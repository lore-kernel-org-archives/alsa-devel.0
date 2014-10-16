From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 1/7] ASoC: Intel: mrfld - add the dsp sst
	driver
Date: Thu, 16 Oct 2014 20:00:13 +0530
Message-ID: <1413469819-18775-2-git-send-email-vinod.koul@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D0552261B0E
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 17:06:46 +0200 (CEST)
In-Reply-To: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The SST driver is the missing piece in our driver stack not upstreamed,
so push it now :) This driver currently supports PCI device on Merrifield.
Future updates will bring support for ACPI device as well as future update
to PCI devices as well

In subsequent patches support is added for DSP loading using memcpy,
pcm operations and compressed ops.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 arch/x86/include/asm/platform_sst_audio.h |   34 ++
 sound/soc/intel/sst/sst.c                 |  434 +++++++++++++++++++++++
 sound/soc/intel/sst/sst.h                 |  539 +++++++++++++++++++++++++++++
 3 files changed, 1007 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 0a4e140..268a96a 100644
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
@@ -73,6 +76,37 @@ struct sst_platform_data {
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
+
+struct sst_platform_info {
+	const struct sst_info *probe_data;
+	const struct sst_ipc_info *ipc_info;
+	const struct sst_lib_dnld_info *lib_info;
+};
 int add_sst_platform_device(void);
 #endif
 
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
new file mode 100644
index 0000000..d88cdd9
--- /dev/null
+++ b/sound/soc/intel/sst/sst.c
@@ -0,0 +1,434 @@
+/*
+ *  sst.c - Intel SST Driver for audio engine
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
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
+#include <linux/async.h>
+#include <linux/delay.h>
+#include <linux/acpi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <asm/intel-mid.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+#include "../sst-dsp.h"
+
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine Driver");
+MODULE_LICENSE("GPL v2");
+
+static inline bool sst_is_process_reply(u32 msg_id)
+{
+	return ((msg_id & PROCESS_MSG) ? true : false);
+}
+
+static inline bool sst_validate_mailbox_size(unsigned int size)
+{
+	return ((size <= SST_MAILBOX_SIZE) ? true : false);
+}
+
+static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
+{
+	union interrupt_reg_mrfld isr;
+	union ipc_header_mrfld header;
+	union sst_imr_reg_mrfld imr;
+	struct ipc_post *msg = NULL;
+	unsigned int size = 0;
+	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
+	irqreturn_t retval = IRQ_HANDLED;
+
+	/* Interrupt arrived, check src */
+	isr.full = sst_shim_read64(drv->shim, SST_ISRX);
+
+	if (isr.part.done_interrupt) {
+		/* Clear done bit */
+		spin_lock(&drv->ipc_spin_lock);
+		header.full = sst_shim_read64(drv->shim,
+					drv->ipc_reg.ipcx);
+		header.p.header_high.part.done = 0;
+		sst_shim_write64(drv->shim, drv->ipc_reg.ipcx, header.full);
+
+		/* write 1 to clear status register */;
+		isr.part.done_interrupt = 1;
+		sst_shim_write64(drv->shim, SST_ISRX, isr.full);
+		spin_unlock(&drv->ipc_spin_lock);
+
+		/* we can send more messages to DSP so trigger work */
+		queue_work(drv->post_msg_wq, &drv->ipc_post_msg_wq);
+		retval = IRQ_HANDLED;
+	}
+
+	if (isr.part.busy_interrupt) {
+		/* message from dsp so copy that */
+		spin_lock(&drv->ipc_spin_lock);
+		imr.full = sst_shim_read64(drv->shim, SST_IMRX);
+		imr.part.busy_interrupt = 1;
+		sst_shim_write64(drv->shim, SST_IMRX, imr.full);
+		spin_unlock(&drv->ipc_spin_lock);
+		header.full =  sst_shim_read64(drv->shim, drv->ipc_reg.ipcd);
+
+		if (sst_create_ipc_msg(&msg, header.p.header_high.part.large)) {
+			drv->ops->clear_interrupt(drv);
+			return IRQ_HANDLED;
+		}
+
+		if (header.p.header_high.part.large) {
+			size = header.p.header_low_payload;
+			if (sst_validate_mailbox_size(size)) {
+				memcpy_fromio(msg->mailbox_data,
+					drv->mailbox + drv->mailbox_recv_offset, size);
+			} else {
+				dev_err(drv->dev,
+					"Mailbox not copied, payload size is: %u\n", size);
+				header.p.header_low_payload = 0;
+			}
+		}
+
+		msg->mrfld_header = header;
+		msg->is_process_reply =
+			sst_is_process_reply(header.p.header_high.part.msg_id);
+		spin_lock(&drv->rx_msg_lock);
+		list_add_tail(&msg->node, &drv->rx_list);
+		spin_unlock(&drv->rx_msg_lock);
+		drv->ops->clear_interrupt(drv);
+		retval = IRQ_WAKE_THREAD;
+	}
+	return retval;
+}
+
+static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
+{
+	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
+	struct ipc_post *__msg, *msg = NULL;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
+	if (list_empty(&drv->rx_list)) {
+		spin_unlock_irqrestore(&drv->rx_msg_lock, irq_flags);
+		return IRQ_HANDLED;
+	}
+
+	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {
+		list_del(&msg->node);
+		spin_unlock_irqrestore(&drv->rx_msg_lock, irq_flags);
+		if (msg->is_process_reply)
+			drv->ops->process_message(msg);
+		else
+			drv->ops->process_reply(drv, msg);
+
+		if (msg->is_large)
+			kfree(msg->mailbox_data);
+		kfree(msg);
+		spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
+	}
+	spin_unlock_irqrestore(&drv->rx_msg_lock, irq_flags);
+	return IRQ_HANDLED;
+}
+
+static struct intel_sst_ops mrfld_ops = {
+	.interrupt = intel_sst_interrupt_mrfld,
+	.irq_thread = intel_sst_irq_thread_mrfld,
+	.clear_interrupt = intel_sst_clear_intr_mrfld,
+	.start = sst_start_mrfld,
+	.reset = intel_sst_reset_dsp_mrfld,
+	.post_message = sst_post_message_mrfld,
+	.process_reply = sst_process_reply_mrfld,
+	.alloc_stream = sst_alloc_stream_mrfld,
+	.post_download = sst_post_download_mrfld,
+};
+
+int sst_driver_ops(struct intel_sst_drv *sst)
+{
+
+	switch (sst->pci_id) {
+	case SST_MRFLD_PCI_ID:
+		sst->tstamp = SST_TIME_STAMP_MRFLD;
+		sst->ops = &mrfld_ops;
+		return 0;
+
+	default:
+		dev_err(sst->dev,
+			"SST Driver capablities missing for pci_id: %x", sst->pci_id);
+		return -EINVAL;
+	};
+}
+
+void sst_process_pending_msg(struct work_struct *work)
+{
+	struct intel_sst_drv *ctx = container_of(work,
+			struct intel_sst_drv, ipc_post_msg_wq);
+
+	ctx->ops->post_message(ctx, NULL, false);
+}
+
+/*
+* intel_sst_probe - PCI probe function
+*
+* @pci:	PCI device structure
+* @pci_id: PCI device ID structure
+*
+*/
+static int intel_sst_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
+{
+	int i, ret = 0;
+	struct intel_sst_drv *sst_drv_ctx;
+	struct intel_sst_ops *ops;
+	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
+	int ddr_base;
+
+	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
+	sst_drv_ctx = devm_kzalloc(&pci->dev, sizeof(*sst_drv_ctx), GFP_KERNEL);
+	if (!sst_drv_ctx)
+		return -ENOMEM;
+
+	sst_drv_ctx->dev = &pci->dev;
+	sst_drv_ctx->pci_id = pci->device;
+	if (!sst_pdata)
+		return -EINVAL;
+
+	sst_drv_ctx->pdata = sst_pdata;
+	if (!sst_drv_ctx->pdata->probe_data)
+		return -EINVAL;
+
+	memcpy(&sst_drv_ctx->info, sst_drv_ctx->pdata->probe_data,
+					sizeof(sst_drv_ctx->info));
+
+	if (0 != sst_driver_ops(sst_drv_ctx))
+		return -EINVAL;
+
+	ops = sst_drv_ctx->ops;
+	mutex_init(&sst_drv_ctx->sst_lock);
+
+	/* pvt_id 0 reserved for async messages */
+	sst_drv_ctx->pvt_id = 1;
+	sst_drv_ctx->stream_cnt = 0;
+	sst_drv_ctx->fw_in_mem = NULL;
+
+	/* we use memcpy, so set to 0 */
+	sst_drv_ctx->use_dma = 0;
+	sst_drv_ctx->use_lli = 0;
+
+	INIT_LIST_HEAD(&sst_drv_ctx->memcpy_list);
+	INIT_LIST_HEAD(&sst_drv_ctx->ipc_dispatch_list);
+	INIT_LIST_HEAD(&sst_drv_ctx->block_list);
+	INIT_LIST_HEAD(&sst_drv_ctx->rx_list);
+
+	sst_drv_ctx->post_msg_wq =
+		create_singlethread_workqueue("sst_post_msg_wq");
+	if (!sst_drv_ctx->post_msg_wq) {
+		ret = -EINVAL;
+		goto do_free_drv_ctx;
+	}
+	INIT_WORK(&sst_drv_ctx->ipc_post_msg_wq, sst_process_pending_msg);
+	init_waitqueue_head(&sst_drv_ctx->wait_queue);
+
+	spin_lock_init(&sst_drv_ctx->ipc_spin_lock);
+	spin_lock_init(&sst_drv_ctx->block_lock);
+	spin_lock_init(&sst_drv_ctx->rx_msg_lock);
+
+	dev_info(sst_drv_ctx->dev, "Got drv data max stream %d\n",
+				sst_drv_ctx->info.max_streams);
+	for (i = 1; i <= sst_drv_ctx->info.max_streams; i++) {
+		struct stream_info *stream = &sst_drv_ctx->streams[i];
+
+		memset(stream, 0, sizeof(*stream));
+		stream->pipe_id = PIPE_RSVD;
+		mutex_init(&stream->lock);
+	}
+
+	/* Init the device */
+	ret = pcim_enable_device(pci);
+	if (ret) {
+		dev_err(sst_drv_ctx->dev,
+			"device can't be enabled. Returned err: %d\n", ret);
+		goto do_free_mem;
+	}
+	sst_drv_ctx->pci = pci_dev_get(pci);
+	ret = pci_request_regions(pci, SST_DRV_NAME);
+	if (ret)
+		goto do_free_mem;
+
+	/* map registers */
+	/* DDR base */
+	if (sst_drv_ctx->pci_id == SST_MRFLD_PCI_ID) {
+		sst_drv_ctx->ddr_base = pci_resource_start(pci, 0);
+		/* check that the relocated IMR base matches with FW Binary */
+		ddr_base = relocate_imr_addr_mrfld(sst_drv_ctx->ddr_base);
+		if (!sst_drv_ctx->pdata->lib_info) {
+			dev_err(sst_drv_ctx->dev, "lib_info pointer NULL\n");
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		if (ddr_base != sst_drv_ctx->pdata->lib_info->mod_base) {
+			dev_err(sst_drv_ctx->dev,
+					"FW LSP DDR BASE does not match with IFWI\n");
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		sst_drv_ctx->ddr_end = pci_resource_end(pci, 0);
+
+		sst_drv_ctx->ddr = pcim_iomap(pci, 0,
+					pci_resource_len(pci, 0));
+		if (!sst_drv_ctx->ddr) {
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		dev_dbg(sst_drv_ctx->dev, "sst: DDR Ptr %p\n", sst_drv_ctx->ddr);
+	} else {
+		sst_drv_ctx->ddr = NULL;
+	}
+
+	/* SHIM */
+	sst_drv_ctx->shim_phy_add = pci_resource_start(pci, 1);
+	sst_drv_ctx->shim = pcim_iomap(pci, 1, pci_resource_len(pci, 1));
+	if (!sst_drv_ctx->shim) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(sst_drv_ctx->dev, "SST Shim Ptr %p\n", sst_drv_ctx->shim);
+
+	/* Shared SRAM */
+	sst_drv_ctx->mailbox_add = pci_resource_start(pci, 2);
+	sst_drv_ctx->mailbox = pcim_iomap(pci, 2, pci_resource_len(pci, 2));
+	if (!sst_drv_ctx->mailbox) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(sst_drv_ctx->dev, "SRAM Ptr %p\n", sst_drv_ctx->mailbox);
+
+	/* IRAM */
+	sst_drv_ctx->iram_end = pci_resource_end(pci, 3);
+	sst_drv_ctx->iram_base = pci_resource_start(pci, 3);
+	sst_drv_ctx->iram = pcim_iomap(pci, 3, pci_resource_len(pci, 3));
+	if (!sst_drv_ctx->iram) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(sst_drv_ctx->dev, "IRAM Ptr %p\n", sst_drv_ctx->iram);
+
+	/* DRAM */
+	sst_drv_ctx->dram_end = pci_resource_end(pci, 4);
+	sst_drv_ctx->dram_base = pci_resource_start(pci, 4);
+	sst_drv_ctx->dram = pcim_iomap(pci, 4, pci_resource_len(pci, 4));
+	if (!sst_drv_ctx->dram) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(sst_drv_ctx->dev, "DRAM Ptr %p\n", sst_drv_ctx->dram);
+
+
+	sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
+	sst_drv_ctx->irq_num = pci->irq;
+	/* Register the ISR */
+	ret = devm_request_threaded_irq(&pci->dev, pci->irq,
+		sst_drv_ctx->ops->interrupt,
+		sst_drv_ctx->ops->irq_thread, 0, SST_DRV_NAME,
+		sst_drv_ctx);
+	if (ret)
+		goto do_release_regions;
+	dev_dbg(sst_drv_ctx->dev, "Registered IRQ 0x%x\n", pci->irq);
+
+	/* default intr are unmasked so set this as masked */
+	if (sst_drv_ctx->pci_id == SST_MRFLD_PCI_ID)
+		sst_shim_write64(sst_drv_ctx->shim, SST_IMRX, 0xFFFF0038);
+
+	pci_set_drvdata(pci, sst_drv_ctx);
+	pm_runtime_set_autosuspend_delay(sst_drv_ctx->dev, SST_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(sst_drv_ctx->dev);
+	pm_runtime_allow(sst_drv_ctx->dev);
+	pm_runtime_put_noidle(sst_drv_ctx->dev);
+	sst_register(sst_drv_ctx->dev);
+	sst_drv_ctx->qos = devm_kzalloc(&pci->dev,
+		sizeof(struct pm_qos_request), GFP_KERNEL);
+	if (!sst_drv_ctx->qos) {
+		ret = -ENOMEM;
+		goto do_release_regions;
+	}
+	pm_qos_add_request(sst_drv_ctx->qos, PM_QOS_CPU_DMA_LATENCY,
+				PM_QOS_DEFAULT_VALUE);
+
+	return ret;
+
+do_release_regions:
+	pci_release_regions(pci);
+do_free_mem:
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+do_free_drv_ctx:
+	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
+	return ret;
+}
+
+/**
+* intel_sst_remove - PCI remove function
+*
+* @pci:	PCI device structure
+*
+* This function is called by OS when a device is unloaded
+* This frees the interrupt etc
+*/
+static void intel_sst_remove(struct pci_dev *pci)
+{
+	struct intel_sst_drv *sst_drv_ctx = pci_get_drvdata(pci);
+
+	pm_runtime_get_noresume(sst_drv_ctx->dev);
+	pm_runtime_forbid(sst_drv_ctx->dev);
+	sst_unregister(sst_drv_ctx->dev);
+	pci_dev_put(sst_drv_ctx->pci);
+	sst_set_fw_state_locked(sst_drv_ctx, SST_SHUTDOWN);
+
+	flush_scheduled_work();
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+	pm_qos_remove_request(sst_drv_ctx->qos);
+	kfree(sst_drv_ctx->fw_sg_list.src);
+	kfree(sst_drv_ctx->fw_sg_list.dst);
+	sst_drv_ctx->fw_sg_list.list_len = 0;
+	kfree(sst_drv_ctx->fw_in_mem);
+	sst_drv_ctx->fw_in_mem = NULL;
+	sst_memcpy_free_resources(sst_drv_ctx);
+	sst_drv_ctx = NULL;
+	pci_release_regions(pci);
+	pci_set_drvdata(pci, NULL);
+}
+
+/* PCI Routines */
+static struct pci_device_id intel_sst_ids[] = {
+	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
+	{ 0, }
+};
+
+static struct pci_driver sst_driver = {
+	.name = SST_DRV_NAME,
+	.id_table = intel_sst_ids,
+	.probe = intel_sst_probe,
+	.remove = intel_sst_remove,
+};
+
+module_pci_driver(sst_driver);
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
new file mode 100644
index 0000000..bfcf51a
--- /dev/null
+++ b/sound/soc/intel/sst/sst.h
@@ -0,0 +1,539 @@
+/*
+ *  sst.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-14 Intel Corporation
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
+ *  Common private declarations for SST
+ */
+#ifndef __SST_H__
+#define __SST_H__
+
+#include <linux/firmware.h>
+
+/* driver names */
+#define SST_DRV_NAME "intel_sst_driver"
+#define SST_MRFLD_PCI_ID 0x119A
+
+#define SST_SUSPEND_DELAY 2000
+#define FW_CONTEXT_MEM (64*1024)
+#define SST_ICCM_BOUNDARY 4
+#define SST_CONFIG_SSP_SIGN 0x7ffe8001
+
+#define MRFLD_FW_VIRTUAL_BASE 0xC0000000
+#define MRFLD_FW_DDR_BASE_OFFSET 0x0
+#define MRFLD_FW_FEATURE_BASE_OFFSET 0x4
+#define MRFLD_FW_BSS_RESET_BIT 0
+
+enum sst_states {
+	SST_FW_LOADING = 1,
+	SST_FW_RUNNING,
+	SST_RESET,
+	SST_SHUTDOWN,
+};
+
+enum sst_algo_ops {
+	SST_SET_ALGO = 0,
+	SST_GET_ALGO = 1,
+};
+
+#define SST_BLOCK_TIMEOUT	1000
+
+#define FW_SIGNATURE_SIZE	4
+
+/* stream states */
+enum sst_stream_states {
+	STREAM_UN_INIT	= 0,	/* Freed/Not used stream */
+	STREAM_RUNNING	= 1,	/* Running */
+	STREAM_PAUSED	= 2,	/* Paused stream */
+	STREAM_DECODE	= 3,	/* stream is in decoding only state */
+	STREAM_INIT	= 4,	/* stream init, waiting for data */
+	STREAM_RESET	= 5,	/* force reset on recovery */
+};
+
+enum sst_ram_type {
+	SST_IRAM	= 1,
+	SST_DRAM	= 2,
+	SST_DDR	= 5,
+	SST_CUSTOM_INFO	= 7,	/* consists of FW binary information */
+};
+
+/* SST shim registers to structure mapping */
+union interrupt_reg {
+	struct {
+		u64 done_interrupt:1;
+		u64 busy_interrupt:1;
+		u64 rsvd:62;
+	} part;
+	u64 full;
+};
+
+union sst_pisr_reg {
+	struct {
+		u32 pssp0:1;
+		u32 pssp1:1;
+		u32 rsvd0:3;
+		u32 dmac:1;
+		u32 rsvd1:26;
+	} part;
+	u32 full;
+};
+
+union sst_pimr_reg {
+	struct {
+		u32 ssp0:1;
+		u32 ssp1:1;
+		u32 rsvd0:3;
+		u32 dmac:1;
+		u32 rsvd1:10;
+		u32 ssp0_sc:1;
+		u32 ssp1_sc:1;
+		u32 rsvd2:3;
+		u32 dmac_sc:1;
+		u32 rsvd3:10;
+	} part;
+	u32 full;
+};
+
+union config_status_reg_mrfld {
+	struct {
+		u64 lpe_reset:1;
+		u64 lpe_reset_vector:1;
+		u64 runstall:1;
+		u64 pwaitmode:1;
+		u64 clk_sel:3;
+		u64 rsvd2:1;
+		u64 sst_clk:3;
+		u64 xt_snoop:1;
+		u64 rsvd3:4;
+		u64 clk_sel1:6;
+		u64 clk_enable:3;
+		u64 rsvd4:6;
+		u64 slim0baseclk:1;
+		u64 rsvd:32;
+	} part;
+	u64 full;
+};
+
+union interrupt_reg_mrfld {
+	struct {
+		u64 done_interrupt:1;
+		u64 busy_interrupt:1;
+		u64 rsvd:62;
+	} part;
+	u64 full;
+};
+
+union sst_imr_reg_mrfld {
+	struct {
+		u64 done_interrupt:1;
+		u64 busy_interrupt:1;
+		u64 rsvd:62;
+	} part;
+	u64 full;
+};
+
+/**
+ * struct sst_block - This structure is used to block a user/fw data call to another
+ * fw/user call
+ *
+ * @condition: condition for blocking check
+ * @ret_code: ret code when block is released
+ * @data: data ptr
+ * @size: size of data
+ * @on: block condition
+ * @msg_id: msg_id = msgid in mfld/ctp, mrfld = NULL
+ * @drv_id: str_id in mfld/ctp, = drv_id in mrfld
+ * @node: list head node
+ */
+struct sst_block {
+	bool	condition;
+	int	ret_code;
+	void	*data;
+	u32     size;
+	bool	on;
+	u32     msg_id;
+	u32     drv_id;
+	struct list_head node;
+};
+
+/**
+ * struct stream_info - structure that holds the stream information
+ *
+ * @status : stream current state
+ * @prev : stream prev state
+ * @ops : stream operation pb/cp/drm...
+ * @bufs: stream buffer list
+ * @lock : stream mutex for protecting state
+ * @pcm_substream : PCM substream
+ * @period_elapsed : PCM period elapsed callback
+ * @sfreq : stream sampling freq
+ * @str_type : stream type
+ * @cumm_bytes : cummulative bytes decoded
+ * @str_type : stream type
+ * @src : stream source
+ */
+struct stream_info {
+	unsigned int		status;
+	unsigned int		prev;
+	unsigned int		ops;
+	struct mutex		lock;
+
+	void			*pcm_substream;
+	void (*period_elapsed)(void *pcm_substream);
+
+	unsigned int		sfreq;
+	u32			cumm_bytes;
+
+	void			*compr_cb_param;
+	void (*compr_cb)(void *compr_cb_param);
+
+	void			*drain_cb_param;
+	void (*drain_notify)(void *drain_cb_param);
+
+	unsigned int		num_ch;
+	unsigned int		pipe_id;
+	unsigned int		str_id;
+	unsigned int		task_id;
+};
+
+#define SST_FW_SIGN "$SST"
+#define SST_FW_LIB_SIGN "$LIB"
+
+/**
+ * struct sst_fw_header - FW file headers
+ *
+ * @signature : FW signature
+ * @file_size: size of fw image
+ * @modules : # of modules
+ * @file_format : version of header format
+ * @reserved : reserved fields
+ */
+struct sst_fw_header {
+	unsigned char signature[FW_SIGNATURE_SIZE];
+	u32 file_size;
+	u32 modules;
+	u32 file_format;
+	u32 reserved[4];
+};
+
+/**
+ * struct fw_module_header - module header in FW
+ *
+ * @signature: module signature
+ * @mod_size: size of module
+ * @blocks: block count
+ * @type: block type
+ * @entry_point: module netry point
+ */
+struct fw_module_header {
+	unsigned char signature[FW_SIGNATURE_SIZE];
+	u32 mod_size;
+	u32 blocks;
+	u32 type;
+	u32 entry_point;
+};
+
+/**
+ * struct fw_block_info - block header for FW
+ *
+ * @type: block ram type I/D
+ * @size: size of block
+ * @ram_offset: offset in ram
+ */
+struct fw_block_info {
+	enum sst_ram_type	type;
+	u32			size;
+	u32			ram_offset;
+	u32			rsvd;
+};
+
+struct sst_runtime_param {
+	struct snd_sst_runtime_params param;
+};
+
+struct sst_sg_list {
+	struct scatterlist *src;
+	struct scatterlist *dst;
+	int list_len;
+	unsigned int sg_idx;
+};
+
+struct sst_memcpy_list {
+	struct list_head memcpylist;
+	void *dstn;
+	const void *src;
+	u32 size;
+	bool is_io;
+};
+
+/*Firmware Module Information*/
+enum sst_lib_dwnld_status {
+	SST_LIB_NOT_FOUND = 0,
+	SST_LIB_FOUND,
+	SST_LIB_DOWNLOADED,
+};
+
+struct sst_module_info {
+	const char *name; /*Library name*/
+	u32	id; /*Module ID*/
+	u32	entry_pt; /*Module entry point*/
+	u8	status; /*module status*/
+	u8	rsvd1;
+	u16	rsvd2;
+};
+
+/*
+ * Structure for managing the Library Region(1.5MB)
+ * in DDR in Merrifield
+ */
+struct sst_mem_mgr {
+	phys_addr_t current_base;
+	int avail;
+	unsigned int count;
+};
+
+struct sst_ipc_reg {
+	int ipcx;
+	int ipcd;
+};
+
+struct sst_shim_regs64 {
+	u64 csr;
+	u64 pisr;
+	u64 pimr;
+	u64 isrx;
+	u64 isrd;
+	u64 imrx;
+	u64 imrd;
+	u64 ipcx;
+	u64 ipcd;
+	u64 isrsc;
+	u64 isrlpesc;
+	u64 imrsc;
+	u64 imrlpesc;
+	u64 ipcsc;
+	u64 ipclpesc;
+	u64 clkctl;
+	u64 csr2;
+};
+
+/**
+ * struct intel_sst_drv - driver ops
+ *
+ * @sst_state : current sst device state
+ * @pci_id : PCI device id loaded
+ * @shim : SST shim pointer
+ * @mailbox : SST mailbox pointer
+ * @iram : SST IRAM pointer
+ * @dram : SST DRAM pointer
+ * @pdata : SST info passed as a part of pci platform data
+ * @shim_phy_add : SST shim phy addr
+ * @shim_regs64: Struct to save shim registers
+ * @ipc_dispatch_list : ipc messages dispatched
+ * @rx_list : to copy the process_reply/process_msg from DSP
+ * @ipc_post_msg_wq : wq to post IPC messages context
+ * @mad_ops : MAD driver operations registered
+ * @mad_wq : MAD driver wq
+ * @post_msg_wq : wq to post IPC messages
+ * @streams : sst stream contexts
+ * @list_lock : sst driver list lock (deprecated)
+ * @ipc_spin_lock : spin lock to handle audio shim access and ipc queue
+ * @block_lock : spin lock to add block to block_list and assign pvt_id
+ * @rx_msg_lock : spin lock to handle the rx messages from the DSP
+ * @scard_ops : sst card ops
+ * @pci : sst pci device struture
+ * @dev : pointer to current device struct
+ * @sst_lock : sst device lock
+ * @pvt_id : sst private id
+ * @stream_cnt : total sst active stream count
+ * @pb_streams : total active pb streams
+ * @cp_streams : total active cp streams
+ * @audio_start : audio status
+ * @qos		: PM Qos struct
+ * firmware_name : Firmware / Library name
+ */
+struct intel_sst_drv {
+	int			sst_state;
+	int			irq_num;
+	unsigned int		pci_id;
+	void __iomem		*ddr;
+	void __iomem		*shim;
+	void __iomem		*mailbox;
+	void __iomem		*iram;
+	void __iomem		*dram;
+	unsigned int		mailbox_add;
+	unsigned int		iram_base;
+	unsigned int		dram_base;
+	unsigned int		shim_phy_add;
+	unsigned int		iram_end;
+	unsigned int		dram_end;
+	unsigned int		ddr_end;
+	unsigned int		ddr_base;
+	unsigned int		mailbox_recv_offset;
+	struct sst_shim_regs64	*shim_regs64;
+	struct list_head        block_list;
+	struct list_head	ipc_dispatch_list;
+	struct sst_platform_info *pdata;
+	struct list_head	rx_list;
+	struct work_struct      ipc_post_msg_wq;
+	wait_queue_head_t	wait_queue;
+	struct workqueue_struct *post_msg_wq;
+	unsigned int		tstamp;
+	/* str_id 0 is not used */
+	struct stream_info	streams[MAX_NUM_STREAMS+1];
+	spinlock_t		ipc_spin_lock;
+	spinlock_t              block_lock;
+	spinlock_t		rx_msg_lock;
+	struct pci_dev		*pci;
+	struct device		*dev;
+	volatile long unsigned 		pvt_id;
+	struct mutex            sst_lock;
+	unsigned int		stream_cnt;
+	unsigned int		csr_value;
+	void			*fw_in_mem;
+	struct sst_sg_list	fw_sg_list, library_list;
+	struct intel_sst_ops	*ops;
+	struct sst_info		info;
+	struct pm_qos_request	*qos;
+	unsigned int		use_dma;
+	unsigned int		use_lli;
+	atomic_t		fw_clear_context;
+	bool			lib_dwnld_reqd;
+	struct list_head	memcpy_list;
+	struct sst_ipc_reg	ipc_reg;
+	struct sst_mem_mgr      lib_mem_mgr;
+	/*
+	 * Holder for firmware name. Due to async call it needs to be
+	 * persistent till worker thread gets called
+	 */
+	char firmware_name[20];
+};
+
+/* misc definitions */
+#define FW_DWNL_ID 0x01
+
+struct intel_sst_ops {
+	irqreturn_t (*interrupt)(int, void *);
+	irqreturn_t (*irq_thread)(int, void *);
+	void (*clear_interrupt)(struct intel_sst_drv *ctx);
+	int (*start)(struct intel_sst_drv *ctx);
+	int (*reset)(struct intel_sst_drv *ctx);
+	void (*process_reply)(struct intel_sst_drv *ctx, struct ipc_post *msg);
+	int (*post_message)(struct intel_sst_drv *ctx,
+			struct ipc_post *msg, bool sync);
+	void (*process_message)(struct ipc_post *msg);
+	void (*set_bypass)(bool set);
+	int (*save_dsp_context)(struct intel_sst_drv *sst);
+	void (*restore_dsp_context)(void);
+	int (*alloc_stream)(struct intel_sst_drv *ctx, void *params);
+	void (*post_download)(struct intel_sst_drv *sst);
+};
+
+int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int id);
+int sst_resume_stream(struct intel_sst_drv *sst_drv_ctx, int id);
+int sst_drop_stream(struct intel_sst_drv *sst_drv_ctx, int id);
+int sst_free_stream(struct intel_sst_drv *sst_drv_ctx, int id);
+int sst_start_stream(struct intel_sst_drv *sst_drv_ctx, int str_id);
+int sst_send_byte_stream_mrfld(struct intel_sst_drv *ctx,
+			struct snd_sst_bytes_v2 *sbytes);
+int sst_set_stream_param(int str_id, struct snd_sst_params *str_param);
+int sst_set_metadata(int str_id, char *params);
+int sst_get_stream(struct intel_sst_drv *sst_drv_ctx,
+		struct snd_sst_params *str_param);
+int sst_get_stream_allocated(struct intel_sst_drv *ctx,
+		struct snd_sst_params *str_param,
+		struct snd_sst_lib_download **lib_dnld);
+int sst_drain_stream(struct intel_sst_drv *sst_drv_ctx,
+		int str_id, bool partial_drain);
+int sst_post_message_mrfld(struct intel_sst_drv *ctx,
+		struct ipc_post *msg, bool sync);
+void sst_process_reply_mrfld(struct intel_sst_drv *ctx, struct ipc_post *msg);
+int sst_start_mrfld(struct intel_sst_drv *ctx);
+int intel_sst_reset_dsp_mrfld(struct intel_sst_drv *ctx);
+void intel_sst_clear_intr_mrfld(struct intel_sst_drv *ctx);
+
+int sst_load_fw(struct intel_sst_drv *ctx);
+int sst_load_library(struct snd_sst_lib_download *lib, u8 ops);
+void sst_post_download_mrfld(struct intel_sst_drv *ctx);
+int sst_get_block_stream(struct intel_sst_drv *sst_drv_ctx);
+void sst_memcpy_free_resources(struct intel_sst_drv *ctx);
+
+int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
+				struct sst_block *block);
+int sst_wait_timeout(struct intel_sst_drv *sst_drv_ctx,
+			struct sst_block *block);
+int sst_create_ipc_msg(struct ipc_post **arg, bool large);
+int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id);
+void sst_clean_stream(struct stream_info *stream);
+int intel_sst_register_compress(struct intel_sst_drv *sst);
+int intel_sst_remove_compress(struct intel_sst_drv *sst);
+void sst_cdev_fragment_elapsed(struct intel_sst_drv *ctx, int str_id);
+int sst_send_sync_msg(int ipc, int str_id);
+int sst_get_num_channel(struct snd_sst_params *str_param);
+int sst_get_sfreq(struct snd_sst_params *str_param);
+int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params);
+void sst_restore_fw_context(void);
+struct sst_block *sst_create_block(struct intel_sst_drv *ctx,
+				u32 msg_id, u32 drv_id);
+int sst_create_block_and_ipc_msg(struct ipc_post **arg, bool large,
+		struct intel_sst_drv *sst_drv_ctx, struct sst_block **block,
+		u32 msg_id, u32 drv_id);
+int sst_free_block(struct intel_sst_drv *ctx, struct sst_block *freed);
+int sst_wake_up_block(struct intel_sst_drv *ctx, int result,
+		u32 drv_id, u32 ipc, void *data, u32 size);
+int sst_request_firmware_async(struct intel_sst_drv *ctx);
+int sst_driver_ops(struct intel_sst_drv *sst);
+struct sst_platform_info *sst_get_acpi_driver_data(const char *hid);
+void sst_firmware_load_cb(const struct firmware *fw, void *context);
+int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
+		int task_id, int ipc_msg, int cmd_id, int pipe_id,
+		size_t mbox_data_len, const void *mbox_data, void **data,
+		bool large, bool fill_dsp, bool sync, bool response);
+
+void sst_save_shim64(struct intel_sst_drv *ctx, void __iomem *shim,
+		struct sst_shim_regs64 *shim_regs);
+void sst_process_pending_msg(struct work_struct *work);
+int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx);
+void sst_init_stream(struct stream_info *stream,
+		int codec, int sst_id, int ops, u8 slot);
+int sst_validate_strid(struct intel_sst_drv *sst_drv_ctx, int str_id);
+struct stream_info *get_stream_info(struct intel_sst_drv *sst_drv_ctx,
+		int str_id);
+int get_stream_id_mrfld(struct intel_sst_drv *sst_drv_ctx,
+		u32 pipe_id);
+u32 relocate_imr_addr_mrfld(u32 base_addr);
+void sst_add_to_dispatch_list_and_post(struct intel_sst_drv *sst,
+					struct ipc_post *msg);
+int sst_pm_runtime_put(struct intel_sst_drv *sst_drv);
+int sst_shim_write(void __iomem *addr, int offset, int value);
+u32 sst_shim_read(void __iomem *addr, int offset);
+u64 sst_reg_read64(void __iomem *addr, int offset);
+int sst_shim_write64(void __iomem *addr, int offset, u64 value);
+u64 sst_shim_read64(void __iomem *addr, int offset);
+void sst_set_fw_state_locked(
+		struct intel_sst_drv *sst_drv_ctx, int sst_state);
+void sst_fill_header_mrfld(union ipc_header_mrfld *header,
+				int msg, int task_id, int large, int drv_id);
+void sst_fill_header_dsp(struct ipc_dsp_hdr *dsp, int msg,
+					int pipe_id, int len);
+
+int sst_register(struct device *);
+int sst_unregister(struct device *);
+
+#endif
-- 
1.7.0.4
