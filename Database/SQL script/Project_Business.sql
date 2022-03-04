create database Business;
use Business;
create table New_Business_Den (
economy varchar(20) primary key, YR2015 float, YR2016 float, YR2017 float, YR2018 float);

create table Cost (
economy varchar(20) primary key, YR2015 float, YR2016 float, YR2017 float, YR2018 float);

create table time_required (
economy varchar(20) primary key, YR2015 float, YR2016 float, YR2017 float, YR2018 float);

create table Dev_Stage (
country varchar(20) primary key, Seed_Stage float, Startup_Stage float, Growth_Stage float, Later_Stage float, Steady_Stage float, None float, No_Input varchar(20));

create table Common_countries (
select country, Steady_Stage, YR2018 as Cost_18
from Cost
inner join Dev_Stage
On Cost.economy = Dev_Stage.country );
select *
from Common_countries;

create table Analysis_2018 (
select country, Steady_stage, Cost_18, time_required.YR2018 as Time_18, New_Business_Den.YR2018 as Den_18
from Common_countries
inner join time_required
on Common_countries.country = time_required.economy
inner join New_Business_Den
on Common_countries.country = New_Business_Den.economy);

select *
from avg_cost;

select *
from analysis_2018;

# Update Cost table
select * from Cost;
alter table Cost
add column Avg_EU int;

update Cost
set Avg_EU = (Cost.YR2015+Cost.YR2016+Cost.YR2017+Cost.YR2018)/4;
select *
from cost;

select AVG(avg_cost_country)
from cost;

create table Cost_Final (
select economy,
AVG_cost_country,
(AVG_cost_country - (select AVG(avg_cost_country)
from cost)) as cost_dif
from cost
group by economy);

select * 
from Cost_Final;

# Update time_required table

alter table time_required add column AVG_time_Country int as ((time_required.YR2015+time_required.YR2016+time_required.YR2017+time_required.YR2018)/4);

select AVG(avg_time_country)
from time_required;

create table Time_Final (
select economy,
AVG_time_country,
(AVG_time_country - (select AVG(avg_time_country)
from time_required)) as time_dif
from time_required
group by economy);

select * 
from Time_Final;

# update New_Business_Den table

alter table New_Business_Den add column AVG_Den_Country int as ((New_Business_Den.YR2015+New_Business_Den.YR2016+New_Business_Den.YR2017+New_Business_Den.YR2018)/4);

select AVG(avg_Den_country)
from New_Business_Den;

create table Den_Final (
select economy,
AVG_Den_country,
(AVG_Den_country - (select AVG(avg_Den_country)
from New_Business_Den)) as den_dif
from New_Business_Den
group by economy);

select * 
from Den_Final;

# create a joined table with needed information
create table Final_Table (
select Analysis_2018.country, Analysis_2018.Steady_Stage, Den_Final.den_dif, Time_Final.time_dif, Cost_Final.cost_dif
from Analysis_2018
inner join Den_Final
on Analysis_2018.country = Den_Final.economy
inner join Time_Final
on Analysis_2018.country = Time_Final.economy
inner join Cost_Final
on Analysis_2018.country = Cost_Final.economy);

select *
from Final_Table;




# Trial codes____________________________#



select economy, (YR2015+YR2016+YR2017+YR2018)/4 as avg_cost, avg((YR2015+YR2016+YR2017+YR2018)/4) as AVGEU
from Cost
group by economy;

select economy, YR2015, YR2016, YR2017, YR2018, AVG_Cost_Country, Avg_EU as avg_EU from Cost group by economy;

create table avg_year (
alter table Cost add column AVG_Cost_Country int as ((Cost.YR2015+Cost.YR2016+Cost.YR2017+Cost.YR2018)/4));

select * from time_required;
alter table time_required
add column Avg_EU int;

update time_required
set Avg_EU = (time_required.YR2015+time_required.YR2016+time_required.YR2017+time_required.YR2018)/4;
select *
from time_required;