From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: [RFC PATCH 1/3] ASoC: pcm1792a: Rename internal data and function to pcm179x
Date: Sun, 10 Jan 2016 00:38:03 +0100
Message-ID: <1452382685-18009-2-git-send-email-michael@amarulasolutions.com>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452382685-18009-1-git-send-email-michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
---
 sound/soc/codecs/pcm1792a.c | 158 ++++++++++++++++++++++----------------------
 sound/soc/codecs/pcm1792a.h |   6 +-
 2 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 08bb486..a56c7b7 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -1,5 +1,5 @@
 /*
- * PCM1792A ASoC codec driver
+ * PCM179X ASoC codec driver
  *
  * Copyright (c) Amarula Solutions B.V. 2013
  *
@@ -31,21 +31,21 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include "pcm1792a.h"
+#include "pcm179x.h"
 
-#define PCM1792A_DAC_VOL_LEFT	0x10
-#define PCM1792A_DAC_VOL_RIGHT	0x11
-#define PCM1792A_FMT_CONTROL	0x12
-#define PCM1792A_MODE_CONTROL	0x13
-#define PCM1792A_SOFT_MUTE	PCM1792A_FMT_CONTROL
+#define PCM179X_DAC_VOL_LEFT	0x10
+#define PCM179X_DAC_VOL_RIGHT	0x11
+#define PCM179X_FMT_CONTROL	0x12
+#define PCM179X_MODE_CONTROL	0x13
+#define PCM179X_SOFT_MUTE	PCM179X_FMT_CONTROL
 
-#define PCM1792A_FMT_MASK	0x70
-#define PCM1792A_FMT_SHIFT	4
-#define PCM1792A_MUTE_MASK	0x01
-#define PCM1792A_MUTE_SHIFT	0
-#define PCM1792A_ATLD_ENABLE	(1 << 7)
+#define PCM179X_FMT_MASK	0x70
+#define PCM179X_FMT_SHIFT	4
+#define PCM179X_MUTE_MASK	0x01
+#define PCM179X_MUTE_SHIFT	0
+#define PCM179X_ATLD_ENABLE	(1 << 7)
 
-static const struct reg_default pcm1792a_reg_defaults[] = {
+static const struct reg_default pcm179x_reg_defaults[] = {
 	{ 0x10, 0xff },
 	{ 0x11, 0xff },
 	{ 0x12, 0x50 },
@@ -56,57 +56,57 @@ static const struct reg_default pcm1792a_reg_defaults[] = {
 	{ 0x17, 0x00 },
 };
 
-static bool pcm1792a_accessible_reg(struct device *dev, unsigned int reg)
+static bool pcm179x_accessible_reg(struct device *dev, unsigned int reg)
 {
 	return reg >= 0x10 && reg <= 0x17;
 }
 
-static bool pcm1792a_writeable_reg(struct device *dev, unsigned register reg)
+static bool pcm179x_writeable_reg(struct device *dev, unsigned register reg)
 {
 	bool accessible;
 
-	accessible = pcm1792a_accessible_reg(dev, reg);
+	accessible = pcm179x_accessible_reg(dev, reg);
 
 	return accessible && reg != 0x16 && reg != 0x17;
 }
 
-struct pcm1792a_private {
+struct pcm179x_private {
 	struct regmap *regmap;
 	unsigned int format;
 	unsigned int rate;
 };
 
-static int pcm1792a_set_dai_fmt(struct snd_soc_dai *codec_dai,
+static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
                              unsigned int format)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
 
 	priv->format = format;
 
 	return 0;
 }
 
-static int pcm1792a_digital_mute(struct snd_soc_dai *dai, int mute)
+static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
-				 PCM1792A_MUTE_MASK, !!mute);
+	ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
+				 PCM179X_MUTE_MASK, !!mute);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
+static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
 	int val = 0, ret;
 
 	priv->rate = params_rate(params);
@@ -143,129 +143,129 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	val = val << PCM1792A_FMT_SHIFT | PCM1792A_ATLD_ENABLE;
+	val = val << PCM179X_FMT_SHIFT | PCM179X_ATLD_ENABLE;
 
-	ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
-				 PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
+	ret = regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
+				 PCM179X_FMT_MASK | PCM179X_ATLD_ENABLE, val);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
-	.set_fmt	= pcm1792a_set_dai_fmt,
-	.hw_params	= pcm1792a_hw_params,
-	.digital_mute	= pcm1792a_digital_mute,
+static const struct snd_soc_dai_ops pcm179x_dai_ops = {
+	.set_fmt	= pcm179x_set_dai_fmt,
+	.hw_params	= pcm179x_hw_params,
+	.digital_mute	= pcm179x_digital_mute,
 };
 
-static const DECLARE_TLV_DB_SCALE(pcm1792a_dac_tlv, -12000, 50, 1);
+static const DECLARE_TLV_DB_SCALE(pcm179x_dac_tlv, -12000, 50, 1);
 
-static const struct snd_kcontrol_new pcm1792a_controls[] = {
-	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM1792A_DAC_VOL_LEFT,
-			 PCM1792A_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
-			 pcm1792a_dac_tlv),
-	SOC_SINGLE("DAC Invert Output Switch", PCM1792A_MODE_CONTROL, 7, 1, 0),
-	SOC_SINGLE("DAC Rolloff Filter Switch", PCM1792A_MODE_CONTROL, 1, 1, 0),
+static const struct snd_kcontrol_new pcm179x_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM179X_DAC_VOL_LEFT,
+			 PCM179X_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
+			 pcm179x_dac_tlv),
+	SOC_SINGLE("DAC Invert Output Switch", PCM179X_MODE_CONTROL, 7, 1, 0),
+	SOC_SINGLE("DAC Rolloff Filter Switch", PCM179X_MODE_CONTROL, 1, 1, 0),
 };
 
-static const struct snd_soc_dapm_widget pcm1792a_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget pcm179x_dapm_widgets[] = {
 SND_SOC_DAPM_OUTPUT("IOUTL+"),
 SND_SOC_DAPM_OUTPUT("IOUTL-"),
 SND_SOC_DAPM_OUTPUT("IOUTR+"),
 SND_SOC_DAPM_OUTPUT("IOUTR-"),
 };
 
-static const struct snd_soc_dapm_route pcm1792a_dapm_routes[] = {
+static const struct snd_soc_dapm_route pcm179x_dapm_routes[] = {
 	{ "IOUTL+", NULL, "Playback" },
 	{ "IOUTL-", NULL, "Playback" },
 	{ "IOUTR+", NULL, "Playback" },
 	{ "IOUTR-", NULL, "Playback" },
 };
 
-static struct snd_soc_dai_driver pcm1792a_dai = {
-	.name = "pcm1792a-hifi",
+static struct snd_soc_dai_driver pcm179x_dai = {
+	.name = "pcm179x-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = PCM1792A_RATES,
 		.formats = PCM1792A_FORMATS, },
-	.ops = &pcm1792a_dai_ops,
+	.ops = &pcm179x_dai_ops,
 };
 
-static const struct of_device_id pcm1792a_of_match[] = {
+static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, pcm1792a_of_match);
+MODULE_DEVICE_TABLE(of, pcm179x_of_match);
 
-static const struct regmap_config pcm1792a_regmap = {
+static const struct regmap_config pcm179x_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 	.max_register		= 23,
-	.reg_defaults		= pcm1792a_reg_defaults,
-	.num_reg_defaults	= ARRAY_SIZE(pcm1792a_reg_defaults),
-	.writeable_reg		= pcm1792a_writeable_reg,
-	.readable_reg		= pcm1792a_accessible_reg,
+	.reg_defaults		= pcm179x_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(pcm179x_reg_defaults),
+	.writeable_reg		= pcm179x_writeable_reg,
+	.readable_reg		= pcm179x_accessible_reg,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_pcm1792a = {
-	.controls		= pcm1792a_controls,
-	.num_controls		= ARRAY_SIZE(pcm1792a_controls),
-	.dapm_widgets		= pcm1792a_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(pcm1792a_dapm_widgets),
-	.dapm_routes		= pcm1792a_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(pcm1792a_dapm_routes),
+static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
+	.controls		= pcm179x_controls,
+	.num_controls		= ARRAY_SIZE(pcm179x_controls),
+	.dapm_widgets		= pcm179x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm179x_dapm_widgets),
+	.dapm_routes		= pcm179x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
 };
 
-static int pcm1792a_spi_probe(struct spi_device *spi)
+static int pcm179x_spi_probe(struct spi_device *spi)
 {
-	struct pcm1792a_private *pcm1792a;
+	struct pcm179x_private *pcm179x;
 	int ret;
 
-	pcm1792a = devm_kzalloc(&spi->dev, sizeof(struct pcm1792a_private),
+	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
 				GFP_KERNEL);
-	if (!pcm1792a)
+	if (!pcm179x)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, pcm1792a);
+	spi_set_drvdata(spi, pcm179x);
 
-	pcm1792a->regmap = devm_regmap_init_spi(spi, &pcm1792a_regmap);
-	if (IS_ERR(pcm1792a->regmap)) {
-		ret = PTR_ERR(pcm1792a->regmap);
+	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
+	if (IS_ERR(pcm179x->regmap)) {
+		ret = PTR_ERR(pcm179x->regmap);
 		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
 		return ret;
 	}
 
 	return snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_pcm1792a, &pcm1792a_dai, 1);
+			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
 }
 
-static int pcm1792a_spi_remove(struct spi_device *spi)
+static int pcm179x_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
 }
 
-static const struct spi_device_id pcm1792a_spi_ids[] = {
-	{ "pcm1792a", 0 },
+static const struct spi_device_id pcm179x_spi_ids[] = {
+	{ "pcm179x", 0 },
 	{ },
 };
-MODULE_DEVICE_TABLE(spi, pcm1792a_spi_ids);
+MODULE_DEVICE_TABLE(spi, pcm179x_spi_ids);
 
-static struct spi_driver pcm1792a_codec_driver = {
+static struct spi_driver pcm179x_codec_driver = {
 	.driver = {
-		.name = "pcm1792a",
-		.of_match_table = of_match_ptr(pcm1792a_of_match),
+		.name = "pcm179x",
+		.of_match_table = of_match_ptr(pcm179x_of_match),
 	},
-	.id_table = pcm1792a_spi_ids,
-	.probe = pcm1792a_spi_probe,
-	.remove = pcm1792a_spi_remove,
+	.id_table = pcm179x_spi_ids,
+	.probe = pcm179x_spi_probe,
+	.remove = pcm179x_spi_remove,
 };
 
-module_spi_driver(pcm1792a_codec_driver);
+module_spi_driver(pcm179x_codec_driver);
 
-MODULE_DESCRIPTION("ASoC PCM1792A driver");
+MODULE_DESCRIPTION("ASoC PCM179X driver");
 MODULE_AUTHOR("Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm1792a.h b/sound/soc/codecs/pcm1792a.h
index 51d5470..c6fdc06 100644
--- a/sound/soc/codecs/pcm1792a.h
+++ b/sound/soc/codecs/pcm1792a.h
@@ -1,5 +1,5 @@
 /*
- * definitions for PCM1792A
+ * definitions for PCM179X
  *
  * Copyright 2013 Amarula Solutions
  *
@@ -14,8 +14,8 @@
  * GNU General Public License for more details.
  */
 
-#ifndef __PCM1792A_H__
-#define __PCM1792A_H__
+#ifndef __PCM179X_H__
+#define __PCM179X_H__
 
 #define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
 			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
