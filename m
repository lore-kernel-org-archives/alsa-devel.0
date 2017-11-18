From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: trident: Use common error handling
 code in two functions
Date: Sat, 18 Nov 2017 20:12:33 +0100
Message-ID: <5fc2dcb3-3016-5a0a-62f4-5e873252677e@users.sourceforge.net>
References: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 66FF7266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 20:12:39 +0100 (CET)
In-Reply-To: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 19:29:35 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/trident/trident.c      | 54 +++++++++++++++++++---------------------
 sound/pci/trident/trident_main.c | 41 +++++++++++++++---------------
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index fd35f7826845..830402c32395 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -100,10 +100,9 @@ static int snd_trident_probe(struct pci_dev *pci,
 				 == TRIDENT_DEVICE_ID_SI7018 ? 1 : 2,
 				 wavetable_size[dev],
 				 &trident);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = trident;
 
 	switch (trident->device) {
@@ -130,47 +129,46 @@ static int snd_trident_probe(struct pci_dev *pci,
 		card->shortname, trident->port, trident->irq);
 
 	err = snd_trident_pcm(trident, pcm_dev++);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	switch (trident->device) {
 	case TRIDENT_DEVICE_ID_DX:
 	case TRIDENT_DEVICE_ID_NX:
 		err = snd_trident_foldback_pcm(trident, pcm_dev++);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 		break;
 	}
 	if (trident->device == TRIDENT_DEVICE_ID_NX || trident->device == TRIDENT_DEVICE_ID_SI7018) {
 		err = snd_trident_spdif_pcm(trident, pcm_dev++);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
-	if (trident->device != TRIDENT_DEVICE_ID_SI7018 &&
-	    (err = snd_mpu401_uart_new(card, 0, MPU401_HW_TRID4DWAVE,
-				       trident->midi_port,
-				       MPU401_INFO_INTEGRATED |
-				       MPU401_INFO_IRQ_HOOK,
-				       -1, &trident->rmidi)) < 0) {
-		snd_card_free(card);
-		return err;
+
+	if (trident->device != TRIDENT_DEVICE_ID_SI7018) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_TRID4DWAVE,
+					  trident->midi_port,
+					  MPU401_INFO_INTEGRATED |
+					  MPU401_INFO_IRQ_HOOK,
+					  -1, &trident->rmidi);
+		if (err < 0)
+			goto free_card;
 	}
 
 	snd_trident_create_gameport(trident);
 
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
 
 static void snd_trident_remove(struct pci_dev *pci)
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 88d666cb3300..9843a61a8ead 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3587,14 +3587,14 @@ int snd_trident_create(struct snd_card *card,
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(30)) < 0) {
 		dev_err(card->dev,
 			"architecture does not support 30bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 	
 	trident = kzalloc(sizeof(*trident), GFP_KERNEL);
 	if (trident == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	trident->device = (pci->vendor << 16) | pci->device;
 	trident->card = card;
@@ -3617,16 +3617,15 @@ int snd_trident_create(struct snd_card *card,
 	err = pci_request_regions(pci, "Trident Audio");
 	if (err < 0) {
 		kfree(trident);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	trident->port = pci_resource_start(pci, 0);
 
 	if (request_irq(pci->irq, snd_trident_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, trident)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_trident_free(trident);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	trident->irq = pci->irq;
 
@@ -3635,10 +3634,8 @@ int snd_trident_create(struct snd_card *card,
 	trident->tlb.buffer.area = NULL;
 	if (trident->device == TRIDENT_DEVICE_ID_NX) {
 		err = snd_trident_tlb_alloc(trident);
-		if (err < 0) {
-			snd_trident_free(trident);
-			return err;
-		}
+		if (err < 0)
+			goto free_sound_chip;
 	}
 
 	trident->spdif_bits = trident->spdif_pcm_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
@@ -3658,16 +3655,12 @@ int snd_trident_create(struct snd_card *card,
 		snd_BUG();
 		break;
 	}
-	if (err < 0) {
-		snd_trident_free(trident);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, trident, &ops);
-	if (err < 0) {
-		snd_trident_free(trident);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	err = snd_trident_mixer(trident, pcm_spdif_device);
 	if (err < 0)
@@ -3693,6 +3686,14 @@ int snd_trident_create(struct snd_card *card,
 	snd_trident_proc_init(trident);
 	*rtrident = trident;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+free_sound_chip:
+	snd_trident_free(trident);
+	return err;
 }
 
 /*---------------------------------------------------------------------------
-- 
2.15.0
