From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: ens1370: Use common error handling
 code in snd_ensoniq_create()
Date: Tue, 14 Nov 2017 18:48:23 +0100
Message-ID: <0cec4a4f-5ba5-d88b-ae04-b2a4be948dfe@users.sourceforge.net>
References: <8bcf1ada-f44c-cb83-0890-adc8ae8edda0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id BACDB266F61
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 18:48:30 +0100 (CET)
In-Reply-To: <8bcf1ada-f44c-cb83-0890-adc8ae8edda0@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 Nov 2017 18:28:30 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ens1370.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 55c5173036d3..4b4ca772cafb 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2097,8 +2097,8 @@ static int snd_ensoniq_create(struct snd_card *card,
 		return err;
 	ensoniq = kzalloc(sizeof(*ensoniq), GFP_KERNEL);
 	if (ensoniq == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	spin_lock_init(&ensoniq->reg_lock);
 	mutex_init(&ensoniq->src_mutex);
@@ -2108,23 +2108,20 @@ static int snd_ensoniq_create(struct snd_card *card,
 	err = pci_request_regions(pci, "Ensoniq AudioPCI");
 	if (err < 0) {
 		kfree(ensoniq);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	ensoniq->port = pci_resource_start(pci, 0);
 	if (request_irq(pci->irq, snd_audiopci_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, ensoniq)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_ensoniq_free(ensoniq);
-		return -EBUSY;
+		goto e_busy;
 	}
 	ensoniq->irq = pci->irq;
 #ifdef CHIP1370
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				16, &ensoniq->dma_bug) < 0) {
 		dev_err(card->dev, "unable to allocate space for phantom area - dma_bug\n");
-		snd_ensoniq_free(ensoniq);
-		return -EBUSY;
+		goto e_busy;
 	}
 #endif
 	pci_set_master(pci);
@@ -2150,15 +2147,23 @@ static int snd_ensoniq_create(struct snd_card *card,
 
 	snd_ensoniq_chip_init(ensoniq);
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops);
-	if (err < 0) {
-		snd_ensoniq_free(ensoniq);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	snd_ensoniq_proc_init(ensoniq);
 
 	*rensoniq = ensoniq;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_busy:
+	err = -EBUSY;
+free_sound_chip:
+	snd_ensoniq_free(ensoniq);
+	return err;
 }
 
 /*
-- 
2.15.0
