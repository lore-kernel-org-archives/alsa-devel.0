From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: disable clock on error" to
	the asoc tree
Date: Wed, 06 Dec 2017 15:29:07 +0000
Message-ID: <E1eMbdD-0007Xa-97@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2677526704A
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 16:29:08 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: disable clock on error

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

>From c7b92172a61b91936be985cb9bc499a4ebc6489b Mon Sep 17 00:00:00 2001
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Date: Wed, 6 Dec 2017 16:03:24 +0100
Subject: [PATCH] ASoC: rockchip: disable clock on error

Disable the clocks in  rk_spdif_probe when an error occurs after one
of the clocks has been enabled previously.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: f874b80e1571 ASoC: rockchip: Add rockchip SPDIF transceiver driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index ee5055d47d13..a89fe9b6463b 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -322,26 +322,30 @@ static int rk_spdif_probe(struct platform_device *pdev)
 	spdif->mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(spdif->mclk)) {
 		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
-		return PTR_ERR(spdif->mclk);
+		ret = PTR_ERR(spdif->mclk);
+		goto err_disable_hclk;
 	}
 
 	ret = clk_prepare_enable(spdif->mclk);
 	if (ret) {
 		dev_err(spdif->dev, "clock enable failed %d\n", ret);
-		return ret;
+		goto err_disable_clocks;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err_disable_clocks;
+	}
 
 	spdif->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "hclk", regs,
 						  &rk_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
 		dev_err(&pdev->dev,
 			"Failed to initialise managed register map\n");
-		return PTR_ERR(spdif->regmap);
+		ret = PTR_ERR(spdif->regmap);
+		goto err_disable_clocks;
 	}
 
 	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
@@ -373,6 +377,10 @@ static int rk_spdif_probe(struct platform_device *pdev)
 
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
+err_disable_clocks:
+	clk_disable_unprepare(spdif->mclk);
+err_disable_hclk:
+	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
-- 
2.15.0
