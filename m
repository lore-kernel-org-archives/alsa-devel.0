From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/48] ALSA: fm801: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:18 +0100
Message-ID: <1393430030-26704-17-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 135DD2657A4
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A0CC375019
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
 sound/pci/fm801.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 8b6af212cbfe..db18ccabadd6 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -254,7 +254,7 @@ static void snd_fm801_codec_write(struct snd_ac97 *ac97,
 			goto ok1;
 		udelay(10);
 	}
-	snd_printk(KERN_ERR "AC'97 interface is busy (1)\n");
+	dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
 	return;
 
  ok1:
@@ -269,7 +269,7 @@ static void snd_fm801_codec_write(struct snd_ac97 *ac97,
 			return;
 		udelay(10);
 	}
-	snd_printk(KERN_ERR "AC'97 interface #%d is busy (2)\n", ac97->num);
+	dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n", ac97->num);
 }
 
 static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short reg)
@@ -285,7 +285,7 @@ static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short
 			goto ok1;
 		udelay(10);
 	}
-	snd_printk(KERN_ERR "AC'97 interface is busy (1)\n");
+	dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
 	return 0;
 
  ok1:
@@ -297,7 +297,7 @@ static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short
 			goto ok2;
 		udelay(10);
 	}
-	snd_printk(KERN_ERR "AC'97 interface #%d is busy (2)\n", ac97->num);
+	dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n", ac97->num);
 	return 0;
 
  ok2:
@@ -306,7 +306,7 @@ static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short
 			goto ok3;
 		udelay(10);
 	}
-	snd_printk(KERN_ERR "AC'97 interface #%d is not valid (2)\n", ac97->num);
+	dev_err(chip->card->dev, "AC'97 interface #%d is not valid (2)\n", ac97->num);
 	return 0;
 
  ok3:
@@ -1100,8 +1100,8 @@ static int snd_fm801_chip_init(struct fm801 *chip, int resume)
 
 	if (wait_for_codec(chip, 0, AC97_RESET, msecs_to_jiffies(750)) < 0)
 		if (!resume) {
-			snd_printk(KERN_INFO "Primary AC'97 codec not found, "
-					    "assume SF64-PCR (tuner-only)\n");
+			dev_info(chip->card->dev,
+				 "Primary AC'97 codec not found, assume SF64-PCR (tuner-only)\n");
 			chip->tea575x_tuner = 3 | TUNER_ONLY;
 			goto __ac97_ok;
 		}
@@ -1225,7 +1225,7 @@ static int snd_fm801_create(struct snd_card *card,
 	if ((tea575x_tuner & TUNER_ONLY) == 0) {
 		if (request_irq(pci->irq, snd_fm801_interrupt, IRQF_SHARED,
 				KBUILD_MODNAME, chip)) {
-			snd_printk(KERN_ERR "unable to grab IRQ %d\n", chip->irq);
+			dev_err(card->dev, "unable to grab IRQ %d\n", chip->irq);
 			snd_fm801_free(chip);
 			return -EBUSY;
 		}
@@ -1265,7 +1265,7 @@ static int snd_fm801_create(struct snd_card *card,
 	if ((tea575x_tuner & TUNER_TYPE_MASK) > 0 &&
 	    (tea575x_tuner & TUNER_TYPE_MASK) < 4) {
 		if (snd_tea575x_init(&chip->tea, THIS_MODULE)) {
-			snd_printk(KERN_ERR "TEA575x radio not found\n");
+			dev_err(card->dev, "TEA575x radio not found\n");
 			snd_fm801_free(chip);
 			return -ENODEV;
 		}
@@ -1274,13 +1274,14 @@ static int snd_fm801_create(struct snd_card *card,
 		for (tea575x_tuner = 1; tea575x_tuner <= 3; tea575x_tuner++) {
 			chip->tea575x_tuner = tea575x_tuner;
 			if (!snd_tea575x_init(&chip->tea, THIS_MODULE)) {
-				snd_printk(KERN_INFO "detected TEA575x radio type %s\n",
+				dev_info(card->dev,
+					 "detected TEA575x radio type %s\n",
 					   get_tea575x_gpio(chip)->name);
 				break;
 			}
 		}
 		if (tea575x_tuner == 4) {
-			snd_printk(KERN_ERR "TEA575x radio not found\n");
+			dev_err(card->dev, "TEA575x radio not found\n");
 			chip->tea575x_tuner = TUNER_DISABLED;
 		}
 	}
@@ -1410,8 +1411,7 @@ static int snd_fm801_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "fm801: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
-- 
1.9.0
