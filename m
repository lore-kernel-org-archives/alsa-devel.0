From: =?ISO-8859-15?Q?Ren=E9_Herman?= <rene.herman@gmail.com>
Subject: ISA: Remove snd-sgalaxy
Date: Fri, 13 Aug 2010 10:53:05 +0200
Message-ID: <4C6507F1.5060703@gmail.com>
References: <4C62996F.9040004@gmail.com> <s5hhbizro4e.wl%tiwai@suse.de>
	<4C650297.3090608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090601030001020106090309"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq4.gn.mail.iss.as9143.net (smtpq4.gn.mail.iss.as9143.net
	[212.54.34.167])
	by alsa0.perex.cz (Postfix) with ESMTP id EB82F103809
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 10:53:03 +0200 (CEST)
In-Reply-To: <4C650297.3090608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, krzysztof.h1@poczta.fm
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090601030001020106090309
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

... and in case you immediately want it, here's a patch removing the old 
snd-sgalaxy driver. I'm of course fine with it sticking around a bit as 
well but its hardware is driven more fully by the new drivers.

Regards,
Rene

--------------090601030001020106090309
Content-Type: text/x-patch;
 name="0001-ISA-Remove-snd-sgalaxy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ISA-Remove-snd-sgalaxy.patch"

>From ff8cfb1fe1dbccaefe6c4d2ed9ef10828ef5f865 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ren=C3=A9=20Herman?= <rene.herman@gmail.com>
Date: Fri, 13 Aug 2010 10:43:48 +0200
Subject: [PATCH] ISA: Remove snd-sgalaxy

Its hardware is handled more fully by the new azt1605/azt2316 drivers.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 Documentation/kernel-parameters.txt             |    2 -
 Documentation/sound/alsa/ALSA-Configuration.txt |   14 -
 arch/powerpc/configs/ppc6xx_defconfig           |    1 -
 sound/isa/Kconfig                               |   10 -
 sound/isa/Makefile                              |    2 -
 sound/isa/sgalaxy.c                             |  369 -----------------------
 6 files changed, 0 insertions(+), 398 deletions(-)
 delete mode 100644 sound/isa/sgalaxy.c

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 2b2407d..4df51c8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2484,8 +2484,6 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	snd-serial=	[HW,ALSA]
 
-	snd-sgalaxy=	[HW,ALSA]
-
 	snd-sonicvibes=	[HW,ALSA]
 
 	snd-sun-amd7930=
diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 52f6725..797040d 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1709,20 +1709,6 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 
     This card is also known as Audio Excel DSP 16 or Zoltrix AV302.
 
-  Module snd-sgalaxy
-  ------------------
-
-    Module for Aztech Sound Galaxy sound card.
-
-    sbport	- Port # for SB16 interface (0x220,0x240)
-    wssport	- Port # for WSS interface (0x530,0xe80,0xf40,0x604)
-    irq		- IRQ # (7,9,10,11)
-    dma1	- DMA #
-
-    This module supports multiple cards.
-
-    The power-management is supported.
-
   Module snd-sscape
   -----------------
 
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 12dc7c4..ba7bef1 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -2573,7 +2573,6 @@ CONFIG_SND_ISA=y
 # CONFIG_SND_SB8 is not set
 # CONFIG_SND_SB16 is not set
 # CONFIG_SND_SBAWE is not set
-# CONFIG_SND_SGALAXY is not set
 # CONFIG_SND_SSCAPE is not set
 # CONFIG_SND_WAVEFRONT is not set
 CONFIG_SND_PCI=y
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index f9aa13d..52064cf 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -377,16 +377,6 @@ config SND_SB16_CSP
 	  coprocessor can do variable tasks like various compression and
 	  decompression algorithms.
 
-config SND_SGALAXY
-	tristate "Aztech Sound Galaxy"
-	select SND_WSS_LIB
-	help
-	  Say Y here to include support for Aztech Sound Galaxy
-	  soundcards.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-sgalaxy.
-
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape driver"
 	select SND_MPU401_UART
diff --git a/sound/isa/Makefile b/sound/isa/Makefile
index d2bd8f5..8d781e4 100644
--- a/sound/isa/Makefile
+++ b/sound/isa/Makefile
@@ -10,7 +10,6 @@ snd-cmi8330-objs := cmi8330.o
 snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sc6000-objs := sc6000.o
-snd-sgalaxy-objs := sgalaxy.o
 snd-sscape-objs := sscape.o
 
 # Toplevel Module Dependency
@@ -21,7 +20,6 @@ obj-$(CONFIG_SND_CMI8330) += snd-cmi8330.o
 obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SC6000) += snd-sc6000.o
-obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
 
 obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ galaxy/ gus/ msnd/ opti9xx/ \
diff --git a/sound/isa/sgalaxy.c b/sound/isa/sgalaxy.c
deleted file mode 100644
index 6fe27b9..0000000
--- a/sound/isa/sgalaxy.c
+++ /dev/null
@@ -1,369 +0,0 @@
-/*
- *  Driver for Aztech Sound Galaxy cards
- *  Copyright (c) by Christopher Butler <chrisb@sandy.force9.co.uk.
- *
- *  I don't have documentation for this card, I based this driver on the
- *  driver for OSS/Free included in the kernel source (drivers/sound/sgalaxy.c)
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
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/isa.h>
-#include <linux/delay.h>
-#include <linux/time.h>
-#include <linux/interrupt.h>
-#include <linux/moduleparam.h>
-#include <asm/dma.h>
-#include <sound/core.h>
-#include <sound/sb.h>
-#include <sound/wss.h>
-#include <sound/control.h>
-#define SNDRV_LEGACY_FIND_FREE_IRQ
-#define SNDRV_LEGACY_FIND_FREE_DMA
-#include <sound/initval.h>
-
-MODULE_AUTHOR("Christopher Butler <chrisb@sandy.force9.co.uk>");
-MODULE_DESCRIPTION("Aztech Sound Galaxy");
-MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Aztech Systems,Sound Galaxy}}");
-
-static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
-static long sbport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240 */
-static long wssport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x530,0xe80,0xf40,0x604 */
-static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 7,9,10,11 */
-static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
-
-module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for Sound Galaxy soundcard.");
-module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for Sound Galaxy soundcard.");
-module_param_array(sbport, long, NULL, 0444);
-MODULE_PARM_DESC(sbport, "Port # for Sound Galaxy SB driver.");
-module_param_array(wssport, long, NULL, 0444);
-MODULE_PARM_DESC(wssport, "Port # for Sound Galaxy WSS driver.");
-module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for Sound Galaxy driver.");
-module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "DMA1 # for Sound Galaxy driver.");
-
-#define SGALAXY_AUXC_LEFT 18
-#define SGALAXY_AUXC_RIGHT 19
-
-#define PFX	"sgalaxy: "
-
-/*
-
- */
-
-#define AD1848P1( port, x ) ( port + c_d_c_AD1848##x )
-
-/* from lowlevel/sb/sb.c - to avoid having to allocate a struct snd_sb for the */
-/* short time we actually need it.. */
-
-static int snd_sgalaxy_sbdsp_reset(unsigned long port)
-{
-	int i;
-
-	outb(1, SBP1(port, RESET));
-	udelay(10);
-	outb(0, SBP1(port, RESET));
-	udelay(30);
-	for (i = 0; i < 1000 && !(inb(SBP1(port, DATA_AVAIL)) & 0x80); i++);
-	if (inb(SBP1(port, READ)) != 0xaa) {
-		snd_printd("sb_reset: failed at 0x%lx!!!\n", port);
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static int __devinit snd_sgalaxy_sbdsp_command(unsigned long port,
-					       unsigned char val)
-{
-	int i;
-       	
-	for (i = 10000; i; i--)
-		if ((inb(SBP1(port, STATUS)) & 0x80) == 0) {
-			outb(val, SBP1(port, COMMAND));
-			return 1;
-		}
-
-	return 0;
-}
-
-static irqreturn_t snd_sgalaxy_dummy_interrupt(int irq, void *dev_id)
-{
-	return IRQ_NONE;
-}
-
-static int __devinit snd_sgalaxy_setup_wss(unsigned long port, int irq, int dma)
-{
-	static int interrupt_bits[] = {-1, -1, -1, -1, -1, -1, -1, 0x08, -1, 
-				       0x10, 0x18, 0x20, -1, -1, -1, -1};
-	static int dma_bits[] = {1, 2, 0, 3};
-	int tmp, tmp1;
-
-	if ((tmp = inb(port + 3)) == 0xff)
-	{
-		snd_printdd("I/O address dead (0x%lx)\n", port);
-		return 0;
-	}
-#if 0
-	snd_printdd("WSS signature = 0x%x\n", tmp);
-#endif
-
-        if ((tmp & 0x3f) != 0x04 &&
-            (tmp & 0x3f) != 0x0f &&
-            (tmp & 0x3f) != 0x00) {
-		snd_printdd("No WSS signature detected on port 0x%lx\n",
-			    port + 3);
-		return 0;
-	}
-
-#if 0
-	snd_printdd(PFX "setting up IRQ/DMA for WSS\n");
-#endif
-
-        /* initialize IRQ for WSS codec */
-        tmp = interrupt_bits[irq % 16];
-        if (tmp < 0)
-                return -EINVAL;
-
-	if (request_irq(irq, snd_sgalaxy_dummy_interrupt, IRQF_DISABLED, "sgalaxy", NULL)) {
-		snd_printk(KERN_ERR "sgalaxy: can't grab irq %d\n", irq);
-		return -EIO;
-	}
-
-        outb(tmp | 0x40, port);
-        tmp1 = dma_bits[dma % 4];
-        outb(tmp | tmp1, port);
-
-	free_irq(irq, NULL);
-
-	return 0;
-}
-
-static int __devinit snd_sgalaxy_detect(int dev, int irq, int dma)
-{
-#if 0
-	snd_printdd(PFX "switching to WSS mode\n");
-#endif
-
-	/* switch to WSS mode */
-	snd_sgalaxy_sbdsp_reset(sbport[dev]);
-
-	snd_sgalaxy_sbdsp_command(sbport[dev], 9);
-	snd_sgalaxy_sbdsp_command(sbport[dev], 0);
-
-	udelay(400);
-	return snd_sgalaxy_setup_wss(wssport[dev], irq, dma);
-}
-
-static struct snd_kcontrol_new snd_sgalaxy_controls[] = {
-WSS_DOUBLE("Aux Playback Switch", 0,
-		SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 7, 7, 1, 1),
-WSS_DOUBLE("Aux Playback Volume", 0,
-		SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 0, 0, 31, 0)
-};
-
-static int __devinit snd_sgalaxy_mixer(struct snd_wss *chip)
-{
-	struct snd_card *card = chip->card;
-	struct snd_ctl_elem_id id1, id2;
-	unsigned int idx;
-	int err;
-
-	memset(&id1, 0, sizeof(id1));
-	memset(&id2, 0, sizeof(id2));
-	id1.iface = id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	/* reassign AUX0 to LINE */
-	strcpy(id1.name, "Aux Playback Switch");
-	strcpy(id2.name, "Line Playback Switch");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
-	strcpy(id1.name, "Aux Playback Volume");
-	strcpy(id2.name, "Line Playback Volume");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
-	/* reassign AUX1 to FM */
-	strcpy(id1.name, "Aux Playback Switch"); id1.index = 1;
-	strcpy(id2.name, "FM Playback Switch");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
-	strcpy(id1.name, "Aux Playback Volume");
-	strcpy(id2.name, "FM Playback Volume");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
-	/* build AUX2 input */
-	for (idx = 0; idx < ARRAY_SIZE(snd_sgalaxy_controls); idx++) {
-		err = snd_ctl_add(card,
-				snd_ctl_new1(&snd_sgalaxy_controls[idx], chip));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
-static int __devinit snd_sgalaxy_match(struct device *devptr, unsigned int dev)
-{
-	if (!enable[dev])
-		return 0;
-	if (sbport[dev] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR PFX "specify SB port\n");
-		return 0;
-	}
-	if (wssport[dev] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR PFX "specify WSS port\n");
-		return 0;
-	}
-	return 1;
-}
-
-static int __devinit snd_sgalaxy_probe(struct device *devptr, unsigned int dev)
-{
-	static int possible_irqs[] = {7, 9, 10, 11, -1};
-	static int possible_dmas[] = {1, 3, 0, -1};
-	int err, xirq, xdma1;
-	struct snd_card *card;
-	struct snd_wss *chip;
-
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
-	if (err < 0)
-		return err;
-
-	xirq = irq[dev];
-	if (xirq == SNDRV_AUTO_IRQ) {
-		if ((xirq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free IRQ\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
-	xdma1 = dma1[dev];
-        if (xdma1 == SNDRV_AUTO_DMA) {
-		if ((xdma1 = snd_legacy_find_free_dma(possible_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
-
-	if ((err = snd_sgalaxy_detect(dev, xirq, xdma1)) < 0)
-		goto _err;
-
-	err = snd_wss_create(card, wssport[dev] + 4, -1,
-			     xirq, xdma1, -1,
-			     WSS_HW_DETECT, 0, &chip);
-	if (err < 0)
-		goto _err;
-	card->private_data = chip;
-
-	err = snd_wss_pcm(chip, 0, NULL);
-	if (err < 0) {
-		snd_printdd(PFX "error creating new WSS PCM device\n");
-		goto _err;
-	}
-	err = snd_wss_mixer(chip);
-	if (err < 0) {
-		snd_printdd(PFX "error creating new WSS mixer\n");
-		goto _err;
-	}
-	if ((err = snd_sgalaxy_mixer(chip)) < 0) {
-		snd_printdd(PFX "the mixer rewrite failed\n");
-		goto _err;
-	}
-
-	strcpy(card->driver, "Sound Galaxy");
-	strcpy(card->shortname, "Sound Galaxy");
-	sprintf(card->longname, "Sound Galaxy at 0x%lx, irq %d, dma %d",
-		wssport[dev], xirq, xdma1);
-
-	snd_card_set_dev(card, devptr);
-
-	if ((err = snd_card_register(card)) < 0)
-		goto _err;
-
-	dev_set_drvdata(devptr, card);
-	return 0;
-
- _err:
-	snd_card_free(card);
-	return err;
-}
-
-static int __devexit snd_sgalaxy_remove(struct device *devptr, unsigned int dev)
-{
-	snd_card_free(dev_get_drvdata(devptr));
-	dev_set_drvdata(devptr, NULL);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int snd_sgalaxy_suspend(struct device *pdev, unsigned int n,
-			       pm_message_t state)
-{
-	struct snd_card *card = dev_get_drvdata(pdev);
-	struct snd_wss *chip = card->private_data;
-
-	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	chip->suspend(chip);
-	return 0;
-}
-
-static int snd_sgalaxy_resume(struct device *pdev, unsigned int n)
-{
-	struct snd_card *card = dev_get_drvdata(pdev);
-	struct snd_wss *chip = card->private_data;
-
-	chip->resume(chip);
-	snd_wss_out(chip, SGALAXY_AUXC_LEFT, chip->image[SGALAXY_AUXC_LEFT]);
-	snd_wss_out(chip, SGALAXY_AUXC_RIGHT, chip->image[SGALAXY_AUXC_RIGHT]);
-
-	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
-	return 0;
-}
-#endif
-
-#define DEV_NAME "sgalaxy"
-
-static struct isa_driver snd_sgalaxy_driver = {
-	.match		= snd_sgalaxy_match,
-	.probe		= snd_sgalaxy_probe,
-	.remove		= __devexit_p(snd_sgalaxy_remove),
-#ifdef CONFIG_PM
-	.suspend	= snd_sgalaxy_suspend,
-	.resume		= snd_sgalaxy_resume,
-#endif
-	.driver		= {
-		.name	= DEV_NAME
-	},
-};
-
-static int __init alsa_card_sgalaxy_init(void)
-{
-	return isa_register_driver(&snd_sgalaxy_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_sgalaxy_exit(void)
-{
-	isa_unregister_driver(&snd_sgalaxy_driver);
-}
-
-module_init(alsa_card_sgalaxy_init)
-module_exit(alsa_card_sgalaxy_exit)
-- 
1.7.2.1


--------------090601030001020106090309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090601030001020106090309--
