From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Initial WM8741 CODEC driver
Date: Fri, 30 Jul 2010 17:45:07 +0100
Message-ID: <1280508308.2130.148.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 246CE2439C
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 18:45:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The WM8741 is a very high performance stereo DAC designed for audio
applications such as professional recording systems, A/V receivers and
high specification CD, DVD and home theatre systems. The device
supports PCM data input word lengths from 16 to 32-bits and sampling
rates up to 192kHz. The WM8741 also supports DSD bit-stream data
format, in both direct DSD and PCM-converted DSD modes.

TODO: Expand wm8741_set_dai_sysclk and rate_constraint members to
allow for all supported sample rate / Master Clock frequency
combinations.
Fully enable control of supplies.


Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/wm8741.c |  579
+++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8741.h |  214 +++++++++++++++++
 4 files changed, 799 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wm8741.c
 create mode 100644 sound/soc/codecs/wm8741.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 55bc2be..83f5c67 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -50,6 +50,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8727
 	select SND_SOC_WM8728 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8731 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_WM8741 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8750 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8753 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8776 if SND_SOC_I2C_AND_SPI
@@ -214,6 +215,9 @@ config SND_SOC_WM8728
 config SND_SOC_WM8731
 	tristate
 
+config SND_SOC_WM8741
+	tristate
+
 config SND_SOC_WM8750
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d8d9eeb..5352409 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -35,6 +35,7 @@ snd-soc-wm8711-objs := wm8711.o
 snd-soc-wm8727-objs := wm8727.o
 snd-soc-wm8728-objs := wm8728.o
 snd-soc-wm8731-objs := wm8731.o
+snd-soc-wm8741-objs := wm8741.o
 snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
 snd-soc-wm8776-objs := wm8776.o
@@ -103,6 +104,7 @@ obj-$(CONFIG_SND_SOC_WM8711)	+= snd-soc-wm8711.o
 obj-$(CONFIG_SND_SOC_WM8727)	+= snd-soc-wm8727.o
 obj-$(CONFIG_SND_SOC_WM8728)	+= snd-soc-wm8728.o
 obj-$(CONFIG_SND_SOC_WM8731)	+= snd-soc-wm8731.o
+obj-$(CONFIG_SND_SOC_WM8741)	+= snd-soc-wm8741.o
 obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
 obj-$(CONFIG_SND_SOC_WM8776)	+= snd-soc-wm8776.o
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
new file mode 100644
index 0000000..67a9f4f
--- /dev/null
+++ b/sound/soc/codecs/wm8741.c
@@ -0,0 +1,579 @@
+/*
+ * wm8741.c  --  WM8741 ALSA SoC Audio driver
+ *
+ * Copyright 2010 Wolfson Microelectronics plc
+ *
+ * Author: Ian Lartey <ian@opensource.wolfsonmicro.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "wm8741.h"
+
+static struct snd_soc_codec *wm8741_codec;
+struct snd_soc_codec_device soc_codec_dev_wm8741;
+
+#define WM8741_NUM_SUPPLIES 2
+static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
+	"AVDD",
+	"DVDD",
+};
+
+#define WM8741_NUM_RATES 4
+
+/* codec private data */
+struct wm8741_priv {
+	struct snd_soc_codec codec;
+	u16 reg_cache[WM8741_REGISTER_COUNT];
+	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
+	unsigned int sysclk;
+	unsigned int rate_constraint_list[WM8741_NUM_RATES];
+	struct snd_pcm_hw_constraint_list rate_constraint;
+};
+
+static const u16 wm8741_reg_defaults[WM8741_REGISTER_COUNT] = {
+	0x0000,     /* R0  - DACLLSB Attenuation */
+	0x0000,     /* R1  - DACLMSB Attenuation */
+	0x0000,     /* R2  - DACRLSB Attenuation */
+	0x0000,     /* R3  - DACRMSB Attenuation */
+	0x0000,     /* R4  - Volume Control */
+	0x000A,     /* R5  - Format Control */
+	0x0000,     /* R6  - Filter Control */
+	0x0000,     /* R7  - Mode Control 1 */
+	0x0002,     /* R8  - Mode Control 2 */
+	0x0000,	    /* R9  - Reset */
+	0x0002,     /* R32 - ADDITONAL_CONTROL_1 */
+};
+
+
+static int wm8741_reset(struct snd_soc_codec *codec)
+{
+	return snd_soc_write(codec, WM8741_RESET, 0);
+}
+
+static const DECLARE_TLV_DB_SCALE(dac_tlv_fine, -12700, 13, 0);
+static const DECLARE_TLV_DB_SCALE(dac_tlv, -12700, 400, 0);
+
+static const struct snd_kcontrol_new wm8741_snd_controls[] = {
+SOC_DOUBLE_R_TLV("Fine Playback Volume", WM8741_DACLLSB_ATTENUATION,
+		 WM8741_DACRLSB_ATTENUATION, 1, 255, 1, dac_tlv_fine),
+SOC_DOUBLE_R_TLV("Playback Volume", WM8741_DACLMSB_ATTENUATION,
+		 WM8741_DACRMSB_ATTENUATION, 0, 511, 1, dac_tlv),
+};
+
+static const struct snd_soc_dapm_widget wm8741_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DACL", "Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_DAC("DACR", "Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_OUTPUT("VOUTLP"),
+SND_SOC_DAPM_OUTPUT("VOUTLN"),
+SND_SOC_DAPM_OUTPUT("VOUTRP"),
+SND_SOC_DAPM_OUTPUT("VOUTRN"),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{ "VOUTLP", NULL, "DACL" },
+	{ "VOUTLN", NULL, "DACL" },
+	{ "VOUTRP", NULL, "DACR" },
+	{ "VOUTRN", NULL, "DACR" },
+};
+
+static int wm8741_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, wm8741_dapm_widgets,
+				  ARRAY_SIZE(wm8741_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	return 0;
+}
+
+static struct {
+	int value;
+	int ratio;
+} lrclk_ratios[WM8741_NUM_RATES] = {
+	{ 1, 256 },
+	{ 2, 384 },
+	{ 3, 512 },
+	{ 4, 768 },
+};
+
+
+static int wm8741_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+
+	/* The set of sample rates that can be supported depends on the
+	 * MCLK supplied to the CODEC - enforce this.
+	 */
+	if (!wm8741->sysclk) {
+		dev_err(codec->dev,
+			"No MCLK configured, call set_sysclk() on init\n");
+		return -EINVAL;
+	}
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &wm8741->rate_constraint);
+
+	return 0;
+}
+
+static int wm8741_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
+	int i;
+
+	/* Find a supported LRCLK ratio */
+	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
+		if (wm8741->sysclk / params_rate(params) ==
+		    lrclk_ratios[i].ratio)
+			break;
+	}
+
+	/* Should never happen, should be handled by constraints */
+	if (i == ARRAY_SIZE(lrclk_ratios)) {
+		dev_err(codec->dev, "MCLK/fs ratio %d unsupported\n",
+			wm8741->sysclk / params_rate(params));
+		return -EINVAL;
+	}
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		iface |= 0x0001;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iface |= 0x0002;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		iface |= 0x0003;
+		break;
+	default:
+		dev_dbg(codec->dev, "wm8741_hw_params:    Unsupported bit size param
= %d",
+			params_format(params));
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "wm8741_hw_params:    bit size param = %d",
+		params_format(params));
+
+	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
+	return 0;
+}
+
+static int wm8741_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+	int i;
+
+	dev_dbg(codec->dev, "wm8741_set_dai_sysclk info: freq=%dHz\n", freq);
+
+	wm8741->sysclk = freq;
+
+	wm8741->rate_constraint.count = 0;
+
+	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
+		dev_dbg(codec->dev, "index = %d, ratio = %d, freq = %d",
+				i, lrclk_ratios[i].ratio, freq);
+
+		val = freq / lrclk_ratios[i].ratio;
+		/* Check that it's a standard rate since core can't
+		 * cope with others and having the odd rates confuses
+		 * constraint matching.
+		 */
+		switch (val) {
+		case 32000:
+		case 44100:
+		case 48000:
+		case 64000:
+		case 88200:
+		case 96000:
+			dev_dbg(codec->dev, "Supported sample rate: %dHz\n",
+				val);
+			wm8741->rate_constraint_list[i] = val;
+			wm8741->rate_constraint.count++;
+			break;
+		default:
+			dev_dbg(codec->dev, "Skipping sample rate: %dHz\n",
+				val);
+		}
+	}
+
+	/* Need at least one supported rate... */
+	if (wm8741->rate_constraint.count == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1C3;
+
+	/* check master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= 0x0008;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface |= 0x0004;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface |= 0x0003;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		iface |= 0x0013;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface |= 0x0010;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface |= 0x0020;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface |= 0x0030;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+
+	dev_dbg(codec->dev, "wm8741_set_dai_fmt:    Format=%x, Clock Inv=%x
\n",
+				fmt & SND_SOC_DAIFMT_FORMAT_MASK,
+				((fmt & SND_SOC_DAIFMT_INV_MASK)));
+
+	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
+	return 0;
+}
+
+#define WM8741_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
+			SNDRV_PCM_RATE_192000)
+
+#define WM8741_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
SNDRV_PCM_FMTBIT_S20_3LE |\
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops wm8741_dai_ops = {
+	.startup	= wm8741_startup,
+	.hw_params	= wm8741_hw_params,
+	.set_sysclk	= wm8741_set_dai_sysclk,
+	.set_fmt	= wm8741_set_dai_fmt,
+};
+
+struct snd_soc_dai wm8741_dai = {
+	.name = "WM8741",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,  /* Mono modes not yet supported */
+		.channels_max = 2,
+		.rates = WM8741_RATES,
+		.formats = WM8741_FORMATS,
+	},
+	.ops = &wm8741_dai_ops,
+};
+EXPORT_SYMBOL_GPL(wm8741_dai);
+
+#ifdef CONFIG_PM
+static int wm8741_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+	u16 *cache = codec->reg_cache;
+	int i;
+
+	/* RESTORE REG Cache */
+	for (i = 0; i < WM8741_REGISTER_COUNT; i++) {
+		if (cache[i] == wm8741_reg_defaults[i])
+			continue;
+		snd_soc_write(codec, i, cache[i]);
+	}
+	return 0;
+}
+#else
+#define wm8741_suspend NULL
+#define wm8741_resume NULL
+#endif
+
+static int wm8741_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (wm8741_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
+
+	socdev->card->codec = wm8741_codec;
+	codec = wm8741_codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1,
SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
+		goto pcm_err;
+	}
+
+	snd_soc_add_controls(codec, wm8741_snd_controls,
+			     ARRAY_SIZE(wm8741_snd_controls));
+	wm8741_add_widgets(codec);
+
+	return ret;
+
+pcm_err:
+	return ret;
+}
+
+static int wm8741_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8741 = {
+	.probe =	wm8741_probe,
+	.remove =	wm8741_remove,
+	.resume =	wm8741_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8741);
+
+static int wm8741_register(struct wm8741_priv *wm8741,
+			   enum snd_soc_control_type control)
+{
+	int ret;
+	struct snd_soc_codec *codec = &wm8741->codec;
+	int i;
+
+	if (wm8741_codec) {
+		dev_err(codec->dev, "Another WM8741 is registered\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	snd_soc_codec_set_drvdata(codec, wm8741);
+	codec->name = "WM8741";
+	codec->owner = THIS_MODULE;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = NULL;
+	codec->dai = &wm8741_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = WM8741_REGISTER_COUNT;
+	codec->reg_cache = &wm8741->reg_cache;
+
+	wm8741->rate_constraint.list = &wm8741->rate_constraint_list[0];
+	wm8741->rate_constraint.count =
+		ARRAY_SIZE(wm8741->rate_constraint_list);
+
+	memcpy(codec->reg_cache, wm8741_reg_defaults,
+		sizeof(wm8741->reg_cache));
+
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
+		wm8741->supplies[i].supply = wm8741_supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8741->supplies),
+				 wm8741->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8741->supplies),
+				    wm8741->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_get;
+	}
+
+	ret = wm8741_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		goto err_enable;
+	}
+
+	wm8741_dai.dev = codec->dev;
+
+	/* Change some default settings - latch VU */
+	wm8741->reg_cache[WM8741_DACLLSB_ATTENUATION] |= WM8741_UPDATELL;
+	wm8741->reg_cache[WM8741_DACLMSB_ATTENUATION] |= WM8741_UPDATELM;
+	wm8741->reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERL;
+	wm8741->reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERM;
+
+	wm8741_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_register_dai(&wm8741_dai);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
+		snd_soc_unregister_codec(codec);
+		return ret;
+	}
+
+	dev_dbg(codec->dev, "Successful registration\n");
+	return 0;
+
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies),
wm8741->supplies);
+
+err_get:
+	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+
+err:
+	kfree(wm8741);
+	return ret;
+}
+
+static void wm8741_unregister(struct wm8741_priv *wm8741)
+{
+	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+
+	snd_soc_unregister_dai(&wm8741_dai);
+	snd_soc_unregister_codec(&wm8741->codec);
+	kfree(wm8741);
+	wm8741_codec = NULL;
+}
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8741_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct wm8741_priv *wm8741;
+	struct snd_soc_codec *codec;
+
+	wm8741 = kzalloc(sizeof(struct wm8741_priv), GFP_KERNEL);
+	if (wm8741 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8741->codec;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+
+	i2c_set_clientdata(i2c, wm8741);
+	codec->control_data = i2c;
+
+	codec->dev = &i2c->dev;
+
+	return wm8741_register(wm8741, SND_SOC_I2C);
+}
+
+static __devexit int wm8741_i2c_remove(struct i2c_client *client)
+{
+	struct wm8741_priv *wm8741 = i2c_get_clientdata(client);
+	wm8741_unregister(wm8741);
+	return 0;
+}
+
+static const struct i2c_device_id wm8741_i2c_id[] = {
+	{ "wm8741", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8741_i2c_id);
+
+
+static struct i2c_driver wm8741_i2c_driver = {
+	.driver = {
+		.name = "WM8741",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8741_i2c_probe,
+	.remove =   __devexit_p(wm8741_i2c_remove),
+	.id_table = wm8741_i2c_id,
+};
+#endif
+
+static int __init wm8741_modinit(void)
+{
+	int ret;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8741_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8741 I2C driver: %d\n",
+		       ret);
+	}
+#endif
+	return 0;
+}
+module_init(wm8741_modinit);
+
+static void __exit wm8741_exit(void)
+{
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&wm8741_i2c_driver);
+#endif
+}
+module_exit(wm8741_exit);
+
+MODULE_DESCRIPTION("ASoC WM8741 driver");
+MODULE_AUTHOR("Ian Lartey <ian@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8741.h b/sound/soc/codecs/wm8741.h
new file mode 100644
index 0000000..fdef6ec
--- /dev/null
+++ b/sound/soc/codecs/wm8741.h
@@ -0,0 +1,214 @@
+/*
+ * wm8741.h  --  WM8423 ASoC driver
+ *
+ * Copyright 2010 Wolfson Microelectronics, plc
+ *
+ * Author: Ian Lartey <ian@opensource.wolfsonmicro.com>
+ *
+ * Based on wm8753.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _WM8741_H
+#define _WM8741_H
+
+/*
+ * Register values.
+ */
+#define WM8741_DACLLSB_ATTENUATION              0x00
+#define WM8741_DACLMSB_ATTENUATION              0x01
+#define WM8741_DACRLSB_ATTENUATION              0x02
+#define WM8741_DACRMSB_ATTENUATION              0x03
+#define WM8741_VOLUME_CONTROL                   0x04
+#define WM8741_FORMAT_CONTROL                   0x05
+#define WM8741_FILTER_CONTROL                   0x06
+#define WM8741_MODE_CONTROL_1                   0x07
+#define WM8741_MODE_CONTROL_2                   0x08
+#define WM8741_RESET                            0x09
+#define WM8741_ADDITIONAL_CONTROL_1             0x20
+
+#define WM8741_REGISTER_COUNT                   11
+#define WM8741_MAX_REGISTER                     0x20
+
+/*
+ * Field Definitions.
+ */
+
+/*
+ * R0 (0x00) - DACLLSB_ATTENUATION
+ */
+#define WM8741_UPDATELL                         0x0020  /* UPDATELL */
+#define WM8741_UPDATELL_MASK                    0x0020  /* UPDATELL */
+#define WM8741_UPDATELL_SHIFT                        5  /* UPDATELL */
+#define WM8741_UPDATELL_WIDTH                        1  /* UPDATELL */
+#define WM8741_LAT_4_0_MASK                     0x001F  /* LAT[4:0] -
[4:0] */
+#define WM8741_LAT_4_0_SHIFT                         0  /* LAT[4:0] -
[4:0] */
+#define WM8741_LAT_4_0_WIDTH                         5  /* LAT[4:0] -
[4:0] */
+
+/*
+ * R1 (0x01) - DACLMSB_ATTENUATION
+ */
+#define WM8741_UPDATELM                         0x0020  /* UPDATELM */
+#define WM8741_UPDATELM_MASK                    0x0020  /* UPDATELM */
+#define WM8741_UPDATELM_SHIFT                        5  /* UPDATELM */
+#define WM8741_UPDATELM_WIDTH                        1  /* UPDATELM */
+#define WM8741_LAT_9_5_0_MASK                   0x001F  /* LAT[9:5] -
[4:0] */
+#define WM8741_LAT_9_5_0_SHIFT                       0  /* LAT[9:5] -
[4:0] */
+#define WM8741_LAT_9_5_0_WIDTH                       5  /* LAT[9:5] -
[4:0] */
+
+/*
+ * R2 (0x02) - DACRLSB_ATTENUATION
+ */
+#define WM8741_UPDATERL                         0x0020  /* UPDATERL */
+#define WM8741_UPDATERL_MASK                    0x0020  /* UPDATERL */
+#define WM8741_UPDATERL_SHIFT                        5  /* UPDATERL */
+#define WM8741_UPDATERL_WIDTH                        1  /* UPDATERL */
+#define WM8741_RAT_4_0_MASK                     0x001F  /* RAT[4:0] -
[4:0] */
+#define WM8741_RAT_4_0_SHIFT                         0  /* RAT[4:0] -
[4:0] */
+#define WM8741_RAT_4_0_WIDTH                         5  /* RAT[4:0] -
[4:0] */
+
+/*
+ * R3 (0x03) - DACRMSB_ATTENUATION
+ */
+#define WM8741_UPDATERM                         0x0020  /* UPDATERM */
+#define WM8741_UPDATERM_MASK                    0x0020  /* UPDATERM */
+#define WM8741_UPDATERM_SHIFT                        5  /* UPDATERM */
+#define WM8741_UPDATERM_WIDTH                        1  /* UPDATERM */
+#define WM8741_RAT_9_5_0_MASK                   0x001F  /* RAT[9:5] -
[4:0] */
+#define WM8741_RAT_9_5_0_SHIFT                       0  /* RAT[9:5] -
[4:0] */
+#define WM8741_RAT_9_5_0_WIDTH                       5  /* RAT[9:5] -
[4:0] */
+
+/*
+ * R4 (0x04) - VOLUME_CONTROL
+ */
+#define WM8741_AMUTE                            0x0080  /* AMUTE */
+#define WM8741_AMUTE_MASK                       0x0080  /* AMUTE */
+#define WM8741_AMUTE_SHIFT                           7  /* AMUTE */
+#define WM8741_AMUTE_WIDTH                           1  /* AMUTE */
+#define WM8741_ZFLAG_MASK                       0x0060  /* ZFLAG -
[6:5] */
+#define WM8741_ZFLAG_SHIFT                           5  /* ZFLAG -
[6:5] */
+#define WM8741_ZFLAG_WIDTH                           2  /* ZFLAG -
[6:5] */
+#define WM8741_IZD                              0x0010  /* IZD */
+#define WM8741_IZD_MASK                         0x0010  /* IZD */
+#define WM8741_IZD_SHIFT                             4  /* IZD */
+#define WM8741_IZD_WIDTH                             1  /* IZD */
+#define WM8741_SOFT                             0x0008  /* SOFT MUTE */
+#define WM8741_SOFT_MASK                        0x0008  /* SOFT MUTE */
+#define WM8741_SOFT_SHIFT                            3  /* SOFT MUTE */
+#define WM8741_SOFT_WIDTH                            1  /* SOFT MUTE */
+#define WM8741_ATC                              0x0004  /* ATC */
+#define WM8741_ATC_MASK                         0x0004  /* ATC */
+#define WM8741_ATC_SHIFT                             2  /* ATC */
+#define WM8741_ATC_WIDTH                             1  /* ATC */
+#define WM8741_ATT2DB                           0x0002  /* ATT2DB */
+#define WM8741_ATT2DB_MASK                      0x0002  /* ATT2DB */
+#define WM8741_ATT2DB_SHIFT                          1  /* ATT2DB */
+#define WM8741_ATT2DB_WIDTH                          1  /* ATT2DB */
+#define WM8741_VOL_RAMP                         0x0001  /* VOL_RAMP */
+#define WM8741_VOL_RAMP_MASK                    0x0001  /* VOL_RAMP */
+#define WM8741_VOL_RAMP_SHIFT                        0  /* VOL_RAMP */
+#define WM8741_VOL_RAMP_WIDTH                        1  /* VOL_RAMP */
+
+/*
+ * R5 (0x05) - FORMAT_CONTROL
+ */
+#define WM8741_PWDN                             0x0080  /* PWDN */
+#define WM8741_PWDN_MASK                        0x0080  /* PWDN */
+#define WM8741_PWDN_SHIFT                            7  /* PWDN */
+#define WM8741_PWDN_WIDTH                            1  /* PWDN */
+#define WM8741_REV                              0x0040  /* REV */
+#define WM8741_REV_MASK                         0x0040  /* REV */
+#define WM8741_REV_SHIFT                             6  /* REV */
+#define WM8741_REV_WIDTH                             1  /* REV */
+#define WM8741_BCP                              0x0020  /* BCP */
+#define WM8741_BCP_MASK                         0x0020  /* BCP */
+#define WM8741_BCP_SHIFT                             5  /* BCP */
+#define WM8741_BCP_WIDTH                             1  /* BCP */
+#define WM8741_LRP                              0x0010  /* LRP */
+#define WM8741_LRP_MASK                         0x0010  /* LRP */
+#define WM8741_LRP_SHIFT                             4  /* LRP */
+#define WM8741_LRP_WIDTH                             1  /* LRP */
+#define WM8741_FMT_MASK                         0x000C  /* FMT - [3:2]
*/
+#define WM8741_FMT_SHIFT                             2  /* FMT - [3:2]
*/
+#define WM8741_FMT_WIDTH                             2  /* FMT - [3:2]
*/
+#define WM8741_IWL_MASK                         0x0003  /* IWL - [1:0]
*/
+#define WM8741_IWL_SHIFT                             0  /* IWL - [1:0]
*/
+#define WM8741_IWL_WIDTH                             2  /* IWL - [1:0]
*/
+
+/*
+ * R6 (0x06) - FILTER_CONTROL
+ */
+#define WM8741_ZFLAG_HI                         0x0080  /* ZFLAG_HI */
+#define WM8741_ZFLAG_HI_MASK                    0x0080  /* ZFLAG_HI */
+#define WM8741_ZFLAG_HI_SHIFT                        7  /* ZFLAG_HI */
+#define WM8741_ZFLAG_HI_WIDTH                        1  /* ZFLAG_HI */
+#define WM8741_DEEMPH_MASK                      0x0060  /* DEEMPH -
[6:5] */
+#define WM8741_DEEMPH_SHIFT                          5  /* DEEMPH -
[6:5] */
+#define WM8741_DEEMPH_WIDTH                          2  /* DEEMPH -
[6:5] */
+#define WM8741_DSDFILT_MASK                     0x0018  /* DSDFILT -
[4:3] */
+#define WM8741_DSDFILT_SHIFT                         3  /* DSDFILT -
[4:3] */
+#define WM8741_DSDFILT_WIDTH                         2  /* DSDFILT -
[4:3] */
+#define WM8741_FIRSEL_MASK                      0x0007  /* FIRSEL -
[2:0] */
+#define WM8741_FIRSEL_SHIFT                          0  /* FIRSEL -
[2:0] */
+#define WM8741_FIRSEL_WIDTH                          3  /* FIRSEL -
[2:0] */
+
+/*
+ * R7 (0x07) - MODE_CONTROL_1
+ */
+#define WM8741_MODE8X                           0x0080  /* MODE8X */
+#define WM8741_MODE8X_MASK                      0x0080  /* MODE8X */
+#define WM8741_MODE8X_SHIFT                          7  /* MODE8X */
+#define WM8741_MODE8X_WIDTH                          1  /* MODE8X */
+#define WM8741_OSR_MASK                         0x0060  /* OSR - [6:5]
*/
+#define WM8741_OSR_SHIFT                             5  /* OSR - [6:5]
*/
+#define WM8741_OSR_WIDTH                             2  /* OSR - [6:5]
*/
+#define WM8741_SR_MASK                          0x001C  /* SR - [4:2]
*/
+#define WM8741_SR_SHIFT                              2  /* SR - [4:2]
*/
+#define WM8741_SR_WIDTH                              3  /* SR - [4:2]
*/
+#define WM8741_MODESEL_MASK                     0x0003  /* MODESEL -
[1:0] */
+#define WM8741_MODESEL_SHIFT                         0  /* MODESEL -
[1:0] */
+#define WM8741_MODESEL_WIDTH                         2  /* MODESEL -
[1:0] */
+
+/*
+ * R8 (0x08) - MODE_CONTROL_2
+ */
+#define WM8741_DSD_GAIN                         0x0040  /* DSD_GAIN */
+#define WM8741_DSD_GAIN_MASK                    0x0040  /* DSD_GAIN */
+#define WM8741_DSD_GAIN_SHIFT                        6  /* DSD_GAIN */
+#define WM8741_DSD_GAIN_WIDTH                        1  /* DSD_GAIN */
+#define WM8741_SDOUT                            0x0020  /* SDOUT */
+#define WM8741_SDOUT_MASK                       0x0020  /* SDOUT */
+#define WM8741_SDOUT_SHIFT                           5  /* SDOUT */
+#define WM8741_SDOUT_WIDTH                           1  /* SDOUT */
+#define WM8741_DOUT                             0x0010  /* DOUT */
+#define WM8741_DOUT_MASK                        0x0010  /* DOUT */
+#define WM8741_DOUT_SHIFT                            4  /* DOUT */
+#define WM8741_DOUT_WIDTH                            1  /* DOUT */
+#define WM8741_DIFF_MASK                        0x000C  /* DIFF - [3:2]
*/
+#define WM8741_DIFF_SHIFT                            2  /* DIFF - [3:2]
*/
+#define WM8741_DIFF_WIDTH                            2  /* DIFF - [3:2]
*/
+#define WM8741_DITHER_MASK                      0x0003  /* DITHER -
[1:0] */
+#define WM8741_DITHER_SHIFT                          0  /* DITHER -
[1:0] */
+#define WM8741_DITHER_WIDTH                          2  /* DITHER -
[1:0] */
+
+/*
+ * R32 (0x20) - ADDITONAL_CONTROL_1
+ */
+#define WM8741_DSD_LEVEL                        0x0002  /* DSD_LEVEL */
+#define WM8741_DSD_LEVEL_MASK                   0x0002  /* DSD_LEVEL */
+#define WM8741_DSD_LEVEL_SHIFT                       1  /* DSD_LEVEL */
+#define WM8741_DSD_LEVEL_WIDTH                       1  /* DSD_LEVEL */
+#define WM8741_DSD_NO_NOTCH                     0x0001  /* DSD_NO_NOTCH
*/
+#define WM8741_DSD_NO_NOTCH_MASK                0x0001  /* DSD_NO_NOTCH
*/
+#define WM8741_DSD_NO_NOTCH_SHIFT                    0  /* DSD_NO_NOTCH
*/
+#define WM8741_DSD_NO_NOTCH_WIDTH                    1  /* DSD_NO_NOTCH
*/
+
+#define  WM8741_SYSCLK 0
+
+extern struct snd_soc_dai wm8741_dai;
+extern struct snd_soc_codec_device soc_codec_dev_wm8741;
+
+#endif
-- 
1.7.0.4
