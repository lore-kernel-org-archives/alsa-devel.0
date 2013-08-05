From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH] rme96 synchronization support
Date: Mon, 05 Aug 2013 14:36:37 +0200
Message-ID: <51FF9C55.80701@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070404080708070607050309"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A0452615E7
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 14:36:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070404080708070607050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody!

As I need support for synchronized pcm streams on an
RME Digi96/8 PAD I wrote the attached patch.

It does work here. My own program, trying to get synchronized
capture/playback streams, succeeds.

Programs that use either the playback or the capture part of the
hardware are not affected by start / pause/ stop operations of applications
using the other part of the hardware (tested with aplay, arecord, and ecasound).

I wrote the test code and the patch, so it is not impossible that I acted on
wrong assumptions in both places. Please have a close look at the patch.

cu,
  knut

--------------070404080708070607050309
Content-Type: text/x-patch;
 name="0001-alsa-Add-support-for-synchronized-start-pause-stop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-Add-support-for-synchronized-start-pause-stop.patc";
 filename*1="h"

>From 861be0a7216b9adfdc1632e6812a71417819c7f0 Mon Sep 17 00:00:00 2001
From: Knut Petersen <Knut_Petersen@t-online.de>
Date: Mon, 5 Aug 2013 13:47:59 +0200
Subject: [PATCH] alsa: Add support for synchronized start/pause/stop of pcm
 streams to the rme96 driver.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
---
 sound/pci/rme96.c | 110 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 24 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 5fb88ac..f7e3bd7 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -344,6 +344,7 @@ static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+                              SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -373,6 +374,7 @@ static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+                              SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -402,6 +404,7 @@ static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+                              SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -427,6 +430,7 @@ static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+                              SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -1045,53 +1049,93 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 }
 
 static void
-snd_rme96_playback_start(struct rme96 *rme96,
+snd_rme96_playcap_start(struct rme96 *rme96,
 			 int from_pause)
 {
 	if (!from_pause) {
 		writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
+		writel(0, rme96->iobase + RME96_IO_RESET_REC_POS);
 	}
-
-	rme96->wcreg |= RME96_WCR_START;
+	rme96->wcreg |= (RME96_WCR_START | RME96_WCR_START_2);
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 }
 
 static void
+snd_rme96_playback_start(struct rme96 *rme96,
+			 int from_pause)
+{
+	if ((rme96->playback_substream && rme96->capture_substream) && 
+	    (rme96->playback_substream->group == rme96->capture_substream->group)) {
+		snd_rme96_playcap_start(rme96,from_pause);
+	} else {
+		if (!from_pause) {
+			writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
+		}
+		rme96->wcreg |= RME96_WCR_START;
+		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
+	}
+}
+
+static void
 snd_rme96_capture_start(struct rme96 *rme96,
 			int from_pause)
 {
-	if (!from_pause) {
-		writel(0, rme96->iobase + RME96_IO_RESET_REC_POS);
+	if ((rme96->playback_substream && rme96->capture_substream) && 
+	    (rme96->playback_substream->group == rme96->capture_substream->group)) {
+		snd_rme96_playcap_start(rme96,from_pause);
+	} else {
+		if (!from_pause) {
+			writel(0, rme96->iobase + RME96_IO_RESET_REC_POS);
+		}
+		rme96->wcreg |= RME96_WCR_START_2;
+		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	}
-
-	rme96->wcreg |= RME96_WCR_START_2;
-	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 }
 
 static void
-snd_rme96_playback_stop(struct rme96 *rme96)
+snd_rme96_playcap_stop(struct rme96 *rme96)
 {
-	/*
-	 * Check if there is an unconfirmed IRQ, if so confirm it, or else
-	 * the hardware will not stop generating interrupts
-	 */
 	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	if (rme96->rcreg & RME96_RCR_IRQ) {
 		writel(0, rme96->iobase + RME96_IO_CONFIRM_PLAY_IRQ);
-	}	
-	rme96->wcreg &= ~RME96_WCR_START;
+	}
+	if (rme96->rcreg & RME96_RCR_IRQ_2) {
+		writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
+	}
+	rme96->wcreg &= ~(RME96_WCR_START | RME96_WCR_START_2);
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 }
 
 static void
+snd_rme96_playback_stop(struct rme96 *rme96)
+{
+	if ((rme96->playback_substream && rme96->capture_substream) && 
+	    (rme96->playback_substream->group == rme96->capture_substream->group)) {
+		snd_rme96_playcap_stop(rme96);
+	} else {
+		rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
+		if (rme96->rcreg & RME96_RCR_IRQ) {
+			writel(0, rme96->iobase + RME96_IO_CONFIRM_PLAY_IRQ);
+		}
+		rme96->wcreg &= ~RME96_WCR_START;
+		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
+	}
+}
+
+static void
 snd_rme96_capture_stop(struct rme96 *rme96)
 {
-	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
-	if (rme96->rcreg & RME96_RCR_IRQ_2) {
-		writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
-	}	
-	rme96->wcreg &= ~RME96_WCR_START_2;
-	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
+	if ((rme96->playback_substream && rme96->capture_substream) && 
+	    (rme96->playback_substream->group == rme96->capture_substream->group)) {
+		snd_rme96_playcap_stop(rme96);
+	} else {
+		rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
+		if (rme96->rcreg & RME96_RCR_IRQ_2) {
+			writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
+		}
+		rme96->wcreg &= ~RME96_WCR_START_2;
+		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
+	}
 }
 
 static irqreturn_t
@@ -1155,6 +1199,7 @@ snd_rme96_playback_spdif_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	snd_pcm_set_sync(substream);
 	spin_lock_irq(&rme96->lock);	
         if (rme96->playback_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
@@ -1191,6 +1236,7 @@ snd_rme96_capture_spdif_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	snd_pcm_set_sync(substream);
 	runtime->hw = snd_rme96_capture_spdif_info;
         if (snd_rme96_getinputtype(rme96) != RME96_INPUT_ANALOG &&
             (rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0)
@@ -1222,6 +1268,7 @@ snd_rme96_playback_adat_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;        
 	
+	snd_pcm_set_sync(substream);
 	spin_lock_irq(&rme96->lock);	
         if (rme96->playback_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
@@ -1253,6 +1300,7 @@ snd_rme96_capture_adat_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	snd_pcm_set_sync(substream);
 	runtime->hw = snd_rme96_capture_adat_info;
         if (snd_rme96_getinputtype(rme96) == RME96_INPUT_ANALOG) {
                 /* makes no sense to use analog input. Note that analog
@@ -1306,7 +1354,7 @@ static int
 snd_rme96_capture_close(struct snd_pcm_substream *substream)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	
+
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISRECORDING(rme96)) {
 		snd_rme96_capture_stop(rme96);
@@ -1321,7 +1369,7 @@ static int
 snd_rme96_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	
+
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISPLAYING(rme96)) {
 		snd_rme96_playback_stop(rme96);
@@ -1335,7 +1383,7 @@ static int
 snd_rme96_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	
+
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISRECORDING(rme96)) {
 		snd_rme96_capture_stop(rme96);
@@ -1350,6 +1398,13 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 			   int cmd)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
+	struct snd_pcm_substream *s;
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (snd_pcm_substream_chip(s) == rme96) {
+			snd_pcm_trigger_done(s, substream);
+		}
+	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1393,6 +1448,13 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 			  int cmd)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
+	struct snd_pcm_substream *s;
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (snd_pcm_substream_chip(s) == rme96) {
+			snd_pcm_trigger_done(s, substream);
+		}
+	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-- 
1.8.1.4


--------------070404080708070607050309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070404080708070607050309--
