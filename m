From: Paolo Doz <paolo.doz@gmail.com>
Subject: [PATCH 1/4] ASoC: ak5702: add support for ak5702 --
	4ch ADC
Date: Mon, 29 Oct 2012 09:43:57 +0100
Message-ID: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id D038F26530E
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 09:43:57 +0100 (CET)
Received: by mail-ea0-f179.google.com with SMTP id f14so1606704eaa.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 01:43:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This codec driver adds support for Asahi Kasei AK5702.

Signed-off-by: Paolo Doz <paolo.doz@gmail.com>
---
 sound/soc/codecs/ak5702.c |  728
+++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 728 insertions(+)
 create mode 100644 sound/soc/codecs/ak5702.c

diff --git a/sound/soc/codecs/ak5702.c b/sound/soc/codecs/ak5702.c
new file mode 100644
index 0000000..47c2e52
--- /dev/null
+++ b/sound/soc/codecs/ak5702.c
@@ -0,0 +1,728 @@
+/*
+ * ak5702.c  --  AK5702 ALSA SoC driver
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
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+
+#include <sound/ak5702.h>
+#include "ak5702.h"
+
+#define AK5702_VERSION "0.2"
+#define DRV_NAME "ak5702"
+
+/* codec private data */
+struct ak5702_priv {
+    enum snd_soc_control_type control_type;
+    void *control_data;
+    unsigned int sysclk;
+    enum ak5702_clock_mode clock_mode;
+    struct dentry *debugfs;
+};
+
+/*
+ * ak5702 register cache
+ */
+static u16 ak5702_reg[AK5702_CACHEREGNUM] = {
+    0x00, 0x24, 0x00, 0x01, 0x23, 0x1f,
+    0x00, 0x01, 0x91, 0x00, 0xe1, 0x00,
+    0xa0, 0x00, 0x00, 0x00, 0x01, 0x20,
+    0x00, 0x00, 0x01, 0x91, 0x00, 0xe1,
+    0x00,
+};
+
+/*
+ * read ak5702 register cache
+ */
+static inline unsigned int ak5702_read_reg_cache(struct snd_soc_codec
*codec,
+                unsigned int reg)
+{
+    u16 *cache = codec->reg_cache;
+
+    if (reg >= AK5702_CACHEREGNUM)
+        return -1;
+    return cache[reg];
+}
+
+/*
+ * write ak5702 register cache
+ */
+static inline void ak5702_write_reg_cache(struct snd_soc_codec *codec,
+                u16 reg, unsigned int value)
+{
+    u16 *cache = codec->reg_cache;
+
+    if (reg >= AK5702_CACHEREGNUM)
+        return;
+    cache[reg] = value;
+    ak5702_reg[reg] = value;
+}
+
+/*
+ * write to the AK5702 register space
+ */
+static int ak5702_write(struct snd_soc_codec *codec, unsigned int reg,
+                unsigned int value)
+{
+    u8 data[2];
+    data[0] = reg & 0xff;
+    data[1] = value & 0xff;
+
+    if (codec->hw_write(codec->control_data, data, 2) == 2) {
+        pr_debug("I2c write success @ reg = %x, val = %x\n",
+             data[0], data[1]);
+        ak5702_write_reg_cache(codec, reg, value);
+        return 0;
+    } else {
+        pr_debug("I2c write error reg = %x, val = %x\n",
+            data[0], data[1]);
+        return -EIO;
+    }
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int ak5702_show(struct seq_file *s, void *unused)
+{
+#define REG(r) { r, #r }
+    static const struct {
+        int offset;
+        const char *name;
+    } regs[] = {
+        REG(AK5702_PM1),
+        REG(AK5702_PLL1),
+        REG(AK5702_SIG1),
+        REG(AK5702_MICG1),
+        REG(AK5702_FMT1),
+        REG(AK5702_FS1),
+        REG(AK5702_CLK1),
+        REG(AK5702_VOLCTRL1),
+        REG(AK5702_LVOL1),
+        REG(AK5702_RVOL1),
+        REG(AK5702_TIMER1),
+        REG(AK5702_ALC11),
+        REG(AK5702_ALC12),
+        REG(AK5702_MODE11),
+        REG(AK5702_MODE12),
+        REG(AK5702_MODE13),
+
+        REG(AK5702_PM2),
+        REG(AK5702_PLL2),
+        REG(AK5702_SIG2),
+        REG(AK5702_MICG2),
+        REG(AK5702_FMT2),
+        REG(AK5702_FS2),
+        REG(AK5702_CLK2),
+        REG(AK5702_VOLCTRL2),
+        REG(AK5702_LVOL2),
+        REG(AK5702_RVOL2),
+        REG(AK5702_TIMER2),
+        REG(AK5702_ALC21),
+        REG(AK5702_ALC22),
+        REG(AK5702_MODE21),
+        REG(AK5702_MODE22),
+    };
+#undef REG
+
+    int i;
+    for (i = 0; i < ARRAY_SIZE(ak5702_reg); i++) {
+        seq_printf(s, "%s = 0x%02x\n", regs[i].name,
+                        ak5702_reg[regs[i].offset]);
+    }
+
+    return 0;
+}
+
+static int ak5702_debug_open(struct inode *inode, struct file *file)
+{
+    return single_open(file, ak5702_show, inode->i_private);
+}
+
+static const struct file_operations ak5702_debug_fops = {
+    .open    = ak5702_debug_open,
+    .read    = seq_read,
+    .llseek  = seq_lseek,
+    .release = single_release,
+};
+
+static void ak5702_debug_add(struct ak5702_priv *ak5702)
+{
+    char name[] = DRV_NAME ".0";
+
+    snprintf(name, sizeof(name), DRV_NAME);
+    ak5702->debugfs = debugfs_create_file(name, S_IRUGO,
+            snd_soc_debugfs_root, ak5702, &ak5702_debug_fops);
+}
+
+static void ak5702_debug_remove(struct ak5702_priv *ak5702)
+{
+    if (ak5702->debugfs)
+        debugfs_remove(ak5702->debugfs);
+}
+#else
+static inline void ak5702_debug_add(struct ak5702_priv *ak5702)
+{
+}
+
+static inline void ak5702_debug_remove(struct ak5702_priv *ak5702)
+{
+}
+#endif
+
+static const char *ak5702_mic_gain[] = { "0dB", "+15dB", "+30dB", "+36dB"
};
+static const char *ak5702_adc_input_type[] = {
+    "Single-ended", "Full-differential" };
+static const char *ak5702_adca_left_input[] = { "LIN1", "LIN2" };
+static const char *ak5702_adca_right_input[] = { "RIN1", "RIN2" };
+static const char *ak5702_adca_left5[] = { "LIN1-2", "LIN5" };
+static const char *ak5702_adca_right5[] = { "RIN1-2", "RIN5" };
+
+static const char *ak5702_adcb_left_input[] = { "LIN3", "LIN4" };
+static const char *ak5702_adcb_right_input[] = { "RIN3", "RIN4" };
+static const char *ak5702_adcb_left5[] = { "LIN3-4", "LIN5" };
+static const char *ak5702_adcb_right5[] = { "RIN3-4", "RIN5" };
+
+static const char *ak5702_input_vol_control[] = { "Independent",
"Dependent" };
+static const char *ak5702_mic_power[] = { "Off", "On" };
+
+static const struct soc_enum ak5702_enum[] = {
+    SOC_ENUM_SINGLE(AK5702_MICG1, 0, 4, ak5702_mic_gain),
+    SOC_ENUM_SINGLE(AK5702_MICG2, 0, 4, ak5702_mic_gain),
+
+    SOC_ENUM_SINGLE(AK5702_SIG1, 0, 2, ak5702_adca_left_input),
+    SOC_ENUM_SINGLE(AK5702_SIG1, 1, 2, ak5702_adca_right_input),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 0, 2, ak5702_adcb_left_input),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 1, 2, ak5702_adcb_right_input),
+
+    SOC_ENUM_SINGLE(AK5702_SIG1, 2, 2, ak5702_adc_input_type),
+    SOC_ENUM_SINGLE(AK5702_SIG1, 3, 2, ak5702_adc_input_type),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 2, 2, ak5702_adc_input_type),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 3, 2, ak5702_adc_input_type),
+
+    SOC_ENUM_SINGLE(AK5702_VOLCTRL1, 0, 2, ak5702_input_vol_control),
+    SOC_ENUM_SINGLE(AK5702_VOLCTRL2, 0, 2, ak5702_input_vol_control),
+
+    SOC_ENUM_SINGLE(AK5702_SIG1, 5, 2, ak5702_adca_left5),
+    SOC_ENUM_SINGLE(AK5702_SIG1, 6, 2, ak5702_adca_right5),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 5, 2, ak5702_adcb_left5),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 6, 2, ak5702_adcb_right5),
+
+    SOC_ENUM_SINGLE(AK5702_SIG1, 4, 2, ak5702_mic_power),
+    SOC_ENUM_SINGLE(AK5702_SIG2, 4, 2, ak5702_mic_power),
+};
+
+static const struct snd_kcontrol_new ak5702_snd_controls[] = {
+    SOC_SINGLE("ADCA Left Vol", AK5702_LVOL1, 0, 242, 0),
+    SOC_SINGLE("ADCA Right Vol", AK5702_RVOL1, 0, 242, 0),
+    SOC_SINGLE("ADCB Left Vol", AK5702_LVOL2, 0, 242, 0),
+    SOC_SINGLE("ADCB Right Vol", AK5702_RVOL2, 0, 242, 0),
+
+    SOC_ENUM("MIC-AmpA Gain", ak5702_enum[0]),
+    SOC_ENUM("MIC-AmpB Gain", ak5702_enum[1]),
+
+    SOC_ENUM("ADCA Left Source", ak5702_enum[2]),
+    SOC_ENUM("ADCA Right Source", ak5702_enum[3]),
+    SOC_ENUM("ADCB Left Source", ak5702_enum[4]),
+    SOC_ENUM("ADCB Right Source", ak5702_enum[5]),
+
+    SOC_ENUM("ADCA Left Type", ak5702_enum[6]),
+    SOC_ENUM("ADCA Right Type", ak5702_enum[7]),
+    SOC_ENUM("ADCB Left Type", ak5702_enum[8]),
+    SOC_ENUM("ADCB Right Type", ak5702_enum[9]),
+
+    SOC_ENUM("ADCA Input Vol mode", ak5702_enum[10]),
+    SOC_ENUM("ADCB Input Vol mode", ak5702_enum[11]),
+
+    SOC_ENUM("ADCA LIN5 Source", ak5702_enum[12]),
+    SOC_ENUM("ADCA RIN5 Source", ak5702_enum[13]),
+    SOC_ENUM("ADCB LIN5 Source", ak5702_enum[14]),
+    SOC_ENUM("ADCB RIN5 Source", ak5702_enum[15]),
+
+    SOC_ENUM("MIC-A Power", ak5702_enum[16]),
+    SOC_ENUM("MIC-B Power", ak5702_enum[17]),
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
+static const struct snd_soc_dapm_route audio_map[] = {
+    {"ADCA Left", NULL, "ADCA Left Input"},
+    {"ADCA Right", NULL, "ADCA Right Input"},
+    {"ADCB Left", NULL, "ADCB Left Input"},
+    {"ADCB Right", NULL, "ADCB Right Input"},
+};
+
+static int ak5702_dai_startup(struct snd_pcm_substream *substream,
+                struct snd_soc_dai *dai)
+{
+    pr_debug("Entered %s\n", __func__);
+    return 0;
+}
+
+static void ak5702_dai_shutdown(struct snd_pcm_substream *substream,
+                struct snd_soc_dai *dai)
+{
+    pr_debug("Entered %s\n", __func__);
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
+        value = ak5702_read_reg_cache(codec, AK5702_FMT1);
+        value &= (~AK5702_FMT1_TDM_MASK);
+        ak5702_write(codec, AK5702_FMT1, value);
+        break;
+    case 8:
+        value = ak5702_read_reg_cache(codec, AK5702_FMT1);
+        value &= (~AK5702_FMT1_TDM_MASK);
+        if (params_format(params) == SNDRV_PCM_FORMAT_S32_LE)
+            value |= AK5702_FMT1_TDM256;
+        else if (params_format(params) == SNDRV_PCM_FORMAT_S16_LE)
+            value |= AK5702_FMT1_TDM128;
+        ak5702_write(codec, AK5702_FMT1, value);
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    /* read fs select register */
+    value = ak5702_read_reg_cache(codec, AK5702_FS1);
+    value &= (~(AK5702_FS1_FS_MASK|AK5702_FS1_BCKO_MASK));
+    switch (params_rate(params)) {
+    case 48000:
+        if (ak5702->clock_mode == PLL_slave_mode2)
+            value |= AK5702_FS1_BCLK_MODE2;
+        else if (ak5702->clock_mode == EXT_slave_mode)
+            value |= AK5702_FS1_SLAVE_256FS; /* mode 3 256fs*/
+        else
+            return -EINVAL;
+        break;
+    default:
+        return -EINVAL;
+    }
+    ak5702_write(codec, AK5702_FS1, value);
+
+    /* power on ADCA */
+    value = AK5702_PM1_PMADAL | AK5702_PM1_PMADAR | AK5702_PM1_PMVCM;
+    ak5702_write(codec, AK5702_PM1, value);
+
+    /* power on ADCB */
+    value = AK5702_PM2_PMADBL | AK5702_PM2_PMADBR;
+    ak5702_write(codec, AK5702_PM2, value);
+    return 0;
+}
+
+static int ak5702_dai_hw_free(struct snd_pcm_substream *substream,
+                struct snd_soc_dai *dai)
+{
+    struct snd_soc_codec *codec = dai->codec;
+    int value;
+
+    pr_debug("Entered %s\n", __func__);
+    /* power down ADCA */
+    value = AK5702_POWERDOWN | AK5702_PM1_PMVCM;
+    ak5702_write(codec, AK5702_PM1, value);
+
+    /* power down ADCB */
+    value = AK5702_POWERDOWN;
+    ak5702_write(codec, AK5702_PM2, value);
+    return 0;
+}
+
+static int ak5702_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+                int clk_id, unsigned int freq, int dir)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+    int value = 0;
+    switch (clk_id) {
+    case PLL_master_mode:
+    case EXT_master_mode:
+        if (dir != SND_SOC_CLOCK_OUT)
+            return -EINVAL;
+        break;
+    case PLL_slave_mode:
+    case PLL_slave_mode2:
+        if (dir != SND_SOC_CLOCK_IN)
+            return -EINVAL;
+        value = AK5702_PLL1_POWERUP |
+            AK5702_PLL1_SLAVE |
+            AK5702_PLL1_MODE2;
+        break;
+    case EXT_slave_mode:
+        if (dir != SND_SOC_CLOCK_IN)
+            return -EINVAL;
+        value = AK5702_PLL1_POWERDOWN | AK5702_PLL1_SLAVE;
+        break;
+    default:
+        return -EINVAL;
+    }
+    ak5702_write(codec, AK5702_PLL1, value);
+    ak5702->clock_mode = clk_id;
+
+    return 0;
+}
+
+static int ak5702_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int
fmt)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    int value;
+    u8 fmt1 = 0;
+    pr_debug("Entered %s", __func__);
+
+    switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+    case SND_SOC_DAIFMT_DSP_A:
+    case SND_SOC_DAIFMT_I2S:
+        fmt1 = AK5702_FMT1_I2S;
+        break;
+    case SND_SOC_DAIFMT_LEFT_J:
+        fmt1 = AK5702_FMT1_MSB;
+        break;
+    default:
+        return -EINVAL;
+    }
+    value = ak5702_read_reg_cache(codec, AK5702_FMT1);
+    value &= (~AK5702_FS1_FS_MASK);
+    value |= fmt1;
+    ak5702_write(codec, AK5702_FMT1, value);
+    ak5702_write(codec, AK5702_FMT2, AK5702_FMT2_STEREO);
+    return 0;
+}
+
+static int ak5702_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+        int source, unsigned int freq_in, unsigned int freq_out)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    u8 reg = 0;
+    pr_debug("Entered %s", __func__);
+    reg = ak5702_read_reg_cache(codec, AK5702_PLL1);
+    switch (pll_id) {
+    case AK5702_PLL_POWERDOWN:
+        reg &= (~AK5702_PLL1_PM_MASK);
+        reg |= AK5702_PLL1_POWERDOWN;
+        break;
+    case AK5702_PLL_MASTER:
+        reg &= (~AK5702_PLL1_MODE_MASK);
+        reg |= AK5702_PLL1_MASTER;
+        reg |= AK5702_PLL1_POWERUP;
+        break;
+    case AK5702_PLL_SLAVE:
+        reg &= (~AK5702_PLL1_MODE_MASK);
+        reg |= AK5702_PLL1_SLAVE;
+        reg |= AK5702_PLL1_POWERUP;
+        break;
+    default:
+        return -ENODEV;
+    }
+
+    switch (freq_in) {
+    case 11289600:
+        reg &= (~AK5702_PLL1_PLL_MASK);
+        reg |= AK5702_PLL1_11289600;
+        break;
+    case 12000000:
+        reg &= (~AK5702_PLL1_PLL_MASK);
+        reg |= AK5702_PLL1_12000000;
+        break;
+    case 12288000:
+        reg &= (~AK5702_PLL1_PLL_MASK);
+        reg |= AK5702_PLL1_12288000;
+        break;
+    case 19200000:
+        reg &= (~AK5702_PLL1_PLL_MASK);
+        reg |= AK5702_PLL1_19200000;
+        break;
+    default:
+        return -ENODEV;
+    }
+
+    ak5702_write(codec, AK5702_PLL1, reg);
+    return 0;
+}
+
+static int ak5702_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
+                    int div_id, int div)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    u8 reg = 0;
+    pr_debug("Entered %s", __func__);
+    if (div_id == AK5702_BCLK_CLKDIV) {
+        reg = ak5702_read_reg_cache(codec, AK5702_FS1);
+        switch (div) {
+        case AK5702_BCLK_DIV_32:
+            reg &= (~AK5702_FS1_BCKO_MASK);
+            reg |= AK5702_FS1_BCKO_32FS;
+            ak5702_write(codec, AK5702_FS1, reg);
+            break;
+        case AK5702_BCLK_DIV_64:
+            reg &= (~AK5702_FS1_BCKO_MASK);
+            reg |= AK5702_FS1_BCKO_64FS;
+            ak5702_write(codec, AK5702_FS1, reg);
+            break;
+        default:
+            return -EINVAL;
+        }
+    }
+    return 0;
+}
+
+#ifdef CONFIG_PM
+static int ak5702_sync(struct snd_soc_codec *codec)
+{
+    u16 *cache = codec->reg_cache;
+    int i, r = 0;
+
+    for (i = 0; i < AK5702_CACHEREGNUM; i++)
+        r |= ak5702_write(codec, i, cache[i]);
+
+    return r;
+}
+
+static int ak5702_suspend(struct snd_soc_codec *codec)
+{
+    return 0;
+}
+
+static int ak5702_resume(struct snd_soc_codec *codec)
+{
+    /* restore register status*/
+    return ak5702_sync(codec);
+}
+#endif
+
+/* define operations */
+struct snd_soc_dai_ops ak5702_ops = {
+    .set_sysclk    = ak5702_set_dai_sysclk,
+    .set_pll    = ak5702_set_dai_pll,
+    .set_clkdiv    = ak5702_set_dai_clkdiv,
+    .set_fmt    = ak5702_set_dai_fmt,
+    .startup    = ak5702_dai_startup,
+    .shutdown    = ak5702_dai_shutdown,
+    .hw_params    = ak5702_dai_hw_params,
+    .hw_free    = ak5702_dai_hw_free,
+};
+
+/* define name and capabilities */
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
+static struct snd_soc_codec *ak5702_codec;
+
+static int ak5702_probe(struct snd_soc_codec *codec)
+{
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+    int ret = 0;
+    u8 reg = 0;
+    dev_info(codec->dev, "AK5702 Audio Codec %s", AK5702_VERSION);
+
+    codec->hw_write    = (hw_write_t)i2c_master_send;
+    codec->control_data = ak5702->control_data;
+
+    /* set the clock type */
+    ak5702->clock_mode = EXT_slave_mode;
+
+    /* power off the device */
+    reg = AK5702_POWERDOWN;
+    ak5702_write(codec, AK5702_PM1, reg);
+
+    /* set default ADCA input LIN5-RIN5, power down ADCA mic power*/
+    reg = AK5702_SIG1_L_LIN5 | AK5702_SIG1_R_RIN5;
+    ak5702_write(codec, AK5702_SIG1, reg);
+
+    /* mic gain +0dB */
+    reg = AK5702_MICGAIN_0DB;
+    ak5702_write(codec, AK5702_MICG1, reg);
+
+    /* volume control dependent for ADCA */
+    reg = AK5702_VOLCTRL_DEP;
+    ak5702_write(codec, AK5702_VOLCTRL1, reg);
+
+    /* set default volume for ADCA */
+    reg = AK5702_VOL_INIT;
+    ak5702_write(codec, AK5702_LVOL1, reg);
+
+    /* power down ADCB */
+    reg = AK5702_POWERDOWN;
+    ak5702_write(codec, AK5702_PM2, reg);
+
+    /* set default ADCB input LIN3-RIN3, power off ADCB mic power*/
+    reg = AK5702_SIG2_L_LIN3 | AK5702_SIG2_R_RIN3;
+    ak5702_write(codec, AK5702_SIG2, reg);
+
+    /* mic gain +0dB */
+    reg = AK5702_MICGAIN_0DB;
+    ak5702_write(codec, AK5702_MICG2, reg);
+
+    /* volume control independent for ADCB */
+    reg = AK5702_VOLCTRL_INDEP;
+    ak5702_write(codec, AK5702_VOLCTRL2, reg);
+
+    /* set default volume for ADCB */
+    reg = AK5702_VOL_INIT;
+    ak5702_write(codec, AK5702_LVOL2, reg);
+    ak5702_write(codec, AK5702_RVOL2, reg);
+
+    snd_soc_add_codec_controls(codec, ak5702_snd_controls,
+               ARRAY_SIZE(ak5702_snd_controls));
+
+    /* add debugfs entry */
+    ak5702_debug_add(ak5702);
+
+    return ret;
+}
+
+static int ak5702_remove(struct snd_soc_codec *codec)
+{
+    struct ak5702_priv *ak5702 = snd_soc_codec_get_drvdata(codec);
+    u8 reg = 0;
+
+    /* power off the device */
+    reg = AK5702_POWERDOWN;
+    ak5702_write(codec, AK5702_PM1, reg);
+    ak5702_debug_remove(ak5702);
+
+    return 0;
+}
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int ak5702_i2c_probe(struct i2c_client *i2c,
+                const struct i2c_device_id *id)
+{
+    struct ak5702_priv *ak5702;
+    int ret;
+    pr_debug("Entered %s", __func__);
+    if (ak5702_codec) { /*maybe useless*/
+        dev_err(&i2c->dev,
+          "Multiple AK5702 devices not supported\n");
+        return -ENOMEM;
+    }
+
+    ak5702 = kzalloc(sizeof(struct ak5702_priv), GFP_KERNEL);
+    if (!ak5702)
+        return -ENOMEM;
+
+    i2c_set_clientdata(i2c, ak5702);
+    ak5702->control_data = i2c;
+    ak5702->control_type = SND_SOC_I2C;
+
+    ret = snd_soc_register_codec(&i2c->dev,
+                &soc_codec_dev_ak5702, &ak5702_dai, 1);
+    if (ret < 0) {
+        kfree(ak5702);
+        return ret;
+    }
+    return ret;
+}
+
+static __devexit int ak5702_i2c_remove(struct i2c_client *client)
+{
+    snd_soc_unregister_codec(&client->dev);
+    kfree(i2c_get_clientdata(client));
+    return 0;
+}
+
+static const struct i2c_device_id ak5702_i2c_id[] = {
+    {"ak5702-codec", 0},
+    {}
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
+#endif
+
+struct snd_soc_codec_driver soc_codec_dev_ak5702 = {
+    .probe            = ak5702_probe,
+    .remove            = ak5702_remove,
+#ifdef CONFIG_PM
+    .suspend        = ak5702_suspend,
+    .resume            = ak5702_resume,
+#endif
+    .read            = ak5702_read_reg_cache,
+    .write            = ak5702_write,
+    .reg_cache_size        = ARRAY_SIZE(ak5702_reg) ,
+    .reg_word_size        = sizeof(u16),
+    .reg_cache_default    = ak5702_reg,
+};
+
+static int __init ak5702_modinit(void)
+{
+    int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+    ret = i2c_add_driver(&ak5702_i2c_driver);
+#endif
+    return ret;
+}
+module_init(ak5702_modinit);
+
+static void __exit ak5702_exit(void)
+{
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+    i2c_del_driver(&ak5702_i2c_driver);
+#endif
+}
+module_exit(ak5702_exit);
+
+MODULE_DESCRIPTION("Asahi Kasei AK5702 ALSA SoC driver");
+MODULE_AUTHOR("Paolo Doz <paolo.doz@gmail.com");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
