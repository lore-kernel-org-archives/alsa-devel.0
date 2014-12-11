From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH/RFC 09/14] ASoC: samsung: i2s: Add spinlock in place of
 local_irq_* calls
Date: Thu, 11 Dec 2014 18:45:47 +0100
Message-ID: <1418319952-10163-10-git-send-email-s.nawrocki@samsung.com>
References: <1418319952-10163-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418319952-10163-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org
Cc: broonie@kernel.org, padma.v@samsung.com, drake@endlessm.com, sbkim73@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

It seems this driver hasn't been updated for SMP, as local_irq_save/
local_irq_restore doesn't provide proper protection of read/modify/write
of the device's registers on such systems. Introduce a spinlock serializing
access to the register region, it will be helpful later when some of
the registers are made also accessible through the clk API.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index a131621..e8e0107 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -94,6 +94,10 @@ struct i2s_dai {
 	u32	suspend_i2scon;
 	u32	suspend_i2spsr;
 	const struct samsung_i2s_variant_regs *variant_regs;
+
+	/* Spinlock protecting access to the device's registers */
+	spinlock_t spinlock;
+	spinlock_t *lock;
 };
 
 /* Lock for cross i/f checks */
@@ -867,10 +871,10 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		local_irq_save(flags);
+		spin_lock_irqsave(i2s->lock, flags);
 
 		if (config_setup(i2s)) {
-			local_irq_restore(flags);
+			spin_unlock_irqrestore(i2s->lock, flags);
 			return -EINVAL;
 		}
 
@@ -879,12 +883,12 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 		else
 			i2s_txctrl(i2s, 1);
 
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(i2s->lock, flags);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		local_irq_save(flags);
+		spin_lock_irqsave(i2s->lock, flags);
 
 		if (capture) {
 			i2s_rxctrl(i2s, 0);
@@ -894,7 +898,7 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 			i2s_fifo(i2s, FIC_TXFLUSH);
 		}
 
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(i2s->lock, flags);
 		break;
 	}
 
@@ -1157,6 +1161,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	spin_lock_init(&pri_dai->spinlock);
+	pri_dai->lock = &pri_dai->spinlock;
+
 	if (!np) {
 		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 		if (!res) {
@@ -1234,6 +1241,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
+		sec_dai->lock = &pri_dai->spinlock;
 		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.ch_name = "tx-sec";
-- 
1.7.9.5
