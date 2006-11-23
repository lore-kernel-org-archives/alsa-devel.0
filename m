From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/3] echoaudio, add TLV support
Date: Thu, 23 Nov 2006 22:45:10 +0100
Message-ID: <20061123224510.488d1b2d.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


This patch adds TLV support to the echoaudio driver (headers).

All gains are in the range -127dB to +6dB with steps of 1dB, and -128 is
mute. VU-meters levels go from -128 to 0dB. The input gain of the Layla20
ranges from -25dB to +25dB in steps of 0.5dB.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-kernel/pci/echoaudio__orig/darla20.c alsa-kernel/pci/echoaudio/darla20.c
--- alsa-kernel/pci/echoaudio__orig/darla20.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/darla20.c	2006-11-19 21:44:15.000000000 +0100
@@ -47,6 +47,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/darla24.c alsa-kernel/pci/echoaudio/darla24.c
--- alsa-kernel/pci/echoaudio__orig/darla24.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/darla24.c	2006-11-19 21:58:17.000000000 +0100
@@ -51,6 +51,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/echo3g.c alsa-kernel/pci/echoaudio/echo3g.c
--- alsa-kernel/pci/echoaudio__orig/echo3g.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/echo3g.c	2006-11-19 22:06:22.000000000 +0100
@@ -58,6 +58,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/gina20.c alsa-kernel/pci/echoaudio/gina20.c
--- alsa-kernel/pci/echoaudio__orig/gina20.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/gina20.c	2006-11-19 21:44:15.000000000 +0100
@@ -51,6 +51,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/gina24.c alsa-kernel/pci/echoaudio/gina24.c
--- alsa-kernel/pci/echoaudio__orig/gina24.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/gina24.c	2006-11-19 21:44:15.000000000 +0100
@@ -57,6 +57,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/indigo.c alsa-kernel/pci/echoaudio/indigo.c
--- alsa-kernel/pci/echoaudio__orig/indigo.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/indigo.c	2006-11-19 21:44:15.000000000 +0100
@@ -49,6 +49,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/indigodj.c alsa-kernel/pci/echoaudio/indigodj.c
--- alsa-kernel/pci/echoaudio__orig/indigodj.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/indigodj.c	2006-11-19 21:44:15.000000000 +0100
@@ -49,6 +49,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/indigoio.c alsa-kernel/pci/echoaudio/indigoio.c
--- alsa-kernel/pci/echoaudio__orig/indigoio.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/indigoio.c	2006-11-19 21:44:15.000000000 +0100
@@ -50,6 +50,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/layla20.c alsa-kernel/pci/echoaudio/layla20.c
--- alsa-kernel/pci/echoaudio__orig/layla20.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/layla20.c	2006-11-19 21:44:15.000000000 +0100
@@ -56,6 +56,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/layla24.c alsa-kernel/pci/echoaudio/layla24.c
--- alsa-kernel/pci/echoaudio__orig/layla24.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/layla24.c	2006-11-19 21:44:15.000000000 +0100
@@ -58,6 +58,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/mia.c alsa-kernel/pci/echoaudio/mia.c
--- alsa-kernel/pci/echoaudio__orig/mia.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/mia.c	2006-11-19 21:44:15.000000000 +0100
@@ -56,6 +56,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
diff -dup alsa-kernel/pci/echoaudio__orig/mona.c alsa-kernel/pci/echoaudio/mona.c
--- alsa-kernel/pci/echoaudio__orig/mona.c	2006-11-19 22:04:09.000000000 +0100
+++ alsa-kernel/pci/echoaudio/mona.c	2006-11-19 21:44:15.000000000 +0100
@@ -55,6 +55,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
