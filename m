From: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] ASoC: cs43130: Add support for CS43130 codec
Date: Wed, 9 Aug 2017 10:00:21 -0500
Message-ID: <f5ea5455-b359-4f55-bf73-ee69a7c5d54d@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add support for Cirrus Logic CS43130 codec.

Support:
I2S/DSP PCM playback.
DoP/DSD playback.
HP detection and DC/AC impedance measurement.

Signed-off-by: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 sound/soc/codecs/Kconfig   |    6 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/cs43130.c | 2675 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs43130.h |  545 +++++++++
 4 files changed, 3228 insertions(+)
 create mode 100644 sound/soc/codecs/cs43130.c
 create mode 100644 sound/soc/codecs/cs43130.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 010811e..1f65336 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -60,6 +60,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4271_I2C if I2C
 	select SND_SOC_CS4271_SPI if SPI_MASTER
 	select SND_SOC_CS42XX8_I2C if I2C
+	select SND_SOC_CS43130 if I2C
 	select SND_SOC_CS4349 if I2C
 	select SND_SOC_CS47L24 if MFD_CS47L24
 	select SND_SOC_CS53L30 if I2C
@@ -488,6 +489,11 @@ config SND_SOC_CS42XX8_I2C
 	select SND_SOC_CS42XX8
 	select REGMAP_I2C
 
+# Cirrus Logic CS43130 HiFi DAC
+config SND_SOC_CS43130
+        tristate "Cirrus Logic CS43130 CODEC"
+        depends on I2C
+
 # Cirrus Logic CS4349 HiFi DAC
 config SND_SOC_CS4349
 	tristate "Cirrus Logic CS4349 CODEC"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 12dc2f7..896ef5a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -53,6 +53,7 @@ snd-soc-cs4271-i2c-objs := cs4271-i2c.o
 snd-soc-cs4271-spi-objs := cs4271-spi.o
 snd-soc-cs42xx8-objs := cs42xx8.o
 snd-soc-cs42xx8-i2c-objs := cs42xx8-i2c.o
+snd-soc-cs43130-objs := cs43130.o
 snd-soc-cs4349-objs := cs4349.o
 snd-soc-cs47l24-objs := cs47l24.o
 snd-soc-cs53l30-objs := cs53l30.o
@@ -292,6 +293,7 @@ obj-$(CONFIG_SND_SOC_CS4271_I2C)	+= snd-soc-cs4271-i2c.o
 obj-$(CONFIG_SND_SOC_CS4271_SPI)	+= snd-soc-cs4271-spi.o
 obj-$(CONFIG_SND_SOC_CS42XX8)	+= snd-soc-cs42xx8.o
 obj-$(CONFIG_SND_SOC_CS42XX8_I2C) += snd-soc-cs42xx8-i2c.o
+obj-$(CONFIG_SND_SOC_CS43130)   += snd-soc-cs43130.o
 obj-$(CONFIG_SND_SOC_CS4349)	+= snd-soc-cs4349.o
 obj-$(CONFIG_SND_SOC_CS47L24)	+= snd-soc-cs47l24.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
new file mode 100644
index 0000000..de22919
--- /dev/null
+++ b/sound/soc/codecs/cs43130.c
@@ -0,0 +1,2675 @@
+/*
+ * cs43130.c  --  CS43130 ALSA Soc Audio driver
+ *
+ * Copyright 2016 Cirrus Logic, Inc.
+ *
+ * Authors: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_irq.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <sound/jack.h>
+
+#include "cs43130.h"
+
+static const struct reg_default cs43130_reg_defaults[] = {
+	{CS43130_SYS_CLK_CTL_1, 0x06},
+	{CS43130_SP_SRATE, 0x01},
+	{CS43130_SP_BITSIZE, 0x05},
+	{CS43130_PAD_INT_CFG, 0x03},
+	{CS43130_PWDN_CTL, 0xFE},
+	{CS43130_CRYSTAL_SET, 0x04},
+	{CS43130_PLL_SET_1, 0x00},
+	{CS43130_PLL_SET_2, 0x00},
+	{CS43130_PLL_SET_3, 0x00},
+	{CS43130_PLL_SET_4, 0x00},
+	{CS43130_PLL_SET_5, 0x40},
+	{CS43130_PLL_SET_6, 0x10},
+	{CS43130_PLL_SET_7, 0x80},
+	{CS43130_PLL_SET_8, 0x03},
+	{CS43130_PLL_SET_9, 0x02},
+	{CS43130_PLL_SET_10, 0x02},
+	{CS43130_CLKOUT_CTL, 0x00},
+	{CS43130_ASP_NUM_1, 0x01},
+	{CS43130_ASP_NUM_2, 0x00},
+	{CS43130_ASP_DEN_1, 0x08},
+	{CS43130_ASP_DEN_2, 0x00},
+	{CS43130_ASP_LRCK_HI_TIME_1, 0x1F},
+	{CS43130_ASP_LRCK_HI_TIME_2, 0x00},
+	{CS43130_ASP_LRCK_PERIOD_1, 0x3F},
+	{CS43130_ASP_LRCK_PERIOD_2, 0x00},
+	{CS43130_ASP_CLOCK_CONF, 0x0C},
+	{CS43130_ASP_FRAME_CONF, 0x0A},
+	{CS43130_XSP_NUM_1, 0x01},
+	{CS43130_XSP_NUM_2, 0x00},
+	{CS43130_XSP_DEN_1, 0x02},
+	{CS43130_XSP_DEN_2, 0x00},
+	{CS43130_XSP_LRCK_HI_TIME_1, 0x1F},
+	{CS43130_XSP_LRCK_HI_TIME_2, 0x00},
+	{CS43130_XSP_LRCK_PERIOD_1, 0x3F},
+	{CS43130_XSP_LRCK_PERIOD_2, 0x00},
+	{CS43130_XSP_CLOCK_CONF, 0x0C},
+	{CS43130_XSP_FRAME_CONF, 0x0A},
+	{CS43130_ASP_CH_1_LOC, 0x00},
+	{CS43130_ASP_CH_2_LOC, 0x00},
+	{CS43130_ASP_CH_1_SZ_EN, 0x06},
+	{CS43130_ASP_CH_2_SZ_EN, 0x0E},
+	{CS43130_XSP_CH_1_LOC, 0x00},
+	{CS43130_XSP_CH_2_LOC, 0x00},
+	{CS43130_XSP_CH_1_SZ_EN, 0x06},
+	{CS43130_XSP_CH_2_SZ_EN, 0x0E},
+	{CS43130_DSD_VOL_B, 0x78},
+	{CS43130_DSD_VOL_A, 0x78},
+	{CS43130_DSD_PATH_CTL_1, 0xA8},
+	{CS43130_DSD_INT_CFG, 0x00},
+	{CS43130_DSD_PATH_CTL_2, 0x02},
+	{CS43130_DSD_PCM_MIX_CTL, 0x00},
+	{CS43130_DSD_PATH_CTL_3, 0x40},
+	{CS43130_HP_OUT_CTL_1, 0x30},
+	{CS43130_PCM_FILT_OPT, 0x02},
+	{CS43130_PCM_VOL_B, 0x78},
+	{CS43130_PCM_VOL_A, 0x78},
+	{CS43130_PCM_PATH_CTL_1, 0xA8},
+	{CS43130_PCM_PATH_CTL_2, 0x00},
+	{CS43130_CLASS_H_CTL, 0x1E},
+	{CS43130_HP_DETECT, 0x04},
+	{CS43130_HP_LOAD_1, 0x00},
+	{CS43130_HP_MEAS_LOAD_1, 0x00},
+	{CS43130_HP_MEAS_LOAD_2, 0x00},
+	{CS43130_INT_MASK_1, 0xFF},
+	{CS43130_INT_MASK_2, 0xFF},
+	{CS43130_INT_MASK_3, 0xFF},
+	{CS43130_INT_MASK_4, 0xFF},
+	{CS43130_INT_MASK_5, 0xFF},
+};
+
+static bool cs43130_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS43130_INT_STATUS_1 ... CS43130_INT_STATUS_5:
+	case CS43130_HP_DC_STAT_1 ... CS43130_HP_DC_STAT_2:
+	case CS43130_HP_AC_STAT_1 ... CS43130_HP_AC_STAT_2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs43130_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS43130_DEVID_AB ... CS43130_SYS_CLK_CTL_1:
+	case CS43130_SP_SRATE ... CS43130_PAD_INT_CFG:
+	case CS43130_PWDN_CTL:
+	case CS43130_CRYSTAL_SET:
+	case CS43130_PLL_SET_1 ... CS43130_PLL_SET_5:
+	case CS43130_PLL_SET_6:
+	case CS43130_PLL_SET_7:
+	case CS43130_PLL_SET_8:
+	case CS43130_PLL_SET_9:
+	case CS43130_PLL_SET_10:
+	case CS43130_CLKOUT_CTL:
+	case CS43130_ASP_NUM_1 ... CS43130_ASP_FRAME_CONF:
+	case CS43130_XSP_NUM_1 ... CS43130_XSP_FRAME_CONF:
+	case CS43130_ASP_CH_1_LOC:
+	case CS43130_ASP_CH_2_LOC:
+	case CS43130_ASP_CH_1_SZ_EN:
+	case CS43130_ASP_CH_2_SZ_EN:
+	case CS43130_XSP_CH_1_LOC:
+	case CS43130_XSP_CH_2_LOC:
+	case CS43130_XSP_CH_1_SZ_EN:
+	case CS43130_XSP_CH_2_SZ_EN:
+	case CS43130_DSD_VOL_B ... CS43130_DSD_PATH_CTL_3:
+	case CS43130_HP_OUT_CTL_1:
+	case CS43130_PCM_FILT_OPT ... CS43130_PCM_PATH_CTL_2:
+	case CS43130_CLASS_H_CTL:
+	case CS43130_HP_DETECT:
+	case CS43130_HP_STATUS:
+	case CS43130_HP_LOAD_1:
+	case CS43130_HP_MEAS_LOAD_1:
+	case CS43130_HP_MEAS_LOAD_2:
+	case CS43130_HP_DC_STAT_1:
+	case CS43130_HP_DC_STAT_2:
+	case CS43130_HP_AC_STAT_1:
+	case CS43130_HP_AC_STAT_2:
+	case CS43130_HP_LOAD_STAT:
+	case CS43130_INT_STATUS_1 ... CS43130_INT_STATUS_5:
+	case CS43130_INT_MASK_1 ... CS43130_INT_MASK_5:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs43130_precious_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS43130_INT_STATUS_1 ... CS43130_INT_STATUS_5:
+		return true;
+	default:
+		return false;
+	}
+}
+
+struct cs43130_pll_params {
+	unsigned int pll_in;
+	u8 sclk_prediv;
+	u8 pll_div_int;
+	u32 pll_div_frac;
+	u8 pll_mode;
+	u8 pll_divout;
+	unsigned int pll_out;
+	u8 pll_cal_ratio;
+};
+
+static const struct cs43130_pll_params pll_ratio_table[] = {
+	{9600000, 0x02, 0x49, 0x800000, 0x00, 0x08, 22579200, 151},
+	{9600000, 0x02, 0x50, 0x000000, 0x00, 0x08, 24576000, 164},
+
+	{11289600, 0x02, 0X40, 0, 0x01, 0x08, 22579200, 128},
+	{11289600, 0x02, 0x44, 0x06F700, 0x0, 0x08, 24576000, 139},
+
+	{12000000, 0x02, 0x49, 0x800000, 0x00, 0x0A, 22579200, 120},
+	{12000000, 0x02, 0x40, 0x000000, 0x00, 0x08, 24576000, 131},
+
+	{12288000, 0x02, 0x49, 0x800000, 0x01, 0x0A, 22579200, 118},
+	{12288000, 0x02, 0x40, 0x000000, 0x01, 0x08, 24576000, 128},
+
+	{13000000, 0x02, 0x45, 0x797680, 0x01, 0x0A, 22579200, 111},
+	{13000000, 0x02, 0x3C, 0x7EA940, 0x01, 0x08, 24576000, 121},
+
+	{19200000, 0x03, 0x49, 0x800000, 0x00, 0x08, 22579200, 151},
+	{19200000, 0x03, 0x50, 0x000000, 0x00, 0x08, 24576000, 164},
+
+	{22579200, 0, 0, 0, 0, 0, 22579200, 0},
+	{22579200, 0x03, 0x44, 0x06F700, 0x00, 0x08, 24576000, 139},
+
+	{24000000, 0x03, 0x49, 0x800000, 0x00, 0x0A, 22579200, 120},
+	{24000000, 0x03, 0x40, 0x000000, 0x00, 0x08, 24576000, 131},
+
+	{24576000, 0x03, 0x49, 0x800000, 0x01, 0x0A, 22579200, 118},
+	{24576000, 0, 0, 0, 0, 0, 24576000, 0},
+
+	{26000000, 0x03, 0x45, 0x797680, 0x01, 0x0A, 22579200, 111},
+	{26000000, 0x03, 0x3C, 0x7EA940, 0x01, 0x08, 24576000, 121},
+};
+
+static const struct cs43130_pll_params *cs43130_get_pll_table(
+		unsigned int freq_in, unsigned int freq_out)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
+		if (pll_ratio_table[i].pll_in == freq_in &&
+		    pll_ratio_table[i].pll_out == freq_out)
+			return &pll_ratio_table[i];
+	}
+
+	return NULL;
+}
+
+static int cs43130_pll_config(struct snd_soc_codec *codec)
+{
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	const struct cs43130_pll_params *pll_entry;
+
+	dev_dbg(codec->dev, "cs43130->mclk = %u, cs43130->mclk_int = %u\n",
+		cs43130->mclk, cs43130->mclk_int);
+
+	pll_entry = cs43130_get_pll_table(cs43130->mclk, cs43130->mclk_int);
+	if (!pll_entry)
+		return -EINVAL;
+
+	if (pll_entry->pll_cal_ratio == 0) {
+		regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_1,
+				   CS43130_PLL_START_MASK, 0);
+
+		cs43130->pll_bypass = true;
+		return 0;
+	}
+
+	cs43130->pll_bypass = false;
+
+	regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_2,
+			   CS43130_PLL_DIV_DATA_MASK,
+			   pll_entry->pll_div_frac >>
+			   CS43130_PLL_DIV_FRAC_0_DATA_SHIFT);
+	regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_3,
+			   CS43130_PLL_DIV_DATA_MASK,
+			   pll_entry->pll_div_frac >>
+			   CS43130_PLL_DIV_FRAC_1_DATA_SHIFT);
+	regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_4,
+			   CS43130_PLL_DIV_DATA_MASK,
+			   pll_entry->pll_div_frac >>
+			   CS43130_PLL_DIV_FRAC_2_DATA_SHIFT);
+	regmap_write(cs43130->regmap, CS43130_PLL_SET_5,
+		     pll_entry->pll_div_int);
+	regmap_write(cs43130->regmap, CS43130_PLL_SET_6, pll_entry->pll_divout);
+	regmap_write(cs43130->regmap, CS43130_PLL_SET_7,
+		     pll_entry->pll_cal_ratio);
+	regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_8,
+			   CS43130_PLL_MODE_MASK,
+			   pll_entry->pll_mode << CS43130_PLL_MODE_SHIFT);
+	regmap_write(cs43130->regmap, CS43130_PLL_SET_9,
+		     pll_entry->sclk_prediv);
+	regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_1,
+			   CS43130_PLL_START_MASK, 1);
+
+	return 0;
+}
+
+static int cs43130_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
+			   unsigned int freq_in, unsigned int freq_out)
+{
+	int ret = 0;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (freq_in) {
+	case 9600000:
+	case 11289600:
+	case 12000000:
+	case 12288000:
+	case 13000000:
+	case 19200000:
+	case 22579200:
+	case 24000000:
+	case 24576000:
+	case 26000000:
+		cs43130->mclk = freq_in;
+		break;
+	default:
+		dev_err(codec->dev,
+			"unsupported pll input reference clock:%d\n", freq_in);
+		return -EINVAL;
+	}
+
+	switch (freq_out) {
+	case 22579200:
+		cs43130->mclk_int = freq_out;
+		break;
+	case 24576000:
+		cs43130->mclk_int = freq_out;
+		break;
+	default:
+		dev_err(codec->dev,
+			"unsupported pll output ref clock: %u\n", freq_out);
+		return -EINVAL;
+	}
+
+	ret = cs43130_pll_config(codec);
+	dev_dbg(codec->dev, "cs43130->pll_bypass = %d", cs43130->pll_bypass);
+	return ret;
+}
+
+static int cs43130_change_clksrc(struct snd_soc_codec *codec,
+				 enum cs43130_mclk_src_sel src)
+{
+	int ret;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	int mclk_int_decoded;
+
+	if (src == cs43130->mclk_int_src) {
+		/* clk source has not changed */
+		return 0;
+	}
+
+	switch (cs43130->mclk_int) {
+	case CS43130_MCLK_22M:
+		mclk_int_decoded = CS43130_MCLK_22P5;
+		break;
+	case CS43130_MCLK_24M:
+		mclk_int_decoded = CS43130_MCLK_24P5;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid MCLK INT freq: %u\n", cs43130->mclk_int);
+		return -EINVAL;
+	}
+
+	switch (src) {
+	case CS43130_MCLK_SRC_EXT:
+		cs43130->pll_bypass = true;
+		cs43130->mclk_int_src = CS43130_MCLK_SRC_EXT;
+		if (cs43130->xtal_ibias == CS43130_XTAL_UNUSED) {
+			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+					   CS43130_PDN_XTAL_MASK,
+					   1 << CS43130_PDN_XTAL_SHIFT);
+		} else {
+			reinit_completion(&cs43130->xtal_rdy);
+			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+					   CS43130_XTAL_RDY_INT_MASK, 0);
+			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+					   CS43130_PDN_XTAL_MASK, 0);
+			ret = wait_for_completion_timeout(&cs43130->xtal_rdy,
+							  msecs_to_jiffies(100));
+			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+					   CS43130_XTAL_RDY_INT_MASK,
+					   1 << CS43130_XTAL_RDY_INT_SHIFT);
+			if (ret == 0) {
+				dev_err(codec->dev, "Timeout waiting for XTAL_READY interrupt\n");
+				return -ETIMEDOUT;
+			}
+		}
+
+		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+				   CS43130_MCLK_SRC_SEL_MASK,
+				   src << CS43130_MCLK_SRC_SEL_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+				   CS43130_MCLK_INT_MASK,
+				   mclk_int_decoded << CS43130_MCLK_INT_SHIFT);
+		usleep_range(150, 200);
+
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+				   CS43130_PDN_PLL_MASK,
+				   1 << CS43130_PDN_PLL_SHIFT);
+		break;
+	case CS43130_MCLK_SRC_PLL:
+		cs43130->pll_bypass = false;
+		cs43130->mclk_int_src = CS43130_MCLK_SRC_PLL;
+		if (cs43130->xtal_ibias == CS43130_XTAL_UNUSED) {
+			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+					   CS43130_PDN_XTAL_MASK,
+					   1 << CS43130_PDN_XTAL_SHIFT);
+		} else {
+			reinit_completion(&cs43130->xtal_rdy);
+			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+					   CS43130_XTAL_RDY_INT_MASK, 0);
+			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+					   CS43130_PDN_XTAL_MASK, 0);
+			ret = wait_for_completion_timeout(&cs43130->xtal_rdy,
+							  msecs_to_jiffies(100));
+			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+					   CS43130_XTAL_RDY_INT_MASK,
+					   1 << CS43130_XTAL_RDY_INT_SHIFT);
+			if (ret == 0) {
+				dev_err(codec->dev, "Timeout waiting for XTAL_READY interrupt\n");
+				return -ETIMEDOUT;
+			}
+		}
+
+		reinit_completion(&cs43130->pll_rdy);
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_PLL_RDY_INT_MASK, 0);
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+				   CS43130_PDN_PLL_MASK, 0);
+		ret = wait_for_completion_timeout(&cs43130->pll_rdy,
+						  msecs_to_jiffies(100));
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_PLL_RDY_INT_MASK,
+				   1 << CS43130_PLL_RDY_INT_SHIFT);
+		if (ret == 0) {
+			dev_err(codec->dev, "Timeout waiting for PLL_READY interrupt\n");
+			return -ETIMEDOUT;
+		}
+
+		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+				   CS43130_MCLK_SRC_SEL_MASK,
+				   src << CS43130_MCLK_SRC_SEL_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+				   CS43130_MCLK_INT_MASK,
+				   mclk_int_decoded << CS43130_MCLK_INT_SHIFT);
+		usleep_range(150, 200);
+		break;
+	case CS43130_MCLK_SRC_RCO:
+		cs43130->mclk_int_src = CS43130_MCLK_SRC_RCO;
+
+		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+				   CS43130_MCLK_SRC_SEL_MASK,
+				   src << CS43130_MCLK_SRC_SEL_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+				   CS43130_MCLK_INT_MASK,
+				   CS43130_MCLK_22P5 << CS43130_MCLK_INT_SHIFT);
+		usleep_range(150, 200);
+
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+				   CS43130_PDN_XTAL_MASK,
+				   1 << CS43130_PDN_XTAL_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+				   CS43130_PDN_PLL_MASK,
+				   1 << CS43130_PDN_PLL_SHIFT);
+		break;
+	default:
+		dev_err(codec->dev, "Invalid MCLK source value\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct cs43130_bitwidth_map cs43130_bitwidth_table[] = {
+	{8,	CS43130_SP_BIT_SIZE_8,	CS43130_CH_BIT_SIZE_8},
+	{16,	CS43130_SP_BIT_SIZE_16, CS43130_CH_BIT_SIZE_16},
+	{24,	CS43130_SP_BIT_SIZE_24, CS43130_CH_BIT_SIZE_24},
+	{32,	CS43130_SP_BIT_SIZE_32, CS43130_CH_BIT_SIZE_32},
+};
+
+static const struct cs43130_bitwidth_map *cs43130_get_bitwidth_table(
+				unsigned int bitwidth)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs43130_bitwidth_table); i++) {
+		if (cs43130_bitwidth_table[i].bitwidth == bitwidth)
+			return &cs43130_bitwidth_table[i];
+	}
+
+	return NULL;
+}
+
+static int cs43130_set_bitwidth(int dai_id, unsigned int bitwidth_dai,
+			  struct regmap *regmap)
+{
+	const struct cs43130_bitwidth_map *bw_map;
+
+	bw_map = cs43130_get_bitwidth_table(bitwidth_dai);
+	if (!bw_map)
+		return -EINVAL;
+
+	switch (dai_id) {
+	case CS43130_ASP_PCM_DAI:
+	case CS43130_ASP_DOP_DAI:
+		regmap_update_bits(regmap, CS43130_ASP_CH_1_SZ_EN,
+				   CS43130_CH_BITSIZE_MASK, bw_map->ch_bit);
+		regmap_update_bits(regmap, CS43130_ASP_CH_2_SZ_EN,
+				   CS43130_CH_BITSIZE_MASK, bw_map->ch_bit);
+		regmap_update_bits(regmap, CS43130_SP_BITSIZE,
+				   CS43130_ASP_BITSIZE_MASK, bw_map->sp_bit);
+		break;
+	case CS43130_XSP_DOP_DAI:
+		regmap_update_bits(regmap, CS43130_XSP_CH_1_SZ_EN,
+				   CS43130_CH_BITSIZE_MASK, bw_map->ch_bit);
+		regmap_update_bits(regmap, CS43130_XSP_CH_2_SZ_EN,
+				   CS43130_CH_BITSIZE_MASK, bw_map->ch_bit);
+		regmap_update_bits(regmap, CS43130_SP_BITSIZE,
+				   CS43130_XSP_BITSIZE_MASK, bw_map->sp_bit <<
+				   CS43130_XSP_BITSIZE_SHIFT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct cs43130_rate_map cs43130_rate_table[] = {
+	{32000,		CS43130_ASP_SPRATE_32K},
+	{44100,		CS43130_ASP_SPRATE_44_1K},
+	{48000,		CS43130_ASP_SPRATE_48K},
+	{88200,		CS43130_ASP_SPRATE_88_2K},
+	{96000,		CS43130_ASP_SPRATE_96K},
+	{176400,	CS43130_ASP_SPRATE_176_4K},
+	{192000,	CS43130_ASP_SPRATE_192K},
+	{352800,	CS43130_ASP_SPRATE_352_8K},
+	{384000,	CS43130_ASP_SPRATE_384K},
+};
+
+static const struct cs43130_rate_map *cs43130_get_rate_table(int fs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs43130_rate_table); i++) {
+		if (cs43130_rate_table[i].fs == fs)
+			return &cs43130_rate_table[i];
+	}
+
+	return NULL;
+}
+
+static const struct cs43130_clk_gen *cs43130_get_clk_gen(int mclk_int, int fs,
+		const struct cs43130_clk_gen *clk_gen_table, int len_clk_gen_table)
+{
+	int i;
+
+	for (i = 0; i < len_clk_gen_table; i++) {
+		if (clk_gen_table[i].mclk_int == mclk_int &&
+		    clk_gen_table[i].fs == fs)
+			return &clk_gen_table[i];
+	}
+
+	return NULL;
+}
+
+static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
+			      struct snd_pcm_hw_params *params,
+			      struct cs43130_private *cs43130)
+{
+	u16 frm_size;
+	u16 hi_size;
+	u8 frm_delay;
+	u8 frm_phase;
+	u8 frm_data;
+	u8 sclk_edge;
+	u8 lrck_edge;
+	u8 clk_data;
+	u8 loc_ch1;
+	u8 loc_ch2;
+	u8 dai_mode_val;
+	const struct cs43130_clk_gen *clk_gen;
+
+	switch (cs43130->dais[dai_id].dai_format) {
+	case SND_SOC_DAIFMT_I2S:
+		hi_size = bitwidth_sclk;
+		frm_delay = 2;
+		frm_phase = 0;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		hi_size = bitwidth_sclk;
+		frm_delay = 2;
+		frm_phase = 1;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		hi_size = 1;
+		frm_delay = 2;
+		frm_phase = 1;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		hi_size = 1;
+		frm_delay = 0;
+		frm_phase = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (cs43130->dais[dai_id].dai_mode) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		dai_mode_val = 0;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		dai_mode_val = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	frm_size = bitwidth_sclk * params_channels(params);
+	sclk_edge = 1;
+	lrck_edge = 0;
+	loc_ch1 = 0;
+	loc_ch2 = bitwidth_sclk * (params_channels(params) - 1);
+
+	frm_data = frm_delay & CS43130_SP_FSD_MASK;
+	frm_data |= (frm_phase << CS43130_SP_STP_SHIFT) & CS43130_SP_STP_MASK;
+
+	clk_data = lrck_edge & CS43130_SP_LCPOL_IN_MASK;
+	clk_data |= (lrck_edge << CS43130_SP_LCPOL_OUT_SHIFT) &
+		    CS43130_SP_LCPOL_OUT_MASK;
+	clk_data |= (sclk_edge << CS43130_SP_SCPOL_IN_SHIFT) &
+		    CS43130_SP_SCPOL_IN_MASK;
+	clk_data |= (sclk_edge << CS43130_SP_SCPOL_OUT_SHIFT) &
+		    CS43130_SP_SCPOL_OUT_MASK;
+	clk_data |= (dai_mode_val << CS43130_SP_MODE_SHIFT) &
+		    CS43130_SP_MODE_MASK;
+
+	switch (dai_id) {
+	case CS43130_ASP_PCM_DAI:
+	case CS43130_ASP_DOP_DAI:
+		regmap_update_bits(cs43130->regmap, CS43130_ASP_LRCK_PERIOD_1,
+			CS43130_SP_LCPR_DATA_MASK, (frm_size - 1) >>
+			CS43130_SP_LCPR_LSB_DATA_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_ASP_LRCK_PERIOD_2,
+			CS43130_SP_LCPR_DATA_MASK, (frm_size - 1) >>
+			CS43130_SP_LCPR_MSB_DATA_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_ASP_LRCK_HI_TIME_1,
+			CS43130_SP_LCHI_DATA_MASK, (hi_size - 1) >>
+			CS43130_SP_LCHI_LSB_DATA_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_ASP_LRCK_HI_TIME_2,
+			CS43130_SP_LCHI_DATA_MASK, (hi_size - 1) >>
+			CS43130_SP_LCHI_MSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_ASP_FRAME_CONF, frm_data);
+		regmap_write(cs43130->regmap, CS43130_ASP_CH_1_LOC, loc_ch1);
+		regmap_write(cs43130->regmap, CS43130_ASP_CH_2_LOC, loc_ch2);
+		regmap_update_bits(cs43130->regmap, CS43130_ASP_CH_1_SZ_EN,
+			CS43130_CH_EN_MASK, 1 << CS43130_CH_EN_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_ASP_CH_2_SZ_EN,
+			CS43130_CH_EN_MASK, 1 << CS43130_CH_EN_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_ASP_CLOCK_CONF, clk_data);
+		break;
+	case CS43130_XSP_DOP_DAI:
+		regmap_update_bits(cs43130->regmap, CS43130_XSP_LRCK_PERIOD_1,
+			CS43130_SP_LCPR_DATA_MASK, (frm_size - 1) >>
+			CS43130_SP_LCPR_LSB_DATA_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_XSP_LRCK_PERIOD_2,
+			CS43130_SP_LCPR_DATA_MASK, (frm_size - 1) >>
+			CS43130_SP_LCPR_MSB_DATA_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_XSP_LRCK_HI_TIME_1,
+			CS43130_SP_LCHI_DATA_MASK, (hi_size - 1) >>
+			CS43130_SP_LCHI_LSB_DATA_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_XSP_LRCK_HI_TIME_2,
+			CS43130_SP_LCHI_DATA_MASK, (hi_size - 1) >>
+			CS43130_SP_LCHI_MSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_XSP_FRAME_CONF, frm_data);
+		regmap_write(cs43130->regmap, CS43130_XSP_CH_1_LOC, loc_ch1);
+		regmap_write(cs43130->regmap, CS43130_XSP_CH_2_LOC, loc_ch2);
+		regmap_update_bits(cs43130->regmap, CS43130_XSP_CH_1_SZ_EN,
+			CS43130_CH_EN_MASK, 1 << CS43130_CH_EN_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_XSP_CH_2_SZ_EN,
+			CS43130_CH_EN_MASK, 1 << CS43130_CH_EN_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_XSP_CLOCK_CONF, clk_data);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (frm_size) {
+	case 16:
+		clk_gen = cs43130_get_clk_gen(cs43130->mclk_int,
+					      params_rate(params),
+					      cs43130_16_clk_gen,
+					      ARRAY_SIZE(cs43130_16_clk_gen));
+		break;
+	case 32:
+		clk_gen = cs43130_get_clk_gen(cs43130->mclk_int,
+					      params_rate(params),
+					      cs43130_32_clk_gen,
+					      ARRAY_SIZE(cs43130_32_clk_gen));
+		break;
+	case 48:
+		clk_gen = cs43130_get_clk_gen(cs43130->mclk_int,
+					      params_rate(params),
+					      cs43130_48_clk_gen,
+					      ARRAY_SIZE(cs43130_48_clk_gen));
+		break;
+	case 64:
+		clk_gen = cs43130_get_clk_gen(cs43130->mclk_int,
+					      params_rate(params),
+					      cs43130_64_clk_gen,
+					      ARRAY_SIZE(cs43130_64_clk_gen));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!clk_gen)
+		return -EINVAL;
+
+	switch (dai_id) {
+	case CS43130_ASP_PCM_DAI:
+	case CS43130_ASP_DOP_DAI:
+		regmap_write(cs43130->regmap, CS43130_ASP_DEN_1,
+			     (clk_gen->den & CS43130_SP_M_LSB_DATA_MASK) >>
+			     CS43130_SP_M_LSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_ASP_DEN_2,
+			     (clk_gen->den & CS43130_SP_M_MSB_DATA_MASK) >>
+			     CS43130_SP_M_MSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_ASP_NUM_1,
+			     (clk_gen->num & CS43130_SP_N_LSB_DATA_MASK) >>
+			     CS43130_SP_N_LSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_ASP_NUM_2,
+			     (clk_gen->num & CS43130_SP_N_MSB_DATA_MASK) >>
+			     CS43130_SP_N_MSB_DATA_SHIFT);
+		break;
+	case CS43130_XSP_DOP_DAI:
+		regmap_write(cs43130->regmap, CS43130_XSP_DEN_1,
+			     (clk_gen->den & CS43130_SP_M_LSB_DATA_MASK) >>
+			     CS43130_SP_M_LSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_XSP_DEN_2,
+			     (clk_gen->den & CS43130_SP_M_MSB_DATA_MASK) >>
+			     CS43130_SP_M_MSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_XSP_NUM_1,
+			     (clk_gen->num & CS43130_SP_N_LSB_DATA_MASK) >>
+			     CS43130_SP_N_LSB_DATA_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_XSP_NUM_2,
+			     (clk_gen->num & CS43130_SP_N_MSB_DATA_MASK) >>
+			     CS43130_SP_N_MSB_DATA_SHIFT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cs43130_pcm_dsd_mix(bool en, struct regmap *regmap)
+{
+	if (en) {
+		regmap_update_bits(regmap, CS43130_DSD_PCM_MIX_CTL,
+				   CS43130_MIX_PCM_PREP_MASK,
+				   1 << CS43130_MIX_PCM_PREP_SHIFT);
+		usleep_range(6000, 6050);
+		regmap_update_bits(regmap, CS43130_DSD_PCM_MIX_CTL,
+				   CS43130_MIX_PCM_DSD_MASK,
+				   1 << CS43130_MIX_PCM_DSD_SHIFT);
+	} else {
+		regmap_update_bits(regmap, CS43130_DSD_PCM_MIX_CTL,
+				   CS43130_MIX_PCM_DSD_MASK,
+				   0 << CS43130_MIX_PCM_DSD_SHIFT);
+		usleep_range(1600, 1650);
+		regmap_update_bits(regmap, CS43130_DSD_PCM_MIX_CTL,
+				   CS43130_MIX_PCM_PREP_MASK,
+				   0 << CS43130_MIX_PCM_PREP_SHIFT);
+	}
+
+	return 0;
+}
+
+static int cs43130_dsd_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	unsigned int required_clk;
+	u8 dsd_speed;
+
+	mutex_lock(&cs43130->clk_mutex);
+	if (!cs43130->clk_req) {
+		/* no DAI is currently using clk */
+		if (!(CS43130_MCLK_22M % params_rate(params)))
+			required_clk = CS43130_MCLK_22M;
+		else
+			required_clk = CS43130_MCLK_24M;
+
+		cs43130_set_pll(codec, 0, 0, cs43130->mclk, required_clk);
+		if (cs43130->pll_bypass)
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_EXT);
+		else
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
+	}
+
+	cs43130->clk_req++;
+	if (cs43130->clk_req == 2)
+		cs43130_pcm_dsd_mix(true, cs43130->regmap);
+	mutex_unlock(&cs43130->clk_mutex);
+
+	switch (params_rate(params)) {
+	case 176400:
+		dsd_speed = 0;
+		break;
+	case 352800:
+		dsd_speed = 1;
+		break;
+	default:
+		dev_err(codec->dev, "Rate(%u) not supported\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	if (cs43130->dais[dai->id].dai_mode == SND_SOC_DAIFMT_CBM_CFM)
+		regmap_update_bits(cs43130->regmap, CS43130_DSD_INT_CFG,
+				   CS43130_DSD_MASTER, CS43130_DSD_MASTER);
+	else
+		regmap_update_bits(cs43130->regmap, CS43130_DSD_INT_CFG,
+				   CS43130_DSD_MASTER, 0);
+
+	regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_2,
+			   CS43130_DSD_SPEED_MASK,
+			   dsd_speed << CS43130_DSD_SPEED_SHIFT);
+	regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_2,
+			   CS43130_DSD_SRC_MASK, CS43130_DSD_SRC_DSD <<
+			   CS43130_DSD_SRC_SHIFT);
+
+	return 0;
+}
+
+static int cs43130_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	const struct cs43130_rate_map *rate_map;
+	unsigned int sclk = cs43130->dais[dai->id].sclk;
+	unsigned int bitwidth_sclk;
+	unsigned int bitwidth_dai = (unsigned int)(params_width(params));
+	unsigned int required_clk;
+	u8 dsd_speed;
+
+	mutex_lock(&cs43130->clk_mutex);
+	if (!cs43130->clk_req) {
+		/* no DAI is currently using clk */
+		if (!(CS43130_MCLK_22M % params_rate(params)))
+			required_clk = CS43130_MCLK_22M;
+		else
+			required_clk = CS43130_MCLK_24M;
+
+		cs43130_set_pll(codec, 0, 0, cs43130->mclk, required_clk);
+		if (cs43130->pll_bypass)
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_EXT);
+		else
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
+	}
+
+	cs43130->clk_req++;
+	if (cs43130->clk_req == 2)
+		cs43130_pcm_dsd_mix(true, cs43130->regmap);
+	mutex_unlock(&cs43130->clk_mutex);
+
+	if (dai->id == CS43130_ASP_DOP_DAI ||
+	    dai->id == CS43130_XSP_DOP_DAI) {
+		/* DoP bitwidth is always 24-bit */
+		bitwidth_dai = 24;
+		sclk = params_rate(params) * bitwidth_dai *
+		       params_channels(params);
+
+		switch (params_rate(params)) {
+		case 176400:
+			dsd_speed = 0;
+			break;
+		case 352800:
+			dsd_speed = 1;
+			break;
+		default:
+			dev_err(codec->dev, "Rate(%u) not supported\n",
+				params_rate(params));
+			return -EINVAL;
+		}
+
+		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_2,
+				   CS43130_DSD_SPEED_MASK,
+				   dsd_speed << CS43130_DSD_SPEED_SHIFT);
+	} else {
+		/* ASP PCM format */
+		rate_map = cs43130_get_rate_table(params_rate(params));
+		if (!rate_map)
+			return -EINVAL;
+
+		regmap_write(cs43130->regmap, CS43130_SP_SRATE, rate_map->val);
+	}
+
+	if (dai->id == CS43130_ASP_DOP_DAI) {
+		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_2,
+				   CS43130_DSD_SRC_MASK, CS43130_DSD_SRC_ASP <<
+				   CS43130_DSD_SRC_SHIFT);
+	} else if (dai->id == CS43130_XSP_DOP_DAI) {
+		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_2,
+				   CS43130_DSD_SRC_MASK, CS43130_DSD_SRC_XSP <<
+				   CS43130_DSD_SRC_SHIFT);
+	}
+
+
+	if (!sclk && cs43130->dais[dai->id].dai_mode == SND_SOC_DAIFMT_CBM_CFM)
+		/* Calculate SCLK in master mode if unassigned */
+		sclk = params_rate(params) * bitwidth_dai *
+		       params_channels(params);
+
+	if (!sclk) {
+		/* at this point, SCLK must be set */
+		dev_err(codec->dev, "SCLK freq is not set\n");
+		return -EINVAL;
+	}
+
+	bitwidth_sclk = (sclk / params_rate(params)) / params_channels(params);
+	if (bitwidth_sclk < bitwidth_dai) {
+		dev_err(codec->dev, "Format not supported: SCLK freq is too low\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev,
+		"sclk = %u, fs = %d, bitwidth_dai = %u\n",
+		sclk, params_rate(params), bitwidth_dai);
+
+	dev_dbg(codec->dev,
+		"bitwidth_sclk = %u, num_ch = %u\n",
+		bitwidth_sclk, params_channels(params));
+
+	cs43130_set_bitwidth(dai->id, bitwidth_dai, cs43130->regmap);
+	cs43130_set_sp_fmt(dai->id, bitwidth_sclk, params, cs43130);
+
+	return 0;
+}
+
+static int cs43130_hw_free(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	mutex_lock(&cs43130->clk_mutex);
+	cs43130->clk_req--;
+	if (!cs43130->clk_req) {
+		/* no DAI is currently using clk */
+		cs43130_change_clksrc(codec, CS43130_MCLK_SRC_RCO);
+		cs43130_pcm_dsd_mix(false, cs43130->regmap);
+	}
+	mutex_unlock(&cs43130->clk_mutex);
+
+	return 0;
+}
+
+static const DECLARE_TLV_DB_SCALE(pcm_vol_tlv, -12750, 50, 1);
+
+static const char * const pcm_ch_text[] = {
+	"Left-Right Ch",
+	"Left-Left Ch",
+	"Right-Left Ch",
+	"Right-Right Ch",
+};
+
+static const struct reg_sequence pcm_ch_en_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{0x180005, 0x8C},
+	{0x180007, 0xAB},
+	{0x180015, 0x31},
+	{0x180017, 0xB2},
+	{0x180025, 0x30},
+	{0x180027, 0x84},
+	{0x180035, 0x9C},
+	{0x180037, 0xAE},
+	{0x18000D, 0x24},
+	{0x18000F, 0xA3},
+	{0x18001D, 0x05},
+	{0x18001F, 0xD4},
+	{0x18002D, 0x0B},
+	{0x18002F, 0xC7},
+	{0x18003D, 0x71},
+	{0x18003F, 0xE7},
+	{CS43130_DXD1, 0},
+};
+
+static const struct reg_sequence pcm_ch_dis_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{0x180005, 0x24},
+	{0x180007, 0xA3},
+	{0x180015, 0x05},
+	{0x180017, 0xD4},
+	{0x180025, 0x0B},
+	{0x180027, 0xC7},
+	{0x180035, 0x71},
+	{0x180037, 0xE7},
+	{0x18000D, 0x8C},
+	{0x18000F, 0xAB},
+	{0x18001D, 0x31},
+	{0x18001F, 0xB2},
+	{0x18002D, 0x30},
+	{0x18002F, 0x84},
+	{0x18003D, 0x9C},
+	{0x18003F, 0xAE},
+	{CS43130_DXD1, 0},
+};
+
+static int cs43130_pcm_ch_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_soc_get_enum_double(kcontrol, ucontrol);
+}
+
+static int cs43130_pcm_ch_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+
+	if (item[0] >= e->items)
+		return -EINVAL;
+	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
+
+	if (cs43130->dev_id == CS43131_CHIP_ID ||
+	    cs43130->dev_id == CS43198_CHIP_ID) {
+		if (val >= 2)
+			regmap_multi_reg_write(cs43130->regmap, pcm_ch_en_seq,
+					       ARRAY_SIZE(pcm_ch_en_seq));
+		else
+			regmap_multi_reg_write(cs43130->regmap, pcm_ch_dis_seq,
+					       ARRAY_SIZE(pcm_ch_dis_seq));
+	}
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
+static SOC_ENUM_SINGLE_DECL(pcm_ch_enum, CS43130_PCM_PATH_CTL_2, 0,
+			    pcm_ch_text);
+
+static const char * const pcm_spd_texts[] = {
+	"Fast",
+	"Slow",
+};
+
+static SOC_ENUM_SINGLE_DECL(pcm_spd_enum, CS43130_PCM_FILT_OPT, 7,
+			    pcm_spd_texts);
+
+static const char * const enum_texts[] = {
+	"Off",
+	"On",
+};
+
+static SOC_ENUM_SINGLE_DECL(pcm_phs_enum, CS43130_PCM_FILT_OPT, 6, enum_texts);
+
+static SOC_ENUM_SINGLE_DECL(pcm_nos_enum, CS43130_PCM_FILT_OPT, 5, enum_texts);
+
+static SOC_ENUM_SINGLE_DECL(pcm_high_enum, CS43130_PCM_FILT_OPT, 1, enum_texts);
+
+static SOC_ENUM_SINGLE_DECL(pcm_dmp_enum, CS43130_PCM_FILT_OPT, 0, enum_texts);
+
+static const char * const dsd_texts[] = {
+	"Off",
+	"BCKA Mode",
+	"BCKD Mode",
+};
+
+static const unsigned int dsd_values[] = {
+	CS43130_DSD_SRC_DSD,
+	CS43130_DSD_SRC_ASP,
+	CS43130_DSD_SRC_XSP,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(dsd_enum, CS43130_DSD_INT_CFG, 0, 0x03,
+				  dsd_texts, dsd_values);
+
+static const struct snd_kcontrol_new cs43130_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			 CS43130_PCM_VOL_A, CS43130_PCM_VOL_B, 0, 0xFF, 1,
+			 pcm_vol_tlv),
+	SOC_DOUBLE_R_TLV("Master DSD Playback Volume",
+			 CS43130_DSD_VOL_A, CS43130_DSD_VOL_B, 0, 0xFF, 1,
+			 pcm_vol_tlv),
+	SOC_ENUM_EXT("PCM Ch Select", pcm_ch_enum, cs43130_pcm_ch_get,
+		     cs43130_pcm_ch_put),
+	SOC_ENUM("PCM Filter Speed", pcm_spd_enum),
+	SOC_ENUM("PCM Phase Compensation", pcm_phs_enum),
+	SOC_ENUM("PCM Nonoversampling Emulation", pcm_nos_enum),
+	SOC_ENUM("PCM High-pass Filter", pcm_high_enum),
+	SOC_ENUM("PCM De-emphasis Filter", pcm_dmp_enum),
+	SOC_ENUM("DSD Phase Modulation", dsd_enum),
+};
+
+static const struct reg_sequence pcm_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD7, 0x01},
+	{CS43130_DXD8, 0},
+	{CS43130_DXD9, 0x01},
+	{CS43130_DXD3, 0x12},
+	{CS43130_DXD4, 0},
+	{CS43130_DXD10, 0x28},
+	{CS43130_DXD11, 0x28},
+	{CS43130_DXD1, 0},
+};
+
+static const struct reg_sequence dsd_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD7, 0x01},
+	{CS43130_DXD8, 0},
+	{CS43130_DXD9, 0x01},
+	{CS43130_DXD3, 0x12},
+	{CS43130_DXD4, 0},
+	{CS43130_DXD10, 0x1E},
+	{CS43130_DXD11, 0x20},
+	{CS43130_DXD1, 0},
+};
+
+static const struct reg_sequence pop_free_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD12, 0x0A},
+	{CS43130_DXD1, 0},
+};
+
+static const struct reg_sequence pop_free_seq2[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD13, 0x20},
+	{CS43130_DXD1, 0},
+};
+
+static int cs43130_dsd_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID)
+			regmap_multi_reg_write(cs43130->regmap, dsd_seq,
+					       ARRAY_SIZE(dsd_seq));
+		break;
+	default:
+		dev_err(codec->dev, "Invalid event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cs43130_pcm_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID)
+			regmap_multi_reg_write(cs43130->regmap, pcm_seq,
+					       ARRAY_SIZE(pcm_seq));
+		break;
+	default:
+		dev_err(codec->dev, "Invalid event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct reg_sequence dac_postpmu_seq[] = {
+	{CS43130_DXD9, 0x0C},
+	{CS43130_DXD3, 0x10},
+	{CS43130_DXD4, 0x20},
+};
+
+static const struct reg_sequence dac_postpmd_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD6, 0x01},
+	{CS43130_DXD1, 0},
+};
+
+static int cs43130_dac_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID)
+			regmap_multi_reg_write(cs43130->regmap, pop_free_seq,
+					       ARRAY_SIZE(pop_free_seq));
+		else
+			/* CS43131 or CS43198 */
+			regmap_multi_reg_write(cs43130->regmap, pop_free_seq2,
+					       ARRAY_SIZE(pop_free_seq2));
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(10000, 10050);
+
+		regmap_write(cs43130->regmap, CS43130_DXD1, 0x99);
+
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID) {
+			regmap_multi_reg_write(cs43130->regmap, dac_postpmu_seq,
+					       ARRAY_SIZE(dac_postpmu_seq));
+			/*
+			 * Per datasheet, Sec. PCM Power-Up Sequence.
+			 * According to Design, CS43130_DXD12 must be 0 to meet
+			 * THDN and Dynamic Range spec.
+			 */
+			msleep(1000);
+			regmap_write(cs43130->regmap, CS43130_DXD12, 0);
+		} else {
+			/* CS43131 or CS43198 */
+			usleep_range(12000, 12010);
+			regmap_write(cs43130->regmap, CS43130_DXD13, 0);
+		}
+
+		regmap_write(cs43130->regmap, CS43130_DXD1, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID)
+			regmap_multi_reg_write(cs43130->regmap, dac_postpmd_seq,
+					       ARRAY_SIZE(dac_postpmd_seq));
+		break;
+	default:
+		dev_err(codec->dev, "Invalid DAC event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct reg_sequence hpin_prepmd_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD15, 0x64},
+	{CS43130_DXD14, 0},
+	{CS43130_DXD2, 0},
+	{CS43130_DXD1, 0},
+};
+
+static const struct reg_sequence hpin_postpmu_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD2, 1},
+	{CS43130_DXD14, 0xDC},
+	{CS43130_DXD15, 0xE4},
+	{CS43130_DXD1, 0},
+};
+
+static int cs43130_hpin_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_multi_reg_write(cs43130->regmap, hpin_prepmd_seq,
+				       ARRAY_SIZE(hpin_prepmd_seq));
+		break;
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_multi_reg_write(cs43130->regmap, hpin_postpmu_seq,
+				       ARRAY_SIZE(hpin_postpmu_seq));
+		break;
+	default:
+		dev_err(codec->dev, "Invalid HPIN event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget digital_hp_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("HPOUTA"),
+	SND_SOC_DAPM_OUTPUT("HPOUTB"),
+
+	SND_SOC_DAPM_AIF_IN_E("ASPIN PCM", NULL, 0, CS43130_PWDN_CTL,
+			      CS43130_PDN_ASP_SHIFT, 1, cs43130_pcm_event,
+			      SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_AIF_IN_E("ASPIN DoP", NULL, 0, CS43130_PWDN_CTL,
+			      CS43130_PDN_ASP_SHIFT, 1, cs43130_dsd_event,
+			      SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_AIF_IN_E("XSPIN DoP", NULL, 0, CS43130_PWDN_CTL,
+			      CS43130_PDN_XSP_SHIFT, 1, cs43130_dsd_event,
+			      SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_AIF_IN_E("XSPIN DSD", NULL, 0, CS43130_PWDN_CTL,
+			      CS43130_PDN_DSDIF_SHIFT, 1, cs43130_dsd_event,
+			      SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_DAC("DSD", NULL, CS43130_DSD_PATH_CTL_2,
+			 CS43130_DSD_EN_SHIFT, 0),
+
+	SND_SOC_DAPM_DAC_E("HiFi DAC", NULL, CS43130_PWDN_CTL,
+			   CS43130_PDN_HP_SHIFT, 1, cs43130_dac_event,
+			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD)),
+};
+
+static const struct snd_soc_dapm_widget analog_hp_widgets[] = {
+	SND_SOC_DAPM_DAC_E("Analog Playback", NULL, CS43130_HP_OUT_CTL_1,
+			   CS43130_HP_IN_EN_SHIFT, 0, cs43130_hpin_event,
+			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)),
+};
+
+static struct snd_soc_dapm_widget all_hp_widgets[
+			ARRAY_SIZE(digital_hp_widgets) +
+			ARRAY_SIZE(analog_hp_widgets)];
+
+static const struct snd_soc_dapm_route digital_hp_routes[] = {
+	{"ASPIN PCM", NULL, "ASP PCM Playback"},
+	{"ASPIN DoP", NULL, "ASP DoP Playback"},
+	{"XSPIN DoP", NULL, "XSP DoP Playback"},
+	{"XSPIN DSD", NULL, "XSP DSD Playback"},
+	{"DSD", NULL, "ASPIN DoP"},
+	{"DSD", NULL, "XSPIN DoP"},
+	{"DSD", NULL, "XSPIN DSD"},
+	{"HiFi DAC", NULL, "ASPIN PCM"},
+	{"HiFi DAC", NULL, "DSD"},
+	{"HPOUTA", NULL, "HiFi DAC"},
+	{"HPOUTB", NULL, "HiFi DAC"},
+};
+
+static const struct snd_soc_dapm_route analog_hp_routes[] = {
+	{"HPOUTA", NULL, "Analog Playback"},
+	{"HPOUTB", NULL, "Analog Playback"},
+};
+
+static struct snd_soc_dapm_route all_hp_routes[
+			ARRAY_SIZE(digital_hp_routes) +
+			ARRAY_SIZE(analog_hp_routes)];
+
+static const unsigned int cs43130_asp_src_rates[] = {
+	32000, 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
+};
+
+static const struct snd_pcm_hw_constraint_list cs43130_asp_constraints = {
+	.count	= ARRAY_SIZE(cs43130_asp_src_rates),
+	.list	= cs43130_asp_src_rates,
+};
+
+static int cs43130_pcm_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  &cs43130_asp_constraints);
+}
+
+static const unsigned int cs43130_dop_src_rates[] = {
+	176400, 352800,
+};
+
+static const struct snd_pcm_hw_constraint_list cs43130_dop_constraints = {
+	.count	= ARRAY_SIZE(cs43130_dop_src_rates),
+	.list	= cs43130_dop_src_rates,
+};
+
+static int cs43130_dop_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  &cs43130_dop_constraints);
+}
+
+static int cs43130_pcm_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs43130->dais[codec_dai->id].dai_mode = SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs43130->dais[codec_dai->id].dai_mode = SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	default:
+		dev_err(codec->dev, "unsupported mode\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cs43130->dais[codec_dai->id].dai_format = SND_SOC_DAIFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		cs43130->dais[codec_dai->id].dai_format = SND_SOC_DAIFMT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		cs43130->dais[codec_dai->id].dai_format = SND_SOC_DAIFMT_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		cs43130->dais[codec_dai->id].dai_format = SND_SOC_DAIFMT_DSP_B;
+		break;
+	default:
+		dev_err(codec->dev,
+			"unsupported audio format\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "dai_id = %d,  dai_mode = %u, dai_format = %u\n",
+		codec_dai->id,
+		cs43130->dais[codec_dai->id].dai_mode,
+		cs43130->dais[codec_dai->id].dai_format);
+
+	return 0;
+}
+
+static int cs43130_dsd_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs43130->dais[codec_dai->id].dai_mode = SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs43130->dais[codec_dai->id].dai_mode = SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported DAI format.\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "dai_mode = 0x%x\n",
+		cs43130->dais[codec_dai->id].dai_mode);
+
+	return 0;
+}
+
+static const struct reg_sequence mute_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD3, 0x12},
+	{CS43130_DXD5, 0x02},
+	{CS43130_DXD4, 0x12},
+	{CS43130_DXD1, 0},
+};
+
+static const struct reg_sequence unmute_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD3, 0x10},
+	{CS43130_DXD5, 0},
+	{CS43130_DXD4, 0x16},
+	{CS43130_DXD1, 0},
+};
+
+static int cs43130_pcm_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	if (mute) {
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID) {
+			regmap_multi_reg_write(cs43130->regmap, mute_seq,
+					       ARRAY_SIZE(mute_seq));
+			regmap_update_bits(cs43130->regmap,
+					   CS43130_PCM_PATH_CTL_1,
+					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
+			/*
+			 * PCM Power Down Sequence
+			 * According to Design, 130ms is preferred.
+			 */
+			msleep(130);
+		} else {
+			regmap_update_bits(cs43130->regmap,
+					   CS43130_PCM_PATH_CTL_1,
+					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
+		}
+	} else {
+		/* Unmute */
+		regmap_update_bits(cs43130->regmap, CS43130_PCM_PATH_CTL_1,
+				   CS43130_MUTE_MASK, 0);
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID)
+			regmap_multi_reg_write(cs43130->regmap, unmute_seq,
+					       ARRAY_SIZE(unmute_seq));
+	}
+
+	return 0;
+}
+
+static int cs43130_dsd_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	if (mute) {
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID) {
+			regmap_multi_reg_write(cs43130->regmap, mute_seq,
+					       ARRAY_SIZE(mute_seq));
+			regmap_update_bits(cs43130->regmap,
+					   CS43130_DSD_PATH_CTL_1,
+					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
+			/*
+			 * DSD Power Down Sequence
+			 * According to Design, 130ms is preferred.
+			 */
+			msleep(130);
+		} else {
+			regmap_update_bits(cs43130->regmap,
+					   CS43130_DSD_PATH_CTL_1,
+					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
+		}
+	} else {
+		/* Unmute */
+		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_1,
+				   CS43130_MUTE_MASK, 0);
+		if (cs43130->dev_id == CS43130_CHIP_ID ||
+		    cs43130->dev_id == CS4399_CHIP_ID)
+			regmap_multi_reg_write(cs43130->regmap, unmute_seq,
+					       ARRAY_SIZE(unmute_seq));
+	}
+
+	return 0;
+}
+
+static int cs43130_set_sysclk(struct snd_soc_dai *codec_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	cs43130->dais[codec_dai->id].sclk = freq;
+	dev_dbg(codec->dev, "dai_id = %d,  sclk = %u\n", codec_dai->id,
+		cs43130->dais[codec_dai->id].sclk);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs43130_pcm_ops = {
+	.startup	= cs43130_pcm_startup,
+	.hw_params	= cs43130_hw_params,
+	.hw_free	= cs43130_hw_free,
+	.set_sysclk	= cs43130_set_sysclk,
+	.set_fmt	= cs43130_pcm_set_fmt,
+	.digital_mute	= cs43130_pcm_mute,
+};
+
+static const struct snd_soc_dai_ops cs43130_dop_ops = {
+	.startup	= cs43130_dop_startup,
+	.hw_params	= cs43130_hw_params,
+	.hw_free	= cs43130_hw_free,
+	.set_sysclk	= cs43130_set_sysclk,
+	.set_fmt	= cs43130_pcm_set_fmt,
+	.digital_mute	= cs43130_dsd_mute,
+};
+
+static const struct snd_soc_dai_ops cs43130_dsd_ops = {
+	.startup        = cs43130_dop_startup,
+	.hw_params	= cs43130_dsd_hw_params,
+	.hw_free	= cs43130_hw_free,
+	.set_fmt	= cs43130_dsd_set_fmt,
+	.digital_mute	= cs43130_dsd_mute,
+};
+
+static struct snd_soc_dai_driver cs43130_dai[] = {
+	{
+		.name = "cs43130-asp-pcm",
+		.id = CS43130_ASP_PCM_DAI,
+		.playback = {
+			.stream_name = "ASP PCM Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS43130_PCM_FORMATS,
+		},
+		.ops = &cs43130_pcm_ops,
+		.symmetric_rates = 1,
+	},
+	{
+		.name = "cs43130-asp-dop",
+		.id = CS43130_ASP_DOP_DAI,
+		.playback = {
+			.stream_name = "ASP DoP Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS43130_DOP_FORMATS,
+		},
+		.ops = &cs43130_dop_ops,
+		.symmetric_rates = 1,
+	},
+	{
+		.name = "cs43130-xsp-dop",
+		.id = CS43130_XSP_DOP_DAI,
+		.playback = {
+			.stream_name = "XSP DoP Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS43130_DOP_FORMATS,
+		},
+		.ops = &cs43130_dop_ops,
+		.symmetric_rates = 1,
+	},
+	{
+		.name = "cs43130-xsp-dsd",
+		.id = CS43130_XSP_DSD_DAI,
+		.playback = {
+			.stream_name = "XSP DSD Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS43130_DOP_FORMATS,
+		},
+		.ops = &cs43130_dsd_ops,
+	},
+
+};
+
+static int cs43130_codec_set_sysclk(struct snd_soc_codec *codec,
+				    int clk_id, int source, unsigned int freq,
+				    int dir)
+{
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "clk_id = %d, source = %d, freq = %d, dir = %d\n",
+		clk_id, source, freq, dir);
+
+	switch (freq) {
+	case CS43130_MCLK_22M:
+	case CS43130_MCLK_24M:
+		cs43130->mclk = freq;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid MCLK INT freq: %u\n", freq);
+		return -EINVAL;
+	}
+
+	if (source == CS43130_MCLK_SRC_EXT) {
+		cs43130->pll_bypass = true;
+	} else {
+		dev_err(codec->dev, "Invalid MCLK source\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline u16 cs43130_get_ac_reg_val(u16 ac_freq)
+{
+	/*
+	 * Depending on mclk_int,
+	 * "HPLOAD_MEAS_FREQ_LSB/MSB" counts AC freq in
+	 * 5.86Hz (mclk_int = 24.576MHz)
+	 * or 5.94Hz (mclk_int = 22.5792MHz) steps.
+	 * Because integer step conversion is much easier,
+	 * I choose to use mclk_int = 22.5792MHz and approximate
+	 * 5.94Hz as 6Hz step.
+	 * The approximation worst case scenario occur at 20KHz,
+	 * with approximated freq = 19.798KHz.
+	 * Error freq = 202Hz
+	 */
+
+	return ac_freq / 6;
+}
+
+static char *hpload_msgs[] = {
+	"HPLOAD_DC_L:%u\n",
+	"HPLOAD_DC_R:%u\n",
+};
+
+static char *hpload_ac_msgs[] = {
+	"HPLOAD_AC_L:%u:%u\n",
+	"HPLOAD_AC_R:%u:%u\n",
+};
+
+static ssize_t cs43130_show_hpload(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	int i = 0, j, k, ret;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cs43130_private *cs43130 = i2c_get_clientdata(client);
+
+	if (!cs43130->hpload_done)
+		return scnprintf(buf, PAGE_SIZE, "NO_HPLOAD\n");
+
+	for (j = 0; j < ARRAY_SIZE(hpload_msgs); j++) {
+		ret = scnprintf(buf + i, PAGE_SIZE - i, hpload_msgs[j],
+				cs43130->hpload_dc[j]);
+		if (!ret)
+			return i;
+
+		i = i + ret;
+	}
+
+	if (cs43130->ac_meas) {
+		for (k = 0; k < CS43130_AC_FREQ; k++) {
+			for (j = 0; j < ARRAY_SIZE(hpload_ac_msgs); j++) {
+				ret = scnprintf(buf + i, PAGE_SIZE - i,
+						hpload_ac_msgs[j],
+						cs43130->ac_freq[k],
+						cs43130->hpload_ac[k][j]);
+				if (!ret)
+					return i;
+
+				i = i + ret;
+			}
+		}
+	}
+
+	return i;
+}
+
+static DEVICE_ATTR(hpload, S_IRUGO, cs43130_show_hpload, NULL);
+
+static struct reg_sequence hp_en_cal_seq[] = {
+	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
+	{CS43130_HP_MEAS_LOAD_1, 0},
+	{CS43130_HP_MEAS_LOAD_2, 0},
+	{CS43130_INT_MASK_4, 0},
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD16, 0xBB},
+	{CS43130_DXD12, 0x01},
+	{CS43130_DXD19, 0xCB},
+	{CS43130_DXD17, 0x95},
+	{CS43130_DXD18, 0x0B},
+	{CS43130_DXD1, 0},
+	{CS43130_HP_LOAD_1, 0x80},
+};
+
+static struct reg_sequence hp_en_cal_seq2[] = {
+	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
+	{CS43130_HP_MEAS_LOAD_1, 0},
+	{CS43130_HP_MEAS_LOAD_2, 0},
+	{CS43130_INT_MASK_4, 0},
+	{CS43130_HP_LOAD_1, 0x80},
+};
+
+static struct reg_sequence hp_dis_cal_seq[] = {
+	{CS43130_HP_LOAD_1, 0x80},
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD12, 0},
+	{CS43130_DXD1, 0},
+	{CS43130_HP_LOAD_1, 0},
+};
+
+static struct reg_sequence hp_dis_cal_seq2[] = {
+	{CS43130_HP_LOAD_1, 0x80},
+	{CS43130_HP_LOAD_1, 0},
+};
+
+static struct reg_sequence hp_dc_ch_l_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD19, 0x0A},
+	{CS43130_DXD17, 0x93},
+	{CS43130_DXD18, 0x0A},
+	{CS43130_DXD1, 0},
+	{CS43130_HP_LOAD_1, 0x80},
+	{CS43130_HP_LOAD_1, 0x81},
+};
+
+static struct reg_sequence hp_dc_ch_l_seq2[] = {
+	{CS43130_HP_LOAD_1, 0x80},
+	{CS43130_HP_LOAD_1, 0x81},
+};
+
+static struct reg_sequence hp_dc_ch_r_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD19, 0x8A},
+	{CS43130_DXD17, 0x15},
+	{CS43130_DXD18, 0x06},
+	{CS43130_DXD1, 0},
+	{CS43130_HP_LOAD_1, 0x90},
+	{CS43130_HP_LOAD_1, 0x91},
+};
+
+static struct reg_sequence hp_dc_ch_r_seq2[] = {
+	{CS43130_HP_LOAD_1, 0x90},
+	{CS43130_HP_LOAD_1, 0x91},
+};
+
+static struct reg_sequence hp_ac_ch_l_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD19, 0x0A},
+	{CS43130_DXD17, 0x93},
+	{CS43130_DXD18, 0x0A},
+	{CS43130_DXD1, 0},
+	{CS43130_HP_LOAD_1, 0x80},
+	{CS43130_HP_LOAD_1, 0x82},
+};
+
+static struct reg_sequence hp_ac_ch_l_seq2[] = {
+	{CS43130_HP_LOAD_1, 0x80},
+	{CS43130_HP_LOAD_1, 0x82},
+};
+
+static struct reg_sequence hp_ac_ch_r_seq[] = {
+	{CS43130_DXD1, 0x99},
+	{CS43130_DXD19, 0x8A},
+	{CS43130_DXD17, 0x15},
+	{CS43130_DXD18, 0x06},
+	{CS43130_DXD1, 0},
+	{CS43130_HP_LOAD_1, 0x90},
+	{CS43130_HP_LOAD_1, 0x92},
+};
+
+static struct reg_sequence hp_ac_ch_r_seq2[] = {
+	{CS43130_HP_LOAD_1, 0x90},
+	{CS43130_HP_LOAD_1, 0x92},
+};
+
+static struct reg_sequence hp_cln_seq[] = {
+	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
+	{CS43130_HP_MEAS_LOAD_1, 0},
+	{CS43130_HP_MEAS_LOAD_2, 0},
+};
+
+struct reg_sequences {
+	struct reg_sequence	*seq;
+	int			size;
+	unsigned int		msk;
+};
+
+static struct reg_sequences hpload_seq1[] = {
+	{
+		.seq	= hp_en_cal_seq,
+		.size	= ARRAY_SIZE(hp_en_cal_seq),
+		.msk	= CS43130_HPLOAD_ON_INT,
+	},
+	{
+		.seq	= hp_dc_ch_l_seq,
+		.size	= ARRAY_SIZE(hp_dc_ch_l_seq),
+		.msk	= CS43130_HPLOAD_DC_INT,
+	},
+	{
+		.seq	= hp_ac_ch_l_seq,
+		.size	= ARRAY_SIZE(hp_ac_ch_l_seq),
+		.msk	= CS43130_HPLOAD_AC_INT,
+	},
+	{
+		.seq	= hp_dis_cal_seq,
+		.size	= ARRAY_SIZE(hp_dis_cal_seq),
+		.msk	= CS43130_HPLOAD_OFF_INT,
+	},
+	{
+		.seq	= hp_en_cal_seq,
+		.size	= ARRAY_SIZE(hp_en_cal_seq),
+		.msk	= CS43130_HPLOAD_ON_INT,
+	},
+	{
+		.seq	= hp_dc_ch_r_seq,
+		.size	= ARRAY_SIZE(hp_dc_ch_r_seq),
+		.msk	= CS43130_HPLOAD_DC_INT,
+	},
+	{
+		.seq	= hp_ac_ch_r_seq,
+		.size	= ARRAY_SIZE(hp_ac_ch_r_seq),
+		.msk	= CS43130_HPLOAD_AC_INT,
+	},
+};
+
+static struct reg_sequences hpload_seq2[] = {
+	{
+		.seq	= hp_en_cal_seq2,
+		.size	= ARRAY_SIZE(hp_en_cal_seq2),
+		.msk	= CS43130_HPLOAD_ON_INT,
+	},
+	{
+		.seq	= hp_dc_ch_l_seq2,
+		.size	= ARRAY_SIZE(hp_dc_ch_l_seq2),
+		.msk	= CS43130_HPLOAD_DC_INT,
+	},
+	{
+		.seq	= hp_ac_ch_l_seq2,
+		.size	= ARRAY_SIZE(hp_ac_ch_l_seq2),
+		.msk	= CS43130_HPLOAD_AC_INT,
+	},
+	{
+		.seq	= hp_dis_cal_seq2,
+		.size	= ARRAY_SIZE(hp_dis_cal_seq2),
+		.msk	= CS43130_HPLOAD_OFF_INT,
+	},
+	{
+		.seq	= hp_en_cal_seq2,
+		.size	= ARRAY_SIZE(hp_en_cal_seq2),
+		.msk	= CS43130_HPLOAD_ON_INT,
+	},
+	{
+		.seq	= hp_dc_ch_r_seq2,
+		.size	= ARRAY_SIZE(hp_dc_ch_r_seq2),
+		.msk	= CS43130_HPLOAD_DC_INT,
+	},
+	{
+		.seq	= hp_ac_ch_r_seq2,
+		.size	= ARRAY_SIZE(hp_ac_ch_r_seq2),
+		.msk	= CS43130_HPLOAD_AC_INT,
+	},
+};
+
+static int cs43130_update_hpload(unsigned int msk, int ac_idx,
+				 struct cs43130_private *cs43130)
+{
+	bool left_ch = true;
+	unsigned int reg;
+	u32 addr;
+	u16 impedance;
+	struct snd_soc_codec *codec = cs43130->codec;
+
+	if (msk != CS43130_HPLOAD_DC_INT &&
+	    msk != CS43130_HPLOAD_AC_INT)
+		return 0;
+
+	regmap_read(cs43130->regmap, CS43130_HP_LOAD_1, &reg);
+	if (reg & CS43130_HPLOAD_CHN_SEL)
+		left_ch = false;
+
+	if (msk == CS43130_HPLOAD_DC_INT)
+		addr = CS43130_HP_DC_STAT_1;
+	else
+		addr = CS43130_HP_AC_STAT_1;
+
+	regmap_read(cs43130->regmap, addr, &reg);
+	impedance = reg >> 3;
+	regmap_read(cs43130->regmap, addr + 1, &reg);
+	impedance |= reg << 5;
+
+	if (msk == CS43130_HPLOAD_DC_INT) {
+		if (left_ch)
+			cs43130->hpload_dc[0] = impedance;
+		else
+			cs43130->hpload_dc[1] = impedance;
+
+		dev_dbg(codec->dev, "HP DC impedance (Ch %u): %u\n", !left_ch,
+			impedance);
+	} else {
+		if (left_ch)
+			cs43130->hpload_ac[ac_idx][0] = impedance;
+		else
+			cs43130->hpload_ac[ac_idx][1] = impedance;
+
+		dev_dbg(codec->dev, "HP AC (%u Hz) impedance (Ch %u): %u\n",
+			cs43130->ac_freq[ac_idx], !left_ch, impedance);
+	}
+
+	return 0;
+}
+
+static int cs43130_hpload_proc(struct cs43130_private *cs43130,
+			       struct reg_sequence *seq, int seq_size,
+			       unsigned int rslt_msk, int ac_idx)
+{
+	int ret;
+	unsigned int msk;
+	u16 ac_reg_val;
+	struct snd_soc_codec *codec = cs43130->codec;
+
+	reinit_completion(&cs43130->hpload_evt);
+
+	if (rslt_msk == CS43130_HPLOAD_AC_INT) {
+		ac_reg_val = cs43130_get_ac_reg_val(cs43130->ac_freq[ac_idx]);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_LOAD_1,
+				   CS43130_HPLOAD_AC_START, 0);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_MEAS_LOAD_1,
+				   CS43130_HP_MEAS_LOAD_MASK,
+				   ac_reg_val >> CS43130_HP_MEAS_LOAD_1_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_MEAS_LOAD_2,
+				   CS43130_HP_MEAS_LOAD_MASK,
+				   ac_reg_val >> CS43130_HP_MEAS_LOAD_2_SHIFT);
+	}
+
+	regmap_multi_reg_write(cs43130->regmap, seq,
+			       seq_size);
+
+	ret = wait_for_completion_timeout(&cs43130->hpload_evt,
+					  msecs_to_jiffies(1000));
+	regmap_read(cs43130->regmap, CS43130_INT_MASK_4, &msk);
+	if (!ret) {
+		dev_err(codec->dev, "Timeout waiting for HPLOAD interrupt\n");
+		return -1;
+	}
+
+	dev_dbg(codec->dev, "HP load stat: %x, INT_MASK_4: %x\n",
+		cs43130->hpload_stat, msk);
+	if ((cs43130->hpload_stat & (CS43130_HPLOAD_NO_DC_INT |
+				     CS43130_HPLOAD_UNPLUG_INT |
+				     CS43130_HPLOAD_OOR_INT)) ||
+	    !(cs43130->hpload_stat & rslt_msk)) {
+		dev_dbg(codec->dev, "HP load measure failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static const struct reg_sequence hv_seq[][2] = {
+	{
+		{CS43130_CLASS_H_CTL, 0x1C},
+		{CS43130_HP_OUT_CTL_1, 0x10},
+	},
+	{
+		{CS43130_CLASS_H_CTL, 0x1E},
+		{CS43130_HP_OUT_CTL_1, 0x20},
+	},
+	{
+		{CS43130_CLASS_H_CTL, 0x1E},
+		{CS43130_HP_OUT_CTL_1, 0x30},
+	},
+};
+
+static int cs43130_set_hv(struct regmap *regmap, u16 hpload_dc,
+			  const u16 *dc_threshold)
+{
+	int i;
+
+	for (i = 0; i < CS43130_DC_THRESHOLD; i++) {
+		if (hpload_dc <= dc_threshold[i])
+			break;
+	}
+
+	regmap_multi_reg_write(regmap, hv_seq[i], ARRAY_SIZE(hv_seq[i]));
+
+	return 0;
+}
+
+static void cs43130_imp_meas(struct work_struct *wk)
+{
+	unsigned int reg, seq_size;
+	int i, ret, ac_idx;
+	struct cs43130_private *cs43130;
+	struct snd_soc_codec *codec;
+	struct reg_sequences *hpload_seq;
+
+	cs43130 = container_of(wk, struct cs43130_private, work);
+	codec = cs43130->codec;
+
+	if (!cs43130->mclk)
+		return;
+
+	cs43130->hpload_done = false;
+
+	mutex_lock(&cs43130->clk_mutex);
+	if (!cs43130->clk_req) {
+		/* clk not in use */
+		cs43130_set_pll(codec, 0, 0, cs43130->mclk, CS43130_MCLK_22M);
+		if (cs43130->pll_bypass)
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_EXT);
+		else
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
+	}
+
+	cs43130->clk_req++;
+	mutex_unlock(&cs43130->clk_mutex);
+
+	regmap_read(cs43130->regmap, CS43130_INT_STATUS_4, &reg);
+
+	if (cs43130->dev_id == CS43130_CHIP_ID) {
+		hpload_seq = hpload_seq1;
+		seq_size = ARRAY_SIZE(hpload_seq1);
+	} else {
+		/* CS434131 */
+		hpload_seq = hpload_seq2;
+		seq_size = ARRAY_SIZE(hpload_seq2);
+	}
+
+	i = 0;
+	ac_idx = 0;
+	while (i < seq_size) {
+		ret = cs43130_hpload_proc(cs43130, hpload_seq[i].seq,
+					  hpload_seq[i].size,
+					  hpload_seq[i].msk, ac_idx);
+		if (ret < 0)
+			goto exit;
+
+		cs43130_update_hpload(hpload_seq[i].msk, ac_idx, cs43130);
+
+		if (cs43130->ac_meas &&
+		    hpload_seq[i].msk == CS43130_HPLOAD_AC_INT &&
+		    ac_idx < CS43130_AC_FREQ - 1) {
+			ac_idx++;
+		} else {
+			ac_idx = 0;
+			i++;
+		}
+	}
+	cs43130->hpload_done = true;
+
+	if (cs43130->hpload_dc[0] >= CS43130_LINEOUT_LOAD)
+		snd_soc_jack_report(&cs43130->jack, CS43130_JACK_LINEOUT,
+				    CS43130_JACK_MASK);
+	else
+		snd_soc_jack_report(&cs43130->jack, CS43130_JACK_HEADPHONE,
+				    CS43130_JACK_MASK);
+
+	dev_dbg(codec->dev, "Set HP output control. DC threshold\n");
+	for (i = 0; i < CS43130_DC_THRESHOLD; i++)
+		dev_dbg(codec->dev, "DC threshold[%d]: %u.\n", i,
+			cs43130->dc_threshold[i]);
+
+	cs43130_set_hv(cs43130->regmap, cs43130->hpload_dc[0],
+		       cs43130->dc_threshold);
+
+exit:
+	if (cs43130->dev_id == CS43130_CHIP_ID)
+		cs43130_hpload_proc(cs43130, hp_dis_cal_seq,
+				    ARRAY_SIZE(hp_dis_cal_seq),
+				    CS43130_HPLOAD_OFF_INT, ac_idx);
+	else
+		/* CS434131 */
+		cs43130_hpload_proc(cs43130, hp_dis_cal_seq2,
+				    ARRAY_SIZE(hp_dis_cal_seq2),
+				    CS43130_HPLOAD_OFF_INT, ac_idx);
+
+	regmap_multi_reg_write(cs43130->regmap, hp_cln_seq,
+			       ARRAY_SIZE(hp_cln_seq));
+
+	mutex_lock(&cs43130->clk_mutex);
+	cs43130->clk_req--;
+	/* clk not in use */
+	if (!cs43130->clk_req)
+		cs43130_change_clksrc(codec, CS43130_MCLK_SRC_RCO);
+	mutex_unlock(&cs43130->clk_mutex);
+}
+
+static irqreturn_t cs43130_irq_thread(int irq, void *data)
+{
+	struct cs43130_private *cs43130 = (struct cs43130_private *)data;
+	struct snd_soc_codec *codec = cs43130->codec;
+	unsigned int stickies[CS43130_NUM_INT];
+	unsigned int irq_occurrance = 0;
+	unsigned int masks[CS43130_NUM_INT];
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
+		regmap_read(cs43130->regmap, CS43130_INT_STATUS_1 + i,
+			    &stickies[i]);
+		regmap_read(cs43130->regmap, CS43130_INT_MASK_1 + i,
+			    &masks[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
+		stickies[i] = stickies[i] & (~masks[i]);
+		for (j = 0; j < 8; j++)
+			irq_occurrance += (stickies[i] >> j) & 1;
+	}
+	dev_dbg(codec->dev, "number of interrupts occurred (%u)\n",
+		irq_occurrance);
+
+	if (!irq_occurrance)
+		return IRQ_NONE;
+
+	if (stickies[0] & CS43130_XTAL_RDY_INT) {
+		complete(&cs43130->xtal_rdy);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[0] & CS43130_PLL_RDY_INT) {
+		complete(&cs43130->pll_rdy);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_NO_DC_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_err(codec->dev,
+			"DC load has not completed before AC load (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_UNPLUG_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_err(codec->dev, "HP unplugged during measurement (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_OOR_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_err(codec->dev, "HP load out of range (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_AC_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_dbg(codec->dev, "HP AC load measurement done (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_DC_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_dbg(codec->dev, "HP DC load measurement done (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_ON_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_dbg(codec->dev, "HP load state machine on done (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[3] & CS43130_HPLOAD_OFF_INT) {
+		cs43130->hpload_stat = stickies[3];
+		dev_dbg(codec->dev, "HP load state machine off done (%x)\n",
+			cs43130->hpload_stat);
+		complete(&cs43130->hpload_evt);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[0] & CS43130_XTAL_ERR_INT) {
+		dev_err(codec->dev, "Crystal err: clock is not running\n");
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[0] & CS43130_HP_UNPLUG_INT) {
+		dev_dbg(codec->dev, "HP unplugged\n");
+		cs43130->hpload_done = false;
+		snd_soc_jack_report(&cs43130->jack, 0, CS43130_JACK_MASK);
+		return IRQ_HANDLED;
+	}
+
+	if (stickies[0] & CS43130_HP_PLUG_INT) {
+		if (cs43130->dc_meas && !cs43130->hpload_done &&
+		    !work_busy(&cs43130->work)) {
+			dev_dbg(codec->dev, "HP load queue work\n");
+			queue_work(cs43130->wq, &cs43130->work);
+		}
+
+		snd_soc_jack_report(&cs43130->jack, SND_JACK_MECHANICAL,
+				    CS43130_JACK_MASK);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int cs43130_probe(struct snd_soc_codec *codec)
+{
+	int ret;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_card *card = codec->component.card;
+	unsigned int reg;
+
+	cs43130->codec = codec;
+
+	if (cs43130->xtal_ibias != CS43130_XTAL_UNUSED) {
+		regmap_update_bits(cs43130->regmap, CS43130_CRYSTAL_SET,
+				   CS43130_XTAL_IBIAS_MASK,
+				   cs43130->xtal_ibias);
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_XTAL_ERR_INT, 0);
+	}
+
+	if (!cs43130->idle_bias_off) {
+		ret = snd_soc_card_jack_new(card, "Headphone",
+					    CS43130_JACK_MASK,
+					    &cs43130->jack, NULL, 0);
+		if (ret < 0) {
+			dev_err(codec->dev, "Cannot create jack\n");
+			return ret;
+		}
+
+		cs43130->hpload_done = false;
+		if (cs43130->dc_meas) {
+			ret = device_create_file(codec->dev, &dev_attr_hpload);
+			if (ret < 0) {
+				dev_err(codec->dev,
+					"Cannot create HP load file\n");
+				return ret;
+			}
+
+			cs43130->wq =
+				create_singlethread_workqueue("cs43130_hp");
+			INIT_WORK(&cs43130->work, cs43130_imp_meas);
+		}
+
+		regmap_read(cs43130->regmap, CS43130_INT_STATUS_1, &reg);
+		regmap_read(cs43130->regmap, CS43130_HP_STATUS, &reg);
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_HP_PLUG_INT |
+				   CS43130_HP_UNPLUG_INT, 0);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
+				   CS43130_HP_DETECT_CTRL_MASK, 0);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
+				   CS43130_HP_DETECT_CTRL_MASK,
+				   CS43130_HP_DETECT_CTRL_MASK);
+	}
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_cs43130 = {
+	.probe			= cs43130_probe,
+	.component_driver = {
+		.controls		= cs43130_snd_controls,
+		.num_controls		= ARRAY_SIZE(cs43130_snd_controls),
+	},
+	.set_sysclk		= cs43130_codec_set_sysclk,
+	.set_pll		= cs43130_set_pll,
+};
+
+static const struct regmap_config cs43130_regmap = {
+	.reg_bits		= 24,
+	.pad_bits		= 8,
+	.val_bits		= 8,
+
+	.max_register		= CS43130_LASTREG,
+	.reg_defaults		= cs43130_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(cs43130_reg_defaults),
+	.readable_reg		= cs43130_readable_register,
+	.precious_reg		= cs43130_precious_register,
+	.volatile_reg		= cs43130_volatile_register,
+	.cache_type		= REGCACHE_RBTREE,
+	.use_single_rw		= true, /* needed for regcache_sync */
+};
+
+static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+	24,
+	43,
+	93,
+	200,
+	431,
+	928,
+	2000,
+	4309,
+	9283,
+	20000,
+};
+
+static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+	50,
+	120,
+};
+
+static int cs43130_handle_device_data(struct i2c_client *i2c_client,
+				      struct cs43130_private *cs43130)
+{
+	struct device_node *np = i2c_client->dev.of_node;
+	unsigned int val;
+	int i;
+
+	if (of_property_read_u32(np, "cirrus,xtal-ibias", &val) < 0) {
+		/* Crystal is unused. System clock is used for external MCLK */
+		cs43130->xtal_ibias = CS43130_XTAL_UNUSED;
+		return 0;
+	}
+
+	switch (val) {
+	case 1:
+		cs43130->xtal_ibias = CS43130_XTAL_IBIAS_7_5UA;
+		break;
+	case 2:
+		cs43130->xtal_ibias = CS43130_XTAL_IBIAS_12_5UA;
+		break;
+	case 3:
+		cs43130->xtal_ibias = CS43130_XTAL_IBIAS_15UA;
+		break;
+	default:
+		dev_err(&i2c_client->dev,
+			"Invalid cirrus,xtal-ibias value: %d\n", val);
+		return -EINVAL;
+	}
+
+	cs43130->dc_meas = of_property_read_bool(np, "cirrus,dc-measure");
+	cs43130->ac_meas = of_property_read_bool(np, "cirrus,ac-measure");
+
+	if (of_property_read_u16_array(np, "cirrus,ac-freq", cs43130->ac_freq,
+					CS43130_AC_FREQ) < 0) {
+		for (i = 0; i < CS43130_AC_FREQ; i++)
+			cs43130->ac_freq[i] = cs43130_ac_freq[i];
+	}
+
+	if (of_property_read_u16_array(np, "cirrus,dc-threshold",
+				       cs43130->dc_threshold,
+				       CS43130_DC_THRESHOLD) < 0) {
+		for (i = 0; i < CS43130_DC_THRESHOLD; i++)
+			cs43130->dc_threshold[i] = cs43130_dc_threshold[i];
+	}
+
+	cs43130->idle_bias_off = of_property_read_bool(np,
+						       "cirrus,idle-bias-off");
+
+	return 0;
+}
+
+static int cs43130_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct cs43130_private *cs43130;
+	int ret;
+	unsigned int devid = 0;
+	unsigned int reg;
+	int i;
+
+	cs43130 = devm_kzalloc(&client->dev, sizeof(*cs43130), GFP_KERNEL);
+	if (!cs43130)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, cs43130);
+
+	cs43130->regmap = devm_regmap_init_i2c(client, &cs43130_regmap);
+	if (IS_ERR(cs43130->regmap)) {
+		ret = PTR_ERR(cs43130->regmap);
+		return ret;
+	}
+
+	if (client->dev.of_node) {
+		ret = cs43130_handle_device_data(client, cs43130);
+		if (ret != 0)
+			return ret;
+	}
+	for (i = 0; i < ARRAY_SIZE(cs43130->supplies); i++)
+		cs43130->supplies[i].supply = cs43130_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(cs43130->supplies),
+				      cs43130->supplies);
+	if (ret != 0) {
+		dev_err(&client->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs43130->supplies),
+				    cs43130->supplies);
+	if (ret != 0) {
+		dev_err(&client->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	cs43130->reset_gpio = devm_gpiod_get_optional(&client->dev,
+						      "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs43130->reset_gpio))
+		return PTR_ERR(cs43130->reset_gpio);
+
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 1);
+
+	usleep_range(2000, 2050);
+
+	ret = regmap_read(cs43130->regmap, CS43130_DEVID_AB, &reg);
+
+	devid = (reg & 0xFF) << 12;
+	ret = regmap_read(cs43130->regmap, CS43130_DEVID_CD, &reg);
+	devid |= (reg & 0xFF) << 4;
+	ret = regmap_read(cs43130->regmap, CS43130_DEVID_E, &reg);
+	devid |= (reg & 0xF0) >> 4;
+
+	switch (devid) {
+	case CS43130_CHIP_ID:
+	case CS4399_CHIP_ID:
+	case CS43131_CHIP_ID:
+	case CS43198_CHIP_ID:
+		break;
+	default:
+		dev_err(&client->dev,
+			"CS43130 Device ID %X. Expected ID %X, %X, %X or %X\n",
+			devid, CS43130_CHIP_ID, CS4399_CHIP_ID,
+			CS43131_CHIP_ID, CS43198_CHIP_ID);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	cs43130->dev_id = devid;
+	ret = regmap_read(cs43130->regmap, CS43130_REV_ID, &reg);
+	if (ret < 0) {
+		dev_err(&client->dev, "Get Revision ID failed\n");
+		goto err;
+	}
+
+	dev_info(&client->dev,
+		 "Cirrus Logic CS43130 (%x), Revision: %02X\n", devid,
+		 reg & 0xFF);
+
+	mutex_init(&cs43130->clk_mutex);
+
+	init_completion(&cs43130->xtal_rdy);
+	init_completion(&cs43130->pll_rdy);
+	init_completion(&cs43130->hpload_evt);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, cs43130_irq_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					"cs43130", cs43130);
+	if (ret != 0) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
+		return ret;
+	}
+
+	cs43130->mclk_int_src = CS43130_MCLK_SRC_RCO;
+
+	soc_codec_dev_cs43130.idle_bias_off = cs43130->idle_bias_off;
+
+	if (cs43130->idle_bias_off) {
+		pm_runtime_set_autosuspend_delay(&client->dev, 100);
+		pm_runtime_use_autosuspend(&client->dev);
+		pm_runtime_set_active(&client->dev);
+		pm_runtime_enable(&client->dev);
+	}
+
+	if (cs43130->dev_id == CS43130_CHIP_ID ||
+	    cs43130->dev_id == CS43131_CHIP_ID) {
+		memcpy(all_hp_widgets, digital_hp_widgets,
+		       sizeof(digital_hp_widgets));
+		memcpy(all_hp_widgets + ARRAY_SIZE(digital_hp_widgets),
+		       analog_hp_widgets, sizeof(analog_hp_widgets));
+		memcpy(all_hp_routes, digital_hp_routes,
+		       sizeof(digital_hp_routes));
+		memcpy(all_hp_routes + ARRAY_SIZE(digital_hp_routes),
+		       analog_hp_routes, sizeof(analog_hp_routes));
+
+		soc_codec_dev_cs43130.component_driver.dapm_widgets =
+			all_hp_widgets;
+		soc_codec_dev_cs43130.component_driver.num_dapm_widgets =
+			ARRAY_SIZE(all_hp_widgets);
+		soc_codec_dev_cs43130.component_driver.dapm_routes =
+			all_hp_routes;
+		soc_codec_dev_cs43130.component_driver.num_dapm_routes =
+			ARRAY_SIZE(all_hp_routes);
+	} else {
+		/* CS43198 or CS4399 */
+		soc_codec_dev_cs43130.component_driver.dapm_widgets =
+			digital_hp_widgets;
+		soc_codec_dev_cs43130.component_driver.num_dapm_widgets =
+			ARRAY_SIZE(digital_hp_widgets);
+		soc_codec_dev_cs43130.component_driver.dapm_routes =
+			digital_hp_routes;
+		soc_codec_dev_cs43130.component_driver.num_dapm_routes =
+			ARRAY_SIZE(digital_hp_routes);
+	}
+	ret = snd_soc_register_codec(&client->dev, &soc_codec_dev_cs43130,
+				     cs43130_dai, ARRAY_SIZE(cs43130_dai));
+
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"snd_soc_register_codec failed with ret = %d\n", ret);
+		goto err;
+	}
+
+	regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
+			   CS43130_ASP_3ST_MASK, 0);
+	regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
+			   CS43130_XSP_3ST_MASK, 0);
+
+	return 0;
+err:
+	return ret;
+}
+
+static int cs43130_i2c_remove(struct i2c_client *client)
+{
+	struct cs43130_private *cs43130 = i2c_get_clientdata(client);
+
+	if (cs43130->xtal_ibias != CS43130_XTAL_UNUSED)
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_XTAL_ERR_INT,
+				   1 << CS43130_XTAL_ERR_INT_SHIFT);
+
+	regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+			   CS43130_HP_PLUG_INT | CS43130_HP_UNPLUG_INT,
+			   CS43130_HP_PLUG_INT | CS43130_HP_UNPLUG_INT);
+
+	if (cs43130->dc_meas && !cs43130->idle_bias_off) {
+		cancel_work_sync(&cs43130->work);
+		flush_workqueue(cs43130->wq);
+
+		device_remove_file(&client->dev, &dev_attr_hpload);
+	}
+
+	if (cs43130->reset_gpio)
+		gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
+
+	pm_runtime_disable(&client->dev);
+	regulator_bulk_disable(CS43130_NUM_SUPPLIES, cs43130->supplies);
+
+	snd_soc_unregister_codec(&client->dev);
+
+	return 0;
+}
+
+static int cs43130_runtime_suspend(struct device *dev)
+{
+	struct cs43130_private *cs43130 = dev_get_drvdata(dev);
+
+	if (cs43130->xtal_ibias != CS43130_XTAL_UNUSED)
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_XTAL_ERR_INT,
+				   1 << CS43130_XTAL_ERR_INT_SHIFT);
+
+	regcache_cache_only(cs43130->regmap, true);
+	regcache_mark_dirty(cs43130->regmap);
+
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
+
+	regulator_bulk_disable(CS43130_NUM_SUPPLIES, cs43130->supplies);
+
+	return 0;
+}
+
+static int cs43130_runtime_resume(struct device *dev)
+{
+	struct cs43130_private *cs43130 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(CS43130_NUM_SUPPLIES, cs43130->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(cs43130->regmap, false);
+
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 1);
+
+	usleep_range(2000, 2050);
+
+	ret = regcache_sync(cs43130->regmap);
+	if (ret != 0) {
+		dev_err(dev, "Failed to restore register cache\n");
+		goto err;
+	}
+
+	if (cs43130->xtal_ibias != CS43130_XTAL_UNUSED)
+		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+				   CS43130_XTAL_ERR_INT, 0);
+
+	return 0;
+err:
+	regcache_cache_only(cs43130->regmap, true);
+	regulator_bulk_disable(CS43130_NUM_SUPPLIES, cs43130->supplies);
+
+	return ret;
+}
+
+static const struct dev_pm_ops cs43130_runtime_pm = {
+	SET_RUNTIME_PM_OPS(cs43130_runtime_suspend, cs43130_runtime_resume,
+			   NULL)
+};
+
+static const struct of_device_id cs43130_of_match[] = {
+	{.compatible = "cirrus,cs43130",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, cs43130_of_match);
+
+static const struct i2c_device_id cs43130_i2c_id[] = {
+	{"cs43130", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cs43130_i2c_id);
+
+static struct i2c_driver cs43130_i2c_driver = {
+	.driver = {
+		.name		= "cs43130",
+		.of_match_table	= cs43130_of_match,
+		.pm             = &cs43130_runtime_pm,
+	},
+	.id_table	= cs43130_i2c_id,
+	.probe		= cs43130_i2c_probe,
+	.remove		= cs43130_i2c_remove,
+};
+
+module_i2c_driver(cs43130_i2c_driver);
+
+MODULE_AUTHOR("Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("Cirrus Logic CS43130 ALSA SoC Codec Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
new file mode 100644
index 0000000..5e7a852
--- /dev/null
+++ b/sound/soc/codecs/cs43130.h
@@ -0,0 +1,545 @@
+/*
+ * ALSA SoC CS43130 codec driver
+ *
+ * Copyright 2016 Cirrus Logic, Inc.
+ *
+ * Author: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#ifndef __CS43130_H__
+#define __CS43130_H__
+
+/* CS43130 registers addresses */
+/* all reg address is shifted by a byte for control byte to be LSB */
+#define CS43130_FIRSTREG	0x010000
+#define CS43130_LASTREG		0x190000
+#define CS43130_CHIP_ID		0x00043130
+#define CS4399_CHIP_ID		0x00043990
+#define CS43131_CHIP_ID		0x00043131
+#define CS43198_CHIP_ID		0x00043198
+#define CS43130_DEVID_AB	0x010000	/* Device ID A & B [RO] */
+#define CS43130_DEVID_CD	0x010001	/* Device ID C & D [RO] */
+#define CS43130_DEVID_E		0x010002	/* Device ID E [RO] */
+#define CS43130_FAB_ID		0x010003        /* Fab ID [RO] */
+#define CS43130_REV_ID		0x010004        /* Revision ID [RO] */
+#define CS43130_SUBREV_ID	0x010005        /* Subrevision ID */
+#define CS43130_SYS_CLK_CTL_1	0x010006	/* System Clocking Ctl 1 */
+#define CS43130_SP_SRATE	0x01000B        /* Serial Port Sample Rate */
+#define CS43130_SP_BITSIZE	0x01000C        /* Serial Port Bit Size */
+#define CS43130_PAD_INT_CFG	0x01000D	/* Pad Interface Config */
+#define CS43130_DXD1            0x010010        /* DXD1 */
+#define CS43130_DXD7            0x010025        /* DXD7 */
+#define CS43130_DXD19           0x010026        /* DXD19 */
+#define CS43130_DXD17           0x010027        /* DXD17 */
+#define CS43130_DXD18           0x010028        /* DXD18 */
+#define CS43130_DXD12           0x01002C        /* DXD12 */
+#define CS43130_DXD8            0x01002E        /* DXD8 */
+#define CS43130_PWDN_CTL	0x020000        /* Power Down Ctl */
+#define CS43130_DXD2            0x020019        /* DXD2 */
+#define CS43130_CRYSTAL_SET	0x020052	/* Crystal Setting */
+#define CS43130_PLL_SET_1	0x030001        /* PLL Setting 1 */
+#define CS43130_PLL_SET_2	0x030002        /* PLL Setting 2 */
+#define CS43130_PLL_SET_3	0x030003        /* PLL Setting 3 */
+#define CS43130_PLL_SET_4	0x030004        /* PLL Setting 4 */
+#define CS43130_PLL_SET_5	0x030005        /* PLL Setting 5 */
+#define CS43130_PLL_SET_6	0x030008        /* PLL Setting 6 */
+#define CS43130_PLL_SET_7	0x03000A        /* PLL Setting 7 */
+#define CS43130_PLL_SET_8	0x03001B        /* PLL Setting 8 */
+#define CS43130_PLL_SET_9	0x040002        /* PLL Setting 9 */
+#define CS43130_PLL_SET_10	0x040003        /* PLL Setting 10 */
+#define CS43130_CLKOUT_CTL	0x040004        /* CLKOUT Ctl */
+#define CS43130_ASP_NUM_1	0x040010        /* ASP Numerator 1 */
+#define CS43130_ASP_NUM_2	0x040011        /* ASP Numerator 2 */
+#define CS43130_ASP_DEN_1	0x040012	/* ASP Denominator 1 */
+#define CS43130_ASP_DEN_2	0x040013	/* ASP Denominator 2 */
+#define CS43130_ASP_LRCK_HI_TIME_1 0x040014	/* ASP LRCK High Time 1 */
+#define CS43130_ASP_LRCK_HI_TIME_2 0x040015	/* ASP LRCK High Time 2 */
+#define CS43130_ASP_LRCK_PERIOD_1  0x040016	/* ASP LRCK Period 1 */
+#define CS43130_ASP_LRCK_PERIOD_2  0x040017	/* ASP LRCK Period 2 */
+#define CS43130_ASP_CLOCK_CONF	0x040018	/* ASP Clock Config */
+#define CS43130_ASP_FRAME_CONF	0x040019	/* ASP Frame Config */
+#define CS43130_XSP_NUM_1	0x040020        /* XSP Numerator 1 */
+#define CS43130_XSP_NUM_2	0x040021        /* XSP Numerator 2 */
+#define CS43130_XSP_DEN_1	0x040022	/* XSP Denominator 1 */
+#define CS43130_XSP_DEN_2	0x040023	/* XSP Denominator 2 */
+#define CS43130_XSP_LRCK_HI_TIME_1 0x040024	/* XSP LRCK High Time 1 */
+#define CS43130_XSP_LRCK_HI_TIME_2 0x040025	/* XSP LRCK High Time 2 */
+#define CS43130_XSP_LRCK_PERIOD_1  0x040026	/* XSP LRCK Period 1 */
+#define CS43130_XSP_LRCK_PERIOD_2  0x040027	/* XSP LRCK Period 2 */
+#define CS43130_XSP_CLOCK_CONF	0x040028	/* XSP Clock Config */
+#define CS43130_XSP_FRAME_CONF	0x040029	/* XSP Frame Config */
+#define CS43130_ASP_CH_1_LOC	0x050000	/* ASP Chan 1 Location */
+#define CS43130_ASP_CH_2_LOC	0x050001	/* ASP Chan 2 Location */
+#define CS43130_ASP_CH_1_SZ_EN	0x05000A	/* ASP Chan 1 Size, Enable */
+#define CS43130_ASP_CH_2_SZ_EN	0x05000B	/* ASP Chan 2 Size, Enable */
+#define CS43130_XSP_CH_1_LOC	0x060000	/* XSP Chan 1 Location */
+#define CS43130_XSP_CH_2_LOC	0x060001	/* XSP Chan 2 Location */
+#define CS43130_XSP_CH_1_SZ_EN	0x06000A	/* XSP Chan 1 Size, Enable */
+#define CS43130_XSP_CH_2_SZ_EN	0x06000B	/* XSP Chan 2 Size, Enable */
+#define CS43130_DSD_VOL_B	0x070000        /* DSD Volume B */
+#define CS43130_DSD_VOL_A	0x070001        /* DSD Volume A */
+#define CS43130_DSD_PATH_CTL_1	0x070002	/* DSD Proc Path Sig Ctl 1 */
+#define CS43130_DSD_INT_CFG	0x070003	/* DSD Interface Config */
+#define CS43130_DSD_PATH_CTL_2	0x070004	/* DSD Proc Path Sig Ctl 2 */
+#define CS43130_DSD_PCM_MIX_CTL	0x070005	/* DSD and PCM Mixing Ctl */
+#define CS43130_DSD_PATH_CTL_3	0x070006	/* DSD Proc Path Sig Ctl 3 */
+#define CS43130_HP_OUT_CTL_1	0x080000	/* HP Output Ctl 1 */
+#define CS43130_DXD16		0x080024	/* DXD16 */
+#define CS43130_DXD13		0x080032	/* DXD13 */
+#define CS43130_PCM_FILT_OPT	0x090000	/* PCM Filter Option */
+#define CS43130_PCM_VOL_B	0x090001        /* PCM Volume B */
+#define CS43130_PCM_VOL_A	0x090002        /* PCM Volume A */
+#define CS43130_PCM_PATH_CTL_1	0x090003	/* PCM Path Signal Ctl 1 */
+#define CS43130_PCM_PATH_CTL_2	0x090004	/* PCM Path Signal Ctl 2 */
+#define CS43130_DXD6		0x090097	/* DXD6 */
+#define CS43130_CLASS_H_CTL	0x0B0000	/* Class H Ctl */
+#define CS43130_DXD15		0x0B0005	/* DXD15 */
+#define CS43130_DXD14		0x0B0006	/* DXD14 */
+#define CS43130_DXD3		0x0C0002	/* DXD3 */
+#define CS43130_DXD10		0x0C0003	/* DXD10 */
+#define CS43130_DXD11		0x0C0005	/* DXD11 */
+#define CS43130_DXD9		0x0C0006	/* DXD9 */
+#define CS43130_DXD4		0x0C0009	/* DXD4 */
+#define CS43130_DXD5		0x0C000E	/* DXD5 */
+#define CS43130_HP_DETECT	0x0D0000        /* HP Detect */
+#define CS43130_HP_STATUS	0x0D0001        /* HP Status [RO] */
+#define CS43130_HP_LOAD_1	0x0E0000        /* HP Load 1 */
+#define CS43130_HP_MEAS_LOAD_1	0x0E0003	/* HP Load Measurement 1 */
+#define CS43130_HP_MEAS_LOAD_2	0x0E0004	/* HP Load Measurement 2 */
+#define CS43130_HP_DC_STAT_1	0x0E000D	/* HP DC Load Status 0 [RO] */
+#define CS43130_HP_DC_STAT_2	0x0E000E	/* HP DC Load Status 1 [RO] */
+#define CS43130_HP_AC_STAT_1	0x0E0010	/* HP AC Load Status 0 [RO] */
+#define CS43130_HP_AC_STAT_2	0x0E0011	/* HP AC Load Status 1 [RO] */
+#define CS43130_HP_LOAD_STAT	0x0E001A	/* HP Load Status [RO] */
+#define CS43130_INT_STATUS_1	0x0F0000	/* Interrupt Status 1 */
+#define CS43130_INT_STATUS_2	0x0F0001	/* Interrupt Status 2 */
+#define CS43130_INT_STATUS_3	0x0F0002	/* Interrupt Status 3 */
+#define CS43130_INT_STATUS_4	0x0F0003	/* Interrupt Status 4 */
+#define CS43130_INT_STATUS_5	0x0F0004	/* Interrupt Status 5 */
+#define CS43130_INT_MASK_1	0x0F0010        /* Interrupt Mask 1 */
+#define CS43130_INT_MASK_2	0x0F0011	/* Interrupt Mask 2 */
+#define CS43130_INT_MASK_3	0x0F0012        /* Interrupt Mask 3 */
+#define CS43130_INT_MASK_4	0x0F0013        /* Interrupt Mask 4 */
+#define CS43130_INT_MASK_5	0x0F0014        /* Interrupt Mask 5 */
+
+#define CS43130_MCLK_SRC_SEL_MASK	0x03
+#define CS43130_MCLK_SRC_SEL_SHIFT	0
+#define CS43130_MCLK_INT_MASK		0x04
+#define CS43130_MCLK_INT_SHIFT		2
+#define CS43130_CH_BITSIZE_MASK		0x03
+#define CS43130_CH_EN_MASK		0x04
+#define CS43130_CH_EN_SHIFT		2
+#define CS43130_ASP_BITSIZE_MASK	0x03
+#define CS43130_XSP_BITSIZE_MASK	0x0C
+#define CS43130_XSP_BITSIZE_SHIFT	2
+#define CS43130_SP_BITSIZE_ASP_SHIFT	0
+#define CS43130_HP_DETECT_CTRL_SHIFT	6
+#define CS43130_HP_DETECT_CTRL_MASK     (0x03 << CS43130_HP_DETECT_CTRL_SHIFT)
+#define CS43130_HP_DETECT_INV_SHIFT	5
+#define CS43130_HP_DETECT_INV_MASK      (1 << CS43130_HP_DETECT_INV_SHIFT)
+
+/* CS43130_INT_MASK_1 */
+#define CS43130_HP_PLUG_INT_SHIFT       6
+#define CS43130_HP_PLUG_INT             (1 << CS43130_HP_PLUG_INT_SHIFT)
+#define CS43130_HP_UNPLUG_INT_SHIFT     5
+#define CS43130_HP_UNPLUG_INT           (1 << CS43130_HP_UNPLUG_INT_SHIFT)
+#define CS43130_XTAL_RDY_INT_SHIFT      4
+#define CS43130_XTAL_RDY_INT_MASK	0x10
+#define CS43130_XTAL_RDY_INT            (1 << CS43130_XTAL_RDY_INT_SHIFT)
+#define CS43130_XTAL_ERR_INT_SHIFT      3
+#define CS43130_XTAL_ERR_INT            (1 << CS43130_XTAL_ERR_INT_SHIFT)
+#define CS43130_PLL_RDY_INT_MASK	0x04
+#define CS43130_PLL_RDY_INT_SHIFT	2
+#define CS43130_PLL_RDY_INT		(1 << CS43130_PLL_RDY_INT_SHIFT)
+
+/* CS43130_INT_MASK_4 */
+#define CS43130_INT_MASK_ALL		0xFF
+#define CS43130_HPLOAD_NO_DC_INT_SHIFT	7
+#define CS43130_HPLOAD_NO_DC_INT	(1 << CS43130_HPLOAD_NO_DC_INT_SHIFT)
+#define CS43130_HPLOAD_UNPLUG_INT_SHIFT	6
+#define CS43130_HPLOAD_UNPLUG_INT	(1 << CS43130_HPLOAD_UNPLUG_INT_SHIFT)
+#define CS43130_HPLOAD_OOR_INT_SHIFT	4
+#define CS43130_HPLOAD_OOR_INT		(1 << CS43130_HPLOAD_OOR_INT_SHIFT)
+#define CS43130_HPLOAD_AC_INT_SHIFT	3
+#define CS43130_HPLOAD_AC_INT		(1 << CS43130_HPLOAD_AC_INT_SHIFT)
+#define CS43130_HPLOAD_DC_INT_SHIFT	2
+#define CS43130_HPLOAD_DC_INT		(1 << CS43130_HPLOAD_DC_INT_SHIFT)
+#define CS43130_HPLOAD_OFF_INT_SHIFT	1
+#define CS43130_HPLOAD_OFF_INT		(1 << CS43130_HPLOAD_OFF_INT_SHIFT)
+#define CS43130_HPLOAD_ON_INT		1
+
+/* CS43130_HP_LOAD_1 */
+#define CS43130_HPLOAD_EN_SHIFT		7
+#define CS43130_HPLOAD_EN		(1 << CS43130_HPLOAD_EN_SHIFT)
+#define CS43130_HPLOAD_CHN_SEL_SHIFT	4
+#define CS43130_HPLOAD_CHN_SEL		(1 << CS43130_HPLOAD_CHN_SEL_SHIFT)
+#define CS43130_HPLOAD_AC_START_SHIFT	1
+#define CS43130_HPLOAD_AC_START		(1 << CS43130_HPLOAD_AC_START_SHIFT)
+#define CS43130_HPLOAD_DC_START		1
+
+/* Reg CS43130_SP_BITSIZE */
+#define CS43130_SP_BIT_SIZE_8	0x03
+#define CS43130_SP_BIT_SIZE_16	0x02
+#define CS43130_SP_BIT_SIZE_24	0x01
+#define CS43130_SP_BIT_SIZE_32	0x00
+
+/* Reg CS43130_SP_CH_SZ_EN */
+#define CS43130_CH_BIT_SIZE_8	0x00
+#define CS43130_CH_BIT_SIZE_16	0x01
+#define CS43130_CH_BIT_SIZE_24	0x02
+#define CS43130_CH_BIT_SIZE_32	0x03
+
+/* PLL */
+#define CS43130_PLL_START_MASK	0x01
+#define CS43130_PLL_MODE_MASK	0x02
+#define CS43130_PLL_MODE_SHIFT	1
+
+#define CS43130_PLL_REF_PREDIV_MASK	0x3
+
+#define CS43130_SP_STP_MASK	0x10
+#define CS43130_SP_STP_SHIFT	4
+#define CS43130_SP_5050_MASK	0x08
+#define CS43130_SP_5050_SHIFT	3
+#define CS43130_SP_FSD_MASK	0x07
+
+#define CS43130_SP_MODE_MASK	0x10
+#define CS43130_SP_MODE_SHIFT	4
+#define CS43130_SP_SCPOL_OUT_MASK	0x08
+#define CS43130_SP_SCPOL_OUT_SHIFT	3
+#define CS43130_SP_SCPOL_IN_MASK	0x04
+#define CS43130_SP_SCPOL_IN_SHIFT	2
+#define CS43130_SP_LCPOL_OUT_MASK	0x02
+#define CS43130_SP_LCPOL_OUT_SHIFT	1
+#define CS43130_SP_LCPOL_IN_MASK	0x01
+#define CS43130_SP_LCPOL_IN_SHIFT	0
+
+/* Reg CS43130_PWDN_CTL */
+#define CS43130_PDN_XSP_MASK	0x80
+#define CS43130_PDN_XSP_SHIFT	7
+#define CS43130_PDN_ASP_MASK	0x40
+#define CS43130_PDN_ASP_SHIFT	6
+#define CS43130_PDN_DSPIF_MASK	0x20
+#define CS43130_PDN_DSDIF_SHIFT	5
+#define CS43130_PDN_HP_MASK	0x10
+#define CS43130_PDN_HP_SHIFT	4
+#define CS43130_PDN_XTAL_MASK	0x08
+#define CS43130_PDN_XTAL_SHIFT	3
+#define CS43130_PDN_PLL_MASK	0x04
+#define CS43130_PDN_PLL_SHIFT	2
+#define CS43130_PDN_CLKOUT_MASK	0x02
+#define CS43130_PDN_CLKOUT_SHIFT	1
+
+/* Reg CS43130_HP_OUT_CTL_1 */
+#define CS43130_HP_IN_EN_SHIFT		3
+#define CS43130_HP_IN_EN_MASK		0x08
+
+/* Reg CS43130_PAD_INT_CFG */
+#define CS43130_ASP_3ST_MASK		0x01
+#define CS43130_XSP_3ST_MASK		0x02
+
+/* Reg CS43130_PLL_SET_2 */
+#define CS43130_PLL_DIV_DATA_MASK	0x000000FF
+#define CS43130_PLL_DIV_FRAC_0_DATA_SHIFT	0
+
+/* Reg CS43130_PLL_SET_3 */
+#define CS43130_PLL_DIV_FRAC_1_DATA_SHIFT	8
+
+/* Reg CS43130_PLL_SET_4 */
+#define CS43130_PLL_DIV_FRAC_2_DATA_SHIFT	16
+
+/* Reg CS43130_SP_DEN_1 */
+#define CS43130_SP_M_LSB_DATA_MASK	0x00FF
+#define CS43130_SP_M_LSB_DATA_SHIFT	0
+
+/* Reg CS43130_SP_DEN_2 */
+#define CS43130_SP_M_MSB_DATA_MASK	0xFF00
+#define CS43130_SP_M_MSB_DATA_SHIFT	8
+
+/* Reg CS43130_SP_NUM_1 */
+#define CS43130_SP_N_LSB_DATA_MASK	0x00FF
+#define CS43130_SP_N_LSB_DATA_SHIFT	0
+
+/* Reg CS43130_SP_NUM_2 */
+#define CS43130_SP_N_MSB_DATA_MASK	0xFF00
+#define CS43130_SP_N_MSB_DATA_SHIFT	8
+
+/* Reg CS43130_SP_LRCK_HI_TIME_1 */
+#define	CS43130_SP_LCHI_DATA_MASK	0x00FF
+#define CS43130_SP_LCHI_LSB_DATA_SHIFT	0
+
+/* Reg CS43130_SP_LRCK_HI_TIME_2 */
+#define CS43130_SP_LCHI_MSB_DATA_SHIFT	8
+
+/* Reg CS43130_SP_LRCK_PERIOD_1 */
+#define CS43130_SP_LCPR_DATA_MASK	0x00FF
+#define CS43130_SP_LCPR_LSB_DATA_SHIFT	0
+
+/* Reg CS43130_SP_LRCK_PERIOD_2 */
+#define CS43130_SP_LCPR_MSB_DATA_SHIFT	8
+
+#define CS43130_PCM_FORMATS (SNDRV_PCM_FMTBIT_S8  | \
+			SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+#define CS43130_DOP_FORMATS (SNDRV_PCM_FMTBIT_DSD_U16_LE | \
+			     SNDRV_PCM_FMTBIT_DSD_U16_BE | \
+			     SNDRV_PCM_FMTBIT_S24_LE)
+
+/* Reg CS43130_CRYSTAL_SET */
+#define CS43130_XTAL_IBIAS_MASK		0x07
+
+/* Reg CS43130_PATH_CTL_1 */
+#define CS43130_MUTE_MASK		0x03
+#define CS43130_MUTE_EN			0x03
+
+/* Reg CS43130_DSD_INT_CFG */
+#define CS43130_DSD_MASTER		0x04
+
+/* Reg CS43130_DSD_PATH_CTL_2 */
+#define CS43130_DSD_SRC_MASK		0x60
+#define CS43130_DSD_SRC_SHIFT		5
+#define CS43130_DSD_EN_SHIFT		4
+#define CS43130_DSD_SPEED_MASK		0x04
+#define CS43130_DSD_SPEED_SHIFT		2
+
+/* Reg CS43130_DSD_PCM_MIX_CTL	*/
+#define CS43130_MIX_PCM_PREP_SHIFT	1
+#define CS43130_MIX_PCM_PREP_MASK	0x02
+
+#define CS43130_MIX_PCM_DSD_SHIFT	0
+#define CS43130_MIX_PCM_DSD_MASK	0x01
+
+/* Reg CS43130_HP_MEAS_LOAD */
+#define CS43130_HP_MEAS_LOAD_MASK	0x000000FF
+#define CS43130_HP_MEAS_LOAD_1_SHIFT	0
+#define CS43130_HP_MEAS_LOAD_2_SHIFT	8
+
+#define CS43130_MCLK_22M		22579200
+#define CS43130_MCLK_24M		24576000
+
+#define CS43130_LINEOUT_LOAD		5000
+#define CS43130_JACK_LINEOUT		(SND_JACK_MECHANICAL | SND_JACK_LINEOUT)
+#define CS43130_JACK_HEADPHONE		(SND_JACK_MECHANICAL | \
+					 SND_JACK_HEADPHONE)
+#define CS43130_JACK_MASK		(SND_JACK_MECHANICAL | \
+					 SND_JACK_LINEOUT | \
+					 SND_JACK_HEADPHONE)
+
+enum cs43130_dsd_src {
+	CS43130_DSD_SRC_DSD = 0,
+	CS43130_DSD_SRC_ASP = 2,
+	CS43130_DSD_SRC_XSP = 3,
+};
+
+enum cs43130_asp_rate {
+	CS43130_ASP_SPRATE_32K = 0,
+	CS43130_ASP_SPRATE_44_1K,
+	CS43130_ASP_SPRATE_48K,
+	CS43130_ASP_SPRATE_88_2K,
+	CS43130_ASP_SPRATE_96K,
+	CS43130_ASP_SPRATE_176_4K,
+	CS43130_ASP_SPRATE_192K,
+	CS43130_ASP_SPRATE_352_8K,
+	CS43130_ASP_SPRATE_384K,
+};
+
+enum cs43130_mclk_src_sel {
+	CS43130_MCLK_SRC_EXT = 0,
+	CS43130_MCLK_SRC_PLL,
+	CS43130_MCLK_SRC_RCO
+};
+
+enum cs43130_mclk_int_freq {
+	CS43130_MCLK_24P5 = 0,
+	CS43130_MCLK_22P5,
+};
+
+enum cs43130_xtal_ibias {
+	CS43130_XTAL_UNUSED = -1,
+	CS43130_XTAL_IBIAS_15UA = 2,
+	CS43130_XTAL_IBIAS_12_5UA = 4,
+	CS43130_XTAL_IBIAS_7_5UA = 6,
+};
+
+enum cs43130_dai_id {
+	CS43130_ASP_PCM_DAI = 0,
+	CS43130_ASP_DOP_DAI,
+	CS43130_XSP_DOP_DAI,
+	CS43130_XSP_DSD_DAI,
+	CS43130_DAI_ID_MAX,
+};
+
+struct cs43130_clk_gen {
+	unsigned int	mclk_int;
+	int		fs;
+	u16		den;
+	u16		num;
+};
+
+/* frm_size = 16 */
+static const struct cs43130_clk_gen cs43130_16_clk_gen[] = {
+	{22579200,	32000,		441,		10,},
+	{22579200,	44100,		32,		1,},
+	{22579200,	48000,		147,		5,},
+	{22579200,	88200,		16,		1,},
+	{22579200,	96000,		147,		10,},
+	{22579200,	176400,		8,		1,},
+	{22579200,	192000,		147,		20,},
+	{22579200,	352800,		4,		1,},
+	{22579200,	384000,		147,		40,},
+	{24576000,	32000,		48,		1,},
+	{24576000,	44100,		5120,		147,},
+	{24576000,	48000,		32,		1,},
+	{24576000,	88200,		2560,		147,},
+	{24576000,	96000,		16,		1,},
+	{24576000,	176400,		1280,		147,},
+	{24576000,	192000,		8,		1,},
+	{24576000,	352800,		640,		147,},
+	{24576000,	384000,		4,		1,},
+};
+
+/* frm_size = 32 */
+static const struct cs43130_clk_gen cs43130_32_clk_gen[] = {
+	{22579200,	32000,		441,		20,},
+	{22579200,	44100,		16,		1,},
+	{22579200,	48000,		147,		10,},
+	{22579200,	88200,		8,		1,},
+	{22579200,	96000,		147,		20,},
+	{22579200,	176400,		4,		1,},
+	{22579200,	192000,		147,		40,},
+	{22579200,	352800,		2,		1,},
+	{22579200,	384000,		147,		80,},
+	{24576000,	32000,		24,		1,},
+	{24576000,	44100,		2560,		147,},
+	{24576000,	48000,		16,		1,},
+	{24576000,	88200,		1280,		147,},
+	{24576000,	96000,		8,		1,},
+	{24576000,	176400,		640,		147,},
+	{24576000,	192000,		4,		1,},
+	{24576000,	352800,		320,		147,},
+	{24576000,	384000,		2,		1,},
+};
+
+/* frm_size = 48 */
+static const struct cs43130_clk_gen cs43130_48_clk_gen[] = {
+	{22579200,	32000,		147,		100,},
+	{22579200,	44100,		32,		3,},
+	{22579200,	48000,		49,		5,},
+	{22579200,	88200,		16,		3,},
+	{22579200,	96000,		49,		10,},
+	{22579200,	176400,		8,		3,},
+	{22579200,	192000,		49,		20,},
+	{22579200,	352800,		4,		3,},
+	{22579200,	384000,		49,		40,},
+	{24576000,	32000,		16,		1,},
+	{24576000,	44100,		5120,		441,},
+	{24576000,	48000,		32,		3,},
+	{24576000,	88200,		2560,		441,},
+	{24576000,	96000,		16,		3,},
+	{24576000,	176400,		1280,		441,},
+	{24576000,	192000,		8,		3,},
+	{24576000,	352800,		640,		441,},
+	{24576000,	384000,		4,		3,},
+};
+
+/* frm_size = 64 */
+static const struct cs43130_clk_gen cs43130_64_clk_gen[] = {
+	{22579200,	32000,		441,		40,},
+	{22579200,	44100,		8,		1,},
+	{22579200,	48000,		147,		20,},
+	{22579200,	88200,		4,		1,},
+	{22579200,	96000,		147,		40,},
+	{22579200,	176400,		2,		1,},
+	{22579200,	192000,		147,		80,},
+	{22579200,	352800,		1,		1,},
+	{24576000,	32000,		12,		1,},
+	{24576000,	44100,		1280,		147,},
+	{24576000,	48000,		8,		1,},
+	{24576000,	88200,		640,		147,},
+	{24576000,	96000,		4,		1,},
+	{24576000,	176400,		320,		147,},
+	{24576000,	192000,		2,		1,},
+	{24576000,	352800,		160,		147,},
+	{24576000,	384000,		1,		1,},
+};
+
+struct cs43130_bitwidth_map {
+	unsigned int bitwidth;
+	u8 sp_bit;
+	u8 ch_bit;
+};
+
+struct cs43130_rate_map {
+	int fs;
+	int val;
+};
+
+#define CS43130_AC_FREQ		10
+#define CS43130_DC_THRESHOLD	2
+
+#define CS43130_NUM_SUPPLIES	5
+static const char *const cs43130_supply_names[CS43130_NUM_SUPPLIES] = {
+	"VA",
+	"VP",
+	"VCP",
+	"VD",
+	"VL",
+};
+
+#define CS43130_NUM_INT		5       /* number of interrupt status reg */
+
+struct cs43130_dai {
+	unsigned int			sclk;
+	unsigned int			dai_format;
+	unsigned int			dai_mode;
+};
+
+struct	cs43130_private {
+	struct snd_soc_codec		*codec;
+	struct regmap			*regmap;
+	struct regulator_bulk_data	supplies[CS43130_NUM_SUPPLIES];
+	struct gpio_desc		*reset_gpio;
+	unsigned int			dev_id; /* codec device ID */
+	int				xtal_ibias;
+	bool                            idle_bias_off;
+
+	/* shared by both DAIs */
+	struct mutex			clk_mutex;
+	int				clk_req;
+	bool				pll_bypass;
+	struct completion		xtal_rdy;
+	struct completion		pll_rdy;
+	unsigned int			mclk;
+	unsigned int			mclk_int;
+	int				mclk_int_src;
+
+	/* DAI specific */
+	struct cs43130_dai		dais[CS43130_DAI_ID_MAX];
+
+	/* HP load specific */
+	bool				dc_meas;
+	bool				ac_meas;
+	bool				hpload_done;
+	struct completion		hpload_evt;
+	unsigned int			hpload_stat;
+	u16				hpload_dc[2];
+	u16				dc_threshold[CS43130_DC_THRESHOLD];
+	u16				ac_freq[CS43130_AC_FREQ];
+	u16				hpload_ac[CS43130_AC_FREQ][2];
+	struct workqueue_struct		*wq;
+	struct work_struct		work;
+	struct snd_soc_jack		jack;
+};
+
+#endif	/* __CS43130_H__ */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
