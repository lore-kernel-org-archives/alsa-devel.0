From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: Use devm_clk_get" to the asoc
	tree
Date: Wed, 05 Aug 2015 14:02:47 +0100
Message-ID: <E1ZMyLH-0007Sy-AN@finisterre>
References: <20150803115734.GA32440@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4CAB2668B3
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 15:03:00 +0200 (CEST)
In-Reply-To: <20150803115734.GA32440@localhost>
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

   ASoC: tegra: Use devm_clk_get

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

>From 8833c01af6aa8e42fcbc74d76646ead05d0183a7 Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Mon, 3 Aug 2015 17:27:34 +0530
Subject: [PATCH] ASoC: tegra: Use devm_clk_get

This patch introduces the use of managed resource function
devm_clk_get instead of clk_get and removes corresponding calls
to clk_put in the probe and remove functions.

To be compatible with the change various gotos are replaced with
direct returns, and unneeded labels are dropped.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra30_ahub.c | 49 ++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index bc94e5d..989b1e8 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -549,54 +549,51 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Can't get reset %s\n",
 				configlink_mods[i].rst_name);
 			ret = PTR_ERR(rst);
-			goto err;
+			return ret;
 		}
 
 		ret = reset_control_deassert(rst);
 		reset_control_put(rst);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	ahub = devm_kzalloc(&pdev->dev, sizeof(struct tegra30_ahub),
 			    GFP_KERNEL);
 	if (!ahub) {
 		dev_err(&pdev->dev, "Can't allocate tegra30_ahub\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 	dev_set_drvdata(&pdev->dev, ahub);
 
 	ahub->soc_data = soc_data;
 	ahub->dev = &pdev->dev;
 
-	ahub->clk_d_audio = clk_get(&pdev->dev, "d_audio");
+	ahub->clk_d_audio = devm_clk_get(&pdev->dev, "d_audio");
 	if (IS_ERR(ahub->clk_d_audio)) {
 		dev_err(&pdev->dev, "Can't retrieve ahub d_audio clock\n");
 		ret = PTR_ERR(ahub->clk_d_audio);
-		goto err;
+		return ret;
 	}
 
-	ahub->clk_apbif = clk_get(&pdev->dev, "apbif");
+	ahub->clk_apbif = devm_clk_get(&pdev->dev, "apbif");
 	if (IS_ERR(ahub->clk_apbif)) {
 		dev_err(&pdev->dev, "Can't retrieve ahub apbif clock\n");
 		ret = PTR_ERR(ahub->clk_apbif);
-		goto err_clk_put_d_audio;
+		return ret;
 	}
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res0) {
 		dev_err(&pdev->dev, "No apbif memory resource\n");
-		ret = -ENODEV;
-		goto err_clk_put_apbif;
+		return -ENODEV;
 	}
 
 	region = devm_request_mem_region(&pdev->dev, res0->start,
 					 resource_size(res0), DRV_NAME);
 	if (!region) {
 		dev_err(&pdev->dev, "request region apbif failed\n");
-		ret = -EBUSY;
-		goto err_clk_put_apbif;
+		return -EBUSY;
 	}
 	ahub->apbif_addr = res0->start;
 
@@ -604,8 +601,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 				  resource_size(res0));
 	if (!regs_apbif) {
 		dev_err(&pdev->dev, "ioremap apbif failed\n");
-		ret = -ENOMEM;
-		goto err_clk_put_apbif;
+		return -ENOMEM;
 	}
 
 	ahub->regmap_apbif = devm_regmap_init_mmio(&pdev->dev, regs_apbif,
@@ -613,31 +609,28 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	if (IS_ERR(ahub->regmap_apbif)) {
 		dev_err(&pdev->dev, "apbif regmap init failed\n");
 		ret = PTR_ERR(ahub->regmap_apbif);
-		goto err_clk_put_apbif;
+		return ret;
 	}
 	regcache_cache_only(ahub->regmap_apbif, true);
 
 	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res1) {
 		dev_err(&pdev->dev, "No ahub memory resource\n");
-		ret = -ENODEV;
-		goto err_clk_put_apbif;
+		return -ENODEV;
 	}
 
 	region = devm_request_mem_region(&pdev->dev, res1->start,
 					 resource_size(res1), DRV_NAME);
 	if (!region) {
 		dev_err(&pdev->dev, "request region ahub failed\n");
-		ret = -EBUSY;
-		goto err_clk_put_apbif;
+		return -EBUSY;
 	}
 
 	regs_ahub = devm_ioremap(&pdev->dev, res1->start,
 				 resource_size(res1));
 	if (!regs_ahub) {
 		dev_err(&pdev->dev, "ioremap ahub failed\n");
-		ret = -ENOMEM;
-		goto err_clk_put_apbif;
+		return -ENOMEM;
 	}
 
 	ahub->regmap_ahub = devm_regmap_init_mmio(&pdev->dev, regs_ahub,
@@ -645,7 +638,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	if (IS_ERR(ahub->regmap_ahub)) {
 		dev_err(&pdev->dev, "ahub regmap init failed\n");
 		ret = PTR_ERR(ahub->regmap_ahub);
-		goto err_clk_put_apbif;
+		return ret;
 	}
 	regcache_cache_only(ahub->regmap_ahub, true);
 
@@ -662,12 +655,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-err_clk_put_apbif:
-	clk_put(ahub->clk_apbif);
-err_clk_put_d_audio:
-	clk_put(ahub->clk_d_audio);
-	ahub = NULL;
-err:
+
 	return ret;
 }
 
@@ -680,11 +668,6 @@ static int tegra30_ahub_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra30_ahub_runtime_suspend(&pdev->dev);
 
-	clk_put(ahub->clk_apbif);
-	clk_put(ahub->clk_d_audio);
-
-	ahub = NULL;
-
 	return 0;
 }
 
-- 
2.1.4
