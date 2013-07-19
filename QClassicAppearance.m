//
// Created by Eduardo Scoz on 7/18/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QClassicAppearance.h"


@implementation QClassicAppearance {

}

- (void)setDefaults {
    [super setDefaults];

    self.labelColorDisabled = [UIColor lightGrayColor];
    self.labelColorEnabled = [UIColor blackColor];

    self.actionColorDisabled = [UIColor lightGrayColor];
    self.actionColorEnabled = [UIColor blackColor];

    self.sectionTitleFont = nil;
    self.sectionTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:1];
    self.sectionTitleColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1.000];

    self.sectionFooterFont = nil;
    self.sectionFooterColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1.000];

    self.labelFont = [UIFont boldSystemFontOfSize:15];
    self.labelAlignment = NSTextAlignmentLeft;

    self.backgroundColorDisabled = [UIColor colorWithWhite:0.9605 alpha:1.0000];
    self.backgroundColorEnabled = [UIColor whiteColor];

    self.entryTextColorDisabled = [UIColor lightGrayColor];
    self.entryTextColorEnabled = [UIColor blackColor];
    self.entryAlignment = NSTextAlignmentLeft;
    self.entryFont = [UIFont systemFontOfSize:15];

    self.buttonAlignment = NSTextAlignmentCenter;

    self.valueColorEnabled = [UIColor colorWithRed:0.1653 green:0.2532 blue:0.4543 alpha:1.0000];
    self.valueColorDisabled = [UIColor lightGrayColor];
    self.valueFont = [UIFont systemFontOfSize:15];
    self.valueAlignment = NSTextAlignmentRight;

    self.toolbarStyle = UIBarStyleBlack;
    self.toolbarTranslucent = YES;
}


- (UIView *)buildHeaderForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index{
    if (self.sectionTitleFont!=nil && tableView.style == UITableViewStyleGrouped){
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        containerView.tag = 98989;
        containerView.backgroundColor = [UIColor clearColor];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-40, [tableView.delegate tableView:tableView heightForHeaderInSection:index])];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.text = section.title;
        [containerView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.sectionTitleFont;
        label.numberOfLines = 0;
        label.shadowColor = self.sectionTitleShadowColor;
        label.shadowOffset = CGSizeMake(0, 1);
        label.textColor = self.sectionTitleColor;
        return containerView;
    }
    return nil;
}



- (UIView *)buildFooterForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    if (self.sectionFooterFont!=nil && tableView.style == UITableViewStyleGrouped){
        CGSize textSize = [section.footer sizeWithFont:self.sectionFooterFont constrainedToSize:CGSizeMake(tableView.frame.size.width-40, 1000000)];
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, textSize.height+8)];
        containerView.tag = 89898;
        containerView.backgroundColor = [UIColor clearColor];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, tableView.frame.size.width-40, textSize.height)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.text = section.footer;
        label.textAlignment = NSTextAlignmentCenter;
        [containerView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.sectionFooterFont;
        label.textColor = self.sectionFooterColor;
        label.numberOfLines = 0;
        label.shadowColor = [UIColor colorWithWhite:1.0 alpha:1];
        label.shadowOffset = CGSizeMake(0, 1);

        section.footerView = containerView;
    }
    return nil;
}

- (CGFloat)heightForHeaderInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {

    if (section.headerView!=nil)
        return section.headerView.frame.size.height;

    if (section.title==nil)
        return 0;

    if (!tableView.root.grouped)  {

        return section.footer == NULL
                ? -1
                : [section.title sizeWithFont:self.sectionTitleFont constrainedToSize:CGSizeMake(tableView.frame.size.width-40, 1000000)].height+22;
    }

    CGFloat stringTitleHeight = 0;

    if (section.title != nil) {
        CGFloat maxWidth = tableView.bounds.size.width - 20;
        CGFloat maxHeight = 9999;
        CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
        QAppearance *appearance = ((QuickDialogTableView *)tableView).root.appearance;
        CGSize expectedLabelSize = [section.title sizeWithFont:appearance==nil? [UIFont systemFontOfSize:[UIFont labelFontSize]] : appearance.sectionTitleFont
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];

        stringTitleHeight = expectedLabelSize.height+23.f;
    }


    return section.title != NULL? stringTitleHeight : 0;
}

- (CGFloat)heightForFooterInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {

    if (section.footerView!=nil)
        return section.footerView.frame.size.height;

    QAppearance *appearance = tableView.root.appearance;

    return section.footer == NULL
            ? -1
            : [section.footer sizeWithFont:appearance.sectionFooterFont constrainedToSize:CGSizeMake(tableView.frame.size.width-40, 1000000)].height+22;
}

- (void)cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)path {

}



@end