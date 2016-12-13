From: Li Xu <li.xu@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs35l35: Add support for Cirrus
	CS35L35 Amplifier
Date: Tue, 13 Dec 2016 10:08:50 -0600
Message-ID: <ad824398-5534-495c-91d3-656341bf8212@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A55266E2D
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 17:09:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, Paul.Handrigan@cirrus.com, Li Xu <li.xu@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Add driver support for Cirrus Logic CS35L35 boosted
speaker amplifier

Signed-off-by: Li Xu <li.xu@cirrus.com>
---
 include/sound/cs35l35.h    |  104 ++++
 sound/soc/codecs/Kconfig   |    5 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/cs35l35.c | 1355 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l35.h |  284 ++++++++++
 5 files changed, 1750 insertions(+)
 create mode 100644 include/sound/cs35l35.h
 create mode 100644 sound/soc/codecs/cs35l35.c
 create mode 100644 sound/soc/codecs/cs35l35.h

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
new file mode 100644
index 0000000..005a813
--- /dev/null
+++ b/include/sound/cs35l35.h
@@ -0,0 +1,104 @@
+/*
+ * linux/sound/cs35l35.h -- Platform data for CS35l35
+ *
+ * Copyright (c) 2016 Cirrus Logic Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CS35L35_H
+#define __CS35L35_H
+
+struct classh_cfg {
+	/*
+	 * Class H Algorithm Control Variables
+	 * You can either have it done
+	 * automatically or you can adjust
+	 * these variables for tuning
+	 *
+	 * if you do not enable the internal algorithm
+	 * you will get a set of mixer controls for
+	 * Class H tuning
+	 *
+	 * Section 4.3 of the datasheet
+	 */
+	/* Internal ClassH Algorithm  */
+	bool classh_bst_override;
+	bool classh_algo_enable;
+	int classh_bst_max_limit;
+	int classh_mem_depth;
+	int classh_release_rate;
+	int classh_headroom;
+	int classh_wk_fet_disable;
+	int classh_wk_fet_delay;
+	int classh_wk_fet_thld;
+	int classh_vpch_auto;
+	int classh_vpch_rate;
+	int classh_vpch_man;
+};
+
+struct monitor_cfg {
+	/*
+	 * Signal Monitor Data
+	 * highly configurable signal monitoring
+	 * data positioning and different types of
+	 * monitoring data.
+	 *
+	 * Section 4.8.2 - 4.8.4 of the datasheet
+	 */
+	bool is_present;
+	bool imon_specs;
+	bool vmon_specs;
+	bool vpmon_specs;
+	bool vbstmon_specs;
+	bool vpbrstat_specs;
+	bool zerofill_specs;
+	u8 imon_dpth;
+	u8 imon_loc;
+	u8 imon_frm;
+	u8 vmon_dpth;
+	u8 vmon_loc;
+	u8 vmon_frm;
+	u8 vpmon_dpth;
+	u8 vpmon_loc;
+	u8 vpmon_frm;
+	u8 vbstmon_dpth;
+	u8 vbstmon_loc;
+	u8 vbstmon_frm;
+	u8 vpbrstat_dpth;
+	u8 vpbrstat_loc;
+	u8 vpbrstat_frm;
+	u8 zerofill_dpth;
+	u8 zerofill_loc;
+	u8 zerofill_frm;
+};
+
+struct cs35l35_platform_data {
+
+	/* Stereo (2 Device) */
+	bool stereo;
+	/* serial port drive strength */
+	int sp_drv_str;
+	/* Boost Power Down with FET */
+	bool bst_pdn_fet_on;
+	/* Boost Voltage : used if ClassH Algo Enabled */
+	int bst_vctl;
+	/* Boost Converter Peak Current CTRL */
+	int bst_ipk;
+	/* Amp Gain Zero Cross */
+	bool gain_zc;
+	/* Audio Input Location */
+	int aud_channel;
+	/* Advisory Input Location */
+	int adv_channel;
+	/* Shared Boost for stereo */
+	bool shared_bst;
+	/* ClassH Algorithm */
+	struct classh_cfg classh_algo;
+	/* Monitor Config */
+	struct monitor_cfg mon_cfg;
+};
+
+#endif /* __CS35L35_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a..3fd0a08 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -49,6 +49,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS35L32 if I2C
 	select SND_SOC_CS35L33 if I2C
 	select SND_SOC_CS35L34 if I2C
+	select SND_SOC_CS35L35 if I2C
 	select SND_SOC_CS42L42 if I2C
 	select SND_SOC_CS42L51_I2C if I2C
 	select SND_SOC_CS42L52 if I2C && INPUT
@@ -407,6 +408,10 @@ config SND_SOC_CS35L34
 	tristate "Cirrus Logic CS35L34 CODEC"
 	depends on I2C
 
+config SND_SOC_CS35L35
+	tristate "Cirrus Logic CS35L35 CODEC"
+	depends on I2C
+
 config SND_SOC_CS42L42
 	tristate "Cirrus Logic CS42L42 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7e1dad7..a5622f6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -39,6 +39,7 @@ snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs35l32-objs := cs35l32.o
 snd-soc-cs35l33-objs := cs35l33.o
 snd-soc-cs35l34-objs := cs35l34.o
+snd-soc-cs35l35-objs := cs35l35.o
 snd-soc-cs42l42-objs := cs42l42.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
@@ -268,6 +269,7 @@ obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
 obj-$(CONFIG_SND_SOC_CS35L33)	+= snd-soc-cs35l33.o
 obj-$(CONFIG_SND_SOC_CS35L34)	+= snd-soc-cs35l34.o
+obj-$(CONFIG_SND_SOC_CS35L35)	+= snd-soc-cs35l35.o
 obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
new file mode 100644
index 0000000..b05e900
--- /dev/null
+++ b/sound/soc/codecs/cs35l35.c
@@ -0,0 +1,1355 @@
+/*
+ * cs35l35.c -- CS35L35 ALSA SoC audio driver
+ *
+ * Copyright 2016 Cirrus Logic, Inc.
+ *
+ * Author: Li Xu <li.xu@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <linux/gpio.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/cs35l35.h>
+#include <linux/of_irq.h>
+#include <linux/completion.h>
+
+#include "cs35l35.h"
+
+static const struct reg_default cs35l35_reg[] = {
+	{CS35L35_PWRCTL1,		0x01},
+	{CS35L35_PWRCTL2,		0x11},
+	{CS35L35_PWRCTL3,		0x00},
+	{CS35L35_CLK_CTL1,		0x04},
+	{CS35L35_CLK_CTL2,		0x10},
+	{CS35L35_CLK_CTL3,		0xCF},
+	{CS35L35_SP_FMT_CTL1,		0x20},
+	{CS35L35_SP_FMT_CTL2,		0x00},
+	{CS35L35_SP_FMT_CTL3,		0x02},
+	{CS35L35_MAG_COMP_CTL,		0x00},
+	{CS35L35_AMP_INP_DRV_CTL,	0x01},
+	{CS35L35_AMP_DIG_VOL_CTL,	0x12},
+	{CS35L35_AMP_DIG_VOL,		0x00},
+	{CS35L35_ADV_DIG_VOL,		0x00},
+	{CS35L35_PROTECT_CTL,		0x06},
+	{CS35L35_AMP_GAIN_AUD_CTL,	0x13},
+	{CS35L35_AMP_GAIN_PDM_CTL,	0x00},
+	{CS35L35_AMP_GAIN_ADV_CTL,	0x00},
+	{CS35L35_GPI_CTL,		0x00},
+	{CS35L35_BST_CVTR_V_CTL,	0x00},
+	{CS35L35_BST_PEAK_I,		0x07},
+	{CS35L35_BST_RAMP_CTL,		0x85},
+	{CS35L35_BST_CONV_COEF_1,	0x20},
+	{CS35L35_BST_CONV_COEF_2,	0x20},
+	{CS35L35_BST_CONV_SLOPE_COMP,	0x47},
+	{CS35L35_BST_CONV_SW_FREQ,	0x04},
+	{CS35L35_CLASS_H_CTL,		0x0B},
+	{CS35L35_CLASS_H_HEADRM_CTL,	0x0B},
+	{CS35L35_CLASS_H_RELEASE_RATE,	0x08},
+	{CS35L35_CLASS_H_FET_DRIVE_CTL, 0x41},
+	{CS35L35_CLASS_H_VP_CTL,	0xC5},
+	{CS35L35_VPBR_CTL,		0x0A},
+	{CS35L35_VPBR_VOL_CTL,		0x09},
+	{CS35L35_VPBR_TIMING_CTL,	0x6A},
+	{CS35L35_VPBR_MODE_VOL_CTL,	0x00},
+	{CS35L35_SPKR_MON_CTL,		0xC0},
+	{CS35L35_IMON_SCALE_CTL,	0x30},
+	{CS35L35_AUDIN_RXLOC_CTL,	0x00},
+	{CS35L35_ADVIN_RXLOC_CTL,	0x80},
+	{CS35L35_VMON_TXLOC_CTL,	0x00},
+	{CS35L35_IMON_TXLOC_CTL,	0x80},
+	{CS35L35_VPMON_TXLOC_CTL,	0x04},
+	{CS35L35_VBSTMON_TXLOC_CTL,	0x84},
+	{CS35L35_VPBR_STATUS_TXLOC_CTL,	0x04},
+	{CS35L35_ZERO_FILL_LOC_CTL,	0x00},
+	{CS35L35_AUDIN_DEPTH_CTL,	0x0F},
+	{CS35L35_SPKMON_DEPTH_CTL,	0x0F},
+	{CS35L35_SUPMON_DEPTH_CTL,	0x0F},
+	{CS35L35_ZEROFILL_DEPTH_CTL,	0x00},
+	{CS35L35_MULT_DEV_SYNCH1,	0x02},
+	{CS35L35_MULT_DEV_SYNCH2,	0x80},
+	{CS35L35_PROT_RELEASE_CTL,	0x00},
+	{CS35L35_DIAG_MODE_REG_LOCK,	0x00},
+	{CS35L35_DIAG_MODE_CTL_1,	0x40},
+	{CS35L35_DIAG_MODE_CTL_2,	0x00},
+	{CS35L35_INT_MASK_1,		0xFF},
+	{CS35L35_INT_MASK_2,		0xFF},
+	{CS35L35_INT_MASK_3,		0xFF},
+	{CS35L35_INT_MASK_4,		0xFF},
+
+};
+
+static bool cs35l35_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L35_DEVID_AB ... CS35L35_REV_ID:
+	case CS35L35_INT_STATUS_1:
+	case CS35L35_INT_STATUS_2:
+	case CS35L35_INT_STATUS_3:
+	case CS35L35_INT_STATUS_4:
+	case CS35L35_PLL_STATUS:
+	case CS35L35_OTP_TRIM_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs35l35_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L35_DEVID_AB ... CS35L35_PWRCTL3:
+	case CS35L35_CLK_CTL1 ... CS35L35_SP_FMT_CTL3:
+	case CS35L35_MAG_COMP_CTL ... CS35L35_AMP_GAIN_AUD_CTL:
+	case CS35L35_AMP_GAIN_PDM_CTL ... CS35L35_BST_PEAK_I:
+	case CS35L35_BST_RAMP_CTL ... CS35L35_BST_CONV_SW_FREQ:
+	case CS35L35_CLASS_H_CTL ... CS35L35_CLASS_H_VP_CTL:
+	case CS35L35_CLASS_H_STATUS:
+	case CS35L35_VPBR_CTL ... CS35L35_VPBR_MODE_VOL_CTL:
+	case CS35L35_VPBR_ATTEN_STATUS:
+	case CS35L35_SPKR_MON_CTL:
+	case CS35L35_IMON_SCALE_CTL ... CS35L35_ZEROFILL_DEPTH_CTL:
+	case CS35L35_MULT_DEV_SYNCH1 ... CS35L35_PROT_RELEASE_CTL:
+	case CS35L35_DIAG_MODE_REG_LOCK ... CS35L35_DIAG_MODE_CTL_2:
+	case CS35L35_INT_MASK_1 ... CS35L35_PLL_STATUS:
+	case CS35L35_OTP_TRIM_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs35l35_precious_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L35_INT_STATUS_1:
+	case CS35L35_INT_STATUS_2:
+	case CS35L35_INT_STATUS_3:
+	case CS35L35_INT_STATUS_4:
+	case CS35L35_PLL_STATUS:
+	case CS35L35_OTP_TRIM_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
+			CS35L35_MCLK_DIS_MASK, 0 << CS35L35_MCLK_DIS_SHIFT);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
+			CS35L35_DISCHG_FILT_MASK, 0 << CS35L35_DISCHG_FILT_SHIFT);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
+			CS35L35_PDN_ALL_MASK, 0);
+	break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
+			CS35L35_PDN_ALL_MASK, 1);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
+			CS35L35_DISCHG_FILT_MASK, 1 << CS35L35_DISCHG_FILT_SHIFT);
+
+		ret = wait_for_completion_timeout(&cs35l35->pdn_done,
+							msecs_to_jiffies(100));
+		if (ret == 0) {
+			pr_err("TIMEOUT PDN_DONE did not complete in 100ms\n");
+			ret = -ETIMEDOUT;
+		}
+
+		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
+			CS35L35_MCLK_DIS_MASK, 1 << CS35L35_MCLK_DIS_SHIFT);
+	break;
+	default:
+		pr_err("Invalid event = 0x%x\n", event);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int cs35l35_main_amp_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg[4];
+	int i;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (cs35l35->pdata.bst_pdn_fet_on)
+			regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+				CS35L35_PDN_BST_MASK, 0 << CS35L35_PDN_BST_FETON_SHIFT);
+		else
+			regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+				CS35L35_PDN_BST_MASK, 0 << CS35L35_PDN_BST_FETOFF_SHIFT);
+			regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
+				CS35L35_AMP_MUTE_MASK, 0 << CS35L35_AMP_MUTE_SHIFT);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(5000, 5100);
+		/* If PDM mode we must use VP
+		 * for Voltage control
+		 */
+		if (cs35l35->pdm_mode)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_BST_CVTR_V_CTL, CS35L35_BST_CTL_MASK,
+				0 << CS35L35_BST_CTL_SHIFT);
+		for (i = 0; i < 2; i++)
+			regmap_bulk_read(cs35l35->regmap, CS35L35_INT_STATUS_1,
+				&reg, ARRAY_SIZE(reg));
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
+			CS35L35_AMP_MUTE_MASK, 1 << CS35L35_AMP_MUTE_SHIFT);
+		if (cs35l35->pdata.bst_pdn_fet_on)
+			regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+				CS35L35_PDN_BST_MASK, 1 << CS35L35_PDN_BST_FETON_SHIFT);
+		else
+			regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+				CS35L35_PDN_BST_MASK, 1 << CS35L35_PDN_BST_FETOFF_SHIFT);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		usleep_range(5000, 5100);
+		/* If PDM mode we should switch back to pdata value
+		 * for Voltage control when we go down
+		 */
+		if (cs35l35->pdm_mode)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_BST_CVTR_V_CTL, CS35L35_BST_CTL_MASK,
+				cs35l35->pdata.bst_vctl << CS35L35_BST_CTL_SHIFT);
+
+		break;
+	default:
+		pr_err("Invalid event = 0x%x\n", event);
+	}
+	return 0;
+}
+
+static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 0, 1, 1);
+static DECLARE_TLV_DB_SCALE(dig_vol_tlv, -10200, 50, 0);
+
+static const struct snd_kcontrol_new cs35l35_aud_controls[] = {
+	SOC_SINGLE_SX_TLV("Digital Audio Volume", CS35L35_AMP_DIG_VOL,
+		      0, 0x34, 0xE4, dig_vol_tlv),
+	SOC_SINGLE_TLV("AMP Audio Gain", CS35L35_AMP_GAIN_AUD_CTL, 0, 19, 0,
+			amp_gain_tlv),
+	SOC_SINGLE_TLV("AMP PDM Gain", CS35L35_AMP_GAIN_PDM_CTL, 0, 19, 0,
+			amp_gain_tlv),
+};
+
+static const struct snd_kcontrol_new cs35l35_adv_controls[] = {
+	SOC_SINGLE_SX_TLV("Digital Advisory Volume", CS35L35_ADV_DIG_VOL,
+		      0, 0x34, 0xE4, dig_vol_tlv),
+	SOC_SINGLE_TLV("AMP Advisory Gain", CS35L35_AMP_GAIN_ADV_CTL, 0, 19, 0,
+			amp_gain_tlv),
+};
+
+static const struct snd_soc_dapm_widget cs35l35_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN_E("SDIN", NULL, 0, CS35L35_PWRCTL3, 1, 1,
+				cs35l35_sdin_event, SND_SOC_DAPM_PRE_PMU |
+				SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_AIF_OUT("SDOUT", NULL, 0, CS35L35_PWRCTL3, 2, 1),
+
+	SND_SOC_DAPM_OUTPUT("SPK"),
+
+	SND_SOC_DAPM_INPUT("VP"),
+	SND_SOC_DAPM_INPUT("VBST"),
+	SND_SOC_DAPM_INPUT("ISENSE"),
+	SND_SOC_DAPM_INPUT("VSENSE"),
+
+	SND_SOC_DAPM_ADC("VMON ADC", NULL, CS35L35_PWRCTL2, 7, 1),
+	SND_SOC_DAPM_ADC("IMON ADC", NULL, CS35L35_PWRCTL2, 6, 1),
+	SND_SOC_DAPM_ADC("VPMON ADC", NULL, CS35L35_PWRCTL3, 3, 1),
+	SND_SOC_DAPM_ADC("VBSTMON ADC", NULL, CS35L35_PWRCTL3, 4, 1),
+	SND_SOC_DAPM_ADC("CLASS H", NULL, CS35L35_PWRCTL2, 5, 1),
+
+	SND_SOC_DAPM_OUT_DRV_E("Main AMP", CS35L35_PWRCTL2, 0, 1, NULL, 0,
+		cs35l35_main_amp_event, SND_SOC_DAPM_PRE_PMU |
+				SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_POST_PMU |
+				SND_SOC_DAPM_PRE_PMD),
+};
+
+static const struct snd_soc_dapm_route cs35l35_audio_map[] = {
+	{"VPMON ADC", NULL, "VP"},
+	{"VBSTMON ADC", NULL, "VBST"},
+	{"IMON ADC", NULL, "ISENSE"},
+	{"VMON ADC", NULL, "VSENSE"},
+	{"SDOUT", NULL, "IMON ADC"},
+	{"SDOUT", NULL, "VMON ADC"},
+	{"SDOUT", NULL, "VBSTMON ADC"},
+	{"SDOUT", NULL, "VPMON ADC"},
+	{"AMP Capture", NULL, "SDOUT"},
+
+	{"SDIN", NULL, "AMP Playback"},
+	{"CLASS H", NULL, "SDIN"},
+	{"Main AMP", NULL, "CLASS H"},
+	{"SPK", NULL, "Main AMP"},
+};
+
+static int cs35l35_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
+				    CS35L35_MS_MASK, 1 << CS35L35_MS_SHIFT);
+		cs35l35->slave_mode = false;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
+				    CS35L35_MS_MASK, 0 << CS35L35_MS_SHIFT);
+		cs35l35->slave_mode = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cs35l35->i2s_mode = true;
+		cs35l35->pdm_mode = false;
+		break;
+	case SND_SOC_DAIFMT_PDM:
+		cs35l35->pdm_mode = true;
+		cs35l35->i2s_mode = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct cs35l35_sysclk_config {
+	int sysclk;
+	int srate;
+	u8 clk_cfg;
+};
+
+static struct cs35l35_sysclk_config cs35l35_clk_ctl[] = {
+
+	/* SYSCLK, Sample Rate, Serial Port Cfg */
+	{5644800, 44100, 0x00},
+	{5644800, 88200, 0x40},
+	{6144000, 48000, 0x10},
+	{6144000, 96000, 0x50},
+	{11289600, 44100, 0x01},
+	{11289600, 88200, 0x41},
+	{11289600, 176400, 0x81},
+	{12000000, 44100, 0x03},
+	{12000000, 48000, 0x13},
+	{12000000, 88200, 0x43},
+	{12000000, 96000, 0x53},
+	{12000000, 176400, 0x83},
+	{12000000, 192000, 0x93},
+	{12288000, 48000, 0x11},
+	{12288000, 96000, 0x51},
+	{12288000, 192000, 0x91},
+	{13000000, 44100, 0x07},
+	{13000000, 48000, 0x17},
+	{13000000, 88200, 0x47},
+	{13000000, 96000, 0x57},
+	{13000000, 176400, 0x87},
+	{13000000, 192000, 0x97},
+	{22579200, 44100, 0x02},
+	{22579200, 88200, 0x42},
+	{22579200, 176400, 0x82},
+	{24000000, 44100, 0x0B},
+	{24000000, 48000, 0x1B},
+	{24000000, 88200, 0x4B},
+	{24000000, 96000, 0x5B},
+	{24000000, 176400, 0x8B},
+	{24000000, 192000, 0x9B},
+	{24576000, 48000, 0x12},
+	{24576000, 96000, 0x52},
+	{24576000, 192000, 0x92},
+	{26000000, 44100, 0x0F},
+	{26000000, 48000, 0x1F},
+	{26000000, 88200, 0x4F},
+	{26000000, 96000, 0x5F},
+	{26000000, 176400, 0x8F},
+	{26000000, 192000, 0x9F},
+};
+
+static int cs35l35_get_clk_config(int sysclk, int srate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l35_clk_ctl); i++) {
+		if (cs35l35_clk_ctl[i].sysclk == sysclk &&
+			cs35l35_clk_ctl[i].srate == srate)
+			return cs35l35_clk_ctl[i].clk_cfg;
+	}
+	return -EINVAL;
+}
+
+static int cs35l35_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+	struct classh_cfg *classh = &cs35l35->pdata.classh_algo;
+	int srate = params_rate(params);
+	int ret = 0;
+	u8 sp_sclks;
+	int audin_format;
+	int errata_chk;
+
+	int clk_ctl = cs35l35_get_clk_config(cs35l35->sysclk, srate);
+
+	if (clk_ctl < 0) {
+		dev_err(codec->dev, "Invalid CLK:Rate %d:%d\n",
+			cs35l35->sysclk, srate);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL2,
+			  CS35L35_CLK_CTL2_MASK, clk_ctl);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set port config %d\n", ret);
+		return ret;
+	}
+
+	/* Rev A0 Errata
+	 *
+	 * When configured for the weak-drive detection path (CH_WKFET_DIS = 0)
+	 * the Class H algorithm does not enable weak-drive operation for
+	 * nonzero values of CH_WKFET_DELAY if SP_RATE = 01 or 10
+	 *
+	 */
+	errata_chk = clk_ctl & CS35L35_SP_RATE_MASK;
+
+	if (classh->classh_wk_fet_disable == 0x00 &&
+		(errata_chk == 0x01 || errata_chk == 0x03)) {
+		ret = regmap_update_bits(cs35l35->regmap,
+			CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_DEL_MASK,
+			0 << CS35L35_CH_WKFET_DEL_SHIFT);
+		if (ret != 0) {
+			dev_err(codec->dev, "Failed to set fet config %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+/*
+ * You can pull more Monitor data from the SDOUT pin than going to SDIN
+ * Just make sure your SCLK is fast enough to fill the frame
+ */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (params_width(params)) {
+		case 8:
+			audin_format = CS35L35_SDIN_DEPTH_8;
+			break;
+		case 16:
+			audin_format = CS35L35_SDIN_DEPTH_16;
+			break;
+		case 24:
+			audin_format = CS35L35_SDIN_DEPTH_24;
+			break;
+		default:
+			dev_err(codec->dev, "Unsupported Width %d\n",
+				params_width(params));
+		}
+		regmap_update_bits(cs35l35->regmap,
+			CS35L35_AUDIN_DEPTH_CTL, CS35L35_AUDIN_DEPTH_MASK,
+			audin_format << CS35L35_AUDIN_DEPTH_SHIFT);
+		if (cs35l35->pdata.stereo) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_AUDIN_DEPTH_CTL, CS35L35_ADVIN_DEPTH_MASK,
+				audin_format << CS35L35_ADVIN_DEPTH_SHIFT);
+		}
+	}
+/* We have to take the SCLK to derive num sclks
+ * to configure the CLOCK_CTL3 register correctly
+ */
+	if ((cs35l35->sclk / srate) % 4) {
+		dev_err(codec->dev, "Unsupported sclk/fs ratio %d:%d\n",
+					cs35l35->sclk, srate);
+		return -EINVAL;
+	}
+	sp_sclks = ((cs35l35->sclk / srate) / 4) - 1;
+
+	if (cs35l35->i2s_mode) {
+		/* Only certain ratios are supported in I2S Slave Mode */
+		if (cs35l35->slave_mode) {
+			switch (sp_sclks) {
+			case CS35L35_SP_SCLKS_32FS:
+			case CS35L35_SP_SCLKS_48FS:
+			case CS35L35_SP_SCLKS_64FS:
+			break;
+			default:
+				dev_err(codec->dev, "ratio not supported\n");
+				return -EINVAL;
+			};
+		} else {
+			/* Only certain ratios supported in I2S MASTER Mode */
+			switch (sp_sclks) {
+			case CS35L35_SP_SCLKS_32FS:
+			case CS35L35_SP_SCLKS_64FS:
+			break;
+			default:
+				dev_err(codec->dev, "ratio not supported\n");
+				return -EINVAL;
+			};
+		}
+		ret = regmap_update_bits(cs35l35->regmap,
+			CS35L35_CLK_CTL3, CS35L35_SP_SCLKS_MASK,
+			sp_sclks << CS35L35_SP_SCLKS_SHIFT);
+		if (ret != 0) {
+			dev_err(codec->dev, "Failed to set fsclk %d\n", ret);
+			return ret;
+		}
+	}
+	if (cs35l35->pdm_mode) {
+		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
+			CS35L35_PDM_MODE_MASK, 1 << CS35L35_PDM_MODE_SHIFT);
+	} else {
+		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
+			CS35L35_PDM_MODE_MASK, 0 << CS35L35_PDM_MODE_SHIFT);
+	}
+	return ret;
+}
+
+static const unsigned int cs35l35_src_rates[] = {
+	44100, 48000, 88200, 96000, 176400, 192000
+};
+
+static const struct snd_pcm_hw_constraint_list cs35l35_constraints = {
+	.count  = ARRAY_SIZE(cs35l35_src_rates),
+	.list   = cs35l35_src_rates,
+};
+
+static int cs35l35_pcm_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &cs35l35_constraints);
+	return 0;
+}
+
+static const unsigned int cs35l35_pdm_rates[] = {
+	44100, 48000, 88200, 96000
+};
+
+static const struct snd_pcm_hw_constraint_list cs35l35_pdm_constraints = {
+	.count  = ARRAY_SIZE(cs35l35_pdm_rates),
+	.list   = cs35l35_pdm_rates,
+};
+
+static int cs35l35_pdm_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				&cs35l35_pdm_constraints);
+	return 0;
+}
+
+static int cs35l35_dai_set_sysclk(struct snd_soc_dai *dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+
+	/* Need the SCLK Frequency */
+	cs35l35->sclk = freq;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs35l35_ops = {
+	.startup = cs35l35_pcm_startup,
+	.set_fmt = cs35l35_set_dai_fmt,
+	.hw_params = cs35l35_pcm_hw_params,
+	.set_sysclk = cs35l35_dai_set_sysclk,
+};
+
+static const struct snd_soc_dai_ops cs35l35_pdm_ops = {
+	.startup = cs35l35_pdm_startup,
+	.set_fmt = cs35l35_set_dai_fmt,
+	.hw_params = cs35l35_pcm_hw_params,
+	.set_sysclk = cs35l35_dai_set_sysclk,
+};
+
+static struct snd_soc_dai_driver cs35l35_dai[] = {
+	{
+		.name = "cs35l35-pcm",
+		.id = 0,
+		.playback = {
+			.stream_name = "AMP Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS35L35_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AMP Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS35L35_FORMATS,
+		},
+		.ops = &cs35l35_ops,
+		.symmetric_rates = 1,
+	},
+	{
+		.name = "cs35l35-pdm",
+		.id = 1,
+		.playback = {
+			.stream_name = "PDM Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS35L35_FORMATS,
+		},
+		.ops = &cs35l35_pdm_ops,
+	},
+};
+
+static int cs35l35_codec_set_sysclk(struct snd_soc_codec *codec,
+				int clk_id, int source, unsigned int freq,
+				int dir)
+{
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+	int clksrc;
+	int ret = 0;
+
+	switch (clk_id) {
+	case 0:
+		clksrc = CS35L35_CLK_SOURCE_MCLK;
+		break;
+	case 1:
+		clksrc = CS35L35_CLK_SOURCE_SCLK;
+		break;
+	case 2:
+		clksrc = CS35L35_CLK_SOURCE_PDM;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid CLK Source\n");
+		return -EINVAL;
+	};
+
+	switch (freq) {
+	case 5644800:
+	case 6144000:
+	case 11289600:
+	case 12000000:
+	case 12288000:
+	case 13000000:
+	case 22579200:
+	case 24000000:
+	case 24576000:
+	case 26000000:
+		cs35l35->sysclk = freq;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid CLK Frequency\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
+		CS35L35_CLK_SOURCE_MASK, clksrc << CS35L35_CLK_SOURCE_SHIFT);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set sysclk %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int cs35l35_codec_probe(struct snd_soc_codec *codec)
+{
+	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
+	struct classh_cfg *classh = &cs35l35->pdata.classh_algo;
+	struct monitor_cfg *monitor_config = &cs35l35->pdata.mon_cfg;
+	int ret;
+
+	/* Set Platform Data */
+	if (cs35l35->pdata.bst_vctl)
+		regmap_update_bits(cs35l35->regmap, CS35L35_BST_CVTR_V_CTL,
+			CS35L35_BST_CTL_MASK, cs35l35->pdata.bst_vctl);
+
+	if (cs35l35->pdata.bst_ipk)
+		regmap_update_bits(cs35l35->regmap, CS35L35_BST_PEAK_I,
+			CS35L35_BST_IPK_MASK,
+			cs35l35->pdata.bst_ipk << CS35L35_BST_IPK_SHIFT);
+
+	if (cs35l35->pdata.gain_zc)
+		regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
+			CS35L35_AMP_GAIN_ZC_MASK,
+			cs35l35->pdata.gain_zc << CS35L35_AMP_GAIN_ZC_SHIFT);
+
+	if (cs35l35->pdata.aud_channel)
+		regmap_update_bits(cs35l35->regmap,
+			CS35L35_AUDIN_RXLOC_CTL,
+			CS35L35_AUD_IN_LR_MASK,
+			cs35l35->pdata.aud_channel << CS35L35_AUD_IN_LR_SHIFT);
+
+	if (cs35l35->pdata.stereo) {
+		regmap_update_bits(cs35l35->regmap,
+			CS35L35_ADVIN_RXLOC_CTL, CS35L35_ADV_IN_LR_MASK,
+			cs35l35->pdata.adv_channel << CS35L35_ADV_IN_LR_SHIFT);
+		if (cs35l35->pdata.shared_bst)
+			regmap_update_bits(cs35l35->regmap, CS35L35_CLASS_H_CTL,
+				CS35L35_CH_STEREO_MASK, 1 << CS35L35_CH_STEREO_SHIFT);
+		ret = snd_soc_add_codec_controls(codec, cs35l35_adv_controls,
+					ARRAY_SIZE(cs35l35_adv_controls));
+		if (ret)
+			return ret;
+	}
+
+	if (cs35l35->pdata.sp_drv_str)
+		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
+			CS35L35_SP_DRV_MASK,
+			cs35l35->pdata.sp_drv_str << CS35L35_SP_DRV_SHIFT);
+
+	if (classh->classh_algo_enable) {
+		if (classh->classh_bst_override)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_OVR_MASK,
+				classh->classh_bst_override << CS35L35_CH_BST_OVR_SHIFT);
+		if (classh->classh_bst_max_limit)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_LIM_MASK,
+				classh->classh_bst_max_limit << CS35L35_CH_BST_LIM_SHIFT);
+		if (classh->classh_mem_depth)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_CTL, CS35L35_CH_MEM_DEPTH_MASK,
+				classh->classh_mem_depth << CS35L35_CH_MEM_DEPTH_SHIFT);
+		if (classh->classh_headroom)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_HEADRM_CTL, CS35L35_CH_HDRM_CTL_MASK,
+				classh->classh_headroom << CS35L35_CH_HDRM_CTL_SHIFT);
+		if (classh->classh_release_rate)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_RELEASE_RATE, CS35L35_CH_REL_RATE_MASK,
+				classh->classh_release_rate << CS35L35_CH_REL_RATE_SHIFT);
+		if (classh->classh_wk_fet_disable)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_DIS_MASK,
+				classh->classh_wk_fet_disable << CS35L35_CH_WKFET_DIS_SHIFT);
+		if (classh->classh_wk_fet_delay)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_DEL_MASK,
+				classh->classh_wk_fet_delay << CS35L35_CH_WKFET_DEL_SHIFT);
+		if (classh->classh_wk_fet_thld)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_THLD_MASK,
+				classh->classh_wk_fet_thld << CS35L35_CH_WKFET_THLD_SHIFT);
+		if (classh->classh_vpch_auto)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_VP_CTL, CS35L35_CH_VP_AUTO_MASK,
+				classh->classh_vpch_auto << CS35L35_CH_VP_AUTO_SHIFT);
+		if (classh->classh_vpch_rate)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_VP_CTL, CS35L35_CH_VP_RATE_MASK,
+				classh->classh_vpch_rate << CS35L35_CH_VP_RATE_SHIFT);
+		if (classh->classh_vpch_man)
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_CLASS_H_VP_CTL, CS35L35_CH_VP_MAN_MASK,
+				classh->classh_vpch_man << CS35L35_CH_VP_MAN_SHIFT);
+	}
+
+	if (monitor_config->is_present) {
+		if (monitor_config->vmon_specs) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_SPKMON_DEPTH_CTL, CS35L35_VMON_DEPTH_MASK,
+				monitor_config->vmon_dpth << CS35L35_VMON_DEPTH_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VMON_TXLOC_CTL, CS35L35_MON_TXLOC_MASK,
+				monitor_config->vmon_loc << CS35L35_MON_TXLOC_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VMON_TXLOC_CTL, CS35L35_MON_FRM_MASK,
+				monitor_config->vmon_frm << CS35L35_MON_FRM_SHIFT);
+		}
+		if (monitor_config->imon_specs) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_SPKMON_DEPTH_CTL, CS35L35_IMON_DEPTH_MASK,
+				monitor_config->imon_dpth << CS35L35_IMON_DEPTH_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_IMON_TXLOC_CTL, CS35L35_MON_TXLOC_MASK,
+				monitor_config->imon_loc << CS35L35_MON_TXLOC_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_IMON_TXLOC_CTL, CS35L35_MON_FRM_MASK,
+				monitor_config->imon_frm << CS35L35_MON_FRM_SHIFT);
+		}
+		if (monitor_config->vpmon_specs) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_SUPMON_DEPTH_CTL, CS35L35_VPMON_DEPTH_MASK,
+				monitor_config->vpmon_dpth << CS35L35_VPMON_DEPTH_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VPMON_TXLOC_CTL, CS35L35_MON_TXLOC_MASK,
+				monitor_config->vpmon_loc << CS35L35_MON_TXLOC_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VPMON_TXLOC_CTL, CS35L35_MON_FRM_MASK,
+				monitor_config->vpmon_frm << CS35L35_MON_FRM_SHIFT);
+		}
+		if (monitor_config->vbstmon_specs) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_SUPMON_DEPTH_CTL, CS35L35_VBSTMON_DEPTH_MASK,
+				monitor_config->vpmon_dpth << CS35L35_VBSTMON_DEPTH_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VBSTMON_TXLOC_CTL, CS35L35_MON_TXLOC_MASK,
+				monitor_config->vbstmon_loc << CS35L35_MON_TXLOC_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VBSTMON_TXLOC_CTL, CS35L35_MON_FRM_MASK,
+				monitor_config->vbstmon_frm << CS35L35_MON_FRM_SHIFT);
+		}
+		if (monitor_config->vpbrstat_specs) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_SUPMON_DEPTH_CTL, CS35L35_VPBRSTAT_DEPTH_MASK,
+				monitor_config->vpbrstat_dpth << CS35L35_VPBRSTAT_DEPTH_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VPBR_STATUS_TXLOC_CTL, CS35L35_MON_TXLOC_MASK,
+				monitor_config->vpbrstat_loc << CS35L35_MON_TXLOC_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_VPBR_STATUS_TXLOC_CTL, CS35L35_MON_FRM_MASK,
+				monitor_config->vpbrstat_frm << CS35L35_MON_FRM_SHIFT);
+		}
+		if (monitor_config->zerofill_specs) {
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_SUPMON_DEPTH_CTL, CS35L35_ZEROFILL_DEPTH_MASK,
+				monitor_config->zerofill_dpth << CS35L35_ZEROFILL_DEPTH_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_ZERO_FILL_LOC_CTL, CS35L35_MON_TXLOC_MASK,
+				monitor_config->zerofill_loc << CS35L35_MON_TXLOC_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_ZERO_FILL_LOC_CTL, CS35L35_MON_FRM_MASK,
+				monitor_config->zerofill_frm << CS35L35_MON_FRM_SHIFT);
+		}
+	}
+
+	return ret;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_cs35l35 = {
+	.probe = cs35l35_codec_probe,
+	.set_sysclk = cs35l35_codec_set_sysclk,
+	.component_driver = {
+		.controls = cs35l35_aud_controls,
+		.num_controls = ARRAY_SIZE(cs35l35_aud_controls),
+		.dapm_widgets = cs35l35_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(cs35l35_dapm_widgets),
+
+		.dapm_routes = cs35l35_audio_map,
+		.num_dapm_routes = ARRAY_SIZE(cs35l35_audio_map),
+	},
+};
+
+static struct regmap_config cs35l35_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = CS35L35_MAX_REGISTER,
+	.reg_defaults = cs35l35_reg,
+	.num_reg_defaults = ARRAY_SIZE(cs35l35_reg),
+	.volatile_reg = cs35l35_volatile_register,
+	.readable_reg = cs35l35_readable_register,
+	.precious_reg = cs35l35_precious_register,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static irqreturn_t cs35l35_irq(int irq, void *data)
+{
+	struct cs35l35_private *cs35l35 = data;
+	unsigned int sticky1, sticky2, sticky3, sticky4;
+	unsigned int mask1, mask2, mask3, mask4, current1;
+
+	/* ack the irq by reading all status registers */
+	regmap_read(cs35l35->regmap, CS35L35_INT_STATUS_4, &sticky4);
+	regmap_read(cs35l35->regmap, CS35L35_INT_STATUS_3, &sticky3);
+	regmap_read(cs35l35->regmap, CS35L35_INT_STATUS_2, &sticky2);
+	regmap_read(cs35l35->regmap, CS35L35_INT_STATUS_1, &sticky1);
+
+	regmap_read(cs35l35->regmap, CS35L35_INT_MASK_4, &mask4);
+	regmap_read(cs35l35->regmap, CS35L35_INT_MASK_3, &mask3);
+	regmap_read(cs35l35->regmap, CS35L35_INT_MASK_2, &mask2);
+	regmap_read(cs35l35->regmap, CS35L35_INT_MASK_1, &mask1);
+
+	/* Check to see if unmasked bits are active */
+	if (!(sticky1 & ~mask1) && !(sticky2 & ~mask2) && !(sticky3 & ~mask3)
+			&& !(sticky4 & ~mask4))
+		return IRQ_NONE;
+
+	if (sticky2 & CS35L35_PDN_DONE)
+		complete(&cs35l35->pdn_done);
+
+	/* read the current values */
+	regmap_read(cs35l35->regmap, CS35L35_INT_STATUS_1, &current1);
+
+	/* handle the interrupts */
+	if (sticky1 & CS35L35_CAL_ERR) {
+		pr_err("%s : Calibration Error\n", __func__);
+
+		/* error is no longer asserted; safe to reset */
+		if (!(current1 & CS35L35_CAL_ERR)) {
+			pr_debug("%s : Cal error release\n", __func__);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_CAL_ERR_RLS, 0);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_CAL_ERR_RLS,
+				CS35L35_CAL_ERR_RLS);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_CAL_ERR_RLS, 0);
+		}
+	}
+
+	if (sticky1 & CS35L35_AMP_SHORT) {
+		/* error is no longer asserted; safe to reset */
+		if (!(current1 & CS35L35_AMP_SHORT)) {
+			pr_debug("%s :Amp short error release\n", __func__);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_SHORT_RLS, 0);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_SHORT_RLS,
+				CS35L35_SHORT_RLS);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_SHORT_RLS, 0);
+		}
+	}
+
+	if (sticky1 & CS35L35_OTW) {
+		pr_err("%s : Over temperature warning\n", __func__);
+
+		/* error is no longer asserted; safe to reset */
+		if (!(current1 & CS35L35_OTW)) {
+			pr_debug("%s : Over temperature warning release\n",
+				__func__);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_OTW_RLS, 0);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_OTW_RLS,
+				CS35L35_OTW_RLS);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_OTW_RLS, 0);
+		}
+	}
+
+	if (sticky1 & CS35L35_OTE) {
+		pr_crit("%s : Over temperature error\n", __func__);
+
+		/* error is no longer asserted; safe to reset */
+		if (!(current1 & CS35L35_OTE)) {
+			pr_debug("%s : Over temperature error release\n",
+				__func__);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_OTE_RLS, 0);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_OTE_RLS,
+				CS35L35_OTE_RLS);
+			regmap_update_bits(cs35l35->regmap,
+				CS35L35_PROT_RELEASE_CTL, CS35L35_OTE_RLS, 0);
+		}
+	}
+
+	if (sticky3 & CS35L35_BST_HIGH) {
+		pr_crit("%s : VBST error: powering off!\n", __func__);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+			CS35L35_PDN_AMP, CS35L35_PDN_AMP);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
+			CS35L35_PDN_ALL, CS35L35_PDN_ALL);
+	}
+
+	if (sticky3 & CS35L35_LBST_SHORT) {
+		pr_crit("%s : LBST error: powering off!\n", __func__);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+			CS35L35_PDN_AMP, CS35L35_PDN_AMP);
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
+			CS35L35_PDN_ALL, CS35L35_PDN_ALL);
+	}
+
+	if (sticky2 & CS35L35_VPBR_ERR)
+		pr_err("%s : Error: Reactive Brownout\n", __func__);
+
+	if (sticky4 & CS35L35_VMON_OVFL)
+		pr_err("%s : Error: VMON overflow\n", __func__);
+
+	if (sticky4 & CS35L35_IMON_OVFL)
+		pr_err("%s : Error: IMON overflow\n", __func__);
+
+	return IRQ_HANDLED;
+}
+
+
+static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
+				struct cs35l35_platform_data *pdata)
+{
+	struct device_node *np = i2c_client->dev.of_node;
+	struct device_node *classh, *signal_format;
+	struct classh_cfg *classh_config = &pdata->classh_algo;
+	struct monitor_cfg *monitor_config = &pdata->mon_cfg;
+	unsigned int val32 = 0;
+	u8 monitor_array[3];
+	int ret = 0;
+
+	if (!np)
+		return 0;
+
+	pdata->bst_pdn_fet_on = of_property_read_bool(np,
+					"cirrus,boost-pdn-fet-on");
+
+	if (of_property_read_u32(np, "cirrus,boost-ctl-millivolt", &val32) >= 0)
+		pdata->bst_vctl = val32;
+
+	if (of_property_read_u32(np, "cirrus,boost-ipk-milliamp", &val32) >= 0)
+		pdata->bst_ipk = val32;
+
+	if (of_property_read_u32(np, "cirrus,sp-drv-strength", &val32) >= 0)
+		pdata->sp_drv_str = val32;
+
+	pdata->stereo = of_property_read_bool(np, "cirrus,stereo-config");
+
+	if (pdata->stereo) {
+		if (of_property_read_u32(np, "cirrus,audio-channel", &val32) >= 0)
+			pdata->aud_channel = val32;
+		if (of_property_read_u32(np, "cirrus,advisory-channel",
+					&val32) >= 0)
+			pdata->adv_channel = val32;
+		pdata->shared_bst = of_property_read_bool(np,
+						"cirrus,shared-boost");
+	}
+
+	pdata->gain_zc = of_property_read_bool(np, "cirrus,amp-gain-zc");
+
+	classh = of_get_child_by_name(np, "cirrus,classh-internal-algo");
+	classh_config->classh_algo_enable = classh ? true : false;
+
+	if (classh_config->classh_algo_enable) {
+		classh_config->classh_bst_override =
+			of_property_read_bool(np, "cirrus,classh-bst-overide");
+
+		if (of_property_read_u32(classh, "cirrus,classh-bst-max-limit",
+					&val32) >= 0)
+			classh_config->classh_bst_max_limit = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-mem-depth",
+					&val32) >= 0)
+			classh_config->classh_mem_depth = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-release-rate",
+					&val32) >= 0)
+			classh_config->classh_release_rate = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-headroom",
+					&val32) >= 0)
+			classh_config->classh_headroom = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-wk-fet-disable",
+					&val32) >= 0)
+			classh_config->classh_wk_fet_disable = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-wk-fet-delay",
+					&val32) >= 0)
+			classh_config->classh_wk_fet_delay = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-wk-fet-thld",
+					&val32) >= 0)
+			classh_config->classh_wk_fet_thld = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-vpch-auto",
+					&val32) >= 0)
+			classh_config->classh_vpch_auto = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-vpch-rate",
+					&val32) >= 0)
+			classh_config->classh_vpch_rate = val32;
+		if (of_property_read_u32(classh, "cirrus,classh-vpch-man",
+					&val32) >= 0)
+			classh_config->classh_vpch_man = val32;
+	}
+	of_node_put(classh);
+
+	/* frame depth location */
+	signal_format = of_get_child_by_name(np, "cirrus,monitor-signal-format");
+	monitor_config->is_present = signal_format ? true : false;
+	if (monitor_config->is_present) {
+		ret = of_property_read_u8_array(signal_format, "cirrus,imon",
+				   monitor_array, ARRAY_SIZE(monitor_array));
+		if (!ret) {
+			monitor_config->imon_specs = true;
+			monitor_config->imon_dpth = monitor_array[0];
+			monitor_config->imon_loc = monitor_array[1];
+			monitor_config->imon_frm = monitor_array[2];
+		}
+		ret = of_property_read_u8_array(signal_format, "cirrus,vmon",
+				   monitor_array, ARRAY_SIZE(monitor_array));
+		if (!ret) {
+			monitor_config->vmon_specs = true;
+			monitor_config->vmon_dpth = monitor_array[0];
+			monitor_config->vmon_loc = monitor_array[1];
+			monitor_config->vmon_frm = monitor_array[2];
+		}
+		ret = of_property_read_u8_array(signal_format, "cirrus,vpmon",
+				   monitor_array, ARRAY_SIZE(monitor_array));
+		if (!ret) {
+			monitor_config->vpmon_specs = true;
+			monitor_config->vpmon_dpth = monitor_array[0];
+			monitor_config->vpmon_loc = monitor_array[1];
+			monitor_config->vpmon_frm = monitor_array[2];
+		}
+		ret = of_property_read_u8_array(signal_format, "cirrus,vbstmon",
+				   monitor_array, ARRAY_SIZE(monitor_array));
+		if (!ret) {
+			monitor_config->vbstmon_specs = true;
+			monitor_config->vbstmon_dpth = monitor_array[0];
+			monitor_config->vbstmon_loc = monitor_array[1];
+			monitor_config->vbstmon_frm = monitor_array[2];
+		}
+		ret = of_property_read_u8_array(signal_format, "cirrus,vpbrstat",
+				   monitor_array, ARRAY_SIZE(monitor_array));
+		if (!ret) {
+			monitor_config->vpbrstat_specs = true;
+			monitor_config->vpbrstat_dpth = monitor_array[0];
+			monitor_config->vpbrstat_loc = monitor_array[1];
+			monitor_config->vpbrstat_frm = monitor_array[2];
+		}
+		ret = of_property_read_u8_array(signal_format, "cirrus,zerofill",
+				   monitor_array, ARRAY_SIZE(monitor_array));
+		if (!ret) {
+			monitor_config->zerofill_specs = true;
+			monitor_config->zerofill_dpth = monitor_array[0];
+			monitor_config->zerofill_loc = monitor_array[1];
+			monitor_config->zerofill_frm = monitor_array[2];
+		}
+	}
+	of_node_put(signal_format);
+
+	return 0;
+}
+
+/* Errata Rev A0 */
+static const struct reg_sequence cs35l35_errata_patch[] = {
+
+	{ 0x7F, 0x99 },
+	{ 0x00, 0x99 },
+	{ 0x52, 0x22 },
+	{ 0x04, 0x14 },
+	{ 0x6D, 0x44 },
+	{ 0x24, 0x10 },
+	{ 0x58, 0xC4 },
+	{ 0x00, 0x98 },
+	{ 0x18, 0x08 },
+	{ 0x00, 0x00 },
+	{ 0x7F, 0x00 },
+};
+
+static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
+			      const struct i2c_device_id *id)
+{
+	struct cs35l35_private *cs35l35;
+	struct cs35l35_platform_data *pdata =
+		dev_get_platdata(&i2c_client->dev);
+	int i;
+	int ret;
+	unsigned int devid = 0;
+	unsigned int reg;
+
+	cs35l35 = devm_kzalloc(&i2c_client->dev,
+			       sizeof(struct cs35l35_private),
+			       GFP_KERNEL);
+	if (!cs35l35) {
+		dev_err(&i2c_client->dev, "could not allocate codec\n");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(i2c_client, cs35l35);
+	cs35l35->regmap = devm_regmap_init_i2c(i2c_client, &cs35l35_regmap);
+	if (IS_ERR(cs35l35->regmap)) {
+		ret = PTR_ERR(cs35l35->regmap);
+		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cs35l35_supplies); i++)
+		cs35l35->supplies[i].supply = cs35l35_supplies[i];
+		cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
+
+	ret = devm_regulator_bulk_get(&i2c_client->dev,
+			cs35l35->num_supplies,
+			cs35l35->supplies);
+	if (ret != 0) {
+		dev_err(&i2c_client->dev,
+			"Failed to request core supplies: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (pdata) {
+		cs35l35->pdata = *pdata;
+	} else {
+		pdata = devm_kzalloc(&i2c_client->dev,
+				     sizeof(struct cs35l35_platform_data),
+				GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&i2c_client->dev,
+				"could not allocate pdata\n");
+			return -ENOMEM;
+		}
+		if (i2c_client->dev.of_node) {
+			ret = cs35l35_handle_of_data(i2c_client, pdata);
+			if (ret != 0)
+				return ret;
+
+		}
+		cs35l35->pdata = *pdata;
+	}
+
+	ret = regulator_bulk_enable(cs35l35->num_supplies,
+					cs35l35->supplies);
+	if (ret != 0) {
+		dev_err(&i2c_client->dev,
+			"Failed to enable core supplies: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* returning NULL can be an option if in stereo mode */
+	cs35l35->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
+		"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs35l35->reset_gpio))
+		return PTR_ERR(cs35l35->reset_gpio);
+
+	if (cs35l35->reset_gpio)
+		gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);
+
+	init_completion(&cs35l35->pdn_done);
+
+	ret = regmap_register_patch(cs35l35->regmap, cs35l35_errata_patch,
+				    ARRAY_SIZE(cs35l35_errata_patch));
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "Failed to apply errata patch\n");
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&i2c_client->dev, i2c_client->irq, NULL,
+			cs35l35_irq, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+			"cs35l35", cs35l35);
+	if (ret != 0) {
+		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
+		goto err;
+	}
+	/* initialize codec */
+	ret = regmap_read(cs35l35->regmap, CS35L35_DEVID_AB, &reg);
+
+	devid = (reg & 0xFF) << 12;
+	ret = regmap_read(cs35l35->regmap, CS35L35_DEVID_CD, &reg);
+	devid |= (reg & 0xFF) << 4;
+	ret = regmap_read(cs35l35->regmap, CS35L35_DEVID_E, &reg);
+	devid |= (reg & 0xF0) >> 4;
+
+	if (devid != CS35L35_CHIP_ID) {
+		dev_err(&i2c_client->dev,
+			"CS35L35 Device ID (%X). Expected ID %X\n",
+			devid, CS35L35_CHIP_ID);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = regmap_read(cs35l35->regmap, CS35L35_REV_ID, &reg);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
+		goto err;
+	}
+
+	dev_info(&i2c_client->dev,
+		 "Cirrus Logic CS35L35 (%x), Revision: %02X\n", devid,
+		ret & 0xFF);
+
+	/* Set the INT Masks for critical errors */
+	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_1, CS35L35_INT1_CRIT_MASK);
+	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_2, CS35L35_INT2_CRIT_MASK);
+	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_3, CS35L35_INT3_CRIT_MASK);
+	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_4, CS35L35_INT4_CRIT_MASK);
+
+	regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+		CS35L35_PWR2_PDN_MASK, CS35L35_PWR2_PDN_MASK);
+
+	if (cs35l35->pdata.bst_pdn_fet_on)
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+			CS35L35_PDN_BST_MASK, 1 << CS35L35_PDN_BST_FETON_SHIFT);
+	else
+		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
+			CS35L35_PDN_BST_MASK, 1 << CS35L35_PDN_BST_FETOFF_SHIFT);
+
+	regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL3,
+		CS35L35_PWR3_PDN_MASK, CS35L35_PWR3_PDN_MASK);
+
+	regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
+		CS35L35_AMP_MUTE_MASK, 1 << CS35L35_AMP_MUTE_SHIFT);
+
+	ret =  snd_soc_register_codec(&i2c_client->dev,
+			&soc_codec_dev_cs35l35, cs35l35_dai,
+			ARRAY_SIZE(cs35l35_dai));
+	if (ret < 0) {
+		dev_err(&i2c_client->dev,
+			"%s: Register codec failed\n", __func__);
+		goto err;
+	}
+
+err:
+	regulator_bulk_disable(cs35l35->num_supplies,
+			       cs35l35->supplies);
+	return ret;
+}
+
+static int cs35l35_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct of_device_id cs35l35_of_match[] = {
+	{.compatible = "cirrus,cs35l35"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs35l35_of_match);
+
+static const struct i2c_device_id cs35l35_id[] = {
+	{"cs35l35", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cs35l35_id);
+
+static struct i2c_driver cs35l35_i2c_driver = {
+	.driver = {
+		.name = "cs35l35",
+		.of_match_table = cs35l35_of_match,
+	},
+	.id_table = cs35l35_id,
+	.probe = cs35l35_i2c_probe,
+	.remove = cs35l35_i2c_remove,
+};
+
+module_i2c_driver(cs35l35_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS35L35 driver");
+MODULE_AUTHOR("Li Xu, Cirrus Logic Inc, <li.xu@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
new file mode 100644
index 0000000..fb02785
--- /dev/null
+++ b/sound/soc/codecs/cs35l35.h
@@ -0,0 +1,284 @@
+/*
+ * cs35l35.h -- CS35L35 ALSA SoC audio driver
+ *
+ * Copyright 2016 Cirrus Logic, Inc.
+ *
+ * Author: Li Xu <li.xu@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __CS35L35_H__
+#define __CS35L35_H__
+
+#define CS35L35_FIRSTREG		0x01
+#define CS35L35_LASTREG			0x7E
+#define CS35L35_CHIP_ID			0x00035A35
+#define CS35L35_DEVID_AB		0x01	/* Device ID A & B [RO] */
+#define CS35L35_DEVID_CD		0x02    /* Device ID C & D [RO] */
+#define CS35L35_DEVID_E			0x03    /* Device ID E [RO] */
+#define CS35L35_FAB_ID			0x04	/* Fab ID [RO] */
+#define CS35L35_REV_ID			0x05	/* Revision ID [RO] */
+#define CS35L35_PWRCTL1			0x06    /* Power Ctl 1 */
+#define CS35L35_PWRCTL2			0x07    /* Power Ctl 2 */
+#define CS35L35_PWRCTL3			0x08	/* Power Ctl 3 */
+#define CS35L35_CLK_CTL1		0x0A	/* Clocking Ctl 1 */
+#define CS35L35_CLK_CTL2		0x0B	/* Clocking Ctl 2 */
+#define CS35L35_CLK_CTL3		0x0C	/* Clocking Ctl 3 */
+#define CS35L35_SP_FMT_CTL1		0x0D	/* Serial Port Format CTL1 */
+#define CS35L35_SP_FMT_CTL2		0x0E	/* Serial Port Format CTL2 */
+#define CS35L35_SP_FMT_CTL3		0x0F	/* Serial Port Format CTL3 */
+#define CS35L35_MAG_COMP_CTL		0x13	/* Magnitude Comp CTL */
+#define CS35L35_AMP_INP_DRV_CTL		0x14	/* Amp Input Drive Ctl */
+#define CS35L35_AMP_DIG_VOL_CTL		0x15	/* Amplifier Dig Volume Ctl */
+#define CS35L35_AMP_DIG_VOL		0x16	/* Amplifier Dig Volume */
+#define CS35L35_ADV_DIG_VOL		0x17	/* Advisory Digital Volume */
+#define CS35L35_PROTECT_CTL		0x18	/* Amp Gain - Prot Ctl Param */
+#define CS35L35_AMP_GAIN_AUD_CTL	0x19	/* Amp Serial Port Gain Ctl */
+#define CS35L35_AMP_GAIN_PDM_CTL	0x1A	/* Amplifier Gain PDM Ctl */
+#define CS35L35_AMP_GAIN_ADV_CTL	0x1B	/* Amplifier Gain Ctl */
+#define CS35L35_GPI_CTL			0x1C	/* GPI Ctl */
+#define CS35L35_BST_CVTR_V_CTL		0x1D	/* Boost Conv Voltage Ctl */
+#define CS35L35_BST_PEAK_I		0x1E	/* Boost Conv Peak Current */
+#define CS35L35_BST_RAMP_CTL		0x20	/* Boost Conv Soft Ramp Ctl */
+#define CS35L35_BST_CONV_COEF_1		0x21	/* Boost Conv Coefficients 1 */
+#define CS35L35_BST_CONV_COEF_2		0x22	/* Boost Conv Coefficients 2 */
+#define CS35L35_BST_CONV_SLOPE_COMP	0x23	/* Boost Conv Slope Comp */
+#define CS35L35_BST_CONV_SW_FREQ	0x24	/* Boost Conv L BST SW Freq */
+#define CS35L35_CLASS_H_CTL		0x30	/* CLS H Control */
+#define CS35L35_CLASS_H_HEADRM_CTL	0x31	/* CLS H Headroom Ctl */
+#define CS35L35_CLASS_H_RELEASE_RATE	0x32	/* CLS H Release Rate */
+#define CS35L35_CLASS_H_FET_DRIVE_CTL	0x33	/* CLS H Weak FET Drive Ctl */
+#define CS35L35_CLASS_H_VP_CTL		0x34	/* CLS H VP Ctl */
+#define CS35L35_CLASS_H_STATUS		0x38	/* CLS H Status */
+#define CS35L35_VPBR_CTL		0x3A	/* VPBR Ctl */
+#define CS35L35_VPBR_VOL_CTL		0x3B	/* VPBR Volume Ctl */
+#define CS35L35_VPBR_TIMING_CTL		0x3C	/* VPBR Timing Ctl */
+#define CS35L35_VPBR_MODE_VOL_CTL	0x3D	/* VPBR Mode/Attack Vol Ctl */
+#define CS35L35_VPBR_ATTEN_STATUS	0x4B	/* VPBR Attenuation Status */
+#define CS35L35_SPKR_MON_CTL		0x4E	/* Speaker Monitoring Ctl */
+#define CS35L35_IMON_SCALE_CTL		0x51	/* IMON Scale Ctl */
+#define CS35L35_AUDIN_RXLOC_CTL		0x52	/* Audio Input RX Loc Ctl */
+#define CS35L35_ADVIN_RXLOC_CTL		0x53	/* Advisory Input RX Loc Ctl */
+#define CS35L35_VMON_TXLOC_CTL		0x54	/* VMON TX Loc Ctl */
+#define CS35L35_IMON_TXLOC_CTL		0x55	/* IMON TX Loc Ctl */
+#define CS35L35_VPMON_TXLOC_CTL		0x56	/* VPMON TX Loc Ctl */
+#define CS35L35_VBSTMON_TXLOC_CTL	0x57	/* VBSTMON TX Loc Ctl */
+#define CS35L35_VPBR_STATUS_TXLOC_CTL	0x58	/* VPBR Status TX Loc Ctl */
+#define CS35L35_ZERO_FILL_LOC_CTL	0x59	/* Zero Fill Loc Ctl */
+#define CS35L35_AUDIN_DEPTH_CTL		0x5A	/* Audio Input Depth Ctl */
+#define CS35L35_SPKMON_DEPTH_CTL	0x5B	/* SPK Mon Output Depth Ctl */
+#define CS35L35_SUPMON_DEPTH_CTL	0x5C	/* Supply Mon Out Depth Ctl */
+#define CS35L35_ZEROFILL_DEPTH_CTL	0x5D	/* Zero Fill Mon Output Ctl */
+#define CS35L35_MULT_DEV_SYNCH1		0x62	/* Multidevice Synch */
+#define CS35L35_MULT_DEV_SYNCH2		0x63	/* Multidevice Synch 2 */
+#define CS35L35_PROT_RELEASE_CTL	0x64	/* Protection Release Ctl */
+#define CS35L35_DIAG_MODE_REG_LOCK	0x68	/* Diagnostic Mode Reg Lock */
+#define CS35L35_DIAG_MODE_CTL_1		0x69	/* Diagnostic Mode Ctl 1 */
+#define CS35L35_DIAG_MODE_CTL_2		0x6A	/* Diagnostic Mode Ctl 2 */
+#define CS35L35_INT_MASK_1		0x70	/* Interrupt Mask 1 */
+#define CS35L35_INT_MASK_2		0x71	/* Interrupt Mask 2 */
+#define CS35L35_INT_MASK_3		0x72	/* Interrupt Mask 3 */
+#define CS35L35_INT_MASK_4		0x73	/* Interrupt Mask 4 */
+#define CS35L35_INT_STATUS_1		0x74	/* Interrupt Status 1 */
+#define CS35L35_INT_STATUS_2		0x75	/* Interrupt Status 2 */
+#define CS35L35_INT_STATUS_3		0x76	/* Interrupt Status 3 */
+#define CS35L35_INT_STATUS_4		0x77	/* Interrupt Status 4 */
+#define CS35L35_PLL_STATUS		0x78	/* PLL Status */
+#define CS35L35_OTP_TRIM_STATUS		0x7E	/* OTP Trim Status */
+
+#define CS35L35_MAX_REGISTER		0x7F
+
+/* CS35L35_PWRCTL1 */
+#define CS35L35_SFT_RST			0x80
+#define CS35L35_DISCHG_FLT		0x02
+#define CS35L35_PDN_ALL			0x01
+
+/* CS35L35_PWRCTL2 */
+#define CS35L35_PDN_VMON		0x80
+#define CS35L35_PDN_IMON		0x40
+#define CS35L35_PDN_CLASSH		0x20
+#define CS35L35_PDN_VPBR		0x10
+#define CS35L35_PDN_BST			0x04
+#define CS35L35_PDN_AMP			0x01
+
+/* CS35L35_PWRCTL3 */
+#define CS35L35_PDN_VBSTMON_OUT		0x10
+#define CS35L35_PDN_VMON_OUT		0x08
+
+#define CS35L35_AUDIN_DEPTH_MASK	0x03
+#define CS35L35_AUDIN_DEPTH_SHIFT	0
+#define CS35L35_ADVIN_DEPTH_MASK	0x12
+#define CS35L35_ADVIN_DEPTH_SHIFT	2
+#define CS35L35_SDIN_DEPTH_8		0x01
+#define CS35L35_SDIN_DEPTH_16		0x02
+#define CS35L35_SDIN_DEPTH_24		0x03
+
+#define CS35L35_SDOUT_DEPTH_8		0x01
+#define CS35L35_SDOUT_DEPTH_12		0x02
+#define CS35L35_SDOUT_DEPTH_16		0x03
+
+#define CS35L35_AUD_IN_LR_MASK		0x80
+#define CS35L35_AUD_IN_LR_SHIFT		7
+#define CS35L35_ADV_IN_LR_MASK		0x80
+#define CS35L35_ADV_IN_LR_SHIFT		7
+#define CS35L35_AUD_IN_LOC_MASK		0x0F
+#define CS35L35_AUD_IN_LOC_SHIFT	0
+#define CS35L35_ADV_IN_LOC_MASK		0x0F
+#define CS35L35_ADV_IN_LOC_SHIFT	0
+
+#define CS35L35_IMON_DEPTH_MASK		0x03
+#define CS35L35_IMON_DEPTH_SHIFT	0
+#define CS35L35_VMON_DEPTH_MASK		0x0C
+#define CS35L35_VMON_DEPTH_SHIFT	2
+#define CS35L35_VBSTMON_DEPTH_MASK	0x03
+#define CS35L35_VBSTMON_DEPTH_SHIFT	0
+#define CS35L35_VPMON_DEPTH_MASK	0x0C
+#define CS35L35_VPMON_DEPTH_SHIFT	2
+#define CS35L35_VPBRSTAT_DEPTH_MASK	0x18
+#define CS35L35_VPBRSTAT_DEPTH_SHIFT	4
+#define CS35L35_ZEROFILL_DEPTH_MASK	0x03
+#define CS35L35_ZEROFILL_DEPTH_SHIFT	0x00
+
+#define CS35L35_MON_TXLOC_MASK		0x3F
+#define CS35L35_MON_TXLOC_SHIFT		0
+#define CS35L35_MON_FRM_MASK		0x80
+#define CS35L35_MON_FRM_SHIFT		7
+
+#define CS35L35_MS_MASK			0x80
+#define CS35L35_MS_SHIFT		7
+#define CS35L35_SPMODE_MASK		0x40
+#define CS35L35_SP_DRV_MASK		0x10
+#define CS35L35_SP_DRV_SHIFT		4
+#define CS35L35_CLK_CTL2_MASK		0xFF
+#define CS35L35_PDM_MODE_MASK		0x40
+#define CS35L35_PDM_MODE_SHIFT		6
+#define CS35L35_CLK_SOURCE_MASK		0x03
+#define CS35L35_CLK_SOURCE_SHIFT	0
+#define CS35L35_CLK_SOURCE_MCLK		0
+#define CS35L35_CLK_SOURCE_SCLK		1
+#define CS35L35_CLK_SOURCE_PDM		2
+
+#define CS35L35_SP_SCLKS_MASK		0x0F
+#define CS35L35_SP_SCLKS_SHIFT		0x00
+#define CS35L35_SP_SCLKS_16FS		0x03
+#define CS35L35_SP_SCLKS_32FS		0x07
+#define CS35L35_SP_SCLKS_48FS		0x0B
+#define CS35L35_SP_SCLKS_64FS		0x0F
+#define CS35L35_SP_RATE_MASK		0xC0
+
+#define CS35L35_PDN_BST_MASK		0x06
+#define CS35L35_PDN_BST_FETON_SHIFT	1
+#define CS35L35_PDN_BST_FETOFF_SHIFT	2
+#define CS35L35_PWR2_PDN_MASK		0xE0
+#define CS35L35_PWR3_PDN_MASK		0x1E
+#define CS35L35_PDN_ALL_MASK		0x01
+#define CS35L35_DISCHG_FILT_MASK	0x02
+#define CS35L35_DISCHG_FILT_SHIFT	1
+#define CS35L35_MCLK_DIS_MASK		0x04
+#define CS35L35_MCLK_DIS_SHIFT		2
+
+#define CS35L35_BST_CTL_MASK		0x7F
+#define CS35L35_BST_CTL_SHIFT		0
+#define CS35L35_BST_IPK_MASK		0x1F
+#define CS35L35_BST_IPK_SHIFT		0
+#define CS35L35_AMP_MUTE_MASK		0x20
+#define CS35L35_AMP_MUTE_SHIFT		5
+#define CS35L35_AMP_GAIN_ZC_MASK	0x10
+#define CS35L35_AMP_GAIN_ZC_SHIFT	4
+
+/* Class H Algorithm Control */
+#define CS35L35_CH_STEREO_MASK		0x40
+#define CS35L35_CH_STEREO_SHIFT		6
+#define CS35L35_CH_BST_OVR_MASK		0x04
+#define CS35L35_CH_BST_OVR_SHIFT	2
+#define CS35L35_CH_BST_LIM_MASK		0x08
+#define CS35L35_CH_BST_LIM_SHIFT	3
+#define CS35L35_CH_MEM_DEPTH_MASK	0x01
+#define CS35L35_CH_MEM_DEPTH_SHIFT	0
+#define CS35L35_CH_HDRM_CTL_MASK	0x3F
+#define CS35L35_CH_HDRM_CTL_SHIFT	0
+#define CS35L35_CH_REL_RATE_MASK	0xFF
+#define CS35L35_CH_REL_RATE_SHIFT	0
+#define CS35L35_CH_WKFET_DIS_MASK	0x80
+#define CS35L35_CH_WKFET_DIS_SHIFT	7
+#define CS35L35_CH_WKFET_DEL_MASK	0x70
+#define CS35L35_CH_WKFET_DEL_SHIFT	4
+#define CS35L35_CH_WKFET_THLD_MASK	0x0F
+#define CS35L35_CH_WKFET_THLD_SHIFT	0
+#define CS35L35_CH_VP_AUTO_MASK		0x80
+#define CS35L35_CH_VP_AUTO_SHIFT	7
+#define CS35L35_CH_VP_RATE_MASK		0x60
+#define CS35L35_CH_VP_RATE_SHIFT	5
+#define CS35L35_CH_VP_MAN_MASK		0x1F
+#define CS35L35_CH_VP_MAN_SHIFT		0
+
+/* CS35L35_PROT_RELEASE_CTL */
+#define CS35L35_CAL_ERR_RLS		0x80
+#define CS35L35_SHORT_RLS		0x04
+#define CS35L35_OTW_RLS			0x02
+#define CS35L35_OTE_RLS			0x01
+
+/* INT Mask Registers */
+#define CS35L35_INT1_CRIT_MASK		0x38
+#define CS35L35_INT2_CRIT_MASK		0xEF
+#define CS35L35_INT3_CRIT_MASK		0xEE
+#define CS35L35_INT4_CRIT_MASK		0xFF
+
+/* PDN DONE Masks */
+#define CS35L35_M_PDN_DONE_SHIFT	4
+#define CS35L35_M_PDN_DONE_MASK		0x10
+
+/* CS35L35_INT_1 */
+#define CS35L35_CAL_ERR			0x80
+#define CS35L35_OTP_ERR			0x40
+#define CS35L35_LRCLK_ERR		0x20
+#define CS35L35_SPCLK_ERR		0x10
+#define CS35L35_MCLK_ERR		0x08
+#define CS35L35_AMP_SHORT		0x04
+#define CS35L35_OTW			0x02
+#define CS35L35_OTE			0x01
+
+/* CS35L35_INT_2 */
+#define CS35L35_PDN_DONE		0x10
+#define CS35L35_VPBR_ERR		0x02
+#define CS35L35_VPBR_CLR		0x01
+
+/* CS35L35_INT_3 */
+#define CS35L35_BST_HIGH		0x10
+#define CS35L35_BST_HIGH_FLAG		0x08
+#define CS35L35_BST_IPK_FLAG		0x04
+#define CS35L35_LBST_SHORT		0x01
+
+/* CS35L35_INT_4 */
+#define CS35L35_VMON_OVFL		0x08
+#define CS35L35_IMON_OVFL		0x04
+
+#define CS35L35_FORMATS (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct  cs35l35_private {
+	struct snd_soc_codec *codec;
+	struct cs35l35_platform_data pdata;
+	struct regmap *regmap;
+	struct regulator_bulk_data supplies[2];
+	int num_supplies;
+	int sysclk;
+	int sclk;
+	bool pdm_mode;
+	bool i2s_mode;
+	bool slave_mode;
+	/* GPIO for /RST */
+	struct gpio_desc *reset_gpio;
+	struct completion pdn_done;
+};
+
+static const char * const cs35l35_supplies[] = {
+	"VA",
+	"VP",
+};
+
+#endif
-- 
1.9.1
