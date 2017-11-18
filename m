From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: vx222: Use common error handling
 code in two functions
Date: Sat, 18 Nov 2017 21:40:55 +0100
Message-ID: <7d7de279-baaa-d41c-d5d3-af8eb3fc5948@users.sourceforge.net>
References: <e961ecef-9f03-0c2a-ad64-64102bbc1389@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CA7266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 21:41:02 +0100 (CET)
In-Reply-To: <e961ecef-9f03-0c2a-ad64-64102bbc1389@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 21:23:27 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/vx222/vx222.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 1f866a810a98..672b8f190777 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -163,10 +163,9 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	vx->pci = pci;
 
 	err = pci_request_regions(pci, CARD_NAME);
-	if (err < 0) {
-		snd_vx222_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
+
 	for (i = 0; i < 2; i++)
 		vx->port[i] = pci_resource_start(pci, i + 1);
 
@@ -174,19 +173,21 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 				 snd_vx_threaded_irq_handler, IRQF_SHARED,
 				 KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_vx222_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_vx222_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	*rchip = vx;
 	return 0;
+
+free_sound_chip:
+	snd_vx222_free(chip);
+	return err;
 }
 
 
@@ -225,10 +226,9 @@ static int snd_vx222_probe(struct pci_dev *pci,
 	}
 
 	err = snd_vx222_create(card, pci, hw, &vx);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = vx;
 	vx->core.ibl.size = ibl[dev];
 
@@ -242,20 +242,20 @@ static int snd_vx222_probe(struct pci_dev *pci,
 #endif
 
 	err = snd_vx_setup_firmware(&vx->core);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
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
 
 static void snd_vx222_remove(struct pci_dev *pci)
-- 
2.15.0
