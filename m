From: John Lindgren <john.lindgren@tds.net>
Subject: Problems in snd_device_name_hint
Date: Sat, 24 Oct 2009 18:14:50 -0400
Message-ID: <1256422490.1758.8.camel@dark-knight>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SEsuOuXCp5V9LB2n7wvV"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C22510380A
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Oct 2009 00:14:53 +0200 (CEST)
Received: by gxk20 with SMTP id 20so13093859gxk.12
	for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2009 15:14:53 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org


--=-SEsuOuXCp5V9LB2n7wvV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I haven't frequented the alsa-devel list in the past, but Debian's
maintainer apparently prefers that I go directly to the ALSA developers.
While developing a new ALSA output plugin for Audacious audio player, I
have run into several problems in snd_device_name_hint.  I've already
described the problems in the Debian bug tracker and made up some
patches, which I would like someone to review.  Here are the links:

        http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=549531
        http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=552240

I'm also attaching the patches here.

Peace,
John Lindgren

--=-SEsuOuXCp5V9LB2n7wvV
Content-Disposition: attachment; filename="dlmisc.c.diff"
Content-Type: text/x-patch; name="dlmisc.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- dlmisc.0.c	2009-09-09 08:34:54.000000000 -0400
+++ dlmisc.c	2009-10-24 11:18:51.000000000 -0400
@@ -54,9 +54,13 @@
 #else
 #ifdef HAVE_LIBDL
 	if (name == NULL) {
-		Dl_info dlinfo;
-		if (dladdr(snd_dlopen, &dlinfo) > 0)
-			name = dlinfo.dli_fname;
+		static const char * self = NULL;
+		if (self == NULL) {
+			Dl_info dlinfo;
+			if (dladdr(snd_dlopen, &dlinfo) > 0)
+				self = dlinfo.dli_fname;
+		}
+		name = self;
 	}
 #endif
 #endif

--=-SEsuOuXCp5V9LB2n7wvV
Content-Disposition: attachment; filename="conf.c.diff"
Content-Type: text/x-patch; name="conf.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- conf.0.c	2009-09-09 08:34:54.000000000 -0400
+++ conf.c	2009-10-22 23:51:09.000000000 -0400
@@ -1132,7 +1132,6 @@
 				free(id);
 				continue;
 			}
-			snd_config_delete(n);
 		}
 		if (mode == MERGE) {
 			SNDERR("%s does not exists", id);
@@ -1156,7 +1155,6 @@
 				skip = 1;
 				n = NULL;
 			} else if (mode == OVERRIDE) {
-				snd_config_delete(n);
 				n = NULL;
 			}
 		} else {

--=-SEsuOuXCp5V9LB2n7wvV
Content-Disposition: attachment; filename="namehint.c.diff"
Content-Type: text/x-patch; name="namehint.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- namehint.0.c	2009-09-09 08:34:54.000000000 -0400
+++ namehint.c	2009-10-03 17:39:23.000000000 -0400
@@ -328,7 +328,6 @@
 	if (snd_config_search(cfg1, "slave", &cfg) >= 0 &&
 	    snd_config_search(cfg, base, &cfg1) >= 0)
 	    	goto __hint;
-	snd_config_delete(res);
 	res = NULL;
 	if (strchr(buf, ':') != NULL)
 		goto __ok;
@@ -379,8 +378,6 @@
 	      	err = hint_list_add(list, buf, buf1);
 	}
       __skip_add:
-      	if (res)
-	      	snd_config_delete(res);
 	if (buf1)
 		free(buf1);
       	free(buf);

--=-SEsuOuXCp5V9LB2n7wvV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-SEsuOuXCp5V9LB2n7wvV--
