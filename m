From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Add DSP firmware
	manifest parsing
Date: Sun,  3 Apr 2016 03:19:14 +0530
Message-ID: <1459633754-20548-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 128612612AF
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 23:49:25 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Nc,
 Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Nc,Shreyas" <shreyas.nc@intel.com>

Module params like module_id and loadable flag can changed in the
DSP Firmware. These are kept in the firmware manifest and driver
should read these values from this manifest.

So, add support to parse the DSP firmware manifest and read these
module params.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/Makefile        |   2 +-
 sound/soc/intel/skylake/skl-dsp-parse.c | 134 ++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-dsp-parse.h | 109 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h   |   4 +
 sound/soc/intel/skylake/skl-sst.c       |  11 ++-
 sound/soc/intel/skylake/skl-topology.c  |  15 ++--
 6 files changed, 268 insertions(+), 7 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-dsp-parse.c
 create mode 100644 sound/soc/intel/skylake/skl-dsp-parse.h

diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index c28f5d0e1d99..e2fb5b763b21 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
 
 # Skylake IPC Support
 snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o skl-sst-cldma.o \
-		skl-sst.o bxt-sst.o
+		skl-sst.o skl-dsp-parse.o bxt-sst.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl-ipc.o
diff --git a/sound/soc/intel/skylake/skl-dsp-parse.c b/sound/soc/intel/skylake/skl-dsp-parse.c
new file mode 100644
index 000000000000..1736dec68e3c
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-dsp-parse.c
@@ -0,0 +1,134 @@
+/*
+ *  skl-dsp-parse.c - Implements DSP firmware manifest parsing
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Shreyas NC <shreyas.nc@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <asm/types.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
+#include "skl-tplg-interface.h"
+#include "skl-sst-ipc.h"
+#include "skl-dsp-parse.h"
+
+/*
+ * Get the module id for the module by checking
+ * the table for the UUID for the module
+ */
+int snd_skl_get_module_info(struct skl_sst *ctx, char *uuid,
+				struct skl_dfw_module *dfw_config)
+{
+	int i, num;
+	struct uuid_tbl *tbl;
+
+	tbl = ctx->tbl;
+	num = ctx->num_modules;
+
+	for (i = 0; i < num; i++) {
+		if (!strcmp(uuid, tbl[i].uuid)) {
+			dfw_config->module_id = tbl[i].module_id;
+			dfw_config->is_loadable = tbl[i].is_loadable;
+
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
+
+/*
+ * Get the uuid from the DSP firmware structure in a string
+ * of the format XXXXXXXX-XXXX-XXXX-XXXXXXXXXXXX
+ */
+static char *get_canonical_uuid(char *buf,
+		struct adsp_module_entry *entry)
+{
+	unsigned int i;
+
+	sprintf(buf, "%08X", entry->uuid.id_1);
+	sprintf(buf+strlen(buf), "-");
+
+	for (i = 0; i < ARRAY_SIZE(entry->uuid.id_2); i++) {
+		sprintf(buf+strlen(buf),
+				"%04X", entry->uuid.id_2[i]);
+		sprintf(buf+strlen(buf), "-");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(entry->uuid.id_3); i++) {
+		sprintf(buf+strlen(buf),
+				"%02X", entry->uuid.id_3[i]);
+		if (i == 1)
+			sprintf(buf+strlen(buf), "-");
+	}
+
+	return buf;
+}
+
+/*
+ * Parse the firmware binary to get the UUID, module id
+ * and loadable flags
+ */
+int parse_fw_bin(struct sst_dsp *ctx)
+{
+	struct adsp_fw_hdr *adsp_hdr;
+	struct adsp_module_entry *mod_entry;
+	int i, num_entry;
+	char uuid_str[UUID_STR_SIZE];
+	const char *buf;
+	struct skl_sst *skl = ctx->thread_context;
+	struct uuid_tbl *tbl;
+
+
+	/* Get the FW pointer to derive ADSP header */
+	buf = ctx->fw->data;
+
+	adsp_hdr = (struct adsp_fw_hdr *)(buf + SKL_ADSP_FW_BIN_HDR_OFFSET);
+
+	mod_entry = (struct adsp_module_entry *)
+		(buf + SKL_ADSP_FW_BIN_HDR_OFFSET + adsp_hdr->header_len);
+
+	num_entry = adsp_hdr->num_module_entries;
+
+	tbl = devm_kzalloc(ctx->dev,
+		num_entry * sizeof(struct uuid_tbl), GFP_KERNEL);
+
+	if (!tbl)
+		return -ENOMEM;
+
+	/*
+	 * Populate the UUID table to store module_id
+	 * and loadable flags for the module
+	 */
+
+	for (i = 0; i < num_entry; i++, mod_entry++) {
+		get_canonical_uuid(uuid_str, mod_entry);
+
+		strncpy(tbl[i].uuid, uuid_str, strlen(uuid_str));
+
+		tbl[i].module_id = i;
+		tbl[i].is_loadable = mod_entry->type.load_type;
+	}
+
+	skl->tbl = tbl;
+	skl->num_modules = num_entry;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(parse_fw_bin);
diff --git a/sound/soc/intel/skylake/skl-dsp-parse.h b/sound/soc/intel/skylake/skl-dsp-parse.h
new file mode 100644
index 000000000000..2da1bbad9145
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-dsp-parse.h
@@ -0,0 +1,109 @@
+/*
+ *  skl-dsp-parse.h
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Shreyas NC <shreyas.nc@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <asm/types.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include "skl-tplg-interface.h"
+#include "../common/sst-dsp-priv.h"
+
+#define SKL_ADSP_FW_BIN_HDR_OFFSET	0x284
+#define UUID_STR_SIZE			37
+#define DEFAULT_HASH_SHA256_LEN		32
+
+struct skl_dfw_module_mod {
+	char name[100];
+	struct skl_dfw_module skl_dfw_mod;
+};
+
+struct UUID {
+	u32 id_1;
+	u16 id_2[2];
+	u8  id_3[8];
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
+	u32 rsvd_      : 25;
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
+	u32 header_id;
+	u32 header_len;
+	u8  name[8];
+	u32 preload_page_count;
+	u32 fw_image_flags;
+	u32 feature_mask;
+	u16 major_version;
+	u16 minor_version;
+	u16 hotfix_version;
+	u16 build_version;
+	u32 num_module_entries;
+	u32 hw_buf_base_addr;
+	u32 hw_buf_length;
+	u32 load_offset;
+} __packed;
+
+struct uuid_tbl {
+	char uuid[UUID_STR_SIZE];
+	int module_id;
+	int is_loadable;
+};
+
+int parse_fw_bin(struct sst_dsp *ctx);
+int snd_skl_get_module_info(struct skl_sst *ctx, char *uuid,
+			struct skl_dfw_module *dfw_config);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index d59d1ba62a43..67d56be8cb77 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -60,6 +60,10 @@ struct skl_sst {
 	void (*enable_miscbdcge)(struct device *dev, bool enable);
 	/*Is CGCTL.MISCBDCGE disabled*/
 	bool miscbdcg_disabled;
+
+	/* Populate module information */
+	struct uuid_tbl *tbl;
+	int num_modules;
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 348a734f8e24..9fbe922d05ce 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -24,6 +24,7 @@
 #include "../common/sst-dsp-priv.h"
 #include "../common/sst-ipc.h"
 #include "skl-sst-ipc.h"
+#include "skl-dsp-parse.h"
 
 #define SKL_BASEFW_TIMEOUT	300
 #define SKL_INIT_TIMEOUT	1000
@@ -69,7 +70,7 @@ static int skl_transfer_firmware(struct sst_dsp *ctx,
 
 static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
-	int ret = 0, i;
+	int ret = 0, i, err;
 	struct skl_sst *skl = ctx->thread_context;
 	u32 reg;
 
@@ -83,6 +84,14 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 			skl_dsp_disable_core(ctx);
 			return -EIO;
 		}
+
+		err = parse_fw_bin(ctx);
+		if (err < 0) {
+			dev_err(ctx->dev,
+					"Firmware parsing err: %d\n", ret);
+			release_firmware(ctx->fw);
+			return err;
+		}
 	}
 
 	ret = skl_dsp_boot(ctx);
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 545b4e77b8aa..d64edfa45b6e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -28,6 +28,7 @@
 #include "skl-tplg-interface.h"
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
+#include "skl-dsp-parse.h"
 
 #define SKL_CH_FIXUP_MASK		(1 << 0)
 #define SKL_RATE_FIXUP_MASK		(1 << 1)
@@ -1550,7 +1551,15 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 		return -ENOMEM;
 
 	w->priv = mconfig;
+	memcpy(mconfig->guid, dfw_config->uuid,
+					ARRAY_SIZE(dfw_config->uuid));
+
+	ret = snd_skl_get_module_info(skl->skl_sst, mconfig->guid, dfw_config);
+	if (ret < 0)
+		return ret;
+
 	mconfig->id.module_id = dfw_config->module_id;
+	mconfig->is_loadable = dfw_config->is_loadable;
 	mconfig->id.instance_id = dfw_config->instance_id;
 	mconfig->mcps = dfw_config->max_mcps;
 	mconfig->ibs = dfw_config->ibs;
@@ -1558,7 +1567,7 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->core_id = dfw_config->core_id;
 	mconfig->max_in_queue = dfw_config->max_in_queue;
 	mconfig->max_out_queue = dfw_config->max_out_queue;
-	mconfig->is_loadable = dfw_config->is_loadable;
+
 	skl_tplg_fill_fmt(mconfig->in_fmt, dfw_config->in_fmt,
 						MODULE_MAX_IN_PINS);
 	skl_tplg_fill_fmt(mconfig->out_fmt, dfw_config->out_fmt,
@@ -1579,10 +1588,6 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->time_slot = dfw_config->time_slot;
 	mconfig->formats_config.caps_size = dfw_config->caps.caps_size;
 
-	if (dfw_config->is_loadable)
-		memcpy(mconfig->guid, dfw_config->uuid,
-					ARRAY_SIZE(dfw_config->uuid));
-
 	mconfig->m_in_pin = devm_kzalloc(bus->dev, (mconfig->max_in_queue) *
 						sizeof(*mconfig->m_in_pin),
 						GFP_KERNEL);
-- 
2.4.3
