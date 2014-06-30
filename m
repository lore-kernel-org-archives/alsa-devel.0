From: <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: add RT5670 CODEC driver
Date: Mon, 30 Jun 2014 20:31:13 +0800
Message-ID: <1404131473-4367-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8B9261A92
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:31:45 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch adds a minimum support of Realtek ALC5670 codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
Currently, only playback with headphone or line out and capture with 
digital mic are tested. We will add other patches for other functions.

This version do the following changes:
* Rename some widgets/controls.
* Merge all ASRC checking function to a single function.
* Change _MICBIAS to _SUPPLY
* Return error in unsupported slots or slot_width cases.
---
 include/sound/rt5670.h        |   27 +
 sound/soc/codecs/Kconfig      |    6 +
 sound/soc/codecs/Makefile     |    2 +
 sound/soc/codecs/rt5670-dsp.h |   54 +
 sound/soc/codecs/rt5670.c     | 2692 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5670.h     | 2000 ++++++++++++++++++++++++++++++
 6 files changed, 4781 insertions(+)
 create mode 100644 include/sound/rt5670.h
 create mode 100644 sound/soc/codecs/rt5670-dsp.h
 create mode 100644 sound/soc/codecs/rt5670.c
 create mode 100644 sound/soc/codecs/rt5670.h

diff --git a/include/sound/rt5670.h b/include/sound/rt5670.h
new file mode 100644
index 0000000..bd31119
--- /dev/null
+++ b/include/sound/rt5670.h
@@ -0,0 +1,27 @@
+/*
+ * linux/sound/rt5670.h -- Platform data for RT5670
+ *
+ * Copyright 2014 Realtek Microelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_RT5670_H
+#define __LINUX_SND_RT5670_H
+
+struct rt5670_platform_data {
+	int jd_mode;
+	bool in2_diff;
+
+	bool dmic_en;
+	unsigned int dmic1_data_pin;
+	/* 0 = GPIO6; 1 = IN2P; 3 = GPIO7*/
+	unsigned int dmic2_data_pin;
+	/* 0 = GPIO8; 1 = IN3N; */
+	unsigned int dmic3_data_pin;
+	/* 0 = GPIO9; 1 = GPIO10; 2 = GPIO5*/
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2fc38d4..85e3d78 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_RT5640 if I2C
 	select SND_SOC_RT5645 if I2C
 	select SND_SOC_RT5651 if I2C
+	select SND_SOC_RT5670 if I2C
 	select SND_SOC_RT5677 if I2C
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SI476X if MFD_SI476X_CORE
@@ -451,10 +452,12 @@ config SND_SOC_RL6231
 	default y if SND_SOC_RT5640=y
 	default y if SND_SOC_RT5645=y
 	default y if SND_SOC_RT5651=y
+	default y if SND_SOC_RT5670=y
 	default y if SND_SOC_RT5677=y
 	default m if SND_SOC_RT5640=m
 	default m if SND_SOC_RT5645=m
 	default m if SND_SOC_RT5651=m
+	default m if SND_SOC_RT5670=m
 	default m if SND_SOC_RT5677=m
 
 config SND_SOC_RT5631
@@ -469,6 +472,9 @@ config SND_SOC_RT5645
 config SND_SOC_RT5651
 	tristate
 
+config SND_SOC_RT5670
+	tristate
+
 config SND_SOC_RT5677
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 97b80a1..d87b08e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -73,6 +73,7 @@ snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
 snd-soc-rt5645-objs := rt5645.o
 snd-soc-rt5651-objs := rt5651.o
+snd-soc-rt5670-objs := rt5670.o
 snd-soc-rt5677-objs := rt5677.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
@@ -241,6 +242,7 @@ obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
 obj-$(CONFIG_SND_SOC_RT5645)	+= snd-soc-rt5645.o
 obj-$(CONFIG_SND_SOC_RT5651)	+= snd-soc-rt5651.o
+obj-$(CONFIG_SND_SOC_RT5670)	+= snd-soc-rt5670.o
 obj-$(CONFIG_SND_SOC_RT5677)	+= snd-soc-rt5677.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
diff --git a/sound/soc/codecs/rt5670-dsp.h b/sound/soc/codecs/rt5670-dsp.h
new file mode 100644
index 0000000..a34d0cd
--- /dev/null
+++ b/sound/soc/codecs/rt5670-dsp.h
@@ -0,0 +1,54 @@
+/*
+ * rt5670-dsp.h  --  RT5670 ALSA SoC DSP driver
+ *
+ * Copyright 2014 Realtek Microelectronics
+ * Author: Bard Liao <bardliao@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT5670_DSP_H__
+#define __RT5670_DSP_H__
+
+#define RT5670_DSP_CTRL1		0xe0
+#define RT5670_DSP_CTRL2		0xe1
+#define RT5670_DSP_CTRL3		0xe2
+#define RT5670_DSP_CTRL4		0xe3
+#define RT5670_DSP_CTRL5		0xe4
+
+/* DSP Control 1 (0xe0) */
+#define RT5670_DSP_CMD_MASK		(0xff << 8)
+#define RT5670_DSP_CMD_PE		(0x0d << 8)	/* Patch Entry */
+#define RT5670_DSP_CMD_MW		(0x3b << 8)	/* Memory Write */
+#define RT5670_DSP_CMD_MR		(0x37 << 8)	/* Memory Read */
+#define RT5670_DSP_CMD_RR		(0x60 << 8)	/* Register Read */
+#define RT5670_DSP_CMD_RW		(0x68 << 8)	/* Register Write */
+#define RT5670_DSP_REG_DATHI		(0x26 << 8)	/* High Data Addr */
+#define RT5670_DSP_REG_DATLO		(0x25 << 8)	/* Low Data Addr */
+#define RT5670_DSP_CLK_MASK		(0x3 << 6)
+#define RT5670_DSP_CLK_SFT		6
+#define RT5670_DSP_CLK_768K		(0x0 << 6)
+#define RT5670_DSP_CLK_384K		(0x1 << 6)
+#define RT5670_DSP_CLK_192K		(0x2 << 6)
+#define RT5670_DSP_CLK_96K		(0x3 << 6)
+#define RT5670_DSP_BUSY_MASK		(0x1 << 5)
+#define RT5670_DSP_RW_MASK		(0x1 << 4)
+#define RT5670_DSP_DL_MASK		(0x3 << 2)
+#define RT5670_DSP_DL_0			(0x0 << 2)
+#define RT5670_DSP_DL_1			(0x1 << 2)
+#define RT5670_DSP_DL_2			(0x2 << 2)
+#define RT5670_DSP_DL_3			(0x3 << 2)
+#define RT5670_DSP_I2C_AL_16		(0x1 << 1)
+#define RT5670_DSP_CMD_EN		(0x1)
+
+struct rt5670_dsp_param {
+	u16 cmd_fmt;
+	u16 addr;
+	u16 data;
+	u8 cmd;
+};
+
+#endif /* __RT5670_DSP_H__ */
+
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
new file mode 100644
index 0000000..879d42e
--- /dev/null
+++ b/sound/soc/codecs/rt5670.c
@@ -0,0 +1,2692 @@
+/*
+ * rt5670.c  --  RT5670 ALSA SoC audio codec driver
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
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/jack.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/rt5670.h>
+
+#include "rl6231.h"
+#include "rt5670.h"
+#include "rt5670-dsp.h"
+
+#define RT5670_DEVICE_ID 0x6271
+
+#define RT5670_PR_RANGE_BASE (0xff + 1)
+#define RT5670_PR_SPACING 0x100
+
+#define RT5670_PR_BASE (RT5670_PR_RANGE_BASE + (0 * RT5670_PR_SPACING))
+
+static const struct regmap_range_cfg rt5670_ranges[] = {
+	{ .name = "PR", .range_min = RT5670_PR_BASE,
+	  .range_max = RT5670_PR_BASE + 0xf8,
+	  .selector_reg = RT5670_PRIV_INDEX,
+	  .selector_mask = 0xff,
+	  .selector_shift = 0x0,
+	  .window_start = RT5670_PRIV_DATA,
+	  .window_len = 0x1, },
+};
+
+static struct reg_default init_list[] = {
+	{ RT5670_PR_BASE + 0x14, 0x9a8a },
+	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
+	{ RT5670_PR_BASE + 0x3d, 0x3640 },
+};
+#define RT5670_INIT_REG_LEN ARRAY_SIZE(init_list)
+
+static const struct reg_default rt5670_reg[] = {
+	{ 0x00, 0x0000 },
+	{ 0x02, 0x8888 },
+	{ 0x03, 0x8888 },
+	{ 0x0a, 0x0001 },
+	{ 0x0b, 0x0827 },
+	{ 0x0c, 0x0000 },
+	{ 0x0d, 0x0008 },
+	{ 0x0e, 0x0000 },
+	{ 0x0f, 0x0808 },
+	{ 0x19, 0xafaf },
+	{ 0x1a, 0xafaf },
+	{ 0x1b, 0x0011 },
+	{ 0x1c, 0x2f2f },
+	{ 0x1d, 0x2f2f },
+	{ 0x1e, 0x0000 },
+	{ 0x1f, 0x2f2f },
+	{ 0x20, 0x0000 },
+	{ 0x26, 0x7860 },
+	{ 0x27, 0x7860 },
+	{ 0x28, 0x7871 },
+	{ 0x29, 0x8080 },
+	{ 0x2a, 0x5656 },
+	{ 0x2b, 0x5454 },
+	{ 0x2c, 0xaaa0 },
+	{ 0x2d, 0x0000 },
+	{ 0x2e, 0x2f2f },
+	{ 0x2f, 0x1002 },
+	{ 0x30, 0x0000 },
+	{ 0x31, 0x5f00 },
+	{ 0x32, 0x0000 },
+	{ 0x33, 0x0000 },
+	{ 0x34, 0x0000 },
+	{ 0x35, 0x0000 },
+	{ 0x36, 0x0000 },
+	{ 0x37, 0x0000 },
+	{ 0x38, 0x0000 },
+	{ 0x3b, 0x0000 },
+	{ 0x3c, 0x007f },
+	{ 0x3d, 0x0000 },
+	{ 0x3e, 0x007f },
+	{ 0x45, 0xe00f },
+	{ 0x4c, 0x5380 },
+	{ 0x4f, 0x0073 },
+	{ 0x52, 0x00d3 },
+	{ 0x53, 0xf0f0 },
+	{ 0x61, 0x0000 },
+	{ 0x62, 0x0001 },
+	{ 0x63, 0x00c3 },
+	{ 0x64, 0x0000 },
+	{ 0x65, 0x0000 },
+	{ 0x66, 0x0000 },
+	{ 0x6f, 0x8000 },
+	{ 0x70, 0x8000 },
+	{ 0x71, 0x8000 },
+	{ 0x72, 0x8000 },
+	{ 0x73, 0x1110 },
+	{ 0x74, 0x0e00 },
+	{ 0x75, 0x1505 },
+	{ 0x76, 0x0015 },
+	{ 0x77, 0x0c00 },
+	{ 0x78, 0x4000 },
+	{ 0x79, 0x0123 },
+	{ 0x7f, 0x1100 },
+	{ 0x80, 0x0000 },
+	{ 0x81, 0x0000 },
+	{ 0x82, 0x0000 },
+	{ 0x83, 0x0000 },
+	{ 0x84, 0x0000 },
+	{ 0x85, 0x0000 },
+	{ 0x86, 0x0008 },
+	{ 0x87, 0x0000 },
+	{ 0x88, 0x0000 },
+	{ 0x89, 0x0000 },
+	{ 0x8a, 0x0000 },
+	{ 0x8b, 0x0000 },
+	{ 0x8c, 0x0007 },
+	{ 0x8d, 0x0000 },
+	{ 0x8e, 0x0004 },
+	{ 0x8f, 0x1100 },
+	{ 0x90, 0x0646 },
+	{ 0x91, 0x0c06 },
+	{ 0x93, 0x0000 },
+	{ 0x94, 0x0000 },
+	{ 0x95, 0x0000 },
+	{ 0x97, 0x0000 },
+	{ 0x98, 0x0000 },
+	{ 0x99, 0x0000 },
+	{ 0x9a, 0x2184 },
+	{ 0x9b, 0x010a },
+	{ 0x9c, 0x0aea },
+	{ 0x9d, 0x000c },
+	{ 0x9e, 0x0400 },
+	{ 0xae, 0x7000 },
+	{ 0xaf, 0x0000 },
+	{ 0xb0, 0x6000 },
+	{ 0xb1, 0x0000 },
+	{ 0xb2, 0x0000 },
+	{ 0xb3, 0x001f },
+	{ 0xb4, 0x2206 },
+	{ 0xb5, 0x1f00 },
+	{ 0xb6, 0x0000 },
+	{ 0xb7, 0x0000 },
+	{ 0xbb, 0x0000 },
+	{ 0xbc, 0x0000 },
+	{ 0xbd, 0x0000 },
+	{ 0xbe, 0x0000 },
+	{ 0xbf, 0x0000 },
+	{ 0xc0, 0x0000 },
+	{ 0xc1, 0x0000 },
+	{ 0xc2, 0x0000 },
+	{ 0xcd, 0x0000 },
+	{ 0xce, 0x0000 },
+	{ 0xcf, 0x1813 },
+	{ 0xd0, 0x0690 },
+	{ 0xd1, 0x1c17 },
+	{ 0xd3, 0xb320 },
+	{ 0xd4, 0x0000 },
+	{ 0xd6, 0x0400 },
+	{ 0xd9, 0x0809 },
+	{ 0xda, 0x0000 },
+	{ 0xdb, 0x0001 },
+	{ 0xdc, 0x0049 },
+	{ 0xdd, 0x0009 },
+	{ 0xe6, 0x8000 },
+	{ 0xe7, 0x0000 },
+	{ 0xec, 0xb300 },
+	{ 0xed, 0x0000 },
+	{ 0xee, 0xb300 },
+	{ 0xef, 0x0000 },
+	{ 0xf8, 0x0000 },
+	{ 0xf9, 0x0000 },
+	{ 0xfa, 0x8010 },
+	{ 0xfb, 0x0033 },
+	{ 0xfc, 0x0080 },
+};
+
+static bool rt5670_volatile_register(struct device *dev, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rt5670_ranges); i++) {
+		if ((reg >= rt5670_ranges[i].window_start &&
+		     reg <= rt5670_ranges[i].window_start +
+		     rt5670_ranges[i].window_len) ||
+		    (reg >= rt5670_ranges[i].range_min &&
+		     reg <= rt5670_ranges[i].range_max)) {
+			return true;
+		}
+	}
+
+	switch (reg) {
+	case RT5670_RESET:
+	case RT5670_PDM_DATA_CTRL1:
+	case RT5670_PDM1_DATA_CTRL4:
+	case RT5670_PDM2_DATA_CTRL4:
+	case RT5670_PRIV_DATA:
+	case RT5670_ASRC_5:
+	case RT5670_CJ_CTRL1:
+	case RT5670_CJ_CTRL2:
+	case RT5670_CJ_CTRL3:
+	case RT5670_A_JD_CTRL1:
+	case RT5670_A_JD_CTRL2:
+	case RT5670_VAD_CTRL5:
+	case RT5670_ADC_EQ_CTRL1:
+	case RT5670_EQ_CTRL1:
+	case RT5670_ALC_CTRL_1:
+	case RT5670_IRQ_CTRL1:
+	case RT5670_IRQ_CTRL2:
+	case RT5670_INT_IRQ_ST:
+	case RT5670_IL_CMD:
+	case RT5670_DSP_CTRL1:
+	case RT5670_DSP_CTRL2:
+	case RT5670_DSP_CTRL3:
+	case RT5670_DSP_CTRL4:
+	case RT5670_DSP_CTRL5:
+	case RT5670_VENDOR_ID:
+	case RT5670_VENDOR_ID1:
+	case RT5670_VENDOR_ID2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt5670_readable_register(struct device *dev, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rt5670_ranges); i++) {
+		if ((reg >= rt5670_ranges[i].window_start &&
+		     reg <= rt5670_ranges[i].window_start +
+		     rt5670_ranges[i].window_len) ||
+		    (reg >= rt5670_ranges[i].range_min &&
+		     reg <= rt5670_ranges[i].range_max)) {
+			return true;
+		}
+	}
+
+	switch (reg) {
+	case RT5670_RESET:
+	case RT5670_HP_VOL:
+	case RT5670_LOUT1:
+	case RT5670_CJ_CTRL1:
+	case RT5670_CJ_CTRL2:
+	case RT5670_CJ_CTRL3:
+	case RT5670_IN2:
+	case RT5670_INL1_INR1_VOL:
+	case RT5670_DAC1_DIG_VOL:
+	case RT5670_DAC2_DIG_VOL:
+	case RT5670_DAC_CTRL:
+	case RT5670_STO1_ADC_DIG_VOL:
+	case RT5670_MONO_ADC_DIG_VOL:
+	case RT5670_STO2_ADC_DIG_VOL:
+	case RT5670_ADC_BST_VOL1:
+	case RT5670_ADC_BST_VOL2:
+	case RT5670_STO2_ADC_MIXER:
+	case RT5670_STO1_ADC_MIXER:
+	case RT5670_MONO_ADC_MIXER:
+	case RT5670_AD_DA_MIXER:
+	case RT5670_STO_DAC_MIXER:
+	case RT5670_DD_MIXER:
+	case RT5670_DIG_MIXER:
+	case RT5670_DSP_PATH1:
+	case RT5670_DSP_PATH2:
+	case RT5670_DIG_INF1_DATA:
+	case RT5670_DIG_INF2_DATA:
+	case RT5670_PDM_OUT_CTRL:
+	case RT5670_PDM_DATA_CTRL1:
+	case RT5670_PDM1_DATA_CTRL2:
+	case RT5670_PDM1_DATA_CTRL3:
+	case RT5670_PDM1_DATA_CTRL4:
+	case RT5670_PDM2_DATA_CTRL2:
+	case RT5670_PDM2_DATA_CTRL3:
+	case RT5670_PDM2_DATA_CTRL4:
+	case RT5670_REC_L1_MIXER:
+	case RT5670_REC_L2_MIXER:
+	case RT5670_REC_R1_MIXER:
+	case RT5670_REC_R2_MIXER:
+	case RT5670_HPO_MIXER:
+	case RT5670_MONO_MIXER:
+	case RT5670_OUT_L1_MIXER:
+	case RT5670_OUT_R1_MIXER:
+	case RT5670_LOUT_MIXER:
+	case RT5670_PWR_DIG1:
+	case RT5670_PWR_DIG2:
+	case RT5670_PWR_ANLG1:
+	case RT5670_PWR_ANLG2:
+	case RT5670_PWR_MIXER:
+	case RT5670_PWR_VOL:
+	case RT5670_PRIV_INDEX:
+	case RT5670_PRIV_DATA:
+	case RT5670_I2S4_SDP:
+	case RT5670_I2S1_SDP:
+	case RT5670_I2S2_SDP:
+	case RT5670_I2S3_SDP:
+	case RT5670_ADDA_CLK1:
+	case RT5670_ADDA_CLK2:
+	case RT5670_DMIC_CTRL1:
+	case RT5670_DMIC_CTRL2:
+	case RT5670_TDM_CTRL_1:
+	case RT5670_TDM_CTRL_2:
+	case RT5670_TDM_CTRL_3:
+	case RT5670_DSP_CLK:
+	case RT5670_GLB_CLK:
+	case RT5670_PLL_CTRL1:
+	case RT5670_PLL_CTRL2:
+	case RT5670_ASRC_1:
+	case RT5670_ASRC_2:
+	case RT5670_ASRC_3:
+	case RT5670_ASRC_4:
+	case RT5670_ASRC_5:
+	case RT5670_ASRC_7:
+	case RT5670_ASRC_8:
+	case RT5670_ASRC_9:
+	case RT5670_ASRC_10:
+	case RT5670_ASRC_11:
+	case RT5670_ASRC_12:
+	case RT5670_ASRC_13:
+	case RT5670_ASRC_14:
+	case RT5670_DEPOP_M1:
+	case RT5670_DEPOP_M2:
+	case RT5670_DEPOP_M3:
+	case RT5670_CHARGE_PUMP:
+	case RT5670_MICBIAS:
+	case RT5670_A_JD_CTRL1:
+	case RT5670_A_JD_CTRL2:
+	case RT5670_VAD_CTRL1:
+	case RT5670_VAD_CTRL2:
+	case RT5670_VAD_CTRL3:
+	case RT5670_VAD_CTRL4:
+	case RT5670_VAD_CTRL5:
+	case RT5670_ADC_EQ_CTRL1:
+	case RT5670_ADC_EQ_CTRL2:
+	case RT5670_EQ_CTRL1:
+	case RT5670_EQ_CTRL2:
+	case RT5670_ALC_DRC_CTRL1:
+	case RT5670_ALC_DRC_CTRL2:
+	case RT5670_ALC_CTRL_1:
+	case RT5670_ALC_CTRL_2:
+	case RT5670_ALC_CTRL_3:
+	case RT5670_JD_CTRL:
+	case RT5670_IRQ_CTRL1:
+	case RT5670_IRQ_CTRL2:
+	case RT5670_INT_IRQ_ST:
+	case RT5670_GPIO_CTRL1:
+	case RT5670_GPIO_CTRL2:
+	case RT5670_GPIO_CTRL3:
+	case RT5670_SCRABBLE_FUN:
+	case RT5670_SCRABBLE_CTRL:
+	case RT5670_BASE_BACK:
+	case RT5670_MP3_PLUS1:
+	case RT5670_MP3_PLUS2:
+	case RT5670_ADJ_HPF1:
+	case RT5670_ADJ_HPF2:
+	case RT5670_HP_CALIB_AMP_DET:
+	case RT5670_SV_ZCD1:
+	case RT5670_SV_ZCD2:
+	case RT5670_IL_CMD:
+	case RT5670_IL_CMD2:
+	case RT5670_IL_CMD3:
+	case RT5670_DRC_HL_CTRL1:
+	case RT5670_DRC_HL_CTRL2:
+	case RT5670_ADC_MONO_HP_CTRL1:
+	case RT5670_ADC_MONO_HP_CTRL2:
+	case RT5670_ADC_STO2_HP_CTRL1:
+	case RT5670_ADC_STO2_HP_CTRL2:
+	case RT5670_JD_CTRL3:
+	case RT5670_JD_CTRL4:
+	case RT5670_DIG_MISC:
+	case RT5670_DSP_CTRL1:
+	case RT5670_DSP_CTRL2:
+	case RT5670_DSP_CTRL3:
+	case RT5670_DSP_CTRL4:
+	case RT5670_DSP_CTRL5:
+	case RT5670_GEN_CTRL2:
+	case RT5670_GEN_CTRL3:
+	case RT5670_VENDOR_ID:
+	case RT5670_VENDOR_ID1:
+	case RT5670_VENDOR_ID2:
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
+static const char * const rt5670_data_select[] = {
+	"Normal", "Swap", "left copy to right", "right copy to left"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_if2_dac_enum, RT5670_DIG_INF1_DATA,
+				RT5670_IF2_DAC_SEL_SFT, rt5670_data_select);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_enum, RT5670_DIG_INF1_DATA,
+				RT5670_IF2_ADC_SEL_SFT, rt5670_data_select);
+
+static const struct snd_kcontrol_new rt5670_snd_controls[] = {
+	/* Headphone Output Volume */
+	SOC_DOUBLE("HP Playback Switch", RT5670_HP_VOL,
+		RT5670_L_MUTE_SFT, RT5670_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE_TLV("HP Playback Volume", RT5670_HP_VOL,
+		RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
+		39, 0, out_vol_tlv),
+	/* OUTPUT Control */
+	SOC_DOUBLE("OUT Channel Switch", RT5670_LOUT1,
+		RT5670_VOL_L_SFT, RT5670_VOL_R_SFT, 1, 1),
+	SOC_DOUBLE_TLV("OUT Playback Volume", RT5670_LOUT1,
+		RT5670_L_VOL_SFT, RT5670_R_VOL_SFT, 39, 1, out_vol_tlv),
+	/* DAC Digital Volume */
+	SOC_DOUBLE("DAC2 Playback Switch", RT5670_DAC_CTRL,
+		RT5670_M_DAC_L2_VOL_SFT, RT5670_M_DAC_R2_VOL_SFT, 1, 1),
+	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5670_DAC1_DIG_VOL,
+			RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
+			175, 0, dac_vol_tlv),
+	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5670_DAC2_DIG_VOL,
+			RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
+			175, 0, dac_vol_tlv),
+	/* IN1/IN2 Control */
+	SOC_SINGLE_TLV("IN1 Boost Volume", RT5670_CJ_CTRL1,
+		RT5670_BST_SFT1, 8, 0, bst_tlv),
+	SOC_SINGLE_TLV("IN2 Boost Volume", RT5670_IN2,
+		RT5670_BST_SFT1, 8, 0, bst_tlv),
+	/* INL/INR Volume Control */
+	SOC_DOUBLE_TLV("IN Capture Volume", RT5670_INL1_INR1_VOL,
+			RT5670_INL_VOL_SFT, RT5670_INR_VOL_SFT,
+			31, 1, in_vol_tlv),
+	/* ADC Digital Volume Control */
+	SOC_DOUBLE("ADC Capture Switch", RT5670_STO1_ADC_DIG_VOL,
+		RT5670_L_MUTE_SFT, RT5670_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE_TLV("ADC Capture Volume", RT5670_STO1_ADC_DIG_VOL,
+			RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
+			127, 0, adc_vol_tlv),
+
+	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5670_MONO_ADC_DIG_VOL,
+			RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
+			127, 0, adc_vol_tlv),
+
+	/* ADC Boost Volume Control */
+	SOC_DOUBLE_TLV("STO1 ADC Boost Gain Volume", RT5670_ADC_BST_VOL1,
+			RT5670_STO1_ADC_L_BST_SFT, RT5670_STO1_ADC_R_BST_SFT,
+			3, 0, adc_bst_tlv),
+
+	SOC_DOUBLE_TLV("STO2 ADC Boost Gain Volume", RT5670_ADC_BST_VOL1,
+			RT5670_STO2_ADC_L_BST_SFT, RT5670_STO2_ADC_R_BST_SFT,
+			3, 0, adc_bst_tlv),
+
+	SOC_ENUM("ADC IF2 Data Switch", rt5670_if2_adc_enum),
+	SOC_ENUM("DAC IF2 Data Switch", rt5670_if2_dac_enum),
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
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+	int idx = -EINVAL;
+
+	idx = rl6231_calc_dmic_clk(rt5670->sysclk);
+
+	if (idx < 0)
+		dev_err(codec->dev, "Failed to set DMIC clock\n");
+	else
+		snd_soc_update_bits(codec, RT5670_DMIC_CTRL1,
+			RT5670_DMIC_CLK_MASK, idx << RT5670_DMIC_CLK_SFT);
+	return idx;
+}
+
+static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	unsigned int val;
+
+	val = snd_soc_read(source->codec, RT5670_GLB_CLK);
+	val &= RT5670_SCLK_SRC_MASK;
+	if (val == RT5670_SCLK_SRC_PLL1)
+		return 1;
+	else
+		return 0;
+}
+
+static int is_using_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	unsigned int reg, shift, val;
+
+	switch (source->shift) {
+	case 0:
+		reg = RT5670_ASRC_3;
+		shift = 0;
+		break;
+	case 1:
+		reg = RT5670_ASRC_3;
+		shift = 4;
+		break;
+	case 2:
+		reg = RT5670_ASRC_5;
+		shift = 12;
+		break;
+	case 3:
+		reg = RT5670_ASRC_2;
+		shift = 0;
+		break;
+	case 8:
+		reg = RT5670_ASRC_2;
+		shift = 4;
+		break;
+	case 9:
+		reg = RT5670_ASRC_2;
+		shift = 8;
+		break;
+	case 10:
+		reg = RT5670_ASRC_2;
+		shift = 12;
+		break;
+	default:
+		return 0;
+	}
+
+	val = (snd_soc_read(source->codec, reg) >> shift) & 0xf;
+	switch (val) {
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		return 1;
+	default:
+		return 0;
+	}
+
+}
+
+/* Digital Mixer */
+static const struct snd_kcontrol_new rt5670_sto1_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_STO1_ADC_MIXER,
+			RT5670_M_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5670_STO1_ADC_MIXER,
+			RT5670_M_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_sto1_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_STO1_ADC_MIXER,
+			RT5670_M_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5670_STO1_ADC_MIXER,
+			RT5670_M_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_STO2_ADC_MIXER,
+			RT5670_M_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5670_STO2_ADC_MIXER,
+			RT5670_M_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_STO2_ADC_MIXER,
+			RT5670_M_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5670_STO2_ADC_MIXER,
+			RT5670_M_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_mono_adc_l_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_MONO_ADC_MIXER,
+			RT5670_M_MONO_ADC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5670_MONO_ADC_MIXER,
+			RT5670_M_MONO_ADC_L2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_mono_adc_r_mix[] = {
+	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_MONO_ADC_MIXER,
+			RT5670_M_MONO_ADC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("ADC2 Switch", RT5670_MONO_ADC_MIXER,
+			RT5670_M_MONO_ADC_R2_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5670_AD_DA_MIXER,
+			RT5670_M_ADCMIX_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC1 Switch", RT5670_AD_DA_MIXER,
+			RT5670_M_DAC1_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5670_AD_DA_MIXER,
+			RT5670_M_ADCMIX_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC1 Switch", RT5670_AD_DA_MIXER,
+			RT5670_M_DAC1_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_sto_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_STO_DAC_MIXER,
+			RT5670_M_DAC_L1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5670_STO_DAC_MIXER,
+			RT5670_M_DAC_L2_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_STO_DAC_MIXER,
+			RT5670_M_DAC_R1_STO_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_sto_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_STO_DAC_MIXER,
+			RT5670_M_DAC_R1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5670_STO_DAC_MIXER,
+			RT5670_M_DAC_R2_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_STO_DAC_MIXER,
+			RT5670_M_DAC_L1_STO_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_mono_dac_l_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_DD_MIXER,
+			RT5670_M_DAC_L1_MONO_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5670_DD_MIXER,
+			RT5670_M_DAC_L2_MONO_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5670_DD_MIXER,
+			RT5670_M_DAC_R2_MONO_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_mono_dac_r_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_DD_MIXER,
+			RT5670_M_DAC_R1_MONO_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5670_DD_MIXER,
+			RT5670_M_DAC_R2_MONO_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5670_DD_MIXER,
+			RT5670_M_DAC_L2_MONO_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_dig_l_mix[] = {
+	SOC_DAPM_SINGLE("Sto DAC Mix L Switch", RT5670_DIG_MIXER,
+			RT5670_M_STO_L_DAC_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5670_DIG_MIXER,
+			RT5670_M_DAC_L2_DAC_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5670_DIG_MIXER,
+			RT5670_M_DAC_R2_DAC_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_dig_r_mix[] = {
+	SOC_DAPM_SINGLE("Sto DAC Mix R Switch", RT5670_DIG_MIXER,
+			RT5670_M_STO_R_DAC_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5670_DIG_MIXER,
+			RT5670_M_DAC_R2_DAC_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5670_DIG_MIXER,
+			RT5670_M_DAC_L2_DAC_R_SFT, 1, 1),
+};
+
+/* Analog Input Mixer */
+static const struct snd_kcontrol_new rt5670_rec_l_mix[] = {
+	SOC_DAPM_SINGLE("INL Switch", RT5670_REC_L2_MIXER,
+			RT5670_M_IN_L_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5670_REC_L2_MIXER,
+			RT5670_M_BST2_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5670_REC_L2_MIXER,
+			RT5670_M_BST1_RM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_rec_r_mix[] = {
+	SOC_DAPM_SINGLE("INR Switch", RT5670_REC_R2_MIXER,
+			RT5670_M_IN_R_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST2 Switch", RT5670_REC_R2_MIXER,
+			RT5670_M_BST2_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST1 Switch", RT5670_REC_R2_MIXER,
+			RT5670_M_BST1_RM_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_out_l_mix[] = {
+	SOC_DAPM_SINGLE("BST1 Switch", RT5670_OUT_L1_MIXER,
+			RT5670_M_BST1_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL Switch", RT5670_OUT_L1_MIXER,
+			RT5670_M_IN_L_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L2 Switch", RT5670_OUT_L1_MIXER,
+			RT5670_M_DAC_L2_OM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_OUT_L1_MIXER,
+			RT5670_M_DAC_L1_OM_L_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_out_r_mix[] = {
+	SOC_DAPM_SINGLE("BST2 Switch", RT5670_OUT_R1_MIXER,
+			RT5670_M_BST2_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR Switch", RT5670_OUT_R1_MIXER,
+			RT5670_M_IN_R_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R2 Switch", RT5670_OUT_R1_MIXER,
+			RT5670_M_DAC_R2_OM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_OUT_R1_MIXER,
+			RT5670_M_DAC_R1_OM_R_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_hpo_mix[] = {
+	SOC_DAPM_SINGLE("DAC1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_DAC1_HM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("HPVOL Switch", RT5670_HPO_MIXER,
+			RT5670_M_HPVOL_HM_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_hpvoll_mix[] = {
+	SOC_DAPM_SINGLE("DAC1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_DACL1_HML_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL Switch", RT5670_HPO_MIXER,
+			RT5670_M_INL1_HML_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_hpvolr_mix[] = {
+	SOC_DAPM_SINGLE("DAC1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_DACR1_HMR_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR Switch", RT5670_HPO_MIXER,
+			RT5670_M_INR1_HMR_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_lout_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_LOUT_MIXER,
+			RT5670_M_DAC_L1_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_LOUT_MIXER,
+			RT5670_M_DAC_R1_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUTMIX L Switch", RT5670_LOUT_MIXER,
+			RT5670_M_OV_L_LM_SFT, 1, 1),
+	SOC_DAPM_SINGLE("OUTMIX R Switch", RT5670_LOUT_MIXER,
+			RT5670_M_OV_R_LM_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_hpl_mix[] = {
+	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_DACL1_HML_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INL1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_INL1_HML_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new rt5670_hpr_mix[] = {
+	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_DACR1_HMR_SFT, 1, 1),
+	SOC_DAPM_SINGLE("INR1 Switch", RT5670_HPO_MIXER,
+			RT5670_M_INR1_HMR_SFT, 1, 1),
+};
+
+static const struct snd_kcontrol_new lout_l_enable_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5670_LOUT1,
+		RT5670_L_MUTE_SFT, 1, 1);
+
+static const struct snd_kcontrol_new lout_r_enable_control =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5670_LOUT1,
+		RT5670_R_MUTE_SFT, 1, 1);
+
+/* DAC1 L/R source */ /* MX-29 [9:8] [11:10] */
+static const char * const rt5670_dac1_src[] = {
+	"IF1 DAC", "IF2 DAC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_dac1l_enum, RT5670_AD_DA_MIXER,
+	RT5670_DAC1_L_SEL_SFT, rt5670_dac1_src);
+
+static const struct snd_kcontrol_new rt5670_dac1l_mux =
+	SOC_DAPM_ENUM("DAC1 L source", rt5670_dac1l_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_dac1r_enum, RT5670_AD_DA_MIXER,
+	RT5670_DAC1_R_SEL_SFT, rt5670_dac1_src);
+
+static const struct snd_kcontrol_new rt5670_dac1r_mux =
+	SOC_DAPM_ENUM("DAC1 R source", rt5670_dac1r_enum);
+
+/*DAC2 L/R source*/ /* MX-1B [6:4] [2:0] */
+/* TODO Use SOC_VALUE_ENUM_SINGLE_DECL */
+static const char * const rt5670_dac12_src[] = {
+	"IF1 DAC", "IF2 DAC", "IF3 DAC", "TxDC DAC",
+	"Bass", "VAD_ADC", "IF4 DAC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_dac2l_enum, RT5670_DAC_CTRL,
+	RT5670_DAC2_L_SEL_SFT, rt5670_dac12_src);
+
+static const struct snd_kcontrol_new rt5670_dac_l2_mux =
+	SOC_DAPM_ENUM("DAC2 L source", rt5670_dac2l_enum);
+
+static const char * const rt5670_dacr2_src[] = {
+	"IF1 DAC", "IF2 DAC", "IF3 DAC", "TxDC DAC", "TxDP ADC", "IF4 DAC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_dac2r_enum, RT5670_DAC_CTRL,
+	RT5670_DAC2_R_SEL_SFT, rt5670_dacr2_src);
+
+static const struct snd_kcontrol_new rt5670_dac_r2_mux =
+	SOC_DAPM_ENUM("DAC2 R source", rt5670_dac2r_enum);
+
+/*RxDP source*/ /* MX-2D [15:13] */
+static const char * const rt5670_rxdp_src[] = {
+	"IF2 DAC", "IF1 DAC", "STO1 ADC Mixer", "STO2 ADC Mixer",
+	"Mono ADC Mixer L", "Mono ADC Mixer R", "DAC1"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_rxdp_enum, RT5670_DSP_PATH1,
+	RT5670_RXDP_SEL_SFT, rt5670_rxdp_src);
+
+static const struct snd_kcontrol_new rt5670_rxdp_mux =
+	SOC_DAPM_ENUM("DAC2 L source", rt5670_rxdp_enum);
+
+/* MX-2D [1] [0] */
+static const char * const rt5670_dsp_bypass_src[] = {
+	"DSP", "Bypass"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_dsp_ul_enum, RT5670_DSP_PATH1,
+	RT5670_DSP_UL_SFT, rt5670_dsp_bypass_src);
+
+static const struct snd_kcontrol_new rt5670_dsp_ul_mux =
+	SOC_DAPM_ENUM("DSP UL source", rt5670_dsp_ul_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_dsp_dl_enum, RT5670_DSP_PATH1,
+	RT5670_DSP_DL_SFT, rt5670_dsp_bypass_src);
+
+static const struct snd_kcontrol_new rt5670_dsp_dl_mux =
+	SOC_DAPM_ENUM("DSP DL source", rt5670_dsp_dl_enum);
+
+/* Stereo2 ADC source */
+/* MX-26 [15] */
+static const char * const rt5670_stereo2_adc_lr_src[] = {
+	"L", "LR"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo2_adc_lr_enum, RT5670_STO2_ADC_MIXER,
+	RT5670_STO2_ADC_SRC_SFT, rt5670_stereo2_adc_lr_src);
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_lr_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC LR source", rt5670_stereo2_adc_lr_enum);
+
+/* Stereo1 ADC source */
+/* MX-27 MX-26 [12] */
+static const char * const rt5670_stereo_adc1_src[] = {
+	"DAC MIX", "ADC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo1_adc1_enum, RT5670_STO1_ADC_MIXER,
+	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
+
+static const struct snd_kcontrol_new rt5670_sto_adc_l1_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC L1 source", rt5670_stereo1_adc1_enum);
+
+static const struct snd_kcontrol_new rt5670_sto_adc_r1_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC R1 source", rt5670_stereo1_adc1_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo2_adc1_enum, RT5670_STO2_ADC_MIXER,
+	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_l1_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC L1 source", rt5670_stereo2_adc1_enum);
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_r1_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC R1 source", rt5670_stereo2_adc1_enum);
+
+/* MX-27 MX-26 [11] */
+static const char * const rt5670_stereo_adc2_src[] = {
+	"DAC MIX", "DMIC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo1_adc2_enum, RT5670_STO1_ADC_MIXER,
+	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
+
+static const struct snd_kcontrol_new rt5670_sto_adc_l2_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC L2 source", rt5670_stereo1_adc2_enum);
+
+static const struct snd_kcontrol_new rt5670_sto_adc_r2_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC R2 source", rt5670_stereo1_adc2_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
+	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_l2_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC L2 source", rt5670_stereo2_adc2_enum);
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_r2_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC R2 source", rt5670_stereo2_adc2_enum);
+
+/* MX-27 MX26 [10] */
+static const char * const rt5670_stereo_adc_src[] = {
+	"ADC1L ADC2R", "ADC3"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo1_adc_enum, RT5670_STO1_ADC_MIXER,
+	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
+
+static const struct snd_kcontrol_new rt5670_sto_adc_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC source", rt5670_stereo1_adc_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo2_adc_enum, RT5670_STO2_ADC_MIXER,
+	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
+
+static const struct snd_kcontrol_new rt5670_sto2_adc_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC source", rt5670_stereo2_adc_enum);
+
+/* MX-27 MX-26 [9:8] */
+static const char * const rt5670_stereo_dmic_src[] = {
+	"DMIC1", "DMIC2", "DMIC3"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo1_dmic_enum, RT5670_STO1_ADC_MIXER,
+	RT5670_DMIC_SRC_SFT, rt5670_stereo_dmic_src);
+
+static const struct snd_kcontrol_new rt5670_sto1_dmic_mux =
+	SOC_DAPM_ENUM("Stereo1 DMIC source", rt5670_stereo1_dmic_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo2_dmic_enum, RT5670_STO2_ADC_MIXER,
+	RT5670_DMIC_SRC_SFT, rt5670_stereo_dmic_src);
+
+static const struct snd_kcontrol_new rt5670_sto2_dmic_mux =
+	SOC_DAPM_ENUM("Stereo2 DMIC source", rt5670_stereo2_dmic_enum);
+
+/* MX-27 [0] */
+static const char * const rt5670_stereo_dmic3_src[] = {
+	"DMIC3", "PDM ADC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_stereo_dmic3_enum, RT5670_STO1_ADC_MIXER,
+	RT5670_DMIC3_SRC_SFT, rt5670_stereo_dmic3_src);
+
+static const struct snd_kcontrol_new rt5670_sto_dmic3_mux =
+	SOC_DAPM_ENUM("Stereo DMIC3 source", rt5670_stereo_dmic3_enum);
+
+/* Mono ADC source */
+/* MX-28 [12] */
+static const char * const rt5670_mono_adc_l1_src[] = {
+	"Mono DAC MIXL", "ADC1"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_mono_adc_l1_enum, RT5670_MONO_ADC_MIXER,
+	RT5670_MONO_ADC_L1_SRC_SFT, rt5670_mono_adc_l1_src);
+
+static const struct snd_kcontrol_new rt5670_mono_adc_l1_mux =
+	SOC_DAPM_ENUM("Mono ADC1 left source", rt5670_mono_adc_l1_enum);
+/* MX-28 [11] */
+static const char * const rt5670_mono_adc_l2_src[] = {
+	"Mono DAC MIXL", "DMIC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_mono_adc_l2_enum, RT5670_MONO_ADC_MIXER,
+	RT5670_MONO_ADC_L2_SRC_SFT, rt5670_mono_adc_l2_src);
+
+static const struct snd_kcontrol_new rt5670_mono_adc_l2_mux =
+	SOC_DAPM_ENUM("Mono ADC2 left source", rt5670_mono_adc_l2_enum);
+
+/* MX-28 [9:8] */
+static const char * const rt5670_mono_dmic_src[] = {
+	"DMIC1", "DMIC2", "DMIC3"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_mono_dmic_l_enum, RT5670_MONO_ADC_MIXER,
+	RT5670_MONO_DMIC_L_SRC_SFT, rt5670_mono_dmic_src);
+
+static const struct snd_kcontrol_new rt5670_mono_dmic_l_mux =
+	SOC_DAPM_ENUM("Mono DMIC left source", rt5670_mono_dmic_l_enum);
+/* MX-28 [1:0] */
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_mono_dmic_r_enum, RT5670_MONO_ADC_MIXER,
+	RT5670_MONO_DMIC_R_SRC_SFT, rt5670_mono_dmic_src);
+
+static const struct snd_kcontrol_new rt5670_mono_dmic_r_mux =
+	SOC_DAPM_ENUM("Mono DMIC Right source", rt5670_mono_dmic_r_enum);
+/* MX-28 [4] */
+static const char * const rt5670_mono_adc_r1_src[] = {
+	"Mono DAC MIXR", "ADC2"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_mono_adc_r1_enum, RT5670_MONO_ADC_MIXER,
+	RT5670_MONO_ADC_R1_SRC_SFT, rt5670_mono_adc_r1_src);
+
+static const struct snd_kcontrol_new rt5670_mono_adc_r1_mux =
+	SOC_DAPM_ENUM("Mono ADC1 right source", rt5670_mono_adc_r1_enum);
+/* MX-28 [3] */
+static const char * const rt5670_mono_adc_r2_src[] = {
+	"Mono DAC MIXR", "DMIC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_mono_adc_r2_enum, RT5670_MONO_ADC_MIXER,
+	RT5670_MONO_ADC_R2_SRC_SFT, rt5670_mono_adc_r2_src);
+
+static const struct snd_kcontrol_new rt5670_mono_adc_r2_mux =
+	SOC_DAPM_ENUM("Mono ADC2 right source", rt5670_mono_adc_r2_enum);
+
+/* MX-2D [3:2] */
+static const char * const rt5670_txdp_slot_src[] = {
+	"Slot 0-1", "Slot 2-3", "Slot 4-5", "Slot 6-7"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_txdp_slot_enum, RT5670_DSP_PATH1,
+	RT5670_TXDP_SLOT_SEL_SFT, rt5670_txdp_slot_src);
+
+static const struct snd_kcontrol_new rt5670_txdp_slot_mux =
+	SOC_DAPM_ENUM("TxDP Slot source", rt5670_txdp_slot_enum);
+
+/* MX-2F [15] */
+static const char * const rt5670_if1_adc2_in_src[] = {
+	"IF_ADC2", "VAD_ADC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_if1_adc2_in_enum, RT5670_DIG_INF1_DATA,
+	RT5670_IF1_ADC2_IN_SFT, rt5670_if1_adc2_in_src);
+
+static const struct snd_kcontrol_new rt5670_if1_adc2_in_mux =
+	SOC_DAPM_ENUM("IF1 ADC2 IN source", rt5670_if1_adc2_in_enum);
+
+/* MX-2F [14:12] */
+static const char * const rt5670_if2_adc_in_src[] = {
+	"IF_ADC1", "IF_ADC2", "IF_ADC3", "TxDC_DAC", "TxDP_ADC", "VAD_ADC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_if2_adc_in_enum, RT5670_DIG_INF1_DATA,
+	RT5670_IF2_ADC_IN_SFT, rt5670_if2_adc_in_src);
+
+static const struct snd_kcontrol_new rt5670_if2_adc_in_mux =
+	SOC_DAPM_ENUM("IF2 ADC IN source", rt5670_if2_adc_in_enum);
+
+/* MX-30 [5:4] */
+static const char * const rt5670_if4_adc_in_src[] = {
+	"IF_ADC1", "IF_ADC2", "IF_ADC3"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_if4_adc_in_enum, RT5670_DIG_INF2_DATA,
+	RT5670_IF4_ADC_IN_SFT, rt5670_if4_adc_in_src);
+
+static const struct snd_kcontrol_new rt5670_if4_adc_in_mux =
+	SOC_DAPM_ENUM("IF4 ADC IN source", rt5670_if4_adc_in_enum);
+
+/* MX-31 [15] [13] [11] [9] */
+static const char * const rt5670_pdm_src[] = {
+	"Mono DAC", "Stereo DAC"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_pdm1_l_enum, RT5670_PDM_OUT_CTRL,
+	RT5670_PDM1_L_SFT, rt5670_pdm_src);
+
+static const struct snd_kcontrol_new rt5670_pdm1_l_mux =
+	SOC_DAPM_ENUM("PDM1 L source", rt5670_pdm1_l_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_pdm1_r_enum, RT5670_PDM_OUT_CTRL,
+	RT5670_PDM1_R_SFT, rt5670_pdm_src);
+
+static const struct snd_kcontrol_new rt5670_pdm1_r_mux =
+	SOC_DAPM_ENUM("PDM1 R source", rt5670_pdm1_r_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_pdm2_l_enum, RT5670_PDM_OUT_CTRL,
+	RT5670_PDM2_L_SFT, rt5670_pdm_src);
+
+static const struct snd_kcontrol_new rt5670_pdm2_l_mux =
+	SOC_DAPM_ENUM("PDM2 L source", rt5670_pdm2_l_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_pdm2_r_enum, RT5670_PDM_OUT_CTRL,
+	RT5670_PDM2_R_SFT, rt5670_pdm_src);
+
+static const struct snd_kcontrol_new rt5670_pdm2_r_mux =
+	SOC_DAPM_ENUM("PDM2 R source", rt5670_pdm2_r_enum);
+
+/* MX-FA [12] */
+static const char * const rt5670_if1_adc1_in1_src[] = {
+	"IF_ADC1", "IF1_ADC3"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_if1_adc1_in1_enum, RT5670_DIG_MISC,
+	RT5670_IF1_ADC1_IN1_SFT, rt5670_if1_adc1_in1_src);
+
+static const struct snd_kcontrol_new rt5670_if1_adc1_in1_mux =
+	SOC_DAPM_ENUM("IF1 ADC1 IN1 source", rt5670_if1_adc1_in1_enum);
+
+/* MX-FA [11] */
+static const char * const rt5670_if1_adc1_in2_src[] = {
+	"IF1_ADC1_IN1", "IF1_ADC4"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_if1_adc1_in2_enum, RT5670_DIG_MISC,
+	RT5670_IF1_ADC1_IN2_SFT, rt5670_if1_adc1_in2_src);
+
+static const struct snd_kcontrol_new rt5670_if1_adc1_in2_mux =
+	SOC_DAPM_ENUM("IF1 ADC1 IN2 source", rt5670_if1_adc1_in2_enum);
+
+/* MX-FA [10] */
+static const char * const rt5670_if1_adc2_in1_src[] = {
+	"IF1_ADC2_IN", "IF1_ADC4"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_if1_adc2_in1_enum, RT5670_DIG_MISC,
+	RT5670_IF1_ADC2_IN1_SFT, rt5670_if1_adc2_in1_src);
+
+static const struct snd_kcontrol_new rt5670_if1_adc2_in1_mux =
+	SOC_DAPM_ENUM("IF1 ADC2 IN1 source", rt5670_if1_adc2_in1_enum);
+
+/* MX-9D [9:8] */
+static const char * const rt5670_vad_adc_src[] = {
+	"Sto1 ADC L", "Mono ADC L", "Mono ADC R", "Sto2 ADC L"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5670_vad_adc_enum, RT5670_VAD_CTRL4,
+	RT5670_VAD_SEL_SFT, rt5670_vad_adc_src);
+
+static const struct snd_kcontrol_new rt5670_vad_adc_mux =
+	SOC_DAPM_ENUM("VAD ADC source", rt5670_vad_adc_enum);
+
+static int rt5670_hp_power_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(rt5670->regmap, RT5670_CHARGE_PUMP,
+			RT5670_PM_HP_MASK, RT5670_PM_HP_HV);
+		regmap_update_bits(rt5670->regmap, RT5670_GEN_CTRL2,
+			0x0400, 0x0400);
+		/* headphone amp power on */
+		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG1,
+			RT5670_PWR_HA |	RT5670_PWR_FV1 |
+			RT5670_PWR_FV2,	RT5670_PWR_HA |
+			RT5670_PWR_FV1 | RT5670_PWR_FV2);
+		/* depop parameters */
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M2, 0x3100);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x8009);
+		regmap_write(rt5670->regmap, RT5670_PR_BASE +
+			RT5670_HP_DCC_INT1, 0x9f00);
+		mdelay(20);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x8019);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x0004);
+		msleep(30);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5670_hp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* headphone unmute sequence */
+		regmap_write(rt5670->regmap, RT5670_PR_BASE +
+				RT5670_MAMP_INT_REG2, 0xb400);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M3, 0x0772);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x805d);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x831d);
+		regmap_update_bits(rt5670->regmap, RT5670_GEN_CTRL2,
+				0x0300, 0x0300);
+		regmap_update_bits(rt5670->regmap, RT5670_HP_VOL,
+			RT5670_L_MUTE | RT5670_R_MUTE, 0);
+		msleep(80);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x8019);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		/* headphone mute sequence */
+		regmap_write(rt5670->regmap, RT5670_PR_BASE +
+				RT5670_MAMP_INT_REG2, 0xb400);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M3, 0x0772);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x803d);
+		mdelay(10);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x831d);
+		mdelay(10);
+		regmap_update_bits(rt5670->regmap, RT5670_HP_VOL,
+				   RT5670_L_MUTE | RT5670_R_MUTE,
+				   RT5670_L_MUTE | RT5670_R_MUTE);
+		msleep(20);
+		regmap_update_bits(rt5670->regmap,
+				   RT5670_GEN_CTRL2, 0x0300, 0x0);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M1, 0x8019);
+		regmap_write(rt5670->regmap, RT5670_DEPOP_M3, 0x0707);
+		regmap_write(rt5670->regmap, RT5670_PR_BASE +
+				RT5670_MAMP_INT_REG2, 0xfc00);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5670_bst1_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, RT5670_PWR_ANLG2,
+				    RT5670_PWR_BST1_P, RT5670_PWR_BST1_P);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5670_PWR_ANLG2,
+				    RT5670_PWR_BST1_P, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5670_bst2_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, RT5670_PWR_ANLG2,
+				    RT5670_PWR_BST2_P, RT5670_PWR_BST2_P);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5670_PWR_ANLG2,
+				    RT5670_PWR_BST2_P, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("PLL1", RT5670_PWR_ANLG2,
+			    RT5670_PWR_PLL_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("I2S DSP", RT5670_PWR_DIG2,
+			    RT5670_PWR_I2S_DSP_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Det Power", RT5670_PWR_VOL,
+			    RT5670_PWR_MIC_DET_BIT, 0, NULL, 0),
+
+	/* ASRC */
+	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5670_ASRC_1,
+			      11, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5670_ASRC_1,
+			      12, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5670_ASRC_1,
+			      10, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO L ASRC", 1, RT5670_ASRC_1,
+			      9, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO R ASRC", 1, RT5670_ASRC_1,
+			      8, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5670_ASRC_1,
+			      3, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5670_ASRC_1,
+			      2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC MONO L ASRC", 1, RT5670_ASRC_1,
+			      1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC MONO R ASRC", 1, RT5670_ASRC_1,
+			      0, 0, NULL, 0),
+
+	/* Input Side */
+	/* micbias */
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5670_PWR_ANLG2,
+			     RT5670_PWR_MB1_BIT, 0, NULL, 0),
+
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("DMIC L1"),
+	SND_SOC_DAPM_INPUT("DMIC R1"),
+	SND_SOC_DAPM_INPUT("DMIC L2"),
+	SND_SOC_DAPM_INPUT("DMIC R2"),
+	SND_SOC_DAPM_INPUT("DMIC L3"),
+	SND_SOC_DAPM_INPUT("DMIC R3"),
+
+	SND_SOC_DAPM_INPUT("IN1P"),
+	SND_SOC_DAPM_INPUT("IN1N"),
+	SND_SOC_DAPM_INPUT("IN2P"),
+	SND_SOC_DAPM_INPUT("IN2N"),
+
+	SND_SOC_DAPM_PGA("DMIC1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DMIC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DMIC3", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0,
+			    set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY("DMIC1 Power", RT5670_DMIC_CTRL1,
+			    RT5670_DMIC_1_EN_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DMIC2 Power", RT5670_DMIC_CTRL1,
+			    RT5670_DMIC_2_EN_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DMIC3 Power", RT5670_DMIC_CTRL1,
+			    RT5670_DMIC_3_EN_SFT, 0, NULL, 0),
+	/* Boost */
+	SND_SOC_DAPM_PGA_E("BST1", RT5670_PWR_ANLG2, RT5670_PWR_BST1_BIT,
+			   0, NULL, 0, rt5670_bst1_event,
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("BST2", RT5670_PWR_ANLG2, RT5670_PWR_BST2_BIT,
+			   0, NULL, 0, rt5670_bst2_event,
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	/* Input Volume */
+	SND_SOC_DAPM_PGA("INL VOL", RT5670_PWR_VOL,
+			 RT5670_PWR_IN_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INR VOL", RT5670_PWR_VOL,
+			 RT5670_PWR_IN_R_BIT, 0, NULL, 0),
+
+	/* REC Mixer */
+	SND_SOC_DAPM_MIXER("RECMIXL", RT5670_PWR_MIXER, RT5670_PWR_RM_L_BIT, 0,
+			   rt5670_rec_l_mix, ARRAY_SIZE(rt5670_rec_l_mix)),
+	SND_SOC_DAPM_MIXER("RECMIXR", RT5670_PWR_MIXER, RT5670_PWR_RM_R_BIT, 0,
+			   rt5670_rec_r_mix, ARRAY_SIZE(rt5670_rec_r_mix)),
+	/* ADCs */
+	SND_SOC_DAPM_ADC("ADC 1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC 2", NULL, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_PGA("ADC 1_2", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("ADC 1 power", RT5670_PWR_DIG1,
+			    RT5670_PWR_ADC_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC 2 power", RT5670_PWR_DIG1,
+			    RT5670_PWR_ADC_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC clock", RT5670_PR_BASE +
+			    RT5670_CHOP_DAC_ADC, 12, 0, NULL, 0),
+	/* ADC Mux */
+	SND_SOC_DAPM_MUX("Stereo1 DMIC Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto1_dmic_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto_adc_l2_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto_adc_r2_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto_adc_l1_mux),
+	SND_SOC_DAPM_MUX("Stereo1 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto_adc_r1_mux),
+	SND_SOC_DAPM_MUX("Stereo2 DMIC Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto2_dmic_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto2_adc_l2_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto2_adc_r2_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto2_adc_l1_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto2_adc_r1_mux),
+	SND_SOC_DAPM_MUX("Stereo2 ADC LR Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_sto2_adc_lr_mux),
+	SND_SOC_DAPM_MUX("Mono DMIC L Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_mono_dmic_l_mux),
+	SND_SOC_DAPM_MUX("Mono DMIC R Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_mono_dmic_r_mux),
+	SND_SOC_DAPM_MUX("Mono ADC L2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_mono_adc_l2_mux),
+	SND_SOC_DAPM_MUX("Mono ADC L1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_mono_adc_l1_mux),
+	SND_SOC_DAPM_MUX("Mono ADC R1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_mono_adc_r1_mux),
+	SND_SOC_DAPM_MUX("Mono ADC R2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_mono_adc_r2_mux),
+	/* ADC Mixer */
+	SND_SOC_DAPM_SUPPLY("ADC Stereo1 Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_ADC_S1F_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Stereo2 Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_ADC_S2F_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Sto1 ADC MIXL", RT5670_STO1_ADC_DIG_VOL,
+			   RT5670_L_MUTE_SFT, 1, rt5670_sto1_adc_l_mix,
+			   ARRAY_SIZE(rt5670_sto1_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Sto1 ADC MIXR", RT5670_STO1_ADC_DIG_VOL,
+			   RT5670_R_MUTE_SFT, 1, rt5670_sto1_adc_r_mix,
+			   ARRAY_SIZE(rt5670_sto1_adc_r_mix)),
+	SND_SOC_DAPM_MIXER("Sto2 ADC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5670_sto2_adc_l_mix,
+			   ARRAY_SIZE(rt5670_sto2_adc_l_mix)),
+	SND_SOC_DAPM_MIXER("Sto2 ADC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5670_sto2_adc_r_mix,
+			   ARRAY_SIZE(rt5670_sto2_adc_r_mix)),
+	SND_SOC_DAPM_SUPPLY("ADC Mono Left Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_ADC_MF_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Mono ADC MIXL", RT5670_MONO_ADC_DIG_VOL,
+			   RT5670_L_MUTE_SFT, 1, rt5670_mono_adc_l_mix,
+			   ARRAY_SIZE(rt5670_mono_adc_l_mix)),
+	SND_SOC_DAPM_SUPPLY("ADC Mono Right Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_ADC_MF_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Mono ADC MIXR", RT5670_MONO_ADC_DIG_VOL,
+			   RT5670_R_MUTE_SFT, 1, rt5670_mono_adc_r_mix,
+			   ARRAY_SIZE(rt5670_mono_adc_r_mix)),
+
+	/* ADC PGA */
+	SND_SOC_DAPM_PGA("Stereo1 ADC MIXL", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Stereo1 ADC MIXR", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Stereo2 ADC MIXL", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Stereo2 ADC MIXR", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Sto2 ADC LR MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Stereo1 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Stereo2 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mono ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("VAD_ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF_ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF_ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF_ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1_ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1_ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1_ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* DSP */
+	SND_SOC_DAPM_PGA("TxDP_ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("TxDP_ADC_L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("TxDP_ADC_R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("TxDC_DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("TDM Data Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_txdp_slot_mux),
+
+	SND_SOC_DAPM_MUX("DSP UL Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_dsp_ul_mux),
+	SND_SOC_DAPM_MUX("DSP DL Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_dsp_dl_mux),
+
+	SND_SOC_DAPM_MUX("RxDP Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_rxdp_mux),
+
+	/* IF2 Mux */
+	SND_SOC_DAPM_MUX("IF2 ADC Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_if2_adc_in_mux),
+
+	/* Digital Interface */
+	SND_SOC_DAPM_SUPPLY("I2S1", RT5670_PWR_DIG1,
+			    RT5670_PWR_I2S1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC1 L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC1 R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC2 L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 DAC2 R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("I2S2", RT5670_PWR_DIG1,
+			    RT5670_PWR_I2S2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 DAC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Digital Interface Select */
+	SND_SOC_DAPM_MUX("IF1 ADC1 IN1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_if1_adc1_in1_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC1 IN2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_if1_adc1_in2_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC2 IN Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_if1_adc2_in_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC2 IN1 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_if1_adc2_in1_mux),
+	SND_SOC_DAPM_MUX("VAD ADC Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_vad_adc_mux),
+
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "AIF2 Capture", 0,
+			     RT5670_GPIO_CTRL1, RT5670_I2S2_PIN_SFT, 1),
+
+	/* Audio DSP */
+	SND_SOC_DAPM_PGA("Audio DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Output Side */
+	/* DAC mixer before sound effect  */
+	SND_SOC_DAPM_MIXER("DAC1 MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5670_dac_l_mix, ARRAY_SIZE(rt5670_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("DAC1 MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5670_dac_r_mix, ARRAY_SIZE(rt5670_dac_r_mix)),
+	SND_SOC_DAPM_PGA("DAC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* DAC2 channel Mux */
+	SND_SOC_DAPM_MUX("DAC L2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_dac_l2_mux),
+	SND_SOC_DAPM_MUX("DAC R2 Mux", SND_SOC_NOPM, 0, 0,
+			 &rt5670_dac_r2_mux),
+	SND_SOC_DAPM_PGA("DAC L2 Volume", RT5670_PWR_DIG1,
+			 RT5670_PWR_DAC_L2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DAC R2 Volume", RT5670_PWR_DIG1,
+			 RT5670_PWR_DAC_R2_BIT, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("DAC1 L Mux", SND_SOC_NOPM, 0, 0, &rt5670_dac1l_mux),
+	SND_SOC_DAPM_MUX("DAC1 R Mux", SND_SOC_NOPM, 0, 0, &rt5670_dac1r_mux),
+
+	/* DAC Mixer */
+	SND_SOC_DAPM_SUPPLY("DAC Stereo1 Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_DAC_S1F_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC Mono Left Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_DAC_MF_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC Mono Right Filter", RT5670_PWR_DIG2,
+			    RT5670_PWR_DAC_MF_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5670_sto_dac_l_mix,
+			   ARRAY_SIZE(rt5670_sto_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5670_sto_dac_r_mix,
+			   ARRAY_SIZE(rt5670_sto_dac_r_mix)),
+	SND_SOC_DAPM_MIXER("Mono DAC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5670_mono_dac_l_mix,
+			   ARRAY_SIZE(rt5670_mono_dac_l_mix)),
+	SND_SOC_DAPM_MIXER("Mono DAC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5670_mono_dac_r_mix,
+			   ARRAY_SIZE(rt5670_mono_dac_r_mix)),
+	SND_SOC_DAPM_MIXER("DAC MIXL", SND_SOC_NOPM, 0, 0,
+			   rt5670_dig_l_mix,
+			   ARRAY_SIZE(rt5670_dig_l_mix)),
+	SND_SOC_DAPM_MIXER("DAC MIXR", SND_SOC_NOPM, 0, 0,
+			   rt5670_dig_r_mix,
+			   ARRAY_SIZE(rt5670_dig_r_mix)),
+
+	/* DACs */
+	SND_SOC_DAPM_SUPPLY("DAC L1 Power", RT5670_PWR_DIG1,
+			    RT5670_PWR_DAC_L1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R1 Power", RT5670_PWR_DIG1,
+			    RT5670_PWR_DAC_R1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_DAC("DAC L1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC R1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC L2", NULL, RT5670_PWR_DIG1,
+			 RT5670_PWR_DAC_L2_BIT, 0),
+
+	SND_SOC_DAPM_DAC("DAC R2", NULL, RT5670_PWR_DIG1,
+			 RT5670_PWR_DAC_R2_BIT, 0),
+	/* OUT Mixer */
+
+	SND_SOC_DAPM_MIXER("OUT MIXL", RT5670_PWR_MIXER, RT5670_PWR_OM_L_BIT,
+			   0, rt5670_out_l_mix, ARRAY_SIZE(rt5670_out_l_mix)),
+	SND_SOC_DAPM_MIXER("OUT MIXR", RT5670_PWR_MIXER, RT5670_PWR_OM_R_BIT,
+			   0, rt5670_out_r_mix, ARRAY_SIZE(rt5670_out_r_mix)),
+	/* Ouput Volume */
+	SND_SOC_DAPM_MIXER("HPOVOL MIXL", RT5670_PWR_VOL,
+			   RT5670_PWR_HV_L_BIT, 0,
+			   rt5670_hpvoll_mix, ARRAY_SIZE(rt5670_hpvoll_mix)),
+	SND_SOC_DAPM_MIXER("HPOVOL MIXR", RT5670_PWR_VOL,
+			   RT5670_PWR_HV_R_BIT, 0,
+			   rt5670_hpvolr_mix, ARRAY_SIZE(rt5670_hpvolr_mix)),
+	SND_SOC_DAPM_PGA("DAC 1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("DAC 2", SND_SOC_NOPM,	0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HPOVOL", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* HPO/LOUT/Mono Mixer */
+	SND_SOC_DAPM_MIXER("HPO MIX", SND_SOC_NOPM, 0, 0,
+			   rt5670_hpo_mix, ARRAY_SIZE(rt5670_hpo_mix)),
+	SND_SOC_DAPM_MIXER("LOUT MIX", RT5670_PWR_ANLG1, RT5670_PWR_LM_BIT,
+			   0, rt5670_lout_mix, ARRAY_SIZE(rt5670_lout_mix)),
+	SND_SOC_DAPM_SUPPLY_S("Improve HP Amp Drv", 1, SND_SOC_NOPM, 0, 0,
+			      rt5670_hp_power_event, SND_SOC_DAPM_POST_PMU |
+			      SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SUPPLY("HP L Amp", RT5670_PWR_ANLG1,
+			    RT5670_PWR_HP_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HP R Amp", RT5670_PWR_ANLG1,
+			    RT5670_PWR_HP_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
+			   rt5670_hp_event, SND_SOC_DAPM_PRE_PMD |
+			   SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SWITCH("LOUT L Playback", SND_SOC_NOPM, 0, 0,
+			    &lout_l_enable_control),
+	SND_SOC_DAPM_SWITCH("LOUT R Playback", SND_SOC_NOPM, 0, 0,
+			    &lout_r_enable_control),
+	SND_SOC_DAPM_PGA("LOUT Amp", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* PDM */
+	SND_SOC_DAPM_SUPPLY("PDM1 Power", RT5670_PWR_DIG2,
+		RT5670_PWR_PDM1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("PDM2 Power", RT5670_PWR_DIG2,
+		RT5670_PWR_PDM2_BIT, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("PDM1 L Mux", RT5670_PDM_OUT_CTRL,
+			 RT5670_M_PDM1_L_SFT, 1, &rt5670_pdm1_l_mux),
+	SND_SOC_DAPM_MUX("PDM1 R Mux", RT5670_PDM_OUT_CTRL,
+			 RT5670_M_PDM1_R_SFT, 1, &rt5670_pdm1_r_mux),
+	SND_SOC_DAPM_MUX("PDM2 L Mux", RT5670_PDM_OUT_CTRL,
+			 RT5670_M_PDM2_L_SFT, 1, &rt5670_pdm2_l_mux),
+	SND_SOC_DAPM_MUX("PDM2 R Mux", RT5670_PDM_OUT_CTRL,
+			 RT5670_M_PDM2_R_SFT, 1, &rt5670_pdm2_r_mux),
+
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+	SND_SOC_DAPM_OUTPUT("LOUTL"),
+	SND_SOC_DAPM_OUTPUT("LOUTR"),
+	SND_SOC_DAPM_OUTPUT("PDM1L"),
+	SND_SOC_DAPM_OUTPUT("PDM1R"),
+	SND_SOC_DAPM_OUTPUT("PDM2L"),
+	SND_SOC_DAPM_OUTPUT("PDM2R"),
+};
+
+static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
+	{ "ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc },
+	{ "ADC Stereo2 Filter", NULL, "ADC STO2 ASRC", is_using_asrc },
+	{ "ADC Mono Left Filter", NULL, "ADC MONO L ASRC", is_using_asrc },
+	{ "ADC Mono Right Filter", NULL, "ADC MONO R ASRC", is_using_asrc },
+	{ "DAC Mono Left Filter", NULL, "DAC MONO L ASRC", is_using_asrc },
+	{ "DAC Mono Right Filter", NULL, "DAC MONO R ASRC", is_using_asrc },
+	{ "DAC Stereo1 Filter", NULL, "DAC STO ASRC", is_using_asrc },
+
+	{ "I2S1", NULL, "I2S1 ASRC" },
+	{ "I2S2", NULL, "I2S2 ASRC" },
+
+	{ "DMIC1", NULL, "DMIC L1" },
+	{ "DMIC1", NULL, "DMIC R1" },
+	{ "DMIC2", NULL, "DMIC L2" },
+	{ "DMIC2", NULL, "DMIC R2" },
+	{ "DMIC3", NULL, "DMIC L3" },
+	{ "DMIC3", NULL, "DMIC R3" },
+
+	{ "BST1", NULL, "IN1P" },
+	{ "BST1", NULL, "IN1N" },
+	{ "BST1", NULL, "Mic Det Power" },
+	{ "BST2", NULL, "IN2P" },
+	{ "BST2", NULL, "IN2N" },
+
+	{ "INL VOL", NULL, "IN2P" },
+	{ "INR VOL", NULL, "IN2N" },
+
+	{ "RECMIXL", "INL Switch", "INL VOL" },
+	{ "RECMIXL", "BST2 Switch", "BST2" },
+	{ "RECMIXL", "BST1 Switch", "BST1" },
+
+	{ "RECMIXR", "INR Switch", "INR VOL" },
+	{ "RECMIXR", "BST2 Switch", "BST2" },
+	{ "RECMIXR", "BST1 Switch", "BST1" },
+
+	{ "ADC 1", NULL, "RECMIXL" },
+	{ "ADC 1", NULL, "ADC 1 power" },
+	{ "ADC 1", NULL, "ADC clock" },
+	{ "ADC 2", NULL, "RECMIXR" },
+	{ "ADC 2", NULL, "ADC 2 power" },
+	{ "ADC 2", NULL, "ADC clock" },
+
+	{ "DMIC L1", NULL, "DMIC CLK" },
+	{ "DMIC L1", NULL, "DMIC1 Power" },
+	{ "DMIC R1", NULL, "DMIC CLK" },
+	{ "DMIC R1", NULL, "DMIC1 Power" },
+	{ "DMIC L2", NULL, "DMIC CLK" },
+	{ "DMIC L2", NULL, "DMIC2 Power" },
+	{ "DMIC R2", NULL, "DMIC CLK" },
+	{ "DMIC R2", NULL, "DMIC2 Power" },
+	{ "DMIC L3", NULL, "DMIC CLK" },
+	{ "DMIC L3", NULL, "DMIC3 Power" },
+	{ "DMIC R3", NULL, "DMIC CLK" },
+	{ "DMIC R3", NULL, "DMIC3 Power" },
+
+	{ "Stereo1 DMIC Mux", "DMIC1", "DMIC1" },
+	{ "Stereo1 DMIC Mux", "DMIC2", "DMIC2" },
+	{ "Stereo1 DMIC Mux", "DMIC3", "DMIC3" },
+
+	{ "Stereo2 DMIC Mux", "DMIC1", "DMIC1" },
+	{ "Stereo2 DMIC Mux", "DMIC2", "DMIC2" },
+	{ "Stereo2 DMIC Mux", "DMIC3", "DMIC3" },
+
+	{ "Mono DMIC L Mux", "DMIC1", "DMIC L1" },
+	{ "Mono DMIC L Mux", "DMIC2", "DMIC L2" },
+	{ "Mono DMIC L Mux", "DMIC3", "DMIC L3" },
+
+	{ "Mono DMIC R Mux", "DMIC1", "DMIC R1" },
+	{ "Mono DMIC R Mux", "DMIC2", "DMIC R2" },
+	{ "Mono DMIC R Mux", "DMIC3", "DMIC R3" },
+
+	{ "ADC 1_2", NULL, "ADC 1" },
+	{ "ADC 1_2", NULL, "ADC 2" },
+
+	{ "Stereo1 ADC L2 Mux", "DMIC", "Stereo1 DMIC Mux" },
+	{ "Stereo1 ADC L2 Mux", "DAC MIX", "DAC MIXL" },
+	{ "Stereo1 ADC L1 Mux", "ADC", "ADC 1_2" },
+	{ "Stereo1 ADC L1 Mux", "DAC MIX", "DAC MIXL" },
+
+	{ "Stereo1 ADC R1 Mux", "ADC", "ADC 1_2" },
+	{ "Stereo1 ADC R1 Mux", "DAC MIX", "DAC MIXR" },
+	{ "Stereo1 ADC R2 Mux", "DMIC", "Stereo1 DMIC Mux" },
+	{ "Stereo1 ADC R2 Mux", "DAC MIX", "DAC MIXR" },
+
+	{ "Mono ADC L2 Mux", "DMIC", "Mono DMIC L Mux" },
+	{ "Mono ADC L2 Mux", "Mono DAC MIXL", "Mono DAC MIXL" },
+	{ "Mono ADC L1 Mux", "Mono DAC MIXL", "Mono DAC MIXL" },
+	{ "Mono ADC L1 Mux", "ADC1",  "ADC 1" },
+
+	{ "Mono ADC R1 Mux", "Mono DAC MIXR", "Mono DAC MIXR" },
+	{ "Mono ADC R1 Mux", "ADC2", "ADC 2" },
+	{ "Mono ADC R2 Mux", "DMIC", "Mono DMIC R Mux" },
+	{ "Mono ADC R2 Mux", "Mono DAC MIXR", "Mono DAC MIXR" },
+
+	{ "Sto1 ADC MIXL", "ADC1 Switch", "Stereo1 ADC L1 Mux" },
+	{ "Sto1 ADC MIXL", "ADC2 Switch", "Stereo1 ADC L2 Mux" },
+	{ "Sto1 ADC MIXR", "ADC1 Switch", "Stereo1 ADC R1 Mux" },
+	{ "Sto1 ADC MIXR", "ADC2 Switch", "Stereo1 ADC R2 Mux" },
+
+	{ "Stereo1 ADC MIXL", NULL, "Sto1 ADC MIXL" },
+	{ "Stereo1 ADC MIXL", NULL, "ADC Stereo1 Filter" },
+	{ "ADC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "Stereo1 ADC MIXR", NULL, "Sto1 ADC MIXR" },
+	{ "Stereo1 ADC MIXR", NULL, "ADC Stereo1 Filter" },
+	{ "ADC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "Mono ADC MIXL", "ADC1 Switch", "Mono ADC L1 Mux" },
+	{ "Mono ADC MIXL", "ADC2 Switch", "Mono ADC L2 Mux" },
+	{ "Mono ADC MIXL", NULL, "ADC Mono Left Filter" },
+	{ "ADC Mono Left Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "Mono ADC MIXR", "ADC1 Switch", "Mono ADC R1 Mux" },
+	{ "Mono ADC MIXR", "ADC2 Switch", "Mono ADC R2 Mux" },
+	{ "Mono ADC MIXR", NULL, "ADC Mono Right Filter" },
+	{ "ADC Mono Right Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "Stereo2 ADC L2 Mux", "DMIC", "Stereo2 DMIC Mux" },
+	{ "Stereo2 ADC L2 Mux", "DAC MIX", "DAC MIXL" },
+	{ "Stereo2 ADC L1 Mux", "ADC", "ADC 1_2" },
+	{ "Stereo2 ADC L1 Mux", "DAC MIX", "DAC MIXL" },
+
+	{ "Stereo2 ADC R1 Mux", "ADC", "ADC 1_2" },
+	{ "Stereo2 ADC R1 Mux", "DAC MIX", "DAC MIXR" },
+	{ "Stereo2 ADC R2 Mux", "DMIC", "Stereo2 DMIC Mux" },
+	{ "Stereo2 ADC R2 Mux", "DAC MIX", "DAC MIXR" },
+
+	{ "Sto2 ADC MIXL", "ADC1 Switch", "Stereo2 ADC L1 Mux" },
+	{ "Sto2 ADC MIXL", "ADC2 Switch", "Stereo2 ADC L2 Mux" },
+	{ "Sto2 ADC MIXR", "ADC1 Switch", "Stereo2 ADC R1 Mux" },
+	{ "Sto2 ADC MIXR", "ADC2 Switch", "Stereo2 ADC R2 Mux" },
+
+	{ "Sto2 ADC LR MIX", NULL, "Sto2 ADC MIXL" },
+	{ "Sto2 ADC LR MIX", NULL, "Sto2 ADC MIXR" },
+
+	{ "Stereo2 ADC LR Mux", "L", "Sto2 ADC MIXL" },
+	{ "Stereo2 ADC LR Mux", "LR", "Sto2 ADC LR MIX" },
+
+	{ "Stereo2 ADC MIXL", NULL, "Stereo2 ADC LR Mux" },
+	{ "Stereo2 ADC MIXL", NULL, "ADC Stereo2 Filter" },
+	{ "ADC Stereo2 Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "Stereo2 ADC MIXR", NULL, "Sto2 ADC MIXR" },
+	{ "Stereo2 ADC MIXR", NULL, "ADC Stereo2 Filter" },
+	{ "ADC Stereo2 Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "VAD ADC Mux", "Sto1 ADC L", "Stereo1 ADC MIXL" },
+	{ "VAD ADC Mux", "Mono ADC L", "Mono ADC MIXL" },
+	{ "VAD ADC Mux", "Mono ADC R", "Mono ADC MIXR" },
+	{ "VAD ADC Mux", "Sto2 ADC L", "Sto2 ADC MIXL" },
+
+	{ "VAD_ADC", NULL, "VAD ADC Mux" },
+
+	{ "IF_ADC1", NULL, "Stereo1 ADC MIXL" },
+	{ "IF_ADC1", NULL, "Stereo1 ADC MIXR" },
+	{ "IF_ADC2", NULL, "Mono ADC MIXL" },
+	{ "IF_ADC2", NULL, "Mono ADC MIXR" },
+	{ "IF_ADC3", NULL, "Stereo2 ADC MIXL" },
+	{ "IF_ADC3", NULL, "Stereo2 ADC MIXR" },
+
+	{ "IF1 ADC1 IN1 Mux", "IF_ADC1", "IF_ADC1" },
+	{ "IF1 ADC1 IN1 Mux", "IF1_ADC3", "IF1_ADC3" },
+
+	{ "IF1 ADC1 IN2 Mux", "IF1_ADC1_IN1", "IF1 ADC1 IN1 Mux" },
+	{ "IF1 ADC1 IN2 Mux", "IF1_ADC4", "IF1_ADC4" },
+
+	{ "IF1 ADC2 IN Mux", "IF_ADC2", "IF_ADC2" },
+	{ "IF1 ADC2 IN Mux", "VAD_ADC", "VAD_ADC" },
+
+	{ "IF1 ADC2 IN1 Mux", "IF1_ADC2_IN", "IF1 ADC2 IN Mux" },
+	{ "IF1 ADC2 IN1 Mux", "IF1_ADC4", "IF1_ADC4" },
+
+	{ "IF1_ADC1" , NULL, "IF1 ADC1 IN2 Mux" },
+	{ "IF1_ADC2" , NULL, "IF1 ADC2 IN1 Mux" },
+
+	{ "Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXL" },
+	{ "Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXR" },
+	{ "Stereo2 ADC MIX", NULL, "Sto2 ADC MIXL" },
+	{ "Stereo2 ADC MIX", NULL, "Sto2 ADC MIXR" },
+	{ "Mono ADC MIX", NULL, "Mono ADC MIXL" },
+	{ "Mono ADC MIX", NULL, "Mono ADC MIXR" },
+
+	{ "RxDP Mux", "IF2 DAC", "IF2 DAC" },
+	{ "RxDP Mux", "IF1 DAC", "IF1 DAC2" },
+	{ "RxDP Mux", "STO1 ADC Mixer", "Stereo1 ADC MIX" },
+	{ "RxDP Mux", "STO2 ADC Mixer", "Stereo2 ADC MIX" },
+	{ "RxDP Mux", "Mono ADC Mixer L", "Mono ADC MIXL" },
+	{ "RxDP Mux", "Mono ADC Mixer R", "Mono ADC MIXR" },
+	{ "RxDP Mux", "DAC1", "DAC MIX" },
+
+	{ "TDM Data Mux", "Slot 0-1", "Stereo1 ADC MIX" },
+	{ "TDM Data Mux", "Slot 2-3", "Mono ADC MIX" },
+	{ "TDM Data Mux", "Slot 4-5", "Stereo2 ADC MIX" },
+	{ "TDM Data Mux", "Slot 6-7", "IF2 DAC" },
+
+	{ "DSP UL Mux", "Bypass", "TDM Data Mux" },
+	{ "DSP UL Mux", NULL, "I2S DSP" },
+	{ "DSP DL Mux", "Bypass", "RxDP Mux" },
+	{ "DSP DL Mux", NULL, "I2S DSP" },
+
+	{ "TxDP_ADC_L", NULL, "DSP UL Mux" },
+	{ "TxDP_ADC_R", NULL, "DSP UL Mux" },
+	{ "TxDC_DAC", NULL, "DSP DL Mux" },
+
+	{ "TxDP_ADC", NULL, "TxDP_ADC_L" },
+	{ "TxDP_ADC", NULL, "TxDP_ADC_R" },
+
+	{ "IF1 ADC", NULL, "I2S1" },
+	{ "IF1 ADC", NULL, "IF1_ADC1" },
+	{ "IF1 ADC", NULL, "IF1_ADC2" },
+	{ "IF1 ADC", NULL, "IF_ADC3" },
+	{ "IF1 ADC", NULL, "TxDP_ADC" },
+
+	{ "IF2 ADC Mux", "IF_ADC1", "IF_ADC1" },
+	{ "IF2 ADC Mux", "IF_ADC2", "IF_ADC2" },
+	{ "IF2 ADC Mux", "IF_ADC3", "IF_ADC3" },
+	{ "IF2 ADC Mux", "TxDC_DAC", "TxDC_DAC" },
+	{ "IF2 ADC Mux", "TxDP_ADC", "TxDP_ADC" },
+	{ "IF2 ADC Mux", "VAD_ADC", "VAD_ADC" },
+
+	{ "IF2 ADC L", NULL, "IF2 ADC Mux" },
+	{ "IF2 ADC R", NULL, "IF2 ADC Mux" },
+
+	{ "IF2 ADC", NULL, "I2S2" },
+	{ "IF2 ADC", NULL, "IF2 ADC L" },
+	{ "IF2 ADC", NULL, "IF2 ADC R" },
+
+	{ "AIF1TX", NULL, "IF1 ADC" },
+	{ "AIF2TX", NULL, "IF2 ADC" },
+
+	{ "IF1 DAC1", NULL, "AIF1RX" },
+	{ "IF1 DAC2", NULL, "AIF1RX" },
+	{ "IF2 DAC", NULL, "AIF2RX" },
+
+	{ "IF1 DAC1", NULL, "I2S1" },
+	{ "IF1 DAC2", NULL, "I2S1" },
+	{ "IF2 DAC", NULL, "I2S2" },
+
+	{ "IF1 DAC2 L", NULL, "IF1 DAC2" },
+	{ "IF1 DAC2 R", NULL, "IF1 DAC2" },
+	{ "IF1 DAC1 L", NULL, "IF1 DAC1" },
+	{ "IF1 DAC1 R", NULL, "IF1 DAC1" },
+	{ "IF2 DAC L", NULL, "IF2 DAC" },
+	{ "IF2 DAC R", NULL, "IF2 DAC" },
+
+	{ "DAC1 L Mux", "IF1 DAC", "IF1 DAC1 L" },
+	{ "DAC1 L Mux", "IF2 DAC", "IF2 DAC L" },
+
+	{ "DAC1 R Mux", "IF1 DAC", "IF1 DAC1 R" },
+	{ "DAC1 R Mux", "IF2 DAC", "IF2 DAC R" },
+
+	{ "DAC1 MIXL", "Stereo ADC Switch", "Stereo1 ADC MIXL" },
+	{ "DAC1 MIXL", "DAC1 Switch", "DAC1 L Mux" },
+	{ "DAC1 MIXL", NULL, "DAC Stereo1 Filter" },
+	{ "DAC1 MIXR", "Stereo ADC Switch", "Stereo1 ADC MIXR" },
+	{ "DAC1 MIXR", "DAC1 Switch", "DAC1 R Mux" },
+	{ "DAC1 MIXR", NULL, "DAC Stereo1 Filter" },
+
+	{ "DAC MIX", NULL, "DAC1 MIXL" },
+	{ "DAC MIX", NULL, "DAC1 MIXR" },
+
+	{ "Audio DSP", NULL, "DAC1 MIXL" },
+	{ "Audio DSP", NULL, "DAC1 MIXR" },
+
+	{ "DAC L2 Mux", "IF1 DAC", "IF1 DAC2 L" },
+	{ "DAC L2 Mux", "IF2 DAC", "IF2 DAC L" },
+	{ "DAC L2 Mux", "TxDC DAC", "TxDC_DAC" },
+	{ "DAC L2 Mux", "VAD_ADC", "VAD_ADC" },
+	{ "DAC L2 Volume", NULL, "DAC L2 Mux" },
+	{ "DAC L2 Volume", NULL, "DAC Mono Left Filter" },
+
+	{ "DAC R2 Mux", "IF1 DAC", "IF1 DAC2 R" },
+	{ "DAC R2 Mux", "IF2 DAC", "IF2 DAC R" },
+	{ "DAC R2 Mux", "TxDC DAC", "TxDC_DAC" },
+	{ "DAC R2 Mux", "TxDP ADC", "TxDP_ADC" },
+	{ "DAC R2 Volume", NULL, "DAC R2 Mux" },
+	{ "DAC R2 Volume", NULL, "DAC Mono Right Filter" },
+
+	{ "Stereo DAC MIXL", "DAC L1 Switch", "DAC1 MIXL" },
+	{ "Stereo DAC MIXL", "DAC R1 Switch", "DAC1 MIXR" },
+	{ "Stereo DAC MIXL", "DAC L2 Switch", "DAC L2 Volume" },
+	{ "Stereo DAC MIXL", NULL, "DAC Stereo1 Filter" },
+	{ "Stereo DAC MIXL", NULL, "DAC L1 Power" },
+	{ "Stereo DAC MIXR", "DAC R1 Switch", "DAC1 MIXR" },
+	{ "Stereo DAC MIXR", "DAC L1 Switch", "DAC1 MIXL" },
+	{ "Stereo DAC MIXR", "DAC R2 Switch", "DAC R2 Volume" },
+	{ "Stereo DAC MIXR", NULL, "DAC Stereo1 Filter" },
+	{ "Stereo DAC MIXR", NULL, "DAC R1 Power" },
+
+	{ "Mono DAC MIXL", "DAC L1 Switch", "DAC1 MIXL" },
+	{ "Mono DAC MIXL", "DAC L2 Switch", "DAC L2 Volume" },
+	{ "Mono DAC MIXL", "DAC R2 Switch", "DAC R2 Volume" },
+	{ "Mono DAC MIXL", NULL, "DAC Mono Left Filter" },
+	{ "Mono DAC MIXR", "DAC R1 Switch", "DAC1 MIXR" },
+	{ "Mono DAC MIXR", "DAC R2 Switch", "DAC R2 Volume" },
+	{ "Mono DAC MIXR", "DAC L2 Switch", "DAC L2 Volume" },
+	{ "Mono DAC MIXR", NULL, "DAC Mono Right Filter" },
+
+	{ "DAC MIXL", "Sto DAC Mix L Switch", "Stereo DAC MIXL" },
+	{ "DAC MIXL", "DAC L2 Switch", "DAC L2 Volume" },
+	{ "DAC MIXL", "DAC R2 Switch", "DAC R2 Volume" },
+	{ "DAC MIXR", "Sto DAC Mix R Switch", "Stereo DAC MIXR" },
+	{ "DAC MIXR", "DAC R2 Switch", "DAC R2 Volume" },
+	{ "DAC MIXR", "DAC L2 Switch", "DAC L2 Volume" },
+
+	{ "DAC L1", NULL, "DAC L1 Power" },
+	{ "DAC L1", NULL, "Stereo DAC MIXL" },
+	{ "DAC L1", NULL, "PLL1", is_sys_clk_from_pll },
+	{ "DAC R1", NULL, "DAC R1 Power" },
+	{ "DAC R1", NULL, "Stereo DAC MIXR" },
+	{ "DAC R1", NULL, "PLL1", is_sys_clk_from_pll },
+	{ "DAC L2", NULL, "Mono DAC MIXL" },
+	{ "DAC L2", NULL, "PLL1", is_sys_clk_from_pll },
+	{ "DAC R2", NULL, "Mono DAC MIXR" },
+	{ "DAC R2", NULL, "PLL1", is_sys_clk_from_pll },
+
+	{ "OUT MIXL", "BST1 Switch", "BST1" },
+	{ "OUT MIXL", "INL Switch", "INL VOL" },
+	{ "OUT MIXL", "DAC L2 Switch", "DAC L2" },
+	{ "OUT MIXL", "DAC L1 Switch", "DAC L1" },
+
+	{ "OUT MIXR", "BST2 Switch", "BST2" },
+	{ "OUT MIXR", "INR Switch", "INR VOL" },
+	{ "OUT MIXR", "DAC R2 Switch", "DAC R2" },
+	{ "OUT MIXR", "DAC R1 Switch", "DAC R1" },
+
+	{ "HPOVOL MIXL", "DAC1 Switch", "DAC L1" },
+	{ "HPOVOL MIXL", "INL Switch", "INL VOL" },
+	{ "HPOVOL MIXR", "DAC1 Switch", "DAC R1" },
+	{ "HPOVOL MIXR", "INR Switch", "INR VOL" },
+
+	{ "DAC 2", NULL, "DAC L2" },
+	{ "DAC 2", NULL, "DAC R2" },
+	{ "DAC 1", NULL, "DAC L1" },
+	{ "DAC 1", NULL, "DAC R1" },
+	{ "HPOVOL", NULL, "HPOVOL MIXL" },
+	{ "HPOVOL", NULL, "HPOVOL MIXR" },
+	{ "HPO MIX", "DAC1 Switch", "DAC 1" },
+	{ "HPO MIX", "HPVOL Switch", "HPOVOL" },
+
+	{ "LOUT MIX", "DAC L1 Switch", "DAC L1" },
+	{ "LOUT MIX", "DAC R1 Switch", "DAC R1" },
+	{ "LOUT MIX", "OUTMIX L Switch", "OUT MIXL" },
+	{ "LOUT MIX", "OUTMIX R Switch", "OUT MIXR" },
+
+	{ "PDM1 L Mux", "Stereo DAC", "Stereo DAC MIXL" },
+	{ "PDM1 L Mux", "Mono DAC", "Mono DAC MIXL" },
+	{ "PDM1 L Mux", NULL, "PDM1 Power" },
+	{ "PDM1 R Mux", "Stereo DAC", "Stereo DAC MIXR" },
+	{ "PDM1 R Mux", "Mono DAC", "Mono DAC MIXR" },
+	{ "PDM1 R Mux", NULL, "PDM1 Power" },
+	{ "PDM2 L Mux", "Stereo DAC", "Stereo DAC MIXL" },
+	{ "PDM2 L Mux", "Mono DAC", "Mono DAC MIXL" },
+	{ "PDM2 L Mux", NULL, "PDM2 Power" },
+	{ "PDM2 R Mux", "Stereo DAC", "Stereo DAC MIXR" },
+	{ "PDM2 R Mux", "Mono DAC", "Mono DAC MIXR" },
+	{ "PDM2 R Mux", NULL, "PDM2 Power" },
+
+	{ "HP Amp", NULL, "HPO MIX" },
+	{ "HP Amp", NULL, "Mic Det Power" },
+	{ "HPOL", NULL, "HP Amp" },
+	{ "HPOL", NULL, "HP L Amp" },
+	{ "HPOL", NULL, "Improve HP Amp Drv" },
+	{ "HPOR", NULL, "HP Amp" },
+	{ "HPOR", NULL, "HP R Amp" },
+	{ "HPOR", NULL, "Improve HP Amp Drv" },
+
+	{ "LOUT Amp", NULL, "LOUT MIX" },
+	{ "LOUT L Playback", "Switch", "LOUT Amp" },
+	{ "LOUT R Playback", "Switch", "LOUT Amp" },
+	{ "LOUTL", NULL, "LOUT L Playback" },
+	{ "LOUTR", NULL, "LOUT R Playback" },
+	{ "LOUTL", NULL, "Improve HP Amp Drv" },
+	{ "LOUTR", NULL, "Improve HP Amp Drv" },
+
+	{ "PDM1L", NULL, "PDM1 L Mux" },
+	{ "PDM1R", NULL, "PDM1 R Mux" },
+	{ "PDM2L", NULL, "PDM2 L Mux" },
+	{ "PDM2R", NULL, "PDM2 R Mux" },
+};
+
+static int rt5670_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val_len = 0, val_clk, mask_clk;
+	int pre_div, bclk_ms, frame_size;
+
+	rt5670->lrck[dai->id] = params_rate(params);
+	pre_div = rl6231_get_clk_info(rt5670->sysclk, rt5670->lrck[dai->id]);
+	if (pre_div < 0) {
+		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
+			rt5670->lrck[dai->id], dai->id);
+		return -EINVAL;
+	}
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0) {
+		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
+		return -EINVAL;
+	}
+	bclk_ms = frame_size > 32;
+	rt5670->bclk[dai->id] = rt5670->lrck[dai->id] * (32 << bclk_ms);
+
+	dev_dbg(dai->dev, "bclk is %dHz and lrck is %dHz\n",
+		rt5670->bclk[dai->id], rt5670->lrck[dai->id]);
+	dev_dbg(dai->dev, "bclk_ms is %d and pre_div is %d for iis %d\n",
+				bclk_ms, pre_div, dai->id);
+
+	switch (params_width(params)) {
+	case 16:
+		break;
+	case 20:
+		val_len |= RT5670_I2S_DL_20;
+		break;
+	case 24:
+		val_len |= RT5670_I2S_DL_24;
+		break;
+	case 8:
+		val_len |= RT5670_I2S_DL_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dai->id) {
+	case RT5670_AIF1:
+		mask_clk = RT5670_I2S_BCLK_MS1_MASK | RT5670_I2S_PD1_MASK;
+		val_clk = bclk_ms << RT5670_I2S_BCLK_MS1_SFT |
+			pre_div << RT5670_I2S_PD1_SFT;
+		snd_soc_update_bits(codec, RT5670_I2S1_SDP,
+			RT5670_I2S_DL_MASK, val_len);
+		snd_soc_update_bits(codec, RT5670_ADDA_CLK1, mask_clk, val_clk);
+		break;
+	case RT5670_AIF2:
+		mask_clk = RT5670_I2S_BCLK_MS2_MASK | RT5670_I2S_PD2_MASK;
+		val_clk = bclk_ms << RT5670_I2S_BCLK_MS2_SFT |
+			pre_div << RT5670_I2S_PD2_SFT;
+		snd_soc_update_bits(codec, RT5670_I2S2_SDP,
+			RT5670_I2S_DL_MASK, val_len);
+		snd_soc_update_bits(codec, RT5670_ADDA_CLK1, mask_clk, val_clk);
+		break;
+	default:
+		dev_err(codec->dev, "Invalid dai->id: %d\n", dai->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rt5670_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		rt5670->master[dai->id] = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		reg_val |= RT5670_I2S_MS_S;
+		rt5670->master[dai->id] = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg_val |= RT5670_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg_val |= RT5670_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		reg_val |= RT5670_I2S_DF_PCM_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		reg_val |= RT5670_I2S_DF_PCM_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dai->id) {
+	case RT5670_AIF1:
+		snd_soc_update_bits(codec, RT5670_I2S1_SDP,
+			RT5670_I2S_MS_MASK | RT5670_I2S_BP_MASK |
+			RT5670_I2S_DF_MASK, reg_val);
+		break;
+	case RT5670_AIF2:
+		snd_soc_update_bits(codec, RT5670_I2S2_SDP,
+			RT5670_I2S_MS_MASK | RT5670_I2S_BP_MASK |
+			RT5670_I2S_DF_MASK, reg_val);
+		break;
+	default:
+		dev_err(codec->dev, "Invalid dai->id: %d\n", dai->id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg_val = 0;
+
+	if (freq == rt5670->sysclk && clk_id == rt5670->sysclk_src)
+		return 0;
+
+	switch (clk_id) {
+	case RT5670_SCLK_S_MCLK:
+		reg_val |= RT5670_SCLK_SRC_MCLK;
+		break;
+	case RT5670_SCLK_S_PLL1:
+		reg_val |= RT5670_SCLK_SRC_PLL1;
+		break;
+	case RT5670_SCLK_S_RCCLK:
+		reg_val |= RT5670_SCLK_SRC_RCCLK;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, RT5670_GLB_CLK,
+		RT5670_SCLK_SRC_MASK, reg_val);
+	rt5670->sysclk = freq;
+	rt5670->sysclk_src = clk_id;
+
+	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+
+	return 0;
+}
+
+static int rt5670_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
+			unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+	struct rl6231_pll_code pll_code;
+	int ret;
+
+	if (source == rt5670->pll_src && freq_in == rt5670->pll_in &&
+	    freq_out == rt5670->pll_out)
+		return 0;
+
+	if (!freq_in || !freq_out) {
+		dev_dbg(codec->dev, "PLL disabled\n");
+
+		rt5670->pll_in = 0;
+		rt5670->pll_out = 0;
+		snd_soc_update_bits(codec, RT5670_GLB_CLK,
+			RT5670_SCLK_SRC_MASK, RT5670_SCLK_SRC_MCLK);
+		return 0;
+	}
+
+	switch (source) {
+	case RT5670_PLL1_S_MCLK:
+		snd_soc_update_bits(codec, RT5670_GLB_CLK,
+			RT5670_PLL1_SRC_MASK, RT5670_PLL1_SRC_MCLK);
+		break;
+	case RT5670_PLL1_S_BCLK1:
+	case RT5670_PLL1_S_BCLK2:
+	case RT5670_PLL1_S_BCLK3:
+	case RT5670_PLL1_S_BCLK4:
+		switch (dai->id) {
+		case RT5670_AIF1:
+			snd_soc_update_bits(codec, RT5670_GLB_CLK,
+				RT5670_PLL1_SRC_MASK, RT5670_PLL1_SRC_BCLK1);
+			break;
+		case RT5670_AIF2:
+			snd_soc_update_bits(codec, RT5670_GLB_CLK,
+				RT5670_PLL1_SRC_MASK, RT5670_PLL1_SRC_BCLK2);
+			break;
+		default:
+			dev_err(codec->dev, "Invalid dai->id: %d\n", dai->id);
+			return -EINVAL;
+		}
+		break;
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
+	snd_soc_write(codec, RT5670_PLL_CTRL1,
+		pll_code.n_code << RT5670_PLL_N_SFT | pll_code.k_code);
+	snd_soc_write(codec, RT5670_PLL_CTRL2,
+		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5670_PLL_M_SFT |
+		pll_code.m_bp << RT5670_PLL_M_BP_SFT);
+
+	rt5670->pll_in = freq_in;
+	rt5670->pll_out = freq_out;
+	rt5670->pll_src = source;
+
+	return 0;
+}
+
+static int rt5670_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int val = 0;
+
+	if (rx_mask || tx_mask)
+		val |= (1 << 14);
+
+	switch (slots) {
+	case 4:
+		val |= (1 << 12);
+		break;
+	case 6:
+		val |= (2 << 12);
+		break;
+	case 8:
+		val |= (3 << 12);
+		break;
+	case 2:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (slot_width) {
+	case 20:
+		val |= (1 << 10);
+		break;
+	case 24:
+		val |= (2 << 10);
+		break;
+	case 32:
+		val |= (3 << 10);
+		break;
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, RT5670_TDM_CTRL_1, 0x7c00, val);
+
+	return 0;
+}
+
+static int rt5670_set_bias_level(struct snd_soc_codec *codec,
+			enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
+			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_PWR_VREF1 | RT5670_PWR_MB |
+				RT5670_PWR_BG | RT5670_PWR_VREF2,
+				RT5670_PWR_VREF1 | RT5670_PWR_MB |
+				RT5670_PWR_BG | RT5670_PWR_VREF2);
+			mdelay(10);
+			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_PWR_FV1 | RT5670_PWR_FV2,
+				RT5670_PWR_FV1 | RT5670_PWR_FV2);
+			snd_soc_update_bits(codec, RT5670_CHARGE_PUMP,
+				RT5670_OSW_L_MASK | RT5670_OSW_R_MASK,
+				RT5670_OSW_L_DIS | RT5670_OSW_R_DIS);
+			snd_soc_update_bits(codec, RT5670_DIG_MISC, 0x1, 0x1);
+			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_LDO_SEL_MASK, 0x3);
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		snd_soc_write(codec, RT5670_PWR_DIG1, 0x0000);
+		snd_soc_write(codec, RT5670_PWR_DIG2, 0x0001);
+		snd_soc_write(codec, RT5670_PWR_VOL, 0x0000);
+		snd_soc_write(codec, RT5670_PWR_MIXER, 0x0001);
+		snd_soc_write(codec, RT5670_PWR_ANLG1, 0x2800);
+		snd_soc_write(codec, RT5670_PWR_ANLG2, 0x0004);
+		snd_soc_update_bits(codec, RT5670_DIG_MISC, 0x1, 0x0);
+		snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_LDO_SEL_MASK, 0x1);
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
+static int rt5670_probe(struct snd_soc_codec *codec)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	rt5670->codec = codec;
+
+	return 0;
+}
+
+static int rt5670_remove(struct snd_soc_codec *codec)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_write(rt5670->regmap, RT5670_RESET, 0);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rt5670_suspend(struct snd_soc_codec *codec)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(rt5670->regmap, true);
+	regcache_mark_dirty(rt5670->regmap);
+	return 0;
+}
+
+static int rt5670_resume(struct snd_soc_codec *codec)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(rt5670->regmap, false);
+	regcache_sync(rt5670->regmap);
+
+	return 0;
+}
+#else
+#define rt5670_suspend NULL
+#define rt5670_resume NULL
+#endif
+
+#define RT5670_STEREO_RATES SNDRV_PCM_RATE_8000_96000
+#define RT5670_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
+
+struct snd_soc_dai_ops rt5670_aif_dai_ops = {
+	.hw_params = rt5670_hw_params,
+	.set_fmt = rt5670_set_dai_fmt,
+	.set_sysclk = rt5670_set_dai_sysclk,
+	.set_tdm_slot = rt5670_set_tdm_slot,
+	.set_pll = rt5670_set_dai_pll,
+};
+
+struct snd_soc_dai_driver rt5670_dai[] = {
+	{
+		.name = "rt5670-aif1",
+		.id = RT5670_AIF1,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5670_STEREO_RATES,
+			.formats = RT5670_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5670_STEREO_RATES,
+			.formats = RT5670_FORMATS,
+		},
+		.ops = &rt5670_aif_dai_ops,
+	},
+	{
+		.name = "rt5670-aif2",
+		.id = RT5670_AIF2,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5670_STEREO_RATES,
+			.formats = RT5670_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5670_STEREO_RATES,
+			.formats = RT5670_FORMATS,
+		},
+		.ops = &rt5670_aif_dai_ops,
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_rt5670 = {
+	.probe = rt5670_probe,
+	.remove = rt5670_remove,
+	.suspend = rt5670_suspend,
+	.resume = rt5670_resume,
+	.set_bias_level = rt5670_set_bias_level,
+	.idle_bias_off = true,
+	.controls = rt5670_snd_controls,
+	.num_controls = ARRAY_SIZE(rt5670_snd_controls),
+	.dapm_widgets = rt5670_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt5670_dapm_widgets),
+	.dapm_routes = rt5670_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt5670_dapm_routes),
+};
+
+static const struct regmap_config rt5670_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = RT5670_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5670_ranges) *
+					       RT5670_PR_SPACING),
+	.volatile_reg = rt5670_volatile_register,
+	.readable_reg = rt5670_readable_register,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = rt5670_reg,
+	.num_reg_defaults = ARRAY_SIZE(rt5670_reg),
+	.ranges = rt5670_ranges,
+	.num_ranges = ARRAY_SIZE(rt5670_ranges),
+};
+
+static const struct i2c_device_id rt5670_i2c_id[] = {
+	{ "rt5670", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
+
+static int rt5670_i2c_probe(struct i2c_client *i2c,
+		    const struct i2c_device_id *id)
+{
+	struct rt5670_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	struct rt5670_priv *rt5670;
+	int ret;
+	unsigned int val;
+
+	rt5670 = devm_kzalloc(&i2c->dev,
+				sizeof(struct rt5670_priv),
+				GFP_KERNEL);
+	if (NULL == rt5670)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, rt5670);
+
+	if (pdata)
+		rt5670->pdata = *pdata;
+
+	rt5670->regmap = devm_regmap_init_i2c(i2c, &rt5670_regmap);
+	if (IS_ERR(rt5670->regmap)) {
+		ret = PTR_ERR(rt5670->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	regmap_read(rt5670->regmap, RT5670_VENDOR_ID2, &val);
+	if (val != RT5670_DEVICE_ID) {
+		dev_err(&i2c->dev,
+			"Device with ID register %x is not rt5670/72\n", val);
+		return -ENODEV;
+	}
+
+	regmap_write(rt5670->regmap, RT5670_RESET, 0);
+	regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG1,
+		RT5670_PWR_HP_L | RT5670_PWR_HP_R |
+		RT5670_PWR_VREF2, RT5670_PWR_VREF2);
+	msleep(100);
+
+	regmap_write(rt5670->regmap, RT5670_RESET, 0);
+
+	ret = regmap_register_patch(rt5670->regmap, init_list,
+				    ARRAY_SIZE(init_list));
+	if (ret != 0)
+		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
+
+	if (rt5670->pdata.in2_diff)
+		regmap_update_bits(rt5670->regmap, RT5670_IN2,
+					RT5670_IN_DF2, RT5670_IN_DF2);
+
+	if (i2c->irq) {
+		regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
+				   RT5670_GP1_PIN_MASK, RT5670_GP1_PIN_IRQ);
+		regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL2,
+				   RT5670_GP1_PF_MASK, RT5670_GP1_PF_OUT);
+
+	}
+
+	if (rt5670->pdata.jd_mode) {
+		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG1,
+				   RT5670_PWR_MB, RT5670_PWR_MB);
+		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG2,
+				   RT5670_PWR_JD1, RT5670_PWR_JD1);
+		regmap_update_bits(rt5670->regmap, RT5670_IRQ_CTRL1,
+				   RT5670_JD1_1_EN_MASK, RT5670_JD1_1_EN);
+		regmap_update_bits(rt5670->regmap, RT5670_JD_CTRL3,
+				   RT5670_JD_TRI_CBJ_SEL_MASK |
+				   RT5670_JD_TRI_HPO_SEL_MASK,
+				   RT5670_JD_CBJ_JD1_1 | RT5670_JD_HPO_JD1_1);
+		switch (rt5670->pdata.jd_mode) {
+		case 1:
+			regmap_update_bits(rt5670->regmap, RT5670_A_JD_CTRL1,
+					   RT5670_JD1_MODE_MASK,
+					   RT5670_JD1_MODE_0);
+			break;
+		case 2:
+			regmap_update_bits(rt5670->regmap, RT5670_A_JD_CTRL1,
+					   RT5670_JD1_MODE_MASK,
+					   RT5670_JD1_MODE_1);
+			break;
+		case 3:
+			regmap_update_bits(rt5670->regmap, RT5670_A_JD_CTRL1,
+					   RT5670_JD1_MODE_MASK,
+					   RT5670_JD1_MODE_2);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (rt5670->pdata.dmic_en) {
+		regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
+				   RT5670_GP2_PIN_MASK,
+				   RT5670_GP2_PIN_DMIC1_SCL);
+
+		switch (rt5670->pdata.dmic1_data_pin) {
+		case RT5670_DMIC_DATA_IN2P:
+			regmap_update_bits(rt5670->regmap, RT5670_DMIC_CTRL1,
+					   RT5670_DMIC_1_DP_MASK,
+					   RT5670_DMIC_1_DP_IN2P);
+			break;
+
+		case RT5670_DMIC_DATA_GPIO6:
+			regmap_update_bits(rt5670->regmap, RT5670_DMIC_CTRL1,
+					   RT5670_DMIC_1_DP_MASK,
+					   RT5670_DMIC_1_DP_GPIO6);
+			regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
+					   RT5670_GP6_PIN_MASK,
+					   RT5670_GP6_PIN_DMIC1_SDA);
+			break;
+
+		case RT5670_DMIC_DATA_GPIO7:
+			regmap_update_bits(rt5670->regmap, RT5670_DMIC_CTRL1,
+					   RT5670_DMIC_1_DP_MASK,
+					   RT5670_DMIC_1_DP_GPIO7);
+			regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
+					   RT5670_GP7_PIN_MASK,
+					   RT5670_GP7_PIN_DMIC1_SDA);
+			break;
+
+		default:
+			break;
+		}
+
+		switch (rt5670->pdata.dmic2_data_pin) {
+		case RT5670_DMIC_DATA_IN3N:
+			regmap_update_bits(rt5670->regmap, RT5670_DMIC_CTRL1,
+					   RT5670_DMIC_2_DP_MASK,
+					   RT5670_DMIC_2_DP_IN3N);
+			break;
+
+		case RT5670_DMIC_DATA_GPIO8:
+			regmap_update_bits(rt5670->regmap, RT5670_DMIC_CTRL1,
+					   RT5670_DMIC_2_DP_MASK,
+					   RT5670_DMIC_2_DP_GPIO8);
+			regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
+					   RT5670_GP8_PIN_MASK,
+					   RT5670_GP8_PIN_DMIC2_SDA);
+			break;
+
+		default:
+			break;
+		}
+
+		switch (rt5670->pdata.dmic3_data_pin) {
+		case RT5670_DMIC_DATA_GPIO5:
+			regmap_update_bits(rt5670->regmap, RT5670_DMIC_CTRL2,
+					   RT5670_DMIC_3_DP_MASK,
+					   RT5670_DMIC_3_DP_GPIO5);
+			regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
+					   RT5670_GP5_PIN_MASK,
+					   RT5670_GP5_PIN_DMIC3_SDA);
+			break;
+
+		case RT5670_DMIC_DATA_GPIO9:
+		case RT5670_DMIC_DATA_GPIO10:
+			dev_err(&i2c->dev,
+				"Always use GPIO5 as DMIC3 data pin\n");
+			break;
+
+		default:
+			break;
+		}
+
+	}
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5670,
+			rt5670_dai, ARRAY_SIZE(rt5670_dai));
+	if (ret < 0)
+		goto err;
+
+	return 0;
+err:
+	return ret;
+}
+
+static int rt5670_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+struct i2c_driver rt5670_i2c_driver = {
+	.driver = {
+		.name = "rt5670",
+		.owner = THIS_MODULE,
+	},
+	.probe = rt5670_i2c_probe,
+	.remove   = rt5670_i2c_remove,
+	.id_table = rt5670_i2c_id,
+};
+
+module_i2c_driver(rt5670_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC RT5670 driver");
+MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
new file mode 100644
index 0000000..a0b5c85
--- /dev/null
+++ b/sound/soc/codecs/rt5670.h
@@ -0,0 +1,2000 @@
+/*
+ * rt5670.h  --  RT5670 ALSA SoC audio driver
+ *
+ * Copyright 2014 Realtek Microelectronics
+ * Author: Bard Liao <bardliao@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT5670_H__
+#define __RT5670_H__
+
+#include <sound/rt5670.h>
+
+/* Info */
+#define RT5670_RESET				0x00
+#define RT5670_VENDOR_ID			0xfd
+#define RT5670_VENDOR_ID1			0xfe
+#define RT5670_VENDOR_ID2			0xff
+/*  I/O - Output */
+#define RT5670_HP_VOL				0x02
+#define RT5670_LOUT1				0x03
+/* I/O - Input */
+#define RT5670_CJ_CTRL1				0x0a
+#define RT5670_CJ_CTRL2				0x0b
+#define RT5670_CJ_CTRL3				0x0c
+#define RT5670_IN2				0x0e
+#define RT5670_INL1_INR1_VOL			0x0f
+/* I/O - ADC/DAC/DMIC */
+#define RT5670_DAC1_DIG_VOL			0x19
+#define RT5670_DAC2_DIG_VOL			0x1a
+#define RT5670_DAC_CTRL				0x1b
+#define RT5670_STO1_ADC_DIG_VOL			0x1c
+#define RT5670_MONO_ADC_DIG_VOL			0x1d
+#define RT5670_ADC_BST_VOL1			0x1e
+#define RT5670_STO2_ADC_DIG_VOL			0x1f
+/* Mixer - D-D */
+#define RT5670_ADC_BST_VOL2			0x20
+#define RT5670_STO2_ADC_MIXER			0x26
+#define RT5670_STO1_ADC_MIXER			0x27
+#define RT5670_MONO_ADC_MIXER			0x28
+#define RT5670_AD_DA_MIXER			0x29
+#define RT5670_STO_DAC_MIXER			0x2a
+#define RT5670_DD_MIXER				0x2b
+#define RT5670_DIG_MIXER			0x2c
+#define RT5670_DSP_PATH1			0x2d
+#define RT5670_DSP_PATH2			0x2e
+#define RT5670_DIG_INF1_DATA			0x2f
+#define RT5670_DIG_INF2_DATA			0x30
+/* Mixer - PDM */
+#define RT5670_PDM_OUT_CTRL			0x31
+#define RT5670_PDM_DATA_CTRL1			0x32
+#define RT5670_PDM1_DATA_CTRL2			0x33
+#define RT5670_PDM1_DATA_CTRL3			0x34
+#define RT5670_PDM1_DATA_CTRL4			0x35
+#define RT5670_PDM2_DATA_CTRL2			0x36
+#define RT5670_PDM2_DATA_CTRL3			0x37
+#define RT5670_PDM2_DATA_CTRL4			0x38
+/* Mixer - ADC */
+#define RT5670_REC_L1_MIXER			0x3b
+#define RT5670_REC_L2_MIXER			0x3c
+#define RT5670_REC_R1_MIXER			0x3d
+#define RT5670_REC_R2_MIXER			0x3e
+/* Mixer - DAC */
+#define RT5670_HPO_MIXER			0x45
+#define RT5670_MONO_MIXER			0x4c
+#define RT5670_OUT_L1_MIXER			0x4f
+#define RT5670_OUT_R1_MIXER			0x52
+#define RT5670_LOUT_MIXER			0x53
+/* Power */
+#define RT5670_PWR_DIG1				0x61
+#define RT5670_PWR_DIG2				0x62
+#define RT5670_PWR_ANLG1			0x63
+#define RT5670_PWR_ANLG2			0x64
+#define RT5670_PWR_MIXER			0x65
+#define RT5670_PWR_VOL				0x66
+/* Private Register Control */
+#define RT5670_PRIV_INDEX			0x6a
+#define RT5670_PRIV_DATA			0x6c
+/* Format - ADC/DAC */
+#define RT5670_I2S4_SDP				0x6f
+#define RT5670_I2S1_SDP				0x70
+#define RT5670_I2S2_SDP				0x71
+#define RT5670_I2S3_SDP				0x72
+#define RT5670_ADDA_CLK1			0x73
+#define RT5670_ADDA_CLK2			0x74
+#define RT5670_DMIC_CTRL1			0x75
+#define RT5670_DMIC_CTRL2			0x76
+/* Format - TDM Control */
+#define RT5670_TDM_CTRL_1			0x77
+#define RT5670_TDM_CTRL_2			0x78
+#define RT5670_TDM_CTRL_3			0x79
+
+/* Function - Analog */
+#define RT5670_DSP_CLK				0x7f
+#define RT5670_GLB_CLK				0x80
+#define RT5670_PLL_CTRL1			0x81
+#define RT5670_PLL_CTRL2			0x82
+#define RT5670_ASRC_1				0x83
+#define RT5670_ASRC_2				0x84
+#define RT5670_ASRC_3				0x85
+#define RT5670_ASRC_4				0x86
+#define RT5670_ASRC_5				0x87
+#define RT5670_ASRC_7				0x89
+#define RT5670_ASRC_8				0x8a
+#define RT5670_ASRC_9				0x8b
+#define RT5670_ASRC_10				0x8c
+#define RT5670_ASRC_11				0x8d
+#define RT5670_DEPOP_M1				0x8e
+#define RT5670_DEPOP_M2				0x8f
+#define RT5670_DEPOP_M3				0x90
+#define RT5670_CHARGE_PUMP			0x91
+#define RT5670_MICBIAS				0x93
+#define RT5670_A_JD_CTRL1			0x94
+#define RT5670_A_JD_CTRL2			0x95
+#define RT5670_ASRC_12				0x97
+#define RT5670_ASRC_13				0x98
+#define RT5670_ASRC_14				0x99
+#define RT5670_VAD_CTRL1			0x9a
+#define RT5670_VAD_CTRL2			0x9b
+#define RT5670_VAD_CTRL3			0x9c
+#define RT5670_VAD_CTRL4			0x9d
+#define RT5670_VAD_CTRL5			0x9e
+/* Function - Digital */
+#define RT5670_ADC_EQ_CTRL1			0xae
+#define RT5670_ADC_EQ_CTRL2			0xaf
+#define RT5670_EQ_CTRL1				0xb0
+#define RT5670_EQ_CTRL2				0xb1
+#define RT5670_ALC_DRC_CTRL1			0xb2
+#define RT5670_ALC_DRC_CTRL2			0xb3
+#define RT5670_ALC_CTRL_1			0xb4
+#define RT5670_ALC_CTRL_2			0xb5
+#define RT5670_ALC_CTRL_3			0xb6
+#define RT5670_ALC_CTRL_4			0xb7
+#define RT5670_JD_CTRL				0xbb
+#define RT5670_IRQ_CTRL1			0xbd
+#define RT5670_IRQ_CTRL2			0xbe
+#define RT5670_INT_IRQ_ST			0xbf
+#define RT5670_GPIO_CTRL1			0xc0
+#define RT5670_GPIO_CTRL2			0xc1
+#define RT5670_GPIO_CTRL3			0xc2
+#define RT5670_SCRABBLE_FUN			0xcd
+#define RT5670_SCRABBLE_CTRL			0xce
+#define RT5670_BASE_BACK			0xcf
+#define RT5670_MP3_PLUS1			0xd0
+#define RT5670_MP3_PLUS2			0xd1
+#define RT5670_ADJ_HPF1				0xd3
+#define RT5670_ADJ_HPF2				0xd4
+#define RT5670_HP_CALIB_AMP_DET			0xd6
+#define RT5670_SV_ZCD1				0xd9
+#define RT5670_SV_ZCD2				0xda
+#define RT5670_IL_CMD				0xdb
+#define RT5670_IL_CMD2				0xdc
+#define RT5670_IL_CMD3				0xdd
+#define RT5670_DRC_HL_CTRL1			0xe6
+#define RT5670_DRC_HL_CTRL2			0xe7
+#define RT5670_ADC_MONO_HP_CTRL1		0xec
+#define RT5670_ADC_MONO_HP_CTRL2		0xed
+#define RT5670_ADC_STO2_HP_CTRL1		0xee
+#define RT5670_ADC_STO2_HP_CTRL2		0xef
+#define RT5670_JD_CTRL3				0xf8
+#define RT5670_JD_CTRL4				0xf9
+/* General Control */
+#define RT5670_DIG_MISC				0xfa
+#define RT5670_GEN_CTRL2			0xfb
+#define RT5670_GEN_CTRL3			0xfc
+
+
+/* Index of Codec Private Register definition */
+#define RT5670_DIG_VOL				0x00
+#define RT5670_PR_ALC_CTRL_1			0x01
+#define RT5670_PR_ALC_CTRL_2			0x02
+#define RT5670_PR_ALC_CTRL_3			0x03
+#define RT5670_PR_ALC_CTRL_4			0x04
+#define RT5670_PR_ALC_CTRL_5			0x05
+#define RT5670_PR_ALC_CTRL_6			0x06
+#define RT5670_BIAS_CUR1			0x12
+#define RT5670_BIAS_CUR3			0x14
+#define RT5670_CLSD_INT_REG1			0x1c
+#define RT5670_MAMP_INT_REG2			0x37
+#define RT5670_CHOP_DAC_ADC			0x3d
+#define RT5670_MIXER_INT_REG			0x3f
+#define RT5670_3D_SPK				0x63
+#define RT5670_WND_1				0x6c
+#define RT5670_WND_2				0x6d
+#define RT5670_WND_3				0x6e
+#define RT5670_WND_4				0x6f
+#define RT5670_WND_5				0x70
+#define RT5670_WND_8				0x73
+#define RT5670_DIP_SPK_INF			0x75
+#define RT5670_HP_DCC_INT1			0x77
+#define RT5670_EQ_BW_LOP			0xa0
+#define RT5670_EQ_GN_LOP			0xa1
+#define RT5670_EQ_FC_BP1			0xa2
+#define RT5670_EQ_BW_BP1			0xa3
+#define RT5670_EQ_GN_BP1			0xa4
+#define RT5670_EQ_FC_BP2			0xa5
+#define RT5670_EQ_BW_BP2			0xa6
+#define RT5670_EQ_GN_BP2			0xa7
+#define RT5670_EQ_FC_BP3			0xa8
+#define RT5670_EQ_BW_BP3			0xa9
+#define RT5670_EQ_GN_BP3			0xaa
+#define RT5670_EQ_FC_BP4			0xab
+#define RT5670_EQ_BW_BP4			0xac
+#define RT5670_EQ_GN_BP4			0xad
+#define RT5670_EQ_FC_HIP1			0xae
+#define RT5670_EQ_GN_HIP1			0xaf
+#define RT5670_EQ_FC_HIP2			0xb0
+#define RT5670_EQ_BW_HIP2			0xb1
+#define RT5670_EQ_GN_HIP2			0xb2
+#define RT5670_EQ_PRE_VOL			0xb3
+#define RT5670_EQ_PST_VOL			0xb4
+
+
+/* global definition */
+#define RT5670_L_MUTE				(0x1 << 15)
+#define RT5670_L_MUTE_SFT			15
+#define RT5670_VOL_L_MUTE			(0x1 << 14)
+#define RT5670_VOL_L_SFT			14
+#define RT5670_R_MUTE				(0x1 << 7)
+#define RT5670_R_MUTE_SFT			7
+#define RT5670_VOL_R_MUTE			(0x1 << 6)
+#define RT5670_VOL_R_SFT			6
+#define RT5670_L_VOL_MASK			(0x3f << 8)
+#define RT5670_L_VOL_SFT			8
+#define RT5670_R_VOL_MASK			(0x3f)
+#define RT5670_R_VOL_SFT			0
+
+/* Combo Jack Control 1 (0x0a) */
+#define RT5670_CBJ_BST1_MASK			(0xf << 12)
+#define RT5670_CBJ_BST1_SFT			(12)
+#define RT5670_CBJ_JD_HP_EN			(0x1 << 9)
+#define RT5670_CBJ_JD_MIC_EN			(0x1 << 8)
+#define RT5670_CBJ_BST1_EN			(0x1 << 2)
+
+/* Combo Jack Control 1 (0x0b) */
+#define RT5670_CBJ_MN_JD			(0x1 << 12)
+#define RT5670_CAPLESS_EN			(0x1 << 11)
+#define RT5670_CBJ_DET_MODE			(0x1 << 7)
+
+/* IN2 Control (0x0e) */
+#define RT5670_BST_MASK1			(0xf<<12)
+#define RT5670_BST_SFT1				12
+#define RT5670_BST_MASK2			(0xf<<8)
+#define RT5670_BST_SFT2				8
+#define RT5670_IN_DF1				(0x1 << 7)
+#define RT5670_IN_SFT1				7
+#define RT5670_IN_DF2				(0x1 << 6)
+#define RT5670_IN_SFT2				6
+
+/* INL and INR Volume Control (0x0f) */
+#define RT5670_INL_SEL_MASK			(0x1 << 15)
+#define RT5670_INL_SEL_SFT			15
+#define RT5670_INL_SEL_IN4P			(0x0 << 15)
+#define RT5670_INL_SEL_MONOP			(0x1 << 15)
+#define RT5670_INL_VOL_MASK			(0x1f << 8)
+#define RT5670_INL_VOL_SFT			8
+#define RT5670_INR_SEL_MASK			(0x1 << 7)
+#define RT5670_INR_SEL_SFT			7
+#define RT5670_INR_SEL_IN4N			(0x0 << 7)
+#define RT5670_INR_SEL_MONON			(0x1 << 7)
+#define RT5670_INR_VOL_MASK			(0x1f)
+#define RT5670_INR_VOL_SFT			0
+
+/* Sidetone Control (0x18) */
+#define RT5670_ST_SEL_MASK			(0x7 << 9)
+#define RT5670_ST_SEL_SFT			9
+#define RT5670_M_ST_DACR2			(0x1 << 8)
+#define RT5670_M_ST_DACR2_SFT			8
+#define RT5670_M_ST_DACL2			(0x1 << 7)
+#define RT5670_M_ST_DACL2_SFT			7
+#define RT5670_ST_EN				(0x1 << 6)
+#define RT5670_ST_EN_SFT			6
+
+/* DAC1 Digital Volume (0x19) */
+#define RT5670_DAC_L1_VOL_MASK			(0xff << 8)
+#define RT5670_DAC_L1_VOL_SFT			8
+#define RT5670_DAC_R1_VOL_MASK			(0xff)
+#define RT5670_DAC_R1_VOL_SFT			0
+
+/* DAC2 Digital Volume (0x1a) */
+#define RT5670_DAC_L2_VOL_MASK			(0xff << 8)
+#define RT5670_DAC_L2_VOL_SFT			8
+#define RT5670_DAC_R2_VOL_MASK			(0xff)
+#define RT5670_DAC_R2_VOL_SFT			0
+
+/* DAC2 Control (0x1b) */
+#define RT5670_M_DAC_L2_VOL			(0x1 << 13)
+#define RT5670_M_DAC_L2_VOL_SFT			13
+#define RT5670_M_DAC_R2_VOL			(0x1 << 12)
+#define RT5670_M_DAC_R2_VOL_SFT			12
+#define RT5670_DAC2_L_SEL_MASK			(0x7 << 4)
+#define RT5670_DAC2_L_SEL_SFT			4
+#define RT5670_DAC2_R_SEL_MASK			(0x7 << 0)
+#define RT5670_DAC2_R_SEL_SFT			0
+
+/* ADC Digital Volume Control (0x1c) */
+#define RT5670_ADC_L_VOL_MASK			(0x7f << 8)
+#define RT5670_ADC_L_VOL_SFT			8
+#define RT5670_ADC_R_VOL_MASK			(0x7f)
+#define RT5670_ADC_R_VOL_SFT			0
+
+/* Mono ADC Digital Volume Control (0x1d) */
+#define RT5670_MONO_ADC_L_VOL_MASK		(0x7f << 8)
+#define RT5670_MONO_ADC_L_VOL_SFT		8
+#define RT5670_MONO_ADC_R_VOL_MASK		(0x7f)
+#define RT5670_MONO_ADC_R_VOL_SFT		0
+
+/* ADC Boost Volume Control (0x1e) */
+#define RT5670_STO1_ADC_L_BST_MASK		(0x3 << 14)
+#define RT5670_STO1_ADC_L_BST_SFT		14
+#define RT5670_STO1_ADC_R_BST_MASK		(0x3 << 12)
+#define RT5670_STO1_ADC_R_BST_SFT		12
+#define RT5670_STO1_ADC_COMP_MASK		(0x3 << 10)
+#define RT5670_STO1_ADC_COMP_SFT		10
+#define RT5670_STO2_ADC_L_BST_MASK		(0x3 << 8)
+#define RT5670_STO2_ADC_L_BST_SFT		8
+#define RT5670_STO2_ADC_R_BST_MASK		(0x3 << 6)
+#define RT5670_STO2_ADC_R_BST_SFT		6
+#define RT5670_STO2_ADC_COMP_MASK		(0x3 << 4)
+#define RT5670_STO2_ADC_COMP_SFT		4
+
+/* Stereo2 ADC Mixer Control (0x26) */
+#define RT5670_STO2_ADC_SRC_MASK		(0x1 << 15)
+#define RT5670_STO2_ADC_SRC_SFT			15
+
+/* Stereo ADC Mixer Control (0x26 0x27) */
+#define RT5670_M_ADC_L1				(0x1 << 14)
+#define RT5670_M_ADC_L1_SFT			14
+#define RT5670_M_ADC_L2				(0x1 << 13)
+#define RT5670_M_ADC_L2_SFT			13
+#define RT5670_ADC_1_SRC_MASK			(0x1 << 12)
+#define RT5670_ADC_1_SRC_SFT			12
+#define RT5670_ADC_1_SRC_ADC			(0x1 << 12)
+#define RT5670_ADC_1_SRC_DACMIX			(0x0 << 12)
+#define RT5670_ADC_2_SRC_MASK			(0x1 << 11)
+#define RT5670_ADC_2_SRC_SFT			11
+#define RT5670_ADC_SRC_MASK			(0x1 << 10)
+#define RT5670_ADC_SRC_SFT			10
+#define RT5670_DMIC_SRC_MASK			(0x3 << 8)
+#define RT5670_DMIC_SRC_SFT			8
+#define RT5670_M_ADC_R1				(0x1 << 6)
+#define RT5670_M_ADC_R1_SFT			6
+#define RT5670_M_ADC_R2				(0x1 << 5)
+#define RT5670_M_ADC_R2_SFT			5
+#define RT5670_DMIC3_SRC_MASK			(0x1 << 1)
+#define RT5670_DMIC3_SRC_SFT			0
+
+/* Mono ADC Mixer Control (0x28) */
+#define RT5670_M_MONO_ADC_L1			(0x1 << 14)
+#define RT5670_M_MONO_ADC_L1_SFT		14
+#define RT5670_M_MONO_ADC_L2			(0x1 << 13)
+#define RT5670_M_MONO_ADC_L2_SFT		13
+#define RT5670_MONO_ADC_L1_SRC_MASK		(0x1 << 12)
+#define RT5670_MONO_ADC_L1_SRC_SFT		12
+#define RT5670_MONO_ADC_L1_SRC_DACMIXL		(0x0 << 12)
+#define RT5670_MONO_ADC_L1_SRC_ADCL		(0x1 << 12)
+#define RT5670_MONO_ADC_L2_SRC_MASK		(0x1 << 11)
+#define RT5670_MONO_ADC_L2_SRC_SFT		11
+#define RT5670_MONO_ADC_L_SRC_MASK		(0x1 << 10)
+#define RT5670_MONO_ADC_L_SRC_SFT		10
+#define RT5670_MONO_DMIC_L_SRC_MASK		(0x3 << 8)
+#define RT5670_MONO_DMIC_L_SRC_SFT		8
+#define RT5670_M_MONO_ADC_R1			(0x1 << 6)
+#define RT5670_M_MONO_ADC_R1_SFT		6
+#define RT5670_M_MONO_ADC_R2			(0x1 << 5)
+#define RT5670_M_MONO_ADC_R2_SFT		5
+#define RT5670_MONO_ADC_R1_SRC_MASK		(0x1 << 4)
+#define RT5670_MONO_ADC_R1_SRC_SFT		4
+#define RT5670_MONO_ADC_R1_SRC_ADCR		(0x1 << 4)
+#define RT5670_MONO_ADC_R1_SRC_DACMIXR		(0x0 << 4)
+#define RT5670_MONO_ADC_R2_SRC_MASK		(0x1 << 3)
+#define RT5670_MONO_ADC_R2_SRC_SFT		3
+#define RT5670_MONO_DMIC_R_SRC_MASK		(0x3)
+#define RT5670_MONO_DMIC_R_SRC_SFT		0
+
+/* ADC Mixer to DAC Mixer Control (0x29) */
+#define RT5670_M_ADCMIX_L			(0x1 << 15)
+#define RT5670_M_ADCMIX_L_SFT			15
+#define RT5670_M_DAC1_L				(0x1 << 14)
+#define RT5670_M_DAC1_L_SFT			14
+#define RT5670_DAC1_R_SEL_MASK			(0x3 << 10)
+#define RT5670_DAC1_R_SEL_SFT			10
+#define RT5670_DAC1_R_SEL_IF1			(0x0 << 10)
+#define RT5670_DAC1_R_SEL_IF2			(0x1 << 10)
+#define RT5670_DAC1_R_SEL_IF3			(0x2 << 10)
+#define RT5670_DAC1_R_SEL_IF4			(0x3 << 10)
+#define RT5670_DAC1_L_SEL_MASK			(0x3 << 8)
+#define RT5670_DAC1_L_SEL_SFT			8
+#define RT5670_DAC1_L_SEL_IF1			(0x0 << 8)
+#define RT5670_DAC1_L_SEL_IF2			(0x1 << 8)
+#define RT5670_DAC1_L_SEL_IF3			(0x2 << 8)
+#define RT5670_DAC1_L_SEL_IF4			(0x3 << 8)
+#define RT5670_M_ADCMIX_R			(0x1 << 7)
+#define RT5670_M_ADCMIX_R_SFT			7
+#define RT5670_M_DAC1_R				(0x1 << 6)
+#define RT5670_M_DAC1_R_SFT			6
+
+/* Stereo DAC Mixer Control (0x2a) */
+#define RT5670_M_DAC_L1				(0x1 << 14)
+#define RT5670_M_DAC_L1_SFT			14
+#define RT5670_DAC_L1_STO_L_VOL_MASK		(0x1 << 13)
+#define RT5670_DAC_L1_STO_L_VOL_SFT		13
+#define RT5670_M_DAC_L2				(0x1 << 12)
+#define RT5670_M_DAC_L2_SFT			12
+#define RT5670_DAC_L2_STO_L_VOL_MASK		(0x1 << 11)
+#define RT5670_DAC_L2_STO_L_VOL_SFT		11
+#define RT5670_M_DAC_R1_STO_L			(0x1 << 9)
+#define RT5670_M_DAC_R1_STO_L_SFT		9
+#define RT5670_DAC_R1_STO_L_VOL_MASK		(0x1 << 8)
+#define RT5670_DAC_R1_STO_L_VOL_SFT		8
+#define RT5670_M_DAC_R1				(0x1 << 6)
+#define RT5670_M_DAC_R1_SFT			6
+#define RT5670_DAC_R1_STO_R_VOL_MASK		(0x1 << 5)
+#define RT5670_DAC_R1_STO_R_VOL_SFT		5
+#define RT5670_M_DAC_R2				(0x1 << 4)
+#define RT5670_M_DAC_R2_SFT			4
+#define RT5670_DAC_R2_STO_R_VOL_MASK		(0x1 << 3)
+#define RT5670_DAC_R2_STO_R_VOL_SFT		3
+#define RT5670_M_DAC_L1_STO_R			(0x1 << 1)
+#define RT5670_M_DAC_L1_STO_R_SFT		1
+#define RT5670_DAC_L1_STO_R_VOL_MASK		(0x1)
+#define RT5670_DAC_L1_STO_R_VOL_SFT		0
+
+/* Mono DAC Mixer Control (0x2b) */
+#define RT5670_M_DAC_L1_MONO_L			(0x1 << 14)
+#define RT5670_M_DAC_L1_MONO_L_SFT		14
+#define RT5670_DAC_L1_MONO_L_VOL_MASK		(0x1 << 13)
+#define RT5670_DAC_L1_MONO_L_VOL_SFT		13
+#define RT5670_M_DAC_L2_MONO_L			(0x1 << 12)
+#define RT5670_M_DAC_L2_MONO_L_SFT		12
+#define RT5670_DAC_L2_MONO_L_VOL_MASK		(0x1 << 11)
+#define RT5670_DAC_L2_MONO_L_VOL_SFT		11
+#define RT5670_M_DAC_R2_MONO_L			(0x1 << 10)
+#define RT5670_M_DAC_R2_MONO_L_SFT		10
+#define RT5670_DAC_R2_MONO_L_VOL_MASK		(0x1 << 9)
+#define RT5670_DAC_R2_MONO_L_VOL_SFT		9
+#define RT5670_M_DAC_R1_MONO_R			(0x1 << 6)
+#define RT5670_M_DAC_R1_MONO_R_SFT		6
+#define RT5670_DAC_R1_MONO_R_VOL_MASK		(0x1 << 5)
+#define RT5670_DAC_R1_MONO_R_VOL_SFT		5
+#define RT5670_M_DAC_R2_MONO_R			(0x1 << 4)
+#define RT5670_M_DAC_R2_MONO_R_SFT		4
+#define RT5670_DAC_R2_MONO_R_VOL_MASK		(0x1 << 3)
+#define RT5670_DAC_R2_MONO_R_VOL_SFT		3
+#define RT5670_M_DAC_L2_MONO_R			(0x1 << 2)
+#define RT5670_M_DAC_L2_MONO_R_SFT		2
+#define RT5670_DAC_L2_MONO_R_VOL_MASK		(0x1 << 1)
+#define RT5670_DAC_L2_MONO_R_VOL_SFT		1
+
+/* Digital Mixer Control (0x2c) */
+#define RT5670_M_STO_L_DAC_L			(0x1 << 15)
+#define RT5670_M_STO_L_DAC_L_SFT		15
+#define RT5670_STO_L_DAC_L_VOL_MASK		(0x1 << 14)
+#define RT5670_STO_L_DAC_L_VOL_SFT		14
+#define RT5670_M_DAC_L2_DAC_L			(0x1 << 13)
+#define RT5670_M_DAC_L2_DAC_L_SFT		13
+#define RT5670_DAC_L2_DAC_L_VOL_MASK		(0x1 << 12)
+#define RT5670_DAC_L2_DAC_L_VOL_SFT		12
+#define RT5670_M_STO_R_DAC_R			(0x1 << 11)
+#define RT5670_M_STO_R_DAC_R_SFT		11
+#define RT5670_STO_R_DAC_R_VOL_MASK		(0x1 << 10)
+#define RT5670_STO_R_DAC_R_VOL_SFT		10
+#define RT5670_M_DAC_R2_DAC_R			(0x1 << 9)
+#define RT5670_M_DAC_R2_DAC_R_SFT		9
+#define RT5670_DAC_R2_DAC_R_VOL_MASK		(0x1 << 8)
+#define RT5670_DAC_R2_DAC_R_VOL_SFT		8
+#define RT5670_M_DAC_R2_DAC_L			(0x1 << 7)
+#define RT5670_M_DAC_R2_DAC_L_SFT		7
+#define RT5670_DAC_R2_DAC_L_VOL_MASK		(0x1 << 6)
+#define RT5670_DAC_R2_DAC_L_VOL_SFT		6
+#define RT5670_M_DAC_L2_DAC_R			(0x1 << 5)
+#define RT5670_M_DAC_L2_DAC_R_SFT		5
+#define RT5670_DAC_L2_DAC_R_VOL_MASK		(0x1 << 4)
+#define RT5670_DAC_L2_DAC_R_VOL_SFT		4
+
+/* DSP Path Control 1 (0x2d) */
+#define RT5670_RXDP_SEL_MASK			(0x7 << 13)
+#define RT5670_RXDP_SEL_SFT			13
+#define RT5670_RXDP_SRC_MASK			(0x3 << 11)
+#define RT5670_RXDP_SRC_SFT			11
+#define RT5670_RXDP_SRC_NOR			(0x0 << 11)
+#define RT5670_RXDP_SRC_DIV2			(0x1 << 11)
+#define RT5670_RXDP_SRC_DIV3			(0x2 << 11)
+#define RT5670_TXDP_SRC_MASK			(0x3 << 4)
+#define RT5670_TXDP_SRC_SFT			4
+#define RT5670_TXDP_SRC_NOR			(0x0 << 4)
+#define RT5670_TXDP_SRC_DIV2			(0x1 << 4)
+#define RT5670_TXDP_SRC_DIV3			(0x2 << 4)
+#define RT5670_TXDP_SLOT_SEL_MASK		(0x3 << 2)
+#define RT5670_TXDP_SLOT_SEL_SFT		2
+#define RT5670_DSP_UL_SEL			(0x1 << 1)
+#define RT5670_DSP_UL_SFT			1
+#define RT5670_DSP_DL_SEL			0x1
+#define RT5670_DSP_DL_SFT			0
+
+/* DSP Path Control 2 (0x2e) */
+#define RT5670_TXDP_L_VOL_MASK			(0x7f << 8)
+#define RT5670_TXDP_L_VOL_SFT			8
+#define RT5670_TXDP_R_VOL_MASK			(0x7f)
+#define RT5670_TXDP_R_VOL_SFT			0
+
+/* Digital Interface Data Control (0x2f) */
+#define RT5670_IF1_ADC2_IN_SEL			(0x1 << 15)
+#define RT5670_IF1_ADC2_IN_SFT			15
+#define RT5670_IF2_ADC_IN_MASK			(0x7 << 12)
+#define RT5670_IF2_ADC_IN_SFT			12
+#define RT5670_IF2_DAC_SEL_MASK			(0x3 << 10)
+#define RT5670_IF2_DAC_SEL_SFT			10
+#define RT5670_IF2_ADC_SEL_MASK			(0x3 << 8)
+#define RT5670_IF2_ADC_SEL_SFT			8
+
+/* Digital Interface Data Control (0x30) */
+#define RT5670_IF4_ADC_IN_MASK			(0x3 << 4)
+#define RT5670_IF4_ADC_IN_SFT			4
+
+/* PDM Output Control (0x31) */
+#define RT5670_PDM1_L_MASK			(0x1 << 15)
+#define RT5670_PDM1_L_SFT			15
+#define RT5670_M_PDM1_L				(0x1 << 14)
+#define RT5670_M_PDM1_L_SFT			14
+#define RT5670_PDM1_R_MASK			(0x1 << 13)
+#define RT5670_PDM1_R_SFT			13
+#define RT5670_M_PDM1_R				(0x1 << 12)
+#define RT5670_M_PDM1_R_SFT			12
+#define RT5670_PDM2_L_MASK			(0x1 << 11)
+#define RT5670_PDM2_L_SFT			11
+#define RT5670_M_PDM2_L				(0x1 << 10)
+#define RT5670_M_PDM2_L_SFT			10
+#define RT5670_PDM2_R_MASK			(0x1 << 9)
+#define RT5670_PDM2_R_SFT			9
+#define RT5670_M_PDM2_R				(0x1 << 8)
+#define RT5670_M_PDM2_R_SFT			8
+#define RT5670_PDM2_BUSY			(0x1 << 7)
+#define RT5670_PDM1_BUSY			(0x1 << 6)
+#define RT5670_PDM_PATTERN			(0x1 << 5)
+#define RT5670_PDM_GAIN				(0x1 << 4)
+#define RT5670_PDM_DIV_MASK			(0x3)
+
+/* REC Left Mixer Control 1 (0x3b) */
+#define RT5670_G_HP_L_RM_L_MASK			(0x7 << 13)
+#define RT5670_G_HP_L_RM_L_SFT			13
+#define RT5670_G_IN_L_RM_L_MASK			(0x7 << 10)
+#define RT5670_G_IN_L_RM_L_SFT			10
+#define RT5670_G_BST4_RM_L_MASK			(0x7 << 7)
+#define RT5670_G_BST4_RM_L_SFT			7
+#define RT5670_G_BST3_RM_L_MASK			(0x7 << 4)
+#define RT5670_G_BST3_RM_L_SFT			4
+#define RT5670_G_BST2_RM_L_MASK			(0x7 << 1)
+#define RT5670_G_BST2_RM_L_SFT			1
+
+/* REC Left Mixer Control 2 (0x3c) */
+#define RT5670_G_BST1_RM_L_MASK			(0x7 << 13)
+#define RT5670_G_BST1_RM_L_SFT			13
+#define RT5670_M_IN_L_RM_L			(0x1 << 5)
+#define RT5670_M_IN_L_RM_L_SFT			5
+#define RT5670_M_BST2_RM_L			(0x1 << 3)
+#define RT5670_M_BST2_RM_L_SFT			3
+#define RT5670_M_BST1_RM_L			(0x1 << 1)
+#define RT5670_M_BST1_RM_L_SFT			1
+
+/* REC Right Mixer Control 1 (0x3d) */
+#define RT5670_G_HP_R_RM_R_MASK			(0x7 << 13)
+#define RT5670_G_HP_R_RM_R_SFT			13
+#define RT5670_G_IN_R_RM_R_MASK			(0x7 << 10)
+#define RT5670_G_IN_R_RM_R_SFT			10
+#define RT5670_G_BST4_RM_R_MASK			(0x7 << 7)
+#define RT5670_G_BST4_RM_R_SFT			7
+#define RT5670_G_BST3_RM_R_MASK			(0x7 << 4)
+#define RT5670_G_BST3_RM_R_SFT			4
+#define RT5670_G_BST2_RM_R_MASK			(0x7 << 1)
+#define RT5670_G_BST2_RM_R_SFT			1
+
+/* REC Right Mixer Control 2 (0x3e) */
+#define RT5670_G_BST1_RM_R_MASK			(0x7 << 13)
+#define RT5670_G_BST1_RM_R_SFT			13
+#define RT5670_M_IN_R_RM_R			(0x1 << 5)
+#define RT5670_M_IN_R_RM_R_SFT			5
+#define RT5670_M_BST2_RM_R			(0x1 << 3)
+#define RT5670_M_BST2_RM_R_SFT			3
+#define RT5670_M_BST1_RM_R			(0x1 << 1)
+#define RT5670_M_BST1_RM_R_SFT			1
+
+/* HPMIX Control (0x45) */
+#define RT5670_M_DAC2_HM			(0x1 << 15)
+#define RT5670_M_DAC2_HM_SFT			15
+#define RT5670_M_HPVOL_HM			(0x1 << 14)
+#define RT5670_M_HPVOL_HM_SFT			14
+#define RT5670_M_DAC1_HM			(0x1 << 13)
+#define RT5670_M_DAC1_HM_SFT			13
+#define RT5670_G_HPOMIX_MASK			(0x1 << 12)
+#define RT5670_G_HPOMIX_SFT			12
+#define RT5670_M_INR1_HMR			(0x1 << 3)
+#define RT5670_M_INR1_HMR_SFT			3
+#define RT5670_M_DACR1_HMR			(0x1 << 2)
+#define RT5670_M_DACR1_HMR_SFT			2
+#define RT5670_M_INL1_HML			(0x1 << 1)
+#define RT5670_M_INL1_HML_SFT			1
+#define RT5670_M_DACL1_HML			(0x1)
+#define RT5670_M_DACL1_HML_SFT			0
+
+/* Mono Output Mixer Control (0x4c) */
+#define RT5670_M_DAC_R2_MA			(0x1 << 15)
+#define RT5670_M_DAC_R2_MA_SFT			15
+#define RT5670_M_DAC_L2_MA			(0x1 << 14)
+#define RT5670_M_DAC_L2_MA_SFT			14
+#define RT5670_M_OV_R_MM			(0x1 << 13)
+#define RT5670_M_OV_R_MM_SFT			13
+#define RT5670_M_OV_L_MM			(0x1 << 12)
+#define RT5670_M_OV_L_MM_SFT			12
+#define RT5670_G_MONOMIX_MASK			(0x1 << 10)
+#define RT5670_G_MONOMIX_SFT			10
+#define RT5670_M_DAC_R2_MM			(0x1 << 9)
+#define RT5670_M_DAC_R2_MM_SFT			9
+#define RT5670_M_DAC_L2_MM			(0x1 << 8)
+#define RT5670_M_DAC_L2_MM_SFT			8
+#define RT5670_M_BST4_MM			(0x1 << 7)
+#define RT5670_M_BST4_MM_SFT			7
+
+/* Output Left Mixer Control 1 (0x4d) */
+#define RT5670_G_BST3_OM_L_MASK			(0x7 << 13)
+#define RT5670_G_BST3_OM_L_SFT			13
+#define RT5670_G_BST2_OM_L_MASK			(0x7 << 10)
+#define RT5670_G_BST2_OM_L_SFT			10
+#define RT5670_G_BST1_OM_L_MASK			(0x7 << 7)
+#define RT5670_G_BST1_OM_L_SFT			7
+#define RT5670_G_IN_L_OM_L_MASK			(0x7 << 4)
+#define RT5670_G_IN_L_OM_L_SFT			4
+#define RT5670_G_RM_L_OM_L_MASK			(0x7 << 1)
+#define RT5670_G_RM_L_OM_L_SFT			1
+
+/* Output Left Mixer Control 2 (0x4e) */
+#define RT5670_G_DAC_R2_OM_L_MASK		(0x7 << 13)
+#define RT5670_G_DAC_R2_OM_L_SFT		13
+#define RT5670_G_DAC_L2_OM_L_MASK		(0x7 << 10)
+#define RT5670_G_DAC_L2_OM_L_SFT		10
+#define RT5670_G_DAC_L1_OM_L_MASK		(0x7 << 7)
+#define RT5670_G_DAC_L1_OM_L_SFT		7
+
+/* Output Left Mixer Control 3 (0x4f) */
+#define RT5670_M_BST1_OM_L			(0x1 << 5)
+#define RT5670_M_BST1_OM_L_SFT			5
+#define RT5670_M_IN_L_OM_L			(0x1 << 4)
+#define RT5670_M_IN_L_OM_L_SFT			4
+#define RT5670_M_DAC_L2_OM_L			(0x1 << 1)
+#define RT5670_M_DAC_L2_OM_L_SFT		1
+#define RT5670_M_DAC_L1_OM_L			(0x1)
+#define RT5670_M_DAC_L1_OM_L_SFT		0
+
+/* Output Right Mixer Control 1 (0x50) */
+#define RT5670_G_BST4_OM_R_MASK			(0x7 << 13)
+#define RT5670_G_BST4_OM_R_SFT			13
+#define RT5670_G_BST2_OM_R_MASK			(0x7 << 10)
+#define RT5670_G_BST2_OM_R_SFT			10
+#define RT5670_G_BST1_OM_R_MASK			(0x7 << 7)
+#define RT5670_G_BST1_OM_R_SFT			7
+#define RT5670_G_IN_R_OM_R_MASK			(0x7 << 4)
+#define RT5670_G_IN_R_OM_R_SFT			4
+#define RT5670_G_RM_R_OM_R_MASK			(0x7 << 1)
+#define RT5670_G_RM_R_OM_R_SFT			1
+
+/* Output Right Mixer Control 2 (0x51) */
+#define RT5670_G_DAC_L2_OM_R_MASK		(0x7 << 13)
+#define RT5670_G_DAC_L2_OM_R_SFT		13
+#define RT5670_G_DAC_R2_OM_R_MASK		(0x7 << 10)
+#define RT5670_G_DAC_R2_OM_R_SFT		10
+#define RT5670_G_DAC_R1_OM_R_MASK		(0x7 << 7)
+#define RT5670_G_DAC_R1_OM_R_SFT		7
+
+/* Output Right Mixer Control 3 (0x52) */
+#define RT5670_M_BST2_OM_R			(0x1 << 6)
+#define RT5670_M_BST2_OM_R_SFT			6
+#define RT5670_M_IN_R_OM_R			(0x1 << 4)
+#define RT5670_M_IN_R_OM_R_SFT			4
+#define RT5670_M_DAC_R2_OM_R			(0x1 << 1)
+#define RT5670_M_DAC_R2_OM_R_SFT		1
+#define RT5670_M_DAC_R1_OM_R			(0x1)
+#define RT5670_M_DAC_R1_OM_R_SFT		0
+
+/* LOUT Mixer Control (0x53) */
+#define RT5670_M_DAC_L1_LM			(0x1 << 15)
+#define RT5670_M_DAC_L1_LM_SFT			15
+#define RT5670_M_DAC_R1_LM			(0x1 << 14)
+#define RT5670_M_DAC_R1_LM_SFT			14
+#define RT5670_M_OV_L_LM			(0x1 << 13)
+#define RT5670_M_OV_L_LM_SFT			13
+#define RT5670_M_OV_R_LM			(0x1 << 12)
+#define RT5670_M_OV_R_LM_SFT			12
+#define RT5670_G_LOUTMIX_MASK			(0x1 << 11)
+#define RT5670_G_LOUTMIX_SFT			11
+
+/* Power Management for Digital 1 (0x61) */
+#define RT5670_PWR_I2S1				(0x1 << 15)
+#define RT5670_PWR_I2S1_BIT			15
+#define RT5670_PWR_I2S2				(0x1 << 14)
+#define RT5670_PWR_I2S2_BIT			14
+#define RT5670_PWR_DAC_L1			(0x1 << 12)
+#define RT5670_PWR_DAC_L1_BIT			12
+#define RT5670_PWR_DAC_R1			(0x1 << 11)
+#define RT5670_PWR_DAC_R1_BIT			11
+#define RT5670_PWR_DAC_L2			(0x1 << 7)
+#define RT5670_PWR_DAC_L2_BIT			7
+#define RT5670_PWR_DAC_R2			(0x1 << 6)
+#define RT5670_PWR_DAC_R2_BIT			6
+#define RT5670_PWR_ADC_L			(0x1 << 2)
+#define RT5670_PWR_ADC_L_BIT			2
+#define RT5670_PWR_ADC_R			(0x1 << 1)
+#define RT5670_PWR_ADC_R_BIT			1
+#define RT5670_PWR_CLS_D			(0x1)
+#define RT5670_PWR_CLS_D_BIT			0
+
+/* Power Management for Digital 2 (0x62) */
+#define RT5670_PWR_ADC_S1F			(0x1 << 15)
+#define RT5670_PWR_ADC_S1F_BIT			15
+#define RT5670_PWR_ADC_MF_L			(0x1 << 14)
+#define RT5670_PWR_ADC_MF_L_BIT			14
+#define RT5670_PWR_ADC_MF_R			(0x1 << 13)
+#define RT5670_PWR_ADC_MF_R_BIT			13
+#define RT5670_PWR_I2S_DSP			(0x1 << 12)
+#define RT5670_PWR_I2S_DSP_BIT			12
+#define RT5670_PWR_DAC_S1F			(0x1 << 11)
+#define RT5670_PWR_DAC_S1F_BIT			11
+#define RT5670_PWR_DAC_MF_L			(0x1 << 10)
+#define RT5670_PWR_DAC_MF_L_BIT			10
+#define RT5670_PWR_DAC_MF_R			(0x1 << 9)
+#define RT5670_PWR_DAC_MF_R_BIT			9
+#define RT5670_PWR_ADC_S2F			(0x1 << 8)
+#define RT5670_PWR_ADC_S2F_BIT			8
+#define RT5670_PWR_PDM1				(0x1 << 7)
+#define RT5670_PWR_PDM1_BIT			7
+#define RT5670_PWR_PDM2				(0x1 << 6)
+#define RT5670_PWR_PDM2_BIT			6
+
+/* Power Management for Analog 1 (0x63) */
+#define RT5670_PWR_VREF1			(0x1 << 15)
+#define RT5670_PWR_VREF1_BIT			15
+#define RT5670_PWR_FV1				(0x1 << 14)
+#define RT5670_PWR_FV1_BIT			14
+#define RT5670_PWR_MB				(0x1 << 13)
+#define RT5670_PWR_MB_BIT			13
+#define RT5670_PWR_LM				(0x1 << 12)
+#define RT5670_PWR_LM_BIT			12
+#define RT5670_PWR_BG				(0x1 << 11)
+#define RT5670_PWR_BG_BIT			11
+#define RT5670_PWR_HP_L				(0x1 << 7)
+#define RT5670_PWR_HP_L_BIT			7
+#define RT5670_PWR_HP_R				(0x1 << 6)
+#define RT5670_PWR_HP_R_BIT			6
+#define RT5670_PWR_HA				(0x1 << 5)
+#define RT5670_PWR_HA_BIT			5
+#define RT5670_PWR_VREF2			(0x1 << 4)
+#define RT5670_PWR_VREF2_BIT			4
+#define RT5670_PWR_FV2				(0x1 << 3)
+#define RT5670_PWR_FV2_BIT			3
+#define RT5670_LDO_SEL_MASK			(0x3)
+#define RT5670_LDO_SEL_SFT			0
+
+/* Power Management for Analog 2 (0x64) */
+#define RT5670_PWR_BST1				(0x1 << 15)
+#define RT5670_PWR_BST1_BIT			15
+#define RT5670_PWR_BST2				(0x1 << 13)
+#define RT5670_PWR_BST2_BIT			13
+#define RT5670_PWR_MB1				(0x1 << 11)
+#define RT5670_PWR_MB1_BIT			11
+#define RT5670_PWR_MB2				(0x1 << 10)
+#define RT5670_PWR_MB2_BIT			10
+#define RT5670_PWR_PLL				(0x1 << 9)
+#define RT5670_PWR_PLL_BIT			9
+#define RT5670_PWR_BST1_P			(0x1 << 6)
+#define RT5670_PWR_BST1_P_BIT			6
+#define RT5670_PWR_BST2_P			(0x1 << 4)
+#define RT5670_PWR_BST2_P_BIT			4
+#define RT5670_PWR_JD1				(0x1 << 2)
+#define RT5670_PWR_JD1_BIT			2
+#define RT5670_PWR_JD				(0x1 << 1)
+#define RT5670_PWR_JD_BIT			1
+
+/* Power Management for Mixer (0x65) */
+#define RT5670_PWR_OM_L				(0x1 << 15)
+#define RT5670_PWR_OM_L_BIT			15
+#define RT5670_PWR_OM_R				(0x1 << 14)
+#define RT5670_PWR_OM_R_BIT			14
+#define RT5670_PWR_RM_L				(0x1 << 11)
+#define RT5670_PWR_RM_L_BIT			11
+#define RT5670_PWR_RM_R				(0x1 << 10)
+#define RT5670_PWR_RM_R_BIT			10
+
+/* Power Management for Volume (0x66) */
+#define RT5670_PWR_HV_L				(0x1 << 11)
+#define RT5670_PWR_HV_L_BIT			11
+#define RT5670_PWR_HV_R				(0x1 << 10)
+#define RT5670_PWR_HV_R_BIT			10
+#define RT5670_PWR_IN_L				(0x1 << 9)
+#define RT5670_PWR_IN_L_BIT			9
+#define RT5670_PWR_IN_R				(0x1 << 8)
+#define RT5670_PWR_IN_R_BIT			8
+#define RT5670_PWR_MIC_DET			(0x1 << 5)
+#define RT5670_PWR_MIC_DET_BIT			5
+
+/* I2S1/2/3 Audio Serial Data Port Control (0x70 0x71 0x72) */
+#define RT5670_I2S_MS_MASK			(0x1 << 15)
+#define RT5670_I2S_MS_SFT			15
+#define RT5670_I2S_MS_M				(0x0 << 15)
+#define RT5670_I2S_MS_S				(0x1 << 15)
+#define RT5670_I2S_IF_MASK			(0x7 << 12)
+#define RT5670_I2S_IF_SFT			12
+#define RT5670_I2S_O_CP_MASK			(0x3 << 10)
+#define RT5670_I2S_O_CP_SFT			10
+#define RT5670_I2S_O_CP_OFF			(0x0 << 10)
+#define RT5670_I2S_O_CP_U_LAW			(0x1 << 10)
+#define RT5670_I2S_O_CP_A_LAW			(0x2 << 10)
+#define RT5670_I2S_I_CP_MASK			(0x3 << 8)
+#define RT5670_I2S_I_CP_SFT			8
+#define RT5670_I2S_I_CP_OFF			(0x0 << 8)
+#define RT5670_I2S_I_CP_U_LAW			(0x1 << 8)
+#define RT5670_I2S_I_CP_A_LAW			(0x2 << 8)
+#define RT5670_I2S_BP_MASK			(0x1 << 7)
+#define RT5670_I2S_BP_SFT			7
+#define RT5670_I2S_BP_NOR			(0x0 << 7)
+#define RT5670_I2S_BP_INV			(0x1 << 7)
+#define RT5670_I2S_DL_MASK			(0x3 << 2)
+#define RT5670_I2S_DL_SFT			2
+#define RT5670_I2S_DL_16			(0x0 << 2)
+#define RT5670_I2S_DL_20			(0x1 << 2)
+#define RT5670_I2S_DL_24			(0x2 << 2)
+#define RT5670_I2S_DL_8				(0x3 << 2)
+#define RT5670_I2S_DF_MASK			(0x3)
+#define RT5670_I2S_DF_SFT			0
+#define RT5670_I2S_DF_I2S			(0x0)
+#define RT5670_I2S_DF_LEFT			(0x1)
+#define RT5670_I2S_DF_PCM_A			(0x2)
+#define RT5670_I2S_DF_PCM_B			(0x3)
+
+/* I2S2 Audio Serial Data Port Control (0x71) */
+#define RT5670_I2S2_SDI_MASK			(0x1 << 6)
+#define RT5670_I2S2_SDI_SFT			6
+#define RT5670_I2S2_SDI_I2S1			(0x0 << 6)
+#define RT5670_I2S2_SDI_I2S2			(0x1 << 6)
+
+/* ADC/DAC Clock Control 1 (0x73) */
+#define RT5670_I2S_BCLK_MS1_MASK		(0x1 << 15)
+#define RT5670_I2S_BCLK_MS1_SFT			15
+#define RT5670_I2S_BCLK_MS1_32			(0x0 << 15)
+#define RT5670_I2S_BCLK_MS1_64			(0x1 << 15)
+#define RT5670_I2S_PD1_MASK			(0x7 << 12)
+#define RT5670_I2S_PD1_SFT			12
+#define RT5670_I2S_PD1_1			(0x0 << 12)
+#define RT5670_I2S_PD1_2			(0x1 << 12)
+#define RT5670_I2S_PD1_3			(0x2 << 12)
+#define RT5670_I2S_PD1_4			(0x3 << 12)
+#define RT5670_I2S_PD1_6			(0x4 << 12)
+#define RT5670_I2S_PD1_8			(0x5 << 12)
+#define RT5670_I2S_PD1_12			(0x6 << 12)
+#define RT5670_I2S_PD1_16			(0x7 << 12)
+#define RT5670_I2S_BCLK_MS2_MASK		(0x1 << 11)
+#define RT5670_I2S_BCLK_MS2_SFT			11
+#define RT5670_I2S_BCLK_MS2_32			(0x0 << 11)
+#define RT5670_I2S_BCLK_MS2_64			(0x1 << 11)
+#define RT5670_I2S_PD2_MASK			(0x7 << 8)
+#define RT5670_I2S_PD2_SFT			8
+#define RT5670_I2S_PD2_1			(0x0 << 8)
+#define RT5670_I2S_PD2_2			(0x1 << 8)
+#define RT5670_I2S_PD2_3			(0x2 << 8)
+#define RT5670_I2S_PD2_4			(0x3 << 8)
+#define RT5670_I2S_PD2_6			(0x4 << 8)
+#define RT5670_I2S_PD2_8			(0x5 << 8)
+#define RT5670_I2S_PD2_12			(0x6 << 8)
+#define RT5670_I2S_PD2_16			(0x7 << 8)
+#define RT5670_I2S_BCLK_MS3_MASK		(0x1 << 7)
+#define RT5670_I2S_BCLK_MS3_SFT			7
+#define RT5670_I2S_BCLK_MS3_32			(0x0 << 7)
+#define RT5670_I2S_BCLK_MS3_64			(0x1 << 7)
+#define RT5670_I2S_PD3_MASK			(0x7 << 4)
+#define RT5670_I2S_PD3_SFT			4
+#define RT5670_I2S_PD3_1			(0x0 << 4)
+#define RT5670_I2S_PD3_2			(0x1 << 4)
+#define RT5670_I2S_PD3_3			(0x2 << 4)
+#define RT5670_I2S_PD3_4			(0x3 << 4)
+#define RT5670_I2S_PD3_6			(0x4 << 4)
+#define RT5670_I2S_PD3_8			(0x5 << 4)
+#define RT5670_I2S_PD3_12			(0x6 << 4)
+#define RT5670_I2S_PD3_16			(0x7 << 4)
+#define RT5670_DAC_OSR_MASK			(0x3 << 2)
+#define RT5670_DAC_OSR_SFT			2
+#define RT5670_DAC_OSR_128			(0x0 << 2)
+#define RT5670_DAC_OSR_64			(0x1 << 2)
+#define RT5670_DAC_OSR_32			(0x2 << 2)
+#define RT5670_DAC_OSR_16			(0x3 << 2)
+#define RT5670_ADC_OSR_MASK			(0x3)
+#define RT5670_ADC_OSR_SFT			0
+#define RT5670_ADC_OSR_128			(0x0)
+#define RT5670_ADC_OSR_64			(0x1)
+#define RT5670_ADC_OSR_32			(0x2)
+#define RT5670_ADC_OSR_16			(0x3)
+
+/* ADC/DAC Clock Control 2 (0x74) */
+#define RT5670_DAC_L_OSR_MASK			(0x3 << 14)
+#define RT5670_DAC_L_OSR_SFT			14
+#define RT5670_DAC_L_OSR_128			(0x0 << 14)
+#define RT5670_DAC_L_OSR_64			(0x1 << 14)
+#define RT5670_DAC_L_OSR_32			(0x2 << 14)
+#define RT5670_DAC_L_OSR_16			(0x3 << 14)
+#define RT5670_ADC_R_OSR_MASK			(0x3 << 12)
+#define RT5670_ADC_R_OSR_SFT			12
+#define RT5670_ADC_R_OSR_128			(0x0 << 12)
+#define RT5670_ADC_R_OSR_64			(0x1 << 12)
+#define RT5670_ADC_R_OSR_32			(0x2 << 12)
+#define RT5670_ADC_R_OSR_16			(0x3 << 12)
+#define RT5670_DAHPF_EN				(0x1 << 11)
+#define RT5670_DAHPF_EN_SFT			11
+#define RT5670_ADHPF_EN				(0x1 << 10)
+#define RT5670_ADHPF_EN_SFT			10
+
+/* Digital Microphone Control (0x75) */
+#define RT5670_DMIC_1_EN_MASK			(0x1 << 15)
+#define RT5670_DMIC_1_EN_SFT			15
+#define RT5670_DMIC_1_DIS			(0x0 << 15)
+#define RT5670_DMIC_1_EN			(0x1 << 15)
+#define RT5670_DMIC_2_EN_MASK			(0x1 << 14)
+#define RT5670_DMIC_2_EN_SFT			14
+#define RT5670_DMIC_2_DIS			(0x0 << 14)
+#define RT5670_DMIC_2_EN			(0x1 << 14)
+#define RT5670_DMIC_1L_LH_MASK			(0x1 << 13)
+#define RT5670_DMIC_1L_LH_SFT			13
+#define RT5670_DMIC_1L_LH_FALLING		(0x0 << 13)
+#define RT5670_DMIC_1L_LH_RISING		(0x1 << 13)
+#define RT5670_DMIC_1R_LH_MASK			(0x1 << 12)
+#define RT5670_DMIC_1R_LH_SFT			12
+#define RT5670_DMIC_1R_LH_FALLING		(0x0 << 12)
+#define RT5670_DMIC_1R_LH_RISING		(0x1 << 12)
+#define RT5670_DMIC_2_DP_MASK			(0x1 << 10)
+#define RT5670_DMIC_2_DP_SFT			10
+#define RT5670_DMIC_2_DP_GPIO8			(0x0 << 10)
+#define RT5670_DMIC_2_DP_IN3N			(0x1 << 10)
+#define RT5670_DMIC_2L_LH_MASK			(0x1 << 9)
+#define RT5670_DMIC_2L_LH_SFT			9
+#define RT5670_DMIC_2L_LH_FALLING		(0x0 << 9)
+#define RT5670_DMIC_2L_LH_RISING		(0x1 << 9)
+#define RT5670_DMIC_2R_LH_MASK			(0x1 << 8)
+#define RT5670_DMIC_2R_LH_SFT			8
+#define RT5670_DMIC_2R_LH_FALLING		(0x0 << 8)
+#define RT5670_DMIC_2R_LH_RISING		(0x1 << 8)
+#define RT5670_DMIC_CLK_MASK			(0x7 << 5)
+#define RT5670_DMIC_CLK_SFT			5
+#define RT5670_DMIC_3_EN_MASK			(0x1 << 4)
+#define RT5670_DMIC_3_EN_SFT			4
+#define RT5670_DMIC_3_DIS			(0x0 << 4)
+#define RT5670_DMIC_3_EN			(0x1 << 4)
+#define RT5670_DMIC_1_DP_MASK			(0x3 << 0)
+#define RT5670_DMIC_1_DP_SFT			0
+#define RT5670_DMIC_1_DP_GPIO6			(0x0 << 0)
+#define RT5670_DMIC_1_DP_IN2P			(0x1 << 0)
+#define RT5670_DMIC_1_DP_GPIO7			(0x2 << 0)
+
+/* Digital Microphone Control2 (0x76) */
+#define RT5670_DMIC_3_DP_MASK			(0x3 << 6)
+#define RT5670_DMIC_3_DP_SFT			6
+#define RT5670_DMIC_3_DP_GPIO9			(0x0 << 6)
+#define RT5670_DMIC_3_DP_GPIO10			(0x1 << 6)
+#define RT5670_DMIC_3_DP_GPIO5			(0x2 << 6)
+
+/* Global Clock Control (0x80) */
+#define RT5670_SCLK_SRC_MASK			(0x3 << 14)
+#define RT5670_SCLK_SRC_SFT			14
+#define RT5670_SCLK_SRC_MCLK			(0x0 << 14)
+#define RT5670_SCLK_SRC_PLL1			(0x1 << 14)
+#define RT5670_SCLK_SRC_RCCLK			(0x2 << 14) /* 15MHz */
+#define RT5670_PLL1_SRC_MASK			(0x3 << 12)
+#define RT5670_PLL1_SRC_SFT			12
+#define RT5670_PLL1_SRC_MCLK			(0x0 << 12)
+#define RT5670_PLL1_SRC_BCLK1			(0x1 << 12)
+#define RT5670_PLL1_SRC_BCLK2			(0x2 << 12)
+#define RT5670_PLL1_SRC_BCLK3			(0x3 << 12)
+#define RT5670_PLL1_PD_MASK			(0x1 << 3)
+#define RT5670_PLL1_PD_SFT			3
+#define RT5670_PLL1_PD_1			(0x0 << 3)
+#define RT5670_PLL1_PD_2			(0x1 << 3)
+
+#define RT5670_PLL_INP_MAX			40000000
+#define RT5670_PLL_INP_MIN			256000
+/* PLL M/N/K Code Control 1 (0x81) */
+#define RT5670_PLL_N_MAX			0x1ff
+#define RT5670_PLL_N_MASK			(RT5670_PLL_N_MAX << 7)
+#define RT5670_PLL_N_SFT			7
+#define RT5670_PLL_K_MAX			0x1f
+#define RT5670_PLL_K_MASK			(RT5670_PLL_K_MAX)
+#define RT5670_PLL_K_SFT			0
+
+/* PLL M/N/K Code Control 2 (0x82) */
+#define RT5670_PLL_M_MAX			0xf
+#define RT5670_PLL_M_MASK			(RT5670_PLL_M_MAX << 12)
+#define RT5670_PLL_M_SFT			12
+#define RT5670_PLL_M_BP				(0x1 << 11)
+#define RT5670_PLL_M_BP_SFT			11
+
+/* ASRC Control 1 (0x83) */
+#define RT5670_STO_T_MASK			(0x1 << 15)
+#define RT5670_STO_T_SFT			15
+#define RT5670_STO_T_SCLK			(0x0 << 15)
+#define RT5670_STO_T_LRCK1			(0x1 << 15)
+#define RT5670_M1_T_MASK			(0x1 << 14)
+#define RT5670_M1_T_SFT				14
+#define RT5670_M1_T_I2S2			(0x0 << 14)
+#define RT5670_M1_T_I2S2_D3			(0x1 << 14)
+#define RT5670_I2S2_F_MASK			(0x1 << 12)
+#define RT5670_I2S2_F_SFT			12
+#define RT5670_I2S2_F_I2S2_D2			(0x0 << 12)
+#define RT5670_I2S2_F_I2S1_TCLK			(0x1 << 12)
+#define RT5670_DMIC_1_M_MASK			(0x1 << 9)
+#define RT5670_DMIC_1_M_SFT			9
+#define RT5670_DMIC_1_M_NOR			(0x0 << 9)
+#define RT5670_DMIC_1_M_ASYN			(0x1 << 9)
+#define RT5670_DMIC_2_M_MASK			(0x1 << 8)
+#define RT5670_DMIC_2_M_SFT			8
+#define RT5670_DMIC_2_M_NOR			(0x0 << 8)
+#define RT5670_DMIC_2_M_ASYN			(0x1 << 8)
+
+/* ASRC Control 2 (0x84) */
+#define RT5670_MDA_L_M_MASK			(0x1 << 15)
+#define RT5670_MDA_L_M_SFT			15
+#define RT5670_MDA_L_M_NOR			(0x0 << 15)
+#define RT5670_MDA_L_M_ASYN			(0x1 << 15)
+#define RT5670_MDA_R_M_MASK			(0x1 << 14)
+#define RT5670_MDA_R_M_SFT			14
+#define RT5670_MDA_R_M_NOR			(0x0 << 14)
+#define RT5670_MDA_R_M_ASYN			(0x1 << 14)
+#define RT5670_MAD_L_M_MASK			(0x1 << 13)
+#define RT5670_MAD_L_M_SFT			13
+#define RT5670_MAD_L_M_NOR			(0x0 << 13)
+#define RT5670_MAD_L_M_ASYN			(0x1 << 13)
+#define RT5670_MAD_R_M_MASK			(0x1 << 12)
+#define RT5670_MAD_R_M_SFT			12
+#define RT5670_MAD_R_M_NOR			(0x0 << 12)
+#define RT5670_MAD_R_M_ASYN			(0x1 << 12)
+#define RT5670_ADC_M_MASK			(0x1 << 11)
+#define RT5670_ADC_M_SFT			11
+#define RT5670_ADC_M_NOR			(0x0 << 11)
+#define RT5670_ADC_M_ASYN			(0x1 << 11)
+#define RT5670_STO_DAC_M_MASK			(0x1 << 5)
+#define RT5670_STO_DAC_M_SFT			5
+#define RT5670_STO_DAC_M_NOR			(0x0 << 5)
+#define RT5670_STO_DAC_M_ASYN			(0x1 << 5)
+#define RT5670_I2S1_R_D_MASK			(0x1 << 4)
+#define RT5670_I2S1_R_D_SFT			4
+#define RT5670_I2S1_R_D_DIS			(0x0 << 4)
+#define RT5670_I2S1_R_D_EN			(0x1 << 4)
+#define RT5670_I2S2_R_D_MASK			(0x1 << 3)
+#define RT5670_I2S2_R_D_SFT			3
+#define RT5670_I2S2_R_D_DIS			(0x0 << 3)
+#define RT5670_I2S2_R_D_EN			(0x1 << 3)
+#define RT5670_PRE_SCLK_MASK			(0x3)
+#define RT5670_PRE_SCLK_SFT			0
+#define RT5670_PRE_SCLK_512			(0x0)
+#define RT5670_PRE_SCLK_1024			(0x1)
+#define RT5670_PRE_SCLK_2048			(0x2)
+
+/* ASRC Control 3 (0x85) */
+#define RT5670_I2S1_RATE_MASK			(0xf << 12)
+#define RT5670_I2S1_RATE_SFT			12
+#define RT5670_I2S2_RATE_MASK			(0xf << 8)
+#define RT5670_I2S2_RATE_SFT			8
+
+/* ASRC Control 4 (0x89) */
+#define RT5670_I2S1_PD_MASK			(0x7 << 12)
+#define RT5670_I2S1_PD_SFT			12
+#define RT5670_I2S2_PD_MASK			(0x7 << 8)
+#define RT5670_I2S2_PD_SFT			8
+
+/* HPOUT Over Current Detection (0x8b) */
+#define RT5670_HP_OVCD_MASK			(0x1 << 10)
+#define RT5670_HP_OVCD_SFT			10
+#define RT5670_HP_OVCD_DIS			(0x0 << 10)
+#define RT5670_HP_OVCD_EN			(0x1 << 10)
+#define RT5670_HP_OC_TH_MASK			(0x3 << 8)
+#define RT5670_HP_OC_TH_SFT			8
+#define RT5670_HP_OC_TH_90			(0x0 << 8)
+#define RT5670_HP_OC_TH_105			(0x1 << 8)
+#define RT5670_HP_OC_TH_120			(0x2 << 8)
+#define RT5670_HP_OC_TH_135			(0x3 << 8)
+
+/* Class D Over Current Control (0x8c) */
+#define RT5670_CLSD_OC_MASK			(0x1 << 9)
+#define RT5670_CLSD_OC_SFT			9
+#define RT5670_CLSD_OC_PU			(0x0 << 9)
+#define RT5670_CLSD_OC_PD			(0x1 << 9)
+#define RT5670_AUTO_PD_MASK			(0x1 << 8)
+#define RT5670_AUTO_PD_SFT			8
+#define RT5670_AUTO_PD_DIS			(0x0 << 8)
+#define RT5670_AUTO_PD_EN			(0x1 << 8)
+#define RT5670_CLSD_OC_TH_MASK			(0x3f)
+#define RT5670_CLSD_OC_TH_SFT			0
+
+/* Class D Output Control (0x8d) */
+#define RT5670_CLSD_RATIO_MASK			(0xf << 12)
+#define RT5670_CLSD_RATIO_SFT			12
+#define RT5670_CLSD_OM_MASK			(0x1 << 11)
+#define RT5670_CLSD_OM_SFT			11
+#define RT5670_CLSD_OM_MONO			(0x0 << 11)
+#define RT5670_CLSD_OM_STO			(0x1 << 11)
+#define RT5670_CLSD_SCH_MASK			(0x1 << 10)
+#define RT5670_CLSD_SCH_SFT			10
+#define RT5670_CLSD_SCH_L			(0x0 << 10)
+#define RT5670_CLSD_SCH_S			(0x1 << 10)
+
+/* Depop Mode Control 1 (0x8e) */
+#define RT5670_SMT_TRIG_MASK			(0x1 << 15)
+#define RT5670_SMT_TRIG_SFT			15
+#define RT5670_SMT_TRIG_DIS			(0x0 << 15)
+#define RT5670_SMT_TRIG_EN			(0x1 << 15)
+#define RT5670_HP_L_SMT_MASK			(0x1 << 9)
+#define RT5670_HP_L_SMT_SFT			9
+#define RT5670_HP_L_SMT_DIS			(0x0 << 9)
+#define RT5670_HP_L_SMT_EN			(0x1 << 9)
+#define RT5670_HP_R_SMT_MASK			(0x1 << 8)
+#define RT5670_HP_R_SMT_SFT			8
+#define RT5670_HP_R_SMT_DIS			(0x0 << 8)
+#define RT5670_HP_R_SMT_EN			(0x1 << 8)
+#define RT5670_HP_CD_PD_MASK			(0x1 << 7)
+#define RT5670_HP_CD_PD_SFT			7
+#define RT5670_HP_CD_PD_DIS			(0x0 << 7)
+#define RT5670_HP_CD_PD_EN			(0x1 << 7)
+#define RT5670_RSTN_MASK			(0x1 << 6)
+#define RT5670_RSTN_SFT				6
+#define RT5670_RSTN_DIS				(0x0 << 6)
+#define RT5670_RSTN_EN				(0x1 << 6)
+#define RT5670_RSTP_MASK			(0x1 << 5)
+#define RT5670_RSTP_SFT				5
+#define RT5670_RSTP_DIS				(0x0 << 5)
+#define RT5670_RSTP_EN				(0x1 << 5)
+#define RT5670_HP_CO_MASK			(0x1 << 4)
+#define RT5670_HP_CO_SFT			4
+#define RT5670_HP_CO_DIS			(0x0 << 4)
+#define RT5670_HP_CO_EN				(0x1 << 4)
+#define RT5670_HP_CP_MASK			(0x1 << 3)
+#define RT5670_HP_CP_SFT			3
+#define RT5670_HP_CP_PD				(0x0 << 3)
+#define RT5670_HP_CP_PU				(0x1 << 3)
+#define RT5670_HP_SG_MASK			(0x1 << 2)
+#define RT5670_HP_SG_SFT			2
+#define RT5670_HP_SG_DIS			(0x0 << 2)
+#define RT5670_HP_SG_EN				(0x1 << 2)
+#define RT5670_HP_DP_MASK			(0x1 << 1)
+#define RT5670_HP_DP_SFT			1
+#define RT5670_HP_DP_PD				(0x0 << 1)
+#define RT5670_HP_DP_PU				(0x1 << 1)
+#define RT5670_HP_CB_MASK			(0x1)
+#define RT5670_HP_CB_SFT			0
+#define RT5670_HP_CB_PD				(0x0)
+#define RT5670_HP_CB_PU				(0x1)
+
+/* Depop Mode Control 2 (0x8f) */
+#define RT5670_DEPOP_MASK			(0x1 << 13)
+#define RT5670_DEPOP_SFT			13
+#define RT5670_DEPOP_AUTO			(0x0 << 13)
+#define RT5670_DEPOP_MAN			(0x1 << 13)
+#define RT5670_RAMP_MASK			(0x1 << 12)
+#define RT5670_RAMP_SFT				12
+#define RT5670_RAMP_DIS				(0x0 << 12)
+#define RT5670_RAMP_EN				(0x1 << 12)
+#define RT5670_BPS_MASK				(0x1 << 11)
+#define RT5670_BPS_SFT				11
+#define RT5670_BPS_DIS				(0x0 << 11)
+#define RT5670_BPS_EN				(0x1 << 11)
+#define RT5670_FAST_UPDN_MASK			(0x1 << 10)
+#define RT5670_FAST_UPDN_SFT			10
+#define RT5670_FAST_UPDN_DIS			(0x0 << 10)
+#define RT5670_FAST_UPDN_EN			(0x1 << 10)
+#define RT5670_MRES_MASK			(0x3 << 8)
+#define RT5670_MRES_SFT				8
+#define RT5670_MRES_15MO			(0x0 << 8)
+#define RT5670_MRES_25MO			(0x1 << 8)
+#define RT5670_MRES_35MO			(0x2 << 8)
+#define RT5670_MRES_45MO			(0x3 << 8)
+#define RT5670_VLO_MASK				(0x1 << 7)
+#define RT5670_VLO_SFT				7
+#define RT5670_VLO_3V				(0x0 << 7)
+#define RT5670_VLO_32V				(0x1 << 7)
+#define RT5670_DIG_DP_MASK			(0x1 << 6)
+#define RT5670_DIG_DP_SFT			6
+#define RT5670_DIG_DP_DIS			(0x0 << 6)
+#define RT5670_DIG_DP_EN			(0x1 << 6)
+#define RT5670_DP_TH_MASK			(0x3 << 4)
+#define RT5670_DP_TH_SFT			4
+
+/* Depop Mode Control 3 (0x90) */
+#define RT5670_CP_SYS_MASK			(0x7 << 12)
+#define RT5670_CP_SYS_SFT			12
+#define RT5670_CP_FQ1_MASK			(0x7 << 8)
+#define RT5670_CP_FQ1_SFT			8
+#define RT5670_CP_FQ2_MASK			(0x7 << 4)
+#define RT5670_CP_FQ2_SFT			4
+#define RT5670_CP_FQ3_MASK			(0x7)
+#define RT5670_CP_FQ3_SFT			0
+#define RT5670_CP_FQ_1_5_KHZ			0
+#define RT5670_CP_FQ_3_KHZ			1
+#define RT5670_CP_FQ_6_KHZ			2
+#define RT5670_CP_FQ_12_KHZ			3
+#define RT5670_CP_FQ_24_KHZ			4
+#define RT5670_CP_FQ_48_KHZ			5
+#define RT5670_CP_FQ_96_KHZ			6
+#define RT5670_CP_FQ_192_KHZ			7
+
+/* HPOUT charge pump (0x91) */
+#define RT5670_OSW_L_MASK			(0x1 << 11)
+#define RT5670_OSW_L_SFT			11
+#define RT5670_OSW_L_DIS			(0x0 << 11)
+#define RT5670_OSW_L_EN				(0x1 << 11)
+#define RT5670_OSW_R_MASK			(0x1 << 10)
+#define RT5670_OSW_R_SFT			10
+#define RT5670_OSW_R_DIS			(0x0 << 10)
+#define RT5670_OSW_R_EN				(0x1 << 10)
+#define RT5670_PM_HP_MASK			(0x3 << 8)
+#define RT5670_PM_HP_SFT			8
+#define RT5670_PM_HP_LV				(0x0 << 8)
+#define RT5670_PM_HP_MV				(0x1 << 8)
+#define RT5670_PM_HP_HV				(0x2 << 8)
+#define RT5670_IB_HP_MASK			(0x3 << 6)
+#define RT5670_IB_HP_SFT			6
+#define RT5670_IB_HP_125IL			(0x0 << 6)
+#define RT5670_IB_HP_25IL			(0x1 << 6)
+#define RT5670_IB_HP_5IL			(0x2 << 6)
+#define RT5670_IB_HP_1IL			(0x3 << 6)
+
+/* PV detection and SPK gain control (0x92) */
+#define RT5670_PVDD_DET_MASK			(0x1 << 15)
+#define RT5670_PVDD_DET_SFT			15
+#define RT5670_PVDD_DET_DIS			(0x0 << 15)
+#define RT5670_PVDD_DET_EN			(0x1 << 15)
+#define RT5670_SPK_AG_MASK			(0x1 << 14)
+#define RT5670_SPK_AG_SFT			14
+#define RT5670_SPK_AG_DIS			(0x0 << 14)
+#define RT5670_SPK_AG_EN			(0x1 << 14)
+
+/* Micbias Control (0x93) */
+#define RT5670_MIC1_BS_MASK			(0x1 << 15)
+#define RT5670_MIC1_BS_SFT			15
+#define RT5670_MIC1_BS_9AV			(0x0 << 15)
+#define RT5670_MIC1_BS_75AV			(0x1 << 15)
+#define RT5670_MIC2_BS_MASK			(0x1 << 14)
+#define RT5670_MIC2_BS_SFT			14
+#define RT5670_MIC2_BS_9AV			(0x0 << 14)
+#define RT5670_MIC2_BS_75AV			(0x1 << 14)
+#define RT5670_MIC1_CLK_MASK			(0x1 << 13)
+#define RT5670_MIC1_CLK_SFT			13
+#define RT5670_MIC1_CLK_DIS			(0x0 << 13)
+#define RT5670_MIC1_CLK_EN			(0x1 << 13)
+#define RT5670_MIC2_CLK_MASK			(0x1 << 12)
+#define RT5670_MIC2_CLK_SFT			12
+#define RT5670_MIC2_CLK_DIS			(0x0 << 12)
+#define RT5670_MIC2_CLK_EN			(0x1 << 12)
+#define RT5670_MIC1_OVCD_MASK			(0x1 << 11)
+#define RT5670_MIC1_OVCD_SFT			11
+#define RT5670_MIC1_OVCD_DIS			(0x0 << 11)
+#define RT5670_MIC1_OVCD_EN			(0x1 << 11)
+#define RT5670_MIC1_OVTH_MASK			(0x3 << 9)
+#define RT5670_MIC1_OVTH_SFT			9
+#define RT5670_MIC1_OVTH_600UA			(0x0 << 9)
+#define RT5670_MIC1_OVTH_1500UA			(0x1 << 9)
+#define RT5670_MIC1_OVTH_2000UA			(0x2 << 9)
+#define RT5670_MIC2_OVCD_MASK			(0x1 << 8)
+#define RT5670_MIC2_OVCD_SFT			8
+#define RT5670_MIC2_OVCD_DIS			(0x0 << 8)
+#define RT5670_MIC2_OVCD_EN			(0x1 << 8)
+#define RT5670_MIC2_OVTH_MASK			(0x3 << 6)
+#define RT5670_MIC2_OVTH_SFT			6
+#define RT5670_MIC2_OVTH_600UA			(0x0 << 6)
+#define RT5670_MIC2_OVTH_1500UA			(0x1 << 6)
+#define RT5670_MIC2_OVTH_2000UA			(0x2 << 6)
+#define RT5670_PWR_MB_MASK			(0x1 << 5)
+#define RT5670_PWR_MB_SFT			5
+#define RT5670_PWR_MB_PD			(0x0 << 5)
+#define RT5670_PWR_MB_PU			(0x1 << 5)
+#define RT5670_PWR_CLK25M_MASK			(0x1 << 4)
+#define RT5670_PWR_CLK25M_SFT			4
+#define RT5670_PWR_CLK25M_PD			(0x0 << 4)
+#define RT5670_PWR_CLK25M_PU			(0x1 << 4)
+
+/* Analog JD Control 1 (0x94) */
+#define RT5670_JD1_MODE_MASK			(0x3 << 0)
+#define RT5670_JD1_MODE_0			(0x0 << 0)
+#define RT5670_JD1_MODE_1			(0x1 << 0)
+#define RT5670_JD1_MODE_2			(0x2 << 0)
+
+/* VAD Control 4 (0x9d) */
+#define RT5670_VAD_SEL_MASK			(0x3 << 8)
+#define RT5670_VAD_SEL_SFT			8
+
+/* EQ Control 1 (0xb0) */
+#define RT5670_EQ_SRC_MASK			(0x1 << 15)
+#define RT5670_EQ_SRC_SFT			15
+#define RT5670_EQ_SRC_DAC			(0x0 << 15)
+#define RT5670_EQ_SRC_ADC			(0x1 << 15)
+#define RT5670_EQ_UPD				(0x1 << 14)
+#define RT5670_EQ_UPD_BIT			14
+#define RT5670_EQ_CD_MASK			(0x1 << 13)
+#define RT5670_EQ_CD_SFT			13
+#define RT5670_EQ_CD_DIS			(0x0 << 13)
+#define RT5670_EQ_CD_EN				(0x1 << 13)
+#define RT5670_EQ_DITH_MASK			(0x3 << 8)
+#define RT5670_EQ_DITH_SFT			8
+#define RT5670_EQ_DITH_NOR			(0x0 << 8)
+#define RT5670_EQ_DITH_LSB			(0x1 << 8)
+#define RT5670_EQ_DITH_LSB_1			(0x2 << 8)
+#define RT5670_EQ_DITH_LSB_2			(0x3 << 8)
+
+/* EQ Control 2 (0xb1) */
+#define RT5670_EQ_HPF1_M_MASK			(0x1 << 8)
+#define RT5670_EQ_HPF1_M_SFT			8
+#define RT5670_EQ_HPF1_M_HI			(0x0 << 8)
+#define RT5670_EQ_HPF1_M_1ST			(0x1 << 8)
+#define RT5670_EQ_LPF1_M_MASK			(0x1 << 7)
+#define RT5670_EQ_LPF1_M_SFT			7
+#define RT5670_EQ_LPF1_M_LO			(0x0 << 7)
+#define RT5670_EQ_LPF1_M_1ST			(0x1 << 7)
+#define RT5670_EQ_HPF2_MASK			(0x1 << 6)
+#define RT5670_EQ_HPF2_SFT			6
+#define RT5670_EQ_HPF2_DIS			(0x0 << 6)
+#define RT5670_EQ_HPF2_EN			(0x1 << 6)
+#define RT5670_EQ_HPF1_MASK			(0x1 << 5)
+#define RT5670_EQ_HPF1_SFT			5
+#define RT5670_EQ_HPF1_DIS			(0x0 << 5)
+#define RT5670_EQ_HPF1_EN			(0x1 << 5)
+#define RT5670_EQ_BPF4_MASK			(0x1 << 4)
+#define RT5670_EQ_BPF4_SFT			4
+#define RT5670_EQ_BPF4_DIS			(0x0 << 4)
+#define RT5670_EQ_BPF4_EN			(0x1 << 4)
+#define RT5670_EQ_BPF3_MASK			(0x1 << 3)
+#define RT5670_EQ_BPF3_SFT			3
+#define RT5670_EQ_BPF3_DIS			(0x0 << 3)
+#define RT5670_EQ_BPF3_EN			(0x1 << 3)
+#define RT5670_EQ_BPF2_MASK			(0x1 << 2)
+#define RT5670_EQ_BPF2_SFT			2
+#define RT5670_EQ_BPF2_DIS			(0x0 << 2)
+#define RT5670_EQ_BPF2_EN			(0x1 << 2)
+#define RT5670_EQ_BPF1_MASK			(0x1 << 1)
+#define RT5670_EQ_BPF1_SFT			1
+#define RT5670_EQ_BPF1_DIS			(0x0 << 1)
+#define RT5670_EQ_BPF1_EN			(0x1 << 1)
+#define RT5670_EQ_LPF_MASK			(0x1)
+#define RT5670_EQ_LPF_SFT			0
+#define RT5670_EQ_LPF_DIS			(0x0)
+#define RT5670_EQ_LPF_EN			(0x1)
+#define RT5670_EQ_CTRL_MASK			(0x7f)
+
+/* Memory Test (0xb2) */
+#define RT5670_MT_MASK				(0x1 << 15)
+#define RT5670_MT_SFT				15
+#define RT5670_MT_DIS				(0x0 << 15)
+#define RT5670_MT_EN				(0x1 << 15)
+
+/* DRC/AGC Control 1 (0xb4) */
+#define RT5670_DRC_AGC_P_MASK			(0x1 << 15)
+#define RT5670_DRC_AGC_P_SFT			15
+#define RT5670_DRC_AGC_P_DAC			(0x0 << 15)
+#define RT5670_DRC_AGC_P_ADC			(0x1 << 15)
+#define RT5670_DRC_AGC_MASK			(0x1 << 14)
+#define RT5670_DRC_AGC_SFT			14
+#define RT5670_DRC_AGC_DIS			(0x0 << 14)
+#define RT5670_DRC_AGC_EN			(0x1 << 14)
+#define RT5670_DRC_AGC_UPD			(0x1 << 13)
+#define RT5670_DRC_AGC_UPD_BIT			13
+#define RT5670_DRC_AGC_AR_MASK			(0x1f << 8)
+#define RT5670_DRC_AGC_AR_SFT			8
+#define RT5670_DRC_AGC_R_MASK			(0x7 << 5)
+#define RT5670_DRC_AGC_R_SFT			5
+#define RT5670_DRC_AGC_R_48K			(0x1 << 5)
+#define RT5670_DRC_AGC_R_96K			(0x2 << 5)
+#define RT5670_DRC_AGC_R_192K			(0x3 << 5)
+#define RT5670_DRC_AGC_R_441K			(0x5 << 5)
+#define RT5670_DRC_AGC_R_882K			(0x6 << 5)
+#define RT5670_DRC_AGC_R_1764K			(0x7 << 5)
+#define RT5670_DRC_AGC_RC_MASK			(0x1f)
+#define RT5670_DRC_AGC_RC_SFT			0
+
+/* DRC/AGC Control 2 (0xb5) */
+#define RT5670_DRC_AGC_POB_MASK			(0x3f << 8)
+#define RT5670_DRC_AGC_POB_SFT			8
+#define RT5670_DRC_AGC_CP_MASK			(0x1 << 7)
+#define RT5670_DRC_AGC_CP_SFT			7
+#define RT5670_DRC_AGC_CP_DIS			(0x0 << 7)
+#define RT5670_DRC_AGC_CP_EN			(0x1 << 7)
+#define RT5670_DRC_AGC_CPR_MASK			(0x3 << 5)
+#define RT5670_DRC_AGC_CPR_SFT			5
+#define RT5670_DRC_AGC_CPR_1_1			(0x0 << 5)
+#define RT5670_DRC_AGC_CPR_1_2			(0x1 << 5)
+#define RT5670_DRC_AGC_CPR_1_3			(0x2 << 5)
+#define RT5670_DRC_AGC_CPR_1_4			(0x3 << 5)
+#define RT5670_DRC_AGC_PRB_MASK			(0x1f)
+#define RT5670_DRC_AGC_PRB_SFT			0
+
+/* DRC/AGC Control 3 (0xb6) */
+#define RT5670_DRC_AGC_NGB_MASK			(0xf << 12)
+#define RT5670_DRC_AGC_NGB_SFT			12
+#define RT5670_DRC_AGC_TAR_MASK			(0x1f << 7)
+#define RT5670_DRC_AGC_TAR_SFT			7
+#define RT5670_DRC_AGC_NG_MASK			(0x1 << 6)
+#define RT5670_DRC_AGC_NG_SFT			6
+#define RT5670_DRC_AGC_NG_DIS			(0x0 << 6)
+#define RT5670_DRC_AGC_NG_EN			(0x1 << 6)
+#define RT5670_DRC_AGC_NGH_MASK			(0x1 << 5)
+#define RT5670_DRC_AGC_NGH_SFT			5
+#define RT5670_DRC_AGC_NGH_DIS			(0x0 << 5)
+#define RT5670_DRC_AGC_NGH_EN			(0x1 << 5)
+#define RT5670_DRC_AGC_NGT_MASK			(0x1f)
+#define RT5670_DRC_AGC_NGT_SFT			0
+
+/* Jack Detect Control (0xbb) */
+#define RT5670_JD_MASK				(0x7 << 13)
+#define RT5670_JD_SFT				13
+#define RT5670_JD_DIS				(0x0 << 13)
+#define RT5670_JD_GPIO1				(0x1 << 13)
+#define RT5670_JD_JD1_IN4P			(0x2 << 13)
+#define RT5670_JD_JD2_IN4N			(0x3 << 13)
+#define RT5670_JD_GPIO2				(0x4 << 13)
+#define RT5670_JD_GPIO3				(0x5 << 13)
+#define RT5670_JD_GPIO4				(0x6 << 13)
+#define RT5670_JD_HP_MASK			(0x1 << 11)
+#define RT5670_JD_HP_SFT			11
+#define RT5670_JD_HP_DIS			(0x0 << 11)
+#define RT5670_JD_HP_EN				(0x1 << 11)
+#define RT5670_JD_HP_TRG_MASK			(0x1 << 10)
+#define RT5670_JD_HP_TRG_SFT			10
+#define RT5670_JD_HP_TRG_LO			(0x0 << 10)
+#define RT5670_JD_HP_TRG_HI			(0x1 << 10)
+#define RT5670_JD_SPL_MASK			(0x1 << 9)
+#define RT5670_JD_SPL_SFT			9
+#define RT5670_JD_SPL_DIS			(0x0 << 9)
+#define RT5670_JD_SPL_EN			(0x1 << 9)
+#define RT5670_JD_SPL_TRG_MASK			(0x1 << 8)
+#define RT5670_JD_SPL_TRG_SFT			8
+#define RT5670_JD_SPL_TRG_LO			(0x0 << 8)
+#define RT5670_JD_SPL_TRG_HI			(0x1 << 8)
+#define RT5670_JD_SPR_MASK			(0x1 << 7)
+#define RT5670_JD_SPR_SFT			7
+#define RT5670_JD_SPR_DIS			(0x0 << 7)
+#define RT5670_JD_SPR_EN			(0x1 << 7)
+#define RT5670_JD_SPR_TRG_MASK			(0x1 << 6)
+#define RT5670_JD_SPR_TRG_SFT			6
+#define RT5670_JD_SPR_TRG_LO			(0x0 << 6)
+#define RT5670_JD_SPR_TRG_HI			(0x1 << 6)
+#define RT5670_JD_MO_MASK			(0x1 << 5)
+#define RT5670_JD_MO_SFT			5
+#define RT5670_JD_MO_DIS			(0x0 << 5)
+#define RT5670_JD_MO_EN				(0x1 << 5)
+#define RT5670_JD_MO_TRG_MASK			(0x1 << 4)
+#define RT5670_JD_MO_TRG_SFT			4
+#define RT5670_JD_MO_TRG_LO			(0x0 << 4)
+#define RT5670_JD_MO_TRG_HI			(0x1 << 4)
+#define RT5670_JD_LO_MASK			(0x1 << 3)
+#define RT5670_JD_LO_SFT			3
+#define RT5670_JD_LO_DIS			(0x0 << 3)
+#define RT5670_JD_LO_EN				(0x1 << 3)
+#define RT5670_JD_LO_TRG_MASK			(0x1 << 2)
+#define RT5670_JD_LO_TRG_SFT			2
+#define RT5670_JD_LO_TRG_LO			(0x0 << 2)
+#define RT5670_JD_LO_TRG_HI			(0x1 << 2)
+#define RT5670_JD1_IN4P_MASK			(0x1 << 1)
+#define RT5670_JD1_IN4P_SFT			1
+#define RT5670_JD1_IN4P_DIS			(0x0 << 1)
+#define RT5670_JD1_IN4P_EN			(0x1 << 1)
+#define RT5670_JD2_IN4N_MASK			(0x1)
+#define RT5670_JD2_IN4N_SFT			0
+#define RT5670_JD2_IN4N_DIS			(0x0)
+#define RT5670_JD2_IN4N_EN			(0x1)
+
+/* IRQ Control 1 (0xbd) */
+#define RT5670_IRQ_JD_MASK			(0x1 << 15)
+#define RT5670_IRQ_JD_SFT			15
+#define RT5670_IRQ_JD_BP			(0x0 << 15)
+#define RT5670_IRQ_JD_NOR			(0x1 << 15)
+#define RT5670_IRQ_OT_MASK			(0x1 << 14)
+#define RT5670_IRQ_OT_SFT			14
+#define RT5670_IRQ_OT_BP			(0x0 << 14)
+#define RT5670_IRQ_OT_NOR			(0x1 << 14)
+#define RT5670_JD_STKY_MASK			(0x1 << 13)
+#define RT5670_JD_STKY_SFT			13
+#define RT5670_JD_STKY_DIS			(0x0 << 13)
+#define RT5670_JD_STKY_EN			(0x1 << 13)
+#define RT5670_OT_STKY_MASK			(0x1 << 12)
+#define RT5670_OT_STKY_SFT			12
+#define RT5670_OT_STKY_DIS			(0x0 << 12)
+#define RT5670_OT_STKY_EN			(0x1 << 12)
+#define RT5670_JD_P_MASK			(0x1 << 11)
+#define RT5670_JD_P_SFT				11
+#define RT5670_JD_P_NOR				(0x0 << 11)
+#define RT5670_JD_P_INV				(0x1 << 11)
+#define RT5670_OT_P_MASK			(0x1 << 10)
+#define RT5670_OT_P_SFT				10
+#define RT5670_OT_P_NOR				(0x0 << 10)
+#define RT5670_OT_P_INV				(0x1 << 10)
+#define RT5670_JD1_1_EN_MASK			(0x1 << 9)
+#define RT5670_JD1_1_EN_SFT			9
+#define RT5670_JD1_1_DIS			(0x0 << 9)
+#define RT5670_JD1_1_EN				(0x1 << 9)
+
+/* IRQ Control 2 (0xbe) */
+#define RT5670_IRQ_MB1_OC_MASK			(0x1 << 15)
+#define RT5670_IRQ_MB1_OC_SFT			15
+#define RT5670_IRQ_MB1_OC_BP			(0x0 << 15)
+#define RT5670_IRQ_MB1_OC_NOR			(0x1 << 15)
+#define RT5670_IRQ_MB2_OC_MASK			(0x1 << 14)
+#define RT5670_IRQ_MB2_OC_SFT			14
+#define RT5670_IRQ_MB2_OC_BP			(0x0 << 14)
+#define RT5670_IRQ_MB2_OC_NOR			(0x1 << 14)
+#define RT5670_MB1_OC_STKY_MASK			(0x1 << 11)
+#define RT5670_MB1_OC_STKY_SFT			11
+#define RT5670_MB1_OC_STKY_DIS			(0x0 << 11)
+#define RT5670_MB1_OC_STKY_EN			(0x1 << 11)
+#define RT5670_MB2_OC_STKY_MASK			(0x1 << 10)
+#define RT5670_MB2_OC_STKY_SFT			10
+#define RT5670_MB2_OC_STKY_DIS			(0x0 << 10)
+#define RT5670_MB2_OC_STKY_EN			(0x1 << 10)
+#define RT5670_MB1_OC_P_MASK			(0x1 << 7)
+#define RT5670_MB1_OC_P_SFT			7
+#define RT5670_MB1_OC_P_NOR			(0x0 << 7)
+#define RT5670_MB1_OC_P_INV			(0x1 << 7)
+#define RT5670_MB2_OC_P_MASK			(0x1 << 6)
+#define RT5670_MB2_OC_P_SFT			6
+#define RT5670_MB2_OC_P_NOR			(0x0 << 6)
+#define RT5670_MB2_OC_P_INV			(0x1 << 6)
+#define RT5670_MB1_OC_CLR			(0x1 << 3)
+#define RT5670_MB1_OC_CLR_SFT			3
+#define RT5670_MB2_OC_CLR			(0x1 << 2)
+#define RT5670_MB2_OC_CLR_SFT			2
+
+/* GPIO Control 1 (0xc0) */
+#define RT5670_GP1_PIN_MASK			(0x1 << 15)
+#define RT5670_GP1_PIN_SFT			15
+#define RT5670_GP1_PIN_GPIO1			(0x0 << 15)
+#define RT5670_GP1_PIN_IRQ			(0x1 << 15)
+#define RT5670_GP2_PIN_MASK			(0x1 << 14)
+#define RT5670_GP2_PIN_SFT			14
+#define RT5670_GP2_PIN_GPIO2			(0x0 << 14)
+#define RT5670_GP2_PIN_DMIC1_SCL		(0x1 << 14)
+#define RT5670_GP3_PIN_MASK			(0x3 << 12)
+#define RT5670_GP3_PIN_SFT			12
+#define RT5670_GP3_PIN_GPIO3			(0x0 << 12)
+#define RT5670_GP3_PIN_DMIC1_SDA		(0x1 << 12)
+#define RT5670_GP3_PIN_IRQ			(0x2 << 12)
+#define RT5670_GP4_PIN_MASK			(0x1 << 11)
+#define RT5670_GP4_PIN_SFT			11
+#define RT5670_GP4_PIN_GPIO4			(0x0 << 11)
+#define RT5670_GP4_PIN_DMIC2_SDA		(0x1 << 11)
+#define RT5670_DP_SIG_MASK			(0x1 << 10)
+#define RT5670_DP_SIG_SFT			10
+#define RT5670_DP_SIG_TEST			(0x0 << 10)
+#define RT5670_DP_SIG_AP			(0x1 << 10)
+#define RT5670_GPIO_M_MASK			(0x1 << 9)
+#define RT5670_GPIO_M_SFT			9
+#define RT5670_GPIO_M_FLT			(0x0 << 9)
+#define RT5670_GPIO_M_PH			(0x1 << 9)
+#define RT5670_I2S2_PIN_MASK			(0x1 << 8)
+#define RT5670_I2S2_PIN_SFT			8
+#define RT5670_I2S2_PIN_I2S			(0x0 << 8)
+#define RT5670_I2S2_PIN_GPIO			(0x1 << 8)
+#define RT5670_GP5_PIN_MASK			(0x1 << 7)
+#define RT5670_GP5_PIN_SFT			7
+#define RT5670_GP5_PIN_GPIO5			(0x0 << 7)
+#define RT5670_GP5_PIN_DMIC3_SDA		(0x1 << 7)
+#define RT5670_GP6_PIN_MASK			(0x1 << 6)
+#define RT5670_GP6_PIN_SFT			6
+#define RT5670_GP6_PIN_GPIO6			(0x0 << 6)
+#define RT5670_GP6_PIN_DMIC1_SDA		(0x1 << 6)
+#define RT5670_GP7_PIN_MASK			(0x3 << 4)
+#define RT5670_GP7_PIN_SFT			4
+#define RT5670_GP7_PIN_GPIO7			(0x0 << 4)
+#define RT5670_GP7_PIN_DMIC1_SDA		(0x1 << 4)
+#define RT5670_GP7_PIN_PDM_SCL2			(0x2 << 4)
+#define RT5670_GP8_PIN_MASK			(0x1 << 3)
+#define RT5670_GP8_PIN_SFT			3
+#define RT5670_GP8_PIN_GPIO8			(0x0 << 3)
+#define RT5670_GP8_PIN_DMIC2_SDA		(0x1 << 3)
+#define RT5670_GP9_PIN_MASK			(0x1 << 2)
+#define RT5670_GP9_PIN_SFT			2
+#define RT5670_GP9_PIN_GPIO9			(0x0 << 2)
+#define RT5670_GP9_PIN_DMIC3_SDA		(0x1 << 2)
+#define RT5670_GP10_PIN_MASK			(0x3)
+#define RT5670_GP10_PIN_SFT			0
+#define RT5670_GP10_PIN_GPIO9			(0x0)
+#define RT5670_GP10_PIN_DMIC3_SDA		(0x1)
+#define RT5670_GP10_PIN_PDM_ADT2		(0x2)
+
+/* GPIO Control 2 (0xc1) */
+#define RT5670_GP4_PF_MASK			(0x1 << 11)
+#define RT5670_GP4_PF_SFT			11
+#define RT5670_GP4_PF_IN			(0x0 << 11)
+#define RT5670_GP4_PF_OUT			(0x1 << 11)
+#define RT5670_GP4_OUT_MASK			(0x1 << 10)
+#define RT5670_GP4_OUT_SFT			10
+#define RT5670_GP4_OUT_LO			(0x0 << 10)
+#define RT5670_GP4_OUT_HI			(0x1 << 10)
+#define RT5670_GP4_P_MASK			(0x1 << 9)
+#define RT5670_GP4_P_SFT			9
+#define RT5670_GP4_P_NOR			(0x0 << 9)
+#define RT5670_GP4_P_INV			(0x1 << 9)
+#define RT5670_GP3_PF_MASK			(0x1 << 8)
+#define RT5670_GP3_PF_SFT			8
+#define RT5670_GP3_PF_IN			(0x0 << 8)
+#define RT5670_GP3_PF_OUT			(0x1 << 8)
+#define RT5670_GP3_OUT_MASK			(0x1 << 7)
+#define RT5670_GP3_OUT_SFT			7
+#define RT5670_GP3_OUT_LO			(0x0 << 7)
+#define RT5670_GP3_OUT_HI			(0x1 << 7)
+#define RT5670_GP3_P_MASK			(0x1 << 6)
+#define RT5670_GP3_P_SFT			6
+#define RT5670_GP3_P_NOR			(0x0 << 6)
+#define RT5670_GP3_P_INV			(0x1 << 6)
+#define RT5670_GP2_PF_MASK			(0x1 << 5)
+#define RT5670_GP2_PF_SFT			5
+#define RT5670_GP2_PF_IN			(0x0 << 5)
+#define RT5670_GP2_PF_OUT			(0x1 << 5)
+#define RT5670_GP2_OUT_MASK			(0x1 << 4)
+#define RT5670_GP2_OUT_SFT			4
+#define RT5670_GP2_OUT_LO			(0x0 << 4)
+#define RT5670_GP2_OUT_HI			(0x1 << 4)
+#define RT5670_GP2_P_MASK			(0x1 << 3)
+#define RT5670_GP2_P_SFT			3
+#define RT5670_GP2_P_NOR			(0x0 << 3)
+#define RT5670_GP2_P_INV			(0x1 << 3)
+#define RT5670_GP1_PF_MASK			(0x1 << 2)
+#define RT5670_GP1_PF_SFT			2
+#define RT5670_GP1_PF_IN			(0x0 << 2)
+#define RT5670_GP1_PF_OUT			(0x1 << 2)
+#define RT5670_GP1_OUT_MASK			(0x1 << 1)
+#define RT5670_GP1_OUT_SFT			1
+#define RT5670_GP1_OUT_LO			(0x0 << 1)
+#define RT5670_GP1_OUT_HI			(0x1 << 1)
+#define RT5670_GP1_P_MASK			(0x1)
+#define RT5670_GP1_P_SFT			0
+#define RT5670_GP1_P_NOR			(0x0)
+#define RT5670_GP1_P_INV			(0x1)
+
+/* Scramble Function (0xcd) */
+#define RT5670_SCB_KEY_MASK			(0xff)
+#define RT5670_SCB_KEY_SFT			0
+
+/* Scramble Control (0xce) */
+#define RT5670_SCB_SWAP_MASK			(0x1 << 15)
+#define RT5670_SCB_SWAP_SFT			15
+#define RT5670_SCB_SWAP_DIS			(0x0 << 15)
+#define RT5670_SCB_SWAP_EN			(0x1 << 15)
+#define RT5670_SCB_MASK				(0x1 << 14)
+#define RT5670_SCB_SFT				14
+#define RT5670_SCB_DIS				(0x0 << 14)
+#define RT5670_SCB_EN				(0x1 << 14)
+
+/* Baseback Control (0xcf) */
+#define RT5670_BB_MASK				(0x1 << 15)
+#define RT5670_BB_SFT				15
+#define RT5670_BB_DIS				(0x0 << 15)
+#define RT5670_BB_EN				(0x1 << 15)
+#define RT5670_BB_CT_MASK			(0x7 << 12)
+#define RT5670_BB_CT_SFT			12
+#define RT5670_BB_CT_A				(0x0 << 12)
+#define RT5670_BB_CT_B				(0x1 << 12)
+#define RT5670_BB_CT_C				(0x2 << 12)
+#define RT5670_BB_CT_D				(0x3 << 12)
+#define RT5670_M_BB_L_MASK			(0x1 << 9)
+#define RT5670_M_BB_L_SFT			9
+#define RT5670_M_BB_R_MASK			(0x1 << 8)
+#define RT5670_M_BB_R_SFT			8
+#define RT5670_M_BB_HPF_L_MASK			(0x1 << 7)
+#define RT5670_M_BB_HPF_L_SFT			7
+#define RT5670_M_BB_HPF_R_MASK			(0x1 << 6)
+#define RT5670_M_BB_HPF_R_SFT			6
+#define RT5670_G_BB_BST_MASK			(0x3f)
+#define RT5670_G_BB_BST_SFT			0
+
+/* MP3 Plus Control 1 (0xd0) */
+#define RT5670_M_MP3_L_MASK			(0x1 << 15)
+#define RT5670_M_MP3_L_SFT			15
+#define RT5670_M_MP3_R_MASK			(0x1 << 14)
+#define RT5670_M_MP3_R_SFT			14
+#define RT5670_M_MP3_MASK			(0x1 << 13)
+#define RT5670_M_MP3_SFT			13
+#define RT5670_M_MP3_DIS			(0x0 << 13)
+#define RT5670_M_MP3_EN				(0x1 << 13)
+#define RT5670_EG_MP3_MASK			(0x1f << 8)
+#define RT5670_EG_MP3_SFT			8
+#define RT5670_MP3_HLP_MASK			(0x1 << 7)
+#define RT5670_MP3_HLP_SFT			7
+#define RT5670_MP3_HLP_DIS			(0x0 << 7)
+#define RT5670_MP3_HLP_EN			(0x1 << 7)
+#define RT5670_M_MP3_ORG_L_MASK			(0x1 << 6)
+#define RT5670_M_MP3_ORG_L_SFT			6
+#define RT5670_M_MP3_ORG_R_MASK			(0x1 << 5)
+#define RT5670_M_MP3_ORG_R_SFT			5
+
+/* MP3 Plus Control 2 (0xd1) */
+#define RT5670_MP3_WT_MASK			(0x1 << 13)
+#define RT5670_MP3_WT_SFT			13
+#define RT5670_MP3_WT_1_4			(0x0 << 13)
+#define RT5670_MP3_WT_1_2			(0x1 << 13)
+#define RT5670_OG_MP3_MASK			(0x1f << 8)
+#define RT5670_OG_MP3_SFT			8
+#define RT5670_HG_MP3_MASK			(0x3f)
+#define RT5670_HG_MP3_SFT			0
+
+/* 3D HP Control 1 (0xd2) */
+#define RT5670_3D_CF_MASK			(0x1 << 15)
+#define RT5670_3D_CF_SFT			15
+#define RT5670_3D_CF_DIS			(0x0 << 15)
+#define RT5670_3D_CF_EN				(0x1 << 15)
+#define RT5670_3D_HP_MASK			(0x1 << 14)
+#define RT5670_3D_HP_SFT			14
+#define RT5670_3D_HP_DIS			(0x0 << 14)
+#define RT5670_3D_HP_EN				(0x1 << 14)
+#define RT5670_3D_BT_MASK			(0x1 << 13)
+#define RT5670_3D_BT_SFT			13
+#define RT5670_3D_BT_DIS			(0x0 << 13)
+#define RT5670_3D_BT_EN				(0x1 << 13)
+#define RT5670_3D_1F_MIX_MASK			(0x3 << 11)
+#define RT5670_3D_1F_MIX_SFT			11
+#define RT5670_3D_HP_M_MASK			(0x1 << 10)
+#define RT5670_3D_HP_M_SFT			10
+#define RT5670_3D_HP_M_SUR			(0x0 << 10)
+#define RT5670_3D_HP_M_FRO			(0x1 << 10)
+#define RT5670_M_3D_HRTF_MASK			(0x1 << 9)
+#define RT5670_M_3D_HRTF_SFT			9
+#define RT5670_M_3D_D2H_MASK			(0x1 << 8)
+#define RT5670_M_3D_D2H_SFT			8
+#define RT5670_M_3D_D2R_MASK			(0x1 << 7)
+#define RT5670_M_3D_D2R_SFT			7
+#define RT5670_M_3D_REVB_MASK			(0x1 << 6)
+#define RT5670_M_3D_REVB_SFT			6
+
+/* Adjustable high pass filter control 1 (0xd3) */
+#define RT5670_2ND_HPF_MASK			(0x1 << 15)
+#define RT5670_2ND_HPF_SFT			15
+#define RT5670_2ND_HPF_DIS			(0x0 << 15)
+#define RT5670_2ND_HPF_EN			(0x1 << 15)
+#define RT5670_HPF_CF_L_MASK			(0x7 << 12)
+#define RT5670_HPF_CF_L_SFT			12
+#define RT5670_1ST_HPF_MASK			(0x1 << 11)
+#define RT5670_1ST_HPF_SFT			11
+#define RT5670_1ST_HPF_DIS			(0x0 << 11)
+#define RT5670_1ST_HPF_EN			(0x1 << 11)
+#define RT5670_HPF_CF_R_MASK			(0x7 << 8)
+#define RT5670_HPF_CF_R_SFT			8
+#define RT5670_ZD_T_MASK			(0x3 << 6)
+#define RT5670_ZD_T_SFT				6
+#define RT5670_ZD_F_MASK			(0x3 << 4)
+#define RT5670_ZD_F_SFT				4
+#define RT5670_ZD_F_IM				(0x0 << 4)
+#define RT5670_ZD_F_ZC_IM			(0x1 << 4)
+#define RT5670_ZD_F_ZC_IOD			(0x2 << 4)
+#define RT5670_ZD_F_UN				(0x3 << 4)
+
+/* HP calibration control and Amp detection (0xd6) */
+#define RT5670_SI_DAC_MASK			(0x1 << 11)
+#define RT5670_SI_DAC_SFT			11
+#define RT5670_SI_DAC_AUTO			(0x0 << 11)
+#define RT5670_SI_DAC_TEST			(0x1 << 11)
+#define RT5670_DC_CAL_M_MASK			(0x1 << 10)
+#define RT5670_DC_CAL_M_SFT			10
+#define RT5670_DC_CAL_M_CAL			(0x0 << 10)
+#define RT5670_DC_CAL_M_NOR			(0x1 << 10)
+#define RT5670_DC_CAL_MASK			(0x1 << 9)
+#define RT5670_DC_CAL_SFT			9
+#define RT5670_DC_CAL_DIS			(0x0 << 9)
+#define RT5670_DC_CAL_EN			(0x1 << 9)
+#define RT5670_HPD_RCV_MASK			(0x7 << 6)
+#define RT5670_HPD_RCV_SFT			6
+#define RT5670_HPD_PS_MASK			(0x1 << 5)
+#define RT5670_HPD_PS_SFT			5
+#define RT5670_HPD_PS_DIS			(0x0 << 5)
+#define RT5670_HPD_PS_EN			(0x1 << 5)
+#define RT5670_CAL_M_MASK			(0x1 << 4)
+#define RT5670_CAL_M_SFT			4
+#define RT5670_CAL_M_DEP			(0x0 << 4)
+#define RT5670_CAL_M_CAL			(0x1 << 4)
+#define RT5670_CAL_MASK				(0x1 << 3)
+#define RT5670_CAL_SFT				3
+#define RT5670_CAL_DIS				(0x0 << 3)
+#define RT5670_CAL_EN				(0x1 << 3)
+#define RT5670_CAL_TEST_MASK			(0x1 << 2)
+#define RT5670_CAL_TEST_SFT			2
+#define RT5670_CAL_TEST_DIS			(0x0 << 2)
+#define RT5670_CAL_TEST_EN			(0x1 << 2)
+#define RT5670_CAL_P_MASK			(0x3)
+#define RT5670_CAL_P_SFT			0
+#define RT5670_CAL_P_NONE			(0x0)
+#define RT5670_CAL_P_CAL			(0x1)
+#define RT5670_CAL_P_DAC_CAL			(0x2)
+
+/* Soft volume and zero cross control 1 (0xd9) */
+#define RT5670_SV_MASK				(0x1 << 15)
+#define RT5670_SV_SFT				15
+#define RT5670_SV_DIS				(0x0 << 15)
+#define RT5670_SV_EN				(0x1 << 15)
+#define RT5670_SPO_SV_MASK			(0x1 << 14)
+#define RT5670_SPO_SV_SFT			14
+#define RT5670_SPO_SV_DIS			(0x0 << 14)
+#define RT5670_SPO_SV_EN			(0x1 << 14)
+#define RT5670_OUT_SV_MASK			(0x1 << 13)
+#define RT5670_OUT_SV_SFT			13
+#define RT5670_OUT_SV_DIS			(0x0 << 13)
+#define RT5670_OUT_SV_EN			(0x1 << 13)
+#define RT5670_HP_SV_MASK			(0x1 << 12)
+#define RT5670_HP_SV_SFT			12
+#define RT5670_HP_SV_DIS			(0x0 << 12)
+#define RT5670_HP_SV_EN				(0x1 << 12)
+#define RT5670_ZCD_DIG_MASK			(0x1 << 11)
+#define RT5670_ZCD_DIG_SFT			11
+#define RT5670_ZCD_DIG_DIS			(0x0 << 11)
+#define RT5670_ZCD_DIG_EN			(0x1 << 11)
+#define RT5670_ZCD_MASK				(0x1 << 10)
+#define RT5670_ZCD_SFT				10
+#define RT5670_ZCD_PD				(0x0 << 10)
+#define RT5670_ZCD_PU				(0x1 << 10)
+#define RT5670_M_ZCD_MASK			(0x3f << 4)
+#define RT5670_M_ZCD_SFT			4
+#define RT5670_M_ZCD_RM_L			(0x1 << 9)
+#define RT5670_M_ZCD_RM_R			(0x1 << 8)
+#define RT5670_M_ZCD_SM_L			(0x1 << 7)
+#define RT5670_M_ZCD_SM_R			(0x1 << 6)
+#define RT5670_M_ZCD_OM_L			(0x1 << 5)
+#define RT5670_M_ZCD_OM_R			(0x1 << 4)
+#define RT5670_SV_DLY_MASK			(0xf)
+#define RT5670_SV_DLY_SFT			0
+
+/* Soft volume and zero cross control 2 (0xda) */
+#define RT5670_ZCD_HP_MASK			(0x1 << 15)
+#define RT5670_ZCD_HP_SFT			15
+#define RT5670_ZCD_HP_DIS			(0x0 << 15)
+#define RT5670_ZCD_HP_EN			(0x1 << 15)
+
+
+/* Codec Private Register definition */
+/* 3D Speaker Control (0x63) */
+#define RT5670_3D_SPK_MASK			(0x1 << 15)
+#define RT5670_3D_SPK_SFT			15
+#define RT5670_3D_SPK_DIS			(0x0 << 15)
+#define RT5670_3D_SPK_EN			(0x1 << 15)
+#define RT5670_3D_SPK_M_MASK			(0x3 << 13)
+#define RT5670_3D_SPK_M_SFT			13
+#define RT5670_3D_SPK_CG_MASK			(0x1f << 8)
+#define RT5670_3D_SPK_CG_SFT			8
+#define RT5670_3D_SPK_SG_MASK			(0x1f)
+#define RT5670_3D_SPK_SG_SFT			0
+
+/* Wind Noise Detection Control 1 (0x6c) */
+#define RT5670_WND_MASK				(0x1 << 15)
+#define RT5670_WND_SFT				15
+#define RT5670_WND_DIS				(0x0 << 15)
+#define RT5670_WND_EN				(0x1 << 15)
+
+/* Wind Noise Detection Control 2 (0x6d) */
+#define RT5670_WND_FC_NW_MASK			(0x3f << 10)
+#define RT5670_WND_FC_NW_SFT			10
+#define RT5670_WND_FC_WK_MASK			(0x3f << 4)
+#define RT5670_WND_FC_WK_SFT			4
+
+/* Wind Noise Detection Control 3 (0x6e) */
+#define RT5670_HPF_FC_MASK			(0x3f << 6)
+#define RT5670_HPF_FC_SFT			6
+#define RT5670_WND_FC_ST_MASK			(0x3f)
+#define RT5670_WND_FC_ST_SFT			0
+
+/* Wind Noise Detection Control 4 (0x6f) */
+#define RT5670_WND_TH_LO_MASK			(0x3ff)
+#define RT5670_WND_TH_LO_SFT			0
+
+/* Wind Noise Detection Control 5 (0x70) */
+#define RT5670_WND_TH_HI_MASK			(0x3ff)
+#define RT5670_WND_TH_HI_SFT			0
+
+/* Wind Noise Detection Control 8 (0x73) */
+#define RT5670_WND_WIND_MASK			(0x1 << 13) /* Read-Only */
+#define RT5670_WND_WIND_SFT			13
+#define RT5670_WND_STRONG_MASK			(0x1 << 12) /* Read-Only */
+#define RT5670_WND_STRONG_SFT			12
+enum {
+	RT5670_NO_WIND,
+	RT5670_BREEZE,
+	RT5670_STORM,
+};
+
+/* Dipole Speaker Interface (0x75) */
+#define RT5670_DP_ATT_MASK			(0x3 << 14)
+#define RT5670_DP_ATT_SFT			14
+#define RT5670_DP_SPK_MASK			(0x1 << 10)
+#define RT5670_DP_SPK_SFT			10
+#define RT5670_DP_SPK_DIS			(0x0 << 10)
+#define RT5670_DP_SPK_EN			(0x1 << 10)
+
+/* EQ Pre Volume Control (0xb3) */
+#define RT5670_EQ_PRE_VOL_MASK			(0xffff)
+#define RT5670_EQ_PRE_VOL_SFT			0
+
+/* EQ Post Volume Control (0xb4) */
+#define RT5670_EQ_PST_VOL_MASK			(0xffff)
+#define RT5670_EQ_PST_VOL_SFT			0
+
+/* Jack Detect Control 3 (0xf8) */
+#define RT5670_CMP_MIC_IN_DET_MASK		(0x7 << 12)
+#define RT5670_JD_CBJ_EN			(0x1 << 7)
+#define RT5670_JD_CBJ_POL			(0x1 << 6)
+#define RT5670_JD_TRI_CBJ_SEL_MASK		(0x7 << 3)
+#define RT5670_JD_TRI_CBJ_SEL_SFT		(3)
+#define RT5670_JD_CBJ_GPIO_JD1			(0x0 << 3)
+#define RT5670_JD_CBJ_JD1_1			(0x1 << 3)
+#define RT5670_JD_CBJ_JD1_2			(0x2 << 3)
+#define RT5670_JD_CBJ_JD2			(0x3 << 3)
+#define RT5670_JD_CBJ_JD3			(0x4 << 3)
+#define RT5670_JD_CBJ_GPIO_JD2			(0x5 << 3)
+#define RT5670_JD_CBJ_MX0B_12			(0x6 << 3)
+#define RT5670_JD_TRI_HPO_SEL_MASK		(0x7 << 3)
+#define RT5670_JD_TRI_HPO_SEL_SFT		(0)
+#define RT5670_JD_HPO_GPIO_JD1			(0x0)
+#define RT5670_JD_HPO_JD1_1			(0x1)
+#define RT5670_JD_HPO_JD1_2			(0x2)
+#define RT5670_JD_HPO_JD2			(0x3)
+#define RT5670_JD_HPO_JD3			(0x4)
+#define RT5670_JD_HPO_GPIO_JD2			(0x5)
+#define RT5670_JD_HPO_MX0B_12			(0x6)
+
+/* Digital Misc Control (0xfa) */
+#define RT5670_RST_DSP				(0x1 << 13)
+#define RT5670_IF1_ADC1_IN1_SEL			(0x1 << 12)
+#define RT5670_IF1_ADC1_IN1_SFT			12
+#define RT5670_IF1_ADC1_IN2_SEL			(0x1 << 11)
+#define RT5670_IF1_ADC1_IN2_SFT			11
+#define RT5670_IF1_ADC2_IN1_SEL			(0x1 << 10)
+#define RT5670_IF1_ADC2_IN1_SFT			10
+
+/* General Control2 (0xfb) */
+#define RT5670_RXDC_SRC_MASK			(0x1 << 7)
+#define RT5670_RXDC_SRC_STO			(0x0 << 7)
+#define RT5670_RXDC_SRC_MONO			(0x1 << 7)
+#define RT5670_RXDC_SRC_SFT			(7)
+#define RT5670_RXDP2_SEL_MASK			(0x1 << 3)
+#define RT5670_RXDP2_SEL_IF2			(0x0 << 3)
+#define RT5670_RXDP2_SEL_ADC			(0x1 << 3)
+#define RT5670_RXDP2_SEL_SFT			(3)
+
+/* System Clock Source */
+enum {
+	RT5670_SCLK_S_MCLK,
+	RT5670_SCLK_S_PLL1,
+	RT5670_SCLK_S_RCCLK,
+};
+
+/* PLL1 Source */
+enum {
+	RT5670_PLL1_S_MCLK,
+	RT5670_PLL1_S_BCLK1,
+	RT5670_PLL1_S_BCLK2,
+	RT5670_PLL1_S_BCLK3,
+	RT5670_PLL1_S_BCLK4,
+};
+
+enum {
+	RT5670_AIF1,
+	RT5670_AIF2,
+	RT5670_AIF3,
+	RT5670_AIF4,
+	RT5670_AIFS,
+};
+
+enum {
+	RT5670_DMIC_DATA_GPIO6,
+	RT5670_DMIC_DATA_IN2P,
+	RT5670_DMIC_DATA_GPIO7,
+};
+
+enum {
+	RT5670_DMIC_DATA_GPIO8,
+	RT5670_DMIC_DATA_IN3N,
+};
+
+enum {
+	RT5670_DMIC_DATA_GPIO9,
+	RT5670_DMIC_DATA_GPIO10,
+	RT5670_DMIC_DATA_GPIO5,
+};
+
+struct rt5670_priv {
+	struct snd_soc_codec *codec;
+	struct rt5670_platform_data pdata;
+	struct regmap *regmap;
+
+	int sysclk;
+	int sysclk_src;
+	int lrck[RT5670_AIFS];
+	int bclk[RT5670_AIFS];
+	int master[RT5670_AIFS];
+
+	int pll_src;
+	int pll_in;
+	int pll_out;
+
+	int dsp_sw; /* expected parameter setting */
+	int dsp_rate;
+	int jack_type;
+};
+
+#endif /* __RT5670_H__ */
-- 
1.8.1.1.439.g50a6b54
