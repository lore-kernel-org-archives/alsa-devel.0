From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: add rt5514 codec driver
Date: Tue, 19 Jan 2016 20:02:28 +0800
Message-ID: <1453204948-21945-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BB17826058F
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 13:02:37 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, koro.chen@mediatek.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This is the initial codec driver for rt5514.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5514.txt |   25 +
 sound/soc/codecs/Kconfig                           |    6 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/rt5514.c                          | 1047 ++++++++++++++++++++
 sound/soc/codecs/rt5514.h                          |  252 +++++
 5 files changed, 1332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5514.txt
 create mode 100644 sound/soc/codecs/rt5514.c
 create mode 100644 sound/soc/codecs/rt5514.h

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
new file mode 100644
index 0000000..e24436f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -0,0 +1,25 @@
+RT5514 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5514".
+
+- reg : The I2C address of the device.
+
+Pins on the device (for linking into audio routes) for RT5514:
+
+  * DMIC1L
+  * DMIC1R
+  * DMIC2L
+  * DMIC2R
+  * AMICL
+  * AMICR
+
+Example:
+
+codec: rt5514@57 {
+	compatible = "realtek,rt5514";
+	reg = <0x57>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 50693c8..dabd479 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -95,6 +95,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM512x_SPI if SPI_MASTER
 	select SND_SOC_RT286 if I2C
 	select SND_SOC_RT298 if I2C
+	select SND_SOC_RT5514 if I2C
 	select SND_SOC_RT5616 if I2C
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_RT5640 if I2C
@@ -565,6 +566,7 @@ config SND_SOC_PCM512x_SPI
 
 config SND_SOC_RL6231
 	tristate
+	default y if SND_SOC_RT5514=y
 	default y if SND_SOC_RT5616=y
 	default y if SND_SOC_RT5640=y
 	default y if SND_SOC_RT5645=y
@@ -572,6 +574,7 @@ config SND_SOC_RL6231
 	default y if SND_SOC_RT5659=y
 	default y if SND_SOC_RT5670=y
 	default y if SND_SOC_RT5677=y
+	default m if SND_SOC_RT5514=m
 	default m if SND_SOC_RT5616=m
 	default m if SND_SOC_RT5640=m
 	default m if SND_SOC_RT5645=m
@@ -595,6 +598,9 @@ config SND_SOC_RT298
 	tristate
 	depends on I2C
 
+config SND_SOC_RT5514
+	tristate
+
 config SND_SOC_RT5616
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d44f7d3..79f95dd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -92,6 +92,7 @@ snd-soc-rl6231-objs := rl6231.o
 snd-soc-rl6347a-objs := rl6347a.o
 snd-soc-rt286-objs := rt286.o
 snd-soc-rt298-objs := rt298.o
+snd-soc-rt5514-objs := rt5514.o
 snd-soc-rt5616-objs := rt5616.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
@@ -296,6 +297,7 @@ obj-$(CONFIG_SND_SOC_RL6231)	+= snd-soc-rl6231.o
 obj-$(CONFIG_SND_SOC_RL6347A)	+= snd-soc-rl6347a.o
 obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
+obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
 obj-$(CONFIG_SND_SOC_RT5616)	+= snd-soc-rt5616.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
new file mode 100644
index 0000000..cb331a0
--- /dev/null
+++ b/sound/soc/codecs/rt5514.c
@@ -0,0 +1,1047 @@
+/*
+ * rt5514.c  --  RT5514 ALSA SoC audio codec driver
+ *
+ * Copyright 2015 Realtek Semiconductor Corp.
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/firmware.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "rl6231.h"
+#include "rt5514.h"
+
+static const struct reg_sequence rt5514_init_list[] = {
+	{RT5514_DIG_IO_CTRL,		0x00000040},
+	{RT5514_CLK_CTRL1,		0x38020041},
+	{RT5514_SRC_CTRL,		0x44000eee},
+	{RT5514_ANA_CTRL_LDO10,		0x00028604},
+	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
+};
+
+static const struct reg_default rt5514_reg[] = {
+	{RT5514_RESET,			0x00000000},
+	{RT5514_PWR_ANA1,		0x00808880},
+	{RT5514_PWR_ANA2,		0x00220000},
+	{RT5514_I2S_CTRL1,		0x00000330},
+	{RT5514_I2S_CTRL2,		0x20000000},
+	{RT5514_VAD_CTRL6,		0xc00007d2},
+	{RT5514_EXT_VAD_CTRL,		0x80000080},
+	{RT5514_DIG_IO_CTRL,		0x00000040},
+	{RT5514_PAD_CTRL1,		0x00804000},
+	{RT5514_DMIC_DATA_CTRL,		0x00000005},
+	{RT5514_DIG_SOURCE_CTRL,	0x00000002},
+	{RT5514_SRC_CTRL,		0x44000eee},
+	{RT5514_DOWNFILTER2_CTRL1,	0x0000882f},
+	{RT5514_PLL_SOURCE_CTRL,	0x00000004},
+	{RT5514_CLK_CTRL1,		0x38020041},
+	{RT5514_CLK_CTRL2,		0x00000000},
+	{RT5514_PLL3_CALIB_CTRL1,	0x00400200},
+	{RT5514_PLL3_CALIB_CTRL5,	0x40220012},
+	{RT5514_DELAY_BUF_CTRL1,	0x7fff006a},
+	{RT5514_DELAY_BUF_CTRL3,	0x00000000},
+	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
+	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
+	{RT5514_DOWNFILTER0_CTRL3,	0x00000362},
+	{RT5514_DOWNFILTER1_CTRL1,	0x00020c2f},
+	{RT5514_DOWNFILTER1_CTRL2,	0x00020c2f},
+	{RT5514_DOWNFILTER1_CTRL3,	0x00000362},
+	{RT5514_ANA_CTRL_LDO10,		0x00028604},
+	{RT5514_ANA_CTRL_LDO18_16,	0x02000345},
+	{RT5514_ANA_CTRL_ADC12,		0x0000a2a8},
+	{RT5514_ANA_CTRL_ADC21,		0x00001180},
+	{RT5514_ANA_CTRL_ADC22,		0x0000aaa8},
+	{RT5514_ANA_CTRL_ADC23,		0x00151427},
+	{RT5514_ANA_CTRL_MICBST,	0x00002000},
+	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
+	{RT5514_ANA_CTRL_INBUF,		0x00000143},
+	{RT5514_ANA_CTRL_VREF,		0x00008d50},
+	{RT5514_ANA_CTRL_PLL3,		0x0000000e},
+	{RT5514_ANA_CTRL_PLL1_1,	0x00000000},
+	{RT5514_ANA_CTRL_PLL1_2,	0x00030220},
+	{RT5514_DMIC_LP_CTRL,		0x00000000},
+	{RT5514_MISC_CTRL_DSP,		0x00000000},
+	{RT5514_DSP_CTRL1,		0x00055149},
+	{RT5514_DSP_CTRL3,		0x00000006},
+	{RT5514_DSP_CTRL4,		0x00000001},
+	{RT5514_VENDOR_ID1,		0x00000001},
+	{RT5514_VENDOR_ID2,		0x10ec5514},
+};
+
+static bool rt5514_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT5514_VENDOR_ID1:
+	case RT5514_VENDOR_ID2:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static bool rt5514_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT5514_RESET:
+	case RT5514_PWR_ANA1:
+	case RT5514_PWR_ANA2:
+	case RT5514_I2S_CTRL1:
+	case RT5514_I2S_CTRL2:
+	case RT5514_VAD_CTRL6:
+	case RT5514_EXT_VAD_CTRL:
+	case RT5514_DIG_IO_CTRL:
+	case RT5514_PAD_CTRL1:
+	case RT5514_DMIC_DATA_CTRL:
+	case RT5514_DIG_SOURCE_CTRL:
+	case RT5514_SRC_CTRL:
+	case RT5514_DOWNFILTER2_CTRL1:
+	case RT5514_PLL_SOURCE_CTRL:
+	case RT5514_CLK_CTRL1:
+	case RT5514_CLK_CTRL2:
+	case RT5514_PLL3_CALIB_CTRL1:
+	case RT5514_PLL3_CALIB_CTRL5:
+	case RT5514_DELAY_BUF_CTRL1:
+	case RT5514_DELAY_BUF_CTRL3:
+	case RT5514_DOWNFILTER0_CTRL1:
+	case RT5514_DOWNFILTER0_CTRL2:
+	case RT5514_DOWNFILTER0_CTRL3:
+	case RT5514_DOWNFILTER1_CTRL1:
+	case RT5514_DOWNFILTER1_CTRL2:
+	case RT5514_DOWNFILTER1_CTRL3:
+	case RT5514_ANA_CTRL_LDO10:
+	case RT5514_ANA_CTRL_LDO18_16:
+	case RT5514_ANA_CTRL_ADC12:
+	case RT5514_ANA_CTRL_ADC21:
+	case RT5514_ANA_CTRL_ADC22:
+	case RT5514_ANA_CTRL_ADC23:
+	case RT5514_ANA_CTRL_MICBST:
+	case RT5514_ANA_CTRL_ADCFED:
+	case RT5514_ANA_CTRL_INBUF:
+	case RT5514_ANA_CTRL_VREF:
+	case RT5514_ANA_CTRL_PLL3:
+	case RT5514_ANA_CTRL_PLL1_1:
+	case RT5514_ANA_CTRL_PLL1_2:
+	case RT5514_DMIC_LP_CTRL:
+	case RT5514_MISC_CTRL_DSP:
+	case RT5514_DSP_CTRL1:
+	case RT5514_DSP_CTRL3:
+	case RT5514_DSP_CTRL4:
+	case RT5514_VENDOR_ID1:
+	case RT5514_VENDOR_ID2:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static bool rt5514_readable_register_physical(struct device *dev,
+	unsigned int reg)
+{
+	switch (reg) {
+	case RT5514_DSP_MAPPING | RT5514_RESET:
+	case RT5514_DSP_MAPPING | RT5514_PWR_ANA1:
+	case RT5514_DSP_MAPPING | RT5514_PWR_ANA2:
+	case RT5514_DSP_MAPPING | RT5514_I2S_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_I2S_CTRL2:
+	case RT5514_DSP_MAPPING | RT5514_VAD_CTRL6:
+	case RT5514_DSP_MAPPING | RT5514_EXT_VAD_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_DIG_IO_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_PAD_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_DMIC_DATA_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_DIG_SOURCE_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_SRC_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER2_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_PLL_SOURCE_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_CLK_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_CLK_CTRL2:
+	case RT5514_DSP_MAPPING | RT5514_PLL3_CALIB_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_PLL3_CALIB_CTRL5:
+	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL2:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER1_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER1_CTRL2:
+	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER1_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_LDO10:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_LDO18_16:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_ADC12:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_ADC21:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_ADC22:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_ADC23:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_MICBST:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_ADCFED:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_INBUF:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_VREF:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_PLL3:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_PLL1_1:
+	case RT5514_DSP_MAPPING | RT5514_ANA_CTRL_PLL1_2:
+	case RT5514_DSP_MAPPING | RT5514_DMIC_LP_CTRL:
+	case RT5514_DSP_MAPPING | RT5514_MISC_CTRL_DSP:
+	case RT5514_DSP_MAPPING | RT5514_DSP_CTRL1:
+	case RT5514_DSP_MAPPING | RT5514_DSP_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_DSP_CTRL4:
+	case RT5514_DSP_MAPPING | RT5514_VENDOR_ID1:
+	case RT5514_DSP_MAPPING | RT5514_VENDOR_ID2:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+/* {-3, 0, +3, +4.5, +7.5, +9.5, +12, +14, +17} dB */
+static const DECLARE_TLV_DB_RANGE(bst_tlv,
+	0, 2, TLV_DB_SCALE_ITEM(-300, 300, 0),
+	3, 3, TLV_DB_SCALE_ITEM(450, 0, 0),
+	4, 4, TLV_DB_SCALE_ITEM(750, 0, 0),
+	5, 5, TLV_DB_SCALE_ITEM(950, 0, 0),
+	6, 6, TLV_DB_SCALE_ITEM(1200, 0, 0),
+	7, 7, TLV_DB_SCALE_ITEM(1400, 0, 0),
+	8, 8, TLV_DB_SCALE_ITEM(1700, 0, 0)
+);
+
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+
+static const struct snd_kcontrol_new rt5514_snd_controls[] = {
+	SOC_DOUBLE_TLV("MIC Boost Volume", RT5514_ANA_CTRL_MICBST,
+		RT5514_SEL_BSTL_SFT, RT5514_SEL_BSTR_SFT, 8, 0, bst_tlv),
+	SOC_DOUBLE_R_TLV("ADC1 Capture Volume", RT5514_DOWNFILTER0_CTRL1,
+		RT5514_DOWNFILTER0_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
+		adc_vol_tlv),
+	SOC_DOUBLE_R_TLV("ADC2 Capture Volume", RT5514_DOWNFILTER1_CTRL1,
+		RT5514_DOWNFILTER1_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
+		adc_vol_tlv),
+};
+
+/* ADC Mixer*/
+static const struct snd_kcontrol_new rt5514_sto1_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("DMIC Switch", RT5514_DOWNFILTER0_CTRL1,
+		RT5514_AD_DMIC_MIX_BIT, 1, 1),
+	SOC_DAPM_SINGLE("ADC Switch", RT5514_DOWNFILTER0_CTRL1,
+		RT5514_AD_AD_MIX_BIT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5514_sto1_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("DMIC Switch", RT5514_DOWNFILTER0_CTRL2,
+		RT5514_AD_DMIC_MIX_BIT, 1, 1),
+	SOC_DAPM_SINGLE("ADC Switch", RT5514_DOWNFILTER0_CTRL2,
+		RT5514_AD_AD_MIX_BIT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5514_sto2_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("DMIC Switch", RT5514_DOWNFILTER1_CTRL1,
+		RT5514_AD_DMIC_MIX_BIT, 1, 1),
+	SOC_DAPM_SINGLE("ADC Switch", RT5514_DOWNFILTER1_CTRL1,
+		RT5514_AD_AD_MIX_BIT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5514_sto2_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("DMIC Switch", RT5514_DOWNFILTER1_CTRL2,
+		RT5514_AD_DMIC_MIX_BIT, 1, 1),
+	SOC_DAPM_SINGLE("ADC Switch", RT5514_DOWNFILTER1_CTRL2,
+		RT5514_AD_AD_MIX_BIT, 1, 1),
+};
+
+/* DMIC Source */
+static const char * const rt5514_dmic_src[] = {
+	"DMIC1", "DMIC2"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5514_stereo1_dmic_enum, RT5514_DIG_SOURCE_CTRL,
+	RT5514_AD0_DMIC_INPUT_SEL_SFT, rt5514_dmic_src);
+
+static const struct snd_kcontrol_new rt5514_sto1_dmic_mux =
+	SOC_DAPM_ENUM("Stereo1 DMIC Source", rt5514_stereo1_dmic_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5514_stereo2_dmic_enum, RT5514_DIG_SOURCE_CTRL,
+	RT5514_AD1_DMIC_INPUT_SEL_SFT, rt5514_dmic_src);
+
+static const struct snd_kcontrol_new rt5514_sto2_dmic_mux =
+	SOC_DAPM_ENUM("Stereo2 DMIC Source", rt5514_stereo2_dmic_enum);
+
+/**
+ * rt5514_calc_dmic_clk - Calculate the frequency divider parameter of dmic.
+ *
+ * @rate: base clock rate.
+ *
+ * Choose divider parameter that gives the highest possible DMIC frequency in
+ * 1MHz - 3MHz range.
+ */
+static int rt5514_calc_dmic_clk(int rate)
+{
+	int div[] = {2, 3, 4, 8, 12, 16, 24, 32};
+	int i;
+
+	if (rate < 1000000 * div[0]) {
+		pr_warn("Base clock rate %d is too low\n", rate);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(div); i++) {
+		/* find divider that gives DMIC frequency below 3.072MHz */
+		if (3072000 * div[i] >= rate)
+			return i;
+	}
+
+	pr_warn("Base clock rate %d is too high\n", rate);
+	return -EINVAL;
+}
+
+static int rt5514_set_dmic_clk(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	int idx;
+
+	idx = rt5514_calc_dmic_clk(rt5514->sysclk);
+	if (idx < 0)
+		dev_err(codec->dev, "Failed to set DMIC clock\n");
+	else
+		regmap_update_bits(rt5514->regmap, RT5514_CLK_CTRL1,
+			RT5514_CLK_DMIC_OUT_SEL_MASK,
+			idx << RT5514_CLK_DMIC_OUT_SEL_SFT);
+
+	return idx;
+}
+
+static int rt5514_adc_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA1,
+			RT5514_POW_LDO18_IN | RT5514_POW_LDO18_ADC |
+			RT5514_POW_LDO21 | RT5514_POW_BG_LDO18_IN |
+			RT5514_POW_BG_LDO21,
+			RT5514_POW_LDO18_IN | RT5514_POW_LDO18_ADC |
+			RT5514_POW_LDO21 | RT5514_POW_BG_LDO18_IN |
+			RT5514_POW_BG_LDO21);
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
+			RT5514_POW_BG_MBIAS | RT5514_POW_MBIAS |
+			RT5514_POW_VREF2 | RT5514_POW_VREF1,
+			RT5514_POW_BG_MBIAS | RT5514_POW_MBIAS |
+			RT5514_POW_VREF2 | RT5514_POW_VREF1);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA1,
+			RT5514_POW_LDO18_IN | RT5514_POW_LDO18_ADC |
+			RT5514_POW_LDO21 | RT5514_POW_BG_LDO18_IN |
+			RT5514_POW_BG_LDO21, 0);
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
+			RT5514_POW_BG_MBIAS | RT5514_POW_MBIAS |
+			RT5514_POW_VREF2 | RT5514_POW_VREF1, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5514_adcl_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
+			RT5514_POWL_LDO16 | RT5514_POW_ADC1_L |
+			RT5514_POW2_BSTL | RT5514_POW_BSTL |
+			RT5514_POW_ADCFEDL,
+			RT5514_POWL_LDO16 | RT5514_POW_ADC1_L |
+			RT5514_POW2_BSTL | RT5514_POW_BSTL |
+			RT5514_POW_ADCFEDL);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
+			RT5514_POWL_LDO16 | RT5514_POW_ADC1_L |
+			RT5514_POW2_BSTL | RT5514_POW_BSTL |
+			RT5514_POW_ADCFEDL, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5514_adcr_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
+			RT5514_POWR_LDO16 | RT5514_POW_ADC1_R |
+			RT5514_POW2_BSTR | RT5514_POW_BSTR |
+			RT5514_POW_ADCFEDR,
+			RT5514_POWR_LDO16 | RT5514_POW_ADC1_R |
+			RT5514_POW2_BSTR | RT5514_POW_BSTR |
+			RT5514_POW_ADCFEDR);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
+			RT5514_POWR_LDO16 | RT5514_POW_ADC1_R |
+			RT5514_POW2_BSTR | RT5514_POW_BSTR |
+			RT5514_POW_ADCFEDR, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5514_is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	if (rt5514->sysclk_src == RT5514_SCLK_S_PLL1)
+		return 1;
+	else
+		return 0;
+}
+
+static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("DMIC1L"),
+	SND_SOC_DAPM_INPUT("DMIC1R"),
+	SND_SOC_DAPM_INPUT("DMIC2L"),
+	SND_SOC_DAPM_INPUT("DMIC2R"),
+
+	SND_SOC_DAPM_INPUT("AMICL"),
+	SND_SOC_DAPM_INPUT("AMICR"),
+
+	SND_SOC_DAPM_PGA("DMIC1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DMIC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0,
+		rt5514_set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_SUPPLY("ADC CLK", RT5514_CLK_CTRL1,
+		RT5514_CLK_AD_ANA1_EN_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Power", SND_SOC_NOPM, 0, 0,
+		rt5514_adc_power_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("ADCL Power", SND_SOC_NOPM, 0, 0,
+		rt5514_adcl_power_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("ADCR Power", SND_SOC_NOPM, 0, 0,
+		rt5514_adcr_power_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("PLL1 LDO ENABLE", RT5514_ANA_CTRL_PLL1_2,
+		RT5514_EN_LDO_PLL1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("PLL1 LDO", RT5514_PWR_ANA2,
+		RT5514_POW_PLL1_LDO_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("PLL1", RT5514_PWR_ANA2, RT5514_POW_PLL1_BIT, 0,
+		NULL, 0),
+
+	/* ADC Mux */
+	SND_SOC_DAPM_MUX("Stereo1 DMIC Mux", SND_SOC_NOPM, 0, 0,
+				&rt5514_sto1_dmic_mux),
+	SND_SOC_DAPM_MUX("Stereo2 DMIC Mux", SND_SOC_NOPM, 0, 0,
+				&rt5514_sto2_dmic_mux),
+
+	/* ADC Mixer */
+	SND_SOC_DAPM_SUPPLY("adc stereo1 filter", RT5514_CLK_CTRL1,
+		RT5514_CLK_AD0_EN_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("adc stereo2 filter", RT5514_CLK_CTRL1,
+		RT5514_CLK_AD1_EN_BIT, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("Sto1 ADC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5514_sto1_adc_l_mix, ARRAY_SIZE(rt5514_sto1_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Sto1 ADC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5514_sto1_adc_r_mix, ARRAY_SIZE(rt5514_sto1_adc_r_mix)),
+	SND_SOC_DAPM_MIXER("Sto2 ADC MIXL", SND_SOC_NOPM, 0, 0,
+		rt5514_sto2_adc_l_mix, ARRAY_SIZE(rt5514_sto2_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Sto2 ADC MIXR", SND_SOC_NOPM, 0, 0,
+		rt5514_sto2_adc_r_mix, ARRAY_SIZE(rt5514_sto2_adc_r_mix)),
+
+	SND_SOC_DAPM_ADC("Stereo1 ADC MIXL", NULL, RT5514_DOWNFILTER0_CTRL1,
+		RT5514_AD_AD_MUTE_BIT, 1),
+	SND_SOC_DAPM_ADC("Stereo1 ADC MIXR", NULL, RT5514_DOWNFILTER0_CTRL2,
+		RT5514_AD_AD_MUTE_BIT, 1),
+	SND_SOC_DAPM_ADC("Stereo2 ADC MIXL", NULL, RT5514_DOWNFILTER1_CTRL1,
+		RT5514_AD_AD_MUTE_BIT, 1),
+	SND_SOC_DAPM_ADC("Stereo2 ADC MIXR", NULL, RT5514_DOWNFILTER1_CTRL2,
+		RT5514_AD_AD_MUTE_BIT, 1),
+
+	/* ADC PGA */
+	SND_SOC_DAPM_PGA("Stereo1 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Stereo2 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route rt5514_dapm_routes[] = {
+	{ "DMIC1", NULL, "DMIC1L" },
+	{ "DMIC1", NULL, "DMIC1R" },
+	{ "DMIC2", NULL, "DMIC2L" },
+	{ "DMIC2", NULL, "DMIC2R" },
+
+	{ "DMIC1L", NULL, "DMIC CLK" },
+	{ "DMIC1R", NULL, "DMIC CLK" },
+	{ "DMIC2L", NULL, "DMIC CLK" },
+	{ "DMIC2R", NULL, "DMIC CLK" },
+
+	{ "Stereo1 DMIC Mux", "DMIC1", "DMIC1" },
+	{ "Stereo1 DMIC Mux", "DMIC2", "DMIC2" },
+
+	{ "Sto1 ADC MIXL", "DMIC Switch", "Stereo1 DMIC Mux" },
+	{ "Sto1 ADC MIXL", "ADC Switch", "AMICL" },
+	{ "Sto1 ADC MIXR", "DMIC Switch", "Stereo1 DMIC Mux" },
+	{ "Sto1 ADC MIXR", "ADC Switch", "AMICR" },
+
+	{ "AMICL", NULL, "ADC CLK" },
+	{ "AMICL", NULL, "ADC Power" },
+	{ "AMICL", NULL, "ADCL Power" },
+	{ "AMICR", NULL, "ADC CLK" },
+	{ "AMICR", NULL, "ADC Power" },
+	{ "AMICR", NULL, "ADCR Power" },
+
+	{ "PLL1 LDO", NULL, "PLL1 LDO ENABLE" },
+	{ "PLL1", NULL, "PLL1 LDO" },
+
+	{ "Stereo1 ADC MIXL", NULL, "Sto1 ADC MIXL" },
+	{ "Stereo1 ADC MIXR", NULL, "Sto1 ADC MIXR" },
+
+	{ "Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXL" },
+	{ "Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXR" },
+	{ "Stereo1 ADC MIX", NULL, "adc stereo1 filter" },
+	{ "adc stereo1 filter", NULL, "PLL1", rt5514_is_sys_clk_from_pll },
+
+	{ "Stereo2 DMIC Mux", "DMIC1", "DMIC1" },
+	{ "Stereo2 DMIC Mux", "DMIC2", "DMIC2" },
+
+	{ "Sto2 ADC MIXL", "DMIC Switch", "Stereo2 DMIC Mux" },
+	{ "Sto2 ADC MIXL", "ADC Switch", "AMICL" },
+	{ "Sto2 ADC MIXR", "DMIC Switch", "Stereo2 DMIC Mux" },
+	{ "Sto2 ADC MIXR", "ADC Switch", "AMICR" },
+
+	{ "Stereo2 ADC MIXL", NULL, "Sto2 ADC MIXL" },
+	{ "Stereo2 ADC MIXR", NULL, "Sto2 ADC MIXR" },
+
+	{ "Stereo2 ADC MIX", NULL, "Stereo2 ADC MIXL" },
+	{ "Stereo2 ADC MIX", NULL, "Stereo2 ADC MIXR" },
+	{ "Stereo2 ADC MIX", NULL, "adc stereo2 filter" },
+	{ "adc stereo2 filter", NULL, "PLL1", rt5514_is_sys_clk_from_pll },
+
+	{ "AIF1TX", NULL, "Stereo1 ADC MIX"},
+	{ "AIF1TX", NULL, "Stereo2 ADC MIX"},
+};
+
+static int rt5514_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	int pre_div, bclk_ms, frame_size;
+	unsigned int val_len = 0;
+
+	rt5514->lrck = params_rate(params);
+	pre_div = rl6231_get_clk_info(rt5514->sysclk, rt5514->lrck);
+	if (pre_div < 0) {
+		dev_err(codec->dev, "Unsupported clock setting\n");
+		return -EINVAL;
+	}
+
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0) {
+		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
+		return -EINVAL;
+	}
+
+	bclk_ms = frame_size > 32 ? 1 : 0;
+	rt5514->bclk = rt5514->lrck * (32 << bclk_ms);
+
+	dev_dbg(dai->dev, "bclk is %dHz and lrck is %dHz\n",
+		rt5514->bclk, rt5514->lrck);
+	dev_dbg(dai->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
+				bclk_ms, pre_div, dai->id);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		val_len = RT5514_I2S_DL_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		val_len = RT5514_I2S_DL_24;
+		break;
+	case SNDRV_PCM_FORMAT_S8:
+		val_len = RT5514_I2S_DL_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL1, RT5514_I2S_DL_MASK,
+		val_len);
+	regmap_update_bits(rt5514->regmap, RT5514_CLK_CTRL2,
+		RT5514_CLK_SYS_DIV_OUT_MASK | RT5514_SEL_ADC_OSR_MASK,
+		pre_div << RT5514_CLK_SYS_DIV_OUT_SFT |
+		pre_div << RT5514_SEL_ADC_OSR_SFT);
+
+	return 0;
+}
+
+static int rt5514_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+
+	case SND_SOC_DAIFMT_NB_IF:
+		reg_val |= RT5514_I2S_LR_INV;
+		break;
+
+	case SND_SOC_DAIFMT_IB_NF:
+		reg_val |= RT5514_I2S_BP_INV;
+		break;
+
+	case SND_SOC_DAIFMT_IB_IF:
+		reg_val |= RT5514_I2S_BP_INV | RT5514_I2S_LR_INV;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg_val |= RT5514_I2S_DF_LEFT;
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A:
+		reg_val |= RT5514_I2S_DF_PCM_A;
+		break;
+
+	case SND_SOC_DAIFMT_DSP_B:
+		reg_val |= RT5514_I2S_DF_PCM_B;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL1,
+		RT5514_I2S_DF_MASK | RT5514_I2S_BP_MASK | RT5514_I2S_LR_MASK,
+		reg_val);
+
+	return 0;
+}
+
+static int rt5514_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	if (freq == rt5514->sysclk && clk_id == rt5514->sysclk_src)
+		return 0;
+
+	switch (clk_id) {
+	case RT5514_SCLK_S_MCLK:
+		reg_val |= RT5514_CLK_SYS_PRE_SEL_MCLK;
+		break;
+
+	case RT5514_SCLK_S_PLL1:
+		reg_val |= RT5514_CLK_SYS_PRE_SEL_PLL;
+		break;
+
+	default:
+		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(rt5514->regmap, RT5514_CLK_CTRL2,
+		RT5514_CLK_SYS_PRE_SEL_MASK, reg_val);
+
+	rt5514->sysclk = freq;
+	rt5514->sysclk_src = clk_id;
+
+	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+
+	return 0;
+}
+
+static int rt5514_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
+			unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	struct rl6231_pll_code pll_code;
+	int ret;
+
+	if (!freq_in || !freq_out) {
+		dev_dbg(codec->dev, "PLL disabled\n");
+
+		rt5514->pll_in = 0;
+		rt5514->pll_out = 0;
+		regmap_update_bits(rt5514->regmap, RT5514_CLK_CTRL2,
+			RT5514_CLK_SYS_PRE_SEL_MASK,
+			RT5514_CLK_SYS_PRE_SEL_MCLK);
+
+		return 0;
+	}
+
+	if (source == rt5514->pll_src && freq_in == rt5514->pll_in &&
+	    freq_out == rt5514->pll_out)
+		return 0;
+
+	switch (source) {
+	case RT5514_PLL1_S_MCLK:
+		regmap_update_bits(rt5514->regmap, RT5514_PLL_SOURCE_CTRL,
+			RT5514_PLL_1_SEL_MASK, RT5514_PLL_1_SEL_MCLK);
+		break;
+
+	case RT5514_PLL1_S_BCLK:
+		regmap_update_bits(rt5514->regmap, RT5514_PLL_SOURCE_CTRL,
+			RT5514_PLL_1_SEL_MASK, RT5514_PLL_1_SEL_SCLK);
+		break;
+
+	default:
+		dev_err(codec->dev, "Unknown PLL source %d\n", source);
+		return -EINVAL;
+	}
+
+	ret = rl6231_pll_calc(freq_in, freq_out, &pll_code);
+	if (ret < 0) {
+		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
+		return ret;
+	}
+
+	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=%d\n",
+		pll_code.m_bp, (pll_code.m_bp ? 0 : pll_code.m_code),
+		pll_code.n_code, pll_code.k_code);
+
+	regmap_write(rt5514->regmap, RT5514_ANA_CTRL_PLL1_1,
+		pll_code.k_code << RT5514_PLL_K_SFT |
+		pll_code.n_code << RT5514_PLL_N_SFT |
+		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5514_PLL_M_SFT);
+	regmap_update_bits(rt5514->regmap, RT5514_ANA_CTRL_PLL1_2,
+		RT5514_PLL_M_BP, pll_code.m_bp << RT5514_PLL_M_BP_SFT);
+
+	rt5514->pll_in = freq_in;
+	rt5514->pll_out = freq_out;
+	rt5514->pll_src = source;
+
+	return 0;
+}
+
+static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = 0;
+
+	if (rx_mask || tx_mask)
+		val |= RT5514_TDM_MODE;
+
+	if (slots == 4)
+		val |= RT5514_TDMSLOT_SEL_RX_4CH | RT5514_TDMSLOT_SEL_TX_4CH;
+
+
+	switch (slot_width) {
+	case 20:
+		val |= RT5514_CH_LEN_RX_20 | RT5514_CH_LEN_TX_20;
+		break;
+
+	case 24:
+		val |= RT5514_CH_LEN_RX_24 | RT5514_CH_LEN_TX_24;
+		break;
+
+	case 32:
+		val |= RT5514_CH_LEN_RX_32 | RT5514_CH_LEN_TX_32;
+		break;
+
+	case 16:
+	default:
+		break;
+	}
+
+	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL1, RT5514_TDM_MODE |
+		RT5514_TDMSLOT_SEL_RX_MASK | RT5514_TDMSLOT_SEL_TX_MASK |
+		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK, val);
+
+	return 0;
+}
+
+static int rt5514_probe(struct snd_soc_codec *codec)
+{
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	rt5514->codec = codec;
+
+	return 0;
+}
+
+static int rt5514_remove(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rt5514_suspend(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static int rt5514_resume(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+#else
+#define rt5514_suspend NULL
+#define rt5514_resume NULL
+#endif
+
+static int rt5514_i2c_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct i2c_client *client = context;
+	struct rt5514_priv *rt5514 = i2c_get_clientdata(client);
+
+	regmap_read(rt5514->regmap_physical, reg | RT5514_DSP_MAPPING, val);
+
+	return 0;
+}
+
+static int rt5514_i2c_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *client = context;
+	struct rt5514_priv *rt5514 = i2c_get_clientdata(client);
+
+	regmap_write(rt5514->regmap_physical, reg | RT5514_DSP_MAPPING, val);
+
+	return 0;
+}
+
+#define RT5514_STEREO_RATES SNDRV_PCM_RATE_8000_192000
+#define RT5514_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
+
+struct snd_soc_dai_ops rt5514_aif_dai_ops = {
+	.hw_params = rt5514_hw_params,
+	.set_fmt = rt5514_set_dai_fmt,
+	.set_sysclk = rt5514_set_dai_sysclk,
+	.set_pll = rt5514_set_dai_pll,
+	.set_tdm_slot = rt5514_set_tdm_slot,
+};
+
+struct snd_soc_dai_driver rt5514_dai[] = {
+	{
+		.name = "rt5514-aif1",
+		.id = 0,
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = RT5514_STEREO_RATES,
+			.formats = RT5514_FORMATS,
+		},
+		.ops = &rt5514_aif_dai_ops,
+	}
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_rt5514 = {
+	.probe = rt5514_probe,
+	.remove = rt5514_remove,
+	.suspend = rt5514_suspend,
+	.resume = rt5514_resume,
+	.idle_bias_off = true,
+	.controls = rt5514_snd_controls,
+	.num_controls = ARRAY_SIZE(rt5514_snd_controls),
+	.dapm_widgets = rt5514_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt5514_dapm_widgets),
+	.dapm_routes = rt5514_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt5514_dapm_routes),
+};
+
+static const struct regmap_config rt5514_regmap_physical = {
+	.name = "physical",
+	.reg_bits = 32,
+	.val_bits = 32,
+
+	.max_register = RT5514_DSP_MAPPING | RT5514_VENDOR_ID2,
+	.readable_reg = rt5514_readable_register_physical,
+
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct regmap_config rt5514_regmap = {
+	.reg_bits = 16,
+	.val_bits = 32,
+
+	.max_register = RT5514_VENDOR_ID2,
+	.volatile_reg = rt5514_volatile_register,
+	.readable_reg = rt5514_readable_register,
+	.reg_read = rt5514_i2c_read,
+	.reg_write = rt5514_i2c_write,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = rt5514_reg,
+	.num_reg_defaults = ARRAY_SIZE(rt5514_reg),
+	.use_single_rw = true,
+};
+
+static const struct i2c_device_id rt5514_i2c_id[] = {
+	{ "rt5514", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rt5514_i2c_id);
+
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5514_of_match[] = {
+	{ .compatible = "realtek,rt5514", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5514_of_match);
+#endif
+
+static void rt5514_reset(struct rt5514_priv *rt5514)
+{
+	regmap_write(rt5514->regmap_physical, 0x1800101c, 0x00000000);
+	regmap_write(rt5514->regmap_physical, 0x18001100, 0x0000031f);
+	regmap_write(rt5514->regmap_physical, 0x18001104, 0x00000007);
+	regmap_write(rt5514->regmap_physical, 0x18001108, 0x00000000);
+	regmap_write(rt5514->regmap_physical, 0x1800110c, 0x00000000);
+	regmap_write(rt5514->regmap_physical, 0x18001110, 0x00000000);
+	regmap_write(rt5514->regmap_physical, 0x18001114, 0x00000001);
+	regmap_write(rt5514->regmap_physical, 0x18001118, 0x00000000);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL3, 0x00000006);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL1, 0x00055149);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL1, 0x0005514b);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL1, 0x00055149);
+	regmap_write(rt5514->regmap_physical, 0xfafafafa, 0x00000001);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL4, 0x00000001);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL4, 0x00000000);
+	regmap_write(rt5514->regmap_physical,
+		RT5514_DSP_MAPPING | RT5514_DSP_CTRL4, 0x00000001);
+	regmap_write(rt5514->regmap_physical, 0xfafafafa, 0x00000001);
+	regmap_write(rt5514->regmap_physical, RT5514_DSP_MAPPING | RT5514_RESET,
+		0x000010ec);
+	regmap_write(rt5514->regmap_physical, 0xfafafafa, 0x00000000);
+}
+
+static int rt5514_i2c_probe(struct i2c_client *i2c,
+		    const struct i2c_device_id *id)
+{
+	struct rt5514_priv *rt5514;
+	int ret;
+
+	rt5514 = devm_kzalloc(&i2c->dev, sizeof(struct rt5514_priv),
+				GFP_KERNEL);
+	if (rt5514 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, rt5514);
+
+	rt5514->regmap_physical = devm_regmap_init_i2c(i2c,
+					&rt5514_regmap_physical);
+	if (IS_ERR(rt5514->regmap_physical)) {
+		ret = PTR_ERR(rt5514->regmap_physical);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	rt5514->regmap = devm_regmap_init(&i2c->dev, NULL, i2c, &rt5514_regmap);
+	if (IS_ERR(rt5514->regmap)) {
+		ret = PTR_ERR(rt5514->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	rt5514_reset(rt5514);
+
+	ret = regmap_register_patch(rt5514->regmap, rt5514_init_list,
+				    ARRAY_SIZE(rt5514_init_list));
+	if (ret != 0)
+		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
+
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5514,
+			rt5514_dai, ARRAY_SIZE(rt5514_dai));
+}
+
+static int rt5514_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+struct i2c_driver rt5514_i2c_driver = {
+	.driver = {
+		.name = "rt5514",
+		.of_match_table = of_match_ptr(rt5514_of_match),
+	},
+	.probe = rt5514_i2c_probe,
+	.remove   = rt5514_i2c_remove,
+	.id_table = rt5514_i2c_id,
+};
+module_i2c_driver(rt5514_i2c_driver);
+
+
+MODULE_DESCRIPTION("ASoC RT5514 driver");
+MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
new file mode 100644
index 0000000..5c7ddf0
--- /dev/null
+++ b/sound/soc/codecs/rt5514.h
@@ -0,0 +1,252 @@
+/*
+ * rt5514.h  --  RT5514 ALSA SoC audio driver
+ *
+ * Copyright 2015 Realtek Microelectronics
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT5514_H__
+#define __RT5514_H__
+
+#define RT5514_DEVICE_ID			0x6311
+
+#define RT5514_RESET				0x2000
+#define RT5514_PWR_ANA1				0x2004
+#define RT5514_PWR_ANA2				0x2008
+#define RT5514_I2S_CTRL1			0x2010
+#define RT5514_I2S_CTRL2			0x2014
+#define RT5514_VAD_CTRL6			0x2030
+#define RT5514_EXT_VAD_CTRL			0x206c
+#define RT5514_DIG_IO_CTRL			0x2070
+#define RT5514_PAD_CTRL1			0x2080
+#define RT5514_DMIC_DATA_CTRL			0x20a0
+#define RT5514_DIG_SOURCE_CTRL			0x20a4
+#define RT5514_SRC_CTRL				0x20ac
+#define RT5514_DOWNFILTER2_CTRL1		0x20d0
+#define RT5514_PLL_SOURCE_CTRL			0x2100
+#define RT5514_CLK_CTRL1			0x2104
+#define RT5514_CLK_CTRL2			0x2108
+#define RT5514_PLL3_CALIB_CTRL1			0x2110
+#define RT5514_PLL3_CALIB_CTRL5			0x2124
+#define RT5514_DELAY_BUF_CTRL1			0x2140
+#define RT5514_DELAY_BUF_CTRL3			0x2148
+#define RT5514_DOWNFILTER0_CTRL1		0x2190
+#define RT5514_DOWNFILTER0_CTRL2		0x2194
+#define RT5514_DOWNFILTER0_CTRL3		0x2198
+#define RT5514_DOWNFILTER1_CTRL1		0x21a0
+#define RT5514_DOWNFILTER1_CTRL2		0x21a4
+#define RT5514_DOWNFILTER1_CTRL3		0x21a8
+#define RT5514_ANA_CTRL_LDO10			0x2200
+#define RT5514_ANA_CTRL_LDO18_16		0x2204
+#define RT5514_ANA_CTRL_ADC12			0x2210
+#define RT5514_ANA_CTRL_ADC21			0x2214
+#define RT5514_ANA_CTRL_ADC22			0x2218
+#define RT5514_ANA_CTRL_ADC23			0x221c
+#define RT5514_ANA_CTRL_MICBST			0x2220
+#define RT5514_ANA_CTRL_ADCFED			0x2224
+#define RT5514_ANA_CTRL_INBUF			0x2228
+#define RT5514_ANA_CTRL_VREF			0x222c
+#define RT5514_ANA_CTRL_PLL3			0x2240
+#define RT5514_ANA_CTRL_PLL1_1			0x2260
+#define RT5514_ANA_CTRL_PLL1_2			0x2264
+#define RT5514_DMIC_LP_CTRL			0x2e00
+#define RT5514_MISC_CTRL_DSP			0x2e04
+#define RT5514_DSP_CTRL1			0x2f00
+#define RT5514_DSP_CTRL3			0x2f08
+#define RT5514_DSP_CTRL4			0x2f10
+#define RT5514_VENDOR_ID1			0x2ff0
+#define RT5514_VENDOR_ID2			0x2ff4
+
+#define RT5514_DSP_MAPPING			0x18000000
+
+/* RT5514_PWR_ANA1 (0x2004) */
+#define RT5514_POW_LDO18_IN			(0x1 << 5)
+#define RT5514_POW_LDO18_IN_BIT			5
+#define RT5514_POW_LDO18_ADC			(0x1 << 4)
+#define RT5514_POW_LDO18_ADC_BIT		4
+#define RT5514_POW_LDO21			(0x1 << 3)
+#define RT5514_POW_LDO21_BIT			3
+#define RT5514_POW_BG_LDO18_IN			(0x1 << 2)
+#define RT5514_POW_BG_LDO18_BIT			2
+#define RT5514_POW_BG_LDO21			(0x1 << 1)
+#define RT5514_POW_BG_LDO21_BIT			1
+
+/* RT5514_PWR_ANA2 (0x2008) */
+#define RT5514_POW_PLL1				(0x1 << 18)
+#define RT5514_POW_PLL1_BIT			18
+#define RT5514_POW_PLL1_LDO			(0x1 << 16)
+#define RT5514_POW_PLL1_LDO_BIT			16
+#define RT5514_POW_BG_MBIAS			(0x1 << 15)
+#define RT5514_POW_BG_MBIAS_BIT			15
+#define RT5514_POW_MBIAS			(0x1 << 14)
+#define RT5514_POW_MBIAS_BIT			14
+#define RT5514_POW_VREF2			(0x1 << 13)
+#define RT5514_POW_VREF2_BIT			13
+#define RT5514_POW_VREF1			(0x1 << 12)
+#define RT5514_POW_VREF1_BIT			12
+#define RT5514_POWR_LDO16			(0x1 << 11)
+#define RT5514_POWR_LDO16_BIT			11
+#define RT5514_POWL_LDO16			(0x1 << 10)
+#define RT5514_POWL_LDO16_BIT			10
+#define RT5514_POW_ADC2				(0x1 << 9)
+#define RT5514_POW_ADC2_BIT			9
+#define RT5514_POW_INPUT_BUF			(0x1 << 8)
+#define RT5514_POW_INPUT_BUF_BIT		8
+#define RT5514_POW_ADC1_R			(0x1 << 7)
+#define RT5514_POW_ADC1_R_BIT			7
+#define RT5514_POW_ADC1_L			(0x1 << 6)
+#define RT5514_POW_ADC1_L_BIT			6
+#define RT5514_POW2_BSTR			(0x1 << 5)
+#define RT5514_POW2_BSTR_BIT			5
+#define RT5514_POW2_BSTL			(0x1 << 4)
+#define RT5514_POW2_BSTL_BIT			4
+#define RT5514_POW_BSTR				(0x1 << 3)
+#define RT5514_POW_BSTR_BIT			3
+#define RT5514_POW_BSTL				(0x1 << 2)
+#define RT5514_POW_BSTL_BIT			2
+#define RT5514_POW_ADCFEDR			(0x1 << 1)
+#define RT5514_POW_ADCFEDR_BIT			1
+#define RT5514_POW_ADCFEDL			(0x1 << 0)
+#define RT5514_POW_ADCFEDL_BIT			0
+
+/* RT5514_I2S_CTRL1 (0x2010) */
+#define RT5514_TDM_MODE				(0x1 << 28)
+#define RT5514_TDM_MODE_SFT			28
+#define RT5514_I2S_LR_MASK			(0x1 << 26)
+#define RT5514_I2S_LR_SFT			26
+#define RT5514_I2S_LR_NOR			(0x0 << 26)
+#define RT5514_I2S_LR_INV			(0x1 << 26)
+#define RT5514_I2S_BP_MASK			(0x1 << 25)
+#define RT5514_I2S_BP_SFT			25
+#define RT5514_I2S_BP_NOR			(0x0 << 25)
+#define RT5514_I2S_BP_INV			(0x1 << 25)
+#define RT5514_I2S_DF_MASK			(0x7 << 16)
+#define RT5514_I2S_DF_SFT			16
+#define RT5514_I2S_DF_I2S			(0x0 << 16)
+#define RT5514_I2S_DF_LEFT			(0x1 << 16)
+#define RT5514_I2S_DF_PCM_A			(0x2 << 16)
+#define RT5514_I2S_DF_PCM_B			(0x3 << 16)
+#define RT5514_TDMSLOT_SEL_RX_MASK		(0x3 << 10)
+#define RT5514_TDMSLOT_SEL_RX_SFT		10
+#define RT5514_TDMSLOT_SEL_RX_4CH		(0x1 << 10)
+#define RT5514_CH_LEN_RX_MASK			(0x3 << 8)
+#define RT5514_CH_LEN_RX_SFT			8
+#define RT5514_CH_LEN_RX_16			(0x0 << 8)
+#define RT5514_CH_LEN_RX_20			(0x1 << 8)
+#define RT5514_CH_LEN_RX_24			(0x2 << 8)
+#define RT5514_CH_LEN_RX_32			(0x3 << 8)
+#define RT5514_TDMSLOT_SEL_TX_MASK		(0x3 << 6)
+#define RT5514_TDMSLOT_SEL_TX_SFT		6
+#define RT5514_TDMSLOT_SEL_TX_4CH		(0x1 << 6)
+#define RT5514_CH_LEN_TX_MASK			(0x3 << 4)
+#define RT5514_CH_LEN_TX_SFT			4
+#define RT5514_CH_LEN_TX_16			(0x0 << 4)
+#define RT5514_CH_LEN_TX_20			(0x1 << 4)
+#define RT5514_CH_LEN_TX_24			(0x2 << 4)
+#define RT5514_CH_LEN_TX_32			(0x3 << 4)
+#define RT5514_I2S_DL_MASK			(0x3 << 0)
+#define RT5514_I2S_DL_SFT			0
+#define RT5514_I2S_DL_16			(0x0 << 0)
+#define RT5514_I2S_DL_20			(0x1 << 0)
+#define RT5514_I2S_DL_24			(0x2 << 0)
+#define RT5514_I2S_DL_8				(0x3 << 0)
+
+/* RT5514_DIG_SOURCE_CTRL (0x20a4) */
+#define RT5514_AD1_DMIC_INPUT_SEL		(0x1 << 1)
+#define RT5514_AD1_DMIC_INPUT_SEL_SFT		1
+#define RT5514_AD0_DMIC_INPUT_SEL		(0x1 << 0)
+#define RT5514_AD0_DMIC_INPUT_SEL_SFT		0
+
+/* RT5514_PLL_SOURCE_CTRL (0x2100) */
+#define RT5514_PLL_1_SEL_MASK			(0x7 << 12)
+#define RT5514_PLL_1_SEL_SFT			12
+#define RT5514_PLL_1_SEL_SCLK			(0x3 << 12)
+#define RT5514_PLL_1_SEL_MCLK			(0x4 << 12)
+
+/* RT5514_CLK_CTRL1 (0x2104) */
+#define RT5514_CLK_AD_ANA1_EN			(0x1 << 31)
+#define RT5514_CLK_AD_ANA1_EN_BIT		31
+#define RT5514_CLK_AD1_EN			(0x1 << 24)
+#define RT5514_CLK_AD1_EN_BIT			24
+#define RT5514_CLK_AD0_EN			(0x1 << 23)
+#define RT5514_CLK_AD0_EN_BIT			23
+#define RT5514_CLK_DMIC_OUT_SEL_MASK		(0x7 << 8)
+#define RT5514_CLK_DMIC_OUT_SEL_SFT		8
+
+/* RT5514_CLK_CTRL2 (0x2108) */
+#define RT5514_CLK_SYS_DIV_OUT_MASK		(0x7 << 8)
+#define RT5514_CLK_SYS_DIV_OUT_SFT		8
+#define RT5514_SEL_ADC_OSR_MASK			(0x7 << 4)
+#define RT5514_SEL_ADC_OSR_SFT			4
+#define RT5514_CLK_SYS_PRE_SEL_MASK		(0x3 << 0)
+#define RT5514_CLK_SYS_PRE_SEL_SFT		0
+#define RT5514_CLK_SYS_PRE_SEL_MCLK		(0x2 << 0)
+#define RT5514_CLK_SYS_PRE_SEL_PLL		(0x3 << 0)
+
+/*  RT5514_DOWNFILTER_CTRL (0x2190 0x2194 0x21a0 0x21a4) */
+#define RT5514_AD_DMIC_MIX			(0x1 << 11)
+#define RT5514_AD_DMIC_MIX_BIT			11
+#define RT5514_AD_AD_MIX			(0x1 << 10)
+#define RT5514_AD_AD_MIX_BIT			10
+#define RT5514_AD_AD_MUTE			(0x1 << 7)
+#define RT5514_AD_AD_MUTE_BIT			7
+#define RT5514_AD_GAIN_MASK			(0x7f << 0)
+#define RT5514_AD_GAIN_SFT			0
+
+/*  RT5514_ANA_CTRL_MICBST (0x2220) */
+#define RT5514_SEL_BSTL_MASK			(0xf << 4)
+#define RT5514_SEL_BSTL_SFT			4
+#define RT5514_SEL_BSTR_MASK			(0xf << 0)
+#define RT5514_SEL_BSTR_SFT			0
+
+/*  RT5514_ANA_CTRL_PLL1_1 (0x2260) */
+#define RT5514_PLL_K_MAX			0x1f
+#define RT5514_PLL_K_MASK			(RT5514_PLL_K_MAX << 16)
+#define RT5514_PLL_K_SFT			16
+#define RT5514_PLL_N_MAX			0x1ff
+#define RT5514_PLL_N_MASK			(RT5514_PLL_N_MAX << 7)
+#define RT5514_PLL_N_SFT			4
+#define RT5514_PLL_M_MAX			0xf
+#define RT5514_PLL_M_MASK			(RT5514_PLL_M_MAX << 0)
+#define RT5514_PLL_M_SFT			0
+
+/*  RT5514_ANA_CTRL_PLL1_2 (0x2264) */
+#define RT5514_PLL_M_BP				(0x1 << 2)
+#define RT5514_PLL_M_BP_SFT			2
+#define RT5514_PLL_K_BP				(0x1 << 1)
+#define RT5514_PLL_K_BP_SFT			1
+#define RT5514_EN_LDO_PLL1			(0x1 << 0)
+#define RT5514_EN_LDO_PLL1_BIT			0
+
+#define RT5514_PLL_INP_MAX			40000000
+#define RT5514_PLL_INP_MIN			256000
+
+/* System Clock Source */
+enum {
+	RT5514_SCLK_S_MCLK,
+	RT5514_SCLK_S_PLL1,
+};
+
+/* PLL1 Source */
+enum {
+	RT5514_PLL1_S_MCLK,
+	RT5514_PLL1_S_BCLK,
+};
+
+struct rt5514_priv {
+	struct snd_soc_codec *codec;
+	struct regmap *regmap, *regmap_physical;
+	int sysclk;
+	int sysclk_src;
+	int lrck;
+	int bclk;
+	int pll_src;
+	int pll_in;
+	int pll_out;
+};
+
+#endif /* __RT5514_H__ */
-- 
1.8.1.1.439.g50a6b54
