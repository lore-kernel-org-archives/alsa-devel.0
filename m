From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 6/6] ASoC: Intel: Skylake: Use the fw name
	from ACPI mach table
Date: Thu,  5 Nov 2015 21:34:15 +0530
Message-ID: <1446739455-22332-7-git-send-email-vinod.koul@intel.com>
References: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 74ABE266501
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:01:28 +0100 (CET)
In-Reply-To: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The firmware name is hard coded which doesnt allow to load
different platforms for various platforms so get this name from
available machine table and pass it to dsp context for loading

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h  | 3 ++-
 sound/soc/intel/skylake/skl-sst.c      | 5 +++--
 sound/soc/intel/skylake/skl.c          | 1 +
 sound/soc/intel/skylake/skl.h          | 2 ++
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index bfde60bb8119..d71b58322cc7 100644
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
index 6bfcef449bdc..f2a69d9e56b3 100644
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
index 5c5a244942ef..0c5039f2bd09 100644
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
index 59336cbc10dd..390f839d6168 100644
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
index 9b1beed26f0f..774c29cf84dc 100644
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
1.9.1
