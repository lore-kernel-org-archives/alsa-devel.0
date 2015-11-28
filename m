From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/16] ASoC: Intel: Skylake: Add support for
	Loadable modules
Date: Sat, 28 Nov 2015 15:01:52 +0530
Message-ID: <1448703121-5831-8-git-send-email-vinod.koul@intel.com>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 893D026683A
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:32:49 +0100 (CET)
In-Reply-To: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

A module is loaded when the path consisting the module is opened.
The module binary is requested from filesystem and cached in
kernel memory for future use. This is downloaded to DSP using
Code Loader DMA

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c |  18 ++++
 sound/soc/intel/skylake/skl-sst-dsp.h  |  14 +++
 sound/soc/intel/skylake/skl-sst.c      | 175 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.c |  24 ++++-
 sound/soc/intel/skylake/skl-topology.h |   4 +
 5 files changed, 234 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 7770a7e4162f..6c0ed4dada4d 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -161,6 +161,24 @@ int skl_resume_dsp(struct skl *skl)
 	return ret;
 }
 
+int skl_load_modules(struct skl_sst *ctx, struct skl_module_cfg *mcfg)
+{
+	if (ctx->dsp->fw_ops.load_mod)
+		return ctx->dsp->fw_ops.load_mod(ctx->dsp,
+				mcfg->id.module_id, mcfg->guid);
+
+	return 0;
+}
+
+int skl_unload_modules(struct skl_sst *ctx, struct skl_module_cfg *mcfg)
+{
+	if (ctx->dsp->fw_ops.unload_mod)
+		return ctx->dsp->fw_ops.unload_mod(ctx->dsp,
+						mcfg->id.module_id);
+
+	return 0;
+}
+
 enum skl_bitdepth skl_get_bit_depth(int params)
 {
 	switch (params) {
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index f2a69d9e56b3..5d0947935e2b 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -114,6 +114,9 @@ struct skl_dsp_fw_ops {
 	int (*set_state_D0)(struct sst_dsp *ctx);
 	int (*set_state_D3)(struct sst_dsp *ctx);
 	unsigned int (*get_fw_errcode)(struct sst_dsp *ctx);
+	int (*load_mod)(struct sst_dsp *ctx, u16 mod_id, char *mod_name);
+	int (*unload_mod)(struct sst_dsp *ctx, u16 mod_id);
+
 };
 
 struct skl_dsp_loader_ops {
@@ -123,6 +126,17 @@ struct skl_dsp_loader_ops {
 		struct snd_dma_buffer *dmab);
 };
 
+struct skl_load_module_info {
+	u16 mod_id;
+	const struct firmware *fw;
+};
+
+struct skl_module_table {
+	struct skl_load_module_info *mod_info;
+	unsigned int usage_cnt;
+	struct list_head list;
+};
+
 void skl_cldma_process_intr(struct sst_dsp *ctx);
 void skl_cldma_int_disable(struct sst_dsp *ctx);
 int skl_cldma_prepare(struct sst_dsp *ctx);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index e1d34d5c3f9a..8cd5cdb21fd5 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -38,6 +38,8 @@
 #define SKL_INSTANCE_ID		0
 #define SKL_BASE_FW_MODULE_ID	0
 
+#define SKL_NUM_MODULES		1
+
 static bool skl_check_fw_status(struct sst_dsp *ctx, u32 status)
 {
 	u32 cur_sts;
@@ -202,11 +204,182 @@ static unsigned int skl_get_errorcode(struct sst_dsp *ctx)
 	 return sst_dsp_shim_read(ctx, SKL_ADSP_ERROR_CODE);
 }
 
+/*
+ * since get/set_module are called from DAPM context,
+ * we don't need lock for usage count
+ */
+static unsigned int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
+{
+	struct skl_module_table *module;
+
+	list_for_each_entry(module, &ctx->module_list, list) {
+		if (module->mod_info->mod_id == mod_id)
+			return ++module->usage_cnt;
+	}
+
+	return -EINVAL;
+}
+
+static unsigned int skl_put_module(struct sst_dsp *ctx, u16 mod_id)
+{
+	struct skl_module_table *module;
+
+	list_for_each_entry(module, &ctx->module_list, list) {
+		if (module->mod_info->mod_id == mod_id)
+			return --module->usage_cnt;
+	}
+
+	return -EINVAL;
+}
+
+static struct skl_module_table *skl_fill_module_table(struct sst_dsp *ctx,
+						char *mod_name, int mod_id)
+{
+	const struct firmware *fw;
+	struct skl_module_table *skl_module;
+	unsigned int size;
+	int ret;
+
+	ret = request_firmware(&fw, mod_name, ctx->dev);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Request Module %s failed :%d\n",
+							mod_name, ret);
+		return NULL;
+	}
+
+	skl_module = devm_kzalloc(ctx->dev, sizeof(*skl_module), GFP_KERNEL);
+	if (skl_module == NULL) {
+		release_firmware(fw);
+		return NULL;
+	}
+
+	size = sizeof(*skl_module->mod_info);
+	skl_module->mod_info = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
+	if (skl_module->mod_info == NULL) {
+		release_firmware(fw);
+		return NULL;
+	}
+
+	skl_module->mod_info->mod_id = mod_id;
+	skl_module->mod_info->fw = fw;
+	list_add(&skl_module->list, &ctx->module_list);
+
+	return skl_module;
+}
+
+/* get a module from it's unique ID */
+static struct skl_module_table *skl_module_get_from_id(
+			struct sst_dsp *ctx, u16 mod_id)
+{
+	struct skl_module_table *module;
+
+	if (list_empty(&ctx->module_list)) {
+		dev_err(ctx->dev, "Module list is empty\n");
+		return NULL;
+	}
+
+	list_for_each_entry(module, &ctx->module_list, list) {
+		if (module->mod_info->mod_id == mod_id)
+			return module;
+	}
+
+	return NULL;
+}
+
+static int skl_transfer_module(struct sst_dsp *ctx,
+			struct skl_load_module_info *module)
+{
+	int ret;
+	struct skl_sst *skl = ctx->thread_context;
+
+	ret = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, module->fw->data,
+							module->fw->size);
+	if (ret < 0)
+		return ret;
+
+	ret = skl_ipc_load_modules(&skl->ipc, SKL_NUM_MODULES,
+						(void *)&module->mod_id);
+	if (ret < 0)
+		dev_err(ctx->dev, "Failed to Load module: %d\n", ret);
+
+	ctx->cl_dev.ops.cl_stop_dma(ctx);
+
+	return ret;
+}
+
+static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, char *guid)
+{
+	struct skl_module_table *module_entry = NULL;
+	int ret = 0;
+	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
+
+	snprintf(mod_name, sizeof(mod_name), "%s%s%s",
+			"intel/dsp_fw_", guid, ".bin");
+
+	module_entry = skl_module_get_from_id(ctx, mod_id);
+	if (module_entry == NULL) {
+		module_entry = skl_fill_module_table(ctx, mod_name, mod_id);
+		if (module_entry == NULL) {
+			dev_err(ctx->dev, "Failed to Load module\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!module_entry->usage_cnt) {
+		ret = skl_transfer_module(ctx, module_entry->mod_info);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Failed to Load module\n");
+			return ret;
+		}
+	}
+
+	ret = skl_get_module(ctx, mod_id);
+
+	return ret;
+}
+
+static int skl_unload_module(struct sst_dsp *ctx, u16 mod_id)
+{
+	unsigned int usage_cnt;
+	struct skl_sst *skl = ctx->thread_context;
+	int ret = 0;
+
+	usage_cnt = skl_put_module(ctx, mod_id);
+	if (usage_cnt < 0) {
+		dev_err(ctx->dev, "Module bad usage cnt!:%d\n", usage_cnt);
+		return -EIO;
+	}
+	ret = skl_ipc_unload_modules(&skl->ipc,
+			SKL_NUM_MODULES, &mod_id);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to UnLoad module\n");
+		skl_get_module(ctx, mod_id);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void skl_clear_module_table(struct sst_dsp *ctx)
+{
+	struct skl_module_table *module, *tmp;
+
+	if (list_empty(&ctx->module_list))
+		return;
+
+	list_for_each_entry_safe(module, tmp, &ctx->module_list, list) {
+		list_del(&module->list);
+		release_firmware(module->mod_info->fw);
+	}
+}
+
 static struct skl_dsp_fw_ops skl_fw_ops = {
 	.set_state_D0 = skl_set_dsp_D0,
 	.set_state_D3 = skl_set_dsp_D3,
 	.load_fw = skl_load_base_firmware,
 	.get_fw_errcode = skl_get_errorcode,
+	.load_mod = skl_load_module,
+	.unload_mod = skl_unload_module,
 };
 
 static struct sst_ops skl_ops = {
@@ -251,6 +424,7 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
+	INIT_LIST_HEAD(&sst->module_list);
 	sst->dsp_ops = dsp_ops;
 	sst->fw_ops = skl_fw_ops;
 
@@ -277,6 +451,7 @@ EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
+	skl_clear_module_table(ctx->dsp);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->ops->free(ctx->dsp);
 }
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 622f7430e100..1019a6ec1739 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -412,6 +412,12 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (!skl_tplg_alloc_pipe_mcps(skl, mconfig))
 			return -ENOMEM;
 
+		if (mconfig->is_loadable) {
+			ret = skl_load_modules(ctx, mconfig);
+			if (ret < 0)
+				return ret;
+		}
+
 		/*
 		 * apply fix/conversion to module params based on
 		 * FE/BE params
@@ -431,6 +437,22 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 	return 0;
 }
 
+static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
+	 struct skl_pipe *pipe)
+{
+	struct skl_pipe_module *w_module = NULL;
+	struct skl_module_cfg *mconfig = NULL;
+
+	list_for_each_entry(w_module, &pipe->w_list, node) {
+		mconfig  = w_module->w->priv;
+
+		if (mconfig->is_loadable)
+			return skl_unload_modules(ctx, mconfig);
+	}
+
+	return 0;
+}
+
 /*
  * Mixer module represents a pipeline. So in the Pre-PMU event of mixer we
  * need create the pipeline. So we do following:
@@ -755,7 +777,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 
 	ret = skl_delete_pipe(ctx, mconfig->pipe);
 
-	return ret;
+	return skl_tplg_unload_pipe_modules(ctx, s_pipe);
 }
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 51e785424a37..2405709f4a69 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -337,5 +337,9 @@ int skl_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
 int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
 			u32 param_id, struct skl_module_cfg *mcfg);
 
+int skl_load_modules(struct skl_sst *ctx, struct skl_module_cfg *mcfg);
+
+int skl_unload_modules(struct skl_sst *ctx, struct skl_module_cfg *mcfg);
+
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
2.4.3
