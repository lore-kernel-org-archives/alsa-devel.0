From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 07/10] ASoC: kirkwood-i2s: better handling of
 play/record control registers
Date: Tue, 20 Nov 2012 12:19:53 +0000
Message-ID: <E1Tamnx-0007XY-Pd@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1DCBB26538B
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:19:56 +0100 (CET)
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

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |  112 ++++++++++++++++++++++++-------------
 sound/soc/kirkwood/kirkwood.h     |    2 +
 2 files changed, 74 insertions(+), 40 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index f059f40..823ef1e 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -113,15 +113,14 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
-	unsigned int i2s_reg, reg;
-	unsigned long i2s_value, value;
+	uint32_t ctl_play, ctl_rec;
+	unsigned int i2s_reg;
+	unsigned long i2s_value;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		i2s_reg = KIRKWOOD_I2S_PLAYCTL;
-		reg = KIRKWOOD_PLAYCTL;
 	} else {
 		i2s_reg = KIRKWOOD_I2S_RECCTL;
-		reg = KIRKWOOD_RECCTL;
 	}
 
 	/* set dco conf */
@@ -130,9 +129,6 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	i2s_value = readl(priv->io+i2s_reg);
 	i2s_value &= ~KIRKWOOD_I2S_CTL_SIZE_MASK;
 
-	value = readl(priv->io+reg);
-	value &= ~KIRKWOOD_PLAYCTL_SIZE_MASK;
-
 	/*
 	 * Size settings in play/rec i2s control regs and play/rec control
 	 * regs must be the same.
@@ -140,38 +136,57 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
-		value |= KIRKWOOD_PLAYCTL_SIZE_16_C;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C |
+			   KIRKWOOD_PLAYCTL_I2S_EN;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C |
+			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
 	/*
 	 * doesn't work... S20_3LE != kirkwood 20bit format ?
 	 *
 	case SNDRV_PCM_FORMAT_S20_3LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_20;
-		value |= KIRKWOOD_PLAYCTL_SIZE_20;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_20 |
+			   KIRKWOOD_PLAYCTL_I2S_EN;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_20 |
+			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
 	*/
 	case SNDRV_PCM_FORMAT_S24_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_24;
-		value |= KIRKWOOD_PLAYCTL_SIZE_24;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 |
+			   KIRKWOOD_PLAYCTL_I2S_EN;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 |
+			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_32;
-		value |= KIRKWOOD_PLAYCTL_SIZE_32;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_32 |
+			   KIRKWOOD_PLAYCTL_I2S_EN;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_32 |
+			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		value &= ~KIRKWOOD_PLAYCTL_MONO_MASK;
 		if (params_channels(params) == 1)
-			value |= KIRKWOOD_PLAYCTL_MONO_BOTH;
+			ctl_play |= KIRKWOOD_PLAYCTL_MONO_BOTH;
 		else
-			value |= KIRKWOOD_PLAYCTL_MONO_OFF;
+			ctl_play |= KIRKWOOD_PLAYCTL_MONO_OFF;
+
+		priv->ctl_play &= ~(KIRKWOOD_PLAYCTL_MONO_MASK |
+				    KIRKWOOD_PLAYCTL_I2S_EN |
+				    KIRKWOOD_PLAYCTL_SPDIF_EN |
+				    KIRKWOOD_PLAYCTL_SIZE_MASK);
+		priv->ctl_play |= ctl_play;
+	} else {
+		priv->ctl_rec &= ~KIRKWOOD_RECCTL_SIZE_MASK;
+		priv->ctl_rec |= ctl_rec;
 	}
 
 	writel(i2s_value, priv->io+i2s_reg);
-	writel(value, priv->io+reg);
 
 	return 0;
 }
@@ -205,20 +220,18 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		/* configure */
+		ctl = priv->ctl_play;
+		value = ctl & ~(KIRKWOOD_PLAYCTL_I2S_EN |
+				KIRKWOOD_PLAYCTL_SPDIF_EN);
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+
+		/* enable interrupts */
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
 		value |= KIRKWOOD_INT_CAUSE_PLAY_BYTES;
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
-		/* configure audio & enable i2s playback */
-		ctl &= ~KIRKWOOD_PLAYCTL_BURST_MASK;
-		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE
-				| KIRKWOOD_PLAYCTL_SPDIF_EN);
-
-		if (priv->burst == 32)
-			ctl |= KIRKWOOD_PLAYCTL_BURST_32;
-		else
-			ctl |= KIRKWOOD_PLAYCTL_BURST_128;
-		ctl |= KIRKWOOD_PLAYCTL_I2S_EN;
+		/* enable playback */
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
@@ -259,30 +272,24 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
-	unsigned long value;
+	uint32_t ctl, value;
 
 	value = readl(priv->io + KIRKWOOD_RECCTL);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		/* configure */
+		ctl = priv->ctl_rec;
+		value = ctl & ~KIRKWOOD_RECCTL_I2S_EN;
+		writel(value, priv->io + KIRKWOOD_RECCTL);
+
+		/* enable interrupts */
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
 		value |= KIRKWOOD_INT_CAUSE_REC_BYTES;
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
-		/* configure audio & enable i2s record */
-		value = readl(priv->io + KIRKWOOD_RECCTL);
-		value &= ~KIRKWOOD_RECCTL_BURST_MASK;
-		value &= ~KIRKWOOD_RECCTL_MONO;
-		value &= ~(KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_MUTE
-			| KIRKWOOD_RECCTL_SPDIF_EN);
-
-		if (priv->burst == 32)
-			value |= KIRKWOOD_RECCTL_BURST_32;
-		else
-			value |= KIRKWOOD_RECCTL_BURST_128;
-		value |= KIRKWOOD_RECCTL_I2S_EN;
-
-		writel(value, priv->io + KIRKWOOD_RECCTL);
+		/* enable record */
+		writel(ctl, priv->io + KIRKWOOD_RECCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -448,6 +455,31 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	priv->extclk = clk_get(&pdev->dev, "extclk");
+	if (!IS_ERR(priv->extclk)) {
+		if (priv->extclk == priv->clk) {
+			clk_put(priv->extclk);
+			priv->extclk = ERR_PTR(-EINVAL);
+		} else {
+			dev_info(&pdev->dev, "found external clock\n");
+			clk_prepare_enable(priv->extclk);
+			soc_dai = &kirkwood_i2s_dai_extclk;
+		}
+	}
+
+	/* Some sensible defaults - this reflects the powerup values */
+	priv->ctl_play = KIRKWOOD_PLAYCTL_SIZE_24;
+	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
+
+	/* Select the burst size */
+	if (data->burst == 32) {
+		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_32;
+		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_32;
+	} else {
+		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_128;
+		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_128;
+	}
+
 	err = snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
 	if (!err)
 		return 0;
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 7d92b9e..6e3b14a 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -120,6 +120,8 @@
 
 struct kirkwood_dma_data {
 	void __iomem *io;
+	uint32_t ctl_play;
+	uint32_t ctl_rec;
 	int irq;
 	int burst;
 	struct clk *clk;
-- 
1.7.4.4
