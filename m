From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: tegra: Use devm_ioremap_resource instead
	of open code
Date: Sun, 23 Aug 2015 23:32:14 +0800
Message-ID: <1440343934.18793.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id D54CE260421
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 17:32:20 +0200 (CEST)
Received: by pacti10 with SMTP id ti10so4609079pac.0
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 08:32:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Vaishali Thakkar <vthakkar1994@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use devm_ioremap_resource() to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/tegra/tegra20_das.c   | 23 ++++------------------
 sound/soc/tegra/tegra20_i2s.c   | 23 ++++------------------
 sound/soc/tegra/tegra20_spdif.c | 22 ++++-----------------
 sound/soc/tegra/tegra30_ahub.c  | 43 +++++++----------------------------------
 sound/soc/tegra/tegra30_i2s.c   | 23 ++++------------------
 5 files changed, 23 insertions(+), 111 deletions(-)

diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index f52600b..89add13 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -133,7 +133,7 @@ static const struct regmap_config tegra20_das_regmap_config = {
 
 static int tegra20_das_probe(struct platform_device *pdev)
 {
-	struct resource *res, *region;
+	struct resource *res;
 	void __iomem *regs;
 	int ret = 0;
 
@@ -149,24 +149,9 @@ static int tegra20_das_probe(struct platform_device *pdev)
 	das->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		ret = -ENODEV;
-		goto err;
-	}
-
-	region = devm_request_mem_region(&pdev->dev, res->start,
-					 resource_size(res), pdev->name);
-	if (!region) {
-		dev_err(&pdev->dev, "Memory region already claimed\n");
-		ret = -EBUSY;
-		goto err;
-	}
-
-	regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!regs) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
 		goto err;
 	}
 
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 05f1c6e..14106fa 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -339,7 +339,7 @@ static const struct regmap_config tegra20_i2s_regmap_config = {
 static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s;
-	struct resource *mem, *memregion;
+	struct resource *mem;
 	void __iomem *regs;
 	int ret;
 
@@ -362,24 +362,9 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		ret = -ENODEV;
-		goto err_clk_put;
-	}
-
-	memregion = devm_request_mem_region(&pdev->dev, mem->start,
-					    resource_size(mem), DRV_NAME);
-	if (!memregion) {
-		dev_err(&pdev->dev, "Memory region already claimed\n");
-		ret = -EBUSY;
-		goto err_clk_put;
-	}
-
-	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!regs) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
+	regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
 		goto err_clk_put;
 	}
 
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 0809b1e..a0c3640 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -265,7 +265,7 @@ static const struct regmap_config tegra20_spdif_regmap_config = {
 static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif;
-	struct resource *mem, *memregion, *dmareq;
+	struct resource *mem, *dmareq;
 	void __iomem *regs;
 	int ret;
 
@@ -285,10 +285,9 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		return -ENODEV;
-	}
+	regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmareq) {
@@ -296,19 +295,6 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	memregion = devm_request_mem_region(&pdev->dev, mem->start,
-					    resource_size(mem), DRV_NAME);
-	if (!memregion) {
-		dev_err(&pdev->dev, "Memory region already claimed\n");
-		return -EBUSY;
-	}
-
-	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!regs) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
-	}
-
 	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
 					    &tegra20_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 989b1e8..fef3b9a 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -521,7 +521,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	const struct tegra30_ahub_soc_data *soc_data;
 	struct reset_control *rst;
 	int i;
-	struct resource *res0, *res1, *region;
+	struct resource *res0, *res1;
 	void __iomem *regs_apbif, *regs_ahub;
 	int ret = 0;
 
@@ -584,26 +584,12 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	}
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res0) {
-		dev_err(&pdev->dev, "No apbif memory resource\n");
-		return -ENODEV;
-	}
+	regs_apbif = devm_ioremap_resource(&pdev->dev, res0);
+	if (IS_ERR(regs_apbif))
+		return PTR_ERR(regs_apbif);
 
-	region = devm_request_mem_region(&pdev->dev, res0->start,
-					 resource_size(res0), DRV_NAME);
-	if (!region) {
-		dev_err(&pdev->dev, "request region apbif failed\n");
-		return -EBUSY;
-	}
 	ahub->apbif_addr = res0->start;
 
-	regs_apbif = devm_ioremap(&pdev->dev, res0->start,
-				  resource_size(res0));
-	if (!regs_apbif) {
-		dev_err(&pdev->dev, "ioremap apbif failed\n");
-		return -ENOMEM;
-	}
-
 	ahub->regmap_apbif = devm_regmap_init_mmio(&pdev->dev, regs_apbif,
 					&tegra30_ahub_apbif_regmap_config);
 	if (IS_ERR(ahub->regmap_apbif)) {
@@ -614,24 +600,9 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	regcache_cache_only(ahub->regmap_apbif, true);
 
 	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res1) {
-		dev_err(&pdev->dev, "No ahub memory resource\n");
-		return -ENODEV;
-	}
-
-	region = devm_request_mem_region(&pdev->dev, res1->start,
-					 resource_size(res1), DRV_NAME);
-	if (!region) {
-		dev_err(&pdev->dev, "request region ahub failed\n");
-		return -EBUSY;
-	}
-
-	regs_ahub = devm_ioremap(&pdev->dev, res1->start,
-				 resource_size(res1));
-	if (!regs_ahub) {
-		dev_err(&pdev->dev, "ioremap ahub failed\n");
-		return -ENOMEM;
-	}
+	regs_ahub = devm_ioremap_resource(&pdev->dev, res1);
+	if (IS_ERR(regs_ahub))
+		return PTR_ERR(regs_ahub);
 
 	ahub->regmap_ahub = devm_regmap_init_mmio(&pdev->dev, regs_ahub,
 					&tegra30_ahub_ahub_regmap_config);
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index fe36375..8e55583 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -379,7 +379,7 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 	struct tegra30_i2s *i2s;
 	const struct of_device_id *match;
 	u32 cif_ids[2];
-	struct resource *mem, *memregion;
+	struct resource *mem;
 	void __iomem *regs;
 	int ret;
 
@@ -419,24 +419,9 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		ret = -ENODEV;
-		goto err_clk_put;
-	}
-
-	memregion = devm_request_mem_region(&pdev->dev, mem->start,
-					    resource_size(mem), DRV_NAME);
-	if (!memregion) {
-		dev_err(&pdev->dev, "Memory region already claimed\n");
-		ret = -EBUSY;
-		goto err_clk_put;
-	}
-
-	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!regs) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
+	regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
 		goto err_clk_put;
 	}
 
-- 
2.1.0
