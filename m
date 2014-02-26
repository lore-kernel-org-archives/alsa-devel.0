From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 27/48] ALSA: aw2: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:29 +0100
Message-ID: <1393430030-26704-28-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 220C32657B4
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CED3C7503A
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
A couple of prints are difficult to convert with dev_err() so they are
converted to pr_err() at least.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/aw2/aw2-alsa.c    | 42 ++++++++++++++++++++----------------------
 sound/pci/aw2/aw2-saa7146.c |  6 ++----
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index e9dabee42805..120d0d320a60 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -262,7 +262,7 @@ static int snd_aw2_create(struct snd_card *card,
 	/* check PCI availability (32bit DMA) */
 	if ((pci_set_dma_mask(pci, DMA_BIT_MASK(32)) < 0) ||
 	    (pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32)) < 0)) {
-		printk(KERN_ERR "aw2: Impossible to set 32bit mask DMA\n");
+		dev_err(card->dev, "Impossible to set 32bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -290,7 +290,7 @@ static int snd_aw2_create(struct snd_card *card,
 				pci_resource_len(pci, 0));
 
 	if (chip->iobase_virt == NULL) {
-		printk(KERN_ERR "aw2: unable to remap memory region");
+		dev_err(card->dev, "unable to remap memory region");
 		pci_release_regions(pci);
 		pci_disable_device(pci);
 		kfree(chip);
@@ -302,7 +302,7 @@ static int snd_aw2_create(struct snd_card *card,
 
 	if (request_irq(pci->irq, snd_aw2_saa7146_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-		printk(KERN_ERR "aw2: Cannot grab irq %d\n", pci->irq);
+		dev_err(card->dev, "Cannot grab irq %d\n", pci->irq);
 
 		iounmap(chip->iobase_virt);
 		pci_release_regions(chip->pci);
@@ -324,9 +324,8 @@ static int snd_aw2_create(struct snd_card *card,
 
 	*rchip = chip;
 
-	printk(KERN_INFO
-	       "Audiowerk 2 sound card (saa7146 chipset) detected and "
-	       "managed\n");
+	dev_info(card->dev,
+		 "Audiowerk 2 sound card (saa7146 chipset) detected and managed\n");
 	return 0;
 }
 
@@ -399,7 +398,7 @@ static int snd_aw2_pcm_playback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	snd_printdd(KERN_DEBUG "aw2: Playback_open\n");
+	dev_dbg(substream->pcm->card->dev, "Playback_open\n");
 	runtime->hw = snd_aw2_playback_hw;
 	return 0;
 }
@@ -415,7 +414,7 @@ static int snd_aw2_pcm_capture_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	snd_printdd(KERN_DEBUG "aw2: Capture_open\n");
+	dev_dbg(substream->pcm->card->dev, "Capture_open\n");
 	runtime->hw = snd_aw2_capture_hw;
 	return 0;
 }
@@ -603,7 +602,7 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 	err = snd_pcm_new(chip->card, "Audiowerk2 analog playback", 0, 1, 0,
 			  &pcm_playback_ana);
 	if (err < 0) {
-		printk(KERN_ERR "aw2: snd_pcm_new error (0x%X)\n", err);
+		dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
 		return err;
 	}
 
@@ -633,14 +632,15 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 						    (chip->pci),
 						    64 * 1024, 64 * 1024);
 	if (err)
-		printk(KERN_ERR "aw2: snd_pcm_lib_preallocate_pages_for_all "
-		       "error (0x%X)\n", err);
+		dev_err(chip->card->dev,
+			"snd_pcm_lib_preallocate_pages_for_all error (0x%X)\n",
+			err);
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 digital playback", 1, 1, 0,
 			  &pcm_playback_num);
 
 	if (err < 0) {
-		printk(KERN_ERR "aw2: snd_pcm_new error (0x%X)\n", err);
+		dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
 		return err;
 	}
 	/* Creation ok */
@@ -669,17 +669,15 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 						    (chip->pci),
 						    64 * 1024, 64 * 1024);
 	if (err)
-		printk(KERN_ERR
-		       "aw2: snd_pcm_lib_preallocate_pages_for_all error "
-		       "(0x%X)\n", err);
-
-
+		dev_err(chip->card->dev,
+			"snd_pcm_lib_preallocate_pages_for_all error (0x%X)\n",
+			err);
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 capture", 2, 0, 1,
 			  &pcm_capture);
 
 	if (err < 0) {
-		printk(KERN_ERR "aw2: snd_pcm_new error (0x%X)\n", err);
+		dev_err(chip->card->dev, "snd_pcm_new error (0x%X)\n", err);
 		return err;
 	}
 
@@ -709,15 +707,15 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 						    (chip->pci),
 						    64 * 1024, 64 * 1024);
 	if (err)
-		printk(KERN_ERR
-		       "aw2: snd_pcm_lib_preallocate_pages_for_all error "
-		       "(0x%X)\n", err);
+		dev_err(chip->card->dev,
+			"snd_pcm_lib_preallocate_pages_for_all error (0x%X)\n",
+			err);
 
 
 	/* Create control */
 	err = snd_ctl_add(chip->card, snd_ctl_new1(&aw2_control, chip));
 	if (err < 0) {
-		printk(KERN_ERR "aw2: snd_ctl_add error (0x%X)\n", err);
+		dev_err(chip->card->dev, "snd_ctl_add error (0x%X)\n", err);
 		return err;
 	}
 
diff --git a/sound/pci/aw2/aw2-saa7146.c b/sound/pci/aw2/aw2-saa7146.c
index 4439636971eb..6d24e9536777 100644
--- a/sound/pci/aw2/aw2-saa7146.c
+++ b/sound/pci/aw2/aw2-saa7146.c
@@ -204,8 +204,7 @@ void snd_aw2_saa7146_pcm_init_playback(struct snd_aw2_saa7146 *chip,
 		/* Define upper limit for DMA access */
 		WRITEREG(dma_addr + buffer_size, ProtA1_out);
 	} else {
-		printk(KERN_ERR
-		       "aw2: snd_aw2_saa7146_pcm_init_playback: "
+		pr_err("aw2: snd_aw2_saa7146_pcm_init_playback: "
 		       "Substream number is not 0 or 1 -> not managed\n");
 	}
 }
@@ -251,8 +250,7 @@ void snd_aw2_saa7146_pcm_init_capture(struct snd_aw2_saa7146 *chip,
 		/* Define upper limit for DMA access  */
 		WRITEREG(dma_addr + buffer_size, ProtA1_in);
 	} else {
-		printk(KERN_ERR
-		       "aw2: snd_aw2_saa7146_pcm_init_capture: "
+		pr_err("aw2: snd_aw2_saa7146_pcm_init_capture: "
 		       "Substream number is not 0 -> not managed\n");
 	}
 }
-- 
1.9.0
