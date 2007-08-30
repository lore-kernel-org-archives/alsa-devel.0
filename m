From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [PATCH] Improved support for different bt87x board
	configurations
Date: Thu, 30 Aug 2007 03:21:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4]) by alsa0.perex.cz (Postfix) with ESMTP id 1DADE10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 12:21:54 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 30 Aug 2007 10:21:52 -0000
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

After applying this patch, the bt87x.patch file in alsa-driver doesn't apply.
I'm not sure what I'm supposed to do about that?

# HG changeset patch
# User Trent Piepho <xyzzy@speakeasy.org>
# Date 1188469025 25200
# Node ID 33d453db23d246dade155a6fc3b91d8437a4b7f5
# Parent  52dfc5244360d2b0b119786596962ff5d0c9f338
snd-bt87x: Improve support for different board types

Different cards have different audio configurations, but the driver didn't
support this.  The only setting it had was the digital rate.

This patch adds a board configuration list.  Currently, configurable items are
the digital rate and the digital data format (for cards with an external ADC),
a flag for the absence of an external ADC, and a flag for no connection to the
Bt87x internal ADC.

This allows cards that don't use the internal ADC to omit the ALSA "Bt87x
analog" device and related controls.  Cards without an external ADC can omit
the "Bt87x digital" device.

In order to support the CS5331A ADC used on the Osprey 440 and 2x0 cards, the
digital format needs to be different than the default.

Support could be added for defining:
  The connections or lack of them to the Bt87x's internal ADC mux
  Multiple sample rates for an external ADC (e.g. Osprey)
  Control of an external mux for an external ADC (e.g. Osprey)

The card definitions for cards other than the Ospreys are kept equivalent to
their old values.  This is likely inaccurate for most cards, as it is doubtful
that both an external and the internal ADC would be used.  Lacking information
on those cards, the behavior is left unchanged.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>

diff -r 52dfc5244360 -r 33d453db23d2 pci/bt87x.c
--- a/pci/bt87x.c	Thu Aug 30 10:22:35 2007 +0200
+++ b/pci/bt87x.c	Thu Aug 30 03:17:05 2007 -0700
@@ -147,14 +147,67 @@ MODULE_PARM_DESC(load_all, "Allow to loa
 /* SYNC, one WRITE per line, one extra WRITE per page boundary, SYNC, JUMP */
 #define MAX_RISC_SIZE ((1 + 255 + (PAGE_ALIGN(255 * 4092) / PAGE_SIZE - 1) + 1 + 1) * 8)

+/* Cards with configuration information */
+enum snd_bt87x_boardid {
+	SND_BT87X_BOARD_GENERIC,
+	SND_BT87X_BOARD_ANALOG,		/* board with no external A/D */
+	SND_BT87X_BOARD_HAUPPAUGE878,
+	SND_BT87X_BOARD_OSPREY2x0,
+	SND_BT87X_BOARD_OSPREY440,
+	SND_BT87X_BOARD_ATI_TVWONDER,
+	SND_BT87X_BOARD_WINFAST2000,
+	SND_BT87X_BOARD_VOODOOTV_200,
+	SND_BT87X_BOARD_AVPHONE98,
+};
+
+/* Card configuration */
+struct snd_bt87x_board {
+	int dig_rate;		/* Digital input sampling rate */
+	u32 digital_fmt;	/* Register settings for digital input */
+	unsigned no_analog:1;	/* No analog input */
+	unsigned no_digital:1;	/* No digital input */
+};
+
+static const __devinitdata struct snd_bt87x_board snd_bt87x_boards[] = {
+	[SND_BT87X_BOARD_GENERIC] = {
+		.dig_rate = 32000,
+	},
+	[SND_BT87X_BOARD_ANALOG] = {
+		.no_digital = 1,
+	},
+	[SND_BT87X_BOARD_HAUPPAUGE878] = {
+		.dig_rate = 32000,
+	},
+	[SND_BT87X_BOARD_OSPREY2x0] = {
+		.dig_rate = 44100,
+		.digital_fmt = CTL_DA_LRI | (1 << CTL_DA_LRD_SHIFT),
+	},
+	[SND_BT87X_BOARD_OSPREY440] = {
+		.dig_rate = 32000,
+		.digital_fmt = CTL_DA_LRI | (1 << CTL_DA_LRD_SHIFT),
+		.no_analog = 1,
+	},
+	[SND_BT87X_BOARD_ATI_TVWONDER] = {
+		.dig_rate = 32000,
+	},
+	[SND_BT87X_BOARD_WINFAST2000] = {
+		.dig_rate = 32000,
+	},
+	[SND_BT87X_BOARD_VOODOOTV_200] = {
+		.dig_rate = 32000,
+	},
+	[SND_BT87X_BOARD_AVPHONE98] = {
+		.dig_rate = 48000,
+	},
+};
+
 struct snd_bt87x {
 	struct snd_card *card;
 	struct pci_dev *pci;
+	struct snd_bt87x_board board;

 	void __iomem *mmio;
 	int irq;
-
-	int dig_rate;

 	spinlock_t reg_lock;
 	long opened;
@@ -342,9 +395,9 @@ static int snd_bt87x_set_digital_hw(stru
 {
 	chip->reg_control |= CTL_DA_IOM_DA;
 	runtime->hw = snd_bt87x_digital_hw;
-	runtime->hw.rates = snd_pcm_rate_to_rate_bit(chip->dig_rate);
-	runtime->hw.rate_min = chip->dig_rate;
-	runtime->hw.rate_max = chip->dig_rate;
+	runtime->hw.rates = snd_pcm_rate_to_rate_bit(chip->board.dig_rate);
+	runtime->hw.rate_min = chip->board.dig_rate;
+	runtime->hw.rate_max = chip->board.dig_rate;
 	return 0;
 }

@@ -709,9 +762,9 @@ static int __devinit snd_bt87x_create(st
 	chip->mmio = ioremap_nocache(pci_resource_start(pci, 0),
 				     pci_resource_len(pci, 0));
 	if (!chip->mmio) {
-		snd_bt87x_free(chip);
 		snd_printk(KERN_ERR "cannot remap io memory\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto fail;
 	}

 	chip->reg_control = CTL_DA_ES2 | CTL_PKTP_16 | (15 << CTL_DA_SDR_SHIFT);
@@ -720,54 +773,57 @@ static int __devinit snd_bt87x_create(st
 	snd_bt87x_writel(chip, REG_INT_MASK, 0);
 	snd_bt87x_writel(chip, REG_INT_STAT, MY_INTERRUPTS);

-	if (request_irq(pci->irq, snd_bt87x_interrupt, IRQF_SHARED,
-			"Bt87x audio", chip)) {
-		snd_bt87x_free(chip);
-		snd_printk(KERN_ERR "cannot grab irq\n");
-		return -EBUSY;
+	err = request_irq(pci->irq, snd_bt87x_interrupt, IRQF_SHARED,
+			  "Bt87x audio", chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR "cannot grab irq %d\n", pci->irq);
+		goto fail;
 	}
 	chip->irq = pci->irq;
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);

 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_bt87x_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto fail;
+
 	snd_card_set_dev(card, &pci->dev);
 	*rchip = chip;
 	return 0;
-}
-
-#define BT_DEVICE(chip, subvend, subdev, rate) \
+
+fail:
+	snd_bt87x_free(chip);
+	return err;
+}
+
+#define BT_DEVICE(chip, subvend, subdev, id) \
 	{ .vendor = PCI_VENDOR_ID_BROOKTREE, \
-	  .device = chip, \
+	  .device = PCI_DEVICE_ID_BROOKTREE ## chip, \
 	  .subvendor = subvend, .subdevice = subdev, \
-	  .driver_data = rate }
-
-/* driver_data is the default digital_rate value for that device */
+	  .driver_data = id }
+/* driver_data is the card id for that device */
+
 static struct pci_device_id snd_bt87x_ids[] = {
 	/* Hauppauge WinTV series */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0x13eb, 32000),
+	BT_DEVICE(_878, 0x0070, 0x13eb, SND_BT87X_BOARD_HAUPPAUGE878),
 	/* Hauppauge WinTV series */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_879, 0x0070, 0x13eb, 32000),
+	BT_DEVICE(_879, 0x0070, 0x13eb, SND_BT87X_BOARD_HAUPPAUGE878),
 	/* Viewcast Osprey 200 */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0xff01, 44100),
+	BT_DEVICE(_878, 0x0070, 0xff01, SND_BT87X_BOARD_OSPREY2x0),
 	/* Viewcast Osprey 440 (rate is configurable via gpio) */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0xff07, 32000),
+	BT_DEVICE(_878, 0x0070, 0xff07, SND_BT87X_BOARD_OSPREY440),
 	/* ATI TV-Wonder */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x1002, 0x0001, 32000),
+	BT_DEVICE(_878, 0x1002, 0x0001, SND_BT87X_BOARD_ATI_TVWONDER),
 	/* Leadtek Winfast tv 2000xp delux */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x107d, 0x6606, 32000),
+	BT_DEVICE(_878, 0x107d, 0x6606, SND_BT87X_BOARD_WINFAST2000),
 	/* Voodoo TV 200 */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x121a, 0x3000, 32000),
+	BT_DEVICE(_878, 0x121a, 0x3000, SND_BT87X_BOARD_VOODOOTV_200),
 	/* AVerMedia Studio No. 103, 203, ...? */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x1461, 0x0003, 48000),
+	BT_DEVICE(_878, 0x1461, 0x0003, SND_BT87X_BOARD_AVPHONE98),
 	/* Prolink PixelView PV-M4900 */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x1554, 0x4011, 32000),
+	BT_DEVICE(_878, 0x1554, 0x4011, SND_BT87X_BOARD_GENERIC),
 	/* Pinnacle  Studio PCTV rave */
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0xbd11, 0x1200, 32000),
+	BT_DEVICE(_878, 0xbd11, 0x1200, SND_BT87X_BOARD_GENERIC),
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, snd_bt87x_ids);
@@ -792,7 +848,7 @@ static struct {

 static struct pci_driver driver;

-/* return the rate of the card, or a negative value if it's blacklisted */
+/* return the id of the card, or a negative value if it's blacklisted */
 static int __devinit snd_bt87x_detect_card(struct pci_dev *pci)
 {
 	int i;
@@ -810,12 +866,12 @@ static int __devinit snd_bt87x_detect_ca
 			return -EBUSY;
 		}

-	snd_printk(KERN_INFO "unknown card %#04x-%#04x:%#04x, using default rate 32000\n",
-	           pci->device, pci->subsystem_vendor, pci->subsystem_device);
+	snd_printk(KERN_INFO "unknown card %#04x-%#04x:%#04x\n",
+		   pci->device, pci->subsystem_vendor, pci->subsystem_device);
 	snd_printk(KERN_DEBUG "please mail id, board name, and, "
 		   "if it works, the correct digital_rate option to "
 		   "<alsa-devel@alsa-project.org>\n");
-	return 32000; /* default rate */
+	return SND_BT87X_BOARD_GENERIC;
 }

 static int __devinit snd_bt87x_probe(struct pci_dev *pci,
@@ -824,12 +880,15 @@ static int __devinit snd_bt87x_probe(str
 	static int dev;
 	struct snd_card *card;
 	struct snd_bt87x *chip;
-	int err, rate;
-
-	rate = pci_id->driver_data;
-	if (! rate)
-		if ((rate = snd_bt87x_detect_card(pci)) <= 0)
+	int err;
+	enum snd_bt87x_boardid boardid;
+
+	if (! pci_id->driver_data) {
+		if ((err = snd_bt87x_detect_card(pci)) < 0)
 			return -ENODEV;
+		boardid = err;
+	} else
+		boardid = pci_id->driver_data;

 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
@@ -846,27 +905,36 @@ static int __devinit snd_bt87x_probe(str
 	if (err < 0)
 		goto _error;

-	if (digital_rate[dev] > 0)
-		chip->dig_rate = digital_rate[dev];
-	else
-		chip->dig_rate = rate;
-
-	err = snd_bt87x_pcm(chip, DEVICE_DIGITAL, "Bt87x Digital");
-	if (err < 0)
-		goto _error;
-	err = snd_bt87x_pcm(chip, DEVICE_ANALOG, "Bt87x Analog");
-	if (err < 0)
-		goto _error;
-
-	err = snd_ctl_add(card, snd_ctl_new1(&snd_bt87x_capture_volume, chip));
-	if (err < 0)
-		goto _error;
-	err = snd_ctl_add(card, snd_ctl_new1(&snd_bt87x_capture_boost, chip));
-	if (err < 0)
-		goto _error;
-	err = snd_ctl_add(card, snd_ctl_new1(&snd_bt87x_capture_source, chip));
-	if (err < 0)
-		goto _error;
+	memcpy(&chip->board, &snd_bt87x_boards[boardid], sizeof(chip->board));
+
+	if (! chip->board.no_digital) {
+		if (digital_rate[dev] > 0)
+			chip->board.dig_rate = digital_rate[dev];
+
+		chip->reg_control |= chip->board.digital_fmt;
+
+		err = snd_bt87x_pcm(chip, DEVICE_DIGITAL, "Bt87x Digital");
+		if (err < 0)
+			goto _error;
+	}
+	if (! chip->board.no_analog) {
+		err = snd_bt87x_pcm(chip, DEVICE_ANALOG, "Bt87x Analog");
+		if (err < 0)
+			goto _error;
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_bt87x_capture_volume, chip));
+		if (err < 0)
+			goto _error;
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_bt87x_capture_boost, chip));
+		if (err < 0)
+			goto _error;
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_bt87x_capture_source, chip));
+		if (err < 0)
+			goto _error;
+	}
+	snd_printk(KERN_INFO "bt87x%d: Using board %d, %sanalog, %sdigital (rate %d Hz)\n",
+		   dev, boardid, chip->board.no_analog ? "no " : "",
+		   chip->board.no_digital ? "no " : "",
+		   chip->board.dig_rate);

 	strcpy(card->driver, "Bt87x");
 	sprintf(card->shortname, "Brooktree Bt%x", pci->device);
@@ -897,8 +965,8 @@ static void __devexit snd_bt87x_remove(s
 /* default entries for all Bt87x cards - it's not exported */
 /* driver_data is set to 0 to call detection */
 static struct pci_device_id snd_bt87x_default_ids[] __devinitdata = {
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, PCI_ANY_ID, PCI_ANY_ID, 0),
-	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_879, PCI_ANY_ID, PCI_ANY_ID, 0),
+	BT_DEVICE(_878, PCI_ANY_ID, PCI_ANY_ID, SND_BT87X_BOARD_GENERIC),
+	BT_DEVICE(_879, PCI_ANY_ID, PCI_ANY_ID, SND_BT87X_BOARD_GENERIC),
 	{ }
 };
