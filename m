From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: mixart: Use common error handling
 code in snd_mixart_probe()
Date: Thu, 16 Nov 2017 16:36:12 +0100
Message-ID: <d4bad61d-fa9d-283f-1cce-b5c7a7efa640@users.sourceforge.net>
References: <6f8ce522-66ac-9740-41fb-2df6ab6f3aec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AAD95266F1D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 16:36:19 +0100 (CET)
In-Reply-To: <6f8ce522-66ac-9740-41fb-2df6ab6f3aec@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 16:18:38 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/mixart/mixart.c | 61 ++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index ff90a06f775e..928079520502 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1274,16 +1274,16 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(32)) < 0) {
 		dev_err(&pci->dev,
 			"architecture does not support 32bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 
 	/*
 	 */
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 	if (! mgr) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	mgr->pci = pci;
@@ -1293,8 +1293,7 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	err = pci_request_regions(pci, CARD_NAME);
 	if (err < 0) {
 		kfree(mgr);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	for (i = 0; i < 2; i++) {
 		mgr->mem[i].phys = pci_resource_start(pci, i);
@@ -1302,8 +1301,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		if (!mgr->mem[i].virt) {
 			dev_err(&pci->dev, "unable to remap resource 0x%lx\n",
 			       mgr->mem[i].phys);
-			snd_mixart_free(mgr);
-			return -EBUSY;
+			err = -EBUSY;
+			goto free_sound_chip;
 		}
 	}
 
@@ -1311,8 +1310,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 				 snd_mixart_threaded_irq, IRQF_SHARED,
 				 KBUILD_MODNAME, mgr)) {
 		dev_err(&pci->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_mixart_free(mgr);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	mgr->irq = pci->irq;
 
@@ -1345,8 +1344,7 @@ static int snd_mixart_probe(struct pci_dev *pci,
 
 		if (err < 0) {
 			dev_err(&pci->dev, "cannot allocate the card %d\n", i);
-			snd_mixart_free(mgr);
-			return err;
+			goto free_sound_chip;
 		}
 
 		strcpy(card->driver, CARD_NAME);
@@ -1359,8 +1357,7 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		err = snd_mixart_create(mgr, card, i);
 		if (err < 0) {
 			snd_card_free(card);
-			snd_mixart_free(mgr);
-			return err;
+			goto free_sound_chip;
 		}
 
 		if(i==0) {
@@ -1369,10 +1366,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		}
 
 		err = snd_card_register(card);
-		if (err < 0) {
-			snd_mixart_free(mgr);
-			return err;
-		}
+		if (err < 0)
+			goto free_sound_chip;
 	}
 
 	/* init firmware status (mgr->dsp_loaded reset in hwdep_new) */
@@ -1382,10 +1377,9 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	size = PAGE_ALIGN( (MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS *
 			    sizeof(struct mixart_flowinfo)) );
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				size, &mgr->flowinfo) < 0) {
-		snd_mixart_free(mgr);
-		return -ENOMEM;
-	}
+				size, &mgr->flowinfo) < 0)
+		goto e_nomem;
+
 	/* init streaminfo_array */
 	memset(mgr->flowinfo.area, 0, size);
 
@@ -1393,23 +1387,30 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	size = PAGE_ALIGN( (MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS *
 			    sizeof(struct mixart_bufferinfo)) );
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				size, &mgr->bufferinfo) < 0) {
-		snd_mixart_free(mgr);
-		return -ENOMEM;
-	}
+				size, &mgr->bufferinfo) < 0)
+		goto e_nomem;
+
 	/* init bufferinfo_array */
 	memset(mgr->bufferinfo.area, 0, size);
 
 	/* set up firmware */
 	err = snd_mixart_setup_firmware(mgr);
-	if (err < 0) {
-		snd_mixart_free(mgr);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	pci_set_drvdata(pci, mgr);
 	dev++;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_nomem:
+	err = -ENOMEM;
+free_sound_chip:
+	snd_mixart_free(mgr);
+	return err;
 }
 
 static void snd_mixart_remove(struct pci_dev *pci)
-- 
2.15.0
