From: Matthias Andree <matthias.andree@gmx.de>
Subject: PATCH: acore/wrappers.c hosed snprintf
Date: Sun, 13 Jul 2003 14:28:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030713122813.GA13287@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

for some reason, alsa-driver-0.9.5 chose to use its snd_compat_*snprintf
stuff on Linux 2.4.22-pre3-ac1. This triggered bugs in wrappers.c that
break the compile, trivial patch below. Please apply.

--- ./acore/wrappers.c.orig	2003-07-13 13:53:29.000000000 +0200
+++ ./acore/wrappers.c	2003-07-13 13:53:43.000000000 +0200
@@ -58,7 +58,6 @@
 int snd_compat_vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
 	char *ptr = (void *) __get_free_pages(GFP_KERNEL, 0);
-	va_list args;
 	if (ptr == NULL) {	/* should not happen - GFP_KERNEL has wait flag */
 		if (size > 0)
 			buf[0] = 0;
@@ -73,9 +72,10 @@
 int snd_compat_snprintf(char *buf, size_t size, const char * fmt, ...)
 {
 	int res;
+	va_list args;
 
 	va_start(args, fmt);
-	res = snd_compat_vsnprintf(buf, size, args);
+	res = snd_compat_vsnprintf(buf, size, fmt, args);
 	va_end(args);
 	return res;
 }


-- 
Matthias Andree


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
