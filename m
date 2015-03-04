From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: [PATCH v2] ASoC: Add support for NAU8824 codec to ASoC
Date: Wed, 4 Mar 2015 20:53:38 +0800
Message-ID: <54F70052.1070109@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

>From fe37688e226f83ba477a3c2fbc1e64946cd4ec4e Mon Sep 17 00:00:00 2001
From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Date: Wed, 4 Mar 2015 20:03:21 +0800
Subject: [PATCH v2] ASoC: Add support for NAU8824 codec to ASoC

Signed-off-by: Chih-Chiang Chang <ccchang12@nuvoton.com>
---
 include/sound/nau8824.h    |  22 ++
 sound/soc/codecs/Kconfig   |   5 +
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/nau8824.c | 807 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8824.h | 380 +++++++++++++++++++++
 5 files changed, 1216 insertions(+)
 create mode 100644 include/sound/nau8824.h
 create mode 100644 sound/soc/codecs/nau8824.c
 create mode 100644 sound/soc/codecs/nau8824.h

diff --git a/include/sound/nau8824.h b/include/sound/nau8824.h
new file mode 100644
index 0000000..edb5f08
--- /dev/null
+++ b/include/sound/nau8824.h
@@ -0,0 +1,22 @@
+/*
+ * linux/sound/nau8824.h -- Platform data for NAU8824
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_NAU8824_H
+#define __LINUX_SND_NAU8824_H
+
+struct nau8824_platform_data {
+       unsigned int audio_mclk1;
+       unsigned int gpio_irq;
+       int naudint_irq;
+       int headset_detect;
+       int button_press_detect;
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 064e6c1..862b7bd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -75,6 +75,7 @@ config SND_SOC_ALL_CODECS
        select SND_SOC_MAX9877 if I2C
        select SND_SOC_MC13783 if MFD_MC13XXX
        select SND_SOC_ML26124 if I2C
+       select SND_SOC_NAU8824 if I2C
        select SND_SOC_HDMI_CODEC
        select SND_SOC_PCM1681 if I2C
        select SND_SOC_PCM1792A if SPI_MASTER
@@ -463,6 +464,10 @@ config SND_SOC_MAX98357A
 config SND_SOC_MAX9850
        tristate

+config SND_SOC_NAU8824
+       tristate "Nuvoton NAU8824 CODEC"
+       depends on I2C
+
 config SND_SOC_PCM1681
        tristate "Texas Instruments PCM1681 CODEC"
        depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 69b8666..acb7bda 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -68,6 +68,7 @@ snd-soc-max98357a-objs := max98357a.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
+snd-soc-nau8824-objs := nau8824.o
 snd-soc-hdmi-codec-objs := hdmi.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
@@ -250,6 +251,7 @@ obj-$(CONFIG_SND_SOC_MAX98357A)     += snd-soc-max98357a.o
 obj-$(CONFIG_SND_SOC_MAX9850)  += snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)  += snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)  += snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_NAU8824)  += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)  += snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A) += snd-soc-pcm1792a-codec.o
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
new file mode 100644
index 0000000..8a19b77
--- /dev/null
+++ b/sound/soc/codecs/nau8824.c
@@ -0,0 +1,807 @@
+/*
+ * linux/sound/soc/codecs/nau8824.c
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
+
+#include "nau8824.h"
+
+static int nau8824_hw_params(struct snd_pcm_substream *substream,
+                               struct snd_pcm_hw_params *params,
+                               struct snd_soc_dai *dai);
+static int nau8824_set_dai_fmt(struct snd_soc_dai *codec_dai,
+                               unsigned int fmt);
+static int nau8824_set_bias_level(struct snd_soc_codec *codec,
+                               enum snd_soc_bias_level level);
+static int nau8824_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+                               unsigned int freq, int dir);
+static const DECLARE_TLV_DB_SCALE(out_spk_vol_tlv, 0, 100, 0);
+static const DECLARE_TLV_DB_SCALE(out_hp_vol_tlv, -3000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -12800, 50, 0);
+static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -12800, 50, 0);
+static const DECLARE_TLV_DB_SCALE(adc_left_vol_tlv, -12750, 50, 1);
+static const DECLARE_TLV_DB_SCALE(adc_right_vol_tlv, -12750, 50, 1);
+
+static const struct snd_kcontrol_new nau8824_snd_controls[] = {
+       /* SP Class-D mute control */
+       SOC_DOUBLE("SP Playback Switch", NAU8824_CLASS_D_GAIN1,
+                               NAU8824_CLASS_D_SFT, NAU8824_CLASS_D_SFT, 1, 0),
+       /* SP Class-D driver output stage gain control */
+       SOC_SINGLE_TLV("SP Left Volume", NAU8824_CLASS_D_GAIN2,
+                               NAU8824_CLASS_D_GAIN_L_SFT,
+                               NAU8824_SPK_VOL_RSCL_RANGE, 0, out_spk_vol_tlv),
+       SOC_SINGLE_TLV("SP Right Volume", NAU8824_CLASS_D_GAIN1,
+                               NAU8824_CLASS_D_GAIN_R_SFT,
+                               NAU8824_SPK_VOL_RSCL_RANGE,     0,
+                               out_spk_vol_tlv),
+       /* SP Class-D mute control */
+       SOC_DOUBLE("HP Playback Switch", NAU8824_HP_MUTE, NAU8824_L_MUTE_SFT,
+                               NAU8824_R_MUTE_SFT, 1, 1),
+       SOC_SINGLE_TLV("HP Left Volume", NAU8824_HP_VOL, NAU8824_L_VOL_SFT,
+                               NAU8824_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),
+       SOC_SINGLE_TLV("HP Right Volume", NAU8824_HP_VOL, NAU8824_R_VOL_SFT,
+                               NAU8824_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),
+       /* MIC volume control */
+       SOC_DOUBLE_R_TLV("MIC Volume", NAU8824_ADC_CH0_DGAIN_CTRL,
+                               NAU8824_ADC_CH1_DGAIN_CTRL, 0,
+                               NAU8824_ADC_VOL_RSCL_RANGE,     0, adc_vol_tlv),
+};
+
+static int set_dmic_clk(struct snd_soc_dapm_widget *w,
+                               struct snd_kcontrol *kcontrol, int event)
+{
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+       switch (event) {
+       case SND_SOC_DAPM_PRE_PMU:
+               snd_soc_update_bits(codec, NAU8824_CLK_DIVIDER,
+                               NAU8824_CLK_DMIC_SRC_MASK,
+                               NAU8824_CLK_DMIC_DIV_4);
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
+static const struct snd_kcontrol_new dmic_enable_control =
+       SOC_DAPM_SINGLE_AUTODISABLE("Switch", NAU8824_BIAS_ADJ,
+               NAU8824_DMIC1_SFT, 1, 0);
+
+static const struct snd_kcontrol_new nau8824_rec_l_mix[] = {
+       SOC_DAPM_SINGLE("BST1 Switch", SND_SOC_NOPM, 0, 0, 0),
+};
+
+static const struct snd_kcontrol_new nau8824_rec_r_mix[] = {
+       SOC_DAPM_SINGLE("BST2 Switch", SND_SOC_NOPM, 0, 0, 0),
+};
+
+static const struct snd_kcontrol_new nau8824_spo_mix[] = {
+       SOC_DAPM_SINGLE("SP L Switch", SND_SOC_NOPM, 0, 0, 0),
+       SOC_DAPM_SINGLE("SP R Switch", SND_SOC_NOPM, 0, 0, 0),
+};
+
+static const struct snd_kcontrol_new nau8824_hpo_mix[] = {
+       SOC_DAPM_SINGLE("HP L Switch", NAU8824_HPO_MIXER,
+       NAU8824_M_HPVOL_L_HM_SFT, 1, 0),
+       SOC_DAPM_SINGLE("HP R Switch", NAU8824_HPO_MIXER,
+       NAU8824_M_HPVOL_R_HM_SFT, 1, 0),
+};
+
+static const char * const nau8824_stereo_adc1_src[] = { "ADC", "DMIC" };
+
+static const SOC_ENUM_SINGLE_DECL(nau8824_stereo_adc_l1_enum,
+       NAU8824_ENA_CTRL, NAU8824_DMIC_CH0_SFT, nau8824_stereo_adc1_src);
+
+static const SOC_ENUM_SINGLE_DECL(nau8824_stereo_adc_r1_enum,
+       NAU8824_ENA_CTRL, NAU8824_DMIC_CH1_SFT, nau8824_stereo_adc1_src);
+
+static const struct snd_kcontrol_new nau8824_sto_adc_l1_mux =
+       SOC_DAPM_ENUM("Stereo ADC L1 source", nau8824_stereo_adc_l1_enum);
+
+static const struct snd_kcontrol_new nau8824_sto_adc_r1_mux =
+       SOC_DAPM_ENUM("Stereo ADC R1 source", nau8824_stereo_adc_r1_enum);
+
+static int nau8824_spk_event(struct snd_soc_dapm_widget *w,
+                           struct snd_kcontrol *kcontrol, int event)
+{
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+       switch (event) {
+       case SND_SOC_DAPM_POST_PMU:
+               snd_soc_update_bits(codec, NAU8824_ANALOG_CTRL2,
+                               NAU8824_CLASS_D_CLAMP_MSK,
+                               NAU8824_CLASS_D_CLAMP_BETTER);
+               break;
+       case SND_SOC_DAPM_PRE_PMD:
+               snd_soc_update_bits(codec, NAU8824_CLASS_D_GAIN1,
+                               NAU8824_CLASS_D_MASK, NAU8824_CLASS_D_DIS);
+       default:
+               break;
+       }
+       return 0;
+}
+
+static int nau8824_dac1_event(struct snd_soc_dapm_widget *w,
+                               struct snd_kcontrol *kcontrol, int event)
+{
+       return 0;
+}
+
+static int micbias_power_on_event(struct snd_soc_dapm_widget *w,
+                               struct snd_kcontrol *kcontrol, int event)
+{
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+       if (SND_SOC_DAPM_EVENT_ON(event))
+               snd_soc_update_bits(codec, NAU8824_BOOST, NAU8824_G_BIAS_MASK,
+                               NAU8824_G_BIAS_EN);
+       else if (SND_SOC_DAPM_EVENT_OFF(event))
+               snd_soc_update_bits(codec, NAU8824_BOOST, NAU8824_G_BIAS_MASK,
+                               NAU8824_G_BIAS_DIS);
+       return 0;
+}
+
+static int vmid_power_on_event(struct snd_soc_dapm_widget *w,
+                               struct snd_kcontrol *kcontrol, int event)
+{
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+       if (SND_SOC_DAPM_EVENT_ON(event))
+               snd_soc_update_bits(codec, NAU8824_BIAS_ADJ,
+                               NAU8824_VMID_MASK, NAU8824_VMID_EN);
+       else if (SND_SOC_DAPM_EVENT_OFF(event))
+               snd_soc_update_bits(codec, NAU8824_BIAS_ADJ,
+                               NAU8824_VMID_MASK, NAU8824_VMID_DIS);
+       return 0;
+}
+
+static const struct snd_soc_dapm_widget nau8824_dapm_widgets[] = {
+
+       SND_SOC_DAPM_INPUT("DMIC1"),
+       SND_SOC_DAPM_INPUT("IN1P"),
+       SND_SOC_DAPM_INPUT("IN1N"),
+       SND_SOC_DAPM_INPUT("IN2P"),
+       SND_SOC_DAPM_INPUT("IN2N"),
+       SND_SOC_DAPM_MICBIAS("MIC BIAS", NAU8824_BOOST, NAU8824_G_BIAS_SFT, 0),
+
+       SND_SOC_DAPM_SUPPLY("micbias", SND_SOC_NOPM, 0, 0,
+                               micbias_power_on_event, SND_SOC_DAPM_PRE_PMU
+                               | SND_SOC_DAPM_POST_PMD),
+
+       SND_SOC_DAPM_SUPPLY("vmid", SND_SOC_NOPM, 0, 0, vmid_power_on_event,
+                               SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+       /* DMIC */
+       SND_SOC_DAPM_SWITCH("DMIC Enable", SND_SOC_NOPM, 0, 0,
+                       &dmic_enable_control),
+       SND_SOC_DAPM_PGA("DMIC L1", NAU8824_ENA_CTRL, NAU8824_DMIC_CH0_SFT,
+                               0, NULL, 0),
+       SND_SOC_DAPM_PGA("DMIC R1", NAU8824_ENA_CTRL, NAU8824_DMIC_CH1_SFT,
+                               0, NULL, 0),
+       SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0, set_dmic_clk,
+                               SND_SOC_DAPM_PRE_PMU),
+
+       /* REC Mixer */
+       SND_SOC_DAPM_MIXER("RECMIXL", SND_SOC_NOPM, 0, 0, nau8824_rec_l_mix,
+                               ARRAY_SIZE(nau8824_rec_l_mix)),
+       SND_SOC_DAPM_MIXER("RECMIXR", SND_SOC_NOPM, 0, 0, nau8824_rec_r_mix,
+                               ARRAY_SIZE(nau8824_rec_r_mix)),
+
+       /* ADCs */
+       SND_SOC_DAPM_ADC("ADC L", NULL, SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_ADC("ADC R", NULL, SND_SOC_NOPM, 0, 0),
+
+       /* ADC Mux */
+       SND_SOC_DAPM_MUX("Stereo ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+                               &nau8824_sto_adc_l1_mux),
+       SND_SOC_DAPM_MUX("Stereo ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+                               &nau8824_sto_adc_r1_mux),
+       /* ADC IF1  */
+       SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+       /* Audio Interface */
+       SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+       /* DACs */
+       SND_SOC_DAPM_DAC_E("DAC L1", NULL, NAU8824_DAC_CTRL,
+                               NAU8824_DAC_L_SFT, 0, nau8824_dac1_event,
+                               SND_SOC_DAPM_PRE_PMD),
+       SND_SOC_DAPM_DAC_E("DAC R1", NULL, NAU8824_DAC_CTRL,
+                               NAU8824_DAC_R_SFT, 0, nau8824_dac1_event,
+                               SND_SOC_DAPM_PRE_PMD),
+
+       /* SPO/HPO/LOUT/Mono Mixer */
+       SND_SOC_DAPM_MIXER("SPO MIX", SND_SOC_NOPM, 0, 0, nau8824_spo_mix,
+                               ARRAY_SIZE(nau8824_spo_mix)),
+       SND_SOC_DAPM_MIXER("HPO MIX", SND_SOC_NOPM, 0, 0, nau8824_hpo_mix,
+                               ARRAY_SIZE(nau8824_hpo_mix)),
+
+       SND_SOC_DAPM_PGA_S("HP amp", 1, NAU8824_CLASS_G_CTRL,
+                               NAU8824_CLASS_G_SHIFT, 0, NULL, 0),
+       SND_SOC_DAPM_PGA_S("SPK amp", 1, NAU8824_CLASS_D_GAIN1,
+                               NAU8824_CLASS_D_SFT, 0, nau8824_spk_event,
+                               SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+
+       /* Output Lines */
+       SND_SOC_DAPM_OUTPUT("SPK"),
+       SND_SOC_DAPM_OUTPUT("HPOL"),
+       SND_SOC_DAPM_OUTPUT("HPOR"),
+};
+
+static const struct snd_soc_dapm_route nau8824_dapm_routes[] = {
+
+       {"DMIC L1", NULL, "DMIC1"},
+       {"DMIC R1", NULL, "DMIC1"},
+       {"DMIC Switch", "Switch", "DMIC1"},
+
+       {"BST1", NULL, "IN1P"},
+       {"BST1", NULL, "IN1N"},
+       {"BST2", NULL, "IN2P"},
+       {"BST2", NULL, "IN2N"},
+       {"IN2P", NULL, "micbias"},
+       {"IN2P", NULL, "vmid"},
+
+       {"RECMIXL", "BST1 Switch", "BST1"},
+       {"RECMIXR", "BST2 Switch", "BST2"},
+
+       {"ADC L", NULL, "RECMIXL"},
+       {"ADC R", NULL, "RECMIXR"},
+       {"DMIC L1", NULL, "DMIC CLK"},
+       {"DMIC R1", NULL, "DMIC CLK"},
+
+       {"Stereo ADC L1 Mux", "ADC", "ADC L"},
+       {"Stereo ADC L1 Mux", "DMIC", "DMIC L1"},
+       {"Stereo ADC R1 Mux", "ADC", "ADC R"},
+       {"Stereo ADC R1 Mux", "DMIC", "DMIC R1"},
+       {"AIF1TX", NULL, "IF1 ADC"},
+
+       {"DAC L1", NULL, "AIF1RX"},
+       {"DAC R1", NULL, "AIF1RX"},
+       {"SPO MIX", "SP L Switch", "DAC L1"},
+       {"SPO MIX", "SP R Switch", "DAC R1"},
+       {"SPK amp", NULL, "SPO MIX"},
+       {"SPK", NULL, "SPK amp"},
+
+       {"HPO MIX", "HP L Switch", "DAC L1"},
+       {"HPO MIX", "HP R Switch", "DAC R1"},
+       {"HP amp", NULL, "HPO MIX"},
+       {"HPOL", NULL, "HP amp"},
+       {"HPOR", NULL, "HP amp"},
+};
+
+static int nau8824_hw_params(struct snd_pcm_substream *substream,
+                               struct snd_pcm_hw_params *params,
+                               struct snd_soc_dai *tmp)
+{
+       struct snd_soc_pcm_runtime *rtd = substream->private_data;
+       struct snd_soc_codec *codec = rtd->codec;
+       unsigned int val_len = 0;
+
+       dev_dbg(codec->dev, "%s\n", __func__);
+       dev_dbg(codec->dev, "##- Data length: %d\n", params_format(params));
+
+       switch (params_format(params)) {
+       case SNDRV_PCM_FORMAT_S16_LE:
+               break;
+       case SNDRV_PCM_FORMAT_S20_3LE:
+               val_len |= NAU8824_I2S_DL_20;
+               break;
+       case SNDRV_PCM_FORMAT_S24_LE:
+               val_len |= NAU8824_I2S_DL_24;
+               break;
+       case SNDRV_PCM_FORMAT_S8:
+       case SNDRV_PCM_FORMAT_S32_LE:
+               val_len |= NAU8824_I2S_DL_32;
+               break;
+       default:
+               return -EINVAL;
+       }
+       snd_soc_update_bits(codec, NAU8824_I2S_PCM_CTRL_1, NAU8824_I2S_DL_MASK,
+                               val_len);
+       return 0;
+}
+
+static int nau8824_dac_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+
+       if (mute)
+               snd_soc_update_bits(codec, NAU8824_DAC_MUTE_CTRL,
+                               NAU8824_SOFT_MUTE_MASK, NAU8824_SOFT_MUTE_EN);
+       else
+               snd_soc_update_bits(codec, NAU8824_DAC_MUTE_CTRL,
+                               NAU8824_SOFT_MUTE_MASK, NAU8824_SOFT_MUTE_DIS);
+       return 0;
+}
+
+static int nau8824_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+       unsigned int reg_val = 0, reg_val_2 = 0;
+
+       dev_dbg(codec->dev, "%s: Entered\n", __func__);
+       dev_dbg(codec->dev, "###nau8824_set_dai_fmt %x\n", fmt);
+       dev_dbg(codec->dev, "##+ nau8824_set_dai_fmt (%x)\n", fmt);
+
+       /* set master/slave audio interface */
+       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+       case SND_SOC_DAIFMT_CBM_CFM:
+               reg_val_2 |= NAU8824_I2S_MS_M;
+               break;
+       default:
+               dev_alert(codec->dev, "Invalid DAI master/slave interface\n");
+               return -EINVAL;
+       }
+
+       /* interface format */
+       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+       case SND_SOC_DAIFMT_NB_NF:
+               break;
+       case SND_SOC_DAIFMT_IB_NF:
+               reg_val |= NAU8824_I2S_BP_INV;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+       case SND_SOC_DAIFMT_I2S:
+               reg_val |= NAU8824_I2S_DF_I2S;
+               break;
+       case SND_SOC_DAIFMT_LEFT_J:
+               reg_val |= NAU8824_I2S_DF_LEFT;
+               break;
+       case SND_SOC_DAIFMT_RIGHT_J:
+               reg_val |= NAU8824_I2S_DF_RIGHT;
+               break;
+       case SND_SOC_DAIFMT_DSP_A:
+               reg_val |= NAU8824_I2S_DF_PCM_A;
+               break;
+       case SND_SOC_DAIFMT_DSP_B:
+               reg_val |= NAU8824_I2S_DF_PCM_B;
+               reg_val |= NAU8824_I2S_PCMB_EN;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       snd_soc_update_bits(codec, NAU8824_I2S_PCM_CTRL_1,
+                               NAU8824_I2S_DL_MASK | NAU8824_I2S_DF_MASK
+                               | NAU8824_I2S_BP_MASK | NAU8824_I2S_PCMB_MASK,
+                               reg_val);
+       snd_soc_update_bits(codec, NAU8824_I2S_PCM_CTRL_2, NAU8824_I2S_MS_MASK,
+                               reg_val_2);
+
+       dev_dbg(codec->dev, "##-nau8824_set_dai_fmt Master\n");
+       dev_dbg(codec->dev, "%s: Exiting\n", __func__);
+       return 0;
+}
+
+void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
+{
+       pr_debug("%s sys_clk=%x\n", __func__, sys_clk);
+       switch (sys_clk) {
+       case NAU8824_INTERNALCLOCK:
+               snd_soc_write(codec, 0x03, 0x0853);
+               snd_soc_write(codec, 0x09, 0xE000);
+               snd_soc_write(codec, 0x03, 0x8853);
+               break;
+
+       case NAU8824_MCLK:
+       default:
+               snd_soc_write(codec, 0x03, 0x0853);
+               snd_soc_write(codec, 0x09, 0x6000);
+               snd_soc_write(codec, 0x03, 0x8853);
+               break;
+       }
+}
+
+static int nau8824_set_dai_pll(struct snd_soc_dai *dai,
+               int pll_id, int source, unsigned int freq_in,
+               unsigned int freq_out)
+{
+       struct snd_soc_codec *codec = dai->codec;
+
+       dev_dbg(codec->dev, "In nau8824: dai_set_pll\n");
+       return 0;
+}
+
+static int nau8824_dai_set_sysclk(struct snd_soc_dai *dai,
+               int clk_id, unsigned int freq, int dir)
+{
+       struct snd_soc_codec *codec = dai->codec;
+       int divider = 1;
+
+       switch (clk_id) {
+       case NAU8824_MCLK:
+               set_sys_clk(codec, clk_id);
+               dev_dbg(codec->dev, "%s: input freq = %d divider = %d",
+               __func__, freq, divider);
+               break;
+       case NAU8824_INTERNALCLOCK:
+               set_sys_clk(codec, clk_id);
+               break;
+       default:
+               dev_err(codec->dev, "Wrong clock src\n");
+               return -EINVAL;
+       }
+       return 0;
+}
+
+static int nau8824_set_bias_level(struct snd_soc_codec *codec,
+                               enum snd_soc_bias_level level)
+{
+       switch (level) {
+       case SND_SOC_BIAS_ON:
+               /* All power is driven by DAPM system*/
+               dev_dbg(codec->dev, "###nau8824_set_bias_level BIAS_ON\n");
+               snd_soc_update_bits(codec, NAU8824_BIAS_ADJ,
+                       NAU8824_VMID_MASK, NAU8824_VMID_EN);
+               snd_soc_update_bits(codec, NAU8824_BOOST,
+                               NAU8824_G_BIAS_MASK, NAU8824_G_BIAS_EN);
+               break;
+
+       case SND_SOC_BIAS_PREPARE:
+               dev_dbg(codec->dev, "###nau8824_set_bias_level BIAS_PREPARE\n");
+               break;
+
+       case SND_SOC_BIAS_STANDBY:
+               dev_dbg(codec->dev, "###nau8824_set_bias_level STANDBY\n");
+               break;
+
+       case SND_SOC_BIAS_OFF:
+               dev_dbg(codec->dev, "###nau8824_set_bias_level OFF\n");
+               set_sys_clk(codec, NAU8824_INTERNALCLOCK);
+               snd_soc_update_bits(codec, NAU8824_BIAS_ADJ, NAU8824_VMID_MASK,
+                               NAU8824_VMID_DIS);
+               snd_soc_update_bits(codec, NAU8824_BOOST,
+                               NAU8824_G_BIAS_MASK, NAU8824_G_BIAS_DIS);
+               break;
+       default:
+               break;
+       }
+       codec->dapm.bias_level = level;
+       dev_dbg(codec->dev, "## nau8824_set_bias_level %d\n", level);
+
+       return 0;
+}
+
+static int nau8824_resume(struct snd_soc_codec *codec)
+{
+       dev_dbg(codec->dev, "%s: Entered\n", __func__);
+       nau8824_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+       dev_dbg(codec->dev, "%s: Exiting\n", __func__);
+       return 0;
+}
+
+struct nau8824_init_reg {
+       u8 reg;
+       u16 val;
+};
+
+static const struct reg_default nau8824_reg[] = {
+       {0x0000, 0x0000},
+       {0x0001, 0x48F3},
+       {0x0002, 0xFBA5},
+       {0x0004, 0x0002},
+       {0x0005, 0xDD44},
+       {0x0006, 0x0007},
+       {0x0007, 0x0810},
+       {0x0008, 0xC000},
+       {0x0014, 0x2210},
+       {0x001C, 0x000A},
+       {0x001F, 0x2000},
+       {0x0020, 0x0003},
+       {0x0023, 0x1010},
+       {0x0024, 0x8102},
+       {0x0025, 0x3082},
+       {0x002D, 0x0108},
+       {0x002E, 0x0308},
+       {0x002F, 0x0500},
+       {0x0030, 0x0700},
+       {0x0031, 0x0800},
+       {0x0032, 0x0100},
+       {0x0033, 0x0300},
+       {0x0034, 0x0000},
+       {0x0038, 0x1486},
+       {0x003C, 0x1486},
+       {0x0050, 0x2007},
+       {0x0066, 0x0064},
+       {0x0067, 0x0000},
+       {0x0068, 0x8000},
+       {0x006A, 0x0008},
+       {0x006B, 0x0005},
+       {0x006D, 0x0180},
+       {0x006D, 0x1480},
+       {0x006E, 0x0014},
+       {0x0072, 0x40A0},
+       {0x0073, 0x330C},
+       {0x0074, 0x1106},
+       {0x0076, 0x300F},
+       {0x0077, 0x0010},
+       {0x0078, 0x3C00},
+       {0x0079, 0x0300},
+       {0x007A, 0x0202},
+       {0x007B, 0x0000},
+       {0x007c, 0x1E1E},
+       {0x007F, 0x300F},
+       {0x0080, 0x0020},
+};
+
+static int nau8824_reset(struct nau8824_priv *nau8824)
+{
+       int ret;
+
+       /* Reset the codec by writing to this write-only reset register twice */
+       ret = regmap_write(nau8824->regmap, NAU8824_RESET, 0);
+       if (ret < 0) {
+               dev_err(nau8824->codec->dev,
+                       "Failed to reset codec: %d\n", ret);
+               return ret;
+       }
+
+       ret = regmap_write(nau8824->regmap, NAU8824_RESET, 0);
+       if (ret < 0) {
+               dev_err(nau8824->codec->dev,
+                       "Failed to reset codec: %d\n", ret);
+               return ret;
+       }
+
+       msleep(20);
+       return ret;
+}
+
+static int nau8824_codec_probe(struct snd_soc_codec *codec)
+{
+       int ret = 0;
+       struct nau8824_priv *nau8824;
+
+       nau8824 = snd_soc_codec_get_drvdata(codec);
+       nau8824->codec = codec;
+
+       /* Reset the codec */
+       nau8824_reset(nau8824);
+
+       /* Dynamic Headset detection enabled */
+       snd_soc_update_bits(codec, NAU8824_ENA_CTRL, 0x400, 0x400);
+       snd_soc_update_bits(codec, NAU8824_CLK_EN, 0x0008, 0x0008);
+       snd_soc_update_bits(codec, NAU8824_IRQ_SETTING_1, 0x0300, 0x0100);
+       snd_soc_write(codec, NAU8824_FL_6, 0xE000);
+       snd_soc_write(codec, NAU8824_IRQ_SETTING, 0x1006);
+       snd_soc_write(codec, NAU8824_SAR_ADC, 0x1615);
+       snd_soc_write(codec, VDET_THRESHOLD_1, 0x0414);
+       snd_soc_update_bits(codec, VDET_THRESHOLD_1, 0xFF00, 0x5900);
+       snd_soc_update_bits(codec, NAU8824_BIAS_ADJ, 0x0070, 0x0060);
+
+       /* Program codec to use internal clock */
+       snd_soc_write(codec, NAU8824_CLK_DIVIDER, 0x0853);
+       snd_soc_write(codec, NAU8824_FL_6, 0xE000);
+       snd_soc_write(codec, NAU8824_CLK_DIVIDER, 0x8853);
+       return ret;
+}
+
+static int nau8824_codec_remove(struct snd_soc_codec *codec)
+{
+       nau8824_set_bias_level(codec, SND_SOC_BIAS_OFF);
+       return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_driver_nau8824 = {
+       .probe                  = nau8824_codec_probe,
+       .remove                 = nau8824_codec_remove,
+       .suspend                = NULL,
+       .resume                 = nau8824_resume,
+       .set_bias_level         = nau8824_set_bias_level,
+       .controls               = nau8824_snd_controls,
+       .num_controls           = ARRAY_SIZE(nau8824_snd_controls),
+       .dapm_widgets           = nau8824_dapm_widgets,
+       .num_dapm_widgets       = ARRAY_SIZE(nau8824_dapm_widgets),
+       .dapm_routes            = nau8824_dapm_routes,
+       .num_dapm_routes        = ARRAY_SIZE(nau8824_dapm_routes),
+};
+
+static bool nau8824_readable_register(struct device *dev, unsigned int reg)
+{
+       switch (reg) {
+       case NAU8824_RESET:
+       case NAU8824_ENA_CTRL:
+       case NAU8824_CLK_EN:
+       case NAU8824_CLK_DIVIDER:
+       case NAU8824_FL_1:
+       case NAU8824_FL_2:
+       case NAU8824_FL_3:
+       case NAU8824_FL_4:
+       case NAU8824_FL_5:
+       case NAU8824_FL_6:
+       case NAU8824_IRQ_STATUS:
+       case NAU8824_IRQ_CLEAR:
+       case NAU8824_IRQ_SETTING:
+       case NAU8824_IRQ_SETTING_1:
+       case VDET_THRESHOLD_1:
+       case VDET_THRESHOLD_2:
+       case NAU8824_SAR_ADC:
+       case NAU8824_VDET_COEFFICIENT:
+       case NAU8824_I2S_PCM_CTRL_1:
+       case NAU8824_I2S_PCM_CTRL_2:
+       case NAU8824_ADC_CH0_DGAIN_CTRL:
+       case NAU8824_ADC_CH1_DGAIN_CTRL:
+       case NAU8824_DAC_MUTE_CTRL:
+       case NAU8824_DAC0_DIG_VOL:
+       case NAU8824_DAC1_DIG_VOL:
+       case NAU8824_CLASS_G_CTRL:
+       case NAU8824_SAR_ADC_OUTPUT:
+       case NAU8824_BIAS_ADJ:
+       case NAU8824_ANALOG_CTRL2:
+       case NAU8824_HPO_MIXER:
+       case NAU8824_CLASS_D_GAIN1:
+       case NAU8824_CLASS_D_GAIN2:
+       case NAU8824_DAC_CTRL:
+       case NAU8824_MIC_BIAS:
+       case NAU8824_HP_MUTE:
+       case NAU8824_BOOST:
+       case NAU8824_HP_VOL:
+               return true;
+       default:
+               return false;
+       }
+}
+
+static bool nau8824_volatile_register(struct device *dev, unsigned int reg)
+{
+       switch (reg) {
+       case NAU8824_RESET:
+       case NAU8824_CLK_EN:
+       case NAU8824_CLK_DIVIDER:
+       case NAU8824_FL_1:
+       case NAU8824_FL_2:
+       case NAU8824_FL_3:
+       case NAU8824_FL_4:
+       case NAU8824_FL_5:
+       case NAU8824_FL_6:
+       case NAU8824_IRQ_STATUS:
+       case NAU8824_IRQ_CLEAR:
+       case NAU8824_IRQ_SETTING:
+               return true;
+       default:
+               return false;
+       }
+}
+
+static const struct regmap_config nau8824_regmap = {
+       .reg_bits = 8,
+       .val_bits = 16,
+       .use_single_rw = true,
+
+       .max_register = NAU8824_MAX_REGISTER,
+       .volatile_reg = nau8824_volatile_register,
+       .readable_reg = nau8824_readable_register,
+
+       .cache_type = REGCACHE_RBTREE,
+       .reg_defaults = nau8824_reg,
+       .num_reg_defaults = ARRAY_SIZE(nau8824_reg),
+};
+
+static struct snd_soc_dai_ops nau8824_dai_ops = {
+       .hw_params      = nau8824_hw_params,
+       .set_pll        = nau8824_set_dai_pll,
+       .set_sysclk     = nau8824_dai_set_sysclk,
+       .set_fmt        = nau8824_set_dai_fmt,
+       .digital_mute   = nau8824_dac_mute,
+};
+
+static struct snd_soc_dai_driver nau8824_dai_driver[] = {
+{
+       .name = "nau8824-aif1",
+               .playback = {
+                       .stream_name     = "AIF1 Playback",
+                       .channels_min    = 1,
+                       .channels_max    = 2,
+                       .rates           = NAU8824_RATES,
+                       .formats         = NAU8824_FORMATS,
+               },
+               .capture = {
+                       .stream_name     = "AIF1 Capture",
+                       .channels_min    = 1,
+                       .channels_max    = 2,
+                       .rates           = NAU8824_RATES,
+                       .formats         = NAU8824_FORMATS,
+               },
+       .ops = &nau8824_dai_ops,
+}
+};
+
+static int nau8824_i2c_probe(struct i2c_client *i2c,
+                                const struct i2c_device_id *i2c_id)
+{
+       struct nau8824_platform_data *pdata = dev_get_platdata(&i2c->dev);
+       struct nau8824_priv *nau8824;
+       int ret;
+
+       pr_debug("nau8824_i2c_probe\n");
+
+       nau8824 = devm_kzalloc(&i2c->dev, sizeof(struct nau8824_priv),
+               GFP_KERNEL);
+       if (nau8824 == NULL)
+               return -ENOMEM;
+
+       nau8824->i2c = i2c;
+       i2c_set_clientdata(i2c, nau8824);
+
+       if (pdata)
+               nau8824->pdata = *pdata;
+
+       nau8824->regmap = devm_regmap_init_i2c(i2c, &nau8824_regmap);
+       if (IS_ERR(nau8824->regmap)) {
+               ret = PTR_ERR(nau8824->regmap);
+               dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+               goto err_enable;
+       }
+
+       ret = snd_soc_register_codec(&i2c->dev, &soc_codec_driver_nau8824,
+                               nau8824_dai_driver,
+                               ARRAY_SIZE(nau8824_dai_driver));
+
+err_enable:
+       return ret;
+}
+
+static int nau8824_i2c_remove(struct i2c_client *i2c)
+{
+       snd_soc_unregister_codec(&i2c->dev);
+
+       return 0;
+}
+
+static const struct i2c_device_id nau8824_i2c_id[] = {
+       {"nau8824", 0},
+       {"10508824:00", 0},
+       {"10508824", 0},
+       { }
+};
+
+MODULE_DEVICE_TABLE(i2c, nau8824_i2c_id);
+static struct i2c_driver nau8824_i2c_driver = {
+       .driver = {
+               .name   = "nau8824",
+               .owner  = THIS_MODULE,
+       },
+       .probe          = nau8824_i2c_probe,
+       .remove         = (nau8824_i2c_remove),
+       .id_table       = nau8824_i2c_id,
+};
+module_i2c_driver(nau8824_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU8824 codec driver");
+MODULE_AUTHOR("Nuvoton");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/codecs/nau8824.h b/sound/soc/codecs/nau8824.h
new file mode 100644
index 0000000..b416998
--- /dev/null
+++ b/sound/soc/codecs/nau8824.h
@@ -0,0 +1,380 @@
+/*
+ * linux/sound/soc/codecs/nau8824.h
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ * Author: Meng-Huang Kuo <mhkuo@nuvoton.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _NAU8824_H
+#define _NAU8824_H
+
+#include <sound/nau8824.h>
+
+#define NAU8824_RESET                                          0x00
+#define NAU8824_ENA_CTRL                                       0x01
+#define NAU8824_CLK_EN                                         0x02
+#define NAU8824_CLK_DIVIDER                                    0x03
+#define NAU8824_FL_1                                           0x04
+#define NAU8824_FL_2                                           0x05
+#define NAU8824_FL_3                                           0x06
+#define NAU8824_FL_4                                           0x07
+#define NAU8824_FL_5                                           0x08
+#define NAU8824_FL_6                                           0x09
+#define NAU8824_IRQ_SETTING_1                          0x0F
+#define NAU8824_IRQ_STATUS                                     0x10
+#define NAU8824_IRQ_CLEAR                                      0x11
+#define NAU8824_IRQ_SETTING                                    0x12
+#define NAU8824_SAR_ADC                                                0x13
+#define NAU8824_VDET_COEFFICIENT                       0x14
+#define VDET_THRESHOLD_1                                       0x15
+#define VDET_THRESHOLD_2                                       0x16
+#define NAU8824_I2S_PCM_CTRL_1                         0x1C
+#define NAU8824_I2S_PCM_CTRL_2                         0x1D
+#define NAU8824_ADC_CH0_DGAIN_CTRL                     0x2D
+#define NAU8824_ADC_CH1_DGAIN_CTRL                     0x2E
+#define NAU8824_DAC_MUTE_CTRL                          0x31
+#define NAU8824_DAC0_DIG_VOL                           0x32
+#define NAU8824_DAC1_DIG_VOL                           0x33
+#define NAU8824_CLASS_G_CTRL                           0x50
+#define NAU8824_SAR_ADC_OUTPUT                         0x59
+#define NAU8824_BIAS_ADJ                                       0x66
+#define NAU8824_ANALOG_CTRL2                           0x6A
+#define NAU8824_HPO_MIXER                                      0x6B
+#define NAU8824_CLASS_D_GAIN1                          0x6D
+#define NAU8824_CLASS_D_GAIN2                          0x6E
+#define NAU8824_DAC_CTRL                                       0x73
+#define NAU8824_MIC_BIAS                                       0x74
+#define NAU8824_HP_MUTE                                                0x75
+#define NAU8824_BOOST                                          0x76
+#define        NAU8824_HP_VOL                                          0x7B
+
+#define NAU8824_REG_CNT                                                (0xFF+1)
+#define NAU8824_MAX_REGISTER                           0xFF
+
+/* reg. NAU8824_ENA_CTRL (0x01) */
+#define NAU8824_DMIC_EDGE_CH23_MASK                    (0x01 << 15)
+#define NAU8824_DMIC_EDGE_CH23_SFT                     15
+#define NAU8824_DMIC_EDGE_CH01_MASK                    (0x01 << 14)
+#define NAU8824_DMIC_EDGE_CH01_SFT                     14
+#define NAU8824_ADC_OP_EN_MASK                         (0x01 << 11)
+#define NAU8824_ADC_OP_EN_SFT                          11
+#define NAU8824_ADC_OP_EN                                      (0x01 << 11)
+#define NAU8824_ADC_OP_DIS                                     (0x00 << 11)
+#define NAU8824_INT_SLEEP_MASK                         (0x01 << 10)
+#define NAU8824_INT_SLEEP_SFT                          10
+#define NAU8824_INT_SLEEP_ON                           (0x01 << 10)
+#define NAU8824_INT_SLEEP_OFF                          (0x00 << 10)
+#define NAU8824_DMIC_CH3_MASK                          (0x01 << 9)
+#define NAU8824_DMIC_CH3_SFT                           9
+#define NAU8824_DMIC_CH3_ON                                    (0x01 << 9)
+#define NAU8824_DMIC_CH3_OFF                           (0x00 << 9)
+#define NAU8824_DMIC_CH2_MASK                          (0x01 << 8)
+#define NAU8824_DMIC_CH2_SFT                           8
+#define NAU8824_DMIC_CH2_ON                                    (0x01 << 8)
+#define NAU8824_DMIC_CH2_OFF                           (0x00 << 8)
+#define NAU8824_DMIC_CH1_MASK                          (0x01 << 7)
+#define NAU8824_DMIC_CH1_SFT                           7
+#define NAU8824_DMIC_CH1_ON                                    (0x01 << 7)
+#define NAU8824_DMIC_CH1_OFF                           (0x00 << 7)
+#define NAU8824_DMIC_CH0_MASK                          (0x01 << 6)
+#define NAU8824_DMIC_CH0_SFT                           6
+#define NAU8824_DMIC_CH0_ON                                    (0x01 << 6)
+#define NAU8824_DMIC_CH0_OFF                           (0x00 << 6)
+#define NAU8824_DAC_CH1_EN_MASK                                (0x01 << 5)
+#define NAU8824_DAC_CH1_EN_SFT                         5
+#define NAU8824_DAC_CH1_EN                                     (0x01 << 5)
+#define NAU8824_DAC_CH1_DIS                                    (0x00 << 5)
+#define NAU8824_DAC_CH0_EN_MASK                                (0x01 << 4)
+#define NAU8824_DAC_CH0_EN_SFT                         4
+#define NAU8824_DAC_CH0_EN                                     (0x01 << 4)
+#define NAU8824_DAC_CH0_DIS                                    (0x00 << 4)
+#define NAU8824_ADC_CH3_EN_MASK                                (0x01 << 3)
+#define NAU8824_ADC_CH3_EN_SFT                         3
+#define NAU8824_ADC_CH3_EN                                     (0x01 << 3)
+#define NAU8824_ADC_CH3_DIS                                    (0x00 << 3)
+#define NAU8824_ADC_CH2_EN_MASK                                (0x01 << 2)
+#define NAU8824_ADC_CH2_EN_SFT                         2
+#define NAU8824_ADC_CH2_EN                                     (0x01 << 2)
+#define NAU8824_ADC_CH2_DIS                                    (0x00 << 2)
+#define NAU8824_ADC_CH1_EN_MASK                                (0x01 << 1)
+#define NAU8824_ADC_CH1_EN_SFT                         1
+#define NAU8824_ADC_CH1_EN                                     (0x01 << 1)
+#define NAU8824_ADC_CH1_DIS                                    (0x00 << 1)
+#define NAU8824_ADC_CH0_EN_MASK                                (0x01 << 0)
+#define NAU8824_ADC_CH0_EN_SFT                         0
+#define NAU8824_ADC_CH0_EN                                     (0x01 << 0)
+#define NAU8824_ADC_CH0_DIS                                    (0x00 << 0)
+
+/* reg. NAU8824_CLK_EN (0x02) */
+#define NAU8824_CLK_SAR_EN_MASK                                (0x1 << 3)
+#define NAU8824_CLK_SAR_EN_SFT                         3
+#define NAU8824_CLK_SAR_EN                                     (0x1 << 3)
+#define NAU8824_CLK_SAR_DIS                                    (0x0 << 3)
+
+/* reg. NAU8824_CLK_DIVIDER (0x03) */
+#define NAU8824_SYSCLK_SRC_MASK                                (0x1 << 15)
+#define NAU8824_SYSCLK_SRC_SFT                         15
+#define NAU8824_SYSCLK_SRC_VCO                         (0x1 << 15)
+#define NAU8824_SYSCLK_SRC_MCLK                                (0x0 << 15)
+#define NAU8824_CLK_CODEC_SRC_MASK                     (0x1 << 13)
+#define NAU8824_CLK_CODEC_SRC_SFT                      13
+#define NAU8824_CODEC_SRC_SYSCLK                       (0x1 << 13)
+#define NAU8824_CODEC_SRC_MCLK                         (0x0 << 13)
+#define NAU8824_CLK_DMIC_SRC_MASK                      (0x7 << 10)
+#define NAU8824_CLK_DMIC_SRC_SFT                       10
+#define NAU8824_CLK_DMIC_DIV_4                         (0x2 << 10)
+
+/* reg. NAU8824_IRQ_STATUS (0x10) */
+#define NAU8824_IRQ_KEY_RELEASE                                (0x1 << 5)
+#define NAU8824_IRQ_LONGKEY                                    (0x1 << 4)
+#define NAU8824_IRQ_SHORTKEY                           (0x1 << 3)
+#define NAU8824_IRQ_MIC_INSERTED                       (0x1 << 2)
+#define NAU8824_IRQ_JACK_EJECTED                       (0x1 << 1)
+#define NAU8824_IRQ_JACK_INSERTED                      (0x1 << 0)
+
+/* reg. NAU8824_IRQ_CLEAR (0x11) */
+#define NAU8824_IRQ_KEY_RELEASE_CLR                    (0x1 << 5)
+#define NAU8824_IRQ_LONGKEY_CLR                                (0x1 << 4)
+#define NAU8824_IRQ_SHORTKEY_CLR                       (0x1 << 3)
+#define NAU8824_IRQ_MIC_INSERTED_CLR           (0x1 << 2)
+#define NAU8824_IRQ_JACK_EJECTED_CLR           (0x1 << 1)
+#define NAU8824_IRQ_JACK_INSERTED_CLR          (0x1 << 0)
+
+/* reg NAU8824_SAR_ADC (0x13) */
+#define NAU8824_SAR_EN_MASK                                    (0x1 << 12)
+#define NAU8824_SAR_EN_SFT                                     12
+#define NAU8824_SAR_EN                                         (0x1 << 12)
+#define NAU8824_SAR_DIS                                                (0x0 << 12)
+
+/* reg. NAU8824_I2S_PCM_CTRL_1 (0x1C) */
+#define NAU8824_I2S_BP_MASK                                    (0x1 << 7)
+#define NAU8824_I2S_BP_SFT                                     7
+#define NAU8824_I2S_BP_NOR                                     (0x0 << 7)
+#define NAU8824_I2S_BP_INV                                     (0x1 << 7)
+#define NAU8824_I2S_PCMB_MASK                          (0x1 << 6)
+#define NAU8824_I2S_PCMB_SFT                           6
+#define NAU8824_I2S_PCMB_EN                                    (0x1 << 6)
+#define NAU8824_I2S_PCMB_DIS                           (0x0 << 6)
+#define NAU8824_I2S_DL_MASK                                    (0x3 << 2)
+#define NAU8824_I2S_DL_SFT                                     2
+#define NAU8824_I2S_DF_MASK                                    (0x3)
+#define NAU8824_I2S_DF_SFT                                     0
+#define NAU8824_I2S_DF_RIGHT                           (0x0)
+#define NAU8824_I2S_DF_LEFT                                    (0x1)
+#define NAU8824_I2S_DF_I2S                                     (0x2)
+#define NAU8824_I2S_DF_PCM_A                           (0x3)
+#define NAU8824_I2S_DF_PCM_B                           (0x3)
+
+/* reg. NAU8824_I2S_PCM_CTRL_2 (0x1D) */
+#define NAU8824_I2S_BCLKDIV_MASK                       7
+#define NAU8824_I2S_BCLKDIV_SFT                                0
+
+#define NAU8824_I2S_MS_MASK                                    (0x1 << 3)
+#define NAU8824_I2S_MS_SFT                                     3
+#define NAU8824_I2S_MS_M                                       (0x1 << 3)
+#define NAU8824_I2S_MS_S                                       (0x0 << 3)
+
+/* reg. NAU8824_DAC_MUTE_CTRL (0x31) */
+#define NAU8824_SOFT_MUTE_MASK                         (0x1 << 13)
+#define NAU8824_SOFT_MUTE_SFT                          13
+#define NAU8824_SOFT_MUTE_EN                           (0x1 << 13)
+#define NAU8824_SOFT_MUTE_DIS                          (0x0 << 13)
+
+/* reg NAU8824_DAC0_DIG_VOL (0x32) */
+#define NAU8824_DAC0_GAIN_MASK                         (0x1FF << 0)
+
+/* reg NAU8824_DAC1_DIG_VOL (0x33) */
+#define NAU8824_DAC1_GAIN_MASK                         (0x1FF << 0)
+
+/* reg. NAU8824_CLASS_G_CTRL (0x50) */
+#define NAU8824_CLASS_G_CLK_SRC_MSK                    (0x3 << 14)
+#define NAU8824_CLASS_G_CLK_DIS                                (0x3 << 14)
+#define NAU8824_CLASS_G_CLK_SRC_MCLK           (0x2 << 14)
+#define NAU8824_CLASS_G_CLK_SRC_660K           (0x1 << 14)
+#define NAU8824_CLASS_G_CLK_SRC_2M                     (0x0 << 14)
+#define NAU8824_CLASS_G_TIMER_MSK                      (0x3F << 8)
+#define NAU8824_CLASS_G_TIMER_SFT                      8
+#define NAU8824_CLASS_G_THRSLD_MSK                     (0x3 << 4)
+#define NAU8824_CLASS_G_THRSLD_SFT                     4
+#define NAU8824_CLASS_G_RIGHT_EN_MSK           (0x1 << 2)
+#define NAU8824_CLASS_G_RIGHT_EN                       (0x1 << 2)
+#define        NAU8824_CLASS_G_RIGHT_DIS                       (0x0 << 2)
+#define NAU8824_CLASS_G_LEFT_EN_MSK                    (0x1 << 1)
+#define NAU8824_CLASS_G_LEFT_EN                                (0x1 << 1)
+#define NAU8824_CLASS_G_LEFT_DIS                       (0x0 << 1)
+#define NAU8824_CLASS_G_EN_MSK                         (0x1 << 0)
+#define NAU8824_CLASS_G_SHIFT                          0
+#define NAU8824_CLASS_G_EN                                     (0x1 << 0)
+#define NAU8824_CLASS_G_DIS                                    (0x0 << 0)
+
+/* reg NAU8824_SAR_ADC_OUTPUT (0x59) */
+#define NAU8824_ADC_OUTPUT_MASK                                (0xFF << 0)
+#define NAU8824_ADC_OUTPUT_SFT                         0
+
+/* reg. NAU8824_BIAS_ADJ_2 (0x66) */
+#define NAU8824_VMID_MASK                                      (0x1 << 6)
+#define NAU8824_VMID_SFT                                       6
+#define NAU8824_VMID_EN                                                (0x1 << 6)
+#define NAU8824_VMID_DIS                                       (0x0 << 6)
+#define NAU8824_VMID_OPTION_MASK                       (0x1 << 4)
+#define NAU8824_VMID_OPTION_SFT                                4
+#define NAU8824_DMIC2_MASK                                     (0x1 << 3)
+#define NAU8824_DMIC2_SFT                                      3
+#define NAU8824_DMIC2_EN                                       (0x1 << 3)
+#define NAU8824_DMIC2_DIS                                      (0x0 << 3)
+#define NAU8824_DMIC1_MASK                                     (0x1 << 2)
+#define NAU8824_DMIC1_SFT                                      2
+#define NAU8824_DMIC1_EN                                       (0x1 << 2)
+#define NAU8824_DMIC1_DIS                                      (0x0 << 2)
+
+/* reg. NAU8824_ANALOG_CTRL2 (0x6A) */
+#define NAU8824_CLASS_D_CLAMP_MSK                      (0x1 << 3)
+#define NAU8824_CLASS_D_CLAMP_SFT                      3
+#define NAU8824_CLASS_D_CLAMP_BETTER           (0x1 << 3)
+#define NAU8824_CLASS_D_CLAMP_DEFAULT          (0x0 << 3)
+
+/* reg. NAU8824_HPO_MIXER (0x6B) */
+#define NAU8824_M_HPVOL_R_HM                           (0x1 << 2)
+#define NAU8824_M_HPVOL_R_HM_SFT                       2
+#define NAU8824_M_HPVOL_L_HM                           (0x1 << 0)
+#define NAU8824_M_HPVOL_L_HM_SFT                       0
+
+/* reg. NAU8824_CLASS_D_GAIN1 (0x6D) */
+#define NAU8824_CLASS_D_GAIN_R_MSK                     (0x1F << 8)
+#define NAU8824_CLASS_D_GAIN_R_SFT                     8
+#define NAU8824_CLASS_D_MASK                           (0x1 << 7)
+#define NAU8824_CLASS_D_SFT                                    7
+#define NAU8824_CLASS_D_EN_MSK                         (0x1 << 7)
+#define NAU8824_CLASS_D_EN                                     (0x1 << 7)
+#define NAU8824_CLASS_D_DIS                                    (0x0 << 7)
+
+/* reg. NAU8824_CLASS_D_GAIN2 (0x6E) */
+#define NAU8824_CLASS_D_GAIN_L_MSK                     (0x1F << 0)
+#define NAU8824_CLASS_D_GAIN_L_SFT                     0
+
+/* reg. NAU8824_DAC_CTRL (0x73) */
+#define NAU8824_DAC_R_MASK                                     (0x1 << 13)
+#define NAU8824_DAC_R_SFT                                      13
+#define NAU8824_DAC_R_EN                               (0x1 << 13)
+#define NAU8824_DAC_R_DIS                                      (0x0 << 13)
+#define NAU8824_DAC_L_MASK                                     (0x1 << 12)
+#define NAU8824_DAC_L_SFT                                      12
+#define NAU8824_DAC_L_EN                                       (0x1 << 12)
+#define NAU8824_DAC_L_DIS                                      (0x0 << 12)
+
+/* reg. NAU8824_MIC_BIAS (0x74) */
+#define NAU8824_BIAS_POWER_MASK                                (0x1 << 8)
+#define NAU8824_BIAS_POWER_SFT                         8
+#define NAU8824_BIAS_POWER_ON                          (0x1 << 8)
+#define NAU8824_BIAS_POWER_DOWN                                (0x0 << 8)
+#define NAU8824_BIAS_LEVEL_MASK                                (0x7 << 0)
+#define NAU8824_BIAS_LEVEL_SFT                         0
+#define NAU8824_BIAS_LEVEL_VDDA                                (0x0 << 0)
+
+/* reg. NAU8824_HP_MUTE        (0x75) */
+#define NAU8824_R_MUTE                                         (0x1 << 14)
+#define NAU8824_R_MUTE_SFT                                     14
+#define NAU8824_L_MUTE                                         (0x1 << 6)
+#define NAU8824_L_MUTE_SFT                                     6
+
+/* reg. NAU8824_BOOST (0x76) */
+#define NAU8824_VMID_PRECHARGE_MASK                    (0x1 << 13)
+#define NAU8824_VMID_PRECHARGE_SFT                     13
+#define NAU8824_VMID_PRECHARGE_DIS                     (0x1 << 13)
+#define NAU8824_VMID_PRECHARGE_EN                      (0x0 << 13)
+#define NAU8824_G_BIAS_MASK                                    (0x1 << 12)
+#define NAU8824_G_BIAS_SFT                                     12
+#define NAU8824_G_BIAS_EN                                      (0x1 << 12)
+#define NAU8824_G_BIAS_DIS                                     (0x0 << 12)
+
+/* reg. NAU8824_HP_VOL (0x7B) */
+#define NAU8824_R_VOL_MASK                                     (0x1f << 8)
+#define NAU8824_R_VOL_SFT                                      8
+#define NAU8824_SPK_L_VOL_MASK                         (0x1f)
+#define NAU8824_SPK_R_VOL_MASK                         (0x1f << 8)
+#define NAU8824_L_VOL_MASK                                     (0x1f)
+#define NAU8824_L_VOL_SFT                                      0
+
+/* Volume Rescale */
+#define NAU8824_VOL_RSCL_MAX                           0x1E
+#define NAU8824_VOL_RSCL_RANGE                         0x1E
+#define NAU8824_SPK_VOL_RSCL_MAX                       0x19
+#define NAU8824_SPK_VOL_RSCL_RANGE                     0x19
+#define NAU8824_DAC_VOL_RSCL_RANGE                     0x164
+#define NAU8824_ADC_VOL_RSCL_RANGE                     0x164
+
+/* Data Format */
+#define NAU8824_I2S_DL_32                                      (0x3 << 2)
+#define NAU8824_I2S_DL_24                                      (0x2 << 2)
+#define NAU8824_I2S_DL_20                                      (0x1 << 2)
+#define NAU8824_I2S_DL_16                                      (0x0 << 2)
+
+#define NAU8824_FREQ_25000000                          25000000
+#define NAU8824_PLL_CLKIN_MCLK                         0
+#define NAU8824_BUTTONPRESS_MASK                       0x20
+#define NAU8824_HSPLUG_MASK                                    0x10
+
+enum {
+       NAU8824_INTERNALCLOCK = 0,
+       NAU8824_MCLK,
+};
+
+enum {
+       NAU8824_J_IN_EVENT,
+       NAU8824_J_OUT_EVENT,
+       NAU8824_BP_EVENT,
+       NAU8824_BR_EVENT,
+       NAU8824_UN_EVENT,
+};
+
+enum {
+       S_NAU8824_J_OUT,
+       S_NAU8824_J_IN_TEMP,
+       S_NAU8824_J_IN,
+       S_NAU8824_BUTTON_DECT,
+       S_NAU8824_NO_BUTTON_DECT,
+};
+
+#define NAU8824_RATES  SNDRV_PCM_RATE_8000_192000
+#define NAU8824_FORMATS        (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+                        | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct nau8824_jack_data {
+       struct snd_soc_jack *jack;
+       int report;
+};
+
+struct nau8824_gpio_setup {
+       unsigned int reg;
+       u8 value;
+};
+
+struct nau8824_priv {
+       struct snd_soc_codec *codec;
+       struct nau8824_platform_data pdata;
+       struct regmap *regmap;
+       struct i2c_client *i2c;
+       struct snd_soc_jack *hp_jack;
+       struct snd_soc_jack *mic_jack;
+       struct delayed_work delayed_work;
+
+       struct workqueue_struct *workqueue;
+       struct mutex mutex;
+       unsigned int irq;
+       bool jd_status;
+       bool bp_status;
+       int     jack_type;
+};
+
+int nau8824_device_init(struct nau8824_priv *nau8824);
+void nau8824_device_exit(struct nau8824_priv *nau8824);
+void nau8824_enable_mic_bias(struct snd_soc_codec *codec, int enable);
+int nau8824_query_jack_status(struct snd_soc_codec *codec);
+int nau8824_query_btn_press(struct snd_soc_codec *codec);
+void nau8824_btn_press_intr_enable(struct snd_soc_codec *codec,        int enable);
+
+#endif                         /* _NAU8824_H */
--
1.9.3


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
