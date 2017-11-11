From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: sgio2audio: Use common error
 handling code in two functions
Date: Sat, 11 Nov 2017 20:21:41 +0100
Message-ID: <7d824a50-4333-a0d5-6a64-3c28f87b12e0@users.sourceforge.net>
References: <eb375101-03bd-37bb-67ef-e261eeca206e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7505D266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 20:22:16 +0100 (CET)
In-Reply-To: <eb375101-03bd-37bb-67ef-e261eeca206e@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 19:56:07 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/mips/sgio2audio.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 71c942162c25..62715a01f507 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -893,18 +893,19 @@ static int snd_sgio2audio_create(struct snd_card *card,
 
 	/* initialize the AD1843 codec */
 	err = ad1843_init(&chip->ad1843);
-	if (err < 0) {
-		snd_sgio2audio_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_chip;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_sgio2audio_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_chip;
+
 	*rchip = chip;
 	return 0;
+
+free_chip:
+	snd_sgio2audio_free(chip);
+	return err;
 }
 
 static int snd_sgio2audio_probe(struct platform_device *pdev)
@@ -918,21 +919,16 @@ static int snd_sgio2audio_probe(struct platform_device *pdev)
 		return err;
 
 	err = snd_sgio2audio_create(card, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	err = snd_sgio2audio_new_pcm(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_sgio2audio_new_mixer(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "SGI O2 Audio");
 	strcpy(card->shortname, "SGI O2 Audio");
@@ -942,12 +938,15 @@ static int snd_sgio2audio_probe(struct platform_device *pdev)
 		MACEISA_AUDIO3_MERR_IRQ);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	platform_set_drvdata(pdev, card);
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static int snd_sgio2audio_remove(struct platform_device *pdev)
-- 
2.15.0
