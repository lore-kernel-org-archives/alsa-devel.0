From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/2] ASoC: Intel: Skylake: Add DSP firmware
	manifest parsing
Date: Thu, 21 Apr 2016 11:45:23 +0530
Message-ID: <1461219323-1036-3-git-send-email-vinod.koul@intel.com>
References: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AE23266558
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:10:51 +0200 (CEST)
In-Reply-To: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
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
 sound/soc/intel/skylake/Makefile        |   2 +-
 sound/soc/intel/skylake/skl-dsp-parse.c | 105 +++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-dsp-parse.h | 107 ++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h   |   4 ++
 sound/soc/intel/skylake/skl-sst.c       |  11 +++-
 sound/soc/intel/skylake/skl-topology.c  |   7 ++-
 6 files changed, 233 insertions(+), 3 deletions(-)
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
index 000000000000..015d17043944
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-dsp-parse.c
@@ -0,0 +1,105 @@
+/*
+ *  skl-dsp-parse.c - Implements DSP firmware parsing
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Shreyas NC <shreyas.nc@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
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
+int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
+			struct skl_dfw_module *dfw_config)
+{
+	int i, num;
+	struct uuid_tbl *tbl;
+	uuid_le *uuid_mod;
+
+	tbl = ctx->tbl;
+	num = ctx->num_modules;
+	uuid_mod = (uuid_le *)uuid;
+
+	for (i = 0; i < num; i++) {
+		if (uuid_le_cmp(*uuid_mod, tbl[i].uuid) == 0) {
+			dfw_config->module_id = tbl[i].module_id;
+			dfw_config->is_loadable = tbl[i].is_loadable;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
+
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
+	uuid_le *uuid_bin;
+	const char *buf;
+	struct skl_sst *skl = ctx->thread_context;
+	struct uuid_tbl *tbl;
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
+	 * Read the UUID(GUID) from FW Manifest.
+	 * The 16 byte UUID is of the format:
+	 * XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXX
+	 * Populate the UUID table to store module_id
+	 * and loadable flags for the module.
+	 */
+
+	for (i = 0; i < num_entry; i++, mod_entry++) {
+		uuid_bin = (uuid_le *)mod_entry->uuid.id;
+		memcpy(&tbl[i].uuid, uuid_bin, sizeof(tbl[i].uuid));
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
index 000000000000..5d3fa14bd677
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-dsp-parse.h
@@ -0,0 +1,107 @@
+/*
+ *  skl-dsp-parse.h
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Shreyas NC <shreyas.nc@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+#define SKL_ADSP_FW_BIN_HDR_OFFSET 0x284
+#define UUID_STR_SIZE 37
+#define DEFAULT_HASH_SHA256_LEN 32
+
+struct skl_dfw_module_mod {
+	char name[100];
+	struct skl_dfw_module skl_dfw_mod;
+};
+
+struct UUID {
+	u8  id[16];
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
+	uuid_le uuid;
+	int module_id;
+	int is_loadable;
+};
+
+int parse_fw_bin(struct sst_dsp *ctx);
+int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
+		struct skl_dfw_module *dfw_config);
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
index bec4a7c486fd..8f836b45a72b 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -25,6 +25,7 @@
 #include "../common/sst-dsp-priv.h"
 #include "../common/sst-ipc.h"
 #include "skl-sst-ipc.h"
+#include "skl-dsp-parse.h"
 
 #define SKL_BASEFW_TIMEOUT	300
 #define SKL_INIT_TIMEOUT	1000
@@ -70,7 +71,7 @@ static int skl_transfer_firmware(struct sst_dsp *ctx,
 
 static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
-	int ret = 0, i;
+	int ret = 0, i, err;
 	struct skl_sst *skl = ctx->thread_context;
 	u32 reg;
 
@@ -84,6 +85,14 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
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
index 3e036b0349b9..25192dce2fa4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -28,6 +28,7 @@
 #include "skl-tplg-interface.h"
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
+#include "skl-dsp-parse.h"
 
 #define SKL_CH_FIXUP_MASK		(1 << 0)
 #define SKL_RATE_FIXUP_MASK		(1 << 1)
@@ -1583,7 +1584,11 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 		return -ENOMEM;
 
 	w->priv = mconfig;
-	memcpy(&mconfig->guid, &dfw_config->uuid, 16);
+	memcpy(&mconfig->guid, &dfw_config->uuid, sizeof(mconfig->guid));
+
+	ret = snd_skl_get_module_info(skl->skl_sst, mconfig->guid, dfw_config);
+	if (ret < 0)
+		return ret;
 
 	mconfig->id.module_id = dfw_config->module_id;
 	mconfig->id.instance_id = dfw_config->instance_id;
-- 
1.9.1
