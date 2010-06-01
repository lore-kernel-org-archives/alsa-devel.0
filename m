From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 1 Jun 2010 21:32:38 +1000
Message-ID: <20100601113224.GA14493@www.longlandclan.yi.org>
References: <1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
	<20100601033023.GA24820@www.longlandclan.yi.org>
	<20100601050731.GB24820@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id D2382103A07
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 13:32:54 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OJPiC-00051l-Jy
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 21:32:51 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OJPi3-0004zi-LJ
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 21:32:48 +1000
Content-Disposition: inline
In-Reply-To: <20100601050731.GB24820@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For the benefit of those working with the TLV320AIC3204 CODEC, I release
this *very experimental* and incomplete driver to hopefully encourage
further work.  I haven't made it available as a patch; rather just
attached the driver and its header file, since the driver is far from
complete.  These files go in sound/soc/codecs, with appropriate entries
into Kconfig and Makefile.

Presently, I'm working on defining all the registers, and considering
methods for allowing their configuration via the APIs available.

The TLV320AIC3204 CODEC exposes its registers in individual "pages"; the
first register (reg 0) is the page select register, the remaining
registers change in meaning depending on what page is selected.  In the
CODEC driver, I therefore use a 16-bit addressing scheme, whereby the
upper 8-bits indicates the page number, and the lower 8-bits is the
actual register address used.  Page select is *always* at register
0x0000 in cache.  When a register on a different page is accessed, the
page is switched first before accessing the register.  I'm not certain
if this is the best approach; but it was the only way that made sense.

The CODEC driver claims total control of the I2C device, and therefore
makes it impossible to alter registers using i2c-tools.  However, as a
work-around; I have provided read/write access to the registers via
sysfs... we use the AIC3204 attached to I2C bus 0; the CODEC therefore
lives under:

	/sys/bus/i2c/devices/0-0018

There are two files:
	- regsel:	Takes or reports back the 16-bit register
			address in hexadecimal
	- regdata:	Reads or writes the value of the register

`i2cget -y 0 0x18` and `i2cset -y 0 0x18` can be replaced by the
following shell functions:

acget () {
	printf "0x%02x%02x\n" $1 > /sys/bus/i2c/devices/0-0018/regsel
	cat /sys/bus/i2c/devices/0-0018/regdata
}

acset () {
	printf "0x%02x%02x\n" $1 > /sys/bus/i2c/devices/0-0018/regsel
	printf "0x%02x\n" $2 > /sys/bus/i2c/devices/0-0018/regdata
}

At most, to get sound out, you may need to use the above two functions
to set your routing and levels.  Register dumps can also be done using
shell scripting, although it's slower than the i2cdump tool.

Other things that need work;
- PLL support doesn't seem to work ... this will need adjustment
- Sample rates are "off"... 48kHz audio gets played at ~52kHz for
  example (see above comment about PLL)
- Routing is hard-coded at present
- In my testing, sound output is low in amplitude

I hope to address some of these over this week, but in the meantime I'll
provide my work in its current form in the hope that we can build upon
this and improve it for inclusion in the Linux kernel.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

--R3G7APHDIzY6R/pk
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="tlv320aic3204.h"

/*
 * ALSA SoC TLV320AIC3204 codec driver
 *
 * Author:	Stuart Longland, <redhatter@gentoo.org>
 * Copyright:	(C) 2010 Jacques Electronics, Pty, Ltd.
 *
 * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
 * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#ifndef _AIC3204_H
#define _AIC3204_H

/*
 * The AIC3204's registers are divided into separate pages, the first page of
 * every register is a "page select", which sets the current page being
 * accessed.  For the purposes of simplicity; we shall consider all registers
 * as being addressed by a 16-bit value, consisting of the page number as
 * most-significant 8 bits, followed by the register number as given in the
 * datasheet.
 *
 * The register access functions will look after page flipping from here.
 */

/* AIC3204 register space -- we cache the first two pages */
#define AIC3204_CACHEREGNUM		512

/* Page select register */
#define AIC3204_PAGE_SELECT		0

/* Register Page/Number => Address Mapping Macro */
#define AIC3204_PGREG(page,reg)		(((page) << 8) | ((reg) & 0xff))

/* Software reset register */
#define AIC3204_RESET			AIC3204_PGREG(0, 1)
/* Perform software reset */
#define AIC3204_RESET_SOFT		1

/* Clock Setting Register 1, Multiplexers */
#define AIC3204_CLK1			AIC3204_PGREG(0, 4)
/* PLL Range Select: Low Range */
#define AIC3204_CLK1_PLLRANGE_LOW	(0 << 6)
/* PLL Range Select: High Range */
#define AIC3204_CLK1_PLLRANGE_HIGH	(1 << 6)
/* PLL Range Select Mask */
#define AIC3204_CLK1_PLLRANGE		(1 << 6)
/* PLL Input Clock Select: MCLK */
#define AIC3204_CLK1_PLLSRC_MCLK	(0 << 2)
/* PLL Input Clock Select: BCLK */
#define AIC3204_CLK1_PLLSRC_BCLK	(1 << 2)
/* PLL Input Clock Select: GPIO */
#define AIC3204_CLK1_PLLSRC_GPIO	(2 << 2)
/* PLL Input Clock Select: Data In */
#define AIC3204_CLK1_PLLSRC_DIN		(3 << 2)
/* PLL Input Clock Select Mask */
#define AIC3204_CLK1_PLLSRC		(3 << 2)
/* CODEC Clock Source Select: MCLK */
#define AIC3204_CLK1_CODECCLK_MCLK	(0)
/* CODEC Clock Source Select: BCLK */
#define AIC3204_CLK1_CODECCLK_BCLK	(1)
/* CODEC Clock Source Select: GPIO */
#define AIC3204_CLK1_CODECCLK_GPIO	(2)
/* CODEC Clock Source Select: PLL */
#define AIC3204_CLK1_CODECCLK_PLL	(3)
/* CODEC Clock Source Select Mask */
#define AIC3204_CLK1_CODECCLK		(3)

/* Clock Setting Register 2, PLL P & R Values */
#define AIC3204_CLK2			AIC3204_PGREG(0, 5)
/* PLL State: Powered Down */
#define AIC3204_CLK2_PLL_OFF		(0 << 7)
/* PLL State: Powered Up */
#define AIC3204_CLK2_PLL_ON		(1 << 7)
/* PLL State Mask */
#define AIC3204_CLK2_PLL		(1 << 7)
/* PLL P Divider value bitfield location */
#define AIC3204_CLK2_PLL_P_SHIFT	(4)
/* PLL P Divider value bitfield mask */
#define AIC3204_CLK2_PLL_P		(7 << 4)
/* PLL R Divider value bitfield location */
#define AIC3204_CLK2_PLL_R_SHIFT	(0)
/* PLL R Divider value bitfield mask */
#define AIC3204_CLK2_PLL_R		(0xf)

/* Clock Setting Register 3, PLL J Values */
#define AIC3204_CLK3			AIC3204_PGREG(0, 6)
/* PLL J Divider value bitfield location */
#define AIC3204_CLK3_PLL_J_SHIFT	(0)
/* PLL J Divider value bitfield mask */
#define AIC3204_CLK3_PLL_J		(0x3f)

/* Clock Setting Register 4, PLL D MSB */
#define AIC3204_CLK4			AIC3204_PGREG(0, 7)
/* PLL D most significant portion bitfield location */
#define AIC3204_CLK4_PLL_D_SHIFT	(0)
/* PLL D most significant portion bitfield mask */
#define AIC3204_CLK4_PLL_D		(0x3f)
/* PLL D most significant portion value shift */
#define AIC3204_CLK4_PLL_D_VSHIFT	(8)

/* Clock Setting Register 5, PLL D LSB */
#define AIC3204_CLK5			AIC3204_PGREG(0, 8)
/* PLL D least significant portion bitfield location */
#define AIC3204_CLK5_PLL_D_SHIFT	(0)
/* PLL D least significant portion bitfield mask */
#define AIC3204_CLK5_PLL_D		(0xff)
/* PLL D least significant portion value shift */
#define AIC3204_CLK5_PLL_D_VSHIFT	(0)

/* Clock Setting Register 6, NDAC Values */
#define AIC3204_CLK6			AIC3204_PGREG(0, 11)
/* NDAC State: Powered Down */
#define AIC3204_CLK6_NDAC_STATE_OFF	(0 << 7)
/* NDAC State: Powered Up */
#define AIC3204_CLK6_NDAC_STATE_ON	(1 << 7)
/* NDAC State Mask */
#define AIC3204_CLK6_NDAC_STATE		(1 << 7)
/* NDAC value bitfield location */
#define AIC3204_CLK6_NDAC_SHIFT		(0)
/* NDAC value bitfield mask */
#define AIC3204_CLK6_NDAC		(0x7f)

/* Clock Setting Register 7, MDAC Values */
#define AIC3204_CLK7			AIC3204_PGREG(0, 12)
/* MDAC State: Powered Down */
#define AIC3204_CLK7_MDAC_STATE_OFF	(0 << 7)
/* MDAC State: Powered Up */
#define AIC3204_CLK7_MDAC_STATE_ON	(1 << 7)
/* MDAC State Mask */
#define AIC3204_CLK7_MDAC_STATE		(1 << 7)
/* MDAC value bitfield location */
#define AIC3204_CLK7_MDAC_SHIFT		(0)
/* MDAC value bitfield mask */
#define AIC3204_CLK7_MDAC		(0x7f)

/* DAC OSR Setting Register 1, MSB */
#define AIC3204_DOSR1			AIC3204_PGREG(0, 13)
/* DOSR most significant portion bitfield location */
#define AIC3204_DOSR1_MSB_SHIFT		(0)
/* DOSR most significant portion bitfield mask */
#define AIC3204_DOSR1_MSB		(3)
/* DOSR most significant portion value shift */
#define AIC3204_DOSR1_MSB_VSHIFT	(8)

/* DAC OSR Setting Register 2, LSB */
#define AIC3204_DOSR2			AIC3204_PGREG(0, 14)
/* DOSR least significant portion bitfield location */
#define AIC3204_DOSR2_LSB_SHIFT		(0)
/* DOSR least significant portion bitfield mask */
#define AIC3204_DOSR2_LSB		(0xff)
/* DOSR least significant portion value shift */
#define AIC3204_DOSR2_LSB_VSHIFT	(0)

/* Clock Setting Register 8, NADC Values */
#define AIC3204_CLK8			AIC3204_PGREG(0, 18)
/* NADC State: Powered Down */
#define AIC3204_CLK8_NADC_STATE_OFF	(0 << 7)
/* NADC State: Powered Up */
#define AIC3204_CLK8_NADC_STATE_ON	(1 << 7)
/* NADC State Mask */
#define AIC3204_CLK8_NADC_STATE		(1 << 7)
/* NADC value bitfield location */
#define AIC3204_CLK8_NADC_SHIFT		(0)
/* NADC value bitfield mask */
#define AIC3204_CLK8_NADC		(0x7f)

/* Clock Setting Register 9, MADC Values */
#define AIC3204_CLK9			AIC3204_PGREG(0, 19)
/* MADC State: Powered Down */
#define AIC3204_CLK9_MADC_STATE_OFF	(0 << 7)
/* MADC State: Powered Up */
#define AIC3204_CLK9_MADC_STATE_ON	(1 << 7)
/* MADC State Mask */
#define AIC3204_CLK9_MADC_STATE		(1 << 7)
/* MADC value bitfield location */
#define AIC3204_CLK9_MADC_SHIFT		(0)
/* MADC value bitfield mask */
#define AIC3204_CLK9_MADC		(0x7f)

/* ADC OSR Setting Register */
#define AIC3204_AOSR			AIC3204_PGREG(0, 20)

/* 
 * Clock Register setting 10, Multiplexers
 *
 * XXX: Note that the datasheet goofs up here, calling this register 9, but we
 * already had a register 9 just before AOSR.  Therefore, we will call this
 * register 10, and will increment all following by one to correct TI's
 * mistake.
 */
#define AIC3204_CLK10			AIC3204_PGREG(0, 25)
/* CDIV Clock Source: MCLK */
#define AIC3204_CLK10_CDIV_MCLK		(0)
/* CDIV Clock Source: BCLK */
#define AIC3204_CLK10_CDIV_BCLK		(1)
/* CDIV Clock Source: Data IN */
#define AIC3204_CLK10_CDIV_DIN		(2)
/* CDIV Clock Source: PLL */
#define AIC3204_CLK10_CDIV_PLL		(3)
/* CDIV Clock Source: DAC */
#define AIC3204_CLK10_CDIV_DAC		(4)
/* CDIV Clock Source: DAC Modulation */
#define AIC3204_CLK10_CDIV_DAC_MOD	(5)
/* CDIV Clock Source: ADC */
#define AIC3204_CLK10_CDIV_ADC		(6)
/* CDIV Clock Source: ADC Modulation */
#define AIC3204_CLK10_CDIV_ADC_MOD	(7)
/* CDIV Clock Source Mask */
#define AIC3204_CLK10_CDIV		(7)

/* Clock Register setting 11, CLKOUT M divider value */
#define AIC3204_CLK11			AIC3204_PGREG(0, 26)
/* CLKOUT Divider State: Off */
#define AIC3204_CLK11_CLKOUT_OFF	(0 << 7)
/* CLKOUT Divider State: On */
#define AIC3204_CLK11_CLKOUT_ON		(1 << 7)
/* CLKOUT Divider State Mask */
#define AIC3204_CLK11_CLKOUT		(1 << 7)
/* CLKOUT Divider M value bitfield location */
#define AIC3204_CLK11_CLKOUTM_SHIFT	(0)
/* CLKOUT Divider M value bitfield mask */
#define AIC3204_CLK11_CLKOUTM		(0x7f)

/* Audio Interface Setting Register 1 */
#define AIC3204_AISR1			AIC3204_PGREG(0, 27)
/* Audio Interface Select: I2S */
#define AIC3204_AISR1_INT_I2S		(0 << 6)
/* Audio Interface Select: DSP */
#define AIC3204_AISR1_INT_DSP		(1 << 6)
/* Audio Interface Select: Right-Justified Format */
#define AIC3204_AISR1_INT_RJF		(2 << 6)
/* Audio Interface Select: Left-Justified Format */
#define AIC3204_AISR1_INT_LJF		(3 << 6)
/* Audio Interface Select Mask */
#define AIC3204_AISR1_INT		(3 << 6)
/* Audio Data Word Length: 16 bits */
#define AIC3204_AISR1_WL_16BITS		(0 << 4)
/* Audio Data Word Length: 20 bits */
#define AIC3204_AISR1_WL_20BITS		(1 << 4)
/* Audio Data Word Length: 24 bits */
#define AIC3204_AISR1_WL_24BITS		(2 << 4)
/* Audio Data Word Length: 32 bits */
#define AIC3204_AISR1_WL_32BITS		(3 << 4)
/* Audio Data Word Length Mask */
#define AIC3204_AISR1_WL		(3 << 4)
/* BCLK Direction Control: Input */
#define AIC3204_AISR1_BCLK_IN		(0 << 3)
/* BCLK Direction Control: Output */
#define AIC3204_AISR1_BCLK_OUT		(1 << 3)
/* BCLK Direction Control: Mask */
#define AIC3204_AISR1_BCLK		(1 << 3)
/* WCLK Direction Control: Input */
#define AIC3204_AISR1_WCLK_IN		(0 << 2)
/* WCLK Direction Control: Output */
#define AIC3204_AISR1_WCLK_OUT		(1 << 2)
/* WCLK Direction Control: Mask */
#define AIC3204_AISR1_WCLK		(1 << 2)
/* DOUT High Impedance Output Control: Never high impedance */
#define AIC3204_AISR1_HIZ_NEVER		(0 << 0)
/* DOUT High Impedance Output Control: High impedance when idle */
#define AIC3204_AISR1_HIZ_IDLE		(1 << 0)
/* DOUT High Impedance Output Control Mask */
#define AIC3204_AISR1_HIZ		(1 << 0)

/* Audio Interface Register 2, Data offset setting */
#define AIC3204_AISR2			AIC3204_PGREG(0, 28)

/* Audio Interface Register 3 */
#define AIC3204_AISR3			AIC3204_PGREG(0, 29)
/* Audio Data Loopback Control: Disabled */
#define AIC3204_AISR3_ADLO_OFF		(0 << 5)
/* Audio Data Loopback Control: Enabled */
#define AIC3204_AISR3_ADLO_ON		(1 << 5)
/* Audio Data Loopback Control Mask */
#define AIC3204_AISR3_ADLO		(1 << 5)
/* ADC->DAC Loopback Control: Disabled */
#define AIC3204_AISR3_ADDALO_OFF	(0 << 4)
/* ADC->DAC Loopback Control: Enabled */
#define AIC3204_AISR3_ADDALO_ON		(1 << 4)
/* ADC->DAC Loopback Control Mask */
#define AIC3204_AISR3_ADDALO		(1 << 4)
/* Audio Bit Clock Polarity: Normal */
#define AIC3204_AISR3_BCLKPOL_NOR	(0 << 3)
/* Audio Bit Clock Polarity: Inverted */
#define AIC3204_AISR3_BCLKPOL_INV	(1 << 3)
/* Audio Bit Clock Polarity Mask */
#define AIC3204_AISR3_BCLKPOL		(1 << 3)
/* Audio Data Interface Clock Buffers: Always powered */
#define AIC3204_AISR3_ADICLK_ALWAYS	(0 << 2)
/* Audio Data Interface Clock Buffers: Powered with CODEC only */
#define AIC3204_AISR3_ADICLK_CODEC	(1 << 2)
/* Audio Data Interface Clock Buffers' State */
#define AIC3204_AISR3_ADICLK		(1 << 2)
/* Audio Bit Clock Divider Source: DAC */
#define AIC3204_AISR3_BDIV_DAC		(0 << 0)
/* Audio Bit Clock Divider Source: DAC Modulation */
#define AIC3204_AISR3_BDIV_DAC_MOD	(1 << 0)
/* Audio Bit Clock Divider Source: ADC */
#define AIC3204_AISR3_BDIV_ADC		(2 << 0)
/* Audio Bit Clock Divider Source: ADC Modulation */
#define AIC3204_AISR3_BDIV_ADC_MOD	(3 << 0)

/* Clock Setting Register 12, BCLK N Divider */
#define AIC3204_CLK12			AIC3204_PGREG(0, 30)
/* BCLK N State: Powered Down */
#define AIC3204_PG0_CLK12_BCLK_STATE_OFF (0 << 7)
/* BCLK N State: Powered Up */
#define AIC3204_CLK12_BCLK_STATE_ON	(1 << 7)
/* BCLK N State Mask */
#define AIC3204_CLK12_BCLK_STATE	(1 << 7)
/* BCLK N value bitfield location */
#define AIC3204_CLK12_BCLK_SHIFT	(0)
/* BCLK N value bitfield mask */
#define AIC3204_CLK12_BCLK		(0x7f)

/* Audio Interface Setting Register 4, Secondary Audio Interface */
#define AIC3204_AISR4			AIC3204_PGREG(0, 31)
/* Secondary Bit Clock: GPIO */
#define AIC3204_AISR4_SECBCLK_GPIO	(0 << 5)
/* Secondary Bit Clock: SCLK */
#define AIC3204_AISR4_SECBCLK_SCLK	(1 << 5)
/* Secondary Bit Clock: MISO */
#define AIC3204_AISR4_SECBCLK_MISO	(2 << 5)
/* Secondary Bit Clock: DOUT */
#define AIC3204_AISR4_SECBCLK_DOUT	(3 << 5)
/* Secondary Bit Clock Mask */
#define AIC3204_AISR4_SECBCLK		(3 << 5)
/* Secondary Word Clock: GPIO */
#define AIC3204_AISR4_SECWCLK_GPIO	(0 << 3)
/* Secondary Word Clock: SCLK */
#define AIC3204_AISR4_SECWCLK_SCLK	(1 << 3)
/* Secondary Word Clock: MISO */
#define AIC3204_AISR4_SECWCLK_MISO	(2 << 3)
/* Secondary Word Clock: DOUT */
#define AIC3204_AISR4_SECWCLK_DOUT	(3 << 3)
/* Secondary Word Clock Mask */
#define AIC3204_AISR4_SECWCLK		(3 << 3)
/* ADC Word Clock: GPIO */
#define AIC3204_AISR4_ADCWCLK_GPIO	(0 << 3)
/* ADC Word Clock: SCLK */
#define AIC3204_AISR4_ADCWCLK_SCLK	(1 << 3)
/* ADC Word Clock: MISO */
#define AIC3204_AISR4_ADCWCLK_MISO	(2 << 3)
/* ADC Word Clock Mask */
#define AIC3204_AISR4_ADCWCLK		(3 << 3)
/* Secondary Data Input: GPIO */
#define AIC3204_AISR4_SECDIN_GPIO	(0 << 0)
/* Secondary Data Input: SCLK */
#define AIC3204_AISR4_SECDIN_SCLK	(1 << 0)
/* Secondary Data Input Mask */
#define AIC3204_AISR4_SECDIN		(1 << 0)

/* Audio Interface Setting Register 5 */
#define AIC3204_AISR5			AIC3204_PGREG(0, 32)
/* Audio Interface Bit Clock: Primary (BCLK) */
#define AIC3204_AISR5_BCLKIN_PRI	(0 << 3)
/* Audio Interface Bit Clock: Secondary */
#define AIC3204_AISR5_BCLKIN_SEC	(1 << 3)
/* Audio Interface Bit Clock Mask */
#define AIC3204_AISR5_WCLKIN		(1 << 2)
/* Audio Interface Word Clock: Primary (BCLK) */
#define AIC3204_AISR5_WCLKIN_PRI	(0 << 2)
/* Audio Interface Word Clock: Secondary */
#define AIC3204_AISR5_WCLKIN_SEC	(1 << 2)
/* Audio Interface Word Clock Mask */
#define AIC3204_AISR5_WCLKIN		(1 << 2)
/* ADC Word Clock Control: ADC WCLK = DAC WCLK */
#define ADC3204_PG0_AISR5_ADCWCLK_DAC	(0 << 1)
/* ADC Word Clock Control: ADC WCLK = Secondary ADC WCLK */
#define ADC3204_PG0_AISR5_ADCWCLK_SEC	(1 << 1)
/* ADC Word Clock Control Mask */
#define ADC3204_PG0_AISR5_ADCWCLK	(1 << 1)
/* Audio Data In: Primary Data In */
#define ADC3204_PG0_AISR5_DIN_PRI	(0 << 0)
/* Audio Data In: Secondary Data In */
#define ADC3204_PG0_AISR5_DIN_SEC	(1 << 0)
/* Audio Data In Mask */
#define ADC3204_PG0_AISR5_DIN		(1 << 0)

/* Audio Interface Setting Register 6 */
#define AIC3204_AISR6			AIC3204_PGREG(0, 33)
/* BCLK Output Control: Generated Primary Bit Clock */
#define AIC3204_AISR6_BCLKOUT_GEN	(0 << 7)
/* BCLK Output Control: Secondary Bit Clock */
#define AIC3204_AISR6_BCLKOUT_SEC	(1 << 7)
/* BCLK Output Control Mask */
#define AIC3204_AISR6_BCLKOUT		(1 << 7)
/* Secondary BCLK Output Control: Primary Bit Clock Input */
#define AIC3204_AISR6_SBCLKOUT_BCLK	(0 << 6)
/* Secondary BCLK Output Control: Generated Primary Bit Clock */
#define AIC3204_AISR6_SBCLKOUT_GEN	(1 << 6)
/* Secondary BCLK Output Control Mask */
#define AIC3204_AISR6_SBCLKOUT		(1 << 6)
/* WCLK Output Control: Generated DAC_FS */
#define AIC3204_AISR6_WCLKOUT_DAC	(0 << 4)
/* WCLK Output Control: Generated ADC_FS */
#define AIC3204_AISR6_WCLKOUT_ADC	(1 << 4)
/* WCLK Output Control: Secondary WCLK Input */
#define AIC3204_AISR6_WCLKOUT_SWCLK	(2 << 4)
/* WCLK Output Control Mask */
#define AIC3204_AISR6_WCLKOUT		(3 << 4)
/* Secondary WCLK Output Control: WCLK Input */
#define AIC3204_AISR6_SWCLKOUT_WCLK	(0 << 2)
/* Secondary WCLK Output Control: Generated DAC_FS */
#define AIC3204_AISR6_SWCLKOUT_DAC	(1 << 2)
/* Secondary WCLK Output Control: Generated ADC_FS */
#define AIC3204_AISR6_SWCLKOUT_ADC	(2 << 2)
/* Secondary WCLK Output Control Mask */
#define AIC3204_AISR6_SWCLKOUT		(3 << 2)
/* Primary Data Output Control: Serial Interface */
#define AIC3204_AISR6_DOUT_INT		(0 << 1)
/* Primary Data Output Control: Secondary Data Input */
#define AIC3204_AISR6_DOUT_SDIN		(1 << 1)
/* Primary Data Output Control Mask */
#define AIC3204_AISR6_DOUT		(1 << 1)
/* Secondary Data Output Control: Primary Data In */
#define AIC3204_AISR6_SDOUT_DIN		(0 << 0)
/* Secondary Data Output Control: Serial Interface */
#define AIC3204_AISR6_SDOUT_INT		(1 << 0)
/* Secondary Data Output Control Mask */
#define AIC3204_AISR6_SDOUT		(1 << 0)

/* Digital Interface Misc. Setting Register */
#define AIC3204_DIMISC			AIC3204_PGREG(0, 34)
/* I2C General Call Address Configuration: Ignore */
#define AIC3204_DIMISC_I2CGC_IGNORE	(0 << 5)
/* I2C General Call Address Configuration: Accept */
#define AIC3204_DIMISC_I2CGC_ACCEPT	(1 << 5)

/* ADC Flag Register */
#define AIC3204_ADCF			AIC3204_PGREG(0, 36)
/* Left ADC PGA Status: Gain is set */
#define AIC3204_ADCF_LEFT_PGASET	(1 << 7)
/* Left ADC Power Status: Powered Up */
#define AIC3204_ADCF_LEFT_UP		(1 << 6)
/* Left ADC AGC Status: Gain is saturated */
#define AIC3204_ADCF_LEFT_AGCSAT	(1 << 5)
/* Right ADC PGA Status: Gain is set */
#define AIC3204_ADCF_RIGHT_PGASET	(1 << 3)
/* Right ADC Power Status: Powered Up */
#define AIC3204_ADCF_RIGHT_UP		(1 << 2)
/* Right ADC AGC Status: Gain is saturated */
#define AIC3204_ADCF_RIGHT_AGCSAT	(1 << 1)

/* DAC Flag Register 1 */
#define AIC3204_DACF1			AIC3204_PGREG(0, 37)
/* Left DAC powered up */
#define AIC3204_DACF1_LEFT_UP		(1 << 7)
/* Left Line Output Driver powered up */
#define AIC3204_DACF1_LOL_UP		(1 << 6)
/* Left Headphone Output Driver powered up */
#define AIC3204_DACF1_HPL_UP		(1 << 5)
/* Right DAC powered up */
#define AIC3204_DACF1_RIGHT_UP		(1 << 7)
/* Right Line Output Driver powered up */
#define AIC3204_DACF1_LOR_UP		(1 << 6)
/* Right Headphone Output Driver powered up */
#define AIC3204_DACF1_HPR_UP		(1 << 5)

/* DAC Flag Register 2 */
#define AIC3204_DACF2			AIC3204_PGREG(0, 38)
/* Left DAC PGA Status: Gain is set */
#define AIC3204_DACF2_LEFT_PGASET	(1 << 4)
/* Right DAC PGA Status: Gain is set */
#define AIC3204_DACF2_RIGHT_PGASET	(1 << 0)

/* Sticky Flag Register 1 */
#define AIC3204_STICK1			AIC3204_PGREG(0, 42)
/* Left DAC Overflow */
#define AIC3204_STICK1_LDAC_OVER	(1 << 7)
/* Right DAC Overflow */
#define AIC3204_STICK1_RDAC_OVER	(1 << 6)
/* Left ADC Overflow */
#define AIC3204_STICK1_LADC_OVER	(1 << 3)
/* Right ADC Overflow */
#define AIC3204_STICK1_RADC_OVER	(1 << 2)

/* Interrupt Flag Register 1 */
#define AIC3204_INTF1			AIC3204_PGREG(0, 43)
/* Left DAC Overflow */
#define AIC3204_INTF1_LDAC_OVER		(1 << 7)
/* Right DAC Overflow */
#define AIC3204_INTF1_RDAC_OVER		(1 << 6)
/* Left ADC Overflow */
#define AIC3204_INTF1_LADC_OVER		(1 << 3)
/* Right ADC Overflow */
#define AIC3204_INTF1_RADC_OVER		(1 << 2)

/* Sticky Flag Register 2 */
#define AIC3204_STICK2			AIC3204_PGREG(0, 44)
/* Left Headphone Driver Over Current */
#define AIC3204_STICK2_HPL_OVER		(1 << 7)
/* Right Headphone Driver Over Current */
#define AIC3204_STICK2_HPR_OVER		(1 << 6)
/* Headset button pressed */
#define AIC3204_STICK2_HS_BUTTON	(1 << 5)
/* Headset plug inserted/removed */
#define AIC3204_STICK2_HS_PLUGGED	(1 << 4)
/* Left Channel DRC: Over threshold */
#define AIC3204_STICK2_LDRC_OVER	(1 << 3)
/* Right Channel DRC: Over threshold */
#define AIC3204_STICK2_RDRC_OVER	(1 << 2)

/* Sticky Flag Register 3 */
#define AIC3204_STICK3			AIC3204_PGREG(0, 45)
/* Left AGC Noise Threshold Flag: Over threshold */
#define AIC3204_STICK3_LAGC_OVER	(1 << 6)
/* Right AGC Noise Threshold Flag: Over threshold */
#define AIC3204_STICK3_RAGC_OVER	(1 << 5)
/* Left ADC DC Measurement Available */
#define AIC3204_STICK3_LADC_DC		(1 << 2)
/* Right ADC DC Measurement Available */
#define AIC3204_STICK3_RADC_DC		(1 << 1)

/* Interrupt Flag Register 2 */
#define AIC3204_INTF2			AIC3204_PGREG(0, 46)
/* Left Headphone Driver Over Current */
#define AIC3204_INTF2_HPL_OVER		(1 << 7)
/* Right Headphone Driver Over Current */
#define AIC3204_INTF2_HPR_OVER		(1 << 6)
/* Headset button pressed */
#define AIC3204_INTF2_HS_BUTTON		(1 << 5)
/* Headset plug inserted/removed */
#define AIC3204_INTF2_HS_PLUGGED	(1 << 4)
/* Left Channel DRC: Over threshold */
#define AIC3204_INTF2_LDRC_OVER		(1 << 3)
/* Right Channel DRC: Over threshold */
#define AIC3204_INTF2_RDRC_OVER		(1 << 2)

/* Interrupt Flag Register 3 */
#define AIC3204_INTF3			AIC3204_PGREG(0, 47)
/* Left AGC Noise Threshold Flag: Over threshold */
#define AIC3204_INTF3_LAGC_OVER		(1 << 6)
/* Right AGC Noise Threshold Flag: Over threshold */
#define AIC3204_INTF3_RAGC_OVER		(1 << 5)
/* Left ADC DC Measurement Available */
#define AIC3204_INTF3_LADC_DC		(1 << 2)
/* Right ADC DC Measurement Available */
#define AIC3204_INTF3_RADC_DC		(1 << 1)

/* INT1 Interrupt Control Register */
#define AIC3204_INT1			AIC3204_PGREG(0, 48)
/* INT1 Generated on Headset insertion */
#define AIC3204_INT1_HS_PLUG		(1 << 7)
/* INT1 Generated on Headset Button press */
#define AIC3204_INT1_HS_BUTTON		(1 << 6)
/* INT1 Generated on DAC DRC Signal Threshold */
#define AIC3204_INT1_DAC_DRC		(1 << 5)
/* INT1 Generated on AGC Noise Interrupt */
#define AIC3204_INT1_ADC_NOISE		(1 << 4)
/* INT1 Generated on Over Current */
#define AIC3204_INT1_HP_OVERCURRENT	(1 << 3)
/* INT1 Generated on overflow event */
#define AIC3204_INT1_OVERFLOW		(1 << 2)
/* INT1 Generated on DC measurement */
#define AIC3204_INT1_DC			(1 << 1)
/* INT1 pulse control: Continuous pulse train */
#define AIC3204_INT1_CONT_PULSE		(1 << 0)

/* INT2 Interrupt Control Register */
#define AIC3204_INT2			AIC3204_PGREG(0, 49)
/* INT2 Generated on Headset insertion */
#define AIC3204_INT2_HS_PLUG		(1 << 7)
/* INT2 Generated on Headset Button press */
#define AIC3204_INT2_HS_BUTTON		(1 << 6)
/* INT2 Generated on DAC DRC Signal Threshold */
#define AIC3204_INT2_DAC_DRC		(1 << 5)
/* INT2 Generated on AGC Noise Interrupt */
#define AIC3204_INT2_ADC_NOISE		(1 << 4)
/* INT2 Generated on Over Current */
#define AIC3204_INT2_HP_OVERCURRENT	(1 << 3)
/* INT2 Generated on overflow event */
#define AIC3204_INT2_OVERFLOW		(1 << 2)
/* INT2 Generated on DC measurement */
#define AIC3204_INT2_DC			(1 << 1)
/* INT2 pulse control: Continuous pulse train */
#define AIC3204_INT2_CONT_PULSE		(1 << 0)

/* TODO: Define the remaining registers ... this will do for now */

/* GPIO/MFP5 Control Register */
#define AIC3204_MFP5			AIC3204_PGREG(0, 52)
/* GPIO Control: Disabled */
#define AIC3204_MFP5_FUNC_DISABLED	(0 << 2)
/* GPIO Control: Secondary audio interface/digital microphone/clock input */
#define AIC3204_MFP5_FUNC_SAI_DM_CI	(1 << 2)
/* GPIO Control: General Purpose Input */
#define AIC3204_MFP5_FUNC_INPUT		(2 << 2)
/* GPIO Control: General Purpose Output */
#define AIC3204_MFP5_FUNC_OUTPUT	(3 << 2)
/* GPIO Control: CLKOUT Output */
#define AIC3204_MFP5_FUNC_CLKOUT	(4 << 2)
/* GPIO Control: INT1 Output */
#define AIC3204_MFP5_FUNC_INT1		(4 << 2)
/* GPIO Control: INT2 Output */
#define AIC3204_MFP5_FUNC_INT2		(4 << 2)
/* GPIO Control: ADC_WCLK */
#define AIC3204_MFP5_FUNC_ADC_WCLK	(4 << 2)
/* GPIO Control: Secondary Bit Clock */
#define AIC3204_MFP5_FUNC_SEC_BCLK	(4 << 2)
/* GPIO Control: Secondary Word Clock */
#define AIC3204_MFP5_FUNC_SEC_WCLK	(4 << 2)
/* GPIO Control: Digital Microphone Clock */
#define AIC3204_MFP5_FUNC_DMIC_CLK	(4 << 2)
/* GPIO Control Mask */
#define AIC3204_MFP5_FUNC		(15 << 2)
/* GPIO Input State */
#define AIC3204_MFP5_IN			(1 << 1)
/* GPIO Output State */
#define AIC3204_MFP5_OUT		(1 << 0)

/* DOUT/MFP2 Function Control Register */
#define AIC3204_MFP2			AIC3204_PGREG(0, 53)
/* DOUT Bus Keeper Enabled */
#define AIC3204_MFP2_BK			(1 << 4)
/* DOUT MUX Control: Disabled */
#define AIC3204_MFP2_FUNC_DISABLED	(0 << 1)
/* DOUT MUX Control: Primary DOUT */
#define AIC3204_MFP2_FUNC_PRI_DOUT	(1 << 1)
/* DOUT MUX Control: General Purpose Output */
#define AIC3204_MFP2_FUNC_OUTPUT	(2 << 1)
/* DOUT MUX Control: CLKOUT Clock Output */
#define AIC3204_MFP2_FUNC_CLKOUT	(3 << 1)
/* DOUT MUX Control: INT1 Output */
#define AIC3204_MFP2_FUNC_INT1		(4 << 1)
/* DOUT MUX Control: INT2 Output */
#define AIC3204_MFP2_FUNC_INT2		(5 << 1)
/* DOUT MUX Control: Secondary Bit Clock */
#define AIC3204_MFP2_FUNC_SEC_BCLK	(6 << 1)
/* DOUT MUX Control: Secondary Word Clock */
#define AIC3204_MFP2_FUNC_SEC_WCLK	(7 << 1)
/* DOUT MUX Control Mask */
#define AIC3204_MFP2_FUNC		(7 << 1)
/* DOUT General Purpose Output State */
#define AIC3204_MFP2_OUT		(1 << 0)

/* DIN/MFP1 Function Control Register */
#define AIC3204_MFP1			AIC3204_PGREG(0, 54)
/* DIN Function Control: Disabled */
#define AIC3204_MFP1_FUNC_DISABLED	(0 << 1)
/* DIN Function Control: Primary Data Input/Digital Microphone/Clock Input */
#define AIC3204_MFP1_FUNC_DIN_DM_CI	(1 << 1)
/* DIN Function Control: General Purpose Input */
#define AIC3204_MFP1_FUNC_INPUT		(2 << 1)
/* DIN Function Control Mask */
#define AIC3204_MFP1_FUNC		(3 << 1)
/* DIN Input State */
#define AIC3204_MFP1_IN			(1 << 0)

/* MISO/MFP4 Function Control Register */
#define AIC3204_MFP4			AIC3204_PGREG(0, 55)
/* MISO Function Control: Disabled */
#define AIC3204_MFP4_FUNC_DISABLED	(0 << 1)
/* MISO Function Control: SPI Data Output (disabled in I2C mode) */
#define AIC3204_MFP4_FUNC_SPI_OUT	(1 << 1)
/* MISO Function Control: General Purpose Output */
#define AIC3204_MFP4_FUNC_OUTPUT	(2 << 1)
/* MISO Function Control: CLKOUT Clock Output */
#define AIC3204_MFP4_FUNC_CLKOUT	(3 << 1)
/* MISO Function Control: INT1 Output */
#define AIC3204_MFP4_FUNC_INT1		(4 << 1)
/* MISO Function Control: INT2 Output */
#define AIC3204_MFP4_FUNC_INT2		(5 << 1)
/* MISO Function Control: ADC Word Clock Output */
#define AIC3204_MFP4_FUNC_ADC_WCLK	(6 << 1)
/* MISO Function Control: Digital Microphone Clock Output */
#define AIC3204_MFP4_FUNC_DMIC_CLK	(7 << 1)
/* MISO Function Control: Secondary Data Output */
#define AIC3204_MFP4_FUNC_SEC_DOUT	(8 << 1)
/* MISO Function Control: Secondary Bit Clock */
#define AIC3204_MFP4_FUNC_SEC_BCLK	(9 << 1)
/* MISO Function Control: Secondary Word Clock */
#define AIC3204_MFP4_FUNC_SEC_WCLK	(10 << 1)
/* MISO Function Control Mask */
#define AIC3204_MFP4_FUNC		(15 << 1)
/* MISO Output State */
#define AIC3204_MFP4_OUT		(1 << 0)

/* SCLK/MFP3 Function Control Register */
#define AIC3204_MFP3			AIC3204_PGREG(0, 56)
/* SCLK Function Control: Disabled */
#define AIC3204_MFP3_FUNC_DISABLED	(0 << 1)
/* SCLK Function Control: SPI Clock / Secondary Interface / Digital Mic Input */
#define AIC3204_MFP3_FUNC_SPI_SI_DM	(1 << 1)
/* SCLK Function Control: General Purpose Input */
#define AIC3204_MFP3_FUNC_INPUT		(2 << 1)
/* SCLK Function Control Mask */
#define AIC3204_MFP3_FUNC		(3 << 1)
/* SCLK Input State */
#define AIC3204_MFP3_IN			(1 << 0)

/* DAC Signal Processing Block Control Register */
#define AIC3204_DACSPB			AIC3204_PGREG(0, 60)
/* DAC Signal Processing Block Mask */
#define AIC3204_DACSPB_MASK		0x1f

/* ADC Signal Processing Block Control Register */
#define AIC3204_ADCSPB			AIC3204_PGREG(0, 61)
/* ADC Signal Processing Block Mask */
#define AIC3204_ADCSPB_MASK		0x1f

/* DAC Channel Setup Register 1 */
#define AIC3204_DACS1			AIC3204_PGREG(0, 63)
/* Left DAC Powered Up */
#define AIC3204_DACS1_LDAC_UP		(1 << 7)
/* Right DAC Powered Up */
#define AIC3204_DACS1_RDAC_UP		(1 << 6)
/* Left DAC Data Path Control: Disabled */
#define AIC3204_DACS1_LDACD_DIS		(0 << 4)
/* Left DAC Data Path Control: Left Data */
#define AIC3204_DACS1_LDACD_LEFT	(1 << 4)
/* Left DAC Data Path Control: Right Data */
#define AIC3204_DACS1_LDACD_RIGHT	(2 << 4)
/* Left DAC Data Path Control: Left + Right */
#define AIC3204_DACS1_LDACD_MIX		(3 << 4)
/* Left DAC Data Path Control Mask */
#define AIC3204_DACS1_LDACD		(3 << 4)
/* Right DAC Data Path Control: Disabled */
#define AIC3204_DACS1_RDACD_DIS		(0 << 2)
/* Right DAC Data Path Control: Right Data */
#define AIC3204_DACS1_RDACD_RIGHT	(1 << 2)
/* Right DAC Data Path Control: Left Data */
#define AIC3204_DACS1_RDACD_LEFT	(2 << 2)
/* Right DAC Data Path Control: Left + Right */
#define AIC3204_DACS1_RDACD_MIX		(3 << 2)
/* Right DAC Data Path Control Mask */
#define AIC3204_DACS1_RDACD		(3 << 2)
/* DAC Soft-Step: Disabled */
#define AIC3204_DACS1_SOFT_DIS		(0 << 0)
/* DAC Soft-Step: 1 step every clock */
#define AIC3204_DACS1_SOFT_1SEC		(1 << 0)
/* DAC Soft-Step: 1 step every 2 clocks */
#define AIC3204_DACS1_SOFT_1SE2C	(2 << 0)
/* DAC Soft-Step Mask */
#define AIC3204_DACS1_SOFT		(3 << 0)

/* DAC Channel Setup Register 2 */
#define AIC3204_DACS2			AIC3204_PGREG(0, 64)
/* Right Modulator Output Control: Output is inverted left output */
#define AIC3204_DACS2_RMOD_INV		(1 << 7)
/* DAC Auto Mute: Disabled */
#define AIC3204_DACS2_AMUTE_DIS		(0 << 4)
/* DAC Auto Mute: After 100 samples of DC */
#define AIC3204_DACS2_AMUTE_100		(1 << 4)
/* DAC Auto Mute: After 200 samples of DC */
#define AIC3204_DACS2_AMUTE_200		(2 << 4)
/* DAC Auto Mute: After 400 samples of DC */
#define AIC3204_DACS2_AMUTE_400		(3 << 4)
/* DAC Auto Mute: After 800 samples of DC */
#define AIC3204_DACS2_AMUTE_800		(4 << 4)
/* DAC Auto Mute: After 1600 samples of DC */
#define AIC3204_DACS2_AMUTE_1600	(5 << 4)
/* DAC Auto Mute: After 3200 samples of DC */
#define AIC3204_DACS2_AMUTE_3200	(6 << 4)
/* DAC Auto Mute: After 6400 samples of DC */
#define AIC3204_DACS2_AMUTE_6400	(7 << 4)
/* DAC Auto Mute Mask */
#define AIC3204_DACS2_AMUTE		(7 << 4)
/* Left DAC Muted */
#define AIC3204_DACS2_LEFT_MUTE		(1 << 3)
/* Right DAC Muted */
#define AIC3204_DACS2_RIGHT_MUTE	(1 << 2)
/* DAC Master Volume Control: Independant */
#define AIC3204_DACS2_VOL_IND		(0 << 0)
/* DAC Master Volume Control: Left controls right */
#define AIC3204_DACS2_VOL_LEFT		(1 << 0)
/* DAC Master Volume Control: Right controls left */
#define AIC3204_DACS2_VOL_RIGHT		(2 << 0)
/* DAC Master Volume Control Mask */
#define AIC3204_DACS2_VOL			(3 << 0)

/* Left DAC Digital Volume Control */
#define AIC3204_LDACVOL			AIC3204_PGREG(0, 65)

/* Right DAC Digital Volume Control */
#define AIC3204_RDACVOL			AIC3204_PGREG(0, 66)

/* Headset Detection Configuration Register */
#define AIC3204_HSDET			AIC3204_PGREG(0, 67)
/* Enable Headset Detection */
#define AIC3204_HSDET_ENABLE		(1 << 7)
/* Headset Type: No Headset */
#define AIC3204_HSDET_NONE		(0 << 5)
/* Headset Type: Stereo Headset */
#define AIC3204_HSDET_STEREO		(1 << 5)
/* Headset Type: Cellular Stereo Headset */
#define AIC3204_HSDET_CELLSTEREO	(3 << 5)
/* Headset Detection Debounce Time: 16ms */
#define AIC3204_HSDET_PLUGDT_16		(0 << 2)
/* Headset Detection Debounce Time: 32ms */
#define AIC3204_HSDET_PLUGDT_32		(1 << 2)
/* Headset Detection Debounce Time: 64ms */
#define AIC3204_HSDET_PLUGDT_64		(2 << 2)
/* Headset Detection Debounce Time: 128ms */
#define AIC3204_HSDET_PLUGDT_128	(3 << 2)
/* Headset Detection Debounce Time: 256ms */
#define AIC3204_HSDET_PLUGDT_256	(4 << 2)
/* Headset Detection Debounce Time: 512ms */
#define AIC3204_HSDET_PLUGDT_512	(5 << 2)
/* Headset Detection Debounce Time Mask */
#define AIC3204_HSDET_PLUGDT		(7 << 2)
/* Headset Button Debounce Time: 8ms */
#define AIC3204_HSDET_BTNDT_8		(0 << 0)
/* Headset Button Debounce Time: 16ms */
#define AIC3204_HSDET_BTNDT_16		(1 << 0)
/* Headset Button Debounce Time: 32ms */
#define AIC3204_HSDET_BTNDT_32		(2 << 0)
/* Headset Button Debounce Time Mask */
#define AIC3204_HSDET_BTNDT		(3 << 0)

/* GPIO API */
enum {
	AIC3204_GPIO1_FUNC_DISABLED		= 0,
	AIC3204_GPIO1_FUNC_AUDIO_WORDCLK_ADC	= 1,
	AIC3204_GPIO1_FUNC_CLOCK_MUX		= 2,
	AIC3204_GPIO1_FUNC_CLOCK_MUX_DIV2		= 3,
	AIC3204_GPIO1_FUNC_CLOCK_MUX_DIV4		= 4,
	AIC3204_GPIO1_FUNC_CLOCK_MUX_DIV8		= 5,
	AIC3204_GPIO1_FUNC_SHORT_CIRCUIT_IRQ	= 6,
	AIC3204_GPIO1_FUNC_AGC_NOISE_IRQ		= 7,
	AIC3204_GPIO1_FUNC_INPUT			= 8,
	AIC3204_GPIO1_FUNC_OUTPUT			= 9,
	AIC3204_GPIO1_FUNC_DIGITAL_MIC_MODCLK	= 10,
	AIC3204_GPIO1_FUNC_AUDIO_WORDCLK		= 11,
	AIC3204_GPIO1_FUNC_BUTTON_IRQ		= 12,
	AIC3204_GPIO1_FUNC_HEADSET_DETECT_IRQ	= 13,
	AIC3204_GPIO1_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ	= 14,
	AIC3204_GPIO1_FUNC_ALL_IRQ		= 16
};

enum {
	AIC3204_GPIO2_FUNC_DISABLED		= 0,
	AIC3204_GPIO2_FUNC_HEADSET_DETECT_IRQ	= 2,
	AIC3204_GPIO2_FUNC_INPUT			= 3,
	AIC3204_GPIO2_FUNC_OUTPUT			= 4,
	AIC3204_GPIO2_FUNC_DIGITAL_MIC_INPUT	= 5,
	AIC3204_GPIO2_FUNC_AUDIO_BITCLK		= 8,
	AIC3204_GPIO2_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ = 9,
	AIC3204_GPIO2_FUNC_ALL_IRQ		= 10,
	AIC3204_GPIO2_FUNC_SHORT_CIRCUIT_OR_AGC_IRQ = 11,
	AIC3204_GPIO2_FUNC_HEADSET_OR_BUTTON_PRESS_OR_SHORT_CIRCUIT_IRQ = 12,
	AIC3204_GPIO2_FUNC_SHORT_CIRCUIT_IRQ	= 13,
	AIC3204_GPIO2_FUNC_AGC_NOISE_IRQ		= 14,
	AIC3204_GPIO2_FUNC_BUTTON_PRESS_IRQ	= 15
};

void aic3204_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
int aic3204_get_gpio(struct snd_soc_codec *codec, int gpio);

/* headset detection / button API */

/* The AIC3204 supports detection of stereo headsets (GND + left + right signal)
 * and cellular headsets (GND + speaker output + microphone input).
 * It is recommended to enable MIC bias for this function to work properly.
 * For more information, please refer to the datasheet. */
enum {
	AIC3204_HEADSET_DETECT_OFF	= 0,
	AIC3204_HEADSET_DETECT_STEREO	= 1,
	AIC3204_HEADSET_DETECT_CELLULAR   = 2,
	AIC3204_HEADSET_DETECT_BOTH	= 3
};

enum {
	AIC3204_HEADSET_DEBOUNCE_16MS	= 0,
	AIC3204_HEADSET_DEBOUNCE_32MS	= 1,
	AIC3204_HEADSET_DEBOUNCE_64MS	= 2,
	AIC3204_HEADSET_DEBOUNCE_128MS	= 3,
	AIC3204_HEADSET_DEBOUNCE_256MS	= 4,
	AIC3204_HEADSET_DEBOUNCE_512MS	= 5
};

enum {
	AIC3204_BUTTON_DEBOUNCE_0MS	= 0,
	AIC3204_BUTTON_DEBOUNCE_8MS	= 1,
	AIC3204_BUTTON_DEBOUNCE_16MS	= 2,
	AIC3204_BUTTON_DEBOUNCE_32MS	= 3
};

#define AIC3204_HEADSET_DETECT_ENABLED	0x80
#define AIC3204_HEADSET_DETECT_SHIFT	5
#define AIC3204_HEADSET_DETECT_MASK	3
#define AIC3204_HEADSET_DEBOUNCE_SHIFT	2
#define AIC3204_HEADSET_DEBOUNCE_MASK	7
#define AIC3204_BUTTON_DEBOUNCE_SHIFT 	0
#define AIC3204_BUTTON_DEBOUNCE_MASK	3

/* see the enums above for valid parameters to this function */
void aic3204_set_headset_detection(struct snd_soc_codec *codec, int detect,
				 int headset_debounce, int button_debounce);
int aic3204_headset_detected(struct snd_soc_codec *codec);
int aic3204_button_pressed(struct snd_soc_codec *codec);

struct aic3204_setup_data {
	unsigned int gpio_func[2];
};

extern struct snd_soc_dai aic3204_dai;
extern struct snd_soc_codec_device soc_codec_dev_aic3204;

#endif /* _AIC3204_H */

--R3G7APHDIzY6R/pk
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
/* #define ENABLE_PLL */

/* TODO: Make this configurable */
#define AIC3204_OSR		128

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

	/* For SYSFS; register selection */
	u16 sysfs_reg;
};

/*
 * read aic3204 register cache
 */
static inline unsigned int aic3204_read_reg_cache(struct snd_soc_codec *codec,
						unsigned int reg)
{
	u8 *cache = codec->reg_cache;

	if (reg >= AIC3204_CACHEREGNUM)
		return -1;
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
	struct aic3204_priv *aic3204 = snd_soc_codec_get_drvdata(codec);
	/* data is
	 *   D15..D8 aic3204 register offset
	 *   D7...D0 register data
	 */
	u8 data[2];

	/*
	 * Register number; upper 8 bits indicate page
	 */
	if ( reg && (aic3204_read_reg_cache( codec, AIC3204_PAGE_SELECT ) 
			!= ( reg >> 8 )) ) {
		/* Select the required page */
		data[0] = 0;
		data[1] = reg >> 8;
		if (codec->hw_write(codec->control_data, data, 2) != 2)
			return -EIO;
		aic3204_write_reg_cache(codec, AIC3204_PAGE_SELECT, reg >> 8);
		printk( KERN_INFO "%s: Page %d selected\n", 
				__func__, reg >> 8 );
	}

	data[0] = reg & 0xff;
	data[1] = value & 0xff;

	if (codec->hw_write(codec->control_data, data, 2) != 2)
		return -EIO;

	printk( KERN_INFO "%s: pg %d reg %d[%04x] <= %02x\n",
			__func__, reg >> 8, reg & 0xff, reg, value);
	aic3204_write_reg_cache(codec, reg, value);
	return 0;
}

/*
 * read from the aic3204 register space
 */
static int aic3204_read(struct snd_soc_codec *codec, unsigned int reg,
		      u8 *value)
{
	*value = reg & 0xff;

	/*
	 * Register number; upper 8 bits indicate page
	 */
	if ( reg && (aic3204_read_reg_cache( codec, AIC3204_PAGE_SELECT ) 
			!= ( reg >> 8 )) )
		/* Select the required page */
		aic3204_write( codec, AIC3204_PAGE_SELECT, (reg >> 8) );

	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);

#if 0
	printk( KERN_INFO "%s: pg %d reg %d[%04x] => %02x\n",
			__func__, reg >> 8, reg & 0xff, reg, value[0] );
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


#define SOC_DAPM_SINGLE_AIC3204(xname, reg, shift, mask, invert) \
{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
	.info = snd_soc_info_volsw, \
	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw_aic3204, \
	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }

/*
 * All input lines are connected when !0xf and disconnected with 0xf bit field,
 * so we have to use specific dapm_put call for input mixer
 */
static int snd_soc_dapm_put_volsw_aic3204(struct snd_kcontrol *kcontrol,
					struct snd_ctl_elem_value *ucontrol)
{
	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int shift = mc->shift;
	int max = mc->max;
	unsigned int mask = (1 << fls(max)) - 1;
	unsigned int invert = mc->invert;
	unsigned short val, val_mask;
	int ret;
	struct snd_soc_dapm_path *path;
	int found = 0;

	val = (ucontrol->value.integer.value[0] & mask);

	mask = 0xf;
	if (val)
		val = mask;

	if (invert)
		val = mask - val;
	val_mask = mask << shift;
	val = val << shift;

	mutex_lock(&widget->codec->mutex);

	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
		/* find dapm widget path assoc with kcontrol */
		list_for_each_entry(path, &widget->codec->dapm_paths, list) {
			if (path->kcontrol != kcontrol)
				continue;

			/* found, now check type */
			found = 1;
			if (val)
				/* new connection */
				path->connect = invert ? 0 : 1;
			else
				/* old connection must be powered down */
				path->connect = invert ? 1 : 0;
			break;
		}

		if (found)
			snd_soc_dapm_sync(widget->codec);
	}

	ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);

	mutex_unlock(&widget->codec->mutex);
	return ret;
}

/* For DAC Channel Setup Register 1 */
static const char *aic3204_ldac_src_mux[] = {
	"Disabled", "Left Data In", "Right Data In", "Left + Right Data Mix"
};
static const char *aic3204_rdac_src_mux[] = {
	"Disabled", "Right Data In", "Left Data In", "Left + Right Data Mix"
};

/* For DAC Channel Setup Register 2 */
static const char *aic3204_rdac_mod_ctl[] = {
	"Mute", "Inverse Left"
};
static const char *aic3204_amute_ctl[] = {
	"Off", ">100 samples", ">200 samples", ">400 samples", ">800 samples",
	">1600 samples", ">3200 samples", ">6400 samples"
};
static const char *aic3204_linein_mode_mux[] = {
	"single-ended", "differential"
};

#if 0
static const char *aic3204_left_dac_mux[] = { "DAC_L1", "DAC_L3", "DAC_L2" };
static const char *aic3204_right_dac_mux[] = { "DAC_R1", "DAC_R3", "DAC_R2" };
static const char *aic3204_left_hpcom_mux[] =
    { "differential of HPLOUT", "constant VCM", "single-ended" };
static const char *aic3204_right_hpcom_mux[] =
    { "differential of HPROUT", "constant VCM", "single-ended",
      "differential of HPLCOM", "external feedback" };
static const char *aic3204_adc_hpf[] =
    { "Disabled", "0.0045xFs", "0.0125xFs", "0.025xFs" };

#define LDAC_ENUM	0
#define RDAC_ENUM	1
#define LHPCOM_ENUM	2
#define RHPCOM_ENUM	3
#define LINE1L_ENUM	4
#define LINE1R_ENUM	5
#define LINE2L_ENUM	6
#define LINE2R_ENUM	7
#define ADC_HPF_ENUM	8

static const struct soc_enum aic3204_enum[] = {
	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3204_left_dac_mux),
	SOC_ENUM_SINGLE(DAC_LINE_MUX, 4, 3, aic3204_right_dac_mux),
	SOC_ENUM_SINGLE(HPLCOM_CFG, 4, 3, aic3204_left_hpcom_mux),
	SOC_ENUM_SINGLE(HPRCOM_CFG, 3, 5, aic3204_right_hpcom_mux),
	SOC_ENUM_SINGLE(LINE1L_2_LADC_CTRL, 7, 2, aic3204_linein_mode_mux),
	SOC_ENUM_SINGLE(LINE1R_2_RADC_CTRL, 7, 2, aic3204_linein_mode_mux),
	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3204_linein_mode_mux),
	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3204_linein_mode_mux),
	SOC_ENUM_DOUBLE(AIC3204_CODEC_DFILT_CTRL, 6, 4, 4, aic3204_adc_hpf),
};

/*
 * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
 */
static DECLARE_TLV_DB_SCALE(dac_tlv, -6350, 50, 0);
/* ADC PGA gain volumes. From 0 to 59.5 dB in 0.5 dB steps */
static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
/*
 * Output stage volumes. From -78.3 to 0 dB. Muted below -78.3 dB.
 * Step size is approximately 0.5 dB over most of the scale but increasing
 * near the very low levels.
 * Define dB scale so that it is mostly correct for range about -55 to 0 dB
 * but having increasing dB difference below that (and where it doesn't count
 * so much). This setting shows -50 dB (actual is -50.3 dB) for register
 * value 100 and -58.5 dB (actual is -78.3 dB) for register value 117.
 */
static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);

static const struct snd_kcontrol_new aic3204_snd_controls[] = {
#if 0
	/* Output */
	SOC_DOUBLE_R_TLV("PCM Playback Volume",
			 LDAC_VOL, RDAC_VOL, 0, 0x7f, 1, dac_tlv),

	SOC_DOUBLE_R_TLV("Line DAC Playback Volume",
			 DACL1_2_LLOPM_VOL, DACR1_2_RLOPM_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_SINGLE("LineL Playback Switch", LLOPM_CTRL, 3, 0x01, 0),
	SOC_SINGLE("LineR Playback Switch", RLOPM_CTRL, 3, 0x01, 0),
	SOC_DOUBLE_R_TLV("LineL DAC Playback Volume",
			 DACL1_2_LLOPM_VOL, DACR1_2_LLOPM_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_SINGLE_TLV("LineL Left PGA Bypass Playback Volume",
		       PGAL_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
	SOC_SINGLE_TLV("LineR Right PGA Bypass Playback Volume",
		       PGAR_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R_TLV("LineL Line2 Bypass Playback Volume",
			 LINE2L_2_LLOPM_VOL, LINE2R_2_LLOPM_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R_TLV("LineR Line2 Bypass Playback Volume",
			 LINE2L_2_RLOPM_VOL, LINE2R_2_RLOPM_VOL,
			 0, 118, 1, output_stage_tlv),

	SOC_DOUBLE_R_TLV("Mono DAC Playback Volume",
			 DACL1_2_MONOLOPM_VOL, DACR1_2_MONOLOPM_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_SINGLE("Mono DAC Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
	SOC_DOUBLE_R_TLV("Mono PGA Bypass Playback Volume",
			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Playback Volume",
			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
			 0, 118, 1, output_stage_tlv),

	SOC_DOUBLE_R_TLV("HP DAC Playback Volume",
			 DACL1_2_HPLOUT_VOL, DACR1_2_HPROUT_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
		     0x01, 0),
	SOC_DOUBLE_R_TLV("HP Right PGA Bypass Playback Volume",
			 PGAR_2_HPLOUT_VOL, PGAR_2_HPROUT_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_SINGLE_TLV("HPL PGA Bypass Playback Volume",
		       PGAL_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
	SOC_SINGLE_TLV("HPR PGA Bypass Playback Volume",
		       PGAL_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R_TLV("HP Line2 Bypass Playback Volume",
			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
			 0, 118, 1, output_stage_tlv),

	SOC_DOUBLE_R_TLV("HPCOM DAC Playback Volume",
			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
			 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
		     0x01, 0),
	SOC_SINGLE_TLV("HPLCOM PGA Bypass Playback Volume",
		       PGAL_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
	SOC_SINGLE_TLV("HPRCOM PGA Bypass Playback Volume",
		       PGAL_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
	SOC_DOUBLE_R_TLV("HPCOM Line2 Bypass Playback Volume",
			 LINE2L_2_HPLCOM_VOL, LINE2R_2_HPRCOM_VOL,
			 0, 118, 1, output_stage_tlv),

	/*
	 * Note: enable Automatic input Gain Controller with care. It can
	 * adjust PGA to max value when ADC is on and will never go back.
	*/
	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),

	/* Input */
	SOC_DOUBLE_R_TLV("PGA Capture Volume", LADC_VOL, RADC_VOL,
			 0, 119, 0, adc_tlv),
	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),

	SOC_ENUM("ADC HPF Cut-off", aic3204_enum[ADC_HPF_ENUM]),
#endif
};

/* Left DAC Mux */
static const struct snd_kcontrol_new aic3204_left_dac_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[LDAC_ENUM]);

/* Right DAC Mux */
static const struct snd_kcontrol_new aic3204_right_dac_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[RDAC_ENUM]);

/* Left HPCOM Mux */
static const struct snd_kcontrol_new aic3204_left_hpcom_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[LHPCOM_ENUM]);

/* Right HPCOM Mux */
static const struct snd_kcontrol_new aic3204_right_hpcom_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[RHPCOM_ENUM]);

/* Left DAC_L1 Mixer */
static const struct snd_kcontrol_new aic3204_left_dac_mixer_controls[] = {
	SOC_DAPM_SINGLE("LineL Switch", DACL1_2_LLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("LineR Switch", DACL1_2_RLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("Mono Switch", DACL1_2_MONOLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HP Switch", DACL1_2_HPLOUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPCOM Switch", DACL1_2_HPLCOM_VOL, 7, 1, 0),
};

/* Right DAC_R1 Mixer */
static const struct snd_kcontrol_new aic3204_right_dac_mixer_controls[] = {
	SOC_DAPM_SINGLE("LineL Switch", DACR1_2_LLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("LineR Switch", DACR1_2_RLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("Mono Switch", DACR1_2_MONOLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HP Switch", DACR1_2_HPROUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPCOM Switch", DACR1_2_HPRCOM_VOL, 7, 1, 0),
};

/* Left PGA Mixer */
static const struct snd_kcontrol_new aic3204_left_pga_mixer_controls[] = {
	SOC_DAPM_SINGLE_AIC3204("Line1L Switch", LINE1L_2_LADC_CTRL, 3, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Line1R Switch", LINE1R_2_LADC_CTRL, 3, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Line2L Switch", LINE2L_2_LADC_CTRL, 3, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Mic3L Switch", MIC3LR_2_LADC_CTRL, 4, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Mic3R Switch", MIC3LR_2_LADC_CTRL, 0, 1, 1),
};

/* Right PGA Mixer */
static const struct snd_kcontrol_new aic3204_right_pga_mixer_controls[] = {
	SOC_DAPM_SINGLE_AIC3204("Line1R Switch", LINE1R_2_RADC_CTRL, 3, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Line1L Switch", LINE1L_2_RADC_CTRL, 3, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Line2R Switch", LINE2R_2_RADC_CTRL, 3, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Mic3L Switch", MIC3LR_2_RADC_CTRL, 4, 1, 1),
	SOC_DAPM_SINGLE_AIC3204("Mic3R Switch", MIC3LR_2_RADC_CTRL, 0, 1, 1),
};

/* Left Line1 Mux */
static const struct snd_kcontrol_new aic3204_left_line1_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[LINE1L_ENUM]);

/* Right Line1 Mux */
static const struct snd_kcontrol_new aic3204_right_line1_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[LINE1R_ENUM]);

/* Left Line2 Mux */
static const struct snd_kcontrol_new aic3204_left_line2_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[LINE2L_ENUM]);

/* Right Line2 Mux */
static const struct snd_kcontrol_new aic3204_right_line2_mux_controls =
SOC_DAPM_ENUM("Route", aic3204_enum[LINE2R_ENUM]);

/* Left PGA Bypass Mixer */
static const struct snd_kcontrol_new aic3204_left_pga_bp_mixer_controls[] = {
	SOC_DAPM_SINGLE("LineL Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("LineR Switch", PGAL_2_RLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("Mono Switch", PGAL_2_MONOLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPL Switch", PGAL_2_HPLOUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPR Switch", PGAL_2_HPROUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPLCOM Switch", PGAL_2_HPLCOM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPRCOM Switch", PGAL_2_HPRCOM_VOL, 7, 1, 0),
};

/* Right PGA Bypass Mixer */
static const struct snd_kcontrol_new aic3204_right_pga_bp_mixer_controls[] = {
	SOC_DAPM_SINGLE("LineL Switch", PGAR_2_LLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("LineR Switch", PGAR_2_RLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("Mono Switch", PGAR_2_MONOLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPL Switch", PGAR_2_HPLOUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPR Switch", PGAR_2_HPROUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPLCOM Switch", PGAR_2_HPLCOM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPRCOM Switch", PGAR_2_HPRCOM_VOL, 7, 1, 0),
};

/* Left Line2 Bypass Mixer */
static const struct snd_kcontrol_new aic3204_left_line2_bp_mixer_controls[] = {
	SOC_DAPM_SINGLE("LineL Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("LineR Switch", LINE2L_2_RLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("Mono Switch", LINE2L_2_MONOLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HP Switch", LINE2L_2_HPLOUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPLCOM Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
};

/* Right Line2 Bypass Mixer */
static const struct snd_kcontrol_new aic3204_right_line2_bp_mixer_controls[] = {
	SOC_DAPM_SINGLE("LineL Switch", LINE2R_2_LLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("LineR Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("Mono Switch", LINE2R_2_MONOLOPM_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HP Switch", LINE2R_2_HPROUT_VOL, 7, 1, 0),
	SOC_DAPM_SINGLE("HPRCOM Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
};

static const struct snd_soc_dapm_widget aic3204_dapm_widgets[] = {
	/* Left DAC to Left Outputs */
	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0),
	SND_SOC_DAPM_MUX("Left DAC Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_left_dac_mux_controls),
	SND_SOC_DAPM_MIXER("Left DAC_L1 Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_left_dac_mixer_controls[0],
			   ARRAY_SIZE(aic3204_left_dac_mixer_controls)),
	SND_SOC_DAPM_MUX("Left HPCOM Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_left_hpcom_mux_controls),
	SND_SOC_DAPM_PGA("Left Line Out", LLOPM_CTRL, 0, 0, NULL, 0),
	SND_SOC_DAPM_PGA("Left HP Out", HPLOUT_CTRL, 0, 0, NULL, 0),
	SND_SOC_DAPM_PGA("Left HP Com", HPLCOM_CTRL, 0, 0, NULL, 0),

	/* Right DAC to Right Outputs */
	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", DAC_PWR, 6, 0),
	SND_SOC_DAPM_MUX("Right DAC Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_right_dac_mux_controls),
	SND_SOC_DAPM_MIXER("Right DAC_R1 Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_right_dac_mixer_controls[0],
			   ARRAY_SIZE(aic3204_right_dac_mixer_controls)),
	SND_SOC_DAPM_MUX("Right HPCOM Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_right_hpcom_mux_controls),
	SND_SOC_DAPM_PGA("Right Line Out", RLOPM_CTRL, 0, 0, NULL, 0),
	SND_SOC_DAPM_PGA("Right HP Out", HPROUT_CTRL, 0, 0, NULL, 0),
	SND_SOC_DAPM_PGA("Right HP Com", HPRCOM_CTRL, 0, 0, NULL, 0),

	/* Mono Output */
	SND_SOC_DAPM_PGA("Mono Out", MONOLOPM_CTRL, 0, 0, NULL, 0),

	/* Inputs to Left ADC */
	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", LINE1L_2_LADC_CTRL, 2, 0),
	SND_SOC_DAPM_MIXER("Left PGA Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_left_pga_mixer_controls[0],
			   ARRAY_SIZE(aic3204_left_pga_mixer_controls)),
	SND_SOC_DAPM_MUX("Left Line1L Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_left_line1_mux_controls),
	SND_SOC_DAPM_MUX("Left Line1R Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_left_line1_mux_controls),
	SND_SOC_DAPM_MUX("Left Line2L Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_left_line2_mux_controls),

	/* Inputs to Right ADC */
	SND_SOC_DAPM_ADC("Right ADC", "Right Capture",
			 LINE1R_2_RADC_CTRL, 2, 0),
	SND_SOC_DAPM_MIXER("Right PGA Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_right_pga_mixer_controls[0],
			   ARRAY_SIZE(aic3204_right_pga_mixer_controls)),
	SND_SOC_DAPM_MUX("Right Line1L Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_right_line1_mux_controls),
	SND_SOC_DAPM_MUX("Right Line1R Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_right_line1_mux_controls),
	SND_SOC_DAPM_MUX("Right Line2R Mux", SND_SOC_NOPM, 0, 0,
			 &aic3204_right_line2_mux_controls),

	/*
	 * Not a real mic bias widget but similar function. This is for dynamic
	 * control of GPIO1 digital mic modulator clock output function when
	 * using digital mic.
	 */
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "GPIO1 dmic modclk",
			 AIC3204_GPIO1_REG, 4, 0xf,
			 AIC3204_GPIO1_FUNC_DIGITAL_MIC_MODCLK,
			 AIC3204_GPIO1_FUNC_DISABLED),

	/*
	 * Also similar function like mic bias. Selects digital mic with
	 * configurable oversampling rate instead of ADC converter.
	 */
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 128",
			 AIC3204_ASD_INTF_CTRLA, 0, 3, 1, 0),
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 64",
			 AIC3204_ASD_INTF_CTRLA, 0, 3, 2, 0),
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 32",
			 AIC3204_ASD_INTF_CTRLA, 0, 3, 3, 0),

	/* Mic Bias */
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2V",
			 MICBIAS_CTRL, 6, 3, 1, 0),
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2.5V",
			 MICBIAS_CTRL, 6, 3, 2, 0),
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias AVDD",
			 MICBIAS_CTRL, 6, 3, 3, 0),

	/* Left PGA to Left Output bypass */
	SND_SOC_DAPM_MIXER("Left PGA Bypass Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_left_pga_bp_mixer_controls[0],
			   ARRAY_SIZE(aic3204_left_pga_bp_mixer_controls)),

	/* Right PGA to Right Output bypass */
	SND_SOC_DAPM_MIXER("Right PGA Bypass Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_right_pga_bp_mixer_controls[0],
			   ARRAY_SIZE(aic3204_right_pga_bp_mixer_controls)),

	/* Left Line2 to Left Output bypass */
	SND_SOC_DAPM_MIXER("Left Line2 Bypass Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_left_line2_bp_mixer_controls[0],
			   ARRAY_SIZE(aic3204_left_line2_bp_mixer_controls)),

	/* Right Line2 to Right Output bypass */
	SND_SOC_DAPM_MIXER("Right Line2 Bypass Mixer", SND_SOC_NOPM, 0, 0,
			   &aic3204_right_line2_bp_mixer_controls[0],
			   ARRAY_SIZE(aic3204_right_line2_bp_mixer_controls)),

	SND_SOC_DAPM_OUTPUT("LLOUT"),
	SND_SOC_DAPM_OUTPUT("RLOUT"),
	SND_SOC_DAPM_OUTPUT("MONO_LOUT"),
	SND_SOC_DAPM_OUTPUT("HPLOUT"),
	SND_SOC_DAPM_OUTPUT("HPROUT"),
	SND_SOC_DAPM_OUTPUT("HPLCOM"),
	SND_SOC_DAPM_OUTPUT("HPRCOM"),

	SND_SOC_DAPM_INPUT("MIC3L"),
	SND_SOC_DAPM_INPUT("MIC3R"),
	SND_SOC_DAPM_INPUT("LINE1L"),
	SND_SOC_DAPM_INPUT("LINE1R"),
	SND_SOC_DAPM_INPUT("LINE2L"),
	SND_SOC_DAPM_INPUT("LINE2R"),
};

static const struct snd_soc_dapm_route intercon[] = {
	/* Left Output */
	{"Left DAC Mux", "DAC_L1", "Left DAC"},
	{"Left DAC Mux", "DAC_L2", "Left DAC"},
	{"Left DAC Mux", "DAC_L3", "Left DAC"},

	{"Left DAC_L1 Mixer", "LineL Switch", "Left DAC Mux"},
	{"Left DAC_L1 Mixer", "LineR Switch", "Left DAC Mux"},
	{"Left DAC_L1 Mixer", "Mono Switch", "Left DAC Mux"},
	{"Left DAC_L1 Mixer", "HP Switch", "Left DAC Mux"},
	{"Left DAC_L1 Mixer", "HPCOM Switch", "Left DAC Mux"},
	{"Left Line Out", NULL, "Left DAC Mux"},
	{"Left HP Out", NULL, "Left DAC Mux"},

	{"Left HPCOM Mux", "differential of HPLOUT", "Left DAC_L1 Mixer"},
	{"Left HPCOM Mux", "constant VCM", "Left DAC_L1 Mixer"},
	{"Left HPCOM Mux", "single-ended", "Left DAC_L1 Mixer"},

	{"Left Line Out", NULL, "Left DAC_L1 Mixer"},
	{"Mono Out", NULL, "Left DAC_L1 Mixer"},
	{"Left HP Out", NULL, "Left DAC_L1 Mixer"},
	{"Left HP Com", NULL, "Left HPCOM Mux"},

	{"LLOUT", NULL, "Left Line Out"},
	{"LLOUT", NULL, "Left Line Out"},
	{"HPLOUT", NULL, "Left HP Out"},
	{"HPLCOM", NULL, "Left HP Com"},

	/* Right Output */
	{"Right DAC Mux", "DAC_R1", "Right DAC"},
	{"Right DAC Mux", "DAC_R2", "Right DAC"},
	{"Right DAC Mux", "DAC_R3", "Right DAC"},

	{"Right DAC_R1 Mixer", "LineL Switch", "Right DAC Mux"},
	{"Right DAC_R1 Mixer", "LineR Switch", "Right DAC Mux"},
	{"Right DAC_R1 Mixer", "Mono Switch", "Right DAC Mux"},
	{"Right DAC_R1 Mixer", "HP Switch", "Right DAC Mux"},
	{"Right DAC_R1 Mixer", "HPCOM Switch", "Right DAC Mux"},
	{"Right Line Out", NULL, "Right DAC Mux"},
	{"Right HP Out", NULL, "Right DAC Mux"},

	{"Right HPCOM Mux", "differential of HPROUT", "Right DAC_R1 Mixer"},
	{"Right HPCOM Mux", "constant VCM", "Right DAC_R1 Mixer"},
	{"Right HPCOM Mux", "single-ended", "Right DAC_R1 Mixer"},
	{"Right HPCOM Mux", "differential of HPLCOM", "Right DAC_R1 Mixer"},
	{"Right HPCOM Mux", "external feedback", "Right DAC_R1 Mixer"},

	{"Right Line Out", NULL, "Right DAC_R1 Mixer"},
	{"Mono Out", NULL, "Right DAC_R1 Mixer"},
	{"Right HP Out", NULL, "Right DAC_R1 Mixer"},
	{"Right HP Com", NULL, "Right HPCOM Mux"},

	{"RLOUT", NULL, "Right Line Out"},
	{"RLOUT", NULL, "Right Line Out"},
	{"HPROUT", NULL, "Right HP Out"},
	{"HPRCOM", NULL, "Right HP Com"},

	/* Mono Output */
	{"MONO_LOUT", NULL, "Mono Out"},
	{"MONO_LOUT", NULL, "Mono Out"},

	/* Left Input */
	{"Left Line1L Mux", "single-ended", "LINE1L"},
	{"Left Line1L Mux", "differential", "LINE1L"},

	{"Left Line2L Mux", "single-ended", "LINE2L"},
	{"Left Line2L Mux", "differential", "LINE2L"},

	{"Left PGA Mixer", "Line1L Switch", "Left Line1L Mux"},
	{"Left PGA Mixer", "Line1R Switch", "Left Line1R Mux"},
	{"Left PGA Mixer", "Line2L Switch", "Left Line2L Mux"},
	{"Left PGA Mixer", "Mic3L Switch", "MIC3L"},
	{"Left PGA Mixer", "Mic3R Switch", "MIC3R"},

	{"Left ADC", NULL, "Left PGA Mixer"},
	{"Left ADC", NULL, "GPIO1 dmic modclk"},

	/* Right Input */
	{"Right Line1R Mux", "single-ended", "LINE1R"},
	{"Right Line1R Mux", "differential", "LINE1R"},

	{"Right Line2R Mux", "single-ended", "LINE2R"},
	{"Right Line2R Mux", "differential", "LINE2R"},

	{"Right PGA Mixer", "Line1L Switch", "Right Line1L Mux"},
	{"Right PGA Mixer", "Line1R Switch", "Right Line1R Mux"},
	{"Right PGA Mixer", "Line2R Switch", "Right Line2R Mux"},
	{"Right PGA Mixer", "Mic3L Switch", "MIC3L"},
	{"Right PGA Mixer", "Mic3R Switch", "MIC3R"},

	{"Right ADC", NULL, "Right PGA Mixer"},
	{"Right ADC", NULL, "GPIO1 dmic modclk"},

	/* Left PGA Bypass */
	{"Left PGA Bypass Mixer", "LineL Switch", "Left PGA Mixer"},
	{"Left PGA Bypass Mixer", "LineR Switch", "Left PGA Mixer"},
	{"Left PGA Bypass Mixer", "Mono Switch", "Left PGA Mixer"},
	{"Left PGA Bypass Mixer", "HPL Switch", "Left PGA Mixer"},
	{"Left PGA Bypass Mixer", "HPR Switch", "Left PGA Mixer"},
	{"Left PGA Bypass Mixer", "HPLCOM Switch", "Left PGA Mixer"},
	{"Left PGA Bypass Mixer", "HPRCOM Switch", "Left PGA Mixer"},

	{"Left HPCOM Mux", "differential of HPLOUT", "Left PGA Bypass Mixer"},
	{"Left HPCOM Mux", "constant VCM", "Left PGA Bypass Mixer"},
	{"Left HPCOM Mux", "single-ended", "Left PGA Bypass Mixer"},

	{"Left Line Out", NULL, "Left PGA Bypass Mixer"},
	{"Mono Out", NULL, "Left PGA Bypass Mixer"},
	{"Left HP Out", NULL, "Left PGA Bypass Mixer"},

	/* Right PGA Bypass */
	{"Right PGA Bypass Mixer", "LineL Switch", "Right PGA Mixer"},
	{"Right PGA Bypass Mixer", "LineR Switch", "Right PGA Mixer"},
	{"Right PGA Bypass Mixer", "Mono Switch", "Right PGA Mixer"},
	{"Right PGA Bypass Mixer", "HPL Switch", "Right PGA Mixer"},
	{"Right PGA Bypass Mixer", "HPR Switch", "Right PGA Mixer"},
	{"Right PGA Bypass Mixer", "HPLCOM Switch", "Right PGA Mixer"},
	{"Right PGA Bypass Mixer", "HPRCOM Switch", "Right PGA Mixer"},

	{"Right HPCOM Mux", "differential of HPROUT", "Right PGA Bypass Mixer"},
	{"Right HPCOM Mux", "constant VCM", "Right PGA Bypass Mixer"},
	{"Right HPCOM Mux", "single-ended", "Right PGA Bypass Mixer"},
	{"Right HPCOM Mux", "differential of HPLCOM", "Right PGA Bypass Mixer"},
	{"Right HPCOM Mux", "external feedback", "Right PGA Bypass Mixer"},

	{"Right Line Out", NULL, "Right PGA Bypass Mixer"},
	{"Mono Out", NULL, "Right PGA Bypass Mixer"},
	{"Right HP Out", NULL, "Right PGA Bypass Mixer"},

	/* Left Line2 Bypass */
	{"Left Line2 Bypass Mixer", "LineL Switch", "Left Line2L Mux"},
	{"Left Line2 Bypass Mixer", "LineR Switch", "Left Line2L Mux"},
	{"Left Line2 Bypass Mixer", "Mono Switch", "Left Line2L Mux"},
	{"Left Line2 Bypass Mixer", "HP Switch", "Left Line2L Mux"},
	{"Left Line2 Bypass Mixer", "HPLCOM Switch", "Left Line2L Mux"},

	{"Left HPCOM Mux", "differential of HPLOUT", "Left Line2 Bypass Mixer"},
	{"Left HPCOM Mux", "constant VCM", "Left Line2 Bypass Mixer"},
	{"Left HPCOM Mux", "single-ended", "Left Line2 Bypass Mixer"},

	{"Left Line Out", NULL, "Left Line2 Bypass Mixer"},
	{"Mono Out", NULL, "Left Line2 Bypass Mixer"},
	{"Left HP Out", NULL, "Left Line2 Bypass Mixer"},

	/* Right Line2 Bypass */
	{"Right Line2 Bypass Mixer", "LineL Switch", "Right Line2R Mux"},
	{"Right Line2 Bypass Mixer", "LineR Switch", "Right Line2R Mux"},
	{"Right Line2 Bypass Mixer", "Mono Switch", "Right Line2R Mux"},
	{"Right Line2 Bypass Mixer", "HP Switch", "Right Line2R Mux"},
	{"Right Line2 Bypass Mixer", "HPRCOM Switch", "Right Line2R Mux"},

	{"Right HPCOM Mux", "differential of HPROUT", "Right Line2 Bypass Mixer"},
	{"Right HPCOM Mux", "constant VCM", "Right Line2 Bypass Mixer"},
	{"Right HPCOM Mux", "single-ended", "Right Line2 Bypass Mixer"},
	{"Right HPCOM Mux", "differential of HPLCOM", "Right Line2 Bypass Mixer"},
	{"Right HPCOM Mux", "external feedback", "Right Line2 Bypass Mixer"},

	{"Right Line Out", NULL, "Right Line2 Bypass Mixer"},
	{"Mono Out", NULL, "Right Line2 Bypass Mixer"},
	{"Right HP Out", NULL, "Right Line2 Bypass Mixer"},

	/*
	 * Logical path between digital mic enable and GPIO1 modulator clock
	 * output function
	 */
	{"GPIO1 dmic modclk", NULL, "DMic Rate 128"},
	{"GPIO1 dmic modclk", NULL, "DMic Rate 64"},
	{"GPIO1 dmic modclk", NULL, "DMic Rate 32"},
};
#endif

static int aic3204_add_widgets(struct snd_soc_codec *codec)
{
#if 0
	snd_soc_dapm_new_controls(codec, aic3204_dapm_widgets,
				  ARRAY_SIZE(aic3204_dapm_widgets));

	/* set up audio path interconnects */
	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
#endif
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
	int codec_clk = 0, bypass_pll = 0, last_clk = 0, last_error = 0;
	u8 data = 0, div = 0, pll_p = 1, pll_r = 1, pll_j = 1, bdiv = 1;
	u16 pll_d = 0;

	int this_clk = 0, this_error = 0;
	unsigned int this_abs_error;
	u8 p, r, j, this_div;
	u16 d;

	/* Determine the bit clock and CODEC clock rates needed */
	codec_clk = AIC3204_OSR * params_rate(params) *
		params_channels(params);

	/* 
	 * Select data word length.
	 * Note that the number of bits per frame used
	 * to determine BDIV is double the number of bits per sample, as there
	 * are two samples per frame.
	 */
	switch (params_format(params)) {
		case SNDRV_PCM_FORMAT_S16_LE:
			pr_debug("%s: Sample format 16 bits\n", __func__);
			bdiv = AIC3204_OSR / 32;
			data = AIC3204_AISR1_WL_16BITS;
			break;
		case SNDRV_PCM_FORMAT_S20_3LE:
			pr_debug("%s: Sample format 20 bits\n", __func__);
			bdiv = AIC3204_OSR / 40;
			data = AIC3204_AISR1_WL_20BITS;
			break;
		case SNDRV_PCM_FORMAT_S24_LE:
			pr_debug("%s: Sample format 24 bits\n", __func__);
			bdiv = AIC3204_OSR / 48;
			data = AIC3204_AISR1_WL_24BITS;
			break;
		case SNDRV_PCM_FORMAT_S32_LE:
			pr_debug("%s: Sample format 32 bits\n", __func__);
			bdiv = AIC3204_OSR / 64;
			data = AIC3204_AISR1_WL_32BITS;
			break;
	}
	aic3204_mod(codec, AIC3204_AISR1, ~AIC3204_AISR1_WL, data);

#ifndef ENABLE_PLL
	/* If PLL is disabled; always bypass the PLL */
	bypass_pll = 1;
#endif

	/* Try to find a value for div which allows us to bypass the PLL and
	 * generate CODEC_CLK directly. */
	for (this_div = 1; this_div < 128; this_div++) {
		this_clk = aic3204->sysclk / this_div;

		if (this_clk == codec_clk) {
			bypass_pll = 1;
			div = this_div;
			break;
#ifndef ENABLE_PLL
		} else {
			this_error = this_clk - codec_clk;
			this_abs_error = abs(this_error);
			if ( !last_clk || (this_abs_error < last_error) ) {
				last_clk = this_clk;
				last_error = this_abs_error;
				div = this_div;
			}
#endif
		}
	}

	if (bypass_pll) {
		/* Select MCLK as CODEC_CLKIN */
		aic3204_write(codec, AIC3204_CLK1, AIC3204_CLK1_CODECCLK_MCLK );
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
	 * We shall try for D == 0 at first; as this gives us the wider
	 * frequency range; allowing us to select P at will.  Otherwise
	 * P must be chosen so that the PLL input frequency falls
	 * between 10MHz and 20MHz as above.
	 *
	 * As an added failsafe; we have the NDAC divider we can make use of.
	 * We will continue to increment this until we get a PLL setting that
	 * matches our needs.
	 *
	 * We keep going until we run out of NADC settings and PLL settings.
	 */
	this_div = 1;
	while(( this_div <= 128 ) && (!last_clk)) {
		codec_clk = this_div * AIC3204_OSR * params_rate(params) *
			params_channels(params);
		for( p = 8; p >= 1; p-- ) {
			int sysclk_div_p = aic3204->sysclk / p;
			int rj, temp_d;
			pr_debug("%s: Trying P=%d => in/p = %d Hz\n", 
				__func__, p, sysclk_div_p );
			if ( sysclk_div_p <   512000 ) continue;
			if ( sysclk_div_p > 20000000 ) continue;

			/* Determine a value for R*J */
			rj = codec_clk / sysclk_div_p;
			pr_debug("%s: Trying R*J=%d\n", __func__, rj );
			if ( rj < 4 )
				/* Too low for J */
				continue;

			r = 1;
			j = rj;
			while ( ( j > 63 ) && ( r <= 4 ) ) {
				r++;
				j = rj / r;
			}
			/* How did we go? */
			this_clk = sysclk_div_p * rj;
			this_error = this_clk - codec_clk;
			this_abs_error = abs(this_error);
			if ( (!last_clk) || (this_abs_error < last_error ) ) {
				pr_debug("%s: Integer PLL search; best found "
						"P=%d, R=%d, J=%d, D=0 "
						"=> %d Hz (%d Hz error)\n",
						__func__, p, r, j,
						this_clk, this_error );
				div = this_div;
				pll_p = p;
				pll_r = r;
				pll_j = j;
				pll_d = 0;
				last_clk = this_clk;
				last_error = this_abs_error;

				if ( !this_abs_error )
					goto found_pll;
			}
			/* 
			 * Okay; can we do better using D?
			 * Check we meet the criteria.
			 */
			if ( sysclk_div_p < 10000000 ) continue;
			/*
			 * this_error gives us the degree of error in the
			 * calculation.  We can use this to derive D exactly.
			 */
			temp_d = 10000 * p * this_error;
			temp_d /= r * j * aic3204->sysclk;
			temp_d = 10000 - temp_d;
			pr_debug("%s: Trying D=%d\n", __func__, temp_d );
			/* Skip invalid values */
			if ( temp_d < 0 ) continue;
			if ( temp_d > 10000 ) continue;
			d = temp_d;

			/* How did we go? */
			this_clk = ((sysclk_div_p * rj)/10000) * d;
			this_error = this_clk - codec_clk;
			this_abs_error = abs(this_error);
			if ( (!last_clk) || (this_abs_error < last_error ) ) {
				pr_debug("%s: Fractional PLL search; best found "
						"P=%d, R=%d, J.D=%d.%04d "
						"=> %d Hz (%d Hz error)\n",
						__func__, p, r, j, d,
						this_clk, this_error );
				div = this_div;
				pll_p = p;
				pll_r = r;
				pll_j = j;
				pll_d = d;
				last_clk = this_clk;
				last_error = this_abs_error;

				if ( !this_abs_error )
					goto found_pll;
			}
		}

		/* 
		 * Okay; if we get here and haven't found something; try for
		 * the next harmonic.
		 */
		if ( !last_clk )
			this_div++;
	}

	/* If we still haven't found anything; bail out here! */
	if ( !last_clk ) goto fail;
found_pll:
	pr_debug("%s: Best Output: %d (%d Hz Error)\n",
			__func__, last_clk, last_error );
	pr_debug( "%s: setting up PLL: P=%d R=%d J.D=%d.%04d\n",
			__func__, pll_p, pll_r, pll_j, pll_d );
	aic3204_write(codec, AIC3204_CLK4, (pll_d >> AIC3204_CLK4_PLL_D_VSHIFT) 
			& AIC3204_CLK4_PLL_D); 		/* PLL D[14:8] */
	aic3204_write(codec, AIC3204_CLK5, pll_d & AIC3204_CLK5_PLL_D);
							/* PLL D[7:0] */
	aic3204_write(codec, AIC3204_CLK3, pll_j & AIC3204_CLK3_PLL_J);
							/* PLL J */
	aic3204_write(codec, AIC3204_CLK2,	
			( pll_r & AIC3204_CLK2_PLL_R )	/* PLL R */
			| ( ( pll_p & AIC3204_CLK2_PLL_P ) 
				<< AIC3204_CLK2_PLL_P_SHIFT )
							/* PLL P */
			| AIC3204_CLK2_PLL_ON );	/* PLL on */

	/* Select PLL as CODEC_CLKIN */
	aic3204_write(codec, AIC3204_CLK1, AIC3204_CLK1_CODECCLK_PLL );

setup_codec:
	/* Incorporate NDAC clock divider into BDIV */
	bdiv *= div;

	/* Set AOSR and DOSR */
	aic3204_write(codec, AIC3204_DOSR1, 
			(AIC3204_OSR >> AIC3204_DOSR1_MSB_VSHIFT) 
			& AIC3204_DOSR1_MSB );			/* DOSR[9:8] */
	aic3204_write(codec, AIC3204_DOSR2, AIC3204_OSR 
			& AIC3204_DOSR2_LSB );			/* DOSR[7:0] */
	aic3204_write(codec, AIC3204_AOSR, AIC3204_OSR);	/* AOSR */

	pr_debug("%s: NDAC = %d\n", __func__, div);
	/* Set NDAC to divider value */
	aic3204_write(codec, AIC3204_CLK6, div |
			AIC3204_CLK6_NDAC_STATE_ON );
	/* Use NDAC for NADC */
	aic3204_write(codec, AIC3204_CLK8, 0x00 );
	/* Set MDAC to 2 */
	aic3204_write(codec, AIC3204_CLK7, AIC3204_CLK7_MDAC_STATE_ON | 2);
	/* Use MDAC for MADC */
	aic3204_write(codec, AIC3204_CLK9, 0x00 );

	/* Set BCLK and WCLK */
	pr_debug("%s: Bit clock divider = %d\n", __func__, bdiv);
	/* Turn on and set BCLK N divider */
	aic3204_write(codec, AIC3204_CLK12, bdiv
			| AIC3204_CLK12_BCLK_STATE_ON );

	/* Turn on ADC or DAC */
	if ( substream->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
		aic3204_write(codec, AIC3204_DACS1,
				AIC3204_DACS1_LDAC_UP |
				AIC3204_DACS1_RDAC_UP |
				AIC3204_DACS1_LDACD_LEFT |
				AIC3204_DACS1_RDACD_RIGHT |
				AIC3204_DACS1_SOFT_DIS );
	} else {
		/* TODO; put these registers into the header */
		aic3204_write(codec, AIC3204_PGREG(0, 81), 0xc0 );
	}

	/* This all needs to be done elsewhere */
	aic3204_write(codec, AIC3204_PGREG(1,  9), 0x0f );	/* Turn on LOL/LOR drivers */
	aic3204_write(codec, AIC3204_PGREG(1, 14), 0x0c );	/* LOL <= LDAC + MAL */
	aic3204_write(codec, AIC3204_PGREG(1, 15), 0x0c );	/* LOR <= RDAC + MAR */
	aic3204_write(codec, AIC3204_PGREG(1, 18), 0x1d );	/* LOL Driver unmuted; max volume */
	aic3204_write(codec, AIC3204_PGREG(1, 19), 0x1d );	/* LOR Driver unmuted; max volume */
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
		dacs2 	|= AIC3204_DACS2_LEFT_MUTE
			| AIC3204_DACS2_RIGHT_MUTE;
	} else {
		dacs2 	&= ~(AIC3204_DACS2_LEFT_MUTE
			| AIC3204_DACS2_RIGHT_MUTE);
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

			/* TODO: These need to be set elsewhere (mixer for instance) */
			aic3204_write(codec, AIC3204_PGREG(1,  9), 0x00 );	/* Turn on LOL/LOR drivers */
			aic3204_write(codec, AIC3204_PGREG(1, 14), 0x00 );	/* LOL <= LDAC + MAL */
			aic3204_write(codec, AIC3204_PGREG(1, 15), 0x00 );	/* LOR <= RDAC + MAR */
			aic3204_write(codec, AIC3204_PGREG(1, 18), 0x00 );	/* LOL Driver unmuted; 0dB */
			aic3204_write(codec, AIC3204_PGREG(1, 19), 0x00 );	/* LOR Driver unmuted; 0dB */
			break;
	}
	codec->bias_level = level;
	return 0;
}

void aic3204_set_gpio(struct snd_soc_codec *codec, int gpio, int state)
{
#if 0
	u8 reg = gpio ? AIC3204_GPIO2_REG : AIC3204_GPIO1_REG;
	u8 bit = gpio ? 3: 0;
	u8 val = aic3204_read_reg_cache(codec, reg) & ~(1 << bit);
	aic3204_write(codec, reg, val | (!!state << bit));
#endif
}
EXPORT_SYMBOL_GPL(aic3204_set_gpio);

int aic3204_get_gpio(struct snd_soc_codec *codec, int gpio)
{
#if 0
	u8 reg = gpio ? AIC3204_GPIO2_REG : AIC3204_GPIO1_REG;
	u8 val, bit = gpio ? 2: 1;

	aic3204_read(codec, reg, &val);
	return (val >> bit) & 1;
#endif
	return 0;
}
EXPORT_SYMBOL_GPL(aic3204_get_gpio);

void aic3204_set_headset_detection(struct snd_soc_codec *codec, int detect,
				 int headset_debounce, int button_debounce)
{
#if 0
	u8 val;

	val = ((detect & AIC3204_HEADSET_DETECT_MASK)
		<< AIC3204_HEADSET_DETECT_SHIFT) |
	      ((headset_debounce & AIC3204_HEADSET_DEBOUNCE_MASK)
		<< AIC3204_HEADSET_DEBOUNCE_SHIFT) |
	      ((button_debounce & AIC3204_BUTTON_DEBOUNCE_MASK)
		<< AIC3204_BUTTON_DEBOUNCE_SHIFT);

	if (detect & AIC3204_HEADSET_DETECT_MASK)
		val |= AIC3204_HEADSET_DETECT_ENABLED;

	aic3204_write(codec, AIC3204_HEADSET_DETECT_CTRL_A, val);
#endif
}
EXPORT_SYMBOL_GPL(aic3204_set_headset_detection);

int aic3204_headset_detected(struct snd_soc_codec *codec)
{
	u8 val;
#if 0
	aic3204_read(codec, AIC3204_HEADSET_DETECT_CTRL_B, &val);
#else
	val = 0;
#endif
	return (val >> 4) & 1;
}
EXPORT_SYMBOL_GPL(aic3204_headset_detected);

int aic3204_button_pressed(struct snd_soc_codec *codec)
{
	u8 val;
#if 0
	aic3204_read(codec, AIC3204_HEADSET_DETECT_CTRL_B, &val);
#else
	val = 0;
#endif
	return (val >> 5) & 1;
}
EXPORT_SYMBOL_GPL(aic3204_button_pressed);

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
	for( reg=1; reg < 512; reg++ ) {
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
 * AIC3204 2 wire address can be up to 4 devices with device addresses
 * 0x18, 0x19, 0x1A, 0x1B
 */

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
		printk(KERN_DEBUG "%s: failed to register sysfs"
				"file for I2C register selection\n",
				__func__);

	if ( device_create_file( &i2c->dev, &dev_attr_regdata ) )
		printk(KERN_DEBUG "%s: failed to register sysfs"
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

#if 0
	if (setup) {
		/* setup GPIO functions */
		aic3204_write(codec, AIC3204_GPIO1_REG,
			    (setup->gpio_func[0] & 0xf) << 4);
		aic3204_write(codec, AIC3204_GPIO2_REG,
			    (setup->gpio_func[1] & 0xf) << 4);
	}
#endif

	/* register pcms */
	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
	if (ret < 0) {
		printk(KERN_ERR "aic3204: failed to create pcms\n");
		goto pcm_err;
	}

#if 0
	snd_soc_add_controls(codec, aic3204_snd_controls,
			     ARRAY_SIZE(aic3204_snd_controls));

	aic3204_add_widgets(codec);
#endif

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

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--R3G7APHDIzY6R/pk--
