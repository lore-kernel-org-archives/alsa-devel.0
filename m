From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 01/12] ASoC: s3c24xx_uda134x: Remove unnecessary function call
Date: Sun, 20 Aug 2017 13:21:35 +0800
Message-ID: <1503206495-14948-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

First of all,the address of pdev->dev is assigned to card->dev,then
the function platform_set_drvdata copies the value the variable card
to pdev->dev.driver_data, but when calling snd_soc_register_card,the
function dev_set_drvdata(card->dev, card) will also do the same copy
operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/samsung/s3c24xx_uda134x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 55538e3..758e46e 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -237,7 +237,6 @@ static int s3c24xx_uda134x_probe(struct platform_device *pdev)
 	mutex_init(&priv->clk_lock);
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-- 
1.9.1
