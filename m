From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 5/5] ASoC: es7134: add support for the es7154
Date: Fri, 29 Jun 2018 17:09:24 +0200
Message-ID: <20180629150924.18197-6-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add support for the es7154 which is basically an es7134 with an
embedded power amplifier and lower maximum sample rate

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 5ad59c38fed1..935bed820ba5 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -33,6 +33,7 @@ struct es7134_clock_mode {
 };
 
 struct es7134_chip {
+	struct snd_soc_dai_driver *dai_drv;
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
 };
@@ -159,6 +160,7 @@ static const struct es7134_clock_mode es7134_modes[] = {
 };
 
 static const struct es7134_chip es7134_chip = {
+	.dai_drv = &es7134_dai,
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
 };
@@ -189,6 +191,48 @@ static const struct snd_soc_component_driver es7134_component_driver = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static struct snd_soc_dai_driver es7154_dai = {
+	.name = "es7154-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000),
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
+			    SNDRV_PCM_FMTBIT_S18_3LE |
+			    SNDRV_PCM_FMTBIT_S20_3LE |
+			    SNDRV_PCM_FMTBIT_S24_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &es7134_dai_ops,
+};
+
+static const struct es7134_clock_mode es7154_modes[] = {
+	{
+		/* Single speed mode */
+		.rate_min = 8000,
+		.rate_max = 50000,
+		.mclk_fs = (unsigned int[]) { 32, 64, 128, 192, 256,
+					      384, 512, 768, 1024 },
+		.mclk_fs_num = 9,
+	}, {
+		/* Double speed mode */
+		.rate_min = 84000,
+		.rate_max = 100000,
+		.mclk_fs = (unsigned int[]) { 128, 192, 256, 384, 512,
+					      768, 1024},
+		.mclk_fs_num = 7,
+	}
+};
+
+static const struct es7134_chip es7154_chip = {
+	.dai_drv = &es7154_dai,
+	.modes = es7154_modes,
+	.mode_num = ARRAY_SIZE(es7154_modes),
+};
+
 static int es7134_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -207,13 +251,14 @@ static int es7134_probe(struct platform_device *pdev)
 
 	return devm_snd_soc_register_component(&pdev->dev,
 				      &es7134_component_driver,
-				      &es7134_dai, 1);
+				      priv->chip->dai_drv, 1);
 }
 
 #ifdef CONFIG_OF
 static const struct of_device_id es7134_ids[] = {
 	{ .compatible = "everest,es7134", .data = &es7134_chip },
 	{ .compatible = "everest,es7144", .data = &es7134_chip },
+	{ .compatible = "everest,es7154", .data = &es7154_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es7134_ids);
-- 
2.14.4
