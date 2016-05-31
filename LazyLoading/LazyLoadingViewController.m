//
//  ViewController.m
//  LazyLoading
//
//  Created by Gowri Sammandhamoorthy on 5/30/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import "LazyLoadingViewController.h"
#import "UIImageView+WebCache.h"
#import "CustomTableViewCell.h"

@interface LazyLoadingViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LazyLoadingViewController{
    NSArray* dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:@"http://www.splashbase.co/api/v1/images/latest"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    dataArray = dic[@"images"];
}

#pragma mark - TableView Delegate methods.

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    

    [cell.imgVw sd_setImageWithURL:dataArray[indexPath.row][@"url"] placeholderImage:[UIImage imageNamed:@"Placeholder_image.png"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 250.0f;
}

- (IBAction)exitButton:(id)sender {
    exit(0);
}
@end
