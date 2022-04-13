# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "test" {
cidr_block           = "10.0.0.0/16"
instance_tenancy     = "default"
enable_dns_support   = "true"
enable_dns_hostnames = "true"
enable_classiclink   = "false"
tags = {
Name = "test"
}
}
# Creating Public Subnets in VPC
resource "aws_subnet" "test-public-1" {
vpc_id                  = aws_vpc.test.id
cidr_block              = "10.0.1.0/24"
map_public_ip_on_launch = "true"
availability_zone       = "us-west-2a"
tags = {
Name = "test-public"
}
}

# Creating Private Subnets in VPC
resource "aws_subnet" "test-private-1" {
vpc_id                  = aws_vpc.test.id
cidr_block              = "10.0.3.0/24"
map_public_ip_on_launch = "false"
availability_zone       = "us-west-2b"
tags = {
Name = "test-private"
}
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "test-gw" {
vpc_id = aws_vpc.test.id
tags = {
Name = "test"
}
}
# Creating Route Tables for Internet gateway
resource "aws_route_table" "test-public" {
vpc_id = aws_vpc.test.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.test-gw.id
}
tags = {
Name = "test-public"
}
}
# Creating Route Associations public subnets
resource "aws_route_table_association" "test-public-1-a" {
subnet_id      = aws_subnet.test-public-1.id
route_table_id = aws_route_table.test-public.id
}

