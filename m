From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/48] ALSA: ad1889: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:03 +0100
Message-ID: <1393430030-26704-2-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C73FF265789
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4C6F175029
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ad1889.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index ba4da1ed0444..488f966adde3 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -77,9 +77,6 @@ MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 #define DEVNAME "ad1889"
 #define PFX	DEVNAME ": "
 
-/* let's use the global sound debug interfaces */
-#define ad1889_debug(fmt, arg...) snd_printd(KERN_DEBUG fmt, ## arg)
-
 /* keep track of some hw registers */
 struct ad1889_register_state {
 	u16 reg;	/* reg setup */
@@ -264,11 +261,11 @@ snd_ad1889_ac97_ready(struct snd_ad1889 *chip)
 			&& --retry)
 		mdelay(1);
 	if (!retry) {
-		snd_printk(KERN_ERR PFX "[%s] Link is not ready.\n",
-		       __func__);
+		dev_err(chip->card->dev, "[%s] Link is not ready.\n",
+			__func__);
 		return -EIO;
 	}
-	ad1889_debug("[%s] ready after %d ms\n", __func__, 400 - retry);
+	dev_dbg(chip->card->dev, "[%s] ready after %d ms\n", __func__, 400 - retry);
 
 	return 0;
 }
@@ -405,9 +402,9 @@ snd_ad1889_playback_prepare(struct snd_pcm_substream *ss)
 	
 	spin_unlock_irq(&chip->lock);
 	
-	ad1889_debug("prepare playback: addr = 0x%x, count = %u, "
-			"size = %u, reg = 0x%x, rate = %u\n", chip->wave.addr,
-			count, size, reg, rt->rate);
+	dev_dbg(chip->card->dev,
+		"prepare playback: addr = 0x%x, count = %u, size = %u, reg = 0x%x, rate = %u\n",
+		chip->wave.addr, count, size, reg, rt->rate);
 	return 0;
 }
 
@@ -452,9 +449,9 @@ snd_ad1889_capture_prepare(struct snd_pcm_substream *ss)
 	
 	spin_unlock_irq(&chip->lock);
 	
-	ad1889_debug("prepare capture: addr = 0x%x, count = %u, "
-			"size = %u, reg = 0x%x, rate = %u\n", chip->ramc.addr,
-			count, size, reg, rt->rate);
+	dev_dbg(chip->card->dev,
+		"prepare capture: addr = 0x%x, count = %u, size = %u, reg = 0x%x, rate = %u\n",
+		chip->ramc.addr, count, size, reg, rt->rate);
 	return 0;
 }
 
@@ -614,7 +611,8 @@ snd_ad1889_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (st & (AD_DMA_DISR_PMAI|AD_DMA_DISR_PTAI))
-		ad1889_debug("Unexpected master or target abort interrupt!\n");
+		dev_dbg(chip->card->dev,
+			"Unexpected master or target abort interrupt!\n");
 
 	if ((st & AD_DMA_DISR_WAVI) && chip->psubs)
 		snd_pcm_period_elapsed(chip->psubs);
@@ -656,7 +654,7 @@ snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 						BUFFER_BYTES_MAX);
 
 	if (err < 0) {
-		snd_printk(KERN_ERR PFX "buffer allocation error: %d\n", err);
+		dev_err(chip->card->dev, "buffer allocation error: %d\n", err);
 		return err;
 	}
 	
@@ -912,7 +910,7 @@ snd_ad1889_create(struct snd_card *card,
 	/* check PCI availability (32bit DMA) */
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(32)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32)) < 0) {
-		printk(KERN_ERR PFX "error setting 32-bit DMA mask.\n");
+		dev_err(card->dev, "error setting 32-bit DMA mask.\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -935,7 +933,7 @@ snd_ad1889_create(struct snd_card *card,
 	chip->bar = pci_resource_start(pci, 0);
 	chip->iobase = pci_ioremap_bar(pci, 0);
 	if (chip->iobase == NULL) {
-		printk(KERN_ERR PFX "unable to reserve region.\n");
+		dev_err(card->dev, "unable to reserve region.\n");
 		err = -EBUSY;
 		goto free_and_ret;
 	}
@@ -946,7 +944,7 @@ snd_ad1889_create(struct snd_card *card,
 
 	if (request_irq(pci->irq, snd_ad1889_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-		printk(KERN_ERR PFX "cannot obtain IRQ %d\n", pci->irq);
+		dev_err(card->dev, "cannot obtain IRQ %d\n", pci->irq);
 		snd_ad1889_free(chip);
 		return -EBUSY;
 	}
-- 
1.9.0
