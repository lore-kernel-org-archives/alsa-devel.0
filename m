From: Paolo Doz <paolo.doz@gmail.com>
Subject: [PATCH V2 1/1] ASoC: ak5702: add support for ak5702 --
 4ch ADC
Date: Wed, 28 Nov 2012 16:54:49 +0100
Message-ID: <CAFsPKCW7N8ZBiazDtmEKLXVCxrZ-00sk9YJTreffAJAcWGv=pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C8A0B26031F
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 16:54:50 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id p1so8985324vcq.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 07:54:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This codec driver adds support for Asahi Kasei AK5702.

Signed-off-by: Paolo Doz <paolo.doz@gmail.com>
---
 include/sound/ak5702.h    |   27 +++
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/ak5702.c |  507 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak5702.h |  171 +++++++++++++++
 5 files changed, 711 insertions(+)

diff --git a/include/sound/ak5702.h b/include/sound/ak5702.h
new file mode 100644
index 0000000..8c0d4e9
--- /dev/null
+++ b/include/sound/ak5702.h
@@ -0,0 +1,27 @@
+/*
+ * AK5702 ALSA SoC Codec driver
+ *
+ * Author:      Paolo Doz <paolo.doz@gmail.com>
+ * Copyright:   (C) 2012 Soft In S.r.l.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __AK5702_H
+#define __AK5702_H
+
+/**
+ * enum ak5702_clock mode
+ */
+
+enum ak5702_clock_mode {
+    AK5702_CLKPLL_SLAVE,
+    AK5702_CLKPLL_SLAVE2,
+    AK5702_CLKPLL_MASTER,
+    AK5702_CLKEXT_SLAVE,
+    AK5702_CLKEXT_MASTER,
+};
+
+#endif /* __AK5702_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3a84782..d8156c7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -26,6 +26,7 @@ config SND_SOC_ALL_CODECS
     select SND_SOC_AK4641 if I2C
     select SND_SOC_AK4642 if I2C
     select SND_SOC_AK4671 if I2C
+    select SND_SOC_AK5702 if I2C
     select SND_SOC_ALC5623 if I2C
     select SND_SOC_ALC5632 if I2C
     select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
@@ -202,6 +203,9 @@ config SND_SOC_AK4642
 config SND_SOC_AK4671
     tristate

+config SND_SOC_AK5702
+    tristate
+
 config SND_SOC_ALC5623
        tristate
 config SND_SOC_ALC5632
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f6e8e36..1f88602 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -14,6 +14,7 @@ snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4641-objs := ak4641.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
+snd-soc-ak5702-objs := ak5702.o
 snd-soc-arizona-objs := arizona.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs42l51-objs := cs42l51.o
@@ -136,6 +137,7 @@ obj-$(CONFIG_SND_SOC_AK4535)    += snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4641)    += snd-soc-ak4641.o
 obj-$(CONFIG_SND_SOC_AK4642)    += snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)    += snd-soc-ak4671.o
+obj-$(CONFIG_SND_SOC_AK5702)    += snd-soc-ak5702.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)    += snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)    += snd-soc-arizona.o
diff --git a/sound/soc/codecs/ak5702.c b/sound/soc/codecs/ak5702.c
new file mode 100644
index 0000000..9d35062
--- /dev/null
+++ b/sound/soc/codecs/ak5702.c
@@ -0,0 +1,507 @@
+/*
+ * ak5702.c  --  AK5702 Soc Audio driver
+ *
+ * Author:      Paolo Doz <paolo.doz@gmail.com>
+ * Copyright:   (C) 2012 Soft In S.r.l.
+ *                  2009 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This code comes from the original Freescale Ak5702 Audio driver
+ */
+
+/* #define DEBUG 1 */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <linux/slab.h>
+#include <sound/tlv.h>
+#include <linux/regmap.h>
+
+#include <sound/ak5702.h>
+#include "ak5702.h"
+
+#define AK5702_VERSION "0.5"
+#define DRV_NAME "ak5702"
+
+/* codec private data */
+struct ak5702_priv {
+    struct regmap *regmap;
+    enum ak5702_clock_mode clock_mode;
+};
+
+/*
+ * ak5702 register cache
+ */
+static const struct reg_default ak5702_reg_defaults[] = {
+    {  0, 0x0000},    /* R0  - Power Management */
+    {  1, 0x0024},    /* R1  - PLL Control */
+    {  2, 0x0000},    /* R2  - Signal Select */
+    {  3, 0x0001},    /* R3  - Mic Gain Control */
+    {  4, 0x0023},    /* R4  - Audio Format Select */
+    {  5, 0x001F},    /* R5  - fs Select */
+    {  6, 0x0000},    /* R6  - Clock Output Select */
+    {  7, 0x0001},    /* R7  - Volume Control */
+    {  8, 0x0091},    /* R8  - Lch Input Volume Control */
+    {  9, 0x0091},    /* R9  - Rch Input Volume Control */
+    { 10, 0x0000},    /* R10 - Timer Select */
+    { 11, 0x00E1},    /* R11 - ALC Mode Control 1 */
+    { 12, 0x0000},    /* R12 - ALC Mode Control 2 */
+    { 13, 0x00A0},    /* R13 - Mode Control 1 */
+    { 14, 0x0000},    /* R14 - Mode Control 2 */
+    { 15, 0x0000},    /* R15 - Mode Control 3 */
+    { 16, 0x0000},    /* R16 - Power Management */
+    { 17, 0x0000},    /* R17 - PLL Control */
+    { 18, 0x0000},    /* R18 - Signal Select */
+    { 19, 0x0001},    /* R19 - Mic Gain Control */
+    { 20, 0x0020},    /* R20 - Audio Format Select */
+    { 21, 0x0000},    /* R21 - fs Select */
+    { 22, 0x0000},    /* R22 - Clock Output Select */
+    { 23, 0x0001},    /* R23 - Volume Control */
+    { 24, 0x0091},    /* R24 - Lch Input Volume Control */
+    { 25, 0x0091},    /* R25 - Rch Input Volume Control */
+    { 26, 0x0000},    /* R26 - Timer Select */
+    { 27, 0x00E1},    /* R27 - ALC Mode Control 1 */
+    { 28, 0x0000},    /* R28 - ALC Mode Control 2 */
+    { 29, 0x0000},    /* R29 - Mode Control 1 */
+    { 30, 0x0000},    /* R30 - Mode Control 2 */
+};
+
+static bool ak5702_writeable(struct device *dev, unsigned int reg)
+{
+    return reg < AK5702_MAX_REGISTER;
+}
+
+static const unsigned int mic_tlv[] = {
+    TLV_DB_RANGE_HEAD(2),
+    0, 2, TLV_DB_SCALE_ITEM(0, 1500, 0),
+    3, 3, TLV_DB_SCALE_ITEM(3600, 0, 0),
+};
+
+static const DECLARE_TLV_DB_SCALE(in_tlv, -5400, 37, 1);
+
+static const char *ak5702_adca_left12_input[] = { "Left1", "Left2" };
+static const char *ak5702_adca_right12_input[] = { "Right1", "Right2" };
+static const char *ak5702_adca_left5_input[] = { "Left1/2", "Left5" };
+static const char *ak5702_adca_right5_input[] = { "Right1/2", "Right5" };
+
+static const char *ak5702_adcb_left12_input[] = { "Left3", "Left4" };
+static const char *ak5702_adcb_right12_input[] = { "Right3", "Right4" };
+static const char *ak5702_adcb_left5_input[] = { "Left3-4", "Left5" };
+static const char *ak5702_adcb_right5_input[] = { "Right3-4", "Right5" };
+
+static const struct soc_enum ak5702_enum[] = {
+    SOC_ENUM_SINGLE(AK5702_SIG1, 0, 2, ak5702_adca_left12_input),
+    SOC_ENUM_SINGLE(AK5702_SIG1, 1, 2, ak5702_adca_right12_input),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 0, 2, ak5702_adcb_left12_input),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 1, 2, ak5702_adcb_right12_input),
+    SOC_ENUM_SINGLE(AK5702_SIG1, 5, 2, ak5702_adca_left5_input),
+    SOC_ENUM_SINGLE(AK5702_SIG1, 6, 2, ak5702_adca_right5_input),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 5, 2, ak5702_adcb_left5_input),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 6, 2, ak5702_adcb_right5_input),
+};
+
+static const struct snd_kcontrol_new ak5702_snd_controls[] = {
+    SOC_ENUM("ADCA Left1/2 Capture Source", ak5702_enum[0]),
+    SOC_ENUM("ADCA Right1/2 Capture Source", ak5702_enum[1]),
+    SOC_ENUM("ADCB Left1/2 Capture Source", ak5702_enum[2]),
+    SOC_ENUM("ADCB Right1/2 Capture Source", ak5702_enum[3]),
+    SOC_ENUM("ADCA Left5 Capture Source", ak5702_enum[4]),
+    SOC_ENUM("ADCA Right5 Capture Source", ak5702_enum[5]),
+    SOC_ENUM("ADCB Left5 Capture Source", ak5702_enum[6]),
+    SOC_ENUM("ADCB Right5 Capture Source", ak5702_enum[7]),
+    SOC_SINGLE_TLV("Mic A Boost Gain", AK5702_MICG1, 0, 3, 0, mic_tlv),
+    SOC_SINGLE_TLV("Mic B Boost Gain", AK5702_MICG2, 0, 3, 0, mic_tlv),
+    SOC_DOUBLE_R_TLV("ADCA Capture Volume", AK5702_LVOL1, AK5702_RVOL1, 0,
+             241, 0, in_tlv),
+    SOC_DOUBLE_R_TLV("ADCB Capture Volume", AK5702_LVOL2, AK5702_RVOL2, 0,
+             241, 0, in_tlv),
+};
+
+/* ak5702 dapm widgets */
+static const struct snd_soc_dapm_widget ak5702_dapm_widgets[] = {
+    SND_SOC_DAPM_ADC("ADCA Left", "Capture", AK5702_PM1, 0, 0),
+    SND_SOC_DAPM_ADC("ADCA Right", "Capture", AK5702_PM1, 1, 0),
+    SND_SOC_DAPM_ADC("ADCB Left", "Capture", AK5702_PM2, 0, 0),
+    SND_SOC_DAPM_ADC("ADCB Right", "Capture", AK5702_PM2, 1, 0),
+
+    SND_SOC_DAPM_INPUT("ADCA Left Input"),
+    SND_SOC_DAPM_INPUT("ADCA Right Input"),
+    SND_SOC_DAPM_INPUT("ADCB Left Input"),
+    SND_SOC_DAPM_INPUT("ADCB Right Input"),
+};
+
+static const struct snd_soc_dapm_route ak5702_dapm_routes[] = {
+    {"ADCA Left", NULL, "ADCA Left Input"},
+    {"ADCA Right", NULL, "ADCA Right Input"},
+    {"ADCB Left", NULL, "ADCB Left Input"},
+    {"ADCB Right", NULL, "ADCB Right Input"},
+};
+
+static int ak5702_set_bias_level(struct snd_soc_codec *codec,
+                 enum snd_soc_bias_level level)
+{
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+    u8 value;
+
+    switch (level) {
+    case SND_SOC_BIAS_ON:
+        /* power on ADCA */
+        value = AK5702_PM1_PMADAL |
+            AK5702_PM1_PMADAR |
+            AK5702_PM1_PMVCM;
+        snd_soc_write(codec, AK5702_PM1, value);
+        /* power up ADCB */
+        value = AK5702_PM2_PMADBL | AK5702_PM2_PMADBR;
+        snd_soc_write(codec, AK5702_PM2, value);
+        break;
+    case SND_SOC_BIAS_PREPARE:
+        break;
+    case SND_SOC_BIAS_STANDBY:
+        if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+            regcache_sync(ak5702->regmap);
+        /* power down ADCA */
+        value = AK5702_POWERDOWN | AK5702_PM1_PMVCM;
+        snd_soc_write(codec, AK5702_PM1, value);
+        /* power down ADCB */
+        value = AK5702_POWERDOWN;
+        snd_soc_write(codec, AK5702_PM2, value);
+        break;
+    case SND_SOC_BIAS_OFF:
+        /* power down */
+        value = AK5702_POWERDOWN;
+        snd_soc_write(codec, AK5702_PM1, value);
+        value = AK5702_POWERDOWN;
+        snd_soc_write(codec, AK5702_PM2, value);
+        regcache_mark_dirty(ak5702->regmap);
+        break;
+    }
+    codec->dapm.bias_level = level;
+    return 0;
+}
+
+static int ak5702_dai_hw_params(struct snd_pcm_substream *substream,
+                struct snd_pcm_hw_params *params,
+                struct snd_soc_dai *dai)
+{
+    u8 value;
+    struct snd_soc_codec *codec = dai->codec;
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+
+    pr_debug("Entered %s\n", __func__);
+
+    switch (params_channels(params)) {
+    case 2:
+        snd_soc_update_bits(codec, AK5702_FMT1, AK5702_FMT1_TDM_MASK,
+                AK5702_FMT1_STEREO);
+        break;
+    case 8:
+        if (params_format(params) == SNDRV_PCM_FORMAT_S16_LE)
+            value = AK5702_FMT1_TDM128;
+        else if (params_format(params) == SNDRV_PCM_FORMAT_S32_LE)
+            value = AK5702_FMT1_TDM256;
+        else
+            return -EINVAL;
+        snd_soc_update_bits(codec, AK5702_FMT1, AK5702_FMT1_TDM_MASK,
+                value);
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    switch (params_rate(params)) {
+    case 48000:
+        if (ak5702->clock_mode == AK5702_CLKPLL_SLAVE2)
+            value = AK5702_FS1_BCLK_MODE2;
+        else if (ak5702->clock_mode == AK5702_CLKEXT_SLAVE)
+            value = AK5702_FS1_SLAVE_256FS; /* mode 3 256fs*/
+        else
+            return -EINVAL;
+        break;
+    default:
+        return -EINVAL;
+    }
+    snd_soc_update_bits(codec, AK5702_FS1,
+                AK5702_FS1_FS_MASK | AK5702_FS1_BCKO_MASK, value);
+    return 0;
+}
+
+static int ak5702_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+                int clk_id, unsigned int freq, int dir)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+    u8 value = 0;
+
+    pr_debug("Entered %s\n", __func__);
+
+    switch (clk_id) {
+    case AK5702_CLKPLL_MASTER:
+    case AK5702_CLKEXT_MASTER:
+        if (dir != SND_SOC_CLOCK_OUT)
+            return -EINVAL;
+        break;
+    case AK5702_CLKPLL_SLAVE:
+    case AK5702_CLKPLL_SLAVE2:
+        if (dir != SND_SOC_CLOCK_IN)
+            return -EINVAL;
+        value = AK5702_PLL1_POWERUP |
+            AK5702_PLL1_SLAVE |
+            AK5702_PLL1_MODE2;
+        break;
+    case AK5702_CLKEXT_SLAVE:
+        if (dir != SND_SOC_CLOCK_IN)
+            return -EINVAL;
+        value = AK5702_PLL1_POWERDOWN | AK5702_PLL1_SLAVE;
+        break;
+    default:
+        return -EINVAL;
+    }
+    snd_soc_write(codec, AK5702_PLL1, value);
+    ak5702->clock_mode = clk_id;
+    return 0;
+}
+
+static int ak5702_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    u8 value = 0;
+    pr_debug("Entered %s", __func__);
+
+    switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+    case SND_SOC_DAIFMT_DSP_A:
+    case SND_SOC_DAIFMT_I2S:
+        value = AK5702_FMT1_I2S;
+        break;
+    case SND_SOC_DAIFMT_LEFT_J:
+        value = AK5702_FMT1_MSB;
+        break;
+    default:
+        return -EINVAL;
+    }
+    snd_soc_update_bits(codec, AK5702_FMT1, AK5702_FMT1_FMT_MASK, value);
+    snd_soc_write(codec, AK5702_FMT2, AK5702_FMT2_STEREO);
+    return 0;
+}
+
+static int ak5702_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+        int source, unsigned int freq_in, unsigned int freq_out)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    u8 reg = 0;
+    pr_debug("Entered %s", __func__);
+    reg = snd_soc_read(codec, AK5702_PLL1);
+    switch (pll_id) {
+    case AK5702_PLL_POWERDOWN:
+        reg &= (~AK5702_PLL1_PM_MASK);
+        reg |= AK5702_PLL1_POWERDOWN;
+        break;
+    case AK5702_PLL_MASTER:
+        reg &= (~AK5702_PLL1_MODE_MASK);
+        reg |= AK5702_PLL1_MASTER | AK5702_PLL1_POWERUP;
+        break;
+    case AK5702_PLL_SLAVE:
+        reg &= (~AK5702_PLL1_MODE_MASK);
+        reg |= AK5702_PLL1_SLAVE | AK5702_PLL1_POWERUP;
+        break;
+    default:
+        return -ENODEV;
+    }
+    reg &= (~AK5702_PLL1_PLL_MASK);
+    switch (freq_in) {
+    case 11289600:
+        reg |= AK5702_PLL1_11289600;
+        break;
+    case 12000000:
+        reg |= AK5702_PLL1_12000000;
+        break;
+    case 12288000:
+        reg |= AK5702_PLL1_12288000;
+        break;
+    case 19200000:
+        reg |= AK5702_PLL1_19200000;
+        break;
+    default:
+        return -ENODEV;
+    }
+    snd_soc_write(codec, AK5702_PLL1, reg);
+    return 0;
+}
+
+static int ak5702_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
+                    int div_id, int div)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    u8 value = 0;
+    pr_debug("Entered %s", __func__);
+    if (div_id == AK5702_BCLK_CLKDIV) {
+        switch (div) {
+        case AK5702_BCLK_DIV_32:
+            value = AK5702_FS1_BCKO_32FS;
+            break;
+        case AK5702_BCLK_DIV_64:
+            value = AK5702_FS1_BCKO_64FS;
+            break;
+        default:
+            return -EINVAL;
+        }
+    }
+    snd_soc_update_bits(codec, AK5702_FS1, AK5702_FS1_BCKO_MASK, value);
+    return 0;
+}
+
+#ifdef CONFIG_PM
+static int ak5702_suspend(struct snd_soc_codec *codec)
+{
+    ak5702_set_bias_level(codec, SND_SOC_BIAS_OFF);
+    return 0;
+}
+
+static int ak5702_resume(struct snd_soc_codec *codec)
+{
+    ak5702_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+    return 0;
+}
+#else
+#define ak5702_suspend NULL
+#define ak5702_resume NULL
+#endif
+
+static const struct snd_soc_dai_ops ak5702_ops = {
+    .set_sysclk    = ak5702_set_dai_sysclk,
+    .set_pll    = ak5702_set_dai_pll,
+    .set_clkdiv    = ak5702_set_dai_clkdiv,
+    .set_fmt    = ak5702_set_dai_fmt,
+    .hw_params    = ak5702_dai_hw_params,
+};
+
+struct snd_soc_dai_driver ak5702_dai = {
+    .name = "ak5702-hifi",
+    .capture = {
+        .stream_name = "Capture",
+        .channels_min = 1,
+        .channels_max = 8,
+        .rates = SNDRV_PCM_RATE_8000_48000,
+        .formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+    },
+    .ops = &ak5702_ops,
+};
+
+static int ak5702_probe(struct snd_soc_codec *codec)
+{
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+    int ret = 0;
+    dev_info(codec->dev, "AK5702 Audio Codec %s", AK5702_VERSION);
+
+    codec->control_data = ak5702->regmap;
+    ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
+    if (ret < 0) {
+        dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+        return ret;
+    }
+    ak5702_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+    return ret;
+}
+
+static int ak5702_remove(struct snd_soc_codec *codec)
+{
+    ak5702_set_bias_level(codec, SND_SOC_BIAS_OFF);
+    return 0;
+}
+
+static const struct regmap_config ak5702_regmap = {
+    .reg_bits = 8,
+    .val_bits = 8,
+
+    .max_register = AK5702_MAX_REGISTER,
+    .writeable_reg = ak5702_writeable,
+
+    .cache_type = REGCACHE_RBTREE,
+    .reg_defaults = ak5702_reg_defaults,
+    .num_reg_defaults = ARRAY_SIZE(ak5702_reg_defaults),
+};
+
+static __devinit int ak5702_i2c_probe(struct i2c_client *i2c,
+                const struct i2c_device_id *id)
+{
+    struct ak5702_priv *ak5702;
+    int ret;
+    pr_debug("Entered %s", __func__);
+
+    ak5702 = devm_kzalloc(&i2c->dev, sizeof(struct ak5702_priv),
+                  GFP_KERNEL);
+    if (!ak5702)
+        return -ENOMEM;
+
+    ak5702->regmap = devm_regmap_init_i2c(i2c, &ak5702_regmap);
+    if (IS_ERR(ak5702->regmap)) {
+        ret = PTR_ERR(ak5702->regmap);
+        dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+            ret);
+        return ret;
+    }
+
+    i2c_set_clientdata(i2c, ak5702);
+
+    ret = snd_soc_register_codec(&i2c->dev,
+                &soc_codec_dev_ak5702, &ak5702_dai, 1);
+    if (ret != 0)
+        dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+
+    return ret;
+}
+
+static __devexit int ak5702_i2c_remove(struct i2c_client *client)
+{
+    snd_soc_unregister_codec(&client->dev);
+    return 0;
+}
+
+static const struct i2c_device_id ak5702_i2c_id[] = {
+    { "ak5702-codec", 0 },
+    { }
+};
+
+MODULE_DEVICE_TABLE(i2c, ak5702_i2c_id);
+
+static struct i2c_driver ak5702_i2c_driver = {
+    .driver = {
+        .name = "ak5702-codec",
+        .owner = THIS_MODULE,
+    },
+    .probe = ak5702_i2c_probe,
+    .remove = __devexit_p(ak5702_i2c_remove),
+    .id_table = ak5702_i2c_id,
+};
+
+struct snd_soc_codec_driver soc_codec_dev_ak5702 = {
+    .probe            = ak5702_probe,
+    .remove            = ak5702_remove,
+    .suspend        = ak5702_suspend,
+    .resume            = ak5702_resume,
+    .set_bias_level        = ak5702_set_bias_level,
+    .controls        = ak5702_snd_controls,
+    .num_controls        = ARRAY_SIZE(ak5702_snd_controls),
+    .dapm_widgets        = ak5702_dapm_widgets,
+    .num_dapm_widgets    = ARRAY_SIZE(ak5702_dapm_widgets),
+    .dapm_routes        = ak5702_dapm_routes,
+    .num_dapm_routes    = ARRAY_SIZE(ak5702_dapm_routes),
+};
+
+module_i2c_driver(ak5702_i2c_driver);
+
+MODULE_DESCRIPTION("Asahi Kasei AK5702 ALSA SoC driver");
+MODULE_AUTHOR("Paolo Doz <paolo.doz@gmail.com");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak5702.h b/sound/soc/codecs/ak5702.h
new file mode 100644
index 0000000..a492a61
--- /dev/null
+++ b/sound/soc/codecs/ak5702.h
@@ -0,0 +1,171 @@
+/*
+ * ak5702.h  --  AK5702 Soc Audio driver
+ *
+ * Author:      Paolo Doz <paolo.doz@gmail.com>
+ * Copyright:   (C) 2012 Soft In S.r.l.
+ *                  2009 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This code comes from the original Freescale Ak5702 Audio driver
+ */
+
+#ifndef _AK5702_H
+#define _AK5702_H
+
+/* AK5702 register space */
+
+#define AK5702_PM1        0x00
+#define AK5702_PLL1        0x01
+#define AK5702_SIG1        0x02
+#define AK5702_MICG1        0x03
+#define AK5702_FMT1        0x04
+#define AK5702_FS1        0x05
+#define AK5702_CLK1        0x06
+#define AK5702_VOLCTRL1        0x07
+#define AK5702_LVOL1        0x08
+#define AK5702_RVOL1        0x09
+#define AK5702_TIMER1        0x0A
+#define AK5702_ALC11        0x0B
+#define AK5702_ALC12        0x0C
+#define AK5702_MODE11        0x0D
+#define AK5702_MODE12        0x0E
+#define AK5702_MODE13        0x0F
+
+#define AK5702_PM2        0x10
+#define AK5702_PLL2        0x11
+#define AK5702_SIG2        0x12
+#define AK5702_MICG2        0x13
+#define AK5702_FMT2        0x14
+#define AK5702_FS2        0x15
+#define AK5702_CLK2        0x16
+#define AK5702_VOLCTRL2        0x17
+#define AK5702_LVOL2        0x18
+#define AK5702_RVOL2        0x19
+#define AK5702_TIMER2        0x1A
+#define AK5702_ALC21        0x1B
+#define AK5702_ALC22        0x1C
+#define AK5702_MODE21        0x1D
+#define AK5702_MODE22        0x1E
+
+#define AK5702_MAX_REGISTER    0x1F
+
+#define AK5702_CACHEREGNUM    0x1F
+
+#define AK5702_POWERDOWN    0x0
+#define AK5702_PM1_PMADAL    0x01
+#define AK5702_PM1_PMADAR    0x02
+#define AK5702_PM1_PMVCM    0x04
+#define AK5702_PM2_PMADBL    0x01
+#define AK5702_PM2_PMADBR    0x02
+
+#define AK5702_PLL1_POWERDOWN    0x0
+#define AK5702_PLL1_POWERUP    0x01
+#define AK5702_PLL1_MASTER    0x02
+#define AK5702_PLL1_SLAVE    0x0
+#define AK5702_PLL1_MODE0    0x0
+#define AK5702_PLL1_MODE2    0x08
+#define AK5702_PLL1_MODE3    0x0C
+#define AK5702_PLL1_MODE4    0x10
+#define AK5702_PLL1_MODE5    0x14
+#define AK5702_PLL1_MODE6    0x18
+#define AK5702_PLL1_MODE7    0x1C
+#define AK5702_PLL1_MODE8    0x20
+#define AK5702_PLL1_MODE9    0x24
+#define AK5702_PLL1_MODE12    0x30
+#define AK5702_PLL1_MODE13    0x34
+#define AK5702_PLL1_MODE14    0x38
+#define AK5702_PLL1_MODE15    0x3C
+#define AK5702_PLL1_11289600    0x10
+#define AK5702_PLL1_12000000    0x24
+#define AK5702_PLL1_12288000    0x14
+#define AK5702_PLL1_19200000    0x20
+
+#define AK5702_FS1_MCKI_MODE0    0x0
+#define AK5702_FS1_MCKI_MODE1    0x01
+#define AK5702_FS1_MCKI_MODE2    0x02
+#define AK5702_FS1_MCKI_MODE3    0x03
+#define AK5702_FS1_MCKI_MODE4    0x04
+#define AK5702_FS1_MCKI_MODE5    0x05
+#define AK5702_FS1_MCKI_MODE6    0x06
+#define AK5702_FS1_MCKI_MODE7    0x07
+#define AK5702_FS1_MCKI_MODE10    0x0A
+#define AK5702_FS1_MCKI_MODE11    0x0B
+#define AK5702_FS1_MCKI_MODE14    0x0E
+#define AK5702_FS1_MCKI_MODE15    0x0F
+
+#define AK5702_FS1_BCLK_MODE0    0x0
+#define AK5702_FS1_BCLK_MODE1    0x04
+#define AK5702_FS1_BCLK_MODE2    0x08
+
+#define AK5702_FS1_SLAVE_1024FS    0x01
+#define AK5702_FS1_SLAVE_512FS    0x02
+#define AK5702_FS1_SLAVE_256FS    0x03
+
+#define AK5702_SIG1_L_LIN1    0x0
+#define AK5702_SIG1_L_LIN2    0x01
+#define AK5702_SIG1_R_RIN1    0x0
+#define AK5702_SIG1_R_RIN2    0x02
+#define AK5702_SIG1_PMMPA    0x10
+#define AK5702_SIG1_L_LIN5    0x20
+#define AK5702_SIG1_R_RIN5    0x40
+#define AK5702_SIG2_L_LIN3    0x0
+#define AK5702_SIG2_L_LIN4    0x01
+#define AK5702_SIG2_R_RIN3    0x0
+#define AK5702_SIG2_R_RIN4    0x02
+#define AK5702_SIG2_PMMPB    0x10
+
+#define AK5702_MICGAIN_0DB    0x0
+
+#define AK5702_FMT1_I2S        0x03
+#define AK5702_FMT1_MSB        0x02
+#define AK5702_FMT1_STEREO    0x00
+#define AK5702_FMT1_TDM128    0x60
+#define AK5702_FMT1_TDM256    0xE0
+#define AK5702_FMT2_STEREO    0x20
+#define AK5702_FS1_BCKO_32FS    0x10
+#define AK5702_FS1_BCKO_64FS    0x20
+#define AK5702_CLK1_PS_256FS    0x0
+#define AK5702_CLK1_PS_128FS    0x01
+#define AK5702_CLK1_PS_64FS    0x02
+#define AK5702_CLK1_PS_32FS    0x03
+#define AK5702_VOLCTRL_INDEP    0x0
+#define AK5702_VOLCTRL_DEP    0x01
+#define AK5702_VOL_INIT        0x91
+
+#define AK5702_PM1_MASK        0x07
+#define AK5702_PM2_MASK        0x03
+#define AK5702_PLL1_PM_MASK    0x01
+#define AK5702_PLL1_MODE_MASK    0x02
+#define AK5702_PLL1_PLL_MASK    0x3C
+#define AK5702_FS1_BCKO_MASK    0x30
+#define AK5702_FS1_FS_MASK    0x0F
+#define AK5702_CLK1_PS_MASK    0x03
+#define AK5702_FMT1_FMT_MASK    0x03
+#define AK5702_FMT1_TDM_MASK    0xC0
+#define AK5702_FMT2_OUT_MASK    0x10
+/* clock divider id */
+#define AK5702_BCLK_CLKDIV    0
+#define AK5702_MCLK_CLKDIV    1
+
+/* bit clock div values */
+#define AK5702_BCLK_DIV_32    0
+#define AK5702_BCLK_DIV_64    1
+
+/* m clock div values */
+#define AK5702_MCLK_DIV_32    0
+#define AK5702_MCLK_DIV_64    1
+#define AK5702_MCLK_DIV_128    2
+#define AK5702_MCLK_DIV_256    3
+
+/* PLL master and slave modes */
+#define AK5702_PLL_POWERDOWN    0
+#define AK5702_PLL_MASTER    1
+#define AK5702_PLL_SLAVE    2
+
+extern struct snd_soc_dai_driver ak5702_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_ak5702;
+
+#endif
