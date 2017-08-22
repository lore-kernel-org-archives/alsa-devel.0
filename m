From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: maestro3: Use common error handling code
 in two functions
Date: Tue, 22 Aug 2017 15:43:03 +0200
Message-ID: <e6f4f769-eef7-75e7-19b2-7052328f4b9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2AC266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 15:43:11 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 15:00:27 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/maestro3.c | 55 +++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index cafea6dc5c01..759c3f6ad7aa 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2622,22 +2622,18 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	err = request_firmware(&chip->assp_kernel_image,
 			       "ess/maestro3_assp_kernel.fw", &pci->dev);
-	if (err < 0) {
-		snd_m3_free(chip);
-		return err;
-	}
+	if (err)
+		goto free_chip;
 
 	err = request_firmware(&chip->assp_minisrc_image,
 			       "ess/maestro3_assp_minisrc.fw", &pci->dev);
-	if (err < 0) {
-		snd_m3_free(chip);
-		return err;
-	}
+	if (err)
+		goto free_chip;
+
+	err = pci_request_regions(pci, card->driver);
+	if (err)
+		goto free_chip;
 
-	if ((err = pci_request_regions(pci, card->driver)) < 0) {
-		snd_m3_free(chip);
-		return err;
-	}
 	chip->iobase = pci_resource_start(pci, 0);
 	
 	/* just to be sure */
@@ -2655,8 +2651,8 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	if (request_irq(pci->irq, snd_m3_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_m3_free(chip);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_chip;
 	}
 	chip->irq = pci->irq;
 
@@ -2666,10 +2662,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 		dev_warn(card->dev, "can't allocate apm buffer\n");
 #endif
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_m3_free(chip);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err)
+		goto free_chip;
 
 	if ((err = snd_m3_mixer(chip)) < 0)
 		return err;
@@ -2699,6 +2694,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	*chip_ret = chip;
 
 	return 0; 
+free_chip:
+	snd_m3_free(chip);
+	return err;
 }
 
 /*
@@ -2741,23 +2739,19 @@ snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		break;
 	}
 
-	if ((err = snd_m3_create(card, pci,
-				 external_amp[dev],
-				 amp_gpio[dev],
-				 &chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_m3_create(card, pci, external_amp[dev], amp_gpio[dev], &chip);
+	if (err)
+		goto free_card;
+
 	card->private_data = chip;
 
 	sprintf(card->shortname, "ESS %s PCI", card->driver);
 	sprintf(card->longname, "%s at 0x%lx, irq %d",
 		card->shortname, chip->iobase, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err)
+		goto free_card;
 
 #if 0 /* TODO: not supported yet */
 	/* TODO enable MIDI IRQ and I/O */
@@ -2772,6 +2766,9 @@ snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_m3_remove(struct pci_dev *pci)
-- 
2.14.0
