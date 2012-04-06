From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: tegra: use devm_ APIs in SPDIF driver
Date: Fri,  6 Apr 2012 11:14:04 -0600
Message-ID: <1333732444-9872-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CE8F11041B1
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:14:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

The devm_ APIs remove the need to manually clean up allocations,
thus removing some code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is ordered after the header re-order/cleanup patch that I just
posted. This only affects context (well, actually just line numbers).

 sound/soc/tegra/tegra20_spdif.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 00a2d33..ef5d49e 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -245,11 +245,12 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	struct resource *mem, *memregion, *dmareq;
 	int ret;
 
-	spdif = kzalloc(sizeof(struct tegra20_spdif), GFP_KERNEL);
+	spdif = devm_kzalloc(&pdev->dev, sizeof(struct tegra20_spdif),
+			     GFP_KERNEL);
 	if (!spdif) {
 		dev_err(&pdev->dev, "Can't allocate tegra20_spdif\n");
 		ret = -ENOMEM;
-		goto exit;
+		goto err;
 	}
 	dev_set_drvdata(&pdev->dev, spdif);
 
@@ -257,7 +258,7 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(spdif->clk_spdif_out)) {
 		pr_err("Can't retrieve spdif clock\n");
 		ret = PTR_ERR(spdif->clk_spdif_out);
-		goto err_free;
+		goto err;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -274,19 +275,19 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 		goto err_clk_put;
 	}
 
-	memregion = request_mem_region(mem->start, resource_size(mem),
-					DRV_NAME);
+	memregion = devm_request_mem_region(&pdev->dev, mem->start,
+					    resource_size(mem), DRV_NAME);
 	if (!memregion) {
 		dev_err(&pdev->dev, "Memory region already claimed\n");
 		ret = -EBUSY;
 		goto err_clk_put;
 	}
 
-	spdif->regs = ioremap(mem->start, resource_size(mem));
+	spdif->regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 	if (!spdif->regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err_release;
+		goto err_clk_put;
 	}
 
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
@@ -298,7 +299,7 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
-		goto err_unmap;
+		goto err_clk_put;
 	}
 
 	ret = tegra_pcm_platform_register(&pdev->dev);
@@ -313,37 +314,23 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 
 err_unregister_dai:
 	snd_soc_unregister_dai(&pdev->dev);
-err_unmap:
-	iounmap(spdif->regs);
-err_release:
-	release_mem_region(mem->start, resource_size(mem));
 err_clk_put:
 	clk_put(spdif->clk_spdif_out);
-err_free:
-	kfree(spdif);
-exit:
+err:
 	return ret;
 }
 
 static int __devexit tegra20_spdif_platform_remove(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif = dev_get_drvdata(&pdev->dev);
-	struct resource *res;
 
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 
 	tegra20_spdif_debug_remove(spdif);
 
-	iounmap(spdif->regs);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	clk_put(spdif->clk_spdif_out);
 
-	kfree(spdif);
-
 	return 0;
 }
 
-- 
1.7.0.4
