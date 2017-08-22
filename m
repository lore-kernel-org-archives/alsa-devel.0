From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: via82xx: Use common error handling code
 in snd_via82xx_create()
Date: Tue, 22 Aug 2017 19:43:08 +0200
Message-ID: <2332472c-61d2-8c21-bf46-5c80745d6380@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 55761266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 19:43:47 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 19:37:26 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/via82xx_modem.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 55f79b2599e7..8659776887b2 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1110,8 +1110,8 @@ static int snd_via82xx_create(struct snd_card *card,
 		return err;
 
 	if ((chip = kzalloc(sizeof(*chip), GFP_KERNEL)) == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	spin_lock_init(&chip->reg_lock);
@@ -1121,30 +1121,27 @@ static int snd_via82xx_create(struct snd_card *card,
 
 	if ((err = pci_request_regions(pci, card->driver)) < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	chip->port = pci_resource_start(pci, 0);
 	if (request_irq(pci->irq, snd_via82xx_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_via82xx_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_chip;
 	}
 	chip->irq = pci->irq;
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
 		chip->ac97_clock = ac97_clock;
 	synchronize_irq(chip->irq);
 
-	if ((err = snd_via82xx_chip_init(chip)) < 0) {
-		snd_via82xx_free(chip);
-		return err;
-	}
+	err = snd_via82xx_chip_init(chip);
+	if (err < 0)
+		goto free_chip;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_via82xx_free(chip);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto free_chip;
 
 	/* The 8233 ac97 controller does not implement the master bit
 	 * in the pci command register. IMHO this is a violation of the PCI spec.
@@ -1153,6 +1150,14 @@ static int snd_via82xx_create(struct snd_card *card,
 
 	*r_via = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	goto exit;
+free_chip:
+	snd_via82xx_free(chip);
+exit:
+	return err;
 }
 
 
-- 
2.14.0
