From: andi@lisas.de
Subject: [patch 1/6] sound azt3328: cosmetics, minor updates
Date: Mon, 27 Dec 2010 21:16:43 +0100
Message-ID: <20101227201642.GB28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 39CB8246F0
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:16:43 +0100 (CET)
Content-Disposition: inline; filename=cosmetics
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

ChangeLog:
- correct samples to be POSIX shell compatible
- add logging of jiffies value in _pointer()
- several comments
- cleanup

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: linux-2.6/sound/pci/azt3328.c
===================================================================
--- linux-2.6.orig/sound/pci/azt3328.c	2010-12-27 14:28:57.722851002 -0500
+++ linux-2.6/sound/pci/azt3328.c	2010-12-27 14:29:00.449517668 -0500
@@ -1,6 +1,6 @@
 /*
  *  azt3328.c - driver for Aztech AZF3328 based soundcards (e.g. PCI168).
- *  Copyright (C) 2002, 2005 - 2009 by Andreas Mohr <andi AT lisas.de>
+ *  Copyright (C) 2002, 2005 - 2010 by Andreas Mohr <andi AT lisas.de>
  *
  *  Framework borrowed from Bart Hartgers's als4000.c.
  *  Driver developed on PCI168 AP(W) version (PCI rev. 10, subsystem ID 1801),
@@ -201,14 +201,15 @@ MODULE_SUPPORTED_DEVICE("{{Aztech,AZF332
 
 /* === Debug settings ===
   Further diagnostic functionality than the settings below
-  does not need to be provided, since one can easily write a bash script
+  does not need to be provided, since one can easily write a POSIX shell script
   to dump the card's I/O ports (those listed in lspci -v -v):
-  function dump()
+  dump()
   {
     local descr=$1; local addr=$2; local count=$3
 
     echo "${descr}: ${count} @ ${addr}:"
-    dd if=/dev/port skip=$[${addr}] count=${count} bs=1 2>/dev/null| hexdump -C
+    dd if=/dev/port skip=`printf %d ${addr}` count=${count} bs=1 \
+      2>/dev/null| hexdump -C
   }
   and then use something like
   "dump joy200 0x200 8", "dump mpu388 0x388 4", "dump joy 0xb400 8",
@@ -216,14 +217,14 @@ MODULE_SUPPORTED_DEVICE("{{Aztech,AZF332
   possibly within a "while true; do ... sleep 1; done" loop.
   Tweaking ports could be done using
   VALSTRING="`printf "%02x" $value`"
-  printf "\x""$VALSTRING"|dd of=/dev/port seek=$[${addr}] bs=1 2>/dev/null
+  printf "\x""$VALSTRING"|dd of=/dev/port seek=`printf %d ${addr}` bs=1 \
+    2>/dev/null
 */
 
 #define DEBUG_MISC	0
 #define DEBUG_CALLS	0
 #define DEBUG_MIXER	0
 #define DEBUG_CODEC	0
-#define DEBUG_IO	0
 #define DEBUG_TIMER	0
 #define DEBUG_GAME	0
 #define DEBUG_PM	0
@@ -299,6 +300,7 @@ struct snd_azf3328_codec_data {
 };
 
 enum snd_azf3328_codec_type {
+  /* warning: fixed indices (also used for bitmask checks!) */
   AZF_CODEC_PLAYBACK = 0,
   AZF_CODEC_CAPTURE = 1,
   AZF_CODEC_I2S_OUT = 2,
@@ -362,6 +364,9 @@ MODULE_DEVICE_TABLE(pci, snd_azf3328_ids
 static int
 snd_azf3328_io_reg_setb(unsigned reg, u8 mask, bool do_set)
 {
+	/* Well, strictly spoken, the inb/outb sequence isn't atomic
+	   and would need locking. However we currently don't care
+	   since it potentially complicates matters. */
 	u8 prev = inb(reg), new;
 
 	new = (do_set) ? (prev|mask) : (prev & ~mask);
@@ -1004,7 +1009,8 @@ snd_azf3328_codec_setfmt(struct snd_azf3
 	 * (FIXME: yes, it works, but what exactly am I doing here?? :)
 	 * FIXME: does this have some side effects for full-duplex
 	 * or other dramatic side effects? */
-	if (codec_type == AZF_CODEC_PLAYBACK) /* only do it for playback */
+	/* do it for non-capture codecs only */
+	if (codec_type == AZF_CODEC_PLAYBACK)
 		snd_azf3328_codec_outw(codec, IDX_IO_CODEC_DMA_FLAGS,
 			snd_azf3328_codec_inw(codec, IDX_IO_CODEC_DMA_FLAGS) |
 			DMA_RUN_SOMETHING1 |
@@ -1368,8 +1374,8 @@ snd_azf3328_codec_pointer(struct snd_pcm
 	/* calculate offset */
 	result -= bufptr;
 	frmres = bytes_to_frames( substream->runtime, result);
-	snd_azf3328_dbgcodec("%s @ 0x%8lx, frames %8ld\n",
-				codec->name, result, frmres);
+	snd_azf3328_dbgcodec("%08li %s @ 0x%8lx, frames %8ld\n",
+				jiffies, codec->name, result, frmres);
 	return frmres;
 }
 
@@ -1532,7 +1538,7 @@ snd_azf3328_gameport_cooked_read(struct 
 		}
 	}
 
-	/* trigger next axes sampling, to be evaluated the next time we
+	/* trigger next sampling of axes, to be evaluated the next time we
 	 * enter this function */
 
 	/* for some very, very strange reason we cannot enable
@@ -1966,7 +1972,7 @@ snd_azf3328_timer_start(struct snd_timer
 		snd_azf3328_dbgtimer("delay was too low (%d)!\n", delay);
 		delay = 49; /* minimum time is 49 ticks */
 	}
-	snd_azf3328_dbgtimer("setting timer countdown value %d, add COUNTDOWN|IRQ\n", delay);
+	snd_azf3328_dbgtimer("setting timer countdown value %d\n", delay);
 	delay |= TIMER_COUNTDOWN_ENABLE | TIMER_IRQ_ENABLE;
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_azf3328_ctrl_outl(chip, IDX_IO_TIMER_VALUE, delay);
@@ -2257,7 +2263,7 @@ snd_azf3328_create(struct snd_card *card
 		struct snd_azf3328_codec_data *codec =
 			 &chip->codecs[codec_type];
 
-		/* shutdown codecs to save power */
+		/* shutdown codecs to reduce power / noise */
 			/* have ...ctrl_codec_activity() act properly */
 		codec->running = 1;
 		snd_azf3328_ctrl_codec_activity(chip, codec_type, 0);
@@ -2419,6 +2425,7 @@ snd_azf3328_suspend(struct pci_dev *pci,
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
+	/* same pcm object for playback/capture */
 	snd_pcm_suspend_all(chip->pcm[AZF_CODEC_PLAYBACK]);
 	snd_pcm_suspend_all(chip->pcm[AZF_CODEC_I2S_OUT]);
 

-- 
