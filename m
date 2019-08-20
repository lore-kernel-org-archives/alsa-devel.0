From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Register regmap and PCM before our component" to the asoc tree
Date: Tue, 20 Aug 2019 18:41:07 +0100 (BST)
Message-ID: <20190820174107.718392742B4A@ypsilon.sirena.org.uk>
References: <67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Register regmap and PCM before our component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From bf283a05c09b58db83afbb1a8a3c6a684c56c1bb Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:08 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Register regmap and PCM before our component

So far the regmap and the dmaengine PCM are registered after our component
has been, which means that our driver isn't properly initialised by then.

Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 7fa5c61169db..85c3b2c8cd77 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1148,11 +1148,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not register DAI\n");
+		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
 		goto err_suspend;
 	}
 
@@ -1162,9 +1160,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &sun4i_i2s_component,
+					      &sun4i_i2s_dai, 1);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
+		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
 	}
 
-- 
2.20.1
