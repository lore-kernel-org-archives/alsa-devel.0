From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v3 01/27] ASOC: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 18:56:02 +0800
Message-ID: <1514026562-32593-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: ysxie@foxmail.com, Yisheng Xie <xieyisheng1@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 sound/soc/au1x/ac97c.c                |  4 ++--
 sound/soc/au1x/i2sc.c                 |  4 ++--
 sound/soc/intel/atom/sst/sst_acpi.c   | 20 ++++++++++----------
 sound/soc/intel/boards/mfld_machine.c |  4 ++--
 sound/soc/sh/fsi.c                    |  4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 29a97d5..fb77f63 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -247,8 +247,8 @@ static int au1xac97c_drvprobe(struct platform_device *pdev)
 				     pdev->name))
 		return -EBUSY;
 
-	ctx->mmio = devm_ioremap_nocache(&pdev->dev, iores->start,
-					 resource_size(iores));
+	ctx->mmio = devm_ioremap(&pdev->dev, iores->start,
+				 resource_size(iores));
 	if (!ctx->mmio)
 		return -EBUSY;
 
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 450c842..ee1a078 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -247,8 +247,8 @@ static int au1xi2s_drvprobe(struct platform_device *pdev)
 				     pdev->name))
 		return -EBUSY;
 
-	ctx->mmio = devm_ioremap_nocache(&pdev->dev, iores->start,
-					 resource_size(iores));
+	ctx->mmio = devm_ioremap(&pdev->dev, iores->start,
+				 resource_size(iores));
 	if (!ctx->mmio)
 		return -EBUSY;
 
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 32d6e02..c94b19b 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -175,8 +175,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->iram_base = rsrc->start + ctx->pdata->res_info->iram_offset;
 	ctx->iram_end =  ctx->iram_base + ctx->pdata->res_info->iram_size - 1;
 	dev_info(ctx->dev, "IRAM base: %#x", ctx->iram_base);
-	ctx->iram = devm_ioremap_nocache(ctx->dev, ctx->iram_base,
-					 ctx->pdata->res_info->iram_size);
+	ctx->iram = devm_ioremap(ctx->dev, ctx->iram_base,
+				 ctx->pdata->res_info->iram_size);
 	if (!ctx->iram) {
 		dev_err(ctx->dev, "unable to map IRAM\n");
 		return -EIO;
@@ -185,8 +185,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->dram_base = rsrc->start + ctx->pdata->res_info->dram_offset;
 	ctx->dram_end = ctx->dram_base + ctx->pdata->res_info->dram_size - 1;
 	dev_info(ctx->dev, "DRAM base: %#x", ctx->dram_base);
-	ctx->dram = devm_ioremap_nocache(ctx->dev, ctx->dram_base,
-					 ctx->pdata->res_info->dram_size);
+	ctx->dram = devm_ioremap(ctx->dev, ctx->dram_base,
+				 ctx->pdata->res_info->dram_size);
 	if (!ctx->dram) {
 		dev_err(ctx->dev, "unable to map DRAM\n");
 		return -EIO;
@@ -194,8 +194,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 
 	ctx->shim_phy_add = rsrc->start + ctx->pdata->res_info->shim_offset;
 	dev_info(ctx->dev, "SHIM base: %#x", ctx->shim_phy_add);
-	ctx->shim = devm_ioremap_nocache(ctx->dev, ctx->shim_phy_add,
-					ctx->pdata->res_info->shim_size);
+	ctx->shim = devm_ioremap(ctx->dev, ctx->shim_phy_add,
+				 ctx->pdata->res_info->shim_size);
 	if (!ctx->shim) {
 		dev_err(ctx->dev, "unable to map SHIM\n");
 		return -EIO;
@@ -207,8 +207,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	/* Get mailbox addr */
 	ctx->mailbox_add = rsrc->start + ctx->pdata->res_info->mbox_offset;
 	dev_info(ctx->dev, "Mailbox base: %#x", ctx->mailbox_add);
-	ctx->mailbox = devm_ioremap_nocache(ctx->dev, ctx->mailbox_add,
-					    ctx->pdata->res_info->mbox_size);
+	ctx->mailbox = devm_ioremap(ctx->dev, ctx->mailbox_add,
+				    ctx->pdata->res_info->mbox_size);
 	if (!ctx->mailbox) {
 		dev_err(ctx->dev, "unable to map mailbox\n");
 		return -EIO;
@@ -226,8 +226,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->ddr_base = rsrc->start;
 	ctx->ddr_end = rsrc->end;
 	dev_info(ctx->dev, "DDR base: %#x", ctx->ddr_base);
-	ctx->ddr = devm_ioremap_nocache(ctx->dev, ctx->ddr_base,
-					resource_size(rsrc));
+	ctx->ddr = devm_ioremap(ctx->dev, ctx->ddr_base,
+				resource_size(rsrc));
 	if (!ctx->ddr) {
 		dev_err(ctx->dev, "unable to map DDR\n");
 		return -EIO;
diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acf..cee1caad 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -385,8 +385,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 		pr_err("no mem resource given\n");
 		return -ENODEV;
 	}
-	mc_drv_ctx->int_base = devm_ioremap_nocache(&pdev->dev, irq_mem->start,
-						    resource_size(irq_mem));
+	mc_drv_ctx->int_base = devm_ioremap(&pdev->dev, irq_mem->start,
+					    resource_size(irq_mem));
 	if (!mc_drv_ctx->int_base) {
 		pr_err("Mapping of cache failed\n");
 		return -ENOMEM;
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index c3aaf47..fe19aee 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1960,8 +1960,8 @@ static int fsi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->base = devm_ioremap_nocache(&pdev->dev,
-					    res->start, resource_size(res));
+	master->base = devm_ioremap(&pdev->dev,
+				    res->start, resource_size(res));
 	if (!master->base) {
 		dev_err(&pdev->dev, "Unable to ioremap FSI registers.\n");
 		return -ENXIO;
-- 
1.8.3.1
