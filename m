From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/24] ALSA: mips: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:27 +0100
Message-ID: <1392201340-27113-12-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F33AE26501D
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 87BCBAC89
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/au1x00.c     | 4 ++--
 sound/mips/hal2.c       | 3 +--
 sound/mips/sgio2audio.c | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 9ca8fd0c2201..a1d2e27bef56 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -599,8 +599,8 @@ static int au1000_ac97_probe(struct platform_device *pdev)
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
 
-	err = snd_card_create(-1, "AC97", THIS_MODULE,
-				sizeof(struct snd_au1000), &card);
+	err = snd_card_new(&pdev->dev, -1, "AC97", THIS_MODULE,
+			   sizeof(struct snd_au1000), &card);
 	if (err < 0)
 		goto out0;
 
diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 2b7f6e8bdd24..23441b9e6148 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -880,7 +880,7 @@ static int hal2_probe(struct platform_device *pdev)
 	struct snd_hal2 *chip;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pdev->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -889,7 +889,6 @@ static int hal2_probe(struct platform_device *pdev)
 		snd_card_free(card);
 		return err;
 	}
-	snd_card_set_dev(card, &pdev->dev);
 
 	err = hal2_pcm_create(chip);
 	if (err < 0) {
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index cfe99ae149fe..04bb06c03ec8 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -920,7 +920,7 @@ static int snd_sgio2audio_probe(struct platform_device *pdev)
 	struct snd_sgio2audio *chip;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pdev->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -929,7 +929,6 @@ static int snd_sgio2audio_probe(struct platform_device *pdev)
 		snd_card_free(card);
 		return err;
 	}
-	snd_card_set_dev(card, &pdev->dev);
 
 	err = snd_sgio2audio_new_pcm(chip);
 	if (err < 0) {
-- 
1.8.5.2
