From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Convert to
	devm_snd_soc_register_card" to the asoc tree
Date: Mon, 31 Aug 2015 16:12:12 +0100
Message-ID: <E1ZWQkm-0001kl-Cn@finisterre>
References: <1440926330.19424.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCF9726167D
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 17:12:38 +0200 (CEST)
In-Reply-To: <1440926330.19424.4.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Convert to devm_snd_soc_register_card

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 887e83e32d99e43798e9ac9a274ad4debebf03f7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 30 Aug 2015 17:18:50 +0800
Subject: [PATCH] ASoC: mediatek: Convert to devm_snd_soc_register_card

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173-max98090.c      | 11 +----------
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 4d44b58..72d66cb 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -169,21 +169,13 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
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
@@ -200,7 +192,6 @@ static struct platform_driver mt8173_max98090_driver = {
 #endif
 	},
 	.probe = mt8173_max98090_dev_probe,
-	.remove = mt8173_max98090_dev_remove,
 };
 
 module_platform_driver(mt8173_max98090_driver);
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 0940553..bff96e4 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -234,21 +234,13 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
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
@@ -265,7 +257,6 @@ static struct platform_driver mt8173_rt5650_rt5676_driver = {
 #endif
 	},
 	.probe = mt8173_rt5650_rt5676_dev_probe,
-	.remove = mt8173_rt5650_rt5676_dev_remove,
 };
 
 module_platform_driver(mt8173_rt5650_rt5676_driver);
-- 
2.5.0
