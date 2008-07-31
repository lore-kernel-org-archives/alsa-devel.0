From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 10/11] wss_lib: use wss detection code instead
	of ad1848 one
Date: Thu, 31 Jul 2008 21:10:47 +0200
Message-ID: <20080731211047.2c06bfad.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 74C082447B
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:05:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the wss detection code and kill the ad1848 library.
The library is fully assimilated into the new wss library.

This required reworking of the AD1848 family code
so the code is changed to correctly detect chips from
the AD1848 and CS4231 families.

I have tested it on following cards:
Gallant SC-6600 (codec: AD1848, driver: snd-sc6600)
SoundScape VIVO/90 (codec: AD1845, driver: snd-sscape)
SG Waverider (codec: CS4231A, driver: Rene Herman's snd-galaxy)
Opti930 (codec: built-in - CS4231 compatible, driver: snd-opti93x)
Opti931 (codec: built-in - CS4231 compatible, driver: snd-opti93x)
Gallant SC-70P (chip/codec: CS4237B, driver: snd-cs4236)
Audio Plus 3D (chip/codec: CMI8330A, driver: snd-cmi8330)
Dell Latitude CP (chip/codec: cs4236, driver snd-cs4232)

Sound playback and recording works on all these cards.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Changes since previous version:

1. Remove AD1848_LIB symbol from the Kconfig.
2. Actually delete ad1848.h and ad1848_lib.c.
3. Leave different description for opti82x-ad1848
   and opti 92x-cs4231 drivers (they are still
   separated drivers).
4. One less assigment in if.

diff -urpN linux-ref/include/sound/ad1848.h linux-2.6.26/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/include/sound/ad1848.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,111 +0,0 @@
-#ifndef __SOUND_AD1848_H
-#define __SOUND_AD1848_H
-
-/*
- *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
- *  Definitions for AD1847/AD1848/CS4248 chips
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#include "pcm.h"
-#include <linux/interrupt.h>
-
-#include "wss.h"	/* temporary till the driver is removed */
-
-/* codec registers */
-
-#define AD1848_LEFT_INPUT	0x00	/* left input control */
-#define AD1848_RIGHT_INPUT	0x01	/* right input control */
-#define AD1848_AUX1_LEFT_INPUT	0x02	/* left AUX1 input control */
-#define AD1848_AUX1_RIGHT_INPUT	0x03	/* right AUX1 input control */
-#define AD1848_AUX2_LEFT_INPUT	0x04	/* left AUX2 input control */
-#define AD1848_AUX2_RIGHT_INPUT	0x05	/* right AUX2 input control */
-#define AD1848_LEFT_OUTPUT	0x06	/* left output control register */
-#define AD1848_RIGHT_OUTPUT	0x07	/* right output control register */
-#define AD1848_DATA_FORMAT	0x08	/* clock and data format - playback/capture - bits 7-0 MCE */
-#define AD1848_IFACE_CTRL	0x09	/* interface control - bits 7-2 MCE */
-#define AD1848_PIN_CTRL		0x0a	/* pin control */
-#define AD1848_TEST_INIT	0x0b	/* test and initialization */
-#define AD1848_MISC_INFO	0x0c	/* miscellaneous information */
-#define AD1848_LOOPBACK		0x0d	/* loopback control */
-#define AD1848_DATA_UPR_CNT	0x0e	/* playback/capture upper base count */
-#define AD1848_DATA_LWR_CNT	0x0f	/* playback/capture lower base count */
-
-/* definitions for codec register select port - CODECP( REGSEL ) */
-
-#define AD1848_INIT		0x80	/* CODEC is initializing */
-#define AD1848_MCE		0x40	/* mode change enable */
-#define AD1848_TRD		0x20	/* transfer request disable */
-
-/* definitions for codec status register - CODECP( STATUS ) */
-
-#define AD1848_GLOBALIRQ	0x01	/* IRQ is active */
-
-/* definitions for AD1848_LEFT_INPUT and AD1848_RIGHT_INPUT registers */
-
-#define AD1848_ENABLE_MIC_GAIN	0x20
-
-#define AD1848_MIXS_LINE1	0x00
-#define AD1848_MIXS_AUX1	0x40
-#define AD1848_MIXS_LINE2	0x80
-#define AD1848_MIXS_ALL		0xc0
-
-/* definitions for clock and data format register - AD1848_PLAYBK_FORMAT */
-
-#define AD1848_LINEAR_8		0x00	/* 8-bit unsigned data */
-#define AD1848_ALAW_8		0x60	/* 8-bit A-law companded */
-#define AD1848_ULAW_8		0x20	/* 8-bit U-law companded */
-#define AD1848_LINEAR_16	0x40	/* 16-bit twos complement data - little endian */
-#define AD1848_STEREO		0x10	/* stereo mode */
-/* bits 3-1 define frequency divisor */
-#define AD1848_XTAL1		0x00	/* 24.576 crystal */
-#define AD1848_XTAL2		0x01	/* 16.9344 crystal */
-
-/* definitions for interface control register - AD1848_IFACE_CTRL */
-
-#define AD1848_CAPTURE_PIO	0x80	/* capture PIO enable */
-#define AD1848_PLAYBACK_PIO	0x40	/* playback PIO enable */
-#define AD1848_CALIB_MODE	0x18	/* calibration mode bits */
-#define AD1848_AUTOCALIB	0x08	/* auto calibrate */
-#define AD1848_SINGLE_DMA	0x04	/* use single DMA channel */
-#define AD1848_CAPTURE_ENABLE	0x02	/* capture enable */
-#define AD1848_PLAYBACK_ENABLE	0x01	/* playback enable */
-
-/* definitions for pin control register - AD1848_PIN_CTRL */
-
-#define AD1848_IRQ_ENABLE	0x02	/* enable IRQ */
-#define AD1848_XCTL1		0x40	/* external control #1 */
-#define AD1848_XCTL0		0x80	/* external control #0 */
-
-/* definitions for test and init register - AD1848_TEST_INIT */
-
-#define AD1848_CALIB_IN_PROGRESS 0x20	/* auto calibrate in progress */
-#define AD1848_DMA_REQUEST	0x10	/* DMA request in progress */
-
-/* exported functions */
-
-void snd_ad1848_out(struct snd_wss *chip, unsigned char reg,
-		    unsigned char value);
-
-int snd_ad1848_create(struct snd_card *card,
-		      unsigned long port,
-		      int irq, int dma,
-		      unsigned short hardware,
-		      struct snd_wss **chip);
-
-#endif /* __SOUND_AD1848_H */
diff -urpN linux-ref/sound/isa/Kconfig linux-2.6.26/sound/isa/Kconfig
--- linux-ref/sound/isa/Kconfig	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/Kconfig	2008-07-31 19:22:16.000000000 +0200
@@ -4,11 +4,6 @@ config SND_WSS_LIB
         tristate
         select SND_PCM
 
-config SND_AD1848_LIB
-        tristate
-        select SND_PCM
-        select SND_WSS_LIB
-
 config SND_SB_COMMON
         tristate
 
@@ -56,7 +51,7 @@ config SND_AD1816A
 
 config SND_AD1848
 	tristate "Generic AD1848/CS4248 driver"
-	select SND_AD1848_LIB
+	select SND_WSS_LIB
 	help
 	  Say Y here to include support for AD1848 (Analog Devices) or
 	  CS4248 (Cirrus Logic - Crystal Semiconductors) chips.
@@ -97,7 +92,7 @@ config SND_AZT2320
 
 config SND_CMI8330
 	tristate "C-Media CMI8330"
-	select SND_AD1848_LIB
+	select SND_WSS_LIB
 	select SND_SB16_DSP
 	help
 	  Say Y here to include support for soundcards based on the
@@ -193,7 +188,7 @@ config SND_ES18XX
 config SND_SC6000
 	tristate "Gallant SC-6000, Audio Excel DSP 16"
 	depends on HAS_IOPORT
-	select SND_AD1848_LIB
+	select SND_WSS_LIB
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	help
@@ -280,7 +275,7 @@ config SND_OPTI92X_AD1848
 	select SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
-	select SND_AD1848_LIB
+	select SND_WSS_LIB
 	help
 	  Say Y here to include support for soundcards based on Opti
 	  82C92x or OTI-601 chips and using an AD1848 codec.
@@ -373,7 +368,7 @@ config SND_SB16_CSP
 
 config SND_SGALAXY
 	tristate "Aztech Sound Galaxy"
-	select SND_AD1848_LIB
+	select SND_WSS_LIB
 	help
 	  Say Y here to include support for Aztech Sound Galaxy
 	  soundcards.
diff -urpN linux-ref/sound/isa/ad1848/Makefile linux-2.6.26/sound/isa/ad1848/Makefile
--- linux-ref/sound/isa/ad1848/Makefile	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/Makefile	2008-07-31 19:17:44.000000000 +0200
@@ -3,10 +3,8 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@perex.cz>
 #
 
-snd-ad1848-lib-objs := ad1848_lib.o
 snd-ad1848-objs := ad1848.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AD1848) += snd-ad1848.o
-obj-$(CONFIG_SND_AD1848_LIB) += snd-ad1848-lib.o
 
diff -urpN linux-ref/sound/isa/ad1848/ad1848.c linux-2.6.26/sound/isa/ad1848/ad1848.c
--- linux-ref/sound/isa/ad1848/ad1848.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848.c	2008-07-31 19:17:44.000000000 +0200
@@ -28,7 +28,7 @@
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
-#include <sound/ad1848.h>
+#include <sound/wss.h>
 #include <sound/initval.h>
 
 #define CRD_NAME "Generic AD1848/AD1847/CS4248"
@@ -95,8 +95,9 @@ static int __devinit snd_ad1848_probe(st
 	if (!card)
 		return -EINVAL;
 
-	error = snd_ad1848_create(card, port[n], irq[n], dma1[n],
-			thinkpad[n] ? WSS_HW_THINKPAD : WSS_HW_DETECT, &chip);
+	error = snd_wss_create(card, port[n], -1, irq[n], dma1[n], -1,
+			thinkpad[n] ? WSS_HW_THINKPAD : WSS_HW_DETECT,
+			0, &chip);
 	if (error < 0)
 		goto out;
 
diff -urpN linux-ref/sound/isa/ad1848/ad1848_lib.c linux-2.6.26/sound/isa/ad1848/ad1848_lib.c
--- linux-ref/sound/isa/ad1848/ad1848_lib.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848_lib.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,487 +0,0 @@
-/*
- *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
- *  Routines for control of AD1848/AD1847/CS4248
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#define SNDRV_MAIN_OBJECT_FILE
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <sound/core.h>
-#include <sound/ad1848.h>
-#include <sound/control.h>
-#include <sound/tlv.h>
-#include <sound/pcm_params.h>
-
-#include <asm/io.h>
-#include <asm/dma.h>
-
-MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
-MODULE_DESCRIPTION("Routines for control of AD1848/AD1847/CS4248");
-MODULE_LICENSE("GPL");
-
-#if 0
-#define SNDRV_DEBUG_MCE
-#endif
-
-/*
- *  Some variables
- */
-
-static unsigned char snd_ad1848_original_image[16] =
-{
-	0x00,			/* 00 - lic */
-	0x00,			/* 01 - ric */
-	0x9f,			/* 02 - la1ic */
-	0x9f,			/* 03 - ra1ic */
-	0x9f,			/* 04 - la2ic */
-	0x9f,			/* 05 - ra2ic */
-	0xbf,			/* 06 - loc */
-	0xbf,			/* 07 - roc */
-	0x20,			/* 08 - dfr */
-	AD1848_AUTOCALIB,	/* 09 - ic */
-	0x00,			/* 0a - pc */
-	0x00,			/* 0b - ti */
-	0x00,			/* 0c - mi */
-	0x00,			/* 0d - lbc */
-	0x00,			/* 0e - dru */
-	0x00,			/* 0f - drl */
-};
-
-/*
- *  Basic I/O functions
- */
-
-static void snd_ad1848_wait(struct snd_wss *chip)
-{
-	int timeout;
-
-	for (timeout = 250; timeout > 0; timeout--) {
-		if ((inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT) == 0)
-			break;
-		udelay(100);
-	}
-}
-
-void snd_ad1848_out(struct snd_wss *chip,
-			   unsigned char reg,
-			   unsigned char value)
-{
-	snd_ad1848_wait(chip);
-#ifdef CONFIG_SND_DEBUG
-	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING "auto calibration time out - "
-			   "reg = 0x%x, value = 0x%x\n", reg, value);
-#endif
-	outb(chip->mce_bit | reg, chip->port + CS4231P(REGSEL));
-	outb(chip->image[reg] = value, chip->port + CS4231P(REG));
-	mb();
-	snd_printdd("codec out - reg 0x%x = 0x%x\n",
-			chip->mce_bit | reg, value);
-}
-
-EXPORT_SYMBOL(snd_ad1848_out);
-
-static unsigned char snd_ad1848_in(struct snd_wss *chip, unsigned char reg)
-{
-	snd_ad1848_wait(chip);
-#ifdef CONFIG_SND_DEBUG
-	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING "auto calibration time out - "
-			   "reg = 0x%x\n", reg);
-#endif
-	outb(chip->mce_bit | reg, chip->port + CS4231P(REGSEL));
-	mb();
-	return inb(chip->port + CS4231P(REG));
-}
-
-#if 0
-
-static void snd_ad1848_debug(struct snd_wss *chip)
-{
-	printk(KERN_DEBUG "AD1848 REGS:      INDEX = 0x%02x  ", inb(chip->port + CS4231P(REGSEL)));
-	printk(KERN_DEBUG "                 STATUS = 0x%02x\n", inb(chip->port + CS4231P(STATUS)));
-	printk(KERN_DEBUG "  0x00: left input      = 0x%02x  ", snd_ad1848_in(chip, 0x00));
-	printk(KERN_DEBUG "  0x08: playback format = 0x%02x\n", snd_ad1848_in(chip, 0x08));
-	printk(KERN_DEBUG "  0x01: right input     = 0x%02x  ", snd_ad1848_in(chip, 0x01));
-	printk(KERN_DEBUG "  0x09: iface (CFIG 1)  = 0x%02x\n", snd_ad1848_in(chip, 0x09));
-	printk(KERN_DEBUG "  0x02: AUXA left       = 0x%02x  ", snd_ad1848_in(chip, 0x02));
-	printk(KERN_DEBUG "  0x0a: pin control     = 0x%02x\n", snd_ad1848_in(chip, 0x0a));
-	printk(KERN_DEBUG "  0x03: AUXA right      = 0x%02x  ", snd_ad1848_in(chip, 0x03));
-	printk(KERN_DEBUG "  0x0b: init & status   = 0x%02x\n", snd_ad1848_in(chip, 0x0b));
-	printk(KERN_DEBUG "  0x04: AUXB left       = 0x%02x  ", snd_ad1848_in(chip, 0x04));
-	printk(KERN_DEBUG "  0x0c: revision & mode = 0x%02x\n", snd_ad1848_in(chip, 0x0c));
-	printk(KERN_DEBUG "  0x05: AUXB right      = 0x%02x  ", snd_ad1848_in(chip, 0x05));
-	printk(KERN_DEBUG "  0x0d: loopback        = 0x%02x\n", snd_ad1848_in(chip, 0x0d));
-	printk(KERN_DEBUG "  0x06: left output     = 0x%02x  ", snd_ad1848_in(chip, 0x06));
-	printk(KERN_DEBUG "  0x0e: data upr count  = 0x%02x\n", snd_ad1848_in(chip, 0x0e));
-	printk(KERN_DEBUG "  0x07: right output    = 0x%02x  ", snd_ad1848_in(chip, 0x07));
-	printk(KERN_DEBUG "  0x0f: data lwr count  = 0x%02x\n", snd_ad1848_in(chip, 0x0f));
-}
-
-#endif
-
-/*
- *  AD1848 detection / MCE routines
- */
-
-static void snd_ad1848_mce_up(struct snd_wss *chip)
-{
-	unsigned long flags;
-	int timeout;
-
-	snd_ad1848_wait(chip);
-#ifdef CONFIG_SND_DEBUG
-	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING "mce_up - auto calibration time out (0)\n");
-#endif
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->mce_bit |= AD1848_MCE;
-	timeout = inb(chip->port + CS4231P(REGSEL));
-	if (timeout == 0x80)
-		snd_printk(KERN_WARNING "mce_up [0x%lx]: serious init problem - codec still busy\n", chip->port);
-	if (!(timeout & AD1848_MCE))
-		outb(chip->mce_bit | (timeout & 0x1f),
-		     chip->port + CS4231P(REGSEL));
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-}
-
-static void snd_ad1848_mce_down(struct snd_wss *chip)
-{
-	unsigned long flags, timeout;
-	int reg;
-
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	for (timeout = 5; timeout > 0; timeout--)
-		inb(chip->port + CS4231P(REGSEL));
-	/* end of cleanup sequence */
-	for (timeout = 12000;
-	     timeout > 0 && (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT);
-	     timeout--)
-		udelay(100);
-
-	snd_printdd("(1) timeout = %ld\n", timeout);
-
-#ifdef CONFIG_SND_DEBUG
-	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING
-			   "mce_down [0x%lx] - auto calibration time out (0)\n",
-			   chip->port + CS4231P(REGSEL));
-#endif
-
-	chip->mce_bit &= ~AD1848_MCE;
-	reg = inb(chip->port + CS4231P(REGSEL));
-	outb(chip->mce_bit | (reg & 0x1f), chip->port + CS4231P(REGSEL));
-	if (reg == 0x80)
-		snd_printk(KERN_WARNING "mce_down [0x%lx]: serious init problem - codec still busy\n", chip->port);
-	if ((reg & AD1848_MCE) == 0) {
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		return;
-	}
-
-	/*
-	 * Wait for auto-calibration (AC) process to finish, i.e. ACI to go low.
-	 * It may take up to 5 sample periods (at most 907 us @ 5.5125 kHz) for
-	 * the process to _start_, so it is important to wait at least that long
-	 * before checking.  Otherwise we might think AC has finished when it
-	 * has in fact not begun.  It could take 128 (no AC) or 384 (AC) cycles
-	 * for ACI to drop.  This gives a wait of at most 70 ms with a more
-	 * typical value of 3-9 ms.
-	 */
-	timeout = jiffies + msecs_to_jiffies(250);
-	do {
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		msleep(1);
-		spin_lock_irqsave(&chip->reg_lock, flags);
-		reg = snd_ad1848_in(chip, AD1848_TEST_INIT) &
-		      AD1848_CALIB_IN_PROGRESS;
-	} while (reg && time_before(jiffies, timeout));
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	if (reg)
-		snd_printk(KERN_ERR
-			   "mce_down - auto calibration time out (2)\n");
-
-	snd_printdd("(4) jiffies = %lu\n", jiffies);
-	snd_printd("mce_down - exit = 0x%x\n",
-		   inb(chip->port + CS4231P(REGSEL)));
-}
-
-static irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id)
-{
-	struct snd_wss *chip = dev_id;
-
-	if ((chip->mode & WSS_MODE_PLAY) && chip->playback_substream)
-		snd_pcm_period_elapsed(chip->playback_substream);
-	if ((chip->mode & WSS_MODE_RECORD) && chip->capture_substream)
-		snd_pcm_period_elapsed(chip->capture_substream);
-	outb(0, chip->port + CS4231P(STATUS));	/* clear global interrupt bit */
-	return IRQ_HANDLED;
-}
-
-/*
-
- */
-
-static void snd_ad1848_thinkpad_twiddle(struct snd_wss *chip, int on)
-{
-	int tmp;
-
-	if (!chip->thinkpad_flag) return;
-
-	outb(0x1c, AD1848_THINKPAD_CTL_PORT1);
-	tmp = inb(AD1848_THINKPAD_CTL_PORT2);
-
-	if (on)
-		/* turn it on */
-		tmp |= AD1848_THINKPAD_CS4248_ENABLE_BIT;
-	else
-		/* turn it off */
-		tmp &= ~AD1848_THINKPAD_CS4248_ENABLE_BIT;
-	
-	outb(tmp, AD1848_THINKPAD_CTL_PORT2);
-
-}
-
-#ifdef CONFIG_PM
-static void snd_ad1848_suspend(struct snd_wss *chip)
-{
-	snd_pcm_suspend_all(chip->pcm);
-	if (chip->thinkpad_flag)
-		snd_ad1848_thinkpad_twiddle(chip, 0);
-}
-
-static void snd_ad1848_resume(struct snd_wss *chip)
-{
-	int i;
-
-	if (chip->thinkpad_flag)
-		snd_ad1848_thinkpad_twiddle(chip, 1);
-
-	/* clear any pendings IRQ */
-	inb(chip->port + CS4231P(STATUS));
-	outb(0, chip->port + CS4231P(STATUS));
-	mb();
-
-	snd_ad1848_mce_down(chip);
-	for (i = 0; i < 16; i++)
-		snd_ad1848_out(chip, i, chip->image[i]);
-	snd_ad1848_mce_up(chip);
-	snd_ad1848_mce_down(chip);
-}
-#endif /* CONFIG_PM */
-
-static int snd_ad1848_probe(struct snd_wss *chip)
-{
-	unsigned long flags;
-	int i, id, rev, ad1847;
-	unsigned char *ptr;
-
-#if 0
-	snd_ad1848_debug(chip);
-#endif
-	id = ad1847 = 0;
-	for (i = 0; i < 1000; i++) {
-		mb();
-		if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
-			udelay(500);
-		else {
-			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_ad1848_out(chip, AD1848_MISC_INFO, 0x00);
-			snd_ad1848_out(chip, AD1848_LEFT_INPUT, 0xaa);
-			snd_ad1848_out(chip, AD1848_RIGHT_INPUT, 0x45);
-			rev = snd_ad1848_in(chip, AD1848_RIGHT_INPUT);
-			if (rev == 0x65) {
-				spin_unlock_irqrestore(&chip->reg_lock, flags);
-				id = 1;
-				ad1847 = 1;
-				break;
-			}
-			if (snd_ad1848_in(chip, AD1848_LEFT_INPUT) == 0xaa && rev == 0x45) {
-				spin_unlock_irqrestore(&chip->reg_lock, flags);
-				id = 1;
-				break;
-			}
-			spin_unlock_irqrestore(&chip->reg_lock, flags);
-		}
-	}
-	if (id != 1)
-		return -ENODEV;	/* no valid device found */
-	if (chip->hardware == WSS_HW_DETECT) {
-		if (ad1847) {
-			chip->hardware = WSS_HW_AD1847;
-		} else {
-			chip->hardware = WSS_HW_AD1848;
-			rev = snd_ad1848_in(chip, AD1848_MISC_INFO);
-			if (rev & 0x80) {
-				chip->hardware = WSS_HW_CS4248;
-			} else if ((rev & 0x0f) == 0x0a) {
-				snd_ad1848_out(chip, AD1848_MISC_INFO, 0x40);
-				for (i = 0; i < 16; ++i) {
-					if (snd_ad1848_in(chip, i) != snd_ad1848_in(chip, i + 16)) {
-						chip->hardware = WSS_HW_CMI8330;
-						break;
-					}
-				}
-				snd_ad1848_out(chip, AD1848_MISC_INFO, 0x00);
-			}
-		}
-	}
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	inb(chip->port + CS4231P(STATUS));	/* clear any pendings IRQ */
-	outb(0, chip->port + CS4231P(STATUS));
-	mb();
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-
-	chip->image[AD1848_MISC_INFO] = 0x00;
-	chip->image[AD1848_IFACE_CTRL] =
-	    (chip->image[AD1848_IFACE_CTRL] & ~AD1848_SINGLE_DMA) | AD1848_SINGLE_DMA;
-	ptr = (unsigned char *) &chip->image;
-	snd_ad1848_mce_down(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	for (i = 0; i < 16; i++)	/* ok.. fill all AD1848 registers */
-		snd_ad1848_out(chip, i, *ptr++);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_up(chip);
-	/* init needed for WSS pcm */
-	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE |
-				AD1848_PLAYBACK_PIO |
-				AD1848_CAPTURE_ENABLE |
-				AD1848_CAPTURE_PIO |
-				AD1848_CALIB_MODE);
-	chip->image[AD1848_IFACE_CTRL] |= AD1848_AUTOCALIB;
-	snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-	return 0;		/* all things are ok.. */
-}
-
-/*
-
- */
-
-static int snd_ad1848_free(struct snd_wss *chip)
-{
-	release_and_free_resource(chip->res_port);
-	if (chip->irq >= 0)
-		free_irq(chip->irq, (void *) chip);
-	if (chip->dma1 >= 0) {
-		snd_dma_disable(chip->dma1);
-		free_dma(chip->dma1);
-	}
-	kfree(chip);
-	return 0;
-}
-
-static int snd_ad1848_dev_free(struct snd_device *device)
-{
-	struct snd_wss *chip = device->device_data;
-	return snd_ad1848_free(chip);
-}
-
-int snd_ad1848_create(struct snd_card *card,
-		      unsigned long port,
-		      int irq, int dma,
-		      unsigned short hardware,
-		      struct snd_wss **rchip)
-{
-	static struct snd_device_ops ops = {
-		.dev_free =	snd_ad1848_dev_free,
-	};
-	struct snd_wss *chip;
-	int err;
-
-	*rchip = NULL;
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-	spin_lock_init(&chip->reg_lock);
-	chip->card = card;
-	chip->port = port;
-	chip->irq = -1;
-	chip->dma1 = -1;
-	chip->dma2 = -1;
-	chip->single_dma = 1;
-	chip->hardware = hardware;
-	memcpy(&chip->image, &snd_ad1848_original_image, sizeof(snd_ad1848_original_image));
-	
-	if ((chip->res_port = request_region(port, 4, "AD1848")) == NULL) {
-		snd_printk(KERN_ERR "ad1848: can't grab port 0x%lx\n", port);
-		snd_ad1848_free(chip);
-		return -EBUSY;
-	}
-	if (request_irq(irq, snd_ad1848_interrupt, IRQF_DISABLED, "AD1848", (void *) chip)) {
-		snd_printk(KERN_ERR "ad1848: can't grab IRQ %d\n", irq);
-		snd_ad1848_free(chip);
-		return -EBUSY;
-	}
-	chip->irq = irq;
-	if (request_dma(dma, "AD1848")) {
-		snd_printk(KERN_ERR "ad1848: can't grab DMA %d\n", dma);
-		snd_ad1848_free(chip);
-		return -EBUSY;
-	}
-	chip->dma1 = dma;
-	chip->dma2 = dma;
-
-	if (hardware == WSS_HW_THINKPAD) {
-		chip->thinkpad_flag = 1;
-		chip->hardware = WSS_HW_DETECT; /* reset */
-		snd_ad1848_thinkpad_twiddle(chip, 1);
-	}
-
-	if (snd_ad1848_probe(chip) < 0) {
-		snd_ad1848_free(chip);
-		return -ENODEV;
-	}
-
-	/* Register device */
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_ad1848_free(chip);
-		return err;
-	}
-
-#ifdef CONFIG_PM
-	chip->suspend = snd_ad1848_suspend;
-	chip->resume = snd_ad1848_resume;
-#endif
-
-	*rchip = chip;
-	return 0;
-}
-
-EXPORT_SYMBOL(snd_ad1848_create);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_ad1848_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_ad1848_exit(void)
-{
-}
-
-module_init(alsa_ad1848_init)
-module_exit(alsa_ad1848_exit)
diff -urpN linux-ref/sound/isa/cmi8330.c linux-2.6.26/sound/isa/cmi8330.c
--- linux-ref/sound/isa/cmi8330.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/cmi8330.c	2008-07-31 19:19:10.000000000 +0200
@@ -50,7 +50,7 @@
 #include <linux/pnp.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
-#include <sound/ad1848.h>
+#include <sound/wss.h>
 #include <sound/sb.h>
 #include <sound/initval.h>
 
@@ -180,9 +180,9 @@ WSS_DOUBLE("Master Playback Volume", 0,
 WSS_SINGLE("Loud Playback Switch", 0,
 		CMI8330_MUTEMUX, 6, 1, 1),
 WSS_DOUBLE("PCM Playback Switch", 0,
-		AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
 WSS_DOUBLE("PCM Playback Volume", 0,
-		AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1),
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
 WSS_DOUBLE("Line Playback Switch", 0,
 		CMI8330_MUTEMUX, CMI8330_MUTEMUX, 4, 3, 1, 0),
 WSS_DOUBLE("Line Playback Volume", 0,
@@ -489,12 +489,11 @@ static int __devinit snd_cmi8330_probe(s
 	int i, err;
 
 	acard = card->private_data;
-	if ((err = snd_ad1848_create(card,
-				     wssport[dev] + 4,
-				     wssirq[dev],
-				     wssdma[dev],
-				     WSS_HW_DETECT,
-				     &acard->wss)) < 0) {
+	err = snd_wss_create(card, wssport[dev] + 4, -1,
+			     wssirq[dev],
+			     wssdma[dev], -1,
+			     WSS_HW_DETECT, 0, &acard->wss);
+	if (err < 0) {
 		snd_printk(KERN_ERR PFX "(AD1848) device busy??\n");
 		return err;
 	}
@@ -517,9 +516,10 @@ static int __devinit snd_cmi8330_probe(s
 		return err;
 	}
 
-	snd_ad1848_out(acard->wss, AD1848_MISC_INFO, 0x40); /* switch on MODE2 */
+	snd_wss_out(acard->wss, CS4231_MISC_INFO, 0x40); /* switch on MODE2 */
 	for (i = CMI8330_RMUX3D; i <= CMI8330_CDINGAIN; i++)
-		snd_ad1848_out(acard->wss, i, snd_cmi8330_image[i - CMI8330_RMUX3D]);
+		snd_wss_out(acard->wss, i,
+			    snd_cmi8330_image[i - CMI8330_RMUX3D]);
 
 	if ((err = snd_cmi8330_mixer(card, acard)) < 0) {
 		snd_printk(KERN_ERR PFX "failed to create mixers\n");
diff -urpN linux-ref/sound/isa/opti9xx/opti92x-ad1848.c linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-ref/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/opti9xx/opti92x-ad1848.c	2008-07-31 19:27:21.000000000 +0200
@@ -33,11 +33,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
-#if defined(CS4231) || defined(OPTi93X)
 #include <sound/wss.h>
-#else
-#include <sound/ad1848.h>
-#endif	/* CS4231 */
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
 #ifndef OPTi93X
@@ -148,9 +144,7 @@ struct snd_opti9xx {
 	long wss_base;
 	int irq;
 	int dma1;
-#if defined(CS4231) || defined(OPTi93X)
 	int dma2;
-#endif	/* CS4231 || OPTi93X */
 
 	long fm_port;
 
@@ -225,9 +219,7 @@ static int __devinit snd_opti9xx_init(st
 	chip->wss_base = -1;
 	chip->irq = -1;
 	chip->dma1 = -1;
-#if defined(CS4231) || defined (OPTi93X)
 	chip->dma2 = -1;
-#endif 	/* CS4231 || OPTi93X */
 	chip->fm_port = -1;
 	chip->mpu_port = -1;
 	chip->mpu_irq = -1;
@@ -740,7 +732,6 @@ static int __devinit snd_opti9xx_probe(s
 	if (error)
 		return error;
 
-#if defined(CS4231) || defined(OPTi93X)
 	error = snd_wss_create(card, chip->wss_base + 4, -1,
 			       chip->irq, chip->dma1, chip->dma2,
 #ifdef CS4231
@@ -754,12 +745,6 @@ static int __devinit snd_opti9xx_probe(s
 #ifdef OPTi93X
 	chip->codec = codec;
 #endif
-#else
-	error = snd_ad1848_create(card, chip->wss_base + 4, chip->irq,
-				  chip->dma1, WSS_HW_DETECT, &codec);
-	if (error < 0)
-		return error;
-#endif
 	error = snd_wss_pcm(codec, 0, &pcm);
 	if (error < 0)
 		return error;
diff -urpN linux-ref/sound/isa/sc6000.c linux-2.6.26/sound/isa/sc6000.c
--- linux-ref/sound/isa/sc6000.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/sc6000.c	2008-07-31 19:17:46.000000000 +0200
@@ -29,7 +29,7 @@
 #include <linux/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
-#include <sound/ad1848.h>
+#include <sound/wss.h>
 #include <sound/opl3.h>
 #include <sound/mpu401.h>
 #include <sound/control.h>
@@ -548,8 +548,8 @@ static int __devinit snd_sc6000_probe(st
 	if (err < 0)
 		goto err_unmap2;
 
-	err = snd_ad1848_create(card, mss_port[dev] + 4, xirq, xdma,
-				WSS_HW_DETECT, &chip);
+	err = snd_wss_create(card, mss_port[dev] + 4,  -1, xirq, xdma, -1,
+			     WSS_HW_DETECT, 0, &chip);
 	if (err < 0)
 		goto err_unmap2;
 	card->private_data = chip;
diff -urpN linux-ref/sound/isa/sgalaxy.c linux-2.6.26/sound/isa/sgalaxy.c
--- linux-ref/sound/isa/sgalaxy.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/sgalaxy.c	2008-07-31 19:17:46.000000000 +0200
@@ -31,7 +31,7 @@
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/sb.h>
-#include <sound/ad1848.h>
+#include <sound/wss.h>
 #include <sound/control.h>
 #define SNDRV_LEGACY_FIND_FREE_IRQ
 #define SNDRV_LEGACY_FIND_FREE_DMA
@@ -267,9 +267,10 @@ static int __devinit snd_sgalaxy_probe(s
 	if ((err = snd_sgalaxy_detect(dev, xirq, xdma1)) < 0)
 		goto _err;
 
-	if ((err = snd_ad1848_create(card, wssport[dev] + 4,
-				     xirq, xdma1,
-				     WSS_HW_DETECT, &chip)) < 0)
+	err = snd_wss_create(card, wssport[dev] + 4, -1,
+			     xirq, xdma1, -1,
+			     WSS_HW_DETECT, 0, &chip);
+	if (err < 0)
 		goto _err;
 	card->private_data = chip;
 
@@ -331,8 +332,8 @@ static int snd_sgalaxy_resume(struct dev
 	struct snd_wss *chip = card->private_data;
 
 	chip->resume(chip);
-	snd_ad1848_out(chip, SGALAXY_AUXC_LEFT, chip->image[SGALAXY_AUXC_LEFT]);
-	snd_ad1848_out(chip, SGALAXY_AUXC_RIGHT, chip->image[SGALAXY_AUXC_RIGHT]);
+	snd_wss_out(chip, SGALAXY_AUXC_LEFT, chip->image[SGALAXY_AUXC_LEFT]);
+	snd_wss_out(chip, SGALAXY_AUXC_RIGHT, chip->image[SGALAXY_AUXC_RIGHT]);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
diff -urpN linux-ref/sound/isa/wss/wss_lib.c linux-2.6.26/sound/isa/wss/wss_lib.c
--- linux-ref/sound/isa/wss/wss_lib.c	2008-07-31 19:18:15.000000000 +0200
+++ linux-2.6.26/sound/isa/wss/wss_lib.c	2008-07-31 19:17:46.000000000 +0200
@@ -1073,7 +1073,11 @@ irqreturn_t snd_wss_interrupt(int irq, v
 	struct snd_wss *chip = dev_id;
 	unsigned char status;
 
-	status = snd_wss_in(chip, CS4231_IRQ_STATUS);
+	if (chip->hardware & WSS_HW_AD1848_MASK)
+		/* pretend it was the only possible irq for AD1848 */
+		status = CS4231_PLAYBACK_IRQ;
+	else
+		status = snd_wss_in(chip, CS4231_IRQ_STATUS);
 	if (status & CS4231_TIMER_IRQ) {
 		if (chip->timer)
 			snd_timer_interrupt(chip->timer, chip->timer->sticks);
@@ -1105,7 +1109,11 @@ irqreturn_t snd_wss_interrupt(int irq, v
 	}
 
 	spin_lock(&chip->reg_lock);
-	snd_wss_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
+	status = ~CS4231_ALL_IRQS | ~status;
+	if (chip->hardware & WSS_HW_AD1848_MASK)
+		wss_outb(chip, CS4231P(STATUS), 0);
+	else
+		snd_wss_outm(chip, CS4231_IRQ_STATUS, status, 0);
 	spin_unlock(&chip->reg_lock);
 	return IRQ_HANDLED;
 }
@@ -1137,36 +1145,112 @@ static snd_pcm_uframes_t snd_wss_capture
 
  */
 
-static int snd_wss_probe(struct snd_wss *chip)
+static int snd_ad1848_probe(struct snd_wss *chip)
 {
 	unsigned long flags;
-	int i, id, rev;
-	unsigned char *ptr;
-	unsigned int hw;
+	int i, id, rev, ad1847;
 
-#if 0
-	snd_wss_debug(chip);
-#endif
 	id = 0;
-	for (i = 0; i < 50; i++) {
+	ad1847 = 0;
+	for (i = 0; i < 1000; i++) {
 		mb();
-		if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
-			udelay(2000);
+		if (inb(chip->port + CS4231P(REGSEL)) & CS4231_INIT)
+			msleep(1);
 		else {
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_wss_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
-			id = snd_wss_in(chip, CS4231_MISC_INFO) & 0x0f;
+			snd_wss_out(chip, CS4231_MISC_INFO, 0x00);
+			snd_wss_out(chip, CS4231_LEFT_INPUT, 0xaa);
+			snd_wss_out(chip, CS4231_RIGHT_INPUT, 0x45);
+			rev = snd_wss_in(chip, CS4231_RIGHT_INPUT);
+			if (rev == 0x65) {
+				spin_unlock_irqrestore(&chip->reg_lock, flags);
+				id = 1;
+				ad1847 = 1;
+				break;
+			}
+			if (snd_wss_in(chip, CS4231_LEFT_INPUT) == 0xaa &&
+			    rev == 0x45) {
+				spin_unlock_irqrestore(&chip->reg_lock, flags);
+				id = 1;
+				break;
+			}
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
-			if (id == 0x0a)
-				break;	/* this is valid value */
 		}
 	}
-	snd_printdd("wss: port = 0x%lx, id = 0x%x\n", chip->port, id);
-	if (id != 0x0a)
+	if (id != 1)
 		return -ENODEV;	/* no valid device found */
+	id = 0;
+	if (chip->hardware == WSS_HW_DETECT)
+		id = ad1847 ? WSS_HW_AD1847 : WSS_HW_AD1848;
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	inb(chip->port + CS4231P(STATUS));	/* clear any pendings IRQ */
+	outb(0, chip->port + CS4231P(STATUS));
+	mb();
+	if (id == WSS_HW_AD1848) {
+		/* check if there are more than 16 registers */
+		rev = snd_wss_in(chip, CS4231_MISC_INFO);
+		snd_wss_out(chip, CS4231_MISC_INFO, 0x40);
+		for (i = 0; i < 16; ++i) {
+			if (snd_wss_in(chip, i) != snd_wss_in(chip, i + 16)) {
+				id = WSS_HW_CMI8330;
+				break;
+			}
+		}
+		snd_wss_out(chip, CS4231_MISC_INFO, 0x00);
+		if (id != WSS_HW_CMI8330 && (rev & 0x80))
+			id = WSS_HW_CS4248;
+		if (id == WSS_HW_CMI8330 && (rev & 0x0f) != 0x0a)
+			id = 0;
+	}
+	if (id == WSS_HW_CMI8330) {
+		/* verify it is not CS4231 by changing the version register */
+		/* on CMI8330 it is volume control register and can be set 0 */
+		snd_wss_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
+		snd_wss_dout(chip, CS4231_VERSION, 0x00);
+		rev = snd_wss_in(chip, CS4231_VERSION) & 0xe7;
+		if (rev)
+			id = 0;
+		snd_wss_out(chip, CS4231_MISC_INFO, 0);
+	}
+	if (id)
+		chip->hardware = id;
+
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	return 0;		/* all things are ok.. */
+}
+
+static int snd_wss_probe(struct snd_wss *chip)
+{
+	unsigned long flags;
+	int i, id, rev, regnum;
+	unsigned char *ptr;
+	unsigned int hw;
+
+	id = snd_ad1848_probe(chip);
+	if (id < 0)
+		return id;
 
 	hw = chip->hardware;
 	if ((hw & WSS_HW_TYPE_MASK) == WSS_HW_DETECT) {
+		for (i = 0; i < 50; i++) {
+			mb();
+			if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+				msleep(2);
+			else {
+				spin_lock_irqsave(&chip->reg_lock, flags);
+				snd_wss_out(chip, CS4231_MISC_INFO,
+					    CS4231_MODE2);
+				id = snd_wss_in(chip, CS4231_MISC_INFO) & 0x0f;
+				spin_unlock_irqrestore(&chip->reg_lock, flags);
+				if (id == 0x0a)
+					break;	/* this is valid value */
+			}
+		}
+		snd_printdd("wss: port = 0x%lx, id = 0x%x\n", chip->port, id);
+		if (id != 0x0a)
+			return -ENODEV;	/* no valid device found */
+
 		rev = snd_wss_in(chip, CS4231_VERSION) & 0xe7;
 		snd_printdd("CS4231: VERSION (I25) = 0x%x\n", rev);
 		if (rev == 0x80) {
@@ -1197,7 +1281,8 @@ static int snd_wss_probe(struct snd_wss 
 	mb();
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
-	chip->image[CS4231_MISC_INFO] = CS4231_MODE2;
+	if (!(chip->hardware & WSS_HW_AD1848_MASK))
+		chip->image[CS4231_MISC_INFO] = CS4231_MODE2;
 	switch (chip->hardware) {
 	case WSS_HW_INTERWAVE:
 		chip->image[CS4231_MISC_INFO] = CS4231_IW_MODE3;
@@ -1223,9 +1308,10 @@ static int snd_wss_probe(struct snd_wss 
 			chip->hardware == WSS_HW_INTERWAVE ? 0xc2 : 0x01;
 	}
 	ptr = (unsigned char *) &chip->image;
+	regnum = (chip->hardware & WSS_HW_AD1848_MASK) ? 16 : 32;
 	snd_wss_mce_down(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	for (i = 0; i < 32; i++)	/* ok.. fill all CS4231 registers */
+	for (i = 0; i < regnum; i++)	/* ok.. fill all registers */
 		snd_wss_out(chip, i, *ptr++);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_wss_mce_up(chip);
@@ -1635,6 +1721,10 @@ static int snd_wss_new(struct snd_card *
 	else
 		memcpy(&chip->image, &snd_wss_original_image,
 		       sizeof(snd_wss_original_image));
+	if (chip->hardware & WSS_HW_AD1848_MASK) {
+		chip->image[CS4231_PIN_CTRL] = 0;
+		chip->image[CS4231_TEST_INIT] = 0;
+	}
 
 	*rchip = chip;
 	return 0;
@@ -1662,7 +1752,7 @@ int snd_wss_create(struct snd_card *card
 	chip->dma1 = -1;
 	chip->dma2 = -1;
 
-	chip->res_port = request_region(port, 4, "CS4231");
+	chip->res_port = request_region(port, 4, "WSS");
 	if (!chip->res_port) {
 		snd_printk(KERN_ERR "wss: can't grab port 0x%lx\n", port);
 		snd_wss_free(chip);
@@ -1681,20 +1771,20 @@ int snd_wss_create(struct snd_card *card
 	chip->cport = cport;
 	if (!(hwshare & WSS_HWSHARE_IRQ))
 		if (request_irq(irq, snd_wss_interrupt, IRQF_DISABLED,
-				"CS4231", (void *) chip)) {
+				"WSS", (void *) chip)) {
 			snd_printk(KERN_ERR "wss: can't grab IRQ %d\n", irq);
 			snd_wss_free(chip);
 			return -EBUSY;
 		}
 	chip->irq = irq;
-	if (!(hwshare & WSS_HWSHARE_DMA1) && request_dma(dma1, "CS4231 - 1")) {
+	if (!(hwshare & WSS_HWSHARE_DMA1) && request_dma(dma1, "WSS - 1")) {
 		snd_printk(KERN_ERR "wss: can't grab DMA1 %d\n", dma1);
 		snd_wss_free(chip);
 		return -EBUSY;
 	}
 	chip->dma1 = dma1;
 	if (!(hwshare & WSS_HWSHARE_DMA2) && dma1 != dma2 &&
-	      dma2 >= 0 && request_dma(dma2, "CS4231 - 2")) {
+	      dma2 >= 0 && request_dma(dma2, "WSS - 2")) {
 		snd_printk(KERN_ERR "wss: can't grab DMA2 %d\n", dma2);
 		snd_wss_free(chip);
 		return -EBUSY;
@@ -1705,6 +1795,12 @@ int snd_wss_create(struct snd_card *card
 	} else
 		chip->dma2 = dma2;
 
+	if (hardware == WSS_HW_THINKPAD) {
+		chip->thinkpad_flag = 1;
+		chip->hardware = WSS_HW_DETECT; /* reset */
+		snd_wss_thinkpad_twiddle(chip, 1);
+	}
+
 	/* global setup */
 	if (snd_wss_probe(chip) < 0) {
 		snd_wss_free(chip);
@@ -1775,12 +1871,6 @@ int snd_wss_pcm(struct snd_wss *chip, in
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_wss_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_wss_capture_ops);
 
-	/* temporary */
-	if (chip->hardware & WSS_HW_AD1848_MASK) {
-		chip->rate_constraint = snd_wss_xrate;
-		chip->set_playback_format = snd_wss_playback_format;
-		chip->set_capture_format = snd_wss_capture_format;
-	}
 	/* global setup */
 	pcm->private_data = chip;
 	pcm->info_flags = 0;

----------------------------------------------------------------------
Partyjka w Chinczyka?
Graj >>> http://link.interia.pl/f1e67
