From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: add missing \n to end of dev_err/dev_dbg messages" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:09 -0700
Message-ID: <E1bo2S1-0002qR-2F@finisterre>
References: <20160916173731.13302-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160916173731.13302-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, trivial@kernel.org, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Sachin Mokashi <sachinx.mokashi@intel.com>, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: add missing \n to end of dev_err/dev_dbg messages

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

>From 1635c694124fe66933ae3db0d39dacb44c53f4b9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 16 Sep 2016 18:37:31 +0100
Subject: [PATCH] ASoC: Intel: atom: add missing \n to end of dev_err/dev_dbg
 messages

Trival fix, some dev_err/deb_dbg messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 773acfbaaf2f..9718e8249224 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -166,7 +166,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
 					ctx->pdata->res_info->acpi_lpe_res_index);
 	if (!rsrc) {
-		dev_err(ctx->dev, "Invalid SHIM base from IFWI");
+		dev_err(ctx->dev, "Invalid SHIM base from IFWI\n");
 		return -EIO;
 	}
 	dev_info(ctx->dev, "LPE base: %#x size:%#x", (unsigned int) rsrc->start,
@@ -178,7 +178,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->iram = devm_ioremap_nocache(ctx->dev, ctx->iram_base,
 					 ctx->pdata->res_info->iram_size);
 	if (!ctx->iram) {
-		dev_err(ctx->dev, "unable to map IRAM");
+		dev_err(ctx->dev, "unable to map IRAM\n");
 		return -EIO;
 	}
 
@@ -188,7 +188,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->dram = devm_ioremap_nocache(ctx->dev, ctx->dram_base,
 					 ctx->pdata->res_info->dram_size);
 	if (!ctx->dram) {
-		dev_err(ctx->dev, "unable to map DRAM");
+		dev_err(ctx->dev, "unable to map DRAM\n");
 		return -EIO;
 	}
 
@@ -197,7 +197,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->shim = devm_ioremap_nocache(ctx->dev, ctx->shim_phy_add,
 					ctx->pdata->res_info->shim_size);
 	if (!ctx->shim) {
-		dev_err(ctx->dev, "unable to map SHIM");
+		dev_err(ctx->dev, "unable to map SHIM\n");
 		return -EIO;
 	}
 
@@ -210,7 +210,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->mailbox = devm_ioremap_nocache(ctx->dev, ctx->mailbox_add,
 					    ctx->pdata->res_info->mbox_size);
 	if (!ctx->mailbox) {
-		dev_err(ctx->dev, "unable to map mailbox");
+		dev_err(ctx->dev, "unable to map mailbox\n");
 		return -EIO;
 	}
 
@@ -220,7 +220,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
 					ctx->pdata->res_info->acpi_ddr_index);
 	if (!rsrc) {
-		dev_err(ctx->dev, "Invalid DDR base from IFWI");
+		dev_err(ctx->dev, "Invalid DDR base from IFWI\n");
 		return -EIO;
 	}
 	ctx->ddr_base = rsrc->start;
@@ -229,7 +229,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	ctx->ddr = devm_ioremap_nocache(ctx->dev, ctx->ddr_base,
 					resource_size(rsrc));
 	if (!ctx->ddr) {
-		dev_err(ctx->dev, "unable to map DDR");
+		dev_err(ctx->dev, "unable to map DDR\n");
 		return -EIO;
 	}
 
@@ -296,7 +296,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
 		return -ENODEV;
-	dev_dbg(dev, "for %s", id->id);
+	dev_dbg(dev, "for %s\n", id->id);
 
 	mach = (struct sst_acpi_mach *)id->driver_data;
 	mach = sst_acpi_find_machine(mach);
-- 
2.9.3
