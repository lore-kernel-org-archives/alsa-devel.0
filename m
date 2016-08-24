From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/9] ASoC: Intel: Skylake: Create dynamic
	instance ids for DSP modules
Date: Wed, 24 Aug 2016 18:03:17 +0530
Message-ID: <1472042001-9582-6-git-send-email-vinod.koul@intel.com>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 312B42675A4
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:39 +0200 (CEST)
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

Module instance id's are unique id's used to communicate with DSP. Earlier
they were defined in topology. But that approach runs issue with assigning
unique id to each module and range is limited by firmware

The solution is to allocate and manage the id's in driver. Any unused id can
be allocated and used in communication with firmware untill the module is
destroyed and id freed.

The implementation uses ffz to find free id. Also it add a macro on top of
ffz to create a 128 bit id as ffz works on long.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h   |  4 ++
 sound/soc/intel/skylake/skl-sst-utils.c | 98 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h  |  1 +
 3 files changed, 103 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 6ad5cab4b0d5..b61bd03ee4f0 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -215,6 +215,10 @@ int snd_skl_get_module_info(struct skl_sst *ctx,
 				struct skl_module_cfg *mconfig);
 int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 				unsigned int offset, int index);
+int skl_get_pvt_id(struct skl_sst *ctx,
+				struct skl_module_cfg *mconfig);
+int skl_put_pvt_id(struct skl_sst *ctx,
+				struct skl_module_cfg *mconfig);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 3a508b7a0041..fe77d185b857 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -94,10 +94,14 @@ struct adsp_fw_hdr {
 	u32 load_offset;
 } __packed;
 
+#define MAX_INSTANCE_BUFF 2
+
 struct uuid_module {
 	uuid_le uuid;
 	int id;
 	int is_loadable;
+	int max_instance;
+	u64 pvt_id[MAX_INSTANCE_BUFF];
 
 	struct list_head list;
 };
@@ -136,6 +140,99 @@ int snd_skl_get_module_info(struct skl_sst *ctx,
 }
 EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
 
+static inline int skl_getid_32(struct uuid_module *module, u64 *val,
+					int word1_mask, int word2_mask)
+{
+	int index, max_inst, pvt_id;
+	u32 mask_val;
+
+	max_inst =  module->max_instance;
+	mask_val = (u32)(*val >> word1_mask);
+
+	if (!(mask_val == 0xffffffff)) {
+		index = ffz(mask_val);
+		pvt_id = index + word1_mask + word2_mask;
+		if (pvt_id <= (max_inst - 1)) {
+			*val |= 1 << (index + word1_mask);
+			return pvt_id;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static inline int skl_pvtid_128(struct uuid_module *module)
+{
+	int j, i, word1_mask, word2_mask = 0, pvt_id;
+
+	for (j = 0; j < MAX_INSTANCE_BUFF; j++) {
+		word1_mask = 0;
+
+		for (i = 0; i < 2; i++) {
+			pvt_id = skl_getid_32(module, &module->pvt_id[j],
+						word1_mask, word2_mask);
+			if (pvt_id >= 0)
+				return pvt_id;
+
+			word1_mask += 32;
+			if ((word1_mask + word2_mask) >= module->max_instance)
+				return -EINVAL;
+		}
+
+		word2_mask += 64;
+		if (word2_mask >= module->max_instance)
+			return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+int skl_get_pvt_id(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+{
+	struct uuid_module *module;
+	uuid_le *uuid_mod;
+	int pvt_id;
+
+	uuid_mod = (uuid_le *)mconfig->guid;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
+
+			pvt_id = skl_pvtid_128(module);
+			if (pvt_id >= 0)
+				return pvt_id;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(skl_get_pvt_id);
+
+int skl_put_pvt_id(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+{
+	int i;
+	uuid_le *uuid_mod;
+	struct uuid_module *module;
+
+	uuid_mod = (uuid_le *)mconfig->guid;
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
+
+			if (mconfig->id.pvt_id != 0)
+				i = (mconfig->id.pvt_id) / 64;
+			else
+				i = 0;
+
+			module->pvt_id[i] &= ~(1 << (mconfig->id.pvt_id));
+			mconfig->id.pvt_id = -1;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(skl_put_pvt_id);
+
 /*
  * Parse the firmware binary to get the UUID, module id
  * and loadable flags
@@ -208,6 +305,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 
 		module->id = (i | (index << 12));
 		module->is_loadable = mod_entry->type.load_type;
+		module->max_instance = mod_entry->instance_max_count;
 
 		list_add_tail(&module->list, &skl->uuid_list);
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 37f45cc32a44..def03912b1bd 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -218,6 +218,7 @@ struct skl_module_cfg;
 struct skl_module_inst_id {
 	int module_id;
 	u32 instance_id;
+	int pvt_id;
 };
 
 enum skl_module_pin_state {
-- 
1.9.1
