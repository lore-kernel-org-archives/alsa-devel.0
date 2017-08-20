From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 09/12] ASoC: qcom: Remove unnecessary function call
Date: Sun, 20 Aug 2017 13:44:58 +0800
Message-ID: <1503207898-16378-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

First of all,the address of pdev->dev is assigned to card->dev,then
the function platform_set_drvdata copies the value the variable card
to pdev->dev.driver_data, but when calling snd_soc_register_card,the
function dev_set_drvdata(card->dev, card) will also do the same copy
operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/qcom/storm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index c5207af..a9fa972 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -99,7 +99,6 @@ static int storm_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = snd_soc_of_parse_card_name(card, "qcom,model");
 	if (ret) {
-- 
1.9.1
