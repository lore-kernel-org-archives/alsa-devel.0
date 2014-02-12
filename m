From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/24] ALSA: arm: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:24 +0100
Message-ID: <1392201340-27113-9-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E38DB265010
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80A08AC05
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
 sound/arm/aaci.c        | 6 ++----
 sound/arm/pxa2xx-ac97.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index c421fdb3c7a1..0e83a73efb16 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -899,8 +899,8 @@ static struct aaci *aaci_init_card(struct amba_device *dev)
 	struct snd_card *card;
 	int err;
 
-	err = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			      THIS_MODULE, sizeof(struct aaci), &card);
+	err = snd_card_new(&dev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			   THIS_MODULE, sizeof(struct aaci), &card);
 	if (err < 0)
 		return NULL;
 
@@ -1055,8 +1055,6 @@ static int aaci_probe(struct amba_device *dev,
 	if (ret)
 		goto out;
 
-	snd_card_set_dev(aaci->card, &dev->dev);
-
 	ret = snd_card_register(aaci->card);
 	if (ret == 0) {
 		dev_info(&dev->dev, "%s\n", aaci->card->longname);
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 9a2ac1e0f77a..3a10df6688ee 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -179,12 +179,11 @@ static int pxa2xx_ac97_probe(struct platform_device *dev)
 		goto err_dev;
 	}
 
-	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			      THIS_MODULE, 0, &card);
+	ret = snd_card_new(&dev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			   THIS_MODULE, 0, &card);
 	if (ret < 0)
 		goto err;
 
-	card->dev = &dev->dev;
 	strlcpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
 
 	ret = pxa2xx_pcm_new(card, &pxa2xx_ac97_pcm_client, &pxa2xx_ac97_pcm);
@@ -210,7 +209,6 @@ static int pxa2xx_ac97_probe(struct platform_device *dev)
 
 	if (pdata && pdata->codec_pdata[0])
 		snd_ac97_dev_add_pdata(ac97_bus->codec[0], pdata->codec_pdata[0]);
-	snd_card_set_dev(card, &dev->dev);
 	ret = snd_card_register(card);
 	if (ret == 0) {
 		platform_set_drvdata(dev, card);
-- 
1.8.5.2
