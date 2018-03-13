From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: clkdev_drop usage depends on CONFIG_COMMON_CLK" to the asoc tree
Date: Tue, 13 Mar 2018 16:31:25 +0000 (GMT)
Message-ID: <20180313163125.96EFF44007C@finisterre.ee.mobilebroadband>
References: <20180313090755.030AA3FBD3@swsrvapps-01.diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313090755.030AA3FBD3@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: clkdev_drop usage depends on CONFIG_COMMON_CLK

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0f9d0e355d7c3fa5756313765a77961074017845 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 13 Mar 2018 09:07:54 +0000
Subject: [PATCH] ASoC: da7219: clkdev_drop usage depends on CONFIG_COMMON_CLK

Fixes: ASoC: da7219: Add common clock usage for providing DAI clks

clkdev_drop usage in the codec remove function should be dependent
on if CONFIG_COMMON_CLK is defined for the platform, otherwise it
can cause build failures for platforms that do not support this.
The clkdev_* functions are still defined for those platforms, in
headers and source but the functions are not linked in.

This patch resolves this issue, so clkdev_drop is only used if
CONFIG_COMMON_CLK is defined.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 441215997273..08f55d7a11ba 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1966,8 +1966,10 @@ static void da7219_remove(struct snd_soc_component *component)
 
 	da7219_aad_exit(component);
 
+#ifdef CONFIG_COMMON_CLK
 	if (da7219->dai_clks_lookup)
 		clkdev_drop(da7219->dai_clks_lookup);
+#endif
 
 	/* Supplies */
 	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
-- 
2.16.2
