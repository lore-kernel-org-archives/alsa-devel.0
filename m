From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: es1968: Use common error handling
 code in two functions
Date: Wed, 15 Nov 2017 10:29:27 +0100
Message-ID: <ce589af7-81c7-8880-1d05-016873e17db9@users.sourceforge.net>
References: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B3D266E67
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 10:29:34 +0100 (CET)
In-Reply-To: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
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
Date: Wed, 15 Nov 2017 09:04:41 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/es1968.c | 66 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index d68980087f93..7777ec583e20 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2702,14 +2702,14 @@ static int snd_es1968_create(struct snd_card *card,
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(28)) < 0) {
 		dev_err(card->dev,
 			"architecture does not support 28bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	/* Set Vars */
@@ -2730,15 +2730,14 @@ static int snd_es1968_create(struct snd_card *card,
 	err = pci_request_regions(pci, "ESS Maestro");
 	if (err < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	chip->io_port = pci_resource_start(pci, 0);
 	if (request_irq(pci->irq, snd_es1968_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_es1968_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 	        
@@ -2775,20 +2774,17 @@ static int snd_es1968_create(struct snd_card *card,
 	snd_es1968_chip_init(chip);
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_es1968_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 #ifdef CONFIG_SND_ES1968_RADIO
 	/* don't play with GPIOs on laptops */
 	if (chip->pci->subsystem_vendor != 0x125d)
 		goto no_radio;
 	err = v4l2_device_register(&pci->dev, &chip->v4l2_dev);
-	if (err < 0) {
-		snd_es1968_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
+
 	chip->tea.v4l2_dev = &chip->v4l2_dev;
 	chip->tea.private_data = chip;
 	chip->tea.radio_nr = radio_nr;
@@ -2810,6 +2806,14 @@ static int snd_es1968_create(struct snd_card *card,
 	*chip_ret = chip;
 
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+free_sound_chip:
+	snd_es1968_free(chip);
+	return err;
 }
 
 
@@ -2849,10 +2853,9 @@ static int snd_es1968_probe(struct pci_dev *pci,
 				use_pm[dev],
 				radio_nr[dev],
 				&chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	switch (chip->type) {
@@ -2871,16 +2874,12 @@ static int snd_es1968_probe(struct pci_dev *pci,
 	}
 
 	err = snd_es1968_pcm(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	err = snd_es1968_mixer(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	if (enable_mpu[dev] == 2) {
 		/* check the black list */
@@ -2923,13 +2922,16 @@ static int snd_es1968_probe(struct pci_dev *pci,
 		card->shortname, chip->io_port, chip->irq);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
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
 
 static void snd_es1968_remove(struct pci_dev *pci)
-- 
2.15.0
