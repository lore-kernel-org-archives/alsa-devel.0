From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: ac97c: Handle return value of clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:16:46 +0100
Message-ID: <E1daN7G-0003RB-2f@debutante>
References: <1500977737-28056-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977737-28056-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.combroonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.

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

>From 260ea95cc027500ee5086e2ef568b8c915e66fb5 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:45:37 +0530
Subject: [PATCH] ASoC: atmel: ac97c: Handle return value of
 clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/atmel/ac97c.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 9d2c9d9af688..52b0522fda20 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -783,7 +783,9 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
 		return PTR_ERR(pclk);
 	}
-	clk_prepare_enable(pclk);
+	retval = clk_prepare_enable(pclk);
+	if (retval)
+		return retval;
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -897,9 +899,9 @@ static int atmel_ac97c_resume(struct device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct atmel_ac97c *chip = card->private_data;
+	int ret = clk_prepare_enable(chip->pclk);
 
-	clk_prepare_enable(chip->pclk);
-	return 0;
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_ac97c_pm, atmel_ac97c_suspend, atmel_ac97c_resume);
-- 
2.13.2
