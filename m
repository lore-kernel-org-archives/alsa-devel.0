From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/9] ASoC: Intel: Skylake: Table for module
	instance id and private id
Date: Wed, 24 Aug 2016 18:03:19 +0530
Message-ID: <1472042001-9582-8-git-send-email-vinod.koul@intel.com>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E0552675A7
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:43 +0200 (CEST)
In-Reply-To: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Dharageswari R <dharageswari.r@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

Now that modules ids are generated dynamically, it helps to keep track of
generated ids while referring modules, so add a map for each module.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h   |  2 ++
 sound/soc/intel/skylake/skl-sst-utils.c | 37 +++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index b61bd03ee4f0..b9e71d051fb1 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -219,6 +219,8 @@ int skl_get_pvt_id(struct skl_sst *ctx,
 				struct skl_module_cfg *mconfig);
 int skl_put_pvt_id(struct skl_sst *ctx,
 				struct skl_module_cfg *mconfig);
+int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
+				int module_id, int instance_id);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 64873bc341dd..8b955f93f405 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -102,6 +102,7 @@ struct uuid_module {
 	int is_loadable;
 	int max_instance;
 	u64 pvt_id[MAX_INSTANCE_BUFF];
+	int *instance_id;
 
 	struct list_head list;
 };
@@ -140,6 +141,31 @@ int snd_skl_get_module_info(struct skl_sst *ctx,
 }
 EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
 
+static int skl_get_pvtid_map(struct uuid_module *module, int instance_id)
+{
+	int pvt_id;
+
+	for (pvt_id = 0; pvt_id < module->max_instance; pvt_id++) {
+		if (module->instance_id[pvt_id] == instance_id)
+			return pvt_id;
+	}
+	return -EINVAL;
+}
+
+int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
+				int module_id, int instance_id)
+{
+	struct uuid_module *module;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (module->id == module_id)
+			return skl_get_pvtid_map(module, instance_id);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(skl_get_pvt_instance_id_map);
+
 static inline int skl_getid_32(struct uuid_module *module, u64 *val,
 				int word1_mask, int word2_mask)
 {
@@ -199,8 +225,11 @@ int skl_get_pvt_id(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 
 			pvt_id = skl_pvtid_128(module);
-			if (pvt_id >= 0)
+			if (pvt_id >= 0) {
+				module->instance_id[pvt_id] =
+						mconfig->id.instance_id;
 				return pvt_id;
+			}
 		}
 	}
 
@@ -242,7 +271,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 {
 	struct adsp_fw_hdr *adsp_hdr;
 	struct adsp_module_entry *mod_entry;
-	int i, num_entry;
+	int i, num_entry, size;
 	uuid_le *uuid_bin;
 	const char *buf;
 	struct skl_sst *skl = ctx->thread_context;
@@ -306,6 +335,10 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->id = (i | (index << 12));
 		module->is_loadable = mod_entry->type.load_type;
 		module->max_instance = mod_entry->instance_max_count;
+		size = sizeof(int) * mod_entry->instance_max_count;
+		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
+		if (!module->instance_id)
+			return -ENOMEM;
 
 		list_add_tail(&module->list, &skl->uuid_list);
 
-- 
1.9.1
