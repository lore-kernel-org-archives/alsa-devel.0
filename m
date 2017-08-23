From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 01/10] ASoC: s3c24xx_uda134x: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:17:41 -0700
Message-ID: <0d466d509dc0490f82caf5f61de422ad03a95870.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/samsung/s3c24xx_uda134x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 55538e333cc8..758e46e8061e 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -237,7 +237,6 @@ static int s3c24xx_uda134x_probe(struct platform_device *pdev)
 	mutex_init(&priv->clk_lock);
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-- 
2.14.1
