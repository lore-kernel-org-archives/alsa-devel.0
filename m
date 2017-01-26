From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] sound: pci: cs46xx: constify snd_pcm_ops structures
Date: Thu, 26 Jan 2017 20:23:29 +0530
Message-ID: <1485442409-2962-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_pcm_ops structures as const as they are either stored in the
ops field of a snd_pcm_substream structure or passed as an argument to the
function snd_pcm_set_ops. The function argument and the ops field 
are of type const, so snd_pcm_ops structures having this property 
can be made const too.

File size before: sound/pci/cs46xx/cs46xx_lib.o
   text	   data	    bss	    dec	    hex	filename
  13669	   1712	      0	  15381	   3c15	sound/pci/cs46xx/cs46xx_lib.o

File size after: sound/pci/cs46xx/cs46xx_lib.o
   text	   data	    bss	    dec	    hex	filename
  14181	   1216	      0	  15397	   3c25	sound/pci/cs46xx/cs46xx_lib.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/cs46xx/cs46xx_lib.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index fde3cd4..5d012f5 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -72,18 +72,18 @@
 static void amp_voyetra(struct snd_cs46xx *chip, int change);
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-static struct snd_pcm_ops snd_cs46xx_playback_rear_ops;
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_rear_ops;
-static struct snd_pcm_ops snd_cs46xx_playback_clfe_ops;
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_clfe_ops;
-static struct snd_pcm_ops snd_cs46xx_playback_iec958_ops;
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_iec958_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_rear_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_rear_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_clfe_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_clfe_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_iec958_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_iec958_ops;
 #endif
 
-static struct snd_pcm_ops snd_cs46xx_playback_ops;
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_ops;
-static struct snd_pcm_ops snd_cs46xx_capture_ops;
-static struct snd_pcm_ops snd_cs46xx_capture_indirect_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_ops;
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_ops;
+static const struct snd_pcm_ops snd_cs46xx_capture_ops;
+static const struct snd_pcm_ops snd_cs46xx_capture_indirect_ops;
 
 static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 					    unsigned short reg,
@@ -1665,7 +1665,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_rear_ops = {
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_rear_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_rear_ops = {
 	.open =			snd_cs46xx_playback_open_rear,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1677,7 +1677,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_indirect_rear_ops = {
 	.ack =			snd_cs46xx_playback_transfer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_playback_clfe_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_clfe_ops = {
 	.open =			snd_cs46xx_playback_open_clfe,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1688,7 +1688,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_clfe_ops = {
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_clfe_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_clfe_ops = {
 	.open =			snd_cs46xx_playback_open_clfe,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1700,7 +1700,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_indirect_clfe_ops = {
 	.ack =			snd_cs46xx_playback_transfer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_playback_iec958_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_iec958_ops = {
 	.open =			snd_cs46xx_playback_open_iec958,
 	.close =		snd_cs46xx_playback_close_iec958,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1711,7 +1711,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_iec958_ops = {
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_iec958_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_iec958_ops = {
 	.open =			snd_cs46xx_playback_open_iec958,
 	.close =		snd_cs46xx_playback_close_iec958,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1725,7 +1725,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_indirect_iec958_ops = {
 
 #endif
 
-static struct snd_pcm_ops snd_cs46xx_playback_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_ops = {
 	.open =			snd_cs46xx_playback_open,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1736,7 +1736,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_ops = {
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_playback_indirect_ops = {
+static const struct snd_pcm_ops snd_cs46xx_playback_indirect_ops = {
 	.open =			snd_cs46xx_playback_open,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1748,7 +1748,7 @@ static struct snd_pcm_ops snd_cs46xx_playback_indirect_ops = {
 	.ack =			snd_cs46xx_playback_transfer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_capture_ops = {
+static const struct snd_pcm_ops snd_cs46xx_capture_ops = {
 	.open =			snd_cs46xx_capture_open,
 	.close =		snd_cs46xx_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1759,7 +1759,7 @@ static struct snd_pcm_ops snd_cs46xx_capture_ops = {
 	.pointer =		snd_cs46xx_capture_direct_pointer,
 };
 
-static struct snd_pcm_ops snd_cs46xx_capture_indirect_ops = {
+static const struct snd_pcm_ops snd_cs46xx_capture_indirect_ops = {
 	.open =			snd_cs46xx_capture_open,
 	.close =		snd_cs46xx_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
-- 
2.7.4
