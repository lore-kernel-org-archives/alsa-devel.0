From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] fm801: move to pcim_* and devm_* functions
Date: Wed,  7 Jan 2015 01:40:17 +0200
Message-ID: <1420587617-28521-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi
 [195.197.172.116])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA272612D0
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 00:40:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

The managed functions allow to get ->probe() and ->remove() simplier.
This patch converts code to use managed functions.

While here remove the dead code and fix the value printed in error
message.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 sound/pci/fm801.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index dcda3c1..2708500 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1178,12 +1178,8 @@ static int snd_fm801_free(struct fm801 *chip)
 		v4l2_device_unregister(&chip->v4l2_dev);
 	}
 #endif
-	if (chip->irq >= 0)
-		free_irq(chip->irq, chip);
 	pci_release_regions(chip->pci);
-	pci_disable_device(chip->pci);
 
-	kfree(chip);
 	return 0;
 }
 
@@ -1206,28 +1202,23 @@ static int snd_fm801_create(struct snd_card *card,
 	};
 
 	*rchip = NULL;
-	if ((err = pci_enable_device(pci)) < 0)
+	if ((err = pcim_enable_device(pci)) < 0)
 		return err;
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		pci_disable_device(pci);
+	chip = devm_kzalloc(&pci->dev, sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL)
 		return -ENOMEM;
-	}
 	spin_lock_init(&chip->reg_lock);
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
 	chip->tea575x_tuner = tea575x_tuner;
-	if ((err = pci_request_regions(pci, "FM801")) < 0) {
-		kfree(chip);
-		pci_disable_device(pci);
+	if ((err = pci_request_regions(pci, "FM801")) < 0)
 		return err;
-	}
 	chip->port = pci_resource_start(pci, 0);
 	if ((tea575x_tuner & TUNER_ONLY) == 0) {
-		if (request_irq(pci->irq, snd_fm801_interrupt, IRQF_SHARED,
-				KBUILD_MODNAME, chip)) {
-			dev_err(card->dev, "unable to grab IRQ %d\n", chip->irq);
+		if (devm_request_irq(&pci->dev, pci->irq, snd_fm801_interrupt,
+				IRQF_SHARED, KBUILD_MODNAME, chip)) {
+			dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 			snd_fm801_free(chip);
 			return -EBUSY;
 		}
@@ -1242,12 +1233,6 @@ static int snd_fm801_create(struct snd_card *card,
 	/* init might set tuner access method */
 	tea575x_tuner = chip->tea575x_tuner;
 
-	if (chip->irq >= 0 && (tea575x_tuner & TUNER_ONLY)) {
-		pci_clear_master(pci);
-		free_irq(chip->irq, chip);
-		chip->irq = -1;
-	}
-
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_fm801_free(chip);
 		return err;
-- 
1.8.3.101.g727a46b
