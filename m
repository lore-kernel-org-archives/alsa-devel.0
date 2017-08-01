From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: fix wm8524 build error" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:55 +0100
Message-ID: <E1dcXyh-0008UA-IJ@debutante>
References: <20170731160713.3732735-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731160713.3732735-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mihai Serban <mihai.serban@nxp.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>Mihai Serban <mihai.serban@nxp.com>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: fix wm8524 build error

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

>From bf11ecb7eebd28d70bf5aa3170c6fe7156c33c5b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Jul 2017 18:05:46 +0200
Subject: [PATCH] ASoC: codecs: fix wm8524 build error

When CONFIG_OF is disabled, we run into a build error:

sound/soc/codecs/wm8524.c:257:21: error: 'wm8524_of_match' undeclared here (not in a function); did you mean 'wm8524_dai'?

This removes the unnecessary #ifdef around the match table.

Fixes: 007b6a54c305 ("ASoC: codecs: add wm8524 codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8524.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index f42ec664877c..e22b76d64e32 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -206,13 +206,11 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm8524 = {
 	},
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id wm8524_of_match[] = {
 	{ .compatible = "wlf,wm8524" },
 	{ /* sentinel*/ }
 };
 MODULE_DEVICE_TABLE(of, wm8524_of_match);
-#endif
 
 static int wm8524_codec_probe(struct platform_device *pdev)
 {
-- 
2.13.2
