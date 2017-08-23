From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 02/10] ASoC: mediatek: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:18:38 -0700
Message-ID: <cebccee7e09dfc8b2abf7447367d222e8840a19c.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 5e383eb456a4..99c15219dbc8 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -222,7 +222,6 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 		mt8173_rt5650_rt5514_codecs[1].of_node;
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index fed1f15a39c2..42de84ca8c84 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -279,7 +279,6 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	}
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index a78470839b65..e69c141d8ed4 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -311,7 +311,6 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-- 
2.14.1
