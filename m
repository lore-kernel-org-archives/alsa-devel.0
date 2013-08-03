From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] ASoC: Add PCM1792A spi mode codec support
Date: Sat, 3 Aug 2013 16:20:43 +0200
Message-ID: <20130803142043.GA13830@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f172.google.com (mail-ea0-f172.google.com
 [209.85.215.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 153D4261647
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 16:20:48 +0200 (CEST)
Received: by mail-ea0-f172.google.com with SMTP id r16so814228ead.31
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 07:20:47 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add PCM1792A spi mode codec support. This version implements only
a subset of functionalities. Tested connect to a pandaboard ES
device and based on recently pcm1681 codec.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 .../devicetree/bindings/sound/pcm1792a.txt         |   18 ++
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/pcm1792a.c                        |  245 ++++++++++++++++++++
 sound/soc/codecs/pcm1792a.h                        |   26 +++
 5 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1792a.txt
 create mode 100644 sound/soc/codecs/pcm1792a.c
 create mode 100644 sound/soc/codecs/pcm1792a.h

diff --git a/Documentation/devicetree/bindings/sound/pcm1792a.txt b/Documentation/devicetree/bindings/sound/pcm1792a.txt
new file mode 100644
index 0000000..b8e48e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm1792a.txt
@@ -0,0 +1,18 @@
+Texas Instruments pcm1792a DT bindings
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
index badb6fb..45a9e3c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -55,6 +55,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ML26124 if I2C
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM3008
+	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_RT5640 if I2C
 	select SND_SOC_SGTL5000 if I2C
@@ -295,6 +296,9 @@ config SND_SOC_HDMI_CODEC
 config SND_SOC_PCM3008
        tristate
 
+config SND_SOC_PCM1792A
+       tristate
+
 config SND_SOC_RT5631
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 70fd806..1f8ee0b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -43,6 +43,7 @@ snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
 snd-soc-hdmi-codec-objs := hdmi.o
 snd-soc-pcm3008-objs := pcm3008.o
+snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
 snd-soc-sgtl5000-objs := sgtl5000.o
@@ -172,6 +173,7 @@ obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
+obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
new file mode 100644
index 0000000..99a4ee2
--- /dev/null
+++ b/sound/soc/codecs/pcm1792a.c
@@ -0,0 +1,245 @@
+/*
+ * PCM1792A ASoC codec driver
+ *
+ * Copyright (c) Amarula Solutions B.V. 2013
+ *
+ *     Michael Trimarchi <michael@amarulasolutions.com>
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
+#include <linux/of_device.h>
+
+#include "pcm1792a.h"
+
+#define PCM1792A_DAC_VOL_LEFT	0x10
+#define PCM1792A_DAC_VOL_RIGHT	0x11
+#define PCM1792A_FMT_CONTROL	0x12
+#define PCM1792A_SOFT_MUTE	PCM1792A_FMT_CONTROL
+
+#define PCM1792A_FMT_MASK	0x70
+#define PCM1792A_FMT_SHIFT	4
+#define PCM1792A_MUTE_MASK	0x01
+#define PCM1792A_MUTE_SHIFT	0
+#define PCM1792A_ATLD_ENABLE	(1 << 7)
+
+static const struct reg_default pcm1792a_reg_defaults[] = {
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
+static bool pcm1792a_accessible_reg(struct device *dev, unsigned int reg)
+{
+	return reg >= 0x10 && reg <= 0x17;
+}
+
+static bool pcm1792a_writeable_reg(struct device *dev, unsigned register reg)
+{
+	bool accessible;
+
+	accessible = pcm1792a_accessible_reg(dev, reg);
+
+	return accessible && reg != 0x16 && reg != 0x17;
+}
+
+struct pcm1792a_private {
+	struct regmap *regmap;
+	unsigned int format;
+	unsigned int rate;
+};
+
+static int pcm1792a_set_dai_fmt(struct snd_soc_dai *codec_dai,
+                             unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->format = format;
+
+	return 0;
+}
+
+static int pcm1792a_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
+				 PCM1792A_MUTE_MASK, !!mute);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
+	int val = 0, ret;
+	int pcm_format = params_format(params);
+
+	priv->rate = params_rate(params);
+
+	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		if (pcm_format == SNDRV_PCM_FORMAT_S24_LE ||
+		    pcm_format == SNDRV_PCM_FORMAT_S32_LE)
+			val = 0x02;
+		else if (pcm_format == SNDRV_PCM_FORMAT_S16_LE)
+			val = 0x00;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		if (pcm_format == SNDRV_PCM_FORMAT_S24_LE ||
+		    pcm_format == SNDRV_PCM_FORMAT_S32_LE)
+			val = 0x05;
+		else if (pcm_format == SNDRV_PCM_FORMAT_S16_LE)
+			val = 0x04;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	val = val << PCM1792A_FMT_SHIFT | PCM1792A_ATLD_ENABLE;
+
+	ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
+				 PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
+	.set_fmt	= pcm1792a_set_dai_fmt,
+	.hw_params	= pcm1792a_hw_params,
+	.digital_mute	= pcm1792a_digital_mute,
+};
+
+static const DECLARE_TLV_DB_SCALE(pcm1792a_dac_tlv, -12000, 50, 1);
+
+static const struct snd_kcontrol_new pcm1792a_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM1792A_DAC_VOL_LEFT,
+			 PCM1792A_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
+			 pcm1792a_dac_tlv),
+};
+
+static struct snd_soc_dai_driver pcm1792a_dai = {
+	.name = "pcm1792a-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = PCM1792A_RATES,
+		.formats = PCM1792A_FORMATS, },
+	.capture = {
+		.channels_min = 0,
+		.channels_max = 0,
+	},
+	.ops = &pcm1792a_dai_ops,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id pcm1792a_of_match[] = {
+	{ .compatible = "ti,pcm1792a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm1792a_of_match);
+#endif
+
+static const struct regmap_config pcm1792a_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= 24,
+	.reg_defaults		= pcm1792a_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(pcm1792a_reg_defaults),
+	.writeable_reg		= pcm1792a_writeable_reg,
+	.readable_reg		= pcm1792a_accessible_reg,
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_pcm1792a = {
+	.controls		= pcm1792a_controls,
+	.num_controls		= ARRAY_SIZE(pcm1792a_controls),
+};
+
+static int pcm1792a_spi_probe(struct spi_device *spi)
+{
+	struct pcm1792a_private *pcm1792a;
+	int ret;
+
+	pcm1792a = devm_kzalloc(&spi->dev, sizeof(struct pcm1792a_private),
+				GFP_KERNEL);
+	if (!pcm1792a)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, pcm1792a);
+
+	pcm1792a->regmap = devm_regmap_init_spi(spi, &pcm1792a_regmap);
+	if (IS_ERR(pcm1792a->regmap)) {
+		ret = PTR_ERR(pcm1792a->regmap);
+		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_pcm1792a, &pcm1792a_dai, 1);
+}
+
+static int pcm1792a_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static const struct spi_device_id pcm1792a_spi_ids[] = {
+	{ "pcm1792a", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, pcm1792a_spi_ids);
+
+static struct spi_driver pcm1792a_codec_driver = {
+	.driver = {
+		.name = "pcm1792a",
+		.owner = THIS_MODULE,
+		.of_match_table = pcm1792a_of_match,
+	},
+	.id_table = pcm1792a_spi_ids,
+	.probe = pcm1792a_spi_probe,
+	.remove = pcm1792a_spi_remove,
+};
+
+module_spi_driver(pcm1792a_codec_driver);
+
+MODULE_DESCRIPTION("ASoC PCM1792A driver");
+MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm1792a.h b/sound/soc/codecs/pcm1792a.h
new file mode 100644
index 0000000..7a83d1f
--- /dev/null
+++ b/sound/soc/codecs/pcm1792a.h
@@ -0,0 +1,26 @@
+/*
+ * definitions for PCM1792A
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
+#ifndef __PCM1792A_H__
+#define __PCM1792A_H__
+
+#define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
+
+#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+			  SNDRV_PCM_FMTBIT_S16_LE)
+
+#endif
-- 
1.7.9.5
