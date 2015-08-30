From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/4] ASoC: au1x: Convert to
	devm_snd_soc_register_card
Date: Sun, 30 Aug 2015 17:16:01 +0800
Message-ID: <1440926161.19424.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 5405D260418
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 11:16:08 +0200 (CEST)
Received: by pabpg12 with SMTP id pg12so368058pab.3
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 02:16:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/au1x/db1000.c | 10 +---------
 sound/soc/au1x/db1200.c | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
index 452f404..e97c327 100644
--- a/sound/soc/au1x/db1000.c
+++ b/sound/soc/au1x/db1000.c
@@ -38,14 +38,7 @@ static int db1000_audio_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &db1000_ac97;
 	card->dev = &pdev->dev;
-	return snd_soc_register_card(card);
-}
-
-static int db1000_audio_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	snd_soc_unregister_card(card);
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 static struct platform_driver db1000_audio_driver = {
@@ -54,7 +47,6 @@ static struct platform_driver db1000_audio_driver = {
 		.pm	= &snd_soc_pm_ops,
 	},
 	.probe		= db1000_audio_probe,
-	.remove		= db1000_audio_remove,
 };
 
 module_platform_driver(db1000_audio_driver);
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 58c3164..638ca0b 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -174,14 +174,7 @@ static int db1200_audio_probe(struct platform_device *pdev)
 
 	card = db1200_cards[pid->driver_data];
 	card->dev = &pdev->dev;
-	return snd_soc_register_card(card);
-}
-
-static int db1200_audio_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	snd_soc_unregister_card(card);
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 static struct platform_driver db1200_audio_driver = {
@@ -191,7 +184,6 @@ static struct platform_driver db1200_audio_driver = {
 	},
 	.id_table	= db1200_pids,
 	.probe		= db1200_audio_probe,
-	.remove		= db1200_audio_remove,
 };
 
 module_platform_driver(db1200_audio_driver);
-- 
2.1.0
