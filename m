From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Skylake: Add DSP firmware
	manifest parsing
Date: Mon, 30 May 2016 17:42:59 +0530
Message-ID: <1464610381-19416-6-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BFA782607F7
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:57 +0200 (CEST)
In-Reply-To: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Module params like module_id and loadable flag can be changed
in the DSP Firmware. These are kept in the firmware manifest
and driver should read these values from this manifest.

So, add support to parse the DSP firmware manifest and
read these module params.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h   |   6 +
 sound/soc/intel/skylake/skl-sst-ipc.h   |   3 +
 sound/soc/intel/skylake/skl-sst-utils.c | 206 +++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.c  |   4 +
 4 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 94878fac2269..7efaf642c10a 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <sound/memalloc.h>
 #include "skl-sst-cldma.h"
+#include "skl-tplg-interface.h"
 
 struct sst_dsp;
 struct skl_sst;
@@ -175,6 +176,11 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
+int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
+		struct skl_dfw_module *dfw_config);
+int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset);
+void skl_freeup_uuid_list(struct skl_sst *ctx);
+
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
 
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index d59d1ba62a43..7b55182b7895 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -60,6 +60,9 @@ struct skl_sst {
 	void (*enable_miscbdcge)(struct device *dev, bool enable);
 	/*Is CGCTL.MISCBDCGE disabled*/
 	bool miscbdcg_disabled;
+
+	/* Populate module information */
+	struct list_head uuid_list;
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index c00567dad989..25fcb796bd86 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -13,12 +13,100 @@
  * General Public License for more details.
  */
 
-#include <linux/firmware.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/uuid.h>
 #include "skl-sst-dsp.h"
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
+#include "skl-sst-ipc.h"
+
+
+#define UUID_STR_SIZE 37
+#define DEFAULT_HASH_SHA256_LEN 32
 
 /* FW Extended Manifest Header id = $AE1 */
 #define SKL_EXT_MANIFEST_HEADER_MAGIC   0x31454124
 
+struct skl_dfw_module_mod {
+	char name[100];
+	struct skl_dfw_module skl_dfw_mod;
+};
+
+struct UUID {
+	u8 id[16];
+};
+
+union seg_flags {
+	u32 ul;
+	struct {
+		u32 contents : 1;
+		u32 alloc    : 1;
+		u32 load     : 1;
+		u32 read_only : 1;
+		u32 code     : 1;
+		u32 data     : 1;
+		u32 _rsvd0   : 2;
+		u32 type     : 4;
+		u32 _rsvd1   : 4;
+		u32 length   : 16;
+	} r;
+} __packed;
+
+struct segment_desc {
+	union seg_flags flags;
+	u32 v_base_addr;
+	u32 file_offset;
+};
+
+struct module_type {
+	u32 load_type  : 4;
+	u32 auto_start : 1;
+	u32 domain_ll  : 1;
+	u32 domain_dp  : 1;
+	u32 rsvd       : 25;
+} __packed;
+
+struct adsp_module_entry {
+	u32 struct_id;
+	u8  name[8];
+	struct UUID uuid;
+	struct module_type type;
+	u8  hash1[DEFAULT_HASH_SHA256_LEN];
+	u32 entry_point;
+	u16 cfg_offset;
+	u16 cfg_count;
+	u32 affinity_mask;
+	u16 instance_max_count;
+	u16 instance_bss_size;
+	struct segment_desc segments[3];
+} __packed;
+
+struct adsp_fw_hdr {
+	u32 id;
+	u32 len;
+	u8  name[8];
+	u32 preload_page_count;
+	u32 fw_image_flags;
+	u32 feature_mask;
+	u16 major;
+	u16 minor;
+	u16 hotfix;
+	u16 build;
+	u32 num_modules;
+	u32 hw_buf_base;
+	u32 hw_buf_length;
+	u32 load_offset;
+} __packed;
+
+struct uuid_module {
+	uuid_le uuid;
+	int id;
+	int is_loadable;
+
+	struct list_head list;
+};
+
 struct skl_ext_manifest_hdr {
 	u32 id;
 	u32 len;
@@ -27,11 +115,125 @@ struct skl_ext_manifest_hdr {
 	u32 entries;
 };
 
+int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
+			struct skl_dfw_module *dfw_config)
+{
+	struct uuid_module *module;
+	uuid_le *uuid_mod;
+
+	uuid_mod = (uuid_le *)uuid;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
+			dfw_config->module_id = module->id;
+			dfw_config->is_loadable = module->is_loadable;
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
+
+/*
+ * Parse the firmware binary to get the UUID, module id
+ * and loadable flags
+ */
+int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
+{
+	struct adsp_fw_hdr *adsp_hdr;
+	struct adsp_module_entry *mod_entry;
+	int i, num_entry;
+	uuid_le *uuid_bin;
+	const char *buf;
+	struct skl_sst *skl = ctx->thread_context;
+	struct uuid_module *module;
+	struct firmware stripped_fw;
+	unsigned int safe_file;
+
+	/* Get the FW pointer to derive ADSP header */
+	stripped_fw.data = ctx->fw->data;
+	stripped_fw.size = ctx->fw->size;
+
+	skl_dsp_strip_extended_manifest(&stripped_fw);
+
+	buf = stripped_fw.data;
+
+	/* check if we have enough space in file to move to header */
+	safe_file = sizeof(*adsp_hdr) + offset;
+	if (stripped_fw.size <= safe_file) {
+		dev_err(ctx->dev, "Small fw file size, No space for hdr\n");
+		return -EINVAL;
+	}
+
+	adsp_hdr = (struct adsp_fw_hdr *)(buf + offset);
+
+	/* check 1st module entry is in file */
+	safe_file += adsp_hdr->len + sizeof(*mod_entry);
+	if (stripped_fw.size <= safe_file) {
+		dev_err(ctx->dev, "Small fw file size, No module entry\n");
+		return -EINVAL;
+	}
+
+	mod_entry = (struct adsp_module_entry *)
+		(buf + offset + adsp_hdr->len);
+
+	num_entry = adsp_hdr->num_modules;
+
+	/* check all entries are in file */
+	safe_file += num_entry * sizeof(*mod_entry);
+	if (stripped_fw.size <= safe_file) {
+		dev_err(ctx->dev, "Small fw file size, No modules\n");
+		return -EINVAL;
+	}
+
+
+	/*
+	 * Read the UUID(GUID) from FW Manifest.
+	 *
+	 * The 16 byte UUID format is: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXX
+	 * Populate the UUID table to store module_id and loadable flags
+	 * for the module.
+	 */
+
+	for (i = 0; i < num_entry; i++, mod_entry++) {
+		module = kzalloc(sizeof(*module), GFP_KERNEL);
+		if (!module)
+			return -ENOMEM;
+
+		uuid_bin = (uuid_le *)mod_entry->uuid.id;
+		memcpy(&module->uuid, uuid_bin, sizeof(module->uuid));
+
+		module->id = i;
+		module->is_loadable = mod_entry->type.load_type;
+
+		list_add_tail(&module->list, &skl->uuid_list);
+
+		dev_dbg(ctx->dev,
+			"Adding uuid :%pUL   mod id: %d  Loadable: %d\n",
+			&module->uuid, module->id, module->is_loadable);
+	}
+
+	return 0;
+}
+
+void skl_freeup_uuid_list(struct skl_sst *ctx)
+{
+	struct uuid_module *uuid, *_uuid;
+
+	list_for_each_entry_safe(uuid, _uuid, &ctx->uuid_list, list) {
+		list_del(&uuid->list);
+		kfree(uuid);
+	}
+}
+
 /*
  * some firmware binary contains some extended manifest. This needs
  * to be stripped in that case before we load and use that image.
  *
- * So check for magic header, if found strip the header
+ * Get the module id for the module by checking
+ * the table for the UUID for the module
  */
 int skl_dsp_strip_extended_manifest(struct firmware *fw)
 {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3e036b0349b9..44b62e1d79db 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1585,6 +1585,10 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	w->priv = mconfig;
 	memcpy(&mconfig->guid, &dfw_config->uuid, 16);
 
+	ret = snd_skl_get_module_info(skl->skl_sst, mconfig->guid, dfw_config);
+	if (ret < 0)
+		return ret;
+
 	mconfig->id.module_id = dfw_config->module_id;
 	mconfig->id.instance_id = dfw_config->instance_id;
 	mconfig->mcps = dfw_config->max_mcps;
-- 
1.9.1
