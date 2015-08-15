From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: Convert to managed resources" to
	the asoc tree
Date: Fri, 14 Aug 2015 19:14:59 -0700
Message-ID: <E1ZQQzr-0004QO-Ai@finisterre>
References: <20150813072920.GA17181@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55B102664FE
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:15:06 +0200 (CEST)
In-Reply-To: <20150813072920.GA17181@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra: Convert to managed resources

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

>From 470805eb9f31be7b0b94cb8e0cbeb5910c47ce37 Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Thu, 13 Aug 2015 12:59:21 +0530
Subject: [PATCH] ASoC: tegra: Convert to managed resources

Use managed resource functions devm_clk_put and
devm_snd_soc_register_component to simplify error handling.

To be compatible with the change various gotos are replaced
with direct returns, and unneeded labels are dropped.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra20_spdif.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 9141477..a814da0 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -273,45 +273,40 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 			     GFP_KERNEL);
 	if (!spdif) {
 		dev_err(&pdev->dev, "Can't allocate tegra20_spdif\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 	dev_set_drvdata(&pdev->dev, spdif);
 
-	spdif->clk_spdif_out = clk_get(&pdev->dev, "spdif_out");
+	spdif->clk_spdif_out = devm_clk_get(&pdev->dev, "spdif_out");
 	if (IS_ERR(spdif->clk_spdif_out)) {
 		pr_err("Can't retrieve spdif clock\n");
 		ret = PTR_ERR(spdif->clk_spdif_out);
-		goto err;
+		return ret;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "No memory resource\n");
-		ret = -ENODEV;
-		goto err_clk_put;
+		return -ENODEV;
 	}
 
 	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmareq) {
 		dev_err(&pdev->dev, "No DMA resource\n");
-		ret = -ENODEV;
-		goto err_clk_put;
+		return -ENODEV;
 	}
 
 	memregion = devm_request_mem_region(&pdev->dev, mem->start,
 					    resource_size(mem), DRV_NAME);
 	if (!memregion) {
 		dev_err(&pdev->dev, "Memory region already claimed\n");
-		ret = -EBUSY;
-		goto err_clk_put;
+		return -EBUSY;
 	}
 
 	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 	if (!regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_clk_put;
+		return -ENOMEM;
 	}
 
 	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
@@ -319,7 +314,7 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(spdif->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		ret = PTR_ERR(spdif->regmap);
-		goto err_clk_put;
+		return ret;
 	}
 
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
@@ -334,8 +329,9 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = snd_soc_register_component(&pdev->dev, &tegra20_spdif_component,
-				   &tegra20_spdif_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &tegra20_spdif_component,
+					      &tegra20_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
@@ -345,21 +341,17 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	ret = tegra_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
-		goto err_unregister_component;
+		return ret;
 	}
 
 	return 0;
 
-err_unregister_component:
-	snd_soc_unregister_component(&pdev->dev);
 err_suspend:
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra20_spdif_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-err_clk_put:
-	clk_put(spdif->clk_spdif_out);
-err:
+
 	return ret;
 }
 
@@ -372,9 +364,6 @@ static int tegra20_spdif_platform_remove(struct platform_device *pdev)
 		tegra20_spdif_runtime_suspend(&pdev->dev);
 
 	tegra_pcm_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
-	clk_put(spdif->clk_spdif_out);
 
 	return 0;
 }
-- 
2.5.0
