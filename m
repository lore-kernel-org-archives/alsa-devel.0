From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 04/35] ASoC: Intel: Skylake: Unify firmware
	loading mechanism
Date: Thu, 22 Aug 2019 21:03:54 +0200
Message-ID: <20190822190425.23001-5-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63552F80391
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:48 +0200 (CEST)
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

There are certain operations we want to do before and after firmware
loading e.g.: disabling/ enabling power and clock gating. To make code
coherent, provide skl_init_fw as a unified way for loading dsp firmware.

In consequence, this change provides CNL load library support during fw
initialization which was previously missing.

skl_dsp_fw_ops already takes care of fw and library load customization.
New post-load additions in form of fw and hw config assignments make
this change even more welcome.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c      | 27 -----------------
 sound/soc/intel/skylake/cnl-sst-dsp.h  |  1 -
 sound/soc/intel/skylake/cnl-sst.c      | 19 ------------
 sound/soc/intel/skylake/skl-messages.c |  8 -----
 sound/soc/intel/skylake/skl-pcm.c      | 22 ++------------
 sound/soc/intel/skylake/skl-sst-dsp.c  |  1 +
 sound/soc/intel/skylake/skl-sst-dsp.h  |  2 --
 sound/soc/intel/skylake/skl-sst.c      | 41 ++++++++++++++++++++++----
 sound/soc/intel/skylake/skl.h          |  2 +-
 9 files changed, 40 insertions(+), 83 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 92a82e6b5fe6..5bece3a6d741 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -591,33 +591,6 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
 
-int bxt_sst_init_fw(struct device *dev, struct skl_dev *skl)
-{
-	int ret;
-	struct sst_dsp *sst = skl->dsp;
-
-	ret = sst->fw_ops.load_fw(sst);
-	if (ret < 0) {
-		dev_err(dev, "Load base fw failed: %x\n", ret);
-		return ret;
-	}
-
-	skl_dsp_init_core_state(sst);
-
-	if (skl->lib_count > 1) {
-		ret = sst->fw_ops.load_library(sst, skl->lib_info,
-						skl->lib_count);
-		if (ret < 0) {
-			dev_err(dev, "Load Library failed : %x\n", ret);
-			return ret;
-		}
-	}
-	skl->is_first_boot = false;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bxt_sst_init_fw);
-
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
 {
 
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
index 7bd4d2a8fdfa..50f4a53a607c 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.h
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -97,7 +97,6 @@ void cnl_ipc_free(struct sst_generic_ipc *ipc);
 int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		     const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		     struct skl_dev **dsp);
-int cnl_sst_init_fw(struct device *dev, struct skl_dev *skl);
 void cnl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
 
 #endif /*__CNL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 4f64f097e9ae..8984653d925d 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -453,25 +453,6 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(cnl_sst_dsp_init);
 
-int cnl_sst_init_fw(struct device *dev, struct skl_dev *skl)
-{
-	int ret;
-	struct sst_dsp *sst = skl->dsp;
-
-	ret = skl->dsp->fw_ops.load_fw(sst);
-	if (ret < 0) {
-		dev_err(dev, "load base fw failed: %d", ret);
-		return ret;
-	}
-
-	skl_dsp_init_core_state(sst);
-
-	skl->is_first_boot = false;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cnl_sst_init_fw);
-
 void cnl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl)
 {
 	if (skl->dsp->fw)
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index d28b4887de27..cc949904717e 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -173,7 +173,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
-		.init_fw = skl_sst_init_fw,
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
@@ -181,7 +180,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
-		.init_fw = skl_sst_init_fw,
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
@@ -189,7 +187,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 2,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
-		.init_fw = bxt_sst_init_fw,
 		.cleanup = bxt_sst_dsp_cleanup
 	},
 	{
@@ -197,7 +194,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 2,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
-		.init_fw = bxt_sst_init_fw,
 		.cleanup = bxt_sst_dsp_cleanup
 	},
 	{
@@ -205,7 +201,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
@@ -213,7 +208,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
@@ -221,7 +215,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
@@ -229,7 +222,6 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
-		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 };
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 7f287424af9b..1dbab3eac0e5 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1408,7 +1408,6 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 {
 	struct hdac_bus *bus = dev_get_drvdata(component->dev);
 	struct skl_dev *skl = bus_to_skl(bus);
-	const struct skl_dsp_ops *ops;
 	int ret;
 
 	pm_runtime_get_sync(component->dev);
@@ -1424,25 +1423,10 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 			return ret;
 		}
 
-		/* load the firmwares, since all is set */
-		ops = skl_get_dsp_ops(skl->pci->device);
-		if (!ops)
-			return -EIO;
-
-		/*
-		 * Disable dynamic clock and power gating during firmware
-		 * and library download
-		 */
-		skl->enable_miscbdcge(component->dev, false);
-		skl->clock_power_gating(component->dev, false);
-
-		ret = ops->init_fw(component->dev, skl);
-		skl->enable_miscbdcge(component->dev, true);
-		skl->clock_power_gating(component->dev, true);
-		if (ret < 0) {
-			dev_err(component->dev, "Failed to boot first fw: %d\n", ret);
+		ret = skl_sst_init_fw(skl);
+		if (ret < 0)
 			return ret;
-		}
+
 		skl_populate_modules(skl);
 		skl->update_d0i3c = skl_update_d0i3c;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 225706d148d8..0eecf26986f9 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -44,6 +44,7 @@ void skl_dsp_init_core_state(struct sst_dsp *ctx)
 		skl->cores.usage_count[i] = 0;
 	}
 }
+EXPORT_SYMBOL_GPL(skl_dsp_init_core_state);
 
 /* Get the mask for all enabled cores */
 unsigned int skl_dsp_get_enabled_cores(struct sst_dsp *ctx)
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index cdfec0fca577..4da240582454 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -226,8 +226,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_dev **dsp);
-int skl_sst_init_fw(struct device *dev, struct skl_dev *skl);
-int bxt_sst_init_fw(struct device *dev, struct skl_dev *skl);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8af7546def1f..8a8ecb9a4fc6 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -555,30 +555,59 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
-int skl_sst_init_fw(struct device *dev, struct skl_dev *skl)
+int skl_sst_init_fw(struct skl_dev *skl)
 {
-	int ret;
 	struct sst_dsp *sst = skl->dsp;
+	struct device *dev = skl->dev;
+	int (*lp_check)(struct sst_dsp *dsp, bool state);
+	int ret;
+
+	lp_check = skl->ipc.ops.check_dsp_lp_on;
+	skl->enable_miscbdcge(dev, false);
+	skl->clock_power_gating(dev, false);
 
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
 		dev_err(dev, "Load base fw failed : %d\n", ret);
-		return ret;
+		goto exit;
+	}
+
+	if (!skl->is_first_boot)
+		goto library_load;
+	/* Disable power check during cfg setup */
+	skl->ipc.ops.check_dsp_lp_on = NULL;
+
+	ret = skl_ipc_fw_cfg_get(&skl->ipc, &skl->fw_cfg);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get fw cfg: %d\n", ret);
+		goto exit;
+	}
+
+	ret = skl_ipc_hw_cfg_get(&skl->ipc, &skl->hw_cfg);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get hw cfg: %d\n", ret);
+		goto exit;
 	}
 
 	skl_dsp_init_core_state(sst);
 
+library_load:
 	if (skl->lib_count > 1) {
 		ret = sst->fw_ops.load_library(sst, skl->lib_info,
 						skl->lib_count);
 		if (ret < 0) {
-			dev_err(dev, "Load Library failed : %x\n", ret);
-			return ret;
+			dev_err(dev, "Load library failed : %x\n", ret);
+			goto exit;
 		}
 	}
+
 	skl->is_first_boot = false;
+exit:
+	skl->ipc.ops.check_dsp_lp_on = lp_check;
+	skl->enable_miscbdcge(dev, true);
+	skl->clock_power_gating(dev, true);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_sst_init_fw);
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 972de5ddf2b7..1f86543fe954 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -161,7 +161,6 @@ struct skl_dsp_ops {
 			int irq, const char *fw_name,
 			struct skl_dsp_loader_ops loader_ops,
 			struct skl_dev **skl_sst);
-	int (*init_fw)(struct device *dev, struct skl_dev *skl);
 	void (*cleanup)(struct device *dev, struct skl_dev *skl);
 };
 
@@ -175,6 +174,7 @@ struct nhlt_specific_cfg *skl_get_ep_blob(struct skl_dev *skl, u32 instance,
 int skl_nhlt_update_topology_bin(struct skl_dev *skl);
 int skl_init_dsp(struct skl_dev *skl);
 int skl_free_dsp(struct skl_dev *skl);
+int skl_sst_init_fw(struct skl_dev *skl);
 int skl_suspend_late_dsp(struct skl_dev *skl);
 int skl_suspend_dsp(struct skl_dev *skl);
 int skl_resume_dsp(struct skl_dev *skl);
-- 
2.17.1
