From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 2/2] ASoC: msm8916: Add msm8916-wcd codec driver
Date: Fri, 10 Jun 2016 19:18:45 +0100
Message-ID: <1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465582725-30183-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to msm8916-wcd codec.

msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
This codec IP is split in to two parts(Digital & Analog), Analog part
is integrated in to PMIC PM8916 and the digital part is integrated into
Application processor. Register access to the analog part is done via
SPMI interface to PMIC, and registers on the Application processor are
memory mapped. Data transfer between Analog and Digital Die is done via
a internal bus called PDM.

This codec support includes:
 - 3 Microphones: Primary Mic(Handset mic), Headset Mic and Secondary Mic.
 - 2 Digital Microphones.
 - 2 Mic Bias Circuits.
 - Earpiece
 - Headset
 - Loud Speaker.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/dt-bindings/sound/msm8916-wcd.h  |    7 +
 sound/soc/codecs/Kconfig                 |    4 +
 sound/soc/codecs/Makefile                |    3 +-
 sound/soc/codecs/msm8916-wcd-registers.h |  710 ++++++++++++++
 sound/soc/codecs/msm8916-wcd.c           | 1575 ++++++++++++++++++++++++++++++
 sound/soc/codecs/msm8916-wcd.h           |  308 ++++++
 6 files changed, 2606 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/sound/msm8916-wcd.h
 create mode 100644 sound/soc/codecs/msm8916-wcd-registers.h
 create mode 100644 sound/soc/codecs/msm8916-wcd.c
 create mode 100644 sound/soc/codecs/msm8916-wcd.h

diff --git a/include/dt-bindings/sound/msm8916-wcd.h b/include/dt-bindings/sound/msm8916-wcd.h
new file mode 100644
index 0000000..718db3c
--- /dev/null
+++ b/include/dt-bindings/sound/msm8916-wcd.h
@@ -0,0 +1,7 @@
+#ifndef __DT_MSM8916_WCD_H
+#define __DT_MSM8916_WCD_H
+
+#define MSM8916_WCD_PLAYBACK_DAI	0
+#define MSM8916_WCD_CAPTURE_DAI		1
+
+#endif /* __DT_MSM8916_WCD_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cb57f8f..ef5e85a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -564,6 +564,10 @@ config SND_SOC_MAX9860
 	depends on I2C
 	select REGMAP_I2C
 
+config SND_SOC_MSM8916_WCD
+	tristate "Qualcomm MSM8916 WCD"
+	depends on SPMI && MFD_SYSCON
+
 config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 550a174..8ee1e72 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -84,6 +84,7 @@ snd-soc-max9850-objs := max9850.o
 snd-soc-max9860-objs := max9860.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
+snd-soc-msm8916-objs := msm8916-wcd.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-hdmi-codec-objs := hdmi-codec.o
 snd-soc-pcm1681-objs := pcm1681.o
@@ -208,7 +209,6 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
-
 # Amp
 snd-soc-max9877-objs := max9877.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
@@ -301,6 +301,7 @@ obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MAX9860)	+= snd-soc-max9860.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_MSM8916_WCD) +=snd-soc-msm8916.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
diff --git a/sound/soc/codecs/msm8916-wcd-registers.h b/sound/soc/codecs/msm8916-wcd-registers.h
new file mode 100644
index 0000000..8896603
--- /dev/null
+++ b/sound/soc/codecs/msm8916-wcd-registers.h
@@ -0,0 +1,710 @@
+ /* Copyright (c) 2016, The Linux Foundation. All rights reserved.
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License version 2 and
+  * only version 2 as published by the Free Software Foundation.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  */
+#ifndef MSM8916_WCD_REGISTERS_H
+#define MSM8916_WCD_REGISTERS_H
+
+#define CDC_D_REVISION1			(0x000)
+#define CDC_D_REVISION1_POR				(0x00)
+#define CDC_D_REVISION2			(0x001)
+#define CDC_D_REVISION2_POR				(0x00)
+#define CDC_D_PERPH_TYPE			(0x004)
+#define CDC_D_PERPH_TYPE_POR				(0x23)
+#define CDC_D_PERPH_SUBTYPE			(0x005)
+#define CDC_D_PERPH_SUBTYPE_POR			(0x01)
+#define CDC_D_INT_RT_STS			(0x010)
+#define CDC_D_INT_RT_STS_POR				(0x00)
+#define CDC_D_INT_SET_TYPE			(0x011)
+#define CDC_D_INT_SET_TYPE_POR				(0xFF)
+#define CDC_D_INT_POLARITY_HIGH			(0x012)
+#define CDC_D_INT_POLARITY_HIGH_POR			(0xFF)
+#define CDC_D_INT_POLARITY_LOW			(0x013)
+#define CDC_D_INT_POLARITY_LOW_POR			(0x00)
+#define CDC_D_INT_LATCHED_CLR			(0x014)
+#define CDC_D_INT_LATCHED_CLR_POR			(0x00)
+#define CDC_D_INT_EN_SET			(0x015)
+#define CDC_D_INT_EN_SET_POR				(0x00)
+#define CDC_D_INT_EN_CLR			(0x016)
+#define CDC_D_INT_EN_CLR_POR				(0x00)
+#define CDC_D_INT_LATCHED_STS			(0x018)
+#define CDC_D_INT_LATCHED_STS_POR			(0x00)
+#define CDC_D_INT_PENDING_STS			(0x019)
+#define CDC_D_INT_PENDING_STS_POR			(0x00)
+#define CDC_D_INT_MID_SEL			(0x01A)
+#define CDC_D_INT_MID_SEL_POR				(0x00)
+#define CDC_D_INT_PRIORITY			(0x01B)
+#define CDC_D_INT_PRIORITY_POR				(0x00)
+#define CDC_D_GPIO_MODE			(0x040)
+#define CDC_D_GPIO_MODE_POR				(0x00)
+#define CDC_D_PIN_CTL_OE			(0x041)
+#define CDC_D_PIN_CTL_OE_POR				(0x01)
+#define CDC_D_PIN_CTL_DATA			(0x042)
+#define CDC_D_PIN_CTL_DATA_POR				(0x00)
+#define CDC_D_PIN_STATUS			(0x043)
+#define CDC_D_PIN_STATUS_POR				(0x00)
+#define CDC_D_HDRIVE_CTL			(0x044)
+#define CDC_D_HDRIVE_CTL_POR				(0x00)
+#define CDC_D_CDC_RST_CTL			(0x046)
+#define RST_CTL_DIG_SW_RST_N_MASK		BIT(7)
+#define RST_CTL_DIG_SW_RST_N_RESET		0
+#define RST_CTL_DIG_SW_RST_N_REMOVE_RESET	BIT(7)
+
+#define CDC_D_CDC_RST_CTL_POR				(0x00)
+#define CDC_D_CDC_TOP_CLK_CTL			(0x048)
+#define TOP_CLK_CTL_A_MCLK_MCLK2_EN_MASK	(BIT(2) | BIT(3))
+#define TOP_CLK_CTL_A_MCLK_EN_ENABLE		BIT(2)
+#define TOP_CLK_CTL_A_MCLK2_EN_ENABLE		BIT(3)
+
+#define CDC_D_CDC_TOP_CLK_CTL_POR			(0x00)
+#define CDC_D_CDC_ANA_CLK_CTL			(0x049)
+#define ANA_CLK_CTL_EAR_HPHR_CLK_EN_MASK	BIT(0)
+#define ANA_CLK_CTL_EAR_HPHR_CLK_EN	BIT(0)
+#define ANA_CLK_CTL_EAR_HPHL_CLK_EN	BIT(1)
+#define ANA_CLK_CTL_SPKR_CLK_EN_MASK	BIT(4)
+#define ANA_CLK_CTL_SPKR_CLK_EN	BIT(4)
+#define ANA_CLK_CTL_TXA_CLK25_EN	BIT(5)
+
+#define CDC_D_CDC_ANA_CLK_CTL_POR			(0x00)
+#define CDC_D_CDC_DIG_CLK_CTL			(0x04A)
+#define DIG_CLK_CTL_RXD1_CLK_EN	BIT(0)
+#define DIG_CLK_CTL_RXD2_CLK_EN	BIT(1)
+#define DIG_CLK_CTL_RXD3_CLK_EN	BIT(3)
+#define DIG_CLK_CTL_TXD_CLK_EN	BIT(4)
+#define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
+#define DIG_CLK_CTL_NCP_CLK_EN	BIT(6)
+#define DIG_CLK_CTL_RXD_PDM_CLK_EN_MASK	BIT(7)
+#define DIG_CLK_CTL_RXD_PDM_CLK_EN	BIT(7)
+
+#define CDC_D_CDC_DIG_CLK_CTL_POR			(0x00)
+#define CDC_D_CDC_CONN_TX1_CTL			(0x050)
+#define CONN_TX1_SERIAL_TX1_MUX			GENMASK(1, 0)
+#define CONN_TX1_SERIAL_TX1_ADC_1		0x0
+#define CONN_TX1_SERIAL_TX1_RX_PDM_LB		0x1
+#define CONN_TX1_SERIAL_TX1_ZERO		0x2
+
+#define CDC_D_CDC_CONN_TX1_CTL_POR			(0x02)
+#define CDC_D_CDC_CONN_TX2_CTL			(0x051)
+#define CONN_TX2_SERIAL_TX2_MUX			GENMASK(1, 0)
+#define CONN_TX2_SERIAL_TX2_ADC_2		0x0
+#define CONN_TX2_SERIAL_TX2_RX_PDM_LB		0x1
+#define CONN_TX2_SERIAL_TX2_ZERO		0x2
+#define CDC_D_CDC_CONN_TX2_CTL_POR			(0x02)
+#define CDC_D_CDC_CONN_HPHR_DAC_CTL			(0x052)
+#define CDC_D_CDC_CONN_HPHR_DAC_CTL_POR		(0x00)
+#define CDC_D_CDC_CONN_RX1_CTL			(0x053)
+#define CDC_D_CDC_CONN_RX1_CTL_POR			(0x00)
+#define CDC_D_CDC_CONN_RX2_CTL			(0x054)
+#define CDC_D_CDC_CONN_RX2_CTL_POR			(0x00)
+#define CDC_D_CDC_CONN_RX3_CTL			(0x055)
+#define CDC_D_CDC_CONN_RX3_CTL_POR			(0x00)
+#define CDC_D_CDC_CONN_RX_LB_CTL			(0x056)
+#define CDC_D_CDC_CONN_RX_LB_CTL_POR			(0x00)
+#define CDC_D_CDC_RX_CTL1			(0x058)
+#define CDC_D_CDC_RX_CTL1_POR				(0x7C)
+#define CDC_D_CDC_RX_CTL2			(0x059)
+#define CDC_D_CDC_RX_CTL2_POR				(0x7C)
+#define CDC_D_CDC_RX_CTL3			(0x05A)
+#define CDC_D_CDC_RX_CTL3_POR				(0x7C)
+#define CDC_D_DEM_BYPASS_DATA0			(0x05B)
+#define CDC_D_DEM_BYPASS_DATA0_POR			(0x00)
+#define CDC_D_DEM_BYPASS_DATA1			(0x05C)
+#define CDC_D_DEM_BYPASS_DATA1_POR			(0x00)
+#define CDC_D_DEM_BYPASS_DATA2			(0x05D)
+#define CDC_D_DEM_BYPASS_DATA2_POR			(0x00)
+#define CDC_D_DEM_BYPASS_DATA3			(0x05E)
+#define CDC_D_DEM_BYPASS_DATA3_POR			(0x00)
+#define CDC_D_DIG_DEBUG_CTL			(0x068)
+#define CDC_D_DIG_DEBUG_CTL_POR			(0x00)
+#define CDC_D_DIG_DEBUG_EN			(0x069)
+#define CDC_D_DIG_DEBUG_EN_POR				(0x00)
+#define CDC_D_SPARE_0				(0x070)
+#define CDC_D_SPARE_0_POR				(0x00)
+#define CDC_D_SPARE_1				(0x071)
+#define CDC_D_SPARE_1_POR				(0x00)
+#define CDC_D_SPARE_2				(0x072)
+#define CDC_D_SPARE_2_POR				(0x00)
+#define CDC_D_SEC_ACCESS			(0x0D0)
+#define CDC_D_SEC_ACCESS_POR				(0x00)
+#define CDC_D_PERPH_RESET_CTL1			(0x0D8)
+#define CDC_D_PERPH_RESET_CTL1_POR			(0x00)
+#define CDC_D_PERPH_RESET_CTL2			(0x0D9)
+#define CDC_D_PERPH_RESET_CTL2_POR			(0x01)
+#define CDC_D_PERPH_RESET_CTL3			(0x0DA)
+#define CDC_D_PERPH_RESET_CTL3_POR			(0x05)
+#define CDC_D_PERPH_RESET_CTL4			(0x0DB)
+#define CDC_D_PERPH_RESET_CTL4_POR			(0x00)
+#define CDC_D_INT_TEST1				(0x0E0)
+#define CDC_D_INT_TEST1_POR				(0x00)
+#define CDC_D_INT_TEST_VAL			(0x0E1)
+#define CDC_D_INT_TEST_VAL_POR				(0x00)
+#define CDC_D_TRIM_NUM				(0x0F0)
+#define CDC_D_TRIM_NUM_POR				(0x00)
+#define CDC_D_TRIM_CTRL				(0x0F1)
+#define CDC_D_TRIM_CTRL_POR				(0x00)
+
+#define CDC_A_REVISION1			(0x100)
+#define CDC_A_REVISION1_POR				(0x00)
+#define CDC_A_REVISION2			(0x101)
+#define CDC_A_REVISION2_POR				(0x00)
+#define CDC_A_REVISION3			(0x102)
+#define CDC_A_REVISION3_POR				(0x00)
+#define CDC_A_REVISION4			(0x103)
+#define CDC_A_REVISION4_POR				(0x00)
+#define CDC_A_PERPH_TYPE			(0x104)
+#define CDC_A_PERPH_TYPE_POR			(0x23)
+#define CDC_A_PERPH_SUBTYPE		(0x105)
+#define CDC_A_PERPH_SUBTYPE_POR			(0x09)
+#define CDC_A_INT_RT_STS			(0x110)
+#define CDC_A_INT_RT_STS_POR			(0x00)
+#define CDC_A_INT_SET_TYPE		(0x111)
+#define CDC_A_INT_SET_TYPE_POR			(0x3F)
+#define CDC_A_INT_POLARITY_HIGH		(0x112)
+#define CDC_A_INT_POLARITY_HIGH_POR		(0x3F)
+#define CDC_A_INT_POLARITY_LOW		(0x113)
+#define CDC_A_INT_POLARITY_LOW_POR		(0x00)
+#define CDC_A_INT_LATCHED_CLR		(0x114)
+#define CDC_A_INT_LATCHED_CLR_POR		(0x00)
+#define CDC_A_INT_EN_SET			(0x115)
+#define CDC_A_INT_EN_SET_POR			(0x00)
+#define CDC_A_INT_EN_CLR			(0x116)
+#define CDC_A_INT_EN_CLR_POR			(0x00)
+#define CDC_A_INT_LATCHED_STS		(0x118)
+#define CDC_A_INT_LATCHED_STS_POR		(0x00)
+#define CDC_A_INT_PENDING_STS		(0x119)
+#define CDC_A_INT_PENDING_STS_POR		(0x00)
+#define CDC_A_INT_MID_SEL		(0x11A)
+#define CDC_A_INT_MID_SEL_POR			(0x00)
+#define CDC_A_INT_PRIORITY		(0x11B)
+#define CDC_A_INT_PRIORITY_POR			(0x00)
+
+#define CDC_A_MICB_1_EN			(0x140)
+#define MICB_1_EN_MICB_ENABLE	BIT(7)
+#define MICB_1_EN_BYP_CAP_MASK	BIT(6)
+#define MICB_1_EN_NO_EXT_BYP_CAP	BIT(6)
+#define MICB_1_EN_EXT_BYP_CAP	0
+#define MICB_1_EN_PULL_DOWN_EN_MASK	BIT(5)
+#define MICB_1_EN_PULL_DOWN_EN_ENABLE	BIT(5)
+#define MICB_1_EN_OPA_STG2_TAIL_CURR_MASK GENMASK(3, 1)
+#define MICB_1_EN_OPA_STG2_TAIL_CURR_1_60UA	BIT(2)
+#define MICB_1_EN_TX3_GND_SEL_MASK	BIT(0)
+#define MICB_1_EN_TX3_GND_SEL_TX_GND	0
+#define CDC_A_MICB_1_EN_POR			(0x00)
+
+#define CDC_A_MICB_1_VAL			(0x141)
+#define MICB_1_VAL_MICB_OUT_VAL_MASK		GENMASK(7, 3)
+#define MICB_1_VAL_MICB_OUT_VAL_V2P70V		((0x16)  << 3)
+#define CDC_A_MICB_1_VAL_POR			(0x20)
+#define CDC_A_MICB_1_CTL			(0x142)
+
+#define MICB_1_CTL_CFILT_REF_SEL_MASK		BIT(1)
+#define MICB_1_CTL_CFILT_REF_SEL_HPF_REF	BIT(1)
+#define MICB_1_CTL_EXT_PRECHARG_EN_MASK		BIT(5)
+#define MICB_1_CTL_EXT_PRECHARG_EN_ENABLE	BIT(5)
+#define MICB_1_CTL_INT_PRECHARG_BYP_MASK	BIT(6)
+#define MICB_1_CTL_INT_PRECHARG_BYP_EXT_PRECHRG_SEL	BIT(6)
+
+#define CDC_A_MICB_1_CTL_POR			(0x00)
+#define CDC_A_MICB_1_INT_RBIAS			(0x143)
+
+#define MICB_1_INT_TX1_INT_RBIAS_EN_MASK	BIT(7)
+#define MICB_1_INT_TX1_INT_RBIAS_EN_ENABLE	BIT(7)
+#define MICB_1_INT_TX1_INT_RBIAS_EN_DISABLE	0
+
+#define MICB_1_INT_TX1_INT_PULLUP_EN_MASK	BIT(6)
+#define MICB_1_INT_TX1_INT_PULLUP_EN_TX1N_TO_MICBIAS BIT(6)
+#define MICB_1_INT_TX1_INT_PULLUP_EN_TX1N_TO_GND	0
+
+#define MICB_1_INT_TX2_INT_RBIAS_EN_MASK	BIT(4)
+#define MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE	BIT(4)
+#define MICB_1_INT_TX2_INT_RBIAS_EN_DISABLE	0
+#define MICB_1_INT_TX2_INT_PULLUP_EN_MASK	BIT(3)
+#define MICB_1_INT_TX2_INT_PULLUP_EN_TX1N_TO_MICBIAS BIT(3)
+#define MICB_1_INT_TX2_INT_PULLUP_EN_TX1N_TO_GND	0
+
+#define MICB_1_INT_TX3_INT_RBIAS_EN_MASK	BIT(1)
+#define MICB_1_INT_TX3_INT_RBIAS_EN_ENABLE	BIT(1)
+#define MICB_1_INT_TX3_INT_RBIAS_EN_DISABLE	0
+#define MICB_1_INT_TX3_INT_PULLUP_EN_MASK	BIT(0)
+#define MICB_1_INT_TX3_INT_PULLUP_EN_TX1N_TO_MICBIAS BIT(0)
+#define MICB_1_INT_TX3_INT_PULLUP_EN_TX1N_TO_GND	0
+
+#define CDC_A_MICB_1_INT_RBIAS_POR		(0x49)
+#define CDC_A_MICB_2_EN			(0x144)
+#define CDC_A_MICB_2_EN_POR			(0x20)
+#define CDC_A_TX_1_2_ATEST_CTL_2			(0x145)
+#define CDC_A_TX_1_2_ATEST_CTL_2_POR		(0x00)
+#define CDC_A_MASTER_BIAS_CTL			(0x146)
+#define MASTER_BIAS_CTL_MASTER_BIAS_EN_MASK	BIT(5)
+#define MASTER_BIAS_CTL_MASTER_BIAS_EN_ENABLE	BIT(5)
+#define MASTER_BIAS_CTL_V2L_BUFFER_EN_MASK	BIT(4)
+#define MASTER_BIAS_CTL_V2L_BUFFER_EN_ENABLE	BIT(4)
+#define CDC_A_MASTER_BIAS_CTL_POR		(0x00)
+#define CDC_A_MBHC_DET_CTL_1		(0x147)
+#define CDC_A_MBHC_DET_CTL_1_POR		(0x35)
+#define CDC_A_MBHC_DET_CTL_2		(0x150)
+#define CDC_A_MBHC_DET_CTL_2_POR		(0x08)
+#define CDC_A_MBHC_FSM_CTL		(0x151)
+#define CDC_A_MBHC_FSM_CTL_POR			(0x00)
+#define CDC_A_MBHC_DBNC_TIMER		(0x152)
+#define CDC_A_MBHC_DBNC_TIMER_POR		(0x98)
+#define CDC_A_MBHC_BTN0_ZDETL_CTL	(0x153)
+#define CDC_A_MBHC_BTN0_ZDETL_CTL_POR		(0x00)
+#define CDC_A_MBHC_BTN1_ZDETM_CTL	(0x154)
+#define CDC_A_MBHC_BTN1_ZDETM_CTL_POR		(0x20)
+#define CDC_A_MBHC_BTN2_ZDETH_CTL	(0x155)
+#define CDC_A_MBHC_BTN2_ZDETH_CTL_POR		(0x40)
+#define CDC_A_MBHC_BTN3_CTL		(0x156)
+#define CDC_A_MBHC_BTN3_CTL_POR			(0x61)
+#define CDC_A_MBHC_BTN4_CTL		(0x157)
+#define CDC_A_MBHC_BTN4_CTL_POR			(0x80)
+#define CDC_A_MBHC_BTN_RESULT		(0x158)
+#define CDC_A_MBHC_BTN_RESULT_POR		(0x00)
+#define CDC_A_MBHC_ZDET_ELECT_RESULT	(0x159)
+#define CDC_A_MBHC_ZDET_ELECT_RESULT_POR	(0x00)
+#define CDC_A_TX_1_EN			(0x160)
+#define CDC_A_TX_1_EN_POR			(0x03)
+#define CDC_A_TX_2_EN			(0x161)
+#define CDC_A_TX_2_EN_POR			(0x03)
+#define CDC_A_TX_1_2_TEST_CTL_1		(0x162)
+#define CDC_A_TX_1_2_TEST_CTL_1_POR		(0xBF)
+#define CDC_A_TX_1_2_TEST_CTL_2		(0x163)
+#define CDC_A_TX_1_2_TEST_CTL_2_POR		(0x8C)
+#define CDC_A_TX_1_2_ATEST_CTL		(0x164)
+#define CDC_A_TX_1_2_ATEST_CTL_POR		(0x00)
+#define CDC_A_TX_1_2_OPAMP_BIAS		(0x165)
+#define CDC_A_TX_1_2_OPAMP_BIAS_POR		(0x6B)
+#define CDC_A_TX_1_2_TXFE_CLKDIV		(0x166)
+#define CDC_A_TX_1_2_TXFE_CLKDIV_POR		(0x51)
+#define CDC_A_TX_3_EN			(0x167)
+#define CDC_A_TX_3_EN_POR			(0x02)
+#define CDC_A_NCP_EN			(0x180)
+#define CDC_A_NCP_EN_POR			(0x26)
+#define CDC_A_NCP_CLK			(0x181)
+#define CDC_A_NCP_CLK_POR			(0x23)
+#define CDC_A_NCP_DEGLITCH		(0x182)
+#define CDC_A_NCP_DEGLITCH_POR			(0x5B)
+#define CDC_A_NCP_FBCTRL			(0x183)
+#define CDC_A_NCP_FBCTRL_FB_CLK_INV_MASK	BIT(5)
+#define CDC_A_NCP_FBCTRL_FB_CLK_INV		BIT(5)
+#define CDC_A_NCP_FBCTRL_POR			(0x08)
+#define CDC_A_NCP_BIAS			(0x184)
+#define CDC_A_NCP_BIAS_POR			(0x29)
+#define CDC_A_NCP_VCTRL			(0x185)
+#define CDC_A_NCP_VCTRL_POR			(0x24)
+#define CDC_A_NCP_TEST			(0x186)
+#define CDC_A_NCP_TEST_POR			(0x00)
+#define CDC_A_NCP_CLIM_ADDR		(0x187)
+#define CDC_A_NCP_CLIM_ADDR_POR			(0xD5)
+#define CDC_A_RX_CLOCK_DIVIDER		(0x190)
+#define CDC_A_RX_CLOCK_DIVIDER_POR		(0xE8)
+#define CDC_A_RX_COM_OCP_CTL		(0x191)
+#define CDC_A_RX_COM_OCP_CTL_POR		(0xCF)
+#define CDC_A_RX_COM_OCP_COUNT		(0x192)
+#define CDC_A_RX_COM_OCP_COUNT_POR		(0x6E)
+#define CDC_A_RX_COM_BIAS_DAC		(0x193)
+#define RX_COM_BIAS_DAC_RX_BIAS_EN_MASK		BIT(7)
+#define RX_COM_BIAS_DAC_RX_BIAS_EN_ENABLE	BIT(7)
+#define RX_COM_BIAS_DAC_DAC_REF_EN_MASK		BIT(0)
+#define RX_COM_BIAS_DAC_DAC_REF_EN_ENABLE	BIT(0)
+
+#define CDC_A_RX_COM_BIAS_DAC_POR		(0x10)
+#define CDC_A_RX_HPH_BIAS_PA		(0x194)
+#define CDC_A_RX_HPH_BIAS_PA_POR		(0x5A)
+#define CDC_A_RX_HPH_BIAS_LDO_OCP	(0x195)
+#define CDC_A_RX_HPH_BIAS_LDO_OCP_POR		(0x69)
+#define CDC_A_RX_HPH_BIAS_CNP		(0x196)
+#define CDC_A_RX_HPH_BIAS_CNP_POR		(0x29)
+#define CDC_A_RX_HPH_CNP_EN		(0x197)
+#define CDC_A_RX_HPH_CNP_EN_POR			(0x80)
+#define CDC_A_RX_HPH_CNP_WG_CTL		(0x198)
+#define CDC_A_RX_HPH_CNP_WG_CTL_POR		(0xDA)
+#define CDC_A_RX_HPH_CNP_WG_TIME		(0x199)
+#define CDC_A_RX_HPH_CNP_WG_TIME_POR		(0x16)
+#define CDC_A_RX_HPH_L_TEST		(0x19A)
+#define CDC_A_RX_HPH_L_TEST_POR			(0x00)
+#define CDC_A_RX_HPH_L_PA_DAC_CTL	(0x19B)
+#define RX_HPA_L_PA_DAC_CTL_DATA_RESET_MASK	BIT(1)
+#define RX_HPA_L_PA_DAC_CTL_DATA_RESET_RESET	BIT(1)
+#define CDC_A_RX_HPH_L_PA_DAC_CTL_POR		(0x20)
+#define CDC_A_RX_HPH_R_TEST		(0x19C)
+#define CDC_A_RX_HPH_R_TEST_POR			(0x00)
+#define CDC_A_RX_HPH_R_PA_DAC_CTL	(0x19D)
+#define RX_HPH_R_PA_DAC_CTL_DATA_RESET	BIT(1)
+#define RX_HPH_R_PA_DAC_CTL_DATA_RESET_MASK BIT(1)
+
+#define CDC_A_RX_HPH_R_PA_DAC_CTL_POR		(0x20)
+#define CDC_A_RX_EAR_CTL			(0x19E)
+#define RX_EAR_CTL_SPK_VBAT_LDO_EN_MASK		BIT(0)
+#define RX_EAR_CTL_SPK_VBAT_LDO_EN_ENABLE	BIT(0)
+
+#define CDC_A_RX_EAR_CTL_POR			(0x12)
+#define CDC_A_RX_ATEST			(0x19F)
+#define CDC_A_RX_ATEST_POR			(0x00)
+#define CDC_A_RX_HPH_STATUS		(0x1A0)
+#define CDC_A_RX_HPH_STATUS_POR			(0x0C)
+#define CDC_A_RX_EAR_STATUS		(0x1A1)
+#define CDC_A_RX_EAR_STATUS_POR			(0x00)
+#define CDC_A_SPKR_DAC_CTL		(0x1B0)
+#define SPKR_DAC_CTL_DAC_RESET_MASK		BIT(4)
+#define SPKR_DAC_CTL_DAC_RESET_NORMAL		0
+
+#define CDC_A_SPKR_DAC_CTL_POR			(0x83)
+#define CDC_A_SPKR_DRV_CLIP_DET		(0x1B1)
+#define CDC_A_SPKR_DRV_CLIP_DET_POR		(0x91)
+#define CDC_A_SPKR_DRV_CTL		(0x1B2)
+#define SPKR_DRV_CTL_DEF_MASK		0xEF
+#define SPKR_DRV_CLASSD_PA_EN_MASK		BIT(7)
+#define SPKR_DRV_CLASSD_PA_EN_ENABLE		BIT(7)
+#define SPKR_DRV_CAL_EN				BIT(6)
+#define SPKR_DRV_SETTLE_EN			BIT(5)
+#define SPKR_DRV_FW_EN				BIT(3)
+#define SPKR_DRV_BOOST_SET			BIT(2)
+#define SPKR_DRV_CMFB_SET			BIT(1)
+#define SPKR_DRV_GAIN_SET			BIT(0)
+#define SPKR_DRV_CTL_DEF_VAL (SPKR_DRV_CLASSD_PA_EN_ENABLE | \
+		SPKR_DRV_CAL_EN | SPKR_DRV_SETTLE_EN | \
+		SPKR_DRV_FW_EN | SPKR_DRV_BOOST_SET | \
+		SPKR_DRV_CMFB_SET | SPKR_DRV_GAIN_SET)
+#define CDC_A_SPKR_DRV_CTL_POR			(0x29)
+#define CDC_A_SPKR_ANA_BIAS_SET		(0x1B3)
+#define CDC_A_SPKR_ANA_BIAS_SET_POR		(0x4D)
+#define CDC_A_SPKR_OCP_CTL		(0x1B4)
+#define CDC_A_SPKR_OCP_CTL_POR			(0xE1)
+#define CDC_A_SPKR_PWRSTG_CTL		(0x1B5)
+#define SPKR_PWRSTG_CTL_DAC_EN_MASK	BIT(0)
+#define SPKR_PWRSTG_CTL_DAC_EN_ENABLE	BIT(0)
+#define SPKR_PWRSTG_CTL_HBRDGE_EN	BIT(6)
+#define SPKR_PWRSTG_CTL_CLAMP_EN	BIT(5)
+#define SPKR_PWRSTG_CTL_DEADTIME_T20NS	0
+#define SPKR_PWRSTG_CTL_DEADTIME_T15NS	BIT(3)
+#define SPKR_PWRSTG_CTL_DEADTIME_T10NS	BIT(4)
+#define SPKR_PWRSTG_CTL_DEADTIME_T05NS	(BIT(3) | BIT(4))
+#define SPKR_PWRSTG_CTL_MASK		0xE0
+#define SPKR_PWRSTG_CTL_DEFAULTS	0xE0
+
+#define CDC_A_SPKR_PWRSTG_CTL_POR		(0x1E)
+#define CDC_A_SPKR_DRV_MISC		(0x1B6)
+#define CDC_A_SPKR_DRV_MISC_POR			(0xCB)
+#define CDC_A_SPKR_DRV_DBG		(0x1B7)
+#define CDC_A_SPKR_DRV_DBG_POR			(0x00)
+#define CDC_A_CURRENT_LIMIT		(0x1C0)
+#define CDC_A_CURRENT_LIMIT_POR			(0x02)
+#define CDC_A_OUTPUT_VOLTAGE		(0x1C1)
+#define CDC_A_OUTPUT_VOLTAGE_POR		(0x14)
+#define CDC_A_BYPASS_MODE		(0x1C2)
+#define CDC_A_BYPASS_MODE_POR			(0x00)
+#define CDC_A_BOOST_EN_CTL		(0x1C3)
+#define CDC_A_BOOST_EN_CTL_POR			(0x1F)
+#define CDC_A_SLOPE_COMP_IP_ZERO		(0x1C4)
+#define CDC_A_SLOPE_COMP_IP_ZERO_POR		(0x8C)
+#define CDC_A_RDSON_MAX_DUTY_CYCLE	(0x1C5)
+#define CDC_A_RDSON_MAX_DUTY_CYCLE_POR		(0xC0)
+#define CDC_A_BOOST_TEST1_1		(0x1C6)
+#define CDC_A_BOOST_TEST1_1_POR			(0x00)
+#define CDC_A_BOOST_TEST_2		(0x1C7)
+#define CDC_A_BOOST_TEST_2_POR			(0x00)
+#define CDC_A_SPKR_SAR_STATUS		(0x1C8)
+#define CDC_A_SPKR_SAR_STATUS_POR		(0x00)
+#define CDC_A_SPKR_DRV_STATUS		(0x1C9)
+#define CDC_A_SPKR_DRV_STATUS_POR		(0x00)
+#define CDC_A_PBUS_ADD_CSR		(0x1CE)
+#define CDC_A_PBUS_ADD_CSR_POR			(0x00)
+#define CDC_A_PBUS_ADD_SEL		(0x1CF)
+#define CDC_A_PBUS_ADD_SEL_POR			(0x00)
+#define CDC_A_SEC_ACCESS			(0x1D0)
+#define CDC_A_SEC_ACCESS_POR			(0x00)
+#define CDC_A_PERPH_RESET_CTL1		(0x1D8)
+#define CDC_A_PERPH_RESET_CTL1_POR		(0x00)
+#define CDC_A_PERPH_RESET_CTL2		(0x1D9)
+#define CDC_A_PERPH_RESET_CTL2_POR		(0x01)
+#define CDC_A_PERPH_RESET_CTL3		(0x1DA)
+#define CDC_A_PERPH_RESET_CTL3_POR		(0x05)
+#define CDC_A_PERPH_RESET_CTL4		(0x1DB)
+#define CDC_A_PERPH_RESET_CTL4_POR		(0x00)
+#define CDC_A_INT_TEST1			(0x1E0)
+#define CDC_A_INT_TEST1_POR			(0x00)
+#define CDC_A_INT_TEST_VAL		(0x1E1)
+#define CDC_A_INT_TEST_VAL_POR			(0x00)
+#define CDC_A_TRIM_NUM			(0x1F0)
+#define CDC_A_TRIM_NUM_POR			(0x04)
+#define CDC_A_TRIM_CTRL1			(0x1F1)
+#define CDC_A_TRIM_CTRL1_POR			(0x00)
+#define CDC_A_TRIM_CTRL2			(0x1F2)
+#define CDC_A_TRIM_CTRL2_POR			(0x00)
+#define CDC_A_TRIM_CTRL3			(0x1F3)
+#define CDC_A_TRIM_CTRL3_POR			(0x00)
+#define CDC_A_TRIM_CTRL4			(0x1F4)
+#define CDC_A_TRIM_CTRL4_POR			(0x00)
+
+/* Digital part */
+#define LPASS_CDC_CLK_RX_RESET_CTL			(0x200)
+#define LPASS_CDC_CLK_RX_RESET_CTL_POR				(0x00)
+#define LPASS_CDC_CLK_TX_RESET_B1_CTL			(0x204)
+#define CLK_RX_RESET_B1_CTL_TX1_RESET_MASK		BIT(0)
+#define CLK_RX_RESET_B1_CTL_TX2_RESET_MASK		BIT(1)
+#define LPASS_CDC_CLK_TX_RESET_B1_CTL_POR			(0x00)
+#define LPASS_CDC_CLK_DMIC_B1_CTL			(0x208)
+#define DMIC_B1_CTL_DMIC0_CLK_SEL_MASK			GENMASK(3, 1)
+#define DMIC_B1_CTL_DMIC0_CLK_SEL_DIV2			(0x0 << 1)
+#define DMIC_B1_CTL_DMIC0_CLK_SEL_DIV3			(0x1 << 1)
+#define DMIC_B1_CTL_DMIC0_CLK_SEL_DIV4			(0x2 << 1)
+#define DMIC_B1_CTL_DMIC0_CLK_SEL_DIV6			(0x3 << 1)
+#define DMIC_B1_CTL_DMIC0_CLK_SEL_DIV16			(0x4 << 1)
+#define DMIC_B1_CTL_DMIC0_CLK_EN_MASK			BIT(0)
+#define DMIC_B1_CTL_DMIC0_CLK_EN_ENABLE			BIT(0)
+
+#define LPASS_CDC_CLK_DMIC_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CLK_RX_I2S_CTL			(0x20C)
+#define RX_I2S_CTL_RX_I2S_MODE_MASK			BIT(5)
+#define RX_I2S_CTL_RX_I2S_MODE_16			BIT(5)
+#define RX_I2S_CTL_RX_I2S_MODE_32			0
+#define RX_I2S_CTL_RX_I2S_FS_RATE_MASK			GENMASK(2, 0)
+#define RX_I2S_CTL_RX_I2S_FS_RATE_F_8_KHZ		0x0
+#define RX_I2S_CTL_RX_I2S_FS_RATE_F_16_KHZ		0x1
+#define RX_I2S_CTL_RX_I2S_FS_RATE_F_32_KHZ		0x2
+#define RX_I2S_CTL_RX_I2S_FS_RATE_F_48_KHZ		0x3
+#define RX_I2S_CTL_RX_I2S_FS_RATE_F_96_KHZ		0x4
+#define RX_I2S_CTL_RX_I2S_FS_RATE_F_192_KHZ		0x5
+#define LPASS_CDC_CLK_RX_I2S_CTL_POR				(0x13)
+#define LPASS_CDC_CLK_OTHR_RESET_B1_CTL			(0x214)
+#define LPASS_CDC_CLK_TX_I2S_CTL_POR				(0x13)
+#define LPASS_CDC_CLK_TX_I2S_CTL			(0x210)
+#define TX_I2S_CTL_TX_I2S_MODE_MASK			BIT(5)
+#define TX_I2S_CTL_TX_I2S_MODE_16			BIT(5)
+#define TX_I2S_CTL_TX_I2S_MODE_32			0
+#define TX_I2S_CTL_TX_I2S_FS_RATE_MASK			GENMASK(2, 0)
+#define TX_I2S_CTL_TX_I2S_FS_RATE_F_8_KHZ		0x0
+#define TX_I2S_CTL_TX_I2S_FS_RATE_F_16_KHZ		0x1
+#define TX_I2S_CTL_TX_I2S_FS_RATE_F_32_KHZ		0x2
+#define TX_I2S_CTL_TX_I2S_FS_RATE_F_48_KHZ		0x3
+#define TX_I2S_CTL_TX_I2S_FS_RATE_F_96_KHZ		0x4
+#define TX_I2S_CTL_TX_I2S_FS_RATE_F_192_KHZ		0x5
+
+#define LPASS_CDC_CLK_TX_I2S_CTL_POR				(0x13)
+#define LPASS_CDC_CLK_OTHR_RESET_B1_CTL			(0x214)
+#define LPASS_CDC_CLK_OTHR_RESET_B1_CTL_POR			(0x00)
+#define LPASS_CDC_CLK_TX_CLK_EN_B1_CTL			(0x218)
+#define LPASS_CDC_CLK_TX_CLK_EN_B1_CTL_POR			(0x00)
+#define LPASS_CDC_CLK_OTHR_CTL			(0x21C)
+#define LPASS_CDC_CLK_OTHR_CTL_POR				(0x04)
+#define LPASS_CDC_CLK_RX_B1_CTL			(0x220)
+#define LPASS_CDC_CLK_RX_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CLK_MCLK_CTL			(0x224)
+#define MCLK_CTL_MCLK_EN_MASK			BIT(0)
+#define MCLK_CTL_MCLK_EN_ENABLE			BIT(0)
+#define MCLK_CTL_MCLK_EN_DISABLE		0
+#define LPASS_CDC_CLK_MCLK_CTL_POR				(0x00)
+#define LPASS_CDC_CLK_PDM_CTL			(0x228)
+#define LPASS_CDC_CLK_PDM_CTL_PDM_EN_MASK	BIT(0)
+#define LPASS_CDC_CLK_PDM_CTL_PDM_EN		BIT(0)
+#define LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK	BIT(1)
+#define LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_FB	BIT(1)
+#define LPASS_CDC_CLK_PDM_CTL_PDM_CLK_PDM_CLK	0
+
+#define LPASS_CDC_CLK_PDM_CTL_POR				(0x00)
+#define LPASS_CDC_CLK_SD_CTL			(0x22C)
+#define LPASS_CDC_CLK_SD_CTL_POR				(0x00)
+#define LPASS_CDC_RX1_B1_CTL			(0x240)
+#define LPASS_CDC_RX1_B1_CTL_POR				(0x00)
+#define LPASS_CDC_RX2_B1_CTL			(0x260)
+#define LPASS_CDC_RX2_B1_CTL_POR				(0x00)
+#define LPASS_CDC_RX3_B1_CTL			(0x280)
+#define LPASS_CDC_RX3_B1_CTL_POR				(0x00)
+#define LPASS_CDC_RX1_B2_CTL			(0x244)
+#define LPASS_CDC_RX1_B2_CTL_POR				(0x00)
+#define LPASS_CDC_RX2_B2_CTL			(0x264)
+#define LPASS_CDC_RX2_B2_CTL_POR				(0x00)
+#define LPASS_CDC_RX3_B2_CTL			(0x284)
+#define LPASS_CDC_RX3_B2_CTL_POR				(0x00)
+#define LPASS_CDC_RX1_B3_CTL			(0x248)
+#define LPASS_CDC_RX1_B3_CTL_POR				(0x00)
+#define LPASS_CDC_RX2_B3_CTL			(0x268)
+#define LPASS_CDC_RX2_B3_CTL_POR				(0x00)
+#define LPASS_CDC_RX3_B3_CTL			(0x288)
+#define LPASS_CDC_RX3_B3_CTL_POR				(0x00)
+#define LPASS_CDC_RX1_B4_CTL			(0x24C)
+#define LPASS_CDC_RX1_B4_CTL_POR				(0x00)
+#define LPASS_CDC_RX2_B4_CTL			(0x26C)
+#define LPASS_CDC_RX2_B4_CTL_POR				(0x00)
+#define LPASS_CDC_RX3_B4_CTL			(0x28C)
+#define LPASS_CDC_RX3_B4_CTL_POR				(0x00)
+#define LPASS_CDC_RX1_B5_CTL			(0x250)
+#define LPASS_CDC_RX1_B5_CTL_POR				(0x68)
+#define LPASS_CDC_RX2_B5_CTL			(0x270)
+#define LPASS_CDC_RX2_B5_CTL_POR				(0x68)
+#define LPASS_CDC_RX3_B5_CTL			(0x290)
+#define LPASS_CDC_RX3_B5_CTL_POR				(0x68)
+#define LPASS_CDC_RX1_B6_CTL			(0x254)
+#define RXn_B6_CTL_MUTE_MASK			BIT(0)
+#define RXn_B6_CTL_MUTE_ENABLE			BIT(0)
+#define RXn_B6_CTL_MUTE_DISABLE			0
+#define LPASS_CDC_RX1_B6_CTL_POR				(0x00)
+#define LPASS_CDC_RX2_B6_CTL			(0x274)
+#define LPASS_CDC_RX2_B6_CTL_POR				(0x00)
+#define LPASS_CDC_RX3_B6_CTL			(0x294)
+#define LPASS_CDC_RX3_B6_CTL_POR				(0x00)
+#define LPASS_CDC_RX1_VOL_CTL_B1_CTL			(0x258)
+#define LPASS_CDC_RX1_VOL_CTL_B1_CTL_POR			(0x00)
+#define LPASS_CDC_RX2_VOL_CTL_B1_CTL			(0x278)
+#define LPASS_CDC_RX2_VOL_CTL_B1_CTL_POR			(0x00)
+#define LPASS_CDC_RX3_VOL_CTL_B1_CTL			(0x298)
+#define LPASS_CDC_RX3_VOL_CTL_B1_CTL_POR			(0x00)
+#define LPASS_CDC_RX1_VOL_CTL_B2_CTL			(0x25C)
+#define LPASS_CDC_RX1_VOL_CTL_B2_CTL_POR			(0x00)
+#define LPASS_CDC_RX2_VOL_CTL_B2_CTL			(0x27C)
+#define LPASS_CDC_RX2_VOL_CTL_B2_CTL_POR			(0x00)
+#define LPASS_CDC_RX3_VOL_CTL_B2_CTL			(0x29C)
+#define LPASS_CDC_RX3_VOL_CTL_B2_CTL_POR			(0x00)
+#define LPASS_CDC_TOP_GAIN_UPDATE			(0x2A0)
+#define LPASS_CDC_TOP_GAIN_UPDATE_POR				(0x00)
+#define LPASS_CDC_TOP_CTL				(0x2A4)
+#define TOP_CTL_DIG_MCLK_FREQ_MASK			BIT(0)
+#define TOP_CTL_DIG_MCLK_FREQ_F_12_288MHZ		0
+#define TOP_CTL_DIG_MCLK_FREQ_F_9_6MHZ			BIT(0)
+
+#define LPASS_CDC_TOP_CTL_POR					(0x01)
+#define LPASS_CDC_DEBUG_DESER1_CTL			(0x2E0)
+#define LPASS_CDC_DEBUG_DESER1_CTL_POR				(0x00)
+#define LPASS_CDC_DEBUG_DESER2_CTL			(0x2E4)
+#define LPASS_CDC_DEBUG_DESER2_CTL_POR				(0x00)
+#define LPASS_CDC_DEBUG_B1_CTL_CFG			(0x2E8)
+#define LPASS_CDC_DEBUG_B1_CTL_CFG_POR				(0x00)
+#define LPASS_CDC_DEBUG_B2_CTL_CFG			(0x2EC)
+#define LPASS_CDC_DEBUG_B2_CTL_CFG_POR				(0x00)
+#define LPASS_CDC_DEBUG_B3_CTL_CFG			(0x2F0)
+#define LPASS_CDC_DEBUG_B3_CTL_CFG_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B1_CTL			(0x300)
+#define LPASS_CDC_IIR1_GAIN_B1_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B1_CTL			(0x340)
+#define LPASS_CDC_IIR2_GAIN_B1_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B2_CTL			(0x304)
+#define LPASS_CDC_IIR1_GAIN_B2_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B2_CTL			(0x344)
+#define LPASS_CDC_IIR2_GAIN_B2_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B3_CTL			(0x308)
+#define LPASS_CDC_IIR1_GAIN_B3_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B3_CTL			(0x348)
+#define LPASS_CDC_IIR2_GAIN_B3_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B4_CTL			(0x30C)
+#define LPASS_CDC_IIR1_GAIN_B4_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B4_CTL			(0x34C)
+#define LPASS_CDC_IIR2_GAIN_B4_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B5_CTL			(0x310)
+#define LPASS_CDC_IIR1_GAIN_B5_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B5_CTL			(0x350)
+#define LPASS_CDC_IIR2_GAIN_B5_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B6_CTL			(0x314)
+#define LPASS_CDC_IIR1_GAIN_B6_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B6_CTL			(0x354)
+#define LPASS_CDC_IIR2_GAIN_B6_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B7_CTL			(0x318)
+#define LPASS_CDC_IIR1_GAIN_B7_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B7_CTL			(0x358)
+#define LPASS_CDC_IIR2_GAIN_B7_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_GAIN_B8_CTL			(0x31C)
+#define LPASS_CDC_IIR1_GAIN_B8_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_GAIN_B8_CTL			(0x35C)
+#define LPASS_CDC_IIR2_GAIN_B8_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_CTL			(0x320)
+#define LPASS_CDC_IIR1_CTL_POR				(0x40)
+#define LPASS_CDC_IIR2_CTL			(0x360)
+#define LPASS_CDC_IIR2_CTL_POR				(0x40)
+#define LPASS_CDC_IIR1_GAIN_TIMER_CTL			(0x324)
+#define LPASS_CDC_IIR1_GAIN_TIMER_CTL_POR			(0x00)
+#define LPASS_CDC_IIR2_GAIN_TIMER_CTL			(0x364)
+#define LPASS_CDC_IIR2_GAIN_TIMER_CTL_POR			(0x00)
+#define LPASS_CDC_IIR1_COEF_B1_CTL			(0x328)
+#define LPASS_CDC_IIR1_COEF_B1_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_COEF_B1_CTL			(0x368)
+#define LPASS_CDC_IIR2_COEF_B1_CTL_POR				(0x00)
+#define LPASS_CDC_IIR1_COEF_B2_CTL			(0x32C)
+#define LPASS_CDC_IIR1_COEF_B2_CTL_POR				(0x00)
+#define LPASS_CDC_IIR2_COEF_B2_CTL			(0x36C)
+#define LPASS_CDC_IIR2_COEF_B2_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX1_B1_CTL			(0x380)
+#define LPASS_CDC_CONN_RX1_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX1_B2_CTL			(0x384)
+#define LPASS_CDC_CONN_RX1_B2_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX1_B3_CTL			(0x388)
+#define LPASS_CDC_CONN_RX1_B3_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX2_B1_CTL			(0x38C)
+#define LPASS_CDC_CONN_RX2_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX2_B2_CTL			(0x390)
+#define LPASS_CDC_CONN_RX2_B2_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX2_B3_CTL			(0x394)
+#define LPASS_CDC_CONN_RX2_B3_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX3_B1_CTL			(0x398)
+#define LPASS_CDC_CONN_RX3_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_RX3_B2_CTL			(0x39C)
+#define LPASS_CDC_CONN_RX3_B2_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_TX_B1_CTL			(0x3A0)
+#define LPASS_CDC_CONN_TX_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ1_B1_CTL			(0x3A8)
+#define LPASS_CDC_CONN_EQ1_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ1_B2_CTL			(0x3AC)
+#define LPASS_CDC_CONN_EQ1_B2_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ1_B3_CTL			(0x3B0)
+#define LPASS_CDC_CONN_EQ1_B3_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ1_B4_CTL			(0x3B4)
+#define LPASS_CDC_CONN_EQ1_B4_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ2_B1_CTL			(0x3B8)
+#define LPASS_CDC_CONN_EQ2_B1_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ2_B2_CTL			(0x3BC)
+#define LPASS_CDC_CONN_EQ2_B2_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ2_B3_CTL			(0x3C0)
+#define LPASS_CDC_CONN_EQ2_B3_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_EQ2_B4_CTL			(0x3C4)
+#define LPASS_CDC_CONN_EQ2_B4_CTL_POR				(0x00)
+#define LPASS_CDC_CONN_TX_I2S_SD1_CTL			(0x3C8)
+#define LPASS_CDC_CONN_TX_I2S_SD1_CTL_POR			(0x00)
+#define LPASS_CDC_TX1_VOL_CTL_TIMER			(0x480)
+#define LPASS_CDC_TX1_VOL_CTL_TIMER_POR			(0x00)
+#define LPASS_CDC_TX2_VOL_CTL_TIMER			(0x4A0)
+#define LPASS_CDC_TX2_VOL_CTL_TIMER_POR			(0x00)
+#define LPASS_CDC_TX1_VOL_CTL_GAIN			(0x484)
+#define LPASS_CDC_TX1_VOL_CTL_GAIN_POR				(0x00)
+#define LPASS_CDC_TX2_VOL_CTL_GAIN			(0x4A4)
+#define LPASS_CDC_TX2_VOL_CTL_GAIN_POR				(0x00)
+#define LPASS_CDC_TX1_VOL_CTL_CFG			(0x488)
+#define TX_VOL_CTL_CFG_MUTE_EN_MASK			BIT(0)
+#define TX_VOL_CTL_CFG_MUTE_EN_ENABLE			BIT(0)
+
+#define LPASS_CDC_TX1_VOL_CTL_CFG_POR				(0x00)
+#define LPASS_CDC_TX2_VOL_CTL_CFG			(0x4A8)
+#define LPASS_CDC_TX2_VOL_CTL_CFG_POR				(0x00)
+#define LPASS_CDC_TX1_MUX_CTL			(0x48C)
+#define TX_MUX_CTL_CUT_OFF_FREQ_MASK			GENMASK(5, 4)
+#define TX_MUX_CTL_CUT_OFF_FREQ_SHIFT			4
+#define TX_MUX_CTL_CUT_OFF_FREQ_CF_NEG_3DB_4HZ		(0x0 << 4)
+#define TX_MUX_CTL_CUT_OFF_FREQ_CF_NEG_3DB_75HZ		(0x1 << 4)
+#define TX_MUX_CTL_CUT_OFF_FREQ_CF_NEG_3DB_150HZ	(0x2 << 4)
+#define TX_MUX_CTL_HPF_BP_SEL_MASK			BIT(3)
+#define TX_MUX_CTL_HPF_BP_SEL_BYPASS			BIT(3)
+#define TX_MUX_CTL_HPF_BP_SEL_NO_BYPASS			0
+
+#define LPASS_CDC_TX1_MUX_CTL_POR				(0x00)
+#define LPASS_CDC_TX2_MUX_CTL			(0x4AC)
+#define LPASS_CDC_TX2_MUX_CTL_POR				(0x00)
+#define LPASS_CDC_TX1_CLK_FS_CTL			(0x490)
+#define LPASS_CDC_TX1_CLK_FS_CTL_POR				(0x03)
+#define LPASS_CDC_TX2_CLK_FS_CTL			(0x4B0)
+#define LPASS_CDC_TX2_CLK_FS_CTL_POR				(0x03)
+#define LPASS_CDC_TX1_DMIC_CTL			(0x494)
+#define LPASS_CDC_TX1_DMIC_CTL_POR				(0x00)
+#define LPASS_CDC_TX2_DMIC_CTL			(0x4B4)
+#define TXN_DMIC_CTL_CLK_SEL_MASK		GENMASK(2, 0)
+#define TXN_DMIC_CTL_CLK_SEL_DIV2		0x0
+#define TXN_DMIC_CTL_CLK_SEL_DIV3		0x1
+#define TXN_DMIC_CTL_CLK_SEL_DIV4		0x2
+#define TXN_DMIC_CTL_CLK_SEL_DIV6		0x3
+#define TXN_DMIC_CTL_CLK_SEL_DIV16		0x4
+#define LPASS_CDC_TX2_DMIC_CTL_POR				(0x00)
+#endif
diff --git a/sound/soc/codecs/msm8916-wcd.c b/sound/soc/codecs/msm8916-wcd.c
new file mode 100644
index 0000000..49d95f3
--- /dev/null
+++ b/sound/soc/codecs/msm8916-wcd.c
@@ -0,0 +1,1575 @@
+/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+
+#include "msm8916-wcd-registers.h"
+#include "msm8916-wcd.h"
+#include "dt-bindings/sound/msm8916-wcd.h"
+
+#define MSM8916_WCD_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
+#define MSM8916_WCD_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+		SNDRV_PCM_FMTBIT_S24_LE)
+
+/* Internal status on mute_mask to track mute on different sinks */
+#define MUTE_MASK_HPHL_PA_DISABLE		BIT(1)
+#define MUTE_MASK_HPHR_PA_DISABLE		BIT(2)
+#define MUTE_MASK_EAR_PA_DISABLE		BIT(3)
+#define MUTE_MASK_SPKR_PA_DISABLE		BIT(4)
+
+struct msm8916_wcd_chip {
+	struct regmap *analog_map;
+	struct regmap *digital_map;
+	unsigned int analog_offset;
+	u16 pmic_rev;
+	u16 codec_version;
+
+	struct clk *mclk;
+	struct regulator *vddio;
+	struct regulator *vdd_tx_rx;
+
+	u32 mute_mask;
+	u32 rx_bias_count;
+	bool micbias1_cap_mode;
+	bool micbias2_cap_mode;
+	int dmic_clk_cnt;
+};
+
+static const unsigned long rx_gain_reg[] = {
+	LPASS_CDC_RX1_VOL_CTL_B2_CTL,
+	LPASS_CDC_RX2_VOL_CTL_B2_CTL,
+	LPASS_CDC_RX3_VOL_CTL_B2_CTL,
+};
+
+static const unsigned long tx_gain_reg[] = {
+	LPASS_CDC_TX1_VOL_CTL_GAIN,
+	LPASS_CDC_TX2_VOL_CTL_GAIN,
+};
+
+static const char *const rx_mix1_text[] = {
+	"ZERO", "IIR1", "IIR2", "RX1", "RX2", "RX3"
+};
+
+static const char *const dec_mux_text[] = {
+	"ZERO", "ADC1", "ADC2", "ADC3", "DMIC1", "DMIC2"
+};
+static const char *const rx_mix2_text[] = { "ZERO", "IIR1", "IIR2" };
+static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
+static const char *const rdac2_mux_text[] = { "ZERO", "RX2", "RX1" };
+static const char *const hph_text[] = { "ZERO", "Switch", };
+
+/* RX1 MIX1 */
+static const struct soc_enum rx_mix1_inp_enum[] = {
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B1_CTL, 0, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B1_CTL, 3, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B2_CTL, 0, 6, rx_mix1_text),
+};
+
+/* RX1 MIX2 */
+static const struct soc_enum rx_mix2_inp1_chain_enum =
+SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B3_CTL, 0, 3, rx_mix2_text);
+
+/* RX2 MIX1 */
+static const struct soc_enum rx2_mix1_inp_enum[] = {
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 0, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 3, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 0, 6, rx_mix1_text),
+};
+
+/* RX2 MIX2 */
+static const struct soc_enum rx2_mix2_inp1_chain_enum =
+SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B3_CTL, 0, 3, rx_mix2_text);
+
+/* RX3 MIX1 */
+static const struct soc_enum rx3_mix1_inp_enum[] = {
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 0, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 3, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 0, 6, rx_mix1_text),
+};
+
+/* DEC */
+static const struct soc_enum dec1_mux_enum =
+SOC_ENUM_SINGLE(LPASS_CDC_CONN_TX_B1_CTL, 0, 6, dec_mux_text);
+
+static const struct soc_enum dec2_mux_enum =
+SOC_ENUM_SINGLE(LPASS_CDC_CONN_TX_B1_CTL, 3, 6, dec_mux_text);
+
+/* RDAC2 MUX */
+static const struct soc_enum rdac2_mux_enum =
+SOC_ENUM_SINGLE(CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 3, rdac2_mux_text);
+
+/* ADC2 MUX */
+static const struct soc_enum adc2_enum =
+SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(adc2_mux_text), adc2_mux_text);
+
+static const struct soc_enum hph_enum =
+SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(hph_text), hph_text);
+
+static const struct snd_kcontrol_new spkr_switch[] = {
+	SOC_DAPM_SINGLE("Switch", CDC_A_SPKR_DAC_CTL, 7, 1, 0)
+};
+
+static const struct snd_kcontrol_new dec1_mux =
+SOC_DAPM_ENUM("DEC1 MUX Mux", dec1_mux_enum);
+
+static const struct snd_kcontrol_new dec2_mux =
+SOC_DAPM_ENUM("DEC2 MUX Mux", dec2_mux_enum);
+
+static const struct snd_kcontrol_new rdac2_mux =
+SOC_DAPM_ENUM("RDAC2 MUX Mux", rdac2_mux_enum);
+
+static const struct snd_kcontrol_new tx_adc2_mux =
+SOC_DAPM_ENUM("ADC2 MUX Mux", adc2_enum);
+
+static const struct snd_kcontrol_new rx_mix1_inp1_mux =
+SOC_DAPM_ENUM("RX1 MIX1 INP1 Mux", rx_mix1_inp_enum[0]);
+
+static const struct snd_kcontrol_new rx_mix1_inp2_mux =
+SOC_DAPM_ENUM("RX1 MIX1 INP2 Mux", rx_mix1_inp_enum[1]);
+
+static const struct snd_kcontrol_new rx_mix1_inp3_mux =
+SOC_DAPM_ENUM("RX1 MIX1 INP3 Mux", rx_mix1_inp_enum[2]);
+
+static const struct snd_kcontrol_new rx2_mix1_inp1_mux =
+SOC_DAPM_ENUM("RX2 MIX1 INP1 Mux", rx2_mix1_inp_enum[0]);
+
+static const struct snd_kcontrol_new rx2_mix1_inp2_mux =
+SOC_DAPM_ENUM("RX2 MIX1 INP2 Mux", rx2_mix1_inp_enum[1]);
+
+static const struct snd_kcontrol_new rx2_mix1_inp3_mux =
+SOC_DAPM_ENUM("RX2 MIX1 INP3 Mux", rx2_mix1_inp_enum[2]);
+
+static const struct snd_kcontrol_new rx3_mix1_inp1_mux =
+SOC_DAPM_ENUM("RX3 MIX1 INP1 Mux", rx3_mix1_inp_enum[0]);
+
+static const struct snd_kcontrol_new rx3_mix1_inp2_mux =
+SOC_DAPM_ENUM("RX3 MIX1 INP2 Mux", rx3_mix1_inp_enum[1]);
+
+static const struct snd_kcontrol_new rx3_mix1_inp3_mux =
+SOC_DAPM_ENUM("RX3 MIX1 INP3 Mux", rx3_mix1_inp_enum[2]);
+
+static const struct snd_kcontrol_new hphl_mux = SOC_DAPM_ENUM("HPHL", hph_enum);
+
+static const struct snd_kcontrol_new hphr_mux = SOC_DAPM_ENUM("HPHR", hph_enum);
+
+/* Digital Gain control -38.4 dB to +38.4 dB in 0.3 dB steps */
+static const DECLARE_TLV_DB_SCALE(digital_gain, -3840, 30, 0);
+
+/* Analog Gain control 0 dB to +24 dB in 6 dB steps */
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 600, 0);
+
+static const struct snd_kcontrol_new msm8916_wcd_snd_controls[] = {
+	SOC_SINGLE_TLV("ADC1 Volume", CDC_A_TX_1_EN, 3, 8, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", CDC_A_TX_2_EN, 3, 8, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", CDC_A_TX_3_EN, 3, 8, 0, analog_gain),
+	SOC_SINGLE_S8_TLV("RX1 Digital Volume", LPASS_CDC_RX1_VOL_CTL_B2_CTL,
+			  -128, 127, digital_gain),
+	SOC_SINGLE_S8_TLV("RX2 Digital Volume", LPASS_CDC_RX2_VOL_CTL_B2_CTL,
+			  -128, 127, digital_gain),
+	SOC_SINGLE_S8_TLV("RX3 Digital Volume", LPASS_CDC_RX3_VOL_CTL_B2_CTL,
+			  -128, 127, digital_gain),
+};
+
+static int msm8916_wcd_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int val)
+{
+	int ret = -EINVAL;
+	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
+	u8 *cache = codec->reg_cache;
+
+	if (!msm8916_wcd_reg_readonly[reg])
+		cache[reg] = val;
+
+	if (MSM8916_WCD_IS_TOMBAK_REG(reg)) {
+		/* codec registers inside pmic core */
+		ret = regmap_write(chip->analog_map,
+				   chip->analog_offset + reg, val);
+	} else if (MSM8916_WCD_IS_DIGITAL_REG(reg)) {
+		/* codec registers in the cpu core */
+		u32 v = val & MSM8916_WCD_REG_VAL_MASK;
+		u16 offset = MSM8916_WCD_DIGITAL_REG(reg);
+
+		ret = regmap_write(chip->digital_map, offset, v);
+	}
+
+	return ret;
+}
+
+static unsigned int msm8916_wcd_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	int ret = -EINVAL;
+	u32 val = 0;
+	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
+	u8 *cache = codec->reg_cache;
+
+	if (!msm8916_wcd_reg_readonly[reg])
+		return cache[reg];
+
+	if (MSM8916_WCD_IS_TOMBAK_REG(reg)) {
+		ret = regmap_read(chip->analog_map,
+				  chip->analog_offset + reg, &val);
+	} else if (MSM8916_WCD_IS_DIGITAL_REG(reg)) {
+		u32 v;
+		u16 offset = MSM8916_WCD_DIGITAL_REG(reg);
+
+		ret = regmap_read(chip->digital_map, offset, &v);
+		val = (u8) v;
+	}
+
+	return val;
+}
+
+static void msm8916_wcd_configure_cap(struct snd_soc_codec *codec,
+				      bool micbias1, bool micbias2)
+{
+	struct msm8916_wcd_chip *wcd = snd_soc_codec_get_drvdata(codec);
+
+	if (micbias1 && micbias2) {
+		if ((wcd->micbias1_cap_mode == MICB_1_EN_EXT_BYP_CAP) ||
+		    (wcd->micbias2_cap_mode == MICB_1_EN_EXT_BYP_CAP))
+			snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+					    MICB_1_EN_BYP_CAP_MASK,
+					    MICB_1_EN_EXT_BYP_CAP);
+		else
+			snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+					    MICB_1_EN_BYP_CAP_MASK,
+					    MICB_1_EN_NO_EXT_BYP_CAP);
+	} else if (micbias2) {
+		snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+				    MICB_1_EN_BYP_CAP_MASK,
+				    wcd->micbias2_cap_mode);
+	} else if (micbias1) {
+		snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+				    MICB_1_EN_BYP_CAP_MASK,
+				    wcd->micbias1_cap_mode);
+	} else {
+		snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+				    MICB_1_EN_BYP_CAP_MASK, 0);
+	}
+}
+
+static int msm8916_wcd_hph_pa_event(struct snd_soc_dapm_widget *w,
+				    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, CDC_A_NCP_FBCTRL,
+				    CDC_A_NCP_FBCTRL_FB_CLK_INV_MASK,
+				    CDC_A_NCP_FBCTRL_FB_CLK_INV);
+		break;
+
+	case SND_SOC_DAPM_POST_PMU:
+		if (w->shift == 5)
+			snd_soc_update_bits(codec, LPASS_CDC_RX1_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK, 0);
+		else if (w->shift == 4)
+			snd_soc_update_bits(codec, LPASS_CDC_RX2_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK, 0);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		if (w->shift == 5) {
+			snd_soc_update_bits(codec, LPASS_CDC_RX1_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK,
+					    RXn_B6_CTL_MUTE_ENABLE);
+			msm8916_wcd->mute_mask |= MUTE_MASK_HPHL_PA_DISABLE;
+		} else if (w->shift == 4) {
+			snd_soc_update_bits(codec, LPASS_CDC_RX2_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK,
+					    RXn_B6_CTL_MUTE_ENABLE);
+			msm8916_wcd->mute_mask |= MUTE_MASK_HPHR_PA_DISABLE;
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_NCP_CLK_EN,
+				    DIG_CLK_CTL_NCP_CLK_EN);
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_hphl_dac_event(struct snd_soc_dapm_widget *w,
+				      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, CDC_A_RX_HPH_L_PA_DAC_CTL,
+				    RX_HPA_L_PA_DAC_CTL_DATA_RESET_MASK,
+				    RX_HPA_L_PA_DAC_CTL_DATA_RESET_RESET);
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD1_CLK_EN,
+				    DIG_CLK_CTL_RXD1_CLK_EN);
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_EAR_HPHL_CLK_EN,
+				    ANA_CLK_CTL_EAR_HPHL_CLK_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, CDC_A_RX_HPH_L_PA_DAC_CTL,
+				    RX_HPA_L_PA_DAC_CTL_DATA_RESET_MASK, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_EAR_HPHL_CLK_EN, 0);
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD1_CLK_EN, 0);
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_spk_pa(struct snd_soc_dapm_widget *w,
+					   struct snd_kcontrol *kcontrol,
+					   int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_SPKR_CLK_EN_MASK,
+				    ANA_CLK_CTL_SPKR_CLK_EN);
+		snd_soc_update_bits(codec, CDC_A_SPKR_PWRSTG_CTL,
+				    SPKR_PWRSTG_CTL_DAC_EN_MASK,
+				    SPKR_PWRSTG_CTL_DAC_EN_ENABLE);
+		snd_soc_update_bits(codec, CDC_A_SPKR_PWRSTG_CTL,
+				    SPKR_PWRSTG_CTL_MASK,
+				    SPKR_PWRSTG_CTL_DEFAULTS);
+		if (!TOMBAK_IS_1_0(msm8916_wcd->pmic_rev))
+			snd_soc_update_bits(codec, CDC_A_RX_EAR_CTL,
+					    RX_EAR_CTL_SPK_VBAT_LDO_EN_MASK,
+					    RX_EAR_CTL_SPK_VBAT_LDO_EN_ENABLE);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, CDC_A_SPKR_DRV_CTL,
+				    SPKR_DRV_CTL_DEF_MASK,
+				    SPKR_DRV_CTL_DEF_VAL);
+
+		snd_soc_update_bits(codec, LPASS_CDC_RX3_B6_CTL,
+				    RXn_B6_CTL_MUTE_MASK,
+				    RXn_B6_CTL_MUTE_DISABLE);
+		snd_soc_update_bits(codec, w->reg,
+				    SPKR_DRV_CLASSD_PA_EN_MASK,
+				    SPKR_DRV_CLASSD_PA_EN_ENABLE);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, CDC_A_SPKR_PWRSTG_CTL,
+				    SPKR_PWRSTG_CTL_MASK, 0);
+		snd_soc_update_bits(codec, CDC_A_SPKR_PWRSTG_CTL,
+				    SPKR_PWRSTG_CTL_DAC_EN_MASK, 0);
+
+		snd_soc_update_bits(codec, CDC_A_SPKR_DAC_CTL,
+				    SPKR_DAC_CTL_DAC_RESET_MASK,
+				    SPKR_DAC_CTL_DAC_RESET_NORMAL);
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_SPKR_CLK_EN, 0);
+		if (!TOMBAK_IS_1_0(msm8916_wcd->pmic_rev))
+			snd_soc_update_bits(codec, CDC_A_RX_EAR_CTL,
+					    RX_EAR_CTL_SPK_VBAT_LDO_EN_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_dig_clk(struct snd_soc_dapm_widget *w,
+					    struct snd_kcontrol *kcontrol,
+					    int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN_MASK,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (msm8916_wcd->rx_bias_count == 0)
+			snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+					    DIG_CLK_CTL_RXD_PDM_CLK_EN_MASK, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_rx_chain(struct snd_soc_dapm_widget *w,
+					     struct snd_kcontrol *kcontrol,
+					     int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN, 0);
+		snd_soc_update_bits(codec, w->reg, 1 << w->shift, 0x00);
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_charge_pump(struct snd_soc_dapm_widget *w,
+						struct snd_kcontrol *kcontrol,
+						int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN_MASK |
+				    DIG_CLK_CTL_NCP_CLK_EN_MASK,
+				    DIG_CLK_CTL_RXD_PDM_CLK_EN |
+				    DIG_CLK_CTL_NCP_CLK_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_NCP_CLK_EN_MASK, 0);
+		if (msm8916_wcd->rx_bias_count == 0)
+			snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+					    DIG_CLK_CTL_RXD_PDM_CLK_EN_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_rx_bias(struct snd_soc_dapm_widget *w,
+					    struct snd_kcontrol *kcontrol,
+					    int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		msm8916_wcd->rx_bias_count++;
+		if (msm8916_wcd->rx_bias_count == 1) {
+			snd_soc_update_bits(codec, CDC_A_RX_COM_BIAS_DAC,
+					    RX_COM_BIAS_DAC_RX_BIAS_EN_MASK |
+					    RX_COM_BIAS_DAC_DAC_REF_EN_MASK,
+					    RX_COM_BIAS_DAC_RX_BIAS_EN_ENABLE |
+					    RX_COM_BIAS_DAC_DAC_REF_EN_ENABLE);
+		}
+
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		msm8916_wcd->rx_bias_count--;
+		if (msm8916_wcd->rx_bias_count == 0) {
+			snd_soc_update_bits(codec, CDC_A_RX_COM_BIAS_DAC,
+					    RX_COM_BIAS_DAC_RX_BIAS_EN_MASK |
+					    RX_COM_BIAS_DAC_DAC_REF_EN_MASK, 0);
+
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static void msm8916_wcd_micbias2_enable(struct snd_soc_codec *codec, bool on)
+{
+	if (on) {
+		snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+				    MICB_1_CTL_EXT_PRECHARG_EN_MASK |
+				    MICB_1_CTL_INT_PRECHARG_BYP_MASK,
+				    MICB_1_CTL_INT_PRECHARG_BYP_EXT_PRECHRG_SEL
+				    | MICB_1_CTL_EXT_PRECHARG_EN_ENABLE);
+		snd_soc_write(codec, CDC_A_MICB_1_VAL,
+			      MICB_1_VAL_MICB_OUT_VAL_V2P70V);
+		/*
+		 * Special headset needs MICBIAS as 2.7V so wait for
+		 * 50 msec for the MICBIAS to reach 2.7 volts.
+		 */
+		msleep(50);
+		snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+				    MICB_1_CTL_EXT_PRECHARG_EN_MASK |
+				    MICB_1_CTL_INT_PRECHARG_BYP_MASK, 0);
+	}
+}
+
+static int msm8916_wcd_codec_enable_micbias(struct snd_soc_dapm_widget *w,
+					    struct snd_kcontrol *kcontrol,
+					    int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	char *internal1_text = "Internal1";
+	char *internal2_text = "Internal2";
+	char *internal3_text = "Internal3";
+	char *external2_text = "External2";
+	char *external_text = "External";
+	bool micbias2;
+
+	micbias2 = (snd_soc_read(codec, CDC_A_MICB_2_EN) & 0x80);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (strnstr(w->name, internal1_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX1_INT_RBIAS_EN_MASK,
+					    MICB_1_INT_TX1_INT_RBIAS_EN_ENABLE);
+		} else if (strnstr(w->name, internal2_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
+					    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
+			snd_soc_update_bits(codec, w->reg,
+					    MICB_1_EN_BYP_CAP_MASK |
+					    MICB_1_EN_PULL_DOWN_EN_MASK, 0);
+		} else if (strnstr(w->name, internal3_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX3_INT_RBIAS_EN_MASK,
+					    MICB_1_INT_TX3_INT_RBIAS_EN_ENABLE);
+		}
+		if (!strnstr(w->name, external_text, 30))
+			snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+					    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK |
+					    MICB_1_EN_TX3_GND_SEL_MASK,
+					    MICB_1_EN_OPA_STG2_TAIL_CURR_1_60UA);
+		if (w->reg == CDC_A_MICB_1_EN)
+			msm8916_wcd_configure_cap(codec, true, micbias2);
+
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		if (strnstr(w->name, internal1_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX1_INT_PULLUP_EN_MASK,
+					    MICB_1_INT_TX1_INT_PULLUP_EN_TX1N_TO_MICBIAS);
+		} else if (strnstr(w->name, internal2_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX2_INT_PULLUP_EN_MASK,
+					    MICB_1_INT_TX2_INT_PULLUP_EN_TX1N_TO_MICBIAS);
+			msm8916_wcd_micbias2_enable(codec, true);
+			msm8916_wcd_configure_cap(codec, false, true);
+		} else if (strnstr(w->name, internal3_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX3_INT_PULLUP_EN_MASK,
+					    MICB_1_INT_TX3_INT_PULLUP_EN_TX1N_TO_MICBIAS);
+		} else if (strnstr(w->name, external2_text, 30)) {
+			msm8916_wcd_micbias2_enable(codec, true);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (strnstr(w->name, internal1_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX1_INT_RBIAS_EN_MASK,
+					    MICB_1_INT_TX1_INT_RBIAS_EN_DISABLE);
+		} else if (strnstr(w->name, internal2_text, 30)) {
+			msm8916_wcd_micbias2_enable(codec, false);
+		} else if (strnstr(w->name, internal3_text, 30)) {
+			snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+					    MICB_1_INT_TX3_INT_RBIAS_EN_MASK,
+					    MICB_1_INT_TX3_INT_RBIAS_EN_DISABLE);
+		} else if (strnstr(w->name, external2_text, 30)) {
+			msm8916_wcd_micbias2_enable(codec, false);
+			break;
+		}
+		if (w->reg == CDC_A_MICB_1_EN)
+			msm8916_wcd_configure_cap(codec, false, micbias2);
+		break;
+	}
+
+	return 0;
+}
+
+static void msm8916_wcd_codec_enable_adc_block(struct snd_soc_codec *codec,
+					       int enable)
+{
+	if (enable) {
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_TXA_CLK25_EN,
+				    ANA_CLK_CTL_TXA_CLK25_EN);
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_TXD_CLK_EN,
+				    DIG_CLK_CTL_TXD_CLK_EN);
+	} else {
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_TXD_CLK_EN, 0);
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_TXA_CLK25_EN, 0);
+	}
+}
+
+static int msm8916_wcd_codec_enable_adc(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	u16 adc_reg = CDC_A_TX_1_2_TEST_CTL_2;
+	u8 init_bit_shift;
+
+	if (w->reg == CDC_A_TX_1_EN)
+		init_bit_shift = 5;
+	else
+		init_bit_shift = 4;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		msm8916_wcd_codec_enable_adc_block(codec, 1);
+		if (w->reg == CDC_A_TX_2_EN)
+			snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+					    MICB_1_CTL_CFILT_REF_SEL_MASK,
+					    MICB_1_CTL_CFILT_REF_SEL_HPF_REF);
+		/*
+		 * Add delay of 10 ms to give sufficient time for the voltage
+		 * to shoot up and settle so that the txfe init does not
+		 * happen when the input voltage is changing too much.
+		 */
+		usleep_range(10000, 10010);
+		snd_soc_update_bits(codec, adc_reg, 1 << init_bit_shift,
+				    1 << init_bit_shift);
+		if (w->reg == CDC_A_TX_1_EN)
+			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX1_CTL,
+					    CONN_TX1_SERIAL_TX1_MUX,
+					    CONN_TX1_SERIAL_TX1_ADC_1);
+		else if ((w->reg == CDC_A_TX_2_EN) || (w->reg == CDC_A_TX_3_EN))
+			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
+					    CONN_TX2_SERIAL_TX2_MUX,
+					    CONN_TX2_SERIAL_TX2_ADC_2);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/*
+		 * Add delay of 12 ms before deasserting the init
+		 * to reduce the tx pop
+		 */
+		usleep_range(12000, 12010);
+		snd_soc_update_bits(codec, adc_reg, 1 << init_bit_shift, 0x00);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		msm8916_wcd_codec_enable_adc_block(codec, 0);
+		if (w->reg == CDC_A_TX_2_EN)
+			snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+					    MICB_1_CTL_CFILT_REF_SEL_MASK, 0);
+		if (w->reg == CDC_A_TX_1_EN)
+			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX1_CTL,
+					    CONN_TX1_SERIAL_TX1_MUX,
+					    CONN_TX1_SERIAL_TX1_ZERO);
+		else if ((w->reg == CDC_A_TX_2_EN) || (w->reg == CDC_A_TX_3_EN))
+			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
+					    CONN_TX2_SERIAL_TX2_MUX,
+					    CONN_TX2_SERIAL_TX2_ZERO);
+
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_hphr_dac_event(struct snd_soc_dapm_widget *w,
+				      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec,
+				    CDC_A_RX_HPH_R_PA_DAC_CTL,
+				    RX_HPH_R_PA_DAC_CTL_DATA_RESET_MASK,
+				    RX_HPH_R_PA_DAC_CTL_DATA_RESET);
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD2_CLK_EN,
+				    DIG_CLK_CTL_RXD2_CLK_EN);
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_EAR_HPHR_CLK_EN_MASK,
+				    ANA_CLK_CTL_EAR_HPHR_CLK_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, CDC_A_RX_HPH_R_PA_DAC_CTL,
+				    RX_HPH_R_PA_DAC_CTL_DATA_RESET_MASK, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, CDC_D_CDC_ANA_CLK_CTL,
+				    ANA_CLK_CTL_EAR_HPHR_CLK_EN_MASK, 0);
+		snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+				    DIG_CLK_CTL_RXD2_CLK_EN, 0);
+		break;
+	}
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
+						 struct snd_kcontrol *kcontrol,
+						 int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* apply the digital gain after the interpolator is enabled */
+		snd_soc_write(codec, rx_gain_reg[w->shift],
+			      snd_soc_read(codec, rx_gain_reg[w->shift]));
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, LPASS_CDC_CLK_RX_RESET_CTL,
+				    1 << w->shift, 1 << w->shift);
+		snd_soc_update_bits(codec, LPASS_CDC_CLK_RX_RESET_CTL,
+				    1 << w->shift, 0x0);
+		/* disable the mute enabled during the PMD of this device */
+		if (msm8916_wcd->mute_mask & MUTE_MASK_HPHL_PA_DISABLE) {
+			snd_soc_update_bits(codec,
+					    LPASS_CDC_RX1_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK,
+					    RXn_B6_CTL_MUTE_DISABLE);
+			msm8916_wcd->mute_mask &= ~(MUTE_MASK_HPHL_PA_DISABLE);
+		}
+		if (msm8916_wcd->mute_mask & MUTE_MASK_HPHR_PA_DISABLE) {
+			snd_soc_update_bits(codec, LPASS_CDC_RX2_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK,
+					    RXn_B6_CTL_MUTE_DISABLE);
+
+			msm8916_wcd->mute_mask &= ~(MUTE_MASK_HPHR_PA_DISABLE);
+		}
+		if (msm8916_wcd->mute_mask & MUTE_MASK_SPKR_PA_DISABLE) {
+			snd_soc_update_bits(codec, LPASS_CDC_RX3_B6_CTL,
+					    RXn_B6_CTL_MUTE_MASK,
+					    RXn_B6_CTL_MUTE_DISABLE);
+
+			msm8916_wcd->mute_mask &= ~(MUTE_MASK_SPKR_PA_DISABLE);
+		}
+	}
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_dec(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	unsigned int decimator;
+	char *dec_name = NULL;
+	char *widget_name = NULL;
+	char *temp;
+	int ret = 0;
+	u16 dec_reset_reg, tx_vol_ctl_reg, tx_mux_ctl_reg;
+	u8 dec_hpf_cut_of_freq;
+	char *dec_num;
+
+	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	if (!widget_name)
+		return -ENOMEM;
+	temp = widget_name;
+
+	dec_name = strsep(&widget_name, " ");
+	widget_name = temp;
+	if (!dec_name) {
+		dev_err(codec->dev, "Invalid decimator = %s\n", w->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dec_num = strpbrk(dec_name, "12");
+	if (dec_num == NULL) {
+		dev_err(codec->dev, "Invalid Decimator\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = kstrtouint(dec_num, 10, &decimator);
+	if (ret < 0) {
+		dev_err(codec->dev, "Invalid decimator = %s\n", dec_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dec_reset_reg = LPASS_CDC_CLK_TX_RESET_B1_CTL;
+	tx_vol_ctl_reg = LPASS_CDC_TX1_VOL_CTL_CFG + 32 * (decimator - 1);
+	tx_mux_ctl_reg = LPASS_CDC_TX1_MUX_CTL + 32 * (decimator - 1);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable TX digital mute */
+		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+				    TX_VOL_CTL_CFG_MUTE_EN_MASK,
+				    TX_VOL_CTL_CFG_MUTE_EN_ENABLE);
+		dec_hpf_cut_of_freq =
+		    snd_soc_read(codec,
+				 tx_mux_ctl_reg) & TX_MUX_CTL_CUT_OFF_FREQ_MASK;
+		dec_hpf_cut_of_freq >>= TX_MUX_CTL_CUT_OFF_FREQ_SHIFT;
+		if (dec_hpf_cut_of_freq !=
+		    TX_MUX_CTL_CUT_OFF_FREQ_CF_NEG_3DB_150HZ) {
+			/* set cut of freq to CF_MIN_3DB_150HZ (0x1) */
+			snd_soc_update_bits(codec, tx_mux_ctl_reg,
+					    TX_MUX_CTL_CUT_OFF_FREQ_MASK,
+					    TX_MUX_CTL_CUT_OFF_FREQ_CF_NEG_3DB_150HZ);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/* enable HPF */
+		snd_soc_update_bits(codec, tx_mux_ctl_reg,
+				    TX_MUX_CTL_HPF_BP_SEL_MASK,
+				    TX_MUX_CTL_HPF_BP_SEL_NO_BYPASS);
+		/* apply the digital gain after the decimator is enabled */
+		snd_soc_write(codec, tx_gain_reg[w->shift],
+			      snd_soc_read(codec, tx_gain_reg[w->shift]));
+		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+				    TX_VOL_CTL_CFG_MUTE_EN_MASK, 0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+				    TX_VOL_CTL_CFG_MUTE_EN_MASK,
+				    TX_VOL_CTL_CFG_MUTE_EN_ENABLE);
+		snd_soc_update_bits(codec, tx_mux_ctl_reg,
+				    TX_MUX_CTL_HPF_BP_SEL_MASK,
+				    TX_MUX_CTL_HPF_BP_SEL_BYPASS);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, dec_reset_reg, 1 << w->shift,
+				    1 << w->shift);
+		snd_soc_update_bits(codec, dec_reset_reg, 1 << w->shift, 0x0);
+		snd_soc_update_bits(codec, tx_mux_ctl_reg,
+				    TX_MUX_CTL_HPF_BP_SEL_MASK,
+				    TX_MUX_CTL_HPF_BP_SEL_BYPASS);
+		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+				    TX_VOL_CTL_CFG_MUTE_EN_MASK, 0);
+		break;
+	}
+
+out:
+	kfree(widget_name);
+	return ret;
+}
+
+static int msm8916_wcd_codec_enable_dmic(struct snd_soc_dapm_widget *w,
+					 struct snd_kcontrol *kcontrol,
+					 int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+	u16 dmic_clk_reg = LPASS_CDC_CLK_DMIC_B1_CTL;
+	unsigned int dmic;
+	int ret;
+	char *dec_num = strpbrk(w->name, "12");
+
+	if (dec_num == NULL) {
+		dev_err(codec->dev, "Invalid DMIC\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtouint(dec_num, 10, &dmic);
+	if (ret < 0) {
+		dev_err(codec->dev, "Invalid DMIC line on the codec\n");
+		return -EINVAL;
+	}
+	if (dmic > 2) {
+		dev_err(codec->dev, "%s: Invalid DMIC Selection\n", __func__);
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (++msm8916_wcd->dmic_clk_cnt == 1) {
+			snd_soc_update_bits(codec, dmic_clk_reg,
+					    DMIC_B1_CTL_DMIC0_CLK_SEL_MASK,
+					    DMIC_B1_CTL_DMIC0_CLK_SEL_DIV3);
+			snd_soc_update_bits(codec, dmic_clk_reg,
+					    DMIC_B1_CTL_DMIC0_CLK_EN_MASK,
+					    DMIC_B1_CTL_DMIC0_CLK_EN_ENABLE);
+		}
+		if (dmic == 1)
+			snd_soc_update_bits(codec, LPASS_CDC_TX1_DMIC_CTL,
+					    TXN_DMIC_CTL_CLK_SEL_MASK,
+					    TXN_DMIC_CTL_CLK_SEL_DIV3);
+		if (dmic == 2)
+			snd_soc_update_bits(codec, LPASS_CDC_TX2_DMIC_CTL,
+					    TXN_DMIC_CTL_CLK_SEL_MASK,
+					    TXN_DMIC_CTL_CLK_SEL_DIV3);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (--msm8916_wcd->dmic_clk_cnt == 0)
+			snd_soc_update_bits(codec, dmic_clk_reg,
+					    DMIC_B1_CTL_DMIC0_CLK_EN_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget msm8916_wcd_dapm_widgets[] = {
+	/*RX stuff */
+	SND_SOC_DAPM_AIF_IN("I2S RX1", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("I2S RX2", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("I2S RX3", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("INT_LDO_H", SND_SOC_NOPM, 1, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("HEADPHONE"),
+	SND_SOC_DAPM_PGA_E("HPHL PA", CDC_A_RX_HPH_CNP_EN,
+			   5, 0, NULL, 0,
+			   msm8916_wcd_hph_pa_event, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD |
+			   SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("HPHL", SND_SOC_NOPM, 0, 0, &hphl_mux),
+	SND_SOC_DAPM_MIXER_E("HPHL DAC",
+			     CDC_A_RX_HPH_L_PA_DAC_CTL, 3, 0, NULL,
+			     0, msm8916_wcd_hphl_dac_event,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("HPHR PA", CDC_A_RX_HPH_CNP_EN,
+			   4, 0, NULL, 0,
+			   msm8916_wcd_hph_pa_event, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD |
+			   SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("HPHR", SND_SOC_NOPM, 0, 0, &hphr_mux),
+	SND_SOC_DAPM_MIXER_E("HPHR DAC",
+			     CDC_A_RX_HPH_R_PA_DAC_CTL, 3, 0, NULL,
+			     0, msm8916_wcd_hphr_dac_event,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER("SPK DAC", SND_SOC_NOPM, 0, 0,
+			   spkr_switch, ARRAY_SIZE(spkr_switch)),
+
+	/* Speaker */
+	SND_SOC_DAPM_OUTPUT("SPK_OUT"),
+	SND_SOC_DAPM_PGA_E("SPK PA", CDC_A_SPKR_DRV_CTL,
+			   6, 0, NULL, 0, msm8916_wcd_codec_enable_spk_pa,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER("RX1 MIX1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("RX2 MIX1", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER_E("RX1 MIX2", LPASS_CDC_CLK_RX_B1_CTL, 0, 0, NULL,
+			     0, msm8916_wcd_codec_enable_interpolator,
+			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX2 MIX2", LPASS_CDC_CLK_RX_B1_CTL, 1, 0, NULL,
+			     0, msm8916_wcd_codec_enable_interpolator,
+			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX3 MIX1", LPASS_CDC_CLK_RX_B1_CTL, 2, 0, NULL,
+			     0, msm8916_wcd_codec_enable_interpolator,
+			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("RX1 CLK", CDC_D_CDC_DIG_CLK_CTL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("RX2 CLK", CDC_D_CDC_DIG_CLK_CTL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("RX3 CLK", CDC_D_CDC_DIG_CLK_CTL,
+			    2, 0, msm8916_wcd_codec_enable_dig_clk,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX1 CHAIN", LPASS_CDC_RX1_B6_CTL, 0, 0,
+			     NULL, 0, msm8916_wcd_codec_enable_rx_chain,
+			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX2 CHAIN", LPASS_CDC_RX2_B6_CTL, 0, 0,
+			     NULL, 0, msm8916_wcd_codec_enable_rx_chain,
+			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX3 CHAIN", LPASS_CDC_RX3_B6_CTL, 0, 0,
+			     NULL, 0, msm8916_wcd_codec_enable_rx_chain,
+			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("RX1 MIX1 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx_mix1_inp1_mux),
+	SND_SOC_DAPM_MUX("RX1 MIX1 INP2", SND_SOC_NOPM, 0, 0,
+			 &rx_mix1_inp2_mux),
+	SND_SOC_DAPM_MUX("RX1 MIX1 INP3", SND_SOC_NOPM, 0, 0,
+			 &rx_mix1_inp3_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX1 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx2_mix1_inp1_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX1 INP2", SND_SOC_NOPM, 0, 0,
+			 &rx2_mix1_inp2_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX1 INP3", SND_SOC_NOPM, 0, 0,
+			 &rx2_mix1_inp3_mux),
+	SND_SOC_DAPM_MUX("RX3 MIX1 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx3_mix1_inp1_mux),
+	SND_SOC_DAPM_MUX("RX3 MIX1 INP2", SND_SOC_NOPM, 0, 0,
+			 &rx3_mix1_inp2_mux),
+	SND_SOC_DAPM_MUX("RX3 MIX1 INP3", SND_SOC_NOPM, 0, 0,
+			 &rx3_mix1_inp3_mux),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("vdd-micbias", 0, 0),
+	SND_SOC_DAPM_SUPPLY("CP", CDC_A_NCP_EN, 0, 0,
+			    msm8916_wcd_codec_enable_charge_pump,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("RX_BIAS", SND_SOC_NOPM, 0, 0,
+			    msm8916_wcd_codec_enable_rx_bias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("SPK_RX_BIAS", SND_SOC_NOPM, 0, 0,
+			    msm8916_wcd_codec_enable_rx_bias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* TX */
+	SND_SOC_DAPM_SUPPLY_S("CDC_CONN", -2, LPASS_CDC_CLK_OTHR_CTL,
+			      2, 0, NULL, 0),
+	SND_SOC_DAPM_INPUT("AMIC1"),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_EN, 7, 0,
+			    msm8916_wcd_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal2", CDC_A_MICB_2_EN, 7, 0,
+			    msm8916_wcd_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal3", CDC_A_MICB_1_EN, 7, 0,
+			    msm8916_wcd_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC1", NULL, CDC_A_TX_1_EN, 7, 0,
+			   msm8916_wcd_codec_enable_adc, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2_INP2", NULL, CDC_A_TX_2_EN, 7, 0,
+			   msm8916_wcd_codec_enable_adc, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2_INP3", NULL, CDC_A_TX_3_EN, 7, 0,
+			   msm8916_wcd_codec_enable_adc, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER("ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MUX("ADC2 MUX", SND_SOC_NOPM, 0, 0, &tx_adc2_mux),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS External", CDC_A_MICB_1_EN, 7, 0,
+			    msm8916_wcd_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS External2", CDC_A_MICB_2_EN, 7, 0,
+			    msm8916_wcd_codec_enable_micbias,
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_INPUT("AMIC3"),
+	SND_SOC_DAPM_MUX_E("DEC1 MUX", LPASS_CDC_CLK_TX_CLK_EN_B1_CTL, 0, 0,
+			   &dec1_mux, msm8916_wcd_codec_enable_dec,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX_E("DEC2 MUX", LPASS_CDC_CLK_TX_CLK_EN_B1_CTL, 1, 0,
+			   &dec2_mux, msm8916_wcd_codec_enable_dec,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("RDAC2 MUX", SND_SOC_NOPM, 0, 0, &rdac2_mux),
+	SND_SOC_DAPM_INPUT("AMIC2"),
+	SND_SOC_DAPM_AIF_OUT("I2S TX1", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("I2S TX2", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("I2S TX3", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+	/* Digital Mic Inputs */
+	SND_SOC_DAPM_ADC_E("DMIC1", NULL, SND_SOC_NOPM, 0, 0,
+			   msm8916_wcd_codec_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("DMIC2", NULL, SND_SOC_NOPM, 0, 0,
+			   msm8916_wcd_codec_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+			   SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("RX_I2S_CLK", LPASS_CDC_CLK_RX_I2S_CTL,
+			    4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("TX_I2S_CLK", LPASS_CDC_CLK_TX_I2S_CTL, 4, 0,
+			    NULL, 0),
+};
+
+static int msm8916_wcd_codec_parse_dt(struct platform_device *pdev,
+				      struct msm8916_wcd_chip *chip)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+	struct regulator_bulk_data regs[2];
+	u32 res[2];
+
+	ret = of_property_read_u32_array(np, "reg", res, 2);
+	if (ret < 0)
+		return ret;
+
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,micbias1-ext-cap"))
+		chip->micbias1_cap_mode = MICB_1_EN_EXT_BYP_CAP;
+	else
+		chip->micbias1_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;
+
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,micbias2-ext-cap"))
+		chip->micbias2_cap_mode = MICB_1_EN_EXT_BYP_CAP;
+	else
+		chip->micbias2_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;
+
+	chip->analog_offset = res[0];
+	chip->digital_map = syscon_regmap_lookup_by_phandle(np,
+							    "qcom,lpass-codec-core");
+	if (IS_ERR(chip->digital_map))
+		return PTR_ERR(chip->digital_map);
+
+	chip->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(chip->mclk)) {
+		dev_err(dev, "failed to get mclk\n");
+		return PTR_ERR(chip->mclk);
+	}
+
+	regs[0].supply = "vddio";
+	regs[1].supply = "vdd-tx-rx";
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(regs), regs);
+	if (ret) {
+		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
+		return ret;
+	}
+	chip->vddio = regs[0].consumer;
+	chip->vdd_tx_rx = regs[1].consumer;
+
+	return 0;
+}
+
+static int msm8916_wcd_codec_enable_clock_block(struct snd_soc_codec *codec,
+						int enable)
+{
+	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
+	unsigned long mclk_rate;
+
+	if (enable) {
+		snd_soc_update_bits(codec, LPASS_CDC_CLK_MCLK_CTL,
+				    MCLK_CTL_MCLK_EN_MASK,
+				    MCLK_CTL_MCLK_EN_ENABLE);
+		snd_soc_update_bits(codec, LPASS_CDC_CLK_PDM_CTL,
+				    LPASS_CDC_CLK_PDM_CTL_PDM_EN_MASK |
+				    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK,
+				    LPASS_CDC_CLK_PDM_CTL_PDM_EN |
+				    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_FB);
+		snd_soc_update_bits(codec, CDC_A_MASTER_BIAS_CTL,
+				    MASTER_BIAS_CTL_MASTER_BIAS_EN_MASK |
+				    MASTER_BIAS_CTL_V2L_BUFFER_EN_MASK,
+				    MASTER_BIAS_CTL_MASTER_BIAS_EN_ENABLE |
+				    MASTER_BIAS_CTL_V2L_BUFFER_EN_ENABLE);
+		snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
+				    RST_CTL_DIG_SW_RST_N_MASK,
+				    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
+
+		snd_soc_update_bits(codec, CDC_D_CDC_TOP_CLK_CTL,
+				    TOP_CLK_CTL_A_MCLK_MCLK2_EN_MASK,
+				    TOP_CLK_CTL_A_MCLK_EN_ENABLE |
+				    TOP_CLK_CTL_A_MCLK2_EN_ENABLE);
+
+		mclk_rate = clk_get_rate(msm8916_wcd->mclk);
+
+		if (mclk_rate == 12288000)
+			snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
+					    TOP_CTL_DIG_MCLK_FREQ_MASK,
+					    TOP_CTL_DIG_MCLK_FREQ_F_12_288MHZ);
+
+		else if (mclk_rate == 9600000)
+			snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
+					    TOP_CTL_DIG_MCLK_FREQ_MASK,
+					    TOP_CTL_DIG_MCLK_FREQ_F_9_6MHZ);
+	} else {
+		snd_soc_update_bits(codec, CDC_D_CDC_TOP_CLK_CTL,
+				    TOP_CLK_CTL_A_MCLK_MCLK2_EN_MASK, 0);
+		snd_soc_update_bits(codec, LPASS_CDC_CLK_PDM_CTL,
+				    LPASS_CDC_CLK_PDM_CTL_PDM_EN_MASK |
+				    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK, 0);
+
+	}
+	return 0;
+}
+
+static const struct msm8916_wcd_reg_mask_val wcd_reg_defaults[] = {
+	MSM8916_WCD_REG_VAL(CDC_A_SPKR_DAC_CTL, 0x03),
+	MSM8916_WCD_REG_VAL(CDC_A_CURRENT_LIMIT, 0x82),
+	MSM8916_WCD_REG_VAL(CDC_A_SPKR_OCP_CTL, 0xE1),
+};
+
+static const struct msm8916_wcd_reg_mask_val wcd_reg_defaults_2_0[] = {
+	MSM8916_WCD_REG_VAL(CDC_D_SEC_ACCESS, 0xA5),
+	MSM8916_WCD_REG_VAL(CDC_D_PERPH_RESET_CTL3, 0x0F),
+	MSM8916_WCD_REG_VAL(CDC_A_TX_1_2_OPAMP_BIAS, 0x4F),
+	MSM8916_WCD_REG_VAL(CDC_A_NCP_FBCTRL, 0x28),
+	MSM8916_WCD_REG_VAL(CDC_A_SPKR_DRV_CTL, 0x69),
+	MSM8916_WCD_REG_VAL(CDC_A_SPKR_DRV_DBG, 0x01),
+	MSM8916_WCD_REG_VAL(CDC_A_BOOST_EN_CTL, 0x5F),
+	MSM8916_WCD_REG_VAL(CDC_A_SLOPE_COMP_IP_ZERO, 0x88),
+	MSM8916_WCD_REG_VAL(CDC_A_SEC_ACCESS, 0xA5),
+	MSM8916_WCD_REG_VAL(CDC_A_PERPH_RESET_CTL3, 0x0F),
+	MSM8916_WCD_REG_VAL(CDC_A_CURRENT_LIMIT, 0x82),
+	MSM8916_WCD_REG_VAL(CDC_A_SPKR_DAC_CTL, 0x03),
+	MSM8916_WCD_REG_VAL(CDC_A_SPKR_OCP_CTL, 0xE1),
+};
+
+static const struct msm8916_wcd_reg_mask_val msm8916_wcd_reg_init_val[] = {
+	/**
+	 * Initialize current threshold to 350MA
+	 * number of wait and run cycles to 4096
+	 */
+	{CDC_A_RX_COM_OCP_CTL, 0xFF, 0xD1},
+	{CDC_A_RX_COM_OCP_COUNT, 0xFF, 0xFF},
+};
+
+static int msm8916_wcd_codec_probe(struct snd_soc_codec *codec)
+{
+	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
+	int err, reg;
+
+	err = regulator_enable(chip->vddio);
+	if (err < 0) {
+		dev_err(codec->dev,
+			"failed to enable VDDIO regulator (%d)\n", err);
+		return err;
+	}
+
+	err = regulator_enable(chip->vdd_tx_rx);
+	if (err < 0) {
+		dev_err(codec->dev,
+			"failed to enable VDD_TX_RX regulator (%d)\n", err);
+		regulator_disable(chip->vddio);
+		return err;
+	}
+
+	snd_soc_codec_set_drvdata(codec, chip);
+	chip->pmic_rev = snd_soc_read(codec, CDC_D_REVISION1);
+	chip->codec_version = snd_soc_read(codec, CDC_D_PERPH_SUBTYPE);
+	dev_info(codec->dev, "PMIC REV: %d\t CODEC Version: %d\n",
+		 chip->pmic_rev, chip->codec_version);
+
+	snd_soc_write(codec, CDC_D_PERPH_RESET_CTL4, 0x01);
+	snd_soc_write(codec, CDC_A_PERPH_RESET_CTL4, 0x01);
+
+	for (reg = 0; reg < ARRAY_SIZE(msm8916_wcd_reg_init_val); reg++)
+		snd_soc_update_bits(codec,
+				    msm8916_wcd_reg_init_val[reg].reg,
+				    msm8916_wcd_reg_init_val[reg].mask,
+				    msm8916_wcd_reg_init_val[reg].val);
+
+	if (TOMBAK_IS_1_0(chip->pmic_rev)) {
+		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults); reg++)
+			snd_soc_write(codec, wcd_reg_defaults[reg].reg,
+				      wcd_reg_defaults[reg].val);
+	} else {
+		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
+			snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
+				      wcd_reg_defaults_2_0[reg].val);
+	}
+
+	/* Set initial cap mode */
+	msm8916_wcd_configure_cap(codec, false, false);
+
+	return 0;
+}
+
+static int msm8916_wcd_codec_remove(struct snd_soc_codec *codec)
+{
+	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
+
+	regulator_disable(chip->vddio);
+	regulator_disable(chip->vdd_tx_rx);
+
+	return 0;
+}
+
+static int msm8916_wcd_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	u8 tx_fs_rate;
+
+	switch (params_rate(params)) {
+	case 8000:
+		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_8_KHZ;
+		break;
+	case 16000:
+		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_16_KHZ;
+		break;
+	case 32000:
+		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_32_KHZ;
+		break;
+	case 48000:
+		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_48_KHZ;
+		break;
+	default:
+		dev_err(dai->codec->dev, "Invalid sampling rate %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_CAPTURE:
+		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
+				    TX_I2S_CTL_TX_I2S_FS_RATE_MASK, tx_fs_rate);
+		break;
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
+				    TX_I2S_CTL_TX_I2S_MODE_MASK,
+				    TX_I2S_CTL_TX_I2S_MODE_16);
+		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_RX_I2S_CTL,
+				    RX_I2S_CTL_RX_I2S_MODE_MASK,
+				    RX_I2S_CTL_RX_I2S_MODE_16);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
+				    TX_I2S_CTL_TX_I2S_MODE_MASK,
+				    TX_I2S_CTL_TX_I2S_MODE_32);
+		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_RX_I2S_CTL,
+				    RX_I2S_CTL_RX_I2S_MODE_MASK,
+				    RX_I2S_CTL_RX_I2S_MODE_32);
+		break;
+	default:
+		dev_err(dai->dev, "%s: wrong format selected\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_route msm8916_wcd_audio_map[] = {
+	{"RX_I2S_CLK", NULL, "CDC_CONN"},
+	{"I2S RX1", NULL, "RX_I2S_CLK"},
+	{"I2S RX2", NULL, "RX_I2S_CLK"},
+	{"I2S RX3", NULL, "RX_I2S_CLK"},
+
+	{"I2S TX1", NULL, "TX_I2S_CLK"},
+	{"I2S TX2", NULL, "TX_I2S_CLK"},
+
+	{"I2S TX1", NULL, "DEC1 MUX"},
+	{"I2S TX2", NULL, "DEC2 MUX"},
+
+	/* RDAC Connections */
+	{"HPHR DAC", NULL, "RDAC2 MUX"},
+	{"RDAC2 MUX", "RX1", "RX1 CHAIN"},
+	{"RDAC2 MUX", "RX2", "RX2 CHAIN"},
+
+	/* Headset (RX MIX1 and RX MIX2) */
+	{"HEADPHONE", NULL, "HPHL PA"},
+	{"HEADPHONE", NULL, "HPHR PA"},
+
+	{"HPHL PA", NULL, "HPHL"},
+	{"HPHR PA", NULL, "HPHR"},
+	{"HPHL", "Switch", "HPHL DAC"},
+	{"HPHR", "Switch", "HPHR DAC"},
+	{"HPHL PA", NULL, "CP"},
+	{"HPHL PA", NULL, "RX_BIAS"},
+	{"HPHR PA", NULL, "CP"},
+	{"HPHR PA", NULL, "RX_BIAS"},
+	{"HPHL DAC", NULL, "RX1 CHAIN"},
+
+	{"SPK_OUT", NULL, "SPK PA"},
+	{"SPK PA", NULL, "SPK_RX_BIAS"},
+	{"SPK PA", NULL, "SPK DAC"},
+	{"SPK DAC", "Switch", "RX3 CHAIN"},
+
+	{"RX1 CHAIN", NULL, "RX1 CLK"},
+	{"RX2 CHAIN", NULL, "RX2 CLK"},
+	{"RX3 CHAIN", NULL, "RX3 CLK"},
+	{"RX1 CHAIN", NULL, "RX1 MIX2"},
+	{"RX2 CHAIN", NULL, "RX2 MIX2"},
+	{"RX3 CHAIN", NULL, "RX3 MIX1"},
+
+	{"RX1 MIX1", NULL, "RX1 MIX1 INP1"},
+	{"RX1 MIX1", NULL, "RX1 MIX1 INP2"},
+	{"RX1 MIX1", NULL, "RX1 MIX1 INP3"},
+	{"RX2 MIX1", NULL, "RX2 MIX1 INP1"},
+	{"RX2 MIX1", NULL, "RX2 MIX1 INP2"},
+	{"RX2 MIX1", NULL, "RX2 MIX1 INP3"},
+	{"RX3 MIX1", NULL, "RX3 MIX1 INP1"},
+	{"RX3 MIX1", NULL, "RX3 MIX1 INP2"},
+	{"RX3 MIX1", NULL, "RX3 MIX1 INP3"},
+	{"RX1 MIX2", NULL, "RX1 MIX1"},
+	{"RX2 MIX2", NULL, "RX2 MIX1"},
+
+	{"RX1 MIX1 INP1", "RX1", "I2S RX1"},
+	{"RX1 MIX1 INP1", "RX2", "I2S RX2"},
+	{"RX1 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP2", "RX1", "I2S RX1"},
+	{"RX1 MIX1 INP2", "RX2", "I2S RX2"},
+	{"RX1 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP3", "RX1", "I2S RX1"},
+	{"RX1 MIX1 INP3", "RX2", "I2S RX2"},
+	{"RX1 MIX1 INP3", "RX3", "I2S RX3"},
+
+	{"RX2 MIX1 INP1", "RX1", "I2S RX1"},
+	{"RX2 MIX1 INP1", "RX2", "I2S RX2"},
+	{"RX2 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP2", "RX1", "I2S RX1"},
+	{"RX2 MIX1 INP2", "RX2", "I2S RX2"},
+	{"RX2 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP3", "RX1", "I2S RX1"},
+	{"RX2 MIX1 INP3", "RX2", "I2S RX2"},
+	{"RX2 MIX1 INP3", "RX3", "I2S RX3"},
+
+	{"RX3 MIX1 INP1", "RX1", "I2S RX1"},
+	{"RX3 MIX1 INP1", "RX2", "I2S RX2"},
+	{"RX3 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP2", "RX1", "I2S RX1"},
+	{"RX3 MIX1 INP2", "RX2", "I2S RX2"},
+	{"RX3 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP3", "RX1", "I2S RX1"},
+	{"RX3 MIX1 INP3", "RX2", "I2S RX2"},
+	{"RX3 MIX1 INP3", "RX3", "I2S RX3"},
+
+	/* Decimator Inputs */
+	{"DEC1 MUX", "DMIC1", "DMIC1"},
+	{"DEC1 MUX", "DMIC2", "DMIC2"},
+	{"DEC1 MUX", "ADC1", "ADC1"},
+	{"DEC1 MUX", "ADC2", "ADC2"},
+	{"DEC1 MUX", "ADC3", "ADC3"},
+	{"DEC1 MUX", NULL, "CDC_CONN"},
+
+	{"DEC2 MUX", "DMIC1", "DMIC1"},
+	{"DEC2 MUX", "DMIC2", "DMIC2"},
+	{"DEC2 MUX", "ADC1", "ADC1"},
+	{"DEC2 MUX", "ADC2", "ADC2"},
+	{"DEC2 MUX", "ADC3", "ADC3"},
+	{"DEC2 MUX", NULL, "CDC_CONN"},
+
+	/* ADC Connections */
+	{"ADC2", NULL, "ADC2 MUX"},
+	{"ADC3", NULL, "ADC2 MUX"},
+	{"ADC2 MUX", "INP2", "ADC2_INP2"},
+	{"ADC2 MUX", "INP3", "ADC2_INP3"},
+
+	{"ADC1", NULL, "AMIC1"},
+	{"ADC2_INP2", NULL, "AMIC2"},
+	{"ADC2_INP3", NULL, "AMIC3"},
+
+	{"MIC BIAS Internal1", NULL, "INT_LDO_H"},
+	{"MIC BIAS Internal2", NULL, "INT_LDO_H"},
+	{"MIC BIAS External", NULL, "INT_LDO_H"},
+	{"MIC BIAS External2", NULL, "INT_LDO_H"},
+	{"MIC BIAS Internal1", NULL, "vdd-micbias"},
+	{"MIC BIAS Internal2", NULL, "vdd-micbias"},
+	{"MIC BIAS External", NULL, "vdd-micbias"},
+	{"MIC BIAS External2", NULL, "vdd-micbias"},
+};
+
+static int msm8916_wcd_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	msm8916_wcd_codec_enable_clock_block(dai->codec, 1);
+	return 0;
+}
+
+static void msm8916_wcd_shutdown(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	msm8916_wcd_codec_enable_clock_block(dai->codec, 0);
+}
+
+static struct snd_soc_dai_ops msm8916_wcd_dai_ops = {
+	.startup = msm8916_wcd_startup,
+	.shutdown = msm8916_wcd_shutdown,
+	.hw_params = msm8916_wcd_hw_params,
+};
+
+static struct snd_soc_dai_driver msm8916_wcd_codec_dai[] = {
+	[0] = {
+	       .name = "msm8916_wcd_i2s_rx1",
+	       .id = MSM8916_WCD_PLAYBACK_DAI,
+	       .playback = {
+			    .stream_name = "AIF1 Playback",
+			    .rates = MSM8916_WCD_RATES,
+			    .formats = MSM8916_WCD_FORMATS,
+			    .channels_min = 1,
+			    .channels_max = 3,
+			    },
+	       .ops = &msm8916_wcd_dai_ops,
+	       },
+	[1] = {
+	       .name = "msm8916_wcd_i2s_tx1",
+	       .id = MSM8916_WCD_CAPTURE_DAI,
+	       .capture = {
+			   .stream_name = "AIF1 Capture",
+			   .rates = MSM8916_WCD_RATES,
+			   .formats = MSM8916_WCD_FORMATS,
+			   .channels_min = 1,
+			   .channels_max = 4,
+			   },
+	       .ops = &msm8916_wcd_dai_ops,
+	       },
+};
+
+static struct snd_soc_codec_driver msm8916_wcd_codec = {
+	.probe = msm8916_wcd_codec_probe,
+	.remove = msm8916_wcd_codec_remove,
+	.read = msm8916_wcd_read,
+	.write = msm8916_wcd_write,
+	.reg_cache_size = MSM8916_WCD_NUM_REGISTERS,
+	.reg_cache_default = msm8916_wcd_reset_reg_defaults,
+	.reg_word_size = 1,
+	.controls = msm8916_wcd_snd_controls,
+	.num_controls = ARRAY_SIZE(msm8916_wcd_snd_controls),
+	.dapm_widgets = msm8916_wcd_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(msm8916_wcd_dapm_widgets),
+	.dapm_routes = msm8916_wcd_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(msm8916_wcd_audio_map),
+};
+
+static int msm8916_wcd_probe(struct platform_device *pdev)
+{
+	struct msm8916_wcd_chip *chip;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->analog_map = dev_get_regmap(dev->parent, NULL);
+	if (!chip->analog_map)
+		return -ENXIO;
+
+	ret = msm8916_wcd_codec_parse_dt(pdev, chip);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(chip->mclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable mclk %d\n", ret);
+		return ret;
+	}
+
+	dev_set_drvdata(dev, chip);
+
+	return snd_soc_register_codec(dev, &msm8916_wcd_codec,
+				      msm8916_wcd_codec_dai,
+				      ARRAY_SIZE(msm8916_wcd_codec_dai));
+}
+
+static int msm8916_wcd_remove(struct platform_device *pdev)
+{
+	struct msm8916_wcd_chip *chip = dev_get_drvdata(&pdev->dev);
+
+	clk_disable_unprepare(chip->mclk);
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id msm8916_wcd_match_table[] = {
+	{.compatible = "qcom,msm8916-pmic-wcd-codec"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, msm8916_wcd_match_table);
+
+static struct platform_driver msm8916_wcd_driver = {
+	.driver = {
+		   .name = "msm8916-pmic-wcd-codec",
+		   .of_match_table = msm8916_wcd_match_table,
+		   },
+	.probe = msm8916_wcd_probe,
+	.remove = msm8916_wcd_remove,
+};
+
+module_platform_driver(msm8916_wcd_driver);
+
+MODULE_ALIAS("platform:spmi-wcd-codec");
+MODULE_DESCRIPTION("SPMI PMIC WCD codec driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/msm8916-wcd.h b/sound/soc/codecs/msm8916-wcd.h
new file mode 100644
index 0000000..5fc8137
--- /dev/null
+++ b/sound/soc/codecs/msm8916-wcd.h
@@ -0,0 +1,308 @@
+/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef MSM8916_WCD_H
+#define MSM8916_WCD_H
+
+#include "msm8916-wcd-registers.h"
+
+#define MSM8916_WCD_NUM_REGISTERS	0x6FF
+#define MSM8916_WCD_MAX_REGISTER	(MSM8916_WCD_NUM_REGISTERS-1)
+#define MSM8916_WCD_REG_VAL(reg, val)		{reg, 0, val}
+#define MSM8916_WCD_REG_VAL_MASK	0xFF
+#define MSM8916_WCD_DIGITAL_REG(reg) ((reg ^ 0x0200) & 0x0FFF)
+#define MSM8916_WCD_IS_DIGITAL_REG(reg) \
+	(((reg >= 0x200) && (reg <= 0x4FF)) ? 1 : 0)
+#define MSM8916_WCD_IS_TOMBAK_REG(reg) \
+	(((reg >= 0x000) && (reg <= 0x1FF)) ? 1 : 0)
+#define TOMBAK_VERSION_1_0	0
+#define TOMBAK_IS_1_0(ver) ((ver == TOMBAK_VERSION_1_0) ? 1 : 0)
+
+struct msm8916_wcd_reg_mask_val {
+	u16 reg;
+	u8 mask;
+	u8 val;
+};
+
+const u8 msm8916_wcd_reg_readonly[MSM8916_WCD_NUM_REGISTERS] = {
+	[CDC_D_REVISION1] = 1,
+	[CDC_D_REVISION2] = 1,
+	[CDC_D_PERPH_TYPE] = 1,
+	[CDC_D_PERPH_SUBTYPE] = 1,
+	[CDC_D_INT_RT_STS] = 1,
+	[CDC_D_INT_SET_TYPE] = 1,
+	[CDC_D_INT_POLARITY_HIGH] = 1,
+	[CDC_D_INT_POLARITY_LOW] = 1,
+	[CDC_D_INT_LATCHED_STS] = 1,
+	[CDC_D_INT_PENDING_STS] = 1,
+	[CDC_D_PIN_STATUS] = 1,
+	[CDC_A_REVISION1] = 1,
+	[CDC_A_REVISION2] = 1,
+	[CDC_A_REVISION3] = 1,
+	[CDC_A_REVISION4] = 1,
+	[CDC_A_PERPH_TYPE] = 1,
+	[CDC_A_PERPH_SUBTYPE] = 1,
+	[CDC_A_INT_RT_STS] = 1,
+	[CDC_A_INT_SET_TYPE] = 1,
+	[CDC_A_INT_POLARITY_HIGH] = 1,
+	[CDC_A_INT_POLARITY_LOW] = 1,
+	[CDC_A_INT_LATCHED_STS] = 1,
+	[CDC_A_INT_PENDING_STS] = 1,
+	[CDC_A_MBHC_BTN_RESULT] = 1,
+	[CDC_A_MBHC_ZDET_ELECT_RESULT] = 1,
+	[CDC_A_RX_HPH_STATUS] = 1,
+	[CDC_A_RX_EAR_STATUS] = 1,
+	[CDC_A_SPKR_SAR_STATUS] = 1,
+	[CDC_A_SPKR_DRV_STATUS] = 1,
+	[LPASS_CDC_RX1_B1_CTL] = 1,
+	[LPASS_CDC_RX2_B1_CTL] = 1,
+	[LPASS_CDC_RX3_B1_CTL] = 1,
+	[LPASS_CDC_RX1_B6_CTL] = 1,
+	[LPASS_CDC_RX2_B6_CTL] = 1,
+	[LPASS_CDC_RX3_B6_CTL] = 1,
+	[LPASS_CDC_TX1_VOL_CTL_CFG] = 1,
+	[LPASS_CDC_TX2_VOL_CTL_CFG] = 1,
+	[LPASS_CDC_IIR1_COEF_B1_CTL] = 1,
+	[LPASS_CDC_IIR2_COEF_B1_CTL] = 1,
+	[LPASS_CDC_CLK_MCLK_CTL] = 1,
+	[LPASS_CDC_CLK_PDM_CTL] = 1,
+};
+
+#define MSM8916_REG_POR(reg) [reg] = reg##_POR
+
+u8 msm8916_wcd_reset_reg_defaults[MSM8916_WCD_NUM_REGISTERS] = {
+	MSM8916_REG_POR(CDC_D_REVISION1),
+	MSM8916_REG_POR(CDC_D_REVISION2),
+	MSM8916_REG_POR(CDC_D_PERPH_TYPE),
+	MSM8916_REG_POR(CDC_D_PERPH_SUBTYPE),
+	MSM8916_REG_POR(CDC_D_INT_RT_STS),
+	MSM8916_REG_POR(CDC_D_INT_SET_TYPE),
+	MSM8916_REG_POR(CDC_D_INT_POLARITY_HIGH),
+	MSM8916_REG_POR(CDC_D_INT_POLARITY_LOW),
+	MSM8916_REG_POR(CDC_D_INT_LATCHED_CLR),
+	MSM8916_REG_POR(CDC_D_INT_EN_SET),
+	MSM8916_REG_POR(CDC_D_INT_EN_CLR),
+	MSM8916_REG_POR(CDC_D_INT_LATCHED_STS),
+	MSM8916_REG_POR(CDC_D_INT_PENDING_STS),
+	MSM8916_REG_POR(CDC_D_INT_MID_SEL),
+	MSM8916_REG_POR(CDC_D_INT_PRIORITY),
+	MSM8916_REG_POR(CDC_D_GPIO_MODE),
+	MSM8916_REG_POR(CDC_D_PIN_CTL_OE),
+	MSM8916_REG_POR(CDC_D_PIN_CTL_DATA),
+	MSM8916_REG_POR(CDC_D_PIN_STATUS),
+	MSM8916_REG_POR(CDC_D_HDRIVE_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_RST_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_TOP_CLK_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_ANA_CLK_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_DIG_CLK_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_TX1_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_TX2_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_HPHR_DAC_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_RX1_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_RX2_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_RX3_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_CONN_RX_LB_CTL),
+	MSM8916_REG_POR(CDC_D_CDC_RX_CTL1),
+	MSM8916_REG_POR(CDC_D_CDC_RX_CTL2),
+	MSM8916_REG_POR(CDC_D_CDC_RX_CTL3),
+	MSM8916_REG_POR(CDC_D_DEM_BYPASS_DATA0),
+	MSM8916_REG_POR(CDC_D_DEM_BYPASS_DATA1),
+	MSM8916_REG_POR(CDC_D_DEM_BYPASS_DATA2),
+	MSM8916_REG_POR(CDC_D_DEM_BYPASS_DATA3),
+	MSM8916_REG_POR(CDC_D_SPARE_0),
+	MSM8916_REG_POR(CDC_D_SPARE_1),
+	MSM8916_REG_POR(CDC_D_SPARE_2),
+	MSM8916_REG_POR(CDC_A_REVISION1),
+	MSM8916_REG_POR(CDC_A_REVISION2),
+	MSM8916_REG_POR(CDC_A_REVISION3),
+	MSM8916_REG_POR(CDC_A_REVISION4),
+	MSM8916_REG_POR(CDC_A_PERPH_TYPE),
+	MSM8916_REG_POR(CDC_A_PERPH_SUBTYPE),
+	MSM8916_REG_POR(CDC_A_INT_RT_STS),
+	MSM8916_REG_POR(CDC_A_INT_SET_TYPE),
+	MSM8916_REG_POR(CDC_A_INT_POLARITY_HIGH),
+	MSM8916_REG_POR(CDC_A_INT_POLARITY_LOW),
+	MSM8916_REG_POR(CDC_A_INT_LATCHED_CLR),
+	MSM8916_REG_POR(CDC_A_INT_EN_SET),
+	MSM8916_REG_POR(CDC_A_INT_EN_CLR),
+	MSM8916_REG_POR(CDC_A_INT_LATCHED_STS),
+	MSM8916_REG_POR(CDC_A_INT_PENDING_STS),
+	MSM8916_REG_POR(CDC_A_INT_MID_SEL),
+	MSM8916_REG_POR(CDC_A_INT_PRIORITY),
+	MSM8916_REG_POR(CDC_A_MICB_1_EN),
+	MSM8916_REG_POR(CDC_A_MICB_1_VAL),
+	MSM8916_REG_POR(CDC_A_MICB_1_CTL),
+	MSM8916_REG_POR(CDC_A_MICB_1_INT_RBIAS),
+	MSM8916_REG_POR(CDC_A_MICB_2_EN),
+	MSM8916_REG_POR(CDC_A_MBHC_DET_CTL_1),
+	MSM8916_REG_POR(CDC_A_MBHC_DET_CTL_2),
+	MSM8916_REG_POR(CDC_A_MBHC_FSM_CTL),
+	MSM8916_REG_POR(CDC_A_MBHC_DBNC_TIMER),
+	MSM8916_REG_POR(CDC_A_MBHC_BTN0_ZDETL_CTL),
+	MSM8916_REG_POR(CDC_A_MBHC_BTN1_ZDETM_CTL),
+	MSM8916_REG_POR(CDC_A_MBHC_BTN2_ZDETH_CTL),
+	MSM8916_REG_POR(CDC_A_MBHC_BTN3_CTL),
+	MSM8916_REG_POR(CDC_A_MBHC_BTN4_CTL),
+	MSM8916_REG_POR(CDC_A_MBHC_BTN_RESULT),
+	MSM8916_REG_POR(CDC_A_MBHC_ZDET_ELECT_RESULT),
+	MSM8916_REG_POR(CDC_A_TX_1_EN),
+	MSM8916_REG_POR(CDC_A_TX_2_EN),
+	MSM8916_REG_POR(CDC_A_TX_1_2_TEST_CTL_1),
+	MSM8916_REG_POR(CDC_A_TX_1_2_TEST_CTL_2),
+	MSM8916_REG_POR(CDC_A_TX_1_2_ATEST_CTL),
+	MSM8916_REG_POR(CDC_A_TX_1_2_OPAMP_BIAS),
+	MSM8916_REG_POR(CDC_A_TX_1_2_TXFE_CLKDIV),
+	MSM8916_REG_POR(CDC_A_TX_3_EN),
+	MSM8916_REG_POR(CDC_A_NCP_EN),
+	MSM8916_REG_POR(CDC_A_NCP_CLK),
+	MSM8916_REG_POR(CDC_A_NCP_DEGLITCH),
+	MSM8916_REG_POR(CDC_A_NCP_FBCTRL),
+	MSM8916_REG_POR(CDC_A_NCP_BIAS),
+	MSM8916_REG_POR(CDC_A_NCP_VCTRL),
+	MSM8916_REG_POR(CDC_A_NCP_TEST),
+	MSM8916_REG_POR(CDC_A_RX_CLOCK_DIVIDER),
+	MSM8916_REG_POR(CDC_A_RX_COM_OCP_CTL),
+	MSM8916_REG_POR(CDC_A_RX_COM_OCP_COUNT),
+	MSM8916_REG_POR(CDC_A_RX_COM_BIAS_DAC),
+	MSM8916_REG_POR(CDC_A_RX_HPH_BIAS_PA),
+	MSM8916_REG_POR(CDC_A_RX_HPH_BIAS_LDO_OCP),
+	MSM8916_REG_POR(CDC_A_RX_HPH_BIAS_CNP),
+	MSM8916_REG_POR(CDC_A_RX_HPH_CNP_EN),
+	MSM8916_REG_POR(CDC_A_RX_HPH_CNP_WG_CTL),
+	MSM8916_REG_POR(CDC_A_RX_HPH_CNP_WG_TIME),
+	MSM8916_REG_POR(CDC_A_RX_HPH_L_TEST),
+	MSM8916_REG_POR(CDC_A_RX_HPH_L_PA_DAC_CTL),
+	MSM8916_REG_POR(CDC_A_RX_HPH_R_TEST),
+	MSM8916_REG_POR(CDC_A_RX_HPH_R_PA_DAC_CTL),
+	MSM8916_REG_POR(CDC_A_RX_EAR_CTL),
+	MSM8916_REG_POR(CDC_A_RX_ATEST),
+	MSM8916_REG_POR(CDC_A_RX_HPH_STATUS),
+	MSM8916_REG_POR(CDC_A_RX_EAR_STATUS),
+	MSM8916_REG_POR(CDC_A_SPKR_DAC_CTL),
+	MSM8916_REG_POR(CDC_A_SPKR_DRV_CLIP_DET),
+	MSM8916_REG_POR(CDC_A_SPKR_DRV_CTL),
+	MSM8916_REG_POR(CDC_A_SPKR_ANA_BIAS_SET),
+	MSM8916_REG_POR(CDC_A_SPKR_OCP_CTL),
+	MSM8916_REG_POR(CDC_A_SPKR_PWRSTG_CTL),
+	MSM8916_REG_POR(CDC_A_SPKR_DRV_MISC),
+	MSM8916_REG_POR(CDC_A_SPKR_DRV_DBG),
+	MSM8916_REG_POR(CDC_A_CURRENT_LIMIT),
+	MSM8916_REG_POR(CDC_A_OUTPUT_VOLTAGE),
+	MSM8916_REG_POR(CDC_A_BYPASS_MODE),
+	MSM8916_REG_POR(CDC_A_BOOST_EN_CTL),
+	MSM8916_REG_POR(CDC_A_SLOPE_COMP_IP_ZERO),
+	MSM8916_REG_POR(CDC_A_RDSON_MAX_DUTY_CYCLE),
+	MSM8916_REG_POR(CDC_A_BOOST_TEST1_1),
+	MSM8916_REG_POR(CDC_A_BOOST_TEST_2),
+	MSM8916_REG_POR(CDC_A_SPKR_SAR_STATUS),
+	MSM8916_REG_POR(CDC_A_SPKR_DRV_STATUS),
+	MSM8916_REG_POR(CDC_A_PBUS_ADD_CSR),
+	MSM8916_REG_POR(CDC_A_PBUS_ADD_SEL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_RX_RESET_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_TX_RESET_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_DMIC_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_RX_I2S_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_TX_I2S_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_OTHR_RESET_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_TX_CLK_EN_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_OTHR_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_RX_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_MCLK_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_PDM_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CLK_SD_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_B5_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_B5_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_B5_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_B6_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_B6_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_B6_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_VOL_CTL_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_VOL_CTL_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_VOL_CTL_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX1_VOL_CTL_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX2_VOL_CTL_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_RX3_VOL_CTL_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TOP_GAIN_UPDATE),
+	MSM8916_REG_POR(LPASS_CDC_TOP_CTL),
+	MSM8916_REG_POR(LPASS_CDC_DEBUG_DESER1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_DEBUG_DESER2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_DEBUG_B1_CTL_CFG),
+	MSM8916_REG_POR(LPASS_CDC_DEBUG_B2_CTL_CFG),
+	MSM8916_REG_POR(LPASS_CDC_DEBUG_B3_CTL_CFG),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B5_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B5_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B6_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B6_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B7_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B7_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_B8_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_B8_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_GAIN_TIMER_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_GAIN_TIMER_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_COEF_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_COEF_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR1_COEF_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_IIR2_COEF_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX1_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX1_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX1_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX2_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX2_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX2_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX3_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_RX3_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_TX_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ1_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ1_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ1_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ1_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ2_B1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ2_B2_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ2_B3_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_EQ2_B4_CTL),
+	MSM8916_REG_POR(LPASS_CDC_CONN_TX_I2S_SD1_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TX1_VOL_CTL_TIMER),
+	MSM8916_REG_POR(LPASS_CDC_TX2_VOL_CTL_TIMER),
+	MSM8916_REG_POR(LPASS_CDC_TX1_VOL_CTL_GAIN),
+	MSM8916_REG_POR(LPASS_CDC_TX2_VOL_CTL_GAIN),
+	MSM8916_REG_POR(LPASS_CDC_TX1_VOL_CTL_CFG),
+	MSM8916_REG_POR(LPASS_CDC_TX2_VOL_CTL_CFG),
+	MSM8916_REG_POR(LPASS_CDC_TX1_MUX_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TX2_MUX_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TX1_CLK_FS_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TX2_CLK_FS_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TX1_DMIC_CTL),
+	MSM8916_REG_POR(LPASS_CDC_TX2_DMIC_CTL),
+};
+
+#endif /* MSM8916_WCD_H */
-- 
2.8.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
