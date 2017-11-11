From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: ml403-ac97cr: Use common error
 handling code in two functions
Date: Sat, 11 Nov 2017 14:17:18 +0100
Message-ID: <c9e8516e-b5cb-97cf-e8b8-86ebdd1ca284@users.sourceforge.net>
References: <4c38a970-2407-3559-060d-501b8259b3fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B80266A73
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 14:17:54 +0100 (CET)
In-Reply-To: <4c38a970-2407-3559-060d-501b8259b3fc@users.sourceforge.net>
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
Date: Sat, 11 Nov 2017 13:50:24 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/drivers/ml403-ac97cr.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 18fd12996cf7..12a54bfde1a5 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1144,8 +1144,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
 			   "unable to remap memory region (%pR)\n",
 			   resource);
-		snd_ml403_ac97cr_free(ml403_ac97cr);
-		return -EBUSY;
+		goto e_busy;
 	}
 	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
 		   "remap controller memory region to "
@@ -1157,8 +1156,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
 			   "unable to grab IRQ %d\n",
 			   irq);
-		snd_ml403_ac97cr_free(ml403_ac97cr);
-		return -EBUSY;
+		goto e_busy;
 	}
 	ml403_ac97cr->irq = irq;
 	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
@@ -1170,8 +1168,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
 			   "unable to grab IRQ %d\n",
 			   irq);
-		snd_ml403_ac97cr_free(ml403_ac97cr);
-		return -EBUSY;
+		goto e_busy;
 	}
 	ml403_ac97cr->capture_irq = irq;
 	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
@@ -1179,20 +1176,23 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		   ml403_ac97cr->capture_irq);
 
 	err = snd_ml403_ac97cr_chip_init(ml403_ac97cr);
-	if (err < 0) {
-		snd_ml403_ac97cr_free(ml403_ac97cr);
-		return err;
-	}
+	if (err < 0)
+		goto free_data;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ml403_ac97cr, &ops);
 	if (err < 0) {
 		PDEBUG(INIT_FAILURE, "probe(): snd_device_new() failed!\n");
-		snd_ml403_ac97cr_free(ml403_ac97cr);
-		return err;
+		goto free_data;
 	}
 
 	*rml403_ac97cr = ml403_ac97cr;
 	return 0;
+
+e_busy:
+	err = -EBUSY;
+free_data:
+	snd_ml403_ac97cr_free(ml403_ac97cr);
+	return err;
 }
 
 static void snd_ml403_ac97cr_mixer_free(struct snd_ac97 *ac97)
@@ -1281,22 +1281,19 @@ static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 	err = snd_ml403_ac97cr_create(card, pfdev, &ml403_ac97cr);
 	if (err < 0) {
 		PDEBUG(INIT_FAILURE, "probe(): create failed!\n");
-		snd_card_free(card);
-		return err;
+		goto free_card;
 	}
 	PDEBUG(INIT_INFO, "probe(): create done\n");
 	card->private_data = ml403_ac97cr;
 	err = snd_ml403_ac97cr_mixer(ml403_ac97cr);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	PDEBUG(INIT_INFO, "probe(): mixer done\n");
 	err = snd_ml403_ac97cr_pcm(ml403_ac97cr, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	PDEBUG(INIT_INFO, "probe(): PCM done\n");
 	strcpy(card->driver, SND_ML403_AC97CR_DRIVER);
 	strcpy(card->shortname, "ML403 AC97 Controller Reference");
@@ -1306,13 +1303,16 @@ static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 		ml403_ac97cr->capture_irq, dev + 1);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	platform_set_drvdata(pfdev, card);
 	PDEBUG(INIT_INFO, "probe(): (done)\n");
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static int snd_ml403_ac97cr_remove(struct platform_device *pfdev)
-- 
2.15.0
