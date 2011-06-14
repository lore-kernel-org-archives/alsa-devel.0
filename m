From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 6/8] ASoC: AD183x: rename from ad1836 to
	support more codecs
Date: Tue, 14 Jun 2011 17:34:26 -0400
Message-ID: <1308087268-11464-6-git-send-email-vapier@gentoo.org>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 59730243E9
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 23:34:07 +0200 (CEST)
In-Reply-To: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

This simply renames the codec from "ad1836" to "ad183x" in preparation
for supporting more codecs in this family.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/Kconfig  |    4 +-
 sound/soc/codecs/Makefile |    4 +-
 sound/soc/codecs/ad1836.c |  311 ---------------------------------------------
 sound/soc/codecs/ad1836.h |   69 ----------
 sound/soc/codecs/ad183x.c |  301 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad183x.h |   59 +++++++++
 6 files changed, 364 insertions(+), 384 deletions(-)
 delete mode 100644 sound/soc/codecs/ad1836.c
 delete mode 100644 sound/soc/codecs/ad1836.h
 create mode 100644 sound/soc/codecs/ad183x.c
 create mode 100644 sound/soc/codecs/ad183x.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 24ab62d..1151000 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -13,7 +13,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
-	select SND_SOC_AD1836 if SPI_MASTER
+	select SND_SOC_AD183X if SPI_MASTER
 	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
 	select SND_SOC_AD73311
@@ -123,7 +123,7 @@ config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
 
-config SND_SOC_AD1836
+config SND_SOC_AD183X
 	tristate
 
 config SND_SOC_AD193X
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d85e117..1a3e3bf 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,6 +1,6 @@
 snd-soc-88pm860x-objs := 88pm860x-codec.o
 snd-soc-ac97-objs := ac97.o
-snd-soc-ad1836-objs := ad1836.o
+snd-soc-ad183x-objs := ad183x.o
 snd-soc-ad193x-objs := ad193x.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
@@ -95,7 +95,7 @@ snd-soc-wm9090-objs := wm9090.o
 
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
-obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
+obj-$(CONFIG_SND_SOC_AD183X)	+= snd-soc-ad183x.o
 obj-$(CONFIG_SND_SOC_AD193X)	+= snd-soc-ad193x.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311)	+= snd-soc-ad73311.o
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
deleted file mode 100644
index 50f1c15..0000000
--- a/sound/soc/codecs/ad1836.c
+++ /dev/null
@@ -1,311 +0,0 @@
-/*
- * File:         sound/soc/codecs/ad1836.c
- * Author:       Barry Song <Barry.Song@analog.com>
- *
- * Created:      Aug 04 2009
- * Description:  Driver for AD1836 sound chip
- *
- * Modified:
- *               Copyright 2009 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-#include <sound/tlv.h>
-#include <linux/spi/spi.h>
-#include "ad1836.h"
-
-/* codec private data */
-struct ad1836_priv {
-	enum snd_soc_control_type control_type;
-	void *control_data;
-};
-
-/*
- * AD1836 volume/mute/de-emphasis etc. controls
- */
-static const char *ad1836_deemp[] = {"None", "44.1kHz", "32kHz", "48kHz"};
-
-static const struct soc_enum ad1836_deemp_enum =
-	SOC_ENUM_SINGLE(AD1836_DAC_CTRL1, 8, 4, ad1836_deemp);
-
-static const struct snd_kcontrol_new ad1836_snd_controls[] = {
-	/* DAC volume control */
-	SOC_DOUBLE_R("DAC1 Volume", AD1836_DAC_L1_VOL,
-			AD1836_DAC_R1_VOL, 0, 0x3FF, 0),
-	SOC_DOUBLE_R("DAC2 Volume", AD1836_DAC_L2_VOL,
-			AD1836_DAC_R2_VOL, 0, 0x3FF, 0),
-	SOC_DOUBLE_R("DAC3 Volume", AD1836_DAC_L3_VOL,
-			AD1836_DAC_R3_VOL, 0, 0x3FF, 0),
-
-	/* ADC switch control */
-	SOC_DOUBLE("ADC1 Switch", AD1836_ADC_CTRL2, AD1836_ADCL1_MUTE,
-		AD1836_ADCR1_MUTE, 1, 1),
-	SOC_DOUBLE("ADC2 Switch", AD1836_ADC_CTRL2, AD1836_ADCL2_MUTE,
-		AD1836_ADCR2_MUTE, 1, 1),
-
-	/* DAC switch control */
-	SOC_DOUBLE("DAC1 Switch", AD1836_DAC_CTRL2, AD1836_DACL1_MUTE,
-		AD1836_DACR1_MUTE, 1, 1),
-	SOC_DOUBLE("DAC2 Switch", AD1836_DAC_CTRL2, AD1836_DACL2_MUTE,
-		AD1836_DACR2_MUTE, 1, 1),
-	SOC_DOUBLE("DAC3 Switch", AD1836_DAC_CTRL2, AD1836_DACL3_MUTE,
-		AD1836_DACR3_MUTE, 1, 1),
-
-	/* ADC high-pass filter */
-	SOC_SINGLE("ADC High Pass Filter Switch", AD1836_ADC_CTRL1,
-			AD1836_ADC_HIGHPASS_FILTER, 1, 0),
-
-	/* DAC de-emphasis */
-	SOC_ENUM("Playback Deemphasis", ad1836_deemp_enum),
-};
-
-static const struct snd_soc_dapm_widget ad1836_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("DAC", "Playback", AD1836_DAC_CTRL1,
-				AD1836_DAC_POWERDOWN, 1),
-	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD1836_ADC_CTRL1,
-				AD1836_ADC_POWERDOWN, 1, NULL, 0),
-	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
-	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
-	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
-	SND_SOC_DAPM_INPUT("ADC1IN"),
-	SND_SOC_DAPM_INPUT("ADC2IN"),
-};
-
-static const struct snd_soc_dapm_route audio_paths[] = {
-	{ "DAC", NULL, "ADC_PWR" },
-	{ "ADC", NULL, "ADC_PWR" },
-	{ "DAC1OUT", "DAC1 Switch", "DAC" },
-	{ "DAC2OUT", "DAC2 Switch", "DAC" },
-	{ "DAC3OUT", "DAC3 Switch", "DAC" },
-	{ "ADC", "ADC1 Switch", "ADC1IN" },
-	{ "ADC", "ADC2 Switch", "ADC2IN" },
-};
-
-/*
- * DAI ops entries
- */
-
-static int ad1836_set_dai_fmt(struct snd_soc_dai *codec_dai,
-		unsigned int fmt)
-{
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	/* at present, we support adc aux mode to interface with
-	 * blackfin sport tdm mode
-	 */
-	case SND_SOC_DAIFMT_DSP_A:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	/* ALCLK,ABCLK are both output, AD1836 can only be master */
-	case SND_SOC_DAIFMT_CBM_CFM:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int ad1836_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params,
-		struct snd_soc_dai *dai)
-{
-	int word_len = 0;
-
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-
-	/* bit size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-		word_len = AD1836_WORD_LEN_16;
-		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-		word_len = AD1836_WORD_LEN_20;
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-	case SNDRV_PCM_FORMAT_S32_LE:
-		word_len = AD1836_WORD_LEN_24;
-		break;
-	}
-
-	snd_soc_update_bits(codec, AD1836_DAC_CTRL1, AD1836_DAC_WORD_LEN_MASK,
-		word_len << AD1836_DAC_WORD_LEN_OFFSET);
-
-	snd_soc_update_bits(codec, AD1836_ADC_CTRL2, AD1836_ADC_WORD_LEN_MASK,
-		word_len << AD1836_ADC_WORD_OFFSET);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int ad1836_soc_suspend(struct snd_soc_codec *codec,
-		pm_message_t state)
-{
-	/* reset clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
-	adc_ctrl2 &= ~AD1836_ADC_SERFMT_MASK;
-
-	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
-}
-
-static int ad1836_soc_resume(struct snd_soc_codec *codec)
-{
-	/* restore clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
-	adc_ctrl2 |= AD1836_ADC_AUX;
-
-	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
-}
-#else
-#define ad1836_soc_suspend NULL
-#define ad1836_soc_resume  NULL
-#endif
-
-static struct snd_soc_dai_ops ad1836_dai_ops = {
-	.hw_params = ad1836_hw_params,
-	.set_fmt = ad1836_set_dai_fmt,
-};
-
-/* codec DAI instance */
-static struct snd_soc_dai_driver ad1836_dai = {
-	.name = "ad1836-hifi",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 6,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
-	},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 2,
-		.channels_max = 4,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
-	},
-	.ops = &ad1836_dai_ops,
-};
-
-static int ad1836_probe(struct snd_soc_codec *codec)
-{
-	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret = 0;
-
-	codec->control_data = ad1836->control_data;
-	ret = snd_soc_codec_set_cache_io(codec, 4, 12, ad1836->control_type);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to set cache I/O: %d\n",
-				ret);
-		return ret;
-	}
-
-	snd_soc_add_controls(codec, ad1836_snd_controls,
-			     ARRAY_SIZE(ad1836_snd_controls));
-	snd_soc_dapm_new_controls(dapm, ad1836_dapm_widgets,
-				  ARRAY_SIZE(ad1836_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
-
-	return ret;
-}
-
-/* power down chip */
-static int ad1836_remove(struct snd_soc_codec *codec)
-{
-	/* reset clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
-	adc_ctrl2 &= ~AD1836_ADC_SERFMT_MASK;
-
-	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
-}
-
-static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
-	.probe =        ad1836_probe,
-	.remove =       ad1836_remove,
-	.suspend =      ad1836_soc_suspend,
-	.resume =       ad1836_soc_resume,
-	.reg_cache_size = AD1836_NUM_REGS,
-	.reg_word_size = sizeof(u16),
-};
-
-static int __devinit ad1836_spi_probe(struct spi_device *spi)
-{
-	struct ad1836_priv *ad1836;
-	int ret;
-
-	ad1836 = kzalloc(sizeof(struct ad1836_priv), GFP_KERNEL);
-	if (ad1836 == NULL)
-		return -ENOMEM;
-
-	spi_set_drvdata(spi, ad1836);
-	ad1836->control_data = spi;
-	ad1836->control_type = SND_SOC_SPI;
-
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_ad1836, &ad1836_dai, 1);
-	if (ret < 0)
-		kfree(ad1836);
-	return ret;
-}
-
-static int __devexit ad1836_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
-	return 0;
-}
-
-static struct spi_driver ad1836_spi_driver = {
-	.driver = {
-		.name	= "ad1836",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= ad1836_spi_probe,
-	.remove		= __devexit_p(ad1836_spi_remove),
-};
-
-static int __init ad1836_init(void)
-{
-	return spi_register_driver(&ad1836_spi_driver);
-}
-module_init(ad1836_init);
-
-static void __exit ad1836_exit(void)
-{
-	spi_unregister_driver(&ad1836_spi_driver);
-}
-module_exit(ad1836_exit);
-
-MODULE_DESCRIPTION("ASoC ad1836 driver");
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad1836.h b/sound/soc/codecs/ad1836.h
deleted file mode 100644
index 81d9ae3..0000000
--- a/sound/soc/codecs/ad1836.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * File:         sound/soc/codecs/ad1836.h
- * Based on:
- * Author:       Barry Song <Barry.Song@analog.com>
- *
- * Created:      Aug 04, 2009
- * Description:  definitions for AD1836 registers
- *
- * Modified:
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __AD1836_H__
-#define __AD1836_H__
-
-#define AD1836_DAC_CTRL1               0
-#define AD1836_DAC_POWERDOWN           2
-#define AD1836_DAC_SERFMT_MASK         0xE0
-#define AD1836_DAC_SERFMT_PCK256       (0x4 << 5)
-#define AD1836_DAC_SERFMT_PCK128       (0x5 << 5)
-#define AD1836_DAC_WORD_LEN_MASK       0x18
-#define AD1836_DAC_WORD_LEN_OFFSET     3
-
-#define AD1836_DAC_CTRL2               1
-#define AD1836_DACL1_MUTE              0
-#define AD1836_DACR1_MUTE              1
-#define AD1836_DACL2_MUTE              2
-#define AD1836_DACR2_MUTE              3
-#define AD1836_DACL3_MUTE              4
-#define AD1836_DACR3_MUTE              5
-
-#define AD1836_DAC_L1_VOL              2
-#define AD1836_DAC_R1_VOL              3
-#define AD1836_DAC_L2_VOL              4
-#define AD1836_DAC_R2_VOL              5
-#define AD1836_DAC_L3_VOL              6
-#define AD1836_DAC_R3_VOL              7
-
-#define AD1836_ADC_CTRL1               12
-#define AD1836_ADC_POWERDOWN           7
-#define AD1836_ADC_HIGHPASS_FILTER     8
-
-#define AD1836_ADC_CTRL2               13
-#define AD1836_ADCL1_MUTE              0
-#define AD1836_ADCR1_MUTE              1
-#define AD1836_ADCL2_MUTE              2
-#define AD1836_ADCR2_MUTE              3
-#define AD1836_ADC_WORD_LEN_MASK       0x30
-#define AD1836_ADC_WORD_OFFSET         5
-#define AD1836_ADC_SERFMT_MASK         (7 << 6)
-#define AD1836_ADC_SERFMT_PCK256       (0x4 << 6)
-#define AD1836_ADC_SERFMT_PCK128       (0x5 << 6)
-#define AD1836_ADC_AUX                 (0x6 << 6)
-
-#define AD1836_ADC_CTRL3               14
-
-#define AD1836_NUM_REGS                16
-
-#define AD1836_WORD_LEN_24 0x0
-#define AD1836_WORD_LEN_20 0x1
-#define AD1836_WORD_LEN_16 0x2
-
-#endif
diff --git a/sound/soc/codecs/ad183x.c b/sound/soc/codecs/ad183x.c
new file mode 100644
index 0000000..2c5c49e
--- /dev/null
+++ b/sound/soc/codecs/ad183x.c
@@ -0,0 +1,301 @@
+/*
+ * Audio Codec driver supporting AD1836
+ *
+ * Copyright 2009-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <linux/spi/spi.h>
+#include "ad183x.h"
+
+/* codec private data */
+struct ad183x_priv {
+	enum snd_soc_control_type control_type;
+	void *control_data;
+};
+
+/*
+ * AD183X volume/mute/de-emphasis etc. controls
+ */
+static const char *ad183x_deemp[] = {"None", "44.1kHz", "32kHz", "48kHz"};
+
+static const struct soc_enum ad183x_deemp_enum =
+	SOC_ENUM_SINGLE(AD183X_DAC_CTRL1, 8, 4, ad183x_deemp);
+
+static const struct snd_kcontrol_new ad183x_snd_controls[] = {
+	/* DAC volume control */
+	SOC_DOUBLE_R("DAC1 Volume", AD183X_DAC_L1_VOL,
+			AD183X_DAC_R1_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC2 Volume", AD183X_DAC_L2_VOL,
+			AD183X_DAC_R2_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC3 Volume", AD183X_DAC_L3_VOL,
+			AD183X_DAC_R3_VOL, 0, 0x3FF, 0),
+
+	/* ADC switch control */
+	SOC_DOUBLE("ADC1 Switch", AD183X_ADC_CTRL2, AD183X_ADCL1_MUTE,
+		AD183X_ADCR1_MUTE, 1, 1),
+	SOC_DOUBLE("ADC2 Switch", AD183X_ADC_CTRL2, AD183X_ADCL2_MUTE,
+		AD183X_ADCR2_MUTE, 1, 1),
+
+	/* DAC switch control */
+	SOC_DOUBLE("DAC1 Switch", AD183X_DAC_CTRL2, AD183X_DACL1_MUTE,
+		AD183X_DACR1_MUTE, 1, 1),
+	SOC_DOUBLE("DAC2 Switch", AD183X_DAC_CTRL2, AD183X_DACL2_MUTE,
+		AD183X_DACR2_MUTE, 1, 1),
+	SOC_DOUBLE("DAC3 Switch", AD183X_DAC_CTRL2, AD183X_DACL3_MUTE,
+		AD183X_DACR3_MUTE, 1, 1),
+
+	/* ADC high-pass filter */
+	SOC_SINGLE("ADC High Pass Filter Switch", AD183X_ADC_CTRL1,
+			AD183X_ADC_HIGHPASS_FILTER, 1, 0),
+
+	/* DAC de-emphasis */
+	SOC_ENUM("Playback Deemphasis", ad183x_deemp_enum),
+};
+
+static const struct snd_soc_dapm_widget ad183x_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", AD183X_DAC_CTRL1,
+				AD183X_DAC_POWERDOWN, 1),
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD183X_ADC_CTRL1,
+				AD183X_ADC_POWERDOWN, 1, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
+	SND_SOC_DAPM_INPUT("ADC1IN"),
+	SND_SOC_DAPM_INPUT("ADC2IN"),
+};
+
+static const struct snd_soc_dapm_route audio_paths[] = {
+	{ "DAC", NULL, "ADC_PWR" },
+	{ "ADC", NULL, "ADC_PWR" },
+	{ "DAC1OUT", "DAC1 Switch", "DAC" },
+	{ "DAC2OUT", "DAC2 Switch", "DAC" },
+	{ "DAC3OUT", "DAC3 Switch", "DAC" },
+	{ "ADC", "ADC1 Switch", "ADC1IN" },
+	{ "ADC", "ADC2 Switch", "ADC2IN" },
+};
+
+/*
+ * DAI ops entries
+ */
+
+static int ad183x_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	/* at present, we support adc aux mode to interface with
+	 * blackfin sport tdm mode
+	 */
+	case SND_SOC_DAIFMT_DSP_A:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	/* ALCLK,ABCLK are both output, AD1836 can only be master */
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ad183x_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	int word_len = 0;
+
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		word_len = AD183X_WORD_LEN_16;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		word_len = AD183X_WORD_LEN_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		word_len = AD183X_WORD_LEN_24;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AD183X_DAC_CTRL1, AD183X_DAC_WORD_LEN_MASK,
+		word_len << AD183X_DAC_WORD_LEN_OFFSET);
+
+	snd_soc_update_bits(codec, AD183X_ADC_CTRL2, AD183X_ADC_WORD_LEN_MASK,
+		word_len << AD183X_ADC_WORD_OFFSET);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ad183x_soc_suspend(struct snd_soc_codec *codec,
+		pm_message_t state)
+{
+	/* reset clock control mode */
+	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
+	adc_ctrl2 &= ~AD183X_ADC_SERFMT_MASK;
+
+	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
+}
+
+static int ad183x_soc_resume(struct snd_soc_codec *codec)
+{
+	/* restore clock control mode */
+	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
+	adc_ctrl2 |= AD183X_ADC_AUX;
+
+	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
+}
+#else
+#define ad183x_soc_suspend NULL
+#define ad183x_soc_resume  NULL
+#endif
+
+static struct snd_soc_dai_ops ad183x_dai_ops = {
+	.hw_params = ad183x_hw_params,
+	.set_fmt = ad183x_set_dai_fmt,
+};
+
+/* codec DAI instance */
+static struct snd_soc_dai_driver ad183x_dai = {
+	.name = "ad183x-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 6,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 4,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops = &ad183x_dai_ops,
+};
+
+static int ad183x_probe(struct snd_soc_codec *codec)
+{
+	struct ad183x_priv *ad183x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret = 0;
+
+	codec->control_data = ad183x->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 4, 12, ad183x->control_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to set cache I/O: %d\n",
+				ret);
+		return ret;
+	}
+
+	snd_soc_add_controls(codec, ad183x_snd_controls,
+			     ARRAY_SIZE(ad183x_snd_controls));
+	snd_soc_dapm_new_controls(dapm, ad183x_dapm_widgets,
+				  ARRAY_SIZE(ad183x_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
+
+	return ret;
+}
+
+/* power down chip */
+static int ad183x_remove(struct snd_soc_codec *codec)
+{
+	/* reset clock control mode */
+	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
+	adc_ctrl2 &= ~AD183X_ADC_SERFMT_MASK;
+
+	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_ad183x = {
+	.probe =        ad183x_probe,
+	.remove =       ad183x_remove,
+	.suspend =      ad183x_soc_suspend,
+	.resume =       ad183x_soc_resume,
+	.reg_cache_size = AD183X_NUM_REGS,
+	.reg_word_size = sizeof(u16),
+};
+
+static int __devinit ad183x_spi_probe(struct spi_device *spi)
+{
+	struct ad183x_priv *ad183x;
+	int ret;
+
+	ad183x = kzalloc(sizeof(struct ad183x_priv), GFP_KERNEL);
+	if (ad183x == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, ad183x);
+	ad183x->control_data = spi;
+	ad183x->control_type = SND_SOC_SPI;
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_ad183x, &ad183x_dai, 1);
+	if (ret < 0)
+		kfree(ad183x);
+	return ret;
+}
+
+static int __devexit ad183x_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver ad183x_spi_driver = {
+	.driver = {
+		.name	= "ad183x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad183x_spi_probe,
+	.remove		= __devexit_p(ad183x_spi_remove),
+};
+
+static int __init ad183x_init(void)
+{
+	return spi_register_driver(&ad183x_spi_driver);
+}
+module_init(ad183x_init);
+
+static void __exit ad183x_exit(void)
+{
+	spi_unregister_driver(&ad183x_spi_driver);
+}
+module_exit(ad183x_exit);
+
+MODULE_DESCRIPTION("ASoC ad183x driver");
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad183x.h b/sound/soc/codecs/ad183x.h
new file mode 100644
index 0000000..b8f7289
--- /dev/null
+++ b/sound/soc/codecs/ad183x.h
@@ -0,0 +1,59 @@
+/*
+ * Audio Codec driver supporting AD1836
+ *
+ * Copyright 2009-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef __AD183X_H__
+#define __AD183X_H__
+
+#define AD183X_DAC_CTRL1               0
+#define AD183X_DAC_POWERDOWN           2
+#define AD183X_DAC_SERFMT_MASK         0xE0
+#define AD183X_DAC_SERFMT_PCK256       (0x4 << 5)
+#define AD183X_DAC_SERFMT_PCK128       (0x5 << 5)
+#define AD183X_DAC_WORD_LEN_MASK       0x18
+#define AD183X_DAC_WORD_LEN_OFFSET     3
+
+#define AD183X_DAC_CTRL2               1
+#define AD183X_DACL1_MUTE              0
+#define AD183X_DACR1_MUTE              1
+#define AD183X_DACL2_MUTE              2
+#define AD183X_DACR2_MUTE              3
+#define AD183X_DACL3_MUTE              4
+#define AD183X_DACR3_MUTE              5
+
+#define AD183X_DAC_L1_VOL              2
+#define AD183X_DAC_R1_VOL              3
+#define AD183X_DAC_L2_VOL              4
+#define AD183X_DAC_R2_VOL              5
+#define AD183X_DAC_L3_VOL              6
+#define AD183X_DAC_R3_VOL              7
+
+#define AD183X_ADC_CTRL1               12
+#define AD183X_ADC_POWERDOWN           7
+#define AD183X_ADC_HIGHPASS_FILTER     8
+
+#define AD183X_ADC_CTRL2               13
+#define AD183X_ADCL1_MUTE              0
+#define AD183X_ADCR1_MUTE              1
+#define AD183X_ADCL2_MUTE              2
+#define AD183X_ADCR2_MUTE              3
+#define AD183X_ADC_WORD_LEN_MASK       0x30
+#define AD183X_ADC_WORD_OFFSET         5
+#define AD183X_ADC_SERFMT_MASK         (7 << 6)
+#define AD183X_ADC_SERFMT_PCK256       (0x4 << 6)
+#define AD183X_ADC_SERFMT_PCK128       (0x5 << 6)
+#define AD183X_ADC_AUX                 (0x6 << 6)
+
+#define AD183X_ADC_CTRL3               14
+
+#define AD183X_NUM_REGS                16
+
+#define AD183X_WORD_LEN_24 0x0
+#define AD183X_WORD_LEN_20 0x1
+#define AD183X_WORD_LEN_16 0x2
+
+#endif
-- 
1.7.5.3
