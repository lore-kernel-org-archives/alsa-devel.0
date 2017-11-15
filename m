From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: ice1712: Use common error handling code
 in two functions
Date: Wed, 15 Nov 2017 15:55:24 +0100
Message-ID: <d3ffaa82-c47d-82a8-3325-1b95acfb70c8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 340D2266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 15:55:29 +0100 (CET)
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
Date: Wed, 15 Nov 2017 15:50:06 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ice1712/ice1712.c | 114 +++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 64 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 0e66afa403a3..691b8844465f 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2534,14 +2534,14 @@ static int snd_ice1712_create(struct snd_card *card,
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(28)) < 0) {
 		dev_err(card->dev,
 			"architecture does not support 28bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 
 	ice = kzalloc(sizeof(*ice), GFP_KERNEL);
 	if (ice == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	ice->omni = omni ? 1 : 0;
 	if (cs8427_timeout < 1)
@@ -2580,8 +2580,7 @@ static int snd_ice1712_create(struct snd_card *card,
 	err = pci_request_regions(pci, "ICE1712");
 	if (err < 0) {
 		kfree(ice);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	ice->port = pci_resource_start(pci, 0);
 	ice->ddma_port = pci_resource_start(pci, 1);
@@ -2591,29 +2590,31 @@ static int snd_ice1712_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_ice1712_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, ice)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_ice1712_free(ice);
-		return -EIO;
+		goto e_io;
 	}
 
 	ice->irq = pci->irq;
 
-	if (snd_ice1712_read_eeprom(ice, modelname) < 0) {
-		snd_ice1712_free(ice);
-		return -EIO;
-	}
-	if (snd_ice1712_chip_init(ice) < 0) {
-		snd_ice1712_free(ice);
-		return -EIO;
-	}
+	if (snd_ice1712_read_eeprom(ice, modelname) < 0 ||
+	    snd_ice1712_chip_init(ice) < 0)
+		goto e_io;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
-	if (err < 0) {
-		snd_ice1712_free(ice);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	*r_ice1712 = ice;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_io:
+	err = -EIO;
+free_sound_chip:
+	snd_ice1712_free(ice);
+	return err;
 }
 
 
@@ -2651,10 +2652,8 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 
 	err = snd_ice1712_create(card, pci, model[dev], omni[dev],
 		cs8427_timeout[dev], dxr_enable[dev], &ice);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	for (tbl = card_tables; *tbl; tbl++) {
 		for (c = *tbl; c->subvendor; c++) {
@@ -2665,10 +2664,8 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 					strcpy(card->driver, c->driver);
 				if (c->chip_init) {
 					err = c->chip_init(ice);
-					if (err < 0) {
-						snd_card_free(card);
-						return err;
-					}
+					if (err < 0)
+						goto free_card;
 				}
 				goto __found;
 			}
@@ -2678,45 +2675,33 @@ static int snd_ice1712_probe(struct pci_dev *pci,
  __found:
 
 	err = snd_ice1712_pcm_profi(ice, pcm_dev++);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	if (ice_has_con_ac97(ice)) {
 		err = snd_ice1712_pcm(ice, pcm_dev++);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
 
 	err = snd_ice1712_ac97_mixer(ice);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	err = snd_ice1712_build_controls(ice);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	if (c->build_controls) {
 		err = c->build_controls(ice);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
 
 	if (ice_has_con_ac97(ice)) {
 		err = snd_ice1712_pcm_ds(ice, pcm_dev++);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
 
 	if (!c->no_mpu401) {
@@ -2725,10 +2710,9 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 			c->mpu401_1_info_flags |
 			MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
 			-1, &ice->rmidi[0]);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
+
 		if (c->mpu401_1_name)
 			/*  Preferred name available in card_info */
 			snprintf(ice->rmidi[0]->name,
@@ -2743,10 +2727,9 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 				MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
 				-1, &ice->rmidi[1]);
 
-			if (err < 0) {
-				snd_card_free(card);
-				return err;
-			}
+			if (err < 0)
+				goto free_card;
+
 			if (c->mpu401_2_name)
 				/*  Preferred name available in card_info */
 				snprintf(ice->rmidi[1]->name,
@@ -2762,13 +2745,16 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 		card->shortname, ice->port, ice->irq);
 
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
 
 static void snd_ice1712_remove(struct pci_dev *pci)
-- 
2.15.0
