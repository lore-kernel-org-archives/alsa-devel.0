From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 2/13] Intel SST driver
Date: Fri,  3 Jul 2009 12:31:33 +0530
Message-ID: <1246604493-12833-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id A21BB2476D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:52:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds the SST driver for the SST DSP engine. This patch
adds the main file intel_sst.c which contains the init, exit
probe, interrupt routine and PCI suspend/resume implementation.
This file also implements the SST Firmware initialization and
firmware and codec libraries download steps

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   sound/pci/sst/intel_sst.c
---
 sound/pci/sst/intel_sst.c |  877 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 877 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intel_sst.c

diff --git a/sound/pci/sst/intel_sst.c b/sound/pci/sst/intel_sst.c
new file mode 100644
index 0000000..bd30833
--- /dev/null
+++ b/sound/pci/sst/intel_sst.c
@@ -0,0 +1,877 @@
+/*
+ *  intel_sst.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09	Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This driver exposes the audio engine functionalities to the ALSA
+ * 	 and middleware.
+ *
+ *  This file contains all init functions
+ */
+
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/firmware.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#ifndef CONFIG_SST_IPC_NOT_INCLUDED
+#include <asm/ipc_defs.h>
+#endif
+#include <sound/intel_sst.h>
+#include <sound/intel_sst_ioctl.h>
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+#include "intel_sst_pvt.h"
+#ifdef CONFIG_SST_OSPM_SUPPORT
+#include <linux/intel_mid.h>
+#endif
+
+
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_DESCRIPTION("Intel (R) Moorestown Audio Engine Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(SST_DRIVER_VERSION);
+
+struct intel_sst_drv *sst_ops;
+
+void sst_reset(void)
+{
+	int retval;
+
+	/*Disable Audio Core clock and Audio Fabric clock*/
+	retval = sst_scu_ipc_write(0xff11d83c, 0x80008008);
+	if (retval != 0)
+		sst_err("scu ipc write1 failed %d", retval);
+	/*Reset the Audio subsystem*/
+	retval = sst_scu_ipc_write(0xff11d118, 0x7ffffcff);
+	if (retval != 0)
+		sst_err("scu ipc write2 failed %d", retval);
+	/*Bring it out of Audio subsystem reset*/
+	retval = sst_scu_ipc_write(0xff11d118, 0x7fffffff);
+	if (retval != 0)
+		sst_err("scu ipc write3 failed %d", retval);
+	/*Enable fabric clock at 50MHz*/
+	retval = sst_scu_ipc_write(0xff11d83c, 0x80008301);
+	if (retval != 0)
+		sst_err("scu ipc write4 failed %d", retval);
+	/*Write to the Shim register for ratio 1:1*/
+	retval = sst_scu_ipc_write(0xffae8000, 0x382);
+	if (retval != 0)
+		sst_err("scu ipc write5 failed %d", retval);
+	/*Enable the core clock at 1:2*/
+	retval = sst_scu_ipc_write(0xff11d83c, 0x80000301);
+	if (retval != 0)
+		sst_err("scu ipc write6 failed %d", retval);
+	return;
+}
+
+void sst_start(void)
+{
+	union config_status_reg csr;
+	int retval;
+
+	csr.full = readl(sst_ops->shim + SST_CSR);
+	csr.part.sst_reset = 0;
+	csr.part.run_stall = 0;
+	csr.part.bypass = 0;
+	/*csr.full = 0x1800;*/
+	sst_dbg("Setting SST to execute 0x%x \n", csr.full);
+
+	retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR, csr.full);
+	if (retval != 0)
+		sst_err("scu ipc write start failed %d", retval);
+	return;
+}
+int sst_parse_module(struct fw_module_header *module)
+{
+	struct dma_block_info *block = NULL;
+	u32 count;
+	void __iomem *ram;
+
+	sst_dbg("module sign=%s sz=0x%x blks=0x%x typ=0x%x ep=0x%x sz=0x%x\n",
+			module->signature, module->mod_size,
+			module->blocks, module->type,
+			module->entry_point, sizeof(*module));
+
+	block = (void *)module + sizeof(*module);
+
+	for (count = 0; count < module->blocks; count++) {
+		if (0 >= block->size) {
+			sst_err("block size invalid\n");
+			return -EINVAL;
+		}
+		switch (block->type) {
+		case SST_IRAM:
+			ram = sst_ops->iram;
+			break;
+		case SST_DRAM:
+			ram = sst_ops->dram;
+			break;
+		default:
+			sst_err("wrong ram type 0x%x in block 0x%x-abort\n",
+					block->type, count);
+			return -EINVAL;
+		}
+		memcpy_toio(ram + block->ram_offset,
+				(void *)block + sizeof(*block), block->size);
+		block = (void *)block + sizeof(*block) + block->size;
+	}
+	return 0;
+}
+
+/**
+* sst_parse_fw_image - FW parse and load
+* @fw:		Pointer to loaded FW
+*
+* This function is called to parse and download the FW image
+*/
+int sst_parse_fw_image(const struct firmware *sst_fw)
+{
+	struct fw_header *header = NULL;
+	u32 count;
+	int ret_val = 0;
+	struct fw_module_header *module = NULL;
+
+	BUG_ON(!sst_fw);
+
+	/*Read the header information from the data pointer*/
+	header = (struct fw_header *)sst_fw->data;
+
+	/*verify FW*/
+	if ((0 != strncmp(header->signature, SST_FW_SIGN, 4)) ||
+			(sst_fw->size != header->file_size + sizeof(*header))) {
+		/*Invalid FW signature*/
+		sst_err("Invalid FW sign/file size mismatch\n");
+		return -EINVAL;
+	}
+	sst_dbg("header sign=%s size=0x%x modules=0x%x fmt=0x%x size=0x%x\n",
+			header->signature, header->file_size, header->modules,
+			header->file_format, sizeof(*header));
+	module = (void *)sst_fw->data + sizeof(*header);
+	for (count = 0; count < header->modules; count++) {
+		/*module*/
+		ret_val = sst_parse_module(module);
+		if (0 != ret_val)
+			return ret_val;
+		module = (void *)module + sizeof(*module) + module->mod_size ;
+	}
+
+	sst_dbg("done....\n");
+	return 0;
+}
+
+/**
+* sst_load_fw - function to reset FW
+* @fw:		Pointer to loaded FW
+* This function is called when the FW is loaded
+*/
+void sst_load_fw(const struct firmware *fw, void *context)
+{
+	int ret;
+
+	sst_dbg("called \n");
+	BUG_ON(!fw);
+
+	sst_reset();
+	/*putting the sst state to init*/
+	sst_ops->sst_state = SST_UN_INIT;
+
+	ret = sst_parse_fw_image(fw);
+	if (0 != ret) {
+		sst_err("error in FW dma\n");
+		return;
+	}
+	sst_ops->sst_state = SST_FW_LOADED;
+	/* 7. ask scu to reset the bypass bits*/
+	/*  8.bring sst out of reset */
+	sst_start();
+	sst_dbg("...successful!!!\n");
+	return;
+}
+
+int sst_download_library(const struct firmware *fw_lib,
+				struct snd_sst_lib_download_info *lib)
+{
+	/*send IPC message and wait*/
+	unsigned int i, pvt_id;
+	struct ipc_post *msg = NULL;
+	union config_status_reg csr;
+	struct snd_sst_str_type str_type = {0};
+	int retval = 0;
+
+	if (sst_create_large_msg(&msg) != 0)
+		return -ENOMEM;
+
+	pvt_id = sst_assign_pvt_id(sst_ops);
+	i = sst_get_block_stream(sst_ops);
+	sst_dbg("alloc block allocated = %d, pvt_id %d\n", i, pvt_id);
+	if (i < 0) {
+		kfree(msg);
+		return -ENOMEM;
+	}
+	sst_ops->alloc_block[i].sst_id = pvt_id;
+	sst_fill_header(&msg->header, IPC_IA_PREP_LIB_DNLD, 1, 0);
+	msg->header.part.data = sizeof(u32) + sizeof(str_type);
+	str_type.codec_type = lib->dload_lib.lib_info.lib_type;
+	str_type.pvt_id = pvt_id;
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &str_type, sizeof(str_type));
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	retval = sst_wait_timeout(sst_ops, &sst_ops->alloc_block[i]);
+	if (retval != 0) {
+		/*error*/
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_err("Prep codec downloaded failed %d\n", retval);
+		return -EIO;
+	}
+	sst_dbg("FW responded, ready for download now...\n");
+	/*downloading on success*/
+	sst_ops->sst_state = SST_FW_LOADED;
+	csr.full = readl(sst_ops->shim + SST_CSR);
+	sst_dbg("CSR reg 0x%x \n", csr.full);
+	csr.part.run_stall = 1;
+	writel(csr.full, sst_ops->shim + SST_ISRX);
+	sst_dbg("HALT CSR reg setting to 0x%x \n", csr.full);
+	retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR, csr.full);
+	if (retval != 0) {
+		/*error*/
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_err("IPC failed to Halt SST 0x%x\n", retval);
+		return -EAGAIN;
+	}
+	csr.full = readl(sst_ops->shim + SST_CSR);
+	csr.part.bypass = 0x7;
+	writel(csr.full, sst_ops->shim + SST_ISRX);
+	sst_dbg("Bypass CSR reg setting to 0x%x \n", csr.full);
+	retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR, csr.full);
+	if (retval != 0) {
+		/*error*/
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_err("IPC failed to Bypass SST 0x%x\n", retval);
+		csr.part.bypass = 0x0;
+		/*bring LPE out of run stall*/
+		csr.part.run_stall = 0x0;
+		writel(csr.full, sst_ops->shim + SST_ISRX);
+		sst_dbg("Bypass CSR reg setting to 0x%x \n", csr.full);
+		retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR,
+			       csr.full);
+		if (retval != 0)
+			sst_ops->sst_state = SST_UN_INIT;
+		return -EAGAIN;
+	}
+	sst_parse_fw_image(fw_lib);
+
+	/*set the FW to running again*/
+	csr.full = readl(sst_ops->shim + SST_CSR);
+	csr.part.bypass = 0x0;
+	writel(csr.full, sst_ops->shim + SST_ISRX);
+	sst_dbg("Bypass CSR reg clearing to 0x%x \n", csr.full);
+	retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR, csr.full);
+	if (retval != 0) {
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_err("Bypass CSR reg clear failed 0x%x \n", retval);
+		/*bring LPE out of run stall*/
+		csr.part.run_stall = 0x0;
+		writel(csr.full, sst_ops->shim + SST_ISRX);
+		sst_dbg("Bypass CSR reg setting to 0x%x \n", csr.full);
+		retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR,
+			       csr.full);
+		if (retval != 0)
+			sst_ops->sst_state = SST_UN_INIT;
+		return -EAGAIN;
+	}
+
+	csr.full = readl(sst_ops->shim + SST_CSR);
+	csr.part.run_stall = 0;
+	writel(csr.full, sst_ops->shim + SST_ISRX);
+	sst_dbg("Stalll CSR reg clearing to 0x%x \n", csr.full);
+	retval = sst_scu_ipc_write(sst_ops->shim_phy_add + SST_CSR, csr.full);
+	if (retval != 0) {
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_err("Stall CSR reg clear failed 0x%x \n", retval);
+		if (retval != 0)
+			sst_ops->sst_state = SST_UN_INIT;
+		return -EAGAIN;
+	}
+	/*send download complete and wait*/
+	if (sst_create_large_msg(&msg) != 0) {
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		return -ENOMEM;
+	}
+
+	sst_fill_header(&msg->header, IPC_IA_LIB_DNLD_CMPLT, 1, 0);
+	msg->header.part.data = sizeof(u32) + sizeof(*lib);
+	lib->pvt_id = pvt_id;
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), lib, sizeof(*lib));
+
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	sst_dbg("Waiting for FW to respond on Download complete \n");
+	sst_ops->alloc_block[i].ops_block.condition = false;
+	retval = sst_wait_timeout(sst_ops, &sst_ops->alloc_block[i]);
+	if (retval != 0) {
+		/*error*/
+		sst_ops->sst_state = SST_FW_RUNNING;
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		return -EIO;
+	}
+
+	sst_dbg("FW responded sucess on Download complete \n");
+	sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+	sst_ops->sst_state = SST_FW_RUNNING;
+	return 0;
+
+}
+
+int sst_validate_library(const struct firmware *fw_lib,
+		struct lib_slot_info *slot,
+		u32 *entry_point)
+{
+	struct fw_header *header = NULL;
+	struct fw_module_header *module = NULL;
+	struct dma_block_info *block = NULL;
+	unsigned int n_blk, isize = 0, dsize = 0;
+	int err = 0;
+
+	header = (struct fw_header *)fw_lib->data;
+	if (header->modules != 1) {
+		sst_err("Module no mismatch found\n");
+		err = -EINVAL;
+		goto exit;
+	}
+	module = (void *)fw_lib->data + sizeof(*header);
+	*entry_point = module->entry_point;
+	sst_dbg("Module entry point 0x%x \n", *entry_point);
+	sst_dbg("Module Sign %s, Size 0x%x, Blocks 0x%x Type 0x%x \n",
+		module->signature, module->mod_size,
+		module->blocks, module->type);
+
+	block = (void *)module + sizeof(*module);
+	for (n_blk = 0; n_blk < module->blocks; n_blk++) {
+		switch (block->type) {
+		case SST_IRAM:
+			isize += block->size;
+			break;
+		case SST_DRAM:
+			dsize += block->size;
+			break;
+		default:
+			sst_err("Invalid block type found for 0x%x\n", n_blk);
+			err = -EINVAL;
+			goto exit;
+		}
+		block = (void *)block + sizeof(*block) + block->size;
+	}
+	if (isize > slot->iram_size || dsize > slot->dram_size) {
+		sst_err("libarary exceeds size allocated \n");
+		err = -EINVAL;
+		goto exit;
+	} else
+		sst_dbg("Library is safe for download...\n");
+
+	sst_dbg("iram 0x%x, dram 0x%x, allowed iram 0x%x, allowed dram 0x%x\n",
+		isize, dsize, slot->iram_size, slot->dram_size);
+exit:
+	return err;
+
+}
+
+int sst_load_library(struct snd_sst_lib_download *lib, u8 ops, u32 pvt_id)
+{
+	char buf[20];
+	int len = 0, error = 0;
+	u32 entry_point;
+	const struct firmware *fw_lib;
+	struct snd_sst_lib_download_info dload_info = {{{0},},};
+
+	memset(buf, 0, sizeof(buf));
+
+	sst_dbg("Lib Type 0x%x, Slot 0x%x, ops 0x%x \n",
+			lib->lib_info.lib_type, lib->slot_info.slot_num, ops);
+	sst_dbg("Version 0x%x, name %s, caps 0x%x media type 0x%x \n",
+		lib->lib_info.lib_version, lib->lib_info.lib_name,
+		lib->lib_info.lib_caps, lib->lib_info.media_type);
+
+	sst_dbg("IRAM Size 0x%x, offset 0x%x, DRAM Size 0x%x, offset 0x%x \n",
+		lib->slot_info.iram_size, lib->slot_info.iram_offset,
+		lib->slot_info.dram_size, lib->slot_info.dram_offset);
+
+	switch (lib->lib_info.lib_type) {
+	case SST_CODEC_TYPE_MP3:
+		len += snprintf(buf + len, sizeof(buf) - len, "mp3_");
+		break;
+	case SST_CODEC_TYPE_AAC:
+		len += snprintf(buf + len, sizeof(buf) - len, "aac_");
+		break;
+	case SST_CODEC_TYPE_WMA9:
+		len += snprintf(buf + len, sizeof(buf) - len, "wma9_");
+		break;
+	default:
+		sst_err("Invalid codec type \n");
+		error = -EINVAL;
+		goto wake;
+	}
+
+	if (ops == STREAM_OPS_CAPTURE)
+		len += snprintf(buf + len, sizeof(buf) - len, "enc_");
+	else
+		len += snprintf(buf + len, sizeof(buf) - len, "dec_");
+
+	len += snprintf(buf + len, sizeof(buf) - len, "%d",
+			lib->slot_info.slot_num);
+	len += snprintf(buf + len, sizeof(buf) - len, ".bin");
+
+	sst_dbg("Requesting %s \n", buf);
+
+	error = request_firmware(&fw_lib, buf, &sst_ops->pci->dev);
+	if (0 != error) {
+		sst_err("library load failed %d \n", error);
+		goto wake;
+	}
+	error = sst_validate_library(fw_lib, &lib->slot_info, &entry_point);
+	if (0 != error) {
+		sst_err("validate lib failed %d \n", error);
+		goto wake_free;
+	}
+	lib->mod_entry_pt = entry_point;
+	memcpy(&dload_info.dload_lib, lib, sizeof(*lib));
+	error = sst_download_library(fw_lib, &dload_info);
+	if (0 != error) {
+		sst_err("download lib failed %d \n", error);
+		goto wake_free;
+	}
+	/*lib is downloaded and init send alloc again*/
+	sst_dbg("Library is downloaded now... \n");
+wake_free:
+	/*sst_wake_up_alloc_block(sst_ops, pvt_id, error, NULL);*/
+	release_firmware(fw_lib);
+wake:
+	return error;
+}
+
+/*fops Routines*/
+const struct file_operations intel_sst_fops = {
+	.owner = THIS_MODULE,
+	.open = intel_sst_open,
+	.release = intel_sst_release,
+	.read = intel_sst_read,
+	.write = intel_sst_write,
+	.ioctl = intel_sst_ioctl,
+	.mmap = intel_sst_mmap,
+	.aio_read = intel_sst_aio_read,
+	.aio_write = intel_sst_aio_write,
+};
+
+/*
+	ISR Routines
+*/
+/**
+* intel_sst_interrupt - Interrupt service routine for SST
+* @irq:		irq number of interrupt
+* @dev_id:	pointer to device structre
+*
+* This function is called by OS when SST device raises
+* an interrupt. This will be result of write in IPC register
+* Source can be busy or done interrupt
+*/
+static irqreturn_t intel_sst_interrupt(int irq, void *context)
+{
+	union interrupt_reg 	isr;
+	union ipc_header 	header;
+	union  interrupt_reg imr;
+	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
+	unsigned int size = 0;
+
+	/*Interrupt arrived, check src*/
+	isr.full = readl(drv->shim + SST_ISRX);
+	imr.full = readl(drv->shim + SST_IMRX);
+	if (1 == isr.part.busy_interrupt) {
+		header.full = readl(drv->shim + SST_IPCD);
+		if (1 == header.part.large)
+			size = header.part.data;
+		if (0 != (header.part.msg_id & REPLY_MSG)) {
+			sst_ops->ipc_process_msg.header = header;
+			memcpy_fromio(sst_ops->ipc_process_msg.mailbox,
+				drv->mailbox + SST_MAILBOX_RCV, size);
+			schedule_work(&sst_ops->ipc_process_msg.wq);
+		} else {
+			sst_ops->ipc_process_reply.header = header;
+			memcpy_fromio(sst_ops->ipc_process_reply.mailbox,
+				drv->mailbox + SST_MAILBOX_RCV, size);
+			schedule_work(&sst_ops->ipc_process_reply.wq);
+		}
+		/*mask busy inetrrupt*/
+		imr.part.busy_interrupt = 1;
+		writel(imr.full, drv->shim + SST_IMRX);
+
+	} else if (1 == isr.part.done_interrupt) {
+		/*Clear done bit*/
+		header.full = readl(drv->shim + SST_IPCX);
+		header.part.done = 0;
+		writel(header.full, drv->shim + SST_IPCX);
+		/* write 1 to clear status register*/;
+		isr.part.done_interrupt = 1;
+		writel(isr.full, drv->shim + SST_ISRX);
+		schedule_work(&sst_ops->ipc_post_msg.wq);
+	}
+	return IRQ_HANDLED;
+}
+
+
+/*
+	PCI Routines
+*/
+static struct pci_device_id intel_sst_ids[] = {
+	{ 0x8086, 0x080A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, intel_sst_ids);
+
+
+/*
+* intel_sst_probe - PCI probe function
+* @pci:	PCI device structure
+* @pci_id:	PCI device ID structure
+*
+* This function is called by OS when a device is found
+* This enables the device, interrupt etc
+*/
+static int __devinit intel_sst_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
+{
+	int ret = 0;
+	u32 bar = 0, size = 0;
+
+	/*Init the device*/
+	ret = pci_enable_device(pci);
+	if (0 != ret) {
+		sst_err("device cant be enabled\n");
+		return ret;
+	}
+	sst_ops->pci = pci;
+	/*map registers*/
+	/*SST Shim*/
+	bar = pci_resource_start(pci, 1);
+	size = pci_resource_len(pci, 1);
+	ret = pci_request_region(pci, 2, SST_DRV_NAME);
+	if (ret != 0)
+		goto err_1;
+	sst_ops->shim_phy_add = bar;
+	sst_ops->shim = ioremap_nocache(bar, size);
+	if (sst_ops->shim == NULL)
+		goto err_2;
+	sst_dbg("SST Shim 0x%x,Size 0x%x,Ptr %p \n", bar, size, sst_ops->shim);
+
+	/*Shared SRAM*/
+	bar = pci_resource_start(pci, 2);
+	size = pci_resource_len(pci, 2);
+	ret = pci_request_region(pci, 3, SST_DRV_NAME);
+	if (ret != 0)
+		goto err_2;
+	sst_ops->mailbox = ioremap_nocache(bar, size);
+	if (NULL == sst_ops->mailbox)
+		goto err_3;
+	sst_dbg("SRAM 0x%x, Size 0x%x, Ptr %p \n", bar, size, sst_ops->mailbox);
+
+	/* IRAM*/
+	bar = pci_resource_start(pci, 3);
+	size = pci_resource_len(pci, 3);
+	ret = pci_request_region(pci, 4, SST_DRV_NAME);
+	if (ret != 0)
+		goto err_3;
+	sst_ops->iram = ioremap_nocache(bar, size);
+	if (sst_ops->iram == NULL)
+		goto err_4;
+	sst_dbg("IRAM 0x%x, Size 0x%x, Ptr %p \n", bar, size, sst_ops->iram);
+
+	/*DRAM*/
+	bar = pci_resource_start(pci, 4);
+	size = pci_resource_len(pci, 4);
+	ret = pci_request_region(pci, 5, SST_DRV_NAME);
+	if (ret != 0)
+		goto err_4;
+	sst_ops->dram = ioremap_nocache(bar, size);
+	if (sst_ops->dram == NULL)
+		goto err_5;
+	sst_dbg("DRAM 0x%x, Size 0x%x, Ptr %p \n", bar, size, sst_ops->dram);
+
+	/*Register the ISR*/
+	ret = request_irq(pci->irq, intel_sst_interrupt,
+		IRQF_SHARED, SST_DRV_NAME, sst_ops);
+	if (0 != ret)
+		goto err_5;
+	sst_dbg("Registered IRQ 0x%x\n", pci->irq);
+	sst_ops->sst_state = SST_UN_INIT;
+
+	/* Register with /dev */
+	ret = register_chrdev(INTEL_SST_MAJOR, SST_DRV_NAME, &intel_sst_fops);
+	if (0 != ret) {
+		sst_err("couldn't register device number\n");
+		goto err_6;
+	}
+
+	sst_dbg("...successfully done!!!\n");
+	return 0;
+
+err_6:	free_irq(pci->irq, sst_ops);
+err_5:	iounmap(sst_ops->dram);
+err_4:	iounmap(sst_ops->iram);
+err_3:	iounmap(sst_ops->mailbox);
+err_2:	iounmap(sst_ops->shim);
+err_1:	sst_err("Probe failed with 0x%x \n", ret);
+	return ret;
+}
+
+/**
+* intel_sst_remove - PCI remove function
+* @pci:		PCI device structure
+*
+* This function is called by OS when a device is unloaded
+* This frees the interrupt etc
+*/
+static void __devexit intel_sst_remove(struct pci_dev *pci)
+{
+	sst_ops->sst_state = SST_UN_INIT;
+	unregister_chrdev(INTEL_SST_MAJOR, SST_DRV_NAME);
+	free_irq(pci->irq, sst_ops);
+	iounmap(sst_ops->dram);
+	iounmap(sst_ops->iram);
+	iounmap(sst_ops->mailbox);
+	iounmap(sst_ops->shim);
+}
+
+#ifdef CONFIG_SST_OSPM_SUPPORT
+/*
+	Power Management
+
+*/
+/**
+* intel_sst_suspend - PCI suspend function
+* @pci:		PCI device structure
+* @state:	PM message
+*
+* This function is called by OS when a power event occurs
+*/
+static int intel_sst_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	int i = 0;
+	sst_dbg("intel_sst_suspend called\n");
+
+	/*Pause all running streams*/
+	for (i = 1; i < MAX_NUM_STREAMS; i++) {
+		if (sst_ops->streams[i].status == STREAM_RUNNING) {
+			sst_ops->active_streams[i] = true;
+			sst_pause_stream(i);
+		} else
+			sst_ops->active_streams[i] = false;
+	}
+
+	pci_set_drvdata(pci, sst_ops);
+
+	/*Disable everything*/
+	/*free_irq(pci->irq, sst_ops);*/
+	pci_disable_device(pci);
+	pci_save_state(pci);
+	pci_set_power_state(pci, pci_choose_state(pci, state));
+	return 0;
+}
+
+/**
+* intel_sst_resume - PCI resume function
+* @pci:		PCI device structure
+* @state:	PM message
+*
+* This function is called by OS when a power event occurs
+*/
+static int intel_sst_resume(struct pci_dev *pci)
+{
+	int i = 0;
+
+	sst_dbg("\nintel_sst_resume called\n");
+	if (pci != NULL)
+		sst_dbg("pci is not null \n");
+	/*Enable*/
+	sst_ops = pci_get_drvdata(pci);
+	if (sst_ops != NULL)
+		sst_dbg("sst_ops is not null\n");
+	if (pci->irq)
+		sst_dbg("irq %d \n", pci->irq);
+
+	pci_set_power_state(pci, PCI_D0);
+	pci_restore_state(pci);
+
+	/*ret = request_irq(pci->irq, intel_sst_interrupt,
+		IRQF_SHARED, "intel_sst_engine", sst_ops);
+	if (0 != ret) {
+		sst_err("\tIRQ %d reg error %d\n", pci->irq, ret);
+		return ret;
+	}*/
+
+	/*Start all paused streams*/
+	for (i = 1; i < MAX_NUM_STREAMS; i++) {
+		if (sst_ops->active_streams[i] == true)
+			sst_resume_stream(i);
+	}
+	return 0;
+}
+/**
+* sst_ospm_send_event - Send PM events to OSPM
+* @event:	OSPM Event
+*
+* This function is called when stream is started/stopped/paused...
+*/
+int sst_ospm_send_event(int event)
+{
+	return ospm_generate_netlink_event(AUDIO_SUBSYTEM_ID, event);
+
+}
+#endif /* CONFIG_SST_OSPM_SUPPORT */
+static struct pci_driver driver = {
+	.name = SST_DRV_NAME,
+	.id_table = intel_sst_ids,
+	.probe = intel_sst_probe,
+	.remove = __devexit_p(intel_sst_remove),
+#ifdef CONFIG_SST_OSPM_SUPPORT
+	.suspend = intel_sst_suspend,
+	.resume = intel_sst_resume,
+#endif
+};
+
+/**
+* intel_sst_init - Module init function
+*
+* Registers with PCI
+* Registers with /dev
+*Init all data strutures
+*/
+/*Module init function*/
+static int __init intel_sst_init(void)
+{
+	/*
+	Init all variables, data structure etc....
+	*/
+	int ret = 0, i = 0;
+	struct stream_info *stream = NULL;
+
+	sst_info("******** SST DRIVER loading.. Ver: %s\n", SST_DRIVER_VERSION);
+
+	sst_ops = kzalloc(sizeof(*sst_ops), GFP_KERNEL);
+	if (NULL == sst_ops) {
+		sst_err("intel_sst malloc fail\n");
+		return -ENOMEM;
+	}
+
+	sst_ops->pmic_state = PMIC_SND_UN_INIT;
+	sst_ops->stream_cnt = 0;
+	sst_ops->active_cnt = 0;
+	sst_ops->am_cnt = 0;
+	sst_ops->unique_id = 0;
+
+	INIT_LIST_HEAD(&sst_ops->ipc_dispatch_list);
+	INIT_WORK(&sst_ops->ipc_post_msg.wq, sst_post_message);
+	INIT_WORK(&sst_ops->ipc_process_msg.wq, sst_process_message);
+	INIT_WORK(&sst_ops->ipc_process_reply.wq, sst_process_reply);
+	init_waitqueue_head(&sst_ops->wait_queue);
+
+	for (i = 0; i < MAX_ACTIVE_STREAM; i++) {
+		sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_ops->alloc_block[i].ops_block.condition = false;
+	}
+	mutex_init(&sst_ops->list_lock);
+
+	for (i = 1; i < MAX_NUM_STREAMS; i++) {
+		stream = &sst_ops->streams[i];
+		INIT_LIST_HEAD(&stream->bufs);
+		mutex_init(&stream->lock);
+	}
+	sst_ops->mmap_mem = NULL;
+	sst_ops->mmap_len = SST_MMAP_PAGES * PAGE_SIZE;
+	while (sst_ops->mmap_len > 0) {
+		sst_ops->mmap_mem = kzalloc(sst_ops->mmap_len, GFP_KERNEL);
+		if (sst_ops->mmap_mem != NULL) {
+			sst_dbg("Got memory %p size 0x%x \n", sst_ops->mmap_mem,
+					sst_ops->mmap_len);
+			break;
+		}
+		sst_ops->mmap_len -= (SST_MMAP_STEP * PAGE_SIZE);
+		if (sst_ops->mmap_len <= 0) {
+			sst_err("Couldnt get any mem...abort!!\n");
+			goto exit_p;
+		}
+		sst_dbg("Failed...trying %d\n", sst_ops->mmap_len);
+	}
+	/* Register with PCI */
+	ret = pci_register_driver(&driver);
+	if (0 != ret) {
+		sst_err("PCI register failed, unregister char drv\n");
+		goto exit;
+	}
+
+
+
+	sst_dbg("...sucessful\n");
+	return 0;
+
+exit:
+	pci_unregister_driver(&driver);
+exit_p:
+	kfree(sst_ops->mmap_mem);
+	kfree(sst_ops);
+	sst_err("Error in init %d\n", ret);
+
+	return ret;
+}
+
+/*Module exit function*/
+static void __exit intel_sst_exit(void)
+{
+	int i;
+	struct stream_info *stream = NULL;
+
+	for (i = 0; i < MAX_NUM_STREAMS; i++) {
+		stream = &sst_ops->streams[i];
+		sst_free_stream(i);
+	}
+	sst_ops->pmic_state = PMIC_SND_UN_INIT;
+	pci_unregister_driver(&driver);
+
+	flush_scheduled_work();
+	kfree(sst_ops->mmap_mem);
+	kfree(sst_ops);
+
+	sst_dbg("...unloaded\n");
+	return;
+}
+
+module_init(intel_sst_init);
+module_exit(intel_sst_exit);
-- 
1.5.4.5
