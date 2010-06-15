From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver [File 1/3]
Date: Tue, 15 Jun 2010 10:29:14 +1000
Message-ID: <20100615002913.GC7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9230624432
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 02:29:57 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK2N-0007iQ-BD
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:29:55 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOK2M-00023F-5k
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:29:55 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK2M-00023C-4N
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:29:54 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK1j-0007YY-K3
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:29:54 +1000
Content-Disposition: inline
In-Reply-To: <20100611101803.GB12436@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 11, 2010 at 11:18:04AM +0100, Mark Brown wrote:
> On Fri, Jun 11, 2010 at 03:55:12PM +1000, Stuart Longland wrote:
> > The driver is accessible online at
> > <http://www.longlandclan.yi.org/~stuartl/asoc/> along with some comments
> > about how to add it to your kernel sources.  I'd appreciate any feedback
> > or advice on how the driver can be improved.
> 
> Please post to the mailing list if you want review - the standard
> workflow is to provide comments by replying to the patch.

Attached :- sound/soc/codecs/tlv320aic3204.c
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

--J/dobhs11T7y2rNN
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="tlv320aic3204.c"

/*
 * ALSA SoC TLV320AIC3204 codec driver
 *
 * Author:	Stuart Longland, <redhatter@gentoo.org>
 * Copyright:	(C) 2010 Jacques Electronics Pty. Ltd.
 *
 * Based upon the TLV320AIC3X driver:
 * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
 * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#ifndef DEBUG
#define DEBUG
#endif

#include <linux/device.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/i2c.h>
#include <linux/gpio.h>
#include <linux/regulator/consumer.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/initval.h>
#include <sound/tlv.h>
#include <sound/tlv320aic3204.h>

#include "tlv320aic3204.h"

/* TODO: PLL */
#define ENABLE_PLL

/* TODO: Make this configurable */
#define AIC3204_OSR		128

static int aic3204_read(struct snd_soc_codec *codec, unsigned int reg,
		      u8 *value);

/* SYSFS Interface -- we should move this to debugfs */
static ssize_t aic3204_show_regsel(struct device *dev,
		struct device_attribute *attr, char *buf);
static ssize_t aic3204_store_regsel(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count);
static ssize_t aic3204_show_regdata(struct device *dev,
		struct device_attribute *attr, char *buf);
static ssize_t aic3204_store_regdata(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count);
static DEVICE_ATTR(regsel, S_IWUSR | S_IRUGO,
		aic3204_show_regsel, aic3204_store_regsel);
static DEVICE_ATTR(regdata, S_IWUSR | S_IRUGO,
		aic3204_show_regdata, aic3204_store_regdata);

#define AIC3204_NUM_SUPPLIES	4
static const char *aic3204_supply_names[AIC3204_NUM_SUPPLIES] = {
	"IOVDD",	/* I/O Voltage */
	"DVDD",		/* Digital Core Voltage */
	"AVDD",		/* Analog DAC Voltage */
	"LDOin",	/* Supply for internal LDOs and output amplifiers */
};

/* codec private data */
struct aic3204_priv {
	struct snd_soc_codec codec;
	struct regulator_bulk_data supplies[AIC3204_NUM_SUPPLIES];
	unsigned int sysclk;
	int gpio_reset;

	/* ADC/DAC Channels enabled for use */
	u8 channels;

	/* For SYSFS; register selection */
	u16 sysfs_reg;
};

static int aic3204_read(struct snd_soc_codec *codec, unsigned int reg,
		      u8 *value);
/*
 * read aic3204 register cache
 */
static inline unsigned int aic3204_read_reg_cache(struct snd_soc_codec *codec,
						unsigned int reg)
{
	u8 *cache = codec->reg_cache;
	if (reg >= AIC3204_CACHEREGNUM) {
		dev_err( codec->dev, "%s: reg 0x%08x out of range!\n",
				__func__, reg );
		return -EINVAL;
	}

	if ( reg ) {
		/* Refresh cache */
		u8 val;
		int ret = aic3204_read( codec, reg, &val );
		if ( ret >= 0 )
			cache[reg] = val;
	}

	return cache[reg];
}

/*
 * write aic3204 register cache
 */
static inline void aic3204_write_reg_cache(struct snd_soc_codec *codec,
					 u16 reg, u8 value)
{
	u8 *cache = codec->reg_cache;

	if (reg >= AIC3204_CACHEREGNUM)
		return;
	cache[reg] = value;
}

/*
 * write to the aic3204 register space
 */
static int aic3204_write(struct snd_soc_codec *codec, unsigned int reg,
		       unsigned int value)
{
	/* data is
	 *   D15..D8 aic3204 register offset
	 *   D7...D0 register data
	 */
	u8 data[2];

	/*
	 * Register number; upper 8 bits indicate page
	 */
	if ( reg && (aic3204_read_reg_cache( codec, AIC3204_PAGE_SELECT ) 
			!= ( reg >> 7 )) ) {
		/* Select the required page */
		data[0] = 0;
		data[1] = reg >> 7;
		if (codec->hw_write(codec->control_data, data, 2) != 2)
			return -EIO;
		aic3204_write_reg_cache(codec, AIC3204_PAGE_SELECT, reg >> 7);
		dev_dbg( codec->dev, "%s: Page %d selected\n", 
				__func__, reg >> 7 );
	}

	data[0] = reg & 0x7f;
	data[1] = value & 0xff;

	if (codec->hw_write(codec->control_data, data, 2) != 2)
		return -EIO;

	dev_dbg( codec->dev, "%s: pg %d reg %d[%04x] <= %02x\n",
			__func__, reg >> 7, reg & 0x7f, reg, value);
	aic3204_write_reg_cache(codec, reg, value);
	return 0;
}

/*
 * read from the aic3204 register space
 */
static int aic3204_read(struct snd_soc_codec *codec, unsigned int reg,
		      u8 *value)
{
	*value = reg & 0x7f;

	/*
	 * Register number; upper 8 bits indicate page
	 */
	if ( reg && (aic3204_read_reg_cache( codec, AIC3204_PAGE_SELECT ) 
			!= ( reg >> 7 )) )
		/* Select the required page */
		aic3204_write( codec, AIC3204_PAGE_SELECT, (reg >> 7) );

	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);

#if 0
	dev_dbg( &codec->dev, "%s: pg %d reg %d[%04x] => %02x\n",
			__func__, reg >> 7, reg & 0xff, reg, value[0] );
#endif
	aic3204_write_reg_cache(codec, reg, *value);
	return 0;
}

/*
 * Perform a read/modify/write cycle on a register.
 *
 * This is a shorthand function, it reads the specified register, masks out the
 * bits in and_mask, applies bits in or_mask, then writes out the result to the
 * register.
 *
 * It returns the modified value; or a negative error code.
 */
static inline int aic3204_mod( struct snd_soc_codec *codec, unsigned int reg,
			u8 and_mask, u8 or_mask )
{
	int result;
	u8 value = aic3204_read_reg_cache( codec, reg );
	value &= and_mask;
	value |= or_mask;

	result = aic3204_write( codec, reg, value );
	if ( !result )
		result = value;
	return result;
}

static ssize_t aic3204_show_regsel(struct device *dev,
		struct device_attribute *attr, char *buf) {
	struct i2c_client *client = to_i2c_client(dev);
	struct aic3204_priv *aic3204 = i2c_get_clientdata(client);

	if ( aic3204 == NULL )
		return snprintf(buf, PAGE_SIZE, "no codec privdata!\n");

	return snprintf(buf, PAGE_SIZE, "0x%04x\n", aic3204->sysfs_reg );
}

static ssize_t aic3204_store_regsel(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count) {
	u16 reg = simple_strtoul( buf, NULL, 16 ) & 0xffff;
	struct i2c_client *client = to_i2c_client(dev);
	struct aic3204_priv *aic3204 = i2c_get_clientdata(client);

	if ( aic3204 == NULL )
		return 0;

	aic3204->sysfs_reg = reg;

	return strnlen(buf, PAGE_SIZE);
}

static ssize_t aic3204_show_regdata(struct device *dev,
		struct device_attribute *attr, char *buf) {
	u8 value;
	struct i2c_client *client = to_i2c_client(dev);
	struct aic3204_priv *aic3204 = i2c_get_clientdata(client);

	if ( aic3204 == NULL )
		return snprintf(buf, PAGE_SIZE, "no codec privdata!\n");

	/* Read the register */
	aic3204_read( &aic3204->codec, aic3204->sysfs_reg, &value);

	return snprintf(buf, PAGE_SIZE, "0x%02x\n", value );
}

static ssize_t aic3204_store_regdata(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count) {
	u8 value = simple_strtoul( buf, NULL, 16 ) & 0xff;
	struct i2c_client *client = to_i2c_client(dev);
	struct aic3204_priv *aic3204 = i2c_get_clientdata(client);

	if ( aic3204 == NULL )
		return 0;

	/* Write the register */
	aic3204_write( &aic3204->codec, aic3204->sysfs_reg, value);

	return strnlen(buf, PAGE_SIZE);
}

/* 
 * For MICPGA inputs; inputs may either be disconnected, or connected via one
 * of three resistances. 
 */
static const char *aic3204_micpga_input_mux[] = {
	"not-connected", "10k", "20k", "40k"
};

static struct soc_enum aic3204_enum_in1l_lmicpgap =
			SOC_ENUM_SINGLE(AIC3204_LMICPGAPROUTE,
				6, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in2l_lmicpgap =
			SOC_ENUM_SINGLE(AIC3204_LMICPGAPROUTE,
				4, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in3l_lmicpgap =
			SOC_ENUM_SINGLE(AIC3204_LMICPGAPROUTE,
				2, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in1r_lmicpgap =
			SOC_ENUM_SINGLE(AIC3204_LMICPGAPROUTE,
				0, 4, aic3204_micpga_input_mux);

static struct soc_enum aic3204_enum_cm1l_lmicpgan =
			SOC_ENUM_SINGLE(AIC3204_LMICPGANROUTE,
				6, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in2r_lmicpgan =
			SOC_ENUM_SINGLE(AIC3204_LMICPGANROUTE,
				4, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in3r_lmicpgan =
			SOC_ENUM_SINGLE(AIC3204_LMICPGANROUTE,
				2, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_cm2l_lmicpgan =
			SOC_ENUM_SINGLE(AIC3204_LMICPGANROUTE,
				0, 4, aic3204_micpga_input_mux);

static struct soc_enum aic3204_enum_in1r_rmicpgap =
			SOC_ENUM_SINGLE(AIC3204_RMICPGAPROUTE,
				6, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in2r_rmicpgap =
			SOC_ENUM_SINGLE(AIC3204_RMICPGAPROUTE,
				4, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in3r_rmicpgap =
			SOC_ENUM_SINGLE(AIC3204_RMICPGAPROUTE,
				2, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in2l_rmicpgap =
			SOC_ENUM_SINGLE(AIC3204_RMICPGAPROUTE,
				0, 4, aic3204_micpga_input_mux);

static struct soc_enum aic3204_enum_cm1r_rmicpgan =
			SOC_ENUM_SINGLE(AIC3204_RMICPGANROUTE,
				6, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in1l_rmicpgan =
			SOC_ENUM_SINGLE(AIC3204_RMICPGANROUTE,
				4, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_in3l_rmicpgan =
			SOC_ENUM_SINGLE(AIC3204_RMICPGANROUTE,
				2, 4, aic3204_micpga_input_mux);
static struct soc_enum aic3204_enum_cm2r_rmicpgan =
			SOC_ENUM_SINGLE(AIC3204_RMICPGANROUTE,
				0, 4, aic3204_micpga_input_mux);

/*
 * MICBIAS Voltages; The exact voltage depends on the common mode voltage
 * setting...
 *
 * 		CM=0.75V	CM=0.9V
 * 	Low	1.04V		1.25V
 * 	Medium	1.425V		1.7V
 * 	High	2.075V		2.5V
 * 	V+	Connects to power supply directly in both cases.
 */
static const char *aic3204_micbias_voltages[] = {
	"Low", "Med", "High", "V+"
};
static struct soc_enum aic3204_enum_micbias_voltage =
			SOC_ENUM_SINGLE(AIC3204_MICBIAS,
				4, 4, aic3204_micbias_voltages);

/*
 * MICBIAS Voltage Source
 */
static const char *aic3204_micbias_srcs[] = {
	"AVDD", "LDOIN"
};
static struct soc_enum aic3204_enum_micbias_src =
			SOC_ENUM_SINGLE(AIC3204_MICBIAS,
				3, 2, aic3204_micbias_srcs);

/*
 * DAC digital volumes. From -63.5 to +24 dB in 0.5 dB steps.
 * Does not mute control.
 */
static DECLARE_TLV_DB_SCALE(dac_tlv, -6350, 50, 0);
/* 
 * ADC gain volumes. From -12dB to 20 dB in 0.5dB steps.
 * Does not mute control.
 */
static DECLARE_TLV_DB_SCALE(adc_tlv, -1200, 50, 0);
#if 0
/*
 * ADC Fine gain volumes. From -0.4 to 0 dB in 0.1dB steps
 * Does not mute control.
 */
static DECLARE_TLV_DB_SCALE(adc_fine_tlv, -40, 10, 0);
#endif
/*
 * Output driver stage volumes; -6dB through to +29dB in 1dB steps
 * Does not mute control.
 */
static DECLARE_TLV_DB_SCALE(output_stage_tlv, -600, 100, 0);
/* 
 * MICPGA volumes; 0dB through to +47.5dB in 0.5dB steps.
 * Does not mute control
 */
static DECLARE_TLV_DB_SCALE(micpga_tlv, 0, 50, 0);

static const struct snd_kcontrol_new aic3204_snd_controls[] = {
	/* Output */

	/*
	 * Note regarding SOC_DOUBLE_R_SX_TLV...
	 *
	 * This is a bit misleading; xshift refers to the bit one bit *past*
	 * the most significant bit.  Or at least that's what it appears to be
	 * doing the math.  Mask needs to select the last 6 bits; which is the
	 * signed bitfield specifiying the gain in dB.
	 */
	SOC_DOUBLE_R_SX_TLV("Headphone Output Volume",
			 AIC3204_HPLGAIN, AIC3204_HPRGAIN,
			 6, -6, 29, output_stage_tlv),
	SOC_DOUBLE_R("Headphone Output Playback Switch",
		AIC3204_HPLGAIN, AIC3204_HPRGAIN,
		AIC3204_HPLGAIN_MUTE_SHIFT, 0x01, 1),
	SOC_DOUBLE_R_SX_TLV("Line Output Playback Volume",
			 AIC3204_LOLGAIN, AIC3204_LORGAIN,
			 6, -6, 29, output_stage_tlv),
	SOC_DOUBLE_R("Line Output Playback Switch", AIC3204_LOLGAIN, 
			AIC3204_LORGAIN, AIC3204_LOLGAIN_MUTE_SHIFT, 0x01, 1),
	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
			 AIC3204_LDACVOL, AIC3204_RDACVOL,
			 8, -127, 48, dac_tlv),
	SOC_DOUBLE("PCM Playback Switch", AIC3204_DACS2, 
			AIC3204_DACS2_LEFT_MUTE_SHIFT,
			AIC3204_DACS2_RIGHT_MUTE_SHIFT, 0x01, 1),
	SOC_DOUBLE_R_SX_TLV("Mixer Amplifier Volume",
			 AIC3204_MALGAIN, AIC3204_MARGAIN,
			 6, -6, 29, output_stage_tlv),

	/* MICPGA Options */
	SOC_DOUBLE_R_TLV("MICPGA Capture Volume",
			 AIC3204_LMICPGAVOL, AIC3204_RMICPGAVOL,
			 0, 95, 0, micpga_tlv),
	SOC_DOUBLE_R("MICPGA Capture Switch", 
			AIC3204_LMICPGAVOL, AIC3204_RMICPGAVOL, 7, 0x1, 1 ),

	/* MICBIAS Options */
	SOC_SINGLE("MICBIAS Enable", AIC3204_MICBIAS, 6, 0x1, 0 ),
	SOC_ENUM("MICBIAS Level", aic3204_enum_micbias_voltage ),
	SOC_ENUM("MICBIAS Source", aic3204_enum_micbias_src ),

	/* ADC */
	SOC_DOUBLE_R_SX_TLV("PCM Capture Volume",
			 AIC3204_LADCVOL, AIC3204_RADCVOL,
			 7, -24, 40, adc_tlv),
	SOC_DOUBLE("PCM Capture Switch", AIC3204_ADCFINE, 7, 3, 0x01, 1 ),

	/* Driver/Amplifier Selection -- DAPM should handle this! */
	SOC_DOUBLE("HP Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_HPL_UP_SHIFT,
			AIC3204_OUTDRV_HPR_UP_SHIFT, 0x1, 0 ),
	SOC_DOUBLE("LO Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_LOL_UP_SHIFT,
			AIC3204_OUTDRV_LOR_UP_SHIFT, 0x1, 0 ),
	SOC_DOUBLE("MA Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_MAL_UP_SHIFT,
			AIC3204_OUTDRV_MAR_UP_SHIFT, 0x1, 0 ),
};

/* Driver/Amplifier Selection */
static const struct snd_kcontrol_new aic3204_hpl_switch =
	SOC_DAPM_SINGLE("Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_HPL_UP_SHIFT, 0x1, 0 );
static const struct snd_kcontrol_new aic3204_hpr_switch =
	SOC_DAPM_SINGLE("Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_HPR_UP_SHIFT, 0x1, 0 );
static const struct snd_kcontrol_new aic3204_lol_switch =
	SOC_DAPM_SINGLE("Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_LOL_UP_SHIFT, 0x1, 0 );
static const struct snd_kcontrol_new aic3204_lor_switch =
	SOC_DAPM_SINGLE("Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_LOR_UP_SHIFT, 0x1, 0 );
static const struct snd_kcontrol_new aic3204_mal_switch =
	SOC_DAPM_SINGLE("Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_MAL_UP_SHIFT, 0x1, 0 );
static const struct snd_kcontrol_new aic3204_mar_switch =
	SOC_DAPM_SINGLE("Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_MAR_UP_SHIFT, 0x1, 0 );

/* Line Output Left Driver Inputs */
static const struct snd_kcontrol_new aic3204_lol_in_controls[] = {
	SOC_DAPM_SINGLE("LOR Switch", AIC3204_LOLROUTE,
			AIC3204_LOLROUTE_LOR_SHIFT, 1, 0 ),
	SOC_DAPM_SINGLE("MAL Switch", AIC3204_LOLROUTE,
			AIC3204_LOLROUTE_MAL_SHIFT, 1, 0 ),
	SOC_DAPM_SINGLE("LDAC+ Switch", AIC3204_LOLROUTE,
			AIC3204_LOLROUTE_LDACP_SHIFT, 1, 0 ),
	SOC_DAPM_SINGLE("RDAC- Switch", AIC3204_LOLROUTE,
			AIC3204_LOLROUTE_RDACN_SHIFT, 1, 0 ),
};

/* Line Output Right Driver Inputs */
static const struct snd_kcontrol_new aic3204_lor_in_controls[] = {
	SOC_DAPM_SINGLE("MAR Switch", AIC3204_LORROUTE,
			AIC3204_LORROUTE_MAR_SHIFT, 1, 0 ),
	SOC_DAPM_SINGLE("RDAC+ Switch", AIC3204_LORROUTE,
			AIC3204_LORROUTE_RDACP_SHIFT, 1, 0 ),
};

/* Headphone Output Left Driver Inputs */
static const struct snd_kcontrol_new aic3204_hpl_in_controls[] = {
	SOC_DAPM_SINGLE("MAR Switch", AIC3204_HPLROUTE,
			AIC3204_HPLROUTE_MAR_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("MAL Switch", AIC3204_HPLROUTE, 
			AIC3204_HPLROUTE_MAL_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("IN1L Switch", AIC3204_HPLROUTE, 
			AIC3204_HPLROUTE_IN1L_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("LDAC+ Switch", AIC3204_HPLROUTE, 
			AIC3204_HPLROUTE_LDACP_SHIFT, 0x1, 0 ),
};

/* Headphone Output Right Driver Inputs */
static const struct snd_kcontrol_new aic3204_hpr_in_controls[] = {
	SOC_DAPM_SINGLE("HPL Switch", AIC3204_HPRROUTE,
			AIC3204_HPRROUTE_HPL_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("MAR Switch", AIC3204_HPRROUTE,
			AIC3204_HPRROUTE_MAR_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("IN1R Switch", AIC3204_HPRROUTE,
			AIC3204_HPRROUTE_IN1R_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("RDAC+ Switch", AIC3204_HPRROUTE,
			AIC3204_HPRROUTE_RDACP_SHIFT, 0x1, 0 ),
	SOC_DAPM_SINGLE("LDAC- Switch", AIC3204_HPRROUTE,
			AIC3204_HPRROUTE_LDACN_SHIFT, 0x1, 0 ),
};

static const struct snd_kcontrol_new aic3204_lmicpgap_in_controls[] = {
	SOC_DAPM_ENUM("IN1L Switch", aic3204_enum_in1l_lmicpgap ),
	SOC_DAPM_ENUM("IN2L Switch", aic3204_enum_in2l_lmicpgap ),
	SOC_DAPM_ENUM("IN3L Switch", aic3204_enum_in3l_lmicpgap ),
	SOC_DAPM_ENUM("IN1R Switch", aic3204_enum_in1r_lmicpgap ),
};

static const struct snd_kcontrol_new aic3204_lmicpgan_in_controls[] = {
	SOC_DAPM_ENUM("CM1L Switch", aic3204_enum_cm1l_lmicpgan ),
	SOC_DAPM_ENUM("IN2R Switch", aic3204_enum_in2r_lmicpgan ),
	SOC_DAPM_ENUM("IN3R Switch", aic3204_enum_in3r_lmicpgan ),
	SOC_DAPM_ENUM("CM2L Switch", aic3204_enum_cm2l_lmicpgan ),
};

static const struct snd_kcontrol_new aic3204_rmicpgap_in_controls[] = {
	SOC_DAPM_ENUM("IN1R Switch", aic3204_enum_in1r_rmicpgap ),
	SOC_DAPM_ENUM("IN2R Switch", aic3204_enum_in2r_rmicpgap ),
	SOC_DAPM_ENUM("IN3R Switch", aic3204_enum_in3r_rmicpgap ),
	SOC_DAPM_ENUM("IN2L Switch", aic3204_enum_in2l_rmicpgap ),
};

static const struct snd_kcontrol_new aic3204_rmicpgan_in_controls[] = {
	SOC_DAPM_ENUM("CM1R Switch", aic3204_enum_cm1r_rmicpgan ),
	SOC_DAPM_ENUM("IN1L Switch", aic3204_enum_in1l_rmicpgan ),
	SOC_DAPM_ENUM("IN3L Switch", aic3204_enum_in3l_rmicpgan ),
	SOC_DAPM_ENUM("CM2R Switch", aic3204_enum_cm2r_rmicpgan ),
};

static const struct snd_soc_dapm_widget aic3204_dapm_widgets[] = {
	/* Driver/Amplifier Selection */
	SND_SOC_DAPM_SWITCH("HPL Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_HPL_UP_SHIFT, 0,
			&aic3204_hpl_switch ),
	SND_SOC_DAPM_SWITCH("HPR Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_HPR_UP_SHIFT, 0,
			&aic3204_hpr_switch ),
	SND_SOC_DAPM_SWITCH("LOL Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_LOL_UP_SHIFT, 0,
			&aic3204_lol_switch ),
	SND_SOC_DAPM_SWITCH("LOR Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_LOR_UP_SHIFT, 0,
			&aic3204_lor_switch ),
	SND_SOC_DAPM_SWITCH("MAL Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_MAL_UP_SHIFT, 0,
			&aic3204_mal_switch ),
	SND_SOC_DAPM_SWITCH("MAR Playback Switch", AIC3204_OUTDRV,
			AIC3204_OUTDRV_MAR_UP_SHIFT, 0,
			&aic3204_mar_switch ),
	/* Line Output Driver Inputs */
	SND_SOC_DAPM_MIXER("Left Line Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_lol_in_controls,
			ARRAY_SIZE(aic3204_lol_in_controls)),
	SND_SOC_DAPM_MIXER("Right Line Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_lor_in_controls,
			ARRAY_SIZE(aic3204_lor_in_controls)),
	/* Headphone Output Driver Inputs */
	SND_SOC_DAPM_MIXER("Left Headphone Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_hpl_in_controls,
			ARRAY_SIZE(aic3204_hpl_in_controls)),
	SND_SOC_DAPM_MIXER("Right Headphone Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_hpr_in_controls,
			ARRAY_SIZE(aic3204_hpr_in_controls)),
	/* DACs, ADCs and audio interfaces */
	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", AIC3204_DACS1,
			AIC3204_DACS1_LDAC_UP_SHIFT, 0),
	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", AIC3204_DACS1,
			AIC3204_DACS1_RDAC_UP_SHIFT, 0),
	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", AIC3204_ADCS,
			AIC3204_ADCS_RADC_UP_SHIFT, 0),
	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", AIC3204_ADCS,
			AIC3204_ADCS_RADC_UP_SHIFT, 0),
	SND_SOC_DAPM_AIF_IN("Left Data In", "Left Playback", 0, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_AIF_IN("Right Data In", "Right Playback", 1, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_AIF_OUT("Left Data Out", "Left Capture", 0, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_AIF_OUT("Right Data Out", "Right Capture", 1, SND_SOC_NOPM, 0, 0),
	/* MICPGA Input Sources */
	SND_SOC_DAPM_MIXER("Left MICPGA+ Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_lmicpgap_in_controls,
			ARRAY_SIZE(aic3204_lmicpgap_in_controls)),
	SND_SOC_DAPM_MIXER("Left MICPGA- Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_lmicpgan_in_controls,
			ARRAY_SIZE(aic3204_lmicpgan_in_controls)),
	SND_SOC_DAPM_MIXER("Right MICPGA+ Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_rmicpgap_in_controls,
			ARRAY_SIZE(aic3204_rmicpgap_in_controls)),
	SND_SOC_DAPM_MIXER("Right MICPGA- Output Mixer", SND_SOC_NOPM, 0, 0,
			aic3204_rmicpgan_in_controls,
			ARRAY_SIZE(aic3204_rmicpgan_in_controls)),
	SND_SOC_DAPM_PGA("Left MICPGA", SND_SOC_NOPM, 0, 0, NULL, 0 ),
	SND_SOC_DAPM_PGA("Right MICPGA", SND_SOC_NOPM, 0, 0, NULL, 0 ),
	SND_SOC_DAPM_MICBIAS("Mic Bias", AIC3204_MICBIAS, 6, 0),
	/* Bypass PGAs */
	SND_SOC_DAPM_PGA("IN1L Bypass PGA", SND_SOC_NOPM, 0, 0, NULL, 0 ),
	SND_SOC_DAPM_PGA("IN1R Bypass PGA", SND_SOC_NOPM, 0, 0, NULL, 0 ),
	/* Input Pins */
	SND_SOC_DAPM_INPUT("IN1L"),
	SND_SOC_DAPM_INPUT("IN1R"),
	SND_SOC_DAPM_INPUT("IN2L"),
	SND_SOC_DAPM_INPUT("IN2R"),
	SND_SOC_DAPM_INPUT("IN3L"),
	SND_SOC_DAPM_INPUT("IN3R"),
	/* Output Pins */
	SND_SOC_DAPM_OUTPUT("LOL"),
	SND_SOC_DAPM_OUTPUT("LOR"),
	SND_SOC_DAPM_OUTPUT("HPL"),
	SND_SOC_DAPM_OUTPUT("HPR"),
	/* Common-mode pins */
	SND_SOC_DAPM_VMID("CM1L"),
	SND_SOC_DAPM_VMID("CM1R"),
	SND_SOC_DAPM_VMID("CM2L"),
	SND_SOC_DAPM_VMID("CM2R"),
};

static const struct snd_soc_dapm_route intercon[] = {
	/* Data Connections */
	{"Left Data Out", NULL, "Left ADC"},
	{"Right Data Out", NULL, "Right ADC"},
	{"Left DAC", NULL, "Left Data In"},
	{"Right DAC", NULL, "Right Data In"},
	/* Line Output */
	{"Left Line Output Mixer", "LOR Switch", "Right Line Output Mixer"},
	{"Left Line Output Mixer", "MAL Switch", "Left MICPGA"},
	{"Left Line Output Mixer", "LDAC+ Switch", "Left DAC"},
	{"Left Line Output Mixer", "RDAC- Switch", "Right DAC"},
	{"Right Line Output Mixer", "MAR Switch", "Right MICPGA"},
	{"Right Line Output Mixer", "RDAC+ Switch", "Right DAC"},
	{"LOL", "LOL Playback Switch", "Left Line Output Mixer"},
	{"LOR", "LOR Playback Switch", "Right Line Output Mixer"},
	/* Headphone Output */
	{"Left Headphone Output Mixer", "MAR Switch", "Right MICPGA"},
	{"Left Headphone Output Mixer", "MAL Switch", "Left MICPGA"},
	{"Left Headphone Output Mixer", "IN1L Switch", "IN1L Bypass PGA"},
	{"Left Headphone Output Mixer", "LDAC+ Switch", "Left DAC"},
	{"Right Headphone Output Mixer", "HPL Switch", "Left Headphone Output Mixer"},
	{"Right Headphone Output Mixer", "MAR Switch", "Right MICPGA"},
	{"Right Headphone Output Mixer", "IN1R Switch", "IN1R Bypass PGA"},
	{"Right Headphone Output Mixer", "RDAC+ Switch", "Right DAC"},
	{"Right Headphone Output Mixer", "LDAC- Switch", "Left DAC"},
	{"HPL", "HPL Playback Switch", "Left Headphone Output Mixer"},
	{"HPR", "HPR Playback Switch", "Right Headphone Output Mixer"},
	/* MICPGA Input */
	{"Left MICPGA+ Output Mixer", "IN1L Switch", "IN1L"},
	{"Left MICPGA+ Output Mixer", "IN2L Switch", "IN2L"},
	{"Left MICPGA+ Output Mixer", "IN3L Switch", "IN3L"},
	{"Left MICPGA+ Output Mixer", "IN1R Switch", "IN1R"},
	{"Left MICPGA- Output Mixer", "CM1L Switch", "CM1L"},
	{"Left MICPGA- Output Mixer", "IN2R Switch", "IN2R"},
	{"Left MICPGA- Output Mixer", "IN3R Switch", "IN3R"},
	{"Left MICPGA- Output Mixer", "CM2L Switch", "CM2L"},
	{"Right MICPGA+ Output Mixer", "IN1R Switch", "IN1R"},
	{"Right MICPGA+ Output Mixer", "IN2R Switch", "IN2R"},
	{"Right MICPGA+ Output Mixer", "IN3R Switch", "IN3R"},
	{"Right MICPGA+ Output Mixer", "IN2L Switch", "IN2L"},
	{"Right MICPGA- Output Mixer", "CM1R Switch", "CM1R"},
	{"Right MICPGA- Output Mixer", "IN1L Switch", "IN1L"},
	{"Right MICPGA- Output Mixer", "IN3L Switch", "IN3L"},
	{"Right MICPGA- Output Mixer", "CM2R Switch", "CM2R"},
	{"Left MICPGA", "MAL Playback Switch", "Left MICPGA+ Output Mixer"},
	{"Right MICPGA", "MAR Playback Switch", "Right MICPGA+ Output Mixer"},
	{"Left MICPGA", "MAL Playback Switch", "Left MICPGA- Output Mixer"},
	{"Right MICPGA", "MAR Playback Switch", "Right MICPGA- Output Mixer"},
	{"Left ADC", NULL, "Left MICPGA"},
	{"Right ADC", NULL, "Right MICPGA"},
};

static int aic3204_add_widgets(struct snd_soc_codec *codec)
{
	snd_soc_dapm_new_controls(codec, aic3204_dapm_widgets,
				  ARRAY_SIZE(aic3204_dapm_widgets));

	/* set up audio path interconnects */
	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
	return 0;
}

static int aic3204_hw_params(struct snd_pcm_substream *substream,
			   struct snd_pcm_hw_params *params,
			   struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_device *socdev = rtd->socdev;
	struct snd_soc_codec *codec = socdev->card->codec;
	struct aic3204_priv *aic3204 = snd_soc_codec_get_drvdata(codec);
	int dac_clk = 0, bit_clk = 0;
	int codec_clk = 0, bypass_pll = 0, last_clk = 0, last_error = 0;
	u8 data = 0, ndac = 0, mdac = 0, pll_p = 1, pll_r = 1, pll_j = 1, bdiv = 1;
	u16 pll_d = 0;

	int this_clk = 0, this_error = 0;
	unsigned int this_abs_error;
	u8 j, this_ndac;
	u16 d;

	/* Determine the DAC clock and bit clock needed */
	dac_clk = AIC3204_OSR * params_rate(params);
	bit_clk = params_rate(params) * params_channels(params);

	/* 
	 * Select data word length.
	 * Note that the number of bits per frame used
	 * to determine BDIV is double the number of bits per sample, as there
	 * are two samples per frame.
	 */
	switch (params_format(params)) {
		case SNDRV_PCM_FORMAT_S16_LE:
			pr_debug("%s: Sample format 16 bits\n", __func__);
			bit_clk *= 16;
			data = AIC3204_AISR1_WL_16BITS;
			break;
		case SNDRV_PCM_FORMAT_S20_3LE:
			pr_debug("%s: Sample format 20 bits\n", __func__);
			bit_clk *= 32;
			data = AIC3204_AISR1_WL_20BITS;
			break;
		case SNDRV_PCM_FORMAT_S24_LE:
			pr_debug("%s: Sample format 24 bits\n", __func__);
			bit_clk *= 40;
			data = AIC3204_AISR1_WL_24BITS;
			break;
		case SNDRV_PCM_FORMAT_S32_LE:
			pr_debug("%s: Sample format 32 bits\n", __func__);
			bit_clk *= 48;
			data = AIC3204_AISR1_WL_32BITS;
			break;
	}
	aic3204_mod(codec, AIC3204_AISR1, ~AIC3204_AISR1_WL, data);

	pr_debug("%s: DAC Clock = %d Hz, Bit clock = %d Hz\n", __func__,
			dac_clk, bit_clk );

#ifndef ENABLE_PLL
	/* If PLL is disabled; always bypass the PLL */
	bypass_pll = 1;
#endif

	/* Try to find a value for div which allows us to bypass the PLL and
	 * generate CODEC_CLK directly. */
	for (this_ndac = 128; this_ndac >= 1; this_ndac--) {
		this_clk = aic3204->sysclk / this_ndac;
		
		if (this_clk == dac_clk) {
			pr_debug("%s: Scored exact match.  NDAC=%d; DAC_CLK=%d\n", 
					__func__, this_ndac, this_clk );
			bypass_pll = 1;
			ndac =  this_ndac;
			break;
#ifndef ENABLE_PLL
		} else {
			this_error = this_clk - dac_clk;
			this_abs_error = abs(this_error);
			pr_debug("%s: NDAC=%d; DAC_CLK=%d Error=%d\n", 
						__func__, this_ndac, 
						this_clk, this_error );
			if ( !last_clk || (this_abs_error < last_error) ) {
				last_clk = this_clk;
				last_error = this_abs_error;
				ndac = this_ndac;
			}
#endif
		}
	}

#ifdef ENABLE_PLL
	if (bypass_pll) {
#endif
		/* Select MCLK as CODEC_CLKIN */
		aic3204_write(codec, AIC3204_CLK1, AIC3204_CLK1_CODECCLK_MCLK );
		codec_clk = aic3204->sysclk;
#ifdef ENABLE_PLL
		goto setup_codec;
	}

	/*
	 * Determine PLL Parameters... the input/output frequency ratio
	 * of the PLL is given in the datasheet:
	 *
	 *   out   R * J * (D/10000)       J      D
	 *   --- = ----------------- = R * - * -------
	 *   in	          P                P    10000
	 *
	 * Limitations:
	 * - R range: 1..4
	 * - J range: 4..63
	 * - D range: 0..9999
	 * - P range: 1..8
	 * - If D == 0;
	 *   	512 kHz <= in / P <= 20 MHz
	 *   else
	 *   	10 MHz <= in / P <= 20 MHz
	 *
	 * We will try for 8* the target frequency; then use NDAC/NADC to divide
	 * that down.  If we set P = 1, and R = 1; we simplify the solution.
	 */
	pll_p = 1;
	pll_r = 1;
	for ( this_ndac = 1; this_ndac <= 128; this_ndac++ ) {
		int ratio, init_ratio;

		codec_clk = dac_clk * this_ndac;

		/* Ensure maximum CODEC frequency is not exceeded */
		if ( codec_clk > 137000000 ) continue;
		if ( ( this_ndac % 2 ) && ( codec_clk > 110000000 ) ) continue;

		/* Initial Fixed-point ratio ... this will be slightly lower */
		init_ratio = codec_clk / ( aic3204->sysclk / 10000 );

		pr_debug("%s: NDAC = %d, PLL J.D * 10000 = %d\n", 
				__func__, this_ndac, init_ratio );
		if ( init_ratio < 40000 ) continue;
		if ( init_ratio > 639999 ) continue;

		for( ratio = init_ratio; (ratio < init_ratio + 10000) 
				&& (ratio < 639999); ratio++ ) {
			j = ratio / 10000;
			d = ratio % 10000;

			this_clk = aic3204->sysclk / 10000;
			this_clk *= (10000 * j) + d;
			this_error = this_clk - codec_clk;
			this_abs_error = abs(this_error);

			if ( this_abs_error > 1000 ) continue;

			pr_debug("%s: Fractional PLL search; "
					"P=%d R=%d J=%d D=%04d => "
					"(%d * %d) / 10000 => %d "
					"(%d error) [NDAC=%d]\n",
					__func__, pll_p, pll_r, j, d, aic3204->sysclk,
					ratio, this_clk, this_error, this_ndac);
			if ( !last_clk || (this_abs_error < last_error) ) {
				last_clk = this_clk;
				last_error = this_abs_error;
				ndac = this_ndac;
				pll_j = j;
				pll_d = d;
				/* Early finish for exact match */
				if ( ! this_abs_error )
					break;
			}
		}
	}

	/* If we still haven't found anything; bail out here! */
	if ( !last_clk ) goto fail;

	pr_debug("%s: Best Output: %d (%d Hz Error)\n",
			__func__, last_clk, last_error );
	pr_debug( "%s: setting up PLL: P=%d R=%d J.D=%d.%04d\n",
			__func__, pll_p, pll_r, pll_j, pll_d );

	codec_clk = last_clk;

	aic3204_write(codec, AIC3204_CLK4, (pll_d >> AIC3204_CLK4_PLL_D_VSHIFT) 
			& AIC3204_CLK4_PLL_D); 		/* PLL D[14:8] */
	aic3204_write(codec, AIC3204_CLK5, pll_d & AIC3204_CLK5_PLL_D);
							/* PLL D[7:0] */
	aic3204_write(codec, AIC3204_CLK3, pll_j & AIC3204_CLK3_PLL_J);
							/* PLL J */
	aic3204_write(codec, AIC3204_CLK2,	
			( pll_r & AIC3204_CLK2_PLL_R )	/* PLL R */
			| ( ( pll_p << AIC3204_CLK2_PLL_P_SHIFT ) 
				& AIC3204_CLK2_PLL_P )
							/* PLL P */
			| AIC3204_CLK2_PLL_ON );	/* PLL on */

	/* Select PLL as CODEC_CLKIN */
	aic3204_write(codec, AIC3204_CLK1, AIC3204_CLK1_CODECCLK_PLL );

setup_codec:
#endif
	pr_debug("%s: CODEC CLK = %d => DAC CLK = %d\n",
		__func__, codec_clk, codec_clk / ndac );
	/* Calculate BDIV and NDAC */
	mdac = codec_clk / (ndac * dac_clk);
	if ( !mdac ) mdac = 1;

	bdiv = dac_clk / bit_clk;
	if ( !bdiv ) bdiv = 1;

	/* Set AOSR and DOSR */
	aic3204_write(codec, AIC3204_DOSR1, 
			(AIC3204_OSR >> AIC3204_DOSR1_MSB_VSHIFT) 
			& AIC3204_DOSR1_MSB );			/* DOSR[9:8] */
	aic3204_write(codec, AIC3204_DOSR2, AIC3204_OSR 
			& AIC3204_DOSR2_LSB );			/* DOSR[7:0] */
	aic3204_write(codec, AIC3204_AOSR, AIC3204_OSR);	/* AOSR */

	pr_debug("%s: NDAC = %d\n", __func__, ndac);
	/* Set NDAC to divider value */
	aic3204_write(codec, AIC3204_CLK6, AIC3204_CLK6_NDAC_STATE_ON | ndac );
	/* Set NADC to match NDAC */
	aic3204_write(codec, AIC3204_CLK8, AIC3204_CLK8_NADC_STATE_ON | ndac );
	/* Set MDAC and turn on */
	aic3204_write(codec, AIC3204_CLK7, AIC3204_CLK7_MDAC_STATE_ON | mdac );
	/* Use MDAC for MADC */
	aic3204_write(codec, AIC3204_CLK9, AIC3204_CLK7_MDAC_STATE_ON | mdac );

	/* Set BCLK and WCLK */
	pr_debug("%s: Bit clock divider = %d\n", __func__, bdiv);
	/* Turn on and set BCLK N divider */
	aic3204_write(codec, AIC3204_CLK12, bdiv
			| AIC3204_CLK12_BCLK_STATE_ON );
	
	/* Set BCLK and WCLK sources */
	aic3204_mod(codec, AIC3204_AISR3, ~AIC3204_AISR3_BDIV,
			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
				? AIC3204_AISR3_BDIV_DAC
				: AIC3204_AISR3_BDIV_ADC );
	aic3204_mod(codec, AIC3204_AISR6, ~AIC3204_AISR6_WCLKOUT,
			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
				? AIC3204_AISR6_WCLKOUT_DAC
				: AIC3204_AISR6_WCLKOUT_ADC );
	return 0;
fail:
	printk(KERN_ERR "%s(): unable to setup PLL\n", __func__);
	return -EINVAL;
}

static int aic3204_mute(struct snd_soc_dai *dai, int mute)
{
	struct snd_soc_codec *codec = dai->codec;
	u8 dacs2;

	dacs2 = aic3204_read_reg_cache(codec, AIC3204_DACS2);

	if (mute) {
		dacs2 	|= (1 << AIC3204_DACS2_LEFT_MUTE_SHIFT)
			| (1 << AIC3204_DACS2_RIGHT_MUTE_SHIFT);
	} else {
		dacs2 	&= ~((1 << AIC3204_DACS2_LEFT_MUTE_SHIFT)
			| (1 << AIC3204_DACS2_RIGHT_MUTE_SHIFT));
	}

	aic3204_write(codec, AIC3204_DACS2, dacs2 );	/* Unmute DAC */
	return 0;
}

static int aic3204_set_dai_sysclk(struct snd_soc_dai *codec_dai,
				int clk_id, unsigned int freq, int dir)
{
	struct snd_soc_codec *codec = codec_dai->codec;
	struct aic3204_priv *aic3204 = snd_soc_codec_get_drvdata(codec);

	aic3204->sysclk = freq;
	return 0;
}

static int aic3204_set_dai_fmt(struct snd_soc_dai *codec_dai,
			     unsigned int fmt)
{
	struct snd_soc_codec *codec = codec_dai->codec;
	u8 aisr1 = 0, aisr2 = 0, aisr3 = 0;

	/* set master/slave audio interface */
	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
		case SND_SOC_DAIFMT_CBM_CFM:
			aisr1	|= AIC3204_AISR1_BCLK_OUT
				| AIC3204_AISR1_WCLK_OUT;
			break;
		case SND_SOC_DAIFMT_CBM_CFS:
			aisr1	|= AIC3204_AISR1_BCLK_OUT
				| AIC3204_AISR1_WCLK_IN;
			break;
		case SND_SOC_DAIFMT_CBS_CFM:
			aisr1	|= AIC3204_AISR1_BCLK_IN
				| AIC3204_AISR1_WCLK_OUT;
			break;
		case SND_SOC_DAIFMT_CBS_CFS:
			aisr1	|= AIC3204_AISR1_BCLK_IN
				| AIC3204_AISR1_WCLK_IN;
			break;
		default:
			printk( KERN_ERR "%s: Clock mode not supported "
				"(fmt=0x%08x)\n", __func__, fmt );
			return -EINVAL;
	}

	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
		case SND_SOC_DAIFMT_I2S:
			aisr1	|= AIC3204_AISR1_INT_I2S;
			break;
		case SND_SOC_DAIFMT_DSP_A:
			aisr2 = 1;
		case SND_SOC_DAIFMT_DSP_B:
			aisr1	|= AIC3204_AISR1_INT_DSP;
			break;
		case SND_SOC_DAIFMT_RIGHT_J:
			aisr1 |= AIC3204_AISR1_INT_RJF;
			break;
		case SND_SOC_DAIFMT_LEFT_J:
			aisr1 |= AIC3204_AISR1_INT_LJF;
			break;
		default:
			printk( KERN_ERR "%s: SSI mode not supported "
				"(fmt=0x%08x)\n", __func__, fmt );
			return -EINVAL;
	}

	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
		case SND_SOC_DAIFMT_NB_NF:
			aisr3	|= AIC3204_AISR3_BCLKPOL_NOR;
			break;
		case SND_SOC_DAIFMT_IB_NF:
			aisr3	|= AIC3204_AISR3_BCLKPOL_INV;
			break;
		default:
			printk( KERN_ERR "%s: Clock inversion mode not "
				"supported (fmt=0x%08x)\n", __func__, fmt );
			return -EINVAL;
	}

	/* set iface */
	aic3204_write(codec, AIC3204_AISR1, aisr1);
	aic3204_write(codec, AIC3204_AISR2, aisr2);
	aic3204_write(codec, AIC3204_AISR3, aisr3);

	return 0;
}

static int aic3204_set_bias_level(struct snd_soc_codec *codec,
				enum snd_soc_bias_level level)
{
#if 0
	switch (level) {
		case SND_SOC_BIAS_ON:
		case SND_SOC_BIAS_PREPARE:
			printk("%s: Powering up ADC/DAC\n", __func__);
			/* Turn on ADC and DAC */
			aic3204_write(codec, AIC3204_DACS1,
					AIC3204_DACS1_LDAC_UP |
					AIC3204_DACS1_RDAC_UP |
					AIC3204_DACS1_LDACD_LEFT |
					AIC3204_DACS1_RDACD_RIGHT |
					AIC3204_DACS1_SOFT_DIS );

			/* TODO; put these registers into the header */
			aic3204_write(codec, AIC3204_PGREG(0, 81), 0xc0 );
			break;
		case SND_SOC_BIAS_STANDBY:
		case SND_SOC_BIAS_OFF:
			printk("%s: Powering down ADC/DAC\n", __func__);
			/* Turn off ADC and DAC */
			aic3204_write(codec, AIC3204_DACS1, 0 );
			/* TODO; put these registers into the header */
			aic3204_write(codec, AIC3204_PGREG(0, 81), 0 );
			break;
	}
#endif
	codec->bias_level = level;
	return 0;
}

#define AIC3204_RATES	SNDRV_PCM_RATE_8000_96000
#define AIC3204_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

static struct snd_soc_dai_ops aic3204_dai_ops = {
	.hw_params	= aic3204_hw_params,
	.digital_mute	= aic3204_mute,
	.set_sysclk	= aic3204_set_dai_sysclk,
	.set_fmt	= aic3204_set_dai_fmt,
};

struct snd_soc_dai aic3204_dai = {
	.name = "tlv320aic3204",
	.playback = {
		.stream_name = "Playback",
		.channels_min = 1,
		.channels_max = 2,
		.rates = AIC3204_RATES,
		.formats = AIC3204_FORMATS,},
	.capture = {
		.stream_name = "Capture",
		.channels_min = 1,
		.channels_max = 2,
		.rates = AIC3204_RATES,
		.formats = AIC3204_FORMATS,},
	.ops = &aic3204_dai_ops,
};
EXPORT_SYMBOL_GPL(aic3204_dai);

static int aic3204_suspend(struct platform_device *pdev, pm_message_t state)
{
	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
	struct snd_soc_codec *codec = socdev->card->codec;

	aic3204_set_bias_level(codec, SND_SOC_BIAS_OFF);

	return 0;
}

static int aic3204_resume(struct platform_device *pdev)
{
	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
	struct snd_soc_codec *codec = socdev->card->codec;
	int i;
	u8 data[2];
	u8 *cache = codec->reg_cache;

	/* Sync reg_cache with the hardware */
	for (i = 0; i < AIC3204_CACHEREGNUM; i++) {
		data[0] = i;
		data[1] = cache[i];
		codec->hw_write(codec->control_data, data, 2);
	}

	aic3204_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

	return 0;
}

/*
 * initialise the AIC3204 driver
 * register the mixer and dsp interfaces with the kernel
 */
static int aic3204_init(struct snd_soc_codec *codec)
{
	int reg;

	mutex_init(&codec->mutex);
	INIT_LIST_HEAD(&codec->dapm_widgets);
	INIT_LIST_HEAD(&codec->dapm_paths);

	codec->name = "tlv320aic3204";
	codec->owner = THIS_MODULE;
	codec->read = aic3204_read_reg_cache;
	codec->write = aic3204_write;
	codec->set_bias_level = aic3204_set_bias_level;
	codec->dai = &aic3204_dai;
	codec->num_dai = 1;
	codec->reg_cache_size = AIC3204_CACHEREGNUM;
	codec->reg_cache = kmalloc(AIC3204_CACHEREGNUM, GFP_KERNEL);
	if (codec->reg_cache == NULL)
		return -ENOMEM;

	/* Reset the CODEC */
	aic3204_write(codec, AIC3204_RESET, AIC3204_RESET_SOFT);

	/* Read in the cache */
	for( reg=0; reg < AIC3204_CACHEREGNUM; reg++ ) {
		u8 temp;
		aic3204_read( codec, reg, &temp );
	}

	return 0;
}

static struct snd_soc_codec *aic3204_codec;

static int aic3204_register(struct snd_soc_codec *codec)
{
	int ret;

	ret = aic3204_init(codec);
	if (ret < 0) {
		dev_err(codec->dev, "Failed to initialise device\n");
		return ret;
	}

	aic3204_codec = codec;

	ret = snd_soc_register_codec(codec);
	if (ret) {
		dev_err(codec->dev, "Failed to register codec\n");
		return ret;
	}

	ret = snd_soc_register_dai(&aic3204_dai);
	if (ret) {
		dev_err(codec->dev, "Failed to register dai\n");
		snd_soc_unregister_codec(codec);
		return ret;
	}

	return 0;
}

static int aic3204_unregister(struct aic3204_priv *aic3204)
{
	aic3204_set_bias_level(&aic3204->codec, SND_SOC_BIAS_OFF);

	snd_soc_unregister_dai(&aic3204_dai);
	snd_soc_unregister_codec(&aic3204->codec);

	if (aic3204->gpio_reset >= 0) {
		gpio_set_value(aic3204->gpio_reset, 0);
		gpio_free(aic3204->gpio_reset);
	}
	regulator_bulk_disable(ARRAY_SIZE(aic3204->supplies), aic3204->supplies);
	regulator_bulk_free(ARRAY_SIZE(aic3204->supplies), aic3204->supplies);

	kfree(aic3204);
	aic3204_codec = NULL;

	return 0;
}

#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
/*
 * If the i2c layer weren't so broken, we could pass this kind of data
 * around
 */
static int aic3204_i2c_probe(struct i2c_client *i2c,
			   const struct i2c_device_id *id)
{
	struct snd_soc_codec *codec;
	struct aic3204_priv *aic3204;
	struct aic3204_pdata *pdata = i2c->dev.platform_data;
	int ret, i;

	aic3204 = kzalloc(sizeof(struct aic3204_priv), GFP_KERNEL);
	if (aic3204 == NULL) {
		dev_err(&i2c->dev, "failed to create private data\n");
		return -ENOMEM;
	}

	codec = &aic3204->codec;
	codec->dev = &i2c->dev;
	snd_soc_codec_set_drvdata(codec, aic3204);
	codec->control_data = i2c;
	codec->hw_write = (hw_write_t) i2c_master_send;

	i2c_set_clientdata(i2c, aic3204);

	aic3204->gpio_reset = -1;
	if (pdata && pdata->gpio_reset >= 0) {
		ret = gpio_request(pdata->gpio_reset, "tlv320aic3204 reset");
		if (ret != 0)
			goto err_gpio;
		aic3204->gpio_reset = pdata->gpio_reset;
		gpio_direction_output(aic3204->gpio_reset, 0);
	}
	/* Initialise the channel configuration ; enable all channels */
	aic3204->channels = AIC3204_LDAC_EN | AIC3204_RDAC_EN
		| AIC3204_LADC_EN | AIC3204_RADC_EN;

	for (i = 0; i < ARRAY_SIZE(aic3204->supplies); i++)
		aic3204->supplies[i].supply = aic3204_supply_names[i];

	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3204->supplies),
				 aic3204->supplies);
	if (ret != 0) {
		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
		goto err_get;
	}

	ret = regulator_bulk_enable(ARRAY_SIZE(aic3204->supplies),
				    aic3204->supplies);
	if (ret != 0) {
		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
		goto err_enable;
	}

	if (aic3204->gpio_reset >= 0) {
		udelay(1);
		gpio_set_value(aic3204->gpio_reset, 1);
	}

	if ( device_create_file( &i2c->dev, &dev_attr_regsel ) )
		dev_dbg( &i2c->dev, "%s: failed to register sysfs"
				"file for I2C register selection\n",
				__func__);

	if ( device_create_file( &i2c->dev, &dev_attr_regdata ) )
		dev_dbg( &i2c->dev, "%s: failed to register sysfs"
				"file for I2C register data\n",
				__func__);
	return aic3204_register(codec);

err_enable:
	regulator_bulk_free(ARRAY_SIZE(aic3204->supplies), aic3204->supplies);
err_get:
	if (aic3204->gpio_reset >= 0)
		gpio_free(aic3204->gpio_reset);
err_gpio:
	kfree(aic3204);
	return ret;
}

static int aic3204_i2c_remove(struct i2c_client *client)
{
	struct aic3204_priv *aic3204 = i2c_get_clientdata(client);

	return aic3204_unregister(aic3204);
}

static const struct i2c_device_id aic3204_i2c_id[] = {
	{ "tlv320aic3204", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, aic3204_i2c_id);

/* machine i2c codec control layer */
static struct i2c_driver aic3204_i2c_driver = {
	.driver = {
		.name = "tlv320aic3204-i2c",
		.owner = THIS_MODULE,
	},
	.probe	= aic3204_i2c_probe,
	.remove = aic3204_i2c_remove,
	.id_table = aic3204_i2c_id,
};

static inline void aic3204_i2c_init(void)
{
	int ret;

	ret = i2c_add_driver(&aic3204_i2c_driver);
	if (ret)
		printk(KERN_ERR "%s: error regsitering i2c driver, %d\n",
		       __func__, ret);
}

static inline void aic3204_i2c_exit(void)
{
	i2c_del_driver(&aic3204_i2c_driver);
}
#else
static inline void aic3204_i2c_init(void) { }
static inline void aic3204_i2c_exit(void) { }
#endif

static int aic3204_probe(struct platform_device *pdev)
{
	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
	struct aic3204_setup_data *setup;
	struct snd_soc_codec *codec;
	int ret = 0;

	codec = aic3204_codec;
	if (!codec) {
		dev_err(&pdev->dev, "Codec not registered\n");
		return -ENODEV;
	}

	socdev->card->codec = codec;
	setup = socdev->codec_data;

	if (setup) {
		struct aic3204_priv *aic3204 = snd_soc_codec_get_drvdata(codec);

		/* Run setup script; if any */
		if ( setup->init_reg_list ) {
			int length = setup->init_reg_length;
			const struct aic3204_init_reg *init_reg = 
				setup->init_reg_list;
			while( length-- ) {
				int ret = 0;
				u8 regval = aic3204_read_reg_cache( codec, init_reg->reg );
				switch ( init_reg->flags & 
						AIC3204_INITFLAG_OPMASK ) {
					case AIC3204_INITFLAG_SET:
						regval = init_reg->value;
						break;
					case AIC3204_INITFLAG_AND:
						regval &= init_reg->value;
						break;
					case AIC3204_INITFLAG_OR:
						regval |= init_reg->value;
						break;
					case AIC3204_INITFLAG_XOR:
						regval ^= init_reg->value;
						break;
					case AIC3204_INITFLAG_FAILNEQ:
						if ( regval != init_reg->value )
							ret = -EIO;
						else
							ret = 1;
						break;
					case AIC3204_INITFLAG_FAILEQ:
						if ( regval == init_reg->value )
							ret = -EIO;
						else
							ret = 1;
						break;
					case AIC3204_INITFLAG_FAILNSET:
						if ( !( regval & init_reg->value ) )
							ret = -EIO;
						else
							ret = 1;
						break;
					case AIC3204_INITFLAG_FAILSET:
						if ( regval & init_reg->value )
							ret = -EIO;
						else
							ret = 1;
						break;
					case AIC3204_INITFLAG_FAILNCLR:
						if ( ( regval | init_reg->value ) != 0xff )
							ret = -EIO;
						else
							ret = 1;
						break;
					case AIC3204_INITFLAG_FAILCLR:
						if ( ( regval & init_reg->value ) == 0xff )
							ret = -EIO;
						else
							ret = 1;
						break;
					default:
						printk( KERN_ERR "%s: Instruction "
							"not understood\n", __func__ );
						ret = -EINVAL;
				}
				if ( !ret )
					ret = aic3204_write(codec,
							init_reg->reg,
							regval );
				if ( ret < 0 ) {
					printk( KERN_ERR "%s: Initialisation operation "
							"reg=0x%04x flags=0x%02x value=0x%02x "
							"returns %d\n", __func__,
							init_reg->reg, init_reg->flags,
							init_reg->value, ret );
					return ret;
				}
				/* Move to next instruction */
				init_reg++;
			}
		}

		/* Copy over channel information */
		aic3204->channels = setup->channels;
	}

	/* register pcms */
	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
	if (ret < 0) {
		printk(KERN_ERR "aic3204: failed to create pcms\n");
		goto pcm_err;
	}

	snd_soc_add_controls(codec, aic3204_snd_controls,
			     ARRAY_SIZE(aic3204_snd_controls));

	aic3204_add_widgets(codec);

	return ret;

pcm_err:
	kfree(codec->reg_cache);
	return ret;
}

static int aic3204_remove(struct platform_device *pdev)
{
	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
	struct snd_soc_codec *codec = socdev->card->codec;

	/* power down chip */
	if (codec->control_data)
		aic3204_set_bias_level(codec, SND_SOC_BIAS_OFF);

	snd_soc_free_pcms(socdev);
	snd_soc_dapm_free(socdev);

	kfree(codec->reg_cache);

	return 0;
}

struct snd_soc_codec_device soc_codec_dev_aic3204 = {
	.probe = aic3204_probe,
	.remove = aic3204_remove,
	.suspend = aic3204_suspend,
	.resume = aic3204_resume,
};
EXPORT_SYMBOL_GPL(soc_codec_dev_aic3204);

static int __init aic3204_modinit(void)
{
	aic3204_i2c_init();

	return 0;
}
module_init(aic3204_modinit);

static void __exit aic3204_exit(void)
{
	aic3204_i2c_exit();
}
module_exit(aic3204_exit);

MODULE_DESCRIPTION("ASoC TLV320AIC3204 codec driver");
MODULE_AUTHOR("Jacques Electronics");
MODULE_LICENSE("GPL");

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--J/dobhs11T7y2rNN--
