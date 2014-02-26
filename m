From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/48] ALSA: als300: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:05 +0100
Message-ID: <1393430030-26704-4-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7665A265773
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4509B75021
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert with dev_err() and co from snd_printk(), etc.
Also, correct the printk level appropriately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/als300.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index fc1043a79007..cc9a15a1304b 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -661,7 +661,7 @@ static int snd_als300_create(struct snd_card *card,
 
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(28)) < 0 ||
 		pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(28)) < 0) {
-		printk(KERN_ERR "error setting 28bit DMA mask\n");
+		dev_err(card->dev, "error setting 28bit DMA mask\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -693,7 +693,7 @@ static int snd_als300_create(struct snd_card *card,
 
 	if (request_irq(pci->irq, irq_handler, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_als300_free(chip);
 		return -EBUSY;
 	}
@@ -704,13 +704,13 @@ static int snd_als300_create(struct snd_card *card,
 
 	err = snd_als300_ac97(chip);
 	if (err < 0) {
-		snd_printk(KERN_WARNING "Could not create ac97\n");
+		dev_err(card->dev, "Could not create ac97\n");
 		snd_als300_free(chip);
 		return err;
 	}
 
 	if ((err = snd_als300_new_pcm(chip)) < 0) {
-		snd_printk(KERN_WARNING "Could not create PCM\n");
+		dev_err(card->dev, "Could not create PCM\n");
 		snd_als300_free(chip);
 		return err;
 	}
@@ -751,8 +751,7 @@ static int snd_als300_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "als300: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
-- 
1.9.0
