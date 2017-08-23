From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 07/10] ASoC: qcom: Remove useless function call
Date: Wed, 23 Aug 2017 05:20:48 -0700
Message-ID: <08cc7ae7dc7bd4a2697de8b03711a7310a582b69.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/qcom/apq8016_sbc.c | 1 -
 sound/soc/qcom/storm.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d084d7468299..52925919267b 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -191,7 +191,6 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(data->spkr_iomux))
 		return PTR_ERR(data->spkr_iomux);
 
-	platform_set_drvdata(pdev, data);
 	snd_soc_card_set_drvdata(card, data);
 
 	return devm_snd_soc_register_card(&pdev->dev, card);
diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index c5207af14104..a9fa972466ad 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -99,7 +99,6 @@ static int storm_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = snd_soc_of_parse_card_name(card, "qcom,model");
 	if (ret) {
-- 
2.14.1
