From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: [PATCH v3] ASoC: Add support for NAU8825 codec to ASoC
Date: Mon, 13 Jul 2015 15:33:06 +0800
Message-ID: <55A369B2.5040500@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The NAU88L25 is an ultra-low power high performance audio codec designed
for smartphone, tablet PC, and other portable devices by Nuvoton, now
add linux driver support for it.

Signed-off-by: Chih-Chiang Chang <ccchang12@nuvoton.com>
---
v3->v2:
    - fix the wrong definition of reg_default
    - fix the flow of set_sys_clk() and nau8825_set_bias_level()
    - remove unnecessary code in nau8825_volatile_register() and nau8825_i2c_probe()
    - add trigger function for ADC/DAC control
    - add some register definitions
    - fix some coding style issues
v2->v1:
    - fixes according to Lars-Peter Clausen's review comments
    - removes unused platform data file
    - corrects the naming of DAPM input widget
    - fixes some wrong coding of SOC widgets and other codes
    - adds definition and remark for config FLL clock
    - moves the code of reset hardware registers from codec_probe() to i2c_probe()
    - removes unused codes

  sound/soc/codecs/Kconfig   |   5 +
  sound/soc/codecs/Makefile  |   2 +
  sound/soc/codecs/nau8825.c | 724 +++++++++++++++++++++++++++++++++++++++++++++
  sound/soc/codecs/nau8825.h | 399 +++++++++++++++++++++++++
  4 files changed, 1130 insertions(+)
  create mode 100644 sound/soc/codecs/nau8825.c
  create mode 100644 sound/soc/codecs/nau8825.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efaafce..1edb781 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -76,6 +76,7 @@ config SND_SOC_ALL_CODECS
      select SND_SOC_MAX9877 if I2C
      select SND_SOC_MC13783 if MFD_MC13XXX
      select SND_SOC_ML26124 if I2C
+    select SND_SOC_NAU8825 if I2C
      select SND_SOC_HDMI_CODEC
      select SND_SOC_PCM1681 if I2C
      select SND_SOC_PCM1792A if SPI_MASTER
@@ -470,6 +471,10 @@ config SND_SOC_MAX98925
  config SND_SOC_MAX9850
      tristate

+config SND_SOC_NAU8825
+    tristate "Nuvoton NAU8825 CODEC"
+    depends on I2C
+
  config SND_SOC_PCM1681
      tristate "Texas Instruments PCM1681 CODEC"
      depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index cf160d9..db0a4ec 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -69,6 +69,7 @@ snd-soc-max98925-objs := max98925.o
  snd-soc-max9850-objs := max9850.o
  snd-soc-mc13783-objs := mc13783.o
  snd-soc-ml26124-objs := ml26124.o
+snd-soc-nau8825-objs := nau8825.o
  snd-soc-hdmi-codec-objs := hdmi.o
  snd-soc-pcm1681-objs := pcm1681.o
  snd-soc-pcm1792a-codec-objs := pcm1792a.o
@@ -256,6 +257,7 @@ obj-$(CONFIG_SND_SOC_MAX98925)    += snd-soc-max98925.o
  obj-$(CONFIG_SND_SOC_MAX9850)    += snd-soc-max9850.o
  obj-$(CONFIG_SND_SOC_MC13783)    += snd-soc-mc13783.o
  obj-$(CONFIG_SND_SOC_ML26124)    += snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_NAU8825)    += snd-soc-nau8825.o
  obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
  obj-$(CONFIG_SND_SOC_PCM1681)    += snd-soc-pcm1681.o
  obj-$(CONFIG_SND_SOC_PCM1792A)    += snd-soc-pcm1792a-codec.o
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
new file mode 100644
index 0000000..d3b306a
--- /dev/null
+++ b/sound/soc/codecs/nau8825.c
@@ -0,0 +1,724 @@
+/*
+ * nau8825.c
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ * Author: Meng-Huang Kuo <mhkuo@nuvoton.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/acpi.h>
+#include <asm/div64.h>
+#include <sound/jack.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <linux/delay.h>
+#include "nau8825.h"
+
+static const DECLARE_TLV_DB_SCALE(out_hp_vol_tlv, -5400, 100, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -10350, 50, 0);
+
+static const struct snd_kcontrol_new nau8825_snd_controls[] = {
+    SOC_SINGLE_TLV("MIC Volume", NAU8825_ADC_DGAIN_CTRL,
+            NAU8825_ADC_DGAIN_SFT,
+            NAU8825_ADC_VOL_RSCL_RANGE, 0, adc_vol_tlv),
+    SOC_DOUBLE_TLV("HP Volume", NAU8825_HSVOL_CTRL,
+            NAU8825_L_HSVOL_SFT, NAU8825_R_HSVOL_SFT,
+            NAU8825_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),
+};
+
+static const struct snd_kcontrol_new nau8825_hpo_mix[] = {
+    SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
+            NAU8825_L_MUTE_SFT, 1, 1),
+    SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
+            NAU8825_R_MUTE_SFT, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
+    /* Input */
+    SND_SOC_DAPM_INPUT("MIC"),
+    SND_SOC_DAPM_SUPPLY("MIC BIAS", NAU8825_BOOST, NAU8825_G_BIAS_SFT, 0,
+            NULL, 0),
+    /* Audio Interface */
+    SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+    SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+    /* DACs */
+    SND_SOC_DAPM_DAC("DAC L1", NULL, NAU8825_DAC_CTRL,
+            NAU8825_DAC_L_SFT, 0),
+    SND_SOC_DAPM_DAC("DAC R1", NULL, NAU8825_DAC_CTRL,
+            NAU8825_DAC_R_SFT, 0),
+    /* SPO/HPO/LOUT/Mono Mixer */
+    SND_SOC_DAPM_MIXER("HPO MIX", SND_SOC_NOPM, 0, 0, nau8825_hpo_mix,
+            ARRAY_SIZE(nau8825_hpo_mix)),
+    SND_SOC_DAPM_SUPPLY("HP amp", NAU8825_CLASSG_CTRL,
+            NAU8825_CLASSG_EN_SHIFT, 0, NULL, 0),
+    /* Output */
+    SND_SOC_DAPM_OUTPUT("HPOL"),
+    SND_SOC_DAPM_OUTPUT("HPOR"),
+};
+
+static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
+    {"AIF1TX", NULL, "MIC"},
+    {"DAC L1", NULL, "AIF1RX"},
+    {"DAC R1", NULL, "AIF1RX"},
+    {"HPO MIX", "HP L Switch", "DAC L1"},
+    {"HPO MIX", "HP R Switch", "DAC R1"},
+    {"HPOL", NULL, "HPO MIX"},
+    {"HPOR", NULL, "HPO MIX"},
+    {"HPOL", NULL, "HP amp"},
+    {"HPOR", NULL, "HP amp"},
+};
+
+static int nau8825_hw_params(struct snd_pcm_substream *substream,
+                struct snd_pcm_hw_params *params,
+                struct snd_soc_dai *dai)
+{
+    struct snd_soc_codec *codec = dai->codec;
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+    unsigned int val_len = 0;
+
+    switch (params_width(params)) {
+    case 16:
+        break;
+    case 20:
+        val_len |= NAU8825_I2S_DL_20;
+        break;
+    case 24:
+        val_len |= NAU8825_I2S_DL_24;
+        break;
+    case 32:
+        val_len |= NAU8825_I2S_DL_32;
+        break;
+    default:
+        return -EINVAL;
+    }
+    regmap_update_bits(nau8825->regmap, NAU8825_I2S_PCM_CTRL_1,
+            NAU8825_I2S_DL_MASK, val_len);
+    return 0;
+}
+
+static int nau8825_dac_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    if (mute)
+        regmap_update_bits(nau8825->regmap, NAU8825_DAC_MUTE_CTRL,
+                NAU8825_SOFT_MUTE_MASK, NAU8825_SOFT_MUTE_EN);
+    else
+        regmap_update_bits(nau8825->regmap, NAU8825_DAC_MUTE_CTRL,
+                NAU8825_SOFT_MUTE_MASK, NAU8825_SOFT_MUTE_DIS);
+    return 0;
+}
+
+static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+    struct snd_soc_codec *codec = codec_dai->codec;
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+    unsigned int reg_val = 0;
+
+    dev_dbg(codec->dev, " %s ###nau8825_set_dai_fmt %x\n", __func__, fmt);
+    /* interface format */
+    switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+    case SND_SOC_DAIFMT_NB_NF:
+        break;
+    case SND_SOC_DAIFMT_IB_NF:
+        reg_val |= NAU8825_I2S_BP_INV;
+        break;
+    default:
+        dev_alert(codec->dev, "Invalid DAI interface format\n");
+        return -EINVAL;
+    }
+    switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+    case SND_SOC_DAIFMT_I2S:
+        reg_val |= NAU8825_I2S_DF_I2S;
+        break;
+    case SND_SOC_DAIFMT_LEFT_J:
+        reg_val |= NAU8825_I2S_DF_LEFT;
+        break;
+    case SND_SOC_DAIFMT_RIGHT_J:
+        reg_val |= NAU8825_I2S_DF_RIGHT;
+        break;
+    case SND_SOC_DAIFMT_DSP_A:
+        reg_val |= NAU8825_I2S_DF_PCM_A;
+        break;
+    case SND_SOC_DAIFMT_DSP_B:
+        reg_val |= NAU8825_I2S_DF_PCM_B;
+        reg_val |= NAU8825_I2S_PCMB_EN;
+        break;
+    default:
+        dev_alert(codec->dev, "Invalid DAI I2S/PCM format\n");
+        return -EINVAL;
+    }
+    regmap_update_bits(nau8825->regmap, NAU8825_I2S_PCM_CTRL_1,
+            NAU8825_I2S_DL_MASK | NAU8825_I2S_DF_MASK
+            | NAU8825_I2S_BP_MASK | NAU8825_I2S_PCMB_MASK,
+            reg_val);
+    return 0;
+}
+
+static void config_fll_clk_12m(struct snd_soc_codec *codec)
+{
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
+            NAU8825_CLK_MCLK_SRC_MASK, 0x0003);
+    regmap_update_bits(nau8825->regmap, NAU8825_FLL_1,
+            NAU8825_FLL_RATIO_MASK, 0x0001);
+    /* FLL 16-bit fractional input */
+    regmap_write(nau8825->regmap, NAU8825_FLL_2, 0xc49b);
+    /* FLL 10-bit integer input */
+    regmap_update_bits(nau8825->regmap, NAU8825_FLL_3,
+            NAU8825_FLL_INTEGER_MASK, 0x0020);
+    /* FLL pre-scaler */
+    regmap_update_bits(nau8825->regmap, NAU8825_FLL_4,
+            NAU8825_FLL_REF_DIV_MASK, 0x0800);
+    /* select divied VCO input */
+    regmap_update_bits(nau8825->regmap, NAU8825_FLL_5,
+            NAU8825_FLL_FILTER_SW_MASK, 0x0000);
+    /* FLL sigma delta modulator enable */
+    regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
+            NAU8825_SDM_EN_MASK, 0x4000);
+}
+
+static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
+{
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    pr_debug("%s :: sys_clk=%x\n", __func__, sys_clk);
+    switch (sys_clk) {
+    case NAU8825_INTERNALCLOCK:
+        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
+                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_DIS);
+        regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
+                NAU8825_DCO_EN_MASK, NAU8825_DCO_EN);
+        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
+                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_EN);
+        break;
+    case NAU8825_MCLK:
+    default:
+        regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
+                NAU8825_DCO_EN_MASK, NAU8825_DCO_DIS);
+        regmap_update_bits(nau8825->regmap, NAU8825_I2S_PCM_CTRL_2,
+                NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+        /* FLL clock source from MCLK */
+        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
+                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_DIS);
+        mdelay(2);
+        regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
+                NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_EN);
+        break;
+    }
+}
+
+static int nau8825_dai_set_sysclk(struct snd_soc_dai *dai,
+        int clk_id, unsigned int freq, int dir)
+{
+    struct snd_soc_codec *codec = dai->codec;
+
+    switch (clk_id) {
+    case NAU8825_MCLK:
+        config_fll_clk_12m(codec);
+        set_sys_clk(codec, clk_id);
+        break;
+    case NAU8825_INTERNALCLOCK:
+        set_sys_clk(codec, clk_id);
+        break;
+    default:
+        dev_err(codec->dev, "Wrong clock src\n");
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int nau8825_set_bias_level(struct snd_soc_codec *codec,
+                enum snd_soc_bias_level level)
+{
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    switch (level) {
+    case SND_SOC_BIAS_ON:
+        /* All power is driven by DAPM system*/
+        dev_dbg(codec->dev, "###nau8825_set_bias_level BIAS_ON\n");
+        regmap_update_bits(nau8825->regmap, NAU8825_BIAS_ADJ,
+                NAU8825_VMIDSEL_MASK, NAU8825_VMIDSEL_125KOHM);
+        regmap_update_bits(nau8825->regmap, NAU8825_BIAS_ADJ,
+                NAU8825_VMID_MASK, NAU8825_VMID_EN);
+        regmap_update_bits(nau8825->regmap, NAU8825_BOOST,
+                NAU8825_G_BIAS_MASK, NAU8825_G_BIAS_EN);
+        break;
+    case SND_SOC_BIAS_OFF:
+        dev_dbg(codec->dev, "###nau8825_set_bias_level OFF\n");
+        set_sys_clk(codec, NAU8825_INTERNALCLOCK);
+        regmap_update_bits(nau8825->regmap, NAU8825_BIAS_ADJ,
+                NAU8825_VMID_MASK, NAU8825_VMID_DIS);
+        regmap_update_bits(nau8825->regmap, NAU8825_BOOST,
+                NAU8825_G_BIAS_MASK, NAU8825_G_BIAS_DIS);
+        break;
+    default:
+        break;
+    }
+    codec->dapm.bias_level = level;
+    dev_dbg(codec->dev, "## nau8825_set_bias_level %d\n", level);
+    return 0;
+}
+
+
+static const struct reg_default nau8825_reg[] = {
+    {0x000, 0x0000},
+    {0x001, 0x00ff},
+    {0x003, 0x0050},
+    {0x004, 0x0000},
+    {0x005, 0x3126},
+    {0x006, 0x0008},
+    {0x007, 0x0010},
+    {0x008, 0x0000},
+    {0x009, 0x6000},
+    {0x00a, 0xf13c},
+    {0x00c, 0x000c},
+    {0x00d, 0x0000},
+    {0x00f, 0x0800},
+    {0x010, 0x0000},
+    {0x011, 0x0000},
+    {0x012, 0x0010},
+    {0x013, 0x0015},
+    {0x014, 0x0110},
+    {0x015, 0x0000},
+    {0x016, 0x0000},
+    {0x017, 0x0000},
+    {0x018, 0x0000},
+    {0x019, 0x0000},
+    {0x01a, 0x0000},
+    {0x01b, 0x0000},
+    {0x01c, 0x000b},
+    {0x01d, 0x8010},
+    {0x01e, 0x0000},
+    {0x01f, 0x0000},
+    {0x020, 0x0000},
+    {0x021, 0x0000},
+    {0x022, 0x0000},
+    {0x023, 0x0000},
+    {0x024, 0x0000},
+    {0x025, 0x0000},
+    {0x026, 0x0000},
+    {0x027, 0x0000},
+    {0x028, 0x0000},
+    {0x029, 0x0000},
+    {0x02a, 0x0000},
+    {0x02b, 0x0010},
+    {0x02c, 0x0001},
+    {0x02d, 0x0000},
+    {0x02f, 0x0000},
+    {0x030, 0x01cf},
+    {0x031, 0x0000},
+    {0x032, 0x0000},
+    {0x033, 0x00cf},
+    {0x034, 0x0000},
+    {0x038, 0x1486},
+    {0x039, 0x0f12},
+    {0x03a, 0x25ff},
+    {0x03b, 0x3457},
+    {0x045, 0x1486},
+    {0x046, 0x0f12},
+    {0x047, 0x25f9},
+    {0x048, 0x3457},
+    {0x04c, 0x0000},
+    {0x04d, 0x0000},
+    {0x050, 0x0000},
+    {0x051, 0x0000},
+    {0x055, 0x0000},
+    {0x058, 0x0000},
+    {0x059, 0x0000},
+    {0x066, 0x0000},
+    {0x068, 0x0000},
+    {0x069, 0x0000},
+    {0x06a, 0x0020},
+    {0x071, 0x0011},
+    {0x072, 0x0020},
+    {0x073, 0x0008},
+    {0x074, 0x0006},
+    {0x076, 0x0000},
+    {0x077, 0x0000},
+    {0x07f, 0x0000},
+    {0x080, 0x0300},
+    {0x081, 0x0000},
+    {0x082, 0x0000},
+};
+
+static int nau8825_codec_remove(struct snd_soc_codec *codec)
+{
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    regmap_write(nau8825->regmap, NAU8825_RESET, 0x00);
+    regmap_write(nau8825->regmap, NAU8825_RESET, 0x00);
+    return 0;
+}
+
+static int nau8825_codec_probe(struct snd_soc_codec *codec)
+{
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    /* bias current settings */
+    regmap_write(nau8825->regmap, 0x0072, 0x0260);
+    /* enable bias */
+    nau8825_set_bias_level(codec, SND_SOC_BIAS_ON);
+    mdelay(10);
+    /* DAC digital default gain 0 dB */
+    regmap_write(nau8825->regmap, 0x0033, 0x00cf);
+    regmap_write(nau8825->regmap, 0x0034, 0x02cf);
+    /* DAC driver default gain -29 dB */
+    regmap_write(nau8825->regmap, 0x0032, 0x075d);
+    /* ADC digital default gain 8 dB */
+    regmap_write(nau8825->regmap, 0x0030, 0x00d2);
+    /* ehance I2C SDA driver strength */
+    regmap_write(nau8825->regmap, 0x0080, 0x0800);
+    /* enable ADC/DAC clocks */
+    regmap_write(nau8825->regmap, 0x0001, 0x07fd);
+    /* headphone output */
+    regmap_write(nau8825->regmap, 0x00C, 0x000c);
+    return 0;
+}
+
+static const struct snd_soc_codec_driver soc_codec_driver_nau8825 = {
+    .probe = nau8825_codec_probe,
+    .remove    = nau8825_codec_remove,
+    .suspend_bias_off = true,
+    .set_bias_level    = nau8825_set_bias_level,
+    .controls = nau8825_snd_controls,
+    .num_controls = ARRAY_SIZE(nau8825_snd_controls),
+    .dapm_widgets = nau8825_dapm_widgets,
+    .num_dapm_widgets = ARRAY_SIZE(nau8825_dapm_widgets),
+    .dapm_routes = nau8825_dapm_routes,
+    .num_dapm_routes = ARRAY_SIZE(nau8825_dapm_routes),
+};
+
+static bool nau8825_readable_register(struct device *dev, unsigned int reg)
+{
+    switch (reg) {
+    case NAU8825_RESET:
+    case NAU8825_ENA_CTRL:
+    case NAU8825_CLK_EN:
+    case NAU8825_CLK_DIVIDER:
+    case NAU8825_FLL_1:
+    case NAU8825_FLL_2:
+    case NAU8825_FLL_3:
+    case NAU8825_FLL_4:
+    case NAU8825_FLL_5:
+    case NAU8825_FLL_6:
+    case NAU8825_HEADSET_CTRL:
+    case NAU8825_JACK_DET_CTRL:
+    case NAU8825_IRQ_MASK:
+    case NAU8825_IRQ_STATUS:
+    case NAU8825_IRQ_CLEAR:
+    case NAU8825_IRQ_CTRL:
+    case NAU8825_SAR_ADC:
+    case NAU8825_VDET_COEFFICIENT:
+    case NAU8825_VDET_THRESHOLD_1:
+    case NAU8825_VDET_THRESHOLD_2:
+    case NAU8825_GPIO12_CTRL:
+    case NAU8825_GPIO34_CTRL:
+    case NAU8825_I2S_PCM_CTRL_1:
+    case NAU8825_I2S_PCM_CTRL_2:
+    case NAU8825_ADC_RATE:
+    case NAU8825_DAC_CTRL1:
+    case NAU8825_DAC_CTRL2:
+    case NAU8825_IMM_MODE_CTRL:
+    case NAU8825_IMM_RMS_VALUE:
+    case NAU8825_ADC_DGAIN_CTRL:
+    case NAU8825_DAC_MUTE_CTRL:
+    case NAU8825_HSVOL_CTRL:
+    case NAU8825_DACL_CTRL:
+    case NAU8825_DACR_CTRL:
+    case NAU8825_SAR_ADC_OUTPUT:
+    case NAU8825_ANALOG_CTRL_2:
+    case NAU8825_ANALOG_ADC_1:
+    case NAU8825_ANALOG_ADC_2:
+    case NAU8825_DAC_CTRL:
+    case NAU8825_MIC_BIAS:
+    case NAU8825_BOOST:
+    case NAU8825_CLASSG_CTRL:
+    case NAU8825_I2C_DEVICE_ID:
+    case NAU8825_BIAS_ADJ:
+    case NAU8825_POWER_UP_CTRL:
+    case NAU8825_CHARGE_BUMP_CTRL:
+    case NAU8825_CHARGE_BUMP_RD:
+    case NAU8825_GENERAL_STATUS:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool nau8825_volatile_register(struct device *dev, unsigned int reg)
+{
+    switch (reg) {
+    case NAU8825_RESET:
+    case NAU8825_CLK_DIVIDER:
+    case NAU8825_FLL_1:
+    case NAU8825_FLL_2:
+    case NAU8825_FLL_3:
+    case NAU8825_FLL_4:
+    case NAU8825_FLL_5:
+    case NAU8825_FLL_6:
+    case NAU8825_ANALOG_CTRL_2:
+    case NAU8825_ANALOG_ADC_1:
+    case NAU8825_ANALOG_ADC_2:
+    case NAU8825_DAC_CTRL:
+    case NAU8825_MIC_BIAS:
+    case NAU8825_BOOST:
+    case NAU8825_CLASSG_CTRL:
+    case NAU8825_I2C_DEVICE_ID:
+    case NAU8825_BIAS_ADJ:
+    case NAU8825_POWER_UP_CTRL:
+    case NAU8825_CHARGE_BUMP_CTRL:
+    case NAU8825_GENERAL_STATUS:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static const struct regmap_config nau8825_regmap = {
+    .reg_bits = 16,
+    .val_bits = 16,
+    .use_single_rw = true,
+    .max_register = NAU8825_MAX_REGISTER,
+    .volatile_reg = nau8825_volatile_register,
+    .readable_reg = nau8825_readable_register,
+    .cache_type = REGCACHE_RBTREE,
+    .reg_defaults = nau8825_reg,
+    .num_reg_defaults = ARRAY_SIZE(nau8825_reg),
+};
+
+static int ena_adc(struct nau8825_priv *nau8825)
+{
+    /* adc & clock settings */
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_ADC_CLK_MASK, NAU8825_ADC_CLK_EN);
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_ADC_MASK, NAU8825_ADC_EN);
+    /* adc PGA settings */
+    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
+            NAU8825_FEPGA_GAIN_MASK, 0x1b00);
+    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
+            NAU8825_FEPGA_MASK, NAU8825_FEPGA_EN);
+    /* mic bias output level (1.1V) */
+    regmap_update_bits(nau8825->regmap, NAU8825_MIC_BIAS,
+            NAU8825_MIC_BIAS_LVL_MSK, 0x04);
+    /* enable mic bias */
+    regmap_update_bits(nau8825->regmap, NAU8825_MIC_BIAS,
+            NAU8825_MIC_POWERUP_MSK, NAU8825_MIC_POWERUP_EN);
+    mdelay(10);
+    return 0;
+}
+
+static int dis_adc(struct nau8825_priv *nau8825)
+{
+    /* disable PGA */
+    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
+            NAU8825_FEPGA_MASK, NAU8825_FEPGA_DIS);
+    /* adc & clock settings */
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_ADC_MASK, NAU8825_ADC_DIS);
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_ADC_CLK_MASK, NAU8825_ADC_CLK_DIS);
+    return 0;
+}
+
+static int ena_dac(struct nau8825_priv *nau8825)
+{
+    /* charge bump settings */
+    regmap_update_bits(nau8825->regmap, NAU8825_CHARGE_BUMP_CTRL,
+            0x07ff, 0x720);
+    /* enable DAC clock */
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_DAC_CLK_MASK, NAU8825_DAC_CLK_EN);
+    /* enable DAC channel */
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_DAC_MASK, NAU8825_DAC_EN);
+    /* classG parameter settings */
+    regmap_update_bits(nau8825->regmap, NAU8825_CLASSG_CTRL,
+            ~NAU8825_CLASSG_EN_MASK, 0x2007);
+    /* enable DAC */
+    regmap_write(nau8825->regmap, NAU8825_DAC_CTRL, 0x332c);
+    /* output driver settings */
+    regmap_write(nau8825->regmap, NAU8825_POWER_UP_CTRL, 0x073c);
+    /* power up main driver */
+    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
+            NAU8825_PUP_MAIN_MASK, NAU8825_PUP_MAIN_ENA);
+    mdelay(200);
+    /* enable charge bump */
+    regmap_update_bits(nau8825->regmap, NAU8825_CHARGE_BUMP_CTRL,
+            NAU8825_PD_DAC_MASK, NAU8825_PD_DAC_DIS);
+    return 0;
+}
+
+static int dis_dac(struct nau8825_priv *nau8825)
+{
+    /* disable charge bump */
+    regmap_update_bits(nau8825->regmap, NAU8825_CHARGE_BUMP_CTRL,
+            NAU8825_PD_DAC_MASK, NAU8825_PD_DAC_ENA);
+    /* disable classG */
+    regmap_update_bits(nau8825->regmap, NAU8825_CLASSG_CTRL,
+            NAU8825_CLASSG_PATH_MASK, NAU8825_CLASSG_PATH_DIS);
+    /* disable DAC */
+    regmap_update_bits(nau8825->regmap, NAU8825_DAC_CTRL,
+            NAU8825_DAC_LR_MASK, NAU8825_DAC_LR_DIS);
+    regmap_update_bits(nau8825->regmap, NAU8825_DAC_CTRL,
+            NAU8825_DAC_CLK_LR_MASK, NAU8825_DAC_CLK_LR_DIS);
+    /* disable output driver */
+    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
+            0x3f, 0x00);
+    /* disable DAC channel */
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_L_DAC_MASK, NAU8825_L_DAC_DIS);
+    /* disable DAC clock */
+    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
+            NAU8825_DAC_CLK_MASK, NAU8825_DAC_CLK_DIS);
+    return 0;
+}
+
+static int nau8825_trigger(struct snd_pcm_substream *substream,
+            int cmd, struct snd_soc_dai *dai)
+{
+    struct snd_soc_codec *codec = dai->codec;
+    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+    switch (cmd) {
+    case SNDRV_PCM_TRIGGER_START:
+        config_fll_clk_12m(codec);
+        set_sys_clk(codec, NAU8825_MCLK);
+        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+            ena_dac(nau8825);
+        else
+            ena_adc(nau8825);
+        break;
+    case SNDRV_PCM_TRIGGER_RESUME:
+        break;
+    case SNDRV_PCM_TRIGGER_STOP:
+        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+            dis_dac(nau8825);
+        else
+            dis_adc(nau8825);
+        break;
+    case SNDRV_PCM_TRIGGER_SUSPEND:
+        break;
+    default:
+        break;
+    }
+    return 0;
+}
+
+#define NAU8825_RATES    SNDRV_PCM_RATE_8000_192000
+#define NAU8825_FORMATS    (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+             | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static const struct snd_soc_dai_ops nau8825_dai_ops = {
+    .trigger    = nau8825_trigger,
+    .hw_params    = nau8825_hw_params,
+    .set_sysclk    = nau8825_dai_set_sysclk,
+    .set_fmt    = nau8825_set_dai_fmt,
+    .digital_mute    = nau8825_dac_mute,
+};
+
+static struct snd_soc_dai_driver nau8825_dai_driver[] = {
+    {
+        .name = "nau8825-aif1",
+        .playback = {
+            .stream_name     = "AIF1 Playback",
+            .channels_min     = 1,
+            .channels_max     = 2,
+            .rates         = NAU8825_RATES,
+            .formats     = NAU8825_FORMATS,
+        },
+        .capture = {
+            .stream_name     = "AIF1 Capture",
+            .channels_min     = 1,
+            .channels_max     = 2,
+            .rates         = NAU8825_RATES,
+            .formats     = NAU8825_FORMATS,
+        },
+        .ops = &nau8825_dai_ops,
+    }
+};
+
+
+static int nau8825_i2c_probe(struct i2c_client *i2c,
+                 const struct i2c_device_id *i2c_id)
+{
+    struct nau8825_priv *nau8825;
+    int ret;
+
+    nau8825 = devm_kzalloc(&i2c->dev, sizeof(*nau8825),
+        GFP_KERNEL);
+    if (nau8825 == NULL)
+        return -ENOMEM;
+    nau8825->i2c = i2c;
+    i2c_set_clientdata(i2c, nau8825);
+    nau8825->regmap = devm_regmap_init_i2c(i2c, &nau8825_regmap);
+    if (IS_ERR(nau8825->regmap)) {
+        ret = PTR_ERR(nau8825->regmap);
+        dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+        return ret;
+    }
+    /* software reset */
+    regmap_write(nau8825->regmap, NAU8825_RESET, 0x00);
+    regmap_write(nau8825->regmap, NAU8825_RESET, 0x00);
+
+    /* register sound card */
+    ret = snd_soc_register_codec(&i2c->dev, &soc_codec_driver_nau8825,
+                nau8825_dai_driver,
+                ARRAY_SIZE(nau8825_dai_driver));
+    return ret;
+}
+
+static int nau8825_i2c_remove(struct i2c_client *i2c)
+{
+    snd_soc_unregister_codec(&i2c->dev);
+    return 0;
+}
+
+static const struct i2c_device_id nau8825_i2c_id[] = {
+    {"nau8825", 0},
+    { }
+};
+MODULE_DEVICE_TABLE(i2c, nau8825_i2c_id);
+
+static const struct acpi_device_id nau8825_acpi_match[] = {
+    { "10508825", 0 },
+    {},
+};
+MODULE_DEVICE_TABLE(acpi, nau8825_acpi_match);
+
+static struct i2c_driver nau8825_i2c_driver = {
+    .driver = {
+        .name    = "nau8825",
+        .owner    = THIS_MODULE,
+        .acpi_match_table = ACPI_PTR(nau8825_acpi_match),
+    },
+    .probe        = nau8825_i2c_probe,
+    .remove        = (nau8825_i2c_remove),
+    .id_table    = nau8825_i2c_id,
+};
+module_i2c_driver(nau8825_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU8825 codec driver");
+MODULE_AUTHOR("Nuvoton");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
new file mode 100644
index 0000000..3050e7c
--- /dev/null
+++ b/sound/soc/codecs/nau8825.h
@@ -0,0 +1,399 @@
+/*
+ * nau8825.h
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ * Author: Meng-Huang Kuo <mhkuo@nuvoton.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _NAU8825_H
+#define _NAU8825_H
+
+#define NAU8825_RESET                0x00
+#define NAU8825_ENA_CTRL            0x01
+#define NAU8825_CLK_EN                0x02
+#define NAU8825_CLK_DIVIDER            0x03
+#define NAU8825_FLL_1                0x04
+#define NAU8825_FLL_2                0x05
+#define NAU8825_FLL_3                0x06
+#define NAU8825_FLL_4                0x07
+#define NAU8825_FLL_5                0x08
+#define NAU8825_FLL_6                0x09
+#define NAU8825_HEADSET_CTRL            0x0C
+#define NAU8825_JACK_DET_CTRL            0x0D
+#define NAU8825_IRQ_MASK            0x0F
+#define NAU8825_IRQ_STATUS            0x10
+#define NAU8825_IRQ_CLEAR            0x11
+#define NAU8825_BTN_STATUS            0x11
+#define NAU8825_IRQ_CTRL            0x12
+#define NAU8825_SAR_ADC                0x13
+#define NAU8825_VDET_COEFFICIENT        0x14
+#define NAU8825_VDET_THRESHOLD_1        0x15
+#define NAU8825_VDET_THRESHOLD_2        0x16
+#define NAU8825_GPIO34_CTRL            0x19
+#define NAU8825_GPIO12_CTRL            0x1A
+#define NAU8825_TDM_CTRL            0x1B
+#define NAU8825_I2S_PCM_CTRL_1            0x1C
+#define NAU8825_I2S_PCM_CTRL_2            0x1D
+#define NAU8825_BIQ_CTRL            0x20
+#define NAU8825_BIQ_COF1            0x21
+#define NAU8825_BIQ_COF2            0x22
+#define NAU8825_BIQ_COF3            0x23
+#define NAU8825_BIQ_COF4            0x24
+#define NAU8825_BIQ_COF5            0x25
+#define NAU8825_BIQ_COF6            0x26
+#define NAU8825_BIQ_COF7            0x27
+#define NAU8825_BIQ_COF8            0x28
+#define NAU8825_BIQ_COF9            0x29
+#define NAU8825_BIQ_COF10            0x2A
+#define NAU8825_ADC_RATE            0x2B
+#define NAU8825_DAC_CTRL1            0x2C
+#define NAU8825_DAC_CTRL2            0x2D
+#define NAU8825_DAC_DGAIN_CTRL            0x2F
+#define NAU8825_ADC_DGAIN_CTRL            0x30
+#define NAU8825_DAC_MUTE_CTRL            0x31
+#define NAU8825_HSVOL_CTRL            0x32
+#define NAU8825_DACL_CTRL            0x33
+#define NAU8825_DACR_CTRL            0x34
+#define NAU8825_ADC_DRC_KNEE_IP12        0x38
+#define NAU8825_ADC_DRC_KNEE_IP34        0x39
+#define NAU8825_ADC_DRC_SLOPES            0x3A
+#define NAU8825_ADC_DRC_ATKDCY            0x3B
+#define NAU8825_DAC_DRC_KNEE_IP12        0x45
+#define NAU8825_DAC_DRC_KNEE_IP34        0x46
+#define NAU8825_DAC_DRC_SLOPES            0x47
+#define NAU8825_DAC_DRC_ATKDCY            0x48
+#define NAU8825_IMM_MODE_CTRL            0x4C
+#define NAU8825_IMM_RMS_VALUE            0x4D
+#define NAU8825_CLASSG_CTRL            0x50
+#define NAU8825_I2C_DEVICE_ID            0x58
+#define NAU8825_SAR_ADC_OUTPUT            0x59
+#define NAU8825_BIAS_ADJ            0x66
+#define NAU8825_ANALOG_CTRL_2            0x6A
+#define NAU8825_ANALOG_ADC_1            0x71
+#define NAU8825_ANALOG_ADC_2            0x72
+#define NAU8825_DAC_CTRL            0x73
+#define NAU8825_MIC_BIAS            0x74
+#define NAU8825_BOOST                0x76
+#define NAU8825_POWER_UP_CTRL            0x7F
+#define NAU8825_CHARGE_BUMP_CTRL        0x80
+#define NAU8825_CHARGE_BUMP_RD            0x81
+#define NAU8825_GENERAL_STATUS            0x82
+#define NAU8825_MAX_REGISTER            0xFF
+
+/* reg. NAU8825_ENA_CTRL (0x01) */
+#define NAU8825_R_DAC_MASK            (0x1 << 10)
+#define NAU8825_R_DAC_EN            (0x1 << 10)
+#define NAU8825_R_DAC_DIS            (0x0 << 10)
+#define NAU8825_L_DAC_MASK            (0x1 << 9)
+#define NAU8825_L_DAC_EN            (0x1 << 9)
+#define NAU8825_L_DAC_DIS            (0x0 << 9)
+#define NAU8825_DAC_MASK            (0x3 << 9)
+#define NAU8825_DAC_EN                (0x3 << 9)
+#define NAU8825_DAC_DIS                (0x0 << 9)
+
+#define NAU8825_R_DAC_MASK            (0x1 << 10)
+#define NAU8825_R_DAC_EN            (0x1 << 10)
+#define NAU8825_R_DAC_DIS            (0x0 << 10)
+#define NAU8825_L_DAC_MASK            (0x1 << 9)
+#define NAU8825_L_DAC_EN            (0x1 << 9)
+#define NAU8825_L_DAC_DIS            (0x0 << 9)
+#define NAU8825_ADC_MASK            (0x1 << 8)
+#define NAU8825_ADC_EN                (0x1 << 8)
+#define NAU8825_ADC_DIS                (0x0 << 8)
+#define NAU8825_ADC_CLK_MASK            (0x1 << 7)
+#define NAU8825_ADC_CLK_EN            (0x1 << 7)
+#define NAU8825_ADC_CLK_DIS            (0x0 << 7)
+#define NAU8825_DAC_CLK_MASK            (0x1 << 6)
+#define NAU8825_DAC_CLK_EN            (0x1 << 6)
+#define NAU8825_DAC_CLK_DIS            (0x0 << 6)
+#define NAU8825_IMM_CLK_MASK            (0x1 << 5)
+#define NAU8825_IMM_CLK_EN            (0x1 << 5)
+#define NAU8825_IMM_CLK_DIS            (0x0 << 5)
+#define NAU8825_I2S_CLK_MASK            (0x1 << 4)
+#define NAU8825_I2S_CLK_EN            (0x1 << 4)
+#define NAU8825_I2S_CLK_DIS            (0x0 << 4)
+#define NAU8825_BIST_CLK_MASK            (0x1 << 3)
+#define NAU8825_BIST_CLK_EN            (0x1 << 3)
+#define NAU8825_BIST_CLK_DIS            (0x0 << 3)
+#define NAU8825_OTP_CLK_MASK            (0x1 << 2)
+#define NAU8825_OTP_CLK_EN            (0x1 << 2)
+#define NAU8825_OTP_CLK_DIS            (0x0 << 2)
+#define NAU8825_SAR_CLK_MASK            (0x1 << 1)
+#define NAU8825_SAR_CLK_EN            (0x1 << 1)
+#define NAU8825_SAR_CLK_DIS            (0x0 << 1)
+#define NAU8825_DRC_CLK_MASK            (0x1 << 0)
+#define NAU8825_DRC_CLK_EN            (0x1 << 0)
+#define NAU8825_DRC_CLK_DIS            (0x0 << 0)
+
+/* reg. NAU8825_CLK_DIVIDER (0x03) */
+#define NAU8825_SYSCLK_EN_MASK            (0x1 << 15)
+#define NAU8825_SYSCLK_EN            (0x1 << 15)
+#define NAU8825_SYSCLK_DIS            (0x0 << 15)
+#define NAU8825_CLK_MCLK_SRC_MASK        (0xF << 0)
+
+/* reg. NAU8825_FLL_1 (0x04) */
+#define NAU8825_FLL_RATIO_MASK            (0x7F << 0)
+
+/* reg. NAU8825_FLL_3 (0x06) */
+#define NAU8825_FLL_INTEGER_MASK        (0x3FF << 0)
+
+/* reg. NAU8825_FLL_4 (0x07) */
+#define NAU8825_FLL_REF_DIV_MASK        (0x3 << 10)
+
+/* reg. NAU8825_FLL_5 (0x08) */
+#define NAU8825_FLL_FILTER_SW_MASK        (0x1 << 14)
+
+/* reg. NAU8825_FLL_6 (0x09) */
+#define NAU8825_DCO_EN_MASK            (0x1 << 15)
+#define NAU8825_DCO_EN                (0x1 << 15)
+#define NAU8825_DCO_DIS                (0x0 << 15)
+#define NAU8825_SDM_EN_MASK            (0x1 << 14)
+
+/* reg. NAU8825_HEADSET_CTRL (0x0c) */
+#define NAU8825_RESET_HSD_MASK            (0x1 << 15)
+#define NAU8825_RESET_HSD_EN            (0x1 << 15)
+#define NAU8825_RESET_HSD_DIS            (0x0 << 15)
+#define NAU8825_AUTO_DETECT_MASK        (0x1 << 6)
+#define NAU8825_AUTO_DETECT_EN            (0x1 << 6)
+#define NAU8825_AUTO_DETECT_DIS            (0x0 << 6)
+#define NAU8825_MANUAL_START_MASK        (0x1 << 4)
+#define NAU8825_MANUAL_START_EN            (0x1 << 4)
+#define NAU8825_MANUAL_START_DIS        (0x0 << 4)
+#define NAU8825_ENGND_MASK            (0x3 << 2)
+
+/* reg. NAU8825_JACK_DET_CTRL (0x0d) */
+#define NAU8825_DB_BP_MODE_MASK            (0x1 << 8)
+#define NAU8825_DB_BP_MODE_EN            (0x1 << 8)
+#define NAU8825_DB_BP_MODE_DIS            (0x0 << 8)
+
+/* reg. NAU8825_IRQ_MASK (0x0f) */
+#define NAU8825_IRQ_QE_MASK            (0x1 << 11)
+#define NAU8825_IRQ_QE_EN            (0x1 << 11)
+#define NAU8825_IRQ_QE_DIS            (0x0 << 11)
+#define NAU8825_IRQ_EJECT_MASK            (0x1 << 2)
+#define NAU8825_IRQ_EJECT_EN            (0x1 << 2)
+#define NAU8825_IRQ_EJECT_DIS            (0x0 << 2)
+
+
+/* reg. NAU8825_IRQ_STATUS (0x10) */
+#define NAU8825_HSD_COMPLETE_INT        (0x1 << 10)
+#define NAU8825_EMRG_INT            (0x1 << 9)
+#define NAU8825_RMS_INT                (0x1 << 8)
+#define NAU8825_BTN_RELEASE_INT            (0x1 << 7)
+#define NAU8825_LONG_BTN_INT            (0x1 << 6)
+#define NAU8825_SHORT_BTN_INT            (0x1 << 5)
+#define NAU8825_BTN_INT                (0x7 << 5)
+#define NAU8825_MIC_DET_INT            (0x1 << 4)
+#define NAU8825_JACK_EJCT_INT            (0x3 << 2)
+#define NAU8825_JACK_DET_INT            (0x3 << 0)
+#define NAU8825_JACK_OUT            (0x1 << 2)
+#define NAU8825_JACK_IN                (0x1 << 0)
+#define NAU8825_JACK_INT            (0xF << 0)
+
+/* reg. NAU8825_BTN_STATUS (0x11) */
+#define NAU8825_SHORT_BTN_MASK            (0xFF << 8)
+#define NAU8825_LONG_BTN_MASK            (0xFF << 0)
+#define NAU8825_BTN_0                (0x01 << 0)
+#define NAU8825_BTN_1                (0x01 << 1)
+#define NAU8825_BTN_2                (0x01 << 2)
+#define NAU8825_BTN_3                (0x01 << 3)
+
+/* reg. NAU8825_IRQ_CTRL (0x12) */
+#define NAU8825_HEADSET_INT_MASK        (0x1 << 10)
+#define NAU8825_HEADSET_INT_EN            (0x0 << 10)
+#define NAU8825_HEADSET_INT_DIS            (0x1 << 10)
+#define NAU8825_RMS_INT_MASK            (0x1 << 8)
+#define NAU8825_RMS_INT_EN            (0x0 << 8)
+#define NAU8825_RMS_INT_DIS            (0x1 << 8)
+#define NAU8825_KEYREL_INT_MASK            (0x1 << 7)
+#define NAU8825_KEYREL_INT_EN            (0x0 << 7)
+#define NAU8825_KEYREL_INT_DIS            (0x1 << 7)
+#define NAU8825_LONGKEY_INT_MASK        (0x1 << 6)
+#define NAU8825_LONGKEY_INT_EN            (0x0 << 6)
+#define NAU8825_LONGKEY_INT_DIS            (0x1 << 6)
+#define NAU8825_SHORTKEY_INT_MASK        (0x1 << 5)
+#define NAU8825_SHORTKEY_INT_EN            (0x0 << 5)
+#define NAU8825_SHORTKEY_INT_DIS        (0x1 << 5)
+#define NAU8825_EJECT_INT_MASK            (0x1 << 2)
+#define NAU8825_EJECT_INT_EN            (0x0 << 2)
+#define NAU8825_EJECT_INT_DIS            (0x1 << 2)
+#define NAU8825_JACK_IN_INT_MASK        (0x1 << 0)
+#define NAU8825_JACK_IN_INT_EN            (0x0 << 0)
+#define NAU8825_JACK_IN_INT_DIS            (0x1 << 0)
+
+/* reg. NAU8825_SAR_ADC (0x13) */
+#define NAU8825_SAR_EN_MASK            (0x1 << 12)
+#define NAU8825_SAR_EN                (0x1 << 12)
+#define NAU8825_SAR_DIS                (0x0 << 12)
+#define NAU8825_JKSLV_MASK            (0x1 << 11)
+#define NAU8825_JKSLV_EN            (0x1 << 11)
+#define NAU8825_JKSLV_DIS            (0x0 << 11)
+
+/* reg. NAU8825_I2S_PCM_CTRL_1 (0x1C) */
+#define NAU8825_I2S_TRI_STATE_MASK        (0x1 << 15)
+#define NAU8825_I2S_TRI_STATE_EN        (0x1 << 15)
+#define NAU8825_I2S_TRI_STATE_DIS        (0x0 << 15)
+#define NAU8825_I2S_BP_MASK            (0x1 << 7)
+#define NAU8825_I2S_BP_INV            (0x1 << 7)
+#define NAU8825_I2S_PCMB_MASK            (0x1 << 6)
+#define NAU8825_I2S_PCMB_EN            (0x1 << 6)
+#define NAU8825_I2S_DL_MASK            (0x3 << 2)
+#define NAU8825_I2S_DF_MASK            0x3
+#define NAU8825_I2S_DF_RIGHT            0x0
+#define NAU8825_I2S_DF_LEFT            0x1
+#define NAU8825_I2S_DF_I2S            0x2
+#define NAU8825_I2S_DF_PCM_A            0x3
+#define NAU8825_I2S_DF_PCM_B            0x3
+
+/* reg. NAU8825_I2S_PCM_CTRL_2 (0x1D) */
+#define NAU8825_I2S_MS_MASK            (0x1 << 3)
+#define NAU8825_I2S_MS_MASTER            (0x1 << 3)
+#define NAU8825_I2S_MS_SLAVE            (0x0 << 3)
+
+/* reg. NAU8825_BIQ_CTRL (0x20) */
+#define NAU8825_BIQ_WRT_MASK            (0x1 << 4)
+#define NAU8825_BIQ_WRT_EN            (0x1 << 4)
+#define NAU8825_BIQ_WRT_DIS            (0x0 << 4)
+
+/* reg. NAU8825_ADC_DGAIN_CTRL (0x30) */
+#define NAU8825_ADC_DGAIN_SFT            0
+
+/* reg. NAU8825_DAC_MUTE_CTRL (0x31) */
+#define NAU8825_SOFT_MUTE_MASK            (0x1 << 9)
+#define NAU8825_SOFT_MUTE_EN            (0x1 << 9)
+#define NAU8825_SOFT_MUTE_DIS            (0x0 << 9)
+
+/* reg. NAU8825_HSVOL_CTRL (0x32) */
+#define NAU8825_R_MUTE                (0x1 << 15)
+#define NAU8825_R_MUTE_SFT            15
+#define NAU8825_L_MUTE                (0x1 << 14)
+#define NAU8825_L_MUTE_SFT            14
+#define NAU8825_L_HSVOL_SFT            6
+#define NAU8825_R_HSVOL_SFT            0
+
+/* reg. NAU8825_IMM_MODE_CTRL (0x4C) */
+#define NAU8825_IMM_MODE_EN_MASK        (0x1 << 3)
+#define NAU8825_IMM_MODE_EN            (0x1 << 3)
+#define NAU8825_IMM_MODE_DIS            (0x0 << 3)
+
+/* reg. NAU8825_CLASSG_CTRL (0x50) */
+#define NAU8825_CLASSG_PATH_MASK        (0x3 << 1)
+#define NAU8825_CLASSG_PATH_EN            (0x3 << 1)
+#define NAU8825_CLASSG_PATH_DIS            (0x3 << 0)
+#define NAU8825_CLASSG_LEFT_SHIFT        1
+#define NAU8825_CLASSG_EN_SHIFT            0
+#define NAU8825_CLASSG_EN_MASK            (0x1 << 0)
+#define NAU8825_CLASSG_EN_SHIFT            0
+
+/*#define NAU8825_I2C_DEVICE_ID (0x58) */
+#define NAU8825_GPIO2JD1            (0x1 << 7)
+
+/* reg. NAU8825_BIAS_ADJ (0x66) */
+#define NAU8825_VMID_MASK            (0x1 << 6)
+#define NAU8825_VMID_EN                (0x1 << 6)
+#define NAU8825_VMID_DIS            (0x0 << 6)
+#define NAU8825_VMIDSEL_MASK            (0x3 << 4)
+#define NAU8825_VMIDSEL_125KOHM            (0x2 << 4)
+
+/* reg. NAU8825_ANALOG_CTRL_2 (0x6A) */
+#define NAU8825_VMID_MASK            (0x1 << 6)
+#define NAU8825_VMID_EN                (0x1 << 6)
+#define NAU8825_VMID_DIS            (0x0 << 6)
+
+/* reg. NAU8825_DAC_CTRL (0x73) */
+#define NAU8825_DAC_R_SFT            13
+#define NAU8825_DAC_L_SFT            12
+#define NAU8825_DAC_CLK_R_SFT            9
+#define NAU8825_DAC_CLK_L_SFT            8
+#define NAU8825_DAC_LR_MASK            (0x3 << 12)
+#define NAU8825_DAC_LR_EN            (0x3 << 12)
+#define NAU8825_DAC_LR_DIS            (0x0 << 12)
+#define NAU8825_DAC_CLK_LR_MASK            (0x3 << 8)
+#define NAU8825_DAC_CLK_LR_EN            (0x3 << 8)
+#define NAU8825_DAC_CLK_LR_DIS            (0x0 << 8)
+#define NAU8825_DAC_CLK_DELAY_MASK        (0x7 << 4)
+#define NAU8825_DAC_REF_VOLT_MASK        (0x3 << 2)
+
+/* reg. NAU8825_MIC_BIAS (0x74) */
+#define NAU8825_INT2KB_MSK            (0x1 << 14)
+#define NAU8825_INT2KB_EN            (0x1 << 14)
+#define NAU8825_INT2KB_DIS            (0x0 << 14)
+#define NAU8825_INT2KA_MSK            (0x1 << 12)
+#define NAU8825_INT2KA_EN            (0x1 << 12)
+#define NAU8825_INT2KA_DIS            (0x0 << 12)
+#define NAU8825_MIC_POWERUP_MSK            (0x1 << 8)
+#define NAU8825_MIC_POWERUP_EN            (0x1 << 8)
+#define NAU8825_MIC_POWERUP_DIS            (0x0 << 8)
+#define NAU8825_MIC_BIAS_LVL_MSK        (0x7 << 0)
+
+/* reg. NAU8825_BOOST (0x76) */
+#define NAU8825_G_BIAS_MASK            (0x1 << 12)
+#define NAU8825_G_BIAS_SFT            12
+#define NAU8825_G_BIAS_EN            (0x1 << 12)
+#define NAU8825_G_BIAS_DIS            (0x0 << 12)
+#define NAU8825_BOOST_DRV_MASK            (0x1 << 9)
+#define NAU8825_BOOST_DRV_EN            (0x0 << 9)
+#define NAU8825_BOOST_DRV_DIS            (0x1 << 9)
+
+/* reg. NAU8825_POWER_UP_CTRL (0x7F) */
+#define NAU8825_FEPGA_MASK            (0x1 << 14)
+#define NAU8825_FEPGA_EN            (0x1 << 14)
+#define NAU8825_FEPGA_DIS            (0x0 << 14)
+#define NAU8825_FEPGA_GAIN_MASK            (0x3F << 8)
+#define NAU8825_OUTPUT_DRIVER_MASK        (0x3F << 0)
+#define NAU8825_OUTPUT_DRIVER_EN        (0x3F << 0)
+#define NAU8825_OUTPUT_DRIVER_DIS        (0x0  << 0)
+#define NAU8825_PUP_INTEG_MASK            (0x3  << 4)
+#define NAU8825_PUP_INTEG_ENA            (0x3  << 4)
+#define NAU8825_PUP_INTEG_DIS            (0x0  << 4)
+#define NAU8825_PUP_OUT_MASK            (0x3  << 2)
+#define NAU8825_PUP_OUT_ENA            (0x3  << 2)
+#define NAU8825_PUP_OUT_DIS            (0x0  << 2)
+#define NAU8825_PUP_MAIN_MASK            (0x3  << 0)
+#define NAU8825_PUP_MAIN_ENA            (0x3  << 0)
+#define NAU8825_PUP_MAIN_DIS            (0x0  << 0)
+
+
+/* reg. NAU8825_CHARGE_BUMP_CTRL (0x80) */
+#define NAU8825_PD_DAC_MASK            (0x3 << 8)
+#define NAU8825_PD_DAC_ENA            (0x3 << 8)
+#define NAU8825_PD_DAC_DIS            (0x0 << 8)
+#define NAU8825_CB_CLK_MASK            (0x1 << 7)
+#define NAU8825_CB_CLK_EN            (0x1 << 7)
+#define NAU8825_CB_CLK_DIS            (0x0 << 7)
+#define NAU8825_CB_MASK                (0x1 << 5)
+#define NAU8825_CB_EN                (0x1 << 5)
+#define NAU8825_CB_DIS                (0x0 << 5)
+
+/* reg. NAU8825_GENERAL_STATUS (0x82) */
+#define NAU8825_OUT12_MASK            (0x3 << 10)
+#define NAU8825_OUT2EN_OUT1EN            (0x3 << 10)
+#define NAU8825_OUT2EN_OUT1DIS            (0x2 << 10)
+#define NAU8825_OUT2DIS_OUT1EN            (0x1 << 10)
+#define NAU8825_OUT2DIS_OUT1DIS            (0x0 << 10)
+
+/* Volume Rescale */
+#define NAU8825_VOL_RSCL_RANGE            0x36
+#define NAU8825_ADC_VOL_RSCL_RANGE        0xFF
+
+/* Data format */
+#define NAU8825_I2S_DL_16            (0x0 << 2)
+#define NAU8825_I2S_DL_20            (0x1 << 2)
+#define NAU8825_I2S_DL_24            (0x2 << 2)
+#define NAU8825_I2S_DL_32            (0x3 << 2)
+
+enum {
+    NAU8825_INTERNALCLOCK = 0,
+    NAU8825_MCLK,
+};
+
+struct nau8825_priv {
+    struct regmap *regmap;
+    struct i2c_client *i2c;
+};
+#endif    /* _NAU8825_H */
+
-- 
1.9.3
