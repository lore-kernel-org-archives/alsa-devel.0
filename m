From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: [RFC PATCH 2/3] ASoC: pcm1792a: Rename pcm1792a to pcm179x
Date: Sun, 10 Jan 2016 00:38:04 +0100
Message-ID: <1452382685-18009-3-git-send-email-michael@amarulasolutions.com>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452382685-18009-1-git-send-email-michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

pcm1792a is compatible with pcm1795 and pcm1796 so it's
better to have them under the common name pcm179x

Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
---
 .../devicetree/bindings/sound/pcm1792a.txt         |  18 --
 .../devicetree/bindings/sound/pcm179x.txt          |  18 ++
 sound/soc/codecs/Kconfig                           |   6 +-
 sound/soc/codecs/Makefile                          |   4 +-
 sound/soc/codecs/pcm1792a.c                        | 271 ---------------------
 sound/soc/codecs/pcm1792a.h                        |  27 --
 sound/soc/codecs/pcm179x.c                         | 271 +++++++++++++++++++++
 sound/soc/codecs/pcm179x.h                         |  27 ++
 8 files changed, 321 insertions(+), 321 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm1792a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm179x.txt
 delete mode 100644 sound/soc/codecs/pcm1792a.c
 delete mode 100644 sound/soc/codecs/pcm1792a.h
 create mode 100644 sound/soc/codecs/pcm179x.c
 create mode 100644 sound/soc/codecs/pcm179x.h

diff --git a/Documentation/devicetree/bindings/sound/pcm1792a.txt b/Documentation/devicetree/bindings/sound/pcm1792a.txt
deleted file mode 100644
index 970ba1e..0000000
--- a/Documentation/devicetree/bindings/sound/pcm1792a.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Texas Instruments pcm1792a DT bindings
-
-This driver supports the SPI bus.
-
-Required properties:
-
- - compatible: "ti,pcm1792a"
-
-For required properties on SPI, please consult
-Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Examples:
-
-	codec_spi: 1792a@0 {
-		compatible = "ti,pcm1792a";
-		spi-max-frequency = <600000>;
-	};
-
diff --git a/Documentation/devicetree/bindings/sound/pcm179x.txt b/Documentation/devicetree/bindings/sound/pcm179x.txt
new file mode 100644
index 0000000..4ae70d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm179x.txt
@@ -0,0 +1,18 @@
+Texas Instruments pcm179x DT bindings
+
+This driver supports the SPI bus.
+
+Required properties:
+
+ - compatible: "ti,pcm1792a"
+
+For required properties on SPI, please consult
+Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Examples:
+
+	codec_spi: 1792a@0 {
+		compatible = "ti,pcm1792a";
+		spi-max-frequency = <600000>;
+	};
+
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733e..eaa3af7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -81,7 +81,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ML26124 if I2C
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM1681 if I2C
-	select SND_SOC_PCM1792A if SPI_MASTER
+	select SND_SOC_PCM179X if SPI_MASTER
 	select SND_SOC_PCM3008
 	select SND_SOC_PCM512x_I2C if I2C
 	select SND_SOC_PCM512x_SPI if SPI_MASTER
@@ -490,8 +490,8 @@ config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
 
-config SND_SOC_PCM1792A
-	tristate "Texas Instruments PCM1792A CODEC"
+config SND_SOC_PCM179X
+	tristate "Texas Instruments PCM179X CODEC"
 	depends on SPI_MASTER
 
 config SND_SOC_PCM3008
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4a32077..35d6c1a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -74,7 +74,7 @@ snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
 snd-soc-hdmi-codec-objs := hdmi.o
 snd-soc-pcm1681-objs := pcm1681.o
-snd-soc-pcm1792a-codec-objs := pcm1792a.o
+snd-soc-pcm179x-codec-objs := pcm179x.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
@@ -266,7 +266,7 @@ obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
-obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
+obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
deleted file mode 100644
index a56c7b7..0000000
--- a/sound/soc/codecs/pcm1792a.c
+++ /dev/null
@@ -1,271 +0,0 @@
-/*
- * PCM179X ASoC codec driver
- *
- * Copyright (c) Amarula Solutions B.V. 2013
- *
- *     Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-#include <sound/tlv.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-
-#include "pcm179x.h"
-
-#define PCM179X_DAC_VOL_LEFT	0x10
-#define PCM179X_DAC_VOL_RIGHT	0x11
-#define PCM179X_FMT_CONTROL	0x12
-#define PCM179X_MODE_CONTROL	0x13
-#define PCM179X_SOFT_MUTE	PCM179X_FMT_CONTROL
-
-#define PCM179X_FMT_MASK	0x70
-#define PCM179X_FMT_SHIFT	4
-#define PCM179X_MUTE_MASK	0x01
-#define PCM179X_MUTE_SHIFT	0
-#define PCM179X_ATLD_ENABLE	(1 << 7)
-
-static const struct reg_default pcm179x_reg_defaults[] = {
-	{ 0x10, 0xff },
-	{ 0x11, 0xff },
-	{ 0x12, 0x50 },
-	{ 0x13, 0x00 },
-	{ 0x14, 0x00 },
-	{ 0x15, 0x01 },
-	{ 0x16, 0x00 },
-	{ 0x17, 0x00 },
-};
-
-static bool pcm179x_accessible_reg(struct device *dev, unsigned int reg)
-{
-	return reg >= 0x10 && reg <= 0x17;
-}
-
-static bool pcm179x_writeable_reg(struct device *dev, unsigned register reg)
-{
-	bool accessible;
-
-	accessible = pcm179x_accessible_reg(dev, reg);
-
-	return accessible && reg != 0x16 && reg != 0x17;
-}
-
-struct pcm179x_private {
-	struct regmap *regmap;
-	unsigned int format;
-	unsigned int rate;
-};
-
-static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
-                             unsigned int format)
-{
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
-
-	priv->format = format;
-
-	return 0;
-}
-
-static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
-				 PCM179X_MUTE_MASK, !!mute);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int pcm179x_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
-	int val = 0, ret;
-
-	priv->rate = params_rate(params);
-
-	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_RIGHT_J:
-		switch (params_width(params)) {
-		case 24:
-		case 32:
-			val = 2;
-			break;
-		case 16:
-			val = 0;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case SND_SOC_DAIFMT_I2S:
-		switch (params_width(params)) {
-		case 24:
-		case 32:
-			val = 5;
-			break;
-		case 16:
-			val = 4;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	default:
-		dev_err(codec->dev, "Invalid DAI format\n");
-		return -EINVAL;
-	}
-
-	val = val << PCM179X_FMT_SHIFT | PCM179X_ATLD_ENABLE;
-
-	ret = regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
-				 PCM179X_FMT_MASK | PCM179X_ATLD_ENABLE, val);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static const struct snd_soc_dai_ops pcm179x_dai_ops = {
-	.set_fmt	= pcm179x_set_dai_fmt,
-	.hw_params	= pcm179x_hw_params,
-	.digital_mute	= pcm179x_digital_mute,
-};
-
-static const DECLARE_TLV_DB_SCALE(pcm179x_dac_tlv, -12000, 50, 1);
-
-static const struct snd_kcontrol_new pcm179x_controls[] = {
-	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM179X_DAC_VOL_LEFT,
-			 PCM179X_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
-			 pcm179x_dac_tlv),
-	SOC_SINGLE("DAC Invert Output Switch", PCM179X_MODE_CONTROL, 7, 1, 0),
-	SOC_SINGLE("DAC Rolloff Filter Switch", PCM179X_MODE_CONTROL, 1, 1, 0),
-};
-
-static const struct snd_soc_dapm_widget pcm179x_dapm_widgets[] = {
-SND_SOC_DAPM_OUTPUT("IOUTL+"),
-SND_SOC_DAPM_OUTPUT("IOUTL-"),
-SND_SOC_DAPM_OUTPUT("IOUTR+"),
-SND_SOC_DAPM_OUTPUT("IOUTR-"),
-};
-
-static const struct snd_soc_dapm_route pcm179x_dapm_routes[] = {
-	{ "IOUTL+", NULL, "Playback" },
-	{ "IOUTL-", NULL, "Playback" },
-	{ "IOUTR+", NULL, "Playback" },
-	{ "IOUTR-", NULL, "Playback" },
-};
-
-static struct snd_soc_dai_driver pcm179x_dai = {
-	.name = "pcm179x-hifi",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = PCM1792A_RATES,
-		.formats = PCM1792A_FORMATS, },
-	.ops = &pcm179x_dai_ops,
-};
-
-static const struct of_device_id pcm179x_of_match[] = {
-	{ .compatible = "ti,pcm1792a", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pcm179x_of_match);
-
-static const struct regmap_config pcm179x_regmap = {
-	.reg_bits		= 8,
-	.val_bits		= 8,
-	.max_register		= 23,
-	.reg_defaults		= pcm179x_reg_defaults,
-	.num_reg_defaults	= ARRAY_SIZE(pcm179x_reg_defaults),
-	.writeable_reg		= pcm179x_writeable_reg,
-	.readable_reg		= pcm179x_accessible_reg,
-};
-
-static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
-	.controls		= pcm179x_controls,
-	.num_controls		= ARRAY_SIZE(pcm179x_controls),
-	.dapm_widgets		= pcm179x_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(pcm179x_dapm_widgets),
-	.dapm_routes		= pcm179x_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
-};
-
-static int pcm179x_spi_probe(struct spi_device *spi)
-{
-	struct pcm179x_private *pcm179x;
-	int ret;
-
-	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
-				GFP_KERNEL);
-	if (!pcm179x)
-		return -ENOMEM;
-
-	spi_set_drvdata(spi, pcm179x);
-
-	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
-	if (IS_ERR(pcm179x->regmap)) {
-		ret = PTR_ERR(pcm179x->regmap);
-		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
-		return ret;
-	}
-
-	return snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
-}
-
-static int pcm179x_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
-static const struct spi_device_id pcm179x_spi_ids[] = {
-	{ "pcm179x", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(spi, pcm179x_spi_ids);
-
-static struct spi_driver pcm179x_codec_driver = {
-	.driver = {
-		.name = "pcm179x",
-		.of_match_table = of_match_ptr(pcm179x_of_match),
-	},
-	.id_table = pcm179x_spi_ids,
-	.probe = pcm179x_spi_probe,
-	.remove = pcm179x_spi_remove,
-};
-
-module_spi_driver(pcm179x_codec_driver);
-
-MODULE_DESCRIPTION("ASoC PCM179X driver");
-MODULE_AUTHOR("Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm1792a.h b/sound/soc/codecs/pcm1792a.h
deleted file mode 100644
index c6fdc06..0000000
--- a/sound/soc/codecs/pcm1792a.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * definitions for PCM179X
- *
- * Copyright 2013 Amarula Solutions
- *
-  * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __PCM179X_H__
-#define __PCM179X_H__
-
-#define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-			SNDRV_PCM_RATE_192000)
-
-#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
-			  SNDRV_PCM_FMTBIT_S16_LE)
-
-#endif
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
new file mode 100644
index 0000000..a56c7b7
--- /dev/null
+++ b/sound/soc/codecs/pcm179x.c
@@ -0,0 +1,271 @@
+/*
+ * PCM179X ASoC codec driver
+ *
+ * Copyright (c) Amarula Solutions B.V. 2013
+ *
+ *     Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "pcm179x.h"
+
+#define PCM179X_DAC_VOL_LEFT	0x10
+#define PCM179X_DAC_VOL_RIGHT	0x11
+#define PCM179X_FMT_CONTROL	0x12
+#define PCM179X_MODE_CONTROL	0x13
+#define PCM179X_SOFT_MUTE	PCM179X_FMT_CONTROL
+
+#define PCM179X_FMT_MASK	0x70
+#define PCM179X_FMT_SHIFT	4
+#define PCM179X_MUTE_MASK	0x01
+#define PCM179X_MUTE_SHIFT	0
+#define PCM179X_ATLD_ENABLE	(1 << 7)
+
+static const struct reg_default pcm179x_reg_defaults[] = {
+	{ 0x10, 0xff },
+	{ 0x11, 0xff },
+	{ 0x12, 0x50 },
+	{ 0x13, 0x00 },
+	{ 0x14, 0x00 },
+	{ 0x15, 0x01 },
+	{ 0x16, 0x00 },
+	{ 0x17, 0x00 },
+};
+
+static bool pcm179x_accessible_reg(struct device *dev, unsigned int reg)
+{
+	return reg >= 0x10 && reg <= 0x17;
+}
+
+static bool pcm179x_writeable_reg(struct device *dev, unsigned register reg)
+{
+	bool accessible;
+
+	accessible = pcm179x_accessible_reg(dev, reg);
+
+	return accessible && reg != 0x16 && reg != 0x17;
+}
+
+struct pcm179x_private {
+	struct regmap *regmap;
+	unsigned int format;
+	unsigned int rate;
+};
+
+static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
+                             unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->format = format;
+
+	return 0;
+}
+
+static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
+				 PCM179X_MUTE_MASK, !!mute);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int pcm179x_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	int val = 0, ret;
+
+	priv->rate = params_rate(params);
+
+	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (params_width(params)) {
+		case 24:
+		case 32:
+			val = 2;
+			break;
+		case 16:
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		switch (params_width(params)) {
+		case 24:
+		case 32:
+			val = 5;
+			break;
+		case 16:
+			val = 4;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(codec->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	val = val << PCM179X_FMT_SHIFT | PCM179X_ATLD_ENABLE;
+
+	ret = regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
+				 PCM179X_FMT_MASK | PCM179X_ATLD_ENABLE, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops pcm179x_dai_ops = {
+	.set_fmt	= pcm179x_set_dai_fmt,
+	.hw_params	= pcm179x_hw_params,
+	.digital_mute	= pcm179x_digital_mute,
+};
+
+static const DECLARE_TLV_DB_SCALE(pcm179x_dac_tlv, -12000, 50, 1);
+
+static const struct snd_kcontrol_new pcm179x_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM179X_DAC_VOL_LEFT,
+			 PCM179X_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
+			 pcm179x_dac_tlv),
+	SOC_SINGLE("DAC Invert Output Switch", PCM179X_MODE_CONTROL, 7, 1, 0),
+	SOC_SINGLE("DAC Rolloff Filter Switch", PCM179X_MODE_CONTROL, 1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget pcm179x_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("IOUTL+"),
+SND_SOC_DAPM_OUTPUT("IOUTL-"),
+SND_SOC_DAPM_OUTPUT("IOUTR+"),
+SND_SOC_DAPM_OUTPUT("IOUTR-"),
+};
+
+static const struct snd_soc_dapm_route pcm179x_dapm_routes[] = {
+	{ "IOUTL+", NULL, "Playback" },
+	{ "IOUTL-", NULL, "Playback" },
+	{ "IOUTR+", NULL, "Playback" },
+	{ "IOUTR-", NULL, "Playback" },
+};
+
+static struct snd_soc_dai_driver pcm179x_dai = {
+	.name = "pcm179x-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = PCM1792A_RATES,
+		.formats = PCM1792A_FORMATS, },
+	.ops = &pcm179x_dai_ops,
+};
+
+static const struct of_device_id pcm179x_of_match[] = {
+	{ .compatible = "ti,pcm1792a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm179x_of_match);
+
+static const struct regmap_config pcm179x_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= 23,
+	.reg_defaults		= pcm179x_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(pcm179x_reg_defaults),
+	.writeable_reg		= pcm179x_writeable_reg,
+	.readable_reg		= pcm179x_accessible_reg,
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
+	.controls		= pcm179x_controls,
+	.num_controls		= ARRAY_SIZE(pcm179x_controls),
+	.dapm_widgets		= pcm179x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm179x_dapm_widgets),
+	.dapm_routes		= pcm179x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
+};
+
+static int pcm179x_spi_probe(struct spi_device *spi)
+{
+	struct pcm179x_private *pcm179x;
+	int ret;
+
+	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
+				GFP_KERNEL);
+	if (!pcm179x)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, pcm179x);
+
+	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
+	if (IS_ERR(pcm179x->regmap)) {
+		ret = PTR_ERR(pcm179x->regmap);
+		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
+}
+
+static int pcm179x_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static const struct spi_device_id pcm179x_spi_ids[] = {
+	{ "pcm179x", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, pcm179x_spi_ids);
+
+static struct spi_driver pcm179x_codec_driver = {
+	.driver = {
+		.name = "pcm179x",
+		.of_match_table = of_match_ptr(pcm179x_of_match),
+	},
+	.id_table = pcm179x_spi_ids,
+	.probe = pcm179x_spi_probe,
+	.remove = pcm179x_spi_remove,
+};
+
+module_spi_driver(pcm179x_codec_driver);
+
+MODULE_DESCRIPTION("ASoC PCM179X driver");
+MODULE_AUTHOR("Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
new file mode 100644
index 0000000..c6fdc06
--- /dev/null
+++ b/sound/soc/codecs/pcm179x.h
@@ -0,0 +1,27 @@
+/*
+ * definitions for PCM179X
+ *
+ * Copyright 2013 Amarula Solutions
+ *
+  * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __PCM179X_H__
+#define __PCM179X_H__
+
+#define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
+			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
+			SNDRV_PCM_RATE_192000)
+
+#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+			  SNDRV_PCM_FMTBIT_S16_LE)
+
+#endif
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
