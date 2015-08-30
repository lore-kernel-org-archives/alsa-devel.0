From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/4] ASoC: mediatek: Convert to
	devm_snd_soc_register_card
Date: Sun, 30 Aug 2015 17:18:50 +0800
Message-ID: <1440926330.19424.4.camel@ingics.com>
References: <1440926161.19424.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id BC7AA260425
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 11:18:55 +0200 (CEST)
Received: by padhy3 with SMTP id hy3so1864689pad.0
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 02:18:55 -0700 (PDT)
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Koro Chen <koro.chen@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/mediatek/mt8173-max98090.c      | 11 +----------
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 684e8a7..71a1a35 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -179,21 +179,13 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 	}
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 	return ret;
 }
 
-static int mt8173_max98090_dev_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static const struct of_device_id mt8173_max98090_dt_match[] = {
 	{ .compatible = "mediatek,mt8173-max98090", },
 	{ }
@@ -209,7 +201,6 @@ static struct platform_driver mt8173_max98090_driver = {
 #endif
 	},
 	.probe = mt8173_max98090_dev_probe,
-	.remove = mt8173_max98090_dev_remove,
 };
 
 module_platform_driver(mt8173_max98090_driver);
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 86cf975..50ba538 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -246,21 +246,13 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 	return ret;
 }
 
-static int mt8173_rt5650_rt5676_dev_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static const struct of_device_id mt8173_rt5650_rt5676_dt_match[] = {
 	{ .compatible = "mediatek,mt8173-rt5650-rt5676", },
 	{ }
@@ -276,7 +268,6 @@ static struct platform_driver mt8173_rt5650_rt5676_driver = {
 #endif
 	},
 	.probe = mt8173_rt5650_rt5676_dev_probe,
-	.remove = mt8173_rt5650_rt5676_dev_remove,
 };
 
 module_platform_driver(mt8173_rt5650_rt5676_driver);
-- 
2.1.0
