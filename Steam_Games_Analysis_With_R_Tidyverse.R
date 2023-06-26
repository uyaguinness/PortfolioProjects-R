
# Data Analysis with R using tidyverse. 
# Skills used: Data exploration, cleaning, analysis and visualisation

install.packages("tidyverse")
library("tidyverse")
read.csv("steamgames.csv")
data()


# [DATA EXPLORATION]

# Understanding the data in general

dim(steamgames) #total rows and variables
str(steamgames) #structure of the database
summary(steamgames) # summary of values by inter quartile ranges

# Reviewing example inputs in the each variables

glimpse(steamgames)
View(steamgames)
head(steamgames)
tail(steamgames)

# Understanding variables

names(steamgames) # find out name of the variables
length(steamgames) # length of the variables
class(year) # type of variable (i.e integer)
length(year) # number of observations (i.e 63543)



# [DATA CLEANING]: Duplicates, Missing Data & Validation, Data Cleaning

duplicated(steamgames) %>% 
  View() # no duplicates detected in the data

steamgames %>% 
  select(id, year, name, metacritic_rating, reviewer_rating, positivity_ratio, to_beat_main, to_beat_extra, to_beat_completionist, extra_content_length, tags) %>% 
  filter(!complete.cases(.)) %>% 
  View() # checking all missing observations in each variables

steamgames %>% 
  select(year) %>% 
  count(year) %>% 
  arrange(desc(n)) %>% 
  View() # counting total games which released in a year of NA

steamgames %>% 
  select(id, year, name, metacritic_rating, reviewer_rating, positivity_ratio, to_beat_main, to_beat_extra, to_beat_completionist, extra_content_length, tags) %>% 
  filter(!complete.cases(.)) %>% 
  drop_na(year) %>% 
  View() # removing only missing data where year = na

# [DATA ANALYSIS & VISUALISATION]: Calculation and visualisation

steamgames %>% 
  count(year) %>% 
  group_by(year) %>% 
  View() # number of games released per year

steamgames %>% 
  count(reviewer_rating) %>% 
  group_by(reviewer_rating) %>% 
  View() # games rated by reviewers including non-reviewed games

steamgames %>% 
  count(reviewer_rating) %>%
  drop_na(reviewer_rating) %>% 
  group_by(reviewer_rating) %>% 
  View() # games rated by reviewers excluding non-reviewed games

steamgames %>% 
  count(year) %>% 
  group_by(year) %>% 
  boxplot(year) # games launched by per year in box plots

steamgames %>% 
  count(reviewer_rating) %>%
  drop_na(reviewer_rating) %>% 
  group_by(reviewer_rating) %>% 
  plot(c(1:5), c(6:9)) # games rated by reviewers excluding non-reviewed games by plot points
