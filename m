From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: mrfld - add the dsp sst driver
Date: Wed,  9 Jul 2014 14:57:52 +0530
Message-ID: <1404898076-1882-5-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D4576264FBA
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:22 +0200 (CEST)
In-Reply-To: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The SST driver is the missing piece in our driver stack not upstreamed, so push
it now :) This driver currently supports PCI device on Merrifield. Future updates
will bring support for ACPI device as well as future update to PCI devices as
well

This driver currently supports DSP loading suing memcpy, pcm operations and
compressed ops (subsequent patch)

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 arch/x86/include/asm/platform_sst_audio.h |   33 +
 sound/soc/intel/Kconfig                   |    4 +
 sound/soc/intel/Makefile                  |    3 +
 sound/soc/intel/sst/Makefile              |    3 +
 sound/soc/intel/sst/sst.c                 |  439 +++++++++++++
 sound/soc/intel/sst/sst.h                 |  666 ++++++++++++++++++++
 sound/soc/intel/sst/sst_drv_interface.c   |  543 ++++++++++++++++
 sound/soc/intel/sst/sst_ipc.c             |  368 +++++++++++
 sound/soc/intel/sst/sst_loader.c          |  951 +++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c             |  208 +++++++
 sound/soc/intel/sst/sst_stream.c          |  534 ++++++++++++++++
 11 files changed, 3752 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/intel/sst/Makefile
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
 create mode 100644 sound/soc/intel/sst/sst_ipc.c
 create mode 100644 sound/soc/intel/sst/sst_loader.c
 create mode 100644 sound/soc/intel/sst/sst_pvt.c
 create mode 100644 sound/soc/intel/sst/sst_stream.c

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 0a4e140..565a617 100644
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
@@ -73,6 +76,36 @@ struct sst_platform_data {
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
+	const struct sst_ipc_info *ipc_info;
+	const struct sst_lib_dnld_info *lib_info;
+};
 int add_sst_platform_device(void);
 #endif
 
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c30fedb..e978a47 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -3,6 +3,7 @@ config SND_MFLD_MACHINE
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
 	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
@@ -12,6 +13,9 @@ config SND_MFLD_MACHINE
 config SND_SST_MFLD_PLATFORM
 	tristate
 
+config SND_SST_IPC
+	tristate
+
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 4bfca79..6f4cefe 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -28,3 +28,6 @@ snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
+
+# DSP driver
+obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/sst/Makefile
new file mode 100644
index 0000000..4d0e79b
--- /dev/null
+++ b/sound/soc/intel/sst/Makefile
@@ -0,0 +1,3 @@
+snd-intel-sst-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
+
+obj-$(CONFIG_SND_SST_IPC) += snd-intel-sst.o
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
new file mode 100644
index 0000000..916b38c
--- /dev/null
+++ b/sound/soc/intel/sst/sst.c
@@ -0,0 +1,439 @@
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
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
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
+MODULE_VERSION(SST_DRIVER_VERSION);
+
+struct intel_sst_drv *sst_drv_ctx;
+
+#define SST_IS_PROCESS_REPLY(header) ((header & PROCESS_MSG) ? true : false)
+#define SST_VALIDATE_MAILBOX_SIZE(size) ((size <= SST_MAILBOX_SIZE) ? true : false)
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
+	if (isr.part.done_interrupt) {
+		/* Clear done bit */
+		spin_lock(&drv->ipc_spin_lock);
+		header.full = sst_shim_read64(drv->shim,
+					drv->ipc_reg.ipcx);
+		header.p.header_high.part.done = 0;
+		sst_shim_write64(drv->shim, drv->ipc_reg.ipcx, header.full);
+		/* write 1 to clear status register */;
+		isr.part.done_interrupt = 1;
+		sst_shim_write64(drv->shim, SST_ISRX, isr.full);
+		spin_unlock(&drv->ipc_spin_lock);
+		queue_work(drv->post_msg_wq, &drv->ipc_post_msg.wq);
+		retval = IRQ_HANDLED;
+	}
+	if (isr.part.busy_interrupt) {
+		spin_lock(&drv->ipc_spin_lock);
+		imr.full = sst_shim_read64(drv->shim, SST_IMRX);
+		imr.part.busy_interrupt = 1;
+		sst_shim_write64(drv->shim, SST_IMRX, imr.full);
+		spin_unlock(&drv->ipc_spin_lock);
+		header.full =  sst_shim_read64(drv->shim, drv->ipc_reg.ipcd);
+		if (sst_create_ipc_msg(&msg, header.p.header_high.part.large)) {
+			pr_err("No memory available\n");
+			drv->ops->clear_interrupt();
+			return IRQ_HANDLED;
+		}
+		if (header.p.header_high.part.large) {
+			size = header.p.header_low_payload;
+			if (SST_VALIDATE_MAILBOX_SIZE(size)) {
+				memcpy_fromio(msg->mailbox_data,
+					drv->mailbox + drv->mailbox_recv_offset, size);
+			} else {
+				pr_err("Mailbox not copied, payload siz is: %u\n", size);
+				header.p.header_low_payload = 0;
+			}
+		}
+		msg->mrfld_header = header;
+		msg->is_process_reply =
+			SST_IS_PROCESS_REPLY(header.p.header_high.part.msg_id);
+		spin_lock(&drv->rx_msg_lock);
+		list_add_tail(&msg->node, &drv->rx_list);
+		spin_unlock(&drv->rx_msg_lock);
+		drv->ops->clear_interrupt();
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
+	if (list_empty(&drv->rx_list))
+		return IRQ_HANDLED;
+
+	spin_lock_irqsave(&drv->rx_msg_lock, irq_flags);
+	list_for_each_entry_safe(msg, __msg, &drv->rx_list, node) {
+
+		list_del(&msg->node);
+		spin_unlock_irqrestore(&drv->rx_msg_lock, irq_flags);
+		if (msg->is_process_reply)
+			drv->ops->process_message(msg);
+		else
+			drv->ops->process_reply(msg);
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
+	.sync_post_message = sst_sync_post_message_mrfld,
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
+		pr_err("SST Driver capablities missing for pci_id: %x", sst->pci_id);
+		return -EINVAL;
+	};
+}
+
+int sst_alloc_drv_context(struct device *dev)
+{
+	struct intel_sst_drv *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		pr_err("malloc fail\n");
+		return -ENOMEM;
+	}
+	sst_drv_ctx = ctx;
+	return 0;
+}
+
+/*
+* intel_sst_probe - PCI probe function
+*
+* @pci:	PCI device structure
+* @pci_id: PCI device ID structure
+*
+* This function is called by OS when a device is found
+* This enables the device, interrupt etc
+*/
+static int intel_sst_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
+{
+	int i, ret = 0;
+	struct intel_sst_ops *ops;
+	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
+	int ddr_base;
+
+	pr_debug("Probe for DID %x\n", pci->device);
+	ret = sst_alloc_drv_context(&pci->dev);
+	if (ret)
+		return ret;
+
+	sst_drv_ctx->dev = &pci->dev;
+	sst_drv_ctx->pci_id = pci->device;
+	if (!sst_pdata)
+		return -EINVAL;
+	sst_drv_ctx->pdata = sst_pdata;
+
+	if (0 != sst_driver_ops(sst_drv_ctx))
+		return -EINVAL;
+	ops = sst_drv_ctx->ops;
+	mutex_init(&sst_drv_ctx->sst_lock);
+
+	sst_drv_ctx->stream_cnt = 0;
+	sst_drv_ctx->fw_in_mem = NULL;
+
+	/* we use dma, so set to 1*/
+	sst_drv_ctx->use_dma = 1;
+	sst_drv_ctx->use_lli = 1;
+
+	INIT_LIST_HEAD(&sst_drv_ctx->memcpy_list);
+	INIT_LIST_HEAD(&sst_drv_ctx->libmemcpy_list);
+
+	INIT_LIST_HEAD(&sst_drv_ctx->ipc_dispatch_list);
+	INIT_LIST_HEAD(&sst_drv_ctx->block_list);
+	INIT_LIST_HEAD(&sst_drv_ctx->rx_list);
+	INIT_WORK(&sst_drv_ctx->ipc_post_msg.wq, ops->post_message);
+	init_waitqueue_head(&sst_drv_ctx->wait_queue);
+
+	sst_drv_ctx->post_msg_wq =
+		create_singlethread_workqueue("sst_post_msg_wq");
+	if (!sst_drv_ctx->post_msg_wq) {
+		ret = -EINVAL;
+		goto do_free_drv_ctx;
+	}
+
+	spin_lock_init(&sst_drv_ctx->ipc_spin_lock);
+	spin_lock_init(&sst_drv_ctx->block_lock);
+	spin_lock_init(&sst_drv_ctx->rx_msg_lock);
+
+	pr_info("Got drv data max stream %d\n",
+				sst_drv_ctx->info.max_streams);
+	for (i = 1; i <= sst_drv_ctx->info.max_streams; i++) {
+		struct stream_info *stream = &sst_drv_ctx->streams[i];
+		memset(stream, 0, sizeof(*stream));
+		stream->pipe_id = PIPE_RSVD;
+		mutex_init(&stream->lock);
+	}
+
+	/* Init the device */
+	ret = pci_enable_device(pci);
+	if (ret) {
+		pr_err("device can't be enabled\n");
+		goto do_free_mem;
+	}
+	sst_drv_ctx->pci = pci_dev_get(pci);
+	ret = pci_request_regions(pci, SST_DRV_NAME);
+	if (ret)
+		goto do_disable_device;
+
+	/* map registers */
+	/* SST Shim */
+	if (sst_drv_ctx->pci_id == SST_MRFLD_PCI_ID) {
+		sst_drv_ctx->ddr_base = pci_resource_start(pci, 0);
+		/*
+		* check that the relocated IMR base matches with FW Binary
+		* put temporary check till better soln is available for FW
+		*/
+		ddr_base = relocate_imr_addr_mrfld(sst_drv_ctx->ddr_base);
+		if (!sst_drv_ctx->pdata->lib_info) {
+			pr_err("%s:lib_info pointer NULL\n", __func__);
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		if (ddr_base != sst_drv_ctx->pdata->lib_info->mod_base) {
+			pr_err("FW LSP DDR BASE does not match with IFWI\n");
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		sst_drv_ctx->ddr_end = pci_resource_end(pci, 0);
+
+		sst_drv_ctx->ddr = pci_ioremap_bar(pci, 0);
+		if (!sst_drv_ctx->ddr) {
+			ret = -EINVAL;
+			goto do_unmap_ddr;
+		}
+		pr_debug("sst: DDR Ptr %p\n", sst_drv_ctx->ddr);
+	} else {
+		sst_drv_ctx->ddr = NULL;
+	}
+
+	/* SHIM */
+	sst_drv_ctx->shim_phy_add = pci_resource_start(pci, 1);
+	sst_drv_ctx->shim = pci_ioremap_bar(pci, 1);
+	if (!sst_drv_ctx->shim) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	pr_debug("SST Shim Ptr %p\n", sst_drv_ctx->shim);
+
+	/* Shared SRAM */
+	sst_drv_ctx->mailbox_add = pci_resource_start(pci, 2);
+	sst_drv_ctx->mailbox = pci_ioremap_bar(pci, 2);
+	if (!sst_drv_ctx->mailbox) {
+		ret = -EINVAL;
+		goto do_unmap_shim;
+	}
+	pr_debug("SRAM Ptr %p\n", sst_drv_ctx->mailbox);
+
+	/* IRAM */
+	sst_drv_ctx->iram_end = pci_resource_end(pci, 3);
+	sst_drv_ctx->iram_base = pci_resource_start(pci, 3);
+	sst_drv_ctx->iram = pci_ioremap_bar(pci, 3);
+	if (!sst_drv_ctx->iram) {
+		ret = -EINVAL;
+		goto do_unmap_sram;
+	}
+	pr_debug("IRAM Ptr %p\n", sst_drv_ctx->iram);
+
+	/* DRAM */
+	sst_drv_ctx->dram_end = pci_resource_end(pci, 4);
+	sst_drv_ctx->dram_base = pci_resource_start(pci, 4);
+	sst_drv_ctx->dram = pci_ioremap_bar(pci, 4);
+	if (!sst_drv_ctx->dram) {
+		ret = -EINVAL;
+		goto do_unmap_iram;
+	}
+	pr_debug("DRAM Ptr %p\n", sst_drv_ctx->dram);
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
+		goto do_unmap_dram;
+	pr_debug("Registered IRQ 0x%x\n", pci->irq);
+
+	/* default intr are unmasked so set this as masked */
+	if (sst_drv_ctx->pci_id == SST_MRFLD_PCI_ID)
+		sst_shim_write64(sst_drv_ctx->shim, SST_IMRX, 0xFFFF0038);
+
+	pci_set_drvdata(pci, sst_drv_ctx);
+	pm_runtime_allow(sst_drv_ctx->dev);
+	pm_runtime_put_noidle(sst_drv_ctx->dev);
+	register_sst(sst_drv_ctx->dev);
+	sst_drv_ctx->qos = devm_kzalloc(&pci->dev,
+		sizeof(struct pm_qos_request), GFP_KERNEL);
+	if (!sst_drv_ctx->qos) {
+		ret = -ENOMEM;
+		goto do_unmap_dram;
+	}
+	pm_qos_add_request(sst_drv_ctx->qos, PM_QOS_CPU_DMA_LATENCY,
+				PM_QOS_DEFAULT_VALUE);
+
+	pr_info("%s successfully done!\n", __func__);
+	return ret;
+
+do_unmap_dram:
+	iounmap(sst_drv_ctx->dram);
+do_unmap_iram:
+	iounmap(sst_drv_ctx->iram);
+do_unmap_sram:
+	iounmap(sst_drv_ctx->mailbox);
+do_unmap_shim:
+	iounmap(sst_drv_ctx->shim);
+do_unmap_ddr:
+	if (sst_drv_ctx->ddr)
+		iounmap(sst_drv_ctx->ddr);
+do_release_regions:
+	pci_release_regions(pci);
+do_disable_device:
+	pci_disable_device(pci);
+do_free_mem:
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+do_free_drv_ctx:
+	sst_drv_ctx = NULL;
+	pr_err("Probe failed with %d\n", ret);
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
+	unregister_sst(sst_drv_ctx->dev);
+	pci_dev_put(sst_drv_ctx->pci);
+	sst_set_fw_state_locked(sst_drv_ctx, SST_SHUTDOWN);
+
+	iounmap(sst_drv_ctx->dram);
+	iounmap(sst_drv_ctx->iram);
+	iounmap(sst_drv_ctx->mailbox);
+	iounmap(sst_drv_ctx->shim);
+	flush_scheduled_work();
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+	pm_qos_remove_request(sst_drv_ctx->qos);
+	kfree(sst_drv_ctx->fw_sg_list.src);
+	kfree(sst_drv_ctx->fw_sg_list.dst);
+	sst_drv_ctx->fw_sg_list.list_len = 0;
+	kfree(sst_drv_ctx->fw_in_mem);
+	sst_drv_ctx->fw_in_mem = NULL;
+	sst_memcpy_free_resources();
+	sst_drv_ctx = NULL;
+	pci_release_regions(pci);
+	pci_disable_device(pci);
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
index 0000000..f6145d8
--- /dev/null
+++ b/sound/soc/intel/sst/sst.h
@@ -0,0 +1,666 @@
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
+#define SST_DRIVER_VERSION "5.0.0"
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
+/* FIXME: All this info should come from platform data
+ * move this when the base framework is ready to pass
+ * platform data to SST driver
+ */
+#define MRFLD_FW_VIRTUAL_BASE 0xC0000000
+#define MRFLD_FW_DDR_BASE_OFFSET 0x0
+#define MRFLD_FW_FEATURE_BASE_OFFSET 0x4
+#define MRFLD_FW_BSS_RESET_BIT 0
+extern struct intel_sst_drv *sst_drv_ctx;
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
+/* SST shim registers to structure mapping  */
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
+/*This structure is used to block a user/fw data call to another
+fw/user call
+*/
+struct sst_block {
+	bool	condition; /* condition for blocking check */
+	int	ret_code; /* ret code when block is released */
+	void	*data; /* data to be appsed for block if any */
+	u32     size;
+	bool	on;
+	u32     msg_id;  /*msg_id = msgid in mfld/ctp, mrfld = 0 */
+	u32     drv_id; /* = str_id in mfld/ctp, = drv_id in mrfld*/
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
+	struct mutex		lock; /* mutex */
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
+/*
+ * struct fw_header - FW file headers
+ *
+ * @signature : FW signature
+ * @modules : # of modules
+ * @file_format : version of header format
+ * @reserved : reserved fields
+ */
+struct fw_header {
+	unsigned char signature[FW_SIGNATURE_SIZE]; /* FW signature */
+	u32 file_size; /* size of fw minus this header */
+	u32 modules; /*  # of modules */
+	u32 file_format; /* version of header format */
+	u32 reserved[4];
+};
+
+struct fw_module_header {
+	unsigned char signature[FW_SIGNATURE_SIZE]; /* module signature */
+	u32 mod_size; /* size of module */
+	u32 blocks; /* # of blocks */
+	u32 type; /* codec type, pp lib */
+	u32 entry_point;
+};
+
+struct fw_block_info {
+	enum sst_ram_type	type;	/* IRAM/DRAM */
+	u32			size;	/* Bytes */
+	u32			ram_offset; /* Offset in I/DRAM */
+	u32			rsvd;	/* Reserved field */
+};
+
+struct sst_ipc_msg_wq {
+	union ipc_header_mrfld mrfld_header;
+	struct ipc_dsp_hdr dsp_hdr;
+	char mailbox[SST_MAILBOX_SIZE];
+	struct work_struct	wq;
+	union ipc_header header;
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
+/* Firmware Module Information*/
+enum sst_lib_dwnld_status {
+	SST_LIB_NOT_FOUND = 0,
+	SST_LIB_FOUND,
+	SST_LIB_DOWNLOADED,
+};
+
+struct sst_module_info {
+	const char *name; /* Library name */
+	u32	id; /* Module ID */
+	u32	entry_pt; /* Module entry point */
+	u8	status; /* module status*/
+	u8	rsvd1;
+	u16	rsvd2;
+};
+
+/* Structure for managing the Library Region(1.5MB)
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
+/***
+ *
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
+ * @ipc_post_msg : wq to post reply from FW context
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
+	atomic_t		pm_usage_count;
+	struct sst_shim_regs64	*shim_regs64;
+	struct list_head        block_list;
+	struct list_head	ipc_dispatch_list;
+	struct sst_platform_info *pdata;
+	struct sst_ipc_msg_wq   ipc_post_msg;
+	struct list_head	rx_list;
+	struct work_struct      ipc_post_msg_wq;
+	wait_queue_head_t	wait_queue;
+	struct workqueue_struct *post_msg_wq;
+	unsigned int		tstamp;
+	struct stream_info	streams[MAX_NUM_STREAMS+1]; /*str_id 0 is not used*/
+	spinlock_t		ipc_spin_lock; /* lock for Shim reg access and ipc queue */
+	/* lock for adding block to block_list and assigning pvt_id */
+	spinlock_t              block_lock;
+	spinlock_t		rx_msg_lock;
+	struct pci_dev		*pci;
+	struct device		*dev;
+	unsigned int		pvt_id;
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
+	atomic_t		fw_clear_cache;
+	bool			lib_dwnld_reqd;
+	struct list_head	memcpy_list;
+	struct list_head	libmemcpy_list;
+	struct sst_ipc_reg	ipc_reg;
+	struct sst_mem_mgr      lib_mem_mgr;
+	/* Holder for firmware name. Due to async call it needs to be
+	 * persistent till worker thread gets called
+	 */
+	char firmware_name[20];
+};
+
+extern struct intel_sst_drv *sst_drv_ctx;
+
+/* misc definitions */
+#define FW_DWNL_ID 0xFF
+
+struct intel_sst_ops {
+	irqreturn_t (*interrupt)(int, void *);
+	irqreturn_t (*irq_thread)(int, void *);
+	void (*clear_interrupt)(void);
+	int (*start)(void);
+	int (*reset)(void);
+	void (*process_reply)(struct ipc_post *msg);
+	void (*post_message)(struct work_struct *work);
+	int (*sync_post_message)(struct ipc_post *msg);
+	void (*process_message)(struct ipc_post *msg);
+	void (*set_bypass)(bool set);
+	int (*save_dsp_context)(struct intel_sst_drv *sst);
+	void (*restore_dsp_context)(void);
+	int (*alloc_stream)(char *params, struct sst_block *block);
+	void (*post_download)(struct intel_sst_drv *sst);
+};
+
+int sst_alloc_stream(char *params, struct sst_block *block);
+int sst_pause_stream(int id);
+int sst_resume_stream(int id);
+int sst_drop_stream(int id);
+int sst_next_track(void);
+int sst_free_stream(int id);
+int sst_start_stream(int str_id);
+int sst_send_byte_stream_mrfld(void *sbytes);
+int sst_set_stream_param(int str_id, struct snd_sst_params *str_param);
+int sst_set_metadata(int str_id, char *params);
+int sst_get_stream(struct snd_sst_params *str_param);
+int sst_get_stream_allocated(struct snd_sst_params *str_param,
+				struct snd_sst_lib_download **lib_dnld);
+int sst_drain_stream(int str_id, bool partial_drain);
+
+
+int sst_sync_post_message_mrfld(struct ipc_post *msg);
+void sst_post_message_mrfld(struct work_struct *work);
+void sst_process_reply_mrfld(struct ipc_post *msg);
+int sst_start_mrfld(void);
+int intel_sst_reset_dsp_mrfld(void);
+void intel_sst_clear_intr_mrfld(void);
+
+int sst_load_fw(void);
+int sst_load_library(struct snd_sst_lib_download *lib, u8 ops);
+int sst_load_all_modules_elf(struct intel_sst_drv *ctx,
+		struct sst_module_info *mod_table, int mod_table_size);
+int sst_get_next_lib_mem(struct sst_mem_mgr *mgr, int size,
+			unsigned long *lib_base);
+void sst_post_download_mrfld(struct intel_sst_drv *ctx);
+int sst_get_block_stream(struct intel_sst_drv *sst_drv_ctx);
+void sst_memcpy_free_resources(void);
+
+int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
+				struct sst_block *block);
+int sst_wait_timeout(struct intel_sst_drv *sst_drv_ctx,
+			struct sst_block *block);
+int sst_create_ipc_msg(struct ipc_post **arg, bool large);
+int sst_download_fw(void);
+int free_stream_context(unsigned int str_id);
+void sst_clean_stream(struct stream_info *stream);
+int intel_sst_register_compress(struct intel_sst_drv *sst);
+int intel_sst_remove_compress(struct intel_sst_drv *sst);
+void sst_cdev_fragment_elapsed(int str_id);
+int sst_send_sync_msg(int ipc, int str_id);
+int sst_get_num_channel(struct snd_sst_params *str_param);
+int sst_get_sfreq(struct snd_sst_params *str_param);
+int intel_sst_check_device(void);
+int sst_alloc_stream_ctp(char *params, struct sst_block *block);
+int sst_alloc_stream_mrfld(char *params, struct sst_block *block);
+void sst_restore_fw_context(void);
+struct sst_block *sst_create_block(struct intel_sst_drv *ctx,
+				u32 msg_id, u32 drv_id);
+int sst_create_block_and_ipc_msg(struct ipc_post **arg, bool large,
+		struct intel_sst_drv *sst_drv_ctx, struct sst_block **block,
+		u32 msg_id, u32 drv_id);
+int sst_free_block(struct intel_sst_drv *ctx, struct sst_block *freed);
+int sst_wake_up_block(struct intel_sst_drv *ctx, int result,
+		u32 drv_id, u32 ipc, void *data, u32 size);
+int sst_alloc_drv_context(struct device *dev);
+int sst_request_firmware_async(struct intel_sst_drv *ctx);
+int sst_driver_ops(struct intel_sst_drv *sst);
+struct sst_platform_info *sst_get_acpi_driver_data(const char *hid);
+void sst_firmware_load_cb(const struct firmware *fw, void *context);
+
+static inline int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
+{
+	int ret;
+
+	ret = pm_runtime_put_sync(sst_drv->dev);
+	if (ret < 0)
+		return ret;
+	atomic_dec(&sst_drv->pm_usage_count);
+
+	pr_debug("%s: count is %d now..\n", __func__,
+			atomic_read(&sst_drv->pm_usage_count));
+	return 0;
+}
+
+static inline void sst_fill_header_mrfld(union ipc_header_mrfld *header,
+				int msg, int task_id, int large, int drv_id)
+{
+	header->full = 0;
+	header->p.header_high.part.msg_id = msg;
+	header->p.header_high.part.task_id = task_id;
+	header->p.header_high.part.large = large;
+	header->p.header_high.part.drv_id = drv_id;
+	header->p.header_high.part.done = 0;
+	header->p.header_high.part.busy = 1;
+	header->p.header_high.part.res_rqd = 1;
+}
+
+static inline void sst_fill_header_dsp(struct ipc_dsp_hdr *dsp, int msg,
+					int pipe_id, int len)
+{
+	dsp->cmd_id = msg;
+	dsp->mod_index_id = 0xff;
+	dsp->pipe_id = pipe_id;
+	dsp->length = len;
+	dsp->mod_id = 0;
+}
+
+#define MAX_BLOCKS 15
+/* sst_assign_pvt_id - assign a pvt id for stream
+ *
+ * @sst_drv_ctx : driver context
+ *
+ * this inline function assigns a private id for calls that dont have stream
+ * context yet, should be called with lock held
+ */
+static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx)
+{
+	unsigned int local;
+
+	spin_lock(&sst_drv_ctx->block_lock);
+	sst_drv_ctx->pvt_id++;
+	if (sst_drv_ctx->pvt_id > MAX_BLOCKS)
+		sst_drv_ctx->pvt_id = 1;
+	local = sst_drv_ctx->pvt_id;
+	spin_unlock(&sst_drv_ctx->block_lock);
+	return local;
+}
+
+
+static inline void sst_init_stream(struct stream_info *stream,
+		int codec, int sst_id, int ops, u8 slot)
+{
+	stream->status = STREAM_INIT;
+	stream->prev = STREAM_UN_INIT;
+	stream->ops = ops;
+}
+
+static inline int sst_validate_strid(int str_id)
+{
+	if (str_id <= 0 || str_id > sst_drv_ctx->info.max_streams) {
+		pr_err("SST ERR: invalid stream id : %d, max %d\n",
+					str_id, sst_drv_ctx->info.max_streams);
+		return -EINVAL;
+	} else
+		return 0;
+}
+
+static inline int sst_shim_write(void __iomem *addr, int offset, int value)
+{
+	writel(value, addr + offset);
+	return 0;
+}
+
+static inline u32 sst_shim_read(void __iomem *addr, int offset)
+{
+
+	return readl(addr + offset);
+}
+
+static inline u64 sst_reg_read64(void __iomem *addr, int offset)
+{
+	u64 val = 0;
+
+	memcpy_fromio(&val, addr + offset, sizeof(val));
+
+	return val;
+}
+
+static inline int sst_shim_write64(void __iomem *addr, int offset, u64 value)
+{
+	memcpy_toio(addr + offset, &value, sizeof(value));
+	return 0;
+}
+
+static inline u64 sst_shim_read64(void __iomem *addr, int offset)
+{
+	u64 val = 0;
+
+	memcpy_fromio(&val, addr + offset, sizeof(val));
+	return val;
+}
+
+static inline void
+sst_set_fw_state_locked(struct intel_sst_drv *sst_drv_ctx, int sst_state)
+{
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = sst_state;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+}
+
+static inline struct stream_info *get_stream_info(int str_id)
+{
+	if (sst_validate_strid(str_id))
+		return NULL;
+	return &sst_drv_ctx->streams[str_id];
+}
+
+static inline int get_stream_id_mrfld(u32 pipe_id)
+{
+	int i;
+
+	for (i = 1; i <= sst_drv_ctx->info.max_streams; i++)
+		if (pipe_id == sst_drv_ctx->streams[i].pipe_id)
+			return i;
+
+	pr_debug("%s: no such pipe_id(%u)", __func__, pipe_id);
+	return -1;
+}
+
+int register_sst(struct device *);
+int unregister_sst(struct device *);
+
+static inline u32 relocate_imr_addr_mrfld(u32 base_addr)
+{
+	/* Get the difference from 512MB aligned base addr */
+	/* relocate the base */
+	base_addr = MRFLD_FW_VIRTUAL_BASE + (base_addr % (512 * 1024 * 1024));
+	return base_addr;
+}
+
+static inline void sst_add_to_dispatch_list_and_post(struct intel_sst_drv *sst,
+						struct ipc_post *msg)
+{
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&sst->ipc_spin_lock, irq_flags);
+	list_add_tail(&msg->node, &sst->ipc_dispatch_list);
+	spin_unlock_irqrestore(&sst->ipc_spin_lock, irq_flags);
+	sst->ops->post_message(&sst->ipc_post_msg_wq);
+}
+#endif
diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
new file mode 100644
index 0000000..1ad3083
--- /dev/null
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -0,0 +1,543 @@
+/*
+ *  sst_drv_interface.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-14 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com)
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
+#include <linux/math64.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+#include "../sst-dsp.h"
+
+
+
+#define NUM_CODEC 2
+#define MIN_FRAGMENT 2
+#define MAX_FRAGMENT 4
+#define MIN_FRAGMENT_SIZE (50 * 1024)
+#define MAX_FRAGMENT_SIZE (1024 * 1024)
+#define SST_GET_BYTES_PER_SAMPLE(pcm_wd_sz)  (((pcm_wd_sz + 15) >> 4) << 1)
+
+/*
+ * sst_download_fw - download the audio firmware to DSP
+ *
+ * This function is called when the FW needs to be downloaded to SST DSP engine
+ */
+int sst_download_fw(void)
+{
+	int retval = 0;
+
+	retval = sst_load_fw();
+	if (retval)
+		return retval;
+	pr_debug("fw loaded successful!!!\n");
+
+	if (sst_drv_ctx->ops->restore_dsp_context)
+		sst_drv_ctx->ops->restore_dsp_context();
+	sst_drv_ctx->sst_state = SST_FW_RUNNING;
+	return retval;
+}
+
+int free_stream_context(unsigned int str_id)
+{
+	struct stream_info *stream;
+	int ret = 0;
+
+	stream = get_stream_info(str_id);
+	if (stream) {
+		/* str_id is valid, so stream is alloacted */
+		ret = sst_free_stream(str_id);
+		if (ret)
+			sst_clean_stream(&sst_drv_ctx->streams[str_id]);
+		return ret;
+	}
+	return ret;
+}
+
+/*
+ * sst_get_stream_allocated - this function gets a stream allocated with
+ * the given params
+ *
+ * @str_param : stream params
+ * @lib_dnld : pointer to pointer of lib downlaod struct
+ *
+ * This creates new stream id for a stream, in case lib is to be downloaded to
+ * DSP, it downloads that
+ */
+int sst_get_stream_allocated(struct snd_sst_params *str_param,
+		struct snd_sst_lib_download **lib_dnld)
+{
+	int retval, str_id;
+	struct sst_block *block;
+	struct snd_sst_alloc_response *response;
+	struct stream_info *str_info;
+
+	pr_debug("In %s\n", __func__);
+	block = sst_create_block(sst_drv_ctx, 0, 0);
+	if (block == NULL)
+		return -ENOMEM;
+
+	retval = sst_drv_ctx->ops->alloc_stream((char *) str_param, block);
+	str_id = retval;
+	if (retval < 0) {
+		pr_err("sst_alloc_stream failed %d\n", retval);
+		goto free_block;
+	}
+	pr_debug("Stream allocated %d\n", retval);
+	str_info = get_stream_info(str_id);
+	if (str_info == NULL) {
+		pr_err("get stream info returned null\n");
+		str_id = -EINVAL;
+		goto free_block;
+	}
+
+	/* Block the call for reply */
+	retval = sst_wait_timeout(sst_drv_ctx, block);
+	if (block->data) {
+		response = (struct snd_sst_alloc_response *)block->data;
+		retval = response->str_type.result;
+		if (!retval)
+			goto free_block;
+
+		pr_err("sst: FW alloc failed retval %d\n", retval);
+		if (retval == SST_ERR_STREAM_IN_USE) {
+			pr_err("sst:FW not in clean state, send free for:%d\n",
+					str_id);
+			sst_free_stream(str_id);
+			*lib_dnld = NULL;
+		} else {
+			*lib_dnld = NULL;
+		}
+		str_id = -retval;
+	} else if (retval != 0) {
+		pr_err("sst: FW alloc failed retval %d\n", retval);
+		/* alloc failed, so reset the state to uninit */
+		str_info->status = STREAM_UN_INIT;
+		str_id = retval;
+	}
+free_block:
+	sst_free_block(sst_drv_ctx, block);
+	return str_id; /*will ret either error (in above if) or correct str id*/
+}
+
+/*
+ * sst_get_sfreq - this function returns the frequency of the stream
+ *
+ * @str_param : stream params
+ */
+int sst_get_sfreq(struct snd_sst_params *str_param)
+{
+	switch (str_param->codec) {
+	case SST_CODEC_TYPE_PCM:
+		return str_param->sparams.uc.pcm_params.sfreq;
+	case SST_CODEC_TYPE_AAC:
+		return str_param->sparams.uc.aac_params.externalsr;
+	case SST_CODEC_TYPE_MP3:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * sst_get_sfreq - this function returns the frequency of the stream
+ *
+ * @str_param : stream params
+ */
+int sst_get_num_channel(struct snd_sst_params *str_param)
+{
+	switch (str_param->codec) {
+	case SST_CODEC_TYPE_PCM:
+		return str_param->sparams.uc.pcm_params.num_chan;
+	case SST_CODEC_TYPE_MP3:
+		return str_param->sparams.uc.mp3_params.num_chan;
+	case SST_CODEC_TYPE_AAC:
+		return str_param->sparams.uc.aac_params.num_chan;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * sst_get_stream - this function prepares for stream allocation
+ *
+ * @str_param : stream param
+ */
+int sst_get_stream(struct snd_sst_params *str_param)
+{
+	int retval;
+	struct stream_info *str_info;
+	struct snd_sst_lib_download *lib_dnld;
+
+	pr_debug("In %s\n", __func__);
+	/* stream is not allocated, we are allocating */
+	retval = sst_get_stream_allocated(str_param, &lib_dnld);
+
+	if  (retval <= 0) {
+		retval = -EIO;
+		goto err;
+	}
+	/* store sampling freq */
+	str_info = &sst_drv_ctx->streams[retval];
+	str_info->sfreq = sst_get_sfreq(str_param);
+
+err:
+	return retval;
+}
+
+/**
+* intel_sst_check_device - checks SST device
+*
+* This utility function checks the state of SST device and downlaods FW if
+* not done, or resumes the device if suspended
+*/
+int intel_sst_check_device(void)
+{
+	int retval = 0;
+
+	pr_debug("In %s\n", __func__);
+
+	pm_runtime_get_sync(sst_drv_ctx->dev);
+	atomic_inc(&sst_drv_ctx->pm_usage_count);
+
+	pr_debug("%s: count is %d now\n", __func__,
+				atomic_read(&sst_drv_ctx->pm_usage_count));
+
+	mutex_lock(&sst_drv_ctx->sst_lock);
+
+	if (sst_drv_ctx->sst_state == SST_RESET) {
+
+		/* FW is not downloaded */
+		pr_debug("DSP Downloading FW now...\n");
+		retval = sst_download_fw();
+		if (retval) {
+			pr_err("FW download fail %x\n", retval);
+			sst_drv_ctx->sst_state = SST_RESET;
+			mutex_unlock(&sst_drv_ctx->sst_lock);
+			sst_pm_runtime_put(sst_drv_ctx);
+			return retval;
+		}
+	}
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	return retval;
+}
+
+/*
+ * sst_open_pcm_stream - Open PCM interface
+ *
+ * @str_param: parameters of pcm stream
+ *
+ * This function is called by MID sound card driver to open
+ * a new pcm interface
+ */
+static int sst_open_pcm_stream(struct snd_sst_params *str_param)
+{
+	int retval;
+
+	if (!str_param)
+		return -EINVAL;
+
+	pr_debug("%s: doing rtpm_get\n", __func__);
+
+	retval = intel_sst_check_device();
+
+	if (retval)
+		return retval;
+	retval = sst_get_stream(str_param);
+	if (retval > 0) {
+		sst_drv_ctx->stream_cnt++;
+	} else {
+		pr_err("sst_get_stream returned err %d\n", retval);
+		sst_pm_runtime_put(sst_drv_ctx);
+	}
+
+	return retval;
+}
+
+/*
+ * sst_close_pcm_stream - Close PCM interface
+ *
+ * @str_id: stream id to be closed
+ *
+ * This function is called by MID sound card driver to close
+ * an existing pcm interface
+ */
+static int sst_close_pcm_stream(unsigned int str_id)
+{
+	struct stream_info *stream;
+	int retval = 0;
+
+	pr_debug("%s: Entry\n", __func__);
+	stream = get_stream_info(str_id);
+	if (!stream) {
+		pr_err("stream info is NULL for str %d!!!\n", str_id);
+		return -EINVAL;
+	}
+
+	if (stream->status == STREAM_RESET) {
+		/* silently fail here as we have cleaned the stream */
+		pr_debug("stream in reset state...\n");
+
+		retval = 0;
+		goto put;
+	}
+
+	retval = free_stream_context(str_id);
+put:
+	stream->pcm_substream = NULL;
+	stream->status = STREAM_UN_INIT;
+	stream->period_elapsed = NULL;
+	sst_drv_ctx->stream_cnt--;
+
+	/* The free_stream will return a error if there is no stream to free,
+	(i.e. the alloc failure case). And in this case the open does a put in
+	the error scenario, so skip in this case.
+		In the close we need to handle put in the success scenario and
+	the timeout error(EBUSY) scenario. */
+	if (!retval || (retval == -EBUSY))
+		sst_pm_runtime_put(sst_drv_ctx);
+	else
+		pr_err("%s: free stream returned err %d\n", __func__, retval);
+
+	pr_debug("%s: Exit\n", __func__);
+	return 0;
+}
+
+static inline int sst_calc_tstamp(struct pcm_stream_info *info,
+		struct snd_pcm_substream *substream,
+		struct snd_sst_tstamp *fw_tstamp)
+{
+	size_t delay_bytes, delay_frames;
+	size_t buffer_sz;
+	u32 pointer_bytes, pointer_samples;
+
+	pr_debug("mrfld ring_buffer_counter %llu in bytes\n",
+			fw_tstamp->ring_buffer_counter);
+	pr_debug("mrfld hardware_counter %llu in bytes\n",
+			 fw_tstamp->hardware_counter);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay_bytes = (size_t) (fw_tstamp->ring_buffer_counter -
+					fw_tstamp->hardware_counter);
+	else
+		delay_bytes = (size_t) (fw_tstamp->hardware_counter -
+					fw_tstamp->ring_buffer_counter);
+	delay_frames = bytes_to_frames(substream->runtime, delay_bytes);
+	buffer_sz = snd_pcm_lib_buffer_bytes(substream);
+	div_u64_rem(fw_tstamp->ring_buffer_counter, buffer_sz, &pointer_bytes);
+	pointer_samples = bytes_to_samples(substream->runtime, pointer_bytes);
+
+	pr_debug("pcm delay %zu in bytes\n", delay_bytes);
+
+	info->buffer_ptr = pointer_samples / substream->runtime->channels;
+
+	info->pcm_delay = delay_frames / substream->runtime->channels;
+	pr_debug("buffer ptr %llu pcm_delay rep: %llu\n",
+			info->buffer_ptr, info->pcm_delay);
+	return 0;
+}
+
+static int sst_read_timestamp(struct pcm_stream_info *info)
+{
+	struct stream_info *stream;
+	struct snd_pcm_substream *substream;
+	struct snd_sst_tstamp fw_tstamp;
+	unsigned int str_id;
+
+	str_id = info->str_id;
+	stream = get_stream_info(str_id);
+	if (!stream)
+		return -EINVAL;
+
+	if (!stream->pcm_substream)
+		return -EINVAL;
+	substream = stream->pcm_substream;
+
+	memcpy_fromio(&fw_tstamp,
+		((void *)(sst_drv_ctx->mailbox + sst_drv_ctx->tstamp)
+			+ (str_id * sizeof(fw_tstamp))),
+		sizeof(fw_tstamp));
+	return sst_calc_tstamp(info, substream, &fw_tstamp);
+}
+
+/*
+ * sst_device_control - Set Control params
+ *
+ * @cmd: control cmd to be set
+ * @arg: command argument
+ *
+ * This function is called by MID sound card driver to set
+ * SST/Sound card controls for an opened stream.
+ * This is registered with MID driver
+ */
+static int sst_device_control(int cmd, void *arg)
+{
+	int retval = 0, str_id = 0;
+
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+
+	switch (cmd) {
+	case SST_SND_START: {
+		struct stream_info *str_info;
+		int ipc;
+
+		str_id = *(int *)arg;
+		str_info = get_stream_info(str_id);
+		if (!str_info)
+			return -EINVAL;
+		ipc = IPC_IA_START_STREAM;
+		str_info->prev = str_info->status;
+		str_info->status = STREAM_RUNNING;
+		sst_start_stream(str_id);
+		break;
+	}
+	case SST_SND_DROP: {
+		struct stream_info *str_info;
+		int ipc;
+
+		str_id = *(int *)arg;
+		str_info = get_stream_info(str_id);
+		if (!str_info)
+			return -EINVAL;
+		ipc = IPC_IA_DROP_STREAM;
+		str_info->prev = STREAM_UN_INIT;
+		str_info->status = STREAM_INIT;
+		retval = sst_drop_stream(str_id);
+		break;
+	}
+	case SST_SND_STREAM_INIT: {
+		struct pcm_stream_info *str_info;
+		struct stream_info *stream;
+
+		pr_debug("stream init called\n");
+		str_info = (struct pcm_stream_info *)arg;
+		str_id = str_info->str_id;
+		stream = get_stream_info(str_id);
+		if (!stream) {
+			retval = -EINVAL;
+			break;
+		}
+		pr_debug("setting the period ptrs\n");
+		stream->pcm_substream = str_info->arg;
+		stream->period_elapsed = str_info->period_elapsed;
+		stream->sfreq = str_info->sfreq;
+		stream->prev = stream->status;
+		stream->status = STREAM_INIT;
+		pr_debug("pcm_substream %p, period_elapsed %p, sfreq %d, status %d\n",
+				stream->pcm_substream, stream->period_elapsed, stream->sfreq, stream->status);
+		break;
+	}
+
+	case SST_SND_BUFFER_POINTER: {
+		struct pcm_stream_info *stream_info;
+
+		stream_info = (struct pcm_stream_info *)arg;
+		retval = sst_read_timestamp(stream_info);
+		pr_debug("pointer %llu, delay %llu\n",
+			stream_info->buffer_ptr, stream_info->pcm_delay);
+		break;
+	}
+	default:
+		/* Illegal case */
+		pr_warn("illegal req\n");
+		return -EINVAL;
+	}
+
+	return retval;
+}
+
+/*
+ * sst_set_generic_params - Set generic params
+ *
+ * @cmd: control cmd to be set
+ * @arg: command argument
+ *
+ * This function is called by MID sound card driver to configure
+ * SST runtime params.
+ */
+static int sst_set_generic_params(enum sst_controls cmd, void *arg)
+{
+	int ret_val = 0;
+
+	if (NULL == arg)
+		return -EINVAL;
+
+	switch (cmd) {
+	case SST_SET_BYTE_STREAM: {
+		ret_val = intel_sst_check_device();
+		if (ret_val)
+			return ret_val;
+
+		ret_val = sst_send_byte_stream_mrfld(arg);
+		sst_pm_runtime_put(sst_drv_ctx);
+		break;
+	}
+	default:
+		pr_err("Invalid cmd request:%d\n", cmd);
+		ret_val = -EINVAL;
+	}
+	return ret_val;
+}
+
+static struct sst_ops pcm_ops = {
+	.open = sst_open_pcm_stream,
+	.device_control = sst_device_control,
+	.set_generic_params = sst_set_generic_params,
+	.close = sst_close_pcm_stream,
+};
+
+static struct sst_device sst_dsp_device = {
+	.name = "Intel(R) SST LPE",
+	.dev = NULL,
+	.ops = &pcm_ops,
+};
+
+/*
+ * register_sst - function to register DSP
+ *
+ * This functions registers DSP with the platform driver
+ */
+int register_sst(struct device *dev)
+{
+	int ret_val;
+
+	sst_dsp_device.dev = dev;
+	ret_val = sst_register_dsp(&sst_dsp_device);
+	if (ret_val)
+		pr_err("Unable to register DSP with platform driver\n");
+
+	return ret_val;
+}
+
+int unregister_sst(struct device *dev)
+{
+	return sst_unregister_dsp(&sst_dsp_device);
+}
diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/sst/sst_ipc.c
new file mode 100644
index 0000000..7287524
--- /dev/null
+++ b/sound/soc/intel/sst/sst_ipc.c
@@ -0,0 +1,368 @@
+/*
+ *  sst_ipc.c - Intel SST Driver for audio engine
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
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
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
+struct sst_block *sst_create_block(struct intel_sst_drv *ctx,
+					u32 msg_id, u32 drv_id)
+{
+	struct sst_block *msg = NULL;
+
+	pr_debug("in %s\n", __func__);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		pr_err("kzalloc block failed\n");
+		return NULL;
+	}
+	msg->condition = false;
+	msg->on = true;
+	msg->msg_id = msg_id;
+	msg->drv_id = drv_id;
+	spin_lock_bh(&ctx->block_lock);
+	list_add_tail(&msg->node, &ctx->block_list);
+	spin_unlock_bh(&ctx->block_lock);
+
+	return msg;
+}
+
+int sst_wake_up_block(struct intel_sst_drv *ctx, int result,
+		u32 drv_id, u32 ipc, void *data, u32 size)
+{
+	struct sst_block *block = NULL;
+
+	pr_debug("in %s\n", __func__);
+	spin_lock_bh(&ctx->block_lock);
+	list_for_each_entry(block, &ctx->block_list, node) {
+		pr_debug("Block ipc %d, drv_id %d\n", block->msg_id,
+							block->drv_id);
+		if (block->msg_id == ipc && block->drv_id == drv_id) {
+			pr_debug("free up the block\n");
+			block->ret_code = result;
+			block->data = data;
+			block->size = size;
+			block->condition = true;
+			spin_unlock_bh(&ctx->block_lock);
+			wake_up(&ctx->wait_queue);
+			return 0;
+		}
+	}
+	spin_unlock_bh(&ctx->block_lock);
+	pr_debug("Block not found or a response is received for a short message for ipc %d, drv_id %d\n",
+			ipc, drv_id);
+	return -EINVAL;
+}
+
+int sst_free_block(struct intel_sst_drv *ctx, struct sst_block *freed)
+{
+	struct sst_block *block = NULL, *__block;
+
+	pr_debug("in %s\n", __func__);
+	spin_lock_bh(&ctx->block_lock);
+	list_for_each_entry_safe(block, __block, &ctx->block_list, node) {
+		if (block == freed) {
+			list_del(&freed->node);
+			kfree(freed->data);
+			freed->data = NULL;
+			kfree(freed);
+			spin_unlock_bh(&ctx->block_lock);
+			return 0;
+		}
+	}
+	spin_unlock_bh(&ctx->block_lock);
+	return -EINVAL;
+}
+
+void sst_post_message_mrfld(struct work_struct *work)
+{
+	struct ipc_post *msg;
+	union ipc_header_mrfld header;
+	unsigned long irq_flags;
+
+	pr_debug("Enter:%s\n", __func__);
+	spin_lock_irqsave(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+	/* check list */
+	if (list_empty(&sst_drv_ctx->ipc_dispatch_list)) {
+		/* queue is empty, nothing to send */
+		spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+		pr_debug("Empty msg queue... NO Action\n");
+		return;
+	}
+
+	/* check busy bit */
+	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
+	if (header.p.header_high.part.busy) {
+		spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+		pr_debug("Busy not free... post later\n");
+		return;
+	}
+	/* copy msg from list */
+	msg = list_entry(sst_drv_ctx->ipc_dispatch_list.next,
+			struct ipc_post, node);
+	list_del(&msg->node);
+	pr_debug("sst: size: = %x\n", msg->mrfld_header.p.header_low_payload);
+	if (msg->mrfld_header.p.header_high.part.large)
+		memcpy_toio(sst_drv_ctx->mailbox + SST_MAILBOX_SEND,
+			    msg->mailbox_data, msg->mrfld_header.p.header_low_payload);
+
+	sst_shim_write64(sst_drv_ctx->shim, SST_IPCX, msg->mrfld_header.full);
+	spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+	pr_debug("sst: Post message: header = %x\n",
+					msg->mrfld_header.p.header_high.full);
+	kfree(msg->mailbox_data);
+	kfree(msg);
+}
+
+int sst_sync_post_message_mrfld(struct ipc_post *msg)
+{
+	union ipc_header_mrfld header;
+	unsigned int loop_count = 0;
+	int retval = 0;
+	unsigned long irq_flags;
+
+	pr_debug("Enter:%s\n", __func__);
+	spin_lock_irqsave(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+
+	/* check busy bit */
+	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
+	while (header.p.header_high.part.busy) {
+		if (loop_count > 10) {
+			pr_err("sst: Busy wait failed, cant send this msg\n");
+			retval = -EBUSY;
+			goto out;
+		}
+		udelay(500);
+		loop_count++;
+		header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
+	}
+	pr_debug("sst: Post message: header = %x\n",
+					msg->mrfld_header.p.header_high.full);
+	pr_debug("sst: size = 0x%x\n", msg->mrfld_header.p.header_low_payload);
+	if (msg->mrfld_header.p.header_high.part.large)
+		memcpy_toio(sst_drv_ctx->mailbox + SST_MAILBOX_SEND,
+			msg->mailbox_data, msg->mrfld_header.p.header_low_payload);
+
+	sst_shim_write64(sst_drv_ctx->shim, SST_IPCX, msg->mrfld_header.full);
+
+out:
+	spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+	kfree(msg->mailbox_data);
+	kfree(msg);
+	return retval;
+}
+
+void intel_sst_clear_intr_mrfld(void)
+{
+	union interrupt_reg_mrfld isr;
+	union interrupt_reg_mrfld imr;
+	union ipc_header_mrfld clear_ipc;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+	imr.full = sst_shim_read64(sst_drv_ctx->shim, SST_IMRX);
+	isr.full = sst_shim_read64(sst_drv_ctx->shim, SST_ISRX);
+
+	/*  write 1 to clear  */
+	isr.part.busy_interrupt = 1;
+	sst_shim_write64(sst_drv_ctx->shim, SST_ISRX, isr.full);
+
+	/* Set IA done bit */
+	clear_ipc.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCD);
+
+	clear_ipc.p.header_high.part.busy = 0;
+	clear_ipc.p.header_high.part.done = 1;
+	clear_ipc.p.header_low_payload = IPC_ACK_SUCCESS;
+	sst_shim_write64(sst_drv_ctx->shim, SST_IPCD, clear_ipc.full);
+	/* un mask busy interrupt */
+	imr.part.busy_interrupt = 0;
+	sst_shim_write64(sst_drv_ctx->shim, SST_IMRX, imr.full);
+	spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+}
+
+
+/*
+ * process_fw_init - process the FW init msg
+ *
+ * @msg: IPC message mailbox data from FW
+ *
+ * This function processes the FW init msg from FW
+ * marks FW state and prints debug info of loaded FW
+ */
+static void process_fw_init(void *msg)
+{
+	struct ipc_header_fw_init *init =
+		(struct ipc_header_fw_init *)msg;
+	int retval = 0;
+
+	pr_debug("*** FW Init msg came***\n");
+	if (init->result) {
+		sst_drv_ctx->sst_state =  SST_RESET;
+		pr_debug("FW Init failed, Error %x\n", init->result);
+		pr_err("FW Init failed, Error %x\n", init->result);
+		retval = init->result;
+		goto ret;
+	}
+	pr_info("FW Version %02x.%02x.%02x.%02x\n",
+		init->fw_version.type, init->fw_version.major,
+		init->fw_version.minor, init->fw_version.build);
+	pr_info("Build date %s Time %s\n",
+			init->build_info.date, init->build_info.time);
+
+ret:
+	sst_wake_up_block(sst_drv_ctx, retval, FW_DWNL_ID, 0 , NULL, 0);
+}
+
+static void process_fw_async_msg(struct ipc_post *msg)
+{
+	u32 msg_id;
+	int str_id;
+	u32 data_size, i;
+	void *data_offset;
+	struct stream_info *stream;
+	union ipc_header_high msg_high;
+	u32 msg_low, pipe_id;
+
+	msg_high = msg->mrfld_header.p.header_high;
+	msg_low = msg->mrfld_header.p.header_low_payload;
+	msg_id = ((struct ipc_dsp_hdr *)msg->mailbox_data)->cmd_id;
+	data_offset = (msg->mailbox_data + sizeof(struct ipc_dsp_hdr));
+	data_size =  msg_low - (sizeof(struct ipc_dsp_hdr));
+
+	switch (msg_id) {
+	case IPC_SST_PERIOD_ELAPSED_MRFLD:
+		pipe_id = ((struct ipc_dsp_hdr *)msg->mailbox_data)->pipe_id;
+		str_id = get_stream_id_mrfld(pipe_id);
+		if (str_id > 0) {
+			pr_debug("Period elapsed rcvd for pipe id 0x%x\n", pipe_id);
+			stream = &sst_drv_ctx->streams[str_id];
+			if (stream->period_elapsed)
+				stream->period_elapsed(stream->pcm_substream);
+			if (stream->compr_cb)
+				stream->compr_cb(stream->compr_cb_param);
+		}
+		break;
+
+	case IPC_IA_DRAIN_STREAM_MRFLD:
+		pipe_id = ((struct ipc_dsp_hdr *)msg->mailbox_data)->pipe_id;
+		str_id = get_stream_id_mrfld(pipe_id);
+		if (str_id > 0) {
+			stream = &sst_drv_ctx->streams[str_id];
+			if (stream->drain_notify)
+				stream->drain_notify(stream->drain_cb_param);
+		}
+		break;
+
+	case IPC_IA_FW_ASYNC_ERR_MRFLD:
+		pr_err("FW sent async error msg:\n");
+		for (i = 0; i < (data_size/4); i++)
+			pr_err("0x%x\n", (*((unsigned int *)data_offset + i)));
+		break;
+
+	case IPC_IA_FW_INIT_CMPLT_MRFLD:
+		process_fw_init(data_offset);
+		break;
+
+	case IPC_IA_BUF_UNDER_RUN_MRFLD:
+		pipe_id = ((struct ipc_dsp_hdr *)msg->mailbox_data)->pipe_id;
+		str_id = get_stream_id_mrfld(pipe_id);
+		if (str_id > 0)
+			pr_err("Buffer under-run for pipe:%#x str_id:%d\n",
+					pipe_id, str_id);
+		break;
+
+	default:
+		pr_err("Unrecognized async msg from FW msg_id %#x\n", msg_id);
+	}
+}
+
+void sst_process_reply_mrfld(struct ipc_post *msg)
+{
+	unsigned int drv_id;
+	void *data;
+	union ipc_header_high msg_high;
+	u32 msg_low;
+	struct ipc_dsp_hdr *dsp_hdr;
+	unsigned int cmd_id;
+
+	msg_high = msg->mrfld_header.p.header_high;
+	msg_low = msg->mrfld_header.p.header_low_payload;
+
+	pr_debug("IPC process message header %x payload %x\n",
+			msg->mrfld_header.p.header_high.full,
+			msg->mrfld_header.p.header_low_payload);
+
+	drv_id = msg_high.part.drv_id;
+
+	/* Check for async messages */
+	if (drv_id == SST_ASYNC_DRV_ID) {
+		/* FW sent async large message */
+		process_fw_async_msg(msg);
+		return;
+	}
+
+	/* FW sent short error response for an IPC */
+	if (msg_high.part.result && drv_id && !msg_high.part.large) {
+		/* 32-bit FW error code in msg_low */
+		pr_err("FW sent error response 0x%x", msg_low);
+		sst_wake_up_block(sst_drv_ctx, msg_high.part.result,
+			msg_high.part.drv_id,
+			msg_high.part.msg_id, NULL, 0);
+		return;
+	}
+
+	/* Process all valid responses */
+	/* if it is a large message, the payload contains the size to
+	 * copy from mailbox */
+	if (msg_high.part.large) {
+		data = kzalloc(msg_low, GFP_KERNEL);
+		if (!data)
+			return;
+		memcpy(data, (void *) msg->mailbox_data, msg_low);
+		/* Copy command id so that we can use to put sst to reset */
+		dsp_hdr = (struct ipc_dsp_hdr *)data;
+		cmd_id = dsp_hdr->cmd_id;
+		pr_debug("cmd_id %d\n", dsp_hdr->cmd_id);
+		if (sst_wake_up_block(sst_drv_ctx, msg_high.part.result,
+				msg_high.part.drv_id,
+				msg_high.part.msg_id, data, msg_low))
+			kfree(data);
+	} else {
+		sst_wake_up_block(sst_drv_ctx, msg_high.part.result,
+				msg_high.part.drv_id,
+				msg_high.part.msg_id, NULL, 0);
+	}
+
+}
diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
new file mode 100644
index 0000000..35e7e6b
--- /dev/null
+++ b/sound/soc/intel/sst/sst_loader.c
@@ -0,0 +1,951 @@
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
+static struct sst_module_info sst_modules_mrfld[] = {
+	{"mp3_dec", SST_CODEC_TYPE_MP3, 0, SST_LIB_NOT_FOUND},
+	{"aac_dec", SST_CODEC_TYPE_AAC, 0, SST_LIB_NOT_FOUND},
+};
+
+/**
+ * intel_sst_reset_dsp_mrfld - Resetting SST DSP
+ *
+ * This resets DSP in case of MRFLD platfroms
+ */
+int intel_sst_reset_dsp_mrfld(void)
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
+int sst_start_mrfld(void)
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
+			Elf32_Phdr *pr, void **dstn, unsigned int *dstn_phys, int *mem_type)
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
+	struct fw_header *header;
+
+	pr_debug("%s\n", __func__);
+
+	/* Read the header information from the data pointer */
+	header = (struct fw_header *)sst_fw_in_mem;
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
+ * @module		: FW module header
+ * @memcpy_list	: Pointer to the list to be populated
+ * Create the memcpy list as the number of block to be copied
+ * returns error or 0 if module sizes are proper
+ */
+static int sst_parse_module_memcpy(struct fw_module_header *module,
+				struct list_head *memcpy_list)
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
+ * @sst_fw_in_mem	: pointer to audio fw
+ * @size		: size of the firmware
+ * @fw_list		: pointer to list_head to be populated
+ * This function parses the FW image and saves the parsed image in the list
+ * for memcpy
+ */
+static int sst_parse_fw_memcpy(const void *sst_fw_in_mem, unsigned long size,
+				struct list_head *fw_list)
+{
+	struct fw_module_header *module;
+	u32 count, num_modules;
+	int ret_val;
+
+	ret_val = sst_validate_fw_image(sst_fw_in_mem, size,
+				&module, &num_modules);
+	if (ret_val)
+		return ret_val;
+
+	for (count = 0; count < num_modules; count++) {
+		/* module */
+		ret_val = sst_parse_module_memcpy(module, fw_list);
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
+			memcpy_toio((void __iomem *)listnode->dstn, listnode->src,
+							listnode->size);
+		else
+			memcpy(listnode->dstn, listnode->src, listnode->size);
+	}
+}
+
+static void sst_memcpy_free_lib_resources(void)
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
+void sst_memcpy_free_resources(void)
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
+	sst_memcpy_free_lib_resources();
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
+	mutex_lock(&sst_drv_ctx->sst_lock);
+
+	if (sst_drv_ctx->sst_state != SST_RESET ||
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
+	if (!ctx->fw_in_mem) {
+		pr_err("%s unable to allocate memory\n", __func__);
+		goto out;
+	}
+
+	pr_debug("copied fw to %p", ctx->fw_in_mem);
+	pr_debug("phys: %lx", (unsigned long)virt_to_phys(ctx->fw_in_mem));
+	memcpy(ctx->fw_in_mem, fw->data, fw->size);
+
+	if (ctx->info.use_elf == true)
+		ret = sst_parse_elf_fw_memcpy(ctx, ctx->fw_in_mem,
+						&ctx->memcpy_list);
+	else
+		ret = sst_parse_fw_memcpy(ctx->fw_in_mem, fw->size,
+						&ctx->memcpy_list);
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
+	mutex_unlock(&sst_drv_ctx->sst_lock);
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
+		pr_err("%s unable to allocate memory\n", __func__);
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
+		retval = sst_parse_fw_memcpy(sst->fw_in_mem, fw->size,
+							&sst->memcpy_list);
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
+static void sst_dccm_config_write(void __iomem *dram_base, unsigned int ddr_base)
+{
+	void __iomem *addr;
+	u32 bss_reset = 0;
+
+	addr = (void __iomem *)(dram_base + MRFLD_FW_DDR_BASE_OFFSET);
+	memcpy_toio(addr, (void *)&ddr_base, sizeof(u32));
+	bss_reset |= (1 << MRFLD_FW_BSS_RESET_BIT);
+	addr = (void __iomem *)(dram_base + MRFLD_FW_FEATURE_BASE_OFFSET);
+	memcpy_toio(addr, &bss_reset, sizeof(u32));
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
+		sst_load_all_modules_elf(ctx, sst_modules_mrfld, ARRAY_SIZE(sst_modules_mrfld));
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
+int sst_load_fw(void)
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
+	ret_val = sst_drv_ctx->ops->reset();
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
+	ret_val = sst_drv_ctx->ops->start();
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
+restore:
+	/* Re-enable Deeper C-states beyond C6 */
+	pm_qos_update_request(sst_drv_ctx->qos, PM_QOS_DEFAULT_VALUE);
+	sst_free_block(sst_drv_ctx, block);
+
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
+	sst_memcpy_free_lib_resources();
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
+	if (!*out_elf) {
+		pr_err("cannot alloc mem for elf copy %d\n", retval);
+		goto mem_error;
+	}
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
+int sst_load_all_modules_elf(struct intel_sst_drv *ctx, struct sst_module_info *mod_table,
+								int num_modules)
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
diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/sst/sst_pvt.c
new file mode 100644
index 0000000..ac07dcd
--- /dev/null
+++ b/sound/soc/intel/sst/sst_pvt.c
@@ -0,0 +1,208 @@
+/*
+ *  sst_pvt.c - Intel SST Driver for audio engine
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
+ *  This file contains all private functions
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kobject.h>
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <sound/asound.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+#include "../sst-dsp.h"
+
+/*
+ * sst_wait_interruptible - wait on event
+ *
+ * @sst_drv_ctx: Driver context
+ * @block: Driver block to wait on
+ *
+ * This function waits without a timeout (and is interruptable) for a
+ * given block event
+ */
+int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
+				struct sst_block *block)
+{
+	int retval = 0;
+
+	if (!wait_event_interruptible(sst_drv_ctx->wait_queue,
+				block->condition)) {
+		/* event wake */
+		if (block->ret_code < 0) {
+			pr_err("stream failed %d\n", block->ret_code);
+			retval = -EBUSY;
+		} else {
+			pr_debug("event up\n");
+			retval = 0;
+		}
+	} else {
+		pr_err("signal interrupted\n");
+		retval = -EINTR;
+	}
+	return retval;
+
+}
+
+unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
+{
+	unsigned long long val = 0;
+
+	switch (sst->pci_id) {
+	case SST_MRFLD_PCI_ID:
+		val = sst_shim_read64(sst->shim, addr);
+		break;
+	}
+	return val;
+}
+
+void write_shim_data(struct intel_sst_drv *sst, int addr,
+				unsigned long long data)
+{
+	switch (sst->pci_id) {
+	case SST_MRFLD_PCI_ID:
+		sst_shim_write64(sst->shim, addr, (u64) data);
+		break;
+	}
+}
+
+/*
+ * sst_wait_timeout - wait on event for timeout
+ *
+ * @sst_drv_ctx: Driver context
+ * @block: Driver block to wait on
+ *
+ * This function waits with a timeout value (and is not interruptible) on a
+ * given block event
+ */
+int sst_wait_timeout(struct intel_sst_drv *sst_drv_ctx, struct sst_block *block)
+{
+	int retval = 0;
+
+	/* NOTE:
+	Observed that FW processes the alloc msg and replies even
+	before the alloc thread has finished execution */
+	pr_debug("sst: waiting for condition %x ipc %d drv_id %d\n",
+		       block->condition, block->msg_id, block->drv_id);
+	if (wait_event_timeout(sst_drv_ctx->wait_queue,
+				block->condition,
+				msecs_to_jiffies(SST_BLOCK_TIMEOUT))) {
+		/* event wake */
+		pr_debug("sst: Event wake %x\n", block->condition);
+		pr_debug("sst: message ret: %d\n", block->ret_code);
+		retval = -block->ret_code;
+	} else {
+		block->on = false;
+		pr_err("sst: Wait timed-out condition:%#x, msg_id:%#x fw_state %#x\n",
+				block->condition, block->msg_id, sst_drv_ctx->sst_state);
+
+		retval = -EBUSY;
+	}
+	return retval;
+}
+
+/*
+ * sst_create_ipc_msg - create a IPC message
+ *
+ * @arg: ipc message
+ * @large: large or short message
+ *
+ * this function allocates structures to send a large or short
+ * message to the firmware
+ */
+int sst_create_ipc_msg(struct ipc_post **arg, bool large)
+{
+	struct ipc_post *msg;
+
+	msg = kzalloc(sizeof(struct ipc_post), GFP_ATOMIC);
+	if (!msg) {
+		pr_err("kzalloc ipc msg failed\n");
+		return -ENOMEM;
+	}
+	if (large) {
+		msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_ATOMIC);
+		if (!msg->mailbox_data) {
+			kfree(msg);
+			pr_err("kzalloc mailbox_data failed");
+			return -ENOMEM;
+		}
+	} else {
+		msg->mailbox_data = NULL;
+	}
+	msg->is_large = large;
+	*arg = msg;
+	return 0;
+}
+
+/*
+ * sst_create_block_and_ipc_msg - Creates IPC message and sst block
+ * @arg: passed to sst_create_ipc_message API
+ * @large: large or short message
+ * @sst_drv_ctx: sst driver context
+ * @block: return block allocated
+ * @msg_id: IPC
+ * @drv_id: stream id or private id
+ */
+int sst_create_block_and_ipc_msg(struct ipc_post **arg, bool large,
+		struct intel_sst_drv *sst_drv_ctx, struct sst_block **block,
+		u32 msg_id, u32 drv_id)
+{
+	int retval = 0;
+
+	retval = sst_create_ipc_msg(arg, large);
+	if (retval)
+		return retval;
+	*block = sst_create_block(sst_drv_ctx, msg_id, drv_id);
+	if (*block == NULL) {
+		kfree(*arg);
+		return -ENOMEM;
+	}
+	return retval;
+}
+
+/*
+ * sst_clean_stream - clean the stream context
+ *
+ * @stream: stream structure
+ *
+ * this function resets the stream contexts
+ * should be called in free
+ */
+void sst_clean_stream(struct stream_info *stream)
+{
+	stream->status = STREAM_UN_INIT;
+	stream->prev = STREAM_UN_INIT;
+	mutex_lock(&stream->lock);
+	stream->cumm_bytes = 0;
+	mutex_unlock(&stream->lock);
+}
+
diff --git a/sound/soc/intel/sst/sst_stream.c b/sound/soc/intel/sst/sst_stream.c
new file mode 100644
index 0000000..b6c8772
--- /dev/null
+++ b/sound/soc/intel/sst/sst_stream.c
@@ -0,0 +1,534 @@
+/*
+ *  sst_stream.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-14 Intel Corp
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
+ *  This file contains the stream operations of SST driver
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+#include "../sst-dsp.h"
+
+int sst_alloc_stream_mrfld(char *params, struct sst_block *block)
+{
+	struct ipc_post *msg = NULL;
+	struct snd_sst_alloc_mrfld alloc_param;
+	struct ipc_dsp_hdr dsp_hdr;
+	struct snd_sst_params *str_params;
+	struct snd_sst_tstamp fw_tstamp;
+	unsigned int str_id, pipe_id, pvt_id, task_id;
+	u32 len = 0;
+	struct stream_info *str_info;
+	int i, num_ch;
+
+	pr_debug("In %s\n", __func__);
+	BUG_ON(!params);
+
+	str_params = (struct snd_sst_params *)params;
+	memset(&alloc_param, 0, sizeof(alloc_param));
+	alloc_param.operation = str_params->ops;
+	alloc_param.codec_type = str_params->codec;
+	alloc_param.sg_count = str_params->aparams.sg_count;
+	alloc_param.ring_buf_info[0].addr = str_params->aparams.ring_buf_info[0].addr;
+	alloc_param.ring_buf_info[0].size = str_params->aparams.ring_buf_info[0].size;
+	alloc_param.frag_size = str_params->aparams.frag_size;
+
+	memcpy(&alloc_param.codec_params, &str_params->sparams,
+			sizeof(struct snd_sst_stream_params));
+
+	/* fill channel map params for multichannel support.
+	 * Ideally channel map should be received from upper layers
+	 * for multichannel support.
+	 * Currently hardcoding as per FW reqm.
+	 */
+	num_ch = sst_get_num_channel(str_params);
+	for (i = 0; i < 8; i++) {
+		if (i < num_ch)
+			alloc_param.codec_params.uc.pcm_params.channel_map[i] = i;
+		else
+			alloc_param.codec_params.uc.pcm_params.channel_map[i] = 0xFF;
+	}
+
+	str_id = str_params->stream_id;
+	pipe_id = str_params->device_type;
+	task_id = str_params->task;
+	sst_drv_ctx->streams[str_id].pipe_id = pipe_id;
+	sst_drv_ctx->streams[str_id].task_id = task_id;
+	sst_drv_ctx->streams[str_id].num_ch = num_ch;
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	if (sst_drv_ctx->info.lpe_viewpt_rqd)
+		alloc_param.ts = sst_drv_ctx->info.mailbox_start +
+			sst_drv_ctx->tstamp + (str_id * sizeof(fw_tstamp));
+	else
+		alloc_param.ts = sst_drv_ctx->mailbox_add +
+			sst_drv_ctx->tstamp + (str_id * sizeof(fw_tstamp));
+
+	pr_debug("alloc tstamp location = 0x%x\n", alloc_param.ts);
+	pr_debug("assigned pipe id 0x%x to task %d\n", pipe_id, task_id);
+
+	/*allocate device type context*/
+	sst_init_stream(&sst_drv_ctx->streams[str_id], alloc_param.codec_type,
+			str_id, alloc_param.operation, 0);
+	/* send msg to FW to allocate a stream */
+	if (sst_create_ipc_msg(&msg, true))
+		return -ENOMEM;
+
+	block->drv_id = pvt_id;
+	block->msg_id = IPC_CMD;
+
+	sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+			      task_id, 1, pvt_id);
+	pr_debug("header:%x\n", msg->mrfld_header.p.header_high.full);
+	msg->mrfld_header.p.header_high.part.res_rqd = 1;
+
+	len = msg->mrfld_header.p.header_low_payload = sizeof(alloc_param) + sizeof(dsp_hdr);
+	sst_fill_header_dsp(&dsp_hdr, IPC_IA_ALLOC_STREAM_MRFLD, pipe_id, sizeof(alloc_param));
+	memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+	memcpy(msg->mailbox_data + sizeof(dsp_hdr), &alloc_param,
+			sizeof(alloc_param));
+	str_info = &sst_drv_ctx->streams[str_id];
+	pr_debug("header:%x\n", msg->mrfld_header.p.header_high.full);
+	pr_debug("response rqd: %x", msg->mrfld_header.p.header_high.part.res_rqd);
+	pr_debug("calling post_message\n");
+	pr_info("Alloc for str %d pipe %#x\n", str_id, pipe_id);
+
+	sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
+	return str_id;
+}
+
+/**
+* sst_stream_stream - Send msg for a pausing stream
+* @str_id:	 stream ID
+*
+* This function is called by any function which wants to start
+* a stream.
+*/
+int sst_start_stream(int str_id)
+{
+	int retval = 0, pvt_id;
+	u32 len = 0;
+	struct ipc_post *msg = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+	struct stream_info *str_info;
+
+	pr_debug("sst_start_stream for %d\n", str_id);
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+	if (str_info->status != STREAM_RUNNING)
+		return -EBADRQC;
+
+	if (sst_create_ipc_msg(&msg, true))
+		return -ENOMEM;
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	pr_debug("pvt_id = %d, pipe id = %d, task = %d\n",
+		 pvt_id, str_info->pipe_id, str_info->task_id);
+	sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+			      str_info->task_id, 1, pvt_id);
+
+	len = sizeof(u16) + sizeof(dsp_hdr);
+	msg->mrfld_header.p.header_low_payload = len;
+	sst_fill_header_dsp(&dsp_hdr, IPC_IA_START_STREAM_MRFLD,
+			str_info->pipe_id, sizeof(u16));
+	memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+	memset(msg->mailbox_data + sizeof(dsp_hdr), 0, sizeof(u16));
+
+	sst_drv_ctx->ops->sync_post_message(msg);
+	return retval;
+}
+
+int sst_send_byte_stream_mrfld(void *sbytes)
+{
+	struct ipc_post *msg = NULL;
+	struct snd_sst_bytes_v2 *bytes = (struct snd_sst_bytes_v2 *) sbytes;
+	u32 length;
+	int pvt_id, ret = 0;
+	struct sst_block *block = NULL;
+
+	pr_debug("%s: type:%u ipc_msg:%u block:%u task_id:%u pipe: %#x length:%#x\n",
+		__func__, bytes->type, bytes->ipc_msg,
+		bytes->block, bytes->task_id,
+		bytes->pipe_id, bytes->len);
+
+	/* need some err check as this is user data, perhpas move this to the
+	 * platform driver and pass the struct
+	 */
+	if (sst_create_ipc_msg(&msg, true))
+		return -ENOMEM;
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	sst_fill_header_mrfld(&msg->mrfld_header, bytes->ipc_msg, bytes->task_id,
+			      1, pvt_id);
+	msg->mrfld_header.p.header_high.part.res_rqd = bytes->block;
+	length = bytes->len;
+	msg->mrfld_header.p.header_low_payload = length;
+	pr_debug("length is %d\n", length);
+	memcpy(msg->mailbox_data, &bytes->bytes, bytes->len);
+	if (bytes->block) {
+		block = sst_create_block(sst_drv_ctx, bytes->ipc_msg, pvt_id);
+		if (block == NULL) {
+			kfree(msg);
+			return -ENOMEM;
+		}
+	}
+	sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
+	pr_debug("msg->mrfld_header.p.header_low_payload:%d", msg->mrfld_header.p.header_low_payload);
+	if (bytes->block) {
+		ret = sst_wait_timeout(sst_drv_ctx, block);
+		if (ret) {
+			pr_err("%s: fw returned err %d\n", __func__, ret);
+			sst_free_block(sst_drv_ctx, block);
+			return ret;
+		}
+	}
+	if (bytes->type == SND_SST_BYTES_GET) {
+		/* copy the reply and send back
+		 * we need to update only sz and payload
+		 */
+		if (bytes->block) {
+			unsigned char *r = block->data;
+
+			pr_debug("read back %d bytes", bytes->len);
+			memcpy(bytes->bytes, r, bytes->len);
+		}
+	}
+	if (bytes->block)
+		sst_free_block(sst_drv_ctx, block);
+	return 0;
+}
+
+/*
+ * sst_pause_stream - Send msg for a pausing stream
+ * @str_id:	 stream ID
+ *
+ * This function is called by any function which wants to pause
+ * an already running stream.
+ */
+int sst_pause_stream(int str_id)
+{
+	int retval = 0, pvt_id, len;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct intel_sst_ops *ops;
+	struct sst_block *block;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_pause_stream for %d\n", str_id);
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+	ops = sst_drv_ctx->ops;
+	if (str_info->status == STREAM_PAUSED)
+		return 0;
+	if (str_info->status == STREAM_RUNNING ||
+		str_info->status == STREAM_INIT) {
+		if (str_info->prev == STREAM_UN_INIT)
+			return -EBADRQC;
+		pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+		retval = sst_create_block_and_ipc_msg(&msg, true,
+				sst_drv_ctx, &block, IPC_CMD, pvt_id);
+		if (retval)
+			return retval;
+		sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+				str_info->task_id, 1, pvt_id);
+		msg->mrfld_header.p.header_high.part.res_rqd = 1;
+		len = sizeof(dsp_hdr);
+		msg->mrfld_header.p.header_low_payload = len;
+		sst_fill_header_dsp(&dsp_hdr, IPC_IA_PAUSE_STREAM_MRFLD,
+					str_info->pipe_id, 0);
+		memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+		sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
+		retval = sst_wait_timeout(sst_drv_ctx, block);
+		sst_free_block(sst_drv_ctx, block);
+		if (retval == 0) {
+			str_info->prev = str_info->status;
+			str_info->status = STREAM_PAUSED;
+		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+			retval = -EINVAL;
+			mutex_lock(&sst_drv_ctx->sst_lock);
+			sst_clean_stream(str_info);
+			mutex_unlock(&sst_drv_ctx->sst_lock);
+		}
+	} else {
+		retval = -EBADRQC;
+		pr_debug("SST DBG:BADRQC for stream\n ");
+	}
+
+	return retval;
+}
+
+/**
+ * sst_resume_stream - Send msg for resuming stream
+ * @str_id:		stream ID
+ *
+ * This function is called by any function which wants to resume
+ * an already paused stream.
+ */
+int sst_resume_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct intel_sst_ops *ops;
+	struct sst_block *block = NULL;
+	int pvt_id, len;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_resume_stream for %d\n", str_id);
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+	ops = sst_drv_ctx->ops;
+	if (str_info->status == STREAM_RUNNING)
+			return 0;
+	if (str_info->status == STREAM_PAUSED) {
+		pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+		retval = sst_create_block_and_ipc_msg(&msg, true,
+				sst_drv_ctx, &block, IPC_CMD, pvt_id);
+		if (retval)
+			return retval;
+		sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+				str_info->task_id, 1, pvt_id);
+		msg->mrfld_header.p.header_high.part.res_rqd = 1;
+		len = sizeof(dsp_hdr);
+		msg->mrfld_header.p.header_low_payload = len;
+		sst_fill_header_dsp(&dsp_hdr,
+					IPC_IA_RESUME_STREAM_MRFLD,
+					str_info->pipe_id, 0);
+		memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+		sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
+		retval = sst_wait_timeout(sst_drv_ctx, block);
+		sst_free_block(sst_drv_ctx, block);
+		if (!retval) {
+			if (str_info->prev == STREAM_RUNNING)
+				str_info->status = STREAM_RUNNING;
+			else
+				str_info->status = STREAM_INIT;
+			str_info->prev = STREAM_PAUSED;
+		} else if (retval == -SST_ERR_INVALID_STREAM_ID) {
+			retval = -EINVAL;
+			mutex_lock(&sst_drv_ctx->sst_lock);
+			sst_clean_stream(str_info);
+			mutex_unlock(&sst_drv_ctx->sst_lock);
+		}
+	} else {
+		retval = -EBADRQC;
+		pr_err("SST ERR: BADQRC for stream\n");
+	}
+
+	return retval;
+}
+
+
+/**
+ * sst_drop_stream - Send msg for stopping stream
+ * @str_id:		stream ID
+ *
+ * This function is called by any function which wants to stop
+ * a stream.
+ */
+int sst_drop_stream(int str_id)
+{
+	int retval = 0, pvt_id;
+	struct stream_info *str_info;
+	struct ipc_post *msg = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_drop_stream for %d\n", str_id);
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+
+	if (str_info->status != STREAM_UN_INIT) {
+
+		if (sst_create_ipc_msg(&msg, true))
+			return -ENOMEM;
+		str_info->prev = STREAM_UN_INIT;
+		str_info->status = STREAM_INIT;
+		str_info->cumm_bytes = 0;
+		pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+		sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+				      str_info->task_id, 1, pvt_id);
+		msg->mrfld_header.p.header_low_payload = sizeof(dsp_hdr);
+		sst_fill_header_dsp(&dsp_hdr, IPC_IA_DROP_STREAM_MRFLD,
+				str_info->pipe_id, 0);
+		memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+
+		sst_drv_ctx->ops->sync_post_message(msg);
+	} else {
+		retval = -EBADRQC;
+		pr_debug("BADQRC for stream, state %x\n", str_info->status);
+	}
+	return retval;
+}
+
+/**
+ * sst_next_track: notify next track
+ * @str_id:		stream ID
+ *
+ * This function is called by any function which wants to
+ * set next track. Current this is NOP as FW doest care
+ */
+int sst_next_track(void)
+{
+	pr_debug("SST DBG: next_track");
+	return 0;
+}
+
+/**
+* sst_drain_stream - Send msg for draining stream
+* @str_id:		stream ID
+*
+* This function is called by any function which wants to drain
+* a stream.
+*/
+int sst_drain_stream(int str_id, bool partial_drain)
+{
+	int retval = 0, pvt_id, len;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct intel_sst_ops *ops;
+	struct sst_block *block = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_drain_stream for %d\n", str_id);
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+	ops = sst_drv_ctx->ops;
+	if (str_info->status != STREAM_RUNNING &&
+		str_info->status != STREAM_INIT &&
+		str_info->status != STREAM_PAUSED) {
+			pr_err("SST ERR: BADQRC for stream = %d\n",
+				       str_info->status);
+			return -EBADRQC;
+	}
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	retval = sst_create_block_and_ipc_msg(&msg, true,
+			sst_drv_ctx, &block, IPC_CMD, pvt_id);
+	if (retval)
+		return retval;
+	sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+			str_info->task_id, 1, pvt_id);
+	pr_debug("header:%x\n",
+		(unsigned int)msg->mrfld_header.p.header_high.full);
+	msg->mrfld_header.p.header_high.part.res_rqd = 1;
+	len = sizeof(u8) + sizeof(dsp_hdr);
+	msg->mrfld_header.p.header_low_payload = len;
+	sst_fill_header_dsp(&dsp_hdr, IPC_IA_DRAIN_STREAM_MRFLD,
+				str_info->pipe_id, sizeof(u8));
+	memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+	memcpy(msg->mailbox_data + sizeof(dsp_hdr),
+			&partial_drain, sizeof(u8));
+	sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
+	/* with new non blocked drain implementation in core we dont need to
+	 * wait for respsonse, and need to only invoke callback for drain
+	 * complete
+	 */
+
+	sst_free_block(sst_drv_ctx, block);
+	return retval;
+}
+
+/**
+ * sst_free_stream - Frees a stream
+ * @str_id:		stream ID
+ *
+ * This function is called by any function which wants to free
+ * a stream.
+ */
+int sst_free_stream(int str_id)
+{
+	int retval = 0;
+	unsigned int pvt_id;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct intel_sst_ops *ops;
+	unsigned long irq_flags;
+	struct ipc_dsp_hdr dsp_hdr;
+	struct sst_block *block;
+
+	pr_debug("SST DBG:sst_free_stream for %d\n", str_id);
+
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	if (sst_drv_ctx->sst_state == SST_RESET) {
+		mutex_unlock(&sst_drv_ctx->sst_lock);
+		return -ENODEV;
+	}
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+	ops = sst_drv_ctx->ops;
+
+	mutex_lock(&str_info->lock);
+	if (str_info->status != STREAM_UN_INIT) {
+		str_info->prev =  str_info->status;
+		str_info->status = STREAM_UN_INIT;
+		mutex_unlock(&str_info->lock);
+
+		pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+		retval = sst_create_block_and_ipc_msg(&msg, true,
+				sst_drv_ctx, &block, IPC_CMD, pvt_id);
+		if (retval)
+			return retval;
+		sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+				      str_info->task_id, 1, pvt_id);
+		msg->mrfld_header.p.header_low_payload =
+						sizeof(dsp_hdr);
+		sst_fill_header_dsp(&dsp_hdr, IPC_IA_FREE_STREAM_MRFLD,
+					str_info->pipe_id,  0);
+		memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+		pr_info("Free for str %d pipe %#x\n", str_id, str_info->pipe_id);
+
+		spin_lock_irqsave(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+		list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+		ops->post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		retval = sst_wait_timeout(sst_drv_ctx, block);
+		pr_debug("sst: wait for free returned %d\n", retval);
+		mutex_lock(&sst_drv_ctx->sst_lock);
+		sst_clean_stream(str_info);
+		mutex_unlock(&sst_drv_ctx->sst_lock);
+		pr_debug("SST DBG:Stream freed\n");
+		sst_free_block(sst_drv_ctx, block);
+	} else {
+		mutex_unlock(&str_info->lock);
+		retval = -EBADRQC;
+		pr_debug("SST DBG:BADQRC for stream\n");
+	}
+
+	return retval;
+}
-- 
1.7.0.4
