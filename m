From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 08/35] ASoC: Intel: Skylake: Inline ipc free
	operations
Date: Thu, 22 Aug 2019 21:03:58 +0200
Message-ID: <20190822190425.23001-9-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96C30F805E0
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:54 +0200 (CEST)
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

skl_ipc_free and its equivalents are simple wrappers. Let's inline them,
making room for cleanup mechanism unification.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     |  1 -
 sound/soc/intel/skylake/cnl-sst-dsp.c | 12 +++++-------
 sound/soc/intel/skylake/cnl-sst-dsp.h |  1 -
 sound/soc/intel/skylake/cnl-sst.c     |  1 -
 sound/soc/intel/skylake/skl-sst-dsp.c |  5 ++++-
 sound/soc/intel/skylake/skl-sst-ipc.c | 13 -------------
 sound/soc/intel/skylake/skl-sst-ipc.h |  1 -
 sound/soc/intel/skylake/skl-sst.c     |  1 -
 8 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index cc9507d4702b..68f400cfb390 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -599,7 +599,6 @@ void bxt_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
 	if (skl->dsp->fw)
 		release_firmware(skl->dsp->fw);
 	skl_freeup_uuid_list(skl);
-	skl_ipc_free(&skl->ipc);
 	skl->dsp->ops->free(skl->dsp);
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_cleanup);
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.c b/sound/soc/intel/skylake/cnl-sst-dsp.c
index 3ef1b194add1..189c1c7086e3 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.c
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.c
@@ -14,9 +14,9 @@
  */
 #include <linux/device.h>
 #include "../common/sst-dsp.h"
-#include "../common/sst-ipc.h"
 #include "../common/sst-dsp-priv.h"
 #include "cnl-sst-dsp.h"
+#include "skl.h"
 
 /* various timeout values */
 #define CNL_DSP_PU_TO		50
@@ -209,10 +209,13 @@ irqreturn_t cnl_dsp_sst_interrupt(int irq, void *dev_id)
 
 void cnl_dsp_free(struct sst_dsp *dsp)
 {
+	struct skl_dev *skl = dsp->thread_context;
+
+	cnl_ipc_op_int_disable(dsp);
+	sst_ipc_fini(&skl->ipc);
 	cnl_ipc_int_disable(dsp);
 
 	free_irq(dsp->irq, dsp);
-	cnl_ipc_op_int_disable(dsp);
 	cnl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
 }
 EXPORT_SYMBOL_GPL(cnl_dsp_free);
@@ -259,8 +262,3 @@ bool cnl_ipc_int_status(struct sst_dsp *ctx)
 							CNL_ADSPIS_IPC;
 }
 
-void cnl_ipc_free(struct sst_generic_ipc *ipc)
-{
-	cnl_ipc_op_int_disable(ipc->dsp);
-	sst_ipc_fini(ipc);
-}
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
index 50f4a53a607c..b1417639bc1c 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.h
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -92,7 +92,6 @@ void cnl_ipc_int_disable(struct sst_dsp *ctx);
 void cnl_ipc_op_int_enable(struct sst_dsp *ctx);
 void cnl_ipc_op_int_disable(struct sst_dsp *ctx);
 bool cnl_ipc_int_status(struct sst_dsp *ctx);
-void cnl_ipc_free(struct sst_generic_ipc *ipc);
 
 int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		     const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index a2b3bce631fc..76b23ea7802e 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -470,7 +470,6 @@ void cnl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
 		release_firmware(skl->dsp->fw);
 
 	skl_freeup_uuid_list(skl);
-	cnl_ipc_free(&skl->ipc);
 
 	skl->dsp->ops->free(skl->dsp);
 }
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 15acbe80711e..e0807db225f4 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -463,10 +463,13 @@ int skl_dsp_acquire_irq(struct sst_dsp *sst)
 
 void skl_dsp_free(struct sst_dsp *dsp)
 {
+	struct skl_dev *skl = dsp->thread_context;
+
+	skl_ipc_op_int_disable(dsp);
+	sst_ipc_fini(&skl->ipc);
 	skl_ipc_int_disable(dsp);
 
 	free_irq(dsp->irq, dsp);
-	skl_ipc_op_int_disable(dsp);
 	skl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_free);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 4875a518dd54..2700f882103d 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -620,19 +620,6 @@ int skl_ipc_init(struct device *dev, struct skl_dev *skl)
 	return 0;
 }
 
-void skl_ipc_free(struct sst_generic_ipc *ipc)
-{
-	/* Disable IPC DONE interrupt */
-	sst_dsp_shim_update_bits(ipc->dsp, SKL_ADSP_REG_HIPCCTL,
-		SKL_ADSP_REG_HIPCCTL_DONE, 0);
-
-	/* Disable IPC BUSY interrupt */
-	sst_dsp_shim_update_bits(ipc->dsp, SKL_ADSP_REG_HIPCCTL,
-		SKL_ADSP_REG_HIPCCTL_BUSY, 0);
-
-	sst_ipc_fini(ipc);
-}
-
 int skl_ipc_create_pipeline(struct sst_generic_ipc *ipc,
 		u16 ppl_mem_size, u8 ppl_type, u8 instance_id, u8 lp_mode)
 {
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index eefa52f7f97a..fb150e656379 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -275,7 +275,6 @@ void skl_ipc_op_int_disable(struct sst_dsp *ctx);
 void skl_ipc_int_disable(struct sst_dsp *dsp);
 
 bool skl_ipc_int_status(struct sst_dsp *dsp);
-void skl_ipc_free(struct sst_generic_ipc *ipc);
 int skl_ipc_init(struct device *dev, struct skl_dev *skl);
 void skl_clear_module_cnt(struct sst_dsp *ctx);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 163590682e1a..72ab579ddd27 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -620,7 +620,6 @@ void skl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
 		release_firmware(skl->dsp->fw);
 	skl_clear_module_table(skl->dsp);
 	skl_freeup_uuid_list(skl);
-	skl_ipc_free(&skl->ipc);
 	skl->dsp->ops->free(skl->dsp);
 	if (skl->boot_complete) {
 		skl->dsp->cl_dev.ops.cl_cleanup_controller(skl->dsp);
-- 
2.17.1
