From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] CONFIG_SND_RTCTIMER
Date: Mon, 26 Aug 2002 16:58:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6A4203.3F5767A0@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


CONFIG_SND_RTCTIMER(_MODULE) is used in timer.c, but never defined.


Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.121
diff -u -r1.121 configure.in
--- configure.in	22 Aug 2002 15:09:45 -0000	1.121
+++ configure.in	26 Aug 2002 13:54:22 -0000
@@ -838,6 +838,7 @@
 CFLAGS="$ac_save_CFLAGS"
 CONFIG_SND_RTCTIMER=$rtcsup
 AC_SUBST(CONFIG_SND_RTCTIMER)
+test "$CONFIG_SND_RTCTIMER" = "m" && AC_DEFINE(CONFIG_SND_RTCTIMER_MODULE)
 CONFIG_RTC=$CONFIG_SND_RTCTIMER
 AC_SUBST(CONFIG_RTC)
 
Index: include/config.h.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/include/config.h.in,v
retrieving revision 1.17
diff -u -r1.17 config.h.in
--- include/config.h.in	21 Jun 2002 12:23:14 -0000	1.17
+++ include/config.h.in	26 Aug 2002 13:54:22 -0000
@@ -23,3 +23,4 @@
 #undef CONFIG_SND_DEBUG_FULL
 #undef CONFIG_SND_DEBUG_DETECT
 #undef CONFIG_SND_BIT32_EMUL_MODULE
+#undef CONFIG_SND_RTCTIMER_MODULE


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
