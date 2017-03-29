From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Rearrangement of code
	to cleanup SKL SST library" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:15 +0100
Message-ID: <E1ctCB5-0001VV-Ev@debutante>
References: <1490275926-2270-9-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EDC58266F52
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:24 +0200 (CEST)
In-Reply-To: <1490275926-2270-9-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Rearrangement of code to cleanup SKL SST library

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

>From b26199eae86f7a1c2363d049249c3be33694f93b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 24 Mar 2017 23:10:31 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Rearrangement of code to cleanup SKL
 SST library

Skylake driver topology header/driver structure is referenced and used
in SST library which creates circular dependency. Hence the
rearrangement.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c       | 35 +++++++++++++++----
 sound/soc/intel/skylake/skl-sst-dsp.h   | 24 +++++++++----
 sound/soc/intel/skylake/skl-sst-ipc.h   |  8 +++++
 sound/soc/intel/skylake/skl-sst-utils.c | 60 +++++----------------------------
 sound/soc/intel/skylake/skl-topology.c  | 11 ++++--
 sound/soc/intel/skylake/skl-topology.h  | 13 -------
 6 files changed, 70 insertions(+), 81 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 3c61dbab3d4f..ef440d8629e8 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1174,29 +1174,52 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return retval;
 }
 
+static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
+{
+	struct skl_sst *ctx = skl->skl_sst;
+	struct uuid_module *module;
+	uuid_le *uuid_mod;
+
+	uuid_mod = (uuid_le *)mconfig->guid;
+
+	if (list_empty(&ctx->uuid_list)) {
+		dev_err(ctx->dev, "Module list is empty\n");
+		return -EIO;
+	}
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
+			mconfig->id.module_id = module->id;
+			mconfig->is_loadable = module->is_loadable;
+			return 0;
+		}
+	}
+
+	return -EIO;
+}
+
 static int skl_populate_modules(struct skl *skl)
 {
 	struct skl_pipeline *p;
 	struct skl_pipe_module *m;
 	struct snd_soc_dapm_widget *w;
 	struct skl_module_cfg *mconfig;
-	int ret;
+	int ret = 0;
 
 	list_for_each_entry(p, &skl->ppl_list, node) {
 		list_for_each_entry(m, &p->pipe->w_list, node) {
-
 			w = m->w;
 			mconfig = w->priv;
 
-			ret = snd_skl_get_module_info(skl->skl_sst, mconfig);
+			ret = skl_get_module_info(skl, mconfig);
 			if (ret < 0) {
 				dev_err(skl->skl_sst->dev,
-					"query module info failed:%d\n", ret);
-				goto err;
+					"query module info failed\n");
+				return ret;
 			}
 		}
 	}
-err:
+
 	return ret;
 }
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 5d7a93aa5bed..7229a12b4c94 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -17,13 +17,14 @@
 #define __SKL_SST_DSP_H__
 
 #include <linux/interrupt.h>
+#include <linux/uuid.h>
 #include <sound/memalloc.h>
 #include "skl-sst-cldma.h"
-#include "skl-topology.h"
 
 struct sst_dsp;
 struct skl_sst;
 struct sst_dsp_device;
+struct skl_lib_info;
 
 /* Intel HD Audio General DSP Registers */
 #define SKL_ADSP_GEN_BASE		0x0
@@ -172,6 +173,19 @@ struct skl_dsp_loader_ops {
 				 int stream_tag);
 };
 
+#define MAX_INSTANCE_BUFF 2
+
+struct uuid_module {
+	uuid_le uuid;
+	int id;
+	int is_loadable;
+	int max_instance;
+	u64 pvt_id[MAX_INSTANCE_BUFF];
+	int *instance_id;
+
+	struct list_head list;
+};
+
 struct skl_load_module_info {
 	u16 mod_id;
 	const struct firmware *fw;
@@ -223,14 +237,10 @@ int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
-int snd_skl_get_module_info(struct skl_sst *ctx,
-				struct skl_module_cfg *mconfig);
 int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 				unsigned int offset, int index);
-int skl_get_pvt_id(struct skl_sst *ctx,
-				struct skl_module_cfg *mconfig);
-int skl_put_pvt_id(struct skl_sst *ctx,
-				struct skl_module_cfg *mconfig);
+int skl_get_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int instance_id);
+int skl_put_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int *pvt_id);
 int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
 				int module_id, int instance_id);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index fc07c397b060..4abf98c0e00e 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -69,6 +69,14 @@ struct skl_d0i3_data {
 	struct delayed_work work;
 };
 
+#define SKL_LIB_NAME_LENGTH 128
+#define SKL_MAX_LIB 16
+
+struct skl_lib_info {
+	char name[SKL_LIB_NAME_LENGTH];
+	const struct firmware *fw;
+};
+
 struct skl_sst {
 	struct device *dev;
 	struct sst_dsp *dsp;
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index ea162fbf68e5..6d5bff04bf65 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -94,19 +94,6 @@ struct adsp_fw_hdr {
 	u32 load_offset;
 } __packed;
 
-#define MAX_INSTANCE_BUFF 2
-
-struct uuid_module {
-	uuid_le uuid;
-	int id;
-	int is_loadable;
-	int max_instance;
-	u64 pvt_id[MAX_INSTANCE_BUFF];
-	int *instance_id;
-
-	struct list_head list;
-};
-
 struct skl_ext_manifest_hdr {
 	u32 id;
 	u32 len;
@@ -115,32 +102,6 @@ struct skl_ext_manifest_hdr {
 	u32 entries;
 };
 
-int snd_skl_get_module_info(struct skl_sst *ctx,
-				struct skl_module_cfg *mconfig)
-{
-	struct uuid_module *module;
-	uuid_le *uuid_mod;
-
-	uuid_mod = (uuid_le *)mconfig->guid;
-
-	if (list_empty(&ctx->uuid_list)) {
-		dev_err(ctx->dev, "Module list is empty\n");
-		return -EINVAL;
-	}
-
-	list_for_each_entry(module, &ctx->uuid_list, list) {
-		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
-			mconfig->id.module_id = module->id;
-			mconfig->is_loadable = module->is_loadable;
-
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
-
 static int skl_get_pvtid_map(struct uuid_module *module, int instance_id)
 {
 	int pvt_id;
@@ -222,21 +183,18 @@ static inline int skl_pvtid_128(struct uuid_module *module)
  * This generates a 128 bit private unique id for a module TYPE so that
  * module instance is unique
  */
-int skl_get_pvt_id(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+int skl_get_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int instance_id)
 {
 	struct uuid_module *module;
-	uuid_le *uuid_mod;
 	int pvt_id;
 
-	uuid_mod = (uuid_le *)mconfig->guid;
-
 	list_for_each_entry(module, &ctx->uuid_list, list) {
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 
 			pvt_id = skl_pvtid_128(module);
 			if (pvt_id >= 0) {
-				module->instance_id[pvt_id] =
-						mconfig->id.instance_id;
+				module->instance_id[pvt_id] = instance_id;
+
 				return pvt_id;
 			}
 		}
@@ -254,23 +212,21 @@ EXPORT_SYMBOL_GPL(skl_get_pvt_id);
  *
  * This frees a 128 bit private unique id previously generated
  */
-int skl_put_pvt_id(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+int skl_put_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int *pvt_id)
 {
 	int i;
-	uuid_le *uuid_mod;
 	struct uuid_module *module;
 
-	uuid_mod = (uuid_le *)mconfig->guid;
 	list_for_each_entry(module, &ctx->uuid_list, list) {
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 
-			if (mconfig->id.pvt_id != 0)
-				i = (mconfig->id.pvt_id) / 64;
+			if (*pvt_id != 0)
+				i = (*pvt_id) / 64;
 			else
 				i = 0;
 
-			module->pvt_id[i] &= ~(1 << (mconfig->id.pvt_id));
-			mconfig->id.pvt_id = -1;
+			module->pvt_id[i] &= ~(1 << (*pvt_id));
+			*pvt_id = -1;
 			return 0;
 		}
 	}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 35d9d7b43dd2..8bd5ded98cec 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -539,6 +539,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 	int ret = 0;
 
 	list_for_each_entry(w_module, &pipe->w_list, node) {
+		uuid_le *uuid_mod;
 		w = w_module->w;
 		mconfig = w->priv;
 
@@ -576,13 +577,15 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		 * FE/BE params
 		 */
 		skl_tplg_update_module_params(w, ctx);
-		mconfig->id.pvt_id = skl_get_pvt_id(ctx, mconfig);
+		uuid_mod = (uuid_le *)mconfig->guid;
+		mconfig->id.pvt_id = skl_get_pvt_id(ctx, uuid_mod,
+						mconfig->id.instance_id);
 		if (mconfig->id.pvt_id < 0)
 			return ret;
 		skl_tplg_set_module_init_data(w);
 		ret = skl_init_module(ctx, mconfig);
 		if (ret < 0) {
-			skl_put_pvt_id(ctx, mconfig);
+			skl_put_pvt_id(ctx, uuid_mod, &mconfig->id.pvt_id);
 			return ret;
 		}
 		skl_tplg_alloc_pipe_mcps(skl, mconfig);
@@ -602,7 +605,9 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 	struct skl_module_cfg *mconfig = NULL;
 
 	list_for_each_entry(w_module, &pipe->w_list, node) {
+		uuid_le *uuid_mod;
 		mconfig  = w_module->w->priv;
+		uuid_mod = (uuid_le *)mconfig->guid;
 
 		if (mconfig->is_loadable && ctx->dsp->fw_ops.unload_mod &&
 			mconfig->m_state > SKL_MODULE_UNINIT) {
@@ -611,7 +616,7 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 			if (ret < 0)
 				return -EIO;
 		}
-		skl_put_pvt_id(ctx, mconfig);
+		skl_put_pvt_id(ctx, uuid_mod, &mconfig->id.pvt_id);
 	}
 
 	/* no modules to unload in this path, so return */
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index bf2c63b4ab83..8536d03a7778 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -336,19 +336,6 @@ struct skl_pipeline {
 	struct list_head node;
 };
 
-#define SKL_LIB_NAME_LENGTH 128
-#define SKL_MAX_LIB 16
-
-struct skl_lib_info {
-	char name[SKL_LIB_NAME_LENGTH];
-	const struct firmware *fw;
-};
-
-struct skl_manifest {
-	u32 lib_count;
-	struct skl_lib_info lib[SKL_MAX_LIB];
-};
-
 static inline struct skl *get_skl_ctx(struct device *dev)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-- 
2.11.0
