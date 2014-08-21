From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 02/11] ASoC: Intel: mrfld - Add DSP load and
	management
Date: Thu, 21 Aug 2014 18:20:41 +0530
Message-ID: <1408625450-32315-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 00AD026524C
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:12:50 +0200 (CEST)
In-Reply-To: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch contains all dsp controlling functions like firmware download,
setting/resetting dsp cores, etc.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 arch/x86/include/asm/platform_sst_audio.h |  28 +
 sound/soc/intel/sst/sst_loader.c          | 975 ++++++++++++++++++++++++++++++
 2 files changed, 1003 insertions(+)
 create mode 100644 sound/soc/intel/sst/sst_loader.c

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index f4904493a44f..565a617d5a42 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -16,6 +16,9 @@
 
 #include <linux/sfi.h>
 
+#define MAX_NUM_STREAMS_MRFLD	25
+#define MAX_NUM_STREAMS	MAX_NUM_STREAMS_MRFLD
+
 enum sst_audio_task_id_mrfld {
 	SST_TASK_ID_NONE = 0,
 	SST_TASK_ID_SBA = 1,
@@ -73,6 +76,31 @@ struct sst_platform_data {
 	unsigned int strm_map_size;
 };
 
+struct sst_info {
+	u32 iram_start;
+	u32 iram_end;
+	bool iram_use;
+	u32 dram_start;
+	u32 dram_end;
+	bool dram_use;
+	u32 imr_start;
+	u32 imr_end;
+	bool imr_use;
+	u32 mailbox_start;
+	bool use_elf;
+	bool lpe_viewpt_rqd;
+	unsigned int max_streams;
+	u32 dma_max_len;
+	u8 num_probes;
+};
+
+struct sst_lib_dnld_info {
+	unsigned int mod_base;
+	unsigned int mod_end;
+	unsigned int mod_table_offset;
+	unsigned int mod_table_size;
+	bool mod_ddr_dnld;
+};
 
 struct sst_platform_info {
 	const struct sst_ipc_info *ipc_info;
diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
new file mode 100644
index 000000000000..1c05a2fef0f8
--- /dev/null
+++ b/sound/soc/intel/sst/sst_loader.c
@@ -0,0 +1,975 @@
+/*
+ *  sst_dsp.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-14	Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com>
+ *		KP Jeeja <jeeja.kp@intel.com>
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file contains all dsp controlling functions like firmware download,
+ * setting/resetting dsp cores, etc
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/firmware.h>
+#include <linux/dmaengine.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
+#include <linux/elf.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+#include "../sst-dsp.h"
+
+#ifndef CONFIG_X86_64
+#define MEMCPY_TOIO memcpy_toio
+#else
+#define MEMCPY_TOIO memcpy32_toio
+#endif
+
+static struct sst_module_info sst_modules_mrfld[] = {
+	{"mp3_dec", SST_CODEC_TYPE_MP3, 0, SST_LIB_NOT_FOUND},
+	{"aac_dec", SST_CODEC_TYPE_AAC, 0, SST_LIB_NOT_FOUND},
+};
+
+/**
+ * memcpy32_toio: Copy using writel commands
+ *
+ * This is needed because the hardware does not support
+ * 64-bit moveq insructions while writing to PCI MMIO
+ */
+void memcpy32_toio(void *dst, const void *src, int count)
+{
+	int i;
+	const u32 *src_32 = src;
+	u32 *dst_32 = dst;
+
+	for (i = 0; i < count/sizeof(u32); i++)
+		writel(*src_32++, dst_32++);
+}
+
+/**
+ * intel_sst_reset_dsp_mrfld - Resetting SST DSP
+ *
+ * This resets DSP in case of MRFLD platfroms
+ */
+int intel_sst_reset_dsp_mrfld(struct intel_sst_drv *sst_drv_ctx)
+{
+	union config_status_reg_mrfld csr;
+
+	pr_debug("sst: Resetting the DSP in mrfld\n");
+	csr.full = sst_shim_read64(sst_drv_ctx->shim, SST_CSR);
+
+	pr_debug("value:0x%llx\n", csr.full);
+
+	csr.full |= 0x7;
+	sst_shim_write64(sst_drv_ctx->shim, SST_CSR, csr.full);
+	csr.full = sst_shim_read64(sst_drv_ctx->shim, SST_CSR);
+
+	pr_debug("value:0x%llx\n", csr.full);
+
+	csr.full &= ~(0x1);
+	sst_shim_write64(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	csr.full = sst_shim_read64(sst_drv_ctx->shim, SST_CSR);
+	pr_debug("value:0x%llx\n", csr.full);
+	return 0;
+}
+
+/**
+ * sst_start_merrifield - Start the SST DSP processor
+ *
+ * This starts the DSP in MERRIFIELD platfroms
+ */
+int sst_start_mrfld(struct intel_sst_drv *sst_drv_ctx)
+{
+	union config_status_reg_mrfld csr;
+
+	pr_debug("sst: Starting the DSP in mrfld LALALALA\n");
+	csr.full = sst_shim_read64(sst_drv_ctx->shim, SST_CSR);
+	pr_debug("value:0x%llx\n", csr.full);
+
+	csr.full |= 0x7;
+	sst_shim_write64(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	csr.full = sst_shim_read64(sst_drv_ctx->shim, SST_CSR);
+	pr_debug("value:0x%llx\n", csr.full);
+
+	csr.part.xt_snoop = 1;
+	csr.full &= ~(0x5);
+	sst_shim_write64(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	csr.full = sst_shim_read64(sst_drv_ctx->shim, SST_CSR);
+	pr_debug("sst: Starting the DSP_merrifield:%llx\n", csr.full);
+	return 0;
+}
+
+#define SST_CALC_DMA_DSTN(lpe_viewpt_rqd, ia_viewpt_addr, elf_paddr, \
+			lpe_viewpt_addr) ((lpe_viewpt_rqd) ? \
+		elf_paddr : (ia_viewpt_addr + elf_paddr - lpe_viewpt_addr))
+
+static int sst_fill_dstn(struct intel_sst_drv *sst, struct sst_info info,
+		Elf32_Phdr *pr, void **dstn, unsigned int *dstn_phys,
+		int *mem_type)
+{
+	/* work arnd-since only 4 byte align copying is only allowed for ICCM */
+	if ((pr->p_paddr >= info.iram_start) && (pr->p_paddr < info.iram_end)) {
+		size_t data_size = pr->p_filesz % SST_ICCM_BOUNDARY;
+
+		if (data_size)
+			pr->p_filesz += 4 - data_size;
+		*dstn = sst->iram + (pr->p_paddr - info.iram_start);
+		*dstn_phys = SST_CALC_DMA_DSTN(info.lpe_viewpt_rqd,
+				sst->iram_base, pr->p_paddr, info.iram_start);
+		*mem_type = 1;
+	} else if ((pr->p_paddr >= info.dram_start) &&
+		 (pr->p_paddr < info.dram_end)) {
+
+		*dstn = sst->dram + (pr->p_paddr - info.dram_start);
+		*dstn_phys = SST_CALC_DMA_DSTN(info.lpe_viewpt_rqd,
+				sst->dram_base, pr->p_paddr, info.dram_start);
+		*mem_type = 1;
+	} else if ((pr->p_paddr >= info.imr_start) &&
+		   (pr->p_paddr < info.imr_end)) {
+
+		*dstn = sst->ddr + (pr->p_paddr - info.imr_start);
+		*dstn_phys =  sst->ddr_base + pr->p_paddr - info.imr_start;
+		*mem_type = 0;
+	} else {
+	       return -EINVAL;
+	}
+	return 0;
+}
+
+static void sst_fill_info(struct intel_sst_drv *sst,
+			struct sst_info *info)
+{
+	/* first we setup addresses to be used for elf sections */
+	if (sst->info.iram_use) {
+		info->iram_start = sst->info.iram_start;
+		info->iram_end = sst->info.iram_end;
+	} else {
+		info->iram_start = sst->iram_base;
+		info->iram_end = sst->iram_end;
+	}
+	if (sst->info.dram_use) {
+		info->dram_start = sst->info.dram_start;
+		info->dram_end = sst->info.dram_end;
+	} else {
+		info->dram_start = sst->dram_base;
+		info->dram_end = sst->dram_end;
+	}
+	if (sst->info.imr_use) {
+		info->imr_start = sst->info.imr_start;
+		info->imr_end = sst->info.imr_end;
+	} else {
+		info->imr_start = relocate_imr_addr_mrfld(sst->ddr_base);
+		info->imr_end = relocate_imr_addr_mrfld(sst->ddr_end);
+	}
+
+	info->lpe_viewpt_rqd = sst->info.lpe_viewpt_rqd;
+	info->dma_max_len = sst->info.dma_max_len;
+	pr_debug("%s: dma_max_len 0x%x", __func__, info->dma_max_len);
+}
+
+static inline int sst_validate_elf(const struct firmware *sst_bin, bool dynamic)
+{
+	Elf32_Ehdr *elf;
+
+	BUG_ON(!sst_bin);
+
+	pr_debug("IN %s\n", __func__);
+
+	elf = (Elf32_Ehdr *)sst_bin->data;
+
+	if ((elf->e_ident[0] != 0x7F) || (elf->e_ident[1] != 'E') ||
+	    (elf->e_ident[2] != 'L') || (elf->e_ident[3] != 'F')) {
+		pr_debug("ELF Header Not found!%zu\n", sst_bin->size);
+		return -EINVAL;
+	}
+
+	if (dynamic == true) {
+		if (elf->e_type != ET_DYN) {
+			pr_err("Not a dynamic loadable library\n");
+			return -EINVAL;
+		}
+	}
+	pr_debug("Valid ELF Header...%zu\n", sst_bin->size);
+	return 0;
+}
+
+static int sst_validate_fw_image(const void *sst_fw_in_mem, unsigned long size,
+		struct fw_module_header **module, u32 *num_modules)
+{
+	struct sst_fw_header *header;
+
+	pr_debug("%s\n", __func__);
+
+	/* Read the header information from the data pointer */
+	header = (struct sst_fw_header *)sst_fw_in_mem;
+	pr_debug("header sign=%s size=%x modules=%x fmt=%x size=%zx\n",
+			header->signature, header->file_size, header->modules,
+			header->file_format, sizeof(*header));
+
+	/* verify FW */
+	if ((strncmp(header->signature, SST_FW_SIGN, 4) != 0) ||
+		(size != header->file_size + sizeof(*header))) {
+		/* Invalid FW signature */
+		pr_err("InvalidFW sign/filesize mismatch\n");
+		return -EINVAL;
+	}
+	*num_modules = header->modules;
+	*module = (void *)sst_fw_in_mem + sizeof(*header);
+
+	return 0;
+}
+
+/*
+ * sst_fill_memcpy_list - Fill the memcpy list
+ *
+ * @memcpy_list: List to be filled
+ * @destn: Destination addr to be filled in the list
+ * @src: Source addr to be filled in the list
+ * @size: Size to be filled in the list
+ *
+ * Adds the node to the list after required fields
+ * are populated in the node
+ */
+
+static int sst_fill_memcpy_list(struct list_head *memcpy_list,
+			void *destn, const void *src, u32 size, bool is_io)
+{
+	struct sst_memcpy_list *listnode;
+
+	listnode = kzalloc(sizeof(*listnode), GFP_KERNEL);
+	if (listnode == NULL)
+		return -ENOMEM;
+	listnode->dstn = destn;
+	listnode->src = src;
+	listnode->size = size;
+	listnode->is_io = is_io;
+	list_add_tail(&listnode->memcpylist, memcpy_list);
+
+	return 0;
+}
+
+static int sst_parse_elf_module_memcpy(struct intel_sst_drv *sst,
+		const void *fw, struct sst_info info, Elf32_Phdr *pr,
+		struct list_head *memcpy_list)
+{
+	void *dstn;
+	unsigned int dstn_phys;
+	int ret_val = 0;
+	int mem_type;
+
+	ret_val = sst_fill_dstn(sst, info, pr, &dstn, &dstn_phys, &mem_type);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = sst_fill_memcpy_list(memcpy_list, dstn,
+			(void *)fw + pr->p_offset, pr->p_filesz, mem_type);
+	if (ret_val)
+		return ret_val;
+
+	return 0;
+}
+
+static int
+sst_parse_elf_fw_memcpy(struct intel_sst_drv *sst, const void *fw_in_mem,
+			struct list_head *memcpy_list)
+{
+	int i = 0;
+
+	Elf32_Ehdr *elf;
+	Elf32_Phdr *pr;
+	struct sst_info info;
+
+	BUG_ON(!fw_in_mem);
+
+	elf = (Elf32_Ehdr *)fw_in_mem;
+	pr = (Elf32_Phdr *) (fw_in_mem + elf->e_phoff);
+	pr_debug("%s entry\n", __func__);
+
+	sst_fill_info(sst, &info);
+
+	while (i < elf->e_phnum) {
+		if (pr[i].p_type == PT_LOAD)
+			sst_parse_elf_module_memcpy(sst, fw_in_mem, info,
+					&pr[i], memcpy_list);
+		i++;
+	}
+	return 0;
+}
+
+/**
+ * sst_parse_module_memcpy - Parse audio FW modules and populate the memcpy list
+ *
+ * @sst_drv_ctx		: driver context
+ * @module		: FW module header
+ * @memcpy_list	: Pointer to the list to be populated
+ * Create the memcpy list as the number of block to be copied
+ * returns error or 0 if module sizes are proper
+ */
+static int sst_parse_module_memcpy(struct intel_sst_drv *sst_drv_ctx,
+		struct fw_module_header *module, struct list_head *memcpy_list)
+{
+	struct fw_block_info *block;
+	u32 count;
+	int ret_val = 0;
+	void __iomem *ram_iomem;
+
+	pr_debug("module sign %s size %x blocks %x type %x\n",
+			module->signature, module->mod_size,
+			module->blocks, module->type);
+	pr_debug("module entrypoint 0x%x\n", module->entry_point);
+
+	block = (void *)module + sizeof(*module);
+
+	for (count = 0; count < module->blocks; count++) {
+		if (block->size <= 0) {
+			pr_err("block size invalid\n");
+			return -EINVAL;
+		}
+		switch (block->type) {
+		case SST_IRAM:
+			ram_iomem = sst_drv_ctx->iram;
+			break;
+		case SST_DRAM:
+			ram_iomem = sst_drv_ctx->dram;
+			break;
+		case SST_DDR:
+			ram_iomem = sst_drv_ctx->ddr;
+			break;
+		case SST_CUSTOM_INFO:
+			block = (void *)block + sizeof(*block) + block->size;
+			continue;
+		default:
+			pr_err("wrong ram type0x%x in block0x%x\n",
+					block->type, count);
+			return -EINVAL;
+		}
+
+		ret_val = sst_fill_memcpy_list(memcpy_list,
+				ram_iomem + block->ram_offset,
+				(void *)block + sizeof(*block), block->size, 1);
+		if (ret_val)
+			return ret_val;
+
+		block = (void *)block + sizeof(*block) + block->size;
+	}
+	return 0;
+}
+
+/**
+ * sst_parse_fw_memcpy - parse the firmware image & populate the list for memcpy
+ *
+ * @ctx			: pointer to drv context
+ * @size		: size of the firmware
+ * @fw_list		: pointer to list_head to be populated
+ * This function parses the FW image and saves the parsed image in the list
+ * for memcpy
+ */
+static int sst_parse_fw_memcpy(struct intel_sst_drv *ctx, unsigned long size,
+				struct list_head *fw_list)
+{
+	struct fw_module_header *module;
+	u32 count, num_modules;
+	int ret_val;
+
+	ret_val = sst_validate_fw_image(ctx->fw_in_mem, size,
+				&module, &num_modules);
+	if (ret_val)
+		return ret_val;
+
+	for (count = 0; count < num_modules; count++) {
+		/* module */
+		ret_val = sst_parse_module_memcpy(ctx, module, fw_list);
+		if (ret_val)
+			return ret_val;
+		module = (void *)module + sizeof(*module) + module->mod_size;
+	}
+
+	return 0;
+}
+
+/**
+ * sst_do_memcpy - function initiates the memcpy
+ *
+ * @memcpy_list: Pter to memcpy list on which the memcpy needs to be initiated
+ *
+ * Triggers the memcpy
+ */
+static void sst_do_memcpy(struct list_head *memcpy_list)
+{
+	struct sst_memcpy_list *listnode;
+
+	list_for_each_entry(listnode, memcpy_list, memcpylist) {
+		if (listnode->is_io == true)
+			MEMCPY_TOIO((void __iomem *)listnode->dstn,
+					listnode->src, listnode->size);
+		else
+			memcpy(listnode->dstn, listnode->src, listnode->size);
+	}
+}
+
+static void sst_memcpy_free_lib_resources(struct intel_sst_drv *sst_drv_ctx)
+{
+	struct sst_memcpy_list *listnode, *tmplistnode;
+
+	pr_debug("entry:%s\n", __func__);
+
+	/*Free the list*/
+	if (!list_empty(&sst_drv_ctx->libmemcpy_list)) {
+		list_for_each_entry_safe(listnode, tmplistnode,
+				&sst_drv_ctx->libmemcpy_list, memcpylist) {
+			list_del(&listnode->memcpylist);
+			kfree(listnode);
+		}
+	}
+}
+
+void sst_memcpy_free_resources(struct intel_sst_drv *sst_drv_ctx)
+{
+	struct sst_memcpy_list *listnode, *tmplistnode;
+
+	pr_debug("entry:%s\n", __func__);
+
+	/*Free the list*/
+	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
+		list_for_each_entry_safe(listnode, tmplistnode,
+				&sst_drv_ctx->memcpy_list, memcpylist) {
+			list_del(&listnode->memcpylist);
+			kfree(listnode);
+		}
+	}
+	sst_memcpy_free_lib_resources(sst_drv_ctx);
+}
+
+void sst_firmware_load_cb(const struct firmware *fw, void *context)
+{
+	struct intel_sst_drv *ctx = context;
+	int ret = 0;
+
+	pr_debug("In %s\n", __func__);
+
+	if (fw == NULL) {
+		pr_err("request fw failed\n");
+		return;
+	}
+
+	mutex_lock(&ctx->sst_lock);
+
+	if (ctx->sst_state != SST_RESET ||
+			ctx->fw_in_mem != NULL)
+		goto out;
+
+	pr_debug("Request Fw completed\n");
+
+	if (ctx->info.use_elf == true)
+		ret = sst_validate_elf(fw, false);
+
+	if (ret != 0) {
+		pr_err("FW image invalid...\n");
+		goto out;
+	}
+
+	ctx->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
+	if (!ctx->fw_in_mem)
+		goto out;
+
+	pr_debug("copied fw to %p", ctx->fw_in_mem);
+	pr_debug("phys: %lx", (unsigned long)virt_to_phys(ctx->fw_in_mem));
+	memcpy(ctx->fw_in_mem, fw->data, fw->size);
+
+	if (ctx->info.use_elf == true)
+		ret = sst_parse_elf_fw_memcpy(ctx, ctx->fw_in_mem,
+						&ctx->memcpy_list);
+	else
+		ret = sst_parse_fw_memcpy(ctx, fw->size, &ctx->memcpy_list);
+	if (ret) {
+		kfree(ctx->fw_in_mem);
+		ctx->fw_in_mem = NULL;
+		goto out;
+	}
+	/* If static module download(download at boot time) is supported,
+	 * set the flag to indicate lib download is to be done
+	 */
+	if (ctx->pdata->lib_info)
+		if (ctx->pdata->lib_info->mod_ddr_dnld)
+			ctx->lib_dwnld_reqd = true;
+
+out:
+	mutex_unlock(&ctx->sst_lock);
+	if (fw != NULL)
+		release_firmware(fw);
+}
+
+/*
+ * sst_request_fw - requests audio fw from kernel and saves a copy
+ *
+ * This function requests the SST FW from the kernel, parses it and
+ * saves a copy in the driver context
+ */
+static int sst_request_fw(struct intel_sst_drv *sst)
+{
+	int retval = 0;
+	char name[20];
+	const struct firmware *fw;
+
+	snprintf(name, sizeof(name), "%s%04x%s", "fw_sst_",
+				sst->pci_id, ".bin");
+	pr_debug("Requesting FW %s now...\n", name);
+
+	retval = request_firmware(&fw, name, sst->dev);
+	if (fw == NULL) {
+		pr_err("fw is returning as null\n");
+		return -EINVAL;
+	}
+	if (retval) {
+		pr_err("request fw failed %d\n", retval);
+		return retval;
+	}
+	if (sst->info.use_elf == true)
+		retval = sst_validate_elf(fw, false);
+	if (retval != 0) {
+		pr_err("FW image invalid...\n");
+		goto end_release;
+	}
+	sst->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
+	if (!sst->fw_in_mem) {
+		retval = -ENOMEM;
+		goto end_release;
+	}
+	pr_debug("copied fw to %p", sst->fw_in_mem);
+	pr_debug("phys: %lx", (unsigned long)virt_to_phys(sst->fw_in_mem));
+	memcpy(sst->fw_in_mem, fw->data, fw->size);
+	if (sst->info.use_elf == true)
+		retval = sst_parse_elf_fw_memcpy(sst, sst->fw_in_mem,
+						&sst->memcpy_list);
+	else
+		retval = sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
+	if (retval) {
+		kfree(sst->fw_in_mem);
+		sst->fw_in_mem = NULL;
+	}
+
+	/* If static module download(download at boot time) is supported,
+	 * set the flag to indicate lib download is to be done
+	 */
+	if (sst->pdata->lib_info)
+		if (sst->pdata->lib_info->mod_ddr_dnld)
+			sst->lib_dwnld_reqd = true;
+end_release:
+	release_firmware(fw);
+	return retval;
+}
+
+static inline void print_lib_info(struct snd_sst_lib_download_info *resp)
+{
+	pr_debug("codec Type %d Ver %d Built %s: %s\n",
+		resp->dload_lib.lib_info.lib_type,
+		resp->dload_lib.lib_info.lib_version,
+		resp->dload_lib.lib_info.b_date,
+		resp->dload_lib.lib_info.b_time);
+}
+
+/*
+ * Writing the DDR physical base to DCCM offset
+ * so that FW can use it to setup TLB
+ */
+static void sst_dccm_config_write(void __iomem *dram_base,
+		unsigned int ddr_base)
+{
+	void __iomem *addr;
+	u32 bss_reset = 0;
+
+	addr = (void __iomem *)(dram_base + MRFLD_FW_DDR_BASE_OFFSET);
+	MEMCPY_TOIO(addr, (void *)&ddr_base, sizeof(u32));
+	bss_reset |= (1 << MRFLD_FW_BSS_RESET_BIT);
+	addr = (void __iomem *)(dram_base + MRFLD_FW_FEATURE_BASE_OFFSET);
+	MEMCPY_TOIO(addr, &bss_reset, sizeof(u32));
+	pr_debug("%s: config written to DCCM\n", __func__);
+}
+
+void sst_post_download_mrfld(struct intel_sst_drv *ctx)
+{
+	sst_dccm_config_write(ctx->dram, ctx->ddr_base);
+	/* For mrfld, download all libraries the first time fw is
+	 * downloaded */
+	pr_debug("%s: lib_dwnld = %u\n", __func__, ctx->lib_dwnld_reqd);
+	if (ctx->lib_dwnld_reqd) {
+		sst_load_all_modules_elf(ctx, sst_modules_mrfld,
+					ARRAY_SIZE(sst_modules_mrfld));
+		ctx->lib_dwnld_reqd = false;
+	}
+}
+
+static void sst_init_lib_mem_mgr(struct intel_sst_drv *ctx)
+{
+	struct sst_mem_mgr *mgr = &ctx->lib_mem_mgr;
+	const struct sst_lib_dnld_info *lib_info = ctx->pdata->lib_info;
+
+	memset(mgr, 0, sizeof(*mgr));
+	mgr->current_base = lib_info->mod_base + lib_info->mod_table_offset
+						+ lib_info->mod_table_size;
+	mgr->avail = lib_info->mod_end - mgr->current_base + 1;
+
+	pr_debug("current base = 0x%lx , avail = 0x%x\n",
+		(unsigned long)mgr->current_base, mgr->avail);
+}
+
+/**
+ * sst_load_fw - function to load FW into DSP
+ *
+ *
+ * Transfers the FW to DSP using dma/memcpy
+ */
+int sst_load_fw(struct intel_sst_drv *sst_drv_ctx)
+{
+	int ret_val = 0;
+	struct sst_block *block;
+
+	pr_debug("sst_load_fw\n");
+
+	if (sst_drv_ctx->sst_state !=  SST_RESET ||
+			sst_drv_ctx->sst_state == SST_SHUTDOWN)
+		return -EAGAIN;
+
+	if (!sst_drv_ctx->fw_in_mem) {
+		pr_debug("sst: FW not in memory retry to download\n");
+		ret_val = sst_request_fw(sst_drv_ctx);
+		if (ret_val)
+			return ret_val;
+	}
+
+	BUG_ON(!sst_drv_ctx->fw_in_mem);
+	block = sst_create_block(sst_drv_ctx, 0, FW_DWNL_ID);
+	if (block == NULL)
+		return -ENOMEM;
+
+	/* Prevent C-states beyond C6 */
+	pm_qos_update_request(sst_drv_ctx->qos, 0);
+
+	sst_drv_ctx->sst_state = SST_FW_LOADING;
+
+	ret_val = sst_drv_ctx->ops->reset(sst_drv_ctx);
+	if (ret_val)
+		goto restore;
+
+	sst_do_memcpy(&sst_drv_ctx->memcpy_list);
+
+	/* Write the DRAM/DCCM config before enabling FW */
+	if (sst_drv_ctx->ops->post_download)
+		sst_drv_ctx->ops->post_download(sst_drv_ctx);
+
+	/* bring sst out of reset */
+	ret_val = sst_drv_ctx->ops->start(sst_drv_ctx);
+	if (ret_val)
+		goto restore;
+
+	ret_val = sst_wait_timeout(sst_drv_ctx, block);
+	if (ret_val) {
+		pr_err("fw download failed %d\n" , ret_val);
+		/* assume FW d/l failed due to timeout*/
+		ret_val = -EBUSY;
+
+	}
+
+
+restore:
+	/* Re-enable Deeper C-states beyond C6 */
+	pm_qos_update_request(sst_drv_ctx->qos, PM_QOS_DEFAULT_VALUE);
+	sst_free_block(sst_drv_ctx, block);
+	pr_debug("fw load successful!!!\n");
+
+	if (sst_drv_ctx->ops->restore_dsp_context)
+		sst_drv_ctx->ops->restore_dsp_context();
+	sst_drv_ctx->sst_state = SST_FW_RUNNING;
+	return ret_val;
+}
+
+/* In relocatable elf file, there can be  relocatable variables and functions.
+ * Variables are kept in Global Address Offset Table (GOT) and functions in
+ * Procedural Linkage Table (PLT). In current codec binaries only relocatable
+ * variables are seen. So we use the GOT table.
+ */
+static int sst_find_got_table(Elf32_Shdr *shdr, int nsec, char *in_elf,
+		Elf32_Rela **got, unsigned int *cnt)
+{
+	int i = 0;
+
+	while (i < nsec) {
+		if (shdr[i].sh_type == SHT_RELA) {
+			*got = (Elf32_Rela *)(in_elf + shdr[i].sh_offset);
+			*cnt = shdr[i].sh_size / sizeof(Elf32_Rela);
+			break;
+		}
+		i++;
+	}
+	if (i == nsec)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* For each entry in the GOT table, find the unrelocated offset. Then
+ * add the relocation base to the offset and write back the new address to the
+ * original variable location.
+ */
+static int sst_relocate_got_entries(Elf32_Rela *table, unsigned int size,
+	char *in_elf, int elf_size, u32 rel_base)
+{
+	int i;
+	Elf32_Rela *entry;
+	Elf32_Addr *target_addr, unreloc_addr;
+
+	for (i = 0; i < size; i++) {
+		entry = &table[i];
+		if (ELF32_R_SYM(entry->r_info) != 0) {
+			return -EINVAL;
+		} else {
+			if (entry->r_offset > elf_size) {
+				pr_err("GOT table target addr out of range\n");
+				return -EINVAL;
+			}
+			target_addr = (Elf32_Addr *)(in_elf + entry->r_offset);
+			unreloc_addr = *target_addr + entry->r_addend;
+			if (unreloc_addr > elf_size) {
+				pr_err("GOT table entry invalid\n");
+				continue;
+			}
+			*target_addr = unreloc_addr + rel_base;
+		}
+	}
+	return 0;
+}
+
+static int sst_relocate_elf(char *in_elf, int elf_size, phys_addr_t rel_base,
+		Elf32_Addr *entry_pt)
+{
+	int retval = 0;
+	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)in_elf;
+	Elf32_Shdr *shdr = (Elf32_Shdr *) (in_elf + ehdr->e_shoff);
+	Elf32_Phdr *phdr = (Elf32_Phdr *) (in_elf + ehdr->e_phoff);
+	int i, num_sec;
+	Elf32_Rela *rel_table = NULL;
+	unsigned int rela_cnt = 0;
+	u32 rbase;
+
+	BUG_ON(rel_base > (u32)(-1));
+	rbase = (u32) (rel_base & (u32)(~0));
+
+	/* relocate the entry_pt */
+	*entry_pt = (Elf32_Addr)(ehdr->e_entry + rbase);
+	num_sec = ehdr->e_shnum;
+
+	/* Find the relocation(GOT) table through the section header */
+	retval = sst_find_got_table(shdr, num_sec, in_elf,
+					&rel_table, &rela_cnt);
+	if (retval < 0)
+		return retval;
+
+	/* Relocate all the entries in the GOT */
+	retval = sst_relocate_got_entries(rel_table, rela_cnt, in_elf,
+						elf_size, rbase);
+	if (retval < 0)
+		return retval;
+
+	pr_debug("GOT entries relocated\n");
+
+	/* Update the program headers in the ELF */
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		if (phdr[i].p_type == PT_LOAD) {
+			phdr[i].p_vaddr += rbase;
+			phdr[i].p_paddr += rbase;
+		}
+	}
+	pr_debug("program header entries updated\n");
+
+	return retval;
+}
+
+#define ALIGN_256 0x100
+
+int sst_get_next_lib_mem(struct sst_mem_mgr *mgr, int size,
+			unsigned long *lib_base)
+{
+	int retval = 0;
+
+	pr_debug("library orig size = 0x%x", size);
+	if (size % ALIGN_256)
+		size += (ALIGN_256 - (size % ALIGN_256));
+	if (size > mgr->avail)
+		return -ENOMEM;
+
+	*lib_base = mgr->current_base;
+	mgr->current_base += size;
+	mgr->avail -= size;
+	mgr->count++;
+	pr_debug("library base = 0x%lx", *lib_base);
+	pr_debug("library aligned size = 0x%x", size);
+	pr_debug("lib count = %d\n", mgr->count);
+	return retval;
+
+}
+
+static int sst_download_lib_elf(struct intel_sst_drv *sst, const void *lib,
+		int size)
+{
+	int retval = 0;
+
+	pr_debug("In %s\n", __func__);
+
+	retval = sst_parse_elf_fw_memcpy(sst, lib,
+			 &sst->libmemcpy_list);
+	if (retval)
+		return retval;
+	sst_do_memcpy(&sst->libmemcpy_list);
+	sst_memcpy_free_lib_resources(sst);
+	pr_debug("download lib complete");
+	return retval;
+}
+
+static void sst_fill_fw_module_table(struct sst_module_info *mod_list,
+		int list_size, unsigned long ddr_base)
+{
+	int i;
+	u32 *write_ptr = (u32 *)ddr_base;
+
+	pr_debug("In %s\n", __func__);
+
+	for (i = 0; i < list_size; i++) {
+		if (mod_list[i].status == SST_LIB_DOWNLOADED) {
+			pr_debug("status dnwld for %d\n", i);
+			pr_debug("module id %d\n", mod_list[i].id);
+			pr_debug("entry pt 0x%x\n", mod_list[i].entry_pt);
+
+			*write_ptr++ = mod_list[i].id;
+			*write_ptr++ = mod_list[i].entry_pt;
+		}
+	}
+}
+
+static int sst_request_lib_elf(struct sst_module_info *mod_entry,
+	const struct firmware **fw_lib, int pci_id, struct device *dev)
+{
+	char name[25];
+	int retval = 0;
+
+	snprintf(name, sizeof(name), "%s%s%04x%s", mod_entry->name,
+			"_", pci_id, ".bin");
+	pr_debug("Requesting %s\n", name);
+
+	retval = request_firmware(fw_lib, name, dev);
+	if (retval) {
+		pr_err("%s library load failed %d\n", name, retval);
+		return retval;
+	}
+	pr_debug("got lib\n");
+	mod_entry->status = SST_LIB_FOUND;
+	return 0;
+}
+
+static int sst_allocate_lib_mem(const struct firmware *lib, int size,
+	struct sst_mem_mgr *mem_mgr, char **out_elf, unsigned long *lib_start)
+{
+	int retval = 0;
+
+	*out_elf = kzalloc(size, GFP_KERNEL);
+	if (!*out_elf)
+		goto mem_error;
+
+	memcpy(*out_elf, lib->data, size);
+	retval = sst_get_next_lib_mem(mem_mgr, size, lib_start);
+	if (retval < 0) {
+		pr_err("cannot alloc ddr mem for lib: %d\n", retval);
+		kfree(*out_elf);
+		goto mem_error;
+	}
+	return 0;
+
+mem_error:
+	release_firmware(lib);
+	return -ENOMEM;
+}
+
+int sst_load_all_modules_elf(struct intel_sst_drv *ctx,
+		struct sst_module_info *mod_table, int num_modules)
+{
+	int retval = 0;
+	int i;
+	const struct firmware *fw_lib;
+	struct sst_module_info *mod = NULL;
+	char *out_elf;
+	unsigned int lib_size = 0;
+	unsigned int mod_table_offset = ctx->pdata->lib_info->mod_table_offset;
+	unsigned long lib_base;
+
+	pr_debug("In %s", __func__);
+
+	sst_init_lib_mem_mgr(ctx);
+
+	for (i = 0; i < num_modules; i++) {
+		mod = &mod_table[i];
+		retval = sst_request_lib_elf(mod, &fw_lib,
+						ctx->pci_id, ctx->dev);
+		if (retval < 0)
+			continue;
+		lib_size = fw_lib->size;
+
+		retval = sst_validate_elf(fw_lib, true);
+		if (retval < 0) {
+			pr_err("library is not valid elf %d\n", retval);
+			release_firmware(fw_lib);
+			continue;
+		}
+		retval = sst_allocate_lib_mem(fw_lib, lib_size,
+				&ctx->lib_mem_mgr, &out_elf, &lib_base);
+		if (retval < 0) {
+			pr_err("lib mem allocation failed: %d\n", retval);
+			continue;
+		}
+
+		/* relocate in place */
+		retval = sst_relocate_elf(out_elf, lib_size,
+						lib_base, &mod->entry_pt);
+		if (retval < 0) {
+			pr_err("lib elf relocation failed: %d\n", retval);
+			release_firmware(fw_lib);
+			kfree(out_elf);
+			continue;
+		}
+		release_firmware(fw_lib);
+		/* write to ddr imr region,use memcpy method */
+		retval = sst_download_lib_elf(ctx, out_elf, lib_size);
+		mod->status = SST_LIB_DOWNLOADED;
+		kfree(out_elf);
+	}
+
+	/* write module table to DDR */
+	sst_fill_fw_module_table(mod_table, num_modules,
+			(unsigned long)(ctx->ddr + mod_table_offset));
+	return retval;
+}
-- 
1.9.0
