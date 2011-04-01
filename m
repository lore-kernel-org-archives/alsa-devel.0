From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] hdspmixer: fix drawing problems with black
	background
Date: Fri,  1 Apr 2011 12:16:12 +0200
Message-ID: <6a9fbdb6a976e82ef55bbb9e9f20c73afa748287.1301652949.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 75EAF103834
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 12:16:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Blechmann <tim@klingt.org>
List-Id: alsa-devel@alsa-project.org

- use foreground color instead of black
- HDSPMixerSelector: set colors before setting labels
- automated removal of some trailing spaces

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 hdspmixer/src/HDSPMixerAboutText.cxx |    6 ++--
 hdspmixer/src/HDSPMixerIOMixer.cxx   |   10 +++---
 hdspmixer/src/HDSPMixerOutput.cxx    |   56 +++++++++++++++++-----------------
 hdspmixer/src/HDSPMixerSelector.cxx  |   20 ++++++------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerAboutText.cxx b/hdspmixer/src/HDSPMixerAboutText.cxx
index c8c9b1a..26a5bbc 100644
--- a/hdspmixer/src/HDSPMixerAboutText.cxx
+++ b/hdspmixer/src/HDSPMixerAboutText.cxx
@@ -1,11 +1,11 @@
 /*
  *   HDSPMixer
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
  *
  *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
  *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -48,7 +48,7 @@ HDSPMixerAboutText::HDSPMixerAboutText(int x, int y, int w, int h):Fl_Widget(x,
 
 void HDSPMixerAboutText::draw()
 {
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw(text, x(), y(), w(), h(), FL_ALIGN_LEFT);
 }
diff --git a/hdspmixer/src/HDSPMixerIOMixer.cxx b/hdspmixer/src/HDSPMixerIOMixer.cxx
index 987be41..b5c293b 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.cxx
+++ b/hdspmixer/src/HDSPMixerIOMixer.cxx
@@ -1,8 +1,8 @@
 /*
  *   HDSPMixer
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -54,7 +54,7 @@ HDSPMixerIOMixer::HDSPMixerIOMixer(int x, int y, int w, int h, int ch, int type)
     end();
 }
 
-void HDSPMixerIOMixer::draw_background() 
+void HDSPMixerIOMixer::draw_background()
 {
     draw_background(x(), y(), w(), h());
 }
@@ -71,7 +71,7 @@ void HDSPMixerIOMixer::draw()
     Fl_Widget *const* a = array();
     if (damage() & ~FL_DAMAGE_CHILD) {
 	draw_background();
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 8);
 	fl_draw(channel_name.str().c_str(), x()+4, y()+225, 27, 9, FL_ALIGN_CENTER);
 	for (int i=children(); i--;) {
@@ -83,7 +83,7 @@ void HDSPMixerIOMixer::draw()
     }
 }
 
-void HDSPMixerIOMixer::update_child(Fl_Widget& widget) 
+void HDSPMixerIOMixer::update_child(Fl_Widget& widget)
 {
     if (widget.damage() && widget.visible() && widget.type() < FL_WINDOW && fl_not_clipped(widget.x(), widget.y(), widget.w(), widget.h())) {
 	if ((HDSPMixerMeter*)&widget == meter) {
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 5047825..f30d8c6 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -1,8 +1,8 @@
 /*
  *   HDSPMixer
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -23,25 +23,25 @@
 
 static char const *labels_madi_ss[64] = {
    "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
-   "9", "10", "11", "12", "13", "14", "15", "16", 
-  "17", "18", "19", "20", "21", "22", "23", "24", 
-  "25", "26", "27", "28", "29", "30", "31", "32", 
-  "33", "34", "35", "36", "37", "38", "39", "40", 
-  "41", "42", "43", "44", "45", "46", "47", "48", 
-  "49", "50", "51", "52", "53", "54", "55", "56", 
+   "9", "10", "11", "12", "13", "14", "15", "16",
+  "17", "18", "19", "20", "21", "22", "23", "24",
+  "25", "26", "27", "28", "29", "30", "31", "32",
+  "33", "34", "35", "36", "37", "38", "39", "40",
+  "41", "42", "43", "44", "45", "46", "47", "48",
+  "49", "50", "51", "52", "53", "54", "55", "56",
   "57", "58", "59", "60", "61", "62", "63", "64"
 };
 
 static char const *labels_madi_ds[64] = {
    "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
-   "9", "10", "11", "12", "13", "14", "15", "16", 
-  "17", "18", "19", "20", "21", "22", "23", "24", 
-  "25", "26", "27", "28", "29", "30", "31", "32", 
+   "9", "10", "11", "12", "13", "14", "15", "16",
+  "17", "18", "19", "20", "21", "22", "23", "24",
+  "25", "26", "27", "28", "29", "30", "31", "32",
 };
 
 static char const *labels_madi_qs[16] = {
    "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
-   "9", "10", "11", "12", "13", "14", "15", "16", 
+   "9", "10", "11", "12", "13", "14", "15", "16",
 };
 
 
@@ -96,14 +96,14 @@ static char const *labels_aio_ss_playback[16] = {
 };
 
 static char const *labels_aio_ds_input[10] = {
-  "AN 1",  "AN 2",  
+  "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2", "A 3", "A 4"
 };
 
 static char const *labels_aio_ds_playback[12] = {
-  "AN 1",  "AN 2",  
+  "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2", "A 3", "A 4",
@@ -204,22 +204,22 @@ void HDSPMixerOutput::setLabels()
                 break;
             case 1:
                 labels_input = labels_playback = labels_9632_ds;
-                break;	
+                break;
             case 2:
                 labels_input = labels_playback = labels_9632_qs;
                 break;
         }
         return;
     }
-    
+
     if (type == Multiface) {
         if (sm)
             labels_input = labels_playback = labels_mf_ds;
-        else 
+        else
             labels_input = labels_playback = labels_mf_ss;
         return;
     };
-    
+
     if (type == Digiface || type == H9652) {
         if (sm)
             labels_input = labels_playback = labels_df_ds;
@@ -227,8 +227,8 @@ void HDSPMixerOutput::setLabels()
             labels_input = labels_playback = labels_df_ss;
         return;
     }
-    
-    
+
+
     if (HDSPeMADI == type) {
         switch (sm) {
             case 0:
@@ -236,7 +236,7 @@ void HDSPMixerOutput::setLabels()
                 break;
             case 1:
                 labels_input = labels_playback = labels_madi_ds;
-                break;	
+                break;
             case 2:
                 labels_input = labels_playback = labels_madi_qs;
                 break;
@@ -248,7 +248,7 @@ void HDSPMixerOutput::setLabels()
         labels_input = labels_playback = labels_aes32;
         return;
     }
-    
+
     if (HDSPeAIO == type) {
         switch (sm) {
             case 0:
@@ -258,7 +258,7 @@ void HDSPMixerOutput::setLabels()
             case 1:
                 labels_input = labels_aio_ds_input;
                 labels_playback = labels_aio_ds_playback;
-                break;	
+                break;
             case 2:
                 labels_input = labels_aio_qs_input;
                 labels_playback = labels_aio_ds_playback;
@@ -266,7 +266,7 @@ void HDSPMixerOutput::setLabels()
         }
         return;
     }
-    
+
     if (HDSPeRayDAT == type) {
         switch (sm) {
             case 0:
@@ -274,14 +274,14 @@ void HDSPMixerOutput::setLabels()
                 break;
             case 1:
                 labels_input = labels_playback = labels_raydat_ds;
-                break;	
+                break;
             case 2:
                 labels_input = labels_playback = labels_raydat_qs;
                 break;
         }
         return;
     }
-    
+
     fprintf(stderr, "Unknown card type for output labels, assigning defaults\n");
     labels_input = labels_playback = labels_madi_ss;
 }
@@ -295,7 +295,7 @@ void HDSPMixerOutput::draw_background(int xpos, int ypos, int w, int h)
 {
     fl_push_clip(xpos, ypos, w, h);
     fl_draw_pixmap(p_output_xpm, x(), y());
-    fl_pop_clip();    
+    fl_pop_clip();
 }
 
 void HDSPMixerOutput::draw()
@@ -303,7 +303,7 @@ void HDSPMixerOutput::draw()
     Fl_Widget*const* a = array();
     if (damage() & ~FL_DAMAGE_CHILD) {
 	draw_background();
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 8);
 	fl_draw(labels_playback[out_num], x()+4, y()+193, 27, 9, FL_ALIGN_CENTER);
 	for (int i=children(); i--;) {
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index 098658f..12f186f 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -1,8 +1,8 @@
 /*
  *   HDSPMixer
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
  *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
  *
@@ -90,7 +90,7 @@ static char const *destinations_aio_ss[8] = {
 };
 
 static char const *destinations_aio_ds[6] = {
-  "AN 1+2", 
+  "AN 1+2",
   "AES",
   "SPDIF",
   "A 1+2", "A 3+4",
@@ -152,11 +152,11 @@ static char const *destinations_h9632_ss[8] = {
 
 static char const *destinations_h9632_ds[6] = {
   "A 1+2", "A 3+4",
-  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
+  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"
 };
 
 static char const *destinations_h9632_qs[4] = {
-  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
+  "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"
 };
 
 HDSPMixerSelector::HDSPMixerSelector(int x, int y, int w, int h):Fl_Menu_(x, y, w, h)
@@ -164,10 +164,10 @@ HDSPMixerSelector::HDSPMixerSelector(int x, int y, int w, int h):Fl_Menu_(x, y,
     max_dest = 0;
     selected = 0;
     basew = (HDSPMixerWindow *)window();
-    setLabels();
     textfont(FL_HELVETICA);
     textsize(8);
-    textcolor(FL_BLACK);
+    textcolor(FL_FOREGROUND_COLOR);
+    setLabels();
 }
 
 void HDSPMixerSelector::draw() {
@@ -186,7 +186,7 @@ int HDSPMixerSelector::handle(int e) {
 		} else {
 		    mode(i, FL_MENU_TOGGLE);
 		}
-	    }    
+	    }
 	    if ((item = (menu()->popup(x(), y()+h(), 0, 0, this))) != NULL) {
 		value(item);
 		selected = value();
@@ -338,10 +338,10 @@ void HDSPMixerSelector::setLabels()
 	  destinations = destinations_raydat_qs;
 	  break;
 	}
-     
+
     }
 
-    
+
     for (int i = 0; i < max_dest; ++i) {
 	add(destinations[i], 0, 0, 0, FL_MENU_TOGGLE);
     }
-- 
1.7.4.1
