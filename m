From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-utils: Spelling fixes
Date: Wed, 09 Feb 2011 11:29:21 +0100
Message-ID: <4D526C81.3000105@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070903090009040503050406"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A7EA8103955
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 11:29:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070903090009040503050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While looking into the Debian packaging of alsa-utils, I noticed a few 
patches which fix spelling errors. I'm attaching them here.

If the patches attached are good for just applying, please do so or 
report back if there's anything I can do to get them in upstream.

Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070903090009040503050406
Content-Type: text/x-patch;
 name="aseqnet_manpage_errors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aseqnet_manpage_errors.patch"

From: Jordi Mallach <jordi@debian.org>
Description: Remove an unknown "LO" section from the manpage to avoid
             man errors.
Index: alsa-utils-1.0.21/seq/aseqnet/aseqnet.1
===================================================================
--- alsa-utils-1.0.21.orig/seq/aseqnet/aseqnet.1	2009-08-31 17:13:36.000000000 +0200
+++ alsa-utils-1.0.21/seq/aseqnet/aseqnet.1	2009-09-04 22:19:32.000000000 +0200
@@ -1,5 +1,4 @@
 .TH aseqnet 1 "January 1, 2000"
-.LO 1
 .SH NAME
 aseqnet \- ALSA sequencer connectors over network
 

--------------070903090009040503050406
Content-Type: text/x-patch;
 name="fix_misspelling_speaker-test_man_page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix_misspelling_speaker-test_man_page.patch"

From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Fix typo in speaker-test manpage

Index: alsa-utils-1.0.18/speaker-test/speaker-test.1
===================================================================
--- alsa-utils-1.0.18.orig/speaker-test/speaker-test.1	2009-02-01 16:56:12.000000000 -0500
+++ alsa-utils-1.0.18/speaker-test/speaker-test.1	2009-02-01 16:56:46.000000000 -0500
@@ -51,7 +51,7 @@
 The default value is 0.
 
 .TP
-\fB\-P\fP | \fB\-\-nperiods\fP \fPERIODS\fP
+\fB\-P\fP | \fB\-\-nperiods\fP \fPPERIODS\fP
 Use number of periods.  The default value is 4.
 
 .TP

--------------070903090009040503050406
Content-Type: text/x-patch;
 name="spelling_fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spelling_fixes.patch"

From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Fix typos in aplay.c and aseqnet.c
diff --git a/aplay/aplay.c b/aplay/aplay.c
index c7c82a1..e2122dd 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -203,7 +203,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 			printf(" %s", s);
 	}
 	printf(_("\nSome of these may not be available on selected hardware\n"));
-	printf(_("The availabled format shortcuts are:\n"));
+	printf(_("The available format shortcuts are:\n"));
 	printf(_("-f cd (16 bit little endian, 44100, stereo)\n"));
 	printf(_("-f cdr (16 bit big endian, 44100, stereo)\n"));
 	printf(_("-f dat (16 bit little endian, 48000, stereo)\n"));
diff --git a/seq/aseqnet/aseqnet.c b/seq/aseqnet/aseqnet.c
index e071ad9..70a1cfd 100644
--- a/seq/aseqnet/aseqnet.c
+++ b/seq/aseqnet/aseqnet.c
@@ -167,7 +167,7 @@ static void usage(void)
 	printf(_("  server mode: aseqnet [-options]\n"));
 	printf(_("  client mode: aseqnet [-options] server_host\n"));
 	printf(_("options:\n"));
-	printf(_("  -p,--port # : sepcify TCP port (digit or service name)\n"));
+	printf(_("  -p,--port # : specify TCP port (digit or service name)\n"));
 	printf(_("  -s,--source addr : read from given addr (client:port)\n"));
 	printf(_("  -d,--dest addr : write to given addr (client:port)\n"));
 	printf(_("  -v, --verbose : print verbose messages\n"));

--------------070903090009040503050406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070903090009040503050406--
