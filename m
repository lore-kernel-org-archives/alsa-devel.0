From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/4] ASoC: blackfin: Convert to
	devm_snd_soc_register_card
Date: Sun, 30 Aug 2015 17:17:44 +0800
Message-ID: <1440926264.19424.3.camel@ingics.com>
References: <1440926161.19424.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id B03DA260417
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 11:17:48 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so106836065pac.2
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 02:17:47 -0700 (PDT)
In-Reply-To: <1440926161.19424.1.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, adi-buildroot-devel@lists.sourceforge.net, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/blackfin/bf5xx-ad1836.c       | 11 +----------
 sound/soc/blackfin/bfin-eval-adau1373.c | 12 +-----------
 sound/soc/blackfin/bfin-eval-adau1701.c | 12 +-----------
 sound/soc/blackfin/bfin-eval-adav80x.c  | 12 +-----------
 4 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 5bf1501..864df26 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -87,27 +87,18 @@ static int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to register card\n");
 	return ret;
 }
 
-static int bf5xx_ad1836_driver_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static struct platform_driver bf5xx_ad1836_driver = {
 	.driver = {
 		.name = "bfin-snd-ad1836",
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bf5xx_ad1836_driver_probe,
-	.remove = bf5xx_ad1836_driver_remove,
 };
 module_platform_driver(bf5xx_ad1836_driver);
 
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index 523baf5..72ac789 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -154,16 +154,7 @@ static int bfin_eval_adau1373_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	return snd_soc_register_card(&bfin_eval_adau1373);
-}
-
-static int bfin_eval_adau1373_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, &bfin_eval_adau1373);
 }
 
 static struct platform_driver bfin_eval_adau1373_driver = {
@@ -172,7 +163,6 @@ static struct platform_driver bfin_eval_adau1373_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adau1373_probe,
-	.remove = bfin_eval_adau1373_remove,
 };
 
 module_platform_driver(bfin_eval_adau1373_driver);
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
index f9e926d..5c67f72 100644
--- a/sound/soc/blackfin/bfin-eval-adau1701.c
+++ b/sound/soc/blackfin/bfin-eval-adau1701.c
@@ -94,16 +94,7 @@ static int bfin_eval_adau1701_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	return snd_soc_register_card(&bfin_eval_adau1701);
-}
-
-static int bfin_eval_adau1701_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, &bfin_eval_adau1701);
 }
 
 static struct platform_driver bfin_eval_adau1701_driver = {
@@ -112,7 +103,6 @@ static struct platform_driver bfin_eval_adau1701_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adau1701_probe,
-	.remove = bfin_eval_adau1701_remove,
 };
 
 module_platform_driver(bfin_eval_adau1701_driver);
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 27eee66..1037477 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -119,16 +119,7 @@ static int bfin_eval_adav80x_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	return snd_soc_register_card(&bfin_eval_adav80x);
-}
-
-static int bfin_eval_adav80x_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, &bfin_eval_adav80x);
 }
 
 static const struct platform_device_id bfin_eval_adav80x_ids[] = {
@@ -144,7 +135,6 @@ static struct platform_driver bfin_eval_adav80x_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adav80x_probe,
-	.remove = bfin_eval_adav80x_remove,
 	.id_table = bfin_eval_adav80x_ids,
 };
 
-- 
2.1.0
