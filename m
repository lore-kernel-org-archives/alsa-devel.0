From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 1/3] new ad1836 codec driver based
	on asoc
Date: Thu, 13 Aug 2009 11:59:32 +0800
Message-ID: <1250135972-19366-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

There has been an ad1836 driver in sound/blackfin based on traditional alsa.
The new driver is based on asoc. The architecture of ad1836 codec driver is
very much like ad1938.

Signed-off-by: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/codecs/Kconfig  |    3 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/ad1836.c |  451 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad1836.h |   64 +++++++
 4 files changed, 520 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ad1836.c
 create mode 100644 sound/soc/codecs/ad1836.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 31a6d21..05e2279 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,6 +68,9 @@ config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
 
+config SND_SOC_AD1836
+	tristate
+
 config SND_SOC_AD1938
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 78dce5d..9cbcf8f 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,4 +1,5 @@
 snd-soc-ac97-objs := ac97.o
+snd-soc-ad1836-objs := ad1836.o
 snd-soc-ad1938-objs := ad1938.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
@@ -45,6 +46,7 @@ snd-soc-wm9713-objs := wm9713.o
 snd-soc-max9877-objs := max9877.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
+obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
 obj-$(CONFIG_SND_SOC_AD1938)	+= snd-soc-ad1938.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
new file mode 100644
index 0000000..79b9d19
--- /dev/null
+++ b/sound/soc/codecs/ad1836.c
@@ -0,0 +1,451 @@
+/*
+ * File:         sound/soc/codecs/ad1836.c
+ * Author:       Barry Song <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
+ *
+ * Created:      Aug 04 2009
+ * Description:  Driver for AD1836 sound chip
+ *
+ * Modified:
+ *               Copyright 2009 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/soc-dapm.h>
+#include <linux/spi/spi.h>
+#include "ad1836.h"
+
+/* codec private data */
+struct ad1836_priv {
+	struct snd_soc_codec codec;
+	u16 reg_cache[AD1836_NUM_REGS];
+};
+
+static struct snd_soc_codec *ad1836_codec;
+struct snd_soc_codec_device soc_codec_dev_ad1836;
+static int ad1836_register(struct ad1836_priv *ad1836);
+static void ad1836_unregister(struct ad1836_priv *ad1836);
+
+/*
+ * AD1836 volume/mute/de-emphasis etc. controls
+ */
+static const char *ad1836_deemp[] = {"None", "44.1kHz", "32kHz", "48kHz"};
+
+static const struct soc_enum ad1836_deemp_enum =
+	SOC_ENUM_SINGLE(AD1836_DAC_CTRL1, 8, 4, ad1836_deemp);
+
+static const struct snd_kcontrol_new ad1836_snd_controls[] = {
+	/* DAC volume control */
+	SOC_DOUBLE_R("DAC1 Volume", AD1836_DAC_L1_VOL,
+			AD1836_DAC_R1_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC2 Volume", AD1836_DAC_L2_VOL,
+			AD1836_DAC_R2_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC3 Volume", AD1836_DAC_L3_VOL,
+			AD1836_DAC_R3_VOL, 0, 0x3FF, 0),
+
+	/* ADC switch control */
+	SOC_DOUBLE("ADC1 Switch", AD1836_ADC_CTRL2, AD1836_ADCL1_MUTE,
+		AD1836_ADCR1_MUTE, 1, 1),
+	SOC_DOUBLE("ADC2 Switch", AD1836_ADC_CTRL2, AD1836_ADCL2_MUTE,
+		AD1836_ADCR2_MUTE, 1, 1),
+
+	/* DAC switch control */
+	SOC_DOUBLE("DAC1 Switch", AD1836_DAC_CTRL2, AD1836_DACL1_MUTE,
+		AD1836_DACR1_MUTE, 1, 1),
+	SOC_DOUBLE("DAC2 Switch", AD1836_DAC_CTRL2, AD1836_DACL2_MUTE,
+		AD1836_DACR2_MUTE, 1, 1),
+	SOC_DOUBLE("DAC3 Switch", AD1836_DAC_CTRL2, AD1836_DACL3_MUTE,
+		AD1836_DACR3_MUTE, 1, 1),
+
+	/* ADC high-pass filter */
+	SOC_SINGLE("ADC High Pass Filter Switch", AD1836_ADC_CTRL1,
+			AD1836_ADC_HIGHPASS_FILTER, 1, 0),
+
+	/* DAC de-emphasis */
+	SOC_ENUM("Playback Deemphasis", ad1836_deemp_enum),
+};
+
+static const struct snd_soc_dapm_widget ad1836_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", AD1836_DAC_CTRL1,
+				AD1836_DAC_POWERDOWN, 1),
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD1836_ADC_CTRL1,
+				AD1836_ADC_POWERDOWN, 1, NULL, 0),
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
+static int ad1836_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
+static int ad1836_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	int word_len = 0;
+
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		word_len = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		word_len = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		word_len = 0;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AD1836_DAC_CTRL1,
+		AD1836_DAC_WORD_LEN_MASK, word_len);
+
+	snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+		AD1836_ADC_WORD_LEN_MASK, word_len);
+
+	return 0;
+}
+
+
+/*
+ * interface to read/write ad1836 register
+ */
+#define AD1836_SPI_REG_SHFT 12
+#define AD1836_SPI_READ     (1 << 11)
+#define AD1836_SPI_VAL_MSK  0x3FF
+
+/*
+ * write to the ad1836 register space
+ */
+
+static int ad1836_write_reg(struct snd_soc_codec *codec, unsigned int reg,
+		unsigned int value)
+{
+	u16 *reg_cache = codec->reg_cache;
+	int ret = 0;
+
+	if (value != reg_cache[reg]) {
+		unsigned short buf;
+		struct spi_transfer t = {
+			.tx_buf = &buf,
+			.len = 2,
+		};
+		struct spi_message m;
+
+		buf = (reg << AD1836_SPI_REG_SHFT) |
+			(value & AD1836_SPI_VAL_MSK);
+		spi_message_init(&m);
+		spi_message_add_tail(&t, &m);
+		ret = spi_sync(codec->control_data, &m);
+		if (ret == 0)
+			reg_cache[reg] = value;
+	}
+
+	return ret;
+}
+
+/*
+ * read from the ad1836 register space cache
+ */
+static unsigned int ad1836_read_reg_cache(struct snd_soc_codec *codec,
+					  unsigned int reg)
+{
+	u16 *reg_cache = codec->reg_cache;
+
+	if (reg >= codec->reg_cache_size)
+		return -EINVAL;
+
+	return reg_cache[reg];
+}
+
+static int __devinit ad1836_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_codec *codec;
+	struct ad1836_priv *ad1836;
+
+	ad1836 = kzalloc(sizeof(struct ad1836_priv), GFP_KERNEL);
+	if (ad1836 == NULL)
+		return -ENOMEM;
+
+	codec = &ad1836->codec;
+	codec->control_data = spi;
+	codec->dev = &spi->dev;
+
+	dev_set_drvdata(&spi->dev, ad1836);
+
+	return ad1836_register(ad1836);
+}
+
+static int __devexit ad1836_spi_remove(struct spi_device *spi)
+{
+	struct ad1836_priv *ad1836 = dev_get_drvdata(&spi->dev);
+
+	ad1836_unregister(ad1836);
+	return 0;
+}
+
+static struct spi_driver ad1836_spi_driver = {
+	.driver = {
+		.name	= "ad1836-spi",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad1836_spi_probe,
+	.remove		= __devexit_p(ad1836_spi_remove),
+};
+
+static struct snd_soc_dai_ops ad1836_dai_ops = {
+	.hw_params = ad1836_hw_params,
+	.set_fmt = ad1836_set_dai_fmt,
+};
+
+/* codec DAI instance */
+struct snd_soc_dai ad1836_dai = {
+	.name = "AD1836",
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
+	.ops = &ad1836_dai_ops,
+};
+EXPORT_SYMBOL_GPL(ad1836_dai);
+
+static int ad1836_register(struct ad1836_priv *ad1836)
+{
+	int ret;
+	struct snd_soc_codec *codec = &ad1836->codec;
+
+	if (ad1836_codec) {
+		dev_err(codec->dev, "Another ad1836 is registered\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+	codec->private_data = ad1836;
+	codec->reg_cache = ad1836->reg_cache;
+	codec->reg_cache_size = AD1836_NUM_REGS;
+	codec->name = "AD1836";
+	codec->owner = THIS_MODULE;
+	codec->dai = &ad1836_dai;
+	codec->num_dai = 1;
+	codec->write = ad1836_write_reg;
+	codec->read = ad1836_read_reg_cache;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ad1836_dai.dev = codec->dev;
+	ad1836_codec = codec;
+
+	/* default setting for ad1836 */
+	/* de-emphasis: 48kHz, power-on dac */
+	codec->write(codec, AD1836_DAC_CTRL1, 0x300);
+	/* unmute dac channels */
+	codec->write(codec, AD1836_DAC_CTRL2, 0x0);
+	/* high-pass filter enable, power-on adc */
+	codec->write(codec, AD1836_ADC_CTRL1, 0x100);
+	/* unmute adc channles, adc aux mode */
+	codec->write(codec, AD1836_ADC_CTRL2, 0x180);
+	/* left/right diff:PGA/MUX */
+	codec->write(codec, AD1836_ADC_CTRL3, 0x3A);
+	/* volume */
+	codec->write(codec, AD1836_DAC_L1_VOL, 0x3FF);
+	codec->write(codec, AD1836_DAC_R1_VOL, 0x3FF);
+	codec->write(codec, AD1836_DAC_L2_VOL, 0x3FF);
+	codec->write(codec, AD1836_DAC_R2_VOL, 0x3FF);
+	codec->write(codec, AD1836_DAC_L3_VOL, 0x3FF);
+	codec->write(codec, AD1836_DAC_R3_VOL, 0x3FF);
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		kfree(ad1836);
+		return ret;
+	}
+
+	ret = snd_soc_register_dai(&ad1836_dai);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
+		snd_soc_unregister_codec(codec);
+		kfree(ad1836);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ad1836_unregister(struct ad1836_priv *ad1836)
+{
+	snd_soc_unregister_dai(&ad1836_dai);
+	snd_soc_unregister_codec(&ad1836->codec);
+	kfree(ad1836);
+	ad1836_codec = NULL;
+}
+
+static int ad1836_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (ad1836_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
+
+	socdev->card->codec = ad1836_codec;
+	codec = ad1836_codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
+		goto pcm_err;
+	}
+
+	snd_soc_add_controls(codec, ad1836_snd_controls,
+			     ARRAY_SIZE(ad1836_snd_controls));
+	snd_soc_dapm_new_controls(codec, ad1836_dapm_widgets,
+				  ARRAY_SIZE(ad1836_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
+	snd_soc_dapm_new_widgets(codec);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to register card: %d\n", ret);
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	return ret;
+}
+
+/* power down chip */
+static int ad1836_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ad1836 = {
+	.probe = 	ad1836_probe,
+	.remove = 	ad1836_remove,
+	/* The power management of ad1836 is very simple. There are
+	 * only adc&dac 2 components to control. Dapm handles them.
+	 */
+	.suspend =      NULL,
+	.resume =       NULL,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ad1836);
+
+static int __init ad1836_init(void)
+{
+	int ret;
+
+	ret = spi_register_driver(&ad1836_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register ad1836 SPI driver: %d\n",
+				ret);
+	}
+
+	return ret;
+}
+module_init(ad1836_init);
+
+static void __exit ad1836_exit(void)
+{
+	spi_unregister_driver(&ad1836_spi_driver);
+}
+module_exit(ad1836_exit);
+
+MODULE_DESCRIPTION("ASoC ad1836 driver");
+MODULE_AUTHOR("Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad1836.h b/sound/soc/codecs/ad1836.h
new file mode 100644
index 0000000..7660ee6
--- /dev/null
+++ b/sound/soc/codecs/ad1836.h
@@ -0,0 +1,64 @@
+/*
+ * File:         sound/soc/codecs/ad1836.h
+ * Based on:
+ * Author:       Barry Song <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
+ *
+ * Created:      Aug 04, 2009
+ * Description:  definitions for AD1836 registers
+ *
+ * Modified:
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __AD1836_H__
+#define __AD1836_H__
+
+#define AD1836_DAC_CTRL1               0
+#define AD1836_DAC_POWERDOWN           2
+#define AD1836_DAC_SERFMT_MASK	       0xE0
+#define AD1836_DAC_SERFMT_PCK256       (0x4 << 5)
+#define AD1836_DAC_SERFMT_PCK128       (0x5 << 5)
+#define AD1836_DAC_WORD_LEN_MASK       0x18
+
+#define AD1836_DAC_CTRL2               1
+#define AD1836_DACL1_MUTE              0
+#define AD1836_DACR1_MUTE              1
+#define AD1836_DACL2_MUTE              2
+#define AD1836_DACR2_MUTE              3
+#define AD1836_DACL3_MUTE              4
+#define AD1836_DACR3_MUTE              5
+
+#define AD1836_DAC_L1_VOL              2
+#define AD1836_DAC_R1_VOL              3
+#define AD1836_DAC_L2_VOL              4
+#define AD1836_DAC_R2_VOL              5
+#define AD1836_DAC_L3_VOL              6
+#define AD1836_DAC_R3_VOL              7
+
+#define AD1836_ADC_CTRL1               12
+#define AD1836_ADC_POWERDOWN           7
+#define AD1836_ADC_HIGHPASS_FILTER     8
+
+#define AD1836_ADC_CTRL2               13
+#define AD1836_ADCL1_MUTE 		0
+#define AD1836_ADCR1_MUTE 		1
+#define AD1836_ADCL2_MUTE 		2
+#define AD1836_ADCR2_MUTE 		3
+#define AD1836_ADC_WORD_LEN_MASK       0x30
+#define AD1836_ADC_SERFMT_MASK	       (7 << 6)
+#define AD1836_ADC_SERFMT_PCK256       (0x4 << 6)
+#define AD1836_ADC_SERFMT_PCK128       (0x5 << 6)
+
+#define AD1836_ADC_CTRL3               14
+
+#define AD1836_NUM_REGS                16
+
+extern struct snd_soc_dai ad1836_dai;
+extern struct snd_soc_codec_device soc_codec_dev_ad1836;
+#endif
-- 
1.5.6.3
