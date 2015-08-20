From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Remove redundant arndale_audio_remove" to the asoc tree
Date: Thu, 20 Aug 2015 11:34:07 -0700
Message-ID: <E1ZSUf9-0008Pp-HP@finisterre>
References: <20150820164115.GA19191@localhost>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150820164115.GA19191@localhost>
Sender: stable-owner@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Remove redundant arndale_audio_remove

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

>From 14a500fe1396934c6b3ed8f009459a4723da7862 Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Thu, 20 Aug 2015 22:11:15 +0530
Subject: [PATCH] ASoC: samsung: Remove redundant arndale_audio_remove

There is no use of snd_soc_unregister_card in remove function
as devm_snd_soc_register_card in probe function automatically
handles it. So, remove use of snd_soc_unregister_card and with
this change remove arndale_audio_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/samsung/arndale_rt5631.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index 8bf2e2c..9e371eb 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -116,15 +116,6 @@ static int arndale_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int arndale_audio_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static const struct of_device_id samsung_arndale_rt5631_of_match[] __maybe_unused = {
 	{ .compatible = "samsung,arndale-rt5631", },
 	{ .compatible = "samsung,arndale-alc5631", },
@@ -139,7 +130,6 @@ static struct platform_driver arndale_audio_driver = {
 		.of_match_table = of_match_ptr(samsung_arndale_rt5631_of_match),
 	},
 	.probe = arndale_audio_probe,
-	.remove = arndale_audio_remove,
 };
 
 module_platform_driver(arndale_audio_driver);
-- 
2.5.0
