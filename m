From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 10/10] ASoC: ux500: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:21:43 -0700
Message-ID: <32013b183a9bf0eeb22e98039324bd04df4276a7.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/ux500/mop500.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index ba9fc099cf67..070a6880980e 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -115,7 +115,6 @@ static int mop500_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
 		__func__, mop500_card.name);
-	platform_set_drvdata(pdev, &mop500_card);
 
 	snd_soc_card_set_drvdata(&mop500_card, NULL);
 
-- 
2.14.1
