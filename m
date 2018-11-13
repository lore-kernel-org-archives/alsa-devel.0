From: James Schulman <james.schulman@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs35l36: Add support for Cirrus
	CS35L36 Amplifier
Date: Tue, 13 Nov 2018 12:49:16 -0600
Message-ID: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EFD52677E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:47:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, broonie@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

Add driver support for Cirrus Logic CS35L36 boosted
speaker amplifier

Signed-off-by: James Schulman <james.schulman@cirrus.com>
---
 include/sound/cs35l36.h           |   58 ++
 sound/soc/codecs/Kconfig          |    5 +
 sound/soc/codecs/Makefile         |    2 +
 sound/soc/codecs/cs35l36-tables.c |  315 +++++++
 sound/soc/codecs/cs35l36.c        | 1736 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l36.h        |  451 ++++++++++
 6 files changed, 2567 insertions(+)
 create mode 100644 include/sound/cs35l36.h
 create mode 100644 sound/soc/codecs/cs35l36-tables.c
 create mode 100644 sound/soc/codecs/cs35l36.c
 create mode 100644 sound/soc/codecs/cs35l36.h

diff --git a/include/sound/cs35l36.h b/include/sound/cs35l36.h
new file mode 100644
index 0000000..6061e40
--- /dev/null
+++ b/include/sound/cs35l36.h
@@ -0,0 +1,58 @@
+/*
+ * linux/sound/cs35l36.h -- Platform data for CS35L36
+ *
+ * Copyright (c) 2018 Cirrus Logic Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CS35L36_H
+#define __CS35L36_H
+
+/* INT/GPIO pin configuration */
+struct irq_cfg {
+	bool is_present;
+	int irq_drv_sel;
+	int irq_pol;
+	int irq_gpio_sel;
+	int irq_out_en;
+	int irq_src_sel;
+};
+
+struct vpbr_cfg {
+	bool is_present;
+	bool vpbr_en;
+	int vpbr_thld;
+	int vpbr_atk_rate;
+	int vpbr_atk_vol;
+	int vpbr_max_attn;
+	int vpbr_wait;
+	int vpbr_rel_rate;
+	int vpbr_mute_en;
+};
+
+struct cs35l36_platform_data {
+	bool sclk_frc;
+	bool lrclk_frc;
+	bool multi_amp_mode;
+	bool dcm_mode;
+	int ldm_mode_sel;
+	bool amp_gain_zc;
+	bool amp_pcm_inv;
+	bool pdm_ldm_exit;
+	bool pdm_ldm_enter;
+	bool imon_pol_inv;
+	bool vmon_pol_inv;
+	int boost_ind;
+	int bst_vctl;
+	int bst_vctl_sel;
+	int bst_ipk;
+	bool extern_boost;
+	int temp_warn_thld;
+	struct vpbr_cfg vpbr_config;
+	struct irq_cfg irq_config;
+};
+
+#endif /* __CS35L36_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9cc4f18..77cb861 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -53,6 +53,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS35L33 if I2C
 	select SND_SOC_CS35L34 if I2C
 	select SND_SOC_CS35L35 if I2C
+	select SND_SOC_CS35L36 if I2C
 	select SND_SOC_CS42L42 if I2C
 	select SND_SOC_CS42L51_I2C if I2C
 	select SND_SOC_CS42L52 if I2C && INPUT
@@ -465,6 +466,10 @@ config SND_SOC_CS35L35
 	tristate "Cirrus Logic CS35L35 CODEC"
 	depends on I2C
 
+config SND_SOC_CS35L36
+	tristate "Cirrus Logic CS35L36 CODEC"
+	depends on I2C
+
 config SND_SOC_CS42L42
 	tristate "Cirrus Logic CS42L42 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8ffab8c..7a6009a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -45,6 +45,7 @@ snd-soc-cs35l32-objs := cs35l32.o
 snd-soc-cs35l33-objs := cs35l33.o
 snd-soc-cs35l34-objs := cs35l34.o
 snd-soc-cs35l35-objs := cs35l35.o
+snd-soc-cs35l36-objs := cs35l36.o cs35l36-tables.o
 snd-soc-cs42l42-objs := cs42l42.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
@@ -310,6 +311,7 @@ obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
 obj-$(CONFIG_SND_SOC_CS35L33)	+= snd-soc-cs35l33.o
 obj-$(CONFIG_SND_SOC_CS35L34)	+= snd-soc-cs35l34.o
 obj-$(CONFIG_SND_SOC_CS35L35)	+= snd-soc-cs35l35.o
+obj-$(CONFIG_SND_SOC_CS35L36)	+= snd-soc-cs35l36.o
 obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
diff --git a/sound/soc/codecs/cs35l36-tables.c b/sound/soc/codecs/cs35l36-tables.c
new file mode 100644
index 0000000..4a93182
--- /dev/null
+++ b/sound/soc/codecs/cs35l36-tables.c
@@ -0,0 +1,315 @@
+/*
+ * cs35l36-tables.c -- CS35L36 ALSA SoC audio driver
+ *
+ * Copyright 2018 Cirrus Logic, Inc.
+ *
+ * Author: James Schulman <james.schulman@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include "cs35l36.h"
+
+struct reg_default cs35l36_reg[CS35L36_MAX_CACHE_REG] = {
+	{CS35L36_TESTKEY_CTRL,			0x00000000},
+	{CS35L36_USERKEY_CTL,			0x00000000},
+	{CS35L36_OTP_CTRL1,			0x00002460},
+	{CS35L36_OTP_CTRL2,			0x00000000},
+	{CS35L36_OTP_CTRL3,			0x00000000},
+	{CS35L36_OTP_CTRL4,			0x00000000},
+	{CS35L36_OTP_CTRL5,			0x00000000},
+	{CS35L36_PAC_CTL1,			0x00000004},
+	{CS35L36_PAC_CTL2,			0x00000000},
+	{CS35L36_PAC_CTL3,			0x00000000},
+	{CS35L36_PWR_CTRL1,			0x00000000},
+	{CS35L36_PWR_CTRL2,			0x00003321},
+	{CS35L36_PWR_CTRL3,			0x01000010},
+	{CS35L36_CTRL_OVRRIDE,			0x00000002},
+	{CS35L36_AMP_OUT_MUTE,			0x00000000},
+	{CS35L36_OTP_TRIM_STATUS,		0x00000000},
+	{CS35L36_DISCH_FILT,			0x00000000},
+	{CS35L36_PROTECT_REL_ERR,		0x00000000},
+	{CS35L36_PAD_INTERFACE,			0x00000038},
+	{CS35L36_PLL_CLK_CTRL,			0x00000010},
+	{CS35L36_GLOBAL_CLK_CTRL,		0x00000003},
+	{CS35L36_ADC_CLK_CTRL,			0x00000000},
+	{CS35L36_SWIRE_CLK_CTRL,		0x00000000},
+	{CS35L36_SP_SCLK_CLK_CTRL,		0x00000000},
+	{CS35L36_MDSYNC_EN,			0x00000000},
+	{CS35L36_MDSYNC_TX_ID,			0x00000000},
+	{CS35L36_MDSYNC_PWR_CTRL,		0x00000000},
+	{CS35L36_MDSYNC_DATA_TX,		0x00000000},
+	{CS35L36_MDSYNC_TX_STATUS,		0x00000002},
+	{CS35L36_MDSYNC_RX_STATUS,		0x00000000},
+	{CS35L36_MDSYNC_ERR_STATUS,		0x00000000},
+	{CS35L36_BSTCVRT_VCTRL1,		0x00000000},
+	{CS35L36_BSTCVRT_VCTRL2,		0x00000001},
+	{CS35L36_BSTCVRT_PEAK_CUR,		0x0000004A},
+	{CS35L36_BSTCVRT_SFT_RAMP,		0x00000003},
+	{CS35L36_BSTCVRT_COEFF,			0x00002424},
+	{CS35L36_BSTCVRT_SLOPE_LBST,		0x00005800},
+	{CS35L36_BSTCVRT_SW_FREQ,		0x00010000},
+	{CS35L36_BSTCVRT_DCM_CTRL,		0x00002001},
+	{CS35L36_BSTCVRT_DCM_MODE_FORCE,	0x00000000},
+	{CS35L36_BSTCVRT_OVERVOLT_CTRL,		0x00000130},
+	{CS35L36_VPI_LIMIT_MODE,		0x00000000},
+	{CS35L36_VPI_LIMIT_MINMAX,		0x00003000},
+	{CS35L36_VPI_VP_THLD,			0x00101010},
+	{CS35L36_VPI_TRACK_CTRL,		0x00000000},
+	{CS35L36_VPI_TRIG_MODE_CTRL,		0x00000000},
+	{CS35L36_VPI_TRIG_STEPS,		0x00000000},
+	{CS35L36_VI_SPKMON_FILT,		0x00000003},
+	{CS35L36_VI_SPKMON_GAIN,		0x00000909},
+	{CS35L36_VI_SPKMON_IP_SEL,		0x00000000},
+	{CS35L36_DTEMP_WARN_THLD,		0x00000002},
+	{CS35L36_DTEMP_STATUS,			0x00000000},
+	{CS35L36_VPVBST_FS_SEL,			0x00000001},
+	{CS35L36_VPVBST_VP_CTRL,		0x000001C0},
+	{CS35L36_VPVBST_VBST_CTRL,		0x000001C0},
+	{CS35L36_ASP_TX_PIN_CTRL,		0x00000028},
+	{CS35L36_ASP_RATE_CTRL,			0x00090000},
+	{CS35L36_ASP_FORMAT,			0x00000002},
+	{CS35L36_ASP_FRAME_CTRL,		0x00180018},
+	{CS35L36_ASP_TX1_TX2_SLOT,		0x00010000},
+	{CS35L36_ASP_TX3_TX4_SLOT,		0x00030002},
+	{CS35L36_ASP_TX5_TX6_SLOT,		0x00050004},
+	{CS35L36_ASP_TX7_TX8_SLOT,		0x00070006},
+	{CS35L36_ASP_RX1_SLOT,			0x00000000},
+	{CS35L36_ASP_RX_TX_EN,			0x00000000},
+	{CS35L36_ASP_RX1_SEL,			0x00000008},
+	{CS35L36_ASP_TX1_SEL,			0x00000018},
+	{CS35L36_ASP_TX2_SEL,			0x00000019},
+	{CS35L36_ASP_TX3_SEL,			0x00000028},
+	{CS35L36_ASP_TX4_SEL,			0x00000029},
+	{CS35L36_ASP_TX5_SEL,			0x00000020},
+	{CS35L36_ASP_TX6_SEL,			0x00000000},
+	{CS35L36_SWIRE_P1_TX1_SEL,		0x00000018},
+	{CS35L36_SWIRE_P1_TX2_SEL,		0x00000019},
+	{CS35L36_SWIRE_P2_TX1_SEL,		0x00000028},
+	{CS35L36_SWIRE_P2_TX2_SEL,		0x00000029},
+	{CS35L36_SWIRE_P2_TX3_SEL,		0x00000020},
+	{CS35L36_SWIRE_DP1_FIFO_CFG,		0x0000001B},
+	{CS35L36_SWIRE_DP2_FIFO_CFG,		0x0000001B},
+	{CS35L36_SWIRE_DP3_FIFO_CFG,		0x0000001B},
+	{CS35L36_SWIRE_PCM_RX_DATA,		0x00000000},
+	{CS35L36_SWIRE_FS_SEL,			0x00000001},
+	{CS35L36_AMP_DIG_VOL_CTRL,		0x00008000},
+	{CS35L36_VPBR_CFG,			0x02AA1905},
+	{CS35L36_VBBR_CFG,			0x02AA1905},
+	{CS35L36_VPBR_STATUS,			0x00000000},
+	{CS35L36_VBBR_STATUS,			0x00000000},
+	{CS35L36_OVERTEMP_CFG,			0x00000001},
+	{CS35L36_AMP_ERR_VOL,			0x00000000},
+	{CS35L36_CLASSH_CFG,			0x000B0405},
+	{CS35L36_CLASSH_FET_DRV_CFG,		0x00000111},
+	{CS35L36_NG_CFG,			0x00000033},
+	{CS35L36_AMP_GAIN_CTRL,			0x00000273},
+	{CS35L36_PWM_MOD_IO_CTRL,		0x00000000},
+	{CS35L36_PWM_MOD_STATUS,		0x00000000},
+	{CS35L36_DAC_MSM_CFG,			0x00000000},
+	{CS35L36_AMP_SLOPE_CTRL,		0x00000B00},
+	{CS35L36_AMP_PDM_VOLUME,		0x00000000},
+	{CS35L36_AMP_PDM_RATE_CTRL,		0x00000000},
+	{CS35L36_PDM_CH_SEL,			0x00000000},
+	{CS35L36_AMP_NG_CTRL,			0x0000212F},
+	{CS35L36_PDM_HIGHFILT_CTRL,		0x00000000},
+	{CS35L36_PAC_INT0_CTRL,			0x00000001},
+	{CS35L36_PAC_INT1_CTRL,			0x00000001},
+	{CS35L36_PAC_INT2_CTRL,			0x00000001},
+	{CS35L36_PAC_INT3_CTRL,			0x00000001},
+	{CS35L36_PAC_INT4_CTRL,			0x00000001},
+	{CS35L36_PAC_INT5_CTRL,			0x00000001},
+	{CS35L36_PAC_INT6_CTRL,			0x00000001},
+	{CS35L36_PAC_INT7_CTRL,			0x00000001},
+};
+EXPORT_SYMBOL_GPL(cs35l36_reg);
+
+bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L36_SW_RESET:
+	case CS35L36_SW_REV:
+	case CS35L36_HW_REV:
+	case CS35L36_TESTKEY_CTRL:
+	case CS35L36_USERKEY_CTL:
+	case CS35L36_OTP_MEM30:
+	case CS35L36_OTP_CTRL1:
+	case CS35L36_OTP_CTRL2:
+	case CS35L36_OTP_CTRL3:
+	case CS35L36_OTP_CTRL4:
+	case CS35L36_OTP_CTRL5:
+	case CS35L36_PAC_CTL1:
+	case CS35L36_PAC_CTL2:
+	case CS35L36_PAC_CTL3:
+	case CS35L36_DEVICE_ID:
+	case CS35L36_FAB_ID:
+	case CS35L36_REV_ID:
+	case CS35L36_PWR_CTRL1:
+	case CS35L36_PWR_CTRL2:
+	case CS35L36_PWR_CTRL3:
+	case CS35L36_CTRL_OVRRIDE:
+	case CS35L36_AMP_OUT_MUTE:
+	case CS35L36_OTP_TRIM_STATUS:
+	case CS35L36_DISCH_FILT:
+	case CS35L36_PROTECT_REL_ERR:
+	case CS35L36_PAD_INTERFACE:
+	case CS35L36_PLL_CLK_CTRL:
+	case CS35L36_GLOBAL_CLK_CTRL:
+	case CS35L36_ADC_CLK_CTRL:
+	case CS35L36_SWIRE_CLK_CTRL:
+	case CS35L36_SP_SCLK_CLK_CTRL:
+	case CS35L36_MDSYNC_EN:
+	case CS35L36_MDSYNC_TX_ID:
+	case CS35L36_MDSYNC_PWR_CTRL:
+	case CS35L36_MDSYNC_DATA_TX:
+	case CS35L36_MDSYNC_TX_STATUS:
+	case CS35L36_MDSYNC_RX_STATUS:
+	case CS35L36_MDSYNC_ERR_STATUS:
+	case CS35L36_BSTCVRT_VCTRL1:
+	case CS35L36_BSTCVRT_VCTRL2:
+	case CS35L36_BSTCVRT_PEAK_CUR:
+	case CS35L36_BSTCVRT_SFT_RAMP:
+	case CS35L36_BSTCVRT_COEFF:
+	case CS35L36_BSTCVRT_SLOPE_LBST:
+	case CS35L36_BSTCVRT_SW_FREQ:
+	case CS35L36_BSTCVRT_DCM_CTRL:
+	case CS35L36_BSTCVRT_DCM_MODE_FORCE:
+	case CS35L36_BSTCVRT_OVERVOLT_CTRL:
+	case CS35L36_BST_TST_MANUAL:
+	case CS35L36_BST_ANA2_TEST:
+	case CS35L36_VPI_LIMIT_MODE:
+	case CS35L36_VPI_LIMIT_MINMAX:
+	case CS35L36_VPI_VP_THLD:
+	case CS35L36_VPI_TRACK_CTRL:
+	case CS35L36_VPI_TRIG_MODE_CTRL:
+	case CS35L36_VPI_TRIG_STEPS:
+	case CS35L36_VI_SPKMON_FILT:
+	case CS35L36_VI_SPKMON_GAIN:
+	case CS35L36_VI_SPKMON_IP_SEL:
+	case CS35L36_DTEMP_WARN_THLD:
+	case CS35L36_DTEMP_STATUS:
+	case CS35L36_VPVBST_FS_SEL:
+	case CS35L36_VPVBST_VP_CTRL:
+	case CS35L36_VPVBST_VBST_CTRL:
+	case CS35L36_ASP_TX_PIN_CTRL:
+	case CS35L36_ASP_RATE_CTRL:
+	case CS35L36_ASP_FORMAT:
+	case CS35L36_ASP_FRAME_CTRL:
+	case CS35L36_ASP_TX1_TX2_SLOT:
+	case CS35L36_ASP_TX3_TX4_SLOT:
+	case CS35L36_ASP_TX5_TX6_SLOT:
+	case CS35L36_ASP_TX7_TX8_SLOT:
+	case CS35L36_ASP_RX1_SLOT:
+	case CS35L36_ASP_RX_TX_EN:
+	case CS35L36_ASP_RX1_SEL:
+	case CS35L36_ASP_TX1_SEL:
+	case CS35L36_ASP_TX2_SEL:
+	case CS35L36_ASP_TX3_SEL:
+	case CS35L36_ASP_TX4_SEL:
+	case CS35L36_ASP_TX5_SEL:
+	case CS35L36_ASP_TX6_SEL:
+	case CS35L36_SWIRE_P1_TX1_SEL:
+	case CS35L36_SWIRE_P1_TX2_SEL:
+	case CS35L36_SWIRE_P2_TX1_SEL:
+	case CS35L36_SWIRE_P2_TX2_SEL:
+	case CS35L36_SWIRE_P2_TX3_SEL:
+	case CS35L36_SWIRE_DP1_FIFO_CFG:
+	case CS35L36_SWIRE_DP2_FIFO_CFG:
+	case CS35L36_SWIRE_DP3_FIFO_CFG:
+	case CS35L36_SWIRE_PCM_RX_DATA:
+	case CS35L36_SWIRE_FS_SEL:
+	case CS35L36_AMP_DIG_VOL_CTRL:
+	case CS35L36_VPBR_CFG:
+	case CS35L36_VBBR_CFG:
+	case CS35L36_VPBR_STATUS:
+	case CS35L36_VBBR_STATUS:
+	case CS35L36_OVERTEMP_CFG:
+	case CS35L36_AMP_ERR_VOL:
+	case CS35L36_CLASSH_CFG:
+	case CS35L36_CLASSH_FET_DRV_CFG:
+	case CS35L36_NG_CFG:
+	case CS35L36_AMP_GAIN_CTRL:
+	case CS35L36_PWM_MOD_IO_CTRL:
+	case CS35L36_PWM_MOD_STATUS:
+	case CS35L36_DAC_MSM_CFG:
+	case CS35L36_AMP_SLOPE_CTRL:
+	case CS35L36_AMP_PDM_VOLUME:
+	case CS35L36_AMP_PDM_RATE_CTRL:
+	case CS35L36_PDM_CH_SEL:
+	case CS35L36_AMP_NG_CTRL:
+	case CS35L36_PDM_HIGHFILT_CTRL:
+	case CS35L36_INT1_STATUS:
+	case CS35L36_INT2_STATUS:
+	case CS35L36_INT3_STATUS:
+	case CS35L36_INT4_STATUS:
+	case CS35L36_INT1_RAW_STATUS:
+	case CS35L36_INT2_RAW_STATUS:
+	case CS35L36_INT3_RAW_STATUS:
+	case CS35L36_INT4_RAW_STATUS:
+	case CS35L36_INT1_MASK:
+	case CS35L36_INT2_MASK:
+	case CS35L36_INT3_MASK:
+	case CS35L36_INT4_MASK:
+	case CS35L36_INT1_EDGE_LVL_CTRL:
+	case CS35L36_INT3_EDGE_LVL_CTRL:
+	case CS35L36_PAC_INT_STATUS:
+	case CS35L36_PAC_INT_RAW_STATUS:
+	case CS35L36_PAC_INT_FLUSH_CTRL:
+	case CS35L36_PAC_INT0_CTRL:
+	case CS35L36_PAC_INT1_CTRL:
+	case CS35L36_PAC_INT2_CTRL:
+	case CS35L36_PAC_INT3_CTRL:
+	case CS35L36_PAC_INT4_CTRL:
+	case CS35L36_PAC_INT5_CTRL:
+	case CS35L36_PAC_INT6_CTRL:
+	case CS35L36_PAC_INT7_CTRL:
+		return true;
+	default:
+		if (reg >= CS35L36_PAC_PMEM_WORD0 &&
+			reg <= CS35L36_PAC_PMEM_WORD1023)
+			return true;
+		else
+			return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cs35l36_readable_reg);
+
+bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L36_SW_RESET:
+	case CS35L36_SW_REV:
+	case CS35L36_HW_REV:
+	case CS35L36_DEVICE_ID:
+	case CS35L36_FAB_ID:
+	case CS35L36_REV_ID:
+	case CS35L36_INT1_STATUS:
+	case CS35L36_INT2_STATUS:
+	case CS35L36_INT3_STATUS:
+	case CS35L36_INT4_STATUS:
+	case CS35L36_INT1_RAW_STATUS:
+	case CS35L36_INT2_RAW_STATUS:
+	case CS35L36_INT3_RAW_STATUS:
+	case CS35L36_INT4_RAW_STATUS:
+	case CS35L36_INT1_MASK:
+	case CS35L36_INT2_MASK:
+	case CS35L36_INT3_MASK:
+	case CS35L36_INT4_MASK:
+	case CS35L36_INT1_EDGE_LVL_CTRL:
+	case CS35L36_INT3_EDGE_LVL_CTRL:
+	case CS35L36_PAC_INT_STATUS:
+	case CS35L36_PAC_INT_RAW_STATUS:
+	case CS35L36_PAC_INT_FLUSH_CTRL:
+		return true;
+	default:
+		if (reg >= CS35L36_PAC_PMEM_WORD0 &&
+			reg <= CS35L36_PAC_PMEM_WORD1023)
+			return true;
+		else
+			return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cs35l36_volatile_reg);
diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
new file mode 100644
index 0000000..4fa1531
--- /dev/null
+++ b/sound/soc/codecs/cs35l36.c
@@ -0,0 +1,1736 @@
+/*
+ * cs35l36.c -- CS35L36 ALSA SoC audio driver
+ *
+ * Copyright 2018 Cirrus Logic, Inc.
+ *
+ * Author: James Schulman <james.schulman@cirrus.com>
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
+#include <sound/cs35l36.h>
+#include <linux/of_irq.h>
+#include <linux/completion.h>
+
+#include "cs35l36.h"
+
+/*
+ * Some fields take zero as a valid value so use a high bit flag that won't
+ * get written to the device to mark those.
+ */
+#define CS35L36_VALID_PDATA 0x80000000
+
+
+static const char * const cs35l36_supplies[] = {
+	"VA",
+	"VP",
+};
+
+struct  cs35l36_private {
+	struct device *dev;
+	struct cs35l36_platform_data pdata;
+	struct regmap *regmap;
+	struct regulator_bulk_data supplies[2];
+	int num_supplies;
+	int clksrc;
+	int prev_clksrc;
+	int extclk_freq;
+	int extclk_cfg;
+	int fll_igain;
+	int sclk;
+	int chip_version;
+	int rev_id;
+	struct gpio_desc *reset_gpio;
+	struct completion global_pup_done;
+	struct completion global_pdn_done;
+};
+
+struct cs35l36_pll_sysclk_config {
+	int freq;
+	int clk_cfg;
+	int fll_igain;
+};
+
+static const struct cs35l36_pll_sysclk_config cs35l36_pll_sysclk[] = {
+	{32768,		0x00, 0x05},
+	{8000,		0x01, 0x03},
+	{11025,		0x02, 0x03},
+	{12000,		0x03, 0x03},
+	{16000,		0x04, 0x04},
+	{22050,		0x05, 0x04},
+	{24000,		0x06, 0x04},
+	{32000,		0x07, 0x05},
+	{44100,		0x08, 0x05},
+	{48000,		0x09, 0x05},
+	{88200,		0x0A, 0x06},
+	{96000,		0x0B, 0x06},
+	{128000,	0x0C, 0x07},
+	{176400,	0x0D, 0x07},
+	{192000,	0x0E, 0x07},
+	{256000,	0x0F, 0x08},
+	{352800,	0x10, 0x08},
+	{384000,	0x11, 0x08},
+	{512000,	0x12, 0x09},
+	{705600,	0x13, 0x09},
+	{750000,	0x14, 0x09},
+	{768000,	0x15, 0x09},
+	{1000000,	0x16, 0x0A},
+	{1024000,	0x17, 0x0A},
+	{1200000,	0x18, 0x0A},
+	{1411200,	0x19, 0x0A},
+	{1500000,	0x1A, 0x0A},
+	{1536000,	0x1B, 0x0A},
+	{2000000,	0x1C, 0x0A},
+	{2048000,	0x1D, 0x0A},
+	{2400000,	0x1E, 0x0A},
+	{2822400,	0x1F, 0x0A},
+	{3000000,	0x20, 0x0A},
+	{3072000,	0x21, 0x0A},
+	{3200000,	0x22, 0x0A},
+	{4000000,	0x23, 0x0A},
+	{4096000,	0x24, 0x0A},
+	{4800000,	0x25, 0x0A},
+	{5644800,	0x26, 0x0A},
+	{6000000,	0x27, 0x0A},
+	{6144000,	0x28, 0x0A},
+	{6250000,	0x29, 0x08},
+	{6400000,	0x2A, 0x0A},
+	{6500000,	0x2B, 0x08},
+	{6750000,	0x2C, 0x09},
+	{7526400,	0x2D, 0x0A},
+	{8000000,	0x2E, 0x0A},
+	{8192000,	0x2F, 0x0A},
+	{9600000,	0x30, 0x0A},
+	{11289600,	0x31, 0x0A},
+	{12000000,	0x32, 0x0A},
+	{12288000,	0x33, 0x0A},
+	{12500000,	0x34, 0x08},
+	{12800000,	0x35, 0x0A},
+	{13000000,	0x36, 0x0A},
+	{13500000,	0x37, 0x0A},
+	{19200000,	0x38, 0x0A},
+	{22579200,	0x39, 0x0A},
+	{24000000,	0x3A, 0x0A},
+	{24576000,	0x3B, 0x0A},
+	{25000000,	0x3C, 0x0A},
+	{25600000,	0x3D, 0x0A},
+	{26000000,	0x3E, 0x0A},
+	{27000000,	0x3F, 0x0A},
+};
+
+static DECLARE_TLV_DB_SCALE(dig_vol_tlv, -10200, 25, 0);
+static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 0, 1, 1);
+
+static const char * const cs35l36_pcm_sftramp_text[] =  {
+	"Off", ".5ms", "1ms", "2ms", "4ms", "8ms", "15ms", "30ms"};
+
+static SOC_ENUM_SINGLE_DECL(pcm_sft_ramp,
+			    CS35L36_AMP_DIG_VOL_CTRL, 0,
+			    cs35l36_pcm_sftramp_text);
+
+static const struct snd_kcontrol_new cs35l36_aud_controls[] = {
+	SOC_SINGLE_SX_TLV("Digital PCM Volume", CS35L36_AMP_DIG_VOL_CTRL,
+		      3, 0x4D0, 0x390, dig_vol_tlv),
+	SOC_SINGLE_TLV("AMP PCM Gain", CS35L36_AMP_GAIN_CTRL, 5, 0x13, 0,
+			amp_gain_tlv),
+	SOC_ENUM("PCM Soft Ramp", pcm_sft_ramp),
+};
+
+static int cs35l36_main_amp_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+			snd_soc_dapm_to_component(w->dapm);
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(component);
+	u32 reg;
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(cs35l36->regmap, CS35L36_PWR_CTRL1,
+					CS35L36_GLOBAL_EN_MASK,
+					1 << CS35L36_GLOBAL_EN_SHIFT);
+		usleep_range(2000, 2100);
+
+		regmap_read(cs35l36->regmap, CS35L36_INT4_RAW_STATUS, &reg);
+		if (reg & CS35L36_PLL_UNLOCK_MASK)
+			dev_crit(cs35l36->dev, "PLL Unlocked\n");
+
+		regmap_update_bits(cs35l36->regmap, CS35L36_ASP_RX1_SEL,
+					CS35L36_PCM_RX_SEL_MASK,
+					CS35L36_PCM_RX_SEL_PCM);
+		regmap_update_bits(cs35l36->regmap, CS35L36_AMP_OUT_MUTE,
+					CS35L36_AMP_MUTE_MASK,
+					0 << CS35L36_AMP_MUTE_SHIFT);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(cs35l36->regmap, CS35L36_ASP_RX1_SEL,
+					CS35L36_PCM_RX_SEL_MASK,
+					CS35L36_PCM_RX_SEL_ZERO);
+		regmap_update_bits(cs35l36->regmap, CS35L36_AMP_OUT_MUTE,
+					CS35L36_AMP_MUTE_MASK,
+					1 << CS35L36_AMP_MUTE_SHIFT);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(cs35l36->regmap, CS35L36_PWR_CTRL1,
+					CS35L36_GLOBAL_EN_MASK,
+					0 << CS35L36_GLOBAL_EN_SHIFT);
+		usleep_range(2000, 2100);
+		break;
+	default:
+		dev_dbg(component->dev, "Invalid event = 0x%x\n", event);
+	}
+	return ret;
+}
+
+static int cs35l36_boost_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+			snd_soc_dapm_to_component(w->dapm);
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (!cs35l36->pdata.extern_boost)
+			regmap_update_bits(cs35l36->regmap, CS35L36_PWR_CTRL2,
+						CS35L36_BST_EN_MASK,
+						CS35L36_BST_EN <<
+						CS35L36_BST_EN_SHIFT);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (!cs35l36->pdata.extern_boost)
+			regmap_update_bits(cs35l36->regmap, CS35L36_PWR_CTRL2,
+						CS35L36_BST_EN_MASK,
+						CS35L36_BST_DIS_VP <<
+						CS35L36_BST_EN_SHIFT);
+		break;
+	default:
+		dev_dbg(component->dev, "Invalid event = 0x%x\n", event);
+	}
+	return 0;
+}
+static const char * const cs35l36_chan_text[] = {
+	"RX1",
+	"RX2",
+};
+
+static SOC_ENUM_SINGLE_DECL(chansel_enum, CS35L36_ASP_RX1_SLOT, 0,
+		cs35l36_chan_text);
+
+static const struct snd_kcontrol_new cs35l36_chan_mux[] = {
+	SOC_DAPM_ENUM("Input Mux", chansel_enum),
+};
+
+static const char * const cs35l36_boost_text[] = {
+	"On",
+	"Off",
+};
+
+static SOC_ENUM_SINGLE_DECL(boost_enum, SND_SOC_NOPM, 0,
+		cs35l36_boost_text);
+
+static const struct snd_kcontrol_new cs35l36_boost_mux[] = {
+	SOC_DAPM_ENUM("Boost Enable", boost_enum),
+};
+
+static const struct snd_kcontrol_new amp_enable_ctrl =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", CS35L36_AMP_OUT_MUTE,
+					CS35L36_AMP_MUTE_SHIFT, 1, 1);
+
+static const char * const asp_tx_src_text[] = {
+	"Zero Fill", "ASPRX1", "VMON", "IMON",
+	"ERRVOL", "VPMON", "VBSTMON"
+};
+
+static const unsigned int asp_tx_src_values[] = {
+	0x00, 0x08, 0x18, 0x19, 0x20, 0x28, 0x29
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(asp_tx1_src_enum,
+				CS35L36_ASP_TX1_SEL, 0,
+				CS35L36_APS_TX_SEL_MASK,
+				asp_tx_src_text,
+				asp_tx_src_values);
+
+static const struct snd_kcontrol_new asp_tx1_src =
+	SOC_DAPM_ENUM("ASPTX1SRC", asp_tx1_src_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(asp_tx2_src_enum,
+				CS35L36_ASP_TX2_SEL, 0,
+				CS35L36_APS_TX_SEL_MASK,
+				asp_tx_src_text,
+				asp_tx_src_values);
+
+static const struct snd_kcontrol_new asp_tx2_src =
+	SOC_DAPM_ENUM("ASPTX2SRC", asp_tx2_src_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(asp_tx3_src_enum,
+				CS35L36_ASP_TX3_SEL, 0,
+				CS35L36_APS_TX_SEL_MASK,
+				asp_tx_src_text,
+				asp_tx_src_values);
+
+static const struct snd_kcontrol_new asp_tx3_src =
+	SOC_DAPM_ENUM("ASPTX3SRC", asp_tx3_src_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(asp_tx4_src_enum,
+				CS35L36_ASP_TX4_SEL, 0,
+				CS35L36_APS_TX_SEL_MASK,
+				asp_tx_src_text,
+				asp_tx_src_values);
+
+static const struct snd_kcontrol_new asp_tx4_src =
+	SOC_DAPM_ENUM("ASPTX4SRC", asp_tx4_src_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(asp_tx5_src_enum,
+				CS35L36_ASP_TX5_SEL, 0,
+				CS35L36_APS_TX_SEL_MASK,
+				asp_tx_src_text,
+				asp_tx_src_values);
+
+static const struct snd_kcontrol_new asp_tx5_src =
+	SOC_DAPM_ENUM("ASPTX5SRC", asp_tx5_src_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(asp_tx6_src_enum,
+				CS35L36_ASP_TX6_SEL, 0,
+				CS35L36_APS_TX_SEL_MASK,
+				asp_tx_src_text,
+				asp_tx_src_values);
+
+static const struct snd_kcontrol_new asp_tx6_src =
+	SOC_DAPM_ENUM("ASPTX6SRC", asp_tx6_src_enum);
+
+static const struct snd_soc_dapm_widget cs35l36_dapm_widgets[] = {
+
+	SND_SOC_DAPM_MUX("Channel Mux", SND_SOC_NOPM, 0, 0, cs35l36_chan_mux),
+	SND_SOC_DAPM_AIF_IN("SDIN", NULL, 0, CS35L36_ASP_RX_TX_EN, 16, 0),
+
+	SND_SOC_DAPM_OUT_DRV_E("Main AMP", CS35L36_PWR_CTRL2, 0, 0, NULL, 0,
+		cs35l36_main_amp_event, SND_SOC_DAPM_POST_PMD |
+				SND_SOC_DAPM_POST_PMU |
+				SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_OUTPUT("SPK"),
+	SND_SOC_DAPM_SWITCH("AMP Enable", SND_SOC_NOPM, 0, 1, &amp_enable_ctrl),
+	SND_SOC_DAPM_MIXER("CLASS H", CS35L36_PWR_CTRL3, 4, 0, NULL, 0),
+	SND_SOC_DAPM_MUX_E("BOOST Mux", SND_SOC_NOPM, 0, 0, cs35l36_boost_mux,
+		cs35l36_boost_event, SND_SOC_DAPM_POST_PMD |
+				SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_AIF_OUT("ASPTX1", NULL, 0, CS35L36_ASP_RX_TX_EN, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ASPTX2", NULL, 1, CS35L36_ASP_RX_TX_EN, 1, 0),
+	SND_SOC_DAPM_AIF_OUT("ASPTX3", NULL, 2, CS35L36_ASP_RX_TX_EN, 2, 0),
+	SND_SOC_DAPM_AIF_OUT("ASPTX4", NULL, 3, CS35L36_ASP_RX_TX_EN, 3, 0),
+	SND_SOC_DAPM_AIF_OUT("ASPTX5", NULL, 4, CS35L36_ASP_RX_TX_EN, 4, 0),
+	SND_SOC_DAPM_AIF_OUT("ASPTX6", NULL, 5, CS35L36_ASP_RX_TX_EN, 5, 0),
+
+	SND_SOC_DAPM_MUX("ASPTX1SRC", SND_SOC_NOPM, 0, 0, &asp_tx1_src),
+	SND_SOC_DAPM_MUX("ASPTX2SRC", SND_SOC_NOPM, 0, 0, &asp_tx2_src),
+	SND_SOC_DAPM_MUX("ASPTX3SRC", SND_SOC_NOPM, 0, 0, &asp_tx3_src),
+	SND_SOC_DAPM_MUX("ASPTX4SRC", SND_SOC_NOPM, 0, 0, &asp_tx4_src),
+	SND_SOC_DAPM_MUX("ASPTX5SRC", SND_SOC_NOPM, 0, 0, &asp_tx5_src),
+	SND_SOC_DAPM_MUX("ASPTX6SRC", SND_SOC_NOPM, 0, 0, &asp_tx6_src),
+
+	SND_SOC_DAPM_ADC("VMON ADC", NULL, CS35L36_PWR_CTRL2, 12, 0),
+	SND_SOC_DAPM_ADC("IMON ADC", NULL, CS35L36_PWR_CTRL2, 13, 0),
+	SND_SOC_DAPM_ADC("VPMON ADC", NULL, CS35L36_PWR_CTRL2, 8, 0),
+	SND_SOC_DAPM_ADC("VBSTMON ADC", NULL, CS35L36_PWR_CTRL2, 9, 0),
+
+	SND_SOC_DAPM_INPUT("VP"),
+	SND_SOC_DAPM_INPUT("VBST"),
+	SND_SOC_DAPM_INPUT("VSENSE"),
+};
+
+static const struct snd_soc_dapm_route cs35l36_audio_map[] = {
+
+	{"VPMON ADC", NULL, "VP"},
+	{"VBSTMON ADC", NULL, "VBST"},
+	{"IMON ADC", NULL, "VSENSE"},
+	{"VMON ADC", NULL, "VSENSE"},
+
+	{"ASPTX1SRC", "IMON", "IMON ADC"},
+	{"ASPTX1SRC", "VMON", "VMON ADC"},
+	{"ASPTX1SRC", "VBSTMON", "VBSTMON ADC"},
+	{"ASPTX1SRC", "VPMON", "VPMON ADC"},
+
+	{"ASPTX2SRC", "IMON", "IMON ADC"},
+	{"ASPTX2SRC", "VMON", "VMON ADC"},
+	{"ASPTX2SRC", "VBSTMON", "VBSTMON ADC"},
+	{"ASPTX2SRC", "VPMON", "VPMON ADC"},
+
+	{"ASPTX3SRC", "IMON", "IMON ADC"},
+	{"ASPTX3SRC", "VMON", "VMON ADC"},
+	{"ASPTX3SRC", "VBSTMON", "VBSTMON ADC"},
+	{"ASPTX3SRC", "VPMON", "VPMON ADC"},
+
+	{"ASPTX4SRC", "IMON", "IMON ADC"},
+	{"ASPTX4SRC", "VMON", "VMON ADC"},
+	{"ASPTX4SRC", "VBSTMON", "VBSTMON ADC"},
+	{"ASPTX4SRC", "VPMON", "VPMON ADC"},
+
+	{"ASPTX5SRC", "IMON", "IMON ADC"},
+	{"ASPTX5SRC", "VMON", "VMON ADC"},
+	{"ASPTX5SRC", "VBSTMON", "VBSTMON ADC"},
+	{"ASPTX5SRC", "VPMON", "VPMON ADC"},
+
+	{"ASPTX6SRC", "IMON", "IMON ADC"},
+	{"ASPTX6SRC", "VMON", "VMON ADC"},
+	{"ASPTX6SRC", "VBSTMON", "VBSTMON ADC"},
+	{"ASPTX6SRC", "VPMON", "VPMON ADC"},
+
+	{"ASPTX1", NULL, "ASPTX1SRC"},
+	{"ASPTX2", NULL, "ASPTX2SRC"},
+	{"ASPTX3", NULL, "ASPTX3SRC"},
+	{"ASPTX4", NULL, "ASPTX4SRC"},
+	{"ASPTX5", NULL, "ASPTX5SRC"},
+	{"ASPTX6", NULL, "ASPTX6SRC"},
+
+	{"AMP Capture", NULL, "ASPTX1"},
+	{"AMP Capture", NULL, "ASPTX2"},
+	{"AMP Capture", NULL, "ASPTX3"},
+	{"AMP Capture", NULL, "ASPTX4"},
+	{"AMP Capture", NULL, "ASPTX5"},
+	{"AMP Capture", NULL, "ASPTX6"},
+
+	{"AMP Enable", "Switch", "AMP Playback"},
+	{"SDIN", NULL, "AMP Enable"},
+	{"Channel Mux", "RX1", "SDIN"},
+	{"Channel Mux", "RX2", "SDIN"},
+	{"BOOST Mux", "On", "Channel Mux"},
+	{"CLASS H", NULL, "BOOST Mux"},
+	{"Main AMP", NULL, "Channel Mux"},
+	{"Main AMP", NULL, "CLASS H"},
+	{"SPK", NULL, "Main AMP"},
+};
+
+static int cs35l36_set_dai_fmt(struct snd_soc_dai *component_dai,
+			       unsigned int fmt)
+{
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(component_dai->component);
+	unsigned int asp_fmt, lrclk_fmt, sclk_fmt, slave_mode;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		slave_mode = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		slave_mode = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	regmap_update_bits(cs35l36->regmap, CS35L36_ASP_TX_PIN_CTRL,
+				CS35L36_SCLK_MSTR_MASK,
+				slave_mode << CS35L36_SCLK_MSTR_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_ASP_RATE_CTRL,
+				CS35L36_LRCLK_MSTR_MASK,
+				slave_mode << CS35L36_LRCLK_MSTR_SHIFT);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		asp_fmt = 0;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		asp_fmt = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_IF:
+		lrclk_fmt = 1;
+		sclk_fmt = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		lrclk_fmt = 0;
+		sclk_fmt = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		lrclk_fmt = 1;
+		sclk_fmt = 1;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		lrclk_fmt = 0;
+		sclk_fmt = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_ASP_RATE_CTRL,
+				CS35L36_LRCLK_INV_MASK,
+				lrclk_fmt << CS35L36_LRCLK_INV_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_ASP_TX_PIN_CTRL,
+				CS35L36_SCLK_INV_MASK,
+				sclk_fmt << CS35L36_SCLK_INV_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_ASP_FORMAT,
+				CS35L36_ASP_FMT_MASK, asp_fmt);
+
+	return 0;
+}
+
+struct cs35l36_global_fs_config {
+	int rate;
+	int fs_cfg;
+};
+
+static const struct cs35l36_global_fs_config cs35l36_fs_rates[] = {
+	{12000, 0x01},
+	{24000, 0x02},
+	{48000, 0x03},
+	{96000, 0x04},
+	{192000, 0x05},
+	{384000, 0x06},
+	{11025, 0x09},
+	{22050, 0x0A},
+	{44100, 0x0B},
+	{88200, 0x0C},
+	{176400, 0x0D},
+	{8000, 0x11},
+	{16000, 0x12},
+	{32000, 0x13},
+};
+
+static int cs35l36_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(dai->component);
+	int i;
+	unsigned int global_fs = params_rate(params);
+	unsigned int asp_width;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l36_fs_rates); i++) {
+		if (global_fs == cs35l36_fs_rates[i].rate)
+			regmap_update_bits(cs35l36->regmap,
+					CS35L36_GLOBAL_CLK_CTRL,
+					CS35L36_GLOBAL_FS_MASK,
+					cs35l36_fs_rates[i].fs_cfg <<
+					CS35L36_GLOBAL_FS_SHIFT);
+	}
+
+	switch (params_width(params)) {
+	case 16:
+		asp_width = CS35L36_ASP_WIDTH_16;
+		break;
+	case 24:
+		asp_width = CS35L36_ASP_WIDTH_24;
+		break;
+	case 32:
+		asp_width = CS35L36_ASP_WIDTH_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_update_bits(cs35l36->regmap, CS35L36_ASP_FRAME_CTRL,
+				CS35L36_ASP_RX_WIDTH_MASK,
+				asp_width << CS35L36_ASP_RX_WIDTH_SHIFT);
+	} else {
+		regmap_update_bits(cs35l36->regmap, CS35L36_ASP_FRAME_CTRL,
+				CS35L36_ASP_TX_WIDTH_MASK,
+				asp_width << CS35L36_ASP_TX_WIDTH_SHIFT);
+	}
+
+	return 0;
+}
+
+static int cs35l36_dai_set_sysclk(struct snd_soc_dai *dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(component);
+	int fs1_val = 0;
+	int fs2_val = 0;
+
+	/* Need the SCLK Frequency regardless of sysclk source */
+	cs35l36->sclk = freq;
+
+	if (cs35l36->sclk > 6000000) {
+		fs1_val = 3 * 4 + 4;
+		fs2_val = 8 * 4 + 4;
+	}
+
+	if (cs35l36->sclk <= 6000000) {
+		fs1_val = 3 * ((24000000 + cs35l36->sclk - 1) / cs35l36->sclk)
+				+ 4;
+		fs2_val = 5 * ((24000000 + cs35l36->sclk - 1) / cs35l36->sclk)
+				+ 4;
+	}
+	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+			CS35L36_TEST_UNLOCK1);
+	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+			CS35L36_TEST_UNLOCK2);
+	regmap_update_bits(cs35l36->regmap, CS35L36_TST_FS_MON0,
+		CS35L36_FS1_WINDOW_MASK, fs1_val);
+	regmap_update_bits(cs35l36->regmap, CS35L36_TST_FS_MON0,
+		CS35L36_FS2_WINDOW_MASK, fs2_val <<
+		CS35L36_FS2_WINDOW_SHIFT);
+	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+			CS35L36_TEST_LOCK1);
+	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+			CS35L36_TEST_LOCK2);
+	return 0;
+}
+
+static int cs35l36_get_clk_config(struct cs35l36_private *cs35l36, int freq)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l36_pll_sysclk); i++) {
+		if (cs35l36_pll_sysclk[i].freq == freq) {
+			cs35l36->extclk_cfg = cs35l36_pll_sysclk[i].clk_cfg;
+			cs35l36->fll_igain = cs35l36_pll_sysclk[i].fll_igain;
+			return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const unsigned int cs35l36_src_rates[] = {
+	8000, 12000, 11025, 16000, 22050, 24000, 32000,
+	44100, 48000, 88200, 96000, 176400, 192000, 384000
+};
+
+static const struct snd_pcm_hw_constraint_list cs35l36_constraints = {
+	.count  = ARRAY_SIZE(cs35l36_src_rates),
+	.list   = cs35l36_src_rates,
+};
+
+static int cs35l36_pcm_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	if (!substream->runtime)
+		return 0;
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &cs35l36_constraints);
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs35l36_ops = {
+	.startup = cs35l36_pcm_startup,
+	.set_fmt = cs35l36_set_dai_fmt,
+	.hw_params = cs35l36_pcm_hw_params,
+	.set_sysclk = cs35l36_dai_set_sysclk,
+};
+
+static struct snd_soc_dai_driver cs35l36_dai[] = {
+	{
+		.name = "cs35l36-pcm",
+		.id = 0,
+		.playback = {
+			.stream_name = "AMP Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS35L36_RX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AMP Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = CS35L36_TX_FORMATS,
+		},
+		.ops = &cs35l36_ops,
+		.symmetric_rates = 1,
+	},
+};
+
+static int cs35l36_component_set_sysclk(struct snd_soc_component *component,
+				int clk_id, int source, unsigned int freq,
+				int dir)
+{
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(component);
+	int ret;
+
+	cs35l36->extclk_freq = freq;
+	cs35l36->prev_clksrc = cs35l36->clksrc;
+
+	switch (clk_id) {
+	case 0:
+		cs35l36->clksrc = CS35L36_PLLSRC_SCLK;
+		break;
+	case 1:
+		cs35l36->clksrc = CS35L36_PLLSRC_LRCLK;
+		break;
+	case 2:
+		cs35l36->clksrc = CS35L36_PLLSRC_PDMCLK;
+		break;
+	case 3:
+		cs35l36->clksrc = CS35L36_PLLSRC_SELF;
+		break;
+	case 4:
+		cs35l36->clksrc = CS35L36_PLLSRC_MCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = cs35l36_get_clk_config(cs35l36, freq);
+
+	if (ret < 0) {
+		dev_err(component->dev,
+			"Invalid CLK Config Freq: %d\n", freq);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_PLL_CLK_CTRL,
+					CS35L36_PLL_OPENLOOP_MASK,
+					1 << CS35L36_PLL_OPENLOOP_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PLL_CLK_CTRL,
+			CS35L36_REFCLK_FREQ_MASK,
+			cs35l36->extclk_cfg << CS35L36_REFCLK_FREQ_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PLL_CLK_CTRL,
+				CS35L36_PLL_REFCLK_EN_MASK,
+				0 << CS35L36_PLL_REFCLK_EN_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PLL_CLK_CTRL,
+			CS35L36_PLL_CLK_SEL_MASK, cs35l36->clksrc);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PLL_CLK_CTRL,
+					CS35L36_PLL_OPENLOOP_MASK,
+					0 << CS35L36_PLL_OPENLOOP_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PLL_CLK_CTRL,
+				CS35L36_PLL_REFCLK_EN_MASK,
+				1 << CS35L36_PLL_REFCLK_EN_SHIFT);
+
+	if (cs35l36->rev_id == CS35L36_REV_A0) {
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_UNLOCK1);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_UNLOCK2);
+		regmap_write(cs35l36->regmap, CS35L36_DCO_CTRL, 0x00036DA8);
+		regmap_write(cs35l36->regmap, CS35L36_MISC_CTRL, 0x0100EE0E);
+		regmap_update_bits(cs35l36->regmap, CS35L36_PLL_LOOP_PARAMS,
+					CS35L36_PLL_IGAIN_MASK,
+					CS35L36_PLL_IGAIN <<
+					CS35L36_PLL_IGAIN_SHIFT);
+		regmap_update_bits(cs35l36->regmap, CS35L36_PLL_LOOP_PARAMS,
+					CS35L36_PLL_FFL_IGAIN_MASK,
+					cs35l36->fll_igain);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_LOCK1);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_LOCK2);
+	}
+
+	if (cs35l36->clksrc == CS35L36_PLLSRC_PDMCLK) {
+		if (cs35l36->pdata.ldm_mode_sel) {
+			if (cs35l36->prev_clksrc != CS35L36_PLLSRC_PDMCLK)
+				regmap_update_bits(cs35l36->regmap,
+						CS35L36_NG_CFG,
+						CS35L36_NG_DELAY_MASK,
+						0 << CS35L36_NG_DELAY_SHIFT);
+		}
+		regmap_update_bits(cs35l36->regmap, CS35L36_DAC_MSM_CFG,
+					CS35L36_PDM_MODE_MASK,
+					1 << CS35L36_PDM_MODE_SHIFT);
+		if (cs35l36->pdata.ldm_mode_sel) {
+			if (cs35l36->prev_clksrc != CS35L36_PLLSRC_PDMCLK) {
+				regmap_update_bits(cs35l36->regmap,
+						CS35L36_NG_CFG,
+						CS35L36_NG_DELAY_MASK,
+						3 << CS35L36_NG_DELAY_SHIFT);
+			}
+		}
+	} else {
+		if (cs35l36->pdata.ldm_mode_sel) {
+			if (cs35l36->prev_clksrc == CS35L36_PLLSRC_PDMCLK)
+				regmap_update_bits(cs35l36->regmap,
+						CS35L36_NG_CFG,
+						CS35L36_NG_DELAY_MASK,
+						0 << CS35L36_NG_DELAY_SHIFT);
+		}
+		regmap_update_bits(cs35l36->regmap, CS35L36_DAC_MSM_CFG,
+					CS35L36_PDM_MODE_MASK,
+					0 << CS35L36_PDM_MODE_SHIFT);
+		if (cs35l36->pdata.ldm_mode_sel) {
+			if (cs35l36->prev_clksrc == CS35L36_PLLSRC_PDMCLK) {
+				regmap_update_bits(cs35l36->regmap,
+						CS35L36_NG_CFG,
+						CS35L36_NG_DELAY_MASK,
+						3 << CS35L36_NG_DELAY_SHIFT);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int cs35l36_boost_inductor(struct cs35l36_private *cs35l36, int inductor)
+{
+	regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_COEFF,
+					CS35L36_BSTCVRT_K1_MASK, 0x3C);
+	regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_COEFF,
+					CS35L36_BSTCVRT_K2_MASK,
+					0x3C << CS35L36_BSTCVRT_K2_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_SW_FREQ,
+				   CS35L36_BSTCVRT_CCMFREQ_MASK, 0x00);
+
+	switch (inductor) {
+	case 1000: /* 1 uH */
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_SLOPE_LBST,
+					CS35L36_BSTCVRT_SLOPE_MASK,
+					0x75 << CS35L36_BSTCVRT_SLOPE_SHIFT);
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_SLOPE_LBST,
+					CS35L36_BSTCVRT_LBSTVAL_MASK, 0x00);
+		break;
+	case 1200: /* 1.2 uH */
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_SLOPE_LBST,
+					CS35L36_BSTCVRT_SLOPE_MASK,
+					0x6B << CS35L36_BSTCVRT_SLOPE_SHIFT);
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_SLOPE_LBST,
+					CS35L36_BSTCVRT_LBSTVAL_MASK, 0x01);
+		break;
+	default:
+		dev_err(cs35l36->dev, "%s Invalid Inductor Value %d uH\n",
+			__func__, inductor);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cs35l36_component_probe(struct snd_soc_component *component)
+{
+	struct cs35l36_private *cs35l36 =
+			snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	if (cs35l36->pdata.sclk_frc)
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_ASP_TX_PIN_CTRL,
+				CS35L36_SCLK_FRC_MASK,
+				cs35l36->pdata.sclk_frc <<
+				CS35L36_SCLK_FRC_SHIFT);
+
+	if (cs35l36->pdata.lrclk_frc)
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_ASP_RATE_CTRL,
+				CS35L36_LRCLK_FRC_MASK,
+				cs35l36->pdata.lrclk_frc <<
+				CS35L36_LRCLK_FRC_SHIFT);
+
+	if (cs35l36->rev_id == CS35L36_REV_A0) {
+		if (cs35l36->pdata.dcm_mode) {
+			regmap_update_bits(cs35l36->regmap,
+						CS35L36_BSTCVRT_DCM_CTRL,
+						CS35L36_DCM_AUTO_MASK,
+						CS35L36_DCM_AUTO_MASK);
+			regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				     CS35L36_TEST_UNLOCK1);
+			regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				     CS35L36_TEST_UNLOCK2);
+			regmap_update_bits(cs35l36->regmap,
+					CS35L36_BST_TST_MANUAL,
+					CS35L36_BST_MAN_IPKCOMP_MASK,
+					0 << CS35L36_BST_MAN_IPKCOMP_SHIFT);
+			regmap_update_bits(cs35l36->regmap,
+					CS35L36_BST_TST_MANUAL,
+					CS35L36_BST_MAN_IPKCOMP_EN_MASK,
+					CS35L36_BST_MAN_IPKCOMP_EN_MASK);
+			regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+					CS35L36_TEST_LOCK1);
+			regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+					CS35L36_TEST_LOCK2);
+		}
+	}
+
+	if (cs35l36->pdata.amp_gain_zc)
+		regmap_update_bits(cs35l36->regmap, CS35L36_AMP_GAIN_CTRL,
+					CS35L36_AMP_ZC_MASK,
+					CS35L36_AMP_ZC_MASK);
+
+	if (cs35l36->pdata.amp_pcm_inv)
+		regmap_update_bits(cs35l36->regmap, CS35L36_AMP_DIG_VOL_CTRL,
+					CS35L36_AMP_PCM_INV_MASK,
+					CS35L36_AMP_PCM_INV_MASK);
+
+	if (cs35l36->pdata.ldm_mode_sel)
+		regmap_update_bits(cs35l36->regmap, CS35L36_NG_CFG,
+					CS35L36_NG_AMP_EN_MASK,
+					CS35L36_NG_AMP_EN_MASK);
+
+	if (cs35l36->pdata.multi_amp_mode)
+		regmap_update_bits(cs35l36->regmap, CS35L36_ASP_TX_PIN_CTRL,
+					CS35L36_ASP_TX_HIZ_MASK,
+					CS35L36_ASP_TX_HIZ_MASK);
+
+	if (cs35l36->pdata.pdm_ldm_enter)
+		regmap_update_bits(cs35l36->regmap, CS35L36_DAC_MSM_CFG,
+					CS35L36_PDM_LDM_ENTER_MASK,
+					CS35L36_PDM_LDM_ENTER_MASK);
+
+	if (cs35l36->pdata.pdm_ldm_exit)
+		regmap_update_bits(cs35l36->regmap, CS35L36_DAC_MSM_CFG,
+					CS35L36_PDM_LDM_EXIT_MASK,
+					CS35L36_PDM_LDM_EXIT_MASK);
+
+	if (cs35l36->pdata.imon_pol_inv)
+		regmap_update_bits(cs35l36->regmap, CS35L36_VI_SPKMON_FILT,
+					CS35L36_IMON_POL_MASK, 0);
+
+	if (cs35l36->pdata.vmon_pol_inv)
+		regmap_update_bits(cs35l36->regmap, CS35L36_VI_SPKMON_FILT,
+					CS35L36_VMON_POL_MASK, 0);
+
+	if (cs35l36->pdata.bst_vctl)
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_VCTRL1,
+				CS35L35_BSTCVRT_CTL_MASK,
+				cs35l36->pdata.bst_vctl);
+
+	if (cs35l36->pdata.bst_vctl_sel)
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_VCTRL2,
+				CS35L35_BSTCVRT_CTL_SEL_MASK,
+				cs35l36->pdata.bst_vctl_sel);
+
+	if (cs35l36->pdata.bst_ipk)
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_PEAK_CUR,
+				CS35L36_BST_IPK_MASK,
+				cs35l36->pdata.bst_ipk);
+
+	if (cs35l36->pdata.boost_ind)
+		ret = cs35l36_boost_inductor(cs35l36, cs35l36->pdata.boost_ind);
+
+	if (cs35l36->pdata.temp_warn_thld)
+		regmap_update_bits(cs35l36->regmap, CS35L36_DTEMP_WARN_THLD,
+					CS35L36_TEMP_THLD_MASK,
+					cs35l36->pdata.temp_warn_thld);
+
+	/*
+	 * Rev B0 has 2 versions
+	 * L36 is 10V
+	 * L37 is 12V
+	 * If L36 we need to clamp some values for safety
+	 * after probe has setup dt values. We want to make
+	 * sure we dont miss any values set in probe
+	 */
+	if (cs35l36->chip_version == CS35L36_10V_L36) {
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_BSTCVRT_OVERVOLT_CTRL,
+				CS35L36_BST_OVP_THLD_MASK,
+				CS35L36_BST_OVP_THLD_11V);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_UNLOCK1);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+					CS35L36_TEST_UNLOCK2);
+		regmap_update_bits(cs35l36->regmap, CS35L36_BST_ANA2_TEST,
+					CS35L36_BST_OVP_TRIM_MASK,
+					CS35L36_BST_OVP_TRIM_11V <<
+					CS35L36_BST_OVP_TRIM_SHIFT);
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_VCTRL2,
+					CS35L36_BST_CTRL_LIM_MASK,
+					1 << CS35L36_BST_CTRL_LIM_SHIFT);
+		regmap_update_bits(cs35l36->regmap, CS35L36_BSTCVRT_VCTRL1,
+					CS35L35_BSTCVRT_CTL_MASK,
+					CS35L36_BST_CTRL_10V_CLAMP);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+					CS35L36_TEST_LOCK1);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+					CS35L36_TEST_LOCK2);
+	}
+
+	/*
+	 * RevA and B require the disabling of
+	 * SYNC_GLOBAL_OVR when GLOBAL_EN = 0.
+	 * Just turn it off from default
+	 */
+	regmap_update_bits(cs35l36->regmap, CS35L36_CTRL_OVRRIDE,
+				CS35L36_SYNC_GLOBAL_OVR_MASK,
+				0 << CS35L36_SYNC_GLOBAL_OVR_SHIFT);
+
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_component_dev_cs35l36 = {
+	.probe			= &cs35l36_component_probe,
+	.set_sysclk		= cs35l36_component_set_sysclk,
+	.dapm_widgets		= cs35l36_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs35l36_dapm_widgets),
+	.dapm_routes		= cs35l36_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(cs35l36_audio_map),
+	.controls		= cs35l36_aud_controls,
+	.num_controls		= ARRAY_SIZE(cs35l36_aud_controls),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static struct regmap_config cs35l36_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = CS35L36_PAC_PMEM_WORD1023,
+	.reg_defaults = cs35l36_reg,
+	.num_reg_defaults = ARRAY_SIZE(cs35l36_reg),
+	.volatile_reg = cs35l36_volatile_reg,
+	.readable_reg = cs35l36_readable_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static irqreturn_t cs35l36_irq(int irq, void *data)
+{
+	struct cs35l36_private *cs35l36 = data;
+	unsigned int status[4];
+	unsigned int masks[4];
+
+	/* ack the irq by reading all status registers */
+	regmap_bulk_read(cs35l36->regmap, CS35L36_INT1_STATUS,
+				status, ARRAY_SIZE(status));
+
+	regmap_bulk_read(cs35l36->regmap, CS35L36_INT1_MASK,
+				masks, ARRAY_SIZE(masks));
+
+	/* Check to see if unmasked bits are active */
+	if (!(status[0] & ~masks[0]) && !(status[1] & ~masks[1]) &&
+		!(status[2] & ~masks[2]) && !(status[3] & ~masks[3])) {
+		return IRQ_NONE;
+	}
+
+	/*
+	 * The following interrupts require a
+	 * protection release cycle to get the
+	 * speaker out of Safe-Mode.
+	 */
+	if (status[2] & CS35L36_AMP_SHORT_ERR) {
+		dev_crit(cs35l36->dev, "Amp short error\n");
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_AMP_SHORT_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_AMP_SHORT_ERR_RLS,
+				CS35L36_AMP_SHORT_ERR_RLS);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_AMP_SHORT_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+					CS35L36_INT3_STATUS,
+					CS35L36_AMP_SHORT_ERR,
+					CS35L36_AMP_SHORT_ERR);
+	}
+
+	if (status[0] & CS35L36_TEMP_WARN) {
+		dev_crit(cs35l36->dev, "Over temperature warning\n");
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_WARN_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_WARN_ERR_RLS,
+				CS35L36_TEMP_WARN_ERR_RLS);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_WARN_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+					CS35L36_INT1_STATUS,
+					CS35L36_TEMP_WARN,
+					CS35L36_TEMP_WARN);
+	}
+
+	if (status[0] & CS35L36_TEMP_ERR) {
+		dev_crit(cs35l36->dev, "Over temperature error\n");
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_ERR_RLS,
+				CS35L36_TEMP_ERR_RLS);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+					CS35L36_INT1_STATUS,
+					CS35L36_TEMP_ERR,
+					CS35L36_TEMP_ERR);
+	}
+
+	if (status[0] & CS35L36_BST_OVP_ERR) {
+		dev_crit(cs35l36->dev, "VBST Over Voltage error\n");
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_ERR_RLS,
+				CS35L36_TEMP_ERR_RLS);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_TEMP_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+					CS35L36_INT1_STATUS,
+					CS35L36_BST_OVP_ERR,
+					CS35L36_BST_OVP_ERR);
+	}
+
+	if (status[0] & CS35L36_BST_DCM_UVP_ERR) {
+		dev_crit(cs35l36->dev, "DCM VBST Under Voltage Error\n");
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_BST_UVP_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_BST_UVP_ERR_RLS,
+				CS35L36_BST_UVP_ERR_RLS);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_BST_UVP_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+					CS35L36_INT1_STATUS,
+					CS35L36_BST_DCM_UVP_ERR,
+					CS35L36_BST_DCM_UVP_ERR);
+	}
+
+	if (status[0] & CS35L36_BST_SHORT_ERR) {
+		dev_crit(cs35l36->dev, "LBST SHORT error!\n");
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_BST_SHORT_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_BST_SHORT_ERR_RLS,
+				CS35L36_BST_SHORT_ERR_RLS);
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PROTECT_REL_ERR,
+				CS35L36_BST_SHORT_ERR_RLS, 0);
+		regmap_update_bits(cs35l36->regmap,
+					CS35L36_INT1_STATUS,
+					CS35L36_BST_SHORT_ERR,
+					CS35L36_BST_SHORT_ERR);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int cs35l36_handle_of_data(struct i2c_client *i2c_client,
+				struct cs35l36_platform_data *pdata)
+{
+	struct device_node *np = i2c_client->dev.of_node;
+	struct irq_cfg *irq_gpio_config = &pdata->irq_config;
+	struct vpbr_cfg *vpbr_config = &pdata->vpbr_config;
+	struct device_node *irq_gpio, *vpbr_node;
+	unsigned int val;
+	int ret;
+
+	if (!np)
+		return 0;
+
+	ret = of_property_read_u32(np, "cirrus,boost-ctl-millivolt", &val);
+	if (!ret) {
+		if (val < 2550 || val > 12000) {
+			dev_err(&i2c_client->dev,
+				"Invalid Boost Voltage %d mV\n", val);
+			return -EINVAL;
+		}
+		pdata->bst_vctl = (((val - 2550) / 100) + 1) << 1;
+	} else {
+		dev_err(&i2c_client->dev,
+			"Unable to find required parameter 'cirrus,boost-ctl-millivolt'");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "cirrus,boost-ctl-select", &val);
+	if (!ret)
+		pdata->bst_vctl_sel = val | CS35L36_VALID_PDATA;
+
+	ret = of_property_read_u32(np, "cirrus,boost-peak-milliamp", &val);
+	if (!ret) {
+		if (val < 1600 || val > 4500) {
+			dev_err(&i2c_client->dev,
+				"Invalid Boost Peak Current %u mA\n", val);
+			return -EINVAL;
+		}
+
+		pdata->bst_ipk = (val - 1600) / 50;
+	} else {
+		dev_err(&i2c_client->dev,
+			"Unable to find required parameter 'cirrus,boost-peak-milliamp'");
+		return -EINVAL;
+	}
+
+	pdata->multi_amp_mode = of_property_read_bool(np,
+					"cirrus,multi-amp-mode");
+
+	pdata->sclk_frc = of_property_read_bool(np,
+					"cirrus,sclk-force-output");
+
+	pdata->lrclk_frc = of_property_read_bool(np,
+					"cirrus,lrclk-force-output");
+
+	pdata->dcm_mode = of_property_read_bool(np,
+					"cirrus,dcm-mode-enable");
+
+	pdata->amp_gain_zc = of_property_read_bool(np,
+					"cirrus,amp-gain-zc");
+
+	pdata->amp_pcm_inv = of_property_read_bool(np,
+					"cirrus,amp-pcm-inv");
+
+	ret = of_property_read_u32(np, "cirrus,ldm-mode-select", &val);
+	if (!ret)
+		pdata->ldm_mode_sel = val;
+
+	pdata->pdm_ldm_exit = of_property_read_bool(np,
+					"cirrus,pdm-ldm-exit");
+
+	pdata->pdm_ldm_enter = of_property_read_bool(np,
+					"cirrus,pdm-ldm-enter");
+
+	pdata->imon_pol_inv = of_property_read_bool(np,
+					"cirrus,imon-pol-inv");
+
+	pdata->vmon_pol_inv = of_property_read_bool(np,
+					"cirrus,vmon-pol-inv");
+
+	if (of_property_read_u32(np, "cirrus,temp-warn-threshold", &val) >= 0)
+		pdata->temp_warn_thld = val | CS35L36_VALID_PDATA;
+
+	if (of_property_read_u32(np, "cirrus,boost-ind-nanohenry", &val) >= 0) {
+		pdata->boost_ind = val;
+	} else {
+		dev_err(&i2c_client->dev, "Inductor not specified.\n");
+		return -EINVAL;
+	}
+
+	/* VPBR Config */
+	vpbr_node = of_get_child_by_name(np, "cirrus,vpbr-config");
+	vpbr_config->is_present = vpbr_node ? true : false;
+	if (vpbr_config->is_present) {
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-en",
+					&val) >= 0)
+			vpbr_config->vpbr_en = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-thld",
+					&val) >= 0)
+			vpbr_config->vpbr_thld = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-atk-rate",
+					&val) >= 0)
+			vpbr_config->vpbr_atk_rate = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-atk-vol",
+					&val) >= 0)
+			vpbr_config->vpbr_atk_vol = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-max-attn",
+					&val) >= 0)
+			vpbr_config->vpbr_max_attn = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-wait",
+					&val) >= 0)
+			vpbr_config->vpbr_wait = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-rel-rate",
+					&val) >= 0)
+			vpbr_config->vpbr_rel_rate = val;
+		if (of_property_read_u32(vpbr_node, "cirrus,vpbr-mute-en",
+					&val) >= 0)
+			vpbr_config->vpbr_mute_en = val;
+	}
+	of_node_put(vpbr_node);
+
+	/* INT/GPIO Pin Config */
+	irq_gpio = of_get_child_by_name(np, "cirrus,irq-config");
+	irq_gpio_config->is_present = irq_gpio ? true : false;
+	if (irq_gpio_config->is_present) {
+		if (of_property_read_u32(irq_gpio, "cirrus,irq-drive-select",
+					&val) >= 0)
+			irq_gpio_config->irq_drv_sel = val;
+		if (of_property_read_u32(irq_gpio, "cirrus,irq-polarity",
+					&val) >= 0)
+			irq_gpio_config->irq_pol = val;
+		if (of_property_read_u32(irq_gpio, "cirrus,irq-gpio-select",
+					&val) >= 0)
+			irq_gpio_config->irq_gpio_sel = val;
+		if (of_property_read_u32(irq_gpio, "cirrus,irq-output-enable",
+					&val) >= 0)
+			irq_gpio_config->irq_out_en = val;
+		if (of_property_read_u32(irq_gpio, "cirrus,irq-src-select",
+					&val) >= 0)
+			irq_gpio_config->irq_src_sel = val;
+	}
+	of_node_put(irq_gpio);
+
+	return 0;
+}
+
+static int cs35l36_pac(struct cs35l36_private *cs35l36)
+{
+	int ret, count;
+	unsigned int val;
+
+	if (cs35l36->rev_id == CS35L36_REV_B0) {
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_UNLOCK1);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_UNLOCK2);
+
+		usleep_range(9500, 10500);
+
+		regmap_write(cs35l36->regmap, CS35L36_PAC_CTL1,
+				CS35L36_PAC_RESET);
+		regmap_write(cs35l36->regmap, CS35L36_PAC_CTL3,
+				CS35L36_PAC_MEM_ACCESS);
+		regmap_write(cs35l36->regmap, CS35L36_PAC_PMEM_WORD0,
+				CS35L36_B0_PAC_PATCH);
+
+		regmap_write(cs35l36->regmap, CS35L36_PAC_CTL3,
+				CS35L36_PAC_MEM_ACCESS_CLR);
+		regmap_write(cs35l36->regmap, CS35L36_PAC_CTL1,
+				CS35L36_PAC_ENABLE_MASK);
+
+		usleep_range(9500, 10500);
+
+		ret = regmap_read(cs35l36->regmap, CS35L36_INT4_STATUS, &val);
+		if (ret < 0) {
+			dev_err(cs35l36->dev, "Failed to read int4_status %d\n",
+				ret);
+			return ret;
+		}
+
+		count = 0;
+		while (!(val & CS35L36_MCU_CONFIG_CLR)) {
+			usleep_range(100, 200);
+			count++;
+
+			ret = regmap_read(cs35l36->regmap, CS35L36_INT4_STATUS,
+					  &val);
+			if (ret < 0) {
+				dev_err(cs35l36->dev, "Failed to read int4_status %d\n",
+					ret);
+				return ret;
+			}
+
+			if (count >= 100)
+				return -EINVAL;
+		}
+
+		regmap_write(cs35l36->regmap, CS35L36_INT4_STATUS,
+				CS35L36_MCU_CONFIG_CLR);
+		regmap_update_bits(cs35l36->regmap, CS35L36_PAC_CTL1,
+					CS35L36_PAC_ENABLE_MASK, 0);
+
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_LOCK1);
+		regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
+				CS35L36_TEST_LOCK2);
+	}
+	return 0;
+}
+
+static int cs35l36_vpbr_config(struct cs35l36_private *cs35l36)
+{
+	struct cs35l36_platform_data *pdata = &cs35l36->pdata;
+	struct vpbr_cfg *vpbr_config = &pdata->vpbr_config;
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_PWR_CTRL3,
+				   CS35L36_VPBR_EN_MASK,
+				   vpbr_config->vpbr_en <<
+				   CS35L36_VPBR_EN_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_THLD_MASK,
+				   vpbr_config->vpbr_thld <<
+				   CS35L36_VPBR_THLD_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_MAX_ATTN_MASK,
+				   vpbr_config->vpbr_max_attn <<
+				   CS35L36_VPBR_MAX_ATTN_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_ATK_VOL_MASK,
+				   vpbr_config->vpbr_atk_vol <<
+				   CS35L36_VPBR_ATK_VOL_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_ATK_RATE_MASK,
+				   vpbr_config->vpbr_atk_rate <<
+				   CS35L36_VPBR_ATK_RATE_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_WAIT_MASK,
+				   vpbr_config->vpbr_wait <<
+				   CS35L36_VPBR_WAIT_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_REL_RATE_MASK,
+				   vpbr_config->vpbr_rel_rate <<
+				   CS35L36_VPBR_REL_RATE_SHIFT);
+
+	regmap_update_bits(cs35l36->regmap, CS35L36_VPBR_CFG,
+				   CS35L36_VPBR_MUTE_EN_MASK,
+				   vpbr_config->vpbr_mute_en <<
+				   CS35L36_VPBR_MUTE_EN_SHIFT);
+
+	return 0;
+}
+
+static int cs35l36_irq_gpio_config(struct cs35l36_private *cs35l36)
+{
+	struct cs35l36_platform_data *pdata = &cs35l36->pdata;
+	struct irq_cfg *irq_config = &pdata->irq_config;
+	int irq_polarity;
+
+	/* setup the Interrupt Pin (INT | GPIO) */
+	regmap_update_bits(cs35l36->regmap, CS35L36_PAD_INTERFACE,
+				CS35L36_INT_OUTPUT_EN_MASK,
+				irq_config->irq_out_en);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PAD_INTERFACE,
+				CS35L36_INT_GPIO_SEL_MASK,
+				irq_config->irq_gpio_sel <<
+				CS35L36_INT_GPIO_SEL_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PAD_INTERFACE,
+				CS35L36_INT_POL_SEL_MASK,
+				irq_config->irq_pol <<
+				CS35L36_INT_POL_SEL_SHIFT);
+	if (cs35l36->rev_id == CS35L36_REV_A0)
+		regmap_update_bits(cs35l36->regmap,
+				CS35L36_PAD_INTERFACE,
+				CS35L36_IRQ_SRC_MASK,
+				irq_config->irq_src_sel <<
+				CS35L36_IRQ_SRC_SHIFT);
+	regmap_update_bits(cs35l36->regmap, CS35L36_PAD_INTERFACE,
+				CS35L36_INT_DRV_SEL_MASK,
+				irq_config->irq_drv_sel <<
+				CS35L36_INT_DRV_SEL_SHIFT);
+
+	if (irq_config->irq_pol)
+		irq_polarity = IRQF_TRIGGER_HIGH;
+	else
+		irq_polarity = IRQF_TRIGGER_LOW;
+
+	return irq_polarity;
+}
+
+static const struct reg_sequence cs35l36_pac_int_patch[] = {
+	{ CS35L36_TESTKEY_CTRL,		CS35L36_TEST_UNLOCK1 },
+	{ CS35L36_TESTKEY_CTRL,		CS35L36_TEST_UNLOCK2 },
+	{ CS35L36_CTRL_OVRRIDE,		0x00000000 },
+	{ CS35L36_PAC_INT0_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT1_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT2_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT3_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT4_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT5_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT6_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT7_CTRL,	0x00860001 },
+	{ CS35L36_PAC_INT_FLUSH_CTRL,	0x000000FF },
+	{ CS35L36_TESTKEY_CTRL,		CS35L36_TEST_LOCK1 },
+	{ CS35L36_TESTKEY_CTRL,		CS35L36_TEST_LOCK2 },
+};
+
+static const struct reg_sequence cs35l36_reva0_errata_patch[] = {
+	{ CS35L36_TESTKEY_CTRL,	CS35L36_TEST_UNLOCK1 },
+	{ CS35L36_TESTKEY_CTRL, CS35L36_TEST_UNLOCK2 },
+	{ CS35L36_OTP_CTRL1,	0x00002060 },
+	{ CS35L36_OTP_CTRL2,	0x00000001 },
+	{ CS35L36_OTP_CTRL1,	0x00002460 },
+	{ CS35L36_OTP_CTRL2,	0x00000001 },
+	{ 0x00002088,		0x012A1838 },
+	{ 0x00003014,		0x0100EE0E },
+	{ 0x00003008,		0x0008184A },
+	{ 0x00007418,		0x509001C8 },
+	{ 0x00007064,		0x0929A800 },
+	{ 0x00002D10,		0x0002C01C },
+	{ 0x0000410C,		0x00000A11 },
+	{ 0x00006E08,		0x8B19140C },
+	{ 0x00006454,		0x0300000A },
+	{ CS35L36_AMP_NG_CTRL,	0x000020EF },
+	{ 0x00007E34,		0x0000000E },
+	{ 0x0000410C,		0x00000A11 },
+	{ 0x00007410,		0x20514B00 },
+	{ CS35L36_TESTKEY_CTRL,	CS35L36_TEST_LOCK1 },
+	{ CS35L36_TESTKEY_CTRL, CS35L36_TEST_LOCK2 },
+};
+
+static const struct reg_sequence cs35l36_revb0_errata_patch[] = {
+	{ CS35L36_TESTKEY_CTRL,	CS35L36_TEST_UNLOCK1 },
+	{ CS35L36_TESTKEY_CTRL, CS35L36_TEST_UNLOCK2 },
+	{ 0x00007064,		0x0929A800 },
+	{ 0x00007850,		0x00002FA9 },
+	{ 0x00007854,		0x0003F1D5 },
+	{ 0x00007858,		0x0003F5E3 },
+	{ 0x0000785C,		0x00001137 },
+	{ 0x00007860,		0x0001A7A5 },
+	{ 0x00007864,		0x0002F16A },
+	{ 0x00007868,		0x00003E21 },
+	{ 0x00007848,		0x00000001 },
+	{ 0x00003854,		0x05180240 },
+	{ 0x00007418,		0x509001C8 },
+	{ 0x0000394C,		0x028764BD },
+	{ CS35L36_TESTKEY_CTRL,	CS35L36_TEST_LOCK1 },
+	{ CS35L36_TESTKEY_CTRL, CS35L36_TEST_LOCK2 },
+};
+
+static int cs35l36_i2c_probe(struct i2c_client *i2c_client,
+			      const struct i2c_device_id *id)
+{
+	struct cs35l36_private *cs35l36;
+	struct device *dev = &i2c_client->dev;
+	struct cs35l36_platform_data *pdata = dev_get_platdata(dev);
+
+	int i;
+	int ret;
+	u32 reg_id, reg_revid, l37_id_reg;
+	int irq_pol = IRQF_TRIGGER_HIGH;
+
+	cs35l36 = devm_kzalloc(dev, sizeof(struct cs35l36_private), GFP_KERNEL);
+	if (!cs35l36)
+		return -ENOMEM;
+
+	cs35l36->dev = dev;
+
+	i2c_set_clientdata(i2c_client, cs35l36);
+	cs35l36->regmap = devm_regmap_init_i2c(i2c_client, &cs35l36_regmap);
+	if (IS_ERR(cs35l36->regmap)) {
+		ret = PTR_ERR(cs35l36->regmap);
+		dev_err(dev, "regmap_init() failed: %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cs35l36_supplies); i++)
+		cs35l36->supplies[i].supply = cs35l36_supplies[i];
+	cs35l36->num_supplies = ARRAY_SIZE(cs35l36_supplies);
+
+	ret = devm_regulator_bulk_get(dev, cs35l36->num_supplies,
+					cs35l36->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to request core supplies: %d\n", ret);
+		return ret;
+	}
+
+	if (pdata)
+		cs35l36->pdata = *pdata;
+	else {
+		pdata = devm_kzalloc(dev, sizeof(struct cs35l36_platform_data),
+				     GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		if (i2c_client->dev.of_node) {
+			ret = cs35l36_handle_of_data(i2c_client, pdata);
+			if (ret != 0)
+				return ret;
+
+		}
+		cs35l36->pdata = *pdata;
+	}
+
+	ret = regulator_bulk_enable(cs35l36->num_supplies,
+					cs35l36->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* returning NULL can be an option if in stereo mode */
+	cs35l36->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(cs35l36->reset_gpio)) {
+		ret = PTR_ERR(cs35l36->reset_gpio);
+		cs35l36->reset_gpio = NULL;
+		if (ret == -EBUSY)
+			dev_info(dev,
+				 "Reset line busy, assuming shared reset\n");
+		else {
+			dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
+			goto err;
+		}
+	}
+	if (cs35l36->reset_gpio)
+		gpiod_set_value_cansleep(cs35l36->reset_gpio, 1);
+
+	usleep_range(2000, 2100);
+
+	/* initialize amplifier */
+	ret = regmap_read(cs35l36->regmap, CS35L36_SW_RESET, &reg_id);
+	if (ret < 0) {
+		dev_err(dev, "Get Device ID failed %d\n", ret);
+		goto err;
+	}
+
+	if (reg_id != CS35L36_CHIP_ID) {
+		dev_err(dev, "Device ID (%X). Expected ID %X\n",
+			reg_id, CS35L36_CHIP_ID);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = regmap_read(cs35l36->regmap, CS35L36_REV_ID, &reg_revid);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "Get Revision ID failed %d\n", ret);
+		goto err;
+	}
+
+	cs35l36->rev_id = reg_revid >> 8;
+
+	ret = regmap_read(cs35l36->regmap, CS35L36_OTP_MEM30, &l37_id_reg);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "Failed to read otp_id Register %d\n",
+			ret);
+		return ret;
+	}
+
+	if ((l37_id_reg & CS35L36_OTP_REV_MASK) == CS35L36_OTP_REV_L37)
+		cs35l36->chip_version = CS35L36_12V_L37;
+	else
+		cs35l36->chip_version = CS35L36_10V_L36;
+
+	switch (cs35l36->rev_id) {
+	case CS35L36_REV_A0:
+		ret = regmap_register_patch(cs35l36->regmap,
+				cs35l36_reva0_errata_patch,
+				ARRAY_SIZE(cs35l36_reva0_errata_patch));
+		if (ret < 0) {
+			dev_err(dev, "Failed to apply A0 errata patch %d\n",
+					ret);
+			goto err;
+		}
+		ret = regmap_register_patch(cs35l36->regmap,
+					cs35l36_pac_int_patch,
+					ARRAY_SIZE(cs35l36_pac_int_patch));
+		if (ret < 0) {
+			dev_err(dev, "Failed to apply A0PAC errata patch %d\n",
+					ret);
+			goto err;
+		}
+		break;
+	case CS35L36_REV_B0:
+		ret = cs35l36_pac(cs35l36);
+		if (ret < 0) {
+			dev_err(dev, "Failed to Trim OTP %d\n", ret);
+			goto err;
+		}
+
+		ret = regmap_register_patch(cs35l36->regmap,
+					cs35l36_revb0_errata_patch,
+					ARRAY_SIZE(cs35l36_revb0_errata_patch));
+		if (ret < 0) {
+			dev_err(dev, "Failed to apply B0 errata patch %d\n",
+					ret);
+			goto err;
+		}
+		break;
+	}
+
+	if (pdata->vpbr_config.is_present)
+		cs35l36_vpbr_config(cs35l36);
+
+	if (pdata->irq_config.is_present)
+		irq_pol = cs35l36_irq_gpio_config(cs35l36);
+
+	ret = devm_request_threaded_irq(dev, i2c_client->irq, NULL, cs35l36_irq,
+					IRQF_ONESHOT |
+					irq_pol,
+					"cs35l36", cs35l36);
+
+	if (ret != 0) {
+		dev_err(dev, "Failed to request IRQ: %d\n", ret);
+		goto err;
+	}
+
+	/* Set interrupt masks for critical errors */
+	regmap_write(cs35l36->regmap, CS35L36_INT1_MASK,
+			CS35L36_INT1_MASK_DEFAULT);
+	regmap_write(cs35l36->regmap, CS35L36_INT3_MASK,
+			CS35L36_INT3_MASK_DEFAULT);
+
+	dev_info(&i2c_client->dev,
+			"Cirrus Logic CS35L%d, Revision: %02X\n",
+			cs35l36->chip_version, reg_revid >> 8);
+
+	ret =  snd_soc_register_component(dev, &soc_component_dev_cs35l36,
+					  cs35l36_dai, ARRAY_SIZE(cs35l36_dai));
+	if (ret < 0) {
+		dev_err(dev, "%s: Register component failed %d\n", __func__,
+			ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	regulator_bulk_disable(cs35l36->num_supplies, cs35l36->supplies);
+	gpiod_set_value_cansleep(cs35l36->reset_gpio, 0);
+	return ret;
+}
+
+static int cs35l36_i2c_remove(struct i2c_client *client)
+{
+	struct cs35l36_private *cs35l36 = i2c_get_clientdata(client);
+
+	/* Reset interrupt masks for device removal */
+	regmap_write(cs35l36->regmap, CS35L36_INT1_MASK,
+			CS35L36_INT1_MASK_RESET);
+	regmap_write(cs35l36->regmap, CS35L36_INT3_MASK,
+			CS35L36_INT3_MASK_RESET);
+
+	if (cs35l36->reset_gpio)
+		gpiod_set_value_cansleep(cs35l36->reset_gpio, 0);
+
+	regulator_bulk_disable(cs35l36->num_supplies, cs35l36->supplies);
+
+	snd_soc_unregister_component(&client->dev);
+
+	return 0;
+}
+static const struct of_device_id cs35l36_of_match[] = {
+	{.compatible = "cirrus,cs35l36"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs35l36_of_match);
+
+static const struct i2c_device_id cs35l36_id[] = {
+	{"cs35l36", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cs35l36_id);
+
+static struct i2c_driver cs35l36_i2c_driver = {
+	.driver = {
+		.name = "cs35l36",
+		.of_match_table = cs35l36_of_match,
+	},
+	.id_table = cs35l36_id,
+	.probe = cs35l36_i2c_probe,
+	.remove = cs35l36_i2c_remove,
+};
+module_i2c_driver(cs35l36_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS35L36 driver");
+MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l36.h b/sound/soc/codecs/cs35l36.h
new file mode 100644
index 0000000..5e1dc84
--- /dev/null
+++ b/sound/soc/codecs/cs35l36.h
@@ -0,0 +1,451 @@
+/*
+ * cs35l36.h -- CS35L36 ALSA SoC audio driver
+ *
+ * Copyright 2018 Cirrus Logic, Inc.
+ *
+ * Author: James Schulman <james.schulman@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __CS35L36_H__
+#define __CS35L36_H__
+
+#include <linux/regmap.h>
+
+#define CS35L36_FIRSTREG		0x00000000
+#define CS35L36_LASTREG			0x00E037FC
+#define CS35L36_SW_RESET		0x00000000
+#define CS35L36_SW_REV			0x00000004
+#define CS35L36_HW_REV			0x00000008
+#define CS35L36_TESTKEY_CTRL		0x00000020
+#define CS35L36_USERKEY_CTL		0x00000024
+#define CS35L36_OTP_MEM30		0x00000478
+#define CS35L36_OTP_CTRL1		0x00000500
+#define CS35L36_OTP_CTRL2		0x00000504
+#define CS35L36_OTP_CTRL3		0x00000508
+#define CS35L36_OTP_CTRL4		0x0000050C
+#define CS35L36_OTP_CTRL5		0x00000510
+#define CS35L36_PAC_CTL1		0x00000C00
+#define CS35L36_PAC_CTL2		0x00000C04
+#define CS35L36_PAC_CTL3		0x00000C08
+#define CS35L36_DEVICE_ID		0x00002004
+#define CS35L36_FAB_ID			0x00002008
+#define CS35L36_REV_ID			0x0000200C
+#define CS35L36_PWR_CTRL1		0x00002014
+#define CS35L36_PWR_CTRL2		0x00002018
+#define CS35L36_PWR_CTRL3		0x0000201C
+#define CS35L36_CTRL_OVRRIDE		0x00002020
+#define CS35L36_AMP_OUT_MUTE		0x00002024
+#define CS35L36_OTP_TRIM_STATUS		0x00002028
+#define CS35L36_DISCH_FILT		0x0000202C
+#define CS35L36_OSC_TRIM		0x00002030
+#define CS35L36_PROTECT_REL_ERR		0x00002034
+#define CS35L36_PAD_INTERFACE		0x00002400
+#define CS35L36_PLL_CLK_CTRL		0x00002C04
+#define CS35L36_GLOBAL_CLK_CTRL		0x00002C0C
+#define CS35L36_ADC_CLK_CTRL		0x00002C10
+#define CS35L36_SWIRE_CLK_CTRL		0x00002C14
+#define CS35L36_SP_SCLK_CLK_CTRL	0x00002D00
+#define CS35L36_TST_FS_MON0		0x00002D10
+#define CS35L36_PLL_LOOP_PARAMS		0x00003008
+#define CS35L36_DCO_CTRL		0x00003010
+#define CS35L36_MISC_CTRL		0x00003014
+#define CS35L36_MDSYNC_EN		0x00003404
+#define CS35L36_MDSYNC_TX_ID		0x00003408
+#define CS35L36_MDSYNC_PWR_CTRL		0x0000340C
+#define CS35L36_MDSYNC_DATA_TX		0x00003410
+#define CS35L36_MDSYNC_TX_STATUS	0x0000341C
+#define CS35L36_MDSYNC_RX_STATUS	0x00003420
+#define CS35L36_MDSYNC_ERR_STATUS	0x00003424
+#define CS35L36_BSTCVRT_VCTRL1		0x00003800
+#define CS35L36_BSTCVRT_VCTRL2		0x00003804
+#define CS35L36_BSTCVRT_PEAK_CUR	0x00003808
+#define CS35L36_BSTCVRT_SFT_RAMP	0x0000380C
+#define CS35L36_BSTCVRT_COEFF		0x00003810
+#define CS35L36_BSTCVRT_SLOPE_LBST	0x00003814
+#define CS35L36_BSTCVRT_SW_FREQ		0x00003818
+#define CS35L36_BSTCVRT_DCM_CTRL	0x0000381C
+#define CS35L36_BSTCVRT_DCM_MODE_FORCE	0x00003820
+#define CS35L36_BSTCVRT_OVERVOLT_CTRL	0x00003830
+#define CS35L36_BST_TST_MANUAL		0x0000393C
+#define CS35L36_BST_ANA2_TEST		0x0000394C
+#define CS35L36_VPI_LIMIT_MODE		0x00003C04
+#define CS35L36_VPI_LIMIT_MINMAX	0x00003C08
+#define CS35L36_VPI_VP_THLD		0x00003C0C
+#define CS35L36_VPI_TRACK_CTRL		0x00003C10
+#define CS35L36_VPI_TRIG_MODE_CTRL	0x00003C14
+#define CS35L36_VPI_TRIG_STEPS		0x00003C18
+#define CS35L36_VI_SPKMON_FILT		0x00004004
+#define CS35L36_VI_SPKMON_GAIN		0x00004008
+#define CS35L36_VI_SPKMON_IP_SEL	0x00004100
+#define CS35L36_DTEMP_WARN_THLD		0x00004220
+#define CS35L36_DTEMP_STATUS		0x00004300
+#define CS35L36_VPVBST_FS_SEL		0x00004400
+#define CS35L36_VPVBST_VP_CTRL		0x00004440
+#define CS35L36_VPVBST_VBST_CTRL	0x00004444
+#define CS35L36_ASP_TX_PIN_CTRL		0x00004800
+#define CS35L36_ASP_RATE_CTRL		0x00004804
+#define CS35L36_ASP_FORMAT		0x00004808
+#define CS35L36_ASP_FRAME_CTRL		0x00004818
+#define CS35L36_ASP_TX1_TX2_SLOT	0x0000481C
+#define CS35L36_ASP_TX3_TX4_SLOT	0x00004820
+#define CS35L36_ASP_TX5_TX6_SLOT	0x00004824
+#define CS35L36_ASP_TX7_TX8_SLOT	0x00004828
+#define CS35L36_ASP_RX1_SLOT		0x0000482C
+#define CS35L36_ASP_RX_TX_EN		0x0000483C
+#define CS35L36_ASP_RX1_SEL		0x00004C00
+#define CS35L36_ASP_TX1_SEL		0x00004C20
+#define CS35L36_ASP_TX2_SEL		0x00004C24
+#define CS35L36_ASP_TX3_SEL		0x00004C28
+#define CS35L36_ASP_TX4_SEL		0x00004C2C
+#define CS35L36_ASP_TX5_SEL		0x00004C30
+#define CS35L36_ASP_TX6_SEL		0x00004C34
+#define CS35L36_SWIRE_P1_TX1_SEL	0x00004C40
+#define CS35L36_SWIRE_P1_TX2_SEL	0x00004C44
+#define CS35L36_SWIRE_P2_TX1_SEL	0x00004C60
+#define CS35L36_SWIRE_P2_TX2_SEL	0x00004C64
+#define CS35L36_SWIRE_P2_TX3_SEL	0x00004C68
+#define CS35L36_SWIRE_DP1_FIFO_CFG	0x00005000
+#define CS35L36_SWIRE_DP2_FIFO_CFG	0x00005004
+#define CS35L36_SWIRE_DP3_FIFO_CFG	0x00005008
+#define CS35L36_SWIRE_PCM_RX_DATA	0x0000500C
+#define CS35L36_SWIRE_FS_SEL		0x00005010
+#define CS35L36_SPARE_CP_BITS		0x00005C00
+#define CS35L36_AMP_DIG_VOL_CTRL	0x00006000
+#define CS35L36_VPBR_CFG		0x00006404
+#define CS35L36_VBBR_CFG		0x00006408
+#define CS35L36_VPBR_STATUS		0x0000640C
+#define CS35L36_VBBR_STATUS		0x00006410
+#define CS35L36_OVERTEMP_CFG		0x00006414
+#define CS35L36_AMP_ERR_VOL		0x00006418
+#define CS35L36_CLASSH_CFG		0x00006800
+#define CS35L36_CLASSH_FET_DRV_CFG	0x00006804
+#define CS35L36_NG_CFG			0x00006808
+#define CS35L36_AMP_GAIN_CTRL		0x00006C04
+#define CS35L36_PWM_MOD_IO_CTRL		0x0000706C
+#define CS35L36_PWM_MOD_STATUS		0x00007070
+#define CS35L36_DAC_MSM_CFG		0x00007400
+#define CS35L36_AMP_SLOPE_CTRL		0x00007410
+#define CS35L36_AMP_PDM_VOLUME		0x00007E04
+#define CS35L36_AMP_PDM_RATE_CTRL	0x00007E08
+#define CS35L36_PDM_CH_SEL		0x00007E10
+#define CS35L36_AMP_NG_CTRL		0x00007E14
+#define CS35L36_PDM_HIGHFILT_CTRL	0x00007E3C
+#define CS35L36_INT1_STATUS		0x00D00000
+#define CS35L36_INT2_STATUS		0x00D00004
+#define CS35L36_INT3_STATUS		0x00D00008
+#define CS35L36_INT4_STATUS		0x00D0000C
+#define CS35L36_INT1_RAW_STATUS		0x00D00020
+#define CS35L36_INT2_RAW_STATUS		0x00D00024
+#define CS35L36_INT3_RAW_STATUS		0x00D00028
+#define CS35L36_INT4_RAW_STATUS		0x00D0002C
+#define CS35L36_INT1_MASK		0x00D00040
+#define CS35L36_INT2_MASK		0x00D00044
+#define CS35L36_INT3_MASK		0x00D00048
+#define CS35L36_INT4_MASK		0x00D0004C
+#define CS35L36_INT1_EDGE_LVL_CTRL	0x00D00060
+#define CS35L36_INT3_EDGE_LVL_CTRL	0x00D00068
+#define CS35L36_PAC_INT_STATUS		0x00D00200
+#define CS35L36_PAC_INT_RAW_STATUS	0x00D00210
+#define CS35L36_PAC_INT_FLUSH_CTRL	0x00D00218
+#define CS35L36_PAC_INT0_CTRL		0x00D00220
+#define CS35L36_PAC_INT1_CTRL		0x00D00224
+#define CS35L36_PAC_INT2_CTRL		0x00D00228
+#define CS35L36_PAC_INT3_CTRL		0x00D0022C
+#define CS35L36_PAC_INT4_CTRL		0x00D00230
+#define CS35L36_PAC_INT5_CTRL		0x00D00234
+#define CS35L36_PAC_INT6_CTRL		0x00D00238
+#define CS35L36_PAC_INT7_CTRL		0x00D0023C
+#define CS35L36_PAC_PMEM_WORD0		0x00E02800
+#define CS35L36_PAC_PMEM_WORD1		0x00E02804
+#define CS35L36_PAC_PMEM_WORD1023	0x00E037FC
+
+#define CS35L36_MAX_CACHE_REG		0x00007E44
+#define CS35L36_INTPAC_REG_COUNT	25
+#define CS35L36_CHIP_ID			0x00035A36
+
+#define CS35L36_INT_OUTPUT_EN_MASK	0x01
+#define CS35L36_INT_GPIO_SEL_MASK	0x02
+#define CS35L36_INT_GPIO_SEL_SHIFT	1
+#define CS35L36_INT_POL_SEL_MASK	0x04
+#define CS35L36_INT_POL_SEL_SHIFT	2
+#define CS35L36_INT_DRV_SEL_MASK	0x20
+#define CS35L36_INT_DRV_SEL_SHIFT	5
+#define CS35L36_IRQ_SRC_MASK		0x08
+#define CS35L36_IRQ_SRC_SHIFT		3
+
+#define CS35L36_SCLK_MSTR_MASK		0x40
+#define CS35L36_SCLK_MSTR_SHIFT		6
+#define CS35L36_LRCLK_MSTR_MASK		0x01
+#define CS35L36_LRCLK_MSTR_SHIFT	0
+#define CS35L36_SCLK_INV_MASK		0x100
+#define CS35L36_SCLK_INV_SHIFT		8
+#define CS35L36_LRCLK_INV_MASK		0x04
+#define CS35L36_LRCLK_INV_SHIFT		2
+#define CS35L36_SCLK_FRC_MASK		0x80
+#define CS35L36_SCLK_FRC_SHIFT		7
+#define CS35L36_LRCLK_FRC_MASK		0x02
+#define CS35L36_LRCLK_FRC_SHIFT		1
+
+#define CS35L36_PDM_MODE_MASK		0x01
+#define CS35L36_PDM_MODE_SHIFT		0
+
+#define CS35L36_ASP_FMT_MASK		0x07
+#define CS35L36_ASP_FMT_SHIFT		0
+
+#define CS35L36_ASP_RX_WIDTH_MASK	0xFF0000
+#define CS35L36_ASP_RX_WIDTH_SHIFT	16
+#define CS35L36_ASP_TX_WIDTH_MASK	0xFF
+#define CS35L36_ASP_TX_WIDTH_SHIFT	0
+#define CS35L36_ASP_WIDTH_16		0x10
+#define CS35L36_ASP_WIDTH_24		0x18
+#define CS35L36_ASP_WIDTH_32		0x20
+
+#define CS35L36_ASP_RX1_SLOT_MASK	0x3F
+#define CS35L36_ASP_RX1_EN_MASK		0x00010000
+#define CS35L36_ASP_RX1_EN_SHIFT	16
+
+#define CS35L36_ASP_TX1_SLOT_MASK	0x3F
+#define CS35L36_ASP_TX2_SLOT_MASK	0x3F0000
+#define CS35L36_ASP_TX2_SLOT_SHIFT	16
+#define CS35L36_ASP_TX3_SLOT_MASK	0x3F
+#define CS35L36_ASP_TX4_SLOT_MASK	0x3F0000
+#define CS35L36_ASP_TX4_SLOT_SHIFT	16
+#define CS35L36_ASP_TX5_SLOT_MASK	0x3F
+#define CS35L36_ASP_TX6_SLOT_MASK	0x3F0000
+#define CS35L36_ASP_TX6_SLOT_SHIFT	16
+#define CS35L36_ASP_TX7_SLOT_MASK	0x3F
+#define CS35L36_ASP_TX8_SLOT_MASK	0x3F0000
+#define CS35L36_ASP_TX8_SLOT_SHIFT	16
+#define CS35L36_ASP_TX_HIZ_MASK		0x200000
+
+#define CS35L36_APS_TX_SEL_MASK		0x7F
+
+#define CS35L36_ASP_TX1_EN_MASK		0x01
+#define CS35L36_ASP_TX2_EN_MASK		0x02
+#define CS35L36_ASP_TX2_EN_SHIFT	1
+#define CS35L36_ASP_TX3_EN_MASK		0x04
+#define CS35L36_ASP_TX3_EN_SHIFT	2
+#define CS35L36_ASP_TX4_EN_MASK		0x08
+#define CS35L36_ASP_TX4_EN_SHIFT	3
+#define CS35L36_ASP_TX5_EN_MASK		0x10
+#define CS35L36_ASP_TX5_EN_SHIFT	4
+#define CS35L36_ASP_TX6_EN_MASK		0x20
+#define CS35L36_ASP_TX6_EN_SHIFT	5
+#define CS35L36_ASP_TX7_EN_MASK		0x40
+#define CS35L36_ASP_TX7_EN_SHIFT	6
+#define CS35L36_ASP_TX8_EN_MASK		0x80
+#define CS35L36_ASP_TX8_EN_SHIFT	7
+
+
+#define CS35L36_PLL_CLK_SEL_MASK	0x07
+#define CS35L36_PLL_CLK_SEL_SHIFT	0
+#define CS35L36_PLLSRC_SCLK		0
+#define CS35L36_PLLSRC_LRCLK		1
+#define CS35L36_PLLSRC_SELF		3
+#define CS35L36_PLLSRC_PDMCLK		4
+#define CS35L36_PLLSRC_MCLK		5
+#define CS35L36_PLLSRC_SWIRE		7
+#define CS35L36_REFCLK_FREQ_MASK	0x7E0
+#define CS35L36_REFCLK_FREQ_SHIFT	5
+#define CS35L36_PLL_OPENLOOP_MASK	0x800
+#define CS35L36_PLL_OPENLOOP_SHIFT	11
+#define CS35L36_PLL_REFCLK_EN_MASK	0x10
+#define CS35L36_PLL_REFCLK_EN_SHIFT	4
+
+
+#define CS35L36_GLOBAL_FS_MASK		0x1F
+#define CS35L36_GLOBAL_FS_SHIFT		0
+
+#define CS35L36_HPF_PCM_EN_MASK		0x800
+#define CS35L36_HPF_PCM_EN_SHIFT	15
+#define CS35L36_PCM_RX_SEL_MASK		0x7F
+#define CS35L36_PCM_RX_SEL_SHIFT	0
+
+#define CS35L36_PCM_RX_SEL_ZERO		0x00
+#define CS35L36_PCM_RX_SEL_PCM		0x08
+#define CS35L36_PCM_RX_SEL_SWIRE	0x10
+#define CS35L36_PCM_RX_SEL_DIAG		0x04
+
+#define CS35L36_GLOBAL_EN_MASK		0x01
+#define CS35L36_GLOBAL_EN_SHIFT		0x00
+
+#define CS35L36_AMP_PCM_INV_MASK	0x4000
+#define CS35L36_AMP_PCM_INV_SHIFT	14
+
+#define CS35L36_AMP_VOL_PCM_MASK	0x3FF8
+#define CS35L36_AMP_VOL_PCM_SHIFT	3
+#define CS35L36_DIGITAL_MUTE		0x04CF
+
+#define CS35L36_AMP_RAMP_MASK		0x0007
+#define CS35L36_AMP_RAMP_SHIFT		0
+
+#define CS35L36_AMP_MUTE_MASK		0x0010
+#define CS35L36_AMP_MUTE_SHIFT		4
+
+#define CS35L36_GLOBAL_RESYNC_FS1_MASK	0x00000200
+#define CS35L36_GLOBAL_RESYNC_FS2_MASK	0x00000400
+#define CS35L36_SYNC_GLOBAL_OVR_MASK	0x00000002
+#define CS35L36_SYNC_GLOBAL_OVR_SHIFT	1
+
+#define CS35L36_REFCLK_IN_MASK		0x00100000
+#define CS35L36_PLL_UNLOCK_MASK		0x00002000
+
+#define CS35L36_ASP_RX_UDF_MASK		0x00000040
+#define CS35L36_ASP_RX_OVF_MASK		0x00000080
+
+#define CS35L36_IMON_POL_MASK		0x02
+#define CS35L36_IMON_POL_SHIFT		1
+
+#define CS35L36_VMON_POL_MASK		0x01
+#define CS35L36_VMON_POL_SHIFT		0
+
+#define CS35L36_PDN_DONE		0x40
+#define CS35L36_PDN_DONE_SHIFT		6
+#define CS35L36_PUP_DONE		0x80
+#define CS35L36_PUP_DONE_SHIFT		7
+#define CS35L36_GLOBAL_EN_ASSRT		0x20
+#define CS35L36_PUP_DONE_IRQ_UNMASK	0x7F
+#define CS35L36_PUP_DONE_IRQ_MASK	0xBF
+
+#define CS35L36_FS1_WINDOW_MASK		0x000007FF
+#define CS35L36_FS2_WINDOW_MASK		0x00FFF800
+#define CS35L36_FS2_WINDOW_SHIFT	12
+
+#define CS35L36_PLL_FFL_IGAIN_MASK	0x0F
+#define CS35L36_PLL_IGAIN_MASK		0x3F0
+#define CS35L36_PLL_IGAIN_SHIFT		4
+#define CS35L36_PLL_IGAIN		0x04
+
+#define CS35L36_BST_EN_MASK		0x30
+#define CS35L36_BST_EN			0x02
+#define CS35L36_BST_DIS_VP		0x01
+#define CS35L36_BST_DIS_EXTN		0x00
+#define CS35L36_BST_EN_SHIFT		4
+#define CS35L36_BST_MAN_IPKCOMP_MASK	0x200
+#define CS35L36_BST_MAN_IPKCOMP_SHIFT	9
+
+#define CS35L36_BST_MAN_IPKCOMP_EN_MASK		0x100
+#define CS35L36_BST_MAN_IPKCOMP_EN_SHIFT	8
+
+#define CS35L36_BST_IPK_MASK		0x7F
+#define CS35L36_BST_OVP_THLD_MASK	0x3F
+#define CS35L36_BST_OVP_THLD_11V	0x10
+#define CS35L36_BST_OVP_TRIM_MASK	0x00078000
+#define CS35L36_BST_OVP_TRIM_SHIFT	15
+#define CS35L36_BST_OVP_TRIM_11V	0x0C
+#define CS35L36_BST_CTRL_LIM_MASK	0x04
+#define CS35L36_BST_CTRL_LIM_SHIFT	2
+#define CS35L36_BST_CTRL_10V_CLAMP	0x96
+
+#define CS35L36_NG_AMP_EN_MASK		0x3F00
+#define CS35L36_NG_AMP_EN_SHIFT		8
+#define CS35L36_NG_DELAY_MASK		0x70
+#define CS35L36_NG_DELAY_SHIFT		4
+#define CS35L36_AMP_ZC_MASK		0x400
+#define CS35L36_PDM_LDM_ENTER_MASK	0x08
+#define CS35L36_PDM_LDM_EXIT_MASK	0x10
+
+#define CS35L36_BSTCVRT_K1_MASK		0xFF
+#define CS35L36_BSTCVRT_K2_MASK		0xFF00
+#define CS35L36_BSTCVRT_K2_SHIFT	8
+#define CS35L36_BSTCVRT_SLOPE_MASK	0xFF00
+#define CS35L36_BSTCVRT_SLOPE_SHIFT	8
+#define CS35L36_BSTCVRT_CCMFREQ_MASK	0x0F
+#define CS35L36_BSTCVRT_LBSTVAL_MASK	0x03
+#define CS35L35_BSTCVRT_CTL_MASK	0xFF
+#define CS35L35_BSTCVRT_CTL_SEL_MASK	0x03
+#define CS35L36_DCM_AUTO_MASK		0x01
+
+#define CS35L36_INT1_MASK_DEFAULT	0xF9BA7FFF
+#define CS35L36_INT1_MASK_RESET		0xFFFFFFFF
+#define CS35L36_INT3_MASK_DEFAULT	0xFFFFEFFF
+#define CS35L36_INT3_MASK_RESET		0xFFFFFFFF
+
+
+#define CS35L36_AMP_SHORT_ERR		0x1000
+#define CS35L36_BST_SHORT_ERR		0x40000
+#define CS35L36_TEMP_WARN		0x2000000
+#define CS35L36_TEMP_ERR		0x4000000
+#define CS35L36_BST_OVP_ERR		0x10000
+#define CS35L36_BST_DCM_UVP_ERR		0x20000
+
+#define CS35L36_AMP_SHORT_ERR_RLS	0x02
+#define CS35L36_BST_SHORT_ERR_RLS	0x04
+#define CS35L36_BST_OVP_ERR_RLS		0x08
+#define CS35L36_BST_UVP_ERR_RLS		0x10
+#define CS35L36_TEMP_WARN_ERR_RLS	0x20
+#define CS35L36_TEMP_ERR_RLS		0x40
+#define CS35L36_TEMP_THLD_MASK		0x03
+
+#define CS35L36_REV_B0			0xb0
+#define CS35L36_REV_A0			0xa0
+#define CS35L36_B0_PAC_PATCH		0x00DD0102
+
+#define CS35L36_OTP_ECC_EN_MASK		0x400
+#define CS35L36_OTP_ECC_EN_SHIFT	10
+#define CS35L36_OTP_RUN_BOOT_MASK	0x01
+#define CS35L36_OTP_BOOT_DONE		0x2000000
+#define CS35L36_PAC_RESET_MASK		0x04
+#define CS35L36_PAC_RESET_SHIFT		2
+#define CS35L36_PAC_STALL_MASK		0x02
+#define CS35L36_PAC_STALL_SHIFT		1
+#define CS35L36_PAC_ENABLE_MASK		0x00000001
+#define CS35L36_PAC_MEM_ACCESS		0x01
+#define CS35L36_PAC_MEM_ACCESS_CLR	0
+#define CS35L36_SOFT_RESET		0x5AAA
+#define CS35L36_MCU_BOOT_COMPLETE	0x02
+#define CS35L36_MCU_CONFIG_UNMASK	0x00FEFFFF
+#define CS35L36_MCU_CONFIG_CLR		0x00010000
+#define CS35L36_MCU_CONFIG_MASK		0x00FFFFFF
+#define CS35L36_GPIO_INT_SEL_MASK	0x0000003B
+#define CS35L36_GPIO_INT_SEL_UNMASK	0x0000003A
+#define CS35L36_PAC_RESET		0x00000000
+#define CS35L36_OTP_REV_MASK		0x00FF0000
+#define CS35L36_OTP_REV_L37		0x00CC0000
+#define CS35L36_12V_L37			37
+#define CS35L36_10V_L36			36
+
+#define CS35L36_VPBR_EN_MASK		0x00001000
+#define CS35L36_VPBR_EN_SHIFT		12
+
+#define CS35L36_VPBR_THLD_MASK		0x0000001F
+#define CS35L36_VPBR_THLD_SHIFT		0
+#define CS35L36_VPBR_MAX_ATTN_MASK	0x00000F00
+#define CS35L36_VPBR_MAX_ATTN_SHIFT	8
+#define CS35L36_VPBR_ATK_VOL_MASK	0x0000F000
+#define CS35L36_VPBR_ATK_VOL_SHIFT	12
+#define CS35L36_VPBR_ATK_RATE_MASK	0x00070000
+#define CS35L36_VPBR_ATK_RATE_SHIFT	16
+#define CS35L36_VPBR_WAIT_MASK		0x00180000
+#define CS35L36_VPBR_WAIT_SHIFT		19
+#define CS35L36_VPBR_REL_RATE_MASK	0x00E00000
+#define CS35L36_VPBR_REL_RATE_SHIFT	21
+#define CS35L36_VPBR_MUTE_EN_MASK	0x01000000
+#define CS35L36_VPBR_MUTE_EN_SHIFT	24
+
+#define CS35L36_OSC_FREQ_TRIM_MASK	0x070
+#define CS35L36_OSC_TRIM_DONE		0x08
+
+#define CS35L36_TEST_UNLOCK1		0x00005555
+#define CS35L36_TEST_UNLOCK2		0x0000AAAA
+#define CS35L36_TEST_LOCK1		0x0000CCCC
+#define CS35L36_TEST_LOCK2		0x00003333
+
+#define CS35L36_PAC_PROG_MEM		512
+
+#define CS35L36_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define CS35L36_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE \
+				| SNDRV_PCM_FMTBIT_S32_LE)
+
+bool cs35l36_readable_reg(struct device *dev, unsigned int reg);
+bool cs35l36_volatile_reg(struct device *dev, unsigned int reg);
+
+extern struct reg_default cs35l36_reg[CS35L36_MAX_CACHE_REG];
+extern const int cs35l36_a0_pac_patch[CS35L36_PAC_PROG_MEM];
+
+#endif
-- 
1.9.1
