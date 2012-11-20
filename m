From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 09/10] ASoC: kirkwood-i2s: add support for
 external clock rates
Date: Tue, 20 Nov 2012 12:20:34 +0000
Message-ID: <E1Tamoc-0007Xg-Lo@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 4DA7A26537C
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:20:37 +0100 (CET)
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

This is part of a patch found in Rabeeh Khoury's git tree for the
cubox, and cleaned up by me.

Some platforms provide an external clock which can be used to allow
other sample rates to be selected.  Provide support for this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   70 ++++++++++++++++++++++++++++++++----
 sound/soc/kirkwood/kirkwood.h     |    8 ++++-
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 823ef1e..d3629d5 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -99,6 +99,29 @@ static inline void kirkwood_set_dco(void __iomem *io, unsigned long rate)
 	} while (value == 0);
 }
 
+static void kirkwood_set_rate(struct snd_soc_dai *dai,
+	struct kirkwood_dma_data *priv, unsigned long rate)
+{
+	uint32_t clks_ctrl;
+
+	if (rate == 44100 || rate == 48000 || rate == 96000) {
+		/* use internal dco for supported rates */
+		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
+			__func__, rate);
+		kirkwood_set_dco(priv->io, rate);
+
+		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
+	} else if (!IS_ERR(priv->extclk)) {
+		/* use optional external clk for other rates */
+		dev_dbg(dai->dev, "%s: extclk set rate = %lu -> %lu\n",
+			__func__, rate, 256 * rate);
+		clk_set_rate(priv->extclk, 256 * rate);
+
+		clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
+	}
+	writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
+}
+
 static int kirkwood_i2s_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -123,8 +146,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 		i2s_reg = KIRKWOOD_I2S_RECCTL;
 	}
 
-	/* set dco conf */
-	kirkwood_set_dco(priv->io, params_rate(params));
+	kirkwood_set_rate(dai, priv, params_rate(params));
 
 	i2s_value = readl(priv->io+i2s_reg);
 	i2s_value &= ~KIRKWOOD_I2S_CTL_SIZE_MASK;
@@ -396,21 +418,45 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = KIRKWOOD_I2S_RATES,
-		.formats = KIRKWOOD_I2S_FORMATS,},
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = KIRKWOOD_I2S_RATES,
-		.formats = KIRKWOOD_I2S_FORMATS,},
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
+	.ops = &kirkwood_i2s_dai_ops,
+};
+
+static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
+	.probe = kirkwood_i2s_probe,
+	.remove = kirkwood_i2s_remove,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
 	.ops = &kirkwood_i2s_dai_ops,
 };
 
 static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
-	struct resource *mem;
-	struct kirkwood_asoc_platform_data *data =
-		pdev->dev.platform_data;
+	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
+	struct resource *mem;
 	int err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -480,11 +526,15 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_128;
 	}
 
-	err = snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
+	err = snd_soc_register_dai(&pdev->dev, soc_dai);
 	if (!err)
 		return 0;
 	dev_err(&pdev->dev, "snd_soc_register_dai failed\n");
 
+	if (!IS_ERR(priv->extclk)) {
+		clk_disable_unprepare(priv->extclk);
+		clk_put(priv->extclk);
+	}
 	clk_disable_unprepare(priv->clk);
 
 	return err;
@@ -496,6 +546,10 @@ static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_dai(&pdev->dev);
 
+	if (!IS_ERR(priv->extclk)) {
+		clk_disable_unprepare(priv->extclk);
+		clk_put(priv->extclk);
+	}
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 6e3b14a..4d92637 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -77,6 +77,11 @@
 #define KIRKWOOD_DCO_SPCR_STATUS		0x120c
 #define KIRKWOOD_DCO_SPCR_STATUS_DCO_LOCK	(1<<16)
 
+#define KIRKWOOD_CLOCKS_CTRL			0x1230
+#define KIRKWOOD_MCLK_SOURCE_MASK		(3<<0)
+#define KIRKWOOD_MCLK_SOURCE_DCO		(0<<0)
+#define KIRKWOOD_MCLK_SOURCE_EXTCLK		(3<<0)
+
 #define KIRKWOOD_ERR_CAUSE			0x1300
 #define KIRKWOOD_ERR_MASK			0x1304
 
@@ -120,11 +125,12 @@
 
 struct kirkwood_dma_data {
 	void __iomem *io;
+	struct clk *clk;
+	struct clk *extclk;
 	uint32_t ctl_play;
 	uint32_t ctl_rec;
 	int irq;
 	int burst;
-	struct clk *clk;
 };
 
 #endif
-- 
1.7.4.4
