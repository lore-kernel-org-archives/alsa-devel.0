From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: als300: Use common error handling code
	in two functions
Date: Sun, 12 Nov 2017 13:03:04 +0100
Message-ID: <05cbc30d-ca3b-0c0c-ef7f-fc128bcc8753@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 26636266A73
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 13:03:43 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Nov 2017 12:52:50 +0100

* Add jump targets so that a bit of exception handling can be better reused
  at the end of these functions.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix six affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/als300.c | 65 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index eaa2d853d922..fd5ba75595cc 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -655,21 +655,22 @@ static int snd_als300_create(struct snd_card *card,
 	};
 	*rchip = NULL;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(28)) < 0 ||
 		dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(28)) < 0) {
 		dev_err(card->dev, "error setting 28bit DMA mask\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 	pci_set_master(pci);
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	chip->card = card;
@@ -678,10 +679,10 @@ static int snd_als300_create(struct snd_card *card,
 	chip->chip_type = chip_type;
 	spin_lock_init(&chip->reg_lock);
 
-	if ((err = pci_request_regions(pci, "ALS300")) < 0) {
+	err = pci_request_regions(pci, "ALS300");
+	if (err < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	chip->port = pci_resource_start(pci, 0);
 
@@ -693,8 +694,8 @@ static int snd_als300_create(struct snd_card *card,
 	if (request_irq(pci->irq, irq_handler, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_als300_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 
@@ -704,24 +705,29 @@ static int snd_als300_create(struct snd_card *card,
 	err = snd_als300_ac97(chip);
 	if (err < 0) {
 		dev_err(card->dev, "Could not create ac97\n");
-		snd_als300_free(chip);
-		return err;
+		goto free_sound_chip;
 	}
 
-	if ((err = snd_als300_new_pcm(chip)) < 0) {
+	err = snd_als300_new_pcm(chip);
+	if (err < 0) {
 		dev_err(card->dev, "Could not create PCM\n");
-		snd_als300_free(chip);
-		return err;
+		goto free_sound_chip;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
-						chip, &ops)) < 0) {
-		snd_als300_free(chip);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto free_sound_chip;
 
 	*rchip = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+free_sound_chip:
+	snd_als300_free(chip);
+	return err;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -776,11 +782,10 @@ static int snd_als300_probe(struct pci_dev *pci,
 		return err;
 
 	chip_type = pci_id->driver_data;
+	err = snd_als300_create(card, pci, chip_type, &chip);
+	if (err < 0)
+		goto free_card;
 
-	if ((err = snd_als300_create(card, pci, chip_type, &chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
 	card->private_data = chip;
 
 	strcpy(card->driver, "ALS300");
@@ -794,13 +799,17 @@ static int snd_als300_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx irq %i",
 				card->shortname, chip->port, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static struct pci_driver als300_driver = {
-- 
2.15.0
