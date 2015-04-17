From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 7/9] ASoC: hda: Add DSP library functions for SKL
	platform
Date: Fri, 17 Apr 2015 18:46:05 +0530
Message-ID: <1429276567-29007-8-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CCF265964
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:31 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Adding functionality to parse and load fw and DSP power management in SKL.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-dsp.h          |   39 ++++
 sound/soc/hda/intel/Makefile             |    3 +-
 sound/soc/hda/intel/soc-hda-sst-skl-fw.h |  163 +++++++++++++++++
 sound/soc/hda/intel/soc-hda-sst-skl.c    |  292 ++++++++++++++++++++++++++++++
 4 files changed, 496 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-skl-fw.h
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-skl.c

diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
index 82ba1c9a68c4..4549d6df2ed2 100644
--- a/include/sound/soc-hda-sst-dsp.h
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -99,6 +99,27 @@
 
 #define WINDOW1_SIZE			0x1000
 
+#define FW_STATUS_MASK			0xf
+
+#define FW_ROM_INIT			0x0
+#define FW_ROM_INIT_DONE		0x1
+#define FW_ROM_MEM_PWR_DONE		0x2
+#define FW_ROM_MANIFEST_LOADED		0X3
+#define FW_ROM_MANIFEST_VERIFIED	0x4
+#define FW_ROM_FEAT_MASK_VERIFIED	0x5
+#define FW_ROM_BASEFW_FOUND		0x6
+#define FW_ROM_BASEFW_BA_VALID		0x7
+#define FW_ROM_BASEFW_TOTAL_PWR		0x8
+#define FW_ROM_BASEFW_TEXT_LOADED	0x9
+#define FW_ROM_BASEFW_TEXT_HASHED	0xa
+#define FW_ROM_BASEFW_RODA_LOADED	0xb
+#define FW_ROM_BASEFW_LOAD_HASHED	0xc
+#define FW_ROM_BASEFW_HASH_VER		0xd
+#define FW_ROM_BASEFW_START_FOUND	0xe
+#define FW_ROM_BASEFW_ENTERED		0xf
+
+
+
 #define ADSPIC_IPC                      1
 #define ADSPIS_IPC			1
 
@@ -160,6 +181,14 @@ struct ssth_dsp_loader_ops {
 		struct snd_dma_buffer *dmab);
 };
 
+struct ssth_ops {
+	int (*load_fw)(struct ssth_lib  *ctx);
+	/* FW module parser/loader */
+	int (*parse_fw)(struct ssth_lib *ctx);
+	int (*set_state_D0)(struct ssth_lib *ctx);
+	int (*set_state_D3)(struct ssth_lib *ctx);
+};
+
 struct ssth_lib {
 	struct device *dev;
 	struct ssth_ipc *ipc;
@@ -167,6 +196,7 @@ struct ssth_lib {
 	struct ssth_window window;
 	int irq;
 	struct ssth_dsp_loader_ops  dsp_ops;
+	struct ssth_ops ops;
 	struct snd_dma_buffer dsp_fw_buf;
 	int sst_state;
 	struct mutex sst_lock;
@@ -223,4 +253,13 @@ void ssth_writel_traced(
 	u32 offset,
 	u32 val);
 
+int ssth_register_poll(struct ssth_lib  *ctx, u32 offset, u32 mask,
+			 u32 expected_value, u32 timeout, char *operation);
+int ssth_boot_dsp(struct ssth_lib *ctx);
+int ssth_dsp_init(struct ssth_lib *ctx);
+int ssth_disable_dsp_core(struct ssth_lib  *ctx);
+bool ssth_dsp_is_running(struct ssth_lib *ctx);
+int ssth_cl_dma_prepare(struct ssth_lib *ctx);
+void ssth_process_cl_dma(struct work_struct *work);
+
 #endif /*__HDA_SST_DSP_H__*/
diff --git a/sound/soc/hda/intel/Makefile b/sound/soc/hda/intel/Makefile
index a31db94b2dde..d37275f13aac 100644
--- a/sound/soc/hda/intel/Makefile
+++ b/sound/soc/hda/intel/Makefile
@@ -1,5 +1,6 @@
 
-snd-soc-hda-sst-dsp-objs := soc-hda-sst-ipc.o soc-hda-sst-dsp.o soc-hda-sst-cldma.o
+snd-soc-hda-sst-dsp-objs := soc-hda-sst-ipc.o soc-hda-sst-dsp.o soc-hda-sst-cldma.o \
+	soc-hda-sst-skl.o
 
 # SST DSP Library
 obj-$(CONFIG_SND_SOC_HDA_SST_DSP) += snd-soc-hda-sst-dsp.o
diff --git a/sound/soc/hda/intel/soc-hda-sst-skl-fw.h b/sound/soc/hda/intel/soc-hda-sst-skl-fw.h
new file mode 100644
index 000000000000..b5fd94479e2e
--- /dev/null
+++ b/sound/soc/hda/intel/soc-hda-sst-skl-fw.h
@@ -0,0 +1,163 @@
+/*
+ * Intel SST Firmware Loader
+ *
+ * Copyright (C) 2013-15, Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef SST_FIRMWARE_SKYLAKE_H_
+#define SST_FIRMWARE_SKYLAKE_H_
+
+#include <linux/types.h>
+#include <linux/bug.h>
+
+#define RSA_KEY_DEFAULT_LENGTH 256
+#define RSA_EXPONENT_DEFAULT_LENGTH 4
+
+#define SHA256_HASH_DEFAULT_LENGTH 32
+
+#define MODULE_SIGNATURE_DEFAULT_SIZE 256
+#define MODULE_NAME_DEFAULT_LENGTH 8
+#define MODULE_UUID_DEFAULT_LENGTH 4
+
+struct ssth_segment_flags {
+	uint32_t contents:1;
+	uint32_t alloc:1;
+	uint32_t load:1;
+	uint32_t readonly:1;
+	uint32_t code:1;
+	uint32_t data:1;
+	uint32_t rsvd0:2;
+	uint32_t type:4;
+	uint32_t rsvd1:4;
+	uint32_t length:16;
+} __packed;
+
+enum ssth_segment_type {
+	ST_TEXT,
+	ST_RODATA,
+	ST_BSS
+};
+
+struct ssth_segment_desc {
+	struct ssth_segment_flags flags;
+	uint32_t v_base_addr;
+	uint32_t file_offset;
+} __packed;
+
+struct ssth_module_cfg {
+	uint32_t par[4];
+	uint32_t ip_pages;
+	uint32_t cps;
+	uint32_t ibs;
+	uint32_t obs;
+	uint32_t module_flags;
+	uint32_t cpc;
+	uint32_t obls;
+} __packed;
+
+enum ssth_module_type {
+	MT_BUILTIN,
+	MT_LOADABLE
+};
+
+struct ssth_module_entry {
+	uint32_t struct_id;
+	uint8_t name[MODULE_NAME_DEFAULT_LENGTH];
+	uint32_t uuid[MODULE_UUID_DEFAULT_LENGTH];
+	enum ssth_module_type type;
+	uint8_t hash[SHA256_HASH_DEFAULT_LENGTH];
+	uint32_t entry_point;
+	uint16_t cfg_offset;
+	uint16_t cfg_count;
+	uint32_t affinity_mask;
+	uint16_t instance_max_count;
+	uint16_t instance_bss_size;
+	struct ssth_segment_desc segments[3];
+} __packed;
+
+struct ssth_adsp_fw_binary_header {
+	uint32_t header_id;
+	uint32_t header_len;
+	uint8_t name[MODULE_NAME_DEFAULT_LENGTH];
+	uint32_t preload_page_count;
+	uint32_t fw_image_size;
+	uint32_t feature_mask;
+	uint16_t major_version;
+	uint16_t minor_version;
+	uint16_t hotfix_version;
+	uint16_t build_version;
+	uint32_t num_module_entries;
+	uint32_t hw_buf_base_addr;
+	uint32_t hw_buf_length;
+} __packed;
+
+struct ssth_adsp_fw_binary_desc {
+	struct ssth_adsp_fw_binary_header header;
+	struct ssth_module_entry module_entries[1];
+	/* address of module_cfg depend on
+	 *  sizeof(struct ssth_module_entry) * header.num_module_entries
+	 */
+	struct ssth_module_cfg module_cfg[1];
+} __packed;
+
+struct ssth_css_module_id {
+	uint32_t _res_ls_bits:31;
+	uint32_t debug_manifest:1;
+} __packed;
+
+struct ssth_css_header {
+	uint32_t module_type;
+	uint32_t header_len;
+	uint32_t header_version;
+	struct ssth_css_module_id module_id;
+	uint32_t module_vendor;
+	uint32_t date;
+	uint32_t size;
+	uint32_t key_size;
+	uint32_t modules_size;
+	uint32_t exponent_size;
+	uint32_t reserved[22];
+} __packed;
+
+struct ssth_manifest_rsa_keys {
+	uint8_t modules[RSA_KEY_DEFAULT_LENGTH];
+	uint8_t exponent[RSA_EXPONENT_DEFAULT_LENGTH];
+} __packed;
+
+struct ssth_manifest_crypto_block {
+	struct ssth_manifest_rsa_keys pub_key;
+	uint8_t signature[MODULE_SIGNATURE_DEFAULT_SIZE];
+} __packed;
+
+struct ssth_fw_image_manifest {
+	struct ssth_css_header header;
+	struct ssth_manifest_crypto_block crypto_block;
+	struct ssth_adsp_fw_binary_desc adsp_fw_bin_desc;
+} __packed;
+
+
+static inline void ssth_fw_structs_check_sizes(void)
+{
+	BUILD_BUG_ON(sizeof(struct ssth_segment_flags) != 4);
+	BUILD_BUG_ON(sizeof(struct ssth_segment_desc) != 12);
+	BUILD_BUG_ON(sizeof(struct ssth_module_cfg) != 44);
+	BUILD_BUG_ON(sizeof(struct ssth_module_entry) != 116);
+	BUILD_BUG_ON(sizeof(struct ssth_adsp_fw_binary_header) != 48);
+	BUILD_BUG_ON(sizeof(struct ssth_adsp_fw_binary_desc) != 208);
+	BUILD_BUG_ON(sizeof(struct ssth_css_module_id) != 4);
+	BUILD_BUG_ON(sizeof(struct ssth_css_header) != 128);
+	BUILD_BUG_ON(sizeof(struct ssth_manifest_rsa_keys) != 260);
+	BUILD_BUG_ON(sizeof(struct ssth_manifest_crypto_block) != 516);
+}
+
+#endif /* HDA_SST_FIRMWARE_H_ */
diff --git a/sound/soc/hda/intel/soc-hda-sst-skl.c b/sound/soc/hda/intel/soc-hda-sst-skl.c
new file mode 100644
index 000000000000..71add5891c93
--- /dev/null
+++ b/sound/soc/hda/intel/soc-hda-sst-skl.c
@@ -0,0 +1,292 @@
+/*
+ *  soc_hda_sst-skl.c - HDA DSP library functions for SKL platform
+ *
+ *  Copyright (C) 2014-15 Intel Corp
+ *  Author:Rafal Redzimski <rafal.f.redzimski@intel.com>
+ *		 Jeeja KP <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/soc-hda-sst-ipc.h>
+#include <sound/soc-hda-sst-dsp.h>
+#include "soc-hda-sst-skl-fw.h"
+
+#define SKL_FW_ROM_BASEFW_ENTERED_TIMEOUT		300
+#define SKL_ROM_INIT_DONE_TIMEOUT 1000
+#define SKL_FWLOAD_DONE_TIMEOUT 10000
+
+/* Intel HD Audio SRAM Windoww 0*/
+#define SKL_HDA_ADSP_SRAM0_BASE		0x8000
+
+/* Firmware status window */
+#define SKL_HDA_ADSP_REG_FW_STATUS	SKL_HDA_ADSP_SRAM0_BASE
+
+static int ssth_skl_load_base_firmware(struct ssth_lib *ctx);
+static int ssth_skl_set_dsp_D0(struct ssth_lib *ctx);
+static int ssth_skl_set_dsp_D3(struct ssth_lib *ctx);
+
+struct ssth_ops skl_ops = {
+	/*.parse_fw = ssth_skl_parse_fw_image,*/
+	.set_state_D0 = ssth_skl_set_dsp_D0,
+	.set_state_D3 = ssth_skl_set_dsp_D3,
+	.load_fw = ssth_skl_load_base_firmware,
+};
+
+#define INSTANCE_ID 0
+#define BASE_FW_MODULE_ID 0
+
+static int set_dsp_dx_state(struct ssth_ipc *ipc, struct ssth_dxstate_info *dx)
+{
+	struct ssth_large_config_msg msg;
+
+	msg.module_id = BASE_FW_MODULE_ID;
+	msg.instance_id = INSTANCE_ID;
+	msg.large_param_id = 2;
+	msg.param_data_size = sizeof(*dx);
+
+	return ssth_ipc_set_large_config(ipc, &msg, (u32 *)dx);
+}
+
+static int ssth_skl_set_dsp_D0(struct ssth_lib *ctx)
+{
+	int ret;
+
+	dev_dbg(ctx->dev, "In %s:\n", __func__);
+
+	ret = ssth_skl_load_base_firmware(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "unable to load firmware\n");
+		return ret;
+	}
+
+	/* FIXME: wait for sometime so that FW boots. Remove this once FW_BOOT
+	 * notification is implemented */
+	msleep(200);
+
+	ssth_dsp_set_state_locked(ctx, SST_DSP_RUNNING);
+	return ret;
+}
+
+static int ssth_skl_set_dsp_D3(struct ssth_lib *ctx)
+{
+	int ret;
+	struct ssth_dxstate_info dx;
+
+	dev_dbg(ctx->dev, "In %s:\n", __func__);
+	if (!ssth_dsp_is_running(ctx))
+		return 0;
+
+	dx.core_mask = DSP_CORE0_MASK;
+	dx.dx_mask = ADSP_IPC_D3_MASK;
+	ret = set_dsp_dx_state(ctx->ipc, &dx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to set DSP to D3 state\n");
+		return ret;
+	}
+
+	ret = ssth_disable_dsp_core(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "disable dsp core failed ret: %d\n", ret);
+		ret = -EIO;
+	}
+	ssth_dsp_set_state_locked(ctx, SST_DSP_RESET);
+	return ret;
+}
+
+static bool check_fw_status(struct ssth_lib *ctx, u32 status)
+{
+	u32 cur_sts;
+
+	cur_sts = ssth_readl_alt(ctx, SKL_HDA_ADSP_REG_FW_STATUS) & FW_STATUS_MASK;
+	return (cur_sts == status) ? true : false;
+}
+
+static int ssth_ctx_init(struct ssth_lib *ctx)
+{
+	/* TODO: Move common context initialization here */
+	ctx->intr_wq = create_singlethread_workqueue("sst_dsp_interrupt_wq");
+	if (!ctx->intr_wq)
+		return -EBUSY;
+
+	INIT_WORK(&ctx->ipc_process_msg_work, ssth_ipc_process_msg);
+	INIT_WORK(&ctx->cl_dma_process_work, ssth_process_cl_dma);
+	init_waitqueue_head(&ctx->cl_dev.wait_queue);
+
+	return 0;
+}
+int ssth_skl_init(struct device *dev, void __iomem *mmio_base, int irq,
+		struct ssth_dsp_loader_ops dsp_ops, struct ssth_lib **dsp)
+{
+	struct ssth_lib *ctx;
+	int ret = 0;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (ctx == NULL)
+		return -ENOMEM;
+	ctx->mmio_base = mmio_base;
+	ctx->irq = irq;
+	ctx->dev = dev;
+
+	dev_dbg(dev, "mmio_base: 0x%p\n", ctx->mmio_base);
+	ctx->dsp_ops = dsp_ops;
+	ctx->window.w0stat = mmio_base + SKL_HDA_ADSP_SRAM0_BASE;
+	ctx->window.w0up = mmio_base + SKL_HDA_ADSP_SRAM0_BASE + WINDOW0_STAT_SIZE;
+	ctx->window.w1 = mmio_base + HDA_ADSP_SRAM1_BASE;
+	ctx->window.w0stat_size = WINDOW0_STAT_SIZE;
+	ctx->window.w0up_size = WINDOW0_UP_SIZE;
+	ctx->window.w1_size = WINDOW1_SIZE;
+
+	ctx->ops = skl_ops;
+
+	ret = ssth_dsp_init(ctx);
+	if (ret < 0)
+		return ret;
+
+
+	ret = ssth_ctx_init(ctx);
+	if (ret < 0)
+		return ret;
+
+	ctx->ipc->boot_complete = false;
+	ret = ssth_boot_dsp(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Boot dsp core failed ret: %d", ret);
+		return ret;
+	}
+
+	ssth_cl_dma_prepare(ctx);
+
+	ret = ctx->ops.load_fw(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Load base fw failed : %x", ret);
+		return ret;
+	}
+
+	if (dsp)
+		*dsp = ctx;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ssth_skl_init);
+
+void ssth_skl_cleanup(struct device *dev, struct ssth_lib *ctx)
+{
+	ctx->cl_dev.ops.cl_cleaup_controller(ctx);
+}
+EXPORT_SYMBOL_GPL(ssth_skl_cleanup);
+
+static int ssth_skl_transfer_firmware(struct ssth_lib *ctx,
+		const void *basefw, u32 base_fw_size)
+{
+	int ret = 0;
+
+	if (!ctx->cl_dev.cl_ops) {
+		dev_err(ctx->dev, "No cl ops\n");
+		return -EIO;
+	}
+
+	ret = ctx->cl_dev.ops.cl_copy_to_bdl(ctx, basefw, base_fw_size);
+
+	if (ret)
+		return ret;
+
+	mdelay(1000);
+
+	ret = ssth_register_poll(ctx,
+			SKL_HDA_ADSP_REG_FW_STATUS,
+			FW_STATUS_MASK,
+			FW_ROM_BASEFW_ENTERED,
+			SKL_FW_ROM_BASEFW_ENTERED_TIMEOUT,
+			"Firmware boot");
+
+	return 0;
+}
+
+static int ssth_skl_load_base_firmware(struct ssth_lib *ctx)
+{
+	int ret = 0, i;
+	const struct firmware *fw = NULL;
+	u32 fw_preload_page_count = 0;
+	u32 base_fw_size = 0;
+	struct ssth_fw_image_manifest *manifest;
+	u32 reg;
+
+	ret = request_firmware(&fw, "dsp_fw_release.bin", ctx->dev);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Request firmware failed %d\n", ret);
+		ssth_disable_dsp_core(ctx);
+		return -EIO;
+	}
+
+	/*enable Interrupt */
+	ssth_ipc_int_enable(ctx);
+	ssth_ipc_op_int_enable(ctx);
+
+	/*check ROM Status */
+	for (i = SKL_ROM_INIT_DONE_TIMEOUT; i > 0; --i) {
+		if (check_fw_status(ctx, FW_ROM_INIT_DONE)) {
+			dev_dbg(ctx->dev, "ROM loaded, we can continue with FW loading\n");
+			break;
+		}
+		mdelay(1);
+	}
+	if (!i) {
+		reg = ssth_readl_alt(ctx, SKL_HDA_ADSP_REG_FW_STATUS);
+		dev_err(ctx->dev, "Timeout waiting for ROM init done, reg:0x%x\n", reg);
+		ret = -EIO;
+		goto sst_load_base_firmware_failed;
+	}
+
+	manifest = (struct ssth_fw_image_manifest *)fw->data;
+	fw_preload_page_count =
+		manifest->adsp_fw_bin_desc.header.preload_page_count;
+	base_fw_size = fw_preload_page_count * PAGE_SIZE;
+
+	if (base_fw_size > fw->size) {
+		dev_err(ctx->dev, "Preloaded base fw size is bigger then whole fw image");
+		ret = -EIO;
+		goto sst_load_base_firmware_failed;
+	}
+
+	ret = ssth_skl_transfer_firmware(ctx, fw->data,
+			base_fw_size);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Transfer firmware failed%d\n", ret);
+		goto sst_load_base_firmware_failed;
+	} else {
+		dev_dbg(ctx->dev, "Download firmware successful%d\n", ret);
+		/*FIXME - remove once firmware implementation is done
+		ret = wait_event_timeout(ctx->ipc->boot_wait, ctx->ipc->boot_complete,
+						msecs_to_jiffies(IPC_BOOT_MSECS));
+		if (ret == 0) {
+			dev_err(ctx->dev, "DSP boot failed, FW Ready timed-out\n");
+			ret = -EIO;
+			goto sst_load_base_firmware_failed;
+		} */
+		ssth_dsp_set_state_locked(ctx, SST_DSP_RUNNING);
+	}
+	release_firmware(fw);
+	return 0;
+
+sst_load_base_firmware_failed:
+	ssth_disable_dsp_core(ctx);
+	release_firmware(fw);
+	return ret;
+}
-- 
1.7.9.5
