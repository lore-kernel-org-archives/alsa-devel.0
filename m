From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/48] ALSA: maestro3: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:21 +0100
Message-ID: <1393430030-26704-20-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD522657AD
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B633675023
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
 sound/pci/maestro3.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 076c3ec000c0..0d3ea3e79952 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1403,7 +1403,7 @@ static int snd_m3_pcm_hw_params(struct snd_pcm_substream *substream,
 	/* set buffer address */
 	s->buffer_addr = substream->runtime->dma_addr;
 	if (s->buffer_addr & 0x3) {
-		snd_printk(KERN_ERR "oh my, not aligned\n");
+		dev_err(substream->pcm->card->dev, "oh my, not aligned\n");
 		s->buffer_addr = s->buffer_addr & ~0x3;
 	}
 	return 0;
@@ -1900,7 +1900,7 @@ static int snd_m3_ac97_wait(struct snd_m3 *chip)
 		cpu_relax();
 	} while (i-- > 0);
 
-	snd_printk(KERN_ERR "ac97 serial bus busy\n");
+	dev_err(chip->card->dev, "ac97 serial bus busy\n");
 	return 1;
 }
 
@@ -2015,7 +2015,8 @@ static void snd_m3_ac97_reset(struct snd_m3 *chip)
 		delay1 += 10;
 		delay2 += 100;
 
-		snd_printd("maestro3: retrying codec reset with delays of %d and %d ms\n",
+		dev_dbg(chip->card->dev,
+			"retrying codec reset with delays of %d and %d ms\n",
 			   delay1, delay2);
 	}
 
@@ -2194,7 +2195,8 @@ static int snd_m3_assp_client_init(struct snd_m3 *chip, struct m3_dma *s, int in
 	address = 0x1100 + ((data_bytes/2) * index);
 
 	if ((address + (data_bytes/2)) >= 0x1c00) {
-		snd_printk(KERN_ERR "no memory for %d bytes at ind %d (addr 0x%x)\n",
+		dev_err(chip->card->dev,
+			"no memory for %d bytes at ind %d (addr 0x%x)\n",
 			   data_bytes, index, address);
 		return -ENOMEM;
 	}
@@ -2439,8 +2441,7 @@ static int m3_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "maestor3: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -2553,7 +2554,8 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(28)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(28)) < 0) {
-		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
+		dev_err(card->dev,
+			"architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -2586,9 +2588,8 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	else {
 		quirk = snd_pci_quirk_lookup(pci, m3_amp_quirk_list);
 		if (quirk) {
-			snd_printdd(KERN_INFO
-				    "maestro3: set amp-gpio for '%s'\n",
-				    snd_pci_quirk_name(quirk));
+			dev_info(card->dev, "set amp-gpio for '%s'\n",
+				 snd_pci_quirk_name(quirk));
 			chip->amp_gpio = quirk->value;
 		} else if (chip->allegro_flag)
 			chip->amp_gpio = GPO_EXT_AMP_ALLEGRO;
@@ -2598,9 +2599,8 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	quirk = snd_pci_quirk_lookup(pci, m3_irda_quirk_list);
 	if (quirk) {
-		snd_printdd(KERN_INFO
-			    "maestro3: enabled irda workaround for '%s'\n",
-			    snd_pci_quirk_name(quirk));
+		dev_info(card->dev, "enabled irda workaround for '%s'\n",
+			 snd_pci_quirk_name(quirk));
 		chip->irda_workaround = 1;
 	}
 	quirk = snd_pci_quirk_lookup(pci, m3_hv_quirk_list);
@@ -2652,7 +2652,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	if (request_irq(pci->irq, snd_m3_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_m3_free(chip);
 		return -ENOMEM;
 	}
@@ -2661,7 +2661,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 #ifdef CONFIG_PM_SLEEP
 	chip->suspend_mem = vmalloc(sizeof(u16) * (REV_B_CODE_MEMORY_LENGTH + REV_B_DATA_MEMORY_LENGTH));
 	if (chip->suspend_mem == NULL)
-		snd_printk(KERN_WARNING "can't allocate apm buffer\n");
+		dev_warn(card->dev, "can't allocate apm buffer\n");
 #endif
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
@@ -2685,8 +2685,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	if (chip->hv_config & HV_CTRL_ENABLE) {
 		err = snd_m3_input_register(chip);
 		if (err)
-			snd_printk(KERN_WARNING "Input device registration "
-				"failed with error %i", err);
+			dev_warn(card->dev,
+				 "Input device registration failed with error %i",
+				 err);
 	}
 #endif
 
@@ -2763,7 +2764,7 @@ snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 				  MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
 				  -1, &chip->rmidi);
 	if (err < 0)
-		printk(KERN_WARNING "maestro3: no MIDI support.\n");
+		dev_warn(card->dev, "no MIDI support.\n");
 #endif
 
 	pci_set_drvdata(pci, card);
-- 
1.9.0
