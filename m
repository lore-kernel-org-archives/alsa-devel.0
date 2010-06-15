From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver [File 2/3]
Date: Tue, 15 Jun 2010 10:33:40 +1000
Message-ID: <20100615003339.GD7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002913.GC7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eAbsdosE1cNLO4uF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9032A2442F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 02:33:58 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOK6F-00028f-4a
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:33:57 +1000
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK6F-00028c-2x
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:33:55 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOK6D-0002vh-B8
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:33:55 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK6D-0002ve-9s
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:33:53 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK61-0000EJ-8h
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:33:53 +1000
Content-Disposition: inline
In-Reply-To: <20100615002913.GC7759@www.longlandclan.yi.org>
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


--eAbsdosE1cNLO4uF
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

Attached :- sound/soc/codecs/tlv320aic3204.h
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

--eAbsdosE1cNLO4uF
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
 * most-significant 9 bits, followed by the register number as given in the
 * datasheet.
 *
 * The register access functions will look after page flipping from here.
 */

/* 
 * AIC3204 register space; 128 registers each page, we pages 0..127.  It's not
 * clear from the datasheet exactly how many pages are in use... and it's a
 * sparse register map!  Ideally, I'd like to just cache the pages that are
 * needed, but the ALSA framework doesn't allow this easily.
 *
 * It does look as if up to and including page 70 is needed.  For now, we will
 * cache up to page 128 however; as this ensures we get *everything*.
 */
#define AIC3204_CACHEREGNUM		(128*128)

/* Page select register */
#define AIC3204_PAGE_SELECT		0

/* Register Page/Number => Address Mapping Macro */
#define AIC3204_PGREG(page,reg)		(((page) << 7) | ((reg) & 0x7f))

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
/* Audio Bit Clock Divider Source Mask */
#define AIC3204_AISR3_BDIV		(3 << 0)

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
#define AIC3204_DACS1_LDAC_UP_SHIFT	(7)
/* Right DAC Powered Up */
#define AIC3204_DACS1_RDAC_UP_SHIFT	(6)
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
#define AIC3204_DACS2_LEFT_MUTE_SHIFT	(3)
/* Right DAC Muted */
#define AIC3204_DACS2_RIGHT_MUTE_SHIFT	(2)
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

/* DRC Control Register 1 */
#define AIC3204_DRC1			AIC3204_PGREG(0, 68)
/* Left Channel DRC Enable */
#define AIC3204_DRC1_LEFT_EN		(1 << 6)
/* Right Channel DRC Enable */
#define AIC3204_DRC1_RIGHT_EN		(1 << 5)
/* DRC Threshold: -3dBFS */
#define AIC3204_DRC1_THOLD_3DBFS	(0 << 2)
/* DRC Threshold: -6dBFS */
#define AIC3204_DRC1_THOLD_6DBFS	(1 << 2)
/* DRC Threshold: -9dBFS */
#define AIC3204_DRC1_THOLD_9DBFS	(2 << 2)
/* DRC Threshold: -12dBFS */
#define AIC3204_DRC1_THOLD_12DBFS	(3 << 2)
/* DRC Threshold: -15dBFS */
#define AIC3204_DRC1_THOLD_15DBFS	(4 << 2)
/* DRC Threshold: -18dBFS */
#define AIC3204_DRC1_THOLD_18DBFS	(5 << 2)
/* DRC Threshold: -21dBFS */
#define AIC3204_DRC1_THOLD_21DBFS	(6 << 2)
/* DRC Threshold: -24dBFS */
#define AIC3204_DRC1_THOLD_24DBFS	(7 << 2)
/* DRC Threshold Mask */
#define AIC3204_DRC1_THOLD		(7 << 2)
/* DRC Hysteresis: 0dB */
#define AIC3204_DRC1_HYST_0DB		(0 << 0)
/* DRC Hysteresis: 1dB */
#define AIC3204_DRC1_HYST_1DB		(1 << 0)
/* DRC Hysteresis: 2dB */
#define AIC3204_DRC1_HYST_2DB		(2 << 0)
/* DRC Hysteresis: 3dB */
#define AIC3204_DRC1_HYST_3DB		(3 << 0)
/* DRC Hysteresis Mask */
#define AIC3204_DRC1_HYST		(3 << 0)

/* DRC Control Register 2 */
#define AIC3204_DRC2			AIC3204_PGREG(0, 69)
/* DRC Hold: Disabled */
#define AIC3204_DRC2_HOLD_DISABLED	(0 << 3)
/* DRC Hold: 32 Word Clocks */
#define AIC3204_DRC2_HOLD_32WC		(1 << 3)
/* DRC Hold: 64 Word Clocks */
#define AIC3204_DRC2_HOLD_64WC		(2 << 3)
/* DRC Hold: 128 Word Clocks */
#define AIC3204_DRC2_HOLD_128WC		(3 << 3)
/* DRC Hold: 256 Word Clocks */
#define AIC3204_DRC2_HOLD_256WC		(4 << 3)
/* DRC Hold: 512 Word Clocks */
#define AIC3204_DRC2_HOLD_512WC		(5 << 3)
/* DRC Hold: 1024 Word Clocks */
#define AIC3204_DRC2_HOLD_1024WC	(6 << 3)
/* DRC Hold: 2048 Word Clocks */
#define AIC3204_DRC2_HOLD_2048WC	(7 << 3)
/* DRC Hold: 4096 Word Clocks */
#define AIC3204_DRC2_HOLD_4096WC	(8 << 3)
/* DRC Hold: 8192 Word Clocks */
#define AIC3204_DRC2_HOLD_8192WC	(9 << 3)
/* DRC Hold: 16384 Word Clocks */
#define AIC3204_DRC2_HOLD_16384WC	(10 << 3)
/* DRC Hold: 32768 Word Clocks */
#define AIC3204_DRC2_HOLD_32768WC	(11 << 3)
/* DRC Hold: 65536 Word Clocks */
#define AIC3204_DRC2_HOLD_65536WC	(12 << 3)
/* DRC Hold: 98304 Word Clocks */
#define AIC3204_DRC2_HOLD_98304WC	(13 << 3)
/* DRC Hold: 131072 Word Clocks */
#define AIC3204_DRC2_HOLD_131072WC	(14 << 3)
/* DRC Hold: 163840 Word Clocks */
#define AIC3204_DRC2_HOLD_163840WC	(15 << 3)
/* DRC Hold Mask */
#define AIC3204_DRC2_HOLD		(15 << 3)

/* DRC Control Register 3 */
#define AIC3204_DRC3			AIC3204_PGREG(0, 70)
/* DRC Attack Rate Shift */
#define AIC3204_DRC3_ATTACK_SHIFT	4
/* DRC Attack Rate Mask */
#define AIC3204_DRC3_ATTACK		(15 << AIC3204_DRC3_ATTACK_SHIFT)
/* DRC Decay Rate Shift */
#define AIC3204_DRC3_DECAY_SHIFT	0
/* DRC Decay Rate Mask */
#define AIC3204_DRC3_DECAY		(15 << AIC3204_DRC3_DECAY_SHIFT)

/* Beep Generator Register 1 */
#define AIC3204_BEEP1			AIC3204_PGREG(0, 71)
/* Enable Beep Generator */
#define AIC3204_BEEP1_EN		(1 << 7)
/* Left Channel Beep Volume Shift */
#define AIC3204_BEEP1_VOL_SHIFT		0
/* Left Channel Beep Volume Mask */
#define AIC3204_BEEP1_VOL		(0x3f)

/* Beep Generator Register 2 */
#define AIC3204_BEEP2			AIC3204_PGREG(0, 72)
/* Beep Generator Master Volume: Independant Left/Right Channels */
#define AIC3204_BEEP2_MVOL_IND		(0 << 6)
/* Beep Generator Master Volume: Left Channel controls Right */
#define AIC3204_BEEP2_MVOL_LEFT		(1 << 6)
/* Beep Generator Master Volume: Right Channel controls Left */
#define AIC3204_BEEP2_MVOL_RIGHT	(2 << 6)
/* Beep Generator Master Volume Mask */
#define AIC3204_BEEP2_MVOL		(3 << 6)

/* Beep Generator Register 3 */
#define AIC3204_BEEP3			AIC3204_PGREG(0, 73)
/* Sample Length Value Shift */
#define AIC3204_BEEP3_LENGTH_VSHIFT	16
/* Sample Length Shift */
#define AIC3204_BEEP3_LENGTH_SHIFT	0
/* Sample Length Mask */
#define AIC3204_BEEP3_LENGTH		(0xff)

/* Beep Generator Register 4 */
#define AIC3204_BEEP4			AIC3204_PGREG(0, 74)
/* Sample Length Value Shift */
#define AIC3204_BEEP4_LENGTH_VSHIFT	8
/* Sample Length Shift */
#define AIC3204_BEEP4_LENGTH_SHIFT	0
/* Sample Length Mask */
#define AIC3204_BEEP4_LENGTH		(0xff)

/* Beep Generator Register 5 */
#define AIC3204_BEEP5			AIC3204_PGREG(0, 75)
/* Sample Length Value Shift */
#define AIC3204_BEEP5_LENGTH_VSHIFT	0
/* Sample Length Shift */
#define AIC3204_BEEP5_LENGTH_SHIFT	0
/* Sample Length Mask */
#define AIC3204_BEEP5_LENGTH		(0xff)

/* Beep Generator Register 6 */
#define AIC3204_BEEP6			AIC3204_PGREG(0, 76)
/* Relative Sine Frequency Value Shift */
#define AIC3204_BEEP6_SINFREQ_VSHIFT	8
/* Relative Sine Frequency Shift */
#define AIC3204_BEEP6_SINFREQ_SHIFT	0
/* Relative Sine Frequency Mask */
#define AIC3204_BEEP6_SINFREQ		(0xff)

/* Beep Generator Register 7 */
#define AIC3204_BEEP7			AIC3204_PGREG(0, 77)
/* Relative Sine Frequency Value Shift */
#define AIC3204_BEEP7_SINFREQ_VSHIFT	0
/* Relative Sine Frequency Shift */
#define AIC3204_BEEP7_SINFREQ_SHIFT	0
/* Relative Sine Frequency Mask */
#define AIC3204_BEEP7_SINFREQ		(0xff)

/* Beep Generator Register 8 */
#define AIC3204_BEEP8			AIC3204_PGREG(0, 78)
/* Relative Cosine Frequency Value Shift */
#define AIC3204_BEEP8_COSFREQ_VSHIFT	8
/* Relative Cosine Frequency Shift */
#define AIC3204_BEEP8_COSFREQ_SHIFT	0
/* Relative Cosine Frequency Mask */
#define AIC3204_BEEP8_COSFREQ		(0xff)

/* Beep Generator Register 9 */
#define AIC3204_BEEP9			AIC3204_PGREG(0, 79)
/* Relative Cosine Frequency Value Shift */
#define AIC3204_BEEP9_COSFREQ_VSHIFT	0
/* Relative Cosine Frequency Shift */
#define AIC3204_BEEP9_COSFREQ_SHIFT	0
/* Relative Cosine Frequency Mask */
#define AIC3204_BEEP9_COSFREQ		(0xff)

/* ADC Channel Setup Register */
#define AIC3204_ADCS			AIC3204_PGREG(0, 81)
/* Left Channel ADC Powered Up */
#define AIC3204_ADCS_LADC_UP_SHIFT	(7)
/* Right Channel ADC Powered Up */
#define AIC3204_ADCS_RADC_UP_SHIFT	(6)
/* Digital Microphone Input: GPIO */
#define AIC3204_ADC5_DMICIN_GPIO	(0 << 4)
/* Digital Microphone Input: SCLK */
#define AIC3204_ADC5_DMICIN_SCLK	(1 << 4)
/* Digital Microphone Input: DIN */
#define AIC3204_ADC5_DMICIN_DIN		(2 << 4)
/* Digital Microphone Input Mask */
#define AIC3204_ADC5_DMICIN		(3 << 4)
/* Left ADC Source: Digital Microphone */
#define AIC3204_ADC5_LADC_DMIC		(1 << 3)
/* Right ADC Source: Digital Microphone */
#define AIC3204_ADC5_RADC_DMIC		(1 << 2)
/* ADC Volume Soft Step: 1 step / word clock */
#define AIC3204_ADC5_VOLSS_1SPWC	(0 << 0)
/* ADC Volume Soft Step: 1 step / 2 word clocks */
#define AIC3204_ADC5_VOLSS_1SP2WC	(1 << 0)
/* ADC Volume Soft Step: Disabled */
#define AIC3204_ADC5_VOLSS_DISABLED	(2 << 0)
/* ADC Volume Soft Step Mask */
#define AIC3204_ADC5_VOLSS		(3 << 0)

/* ADC Fine Gain Adjust Register */
#define AIC3204_ADCFINE			AIC3204_PGREG(0, 82)
/* Left ADC Mute */
#define AIC3204_ADCFINE_LEFT_MUTE	(1 << 7)
/* Left ADC Gain: 0dB */
#define AIC3204_ADCFINE_LEFT_0DB	(0 << 4)
/* Left ADC Gain: -0.1dB */
#define AIC3204_ADCFINE_LEFT_0DB1	(1 << 4)
/* Left ADC Gain: -0.2dB */
#define AIC3204_ADCFINE_LEFT_0DB2	(2 << 4)
/* Left ADC Gain: -0.3dB */
#define AIC3204_ADCFINE_LEFT_0DB3	(2 << 4)
/* Left ADC Gain: -0.4dB */
#define AIC3204_ADCFINE_LEFT_0DB4	(3 << 4)
/* Left ADC Gain Mask */
#define AIC3204_ADCFINE_LEFT		(7 << 4)
/* Right ADC Mute */
#define AIC3204_ADCFINE_RIGHT_MUTE	(1 << 3)
/* Right ADC Gain: 0dB */
#define AIC3204_ADCFINE_RIGHT_0DB	(0 << 0)
/* Right ADC Gain: -0.1dB */
#define AIC3204_ADCFINE_RIGHT_0DB1	(1 << 0)
/* Right ADC Gain: -0.2dB */
#define AIC3204_ADCFINE_RIGHT_0DB2	(2 << 0)
/* Right ADC Gain: -0.3dB */
#define AIC3204_ADCFINE_RIGHT_0DB3	(2 << 0)
/* Right ADC Gain: -0.4dB */
#define AIC3204_ADCFINE_RIGHT_0DB4	(3 << 0)
/* Right ADC Gain Mask */
#define AIC3204_ADCFINE_RIGHT		(7 << 0)

/* Left ADC Channel Volume Register */
#define AIC3204_LADCVOL			AIC3204_PGREG(0, 83)
/* Left ADC Channel Volume Mask */
#define AIC3204_LADCVOL_MASK		0x7f

/* Right ADC Channel Volume Register */
#define AIC3204_RADCVOL			AIC3204_PGREG(0, 84)
/* Right ADC Channel Volume Mask */
#define AIC3204_RADCVOL_MASK		0x7f

/* ADC Phase Adjust Register */
#define AIC3204_ADCPHASE		AIC3204_PGREG(0, 85)

/* Left Channel AGC Control Register 1 */
#define AIC3204_LAGC1			AIC3204_PGREG(0, 86)
/* Left Channel AGC Enabled */
#define AIC3204_LAGC1_ENABLE		(1 << 7)
/* Left Channel Target Level: -5.5dBFS */
#define AIC3204_LAGC1_LEVEL_5DBFS5	(0 << 4)
/* Left Channel Target Level: -8.0dBFS */
#define AIC3204_LAGC1_LEVEL_8DBFS	(1 << 4)
/* Left Channel Target Level: -10dBFS */
#define AIC3204_LAGC1_LEVEL_10DBFS	(2 << 4)
/* Left Channel Target Level: -12dBFS */
#define AIC3204_LAGC1_LEVEL_12DBFS	(3 << 4)
/* Left Channel Target Level: -14dBFS */
#define AIC3204_LAGC1_LEVEL_14DBFS	(4 << 4)
/* Left Channel Target Level: -17dBFS */
#define AIC3204_LAGC1_LEVEL_17DBFS	(5 << 4)
/* Left Channel Target Level: -20dBFS */
#define AIC3204_LAGC1_LEVEL_20DBFS	(6 << 4)
/* Left Channel Target Level: -24dBFS */
#define AIC3204_LAGC1_LEVEL_24DBFS	(7 << 4)
/* Left Channel Target Level Mask */
#define AIC3204_LAGC1_LEVEL		(7 << 4)
/* Left Channel Gain Hysteresis: Disabled */
#define AIC3204_LAGC1_GAINHYST_DISABLED	(0 << 0)
/* Left Channel Gain Hysteresis: 0.5dB */
#define AIC3204_LAGC1_GAINHYST_0DB5	(1 << 0)
/* Left Channel Gain Hysteresis: 1dB */
#define AIC3204_LAGC1_GAINHYST_1DB	(2 << 0)
/* Left Channel Gain Hysteresis: 1.5dB */
#define AIC3204_LAGC1_GAINHYST_1DB5	(3 << 0)
/* Left Channel Gain Hysteresis Mask */
#define AIC3204_LAGC1_GAINHYST		(3 << 0)

/* Left Channel AGC Control Register 2 */
#define AIC3204_LAGC2			AIC3204_PGREG(0, 87)
/* Left Channel AGC Hysteresis: 1dB */
#define AIC3204_LAGC2_HYST_1DB		(0 << 6)
/* Left Channel AGC Hysteresis: 2dB */
#define AIC3204_LAGC2_HYST_2DB		(1 << 6)
/* Left Channel AGC Hysteresis: 4dB */
#define AIC3204_LAGC2_HYST_4DB		(2 << 6)
/* Left Channel AGC Hysteresis: Disabled */
#define AIC3204_LAGC2_HYST_DISABLED	(3 << 6)
/* Left Channel AGC Hysteresis Mask */
#define AIC3204_LAGC2_HYST		(3 << 6)
/* Left Channel AGC Noise Gate Threshold Mask */
#define AIC3204_LAGC2_NGATE		(0x1f)
/* Left Channel AGC Noise Gate Threshold Shift */
#define AIC3204_LAGC2_NGATE_SHIFT	1

/* TODO: Remaining AGC registers, DC measurement registers */

/* Power Configuration Register */
#define AIC3204_POWER			AIC3204_PGREG(1, 1)
/* Disable AVDD -> DVDD Link */
#define AIC3204_POWER_AVDD_DVDD_UNLINK	(1 << 3)

/* LDO Control Register */
#define AIC3204_LDO			AIC3204_PGREG(1, 2)
/* DVDD LDO: 1.72V */
#define AIC3204_LDO_DVDD_1V72		(0 << 6)
/* DVDD LDO: 1.67V */
#define AIC3204_LDO_DVDD_1V67		(1 << 6)
/* DVDD LDO: 1.77V */
#define AIC3204_LDO_DVDD_1V77		(2 << 6)
/* DVDD LDO Mask */
#define AIC3204_LDO_DVDD		(3 << 6)
/* AVDD LDO: 1.72V */
#define AIC3204_LDO_AVDD_1V72		(0 << 4)
/* AVDD LDO: 1.67V */
#define AIC3204_LDO_AVDD_1V67		(1 << 4)
/* AVDD LDO: 1.77V */
#define AIC3204_LDO_AVDD_1V77		(2 << 4)
/* AVDD LDO Mask */
#define AIC3204_LDO_AVDD		(3 << 4)
/* Analog Blocks Enabled */
#define AIC3204_LDO_ANALOG_ENABLED	(0 << 3)
/* Analog Blocks Disabled */
#define AIC3204_LDO_ANALOG_DISABLED	(1 << 3)
/* Analog Block Status */
#define AIC3204_LDO_ANALOG		(1 << 3)
/* DVDD Over Current Detect */
#define AIC3204_LDO_DVDD_OVERCURRENT	(1 << 2)
/* AVDD Over Current Detect */
#define AIC3204_LDO_AVDD_OVERCURRENT	(1 << 1)
/* AVDD Powered Up */
#define AIC3204_LDO_AVDD_UP		(1 << 0)

/* TODO: Playback Configuration Registers */

/* Output Driver Power Control Register */
#define AIC3204_OUTDRV			AIC3204_PGREG(1, 9)
/* Left Headphone Driver Up */
#define AIC3204_OUTDRV_HPL_UP_SHIFT	(5)
/* Right Headphone Driver Up */
#define AIC3204_OUTDRV_HPR_UP_SHIFT	(4)
/* Left Line Output Driver Up */
#define AIC3204_OUTDRV_LOL_UP_SHIFT	(3)
/* Right Line Output Driver Up */
#define AIC3204_OUTDRV_LOR_UP_SHIFT	(2)
/* Left Mixer Amplifier Up */
#define AIC3204_OUTDRV_MAL_UP_SHIFT	(1)
/* Right Mixer Amplifier Up */
#define AIC3204_OUTDRV_MAR_UP_SHIFT	(0)

/* Common Mode Control Register */
#define AIC3204_CMCTL			AIC3204_PGREG(1, 10)
/* Full Chip Common Mode = 0.9V */
#define AIC3204_CMCTL_FCCM_0V9		(0 << 6)
/* Full Chip Common Mode = 0.75V */
#define AIC3204_CMCTL_FCCM_0V75		(1 << 6)
/* Full Chip Common Mode Mask */
#define AIC3204_CMCTL_FCCM		(1 << 6)
/* Headphone Output Common Mode = Full Chip Common Mode */
#define AIC3204_CMCTL_HPCM_FCCM		(0 << 4)
/* Headphone Output Common Mode = 1.25V */
#define AIC3204_CMCTL_HPCM_1V25		(1 << 4)
/* Headphone Output Common Mode = 1.5V */
#define AIC3204_CMCTL_HPCM_1V5		(2 << 4)
/* Headphone Output Common Mode = 1.65V */
#define AIC3204_CMCTL_HPCM_1V65		(3 << 4)
/* Headphone Output Common Mode Mask */
#define AIC3204_CMCTL_HPCM		(3 << 4)
/* Line Output Common Mode = Full Chip Common Mode */
#define AIC3204_CMCTL_LOCM_FCCM		(0 << 3)
/* Line Output Common Mode = 1.65V from LDOin */
#define AIC3204_CMCTL_LOCM_1V65LDOIN	(1 << 3)
/* Line Output Common Mode Mask */
#define AIC3204_CMCTL_LOCM		(1 << 3)
/* Headphone Output Common Mode Source = AVDD */
#define AIC3204_CMCTL_HPCMSRC_AVDD	(0 << 1)
/* Headphone Output Common Mode Source = LDOin */
#define AIC3204_CMCTL_HPCMSRC_LDOIN	(1 << 1)
/* Headphone Output Common Mode Source Mask */
#define AIC3204_CMCTL_HPCMSRC		(1 << 1)
/* LDO Input Range = 1.5~1.95V */
#define AIC3204_CMCTL_LDORANGE_1V5_1V95	(0 << 0)
/* LDO Input Range = 1.8~3.6V */
#define AIC3204_CMCTL_LDORANGE_1V8_3V6	(1 << 0)
/* LDO Input Range Mask (effective when HPCMSRC = LDOIN) */
#define AIC3204_CMCTL_LDORANGE		(1 << 0)

/* Over Current Protection Configuration Register TODO */
#define AIC3204_OCP			AIC3204_PGREG(1, 11)

/* Left Headphone Driver Routing Register */
#define AIC3204_HPLROUTE		AIC3204_PGREG(1, 12)
/* Left Headphone Driver connects to LDAC+ */
#define AIC3204_HPLROUTE_LDACP_SHIFT	(3)
/* Left Headphone Driver connects to IN1L */
#define AIC3204_HPLROUTE_IN1L_SHIFT	(2)
/* Left Headphone Driver connects to MAL */
#define AIC3204_HPLROUTE_MAL_SHIFT	(1)
/* Left Headphone Driver connects to MAR */
#define AIC3204_HPLROUTE_MAR_SHIFT	(0)

/* Right Headphone Driver Routing Register */
#define AIC3204_HPRROUTE		AIC3204_PGREG(1, 13)
/* Right Headphone Driver connects to LDAC- */
#define AIC3204_HPRROUTE_LDACN_SHIFT	(4)
/* Right Headphone Driver connects to RDAC+ */
#define AIC3204_HPRROUTE_RDACP_SHIFT	(3)
/* Right Headphone Driver connects to IN1L */
#define AIC3204_HPRROUTE_IN1R_SHIFT	(2)
/* Right Headphone Driver connects to MAL */
#define AIC3204_HPRROUTE_MAR_SHIFT	(1)
/* Right Headphone Driver connects to HPL */
#define AIC3204_HPRROUTE_HPL_SHIFT	(0)

/* Left Line Output Routing Register */
#define AIC3204_LOLROUTE		AIC3204_PGREG(1, 14)
/* Left Line Output Driver connects to RDAC- */
#define AIC3204_LOLROUTE_RDACN_SHIFT	(4)
/* Left Line Output Driver connects to LDAC+ */
#define AIC3204_LOLROUTE_LDACP_SHIFT	(3)
/* Left Line Output Driver connects to MAL */
#define AIC3204_LOLROUTE_MAL_SHIFT	(1)
/* Left Line Output Driver connects to LOR */
#define AIC3204_LOLROUTE_LOR_SHIFT	(0)

/* Right Line Output Routing Register */
#define AIC3204_LORROUTE		AIC3204_PGREG(1, 15)
/* Right Line Output Driver connects to RDAC+ */
#define AIC3204_LORROUTE_RDACP_SHIFT	(3)
/* Right Line Output Driver connects to MAR */
#define AIC3204_LORROUTE_MAR_SHIFT	(1)

/* Left Headphone Gain Setting Register */
#define AIC3204_HPLGAIN			AIC3204_PGREG(1, 16)
/* Left Headphone Mute */
#define AIC3204_HPLGAIN_MUTE_SHIFT	(6)
/* Left Headphone Gain Mask */
#define AIC3204_HPLGAIN_MASK		(0x3f)

/* Right Headphone Gain Setting Register */
#define AIC3204_HPRGAIN			AIC3204_PGREG(1, 17)
/* Right Headphone Mute */
#define AIC3204_HPRGAIN_MUTE_SHIFT	(6)
/* Right Headphone Gain Mask */
#define AIC3204_HPRGAIN_MASK		(0x3f)

/* Left Line Output Gain Setting Register */
#define AIC3204_LOLGAIN			AIC3204_PGREG(1, 18)
/* Left Line Output Mute */
#define AIC3204_LOLGAIN_MUTE_SHIFT	(6)
/* Left Line Output Gain Mask */
#define AIC3204_LOLGAIN_MASK		(0x3f)

/* Right Line Output Gain Setting Register */
#define AIC3204_LORGAIN			AIC3204_PGREG(1, 19)
/* Right Line Output Mute */
#define AIC3204_LORGAIN_MUTE_SHIFT	(6)
/* Right Line Output Gain Mask */
#define AIC3204_LORGAIN_MASK		(0x3f)

/* Left Mixer Amplifier Gain Setting Register */
#define AIC3204_MALGAIN			AIC3204_PGREG(1, 24)
/* Left Mixer Amplifier Gain Mask */
#define AIC3204_MALGAIN_MASK		(0x3f)

/* Right Mixer Amplifier Gain Setting Register */
#define AIC3204_MARGAIN			AIC3204_PGREG(1, 25)
/* Right Mixer Amplifier Gain Mask */
#define AIC3204_MARGAIN_MASK		(0x3f)

#define AIC3204_MICBIAS			AIC3204_PGREG(1, 51)

#define AIC3204_LMICPGAPROUTE		AIC3204_PGREG(1, 52)
#define AIC3204_LMICPGANROUTE		AIC3204_PGREG(1, 54)

#define AIC3204_RMICPGAPROUTE		AIC3204_PGREG(1, 55)
#define AIC3204_RMICPGANROUTE		AIC3204_PGREG(1, 57)

#define AIC3204_LMICPGAVOL		AIC3204_PGREG(1, 59)
#define AIC3204_RMICPGAVOL		AIC3204_PGREG(1, 60)

/* ADC Power Tune Mode Register */
#define AIC3204_ADCPTM			AIC3204_PGREG(1, 61)
/* ADC Power Tune Mode: PTM_R4 */
#define AIC3204_ADCPTM_R4		(0x00)
/* ADC Power Tune Mode: PTM_R3 */
#define AIC3204_ADCPTM_R3		(0x64)
/* ADC Power Tune Mode: PTM_R2 */
#define AIC3204_ADCPTM_R2		(0xb6)
/* ADC Power Tune Mode: PTM_R1 */
#define AIC3204_ADCPTM_R1		(0xff)

/* Analogue Input Quick Charging Configuration Register */
#define AIC3204_AIQC			AIC3204_PGREG(1, 71)
/* Power up time: Default Value (whatever that is) */
#define AIC3204_AIQC_PWRUP_DEFAULT	(0x00)
/* Power up time: 3.1ms */
#define AIC3204_AIQC_PWRUP_3M1S		(0x31)
/* Power up time: 6.4ms */
#define AIC3204_AIQC_PWRUP_6M4S		(0x32)
/* Power up time: 1.6ms */
#define AIC3204_AIQC_PWRUP_1M6S		(0x33)
/* Power up time mask */
#define AIC3204_AIQC_PWRUP		(0x3f)

/* Reference Power-Up Configuration Register */
#define AIC3204_REFPU			AIC3204_PGREG(1, 123)
/* Reference Power-Up delay: Slow */
#define AIC3204_REFPU_DELAY_SLOW	(0 << 0)
/* Reference Power-Up delay: 40ms */
#define AIC3204_REFPU_DELAY_40MS	(1 << 0)
/* Reference Power-Up delay: 80ms */
#define AIC3204_REFPU_DELAY_80MS	(2 << 0)
/* Reference Power-Up delay: 120ms */
#define AIC3204_REFPU_DELAY_120MS	(3 << 0)
/* Force power-up */
#define AIC3204_REFPU_FORCE		(1 << 2)

/* TODO: Define the remaining registers ... this will do for now */

/*
 * Since the AIC3204 has a great variety of settings to configure, rather than
 * provide individual module parameters for each of them, instead the machine
 * driver may pass in a const array of structs like this.
 *
 * This script of register modifications is run at initialisation, and is
 * intended to configure the AIC3204 for use with the particular hardware
 * surrounding it, e.g. GPIOs, filter coefficients, etc.
 */
struct aic3204_init_reg {
	/*
	 * The register to manipulate.  This register address contains the
	 * page number in the upper 8 bits -- use the AIC3204_PGREG macro
	 * to generate such a number.
	 */
	u16	reg;
	/*
	 * Flags: See the flags below; but this basically allows for the 
	 * value field to be ANDed or ORed with the register value, rather
	 * than setting it explicitly.
	 */
	u8	flags;
	/*
	 * The value to use in the operation
	 */
	u8	value;
};

/* Set Register = Value */
#define AIC3204_INITFLAG_SET		(0 << 0)
/* Set Register = Register & Value */
#define AIC3204_INITFLAG_AND		(1 << 0)
/* Set Register = Register | Value */
#define AIC3204_INITFLAG_OR		(2 << 0)
/* Set Register = Register ^ Value */
#define AIC3204_INITFLAG_XOR		(3 << 0)
/* Fail on Register != Value */
#define AIC3204_INITFLAG_FAILNEQ	(4 << 0)
/* Fail on Register == Value */
#define AIC3204_INITFLAG_FAILEQ		(5 << 0)
/* Fail on (Register & Value) == 0 */
#define AIC3204_INITFLAG_FAILNSET	(6 << 0)
/* Fail on (Register & Value) != 0 */
#define AIC3204_INITFLAG_FAILSET	(7 << 0)
/* Fail on (Register | Value) == 0xff */
#define AIC3204_INITFLAG_FAILCLR	(8 << 0)
/* Fail on (Register | Value) != 0xff */
#define AIC3204_INITFLAG_FAILNCLR	(9 << 0)
/* Register operation mask */
#define AIC3204_INITFLAG_OPMASK		(15 << 0)

struct aic3204_setup_data {
	/* List of initialisation settings to perform at startup */
	const struct aic3204_init_reg *init_reg_list;
	/* Length of initialisation register list */
	int init_reg_length;
	/* ADC/DAC channel mask */
	u8 channels;
};

#define AIC3204_LDAC_EN			(1 << 3)
#define AIC3204_RDAC_EN			(1 << 2)
#define AIC3204_LADC_EN			(1 << 1)
#define AIC3204_RADC_EN			(1 << 0)

extern struct snd_soc_dai aic3204_dai;
extern struct snd_soc_codec_device soc_codec_dev_aic3204;

#endif /* _AIC3204_H */

--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--eAbsdosE1cNLO4uF--
