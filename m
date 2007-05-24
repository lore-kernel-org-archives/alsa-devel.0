From: "Zoltan Devai" <zdevai@gmail.com>
Subject: [RFC] [PATCH 1/2] ASoC sound support for SMDK2440
	boards: UDA1341 driver
Date: Thu, 24 May 2007 16:36:53 +0200
Message-ID: <5b7270f40705240736h7f47e0a0p16ac2b36ae07a5d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id EB2FE243F5
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 16:36:59 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so56826ana
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 07:36:54 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ASoC Support for the UDA1341 codec.
Please note that until there is a final L3-bus driver, this patch won't work.

---

--- /dev/null
+++ /sound/soc/codecs/uda1341.c
@@ -0,0 +1,519 @@
+/*
+ * uda1341.c  --  UDA1341 ALSA SoC Codec driver
+ *
+ * Copyright 2007 Dension Audio Systems Ltd.
+ * Author: Zoltan Devai
+ *
+ * Based on the WM87xx drivers by Liam Girdwood and Richard Purdie
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/l3.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "../s3c24xx/s3c24xx-i2s.h"
+#include "uda1341.h"
+
+#define UDA1341_DEBUG 0
+
+#ifdef UDA1341_DEBUG
+#define DBG(format, arg...) \
+	printk(KERN_DEBUG "UDA1341: %s:" format "\n" ,__FUNCTION__, ## arg)
+#else
+#define DBG(format, arg...) do {} while (0)
+#endif
+
+#define UDA1341_RATES SNDRV_PCM_RATE_8000_48000
+#define UDA1341_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+		SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE )
+
+struct uda1341_priv {
+	int sysclk;
+	int dai_fmt;
+};
+
+/* In-data addresses are hard-coded into the reg-cache values */
+static const char uda1341_reg[UDA1341_REGS_NUM] = {
+	/* Extended address registers */
+	0x04, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* Status, data regs */
+	0x00, 0x83, 0x00, 0x40, 0x80, 0x00,
+};
+
+/*
+ * The codec has no support for reading its registers except for peak level...
+ */
+static inline unsigned int uda1341_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u8 *cache = codec->reg_cache;
+	
+	DBG("reg: %d", reg);
+	
+	if (reg >= UDA1341_REGS_NUM)
+		return -1;
+	return cache[reg];
+}
+
+/*
+ * Write the register cache
+ */
+static inline void uda1341_write_reg_cache(struct snd_soc_codec *codec,
+	u8 reg, unsigned int value)
+{
+	u8 *cache = codec->reg_cache;
+	
+	DBG("reg: %02X", reg);
+	
+	if (reg >= UDA1341_REGS_NUM)
+		return;
+	cache[reg] = value;
+}
+
+/*
+ * Write to the uda1341 registers
+ *
+ */
+static int uda1341_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	int ret;
+	int addr;
+	u8 data = value;
+
+	DBG("reg: %02X, value:%02X", reg, value);
+
+	if (reg >= UDA1341_REGS_NUM) {
+		DBG("Unkown register: reg: %d", reg);
+		return -EINVAL;
+	}
+	
+	uda1341_write_reg_cache(codec, reg, value);
+
+	switch (reg) {
+		case UDA1341_STATUS0:
+		case UDA1341_STATUS1:
+			addr = UDA1341_STATUS_ADDR;
+			break;
+		case UDA1341_DATA000:
+		case UDA1341_DATA001:
+		case UDA1341_DATA010:
+			addr = UDA1341_DATA0_ADDR;
+			break;
+		case UDA1341_DATA1:
+			addr = UDA1341_DATA1_ADDR;
+			break;
+		default:
+			/* It's an extended address register */
+			addr =  (reg | UDA1341_EXTADDR_PREFIX);
+
+			ret = codec->hw_write_l3(codec->control_data,
+					UDA1341_DATA0_ADDR, (char*)&addr, 1);
+			if (ret != 1)
+				return -EIO;
+			
+			addr = UDA1341_DATA0_ADDR;
+			data = (value | UDA1341_EXTDATA_PREFIX);
+			break;
+	}
+	
+	ret = codec->hw_write_l3(codec->control_data, addr, (char*)&data, 1);
+	if (ret != 1)
+		return -EIO;
+
+	return 0;
+}
+
+static inline void uda1341_reset(struct snd_soc_codec *codec)
+{
+	u8 reset_reg = uda1341_read_reg_cache(codec, UDA1341_STATUS0);
+	uda1341_write(codec, UDA1341_STATUS0, reset_reg | (1<<6));
+}
+
+static int uda1341_mute(struct snd_soc_codec_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 mute_reg = uda1341_read_reg_cache(codec, UDA1341_DATA010);
+
+	DBG("mute: %d", mute);
+
+	if (mute)
+		mute_reg |= (1<<2);
+	else
+		mute_reg &= ~(1<<2);
+
+	uda1341_write(codec, UDA1341_DATA010, mute_reg & ~(1<<2));
+	
+	return 0;
+}
+
+static int uda1341_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct uda1341_priv *uda1341 = codec->private_data;
+
+	u8 hw_params = uda1341_read_reg_cache(codec, UDA1341_STATUS0);
+	hw_params &= STATUS0_SYSCLK_MASK;
+	hw_params &= STATUS0_DAIFMT_MASK;
+
+	DBG("sysclk: %d, rate:%d", uda1341->sysclk, params_rate(params));
+
+	/* set SYSCLK / fs ratio */
+	switch (uda1341->sysclk / params_rate(params)) {
+		case 512:
+			break;
+		case 384:
+			hw_params |= (1<<4);
+			break;
+		case 256:
+			hw_params |= (1<<5);
+			break;
+		default:
+			return -EINVAL;
+			break;
+	}
+
+	DBG("dai_fmt: %d, params_format:%d", uda1341->dai_fmt,
+						params_format(params));
+
+	
+	/* set DAI format and word length */
+	switch (uda1341->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch(params_format(params)) {
+		case SNDRV_PCM_FORMAT_S16_LE:
+			hw_params |= (1<<1);
+			break;
+		case SNDRV_PCM_FORMAT_S18_3LE:
+			hw_params |= (1<<2);
+			break;
+		case SNDRV_PCM_FORMAT_S20_3LE:
+			hw_params |= ((1<<2) | (1<<1));
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		hw_params |= (1<<3);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	uda1341_write(codec, UDA1341_STATUS0, hw_params);
+
+	return 0;
+}
+
+static int uda1341_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct uda1341_priv *uda1341 = codec->private_data;
+
+	DBG("clk_id: %d, freq: %d, dir: %d", clk_id, freq, dir);
+
+	/* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
+	we'll error out on set_hw_params if it's not OK */
+	if ( (freq >= (256 * 8000)) && (freq <= (512 * 48000)) ) {
+		uda1341->sysclk = freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int uda1341_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+			       unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct uda1341_priv *uda1341 = codec->private_data;
+
+	DBG("fmt: %08X", fmt);
+	
+	/* codec supports only full slave mode */
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
+		return -EINVAL;
+
+	/* no support for clock inversion */
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF)
+		return -EINVAL;
+
+	/* We can't setup DAI format here as it depends on the word bit num */
+	/* so let's just store the value for later */
+	uda1341->dai_fmt = fmt;
+
+	return 0;
+}
+
+static int uda1341_dapm_event(struct snd_soc_codec *codec, int event)
+{
+	u8 reg;
+
+	DBG("event: %08X", event);
+
+	switch (event) {
+	case SNDRV_CTL_POWER_D0: /* full On */
+		/* ADC, DAC on */
+		reg = uda1341_read_reg_cache(codec, UDA1341_STATUS1);
+		uda1341_write(codec, UDA1341_STATUS1, reg | 0x03);
+		break;
+	case SNDRV_CTL_POWER_D1: /* partial On */
+	case SNDRV_CTL_POWER_D2: /* partial On */
+	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+		break;
+	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+		/* mute, ADC, DAC power off */
+		reg = codec->read(codec, UDA1341_STATUS1);
+		uda1341_write(codec, UDA1341_STATUS1, reg & ~(0x03));
+		break;
+	}
+	codec->dapm_state = event;
+	return 0;
+}
+
+static const char *uda1341_dsp_setting[] = {"Flat", "Minimum1",
"Minimum2", "Maximum"};
+static const char *uda1341_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
+static const char *uda1341_mixmode[] = {"DD", "Input 2", "Input 2",
"Digital mixer"};
+
+static const struct soc_enum uda1341_mixer_enum[] = {
+SOC_ENUM_SINGLE(UDA1341_DATA010, 0, 0x03, uda1341_dsp_setting),
+SOC_ENUM_SINGLE(UDA1341_DATA010, 3, 0x03, uda1341_deemph),
+SOC_ENUM_SINGLE(UDA1341_EA010, 0, 0x03, uda1341_mixmode),
+};
+
+static const struct snd_kcontrol_new uda1341_snd_controls[] = {
+SOC_SINGLE("Playback Volume", UDA1341_DATA000, 0, 0x3F, 1),
+SOC_SINGLE("Mic gain", UDA1341_EA010, 2, 0x07, 0),
+SOC_SINGLE("Channel 1 mixer gain", UDA1341_EA000, 0, 0x1F, 1),
+SOC_SINGLE("Channgel 2 mixer gain", UDA1341_EA001, 0, 0x1F, 1),
+SOC_SINGLE("Input channel 2 amp gain", UDA1341_EA101, 0, 0x1F, 0),
+
+SOC_SINGLE("Bass boost", UDA1341_DATA001, 2, 0xF, 0),
+SOC_SINGLE("Treble", UDA1341_DATA001, 0, 3, 0),
+
+SOC_ENUM("DSP setting", uda1341_mixer_enum[0]),
+SOC_ENUM("Playback De-emphasis", uda1341_mixer_enum[1]),
+SOC_ENUM("Mixer mode", uda1341_mixer_enum[2]),
+
+/* This should be an ext control with own handler, if one wants
+	   to set the values in 0.5dB steps instead of 3dB */
+SOC_SINGLE("AGC output level", UDA1341_EA110, 0, 0x03, 1),
+SOC_SINGLE("AGC time const", UDA1341_EA110, 2, 0x07, 0),
+
+SOC_SINGLE("DAC Gain switch", UDA1341_STATUS1, 6, 1, 0),
+SOC_SINGLE("ADC Gain switch", UDA1341_STATUS1, 5, 1, 0),
+SOC_SINGLE("ADC Polarity switch", UDA1341_STATUS1, 4, 1, 0),
+SOC_SINGLE("DAC Polarity switch", UDA1341_STATUS1, 3, 1, 0),
+SOC_SINGLE("Double speed playback switch", UDA1341_STATUS1, 2, 1, 0),
+};
+
+static int uda1341_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(uda1341_snd_controls); i++) {
+		if ((err = snd_ctl_add(codec->card,
+		snd_soc_cnew(&uda1341_snd_controls[i],codec, NULL))) < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+struct snd_soc_codec_dai uda1341_dai = {
+	.name = "UDA1341",
+	/* playback capabilities */
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = UDA1341_RATES,
+		.formats = UDA1341_FORMATS,
+	},
+	/* capture capabilities */
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = UDA1341_RATES,
+		.formats = UDA1341_FORMATS,
+	},
+	/* pcm operations */
+	.ops = {
+		.hw_params = uda1341_hw_params,
+	},
+	/* DAI operations */
+	.dai_ops = {
+		.digital_mute = uda1341_mute,
+		.set_sysclk = uda1341_set_dai_sysclk,
+		.set_fmt = uda1341_set_dai_fmt,
+	}
+};
+EXPORT_SYMBOL(uda1341_dai);
+
+
+static int uda1341_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct uda1341_priv *uda1341;
+	void * codec_setup_data = socdev->codec_data;
+	int ret = -ENOMEM;
+
+	printk(KERN_INFO "UDA1341 SoC Audio Codec\n");
+
+	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (socdev->codec == NULL)
+		return ret;
+
+	codec = socdev->codec;
+
+	uda1341 = kzalloc(sizeof(struct uda1341_priv), GFP_KERNEL);
+	if (uda1341 == NULL)
+		goto priv_err;
+
+	codec->private_data = uda1341;
+
+        codec->reg_cache = kmemdup(uda1341_reg, sizeof(uda1341_reg), \
+								GFP_KERNEL);
+
+	if (codec->reg_cache == NULL)
+		goto reg_err;
+
+	mutex_init(&codec->mutex);
+
+	codec->reg_cache_size = sizeof(uda1341_reg);
+	codec->reg_cache_step = 1;
+
+	codec->name = "UDA1341";
+	codec->owner = THIS_MODULE;
+	codec->dai = &uda1341_dai;
+	codec->num_dai = 1;
+	codec->read = uda1341_read_reg_cache;
+	codec->write = uda1341_write;
+	codec->dapm_event = uda1341_dapm_event;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+	
+	if (!codec_setup_data) {
+		printk(KERN_ERR "UDA1341 SoC codec: \
+				 Unable to find an L3 bus adapter\n");
+		ret = -ENODEV;
+		goto pcm_err;
+	}
+
+	codec->control_data = codec_setup_data;
+	codec->hw_write_l3 = (hw_write_l3_t)l3_write;
+
+	uda1341_reset(codec);
+
+        /* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "UDA1341: failed to register pcms\n");
+		goto pcm_err;
+	}
+
+	ret = uda1341_add_controls(codec);
+	if (ret < 0) {
+		printk(KERN_ERR "UDA1341: failed to register controls\n");
+		goto pcm_err;
+	}
+
+	//uda1341_add_widgets(codec);
+	
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "UDA1341: failed to register card\n");
+		goto card_err;
+	}
+
+	return 0;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
+reg_err:
+	kfree(codec->private_data);
+priv_err:
+	kfree(codec);
+	return ret;
+}
+
+/* power down chip */
+static int uda1341_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (codec->control_data)
+		uda1341_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	kfree(codec->private_data);
+	kfree(codec->reg_cache);
+	kfree(codec);
+
+	return 0;
+}
+
+#if defined(CONFIG_PM)
+static int uda1341_soc_suspend(struct platform_device *pdev,
+						pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	uda1341_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	return 0;
+}
+
+static int uda1341_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	int i;
+	u8 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(uda1341_reg); i++) {
+		codec->write(codec, i, *cache++);
+	}
+	uda1341_dapm_event(codec, codec->suspend_dapm_state);
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+struct snd_soc_codec_device soc_codec_dev_uda1341 = {
+	.probe =        uda1341_soc_probe,
+	.remove =       uda1341_soc_remove,
+#if defined(CONFIG_PM)	
+	.suspend =      uda1341_soc_suspend,
+	.resume =       uda1341_soc_resume,
+#endif /* CONFIG_PM */
+};
+
+EXPORT_SYMBOL(soc_codec_dev_uda1341);
+
+MODULE_DESCRIPTION("UDA1341 ALSA soc codec driver");
+MODULE_AUTHOR("Zoltan Devai");
+MODULE_LICENSE("GPL");
--- /dev/null
+++ /sound/soc/codecs/uda1341.h
@@ -0,0 +1,47 @@
+/*
+ * uda1341.h  --  UDA1341 ALSA SoC Codec driver
+ *
+ * Copyright 2007 Dension Audio Systems Ltd.
+ * Author: Zoltan Devai
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UDA1341_H
+#define _UDA1341_H
+
+#define UDA1341_L3ADDR	5
+#define UDA1341_DATA0_ADDR	((UDA1341_L3ADDR << 2) | 0)
+#define UDA1341_DATA1_ADDR	((UDA1341_L3ADDR << 2) | 1)
+#define UDA1341_STATUS_ADDR	((UDA1341_L3ADDR << 2) | 2)
+
+#define UDA1341_EXTADDR_PREFIX	0xC0
+#define UDA1341_EXTDATA_PREFIX	0xE0
+
+/* UDA1341 registers */
+#define UDA1341_EA000	0
+#define UDA1341_EA001	1
+#define UDA1341_EA010	2
+#define UDA1341_EA011	3
+#define UDA1341_EA100	4
+#define UDA1341_EA101	5
+#define UDA1341_EA110	6
+#define UDA1341_EA111	7
+#define UDA1341_STATUS0 8
+#define UDA1341_STATUS1 9
+#define UDA1341_DATA000 10
+#define UDA1341_DATA001 11
+#define UDA1341_DATA010 12
+#define UDA1341_DATA1	13
+
+#define UDA1341_REGS_NUM 14
+
+#define STATUS0_DAIFMT_MASK (~(7<<1))
+#define STATUS0_SYSCLK_MASK (~(3<<4))
+
+extern struct snd_soc_codec_dai uda1341_dai;
+extern struct snd_soc_codec_device soc_codec_dev_uda1341;
+
+#endif /* _UDA1341_H */
