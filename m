From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 3/3] echoaudio, add TLV support
Date: Wed, 22 Nov 2006 23:23:10 +0100
Message-ID: <20061122232310.3846d620.pochini@shiny.it>
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
List-Id: alsa-devel@alsa-project.org


This patch adds TLV support to the echoaudio driver (patchers).


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver/pci/echoaudio__orig/darla20.patch alsa-driver/pci/echoaudio/darla20.patch
--- alsa-driver/pci/echoaudio__orig/darla20.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/darla20.patch	2006-11-19 22:19:06.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -97,3 +104,5 @@
+@@ -98,3 +105,5 @@
  #include "darla20_dsp.c"
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
diff -dup alsa-driver/pci/echoaudio__orig/darla24.patch alsa-driver/pci/echoaudio/darla24.patch
--- alsa-driver/pci/echoaudio__orig/darla24.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/darla24.patch	2006-11-19 22:19:21.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -104,3 +111,5 @@
+@@ -105,3 +112,5 @@
  #include "darla24_dsp.c"
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
diff -dup alsa-driver/pci/echoaudio__orig/echo3g.patch alsa-driver/pci/echoaudio/echo3g.patch
--- alsa-driver/pci/echoaudio__orig/echo3g.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/echo3g.patch	2006-11-19 22:19:34.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -116,3 +123,5 @@
+@@ -117,3 +124,5 @@
  #include "echoaudio_3g.c"
  #include "echoaudio.c"
  #include "midi.c"
diff -dup alsa-driver/pci/echoaudio__orig/echoaudio.patch alsa-driver/pci/echoaudio/echoaudio.patch
--- alsa-driver/pci/echoaudio__orig/echoaudio.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/echoaudio.patch	2006-11-19 22:38:34.000000000 +0100
@@ -1,6 +1,6 @@
 --- ../../alsa-kernel/pci/echoaudio/echoaudio.c	2006-08-05 14:41:12.000000000 +0200
 +++ echoaudio.c	2006-10-07 20:30:53.000000000 +0200
-@@ -1911,6 +1911,7 @@
+@@ -1926,6 +1926,7 @@
  	struct echoaudio *chip;
  	int err;
  	size_t sz;
@@ -8,7 +8,7 @@
  	static struct snd_device_ops ops = {
  		.dev_free = snd_echo_dev_free,
  	};
-@@ -1973,7 +1974,12 @@
+@@ -1988,7 +1989,12 @@
  	chip->comm_page_phys = chip->commpage_dma_buf.addr;
  	chip->comm_page = (struct comm_page *)chip->commpage_dma_buf.area;
  
diff -dup alsa-driver/pci/echoaudio__orig/gina20.patch alsa-driver/pci/echoaudio/gina20.patch
--- alsa-driver/pci/echoaudio__orig/gina20.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/gina20.patch	2006-11-19 22:19:54.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -101,3 +108,5 @@
+@@ -102,3 +109,5 @@
  #include "gina20_dsp.c"
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
diff -dup alsa-driver/pci/echoaudio__orig/gina24.patch alsa-driver/pci/echoaudio/gina24.patch
--- alsa-driver/pci/echoaudio__orig/gina24.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/gina24.patch	2006-11-19 22:25:03.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -121,3 +128,5 @@
+@@ -122,3 +129,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio_gml.c"
  #include "echoaudio.c"
diff -dup alsa-driver/pci/echoaudio__orig/indigo.patch alsa-driver/pci/echoaudio/indigo.patch
--- alsa-driver/pci/echoaudio__orig/indigo.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/indigo.patch	2006-11-19 22:20:25.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -102,3 +109,5 @@
+@@ -103,3 +110,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
  
diff -dup alsa-driver/pci/echoaudio__orig/indigodj.patch alsa-driver/pci/echoaudio/indigodj.patch
--- alsa-driver/pci/echoaudio__orig/indigodj.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/indigodj.patch	2006-11-19 22:20:34.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -102,3 +109,5 @@
+@@ -103,3 +110,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
  
diff -dup alsa-driver/pci/echoaudio__orig/indigoio.patch alsa-driver/pci/echoaudio/indigoio.patch
--- alsa-driver/pci/echoaudio__orig/indigoio.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/indigoio.patch	2006-11-19 22:20:44.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -103,3 +110,5 @@
+@@ -104,3 +111,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
  
diff -dup alsa-driver/pci/echoaudio__orig/layla20.patch alsa-driver/pci/echoaudio/layla20.patch
--- alsa-driver/pci/echoaudio__orig/layla20.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/layla20.patch	2006-11-19 22:20:53.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -110,3 +117,5 @@
+@@ -111,3 +118,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
  #include "midi.c"
diff -dup alsa-driver/pci/echoaudio__orig/layla24.patch alsa-driver/pci/echoaudio/layla24.patch
--- alsa-driver/pci/echoaudio__orig/layla24.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/layla24.patch	2006-11-19 22:21:03.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -119,3 +126,5 @@
+@@ -120,3 +127,5 @@
  #include "echoaudio_gml.c"
  #include "echoaudio.c"
  #include "midi.c"
diff -dup alsa-driver/pci/echoaudio__orig/mia.patch alsa-driver/pci/echoaudio/mia.patch
--- alsa-driver/pci/echoaudio__orig/mia.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/mia.patch	2006-11-19 22:21:14.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -115,3 +122,5 @@
+@@ -116,3 +123,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio.c"
  #include "midi.c"
diff -dup alsa-driver/pci/echoaudio__orig/mona.patch alsa-driver/pci/echoaudio/mona.patch
--- alsa-driver/pci/echoaudio__orig/mona.patch	2006-11-19 22:39:27.000000000 +0100
+++ alsa-driver/pci/echoaudio/mona.patch	2006-11-19 22:21:23.000000000 +0100
@@ -11,7 +11,7 @@
  /*
   *  ALSA driver for Echoaudio soundcards.
   *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
-@@ -127,3 +134,5 @@
+@@ -128,3 +135,5 @@
  #include "echoaudio_dsp.c"
  #include "echoaudio_gml.c"
  #include "echoaudio.c"


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
