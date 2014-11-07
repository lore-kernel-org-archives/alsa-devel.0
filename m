From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Add snd_pcm_stop_xrun() helper
Date: Fri,  7 Nov 2014 17:12:37 +0100
Message-ID: <1415376757-5836-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 84C72265779
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 17:12:40 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3C273AD68
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 16:12:40 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a new helper function snd_pcm_stop_xrun() to the standard sequnce
lock/snd_pcm_stop(XRUN)/unlock by a single call, and replace the
existing open codes with this helper.

The function checks the PCM running state to prevent setting the wrong
state, too, for more safety.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/saa7134/saa7134-alsa.c |  4 +---
 include/sound/pcm.h                      |  1 +
 sound/arm/pxa2xx-pcm-lib.c               |  4 +---
 sound/core/pcm_native.c                  | 23 +++++++++++++++++++++++
 sound/firewire/amdtp.c                   |  8 ++------
 sound/firewire/isight.c                  | 10 ++--------
 sound/pci/asihpi/asihpi.c                |  5 +----
 sound/pci/atiixp.c                       |  4 +---
 sound/pci/atiixp_modem.c                 |  4 +---
 sound/soc/atmel/atmel-pcm-dma.c          |  4 +---
 sound/soc/fsl/fsl_dma.c                  |  9 +--------
 sound/usb/6fire/pcm.c                    | 17 ++++-------------
 sound/usb/endpoint.c                     |  4 +---
 sound/usb/misc/ua101.c                   | 18 ++++--------------
 sound/usb/usx2y/usbusx2yaudio.c          |  9 ++-------
 15 files changed, 46 insertions(+), 78 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index 40569894c1c9..ac3cd74e824e 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -173,9 +173,7 @@ static void saa7134_irq_alsa_done(struct saa7134_dev *dev,
 		dprintk("irq: overrun [full=%d/%d] - Blocks in %d\n",dev->dmasound.read_count,
 			dev->dmasound.bufsize, dev->dmasound.blocks);
 		spin_unlock(&dev->slock);
-		snd_pcm_stream_lock(dev->dmasound.substream);
-		snd_pcm_stop(dev->dmasound.substream,SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(dev->dmasound.substream);
+		snd_pcm_stop_xrun(dev->dmasound.substream);
 		return;
 	}
 
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0b8daeed0a33..40289ec2451c 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -506,6 +506,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 int snd_pcm_start(struct snd_pcm_substream *substream);
 int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
+int snd_pcm_stop_xrun(struct snd_pcm_substream *substream);
 #ifdef CONFIG_PM
 int snd_pcm_suspend(struct snd_pcm_substream *substream);
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index a61d7a9a995e..01f8fdc42b1b 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -200,9 +200,7 @@ void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
 	} else {
 		printk(KERN_ERR "DMA error on channel %d (DCSR=%#x)\n",
 			dma_ch, dcsr);
-		snd_pcm_stream_lock(substream);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(substream);
+		snd_pcm_stop_xrun(substream);
 	}
 }
 EXPORT_SYMBOL(pxa2xx_pcm_dma_irq);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index dfb5031969f8..a3d122109704 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1098,6 +1098,29 @@ int snd_pcm_drain_done(struct snd_pcm_substream *substream)
 				     SNDRV_PCM_STATE_SETUP);
 }
 
+/**
+ * snd_pcm_stop_xrun - stop the running streams as XRUN
+ * @substream: the PCM substream instance
+ * @state: PCM state after stopping the stream
+ *
+ * This stops the given running substream (and all linked substreams) as XRUN.
+ * Unlike snd_pcm_stop(), this function takes the substream lock by itself.
+ *
+ * Return: Zero if successful, or a negative error code.
+ */
+int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	snd_pcm_stream_lock_irqsave(substream, flags);
+	if (snd_pcm_running(substream))
+		ret = snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	snd_pcm_stream_unlock_irqrestore(substream, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_pcm_stop_xrun);
+
 /*
  * pause callbacks
  */
diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 95fc2eaf11dc..3badc70124ab 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -1006,11 +1006,7 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 	struct snd_pcm_substream *pcm;
 
 	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm) {
-		snd_pcm_stream_lock_irq(pcm);
-		if (snd_pcm_running(pcm))
-			snd_pcm_stop(pcm, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock_irq(pcm);
-	}
+	if (pcm)
+		snd_pcm_stop_xrun(pcm);
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_abort);
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 7ac94439e758..48d6dca471c6 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -131,14 +131,8 @@ static void isight_samples(struct isight *isight,
 
 static void isight_pcm_abort(struct isight *isight)
 {
-	unsigned long flags;
-
-	if (ACCESS_ONCE(isight->pcm_active)) {
-		snd_pcm_stream_lock_irqsave(isight->pcm, flags);
-		if (snd_pcm_running(isight->pcm))
-			snd_pcm_stop(isight->pcm, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock_irqrestore(isight->pcm, flags);
-	}
+	if (ACCESS_ONCE(isight->pcm_active))
+		snd_pcm_stop_xrun(isight->pcm);
 }
 
 static void isight_dropped_samples(struct isight *isight, unsigned int total)
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index ac66b3228a34..ff9f9f1c0391 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -769,10 +769,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 						s->number);
 				ds->drained_count++;
 				if (ds->drained_count > 20) {
-					unsigned long flags;
-					snd_pcm_stream_lock_irqsave(s, flags);
-					snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
-					snd_pcm_stream_unlock_irqrestore(s, flags);
+					snd_pcm_stop_xrun(s);
 					continue;
 				}
 			} else {
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 7895c5d300c7..9c1c4452a8ee 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -688,9 +688,7 @@ static void snd_atiixp_xrun_dma(struct atiixp *chip, struct atiixp_dma *dma)
 	if (! dma->substream || ! dma->running)
 		return;
 	dev_dbg(chip->card->dev, "XRUN detected (DMA %d)\n", dma->ops->type);
-	snd_pcm_stream_lock(dma->substream);
-	snd_pcm_stop(dma->substream, SNDRV_PCM_STATE_XRUN);
-	snd_pcm_stream_unlock(dma->substream);
+	snd_pcm_stop_xrun(dma->substream);
 }
 
 /*
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 3c3241309a30..b2f63e0727de 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -638,9 +638,7 @@ static void snd_atiixp_xrun_dma(struct atiixp_modem *chip,
 	if (! dma->substream || ! dma->running)
 		return;
 	dev_dbg(chip->card->dev, "XRUN detected (DMA %d)\n", dma->ops->type);
-	snd_pcm_stream_lock(dma->substream);
-	snd_pcm_stop(dma->substream, SNDRV_PCM_STATE_XRUN);
-	snd_pcm_stream_unlock(dma->substream);
+	snd_pcm_stop_xrun(dma->substream);
 }
 
 /*
diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index b79a2a864513..33fb3bb133df 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -80,9 +80,7 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 
 		/* stop RX and capture: will be enabled again at restart */
 		ssc_writex(prtd->ssc->regs, SSC_CR, prtd->mask->ssc_disable);
-		snd_pcm_stream_lock(substream);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(substream);
+		snd_pcm_stop_xrun(substream);
 
 		/* now drain RHR and read status to remove xrun condition */
 		ssc_readx(prtd->ssc->regs, SSC_RHR);
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index a609aafc994d..b2b108805b24 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -151,14 +151,7 @@ static const struct snd_pcm_hardware fsl_dma_hardware = {
  */
 static void fsl_dma_abort_stream(struct snd_pcm_substream *substream)
 {
-	unsigned long flags;
-
-	snd_pcm_stream_lock_irqsave(substream, flags);
-
-	if (snd_pcm_running(substream))
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-
-	snd_pcm_stream_unlock_irqrestore(substream, flags);
+	snd_pcm_stop_xrun(substream);
 }
 
 /**
diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index ba40489b2de4..36f4115eb1cd 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -679,25 +679,16 @@ int usb6fire_pcm_init(struct sfire_chip *chip)
 void usb6fire_pcm_abort(struct sfire_chip *chip)
 {
 	struct pcm_runtime *rt = chip->pcm;
-	unsigned long flags;
 	int i;
 
 	if (rt) {
 		rt->panic = true;
 
-		if (rt->playback.instance) {
-			snd_pcm_stream_lock_irqsave(rt->playback.instance, flags);
-			snd_pcm_stop(rt->playback.instance,
-					SNDRV_PCM_STATE_XRUN);
-			snd_pcm_stream_unlock_irqrestore(rt->playback.instance, flags);
-		}
+		if (rt->playback.instance)
+			snd_pcm_stop_xrun(rt->playback.instance);
 
-		if (rt->capture.instance) {
-			snd_pcm_stream_lock_irqsave(rt->capture.instance, flags);
-			snd_pcm_stop(rt->capture.instance,
-					SNDRV_PCM_STATE_XRUN);
-			snd_pcm_stream_unlock_irqrestore(rt->capture.instance, flags);
-		}
+		if (rt->capture.instance)
+			snd_pcm_stop_xrun(rt->capture.instance);
 
 		for (i = 0; i < PCM_N_URBS; i++) {
 			usb_poison_urb(&rt->in_urbs[i].instance);
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a4679913b0aa..03b074419964 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -391,9 +391,7 @@ static void snd_complete_urb(struct urb *urb)
 	usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
 	if (ep->data_subs && ep->data_subs->pcm_substream) {
 		substream = ep->data_subs->pcm_substream;
-		snd_pcm_stream_lock_irqsave(substream, flags);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock_irqrestore(substream, flags);
+		snd_pcm_stop_xrun(substream);
 	}
 
 exit_clear:
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index a1bab149df4d..9581089c28c5 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -613,24 +613,14 @@ static int start_usb_playback(struct ua101 *ua)
 
 static void abort_alsa_capture(struct ua101 *ua)
 {
-	unsigned long flags;
-
-	if (test_bit(ALSA_CAPTURE_RUNNING, &ua->states)) {
-		snd_pcm_stream_lock_irqsave(ua->capture.substream, flags);
-		snd_pcm_stop(ua->capture.substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock_irqrestore(ua->capture.substream, flags);
-	}
+	if (test_bit(ALSA_CAPTURE_RUNNING, &ua->states))
+		snd_pcm_stop_xrun(ua->capture.substream);
 }
 
 static void abort_alsa_playback(struct ua101 *ua)
 {
-	unsigned long flags;
-
-	if (test_bit(ALSA_PLAYBACK_RUNNING, &ua->states)) {
-		snd_pcm_stream_lock_irqsave(ua->playback.substream, flags);
-		snd_pcm_stop(ua->playback.substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock_irqrestore(ua->playback.substream, flags);
-	}
+	if (test_bit(ALSA_PLAYBACK_RUNNING, &ua->states))
+		snd_pcm_stop_xrun(ua->playback.substream);
 }
 
 static int set_stream_hw(struct ua101 *ua, struct snd_pcm_substream *substream,
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index a63330dd1407..61d5dc2a3421 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -272,13 +272,8 @@ static void usX2Y_clients_stop(struct usX2Ydev *usX2Y)
 	for (s = 0; s < 4; s++) {
 		struct snd_usX2Y_substream *subs = usX2Y->subs[s];
 		if (subs) {
-			if (atomic_read(&subs->state) >= state_PRERUNNING) {
-				unsigned long flags;
-
-				snd_pcm_stream_lock_irqsave(subs->pcm_substream, flags);
-				snd_pcm_stop(subs->pcm_substream, SNDRV_PCM_STATE_XRUN);
-				snd_pcm_stream_unlock_irqrestore(subs->pcm_substream, flags);
-			}
+			if (atomic_read(&subs->state) >= state_PRERUNNING)
+				snd_pcm_stop_xrun(subs->pcm_substream);
 			for (u = 0; u < NRURBS; u++) {
 				struct urb *urb = subs->urb[u];
 				if (NULL != urb)
-- 
2.1.3
