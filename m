From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: [PATCH] fix building alsa-tools with gtk+-2.x
Date: Thu, 04 May 2006 14:23:21 +0200
Message-ID: <m24q06x9l2.fsf@vador2.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2BFC8222
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 14:24:54 +0200 (MEST)
Received: from vador.mandriva.com (unknown [192.168.100.253])
	by office.mandriva.com (Postfix) with ESMTP id 9650954633
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 14:24:53 +0200 (CEST)
Received: from vador2.mandriva.com (vador2.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id 067961BCC1
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 14:23:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

the following patch fixes building with devel packages gtk+-2 devel
files and not gtk+-1.2 devel files (a m4 macro was renamed between
gtk+-1.x and gtk+-2.x):


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
  filename=alsa-tools-1.0.11-gtk-buildfix.patch

--- ./echomixer/configure.in.tv	2006-05-04 12:58:29.000000000 +0200
+++ ./echomixer/configure.in	2006-05-04 12:57:59.000000000 +0200
@@ -15,7 +15,7 @@
 
 else
 
-AM_PATH_GTK(1.2.0)
+AM_PATH_GTK_2_0(1.2.0)
 AM_PATH_ALSA(1.0.0)
 ECHOMIXER_CFLAGS="$CFLAGS $ALSA_CFLAGS $GTK_CFLAGS"
 ECHOMIXER_LIBS="$LIBS $ALSA_LIBS $GTK_LIBS"
--- ./envy24control/configure.in.tv	2006-05-04 12:58:29.000000000 +0200
+++ ./envy24control/configure.in	2006-05-04 12:57:59.000000000 +0200
@@ -14,7 +14,7 @@
 
 else
 
-AM_PATH_GTK(1.0.1)
+AM_PATH_GTK_2_0(1.0.1)
 AM_PATH_ALSA(1.0.0)
 ENVY24CONTROL_CFLAGS="$CFLAGS $ALSA_CFLAGS $GTK_CFLAGS"
 ENVY24CONTROL_LIBS="$LIBS $ALSA_LIBS $GTK_LIBS"
--- ./rmedigicontrol/configure.in.tv	2006-05-04 12:58:29.000000000 +0200
+++ ./rmedigicontrol/configure.in	2006-05-04 12:57:59.000000000 +0200
@@ -14,7 +14,7 @@
 
 else
 
-AM_PATH_GTK(1.0.1)
+AM_PATH_GTK_2_0(1.0.1)
 AM_PATH_ALSA(1.0.0)
 RMEDIGICONTROL_CFLAGS="$CFLAGS $ALSA_CFLAGS $GTK_CFLAGS"
 RMEDIGICONTROL_LIBS="$LIBS $ALSA_LIBS $GTK_LIBS"

--=-=-=--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
