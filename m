From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 12/12] ASoC: ux500: Remove unnecessary function call
Date: Sun, 20 Aug 2017 14:01:10 +0800
Message-ID: <1503208870-4313-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

First of all,the address of pdev->dev is assigned to mop500_card.dev,
then the function platform_set_drvdata copies the value the variable
card to pdev->dev.driver_data,but when calling snd_soc_register_card,
the function dev_set_drvdata(card->dev, card) will also do the same
copy operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/ux500/mop500.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index ba9fc09..070a688 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -115,7 +115,6 @@ static int mop500_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
 		__func__, mop500_card.name);
-	platform_set_drvdata(pdev, &mop500_card);
 
 	snd_soc_card_set_drvdata(&mop500_card, NULL);
 
-- 
1.9.1
