From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 09/35] ASoC: Intel: Skylake: Unify driver
	cleanup mechanism
Date: Thu, 22 Aug 2019 21:03:59 +0200
Message-ID: <20190822190425.23001-10-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C343F803D5
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:55 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Driver cleanup process is similar for all platforms and sst_ops::free
provides enough customization already. Unify them. Also remove redundant
disable interrupt calls from new cleanup method. This is yet another
checkpoint in quest for simplification or, perhaps a removal of
skl_dsp_ops.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c      | 11 -----------
 sound/soc/intel/skylake/cnl-sst-dsp.h  |  1 -
 sound/soc/intel/skylake/cnl-sst.c      | 11 -----------
 sound/soc/intel/skylake/skl-messages.c | 10 +---------
 sound/soc/intel/skylake/skl-sst-dsp.h  |  2 --
 sound/soc/intel/skylake/skl-sst.c      | 20 ++++++++++++--------
 sound/soc/intel/skylake/skl.h          |  2 +-
 7 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 68f400cfb390..4e5fb7684415 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -592,16 +592,5 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
 
-void bxt_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
-{
-
-	skl_release_library(skl->lib_info, skl->lib_count);
-	if (skl->dsp->fw)
-		release_firmware(skl->dsp->fw);
-	skl_freeup_uuid_list(skl);
-	skl->dsp->ops->free(skl->dsp);
-}
-EXPORT_SYMBOL_GPL(bxt_sst_dsp_cleanup);
-
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Broxton IPC driver");
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
index b1417639bc1c..f3d320b05eb5 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.h
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -96,6 +96,5 @@ bool cnl_ipc_int_status(struct sst_dsp *ctx);
 int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		     const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		     struct skl_dev **dsp);
-void cnl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
 
 #endif /*__CNL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 76b23ea7802e..5143200579aa 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -464,16 +464,5 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(cnl_sst_dsp_init);
 
-void cnl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
-{
-	if (skl->dsp->fw)
-		release_firmware(skl->dsp->fw);
-
-	skl_freeup_uuid_list(skl);
-
-	skl->dsp->ops->free(skl->dsp);
-}
-EXPORT_SYMBOL_GPL(cnl_sst_dsp_cleanup);
-
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Cannonlake IPC driver");
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e4ac1ae777e0..8fd682872d0c 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -172,49 +172,41 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.id = 0x9d70,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
-		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
 		.id = 0x9d71,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
-		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
 		.id = 0x5a98,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
-		.cleanup = bxt_sst_dsp_cleanup
 	},
 	{
 		.id = 0x3198,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
-		.cleanup = bxt_sst_dsp_cleanup
 	},
 	{
 		.id = 0x9dc8,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
 		.id = 0xa348,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
 		.id = 0x02c8,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
 		.id = 0x06c8,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.cleanup = cnl_sst_dsp_cleanup
 	},
 };
 
@@ -282,7 +274,7 @@ int skl_free_dsp(struct skl_dev *skl)
 	/* disable  ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
 
-	skl->dsp_ops->cleanup(bus->dev, skl);
+	skl_sst_dsp_cleanup(skl);
 
 	kfree(skl->hw_cfg.i2s_caps.ctrl_base_addr);
 	kfree(skl->cores.state);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 2129627e6255..21d376692503 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -226,8 +226,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_dev **dsp);
-void skl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
-void bxt_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
 int bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo,
 		int lib_count);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 72ab579ddd27..a7a285ea24e1 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -613,17 +613,21 @@ int skl_sst_init_fw(struct skl_dev *skl)
 }
 EXPORT_SYMBOL_GPL(skl_sst_init_fw);
 
-void skl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
+void skl_sst_dsp_cleanup(struct skl_dev *skl)
 {
+	struct sst_dsp *dsp = skl->dsp;
+
+	skl_release_library(skl->lib_info, skl->lib_count);
+	if (dsp->fw)
+		release_firmware(dsp->fw);
+	skl_clear_module_table(dsp);
 
-	if (skl->dsp->fw)
-		release_firmware(skl->dsp->fw);
-	skl_clear_module_table(skl->dsp);
 	skl_freeup_uuid_list(skl);
-	skl->dsp->ops->free(skl->dsp);
-	if (skl->boot_complete) {
-		skl->dsp->cl_dev.ops.cl_cleanup_controller(skl->dsp);
-		skl_cldma_int_disable(skl->dsp);
+	dsp->ops->free(dsp);
+
+	if (skl->boot_complete && dsp->cl_dev.bufsize) {
+		dsp->cl_dev.ops.cl_cleanup_controller(dsp);
+		skl_cldma_int_disable(dsp);
 	}
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_cleanup);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 71e69f52b7ab..62e2f2d450e4 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -160,7 +160,6 @@ struct skl_dsp_ops {
 			int irq, const char *fw_name,
 			struct skl_dsp_loader_ops loader_ops,
 			struct skl_dev **skl_sst);
-	void (*cleanup)(struct device *dev, struct skl_dev *skl);
 };
 
 int skl_platform_unregister(struct device *dev);
@@ -174,6 +173,7 @@ int skl_nhlt_update_topology_bin(struct skl_dev *skl);
 int skl_init_dsp(struct skl_dev *skl);
 int skl_free_dsp(struct skl_dev *skl);
 int skl_sst_init_fw(struct skl_dev *skl);
+void skl_sst_dsp_cleanup(struct skl_dev *skl);
 int skl_suspend_late_dsp(struct skl_dev *skl);
 int skl_suspend_dsp(struct skl_dev *skl);
 int skl_resume_dsp(struct skl_dev *skl);
-- 
2.17.1
