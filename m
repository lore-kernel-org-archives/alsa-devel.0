From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: intel8x0m: Use common error handling
 code in two functions
Date: Wed, 15 Nov 2017 22:06:06 +0100
Message-ID: <8e16f76a-347a-c764-c7cd-955b52cc2817@users.sourceforge.net>
References: <fb982b27-f9b8-959b-9bb6-17f217aa3220@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 51896267587
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 22:06:43 +0100 (CET)
In-Reply-To: <fb982b27-f9b8-959b-9bb6-17f217aa3220@users.sourceforge.net>
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
Date: Wed, 15 Nov 2017 21:52:00 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/intel8x0m.c | 76 ++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index ab798533a6bc..3ff994996255 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1135,8 +1135,8 @@ static int snd_intel8x0m_create(struct snd_card *card,
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	spin_lock_init(&chip->reg_lock);
 	chip->device_type = device_type;
@@ -1147,8 +1147,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	err = pci_request_regions(pci, card->shortname);
 	if (err < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 
 	if (device_type == DEVICE_ALI) {
@@ -1163,8 +1162,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
 		chip->addr = pci_iomap(pci, 0, 0);
 	if (!chip->addr) {
 		dev_err(card->dev, "AC'97 space ioremap problem\n");
-		snd_intel8x0m_free(chip);
-		return -EIO;
+		goto e_io;
 	}
 	if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) /* ICH4 */
 		chip->bmaddr = pci_iomap(pci, 3, 0);
@@ -1172,16 +1170,15 @@ static int snd_intel8x0m_create(struct snd_card *card,
 		chip->bmaddr = pci_iomap(pci, 1, 0);
 	if (!chip->bmaddr) {
 		dev_err(card->dev, "Controller space ioremap problem\n");
-		snd_intel8x0m_free(chip);
-		return -EIO;
+		goto e_io;
 	}
 
  port_inited:
 	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_intel8x0m_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 	pci_set_master(pci);
@@ -1215,8 +1212,8 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				chip->bdbars_count * sizeof(u32) * ICH_MAX_FRAGS * 2,
 				&chip->bdbars) < 0) {
-		snd_intel8x0m_free(chip);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_sound_chip;
 	}
 	/* tables must be aligned to 8 bytes here, but the kernel pages
 	   are much bigger, so we don't care (on i386) */
@@ -1231,19 +1228,25 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	chip->int_sta_mask = int_sta_masks;
 
 	err = snd_intel8x0m_chip_init(chip, 1);
-	if (err < 0) {
-		snd_intel8x0m_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_intel8x0m_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	*r_intel8x0m = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_io:
+	err = -EIO;
+free_sound_chip:
+	snd_intel8x0m_free(chip);
+	return err;
 }
 
 static struct shortname_table {
@@ -1295,35 +1298,34 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	strcat(card->shortname," Modem");
 
 	err = snd_intel8x0m_create(card, pci, pci_id->driver_data, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	err = snd_intel8x0m_mixer(chip, ac97_clock);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_intel8x0m_pcm(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	
+	if (err < 0)
+		goto free_card;
+
 	snd_intel8x0m_proc_init(chip);
 
 	sprintf(card->longname, "%s at irq %i",
 		card->shortname, chip->irq);
 
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
 
 static void snd_intel8x0m_remove(struct pci_dev *pci)
-- 
2.15.0
