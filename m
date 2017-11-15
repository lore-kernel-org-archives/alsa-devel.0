From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: intel8x0: Use common error handling
 code in two functions
Date: Wed, 15 Nov 2017 20:50:33 +0100
Message-ID: <0abfdb55-de9c-398e-772b-77c3c3b3f7f3@users.sourceforge.net>
References: <981b2716-2828-6478-46b3-5f8f3c36db46@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 78810267064
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 20:50:43 +0100 (CET)
In-Reply-To: <981b2716-2828-6478-46b3-5f8f3c36db46@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Laura Abbott <labbott@redhat.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 20:30:46 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/intel8x0.c | 74 +++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 2d7e0fb163f9..7d31012cdf90 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -3051,8 +3051,8 @@ static int snd_intel8x0_create(struct snd_card *card,
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	spin_lock_init(&chip->reg_lock);
 	chip->device_type = device_type;
@@ -3075,8 +3075,7 @@ static int snd_intel8x0_create(struct snd_card *card,
 	err = pci_request_regions(pci, card->shortname);
 	if (err < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 
 	if (device_type == DEVICE_ALI) {
@@ -3091,8 +3090,7 @@ static int snd_intel8x0_create(struct snd_card *card,
 		chip->addr = pci_iomap(pci, 0, 0);
 	if (!chip->addr) {
 		dev_err(card->dev, "AC'97 space ioremap problem\n");
-		snd_intel8x0_free(chip);
-		return -EIO;
+		goto e_io;
 	}
 	if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) /* ICH4 */
 		chip->bmaddr = pci_iomap(pci, 3, 0);
@@ -3102,8 +3100,7 @@ static int snd_intel8x0_create(struct snd_card *card,
  port_inited:
 	if (!chip->bmaddr) {
 		dev_err(card->dev, "Controller space ioremap problem\n");
-		snd_intel8x0_free(chip);
-		return -EIO;
+		goto e_io;
 	}
 	chip->bdbars_count = bdbars[device_type];
 
@@ -3143,9 +3140,9 @@ static int snd_intel8x0_create(struct snd_card *card,
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				chip->bdbars_count * sizeof(u32) * ICH_MAX_FRAGS * 2,
 				&chip->bdbars) < 0) {
-		snd_intel8x0_free(chip);
 		dev_err(card->dev, "cannot allocate buffer descriptors\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_sound_chip;
 	}
 	/* tables must be aligned to 8 bytes here, but the kernel pages
 	   are much bigger, so we don't care (on i386) */
@@ -3191,28 +3188,34 @@ static int snd_intel8x0_create(struct snd_card *card,
 		chip->codec_isr_bits |= chip->codec_bit[i];
 
 	err = snd_intel8x0_chip_init(chip, 1);
-	if (err < 0) {
-		snd_intel8x0_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	/* request irq after initializaing int_sta_mask, etc */
 	if (request_irq(pci->irq, snd_intel8x0_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_intel8x0_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_intel8x0_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	*r_intel8x0 = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_io:
+	err = -EIO;
+free_sound_chip:
+	snd_intel8x0_free(chip);
+	return err;
 }
 
 static struct shortname_table {
@@ -3314,22 +3317,18 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 	}
 
 	err = snd_intel8x0_create(card, pci, pci_id->driver_data, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	err = snd_intel8x0_mixer(chip, ac97_clock, ac97_quirk);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_intel8x0_pcm(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 	
 	snd_intel8x0_proc_init(chip);
 
@@ -3347,12 +3346,15 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 	}
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_intel8x0_remove(struct pci_dev *pci)
-- 
2.15.0
