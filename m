From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Fri, 30 Sep 2011 23:04:52 +0530
Message-ID: <1317404092.1573.1818.camel@vkoul-udesk3>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 0473D1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 19:40:56 +0200 (CEST)
In-Reply-To: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: heelrod@heelrod.ad.cirrus.com
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-30 at 11:41 -0500, Brian Austin wrote:
> This patch adds support for the Cirrus Logic CS42L73
> low power stereo codec.
> 
> This patch has cleared checkpatch.pl with no warnings or errors.
> Code changes requested were implemented.
> ASoC API changes requested were implemented.
Stuff like version changes can be below SoB
> 
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> ---
>  sound/soc/codecs/Kconfig   |    4 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/cs42l73.c | 1047 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs42l73.h |  223 ++++++++++
>  4 files changed, 1276 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/cs42l73.c
>  create mode 100644 sound/soc/codecs/cs42l73.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 3449431..9107c48 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -28,6 +28,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_ALC5623 if I2C
>  	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
>  	select SND_SOC_CS42L51 if I2C
> +	select SND_SOC_CS42L73 if I2C
>  	select SND_SOC_CS4270 if I2C
>  	select SND_SOC_CS4271 if SND_SOC_I2C_AND_SPI
>  	select SND_SOC_CX20442
> @@ -175,6 +176,9 @@ config SND_SOC_CQ0093VC
>  config SND_SOC_CS42L51
>  	tristate
>  
> +config SND_SOC_CS42L73
> +	tristate
> +
>  # Cirrus Logic CS4270 Codec
>  config SND_SOC_CS4270
>  	tristate
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 787881b..e89e84b 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -15,6 +15,7 @@ snd-soc-ak4642-objs := ak4642.o
>  snd-soc-ak4671-objs := ak4671.o
>  snd-soc-cq93vc-objs := cq93vc.o
>  snd-soc-cs42l51-objs := cs42l51.o
> +snd-soc-cs42l73-objs := cs42l73.o
>  snd-soc-cs4270-objs := cs4270.o
>  snd-soc-cs4271-objs := cs4271.o
>  snd-soc-cx20442-objs := cx20442.o
> @@ -115,6 +116,7 @@ obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
>  obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
>  obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
>  obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
> +obj-$(CONFIG_SND_SOC_CS42L73)	+= snd-soc-cs42l73.o
>  obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
>  obj-$(CONFIG_SND_SOC_CS4271)	+= snd-soc-cs4271.o
>  obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
> diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
> new file mode 100644
> index 0000000..18a49d8
> --- /dev/null
> +++ b/sound/soc/codecs/cs42l73.c
> @@ -0,0 +1,1047 @@
> +/*
> + * cs42l73.c  --  CS42L73 ALSA Soc Audio driver
> + *
> + * Copyright 2011 Cirrus Logic, Inc.
> + *
> + * Authors: Georgi Vlaev, Nucleus Systems Ltd, <office@nucleusys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>
> +#include <linux/gpio.h>
gpio should be before sound, would make sense to sort this
> +
> +#include "cs42l73.h"
no need to empty line before this
> +
> +struct sp_config {
> +	u8 spc, mmcc, spfs;
> +	u32 srate;
> +};
> +
> +struct  cs42l73_private {
> +	enum snd_soc_control_type control_type;
> +	void *control_data;
> +	u32 sysclk;
> +	u8 mclksel;
> +	u32 mclk;
> +	struct sp_config config[3];
> +};
> +
> +static const u8 cs42l73_reg[] = {
> +/* 0*/ 0x00, 0x42, 0xA7, 0x30,
> +/* 4*/ 0x00, 0x00, 0xF1, 0xDF,
> +/* 8*/ 0x3F, 0x57, 0x53, 0x00,
> +/* C*/ 0x00, 0x15, 0x00, 0x15,
> +/*10*/ 0x00, 0x15, 0x00, 0x06,
/* abc */ pls
> +/*14*/ 0x00, 0x00, 0x00, 0x00,
> +/*18*/ 0x00, 0x00, 0x00, 0x00,
> +/*1C*/ 0x00, 0x00, 0x00, 0x00,
> +/*20*/ 0x00, 0x00, 0x00, 0x00,
> +/*24*/ 0x00, 0x00, 0x00, 0x7F,
> +/*28*/ 0x00, 0x00, 0x3F, 0x00,
> +/*2C*/ 0x00, 0x3F, 0x00, 0x00,
> +/*30*/ 0x3F, 0x00, 0x00, 0x00,
> +/*34*/ 0x18, 0x3F, 0x3F, 0x3F,
> +/*38*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*3C*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*40*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*44*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*48*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*4C*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*50*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*54*/ 0x3F, 0xAA, 0x3F, 0x3F,
> +/*58*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*5C*/ 0x3F, 0x3F, 0x00, 0x00,
> +/*60*/ 0x00, 0x00
> +};
> +
> +static const unsigned int hpaloa_tlv[] = {
> +	TLV_DB_RANGE_HEAD(2),
> +	0, 13, TLV_DB_SCALE_ITEM(-7600, 200, 0),
> +	14, 75, TLV_DB_SCALE_ITEM(-4900, 100, 0),
> +};
> +
> +static DECLARE_TLV_DB_SCALE(hl_tlv, -10200, 50, 0);
> +
> +static DECLARE_TLV_DB_SCALE(ipd_tlv, -9600, 100, 0);
> +
> +static DECLARE_TLV_DB_SCALE(micpga_tlv, -600, 50, 0);
> +
> +static const unsigned int limiter_tlv[] = {
> +	TLV_DB_RANGE_HEAD(2),
> +	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
> +	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0),
> +};
> +
> +static const DECLARE_TLV_DB_SCALE(attn_tlv, -6300, 100, 1);
> +
> +static const char * const s42l73_pgaa_text[] = { "Line A", "Mic 1" };
> +static const char * const cs42l73_pgab_text[] = { "Line B", "Mic 2" };
> +
> +static const struct soc_enum pgaa_enum =
> +	SOC_ENUM_SINGLE(CS42L73_ADCIPC, 3,
> +		ARRAY_SIZE(cs42l73_pgaa_text), cs42l73_pgaa_text);
> +
> +static const struct soc_enum pgab_enum =
> +	SOC_ENUM_SINGLE(CS42L73_ADCIPC, 7,
> +		ARRAY_SIZE(cs42l73_pgab_text), cs42l73_pgab_text);
> +
> +static const struct snd_kcontrol_new pgaa_mux =
> +	SOC_DAPM_ENUM("Left Analog Input Capture Mux", pgaa_enum);
> +
> +static const struct snd_kcontrol_new pgab_mux =
> +	SOC_DAPM_ENUM("Right Analog Input Capture Mux", pgab_enum);
> +
> +static const char * const cs42l73_ng_delay_text[] = {
> +	"50ms", "100ms", "150ms", "200ms" };
> +
> +static const struct soc_enum ng_delay_enum =
> +	SOC_ENUM_SINGLE(CS42L73_NGCAB, 0,
> +		ARRAY_SIZE(cs42l73_ng_delay_text), cs42l73_ng_delay_text);
> +
> +static const char * const cs42l73_mono_mixer_text[] = {
> +	"Left", "Right", "Mono Mix"};
> +
> +static const struct soc_enum spk_asp_mono_mixer_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 6,
> +		ARRAY_SIZE(cs42l73_mono_mixer_text), cs42l73_mono_mixer_text);
> +
> +static const struct soc_enum spk_xsp_mono_mixer_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 4,
> +		ARRAY_SIZE(cs42l73_mono_mixer_text), cs42l73_mono_mixer_text);
> +
> +static const struct soc_enum esl_asp_mono_mixer_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 2,
> +		ARRAY_SIZE(cs42l73_mono_mixer_text), cs42l73_mono_mixer_text);
> +
> +static const struct soc_enum esl_xsp_mono_mixer_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 0,
> +		ARRAY_SIZE(cs42l73_mono_mixer_text), cs42l73_mono_mixer_text);
> +
> +static const char * const cs42l73_ip_swap_text[] = {
> +	"Stereo", "Mono A", "Mono B", "Swap A-B"};
> +
> +static const struct soc_enum ip_swap_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MIOPC, 6,
> +		ARRAY_SIZE(cs42l73_ip_swap_text), cs42l73_ip_swap_text);
> +
> +static const char * const cs42l73_spo_mixer_text[] = {"Mono", "Stereo"};
> +
> +static const struct soc_enum vspout_mixer_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MIXERCTL, 5,
> +		ARRAY_SIZE(cs42l73_spo_mixer_text), cs42l73_spo_mixer_text);
> +
> +static const struct soc_enum xspout_mixer_enum =
> +	SOC_ENUM_SINGLE(CS42L73_MIXERCTL, 4,
> +		ARRAY_SIZE(cs42l73_spo_mixer_text), cs42l73_spo_mixer_text);
> +
> +static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
> +	SOC_DOUBLE_R_SX_TLV("Headphone Analog Playback Volume", CS42L73_HPAAVOL,
> +			CS42L73_HPBAVOL, 7, 0xffffffC1, 0x0C, hpaloa_tlv),
> +
> +	SOC_DOUBLE_R_SX_TLV("LineOut Analog Playback Volume", CS42L73_LOAAVOL,
> +			CS42L73_LOBAVOL, 7, 0xffffffC1, 0x0C, hpaloa_tlv),
> +
> +	SOC_DOUBLE_R_SX_TLV("Input PGA Analog Volume", CS42L73_MICAPREPGAAVOL,
> +			CS42L73_MICBPREPGABVOL, 5, 0xffffff35,
> +			0x34, micpga_tlv),
> +
> +	SOC_DOUBLE_R("MIC Preamp Switch", CS42L73_MICAPREPGAAVOL,
> +			CS42L73_MICBPREPGABVOL, 6, 1, 1),
> +
> +	SOC_DOUBLE_R_SX_TLV("Input Path Digital Volume", CS42L73_IPADVOL,
> +			CS42L73_IPBDVOL, 7, 0xffffffA0, 0xA0, ipd_tlv),
> +
> +	SOC_DOUBLE_R_SX_TLV("HL Digital Playback Volume",
> +			CS42L73_HLADVOL, CS42L73_HLBDVOL, 7, 0xffffffE5,
> +			0xE4, hl_tlv),
> +
> +	SOC_DOUBLE_S8_TLV("Speakerphone Digital Playback Volume",
> +			CS42L73_SPKDVOL, 0x34, 0xE4, hl_tlv),
> +
> +	SOC_DOUBLE_S8_TLV("Ear Speaker Digital Playback Volume",
> +			CS42L73_ESLDVOL, 0x34, 0xE4, hl_tlv),
> +
> +	SOC_DOUBLE_R("Headphone Analog Playback Switch", CS42L73_HPAAVOL,
> +			CS42L73_HPBAVOL, 7, 1, 1),
> +
> +	SOC_DOUBLE_R("LineOut Analog Playback Switch", CS42L73_LOAAVOL,
> +			CS42L73_LOBAVOL, 7, 1, 1),
> +	SOC_DOUBLE("Input Path Digital Switch", CS42L73_ADCIPC, 0, 4, 1, 1),
> +	SOC_DOUBLE("HL Digital Playback Switch", CS42L73_PBDC, 0,
> +			1, 1, 1),
> +	SOC_SINGLE("Speakerphone Digital Playback Switch", CS42L73_PBDC, 2, 1,
> +			1),
> +	SOC_SINGLE("Ear Speaker Digital Playback Switch", CS42L73_PBDC, 3, 1,
> +			1),
> +
> +	SOC_SINGLE("PGA Soft-Ramp Switch", CS42L73_MIOPC, 3, 1, 0),
> +	SOC_SINGLE("Analog Zero Cross Switch", CS42L73_MIOPC, 2, 1, 0),
> +	SOC_SINGLE("Digital Soft-Ramp Switch", CS42L73_MIOPC, 1, 1, 0),
> +	SOC_SINGLE("Analog Output Soft-Ramp Switch", CS42L73_MIOPC, 0, 1, 0),
> +
> +	SOC_DOUBLE("Invert ADC Signal Polarity Switch", CS42L73_ADCIPC, 1, 5, 1,
> +			0),
> +	SOC_DOUBLE("ADC Boost Switch", CS42L73_ADCIPC, 2, 6, 1, 0),
> +
> +	SOC_SINGLE("Charge Pump Frequency Volume", CS42L73_CPFCHC, 4, 15, 0),
> +
> +	SOC_SINGLE("HL Limiter Attack Rate Volume", CS42L73_LIMARATEHL, 0, 0x3F,
> +			0),
> +	SOC_SINGLE("HL Limiter Release Rate Volume", CS42L73_LIMRRATEHL, 0,
> +			0x3F, 0),
> +	SOC_SINGLE("HL Limiter Switch", CS42L73_LIMRRATEHL, 7, 1, 0),
> +	SOC_SINGLE("HL Limiter All Channels Switch", CS42L73_LIMRRATEHL, 6, 1,
> +			0),
> +
> +	SOC_SINGLE_TLV("HL Limiter Max Threshold Volume", CS42L73_LMAXHL, 5, 7,
> +			1, limiter_tlv),
> +
> +	SOC_SINGLE_TLV("HL Limiter Cushion Volume", CS42L73_LMAXHL, 2, 7, 1,
> +			limiter_tlv),
> +
> +	SOC_SINGLE("SPK Limiter Attack Rate Volume", CS42L73_LIMARATESPK, 0,
> +			0x3F, 0),
> +	SOC_SINGLE("SPK Limiter Release Rate Volume", CS42L73_LIMRRATESPK, 0,
> +			0x3F, 0),
> +	SOC_SINGLE("SPK Limiter Switch", CS42L73_LIMRRATESPK, 7, 1, 0),
> +	SOC_SINGLE("SPK Limiter All Channels Switch", CS42L73_LIMRRATESPK, 6, 1,
> +			0),
> +	SOC_SINGLE_TLV("SPK Limiter Max Threshold Volume", CS42L73_LMAXSPK, 5,
> +			7, 1, limiter_tlv),
> +
> +	SOC_SINGLE_TLV("SPK Limiter Cushion Volume", CS42L73_LMAXSPK, 2, 7, 1,
> +			limiter_tlv),
> +
> +	SOC_SINGLE("ESL Limiter Attack Rate Volume", CS42L73_LIMARATEESL, 0,
> +			0x3F, 0),
> +	SOC_SINGLE("ESL Limiter Release Rate Volume", CS42L73_LIMRRATEESL, 0,
> +			0x3F, 0),
> +	SOC_SINGLE("ESL Limiter Switch", CS42L73_LIMRRATEESL, 7, 1, 0),
> +	SOC_SINGLE_TLV("ESL Limiter Max Threshold Volume", CS42L73_LMAXESL, 5,
> +			7, 1, limiter_tlv),
> +
> +	SOC_SINGLE_TLV("ESL Limiter Cushion Volume", CS42L73_LMAXESL, 2, 7, 1,
> +			limiter_tlv),
> +
> +	SOC_SINGLE("ALC Attack Rate Volume", CS42L73_ALCARATE, 0, 0x3F, 0),
> +	SOC_SINGLE("ALC Release Rate Volume", CS42L73_ALCRRATE, 0, 0x3F, 0),
> +	SOC_DOUBLE("ALC Switch", CS42L73_ALCARATE, 6, 7, 1, 0),
> +	SOC_SINGLE_TLV("ALC Max Threshold Volume", CS42L73_ALCMINMAX, 5, 7, 1,
> +			limiter_tlv),
> +	SOC_SINGLE_TLV("ALC Min Threshold Volume", CS42L73_ALCMINMAX, 2, 7, 1,
> +			limiter_tlv),
> +
> +	SOC_DOUBLE("NG Enable Switch", CS42L73_NGCAB, 6, 7, 1, 0),
> +	SOC_SINGLE("NG Boost Switch", CS42L73_NGCAB, 5, 1, 0),
> +	/*
> +	    NG Threshold depends on NG_BOOTSAB, which selects
> +	    between two threshold scales in decibels.
> +	    Set linear values for now ..
> +	*/
> +	SOC_SINGLE("NG Threshold", CS42L73_NGCAB, 2, 7, 0),
> +	SOC_ENUM("NG Delay", ng_delay_enum),
> +
> +	SOC_DOUBLE_R_TLV("XSP-IP Attenuation Volume",
> +			CS42L73_XSPAIPAA, CS42L73_XSPBIPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("XSP-XSP Attenuation Volume",
> +			CS42L73_XSPAXSPAA, CS42L73_XSPBXSPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("XSP-ASP Attenuation Volume",
> +			CS42L73_XSPAASPAA, CS42L73_XSPAASPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("XSP-VSP Attenuation Volume",
> +			CS42L73_XSPAVSPMA, CS42L73_XSPBVSPMA, 0, 0x3F, 1,
> +			attn_tlv),
> +
> +	SOC_DOUBLE_R_TLV("ASP-IP Attenuation Volume",
> +			CS42L73_ASPAIPAA, CS42L73_ASPBIPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("ASP-XSP Attenuation Volume",
> +			CS42L73_ASPAXSPAA, CS42L73_ASPBXSPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("ASP-ASP Attenuation Volume",
> +			CS42L73_ASPAASPAA, CS42L73_ASPBASPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("ASP-VSP Attenuation Volume",
> +			CS42L73_ASPAVSPMA, CS42L73_ASPBVSPMA, 0, 0x3F, 1,
> +			attn_tlv),
> +
> +	SOC_DOUBLE_R_TLV("VSP-IP Attenuation Volume",
> +			CS42L73_VSPAIPAA, CS42L73_VSPBIPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("VSP-XSP Attenuation Volume",
> +			CS42L73_VSPAXSPAA, CS42L73_VSPBXSPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("VSP-ASP Attenuation Volume",
> +			CS42L73_VSPAASPAA, CS42L73_VSPBASPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("VSP-VSP Attenuation Volume",
> +			CS42L73_VSPAVSPMA, CS42L73_VSPBVSPMA, 0, 0x3F, 1,
> +			attn_tlv),
> +
> +	SOC_DOUBLE_R_TLV("HL-IP Attenuation Volume",
> +			CS42L73_HLAIPAA, CS42L73_HLBIPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("HL-XSP Attenuation Volume",
> +			CS42L73_HLAXSPAA, CS42L73_HLBXSPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("HL-ASP Attenuation Volume",
> +			CS42L73_HLAASPAA, CS42L73_HLBASPBA, 0, 0x3F, 1,
> +			attn_tlv),
> +	SOC_DOUBLE_R_TLV("HL-VSP Attenuation Volume",
> +			CS42L73_HLAVSPMA, CS42L73_HLBVSPMA, 0, 0x3F, 1,
> +			attn_tlv),
> +
> +	SOC_SINGLE_TLV("SPK-IP Mono Attenuation Volume",
> +			CS42L73_SPKMIPMA, 0, 0x3F, 1, attn_tlv),
> +	SOC_SINGLE_TLV("SPK-XSP Mono Attenuation Volume",
> +			CS42L73_SPKMXSPA, 0, 0x3F, 1, attn_tlv),
> +	SOC_SINGLE_TLV("SPK-ASP Mono Attenuation Volume",
> +			CS42L73_SPKMASPA, 0, 0x3F, 1, attn_tlv),
> +	SOC_SINGLE_TLV("SPK-VSP Mono Attenuation Volume",
> +			CS42L73_SPKMVSPMA, 0, 0x3F, 1, attn_tlv),
> +
> +	SOC_SINGLE_TLV("ESL-IP Mono Attenuation Volume",
> +			CS42L73_ESLMIPMA, 0, 0x3F, 1, attn_tlv),
> +	SOC_SINGLE_TLV("ESL-XSP Mono Attenuation Volume",
> +			CS42L73_ESLMXSPA, 0, 0x3F, 1, attn_tlv),
> +	SOC_SINGLE_TLV("ESL-ASP Mono Attenuation Volume",
> +			CS42L73_ESLMASPA, 0, 0x3F, 1, attn_tlv),
> +	SOC_SINGLE_TLV("ESL-VSP Mono Attenuation Volume",
> +			CS42L73_ESLMVSPMA, 0, 0x3F, 1, attn_tlv),
> +
> +	SOC_ENUM("IP Digital Swap/Mono Select", ip_swap_enum),
> +
> +	SOC_ENUM("ESL-XSP Mono Mixer Select", esl_xsp_mono_mixer_enum),
> +	SOC_ENUM("ESL-ASP Mono Mixer Select", esl_asp_mono_mixer_enum),
> +
> +	SOC_ENUM("SPK-ASP Mono Mixer Select", spk_asp_mono_mixer_enum),
> +	SOC_ENUM("SPK-XSP Mono Mixer Select", spk_xsp_mono_mixer_enum),
> +
> +	SOC_ENUM("VSP Output Mixer Select", vspout_mixer_enum),
> +	SOC_ENUM("XSP Output Mixer Select", xspout_mixer_enum),
> +
> +};
> +
> +static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
> +	SND_SOC_DAPM_INPUT("LINEINA"),
> +	SND_SOC_DAPM_INPUT("LINEINB"),
> +	SND_SOC_DAPM_INPUT("MIC1"),
> +	SND_SOC_DAPM_SUPPLY("MIC1 Bias", CS42L73_PWRCTL2, 6, 1, NULL, 0),
> +	SND_SOC_DAPM_INPUT("MIC2"),
> +	SND_SOC_DAPM_SUPPLY("MIC2 Bias", CS42L73_PWRCTL2, 7, 1, NULL, 0),
> +	SND_SOC_DAPM_INPUT("DMICA"),
> +	SND_SOC_DAPM_INPUT("DMICB"),
> +
> +	SND_SOC_DAPM_AIF_OUT("XSPOUT", "XSP Capture",  0,
> +			CS42L73_PWRCTL2, 1, 1),
> +	SND_SOC_DAPM_AIF_OUT("ASPOUT", "ASP Capture",  0,
> +			CS42L73_PWRCTL2, 3, 1),
> +	SND_SOC_DAPM_AIF_OUT("VSPOUT", "VSP Capture",  0,
> +			CS42L73_PWRCTL2, 4, 1),
> +
> +	SND_SOC_DAPM_AIF_IN("XSPIN", "XSP Playback",  0,
> +			CS42L73_PWRCTL2, 0, 1),
> +	SND_SOC_DAPM_AIF_IN("ASPIN", "ASP Playback",  0,
> +			CS42L73_PWRCTL2, 2, 1),
> +	SND_SOC_DAPM_AIF_IN("VSPIN", "VSP Playback",  0,
> +			CS42L73_PWRCTL2, 4, 1),
> +
> +	SND_SOC_DAPM_ADC("ADC Left", NULL, CS42L73_PWRCTL1, 5, 1),
> +	SND_SOC_DAPM_ADC("ADC Right", NULL, CS42L73_PWRCTL1, 7, 1),
> +	SND_SOC_DAPM_DAC("DAC Left", NULL, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_DAC("DAC Right", NULL, SND_SOC_NOPM, 0, 0),
> +
> +	SND_SOC_DAPM_PGA("PGA Left", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_PGA("PGA Right", SND_SOC_NOPM, 0, 0, NULL, 0),
> +
> +	SND_SOC_DAPM_MUX("PGA Mux Left", SND_SOC_NOPM, 0, 0, &pgaa_mux),
> +	SND_SOC_DAPM_MUX("PGA Mux Right", SND_SOC_NOPM, 0, 0, &pgab_mux),
> +
> +	SND_SOC_DAPM_PGA("HP Amp Left", CS42L73_PWRCTL3, 0, 1, NULL, 0),
> +	SND_SOC_DAPM_PGA("HP Amp Right", CS42L73_PWRCTL3, 0, 1, NULL, 0),
> +
> +	SND_SOC_DAPM_PGA("LO Amp Left", CS42L73_PWRCTL3, 1, 1, NULL, 0),
> +	SND_SOC_DAPM_PGA("LO Amp Right", CS42L73_PWRCTL3, 1, 1, NULL, 0),
> +
> +	SND_SOC_DAPM_PGA("SPK Amp", CS42L73_PWRCTL3, 2, 1, NULL, 0),
> +
> +	SND_SOC_DAPM_PGA("EAR Amp", CS42L73_PWRCTL3, 3, 1, NULL, 0),
> +
> +	SND_SOC_DAPM_PGA("SPKLO Amp", CS42L73_PWRCTL3, 4, 1, NULL, 0),
> +
> +	SND_SOC_DAPM_OUTPUT("HPOUTA"),
> +	SND_SOC_DAPM_OUTPUT("HPOUTB"),
> +	SND_SOC_DAPM_OUTPUT("LINEOUTA"),
> +	SND_SOC_DAPM_OUTPUT("LINEOUTB"),
> +	SND_SOC_DAPM_OUTPUT("EAROUT"),
> +	SND_SOC_DAPM_OUTPUT("SPKOUT"),
> +	SND_SOC_DAPM_OUTPUT("SPKLINEOUT"),
> +};
> +
> +static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
> +	{"HPOUTA", NULL, "HP Amp Left"},
> +	{"HPOUTB", NULL, "HP Amp Right"},
> +	{"LINEOUTA", NULL, "LO Amp Left"},
> +	{"LINEOUTB", NULL, "LO Amp Right"},
> +	{"SPKOUT", NULL, "SPK Amp"},
> +	{"EAROUT", NULL, "EAR Amp"},
> +	{"SPKLINEOUT", NULL, "SPKLO Amp"},
> +
> +	{"HP Amp Left", "DAC", "DAC Left"},
> +	{"HP Amp Right", "DAC", "DAC Right"},
> +	{"LO Amp Left", "DAC", "DAC Left"},
> +	{"LO Amp Right", "DAC", "DAC Right"},
> +	{"SPK Amp", "DAC", "DAC Left"},
> +	{"SPKLO Amp", "DAC", "DAC Right"},
> +	{"EAR Amp", "DAC", "DAC Right"},
This is not right, all amplifiers are connecting to DACs, whereas per
spec you have Headset and speaker DACs and a mux before each DAC. Please
change this, otherwise this code will result in turning of all Amps when
DAC is active which is not right...
> +
> +	{"PGA Mux Left", NULL, "LINEINA"},
> +	{"PGA Mux Right", NULL, "LINEINB"},
> +	{"PGA Mux Left", NULL, "MIC1"},
> +	{"PGA Mux Right", NULL, "MIC2"},
> +
> +	{"PGA Left", NULL, "PGA Mux Left"},
> +	{"PGA Right", NULL, "PGA Mux Right"},
> +	{"ADC Left", "ADC", "PGA Left"},
> +	{"ADC Right", "ADC", "PGA Right"},
> +
> +	{"XSPOUT", NULL, "ADC Left"},
> +	{"XSPOUT", NULL, "ADC Right"},
> +	{"DAC Left", NULL, "XSPIN"},
> +	{"DAC Right", NULL, "XSPIN"},
> +
> +	{"ASPOUT", NULL, "ADC Left"},
> +	{"ASPOUT", NULL, "ADC Right"},
> +	{"DAC Left", NULL, "ASPIN"},
> +	{"DAC Right", NULL, "ASPIN"},
> +
> +	{"VSPOUT", NULL, "ADC Left"},
> +	{"VSPOUT", NULL, "ADC Right"},
> +	{"DAC Left", NULL, "VSPIN"},
> +	{"DAC Right", NULL, "VSPIN"},
> +};
> +
> +struct cs42l73_mclk_div {
> +	u32 mclk;
> +	u32 srate;
> +	u8 mmcc;
> +};
> +
> +struct cs42l73_mclk_div cs42l73_mclk_coeffs[] = {
> +	/* MCLK, Sample Rate, xMMCC[5:0] */
> +	{5644800, 11025, 0x30},
> +	{5644800, 22050, 0x20},
> +	{5644800, 44100, 0x10},
> +
> +	{6000000,  8000, 0x39},
> +	{6000000, 11025, 0x33},
> +	{6000000, 12000, 0x31},
> +	{6000000, 16000, 0x29},
> +	{6000000, 22050, 0x23},
> +	{6000000, 24000, 0x21},
> +	{6000000, 32000, 0x19},
> +	{6000000, 44100, 0x13},
> +	{6000000, 48000, 0x11},
> +
> +	{6144000,  8000, 0x38},
> +	{6144000, 12000, 0x30},
> +	{6144000, 16000, 0x28},
> +	{6144000, 24000, 0x20},
> +	{6144000, 32000, 0x18},
> +	{6144000, 48000, 0x10},
> +
> +	{6500000,  8000, 0x3C},
> +	{6500000, 11025, 0x35},
> +	{6500000, 12000, 0x34},
> +	{6500000, 16000, 0x2C},
> +	{6500000, 22050, 0x25},
> +	{6500000, 24000, 0x24},
> +	{6500000, 32000, 0x1C},
> +	{6500000, 44100, 0x15},
> +	{6500000, 48000, 0x14},
> +
> +	{6400000,  8000, 0x3E},
> +	{6400000, 11025, 0x37},
> +	{6400000, 12000, 0x36},
> +	{6400000, 16000, 0x2E},
> +	{6400000, 22050, 0x27},
> +	{6400000, 24000, 0x26},
> +	{6400000, 32000, 0x1E},
> +	{6400000, 44100, 0x17},
> +	{6400000, 48000, 0x16},
> +};
> +
> +struct cs42l73_mclkx_div {
> +	u32 mclkx;
> +	u8 ratio;
> +	u8 mclkdiv;
> +};
> +
> +struct cs42l73_mclkx_div cs42l73_mclkx_coeffs[] = {
> +	{5644800,  1, 0},	/* 5644800 */
> +	{6000000,  1, 0},	/* 6000000 */
> +	{6144000,  1, 0},	/* 6144000 */
> +	{11289600, 2, 2},	/* 5644800 */
> +	{12288000, 2, 2},	/* 6144000 */
> +	{12000000, 2, 2},	/* 6000000 */
> +	{13000000, 2, 2},	/* 6500000 */
> +	{19200000, 3, 3},	/* 6400000 */
> +	{24000000, 4, 4},	/* 6000000 */
> +	{26000000, 4, 4},	/* 6500000 */
> +	{38400000, 6, 5}	/* 6400000 */
> +};
> +
> +int cs42l73_get_mclkx_coeff(int mclkx)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cs42l73_mclkx_coeffs); i++) {
> +		if (cs42l73_mclkx_coeffs[i].mclkx == mclkx)
> +			return i;
> +	}
> +	return -EINVAL;
> +}
> +
> +int cs42l73_get_mclk_coeff(int mclk, int srate)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cs42l73_mclk_coeffs); i++) {
> +		if (cs42l73_mclk_coeffs[i].mclk == mclk &&
> +		    cs42l73_mclk_coeffs[i].srate == srate)
> +			return i;
> +	}
> +	return -EINVAL;
> +
> +}
> +
> +static int cs42l73_set_mclk(struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	int mclkx_coeff;
> +	u32 mclk = 0;
> +	u8 dmmcc = 0;
> +
> +	/* MCLKX -> MCLK */
> +	mclkx_coeff = cs42l73_get_mclkx_coeff(priv->sysclk);
> +
> +	mclk = cs42l73_mclkx_coeffs[mclkx_coeff].mclkx /
> +		cs42l73_mclkx_coeffs[mclkx_coeff].ratio;
> +
> +	dev_dbg(codec->dev, "MCLK%u %u  <-> internal MCLK %u\n",
> +		 priv->mclksel + 1, cs42l73_mclkx_coeffs[mclkx_coeff].mclkx,
> +		 mclk);
> +
> +	dmmcc = (priv->mclksel << 4) |
> +		(cs42l73_mclkx_coeffs[mclkx_coeff].mclkdiv << 1);
> +
> +	snd_soc_write(codec, CS42L73_DMMCC, dmmcc);
> +
> +	priv->mclk = mclk;
> +
> +	return 0;
> +}
> +
> +static int cs42l73_set_sysclk(struct snd_soc_dai *dai,
> +			      int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	if (clk_id != CS42L73_CLKID_MCLK1 && clk_id != CS42L73_CLKID_MCLK2) {
> +		dev_err(codec->dev, "Invalid clk_id %u\n", clk_id);
> +		return -EINVAL;
> +	}
> +
> +	if ((cs42l73_get_mclkx_coeff(freq) < 0)) {
> +		dev_err(codec->dev, "Invalid sysclk %u\n", freq);
> +		return -EINVAL;
> +	}
> +
> +	if ((cs42l73_set_mclk(dai)) < 0) {
> +		dev_err(codec->dev, "Unable to set MCLK for dai %s\n",
> +			dai->name);
> +		return -EINVAL;
> +	}
> +
> +	priv->sysclk = freq;
> +	priv->mclksel = clk_id;
> +
> +	return 0;
> +}
> +
> +static int cs42l73_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int id = codec_dai->id;
> +	int inv, format;
> +	u8 spc, mmcc;
> +
> +	spc = snd_soc_read(codec, CS42L73_SPC(id));
> +	mmcc = snd_soc_read(codec, CS42L73_MMCC(id));
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		mmcc |= MS_MASTER;
> +		break;
> +
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		mmcc &= ~MS_MASTER;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	format = (fmt & SND_SOC_DAIFMT_FORMAT_MASK);
> +	inv = (fmt & SND_SOC_DAIFMT_INV_MASK);
> +
> +	switch (format) {
> +	case SND_SOC_DAIFMT_I2S:
> +		spc &= ~xSPDIF_PCM;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +		if (mmcc & MS_MASTER) {
> +			dev_err(codec->dev,
> +				"PCM format is supported only in slave mode\n");
> +			return -EINVAL;
> +		}
> +		if (id == CS42L73_ASP) {
> +			dev_err(codec->dev,
> +				"PCM format is not supported on ASP port\n");
> +			return -EINVAL;
> +		}
> +		spc |= xSPDIF_PCM;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (spc & xSPDIF_PCM) {
> +		spc &= (31 << 3);	/* Clear PCM mode, set MSB->LSB */
> +		if (format == SND_SOC_DAIFMT_DSP_B
> +		    && inv == SND_SOC_DAIFMT_IB_IF)
> +			spc |= (xPCM_MODE0 << 4);
> +		else
> +
> +		    if (format == SND_SOC_DAIFMT_DSP_B
> +				&& inv == SND_SOC_DAIFMT_IB_NF)
> +			spc |= (xPCM_MODE1 << 4);
> +		else
> +
> +		    if (format == SND_SOC_DAIFMT_DSP_A
> +				&& inv == SND_SOC_DAIFMT_IB_IF)
> +			spc |= (xPCM_MODE1 << 4);
> +		else
> +			return -EINVAL;
> +	}
> +
> +	priv->config[id].spc = spc;
> +	priv->config[id].mmcc = mmcc;
> +
> +
> +	return 0;
> +}
> +
> +static u32 cs42l73_asrc_rates[] = {
> +	8000, 11025, 12000, 16000, 22050,
> +	24000, 32000, 44100, 48000
> +};
> +
> +static unsigned int cs42l73_get_xspfs_coeff(u32 rate)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(cs42l73_asrc_rates); i++) {
> +		if (cs42l73_asrc_rates[i] == rate)
> +			return i + 1;
> +	}
> +	return 0;		/* 0 = Don't know */
> +}
> +
> +static void cs42l73_update_asrc(struct snd_soc_codec *codec, int id, int srate)
> +{
> +	u8 spfs = 0;
> +
> +	if (srate > 0)
> +		spfs = cs42l73_get_xspfs_coeff(srate);
> +
> +	switch (id) {
> +	case CS42L73_XSP:
> +		snd_soc_update_bits(codec, CS42L73_VXSPFS, 0x0f, spfs);
> +	break;
> +	case CS42L73_ASP:
> +		snd_soc_update_bits(codec, CS42L73_ASPC, 0x3c, spfs << 2);
> +	break;
> +	case CS42L73_VSP:
> +		snd_soc_update_bits(codec, CS42L73_VXSPFS, 0xf0, spfs << 4);
> +	break;
> +	default:
> +	break;
> +	}
> +}
> +
> +static int cs42l73_pcm_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int id = dai->id;
> +	int mclk_coeff;
> +	int srate = params_rate(params);
> +
> +	if (priv->config[id].mmcc & MS_MASTER) {
> +		/* CS42L73 Master */
> +		/* MCLK -> srate */
> +		mclk_coeff =
> +		    cs42l73_get_mclk_coeff(priv->mclk, srate);
> +
> +		if (mclk_coeff < 0)
> +			return -EINVAL;
> +
> +		dev_dbg(codec->dev,
> +			 "DAI[%d]: MCLK %u, srate %u, MMCC[5:0] = %x\n",
> +			 id, priv->mclk, srate,
> +			 cs42l73_mclk_coeffs[mclk_coeff].mmcc);
> +
> +		priv->config[id].mmcc &= 0xC0;
> +		priv->config[id].mmcc |= cs42l73_mclk_coeffs[mclk_coeff].mmcc;
> +		priv->config[id].spc &= 0xFC;
> +		priv->config[id].spc |= xMCK_SCLK_64FS;
> +
> +	} else {
> +		/* CS42L73 Slave */
> +		dev_dbg(codec->dev, "DAI[%d]: Slave\n", id);
> +		priv->config[id].spc &= 0xFC;
> +		priv->config[id].spc |= xMCK_SCLK_64FS;
> +	}
> +	/* Update ASRCs */
> +	priv->config[id].srate = srate;
> +	cs42l73_update_asrc(codec, id, srate);
> +	snd_soc_write(codec, CS42L73_SPC(id), priv->config[id].spc);
> +	snd_soc_write(codec, CS42L73_MMCC(id), priv->config[id].mmcc);
> +	return 0;
> +}
> +
> +static int cs42l73_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +	int ret;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		snd_soc_update_bits(codec, CS42L73_DMMCC, MCLKDIS, 0);
> +		snd_soc_update_bits(codec, CS42L73_PWRCTL1, PDN, 0);
> +		break;
> +
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +
> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> +				ret = snd_soc_cache_sync(codec);
indent? surely checkpatch should have detected this
> +			if (ret < 0) {
> +				dev_err(codec->dev,
> +					"Failed to sync cache: %d\n", ret);
> +				return ret;
> +			}
> +		}
> +		snd_soc_update_bits(codec, CS42L73_PWRCTL1, PDN, 1);
> +		break;
> +
> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_update_bits(codec, CS42L73_PWRCTL1, PDN, 1);
> +		snd_soc_update_bits(codec, CS42L73_DMMCC, MCLKDIS, 1);
> +		break;
> +	}
> +	codec->dapm.bias_level = level;
> +	return 0;
> +}
> +
> +static int cs42l73_set_tristate(struct snd_soc_dai *dai, int tristate)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	int id = dai->id;
> +
> +	return snd_soc_update_bits(codec, CS42L73_SPC(id), 0x7F, tristate << 7);
> +}
> +
> +static struct snd_pcm_hw_constraint_list constraints_12_24 = {
> +	.count  = ARRAY_SIZE(cs42l73_asrc_rates),
> +	.list   = cs42l73_asrc_rates,
> +};
> +
> +static int cs42l73_pcm_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					SNDRV_PCM_HW_PARAM_RATE,
> +					&constraints_12_24);
> +	return 0;
> +}
> +
> +/* SNDRV_PCM_RATE_KNOT -> 12000, 24000 Hz, limit with constraint list */
> +#define CS42L73_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
> +
> +
> +#define CS42L73_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
> +	SNDRV_PCM_FMTBIT_S24_LE)
> +
> +static struct snd_soc_dai_ops cs42l73_ops = {
> +	.startup = cs42l73_pcm_startup,
> +	.hw_params = cs42l73_pcm_hw_params,
> +	.set_fmt = cs42l73_set_dai_fmt,
> +	.set_sysclk = cs42l73_set_sysclk,
> +	.set_tristate = cs42l73_set_tristate,
> +};
> +
> +struct snd_soc_dai_driver cs42l73_dai[] = {
> +	{
> +	 .name = "cs42l73-xsp",
> +	 .id = CS42L73_XSP,
> +	 .playback = {
> +		      .stream_name = "XSP Playback",
> +		      .channels_min = 1,
> +		      .channels_max = 2,
> +		      .rates = CS42L73_RATES,
> +		      .formats = CS42L73_FORMATS,},
> +
> +	 .capture = {
> +		     .stream_name = "XSP Capture",
> +		     .channels_min = 1,
> +		     .channels_max = 2,
> +		     .rates = CS42L73_RATES,
> +		     .formats = CS42L73_FORMATS,},
> +
> +	 .ops = &cs42l73_ops,
> +	 .symmetric_rates = 1,
> +	 },
> +	{
> +	 .name = "cs42l73-asp",
> +	 .id = CS42L73_ASP,
> +	 .playback = {
> +		      .stream_name = "ASP Playback",
> +		      .channels_min = 2,
> +		      .channels_max = 2,
> +		      .rates = CS42L73_RATES,
> +		      .formats = CS42L73_FORMATS,},
> +	 .capture = {
> +		     .stream_name = "ASP Capture",
> +		     .channels_min = 2,
> +		     .channels_max = 2,
> +		     .rates = CS42L73_RATES,
> +		     .formats = CS42L73_FORMATS,},
> +	 .ops = &cs42l73_ops,
> +	 .symmetric_rates = 1,
> +	 },
> +	{
> +	 .name = "cs42l73-vsp",
> +	 .id = CS42L73_VSP,
> +	 .playback = {
> +		      .stream_name = "VSP Playback",
> +		      .channels_min = 1,
> +		      .channels_max = 2,
> +		      .rates = CS42L73_RATES,
> +		      .formats = CS42L73_FORMATS,},
> +	 .capture = {
> +		     .stream_name = "VSP Capture",
> +		     .channels_min = 1,
> +		     .channels_max = 2,
> +		     .rates = CS42L73_RATES,
> +		     .formats = CS42L73_FORMATS,},
> +	 .ops = &cs42l73_ops,
> +	 .symmetric_rates = 1,
> +	 }
> +};
> +
> +static int cs42l73_suspend(struct snd_soc_codec *codec, pm_message_t state)
> +{
> +	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}
> +
> +static int cs42l73_resume(struct snd_soc_codec *codec)
> +{
> +
> +	cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +	return 0;
> +}
> +
> +static int cs42l73_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +	unsigned int devid = 0;
> +	struct cs42l73_private *cs42l73 = snd_soc_codec_get_drvdata(codec);
> +
> +	codec->control_data = cs42l73->control_data;
> +	codec->hw_write = (hw_write_t)i2c_master_send;
> +
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, cs42l73->control_type);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +	/* initialize codec */
> +	ret = snd_soc_read(codec, CS42L73_DEVID_AB);
> +	devid = (ret & 0xFF) << 12;
> +
> +	ret = snd_soc_read(codec, CS42L73_DEVID_CD);
> +	devid |= (ret & 0xFF) << 4;
> +
> +	ret = snd_soc_read(codec, CS42L73_DEVID_E);
> +	devid |= (ret & 0xF0) >> 4;
> +
> +
> +	if (devid != CS42L73_DEVID) {
> +		dev_err(codec->dev,
> +			"CS42L73 Device ID (%X). Expected %X\n",
> +			devid, CS42L73_DEVID);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_read(codec, CS42L73_REVID);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Get Revision ID failed\n");
> +		return ret;
> +	}
> +
> +	dev_info(codec->dev,
> +		 "Cirrus Logic CS42L73, Revision: %02X\n", ret & 0xFF);
> +
> +	cs42l73->mclksel = CS42L73_CLKID_MCLK1;	/* MCLK1 as master clk */
> +	cs42l73->mclk = 0;
> +
> +
> +	snd_soc_add_controls(codec, cs42l73_snd_controls,
> +			     ARRAY_SIZE(cs42l73_snd_controls));
> +
> +	return ret;
> +}
> +
> +static int cs42l73_remove(struct snd_soc_codec *codec)
> +{
> +	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}
> +
> +struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {
> +	.probe = cs42l73_probe,
> +	.remove = cs42l73_remove,
> +	.suspend = cs42l73_suspend,
> +	.resume = cs42l73_resume,
> +	.set_bias_level = cs42l73_set_bias_level,
> +	.reg_cache_size = ARRAY_SIZE(cs42l73_reg),
> +	.reg_cache_default = cs42l73_reg,
> +	.reg_word_size = sizeof(u8),
> +	.dapm_widgets = cs42l73_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(cs42l73_dapm_widgets),
> +	.dapm_routes = cs42l73_audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(cs42l73_audio_map),
> +};
> +
> +static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
> +				       const struct i2c_device_id *id)
> +{
> +	struct cs42l73_private *cs42l73;
> +	int ret;
> +
> +	cs42l73 = kzalloc(sizeof(struct cs42l73_private), GFP_KERNEL);
sizeof(*cs42l73)
> +	if (!cs42l73) {
> +		dev_err(&i2c_client->dev, "could not allocate codec\n");
> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(i2c_client, cs42l73);
> +	cs42l73->control_data = i2c_client;
> +	cs42l73->control_type = SND_SOC_I2C;
> +
> +
> +	ret =  snd_soc_register_codec(&i2c_client->dev,
> +			&soc_codec_dev_cs42l73, cs42l73_dai,
> +			ARRAY_SIZE(cs42l73_dai));
> +	if (ret < 0)
> +		kfree(cs42l73);
> +	return ret;
> +}
> +
> +static __devexit int cs42l73_i2c_remove(struct i2c_client *client)
> +{
> +	struct cs42l73_private *cs42l73 = i2c_get_clientdata(client);
> +
> +	snd_soc_unregister_codec(&client->dev);
> +	kfree(cs42l73);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id cs42l73_id[] = {
> +	{"cs42l73", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cs42l73_id);
> +
> +static struct i2c_driver cs42l73_i2c_driver = {
> +	.driver = {
> +		   .name = "cs42l73",
> +		   .owner = THIS_MODULE,
> +		   },
> +	.id_table = cs42l73_id,
> +	.probe = cs42l73_i2c_probe,
> +	.remove = __devexit_p(cs42l73_i2c_remove),
> +
> +};
> +
> +static int __init cs42l73_modinit(void)
> +{
> +	int ret;
> +	ret = i2c_add_driver(&cs42l73_i2c_driver);
> +	if (ret != 0) {
> +		printk(KERN_ERR "%s: can't add i2c driver\n", __func__);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +module_init(cs42l73_modinit);
> +
> +static void __exit cs42l73_exit(void)
> +{
> +	i2c_del_driver(&cs42l73_i2c_driver);
> +}
> +
> +module_exit(cs42l73_exit);
> +
> +MODULE_DESCRIPTION("ASoC CS42L73 driver");
> +MODULE_AUTHOR("Georgi Vlaev, Nucleus Systems Ltd, <office@nucleusys.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/cs42l73.h b/sound/soc/codecs/cs42l73.h
> new file mode 100644
> index 0000000..aa09c2e
> --- /dev/null
> +++ b/sound/soc/codecs/cs42l73.h
> @@ -0,0 +1,223 @@
> +/*
> + * ALSA SoC CS42L73 codec driver
> + *
> + * Copyright 2011 Cirrus Logic, Inc.
> + *
> + * Author: Georgi Vlaev <office@nucleusys.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifndef __CS42L73_H__
> +#define __CS42L73_H__
> +
> +/* I2C Registers */
> +/* I2C Address: 1001010[R/W] - 10010100 = 0x94(Write); 10010101 = 0x95(Read) */
> +#define CS42L73_CHIP_ID		0x4a
> +#define CS42L73_DEVID_AB	0x01	/* Device ID A & B [RO]. */
> +#define CS42L73_DEVID_CD	0x02    /* Device ID C & D [RO]. */
> +#define CS42L73_DEVID_E		0x03    /* Device ID E [RO]. */
> +#define CS42L73_REVID		0x05    /* Revision ID [RO]. */
> +#define CS42L73_PWRCTL1		0x06    /* Power Control 1. */
> +#define CS42L73_PWRCTL2		0x07    /* Power Control 2. */
> +#define CS42L73_PWRCTL3		0x08    /* Power Control 3. */
> +#define CS42L73_CPFCHC		0x09    /* Charge Pump Freq. Class H Ctl. */
> +#define CS42L73_OLMBMSDC	0x0A    /* Output Load, MIC Bias, MIC2 SDT */
> +#define CS42L73_DMMCC		0x0B    /* Digital MIC & Master Clock Ctl. */
> +#define CS42L73_XSPC		0x0C    /* Auxiliary Serial Port (XSP) Ctl. */
> +#define CS42L73_XSPMMCC		0x0D    /* XSP Master Mode Clocking Control. */
> +#define CS42L73_ASPC		0x0E    /* Audio Serial Port (ASP) Control. */
> +#define CS42L73_ASPMMCC		0x0F    /* ASP Master Mode Clocking Control. */
> +#define CS42L73_VSPC		0x10    /* Voice Serial Port (VSP) Control. */
> +#define CS42L73_VSPMMCC		0x11    /* VSP Master Mode Clocking Control. */
> +#define CS42L73_VXSPFS		0x12    /* VSP & XSP Sample Rate. */
> +#define CS42L73_MIOPC		0x13    /* Misc. Input & Output Path Control. */
> +#define CS42L73_ADCIPC		0x14	/* ADC/IP Control. */
> +#define CS42L73_MICAPREPGAAVOL	0x15	/* MIC 1 [A] PreAmp, PGAA Vol. */
> +#define CS42L73_MICBPREPGABVOL	0x16	/* MIC 2 [B] PreAmp, PGAB Vol. */
> +#define CS42L73_IPADVOL		0x17	/* Input Pat7h A Digital Volume. */
> +#define CS42L73_IPBDVOL		0x18	/* Input Path B Digital Volume. */
> +#define CS42L73_PBDC		0x19	/* Playback Digital Control. */
> +#define CS42L73_HLADVOL		0x1A	/* HP/Line A Out Digital Vol. */
> +#define CS42L73_HLBDVOL		0x1B	/* HP/Line B Out Digital Vol. */
> +#define CS42L73_SPKDVOL		0x1C	/* Spkphone Out [A] Digital Vol. */
> +#define CS42L73_ESLDVOL		0x1D	/* Ear/Spkphone LO [B] Digital */
> +#define CS42L73_HPAAVOL		0x1E	/* HP A Analog Volume. */
> +#define CS42L73_HPBAVOL		0x1F	/* HP B Analog Volume. */
> +#define CS42L73_LOAAVOL		0x20	/* Line Out A Analog Volume. */
> +#define CS42L73_LOBAVOL		0x21	/* Line Out B Analog Volume. */
> +#define CS42L73_STRINV		0x22	/* Stereo Input Path Adv. Vol. */
> +#define CS42L73_XSPINV		0x23	/* Auxiliary Port Input Advisory Vol. */
> +#define CS42L73_ASPINV		0x24	/* Audio Port Input Advisory Vol. */
> +#define CS42L73_VSPINV		0x25	/* Voice Port Input Advisory Vol. */
> +#define CS42L73_LIMARATEHL	0x26	/* Lmtr Attack Rate HP/Line. */
> +#define CS42L73_LIMRRATEHL	0x27	/* Lmtr Ctl, Rel.Rate HP/Line. */
> +#define CS42L73_LMAXHL		0x28	/* Lmtr Thresholds HP/Line. */
> +#define CS42L73_LIMARATESPK	0x29	/* Lmtr Attack Rate Spkphone [A]. */
> +#define CS42L73_LIMRRATESPK	0x2A	/* Lmtr Ctl,Release Rate Spk. [A]. */
> +#define CS42L73_LMAXSPK		0x2B	/* Lmtr Thresholds Spkphone [A]. */
> +#define CS42L73_LIMARATEESL	0x2C	/* Lmtr Attack Rate  */
> +#define CS42L73_LIMRRATEESL	0x2D	/* Lmtr Ctl,Release Rate */
> +#define CS42L73_LMAXESL		0x2E	/* Lmtr Thresholds */
> +#define CS42L73_ALCARATE	0x2F	/* ALC Enable, Attack Rate AB. */
> +#define CS42L73_ALCRRATE	0x30	/* ALC Release Rate AB.  */
> +#define CS42L73_ALCMINMAX	0x31	/* ALC Thresholds AB. */
> +#define CS42L73_NGCAB		0x32	/* Noise Gate Ctl AB. */
> +#define CS42L73_ALCNGMC		0x33	/* ALC & Noise Gate Misc Ctl. */
> +#define CS42L73_MIXERCTL	0x34	/* Mixer Control. */
> +#define CS42L73_HLAIPAA		0x35	/* HP/LO Left Mixer: L. */
> +#define CS42L73_HLBIPBA		0x36	/* HP/LO Right Mixer: R.  */
> +#define CS42L73_HLAXSPAA	0x37	/* HP/LO Left Mixer: XSP L */
> +#define CS42L73_HLBXSPBA	0x38	/* HP/LO Right Mixer: XSP R */
> +#define CS42L73_HLAASPAA	0x39	/* HP/LO Left Mixer: ASP L */
> +#define CS42L73_HLBASPBA	0x3A	/* HP/LO Right Mixer: ASP R */
> +#define CS42L73_HLAVSPMA	0x3B	/* HP/LO Left Mixer: VSP. */
> +#define CS42L73_HLBVSPMA	0x3C	/* HP/LO Right Mixer: VSP */
> +#define CS42L73_XSPAIPAA	0x3D	/* XSP Left Mixer: Left */
> +#define CS42L73_XSPBIPBA	0x3E	/* XSP Rt. Mixer: Right */
> +#define CS42L73_XSPAXSPAA	0x3F	/* XSP Left Mixer: XSP L */
> +#define CS42L73_XSPBXSPBA	0x40	/* XSP Rt. Mixer: XSP R */
> +#define CS42L73_XSPAASPAA	0x41	/* XSP Left Mixer: ASP L */
> +#define CS42L73_XSPAASPBA	0x42	/* XSP Rt. Mixer: ASP R */
> +#define CS42L73_XSPAVSPMA	0x43	/* XSP Left Mixer: VSP */
> +#define CS42L73_XSPBVSPMA	0x44	/* XSP Rt. Mixer: VSP */
> +#define CS42L73_ASPAIPAA	0x45	/* ASP Left Mixer: Left */
> +#define CS42L73_ASPBIPBA	0x46	/* ASP Rt. Mixer: Right */
> +#define CS42L73_ASPAXSPAA	0x47	/* ASP Left Mixer: XSP L */
> +#define CS42L73_ASPBXSPBA	0x48	/* ASP Rt. Mixer: XSP R */
> +#define CS42L73_ASPAASPAA	0x49	/* ASP Left Mixer: ASP L */
> +#define CS42L73_ASPBASPBA	0x4A	/* ASP Rt. Mixer: ASP R */
> +#define CS42L73_ASPAVSPMA	0x4B	/* ASP Left Mixer: VSP */
> +#define CS42L73_ASPBVSPMA	0x4C	/* ASP Rt. Mixer: VSP */
> +#define CS42L73_VSPAIPAA	0x4D	/* VSP Left Mixer: Left */
> +#define CS42L73_VSPBIPBA	0x4E	/* VSP Rt. Mixer: Right */
> +#define CS42L73_VSPAXSPAA	0x4F	/* VSP Left Mixer: XSP L */
> +#define CS42L73_VSPBXSPBA	0x50	/* VSP Rt. Mixer: XSP R */
> +#define CS42L73_VSPAASPAA	0x51	/* VSP Left Mixer: ASP Left */
> +#define CS42L73_VSPBASPBA	0x52	/* VSP Rt. Mixer: ASP Right */
> +#define CS42L73_VSPAVSPMA	0x53	/* VSP Left Mixer: VSP */
> +#define CS42L73_VSPBVSPMA	0x54	/* VSP Rt. Mixer: VSP */
> +#define CS42L73_MMIXCTL		0x55	/* Mono Mixer Controls. */
> +#define CS42L73_SPKMIPMA	0x56	/* SPK Mono Mixer: In. Path */
> +#define CS42L73_SPKMXSPA	0x57	/* SPK Mono Mixer: XSP Mono/L/R Att. */
> +#define CS42L73_SPKMASPA	0x58	/* SPK Mono Mixer: ASP Mono/L/R Att. */
> +#define CS42L73_SPKMVSPMA	0x59	/* SPK Mono Mixer: VSP Mono Atten. */
> +#define CS42L73_ESLMIPMA	0x5A	/* Ear/SpLO Mono Mixer: */
> +#define CS42L73_ESLMXSPA	0x5B	/* Ear/SpLO Mono Mixer: XSP */
> +#define CS42L73_ESLMASPA	0x5C	/* Ear/SpLO Mono Mixer: ASP */
> +#define CS42L73_ESLMVSPMA	0x5D	/* Ear/SpLO Mono Mixer: VSP */
> +#define CS42L73_IM1		0x5E	/* Interrupt Mask 1.  */
> +#define CS42L73_IM2		0x5F	/* Interrupt Mask 2. */
> +#define CS42L73_IS1		0x60	/* Interrupt Status 1 [RO]. */
> +#define CS42L73_IS2		0x61	/* Interrupt Status 2 [RO]. */
> +
> +/* Bitfield Definitions */
> +
> +/* CS42L73_PWRCTL1 */
> +#define PDN_ADCB	(1 << 7)
> +#define PDN_DMICB	(1 << 6)
> +#define PDN_ADCA        (1 << 5)
> +#define PDN_DMICA       (1 << 4)
> +#define PDN_LDO         (1 << 2)
> +#define DISCHG_FILT     (1 << 1)
> +#define PDN             (1 << 0)
> +
> +/* CS42L73_PWRCTL2 */
> +#define PDN_MIC2_BIAS	(1 << 7)
> +#define PDN_MIC1_BIAS	(1 << 6)
> +#define PDN_VSP		(1 << 4)
> +#define PDN_ASP_SDOUT	(1 << 3)
> +#define PDN_ASP_SDIN	(1 << 2)
> +#define PDN_XSP_SDOUT	(1 << 1)
> +#define PDN_XSP_SDIN	(1 << 0)
> +
> +/* CS42L73_PWRCTL3 */
> +#define PDN_THMS	(1 << 5)
> +#define PDN_SPKLO	(1 << 4)
> +#define PDN_EAR		(1 << 3)
> +#define PDN_SPK		(1 << 2)
> +#define PDN_LO		(1 << 1)
> +#define PDN_HP		(1 << 0)
> +
> +/* Thermal Overload Detect. Requires interrupt ... */
> +#define THMOVLD_150C	0
> +#define THMOVLD_132C	1
> +#define THMOVLD_115C	2
> +#define THMOVLD_098C	3
> +
> +
> +/* CS42L73_ASPC, CS42L73_XSPC, CS42L73_VSPC */
> +#define	xSP_3ST			(1 << 7)
??
> +#define xSPDIF_I2S		0
> +#define xSPDIF_PCM		(1 << 6)
> +#define xPCM_MODE0		0
> +#define xPCM_MODE1              1
> +#define xPCM_MODE2              2
> +#define xPCM_BO_MSBLSB		0
> +#define xPCM_BO_LSBMSB	        1
> +#define xMCK_SCLK_64FS		0
> +#define xMCK_SCLK_MCLK	        2
> +#define xMCK_SCLK_PREMCLK       3
> +
> +/* CS42L73_xSPMMCC */
> +#define MS_MASTER		(1 << 7)
All these should be properly namespaced..
> +
> +
> +/* CS42L73_DMMCC */
> +#define MCLKDIS			(1 << 0)
> +#define MCLKSEL_MCLK2		(1 << 4)
> +#define MCLKSEL_MCLK1		(0 << 4)
> +
> +/* CS42L73 MCLK derived from MCLK1 or MCLK2 */
> +#define CS42L73_CLKID_MCLK1     0
> +#define CS42L73_CLKID_MCLK2     1
> +
> +#define CS42L73_MCLKXDIV	0
> +#define CS42L73_MMCCDIV         1
> +
> +#define CS42L73_XSP     0
> +#define CS42L73_ASP     1
> +#define CS42L73_VSP     2
> +
> +/* IS1, IM1 */
> +#define MIC2_SDET	(1 << 6)
> +#define THMOVLD		(1 << 4)
> +#define DIGMIXOVFL	(1 << 3)
> +#define IPBOVFL		(1 << 1)
> +#define IPAOVFL		(1 << 0)
> +
> +/* Analog Softramp */
> +#define ANLGOSFT	(1 << 0)
> +
> +/* HP A/B Mute */
> +#define HPMUTE		(1 << 7)
> +/* LO A/B Mute	*/
> +#define LOMUTE		(1 << 7)
> +/* SPK Digital Mute */
> +#define SPKDMUTE	(1 << 2)
> +
> +/* Misc defines for codec */
> +#define CS42L73_RESET_GPIO 143
> +
> +#define CS42L73_DEVID		0x00042A73
> +#define CS42L73_MCLKX_MIN	5644800
> +#define CS42L73_MCLKX_MAX	38400000
> +
> +#define CS42L73_SPC(id) (CS42L73_XSPC + (id << 1))
> +#define CS42L73_MMCC(id) (CS42L73_XSPMMCC + (id << 1))
> +#define CS42L73_SPFS(id) ((id == CS42L73_ASP) ? CS42L73_ASPC : CS42L73_VXSPFS)
> +
> +#endif	/* __CS42L73_H__ */

now code shows, you dont use gpio, so why add the header?
-- 
~Vinod
