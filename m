From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] ALSA: cs46xx: Use common error handling
 code in two functions
Date: Mon, 13 Nov 2017 19:23:31 +0100
Message-ID: <efe20785-da43-c1e4-fb38-038fe34b2bc6@users.sourceforge.net>
References: <893b1dc2-d078-9ea6-4ad2-0e0327affddd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 414DF2673B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 19:23:42 +0100 (CET)
In-Reply-To: <893b1dc2-d078-9ea6-4ad2-0e0327affddd@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 18:53:11 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs46xx/cs46xx.c     | 64 ++++++++++++++++++-------------------------
 sound/pci/cs46xx/cs46xx_lib.c | 44 ++++++++++++++---------------
 2 files changed, 47 insertions(+), 61 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 520478a6e605..d42e7e282cab 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -95,54 +95,42 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 
 	err = snd_cs46xx_create(card, pci, external_amp[dev],
 				thinkpad[dev], &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 	chip->accept_valid = mmap_valid[dev];
 	err = snd_cs46xx_pcm(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	err = snd_cs46xx_pcm_rear(chip, 1);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_cs46xx_pcm_iec958(chip, 2);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 #endif
 	err = snd_cs46xx_mixer(chip, 2);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	if (chip->nr_ac97_codecs ==2) {
 		err = snd_cs46xx_pcm_center_lfe(chip, 3);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
 #endif
 	err = snd_cs46xx_midi(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	err = snd_cs46xx_start_dsp(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
+	err = snd_cs46xx_start_dsp(chip);
+	if (err < 0)
+		goto free_card;
 
 	snd_cs46xx_gameport(chip);
 
@@ -155,14 +143,16 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 		chip->irq);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_card_cs46xx_remove(struct pci_dev *pci)
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 164f86949b2d..27b568f350f6 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3937,8 +3937,7 @@ int snd_cs46xx_create(struct snd_card *card,
 		dev_err(chip->card->dev,
 			"wrong address(es) - ba0 = 0x%lx, ba1 = 0x%lx\n",
 			   chip->ba0_addr, chip->ba1_addr);
-	    	snd_cs46xx_free(chip);
-	    	return -ENOMEM;
+		goto e_nomem;
 	}
 
 	region = &chip->region.name.ba0;
@@ -4016,59 +4015,56 @@ int snd_cs46xx_create(struct snd_card *card,
 			dev_err(chip->card->dev,
 				"unable to request memory region 0x%lx-0x%lx\n",
 				   region->base, region->base + region->size - 1);
-			snd_cs46xx_free(chip);
-			return -EBUSY;
+			err = -EBUSY;
+			goto free_sound_chip;
 		}
 		region->remap_addr = ioremap_nocache(region->base, region->size);
 		if (region->remap_addr == NULL) {
 			dev_err(chip->card->dev,
 				"%s ioremap problem\n", region->name);
-			snd_cs46xx_free(chip);
-			return -ENOMEM;
+			goto e_nomem;
 		}
 	}
 
 	if (request_irq(pci->irq, snd_cs46xx_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_cs46xx_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	chip->dsp_spos_instance = cs46xx_dsp_spos_create(chip);
-	if (chip->dsp_spos_instance == NULL) {
-		snd_cs46xx_free(chip);
-		return -ENOMEM;
-	}
+	if (!chip->dsp_spos_instance)
+		goto e_nomem;
 #endif
 
 	err = snd_cs46xx_chip_init(chip);
-	if (err < 0) {
-		snd_cs46xx_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_cs46xx_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 	
 	snd_cs46xx_proc_init(card, chip);
 
 #ifdef CONFIG_PM_SLEEP
 	chip->saved_regs = kmalloc(sizeof(*chip->saved_regs) *
 				   ARRAY_SIZE(saved_regs), GFP_KERNEL);
-	if (!chip->saved_regs) {
-		snd_cs46xx_free(chip);
-		return -ENOMEM;
-	}
+	if (!chip->saved_regs)
+		goto e_nomem;
 #endif
 
 	chip->active_ctrl(chip, -1); /* disable CLKRUN */
 
 	*rchip = chip;
 	return 0;
+
+e_nomem:
+	err = -ENOMEM;
+free_sound_chip:
+	snd_cs46xx_free(chip);
+	return err;
 }
-- 
2.15.0
