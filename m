From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/6] ASoC: Intel: Skylake: Move sst common
	initialization to a helper function
Date: Fri, 21 Apr 2017 20:28:08 +0530
Message-ID: <1492786693-24167-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 71251267115
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:11:16 +0200 (CEST)
In-Reply-To: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: G Kranthi <gudishax.kranthikumar@intel.com>

Some skl sst context are not dependent of platform and initializing them
independently for each platform can lead to errors. So optimize by
moving them to a helper function and platform specific init code can
call this.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c       | 28 +++++--------------------
 sound/soc/intel/skylake/skl-sst-dsp.h   |  3 +++
 sound/soc/intel/skylake/skl-sst-utils.c | 37 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst.c       | 32 ++++++----------------------
 4 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 600d95891996..c54f56c568e8 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -590,23 +590,14 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	struct sst_dsp *sst;
 	int ret;
 
-	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
-	if (skl == NULL)
-		return -ENOMEM;
-
-	skl->dev = dev;
-	skl_dev.thread_context = skl;
-	INIT_LIST_HEAD(&skl->uuid_list);
-
-	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
-	if (!skl->dsp) {
-		dev_err(skl->dev, "skl_dsp_ctx_init failed\n");
-		return -ENODEV;
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
+	if (ret < 0) {
+		dev_err(skl->dev, "%s: no device\n", __func__);
+		return ret;
 	}
 
+	skl = *dsp;
 	sst = skl->dsp;
-	sst->fw_name = fw_name;
-	sst->dsp_ops = dsp_ops;
 	sst->fw_ops = bxt_fw_ops;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
@@ -614,24 +605,15 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
-	INIT_LIST_HEAD(&sst->module_list);
-	ret = skl_ipc_init(dev, skl);
-	if (ret)
-		return ret;
-
 	/* set the D0i3 check */
 	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
 
 	skl->cores.count = 2;
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
-	skl->is_first_boot = true;
 	INIT_DELAYED_WORK(&skl->d0i3.work, bxt_set_dsp_D0i3);
 	skl->d0i3.state = SKL_DSP_D0I3_NONE;
 
-	if (dsp)
-		*dsp = skl;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 7229a12b4c94..c1f95e23933d 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -247,5 +247,8 @@ int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
 void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable);
+int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
+		struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp,
+		struct sst_dsp_device *skl_dev);
 
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 6d5bff04bf65..a72152123c3c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -361,3 +361,40 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw)
 
 	return 0;
 }
+
+int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
+	struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp,
+	struct sst_dsp_device *skl_dev)
+{
+	struct skl_sst *skl;
+	struct sst_dsp *sst;
+	int ret;
+
+	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
+	if (skl == NULL)
+		return -ENOMEM;
+
+	skl->dev = dev;
+	skl_dev->thread_context = skl;
+	INIT_LIST_HEAD(&skl->uuid_list);
+	skl->dsp = skl_dsp_ctx_init(dev, skl_dev, irq);
+	if (!skl->dsp) {
+		dev_err(skl->dev, "%s: no device\n", __func__);
+		return -ENODEV;
+	}
+
+	sst = skl->dsp;
+	sst->fw_name = fw_name;
+	sst->dsp_ops = dsp_ops;
+	init_waitqueue_head(&skl->mod_load_wait);
+	INIT_LIST_HEAD(&sst->module_list);
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
+	skl->is_first_boot = true;
+	if (dsp)
+		*dsp = skl;
+
+	return ret;
+}
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 539529729e3f..4fdd503a837c 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -330,7 +330,6 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 	int ret, bytes_left, curr_pos;
 	struct skl_sst *skl = ctx->thread_context;
 	skl->mod_load_complete = false;
-	init_waitqueue_head(&skl->mod_load_wait);
 
 	bytes_left = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, data, size, false);
 	if (bytes_left < 0)
@@ -489,43 +488,24 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	struct sst_dsp *sst;
 	int ret;
 
-	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
-	if (skl == NULL)
-		return -ENOMEM;
-
-	skl->dev = dev;
-	skl_dev.thread_context = skl;
-	INIT_LIST_HEAD(&skl->uuid_list);
-
-	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
-	if (!skl->dsp) {
-		dev_err(skl->dev, "%s: no device\n", __func__);
-		return -ENODEV;
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
+	if (ret < 0) {
+		dev_err(dev, "%s: no device\n", __func__);
+		return ret;
 	}
 
+	skl = *dsp;
 	sst = skl->dsp;
-
-	sst->fw_name = fw_name;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
-	INIT_LIST_HEAD(&sst->module_list);
-	sst->dsp_ops = dsp_ops;
 	sst->fw_ops = skl_fw_ops;
 
-	ret = skl_ipc_init(dev, skl);
-	if (ret)
-		return ret;
-
 	skl->cores.count = 2;
-	skl->is_first_boot = true;
-
-	if (dsp)
-		*dsp = skl;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
-- 
1.9.1
