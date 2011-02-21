From: javier Martin <javier.martin@vista-silicon.com>
Subject: [ASoC] Problem with codec driver for tlv320aic32x4 and
	bias level.
Date: Mon, 21 Feb 2011 10:00:38 +0100
Message-ID: <AANLkTimG-x2ePD2ehMgKuSCPfmVi4gF6yUOiiim5Y9qP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 799C024368
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 10:00:41 +0100 (CET)
Received: by iym7 with SMTP id 7so64877iym.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 01:00:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I am currently developing a codec driver for tlv320aic32x4 codec for
kernel 2.6.37, based on a TI driver made for 2.6.27. The last version
of the code is posted below as plain text, not as a patch because it
is only meant for showing purposes.

As you can see, my "aic32x4_probe" function sets bias level to
SND_SOC_BIAS_OFF. As far as I know, when I enable playback (with aplay
command), ASoC should call "aic32x4_set_bias_level" and change level
to SND_SOC_BIAS_ON and thus triggering some dapm events. However, this
won't happen with the current version of the code.

Maybe someone could point out some tips.

--

/*
 * linux/sound/soc/codecs/tlv320aic32x4.c
 *
 * Copyright 2011 Vista Silicon S.L.
 *
 * Author: Javier Martin <javier.martin@vista-silicon.com>
 *
 * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 */

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/i2c.h>
#include <linux/platform_device.h>
#include <linux/cdev.h>
#include <linux/slab.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/initval.h>

#include "tlv320aic32x4.h"

#define SOC_DOUBLE_R_AIC32X4(xname, reg_left, reg_right, shift, mask, invert) \
{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
	.info = snd_soc_info_volsw_2r_aic32x4, \
	.get = snd_soc_get_volsw_2r_aic32x4, .put = snd_soc_put_volsw_2r_aic32x4, \
	.private_value = (reg_left) | ((shift) << 8)  | \
		((mask) << 12) | ((invert) << 20) | ((reg_right) << 24) }

static int aic32x4_set_bias_level(struct snd_soc_codec *codec, enum
snd_soc_bias_level level);

static int snd_soc_info_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
    struct snd_ctl_elem_info *uinfo);

static int snd_soc_get_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
					struct snd_ctl_elem_value *ucontrol);

static int snd_soc_put_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
					struct snd_ctl_elem_value *ucontrol);

/*
 *****************************************************************************
 * Structure Initialization
 *****************************************************************************
 */
static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
	/* Output */
	/* sound new kcontrol for PCM Playback volume control */
	SOC_DOUBLE_R_AIC32X4("PCM Playback Volume", LDAC_VOL, RDAC_VOL, 0, 0xAf,
			     0),
	/* sound new kcontrol for HP driver gain */
	SOC_DOUBLE_R_AIC32X4("HP Driver Gain", HPL_GAIN, HPR_GAIN, 0, 0x23, 0),
	/* sound new kcontrol for LO driver gain */
	SOC_DOUBLE_R_AIC32X4("LO Driver Gain", LOL_GAIN, LOR_GAIN, 0, 0x23, 0),
	/* sound new kcontrol for HP mute */
	SOC_DOUBLE_R("HP DAC Playback Switch", HPL_GAIN, HPR_GAIN, 6,
		     0x01, 1),
	/* sound new kcontrol for LO mute */
	SOC_DOUBLE_R("LO DAC Playback Switch", LOL_GAIN, LOR_GAIN, 6,
		     0x01, 1),

	/* Input */
	/* sound new kcontrol for PGA capture volume */
	SOC_DOUBLE_R("ADC Volume Level", LADC_VOL, RADC_VOL, 0, 0x28,
			     0),
	SOC_DOUBLE_R("PGA Gain Level", LMICPGA_VOL_CTRL, RMICPGA_VOL_CTRL, 0, 0x5f, 0),

	/* DAC Automute control */
	SOC_SINGLE("Auto-mute", DAC_MUTE_CTRL_REG, 4, 7, 0),
	
	/* AGC controls */
	SOC_SINGLE("AGC Left Enable Switch", LEFT_CHN_AGC_1, 7, 1, 0),
	SOC_SINGLE("AGC Right Enable Switch", RIGHT_CHN_AGC_1, 7, 1, 0),
	SOC_DOUBLE_R("AGC Target Level", LEFT_CHN_AGC_1, RIGHT_CHN_AGC_1,
			4, 0x07, 0),
	SOC_DOUBLE_R("AGC Gain Hysteresis", LEFT_CHN_AGC_1, RIGHT_CHN_AGC_1,
			0, 0x03, 0),
	SOC_DOUBLE_R("AGC Hysteresis", LEFT_CHN_AGC_2, RIGHT_CHN_AGC_2,
			6, 0x03, 0),
	SOC_DOUBLE_R("AGC Noise Threshold", LEFT_CHN_AGC_2, RIGHT_CHN_AGC_2,
			1, 0x1F, 0),
	SOC_DOUBLE_R("AGC Max PGA", LEFT_CHN_AGC_3, RIGHT_CHN_AGC_3,
			0, 0x7F, 0),
	SOC_DOUBLE_R("AGC Attack Time", LEFT_CHN_AGC_4, RIGHT_CHN_AGC_4,
			3, 0x1F, 0),
	SOC_DOUBLE_R("AGC Decay Time", LEFT_CHN_AGC_5, RIGHT_CHN_AGC_5,
			3, 0x1F, 0),
	SOC_DOUBLE_R("AGC Noise Debounce", LEFT_CHN_AGC_6, RIGHT_CHN_AGC_6,
			0, 0x1F, 0),
	SOC_DOUBLE_R("AGC Signal Debounce", LEFT_CHN_AGC_7, RIGHT_CHN_AGC_7,
			0, 0x0F, 0),

	/* MIC BIAS control */
	SOC_SINGLE("MIC BIAS", MICBIAS_CTRL, 6, 1, 0),
};

/* the sturcture contains the different values for mclk */
static const struct aic32x4_rate_divs aic32x4_divs[] = {
/*
 * mclk, rate, p_val, pll_j, pll_d, dosr, ndac, mdac, aosr, nadc, madc, blck_N,
 * codec_speficic_initializations
 */
	/* 8k rate */
	{12000000, 8000, 1, 7, 6800, 768, 5, 3, 128, 5, 18, 24,
	 {{60, 1}, {61, 1}}},
	{24000000, 8000, 2, 7, 6800, 768, 15, 1, 64, 45, 4, 24,
	 {{60, 1}, {61, 1}}},
	{25000000, 8000, 2, 7, 3728, 768, 15, 1, 64, 45, 4, 24,
	 {{60, 1}, {61, 1}}},
	/* 11.025k rate */
	{12000000, 11025, 1, 7, 5264, 512, 8, 2, 128, 8, 8, 16,
	 {{60, 1}, {61, 1}}},
	{24000000, 11025, 2, 7, 5264, 512, 16, 1, 64, 32, 4, 16,
	 {{60, 1}, {61, 1}}},
	/* 16k rate */
	{12000000, 16000, 1, 7, 6800, 384, 5, 3, 128, 5, 9, 12,
	 {{60, 1}, {61, 1}}},
	{24000000, 16000, 2, 7, 6800, 384, 15, 1, 64, 18, 5, 12,
	 {{60, 1}, {61, 1}}},
	{25000000, 16000, 2, 7, 3728, 384, 15, 1, 64, 18, 5, 12,
	 {{60, 1}, {61, 1}}},
	/* 22.05k rate */
	{12000000, 22050, 1, 7, 5264, 256, 4, 4, 128, 4, 8, 8,
	 {{60, 1}, {61, 1}}},
	{24000000, 22050, 2, 7, 5264, 256, 16, 1, 64, 16, 4, 8,
	 {{60, 1}, {61, 1}}},
	{25000000, 22050, 2, 7, 2253, 256, 16, 1, 64, 16, 4, 8,
	 {{60, 1}, {61, 1}}},
	/* 32k rate */
	{12000000, 32000, 1, 7, 1680, 192, 2, 7, 64, 2, 21, 6,
	 {{60, 1}, {61, 1}}},
	{24000000, 32000, 2, 7, 1680, 192, 7, 2, 64, 7, 6, 6,
	 {{60, 1}, {61, 1}}},
	/* 44.1k rate */
	{12000000, 44100, 1, 7, 5264, 128, 2, 8, 128, 2, 8, 4,
	 {{60, 1}, {61, 1}}},
	{24000000, 44100, 2, 7, 5264, 128, 8, 2, 64, 8, 4, 4,
	 {{60, 1}, {61, 1}}},
	{25000000, 44100, 2, 7, 2253, 128, 8, 2, 64, 8, 4, 4,
	 {{60, 1}, {61, 1}}},
	/* 48k rate */
	{12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4,
	 {{60, 1}, {61, 1}}},
	{24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4,
	 {{60, 1}, {61, 1}}},
	{25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4,
	 {{60, 1}, {61, 1}}},
	/*96k rate */
	{12000000, 96000, 1, 8, 1920, 64, 2, 8, 64, 2, 8, 2,
	 {{60, 7}, {61, 7}}},
	{24000000, 96000, 2, 8, 1920, 64, 4, 4, 64, 8, 2, 2,
	 {{60, 7}, {61, 7}}},
	/*192k */
	{12000000, 192000, 1, 8, 1920, 32, 2, 8, 32, 2, 8, 1,
	 {{60, 17}, {61, 13}}},
	{24000000, 192000, 2, 8, 1920, 32, 4, 4, 32, 4, 4, 1,
	 {{60, 17}, {61, 13}}},
};

/*
 *----------------------------------------------------------------------------
 * @struct  aic32x4_priv |
 *          AIC32X4 priviate data structure to set the system clock, mode and
 *          page number.
 * @field   u32 | sysclk |
 *          system clock
 * @field   s32 | master |
 *          master/slave mode setting for AIC32X4
 * @field   u8 | page_no |
 *          page number. Here, page 0 and page 1 are used.
 *----------------------------------------------------------------------------
 */
struct aic32x4_priv {
	u32 sysclk;
	s32 master;
	u8 page_no;
};

#define aic32x4_reset(c) aic32x4_write(c, AIC32X4_RESET, 0x01);


/*
 * aic32x4 initialization data
 * This structure initialization contains the initialization required for
 * AIC32X4.
 * These registers values (reg_val) are written into the respective AIC32X4
 * register offset (reg_offset) to  initialize AIC32X4.
 * These values are used in aic32x4_init() function only.
 */
static const struct aic32x4_configs aic32x4_reg_init[] = {
	/* Carry out the software reset */
	{AIC32X4_RESET, 0x01},
	/* Disable crude LDO */
	{POW_CFG, 0x08},
	/* Switch on the analog blocks */
	{LDO_CTL, 0x01},
	/* Do not connect IN1_L and IN1_R to CM (differential mode) */
	{INPUT_CFG_REG, 0x00},
	/* USE LDOIN range 1.8 - 3.6 V */
	{CM_MODE_CTL, 0x03},
	/* PLL is CODEC_CLKIN */
	{CLK_REG_1, PLLCLK_2_CODEC_CLKIN},
	/* DAC_MOD_CLK is BCLK source */
	{AIS_REG_3, DAC_MOD_CLK_2_BDIV_CLKIN},
	/* Setting up DAC Channel */
	{DAC_CHN_REG,
	 LDAC_2_LCHN | RDAC_2_RCHN | SOFT_STEP_2WCLK},
	/* Headphone powerup */
	{HPHONE_STARTUP_CTRL, 0x35},
	/* Left Channel DAC recons filter's positive terminal is routed to HPL */
	{HPL_ROUTE_CTL, LDAC_CHNL_2_HPL},
	/* Right Channel DAC recons filter's positive terminal is routed to HPR */
	{HPR_ROUTE_CTL, RDAC_CHNL_2_HPR},
	/* Left Channel DAC recons filter's positive terminal is routed to LOL */
	{LOL_ROUTE_CTL, LDAC_CHNL_2_HPL},
	/* Right Channel DAC recons filter's positive terminal is routed to LOR */
	{LOR_ROUTE_CTL, RDAC_CHNL_2_HPR},
	/* HPL unmute and gain 0db */
	{HPL_GAIN, 0x0},
	/* HPR unmute and gain 0db */
	{HPR_GAIN, 0x0},
	/* LOL unmute and gain 0db */
	{LOL_GAIN, 0x0},
	/* LOR unmute and gain 0db */
	{LOR_GAIN, 0x0},
	/* Unmute DAC Left and Right channels */
	{DAC_MUTE_CTRL_REG, 0x00},
	/* IN2_L is selected for left P */
	{LMICPGA_PIN_CFG, 0x10},
	/* IN2_R is selected for left M */
	{LMICPGA_NIN_CFG, 0x10},
	/* IN1_R is selected for right P */
	{RMICPGA_PIN_CFG, 0x40},
	/* IN1_L is selected for right M */
	{RMICPGA_NIN_CFG, 0x10},
	/* Left mic PGA unmuted */
	{LMICPGA_VOL_CTRL, 0x00},
	/* Right mic PGA unmuted */
	{RMICPGA_VOL_CTRL, 0x00},
	/* ADC volume control change by 2 gain step per ADC Word Clock */
	{ADC_REG_1, 0x02},
	/* Unmute ADC left and right channels */
	{ADC_FGA, 0x00},
	/* MICBIAS = 2.075V(CM=0.75V) generated from LDOIN */
	{MICBIAS_CTRL, 0x28},
	/* FIXME: these registers should be configured from user space using alsactl */
	{146, 0x0a},
	{147, 0x0a},
	{83, 0x28},
	{84, 0x28},
	{187, 0x20},
	{188, 0x20},
	{64, 0x10},
	{86, 0x80},
	{94, 0x80},
	{87, 0x3e},
	{95, 0x3e},
	{88, 0x32},
	{96, 0x32},
	{179, 0x68},
	{88, 0x14}
};

/* Left DAC_L Mixer */
static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
	SOC_DAPM_SINGLE("L_DAC switch", HPL_ROUTE_CTL, 3, 1, 0),
	SOC_DAPM_SINGLE("IN1_L switch", HPL_ROUTE_CTL, 2, 1, 0),
//	SOC_DAPM_SINGLE("Left_Bypass switch", HPL_ROUTE_CTL, 1, 1, 0),
};

/* Right DAC_R Mixer */
static const struct snd_kcontrol_new hpr_output_mixer_controls[] = {
	SOC_DAPM_SINGLE("R_DAC switch", HPR_ROUTE_CTL, 3, 1, 0),
	SOC_DAPM_SINGLE("IN1_R switch", HPR_ROUTE_CTL, 2, 1, 0),
//	SOC_DAPM_SINGLE("Right_Bypass switch", HPR_ROUTE_CTL, 1, 1, 0),
};

static const struct snd_kcontrol_new lol_output_mixer_controls[] = {
	SOC_DAPM_SINGLE("L_DAC switch", LOL_ROUTE_CTL, 3, 1, 0),
//	SOC_DAPM_SINGLE("Left_Bypass switch", HPL_ROUTE_CTL, 1, 1, 0),
};

static const struct snd_kcontrol_new lor_output_mixer_controls[] = {
	SOC_DAPM_SINGLE("R_DAC switch", LOR_ROUTE_CTL, 3, 1, 0),
//	SOC_DAPM_SINGLE("Right_Bypass switch", LOR_ROUTE_CTL, 1, 1, 0),
};

/* Right DAC_R Mixer */
static const struct snd_kcontrol_new left_input_mixer_controls[] = {
	SOC_DAPM_SINGLE("IN1_L switch", LMICPGA_PIN_CFG, 6, 1, 0),
	SOC_DAPM_SINGLE("IN2_L switch", LMICPGA_PIN_CFG, 4, 1, 0),
	SOC_DAPM_SINGLE("IN3_L switch", LMICPGA_PIN_CFG, 2, 1, 0),
};

static const struct snd_kcontrol_new right_input_mixer_controls[] = {
	SOC_DAPM_SINGLE("IN1_R switch", RMICPGA_PIN_CFG, 6, 1, 0),
	SOC_DAPM_SINGLE("IN2_R switch", RMICPGA_PIN_CFG, 4, 1, 0),
	SOC_DAPM_SINGLE("IN3_R switch", RMICPGA_PIN_CFG, 2, 1, 0),
};

static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
	/* Left DAC to Left Outputs */
	/* dapm widget (stream domain) for left DAC */
	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_CHN_REG, 7, 0),
	/* dapm widget (path domain) for left DAC_L Mixer */
	SND_SOC_DAPM_MIXER("HPL Output Mixer", SND_SOC_NOPM, 0, 0,
			   &hpl_output_mixer_controls[0],
			   ARRAY_SIZE(hpl_output_mixer_controls)),
	SND_SOC_DAPM_PGA("HPL Power", OUT_PWR_CTL, 5, 0, NULL, 0),

	SND_SOC_DAPM_MIXER("LOL Output Mixer", SND_SOC_NOPM, 0, 0,
			   &lol_output_mixer_controls[0],
			   ARRAY_SIZE(lol_output_mixer_controls)),
	SND_SOC_DAPM_PGA("LOL Power", OUT_PWR_CTL, 3, 0, NULL, 0),

	/* Right DAC to Right Outputs */
	/* dapm widget (stream domain) for right DAC */
	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", DAC_CHN_REG, 6, 0),
	/* dapm widget (path domain) for right DAC_R mixer */
	SND_SOC_DAPM_MIXER("HPR Output Mixer", SND_SOC_NOPM, 0, 0,
			   &hpr_output_mixer_controls[0],
			   ARRAY_SIZE(hpr_output_mixer_controls)),
	SND_SOC_DAPM_PGA("HPR Power", OUT_PWR_CTL, 4, 0, NULL, 0),

	SND_SOC_DAPM_MIXER("LOR Output Mixer", SND_SOC_NOPM, 0, 0,
			   &lor_output_mixer_controls[0],
			   ARRAY_SIZE(lor_output_mixer_controls)),
	SND_SOC_DAPM_PGA("LOR Power", OUT_PWR_CTL, 2, 0, NULL, 0),

	SND_SOC_DAPM_MIXER("Left Input Mixer", SND_SOC_NOPM, 0, 0,
			   &left_input_mixer_controls[0],
			   ARRAY_SIZE(left_input_mixer_controls)),

	SND_SOC_DAPM_MIXER("Right Input Mixer", SND_SOC_NOPM, 0, 0,
			   &right_input_mixer_controls[0],
			   ARRAY_SIZE(right_input_mixer_controls)),

	/* Left Inputs to Left ADC */
	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", ADC_REG_1, 7, 0),

	/* Right Inputs to Right ADC */
	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", ADC_REG_1, 6, 0),

	/* dapm widget (platform domain) name for HPLOUT */
	SND_SOC_DAPM_OUTPUT("HPL"),
	/* dapm widget (platform domain) name for HPROUT */
	SND_SOC_DAPM_OUTPUT("HPR"),
	/* dapm widget (platform domain) name for LOLOUT */
	SND_SOC_DAPM_OUTPUT("LOL"),
	/* dapm widget (platform domain) name for LOROUT */
	SND_SOC_DAPM_OUTPUT("LOR"),

	/* dapm widget (platform domain) name for LINE1L */
	SND_SOC_DAPM_INPUT("IN1_L"),
	/* dapm widget (platform domain) name for LINE1R */
	SND_SOC_DAPM_INPUT("IN1_R"),
	/* dapm widget (platform domain) name for LINE2L */
	SND_SOC_DAPM_INPUT("IN2_L"),
	/* dapm widget (platform domain) name for LINE2R */
	SND_SOC_DAPM_INPUT("IN2_R"),
	/* dapm widget (platform domain) name for LINE3L */
	SND_SOC_DAPM_INPUT("IN3_L"),
	/* dapm widget (platform domain) name for LINE3R */
	SND_SOC_DAPM_INPUT("IN3_R"),
};

static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
	/* ******** Left Output ******** */
	{"HPL Output Mixer", "L_DAC switch", "Left DAC"},
	{"HPL Output Mixer", "IN1_L switch", "IN1_L"},
	//{"HPL Output Mixer", "Left_Bypass switch", "Left_Bypass"},

	{"HPL Power", NULL, "HPL Output Mixer"},
	{"HPL", NULL, "HPL Power"},

	{"LOL Output Mixer", "L_DAC switch", "Left DAC"},
//	{"LOL Output Mixer", "Left_Bypass switch", "Left_Bypass"},

	{"LOL Power", NULL, "LOL Output Mixer"},
	{"LOL", NULL, "LOL Power"},

	/* ******** Right Output ******** */
	{"HPR Output Mixer", "R_DAC switch", "Right DAC"},
	{"HPR Output Mixer", "IN1_R switch", "IN1_R"},
	//{"HPR Output Mixer", "Right_Bypass switch", "Right_Bypass"},

	{"HPR Power", NULL, "HPR Output Mixer"},
	{"HPR", NULL, "HPR Power"},

	{"LOR Output Mixer", "R_DAC switch", "Right DAC"},
//	{"LOR Output Mixer", "Right_Bypass switch", "Right_Bypass"},

	{"LOR Power", NULL, "LOR Output Mixer"},
	{"LOR", NULL, "LOR Power"},

	/* ******** Left input ******** */
	{"Left Input Mixer", "IN1_L switch", "IN1_L"},
	{"Left Input Mixer", "IN2_L switch", "IN2_L"},
	{"Left Input Mixer", "IN3_L switch", "IN3_L"},

	//{"Left_Bypass", NULL, "Left Input Mixer"},

	{"Left ADC", NULL, "Left Input Mixer"},

	/* ******** Right Input ******** */
	{"Right Input Mixer", "IN1_R switch", "IN1_R"},
	{"Right Input Mixer", "IN2_R switch", "IN2_R"},
	{"Right Input Mixer", "IN3_R switch", "IN3_R"},

//	{"Right_Bypass", NULL, "Right Input Mixer"},

	{"Right ADC", NULL, "Right Input Mixer"},
};

/*
 *****************************************************************************
 * Function Definitions
 *****************************************************************************
 */
static void aic32x4_change_page(struct snd_soc_codec *codec, u8 new_page)
{
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);

	snd_soc_write(codec, AIC32X4_PSEL, new_page);
	aic32x4->page_no = new_page;
}

static void aic32x4_write(struct snd_soc_codec *codec, u16 reg, u8 val)
{
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
	u8 page = reg / 128;
	u8 fixed_reg = reg % 128;

	printk("%s: reg=%d, val=0x%02x\n", __func__, reg, val);

	/* A write to AIC32X4_PSEL is really a non-explicit page change */
	if (reg == AIC32X4_PSEL) {
		aic32x4_change_page(codec, val);
		return;
	}

	if (aic32x4->page_no != page) {
		aic32x4_change_page(codec, page);
	}

	snd_soc_write(codec, fixed_reg, val);
}

static u8 aic32x4_read(struct snd_soc_codec *codec, u16 reg)
{
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
	u8 page = reg / 128;
	u8 fixed_reg = reg % 128;

	if (aic32x4->page_no != page) {
		aic32x4_change_page(codec, page);
	}
	return snd_soc_read(codec, fixed_reg);
}

static int snd_soc_info_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
    struct snd_ctl_elem_info *uinfo)
{
    int mask = (kcontrol->private_value >> 12) & 0xff;

    uinfo->type =
        mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
    uinfo->count = 2;
    uinfo->value.integer.min = 0;
    uinfo->value.integer.max = mask;
    return 0;
}
/*
 *----------------------------------------------------------------------------
 * Function : snd_soc_get_volsw_2r_aic32x4
 * Purpose  : Callback to get the value of a double mixer control that spans
 *            two registers.
 *
 *----------------------------------------------------------------------------
 */
int snd_soc_get_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
				 struct snd_ctl_elem_value *ucontrol)
{
	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
	int reg = kcontrol->private_value & AIC32X4_8BITS_MASK;
	int reg2 = (kcontrol->private_value >> 24) & AIC32X4_8BITS_MASK;
	int mask;
	int shift;
	unsigned short val, val2;

	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
		mask = AIC32X4_8BITS_MASK;
		shift = 0;
	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain")) ||
		   (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
		mask = 0x3F;
		shift = 0;
	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
		mask = 0x7F;
		shift = 0;
	} else {
		printk("Invalid kcontrol name\n");
		return -1;
	}

	val = (snd_soc_read(codec, reg) >> shift) & mask;
	val2 = (snd_soc_read(codec, reg2) >> shift) & mask;

	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
		ucontrol->value.integer.value[0] =
		    (val <= 48) ? (val + 127) : (val - 129);
		ucontrol->value.integer.value[1] =
		    (val2 <= 48) ? (val2 + 127) : (val2 - 129);
	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain"))
		   || (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
		ucontrol->value.integer.value[0] =
		    (val <= 29) ? (val + 6) : (val - 58);
		ucontrol->value.integer.value[1] =
		    (val2 <= 29) ? (val2 + 6) : (val2 - 58);
	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
		ucontrol->value.integer.value[0] =
		    (val <= 38) ? (val + 25) : (val - 103);
		ucontrol->value.integer.value[1] =
		    (val2 <= 38) ? (val2 + 25) : (val2 - 103);
	}
	return 0;
}

/*
 *----------------------------------------------------------------------------
 * Function : snd_soc_put_volsw_2r_aic32x4
 * Purpose  : Callback to set the value of a double mixer control that spans
 *            two registers.
 *
 *----------------------------------------------------------------------------
 */
int snd_soc_put_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
				 struct snd_ctl_elem_value *ucontrol)
{
	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
	int reg = kcontrol->private_value & AIC32X4_8BITS_MASK;
	int reg2 = (kcontrol->private_value >> 24) & AIC32X4_8BITS_MASK;
	int err;
	unsigned short val, val2, val_mask;

	val = ucontrol->value.integer.value[0];
	val2 = ucontrol->value.integer.value[1];

	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
		val = (val >= 127) ? (val - 127) : (val + 129);
		val2 = (val2 >= 127) ? (val2 - 127) : (val2 + 129);
		val_mask = AIC32X4_8BITS_MASK;	/* 8 bits */
	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain")) ||
		   (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
		val = (val >= 6) ? (val - 6) : (val + 58);
		val2 = (val2 >= 6) ? (val2 - 6) : (val2 + 58);
		val_mask = 0x3F;	/* 6 bits */
	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
		val = (val >= 25) ? (val - 25) : (val + 103);
		val2 = (val2 >= 25) ? (val2 - 25) : (val2 + 103);
		val_mask = 0x7F;	/* 7 bits */
	} else {
		printk("Invalid control name\n");
		return -1;
	}

	if ((err = snd_soc_update_bits(codec, reg, val_mask, val)) < 0) {
		printk("Error while updating bits\n");
		return err;
	}

	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
	return err;
}

/*
 *----------------------------------------------------------------------------
 * Function : aic32x4_get_divs
 * Purpose  : This function is to get required divisor from the "aic32x4_divs"
 *            table.
 *
 *----------------------------------------------------------------------------
 */
static inline int aic32x4_get_divs(int mclk, int rate)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(aic32x4_divs); i++) {
		if ((aic32x4_divs[i].rate == rate)
		    && (aic32x4_divs[i].mclk == mclk)) {
			return i;
		}
	}
	printk("Master clock and sample rate is not supported\n");
	return -EINVAL;
}

static int aic32x4_add_widgets(struct snd_soc_codec *codec)
{
	snd_soc_dapm_new_controls(codec, aic32x4_dapm_widgets,
				ARRAY_SIZE(aic32x4_dapm_widgets));

	snd_soc_dapm_add_routes(codec, aic32x4_dapm_routes,
				ARRAY_SIZE(aic32x4_dapm_routes));

	snd_soc_dapm_new_widgets(codec);
	return 0;
}

static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
				  int clk_id, unsigned int freq, int dir)
{
	struct snd_soc_codec *codec = codec_dai->codec;
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
printk("%s\n", __func__);
	switch (freq) {
	case AIC32X4_FREQ_12000000:
	case AIC32X4_FREQ_24000000:
	case AIC32X4_FREQ_25000000:
		aic32x4->sysclk = freq;
		return 0;
	}
	printk("Invalid frequency to set DAI system clock\n");
	return -EINVAL;
}

static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
{
	struct snd_soc_codec *codec = codec_dai->codec;
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
	u8 iface_reg;
printk("%s\n", __func__);
	iface_reg = aic32x4_read(codec, INTERFACE_SET_REG_1);
	iface_reg = iface_reg & ~(3 << 6 | 3 << 2);

	/* set master/slave audio interface */
	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
	case SND_SOC_DAIFMT_CBM_CFM:
		aic32x4->master = 1;
		iface_reg |= BIT_CLK_MASTER | WORD_CLK_MASTER;
		break;
	case SND_SOC_DAIFMT_CBS_CFS:
		aic32x4->master = 0;
		break;
	default:
		printk("Invalid DAI master/slave interface\n");
		return -EINVAL;
	}

	/* interface format */
	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
	case SND_SOC_DAIFMT_I2S:
		break;
	case SND_SOC_DAIFMT_DSP_A:
		iface_reg |= (AIC32X4_DSP_MODE << CLK_REG_3_SHIFT);
		break;
	case SND_SOC_DAIFMT_RIGHT_J:
		iface_reg |= (AIC32X4_RIGHT_JUSTIFIED_MODE << CLK_REG_3_SHIFT);
		break;
	case SND_SOC_DAIFMT_LEFT_J:
		iface_reg |= (AIC32X4_LEFT_JUSTIFIED_MODE << CLK_REG_3_SHIFT);
		break;
	default:
		printk("Invalid DAI interface format\n");
		return -EINVAL;
	}

	aic32x4_write(codec, INTERFACE_SET_REG_1, iface_reg);
	return 0;
}

static int aic32x4_hw_params(struct snd_pcm_substream *substream,
			     struct snd_pcm_hw_params *params,
			     struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
	int i, j;
	u8 data;
printk("%s\n", __func__);

	i = aic32x4_get_divs(aic32x4->sysclk, params_rate(params));

	if (i < 0) {
		printk("sampling rate not supported\n");
		return i;
	}

	/* We will fix R value to 1 and will make P & J=K.D as varialble */

	/* Setting P & R values */
	aic32x4_write(codec, CLK_REG_2,
		      ((aic32x4_divs[i].p_val << 4) | 0x01));

	/* J value */
	aic32x4_write(codec, CLK_REG_3, aic32x4_divs[i].pll_j);

	/* MSB & LSB for D value */
	aic32x4_write(codec, CLK_REG_4, (aic32x4_divs[i].pll_d >> 8));
	aic32x4_write(codec, CLK_REG_5,
		      (aic32x4_divs[i].pll_d & AIC32X4_8BITS_MASK));

	/* NDAC divider value */
	aic32x4_write(codec, NDAC_CLK_REG_6, aic32x4_divs[i].ndac);

	/* MDAC divider value */
	aic32x4_write(codec, MDAC_CLK_REG_7, aic32x4_divs[i].mdac);

	/* DOSR MSB & LSB values */
	aic32x4_write(codec, DAC_OSR_MSB, aic32x4_divs[i].dosr >> 8);
	aic32x4_write(codec, DAC_OSR_LSB,
		      (aic32x4_divs[i].dosr & AIC32X4_8BITS_MASK));

	/* NADC divider value */
	aic32x4_write(codec, NADC_CLK_REG_8, aic32x4_divs[i].nadc);

	/* MADC divider value */
	aic32x4_write(codec, MADC_CLK_REG_9, aic32x4_divs[i].madc);

	/* AOSR value */
	aic32x4_write(codec, ADC_OSR_REG, aic32x4_divs[i].aosr);

	/* BCLK N divider */
	aic32x4_write(codec, CLK_REG_11, aic32x4_divs[i].blck_N);

	data = aic32x4_read(codec, INTERFACE_SET_REG_1);
	data = data & ~(3 << 4);
	switch (params_format(params)) {
	case SNDRV_PCM_FORMAT_S16_LE:
		break;
	case SNDRV_PCM_FORMAT_S20_3LE:
		data |= (AIC32X4_WORD_LEN_20BITS << DAC_OSR_MSB_SHIFT);
		break;
	case SNDRV_PCM_FORMAT_S24_LE:
		data |= (AIC32X4_WORD_LEN_24BITS << DAC_OSR_MSB_SHIFT);
		break;
	case SNDRV_PCM_FORMAT_S32_LE:
		data |= (AIC32X4_WORD_LEN_32BITS << DAC_OSR_MSB_SHIFT);
		break;
	}
	aic32x4_write(codec, INTERFACE_SET_REG_1, data);

	for (j = 0; j < NO_FEATURE_REGS; j++) {
		aic32x4_write(codec,
			      aic32x4_divs[i].codec_specific_regs[j].reg_offset,
			      aic32x4_divs[i].codec_specific_regs[j].reg_val);
	}
	return 0;
}

static int aic32x4_mute(struct snd_soc_dai *dai, int mute)
{
	struct snd_soc_codec *codec = dai->codec;
	u8 dac_reg;
printk("%s\n", __func__);
	dac_reg = aic32x4_read(codec, DAC_MUTE_CTRL_REG) & ~MUTE_ON;
	if (mute) {
		aic32x4_write(codec, DAC_MUTE_CTRL_REG, dac_reg | MUTE_ON);
	} else {
		aic32x4_write(codec, DAC_MUTE_CTRL_REG, dac_reg);
	}
	return 0;
}

static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
				  enum snd_soc_bias_level level)
{
	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
	u8 value;
	char *dbgmap[] = {"SND_SOC_BIAS_OFF", "SND_SOC_BIAS_STANDBY",
"SND_SOC_BIAS_PREPARE", "SND_SOC_BIAS_ON"};

printk("%s: %s\n", __func__, dbgmap[level]);
	switch (level) {
		/* full On */
	case SND_SOC_BIAS_ON:
		/* all power is driven by DAPM system */
		if (aic32x4->master) {
			/* Switch on PLL */
			value = aic32x4_read(codec, CLK_REG_2);
			aic32x4_write(codec, CLK_REG_2, (value | ENABLE_PLL));

			/* Switch on NDAC Divider */
			value = aic32x4_read(codec, NDAC_CLK_REG_6);
			aic32x4_write(codec, NDAC_CLK_REG_6,
				      value | ENABLE_NDAC);

			/* Switch on MDAC Divider */
			value = aic32x4_read(codec, MDAC_CLK_REG_7);
			aic32x4_write(codec, MDAC_CLK_REG_7,
				      value | ENABLE_MDAC);

			/* Switch on NADC Divider */
			value = aic32x4_read(codec, NADC_CLK_REG_8);
			aic32x4_write(codec, NADC_CLK_REG_8,
				      value | ENABLE_MDAC);

			/* Switch on MADC Divider */
			value = aic32x4_read(codec, MADC_CLK_REG_9);
			aic32x4_write(codec, MADC_CLK_REG_9,
				      value | ENABLE_MDAC);

			/* Switch on BCLK_N Divider */
			value = aic32x4_read(codec, CLK_REG_11);
			aic32x4_write(codec, CLK_REG_11, value | ENABLE_BCLK);
		}
		break;

		/* partial On */
	case SND_SOC_BIAS_PREPARE:
		break;

		/* Off, with power */
	case SND_SOC_BIAS_STANDBY:
		/*
		 * all power is driven by DAPM system,
		 * so output power is safe if bypass was set
		 */;
		if (aic32x4->master) {
			/* Switch off PLL */
			value = aic32x4_read(codec, CLK_REG_2);
			aic32x4_write(codec, CLK_REG_2, (value & ~ENABLE_PLL));

			/* Switch off NDAC Divider */
			value = aic32x4_read(codec, NDAC_CLK_REG_6);
			aic32x4_write(codec, NDAC_CLK_REG_6,
				      value & ~ENABLE_NDAC);

			/* Switch off MDAC Divider */
			value = aic32x4_read(codec, MDAC_CLK_REG_7);
			aic32x4_write(codec, MDAC_CLK_REG_7,
				      value & ~ENABLE_MDAC);

			/* Switch off NADC Divider */
			value = aic32x4_read(codec, NADC_CLK_REG_8);
			aic32x4_write(codec, NADC_CLK_REG_8,
				      value & ~ENABLE_NDAC);

			/* Switch off MADC Divider */
			value = aic32x4_read(codec, MADC_CLK_REG_9);
			aic32x4_write(codec, MADC_CLK_REG_9,
				      value & ~ENABLE_MDAC);
			value = aic32x4_read(codec, CLK_REG_11);

			/* Switch off BCLK_N Divider */
			aic32x4_write(codec, CLK_REG_11, value & ~ENABLE_BCLK);
		}
		break;

		/* Off, without power */
	case SND_SOC_BIAS_OFF:
		/* TODO: implement a real shutdown and use a cache for registers */
		break;
	}
	codec->bias_level = level;
	return 0;
}

#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_192000
#define AIC32X4_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

static struct snd_soc_dai_ops aic32x4_ops = {
	.hw_params = aic32x4_hw_params,
	.digital_mute = aic32x4_mute,
	.set_fmt = aic32x4_set_dai_fmt,
	.set_sysclk = aic32x4_set_dai_sysclk,
};

static struct snd_soc_dai_driver aic32x4_dai = {
	.name = "tlv320aic32x4-hifi",
	.playback = {
		     .stream_name = "Playback",
		     .channels_min = 1,
		     .channels_max = 2,
		     .rates = AIC32X4_RATES,
		     .formats = AIC32X4_FORMATS,},
	.capture = {
		    .stream_name = "Capture",
		    .channels_min = 1,
		    .channels_max = 2,
		    .rates = AIC32X4_RATES,
		    .formats = AIC32X4_FORMATS,},
	.ops = &aic32x4_ops,
	.symmetric_rates = 1,
};

static int aic32x4_suspend(struct snd_soc_codec *codec, pm_message_t state)
{
printk("%s\n", __func__);
	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);

	return 0;
}

static int aic32x4_resume(struct snd_soc_codec *codec)
{
printk("%s\n", __func__);
	/*
	 * TODO: Since SND_SOC_BIAS_OFF is not effective there's no need to
	 * sync with a cache here.
	 */
	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

	return 0;
}

static int aic32x4_probe(struct snd_soc_codec *codec)
{
	int ret, i;
printk("%s\n", __func__);
	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
	if (ret < 0) {
		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
		return ret;
	}

// 	aic32x4_reset(codec);

	/* TODO: initial configuration of registers -> remove since this is
machine specific */
	for (i=0; i<ARRAY_SIZE(aic32x4_reg_init); i++)
		aic32x4_write(codec, aic32x4_reg_init[i].reg_offset,
aic32x4_reg_init[i].reg_val);
	
	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
	snd_soc_add_controls(codec, aic32x4_snd_controls,
			     ARRAY_SIZE(aic32x4_snd_controls));
	aic32x4_add_widgets(codec);

	return 0;
}


static int aic32x4_remove(struct snd_soc_codec *codec)
{
	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
	return 0;
}

static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
	.probe = aic32x4_probe,
	.remove = aic32x4_remove,
	.suspend = aic32x4_suspend,
	.resume = aic32x4_resume,
	.set_bias_level = aic32x4_set_bias_level,
};

#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
				      const struct i2c_device_id *id)
{
	struct aic32x4_priv *aic32x4;
	int ret;

	aic32x4 = kzalloc(sizeof(struct aic32x4_priv), GFP_KERNEL);
	if (aic32x4 == NULL)
		return -ENOMEM;

	i2c_set_clientdata(i2c, aic32x4);

	ret = snd_soc_register_codec(&i2c->dev,
			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
	if (ret < 0)
		kfree(aic32x4);
	return ret;
}

static __devexit int aic32x4_i2c_remove(struct i2c_client *client)
{
	snd_soc_unregister_codec(&client->dev);
	kfree(i2c_get_clientdata(client));
	return 0;
}

/* TODO: two possible models: tlv320aic3254/tlv320aic3204 (see other
tlv drivers) */
static const struct i2c_device_id aic32x4_i2c_id[] = {
	{ "tlv320aic32x4", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);

static struct i2c_driver aic32x4_i2c_driver = {
	.driver = {
		.name = "tlv320aic32x4-codec",
		.owner = THIS_MODULE,
	},
	.probe =    aic32x4_i2c_probe,
	.remove =   __devexit_p(aic32x4_i2c_remove),
	.id_table = aic32x4_i2c_id,
};
#endif

static int __init aic32x4_modinit(void)
{
	int ret = 0;
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
	ret = i2c_add_driver(&aic32x4_i2c_driver);
	if (ret != 0) {
		printk(KERN_ERR "Failed to register aic32x4 I2C driver: %d\n",
		       ret);
	}
#endif
	return ret;
}
module_init(aic32x4_modinit);

static void __exit aic32x4_exit(void)
{
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
	i2c_del_driver(&aic32x4_i2c_driver);
#endif
}
module_exit(aic32x4_exit);

MODULE_DESCRIPTION("ASoC tlv320aic32x4 codec driver");
MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
MODULE_LICENSE("GPL");


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
