From: <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: add RT5639 CODEC driver
Date: Mon, 24 Mar 2014 10:16:37 +0800
Message-ID: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D88012615B6
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 03:18:02 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Oder Chiou <oder_chiou@realtek.com>

This patch adds the RT5639 codec driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>

---

It is migrated from RT5640 codec driver,
and modified for RT5639's specification.

---
 include/sound/rt5639.h    |   22 +
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/rt5639.c | 2092 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5639.h | 1928 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 4048 insertions(+)
 create mode 100644 include/sound/rt5639.h
 create mode 100644 sound/soc/codecs/rt5639.c
 create mode 100644 sound/soc/codecs/rt5639.h

diff --git a/include/sound/rt5639.h b/include/sound/rt5639.h
new file mode 100644
index 0000000..7101120
--- /dev/null
+++ b/include/sound/rt5639.h
@@ -0,0 +1,22 @@
+/*
+ * linux/sound/rt5639.h -- Platform data for RT5639
+ *
+ * Copyright 2011 Realtek Microelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_RT5639_H
+#define __LINUX_SND_RT5639_H
+
+struct rt5639_platform_data {
+	/* IN1 & IN2 can optionally be differential */
+	bool in1_diff;
+	bool in2_diff;
+
+	int ldo1_en; /* GPIO for LDO1_EN */
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 983d087a..ed791fb 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -60,6 +60,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_PCM3008
 	select SND_SOC_RT5631 if I2C
+	select SND_SOC_RT5639 if I2C
 	select SND_SOC_RT5640 if I2C
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SI476X if MFD_SI476X_CORE
@@ -316,6 +317,9 @@ config SND_SOC_PCM3008
 config SND_SOC_RT5631
 	tristate
 
+config SND_SOC_RT5639
+	tristate
+
 config SND_SOC_RT5640
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bc12676..051f3fb 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -47,6 +47,7 @@ snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-rt5631-objs := rt5631.o
+snd-soc-rt5639-objs := rt5639.o
 snd-soc-rt5640-objs := rt5640.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
@@ -180,6 +181,7 @@ obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
+obj-$(CONFIG_SND_SOC_RT5639)	+= snd-soc-rt5639.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
diff --git a/sound/soc/codecs/rt5639.c b/sound/soc/codecs/rt5639.c
new file mode 100644
index 0000000..df8d307
--- /dev/null
+++ b/sound/soc/codecs/rt5639.c
@@ -0,0 +1,2092 @@
+/*
+ * rt5639.c  --  RT5639 ALSA SoC audio codec driver
+ *
+ * Copyright 2011 Realtek Semiconductor Corp.
+ * Author: Bard Liao <bardliao@realtek.com>
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
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
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/acpi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "rt5639.h"
+
+#define RT5639_DEVICE_ID 0x6231
+
+#define RT5639_PR_RANGE_BASE (0xff + 1)
+#define RT5639_PR_SPACING 0x100
+
+#define RT5639_PR_BASE (RT5639_PR_RANGE_BASE + (0 * RT5639_PR_SPACING))
+
+static const struct regmap_range_cfg rt5639_ranges[] = {
+	{ .name = "PR", .range_min = RT5639_PR_BASE,
+	  .range_max = RT5639_PR_BASE + 0xb4,
+	  .selector_reg = RT5639_PRIV_INDEX,
+	  .selector_mask = 0xff,
+	  .selector_shift = 0x0,
+	  .window_start = RT5639_PRIV_DATA,
+	  .window_len = 0x1, },
+};
+
+static struct reg_default init_list[] = {
+	{0x2e,	0x0c00},
+	{RT5639_PR_BASE + 0x3d,	0x3600},
+	{RT5639_PR_BASE + 0x12,	0x0aa8},
+	{RT5639_PR_BASE + 0x14,	0x0aaa},
+	{RT5639_PR_BASE + 0x20,	0x6110},
+	{RT5639_PR_BASE + 0x21,	0xe0e0},
+	{RT5639_PR_BASE + 0x23,	0x1804},
+};
+#define RT5639_INIT_REG_LEN ARRAY_SIZE(init_list)
+
+static const struct reg_default rt5639_reg[] = {
+	{ 0x00, 0x000e },
+	{ 0x01, 0xc8c8 },
+	{ 0x02, 0xc8c8 },
+	{ 0x03, 0xc8c8 },
+	{ 0x04, 0x8000 },
+	{ 0x0d, 0x0000 },
+	{ 0x0e, 0x0000 },
+	{ 0x0f, 0x0808 },
+	{ 0x19, 0xafaf },
+	{ 0x1a, 0xafaf },
+	{ 0x1b, 0x0000 },
+	{ 0x1c, 0x2f2f },
+	{ 0x1d, 0x2f2f },
+	{ 0x1e, 0x0000 },
+	{ 0x27, 0x7060 },
+	{ 0x28, 0x7070 },
+	{ 0x29, 0x8080 },
+	{ 0x2a, 0x5454 },
+	{ 0x2b, 0x5454 },
+	{ 0x2c, 0xaa00 },
+	{ 0x2d, 0x0000 },
+	{ 0x2e, 0xa000 },
+	{ 0x2f, 0x0000 },
+	{ 0x3b, 0x0000 },
+	{ 0x3c, 0x007f },
+	{ 0x3d, 0x0000 },
+	{ 0x3e, 0x007f },
+	{ 0x45, 0xe000 },
+	{ 0x46, 0x003e },
+	{ 0x47, 0x003e },
+	{ 0x48, 0xf800 },
+	{ 0x49, 0x3800 },
+	{ 0x4a, 0x0004 },
+	{ 0x4c, 0xfc00 },
+	{ 0x4d, 0x0000 },
+	{ 0x4f, 0x01ff },
+	{ 0x50, 0x0000 },
+	{ 0x51, 0x0000 },
+	{ 0x52, 0x01ff },
+	{ 0x53, 0xf000 },
+	{ 0x61, 0x0000 },
+	{ 0x62, 0x0000 },
+	{ 0x63, 0x00c0 },
+	{ 0x64, 0x0000 },
+	{ 0x65, 0x0000 },
+	{ 0x66, 0x0000 },
+	{ 0x6a, 0x0000 },
+	{ 0x6c, 0x0000 },
+	{ 0x70, 0x8000 },
+	{ 0x71, 0x8000 },
+	{ 0x72, 0x8000 },
+	{ 0x73, 0x1114 },
+	{ 0x74, 0x0c00 },
+	{ 0x75, 0x1d00 },
+	{ 0x80, 0x0000 },
+	{ 0x81, 0x0000 },
+	{ 0x82, 0x0000 },
+	{ 0x83, 0x0000 },
+	{ 0x84, 0x0000 },
+	{ 0x85, 0x0008 },
+	{ 0x89, 0x0000 },
+	{ 0x8a, 0x0000 },
+	{ 0x8b, 0x0600 },
+	{ 0x8c, 0x0228 },
+	{ 0x8d, 0xa000 },
+	{ 0x8e, 0x0004 },
+	{ 0x8f, 0x1100 },
+	{ 0x90, 0x0646 },
+	{ 0x91, 0x0c00 },
+	{ 0x92, 0x0000 },
+	{ 0x93, 0x3000 },
+	{ 0xb0, 0x2080 },
+	{ 0xb1, 0x0000 },
+	{ 0xb4, 0x2206 },
+	{ 0xb5, 0x1f00 },
+	{ 0xb6, 0x0000 },
+	{ 0xb8, 0x034b },
+	{ 0xb9, 0x0066 },
+	{ 0xba, 0x000b },
+	{ 0xbb, 0x0000 },
+	{ 0xbc, 0x0000 },
+	{ 0xbd, 0x0000 },
+	{ 0xbe, 0x0000 },
+	{ 0xbf, 0x0000 },
+	{ 0xc0, 0x0400 },
+	{ 0xc2, 0x0000 },
+	{ 0xc4, 0x0000 },
+	{ 0xc5, 0x0000 },
+	{ 0xc6, 0x2000 },
+	{ 0xc8, 0x0000 },
+	{ 0xc9, 0x0000 },
+	{ 0xca, 0x0000 },
+	{ 0xcb, 0x0000 },
+	{ 0xcc, 0x0000 },
+	{ 0xcf, 0x0013 },
+	{ 0xd0, 0x0680 },
+	{ 0xd1, 0x1c17 },
+	{ 0xd2, 0x8c00 },
+	{ 0xd3, 0xaa20 },
+	{ 0xd6, 0x0400 },
+	{ 0xd9, 0x0809 },
+	{ 0xfe, 0x10ec },
+	{ 0xff, 0x6231 },
+};
+
+static int rt5639_reset(struct snd_soc_codec *codec)
+{
+	return snd_soc_write(codec, RT5639_RESET, 0);
+}
+
+static bool rt5639_volatile_register(struct device *dev, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rt5639_ranges); i++)
+		if ((reg >= rt5639_ranges[i].window_start &&
+		     reg <= rt5639_ranges[i].window_start +
+		     rt5639_ranges[i].window_len) ||
+		    (reg >= rt5639_ranges[i].range_min &&
+		     reg <= rt5639_ranges[i].range_max))
+			return true;
+
+	switch (reg) {
+	case RT5639_RESET:
+	case RT5639_ASRC_5:
+	case RT5639_EQ_CTRL1:
+	case RT5639_DRC_AGC_1:
+	case RT5639_IRQ_CTRL2:
+	case RT5639_INT_IRQ_ST:
+	case RT5639_PRIV_INDEX:
+	case RT5639_PRIV_DATA:
+	case RT5639_PGM_REG_ARR1:
+	case RT5639_PGM_REG_ARR3:
+	case RT5639_VENDOR_ID:
+	case RT5639_VENDOR_ID1:
+	case RT5639_VENDOR_ID2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt5639_readable_register(struct device *dev, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rt5639_ranges); i++)
+		if ((reg >= rt5639_ranges[i].window_start &&
+		     reg <= rt5639_ranges[i].window_start +
+		     rt5639_ranges[i].window_len) ||
+		    (reg >= rt5639_ranges[i].range_min &&
+		     reg <= rt5639_ranges[i].range_max))
+			return true;
+
+	switch (reg) {
+	case RT5639_RESET:
+	case RT5639_SPK_VOL:
+	case RT5639_HP_VOL:
+	case RT5639_OUTPUT:
+	case RT5639_IN1_IN2:
+	case RT5639_IN3_IN4:
+	case RT5639_INL_INR_VOL:
+	case RT5639_DAC1_DIG_VOL:
+	case RT5639_DAC2_DIG_VOL:
+	case RT5639_DAC2_CTRL:
+	case RT5639_ADC_DIG_VOL:
+	case RT5639_ADC_DATA:
+	case RT5639_ADC_BST_VOL:
+	case RT5639_STO_ADC_MIXER:
+	case RT5639_MONO_ADC_MIXER:
+	case RT5639_AD_DA_MIXER:
+	case RT5639_STO_DAC_MIXER:
+	case RT5639_MONO_DAC_MIXER:
+	case RT5639_DIG_MIXER:
+	case RT5639_DIG_INF_DATA:
+	case RT5639_REC_L1_MIXER:
+	case RT5639_REC_L2_MIXER:
+	case RT5639_REC_R1_MIXER:
+	case RT5639_REC_R2_MIXER:
+	case RT5639_HPO_MIXER:
+	case RT5639_SPK_L_MIXER:
+	case RT5639_SPK_R_MIXER:
+	case RT5639_SPO_L_MIXER:
+	case RT5639_SPO_R_MIXER:
+	case RT5639_SPO_CLSD_RATIO:
+	case RT5639_OUT_L1_MIXER:
+	case RT5639_OUT_L2_MIXER:
+	case RT5639_OUT_L3_MIXER:
+	case RT5639_OUT_R1_MIXER:
+	case RT5639_OUT_R2_MIXER:
+	case RT5639_OUT_R3_MIXER:
+	case RT5639_LOUT_MIXER:
+	case RT5639_PWR_DIG1:
+	case RT5639_PWR_DIG2:
+	case RT5639_PWR_ANLG1:
+	case RT5639_PWR_ANLG2:
+	case RT5639_PWR_MIXER:
+	case RT5639_PWR_VOL:
+	case RT5639_PRIV_INDEX:
+	case RT5639_PRIV_DATA:
+	case RT5639_I2S1_SDP:
+	case RT5639_I2S2_SDP:
+	case RT5639_ADDA_CLK1:
+	case RT5639_DMIC:
+	case RT5639_GLB_CLK:
+	case RT5639_PLL_CTRL1:
+	case RT5639_PLL_CTRL2:
+	case RT5639_ASRC_1:
+	case RT5639_ASRC_2:
+	case RT5639_ASRC_3:
+	case RT5639_ASRC_4:
+	case RT5639_ASRC_5:
+	case RT5639_CLS_D_OVCD:
+	case RT5639_CLS_D_OUT:
+	case RT5639_DEPOP_M1:
+	case RT5639_DEPOP_M2:
+	case RT5639_DEPOP_M3:
+	case RT5639_CHARGE_PUMP:
+	case RT5639_PV_DET_SPK_G:
+	case RT5639_MICBIAS:
+	case RT5639_EQ_CTRL1:
+	case RT5639_EQ_CTRL2:
+	case RT5639_WIND_FILTER:
+	case RT5639_DRC_AGC_1:
+	case RT5639_DRC_AGC_2:
+	case RT5639_DRC_AGC_3:
+	case RT5639_JD_CTRL:
+	case RT5639_IRQ_CTRL1:
+	case RT5639_IRQ_CTRL2:
+	case RT5639_INT_IRQ_ST:
+	case RT5639_GPIO_CTRL1:
+	case RT5639_GPIO_CTRL2:
+	case RT5639_PGM_REG_ARR1:
+	case RT5639_PGM_REG_ARR2:
+	case RT5639_PGM_REG_ARR3:
+	case RT5639_PGM_REG_ARR4:
+	case RT5639_PGM_REG_ARR5:
+	case RT5639_ADJ_HPF:
+	case RT5639_HP_CALIB_AMP_DET:
+	case RT5639_SV_ZCD1:
+	case RT5639_DUMMY1:
+	case RT5639_DUMMY2:
+	case RT5639_DUMMY3:
+	case RT5639_VENDOR_ID:
+	case RT5639_VENDOR_ID1:
+	case RT5639_VENDOR_ID2:
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
+static const char * const rt5639_data_select[] = {
+	"Normal", "left copy to right", "right copy to left", "Swap"};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_if1_dac_enum, RT5639_DIG_INF_DATA,
+	RT5639_IF1_DAC_SEL_SFT, rt5639_data_select);
+
+static SOC_ENUM_SINGLE_DECL(rt5639_if1_adc_enum, RT5639_DIG_INF_DATA,
+	RT5639_IF1_ADC_SEL_SFT, rt5639_data_select);
+
+static SOC_ENUM_SINGLE_DECL(rt5639_if2_dac_enum, RT5639_DIG_INF_DATA,
+	RT5639_IF2_DAC_SEL_SFT, rt5639_data_select);
+
+static SOC_ENUM_SINGLE_DECL(rt5639_if2_adc_enum, RT5639_DIG_INF_DATA,
+	RT5639_IF2_ADC_SEL_SFT, rt5639_data_select);
+
+/* Class D speaker gain ratio */
+static const char * const rt5639_clsd_spk_ratio[] = {"1.66x", "1.83x", "1.94x",
+	"2x", "2.11x", "2.22x", "2.33x", "2.44x", "2.55x", "2.66x", "2.77x"};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_clsd_spk_ratio_enum,
+	RT5639_CLS_D_OUT, RT5639_CLSD_RATIO_SFT, rt5639_clsd_spk_ratio);
+
+static const struct snd_kcontrol_new rt5639_snd_controls[] = {
+	/* Speaker Output Volume */
+	SOC_DOUBLE("Speaker Channel Switch", RT5639_SPK_VOL,
+		RT5639_VOL_L_SFT, RT5639_VOL_R_SFT, 1, 1),
+	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5639_SPK_VOL,
+		RT5639_L_VOL_SFT, RT5639_R_VOL_SFT, 39, 1, out_vol_tlv),
+
+	/* Headphone Output Volume */
+	SOC_DOUBLE("HP Channel Switch", RT5639_HP_VOL,
+		RT5639_VOL_L_SFT, RT5639_VOL_R_SFT, 1, 1),
+	SOC_DOUBLE_TLV("HP Playback Volume", RT5639_HP_VOL,
+		RT5639_L_VOL_SFT, RT5639_R_VOL_SFT, 39, 1, out_vol_tlv),
+
+	/* OUTPUT Control */
+	SOC_DOUBLE("OUT Playback Switch", RT5639_OUTPUT,
+		RT5639_L_MUTE_SFT, RT5639_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE("OUT Channel Switch", RT5639_OUTPUT,
+		RT5639_VOL_L_SFT, RT5639_VOL_R_SFT, 1, 1),
+	SOC_DOUBLE_TLV("OUT Playback Volume", RT5639_OUTPUT,
+		RT5639_L_VOL_SFT, RT5639_R_VOL_SFT, 39, 1, out_vol_tlv),
+
+	/* DAC Digital Volume */
+	SOC_DOUBLE("DAC2 Playback Switch", RT5639_DAC2_CTRL,
+		RT5639_M_DAC_L2_VOL_SFT, RT5639_M_DAC_R2_VOL_SFT, 1, 1),
+	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5639_DAC1_DIG_VOL,
+		RT5639_L_VOL_SFT, RT5639_R_VOL_SFT, 175, 0, dac_vol_tlv),
+
+	/* IN1/IN2 Control */
+	SOC_SINGLE_TLV("IN1 Boost", RT5639_IN1_IN2, RT5639_BST_SFT1, 8, 0,
+		bst_tlv),
+	SOC_SINGLE_TLV("IN2 Boost", RT5639_IN3_IN4, RT5639_BST_SFT2, 8, 0,
+		bst_tlv),
+
+	/* INL/INR Volume Control */
+	SOC_DOUBLE_TLV("IN Capture Volume", RT5639_INL_INR_VOL,
+		RT5639_INL_VOL_SFT, RT5639_INR_VOL_SFT, 31, 1, in_vol_tlv),
+
+	/* ADC Digital Volume Control */
+	SOC_DOUBLE("ADC Capture Switch", RT5639_ADC_DIG_VOL,
+		RT5639_L_MUTE_SFT, RT5639_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE_TLV("ADC Capture Volume", RT5639_ADC_DIG_VOL,
+		RT5639_L_VOL_SFT, RT5639_R_VOL_SFT, 127, 0, adc_vol_tlv),
+	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5639_ADC_DATA,
+		RT5639_L_VOL_SFT, RT5639_R_VOL_SFT, 127, 0, adc_vol_tlv),
+
+	/* ADC Boost Volume Control */
+	SOC_DOUBLE_TLV("ADC Boost Gain", RT5639_ADC_BST_VOL,
+		RT5639_ADC_L_BST_SFT, RT5639_ADC_R_BST_SFT, 3, 0, adc_bst_tlv),
+
+	/* Class D speaker gain ratio */
+	SOC_ENUM("Class D SPK Ratio Control", rt5639_clsd_spk_ratio_enum),
+
+	/* Data Swap */
+	SOC_ENUM("ADC IF1 Data Switch", rt5639_if1_adc_enum),
+	SOC_ENUM("DAC IF1 Data Switch", rt5639_if1_dac_enum),
+	SOC_ENUM("ADC IF2 Data Switch", rt5639_if2_adc_enum),
+	SOC_ENUM("DAC IF2 Data Switch", rt5639_if2_dac_enum),
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
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	int div[] = {2, 3, 4, 6, 8, 12};
+	int i, idx = -EINVAL;
+	int rate, red, bound, temp;
+
+	rate = rt5639->sysclk;
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
+		snd_soc_update_bits(codec, RT5639_DMIC, RT5639_DMIC_CLK_MASK,
+					idx << RT5639_DMIC_CLK_SFT);
+	return idx;
+}
+
+static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	unsigned int val;
+
+	val = snd_soc_read(source->codec, RT5639_GLB_CLK);
+	val &= RT5639_SCLK_SRC_MASK;
+	if (val == RT5639_SCLK_SRC_PLL1)
+		return 1;
+	else
+		return 0;
+}
+
+/* Digital Mixer */
+static const struct snd_kcontrol_new rt5639_sto_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5639_STO_ADC_MIXER,
+			RT5639_M_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5639_STO_ADC_MIXER,
+			RT5639_M_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_sto_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5639_STO_ADC_MIXER,
+			RT5639_M_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5639_STO_ADC_MIXER,
+			RT5639_M_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_mono_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5639_MONO_ADC_MIXER,
+			RT5639_M_MONO_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5639_MONO_ADC_MIXER,
+			RT5639_M_MONO_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_mono_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5639_MONO_ADC_MIXER,
+			RT5639_M_MONO_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5639_MONO_ADC_MIXER,
+			RT5639_M_MONO_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5639_AD_DA_MIXER,
+			RT5639_M_ADCMIX_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INF1 Switch", RT5639_AD_DA_MIXER,
+			RT5639_M_IF1_DAC_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5639_AD_DA_MIXER,
+			RT5639_M_ADCMIX_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INF1 Switch", RT5639_AD_DA_MIXER,
+			RT5639_M_IF1_DAC_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_sto_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_STO_DAC_MIXER,
+			RT5639_M_DAC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_STO_DAC_MIXER,
+			RT5639_M_DAC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_sto_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_STO_DAC_MIXER,
+			RT5639_M_DAC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_STO_DAC_MIXER,
+			RT5639_M_DAC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_mono_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_MONO_DAC_MIXER,
+			RT5639_M_DAC_L1_MONO_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_MONO_DAC_MIXER,
+			RT5639_M_DAC_L2_MONO_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_MONO_DAC_MIXER,
+			RT5639_M_DAC_R2_MONO_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_mono_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_MONO_DAC_MIXER,
+			RT5639_M_DAC_R1_MONO_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_MONO_DAC_MIXER,
+			RT5639_M_DAC_R2_MONO_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_MONO_DAC_MIXER,
+			RT5639_M_DAC_L2_MONO_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_dig_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_DIG_MIXER,
+			RT5639_M_STO_L_DAC_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_DIG_MIXER,
+			RT5639_M_DAC_L2_DAC_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_dig_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_DIG_MIXER,
+			RT5639_M_STO_R_DAC_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_DIG_MIXER,
+			RT5639_M_DAC_R2_DAC_R_SFT, 1, 1),
+};
+
+/* Analog Input Mixer */
+static const struct snd_kcontrol_new rt5639_rec_l_mix[] = {
+	SOC_DAPM_SINGLE("HPOL Switch", RT5639_REC_L2_MIXER,
+			RT5639_M_HP_L_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL Switch", RT5639_REC_L2_MIXER,
+			RT5639_M_IN_L_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST3 Switch", RT5639_REC_L2_MIXER,
+			RT5639_M_BST2_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5639_REC_L2_MIXER,
+			RT5639_M_BST4_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5639_REC_L2_MIXER,
+			RT5639_M_BST1_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUT MIXL Switch", RT5639_REC_L2_MIXER,
+			RT5639_M_OM_L_RM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_rec_r_mix[] = {
+	SOC_DAPM_SINGLE("HPOR Switch", RT5639_REC_R2_MIXER,
+			RT5639_M_HP_R_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR Switch", RT5639_REC_R2_MIXER,
+			RT5639_M_IN_R_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST3 Switch", RT5639_REC_R2_MIXER,
+			RT5639_M_BST2_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5639_REC_R2_MIXER,
+			RT5639_M_BST4_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5639_REC_R2_MIXER,
+			RT5639_M_BST1_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUT MIXR Switch", RT5639_REC_R2_MIXER,
+			RT5639_M_OM_R_RM_R_SFT, 1, 1),
+};
+
+/* Analog Output Mixer */
+static const struct snd_kcontrol_new rt5639_spk_l_mix[] = {
+	SOC_DAPM_SINGLE("REC MIXL Switch", RT5639_SPK_L_MIXER,
+			RT5639_M_RM_L_SM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL Switch", RT5639_SPK_L_MIXER,
+			RT5639_M_IN_L_SM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_SPK_L_MIXER,
+			RT5639_M_DAC_L1_SM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_SPK_L_MIXER,
+			RT5639_M_DAC_L2_SM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUT MIXL Switch", RT5639_SPK_L_MIXER,
+			RT5639_M_OM_L_SM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_spk_r_mix[] = {
+	SOC_DAPM_SINGLE("REC MIXR Switch", RT5639_SPK_R_MIXER,
+			RT5639_M_RM_R_SM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR Switch", RT5639_SPK_R_MIXER,
+			RT5639_M_IN_R_SM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_SPK_R_MIXER,
+			RT5639_M_DAC_R1_SM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_SPK_R_MIXER,
+			RT5639_M_DAC_R2_SM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUT MIXR Switch", RT5639_SPK_R_MIXER,
+			RT5639_M_OM_R_SM_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_out_l_mix[] = {
+	SOC_DAPM_SINGLE("BST1 Switch", RT5639_OUT_L3_MIXER,
+			RT5639_M_BST1_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL Switch", RT5639_OUT_L3_MIXER,
+			RT5639_M_IN_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("REC MIXL Switch", RT5639_OUT_L3_MIXER,
+			RT5639_M_RM_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_OUT_L3_MIXER,
+			RT5639_M_DAC_R2_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_OUT_L3_MIXER,
+			RT5639_M_DAC_L2_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_OUT_L3_MIXER,
+			RT5639_M_DAC_L1_OM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_out_r_mix[] = {
+	SOC_DAPM_SINGLE("BST2 Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_BST4_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_BST1_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_IN_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("REC MIXR Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_RM_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_DAC_L2_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_DAC_R2_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_OUT_R3_MIXER,
+			RT5639_M_DAC_R1_OM_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_spo_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_SPO_L_MIXER,
+			RT5639_M_DAC_R1_SPM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_SPO_L_MIXER,
+			RT5639_M_DAC_L1_SPM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("SPKVOL R Switch", RT5639_SPO_L_MIXER,
+			RT5639_M_SV_R_SPM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("SPKVOL L Switch", RT5639_SPO_L_MIXER,
+			RT5639_M_SV_L_SPM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5639_SPO_L_MIXER,
+			RT5639_M_BST1_SPM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_spo_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_SPO_R_MIXER,
+			RT5639_M_DAC_R1_SPM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("SPKVOL R Switch", RT5639_SPO_R_MIXER,
+			RT5639_M_SV_R_SPM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5639_SPO_R_MIXER,
+			RT5639_M_BST1_SPM_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_hpo_mix[] = {
+	SOC_DAPM_SINGLE("HPO MIX DAC1 Switch", RT5639_HPO_MIXER,
+			RT5639_M_DAC1_HM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("HPO MIX HPVOL Switch", RT5639_HPO_MIXER,
+			RT5639_M_HPVOL_HM_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5639_lout_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5639_LOUT_MIXER,
+			RT5639_M_DAC_L1_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5639_LOUT_MIXER,
+			RT5639_M_DAC_R1_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUTVOL L Switch", RT5639_LOUT_MIXER,
+			RT5639_M_OV_L_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUTVOL R Switch", RT5639_LOUT_MIXER,
+			RT5639_M_OV_R_LM_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new spk_l_enable_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5639_SPK_VOL,
+		RT5639_L_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new spk_r_enable_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5639_SPK_VOL,
+		RT5639_R_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new hp_l_enable_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5639_HP_VOL,
+		RT5639_L_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new hp_r_enable_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5639_HP_VOL,
+		RT5639_R_MUTE_SFT, 1, 1);
+
+/* Stereo ADC source */
+static const char * const rt5639_stereo_adc1_src[] = {
+	"DIG MIX", "ADC"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_stereo_adc1_enum, RT5639_STO_ADC_MIXER,
+			    RT5639_ADC_1_SRC_SFT, rt5639_stereo_adc1_src);
+
+static const struct snd_kcontrol_new rt5639_sto_adc_1_mux =
+	SOC_DAPM_ENUM("Stereo ADC1 Mux", rt5639_stereo_adc1_enum);
+
+static const char * const rt5639_stereo_adc2_src[] = {
+	"DMIC1", "DMIC2", "DIG MIX"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_stereo_adc2_enum, RT5639_STO_ADC_MIXER,
+			    RT5639_ADC_2_SRC_SFT, rt5639_stereo_adc2_src);
+
+static const struct snd_kcontrol_new rt5639_sto_adc_2_mux =
+	SOC_DAPM_ENUM("Stereo ADC2 Mux", rt5639_stereo_adc2_enum);
+
+/* Mono ADC source */
+static const char * const rt5639_mono_adc_l1_src[] = {
+	"Mono DAC MIXL", "ADCL"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_mono_adc_l1_enum, RT5639_MONO_ADC_MIXER,
+			    RT5639_MONO_ADC_L1_SRC_SFT, rt5639_mono_adc_l1_src);
+
+static const struct snd_kcontrol_new rt5639_mono_adc_l1_mux =
+	SOC_DAPM_ENUM("Mono ADC1 left source", rt5639_mono_adc_l1_enum);
+
+static const char * const rt5639_mono_adc_l2_src[] = {
+	"DMIC L1", "DMIC L2", "Mono DAC MIXL"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_mono_adc_l2_enum, RT5639_MONO_ADC_MIXER,
+			    RT5639_MONO_ADC_L2_SRC_SFT, rt5639_mono_adc_l2_src);
+
+static const struct snd_kcontrol_new rt5639_mono_adc_l2_mux =
+	SOC_DAPM_ENUM("Mono ADC2 left source", rt5639_mono_adc_l2_enum);
+
+static const char * const rt5639_mono_adc_r1_src[] = {
+	"Mono DAC MIXR", "ADCR"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_mono_adc_r1_enum, RT5639_MONO_ADC_MIXER,
+			    RT5639_MONO_ADC_R1_SRC_SFT, rt5639_mono_adc_r1_src);
+
+static const struct snd_kcontrol_new rt5639_mono_adc_r1_mux =
+	SOC_DAPM_ENUM("Mono ADC1 right source", rt5639_mono_adc_r1_enum);
+
+static const char * const rt5639_mono_adc_r2_src[] = {
+	"DMIC R1", "DMIC R2", "Mono DAC MIXR"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_mono_adc_r2_enum, RT5639_MONO_ADC_MIXER,
+			    RT5639_MONO_ADC_R2_SRC_SFT, rt5639_mono_adc_r2_src);
+
+static const struct snd_kcontrol_new rt5639_mono_adc_r2_mux =
+	SOC_DAPM_ENUM("Mono ADC2 right source", rt5639_mono_adc_r2_enum);
+
+/* digital interface and iis interface map */
+static const char * const rt5639_dai_iis_map[] = {
+	"1:1|2:2", "1:2|2:1", "1:1|2:1", "1:2|2:2"
+};
+
+static int rt5639_dai_iis_map_values[] = {
+	0,
+	5,
+	6,
+	7,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(rt5639_dai_iis_map_enum,
+				  RT5639_I2S1_SDP, RT5639_I2S_IF_SFT,
+				  0x7, rt5639_dai_iis_map,
+				  rt5639_dai_iis_map_values);
+
+static const struct snd_kcontrol_new rt5639_dai_mux =
+	SOC_DAPM_VALUE_ENUM("DAI select", rt5639_dai_iis_map_enum);
+
+/* SDI select */
+static const char * const rt5639_sdi_sel[] = {
+	"IF1", "IF2"
+};
+
+static SOC_ENUM_SINGLE_DECL(rt5639_sdi_sel_enum, RT5639_I2S2_SDP,
+			    RT5639_I2S2_SDI_SFT, rt5639_sdi_sel);
+
+static const struct snd_kcontrol_new rt5639_sdi_mux =
+	SOC_DAPM_ENUM("SDI select", rt5639_sdi_sel_enum);
+
+static int rt5639_set_dmic1_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5639_GPIO_CTRL1,
+			RT5639_GP2_PIN_MASK | RT5639_GP3_PIN_MASK,
+			RT5639_GP2_PIN_DMIC1_SCL | RT5639_GP3_PIN_DMIC1_SDA);
+		snd_soc_update_bits(codec, RT5639_DMIC,
+			RT5639_DMIC_1L_LH_MASK | RT5639_DMIC_1R_LH_MASK |
+			RT5639_DMIC_1_DP_MASK,
+			RT5639_DMIC_1L_LH_FALLING | RT5639_DMIC_1R_LH_RISING |
+			RT5639_DMIC_1_DP_IN1P);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5639_set_dmic2_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5639_GPIO_CTRL1,
+			RT5639_GP2_PIN_MASK | RT5639_GP4_PIN_MASK,
+			RT5639_GP2_PIN_DMIC1_SCL | RT5639_GP4_PIN_DMIC2_SDA);
+		snd_soc_update_bits(codec, RT5639_DMIC,
+			RT5639_DMIC_2L_LH_MASK | RT5639_DMIC_2R_LH_MASK |
+			RT5639_DMIC_2_DP_MASK,
+			RT5639_DMIC_2L_LH_FALLING | RT5639_DMIC_2R_LH_RISING |
+			RT5639_DMIC_2_DP_IN1N);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static void hp_amp_power_on(struct snd_soc_codec *codec)
+{
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+
+	/* depop parameters */
+	regmap_update_bits(rt5639->regmap, RT5639_PR_BASE +
+		RT5639_CHPUMP_INT_REG1, 0x0700, 0x0200);
+	regmap_update_bits(rt5639->regmap, RT5639_DEPOP_M2,
+		RT5639_DEPOP_MASK, RT5639_DEPOP_MAN);
+	regmap_update_bits(rt5639->regmap, RT5639_DEPOP_M1,
+		RT5639_HP_CP_MASK | RT5639_HP_SG_MASK | RT5639_HP_CB_MASK,
+		RT5639_HP_CP_PU | RT5639_HP_SG_DIS | RT5639_HP_CB_PU);
+	regmap_write(rt5639->regmap, RT5639_PR_BASE + RT5639_HP_DCC_INT1,
+			   0x9f00);
+	/* headphone amp power on */
+	regmap_update_bits(rt5639->regmap, RT5639_PWR_ANLG1,
+		RT5639_PWR_FV1 | RT5639_PWR_FV2, 0);
+	regmap_update_bits(rt5639->regmap, RT5639_PWR_ANLG1,
+		RT5639_PWR_HA,
+		RT5639_PWR_HA);
+	usleep_range(10000, 15000);
+	regmap_update_bits(rt5639->regmap, RT5639_PWR_ANLG1,
+		RT5639_PWR_FV1 | RT5639_PWR_FV2 ,
+		RT5639_PWR_FV1 | RT5639_PWR_FV2);
+}
+
+static void rt5639_pmu_depop(struct snd_soc_codec *codec)
+{
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_update_bits(rt5639->regmap, RT5639_DEPOP_M2,
+		RT5639_DEPOP_MASK | RT5639_DIG_DP_MASK,
+		RT5639_DEPOP_AUTO | RT5639_DIG_DP_EN);
+	regmap_update_bits(rt5639->regmap, RT5639_CHARGE_PUMP,
+		RT5639_PM_HP_MASK, RT5639_PM_HP_HV);
+
+	regmap_update_bits(rt5639->regmap, RT5639_DEPOP_M3,
+		RT5639_CP_FQ1_MASK | RT5639_CP_FQ2_MASK | RT5639_CP_FQ3_MASK,
+		(RT5639_CP_FQ_192_KHZ << RT5639_CP_FQ1_SFT) |
+		(RT5639_CP_FQ_12_KHZ << RT5639_CP_FQ2_SFT) |
+		(RT5639_CP_FQ_192_KHZ << RT5639_CP_FQ3_SFT));
+
+	regmap_write(rt5639->regmap, RT5639_PR_BASE +
+		RT5639_MAMP_INT_REG2, 0x1c00);
+	regmap_update_bits(rt5639->regmap, RT5639_DEPOP_M1,
+		RT5639_HP_CP_MASK | RT5639_HP_SG_MASK,
+		RT5639_HP_CP_PD | RT5639_HP_SG_EN);
+	regmap_update_bits(rt5639->regmap, RT5639_PR_BASE +
+		RT5639_CHPUMP_INT_REG1, 0x0700, 0x0400);
+}
+
+static int rt5639_hp_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		rt5639_pmu_depop(codec);
+		rt5639->hp_mute = 0;
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		rt5639->hp_mute = 1;
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
+static int rt5639_hp_power_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		hp_amp_power_on(codec);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5639_hp_post_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (!rt5639->hp_mute)
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
+static const struct snd_soc_dapm_widget rt5639_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("PLL1", RT5639_PWR_ANLG2, RT5639_PWR_PLL_BIT,
+		0, NULL, 0),
+	/* Input Side */
+	/* micbias */
+	SND_SOC_DAPM_SUPPLY("LDO2", RT5639_PWR_ANLG1, RT5639_PWR_LDO2_BIT,
+		0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5639_PWR_ANLG2, RT5639_PWR_MB1_BIT,
+		0, NULL, 0),
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("DMIC1"),
+	SND_SOC_DAPM_INPUT("DMIC2"),
+	SND_SOC_DAPM_INPUT("IN1P"),
+	SND_SOC_DAPM_INPUT("IN1N"),
+	SND_SOC_DAPM_INPUT("IN2P"),
+	SND_SOC_DAPM_INPUT("IN2N"),
+	SND_SOC_DAPM_INPUT("IN3P"),
+	SND_SOC_DAPM_INPUT("IN3N"),
+	SND_SOC_DAPM_PGA("DMIC L1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DMIC R1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DMIC L2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DMIC R2", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0,
+		set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY("DMIC1 Power", RT5639_DMIC,
+		RT5639_DMIC_1_EN_SFT, 0, rt5639_set_dmic1_event,
+		SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY("DMIC2 Power", RT5639_DMIC,
+		RT5639_DMIC_2_EN_SFT, 0, rt5639_set_dmic2_event,
+		SND_SOC_DAPM_PRE_PMU),
+	/* Boost */
+	SND_SOC_DAPM_PGA("BST1", RT5639_PWR_ANLG2,
+		RT5639_PWR_BST1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("BST2", RT5639_PWR_ANLG2,
+		RT5639_PWR_BST4_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("BST3", RT5639_PWR_ANLG2,
+		RT5639_PWR_BST2_BIT, 0, NULL, 0),
+
+	/* Input Volume */
+	SND_SOC_DAPM_PGA("INL VOL", RT5639_PWR_VOL,
+		RT5639_PWR_IN_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INR VOL", RT5639_PWR_VOL,
+		RT5639_PWR_IN_R_BIT, 0, NULL, 0),
+	/* REC Mixer */
+	SND_SOC_DAPM_MIXER("RECMIXL", RT5639_PWR_MIXER, RT5639_PWR_RM_L_BIT, 0,
+		rt5639_rec_l_mix, ARRAY_SIZE(rt5639_rec_l_mix)),
+	SND_SOC_DAPM_MIXER("RECMIXR", RT5639_PWR_MIXER, RT5639_PWR_RM_R_BIT, 0,
+		rt5639_rec_r_mix, ARRAY_SIZE(rt5639_rec_r_mix)),
+	/* ADCs */
+	SND_SOC_DAPM_ADC("ADC L", NULL, RT5639_PWR_DIG1, RT5639_PWR_ADC_L_BIT,
+		0),
+	SND_SOC_DAPM_ADC("ADC R", NULL, RT5639_PWR_DIG1, RT5639_PWR_ADC_R_BIT,
+		0),
+	/* ADC Mux */
+	SND_SOC_DAPM_MUX("Stereo ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_sto_adc_2_mux),
+	SND_SOC_DAPM_MUX("Stereo ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_sto_adc_2_mux),
+	SND_SOC_DAPM_MUX("Stereo ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_sto_adc_1_mux),
+	SND_SOC_DAPM_MUX("Stereo ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_sto_adc_1_mux),
+	SND_SOC_DAPM_MUX("Mono ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_mono_adc_l2_mux),
+	SND_SOC_DAPM_MUX("Mono ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_mono_adc_l1_mux),
+	SND_SOC_DAPM_MUX("Mono ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_mono_adc_r1_mux),
+	SND_SOC_DAPM_MUX("Mono ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+		&rt5639_mono_adc_r2_mux),
+	/* ADC Mixer */
+	SND_SOC_DAPM_SUPPLY("Stereo Filter", RT5639_PWR_DIG2,
+		RT5639_PWR_ADC_SF_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Stereo ADC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_sto_adc_l_mix, ARRAY_SIZE(rt5639_sto_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo ADC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_sto_adc_r_mix, ARRAY_SIZE(rt5639_sto_adc_r_mix)),
+	SND_SOC_DAPM_SUPPLY("Mono Left Filter", RT5639_PWR_DIG2,
+		RT5639_PWR_ADC_MF_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Mono ADC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_mono_adc_l_mix, ARRAY_SIZE(rt5639_mono_adc_l_mix)),
+	SND_SOC_DAPM_SUPPLY("Mono Right Filter", RT5639_PWR_DIG2,
+		RT5639_PWR_ADC_MF_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Mono ADC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_mono_adc_r_mix, ARRAY_SIZE(rt5639_mono_adc_r_mix)),
+
+	/* Digital Interface */
+	SND_SOC_DAPM_SUPPLY("I2S1", RT5639_PWR_DIG1,
+		RT5639_PWR_I2S1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("I2S2", RT5639_PWR_DIG1,
+		RT5639_PWR_I2S2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	/* Digital Interface Select */
+	SND_SOC_DAPM_MUX("DAI1 RX Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("DAI1 TX Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("DAI1 IF1 Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("DAI1 IF2 Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("SDI1 TX Mux", SND_SOC_NOPM, 0, 0, &rt5639_sdi_mux),
+	SND_SOC_DAPM_MUX("DAI2 RX Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("DAI2 TX Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("DAI2 IF1 Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("DAI2 IF2 Mux", SND_SOC_NOPM, 0, 0, &rt5639_dai_mux),
+	SND_SOC_DAPM_MUX("SDI2 TX Mux", SND_SOC_NOPM, 0, 0, &rt5639_sdi_mux),
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
+	/* Output Side */
+	/* DAC mixer before sound effect  */
+	SND_SOC_DAPM_MIXER("DAC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_dac_l_mix, ARRAY_SIZE(rt5639_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("DAC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_dac_r_mix, ARRAY_SIZE(rt5639_dac_r_mix)),
+
+	/* DAC Mixer */
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_sto_dac_l_mix, ARRAY_SIZE(rt5639_sto_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_sto_dac_r_mix, ARRAY_SIZE(rt5639_sto_dac_r_mix)),
+	SND_SOC_DAPM_MIXER("Mono DAC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_mono_dac_l_mix, ARRAY_SIZE(rt5639_mono_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Mono DAC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_mono_dac_r_mix, ARRAY_SIZE(rt5639_mono_dac_r_mix)),
+	SND_SOC_DAPM_MIXER("DIG MIXL", SND_SOC_NOPM, 0, 0,
+		rt5639_dig_l_mix, ARRAY_SIZE(rt5639_dig_l_mix)),
+	SND_SOC_DAPM_MIXER("DIG MIXR", SND_SOC_NOPM, 0, 0,
+		rt5639_dig_r_mix, ARRAY_SIZE(rt5639_dig_r_mix)),
+	/* DACs */
+	SND_SOC_DAPM_DAC("DAC L1", NULL, RT5639_PWR_DIG1, RT5639_PWR_DAC_L1_BIT,
+		0),
+	SND_SOC_DAPM_DAC("DAC R1", NULL, RT5639_PWR_DIG1, RT5639_PWR_DAC_R1_BIT,
+		0),
+	SND_SOC_DAPM_SUPPLY("DAC L2 Filter", RT5639_PWR_DIG1,
+		RT5639_PWR_DAC_L2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R2 Filter", RT5639_PWR_DIG1,
+		RT5639_PWR_DAC_R2_BIT, 0, NULL, 0),
+	/* SPK/OUT Mixer */
+	SND_SOC_DAPM_MIXER("SPK MIXL", RT5639_PWR_MIXER, RT5639_PWR_SM_L_BIT,
+		0, rt5639_spk_l_mix, ARRAY_SIZE(rt5639_spk_l_mix)),
+	SND_SOC_DAPM_MIXER("SPK MIXR", RT5639_PWR_MIXER, RT5639_PWR_SM_R_BIT,
+		0, rt5639_spk_r_mix, ARRAY_SIZE(rt5639_spk_r_mix)),
+	SND_SOC_DAPM_MIXER("OUT MIXL", RT5639_PWR_MIXER, RT5639_PWR_OM_L_BIT,
+		0, rt5639_out_l_mix, ARRAY_SIZE(rt5639_out_l_mix)),
+	SND_SOC_DAPM_MIXER("OUT MIXR", RT5639_PWR_MIXER, RT5639_PWR_OM_R_BIT,
+		0, rt5639_out_r_mix, ARRAY_SIZE(rt5639_out_r_mix)),
+	/* Ouput Volume */
+	SND_SOC_DAPM_PGA("SPKVOL L", RT5639_PWR_VOL,
+		RT5639_PWR_SV_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("SPKVOL R", RT5639_PWR_VOL,
+		RT5639_PWR_SV_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUTVOL L", RT5639_PWR_VOL,
+		RT5639_PWR_OV_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUTVOL R", RT5639_PWR_VOL,
+		RT5639_PWR_OV_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HPOVOL L", RT5639_PWR_VOL,
+		RT5639_PWR_HV_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HPOVOL R", RT5639_PWR_VOL,
+		RT5639_PWR_HV_R_BIT, 0, NULL, 0),
+	/* SPO/HPO/LOUT/Mono Mixer */
+	SND_SOC_DAPM_MIXER("SPOL MIX", SND_SOC_NOPM, 0,
+		0, rt5639_spo_l_mix, ARRAY_SIZE(rt5639_spo_l_mix)),
+	SND_SOC_DAPM_MIXER("SPOR MIX", SND_SOC_NOPM, 0,
+		0, rt5639_spo_r_mix, ARRAY_SIZE(rt5639_spo_r_mix)),
+	SND_SOC_DAPM_MIXER("HPO MIX L", SND_SOC_NOPM, 0, 0,
+		rt5639_hpo_mix, ARRAY_SIZE(rt5639_hpo_mix)),
+	SND_SOC_DAPM_MIXER("HPO MIX R", SND_SOC_NOPM, 0, 0,
+		rt5639_hpo_mix, ARRAY_SIZE(rt5639_hpo_mix)),
+	SND_SOC_DAPM_MIXER("LOUT MIX", RT5639_PWR_ANLG1, RT5639_PWR_LM_BIT, 0,
+		rt5639_lout_mix, ARRAY_SIZE(rt5639_lout_mix)),
+	SND_SOC_DAPM_SUPPLY_S("Improve HP Amp Drv", 1, SND_SOC_NOPM,
+		0, 0, rt5639_hp_power_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
+		rt5639_hp_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SUPPLY("HP L Amp", RT5639_PWR_ANLG1,
+		RT5639_PWR_HP_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HP R Amp", RT5639_PWR_ANLG1,
+		RT5639_PWR_HP_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Improve SPK Amp Drv", RT5639_PWR_DIG1,
+		RT5639_PWR_CLS_D_BIT, 0, NULL, 0),
+
+	/* Output Switch */
+	SND_SOC_DAPM_SWITCH("Speaker L Playback", SND_SOC_NOPM, 0, 0,
+		&spk_l_enable_control),
+	SND_SOC_DAPM_SWITCH("Speaker R Playback", SND_SOC_NOPM, 0, 0,
+		&spk_r_enable_control),
+	SND_SOC_DAPM_SWITCH("HP L Playback", SND_SOC_NOPM, 0, 0,
+		&hp_l_enable_control),
+	SND_SOC_DAPM_SWITCH("HP R Playback", SND_SOC_NOPM, 0, 0,
+		&hp_r_enable_control),
+	SND_SOC_DAPM_POST("HP Post", rt5639_hp_post_event),
+
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("SPOLP"),
+	SND_SOC_DAPM_OUTPUT("SPOLN"),
+	SND_SOC_DAPM_OUTPUT("SPORP"),
+	SND_SOC_DAPM_OUTPUT("SPORN"),
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+	SND_SOC_DAPM_OUTPUT("LOUTL"),
+	SND_SOC_DAPM_OUTPUT("LOUTR"),
+};
+
+static const struct snd_soc_dapm_route rt5639_dapm_routes[] = {
+	{"IN1P", NULL, "LDO2"},
+	{"IN2P", NULL, "LDO2"},
+	{"IN3P", NULL, "LDO2"},
+
+	{"DMIC L1", NULL, "DMIC1"},
+	{"DMIC R1", NULL, "DMIC1"},
+	{"DMIC L2", NULL, "DMIC2"},
+	{"DMIC R2", NULL, "DMIC2"},
+
+	{"BST1", NULL, "IN1P"},
+	{"BST1", NULL, "IN1N"},
+	{"BST2", NULL, "IN2P"},
+	{"BST2", NULL, "IN2N"},
+	{"BST3", NULL, "IN3P"},
+	{"BST3", NULL, "IN3N"},
+
+	{"INL VOL", NULL, "IN2P"},
+	{"INR VOL", NULL, "IN2N"},
+
+	{"RECMIXL", "HPOL Switch", "HPOL"},
+	{"RECMIXL", "INL Switch", "INL VOL"},
+	{"RECMIXL", "BST3 Switch", "BST3"},
+	{"RECMIXL", "BST2 Switch", "BST2"},
+	{"RECMIXL", "BST1 Switch", "BST1"},
+	{"RECMIXL", "OUT MIXL Switch", "OUT MIXL"},
+
+	{"RECMIXR", "HPOR Switch", "HPOR"},
+	{"RECMIXR", "INR Switch", "INR VOL"},
+	{"RECMIXR", "BST3 Switch", "BST3"},
+	{"RECMIXR", "BST2 Switch", "BST2"},
+	{"RECMIXR", "BST1 Switch", "BST1"},
+	{"RECMIXR", "OUT MIXR Switch", "OUT MIXR"},
+
+	{"ADC L", NULL, "RECMIXL"},
+	{"ADC R", NULL, "RECMIXR"},
+
+	{"DMIC L1", NULL, "DMIC CLK"},
+	{"DMIC L1", NULL, "DMIC1 Power"},
+	{"DMIC R1", NULL, "DMIC CLK"},
+	{"DMIC R1", NULL, "DMIC1 Power"},
+	{"DMIC L2", NULL, "DMIC CLK"},
+	{"DMIC L2", NULL, "DMIC2 Power"},
+	{"DMIC R2", NULL, "DMIC CLK"},
+	{"DMIC R2", NULL, "DMIC2 Power"},
+
+	{"Stereo ADC L2 Mux", "DMIC1", "DMIC L1"},
+	{"Stereo ADC L2 Mux", "DMIC2", "DMIC L2"},
+	{"Stereo ADC L2 Mux", "DIG MIX", "DIG MIXL"},
+	{"Stereo ADC L1 Mux", "ADC", "ADC L"},
+	{"Stereo ADC L1 Mux", "DIG MIX", "DIG MIXL"},
+
+	{"Stereo ADC R1 Mux", "ADC", "ADC R"},
+	{"Stereo ADC R1 Mux", "DIG MIX", "DIG MIXR"},
+	{"Stereo ADC R2 Mux", "DMIC1", "DMIC R1"},
+	{"Stereo ADC R2 Mux", "DMIC2", "DMIC R2"},
+	{"Stereo ADC R2 Mux", "DIG MIX", "DIG MIXR"},
+
+	{"Mono ADC L2 Mux", "DMIC L1", "DMIC L1"},
+	{"Mono ADC L2 Mux", "DMIC L2", "DMIC L2"},
+	{"Mono ADC L2 Mux", "Mono DAC MIXL", "Mono DAC MIXL"},
+	{"Mono ADC L1 Mux", "Mono DAC MIXL", "Mono DAC MIXL"},
+	{"Mono ADC L1 Mux", "ADCL", "ADC L"},
+
+	{"Mono ADC R1 Mux", "Mono DAC MIXR", "Mono DAC MIXR"},
+	{"Mono ADC R1 Mux", "ADCR", "ADC R"},
+	{"Mono ADC R2 Mux", "DMIC R1", "DMIC R1"},
+	{"Mono ADC R2 Mux", "DMIC R2", "DMIC R2"},
+	{"Mono ADC R2 Mux", "Mono DAC MIXR", "Mono DAC MIXR"},
+
+	{"Stereo ADC MIXL", "ADC1 Switch", "Stereo ADC L1 Mux"},
+	{"Stereo ADC MIXL", "ADC2 Switch", "Stereo ADC L2 Mux"},
+	{"Stereo ADC MIXL", NULL, "Stereo Filter"},
+	{"Stereo Filter", NULL, "PLL1", is_sys_clk_from_pll},
+
+	{"Stereo ADC MIXR", "ADC1 Switch", "Stereo ADC R1 Mux"},
+	{"Stereo ADC MIXR", "ADC2 Switch", "Stereo ADC R2 Mux"},
+	{"Stereo ADC MIXR", NULL, "Stereo Filter"},
+	{"Stereo Filter", NULL, "PLL1", is_sys_clk_from_pll},
+
+	{"Mono ADC MIXL", "ADC1 Switch", "Mono ADC L1 Mux"},
+	{"Mono ADC MIXL", "ADC2 Switch", "Mono ADC L2 Mux"},
+	{"Mono ADC MIXL", NULL, "Mono Left Filter"},
+	{"Mono Left Filter", NULL, "PLL1", is_sys_clk_from_pll},
+
+	{"Mono ADC MIXR", "ADC1 Switch", "Mono ADC R1 Mux"},
+	{"Mono ADC MIXR", "ADC2 Switch", "Mono ADC R2 Mux"},
+	{"Mono ADC MIXR", NULL, "Mono Right Filter"},
+	{"Mono Right Filter", NULL, "PLL1", is_sys_clk_from_pll},
+
+	{"IF2 ADC L", NULL, "Mono ADC MIXL"},
+	{"IF2 ADC R", NULL, "Mono ADC MIXR"},
+	{"IF1 ADC L", NULL, "Stereo ADC MIXL"},
+	{"IF1 ADC R", NULL, "Stereo ADC MIXR"},
+
+	{"IF1 ADC", NULL, "I2S1"},
+	{"IF1 ADC", NULL, "IF1 ADC L"},
+	{"IF1 ADC", NULL, "IF1 ADC R"},
+	{"IF2 ADC", NULL, "I2S2"},
+	{"IF2 ADC", NULL, "IF2 ADC L"},
+	{"IF2 ADC", NULL, "IF2 ADC R"},
+
+	{"DAI1 TX Mux", "1:1|2:2", "IF1 ADC"},
+	{"DAI1 TX Mux", "1:2|2:1", "IF2 ADC"},
+	{"DAI1 IF1 Mux", "1:1|2:1", "IF1 ADC"},
+	{"DAI1 IF2 Mux", "1:1|2:1", "IF2 ADC"},
+	{"SDI1 TX Mux", "IF1", "DAI1 IF1 Mux"},
+	{"SDI1 TX Mux", "IF2", "DAI1 IF2 Mux"},
+
+	{"DAI2 TX Mux", "1:2|2:1", "IF1 ADC"},
+	{"DAI2 TX Mux", "1:1|2:2", "IF2 ADC"},
+	{"DAI2 IF1 Mux", "1:2|2:2", "IF1 ADC"},
+	{"DAI2 IF2 Mux", "1:2|2:2", "IF2 ADC"},
+	{"SDI2 TX Mux", "IF1", "DAI2 IF1 Mux"},
+	{"SDI2 TX Mux", "IF2", "DAI2 IF2 Mux"},
+
+	{"AIF1TX", NULL, "DAI1 TX Mux"},
+	{"AIF1TX", NULL, "SDI1 TX Mux"},
+	{"AIF2TX", NULL, "DAI2 TX Mux"},
+	{"AIF2TX", NULL, "SDI2 TX Mux"},
+
+	{"DAI1 RX Mux", "1:1|2:2", "AIF1RX"},
+	{"DAI1 RX Mux", "1:1|2:1", "AIF1RX"},
+	{"DAI1 RX Mux", "1:2|2:1", "AIF2RX"},
+	{"DAI1 RX Mux", "1:2|2:2", "AIF2RX"},
+
+	{"DAI2 RX Mux", "1:2|2:1", "AIF1RX"},
+	{"DAI2 RX Mux", "1:1|2:1", "AIF1RX"},
+	{"DAI2 RX Mux", "1:1|2:2", "AIF2RX"},
+	{"DAI2 RX Mux", "1:2|2:2", "AIF2RX"},
+
+	{"IF1 DAC", NULL, "I2S1"},
+	{"IF1 DAC", NULL, "DAI1 RX Mux"},
+	{"IF2 DAC", NULL, "I2S2"},
+	{"IF2 DAC", NULL, "DAI2 RX Mux"},
+
+	{"IF1 DAC L", NULL, "IF1 DAC"},
+	{"IF1 DAC R", NULL, "IF1 DAC"},
+	{"IF2 DAC L", NULL, "IF2 DAC"},
+	{"IF2 DAC R", NULL, "IF2 DAC"},
+
+	{"DAC MIXL", "Stereo ADC Switch", "Stereo ADC MIXL"},
+	{"DAC MIXL", "INF1 Switch", "IF1 DAC L"},
+	{"DAC MIXR", "Stereo ADC Switch", "Stereo ADC MIXR"},
+	{"DAC MIXR", "INF1 Switch", "IF1 DAC R"},
+
+	{"Stereo DAC MIXL", "DAC L1 Switch", "DAC MIXL"},
+	{"Stereo DAC MIXL", "DAC L2 Switch", "IF2 DAC L"},
+	{"Stereo DAC MIXR", "DAC R1 Switch", "DAC MIXR"},
+	{"Stereo DAC MIXR", "DAC R2 Switch", "IF2 DAC R"},
+
+	{"Mono DAC MIXL", "DAC L1 Switch", "DAC MIXL"},
+	{"Mono DAC MIXL", "DAC L2 Switch", "IF2 DAC L"},
+	{"Mono DAC MIXL", "DAC R2 Switch", "IF2 DAC R"},
+	{"Mono DAC MIXR", "DAC R1 Switch", "DAC MIXR"},
+	{"Mono DAC MIXR", "DAC R2 Switch", "IF2 DAC R"},
+	{"Mono DAC MIXR", "DAC L2 Switch", "IF2 DAC L"},
+
+	{"DIG MIXL", "DAC L1 Switch", "DAC MIXL"},
+	{"DIG MIXL", "DAC L2 Switch", "IF2 DAC L"},
+	{"DIG MIXR", "DAC R1 Switch", "DAC MIXR"},
+	{"DIG MIXR", "DAC R2 Switch", "IF2 DAC R"},
+
+	{"IF2 DAC L", NULL, "DAC L2 Filter"},
+	{"IF2 DAC R", NULL, "DAC R2 Filter"},
+
+	{"DAC L1", NULL, "Stereo DAC MIXL"},
+	{"DAC L1", NULL, "PLL1", is_sys_clk_from_pll},
+	{"DAC R1", NULL, "Stereo DAC MIXR"},
+	{"DAC R1", NULL, "PLL1", is_sys_clk_from_pll},
+
+	{"SPK MIXL", "REC MIXL Switch", "RECMIXL"},
+	{"SPK MIXL", "INL Switch", "INL VOL"},
+	{"SPK MIXL", "DAC L1 Switch", "DAC L1"},
+	{"SPK MIXL", "OUT MIXL Switch", "OUT MIXL"},
+	{"SPK MIXR", "REC MIXR Switch", "RECMIXR"},
+	{"SPK MIXR", "INR Switch", "INR VOL"},
+	{"SPK MIXR", "DAC R1 Switch", "DAC R1"},
+	{"SPK MIXR", "OUT MIXR Switch", "OUT MIXR"},
+
+	{"OUT MIXL", "BST1 Switch", "BST1"},
+	{"OUT MIXL", "INL Switch", "INL VOL"},
+	{"OUT MIXL", "REC MIXL Switch", "RECMIXL"},
+	{"OUT MIXL", "DAC L1 Switch", "DAC L1"},
+
+	{"OUT MIXR", "BST2 Switch", "BST2"},
+	{"OUT MIXR", "BST1 Switch", "BST1"},
+	{"OUT MIXR", "INR Switch", "INR VOL"},
+	{"OUT MIXR", "REC MIXR Switch", "RECMIXR"},
+	{"OUT MIXR", "DAC R1 Switch", "DAC R1"},
+
+	{"SPKVOL L", NULL, "SPK MIXL"},
+	{"SPKVOL R", NULL, "SPK MIXR"},
+	{"HPOVOL L", NULL, "OUT MIXL"},
+	{"HPOVOL R", NULL, "OUT MIXR"},
+	{"OUTVOL L", NULL, "OUT MIXL"},
+	{"OUTVOL R", NULL, "OUT MIXR"},
+
+	{"SPOL MIX", "DAC R1 Switch", "DAC R1"},
+	{"SPOL MIX", "DAC L1 Switch", "DAC L1"},
+	{"SPOL MIX", "SPKVOL R Switch", "SPKVOL R"},
+	{"SPOL MIX", "SPKVOL L Switch", "SPKVOL L"},
+	{"SPOL MIX", "BST1 Switch", "BST1"},
+	{"SPOR MIX", "DAC R1 Switch", "DAC R1"},
+	{"SPOR MIX", "SPKVOL R Switch", "SPKVOL R"},
+	{"SPOR MIX", "BST1 Switch", "BST1"},
+
+	{"HPO MIX L", "HPO MIX DAC1 Switch", "DAC L1"},
+	{"HPO MIX L", "HPO MIX HPVOL Switch", "HPOVOL L"},
+	{"HPO MIX L", NULL, "HP L Amp"},
+	{"HPO MIX R", "HPO MIX DAC1 Switch", "DAC R1"},
+	{"HPO MIX R", "HPO MIX HPVOL Switch", "HPOVOL R"},
+	{"HPO MIX R", NULL, "HP R Amp"},
+
+	{"LOUT MIX", "DAC L1 Switch", "DAC L1"},
+	{"LOUT MIX", "DAC R1 Switch", "DAC R1"},
+	{"LOUT MIX", "OUTVOL L Switch", "OUTVOL L"},
+	{"LOUT MIX", "OUTVOL R Switch", "OUTVOL R"},
+
+	{"HP Amp", NULL, "HPO MIX L"},
+	{"HP Amp", NULL, "HPO MIX R"},
+
+	{"Speaker L Playback", "Switch", "SPOL MIX"},
+	{"Speaker R Playback", "Switch", "SPOR MIX"},
+	{"SPOLP", NULL, "Speaker L Playback"},
+	{"SPOLN", NULL, "Speaker L Playback"},
+	{"SPORP", NULL, "Speaker R Playback"},
+	{"SPORN", NULL, "Speaker R Playback"},
+
+	{"SPOLP", NULL, "Improve SPK Amp Drv"},
+	{"SPOLN", NULL, "Improve SPK Amp Drv"},
+	{"SPORP", NULL, "Improve SPK Amp Drv"},
+	{"SPORN", NULL, "Improve SPK Amp Drv"},
+
+	{"HPOL", NULL, "Improve HP Amp Drv"},
+	{"HPOR", NULL, "Improve HP Amp Drv"},
+
+	{"HP L Playback", "Switch", "HP Amp"},
+	{"HP R Playback", "Switch", "HP Amp"},
+	{"HPOL", NULL, "HP L Playback"},
+	{"HPOR", NULL, "HP R Playback"},
+	{"LOUTL", NULL, "LOUT MIX"},
+	{"LOUTR", NULL, "LOUT MIX"},
+};
+
+static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
+{
+	int ret = 0, val;
+
+	if (codec == NULL)
+		return -EINVAL;
+
+	val = snd_soc_read(codec, RT5639_I2S1_SDP);
+	val = (val & RT5639_I2S_IF_MASK) >> RT5639_I2S_IF_SFT;
+	switch (dai_id) {
+	case RT5639_AIF1:
+		switch (val) {
+		case RT5639_IF_123:
+		case RT5639_IF_132:
+			ret |= RT5639_U_IF1;
+			break;
+		case RT5639_IF_113:
+			ret |= RT5639_U_IF1;
+		case RT5639_IF_312:
+		case RT5639_IF_213:
+			ret |= RT5639_U_IF2;
+			break;
+		}
+		break;
+
+	case RT5639_AIF2:
+		switch (val) {
+		case RT5639_IF_231:
+		case RT5639_IF_213:
+			ret |= RT5639_U_IF1;
+			break;
+		case RT5639_IF_223:
+			ret |= RT5639_U_IF1;
+		case RT5639_IF_123:
+		case RT5639_IF_321:
+			ret |= RT5639_U_IF2;
+			break;
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
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
+static int rt5639_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val_len = 0, val_clk, mask_clk;
+	int dai_sel, pre_div, bclk_ms, frame_size;
+
+	rt5639->lrck[dai->id] = params_rate(params);
+	pre_div = get_clk_info(rt5639->sysclk, rt5639->lrck[dai->id]);
+	if (pre_div < 0) {
+		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
+			rt5639->lrck[dai->id], dai->id);
+		return -EINVAL;
+	}
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0) {
+		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
+		return frame_size;
+	}
+	if (frame_size > 32)
+		bclk_ms = 1;
+	else
+		bclk_ms = 0;
+	rt5639->bclk[dai->id] = rt5639->lrck[dai->id] * (32 << bclk_ms);
+
+	dev_dbg(dai->dev, "bclk is %dHz and lrck is %dHz\n",
+		rt5639->bclk[dai->id], rt5639->lrck[dai->id]);
+	dev_dbg(dai->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
+				bclk_ms, pre_div, dai->id);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		val_len |= RT5639_I2S_DL_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		val_len |= RT5639_I2S_DL_24;
+		break;
+	case SNDRV_PCM_FORMAT_S8:
+		val_len |= RT5639_I2S_DL_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dai_sel = get_sdp_info(codec, dai->id);
+	if (dai_sel < 0) {
+		dev_err(codec->dev, "Failed to get sdp info: %d\n", dai_sel);
+		return -EINVAL;
+	}
+	if (dai_sel & RT5639_U_IF1) {
+		mask_clk = RT5639_I2S_BCLK_MS1_MASK | RT5639_I2S_PD1_MASK;
+		val_clk = bclk_ms << RT5639_I2S_BCLK_MS1_SFT |
+			pre_div << RT5639_I2S_PD1_SFT;
+		snd_soc_update_bits(codec, RT5639_I2S1_SDP,
+			RT5639_I2S_DL_MASK, val_len);
+		snd_soc_update_bits(codec, RT5639_ADDA_CLK1, mask_clk, val_clk);
+	}
+	if (dai_sel & RT5639_U_IF2) {
+		mask_clk = RT5639_I2S_BCLK_MS2_MASK | RT5639_I2S_PD2_MASK;
+		val_clk = bclk_ms << RT5639_I2S_BCLK_MS2_SFT |
+			pre_div << RT5639_I2S_PD2_SFT;
+		snd_soc_update_bits(codec, RT5639_I2S2_SDP,
+			RT5639_I2S_DL_MASK, val_len);
+		snd_soc_update_bits(codec, RT5639_ADDA_CLK1, mask_clk, val_clk);
+	}
+
+	return 0;
+}
+
+static int rt5639_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+	int dai_sel;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		rt5639->master[dai->id] = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		reg_val |= RT5639_I2S_MS_S;
+		rt5639->master[dai->id] = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg_val |= RT5639_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg_val |= RT5639_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		reg_val |= RT5639_I2S_DF_PCM_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		reg_val  |= RT5639_I2S_DF_PCM_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dai_sel = get_sdp_info(codec, dai->id);
+	if (dai_sel < 0) {
+		dev_err(codec->dev, "Failed to get sdp info: %d\n", dai_sel);
+		return -EINVAL;
+	}
+	if (dai_sel & RT5639_U_IF1) {
+		snd_soc_update_bits(codec, RT5639_I2S1_SDP,
+			RT5639_I2S_MS_MASK | RT5639_I2S_BP_MASK |
+			RT5639_I2S_DF_MASK, reg_val);
+	}
+	if (dai_sel & RT5639_U_IF2) {
+		snd_soc_update_bits(codec, RT5639_I2S2_SDP,
+			RT5639_I2S_MS_MASK | RT5639_I2S_BP_MASK |
+			RT5639_I2S_DF_MASK, reg_val);
+	}
+
+	return 0;
+}
+
+static int rt5639_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	if (freq == rt5639->sysclk && clk_id == rt5639->sysclk_src)
+		return 0;
+
+	switch (clk_id) {
+	case RT5639_SCLK_S_MCLK:
+		reg_val |= RT5639_SCLK_SRC_MCLK;
+		break;
+	case RT5639_SCLK_S_PLL1:
+		reg_val |= RT5639_SCLK_SRC_PLL1;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, RT5639_GLB_CLK,
+		RT5639_SCLK_SRC_MASK, reg_val);
+	rt5639->sysclk = freq;
+	rt5639->sysclk_src = clk_id;
+
+	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+	return 0;
+}
+
+/**
+ * rt5639_pll_calc - Calculate PLL M/N/K code.
+ * @freq_in: external clock provided to codec.
+ * @freq_out: target clock which codec works on.
+ * @pll_code: Pointer to structure with M, N, K and bypass flag.
+ *
+ * Calculate M/N/K code to configure PLL for codec. And K is assigned to 2
+ * which make calculation more efficiently.
+ *
+ * Returns 0 for success or negative error code.
+ */
+static int rt5639_pll_calc(const unsigned int freq_in,
+	const unsigned int freq_out, struct rt5639_pll_code *pll_code)
+{
+	int max_n = RT5639_PLL_N_MAX, max_m = RT5639_PLL_M_MAX;
+	int n = 0, m = 0, red, n_t, m_t, in_t, out_t;
+	int red_t = abs(freq_out - freq_in);
+	bool bypass = false;
+
+	if (RT5639_PLL_INP_MAX < freq_in || RT5639_PLL_INP_MIN > freq_in)
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
+static int rt5639_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
+			unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	struct rt5639_pll_code *pll_code = &rt5639->pll_code;
+	int ret, dai_sel;
+
+	if (source == rt5639->pll_src && freq_in == rt5639->pll_in &&
+	    freq_out == rt5639->pll_out)
+		return 0;
+
+	if (!freq_in || !freq_out) {
+		dev_dbg(codec->dev, "PLL disabled\n");
+
+		rt5639->pll_in = 0;
+		rt5639->pll_out = 0;
+		snd_soc_update_bits(codec, RT5639_GLB_CLK,
+			RT5639_SCLK_SRC_MASK, RT5639_SCLK_SRC_MCLK);
+		return 0;
+	}
+
+	switch (source) {
+	case RT5639_PLL1_S_MCLK:
+		snd_soc_update_bits(codec, RT5639_GLB_CLK,
+			RT5639_PLL1_SRC_MASK, RT5639_PLL1_SRC_MCLK);
+		break;
+	case RT5639_PLL1_S_BCLK1:
+	case RT5639_PLL1_S_BCLK2:
+		dai_sel = get_sdp_info(codec, dai->id);
+		if (dai_sel < 0) {
+			dev_err(codec->dev,
+				"Failed to get sdp info: %d\n", dai_sel);
+			return -EINVAL;
+		}
+		if (dai_sel & RT5639_U_IF1) {
+			snd_soc_update_bits(codec, RT5639_GLB_CLK,
+				RT5639_PLL1_SRC_MASK, RT5639_PLL1_SRC_BCLK1);
+		}
+		if (dai_sel & RT5639_U_IF2) {
+			snd_soc_update_bits(codec, RT5639_GLB_CLK,
+				RT5639_PLL1_SRC_MASK, RT5639_PLL1_SRC_BCLK2);
+		}
+		break;
+	default:
+		dev_err(codec->dev, "Unknown PLL source %d\n", source);
+		return -EINVAL;
+	}
+
+	ret = rt5639_pll_calc(freq_in, freq_out, pll_code);
+	if (ret < 0) {
+		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
+		return ret;
+	}
+
+	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=2\n", pll_code->m_bp,
+		(pll_code->m_bp ? 0 : pll_code->m_code), pll_code->n_code);
+
+	snd_soc_write(codec, RT5639_PLL_CTRL1,
+		pll_code->n_code << RT5639_PLL_N_SFT | pll_code->k_code);
+	snd_soc_write(codec, RT5639_PLL_CTRL2,
+		(pll_code->m_bp ? 0 : pll_code->m_code) << RT5639_PLL_M_SFT |
+		pll_code->m_bp << RT5639_PLL_M_BP_SFT);
+
+	rt5639->pll_in = freq_in;
+	rt5639->pll_out = freq_out;
+	rt5639->pll_src = source;
+
+	return 0;
+}
+
+static int rt5639_set_bias_level(struct snd_soc_codec *codec,
+			enum snd_soc_bias_level level)
+{
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
+			regcache_cache_only(rt5639->regmap, false);
+			snd_soc_update_bits(codec, RT5639_PWR_ANLG1,
+				RT5639_PWR_VREF1 | RT5639_PWR_MB |
+				RT5639_PWR_BG | RT5639_PWR_VREF2,
+				RT5639_PWR_VREF1 | RT5639_PWR_MB |
+				RT5639_PWR_BG | RT5639_PWR_VREF2);
+			usleep_range(10000, 15000);
+			snd_soc_update_bits(codec, RT5639_PWR_ANLG1,
+				RT5639_PWR_FV1 | RT5639_PWR_FV2,
+				RT5639_PWR_FV1 | RT5639_PWR_FV2);
+			regcache_sync(rt5639->regmap);
+			snd_soc_update_bits(codec, RT5639_DUMMY1,
+						0x0301, 0x0301);
+			snd_soc_update_bits(codec, RT5639_MICBIAS,
+						0x0030, 0x0030);
+		}
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, RT5639_DEPOP_M1, 0x0004);
+		snd_soc_write(codec, RT5639_DEPOP_M2, 0x1100);
+		snd_soc_update_bits(codec, RT5639_DUMMY1, 0x1, 0);
+		snd_soc_write(codec, RT5639_PWR_DIG1, 0x0000);
+		snd_soc_write(codec, RT5639_PWR_DIG2, 0x0000);
+		snd_soc_write(codec, RT5639_PWR_VOL, 0x0000);
+		snd_soc_write(codec, RT5639_PWR_MIXER, 0x0000);
+		snd_soc_write(codec, RT5639_PWR_ANLG1, 0x0000);
+		snd_soc_write(codec, RT5639_PWR_ANLG2, 0x0000);
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
+static int rt5639_probe(struct snd_soc_codec *codec)
+{
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	rt5639->codec = codec;
+	codec->control_data = rt5639->regmap;
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	rt5639_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_update_bits(codec, RT5639_DUMMY1, 0x0301, 0x0301);
+	snd_soc_update_bits(codec, RT5639_MICBIAS, 0x0030, 0x0030);
+
+	return 0;
+}
+
+static int rt5639_remove(struct snd_soc_codec *codec)
+{
+	rt5639_reset(codec);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rt5639_suspend(struct snd_soc_codec *codec)
+{
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+
+	rt5639_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	rt5639_reset(codec);
+	regcache_cache_only(rt5639->regmap, true);
+	regcache_mark_dirty(rt5639->regmap);
+	if (gpio_is_valid(rt5639->pdata.ldo1_en))
+		gpio_set_value_cansleep(rt5639->pdata.ldo1_en, 0);
+
+	return 0;
+}
+
+static int rt5639_resume(struct snd_soc_codec *codec)
+{
+	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
+
+	if (gpio_is_valid(rt5639->pdata.ldo1_en)) {
+		gpio_set_value_cansleep(rt5639->pdata.ldo1_en, 1);
+		msleep(400);
+	}
+
+	return 0;
+}
+#else
+#define rt5639_suspend NULL
+#define rt5639_resume NULL
+#endif
+
+#define RT5639_STEREO_RATES SNDRV_PCM_RATE_8000_96000
+#define RT5639_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
+
+static const struct snd_soc_dai_ops rt5639_aif_dai_ops = {
+	.hw_params = rt5639_hw_params,
+	.set_fmt = rt5639_set_dai_fmt,
+	.set_sysclk = rt5639_set_dai_sysclk,
+	.set_pll = rt5639_set_dai_pll,
+};
+
+static struct snd_soc_dai_driver rt5639_dai[] = {
+	{
+		.name = "rt5639-aif1",
+		.id = RT5639_AIF1,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5639_STEREO_RATES,
+			.formats = RT5639_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5639_STEREO_RATES,
+			.formats = RT5639_FORMATS,
+		},
+		.ops = &rt5639_aif_dai_ops,
+	},
+	{
+		.name = "rt5639-aif2",
+		.id = RT5639_AIF2,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5639_STEREO_RATES,
+			.formats = RT5639_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5639_STEREO_RATES,
+			.formats = RT5639_FORMATS,
+		},
+		.ops = &rt5639_aif_dai_ops,
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_rt5639 = {
+	.probe = rt5639_probe,
+	.remove = rt5639_remove,
+	.suspend = rt5639_suspend,
+	.resume = rt5639_resume,
+	.set_bias_level = rt5639_set_bias_level,
+	.idle_bias_off = true,
+	.controls = rt5639_snd_controls,
+	.num_controls = ARRAY_SIZE(rt5639_snd_controls),
+	.dapm_widgets = rt5639_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt5639_dapm_widgets),
+	.dapm_routes = rt5639_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt5639_dapm_routes),
+};
+
+static const struct regmap_config rt5639_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = RT5639_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5639_ranges) *
+					       RT5639_PR_SPACING),
+	.volatile_reg = rt5639_volatile_register,
+	.readable_reg = rt5639_readable_register,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = rt5639_reg,
+	.num_reg_defaults = ARRAY_SIZE(rt5639_reg),
+	.ranges = rt5639_ranges,
+	.num_ranges = ARRAY_SIZE(rt5639_ranges),
+};
+
+static const struct i2c_device_id rt5639_i2c_id[] = {
+	{ "rt5639", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rt5639_i2c_id);
+
+static int rt5639_parse_dt(struct rt5639_priv *rt5639, struct device_node *np)
+{
+	rt5639->pdata.in1_diff = of_property_read_bool(np,
+					"realtek,in1-differential");
+	rt5639->pdata.in2_diff = of_property_read_bool(np,
+					"realtek,in2-differential");
+
+	rt5639->pdata.ldo1_en = of_get_named_gpio(np,
+					"realtek,ldo1-en-gpios", 0);
+	/*
+	 * LDO1_EN is optional (it may be statically tied on the board).
+	 * -ENOENT means that the property doesn't exist, i.e. there is no
+	 * GPIO, so is not an error. Any other error code means the property
+	 * exists, but could not be parsed.
+	 */
+	if (!gpio_is_valid(rt5639->pdata.ldo1_en) &&
+			(rt5639->pdata.ldo1_en != -ENOENT))
+		return rt5639->pdata.ldo1_en;
+
+	return 0;
+}
+
+static int rt5639_i2c_probe(struct i2c_client *i2c,
+		    const struct i2c_device_id *id)
+{
+	struct rt5639_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	struct rt5639_priv *rt5639;
+	int ret;
+	unsigned int val;
+
+	rt5639 = devm_kzalloc(&i2c->dev,
+				sizeof(struct rt5639_priv),
+				GFP_KERNEL);
+	if (NULL == rt5639)
+		return -ENOMEM;
+	i2c_set_clientdata(i2c, rt5639);
+
+	if (pdata) {
+		rt5639->pdata = *pdata;
+		/*
+		 * Translate zero'd out (default) pdata value to an invalid
+		 * GPIO ID. This makes the pdata and DT paths consistent in
+		 * terms of the value left in this field when no GPIO is
+		 * specified, but means we can't actually use GPIO 0.
+		 */
+		if (!rt5639->pdata.ldo1_en)
+			rt5639->pdata.ldo1_en = -EINVAL;
+	} else if (i2c->dev.of_node) {
+		ret = rt5639_parse_dt(rt5639, i2c->dev.of_node);
+		if (ret)
+			return ret;
+	} else
+		rt5639->pdata.ldo1_en = -EINVAL;
+
+	rt5639->regmap = devm_regmap_init_i2c(i2c, &rt5639_regmap);
+	if (IS_ERR(rt5639->regmap)) {
+		ret = PTR_ERR(rt5639->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (gpio_is_valid(rt5639->pdata.ldo1_en)) {
+		ret = devm_gpio_request_one(&i2c->dev, rt5639->pdata.ldo1_en,
+					    GPIOF_OUT_INIT_HIGH,
+					    "RT5639 LDO1_EN");
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to request LDO1_EN %d: %d\n",
+				rt5639->pdata.ldo1_en, ret);
+			return ret;
+		}
+		msleep(400);
+	}
+
+	regmap_read(rt5639->regmap, RT5639_VENDOR_ID2, &val);
+	if (val != RT5639_DEVICE_ID) {
+		dev_err(&i2c->dev,
+			"Device with ID register %x is not rt5640/39\n", val);
+		return -ENODEV;
+	}
+
+	regmap_write(rt5639->regmap, RT5639_RESET, 0);
+
+	ret = regmap_register_patch(rt5639->regmap, init_list,
+				    ARRAY_SIZE(init_list));
+	if (ret != 0)
+		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
+
+	if (rt5639->pdata.in1_diff)
+		regmap_update_bits(rt5639->regmap, RT5639_IN1_IN2,
+					RT5639_IN_DF1, RT5639_IN_DF1);
+
+	if (rt5639->pdata.in2_diff)
+		regmap_update_bits(rt5639->regmap, RT5639_IN3_IN4,
+					RT5639_IN_DF2, RT5639_IN_DF2);
+
+	rt5639->hp_mute = 1;
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5639,
+			rt5639_dai, ARRAY_SIZE(rt5639_dai));
+	if (ret < 0)
+		goto err;
+
+	return 0;
+err:
+	return ret;
+}
+
+static int rt5639_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+static struct i2c_driver rt5639_i2c_driver = {
+	.driver = {
+		.name = "rt5639",
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(rt5639_acpi_match),
+	},
+	.probe = rt5639_i2c_probe,
+	.remove   = rt5639_i2c_remove,
+	.id_table = rt5639_i2c_id,
+};
+module_i2c_driver(rt5639_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC RT5639 driver");
+MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rt5639.h b/sound/soc/codecs/rt5639.h
new file mode 100644
index 0000000..b9b7f4a
--- /dev/null
+++ b/sound/soc/codecs/rt5639.h
@@ -0,0 +1,1928 @@
+/*
+ * rt5639.h  --  RT5639 ALSA SoC audio driver
+ *
+ * Copyright 2011 Realtek Microelectronics
+ * Author: Bard Liao <bardliao@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _RT5639_H
+#define _RT5639_H
+
+#include <sound/rt5639.h>
+
+/* Info */
+#define RT5639_RESET				0x00
+#define RT5639_VENDOR_ID			0xfd
+#define RT5639_VENDOR_ID1			0xfe
+#define RT5639_VENDOR_ID2			0xff
+/*  I/O - Output */
+#define RT5639_SPK_VOL				0x01
+#define RT5639_HP_VOL				0x02
+#define RT5639_OUTPUT				0x03
+/* I/O - Input */
+#define RT5639_IN1_IN2				0x0d
+#define RT5639_IN3_IN4				0x0e
+#define RT5639_INL_INR_VOL			0x0f
+/* I/O - ADC/DAC/DMIC */
+#define RT5639_DAC1_DIG_VOL			0x19
+#define RT5639_DAC2_DIG_VOL			0x1a
+#define RT5639_DAC2_CTRL			0x1b
+#define RT5639_ADC_DIG_VOL			0x1c
+#define RT5639_ADC_DATA				0x1d
+#define RT5639_ADC_BST_VOL			0x1e
+/* Mixer - D-D */
+#define RT5639_STO_ADC_MIXER			0x27
+#define RT5639_MONO_ADC_MIXER			0x28
+#define RT5639_AD_DA_MIXER			0x29
+#define RT5639_STO_DAC_MIXER			0x2a
+#define RT5639_MONO_DAC_MIXER			0x2b
+#define RT5639_DIG_MIXER			0x2c
+#define RT5639_DIG_INF_DATA			0x2f
+/* Mixer - ADC */
+#define RT5639_REC_L1_MIXER			0x3b
+#define RT5639_REC_L2_MIXER			0x3c
+#define RT5639_REC_R1_MIXER			0x3d
+#define RT5639_REC_R2_MIXER			0x3e
+/* Mixer - DAC */
+#define RT5639_HPO_MIXER			0x45
+#define RT5639_SPK_L_MIXER			0x46
+#define RT5639_SPK_R_MIXER			0x47
+#define RT5639_SPO_L_MIXER			0x48
+#define RT5639_SPO_R_MIXER			0x49
+#define RT5639_SPO_CLSD_RATIO			0x4a
+#define RT5639_OUT_L1_MIXER			0x4d
+#define RT5639_OUT_L2_MIXER			0x4e
+#define RT5639_OUT_L3_MIXER			0x4f
+#define RT5639_OUT_R1_MIXER			0x50
+#define RT5639_OUT_R2_MIXER			0x51
+#define RT5639_OUT_R3_MIXER			0x52
+#define RT5639_LOUT_MIXER			0x53
+/* Power */
+#define RT5639_PWR_DIG1				0x61
+#define RT5639_PWR_DIG2				0x62
+#define RT5639_PWR_ANLG1			0x63
+#define RT5639_PWR_ANLG2			0x64
+#define RT5639_PWR_MIXER			0x65
+#define RT5639_PWR_VOL				0x66
+/* Private Register Control */
+#define RT5639_PRIV_INDEX			0x6a
+#define RT5639_PRIV_DATA			0x6c
+/* Format - ADC/DAC */
+#define RT5639_I2S1_SDP				0x70
+#define RT5639_I2S2_SDP				0x71
+#define RT5639_ADDA_CLK1			0x73
+#define RT5639_DMIC				0x75
+/* Function - Analog */
+#define RT5639_GLB_CLK				0x80
+#define RT5639_PLL_CTRL1			0x81
+#define RT5639_PLL_CTRL2			0x82
+#define RT5639_ASRC_1				0x83
+#define RT5639_ASRC_2				0x84
+#define RT5639_ASRC_3				0x85
+#define RT5639_ASRC_4				0x89
+#define RT5639_ASRC_5				0x8a
+#define RT5639_CLS_D_OVCD			0x8c
+#define RT5639_CLS_D_OUT			0x8d
+#define RT5639_DEPOP_M1				0x8e
+#define RT5639_DEPOP_M2				0x8f
+#define RT5639_DEPOP_M3				0x90
+#define RT5639_CHARGE_PUMP			0x91
+#define RT5639_PV_DET_SPK_G			0x92
+#define RT5639_MICBIAS				0x93
+/* Function - Digital */
+#define RT5639_EQ_CTRL1				0xb0
+#define RT5639_EQ_CTRL2				0xb1
+#define RT5639_WIND_FILTER			0xb2
+#define RT5639_DRC_AGC_1			0xb4
+#define RT5639_DRC_AGC_2			0xb5
+#define RT5639_DRC_AGC_3			0xb6
+#define RT5639_JD_CTRL				0xbb
+#define RT5639_IRQ_CTRL1			0xbd
+#define RT5639_IRQ_CTRL2			0xbe
+#define RT5639_INT_IRQ_ST			0xbf
+#define RT5639_GPIO_CTRL1			0xc0
+#define RT5639_GPIO_CTRL2			0xc2
+#define RT5639_PGM_REG_ARR1			0xc8
+#define RT5639_PGM_REG_ARR2			0xc9
+#define RT5639_PGM_REG_ARR3			0xca
+#define RT5639_PGM_REG_ARR4			0xcb
+#define RT5639_PGM_REG_ARR5			0xcc
+#define RT5639_ADJ_HPF				0xd3
+#define RT5639_HP_CALIB_AMP_DET			0xd6
+#define RT5639_SV_ZCD1				0xd9
+/* Dummy Register */
+#define RT5639_DUMMY1				0xfa
+#define RT5639_DUMMY2				0xfb
+#define RT5639_DUMMY3				0xfc
+
+
+/* Index of Codec Private Register definition */
+#define RT5639_CHPUMP_INT_REG1			0x24
+#define RT5639_MAMP_INT_REG2			0x37
+#define RT5639_3D_SPK				0x63
+#define RT5639_WND_1				0x6c
+#define RT5639_WND_2				0x6d
+#define RT5639_WND_3				0x6e
+#define RT5639_WND_4				0x6f
+#define RT5639_WND_5				0x70
+#define RT5639_WND_8				0x73
+#define RT5639_DIP_SPK_INF			0x75
+#define RT5639_HP_DCC_INT1			0x77
+#define RT5639_EQ_BW_LOP			0xa0
+#define RT5639_EQ_GN_LOP			0xa1
+#define RT5639_EQ_FC_BP1			0xa2
+#define RT5639_EQ_BW_BP1			0xa3
+#define RT5639_EQ_GN_BP1			0xa4
+#define RT5639_EQ_FC_BP2			0xa5
+#define RT5639_EQ_BW_BP2			0xa6
+#define RT5639_EQ_GN_BP2			0xa7
+#define RT5639_EQ_FC_BP3			0xa8
+#define RT5639_EQ_BW_BP3			0xa9
+#define RT5639_EQ_GN_BP3			0xaa
+#define RT5639_EQ_FC_BP4			0xab
+#define RT5639_EQ_BW_BP4			0xac
+#define RT5639_EQ_GN_BP4			0xad
+#define RT5639_EQ_FC_HIP1			0xae
+#define RT5639_EQ_GN_HIP1			0xaf
+#define RT5639_EQ_FC_HIP2			0xb0
+#define RT5639_EQ_BW_HIP2			0xb1
+#define RT5639_EQ_GN_HIP2			0xb2
+#define RT5639_EQ_PRE_VOL			0xb3
+#define RT5639_EQ_PST_VOL			0xb4
+
+/* global definition */
+#define RT5639_L_MUTE				(0x1 << 15)
+#define RT5639_L_MUTE_SFT			15
+#define RT5639_VOL_L_MUTE			(0x1 << 14)
+#define RT5639_VOL_L_SFT			14
+#define RT5639_R_MUTE				(0x1 << 7)
+#define RT5639_R_MUTE_SFT			7
+#define RT5639_VOL_R_MUTE			(0x1 << 6)
+#define RT5639_VOL_R_SFT			6
+#define RT5639_L_VOL_MASK			(0x3f << 8)
+#define RT5639_L_VOL_SFT			8
+#define RT5639_R_VOL_MASK			(0x3f)
+#define RT5639_R_VOL_SFT			0
+
+/* IN1 and IN2 Control (0x0d) */
+/* IN3 and IN4 Control (0x0e) */
+#define RT5639_BST_SFT1				12
+#define RT5639_BST_SFT2				8
+#define RT5639_IN_DF1				(0x1 << 7)
+#define RT5639_IN_SFT1				7
+#define RT5639_IN_DF2				(0x1 << 6)
+#define RT5639_IN_SFT2				6
+
+/* INL and INR Volume Control (0x0f) */
+#define RT5639_INL_SEL_MASK			(0x1 << 15)
+#define RT5639_INL_SEL_SFT			15
+#define RT5639_INL_SEL_IN4P			(0x0 << 15)
+#define RT5639_INL_SEL_MONOP			(0x1 << 15)
+#define RT5639_INL_VOL_MASK			(0x1f << 8)
+#define RT5639_INL_VOL_SFT			8
+#define RT5639_INR_SEL_MASK			(0x1 << 7)
+#define RT5639_INR_SEL_SFT			7
+#define RT5639_INR_SEL_IN4N			(0x0 << 7)
+#define RT5639_INR_SEL_MONON			(0x1 << 7)
+#define RT5639_INR_VOL_MASK			(0x1f)
+#define RT5639_INR_VOL_SFT			0
+
+/* DAC1 Digital Volume (0x19) */
+#define RT5639_DAC_L1_VOL_MASK			(0xff << 8)
+#define RT5639_DAC_L1_VOL_SFT			8
+#define RT5639_DAC_R1_VOL_MASK			(0xff)
+#define RT5639_DAC_R1_VOL_SFT			0
+
+/* DAC2 Digital Volume (0x1a) */
+#define RT5639_DAC_L2_VOL_MASK			(0xff << 8)
+#define RT5639_DAC_L2_VOL_SFT			8
+#define RT5639_DAC_R2_VOL_MASK			(0xff)
+#define RT5639_DAC_R2_VOL_SFT			0
+
+/* DAC2 Control (0x1b) */
+#define RT5639_M_DAC_L2_VOL			(0x1 << 13)
+#define RT5639_M_DAC_L2_VOL_SFT			13
+#define RT5639_M_DAC_R2_VOL			(0x1 << 12)
+#define RT5639_M_DAC_R2_VOL_SFT			12
+
+/* ADC Digital Volume Control (0x1c) */
+#define RT5639_ADC_L_VOL_MASK			(0x7f << 8)
+#define RT5639_ADC_L_VOL_SFT			8
+#define RT5639_ADC_R_VOL_MASK			(0x7f)
+#define RT5639_ADC_R_VOL_SFT			0
+
+/* Mono ADC Digital Volume Control (0x1d) */
+#define RT5639_MONO_ADC_L_VOL_MASK		(0x7f << 8)
+#define RT5639_MONO_ADC_L_VOL_SFT		8
+#define RT5639_MONO_ADC_R_VOL_MASK		(0x7f)
+#define RT5639_MONO_ADC_R_VOL_SFT		0
+
+/* ADC Boost Volume Control (0x1e) */
+#define RT5639_ADC_L_BST_MASK			(0x3 << 14)
+#define RT5639_ADC_L_BST_SFT			14
+#define RT5639_ADC_R_BST_MASK			(0x3 << 12)
+#define RT5639_ADC_R_BST_SFT			12
+#define RT5639_ADC_COMP_MASK			(0x3 << 10)
+#define RT5639_ADC_COMP_SFT			10
+
+/* Stereo ADC Mixer Control (0x27) */
+#define RT5639_M_ADC_L1				(0x1 << 14)
+#define RT5639_M_ADC_L1_SFT			14
+#define RT5639_M_ADC_L2				(0x1 << 13)
+#define RT5639_M_ADC_L2_SFT			13
+#define RT5639_ADC_1_SRC_MASK			(0x1 << 12)
+#define RT5639_ADC_1_SRC_SFT			12
+#define RT5639_ADC_1_SRC_ADC			(0x1 << 12)
+#define RT5639_ADC_1_SRC_DACMIX			(0x0 << 12)
+#define RT5639_ADC_2_SRC_MASK			(0x3 << 10)
+#define RT5639_ADC_2_SRC_SFT			10
+#define RT5639_ADC_2_SRC_DMIC1			(0x0 << 10)
+#define RT5639_ADC_2_SRC_DMIC2			(0x1 << 10)
+#define RT5639_ADC_2_SRC_DACMIX			(0x2 << 10)
+#define RT5639_M_ADC_R1				(0x1 << 6)
+#define RT5639_M_ADC_R1_SFT			6
+#define RT5639_M_ADC_R2				(0x1 << 5)
+#define RT5639_M_ADC_R2_SFT			5
+
+/* Mono ADC Mixer Control (0x28) */
+#define RT5639_M_MONO_ADC_L1			(0x1 << 14)
+#define RT5639_M_MONO_ADC_L1_SFT		14
+#define RT5639_M_MONO_ADC_L2			(0x1 << 13)
+#define RT5639_M_MONO_ADC_L2_SFT		13
+#define RT5639_MONO_ADC_L1_SRC_MASK		(0x1 << 12)
+#define RT5639_MONO_ADC_L1_SRC_SFT		12
+#define RT5639_MONO_ADC_L1_SRC_DACMIXL		(0x0 << 12)
+#define RT5639_MONO_ADC_L1_SRC_ADCL		(0x1 << 12)
+#define RT5639_MONO_ADC_L2_SRC_MASK		(0x3 << 10)
+#define RT5639_MONO_ADC_L2_SRC_SFT		10
+#define RT5639_MONO_ADC_L2_SRC_DMIC_L1		(0x0 << 10)
+#define RT5639_MONO_ADC_L2_SRC_DMIC_L2		(0x1 << 10)
+#define RT5639_MONO_ADC_L2_SRC_DACMIXL		(0x2 << 10)
+#define RT5639_M_MONO_ADC_R1			(0x1 << 6)
+#define RT5639_M_MONO_ADC_R1_SFT		6
+#define RT5639_M_MONO_ADC_R2			(0x1 << 5)
+#define RT5639_M_MONO_ADC_R2_SFT		5
+#define RT5639_MONO_ADC_R1_SRC_MASK		(0x1 << 4)
+#define RT5639_MONO_ADC_R1_SRC_SFT		4
+#define RT5639_MONO_ADC_R1_SRC_ADCR		(0x1 << 4)
+#define RT5639_MONO_ADC_R1_SRC_DACMIXR		(0x0 << 4)
+#define RT5639_MONO_ADC_R2_SRC_MASK		(0x3 << 2)
+#define RT5639_MONO_ADC_R2_SRC_SFT		2
+#define RT5639_MONO_ADC_R2_SRC_DMIC_R1		(0x0 << 2)
+#define RT5639_MONO_ADC_R2_SRC_DMIC_R2		(0x1 << 2)
+#define RT5639_MONO_ADC_R2_SRC_DACMIXR		(0x2 << 2)
+
+/* ADC Mixer to DAC Mixer Control (0x29) */
+#define RT5639_M_ADCMIX_L			(0x1 << 15)
+#define RT5639_M_ADCMIX_L_SFT			15
+#define RT5639_M_IF1_DAC_L			(0x1 << 14)
+#define RT5639_M_IF1_DAC_L_SFT			14
+#define RT5639_M_ADCMIX_R			(0x1 << 7)
+#define RT5639_M_ADCMIX_R_SFT			7
+#define RT5639_M_IF1_DAC_R			(0x1 << 6)
+#define RT5639_M_IF1_DAC_R_SFT			6
+
+/* Stereo DAC Mixer Control (0x2a) */
+#define RT5639_M_DAC_L1				(0x1 << 14)
+#define RT5639_M_DAC_L1_SFT			14
+#define RT5639_DAC_L1_STO_L_VOL_MASK		(0x1 << 13)
+#define RT5639_DAC_L1_STO_L_VOL_SFT		13
+#define RT5639_M_DAC_L2				(0x1 << 12)
+#define RT5639_M_DAC_L2_SFT			12
+#define RT5639_DAC_L2_STO_L_VOL_MASK		(0x1 << 11)
+#define RT5639_DAC_L2_STO_L_VOL_SFT		11
+#define RT5639_M_DAC_R1				(0x1 << 6)
+#define RT5639_M_DAC_R1_SFT			6
+#define RT5639_DAC_R1_STO_R_VOL_MASK		(0x1 << 5)
+#define RT5639_DAC_R1_STO_R_VOL_SFT		5
+#define RT5639_M_DAC_R2				(0x1 << 4)
+#define RT5639_M_DAC_R2_SFT			4
+#define RT5639_DAC_R2_STO_R_VOL_MASK		(0x1 << 3)
+#define RT5639_DAC_R2_STO_R_VOL_SFT		3
+
+/* Mono DAC Mixer Control (0x2b) */
+#define RT5639_M_DAC_L1_MONO_L			(0x1 << 14)
+#define RT5639_M_DAC_L1_MONO_L_SFT		14
+#define RT5639_DAC_L1_MONO_L_VOL_MASK		(0x1 << 13)
+#define RT5639_DAC_L1_MONO_L_VOL_SFT		13
+#define RT5639_M_DAC_L2_MONO_L			(0x1 << 12)
+#define RT5639_M_DAC_L2_MONO_L_SFT		12
+#define RT5639_DAC_L2_MONO_L_VOL_MASK		(0x1 << 11)
+#define RT5639_DAC_L2_MONO_L_VOL_SFT		11
+#define RT5639_M_DAC_R2_MONO_L			(0x1 << 10)
+#define RT5639_M_DAC_R2_MONO_L_SFT		10
+#define RT5639_DAC_R2_MONO_L_VOL_MASK		(0x1 << 9)
+#define RT5639_DAC_R2_MONO_L_VOL_SFT		9
+#define RT5639_M_DAC_R1_MONO_R			(0x1 << 6)
+#define RT5639_M_DAC_R1_MONO_R_SFT		6
+#define RT5639_DAC_R1_MONO_R_VOL_MASK		(0x1 << 5)
+#define RT5639_DAC_R1_MONO_R_VOL_SFT		5
+#define RT5639_M_DAC_R2_MONO_R			(0x1 << 4)
+#define RT5639_M_DAC_R2_MONO_R_SFT		4
+#define RT5639_DAC_R2_MONO_R_VOL_MASK		(0x1 << 3)
+#define RT5639_DAC_R2_MONO_R_VOL_SFT		3
+#define RT5639_M_DAC_L2_MONO_R			(0x1 << 2)
+#define RT5639_M_DAC_L2_MONO_R_SFT		2
+#define RT5639_DAC_L2_MONO_R_VOL_MASK		(0x1 << 1)
+#define RT5639_DAC_L2_MONO_R_VOL_SFT		1
+
+/* Digital Mixer Control (0x2c) */
+#define RT5639_M_STO_L_DAC_L			(0x1 << 15)
+#define RT5639_M_STO_L_DAC_L_SFT		15
+#define RT5639_STO_L_DAC_L_VOL_MASK		(0x1 << 14)
+#define RT5639_STO_L_DAC_L_VOL_SFT		14
+#define RT5639_M_DAC_L2_DAC_L			(0x1 << 13)
+#define RT5639_M_DAC_L2_DAC_L_SFT		13
+#define RT5639_DAC_L2_DAC_L_VOL_MASK		(0x1 << 12)
+#define RT5639_DAC_L2_DAC_L_VOL_SFT		12
+#define RT5639_M_STO_R_DAC_R			(0x1 << 11)
+#define RT5639_M_STO_R_DAC_R_SFT		11
+#define RT5639_STO_R_DAC_R_VOL_MASK		(0x1 << 10)
+#define RT5639_STO_R_DAC_R_VOL_SFT		10
+#define RT5639_M_DAC_R2_DAC_R			(0x1 << 9)
+#define RT5639_M_DAC_R2_DAC_R_SFT		9
+#define RT5639_DAC_R2_DAC_R_VOL_MASK		(0x1 << 8)
+#define RT5639_DAC_R2_DAC_R_VOL_SFT		8
+
+/* DSP Path Control 2 (0x2e) */
+#define RT5639_DAC_L2_SEL_MASK			(0x3 << 14)
+#define RT5639_DAC_L2_SEL_SFT			14
+#define RT5639_DAC_L2_SEL_IF2			(0x0 << 14)
+#define RT5639_DAC_R2_SEL_MASK			(0x3 << 12)
+#define RT5639_DAC_R2_SEL_SFT			12
+#define RT5639_DAC_R2_SEL_IF2			(0x0 << 12)
+
+/* Digital Interface Data Control (0x2f) */
+#define RT5639_IF1_DAC_SEL_MASK			(0x3 << 14)
+#define RT5639_IF1_DAC_SEL_SFT			14
+#define RT5639_IF1_DAC_SEL_NOR			(0x0 << 14)
+#define RT5639_IF1_DAC_SEL_L2R			(0x1 << 14)
+#define RT5639_IF1_DAC_SEL_R2L			(0x2 << 14)
+#define RT5639_IF1_DAC_SEL_SWAP			(0x3 << 14)
+#define RT5639_IF1_ADC_SEL_MASK			(0x3 << 12)
+#define RT5639_IF1_ADC_SEL_SFT			12
+#define RT5639_IF1_ADC_SEL_NOR			(0x0 << 12)
+#define RT5639_IF1_ADC_SEL_L2R			(0x1 << 12)
+#define RT5639_IF1_ADC_SEL_R2L			(0x2 << 12)
+#define RT5639_IF1_ADC_SEL_SWAP			(0x3 << 12)
+#define RT5639_IF2_DAC_SEL_MASK			(0x3 << 10)
+#define RT5639_IF2_DAC_SEL_SFT			10
+#define RT5639_IF2_DAC_SEL_NOR			(0x0 << 10)
+#define RT5639_IF2_DAC_SEL_L2R			(0x1 << 10)
+#define RT5639_IF2_DAC_SEL_R2L			(0x2 << 10)
+#define RT5639_IF2_DAC_SEL_SWAP			(0x3 << 10)
+#define RT5639_IF2_ADC_SEL_MASK			(0x3 << 8)
+#define RT5639_IF2_ADC_SEL_SFT			8
+#define RT5639_IF2_ADC_SEL_NOR			(0x0 << 8)
+#define RT5639_IF2_ADC_SEL_L2R			(0x1 << 8)
+#define RT5639_IF2_ADC_SEL_R2L			(0x2 << 8)
+#define RT5639_IF2_ADC_SEL_SWAP			(0x3 << 8)
+#define RT5639_IF3_DAC_SEL_MASK			(0x3 << 6)
+#define RT5639_IF3_DAC_SEL_SFT			6
+#define RT5639_IF3_DAC_SEL_NOR			(0x0 << 6)
+#define RT5639_IF3_DAC_SEL_L2R			(0x1 << 6)
+#define RT5639_IF3_DAC_SEL_R2L			(0x2 << 6)
+#define RT5639_IF3_DAC_SEL_SWAP			(0x3 << 6)
+#define RT5639_IF3_ADC_SEL_MASK			(0x3 << 4)
+#define RT5639_IF3_ADC_SEL_SFT			4
+#define RT5639_IF3_ADC_SEL_NOR			(0x0 << 4)
+#define RT5639_IF3_ADC_SEL_L2R			(0x1 << 4)
+#define RT5639_IF3_ADC_SEL_R2L			(0x2 << 4)
+#define RT5639_IF3_ADC_SEL_SWAP			(0x3 << 4)
+
+/* REC Left Mixer Control 1 (0x3b) */
+#define RT5639_G_HP_L_RM_L_MASK			(0x7 << 13)
+#define RT5639_G_HP_L_RM_L_SFT			13
+#define RT5639_G_IN_L_RM_L_MASK			(0x7 << 10)
+#define RT5639_G_IN_L_RM_L_SFT			10
+#define RT5639_G_BST4_RM_L_MASK			(0x7 << 7)
+#define RT5639_G_BST4_RM_L_SFT			7
+#define RT5639_G_BST3_RM_L_MASK			(0x7 << 4)
+#define RT5639_G_BST3_RM_L_SFT			4
+#define RT5639_G_BST2_RM_L_MASK			(0x7 << 1)
+#define RT5639_G_BST2_RM_L_SFT			1
+
+/* REC Left Mixer Control 2 (0x3c) */
+#define RT5639_G_BST1_RM_L_MASK			(0x7 << 13)
+#define RT5639_G_BST1_RM_L_SFT			13
+#define RT5639_G_OM_L_RM_L_MASK			(0x7 << 10)
+#define RT5639_G_OM_L_RM_L_SFT			10
+#define RT5639_M_HP_L_RM_L			(0x1 << 6)
+#define RT5639_M_HP_L_RM_L_SFT			6
+#define RT5639_M_IN_L_RM_L			(0x1 << 5)
+#define RT5639_M_IN_L_RM_L_SFT			5
+#define RT5639_M_BST4_RM_L			(0x1 << 4)
+#define RT5639_M_BST4_RM_L_SFT			4
+#define RT5639_M_BST3_RM_L			(0x1 << 3)
+#define RT5639_M_BST3_RM_L_SFT			3
+#define RT5639_M_BST2_RM_L			(0x1 << 2)
+#define RT5639_M_BST2_RM_L_SFT			2
+#define RT5639_M_BST1_RM_L			(0x1 << 1)
+#define RT5639_M_BST1_RM_L_SFT			1
+#define RT5639_M_OM_L_RM_L			(0x1)
+#define RT5639_M_OM_L_RM_L_SFT			0
+
+/* REC Right Mixer Control 1 (0x3d) */
+#define RT5639_G_HP_R_RM_R_MASK			(0x7 << 13)
+#define RT5639_G_HP_R_RM_R_SFT			13
+#define RT5639_G_IN_R_RM_R_MASK			(0x7 << 10)
+#define RT5639_G_IN_R_RM_R_SFT			10
+#define RT5639_G_BST4_RM_R_MASK			(0x7 << 7)
+#define RT5639_G_BST4_RM_R_SFT			7
+#define RT5639_G_BST3_RM_R_MASK			(0x7 << 4)
+#define RT5639_G_BST3_RM_R_SFT			4
+#define RT5639_G_BST2_RM_R_MASK			(0x7 << 1)
+#define RT5639_G_BST2_RM_R_SFT			1
+
+/* REC Right Mixer Control 2 (0x3e) */
+#define RT5639_G_BST1_RM_R_MASK			(0x7 << 13)
+#define RT5639_G_BST1_RM_R_SFT			13
+#define RT5639_G_OM_R_RM_R_MASK			(0x7 << 10)
+#define RT5639_G_OM_R_RM_R_SFT			10
+#define RT5639_M_HP_R_RM_R			(0x1 << 6)
+#define RT5639_M_HP_R_RM_R_SFT			6
+#define RT5639_M_IN_R_RM_R			(0x1 << 5)
+#define RT5639_M_IN_R_RM_R_SFT			5
+#define RT5639_M_BST4_RM_R			(0x1 << 4)
+#define RT5639_M_BST4_RM_R_SFT			4
+#define RT5639_M_BST3_RM_R			(0x1 << 3)
+#define RT5639_M_BST3_RM_R_SFT			3
+#define RT5639_M_BST2_RM_R			(0x1 << 2)
+#define RT5639_M_BST2_RM_R_SFT			2
+#define RT5639_M_BST1_RM_R			(0x1 << 1)
+#define RT5639_M_BST1_RM_R_SFT			1
+#define RT5639_M_OM_R_RM_R			(0x1)
+#define RT5639_M_OM_R_RM_R_SFT			0
+
+/* HPMIX Control (0x45) */
+#define RT5639_M_DAC2_HM			(0x1 << 15)
+#define RT5639_M_DAC2_HM_SFT			15
+#define RT5639_M_DAC1_HM			(0x1 << 14)
+#define RT5639_M_DAC1_HM_SFT			14
+#define RT5639_M_HPVOL_HM			(0x1 << 13)
+#define RT5639_M_HPVOL_HM_SFT			13
+#define RT5639_G_HPOMIX_MASK			(0x1 << 12)
+#define RT5639_G_HPOMIX_SFT			12
+
+/* SPK Left Mixer Control (0x46) */
+#define RT5639_G_RM_L_SM_L_MASK			(0x3 << 14)
+#define RT5639_G_RM_L_SM_L_SFT			14
+#define RT5639_G_IN_L_SM_L_MASK			(0x3 << 12)
+#define RT5639_G_IN_L_SM_L_SFT			12
+#define RT5639_G_DAC_L1_SM_L_MASK		(0x3 << 10)
+#define RT5639_G_DAC_L1_SM_L_SFT		10
+#define RT5639_G_DAC_L2_SM_L_MASK		(0x3 << 8)
+#define RT5639_G_DAC_L2_SM_L_SFT		8
+#define RT5639_G_OM_L_SM_L_MASK			(0x3 << 6)
+#define RT5639_G_OM_L_SM_L_SFT			6
+#define RT5639_M_RM_L_SM_L			(0x1 << 5)
+#define RT5639_M_RM_L_SM_L_SFT			5
+#define RT5639_M_IN_L_SM_L			(0x1 << 4)
+#define RT5639_M_IN_L_SM_L_SFT			4
+#define RT5639_M_DAC_L1_SM_L			(0x1 << 3)
+#define RT5639_M_DAC_L1_SM_L_SFT		3
+#define RT5639_M_DAC_L2_SM_L			(0x1 << 2)
+#define RT5639_M_DAC_L2_SM_L_SFT		2
+#define RT5639_M_OM_L_SM_L			(0x1 << 1)
+#define RT5639_M_OM_L_SM_L_SFT		1
+
+/* SPK Right Mixer Control (0x47) */
+#define RT5639_G_RM_R_SM_R_MASK			(0x3 << 14)
+#define RT5639_G_RM_R_SM_R_SFT			14
+#define RT5639_G_IN_R_SM_R_MASK			(0x3 << 12)
+#define RT5639_G_IN_R_SM_R_SFT			12
+#define RT5639_G_DAC_R1_SM_R_MASK		(0x3 << 10)
+#define RT5639_G_DAC_R1_SM_R_SFT		10
+#define RT5639_G_DAC_R2_SM_R_MASK		(0x3 << 8)
+#define RT5639_G_DAC_R2_SM_R_SFT		8
+#define RT5639_G_OM_R_SM_R_MASK			(0x3 << 6)
+#define RT5639_G_OM_R_SM_R_SFT			6
+#define RT5639_M_RM_R_SM_R			(0x1 << 5)
+#define RT5639_M_RM_R_SM_R_SFT			5
+#define RT5639_M_IN_R_SM_R			(0x1 << 4)
+#define RT5639_M_IN_R_SM_R_SFT			4
+#define RT5639_M_DAC_R1_SM_R			(0x1 << 3)
+#define RT5639_M_DAC_R1_SM_R_SFT		3
+#define RT5639_M_DAC_R2_SM_R			(0x1 << 2)
+#define RT5639_M_DAC_R2_SM_R_SFT		2
+#define RT5639_M_OM_R_SM_R			(0x1 << 1)
+#define RT5639_M_OM_R_SM_R_SFT			1
+
+/* SPOLMIX Control (0x48) */
+#define RT5639_M_DAC_R1_SPM_L			(0x1 << 15)
+#define RT5639_M_DAC_R1_SPM_L_SFT		15
+#define RT5639_M_DAC_L1_SPM_L			(0x1 << 14)
+#define RT5639_M_DAC_L1_SPM_L_SFT		14
+#define RT5639_M_SV_R_SPM_L			(0x1 << 13)
+#define RT5639_M_SV_R_SPM_L_SFT			13
+#define RT5639_M_SV_L_SPM_L			(0x1 << 12)
+#define RT5639_M_SV_L_SPM_L_SFT			12
+#define RT5639_M_BST1_SPM_L			(0x1 << 11)
+#define RT5639_M_BST1_SPM_L_SFT			11
+
+/* SPORMIX Control (0x49) */
+#define RT5639_M_DAC_R1_SPM_R			(0x1 << 13)
+#define RT5639_M_DAC_R1_SPM_R_SFT		13
+#define RT5639_M_SV_R_SPM_R			(0x1 << 12)
+#define RT5639_M_SV_R_SPM_R_SFT			12
+#define RT5639_M_BST1_SPM_R			(0x1 << 11)
+#define RT5639_M_BST1_SPM_R_SFT			11
+
+/* SPOLMIX / SPORMIX Ratio Control (0x4a) */
+#define RT5639_SPO_CLSD_RATIO_MASK		(0x7)
+#define RT5639_SPO_CLSD_RATIO_SFT		0
+
+/* Output Left Mixer Control 1 (0x4d) */
+#define RT5639_G_BST3_OM_L_MASK			(0x7 << 13)
+#define RT5639_G_BST3_OM_L_SFT			13
+#define RT5639_G_BST2_OM_L_MASK			(0x7 << 10)
+#define RT5639_G_BST2_OM_L_SFT			10
+#define RT5639_G_BST1_OM_L_MASK			(0x7 << 7)
+#define RT5639_G_BST1_OM_L_SFT			7
+#define RT5639_G_IN_L_OM_L_MASK			(0x7 << 4)
+#define RT5639_G_IN_L_OM_L_SFT			4
+#define RT5639_G_RM_L_OM_L_MASK			(0x7 << 1)
+#define RT5639_G_RM_L_OM_L_SFT			1
+
+/* Output Left Mixer Control 2 (0x4e) */
+#define RT5639_G_DAC_R2_OM_L_MASK		(0x7 << 13)
+#define RT5639_G_DAC_R2_OM_L_SFT		13
+#define RT5639_G_DAC_L2_OM_L_MASK		(0x7 << 10)
+#define RT5639_G_DAC_L2_OM_L_SFT		10
+#define RT5639_G_DAC_L1_OM_L_MASK		(0x7 << 7)
+#define RT5639_G_DAC_L1_OM_L_SFT		7
+
+/* Output Left Mixer Control 3 (0x4f) */
+#define RT5639_M_BST3_OM_L			(0x1 << 7)
+#define RT5639_M_BST3_OM_L_SFT			7
+#define RT5639_M_BST2_OM_L			(0x1 << 6)
+#define RT5639_M_BST2_OM_L_SFT			6
+#define RT5639_M_BST1_OM_L			(0x1 << 5)
+#define RT5639_M_BST1_OM_L_SFT			5
+#define RT5639_M_IN_L_OM_L			(0x1 << 4)
+#define RT5639_M_IN_L_OM_L_SFT			4
+#define RT5639_M_RM_L_OM_L			(0x1 << 3)
+#define RT5639_M_RM_L_OM_L_SFT			3
+#define RT5639_M_DAC_R2_OM_L			(0x1 << 2)
+#define RT5639_M_DAC_R2_OM_L_SFT		2
+#define RT5639_M_DAC_L2_OM_L			(0x1 << 1)
+#define RT5639_M_DAC_L2_OM_L_SFT		1
+#define RT5639_M_DAC_L1_OM_L			(0x1)
+#define RT5639_M_DAC_L1_OM_L_SFT		0
+
+/* Output Right Mixer Control 1 (0x50) */
+#define RT5639_G_BST4_OM_R_MASK			(0x7 << 13)
+#define RT5639_G_BST4_OM_R_SFT			13
+#define RT5639_G_BST2_OM_R_MASK			(0x7 << 10)
+#define RT5639_G_BST2_OM_R_SFT			10
+#define RT5639_G_BST1_OM_R_MASK			(0x7 << 7)
+#define RT5639_G_BST1_OM_R_SFT			7
+#define RT5639_G_IN_R_OM_R_MASK			(0x7 << 4)
+#define RT5639_G_IN_R_OM_R_SFT			4
+#define RT5639_G_RM_R_OM_R_MASK			(0x7 << 1)
+#define RT5639_G_RM_R_OM_R_SFT			1
+
+/* Output Right Mixer Control 2 (0x51) */
+#define RT5639_G_DAC_L2_OM_R_MASK		(0x7 << 13)
+#define RT5639_G_DAC_L2_OM_R_SFT		13
+#define RT5639_G_DAC_R2_OM_R_MASK		(0x7 << 10)
+#define RT5639_G_DAC_R2_OM_R_SFT		10
+#define RT5639_G_DAC_R1_OM_R_MASK		(0x7 << 7)
+#define RT5639_G_DAC_R1_OM_R_SFT		7
+
+/* Output Right Mixer Control 3 (0x52) */
+#define RT5639_M_BST4_OM_R			(0x1 << 7)
+#define RT5639_M_BST4_OM_R_SFT			7
+#define RT5639_M_BST2_OM_R			(0x1 << 6)
+#define RT5639_M_BST2_OM_R_SFT			6
+#define RT5639_M_BST1_OM_R			(0x1 << 5)
+#define RT5639_M_BST1_OM_R_SFT			5
+#define RT5639_M_IN_R_OM_R			(0x1 << 4)
+#define RT5639_M_IN_R_OM_R_SFT			4
+#define RT5639_M_RM_R_OM_R			(0x1 << 3)
+#define RT5639_M_RM_R_OM_R_SFT			3
+#define RT5639_M_DAC_L2_OM_R			(0x1 << 2)
+#define RT5639_M_DAC_L2_OM_R_SFT		2
+#define RT5639_M_DAC_R2_OM_R			(0x1 << 1)
+#define RT5639_M_DAC_R2_OM_R_SFT		1
+#define RT5639_M_DAC_R1_OM_R			(0x1)
+#define RT5639_M_DAC_R1_OM_R_SFT		0
+
+/* LOUT Mixer Control (0x53) */
+#define RT5639_M_DAC_L1_LM			(0x1 << 15)
+#define RT5639_M_DAC_L1_LM_SFT			15
+#define RT5639_M_DAC_R1_LM			(0x1 << 14)
+#define RT5639_M_DAC_R1_LM_SFT			14
+#define RT5639_M_OV_L_LM			(0x1 << 13)
+#define RT5639_M_OV_L_LM_SFT			13
+#define RT5639_M_OV_R_LM			(0x1 << 12)
+#define RT5639_M_OV_R_LM_SFT			12
+#define RT5639_G_LOUTMIX_MASK			(0x1 << 11)
+#define RT5639_G_LOUTMIX_SFT			11
+
+/* Power Management for Digital 1 (0x61) */
+#define RT5639_PWR_I2S1				(0x1 << 15)
+#define RT5639_PWR_I2S1_BIT			15
+#define RT5639_PWR_I2S2				(0x1 << 14)
+#define RT5639_PWR_I2S2_BIT			14
+#define RT5639_PWR_DAC_L1			(0x1 << 12)
+#define RT5639_PWR_DAC_L1_BIT			12
+#define RT5639_PWR_DAC_R1			(0x1 << 11)
+#define RT5639_PWR_DAC_R1_BIT			11
+#define RT5639_PWR_DAC_L2			(0x1 << 7)
+#define RT5639_PWR_DAC_L2_BIT			7
+#define RT5639_PWR_DAC_R2			(0x1 << 6)
+#define RT5639_PWR_DAC_R2_BIT			6
+#define RT5639_PWR_ADC_L			(0x1 << 2)
+#define RT5639_PWR_ADC_L_BIT			2
+#define RT5639_PWR_ADC_R			(0x1 << 1)
+#define RT5639_PWR_ADC_R_BIT			1
+#define RT5639_PWR_CLS_D			(0x1)
+#define RT5639_PWR_CLS_D_BIT			0
+
+/* Power Management for Digital 2 (0x62) */
+#define RT5639_PWR_ADC_SF			(0x1 << 15)
+#define RT5639_PWR_ADC_SF_BIT			15
+#define RT5639_PWR_ADC_MF_L			(0x1 << 14)
+#define RT5639_PWR_ADC_MF_L_BIT			14
+#define RT5639_PWR_ADC_MF_R			(0x1 << 13)
+#define RT5639_PWR_ADC_MF_R_BIT			13
+#define RT5639_PWR_I2S_DSP			(0x1 << 12)
+#define RT5639_PWR_I2S_DSP_BIT			12
+
+/* Power Management for Analog 1 (0x63) */
+#define RT5639_PWR_VREF1			(0x1 << 15)
+#define RT5639_PWR_VREF1_BIT			15
+#define RT5639_PWR_FV1				(0x1 << 14)
+#define RT5639_PWR_FV1_BIT			14
+#define RT5639_PWR_MB				(0x1 << 13)
+#define RT5639_PWR_MB_BIT			13
+#define RT5639_PWR_LM				(0x1 << 12)
+#define RT5639_PWR_LM_BIT			12
+#define RT5639_PWR_BG				(0x1 << 11)
+#define RT5639_PWR_BG_BIT			11
+#define RT5639_PWR_MM				(0x1 << 10)
+#define RT5639_PWR_MM_BIT			10
+#define RT5639_PWR_MA				(0x1 << 8)
+#define RT5639_PWR_MA_BIT			8
+#define RT5639_PWR_HP_L				(0x1 << 7)
+#define RT5639_PWR_HP_L_BIT			7
+#define RT5639_PWR_HP_R				(0x1 << 6)
+#define RT5639_PWR_HP_R_BIT			6
+#define RT5639_PWR_HA				(0x1 << 5)
+#define RT5639_PWR_HA_BIT			5
+#define RT5639_PWR_VREF2			(0x1 << 4)
+#define RT5639_PWR_VREF2_BIT			4
+#define RT5639_PWR_FV2				(0x1 << 3)
+#define RT5639_PWR_FV2_BIT			3
+#define RT5639_PWR_LDO2				(0x1 << 2)
+#define RT5639_PWR_LDO2_BIT			2
+
+/* Power Management for Analog 2 (0x64) */
+#define RT5639_PWR_BST1				(0x1 << 15)
+#define RT5639_PWR_BST1_BIT			15
+#define RT5639_PWR_BST2				(0x1 << 14)
+#define RT5639_PWR_BST2_BIT			14
+#define RT5639_PWR_BST3				(0x1 << 13)
+#define RT5639_PWR_BST3_BIT			13
+#define RT5639_PWR_BST4				(0x1 << 12)
+#define RT5639_PWR_BST4_BIT			12
+#define RT5639_PWR_MB1				(0x1 << 11)
+#define RT5639_PWR_MB1_BIT			11
+#define RT5639_PWR_PLL				(0x1 << 9)
+#define RT5639_PWR_PLL_BIT			9
+
+/* Power Management for Mixer (0x65) */
+#define RT5639_PWR_OM_L				(0x1 << 15)
+#define RT5639_PWR_OM_L_BIT			15
+#define RT5639_PWR_OM_R				(0x1 << 14)
+#define RT5639_PWR_OM_R_BIT			14
+#define RT5639_PWR_SM_L				(0x1 << 13)
+#define RT5639_PWR_SM_L_BIT			13
+#define RT5639_PWR_SM_R				(0x1 << 12)
+#define RT5639_PWR_SM_R_BIT			12
+#define RT5639_PWR_RM_L				(0x1 << 11)
+#define RT5639_PWR_RM_L_BIT			11
+#define RT5639_PWR_RM_R				(0x1 << 10)
+#define RT5639_PWR_RM_R_BIT			10
+
+/* Power Management for Volume (0x66) */
+#define RT5639_PWR_SV_L				(0x1 << 15)
+#define RT5639_PWR_SV_L_BIT			15
+#define RT5639_PWR_SV_R				(0x1 << 14)
+#define RT5639_PWR_SV_R_BIT			14
+#define RT5639_PWR_OV_L				(0x1 << 13)
+#define RT5639_PWR_OV_L_BIT			13
+#define RT5639_PWR_OV_R				(0x1 << 12)
+#define RT5639_PWR_OV_R_BIT			12
+#define RT5639_PWR_HV_L				(0x1 << 11)
+#define RT5639_PWR_HV_L_BIT			11
+#define RT5639_PWR_HV_R				(0x1 << 10)
+#define RT5639_PWR_HV_R_BIT			10
+#define RT5639_PWR_IN_L				(0x1 << 9)
+#define RT5639_PWR_IN_L_BIT			9
+#define RT5639_PWR_IN_R				(0x1 << 8)
+#define RT5639_PWR_IN_R_BIT			8
+
+/* I2S1/2/3 Audio Serial Data Port Control (0x70 0x71 0x72) */
+#define RT5639_I2S_MS_MASK			(0x1 << 15)
+#define RT5639_I2S_MS_SFT			15
+#define RT5639_I2S_MS_M				(0x0 << 15)
+#define RT5639_I2S_MS_S				(0x1 << 15)
+#define RT5639_I2S_IF_MASK			(0x7 << 12)
+#define RT5639_I2S_IF_SFT			12
+#define RT5639_I2S_O_CP_MASK			(0x3 << 10)
+#define RT5639_I2S_O_CP_SFT			10
+#define RT5639_I2S_O_CP_OFF			(0x0 << 10)
+#define RT5639_I2S_O_CP_U_LAW			(0x1 << 10)
+#define RT5639_I2S_O_CP_A_LAW			(0x2 << 10)
+#define RT5639_I2S_I_CP_MASK			(0x3 << 8)
+#define RT5639_I2S_I_CP_SFT			8
+#define RT5639_I2S_I_CP_OFF			(0x0 << 8)
+#define RT5639_I2S_I_CP_U_LAW			(0x1 << 8)
+#define RT5639_I2S_I_CP_A_LAW			(0x2 << 8)
+#define RT5639_I2S_BP_MASK			(0x1 << 7)
+#define RT5639_I2S_BP_SFT			7
+#define RT5639_I2S_BP_NOR			(0x0 << 7)
+#define RT5639_I2S_BP_INV			(0x1 << 7)
+#define RT5639_I2S_DL_MASK			(0x3 << 2)
+#define RT5639_I2S_DL_SFT			2
+#define RT5639_I2S_DL_16			(0x0 << 2)
+#define RT5639_I2S_DL_20			(0x1 << 2)
+#define RT5639_I2S_DL_24			(0x2 << 2)
+#define RT5639_I2S_DL_8				(0x3 << 2)
+#define RT5639_I2S_DF_MASK			(0x3)
+#define RT5639_I2S_DF_SFT			0
+#define RT5639_I2S_DF_I2S			(0x0)
+#define RT5639_I2S_DF_LEFT			(0x1)
+#define RT5639_I2S_DF_PCM_A			(0x2)
+#define RT5639_I2S_DF_PCM_B			(0x3)
+
+/* I2S2 Audio Serial Data Port Control (0x71) */
+#define RT5639_I2S2_SDI_MASK			(0x1 << 6)
+#define RT5639_I2S2_SDI_SFT			6
+#define RT5639_I2S2_SDI_I2S1			(0x0 << 6)
+#define RT5639_I2S2_SDI_I2S2			(0x1 << 6)
+
+/* ADC/DAC Clock Control 1 (0x73) */
+#define RT5639_I2S_BCLK_MS1_MASK		(0x1 << 15)
+#define RT5639_I2S_BCLK_MS1_SFT			15
+#define RT5639_I2S_BCLK_MS1_32			(0x0 << 15)
+#define RT5639_I2S_BCLK_MS1_64			(0x1 << 15)
+#define RT5639_I2S_PD1_MASK			(0x7 << 12)
+#define RT5639_I2S_PD1_SFT			12
+#define RT5639_I2S_PD1_1			(0x0 << 12)
+#define RT5639_I2S_PD1_2			(0x1 << 12)
+#define RT5639_I2S_PD1_3			(0x2 << 12)
+#define RT5639_I2S_PD1_4			(0x3 << 12)
+#define RT5639_I2S_PD1_6			(0x4 << 12)
+#define RT5639_I2S_PD1_8			(0x5 << 12)
+#define RT5639_I2S_PD1_12			(0x6 << 12)
+#define RT5639_I2S_PD1_16			(0x7 << 12)
+#define RT5639_I2S_BCLK_MS2_MASK		(0x1 << 11)
+#define RT5639_I2S_BCLK_MS2_SFT			11
+#define RT5639_I2S_BCLK_MS2_32			(0x0 << 11)
+#define RT5639_I2S_BCLK_MS2_64			(0x1 << 11)
+#define RT5639_I2S_PD2_MASK			(0x7 << 8)
+#define RT5639_I2S_PD2_SFT			8
+#define RT5639_I2S_PD2_1			(0x0 << 8)
+#define RT5639_I2S_PD2_2			(0x1 << 8)
+#define RT5639_I2S_PD2_3			(0x2 << 8)
+#define RT5639_I2S_PD2_4			(0x3 << 8)
+#define RT5639_I2S_PD2_6			(0x4 << 8)
+#define RT5639_I2S_PD2_8			(0x5 << 8)
+#define RT5639_I2S_PD2_12			(0x6 << 8)
+#define RT5639_I2S_PD2_16			(0x7 << 8)
+#define RT5639_I2S_BCLK_MS3_MASK		(0x1 << 7)
+#define RT5639_I2S_BCLK_MS3_SFT			7
+#define RT5639_I2S_BCLK_MS3_32			(0x0 << 7)
+#define RT5639_I2S_BCLK_MS3_64			(0x1 << 7)
+#define RT5639_I2S_PD3_MASK			(0x7 << 4)
+#define RT5639_I2S_PD3_SFT			4
+#define RT5639_I2S_PD3_1			(0x0 << 4)
+#define RT5639_I2S_PD3_2			(0x1 << 4)
+#define RT5639_I2S_PD3_3			(0x2 << 4)
+#define RT5639_I2S_PD3_4			(0x3 << 4)
+#define RT5639_I2S_PD3_6			(0x4 << 4)
+#define RT5639_I2S_PD3_8			(0x5 << 4)
+#define RT5639_I2S_PD3_12			(0x6 << 4)
+#define RT5639_I2S_PD3_16			(0x7 << 4)
+#define RT5639_DAC_OSR_MASK			(0x3 << 2)
+#define RT5639_DAC_OSR_SFT			2
+#define RT5639_DAC_OSR_128			(0x0 << 2)
+#define RT5639_DAC_OSR_64			(0x1 << 2)
+#define RT5639_DAC_OSR_32			(0x2 << 2)
+#define RT5639_DAC_OSR_16			(0x3 << 2)
+#define RT5639_ADC_OSR_MASK			(0x3)
+#define RT5639_ADC_OSR_SFT			0
+#define RT5639_ADC_OSR_128			(0x0)
+#define RT5639_ADC_OSR_64			(0x1)
+#define RT5639_ADC_OSR_32			(0x2)
+#define RT5639_ADC_OSR_16			(0x3)
+
+/* ADC/DAC Clock Control 2 (0x74) */
+#define RT5639_DAC_L_OSR_MASK			(0x3 << 14)
+#define RT5639_DAC_L_OSR_SFT			14
+#define RT5639_DAC_L_OSR_128			(0x0 << 14)
+#define RT5639_DAC_L_OSR_64			(0x1 << 14)
+#define RT5639_DAC_L_OSR_32			(0x2 << 14)
+#define RT5639_DAC_L_OSR_16			(0x3 << 14)
+#define RT5639_ADC_R_OSR_MASK			(0x3 << 12)
+#define RT5639_ADC_R_OSR_SFT			12
+#define RT5639_ADC_R_OSR_128			(0x0 << 12)
+#define RT5639_ADC_R_OSR_64			(0x1 << 12)
+#define RT5639_ADC_R_OSR_32			(0x2 << 12)
+#define RT5639_ADC_R_OSR_16			(0x3 << 12)
+#define RT5639_DAHPF_EN				(0x1 << 11)
+#define RT5639_DAHPF_EN_SFT			11
+#define RT5639_ADHPF_EN				(0x1 << 10)
+#define RT5639_ADHPF_EN_SFT			10
+
+/* Digital Microphone Control (0x75) */
+#define RT5639_DMIC_1_EN_MASK			(0x1 << 15)
+#define RT5639_DMIC_1_EN_SFT			15
+#define RT5639_DMIC_1_DIS			(0x0 << 15)
+#define RT5639_DMIC_1_EN			(0x1 << 15)
+#define RT5639_DMIC_2_EN_MASK			(0x1 << 14)
+#define RT5639_DMIC_2_EN_SFT			14
+#define RT5639_DMIC_2_DIS			(0x0 << 14)
+#define RT5639_DMIC_2_EN			(0x1 << 14)
+#define RT5639_DMIC_1L_LH_MASK			(0x1 << 13)
+#define RT5639_DMIC_1L_LH_SFT			13
+#define RT5639_DMIC_1L_LH_FALLING		(0x0 << 13)
+#define RT5639_DMIC_1L_LH_RISING		(0x1 << 13)
+#define RT5639_DMIC_1R_LH_MASK			(0x1 << 12)
+#define RT5639_DMIC_1R_LH_SFT			12
+#define RT5639_DMIC_1R_LH_FALLING		(0x0 << 12)
+#define RT5639_DMIC_1R_LH_RISING		(0x1 << 12)
+#define RT5639_DMIC_1_DP_MASK			(0x1 << 11)
+#define RT5639_DMIC_1_DP_SFT			11
+#define RT5639_DMIC_1_DP_GPIO3			(0x0 << 11)
+#define RT5639_DMIC_1_DP_IN1P			(0x1 << 11)
+#define RT5639_DMIC_2_DP_MASK			(0x1 << 10)
+#define RT5639_DMIC_2_DP_SFT			10
+#define RT5639_DMIC_2_DP_GPIO4			(0x0 << 10)
+#define RT5639_DMIC_2_DP_IN1N			(0x1 << 10)
+#define RT5639_DMIC_2L_LH_MASK			(0x1 << 9)
+#define RT5639_DMIC_2L_LH_SFT			9
+#define RT5639_DMIC_2L_LH_FALLING		(0x0 << 9)
+#define RT5639_DMIC_2L_LH_RISING		(0x1 << 9)
+#define RT5639_DMIC_2R_LH_MASK			(0x1 << 8)
+#define RT5639_DMIC_2R_LH_SFT			8
+#define RT5639_DMIC_2R_LH_FALLING		(0x0 << 8)
+#define RT5639_DMIC_2R_LH_RISING		(0x1 << 8)
+#define RT5639_DMIC_CLK_MASK			(0x7 << 5)
+#define RT5639_DMIC_CLK_SFT			5
+
+/* Global Clock Control (0x80) */
+#define RT5639_SCLK_SRC_MASK			(0x3 << 14)
+#define RT5639_SCLK_SRC_SFT			14
+#define RT5639_SCLK_SRC_MCLK			(0x0 << 14)
+#define RT5639_SCLK_SRC_PLL1			(0x1 << 14)
+#define RT5639_PLL1_SRC_MASK			(0x3 << 12)
+#define RT5639_PLL1_SRC_SFT			12
+#define RT5639_PLL1_SRC_MCLK			(0x0 << 12)
+#define RT5639_PLL1_SRC_BCLK1			(0x1 << 12)
+#define RT5639_PLL1_SRC_BCLK2			(0x2 << 12)
+#define RT5639_PLL1_SRC_BCLK3			(0x3 << 12)
+#define RT5639_PLL1_PD_MASK			(0x1 << 3)
+#define RT5639_PLL1_PD_SFT			3
+#define RT5639_PLL1_PD_1			(0x0 << 3)
+#define RT5639_PLL1_PD_2			(0x1 << 3)
+
+#define RT5639_PLL_INP_MAX			40000000
+#define RT5639_PLL_INP_MIN			256000
+/* PLL M/N/K Code Control 1 (0x81) */
+#define RT5639_PLL_N_MAX			0x1ff
+#define RT5639_PLL_N_MASK			(RT5639_PLL_N_MAX << 7)
+#define RT5639_PLL_N_SFT			7
+#define RT5639_PLL_K_MAX			0x1f
+#define RT5639_PLL_K_MASK			(RT5639_PLL_K_MAX)
+#define RT5639_PLL_K_SFT			0
+
+/* PLL M/N/K Code Control 2 (0x82) */
+#define RT5639_PLL_M_MAX			0xf
+#define RT5639_PLL_M_MASK			(RT5639_PLL_M_MAX << 12)
+#define RT5639_PLL_M_SFT			12
+#define RT5639_PLL_M_BP				(0x1 << 11)
+#define RT5639_PLL_M_BP_SFT			11
+
+/* ASRC Control 1 (0x83) */
+#define RT5639_STO_T_MASK			(0x1 << 15)
+#define RT5639_STO_T_SFT			15
+#define RT5639_STO_T_SCLK			(0x0 << 15)
+#define RT5639_STO_T_LRCK1			(0x1 << 15)
+#define RT5639_M1_T_MASK			(0x1 << 14)
+#define RT5639_M1_T_SFT				14
+#define RT5639_M1_T_I2S2			(0x0 << 14)
+#define RT5639_M1_T_I2S2_D3			(0x1 << 14)
+#define RT5639_I2S2_F_MASK			(0x1 << 12)
+#define RT5639_I2S2_F_SFT			12
+#define RT5639_I2S2_F_I2S2_D2			(0x0 << 12)
+#define RT5639_I2S2_F_I2S1_TCLK			(0x1 << 12)
+#define RT5639_DMIC_1_M_MASK			(0x1 << 9)
+#define RT5639_DMIC_1_M_SFT			9
+#define RT5639_DMIC_1_M_NOR			(0x0 << 9)
+#define RT5639_DMIC_1_M_ASYN			(0x1 << 9)
+#define RT5639_DMIC_2_M_MASK			(0x1 << 8)
+#define RT5639_DMIC_2_M_SFT			8
+#define RT5639_DMIC_2_M_NOR			(0x0 << 8)
+#define RT5639_DMIC_2_M_ASYN			(0x1 << 8)
+
+/* ASRC Control 2 (0x84) */
+#define RT5639_MDA_L_M_MASK			(0x1 << 15)
+#define RT5639_MDA_L_M_SFT			15
+#define RT5639_MDA_L_M_NOR			(0x0 << 15)
+#define RT5639_MDA_L_M_ASYN			(0x1 << 15)
+#define RT5639_MDA_R_M_MASK			(0x1 << 14)
+#define RT5639_MDA_R_M_SFT			14
+#define RT5639_MDA_R_M_NOR			(0x0 << 14)
+#define RT5639_MDA_R_M_ASYN			(0x1 << 14)
+#define RT5639_MAD_L_M_MASK			(0x1 << 13)
+#define RT5639_MAD_L_M_SFT			13
+#define RT5639_MAD_L_M_NOR			(0x0 << 13)
+#define RT5639_MAD_L_M_ASYN			(0x1 << 13)
+#define RT5639_MAD_R_M_MASK			(0x1 << 12)
+#define RT5639_MAD_R_M_SFT			12
+#define RT5639_MAD_R_M_NOR			(0x0 << 12)
+#define RT5639_MAD_R_M_ASYN			(0x1 << 12)
+#define RT5639_ADC_M_MASK			(0x1 << 11)
+#define RT5639_ADC_M_SFT			11
+#define RT5639_ADC_M_NOR			(0x0 << 11)
+#define RT5639_ADC_M_ASYN			(0x1 << 11)
+#define RT5639_STO_DAC_M_MASK			(0x1 << 5)
+#define RT5639_STO_DAC_M_SFT			5
+#define RT5639_STO_DAC_M_NOR			(0x0 << 5)
+#define RT5639_STO_DAC_M_ASYN			(0x1 << 5)
+#define RT5639_I2S1_R_D_MASK			(0x1 << 4)
+#define RT5639_I2S1_R_D_SFT			4
+#define RT5639_I2S1_R_D_DIS			(0x0 << 4)
+#define RT5639_I2S1_R_D_EN			(0x1 << 4)
+#define RT5639_I2S2_R_D_MASK			(0x1 << 3)
+#define RT5639_I2S2_R_D_SFT			3
+#define RT5639_I2S2_R_D_DIS			(0x0 << 3)
+#define RT5639_I2S2_R_D_EN			(0x1 << 3)
+#define RT5639_PRE_SCLK_MASK			(0x3)
+#define RT5639_PRE_SCLK_SFT			0
+#define RT5639_PRE_SCLK_512			(0x0)
+#define RT5639_PRE_SCLK_1024			(0x1)
+#define RT5639_PRE_SCLK_2048			(0x2)
+
+/* ASRC Control 3 (0x85) */
+#define RT5639_I2S1_RATE_MASK			(0xf << 12)
+#define RT5639_I2S1_RATE_SFT			12
+#define RT5639_I2S2_RATE_MASK			(0xf << 8)
+#define RT5639_I2S2_RATE_SFT			8
+
+/* ASRC Control 4 (0x89) */
+#define RT5639_I2S1_PD_MASK			(0x7 << 12)
+#define RT5639_I2S1_PD_SFT			12
+#define RT5639_I2S2_PD_MASK			(0x7 << 8)
+#define RT5639_I2S2_PD_SFT			8
+
+/* HPOUT Over Current Detection (0x8b) */
+#define RT5639_HP_OVCD_MASK			(0x1 << 10)
+#define RT5639_HP_OVCD_SFT			10
+#define RT5639_HP_OVCD_DIS			(0x0 << 10)
+#define RT5639_HP_OVCD_EN			(0x1 << 10)
+#define RT5639_HP_OC_TH_MASK			(0x3 << 8)
+#define RT5639_HP_OC_TH_SFT			8
+#define RT5639_HP_OC_TH_90			(0x0 << 8)
+#define RT5639_HP_OC_TH_105			(0x1 << 8)
+#define RT5639_HP_OC_TH_120			(0x2 << 8)
+#define RT5639_HP_OC_TH_135			(0x3 << 8)
+
+/* Class D Over Current Control (0x8c) */
+#define RT5639_CLSD_OC_MASK			(0x1 << 9)
+#define RT5639_CLSD_OC_SFT			9
+#define RT5639_CLSD_OC_PU			(0x0 << 9)
+#define RT5639_CLSD_OC_PD			(0x1 << 9)
+#define RT5639_AUTO_PD_MASK			(0x1 << 8)
+#define RT5639_AUTO_PD_SFT			8
+#define RT5639_AUTO_PD_DIS			(0x0 << 8)
+#define RT5639_AUTO_PD_EN			(0x1 << 8)
+#define RT5639_CLSD_OC_TH_MASK			(0x3f)
+#define RT5639_CLSD_OC_TH_SFT			0
+
+/* Class D Output Control (0x8d) */
+#define RT5639_CLSD_RATIO_MASK			(0xf << 12)
+#define RT5639_CLSD_RATIO_SFT			12
+#define RT5639_CLSD_OM_MASK			(0x1 << 11)
+#define RT5639_CLSD_OM_SFT			11
+#define RT5639_CLSD_OM_MONO			(0x0 << 11)
+#define RT5639_CLSD_OM_STO			(0x1 << 11)
+#define RT5639_CLSD_SCH_MASK			(0x1 << 10)
+#define RT5639_CLSD_SCH_SFT			10
+#define RT5639_CLSD_SCH_L			(0x0 << 10)
+#define RT5639_CLSD_SCH_S			(0x1 << 10)
+
+/* Depop Mode Control 1 (0x8e) */
+#define RT5639_SMT_TRIG_MASK			(0x1 << 15)
+#define RT5639_SMT_TRIG_SFT			15
+#define RT5639_SMT_TRIG_DIS			(0x0 << 15)
+#define RT5639_SMT_TRIG_EN			(0x1 << 15)
+#define RT5639_HP_L_SMT_MASK			(0x1 << 9)
+#define RT5639_HP_L_SMT_SFT			9
+#define RT5639_HP_L_SMT_DIS			(0x0 << 9)
+#define RT5639_HP_L_SMT_EN			(0x1 << 9)
+#define RT5639_HP_R_SMT_MASK			(0x1 << 8)
+#define RT5639_HP_R_SMT_SFT			8
+#define RT5639_HP_R_SMT_DIS			(0x0 << 8)
+#define RT5639_HP_R_SMT_EN			(0x1 << 8)
+#define RT5639_HP_CD_PD_MASK			(0x1 << 7)
+#define RT5639_HP_CD_PD_SFT			7
+#define RT5639_HP_CD_PD_DIS			(0x0 << 7)
+#define RT5639_HP_CD_PD_EN			(0x1 << 7)
+#define RT5639_RSTN_MASK			(0x1 << 6)
+#define RT5639_RSTN_SFT				6
+#define RT5639_RSTN_DIS				(0x0 << 6)
+#define RT5639_RSTN_EN				(0x1 << 6)
+#define RT5639_RSTP_MASK			(0x1 << 5)
+#define RT5639_RSTP_SFT				5
+#define RT5639_RSTP_DIS				(0x0 << 5)
+#define RT5639_RSTP_EN				(0x1 << 5)
+#define RT5639_HP_CO_MASK			(0x1 << 4)
+#define RT5639_HP_CO_SFT			4
+#define RT5639_HP_CO_DIS			(0x0 << 4)
+#define RT5639_HP_CO_EN				(0x1 << 4)
+#define RT5639_HP_CP_MASK			(0x1 << 3)
+#define RT5639_HP_CP_SFT			3
+#define RT5639_HP_CP_PD				(0x0 << 3)
+#define RT5639_HP_CP_PU				(0x1 << 3)
+#define RT5639_HP_SG_MASK			(0x1 << 2)
+#define RT5639_HP_SG_SFT			2
+#define RT5639_HP_SG_DIS			(0x0 << 2)
+#define RT5639_HP_SG_EN				(0x1 << 2)
+#define RT5639_HP_DP_MASK			(0x1 << 1)
+#define RT5639_HP_DP_SFT			1
+#define RT5639_HP_DP_PD				(0x0 << 1)
+#define RT5639_HP_DP_PU				(0x1 << 1)
+#define RT5639_HP_CB_MASK			(0x1)
+#define RT5639_HP_CB_SFT			0
+#define RT5639_HP_CB_PD				(0x0)
+#define RT5639_HP_CB_PU				(0x1)
+
+/* Depop Mode Control 2 (0x8f) */
+#define RT5639_DEPOP_MASK			(0x1 << 13)
+#define RT5639_DEPOP_SFT			13
+#define RT5639_DEPOP_AUTO			(0x0 << 13)
+#define RT5639_DEPOP_MAN			(0x1 << 13)
+#define RT5639_RAMP_MASK			(0x1 << 12)
+#define RT5639_RAMP_SFT				12
+#define RT5639_RAMP_DIS				(0x0 << 12)
+#define RT5639_RAMP_EN				(0x1 << 12)
+#define RT5639_BPS_MASK				(0x1 << 11)
+#define RT5639_BPS_SFT				11
+#define RT5639_BPS_DIS				(0x0 << 11)
+#define RT5639_BPS_EN				(0x1 << 11)
+#define RT5639_FAST_UPDN_MASK			(0x1 << 10)
+#define RT5639_FAST_UPDN_SFT			10
+#define RT5639_FAST_UPDN_DIS			(0x0 << 10)
+#define RT5639_FAST_UPDN_EN			(0x1 << 10)
+#define RT5639_MRES_MASK			(0x3 << 8)
+#define RT5639_MRES_SFT				8
+#define RT5639_MRES_15MO			(0x0 << 8)
+#define RT5639_MRES_25MO			(0x1 << 8)
+#define RT5639_MRES_35MO			(0x2 << 8)
+#define RT5639_MRES_45MO			(0x3 << 8)
+#define RT5639_VLO_MASK				(0x1 << 7)
+#define RT5639_VLO_SFT				7
+#define RT5639_VLO_3V				(0x0 << 7)
+#define RT5639_VLO_32V				(0x1 << 7)
+#define RT5639_DIG_DP_MASK			(0x1 << 6)
+#define RT5639_DIG_DP_SFT			6
+#define RT5639_DIG_DP_DIS			(0x0 << 6)
+#define RT5639_DIG_DP_EN			(0x1 << 6)
+#define RT5639_DP_TH_MASK			(0x3 << 4)
+#define RT5639_DP_TH_SFT			4
+
+/* Depop Mode Control 3 (0x90) */
+#define RT5639_CP_SYS_MASK			(0x7 << 12)
+#define RT5639_CP_SYS_SFT			12
+#define RT5639_CP_FQ1_MASK			(0x7 << 8)
+#define RT5639_CP_FQ1_SFT			8
+#define RT5639_CP_FQ2_MASK			(0x7 << 4)
+#define RT5639_CP_FQ2_SFT			4
+#define RT5639_CP_FQ3_MASK			(0x7)
+#define RT5639_CP_FQ3_SFT			0
+#define RT5639_CP_FQ_1_5_KHZ			0
+#define RT5639_CP_FQ_3_KHZ			1
+#define RT5639_CP_FQ_6_KHZ			2
+#define RT5639_CP_FQ_12_KHZ			3
+#define RT5639_CP_FQ_24_KHZ			4
+#define RT5639_CP_FQ_48_KHZ			5
+#define RT5639_CP_FQ_96_KHZ			6
+#define RT5639_CP_FQ_192_KHZ			7
+
+/* HPOUT charge pump (0x91) */
+#define RT5639_OSW_L_MASK			(0x1 << 11)
+#define RT5639_OSW_L_SFT			11
+#define RT5639_OSW_L_DIS			(0x0 << 11)
+#define RT5639_OSW_L_EN				(0x1 << 11)
+#define RT5639_OSW_R_MASK			(0x1 << 10)
+#define RT5639_OSW_R_SFT			10
+#define RT5639_OSW_R_DIS			(0x0 << 10)
+#define RT5639_OSW_R_EN				(0x1 << 10)
+#define RT5639_PM_HP_MASK			(0x3 << 8)
+#define RT5639_PM_HP_SFT			8
+#define RT5639_PM_HP_LV				(0x0 << 8)
+#define RT5639_PM_HP_MV				(0x1 << 8)
+#define RT5639_PM_HP_HV				(0x2 << 8)
+#define RT5639_IB_HP_MASK			(0x3 << 6)
+#define RT5639_IB_HP_SFT			6
+#define RT5639_IB_HP_125IL			(0x0 << 6)
+#define RT5639_IB_HP_25IL			(0x1 << 6)
+#define RT5639_IB_HP_5IL			(0x2 << 6)
+#define RT5639_IB_HP_1IL			(0x3 << 6)
+
+/* PV detection and SPK gain control (0x92) */
+#define RT5639_PVDD_DET_MASK			(0x1 << 15)
+#define RT5639_PVDD_DET_SFT			15
+#define RT5639_PVDD_DET_DIS			(0x0 << 15)
+#define RT5639_PVDD_DET_EN			(0x1 << 15)
+#define RT5639_SPK_AG_MASK			(0x1 << 14)
+#define RT5639_SPK_AG_SFT			14
+#define RT5639_SPK_AG_DIS			(0x0 << 14)
+#define RT5639_SPK_AG_EN			(0x1 << 14)
+
+/* Micbias Control (0x93) */
+#define RT5639_MIC1_BS_MASK			(0x1 << 15)
+#define RT5639_MIC1_BS_SFT			15
+#define RT5639_MIC1_BS_9AV			(0x0 << 15)
+#define RT5639_MIC1_BS_75AV			(0x1 << 15)
+#define RT5639_MIC2_BS_MASK			(0x1 << 14)
+#define RT5639_MIC2_BS_SFT			14
+#define RT5639_MIC2_BS_9AV			(0x0 << 14)
+#define RT5639_MIC2_BS_75AV			(0x1 << 14)
+#define RT5639_MIC1_CLK_MASK			(0x1 << 13)
+#define RT5639_MIC1_CLK_SFT			13
+#define RT5639_MIC1_CLK_DIS			(0x0 << 13)
+#define RT5639_MIC1_CLK_EN			(0x1 << 13)
+#define RT5639_MIC2_CLK_MASK			(0x1 << 12)
+#define RT5639_MIC2_CLK_SFT			12
+#define RT5639_MIC2_CLK_DIS			(0x0 << 12)
+#define RT5639_MIC2_CLK_EN			(0x1 << 12)
+#define RT5639_MIC1_OVCD_MASK			(0x1 << 11)
+#define RT5639_MIC1_OVCD_SFT			11
+#define RT5639_MIC1_OVCD_DIS			(0x0 << 11)
+#define RT5639_MIC1_OVCD_EN			(0x1 << 11)
+#define RT5639_MIC1_OVTH_MASK			(0x3 << 9)
+#define RT5639_MIC1_OVTH_SFT			9
+#define RT5639_MIC1_OVTH_600UA			(0x0 << 9)
+#define RT5639_MIC1_OVTH_1500UA			(0x1 << 9)
+#define RT5639_MIC1_OVTH_2000UA			(0x2 << 9)
+#define RT5639_MIC2_OVCD_MASK			(0x1 << 8)
+#define RT5639_MIC2_OVCD_SFT			8
+#define RT5639_MIC2_OVCD_DIS			(0x0 << 8)
+#define RT5639_MIC2_OVCD_EN			(0x1 << 8)
+#define RT5639_MIC2_OVTH_MASK			(0x3 << 6)
+#define RT5639_MIC2_OVTH_SFT			6
+#define RT5639_MIC2_OVTH_600UA			(0x0 << 6)
+#define RT5639_MIC2_OVTH_1500UA			(0x1 << 6)
+#define RT5639_MIC2_OVTH_2000UA			(0x2 << 6)
+#define RT5639_PWR_MB_MASK			(0x1 << 5)
+#define RT5639_PWR_MB_SFT			5
+#define RT5639_PWR_MB_PD			(0x0 << 5)
+#define RT5639_PWR_MB_PU			(0x1 << 5)
+#define RT5639_PWR_CLK25M_MASK			(0x1 << 4)
+#define RT5639_PWR_CLK25M_SFT			4
+#define RT5639_PWR_CLK25M_PD			(0x0 << 4)
+#define RT5639_PWR_CLK25M_PU			(0x1 << 4)
+
+/* EQ Control 1 (0xb0) */
+#define RT5639_EQ_SRC_MASK			(0x1 << 15)
+#define RT5639_EQ_SRC_SFT			15
+#define RT5639_EQ_SRC_DAC			(0x0 << 15)
+#define RT5639_EQ_SRC_ADC			(0x1 << 15)
+#define RT5639_EQ_UPD				(0x1 << 14)
+#define RT5639_EQ_UPD_BIT			14
+#define RT5639_EQ_CD_MASK			(0x1 << 13)
+#define RT5639_EQ_CD_SFT			13
+#define RT5639_EQ_CD_DIS			(0x0 << 13)
+#define RT5639_EQ_CD_EN				(0x1 << 13)
+#define RT5639_EQ_DITH_MASK			(0x3 << 8)
+#define RT5639_EQ_DITH_SFT			8
+#define RT5639_EQ_DITH_NOR			(0x0 << 8)
+#define RT5639_EQ_DITH_LSB			(0x1 << 8)
+#define RT5639_EQ_DITH_LSB_1			(0x2 << 8)
+#define RT5639_EQ_DITH_LSB_2			(0x3 << 8)
+
+/* EQ Control 2 (0xb1) */
+#define RT5639_EQ_HPF1_M_MASK			(0x1 << 8)
+#define RT5639_EQ_HPF1_M_SFT			8
+#define RT5639_EQ_HPF1_M_HI			(0x0 << 8)
+#define RT5639_EQ_HPF1_M_1ST			(0x1 << 8)
+#define RT5639_EQ_LPF1_M_MASK			(0x1 << 7)
+#define RT5639_EQ_LPF1_M_SFT			7
+#define RT5639_EQ_LPF1_M_LO			(0x0 << 7)
+#define RT5639_EQ_LPF1_M_1ST			(0x1 << 7)
+#define RT5639_EQ_HPF2_MASK			(0x1 << 6)
+#define RT5639_EQ_HPF2_SFT			6
+#define RT5639_EQ_HPF2_DIS			(0x0 << 6)
+#define RT5639_EQ_HPF2_EN			(0x1 << 6)
+#define RT5639_EQ_HPF1_MASK			(0x1 << 5)
+#define RT5639_EQ_HPF1_SFT			5
+#define RT5639_EQ_HPF1_DIS			(0x0 << 5)
+#define RT5639_EQ_HPF1_EN			(0x1 << 5)
+#define RT5639_EQ_BPF4_MASK			(0x1 << 4)
+#define RT5639_EQ_BPF4_SFT			4
+#define RT5639_EQ_BPF4_DIS			(0x0 << 4)
+#define RT5639_EQ_BPF4_EN			(0x1 << 4)
+#define RT5639_EQ_BPF3_MASK			(0x1 << 3)
+#define RT5639_EQ_BPF3_SFT			3
+#define RT5639_EQ_BPF3_DIS			(0x0 << 3)
+#define RT5639_EQ_BPF3_EN			(0x1 << 3)
+#define RT5639_EQ_BPF2_MASK			(0x1 << 2)
+#define RT5639_EQ_BPF2_SFT			2
+#define RT5639_EQ_BPF2_DIS			(0x0 << 2)
+#define RT5639_EQ_BPF2_EN			(0x1 << 2)
+#define RT5639_EQ_BPF1_MASK			(0x1 << 1)
+#define RT5639_EQ_BPF1_SFT			1
+#define RT5639_EQ_BPF1_DIS			(0x0 << 1)
+#define RT5639_EQ_BPF1_EN			(0x1 << 1)
+#define RT5639_EQ_LPF_MASK			(0x1)
+#define RT5639_EQ_LPF_SFT			0
+#define RT5639_EQ_LPF_DIS			(0x0)
+#define RT5639_EQ_LPF_EN			(0x1)
+
+/* Memory Test (0xb2) */
+#define RT5639_MT_MASK				(0x1 << 15)
+#define RT5639_MT_SFT				15
+#define RT5639_MT_DIS				(0x0 << 15)
+#define RT5639_MT_EN				(0x1 << 15)
+
+/* DRC/AGC Control 1 (0xb4) */
+#define RT5639_DRC_AGC_P_MASK			(0x1 << 15)
+#define RT5639_DRC_AGC_P_SFT			15
+#define RT5639_DRC_AGC_P_DAC			(0x0 << 15)
+#define RT5639_DRC_AGC_P_ADC			(0x1 << 15)
+#define RT5639_DRC_AGC_MASK			(0x1 << 14)
+#define RT5639_DRC_AGC_SFT			14
+#define RT5639_DRC_AGC_DIS			(0x0 << 14)
+#define RT5639_DRC_AGC_EN			(0x1 << 14)
+#define RT5639_DRC_AGC_UPD			(0x1 << 13)
+#define RT5639_DRC_AGC_UPD_BIT			13
+#define RT5639_DRC_AGC_AR_MASK			(0x1f << 8)
+#define RT5639_DRC_AGC_AR_SFT			8
+#define RT5639_DRC_AGC_R_MASK			(0x7 << 5)
+#define RT5639_DRC_AGC_R_SFT			5
+#define RT5639_DRC_AGC_R_48K			(0x1 << 5)
+#define RT5639_DRC_AGC_R_96K			(0x2 << 5)
+#define RT5639_DRC_AGC_R_192K			(0x3 << 5)
+#define RT5639_DRC_AGC_R_441K			(0x5 << 5)
+#define RT5639_DRC_AGC_R_882K			(0x6 << 5)
+#define RT5639_DRC_AGC_R_1764K			(0x7 << 5)
+#define RT5639_DRC_AGC_RC_MASK			(0x1f)
+#define RT5639_DRC_AGC_RC_SFT			0
+
+/* DRC/AGC Control 2 (0xb5) */
+#define RT5639_DRC_AGC_POB_MASK			(0x3f << 8)
+#define RT5639_DRC_AGC_POB_SFT			8
+#define RT5639_DRC_AGC_CP_MASK			(0x1 << 7)
+#define RT5639_DRC_AGC_CP_SFT			7
+#define RT5639_DRC_AGC_CP_DIS			(0x0 << 7)
+#define RT5639_DRC_AGC_CP_EN			(0x1 << 7)
+#define RT5639_DRC_AGC_CPR_MASK			(0x3 << 5)
+#define RT5639_DRC_AGC_CPR_SFT			5
+#define RT5639_DRC_AGC_CPR_1_1			(0x0 << 5)
+#define RT5639_DRC_AGC_CPR_1_2			(0x1 << 5)
+#define RT5639_DRC_AGC_CPR_1_3			(0x2 << 5)
+#define RT5639_DRC_AGC_CPR_1_4			(0x3 << 5)
+#define RT5639_DRC_AGC_PRB_MASK			(0x1f)
+#define RT5639_DRC_AGC_PRB_SFT			0
+
+/* DRC/AGC Control 3 (0xb6) */
+#define RT5639_DRC_AGC_NGB_MASK			(0xf << 12)
+#define RT5639_DRC_AGC_NGB_SFT			12
+#define RT5639_DRC_AGC_TAR_MASK			(0x1f << 7)
+#define RT5639_DRC_AGC_TAR_SFT			7
+#define RT5639_DRC_AGC_NG_MASK			(0x1 << 6)
+#define RT5639_DRC_AGC_NG_SFT			6
+#define RT5639_DRC_AGC_NG_DIS			(0x0 << 6)
+#define RT5639_DRC_AGC_NG_EN			(0x1 << 6)
+#define RT5639_DRC_AGC_NGH_MASK			(0x1 << 5)
+#define RT5639_DRC_AGC_NGH_SFT			5
+#define RT5639_DRC_AGC_NGH_DIS			(0x0 << 5)
+#define RT5639_DRC_AGC_NGH_EN			(0x1 << 5)
+#define RT5639_DRC_AGC_NGT_MASK			(0x1f)
+#define RT5639_DRC_AGC_NGT_SFT			0
+
+/* Jack Detect Control (0xbb) */
+#define RT5639_JD_MASK				(0x7 << 13)
+#define RT5639_JD_SFT				13
+#define RT5639_JD_DIS				(0x0 << 13)
+#define RT5639_JD_GPIO1				(0x1 << 13)
+#define RT5639_JD_JD1_IN4P			(0x2 << 13)
+#define RT5639_JD_JD2_IN4N			(0x3 << 13)
+#define RT5639_JD_GPIO2				(0x4 << 13)
+#define RT5639_JD_GPIO3				(0x5 << 13)
+#define RT5639_JD_GPIO4				(0x6 << 13)
+#define RT5639_JD_HP_MASK			(0x1 << 11)
+#define RT5639_JD_HP_SFT			11
+#define RT5639_JD_HP_DIS			(0x0 << 11)
+#define RT5639_JD_HP_EN				(0x1 << 11)
+#define RT5639_JD_HP_TRG_MASK			(0x1 << 10)
+#define RT5639_JD_HP_TRG_SFT			10
+#define RT5639_JD_HP_TRG_LO			(0x0 << 10)
+#define RT5639_JD_HP_TRG_HI			(0x1 << 10)
+#define RT5639_JD_SPL_MASK			(0x1 << 9)
+#define RT5639_JD_SPL_SFT			9
+#define RT5639_JD_SPL_DIS			(0x0 << 9)
+#define RT5639_JD_SPL_EN			(0x1 << 9)
+#define RT5639_JD_SPL_TRG_MASK			(0x1 << 8)
+#define RT5639_JD_SPL_TRG_SFT			8
+#define RT5639_JD_SPL_TRG_LO			(0x0 << 8)
+#define RT5639_JD_SPL_TRG_HI			(0x1 << 8)
+#define RT5639_JD_SPR_MASK			(0x1 << 7)
+#define RT5639_JD_SPR_SFT			7
+#define RT5639_JD_SPR_DIS			(0x0 << 7)
+#define RT5639_JD_SPR_EN			(0x1 << 7)
+#define RT5639_JD_SPR_TRG_MASK			(0x1 << 6)
+#define RT5639_JD_SPR_TRG_SFT			6
+#define RT5639_JD_SPR_TRG_LO			(0x0 << 6)
+#define RT5639_JD_SPR_TRG_HI			(0x1 << 6)
+#define RT5639_JD_MO_MASK			(0x1 << 5)
+#define RT5639_JD_MO_SFT			5
+#define RT5639_JD_MO_DIS			(0x0 << 5)
+#define RT5639_JD_MO_EN				(0x1 << 5)
+#define RT5639_JD_MO_TRG_MASK			(0x1 << 4)
+#define RT5639_JD_MO_TRG_SFT			4
+#define RT5639_JD_MO_TRG_LO			(0x0 << 4)
+#define RT5639_JD_MO_TRG_HI			(0x1 << 4)
+#define RT5639_JD_LO_MASK			(0x1 << 3)
+#define RT5639_JD_LO_SFT			3
+#define RT5639_JD_LO_DIS			(0x0 << 3)
+#define RT5639_JD_LO_EN				(0x1 << 3)
+#define RT5639_JD_LO_TRG_MASK			(0x1 << 2)
+#define RT5639_JD_LO_TRG_SFT			2
+#define RT5639_JD_LO_TRG_LO			(0x0 << 2)
+#define RT5639_JD_LO_TRG_HI			(0x1 << 2)
+#define RT5639_JD1_IN4P_MASK			(0x1 << 1)
+#define RT5639_JD1_IN4P_SFT			1
+#define RT5639_JD1_IN4P_DIS			(0x0 << 1)
+#define RT5639_JD1_IN4P_EN			(0x1 << 1)
+#define RT5639_JD2_IN4N_MASK			(0x1)
+#define RT5639_JD2_IN4N_SFT			0
+#define RT5639_JD2_IN4N_DIS			(0x0)
+#define RT5639_JD2_IN4N_EN			(0x1)
+
+/* IRQ Control 1 (0xbd) */
+#define RT5639_IRQ_JD_MASK			(0x1 << 15)
+#define RT5639_IRQ_JD_SFT			15
+#define RT5639_IRQ_JD_BP			(0x0 << 15)
+#define RT5639_IRQ_JD_NOR			(0x1 << 15)
+#define RT5639_IRQ_OT_MASK			(0x1 << 14)
+#define RT5639_IRQ_OT_SFT			14
+#define RT5639_IRQ_OT_BP			(0x0 << 14)
+#define RT5639_IRQ_OT_NOR			(0x1 << 14)
+#define RT5639_JD_STKY_MASK			(0x1 << 13)
+#define RT5639_JD_STKY_SFT			13
+#define RT5639_JD_STKY_DIS			(0x0 << 13)
+#define RT5639_JD_STKY_EN			(0x1 << 13)
+#define RT5639_OT_STKY_MASK			(0x1 << 12)
+#define RT5639_OT_STKY_SFT			12
+#define RT5639_OT_STKY_DIS			(0x0 << 12)
+#define RT5639_OT_STKY_EN			(0x1 << 12)
+#define RT5639_JD_P_MASK			(0x1 << 11)
+#define RT5639_JD_P_SFT				11
+#define RT5639_JD_P_NOR				(0x0 << 11)
+#define RT5639_JD_P_INV				(0x1 << 11)
+#define RT5639_OT_P_MASK			(0x1 << 10)
+#define RT5639_OT_P_SFT				10
+#define RT5639_OT_P_NOR				(0x0 << 10)
+#define RT5639_OT_P_INV				(0x1 << 10)
+
+/* IRQ Control 2 (0xbe) */
+#define RT5639_IRQ_MB1_OC_MASK			(0x1 << 15)
+#define RT5639_IRQ_MB1_OC_SFT			15
+#define RT5639_IRQ_MB1_OC_BP			(0x0 << 15)
+#define RT5639_IRQ_MB1_OC_NOR			(0x1 << 15)
+#define RT5639_IRQ_MB2_OC_MASK			(0x1 << 14)
+#define RT5639_IRQ_MB2_OC_SFT			14
+#define RT5639_IRQ_MB2_OC_BP			(0x0 << 14)
+#define RT5639_IRQ_MB2_OC_NOR			(0x1 << 14)
+#define RT5639_MB1_OC_STKY_MASK			(0x1 << 11)
+#define RT5639_MB1_OC_STKY_SFT			11
+#define RT5639_MB1_OC_STKY_DIS			(0x0 << 11)
+#define RT5639_MB1_OC_STKY_EN			(0x1 << 11)
+#define RT5639_MB2_OC_STKY_MASK			(0x1 << 10)
+#define RT5639_MB2_OC_STKY_SFT			10
+#define RT5639_MB2_OC_STKY_DIS			(0x0 << 10)
+#define RT5639_MB2_OC_STKY_EN			(0x1 << 10)
+#define RT5639_MB1_OC_P_MASK			(0x1 << 7)
+#define RT5639_MB1_OC_P_SFT			7
+#define RT5639_MB1_OC_P_NOR			(0x0 << 7)
+#define RT5639_MB1_OC_P_INV			(0x1 << 7)
+#define RT5639_MB2_OC_P_MASK			(0x1 << 6)
+#define RT5639_MB2_OC_P_SFT			6
+#define RT5639_MB2_OC_P_NOR			(0x0 << 6)
+#define RT5639_MB2_OC_P_INV			(0x1 << 6)
+#define RT5639_MB1_OC_CLR			(0x1 << 3)
+#define RT5639_MB1_OC_CLR_SFT			3
+#define RT5639_MB2_OC_CLR			(0x1 << 2)
+#define RT5639_MB2_OC_CLR_SFT			2
+
+/* GPIO Control 1 (0xc0) */
+#define RT5639_GP1_PIN_MASK			(0x1 << 15)
+#define RT5639_GP1_PIN_SFT			15
+#define RT5639_GP1_PIN_GPIO1			(0x0 << 15)
+#define RT5639_GP1_PIN_IRQ			(0x1 << 15)
+#define RT5639_GP2_PIN_MASK			(0x1 << 14)
+#define RT5639_GP2_PIN_SFT			14
+#define RT5639_GP2_PIN_GPIO2			(0x0 << 14)
+#define RT5639_GP2_PIN_DMIC1_SCL		(0x1 << 14)
+#define RT5639_GP3_PIN_MASK			(0x3 << 12)
+#define RT5639_GP3_PIN_SFT			12
+#define RT5639_GP3_PIN_GPIO3			(0x0 << 12)
+#define RT5639_GP3_PIN_DMIC1_SDA		(0x1 << 12)
+#define RT5639_GP3_PIN_IRQ			(0x2 << 12)
+#define RT5639_GP4_PIN_MASK			(0x1 << 11)
+#define RT5639_GP4_PIN_SFT			11
+#define RT5639_GP4_PIN_GPIO4			(0x0 << 11)
+#define RT5639_GP4_PIN_DMIC2_SDA		(0x1 << 11)
+#define RT5639_DP_SIG_MASK			(0x1 << 10)
+#define RT5639_DP_SIG_SFT			10
+#define RT5639_DP_SIG_TEST			(0x0 << 10)
+#define RT5639_DP_SIG_AP			(0x1 << 10)
+#define RT5639_GPIO_M_MASK			(0x1 << 9)
+#define RT5639_GPIO_M_SFT			9
+#define RT5639_GPIO_M_FLT			(0x0 << 9)
+#define RT5639_GPIO_M_PH			(0x1 << 9)
+
+/* GPIO Control 3 (0xc2) */
+#define RT5639_GP4_PF_MASK			(0x1 << 11)
+#define RT5639_GP4_PF_SFT			11
+#define RT5639_GP4_PF_IN			(0x0 << 11)
+#define RT5639_GP4_PF_OUT			(0x1 << 11)
+#define RT5639_GP4_OUT_MASK			(0x1 << 10)
+#define RT5639_GP4_OUT_SFT			10
+#define RT5639_GP4_OUT_LO			(0x0 << 10)
+#define RT5639_GP4_OUT_HI			(0x1 << 10)
+#define RT5639_GP4_P_MASK			(0x1 << 9)
+#define RT5639_GP4_P_SFT			9
+#define RT5639_GP4_P_NOR			(0x0 << 9)
+#define RT5639_GP4_P_INV			(0x1 << 9)
+#define RT5639_GP3_PF_MASK			(0x1 << 8)
+#define RT5639_GP3_PF_SFT			8
+#define RT5639_GP3_PF_IN			(0x0 << 8)
+#define RT5639_GP3_PF_OUT			(0x1 << 8)
+#define RT5639_GP3_OUT_MASK			(0x1 << 7)
+#define RT5639_GP3_OUT_SFT			7
+#define RT5639_GP3_OUT_LO			(0x0 << 7)
+#define RT5639_GP3_OUT_HI			(0x1 << 7)
+#define RT5639_GP3_P_MASK			(0x1 << 6)
+#define RT5639_GP3_P_SFT			6
+#define RT5639_GP3_P_NOR			(0x0 << 6)
+#define RT5639_GP3_P_INV			(0x1 << 6)
+#define RT5639_GP2_PF_MASK			(0x1 << 5)
+#define RT5639_GP2_PF_SFT			5
+#define RT5639_GP2_PF_IN			(0x0 << 5)
+#define RT5639_GP2_PF_OUT			(0x1 << 5)
+#define RT5639_GP2_OUT_MASK			(0x1 << 4)
+#define RT5639_GP2_OUT_SFT			4
+#define RT5639_GP2_OUT_LO			(0x0 << 4)
+#define RT5639_GP2_OUT_HI			(0x1 << 4)
+#define RT5639_GP2_P_MASK			(0x1 << 3)
+#define RT5639_GP2_P_SFT			3
+#define RT5639_GP2_P_NOR			(0x0 << 3)
+#define RT5639_GP2_P_INV			(0x1 << 3)
+#define RT5639_GP1_PF_MASK			(0x1 << 2)
+#define RT5639_GP1_PF_SFT			2
+#define RT5639_GP1_PF_IN			(0x0 << 2)
+#define RT5639_GP1_PF_OUT			(0x1 << 2)
+#define RT5639_GP1_OUT_MASK			(0x1 << 1)
+#define RT5639_GP1_OUT_SFT			1
+#define RT5639_GP1_OUT_LO			(0x0 << 1)
+#define RT5639_GP1_OUT_HI			(0x1 << 1)
+#define RT5639_GP1_P_MASK			(0x1)
+#define RT5639_GP1_P_SFT			0
+#define RT5639_GP1_P_NOR			(0x0)
+#define RT5639_GP1_P_INV			(0x1)
+
+/* FM34-500 Register Control 1 (0xc4) */
+#define RT5639_DSP_ADD_SFT			0
+
+/* FM34-500 Register Control 2 (0xc5) */
+#define RT5639_DSP_DAT_SFT			0
+
+/* FM34-500 Register Control 3 (0xc6) */
+#define RT5639_DSP_BUSY_MASK			(0x1 << 15)
+#define RT5639_DSP_BUSY_BIT			15
+#define RT5639_DSP_DS_MASK			(0x1 << 14)
+#define RT5639_DSP_DS_SFT			14
+#define RT5639_DSP_DS_FM3010			(0x1 << 14)
+#define RT5639_DSP_DS_TEMP			(0x1 << 14)
+#define RT5639_DSP_CLK_MASK			(0x3 << 12)
+#define RT5639_DSP_CLK_SFT			12
+#define RT5639_DSP_CLK_384K			(0x0 << 12)
+#define RT5639_DSP_CLK_192K			(0x1 << 12)
+#define RT5639_DSP_CLK_96K			(0x2 << 12)
+#define RT5639_DSP_CLK_64K			(0x3 << 12)
+#define RT5639_DSP_PD_PIN_MASK			(0x1 << 11)
+#define RT5639_DSP_PD_PIN_SFT			11
+#define RT5639_DSP_PD_PIN_LO			(0x0 << 11)
+#define RT5639_DSP_PD_PIN_HI			(0x1 << 11)
+#define RT5639_DSP_RST_PIN_MASK			(0x1 << 10)
+#define RT5639_DSP_RST_PIN_SFT			10
+#define RT5639_DSP_RST_PIN_LO			(0x0 << 10)
+#define RT5639_DSP_RST_PIN_HI			(0x1 << 10)
+#define RT5639_DSP_R_EN				(0x1 << 9)
+#define RT5639_DSP_R_EN_BIT			9
+#define RT5639_DSP_W_EN				(0x1 << 8)
+#define RT5639_DSP_W_EN_BIT			8
+#define RT5639_DSP_CMD_MASK			(0xff)
+#define RT5639_DSP_CMD_SFT			0
+#define RT5639_DSP_CMD_MW			(0x3B)	/* Memory Write */
+#define RT5639_DSP_CMD_MR			(0x37)	/* Memory Read */
+#define RT5639_DSP_CMD_RR			(0x60)	/* Register Read */
+#define RT5639_DSP_CMD_RW			(0x68)	/* Register Write */
+
+/* Programmable Register Array Control 1 (0xc8) */
+#define RT5639_REG_SEQ_MASK			(0xf << 12)
+#define RT5639_REG_SEQ_SFT			12
+#define RT5639_SEQ1_ST_MASK			(0x1 << 11) /*RO*/
+#define RT5639_SEQ1_ST_SFT			11
+#define RT5639_SEQ1_ST_RUN			(0x0 << 11)
+#define RT5639_SEQ1_ST_FIN			(0x1 << 11)
+#define RT5639_SEQ2_ST_MASK			(0x1 << 10) /*RO*/
+#define RT5639_SEQ2_ST_SFT			10
+#define RT5639_SEQ2_ST_RUN			(0x0 << 10)
+#define RT5639_SEQ2_ST_FIN			(0x1 << 10)
+#define RT5639_REG_LV_MASK			(0x1 << 9)
+#define RT5639_REG_LV_SFT			9
+#define RT5639_REG_LV_MX			(0x0 << 9)
+#define RT5639_REG_LV_PR			(0x1 << 9)
+#define RT5639_SEQ_2_PT_MASK			(0x1 << 8)
+#define RT5639_SEQ_2_PT_BIT			8
+#define RT5639_REG_IDX_MASK			(0xff)
+#define RT5639_REG_IDX_SFT			0
+
+/* Programmable Register Array Control 2 (0xc9) */
+#define RT5639_REG_DAT_MASK			(0xffff)
+#define RT5639_REG_DAT_SFT			0
+
+/* Programmable Register Array Control 3 (0xca) */
+#define RT5639_SEQ_DLY_MASK			(0xff << 8)
+#define RT5639_SEQ_DLY_SFT			8
+#define RT5639_PROG_MASK			(0x1 << 7)
+#define RT5639_PROG_SFT				7
+#define RT5639_PROG_DIS				(0x0 << 7)
+#define RT5639_PROG_EN				(0x1 << 7)
+#define RT5639_SEQ1_PT_RUN			(0x1 << 6)
+#define RT5639_SEQ1_PT_RUN_BIT			6
+#define RT5639_SEQ2_PT_RUN			(0x1 << 5)
+#define RT5639_SEQ2_PT_RUN_BIT			5
+
+/* Programmable Register Array Control 4 (0xcb) */
+#define RT5639_SEQ1_START_MASK			(0xf << 8)
+#define RT5639_SEQ1_START_SFT			8
+#define RT5639_SEQ1_END_MASK			(0xf)
+#define RT5639_SEQ1_END_SFT			0
+
+/* Programmable Register Array Control 5 (0xcc) */
+#define RT5639_SEQ2_START_MASK			(0xf << 8)
+#define RT5639_SEQ2_START_SFT			8
+#define RT5639_SEQ2_END_MASK			(0xf)
+#define RT5639_SEQ2_END_SFT			0
+
+/* Scramble Function (0xcd) */
+#define RT5639_SCB_KEY_MASK			(0xff)
+#define RT5639_SCB_KEY_SFT			0
+
+/* Scramble Control (0xce) */
+#define RT5639_SCB_SWAP_MASK			(0x1 << 15)
+#define RT5639_SCB_SWAP_SFT			15
+#define RT5639_SCB_SWAP_DIS			(0x0 << 15)
+#define RT5639_SCB_SWAP_EN			(0x1 << 15)
+#define RT5639_SCB_MASK				(0x1 << 14)
+#define RT5639_SCB_SFT				14
+#define RT5639_SCB_DIS				(0x0 << 14)
+#define RT5639_SCB_EN				(0x1 << 14)
+
+/* Baseback Control (0xcf) */
+#define RT5639_BB_MASK				(0x1 << 15)
+#define RT5639_BB_SFT				15
+#define RT5639_BB_DIS				(0x0 << 15)
+#define RT5639_BB_EN				(0x1 << 15)
+#define RT5639_BB_CT_MASK			(0x7 << 12)
+#define RT5639_BB_CT_SFT			12
+#define RT5639_BB_CT_A				(0x0 << 12)
+#define RT5639_BB_CT_B				(0x1 << 12)
+#define RT5639_BB_CT_C				(0x2 << 12)
+#define RT5639_BB_CT_D				(0x3 << 12)
+#define RT5639_M_BB_L_MASK			(0x1 << 9)
+#define RT5639_M_BB_L_SFT			9
+#define RT5639_M_BB_R_MASK			(0x1 << 8)
+#define RT5639_M_BB_R_SFT			8
+#define RT5639_M_BB_HPF_L_MASK			(0x1 << 7)
+#define RT5639_M_BB_HPF_L_SFT			7
+#define RT5639_M_BB_HPF_R_MASK			(0x1 << 6)
+#define RT5639_M_BB_HPF_R_SFT			6
+#define RT5639_G_BB_BST_MASK			(0x3f)
+#define RT5639_G_BB_BST_SFT			0
+
+/* MP3 Plus Control 1 (0xd0) */
+#define RT5639_M_MP3_L_MASK			(0x1 << 15)
+#define RT5639_M_MP3_L_SFT			15
+#define RT5639_M_MP3_R_MASK			(0x1 << 14)
+#define RT5639_M_MP3_R_SFT			14
+#define RT5639_M_MP3_MASK			(0x1 << 13)
+#define RT5639_M_MP3_SFT			13
+#define RT5639_M_MP3_DIS			(0x0 << 13)
+#define RT5639_M_MP3_EN				(0x1 << 13)
+#define RT5639_EG_MP3_MASK			(0x1f << 8)
+#define RT5639_EG_MP3_SFT			8
+#define RT5639_MP3_HLP_MASK			(0x1 << 7)
+#define RT5639_MP3_HLP_SFT			7
+#define RT5639_MP3_HLP_DIS			(0x0 << 7)
+#define RT5639_MP3_HLP_EN			(0x1 << 7)
+#define RT5639_M_MP3_ORG_L_MASK			(0x1 << 6)
+#define RT5639_M_MP3_ORG_L_SFT			6
+#define RT5639_M_MP3_ORG_R_MASK			(0x1 << 5)
+#define RT5639_M_MP3_ORG_R_SFT			5
+
+/* MP3 Plus Control 2 (0xd1) */
+#define RT5639_MP3_WT_MASK			(0x1 << 13)
+#define RT5639_MP3_WT_SFT			13
+#define RT5639_MP3_WT_1_4			(0x0 << 13)
+#define RT5639_MP3_WT_1_2			(0x1 << 13)
+#define RT5639_OG_MP3_MASK			(0x1f << 8)
+#define RT5639_OG_MP3_SFT			8
+#define RT5639_HG_MP3_MASK			(0x3f)
+#define RT5639_HG_MP3_SFT			0
+
+/* 3D HP Control 1 (0xd2) */
+#define RT5639_3D_CF_MASK			(0x1 << 15)
+#define RT5639_3D_CF_SFT			15
+#define RT5639_3D_CF_DIS			(0x0 << 15)
+#define RT5639_3D_CF_EN				(0x1 << 15)
+#define RT5639_3D_HP_MASK			(0x1 << 14)
+#define RT5639_3D_HP_SFT			14
+#define RT5639_3D_HP_DIS			(0x0 << 14)
+#define RT5639_3D_HP_EN				(0x1 << 14)
+#define RT5639_3D_BT_MASK			(0x1 << 13)
+#define RT5639_3D_BT_SFT			13
+#define RT5639_3D_BT_DIS			(0x0 << 13)
+#define RT5639_3D_BT_EN				(0x1 << 13)
+#define RT5639_3D_1F_MIX_MASK			(0x3 << 11)
+#define RT5639_3D_1F_MIX_SFT			11
+#define RT5639_3D_HP_M_MASK			(0x1 << 10)
+#define RT5639_3D_HP_M_SFT			10
+#define RT5639_3D_HP_M_SUR			(0x0 << 10)
+#define RT5639_3D_HP_M_FRO			(0x1 << 10)
+#define RT5639_M_3D_HRTF_MASK			(0x1 << 9)
+#define RT5639_M_3D_HRTF_SFT			9
+#define RT5639_M_3D_D2H_MASK			(0x1 << 8)
+#define RT5639_M_3D_D2H_SFT			8
+#define RT5639_M_3D_D2R_MASK			(0x1 << 7)
+#define RT5639_M_3D_D2R_SFT			7
+#define RT5639_M_3D_REVB_MASK			(0x1 << 6)
+#define RT5639_M_3D_REVB_SFT			6
+
+/* Adjustable high pass filter control 1 (0xd3) */
+#define RT5639_2ND_HPF_MASK			(0x1 << 15)
+#define RT5639_2ND_HPF_SFT			15
+#define RT5639_2ND_HPF_DIS			(0x0 << 15)
+#define RT5639_2ND_HPF_EN			(0x1 << 15)
+#define RT5639_HPF_CF_L_MASK			(0x7 << 12)
+#define RT5639_HPF_CF_L_SFT			12
+#define RT5639_1ST_HPF_MASK			(0x1 << 11)
+#define RT5639_1ST_HPF_SFT			11
+#define RT5639_1ST_HPF_DIS			(0x0 << 11)
+#define RT5639_1ST_HPF_EN			(0x1 << 11)
+#define RT5639_HPF_CF_R_MASK			(0x7 << 8)
+#define RT5639_HPF_CF_R_SFT			8
+#define RT5639_ZD_T_MASK			(0x3 << 6)
+#define RT5639_ZD_T_SFT				6
+#define RT5639_ZD_F_MASK			(0x3 << 4)
+#define RT5639_ZD_F_SFT				4
+#define RT5639_ZD_F_IM				(0x0 << 4)
+#define RT5639_ZD_F_ZC_IM			(0x1 << 4)
+#define RT5639_ZD_F_ZC_IOD			(0x2 << 4)
+#define RT5639_ZD_F_UN				(0x3 << 4)
+
+/* HP calibration control and Amp detection (0xd6) */
+#define RT5639_SI_DAC_MASK			(0x1 << 11)
+#define RT5639_SI_DAC_SFT			11
+#define RT5639_SI_DAC_AUTO			(0x0 << 11)
+#define RT5639_SI_DAC_TEST			(0x1 << 11)
+#define RT5639_DC_CAL_M_MASK			(0x1 << 10)
+#define RT5639_DC_CAL_M_SFT			10
+#define RT5639_DC_CAL_M_CAL			(0x0 << 10)
+#define RT5639_DC_CAL_M_NOR			(0x1 << 10)
+#define RT5639_DC_CAL_MASK			(0x1 << 9)
+#define RT5639_DC_CAL_SFT			9
+#define RT5639_DC_CAL_DIS			(0x0 << 9)
+#define RT5639_DC_CAL_EN			(0x1 << 9)
+#define RT5639_HPD_RCV_MASK			(0x7 << 6)
+#define RT5639_HPD_RCV_SFT			6
+#define RT5639_HPD_PS_MASK			(0x1 << 5)
+#define RT5639_HPD_PS_SFT			5
+#define RT5639_HPD_PS_DIS			(0x0 << 5)
+#define RT5639_HPD_PS_EN			(0x1 << 5)
+#define RT5639_CAL_M_MASK			(0x1 << 4)
+#define RT5639_CAL_M_SFT			4
+#define RT5639_CAL_M_DEP			(0x0 << 4)
+#define RT5639_CAL_M_CAL			(0x1 << 4)
+#define RT5639_CAL_MASK				(0x1 << 3)
+#define RT5639_CAL_SFT				3
+#define RT5639_CAL_DIS				(0x0 << 3)
+#define RT5639_CAL_EN				(0x1 << 3)
+#define RT5639_CAL_TEST_MASK			(0x1 << 2)
+#define RT5639_CAL_TEST_SFT			2
+#define RT5639_CAL_TEST_DIS			(0x0 << 2)
+#define RT5639_CAL_TEST_EN			(0x1 << 2)
+#define RT5639_CAL_P_MASK			(0x3)
+#define RT5639_CAL_P_SFT			0
+#define RT5639_CAL_P_NONE			(0x0)
+#define RT5639_CAL_P_CAL			(0x1)
+#define RT5639_CAL_P_DAC_CAL			(0x2)
+
+/* Soft volume and zero cross control 1 (0xd9) */
+#define RT5639_SV_MASK				(0x1 << 15)
+#define RT5639_SV_SFT				15
+#define RT5639_SV_DIS				(0x0 << 15)
+#define RT5639_SV_EN				(0x1 << 15)
+#define RT5639_SPO_SV_MASK			(0x1 << 14)
+#define RT5639_SPO_SV_SFT			14
+#define RT5639_SPO_SV_DIS			(0x0 << 14)
+#define RT5639_SPO_SV_EN			(0x1 << 14)
+#define RT5639_OUT_SV_MASK			(0x1 << 13)
+#define RT5639_OUT_SV_SFT			13
+#define RT5639_OUT_SV_DIS			(0x0 << 13)
+#define RT5639_OUT_SV_EN			(0x1 << 13)
+#define RT5639_HP_SV_MASK			(0x1 << 12)
+#define RT5639_HP_SV_SFT			12
+#define RT5639_HP_SV_DIS			(0x0 << 12)
+#define RT5639_HP_SV_EN				(0x1 << 12)
+#define RT5639_ZCD_DIG_MASK			(0x1 << 11)
+#define RT5639_ZCD_DIG_SFT			11
+#define RT5639_ZCD_DIG_DIS			(0x0 << 11)
+#define RT5639_ZCD_DIG_EN			(0x1 << 11)
+#define RT5639_ZCD_MASK				(0x1 << 10)
+#define RT5639_ZCD_SFT				10
+#define RT5639_ZCD_PD				(0x0 << 10)
+#define RT5639_ZCD_PU				(0x1 << 10)
+#define RT5639_M_ZCD_MASK			(0x3f << 4)
+#define RT5639_M_ZCD_SFT			4
+#define RT5639_M_ZCD_RM_L			(0x1 << 9)
+#define RT5639_M_ZCD_RM_R			(0x1 << 8)
+#define RT5639_M_ZCD_SM_L			(0x1 << 7)
+#define RT5639_M_ZCD_SM_R			(0x1 << 6)
+#define RT5639_M_ZCD_OM_L			(0x1 << 5)
+#define RT5639_M_ZCD_OM_R			(0x1 << 4)
+#define RT5639_SV_DLY_MASK			(0xf)
+#define RT5639_SV_DLY_SFT			0
+
+/* Soft volume and zero cross control 2 (0xda) */
+#define RT5639_ZCD_HP_MASK			(0x1 << 15)
+#define RT5639_ZCD_HP_SFT			15
+#define RT5639_ZCD_HP_DIS			(0x0 << 15)
+#define RT5639_ZCD_HP_EN			(0x1 << 15)
+
+
+/* Codec Private Register definition */
+/* 3D Speaker Control (0x63) */
+#define RT5639_3D_SPK_MASK			(0x1 << 15)
+#define RT5639_3D_SPK_SFT			15
+#define RT5639_3D_SPK_DIS			(0x0 << 15)
+#define RT5639_3D_SPK_EN			(0x1 << 15)
+#define RT5639_3D_SPK_M_MASK			(0x3 << 13)
+#define RT5639_3D_SPK_M_SFT			13
+#define RT5639_3D_SPK_CG_MASK			(0x1f << 8)
+#define RT5639_3D_SPK_CG_SFT			8
+#define RT5639_3D_SPK_SG_MASK			(0x1f)
+#define RT5639_3D_SPK_SG_SFT			0
+
+/* Wind Noise Detection Control 1 (0x6c) */
+#define RT5639_WND_MASK				(0x1 << 15)
+#define RT5639_WND_SFT				15
+#define RT5639_WND_DIS				(0x0 << 15)
+#define RT5639_WND_EN				(0x1 << 15)
+
+/* Wind Noise Detection Control 2 (0x6d) */
+#define RT5639_WND_FC_NW_MASK			(0x3f << 10)
+#define RT5639_WND_FC_NW_SFT			10
+#define RT5639_WND_FC_WK_MASK			(0x3f << 4)
+#define RT5639_WND_FC_WK_SFT			4
+
+/* Wind Noise Detection Control 3 (0x6e) */
+#define RT5639_HPF_FC_MASK			(0x3f << 6)
+#define RT5639_HPF_FC_SFT			6
+#define RT5639_WND_FC_ST_MASK			(0x3f)
+#define RT5639_WND_FC_ST_SFT			0
+
+/* Wind Noise Detection Control 4 (0x6f) */
+#define RT5639_WND_TH_LO_MASK			(0x3ff)
+#define RT5639_WND_TH_LO_SFT			0
+
+/* Wind Noise Detection Control 5 (0x70) */
+#define RT5639_WND_TH_HI_MASK			(0x3ff)
+#define RT5639_WND_TH_HI_SFT			0
+
+/* Wind Noise Detection Control 8 (0x73) */
+#define RT5639_WND_WIND_MASK			(0x1 << 13) /* Read-Only */
+#define RT5639_WND_WIND_SFT			13
+#define RT5639_WND_STRONG_MASK			(0x1 << 12) /* Read-Only */
+#define RT5639_WND_STRONG_SFT			12
+enum {
+	RT5639_NO_WIND,
+	RT5639_BREEZE,
+	RT5639_STORM,
+};
+
+/* Dipole Speaker Interface (0x75) */
+#define RT5639_DP_ATT_MASK			(0x3 << 14)
+#define RT5639_DP_ATT_SFT			14
+#define RT5639_DP_SPK_MASK			(0x1 << 10)
+#define RT5639_DP_SPK_SFT			10
+#define RT5639_DP_SPK_DIS			(0x0 << 10)
+#define RT5639_DP_SPK_EN			(0x1 << 10)
+
+/* EQ Pre Volume Control (0xb3) */
+#define RT5639_EQ_PRE_VOL_MASK			(0xffff)
+#define RT5639_EQ_PRE_VOL_SFT			0
+
+/* EQ Post Volume Control (0xb4) */
+#define RT5639_EQ_PST_VOL_MASK			(0xffff)
+#define RT5639_EQ_PST_VOL_SFT			0
+
+#define RT5639_NO_JACK		BIT(0)
+#define RT5639_HEADSET_DET	BIT(1)
+#define RT5639_HEADPHO_DET	BIT(2)
+
+/* System Clock Source */
+#define RT5639_SCLK_S_MCLK	0
+#define RT5639_SCLK_S_PLL1	1
+#define RT5639_SCLK_S_PLL1_TK	2
+#define RT5639_SCLK_S_RCCLK	3
+
+/* PLL1 Source */
+#define RT5639_PLL1_S_MCLK	0
+#define RT5639_PLL1_S_BCLK1	1
+#define RT5639_PLL1_S_BCLK2	2
+#define RT5639_PLL1_S_BCLK3	3
+
+
+enum {
+	RT5639_AIF1,
+	RT5639_AIF2,
+	RT5639_AIF3,
+	RT5639_AIFS,
+};
+
+enum {
+	RT5639_U_IF1 = 0x1,
+	RT5639_U_IF2 = 0x2,
+	RT5639_U_IF3 = 0x4,
+};
+
+enum {
+	RT5639_IF_123,
+	RT5639_IF_132,
+	RT5639_IF_312,
+	RT5639_IF_321,
+	RT5639_IF_231,
+	RT5639_IF_213,
+	RT5639_IF_113,
+	RT5639_IF_223,
+	RT5639_IF_ALL,
+};
+
+enum {
+	RT5639_DMIC_DIS,
+	RT5639_DMIC1,
+	RT5639_DMIC2,
+};
+
+struct rt5639_pll_code {
+	bool m_bp; /* Indicates bypass m code or not. */
+	int m_code;
+	int n_code;
+	int k_code;
+};
+
+struct rt5639_priv {
+	struct snd_soc_codec *codec;
+	struct rt5639_platform_data pdata;
+	struct regmap *regmap;
+
+	int sysclk;
+	int sysclk_src;
+	int lrck[RT5639_AIFS];
+	int bclk[RT5639_AIFS];
+	int master[RT5639_AIFS];
+
+	struct rt5639_pll_code pll_code;
+	int pll_src;
+	int pll_in;
+	int pll_out;
+
+	bool hp_mute;
+};
+
+#endif
-- 
1.8.1.1.439.g50a6b54
