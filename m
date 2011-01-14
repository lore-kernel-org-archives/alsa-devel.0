From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8991: Add initial WM8991 driver
Date: Fri, 14 Jan 2011 15:49:40 +0000
Message-ID: <1295020180-26564-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03A2F2436A
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 16:49:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The WM8991 is a highly integrated ultra-low power hi-fi CODEC designed for
handsets rich in multimedia features such as GPS, mobile TV, digital audio
playback and gaming.

This driver was originally written by Graeme Gregory and has been maintained
out of tree by Mark Brown and Dimitris Papastamos.

Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/wm8991.c | 1427 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8991.h |  833 ++++++++++++++++++++++++++
 4 files changed, 2266 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wm8991.c
 create mode 100644 sound/soc/codecs/wm8991.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 61e36ef..a18cff4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -77,6 +77,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8985 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8988 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8990 if I2C
+	select SND_SOC_WM8991 if I2C
 	select SND_SOC_WM8993 if I2C
 	select SND_SOC_WM8994 if MFD_WM8994
 	select SND_SOC_WM8995 if SND_SOC_I2C_AND_SPI
@@ -308,6 +309,9 @@ config SND_SOC_WM8988
 config SND_SOC_WM8990
 	tristate
 
+config SND_SOC_WM8991
+	tristate
+
 config SND_SOC_WM8993
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 333910a..68e76af 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -62,6 +62,7 @@ snd-soc-wm8978-objs := wm8978.o
 snd-soc-wm8985-objs := wm8985.o
 snd-soc-wm8988-objs := wm8988.o
 snd-soc-wm8990-objs := wm8990.o
+snd-soc-wm8991-objs := wm8991.o
 snd-soc-wm8993-objs := wm8993.o
 snd-soc-wm8994-objs := wm8994.o wm8994-tables.o
 snd-soc-wm8995-objs := wm8995.o
@@ -143,6 +144,7 @@ obj-$(CONFIG_SND_SOC_WM8978)	+= snd-soc-wm8978.o
 obj-$(CONFIG_SND_SOC_WM8985)	+= snd-soc-wm8985.o
 obj-$(CONFIG_SND_SOC_WM8988)	+= snd-soc-wm8988.o
 obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
+obj-$(CONFIG_SND_SOC_WM8991)	+= snd-soc-wm8991.o
 obj-$(CONFIG_SND_SOC_WM8993)	+= snd-soc-wm8993.o
 obj-$(CONFIG_SND_SOC_WM8994)	+= snd-soc-wm8994.o
 obj-$(CONFIG_SND_SOC_WM8995)	+= snd-soc-wm8995.o
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
new file mode 100644
index 0000000..28fdfd6
--- /dev/null
+++ b/sound/soc/codecs/wm8991.c
@@ -0,0 +1,1427 @@
+/*
+ * wm8991.c  --  WM8991 ALSA Soc Audio driver
+ *
+ * Copyright 2007-2010 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <asm/div64.h>
+
+#include "wm8991.h"
+
+struct wm8991_priv {
+	enum snd_soc_control_type control_type;
+	unsigned int pcmclk;
+};
+
+static const u16 wm8991_reg_defs[] = {
+	0x8991,     /* R0  - Reset */
+	0x0000,     /* R1  - Power Management (1) */
+	0x6000,     /* R2  - Power Management (2) */
+	0x0000,     /* R3  - Power Management (3) */
+	0x4050,     /* R4  - Audio Interface (1) */
+	0x4000,     /* R5  - Audio Interface (2) */
+	0x01C8,     /* R6  - Clocking (1) */
+	0x0000,     /* R7  - Clocking (2) */
+	0x0040,     /* R8  - Audio Interface (3) */
+	0x0040,     /* R9  - Audio Interface (4) */
+	0x0004,     /* R10 - DAC CTRL */
+	0x00C0,     /* R11 - Left DAC Digital Volume */
+	0x00C0,     /* R12 - Right DAC Digital Volume */
+	0x0000,     /* R13 - Digital Side Tone */
+	0x0100,     /* R14 - ADC CTRL */
+	0x00C0,     /* R15 - Left ADC Digital Volume */
+	0x00C0,     /* R16 - Right ADC Digital Volume */
+	0x0000,     /* R17 */
+	0x0000,     /* R18 - GPIO CTRL 1 */
+	0x1000,     /* R19 - GPIO1 & GPIO2 */
+	0x1010,     /* R20 - GPIO3 & GPIO4 */
+	0x1010,     /* R21 - GPIO5 & GPIO6 */
+	0x8000,     /* R22 - GPIOCTRL 2 */
+	0x0800,     /* R23 - GPIO_POL */
+	0x008B,     /* R24 - Left Line Input 1&2 Volume */
+	0x008B,     /* R25 - Left Line Input 3&4 Volume */
+	0x008B,     /* R26 - Right Line Input 1&2 Volume */
+	0x008B,     /* R27 - Right Line Input 3&4 Volume */
+	0x0000,     /* R28 - Left Output Volume */
+	0x0000,     /* R29 - Right Output Volume */
+	0x0066,     /* R30 - Line Outputs Volume */
+	0x0022,     /* R31 - Out3/4 Volume */
+	0x0079,     /* R32 - Left OPGA Volume */
+	0x0079,     /* R33 - Right OPGA Volume */
+	0x0003,     /* R34 - Speaker Volume */
+	0x0003,     /* R35 - ClassD1 */
+	0x0000,     /* R36 */
+	0x0100,     /* R37 - ClassD3 */
+	0x0000,     /* R38 */
+	0x0000,     /* R39 - Input Mixer1 */
+	0x0000,     /* R40 - Input Mixer2 */
+	0x0000,     /* R41 - Input Mixer3 */
+	0x0000,     /* R42 - Input Mixer4 */
+	0x0000,     /* R43 - Input Mixer5 */
+	0x0000,     /* R44 - Input Mixer6 */
+	0x0000,     /* R45 - Output Mixer1 */
+	0x0000,     /* R46 - Output Mixer2 */
+	0x0000,     /* R47 - Output Mixer3 */
+	0x0000,     /* R48 - Output Mixer4 */
+	0x0000,     /* R49 - Output Mixer5 */
+	0x0000,     /* R50 - Output Mixer6 */
+	0x0180,     /* R51 - Out3/4 Mixer */
+	0x0000,     /* R52 - Line Mixer1 */
+	0x0000,     /* R53 - Line Mixer2 */
+	0x0000,     /* R54 - Speaker Mixer */
+	0x0000,     /* R55 - Additional Control */
+	0x0000,     /* R56 - AntiPOP1 */
+	0x0000,     /* R57 - AntiPOP2 */
+	0x0000,     /* R58 - MICBIAS */
+	0x0000,     /* R59 */
+	0x0008,     /* R60 - PLL1 */
+	0x0031,     /* R61 - PLL2 */
+	0x0026,     /* R62 - PLL3 */
+};
+
+#define wm8991_reset(c) snd_soc_write(c, WM8991_RESET, 0)
+
+static const unsigned int rec_mix_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 7, TLV_DB_LINEAR_ITEM(-1500, 600),
+};
+
+static const unsigned int in_pga_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 0x1F, TLV_DB_LINEAR_ITEM(-1650, 3000),
+};
+
+static const unsigned int out_mix_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 7, TLV_DB_LINEAR_ITEM(0, -2100),
+};
+
+static const unsigned int out_pga_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 127, TLV_DB_LINEAR_ITEM(-7300, 600),
+};
+
+static const unsigned int out_omix_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 7, TLV_DB_LINEAR_ITEM(-600, 0),
+};
+
+static const unsigned int out_dac_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 255, TLV_DB_LINEAR_ITEM(-7163, 0),
+};
+
+static const unsigned int in_adc_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 255, TLV_DB_LINEAR_ITEM(-7163, 1763),
+};
+
+static const unsigned int out_sidetone_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 31, TLV_DB_LINEAR_ITEM(-3600, 0),
+};
+
+static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int ret;
+	u16 val;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	/* now hit the volume update bits (always bit 8) */
+	val = snd_soc_read(codec, reg);
+	return snd_soc_write(codec, reg, val | 0x0100);
+}
+
+static const char *wm8991_digital_sidetone[] =
+{"None", "Left ADC", "Right ADC", "Reserved"};
+
+static const struct soc_enum wm8991_left_digital_sidetone_enum =
+	SOC_ENUM_SINGLE(WM8991_DIGITAL_SIDE_TONE,
+			WM8991_ADC_TO_DACL_SHIFT,
+			WM8991_ADC_TO_DACL_MASK,
+			wm8991_digital_sidetone);
+
+static const struct soc_enum wm8991_right_digital_sidetone_enum =
+	SOC_ENUM_SINGLE(WM8991_DIGITAL_SIDE_TONE,
+			WM8991_ADC_TO_DACR_SHIFT,
+			WM8991_ADC_TO_DACR_MASK,
+			wm8991_digital_sidetone);
+
+static const char *wm8991_adcmode[] =
+{"Hi-fi mode", "Voice mode 1", "Voice mode 2", "Voice mode 3"};
+
+static const struct soc_enum wm8991_right_adcmode_enum =
+	SOC_ENUM_SINGLE(WM8991_ADC_CTRL,
+			WM8991_ADC_HPF_CUT_SHIFT,
+			WM8991_ADC_HPF_CUT_MASK,
+			wm8991_adcmode);
+
+static const struct snd_kcontrol_new wm8991_snd_controls[] = {
+	/* INMIXL */
+	SOC_SINGLE("LIN12 PGA Boost", WM8991_INPUT_MIXER3, WM8991_L12MNBST_BIT, 1, 0),
+	SOC_SINGLE("LIN34 PGA Boost", WM8991_INPUT_MIXER3, WM8991_L34MNBST_BIT, 1, 0),
+	/* INMIXR */
+	SOC_SINGLE("RIN12 PGA Boost", WM8991_INPUT_MIXER3, WM8991_R12MNBST_BIT, 1, 0),
+	SOC_SINGLE("RIN34 PGA Boost", WM8991_INPUT_MIXER3, WM8991_R34MNBST_BIT, 1, 0),
+
+	/* LOMIX */
+	SOC_SINGLE_TLV("LOMIX LIN3 Bypass Volume", WM8991_OUTPUT_MIXER3,
+		WM8991_LLI3LOVOL_SHIFT, WM8991_LLI3LOVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("LOMIX RIN12 PGA Bypass Volume", WM8991_OUTPUT_MIXER3,
+		WM8991_LR12LOVOL_SHIFT, WM8991_LR12LOVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("LOMIX LIN12 PGA Bypass Volume", WM8991_OUTPUT_MIXER3,
+		WM8991_LL12LOVOL_SHIFT, WM8991_LL12LOVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("LOMIX RIN3 Bypass Volume", WM8991_OUTPUT_MIXER5,
+		WM8991_LRI3LOVOL_SHIFT, WM8991_LRI3LOVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("LOMIX AINRMUX Bypass Volume", WM8991_OUTPUT_MIXER5,
+		WM8991_LRBLOVOL_SHIFT, WM8991_LRBLOVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("LOMIX AINLMUX Bypass Volume", WM8991_OUTPUT_MIXER5,
+		WM8991_LRBLOVOL_SHIFT, WM8991_LRBLOVOL_MASK, 1, out_mix_tlv),
+
+	/* ROMIX */
+	SOC_SINGLE_TLV("ROMIX RIN3 Bypass Volume", WM8991_OUTPUT_MIXER4,
+		WM8991_RRI3ROVOL_SHIFT, WM8991_RRI3ROVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("ROMIX LIN12 PGA Bypass Volume", WM8991_OUTPUT_MIXER4,
+		WM8991_RL12ROVOL_SHIFT, WM8991_RL12ROVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("ROMIX RIN12 PGA Bypass Volume", WM8991_OUTPUT_MIXER4,
+		WM8991_RR12ROVOL_SHIFT, WM8991_RR12ROVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("ROMIX LIN3 Bypass Volume", WM8991_OUTPUT_MIXER6,
+		WM8991_RLI3ROVOL_SHIFT, WM8991_RLI3ROVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("ROMIX AINLMUX Bypass Volume", WM8991_OUTPUT_MIXER6,
+		WM8991_RLBROVOL_SHIFT, WM8991_RLBROVOL_MASK, 1, out_mix_tlv),
+	SOC_SINGLE_TLV("ROMIX AINRMUX Bypass Volume", WM8991_OUTPUT_MIXER6,
+		WM8991_RRBROVOL_SHIFT, WM8991_RRBROVOL_MASK, 1, out_mix_tlv),
+
+	/* LOUT */
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("LOUT Volume", WM8991_LEFT_OUTPUT_VOLUME,
+		WM8991_LOUTVOL_SHIFT, WM8991_LOUTVOL_MASK, 0, out_pga_tlv),
+	SOC_SINGLE("LOUT ZC", WM8991_LEFT_OUTPUT_VOLUME, WM8991_LOZC_BIT, 1, 0),
+
+	/* ROUT */
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("ROUT Volume", WM8991_RIGHT_OUTPUT_VOLUME,
+		WM8991_ROUTVOL_SHIFT, WM8991_ROUTVOL_MASK, 0, out_pga_tlv),
+	SOC_SINGLE("ROUT ZC", WM8991_RIGHT_OUTPUT_VOLUME, WM8991_ROZC_BIT, 1, 0),
+
+	/* LOPGA */
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("LOPGA Volume", WM8991_LEFT_OPGA_VOLUME,
+		WM8991_LOPGAVOL_SHIFT, WM8991_LOPGAVOL_MASK, 0, out_pga_tlv),
+	SOC_SINGLE("LOPGA ZC Switch", WM8991_LEFT_OPGA_VOLUME,
+		WM8991_LOPGAZC_BIT, 1, 0),
+
+	/* ROPGA */
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("ROPGA Volume", WM8991_RIGHT_OPGA_VOLUME,
+		WM8991_ROPGAVOL_SHIFT, WM8991_ROPGAVOL_MASK, 0, out_pga_tlv),
+	SOC_SINGLE("ROPGA ZC Switch", WM8991_RIGHT_OPGA_VOLUME,
+		WM8991_ROPGAZC_BIT, 1, 0),
+
+	SOC_SINGLE("LON Mute Switch", WM8991_LINE_OUTPUTS_VOLUME,
+		WM8991_LONMUTE_BIT, 1, 0),
+	SOC_SINGLE("LOP Mute Switch", WM8991_LINE_OUTPUTS_VOLUME,
+		WM8991_LOPMUTE_BIT, 1, 0),
+	SOC_SINGLE("LOP Attenuation Switch", WM8991_LINE_OUTPUTS_VOLUME,
+		WM8991_LOATTN_BIT, 1, 0),
+	SOC_SINGLE("RON Mute Switch", WM8991_LINE_OUTPUTS_VOLUME,
+		WM8991_RONMUTE_BIT, 1, 0),
+	SOC_SINGLE("ROP Mute Switch", WM8991_LINE_OUTPUTS_VOLUME,
+		WM8991_ROPMUTE_BIT, 1, 0),
+	SOC_SINGLE("ROP Attenuation Switch", WM8991_LINE_OUTPUTS_VOLUME,
+		WM8991_ROATTN_BIT, 1, 0),
+
+	SOC_SINGLE("OUT3 Mute Switch", WM8991_OUT3_4_VOLUME,
+		WM8991_OUT3MUTE_BIT, 1, 0),
+	SOC_SINGLE("OUT3 Attenuation Switch", WM8991_OUT3_4_VOLUME,
+		WM8991_OUT3ATTN_BIT, 1, 0),
+
+	SOC_SINGLE("OUT4 Mute Switch", WM8991_OUT3_4_VOLUME,
+		WM8991_OUT4MUTE_BIT, 1, 0),
+	SOC_SINGLE("OUT4 Attenuation Switch", WM8991_OUT3_4_VOLUME,
+		WM8991_OUT4ATTN_BIT, 1, 0),
+
+	SOC_SINGLE("Speaker Mode Switch", WM8991_CLASSD1,
+		WM8991_CDMODE_BIT, 1, 0),
+
+	SOC_SINGLE("Speaker Output Attenuation Volume", WM8991_SPEAKER_VOLUME,
+		WM8991_SPKVOL_SHIFT, WM8991_SPKVOL_MASK, 0),
+	SOC_SINGLE("Speaker DC Boost Volume", WM8991_CLASSD3,
+		WM8991_DCGAIN_SHIFT, WM8991_DCGAIN_MASK, 0),
+	SOC_SINGLE("Speaker AC Boost Volume", WM8991_CLASSD3,
+		WM8991_ACGAIN_SHIFT, WM8991_ACGAIN_MASK, 0),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("Left DAC Digital Volume",
+		WM8991_LEFT_DAC_DIGITAL_VOLUME,
+		WM8991_DACL_VOL_SHIFT,
+		WM8991_DACL_VOL_MASK,
+		0,
+		out_dac_tlv),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("Right DAC Digital Volume",
+		WM8991_RIGHT_DAC_DIGITAL_VOLUME,
+		WM8991_DACR_VOL_SHIFT,
+		WM8991_DACR_VOL_MASK,
+		0,
+		out_dac_tlv),
+
+	SOC_ENUM("Left Digital Sidetone", wm8991_left_digital_sidetone_enum),
+	SOC_ENUM("Right Digital Sidetone", wm8991_right_digital_sidetone_enum),
+
+	SOC_SINGLE_TLV("Left Digital Sidetone Volume", WM8991_DIGITAL_SIDE_TONE,
+		WM8991_ADCL_DAC_SVOL_SHIFT, WM8991_ADCL_DAC_SVOL_MASK, 0,
+		out_sidetone_tlv),
+	SOC_SINGLE_TLV("Right Digital Sidetone Volume", WM8991_DIGITAL_SIDE_TONE,
+		WM8991_ADCR_DAC_SVOL_SHIFT, WM8991_ADCR_DAC_SVOL_MASK, 0,
+		out_sidetone_tlv),
+
+	SOC_SINGLE("ADC Digital High Pass Filter Switch", WM8991_ADC_CTRL,
+		WM8991_ADC_HPF_ENA_BIT, 1, 0),
+
+	SOC_ENUM("ADC HPF Mode", wm8991_right_adcmode_enum),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("Left ADC Digital Volume",
+		WM8991_LEFT_ADC_DIGITAL_VOLUME,
+		WM8991_ADCL_VOL_SHIFT,
+		WM8991_ADCL_VOL_MASK,
+		0,
+		in_adc_tlv),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("Right ADC Digital Volume",
+		WM8991_RIGHT_ADC_DIGITAL_VOLUME,
+		WM8991_ADCR_VOL_SHIFT,
+		WM8991_ADCR_VOL_MASK,
+		0,
+		in_adc_tlv),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("LIN12 Volume",
+		WM8991_LEFT_LINE_INPUT_1_2_VOLUME,
+		WM8991_LIN12VOL_SHIFT,
+		WM8991_LIN12VOL_MASK,
+		0,
+		in_pga_tlv),
+
+	SOC_SINGLE("LIN12 ZC Switch", WM8991_LEFT_LINE_INPUT_1_2_VOLUME,
+		WM8991_LI12ZC_BIT, 1, 0),
+
+	SOC_SINGLE("LIN12 Mute Switch", WM8991_LEFT_LINE_INPUT_1_2_VOLUME,
+		WM8991_LI12MUTE_BIT, 1, 0),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("LIN34 Volume",
+		WM8991_LEFT_LINE_INPUT_3_4_VOLUME,
+		WM8991_LIN34VOL_SHIFT,
+		WM8991_LIN34VOL_MASK,
+		0,
+		in_pga_tlv),
+
+	SOC_SINGLE("LIN34 ZC Switch", WM8991_LEFT_LINE_INPUT_3_4_VOLUME,
+		WM8991_LI34ZC_BIT, 1, 0),
+
+	SOC_SINGLE("LIN34 Mute Switch", WM8991_LEFT_LINE_INPUT_3_4_VOLUME,
+		WM8991_LI34MUTE_BIT, 1, 0),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("RIN12 Volume",
+		WM8991_RIGHT_LINE_INPUT_1_2_VOLUME,
+		WM8991_RIN12VOL_SHIFT,
+		WM8991_RIN12VOL_MASK,
+		0,
+		in_pga_tlv),
+
+	SOC_SINGLE("RIN12 ZC Switch", WM8991_RIGHT_LINE_INPUT_1_2_VOLUME,
+		WM8991_RI12ZC_BIT, 1, 0),
+
+	SOC_SINGLE("RIN12 Mute Switch", WM8991_RIGHT_LINE_INPUT_1_2_VOLUME,
+		WM8991_RI12MUTE_BIT, 1, 0),
+
+	SOC_WM899X_OUTPGA_SINGLE_R_TLV("RIN34 Volume",
+		WM8991_RIGHT_LINE_INPUT_3_4_VOLUME,
+		WM8991_RIN34VOL_SHIFT,
+		WM8991_RIN34VOL_MASK,
+		0,
+		in_pga_tlv),
+
+	SOC_SINGLE("RIN34 ZC Switch", WM8991_RIGHT_LINE_INPUT_3_4_VOLUME,
+		WM8991_RI34ZC_BIT, 1, 0),
+
+	SOC_SINGLE("RIN34 Mute Switch", WM8991_RIGHT_LINE_INPUT_3_4_VOLUME,
+		WM8991_RI34MUTE_BIT, 1, 0),
+};
+
+/*
+ * _DAPM_ Controls
+ */
+static int inmixer_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event)
+{
+	u16 reg, fakepower;
+
+	reg = snd_soc_read(w->codec, WM8991_POWER_MANAGEMENT_2);
+	fakepower = snd_soc_read(w->codec, WM8991_INTDRIVBITS);
+
+	if (fakepower & ((1 << WM8991_INMIXL_PWR_BIT) |
+			 (1 << WM8991_AINLMUX_PWR_BIT)))
+		reg |= WM8991_AINL_ENA;
+	else
+		reg &= ~WM8991_AINL_ENA;
+
+	if (fakepower & ((1 << WM8991_INMIXR_PWR_BIT) |
+			 (1 << WM8991_AINRMUX_PWR_BIT)))
+		reg |= WM8991_AINR_ENA;
+	else
+		reg &= ~WM8991_AINL_ENA;
+
+	snd_soc_write(w->codec, WM8991_POWER_MANAGEMENT_2, reg);
+	return 0;
+}
+
+static int outmixer_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol, int event)
+{
+	u32 reg_shift = kcontrol->private_value & 0xfff;
+	int ret = 0;
+	u16 reg;
+
+	switch (reg_shift) {
+	case WM8991_SPEAKER_MIXER | (WM8991_LDSPK_BIT << 8):
+		reg = snd_soc_read(w->codec, WM8991_OUTPUT_MIXER1);
+		if (reg & WM8991_LDLO) {
+			printk(KERN_WARNING
+			       "Cannot set as Output Mixer 1 LDLO Set\n");
+			ret = -1;
+		}
+		break;
+
+	case WM8991_SPEAKER_MIXER | (WM8991_RDSPK_BIT << 8):
+		reg = snd_soc_read(w->codec, WM8991_OUTPUT_MIXER2);
+		if (reg & WM8991_RDRO) {
+			printk(KERN_WARNING
+			       "Cannot set as Output Mixer 2 RDRO Set\n");
+			ret = -1;
+		}
+		break;
+
+	case WM8991_OUTPUT_MIXER1 | (WM8991_LDLO_BIT << 8):
+		reg = snd_soc_read(w->codec, WM8991_SPEAKER_MIXER);
+		if (reg & WM8991_LDSPK) {
+			printk(KERN_WARNING
+			       "Cannot set as Speaker Mixer LDSPK Set\n");
+			ret = -1;
+		}
+		break;
+
+	case WM8991_OUTPUT_MIXER2 | (WM8991_RDRO_BIT << 8):
+		reg = snd_soc_read(w->codec, WM8991_SPEAKER_MIXER);
+		if (reg & WM8991_RDSPK) {
+			printk(KERN_WARNING
+			       "Cannot set as Speaker Mixer RDSPK Set\n");
+			ret = -1;
+		}
+		break;
+	}
+
+	return ret;
+}
+
+/* INMIX dB values */
+static const unsigned int in_mix_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 7, TLV_DB_LINEAR_ITEM(-1200, 600),
+};
+
+/* Left In PGA Connections */
+static const struct snd_kcontrol_new wm8991_dapm_lin12_pga_controls[] = {
+	SOC_DAPM_SINGLE("LIN1 Switch", WM8991_INPUT_MIXER2, WM8991_LMN1_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LIN2 Switch", WM8991_INPUT_MIXER2, WM8991_LMP2_BIT, 1, 0),
+};
+
+static const struct snd_kcontrol_new wm8991_dapm_lin34_pga_controls[] = {
+	SOC_DAPM_SINGLE("LIN3 Switch", WM8991_INPUT_MIXER2, WM8991_LMN3_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LIN4 Switch", WM8991_INPUT_MIXER2, WM8991_LMP4_BIT, 1, 0),
+};
+
+/* Right In PGA Connections */
+static const struct snd_kcontrol_new wm8991_dapm_rin12_pga_controls[] = {
+	SOC_DAPM_SINGLE("RIN1 Switch", WM8991_INPUT_MIXER2, WM8991_RMN1_BIT, 1, 0),
+	SOC_DAPM_SINGLE("RIN2 Switch", WM8991_INPUT_MIXER2, WM8991_RMP2_BIT, 1, 0),
+};
+
+static const struct snd_kcontrol_new wm8991_dapm_rin34_pga_controls[] = {
+	SOC_DAPM_SINGLE("RIN3 Switch", WM8991_INPUT_MIXER2, WM8991_RMN3_BIT, 1, 0),
+	SOC_DAPM_SINGLE("RIN4 Switch", WM8991_INPUT_MIXER2, WM8991_RMP4_BIT, 1, 0),
+};
+
+/* INMIXL */
+static const struct snd_kcontrol_new wm8991_dapm_inmixl_controls[] = {
+	SOC_DAPM_SINGLE_TLV("Record Left Volume", WM8991_INPUT_MIXER3,
+		WM8991_LDBVOL_SHIFT, WM8991_LDBVOL_MASK, 0, in_mix_tlv),
+	SOC_DAPM_SINGLE_TLV("LIN2 Volume", WM8991_INPUT_MIXER5, WM8991_LI2BVOL_SHIFT,
+		7, 0, in_mix_tlv),
+	SOC_DAPM_SINGLE("LINPGA12 Switch", WM8991_INPUT_MIXER3, WM8991_L12MNB_BIT,
+		1, 0),
+	SOC_DAPM_SINGLE("LINPGA34 Switch", WM8991_INPUT_MIXER3, WM8991_L34MNB_BIT,
+		1, 0),
+};
+
+/* INMIXR */
+static const struct snd_kcontrol_new wm8991_dapm_inmixr_controls[] = {
+	SOC_DAPM_SINGLE_TLV("Record Right Volume", WM8991_INPUT_MIXER4,
+		WM8991_RDBVOL_SHIFT, WM8991_RDBVOL_MASK, 0, in_mix_tlv),
+	SOC_DAPM_SINGLE_TLV("RIN2 Volume", WM8991_INPUT_MIXER6, WM8991_RI2BVOL_SHIFT,
+		7, 0, in_mix_tlv),
+	SOC_DAPM_SINGLE("RINPGA12 Switch", WM8991_INPUT_MIXER3, WM8991_L12MNB_BIT,
+		1, 0),
+	SOC_DAPM_SINGLE("RINPGA34 Switch", WM8991_INPUT_MIXER3, WM8991_L34MNB_BIT,
+		1, 0),
+};
+
+/* AINLMUX */
+static const char *wm8991_ainlmux[] =
+{"INMIXL Mix", "RXVOICE Mix", "DIFFINL Mix"};
+
+static const struct soc_enum wm8991_ainlmux_enum =
+	SOC_ENUM_SINGLE(WM8991_INPUT_MIXER1, WM8991_AINLMODE_SHIFT,
+			ARRAY_SIZE(wm8991_ainlmux), wm8991_ainlmux);
+
+static const struct snd_kcontrol_new wm8991_dapm_ainlmux_controls =
+	SOC_DAPM_ENUM("Route", wm8991_ainlmux_enum);
+
+/* DIFFINL */
+
+/* AINRMUX */
+static const char *wm8991_ainrmux[] =
+{"INMIXR Mix", "RXVOICE Mix", "DIFFINR Mix"};
+
+static const struct soc_enum wm8991_ainrmux_enum =
+	SOC_ENUM_SINGLE(WM8991_INPUT_MIXER1, WM8991_AINRMODE_SHIFT,
+			ARRAY_SIZE(wm8991_ainrmux), wm8991_ainrmux);
+
+static const struct snd_kcontrol_new wm8991_dapm_ainrmux_controls =
+	SOC_DAPM_ENUM("Route", wm8991_ainrmux_enum);
+
+/* RXVOICE */
+static const struct snd_kcontrol_new wm8991_dapm_rxvoice_controls[] = {
+	SOC_DAPM_SINGLE_TLV("LIN4RXN", WM8991_INPUT_MIXER5, WM8991_LR4BVOL_SHIFT,
+		WM8991_LR4BVOL_MASK, 0, in_mix_tlv),
+	SOC_DAPM_SINGLE_TLV("RIN4RXP", WM8991_INPUT_MIXER6, WM8991_RL4BVOL_SHIFT,
+		WM8991_RL4BVOL_MASK, 0, in_mix_tlv),
+};
+
+/* LOMIX */
+static const struct snd_kcontrol_new wm8991_dapm_lomix_controls[] = {
+	SOC_DAPM_SINGLE("LOMIX Right ADC Bypass Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LRBLO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOMIX Left ADC Bypass Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LLBLO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOMIX RIN3 Bypass Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LRI3LO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOMIX LIN3 Bypass Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LLI3LO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOMIX RIN12 PGA Bypass Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LR12LO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOMIX LIN12 PGA Bypass Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LL12LO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOMIX Left DAC Switch", WM8991_OUTPUT_MIXER1,
+		WM8991_LDLO_BIT, 1, 0),
+};
+
+/* ROMIX */
+static const struct snd_kcontrol_new wm8991_dapm_romix_controls[] = {
+	SOC_DAPM_SINGLE("ROMIX Left ADC Bypass Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RLBRO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROMIX Right ADC Bypass Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RRBRO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROMIX LIN3 Bypass Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RLI3RO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROMIX RIN3 Bypass Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RRI3RO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROMIX LIN12 PGA Bypass Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RL12RO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROMIX RIN12 PGA Bypass Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RR12RO_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROMIX Right DAC Switch", WM8991_OUTPUT_MIXER2,
+		WM8991_RDRO_BIT, 1, 0),
+};
+
+/* LONMIX */
+static const struct snd_kcontrol_new wm8991_dapm_lonmix_controls[] = {
+	SOC_DAPM_SINGLE("LONMIX Left Mixer PGA Switch", WM8991_LINE_MIXER1,
+		WM8991_LLOPGALON_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LONMIX Right Mixer PGA Switch", WM8991_LINE_MIXER1,
+		WM8991_LROPGALON_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LONMIX Inverted LOP Switch", WM8991_LINE_MIXER1,
+		WM8991_LOPLON_BIT, 1, 0),
+};
+
+/* LOPMIX */
+static const struct snd_kcontrol_new wm8991_dapm_lopmix_controls[] = {
+	SOC_DAPM_SINGLE("LOPMIX Right Mic Bypass Switch", WM8991_LINE_MIXER1,
+		WM8991_LR12LOP_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOPMIX Left Mic Bypass Switch", WM8991_LINE_MIXER1,
+		WM8991_LL12LOP_BIT, 1, 0),
+	SOC_DAPM_SINGLE("LOPMIX Left Mixer PGA Switch", WM8991_LINE_MIXER1,
+		WM8991_LLOPGALOP_BIT, 1, 0),
+};
+
+/* RONMIX */
+static const struct snd_kcontrol_new wm8991_dapm_ronmix_controls[] = {
+	SOC_DAPM_SINGLE("RONMIX Right Mixer PGA Switch", WM8991_LINE_MIXER2,
+		WM8991_RROPGARON_BIT, 1, 0),
+	SOC_DAPM_SINGLE("RONMIX Left Mixer PGA Switch", WM8991_LINE_MIXER2,
+		WM8991_RLOPGARON_BIT, 1, 0),
+	SOC_DAPM_SINGLE("RONMIX Inverted ROP Switch", WM8991_LINE_MIXER2,
+		WM8991_ROPRON_BIT, 1, 0),
+};
+
+/* ROPMIX */
+static const struct snd_kcontrol_new wm8991_dapm_ropmix_controls[] = {
+	SOC_DAPM_SINGLE("ROPMIX Left Mic Bypass Switch", WM8991_LINE_MIXER2,
+		WM8991_RL12ROP_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROPMIX Right Mic Bypass Switch", WM8991_LINE_MIXER2,
+		WM8991_RR12ROP_BIT, 1, 0),
+	SOC_DAPM_SINGLE("ROPMIX Right Mixer PGA Switch", WM8991_LINE_MIXER2,
+		WM8991_RROPGAROP_BIT, 1, 0),
+};
+
+/* OUT3MIX */
+static const struct snd_kcontrol_new wm8991_dapm_out3mix_controls[] = {
+	SOC_DAPM_SINGLE("OUT3MIX LIN4RXN Bypass Switch", WM8991_OUT3_4_MIXER,
+		WM8991_LI4O3_BIT, 1, 0),
+	SOC_DAPM_SINGLE("OUT3MIX Left Out PGA Switch", WM8991_OUT3_4_MIXER,
+		WM8991_LPGAO3_BIT, 1, 0),
+};
+
+/* OUT4MIX */
+static const struct snd_kcontrol_new wm8991_dapm_out4mix_controls[] = {
+	SOC_DAPM_SINGLE("OUT4MIX Right Out PGA Switch", WM8991_OUT3_4_MIXER,
+		WM8991_RPGAO4_BIT, 1, 0),
+	SOC_DAPM_SINGLE("OUT4MIX RIN4RXP Bypass Switch", WM8991_OUT3_4_MIXER,
+		WM8991_RI4O4_BIT, 1, 0),
+};
+
+/* SPKMIX */
+static const struct snd_kcontrol_new wm8991_dapm_spkmix_controls[] = {
+	SOC_DAPM_SINGLE("SPKMIX LIN2 Bypass Switch", WM8991_SPEAKER_MIXER,
+		WM8991_LI2SPK_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX LADC Bypass Switch", WM8991_SPEAKER_MIXER,
+		WM8991_LB2SPK_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX Left Mixer PGA Switch", WM8991_SPEAKER_MIXER,
+		WM8991_LOPGASPK_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX Left DAC Switch", WM8991_SPEAKER_MIXER,
+		WM8991_LDSPK_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX Right DAC Switch", WM8991_SPEAKER_MIXER,
+		WM8991_RDSPK_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX Right Mixer PGA Switch", WM8991_SPEAKER_MIXER,
+		WM8991_ROPGASPK_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX RADC Bypass Switch", WM8991_SPEAKER_MIXER,
+		WM8991_RL12ROP_BIT, 1, 0),
+	SOC_DAPM_SINGLE("SPKMIX RIN2 Bypass Switch", WM8991_SPEAKER_MIXER,
+		WM8991_RI2SPK_BIT, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget wm8991_dapm_widgets[] = {
+	/* Input Side */
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("LIN1"),
+	SND_SOC_DAPM_INPUT("LIN2"),
+	SND_SOC_DAPM_INPUT("LIN3"),
+	SND_SOC_DAPM_INPUT("LIN4RXN"),
+	SND_SOC_DAPM_INPUT("RIN3"),
+	SND_SOC_DAPM_INPUT("RIN4RXP"),
+	SND_SOC_DAPM_INPUT("RIN1"),
+	SND_SOC_DAPM_INPUT("RIN2"),
+	SND_SOC_DAPM_INPUT("Internal ADC Source"),
+
+	/* DACs */
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8991_POWER_MANAGEMENT_2,
+		WM8991_ADCL_ENA_BIT, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", WM8991_POWER_MANAGEMENT_2,
+		WM8991_ADCR_ENA_BIT, 0),
+
+	/* Input PGAs */
+	SND_SOC_DAPM_MIXER("LIN12 PGA", WM8991_POWER_MANAGEMENT_2, WM8991_LIN12_ENA_BIT,
+		0, &wm8991_dapm_lin12_pga_controls[0],
+		ARRAY_SIZE(wm8991_dapm_lin12_pga_controls)),
+	SND_SOC_DAPM_MIXER("LIN34 PGA", WM8991_POWER_MANAGEMENT_2, WM8991_LIN34_ENA_BIT,
+		0, &wm8991_dapm_lin34_pga_controls[0],
+		ARRAY_SIZE(wm8991_dapm_lin34_pga_controls)),
+	SND_SOC_DAPM_MIXER("RIN12 PGA", WM8991_POWER_MANAGEMENT_2, WM8991_RIN12_ENA_BIT,
+		0, &wm8991_dapm_rin12_pga_controls[0],
+		ARRAY_SIZE(wm8991_dapm_rin12_pga_controls)),
+	SND_SOC_DAPM_MIXER("RIN34 PGA", WM8991_POWER_MANAGEMENT_2, WM8991_RIN34_ENA_BIT,
+		0, &wm8991_dapm_rin34_pga_controls[0],
+		ARRAY_SIZE(wm8991_dapm_rin34_pga_controls)),
+
+	/* INMIXL */
+	SND_SOC_DAPM_MIXER_E("INMIXL", WM8991_INTDRIVBITS, WM8991_INMIXL_PWR_BIT, 0,
+		&wm8991_dapm_inmixl_controls[0],
+		ARRAY_SIZE(wm8991_dapm_inmixl_controls),
+		inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* AINLMUX */
+	SND_SOC_DAPM_MUX_E("AINLMUX", WM8991_INTDRIVBITS, WM8991_AINLMUX_PWR_BIT, 0,
+		&wm8991_dapm_ainlmux_controls, inmixer_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* INMIXR */
+	SND_SOC_DAPM_MIXER_E("INMIXR", WM8991_INTDRIVBITS, WM8991_INMIXR_PWR_BIT, 0,
+		&wm8991_dapm_inmixr_controls[0],
+		ARRAY_SIZE(wm8991_dapm_inmixr_controls),
+		inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* AINRMUX */
+	SND_SOC_DAPM_MUX_E("AINRMUX", WM8991_INTDRIVBITS, WM8991_AINRMUX_PWR_BIT, 0,
+		&wm8991_dapm_ainrmux_controls, inmixer_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* Output Side */
+	/* DACs */
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8991_POWER_MANAGEMENT_3,
+		WM8991_DACL_ENA_BIT, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", WM8991_POWER_MANAGEMENT_3,
+		WM8991_DACR_ENA_BIT, 0),
+
+	/* LOMIX */
+	SND_SOC_DAPM_MIXER_E("LOMIX", WM8991_POWER_MANAGEMENT_3, WM8991_LOMIX_ENA_BIT,
+		0, &wm8991_dapm_lomix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_lomix_controls),
+		outmixer_event, SND_SOC_DAPM_PRE_REG),
+
+	/* LONMIX */
+	SND_SOC_DAPM_MIXER("LONMIX", WM8991_POWER_MANAGEMENT_3, WM8991_LON_ENA_BIT, 0,
+		&wm8991_dapm_lonmix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_lonmix_controls)),
+
+	/* LOPMIX */
+	SND_SOC_DAPM_MIXER("LOPMIX", WM8991_POWER_MANAGEMENT_3, WM8991_LOP_ENA_BIT, 0,
+		&wm8991_dapm_lopmix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_lopmix_controls)),
+
+	/* OUT3MIX */
+	SND_SOC_DAPM_MIXER("OUT3MIX", WM8991_POWER_MANAGEMENT_1, WM8991_OUT3_ENA_BIT, 0,
+		&wm8991_dapm_out3mix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_out3mix_controls)),
+
+	/* SPKMIX */
+	SND_SOC_DAPM_MIXER_E("SPKMIX", WM8991_POWER_MANAGEMENT_1, WM8991_SPK_ENA_BIT, 0,
+		&wm8991_dapm_spkmix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_spkmix_controls), outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
+
+	/* OUT4MIX */
+	SND_SOC_DAPM_MIXER("OUT4MIX", WM8991_POWER_MANAGEMENT_1, WM8991_OUT4_ENA_BIT, 0,
+		&wm8991_dapm_out4mix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_out4mix_controls)),
+
+	/* ROPMIX */
+	SND_SOC_DAPM_MIXER("ROPMIX", WM8991_POWER_MANAGEMENT_3, WM8991_ROP_ENA_BIT, 0,
+		&wm8991_dapm_ropmix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_ropmix_controls)),
+
+	/* RONMIX */
+	SND_SOC_DAPM_MIXER("RONMIX", WM8991_POWER_MANAGEMENT_3, WM8991_RON_ENA_BIT, 0,
+		&wm8991_dapm_ronmix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_ronmix_controls)),
+
+	/* ROMIX */
+	SND_SOC_DAPM_MIXER_E("ROMIX", WM8991_POWER_MANAGEMENT_3, WM8991_ROMIX_ENA_BIT,
+		0, &wm8991_dapm_romix_controls[0],
+		ARRAY_SIZE(wm8991_dapm_romix_controls),
+		outmixer_event, SND_SOC_DAPM_PRE_REG),
+
+	/* LOUT PGA */
+	SND_SOC_DAPM_PGA("LOUT PGA", WM8991_POWER_MANAGEMENT_1, WM8991_LOUT_ENA_BIT, 0,
+		NULL, 0),
+
+	/* ROUT PGA */
+	SND_SOC_DAPM_PGA("ROUT PGA", WM8991_POWER_MANAGEMENT_1, WM8991_ROUT_ENA_BIT, 0,
+		NULL, 0),
+
+	/* LOPGA */
+	SND_SOC_DAPM_PGA("LOPGA", WM8991_POWER_MANAGEMENT_3, WM8991_LOPGA_ENA_BIT, 0,
+		NULL, 0),
+
+	/* ROPGA */
+	SND_SOC_DAPM_PGA("ROPGA", WM8991_POWER_MANAGEMENT_3, WM8991_ROPGA_ENA_BIT, 0,
+		NULL, 0),
+
+	/* MICBIAS */
+	SND_SOC_DAPM_MICBIAS("MICBIAS", WM8991_POWER_MANAGEMENT_1,
+		WM8991_MICBIAS_ENA_BIT, 0),
+
+	SND_SOC_DAPM_OUTPUT("LON"),
+	SND_SOC_DAPM_OUTPUT("LOP"),
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+	SND_SOC_DAPM_OUTPUT("LOUT"),
+	SND_SOC_DAPM_OUTPUT("SPKN"),
+	SND_SOC_DAPM_OUTPUT("SPKP"),
+	SND_SOC_DAPM_OUTPUT("ROUT"),
+	SND_SOC_DAPM_OUTPUT("OUT4"),
+	SND_SOC_DAPM_OUTPUT("ROP"),
+	SND_SOC_DAPM_OUTPUT("RON"),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+
+	SND_SOC_DAPM_OUTPUT("Internal DAC Sink"),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Make DACs turn on when playing even if not mixed into any outputs */
+	{"Internal DAC Sink", NULL, "Left DAC"},
+	{"Internal DAC Sink", NULL, "Right DAC"},
+
+	/* Make ADCs turn on when recording even if not mixed from any inputs */
+	{"Left ADC", NULL, "Internal ADC Source"},
+	{"Right ADC", NULL, "Internal ADC Source"},
+
+	/* Input Side */
+	/* LIN12 PGA */
+	{"LIN12 PGA", "LIN1 Switch", "LIN1"},
+	{"LIN12 PGA", "LIN2 Switch", "LIN2"},
+	/* LIN34 PGA */
+	{"LIN34 PGA", "LIN3 Switch", "LIN3"},
+	{"LIN34 PGA", "LIN4 Switch", "LIN4RXN"},
+	/* INMIXL */
+	{"INMIXL", "Record Left Volume", "LOMIX"},
+	{"INMIXL", "LIN2 Volume", "LIN2"},
+	{"INMIXL", "LINPGA12 Switch", "LIN12 PGA"},
+	{"INMIXL", "LINPGA34 Switch", "LIN34 PGA"},
+	/* AINLMUX */
+	{"AINLMUX", "INMIXL Mix", "INMIXL"},
+	{"AINLMUX", "DIFFINL Mix", "LIN12 PGA"},
+	{"AINLMUX", "DIFFINL Mix", "LIN34 PGA"},
+	{"AINLMUX", "RXVOICE Mix", "LIN4RXN"},
+	{"AINLMUX", "RXVOICE Mix", "RIN4RXP"},
+	/* ADC */
+	{"Left ADC", NULL, "AINLMUX"},
+
+	/* RIN12 PGA */
+	{"RIN12 PGA", "RIN1 Switch", "RIN1"},
+	{"RIN12 PGA", "RIN2 Switch", "RIN2"},
+	/* RIN34 PGA */
+	{"RIN34 PGA", "RIN3 Switch", "RIN3"},
+	{"RIN34 PGA", "RIN4 Switch", "RIN4RXP"},
+	/* INMIXL */
+	{"INMIXR", "Record Right Volume", "ROMIX"},
+	{"INMIXR", "RIN2 Volume", "RIN2"},
+	{"INMIXR", "RINPGA12 Switch", "RIN12 PGA"},
+	{"INMIXR", "RINPGA34 Switch", "RIN34 PGA"},
+	/* AINRMUX */
+	{"AINRMUX", "INMIXR Mix", "INMIXR"},
+	{"AINRMUX", "DIFFINR Mix", "RIN12 PGA"},
+	{"AINRMUX", "DIFFINR Mix", "RIN34 PGA"},
+	{"AINRMUX", "RXVOICE Mix", "LIN4RXN"},
+	{"AINRMUX", "RXVOICE Mix", "RIN4RXP"},
+	/* ADC */
+	{"Right ADC", NULL, "AINRMUX"},
+
+	/* LOMIX */
+	{"LOMIX", "LOMIX RIN3 Bypass Switch", "RIN3"},
+	{"LOMIX", "LOMIX LIN3 Bypass Switch", "LIN3"},
+	{"LOMIX", "LOMIX LIN12 PGA Bypass Switch", "LIN12 PGA"},
+	{"LOMIX", "LOMIX RIN12 PGA Bypass Switch", "RIN12 PGA"},
+	{"LOMIX", "LOMIX Right ADC Bypass Switch", "AINRMUX"},
+	{"LOMIX", "LOMIX Left ADC Bypass Switch", "AINLMUX"},
+	{"LOMIX", "LOMIX Left DAC Switch", "Left DAC"},
+
+	/* ROMIX */
+	{"ROMIX", "ROMIX RIN3 Bypass Switch", "RIN3"},
+	{"ROMIX", "ROMIX LIN3 Bypass Switch", "LIN3"},
+	{"ROMIX", "ROMIX LIN12 PGA Bypass Switch", "LIN12 PGA"},
+	{"ROMIX", "ROMIX RIN12 PGA Bypass Switch", "RIN12 PGA"},
+	{"ROMIX", "ROMIX Right ADC Bypass Switch", "AINRMUX"},
+	{"ROMIX", "ROMIX Left ADC Bypass Switch", "AINLMUX"},
+	{"ROMIX", "ROMIX Right DAC Switch", "Right DAC"},
+
+	/* SPKMIX */
+	{"SPKMIX", "SPKMIX LIN2 Bypass Switch", "LIN2"},
+	{"SPKMIX", "SPKMIX RIN2 Bypass Switch", "RIN2"},
+	{"SPKMIX", "SPKMIX LADC Bypass Switch", "AINLMUX"},
+	{"SPKMIX", "SPKMIX RADC Bypass Switch", "AINRMUX"},
+	{"SPKMIX", "SPKMIX Left Mixer PGA Switch", "LOPGA"},
+	{"SPKMIX", "SPKMIX Right Mixer PGA Switch", "ROPGA"},
+	{"SPKMIX", "SPKMIX Right DAC Switch", "Right DAC"},
+	{"SPKMIX", "SPKMIX Left DAC Switch", "Right DAC"},
+
+	/* LONMIX */
+	{"LONMIX", "LONMIX Left Mixer PGA Switch", "LOPGA"},
+	{"LONMIX", "LONMIX Right Mixer PGA Switch", "ROPGA"},
+	{"LONMIX", "LONMIX Inverted LOP Switch", "LOPMIX"},
+
+	/* LOPMIX */
+	{"LOPMIX", "LOPMIX Right Mic Bypass Switch", "RIN12 PGA"},
+	{"LOPMIX", "LOPMIX Left Mic Bypass Switch", "LIN12 PGA"},
+	{"LOPMIX", "LOPMIX Left Mixer PGA Switch", "LOPGA"},
+
+	/* OUT3MIX */
+	{"OUT3MIX", "OUT3MIX LIN4RXN Bypass Switch", "LIN4RXN"},
+	{"OUT3MIX", "OUT3MIX Left Out PGA Switch", "LOPGA"},
+
+	/* OUT4MIX */
+	{"OUT4MIX", "OUT4MIX Right Out PGA Switch", "ROPGA"},
+	{"OUT4MIX", "OUT4MIX RIN4RXP Bypass Switch", "RIN4RXP"},
+
+	/* RONMIX */
+	{"RONMIX", "RONMIX Right Mixer PGA Switch", "ROPGA"},
+	{"RONMIX", "RONMIX Left Mixer PGA Switch", "LOPGA"},
+	{"RONMIX", "RONMIX Inverted ROP Switch", "ROPMIX"},
+
+	/* ROPMIX */
+	{"ROPMIX", "ROPMIX Left Mic Bypass Switch", "LIN12 PGA"},
+	{"ROPMIX", "ROPMIX Right Mic Bypass Switch", "RIN12 PGA"},
+	{"ROPMIX", "ROPMIX Right Mixer PGA Switch", "ROPGA"},
+
+	/* Out Mixer PGAs */
+	{"LOPGA", NULL, "LOMIX"},
+	{"ROPGA", NULL, "ROMIX"},
+
+	{"LOUT PGA", NULL, "LOMIX"},
+	{"ROUT PGA", NULL, "ROMIX"},
+
+	/* Output Pins */
+	{"LON", NULL, "LONMIX"},
+	{"LOP", NULL, "LOPMIX"},
+	{"OUT", NULL, "OUT3MIX"},
+	{"LOUT", NULL, "LOUT PGA"},
+	{"SPKN", NULL, "SPKMIX"},
+	{"ROUT", NULL, "ROUT PGA"},
+	{"OUT4", NULL, "OUT4MIX"},
+	{"ROP", NULL, "ROPMIX"},
+	{"RON", NULL, "RONMIX"},
+};
+
+/* PLL divisors */
+struct _pll_div {
+	u32 div2;
+	u32 n;
+	u32 k;
+};
+
+/* The size in bits of the pll divide multiplied by 10
+ * to allow rounding later */
+#define FIXED_PLL_SIZE ((1 << 16) * 10)
+
+static void pll_factors(struct _pll_div *pll_div, unsigned int target,
+			unsigned int source)
+{
+	u64 Kpart;
+	unsigned int K, Ndiv, Nmod;
+
+
+	Ndiv = target / source;
+	if (Ndiv < 6) {
+		source >>= 1;
+		pll_div->div2 = 1;
+		Ndiv = target / source;
+	} else
+		pll_div->div2 = 0;
+
+	if ((Ndiv < 6) || (Ndiv > 12))
+		printk(KERN_WARNING
+		       "WM8991 N value outwith recommended range! N = %d\n", Ndiv);
+
+	pll_div->n = Ndiv;
+	Nmod = target % source;
+	Kpart = FIXED_PLL_SIZE * (long long)Nmod;
+
+	do_div(Kpart, source);
+
+	K = Kpart & 0xFFFFFFFF;
+
+	/* Check if we need to round */
+	if ((K % 10) >= 5)
+		K += 5;
+
+	/* Move down to proper range now rounding is done */
+	K /= 10;
+
+	pll_div->k = K;
+}
+
+static int wm8991_set_dai_pll(struct snd_soc_dai *codec_dai,
+			      int pll_id, int src, unsigned int freq_in, unsigned int freq_out)
+{
+	u16 reg;
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct _pll_div pll_div;
+
+	if (freq_in && freq_out) {
+		pll_factors(&pll_div, freq_out * 4, freq_in);
+
+		/* Turn on PLL */
+		reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_2);
+		reg |= WM8991_PLL_ENA;
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_2, reg);
+
+		/* sysclk comes from PLL */
+		reg = snd_soc_read(codec, WM8991_CLOCKING_2);
+		snd_soc_write(codec, WM8991_CLOCKING_2, reg | WM8991_SYSCLK_SRC);
+
+		/* set up N , fractional mode and pre-divisor if neccessary */
+		snd_soc_write(codec, WM8991_PLL1, pll_div.n | WM8991_SDM |
+			      (pll_div.div2 ? WM8991_PRESCALE : 0));
+		snd_soc_write(codec, WM8991_PLL2, (u8)(pll_div.k>>8));
+		snd_soc_write(codec, WM8991_PLL3, (u8)(pll_div.k & 0xFF));
+	} else {
+		/* Turn on PLL */
+		reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_2);
+		reg &= ~WM8991_PLL_ENA;
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_2, reg);
+	}
+	return 0;
+}
+
+/*
+ * Set's ADC and Voice DAC format.
+ */
+static int wm8991_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 audio1, audio3;
+
+	audio1 = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_1);
+	audio3 = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_3);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		audio3 &= ~WM8991_AIF_MSTR1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		audio3 |= WM8991_AIF_MSTR1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	audio1 &= ~WM8991_AIF_FMT_MASK;
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		audio1 |= WM8991_AIF_TMF_I2S;
+		audio1 &= ~WM8991_AIF_LRCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		audio1 |= WM8991_AIF_TMF_RIGHTJ;
+		audio1 &= ~WM8991_AIF_LRCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		audio1 |= WM8991_AIF_TMF_LEFTJ;
+		audio1 &= ~WM8991_AIF_LRCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		audio1 |= WM8991_AIF_TMF_DSP;
+		audio1 &= ~WM8991_AIF_LRCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		audio1 |= WM8991_AIF_TMF_DSP | WM8991_AIF_LRCLK_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_1, audio1);
+	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_3, audio3);
+	return 0;
+}
+
+static int wm8991_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
+				 int div_id, int div)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 reg;
+
+	switch (div_id) {
+	case WM8991_MCLK_DIV:
+		reg = snd_soc_read(codec, WM8991_CLOCKING_2) &
+		      ~WM8991_MCLK_DIV_MASK;
+		snd_soc_write(codec, WM8991_CLOCKING_2, reg | div);
+		break;
+	case WM8991_DACCLK_DIV:
+		reg = snd_soc_read(codec, WM8991_CLOCKING_2) &
+		      ~WM8991_DAC_CLKDIV_MASK;
+		snd_soc_write(codec, WM8991_CLOCKING_2, reg | div);
+		break;
+	case WM8991_ADCCLK_DIV:
+		reg = snd_soc_read(codec, WM8991_CLOCKING_2) &
+		      ~WM8991_ADC_CLKDIV_MASK;
+		snd_soc_write(codec, WM8991_CLOCKING_2, reg | div);
+		break;
+	case WM8991_BCLK_DIV:
+		reg = snd_soc_read(codec, WM8991_CLOCKING_1) &
+		      ~WM8991_BCLK_DIV_MASK;
+		snd_soc_write(codec, WM8991_CLOCKING_1, reg | div);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Set PCM DAI bit size and sample rate.
+ */
+static int wm8991_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 audio1 = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_1);
+
+	audio1 &= ~WM8991_AIF_WL_MASK;
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		audio1 |= WM8991_AIF_WL_20BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		audio1 |= WM8991_AIF_WL_24BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		audio1 |= WM8991_AIF_WL_32BITS;
+		break;
+	}
+
+	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_1, audio1);
+	return 0;
+}
+
+static int wm8991_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 val;
+
+	val  = snd_soc_read(codec, WM8991_DAC_CTRL) & ~WM8991_DAC_MUTE;
+	if (mute)
+		snd_soc_write(codec, WM8991_DAC_CTRL, val | WM8991_DAC_MUTE);
+	else
+		snd_soc_write(codec, WM8991_DAC_CTRL, val);
+	return 0;
+}
+
+static int wm8991_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	u16 val;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		/* VMID=2*50k */
+		val = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_1) &
+		      ~WM8991_VMID_MODE_MASK;
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, val | 0x2);
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			snd_soc_cache_sync(codec);
+			/* Enable all output discharge bits */
+			snd_soc_write(codec, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
+				      WM8991_DIS_RLINE | WM8991_DIS_OUT3 |
+				      WM8991_DIS_OUT4 | WM8991_DIS_LOUT |
+				      WM8991_DIS_ROUT);
+
+			/* Enable POBCTRL, SOFT_ST, VMIDTOG and BUFDCOPEN */
+			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+				      WM8991_BUFDCOPEN | WM8991_POBCTRL |
+				      WM8991_VMIDTOG);
+
+			/* Delay to allow output caps to discharge */
+			msleep(300);
+
+			/* Disable VMIDTOG */
+			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+				      WM8991_BUFDCOPEN | WM8991_POBCTRL);
+
+			/* disable all output discharge bits */
+			snd_soc_write(codec, WM8991_ANTIPOP1, 0);
+
+			/* Enable outputs */
+			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1b00);
+
+			msleep(50);
+
+			/* Enable VMID at 2x50k */
+			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f02);
+
+			msleep(100);
+
+			/* Enable VREF */
+			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f03);
+
+			msleep(600);
+
+			/* Enable BUFIOEN */
+			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+				      WM8991_BUFDCOPEN | WM8991_POBCTRL |
+				      WM8991_BUFIOEN);
+
+			/* Disable outputs */
+			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x3);
+
+			/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
+			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_BUFIOEN);
+		}
+
+		/* VMID=2*250k */
+		val = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_1) &
+		      ~WM8991_VMID_MODE_MASK;
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, val | 0x4);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		/* Enable POBCTRL and SOFT_ST */
+		snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+			      WM8991_POBCTRL | WM8991_BUFIOEN);
+
+		/* Enable POBCTRL, SOFT_ST and BUFDCOPEN */
+		snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+			      WM8991_BUFDCOPEN | WM8991_POBCTRL |
+			      WM8991_BUFIOEN);
+
+		/* mute DAC */
+		val = snd_soc_read(codec, WM8991_DAC_CTRL);
+		snd_soc_write(codec, WM8991_DAC_CTRL, val | WM8991_DAC_MUTE);
+
+		/* Enable any disabled outputs */
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f03);
+
+		/* Disable VMID */
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f01);
+
+		msleep(300);
+
+		/* Enable all output discharge bits */
+		snd_soc_write(codec, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
+			      WM8991_DIS_RLINE | WM8991_DIS_OUT3 |
+			      WM8991_DIS_OUT4 | WM8991_DIS_LOUT |
+			      WM8991_DIS_ROUT);
+
+		/* Disable VREF */
+		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x0);
+
+		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
+		snd_soc_write(codec, WM8991_ANTIPOP2, 0x0);
+		codec->cache_sync = 1;
+		break;
+	}
+
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+static int wm8991_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	wm8991_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int wm8991_resume(struct snd_soc_codec *codec)
+{
+	wm8991_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	return 0;
+}
+
+/* power down chip */
+static int wm8991_remove(struct snd_soc_codec *codec)
+{
+	wm8991_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int wm8991_probe(struct snd_soc_codec *codec)
+{
+	struct wm8991_priv *wm8991;
+	int ret;
+	unsigned int reg;
+
+	wm8991 = snd_soc_codec_get_drvdata(codec);
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8991->control_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache i/o: %d\n", ret);
+		return ret;
+	}
+
+	ret = wm8991_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		return ret;
+	}
+
+	wm8991_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	reg = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_4);
+	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_4, reg | WM8991_ALRCGPIO1);
+
+	reg = snd_soc_read(codec, WM8991_GPIO1_GPIO2) &
+	      ~WM8991_GPIO1_SEL_MASK;
+	snd_soc_write(codec, WM8991_GPIO1_GPIO2, reg | 1);
+
+	reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_1);
+	snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, reg | WM8991_VREF_ENA|
+		      WM8991_VMID_MODE_MASK);
+
+	reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_2);
+	snd_soc_write(codec, WM8991_POWER_MANAGEMENT_2, reg | WM8991_OPCLK_ENA);
+
+	snd_soc_write(codec, WM8991_DAC_CTRL, 0);
+	snd_soc_write(codec, WM8991_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
+	snd_soc_write(codec, WM8991_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
+
+	snd_soc_add_controls(codec, wm8991_snd_controls,
+			     ARRAY_SIZE(wm8991_snd_controls));
+
+	snd_soc_dapm_new_controls(&codec->dapm, wm8991_dapm_widgets,
+				  ARRAY_SIZE(wm8991_dapm_widgets));
+	snd_soc_dapm_add_routes(&codec->dapm, audio_map,
+				ARRAY_SIZE(audio_map));
+	return 0;
+}
+
+#define WM8991_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+			SNDRV_PCM_FMTBIT_S24_LE)
+
+static struct snd_soc_dai_ops wm8991_ops = {
+	.hw_params = wm8991_hw_params,
+	.digital_mute = wm8991_mute,
+	.set_fmt = wm8991_set_dai_fmt,
+	.set_clkdiv = wm8991_set_dai_clkdiv,
+	.set_pll = wm8991_set_dai_pll
+};
+
+/*
+ * The WM8991 supports 2 different and mutually exclusive DAI
+ * configurations.
+ *
+ * 1. ADC/DAC on Primary Interface
+ * 2. ADC on Primary Interface/DAC on secondary
+ */
+static struct snd_soc_dai_driver wm8991_dai = {
+	/* ADC/DAC on primary */
+	.name = "wm8991",
+	.id = 1,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = WM8991_FORMATS
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = WM8991_FORMATS
+	},
+	.ops = &wm8991_ops
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
+	.probe = wm8991_probe,
+	.remove = wm8991_remove,
+	.suspend = wm8991_suspend,
+	.resume = wm8991_resume,
+	.set_bias_level = wm8991_set_bias_level,
+	.reg_cache_size = WM8991_MAX_REGISTER + 1,
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8991_reg_defs
+};
+
+static __devinit int wm8991_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct wm8991_priv *wm8991;
+	int ret;
+
+	wm8991 = kzalloc(sizeof *wm8991, GFP_KERNEL);
+	if (!wm8991)
+		return -ENOMEM;
+
+	wm8991->control_type = SND_SOC_I2C;
+	i2c_set_clientdata(i2c, wm8991);
+
+	ret = snd_soc_register_codec(&i2c->dev,
+				     &soc_codec_dev_wm8991, &wm8991_dai, 1);
+	if (ret < 0)
+		kfree(wm8991);
+	return ret;
+}
+
+static __devexit int wm8991_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id wm8991_i2c_id[] = {
+	{ "wm8991", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8991_i2c_id);
+
+static struct i2c_driver wm8991_i2c_driver = {
+	.driver = {
+		.name = "wm8991",
+		.owner = THIS_MODULE,
+	},
+	.probe = wm8991_i2c_probe,
+	.remove = __devexit_p(wm8991_i2c_remove),
+	.id_table = wm8991_i2c_id,
+};
+
+static int __init wm8991_modinit(void)
+{
+	int ret;
+	ret = i2c_add_driver(&wm8991_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8991 I2C driver: %d\n",
+		       ret);
+	}
+	return 0;
+}
+module_init(wm8991_modinit);
+
+static void __exit wm8991_exit(void)
+{
+	i2c_del_driver(&wm8991_i2c_driver);
+}
+module_exit(wm8991_exit);
+
+MODULE_DESCRIPTION("ASoC WM8991 driver");
+MODULE_AUTHOR("Graeme Gregory");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8991.h b/sound/soc/codecs/wm8991.h
new file mode 100644
index 0000000..8a942ef
--- /dev/null
+++ b/sound/soc/codecs/wm8991.h
@@ -0,0 +1,833 @@
+/*
+ * wm8991.h  --  audio driver for WM8991
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _WM8991_H
+#define _WM8991_H
+
+/*
+ * Register values.
+ */
+#define WM8991_RESET                            0x00
+#define WM8991_POWER_MANAGEMENT_1               0x01
+#define WM8991_POWER_MANAGEMENT_2               0x02
+#define WM8991_POWER_MANAGEMENT_3               0x03
+#define WM8991_AUDIO_INTERFACE_1                0x04
+#define WM8991_AUDIO_INTERFACE_2                0x05
+#define WM8991_CLOCKING_1                       0x06
+#define WM8991_CLOCKING_2                       0x07
+#define WM8991_AUDIO_INTERFACE_3                0x08
+#define WM8991_AUDIO_INTERFACE_4                0x09
+#define WM8991_DAC_CTRL                         0x0A
+#define WM8991_LEFT_DAC_DIGITAL_VOLUME          0x0B
+#define WM8991_RIGHT_DAC_DIGITAL_VOLUME         0x0C
+#define WM8991_DIGITAL_SIDE_TONE                0x0D
+#define WM8991_ADC_CTRL                         0x0E
+#define WM8991_LEFT_ADC_DIGITAL_VOLUME          0x0F
+#define WM8991_RIGHT_ADC_DIGITAL_VOLUME         0x10
+#define WM8991_GPIO_CTRL_1                      0x12
+#define WM8991_GPIO1_GPIO2                      0x13
+#define WM8991_GPIO3_GPIO4                      0x14
+#define WM8991_GPIO5_GPIO6                      0x15
+#define WM8991_GPIOCTRL_2                       0x16
+#define WM8991_GPIO_POL                         0x17
+#define WM8991_LEFT_LINE_INPUT_1_2_VOLUME       0x18
+#define WM8991_LEFT_LINE_INPUT_3_4_VOLUME       0x19
+#define WM8991_RIGHT_LINE_INPUT_1_2_VOLUME      0x1A
+#define WM8991_RIGHT_LINE_INPUT_3_4_VOLUME      0x1B
+#define WM8991_LEFT_OUTPUT_VOLUME               0x1C
+#define WM8991_RIGHT_OUTPUT_VOLUME              0x1D
+#define WM8991_LINE_OUTPUTS_VOLUME              0x1E
+#define WM8991_OUT3_4_VOLUME                    0x1F
+#define WM8991_LEFT_OPGA_VOLUME                 0x20
+#define WM8991_RIGHT_OPGA_VOLUME                0x21
+#define WM8991_SPEAKER_VOLUME                   0x22
+#define WM8991_CLASSD1                          0x23
+#define WM8991_CLASSD3                          0x25
+#define WM8991_INPUT_MIXER1                     0x27
+#define WM8991_INPUT_MIXER2                     0x28
+#define WM8991_INPUT_MIXER3                     0x29
+#define WM8991_INPUT_MIXER4                     0x2A
+#define WM8991_INPUT_MIXER5                     0x2B
+#define WM8991_INPUT_MIXER6                     0x2C
+#define WM8991_OUTPUT_MIXER1                    0x2D
+#define WM8991_OUTPUT_MIXER2                    0x2E
+#define WM8991_OUTPUT_MIXER3                    0x2F
+#define WM8991_OUTPUT_MIXER4                    0x30
+#define WM8991_OUTPUT_MIXER5                    0x31
+#define WM8991_OUTPUT_MIXER6                    0x32
+#define WM8991_OUT3_4_MIXER                     0x33
+#define WM8991_LINE_MIXER1                      0x34
+#define WM8991_LINE_MIXER2                      0x35
+#define WM8991_SPEAKER_MIXER                    0x36
+#define WM8991_ADDITIONAL_CONTROL               0x37
+#define WM8991_ANTIPOP1                         0x38
+#define WM8991_ANTIPOP2                         0x39
+#define WM8991_MICBIAS                          0x3A
+#define WM8991_PLL1                             0x3C
+#define WM8991_PLL2                             0x3D
+#define WM8991_PLL3                             0x3E
+#define WM8991_INTDRIVBITS			0x3F
+
+#define WM8991_REGISTER_COUNT                   60
+#define WM8991_MAX_REGISTER                     0x3F
+
+/*
+ * Field Definitions.
+ */
+
+/*
+ * R0 (0x00) - Reset
+ */
+#define WM8991_SW_RESET_CHIP_ID_MASK            0xFFFF  /* SW_RESET_CHIP_ID - [15:0] */
+
+/*
+ * R1 (0x01) - Power Management (1)
+ */
+#define WM8991_SPK_ENA                          0x1000  /* SPK_ENA */
+#define WM8991_SPK_ENA_BIT			12
+#define WM8991_OUT3_ENA                         0x0800  /* OUT3_ENA */
+#define WM8991_OUT3_ENA_BIT			11
+#define WM8991_OUT4_ENA                         0x0400  /* OUT4_ENA */
+#define WM8991_OUT4_ENA_BIT			10
+#define WM8991_LOUT_ENA                         0x0200  /* LOUT_ENA */
+#define WM8991_LOUT_ENA_BIT			9
+#define WM8991_ROUT_ENA                         0x0100  /* ROUT_ENA */
+#define WM8991_ROUT_ENA_BIT			8
+#define WM8991_MICBIAS_ENA                      0x0010  /* MICBIAS_ENA */
+#define WM8991_MICBIAS_ENA_BIT			4
+#define WM8991_VMID_MODE_MASK                   0x0006  /* VMID_MODE - [2:1] */
+#define WM8991_VREF_ENA                         0x0001  /* VREF_ENA */
+#define WM8991_VREF_ENA_BIT			0
+
+/*
+ * R2 (0x02) - Power Management (2)
+ */
+#define WM8991_PLL_ENA                          0x8000  /* PLL_ENA */
+#define WM8991_PLL_ENA_BIT			15
+#define WM8991_TSHUT_ENA                        0x4000  /* TSHUT_ENA */
+#define WM8991_TSHUT_ENA_BIT			14
+#define WM8991_TSHUT_OPDIS                      0x2000  /* TSHUT_OPDIS */
+#define WM8991_TSHUT_OPDIS_BIT			13
+#define WM8991_OPCLK_ENA                        0x0800  /* OPCLK_ENA */
+#define WM8991_OPCLK_ENA_BIT			11
+#define WM8991_AINL_ENA                         0x0200  /* AINL_ENA */
+#define WM8991_AINL_ENA_BIT			9
+#define WM8991_AINR_ENA                         0x0100  /* AINR_ENA */
+#define WM8991_AINR_ENA_BIT			8
+#define WM8991_LIN34_ENA                        0x0080  /* LIN34_ENA */
+#define WM8991_LIN34_ENA_BIT			7
+#define WM8991_LIN12_ENA                        0x0040  /* LIN12_ENA */
+#define WM8991_LIN12_ENA_BIT			6
+#define WM8991_RIN34_ENA                        0x0020  /* RIN34_ENA */
+#define WM8991_RIN34_ENA_BIT			5
+#define WM8991_RIN12_ENA                        0x0010  /* RIN12_ENA */
+#define WM8991_RIN12_ENA_BIT			4
+#define WM8991_ADCL_ENA                         0x0002  /* ADCL_ENA */
+#define WM8991_ADCL_ENA_BIT			1
+#define WM8991_ADCR_ENA                         0x0001  /* ADCR_ENA */
+#define WM8991_ADCR_ENA_BIT			0
+
+/*
+ * R3 (0x03) - Power Management (3)
+ */
+#define WM8991_LON_ENA                          0x2000  /* LON_ENA */
+#define WM8991_LON_ENA_BIT			13
+#define WM8991_LOP_ENA                          0x1000  /* LOP_ENA */
+#define WM8991_LOP_ENA_BIT			12
+#define WM8991_RON_ENA                          0x0800  /* RON_ENA */
+#define WM8991_RON_ENA_BIT			11
+#define WM8991_ROP_ENA                          0x0400  /* ROP_ENA */
+#define WM8991_ROP_ENA_BIT			10
+#define WM8991_LOPGA_ENA                        0x0080  /* LOPGA_ENA */
+#define WM8991_LOPGA_ENA_BIT			7
+#define WM8991_ROPGA_ENA                        0x0040  /* ROPGA_ENA */
+#define WM8991_ROPGA_ENA_BIT			6
+#define WM8991_LOMIX_ENA                        0x0020  /* LOMIX_ENA */
+#define WM8991_LOMIX_ENA_BIT			5
+#define WM8991_ROMIX_ENA                        0x0010  /* ROMIX_ENA */
+#define WM8991_ROMIX_ENA_BIT			4
+#define WM8991_DACL_ENA                         0x0002  /* DACL_ENA */
+#define WM8991_DACL_ENA_BIT			1
+#define WM8991_DACR_ENA                         0x0001  /* DACR_ENA */
+#define WM8991_DACR_ENA_BIT			0
+
+/*
+ * R4 (0x04) - Audio Interface (1)
+ */
+#define WM8991_AIFADCL_SRC                      0x8000  /* AIFADCL_SRC */
+#define WM8991_AIFADCR_SRC                      0x4000  /* AIFADCR_SRC */
+#define WM8991_AIFADC_TDM                       0x2000  /* AIFADC_TDM */
+#define WM8991_AIFADC_TDM_CHAN                  0x1000  /* AIFADC_TDM_CHAN */
+#define WM8991_AIF_BCLK_INV                     0x0100  /* AIF_BCLK_INV */
+#define WM8991_AIF_LRCLK_INV                    0x0080  /* AIF_LRCLK_INV */
+#define WM8991_AIF_WL_MASK                      0x0060  /* AIF_WL - [6:5] */
+#define WM8991_AIF_WL_16BITS			(0 << 5)
+#define WM8991_AIF_WL_20BITS			(1 << 5)
+#define WM8991_AIF_WL_24BITS			(2 << 5)
+#define WM8991_AIF_WL_32BITS			(3 << 5)
+#define WM8991_AIF_FMT_MASK                     0x0018  /* AIF_FMT - [4:3] */
+#define WM8991_AIF_TMF_RIGHTJ			(0 << 3)
+#define WM8991_AIF_TMF_LEFTJ			(1 << 3)
+#define WM8991_AIF_TMF_I2S			(2 << 3)
+#define WM8991_AIF_TMF_DSP			(3 << 3)
+
+/*
+ * R5 (0x05) - Audio Interface (2)
+ */
+#define WM8991_DACL_SRC                         0x8000  /* DACL_SRC */
+#define WM8991_DACR_SRC                         0x4000  /* DACR_SRC */
+#define WM8991_AIFDAC_TDM                       0x2000  /* AIFDAC_TDM */
+#define WM8991_AIFDAC_TDM_CHAN                  0x1000  /* AIFDAC_TDM_CHAN */
+#define WM8991_DAC_BOOST_MASK                   0x0C00  /* DAC_BOOST - [11:10] */
+#define WM8991_DAC_COMP                         0x0010  /* DAC_COMP */
+#define WM8991_DAC_COMPMODE                     0x0008  /* DAC_COMPMODE */
+#define WM8991_ADC_COMP                         0x0004  /* ADC_COMP */
+#define WM8991_ADC_COMPMODE                     0x0002  /* ADC_COMPMODE */
+#define WM8991_LOOPBACK                         0x0001  /* LOOPBACK */
+
+/*
+ * R6 (0x06) - Clocking (1)
+ */
+#define WM8991_TOCLK_RATE                       0x8000  /* TOCLK_RATE */
+#define WM8991_TOCLK_ENA                        0x4000  /* TOCLK_ENA */
+#define WM8991_OPCLKDIV_MASK                    0x1E00  /* OPCLKDIV - [12:9] */
+#define WM8991_DCLKDIV_MASK                     0x01C0  /* DCLKDIV - [8:6] */
+#define WM8991_BCLK_DIV_MASK                    0x001E  /* BCLK_DIV - [4:1] */
+#define WM8991_BCLK_DIV_1			(0x0 << 1)
+#define WM8991_BCLK_DIV_1_5			(0x1 << 1)
+#define WM8991_BCLK_DIV_2			(0x2 << 1)
+#define WM8991_BCLK_DIV_3			(0x3 << 1)
+#define WM8991_BCLK_DIV_4			(0x4 << 1)
+#define WM8991_BCLK_DIV_5_5			(0x5 << 1)
+#define WM8991_BCLK_DIV_6			(0x6 << 1)
+#define WM8991_BCLK_DIV_8			(0x7 << 1)
+#define WM8991_BCLK_DIV_11			(0x8 << 1)
+#define WM8991_BCLK_DIV_12			(0x9 << 1)
+#define WM8991_BCLK_DIV_16			(0xA << 1)
+#define WM8991_BCLK_DIV_22			(0xB << 1)
+#define WM8991_BCLK_DIV_24			(0xC << 1)
+#define WM8991_BCLK_DIV_32			(0xD << 1)
+#define WM8991_BCLK_DIV_44			(0xE << 1)
+#define WM8991_BCLK_DIV_48			(0xF << 1)
+
+/*
+ * R7 (0x07) - Clocking (2)
+ */
+#define WM8991_MCLK_SRC                         0x8000  /* MCLK_SRC */
+#define WM8991_SYSCLK_SRC                       0x4000  /* SYSCLK_SRC */
+#define WM8991_CLK_FORCE                        0x2000  /* CLK_FORCE */
+#define WM8991_MCLK_DIV_MASK                    0x1800  /* MCLK_DIV - [12:11] */
+#define WM8991_MCLK_DIV_1			(0 << 11)
+#define WM8991_MCLK_DIV_2			( 2 << 11)
+#define WM8991_MCLK_INV                         0x0400  /* MCLK_INV */
+#define WM8991_ADC_CLKDIV_MASK                  0x00E0  /* ADC_CLKDIV - [7:5] */
+#define WM8991_ADC_CLKDIV_1			(0 << 5)
+#define WM8991_ADC_CLKDIV_1_5			(1 << 5)
+#define WM8991_ADC_CLKDIV_2			(2 << 5)
+#define WM8991_ADC_CLKDIV_3			(3 << 5)
+#define WM8991_ADC_CLKDIV_4			(4 << 5)
+#define WM8991_ADC_CLKDIV_5_5			(5 << 5)
+#define WM8991_ADC_CLKDIV_6			(6 << 5)
+#define WM8991_DAC_CLKDIV_MASK                  0x001C  /* DAC_CLKDIV - [4:2] */
+#define WM8991_DAC_CLKDIV_1			(0 << 2)
+#define WM8991_DAC_CLKDIV_1_5			(1 << 2)
+#define WM8991_DAC_CLKDIV_2			(2 << 2)
+#define WM8991_DAC_CLKDIV_3			(3 << 2)
+#define WM8991_DAC_CLKDIV_4			(4 << 2)
+#define WM8991_DAC_CLKDIV_5_5			(5 << 2)
+#define WM8991_DAC_CLKDIV_6			(6 << 2)
+
+/*
+ * R8 (0x08) - Audio Interface (3)
+ */
+#define WM8991_AIF_MSTR1                        0x8000  /* AIF_MSTR1 */
+#define WM8991_AIF_MSTR2                        0x4000  /* AIF_MSTR2 */
+#define WM8991_AIF_SEL                          0x2000  /* AIF_SEL */
+#define WM8991_ADCLRC_DIR                       0x0800  /* ADCLRC_DIR */
+#define WM8991_ADCLRC_RATE_MASK                 0x07FF  /* ADCLRC_RATE - [10:0] */
+
+/*
+ * R9 (0x09) - Audio Interface (4)
+ */
+#define WM8991_ALRCGPIO1                        0x8000  /* ALRCGPIO1 */
+#define WM8991_ALRCBGPIO6                       0x4000  /* ALRCBGPIO6 */
+#define WM8991_AIF_TRIS                         0x2000  /* AIF_TRIS */
+#define WM8991_DACLRC_DIR                       0x0800  /* DACLRC_DIR */
+#define WM8991_DACLRC_RATE_MASK                 0x07FF  /* DACLRC_RATE - [10:0] */
+
+/*
+ * R10 (0x0A) - DAC CTRL
+ */
+#define WM8991_AIF_LRCLKRATE                    0x0400  /* AIF_LRCLKRATE */
+#define WM8991_DAC_MONO                         0x0200  /* DAC_MONO */
+#define WM8991_DAC_SB_FILT                      0x0100  /* DAC_SB_FILT */
+#define WM8991_DAC_MUTERATE                     0x0080  /* DAC_MUTERATE */
+#define WM8991_DAC_MUTEMODE                     0x0040  /* DAC_MUTEMODE */
+#define WM8991_DEEMP_MASK                       0x0030  /* DEEMP - [5:4] */
+#define WM8991_DAC_MUTE                         0x0004  /* DAC_MUTE */
+#define WM8991_DACL_DATINV                      0x0002  /* DACL_DATINV */
+#define WM8991_DACR_DATINV                      0x0001  /* DACR_DATINV */
+
+/*
+ * R11 (0x0B) - Left DAC Digital Volume
+ */
+#define WM8991_DAC_VU                           0x0100  /* DAC_VU */
+#define WM8991_DACL_VOL_MASK                    0x00FF  /* DACL_VOL - [7:0] */
+#define WM8991_DACL_VOL_SHIFT			0
+/*
+ * R12 (0x0C) - Right DAC Digital Volume
+ */
+#define WM8991_DAC_VU                           0x0100  /* DAC_VU */
+#define WM8991_DACR_VOL_MASK                    0x00FF  /* DACR_VOL - [7:0] */
+#define WM8991_DACR_VOL_SHIFT			0
+/*
+ * R13 (0x0D) - Digital Side Tone
+ */
+#define WM8991_ADCL_DAC_SVOL_MASK               0x0F  /* ADCL_DAC_SVOL - [12:9] */
+#define WM8991_ADCL_DAC_SVOL_SHIFT		9
+#define WM8991_ADCR_DAC_SVOL_MASK               0x0F  /* ADCR_DAC_SVOL - [8:5] */
+#define WM8991_ADCR_DAC_SVOL_SHIFT		5
+#define WM8991_ADC_TO_DACL_MASK                 0x03  /* ADC_TO_DACL - [3:2] */
+#define WM8991_ADC_TO_DACL_SHIFT		2
+#define WM8991_ADC_TO_DACR_MASK                 0x03  /* ADC_TO_DACR - [1:0] */
+#define WM8991_ADC_TO_DACR_SHIFT		0
+
+/*
+ * R14 (0x0E) - ADC CTRL
+ */
+#define WM8991_ADC_HPF_ENA                      0x0100  /* ADC_HPF_ENA */
+#define WM8991_ADC_HPF_ENA_BIT			8
+#define WM8991_ADC_HPF_CUT_MASK                 0x03  /* ADC_HPF_CUT - [6:5] */
+#define WM8991_ADC_HPF_CUT_SHIFT		5
+#define WM8991_ADCL_DATINV                      0x0002  /* ADCL_DATINV */
+#define WM8991_ADCL_DATINV_BIT			1
+#define WM8991_ADCR_DATINV                      0x0001  /* ADCR_DATINV */
+#define WM8991_ADCR_DATINV_BIT			0
+
+/*
+ * R15 (0x0F) - Left ADC Digital Volume
+ */
+#define WM8991_ADC_VU                           0x0100  /* ADC_VU */
+#define WM8991_ADCL_VOL_MASK                    0x00FF  /* ADCL_VOL - [7:0] */
+#define WM8991_ADCL_VOL_SHIFT			0
+
+/*
+ * R16 (0x10) - Right ADC Digital Volume
+ */
+#define WM8991_ADC_VU                           0x0100  /* ADC_VU */
+#define WM8991_ADCR_VOL_MASK                    0x00FF  /* ADCR_VOL - [7:0] */
+#define WM8991_ADCR_VOL_SHIFT			0
+
+/*
+ * R18 (0x12) - GPIO CTRL 1
+ */
+#define WM8991_IRQ                              0x1000  /* IRQ */
+#define WM8991_TEMPOK                           0x0800  /* TEMPOK */
+#define WM8991_MICSHRT                          0x0400  /* MICSHRT */
+#define WM8991_MICDET                           0x0200  /* MICDET */
+#define WM8991_PLL_LCK                          0x0100  /* PLL_LCK */
+#define WM8991_GPI8_STATUS                      0x0080  /* GPI8_STATUS */
+#define WM8991_GPI7_STATUS                      0x0040  /* GPI7_STATUS */
+#define WM8991_GPIO6_STATUS                     0x0020  /* GPIO6_STATUS */
+#define WM8991_GPIO5_STATUS                     0x0010  /* GPIO5_STATUS */
+#define WM8991_GPIO4_STATUS                     0x0008  /* GPIO4_STATUS */
+#define WM8991_GPIO3_STATUS                     0x0004  /* GPIO3_STATUS */
+#define WM8991_GPIO2_STATUS                     0x0002  /* GPIO2_STATUS */
+#define WM8991_GPIO1_STATUS                     0x0001  /* GPIO1_STATUS */
+
+/*
+ * R19 (0x13) - GPIO1 & GPIO2
+ */
+#define WM8991_GPIO2_DEB_ENA                    0x8000  /* GPIO2_DEB_ENA */
+#define WM8991_GPIO2_IRQ_ENA                    0x4000  /* GPIO2_IRQ_ENA */
+#define WM8991_GPIO2_PU                         0x2000  /* GPIO2_PU */
+#define WM8991_GPIO2_PD                         0x1000  /* GPIO2_PD */
+#define WM8991_GPIO2_SEL_MASK                   0x0F00  /* GPIO2_SEL - [11:8] */
+#define WM8991_GPIO1_DEB_ENA                    0x0080  /* GPIO1_DEB_ENA */
+#define WM8991_GPIO1_IRQ_ENA                    0x0040  /* GPIO1_IRQ_ENA */
+#define WM8991_GPIO1_PU                         0x0020  /* GPIO1_PU */
+#define WM8991_GPIO1_PD                         0x0010  /* GPIO1_PD */
+#define WM8991_GPIO1_SEL_MASK                   0x000F  /* GPIO1_SEL - [3:0] */
+
+/*
+ * R20 (0x14) - GPIO3 & GPIO4
+ */
+#define WM8991_GPIO4_DEB_ENA                    0x8000  /* GPIO4_DEB_ENA */
+#define WM8991_GPIO4_IRQ_ENA                    0x4000  /* GPIO4_IRQ_ENA */
+#define WM8991_GPIO4_PU                         0x2000  /* GPIO4_PU */
+#define WM8991_GPIO4_PD                         0x1000  /* GPIO4_PD */
+#define WM8991_GPIO4_SEL_MASK                   0x0F00  /* GPIO4_SEL - [11:8] */
+#define WM8991_GPIO3_DEB_ENA                    0x0080  /* GPIO3_DEB_ENA */
+#define WM8991_GPIO3_IRQ_ENA                    0x0040  /* GPIO3_IRQ_ENA */
+#define WM8991_GPIO3_PU                         0x0020  /* GPIO3_PU */
+#define WM8991_GPIO3_PD                         0x0010  /* GPIO3_PD */
+#define WM8991_GPIO3_SEL_MASK                   0x000F  /* GPIO3_SEL - [3:0] */
+
+/*
+ * R21 (0x15) - GPIO5 & GPIO6
+ */
+#define WM8991_GPIO6_DEB_ENA                    0x8000  /* GPIO6_DEB_ENA */
+#define WM8991_GPIO6_IRQ_ENA                    0x4000  /* GPIO6_IRQ_ENA */
+#define WM8991_GPIO6_PU                         0x2000  /* GPIO6_PU */
+#define WM8991_GPIO6_PD                         0x1000  /* GPIO6_PD */
+#define WM8991_GPIO6_SEL_MASK                   0x0F00  /* GPIO6_SEL - [11:8] */
+#define WM8991_GPIO5_DEB_ENA                    0x0080  /* GPIO5_DEB_ENA */
+#define WM8991_GPIO5_IRQ_ENA                    0x0040  /* GPIO5_IRQ_ENA */
+#define WM8991_GPIO5_PU                         0x0020  /* GPIO5_PU */
+#define WM8991_GPIO5_PD                         0x0010  /* GPIO5_PD */
+#define WM8991_GPIO5_SEL_MASK                   0x000F  /* GPIO5_SEL - [3:0] */
+
+/*
+ * R22 (0x16) - GPIOCTRL 2
+ */
+#define WM8991_RD_3W_ENA                        0x8000  /* RD_3W_ENA */
+#define WM8991_MODE_3W4W                        0x4000  /* MODE_3W4W */
+#define WM8991_TEMPOK_IRQ_ENA                   0x0800  /* TEMPOK_IRQ_ENA */
+#define WM8991_MICSHRT_IRQ_ENA                  0x0400  /* MICSHRT_IRQ_ENA */
+#define WM8991_MICDET_IRQ_ENA                   0x0200  /* MICDET_IRQ_ENA */
+#define WM8991_PLL_LCK_IRQ_ENA                  0x0100  /* PLL_LCK_IRQ_ENA */
+#define WM8991_GPI8_DEB_ENA                     0x0080  /* GPI8_DEB_ENA */
+#define WM8991_GPI8_IRQ_ENA                     0x0040  /* GPI8_IRQ_ENA */
+#define WM8991_GPI8_ENA                         0x0010  /* GPI8_ENA */
+#define WM8991_GPI7_DEB_ENA                     0x0008  /* GPI7_DEB_ENA */
+#define WM8991_GPI7_IRQ_ENA                     0x0004  /* GPI7_IRQ_ENA */
+#define WM8991_GPI7_ENA                         0x0001  /* GPI7_ENA */
+
+/*
+ * R23 (0x17) - GPIO_POL
+ */
+#define WM8991_IRQ_INV                          0x1000  /* IRQ_INV */
+#define WM8991_TEMPOK_POL                       0x0800  /* TEMPOK_POL */
+#define WM8991_MICSHRT_POL                      0x0400  /* MICSHRT_POL */
+#define WM8991_MICDET_POL                       0x0200  /* MICDET_POL */
+#define WM8991_PLL_LCK_POL                      0x0100  /* PLL_LCK_POL */
+#define WM8991_GPI8_POL                         0x0080  /* GPI8_POL */
+#define WM8991_GPI7_POL                         0x0040  /* GPI7_POL */
+#define WM8991_GPIO6_POL                        0x0020  /* GPIO6_POL */
+#define WM8991_GPIO5_POL                        0x0010  /* GPIO5_POL */
+#define WM8991_GPIO4_POL                        0x0008  /* GPIO4_POL */
+#define WM8991_GPIO3_POL                        0x0004  /* GPIO3_POL */
+#define WM8991_GPIO2_POL                        0x0002  /* GPIO2_POL */
+#define WM8991_GPIO1_POL                        0x0001  /* GPIO1_POL */
+
+/*
+ * R24 (0x18) - Left Line Input 1&2 Volume
+ */
+#define WM8991_IPVU                             0x0100  /* IPVU */
+#define WM8991_LI12MUTE                         0x0080  /* LI12MUTE */
+#define WM8991_LI12MUTE_BIT			7
+#define WM8991_LI12ZC                           0x0040  /* LI12ZC */
+#define WM8991_LI12ZC_BIT			6
+#define WM8991_LIN12VOL_MASK                    0x001F  /* LIN12VOL - [4:0] */
+#define WM8991_LIN12VOL_SHIFT			0
+/*
+ * R25 (0x19) - Left Line Input 3&4 Volume
+ */
+#define WM8991_IPVU                             0x0100  /* IPVU */
+#define WM8991_LI34MUTE                         0x0080  /* LI34MUTE */
+#define WM8991_LI34MUTE_BIT			7
+#define WM8991_LI34ZC                           0x0040  /* LI34ZC */
+#define WM8991_LI34ZC_BIT			6
+#define WM8991_LIN34VOL_MASK                    0x001F  /* LIN34VOL - [4:0] */
+#define WM8991_LIN34VOL_SHIFT			0
+
+/*
+ * R26 (0x1A) - Right Line Input 1&2 Volume
+ */
+#define WM8991_IPVU                             0x0100  /* IPVU */
+#define WM8991_RI12MUTE                         0x0080  /* RI12MUTE */
+#define WM8991_RI12MUTE_BIT			7
+#define WM8991_RI12ZC                           0x0040  /* RI12ZC */
+#define WM8991_RI12ZC_BIT			6
+#define WM8991_RIN12VOL_MASK                    0x001F  /* RIN12VOL - [4:0] */
+#define WM8991_RIN12VOL_SHIFT			0
+
+/*
+ * R27 (0x1B) - Right Line Input 3&4 Volume
+ */
+#define WM8991_IPVU                             0x0100  /* IPVU */
+#define WM8991_RI34MUTE                         0x0080  /* RI34MUTE */
+#define WM8991_RI34MUTE_BIT			7
+#define WM8991_RI34ZC                           0x0040  /* RI34ZC */
+#define WM8991_RI34ZC_BIT			6
+#define WM8991_RIN34VOL_MASK                    0x001F  /* RIN34VOL - [4:0] */
+#define WM8991_RIN34VOL_SHIFT			0
+
+/*
+ * R28 (0x1C) - Left Output Volume
+ */
+#define WM8991_OPVU                             0x0100  /* OPVU */
+#define WM8991_LOZC                             0x0080  /* LOZC */
+#define WM8991_LOZC_BIT				7
+#define WM8991_LOUTVOL_MASK                     0x007F  /* LOUTVOL - [6:0] */
+#define WM8991_LOUTVOL_SHIFT			0
+/*
+ * R29 (0x1D) - Right Output Volume
+ */
+#define WM8991_OPVU                             0x0100  /* OPVU */
+#define WM8991_ROZC                             0x0080  /* ROZC */
+#define WM8991_ROZC_BIT				7
+#define WM8991_ROUTVOL_MASK                     0x007F  /* ROUTVOL - [6:0] */
+#define WM8991_ROUTVOL_SHIFT			0
+/*
+ * R30 (0x1E) - Line Outputs Volume
+ */
+#define WM8991_LONMUTE                          0x0040  /* LONMUTE */
+#define WM8991_LONMUTE_BIT			6
+#define WM8991_LOPMUTE                          0x0020  /* LOPMUTE */
+#define WM8991_LOPMUTE_BIT			5
+#define WM8991_LOATTN                           0x0010  /* LOATTN */
+#define WM8991_LOATTN_BIT			4
+#define WM8991_RONMUTE                          0x0004  /* RONMUTE */
+#define WM8991_RONMUTE_BIT			2
+#define WM8991_ROPMUTE                          0x0002  /* ROPMUTE */
+#define WM8991_ROPMUTE_BIT			1
+#define WM8991_ROATTN                           0x0001  /* ROATTN */
+#define WM8991_ROATTN_BIT			0
+
+/*
+ * R31 (0x1F) - Out3/4 Volume
+ */
+#define WM8991_OUT3MUTE                         0x0020  /* OUT3MUTE */
+#define WM8991_OUT3MUTE_BIT			5
+#define WM8991_OUT3ATTN                         0x0010  /* OUT3ATTN */
+#define WM8991_OUT3ATTN_BIT			4
+#define WM8991_OUT4MUTE                         0x0002  /* OUT4MUTE */
+#define WM8991_OUT4MUTE_BIT			1
+#define WM8991_OUT4ATTN                         0x0001  /* OUT4ATTN */
+#define WM8991_OUT4ATTN_BIT			0
+
+/*
+ * R32 (0x20) - Left OPGA Volume
+ */
+#define WM8991_OPVU                             0x0100  /* OPVU */
+#define WM8991_LOPGAZC                          0x0080  /* LOPGAZC */
+#define WM8991_LOPGAZC_BIT			7
+#define WM8991_LOPGAVOL_MASK                    0x007F  /* LOPGAVOL - [6:0] */
+#define WM8991_LOPGAVOL_SHIFT			0
+
+/*
+ * R33 (0x21) - Right OPGA Volume
+ */
+#define WM8991_OPVU                             0x0100  /* OPVU */
+#define WM8991_ROPGAZC                          0x0080  /* ROPGAZC */
+#define WM8991_ROPGAZC_BIT			7
+#define WM8991_ROPGAVOL_MASK                    0x007F  /* ROPGAVOL - [6:0] */
+#define WM8991_ROPGAVOL_SHIFT			0
+/*
+ * R34 (0x22) - Speaker Volume
+ */
+#define WM8991_SPKVOL_MASK                      0x0003  /* SPKVOL - [1:0] */
+#define WM8991_SPKVOL_SHIFT			0
+
+/*
+ * R35 (0x23) - ClassD1
+ */
+#define WM8991_CDMODE                           0x0100  /* CDMODE */
+#define WM8991_CDMODE_BIT			8
+
+/*
+ * R37 (0x25) - ClassD3
+ */
+#define WM8991_DCGAIN_MASK                      0x0007  /* DCGAIN - [5:3] */
+#define WM8991_DCGAIN_SHIFT			3
+#define WM8991_ACGAIN_MASK                      0x0007  /* ACGAIN - [2:0] */
+#define WM8991_ACGAIN_SHIFT			0
+/*
+ * R39 (0x27) - Input Mixer1
+ */
+#define WM8991_AINLMODE_MASK                    0x000C  /* AINLMODE - [3:2] */
+#define WM8991_AINLMODE_SHIFT			2
+#define WM8991_AINRMODE_MASK                    0x0003  /* AINRMODE - [1:0] */
+#define WM8991_AINRMODE_SHIFT			0
+
+/*
+ * R40 (0x28) - Input Mixer2
+ */
+#define WM8991_LMP4								0x0080	/* LMP4 */
+#define WM8991_LMP4_BIT                         7		/* LMP4 */
+#define WM8991_LMN3                             0x0040  /* LMN3 */
+#define WM8991_LMN3_BIT                         6       /* LMN3 */
+#define WM8991_LMP2                             0x0020  /* LMP2 */
+#define WM8991_LMP2_BIT                         5       /* LMP2 */
+#define WM8991_LMN1                             0x0010  /* LMN1 */
+#define WM8991_LMN1_BIT                         4       /* LMN1 */
+#define WM8991_RMP4                             0x0008  /* RMP4 */
+#define WM8991_RMP4_BIT                         3       /* RMP4 */
+#define WM8991_RMN3                             0x0004  /* RMN3 */
+#define WM8991_RMN3_BIT                         2       /* RMN3 */
+#define WM8991_RMP2                             0x0002  /* RMP2 */
+#define WM8991_RMP2_BIT                         1       /* RMP2 */
+#define WM8991_RMN1                             0x0001  /* RMN1 */
+#define WM8991_RMN1_BIT                         0       /* RMN1 */
+
+/*
+ * R41 (0x29) - Input Mixer3
+ */
+#define WM8991_L34MNB                           0x0100  /* L34MNB */
+#define WM8991_L34MNB_BIT			8
+#define WM8991_L34MNBST                         0x0080  /* L34MNBST */
+#define WM8991_L34MNBST_BIT			7
+#define WM8991_L12MNB                           0x0020  /* L12MNB */
+#define WM8991_L12MNB_BIT			5
+#define WM8991_L12MNBST                         0x0010  /* L12MNBST */
+#define WM8991_L12MNBST_BIT			4
+#define WM8991_LDBVOL_MASK                      0x0007  /* LDBVOL - [2:0] */
+#define WM8991_LDBVOL_SHIFT			0
+
+/*
+ * R42 (0x2A) - Input Mixer4
+ */
+#define WM8991_R34MNB                           0x0100  /* R34MNB */
+#define WM8991_R34MNB_BIT			8
+#define WM8991_R34MNBST                         0x0080  /* R34MNBST */
+#define WM8991_R34MNBST_BIT			7
+#define WM8991_R12MNB                           0x0020  /* R12MNB */
+#define WM8991_R12MNB_BIT			5
+#define WM8991_R12MNBST                         0x0010  /* R12MNBST */
+#define WM8991_R12MNBST_BIT			4
+#define WM8991_RDBVOL_MASK                      0x0007  /* RDBVOL - [2:0] */
+#define WM8991_RDBVOL_SHIFT			0
+
+/*
+ * R43 (0x2B) - Input Mixer5
+ */
+#define WM8991_LI2BVOL_MASK                     0x07  /* LI2BVOL - [8:6] */
+#define WM8991_LI2BVOL_SHIFT			6
+#define WM8991_LR4BVOL_MASK                     0x07  /* LR4BVOL - [5:3] */
+#define WM8991_LR4BVOL_SHIFT			3
+#define WM8991_LL4BVOL_MASK                     0x07  /* LL4BVOL - [2:0] */
+#define WM8991_LL4BVOL_SHIFT			0
+
+/*
+ * R44 (0x2C) - Input Mixer6
+ */
+#define WM8991_RI2BVOL_MASK                     0x07  /* RI2BVOL - [8:6] */
+#define WM8991_RI2BVOL_SHIFT			6
+#define WM8991_RL4BVOL_MASK                     0x07  /* RL4BVOL - [5:3] */
+#define WM8991_RL4BVOL_SHIFT			3
+#define WM8991_RR4BVOL_MASK                     0x07  /* RR4BVOL - [2:0] */
+#define WM8991_RR4BVOL_SHIFT			0
+
+/*
+ * R45 (0x2D) - Output Mixer1
+ */
+#define WM8991_LRBLO                            0x0080  /* LRBLO */
+#define WM8991_LRBLO_BIT			7
+#define WM8991_LLBLO                            0x0040  /* LLBLO */
+#define WM8991_LLBLO_BIT			6
+#define WM8991_LRI3LO                           0x0020  /* LRI3LO */
+#define WM8991_LRI3LO_BIT			5
+#define WM8991_LLI3LO                           0x0010  /* LLI3LO */
+#define WM8991_LLI3LO_BIT			4
+#define WM8991_LR12LO                           0x0008  /* LR12LO */
+#define WM8991_LR12LO_BIT			3
+#define WM8991_LL12LO                           0x0004  /* LL12LO */
+#define WM8991_LL12LO_BIT			2
+#define WM8991_LDLO                             0x0001  /* LDLO */
+#define WM8991_LDLO_BIT				0
+
+/*
+ * R46 (0x2E) - Output Mixer2
+ */
+#define WM8991_RLBRO                            0x0080  /* RLBRO */
+#define WM8991_RLBRO_BIT			7
+#define WM8991_RRBRO                            0x0040  /* RRBRO */
+#define WM8991_RRBRO_BIT			6
+#define WM8991_RLI3RO                           0x0020  /* RLI3RO */
+#define WM8991_RLI3RO_BIT			5
+#define WM8991_RRI3RO                           0x0010  /* RRI3RO */
+#define WM8991_RRI3RO_BIT			4
+#define WM8991_RL12RO                           0x0008  /* RL12RO */
+#define WM8991_RL12RO_BIT			3
+#define WM8991_RR12RO                           0x0004  /* RR12RO */
+#define WM8991_RR12RO_BIT			2
+#define WM8991_RDRO                             0x0001  /* RDRO */
+#define WM8991_RDRO_BIT				0
+
+/*
+ * R47 (0x2F) - Output Mixer3
+ */
+#define WM8991_LLI3LOVOL_MASK                   0x07  /* LLI3LOVOL - [8:6] */
+#define WM8991_LLI3LOVOL_SHIFT			6
+#define WM8991_LR12LOVOL_MASK                   0x07  /* LR12LOVOL - [5:3] */
+#define WM8991_LR12LOVOL_SHIFT			3
+#define WM8991_LL12LOVOL_MASK                   0x07  /* LL12LOVOL - [2:0] */
+#define WM8991_LL12LOVOL_SHIFT			0
+
+/*
+ * R48 (0x30) - Output Mixer4
+ */
+#define WM8991_RRI3ROVOL_MASK                   0x07  /* RRI3ROVOL - [8:6] */
+#define WM8991_RRI3ROVOL_SHIFT			6
+#define WM8991_RL12ROVOL_MASK                   0x07  /* RL12ROVOL - [5:3] */
+#define WM8991_RL12ROVOL_SHIFT			3
+#define WM8991_RR12ROVOL_MASK                   0x07  /* RR12ROVOL - [2:0] */
+#define WM8991_RR12ROVOL_SHIFT			0
+
+/*
+ * R49 (0x31) - Output Mixer5
+ */
+#define WM8991_LRI3LOVOL_MASK                   0x07  /* LRI3LOVOL - [8:6] */
+#define WM8991_LRI3LOVOL_SHIFT			6
+#define WM8991_LRBLOVOL_MASK                    0x07  /* LRBLOVOL - [5:3] */
+#define WM8991_LRBLOVOL_SHIFT			3
+#define WM8991_LLBLOVOL_MASK                    0x07  /* LLBLOVOL - [2:0] */
+#define WM8991_LLBLOVOL_SHIFT			0
+
+/*
+ * R50 (0x32) - Output Mixer6
+ */
+#define WM8991_RLI3ROVOL_MASK                   0x07  /* RLI3ROVOL - [8:6] */
+#define WM8991_RLI3ROVOL_SHIFT			6
+#define WM8991_RLBROVOL_MASK                    0x07  /* RLBROVOL - [5:3] */
+#define WM8991_RLBROVOL_SHIFT			3
+#define WM8991_RRBROVOL_MASK                    0x07  /* RRBROVOL - [2:0] */
+#define WM8991_RRBROVOL_SHIFT			0
+
+/*
+ * R51 (0x33) - Out3/4 Mixer
+ */
+#define WM8991_VSEL_MASK                        0x0180  /* VSEL - [8:7] */
+#define WM8991_LI4O3                            0x0020  /* LI4O3 */
+#define WM8991_LI4O3_BIT			5
+#define WM8991_LPGAO3                           0x0010  /* LPGAO3 */
+#define WM8991_LPGAO3_BIT			4
+#define WM8991_RI4O4                            0x0002  /* RI4O4 */
+#define WM8991_RI4O4_BIT			1
+#define WM8991_RPGAO4                           0x0001  /* RPGAO4 */
+#define WM8991_RPGAO4_BIT			0
+/*
+ * R52 (0x34) - Line Mixer1
+ */
+#define WM8991_LLOPGALON                        0x0040  /* LLOPGALON */
+#define WM8991_LLOPGALON_BIT			6
+#define WM8991_LROPGALON                        0x0020  /* LROPGALON */
+#define WM8991_LROPGALON_BIT			5
+#define WM8991_LOPLON                           0x0010  /* LOPLON */
+#define WM8991_LOPLON_BIT			4
+#define WM8991_LR12LOP                          0x0004  /* LR12LOP */
+#define WM8991_LR12LOP_BIT			2
+#define WM8991_LL12LOP                          0x0002  /* LL12LOP */
+#define WM8991_LL12LOP_BIT			1
+#define WM8991_LLOPGALOP                        0x0001  /* LLOPGALOP */
+#define WM8991_LLOPGALOP_BIT			0
+/*
+ * R53 (0x35) - Line Mixer2
+ */
+#define WM8991_RROPGARON                        0x0040  /* RROPGARON */
+#define WM8991_RROPGARON_BIT			6
+#define WM8991_RLOPGARON                        0x0020  /* RLOPGARON */
+#define WM8991_RLOPGARON_BIT			5
+#define WM8991_ROPRON                           0x0010  /* ROPRON */
+#define WM8991_ROPRON_BIT			4
+#define WM8991_RL12ROP                          0x0004  /* RL12ROP */
+#define WM8991_RL12ROP_BIT			2
+#define WM8991_RR12ROP                          0x0002  /* RR12ROP */
+#define WM8991_RR12ROP_BIT			1
+#define WM8991_RROPGAROP                        0x0001  /* RROPGAROP */
+#define WM8991_RROPGAROP_BIT			0
+
+/*
+ * R54 (0x36) - Speaker Mixer
+ */
+#define WM8991_LB2SPK                           0x0080  /* LB2SPK */
+#define WM8991_LB2SPK_BIT			7
+#define WM8991_RB2SPK                           0x0040  /* RB2SPK */
+#define WM8991_RB2SPK_BIT			6
+#define WM8991_LI2SPK                           0x0020  /* LI2SPK */
+#define WM8991_LI2SPK_BIT			5
+#define WM8991_RI2SPK                           0x0010  /* RI2SPK */
+#define WM8991_RI2SPK_BIT			4
+#define WM8991_LOPGASPK                         0x0008  /* LOPGASPK */
+#define WM8991_LOPGASPK_BIT			3
+#define WM8991_ROPGASPK                         0x0004  /* ROPGASPK */
+#define WM8991_ROPGASPK_BIT			2
+#define WM8991_LDSPK                            0x0002  /* LDSPK */
+#define WM8991_LDSPK_BIT			1
+#define WM8991_RDSPK                            0x0001  /* RDSPK */
+#define WM8991_RDSPK_BIT			0
+
+/*
+ * R55 (0x37) - Additional Control
+ */
+#define WM8991_VROI                             0x0001  /* VROI */
+
+/*
+ * R56 (0x38) - AntiPOP1
+ */
+#define WM8991_DIS_LLINE                        0x0020  /* DIS_LLINE */
+#define WM8991_DIS_RLINE                        0x0010  /* DIS_RLINE */
+#define WM8991_DIS_OUT3                         0x0008  /* DIS_OUT3 */
+#define WM8991_DIS_OUT4                         0x0004  /* DIS_OUT4 */
+#define WM8991_DIS_LOUT                         0x0002  /* DIS_LOUT */
+#define WM8991_DIS_ROUT                         0x0001  /* DIS_ROUT */
+
+/*
+ * R57 (0x39) - AntiPOP2
+ */
+#define WM8991_SOFTST                           0x0040  /* SOFTST */
+#define WM8991_BUFIOEN                          0x0008  /* BUFIOEN */
+#define WM8991_BUFDCOPEN                        0x0004  /* BUFDCOPEN */
+#define WM8991_POBCTRL                          0x0002  /* POBCTRL */
+#define WM8991_VMIDTOG                          0x0001  /* VMIDTOG */
+
+/*
+ * R58 (0x3A) - MICBIAS
+ */
+#define WM8991_MCDSCTH_MASK                     0x00C0  /* MCDSCTH - [7:6] */
+#define WM8991_MCDTHR_MASK                      0x0038  /* MCDTHR - [5:3] */
+#define WM8991_MCD                              0x0004  /* MCD */
+#define WM8991_MBSEL                            0x0001  /* MBSEL */
+
+/*
+ * R60 (0x3C) - PLL1
+ */
+#define WM8991_SDM                              0x0080  /* SDM */
+#define WM8991_PRESCALE                         0x0040  /* PRESCALE */
+#define WM8991_PLLN_MASK                        0x000F  /* PLLN - [3:0] */
+
+/*
+ * R61 (0x3D) - PLL2
+ */
+#define WM8991_PLLK1_MASK                       0x00FF  /* PLLK1 - [7:0] */
+
+/*
+ * R62 (0x3E) - PLL3
+ */
+#define WM8991_PLLK2_MASK                       0x00FF  /* PLLK2 - [7:0] */
+
+/*
+ * R63 (0x3F) - Internal Driver Bits
+ */
+#define WM8991_INMIXL_PWR_BIT			0
+#define WM8991_AINLMUX_PWR_BIT			1
+#define WM8991_INMIXR_PWR_BIT			2
+#define WM8991_AINRMUX_PWR_BIT			3
+
+#define WM8991_MCLK_DIV 0
+#define WM8991_DACCLK_DIV 1
+#define WM8991_ADCCLK_DIV 2
+#define WM8991_BCLK_DIV 3
+
+#define SOC_WM899X_OUTPGA_SINGLE_R_TLV(xname, reg, shift, max, invert,\
+					 tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_volsw, .put = wm899x_outpga_put_volsw_vu, \
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert) }
+
+#endif /* _WM8991_H */
-- 
1.7.3.5
