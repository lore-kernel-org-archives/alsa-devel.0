From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] hdspconf: more string constant fixes
Date: Sun, 27 Mar 2011 13:50:34 +0200
Message-ID: <a02140a66c87c5b74ab7b242006db632e93a2527.1301226622.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Tim Blechmann <tim@klingt.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 hdspconf/pixmaps/alsalogo.xpm   |    2 +-
 hdspconf/pixmaps/lad_banner.xpm |    2 +-
 hdspconf/pixmaps/rme.xpm        |    2 +-
 hdspconf/src/HC_PrefSyncRef.h   |    6 +++---
 hdspconf/src/HC_XpmRenderer.cxx |    6 +++---
 hdspconf/src/HC_XpmRenderer.h   |    8 ++++----
 hdspconf/src/pixmaps.h          |   10 +++++-----
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hdspconf/pixmaps/alsalogo.xpm b/hdspconf/pixmaps/alsalogo.xpm
index b32c32d..cd22dd2 100644
--- a/hdspconf/pixmaps/alsalogo.xpm
+++ b/hdspconf/pixmaps/alsalogo.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * alsalogo_xpm[] = {
+const char * alsalogo_xpm[] = {
 "50 50 398 2",
 "  	c None",
 ". 	c #C0C0C0",
diff --git a/hdspconf/pixmaps/lad_banner.xpm b/hdspconf/pixmaps/lad_banner.xpm
index 8bb8545..11d4357 100644
--- a/hdspconf/pixmaps/lad_banner.xpm
+++ b/hdspconf/pixmaps/lad_banner.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * lad_banner_xpm[] = {
+const char * lad_banner_xpm[] = {
 "113 39 1833 2",
 "  	c None",
 ". 	c #C0C0C0",
diff --git a/hdspconf/pixmaps/rme.xpm b/hdspconf/pixmaps/rme.xpm
index a892603..b94fa7e 100644
--- a/hdspconf/pixmaps/rme.xpm
+++ b/hdspconf/pixmaps/rme.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * rme_xpm[] = {
+const char * rme_xpm[] = {
 "113 35 2300 2",
 "  	c None",
 ". 	c #030505",
diff --git a/hdspconf/src/HC_PrefSyncRef.h b/hdspconf/src/HC_PrefSyncRef.h
index 5ef8875..8c3a71f 100644
--- a/hdspconf/src/HC_PrefSyncRef.h
+++ b/hdspconf/src/HC_PrefSyncRef.h
@@ -1,8 +1,8 @@
 /*
  *   HDSPConf
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -42,7 +42,7 @@ public:
     Fl_Round_Button *adat_sync;
     void setRef(int r);
 private:
-    char *adat_name;
+    const char *adat_name;
 };
 
 #endif
diff --git a/hdspconf/src/HC_XpmRenderer.cxx b/hdspconf/src/HC_XpmRenderer.cxx
index 72742f8..ed66d4d 100644
--- a/hdspconf/src/HC_XpmRenderer.cxx
+++ b/hdspconf/src/HC_XpmRenderer.cxx
@@ -1,8 +1,8 @@
 /*
  *   HDSPConf
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -21,7 +21,7 @@
 #pragma implementation
 #include "HC_XpmRenderer.h"
 
-HC_XpmRenderer::HC_XpmRenderer(int x, int y, int w, int h, char * const *xpm):Fl_Widget(x, y, w, h)
+HC_XpmRenderer::HC_XpmRenderer(int x, int y, int w, int h, const char * const *xpm):Fl_Widget(x, y, w, h)
 {
     pixmap = xpm;
 }
diff --git a/hdspconf/src/HC_XpmRenderer.h b/hdspconf/src/HC_XpmRenderer.h
index 3c6f768..1e18541 100644
--- a/hdspconf/src/HC_XpmRenderer.h
+++ b/hdspconf/src/HC_XpmRenderer.h
@@ -1,8 +1,8 @@
 /*
  *   HDSPConf
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -30,10 +30,10 @@
 class HC_XpmRenderer:public Fl_Widget
 {
 public:
-    HC_XpmRenderer(int x, int y, int w, int h, char * const *xpm);
+    HC_XpmRenderer(int x, int y, int w, int h, const char * const *xpm);
     void draw();
 private:
-    char * const *pixmap;
+    const char * const *pixmap;
 };
 
 #endif
diff --git a/hdspconf/src/pixmaps.h b/hdspconf/src/pixmaps.h
index c193ed2..4c5aa65 100644
--- a/hdspconf/src/pixmaps.h
+++ b/hdspconf/src/pixmaps.h
@@ -1,8 +1,8 @@
 /*
  *   HDSPConf
- *    
+ *
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -21,9 +21,9 @@
 #ifndef pixmaps_H
 #define pixmaps_H
 
-extern char * rme_xpm[];
-extern char * alsalogo_xpm[];
-extern char * lad_banner_xpm[];
+extern const char * rme_xpm[];
+extern const char * alsalogo_xpm[];
+extern const char * lad_banner_xpm[];
 
 #endif
 
-- 
1.7.1
