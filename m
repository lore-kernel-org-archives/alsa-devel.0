From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: add RT5651 CODEC driver
Date: Wed, 16 Apr 2014 19:20:46 +0800
Message-ID: <1397647246-9389-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 79F0826525F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 13:21:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch adds the Realtek ALC5651 codec driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/rt5651.h    |   21 +
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/rt5651.c | 1898 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5651.h | 2081 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 4006 insertions(+)
 create mode 100644 include/sound/rt5651.h
 create mode 100644 sound/soc/codecs/rt5651.c
 create mode 100644 sound/soc/codecs/rt5651.h

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
new file mode 100644
index 0000000..d35de75
--- /dev/null
+++ b/include/sound/rt5651.h
@@ -0,0 +1,21 @@
+/*
+ * linux/sound/rt286.h -- Platform data for RT286
+ *
+ * Copyright 2013 Realtek Microelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_RT5651_H
+#define __LINUX_SND_RT5651_H
+
+struct rt5651_platform_data {
+	/* IN2 can optionally be differential */
+	bool in2_diff;
+
+	bool dmic_en;
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c7b853f..6bdacaf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -71,6 +71,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM512x_SPI if SPI_MASTER
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_RT5640 if I2C
+	select SND_SOC_RT5651 if I2C
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SI476X if MFD_SI476X_CORE
 	select SND_SOC_SIRF_AUDIO_CODEC
@@ -397,6 +398,9 @@ config SND_SOC_RT5631
 config SND_SOC_RT5640
 	tristate
 
+config SND_SOC_RT5651
+	tristate
+
 #Freescale sgtl5000 codec
 config SND_SOC_SGTL5000
 	tristate "Freescale SGTL5000 CODEC"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index efdb4d0..923b6b5e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,7 @@ snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
+snd-soc-rt5651-objs := rt5651.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-alc5632-objs := alc5632.o
@@ -212,6 +213,7 @@ obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
+obj-$(CONFIG_SND_SOC_RT5651)	+= snd-soc-rt5651.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
new file mode 100644
index 0000000..a157736
--- /dev/null
+++ b/sound/soc/codecs/rt5651.c
@@ -0,0 +1,1898 @@
+/*
+ * rt5651.c  --  RT5651 ALSA SoC audio codec driver
+ *
+ * Copyright 2014 Realtek Semiconductor Corp.
+ * Author: Bard Liao <bardliao@realtek.com>
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
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "rt5651.h"
+
+#define RT5651_DEVICE_ID_VALUE 0x6281
+
+#define RT5651_PR_RANGE_BASE (0xff + 1)
+#define RT5651_PR_SPACING 0x100
+
+#define RT5651_PR_BASE (RT5651_PR_RANGE_BASE + (0 * RT5651_PR_SPACING))
+
+static const struct regmap_range_cfg rt5651_ranges[] = {
+	{ .name = "PR", .range_min = RT5651_PR_BASE,
+	  .range_max = RT5651_PR_BASE + 0xb4,
+	  .selector_reg = RT5651_PRIV_INDEX,
+	  .selector_mask = 0xff,
+	  .selector_shift = 0x0,
+	  .window_start = RT5651_PRIV_DATA,
+	  .window_len = 0x1, },
+};
+
+static struct reg_default init_list[] = {
+	{RT5651_PR_BASE + 0x3d,	0x3e00},
+};
+
+static const struct reg_default rt5651_reg[] = {
+	{ 0x00, 0x0000 },
+	{ 0x02, 0xc8c8 },
+	{ 0x03, 0xc8c8 },
+	{ 0x05, 0x0000 },
+	{ 0x0d, 0x0000 },
+	{ 0x0e, 0x0000 },
+	{ 0x0f, 0x0808 },
+	{ 0x10, 0x0808 },
+	{ 0x19, 0xafaf },
+	{ 0x1a, 0xafaf },
+	{ 0x1b, 0x0c00 },
+	{ 0x1c, 0x2f2f },
+	{ 0x1d, 0x2f2f },
+	{ 0x1e, 0x0000 },
+	{ 0x27, 0x7860 },
+	{ 0x28, 0x7070 },
+	{ 0x29, 0x8080 },
+	{ 0x2a, 0x5252 },
+	{ 0x2b, 0x5454 },
+	{ 0x2f, 0x0000 },
+	{ 0x30, 0x5000 },
+	{ 0x3b, 0x0000 },
+	{ 0x3c, 0x006f },
+	{ 0x3d, 0x0000 },
+	{ 0x3e, 0x006f },
+	{ 0x45, 0x6000 },
+	{ 0x4d, 0x0000 },
+	{ 0x4e, 0x0000 },
+	{ 0x4f, 0x0279 },
+	{ 0x50, 0x0000 },
+	{ 0x51, 0x0000 },
+	{ 0x52, 0x0279 },
+	{ 0x53, 0xf000 },
+	{ 0x61, 0x0000 },
+	{ 0x62, 0x0000 },
+	{ 0x63, 0x00c0 },
+	{ 0x64, 0x0000 },
+	{ 0x65, 0x0000 },
+	{ 0x66, 0x0000 },
+	{ 0x70, 0x8000 },
+	{ 0x71, 0x8000 },
+	{ 0x73, 0x1104 },
+	{ 0x74, 0x0c00 },
+	{ 0x75, 0x1400 },
+	{ 0x77, 0x0c00 },
+	{ 0x78, 0x4000 },
+	{ 0x79, 0x0123 },
+	{ 0x80, 0x0000 },
+	{ 0x81, 0x0000 },
+	{ 0x82, 0x0000 },
+	{ 0x83, 0x0800 },
+	{ 0x84, 0x0000 },
+	{ 0x85, 0x0008 },
+	{ 0x89, 0x0000 },
+	{ 0x8e, 0x0004 },
+	{ 0x8f, 0x1100 },
+	{ 0x90, 0x0000 },
+	{ 0x93, 0x2000 },
+	{ 0x94, 0x0200 },
+	{ 0xb0, 0x2080 },
+	{ 0xb1, 0x0000 },
+	{ 0xb4, 0x2206 },
+	{ 0xb5, 0x1f00 },
+	{ 0xb6, 0x0000 },
+	{ 0xbb, 0x0000 },
+	{ 0xbc, 0x0000 },
+	{ 0xbd, 0x0000 },
+	{ 0xbe, 0x0000 },
+	{ 0xbf, 0x0000 },
+	{ 0xc0, 0x0400 },
+	{ 0xc1, 0x0000 },
+	{ 0xc2, 0x0000 },
+	{ 0xcf, 0x0013 },
+	{ 0xd0, 0x0680 },
+	{ 0xd1, 0x1c17 },
+	{ 0xd3, 0xb320 },
+	{ 0xd9, 0x0809 },
+	{ 0xfa, 0x0010 },
+	{ 0xfe, 0x10ec },
+	{ 0xff, 0x6281 },
+};
+
+static bool rt5651_volatile_register(struct device *dev,  unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rt5651_ranges); i++) {
+		if ((reg >= rt5651_ranges[i].window_start &&
+		     reg <= rt5651_ranges[i].window_start +
+		     rt5651_ranges[i].window_len) ||
+		    (reg >= rt5651_ranges[i].range_min &&
+		     reg <= rt5651_ranges[i].range_max)) {
+			return true;
+		}
+	}
+
+	switch (reg) {
+	case RT5651_RESET:
+	case RT5651_PRIV_DATA:
+	case RT5651_EQ_CTRL1:
+	case RT5651_ALC_1:
+	case RT5651_IRQ_CTRL2:
+	case RT5651_INT_IRQ_ST:
+	case RT5651_PGM_REG_ARR1:
+	case RT5651_PGM_REG_ARR3:
+	case RT5651_VENDOR_ID:
+	case RT5651_DEVICE_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt5651_readable_register(struct device *dev, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rt5651_ranges); i++) {
+		if ((reg >= rt5651_ranges[i].window_start &&
+		     reg <= rt5651_ranges[i].window_start +
+		     rt5651_ranges[i].window_len) ||
+		    (reg >= rt5651_ranges[i].range_min &&
+		     reg <= rt5651_ranges[i].range_max)) {
+			return true;
+		}
+	}
+
+	switch (reg) {
+	case RT5651_RESET:
+	case RT5651_VERSION_ID:
+	case RT5651_VENDOR_ID:
+	case RT5651_DEVICE_ID:
+	case RT5651_HP_VOL:
+	case RT5651_LOUT_CTRL1:
+	case RT5651_LOUT_CTRL2:
+	case RT5651_IN1_IN2:
+	case RT5651_IN3:
+	case RT5651_INL1_INR1_VOL:
+	case RT5651_INL2_INR2_VOL:
+	case RT5651_DAC1_DIG_VOL:
+	case RT5651_DAC2_DIG_VOL:
+	case RT5651_DAC2_CTRL:
+	case RT5651_ADC_DIG_VOL:
+	case RT5651_ADC_DATA:
+	case RT5651_ADC_BST_VOL:
+	case RT5651_STO1_ADC_MIXER:
+	case RT5651_STO2_ADC_MIXER:
+	case RT5651_AD_DA_MIXER:
+	case RT5651_STO_DAC_MIXER:
+	case RT5651_DD_MIXER:
+	case RT5651_DIG_INF_DATA:
+	case RT5651_PDM_CTL:
+	case RT5651_REC_L1_MIXER:
+	case RT5651_REC_L2_MIXER:
+	case RT5651_REC_R1_MIXER:
+	case RT5651_REC_R2_MIXER:
+	case RT5651_HPO_MIXER:
+	case RT5651_OUT_L1_MIXER:
+	case RT5651_OUT_L2_MIXER:
+	case RT5651_OUT_L3_MIXER:
+	case RT5651_OUT_R1_MIXER:
+	case RT5651_OUT_R2_MIXER:
+	case RT5651_OUT_R3_MIXER:
+	case RT5651_LOUT_MIXER:
+	case RT5651_PWR_DIG1:
+	case RT5651_PWR_DIG2:
+	case RT5651_PWR_ANLG1:
+	case RT5651_PWR_ANLG2:
+	case RT5651_PWR_MIXER:
+	case RT5651_PWR_VOL:
+	case RT5651_PRIV_INDEX:
+	case RT5651_PRIV_DATA:
+	case RT5651_I2S1_SDP:
+	case RT5651_I2S2_SDP:
+	case RT5651_ADDA_CLK1:
+	case RT5651_ADDA_CLK2:
+	case RT5651_DMIC:
+	case RT5651_TDM_CTL_1:
+	case RT5651_TDM_CTL_2:
+	case RT5651_TDM_CTL_3:
+	case RT5651_GLB_CLK:
+	case RT5651_PLL_CTRL1:
+	case RT5651_PLL_CTRL2:
+	case RT5651_PLL_MODE_1:
+	case RT5651_PLL_MODE_2:
+	case RT5651_PLL_MODE_3:
+	case RT5651_PLL_MODE_4:
+	case RT5651_PLL_MODE_5:
+	case RT5651_PLL_MODE_6:
+	case RT5651_PLL_MODE_7:
+	case RT5651_DEPOP_M1:
+	case RT5651_DEPOP_M2:
+	case RT5651_DEPOP_M3:
+	case RT5651_CHARGE_PUMP:
+	case RT5651_MICBIAS:
+	case RT5651_A_JD_CTL1:
+	case RT5651_EQ_CTRL1:
+	case RT5651_EQ_CTRL2:
+	case RT5651_ALC_1:
+	case RT5651_ALC_2:
+	case RT5651_ALC_3:
+	case RT5651_JD_CTRL1:
+	case RT5651_JD_CTRL2:
+	case RT5651_IRQ_CTRL1:
+	case RT5651_IRQ_CTRL2:
+	case RT5651_INT_IRQ_ST:
+	case RT5651_GPIO_CTRL1:
+	case RT5651_GPIO_CTRL2:
+	case RT5651_GPIO_CTRL3:
+	case RT5651_PGM_REG_ARR1:
+	case RT5651_PGM_REG_ARR2:
+	case RT5651_PGM_REG_ARR3:
+	case RT5651_PGM_REG_ARR4:
+	case RT5651_PGM_REG_ARR5:
+	case RT5651_SCB_FUNC:
+	case RT5651_SCB_CTRL:
+	case RT5651_BASE_BACK:
+	case RT5651_MP3_PLUS1:
+	case RT5651_MP3_PLUS2:
+	case RT5651_ADJ_HPF_CTRL1:
+	case RT5651_ADJ_HPF_CTRL2:
+	case RT5651_HP_CALIB_AMP_DET:
+	case RT5651_HP_CALIB2:
+	case RT5651_SV_ZCD1:
+	case RT5651_SV_ZCD2:
+	case RT5651_D_MISC:
+	case RT5651_DUMMY2:
+	case RT5651_DUMMY3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
+
+/* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
+static unsigned int bst_tlv[] = {
+	TLV_DB_RANGE_HEAD(7),
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
+	3, 5, TLV_DB_SCALE_ITEM(3000, 500, 0),
+	6, 6, TLV_DB_SCALE_ITEM(4400, 0, 0),
+	7, 7, TLV_DB_SCALE_ITEM(5000, 0, 0),
+	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
+};
+
+/* Interface data select */
+static const char * const rt5651_data_select[] = {
+	"Normal", "Swap", "left copy to right", "right copy to left"};
+
+static SOC_ENUM_SINGLE_DECL(rt5651_if2_dac_enum, RT5651_DIG_INF_DATA,
+				RT5651_IF2_DAC_SEL_SFT, rt5651_data_select);
+
+static SOC_ENUM_SINGLE_DECL(rt5651_if2_adc_enum, RT5651_DIG_INF_DATA,
+				RT5651_IF2_ADC_SEL_SFT, rt5651_data_select);
+
+static const struct snd_kcontrol_new rt5651_snd_controls[] = {
+	/* Headphone Output Volume */
+	SOC_DOUBLE_TLV("HP Playback Volume", RT5651_HP_VOL,
+		RT5651_L_VOL_SFT, RT5651_R_VOL_SFT, 39, 1, out_vol_tlv),
+	/* OUTPUT Control */
+	SOC_DOUBLE_TLV("OUT Playback Volume", RT5651_LOUT_CTRL1,
+		RT5651_L_VOL_SFT, RT5651_R_VOL_SFT, 39, 1, out_vol_tlv),
+
+	/* DAC Digital Volume */
+	SOC_DOUBLE("DAC2 Playback Switch", RT5651_DAC2_CTRL,
+		RT5651_M_DAC_L2_VOL_SFT, RT5651_M_DAC_R2_VOL_SFT, 1, 1),
+	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5651_DAC1_DIG_VOL,
+			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
+			175, 0, dac_vol_tlv),
+	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5651_DAC2_DIG_VOL,
+			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
+			175, 0, dac_vol_tlv),
+	/* IN1/IN2 Control */
+	SOC_SINGLE_TLV("IN1 Boost", RT5651_IN1_IN2,
+		RT5651_BST_SFT1, 8, 0, bst_tlv),
+	SOC_SINGLE_TLV("IN2 Boost", RT5651_IN1_IN2,
+		RT5651_BST_SFT2, 8, 0, bst_tlv),
+	/* INL/INR Volume Control */
+	SOC_DOUBLE_TLV("IN Capture Volume", RT5651_INL1_INR1_VOL,
+			RT5651_INL_VOL_SFT, RT5651_INR_VOL_SFT,
+			31, 1, in_vol_tlv),
+	/* ADC Digital Volume Control */
+	SOC_DOUBLE("ADC Capture Switch", RT5651_ADC_DIG_VOL,
+		RT5651_L_MUTE_SFT, RT5651_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE_TLV("ADC Capture Volume", RT5651_ADC_DIG_VOL,
+			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
+			127, 0, adc_vol_tlv),
+	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5651_ADC_DATA,
+			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
+			127, 0, adc_vol_tlv),
+	/* ADC Boost Volume Control */
+	SOC_DOUBLE_TLV("ADC Boost Gain", RT5651_ADC_BST_VOL,
+			RT5651_ADC_L_BST_SFT, RT5651_ADC_R_BST_SFT,
+			3, 0, adc_bst_tlv),
+
+	/* ASRC */
+	SOC_SINGLE("IF1 ASRC Switch", RT5651_PLL_MODE_1,
+		RT5651_STO1_T_SFT, 1, 0),
+	SOC_SINGLE("IF2 ASRC Switch", RT5651_PLL_MODE_1,
+		RT5651_STO2_T_SFT, 1, 0),
+	SOC_SINGLE("DMIC ASRC Switch", RT5651_PLL_MODE_1,
+		RT5651_DMIC_1_M_SFT, 1, 0),
+
+	SOC_ENUM("ADC IF2 Data Switch", rt5651_if2_adc_enum),
+	SOC_ENUM("DAC IF2 Data Switch", rt5651_if2_dac_enum),
+};
+
+/**
+ * set_dmic_clk - Set parameter of dmic.
+ *
+ * @w: DAPM widget.
+ * @kcontrol: The kcontrol of this widget.
+ * @event: Event id.
+ *
+ * Choose dmic clock between 1MHz and 3MHz.
+ * It is better for clock to approximate 3MHz.
+ */
+static int set_dmic_clk(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	int div[] = {2, 3, 4, 6, 8, 12}, idx = -EINVAL;
+	int i, rate, red, bound, temp;
+
+	rate = rt5651->sysclk;
+	red = 3000000 * 12;
+	for (i = 0; i < ARRAY_SIZE(div); i++) {
+		bound = div[i] * 3000000;
+		if (rate > bound)
+			continue;
+		temp = bound - rate;
+		if (temp < red) {
+			red = temp;
+			idx = i;
+		}
+	}
+	if (idx < 0)
+		dev_err(codec->dev, "Failed to set DMIC clock\n");
+	else
+		snd_soc_update_bits(codec, RT5651_DMIC, RT5651_DMIC_CLK_MASK,
+					idx << RT5651_DMIC_CLK_SFT);
+
+	return idx;
+}
+
+static int is_sysclk_from_pll(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	unsigned int val;
+
+	val = snd_soc_read(source->codec, RT5651_GLB_CLK);
+	val &= RT5651_SCLK_SRC_MASK;
+	if (val == RT5651_SCLK_SRC_PLL1)
+		return 1;
+	else
+		return 0;
+}
+
+/* Digital Mixer */
+static const struct snd_kcontrol_new rt5651_sto1_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5651_STO1_ADC_MIXER,
+			RT5651_M_STO1_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5651_STO1_ADC_MIXER,
+			RT5651_M_STO1_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_sto1_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5651_STO1_ADC_MIXER,
+			RT5651_M_STO1_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5651_STO1_ADC_MIXER,
+			RT5651_M_STO1_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_sto2_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5651_STO2_ADC_MIXER,
+			RT5651_M_STO2_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5651_STO2_ADC_MIXER,
+			RT5651_M_STO2_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_sto2_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5651_STO2_ADC_MIXER,
+			RT5651_M_STO2_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5651_STO2_ADC_MIXER,
+			RT5651_M_STO2_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5651_AD_DA_MIXER,
+			RT5651_M_ADCMIX_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INF1 Switch", RT5651_AD_DA_MIXER,
+			RT5651_M_IF1_DAC_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5651_AD_DA_MIXER,
+			RT5651_M_ADCMIX_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INF1 Switch", RT5651_AD_DA_MIXER,
+			RT5651_M_IF1_DAC_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_sto_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5651_STO_DAC_MIXER,
+			RT5651_M_DAC_L1_MIXL_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5651_STO_DAC_MIXER,
+			RT5651_M_DAC_L2_MIXL_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5651_STO_DAC_MIXER,
+			RT5651_M_DAC_R1_MIXL_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_sto_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5651_STO_DAC_MIXER,
+			RT5651_M_DAC_R1_MIXR_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5651_STO_DAC_MIXER,
+			RT5651_M_DAC_R2_MIXR_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5651_STO_DAC_MIXER,
+			RT5651_M_DAC_L1_MIXR_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_dd_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5651_DD_MIXER,
+			RT5651_M_STO_DD_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5651_DD_MIXER,
+			RT5651_M_STO_DD_L2_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5651_DD_MIXER,
+			RT5651_M_STO_DD_R2_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_dd_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5651_DD_MIXER,
+			RT5651_M_STO_DD_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5651_DD_MIXER,
+			RT5651_M_STO_DD_R2_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5651_DD_MIXER,
+			RT5651_M_STO_DD_L2_R_SFT, 1, 1),
+};
+
+/* Analog Input Mixer */
+static const struct snd_kcontrol_new rt5651_rec_l_mix[] = {
+	SOC_DAPM_SINGLE("INL1 Switch", RT5651_REC_L2_MIXER,
+			RT5651_M_IN1_L_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST3 Switch", RT5651_REC_L2_MIXER,
+			RT5651_M_BST3_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5651_REC_L2_MIXER,
+			RT5651_M_BST2_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5651_REC_L2_MIXER,
+			RT5651_M_BST1_RM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_rec_r_mix[] = {
+	SOC_DAPM_SINGLE("INR1 Switch", RT5651_REC_R2_MIXER,
+			RT5651_M_IN1_R_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST3 Switch", RT5651_REC_R2_MIXER,
+			RT5651_M_BST3_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5651_REC_R2_MIXER,
+			RT5651_M_BST2_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5651_REC_R2_MIXER,
+			RT5651_M_BST1_RM_R_SFT, 1, 1),
+};
+
+/* Analog Output Mixer */
+
+static const struct snd_kcontrol_new rt5651_out_l_mix[] = {
+	SOC_DAPM_SINGLE("BST1 Switch", RT5651_OUT_L3_MIXER,
+			RT5651_M_BST1_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5651_OUT_L3_MIXER,
+			RT5651_M_BST2_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL1 Switch", RT5651_OUT_L3_MIXER,
+			RT5651_M_IN1_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("REC MIXL Switch", RT5651_OUT_L3_MIXER,
+			RT5651_M_RM_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5651_OUT_L3_MIXER,
+			RT5651_M_DAC_L1_OM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_out_r_mix[] = {
+	SOC_DAPM_SINGLE("BST2 Switch", RT5651_OUT_R3_MIXER,
+			RT5651_M_BST2_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5651_OUT_R3_MIXER,
+			RT5651_M_BST1_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR1 Switch", RT5651_OUT_R3_MIXER,
+			RT5651_M_IN1_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("REC MIXR Switch", RT5651_OUT_R3_MIXER,
+			RT5651_M_RM_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5651_OUT_R3_MIXER,
+			RT5651_M_DAC_R1_OM_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_hpo_mix[] = {
+	SOC_DAPM_SINGLE("HPO MIX DAC1 Switch", RT5651_HPO_MIXER,
+			RT5651_M_DAC1_HM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("HPO MIX HPVOL Switch", RT5651_HPO_MIXER,
+			RT5651_M_HPVOL_HM_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5651_lout_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5651_LOUT_MIXER,
+			RT5651_M_DAC_L1_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5651_LOUT_MIXER,
+			RT5651_M_DAC_R1_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUTVOL L Switch", RT5651_LOUT_MIXER,
+			RT5651_M_OV_L_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUTVOL R Switch", RT5651_LOUT_MIXER,
+			RT5651_M_OV_R_LM_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new outvol_l_control =
+	SOC_DAPM_SINGLE("Switch", RT5651_LOUT_CTRL1,
+			RT5651_VOL_L_SFT, 1, 1);
+
+static const struct snd_kcontrol_new outvol_r_control =
+	SOC_DAPM_SINGLE("Switch", RT5651_LOUT_CTRL1,
+			RT5651_VOL_R_SFT, 1, 1);
+
+static const struct snd_kcontrol_new lout_l_mute_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5651_LOUT_CTRL1,
+				    RT5651_L_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new lout_r_mute_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5651_LOUT_CTRL1,
+				    RT5651_R_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new hpovol_l_control =
+	SOC_DAPM_SINGLE("Switch", RT5651_HP_VOL,
+			RT5651_VOL_L_SFT, 1, 1);
+
+static const struct snd_kcontrol_new hpovol_r_control =
+	SOC_DAPM_SINGLE("Switch", RT5651_HP_VOL,
+			RT5651_VOL_R_SFT, 1, 1);
+
+static const struct snd_kcontrol_new hpo_l_mute_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5651_HP_VOL,
+				    RT5651_L_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new hpo_r_mute_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5651_HP_VOL,
+				    RT5651_R_MUTE_SFT, 1, 1);
+
+/* INL/R source */
+static const char * const rt5651_inl_src[] = {"IN2P", "HPOVOLLP"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_inl_enum, RT5651_INL1_INR1_VOL,
+	RT5651_INL_SEL_SFT, rt5651_inl_src);
+
+static const struct snd_kcontrol_new rt5651_inl1_mux =
+	SOC_DAPM_ENUM("INL1 source", rt5651_inl_enum);
+
+static const char * const rt5651_inr1_src[] = {"IN2N", "HPOVOLRP"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_inr1_enum, RT5651_INL1_INR1_VOL,
+	RT5651_INR_SEL_SFT, rt5651_inr1_src);
+
+static const struct snd_kcontrol_new rt5651_inr1_mux =
+	SOC_DAPM_ENUM("INR1 source", rt5651_inr1_enum);
+
+static const char * const rt5651_inl2_src[] = {"IN3P", "OUTVOLLP"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_inl2_enum, RT5651_INL2_INR2_VOL,
+	RT5651_INL_SEL_SFT, rt5651_inl2_src);
+
+static const struct snd_kcontrol_new rt5651_inl2_mux =
+	SOC_DAPM_ENUM("INL2 source", rt5651_inl2_enum);
+
+static const char * const rt5651_inr2_src[] = {"IN3N", "OUTVOLRP"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_inr2_enum, RT5651_INL2_INR2_VOL,
+	RT5651_INR_SEL_SFT, rt5651_inr2_src);
+
+static const struct snd_kcontrol_new rt5651_inr2_mux =
+	SOC_DAPM_ENUM("INR2 source", rt5651_inr2_enum);
+
+
+/* Stereo ADC source */
+static const char * const rt5651_stereo1_adc1_src[] = {"DD MIX", "ADC"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_stereo1_adc1_enum, RT5651_STO1_ADC_MIXER,
+	RT5651_STO1_ADC_1_SRC_SFT, rt5651_stereo1_adc1_src);
+
+static const struct snd_kcontrol_new rt5651_sto1_adc_l1_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC L1 source", rt5651_stereo1_adc1_enum);
+
+static const struct snd_kcontrol_new rt5651_sto1_adc_r1_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC R1 source", rt5651_stereo1_adc1_enum);
+
+static const char * const rt5651_stereo1_adc2_src[] = {"DMIC", "DD MIX"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_stereo1_adc2_enum, RT5651_STO1_ADC_MIXER,
+	RT5651_STO1_ADC_2_SRC_SFT, rt5651_stereo1_adc2_src);
+
+static const struct snd_kcontrol_new rt5651_sto1_adc_l2_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC L2 source", rt5651_stereo1_adc2_enum);
+
+static const struct snd_kcontrol_new rt5651_sto1_adc_r2_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC R2 source", rt5651_stereo1_adc2_enum);
+
+/* Mono ADC source */
+static const char * const rt5651_sto2_adc_l1_src[] = {"DD MIXL", "ADCL"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_sto2_adc_l1_enum, RT5651_STO1_ADC_MIXER,
+	RT5651_STO2_ADC_L1_SRC_SFT, rt5651_sto2_adc_l1_src);
+
+static const struct snd_kcontrol_new rt5651_sto2_adc_l1_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC1 left source", rt5651_sto2_adc_l1_enum);
+
+static const char * const rt5651_sto2_adc_l2_src[] = {"DMIC L", "DD MIXL"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_sto2_adc_l2_enum, RT5651_STO1_ADC_MIXER,
+	RT5651_STO2_ADC_L2_SRC_SFT, rt5651_sto2_adc_l2_src);
+
+static const struct snd_kcontrol_new rt5651_sto2_adc_l2_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC2 left source", rt5651_sto2_adc_l2_enum);
+
+static const char * const rt5651_sto2_adc_r1_src[] = {"DD MIXR", "ADCR"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_sto2_adc_r1_enum, RT5651_STO1_ADC_MIXER,
+	RT5651_STO2_ADC_R1_SRC_SFT, rt5651_sto2_adc_r1_src);
+
+static const struct snd_kcontrol_new rt5651_sto2_adc_r1_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC1 right source", rt5651_sto2_adc_r1_enum);
+
+static const char * const rt5651_sto2_adc_r2_src[] = {"DMIC R", "DD MIXR"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_sto2_adc_r2_enum, RT5651_STO1_ADC_MIXER,
+	RT5651_STO2_ADC_R2_SRC_SFT, rt5651_sto2_adc_r2_src);
+
+static const struct snd_kcontrol_new rt5651_sto2_adc_r2_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC2 right source", rt5651_sto2_adc_r2_enum);
+
+/* DAC2 channel source */
+
+static const char * const rt5651_dac_src[] = {"IF1", "IF2"};
+
+static SOC_ENUM_SINGLE_DECL(rt5651_dac_l2_enum, RT5651_DAC2_CTRL,
+				RT5651_SEL_DAC_L2_SFT, rt5651_dac_src);
+
+static const struct snd_kcontrol_new rt5651_dac_l2_mux =
+	SOC_DAPM_ENUM("DAC2 left channel source", rt5651_dac_l2_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_dac_r2_enum, RT5651_DAC2_CTRL,
+	RT5651_SEL_DAC_R2_SFT, rt5651_dac_src);
+
+static const struct snd_kcontrol_new rt5651_dac_r2_mux =
+	SOC_DAPM_ENUM("DAC2 right channel source", rt5651_dac_r2_enum);
+
+/* IF2_ADC channel source */
+
+static const char * const rt5651_adc_src[] = {"IF1 ADC1", "IF1 ADC2"};
+
+static SOC_ENUM_SINGLE_DECL(rt5651_if2_adc_src_enum, RT5651_DIG_INF_DATA,
+				RT5651_IF2_ADC_SRC_SFT, rt5651_adc_src);
+
+static const struct snd_kcontrol_new rt5651_if2_adc_src_mux =
+	SOC_DAPM_ENUM("IF2 ADC channel source", rt5651_if2_adc_src_enum);
+
+/* PDM select */
+static const char * const rt5651_pdm_sel[] = {"DD MIX", "Stereo DAC MIX"};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_pdm_l_sel_enum, RT5651_PDM_CTL,
+	RT5651_PDM_L_SEL_SFT, rt5651_pdm_sel);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5651_pdm_r_sel_enum, RT5651_PDM_CTL,
+	RT5651_PDM_R_SEL_SFT, rt5651_pdm_sel);
+
+static const struct snd_kcontrol_new rt5651_pdm_l_mux =
+	SOC_DAPM_ENUM("PDM L select", rt5651_pdm_l_sel_enum);
+
+static const struct snd_kcontrol_new rt5651_pdm_r_mux =
+	SOC_DAPM_ENUM("PDM R select", rt5651_pdm_r_sel_enum);
+
+static int rt5651_amp_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* depop parameters */
+		regmap_update_bits(rt5651->regmap, RT5651_PR_BASE +
+			RT5651_CHPUMP_INT_REG1, 0x0700, 0x0200);
+		regmap_update_bits(rt5651->regmap, RT5651_DEPOP_M2,
+			RT5651_DEPOP_MASK, RT5651_DEPOP_MAN);
+		regmap_update_bits(rt5651->regmap, RT5651_DEPOP_M1,
+			RT5651_HP_CP_MASK | RT5651_HP_SG_MASK |
+			RT5651_HP_CB_MASK, RT5651_HP_CP_PU |
+			RT5651_HP_SG_DIS | RT5651_HP_CB_PU);
+		regmap_write(rt5651->regmap, RT5651_PR_BASE +
+				RT5651_HP_DCC_INT1, 0x9f00);
+		/* headphone amp power on */
+		regmap_update_bits(rt5651->regmap, RT5651_PWR_ANLG1,
+			RT5651_PWR_FV1 | RT5651_PWR_FV2, 0);
+		regmap_update_bits(rt5651->regmap, RT5651_PWR_ANLG1,
+			RT5651_PWR_HA,
+			RT5651_PWR_HA);
+		usleep_range(10000, 15000);
+		regmap_update_bits(rt5651->regmap, RT5651_PWR_ANLG1,
+			RT5651_PWR_FV1 | RT5651_PWR_FV2 ,
+			RT5651_PWR_FV1 | RT5651_PWR_FV2);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5651_hp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* headphone unmute sequence */
+		regmap_update_bits(rt5651->regmap, RT5651_DEPOP_M2,
+			RT5651_DEPOP_MASK | RT5651_DIG_DP_MASK,
+			RT5651_DEPOP_AUTO | RT5651_DIG_DP_EN);
+		regmap_update_bits(rt5651->regmap, RT5651_CHARGE_PUMP,
+			RT5651_PM_HP_MASK, RT5651_PM_HP_HV);
+
+		regmap_update_bits(rt5651->regmap, RT5651_DEPOP_M3,
+			RT5651_CP_FQ1_MASK | RT5651_CP_FQ2_MASK |
+			RT5651_CP_FQ3_MASK,
+			(RT5651_CP_FQ_192_KHZ << RT5651_CP_FQ1_SFT) |
+			(RT5651_CP_FQ_12_KHZ << RT5651_CP_FQ2_SFT) |
+			(RT5651_CP_FQ_192_KHZ << RT5651_CP_FQ3_SFT));
+
+		regmap_write(rt5651->regmap, RT5651_PR_BASE +
+			RT5651_MAMP_INT_REG2, 0x1c00);
+		regmap_update_bits(rt5651->regmap, RT5651_DEPOP_M1,
+			RT5651_HP_CP_MASK | RT5651_HP_SG_MASK,
+			RT5651_HP_CP_PD | RT5651_HP_SG_EN);
+		regmap_update_bits(rt5651->regmap, RT5651_PR_BASE +
+			RT5651_CHPUMP_INT_REG1, 0x0700, 0x0400);
+		rt5651->hp_mute = 0;
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		rt5651->hp_mute = 1;
+		usleep_range(70000, 75000);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5651_hp_post_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (!rt5651->hp_mute)
+			usleep_range(80000, 85000);
+
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5651_bst1_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+			RT5651_PWR_BST1_OP2, RT5651_PWR_BST1_OP2);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+			RT5651_PWR_BST1_OP2, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5651_bst2_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+			RT5651_PWR_BST2_OP2, RT5651_PWR_BST2_OP2);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+			RT5651_PWR_BST2_OP2, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5651_bst3_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+			RT5651_PWR_BST3_OP2, RT5651_PWR_BST3_OP2);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+			RT5651_PWR_BST3_OP2, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
+	/* ASRC */
+	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5651_PLL_MODE_2,
+			      15, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5651_PLL_MODE_2,
+			      14, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("STO1 DAC ASRC", 1, RT5651_PLL_MODE_2,
+			      13, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("STO2 DAC ASRC", 1, RT5651_PLL_MODE_2,
+			      12, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC ASRC", 1, RT5651_PLL_MODE_2,
+			      11, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("PLL1", RT5651_PWR_ANLG2,
+			RT5651_PWR_PLL_BIT, 0, NULL, 0),
+	/* Input Side */
+	/* micbias */
+	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
+			RT5651_PWR_LDO_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MICBIAS("micbias1", RT5651_PWR_ANLG2,
+			RT5651_PWR_MB1_BIT, 0),
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_INPUT("MIC3"),
+
+	SND_SOC_DAPM_INPUT("IN1P"),
+	SND_SOC_DAPM_INPUT("IN2P"),
+	SND_SOC_DAPM_INPUT("IN2N"),
+	SND_SOC_DAPM_INPUT("IN3P"),
+	SND_SOC_DAPM_INPUT("DMIC L1"),
+	SND_SOC_DAPM_INPUT("DMIC R1"),
+	SND_SOC_DAPM_SUPPLY("DMIC CLK", RT5651_DMIC, RT5651_DMIC_1_EN_SFT,
+			    0, set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
+	/* Boost */
+	SND_SOC_DAPM_PGA_E("BST1", RT5651_PWR_ANLG2,
+		RT5651_PWR_BST1_BIT, 0, NULL, 0, rt5651_bst1_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("BST2", RT5651_PWR_ANLG2,
+		RT5651_PWR_BST2_BIT, 0, NULL, 0, rt5651_bst2_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("BST3", RT5651_PWR_ANLG2,
+		RT5651_PWR_BST3_BIT, 0, NULL, 0, rt5651_bst3_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	/* Input Volume */
+	SND_SOC_DAPM_PGA("INL1 VOL", RT5651_PWR_VOL,
+			 RT5651_PWR_IN1_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INR1 VOL", RT5651_PWR_VOL,
+			 RT5651_PWR_IN1_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INL2 VOL", RT5651_PWR_VOL,
+			 RT5651_PWR_IN2_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INR2 VOL", RT5651_PWR_VOL,
+			 RT5651_PWR_IN2_R_BIT, 0, NULL, 0),
+	/* IN Mux */
+	SND_SOC_DAPM_MUX("INL1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl1_mux),
+	SND_SOC_DAPM_MUX("INR1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr1_mux),
+	SND_SOC_DAPM_MUX("INL2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl2_mux),
+	SND_SOC_DAPM_MUX("INR2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr2_mux),
+	/* REC Mixer */
+	SND_SOC_DAPM_MIXER("RECMIXL", RT5651_PWR_MIXER, RT5651_PWR_RM_L_BIT, 0,
+			   rt5651_rec_l_mix, ARRAY_SIZE(rt5651_rec_l_mix)),
+	SND_SOC_DAPM_MIXER("RECMIXR", RT5651_PWR_MIXER, RT5651_PWR_RM_R_BIT, 0,
+			   rt5651_rec_r_mix, ARRAY_SIZE(rt5651_rec_r_mix)),
+	/* ADCs */
+	SND_SOC_DAPM_ADC("ADC L", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC R", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("ADC L Power", RT5651_PWR_DIG1,
+			    RT5651_PWR_ADC_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC R Power", RT5651_PWR_DIG1,
+			    RT5651_PWR_ADC_R_BIT, 0, NULL, 0),
+	/* ADC Mux */
+	SND_SOC_DAPM_MUX("Stereo1 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto1_adc_l2_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto1_adc_r2_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto1_adc_l1_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto1_adc_r1_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto2_adc_l2_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto2_adc_l1_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto2_adc_r1_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5651_sto2_adc_r2_mux),
+	/* ADC Mixer */
+	SND_SOC_DAPM_SUPPLY("Stereo1 Filter", RT5651_PWR_DIG2,
+			    RT5651_PWR_ADC_STO1_F_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Stereo2 Filter", RT5651_PWR_DIG2,
+			    RT5651_PWR_ADC_STO2_F_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Stereo1 ADC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5651_sto1_adc_l_mix,
+			   ARRAY_SIZE(rt5651_sto1_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo1 ADC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5651_sto1_adc_r_mix,
+			   ARRAY_SIZE(rt5651_sto1_adc_r_mix)),
+	SND_SOC_DAPM_MIXER("Stereo2 ADC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5651_sto2_adc_l_mix,
+			   ARRAY_SIZE(rt5651_sto2_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo2 ADC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5651_sto2_adc_r_mix,
+			   ARRAY_SIZE(rt5651_sto2_adc_r_mix)),
+
+	/* Digital Interface */
+	SND_SOC_DAPM_SUPPLY("I2S1", RT5651_PWR_DIG1,
+			    RT5651_PWR_I2S1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC1 L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC1 R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC2 L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC2 R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("I2S2", RT5651_PWR_DIG1,
+			    RT5651_PWR_I2S2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MUX("IF2 ADC", SND_SOC_NOPM, 0, 0,
+			 &rt5651_if2_adc_src_mux),
+
+	/* Digital Interface Select */
+
+	SND_SOC_DAPM_MUX("PDM L Mux", RT5651_PDM_CTL,
+			 RT5651_M_PDM_L_SFT, 1, &rt5651_pdm_l_mux),
+	SND_SOC_DAPM_MUX("PDM R Mux", RT5651_PDM_CTL,
+			 RT5651_M_PDM_R_SFT, 1, &rt5651_pdm_r_mux),
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+	/* Audio DSP */
+	SND_SOC_DAPM_PGA("Audio DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Output Side */
+	/* DAC mixer before sound effect  */
+	SND_SOC_DAPM_MIXER("DAC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5651_dac_l_mix, ARRAY_SIZE(rt5651_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("DAC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5651_dac_r_mix, ARRAY_SIZE(rt5651_dac_r_mix)),
+
+	/* DAC2 channel Mux */
+	SND_SOC_DAPM_MUX("DAC L2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_dac_l2_mux),
+	SND_SOC_DAPM_MUX("DAC R2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_dac_r2_mux),
+	SND_SOC_DAPM_PGA("DAC L2 Volume", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DAC R2 Volume", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("Stero1 DAC Power", RT5651_PWR_DIG2,
+			    RT5651_PWR_DAC_STO1_F_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Stero2 DAC Power", RT5651_PWR_DIG2,
+			    RT5651_PWR_DAC_STO2_F_BIT, 0, NULL, 0),
+	/* DAC Mixer */
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5651_sto_dac_l_mix,
+			   ARRAY_SIZE(rt5651_sto_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5651_sto_dac_r_mix,
+			   ARRAY_SIZE(rt5651_sto_dac_r_mix)),
+	SND_SOC_DAPM_MIXER("DD MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5651_dd_dac_l_mix,
+			   ARRAY_SIZE(rt5651_dd_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("DD MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5651_dd_dac_r_mix,
+			   ARRAY_SIZE(rt5651_dd_dac_r_mix)),
+
+	/* DACs */
+	SND_SOC_DAPM_DAC("DAC L1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC R1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("DAC L1 Power", RT5651_PWR_DIG1,
+			    RT5651_PWR_DAC_L1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R1 Power", RT5651_PWR_DIG1,
+			    RT5651_PWR_DAC_R1_BIT, 0, NULL, 0),
+	/* OUT Mixer */
+	SND_SOC_DAPM_MIXER("OUT MIXL", RT5651_PWR_MIXER, RT5651_PWR_OM_L_BIT,
+			   0, rt5651_out_l_mix, ARRAY_SIZE(rt5651_out_l_mix)),
+	SND_SOC_DAPM_MIXER("OUT MIXR", RT5651_PWR_MIXER, RT5651_PWR_OM_R_BIT,
+			   0, rt5651_out_r_mix, ARRAY_SIZE(rt5651_out_r_mix)),
+	/* Ouput Volume */
+	SND_SOC_DAPM_SWITCH("OUTVOL L", RT5651_PWR_VOL,
+			    RT5651_PWR_OV_L_BIT, 0, &outvol_l_control),
+	SND_SOC_DAPM_SWITCH("OUTVOL R", RT5651_PWR_VOL,
+			    RT5651_PWR_OV_R_BIT, 0, &outvol_r_control),
+	SND_SOC_DAPM_SWITCH("HPOVOL L", RT5651_PWR_VOL,
+			    RT5651_PWR_HV_L_BIT, 0, &hpovol_l_control),
+	SND_SOC_DAPM_SWITCH("HPOVOL R", RT5651_PWR_VOL,
+			    RT5651_PWR_HV_R_BIT, 0, &hpovol_r_control),
+	SND_SOC_DAPM_PGA("INL1", RT5651_PWR_VOL,
+			 RT5651_PWR_IN1_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INR1", RT5651_PWR_VOL,
+			 RT5651_PWR_IN1_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INL2", RT5651_PWR_VOL,
+			 RT5651_PWR_IN2_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INR2", RT5651_PWR_VOL,
+			 RT5651_PWR_IN2_R_BIT, 0, NULL, 0),
+	/* HPO/LOUT/Mono Mixer */
+	SND_SOC_DAPM_MIXER("HPOL MIX", SND_SOC_NOPM, 0, 0,
+			   rt5651_hpo_mix, ARRAY_SIZE(rt5651_hpo_mix)),
+	SND_SOC_DAPM_MIXER("HPOR MIX", SND_SOC_NOPM, 0, 0,
+			   rt5651_hpo_mix, ARRAY_SIZE(rt5651_hpo_mix)),
+	SND_SOC_DAPM_SUPPLY("HP L Amp", RT5651_PWR_ANLG1,
+			    RT5651_PWR_HP_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HP R Amp", RT5651_PWR_ANLG1,
+			    RT5651_PWR_HP_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("LOUT MIX", RT5651_PWR_ANLG1, RT5651_PWR_LM_BIT, 0,
+			   rt5651_lout_mix, ARRAY_SIZE(rt5651_lout_mix)),
+
+	SND_SOC_DAPM_SUPPLY("Amp Power", RT5651_PWR_ANLG1,
+			    RT5651_PWR_HA_BIT, 0, rt5651_amp_power_event,
+			    SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0, rt5651_hp_event,
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SWITCH("HPO L Playback", SND_SOC_NOPM, 0, 0,
+			    &hpo_l_mute_control),
+	SND_SOC_DAPM_SWITCH("HPO R Playback", SND_SOC_NOPM, 0, 0,
+			    &hpo_r_mute_control),
+	SND_SOC_DAPM_SWITCH("LOUT L Playback", SND_SOC_NOPM, 0, 0,
+			    &lout_l_mute_control),
+	SND_SOC_DAPM_SWITCH("LOUT R Playback", SND_SOC_NOPM, 0, 0,
+			    &lout_r_mute_control),
+	SND_SOC_DAPM_POST("HP Post", rt5651_hp_post_event),
+
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+	SND_SOC_DAPM_OUTPUT("LOUTL"),
+	SND_SOC_DAPM_OUTPUT("LOUTR"),
+	SND_SOC_DAPM_OUTPUT("PDML"),
+	SND_SOC_DAPM_OUTPUT("PDMR"),
+};
+
+static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
+	{"Stero1 DAC Power", NULL, "STO1 DAC ASRC"},
+	{"Stero2 DAC Power", NULL, "STO2 DAC ASRC"},
+	{"I2S1", NULL, "I2S1 ASRC"},
+	{"I2S2", NULL, "I2S2 ASRC"},
+
+	{"IN1P", NULL, "LDO"},
+	{"IN2P", NULL, "LDO"},
+	{"IN3P", NULL, "LDO"},
+
+	{"IN1P", NULL, "MIC1"},
+	{"IN2P", NULL, "MIC2"},
+	{"IN2N", NULL, "MIC2"},
+	{"IN3P", NULL, "MIC3"},
+
+	{"BST1", NULL, "IN1P"},
+	{"BST2", NULL, "IN2P"},
+	{"BST2", NULL, "IN2N"},
+	{"BST3", NULL, "IN3P"},
+
+	{"INL1 VOL", NULL, "IN2P"},
+	{"INR1 VOL", NULL, "IN2N"},
+
+	{"RECMIXL", "INL1 Switch", "INL1 VOL"},
+	{"RECMIXL", "BST3 Switch", "BST3"},
+	{"RECMIXL", "BST2 Switch", "BST2"},
+	{"RECMIXL", "BST1 Switch", "BST1"},
+
+	{"RECMIXR", "INR1 Switch", "INR1 VOL"},
+	{"RECMIXR", "BST3 Switch", "BST3"},
+	{"RECMIXR", "BST2 Switch", "BST2"},
+	{"RECMIXR", "BST1 Switch", "BST1"},
+
+	{"ADC L", NULL, "RECMIXL"},
+	{"ADC L", NULL, "ADC L Power"},
+	{"ADC R", NULL, "RECMIXR"},
+	{"ADC R", NULL, "ADC R Power"},
+
+	{"DMIC L1", NULL, "DMIC CLK"},
+	{"DMIC R1", NULL, "DMIC CLK"},
+
+	{"Stereo1 ADC L2 Mux", "DMIC", "DMIC L1"},
+	{"Stereo1 ADC L2 Mux", "DD MIX", "DD MIXL"},
+	{"Stereo1 ADC L1 Mux", "ADC", "ADC L"},
+	{"Stereo1 ADC L1 Mux", "DD MIX", "DD MIXL"},
+
+	{"Stereo1 ADC R1 Mux", "ADC", "ADC R"},
+	{"Stereo1 ADC R1 Mux", "DD MIX", "DD MIXR"},
+	{"Stereo1 ADC R2 Mux", "DMIC", "DMIC R1"},
+	{"Stereo1 ADC R2 Mux", "DD MIX", "DD MIXR"},
+
+	{"Stereo2 ADC L2 Mux", "DMIC L", "DMIC L1"},
+	{"Stereo2 ADC L2 Mux", "DD MIXL", "DD MIXL"},
+	{"Stereo2 ADC L1 Mux", "DD MIXL", "DD MIXL"},
+	{"Stereo2 ADC L1 Mux", "ADCL", "ADC L"},
+
+	{"Stereo2 ADC R1 Mux", "DD MIXR", "DD MIXR"},
+	{"Stereo2 ADC R1 Mux", "ADCR", "ADC R"},
+	{"Stereo2 ADC R2 Mux", "DMIC R", "DMIC R1"},
+	{"Stereo2 ADC R2 Mux", "DD MIXR", "DD MIXR"},
+
+	{"Stereo1 ADC MIXL", "ADC1 Switch", "Stereo1 ADC L1 Mux"},
+	{"Stereo1 ADC MIXL", "ADC2 Switch", "Stereo1 ADC L2 Mux"},
+	{"Stereo1 ADC MIXL", NULL, "Stereo1 Filter"},
+	{"Stereo1 Filter", NULL, "PLL1", is_sysclk_from_pll},
+	{"Stereo1 Filter", NULL, "ADC ASRC"},
+
+	{"Stereo1 ADC MIXR", "ADC1 Switch", "Stereo1 ADC R1 Mux"},
+	{"Stereo1 ADC MIXR", "ADC2 Switch", "Stereo1 ADC R2 Mux"},
+	{"Stereo1 ADC MIXR", NULL, "Stereo1 Filter"},
+
+	{"Stereo2 ADC MIXL", "ADC1 Switch", "Stereo2 ADC L1 Mux"},
+	{"Stereo2 ADC MIXL", "ADC2 Switch", "Stereo2 ADC L2 Mux"},
+	{"Stereo2 ADC MIXL", NULL, "Stereo2 Filter"},
+	{"Stereo2 Filter", NULL, "PLL1", is_sysclk_from_pll},
+	{"Stereo2 Filter", NULL, "ADC ASRC"},
+
+	{"Stereo2 ADC MIXR", "ADC1 Switch", "Stereo2 ADC R1 Mux"},
+	{"Stereo2 ADC MIXR", "ADC2 Switch", "Stereo2 ADC R2 Mux"},
+	{"Stereo2 ADC MIXR", NULL, "Stereo2 Filter"},
+
+	{"IF1 ADC2", NULL, "Stereo2 ADC MIXL"},
+	{"IF1 ADC2", NULL, "Stereo2 ADC MIXR"},
+	{"IF1 ADC1", NULL, "Stereo1 ADC MIXL"},
+	{"IF1 ADC1", NULL, "Stereo1 ADC MIXR"},
+
+	{"IF1 ADC1", NULL, "I2S1"},
+
+	{"IF2 ADC", "IF1 ADC1", "IF1 ADC1"},
+	{"IF2 ADC", "IF1 ADC2", "IF1 ADC2"},
+	{"IF2 ADC", NULL, "I2S2"},
+
+	{"AIF1TX", NULL, "IF1 ADC1"},
+	{"AIF1TX", NULL, "IF1 ADC2"},
+	{"AIF2TX", NULL, "IF2 ADC"},
+
+	{"IF1 DAC", NULL, "AIF1RX"},
+	{"IF1 DAC", NULL, "I2S1"},
+	{"IF2 DAC", NULL, "AIF2RX"},
+	{"IF2 DAC", NULL, "I2S2"},
+
+	{"IF1 DAC1 L", NULL, "IF1 DAC"},
+	{"IF1 DAC1 R", NULL, "IF1 DAC"},
+	{"IF1 DAC2 L", NULL, "IF1 DAC"},
+	{"IF1 DAC2 R", NULL, "IF1 DAC"},
+	{"IF2 DAC L", NULL, "IF2 DAC"},
+	{"IF2 DAC R", NULL, "IF2 DAC"},
+
+	{"DAC MIXL", "Stereo ADC Switch", "Stereo1 ADC MIXL"},
+	{"DAC MIXL", "INF1 Switch", "IF1 DAC1 L"},
+	{"DAC MIXR", "Stereo ADC Switch", "Stereo1 ADC MIXR"},
+	{"DAC MIXR", "INF1 Switch", "IF1 DAC1 R"},
+
+	{"Audio DSP", NULL, "DAC MIXL"},
+	{"Audio DSP", NULL, "DAC MIXR"},
+
+	{"DAC L2 Mux", "IF1", "IF1 DAC2 L"},
+	{"DAC L2 Mux", "IF2", "IF2 DAC L"},
+	{"DAC L2 Volume", NULL, "DAC L2 Mux"},
+
+	{"DAC R2 Mux", "IF1", "IF1 DAC2 R"},
+	{"DAC R2 Mux", "IF2", "IF2 DAC R"},
+	{"DAC R2 Volume", NULL, "DAC R2 Mux"},
+
+	{"Stereo DAC MIXL", "DAC L1 Switch", "Audio DSP"},
+	{"Stereo DAC MIXL", "DAC L2 Switch", "DAC L2 Volume"},
+	{"Stereo DAC MIXL", "DAC R1 Switch", "DAC MIXR"},
+	{"Stereo DAC MIXL", NULL, "Stero1 DAC Power"},
+	{"Stereo DAC MIXL", NULL, "Stero2 DAC Power"},
+	{"Stereo DAC MIXR", "DAC R1 Switch", "Audio DSP"},
+	{"Stereo DAC MIXR", "DAC R2 Switch", "DAC R2 Volume"},
+	{"Stereo DAC MIXR", "DAC L1 Switch", "DAC MIXL"},
+	{"Stereo DAC MIXR", NULL, "Stero1 DAC Power"},
+	{"Stereo DAC MIXR", NULL, "Stero2 DAC Power"},
+
+	{"PDM L Mux", "Stereo DAC MIX", "Stereo DAC MIXL"},
+	{"PDM L Mux", "DD MIX", "DAC MIXL"},
+	{"PDM R Mux", "Stereo DAC MIX", "Stereo DAC MIXR"},
+	{"PDM R Mux", "DD MIX", "DAC MIXR"},
+
+	{"DAC L1", NULL, "Stereo DAC MIXL"},
+	{"DAC L1", NULL, "PLL1", is_sysclk_from_pll},
+	{"DAC L1", NULL, "DAC L1 Power"},
+	{"DAC R1", NULL, "Stereo DAC MIXR"},
+	{"DAC R1", NULL, "PLL1", is_sysclk_from_pll},
+	{"DAC R1", NULL, "DAC R1 Power"},
+
+	{"DD MIXL", "DAC L1 Switch", "DAC MIXL"},
+	{"DD MIXL", "DAC L2 Switch", "DAC L2 Volume"},
+	{"DD MIXL", "DAC R2 Switch", "DAC R2 Volume"},
+	{"DD MIXL", NULL, "Stero2 DAC Power"},
+
+	{"DD MIXR", "DAC R1 Switch", "DAC MIXR"},
+	{"DD MIXR", "DAC R2 Switch", "DAC R2 Volume"},
+	{"DD MIXR", "DAC L2 Switch", "DAC L2 Volume"},
+	{"DD MIXR", NULL, "Stero2 DAC Power"},
+
+	{"OUT MIXL", "BST1 Switch", "BST1"},
+	{"OUT MIXL", "BST2 Switch", "BST2"},
+	{"OUT MIXL", "INL1 Switch", "INL1 VOL"},
+	{"OUT MIXL", "REC MIXL Switch", "RECMIXL"},
+	{"OUT MIXL", "DAC L1 Switch", "DAC L1"},
+
+	{"OUT MIXR", "BST2 Switch", "BST2"},
+	{"OUT MIXR", "BST1 Switch", "BST1"},
+	{"OUT MIXR", "INR1 Switch", "INR1 VOL"},
+	{"OUT MIXR", "REC MIXR Switch", "RECMIXR"},
+	{"OUT MIXR", "DAC R1 Switch", "DAC R1"},
+
+	{"HPOVOL L", "Switch", "OUT MIXL"},
+	{"HPOVOL R", "Switch", "OUT MIXR"},
+	{"OUTVOL L", "Switch", "OUT MIXL"},
+	{"OUTVOL R", "Switch", "OUT MIXR"},
+
+	{"HPOL MIX", "HPO MIX DAC1 Switch", "DAC L1"},
+	{"HPOL MIX", "HPO MIX HPVOL Switch", "HPOVOL L"},
+	{"HPOL MIX", NULL, "HP L Amp"},
+	{"HPOR MIX", "HPO MIX DAC1 Switch", "DAC R1"},
+	{"HPOR MIX", "HPO MIX HPVOL Switch", "HPOVOL R"},
+	{"HPOR MIX", NULL, "HP R Amp"},
+
+	{"LOUT MIX", "DAC L1 Switch", "DAC L1"},
+	{"LOUT MIX", "DAC R1 Switch", "DAC R1"},
+	{"LOUT MIX", "OUTVOL L Switch", "OUTVOL L"},
+	{"LOUT MIX", "OUTVOL R Switch", "OUTVOL R"},
+
+	{"HP Amp", NULL, "HPOL MIX"},
+	{"HP Amp", NULL, "HPOR MIX"},
+	{"HP Amp", NULL, "Amp Power"},
+	{"HPO L Playback", "Switch", "HP Amp"},
+	{"HPO R Playback", "Switch", "HP Amp"},
+	{"HPOL", NULL, "HPO L Playback"},
+	{"HPOR", NULL, "HPO R Playback"},
+
+	{"LOUT L Playback", "Switch", "LOUT MIX"},
+	{"LOUT R Playback", "Switch", "LOUT MIX"},
+	{"LOUTL", NULL, "LOUT L Playback"},
+	{"LOUTL", NULL, "Amp Power"},
+	{"LOUTR", NULL, "LOUT R Playback"},
+	{"LOUTR", NULL, "Amp Power"},
+
+	{"PDML", NULL, "PDM L Mux"},
+	{"PDMR", NULL, "PDM R Mux"},
+};
+
+static int get_clk_info(int sclk, int rate)
+{
+	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
+
+	if (sclk <= 0 || rate <= 0)
+		return -EINVAL;
+
+	rate = rate << 8;
+	for (i = 0; i < ARRAY_SIZE(pd); i++)
+		if (sclk == rate * pd[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static int rt5651_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val_len = 0, val_clk, mask_clk;
+	int pre_div, bclk_ms, frame_size;
+
+	rt5651->lrck[dai->id] = params_rate(params);
+	pre_div = get_clk_info(rt5651->sysclk, rt5651->lrck[dai->id]);
+
+	if (pre_div < 0) {
+		dev_err(codec->dev, "Unsupported clock setting\n");
+		return -EINVAL;
+	}
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0) {
+		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
+		return -EINVAL;
+	}
+	bclk_ms = frame_size > 32 ? 1 : 0;
+	rt5651->bclk[dai->id] = rt5651->lrck[dai->id] * (32 << bclk_ms);
+
+	dev_dbg(dai->dev, "bclk is %dHz and lrck is %dHz\n",
+		rt5651->bclk[dai->id], rt5651->lrck[dai->id]);
+	dev_dbg(dai->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
+				bclk_ms, pre_div, dai->id);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		val_len |= RT5651_I2S_DL_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		val_len |= RT5651_I2S_DL_24;
+		break;
+	case SNDRV_PCM_FORMAT_S8:
+		val_len |= RT5651_I2S_DL_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dai->id) {
+	case RT5651_AIF1:
+		mask_clk = RT5651_I2S_PD1_MASK;
+		val_clk = pre_div << RT5651_I2S_PD1_SFT;
+		snd_soc_update_bits(codec, RT5651_I2S1_SDP,
+			RT5651_I2S_DL_MASK, val_len);
+		snd_soc_update_bits(codec, RT5651_ADDA_CLK1, mask_clk, val_clk);
+		break;
+	case RT5651_AIF2:
+		mask_clk = RT5651_I2S_BCLK_MS2_MASK | RT5651_I2S_PD2_MASK;
+		val_clk = pre_div << RT5651_I2S_PD2_SFT;
+		snd_soc_update_bits(codec, RT5651_I2S2_SDP,
+			RT5651_I2S_DL_MASK, val_len);
+		snd_soc_update_bits(codec, RT5651_ADDA_CLK1, mask_clk, val_clk);
+		break;
+	default:
+		dev_err(codec->dev, "Wrong dai->id: %d\n", dai->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rt5651_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		rt5651->master[dai->id] = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		reg_val |= RT5651_I2S_MS_S;
+		rt5651->master[dai->id] = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg_val |= RT5651_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg_val |= RT5651_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		reg_val |= RT5651_I2S_DF_PCM_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		reg_val |= RT5651_I2S_DF_PCM_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dai->id) {
+	case RT5651_AIF1:
+		snd_soc_update_bits(codec, RT5651_I2S1_SDP,
+			RT5651_I2S_MS_MASK | RT5651_I2S_BP_MASK |
+			RT5651_I2S_DF_MASK, reg_val);
+		break;
+	case RT5651_AIF2:
+		snd_soc_update_bits(codec, RT5651_I2S2_SDP,
+			RT5651_I2S_MS_MASK | RT5651_I2S_BP_MASK |
+			RT5651_I2S_DF_MASK, reg_val);
+		break;
+	default:
+		dev_err(codec->dev, "Wrong dai->id: %d\n", dai->id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	if (freq == rt5651->sysclk && clk_id == rt5651->sysclk_src)
+		return 0;
+
+	switch (clk_id) {
+	case RT5651_SCLK_S_MCLK:
+		reg_val |= RT5651_SCLK_SRC_MCLK;
+		break;
+	case RT5651_SCLK_S_PLL1:
+		reg_val |= RT5651_SCLK_SRC_PLL1;
+		break;
+	case RT5651_SCLK_S_RCCLK:
+		reg_val |= RT5651_SCLK_SRC_RCCLK;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, RT5651_GLB_CLK,
+		RT5651_SCLK_SRC_MASK, reg_val);
+	rt5651->sysclk = freq;
+	rt5651->sysclk_src = clk_id;
+
+	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+
+	return 0;
+}
+
+/**
+ * rt5651_pll_calc - Calcualte PLL M/N/K code.
+ * @freq_in: external clock provided to codec.
+ * @freq_out: target clock which codec works on.
+ * @pll_code: Pointer to structure with M, N, K and bypass flag.
+ *
+ * Calcualte M/N/K code to configure PLL for codec. And K is assigned to 2
+ * which make calculation more efficiently.
+ *
+ * Returns 0 for success or negative error code.
+ */
+static int rt5651_pll_calc(const unsigned int freq_in,
+	const unsigned int freq_out, struct rt5651_pll_code *pll_code)
+{
+	int max_n = RT5651_PLL_N_MAX, max_m = RT5651_PLL_M_MAX;
+	int n = 0, m = 0, red, n_t, m_t, in_t, out_t;
+	int red_t = abs(freq_out - freq_in);
+	bool bypass = false;
+
+	if (RT5651_PLL_INP_MAX < freq_in || RT5651_PLL_INP_MIN > freq_in)
+		return -EINVAL;
+
+	for (n_t = 0; n_t <= max_n; n_t++) {
+		in_t = (freq_in >> 1) + (freq_in >> 2) * n_t;
+		if (in_t < 0)
+			continue;
+		if (in_t == freq_out) {
+			bypass = true;
+			n = n_t;
+			goto code_find;
+		}
+		for (m_t = 0; m_t <= max_m; m_t++) {
+			out_t = in_t / (m_t + 2);
+			red = abs(out_t - freq_out);
+			if (red < red_t) {
+				n = n_t;
+				m = m_t;
+				if (red == 0)
+					goto code_find;
+				red_t = red;
+			}
+		}
+	}
+	pr_debug("Only get approximation about PLL\n");
+
+code_find:
+	pll_code->m_bp = bypass;
+	pll_code->m_code = m;
+	pll_code->n_code = n;
+	pll_code->k_code = 2;
+	return 0;
+}
+
+static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
+			unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	struct rt5651_pll_code *pll_code = &rt5651->pll_code;
+	int ret;
+
+	if (source == rt5651->pll_src && freq_in == rt5651->pll_in &&
+	    freq_out == rt5651->pll_out)
+		return 0;
+
+	if (!freq_in || !freq_out) {
+		dev_dbg(codec->dev, "PLL disabled\n");
+
+		rt5651->pll_in = 0;
+		rt5651->pll_out = 0;
+		snd_soc_update_bits(codec, RT5651_GLB_CLK,
+			RT5651_SCLK_SRC_MASK, RT5651_SCLK_SRC_MCLK);
+		return 0;
+	}
+
+	switch (source) {
+	case RT5651_PLL1_S_MCLK:
+		snd_soc_update_bits(codec, RT5651_GLB_CLK,
+			RT5651_PLL1_SRC_MASK, RT5651_PLL1_SRC_MCLK);
+		break;
+	case RT5651_PLL1_S_BCLK1:
+		snd_soc_update_bits(codec, RT5651_GLB_CLK,
+				RT5651_PLL1_SRC_MASK, RT5651_PLL1_SRC_BCLK1);
+		break;
+	case RT5651_PLL1_S_BCLK2:
+			snd_soc_update_bits(codec, RT5651_GLB_CLK,
+				RT5651_PLL1_SRC_MASK, RT5651_PLL1_SRC_BCLK2);
+		break;
+	default:
+		dev_err(codec->dev, "Unknown PLL source %d\n", source);
+		return -EINVAL;
+	}
+
+	ret = rt5651_pll_calc(freq_in, freq_out, pll_code);
+	if (ret < 0) {
+		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
+		return ret;
+	}
+
+	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=2\n", pll_code->m_bp,
+		(pll_code->m_bp ? 0 : pll_code->m_code), pll_code->n_code);
+
+	snd_soc_write(codec, RT5651_PLL_CTRL1,
+		pll_code->n_code << RT5651_PLL_N_SFT | pll_code->k_code);
+	snd_soc_write(codec, RT5651_PLL_CTRL2,
+		(pll_code->m_bp ? 0 : pll_code->m_code) << RT5651_PLL_M_SFT |
+		pll_code->m_bp << RT5651_PLL_M_BP_SFT);
+
+	rt5651->pll_in = freq_in;
+	rt5651->pll_out = freq_out;
+	rt5651->pll_src = source;
+
+	return 0;
+}
+
+static int rt5651_set_bias_level(struct snd_soc_codec *codec,
+			enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
+			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
+				RT5651_PWR_VREF1 | RT5651_PWR_MB |
+				RT5651_PWR_BG | RT5651_PWR_VREF2,
+				RT5651_PWR_VREF1 | RT5651_PWR_MB |
+				RT5651_PWR_BG | RT5651_PWR_VREF2);
+			usleep_range(10000, 15000);
+			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
+				RT5651_PWR_FV1 | RT5651_PWR_FV2,
+				RT5651_PWR_FV1 | RT5651_PWR_FV2);
+			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
+				RT5651_PWR_LDO_DVO_MASK,
+				RT5651_PWR_LDO_DVO_1_2V);
+			snd_soc_update_bits(codec, RT5651_D_MISC, 0x1, 0x1);
+			if (snd_soc_read(codec, RT5651_PLL_MODE_1) & 0x9200)
+				snd_soc_update_bits(codec, RT5651_D_MISC,
+						    0xc00, 0xc00);
+		}
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		snd_soc_write(codec, RT5651_D_MISC, 0x0010);
+		snd_soc_write(codec, RT5651_PWR_DIG1, 0x0000);
+		snd_soc_write(codec, RT5651_PWR_DIG2, 0x0000);
+		snd_soc_write(codec, RT5651_PWR_VOL, 0x0000);
+		snd_soc_write(codec, RT5651_PWR_MIXER, 0x0000);
+		snd_soc_write(codec, RT5651_PWR_ANLG1, 0x0000);
+		snd_soc_write(codec, RT5651_PWR_ANLG2, 0x0000);
+		break;
+
+	default:
+		break;
+	}
+	codec->dapm.bias_level = level;
+
+	return 0;
+}
+
+static int rt5651_probe(struct snd_soc_codec *codec)
+{
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	rt5651->codec = codec;
+
+	snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
+		RT5651_PWR_VREF1 | RT5651_PWR_MB |
+		RT5651_PWR_BG | RT5651_PWR_VREF2,
+		RT5651_PWR_VREF1 | RT5651_PWR_MB |
+		RT5651_PWR_BG | RT5651_PWR_VREF2);
+	usleep_range(10000, 15000);
+	snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
+		RT5651_PWR_FV1 | RT5651_PWR_FV2,
+		RT5651_PWR_FV1 | RT5651_PWR_FV2);
+
+	rt5651_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rt5651_suspend(struct snd_soc_codec *codec)
+{
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(rt5651->regmap, true);
+	regcache_mark_dirty(rt5651->regmap);
+	return 0;
+}
+
+static int rt5651_resume(struct snd_soc_codec *codec)
+{
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(rt5651->regmap, false);
+	snd_soc_cache_sync(codec);
+
+	return 0;
+}
+#else
+#define rt5651_suspend NULL
+#define rt5651_resume NULL
+#endif
+
+#define RT5651_STEREO_RATES SNDRV_PCM_RATE_8000_96000
+#define RT5651_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
+
+struct snd_soc_dai_ops rt5651_aif_dai_ops = {
+	.hw_params = rt5651_hw_params,
+	.set_fmt = rt5651_set_dai_fmt,
+	.set_sysclk = rt5651_set_dai_sysclk,
+	.set_pll = rt5651_set_dai_pll,
+};
+
+struct snd_soc_dai_driver rt5651_dai[] = {
+	{
+		.name = "rt5651-aif1",
+		.id = RT5651_AIF1,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5651_STEREO_RATES,
+			.formats = RT5651_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5651_STEREO_RATES,
+			.formats = RT5651_FORMATS,
+		},
+		.ops = &rt5651_aif_dai_ops,
+	},
+	{
+		.name = "rt5651-aif2",
+		.id = RT5651_AIF2,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5651_STEREO_RATES,
+			.formats = RT5651_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5651_STEREO_RATES,
+			.formats = RT5651_FORMATS,
+		},
+		.ops = &rt5651_aif_dai_ops,
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_rt5651 = {
+	.probe = rt5651_probe,
+	.suspend = rt5651_suspend,
+	.resume = rt5651_resume,
+	.set_bias_level = rt5651_set_bias_level,
+	.idle_bias_off = true,
+	.controls = rt5651_snd_controls,
+	.num_controls = ARRAY_SIZE(rt5651_snd_controls),
+	.dapm_widgets = rt5651_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt5651_dapm_widgets),
+	.dapm_routes = rt5651_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt5651_dapm_routes),
+};
+
+static const struct regmap_config rt5651_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = RT5651_DEVICE_ID + 1 + (ARRAY_SIZE(rt5651_ranges) *
+					       RT5651_PR_SPACING),
+	.volatile_reg = rt5651_volatile_register,
+	.readable_reg = rt5651_readable_register,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = rt5651_reg,
+	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
+	.ranges = rt5651_ranges,
+	.num_ranges = ARRAY_SIZE(rt5651_ranges),
+};
+
+static const struct i2c_device_id rt5651_i2c_id[] = {
+	{ "rt5651", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
+
+static int rt5651_i2c_probe(struct i2c_client *i2c,
+		    const struct i2c_device_id *id)
+{
+	struct rt5651_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	struct rt5651_priv *rt5651;
+	int ret;
+
+	rt5651 = devm_kzalloc(&i2c->dev, sizeof(*rt5651),
+				GFP_KERNEL);
+	if (NULL == rt5651)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, rt5651);
+
+	if (pdata)
+		rt5651->pdata = *pdata;
+
+	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
+	if (IS_ERR(rt5651->regmap)) {
+		ret = PTR_ERR(rt5651->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	if (ret != RT5651_DEVICE_ID_VALUE) {
+		dev_err(&i2c->dev,
+			"Device with ID register %x is not rt5651\n", ret);
+		return -ENODEV;
+	}
+
+	regmap_write(rt5651->regmap, RT5651_RESET, 0);
+
+	ret = regmap_register_patch(rt5651->regmap, init_list,
+				    ARRAY_SIZE(init_list));
+	if (ret != 0)
+		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
+
+	if (rt5651->pdata.in2_diff)
+		regmap_update_bits(rt5651->regmap, RT5651_IN1_IN2,
+					RT5651_IN_DF2, RT5651_IN_DF2);
+
+	if (rt5651->pdata.dmic_en)
+		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
+				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
+
+	rt5651->hp_mute = 1;
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5651,
+				rt5651_dai, ARRAY_SIZE(rt5651_dai));
+
+	return ret;
+}
+
+static int rt5651_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+struct i2c_driver rt5651_i2c_driver = {
+	.driver = {
+		.name = "rt5651",
+		.owner = THIS_MODULE,
+	},
+	.probe = rt5651_i2c_probe,
+	.remove   = rt5651_i2c_remove,
+	.id_table = rt5651_i2c_id,
+};
+module_i2c_driver(rt5651_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC RT5651 driver");
+MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
new file mode 100644
index 0000000..a28bd0c
--- /dev/null
+++ b/sound/soc/codecs/rt5651.h
@@ -0,0 +1,2081 @@
+/*
+ * rt5651.h  --  RT5651 ALSA SoC audio driver
+ *
+ * Copyright 2011 Realtek Microelectronics
+ * Author: Johnny Hsu <johnnyhsu@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT5651_H__
+#define __RT5651_H__
+
+#include <sound/rt5651.h>
+
+/* Info */
+#define RT5651_RESET				0x00
+#define RT5651_VERSION_ID			0xfd
+#define RT5651_VENDOR_ID			0xfe
+#define RT5651_DEVICE_ID			0xff
+/*  I/O - Output */
+#define RT5651_HP_VOL				0x02
+#define RT5651_LOUT_CTRL1			0x03
+#define RT5651_LOUT_CTRL2			0x05
+/* I/O - Input */
+#define RT5651_IN1_IN2				0x0d
+#define RT5651_IN3				0x0e
+#define RT5651_INL1_INR1_VOL			0x0f
+#define RT5651_INL2_INR2_VOL			0x10
+/* I/O - ADC/DAC/DMIC */
+#define RT5651_DAC1_DIG_VOL			0x19
+#define RT5651_DAC2_DIG_VOL			0x1a
+#define RT5651_DAC2_CTRL			0x1b
+#define RT5651_ADC_DIG_VOL			0x1c
+#define RT5651_ADC_DATA				0x1d
+#define RT5651_ADC_BST_VOL			0x1e
+/* Mixer - D-D */
+#define RT5651_STO1_ADC_MIXER			0x27
+#define RT5651_STO2_ADC_MIXER			0x28
+#define RT5651_AD_DA_MIXER			0x29
+#define RT5651_STO_DAC_MIXER			0x2a
+#define RT5651_DD_MIXER				0x2b
+#define RT5651_DIG_INF_DATA			0x2f
+/* PDM */
+#define RT5651_PDM_CTL				0x30
+#define RT5651_PDM_I2C_CTL1			0x31
+#define RT5651_PDM_I2C_CTL2			0x32
+#define RT5651_PDM_I2C_DATA_W			0x33
+#define RT5651_PDM_I2C_DATA_R			0x34
+/* Mixer - ADC */
+#define RT5651_REC_L1_MIXER			0x3b
+#define RT5651_REC_L2_MIXER			0x3c
+#define RT5651_REC_R1_MIXER			0x3d
+#define RT5651_REC_R2_MIXER			0x3e
+/* Mixer - DAC */
+#define RT5651_HPO_MIXER			0x45
+#define RT5651_OUT_L1_MIXER			0x4d
+#define RT5651_OUT_L2_MIXER			0x4e
+#define RT5651_OUT_L3_MIXER			0x4f
+#define RT5651_OUT_R1_MIXER			0x50
+#define RT5651_OUT_R2_MIXER			0x51
+#define RT5651_OUT_R3_MIXER			0x52
+#define RT5651_LOUT_MIXER			0x53
+/* Power */
+#define RT5651_PWR_DIG1				0x61
+#define RT5651_PWR_DIG2				0x62
+#define RT5651_PWR_ANLG1			0x63
+#define RT5651_PWR_ANLG2			0x64
+#define RT5651_PWR_MIXER			0x65
+#define RT5651_PWR_VOL				0x66
+/* Private Register Control */
+#define RT5651_PRIV_INDEX			0x6a
+#define RT5651_PRIV_DATA			0x6c
+/* Format - ADC/DAC */
+#define RT5651_I2S1_SDP				0x70
+#define RT5651_I2S2_SDP				0x71
+#define RT5651_ADDA_CLK1			0x73
+#define RT5651_ADDA_CLK2			0x74
+#define RT5651_DMIC				0x75
+/* TDM Control */
+#define RT5651_TDM_CTL_1			0x77
+#define RT5651_TDM_CTL_2			0x78
+#define RT5651_TDM_CTL_3			0x79
+/* Function - Analog */
+#define RT5651_GLB_CLK				0x80
+#define RT5651_PLL_CTRL1			0x81
+#define RT5651_PLL_CTRL2			0x82
+#define RT5651_PLL_MODE_1			0x83
+#define RT5651_PLL_MODE_2			0x84
+#define RT5651_PLL_MODE_3			0x85
+#define RT5651_PLL_MODE_4			0x86
+#define RT5651_PLL_MODE_5			0x87
+#define RT5651_PLL_MODE_6			0x89
+#define RT5651_PLL_MODE_7			0x8a
+#define RT5651_DEPOP_M1				0x8e
+#define RT5651_DEPOP_M2				0x8f
+#define RT5651_DEPOP_M3				0x90
+#define RT5651_CHARGE_PUMP			0x91
+#define RT5651_MICBIAS				0x93
+#define RT5651_A_JD_CTL1			0x94
+/* Function - Digital */
+#define RT5651_EQ_CTRL1				0xb0
+#define RT5651_EQ_CTRL2				0xb1
+#define RT5651_ALC_1				0xb4
+#define RT5651_ALC_2				0xb5
+#define RT5651_ALC_3				0xb6
+#define RT5651_JD_CTRL1				0xbb
+#define RT5651_JD_CTRL2				0xbc
+#define RT5651_IRQ_CTRL1			0xbd
+#define RT5651_IRQ_CTRL2			0xbe
+#define RT5651_INT_IRQ_ST			0xbf
+#define RT5651_GPIO_CTRL1			0xc0
+#define RT5651_GPIO_CTRL2			0xc1
+#define RT5651_GPIO_CTRL3			0xc2
+#define RT5651_PGM_REG_ARR1			0xc8
+#define RT5651_PGM_REG_ARR2			0xc9
+#define RT5651_PGM_REG_ARR3			0xca
+#define RT5651_PGM_REG_ARR4			0xcb
+#define RT5651_PGM_REG_ARR5			0xcc
+#define RT5651_SCB_FUNC				0xcd
+#define RT5651_SCB_CTRL				0xce
+#define RT5651_BASE_BACK			0xcf
+#define RT5651_MP3_PLUS1			0xd0
+#define RT5651_MP3_PLUS2			0xd1
+#define RT5651_ADJ_HPF_CTRL1			0xd3
+#define RT5651_ADJ_HPF_CTRL2			0xd4
+#define RT5651_HP_CALIB_AMP_DET			0xd6
+#define RT5651_HP_CALIB2			0xd7
+#define RT5651_SV_ZCD1				0xd9
+#define RT5651_SV_ZCD2				0xda
+#define RT5651_D_MISC				0xfa
+/* Dummy Register */
+#define RT5651_DUMMY2				0xfb
+#define RT5651_DUMMY3				0xfc
+
+
+/* Index of Codec Private Register definition */
+#define RT5651_BIAS_CUR1			0x12
+#define RT5651_BIAS_CUR3			0x14
+#define RT5651_CLSD_INT_REG1			0x1c
+#define RT5651_CHPUMP_INT_REG1			0x24
+#define RT5651_MAMP_INT_REG2			0x37
+#define RT5651_CHOP_DAC_ADC			0x3d
+#define RT5651_3D_SPK				0x63
+#define RT5651_WND_1				0x6c
+#define RT5651_WND_2				0x6d
+#define RT5651_WND_3				0x6e
+#define RT5651_WND_4				0x6f
+#define RT5651_WND_5				0x70
+#define RT5651_WND_8				0x73
+#define RT5651_DIP_SPK_INF			0x75
+#define RT5651_HP_DCC_INT1			0x77
+#define RT5651_EQ_BW_LOP			0xa0
+#define RT5651_EQ_GN_LOP			0xa1
+#define RT5651_EQ_FC_BP1			0xa2
+#define RT5651_EQ_BW_BP1			0xa3
+#define RT5651_EQ_GN_BP1			0xa4
+#define RT5651_EQ_FC_BP2			0xa5
+#define RT5651_EQ_BW_BP2			0xa6
+#define RT5651_EQ_GN_BP2			0xa7
+#define RT5651_EQ_FC_BP3			0xa8
+#define RT5651_EQ_BW_BP3			0xa9
+#define RT5651_EQ_GN_BP3			0xaa
+#define RT5651_EQ_FC_BP4			0xab
+#define RT5651_EQ_BW_BP4			0xac
+#define RT5651_EQ_GN_BP4			0xad
+#define RT5651_EQ_FC_HIP1			0xae
+#define RT5651_EQ_GN_HIP1			0xaf
+#define RT5651_EQ_FC_HIP2			0xb0
+#define RT5651_EQ_BW_HIP2			0xb1
+#define RT5651_EQ_GN_HIP2			0xb2
+#define RT5651_EQ_PRE_VOL			0xb3
+#define RT5651_EQ_PST_VOL			0xb4
+
+
+/* global definition */
+#define RT5651_L_MUTE				(0x1 << 15)
+#define RT5651_L_MUTE_SFT			15
+#define RT5651_VOL_L_MUTE			(0x1 << 14)
+#define RT5651_VOL_L_SFT			14
+#define RT5651_R_MUTE				(0x1 << 7)
+#define RT5651_R_MUTE_SFT			7
+#define RT5651_VOL_R_MUTE			(0x1 << 6)
+#define RT5651_VOL_R_SFT			6
+#define RT5651_L_VOL_MASK			(0x3f << 8)
+#define RT5651_L_VOL_SFT			8
+#define RT5651_R_VOL_MASK			(0x3f)
+#define RT5651_R_VOL_SFT			0
+
+/* LOUT Control 2(0x05) */
+#define RT5651_EN_DFO				(0x1 << 15)
+
+/* IN1 and IN2 Control (0x0d) */
+/* IN3 and IN4 Control (0x0e) */
+#define RT5651_BST_MASK1			(0xf<<12)
+#define RT5651_BST_SFT1				12
+#define RT5651_BST_MASK2			(0xf<<8)
+#define RT5651_BST_SFT2				8
+#define RT5651_IN_DF1				(0x1 << 7)
+#define RT5651_IN_SFT1				7
+#define RT5651_IN_DF2				(0x1 << 6)
+#define RT5651_IN_SFT2				6
+
+/* INL1 and INR1 Volume Control (0x0f) */
+/* INL2 and INR2 Volume Control (0x10) */
+#define RT5651_INL_SEL_MASK			(0x1 << 15)
+#define RT5651_INL_SEL_SFT			15
+#define RT5651_INL_SEL_IN4P			(0x0 << 15)
+#define RT5651_INL_SEL_MONOP			(0x1 << 15)
+#define RT5651_INL_VOL_MASK			(0x1f << 8)
+#define RT5651_INL_VOL_SFT			8
+#define RT5651_INR_SEL_MASK			(0x1 << 7)
+#define RT5651_INR_SEL_SFT			7
+#define RT5651_INR_SEL_IN4N			(0x0 << 7)
+#define RT5651_INR_SEL_MONON			(0x1 << 7)
+#define RT5651_INR_VOL_MASK			(0x1f)
+#define RT5651_INR_VOL_SFT			0
+
+/* DAC1 Digital Volume (0x19) */
+#define RT5651_DAC_L1_VOL_MASK			(0xff << 8)
+#define RT5651_DAC_L1_VOL_SFT			8
+#define RT5651_DAC_R1_VOL_MASK			(0xff)
+#define RT5651_DAC_R1_VOL_SFT			0
+
+/* DAC2 Digital Volume (0x1a) */
+#define RT5651_DAC_L2_VOL_MASK			(0xff << 8)
+#define RT5651_DAC_L2_VOL_SFT			8
+#define RT5651_DAC_R2_VOL_MASK			(0xff)
+#define RT5651_DAC_R2_VOL_SFT			0
+
+/* DAC2 Control (0x1b) */
+#define RT5651_M_DAC_L2_VOL			(0x1 << 13)
+#define RT5651_M_DAC_L2_VOL_SFT			13
+#define RT5651_M_DAC_R2_VOL			(0x1 << 12)
+#define RT5651_M_DAC_R2_VOL_SFT			12
+#define RT5651_SEL_DAC_L2			(0x1 << 11)
+#define RT5651_IF2_DAC_L2			(0x1 << 11)
+#define RT5651_IF1_DAC_L2			(0x0 << 11)
+#define RT5651_SEL_DAC_L2_SFT			11
+#define RT5651_SEL_DAC_R2			(0x1 << 10)
+#define RT5651_IF2_DAC_R2			(0x1 << 11)
+#define RT5651_IF1_DAC_R2			(0x0 << 11)
+#define RT5651_SEL_DAC_R2_SFT			10
+
+/* ADC Digital Volume Control (0x1c) */
+#define RT5651_ADC_L_VOL_MASK			(0x7f << 8)
+#define RT5651_ADC_L_VOL_SFT			8
+#define RT5651_ADC_R_VOL_MASK			(0x7f)
+#define RT5651_ADC_R_VOL_SFT			0
+
+/* Mono ADC Digital Volume Control (0x1d) */
+#define RT5651_M_MONO_ADC_L			(0x1 << 15)
+#define RT5651_M_MONO_ADC_L_SFT			15
+#define RT5651_MONO_ADC_L_VOL_MASK		(0x7f << 8)
+#define RT5651_MONO_ADC_L_VOL_SFT		8
+#define RT5651_M_MONO_ADC_R			(0x1 << 7)
+#define RT5651_M_MONO_ADC_R_SFT			7
+#define RT5651_MONO_ADC_R_VOL_MASK		(0x7f)
+#define RT5651_MONO_ADC_R_VOL_SFT		0
+
+/* ADC Boost Volume Control (0x1e) */
+#define RT5651_ADC_L_BST_MASK			(0x3 << 14)
+#define RT5651_ADC_L_BST_SFT			14
+#define RT5651_ADC_R_BST_MASK			(0x3 << 12)
+#define RT5651_ADC_R_BST_SFT			12
+#define RT5651_ADC_COMP_MASK			(0x3 << 10)
+#define RT5651_ADC_COMP_SFT			10
+
+/* Stereo ADC1 Mixer Control (0x27) */
+#define RT5651_M_STO1_ADC_L1			(0x1 << 14)
+#define RT5651_M_STO1_ADC_L1_SFT		14
+#define RT5651_M_STO1_ADC_L2			(0x1 << 13)
+#define RT5651_M_STO1_ADC_L2_SFT		13
+#define RT5651_STO1_ADC_1_SRC_MASK		(0x1 << 12)
+#define RT5651_STO1_ADC_1_SRC_SFT		12
+#define RT5651_STO1_ADC_1_SRC_ADC		(0x1 << 12)
+#define RT5651_STO1_ADC_1_SRC_DACMIX		(0x0 << 12)
+#define RT5651_STO1_ADC_2_SRC_MASK		(0x1 << 11)
+#define RT5651_STO1_ADC_2_SRC_SFT		11
+#define RT5651_STO1_ADC_2_SRC_DMIC		(0x0 << 11)
+#define RT5651_STO1_ADC_2_SRC_DACMIXR	(0x1 << 11)
+#define RT5651_M_STO1_ADC_R1			(0x1 << 6)
+#define RT5651_M_STO1_ADC_R1_SFT		6
+#define RT5651_M_STO1_ADC_R2			(0x1 << 5)
+#define RT5651_M_STO1_ADC_R2_SFT		5
+
+/* Stereo ADC2 Mixer Control (0x28) */
+#define RT5651_M_STO2_ADC_L1			(0x1 << 14)
+#define RT5651_M_STO2_ADC_L1_SFT		14
+#define RT5651_M_STO2_ADC_L2			(0x1 << 13)
+#define RT5651_M_STO2_ADC_L2_SFT		13
+#define RT5651_STO2_ADC_L1_SRC_MASK		(0x1 << 12)
+#define RT5651_STO2_ADC_L1_SRC_SFT		12
+#define RT5651_STO2_ADC_L1_SRC_DACMIXL		(0x0 << 12)
+#define RT5651_STO2_ADC_L1_SRC_ADCL		(0x1 << 12)
+#define RT5651_STO2_ADC_L2_SRC_MASK		(0x1 << 11)
+#define RT5651_STO2_ADC_L2_SRC_SFT		11
+#define RT5651_STO2_ADC_L2_SRC_DMIC		(0x0 << 11)
+#define RT5651_STO2_ADC_L2_SRC_DACMIXR		(0x1 << 11)
+#define RT5651_M_STO2_ADC_R1			(0x1 << 6)
+#define RT5651_M_STO2_ADC_R1_SFT		6
+#define RT5651_M_STO2_ADC_R2			(0x1 << 5)
+#define RT5651_M_STO2_ADC_R2_SFT		5
+#define RT5651_STO2_ADC_R1_SRC_MASK		(0x1 << 4)
+#define RT5651_STO2_ADC_R1_SRC_SFT		4
+#define RT5651_STO2_ADC_R1_SRC_ADCR		(0x1 << 4)
+#define RT5651_STO2_ADC_R1_SRC_DACMIXR		(0x0 << 4)
+#define RT5651_STO2_ADC_R2_SRC_MASK		(0x1 << 3)
+#define RT5651_STO2_ADC_R2_SRC_SFT		3
+#define RT5651_STO2_ADC_R2_SRC_DMIC		(0x0 << 3)
+#define RT5651_STO2_ADC_R2_SRC_DACMIXR		(0x1 << 3)
+
+/* ADC Mixer to DAC Mixer Control (0x29) */
+#define RT5651_M_ADCMIX_L			(0x1 << 15)
+#define RT5651_M_ADCMIX_L_SFT			15
+#define RT5651_M_IF1_DAC_L			(0x1 << 14)
+#define RT5651_M_IF1_DAC_L_SFT			14
+#define RT5651_M_ADCMIX_R			(0x1 << 7)
+#define RT5651_M_ADCMIX_R_SFT			7
+#define RT5651_M_IF1_DAC_R			(0x1 << 6)
+#define RT5651_M_IF1_DAC_R_SFT			6
+
+/* Stereo DAC Mixer Control (0x2a) */
+#define RT5651_M_DAC_L1_MIXL			(0x1 << 14)
+#define RT5651_M_DAC_L1_MIXL_SFT		14
+#define RT5651_DAC_L1_STO_L_VOL_MASK		(0x1 << 13)
+#define RT5651_DAC_L1_STO_L_VOL_SFT		13
+#define RT5651_M_DAC_L2_MIXL			(0x1 << 12)
+#define RT5651_M_DAC_L2_MIXL_SFT		12
+#define RT5651_DAC_L2_STO_L_VOL_MASK		(0x1 << 11)
+#define RT5651_DAC_L2_STO_L_VOL_SFT		11
+#define RT5651_M_DAC_R1_MIXL			(0x1 << 9)
+#define RT5651_M_DAC_R1_MIXL_SFT		9
+#define RT5651_DAC_R1_STO_L_VOL_MASK		(0x1 << 8)
+#define RT5651_DAC_R1_STO_L_VOL_SFT		8
+#define RT5651_M_DAC_R1_MIXR			(0x1 << 6)
+#define RT5651_M_DAC_R1_MIXR_SFT		6
+#define RT5651_DAC_R1_STO_R_VOL_MASK		(0x1 << 5)
+#define RT5651_DAC_R1_STO_R_VOL_SFT		5
+#define RT5651_M_DAC_R2_MIXR			(0x1 << 4)
+#define RT5651_M_DAC_R2_MIXR_SFT		4
+#define RT5651_DAC_R2_STO_R_VOL_MASK		(0x1 << 3)
+#define RT5651_DAC_R2_STO_R_VOL_SFT		3
+#define RT5651_M_DAC_L1_MIXR			(0x1 << 1)
+#define RT5651_M_DAC_L1_MIXR_SFT		1
+#define RT5651_DAC_L1_STO_R_VOL_MASK		(0x1)
+#define RT5651_DAC_L1_STO_R_VOL_SFT		0
+
+/* DD Mixer Control (0x2b) */
+#define RT5651_M_STO_DD_L1			(0x1 << 14)
+#define RT5651_M_STO_DD_L1_SFT			14
+#define RT5651_STO_DD_L1_VOL_MASK		(0x1 << 13)
+#define RT5651_DAC_DD_L1_VOL_SFT		13
+#define RT5651_M_STO_DD_L2			(0x1 << 12)
+#define RT5651_M_STO_DD_L2_SFT			12
+#define RT5651_STO_DD_L2_VOL_MASK		(0x1 << 11)
+#define RT5651_STO_DD_L2_VOL_SFT		11
+#define RT5651_M_STO_DD_R2_L			(0x1 << 10)
+#define RT5651_M_STO_DD_R2_L_SFT		10
+#define RT5651_STO_DD_R2_L_VOL_MASK		(0x1 << 9)
+#define RT5651_STO_DD_R2_L_VOL_SFT		9
+#define RT5651_M_STO_DD_R1			(0x1 << 6)
+#define RT5651_M_STO_DD_R1_SFT			6
+#define RT5651_STO_DD_R1_VOL_MASK		(0x1 << 5)
+#define RT5651_STO_DD_R1_VOL_SFT		5
+#define RT5651_M_STO_DD_R2			(0x1 << 4)
+#define RT5651_M_STO_DD_R2_SFT			4
+#define RT5651_STO_DD_R2_VOL_MASK		(0x1 << 3)
+#define RT5651_STO_DD_R2_VOL_SFT		3
+#define RT5651_M_STO_DD_L2_R			(0x1 << 2)
+#define RT5651_M_STO_DD_L2_R_SFT		2
+#define RT5651_STO_DD_L2_R_VOL_MASK		(0x1 << 1)
+#define RT5651_STO_DD_L2_R_VOL_SFT		1
+
+/* Digital Mixer Control (0x2c) */
+#define RT5651_M_STO_L_DAC_L			(0x1 << 15)
+#define RT5651_M_STO_L_DAC_L_SFT		15
+#define RT5651_STO_L_DAC_L_VOL_MASK		(0x1 << 14)
+#define RT5651_STO_L_DAC_L_VOL_SFT		14
+#define RT5651_M_DAC_L2_DAC_L			(0x1 << 13)
+#define RT5651_M_DAC_L2_DAC_L_SFT		13
+#define RT5651_DAC_L2_DAC_L_VOL_MASK		(0x1 << 12)
+#define RT5651_DAC_L2_DAC_L_VOL_SFT		12
+#define RT5651_M_STO_R_DAC_R			(0x1 << 11)
+#define RT5651_M_STO_R_DAC_R_SFT		11
+#define RT5651_STO_R_DAC_R_VOL_MASK		(0x1 << 10)
+#define RT5651_STO_R_DAC_R_VOL_SFT		10
+#define RT5651_M_DAC_R2_DAC_R			(0x1 << 9)
+#define RT5651_M_DAC_R2_DAC_R_SFT		9
+#define RT5651_DAC_R2_DAC_R_VOL_MASK		(0x1 << 8)
+#define RT5651_DAC_R2_DAC_R_VOL_SFT		8
+
+/* DSP Path Control 1 (0x2d) */
+#define RT5651_RXDP_SRC_MASK			(0x1 << 15)
+#define RT5651_RXDP_SRC_SFT			15
+#define RT5651_RXDP_SRC_NOR			(0x0 << 15)
+#define RT5651_RXDP_SRC_DIV3			(0x1 << 15)
+#define RT5651_TXDP_SRC_MASK			(0x1 << 14)
+#define RT5651_TXDP_SRC_SFT			14
+#define RT5651_TXDP_SRC_NOR			(0x0 << 14)
+#define RT5651_TXDP_SRC_DIV3			(0x1 << 14)
+
+/* DSP Path Control 2 (0x2e) */
+#define RT5651_DAC_L2_SEL_MASK			(0x3 << 14)
+#define RT5651_DAC_L2_SEL_SFT			14
+#define RT5651_DAC_L2_SEL_IF2			(0x0 << 14)
+#define RT5651_DAC_L2_SEL_IF3			(0x1 << 14)
+#define RT5651_DAC_L2_SEL_TXDC			(0x2 << 14)
+#define RT5651_DAC_L2_SEL_BASS			(0x3 << 14)
+#define RT5651_DAC_R2_SEL_MASK			(0x3 << 12)
+#define RT5651_DAC_R2_SEL_SFT			12
+#define RT5651_DAC_R2_SEL_IF2			(0x0 << 12)
+#define RT5651_DAC_R2_SEL_IF3			(0x1 << 12)
+#define RT5651_DAC_R2_SEL_TXDC			(0x2 << 12)
+#define RT5651_IF2_ADC_L_SEL_MASK		(0x1 << 11)
+#define RT5651_IF2_ADC_L_SEL_SFT		11
+#define RT5651_IF2_ADC_L_SEL_TXDP		(0x0 << 11)
+#define RT5651_IF2_ADC_L_SEL_PASS		(0x1 << 11)
+#define RT5651_IF2_ADC_R_SEL_MASK		(0x1 << 10)
+#define RT5651_IF2_ADC_R_SEL_SFT		10
+#define RT5651_IF2_ADC_R_SEL_TXDP		(0x0 << 10)
+#define RT5651_IF2_ADC_R_SEL_PASS		(0x1 << 10)
+#define RT5651_RXDC_SEL_MASK			(0x3 << 8)
+#define RT5651_RXDC_SEL_SFT			8
+#define RT5651_RXDC_SEL_NOR			(0x0 << 8)
+#define RT5651_RXDC_SEL_L2R			(0x1 << 8)
+#define RT5651_RXDC_SEL_R2L			(0x2 << 8)
+#define RT5651_RXDC_SEL_SWAP			(0x3 << 8)
+#define RT5651_RXDP_SEL_MASK			(0x3 << 6)
+#define RT5651_RXDP_SEL_SFT			6
+#define RT5651_RXDP_SEL_NOR			(0x0 << 6)
+#define RT5651_RXDP_SEL_L2R			(0x1 << 6)
+#define RT5651_RXDP_SEL_R2L			(0x2 << 6)
+#define RT5651_RXDP_SEL_SWAP			(0x3 << 6)
+#define RT5651_TXDC_SEL_MASK			(0x3 << 4)
+#define RT5651_TXDC_SEL_SFT			4
+#define RT5651_TXDC_SEL_NOR			(0x0 << 4)
+#define RT5651_TXDC_SEL_L2R			(0x1 << 4)
+#define RT5651_TXDC_SEL_R2L			(0x2 << 4)
+#define RT5651_TXDC_SEL_SWAP			(0x3 << 4)
+#define RT5651_TXDP_SEL_MASK			(0x3 << 2)
+#define RT5651_TXDP_SEL_SFT			2
+#define RT5651_TXDP_SEL_NOR			(0x0 << 2)
+#define RT5651_TXDP_SEL_L2R			(0x1 << 2)
+#define RT5651_TXDP_SEL_R2L			(0x2 << 2)
+#define RT5651_TRXDP_SEL_SWAP			(0x3 << 2)
+
+/* Digital Interface Data Control (0x2f) */
+#define RT5651_IF2_DAC_SEL_MASK			(0x3 << 10)
+#define RT5651_IF2_DAC_SEL_SFT			10
+#define RT5651_IF2_DAC_SEL_NOR			(0x0 << 10)
+#define RT5651_IF2_DAC_SEL_SWAP			(0x1 << 10)
+#define RT5651_IF2_DAC_SEL_L2R			(0x2 << 10)
+#define RT5651_IF2_DAC_SEL_R2L			(0x3 << 10)
+#define RT5651_IF2_ADC_SEL_MASK			(0x3 << 8)
+#define RT5651_IF2_ADC_SEL_SFT			8
+#define RT5651_IF2_ADC_SEL_NOR			(0x0 << 8)
+#define RT5651_IF2_ADC_SEL_SWAP			(0x1 << 8)
+#define RT5651_IF2_ADC_SEL_L2R			(0x2 << 8)
+#define RT5651_IF2_ADC_SEL_R2L			(0x3 << 8)
+#define RT5651_IF2_ADC_SRC_MASK			(0x1 << 7)
+#define RT5651_IF2_ADC_SRC_SFT			7
+#define RT5651_IF1_ADC1				(0x0 << 7)
+#define RT5651_IF1_ADC2				(0x1 << 7)
+
+/* PDM Output Control (0x30) */
+#define RT5651_PDM_L_SEL_MASK			(0x1 << 15)
+#define RT5651_PDM_L_SEL_SFT			15
+#define RT5651_PDM_L_SEL_DD_L			(0x0 << 15)
+#define RT5651_PDM_L_SEL_STO_L			(0x1 << 15)
+#define RT5651_M_PDM_L				(0x1 << 14)
+#define RT5651_M_PDM_L_SFT			14
+#define RT5651_PDM_R_SEL_MASK			(0x1 << 13)
+#define RT5651_PDM_R_SEL_SFT			13
+#define RT5651_PDM_R_SEL_DD_L			(0x0 << 13)
+#define RT5651_PDM_R_SEL_STO_L			(0x1 << 13)
+#define RT5651_M_PDM_R				(0x1 << 12)
+#define RT5651_M_PDM_R_SFT			12
+#define RT5651_PDM_BUSY				(0x1 << 6)
+#define RT5651_PDM_BUSY_SFT			6
+#define RT5651_PDM_PATTERN_SEL_MASK		(0x1 << 5)
+#define RT5651_PDM_PATTERN_SEL_64		(0x0 << 5)
+#define RT5651_PDM_PATTERN_SEL_128		(0x1 << 5)
+#define RT5651_PDM_VOL_MASK			(0x1 << 4)
+#define RT5651_PDM_VOL_SFT			4
+#define RT5651_PDM_DIV_MASK			(0x3)
+#define RT5651_PDM_DIV_SFT			0
+#define RT5651_PDM_DIV_1			0
+#define RT5651_PDM_DIV_2			1
+#define RT5651_PDM_DIV_3			2
+#define RT5651_PDM_DIV_4			3
+
+/* PDM I2C/Data Control 1 (0x31) */
+#define RT5651_PDM_I2C_ID_MASK			(0xf << 12)
+#define PT5631_PDM_CMD_EXE			(0x1 << 11)
+#define RT5651_PDM_I2C_CMD_MASK			(0x1 << 10)
+#define RT5651_PDM_I2C_CMD_R			(0x0 << 10)
+#define RT5651_PDM_I2C_CMD_W			(0x1 << 10)
+#define RT5651_PDM_I2C_CMD_EXE			(0x1 << 9)
+#define RT5651_PDM_I2C_NORMAL			(0x0 << 8)
+#define RT5651_PDM_I2C_BUSY			(0x1 << 8)
+
+/* PDM I2C/Data Control 2 (0x32) */
+#define RT5651_PDM_I2C_ADDR			(0xff << 8)
+#define RT5651_PDM_I2C_CMD_PATTERN		(0xff)
+
+
+/* REC Left Mixer Control 1 (0x3b) */
+#define RT5651_G_LN_L2_RM_L_MASK		(0x7 << 13)
+#define RT5651_G_IN_L2_RM_L_SFT			13
+#define RT5651_G_LN_L1_RM_L_MASK		(0x7 << 10)
+#define RT5651_G_IN_L1_RM_L_SFT			10
+#define RT5651_G_BST3_RM_L_MASK			(0x7 << 4)
+#define RT5651_G_BST3_RM_L_SFT			4
+#define RT5651_G_BST2_RM_L_MASK			(0x7 << 1)
+#define RT5651_G_BST2_RM_L_SFT			1
+
+/* REC Left Mixer Control 2 (0x3c) */
+#define RT5651_G_BST1_RM_L_MASK			(0x7 << 13)
+#define RT5651_G_BST1_RM_L_SFT			13
+#define RT5651_G_OM_L_RM_L_MASK			(0x7 << 10)
+#define RT5651_G_OM_L_RM_L_SFT			10
+#define RT5651_M_IN2_L_RM_L			(0x1 << 6)
+#define RT5651_M_IN2_L_RM_L_SFT			6
+#define RT5651_M_IN1_L_RM_L			(0x1 << 5)
+#define RT5651_M_IN1_L_RM_L_SFT			5
+#define RT5651_M_BST3_RM_L			(0x1 << 3)
+#define RT5651_M_BST3_RM_L_SFT			3
+#define RT5651_M_BST2_RM_L			(0x1 << 2)
+#define RT5651_M_BST2_RM_L_SFT			2
+#define RT5651_M_BST1_RM_L			(0x1 << 1)
+#define RT5651_M_BST1_RM_L_SFT			1
+#define RT5651_M_OM_L_RM_L			(0x1)
+#define RT5651_M_OM_L_RM_L_SFT			0
+
+/* REC Right Mixer Control 1 (0x3d) */
+#define RT5651_G_IN2_R_RM_R_MASK		(0x7 << 13)
+#define RT5651_G_IN2_R_RM_R_SFT			13
+#define RT5651_G_IN1_R_RM_R_MASK		(0x7 << 10)
+#define RT5651_G_IN1_R_RM_R_SFT			10
+#define RT5651_G_BST3_RM_R_MASK			(0x7 << 4)
+#define RT5651_G_BST3_RM_R_SFT			4
+#define RT5651_G_BST2_RM_R_MASK			(0x7 << 1)
+#define RT5651_G_BST2_RM_R_SFT			1
+
+/* REC Right Mixer Control 2 (0x3e) */
+#define RT5651_G_BST1_RM_R_MASK			(0x7 << 13)
+#define RT5651_G_BST1_RM_R_SFT			13
+#define RT5651_G_OM_R_RM_R_MASK			(0x7 << 10)
+#define RT5651_G_OM_R_RM_R_SFT			10
+#define RT5651_M_IN2_R_RM_R			(0x1 << 6)
+#define RT5651_M_IN2_R_RM_R_SFT			6
+#define RT5651_M_IN1_R_RM_R			(0x1 << 5)
+#define RT5651_M_IN1_R_RM_R_SFT			5
+#define RT5651_M_BST3_RM_R			(0x1 << 3)
+#define RT5651_M_BST3_RM_R_SFT			3
+#define RT5651_M_BST2_RM_R			(0x1 << 2)
+#define RT5651_M_BST2_RM_R_SFT			2
+#define RT5651_M_BST1_RM_R			(0x1 << 1)
+#define RT5651_M_BST1_RM_R_SFT			1
+#define RT5651_M_OM_R_RM_R			(0x1)
+#define RT5651_M_OM_R_RM_R_SFT			0
+
+/* HPMIX Control (0x45) */
+#define RT5651_M_DAC1_HM			(0x1 << 14)
+#define RT5651_M_DAC1_HM_SFT			14
+#define RT5651_M_HPVOL_HM			(0x1 << 13)
+#define RT5651_M_HPVOL_HM_SFT			13
+#define RT5651_G_HPOMIX_MASK			(0x1 << 12)
+#define RT5651_G_HPOMIX_SFT			12
+
+/* SPK Left Mixer Control (0x46) */
+#define RT5651_G_RM_L_SM_L_MASK			(0x3 << 14)
+#define RT5651_G_RM_L_SM_L_SFT			14
+#define RT5651_G_IN_L_SM_L_MASK			(0x3 << 12)
+#define RT5651_G_IN_L_SM_L_SFT			12
+#define RT5651_G_DAC_L1_SM_L_MASK		(0x3 << 10)
+#define RT5651_G_DAC_L1_SM_L_SFT		10
+#define RT5651_G_DAC_L2_SM_L_MASK		(0x3 << 8)
+#define RT5651_G_DAC_L2_SM_L_SFT		8
+#define RT5651_G_OM_L_SM_L_MASK			(0x3 << 6)
+#define RT5651_G_OM_L_SM_L_SFT			6
+#define RT5651_M_RM_L_SM_L			(0x1 << 5)
+#define RT5651_M_RM_L_SM_L_SFT			5
+#define RT5651_M_IN_L_SM_L			(0x1 << 4)
+#define RT5651_M_IN_L_SM_L_SFT			4
+#define RT5651_M_DAC_L1_SM_L			(0x1 << 3)
+#define RT5651_M_DAC_L1_SM_L_SFT		3
+#define RT5651_M_DAC_L2_SM_L			(0x1 << 2)
+#define RT5651_M_DAC_L2_SM_L_SFT		2
+#define RT5651_M_OM_L_SM_L			(0x1 << 1)
+#define RT5651_M_OM_L_SM_L_SFT			1
+
+/* SPK Right Mixer Control (0x47) */
+#define RT5651_G_RM_R_SM_R_MASK			(0x3 << 14)
+#define RT5651_G_RM_R_SM_R_SFT			14
+#define RT5651_G_IN_R_SM_R_MASK			(0x3 << 12)
+#define RT5651_G_IN_R_SM_R_SFT			12
+#define RT5651_G_DAC_R1_SM_R_MASK		(0x3 << 10)
+#define RT5651_G_DAC_R1_SM_R_SFT		10
+#define RT5651_G_DAC_R2_SM_R_MASK		(0x3 << 8)
+#define RT5651_G_DAC_R2_SM_R_SFT		8
+#define RT5651_G_OM_R_SM_R_MASK			(0x3 << 6)
+#define RT5651_G_OM_R_SM_R_SFT			6
+#define RT5651_M_RM_R_SM_R			(0x1 << 5)
+#define RT5651_M_RM_R_SM_R_SFT			5
+#define RT5651_M_IN_R_SM_R			(0x1 << 4)
+#define RT5651_M_IN_R_SM_R_SFT			4
+#define RT5651_M_DAC_R1_SM_R			(0x1 << 3)
+#define RT5651_M_DAC_R1_SM_R_SFT		3
+#define RT5651_M_DAC_R2_SM_R			(0x1 << 2)
+#define RT5651_M_DAC_R2_SM_R_SFT		2
+#define RT5651_M_OM_R_SM_R			(0x1 << 1)
+#define RT5651_M_OM_R_SM_R_SFT			1
+
+/* SPOLMIX Control (0x48) */
+#define RT5651_M_DAC_R1_SPM_L			(0x1 << 15)
+#define RT5651_M_DAC_R1_SPM_L_SFT		15
+#define RT5651_M_DAC_L1_SPM_L			(0x1 << 14)
+#define RT5651_M_DAC_L1_SPM_L_SFT		14
+#define RT5651_M_SV_R_SPM_L			(0x1 << 13)
+#define RT5651_M_SV_R_SPM_L_SFT			13
+#define RT5651_M_SV_L_SPM_L			(0x1 << 12)
+#define RT5651_M_SV_L_SPM_L_SFT			12
+#define RT5651_M_BST1_SPM_L			(0x1 << 11)
+#define RT5651_M_BST1_SPM_L_SFT			11
+
+/* SPORMIX Control (0x49) */
+#define RT5651_M_DAC_R1_SPM_R			(0x1 << 13)
+#define RT5651_M_DAC_R1_SPM_R_SFT		13
+#define RT5651_M_SV_R_SPM_R			(0x1 << 12)
+#define RT5651_M_SV_R_SPM_R_SFT			12
+#define RT5651_M_BST1_SPM_R			(0x1 << 11)
+#define RT5651_M_BST1_SPM_R_SFT			11
+
+/* SPOLMIX / SPORMIX Ratio Control (0x4a) */
+#define RT5651_SPO_CLSD_RATIO_MASK		(0x7)
+#define RT5651_SPO_CLSD_RATIO_SFT		0
+
+/* Mono Output Mixer Control (0x4c) */
+#define RT5651_M_DAC_R2_MM			(0x1 << 15)
+#define RT5651_M_DAC_R2_MM_SFT			15
+#define RT5651_M_DAC_L2_MM			(0x1 << 14)
+#define RT5651_M_DAC_L2_MM_SFT			14
+#define RT5651_M_OV_R_MM			(0x1 << 13)
+#define RT5651_M_OV_R_MM_SFT			13
+#define RT5651_M_OV_L_MM			(0x1 << 12)
+#define RT5651_M_OV_L_MM_SFT			12
+#define RT5651_M_BST1_MM			(0x1 << 11)
+#define RT5651_M_BST1_MM_SFT			11
+#define RT5651_G_MONOMIX_MASK			(0x1 << 10)
+#define RT5651_G_MONOMIX_SFT			10
+
+/* Output Left Mixer Control 1 (0x4d) */
+#define RT5651_G_BST2_OM_L_MASK			(0x7 << 10)
+#define RT5651_G_BST2_OM_L_SFT			10
+#define RT5651_G_BST1_OM_L_MASK			(0x7 << 7)
+#define RT5651_G_BST1_OM_L_SFT			7
+#define RT5651_G_IN1_L_OM_L_MASK		(0x7 << 4)
+#define RT5651_G_IN1_L_OM_L_SFT			4
+#define RT5651_G_RM_L_OM_L_MASK			(0x7 << 1)
+#define RT5651_G_RM_L_OM_L_SFT			1
+
+/* Output Left Mixer Control 2 (0x4e) */
+#define RT5651_G_DAC_L1_OM_L_MASK		(0x7 << 7)
+#define RT5651_G_DAC_L1_OM_L_SFT		7
+#define RT5651_G_IN2_L_OM_L_MASK		(0x7 << 4)
+#define RT5651_G_IN2_L_OM_L_SFT			4
+
+/* Output Left Mixer Control 3 (0x4f) */
+#define RT5651_M_IN2_L_OM_L			(0x1 << 9)
+#define RT5651_M_IN2_L_OM_L_SFT			9
+#define RT5651_M_BST2_OM_L			(0x1 << 6)
+#define RT5651_M_BST2_OM_L_SFT			6
+#define RT5651_M_BST1_OM_L			(0x1 << 5)
+#define RT5651_M_BST1_OM_L_SFT			5
+#define RT5651_M_IN1_L_OM_L			(0x1 << 4)
+#define RT5651_M_IN1_L_OM_L_SFT			4
+#define RT5651_M_RM_L_OM_L			(0x1 << 3)
+#define RT5651_M_RM_L_OM_L_SFT			3
+#define RT5651_M_DAC_L1_OM_L			(0x1)
+#define RT5651_M_DAC_L1_OM_L_SFT		0
+
+/* Output Right Mixer Control 1 (0x50) */
+#define RT5651_G_BST2_OM_R_MASK			(0x7 << 10)
+#define RT5651_G_BST2_OM_R_SFT			10
+#define RT5651_G_BST1_OM_R_MASK			(0x7 << 7)
+#define RT5651_G_BST1_OM_R_SFT			7
+#define RT5651_G_IN1_R_OM_R_MASK		(0x7 << 4)
+#define RT5651_G_IN1_R_OM_R_SFT			4
+#define RT5651_G_RM_R_OM_R_MASK			(0x7 << 1)
+#define RT5651_G_RM_R_OM_R_SFT			1
+
+/* Output Right Mixer Control 2 (0x51) */
+#define RT5651_G_DAC_R1_OM_R_MASK		(0x7 << 7)
+#define RT5651_G_DAC_R1_OM_R_SFT		7
+#define RT5651_G_IN2_R_OM_R_MASK		(0x7 << 4)
+#define RT5651_G_IN2_R_OM_R_SFT			4
+
+/* Output Right Mixer Control 3 (0x52) */
+#define RT5651_M_IN2_R_OM_R			(0x1 << 9)
+#define RT5651_M_IN2_R_OM_R_SFT			9
+#define RT5651_M_BST2_OM_R			(0x1 << 6)
+#define RT5651_M_BST2_OM_R_SFT			6
+#define RT5651_M_BST1_OM_R			(0x1 << 5)
+#define RT5651_M_BST1_OM_R_SFT			5
+#define RT5651_M_IN1_R_OM_R			(0x1 << 4)
+#define RT5651_M_IN1_R_OM_R_SFT			4
+#define RT5651_M_RM_R_OM_R			(0x1 << 3)
+#define RT5651_M_RM_R_OM_R_SFT			3
+#define RT5651_M_DAC_R1_OM_R			(0x1)
+#define RT5651_M_DAC_R1_OM_R_SFT		0
+
+/* LOUT Mixer Control (0x53) */
+#define RT5651_M_DAC_L1_LM			(0x1 << 15)
+#define RT5651_M_DAC_L1_LM_SFT			15
+#define RT5651_M_DAC_R1_LM			(0x1 << 14)
+#define RT5651_M_DAC_R1_LM_SFT			14
+#define RT5651_M_OV_L_LM			(0x1 << 13)
+#define RT5651_M_OV_L_LM_SFT			13
+#define RT5651_M_OV_R_LM			(0x1 << 12)
+#define RT5651_M_OV_R_LM_SFT			12
+#define RT5651_G_LOUTMIX_MASK			(0x1 << 11)
+#define RT5651_G_LOUTMIX_SFT			11
+
+/* Power Management for Digital 1 (0x61) */
+#define RT5651_PWR_I2S1				(0x1 << 15)
+#define RT5651_PWR_I2S1_BIT			15
+#define RT5651_PWR_I2S2				(0x1 << 14)
+#define RT5651_PWR_I2S2_BIT			14
+#define RT5651_PWR_DAC_L1			(0x1 << 12)
+#define RT5651_PWR_DAC_L1_BIT			12
+#define RT5651_PWR_DAC_R1			(0x1 << 11)
+#define RT5651_PWR_DAC_R1_BIT			11
+#define RT5651_PWR_ADC_L			(0x1 << 2)
+#define RT5651_PWR_ADC_L_BIT			2
+#define RT5651_PWR_ADC_R			(0x1 << 1)
+#define RT5651_PWR_ADC_R_BIT			1
+
+/* Power Management for Digital 2 (0x62) */
+#define RT5651_PWR_ADC_STO1_F			(0x1 << 15)
+#define RT5651_PWR_ADC_STO1_F_BIT			15
+#define RT5651_PWR_ADC_STO2_F			(0x1 << 14)
+#define RT5651_PWR_ADC_STO2_F_BIT		14
+#define RT5651_PWR_DAC_STO1_F			(0x1 << 11)
+#define RT5651_PWR_DAC_STO1_F_BIT			11
+#define RT5651_PWR_DAC_STO2_F			(0x1 << 10)
+#define RT5651_PWR_DAC_STO2_F_BIT		10
+#define RT5651_PWR_PDM				(0x1 << 9)
+#define RT5651_PWR_PDM_BIT			9
+
+/* Power Management for Analog 1 (0x63) */
+#define RT5651_PWR_VREF1			(0x1 << 15)
+#define RT5651_PWR_VREF1_BIT			15
+#define RT5651_PWR_FV1				(0x1 << 14)
+#define RT5651_PWR_FV1_BIT			14
+#define RT5651_PWR_MB				(0x1 << 13)
+#define RT5651_PWR_MB_BIT			13
+#define RT5651_PWR_LM				(0x1 << 12)
+#define RT5651_PWR_LM_BIT			12
+#define RT5651_PWR_BG				(0x1 << 11)
+#define RT5651_PWR_BG_BIT			11
+#define RT5651_PWR_HP_L				(0x1 << 7)
+#define RT5651_PWR_HP_L_BIT			7
+#define RT5651_PWR_HP_R				(0x1 << 6)
+#define RT5651_PWR_HP_R_BIT			6
+#define RT5651_PWR_HA				(0x1 << 5)
+#define RT5651_PWR_HA_BIT			5
+#define RT5651_PWR_VREF2			(0x1 << 4)
+#define RT5651_PWR_VREF2_BIT			4
+#define RT5651_PWR_FV2				(0x1 << 3)
+#define RT5651_PWR_FV2_BIT			3
+#define RT5651_PWR_LDO				(0x1 << 2)
+#define RT5651_PWR_LDO_BIT			2
+#define RT5651_PWR_LDO_DVO_MASK			(0x3)
+#define RT5651_PWR_LDO_DVO_1_0V			0
+#define RT5651_PWR_LDO_DVO_1_1V			1
+#define RT5651_PWR_LDO_DVO_1_2V			2
+#define RT5651_PWR_LDO_DVO_1_3V			3
+
+/* Power Management for Analog 2 (0x64) */
+#define RT5651_PWR_BST1				(0x1 << 15)
+#define RT5651_PWR_BST1_BIT			15
+#define RT5651_PWR_BST2				(0x1 << 14)
+#define RT5651_PWR_BST2_BIT			14
+#define RT5651_PWR_BST3				(0x1 << 13)
+#define RT5651_PWR_BST3_BIT			13
+#define RT5651_PWR_MB1				(0x1 << 11)
+#define RT5651_PWR_MB1_BIT			11
+#define RT5651_PWR_PLL				(0x1 << 9)
+#define RT5651_PWR_PLL_BIT			9
+#define RT5651_PWR_BST1_OP2			(0x1 << 5)
+#define RT5651_PWR_BST1_OP2_BIT			5
+#define RT5651_PWR_BST2_OP2			(0x1 << 4)
+#define RT5651_PWR_BST2_OP2_BIT			4
+#define RT5651_PWR_BST3_OP2			(0x1 << 3)
+#define RT5651_PWR_BST3_OP2_BIT			3
+#define RT5651_PWR_JD_M				(0x1 << 2)
+#define RT5651_PWM_JD_M_BIT			2
+#define RT5651_PWR_JD2				(0x1 << 1)
+#define RT5651_PWM_JD2_BIT			1
+#define RT5651_PWR_JD3				(0x1)
+#define RT5651_PWM_JD3_BIT			0
+
+/* Power Management for Mixer (0x65) */
+#define RT5651_PWR_OM_L				(0x1 << 15)
+#define RT5651_PWR_OM_L_BIT			15
+#define RT5651_PWR_OM_R				(0x1 << 14)
+#define RT5651_PWR_OM_R_BIT			14
+#define RT5651_PWR_RM_L				(0x1 << 11)
+#define RT5651_PWR_RM_L_BIT			11
+#define RT5651_PWR_RM_R				(0x1 << 10)
+#define RT5651_PWR_RM_R_BIT			10
+
+/* Power Management for Volume (0x66) */
+#define RT5651_PWR_OV_L				(0x1 << 13)
+#define RT5651_PWR_OV_L_BIT			13
+#define RT5651_PWR_OV_R				(0x1 << 12)
+#define RT5651_PWR_OV_R_BIT			12
+#define RT5651_PWR_HV_L				(0x1 << 11)
+#define RT5651_PWR_HV_L_BIT			11
+#define RT5651_PWR_HV_R				(0x1 << 10)
+#define RT5651_PWR_HV_R_BIT			10
+#define RT5651_PWR_IN1_L			(0x1 << 9)
+#define RT5651_PWR_IN1_L_BIT			9
+#define RT5651_PWR_IN1_R			(0x1 << 8)
+#define RT5651_PWR_IN1_R_BIT			8
+#define RT5651_PWR_IN2_L			(0x1 << 7)
+#define RT5651_PWR_IN2_L_BIT			7
+#define RT5651_PWR_IN2_R			(0x1 << 6)
+#define RT5651_PWR_IN2_R_BIT			6
+
+/* I2S1/2/3 Audio Serial Data Port Control (0x70 0x71) */
+#define RT5651_I2S_MS_MASK			(0x1 << 15)
+#define RT5651_I2S_MS_SFT			15
+#define RT5651_I2S_MS_M				(0x0 << 15)
+#define RT5651_I2S_MS_S				(0x1 << 15)
+#define RT5651_I2S_O_CP_MASK			(0x3 << 10)
+#define RT5651_I2S_O_CP_SFT			10
+#define RT5651_I2S_O_CP_OFF			(0x0 << 10)
+#define RT5651_I2S_O_CP_U_LAW			(0x1 << 10)
+#define RT5651_I2S_O_CP_A_LAW			(0x2 << 10)
+#define RT5651_I2S_I_CP_MASK			(0x3 << 8)
+#define RT5651_I2S_I_CP_SFT			8
+#define RT5651_I2S_I_CP_OFF			(0x0 << 8)
+#define RT5651_I2S_I_CP_U_LAW			(0x1 << 8)
+#define RT5651_I2S_I_CP_A_LAW			(0x2 << 8)
+#define RT5651_I2S_BP_MASK			(0x1 << 7)
+#define RT5651_I2S_BP_SFT			7
+#define RT5651_I2S_BP_NOR			(0x0 << 7)
+#define RT5651_I2S_BP_INV			(0x1 << 7)
+#define RT5651_I2S_DL_MASK			(0x3 << 2)
+#define RT5651_I2S_DL_SFT			2
+#define RT5651_I2S_DL_16			(0x0 << 2)
+#define RT5651_I2S_DL_20			(0x1 << 2)
+#define RT5651_I2S_DL_24			(0x2 << 2)
+#define RT5651_I2S_DL_8				(0x3 << 2)
+#define RT5651_I2S_DF_MASK			(0x3)
+#define RT5651_I2S_DF_SFT			0
+#define RT5651_I2S_DF_I2S			(0x0)
+#define RT5651_I2S_DF_LEFT			(0x1)
+#define RT5651_I2S_DF_PCM_A			(0x2)
+#define RT5651_I2S_DF_PCM_B			(0x3)
+
+/* ADC/DAC Clock Control 1 (0x73) */
+#define RT5651_I2S_PD1_MASK			(0x7 << 12)
+#define RT5651_I2S_PD1_SFT			12
+#define RT5651_I2S_PD1_1			(0x0 << 12)
+#define RT5651_I2S_PD1_2			(0x1 << 12)
+#define RT5651_I2S_PD1_3			(0x2 << 12)
+#define RT5651_I2S_PD1_4			(0x3 << 12)
+#define RT5651_I2S_PD1_6			(0x4 << 12)
+#define RT5651_I2S_PD1_8			(0x5 << 12)
+#define RT5651_I2S_PD1_12			(0x6 << 12)
+#define RT5651_I2S_PD1_16			(0x7 << 12)
+#define RT5651_I2S_BCLK_MS2_MASK		(0x1 << 11)
+#define RT5651_I2S_BCLK_MS2_SFT			11
+#define RT5651_I2S_BCLK_MS2_32			(0x0 << 11)
+#define RT5651_I2S_BCLK_MS2_64			(0x1 << 11)
+#define RT5651_I2S_PD2_MASK			(0x7 << 8)
+#define RT5651_I2S_PD2_SFT			8
+#define RT5651_I2S_PD2_1			(0x0 << 8)
+#define RT5651_I2S_PD2_2			(0x1 << 8)
+#define RT5651_I2S_PD2_3			(0x2 << 8)
+#define RT5651_I2S_PD2_4			(0x3 << 8)
+#define RT5651_I2S_PD2_6			(0x4 << 8)
+#define RT5651_I2S_PD2_8			(0x5 << 8)
+#define RT5651_I2S_PD2_12			(0x6 << 8)
+#define RT5651_I2S_PD2_16			(0x7 << 8)
+#define RT5651_DAC_OSR_MASK			(0x3 << 2)
+#define RT5651_DAC_OSR_SFT			2
+#define RT5651_DAC_OSR_128			(0x0 << 2)
+#define RT5651_DAC_OSR_64			(0x1 << 2)
+#define RT5651_DAC_OSR_32			(0x2 << 2)
+#define RT5651_DAC_OSR_128_3			(0x3 << 2)
+#define RT5651_ADC_OSR_MASK			(0x3)
+#define RT5651_ADC_OSR_SFT			0
+#define RT5651_ADC_OSR_128			(0x0)
+#define RT5651_ADC_OSR_64			(0x1)
+#define RT5651_ADC_OSR_32			(0x2)
+#define RT5651_ADC_OSR_128_3			(0x3)
+
+/* ADC/DAC Clock Control 2 (0x74) */
+#define RT5651_DAHPF_EN				(0x1 << 11)
+#define RT5651_DAHPF_EN_SFT			11
+#define RT5651_ADHPF_EN				(0x1 << 10)
+#define RT5651_ADHPF_EN_SFT			10
+
+/* Digital Microphone Control (0x75) */
+#define RT5651_DMIC_1_EN_MASK			(0x1 << 15)
+#define RT5651_DMIC_1_EN_SFT			15
+#define RT5651_DMIC_1_DIS			(0x0 << 15)
+#define RT5651_DMIC_1_EN			(0x1 << 15)
+#define RT5651_DMIC_1L_LH_MASK			(0x1 << 13)
+#define RT5651_DMIC_1L_LH_SFT			13
+#define RT5651_DMIC_1L_LH_FALLING		(0x0 << 13)
+#define RT5651_DMIC_1L_LH_RISING		(0x1 << 13)
+#define RT5651_DMIC_1R_LH_MASK			(0x1 << 12)
+#define RT5651_DMIC_1R_LH_SFT			12
+#define RT5651_DMIC_1R_LH_FALLING		(0x0 << 12)
+#define RT5651_DMIC_1R_LH_RISING		(0x1 << 12)
+#define RT5651_DMIC_1_DP_MASK			(0x3 << 10)
+#define RT5651_DMIC_1_DP_SFT			10
+#define RT5651_DMIC_1_DP_GPIO6			(0x0 << 10)
+#define RT5651_DMIC_1_DP_IN1P			(0x1 << 10)
+#define RT5651_DMIC_2_DP_GPIO8			(0x2 << 10)
+#define RT5651_DMIC_CLK_MASK			(0x7 << 5)
+#define RT5651_DMIC_CLK_SFT			5
+
+/* TDM Control 1 (0x77) */
+#define RT5651_TDM_INTEL_SEL_MASK		(0x1 << 15)
+#define RT5651_TDM_INTEL_SEL_SFT		15
+#define RT5651_TDM_INTEL_SEL_64			(0x0 << 15)
+#define RT5651_TDM_INTEL_SEL_50			(0x1 << 15)
+#define RT5651_TDM_MODE_SEL_MASK		(0x1 << 14)
+#define RT5651_TDM_MODE_SEL_SFT			14
+#define RT5651_TDM_MODE_SEL_NOR			(0x0 << 14)
+#define RT5651_TDM_MODE_SEL_TDM			(0x1 << 14)
+#define RT5651_TDM_CH_NUM_SEL_MASK		(0x3 << 12)
+#define RT5651_TDM_CH_NUM_SEL_SFT		12
+#define RT5651_TDM_CH_NUM_SEL_2			(0x0 << 12)
+#define RT5651_TDM_CH_NUM_SEL_4			(0x1 << 12)
+#define RT5651_TDM_CH_NUM_SEL_6			(0x2 << 12)
+#define RT5651_TDM_CH_NUM_SEL_8			(0x3 << 12)
+#define RT5651_TDM_CH_LEN_SEL_MASK		(0x3 << 10)
+#define RT5651_TDM_CH_LEN_SEL_SFT		10
+#define RT5651_TDM_CH_LEN_SEL_16		(0x0 << 10)
+#define RT5651_TDM_CH_LEN_SEL_20		(0x1 << 10)
+#define RT5651_TDM_CH_LEN_SEL_24		(0x2 << 10)
+#define RT5651_TDM_CH_LEN_SEL_32		(0x3 << 10)
+#define RT5651_TDM_ADC_SEL_MASK			(0x1 << 9)
+#define RT5651_TDM_ADC_SEL_SFT			9
+#define RT5651_TDM_ADC_SEL_NOR			(0x0 << 9)
+#define RT5651_TDM_ADC_SEL_SWAP			(0x1 << 9)
+#define RT5651_TDM_ADC_START_SEL_MASK		(0x1 << 8)
+#define RT5651_TDM_ADC_START_SEL_SFT		8
+#define RT5651_TDM_ADC_START_SEL_SL0		(0x0 << 8)
+#define RT5651_TDM_ADC_START_SEL_SL4		(0x1 << 8)
+#define RT5651_TDM_I2S_CH2_SEL_MASK		(0x3 << 6)
+#define RT5651_TDM_I2S_CH2_SEL_SFT		6
+#define RT5651_TDM_I2S_CH2_SEL_LR		(0x0 << 6)
+#define RT5651_TDM_I2S_CH2_SEL_RL		(0x1 << 6)
+#define RT5651_TDM_I2S_CH2_SEL_LL		(0x2 << 6)
+#define RT5651_TDM_I2S_CH2_SEL_RR		(0x3 << 6)
+#define RT5651_TDM_I2S_CH4_SEL_MASK		(0x3 << 4)
+#define RT5651_TDM_I2S_CH4_SEL_SFT		4
+#define RT5651_TDM_I2S_CH4_SEL_LR		(0x0 << 4)
+#define RT5651_TDM_I2S_CH4_SEL_RL		(0x1 << 4)
+#define RT5651_TDM_I2S_CH4_SEL_LL		(0x2 << 4)
+#define RT5651_TDM_I2S_CH4_SEL_RR		(0x3 << 4)
+#define RT5651_TDM_I2S_CH6_SEL_MASK		(0x3 << 2)
+#define RT5651_TDM_I2S_CH6_SEL_SFT		2
+#define RT5651_TDM_I2S_CH6_SEL_LR		(0x0 << 2)
+#define RT5651_TDM_I2S_CH6_SEL_RL		(0x1 << 2)
+#define RT5651_TDM_I2S_CH6_SEL_LL		(0x2 << 2)
+#define RT5651_TDM_I2S_CH6_SEL_RR		(0x3 << 2)
+#define RT5651_TDM_I2S_CH8_SEL_MASK		(0x3)
+#define RT5651_TDM_I2S_CH8_SEL_SFT		0
+#define RT5651_TDM_I2S_CH8_SEL_LR		(0x0)
+#define RT5651_TDM_I2S_CH8_SEL_RL		(0x1)
+#define RT5651_TDM_I2S_CH8_SEL_LL		(0x2)
+#define RT5651_TDM_I2S_CH8_SEL_RR		(0x3)
+
+/* TDM Control 2 (0x78) */
+#define RT5651_TDM_LRCK_POL_SEL_MASK		(0x1 << 15)
+#define RT5651_TDM_LRCK_POL_SEL_SFT		15
+#define RT5651_TDM_LRCK_POL_SEL_NOR		(0x0 << 15)
+#define RT5651_TDM_LRCK_POL_SEL_INV		(0x1 << 15)
+#define RT5651_TDM_CH_VAL_SEL_MASK		(0x1 << 14)
+#define RT5651_TDM_CH_VAL_SEL_SFT		14
+#define RT5651_TDM_CH_VAL_SEL_CH01		(0x0 << 14)
+#define RT5651_TDM_CH_VAL_SEL_CH0123		(0x1 << 14)
+#define RT5651_TDM_CH_VAL_EN			(0x1 << 13)
+#define RT5651_TDM_CH_VAL_SFT			13
+#define RT5651_TDM_LPBK_EN			(0x1 << 12)
+#define RT5651_TDM_LPBK_SFT			12
+#define RT5651_TDM_LRCK_PULSE_SEL_MASK		(0x1 << 11)
+#define RT5651_TDM_LRCK_PULSE_SEL_SFT		11
+#define RT5651_TDM_LRCK_PULSE_SEL_BCLK		(0x0 << 11)
+#define RT5651_TDM_LRCK_PULSE_SEL_CH		(0x1 << 11)
+#define RT5651_TDM_END_EDGE_SEL_MASK		(0x1 << 10)
+#define RT5651_TDM_END_EDGE_SEL_SFT		10
+#define RT5651_TDM_END_EDGE_SEL_POS		(0x0 << 10)
+#define RT5651_TDM_END_EDGE_SEL_NEG		(0x1 << 10)
+#define RT5651_TDM_END_EDGE_EN			(0x1 << 9)
+#define RT5651_TDM_END_EDGE_EN_SFT		9
+#define RT5651_TDM_TRAN_EDGE_SEL_MASK		(0x1 << 8)
+#define RT5651_TDM_TRAN_EDGE_SEL_SFT		8
+#define RT5651_TDM_TRAN_EDGE_SEL_POS		(0x0 << 8)
+#define RT5651_TDM_TRAN_EDGE_SEL_NEG		(0x1 << 8)
+#define RT5651_M_TDM2_L				(0x1 << 7)
+#define RT5651_M_TDM2_L_SFT			7
+#define RT5651_M_TDM2_R				(0x1 << 6)
+#define RT5651_M_TDM2_R_SFT			6
+#define RT5651_M_TDM4_L				(0x1 << 5)
+#define RT5651_M_TDM4_L_SFT			5
+#define RT5651_M_TDM4_R				(0x1 << 4)
+#define RT5651_M_TDM4_R_SFT			4
+
+/* TDM Control 3 (0x79) */
+#define RT5651_CH2_L_SEL_MASK			(0x7 << 12)
+#define RT5651_CH2_L_SEL_SFT			12
+#define RT5651_CH2_L_SEL_SL0			(0x0 << 12)
+#define RT5651_CH2_L_SEL_SL1			(0x1 << 12)
+#define RT5651_CH2_L_SEL_SL2			(0x2 << 12)
+#define RT5651_CH2_L_SEL_SL3			(0x3 << 12)
+#define RT5651_CH2_L_SEL_SL4			(0x4 << 12)
+#define RT5651_CH2_L_SEL_SL5			(0x5 << 12)
+#define RT5651_CH2_L_SEL_SL6			(0x6 << 12)
+#define RT5651_CH2_L_SEL_SL7			(0x7 << 12)
+#define RT5651_CH2_R_SEL_MASK			(0x7 << 8)
+#define RT5651_CH2_R_SEL_SFT			8
+#define RT5651_CH2_R_SEL_SL0			(0x0 << 8)
+#define RT5651_CH2_R_SEL_SL1			(0x1 << 8)
+#define RT5651_CH2_R_SEL_SL2			(0x2 << 8)
+#define RT5651_CH2_R_SEL_SL3			(0x3 << 8)
+#define RT5651_CH2_R_SEL_SL4			(0x4 << 8)
+#define RT5651_CH2_R_SEL_SL5			(0x5 << 8)
+#define RT5651_CH2_R_SEL_SL6			(0x6 << 8)
+#define RT5651_CH2_R_SEL_SL7			(0x7 << 8)
+#define RT5651_CH4_L_SEL_MASK			(0x7 << 4)
+#define RT5651_CH4_L_SEL_SFT			4
+#define RT5651_CH4_L_SEL_SL0			(0x0 << 4)
+#define RT5651_CH4_L_SEL_SL1			(0x1 << 4)
+#define RT5651_CH4_L_SEL_SL2			(0x2 << 4)
+#define RT5651_CH4_L_SEL_SL3			(0x3 << 4)
+#define RT5651_CH4_L_SEL_SL4			(0x4 << 4)
+#define RT5651_CH4_L_SEL_SL5			(0x5 << 4)
+#define RT5651_CH4_L_SEL_SL6			(0x6 << 4)
+#define RT5651_CH4_L_SEL_SL7			(0x7 << 4)
+#define RT5651_CH4_R_SEL_MASK			(0x7)
+#define RT5651_CH4_R_SEL_SFT			0
+#define RT5651_CH4_R_SEL_SL0			(0x0)
+#define RT5651_CH4_R_SEL_SL1			(0x1)
+#define RT5651_CH4_R_SEL_SL2			(0x2)
+#define RT5651_CH4_R_SEL_SL3			(0x3)
+#define RT5651_CH4_R_SEL_SL4			(0x4)
+#define RT5651_CH4_R_SEL_SL5			(0x5)
+#define RT5651_CH4_R_SEL_SL6			(0x6)
+#define RT5651_CH4_R_SEL_SL7			(0x7)
+
+/* Global Clock Control (0x80) */
+#define RT5651_SCLK_SRC_MASK			(0x3 << 14)
+#define RT5651_SCLK_SRC_SFT			14
+#define RT5651_SCLK_SRC_MCLK			(0x0 << 14)
+#define RT5651_SCLK_SRC_PLL1			(0x1 << 14)
+#define RT5651_SCLK_SRC_RCCLK			(0x2 << 14)
+#define RT5651_PLL1_SRC_MASK			(0x3 << 12)
+#define RT5651_PLL1_SRC_SFT			12
+#define RT5651_PLL1_SRC_MCLK			(0x0 << 12)
+#define RT5651_PLL1_SRC_BCLK1			(0x1 << 12)
+#define RT5651_PLL1_SRC_BCLK2			(0x2 << 12)
+#define RT5651_PLL1_PD_MASK			(0x1 << 3)
+#define RT5651_PLL1_PD_SFT			3
+#define RT5651_PLL1_PD_1			(0x0 << 3)
+#define RT5651_PLL1_PD_2			(0x1 << 3)
+
+#define RT5651_PLL_INP_MAX			40000000
+#define RT5651_PLL_INP_MIN			256000
+/* PLL M/N/K Code Control 1 (0x81) */
+#define RT5651_PLL_N_MAX			0x1ff
+#define RT5651_PLL_N_MASK			(RT5651_PLL_N_MAX << 7)
+#define RT5651_PLL_N_SFT			7
+#define RT5651_PLL_K_MAX			0x1f
+#define RT5651_PLL_K_MASK			(RT5651_PLL_K_MAX)
+#define RT5651_PLL_K_SFT			0
+
+/* PLL M/N/K Code Control 2 (0x82) */
+#define RT5651_PLL_M_MAX			0xf
+#define RT5651_PLL_M_MASK			(RT5651_PLL_M_MAX << 12)
+#define RT5651_PLL_M_SFT			12
+#define RT5651_PLL_M_BP				(0x1 << 11)
+#define RT5651_PLL_M_BP_SFT			11
+
+/* PLL tracking mode 1 (0x83) */
+#define RT5651_STO1_T_MASK			(0x1 << 15)
+#define RT5651_STO1_T_SFT			15
+#define RT5651_STO1_T_SCLK			(0x0 << 15)
+#define RT5651_STO1_T_LRCK1			(0x1 << 15)
+#define RT5651_STO2_T_MASK			(0x1 << 12)
+#define RT5651_STO2_T_SFT			12
+#define RT5651_STO2_T_I2S2			(0x0 << 12)
+#define RT5651_STO2_T_LRCK2			(0x1 << 12)
+#define RT5651_ASRC2_REF_MASK			(0x1 << 11)
+#define RT5651_ASRC2_REF_SFT			11
+#define RT5651_ASRC2_REF_LRCK2			(0x0 << 11)
+#define RT5651_ASRC2_REF_LRCK1			(0x1 << 11)
+#define RT5651_DMIC_1_M_MASK			(0x1 << 9)
+#define RT5651_DMIC_1_M_SFT			9
+#define RT5651_DMIC_1_M_NOR			(0x0 << 9)
+#define RT5651_DMIC_1_M_ASYN			(0x1 << 9)
+
+/* PLL tracking mode 2 (0x84) */
+#define RT5651_STO1_ASRC_EN			(0x1 << 15)
+#define RT5651_STO1_ASRC_EN_SFT			15
+#define RT5651_STO2_ASRC_EN			(0x1 << 14)
+#define RT5651_STO2_ASRC_EN_SFT			14
+#define RT5651_STO1_DAC_M_MASK			(0x1 << 13)
+#define RT5651_STO1_DAC_M_SFT			13
+#define RT5651_STO1_DAC_M_NOR			(0x0 << 13)
+#define RT5651_STO1_DAC_M_ASRC			(0x1 << 13)
+#define RT5651_STO2_DAC_M_MASK			(0x1 << 12)
+#define RT5651_STO2_DAC_M_SFT			12
+#define RT5651_STO2_DAC_M_NOR			(0x0 << 12)
+#define RT5651_STO2_DAC_M_ASRC			(0x1 << 12)
+#define RT5651_ADC_M_MASK			(0x1 << 11)
+#define RT5651_ADC_M_SFT			11
+#define RT5651_ADC_M_NOR			(0x0 << 11)
+#define RT5651_ADC_M_ASRC			(0x1 << 11)
+#define RT5651_I2S1_R_D_MASK			(0x1 << 4)
+#define RT5651_I2S1_R_D_SFT			4
+#define RT5651_I2S1_R_D_DIS			(0x0 << 4)
+#define RT5651_I2S1_R_D_EN			(0x1 << 4)
+#define RT5651_I2S2_R_D_MASK			(0x1 << 3)
+#define RT5651_I2S2_R_D_SFT			3
+#define RT5651_I2S2_R_D_DIS			(0x0 << 3)
+#define RT5651_I2S2_R_D_EN			(0x1 << 3)
+#define RT5651_PRE_SCLK_MASK			(0x3)
+#define RT5651_PRE_SCLK_SFT			0
+#define RT5651_PRE_SCLK_512			(0x0)
+#define RT5651_PRE_SCLK_1024			(0x1)
+#define RT5651_PRE_SCLK_2048			(0x2)
+
+/* PLL tracking mode 3 (0x85) */
+#define RT5651_I2S1_RATE_MASK			(0xf << 12)
+#define RT5651_I2S1_RATE_SFT			12
+#define RT5651_I2S2_RATE_MASK			(0xf << 8)
+#define RT5651_I2S2_RATE_SFT			8
+#define RT5651_G_ASRC_LP_MASK			(0x1 << 3)
+#define RT5651_G_ASRC_LP_SFT			3
+#define RT5651_ASRC_LP_F_M			(0x1 << 2)
+#define RT5651_ASRC_LP_F_SFT			2
+#define RT5651_ASRC_LP_F_NOR			(0x0 << 2)
+#define RT5651_ASRC_LP_F_SB			(0x1 << 2)
+#define RT5651_FTK_PH_DET_MASK			(0x3)
+#define RT5651_FTK_PH_DET_SFT			0
+#define RT5651_FTK_PH_DET_DIV1			(0x0)
+#define RT5651_FTK_PH_DET_DIV2			(0x1)
+#define RT5651_FTK_PH_DET_DIV4			(0x2)
+#define RT5651_FTK_PH_DET_DIV8			(0x3)
+
+/*PLL tracking mode 6 (0x89) */
+#define RT5651_I2S1_PD_MASK			(0x7 << 12)
+#define RT5651_I2S1_PD_SFT			12
+#define RT5651_I2S2_PD_MASK			(0x7 << 8)
+#define RT5651_I2S2_PD_SFT			8
+
+/*PLL tracking mode 7 (0x8a) */
+#define RT5651_FSI1_RATE_MASK			(0xf << 12)
+#define RT5651_FSI1_RATE_SFT			12
+#define RT5651_FSI2_RATE_MASK			(0xf << 8)
+#define RT5651_FSI2_RATE_SFT			8
+
+/* HPOUT Over Current Detection (0x8b) */
+#define RT5651_HP_OVCD_MASK			(0x1 << 10)
+#define RT5651_HP_OVCD_SFT			10
+#define RT5651_HP_OVCD_DIS			(0x0 << 10)
+#define RT5651_HP_OVCD_EN			(0x1 << 10)
+#define RT5651_HP_OC_TH_MASK			(0x3 << 8)
+#define RT5651_HP_OC_TH_SFT			8
+#define RT5651_HP_OC_TH_90			(0x0 << 8)
+#define RT5651_HP_OC_TH_105			(0x1 << 8)
+#define RT5651_HP_OC_TH_120			(0x2 << 8)
+#define RT5651_HP_OC_TH_135			(0x3 << 8)
+
+/* Depop Mode Control 1 (0x8e) */
+#define RT5651_SMT_TRIG_MASK			(0x1 << 15)
+#define RT5651_SMT_TRIG_SFT			15
+#define RT5651_SMT_TRIG_DIS			(0x0 << 15)
+#define RT5651_SMT_TRIG_EN			(0x1 << 15)
+#define RT5651_HP_L_SMT_MASK			(0x1 << 9)
+#define RT5651_HP_L_SMT_SFT			9
+#define RT5651_HP_L_SMT_DIS			(0x0 << 9)
+#define RT5651_HP_L_SMT_EN			(0x1 << 9)
+#define RT5651_HP_R_SMT_MASK			(0x1 << 8)
+#define RT5651_HP_R_SMT_SFT			8
+#define RT5651_HP_R_SMT_DIS			(0x0 << 8)
+#define RT5651_HP_R_SMT_EN			(0x1 << 8)
+#define RT5651_HP_CD_PD_MASK			(0x1 << 7)
+#define RT5651_HP_CD_PD_SFT			7
+#define RT5651_HP_CD_PD_DIS			(0x0 << 7)
+#define RT5651_HP_CD_PD_EN			(0x1 << 7)
+#define RT5651_RSTN_MASK			(0x1 << 6)
+#define RT5651_RSTN_SFT				6
+#define RT5651_RSTN_DIS				(0x0 << 6)
+#define RT5651_RSTN_EN				(0x1 << 6)
+#define RT5651_RSTP_MASK			(0x1 << 5)
+#define RT5651_RSTP_SFT				5
+#define RT5651_RSTP_DIS				(0x0 << 5)
+#define RT5651_RSTP_EN				(0x1 << 5)
+#define RT5651_HP_CO_MASK			(0x1 << 4)
+#define RT5651_HP_CO_SFT			4
+#define RT5651_HP_CO_DIS			(0x0 << 4)
+#define RT5651_HP_CO_EN				(0x1 << 4)
+#define RT5651_HP_CP_MASK			(0x1 << 3)
+#define RT5651_HP_CP_SFT			3
+#define RT5651_HP_CP_PD				(0x0 << 3)
+#define RT5651_HP_CP_PU				(0x1 << 3)
+#define RT5651_HP_SG_MASK			(0x1 << 2)
+#define RT5651_HP_SG_SFT			2
+#define RT5651_HP_SG_DIS			(0x0 << 2)
+#define RT5651_HP_SG_EN				(0x1 << 2)
+#define RT5651_HP_DP_MASK			(0x1 << 1)
+#define RT5651_HP_DP_SFT			1
+#define RT5651_HP_DP_PD				(0x0 << 1)
+#define RT5651_HP_DP_PU				(0x1 << 1)
+#define RT5651_HP_CB_MASK			(0x1)
+#define RT5651_HP_CB_SFT			0
+#define RT5651_HP_CB_PD				(0x0)
+#define RT5651_HP_CB_PU				(0x1)
+
+/* Depop Mode Control 2 (0x8f) */
+#define RT5651_DEPOP_MASK			(0x1 << 13)
+#define RT5651_DEPOP_SFT			13
+#define RT5651_DEPOP_AUTO			(0x0 << 13)
+#define RT5651_DEPOP_MAN			(0x1 << 13)
+#define RT5651_RAMP_MASK			(0x1 << 12)
+#define RT5651_RAMP_SFT				12
+#define RT5651_RAMP_DIS				(0x0 << 12)
+#define RT5651_RAMP_EN				(0x1 << 12)
+#define RT5651_BPS_MASK				(0x1 << 11)
+#define RT5651_BPS_SFT				11
+#define RT5651_BPS_DIS				(0x0 << 11)
+#define RT5651_BPS_EN				(0x1 << 11)
+#define RT5651_FAST_UPDN_MASK			(0x1 << 10)
+#define RT5651_FAST_UPDN_SFT			10
+#define RT5651_FAST_UPDN_DIS			(0x0 << 10)
+#define RT5651_FAST_UPDN_EN			(0x1 << 10)
+#define RT5651_MRES_MASK			(0x3 << 8)
+#define RT5651_MRES_SFT				8
+#define RT5651_MRES_15MO			(0x0 << 8)
+#define RT5651_MRES_25MO			(0x1 << 8)
+#define RT5651_MRES_35MO			(0x2 << 8)
+#define RT5651_MRES_45MO			(0x3 << 8)
+#define RT5651_VLO_MASK				(0x1 << 7)
+#define RT5651_VLO_SFT				7
+#define RT5651_VLO_3V				(0x0 << 7)
+#define RT5651_VLO_32V				(0x1 << 7)
+#define RT5651_DIG_DP_MASK			(0x1 << 6)
+#define RT5651_DIG_DP_SFT			6
+#define RT5651_DIG_DP_DIS			(0x0 << 6)
+#define RT5651_DIG_DP_EN			(0x1 << 6)
+#define RT5651_DP_TH_MASK			(0x3 << 4)
+#define RT5651_DP_TH_SFT			4
+
+/* Depop Mode Control 3 (0x90) */
+#define RT5651_CP_SYS_MASK			(0x7 << 12)
+#define RT5651_CP_SYS_SFT			12
+#define RT5651_CP_FQ1_MASK			(0x7 << 8)
+#define RT5651_CP_FQ1_SFT			8
+#define RT5651_CP_FQ2_MASK			(0x7 << 4)
+#define RT5651_CP_FQ2_SFT			4
+#define RT5651_CP_FQ3_MASK			(0x7)
+#define RT5651_CP_FQ3_SFT			0
+#define RT5651_CP_FQ_1_5_KHZ			0
+#define RT5651_CP_FQ_3_KHZ			1
+#define RT5651_CP_FQ_6_KHZ			2
+#define RT5651_CP_FQ_12_KHZ			3
+#define RT5651_CP_FQ_24_KHZ			4
+#define RT5651_CP_FQ_48_KHZ			5
+#define RT5651_CP_FQ_96_KHZ			6
+#define RT5651_CP_FQ_192_KHZ			7
+
+/* HPOUT charge pump (0x91) */
+#define RT5651_OSW_L_MASK			(0x1 << 11)
+#define RT5651_OSW_L_SFT			11
+#define RT5651_OSW_L_DIS			(0x0 << 11)
+#define RT5651_OSW_L_EN				(0x1 << 11)
+#define RT5651_OSW_R_MASK			(0x1 << 10)
+#define RT5651_OSW_R_SFT			10
+#define RT5651_OSW_R_DIS			(0x0 << 10)
+#define RT5651_OSW_R_EN				(0x1 << 10)
+#define RT5651_PM_HP_MASK			(0x3 << 8)
+#define RT5651_PM_HP_SFT			8
+#define RT5651_PM_HP_LV				(0x0 << 8)
+#define RT5651_PM_HP_MV				(0x1 << 8)
+#define RT5651_PM_HP_HV				(0x2 << 8)
+#define RT5651_IB_HP_MASK			(0x3 << 6)
+#define RT5651_IB_HP_SFT			6
+#define RT5651_IB_HP_125IL			(0x0 << 6)
+#define RT5651_IB_HP_25IL			(0x1 << 6)
+#define RT5651_IB_HP_5IL			(0x2 << 6)
+#define RT5651_IB_HP_1IL			(0x3 << 6)
+
+/* Micbias Control (0x93) */
+#define RT5651_MIC1_BS_MASK			(0x1 << 15)
+#define RT5651_MIC1_BS_SFT			15
+#define RT5651_MIC1_BS_9AV			(0x0 << 15)
+#define RT5651_MIC1_BS_75AV			(0x1 << 15)
+#define RT5651_MIC1_CLK_MASK			(0x1 << 13)
+#define RT5651_MIC1_CLK_SFT			13
+#define RT5651_MIC1_CLK_DIS			(0x0 << 13)
+#define RT5651_MIC1_CLK_EN			(0x1 << 13)
+#define RT5651_MIC1_OVCD_MASK			(0x1 << 11)
+#define RT5651_MIC1_OVCD_SFT			11
+#define RT5651_MIC1_OVCD_DIS			(0x0 << 11)
+#define RT5651_MIC1_OVCD_EN			(0x1 << 11)
+#define RT5651_MIC1_OVTH_MASK			(0x3 << 9)
+#define RT5651_MIC1_OVTH_SFT			9
+#define RT5651_MIC1_OVTH_600UA			(0x0 << 9)
+#define RT5651_MIC1_OVTH_1500UA			(0x1 << 9)
+#define RT5651_MIC1_OVTH_2000UA			(0x2 << 9)
+#define RT5651_PWR_MB_MASK			(0x1 << 5)
+#define RT5651_PWR_MB_SFT			5
+#define RT5651_PWR_MB_PD			(0x0 << 5)
+#define RT5651_PWR_MB_PU			(0x1 << 5)
+#define RT5651_PWR_CLK12M_MASK			(0x1 << 4)
+#define RT5651_PWR_CLK12M_SFT			4
+#define RT5651_PWR_CLK12M_PD			(0x0 << 4)
+#define RT5651_PWR_CLK12M_PU			(0x1 << 4)
+
+/* Analog JD Control 1 (0x94) */
+#define RT5651_JD2_CMP_MASK			(0x7 << 12)
+#define RT5651_JD2_CMP_SFT			12
+#define RT5651_JD_PU				(0x1 << 11)
+#define RT5651_JD_PU_SFT			11
+#define RT5651_JD_PD				(0x1 << 10)
+#define RT5651_JD_PD_SFT			10
+#define RT5651_JD_MODE_SEL_MASK			(0x3 << 8)
+#define RT5651_JD_MODE_SEL_SFT			8
+#define RT5651_JD_MODE_SEL_M0			(0x0 << 8)
+#define RT5651_JD_MODE_SEL_M1			(0x1 << 8)
+#define RT5651_JD_MODE_SEL_M2			(0x2 << 8)
+#define RT5651_JD_M_CMP				(0x7 << 4)
+#define RT5651_JD_M_CMP_SFT			4
+#define RT5651_JD_M_PU				(0x1 << 3)
+#define RT5651_JD_M_PU_SFT			3
+#define RT5651_JD_M_PD				(0x1 << 2)
+#define RT5651_JD_M_PD_SFT			2
+#define RT5651_JD_M_MODE_SEL_MASK		(0x3)
+#define RT5651_JD_M_MODE_SEL_SFT		0
+#define RT5651_JD_M_MODE_SEL_M0			(0x0)
+#define RT5651_JD_M_MODE_SEL_M1			(0x1)
+#define RT5651_JD_M_MODE_SEL_M2			(0x2)
+
+/* Analog JD Control 2 (0x95) */
+#define RT5651_JD3_CMP_MASK			(0x7 << 12)
+#define RT5651_JD3_CMP_SFT			12
+
+/* EQ Control 1 (0xb0) */
+#define RT5651_EQ_SRC_MASK			(0x1 << 15)
+#define RT5651_EQ_SRC_SFT			15
+#define RT5651_EQ_SRC_DAC			(0x0 << 15)
+#define RT5651_EQ_SRC_ADC			(0x1 << 15)
+#define RT5651_EQ_UPD				(0x1 << 14)
+#define RT5651_EQ_UPD_BIT			14
+#define RT5651_EQ_CD_MASK			(0x1 << 13)
+#define RT5651_EQ_CD_SFT			13
+#define RT5651_EQ_CD_DIS			(0x0 << 13)
+#define RT5651_EQ_CD_EN				(0x1 << 13)
+#define RT5651_EQ_DITH_MASK			(0x3 << 8)
+#define RT5651_EQ_DITH_SFT			8
+#define RT5651_EQ_DITH_NOR			(0x0 << 8)
+#define RT5651_EQ_DITH_LSB			(0x1 << 8)
+#define RT5651_EQ_DITH_LSB_1			(0x2 << 8)
+#define RT5651_EQ_DITH_LSB_2			(0x3 << 8)
+#define RT5651_EQ_CD_F				(0x1 << 7)
+#define RT5651_EQ_CD_F_BIT			7
+#define RT5651_EQ_STA_HP2			(0x1 << 6)
+#define RT5651_EQ_STA_HP2_BIT			6
+#define RT5651_EQ_STA_HP1			(0x1 << 5)
+#define RT5651_EQ_STA_HP1_BIT			5
+#define RT5651_EQ_STA_BP4			(0x1 << 4)
+#define RT5651_EQ_STA_BP4_BIT			4
+#define RT5651_EQ_STA_BP3			(0x1 << 3)
+#define RT5651_EQ_STA_BP3_BIT			3
+#define RT5651_EQ_STA_BP2			(0x1 << 2)
+#define RT5651_EQ_STA_BP2_BIT			2
+#define RT5651_EQ_STA_BP1			(0x1 << 1)
+#define RT5651_EQ_STA_BP1_BIT			1
+#define RT5651_EQ_STA_LP			(0x1)
+#define RT5651_EQ_STA_LP_BIT			0
+
+/* EQ Control 2 (0xb1) */
+#define RT5651_EQ_HPF1_M_MASK			(0x1 << 8)
+#define RT5651_EQ_HPF1_M_SFT			8
+#define RT5651_EQ_HPF1_M_HI			(0x0 << 8)
+#define RT5651_EQ_HPF1_M_1ST			(0x1 << 8)
+#define RT5651_EQ_LPF1_M_MASK			(0x1 << 7)
+#define RT5651_EQ_LPF1_M_SFT			7
+#define RT5651_EQ_LPF1_M_LO			(0x0 << 7)
+#define RT5651_EQ_LPF1_M_1ST			(0x1 << 7)
+#define RT5651_EQ_HPF2_MASK			(0x1 << 6)
+#define RT5651_EQ_HPF2_SFT			6
+#define RT5651_EQ_HPF2_DIS			(0x0 << 6)
+#define RT5651_EQ_HPF2_EN			(0x1 << 6)
+#define RT5651_EQ_HPF1_MASK			(0x1 << 5)
+#define RT5651_EQ_HPF1_SFT			5
+#define RT5651_EQ_HPF1_DIS			(0x0 << 5)
+#define RT5651_EQ_HPF1_EN			(0x1 << 5)
+#define RT5651_EQ_BPF4_MASK			(0x1 << 4)
+#define RT5651_EQ_BPF4_SFT			4
+#define RT5651_EQ_BPF4_DIS			(0x0 << 4)
+#define RT5651_EQ_BPF4_EN			(0x1 << 4)
+#define RT5651_EQ_BPF3_MASK			(0x1 << 3)
+#define RT5651_EQ_BPF3_SFT			3
+#define RT5651_EQ_BPF3_DIS			(0x0 << 3)
+#define RT5651_EQ_BPF3_EN			(0x1 << 3)
+#define RT5651_EQ_BPF2_MASK			(0x1 << 2)
+#define RT5651_EQ_BPF2_SFT			2
+#define RT5651_EQ_BPF2_DIS			(0x0 << 2)
+#define RT5651_EQ_BPF2_EN			(0x1 << 2)
+#define RT5651_EQ_BPF1_MASK			(0x1 << 1)
+#define RT5651_EQ_BPF1_SFT			1
+#define RT5651_EQ_BPF1_DIS			(0x0 << 1)
+#define RT5651_EQ_BPF1_EN			(0x1 << 1)
+#define RT5651_EQ_LPF_MASK			(0x1)
+#define RT5651_EQ_LPF_SFT			0
+#define RT5651_EQ_LPF_DIS			(0x0)
+#define RT5651_EQ_LPF_EN			(0x1)
+#define RT5651_EQ_CTRL_MASK			(0x7f)
+
+/* Memory Test (0xb2) */
+#define RT5651_MT_MASK				(0x1 << 15)
+#define RT5651_MT_SFT				15
+#define RT5651_MT_DIS				(0x0 << 15)
+#define RT5651_MT_EN				(0x1 << 15)
+
+/* ALC Control 1 (0xb4) */
+#define RT5651_ALC_P_MASK			(0x1 << 15)
+#define RT5651_ALC_P_SFT			15
+#define RT5651_ALC_P_DAC			(0x0 << 15)
+#define RT5651_ALC_P_ADC			(0x1 << 15)
+#define RT5651_ALC_MASK				(0x1 << 14)
+#define RT5651_ALC_SFT				14
+#define RT5651_ALC_DIS				(0x0 << 14)
+#define RT5651_ALC_EN				(0x1 << 14)
+#define RT5651_ALC_UPD				(0x1 << 13)
+#define RT5651_ALC_UPD_BIT			13
+#define RT5651_ALC_AR_MASK			(0x1f << 8)
+#define RT5651_ALC_AR_SFT			8
+#define RT5651_ALC_R_MASK			(0x7 << 5)
+#define RT5651_ALC_R_SFT			5
+#define RT5651_ALC_R_48K			(0x1 << 5)
+#define RT5651_ALC_R_96K			(0x2 << 5)
+#define RT5651_ALC_R_192K			(0x3 << 5)
+#define RT5651_ALC_R_441K			(0x5 << 5)
+#define RT5651_ALC_R_882K			(0x6 << 5)
+#define RT5651_ALC_R_1764K			(0x7 << 5)
+#define RT5651_ALC_RC_MASK			(0x1f)
+#define RT5651_ALC_RC_SFT			0
+
+/* ALC Control 2 (0xb5) */
+#define RT5651_ALC_POB_MASK			(0x3f << 8)
+#define RT5651_ALC_POB_SFT			8
+#define RT5651_ALC_DRC_MASK			(0x1 << 7)
+#define RT5651_ALC_DRC_SFT			7
+#define RT5651_ALC_DRC_DIS			(0x0 << 7)
+#define RT5651_ALC_DRC_EN			(0x1 << 7)
+#define RT5651_ALC_CPR_MASK			(0x3 << 5)
+#define RT5651_ALC_CPR_SFT			5
+#define RT5651_ALC_CPR_1_1			(0x0 << 5)
+#define RT5651_ALC_CPR_1_2			(0x1 << 5)
+#define RT5651_ALC_CPR_1_4			(0x2 << 5)
+#define RT5651_ALC_CPR_1_8			(0x3 << 5)
+#define RT5651_ALC_PRB_MASK			(0x1f)
+#define RT5651_ALC_PRB_SFT			0
+
+/* ALC Control 3 (0xb6) */
+#define RT5651_ALC_NGB_MASK			(0xf << 12)
+#define RT5651_ALC_NGB_SFT			12
+#define RT5651_ALC_TAR_MASK			(0x1f << 7)
+#define RT5651_ALC_TAR_SFT			7
+#define RT5651_ALC_NG_MASK			(0x1 << 6)
+#define RT5651_ALC_NG_SFT			6
+#define RT5651_ALC_NG_DIS			(0x0 << 6)
+#define RT5651_ALC_NG_EN			(0x1 << 6)
+#define RT5651_ALC_NGH_MASK			(0x1 << 5)
+#define RT5651_ALC_NGH_SFT			5
+#define RT5651_ALC_NGH_DIS			(0x0 << 5)
+#define RT5651_ALC_NGH_EN			(0x1 << 5)
+#define RT5651_ALC_NGT_MASK			(0x1f)
+#define RT5651_ALC_NGT_SFT			0
+
+/* Jack Detect Control 1 (0xbb) */
+#define RT5651_JD_MASK				(0x7 << 13)
+#define RT5651_JD_SFT				13
+#define RT5651_JD_DIS				(0x0 << 13)
+#define RT5651_JD_GPIO1				(0x1 << 13)
+#define RT5651_JD_GPIO2				(0x2 << 13)
+#define RT5651_JD_GPIO3				(0x3 << 13)
+#define RT5651_JD_GPIO4				(0x4 << 13)
+#define RT5651_JD_GPIO5				(0x5 << 13)
+#define RT5651_JD_GPIO6				(0x6 << 13)
+#define RT5651_JD_HP_MASK			(0x1 << 11)
+#define RT5651_JD_HP_SFT			11
+#define RT5651_JD_HP_DIS			(0x0 << 11)
+#define RT5651_JD_HP_EN				(0x1 << 11)
+#define RT5651_JD_HP_TRG_MASK			(0x1 << 10)
+#define RT5651_JD_HP_TRG_SFT			10
+#define RT5651_JD_HP_TRG_LO			(0x0 << 10)
+#define RT5651_JD_HP_TRG_HI			(0x1 << 10)
+#define RT5651_JD_SPL_MASK			(0x1 << 9)
+#define RT5651_JD_SPL_SFT			9
+#define RT5651_JD_SPL_DIS			(0x0 << 9)
+#define RT5651_JD_SPL_EN			(0x1 << 9)
+#define RT5651_JD_SPL_TRG_MASK			(0x1 << 8)
+#define RT5651_JD_SPL_TRG_SFT			8
+#define RT5651_JD_SPL_TRG_LO			(0x0 << 8)
+#define RT5651_JD_SPL_TRG_HI			(0x1 << 8)
+#define RT5651_JD_SPR_MASK			(0x1 << 7)
+#define RT5651_JD_SPR_SFT			7
+#define RT5651_JD_SPR_DIS			(0x0 << 7)
+#define RT5651_JD_SPR_EN			(0x1 << 7)
+#define RT5651_JD_SPR_TRG_MASK			(0x1 << 6)
+#define RT5651_JD_SPR_TRG_SFT			6
+#define RT5651_JD_SPR_TRG_LO			(0x0 << 6)
+#define RT5651_JD_SPR_TRG_HI			(0x1 << 6)
+#define RT5651_JD_LO_MASK			(0x1 << 3)
+#define RT5651_JD_LO_SFT			3
+#define RT5651_JD_LO_DIS			(0x0 << 3)
+#define RT5651_JD_LO_EN				(0x1 << 3)
+#define RT5651_JD_LO_TRG_MASK			(0x1 << 2)
+#define RT5651_JD_LO_TRG_SFT			2
+#define RT5651_JD_LO_TRG_LO			(0x0 << 2)
+#define RT5651_JD_LO_TRG_HI			(0x1 << 2)
+
+/* Jack Detect Control 2 (0xbc) */
+#define RT5651_JD_TRG_SEL_MASK			(0x7 << 9)
+#define RT5651_JD_TRG_SEL_SFT			9
+#define RT5651_JD_TRG_SEL_GPIO			(0x0 << 9)
+#define RT5651_JD_TRG_SEL_JD1_1			(0x1 << 9)
+#define RT5651_JD_TRG_SEL_JD1_2			(0x2 << 9)
+#define RT5651_JD_TRG_SEL_JD2			(0x3 << 9)
+#define RT5651_JD_TRG_SEL_JD3			(0x4 << 9)
+#define RT5651_JD3_IRQ_EN			(0x1 << 8)
+#define RT5651_JD3_IRQ_EN_SFT			8
+#define RT5651_JD3_EN_STKY			(0x1 << 7)
+#define RT5651_JD3_EN_STKY_SFT			7
+#define RT5651_JD3_INV				(0x1 << 6)
+#define RT5651_JD3_INV_SFT			6
+
+/* IRQ Control 1 (0xbd) */
+#define RT5651_IRQ_JD_MASK			(0x1 << 15)
+#define RT5651_IRQ_JD_SFT			15
+#define RT5651_IRQ_JD_BP			(0x0 << 15)
+#define RT5651_IRQ_JD_NOR			(0x1 << 15)
+#define RT5651_JD_STKY_MASK			(0x1 << 13)
+#define RT5651_JD_STKY_SFT			13
+#define RT5651_JD_STKY_DIS			(0x0 << 13)
+#define RT5651_JD_STKY_EN			(0x1 << 13)
+#define RT5651_JD_P_MASK			(0x1 << 11)
+#define RT5651_JD_P_SFT				11
+#define RT5651_JD_P_NOR				(0x0 << 11)
+#define RT5651_JD_P_INV				(0x1 << 11)
+#define RT5651_JD1_1_IRQ_EN			(0x1 << 9)
+#define RT5651_JD1_1_IRQ_EN_SFT			9
+#define RT5651_JD1_1_EN_STKY			(0x1 << 8)
+#define RT5651_JD1_1_EN_STKY_SFT			8
+#define RT5651_JD1_1_INV			(0x1 << 7)
+#define RT5651_JD1_1_INV_SFT			7
+#define RT5651_JD1_2_IRQ_EN			(0x1 << 6)
+#define RT5651_JD1_2_IRQ_EN_SFT			6
+#define RT5651_JD1_2_EN_STKY			(0x1 << 5)
+#define RT5651_JD1_2_EN_STKY_SFT			5
+#define RT5651_JD1_2_INV			(0x1 << 4)
+#define RT5651_JD1_2_INV_SFT			4
+#define RT5651_JD2_IRQ_EN			(0x1 << 3)
+#define RT5651_JD2_IRQ_EN_SFT			3
+#define RT5651_JD2_EN_STKY			(0x1 << 2)
+#define RT5651_JD2_EN_STKY_SFT			2
+#define RT5651_JD2_INV				(0x1 << 1)
+#define RT5651_JD2_INV_SFT			1
+
+/* IRQ Control 2 (0xbe) */
+#define RT5651_IRQ_MB1_OC_MASK			(0x1 << 15)
+#define RT5651_IRQ_MB1_OC_SFT			15
+#define RT5651_IRQ_MB1_OC_BP			(0x0 << 15)
+#define RT5651_IRQ_MB1_OC_NOR			(0x1 << 15)
+#define RT5651_MB1_OC_STKY_MASK			(0x1 << 11)
+#define RT5651_MB1_OC_STKY_SFT			11
+#define RT5651_MB1_OC_STKY_DIS			(0x0 << 11)
+#define RT5651_MB1_OC_STKY_EN			(0x1 << 11)
+#define RT5651_MB1_OC_P_MASK			(0x1 << 7)
+#define RT5651_MB1_OC_P_SFT			7
+#define RT5651_MB1_OC_P_NOR			(0x0 << 7)
+#define RT5651_MB1_OC_P_INV			(0x1 << 7)
+#define RT5651_MB2_OC_P_MASK			(0x1 << 6)
+#define RT5651_MB1_OC_CLR			(0x1 << 3)
+#define RT5651_MB1_OC_CLR_SFT			3
+#define RT5651_STA_GPIO8			(0x1)
+#define RT5651_STA_GPIO8_BIT			0
+
+/* Internal Status and GPIO status (0xbf) */
+#define RT5651_STA_JD3				(0x1 << 15)
+#define RT5651_STA_JD3_BIT			15
+#define RT5651_STA_JD2				(0x1 << 14)
+#define RT5651_STA_JD2_BIT			14
+#define RT5651_STA_JD1_2			(0x1 << 13)
+#define RT5651_STA_JD1_2_BIT			13
+#define RT5651_STA_JD1_1			(0x1 << 12)
+#define RT5651_STA_JD1_1_BIT			12
+#define RT5651_STA_GP7				(0x1 << 11)
+#define RT5651_STA_GP7_BIT			11
+#define RT5651_STA_GP6				(0x1 << 10)
+#define RT5651_STA_GP6_BIT			10
+#define RT5651_STA_GP5				(0x1 << 9)
+#define RT5651_STA_GP5_BIT			9
+#define RT5651_STA_GP1				(0x1 << 8)
+#define RT5651_STA_GP1_BIT			8
+#define RT5651_STA_GP2				(0x1 << 7)
+#define RT5651_STA_GP2_BIT			7
+#define RT5651_STA_GP3				(0x1 << 6)
+#define RT5651_STA_GP3_BIT			6
+#define RT5651_STA_GP4				(0x1 << 5)
+#define RT5651_STA_GP4_BIT			5
+#define RT5651_STA_GP_JD			(0x1 << 4)
+#define RT5651_STA_GP_JD_BIT			4
+
+/* GPIO Control 1 (0xc0) */
+#define RT5651_GP1_PIN_MASK			(0x1 << 15)
+#define RT5651_GP1_PIN_SFT			15
+#define RT5651_GP1_PIN_GPIO1			(0x0 << 15)
+#define RT5651_GP1_PIN_IRQ			(0x1 << 15)
+#define RT5651_GP2_PIN_MASK			(0x1 << 14)
+#define RT5651_GP2_PIN_SFT			14
+#define RT5651_GP2_PIN_GPIO2			(0x0 << 14)
+#define RT5651_GP2_PIN_DMIC1_SCL		(0x1 << 14)
+#define RT5651_GPIO_M_MASK			(0x1 << 9)
+#define RT5651_GPIO_M_SFT			9
+#define RT5651_GPIO_M_FLT			(0x0 << 9)
+#define RT5651_GPIO_M_PH			(0x1 << 9)
+#define RT5651_I2S2_SEL_MASK			(0x1 << 8)
+#define RT5651_I2S2_SEL_SFT			8
+#define RT5651_I2S2_SEL_I2S			(0x0 << 8)
+#define RT5651_I2S2_SEL_GPIO			(0x1 << 8)
+#define RT5651_GP5_PIN_MASK			(0x1 << 7)
+#define RT5651_GP5_PIN_SFT			7
+#define RT5651_GP5_PIN_GPIO5			(0x0 << 7)
+#define RT5651_GP5_PIN_IRQ			(0x1 << 7)
+#define RT5651_GP6_PIN_MASK			(0x1 << 6)
+#define RT5651_GP6_PIN_SFT			6
+#define RT5651_GP6_PIN_GPIO6			(0x0 << 6)
+#define RT5651_GP6_PIN_DMIC_SDA			(0x1 << 6)
+#define RT5651_GP7_PIN_MASK			(0x1 << 5)
+#define RT5651_GP7_PIN_SFT			5
+#define RT5651_GP7_PIN_GPIO7			(0x0 << 5)
+#define RT5651_GP7_PIN_IRQ			(0x1 << 5)
+#define RT5651_GP8_PIN_MASK			(0x1 << 4)
+#define RT5651_GP8_PIN_SFT			4
+#define RT5651_GP8_PIN_GPIO8			(0x0 << 4)
+#define RT5651_GP8_PIN_DMIC_SDA			(0x1 << 4)
+#define RT5651_GPIO_PDM_SEL_MASK		(0x1 << 3)
+#define RT5651_GPIO_PDM_SEL_SFT			3
+#define RT5651_GPIO_PDM_SEL_GPIO		(0x0 << 3)
+#define RT5651_GPIO_PDM_SEL_PDM			(0x1 << 3)
+
+/* GPIO Control 2 (0xc1) */
+#define RT5651_GP5_DR_MASK			(0x1 << 14)
+#define RT5651_GP5_DR_SFT			14
+#define RT5651_GP5_DR_IN			(0x0 << 14)
+#define RT5651_GP5_DR_OUT			(0x1 << 14)
+#define RT5651_GP5_OUT_MASK			(0x1 << 13)
+#define RT5651_GP5_OUT_SFT			13
+#define RT5651_GP5_OUT_LO			(0x0 << 13)
+#define RT5651_GP5_OUT_HI			(0x1 << 13)
+#define RT5651_GP5_P_MASK			(0x1 << 12)
+#define RT5651_GP5_P_SFT			12
+#define RT5651_GP5_P_NOR			(0x0 << 12)
+#define RT5651_GP5_P_INV			(0x1 << 12)
+#define RT5651_GP4_DR_MASK			(0x1 << 11)
+#define RT5651_GP4_DR_SFT			11
+#define RT5651_GP4_DR_IN			(0x0 << 11)
+#define RT5651_GP4_DR_OUT			(0x1 << 11)
+#define RT5651_GP4_OUT_MASK			(0x1 << 10)
+#define RT5651_GP4_OUT_SFT			10
+#define RT5651_GP4_OUT_LO			(0x0 << 10)
+#define RT5651_GP4_OUT_HI			(0x1 << 10)
+#define RT5651_GP4_P_MASK			(0x1 << 9)
+#define RT5651_GP4_P_SFT			9
+#define RT5651_GP4_P_NOR			(0x0 << 9)
+#define RT5651_GP4_P_INV			(0x1 << 9)
+#define RT5651_GP3_DR_MASK			(0x1 << 8)
+#define RT5651_GP3_DR_SFT			8
+#define RT5651_GP3_DR_IN			(0x0 << 8)
+#define RT5651_GP3_DR_OUT			(0x1 << 8)
+#define RT5651_GP3_OUT_MASK			(0x1 << 7)
+#define RT5651_GP3_OUT_SFT			7
+#define RT5651_GP3_OUT_LO			(0x0 << 7)
+#define RT5651_GP3_OUT_HI			(0x1 << 7)
+#define RT5651_GP3_P_MASK			(0x1 << 6)
+#define RT5651_GP3_P_SFT			6
+#define RT5651_GP3_P_NOR			(0x0 << 6)
+#define RT5651_GP3_P_INV			(0x1 << 6)
+#define RT5651_GP2_DR_MASK			(0x1 << 5)
+#define RT5651_GP2_DR_SFT			5
+#define RT5651_GP2_DR_IN			(0x0 << 5)
+#define RT5651_GP2_DR_OUT			(0x1 << 5)
+#define RT5651_GP2_OUT_MASK			(0x1 << 4)
+#define RT5651_GP2_OUT_SFT			4
+#define RT5651_GP2_OUT_LO			(0x0 << 4)
+#define RT5651_GP2_OUT_HI			(0x1 << 4)
+#define RT5651_GP2_P_MASK			(0x1 << 3)
+#define RT5651_GP2_P_SFT			3
+#define RT5651_GP2_P_NOR			(0x0 << 3)
+#define RT5651_GP2_P_INV			(0x1 << 3)
+#define RT5651_GP1_DR_MASK			(0x1 << 2)
+#define RT5651_GP1_DR_SFT			2
+#define RT5651_GP1_DR_IN			(0x0 << 2)
+#define RT5651_GP1_DR_OUT			(0x1 << 2)
+#define RT5651_GP1_OUT_MASK			(0x1 << 1)
+#define RT5651_GP1_OUT_SFT			1
+#define RT5651_GP1_OUT_LO			(0x0 << 1)
+#define RT5651_GP1_OUT_HI			(0x1 << 1)
+#define RT5651_GP1_P_MASK			(0x1)
+#define RT5651_GP1_P_SFT			0
+#define RT5651_GP1_P_NOR			(0x0)
+#define RT5651_GP1_P_INV			(0x1)
+
+/* GPIO Control 3 (0xc2) */
+#define RT5651_GP8_DR_MASK			(0x1 << 8)
+#define RT5651_GP8_DR_SFT			8
+#define RT5651_GP8_DR_IN			(0x0 << 8)
+#define RT5651_GP8_DR_OUT			(0x1 << 8)
+#define RT5651_GP8_OUT_MASK			(0x1 << 7)
+#define RT5651_GP8_OUT_SFT			7
+#define RT5651_GP8_OUT_LO			(0x0 << 7)
+#define RT5651_GP8_OUT_HI			(0x1 << 7)
+#define RT5651_GP8_P_MASK			(0x1 << 6)
+#define RT5651_GP8_P_SFT			6
+#define RT5651_GP8_P_NOR			(0x0 << 6)
+#define RT5651_GP8_P_INV			(0x1 << 6)
+#define RT5651_GP7_DR_MASK			(0x1 << 5)
+#define RT5651_GP7_DR_SFT			5
+#define RT5651_GP7_DR_IN			(0x0 << 5)
+#define RT5651_GP7_DR_OUT			(0x1 << 5)
+#define RT5651_GP7_OUT_MASK			(0x1 << 4)
+#define RT5651_GP7_OUT_SFT			4
+#define RT5651_GP7_OUT_LO			(0x0 << 4)
+#define RT5651_GP7_OUT_HI			(0x1 << 4)
+#define RT5651_GP7_P_MASK			(0x1 << 3)
+#define RT5651_GP7_P_SFT			3
+#define RT5651_GP7_P_NOR			(0x0 << 3)
+#define RT5651_GP7_P_INV			(0x1 << 3)
+#define RT5651_GP6_DR_MASK			(0x1 << 2)
+#define RT5651_GP6_DR_SFT			2
+#define RT5651_GP6_DR_IN			(0x0 << 2)
+#define RT5651_GP6_DR_OUT			(0x1 << 2)
+#define RT5651_GP6_OUT_MASK			(0x1 << 1)
+#define RT5651_GP6_OUT_SFT			1
+#define RT5651_GP6_OUT_LO			(0x0 << 1)
+#define RT5651_GP6_OUT_HI			(0x1 << 1)
+#define RT5651_GP6_P_MASK			(0x1)
+#define RT5651_GP6_P_SFT			0
+#define RT5651_GP6_P_NOR			(0x0)
+#define RT5651_GP6_P_INV			(0x1)
+
+/* Scramble Control (0xce) */
+#define RT5651_SCB_SWAP_MASK			(0x1 << 15)
+#define RT5651_SCB_SWAP_SFT			15
+#define RT5651_SCB_SWAP_DIS			(0x0 << 15)
+#define RT5651_SCB_SWAP_EN			(0x1 << 15)
+#define RT5651_SCB_MASK				(0x1 << 14)
+#define RT5651_SCB_SFT				14
+#define RT5651_SCB_DIS				(0x0 << 14)
+#define RT5651_SCB_EN				(0x1 << 14)
+
+/* Baseback Control (0xcf) */
+#define RT5651_BB_MASK				(0x1 << 15)
+#define RT5651_BB_SFT				15
+#define RT5651_BB_DIS				(0x0 << 15)
+#define RT5651_BB_EN				(0x1 << 15)
+#define RT5651_BB_CT_MASK			(0x7 << 12)
+#define RT5651_BB_CT_SFT			12
+#define RT5651_BB_CT_A				(0x0 << 12)
+#define RT5651_BB_CT_B				(0x1 << 12)
+#define RT5651_BB_CT_C				(0x2 << 12)
+#define RT5651_BB_CT_D				(0x3 << 12)
+#define RT5651_M_BB_L_MASK			(0x1 << 9)
+#define RT5651_M_BB_L_SFT			9
+#define RT5651_M_BB_R_MASK			(0x1 << 8)
+#define RT5651_M_BB_R_SFT			8
+#define RT5651_M_BB_HPF_L_MASK			(0x1 << 7)
+#define RT5651_M_BB_HPF_L_SFT			7
+#define RT5651_M_BB_HPF_R_MASK			(0x1 << 6)
+#define RT5651_M_BB_HPF_R_SFT			6
+#define RT5651_G_BB_BST_MASK			(0x3f)
+#define RT5651_G_BB_BST_SFT			0
+
+/* MP3 Plus Control 1 (0xd0) */
+#define RT5651_M_MP3_L_MASK			(0x1 << 15)
+#define RT5651_M_MP3_L_SFT			15
+#define RT5651_M_MP3_R_MASK			(0x1 << 14)
+#define RT5651_M_MP3_R_SFT			14
+#define RT5651_M_MP3_MASK			(0x1 << 13)
+#define RT5651_M_MP3_SFT			13
+#define RT5651_M_MP3_DIS			(0x0 << 13)
+#define RT5651_M_MP3_EN				(0x1 << 13)
+#define RT5651_EG_MP3_MASK			(0x1f << 8)
+#define RT5651_EG_MP3_SFT			8
+#define RT5651_MP3_HLP_MASK			(0x1 << 7)
+#define RT5651_MP3_HLP_SFT			7
+#define RT5651_MP3_HLP_DIS			(0x0 << 7)
+#define RT5651_MP3_HLP_EN			(0x1 << 7)
+#define RT5651_M_MP3_ORG_L_MASK			(0x1 << 6)
+#define RT5651_M_MP3_ORG_L_SFT			6
+#define RT5651_M_MP3_ORG_R_MASK			(0x1 << 5)
+#define RT5651_M_MP3_ORG_R_SFT			5
+
+/* MP3 Plus Control 2 (0xd1) */
+#define RT5651_MP3_WT_MASK			(0x1 << 13)
+#define RT5651_MP3_WT_SFT			13
+#define RT5651_MP3_WT_1_4			(0x0 << 13)
+#define RT5651_MP3_WT_1_2			(0x1 << 13)
+#define RT5651_OG_MP3_MASK			(0x1f << 8)
+#define RT5651_OG_MP3_SFT			8
+#define RT5651_HG_MP3_MASK			(0x3f)
+#define RT5651_HG_MP3_SFT			0
+
+/* 3D HP Control 1 (0xd2) */
+#define RT5651_3D_CF_MASK			(0x1 << 15)
+#define RT5651_3D_CF_SFT			15
+#define RT5651_3D_CF_DIS			(0x0 << 15)
+#define RT5651_3D_CF_EN				(0x1 << 15)
+#define RT5651_3D_HP_MASK			(0x1 << 14)
+#define RT5651_3D_HP_SFT			14
+#define RT5651_3D_HP_DIS			(0x0 << 14)
+#define RT5651_3D_HP_EN				(0x1 << 14)
+#define RT5651_3D_BT_MASK			(0x1 << 13)
+#define RT5651_3D_BT_SFT			13
+#define RT5651_3D_BT_DIS			(0x0 << 13)
+#define RT5651_3D_BT_EN				(0x1 << 13)
+#define RT5651_3D_1F_MIX_MASK			(0x3 << 11)
+#define RT5651_3D_1F_MIX_SFT			11
+#define RT5651_3D_HP_M_MASK			(0x1 << 10)
+#define RT5651_3D_HP_M_SFT			10
+#define RT5651_3D_HP_M_SUR			(0x0 << 10)
+#define RT5651_3D_HP_M_FRO			(0x1 << 10)
+#define RT5651_M_3D_HRTF_MASK			(0x1 << 9)
+#define RT5651_M_3D_HRTF_SFT			9
+#define RT5651_M_3D_D2H_MASK			(0x1 << 8)
+#define RT5651_M_3D_D2H_SFT			8
+#define RT5651_M_3D_D2R_MASK			(0x1 << 7)
+#define RT5651_M_3D_D2R_SFT			7
+#define RT5651_M_3D_REVB_MASK			(0x1 << 6)
+#define RT5651_M_3D_REVB_SFT			6
+
+/* Adjustable high pass filter control 1 (0xd3) */
+#define RT5651_2ND_HPF_MASK			(0x1 << 15)
+#define RT5651_2ND_HPF_SFT			15
+#define RT5651_2ND_HPF_DIS			(0x0 << 15)
+#define RT5651_2ND_HPF_EN			(0x1 << 15)
+#define RT5651_HPF_CF_L_MASK			(0x7 << 12)
+#define RT5651_HPF_CF_L_SFT			12
+#define RT5651_HPF_CF_R_MASK			(0x7 << 8)
+#define RT5651_HPF_CF_R_SFT			8
+#define RT5651_ZD_T_MASK			(0x3 << 6)
+#define RT5651_ZD_T_SFT				6
+#define RT5651_ZD_F_MASK			(0x3 << 4)
+#define RT5651_ZD_F_SFT				4
+#define RT5651_ZD_F_IM				(0x0 << 4)
+#define RT5651_ZD_F_ZC_IM			(0x1 << 4)
+#define RT5651_ZD_F_ZC_IOD			(0x2 << 4)
+#define RT5651_ZD_F_UN				(0x3 << 4)
+
+/* Adjustable high pass filter control 2 (0xd4) */
+#define RT5651_HPF_CF_L_NUM_MASK		(0x3f << 8)
+#define RT5651_HPF_CF_L_NUM_SFT			8
+#define RT5651_HPF_CF_R_NUM_MASK		(0x3f)
+#define RT5651_HPF_CF_R_NUM_SFT			0
+
+/* HP calibration control and Amp detection (0xd6) */
+#define RT5651_SI_DAC_MASK			(0x1 << 11)
+#define RT5651_SI_DAC_SFT			11
+#define RT5651_SI_DAC_AUTO			(0x0 << 11)
+#define RT5651_SI_DAC_TEST			(0x1 << 11)
+#define RT5651_DC_CAL_M_MASK			(0x1 << 10)
+#define RT5651_DC_CAL_M_SFT			10
+#define RT5651_DC_CAL_M_NOR			(0x0 << 10)
+#define RT5651_DC_CAL_M_CAL			(0x1 << 10)
+#define RT5651_DC_CAL_MASK			(0x1 << 9)
+#define RT5651_DC_CAL_SFT			9
+#define RT5651_DC_CAL_DIS			(0x0 << 9)
+#define RT5651_DC_CAL_EN			(0x1 << 9)
+#define RT5651_HPD_RCV_MASK			(0x7 << 6)
+#define RT5651_HPD_RCV_SFT			6
+#define RT5651_HPD_PS_MASK			(0x1 << 5)
+#define RT5651_HPD_PS_SFT			5
+#define RT5651_HPD_PS_DIS			(0x0 << 5)
+#define RT5651_HPD_PS_EN			(0x1 << 5)
+#define RT5651_CAL_M_MASK			(0x1 << 4)
+#define RT5651_CAL_M_SFT			4
+#define RT5651_CAL_M_DEP			(0x0 << 4)
+#define RT5651_CAL_M_CAL			(0x1 << 4)
+#define RT5651_CAL_MASK				(0x1 << 3)
+#define RT5651_CAL_SFT				3
+#define RT5651_CAL_DIS				(0x0 << 3)
+#define RT5651_CAL_EN				(0x1 << 3)
+#define RT5651_CAL_TEST_MASK			(0x1 << 2)
+#define RT5651_CAL_TEST_SFT			2
+#define RT5651_CAL_TEST_DIS			(0x0 << 2)
+#define RT5651_CAL_TEST_EN			(0x1 << 2)
+#define RT5651_CAL_P_MASK			(0x3)
+#define RT5651_CAL_P_SFT			0
+#define RT5651_CAL_P_NONE			(0x0)
+#define RT5651_CAL_P_CAL			(0x1)
+#define RT5651_CAL_P_DAC_CAL			(0x2)
+
+/* Soft volume and zero cross control 1 (0xd9) */
+#define RT5651_SV_MASK				(0x1 << 15)
+#define RT5651_SV_SFT				15
+#define RT5651_SV_DIS				(0x0 << 15)
+#define RT5651_SV_EN				(0x1 << 15)
+#define RT5651_OUT_SV_MASK			(0x1 << 13)
+#define RT5651_OUT_SV_SFT			13
+#define RT5651_OUT_SV_DIS			(0x0 << 13)
+#define RT5651_OUT_SV_EN			(0x1 << 13)
+#define RT5651_HP_SV_MASK			(0x1 << 12)
+#define RT5651_HP_SV_SFT			12
+#define RT5651_HP_SV_DIS			(0x0 << 12)
+#define RT5651_HP_SV_EN				(0x1 << 12)
+#define RT5651_ZCD_DIG_MASK			(0x1 << 11)
+#define RT5651_ZCD_DIG_SFT			11
+#define RT5651_ZCD_DIG_DIS			(0x0 << 11)
+#define RT5651_ZCD_DIG_EN			(0x1 << 11)
+#define RT5651_ZCD_MASK				(0x1 << 10)
+#define RT5651_ZCD_SFT				10
+#define RT5651_ZCD_PD				(0x0 << 10)
+#define RT5651_ZCD_PU				(0x1 << 10)
+#define RT5651_M_ZCD_MASK			(0x3f << 4)
+#define RT5651_M_ZCD_SFT			4
+#define RT5651_M_ZCD_OM_L			(0x1 << 7)
+#define RT5651_M_ZCD_OM_R			(0x1 << 6)
+#define RT5651_M_ZCD_RM_L			(0x1 << 5)
+#define RT5651_M_ZCD_RM_R			(0x1 << 4)
+#define RT5651_SV_DLY_MASK			(0xf)
+#define RT5651_SV_DLY_SFT			0
+
+/* Soft volume and zero cross control 2 (0xda) */
+#define RT5651_ZCD_HP_MASK			(0x1 << 15)
+#define RT5651_ZCD_HP_SFT			15
+#define RT5651_ZCD_HP_DIS			(0x0 << 15)
+#define RT5651_ZCD_HP_EN			(0x1 << 15)
+
+/* Digital Misc Control (0xfa) */
+#define RT5651_I2S2_MS_SP_MASK			(0x1 << 8)
+#define RT5651_I2S2_MS_SP_SEL			8
+#define RT5651_I2S2_MS_SP_64			(0x0 << 8)
+#define RT5651_I2S2_MS_SP_50			(0x1 << 8)
+#define RT5651_CLK_DET_EN			(0x1 << 3)
+#define RT5651_CLK_DET_EN_SFT			3
+#define RT5651_AMP_DET_EN			(0x1 << 1)
+#define RT5651_AMP_DET_EN_SFT			1
+#define RT5651_D_GATE_EN			(0x1)
+#define RT5651_D_GATE_EN_SFT			0
+
+/* Codec Private Register definition */
+/* 3D Speaker Control (0x63) */
+#define RT5651_3D_SPK_MASK			(0x1 << 15)
+#define RT5651_3D_SPK_SFT			15
+#define RT5651_3D_SPK_DIS			(0x0 << 15)
+#define RT5651_3D_SPK_EN			(0x1 << 15)
+#define RT5651_3D_SPK_M_MASK			(0x3 << 13)
+#define RT5651_3D_SPK_M_SFT			13
+#define RT5651_3D_SPK_CG_MASK			(0x1f << 8)
+#define RT5651_3D_SPK_CG_SFT			8
+#define RT5651_3D_SPK_SG_MASK			(0x1f)
+#define RT5651_3D_SPK_SG_SFT			0
+
+/* Wind Noise Detection Control 1 (0x6c) */
+#define RT5651_WND_MASK				(0x1 << 15)
+#define RT5651_WND_SFT				15
+#define RT5651_WND_DIS				(0x0 << 15)
+#define RT5651_WND_EN				(0x1 << 15)
+
+/* Wind Noise Detection Control 2 (0x6d) */
+#define RT5651_WND_FC_NW_MASK			(0x3f << 10)
+#define RT5651_WND_FC_NW_SFT			10
+#define RT5651_WND_FC_WK_MASK			(0x3f << 4)
+#define RT5651_WND_FC_WK_SFT			4
+
+/* Wind Noise Detection Control 3 (0x6e) */
+#define RT5651_HPF_FC_MASK			(0x3f << 6)
+#define RT5651_HPF_FC_SFT			6
+#define RT5651_WND_FC_ST_MASK			(0x3f)
+#define RT5651_WND_FC_ST_SFT			0
+
+/* Wind Noise Detection Control 4 (0x6f) */
+#define RT5651_WND_TH_LO_MASK			(0x3ff)
+#define RT5651_WND_TH_LO_SFT			0
+
+/* Wind Noise Detection Control 5 (0x70) */
+#define RT5651_WND_TH_HI_MASK			(0x3ff)
+#define RT5651_WND_TH_HI_SFT			0
+
+/* Wind Noise Detection Control 8 (0x73) */
+#define RT5651_WND_WIND_MASK			(0x1 << 13) /* Read-Only */
+#define RT5651_WND_WIND_SFT			13
+#define RT5651_WND_STRONG_MASK			(0x1 << 12) /* Read-Only */
+#define RT5651_WND_STRONG_SFT			12
+enum {
+	RT5651_NO_WIND,
+	RT5651_BREEZE,
+	RT5651_STORM,
+};
+
+/* Dipole Speaker Interface (0x75) */
+#define RT5651_DP_ATT_MASK			(0x3 << 14)
+#define RT5651_DP_ATT_SFT			14
+#define RT5651_DP_SPK_MASK			(0x1 << 10)
+#define RT5651_DP_SPK_SFT			10
+#define RT5651_DP_SPK_DIS			(0x0 << 10)
+#define RT5651_DP_SPK_EN			(0x1 << 10)
+
+/* EQ Pre Volume Control (0xb3) */
+#define RT5651_EQ_PRE_VOL_MASK			(0xffff)
+#define RT5651_EQ_PRE_VOL_SFT			0
+
+/* EQ Post Volume Control (0xb4) */
+#define RT5651_EQ_PST_VOL_MASK			(0xffff)
+#define RT5651_EQ_PST_VOL_SFT			0
+
+/* System Clock Source */
+enum {
+	RT5651_SCLK_S_MCLK,
+	RT5651_SCLK_S_PLL1,
+	RT5651_SCLK_S_RCCLK,
+};
+
+/* PLL1 Source */
+enum {
+	RT5651_PLL1_S_MCLK,
+	RT5651_PLL1_S_BCLK1,
+	RT5651_PLL1_S_BCLK2,
+};
+
+enum {
+	RT5651_AIF1,
+	RT5651_AIF2,
+	RT5651_AIFS,
+};
+
+struct rt5651_pll_code {
+	bool m_bp; /* Indicates bypass m code or not. */
+	int m_code;
+	int n_code;
+	int k_code;
+};
+
+struct rt5651_priv {
+	struct snd_soc_codec *codec;
+	struct rt5651_platform_data pdata;
+	struct regmap *regmap;
+
+	int sysclk;
+	int sysclk_src;
+	int lrck[RT5651_AIFS];
+	int bclk[RT5651_AIFS];
+	int master[RT5651_AIFS];
+
+	struct rt5651_pll_code pll_code;
+	int pll_src;
+	int pll_in;
+	int pll_out;
+
+	int dmic_en;
+	bool hp_mute;
+};
+
+#endif /* __RT5651_H__ */
-- 
1.8.1.1.439.g50a6b54
