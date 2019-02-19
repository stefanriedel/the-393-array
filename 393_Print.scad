//Spherical loudspeaker array, Design for a 3D Print


//define resolution
$fn=50;

//define outer radius of array
o_radius=120;

//define wall thickness
wall=10;

i_radius=o_radius-wall;
a=3*o_radius;
s_radius=60.5/2;
nl8_radius=33/2;
h_zyl=wall*2;
n=15;

alpha=22.5;
b1=sin(alpha)*o_radius;
b2=cos(alpha)*o_radius;
b3=cos(alpha)*i_radius;
//echo(b2);

beta=67.5;
c1=sin(beta)*o_radius;
c2=cos(beta)*o_radius;

gamma=45;
g1=sin(gamma)*o_radius;
g2=cos(gamma)*o_radius;


module empty_sphere(o_r=o_radius,i_r=i_radius){
    difference(){
        sphere(o_r);
        sphere(i_r);
    }
}


module speaker(){
    translate([o_radius-wall,0,0]) rotate([0,-90,0]) cylinder(h=h_zyl,r=s_radius,center=true);
    translate([o_radius-(35/2)-10,0,0]) rotate([0,-90,0]) cylinder(h=35,r=38/2,center=true);
    translate([o_radius-7,0,0]) rotate([0,-90,0]) cube([64,64,3.5],center=true);

}

module mounter(){
    translate([o_radius+wall*1.1,0,0]) rotate([0,-90,0]) cube([65.5,65.5,40],center=true);
    translate([o_radius-wall*2,0,0]) rotate([0,-90,0]) cube([65,65,10],center=true);
}

module mounting_holes(){
    rotate([45,0,0]) translate([o_radius,0,0]) rotate([0,-90,0]) mounting_holes_(4,72/2,3);
}

module nl8_holes(){
    translate([o_radius-wall,0,0]) rotate([0,-90,0]) cylinder(h=h_zyl,r=nl8_radius,center=true);
    rotate([45,0,0]) translate([o_radius-wall,0,0]) rotate([0,-90,0]) mounting_holes_(4,20.65,3);
    translate([o_radius+wall/2-1,0,0]) rotate([0,-90,0]) cube([39,39,20],center=true);
    translate([o_radius-wall*2,0,0]) rotate([0,-90,0]) cube([39,39,20],center=true);
}

module speaker_sphere(){
    difference(){
        empty_sphere();
        //horizon
        rotate([0,0,0]) speaker();
        rotate([0,0,40]) speaker();
        rotate([0,0,80]) speaker();
        rotate([0,0,120]) speaker();
        rotate([0,0,160]) speaker();
        rotate([0,0,200]) speaker();
        rotate([0,0,240]) speaker();
        rotate([0,0,280]) speaker();
        rotate([0,0,320]) speaker();
        //elevation +45 degrees
        rotate([0,-45,20]) speaker();
        rotate([0,-45,140]) speaker();
        rotate([0,-45,260]) speaker();
        //elevation -45 degrees
        rotate([0,45,80]) speaker();
        rotate([0,45,200]) speaker();
        rotate([0,45,320]) speaker();  
    
        //horizon
        rotate([0,0,0]) mounter();
        rotate([0,0,40]) mounter();
        rotate([0,0,80]) mounter();
        rotate([0,0,120]) mounter();
        rotate([0,0,160]) mounter();
        rotate([0,0,200]) mounter();
        rotate([0,0,240]) mounter();
        rotate([0,0,280]) mounter();
        rotate([0,0,320]) mounter();
        //elevation +45 degrees
        rotate([0,-45,20]) mounter();
        rotate([0,-45,140]) mounter();
        rotate([0,-45,260]) mounter();
        //elevation -45 degrees
        rotate([0,45,80])  mounter();
        rotate([0,45,200]) mounter();
        rotate([0,45,320]) mounter();  
        
        //horizon
        rotate([0,0,0]) mounting_holes();
        rotate([0,0,40]) mounting_holes();
        rotate([0,0,80]) mounting_holes();
        rotate([0,0,120]) mounting_holes();
        rotate([0,0,160]) mounting_holes();
        rotate([0,0,200]) mounting_holes();
        rotate([0,0,240]) mounting_holes();
        rotate([0,0,280]) mounting_holes();
        rotate([0,0,320]) mounting_holes();
        //elevation +45 degrees
        rotate([0,-45,20]) mounting_holes();
        rotate([0,-45,140]) mounting_holes();
        rotate([0,-45,260]) mounting_holes();
        //elevation -45 degrees
        rotate([0,45,80])  mounting_holes();
        rotate([0,45,200]) mounting_holes();
        rotate([0,45,320]) mounting_holes();
      
        //nl8 holes
        //elevation -45 degrees
        rotate([0,40,4])  nl8_holes();
        rotate([0,40,36])  nl8_holes();

        rotate([0,40,124]) nl8_holes();  
        rotate([0,40,156]) nl8_holes();       
       
        //top mounting holes
        //rotate([0,0,20]) top_mounting_holes(); 
    }
}

module speaker_sphere_bottom(){
    difference(){
        union(){
            difference(){
                speaker_sphere();
                translate([0,0,-o_radius+14]) translate([0,0,-10]) cube([a,a,20],center=true);
            }
            translate([0,0,-o_radius+14]) translate([0,0,5]) cube([a,a,10],center=true);
        }
        empty_sphere(o_radius+200,o_radius); 
        rotate([0,45,80])  mounter();
        rotate([0,45,200]) mounter();
        rotate([0,45,320]) mounter();
        rotate([0,45,80])  mounting_holes();
        rotate([0,45,200]) mounting_holes();
        rotate([0,45,320]) mounting_holes();  
        rotate([0,45,80]) speaker();
        rotate([0,45,200]) speaker();
        rotate([0,45,320]) speaker();
        
        translate([0,0,-o_radius]) rotate([0,0,-10]) flange_mounting_holes();
    }
}


module cutter(){
    cube(a,center=true);
}

module flange_mounting_holes(){
    mounting_holes_(4,80/2,7);
    cylinder(h=80,r=25,center=true);
}
 
module regular_polygon(order, r=1){
    angles=[ for (i = [0:order-1]) i*(360/order) ];
    coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
    polygon(coords);
}
 
module nut(d=6,h=3.1){
    linear_extrude(height = h, center = true, convexity = 10){
        regular_polygon(6,d/2);
    }
    
}
 
module top_mounting_holes(){
    translate([0,0,b1+30]) mounting_holes_(9,b2-2,8);
    translate([0,0,b1]) mounting_holes_(9,b2-2,3);
}
 
 module mounting_holes_(order=4,r=10,m=3){
    angles=[ for (i = [0:order-1]) i*(360/order) ];
 	coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
        
    for (i =[0:order-1]){
        //d=5 fuer M3, d=6 fuer M4 Nietmuttern
        translate(coords[i]) cylinder(h=80,d=m,center=true);
    }
 }
 
 module top_part(){
     difference(){
        rotate([0,0,0]) speaker_sphere_bottom();
        translate([0,0,-a/2+b1]) cutter();
        rotate([0,0,-20]) m3_cyl();
        rotate([0,0,-60]) m3_cyl();
        rotate([0,0,-140]) m3_cyl();
        rotate([0,0,-180]) m3_cyl();
        rotate([0,0,-260]) m3_cyl();
        rotate([0,0,-300]) m3_cyl();

        rotate([0,0,-20]) m6_cyl();
        rotate([0,0,-60]) m6_cyl();
        rotate([0,0,-140]) m6_cyl();
        rotate([0,0,-180]) m6_cyl();
        rotate([0,0,-260]) m6_cyl();
        rotate([0,0,-300]) m6_cyl();
     }
 }
 
  module bottom_part(){
     difference(){
        union(){
        rotate([0,0,0]) speaker_sphere_bottom();
        rotate([0,0,-20]) nut_mount_cyl();
        rotate([0,0,-60]) nut_mount_cyl();
        rotate([0,0,-140]) nut_mount_cyl();
        rotate([0,0,-180]) nut_mount_cyl();
        rotate([0,0,-260]) nut_mount_cyl();
        rotate([0,0,-300]) nut_mount_cyl();
        }
        translate([0,0,a/2+b1]) cutter();
        rotate([0,0,-20]) nut_mount_cuts();
        rotate([0,0,-60]) nut_mount_cuts();
        rotate([0,0,-140]) nut_mount_cuts();
        rotate([0,0,-180]) nut_mount_cuts();
        rotate([0,0,-260]) nut_mount_cuts();
        rotate([0,0,-300]) nut_mount_cuts();       
     }
 }
 
 module nut_mount_cyl(){    
    translate([b3,0,b1]) cylinder(h=20,d=wall*2-4,center=true);       
}
 module nut_mount_cuts(){
        translate([b3,0,b1-1.5]) nut();
        translate([b3,0,b1]) cylinder(h=40,d=3,center=true);
 }
 
 module m3_cyl(){
    translate([b3,0,b1]) cylinder(h=80,d=3,center=true);       
 }
 
 module m6_cyl(){
    translate([b3,0,b1+48]) cylinder(h=80,d=8,center=true);       
 }
 
//mutter();
//master();
//
 
translate([0,0,20]) top_part();

//rotate([0,180,0]) 
 bottom_part();
 //top_mounting_holes();
 //mounting_holes();
//flansch();
///rotate([0,0,10]) speaker_sphere_bottom();
//translate([0,0,-o_radius]) flansch_bohr();
//bottom_segment_center();
//elevation();
//rotate([0,0,0]) elev_segment();
