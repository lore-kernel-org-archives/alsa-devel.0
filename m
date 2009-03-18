From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/3] Echoaudio: add support for Indigo express
	cards
Date: Thu, 19 Mar 2009 00:09:49 +0100
Message-ID: <20090319000949.39d76a10.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D2B61038D0
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 00:09:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for IndigoIOx and IndigoDJx.
(alsa-driver part)


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-driver-1.0.19__orig/pci/echoaudio/Makefile	2009-01-19 12:17:17.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/Makefile	2009-03-15 17:14:39.000000000 +0100
@@ -11,7 +11,8 @@ include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
 clean-files := echoaudio.c darla20.c darla24.c echo3g.c gina20.c gina24.c \
-		indigo.c indigodj.c indigoio.c layla20.c layla24.c mia.c mona.c
+		indigo.c indigodj.c indigoio.c indigodjx.c indigoiox.c \
+		layla20.c layla24.c mia.c mona.c
 
 include $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/Makefile
 
@@ -26,6 +27,8 @@ gina24.c: gina24.patch $(SND_TOPDIR)/als
 indigo.c: indigo.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigo.c echoaudio.c
 indigodj.c: indigodj.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigodj.c echoaudio.c
 indigoio.c: indigoio.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigoio.c echoaudio.c
+indigodjx.c: indigodjx.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigodjx.c echoaudio.c
+indigoiox.c: indigoiox.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigoiox.c echoaudio.c
 layla20.c: layla20.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/layla20.c echoaudio.c
 layla24.c: layla24.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/layla24.c echoaudio.c
 mia.c: mia.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/mia.c echoaudio.c
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigoiox.patch	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigoiox.patch	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,18 @@
+--- ../../alsa-kernel/pci/echoaudio/indigoiox.c	2009-03-01 15:26:34.000000000 +0100
++++ indigoiox.c	2009-03-01 15:32:56.000000000 +0100
+@@ -1,3 +1,9 @@
++#include "adriver.h"
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
++#define pci_device(chip) pci_name(chip->pci)
++#endif
++
+ /*
+  *  ALSA driver for Echoaudio soundcards.
+  *  Copyright (C) 2009 Giuliano Pochini <pochini@shiny.it>
+@@ -107,3 +113,5 @@ static struct snd_pcm_hardware pcm_hardw
+ #include "echoaudio_dsp.c"
+ #include "echoaudio.c"
+ 
++
++EXPORT_NO_SYMBOLS;
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigodjx.patch	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigodjx.patch	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,18 @@
+--- ../../alsa-kernel/pci/echoaudio/indigodjx.c	2009-03-01 15:26:27.000000000 +0100
++++ indigodjx.c	2009-03-01 19:02:55.000000000 +0100
+@@ -1,3 +1,9 @@
++#include "adriver.h"
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
++#define pci_device(chip) pci_name(chip->pci)
++#endif
++
+ /*
+  *  ALSA driver for Echoaudio soundcards.
+  *  Copyright (C) 2009 Giuliano Pochini <pochini@shiny.it>
+@@ -105,3 +111,5 @@ static struct snd_pcm_hardware pcm_hardw
+ #include "indigo_express_dsp.c"
+ #include "echoaudio_dsp.c"
+ #include "echoaudio.c"
++
++EXPORT_NO_SYMBOLS;
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigo_express_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigo_express_dsp.c	2009-03-15 17:21:56.000000000 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/pci/echoaudio/indigo_express_dsp.c"
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigoiox_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigoiox_dsp.c	2009-03-15 17:19:36.000000000 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/pci/echoaudio/indigoiox_dsp.c"
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigodjx_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigodjx_dsp.c	2009-03-15 17:19:18.000000000 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/pci/echoaudio/indigodjx_dsp.c"



--
Giuliano.
