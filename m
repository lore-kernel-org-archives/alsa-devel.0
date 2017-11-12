From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: ad1889: Use common error handling code
 in snd_ad1889_create()
Date: Sun, 12 Nov 2017 10:26:58 +0100
Message-ID: <252c71ed-af89-ed5f-d75f-c09292e68bd5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 8368A266B02
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 10:27:10 +0100 (CET)
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
To: alsa-devel@alsa-project.org, linux-parisc@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thibaut Varene <T-Bone@parisc-linux.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Nov 2017 10:10:53 +0100

* Adjust jump targets so that a bit of exception handling can be better
  reused at the end of this function.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix five affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ad1889.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 0bf2c04eeada..9f00e63937a5 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -894,21 +894,23 @@ snd_ad1889_create(struct snd_card *card,
 
 	*rchip = NULL;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	/* check PCI availability (32bit DMA) */
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(32)) < 0 ||
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(32)) < 0) {
 		dev_err(card->dev, "error setting 32-bit DMA mask.\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 
 	/* allocate chip specific data with zero-filled memory */
-	if ((chip = kzalloc(sizeof(*chip), GFP_KERNEL)) == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip) {
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	chip->card = card;
@@ -917,15 +919,16 @@ snd_ad1889_create(struct snd_card *card,
 	chip->irq = -1;
 
 	/* (1) PCI resource allocation */
-	if ((err = pci_request_regions(pci, card->driver)) < 0)
-		goto free_and_ret;
+	err = pci_request_regions(pci, card->driver);
+	if (err < 0)
+		goto free_data;
 
 	chip->bar = pci_resource_start(pci, 0);
 	chip->iobase = pci_ioremap_bar(pci, 0);
 	if (chip->iobase == NULL) {
 		dev_err(card->dev, "unable to reserve region.\n");
 		err = -EBUSY;
-		goto free_and_ret;
+		goto free_data;
 	}
 	
 	pci_set_master(pci);
@@ -935,32 +938,34 @@ snd_ad1889_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_ad1889_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "cannot obtain IRQ %d\n", pci->irq);
-		snd_ad1889_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 
 	chip->irq = pci->irq;
 	synchronize_irq(chip->irq);
 
 	/* (2) initialization of the chip hardware */
-	if ((err = snd_ad1889_init(chip)) < 0) {
-		snd_ad1889_free(chip);
-		return err;
-	}
+	err = snd_ad1889_init(chip);
+	if (err < 0)
+		goto free_sound_chip;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_ad1889_free(chip);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto free_sound_chip;
 
 	*rchip = chip;
 
 	return 0;
 
-free_and_ret:
+free_data:
 	kfree(chip);
+disable_device:
 	pci_disable_device(pci);
+	return err;
 
+free_sound_chip:
+	snd_ad1889_free(chip);
 	return err;
 }
 
-- 
2.15.0
