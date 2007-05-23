From: "Ash Willis" <ashwillis@programmer.net>
Subject: [PATCH 2/2] Add support for Cyrix/NatSemi Geode SC5530
	(VSA1)
Date: Wed, 23 May 2007 15:50:38 -0500
Message-ID: <20070523205038.0D6581158CD@ws1-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id BE4842467C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 22:50:21 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	75133180013C
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 20:50:38 +0000 (GMT)
Content-Disposition: inline
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Add support for the Cyrix/NatSemi Geode SC5530 chips.
This driver is ported from oss/kahlua.c and is made up of two patches.

Patch 1/2 adds some stuff to the SB layer to allow for some hardware quirks and
is to be applied to alsa-kernel.
Patch 2/2 adds the actual driver code to be applied to alsa-driver.
Patch 2 depends on patch 1.

Signed off by: Ash Willis <ashwillis@programmer.net>

---

summary:     Add Cyrix/NatSemi Geode CS5530 driver

diff -r 5c25d0e8819c -r c9be7b8611e7 pci/Kconfig
--- a/pci/Kconfig	Fri May 18 17:56:53 2007 +0200
+++ b/pci/Kconfig	Thu May 24 02:24:57 2007 +0100
@@ -20,5 +20,15 @@ config SND_ASIHPI
 	help
 	  Say 'Y' or 'M' to include support for AudioScience ASIxxxx soundcards.
 
+config SND_CS5530
+	tristate "CS5530 Audio"
+	depends on SND
+	select SND_SB16
+	help
+	  Say Y here to include support for audio on Cyrix/NatSemi CS5530 chips.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-cs5530.
+
 endmenu
 
diff -r 5c25d0e8819c -r c9be7b8611e7 pci/Makefile
--- a/pci/Makefile	Fri May 18 17:56:53 2007 +0200
+++ b/pci/Makefile	Thu May 24 02:24:57 2007 +0100
@@ -13,6 +13,9 @@ clean-files := ad1889.c bt87x.c intel8x0
 
 obj-$(CONFIG_SND) += pdplus/ asihpi/
 
+snd-cs5530-objs := cs5530.o
+obj-$(CONFIG_SND_CS5530) += snd-cs5530.o
+
 #
 #
 #
diff -r 5c25d0e8819c -r c9be7b8611e7 pci/cs5530.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/cs5530.c	Thu May 24 02:24:57 2007 +0100
@@ -0,0 +1,296 @@
+/*
+ * cs5530.c - Initialisation code for Cyrix/NatSemi VSA1 softaudio
+ *
+ * 	(C) Copyright 2007 Ash Willis <ashwillis@programmer.net>
+ *	(C) Copyright 2003 Red Hat Inc <alan@redhat.com>
+ *
+ * This driver was ported (shamelessly ripped ;) from oss/kahlua.c but I did
+ * mess with it a bit. The chip seems to have to have trouble with full duplex
+ * mode. If we're recording in 8bit 8000kHz, say, and we then attempt to
+ * simultaneously play back audio at 16bit 44100kHz, the device actually plays
+ * back in the same format in which it is capturing. By forcing the chip to
+ * always play/capture in 16/44100, we can let alsa-lib convert the samples and
+ * that way we can hack up some full duplex audio. 
+ * 
+ * XpressAudio(tm) is used on the Cyrix MediaGX (now NatSemi Geode) systems.
+ * The older version (VSA1) provides fairly good soundblaster emulation
+ * although there are a couple of bugs: large DMA buffers break record,
+ * and the MPU event handling seems suspect. VSA2 allows the native driver
+ * to control the AC97 audio engine directly and requires a different driver.
+ *
+ * Thanks to National Semiconductor for providing the needed information
+ * on the XpressAudio(tm) internals.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * TO DO:
+ *	Investigate whether we can portably support Cognac (5520) in the
+ *	same manner.
+ */
+
+#include <sound/driver.h>
+#include <linux/delay.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <sound/core.h>
+#include <sound/sb.h>
+#include <sound/initval.h>
+
+MODULE_AUTHOR("Ash Willis");
+MODULE_DESCRIPTION("CS5530 Audio");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+struct snd_cs5530 {
+	struct snd_card *card;
+	struct pci_dev *pci;
+	struct snd_sb *sb;
+	unsigned long pci_base;
+};
+
+static struct pci_device_id snd_cs5530_ids[] = {
+	{PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_AUDIO, PCI_ANY_ID,
+							PCI_ANY_ID, 0, 0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, snd_cs5530_ids);
+
+static int snd_cs5530_free(struct snd_cs5530 *chip)
+{
+	pci_release_regions(chip->pci);
+	pci_disable_device(chip->pci);
+	kfree(chip);
+	return 0;
+}
+
+static int snd_cs5530_dev_free(struct snd_device *device)
+{
+	struct snd_cs5530 *chip = device->device_data;
+	return snd_cs5530_free(chip);
+}
+
+static void __devexit snd_cs5530_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+static u8 __devinit snd_cs5530_mixer_read(unsigned long io, u8 reg)
+{
+	outb(reg, io + 4);
+	udelay(20);
+	reg = inb(io + 5);
+	udelay(20);
+	return reg;
+}
+
+static int __devinit snd_cs5530_create(struct snd_card *card,
+				       struct pci_dev *pci,
+				       struct snd_cs5530 **rchip)
+{
+	struct snd_cs5530 *chip;
+	unsigned long sb_base;
+	u8 irq, dma8, dma16 = 0;
+	u16 map;
+	void __iomem *mem;
+	int err;
+
+	static struct snd_device_ops ops = {
+		.dev_free = snd_cs5530_dev_free,
+	};
+	*rchip = NULL;
+
+	if ((err = pci_enable_device(pci)) < 0)
+		return err;
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+
+	chip->card = card;
+	chip->pci = pci;
+
+	if ((err = pci_request_regions(pci, "CS5530")) < 0) {
+		kfree(chip); 
+		pci_disable_device(pci);
+		return err;
+	}
+	chip->pci_base = pci_resource_start(pci, 0);
+
+	mem = ioremap_nocache(chip->pci_base, pci_resource_len(pci, 0));
+	map = readw(mem + 0x18);
+	iounmap(mem);
+
+	/* Map bits
+		0:1	* 0x20 + 0x200 = sb base
+		2	sb enable
+		3	adlib enable
+		5	MPU enable 0x330
+		6	MPU enable 0x300
+
+	   The other bits may be used internally so must be masked */
+
+	sb_base = 0x220 + 0x20 * (map & 3);
+
+	if (map & (1<<2))
+		printk(KERN_INFO "CS5530: XpressAudio at 0x%lx\n", sb_base);
+	else
+	{
+		printk(KERN_ERR "Could not find XpressAudio!\n");
+		snd_cs5530_free(chip);
+		return -ENODEV;
+	}
+
+	if (map & (1<<5))
+		printk(KERN_INFO "CS5530: MPU at 0x300\n");
+	else if (map & (1<<6))
+		printk(KERN_INFO "CS5530: MPU at 0x330\n");
+
+	irq = snd_cs5530_mixer_read(sb_base, 0x80) & 0x0F;
+	dma8 = snd_cs5530_mixer_read(sb_base, 0x81);
+
+	if (dma8 & 0x20)
+		dma16 = 5;
+	else if (dma8 & 0x40)
+		dma16 = 6;
+	else if (dma8 & 0x80)
+		dma16 = 7;
+	else
+	{
+		printk(KERN_ERR "CS5530: No 16bit DMA enabled\n");
+		snd_cs5530_free(chip);
+		return -ENODEV;
+	}
+
+	if (dma8 & 0x01)
+		dma8 = 0;
+	else if (dma8 & 02)
+		dma8 = 1;
+	else if (dma8 & 0x08)
+		dma8 = 3;
+	else
+	{
+		printk(KERN_ERR "CS5530: No 8bit DMA enabled\n");
+		snd_cs5530_free(chip);
+		return -ENODEV;
+	}
+
+	if (irq & 1)
+		irq = 9;
+	else if (irq & 2)
+		irq = 5;
+	else if (irq & 4)
+		irq = 7;
+	else if (irq & 8)
+		irq = 10;
+	else
+	{
+		printk(KERN_ERR "CS5530: SoundBlaster IRQ not set\n");
+		snd_cs5530_free(chip);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "CS5530: IRQ: %d DMA8: %d DMA16: %d\n", irq, dma8, 
+									dma16);
+
+	if ((err = snd_sbdsp_create(card, sb_base, irq, snd_sb16dsp_interrupt,
+				dma8, dma16, SB_HW_CS5530, &chip->sb)) < 0) {
+		printk(KERN_ERR "CS5530: Could not create SoundBlaster\n");
+		snd_cs5530_free(chip);
+		return err;
+	}
+
+	if ((err = snd_sb16dsp_pcm(chip->sb, 0, &chip->sb->pcm)) < 0) {
+		printk(KERN_ERR "CS5530: Could not create PCM\n");
+		snd_cs5530_free(chip);
+		return err;
+	}
+
+	if ((err = snd_sbmixer_new(chip->sb)) < 0) {
+		printk(KERN_ERR "CS5530: Could not create Mixer\n");
+		snd_cs5530_free(chip);
+		return err;
+	}
+
+	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+		snd_cs5530_free(chip);
+		return err;
+	}
+
+	snd_card_set_dev(card, &pci->dev);
+	*rchip = chip;
+	return 0;
+}
+
+static int __devinit snd_cs5530_probe(struct pci_dev *pci,
+					const struct pci_device_id *pci_id)
+{
+	static int dev;
+	struct snd_card *card;
+	struct snd_cs5530 *chip = NULL;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+
+	if (card == NULL)
+		return -ENOMEM;
+
+	if ((err = snd_cs5530_create(card, pci, &chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	strcpy(card->driver, "CS5530");
+	strcpy(card->shortname, "CS5530 Audio");
+	sprintf(card->longname, "%s at 0x%lx", card->shortname, chip->pci_base);
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	pci_set_drvdata(pci, card);
+	dev++;
+	return 0;
+}
+
+static struct pci_driver driver = {
+	.name = "CS5530_Audio",
+	.id_table = snd_cs5530_ids,
+	.probe = snd_cs5530_probe,
+	.remove = __devexit_p(snd_cs5530_remove),
+};
+
+static int __init alsa_card_cs5530_init(void)
+{
+	return pci_register_driver(&driver);
+}
+
+static void __exit alsa_card_cs5530_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_cs5530_init)
+module_exit(alsa_card_cs5530_exit)
+



=
Work From Home & Learn How To Make Money
Learn How To Make Money Online With Help & Guidance From The Pro's.
http://a8-asy.a8ww.net/a8-ads/adftrclick?redirectid=db055100ca96c7d9527d2fadfac750b9
