From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/2] [EXPERIMENTAL] Add support for the latest
 IndigoIOx and IndigoDJx cards
Date: Sun, 1 Feb 2009 23:03:32 +0100
Message-ID: <20090201230332.06894937.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 782F91037F6
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 23:03:29 +0100 (CET)
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
Cc: carmen <_@whats-your.name>
List-Id: alsa-devel@alsa-project.org


This patch adds to alsa-firmware the firmware needed by the IndigoIOx and
IndigoDJx cards. It's too long to post here inline. Please download the
compressed patch at this url:

http://www.webalice.it/g_pochini/alsa-firmware_indigox.patch.bz2

The patch contains two c-coded blobs and the following patch:

diff -duNrp alsa-firmware__orig/echoaudio/Makefile.am alsa-firmware/echoaudio/Makefile.am
--- alsa-firmware__orig/echoaudio/Makefile.am	2008-06-07 22:18:23.000000000 +0200
+++ alsa-firmware/echoaudio/Makefile.am	2009-02-01 22:15:02.000000000 +0100
@@ -26,7 +26,9 @@ firmware_files =	\
 		3g_asic.fw \
 		indigo_dsp.fw \
 		indigo_io_dsp.fw \
-		indigo_dj_dsp.fw
+		indigo_iox_dsp.fw \
+		indigo_dj_dsp.fw \
+		indigo_djx_dsp.fw
 
 noinst_PROGRAMS = fw_writer
 fw_writer_SOURCES = fw_writer.c
@@ -57,7 +59,9 @@ EXTRA_DIST = 	DSP/LoaderDSP.c \
 		ASIC/3G_ASIC.c \
 		DSP/IndigoDSP.c \
 		DSP/IndigoIODSP.c \
+		DSP/IndigoIOxDSP.c \
 		DSP/IndigoDJDSP.c \
+		DSP/IndigoDJxDSP.c \
 		fw_writer.c
 
 CLEANFILES = $(firmware_files) fw_writer
@@ -97,4 +101,6 @@ $(firmware_files): fw_writer
 	./fw_writer ASIC/3G_ASIC.c 3g_asic.fw
 	./fw_writer DSP/IndigoDSP.c indigo_dsp.fw
 	./fw_writer DSP/IndigoIODSP.c indigo_io_dsp.fw
+	./fw_writer DSP/IndigoIOxDSP.c indigo_iox_dsp.fw
 	./fw_writer DSP/IndigoDJDSP.c indigo_dj_dsp.fw
+	./fw_writer DSP/IndigoDJxDSP.c indigo_djx_dsp.fw



--
Giuliano.
