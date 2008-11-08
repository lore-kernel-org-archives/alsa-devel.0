From: Christian Pellegrin <chripell@gmail.com>
Subject: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Sat,  8 Nov 2008 08:43:55 +0100
Message-ID: <12261302352402-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C5561037EE
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 08:43:54 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id b27so1963778fka.0
	for <alsa-devel@alsa-project.org>; Fri, 07 Nov 2008 23:43:53 -0800 (PST)
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
Cc: Christian Pellegrin <chripell@fsfe.org>, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for the UDA1341 codec and a sound card
definition for one of these UDAs connected to the s3c24xx. It is
*heavily* based on the one made by Zoltan Devai but:

1 since the UDA is the only use of the L3 protocol I can find I just
embedded a stripped-down L3 bit-banging algorithm from the original
RMK work. It is really small.

2 the driver has the possibility to specify the pins used by codec
via platform data so it can work on SMDK2410, SMDK2440 or any custom
design.

3 it tries to guess the right clock source and divider so it is not tied
to a particular crystal used.

4 it fixes some bugs.

Thank you for reviews/comments.

Generated on  20081108  against v2.6.27

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 include/sound/s3c24xx_uda1341.h                  |   41 ++
 sound/soc/codecs/Kconfig                         |    3 +
 sound/soc/codecs/Makefile                        |    1 +
 sound/soc/codecs/uda1341/Makefile                |    3 +
 sound/soc/codecs/uda1341/l3.c                    |  106 +++++
 sound/soc/codecs/uda1341/l3.h                    |    8 +
 sound/soc/codecs/uda1341/uda1341.c               |  537 ++++++++++++++++++++++
 sound/soc/codecs/uda1341/uda1341.h               |   47 ++
 sound/soc/codecs/uda1341/uda1341_platform_data.h |   18 +
 sound/soc/s3c24xx/Kconfig                        |    7 +-
 sound/soc/s3c24xx/Makefile                       |    2 +
 sound/soc/s3c24xx/s3c24xx_uda1341.c              |  314 +++++++++++++
 12 files changed, 1086 insertions(+), 1 deletions(-)

diff --git a/include/sound/s3c24xx_uda1341.h b/include/sound/s3c24xx_uda1341.h
new file mode 100644
index 0000000..bd80bd3
--- /dev/null
+++ b/include/sound/s3c24xx_uda1341.h
@@ -0,0 +1,41 @@
+#ifndef _S3C24XX_UDA1341_H_
+#define _S3C24XX_UDA1341_H_ 1
+
+/*
+
+Example usage (pins for SMDK2410). Put something like this in your
+machine file:
+
+...
+
+static struct s3c24xx_uda1341_platform_data s3c24xx_uda1341_data = {
+	.l3_clk = S3C2410_GPB4,
+	.l3_data = S3C2410_GPB3,
+	.l3_mode = S3C2410_GPB2,
+};
+
+static struct platform_device s3c24xx_uda1341 = {
+	.name		  = "s3c24xx_uda1341",
+	.dev = {
+		.platform_data	  = &s3c24xx_uda1341_data,
+	}
+};
+
+...
+
+static struct platform_device *smdk2410_devices[] __initdata = {
+...
+	&s3c24xx_uda1341,
+...
+};
+
+ */
+
+struct s3c24xx_uda1341_platform_data {
+	int l3_clk;
+	int l3_mode;
+	int l3_data;
+	void (*power) (int);
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1db04a2..4b483b7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -50,3 +50,6 @@ config SND_SOC_CS4270_VD33_ERRATA
 config SND_SOC_TLV320AIC3X
 	tristate
 	depends on I2C
+
+config SND_SOC_UDA1341
+	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d7b97ab..cbace60 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_UDA1341)	+= uda1341/
diff --git a/sound/soc/codecs/uda1341/Makefile b/sound/soc/codecs/uda1341/Makefile
new file mode 100644
index 0000000..f9869ba
--- /dev/null
+++ b/sound/soc/codecs/uda1341/Makefile
@@ -0,0 +1,3 @@
+snd-soc-uda1341-objs := l3.o uda1341.o
+
+obj-$(CONFIG_SND_SOC_UDA1341)	+= snd-soc-uda1341.o
\ No newline at end of file
diff --git a/sound/soc/codecs/uda1341/l3.c b/sound/soc/codecs/uda1341/l3.c
new file mode 100644
index 0000000..b65b352
--- /dev/null
+++ b/sound/soc/codecs/uda1341/l3.c
@@ -0,0 +1,106 @@
+/*
+ * L3 code
+ *
+ *  Copyright (C) 2008, Christian Pellegrin <chripell@evolware.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *
+ * based on:
+ *
+ * L3 bus algorithm module.
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#include "l3.h"
+
+/*#define L3_DEBUG 1*/
+#ifdef L3_DEBUG
+#define DBG(format, arg...) \
+	printk(KERN_DEBUG "L3: %s:" format "\n" , __func__, ## arg)
+#else
+#define DBG(format, arg...) do {} while (0)
+#endif
+
+#define setdat(adap, val)	(adap->setdat(adap, val))
+#define setclk(adap, val)	(adap->setclk(adap, val))
+#define setmode(adap, val)	(adap->setmode(adap, val))
+
+/*
+ * Send one byte of data to the chip.  Data is latched into the chip on
+ * the rising edge of the clock.
+ */
+static void sendbyte(struct uda1341_platform_data *adap, unsigned int byte)
+{
+	int i;
+
+	DBG("%02x", byte);
+
+	for (i = 0; i < 8; i++) {
+		setclk(adap, 0);
+		udelay(adap->data_hold);
+		setdat(adap, byte & 1);
+		udelay(adap->data_setup);
+		setclk(adap, 1);
+		udelay(adap->clock_high);
+		byte >>= 1;
+	}
+}
+
+/*
+ * Send a set of bytes to the chip.  We need to pulse the MODE line
+ * between each byte, but never at the start nor at the end of the
+ * transfer.
+ */
+static void sendbytes(struct uda1341_platform_data *adap, const u8 *buf,
+		      int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (i) {
+			udelay(adap->mode_hold);
+			setmode(adap, 0);
+			udelay(adap->mode);
+		}
+		setmode(adap, 1);
+		udelay(adap->mode_setup);
+		sendbyte(adap, buf[i]);
+	}
+}
+
+int l3_write(struct uda1341_platform_data *adap, u8 addr, u8 *data, int len)
+{
+	setclk(adap, 1);
+	setdat(adap, 1);
+	setmode(adap, 1);
+	udelay(adap->mode);
+
+	setmode(adap, 0);
+	udelay(adap->mode_setup);
+	sendbyte(adap, addr);
+	udelay(adap->mode_hold);
+
+	sendbytes(adap, data, len);
+
+	setclk(adap, 1);
+	setdat(adap, 1);
+	setmode(adap, 0);
+
+	return len;
+}
+
+
diff --git a/sound/soc/codecs/uda1341/l3.h b/sound/soc/codecs/uda1341/l3.h
new file mode 100644
index 0000000..2c31e0c
--- /dev/null
+++ b/sound/soc/codecs/uda1341/l3.h
@@ -0,0 +1,8 @@
+#ifndef _L3_H_
+#define _L3_H_ 1
+
+#include "uda1341_platform_data.h"
+
+int l3_write(struct uda1341_platform_data *adap, u8 addr, u8 *data, int len);
+
+#endif
diff --git a/sound/soc/codecs/uda1341/uda1341.c b/sound/soc/codecs/uda1341/uda1341.c
new file mode 100644
index 0000000..93cadf0
--- /dev/null
+++ b/sound/soc/codecs/uda1341/uda1341.c
@@ -0,0 +1,537 @@
+/*
+ * uda1341.c  --  UDA1341 ALSA SoC Codec driver
+ *
+ * Modifications by Christian Pellegrin <chripell@evolware.org>
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
+#include <linux/delay.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "uda1341.h"
+#include "l3.h"
+
+/*#define UDA1341_DEBUG 1*/
+#ifdef UDA1341_DEBUG
+#define DBG(format, arg...) \
+	printk(KERN_DEBUG "UDA1341: %s:" format "\n" , __func__, ## arg)
+#else
+#define DBG(format, arg...) do {} while (0)
+#endif
+
+#define UDA1341_RATES SNDRV_PCM_RATE_8000_48000
+#define UDA1341_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+		SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE)
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
+	u8 addr;
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
+	case UDA1341_STATUS0:
+	case UDA1341_STATUS1:
+		addr = UDA1341_STATUS_ADDR;
+		break;
+	case UDA1341_DATA000:
+	case UDA1341_DATA001:
+	case UDA1341_DATA010:
+		addr = UDA1341_DATA0_ADDR;
+		break;
+	case UDA1341_DATA1:
+		addr = UDA1341_DATA1_ADDR;
+		break;
+	default:
+		/* It's an extended address register */
+		addr =  (reg | UDA1341_EXTADDR_PREFIX);
+
+		ret = l3_write((struct uda1341_platform_data *)
+			       codec->control_data,
+			       UDA1341_DATA0_ADDR, &addr, 1);
+		if (ret != 1)
+			return -EIO;
+
+		addr = UDA1341_DATA0_ADDR;
+		data = (value | UDA1341_EXTDATA_PREFIX);
+		break;
+	}
+
+	ret = l3_write((struct uda1341_platform_data *)  codec->control_data,
+		       addr, &data, 1);
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
+	mdelay(1);
+	uda1341_write(codec, UDA1341_STATUS0, reset_reg & ~(1<<6));
+}
+
+static int uda1341_mute(struct snd_soc_dai *dai, int mute)
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
+	case 512:
+		break;
+	case 384:
+		hw_params |= (1<<4);
+		break;
+	case 256:
+		hw_params |= (1<<5);
+		break;
+	default:
+		return -EINVAL;
+		break;
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
+		switch (params_format(params)) {
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
+static int uda1341_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct uda1341_priv *uda1341 = codec->private_data;
+
+	DBG("clk_id: %d, freq: %d, dir: %d", clk_id, freq, dir);
+
+	/* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
+	we'll error out on set_hw_params if it's not OK */
+	if ((freq >= (256 * 8000)) && (freq <= (512 * 48000))) {
+		uda1341->sysclk = freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int uda1341_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
+		reg = uda1341_read_reg_cache(codec, UDA1341_STATUS1);
+		uda1341_write(codec, UDA1341_STATUS1, reg & ~(0x03));
+		break;
+	}
+	return 0;
+}
+
+static const char *uda1341_dsp_setting[] = {"Flat", "Minimum1",
+					    "Minimum2", "Maximum"};
+static const char *uda1341_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
+static const char *uda1341_mixmode[] = {"DD", "Input 2",
+					"Input 2", "Digital mixer"};
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
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&uda1341_snd_controls[i],
+					       codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+struct snd_soc_dai uda1341_dai = {
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
+	void *codec_setup_data = socdev->codec_data;
+	int ret = -ENOMEM;
+	struct uda1341_platform_data *pd;
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
+	codec->reg_cache = kmemdup(uda1341_reg, sizeof(uda1341_reg),
+				   GFP_KERNEL);
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
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	if (!codec_setup_data) {
+		printk(KERN_ERR "UDA1341 SoC codec: "
+		       "missing L3 bitbang function\n");
+		ret = -ENODEV;
+		goto pcm_err;
+	}
+
+	codec->control_data = codec_setup_data;
+	pd = (struct uda1341_platform_data *) codec_setup_data;
+
+	if (pd->power)
+		pd->power(1);
+
+	uda1341_reset(codec);
+
+	/* register pcms */
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
+	struct uda1341_platform_data *pd;
+
+	uda1341_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+
+	pd = (struct uda1341_platform_data *) codec->control_data;
+	if (pd->power)
+		pd->power(0);
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
+	struct uda1341_platform_data *pd;
+
+	uda1341_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+
+	pd = (struct uda1341_platform_data *) codec->control_data;
+	if (pd->power)
+		pd->power(0);
+
+	return 0;
+}
+
+static int uda1341_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	struct uda1341_platform_data *pd;
+	int i;
+	u8 *cache = codec->reg_cache;
+
+	pd = (struct uda1341_platform_data *) codec->control_data;
+	if (pd->power)
+		pd->power(1);
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(uda1341_reg); i++)
+		codec->write(codec, i, *cache++);
+	uda1341_dapm_event(codec, SNDRV_CTL_POWER_D0);
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
+EXPORT_SYMBOL(soc_codec_dev_uda1341);
+
+MODULE_DESCRIPTION("UDA1341 ALSA soc codec driver");
+MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/uda1341/uda1341.h b/sound/soc/codecs/uda1341/uda1341.h
new file mode 100644
index 0000000..5eccfc4
--- /dev/null
+++ b/sound/soc/codecs/uda1341/uda1341.h
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
+extern struct snd_soc_dai uda1341_dai;
+extern struct snd_soc_codec_device soc_codec_dev_uda1341;
+
+#endif /* _UDA1341_H */
diff --git a/sound/soc/codecs/uda1341/uda1341_platform_data.h b/sound/soc/codecs/uda1341/uda1341_platform_data.h
new file mode 100644
index 0000000..26081cb
--- /dev/null
+++ b/sound/soc/codecs/uda1341/uda1341_platform_data.h
@@ -0,0 +1,18 @@
+#ifndef _UDA1341_PLATFORM_DATA_H_
+#define _UDA1341_PLATFORM_DATA_H_ 1
+
+struct uda1341_platform_data {
+	void (*setdat) (struct uda1341_platform_data *, int);
+	void (*setclk) (struct uda1341_platform_data *, int);
+	void (*setmode) (struct uda1341_platform_data *, int);
+	int data_hold;
+	int data_setup;
+	int clock_high;
+	int mode_hold;
+	int mode;
+	int mode_setup;
+	void *priv;
+	void (*power) (int);
+};
+
+#endif
diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index b9f2353..cc8fa5e 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -16,7 +16,7 @@ config SND_S3C2443_SOC_AC97
 	tristate
 	select AC97_BUS
 	select SND_SOC_AC97_BUS
-	
+
 config SND_S3C24XX_SOC_NEO1973_WM8753
 	tristate "SoC I2S Audio support for NEO1973 - WM8753"
 	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
@@ -44,3 +44,8 @@ config SND_S3C24XX_SOC_LN2440SBC_ALC650
 	  Say Y if you want to add support for SoC audio on ln2440sbc
 	  with the ALC650.
 
+config SND_S3C24XX_SOC_S3C24XX_UDA1341
+       tristate "SoC I2S Audio support UDA1341 wired to a S3C24XX"
+       depends on SND_S3C24XX_SOC
+       select SND_S3C24XX_SOC_I2S
+       select SND_SOC_UDA1341
\ No newline at end of file
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 0aa5fb0..155f5a4 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -13,7 +13,9 @@ obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
 snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
 snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
+snd-soc-s3c24xx-uda1341-objs := s3c24xx_uda1341.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
 obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
+obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA1341) += snd-soc-s3c24xx-uda1341.o
diff --git a/sound/soc/s3c24xx/s3c24xx_uda1341.c b/sound/soc/s3c24xx/s3c24xx_uda1341.c
new file mode 100644
index 0000000..fc3c13e
--- /dev/null
+++ b/sound/soc/s3c24xx/s3c24xx_uda1341.c
@@ -0,0 +1,314 @@
+/*
+ * Modifications by Christian Pellegrin <chripell@evolware.org>
+ *
+ * s3c24xx_uda1341.c  --  S3C24XX_UDA1341 ALSA SoC Audio board driver
+ *
+ * Copyright 2007 Dension Audio Systems Ltd.
+ * Author: Zoltan Devai
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/s3c24xx_uda1341.h>
+
+#include <asm/mach-types.h>
+#include <asm/plat-s3c24xx/regs-iis.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-gpioj.h>
+#include <mach/hardware.h>
+
+#include "../codecs/uda1341/uda1341.h"
+#include "../codecs/uda1341/uda1341_platform_data.h"
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-i2s.h"
+
+/*#define S3C24XX_UDA1341_DEBUG 1*/
+#ifdef S3C24XX_UDA1341_DEBUG
+#define DBG(x...) printk(KERN_DEBUG "s3c24xx-i2s: " x)
+#else
+#define DBG(x...)
+#endif
+
+static struct clk *xtal;
+static struct clk *pclk;
+
+static unsigned long s3c24xx_uda1341_calc_error(unsigned long rate,
+						unsigned long clk_rate,
+						unsigned int div,
+						unsigned int fs)
+{
+	long err;
+
+	err = clk_rate / (div * fs);
+	err -= rate;
+	if (err < 0)
+		err = -err;
+	DBG("rate %lu clk %lu div %u fs %u err %ld\n",
+	    rate, clk_rate, div, fs, err);
+	return err;
+}
+
+static int s3c24xx_uda1341_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	unsigned int div = 0, cdiv;
+	int ret = 0;
+	int clk_source, fs_mode;
+	unsigned long mpllin_rate = clk_get_rate(xtal);
+	unsigned long pclk_rate = clk_get_rate(pclk);
+	unsigned long rate = params_rate(params);
+	unsigned long err, cerr;
+
+	DBG("mpllin %ld pclk %ld rate %lu\n", mpllin_rate, pclk_rate, rate);
+
+	div = pclk_rate / (256 * rate);
+	if (div == 0)
+		div = 1;
+	if (div > 32)
+		div = 32;
+	err = s3c24xx_uda1341_calc_error(rate, pclk_rate, div, 256);
+	fs_mode = S3C2410_IISMOD_256FS;
+	clk_source = S3C24XX_CLKSRC_PCLK;
+
+	if (div < 32) {
+		cdiv = div + 1;
+		cerr = s3c24xx_uda1341_calc_error(rate, pclk_rate, cdiv, 256);
+		if (cerr < err) {
+			err = cerr;
+			div = cdiv;
+		}
+	}
+
+	cdiv = pclk_rate / (384 * rate);
+	if (cdiv == 0)
+		cdiv = 1;
+	if (cdiv > 32)
+		cdiv = 32;
+	cerr = s3c24xx_uda1341_calc_error(rate, pclk_rate, cdiv, 384);
+	if (cerr < err) {
+		err = cerr;
+		div = cdiv;
+		fs_mode = S3C2410_IISMOD_384FS;
+	}
+
+	if (cdiv < 32) {
+		cdiv = cdiv + 1;
+		cerr = s3c24xx_uda1341_calc_error(rate, pclk_rate, cdiv, 384);
+		if (cerr < err) {
+			err = cerr;
+			div = cdiv;
+			fs_mode = S3C2410_IISMOD_384FS;
+		}
+	}
+
+	cerr = s3c24xx_uda1341_calc_error(rate, mpllin_rate, 1, 256);
+	if (cerr < err) {
+		err = cerr;
+		fs_mode = S3C2410_IISMOD_256FS;
+		clk_source = S3C24XX_CLKSRC_MPLL;
+	}
+
+	cerr = s3c24xx_uda1341_calc_error(rate, mpllin_rate, 1, 384);
+	if (cerr < err) {
+		err = cerr;
+		fs_mode = S3C2410_IISMOD_384FS;
+		clk_source = S3C24XX_CLKSRC_MPLL;
+	}
+
+	clk = (fs_mode == S3C2410_IISMOD_384FS ? 384 : 256) * rate;
+	div = div - 1;
+	DBG("Will use: %s %s %d sysclk %d err %ld\n",
+	    fs_mode == S3C2410_IISMOD_384FS ? "384FS" : "256FS",
+	    clk_source == S3C24XX_CLKSRC_MPLL ? "MPLLin" : "PCLK",
+	    div, clk, err);
+
+	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, clk_source , clk,
+						SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
+						fs_mode);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
+						S3C2410_IISMOD_32FS);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+					  S3C24XX_PRESCALE(div, div));
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = codec_dai->dai_ops.set_sysclk(codec_dai, 0, clk,
+						SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops s3c24xx_uda1341_ops = {
+	.hw_params = s3c24xx_uda1341_hw_params,
+};
+
+static struct snd_soc_dai_link s3c24xx_uda1341_dai_link = {
+	.name = "UDA1341",
+	.stream_name = "UDA1341",
+	.codec_dai = &uda1341_dai,
+	.cpu_dai = &s3c24xx_i2s_dai,
+	.ops = &s3c24xx_uda1341_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_s3c24xx_uda1341 = {
+	.name = "S3C24XX_UDA1341",
+	.dai_link = &s3c24xx_uda1341_dai_link,
+	.num_links = 1,
+};
+
+static struct s3c24xx_uda1341_platform_data *s3c24xx_uda1341_l3_pins;
+
+static void setdat(struct uda1341_platform_data *p, int v)
+{
+	s3c2410_gpio_setpin(s3c24xx_uda1341_l3_pins->l3_data, v > 0);
+	s3c2410_gpio_cfgpin(s3c24xx_uda1341_l3_pins->l3_data,
+			    S3C2410_GPIO_OUTPUT);
+}
+
+static void setclk(struct uda1341_platform_data *p, int v)
+{
+	s3c2410_gpio_setpin(s3c24xx_uda1341_l3_pins->l3_clk, v > 0);
+	s3c2410_gpio_cfgpin(s3c24xx_uda1341_l3_pins->l3_clk,
+			    S3C2410_GPIO_OUTPUT);
+}
+
+static void setmode(struct uda1341_platform_data *p, int v)
+{
+	s3c2410_gpio_setpin(s3c24xx_uda1341_l3_pins->l3_mode, v > 0);
+	s3c2410_gpio_cfgpin(s3c24xx_uda1341_l3_pins->l3_mode,
+			    S3C2410_GPIO_OUTPUT);
+}
+
+static void s3c24xx_uda1341_power(int en)
+{
+	if (s3c24xx_uda1341_l3_pins->power)
+		s3c24xx_uda1341_l3_pins->power(en);
+}
+
+static struct uda1341_platform_data s3c24xx_uda1341 = {
+	.setdat = setdat,
+	.setclk = setclk,
+	.setmode = setmode,
+	.data_hold = 1,
+	.data_setup = 1,
+	.clock_high = 1,
+	.mode_hold = 1,
+	.mode = 1,
+	.mode_setup = 1,
+	.power = s3c24xx_uda1341_power,
+};
+
+static struct snd_soc_device s3c24xx_uda1341_snd_devdata = {
+	.machine = &snd_soc_machine_s3c24xx_uda1341,
+	.platform = &s3c24xx_soc_platform,
+	.codec_dev = &soc_codec_dev_uda1341,
+	.codec_data = &s3c24xx_uda1341,
+};
+
+static struct platform_device *s3c24xx_uda1341_snd_device;
+
+static int s3c24xx_uda1341_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	printk(KERN_INFO "S3C24XX_UDA1341 SoC Audio driver\n");
+
+	s3c24xx_uda1341_l3_pins = pdev->dev.platform_data;
+	if (s3c24xx_uda1341_l3_pins == NULL) {
+		printk(KERN_ERR "S3C24XX_UDA1341 SoC Audio: "
+		       "unable to find platform data\n");
+		return -ENODEV;
+	}
+
+	s3c24xx_uda1341_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!s3c24xx_uda1341_snd_device) {
+		printk(KERN_ERR "S3C24XX_UDA1341 SoC Audio: "
+		       "Unable to register\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(s3c24xx_uda1341_snd_device,
+			     &s3c24xx_uda1341_snd_devdata);
+	s3c24xx_uda1341_snd_devdata.dev = &s3c24xx_uda1341_snd_device->dev;
+	ret = platform_device_add(s3c24xx_uda1341_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "S3C24XX_UDA1341 SoC Audio: Unable to add\n");
+		platform_device_put(s3c24xx_uda1341_snd_device);
+	}
+
+	xtal = clk_get(NULL, "xtal");
+	pclk = clk_get(NULL, "pclk");
+
+	return ret;
+}
+
+static int s3c24xx_uda1341_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(s3c24xx_uda1341_snd_device);
+	clk_put(xtal);
+	clk_put(pclk);
+	return 0;
+}
+
+static struct platform_driver s3c24xx_uda1341_driver = {
+	.probe  = s3c24xx_uda1341_probe,
+	.remove = s3c24xx_uda1341_remove,
+	.driver = {
+		.name = "s3c24xx_uda1341",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init s3c24xx_uda1341_init(void)
+{
+	return platform_driver_register(&s3c24xx_uda1341_driver);
+}
+
+static void __exit s3c24xx_uda1341_exit(void)
+{
+	platform_driver_unregister(&s3c24xx_uda1341_driver);
+}
+
+
+module_init(s3c24xx_uda1341_init);
+module_exit(s3c24xx_uda1341_exit);
+
+MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
+MODULE_DESCRIPTION("S3C24XX_UDA1341 ALSA SoC audio driver");
+MODULE_LICENSE("GPL");
--
1.4.4.4
