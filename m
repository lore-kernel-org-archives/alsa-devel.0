From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] acoonectgui cannot build
Date: Fri, 26 Apr 2002 14:04:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2vgaewtsf.fsf@vador.mandrakesoft.com>
References: <20020426124115.71b29205.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vador.mandrakesoft.com (office.mandrakesoft.com [195.68.114.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA22367
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2002 13:59:13 +0200
Received: from vador.mandrakesoft.com (localhost.localdomain [127.0.0.1])
	by vador.mandrakesoft.com (Postfix) with ESMTP id E62CCECC9
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2002 14:04:00 +0200 (CEST)
In-Reply-To: <20020426124115.71b29205.mdeboer@iua.upf.es> (Maarten de Boer's
 message of "Fri, 26 Apr 2002 12:41:15 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=


aconnectgui won't build withouth these fixes :


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=aconnectgui-0.9.0rc1-fixes.patch

--- src/Fl_PBConnector.H.orig	2002-04-26 13:49:14.000000000 +0200
+++ src/Fl_PBConnector.H	2002-04-26 13:49:16.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef __PBConnector__
 #define __PBConnector__
 
-#include <Fl/Fl_Widget.H>
+#include <FL/Fl_Widget.H>
 #include "Fl_PBConnector_T.H"
 #include "Layout.H"
 
--- src/Fl_PBConnection.H.orig	2002-04-26 13:51:12.000000000 +0200
+++ src/Fl_PBConnection.H	2002-04-26 13:51:20.000000000 +0200
@@ -1,8 +1,8 @@
 #ifndef __PBConnection__
 #define __PBConnection__
 
-#include <Fl/Fl_Widget.H>
-#include <Fl/Fl_Group.H>
+#include <FL/Fl_Widget.H>
+#include <FL/Fl_Group.H>
 
 class Fl_PBConnector;
 
--- src/Fl_PBConnection.cxx.orig	2002-04-26 13:52:00.000000000 +0200
+++ src/Fl_PBConnection.cxx	2002-04-26 13:52:07.000000000 +0200
@@ -2,8 +2,8 @@
 #include "Fl_PBConnector.H"
 #include "Fl_PBWindow.H"
 
-#include <Fl/fl_draw.H>
-#include <Fl/Fl.H>
+#include <FL/fl_draw.H>
+#include <FL/Fl.H>
 
 void Fl_PBConnection::set(Fl_PBConnector* a, Fl_PBConnector* b) 
 {
--- src/Fl_PBConnector.cxx.orig	2002-04-26 13:52:54.000000000 +0200
+++ src/Fl_PBConnector.cxx	2002-04-26 13:53:02.000000000 +0200
@@ -1,7 +1,7 @@
 #include "Fl_PBConnection.H"
 #include "Fl_PBConnector.H"
 
-#include <Fl/fl_draw.H>
+#include <FL/fl_draw.H>
 
 Fl_PBConnector::Fl_PBConnector(int X,int Y,Fl_PBConnector_T T)
 :Fl_Widget(X,Y,8,CONNECTOR_DISTANCE) {
--- src/Fl_FrameGroup.H.orig	2002-04-26 13:54:22.000000000 +0200
+++ src/Fl_FrameGroup.H	2002-04-26 13:55:05.000000000 +0200
@@ -16,7 +16,7 @@
 		fl_draw_box(FL_ENGRAVED_FRAME,x(),y()+5,w(),h()-5,FL_BLACK);
 		fl_color(color());
 		fl_font(labelfont(),labelsize());
-		fl_rectf(x()+10,y(),fl_width(label())+4,10);
+		fl_rectf(x()+10,y(),int(fl_width(label()))+4,10);
 		fl_color(labelcolor());
 		fl_draw(label(),x()+12,y()+10);
 		Fl_Group::draw();
--- src/Fl_PBPort.cxx.orig	2002-04-26 13:55:49.000000000 +0200
+++ src/Fl_PBPort.cxx	2002-04-26 13:55:55.000000000 +0200
@@ -1,6 +1,6 @@
 #include "Fl_PBPort.H"
 #include "Fl_PBConnector.H"
-#include <Fl/Fl_Box.H>
+#include <FL/Fl_Box.H>
 
 Fl_PBPort::Fl_PBPort(int X,int Y,int W,int H,char* L,int P,Fl_PBConnector_T T)
 :Fl_Group(X,Y,W,H)

--=-=-=


(using libfltk1.1-1.1.0)


-- 
"il a ete brule au 28e degre" (the naheulbeuk witch)
"c curieux, gcc fonctionne" (gwenole)

--=-=-=--
