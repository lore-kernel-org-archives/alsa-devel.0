From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 5/5] ALSA: AACI: switch to per-pcm locking
Date: Fri, 18 Dec 2009 17:48:50 +0000
Message-ID: <E1NLgwc-0005NP-RO@rmk-PC.arm.linux.org.uk>
References: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 53549103941
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 18:49:13 +0100 (CET)
In-Reply-To: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We can use finer-grained locking, which makes things easier when
we gain DMA support.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |   49 +++++++++++++++++++++++++++++--------------------
 sound/arm/aaci.h |    2 +-
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 0635c62..e35a0fc 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -172,14 +172,15 @@ static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	return v;
 }
 
-static inline void aaci_chan_wait_ready(struct aaci_runtime *aacirun)
+static inline void
+aaci_chan_wait_ready(struct aaci_runtime *aacirun, unsigned long mask)
 {
 	u32 val;
 	int timeout = 5000;
 
 	do {
 		val = readl(aacirun->base + AACI_SR);
-	} while (val & (SR_TXB|SR_RXB) && timeout--);
+	} while (val & mask && timeout--);
 }
 
 
@@ -208,8 +209,10 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 			writel(0, aacirun->base + AACI_IE);
 			return;
 		}
-		ptr = aacirun->ptr;
 
+		spin_lock(&aacirun->lock);
+
+		ptr = aacirun->ptr;
 		do {
 			unsigned int len = aacirun->fifosz;
 			u32 val;
@@ -217,9 +220,9 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 			if (aacirun->bytes <= 0) {
 				aacirun->bytes += aacirun->period;
 				aacirun->ptr = ptr;
-				spin_unlock(&aaci->lock);
+				spin_unlock(&aacirun->lock);
 				snd_pcm_period_elapsed(aacirun->substream);
-				spin_lock(&aaci->lock);
+				spin_lock(&aacirun->lock);
 			}
 			if (!(aacirun->cr & CR_EN))
 				break;
@@ -245,7 +248,10 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 					ptr = aacirun->start;
 			}
 		} while(1);
+
 		aacirun->ptr = ptr;
+
+		spin_unlock(&aacirun->lock);
 	}
 
 	if (mask & ISR_URINTR) {
@@ -263,6 +269,8 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 			return;
 		}
 
+		spin_lock(&aacirun->lock);
+
 		ptr = aacirun->ptr;
 		do {
 			unsigned int len = aacirun->fifosz;
@@ -271,9 +279,9 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 			if (aacirun->bytes <= 0) {
 				aacirun->bytes += aacirun->period;
 				aacirun->ptr = ptr;
-				spin_unlock(&aaci->lock);
+				spin_unlock(&aacirun->lock);
 				snd_pcm_period_elapsed(aacirun->substream);
-				spin_lock(&aaci->lock);
+				spin_lock(&aacirun->lock);
 			}
 			if (!(aacirun->cr & CR_EN))
 				break;
@@ -301,6 +309,8 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 		} while (1);
 
 		aacirun->ptr = ptr;
+
+		spin_unlock(&aacirun->lock);
 	}
 }
 
@@ -310,7 +320,6 @@ static irqreturn_t aaci_irq(int irq, void *devid)
 	u32 mask;
 	int i;
 
-	spin_lock(&aaci->lock);
 	mask = readl(aaci->base + AACI_ALLINTS);
 	if (mask) {
 		u32 m = mask;
@@ -320,7 +329,6 @@ static irqreturn_t aaci_irq(int irq, void *devid)
 			}
 		}
 	}
-	spin_unlock(&aaci->lock);
 
 	return mask ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -580,7 +588,7 @@ static void aaci_pcm_playback_stop(struct aaci_runtime *aacirun)
 	ie &= ~(IE_URIE|IE_TXIE);
 	writel(ie, aacirun->base + AACI_IE);
 	aacirun->cr &= ~CR_EN;
-	aaci_chan_wait_ready(aacirun);
+	aaci_chan_wait_ready(aacirun, SR_TXB);
 	writel(aacirun->cr, aacirun->base + AACI_TXCR);
 }
 
@@ -588,7 +596,7 @@ static void aaci_pcm_playback_start(struct aaci_runtime *aacirun)
 {
 	u32 ie;
 
-	aaci_chan_wait_ready(aacirun);
+	aaci_chan_wait_ready(aacirun, SR_TXB);
 	aacirun->cr |= CR_EN;
 
 	ie = readl(aacirun->base + AACI_IE);
@@ -599,12 +607,12 @@ static void aaci_pcm_playback_start(struct aaci_runtime *aacirun)
 
 static int aaci_pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct aaci *aaci = substream->private_data;
 	struct aaci_runtime *aacirun = substream->runtime->private_data;
 	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&aaci->lock, flags);
+	spin_lock_irqsave(&aacirun->lock, flags);
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		aaci_pcm_playback_start(aacirun);
@@ -631,7 +639,8 @@ static int aaci_pcm_playback_trigger(struct snd_pcm_substream *substream, int cm
 	default:
 		ret = -EINVAL;
 	}
-	spin_unlock_irqrestore(&aaci->lock, flags);
+
+	spin_unlock_irqrestore(&aacirun->lock, flags);
 
 	return ret;
 }
@@ -666,7 +675,7 @@ static void aaci_pcm_capture_stop(struct aaci_runtime *aacirun)
 {
 	u32 ie;
 
-	aaci_chan_wait_ready(aacirun);
+	aaci_chan_wait_ready(aacirun, SR_RXB);
 
 	ie = readl(aacirun->base + AACI_IE);
 	ie &= ~(IE_ORIE | IE_RXIE);
@@ -681,7 +690,7 @@ static void aaci_pcm_capture_start(struct aaci_runtime *aacirun)
 {
 	u32 ie;
 
-	aaci_chan_wait_ready(aacirun);
+	aaci_chan_wait_ready(aacirun, SR_RXB);
 
 #ifdef DEBUG
 	/* RX Timeout value: bits 28:17 in RXCR */
@@ -698,12 +707,11 @@ static void aaci_pcm_capture_start(struct aaci_runtime *aacirun)
 
 static int aaci_pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct aaci *aaci = substream->private_data;
 	struct aaci_runtime *aacirun = substream->runtime->private_data;
 	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&aaci->lock, flags);
+	spin_lock_irqsave(&aacirun->lock, flags);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -732,7 +740,7 @@ static int aaci_pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irqrestore(&aaci->lock, flags);
+	spin_unlock_irqrestore(&aacirun->lock, flags);
 
 	return ret;
 }
@@ -933,7 +941,6 @@ static struct aaci * __devinit aaci_init_card(struct amba_device *dev)
 
 	aaci = card->private_data;
 	mutex_init(&aaci->ac97_sem);
-	spin_lock_init(&aaci->lock);
 	aaci->card = card;
 	aaci->dev = dev;
 
@@ -1020,12 +1027,14 @@ static int __devinit aaci_probe(struct amba_device *dev, struct amba_id *id)
 	/*
 	 * Playback uses AACI channel 0
 	 */
+	spin_lock_init(&aaci->playback.lock);
 	aaci->playback.base = aaci->base + AACI_CSCH1;
 	aaci->playback.fifo = aaci->base + AACI_DR1;
 
 	/*
 	 * Capture uses AACI channel 0
 	 */
+	spin_lock_init(&aaci->capture.lock);
 	aaci->capture.base = aaci->base + AACI_CSCH1;
 	aaci->capture.fifo = aaci->base + AACI_DR1;
 
diff --git a/sound/arm/aaci.h b/sound/arm/aaci.h
index 924f69c..6a4a2ee 100644
--- a/sound/arm/aaci.h
+++ b/sound/arm/aaci.h
@@ -202,6 +202,7 @@
 struct aaci_runtime {
 	void			__iomem *base;
 	void			__iomem *fifo;
+	spinlock_t		lock;
 
 	struct ac97_pcm		*pcm;
 	int			pcm_open;
@@ -232,7 +233,6 @@ struct aaci {
 	struct snd_ac97		*ac97;
 
 	u32			maincr;
-	spinlock_t		lock;
 
 	struct aaci_runtime	playback;
 	struct aaci_runtime	capture;
-- 
1.6.2.5
