From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] alsamixergui cannot build
Date: Fri, 26 Apr 2002 14:41:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2r8l2ws2m.fsf@vador.mandrakesoft.com>
References: <m2vgaewtsf.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vador.mandrakesoft.com (office.mandrakesoft.com [195.68.114.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA22932
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2002 14:36:14 +0200
Received: from vador.mandrakesoft.com (localhost.localdomain [127.0.0.1])
	by vador.mandrakesoft.com (Postfix) with ESMTP id 8EE352689D
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2002 14:41:05 +0200 (CEST)
In-Reply-To: <m2vgaewtsf.fsf@vador.mandrakesoft.com> (Thierry Vignaud's
 message of "Fri, 26 Apr 2002 14:04:00 +0200")
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

alsamixergui won't build withouth these fixes :


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=alsamixergui-0.9.0rc1-fixes.patch

--- src/Fl_Pixmap_Button.H.orig	2002-04-26 14:25:24.000000000 +0200
+++ src/Fl_Pixmap_Button.H	2002-04-26 14:25:17.000000000 +0200
@@ -48,7 +48,7 @@
 #endif
 	
 	if (pw<0) {
-#if FL_MAJOR_VERSION == 1 && FL_MINOR_VERSION == 0
+#if FL_MAJOR_VERSION == 1 && FL_MINOR_VERSION >= 0
 		fl_measure_pixmap(p->data,pw,ph);
 #else
 		fl_measure_pixmap(p->data(),pw,ph);
--- src/Fl_AM.cxx.orig	2002-04-26 14:26:44.000000000 +0200
+++ src/Fl_AM.cxx	2002-04-26 14:26:48.000000000 +0200
@@ -215,7 +215,7 @@
 	Fl::add_timeout(0.05,gui_idle_cb,0);
 	
 #if FL_MAJOR_VERSION == 1 && FL_MINOR_VERSION >= 1
-	Fl::visible_focus(0);
+//	Fl::visible_focus(0);
 #endif
 
 	Fl::run();

--=-=-=


i just packaged both alsamixergui and aconnectgui into mandrake contribs.

-- 
"il a ete brule au 28e degre" (the naheulbeuk witch)
"c curieux, gcc fonctionne" (gwenole)

--=-=-=--
