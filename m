From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: Remove unnecessary function call" to the asoc tree
Date: Mon, 21 Aug 2017 18:21:16 +0100
Message-ID: <E1djqO4-0004ff-9y@debutante>
References: <1503208870-4313-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503208870-4313-1-git-send-email-dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peng Donglin <dolinux.peng@gmail.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgPeng Donglin <dolinux.peng@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ux500: Remove unnecessary function call

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

>From c996b52df44b83d227d7664d2838ed1c6739c850 Mon Sep 17 00:00:00 2001
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 20 Aug 2017 14:01:10 +0800
Subject: [PATCH] ASoC: ux500: Remove unnecessary function call

First of all,the address of pdev->dev is assigned to mop500_card.dev,
then the function platform_set_drvdata copies the value the variable
card to pdev->dev.driver_data,but when calling snd_soc_register_card,
the function dev_set_drvdata(card->dev, card) will also do the same
copy operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/mop500.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index b50f68a439ce..9298580e4c2a 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -111,7 +111,6 @@ static int mop500_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
 		__func__, mop500_card.name);
-	platform_set_drvdata(pdev, &mop500_card);
 
 	snd_soc_card_set_drvdata(&mop500_card, NULL);
 
-- 
2.13.3
