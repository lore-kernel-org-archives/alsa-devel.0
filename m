From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH] rme96 add stream synchronization and PM support
Date: Tue, 13 Aug 2013 23:12:05 +0200
Message-ID: <520AA125.5010803@t-online.de>
References: <51FF9C55.80701@t-online.de> <51FFA643.7060504@ladisch.de>
 <52013579.7020304@t-online.de> <s5h4nb2asg5.wl%tiwai@suse.de>
 <52037864.9000205@t-online.de> <s5h61vacb25.wl%tiwai@suse.de>
 <520A0B2C.7060500@t-online.de> <s5hy585x4e3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080908040302040309070806"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 80781261A10
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 23:12:13 +0200 (CEST)
In-Reply-To: <s5hy585x4e3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080908040302040309070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody!

The attached patches add pcm stream synchronization support
as well as power management code to the rme96 driver.

scripts/checkpatch.pl does not show any warnings / errors, so
I hope that these attached versions of the patches are acceptable.

cu,
  Knut

--------------080908040302040309070806
Content-Type: text/x-patch;
 name="0001-alsa-rme96-Add-pcm-stream-synchronization.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-rme96-Add-pcm-stream-synchronization.patch"

>From 5edf3a59fffb7038a75c50c715ea649fd9a4cd8e Mon Sep 17 00:00:00 2001
From: Knut Petersen <Knut_Petersen@t-online.de>
Date: Tue, 13 Aug 2013 21:18:12 +0200
Subject: [PATCH 1/2] alsa/rme96: Add pcm stream synchronization

The hardware does support synchronized start/pause/stop of pcm streams,
so there is no reason not to add that feature after more than ten years.

Some minor coding style / white space fixes in the surroundings of the
changes.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
---
 sound/pci/rme96.c | 185 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 110 insertions(+), 75 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 5fb88ac..3eb0bdd 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -198,6 +198,31 @@ MODULE_PARM_DESC(enable, "Enable RME Digi96 soundcard.");
 #define RME96_AD1852_VOL_BITS 14
 #define RME96_AD1855_VOL_BITS 10
 
+/* Defines for snd_rme96_trigger */
+#define RME96_TB_START_PLAYBACK 1
+#define RME96_TB_START_CAPTURE 2
+#define RME96_TB_STOP_PLAYBACK 4
+#define RME96_TB_STOP_CAPTURE 8
+#define RME96_TB_RESET_PLAYPOS 16
+#define RME96_TB_RESET_CAPTUREPOS 32
+#define RME96_TB_CLEAR_PLAYBACK_IRQ 64
+#define RME96_TB_CLEAR_CAPTURE_IRQ 128
+#define RME96_RESUME_PLAYBACK	(RME96_TB_START_PLAYBACK)
+#define RME96_RESUME_CAPTURE	(RME96_TB_START_CAPTURE)
+#define RME96_RESUME_BOTH	(RME96_RESUME_PLAYBACK \
+				| RME96_RESUME_CAPTURE)
+#define RME96_START_PLAYBACK	(RME96_TB_START_PLAYBACK \
+				| RME96_TB_RESET_PLAYPOS)
+#define RME96_START_CAPTURE	(RME96_TB_START_CAPTURE \
+				| RME96_TB_RESET_CAPTUREPOS)
+#define RME96_START_BOTH	(RME96_START_PLAYBACK \
+				| RME96_START_CAPTURE)
+#define RME96_STOP_PLAYBACK	(RME96_TB_STOP_PLAYBACK \
+				| RME96_TB_CLEAR_PLAYBACK_IRQ)
+#define RME96_STOP_CAPTURE	(RME96_TB_STOP_CAPTURE \
+				| RME96_TB_CLEAR_CAPTURE_IRQ)
+#define RME96_STOP_BOTH		(RME96_STOP_PLAYBACK \
+				| RME96_STOP_CAPTURE)
 
 struct rme96 {
 	spinlock_t    lock;
@@ -344,6 +369,7 @@ static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+			      SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -373,6 +399,7 @@ static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+			      SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -402,6 +429,7 @@ static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+			      SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -427,6 +455,7 @@ static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
+			      SNDRV_PCM_INFO_SYNC_START |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -1045,54 +1074,35 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 }
 
 static void
-snd_rme96_playback_start(struct rme96 *rme96,
-			 int from_pause)
+snd_rme96_trigger(struct rme96 *rme96,
+		  int op)
 {
-	if (!from_pause) {
+	if (op & RME96_TB_RESET_PLAYPOS)
 		writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
-	}
-
-	rme96->wcreg |= RME96_WCR_START;
-	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
-}
-
-static void
-snd_rme96_capture_start(struct rme96 *rme96,
-			int from_pause)
-{
-	if (!from_pause) {
+	if (op & RME96_TB_RESET_CAPTUREPOS)
 		writel(0, rme96->iobase + RME96_IO_RESET_REC_POS);
-	}
-
-	rme96->wcreg |= RME96_WCR_START_2;
+	if (op & RME96_TB_CLEAR_PLAYBACK_IRQ) {
+		rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
+		if (rme96->rcreg & RME96_RCR_IRQ)
+			writel(0, rme96->iobase + RME96_IO_CONFIRM_PLAY_IRQ);
+	}
+	if (op & RME96_TB_CLEAR_CAPTURE_IRQ) {
+		rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
+		if (rme96->rcreg & RME96_RCR_IRQ_2)
+			writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
+	}
+	if (op & RME96_TB_START_PLAYBACK)
+		rme96->wcreg |= RME96_WCR_START;
+	if (op & RME96_TB_STOP_PLAYBACK)
+		rme96->wcreg &= ~RME96_WCR_START;
+	if (op & RME96_TB_START_CAPTURE)
+		rme96->wcreg |= RME96_WCR_START_2;
+	if (op & RME96_TB_STOP_CAPTURE)
+		rme96->wcreg &= ~RME96_WCR_START_2;
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 }
 
-static void
-snd_rme96_playback_stop(struct rme96 *rme96)
-{
-	/*
-	 * Check if there is an unconfirmed IRQ, if so confirm it, or else
-	 * the hardware will not stop generating interrupts
-	 */
-	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
-	if (rme96->rcreg & RME96_RCR_IRQ) {
-		writel(0, rme96->iobase + RME96_IO_CONFIRM_PLAY_IRQ);
-	}	
-	rme96->wcreg &= ~RME96_WCR_START;
-	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
-}
 
-static void
-snd_rme96_capture_stop(struct rme96 *rme96)
-{
-	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
-	if (rme96->rcreg & RME96_RCR_IRQ_2) {
-		writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
-	}	
-	rme96->wcreg &= ~RME96_WCR_START_2;
-	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
-}
 
 static irqreturn_t
 snd_rme96_interrupt(int irq,
@@ -1155,6 +1165,7 @@ snd_rme96_playback_spdif_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	snd_pcm_set_sync(substream);
 	spin_lock_irq(&rme96->lock);	
         if (rme96->playback_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
@@ -1191,6 +1202,7 @@ snd_rme96_capture_spdif_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	snd_pcm_set_sync(substream);
 	runtime->hw = snd_rme96_capture_spdif_info;
         if (snd_rme96_getinputtype(rme96) != RME96_INPUT_ANALOG &&
             (rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0)
@@ -1222,6 +1234,7 @@ snd_rme96_playback_adat_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;        
 	
+	snd_pcm_set_sync(substream);
 	spin_lock_irq(&rme96->lock);	
         if (rme96->playback_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
@@ -1253,6 +1266,7 @@ snd_rme96_capture_adat_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	snd_pcm_set_sync(substream);
 	runtime->hw = snd_rme96_capture_adat_info;
         if (snd_rme96_getinputtype(rme96) == RME96_INPUT_ANALOG) {
                 /* makes no sense to use analog input. Note that analog
@@ -1288,7 +1302,7 @@ snd_rme96_playback_close(struct snd_pcm_substream *substream)
 
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISPLAYING(rme96)) {
-		snd_rme96_playback_stop(rme96);
+		snd_rme96_trigger(rme96, RME96_STOP_PLAYBACK);
 	}
 	rme96->playback_substream = NULL;
 	rme96->playback_periodsize = 0;
@@ -1309,7 +1323,7 @@ snd_rme96_capture_close(struct snd_pcm_substream *substream)
 	
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISRECORDING(rme96)) {
-		snd_rme96_capture_stop(rme96);
+		snd_rme96_trigger(rme96, RME96_STOP_CAPTURE);
 	}
 	rme96->capture_substream = NULL;
 	rme96->capture_periodsize = 0;
@@ -1324,7 +1338,7 @@ snd_rme96_playback_prepare(struct snd_pcm_substream *substream)
 	
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISPLAYING(rme96)) {
-		snd_rme96_playback_stop(rme96);
+		snd_rme96_trigger(rme96, RME96_STOP_PLAYBACK);
 	}
 	writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
 	spin_unlock_irq(&rme96->lock);
@@ -1338,7 +1352,7 @@ snd_rme96_capture_prepare(struct snd_pcm_substream *substream)
 	
 	spin_lock_irq(&rme96->lock);	
 	if (RME96_ISRECORDING(rme96)) {
-		snd_rme96_capture_stop(rme96);
+		snd_rme96_trigger(rme96, RME96_STOP_CAPTURE);
 	}
 	writel(0, rme96->iobase + RME96_IO_RESET_REC_POS);
 	spin_unlock_irq(&rme96->lock);
@@ -1350,41 +1364,53 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 			   int cmd)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
+	struct snd_pcm_substream *s;
+	bool sync;
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (snd_pcm_substream_chip(s) == rme96)
+			snd_pcm_trigger_done(s, substream);
+	}
+
+	sync = (rme96->playback_substream && rme96->capture_substream) &&
+	       (rme96->playback_substream->group ==
+		rme96->capture_substream->group);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		if (!RME96_ISPLAYING(rme96)) {
-			if (substream != rme96->playback_substream) {
+			if (substream != rme96->playback_substream)
 				return -EBUSY;
-			}
-			snd_rme96_playback_start(rme96, 0);
+			snd_rme96_trigger(rme96, sync ? RME96_START_BOTH
+						 : RME96_START_PLAYBACK);
 		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISPLAYING(rme96)) {
-			if (substream != rme96->playback_substream) {
+			if (substream != rme96->playback_substream)
 				return -EBUSY;
-			}
-			snd_rme96_playback_stop(rme96);
+			snd_rme96_trigger(rme96, sync ? RME96_STOP_BOTH
+						 :  RME96_STOP_PLAYBACK);
 		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (RME96_ISPLAYING(rme96)) {
-			snd_rme96_playback_stop(rme96);
-		}
+		if (RME96_ISPLAYING(rme96))
+			snd_rme96_trigger(rme96, sync ? RME96_STOP_BOTH
+						 : RME96_STOP_PLAYBACK);
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!RME96_ISPLAYING(rme96)) {
-			snd_rme96_playback_start(rme96, 1);
-		}
+		if (!RME96_ISPLAYING(rme96))
+			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH
+						 : RME96_RESUME_PLAYBACK);
 		break;
-		
+
 	default:
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
@@ -1393,38 +1419,49 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 			  int cmd)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
+	struct snd_pcm_substream *s;
+	bool sync;
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (snd_pcm_substream_chip(s) == rme96)
+			snd_pcm_trigger_done(s, substream);
+	}
+
+	sync = (rme96->playback_substream && rme96->capture_substream) &&
+	       (rme96->playback_substream->group ==
+		rme96->capture_substream->group);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		if (!RME96_ISRECORDING(rme96)) {
-			if (substream != rme96->capture_substream) {
+			if (substream != rme96->capture_substream)
 				return -EBUSY;
-			}
-			snd_rme96_capture_start(rme96, 0);
+			snd_rme96_trigger(rme96, sync ? RME96_START_BOTH
+						 : RME96_START_CAPTURE);
 		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISRECORDING(rme96)) {
-			if (substream != rme96->capture_substream) {
+			if (substream != rme96->capture_substream)
 				return -EBUSY;
-			}
-			snd_rme96_capture_stop(rme96);
+			snd_rme96_trigger(rme96, sync ? RME96_STOP_BOTH
+						 : RME96_STOP_CAPTURE);
 		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (RME96_ISRECORDING(rme96)) {
-			snd_rme96_capture_stop(rme96);
-		}
+		if (RME96_ISRECORDING(rme96))
+			snd_rme96_trigger(rme96, sync ? RME96_STOP_BOTH
+						 : RME96_STOP_CAPTURE);
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!RME96_ISRECORDING(rme96)) {
-			snd_rme96_capture_start(rme96, 1);
-		}
+		if (!RME96_ISRECORDING(rme96))
+			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH
+						 : RME96_RESUME_CAPTURE);
 		break;
-		
+
 	default:
 		return -EINVAL;
 	}
@@ -1505,8 +1542,7 @@ snd_rme96_free(void *private_data)
 	        return;
 	}
 	if (rme96->irq >= 0) {
-		snd_rme96_playback_stop(rme96);
-		snd_rme96_capture_stop(rme96);
+		snd_rme96_trigger(rme96, RME96_STOP_BOTH);
 		rme96->areg &= ~RME96_AR_DAC_EN;
 		writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
 		free_irq(rme96->irq, (void *)rme96);
@@ -1606,8 +1642,7 @@ snd_rme96_create(struct rme96 *rme96)
 	rme96->capture_periodsize = 0;
 	
 	/* make sure playback/capture is stopped, if by some reason active */
-	snd_rme96_playback_stop(rme96);
-	snd_rme96_capture_stop(rme96);
+	snd_rme96_trigger(rme96, RME96_STOP_BOTH);
 	
 	/* set default values in registers */
 	rme96->wcreg =
-- 
1.8.1.4


--------------080908040302040309070806
Content-Type: text/x-patch;
 name="0002-alsa-rme96-Add-PM-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-alsa-rme96-Add-PM-support.patch"

>From becb984d46fc32313316a647a674c711b45ca044 Mon Sep 17 00:00:00 2001
From: Knut Petersen <Knut_Petersen@t-online.de>
Date: Tue, 13 Aug 2013 22:19:48 +0200
Subject: [PATCH 2/2] alsa/rme96: Add PM support

Without proper power management handling, the first use
of a Digi96/8 anytime after a suspend / resume cycle will
start playback with distortions.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
---
 sound/pci/rme96.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 3eb0bdd..c309d24 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -239,6 +239,13 @@ struct rme96 {
 
 	u8 rev; /* card revision number */
 
+#ifdef CONFIG_PM
+	u32 playback_pointer;
+	u32 capture_pointer;
+	void *playback_suspend_buffer;
+	void *capture_suspend_buffer;
+#endif
+
 	struct snd_pcm_substream *playback_substream;
 	struct snd_pcm_substream *capture_substream;
 
@@ -370,6 +377,7 @@ static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -400,6 +408,7 @@ static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -430,6 +439,7 @@ static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -456,6 +466,7 @@ static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_SYNC_START |
+			      SNDRV_PCM_INFO_RESUME |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
@@ -1386,6 +1397,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISPLAYING(rme96)) {
 			if (substream != rme96->playback_substream)
@@ -1401,6 +1413,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 						 : RME96_STOP_PLAYBACK);
 		break;
 
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!RME96_ISPLAYING(rme96))
 			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH
@@ -1441,6 +1454,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 		}
 		break;
 
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (RME96_ISRECORDING(rme96)) {
 			if (substream != rme96->capture_substream)
@@ -1456,6 +1470,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 						 : RME96_STOP_CAPTURE);
 		break;
 
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!RME96_ISRECORDING(rme96))
 			snd_rme96_trigger(rme96, sync ? RME96_RESUME_BOTH
@@ -1556,6 +1571,10 @@ snd_rme96_free(void *private_data)
 		pci_release_regions(rme96->pci);
 		rme96->port = 0;
 	}
+#ifdef CONFIG_PM
+	vfree(rme96->playback_suspend_buffer);
+	vfree(rme96->capture_suspend_buffer);
+#endif
 	pci_disable_device(rme96->pci);
 }
 
@@ -2354,6 +2373,83 @@ snd_rme96_create_switches(struct snd_card *card,
  * Card initialisation
  */
 
+#ifdef CONFIG_PM
+
+static int
+snd_rme96_suspend(struct pci_dev *pci,
+		  pm_message_t state)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct rme96 *rme96 = card->private_data;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	snd_pcm_suspend(rme96->playback_substream);
+	snd_pcm_suspend(rme96->capture_substream);
+
+	/* save capture & playback pointers */
+	rme96->playback_pointer = readl(rme96->iobase + RME96_IO_GET_PLAY_POS)
+				  & RME96_RCR_AUDIO_ADDR_MASK;
+	rme96->capture_pointer = readl(rme96->iobase + RME96_IO_GET_REC_POS)
+				 & RME96_RCR_AUDIO_ADDR_MASK;
+
+	/* save playback and capture buffers */
+	memcpy_fromio(rme96->playback_suspend_buffer,
+		      rme96->iobase + RME96_IO_PLAY_BUFFER, RME96_BUFFER_SIZE);
+	memcpy_fromio(rme96->capture_suspend_buffer,
+		      rme96->iobase + RME96_IO_REC_BUFFER, RME96_BUFFER_SIZE);
+
+	/* disable the DAC  */
+	rme96->areg &= ~RME96_AR_DAC_EN;
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
+
+	pci_disable_device(pci);
+	pci_save_state(pci);
+
+	return 0;
+}
+
+static int
+snd_rme96_resume(struct pci_dev *pci)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct rme96 *rme96 = card->private_data;
+
+	pci_restore_state(pci);
+	pci_enable_device(pci);
+
+	/* reset playback and record buffer pointers */
+	writel(0, rme96->iobase + RME96_IO_SET_PLAY_POS
+		  + rme96->playback_pointer);
+	writel(0, rme96->iobase + RME96_IO_SET_REC_POS
+		  + rme96->capture_pointer);
+
+	/* restore playback and capture buffers */
+	memcpy_toio(rme96->iobase + RME96_IO_PLAY_BUFFER,
+		    rme96->playback_suspend_buffer, RME96_BUFFER_SIZE);
+	memcpy_toio(rme96->iobase + RME96_IO_REC_BUFFER,
+		    rme96->capture_suspend_buffer, RME96_BUFFER_SIZE);
+
+	/* reset the ADC */
+	writel(rme96->areg | RME96_AR_PD2,
+	       rme96->iobase + RME96_IO_ADDITIONAL_REG);
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
+
+	/* reset and enable DAC, restore analog volume */
+	snd_rme96_reset_dac(rme96);
+	rme96->areg |= RME96_AR_DAC_EN;
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
+	if (RME96_HAS_ANALOG_OUT(rme96)) {
+		usleep_range(3000, 10000);
+		snd_rme96_apply_dac_volume(rme96);
+	}
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+
+#endif
+
 static void snd_rme96_card_free(struct snd_card *card)
 {
 	snd_rme96_free(card->private_data);
@@ -2390,6 +2486,21 @@ snd_rme96_probe(struct pci_dev *pci,
 		return err;
 	}
 	
+#ifdef CONFIG_PM
+	rme96->playback_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
+	if (!rme96->playback_suspend_buffer) {
+		snd_printk(KERN_ERR
+			   "Failed to allocate playback suspend buffer!\n");
+		return -ENOMEM;
+	}
+	rme96->capture_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
+	if (!rme96->capture_suspend_buffer) {
+		snd_printk(KERN_ERR
+			   "Failed to allocate capture suspend buffer!\n");
+		return -ENOMEM;
+	}
+#endif
+
 	strcpy(card->driver, "Digi96");
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
@@ -2433,6 +2544,10 @@ static struct pci_driver rme96_driver = {
 	.id_table = snd_rme96_ids,
 	.probe = snd_rme96_probe,
 	.remove = snd_rme96_remove,
+#ifdef CONFIG_PM
+	.suspend = snd_rme96_suspend,
+	.resume = snd_rme96_resume,
+#endif
 };
 
 module_pci_driver(rme96_driver);
-- 
1.8.1.4


--------------080908040302040309070806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080908040302040309070806--
