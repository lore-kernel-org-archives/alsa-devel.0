From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Fri,  7 Feb 2014 13:05:15 +0800
Message-ID: <1391749517-11787-2-git-send-email-xobs@kosagi.com>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391749517-11787-1-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add support for the ES8328 audio codec.
---
 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es8328.c | 611 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/es8328.h | 240 ++++++++++++++++++
 4 files changed, 857 insertions(+)
 create mode 100644 sound/soc/codecs/es8328.c
 create mode 100644 sound/soc/codecs/es8328.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 983d087a..2b0a821 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -43,6 +43,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_BT_SCO
+	select SND_SOC_ES8328 if I2C
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -283,6 +284,9 @@ config SND_SOC_BT_SCO
 config SND_SOC_DMIC
 	tristate
 
+config SND_SOC_ES8328
+	tristate
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bc12676..1b62c93 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -30,6 +30,7 @@ snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-dmic-objs := dmic.o
+snd-soc-es8328-objs := es8328.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -163,6 +164,7 @@ obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
+obj-$(CONFIG_SND_SOC_ES8328)    += snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
new file mode 100644
index 0000000..db118f4
--- /dev/null
+++ b/sound/soc/codecs/es8328.c
@@ -0,0 +1,611 @@
+/*
+ * es8328.c  --  ES8328 ALSA SoC Audio driver
+ *
+ * Copyright 2014 Sutajio Ko-Usagi PTE LTD
+ *
+ * Author: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include "es8328.h"
+
+/* Run the codec at 22.5792 MHz to support these rates */
+enum es8328_rate {
+	ES8328_RATE_8019,
+	ES8328_RATE_11025,
+	ES8328_RATE_22050,
+	ES8328_RATE_44100,
+};
+
+uint8_t sample_ratios[] = {
+	[ES8328_RATE_8019 ] = 0x9,
+	[ES8328_RATE_11025] = 0x7,
+	[ES8328_RATE_22050] = 0x4,
+	[ES8328_RATE_44100] = 0x2,
+};
+
+#define ES8328_RATES (SNDRV_PCM_RATE_44100 | \
+		SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_11025)
+#define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+
+/* codec private data */
+struct es8328_priv {
+	struct regmap *regmap;
+	int sysclk;
+};
+
+static const DECLARE_TLV_DB_SCALE(play_tlv, -3000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(cap_tlv, -9600, 50, 0);
+static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);
+
+static const struct snd_kcontrol_new es8328_snd_controls[] = {
+SOC_DOUBLE_R_TLV("Speaker Playback Volume",
+		ES8328_DACCONTROL26, ES8328_DACCONTROL27, 0, 0x24, 0, play_tlv),
+SOC_DOUBLE_R_TLV("Headphone Playback Volume",
+		ES8328_DACCONTROL24, ES8328_DACCONTROL25, 0, 0x24, 0, play_tlv),
+
+SOC_DOUBLE_R_TLV("Mic Capture Volume",
+		ES8328_ADCCONTROL8, ES8328_ADCCONTROL9, 0, 0xc0, 1, cap_tlv),
+SOC_DOUBLE_TLV("Mic PGA Volume",
+		ES8328_ADCCONTROL1, 4, 0, 0x08, 0, pga_tlv),
+};
+
+/*
+ * DAPM controls.
+ */
+static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("Speaker Volume", "HiFi Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("VOUTL"),
+	SND_SOC_DAPM_OUTPUT("VOUTR"),
+        SND_SOC_DAPM_INPUT("LINE_IN"),
+        SND_SOC_DAPM_INPUT("MIC_IN"),
+        SND_SOC_DAPM_OUTPUT("HP_OUT"),
+        SND_SOC_DAPM_OUTPUT("SPK_OUT"),
+};
+
+
+static const struct snd_soc_dapm_route es8328_intercon[] = {
+	{"VOUTL", NULL, "DAC"},
+	{"VOUTR", NULL, "DAC"},
+};
+
+static int es8328_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 mute_reg = snd_soc_read(codec, ES8328_DACCONTROL3);
+
+	if (mute)
+		mute_reg |= ES8328_DACCONTROL3_DACMUTE;
+	else
+		mute_reg &= ~ES8328_DACCONTROL3_DACMUTE;
+	return snd_soc_write(codec, ES8328_DACCONTROL3, mute_reg);
+}
+
+static int es8328_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		u8 dac = snd_soc_read(codec, ES8328_DACCONTROL2);
+		dac &= ~ES8328_DACCONTROL2_RATEMASK;
+
+		switch (params_rate(params)) {
+		case 8000:
+			dac |= sample_ratios[ES8328_RATE_8019];
+			break;
+		case 11025:
+			dac |= sample_ratios[ES8328_RATE_11025];
+			break;
+		case 22050:
+			dac |= sample_ratios[ES8328_RATE_22050];
+			break;
+		case 44100:
+			dac |= sample_ratios[ES8328_RATE_44100];
+			break;
+		default:
+			dev_err(codec->dev, "%s: unknown rate %d\n",
+				 __func__, params_rate(params));
+			return -EINVAL;
+		}
+		snd_soc_write(codec, ES8328_DACCONTROL2, dac);
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		u8 adc = snd_soc_read(codec, ES8328_ADCCONTROL5);
+		adc &= ~ES8328_ADCCONTROL5_RATEMASK;
+
+		switch (params_rate(params)) {
+		case 8000:
+			adc |= sample_ratios[ES8328_RATE_8019];
+			break;
+		case 11025:
+			adc |= sample_ratios[ES8328_RATE_11025];
+			break;
+		case 22050:
+			adc |= sample_ratios[ES8328_RATE_22050];
+			break;
+		case 44100:
+			adc |= sample_ratios[ES8328_RATE_44100];
+			break;
+		default:
+			dev_err(codec->dev, "%s: unknown rate %d\n",
+				 __func__, params_rate(params));
+			return -EINVAL;
+		}
+		snd_soc_write(codec, ES8328_ADCCONTROL5, adc);
+	}
+
+	return 0;
+}
+
+static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_I2S)
+		return -EINVAL;
+
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
+		return -EINVAL;
+
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int es8328_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+			         int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case 0:
+		es8328->sysclk = freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int es8328_adc_enable(struct snd_soc_codec *codec)
+{
+	u16 reg = snd_soc_read(codec, ES8328_CHIPPOWER);
+	reg &= ~(ES8328_CHIPPOWER_ADCVREF_OFF |
+		 ES8328_CHIPPOWER_ADCPLL_OFF |
+		 ES8328_CHIPPOWER_ADCSTM_RESET |
+		 ES8328_CHIPPOWER_ADCDIG_OFF);
+	snd_soc_write(codec, ES8328_CHIPPOWER, reg);
+
+	/* Set up microphone to be differential input */
+	snd_soc_write(codec, ES8328_ADCCONTROL2, 0xf0);
+
+	/* Set ADC to act as I2S master */
+	snd_soc_write(codec, ES8328_ADCCONTROL3, 0x02);
+
+	/* Set I2S to 16-bit mode */
+	snd_soc_write(codec, ES8328_ADCCONTROL4, 0x18);
+
+	/* Frequency clock of 272 */
+	snd_soc_write(codec, ES8328_ADCCONTROL5, 0x02);
+
+	return 0;
+}
+
+static int es8328_dac_enable(struct snd_soc_codec *codec)
+{
+	u16 old_volumes[4];
+	u16 reg;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		old_volumes[i] = snd_soc_read(codec, i + ES8328_DACCONTROL24);
+		snd_soc_write(codec, i + ES8328_DACCONTROL24, 0);
+	}
+
+	/* Power up LOUT2 ROUT2, and power down xOUT1 */
+	snd_soc_write(codec, ES8328_DACPOWER,
+			ES8328_DACPOWER_ROUT2_ON |
+			ES8328_DACPOWER_LOUT2_ON);
+
+	/* Enable click-free power up */
+	snd_soc_write(codec, ES8328_DACCONTROL6, ES8328_DACCONTROL6_CLICKFREE);
+	snd_soc_write(codec, ES8328_DACCONTROL3, 0x36);
+
+	/* Set I2S to 16-bit mode */
+	snd_soc_write(codec, ES8328_DACCONTROL1, ES8328_DACCONTROL1_DACWL_16);
+
+	/* No attenuation */
+	snd_soc_write(codec, ES8328_DACCONTROL4, 0x00);
+	snd_soc_write(codec, ES8328_DACCONTROL5, 0x00);
+
+	/* Set LIN2 for the output mixer */
+	snd_soc_write(codec, ES8328_DACCONTROL16,
+			ES8328_DACCONTROL16_RMIXSEL_RIN2 |
+			ES8328_DACCONTROL16_LMIXSEL_LIN2);
+
+	/* Point the left DAC at the left mixer */
+	snd_soc_write(codec, ES8328_DACCONTROL17, ES8328_DACCONTROL17_LD2LO);
+	/* Point the right DAC at the right mixer */
+	snd_soc_write(codec, ES8328_DACCONTROL20, ES8328_DACCONTROL20_RD2RO);
+
+	/* Disable all other outputs */
+	snd_soc_write(codec, ES8328_DACCONTROL18, 0x00);
+	snd_soc_write(codec, ES8328_DACCONTROL19, 0x00);
+
+
+	/* Disable mono mode for DACL, and mute DACR */
+	snd_soc_write(codec, ES8328_DACCONTROL7, 0x00);
+
+	for (i = 0; i < 4; i++)
+		snd_soc_write(codec, i + ES8328_DACCONTROL24, old_volumes[i]);
+
+	reg = snd_soc_read(codec, ES8328_CHIPPOWER);
+	reg &= ~(ES8328_CHIPPOWER_DACVREF_OFF |
+		 ES8328_CHIPPOWER_DACPLL_OFF |
+		 ES8328_CHIPPOWER_DACSTM_RESET |
+		 ES8328_CHIPPOWER_DACDIG_OFF);
+	snd_soc_write(codec, ES8328_CHIPPOWER, reg);
+	snd_soc_write(codec, ES8328_DACCONTROL3, 0x32);
+
+	return 0;
+}
+
+static int es8328_pcm_prepare(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		es8328_dac_enable(codec);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		es8328_adc_enable(codec);
+
+	return 0;
+}
+
+static void es8328_pcm_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 reg;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* Mute DAC */
+		snd_soc_write(codec, ES8328_DACCONTROL3,
+				ES8328_DACCONTROL3_DACZEROCROSS |
+				ES8328_DACCONTROL3_DACSOFTRAMP |
+				ES8328_DACCONTROL3_DACMUTE);
+
+		/* Power down DAC and disable LOUT/ROUT */
+		snd_soc_write(codec, ES8328_DACPOWER,
+				ES8328_DACPOWER_LDAC_OFF |
+				ES8328_DACPOWER_RDAC_OFF);
+
+		/* Power down DEM and STM */
+		reg = snd_soc_read(codec, ES8328_CHIPPOWER);
+		reg |= (ES8328_CHIPPOWER_DACVREF_OFF |
+			ES8328_CHIPPOWER_DACPLL_OFF |
+			ES8328_CHIPPOWER_DACDIG_OFF);
+		snd_soc_write(codec, ES8328_CHIPPOWER, reg);
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		/* Mute ADC */
+		snd_soc_write(codec, ES8328_ADCCONTROL7,
+			ES8328_ADCCONTROL7_ADC_LER |
+			ES8328_ADCCONTROL7_ADC_ZERO_CROSS |
+			ES8328_ADCCONTROL7_ADC_SOFT_RAMP);
+
+		/* Power down ADC */
+		snd_soc_write(codec, ES8328_ADCPOWER,
+			ES8328_ADCPOWER_ADC_BIAS_GEN_OFF |
+			ES8328_ADCPOWER_MIC_BIAS_OFF |
+			ES8328_ADCPOWER_ADCR_OFF |
+			ES8328_ADCPOWER_ADCL_OFF |
+			ES8328_ADCPOWER_AINR_OFF |
+			ES8328_ADCPOWER_AINL_OFF);
+
+		/* Power down DEM and STM */
+		reg = snd_soc_read(codec, ES8328_CHIPPOWER);
+		reg |= (ES8328_CHIPPOWER_ADCVREF_OFF |
+			ES8328_CHIPPOWER_ADCPLL_OFF |
+			ES8328_CHIPPOWER_ADCDIG_OFF);
+		snd_soc_write(codec, ES8328_CHIPPOWER, reg);
+	}
+
+	return;
+}
+
+static int es8328_init(struct snd_soc_codec *codec)
+{
+	/* Master serial port mode */
+	snd_soc_write(codec, ES8328_MASTERMODE,
+			ES8328_MASTERMODE_MCLKDIV2 |
+			ES8328_MASTERMODE_MSC);
+
+	/* Power everything down and reset the cip */
+	snd_soc_write(codec, ES8328_CHIPPOWER,
+			ES8328_CHIPPOWER_DACSTM_RESET |
+			ES8328_CHIPPOWER_ADCSTM_RESET |
+			ES8328_CHIPPOWER_DACDIG_OFF |
+			ES8328_CHIPPOWER_ADCDIG_OFF |
+			ES8328_CHIPPOWER_DACVREF_OFF |
+			ES8328_CHIPPOWER_ADCVREF_OFF);
+
+	/* Power up.  Set ADC and DAC to use different frequency ratios */
+	snd_soc_write(codec, ES8328_CONTROL1,
+			ES8328_CONTROL1_VMIDSEL_50k |
+			ES8328_CONTROL1_ENREF);
+
+	/* Power up more blocks */
+	snd_soc_write(codec, ES8328_CONTROL2,
+			ES8328_CONTROL2_OVERCURRENT_ON |
+			ES8328_CONTROL2_THERMAL_SHUTDOWN_ON);
+
+
+	/* Power on the chip (but leave VRET off) */
+	/*
+	snd_soc_write(codec, ES8328_CHIPPOWER,
+			ES8328_CHIPPOWER_DACVREF_OFF |
+			ES8328_CHIPPOWER_ADCVREF_OFF);
+	*/
+
+
+	/* Enable muting, and turn on zerocross */
+	snd_soc_write(codec, ES8328_DACCONTROL3,
+			ES8328_DACCONTROL3_DACZEROCROSS |
+			ES8328_DACCONTROL3_DACSOFTRAMP |
+			ES8328_DACCONTROL3_DACMUTE);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops es8328_dai_ops = {
+	.hw_params	= es8328_hw_params,
+	.prepare	= es8328_pcm_prepare,
+	.shutdown	= es8328_pcm_shutdown,
+//	.digital_mute	= es8328_mute,
+	.set_fmt	= es8328_set_dai_fmt,
+	.set_sysclk	= es8328_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_driver es8328_dai = {
+	.name = "es8328-hifi-analog",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = ES8328_RATES,
+		.formats = ES8328_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = ES8328_RATES,
+		.formats = ES8328_FORMATS,
+	},
+	.ops = &es8328_dai_ops,
+};
+
+static int es8328_suspend(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static int es8328_resume(struct snd_soc_codec *codec)
+{
+	es8328_init(codec);
+	return 0;
+}
+
+static int es8328_probe(struct snd_soc_codec *codec)
+{
+	int ret;
+	struct device *dev = codec->dev;
+
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
+	if (ret < 0) {
+		dev_err(dev, "failed to configure cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	/* power on device */
+	es8328_init(codec);
+
+	return 0;
+}
+
+static int es8328_remove(struct snd_soc_codec *codec)
+{
+	/* Power everything down and reset the cip */
+	snd_soc_write(codec, ES8328_CHIPPOWER,
+			ES8328_CHIPPOWER_DACSTM_RESET |
+			ES8328_CHIPPOWER_ADCSTM_RESET |
+			ES8328_CHIPPOWER_DACDIG_OFF |
+			ES8328_CHIPPOWER_ADCDIG_OFF |
+			ES8328_CHIPPOWER_DACVREF_OFF |
+			ES8328_CHIPPOWER_ADCVREF_OFF);
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_es8328 = {
+	.probe =		es8328_probe,
+	.remove =		es8328_remove,
+	.suspend =		es8328_suspend,
+	.resume =		es8328_resume,
+	.controls =		es8328_snd_controls,
+	.num_controls =		ARRAY_SIZE(es8328_snd_controls),
+	.dapm_widgets =		es8328_dapm_widgets,
+	.num_dapm_widgets =	ARRAY_SIZE(es8328_dapm_widgets),
+	.dapm_routes =		es8328_intercon,
+	.num_dapm_routes =	ARRAY_SIZE(es8328_intercon),
+};
+
+static const struct of_device_id es8328_of_match[] = {
+	{ .compatible = "everest,es8328", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, es8328_of_match);
+
+static const struct regmap_config es8328_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ES8328_REG_MAX,
+
+	.cache_type = REGCACHE_NONE,
+};
+
+#if defined(CONFIG_SPI_MASTER)
+static int es8328_spi_probe(struct spi_device *spi)
+{
+	struct es8328_priv *es8328;
+	int ret;
+
+	es8328 = devm_kzalloc(&spi->dev, sizeof(struct es8328_priv),
+			      GFP_KERNEL);
+	if (es8328 == NULL)
+		return -ENOMEM;
+
+	es8328->regmap = devm_regmap_init_spi(spi, &es8328_regmap);
+	if (IS_ERR(es8328->regmap))
+		return PTR_ERR(es8328->regmap);
+
+	spi_set_drvdata(spi, es8328);
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_es8328, &es8328_dai, 1);
+	if (ret < 0)
+		dev_err(&spi->dev, "unable to register codec: %d\n", ret);
+
+	return ret;
+}
+
+static int es8328_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+
+	return 0;
+}
+
+static struct spi_driver es8328_spi_driver = {
+	.driver = {
+		.name	= "es8328",
+		.owner	= THIS_MODULE,
+		.of_match_table = es8328_of_match,
+	},
+	.probe		= es8328_spi_probe,
+	.remove		= es8328_spi_remove,
+};
+#endif /* CONFIG_SPI_MASTER */
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static int es8328_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct es8328_priv *es8328;
+	int ret;
+
+	es8328 = devm_kzalloc(&i2c->dev, sizeof(struct es8328_priv),
+			      GFP_KERNEL);
+	if (es8328 == NULL)
+		return -ENOMEM;
+
+	es8328->regmap = devm_regmap_init_i2c(i2c, &es8328_regmap);
+	if (IS_ERR(es8328->regmap))
+		return PTR_ERR(es8328->regmap);
+
+	i2c_set_clientdata(i2c, es8328);
+
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_es8328, &es8328_dai, 1);
+
+	return ret;
+}
+
+static int es8328_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id es8328_i2c_id[] = {
+	{ "es8328", 0x11 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, es8328_i2c_id);
+
+static struct i2c_driver es8328_i2c_driver = {
+	.driver = {
+		.name = "es8328-codec",
+		.owner = THIS_MODULE,
+		.of_match_table = es8328_of_match,
+	},
+	.probe =    es8328_i2c_probe,
+	.remove =   es8328_i2c_remove,
+	.id_table = es8328_i2c_id,
+};
+#endif
+
+static int __init es8328_modinit(void)
+{
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&es8328_i2c_driver);
+	if (ret != 0) {
+		pr_err("failed to register es8328 I2C driver: %d\n", ret);
+	}
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&es8328_spi_driver);
+	if (ret != 0) {
+		pr_err("Failed to register es8328 SPI driver: %d\n", ret);
+	}
+#endif
+	return ret;
+}
+module_init(es8328_modinit);
+
+static void __exit es8328_exit(void)
+{
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&es8328_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&es8328_spi_driver);
+#endif
+}
+module_exit(es8328_exit);
+
+MODULE_DESCRIPTION("ASoC ES8328 driver");
+MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
new file mode 100644
index 0000000..234a6cb
--- /dev/null
+++ b/sound/soc/codecs/es8328.h
@@ -0,0 +1,240 @@
+/*
+ * es8328.h  --  ES8328 ALSA SoC Audio driver
+ */
+
+#ifndef _ES8328_H
+#define _ES8328_H
+
+#define ES8328_DACLVOL 46
+#define ES8328_DACRVOL 47
+#define ES8328_DACCTL 28
+
+#define ES8328_CONTROL1		0x00
+#define ES8328_CONTROL1_VMIDSEL_OFF (0 << 0)
+#define ES8328_CONTROL1_VMIDSEL_50k (1 << 0)
+#define ES8328_CONTROL1_VMIDSEL_500k (2 << 0)
+#define ES8328_CONTROL1_VMIDSEL_5k (3 << 0)
+#define ES8328_CONTROL1_ENREF (1 << 2)
+#define ES8328_CONTROL1_SEQEN (1 << 3)
+#define ES8328_CONTROL1_SAMEFS (1 << 4)
+#define ES8328_CONTROL1_DACMCLK_ADC (0 << 5)
+#define ES8328_CONTROL1_DACMCLK_DAC (1 << 5)
+#define ES8328_CONTROL1_LRCM (1 << 6)
+#define ES8328_CONTROL1_SCP_RESET (1 << 7)
+
+#define ES8328_CONTROL2		0x01
+#define ES8328_CONTROL2_VREF_BUF_OFF (1 << 0)
+#define ES8328_CONTROL2_VREF_LOWPOWER (1 << 1)
+#define ES8328_CONTROL2_IBIASGEN_OFF (1 << 2)
+#define ES8328_CONTROL2_ANALOG_OFF (1 << 3)
+#define ES8328_CONTROL2_VREF_BUF_LOWPOWER (1 << 4)
+#define ES8328_CONTROL2_VCM_MOD_LOWPOWER (1 << 5)
+#define ES8328_CONTROL2_OVERCURRENT_ON (1 << 6)
+#define ES8328_CONTROL2_THERMAL_SHUTDOWN_ON (1 << 7)
+
+#define ES8328_CHIPPOWER	0x02
+#define ES8328_CHIPPOWER_DACVREF_OFF (1 << 0)
+#define ES8328_CHIPPOWER_ADCVREF_OFF (1 << 1)
+#define ES8328_CHIPPOWER_DACPLL_OFF (1 << 2)
+#define ES8328_CHIPPOWER_ADCPLL_OFF (1 << 3)
+#define ES8328_CHIPPOWER_DACSTM_RESET (1 << 4)
+#define ES8328_CHIPPOWER_ADCSTM_RESET (1 << 5)
+#define ES8328_CHIPPOWER_DACDIG_OFF (1 << 6)
+#define ES8328_CHIPPOWER_ADCDIG_OFF (1 << 7)
+
+#define ES8328_ADCPOWER		0x03
+#define ES8328_ADCPOWER_INT1_LOWPOWER (1 << 0)
+#define ES8328_ADCPOWER_FLASH_ADC_LOWPOWER (1 << 1)
+#define ES8328_ADCPOWER_ADC_BIAS_GEN_OFF (1 << 2)
+#define ES8328_ADCPOWER_MIC_BIAS_OFF (1 << 3)
+#define ES8328_ADCPOWER_ADCR_OFF (1 << 4)
+#define ES8328_ADCPOWER_ADCL_OFF (1 << 5)
+#define ES8328_ADCPOWER_AINR_OFF (1 << 6)
+#define ES8328_ADCPOWER_AINL_OFF (1 << 7)
+
+#define ES8328_DACPOWER		0x04
+#define ES8328_DACPOWER_OUT3_ON (1 << 0)
+#define ES8328_DACPOWER_MONO_ON (1 << 1)
+#define ES8328_DACPOWER_ROUT2_ON (1 << 2)
+#define ES8328_DACPOWER_LOUT2_ON (1 << 3)
+#define ES8328_DACPOWER_ROUT1_ON (1 << 4)
+#define ES8328_DACPOWER_LOUT1_ON (1 << 5)
+#define ES8328_DACPOWER_RDAC_OFF (1 << 6)
+#define ES8328_DACPOWER_LDAC_OFF (1 << 7)
+
+#define ES8328_CHIPLOPOW1	0x05
+#define ES8328_CHIPLOPOW2	0x06
+#define ES8328_ANAVOLMANAG	0x07
+
+#define ES8328_MASTERMODE	0x08
+#define ES8328_MASTERMODE_BCLKDIV (0 << 0)
+#define ES8328_MASTERMODE_BCLK_INV (1 << 5)
+#define ES8328_MASTERMODE_MCLKDIV2 (1 << 6)
+#define ES8328_MASTERMODE_MSC (1 << 7)
+
+#define ES8328_ADCCONTROL1	0x09
+#define ES8328_ADCCONTROL2	0x0a
+#define ES8328_ADCCONTROL3	0x0b
+#define ES8328_ADCCONTROL4	0x0c
+#define ES8328_ADCCONTROL5	0x0d
+#define ES8328_ADCCONTROL5_RATEMASK (0x1f << 0)
+
+#define ES8328_ADCCONTROL6	0x0e
+
+#define ES8328_ADCCONTROL7	0x0f
+#define ES8328_ADCCONTROL7_ADC_MUTE (1 << 2)
+#define ES8328_ADCCONTROL7_ADC_LER (1 << 3)
+#define ES8328_ADCCONTROL7_ADC_ZERO_CROSS (1 << 4)
+#define ES8328_ADCCONTROL7_ADC_SOFT_RAMP (1 << 5)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_4 (0 << 6)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_8 (1 << 6)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_16 (2 << 6)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_32 (3 << 6)
+
+#define ES8328_ADCCONTROL8	0x10
+#define ES8328_ADCCONTROL9	0x11
+#define ES8328_ADCCONTROL10	0x12
+#define ES8328_ADCCONTROL11	0x13
+#define ES8328_ADCCONTROL12	0x14
+#define ES8328_ADCCONTROL13	0x15
+#define ES8328_ADCCONTROL14	0x16
+
+#define ES8328_DACCONTROL1	0x17
+#define ES8328_DACCONTROL1_DACFORMAT_I2S (0 << 1)
+#define ES8328_DACCONTROL1_DACFORMAT_LJUST (1 << 1)
+#define ES8328_DACCONTROL1_DACFORMAT_RJUST (2 << 1)
+#define ES8328_DACCONTROL1_DACFORMAT_PCM (3 << 1)
+#define ES8328_DACCONTROL1_DACWL_24 (0 << 3)
+#define ES8328_DACCONTROL1_DACWL_20 (1 << 3)
+#define ES8328_DACCONTROL1_DACWL_18 (2 << 3)
+#define ES8328_DACCONTROL1_DACWL_16 (3 << 3)
+#define ES8328_DACCONTROL1_DACWL_32 (4 << 3)
+#define ES8328_DACCONTROL1_DACLRP_I2S_POL_NORMAL (0 << 6)
+#define ES8328_DACCONTROL1_DACLRP_I2S_POL_INV (1 << 6)
+#define ES8328_DACCONTROL1_DACLRP_PCM_MSB_CLK2 (0 << 6)
+#define ES8328_DACCONTROL1_DACLRP_PCM_MSB_CLK1 (0 << 6)
+#define ES8328_DACCONTROL1_LRSWAP (1 << 7)
+
+#define ES8328_DACCONTROL2	0x18
+#define ES8328_DACCONTROL2_RATEMASK (0x1f << 0)
+
+#define ES8328_DACCONTROL3	0x19
+#define ES8328_DACCONTROL3_AUTOMUTE (1 << 2)
+#define ES8328_DACCONTROL3_DACMUTE (1 << 2)
+#define ES8328_DACCONTROL3_LEFTGAINVOL (1 << 3)
+#define ES8328_DACCONTROL3_DACZEROCROSS (1 << 4)
+#define ES8328_DACCONTROL3_DACSOFTRAMP (1 << 5)
+#define ES8328_DACCONTROL3_DACRAMPRATE (3 << 6)
+
+#define ES8328_DACCONTROL4	0x1a
+#define ES8328_DACCONTROL5	0x1b
+
+#define ES8328_DACCONTROL6	0x1c
+#define ES8328_DACCONTROL6_CLICKFREE (1 << 3)
+#define ES8328_DACCONTROL6_DAC_INVR (1 << 4)
+#define ES8328_DACCONTROL6_DAC_INVL (1 << 5)
+#define ES8328_DACCONTROL6_DEEMPH_OFF (0 << 6)
+#define ES8328_DACCONTROL6_DEEMPH_32k (1 << 6)
+#define ES8328_DACCONTROL6_DEEMPH_44_1k (2 << 6)
+#define ES8328_DACCONTROL6_DEEMPH_48k (3 << 6)
+
+#define ES8328_DACCONTROL7	0x1d
+#define ES8328_DACCONTROL8	0x1e
+#define ES8328_DACCONTROL9	0x1f
+#define ES8328_DACCONTROL10	0x20
+#define ES8328_DACCONTROL11	0x21
+#define ES8328_DACCONTROL12	0x22
+#define ES8328_DACCONTROL13	0x23
+#define ES8328_DACCONTROL14	0x24
+#define ES8328_DACCONTROL15	0x25
+
+#define ES8328_DACCONTROL16	0x26
+#define ES8328_DACCONTROL16_RMIXSEL_RIN1 (0 << 0)
+#define ES8328_DACCONTROL16_RMIXSEL_RIN2 (1 << 0)
+#define ES8328_DACCONTROL16_RMIXSEL_RIN3 (2 << 0)
+#define ES8328_DACCONTROL16_RMIXSEL_RADC (3 << 0)
+#define ES8328_DACCONTROL16_LMIXSEL_LIN1 (0 << 3)
+#define ES8328_DACCONTROL16_LMIXSEL_LIN2 (1 << 3)
+#define ES8328_DACCONTROL16_LMIXSEL_LIN3 (2 << 3)
+#define ES8328_DACCONTROL16_LMIXSEL_LADC (3 << 3)
+
+#define ES8328_DACCONTROL17	0x27
+#define ES8328_DACCONTROL17_LI2LOVOL (7 << 3)
+#define ES8328_DACCONTROL17_LI2LO (1 << 6)
+#define ES8328_DACCONTROL17_LD2LO (1 << 7)
+
+#define ES8328_DACCONTROL18	0x28
+#define ES8328_DACCONTROL18_RI2LOVOL (7 << 3)
+#define ES8328_DACCONTROL18_RI2LO (1 << 6)
+#define ES8328_DACCONTROL18_RD2LO (1 << 7)
+
+#define ES8328_DACCONTROL19	0x29
+#define ES8328_DACCONTROL19_LI2ROVOL (7 << 3)
+#define ES8328_DACCONTROL19_LI2RO (1 << 6)
+#define ES8328_DACCONTROL19_LD2RO (1 << 7)
+
+#define ES8328_DACCONTROL20	0x2a
+#define ES8328_DACCONTROL20_RI2ROVOL (7 << 3)
+#define ES8328_DACCONTROL20_RI2RO (1 << 6)
+#define ES8328_DACCONTROL20_RD2RO (1 << 7)
+
+#define ES8328_DACCONTROL21	0x2b
+#define ES8328_DACCONTROL22	0x2c
+#define ES8328_DACCONTROL23	0x2d
+#define ES8328_DACCONTROL24	0x2e
+#define ES8328_DACCONTROL25	0x2f
+#define ES8328_DACCONTROL26	0x30
+#define ES8328_DACCONTROL27	0x31
+#define ES8328_DACCONTROL28	0x32
+#define ES8328_DACCONTROL29	0x33
+#define ES8328_DACCONTROL30	0x34
+#define ES8328_SYSCLK		0
+
+#define ES8328_REG_MAX		0x35
+
+#define ES8328_PLL1		0
+#define ES8328_PLL2		1
+
+/* clock inputs */
+#define ES8328_MCLK		0
+#define ES8328_PCMCLK		1
+
+/* clock divider id's */
+#define ES8328_PCMDIV		0
+#define ES8328_BCLKDIV		1
+#define ES8328_VXCLKDIV		2
+
+/* PCM clock dividers */
+#define ES8328_PCM_DIV_1	(0 << 6)
+#define ES8328_PCM_DIV_3	(2 << 6)
+#define ES8328_PCM_DIV_5_5	(3 << 6)
+#define ES8328_PCM_DIV_2	(4 << 6)
+#define ES8328_PCM_DIV_4	(5 << 6)
+#define ES8328_PCM_DIV_6	(6 << 6)
+#define ES8328_PCM_DIV_8	(7 << 6)
+
+/* BCLK clock dividers */
+#define ES8328_BCLK_DIV_1	(0 << 7)
+#define ES8328_BCLK_DIV_2	(1 << 7)
+#define ES8328_BCLK_DIV_4	(2 << 7)
+#define ES8328_BCLK_DIV_8	(3 << 7)
+
+/* VXCLK clock dividers */
+#define ES8328_VXCLK_DIV_1	(0 << 6)
+#define ES8328_VXCLK_DIV_2	(1 << 6)
+#define ES8328_VXCLK_DIV_4	(2 << 6)
+#define ES8328_VXCLK_DIV_8	(3 << 6)
+#define ES8328_VXCLK_DIV_16	(4 << 6)
+
+#define ES8328_DAI_HIFI		0
+#define ES8328_DAI_VOICE	1
+
+#define ES8328_1536FS		1536
+#define ES8328_1024FS		1024
+#define ES8328_768FS		768
+#define ES8328_512FS		512
+#define ES8328_384FS		384
+#define ES8328_256FS		256
+#define ES8328_128FS		128
+
+#endif
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
