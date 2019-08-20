From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Switch to devm for PCM register" to the asoc tree
Date: Tue, 20 Aug 2019 18:41:07 +0100 (BST)
Message-ID: <20190820174107.407F2274314F@ypsilon.sirena.org.uk>
References: <606d271187091e858e8c15e20555af0b79798fe1.1566242458.git-series.maxime.ripard@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <606d271187091e858e8c15e20555af0b79798fe1.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Switch to devm for PCM register

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From a49d24e7d8d4fd4edf59e6373983e0bf4a2cca15 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:09 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Switch to devm for PCM register

Since the introduction of the driver, a new managed helper for the
dmaengine PCM registration has been created. Let's use it to simplify a bit
our probe and remove functions.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/606d271187091e858e8c15e20555af0b79798fe1.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d97d694c48df..70608fa30bf2 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1154,7 +1154,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		goto err_suspend;
@@ -1183,8 +1183,6 @@ static int sun4i_i2s_remove(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_i2s_runtime_suspend(&pdev->dev);
-- 
2.20.1
