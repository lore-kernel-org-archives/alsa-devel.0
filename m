From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use the fw name from
	ACPI mach table" to the asoc tree
Date: Thu, 05 Nov 2015 16:29:35 +0000
Message-ID: <E1ZuNPr-0001Ip-Js@finisterre>
References: <1446739455-22332-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93B71260574
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:29:49 +0100 (CET)
In-Reply-To: <1446739455-22332-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use the fw name from ACPI mach table

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

>From 159f20f618da19b3ed8b055c8f2fce030ad342e3 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 5 Nov 2015 21:34:15 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use the fw name from ACPI mach table

The firmware name is hard coded which doesnt allow to load
different platforms for various platforms so get this name from
available machine table and pass it to dsp context for loading

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h  | 3 ++-
 sound/soc/intel/skylake/skl-sst.c      | 5 +++--
 sound/soc/intel/skylake/skl.c          | 1 +
 sound/soc/intel/skylake/skl.h          | 2 ++
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index bfde60b..d71b583 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -96,7 +96,7 @@ int skl_init_dsp(struct skl *skl)
 	}
 
 	ret = skl_sst_dsp_init(bus->dev, mmio_base, irq,
-			loader_ops, &skl->skl_sst);
+			skl->fw_name, loader_ops, &skl->skl_sst);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 6bfcef4..f2a69d9 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -139,7 +139,8 @@ void skl_dsp_free(struct sst_dsp *dsp);
 
 int skl_dsp_boot(struct sst_dsp *ctx);
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp);
+		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
+		struct skl_sst **dsp);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 5c5a244..0c5039f 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -77,7 +77,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 	init_waitqueue_head(&skl->boot_wait);
 
 	if (ctx->fw == NULL) {
-		ret = request_firmware(&ctx->fw, "dsp_fw_release.bin", ctx->dev);
+		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Request firmware failed %d\n", ret);
 			skl_dsp_disable_core(ctx);
@@ -223,7 +223,7 @@ static struct sst_dsp_device skl_dev = {
 };
 
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp)
+		const char *fw_name, struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp)
 {
 	struct skl_sst *skl;
 	struct sst_dsp *sst;
@@ -244,6 +244,7 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	sst = skl->dsp;
 
+	sst->fw_name = fw_name;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 59336cb..390f839 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -264,6 +264,7 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 		dev_err(bus->dev, "No matching machine driver found\n");
 		return -ENODEV;
 	}
+	skl->fw_name = mach->fw_filename;
 
 	pdev = platform_device_alloc(mach->drv_name, -1);
 	if (pdev == NULL) {
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 9b1beed..774c29c 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -68,6 +68,8 @@ struct skl {
 
 	struct skl_dsp_resource resource;
 	struct list_head ppl_list;
+
+	const char *fw_name;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.6.1
