From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: fm801: Use common error handling
 code in two functions
Date: Wed, 15 Nov 2017 13:47:45 +0100
Message-ID: <8dd7d1f7-4174-3fe3-2a76-6c84fb1de375@users.sourceforge.net>
References: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id F03FB266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 13:48:05 +0100 (CET)
In-Reply-To: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 13:27:57 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/fm801.c | 77 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 3648af4581a0..e4c0fa8db5f6 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1245,8 +1245,8 @@ static int snd_fm801_create(struct snd_card *card,
 		if (devm_request_irq(&pci->dev, pci->irq, snd_fm801_interrupt,
 				IRQF_SHARED, KBUILD_MODNAME, chip)) {
 			dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-			snd_fm801_free(chip);
-			return -EBUSY;
+			err = -EBUSY;
+			goto free_sound_chip;
 		}
 		chip->irq = pci->irq;
 		pci_set_master(pci);
@@ -1255,17 +1255,14 @@ static int snd_fm801_create(struct snd_card *card,
 	snd_fm801_chip_init(chip);
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_fm801_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 #ifdef CONFIG_SND_FM801_TEA575X_BOOL
 	err = v4l2_device_register(&pci->dev, &chip->v4l2_dev);
-	if (err < 0) {
-		snd_fm801_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
+
 	chip->tea.v4l2_dev = &chip->v4l2_dev;
 	chip->tea.radio_nr = radio_nr;
 	chip->tea.private_data = chip;
@@ -1275,8 +1272,8 @@ static int snd_fm801_create(struct snd_card *card,
 	    (chip->tea575x_tuner & TUNER_TYPE_MASK) < 4) {
 		if (snd_tea575x_init(&chip->tea, THIS_MODULE)) {
 			dev_err(card->dev, "TEA575x radio not found\n");
-			snd_fm801_free(chip);
-			return -ENODEV;
+			err = -ENODEV;
+			goto free_sound_chip;
 		}
 	} else if ((chip->tea575x_tuner & TUNER_TYPE_MASK) == 0) {
 		unsigned int tuner_only = chip->tea575x_tuner & TUNER_ONLY;
@@ -1306,6 +1303,10 @@ static int snd_fm801_create(struct snd_card *card,
 
 	*rchip = chip;
 	return 0;
+
+free_sound_chip:
+	snd_fm801_free(chip);
+	return err;
 }
 
 static int snd_card_fm801_probe(struct pci_dev *pci,
@@ -1331,10 +1332,9 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 
 	err = snd_fm801_create(card, pci, tea575x_tuner[dev], radio_nr[dev],
 			       &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	strcpy(card->driver, "FM801");
@@ -1347,45 +1347,42 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 		goto __fm801_tuner_only;
 
 	err = snd_fm801_pcm(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_fm801_mixer(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_mpu401_uart_new(card, 0, MPU401_HW_FM801,
 				  chip->port + FM801_MPU401_DATA,
 				  MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
 				  -1, &chip->rmidi);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_opl3_create(card, chip->port + FM801_OPL3_BANK0,
 			      chip->port + FM801_OPL3_BANK1,
 			      OPL3_HW_OPL3_FM801, 1, &opl3);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
       __fm801_tuner_only:
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
 
 static void snd_card_fm801_remove(struct pci_dev *pci)
-- 
2.15.0
