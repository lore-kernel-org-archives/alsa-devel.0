From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: aw2: Use common error handling code in
	three functions
Date: Mon, 13 Nov 2017 09:56:51 +0100
Message-ID: <ba658643-9ab7-5c78-832b-401291c184c0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FCF1266A73
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 09:57:37 +0100 (CET)
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
Date: Mon, 13 Nov 2017 09:49:15 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/aw2/aw2-alsa.c | 85 +++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 9a49e4243a9c..25710043c79d 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -261,13 +261,13 @@ static int snd_aw2_create(struct snd_card *card,
 	if ((dma_set_mask(&pci->dev, DMA_BIT_MASK(32)) < 0) ||
 	    (dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(32)) < 0)) {
 		dev_err(card->dev, "Impossible to set 32bit mask DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	/* initialize the stuff */
@@ -277,11 +277,9 @@ static int snd_aw2_create(struct snd_card *card,
 
 	/* (1) PCI resource allocation */
 	err = pci_request_regions(pci, "Audiowerk2");
-	if (err < 0) {
-		pci_disable_device(pci);
-		kfree(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_data;
+
 	chip->iobase_phys = pci_resource_start(pci, 0);
 	chip->iobase_virt =
 		ioremap_nocache(chip->iobase_phys,
@@ -289,10 +287,8 @@ static int snd_aw2_create(struct snd_card *card,
 
 	if (chip->iobase_virt == NULL) {
 		dev_err(card->dev, "unable to remap memory region");
-		pci_release_regions(pci);
-		pci_disable_device(pci);
-		kfree(chip);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto release_regions;
 	}
 
 	/* (2) initialization of the chip hardware */
@@ -301,23 +297,15 @@ static int snd_aw2_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_aw2_saa7146_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "Cannot grab irq %d\n", pci->irq);
-
-		iounmap(chip->iobase_virt);
-		pci_release_regions(chip->pci);
-		pci_disable_device(chip->pci);
-		kfree(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto unmap_io;
 	}
 	chip->irq = pci->irq;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		free_irq(chip->irq, (void *)chip);
-		iounmap(chip->iobase_virt);
-		pci_release_regions(chip->pci);
-		pci_disable_device(chip->pci);
-		kfree(chip);
-		return err;
+		goto unmap_io;
 	}
 
 	*rchip = chip;
@@ -325,6 +313,16 @@ static int snd_aw2_create(struct snd_card *card,
 	dev_info(card->dev,
 		 "Audiowerk 2 sound card (saa7146 chipset) detected and managed\n");
 	return 0;
+
+unmap_io:
+	iounmap(chip->iobase_virt);
+release_regions:
+	pci_release_regions(pci);
+free_data:
+	kfree(chip);
+disable_device:
+	pci_disable_device(pci);
+	return err;
 }
 
 /* constructor */
@@ -352,10 +350,8 @@ static int snd_aw2_probe(struct pci_dev *pci,
 
 	/* (3) Create main component */
 	err = snd_aw2_create(card, pci, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	/* initialize mutex */
 	mutex_init(&chip->mtx);
@@ -373,16 +369,18 @@ static int snd_aw2_probe(struct pci_dev *pci,
 
 	/* (6) Register card instance */
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	/* (7) Set PCI driver data */
 	pci_set_drvdata(pci, card);
 
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 /* destructor */
@@ -599,10 +597,8 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 analog playback", 0, 1, 0,
 			  &pcm_playback_ana);
-	if (err < 0) {
-		dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_failure;
 
 	/* Creation ok */
 	pcm_device = &chip->device_playback[NUM_STREAM_PLAYBACK_ANA];
@@ -636,11 +632,9 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 digital playback", 1, 1, 0,
 			  &pcm_playback_num);
+	if (err < 0)
+		goto report_failure;
 
-	if (err < 0) {
-		dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
-		return err;
-	}
 	/* Creation ok */
 	pcm_device = &chip->device_playback[NUM_STREAM_PLAYBACK_DIG];
 
@@ -673,11 +667,8 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 capture", 2, 0, 1,
 			  &pcm_capture);
-
-	if (err < 0) {
-		dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_failure;
 
 	/* Creation ok */
 	pcm_device = &chip->device_capture[NUM_STREAM_CAPTURE_ANA];
@@ -718,6 +709,10 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 	}
 
 	return 0;
+
+report_failure:
+	dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
+	return err;
 }
 
 static int snd_aw2_control_switch_capture_info(struct snd_kcontrol *kcontrol,
-- 
2.15.0
