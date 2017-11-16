From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: korg1212: Use common error handling
 code in two functions
Date: Thu, 16 Nov 2017 12:53:40 +0100
Message-ID: <2165666c-69f9-c716-8ee8-f5071a41f37d@users.sourceforge.net>
References: <3f68211d-51f0-2990-d711-44eaeb85ba4d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F785266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 12:54:18 +0100 (CET)
In-Reply-To: <3f68211d-51f0-2990-d711-44eaeb85ba4d@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 11:55:58 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/korg1212/korg1212.c | 62 ++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index dc701519d219..b908c7c986ab 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2181,8 +2181,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 
         korg1212 = kzalloc(sizeof(*korg1212), GFP_KERNEL);
         if (korg1212 == NULL) {
-		pci_disable_device(pci);
-                return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	korg1212->card = card;
@@ -2216,8 +2216,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	err = pci_request_regions(pci, "korg1212");
 	if (err < 0) {
 		kfree(korg1212);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 
         korg1212->iomem = pci_resource_start(korg1212->pci, 0);
@@ -2242,8 +2241,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	if (!korg1212->iobase) {
 		snd_printk(KERN_ERR "korg1212: unable to remap memory region 0x%lx-0x%lx\n", korg1212->iomem,
                            korg1212->iomem + iomem_size - 1);
-                snd_korg1212_free(korg1212);
-                return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
         }
 
         err = request_irq(pci->irq, snd_korg1212_interrupt,
@@ -2252,8 +2251,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 
         if (err) {
 		snd_printk(KERN_ERR "korg1212: unable to grab IRQ %d\n", pci->irq);
-                snd_korg1212_free(korg1212);
-                return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
         }
 
         korg1212->irq = pci->irq;
@@ -2298,8 +2297,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				sizeof(struct KorgSharedBuffer), &korg1212->dma_shared) < 0) {
 		snd_printk(KERN_ERR "korg1212: can not allocate shared buffer memory (%zd bytes)\n", sizeof(struct KorgSharedBuffer));
-                snd_korg1212_free(korg1212);
-                return -ENOMEM;
+		goto e_nomem;
         }
         korg1212->sharedBufferPtr = (struct KorgSharedBuffer *)korg1212->dma_shared.area;
         korg1212->sharedBufferPhy = korg1212->dma_shared.addr;
@@ -2313,8 +2311,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				korg1212->DataBufsSize, &korg1212->dma_play) < 0) {
 		snd_printk(KERN_ERR "korg1212: can not allocate play data buffer memory (%d bytes)\n", korg1212->DataBufsSize);
-                snd_korg1212_free(korg1212);
-                return -ENOMEM;
+		goto e_nomem;
         }
 	korg1212->playDataBufsPtr = (struct KorgAudioBuffer *)korg1212->dma_play.area;
 	korg1212->PlayDataPhy = korg1212->dma_play.addr;
@@ -2325,8 +2322,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				korg1212->DataBufsSize, &korg1212->dma_rec) < 0) {
 		snd_printk(KERN_ERR "korg1212: can not allocate record data buffer memory (%d bytes)\n", korg1212->DataBufsSize);
-                snd_korg1212_free(korg1212);
-                return -ENOMEM;
+		goto e_nomem;
         }
         korg1212->recordDataBufsPtr = (struct KorgAudioBuffer *)korg1212->dma_rec.area;
         korg1212->RecDataPhy = korg1212->dma_rec.addr;
@@ -2353,16 +2349,14 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	err = request_firmware(&dsp_code, "korg/k1212.dsp", &pci->dev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "firmware not available\n");
-		snd_korg1212_free(korg1212);
-		return err;
+		goto free_sound_chip;
 	}
 
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				dsp_code->size, &korg1212->dma_dsp) < 0) {
 		snd_printk(KERN_ERR "korg1212: cannot allocate dsp code memory (%zd bytes)\n", dsp_code->size);
-                snd_korg1212_free(korg1212);
 		release_firmware(dsp_code);
-                return -ENOMEM;
+		goto e_nomem;
         }
 
         K1212_DEBUG_PRINTK("K1212_DEBUG: DSP Code area = 0x%p (0x%08x) %d bytes [%s]\n",
@@ -2379,10 +2373,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 		K1212_DEBUG_PRINTK("K1212_DEBUG: Reboot Card - RC = %d [%s]\n", rc, stateName[korg1212->cardState]);
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, korg1212, &ops);
-	if (err < 0) {
-                snd_korg1212_free(korg1212);
-                return err;
-        }
+	if (err < 0)
+		goto free_sound_chip;
         
 	snd_korg1212_EnableCardInterrupts(korg1212);
 
@@ -2429,6 +2421,15 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
         * rchip = korg1212;
 	return 0;
 
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_nomem:
+	err = -ENOMEM;
+free_sound_chip:
+	snd_korg1212_free(korg1212);
+	return err;
 }
 
 /*
@@ -2457,10 +2458,8 @@ snd_korg1212_probe(struct pci_dev *pci,
 		return err;
 
 	err = snd_korg1212_create(card, pci, &korg1212);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "korg1212");
 	strcpy(card->shortname, "korg1212");
@@ -2470,13 +2469,16 @@ snd_korg1212_probe(struct pci_dev *pci,
         K1212_DEBUG_PRINTK("K1212_DEBUG: %s\n", card->longname);
 
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
 
 static void snd_korg1212_remove(struct pci_dev *pci)
-- 
2.15.0
