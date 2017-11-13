From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: cs5530: Use common error handling code
 in snd_cs5530_create()
Date: Mon, 13 Nov 2017 20:40:20 +0100
Message-ID: <6acf9697-a5df-0cd4-6cac-1198980c943b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C59182673B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 20:40:30 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 20:33:07 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs5530.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 0a8cf94c4858..88f253489075 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -124,8 +124,8 @@ static int snd_cs5530_create(struct snd_card *card,
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	chip->card = card;
@@ -134,15 +134,14 @@ static int snd_cs5530_create(struct snd_card *card,
 	err = pci_request_regions(pci, "CS5530");
 	if (err < 0) {
 		kfree(chip); 
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	chip->pci_base = pci_resource_start(pci, 0);
 
 	mem = pci_ioremap_bar(pci, 0);
 	if (mem == NULL) {
-		snd_cs5530_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 
 	map = readw(mem + 0x18);
@@ -163,8 +162,7 @@ static int snd_cs5530_create(struct snd_card *card,
 		dev_info(card->dev, "XpressAudio at 0x%lx\n", sb_base);
 	else {
 		dev_err(card->dev, "Could not find XpressAudio!\n");
-		snd_cs5530_free(chip);
-		return -ENODEV;
+		goto e_nodev;
 	}
 
 	if (map & (1<<5))
@@ -183,8 +181,7 @@ static int snd_cs5530_create(struct snd_card *card,
 		dma16 = 7;
 	else {
 		dev_err(card->dev, "No 16bit DMA enabled\n");
-		snd_cs5530_free(chip);
-		return -ENODEV;
+		goto e_nodev;
 	}
 
 	if (dma8 & 0x01)
@@ -195,8 +192,7 @@ static int snd_cs5530_create(struct snd_card *card,
 		dma8 = 3;
 	else {
 		dev_err(card->dev, "No 8bit DMA enabled\n");
-		snd_cs5530_free(chip);
-		return -ENODEV;
+		goto e_nodev;
 	}
 
 	if (irq & 1)
@@ -209,8 +205,7 @@ static int snd_cs5530_create(struct snd_card *card,
 		irq = 10;
 	else {
 		dev_err(card->dev, "SoundBlaster IRQ not set\n");
-		snd_cs5530_free(chip);
-		return -ENODEV;
+		goto e_nodev;
 	}
 
 	dev_info(card->dev, "IRQ: %d DMA8: %d DMA16: %d\n", irq, dma8, dma16);
@@ -219,32 +214,37 @@ static int snd_cs5530_create(struct snd_card *card,
 						dma16, SB_HW_CS5530, &chip->sb);
 	if (err < 0) {
 		dev_err(card->dev, "Could not create SoundBlaster\n");
-		snd_cs5530_free(chip);
-		return err;
+		goto free_sound_chip;
 	}
 
 	err = snd_sb16dsp_pcm(chip->sb, 0);
 	if (err < 0) {
 		dev_err(card->dev, "Could not create PCM\n");
-		snd_cs5530_free(chip);
-		return err;
+		goto free_sound_chip;
 	}
 
 	err = snd_sbmixer_new(chip->sb);
 	if (err < 0) {
 		dev_err(card->dev, "Could not create Mixer\n");
-		snd_cs5530_free(chip);
-		return err;
+		goto free_sound_chip;
 	}
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_cs5530_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	*rchip = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_nodev:
+	err = -ENODEV;
+free_sound_chip:
+	snd_cs5530_free(chip);
+	return err;
 }
 
 static int snd_cs5530_probe(struct pci_dev *pci,
-- 
2.15.0
