From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 18:22:25 +0200
Message-ID: <200901271822.32537.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271749.38788.anarsoul@gmail.com>
	<74d0deb30901270806s166f5336g3086e42477913e1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4131622119874733710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 0705410380F
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 17:30:47 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 13so909796eye.56
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 08:30:47 -0800 (PST)
In-Reply-To: <74d0deb30901270806s166f5336g3086e42477913e1d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--===============4131622119874733710==
Content-Type: multipart/signed;
  boundary="nextPart1868275.yZlyWFHJ3Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1868275.yZlyWFHJ3Y
Content-Type: multipart/mixed;
  boundary="Boundary-01=_BTzfJuCWw2XVwLE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_BTzfJuCWw2XVwLE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 27 January 2009 18:06:47 pHilipp Zabel wrote:

> Could you show the code?
> On magician I'm just powering up uda1380 when the driver is loaded,
> but I wouldn't mind saving some power :)
> There are two GPIOs involved - one connected to the uda1380's RESET
> line and one to control the power.
> The last one doesn't have anything to do with uda1380, really. It's an
> external power switch in a PMIC (or CPLD, on magican) so it would be
> nice if this code could live in the machine specific drivers.
>
> regards
> Philipp

Yep, of course, here's machine driver (originally created by Denis Grigorie=
v)=20
and modified codec driver.
=20
Btw, on rx1950 there're 4 gpio pins involved:
GPJ0 controls codec power
GPA1 controls amplifier power
GPG12 is jack sense pin, it's value depends whether headphone jack is inser=
ted=20
or not,
and GPD0 is connected to uda1380 reset.

--Boundary-01=_BTzfJuCWw2XVwLE
Content-Type: text/x-csrc;
  charset="iso 8859-15";
  name="uda1380.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uda1380.c"

/*
 * uda1380.c - Philips UDA1380 ALSA SoC audio driver
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Copyright (c) 2007 Philipp Zabel <philipp.zabel@gmail.com>
 * Improved support for DAPM and audio routing/mixing capabilities,
 ;* added TLV support.
 *
 * Modified by Richard Purdie <richard@openedhand.com> to fit into SoC
 * codec model.
 *
 * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
 * Copyright 2005 Openedhand Ltd.
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/string.h>
#include <linux/slab.h>
#include <linux/errno.h>
#include <linux/ioctl.h>
#include <linux/delay.h>
#include <linux/i2c.h>
#include <sound/core.h>
#include <sound/control.h>
#include <sound/initval.h>
#include <sound/info.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/tlv.h>

#include "uda1380.h"

#define UDA1380_VERSION "0.6"

/*
 * uda1380 register cache
 */
static const u16 uda1380_reg[UDA1380_CACHEREGNUM] =3D {
	0x0502, 0x0000, 0x0000, 0x3f3f,
	0x0202, 0x0000, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0xff00, 0x0000, 0x4800,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x8000, 0x0002, 0x0000,
};

/*
 * read uda1380 register cache
 */
static inline unsigned int uda1380_read_reg_cache(struct snd_soc_codec *cod=
ec,
	unsigned int reg)
{
	u16 *cache =3D codec->reg_cache;
	if (reg =3D=3D UDA1380_RESET)
		return 0;
	if (reg >=3D UDA1380_CACHEREGNUM)
		return -1;
	return cache[reg];
}

/*
 * write uda1380 register cache
 */
static inline void uda1380_write_reg_cache(struct snd_soc_codec *codec,
	u16 reg, unsigned int value)
{
	u16 *cache =3D codec->reg_cache;
	if (reg >=3D UDA1380_CACHEREGNUM)
		return;
	cache[reg] =3D value;
}

/*
 * write to the UDA1380 register space
 */
static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
	unsigned int value)
{
	u8 data[3];

	/* data is
	 *   data[0] is register offset
	 *   data[1] is MS byte
	 *   data[2] is LS byte
	 */
	data[0] =3D reg;
	data[1] =3D (value & 0xff00) >> 8;
	data[2] =3D value & 0x00ff;

	uda1380_write_reg_cache(codec, reg, value);

	/* the interpolator & decimator regs must only be written when the
	 * codec DAI is active.
	 */
	if (!codec->active && (reg >=3D UDA1380_MVOL))
		return 0;
	pr_debug("uda1380: hw write %x val %x\n", reg, value);
	if (codec->hw_write(codec->control_data, data, 3) =3D=3D 3) {
		unsigned int val;
		i2c_master_send(codec->control_data, data, 1);
		i2c_master_recv(codec->control_data, data, 2);
		val =3D (data[0]<<8) | data[1];
		if (val !=3D value) {
			pr_debug("uda1380: READ BACK VAL %x\n",
					(data[0]<<8) | data[1]);
			return -EIO;
		}
		return 0;
	} else
		return -EIO;
}

#define uda1380_reset(c)	uda1380_write(c, UDA1380_RESET, 0)

/* declarations of ALSA reg_elem_REAL controls */
static const char *uda1380_deemp[] =3D {
	"None",
	"32kHz",
	"44.1kHz",
	"48kHz",
	"96kHz",
};
static const char *uda1380_input_sel[] =3D {
	"Line",
	"Mic + Line R",
	"Line L",
	"Mic",
};
static const char *uda1380_output_sel[] =3D {
	"DAC",
	"Analog Mixer",
};
static const char *uda1380_spf_mode[] =3D {
	"Flat",
	"Minimum1",
	"Minimum2",
	"Maximum"
};
static const char *uda1380_capture_sel[] =3D {
	"ADC",
	"Digital Mixer"
};
static const char *uda1380_sel_ns[] =3D {
	"3rd-order",
	"5th-order"
};
static const char *uda1380_mix_control[] =3D {
	"off",
	"PCM only",
	"before sound processing",
	"after sound processing"
};
static const char *uda1380_sdet_setting[] =3D {
	"3200",
	"4800",
	"9600",
	"19200"
};
static const char *uda1380_os_setting[] =3D {
	"single-speed",
	"double-speed (no mixing)",
	"quad-speed (no mixing)"
};

static const struct soc_enum uda1380_deemp_enum[] =3D {
	SOC_ENUM_SINGLE(UDA1380_DEEMP, 8, 5, uda1380_deemp),
	SOC_ENUM_SINGLE(UDA1380_DEEMP, 0, 5, uda1380_deemp),
};
static const struct soc_enum uda1380_input_sel_enum =3D
	SOC_ENUM_SINGLE(UDA1380_ADC, 2, 4, uda1380_input_sel);		/* SEL_MIC, SEL_LN=
A */
static const struct soc_enum uda1380_output_sel_enum =3D
	SOC_ENUM_SINGLE(UDA1380_PM, 7, 2, uda1380_output_sel);		/* R02_EN_AVC */
static const struct soc_enum uda1380_spf_enum =3D
	SOC_ENUM_SINGLE(UDA1380_MODE, 14, 4, uda1380_spf_mode);		/* M */
static const struct soc_enum uda1380_capture_sel_enum =3D
	SOC_ENUM_SINGLE(UDA1380_IFACE, 6, 2, uda1380_capture_sel);	/* SEL_SOURCE */
static const struct soc_enum uda1380_sel_ns_enum =3D
	SOC_ENUM_SINGLE(UDA1380_MIXER, 14, 2, uda1380_sel_ns);		/* SEL_NS */
static const struct soc_enum uda1380_mix_enum =3D
	SOC_ENUM_SINGLE(UDA1380_MIXER, 12, 4, uda1380_mix_control);	/* MIX, MIX_PO=
S */
static const struct soc_enum uda1380_sdet_enum =3D
	SOC_ENUM_SINGLE(UDA1380_MIXER, 4, 4, uda1380_sdet_setting);	/* SD_VALUE */
static const struct soc_enum uda1380_os_enum =3D
	SOC_ENUM_SINGLE(UDA1380_MIXER, 0, 3, uda1380_os_setting);	/* OS */

/*
 * from -48 dB in 1.5 dB steps (mute instead of -49.5 dB)
 */
static DECLARE_TLV_DB_SCALE(amix_tlv, -4950, 150, 1);

/*
 * from -78 dB in 1 dB steps (3 dB steps, really. LSB are ignored),
 * from -66 dB in 0.5 dB steps (2 dB steps, really) and
 * from -52 dB in 0.25 dB steps
 */
static const unsigned int mvol_tlv[] =3D {
	TLV_DB_RANGE_HEAD(3),
	0, 15, TLV_DB_SCALE_ITEM(-8200, 100, 1),
	16, 43, TLV_DB_SCALE_ITEM(-6600, 50, 0),
	44, 252, TLV_DB_SCALE_ITEM(-5200, 25, 0),
};

/*
 * from -72 dB in 1.5 dB steps (6 dB steps really),
 * from -66 dB in 0.75 dB steps (3 dB steps really),
 * from -60 dB in 0.5 dB steps (2 dB steps really) and
 * from -46 dB in 0.25 dB steps
 */
static const unsigned int vc_tlv[] =3D {
	TLV_DB_RANGE_HEAD(4),
	0, 7, TLV_DB_SCALE_ITEM(-7800, 150, 1),
	8, 15, TLV_DB_SCALE_ITEM(-6600, 75, 0),
	16, 43, TLV_DB_SCALE_ITEM(-6000, 50, 0),
	44, 228, TLV_DB_SCALE_ITEM(-4600, 25, 0),
};

/* from 0 to 6 dB in 2 dB steps if SPF mode !=3D flat */
static DECLARE_TLV_DB_SCALE(tr_tlv, 0, 200, 0);

/* from 0 to 24 dB in 2 dB steps, if SPF mode =3D=3D maximum, otherwise cuts
 * off at 18 dB max) */
static DECLARE_TLV_DB_SCALE(bb_tlv, 0, 200, 0);

/* from -63 to 24 dB in 0.5 dB steps (-128...48) */
static DECLARE_TLV_DB_SCALE(dec_tlv, -6400, 50, 1);

/* from 0 to 24 dB in 3 dB steps */
static DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);

/* from 0 to 30 dB in 2 dB steps */
static DECLARE_TLV_DB_SCALE(vga_tlv, 0, 200, 0);

static const struct snd_kcontrol_new uda1380_snd_controls[] =3D {
	SOC_DOUBLE_TLV("Analog Mixer Volume", UDA1380_AMIX, 0, 8, 44, 1, amix_tlv)=
,	/* AVCR, AVCL */
	SOC_DOUBLE_TLV("Master Playback Volume", UDA1380_MVOL, 0, 8, 252, 1, mvol_=
tlv),	/* MVCL, MVCR */
	SOC_SINGLE_TLV("ADC Playback Volume", UDA1380_MIXVOL, 8, 228, 1, vc_tlv),	=
/* VC2 */
	SOC_SINGLE_TLV("PCM Playback Volume", UDA1380_MIXVOL, 0, 228, 1, vc_tlv),	=
/* VC1 */
	SOC_ENUM("Sound Processing Filter", uda1380_spf_enum),				/* M */
	SOC_DOUBLE_TLV("Tone Control - Treble", UDA1380_MODE, 4, 12, 3, 0, tr_tlv)=
, 	/* TRL, TRR */
	SOC_DOUBLE_TLV("Tone Control - Bass", UDA1380_MODE, 0, 8, 15, 0, bb_tlv),	=
/* BBL, BBR */
/**/	SOC_SINGLE("Master Playback Switch", UDA1380_DEEMP, 14, 1, 1),		/* MTM=
 */
	SOC_SINGLE("ADC Playback Switch", UDA1380_DEEMP, 11, 1, 1),		/* MT2 from d=
ecimation filter */
	SOC_ENUM("ADC Playback De-emphasis", uda1380_deemp_enum[0]),		/* DE2 */
	SOC_SINGLE("PCM Playback Switch", UDA1380_DEEMP, 3, 1, 1),		/* MT1, from d=
igital data input */
	SOC_ENUM("PCM Playback De-emphasis", uda1380_deemp_enum[1]),		/* DE1 */
	SOC_SINGLE("DAC Polarity inverting Switch", UDA1380_MIXER, 15, 1, 0),	/* D=
A_POL_INV */
	SOC_ENUM("Noise Shaper", uda1380_sel_ns_enum),				/* SEL_NS */
	SOC_ENUM("Digital Mixer Signal Control", uda1380_mix_enum),		/* MIX_POS, M=
IX */
	SOC_SINGLE("Silence Switch", UDA1380_MIXER, 7, 1, 0),			/* SILENCE, force =
DAC output to silence */
	SOC_SINGLE("Silence Detector Switch", UDA1380_MIXER, 6, 1, 0),		/* SDET_ON=
 */
	SOC_ENUM("Silence Detector Setting", uda1380_sdet_enum),		/* SD_VALUE */
	SOC_ENUM("Oversampling Input", uda1380_os_enum),			/* OS */
	SOC_DOUBLE_S8_TLV("ADC Capture Volume", UDA1380_DEC, -128, 48, dec_tlv),	/=
* ML_DEC, MR_DEC */
/**/	SOC_SINGLE("ADC Capture Switch", UDA1380_PGA, 15, 1, 1),		/* MT_ADC */
	SOC_DOUBLE_TLV("Line Capture Volume", UDA1380_PGA, 0, 8, 8, 0, pga_tlv), /=
* PGA_GAINCTRLL, PGA_GAINCTRLR */
	SOC_SINGLE("ADC Polarity inverting Switch", UDA1380_ADC, 12, 1, 0),	/* ADC=
POL_INV */
	SOC_SINGLE_TLV("Mic Capture Volume", UDA1380_ADC, 8, 15, 0, vga_tlv),	/* V=
GA_CTRL */
	SOC_SINGLE("DC Filter Bypass Switch", UDA1380_ADC, 1, 1, 0),		/* SKIP_DCFI=
L (before decimator) */
	SOC_SINGLE("DC Filter Enable Switch", UDA1380_ADC, 0, 1, 0),		/* EN_DCFIL =
(at output of decimator) */
	SOC_SINGLE("AGC Timing", UDA1380_AGC, 8, 7, 0),			/* TODO: enum, see table=
 62 */
	SOC_SINGLE("AGC Target level", UDA1380_AGC, 2, 3, 1),			/* AGC_LEVEL */
	/* -5.5, -8, -11.5, -14 dBFS */
	SOC_SINGLE("AGC Switch", UDA1380_AGC, 0, 1, 0),
};

/* add non dapm controls */
static int uda1380_add_controls(struct snd_soc_codec *codec)
{
	int err, i;

	for (i =3D 0; i < ARRAY_SIZE(uda1380_snd_controls); i++) {
		err =3D snd_ctl_add(codec->card,
			snd_soc_cnew(&uda1380_snd_controls[i], codec, NULL));
		if (err < 0)
			return err;
	}

	return 0;
}

/* Input mux */
static const struct snd_kcontrol_new uda1380_input_mux_control =3D
	SOC_DAPM_ENUM("Route", uda1380_input_sel_enum);

/* Output mux */
static const struct snd_kcontrol_new uda1380_output_mux_control =3D
	SOC_DAPM_ENUM("Route", uda1380_output_sel_enum);

/* Capture mux */
static const struct snd_kcontrol_new uda1380_capture_mux_control =3D
	SOC_DAPM_ENUM("Route", uda1380_capture_sel_enum);


static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] =3D {
	SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0,
		&uda1380_input_mux_control),
	SND_SOC_DAPM_MUX("Output Mux", SND_SOC_NOPM, 0, 0,
		&uda1380_output_mux_control),
	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0,
		&uda1380_capture_mux_control),
	SND_SOC_DAPM_PGA("Left PGA", UDA1380_PM, 3, 0, NULL, 0),
	SND_SOC_DAPM_PGA("Right PGA", UDA1380_PM, 1, 0, NULL, 0),
	SND_SOC_DAPM_PGA("Mic LNA", UDA1380_PM, 4, 0, NULL, 0),
	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", UDA1380_PM, 2, 0),
	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", UDA1380_PM, 0, 0),
	SND_SOC_DAPM_INPUT("VINM"),
	SND_SOC_DAPM_INPUT("VINL"),
	SND_SOC_DAPM_INPUT("VINR"),
	SND_SOC_DAPM_MIXER("Analog Mixer", UDA1380_PM, 6, 0, NULL, 0),
	SND_SOC_DAPM_OUTPUT("VOUTLHP"),
	SND_SOC_DAPM_OUTPUT("VOUTRHP"),
	SND_SOC_DAPM_OUTPUT("VOUTL"),
	SND_SOC_DAPM_OUTPUT("VOUTR"),
	SND_SOC_DAPM_DAC("DAC", "Playback", UDA1380_PM, 10, 0),
	SND_SOC_DAPM_PGA("HeadPhone Driver", UDA1380_PM, 13, 0, NULL, 0),
};

static const struct snd_soc_dapm_route audio_map[] =3D {

	/* output mux */
	{"HeadPhone Driver", NULL, "Output Mux"},
	{"VOUTR", NULL, "Output Mux"},
	{"VOUTL", NULL, "Output Mux"},

	{"Analog Mixer", NULL, "VINR"},
	{"Analog Mixer", NULL, "VINL"},
	{"Analog Mixer", NULL, "DAC"},

	{"Output Mux", "DAC", "DAC"},
	{"Output Mux", "Analog Mixer", "Analog Mixer"},

	/* {"DAC", "Digital Mixer", "I2S" } */

	/* headphone driver */
	{"VOUTLHP", NULL, "HeadPhone Driver"},
	{"VOUTRHP", NULL, "HeadPhone Driver"},

	/* input mux */
	{"Left ADC", NULL, "Input Mux"},
	{"Input Mux", "Mic", "Mic LNA"},
	{"Input Mux", "Mic + Line R", "Mic LNA"},
	{"Input Mux", "Line L", "Left PGA"},
	{"Input Mux", "Line", "Left PGA"},

	/* right input */
	{"Right ADC", "Mic + Line R", "Right PGA"},
	{"Right ADC", "Line", "Right PGA"},

	/* inputs */
	{"Mic LNA", NULL, "VINM"},
	{"Left PGA", NULL, "VINL"},
	{"Right PGA", NULL, "VINR"},
};

static int uda1380_add_widgets(struct snd_soc_codec *codec)
{
	snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
				  ARRAY_SIZE(uda1380_dapm_widgets));

	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));

	snd_soc_dapm_new_widgets(codec);
	return 0;
}

static int uda1380_set_dai_fmt(struct snd_soc_dai *codec_dai,
		unsigned int fmt)
{
	struct snd_soc_codec *codec =3D codec_dai->codec;
	int iface;

	/* set up DAI based upon fmt */
	iface =3D uda1380_read_reg_cache(codec, UDA1380_IFACE);
	iface &=3D ~(R01_SFORI_MASK | R01_SIM | R01_SFORO_MASK);

	/* FIXME: how to select I2S for DATAO and MSB for DATAI correctly? */
	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
	case SND_SOC_DAIFMT_I2S:
		iface |=3D R01_SFORI_I2S | R01_SFORO_I2S;
		break;
	case SND_SOC_DAIFMT_LSB:
		iface |=3D R01_SFORI_LSB16 | R01_SFORO_I2S;
		break;
	case SND_SOC_DAIFMT_MSB:
		iface |=3D R01_SFORI_MSB | R01_SFORO_I2S;
	}

	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) =3D=3D SND_SOC_DAIFMT_CBM_CFM)
		iface |=3D R01_SIM;

	uda1380_write(codec, UDA1380_IFACE, iface);

	return 0;
}

/*
 * Flush reg cache
 * We can only write the interpolator and decimator registers
 * when the DAI is being clocked by the CPU DAI. It's up to the
 * machine and cpu DAI driver to do this before we are called.
 */
static int uda1380_pcm_prepare(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
	struct snd_soc_device *socdev =3D rtd->socdev;
	struct snd_soc_codec *codec =3D socdev->codec;
	int reg, reg_start, reg_end, clk;

	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
		reg_start =3D UDA1380_MVOL;
		reg_end =3D UDA1380_MIXER;
	} else {
		reg_start =3D UDA1380_DEC;
		reg_end =3D UDA1380_AGC;
	}

	/* FIXME disable DAC_CLK */
	clk =3D uda1380_read_reg_cache(codec, UDA1380_CLK);
	uda1380_write(codec, UDA1380_CLK, clk & ~R00_DAC_CLK);

	for (reg =3D reg_start; reg <=3D reg_end; reg++) {
		pr_debug("uda1380: flush reg %x val %x:", reg,
				uda1380_read_reg_cache(codec, reg));
		uda1380_write(codec, reg, uda1380_read_reg_cache(codec, reg));
	}

	/* FIXME enable DAC_CLK */
	uda1380_write(codec, UDA1380_CLK, clk | R00_DAC_CLK);

	return 0;
}

static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
	struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
	struct snd_soc_device *socdev =3D rtd->socdev;
	struct snd_soc_codec *codec =3D socdev->codec;
	u16 clk =3D uda1380_read_reg_cache(codec, UDA1380_CLK);

	/* set WSPLL power and divider if running from this clock */
	if (clk & R00_DAC_CLK) {
		int rate =3D params_rate(params);
		u16 pm =3D uda1380_read_reg_cache(codec, UDA1380_PM);
		clk &=3D ~0x3; /* clear SEL_LOOP_DIV */
		switch (rate) {
		case 6250 ... 12500:
			clk |=3D 0x0;
			break;
		case 12501 ... 25000:
			clk |=3D 0x1;
			break;
		case 25001 ... 50000:
			clk |=3D 0x2;
			break;
		case 50001 ... 100000:
			clk |=3D 0x3;
			break;
		}
		uda1380_write(codec, UDA1380_PM, R02_PON_PLL | pm);
	}

	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
		clk |=3D R00_EN_DAC | R00_EN_INT;
	else
		clk |=3D R00_EN_ADC | R00_EN_DEC;

	uda1380_write(codec, UDA1380_CLK, clk);
	return 0;
}

static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
	struct snd_soc_device *socdev =3D rtd->socdev;
	struct snd_soc_codec *codec =3D socdev->codec;
	u16 clk =3D uda1380_read_reg_cache(codec, UDA1380_CLK);

	/* shut down WSPLL power if running from this clock */
	if (clk & R00_DAC_CLK) {
		u16 pm =3D uda1380_read_reg_cache(codec, UDA1380_PM);
		uda1380_write(codec, UDA1380_PM, ~R02_PON_PLL & pm);
	}

	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
		clk &=3D ~(R00_EN_DAC | R00_EN_INT);
	else
		clk &=3D ~(R00_EN_ADC | R00_EN_DEC);

	uda1380_write(codec, UDA1380_CLK, clk);
}

static int uda1380_mute(struct snd_soc_dai *codec_dai, int mute)
{
	struct snd_soc_codec *codec =3D codec_dai->codec;
	u16 mute_reg =3D uda1380_read_reg_cache(codec, UDA1380_DEEMP) & ~R13_MTM;

	/* FIXME: mute(codec,0) is called when the magician clock is already
	 * set to WSPLL, but for some unknown reason writing to interpolator
	 * registers works only when clocked by SYSCLK */
	u16 clk =3D uda1380_read_reg_cache(codec, UDA1380_CLK);
	uda1380_write(codec, UDA1380_CLK, ~R00_DAC_CLK & clk);
	if (mute)
		uda1380_write(codec, UDA1380_DEEMP, mute_reg | R13_MTM);
	else
		uda1380_write(codec, UDA1380_DEEMP, mute_reg);
	uda1380_write(codec, UDA1380_CLK, clk);
	return 0;
}

static int uda1380_set_bias_level(struct snd_soc_codec *codec,
	enum snd_soc_bias_level level)
{
	int pm =3D uda1380_read_reg_cache(codec, UDA1380_PM);
	void (*power)(int) =3D codec->private_data;
	int i;
	u8 *cache =3D codec->reg_cache;

	switch (level) {
	case SND_SOC_BIAS_ON:
	case SND_SOC_BIAS_PREPARE:
		power(1);
		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);
		break;
	case SND_SOC_BIAS_STANDBY:
		if (power) power(1);
		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS);
		break;
	case SND_SOC_BIAS_OFF:
		uda1380_write(codec, UDA1380_PM, 0x0);
		if (power) power(0);
		break;
	}
	codec->bias_level =3D level;
	return 0;
}

#define UDA1380_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
		       SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
		       SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

struct snd_soc_dai uda1380_dai[] =3D {
{
	.name =3D "UDA1380",
	.playback =3D {
		.stream_name =3D "Playback",
		.channels_min =3D 1,
		.channels_max =3D 2,
		.rates =3D UDA1380_RATES,
		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,},
	.capture =3D {
		.stream_name =3D "Capture",
		.channels_min =3D 1,
		.channels_max =3D 2,
		.rates =3D UDA1380_RATES,
		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,},
	.ops =3D {
		.hw_params =3D uda1380_pcm_hw_params,
		.shutdown =3D uda1380_pcm_shutdown,
		.prepare =3D uda1380_pcm_prepare,
	},
	.dai_ops =3D {
		.digital_mute =3D uda1380_mute,
		.set_fmt =3D uda1380_set_dai_fmt,
	},
},
{ /* playback only - dual interface */
	.name =3D "UDA1380",
	.playback =3D {
		.stream_name =3D "Playback",
		.channels_min =3D 1,
		.channels_max =3D 2,
		.rates =3D UDA1380_RATES,
		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
	},
	.ops =3D {
		.hw_params =3D uda1380_pcm_hw_params,
		.shutdown =3D uda1380_pcm_shutdown,
		.prepare =3D uda1380_pcm_prepare,
	},
	.dai_ops =3D {
		.digital_mute =3D uda1380_mute,
		.set_fmt =3D uda1380_set_dai_fmt,
	},
},
{ /* capture only - dual interface*/
	.name =3D "UDA1380",
	.capture =3D {
		.stream_name =3D "Capture",
		.channels_min =3D 1,
		.channels_max =3D 2,
		.rates =3D UDA1380_RATES,
		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
	},
	.ops =3D {
		.hw_params =3D uda1380_pcm_hw_params,
		.shutdown =3D uda1380_pcm_shutdown,
		.prepare =3D uda1380_pcm_prepare,
	},
	.dai_ops =3D {
		.set_fmt =3D uda1380_set_dai_fmt,
	},
},
};
EXPORT_SYMBOL_GPL(uda1380_dai);

static int uda1380_suspend(struct platform_device *pdev, pm_message_t state)
{
	struct snd_soc_device *socdev =3D platform_get_drvdata(pdev);
	struct snd_soc_codec *codec =3D socdev->codec;

	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
	return 0;
}

static int uda1380_resume(struct platform_device *pdev)
{
	struct snd_soc_device *socdev =3D platform_get_drvdata(pdev);
	struct snd_soc_codec *codec =3D socdev->codec;
	int i;
	u8 data[2];
	u16 *cache =3D codec->reg_cache;

	/* Sync reg_cache with the hardware */
	for (i =3D 0; i < ARRAY_SIZE(uda1380_reg); i++) {
		data[0] =3D (i << 1) | ((cache[i] >> 8) & 0x0001);
		data[1] =3D cache[i] & 0x00ff;
		codec->hw_write(codec->control_data, data, 2);
	}
	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
	uda1380_set_bias_level(codec, codec->suspend_bias_level);
	return 0;
}

/*
 * initialise the UDA1380 driver
 * register mixer and dsp interfaces with the kernel
 */
static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
{
	struct snd_soc_codec *codec =3D socdev->codec;
	int ret =3D 0;

	codec->name =3D "UDA1380";
	codec->owner =3D THIS_MODULE;
	codec->read =3D uda1380_read_reg_cache;
	codec->write =3D uda1380_write;
	codec->set_bias_level =3D uda1380_set_bias_level;
	codec->dai =3D uda1380_dai;
	codec->num_dai =3D ARRAY_SIZE(uda1380_dai);
	codec->reg_cache =3D kmemdup(uda1380_reg, sizeof(uda1380_reg),
				   GFP_KERNEL);
	if (codec->reg_cache =3D=3D NULL)
		return -ENOMEM;
	codec->reg_cache_size =3D ARRAY_SIZE(uda1380_reg);
	codec->reg_cache_step =3D 1;

	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
	uda1380_reset(codec);

	/* register pcms */
	ret =3D snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
	if (ret < 0) {
		pr_err("uda1380: failed to create pcms\n");
		goto pcm_err;
	}
	/* power on device */
	/* set clock input */
	switch (dac_clk) {
	case UDA1380_DAC_CLK_SYSCLK:
		uda1380_write(codec, UDA1380_CLK, 0);
		break;
	case UDA1380_DAC_CLK_WSPLL:
		uda1380_write(codec, UDA1380_CLK, R00_DAC_CLK);
		break;
	}

	/* uda1380 init */
	uda1380_add_controls(codec);
	uda1380_add_widgets(codec);
	ret =3D snd_soc_register_card(socdev);
	if (ret < 0) {
		pr_err("uda1380: failed to register card\n");
		goto card_err;
	}

	return ret;

card_err:
	snd_soc_free_pcms(socdev);
	snd_soc_dapm_free(socdev);
pcm_err:
	kfree(codec->reg_cache);
	return ret;
}

static struct snd_soc_device *uda1380_socdev;

#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

static int uda1380_i2c_probe(struct i2c_client *i2c,
			     const struct i2c_device_id *id)
{
	struct snd_soc_device *socdev =3D uda1380_socdev;
	struct uda1380_setup_data *setup =3D socdev->codec_data;
	struct snd_soc_codec *codec =3D socdev->codec;
	int ret;

	i2c_set_clientdata(i2c, codec);
	codec->control_data =3D i2c;

	ret =3D uda1380_init(socdev, setup->dac_clk);
	if (ret < 0)
		pr_err("uda1380: failed to initialise UDA1380\n");

	return ret;
}

static int uda1380_i2c_remove(struct i2c_client *client)
{
	struct snd_soc_codec *codec =3D i2c_get_clientdata(client);
	kfree(codec->reg_cache);
	return 0;
}

static const struct i2c_device_id uda1380_i2c_id[] =3D {
	{ "uda1380", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);

static struct i2c_driver uda1380_i2c_driver =3D {
	.driver =3D {
		.name =3D  "UDA1380 I2C Codec",
		.owner =3D THIS_MODULE,
	},
	.probe =3D    uda1380_i2c_probe,
	.remove =3D   uda1380_i2c_remove,
	.id_table =3D uda1380_i2c_id,
};

static int uda1380_add_i2c_device(struct platform_device *pdev,
				  const struct uda1380_setup_data *setup)
{
	struct i2c_board_info info;
	struct i2c_adapter *adapter;
	struct i2c_client *client;
	int ret;

	ret =3D i2c_add_driver(&uda1380_i2c_driver);
	if (ret !=3D 0) {
		dev_err(&pdev->dev, "can't add i2c driver\n");
		return ret;
	}

	memset(&info, 0, sizeof(struct i2c_board_info));
	info.addr =3D setup->i2c_address;
	strlcpy(info.type, "uda1380", I2C_NAME_SIZE);

	adapter =3D i2c_get_adapter(setup->i2c_bus);
	if (!adapter) {
		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
			setup->i2c_bus);
		goto err_driver;
	}

	client =3D i2c_new_device(adapter, &info);
	i2c_put_adapter(adapter);
	if (!client) {
		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
			(unsigned int)info.addr);
		goto err_driver;
	}

	return 0;

err_driver:
	i2c_del_driver(&uda1380_i2c_driver);
	return -ENODEV;
}
#endif

static int uda1380_probe(struct platform_device *pdev)
{
	struct snd_soc_device *socdev =3D platform_get_drvdata(pdev);
	struct uda1380_setup_data *setup;
	struct snd_soc_codec *codec;
	int ret;

	pr_info("UDA1380 Audio Codec %s\n", UDA1380_VERSION);

	setup =3D socdev->codec_data;
	codec =3D kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
	if (codec =3D=3D NULL)
		return -ENOMEM;

	socdev->codec =3D codec;
=09
	/* Ugly, but should work */
	codec->private_data =3D setup->power;
	mutex_init(&codec->mutex);
	INIT_LIST_HEAD(&codec->dapm_widgets);
	INIT_LIST_HEAD(&codec->dapm_paths);

	uda1380_socdev =3D socdev;
	ret =3D -ENODEV;

#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
	if (setup->i2c_address) {
		codec->hw_write =3D (hw_write_t)i2c_master_send;
		ret =3D uda1380_add_i2c_device(pdev, setup);
	}
#endif

	if (ret !=3D 0)
		kfree(codec);
	return ret;
}

/* power down chip */
static int uda1380_remove(struct platform_device *pdev)
{
	struct snd_soc_device *socdev =3D platform_get_drvdata(pdev);
	struct snd_soc_codec *codec =3D socdev->codec;

	if (codec->control_data)
		uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);

	snd_soc_free_pcms(socdev);
	snd_soc_dapm_free(socdev);
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
	i2c_unregister_device(codec->control_data);
	i2c_del_driver(&uda1380_i2c_driver);
#endif
	kfree(codec);

	return 0;
}

struct snd_soc_codec_device soc_codec_dev_uda1380 =3D {
	.probe =3D 	uda1380_probe,
	.remove =3D 	uda1380_remove,
	.suspend =3D 	uda1380_suspend,
	.resume =3D	uda1380_resume,
};
EXPORT_SYMBOL_GPL(soc_codec_dev_uda1380);

MODULE_AUTHOR("Giorgio Padrin");
MODULE_DESCRIPTION("Audio support for codec Philips UDA1380");
MODULE_LICENSE("GPL");

--Boundary-01=_BTzfJuCWw2XVwLE
Content-Type: text/x-csrc;
  charset="iso 8859-15";
  name="rx1950_uda1380.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rx1950_uda1380.c"

/*
 * rx1950.c  --  ALSA Soc Audio Layer
 *
 * Copyright (c) 2007 Roman Moravcik <roman.moravcik@gmail.com>
 *
 * Based on smdk2440.c and magician.c
 *
 * Authors: Graeme Gregory graeme.gregory@wolfsonmicro.com
 *          Philipp Zabel <philipp.zabel@gmail.com>
 *          Denis Grigoriev <dgreenday@gmail.com>
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 */

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/timer.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/spinlock.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>

#include <asm/mach-types.h>
#include <asm/hardware/scoop.h>
#include <asm/plat-s3c24xx/regs-iis.h>
#include <mach/regs-clock.h>
#include <mach/regs-gpio.h>
#include <mach/regs-gpioj.h>
#include <mach/audio.h>

#include <asm/io.h>
#include <mach/hardware.h>
#include "../codecs/uda1380.h"
#include "s3c24xx-pcm.h"
#include "s3c24xx-i2s.h"

//#define RX1950_DEBUG
#ifdef RX1950_DEBUG
#define DBG(x...) printk(KERN_INFO x)
#else
#define DBG(x...)
#endif

#define RX1950_HP_OFF    0
#define RX1950_HP_ON     1
#define RX1950_MIC       2

#define RX1950_SPK_ON    0
#define RX1950_SPK_OFF   1

static int rx1950_jack_func =3D RX1950_HP_ON;
static int rx1950_spk_func =3D RX1950_SPK_OFF;

static void rx1950_ext_control(struct snd_soc_codec *codec)
{
	printk("%s entered\n", __func__);
	if (rx1950_spk_func =3D=3D RX1950_SPK_ON)
		snd_soc_dapm_enable_pin(codec, "Speaker");
	else
		snd_soc_dapm_disable_pin(codec, "Speaker");
	   =20
	/* set up jack connection */
	switch (rx1950_jack_func) {
		case RX1950_HP_OFF:
	    		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
			snd_soc_dapm_disable_pin(codec, "Mic Jack");
			break;
		case RX1950_HP_ON:
			snd_soc_dapm_enable_pin(codec, "Headphone Jack");
			snd_soc_dapm_disable_pin(codec, "Mic Jack");
			break;
		case RX1950_MIC:
			snd_soc_dapm_disable_pin(codec, "Headphone Jack");
			snd_soc_dapm_enable_pin(codec, "Mic Jack");
			break;
	}
	snd_soc_dapm_sync(codec);
}

static int rx1950_startup(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
	struct snd_soc_codec *codec =3D rtd->socdev->codec;

	printk("%s entered\n", __func__);

	/* check the jack status at stream startup */
	rx1950_ext_control(codec);

	return 0;
}

static void rx1950_shutdown(struct snd_pcm_substream *substream)
{
//	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
//	struct snd_soc_codec *codec =3D rtd->socdev->codec;

	//DBG("Entered rx1950_shutdown\n");
	printk("%s entered\n", __func__);
}

static int rx1950_hw_params(struct snd_pcm_substream *substream,
				struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
	struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
	struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
	unsigned long iis_clkrate;
	int div, div256, div384, diff256, diff384, bclk;
	int ret;
	unsigned int rate=3Dparams_rate(params);

	DBG("Entered %s\n",__FUNCTION__);

	iis_clkrate =3D s3c24xx_i2s_get_clockrate();
	DBG("iis_clkrate =3D %li\n", iis_clkrate);

	/* Using PCLK doesnt seem to suit audio particularly well on these cpu's
	 */

	div256 =3D iis_clkrate / (rate * 256);
	div384 =3D iis_clkrate / (rate * 384);

	if (((iis_clkrate / div256) - (rate * 256)) <
		((rate * 256) - (iis_clkrate / (div256 + 1)))) {
		diff256 =3D (iis_clkrate / div256) - (rate * 256);
	} else {
		div256++;
		diff256 =3D (iis_clkrate / div256) - (rate * 256);
	}

	if (((iis_clkrate / div384) - (rate * 384)) <
		((rate * 384) - (iis_clkrate / (div384 + 1)))) {
		diff384 =3D (iis_clkrate / div384) - (rate * 384);
	} else {
		div384++;
		diff384 =3D (iis_clkrate / div384) - (rate * 384);
	}

	DBG("diff256 %d, diff384 %d\n", diff256, diff384);

	if (diff256<=3Ddiff384) {
		DBG("Selected 256FS\n");
		div =3D div256;
		bclk =3D S3C2410_IISMOD_256FS;
	} else {
		DBG("Selected 384FS\n");
		div =3D div384;
		bclk =3D S3C2410_IISMOD_384FS;
	}

	/* set codec DAI configuration */
	ret =3D codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* set cpu DAI configuration */
	ret =3D cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* set the audio system clock for DAC and ADC */
	ret =3D cpu_dai->dai_ops.set_sysclk(cpu_dai, S3C24XX_CLKSRC_PCLK,
		rate, SND_SOC_CLOCK_OUT);
	if (ret < 0)
		return ret;

	/* set MCLK division for sample rate */
	ret =3D cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK, S3C2410_IIS=
MOD_32FS );
	if (ret < 0)
		return ret;

	/* set BCLK division for sample rate */
	ret =3D cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK, bclk);
	if (ret < 0)
		return ret;

	/* set prescaler division for sample rate */
	ret =3D cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
		S3C24XX_PRESCALE(div,div));
	if (ret < 0)
		return ret;

	return 0;
}

static struct snd_soc_ops rx1950_ops =3D {
	.startup 	=3D rx1950_startup,
	.shutdown 	=3D rx1950_shutdown,
	.hw_params 	=3D rx1950_hw_params,
//	.prepare	=3D rx1950_playback_prepare,
//	.hw_free	=3D rx1950_hw_free,
};

static int rx1950_get_jack(struct snd_kcontrol *kcontrol,
			   struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] =3D rx1950_jack_func;
	return 0;
}

static int rx1950_set_jack(struct snd_kcontrol *kcontrol,
			   struct snd_ctl_elem_value *ucontrol)
{
	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);

	if (rx1950_jack_func =3D=3D ucontrol->value.integer.value[0])
		return 0;

	rx1950_jack_func =3D ucontrol->value.integer.value[0];
	rx1950_ext_control(codec);
	return 1;
}

static int rx1950_get_spk(struct snd_kcontrol *kcontrol,
			  struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] =3D rx1950_spk_func;
	return 0;
}

static int rx1950_set_spk(struct snd_kcontrol *kcontrol,
			  struct snd_ctl_elem_value *ucontrol)
{
	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);

	if (rx1950_spk_func =3D=3D ucontrol->value.integer.value[0])
		return 0;

	rx1950_spk_func =3D ucontrol->value.integer.value[0];
	if (rx1950_spk_func) {
		s3c2410_gpio_setpin(S3C2410_GPA1, 0);
	} else {
		s3c2410_gpio_setpin(S3C2410_GPA1, 1);
	}
	rx1950_ext_control(codec);
	return 1;
}

static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
	       	struct snd_kcontrol *kcontrol, int event)
{
	s3c2410_gpio_cfgpin(S3C2410_GPA1, S3C2410_GPIO_OUTPUT);
	if (SND_SOC_DAPM_EVENT_ON(event) && (rx1950_spk_func =3D=3D 0))
		s3c2410_gpio_setpin(S3C2410_GPA1, 1);
	else
		s3c2410_gpio_setpin(S3C2410_GPA1, 0);

	return 0;
}

/* rx1950 machine dapm widgets */
static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] =3D {
	SND_SOC_DAPM_HP("Headphone Jack", NULL),
	SND_SOC_DAPM_MIC("Mic Jack", NULL),
	SND_SOC_DAPM_SPK("Speaker", rx1950_spk_power),
};

/* rx1950 machine audio_map */
static const struct snd_soc_dapm_route audio_map[] =3D {
	/* headphone connected to VOUTLHP, VOUTRHP */
	{"Headphone Jack", NULL, "VOUTLHP"},
	{"Headphone Jack", NULL, "VOUTRHP"},

	/* ext speaker connected to VOUTL, VOUTR  */
	{"Speaker", NULL, "VOUTL"},
	{"Speaker", NULL, "VOUTR"},

	/* mic is connected to VINM */
	{"VINM", NULL, "Mic Jack"},
};

static const char *jack_function[] =3D {"Off", "Headphone", "Mic"};
static const char *spk_function[] =3D {"On", "Off"};

static const struct soc_enum rx1950_enum[] =3D {
	SOC_ENUM_SINGLE_EXT(3, jack_function),
	SOC_ENUM_SINGLE_EXT(2, spk_function),
};

static const struct snd_kcontrol_new uda1380_rx1950_controls[] =3D {
	SOC_ENUM_EXT("Jack Function", rx1950_enum[0], rx1950_get_jack,
			rx1950_set_jack),
	SOC_ENUM_EXT("Speaker Function", rx1950_enum[1], rx1950_get_spk,
			rx1950_set_spk),
};

/*
 * Logic for a UDA1380 as attached to RX1950
 */
static int rx1950_uda1380_init(struct snd_soc_codec *codec)
{
	int i, err;

	DBG("Staring rx1950 init\n");

	/* NC codec pins */
	snd_soc_dapm_nc_pin(codec, "VOUTLHP");
	snd_soc_dapm_nc_pin(codec, "VOUTRHP");
=09
	/* Add rx1950 specific widgets */
	snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
				  ARRAY_SIZE(uda1380_dapm_widgets));

	rx1950_ext_control(codec);

	/* Add rx1950 specific controls */
	for (i =3D 0; i < ARRAY_SIZE(uda1380_rx1950_controls); i++) {
		if ((err =3D snd_ctl_add(codec->card,
				snd_soc_cnew(&uda1380_rx1950_controls[i],
				codec, NULL))) < 0)
			return err;
	}


	/* Set up rx1950 specific audio path audio_mapnects */
	err =3D snd_soc_dapm_add_routes(codec, audio_map,
				      ARRAY_SIZE(audio_map));

	snd_soc_dapm_sync(codec);

	DBG("Ending rx1950 init\n");

	return 0;
}

/* s3c24xx digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link s3c24xx_dai =3D {
	.name 		=3D "uda1380",
	.stream_name 	=3D "UDA1380",
	.cpu_dai 	=3D &s3c24xx_i2s_dai,
	.codec_dai 	=3D &uda1380_dai[UDA1380_DAI_DUPLEX],
	.init 		=3D rx1950_uda1380_init,
	.ops 		=3D &rx1950_ops,
};

/* rx1950 audio machine driver */
static struct snd_soc_machine snd_soc_machine_rx1950 =3D {
	.name 		=3D "RX1950",
	.dai_link 	=3D &s3c24xx_dai,
	.num_links 	=3D 1,
};

static void rx1950_codec_enable(int enable);

static struct uda1380_setup_data rx1950_uda1380_setup =3D {
	.i2c_address 	=3D 0x1a,
	.dac_clk 	=3D UDA1380_DAC_CLK_SYSCLK,
	.power =3D rx1950_codec_enable,
};

/* s3c24xx audio subsystem */
static struct snd_soc_device s3c24xx_snd_devdata =3D {
	.machine 	=3D &snd_soc_machine_rx1950,
	.platform 	=3D &s3c24xx_soc_platform,
	.codec_dev 	=3D &soc_codec_dev_uda1380,
	.codec_data 	=3D &rx1950_uda1380_setup,
};

static struct platform_device *s3c24xx_snd_device;

//static DECLARE_COMPLETION(rx1950_sound_completion);
static DECLARE_MUTEX(rx1950_power_mutex);
//static spinlock_t cmpl_lock =3D SPIN_LOCK_UNLOCKED;
//static int waiting_for_completion;


static irqreturn_t codec_enabled(int irq, void *dev_id)
{
	/*spin_lock(&cmpl_lock);
	if (waiting_for_completion) {
		printk("%s: completed!\n", __func__);
		complete(&rx1950_sound_completion);
		waiting_for_completion =3D 0;
	}
	spin_unlock(&cmpl_lock);*/
	//printk("%s: got here!\n", __func__);

	return IRQ_HANDLED;
}

static void rx1950_codec_enable(int enable)
{
	down(&rx1950_power_mutex);
	printk("%s: enable =3D=3D %d\n", __func__, enable);
	if (enable) {
		if (s3c2410_gpio_getpin(S3C2440_GPJ0))
			goto done;
		//spin_lock(&cmpl_lock);
		//waiting_for_completion =3D 1;
		//spin_unlock(&cmpl_lock);
		s3c2410_gpio_setpin(S3C2410_GPD0, 0);
		s3c2410_gpio_setpin(S3C2440_GPJ0, 0);
		s3c2410_gpio_setpin(S3C2440_GPJ0, 1);

		/* Wait for EINT20 irq to ensure uda1380 is powered */
		//printk("%s: waiting for compeltion...\n", __func__);
		//wait_for_completion(&rx1950_sound_completion);
		//printk("%s: completed\n", __func__);
		//printk("%s: GPG12: %d\n", __func__,
		//	s3c2410_gpio_getpin(S3C2410_GPG12));
		mdelay(50);
		s3c2410_gpio_setpin(S3C2410_GPD0, 1);
		s3c2410_gpio_setpin(S3C2410_GPD0, 0);
	}
	else {
		if (!s3c2410_gpio_getpin(S3C2440_GPJ0))
			goto done;
		s3c2410_gpio_setpin(S3C2440_GPJ0, 1);
		s3c2410_gpio_setpin(S3C2440_GPJ0, 0);
	}
done:
	printk("%s: done!\n", __func__);
	up(&rx1950_power_mutex);
}

static int __init rx1950_init(void)
{
	int ret;

	/* configure some gpios */
	s3c2410_gpio_cfgpin(S3C2410_GPD0, S3C2410_GPIO_OUTPUT);
	s3c2410_gpio_cfgpin(S3C2410_GPG12, S3C2410_GPIO_IRQ);
	s3c2410_gpio_cfgpin(S3C2440_GPJ0, S3C2410_GPIO_OUTPUT);


	s3c24xx_snd_device =3D platform_device_alloc("soc-audio", -1);
	if (!s3c24xx_snd_device) {
		printk(KERN_ERR "platform_dev_alloc failed\n");
		return -ENOMEM;
	}

	if (request_irq(IRQ_EINT20, codec_enabled,
			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
			"snd_soc_rx1950_uda1380", s3c24xx_snd_device)) {
		printk(KERN_ERR "can't get codec enabled irq.\n");
		/* FIXME: fix memory leak here! */
		return -ENOENT;
	}
	/* enable codec's power */

	platform_set_drvdata(s3c24xx_snd_device, &s3c24xx_snd_devdata);
	s3c24xx_snd_devdata.dev =3D &s3c24xx_snd_device->dev;
	ret =3D platform_device_add(s3c24xx_snd_device);

	if (ret) {
		DBG("ret =3D %i\n",ret);
		platform_device_put(s3c24xx_snd_device);
	}

	printk("%s done\n", __func__);

	return ret;
}

static void __exit rx1950_exit(void)
{
	disable_irq(IRQ_EINT20);
	free_irq(IRQ_EINT20, s3c24xx_snd_device);
	platform_device_unregister(s3c24xx_snd_device);
}

module_init(rx1950_init);
module_exit(rx1950_exit);

/* Module information */
MODULE_AUTHOR("Denis Grigoriev");
MODULE_DESCRIPTION("ALSA SoC RX1950");
MODULE_LICENSE("GPL");

--Boundary-01=_BTzfJuCWw2XVwLE
Content-Type: text/x-chdr;
  charset="iso 8859-15";
  name="uda1380.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uda1380.h"

/*
 * Audio support for Philips UDA1380
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
 */

#ifndef _UDA1380_H
#define _UDA1380_H

#define UDA1380_CLK	0x00
#define UDA1380_IFACE	0x01
#define UDA1380_PM	0x02
#define UDA1380_AMIX	0x03
#define UDA1380_HP	0x04
#define UDA1380_MVOL	0x10
#define UDA1380_MIXVOL	0x11
#define UDA1380_MODE	0x12
#define UDA1380_DEEMP	0x13
#define UDA1380_MIXER	0x14
#define UDA1380_INTSTAT	0x18
#define UDA1380_DEC	0x20
#define UDA1380_PGA	0x21
#define UDA1380_ADC	0x22
#define UDA1380_AGC	0x23
#define UDA1380_DECSTAT	0x28
#define UDA1380_RESET	0x7f

#define UDA1380_CACHEREGNUM 0x24

/* Register flags */
#define R00_EN_ADC	0x0800
#define R00_EN_DEC	0x0400
#define R00_EN_DAC	0x0200
#define R00_EN_INT	0x0100
#define R00_DAC_CLK	0x0010
#define R01_SFORI_I2S   0x0000
#define R01_SFORI_LSB16 0x0100
#define R01_SFORI_LSB18 0x0200
#define R01_SFORI_LSB20 0x0300
#define R01_SFORI_MSB   0x0500
#define R01_SFORI_MASK  0x0700
#define R01_SFORO_I2S   0x0000
#define R01_SFORO_LSB16 0x0001
#define R01_SFORO_LSB18 0x0002
#define R01_SFORO_LSB20 0x0003
#define R01_SFORO_LSB24 0x0004
#define R01_SFORO_MSB   0x0005
#define R01_SFORO_MASK  0x0007
#define R01_SEL_SOURCE  0x0040
#define R01_SIM		0x0010
#define R02_PON_PLL	0x8000
#define R02_PON_HP	0x2000
#define R02_PON_DAC	0x0400
#define R02_PON_BIAS	0x0100
#define R02_EN_AVC	0x0080
#define R02_PON_AVC	0x0040
#define R02_PON_LNA	0x0010
#define R02_PON_PGAL	0x0008
#define R02_PON_ADCL	0x0004
#define R02_PON_PGAR	0x0002
#define R02_PON_ADCR	0x0001
#define R13_MTM		0x4000
#define R14_SILENCE	0x0080
#define R14_SDET_ON	0x0040
#define R21_MT_ADC	0x8000
#define R22_SEL_LNA	0x0008
#define R22_SEL_MIC	0x0004
#define R22_SKIP_DCFIL	0x0002
#define R23_AGC_EN	0x0001

struct uda1380_setup_data {
	int            i2c_bus;
	unsigned short i2c_address;
	int            dac_clk;
	void           (* power)(int);
#define UDA1380_DAC_CLK_SYSCLK 0
#define UDA1380_DAC_CLK_WSPLL  1
};

#define UDA1380_DAI_DUPLEX	0 /* playback and capture on single DAI */
#define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
#define UDA1380_DAI_CAPTURE	2 /* capture DAI */

extern struct snd_soc_dai uda1380_dai[3];
extern struct snd_soc_codec_device soc_codec_dev_uda1380;

#endif /* _UDA1380_H */

--Boundary-01=_BTzfJuCWw2XVwLE--

--nextPart1868275.yZlyWFHJ3Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJfzTIRM6pQpltKE4RAvrzAJ942INv+ydUxxp8u01yRQLtP+2sNQCgq5F3
gJuEocyxMwz4QDEKmw8o0lM=
=48l8
-----END PGP SIGNATURE-----

--nextPart1868275.yZlyWFHJ3Y--

--===============4131622119874733710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4131622119874733710==--
