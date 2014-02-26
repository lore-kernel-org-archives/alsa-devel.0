From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 39/48] ALSA: oxygen: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:41 +0100
Message-ID: <1393430030-26704-40-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 536A22657DB
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EB60175045
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/oxygen/oxygen_io.c  |  8 ++++----
 sound/pci/oxygen/oxygen_lib.c | 10 +++++-----
 sound/pci/oxygen/xonar_hdmi.c |  2 +-
 sound/pci/oxygen/xonar_lib.c  |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 3274907189fe..4b8a32c37e31 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -147,7 +147,7 @@ void oxygen_write_ac97(struct oxygen *chip, unsigned int codec,
 			return;
 		}
 	}
-	snd_printk(KERN_ERR "AC'97 write timeout\n");
+	dev_err(chip->card->dev, "AC'97 write timeout\n");
 }
 EXPORT_SYMBOL(oxygen_write_ac97);
 
@@ -179,7 +179,7 @@ u16 oxygen_read_ac97(struct oxygen *chip, unsigned int codec,
 			reg ^= 0xffff;
 		}
 	}
-	snd_printk(KERN_ERR "AC'97 read timeout on codec %u\n", codec);
+	dev_err(chip->card->dev, "AC'97 read timeout on codec %u\n", codec);
 	return 0;
 }
 EXPORT_SYMBOL(oxygen_read_ac97);
@@ -208,7 +208,7 @@ static int oxygen_wait_spi(struct oxygen *chip)
 						OXYGEN_SPI_BUSY) == 0)
 			return 0;
 	}
-	snd_printk(KERN_ERR "oxygen: SPI wait timeout\n");
+	dev_err(chip->card->dev, "oxygen: SPI wait timeout\n");
 	return -EIO;
 }
 
@@ -288,5 +288,5 @@ void oxygen_write_eeprom(struct oxygen *chip, unsigned int index, u16 value)
 		      & OXYGEN_EEPROM_BUSY))
 			return;
 	}
-	snd_printk(KERN_ERR "EEPROM write timeout\n");
+	dev_err(chip->card->dev, "EEPROM write timeout\n");
 }
diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index efa610cd735c..b67e30602473 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -313,7 +313,7 @@ static void oxygen_restore_eeprom(struct oxygen *chip,
 		oxygen_clear_bits8(chip, OXYGEN_MISC,
 				   OXYGEN_MISC_WRITE_PCI_SUBID);
 
-		snd_printk(KERN_INFO "EEPROM ID restored\n");
+		dev_info(chip->card->dev, "EEPROM ID restored\n");
 	}
 }
 
@@ -617,13 +617,13 @@ int oxygen_pci_probe(struct pci_dev *pci, int index, char *id,
 
 	err = pci_request_regions(pci, DRIVER);
 	if (err < 0) {
-		snd_printk(KERN_ERR "cannot reserve PCI resources\n");
+		dev_err(card->dev, "cannot reserve PCI resources\n");
 		goto err_pci_enable;
 	}
 
 	if (!(pci_resource_flags(pci, 0) & IORESOURCE_IO) ||
 	    pci_resource_len(pci, 0) < OXYGEN_IO_SIZE) {
-		snd_printk(KERN_ERR "invalid PCI I/O range\n");
+		dev_err(card->dev, "invalid PCI I/O range\n");
 		err = -ENXIO;
 		goto err_pci_regions;
 	}
@@ -658,7 +658,7 @@ int oxygen_pci_probe(struct pci_dev *pci, int index, char *id,
 	err = request_irq(pci->irq, oxygen_interrupt, IRQF_SHARED,
 			  KBUILD_MODNAME, chip);
 	if (err < 0) {
-		snd_printk(KERN_ERR "cannot grab interrupt %d\n", pci->irq);
+		dev_err(card->dev, "cannot grab interrupt %d\n", pci->irq);
 		goto err_card;
 	}
 	chip->irq = pci->irq;
@@ -796,7 +796,7 @@ static int oxygen_pci_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		snd_printk(KERN_ERR "cannot reenable device");
+		dev_err(dev, "cannot reenable device");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
diff --git a/sound/pci/oxygen/xonar_hdmi.c b/sound/pci/oxygen/xonar_hdmi.c
index 136dac6a3964..91d92bc32b75 100644
--- a/sound/pci/oxygen/xonar_hdmi.c
+++ b/sound/pci/oxygen/xonar_hdmi.c
@@ -120,7 +120,7 @@ void xonar_hdmi_uart_input(struct oxygen *chip)
 	if (chip->uart_input_count >= 2 &&
 	    chip->uart_input[chip->uart_input_count - 2] == 'O' &&
 	    chip->uart_input[chip->uart_input_count - 1] == 'K') {
-		printk(KERN_DEBUG "message from HDMI chip received:\n");
+		dev_dbg(chip->card->dev, "message from HDMI chip received:\n");
 		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
 				     chip->uart_input, chip->uart_input_count);
 		chip->uart_input_count = 0;
diff --git a/sound/pci/oxygen/xonar_lib.c b/sound/pci/oxygen/xonar_lib.c
index 0ebe7f5916f9..706b1a42163f 100644
--- a/sound/pci/oxygen/xonar_lib.c
+++ b/sound/pci/oxygen/xonar_lib.c
@@ -56,9 +56,9 @@ static void xonar_ext_power_gpio_changed(struct oxygen *chip)
 	if (has_power != data->has_power) {
 		data->has_power = has_power;
 		if (has_power) {
-			snd_printk(KERN_NOTICE "power restored\n");
+			dev_notice(chip->card->dev, "power restored\n");
 		} else {
-			snd_printk(KERN_CRIT
+			dev_crit(chip->card->dev,
 				   "Hey! Don't unplug the power cable!\n");
 			/* TODO: stop PCMs */
 		}
-- 
1.9.0
