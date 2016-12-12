From: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: Add support for CS43130 codec
Date: Mon, 12 Dec 2016 14:17:30 -0600
Message-ID: <57223c0a-d169-4642-8427-292cd4ead15c@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add support for Cirrus Logic CS43130 codec.
Support I2C control and I2S audio playback.

Signed-off-by: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 sound/soc/codecs/Kconfig   |    6 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/cs43130.c | 1164 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs43130.h |  268 ++++++++++
 4 files changed, 1440 insertions(+)
 create mode 100644 sound/soc/codecs/cs43130.c
 create mode 100644 sound/soc/codecs/cs43130.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a..d6ede2b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -59,6 +59,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4271_I2C if I2C
 	select SND_SOC_CS4271_SPI if SPI_MASTER
 	select SND_SOC_CS42XX8_I2C if I2C
+	select SND_SOC_CS43130 if I2C
 	select SND_SOC_CS4349 if I2C
 	select SND_SOC_CS47L24 if MFD_CS47L24
 	select SND_SOC_CS53L30 if I2C
@@ -473,6 +474,11 @@ config SND_SOC_CS42XX8_I2C
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
index 7e1dad7..2f15228 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -52,6 +52,7 @@ snd-soc-cs4271-i2c-objs := cs4271-i2c.o
 snd-soc-cs4271-spi-objs := cs4271-spi.o
 snd-soc-cs42xx8-objs := cs42xx8.o
 snd-soc-cs42xx8-i2c-objs := cs42xx8-i2c.o
+snd-soc-cs43130-objs := cs43130.o
 snd-soc-cs4349-objs := cs4349.o
 snd-soc-cs47l24-objs := cs47l24.o
 snd-soc-cs53l30-objs := cs53l30.o
@@ -281,6 +282,7 @@ obj-$(CONFIG_SND_SOC_CS4271_I2C)	+= snd-soc-cs4271-i2c.o
 obj-$(CONFIG_SND_SOC_CS4271_SPI)	+= snd-soc-cs4271-spi.o
 obj-$(CONFIG_SND_SOC_CS42XX8)	+= snd-soc-cs42xx8.o
 obj-$(CONFIG_SND_SOC_CS42XX8_I2C) += snd-soc-cs42xx8-i2c.o
+obj-$(CONFIG_SND_SOC_CS43130)   += snd-soc-cs43130.o
 obj-$(CONFIG_SND_SOC_CS4349)	+= snd-soc-cs4349.o
 obj-$(CONFIG_SND_SOC_CS47L24)	+= snd-soc-cs47l24.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
new file mode 100644
index 0000000..79e4d2a
--- /dev/null
+++ b/sound/soc/codecs/cs43130.c
@@ -0,0 +1,1164 @@
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
+
+#include "cs43130.h"
+
+
+static const struct reg_default cs43130_reg_defaults[] = {
+	{ CS43130_SYS_CLK_CTL_1, 0x06 },
+	{ CS43130_SP_SRATE, 0x01 },
+	{ CS43130_SP_BITSIZE, 0x05 },
+	{ CS43130_PAD_INT_CFG, 0x03 },
+	{ CS43130_PWDN_CTL, 0xFE },
+	{ CS43130_CRYSTAL_SET, 0x04 },
+	{ CS43130_PLL_SET_1, 0x00 },
+	{ CS43130_PLL_SET_2, 0x00 },
+	{ CS43130_PLL_SET_3, 0x00 },
+	{ CS43130_PLL_SET_4, 0x00 },
+	{ CS43130_PLL_SET_5, 0x40 },
+	{ CS43130_PLL_SET_6, 0x10 },
+	{ CS43130_PLL_SET_7, 0x80 },
+	{ CS43130_PLL_SET_8, 0x03 },
+	{ CS43130_PLL_SET_9, 0x02 },
+	{ CS43130_PLL_SET_10, 0x02 },
+	{ CS43130_CLKOUT_CTL, 0x00 },
+	{ CS43130_ASP_NUM_1, 0x01 },
+	{ CS43130_ASP_NUM_2, 0x00 },
+	{ CS43130_ASP_DENOM_1, 0x08 },
+	{ CS43130_ASP_DENOM_2, 0x00 },
+	{ CS43130_ASP_LRCK_HI_TIME_1, 0x1F },
+	{ CS43130_ASP_LRCK_HI_TIME_2, 0x00 },
+	{ CS43130_ASP_LRCK_PERIOD_1, 0x3F },
+	{ CS43130_ASP_LRCK_PERIOD_2, 0x00 },
+	{ CS43130_ASP_CLOCK_CONF, 0x0C },
+	{ CS43130_ASP_FRAME_CONF, 0x0A },
+	{ CS43130_XSP_NUM_1, 0x01 },
+	{ CS43130_XSP_NUM_2, 0x00 },
+	{ CS43130_XSP_DENOM_1, 0x02 },
+	{ CS43130_XSP_DENOM_2, 0x00 },
+	{ CS43130_XSP_LRCK_HI_TIME_1, 0x1F },
+	{ CS43130_XSP_LRCK_HI_TIME_2, 0x00 },
+	{ CS43130_XSP_LRCK_PERIOD_1, 0x3F },
+	{ CS43130_XSP_LRCK_PERIOD_2, 0x00 },
+	{ CS43130_XSP_CLOCK_CONF, 0x0C },
+	{ CS43130_XSP_FRAME_CONF, 0x0A },
+	{ CS43130_ASP_CH_1_LOC, 0x00 },
+	{ CS43130_ASP_CH_2_LOC, 0x00 },
+	{ CS43130_ASP_CH_1_SZ_EN, 0x06 },
+	{ CS43130_ASP_CH_2_SZ_EN, 0x0E },
+	{ CS43130_XSP_CH_1_LOC, 0x00 },
+	{ CS43130_XSP_CH_2_LOC, 0x00 },
+	{ CS43130_XSP_CH_1_SZ_EN, 0x06 },
+	{ CS43130_XSP_CH_2_SZ_EN, 0x0E },
+	{ CS43130_DSD_VOL_B, 0x78 },
+	{ CS43130_DSD_VOL_A, 0x78 },
+	{ CS43130_DSD_PATH_CTL_1, 0xA8 },
+	{ CS43130_DSD_INT_CFG, 0x00 },
+	{ CS43130_DSD_PATH_CTL_2, 0x00 },
+	{ CS43130_DSD_PCM_MIX_CTL, 0x00 },
+	{ CS43130_DSD_PATH_CTL_3, 0x40 },
+	{ CS43130_HP_OUT_CTL_1, 0x30 },
+	{ CS43130_PCM_FILT_OPT, 0x02 },
+	{ CS43130_PCM_VOL_B, 0x78 },
+	{ CS43130_PCM_VOL_A, 0x78 },
+	{ CS43130_PCM_PATH_CTL_1, 0xA8 },
+	{ CS43130_PCM_PATH_CTL_2, 0x00 },
+	{ CS43130_CLASS_H_CTL, 0x1E },
+	{ CS43130_HP_DETECT, 0x04 },
+	{ CS43130_HP_LOAD_1, 0x00 },
+	{ CS43130_HP_MEAS_LOAD_1, 0x00 },
+	{ CS43130_HP_MEAS_LOAD_2, 0x00 },
+	{ CS43130_INT_MASK_1, 0xFF },
+	{ CS43130_INT_MASK_2, 0xFF },
+	{ CS43130_INT_MASK_3, 0xFF },
+	{ CS43130_INT_MASK_4, 0xFF },
+	{ CS43130_INT_MASK_5, 0xFF },
+};
+
+static bool cs43130_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS43130_INT_STATUS_1 ... CS43130_INT_STATUS_5:
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
+	case CS43130_DXD1:
+	case CS43130_PWDN_CTL:
+	case CS43130_DXD2:
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
+	u32 pll_in;
+	u8 mclk_int;
+	u8 sclk_prediv;
+	u8 pll_div_int;
+	u32 pll_div_frac;
+	u8 pll_mode;
+	u8 pll_divout;
+	u32 pll_out;
+	u8 pll_cal_ratio;
+};
+
+static const struct cs43130_pll_params pll_ratio_table[] = {
+	{ 9600000, 1, 0x02, 0x49, 0x800000, 0x00, 0x08, 22579200, 151 },
+	{ 9600000, 0, 0x02, 0x50, 0x000000, 0x00, 0x08, 24576000, 164 },
+
+	{ 11289600, 1, 0x02, 0X40, 0, 0x01, 0x08, 22579200, 128 },
+	{ 11289600, 0, 0x02, 0x44, 0x06F700, 0x0, 0x08, 24576000, 139 },
+
+	{ 12000000, 1, 0x02, 0x49, 0x800000, 0x00, 0x0A, 22579200, 120 },
+	{ 12000000, 0, 0x02, 0x40, 0x000000, 0x00, 0x08, 24576000, 131 },
+
+	{ 12288000, 1, 0x02, 0x49, 0x800000, 0x01, 0x0A, 22579200, 118 },
+	{ 12288000, 0, 0x02, 0x40, 0x000000, 0x01, 0x08, 24576000, 128 },
+
+	{ 13000000, 1, 0x02, 0x49, 0x800000, 0x01, 0x0A, 22579200, 118 },
+	{ 13000000, 0, 0x02, 0x40, 0x000000, 0x01, 0x08, 24576000, 128 },
+
+	{ 19200000, 1, 0x02, 0x45, 0x797680, 0x01, 0x0A, 22579200, 111 },
+	{ 19200000, 0, 0x02, 0x3C, 0x7EA940, 0x01, 0x08, 24576000, 121 },
+
+	{ 22579200, 1, 0, 0, 0, 0, 0, 22579200, 0 },
+	{ 22579200, 0, 0x03, 0x44, 0x06F700, 0x00, 0x08, 24576000, 139 },
+
+	{ 24000000, 1, 0x03, 0x49, 0x800000, 0x00, 0x0A, 22579200, 120 },
+	{ 24000000, 0, 0x03, 0x40, 0x000000, 0x00, 0x08, 24576000, 131 },
+
+	{ 24576000, 1, 0x03, 0x49, 0x800000, 0x01, 0x0A, 22579200, 128 },
+	{ 24576000, 0, 0, 0, 0, 0, 0, 24576000, 0 },
+
+	{ 26000000, 1, 0x03, 0x45, 0x797680, 0x01, 0x0A, 22579200, 111 },
+	{ 26000000, 0, 0x03, 0x3C, 0x7EA940, 0x01, 0x08, 24576000, 121 },
+};
+
+static int cs43130_pll_config(struct snd_soc_codec *codec)
+{
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	dev_dbg(codec->dev, "%s: cs43130->mclk = %d, cs43130->pll_out = %d",
+		__func__, cs43130->mclk, cs43130->pll_out);
+	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
+		if (pll_ratio_table[i].pll_in == cs43130->mclk &&
+			pll_ratio_table[i].pll_out == cs43130->pll_out) {
+
+			cs43130->mclk_int = pll_ratio_table[i].mclk_int;
+
+			if (pll_ratio_table[i].pll_cal_ratio == 0) {
+				if (cs43130->xtal_ibias > 0) {
+					usleep_range(1000, 1050);
+					/*PDN_XTAL = 0,enable*/
+					regmap_update_bits(cs43130->regmap,
+						CS43130_PWDN_CTL,
+						CS43130_PDN_XTAL_MASK,
+						0 << CS43130_PDN_XTAL_SHIFT);
+				}
+
+				/* PLL_START = 0, disable PLL_START */
+				regmap_update_bits(cs43130->regmap,
+					CS43130_PLL_SET_1,
+					CS43130_PLL_START_MASK,
+				    0 << CS43130_PLL_START_MASK);
+
+				cs43130->pll_bypass = true;
+				return 0;
+			}
+
+			/* PDN_PLL= 0,enable */
+			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+				CS43130_PDN_PLL_MASK,
+				0 << CS43130_PDN_PLL_SHIFT);
+
+			regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_9,
+				CS43130_PLL_REF_PREDIV_MASK,
+				pll_ratio_table[i].sclk_prediv);
+
+			regmap_write(cs43130->regmap, CS43130_PLL_SET_5,
+				pll_ratio_table[i].pll_div_int);
+
+			regmap_write(cs43130->regmap, CS43130_PLL_SET_2,
+				pll_ratio_table[i].pll_div_frac &
+				CS43130_7_0_MASK);
+
+			regmap_write(cs43130->regmap, CS43130_PLL_SET_3,
+				(pll_ratio_table[i].pll_div_frac &
+				CS43130_15_8_MASK) >> 8);
+
+			regmap_write(cs43130->regmap, CS43130_PLL_SET_4,
+				(pll_ratio_table[i].pll_div_frac &
+				CS43130_23_16_MASK) >> 16);
+
+			regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_8,
+				CS43130_PLL_MODE_MASK,
+				pll_ratio_table[i].pll_mode
+				<< CS43130_PLL_MODE_SHIFT);
+
+			regmap_write(cs43130->regmap, CS43130_PLL_SET_6,
+				pll_ratio_table[i].pll_divout);
+
+			regmap_write(cs43130->regmap, CS43130_PLL_SET_7,
+				pll_ratio_table[i].pll_cal_ratio);
+
+			/* PLL_START = 1, enable PLL_START */
+			regmap_update_bits(cs43130->regmap, CS43130_PLL_SET_1,
+				CS43130_PLL_START_MASK, CS43130_PLL_START_MASK);
+			cs43130->pll_bypass = false;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int cs43130_format_config(struct snd_soc_codec *codec)
+{
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	int period_size = 0;
+	int pulse_width = 0;
+	int asp_fsd;
+	int asp_stp;
+	int bick_inv;
+	int asp_m = 0;
+	int asp_sprate = 0;
+	int ret = 0;
+	unsigned int bitwidth_sclk = (cs43130->sclk / cs43130->fs) / 2;
+	unsigned int bitwidth_dai = (cs43130->dai_bit + 1) * 8;
+
+	if (cs43130->fs) {
+		if (bitwidth_sclk < bitwidth_dai) {
+			dev_err(codec->dev, "Format not supported\n");
+			return -EINVAL;
+		}
+		period_size = cs43130->sclk / cs43130->fs;
+		pulse_width = period_size/2;
+
+		if (cs43130->sclk != 0)
+			asp_m = cs43130->pll_out / cs43130->sclk;
+	}
+	dev_dbg(codec->dev, "%s: cs43130->sclk = %d, cs43130->fs = %d, cs43130->dai_bit = %d",
+		__func__, cs43130->sclk, cs43130->fs, cs43130->dai_bit);
+	dev_dbg(codec->dev, "%s: period_size = %d, pulse_width = %d, asp_m = %d",
+		__func__, period_size, pulse_width, asp_m);
+
+	if (cs43130->dai_format) {
+		/*MSB*/
+		bick_inv = 0;
+		asp_fsd = 0;
+		asp_stp = 1;
+
+	} else {
+		/*I2S*/
+		bick_inv = 1;
+		asp_fsd = 2; /* one bick delay */
+		asp_stp = 0;
+	}
+	dev_dbg(codec->dev,
+		"%s: cs43130->dai_format = %d, bick_inv = %d, asp_fsd = %d, asp_stp = %d",
+		__func__, cs43130->dai_format, bick_inv, asp_fsd, asp_stp);
+
+	switch (cs43130->fs) {
+	case 32000:
+		asp_sprate = CS43130_ASP_SPRATE_32K;
+		break;
+	case 44100:
+		asp_sprate = CS43130_ASP_SPRATE_44_1K;
+		break;
+	case 48000:
+		asp_sprate = CS43130_ASP_SPRATE_48K;
+		break;
+	case 88200:
+		asp_sprate = CS43130_ASP_SPRATE_88_2K;
+		break;
+	case 96000:
+		asp_sprate = CS43130_ASP_SPRATE_96K;
+		break;
+	case 176400:
+		asp_sprate = CS43130_ASP_SPRATE_176_4K;
+		break;
+	case 192000:
+		asp_sprate = CS43130_ASP_SPRATE_192K;
+		break;
+	case 352800:
+		asp_sprate = CS43130_ASP_SPRATE_352_8K;
+		break;
+	case 384000:
+		asp_sprate = CS43130_ASP_SPRATE_384K;
+		break;
+	default:
+		dev_err(codec->dev, "sample rate(%d) not supported\n",
+				cs43130->fs);
+		return -EINVAL;
+	}
+	dev_dbg(codec->dev, "%s: asp_sprate = %d, cs43130->asp_size = %d",
+		__func__, asp_sprate, cs43130->asp_size);
+
+	/* ASP_SPRATE = fs*/
+	regmap_write(cs43130->regmap, CS43130_SP_SRATE, asp_sprate);
+	/*ASP_SPSIZE*/
+	regmap_update_bits(cs43130->regmap, CS43130_SP_BITSIZE,
+		CS43130_SP_BITSIZE_ASP_MASK, cs43130->asp_size);
+
+
+	/* Set up slave mode */
+	/*BICK = ASP_N/ASP_M * PLL_OUT */
+	/* ASP_N = 1 */
+	regmap_write(cs43130->regmap, CS43130_ASP_NUM_1, 1);
+	regmap_write(cs43130->regmap, CS43130_ASP_NUM_2, 0);
+
+	/*ASP_M*/
+	regmap_write(cs43130->regmap, CS43130_ASP_DENOM_1, asp_m & 0xff);
+	regmap_write(cs43130->regmap, CS43130_ASP_DENOM_2, (asp_m >> 8) & 0x3f);
+
+
+	/* H / L ratio of LRCK*/
+	regmap_write(cs43130->regmap, CS43130_ASP_LRCK_HI_TIME_1,
+	    (pulse_width-1)  & 0xff);
+	regmap_write(cs43130->regmap, CS43130_ASP_LRCK_HI_TIME_2,
+	    ((pulse_width-1) >> 8) & 0xff);
+
+	/* the period of LRCK*/
+	regmap_write(cs43130->regmap, CS43130_ASP_LRCK_PERIOD_1,
+	    (period_size-1) & 0xff);
+	regmap_write(cs43130->regmap, CS43130_ASP_LRCK_PERIOD_2,
+	    ((period_size-1) >> 8) & 0xff);
+
+	/*resolution*/
+	regmap_update_bits(cs43130->regmap, CS43130_ASP_CH_1_SZ_EN,
+		CS43130_SP_BITSIZE_ASP_MASK, cs43130->dai_bit);
+	regmap_update_bits(cs43130->regmap, CS43130_ASP_CH_2_SZ_EN,
+		CS43130_SP_BITSIZE_ASP_MASK, cs43130->dai_bit);
+
+	regmap_update_bits(cs43130->regmap, CS43130_ASP_FRAME_CONF,
+		CS43130_ASP_FSD_MASK, asp_fsd << CS43130_ASP_FSD_SHIFT);
+
+	regmap_update_bits(cs43130->regmap, CS43130_ASP_FRAME_CONF,
+		CS43130_ASP_STP_MASK, asp_stp << CS43130_ASP_STP_SHIFT);
+
+	/* set clk master/slave */
+	dev_dbg(codec->dev, "%s: cs43130->dai_mode = %d",
+	    __func__, cs43130->dai_mode);
+	regmap_update_bits(cs43130->regmap, CS43130_ASP_CLOCK_CONF,
+	    CS43130_ASP_MODE_MASK, cs43130->dai_mode << CS43130_ASP_MODE_SHIFT);
+
+	return ret;
+}
+
+static int cs43130_change_clksrc(struct snd_soc_codec *codec,
+	enum cs43130_mclk_src_sel src)
+{
+	int ret = 0;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+	    CS43130_MCLK_SRC_SEL_MASK, src << CS43130_MCLK_SRC_SEL_SHIFT);
+	regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
+	    CS43130_MCLK_INT_MASK, cs43130->mclk_int << CS43130_MCLK_INT_SHIFT);
+
+	usleep_range(150, 200);
+
+	return ret;
+}
+
+static int cs43130_pcm_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	unsigned int bitwidth;
+	int ret = 0;
+
+	cs43130->fs = params_rate(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		cs43130->dai_bit = CS43130_SP_BIT_SIZE_8;
+		cs43130->asp_size = CS43130_SP_BIT_SIZE_32;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		cs43130->dai_bit = CS43130_SP_BIT_SIZE_16;
+		cs43130->asp_size = CS43130_SP_BIT_SIZE_24;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		cs43130->dai_bit = CS43130_SP_BIT_SIZE_24;
+		cs43130->asp_size = CS43130_SP_BIT_SIZE_16;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		cs43130->dai_bit = CS43130_SP_BIT_SIZE_32;
+		cs43130->asp_size = CS43130_SP_BIT_SIZE_8;
+		break;
+	default:
+		dev_err(codec->dev, "Format(%d) not supported",
+				params_format(params));
+		return -EINVAL;
+	}
+
+	bitwidth = (cs43130->dai_bit+1)*8;
+	dev_dbg(codec->dev, "(data bit)%d: (rate)%d",
+		bitwidth, cs43130->fs);
+
+	ret = cs43130_format_config(codec);
+	return ret;
+}
+
+static const DECLARE_TLV_DB_SCALE(pcm_vol_tlv, -12750, 50, 1);
+
+static const struct snd_kcontrol_new cs43130_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			CS43130_PCM_VOL_A, CS43130_PCM_VOL_B, 0, 0xFF, 1,
+			pcm_vol_tlv),
+	SOC_SINGLE("Swap L/R", CS43130_PCM_PATH_CTL_2, 1, 1, 0),
+	SOC_SINGLE("Copy L/R", CS43130_PCM_PATH_CTL_2, 0, 1, 0),
+};
+
+static int cs43130_aspin_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (cs43130->pll_bypass)
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_XTAL);
+		else
+			cs43130_change_clksrc(codec, CS43130_MCLK_SRC_PLL);
+
+		usleep_range(10000, 10050);
+		/* ASP_3ST = 0 in master mode */
+		if (cs43130->dai_mode)
+			regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
+						    0x01, 0x00);
+
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+						    CS43130_PDN_CLKOUT_MASK, 0
+						   << CS43130_PDN_CLKOUT_SHIFT);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		break;
+	default:
+		dev_err(codec->dev, "Invalid ASPOUT event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cs43130_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMD:
+		cs43130_change_clksrc(codec, CS43130_MCLK_SRC_RCO);
+
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+						    CS43130_PDN_XTAL_MASK, 1
+						   << CS43130_PDN_XTAL_SHIFT);
+		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
+						    CS43130_PDN_PLL_MASK, 1
+						   << CS43130_PDN_PLL_SHIFT);
+		break;
+	default:
+		dev_err(codec->dev, "Invalid DAC event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cs43130_hpin_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_write(cs43130->regmap, CS43130_DXD1, 0x99);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_OUT_CTL_1,
+			CS43130_HP_IN_EN_MASK, 0 << CS43130_HP_IN_EN_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_DXD2, 0x00);
+		regmap_write(cs43130->regmap, CS43130_DXD1, 0x00);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_write(cs43130->regmap, CS43130_DXD1, 0x99);
+		regmap_write(cs43130->regmap, CS43130_DXD2, 0x01);
+		regmap_update_bits(cs43130->regmap, CS43130_HP_OUT_CTL_1,
+			CS43130_HP_IN_EN_MASK, 1 << CS43130_HP_IN_EN_SHIFT);
+		regmap_write(cs43130->regmap, CS43130_DXD1, 0x00);
+		break;
+	default:
+		dev_err(codec->dev, "Invalid HPIN event = 0x%x\n", event);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget cs43130_dapm_widgets[] = {
+
+	SND_SOC_DAPM_OUTPUT("HPOUTA"),
+	SND_SOC_DAPM_OUTPUT("HPOUTB"),
+
+	SND_SOC_DAPM_AIF_IN_E("ASPIN", NULL, 0, CS43130_PWDN_CTL,
+		CS43130_PDN_ASP_SHIFT, 1, cs43130_aspin_event,
+		(SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)),
+
+	 SND_SOC_DAPM_DAC_E("HiFi DAC",
+		NULL, CS43130_PWDN_CTL, CS43130_PDN_HP_SHIFT, 1,
+		cs43130_dac_event,
+		(SND_SOC_DAPM_PRE_PMD)
+		),
+
+	SND_SOC_DAPM_LINE("Analog Playback", cs43130_hpin_event),
+};
+
+static const struct snd_soc_dapm_route cs43130_routes[] = {
+	{"ASPIN", NULL, "DAC Playback"},
+	{"HiFi DAC", NULL, "ASPIN"},
+
+	{"HPOUTA", NULL, "HiFi DAC"},
+	{"HPOUTB", NULL, "HiFi DAC"},
+	{"HPOUTA", NULL, "Analog Playback"},
+	{"HPOUTB", NULL, "Analog Playback"},
+};
+
+static const unsigned int cs43130_src_rates[] = {
+	32000, 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
+};
+
+static const struct snd_pcm_hw_constraint_list cs43130_constraints = {
+	.count	= ARRAY_SIZE(cs43130_src_rates),
+	.list	= cs43130_src_rates,
+};
+
+static int cs43130_pcm_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &cs43130_constraints);
+	return 0;
+}
+
+static int cs43130_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs43130->dai_mode = CS43130_SLAVE_MODE;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs43130->dai_mode = CS43130_MASTER_MODE;
+		break;
+	default:
+		dev_err(codec->dev, "unsupported i2s master mode\n");
+		return -EINVAL;
+	}
+
+	 /* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cs43130->dai_format = 0;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		cs43130->dai_format = 1;
+		break;
+	default:
+		dev_err(codec->dev, "unsupported audio format except I2S and MSB\n");
+		return -EINVAL;
+	}
+
+	/* BICK/LRCK pority */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		cs43130->bick_invert = false;
+		cs43130->lrck_invert = false;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		cs43130->bick_invert = true;
+		cs43130->lrck_invert = false;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		cs43130->bick_invert = false;
+		cs43130->lrck_invert = true;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		cs43130->bick_invert = true;
+		cs43130->lrck_invert = true;
+		break;
+	default:
+		dev_err(codec->dev, "unsupported audio polarity\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int cs43130_set_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+	unsigned int reg;
+	u8 mute_reg;
+
+	regmap_read(cs43130->regmap, CS43130_PCM_PATH_CTL_1, &reg);
+	mute_reg = reg & 0xfc;
+	if (mute)
+		regmap_write(cs43130->regmap, CS43130_PCM_PATH_CTL_1,
+			mute_reg | 0x03);
+	else
+		regmap_write(cs43130->regmap, CS43130_PCM_PATH_CTL_1, mute_reg);
+
+	return ret;
+}
+
+static int cs43130_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+
+	switch (div_id) {
+	case CS43130_AIF_BICK_RATE:
+		cs43130->bick = div;
+		break;
+	default:
+		dev_err(codec->dev,
+			"Unsupported divide value: div_id = %d", div_id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cs43130_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
+		unsigned int freq_in, unsigned int freq_out)
+{
+	int ret = 0;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	if (freq_in < 9600000 || freq_in > 26000000) {
+		dev_err(codec->dev,
+			"unsupported pll input reference clock:%d\n", freq_in);
+		return -EINVAL;
+	}
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
+		cs43130->pll_out = freq_out;
+		cs43130->mclk_int = 1;
+		break;
+	case 24576000:
+		cs43130->pll_out = freq_out;
+		cs43130->mclk_int = 0;
+		break;
+	default:
+		dev_err(codec->dev,
+			"unsupported pll output reference clock:%d\n",
+			freq_out);
+		return -EINVAL;
+	}
+
+	ret = cs43130_pll_config(codec);
+	dev_dbg(codec->dev, "%s: cs43130->pll_bypass = %d",
+		__func__, cs43130->pll_bypass);
+	return ret;
+}
+
+static int cs43130_dai_set_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s: clk_id =  %d, freq = %d, dir = %d",
+		__func__, clk_id, freq, dir);
+	cs43130->sclk = freq;
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs43130_dai_ops = {
+	.startup	= cs43130_pcm_startup,
+	.hw_params	= cs43130_pcm_hw_params,
+	.set_sysclk	= cs43130_dai_set_sysclk,
+	.set_fmt	= cs43130_set_dai_fmt,
+	.digital_mute = cs43130_set_mute,
+	.set_clkdiv = cs43130_set_clkdiv,
+};
+
+static struct snd_soc_dai_driver cs43130_dai[] = {
+	{
+		.name = "cs43130_hifi",
+		.id = 0,
+		.playback = {
+			.stream_name = "DAC Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS43130_ASP_FORMATS,
+		},
+		.ops = &cs43130_dai_ops,
+		.symmetric_rates = 1,
+	},
+	{
+		.name = "cs43130-xsp",
+		.id = 1,
+		.playback = {
+			.stream_name = "XSP Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS43130_XSP_FORMATS,
+		},
+		.symmetric_rates = 1,
+	 },
+};
+
+static int cs43130_codec_set_sysclk(struct snd_soc_codec *codec,
+		int clk_id, int source, unsigned int freq, int dir)
+{
+	/* 24576000 is not supported */
+	unsigned int mclk_int_freq = 22579200;
+
+	dev_dbg(codec->dev, "%s: clk_id = %d, source = %d, freq = %d, dir = %d\n",
+		__func__, clk_id, source, freq, dir);
+	/*
+	 * freq is external mclk freq
+	 * if freq == mclk_int_freq, pll is bypassed
+	 * modify mclk_int_freq as needed for application
+	 */
+	cs43130_set_pll(codec, 0, 0, freq, mclk_int_freq);
+	return 0;
+}
+
+static irqreturn_t cs43130_irq_thread(int irq, void *data)
+{
+	struct cs43130_private *cs43130 =
+		(struct cs43130_private *)data;
+	struct snd_soc_codec *codec = cs43130->codec;
+	unsigned int stickies[CS43130_NUM_INT];
+	unsigned int masks[CS43130_NUM_INT];
+	unsigned int i;
+
+	/* Read all INT status and mask reg */
+	regmap_bulk_read(cs43130->regmap, CS43130_INT_STATUS_1,
+		stickies, CS43130_NUM_INT * sizeof(unsigned int));
+	regmap_bulk_read(cs43130->regmap, CS43130_INT_MASK_1,
+		masks, CS43130_NUM_INT * sizeof(unsigned int));
+
+	for (i = 0; i < ARRAY_SIZE(stickies); i++)
+		stickies[i] = stickies[i] & (~masks[i]);
+
+	if (stickies[0] & CS43130_XTAL_RDY_INT)
+		dev_dbg(codec->dev, "%s: Crystal ready", __func__);
+
+	if (stickies[0] & CS43130_XTAL_ERR_INT)
+		dev_err(codec->dev, "%s: Crystal err", __func__);
+
+	if (stickies[0] & CS43130_HP_PLUG_INT)
+		dev_dbg(codec->dev, "%s: HP plugged", __func__);
+
+	if (stickies[0] & CS43130_HP_UNPLUG_INT)
+		dev_dbg(codec->dev, "%s: HP unplugged", __func__);
+
+	return IRQ_HANDLED;
+}
+
+static int cs43130_probe(struct snd_soc_codec *codec)
+{
+	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
+
+	cs43130->codec = codec;
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_cs43130 = {
+	.probe			= cs43130_probe,
+	.component_driver = {
+		.controls		= cs43130_snd_controls,
+		.num_controls		= ARRAY_SIZE(cs43130_snd_controls),
+		.dapm_widgets		= cs43130_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(cs43130_dapm_widgets),
+		.dapm_routes		= cs43130_routes,
+		.num_dapm_routes	= ARRAY_SIZE(cs43130_routes),
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
+};
+
+static int cs43130_handle_device_data(
+	struct i2c_client *i2c_client, struct cs43130_private *cs43130)
+{
+	struct device_node *np = i2c_client->dev.of_node;
+	unsigned int val;
+	int ret = 0;
+
+	of_property_read_u32(np, "cirrus,xtal-ibias", &val);
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
+		dev_info(&i2c_client->dev,
+			"cirrus,xtal-ibias value or xtal unused %d",
+			val);
+	}
+	return ret;
+}
+
+static int cs43130_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	struct cs43130_private *cs43130;
+	int ret;
+	unsigned int devid = 0;
+	unsigned int reg;
+	int i;
+
+	cs43130 = devm_kzalloc(&client->dev, sizeof(*cs43130), GFP_KERNEL);
+	if (cs43130 == NULL)
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
+		dev_err(&client->dev,
+			"Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs43130->supplies),
+					cs43130->supplies);
+	if (ret != 0) {
+		dev_err(&client->dev,
+			"Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	cs43130->reset_gpio = devm_gpiod_get_optional(&client->dev,
+		"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs43130->reset_gpio))
+		return PTR_ERR(cs43130->reset_gpio);
+
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 1);
+
+	usleep_range(2000, 2050);
+
+	/* initialize codec */
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
+		break;
+	case CS4399_CHIP_ID:
+		break;
+	default:
+		dev_err(&client->dev,
+			"CS43130 Device ID (%X). Expected ID %X or %X\n",
+			devid, CS43130_CHIP_ID, CS4399_CHIP_ID);
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
+		reg & 0xFF);
+
+	/* Enable interrupt handler */
+	ret = devm_request_threaded_irq(&client->dev,
+			client->irq,
+			NULL, cs43130_irq_thread,
+			IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+			"cs43130", cs43130);
+	if (ret != 0) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
+		return ret;
+	}
+
+	/* Unmask INT */
+	regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
+		CS43130_XTAL_RDY_INT | CS43130_XTAL_ERR_INT |
+		CS43130_HP_PLUG_INT | CS43130_HP_UNPLUG_INT, 0);
+
+	/* Enable HP detect */
+	regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
+		CS43130_HP_DETECT_CTRL_MASK, CS43130_HP_DETECT_CTRL_MASK);
+
+	regmap_write(cs43130->regmap,
+		CS43130_CRYSTAL_SET, cs43130->xtal_ibias);
+	ret = snd_soc_register_codec(&client->dev,
+			&soc_codec_dev_cs43130, cs43130_dai,
+			ARRAY_SIZE(cs43130_dai));
+
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: snd_soc_register_codec failed with ret = %d\n",
+			__func__, ret);
+		goto err;
+	}
+	return 0;
+err:
+	return ret;
+
+}
+
+static int cs43130_i2c_remove(struct i2c_client *client)
+{
+	struct cs43130_private *cs43130 = i2c_get_clientdata(client);
+
+	snd_soc_unregister_codec(&client->dev);
+
+	if (cs43130->reset_gpio)
+		gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
+
+	pm_runtime_disable(&client->dev);
+	regulator_bulk_disable(CS43130_NUM_SUPPLIES,
+		cs43130->supplies);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cs43130_runtime_suspend(struct device *dev)
+{
+	struct cs43130_private *cs43130 = dev_get_drvdata(dev);
+
+	regcache_cache_only(cs43130->regmap, true);
+	regcache_mark_dirty(cs43130->regmap);
+
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
+
+	regulator_bulk_disable(CS43130_NUM_SUPPLIES,
+		cs43130->supplies);
+	return 0;
+}
+
+static int cs43130_runtime_resume(struct device *dev)
+{
+	struct cs43130_private *cs43130 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(CS43130_NUM_SUPPLIES,
+		cs43130->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n",
+			ret);
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
+	return 0;
+err:
+	regcache_cache_only(cs43130->regmap, true);
+	regulator_bulk_disable(CS43130_NUM_SUPPLIES,
+		cs43130->supplies);
+
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops cs43130_runtime_pm = {
+	SET_RUNTIME_PM_OPS(cs43130_runtime_suspend, cs43130_runtime_resume,
+			   NULL)
+};
+
+static const struct of_device_id cs43130_of_match[] = {
+	{ .compatible = "cirrus,cs43130", },
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
index 0000000..bceae76
--- /dev/null
+++ b/sound/soc/codecs/cs43130.h
@@ -0,0 +1,268 @@
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
+#define CS43130_LASTREG		0x0F0014
+#define CS43130_CHIP_ID		0x00043130
+#define CS4399_CHIP_ID		0x00043990
+#define CS43130_DEVID_AB	0x010000         /*Device ID A & B [RO]*/
+#define CS43130_DEVID_CD	0x010001         /*Device ID C & D [RO]*/
+#define CS43130_DEVID_E		0x010002         /*Device ID E [RO]*/
+#define CS43130_FAB_ID		0x010003         /*Fab ID [RO]*/
+#define CS43130_REV_ID		0x010004         /*Revision ID [RO]*/
+#define CS43130_SUBREV_ID	0x010005         /*Subrevision ID*/
+#define CS43130_SYS_CLK_CTL_1	0x010006      /*System Clocking Ctl 1*/
+#define CS43130_SP_SRATE	0x01000B         /*Serial Port Sample Rate*/
+#define CS43130_SP_BITSIZE	0x01000C         /*Serial Port Bit Size*/
+#define CS43130_PAD_INT_CFG	0x01000D      /*Pad Interface Config*/
+#define CS43130_DXD1            0x010010        /*DXD1*/
+#define CS43130_PWDN_CTL	0x020000         /*Power Down Ctl*/
+#define CS43130_DXD2            0x020019        /*DXD2*/
+#define CS43130_CRYSTAL_SET	0x020052      /*Crystal Setting*/
+#define CS43130_PLL_SET_1	0x030001         /*PLL Setting 1*/
+#define CS43130_PLL_SET_2	0x030002         /*PLL Setting 2*/
+#define CS43130_PLL_SET_3	0x030003         /*PLL Setting 3*/
+#define CS43130_PLL_SET_4	0x030004         /*PLL Setting 4*/
+#define CS43130_PLL_SET_5	0x030005         /*PLL Setting 5*/
+#define CS43130_PLL_SET_6	0x030008         /*PLL Setting 6*/
+#define CS43130_PLL_SET_7	0x03000A         /*PLL Setting 7*/
+#define CS43130_PLL_SET_8	0x03001B         /*PLL Setting 8*/
+#define CS43130_PLL_SET_9	0x040002         /*PLL Setting 9*/
+#define CS43130_PLL_SET_10	0x040003         /*PLL Setting 10*/
+#define CS43130_CLKOUT_CTL	0x040004         /*CLKOUT Ctl*/
+#define CS43130_ASP_NUM_1	0x040010         /*ASP Numerator 1*/
+#define CS43130_ASP_NUM_2	0x040011         /*ASP Numerator 2*/
+#define CS43130_ASP_DENOM_1	0x040012      /*ASP Denominator 1*/
+#define CS43130_ASP_DENOM_2	0x040013      /*ASP Denominator 2*/
+#define CS43130_ASP_LRCK_HI_TIME_1 0x040014 /*ASP LRCK High Time 1*/
+#define CS43130_ASP_LRCK_HI_TIME_2 0x040015 /*ASP LRCK High Time 2*/
+#define CS43130_ASP_LRCK_PERIOD_1  0x040016 /*ASP LRCK Period 1*/
+#define CS43130_ASP_LRCK_PERIOD_2  0x040017 /*ASP LRCK Period 2*/
+#define CS43130_ASP_CLOCK_CONF	0x040018   /*ASP Clock Config*/
+#define CS43130_ASP_FRAME_CONF	0x040019   /*ASP Frame Config*/
+#define CS43130_XSP_NUM_1	0x040020         /*XSP Numerator 1*/
+#define CS43130_XSP_NUM_2	0x040021         /*XSP Numerator 2*/
+#define CS43130_XSP_DENOM_1	0x040022      /*XSP Denominator 1*/
+#define CS43130_XSP_DENOM_2	0x040023      /*XSP Denominator 2*/
+#define CS43130_XSP_LRCK_HI_TIME_1 0x040024 /*XSP LRCK High Time 1*/
+#define CS43130_XSP_LRCK_HI_TIME_2 0x040025 /*XSP LRCK High Time 2*/
+#define CS43130_XSP_LRCK_PERIOD_1  0x040026 /*XSP LRCK Period 1*/
+#define CS43130_XSP_LRCK_PERIOD_2  0x040027 /*XSP LRCK Period 2*/
+#define CS43130_XSP_CLOCK_CONF	0x040028   /*XSP Clock Config*/
+#define CS43130_XSP_FRAME_CONF	0x040029   /*XSP Frame Config*/
+#define CS43130_ASP_CH_1_LOC	0x050000      /*ASP Chan 1 Location*/
+#define CS43130_ASP_CH_2_LOC	0x050001      /*ASP Chan 2 Location*/
+#define CS43130_ASP_CH_1_SZ_EN	0x05000A   /*ASP Chan 1 Size, Enable*/
+#define CS43130_ASP_CH_2_SZ_EN	0x05000B   /*ASP Chan 2 Size, Enable*/
+#define CS43130_XSP_CH_1_LOC	0x060000      /*XSP Chan 1 Location*/
+#define CS43130_XSP_CH_2_LOC	0x060001      /*XSP Chan 2 Location*/
+#define CS43130_XSP_CH_1_SZ_EN	0x06000A   /*XSP Chan 1 Size, Enable*/
+#define CS43130_XSP_CH_2_SZ_EN	0x06000B   /*XSP Chan 2 Size, Enable*/
+#define CS43130_DSD_VOL_B	0x070000         /*DSD Volume B*/
+#define CS43130_DSD_VOL_A	0x070001         /*DSD Volume A*/
+#define CS43130_DSD_PATH_CTL_1	0x070002   /*DSD Proc Path Sig Ctl 1*/
+#define CS43130_DSD_INT_CFG	0x070003      /*DSD Interface Config*/
+#define CS43130_DSD_PATH_CTL_2	0x070004   /*DSD Proc Path Sig Ctl 2*/
+#define CS43130_DSD_PCM_MIX_CTL	0x070005   /*DSD and PCM Mixing Ctl*/
+#define CS43130_DSD_PATH_CTL_3	0x070006   /*DSD Proc Path Sig Ctl 3*/
+#define CS43130_HP_OUT_CTL_1	0x080000      /*HP Output Ctl 1*/
+#define CS43130_PCM_FILT_OPT	0x090000      /*PCM Filter Option*/
+#define CS43130_PCM_VOL_B	0x090001         /*PCM Volume B*/
+#define CS43130_PCM_VOL_A	0x090002         /*PCM Volume A*/
+#define CS43130_PCM_PATH_CTL_1	0x090003   /*PCM Path Signal Ctl 1*/
+#define CS43130_PCM_PATH_CTL_2	0x090004   /*PCM Path Signal Ctl 2*/
+#define CS43130_CLASS_H_CTL	0x0B0000      /*Class H Ctl*/
+#define CS43130_HP_DETECT	0x0D0000         /*HP Detect*/
+#define CS43130_HP_STATUS	0x0D0001         /*HP Status [RO]*/
+#define CS43130_HP_LOAD_1	0x0E0000         /*HP Load 1*/
+#define CS43130_HP_MEAS_LOAD_1	0x0E0003   /*HP Load Measurement 1*/
+#define CS43130_HP_MEAS_LOAD_2	0x0E0004   /*HP Load Measurement 2*/
+#define CS43130_HP_DC_STAT_1	0x0E000D      /*HP DC Load Status 0 [RO]*/
+#define CS43130_HP_DC_STAT_2	0x0E000E      /*HP DC Load Status 1 [RO]*/
+#define CS43130_HP_AC_STAT_1	0x0E0010      /*HP AC Load Status 0 [RO]*/
+#define CS43130_HP_AC_STAT_2	0x0E0011      /*HP AC Load Status 1 [RO]*/
+#define CS43130_HP_LOAD_STAT	0x0E001A      /*HP Load Status [RO]*/
+#define CS43130_INT_STATUS_1	0x0F0000      /*Interrupt Status 1*/
+#define CS43130_INT_STATUS_2	0x0F0001      /*Interrupt Status 2*/
+#define CS43130_INT_STATUS_3	0x0F0002      /*Interrupt Status 3*/
+#define CS43130_INT_STATUS_4	0x0F0003      /*Interrupt Status 4*/
+#define CS43130_INT_STATUS_5	0x0F0004      /*Interrupt Status 5*/
+#define CS43130_INT_MASK_1	0x0F0010         /*Interrupt Mask 1*/
+#define CS43130_INT_MASK_2	0x0F0011         /*Interrupt Mask 2*/
+#define CS43130_INT_MASK_3	0x0F0012         /*Interrupt Mask 3*/
+#define CS43130_INT_MASK_4	0x0F0013         /*Interrupt Mask 4*/
+#define CS43130_INT_MASK_5	0x0F0014         /*Interrupt Mask 5*/
+
+#define CS43130_MCLK_SRC_SEL_MASK		0x03
+#define CS43130_MCLK_SRC_SEL_SHIFT		0
+#define CS43130_MCLK_INT_MASK			0x04
+#define CS43130_MCLK_INT_SHIFT			2
+#define CS43130_SP_SRATE_MASK			0x0F
+#define CS43130_SP_SRATE_SHIFT			0
+#define CS43130_SP_BITSIZE_ASP_MASK		0x03
+#define CS43130_SP_BITSIZE_ASP_SHIFT	0
+#define CS43130_HP_DETECT_CTRL_SHIFT            6
+#define CS43130_HP_DETECT_CTRL_MASK     (0x03 << CS43130_HP_DETECT_CTRL_SHIFT)
+#define CS43130_HP_DETECT_INV_SHIFT             5
+#define CS43130_HP_DETECT_INV_MASK      (1 << CS43130_HP_DETECT_INV_SHIFT)
+
+/* CS43130_INT_MASK_1 */
+#define CS43130_HP_PLUG_INT_SHIFT       6
+#define CS43130_HP_PLUG_INT             (1 << CS43130_HP_PLUG_INT_SHIFT)
+#define CS43130_HP_UNPLUG_INT_SHIFT     5
+#define CS43130_HP_UNPLUG_INT           (1 << CS43130_HP_UNPLUG_INT_SHIFT)
+#define CS43130_XTAL_RDY_INT_SHIFT      4
+#define CS43130_XTAL_RDY_INT            (1 << CS43130_XTAL_RDY_INT_SHIFT)
+#define CS43130_XTAL_ERR_INT_SHIFT      3
+#define CS43130_XTAL_ERR_INT            (1 << CS43130_XTAL_ERR_INT_SHIFT)
+
+/*Reg CS43130_SP_BITSIZE*/
+#define CS43130_SP_BIT_SIZE_8			0x00
+#define CS43130_SP_BIT_SIZE_16			0x01
+#define CS43130_SP_BIT_SIZE_24			0x02
+#define CS43130_SP_BIT_SIZE_32			0x03
+
+/*PLL*/
+#define CS43130_PLL_START_MASK (0x1<<0)
+#define CS43130_PLL_MODE_MASK  0x02
+#define CS43130_PLL_MODE_SHIFT 1
+
+#define CS43130_PLL_REF_PREDIV_MASK 0x3
+
+#define CS43130_ASP_STP_MASK	0x10
+#define CS43130_ASP_STP_SHIFT	4
+#define CS43130_ASP_5050_MASK	0x08
+#define CS43130_ASP_5050_SHIFT	3
+#define CS43130_ASP_FSD_MASK	0x07
+#define CS43130_ASP_FSD_SHIFT	0
+
+#define CS43130_ASP_MODE_MASK	0x10
+#define CS43130_ASP_MODE_SHIFT	4
+#define CS43130_ASP_SCPOL_OUT_MASK	0x08
+#define CS43130_ASP_SCPOL_OUT_SHIFT	3
+#define CS43130_ASP_SCPOL_IN_MASK	0x04
+#define CS43130_ASP_SCPOL_IN_SHIFT	2
+#define CS43130_ASP_LCPOL_OUT_MASK	0x02
+#define CS43130_ASP_LCPOL_OUT_SHIFT	1
+#define CS43130_ASP_LCPOL_IN_MASK	0x01
+#define CS43130_ASP_LCPOL_IN_SHIFT	0
+
+/*Reg CS43130_PWDN_CTL*/
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
+#define CS43130_7_0_MASK		0xFF
+#define CS43130_15_8_MASK		0xFF00
+#define CS43130_23_16_MASK		0xFF0000
+
+/* Reg CS43130_HP_OUT_CTL_1 */
+#define CS43130_HP_IN_EN_SHIFT		3
+#define CS43130_HP_IN_EN_MASK		0x08
+
+#define CS43130_ASP_FORMATS (SNDRV_PCM_FMTBIT_S8  | \
+			SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+#define CS43130_XSP_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
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
+	CS43130_MCLK_SRC_XTAL = 0,
+	CS43130_MCLK_SRC_PLL,
+	CS43130_MCLK_SRC_RCO
+};
+
+enum cs43130_mode {
+	CS43130_SLAVE_MODE = 0,
+	CS43130_MASTER_MODE
+};
+
+enum cs43130_xtal_ibias {
+	CS43130_XTAL_IBIAS_15UA = 2,
+	CS43130_XTAL_IBIAS_12_5UA = 4,
+	CS43130_XTAL_IBIAS_7_5UA = 6,
+};
+
+#define CS43130_AIF_BICK_RATE 1
+#define CS43130_SYSCLK_MCLK 1
+#define CS43130_NUM_SUPPLIES 5
+static const char *const cs43130_supply_names[CS43130_NUM_SUPPLIES] = {
+	"VA",
+	"VP",
+	"VCP",
+	"VD",
+	"VL",
+};
+
+#define CS43130_NUM_INT 5       /* number of interrupt status reg */
+
+struct	cs43130_private {
+	struct snd_soc_codec		*codec;
+	struct regmap			*regmap;
+	struct regulator_bulk_data supplies[CS43130_NUM_SUPPLIES];
+	/* codec device ID */
+	unsigned int dev_id;
+	int				mclk;
+	int				sclk;
+	int xtal_ibias;
+
+	bool pll_bypass;
+	int pll_out;
+	int mclk_int;
+	int dai_format;
+	int dai_mode;
+	int dai_bit;
+	int asp_size;
+	int fs;
+	bool bick_invert;
+	bool lrck_invert;
+	int bick;
+	struct gpio_desc *reset_gpio;
+};
+
+#endif	/* __CS43130_H__ */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
