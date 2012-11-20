From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/10] ASoC: kirkwood-i2s: fix DMA underruns
Date: Tue, 20 Nov 2012 12:18:52 +0000
Message-ID: <E1Tammy-0007XF-Jx@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 05C9326536D
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:18:55 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

Stress testing the driver with multiple start/stop events causes
kirkwood-dma to report underrun errors (which used to cause the kernel
to lock up solidly).  This is because kirkwood-i2s is not respecting
the restrictions imposed on clearing the 'pause' bit.  Follow what the
spec says; the busy bit must be read as being clear twice before the
pause bit can be released.  This solves the underruns.

However, it has been noticed that the busy bit occasionally does not
clear itself, hence the waiting is bounded to 5ms maximum to avoid a
new reason for the kernel to lockup.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   67 +++++++++++++++++++++----------------
 1 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 485af80..826306d 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -180,67 +180,76 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
-	unsigned long value;
-
-	/*
-	 * specs says KIRKWOOD_PLAYCTL must be read 2 times before
-	 * changing it. So read 1 time here and 1 later.
-	 */
-	value = readl(priv->io + KIRKWOOD_PLAYCTL);
+	uint32_t ctl, value;
+
+	ctl = readl(priv->io + KIRKWOOD_PLAYCTL);
+	if (ctl & KIRKWOOD_PLAYCTL_PAUSE) {
+		unsigned timeout = 5000;
+		/*
+		 * The Armada510 spec says that if we enter pause mode, the
+		 * busy bit must be read back as clear _twice_.  Make sure
+		 * we respect that otherwise we get DMA underruns.
+		 */
+		do {
+			value = ctl;
+			ctl = readl(priv->io + KIRKWOOD_PLAYCTL);
+			if (!((ctl | value) & KIRKWOOD_PLAYCTL_PLAY_BUSY))
+				break;
+			udelay(1);
+		} while (timeout--);
+
+		if ((ctl | value) & KIRKWOOD_PLAYCTL_PLAY_BUSY)
+			dev_notice(dai->dev, "timed out waiting for busy to deassert: %08x\n",
+				   ctl);
+	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* stop audio, enable interrupts */
-		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value |= KIRKWOOD_PLAYCTL_PAUSE;
-		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE;
+		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
 		value |= KIRKWOOD_INT_CAUSE_PLAY_BYTES;
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
 		/* configure audio & enable i2s playback */
-		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value &= ~KIRKWOOD_PLAYCTL_BURST_MASK;
-		value &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE
+		ctl &= ~KIRKWOOD_PLAYCTL_BURST_MASK;
+		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE
 				| KIRKWOOD_PLAYCTL_SPDIF_EN);
 
 		if (priv->burst == 32)
-			value |= KIRKWOOD_PLAYCTL_BURST_32;
+			ctl |= KIRKWOOD_PLAYCTL_BURST_32;
 		else
-			value |= KIRKWOOD_PLAYCTL_BURST_128;
-		value |= KIRKWOOD_PLAYCTL_I2S_EN;
-		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+			ctl |= KIRKWOOD_PLAYCTL_BURST_128;
+		ctl |= KIRKWOOD_PLAYCTL_I2S_EN;
+		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
-		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
-		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
 		value &= ~KIRKWOOD_INT_CAUSE_PLAY_BYTES;
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
 		/* disable all playbacks */
-		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value &= ~(KIRKWOOD_PLAYCTL_I2S_EN | KIRKWOOD_PLAYCTL_SPDIF_EN);
-		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		ctl &= ~(KIRKWOOD_PLAYCTL_I2S_EN | KIRKWOOD_PLAYCTL_SPDIF_EN);
+		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
-		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
-		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
+		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	default:
-- 
1.7.4.4
