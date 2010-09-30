From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] sst: Intel SST audio driver
Date: Thu, 30 Sep 2010 17:21:32 +0100
Message-ID: <20100930162123.21348.86482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 671C610382B
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 19:10:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: greg@kroah.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This is the Intel SST audio driver.

As compared to the previous versions it has all the printks and other stuff
noted cleaned up and more hardware support. The Aava support is disabled in
this patch (is_aava resolves to 0) because the Aava board detection logic
is not yet upstream.

The driver itself is a combination of a traditional ALSA driver and a
hardware assisted offload driver which can play audio while the processor
is asleep but which can't do all the more interactive stuff.

In the general case most software would use the ALSA interface, but the
other interface is needed for certain classes of use such as music playback
on highly power consumption sensitive devices.

This is going to staging primarily because it depends upon the staging memrar
driver.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
[Merged together and tweaked for -next]
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/Kconfig                            |    2 
 drivers/staging/Makefile                           |    1 
 drivers/staging/intel_sst/TODO                     |   12 
 drivers/staging/intel_sst/intel_sst.c              |  512 ++++++++
 drivers/staging/intel_sst/intel_sst.h              |  131 ++
 .../staging/intel_sst/intel_sst_app_interface.c    | 1234 +++++++++++++++++++
 drivers/staging/intel_sst/intel_sst_common.h       |  618 ++++++++++
 .../staging/intel_sst/intel_sst_drv_interface.c    |  492 ++++++++
 drivers/staging/intel_sst/intel_sst_dsp.c          |  486 ++++++++
 drivers/staging/intel_sst/intel_sst_fw_ipc.h       |  393 ++++++
 drivers/staging/intel_sst/intel_sst_ioctl.h        |  435 +++++++
 drivers/staging/intel_sst/intel_sst_ipc.c          |  656 ++++++++++
 drivers/staging/intel_sst/intel_sst_pvt.c          |  311 +++++
 drivers/staging/intel_sst/intel_sst_stream.c       |  575 +++++++++
 .../staging/intel_sst/intel_sst_stream_encoded.c   | 1275 ++++++++++++++++++++
 drivers/staging/intel_sst/intelmid.c               | 1233 +++++++++++++++++++
 drivers/staging/intel_sst/intelmid.h               |  186 +++
 drivers/staging/intel_sst/intelmid_ctrl.c          |  629 ++++++++++
 drivers/staging/intel_sst/intelmid_msic_control.c  |  410 ++++++
 drivers/staging/intel_sst/intelmid_pvt.c           |  174 +++
 drivers/staging/intel_sst/intelmid_snd_control.h   |  114 ++
 drivers/staging/intel_sst/intelmid_v0_control.c    |  771 ++++++++++++
 drivers/staging/intel_sst/intelmid_v1_control.c    | 1072 +++++++++++++++++
 drivers/staging/intel_sst/intelmid_v2_control.c    | 1001 ++++++++++++++++
 drivers/staging/intel_sst/jack.h                   |   10 
 25 files changed, 12733 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/intel_sst/TODO
 create mode 100644 drivers/staging/intel_sst/intel_sst.c
 create mode 100644 drivers/staging/intel_sst/intel_sst.h
 create mode 100644 drivers/staging/intel_sst/intel_sst_app_interface.c
 create mode 100644 drivers/staging/intel_sst/intel_sst_common.h
 create mode 100644 drivers/staging/intel_sst/intel_sst_drv_interface.c
 create mode 100644 drivers/staging/intel_sst/intel_sst_dsp.c
 create mode 100644 drivers/staging/intel_sst/intel_sst_fw_ipc.h
 create mode 100644 drivers/staging/intel_sst/intel_sst_ioctl.h
 create mode 100644 drivers/staging/intel_sst/intel_sst_ipc.c
 create mode 100644 drivers/staging/intel_sst/intel_sst_pvt.c
 create mode 100644 drivers/staging/intel_sst/intel_sst_stream.c
 create mode 100644 drivers/staging/intel_sst/intel_sst_stream_encoded.c
 create mode 100644 drivers/staging/intel_sst/intelmid.c
 create mode 100644 drivers/staging/intel_sst/intelmid.h
 create mode 100644 drivers/staging/intel_sst/intelmid_ctrl.c
 create mode 100644 drivers/staging/intel_sst/intelmid_msic_control.c
 create mode 100644 drivers/staging/intel_sst/intelmid_pvt.c
 create mode 100644 drivers/staging/intel_sst/intelmid_snd_control.h
 create mode 100644 drivers/staging/intel_sst/intelmid_v0_control.c
 create mode 100644 drivers/staging/intel_sst/intelmid_v1_control.c
 create mode 100644 drivers/staging/intel_sst/intelmid_v2_control.c
 create mode 100644 drivers/staging/intel_sst/jack.h


diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index e00ef92..bb069cf 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -165,5 +165,7 @@ source "drivers/staging/bcm/Kconfig"
 
 source "drivers/staging/ft1000/Kconfig"
 
+source "drivers/staging/intel_sst/Kconfig"
+
 endif # !STAGING_EXCLUDE_BUILD
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 35eacc9..9457e07 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -63,3 +63,4 @@ obj-$(CONFIG_ATH6K_LEGACY)	+= ath6kl/
 obj-$(CONFIG_USB_ENESTORAGE)	+= keucr/
 obj-$(CONFIG_BCM_WIMAX)	+= bcm/
 obj-$(CONFIG_FT1000)		+= ft1000/
+obj-$(CONFIG_SND_INTEL_SST)		+= intel_sst/
diff --git a/drivers/staging/intel_sst/TODO b/drivers/staging/intel_sst/TODO
new file mode 100644
index 0000000..58d6d2d
--- /dev/null
+++ b/drivers/staging/intel_sst/TODO
@@ -0,0 +1,12 @@
+TODO
+----
+
+Get the memrar driver cleaned up and upstream (dependancy blocking SST)
+Get the jack header entries accepted
+Review the printks and kill off any left over ST_ERR: messages
+Review the misc device ioctls for 32/64bit safety and sanity
+Review the misc device ioctls for size safety depending on config and decide
+	if space/unused areas should be left
+
+Anything the sound folks turn up on full review
+
diff --git a/drivers/staging/intel_sst/intel_sst.c b/drivers/staging/intel_sst/intel_sst.c
new file mode 100644
index 0000000..24d3928
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst.c
@@ -0,0 +1,512 @@
+/*
+ *  intel_sst.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10	Intel Corp
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	 and middleware.
+ *
+ *  This file contains all init functions
+ */
+
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/firmware.h>
+#include <linux/miscdevice.h>
+#include <asm/mrst.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_AUTHOR("Dharageswari R <dharageswari.r@intel.com>");
+MODULE_AUTHOR("KP Jeeja <jeeja.kp@intel.com>");
+MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(SST_DRIVER_VERSION);
+
+struct intel_sst_drv *sst_drv_ctx;
+static struct mutex drv_ctx_lock;
+struct class *sst_class;
+
+/* fops Routines */
+static const struct file_operations intel_sst_fops = {
+	.owner = THIS_MODULE,
+	.open = intel_sst_open,
+	.release = intel_sst_release,
+	.read = intel_sst_read,
+	.write = intel_sst_write,
+	.unlocked_ioctl = intel_sst_ioctl,
+	.mmap = intel_sst_mmap,
+	.aio_read = intel_sst_aio_read,
+	.aio_write = intel_sst_aio_write,
+};
+static const struct file_operations intel_sst_fops_cntrl = {
+	.owner = THIS_MODULE,
+	.open = intel_sst_open_cntrl,
+	.release = intel_sst_release_cntrl,
+	.unlocked_ioctl = intel_sst_ioctl,
+};
+
+static struct miscdevice lpe_dev = {
+	.minor = MISC_DYNAMIC_MINOR,/* dynamic allocation */
+	.name = "intel_sst",/* /dev/intel_sst */
+	.fops = &intel_sst_fops
+};
+
+
+static struct miscdevice lpe_ctrl = {
+	.minor = MISC_DYNAMIC_MINOR,/* dynamic allocation */
+	.name = "intel_sst_ctrl",/* /dev/intel_sst_ctrl */
+	.fops = &intel_sst_fops_cntrl
+};
+
+/**
+* intel_sst_interrupt - Interrupt service routine for SST
+*
+* @irq:	irq number of interrupt
+* @context: pointer to device structre
+*
+* This function is called by OS when SST device raises
+* an interrupt. This will be result of write in IPC register
+* Source can be busy or done interrupt
+*/
+static irqreturn_t intel_sst_interrupt(int irq, void *context)
+{
+	union interrupt_reg isr;
+	union ipc_header header;
+	union interrupt_reg imr;
+	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
+	unsigned int size = 0, str_id;
+	struct stream_info *stream ;
+
+	/* Interrupt arrived, check src */
+	isr.full = sst_shim_read(drv->shim, SST_ISRX);
+
+	if (isr.part.busy_interrupt) {
+		header.full = sst_shim_read(drv->shim, SST_IPCD);
+		if (header.part.msg_id == IPC_SST_PERIOD_ELAPSED) {
+			sst_clear_interrupt();
+			str_id = header.part.str_id;
+			stream = &sst_drv_ctx->streams[str_id];
+			if (stream->period_elapsed)
+				stream->period_elapsed(stream->pcm_substream);
+			return IRQ_HANDLED;
+		}
+		if (header.part.large)
+			size = header.part.data;
+		if (header.part.msg_id & REPLY_MSG) {
+			sst_drv_ctx->ipc_process_msg.header = header;
+			memcpy_fromio(sst_drv_ctx->ipc_process_msg.mailbox,
+				drv->mailbox + SST_MAILBOX_RCV, size);
+			queue_work(sst_drv_ctx->process_msg_wq,
+					&sst_drv_ctx->ipc_process_msg.wq);
+		} else {
+			sst_drv_ctx->ipc_process_reply.header = header;
+			memcpy_fromio(sst_drv_ctx->ipc_process_reply.mailbox,
+				drv->mailbox + SST_MAILBOX_RCV, size);
+			queue_work(sst_drv_ctx->process_reply_wq,
+					&sst_drv_ctx->ipc_process_reply.wq);
+		}
+		/* mask busy inetrrupt */
+		imr.full = sst_shim_read(drv->shim, SST_IMRX);
+		imr.part.busy_interrupt = 1;
+		sst_shim_write(sst_drv_ctx->shim, SST_IMRX, imr.full);
+		return IRQ_HANDLED;
+	} else if (isr.part.done_interrupt) {
+		/* Clear done bit */
+		header.full = sst_shim_read(drv->shim, SST_IPCX);
+		header.part.done = 0;
+		sst_shim_write(sst_drv_ctx->shim, SST_IPCX, header.full);
+		/* write 1 to clear status register */;
+		isr.part.done_interrupt = 1;
+		/* dummy register for shim workaround */
+		sst_shim_write(sst_drv_ctx->shim, SST_ISRX, isr.full);
+		queue_work(sst_drv_ctx->post_msg_wq,
+			&sst_drv_ctx->ipc_post_msg.wq);
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+
+}
+
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
+static int __devinit intel_sst_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
+{
+	int i, ret = 0;
+
+	pr_debug("sst: Probe for DID %x\n", pci->device);
+	mutex_lock(&drv_ctx_lock);
+	if (sst_drv_ctx) {
+		pr_err("sst: Only one sst handle is supported\n");
+		mutex_unlock(&drv_ctx_lock);
+		return -EBUSY;
+	}
+
+	sst_drv_ctx = kzalloc(sizeof(*sst_drv_ctx), GFP_KERNEL);
+	if (!sst_drv_ctx) {
+		pr_err("sst: intel_sst malloc fail\n");
+		mutex_unlock(&drv_ctx_lock);
+		return -ENOMEM;
+	}
+	mutex_unlock(&drv_ctx_lock);
+
+	sst_drv_ctx->pci_id = pci->device;
+
+	mutex_init(&sst_drv_ctx->stream_lock);
+	mutex_init(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->pmic_state = SND_MAD_UN_INIT;
+
+	sst_drv_ctx->stream_cnt = 0;
+	sst_drv_ctx->encoded_cnt = 0;
+	sst_drv_ctx->am_cnt = 0;
+	sst_drv_ctx->pb_streams = 0;
+	sst_drv_ctx->cp_streams = 0;
+	sst_drv_ctx->unique_id = 0;
+	sst_drv_ctx->pmic_port_instance = SST_DEFAULT_PMIC_PORT;
+
+	INIT_LIST_HEAD(&sst_drv_ctx->ipc_dispatch_list);
+	INIT_WORK(&sst_drv_ctx->ipc_post_msg.wq, sst_post_message);
+	INIT_WORK(&sst_drv_ctx->ipc_process_msg.wq, sst_process_message);
+	INIT_WORK(&sst_drv_ctx->ipc_process_reply.wq, sst_process_reply);
+	INIT_WORK(&sst_drv_ctx->mad_ops.wq, sst_process_mad_ops);
+	init_waitqueue_head(&sst_drv_ctx->wait_queue);
+
+	sst_drv_ctx->mad_wq = create_workqueue("sst_mad_wq");
+	if (!sst_drv_ctx->mad_wq)
+		goto do_free_drv_ctx;
+	sst_drv_ctx->post_msg_wq = create_workqueue("sst_post_msg_wq");
+	if (!sst_drv_ctx->post_msg_wq)
+		goto free_mad_wq;
+	sst_drv_ctx->process_msg_wq = create_workqueue("sst_process_msg_wqq");
+	if (!sst_drv_ctx->process_msg_wq)
+		goto free_post_msg_wq;
+	sst_drv_ctx->process_reply_wq = create_workqueue("sst_proces_reply_wq");
+	if (!sst_drv_ctx->process_reply_wq)
+		goto free_process_msg_wq;
+
+	for (i = 0; i < MAX_ACTIVE_STREAM; i++) {
+		sst_drv_ctx->alloc_block[i].sst_id = BLOCK_UNINIT;
+		sst_drv_ctx->alloc_block[i].ops_block.condition = false;
+	}
+	spin_lock_init(&sst_drv_ctx->list_spin_lock);
+
+	sst_drv_ctx->max_streams = pci_id->driver_data;
+	pr_debug("sst: Got drv data max stream %d\n",
+				sst_drv_ctx->max_streams);
+	for (i = 1; i <= sst_drv_ctx->max_streams; i++) {
+		struct stream_info *stream = &sst_drv_ctx->streams[i];
+		INIT_LIST_HEAD(&stream->bufs);
+		mutex_init(&stream->lock);
+		spin_lock_init(&stream->pcm_lock);
+	}
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID) {
+		sst_drv_ctx->mmap_mem = NULL;
+		sst_drv_ctx->mmap_len = SST_MMAP_PAGES * PAGE_SIZE;
+		while (sst_drv_ctx->mmap_len > 0) {
+			sst_drv_ctx->mmap_mem =
+				kzalloc(sst_drv_ctx->mmap_len, GFP_KERNEL);
+			if (sst_drv_ctx->mmap_mem) {
+				pr_debug("sst: Got memory %p size 0x%x\n",
+					sst_drv_ctx->mmap_mem,
+					sst_drv_ctx->mmap_len);
+				break;
+			}
+			if (sst_drv_ctx->mmap_len < (SST_MMAP_STEP*PAGE_SIZE)) {
+				pr_err("sst: mem alloc fail...abort!!\n");
+				ret = -ENOMEM;
+				goto free_process_reply_wq;
+			}
+			sst_drv_ctx->mmap_len -= (SST_MMAP_STEP * PAGE_SIZE);
+			pr_debug("sst:mem alloc failed...trying %d\n",
+						sst_drv_ctx->mmap_len);
+		}
+	}
+
+	/* Init the device */
+	ret = pci_enable_device(pci);
+	if (ret) {
+		pr_err("sst: device cant be enabled\n");
+		goto do_free_mem;
+	}
+	sst_drv_ctx->pci = pci_dev_get(pci);
+	ret = pci_request_regions(pci, SST_DRV_NAME);
+	if (ret)
+		goto do_disable_device;
+	/* map registers */
+	/* SST Shim */
+	sst_drv_ctx->shim_phy_add = pci_resource_start(pci, 1);
+	sst_drv_ctx->shim = pci_ioremap_bar(pci, 1);
+	if (!sst_drv_ctx->shim)
+		goto do_release_regions;
+	pr_debug("sst: SST Shim Ptr %p\n", sst_drv_ctx->shim);
+
+	/* Shared SRAM */
+	sst_drv_ctx->mailbox = pci_ioremap_bar(pci, 2);
+	if (!sst_drv_ctx->mailbox)
+		goto do_unmap_shim;
+	pr_debug("sst: SRAM Ptr %p\n", sst_drv_ctx->mailbox);
+
+	/* IRAM */
+	sst_drv_ctx->iram = pci_ioremap_bar(pci, 3);
+	if (!sst_drv_ctx->iram)
+		goto do_unmap_sram;
+	pr_debug("sst:IRAM Ptr %p\n", sst_drv_ctx->iram);
+
+	/* DRAM */
+	sst_drv_ctx->dram = pci_ioremap_bar(pci, 4);
+	if (!sst_drv_ctx->dram)
+		goto do_unmap_iram;
+	pr_debug("sst: DRAM Ptr %p\n", sst_drv_ctx->dram);
+
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_UN_INIT;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	/* Register the ISR */
+	ret = request_irq(pci->irq, intel_sst_interrupt,
+		IRQF_SHARED, SST_DRV_NAME, sst_drv_ctx);
+	if (ret)
+		goto do_unmap_dram;
+	pr_debug("sst: Registered IRQ 0x%x\n", pci->irq);
+
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID) {
+		ret = misc_register(&lpe_dev);
+		if (ret) {
+			pr_err("sst: couldn't register LPE device\n");
+			goto do_free_irq;
+		}
+
+		/*Register LPE Control as misc driver*/
+		ret = misc_register(&lpe_ctrl);
+		if (ret) {
+			pr_err("sst: couldn't register misc driver\n");
+			goto do_free_irq;
+		}
+	}
+	sst_drv_ctx->lpe_stalled = 0;
+	pr_debug("sst: ...successfully done!!!\n");
+	return ret;
+
+do_free_irq:
+	free_irq(pci->irq, sst_drv_ctx);
+do_unmap_dram:
+	iounmap(sst_drv_ctx->dram);
+do_unmap_iram:
+	iounmap(sst_drv_ctx->iram);
+do_unmap_sram:
+	iounmap(sst_drv_ctx->mailbox);
+do_unmap_shim:
+	iounmap(sst_drv_ctx->shim);
+do_release_regions:
+	pci_release_regions(pci);
+do_disable_device:
+	pci_disable_device(pci);
+do_free_mem:
+	kfree(sst_drv_ctx->mmap_mem);
+free_process_reply_wq:
+	destroy_workqueue(sst_drv_ctx->process_reply_wq);
+free_process_msg_wq:
+	destroy_workqueue(sst_drv_ctx->process_msg_wq);
+free_post_msg_wq:
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+free_mad_wq:
+	destroy_workqueue(sst_drv_ctx->mad_wq);
+do_free_drv_ctx:
+	kfree(sst_drv_ctx);
+	pr_err("sst: Probe failed with 0x%x\n", ret);
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
+static void __devexit intel_sst_remove(struct pci_dev *pci)
+{
+	pci_dev_put(sst_drv_ctx->pci);
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_UN_INIT;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID) {
+		misc_deregister(&lpe_dev);
+		misc_deregister(&lpe_ctrl);
+	}
+	free_irq(pci->irq, sst_drv_ctx);
+	iounmap(sst_drv_ctx->dram);
+	iounmap(sst_drv_ctx->iram);
+	iounmap(sst_drv_ctx->mailbox);
+	iounmap(sst_drv_ctx->shim);
+	sst_drv_ctx->pmic_state = SND_MAD_UN_INIT;
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+		kfree(sst_drv_ctx->mmap_mem);
+	flush_scheduled_work();
+	destroy_workqueue(sst_drv_ctx->process_reply_wq);
+	destroy_workqueue(sst_drv_ctx->process_msg_wq);
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+	destroy_workqueue(sst_drv_ctx->mad_wq);
+	kfree(sst_drv_ctx);
+	pci_release_region(pci, 1);
+	pci_release_region(pci, 2);
+	pci_release_region(pci, 3);
+	pci_release_region(pci, 4);
+	pci_release_region(pci, 5);
+	pci_set_drvdata(pci, NULL);
+}
+
+/* Power Management */
+/*
+* intel_sst_suspend - PCI suspend function
+*
+* @pci: PCI device structure
+* @state: PM message
+*
+* This function is called by OS when a power event occurs
+*/
+int intel_sst_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	union config_status_reg csr;
+
+	pr_debug("sst: intel_sst_suspend called\n");
+
+	if (sst_drv_ctx->pb_streams != 0 || sst_drv_ctx->cp_streams != 0)
+		return -EPERM;
+	/*Assert RESET on LPE Processor*/
+	csr.full = sst_shim_read(sst_drv_ctx->shim, SST_CSR);
+	csr.full = csr.full | 0x2;
+	/* Move the SST state to Suspended */
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_SUSPENDED;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	pci_set_drvdata(pci, sst_drv_ctx);
+	pci_save_state(pci);
+	pci_disable_device(pci);
+	pci_set_power_state(pci, PCI_D3hot);
+	return 0;
+}
+
+/**
+* intel_sst_resume - PCI resume function
+*
+* @pci:	PCI device structure
+*
+* This function is called by OS when a power event occurs
+*/
+int intel_sst_resume(struct pci_dev *pci)
+{
+	int ret = 0;
+
+	pr_debug("sst: intel_sst_resume called\n");
+	if (sst_drv_ctx->sst_state != SST_SUSPENDED) {
+		pr_err("sst: SST is not in suspended state\n");
+		return -EPERM;
+	}
+	sst_drv_ctx = pci_get_drvdata(pci);
+	pci_set_power_state(pci, PCI_D0);
+	pci_restore_state(pci);
+	ret = pci_enable_device(pci);
+	if (ret)
+		pr_err("sst: device cant be enabled\n");
+
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_UN_INIT;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	return 0;
+}
+
+/* PCI Routines */
+static struct pci_device_id intel_sst_ids[] = {
+	{ PCI_VDEVICE(INTEL, SST_MRST_PCI_ID), 3},
+	{ PCI_VDEVICE(INTEL, SST_MFLD_PCI_ID), 6},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, intel_sst_ids);
+
+static struct pci_driver driver = {
+	.name = SST_DRV_NAME,
+	.id_table = intel_sst_ids,
+	.probe = intel_sst_probe,
+	.remove = __devexit_p(intel_sst_remove),
+#ifdef CONFIG_PM
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
+* Init all data strutures
+*/
+static int __init intel_sst_init(void)
+{
+	/* Init all variables, data structure etc....*/
+	int ret = 0;
+	pr_debug("sst: INFO: ******** SST DRIVER loading.. Ver: %s\n",
+				       SST_DRIVER_VERSION);
+
+	mutex_init(&drv_ctx_lock);
+	/* Register with PCI */
+	ret = pci_register_driver(&driver);
+	if (ret)
+		pr_err("sst: PCI register failed\n");
+	return ret;
+}
+
+/**
+* intel_sst_exit - Module exit function
+*
+* Unregisters with PCI
+* Unregisters with /dev
+* Frees all data strutures
+*/
+static void __exit intel_sst_exit(void)
+{
+	pci_unregister_driver(&driver);
+
+	pr_debug("sst: driver unloaded\n");
+	return;
+}
+
+module_init(intel_sst_init);
+module_exit(intel_sst_exit);
diff --git a/drivers/staging/intel_sst/intel_sst.h b/drivers/staging/intel_sst/intel_sst.h
new file mode 100644
index 0000000..1f19f0d
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst.h
@@ -0,0 +1,131 @@
+#ifndef __INTEL_SST_H__
+#define __INTEL_SST_H__
+/*
+ *  intel_sst.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *  This file is shared between the SST and MAD drivers
+ */
+
+#define SST_CARD_NAMES "intel_mid_card"
+
+/* control list Pmic & Lpe */
+/* Input controls */
+enum port_status {
+	ACTIVATE = 1,
+	DEACTIVATE,
+};
+
+/* Card states */
+enum sst_card_states {
+	SND_CARD_UN_INIT = 0,
+	SND_CARD_INIT_DONE,
+};
+
+enum sst_controls {
+	SST_SND_ALLOC =			0x1000,
+	SST_SND_PAUSE =			0x1001,
+	SST_SND_RESUME =		0x1002,
+	SST_SND_DROP =			0x1003,
+	SST_SND_FREE =			0x1004,
+	SST_SND_BUFFER_POINTER =	0x1005,
+	SST_SND_STREAM_INIT =		0x1006,
+	SST_SND_START	 =		0x1007,
+	SST_SND_STREAM_PROCESS =	0x1008,
+	SST_MAX_CONTROLS =		0x1008,
+	SST_CONTROL_BASE =		0x1000,
+	SST_ENABLE_RX_TIME_SLOT =	0x1009,
+};
+
+enum SND_CARDS {
+	SND_FS = 0,
+	SND_MX,
+	SND_NC,
+	SND_MSIC
+};
+
+struct pcm_stream_info {
+	int str_id;
+	void *mad_substream;
+	void (*period_elapsed) (void *mad_substream);
+	unsigned long long buffer_ptr;
+	int sfreq;
+};
+
+struct snd_pmic_ops {
+	int card_status;
+	int master_mute;
+	int num_channel;
+	int input_dev_id;
+	int mute_status;
+	int pb_on;
+	int cap_on;
+	int output_dev_id;
+	int (*set_input_dev) (u8 value);
+	int (*set_output_dev) (u8 value);
+
+	int (*set_mute) (int dev_id, u8 value);
+	int (*get_mute) (int dev_id, u8 *value);
+
+	int (*set_vol) (int dev_id, int value);
+	int (*get_vol) (int dev_id, int *value);
+
+	int (*init_card) (void);
+	int (*set_pcm_audio_params)
+		(int sfreq, int word_size , int num_channel);
+	int (*set_pcm_voice_params) (void);
+	int (*set_voice_port) (int status);
+	int (*set_audio_port) (int status);
+
+	int (*power_up_pmic_pb) (unsigned int port);
+	int (*power_up_pmic_cp) (unsigned int port);
+	int (*power_down_pmic_pb) (void);
+	int (*power_down_pmic_cp) (void);
+	int (*power_down_pmic) (void);
+};
+
+struct intel_sst_card_ops {
+	char *module_name;
+	unsigned int  vendor_id;
+	int (*control_set) (int control_element, void *value);
+	struct snd_pmic_ops *scard_ops;
+};
+
+/* modified for generic access */
+struct sc_reg_access {
+	u16 reg_addr;
+	u8 value;
+	u8 mask;
+};
+enum sc_reg_access_type {
+	PMIC_READ = 0,
+	PMIC_WRITE,
+	PMIC_READ_MODIFY,
+};
+
+int register_sst_card(struct intel_sst_card_ops *card);
+void unregister_sst_card(struct intel_sst_card_ops *card);
+#endif /* __INTEL_SST_H__ */
diff --git a/drivers/staging/intel_sst/intel_sst_app_interface.c b/drivers/staging/intel_sst/intel_sst_app_interface.c
new file mode 100644
index 0000000..9f31dc5
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_app_interface.c
@@ -0,0 +1,1234 @@
+/*
+ *  intel_sst_interface.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  Harsha Priya <priya.harsha@intel.com>
+ *  Dharageswari R <dharageswari.r@intel.com>
+ *  Jeeja KP <jeeja.kp@intel.com>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *  Upper layer interfaces (MAD driver, MMF) to SST driver
+ */
+
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/uio.h>
+#include <linux/aio.h>
+#include <linux/uaccess.h>
+#include <linux/firmware.h>
+#include <linux/ioctl.h>
+#include <linux/smp_lock.h>
+#ifdef CONFIG_MRST_RAR_HANDLER
+#include <linux/rar_register.h>
+#include "../../../drivers/staging/memrar/memrar.h"
+#endif
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+#define AM_MODULE 1
+#define STREAM_MODULE 0
+
+
+/**
+* intel_sst_check_device - checks SST device
+*
+* This utility function checks the state of SST device and downlaods FW if
+* not done, or resumes the device if suspended
+*/
+
+static int intel_sst_check_device(void)
+{
+	int retval = 0;
+	if (sst_drv_ctx->pmic_state != SND_MAD_INIT_DONE) {
+		pr_warn("sst: Sound card not availble\n ");
+		return -EIO;
+	}
+	if (sst_drv_ctx->sst_state == SST_SUSPENDED) {
+		pr_debug("sst: Resuming from Suspended state\n");
+		retval = intel_sst_resume(sst_drv_ctx->pci);
+		if (retval) {
+			pr_debug("sst: Resume Failed= %#x,abort\n", retval);
+			return retval;
+		}
+	}
+
+	if (sst_drv_ctx->sst_state == SST_UN_INIT) {
+		/* FW is not downloaded */
+		retval = sst_download_fw();
+		if (retval)
+			return -ENODEV;
+		if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID) {
+			retval = sst_drv_ctx->rx_time_slot_status;
+			if (retval != RX_TIMESLOT_UNINIT
+					&& sst_drv_ctx->pmic_vendor != SND_NC)
+				sst_enable_rx_timeslot(retval);
+		}
+	}
+	return 0;
+}
+
+/**
+ * intel_sst_open - opens a handle to driver
+ *
+ * @i_node:	inode structure
+ * @file_ptr:pointer to file
+ *
+ * This function is called by OS when a user space component
+ * tries to get a driver handle. Only one handle at a time
+ * will be allowed
+ */
+int intel_sst_open(struct inode *i_node, struct file *file_ptr)
+{
+	unsigned int retval = intel_sst_check_device();
+	if (retval)
+		return retval;
+
+	mutex_lock(&sst_drv_ctx->stream_lock);
+	if (sst_drv_ctx->encoded_cnt < MAX_ENC_STREAM) {
+		struct ioctl_pvt_data *data =
+			kzalloc(sizeof(struct ioctl_pvt_data), GFP_KERNEL);
+		if (!data) {
+			mutex_unlock(&sst_drv_ctx->stream_lock);
+			return -ENOMEM;
+		}
+
+		sst_drv_ctx->encoded_cnt++;
+		mutex_unlock(&sst_drv_ctx->stream_lock);
+		data->pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+		data->str_id = 0;
+		file_ptr->private_data = (void *)data;
+		pr_debug("sst: pvt_id handle = %d!\n", data->pvt_id);
+	} else {
+		retval = -EUSERS;
+		mutex_unlock(&sst_drv_ctx->stream_lock);
+	}
+	return retval;
+}
+
+/**
+ * intel_sst_open_cntrl - opens a handle to driver
+ *
+ * @i_node:	inode structure
+ * @file_ptr:pointer to file
+ *
+ * This function is called by OS when a user space component
+ * tries to get a driver handle to /dev/intel_sst_control.
+ * Only one handle at a time will be allowed
+ * This is for control operations only
+ */
+int intel_sst_open_cntrl(struct inode *i_node, struct file *file_ptr)
+{
+	unsigned int retval = intel_sst_check_device();
+	if (retval)
+		return retval;
+
+	/* audio manager open */
+	mutex_lock(&sst_drv_ctx->stream_lock);
+	if (sst_drv_ctx->am_cnt < MAX_AM_HANDLES) {
+		sst_drv_ctx->am_cnt++;
+		pr_debug("sst: AM handle opened...\n");
+		file_ptr->private_data = NULL;
+	} else
+		retval = -EACCES;
+
+	mutex_unlock(&sst_drv_ctx->stream_lock);
+	return retval;
+}
+
+/**
+ * intel_sst_release - releases a handle to driver
+ *
+ * @i_node:	inode structure
+ * @file_ptr:	pointer to file
+ *
+ * This function is called by OS when a user space component
+ * tries to release a driver handle.
+ */
+int intel_sst_release(struct inode *i_node, struct file *file_ptr)
+{
+	struct ioctl_pvt_data *data = file_ptr->private_data;
+
+	pr_debug("sst: Release called, closing app handle\n");
+	mutex_lock(&sst_drv_ctx->stream_lock);
+	sst_drv_ctx->encoded_cnt--;
+	sst_drv_ctx->stream_cnt--;
+	mutex_unlock(&sst_drv_ctx->stream_lock);
+	free_stream_context(data->str_id);
+	kfree(data);
+	return 0;
+}
+
+int intel_sst_release_cntrl(struct inode *i_node, struct file *file_ptr)
+{
+	/* audio manager close */
+	mutex_lock(&sst_drv_ctx->stream_lock);
+	sst_drv_ctx->am_cnt--;
+	mutex_unlock(&sst_drv_ctx->stream_lock);
+	pr_debug("sst: AM handle closed\n");
+	return 0;
+}
+
+/**
+* intel_sst_mmap - mmaps a kernel buffer to user space for copying data
+*
+* @vma:		vm area structure instance
+* @file_ptr:	pointer to file
+*
+* This function is called by OS when a user space component
+* tries to get mmap memory from driver
+*/
+int intel_sst_mmap(struct file *file_ptr, struct vm_area_struct *vma)
+{
+	int retval, length;
+	struct ioctl_pvt_data *data =
+		(struct ioctl_pvt_data *)file_ptr->private_data;
+	int str_id = data->str_id;
+	void *mem_area;
+
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return -EINVAL;
+
+	length = vma->vm_end - vma->vm_start;
+	pr_debug("sst: called for stream %d length 0x%x\n", str_id, length);
+
+	if (length > sst_drv_ctx->mmap_len)
+		return -ENOMEM;
+	if (!sst_drv_ctx->mmap_mem)
+		return -EIO;
+
+	/* round it up to the page bondary  */
+	/*mem_area = (void *)((((unsigned long)sst_drv_ctx->mmap_mem)
+				+ PAGE_SIZE - 1) & PAGE_MASK);*/
+	mem_area = (void *) PAGE_ALIGN((unsigned int) sst_drv_ctx->mmap_mem);
+
+	/* map the whole physically contiguous area in one piece  */
+	retval = remap_pfn_range(vma,
+			vma->vm_start,
+			virt_to_phys((void *)mem_area) >> PAGE_SHIFT,
+			length,
+			vma->vm_page_prot);
+	if (retval)
+		sst_drv_ctx->streams[str_id].mmapped = false;
+	else
+		sst_drv_ctx->streams[str_id].mmapped = true;
+
+	pr_debug("sst: mmap ret 0x%x\n", retval);
+	return retval;
+}
+
+/* sets mmap data buffers to play/capture*/
+static int intel_sst_mmap_play_capture(u32 str_id,
+		struct snd_sst_mmap_buffs *mmap_buf)
+{
+	struct sst_stream_bufs *bufs;
+	int retval, i;
+	struct stream_info *stream;
+	struct snd_sst_mmap_buff_entry *buf_entry;
+
+	pr_debug("sst:called for str_id %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return -EINVAL;
+	BUG_ON(!mmap_buf);
+
+	stream = &sst_drv_ctx->streams[str_id];
+	if (stream->mmapped != true)
+		return -EIO;
+
+	if (stream->status == STREAM_UN_INIT ||
+		stream->status == STREAM_DECODE) {
+		return -EBADRQC;
+	}
+	stream->curr_bytes = 0;
+	stream->cumm_bytes = 0;
+
+	pr_debug("sst:new buffers count %d status %d\n",
+			mmap_buf->entries, stream->status);
+	buf_entry = mmap_buf->buff;
+	for (i = 0; i < mmap_buf->entries; i++) {
+		BUG_ON(!buf_entry);
+		bufs = kzalloc(sizeof(*bufs), GFP_KERNEL);
+		if (!bufs)
+			return -ENOMEM;
+		bufs->size = buf_entry->size;
+		bufs->offset = buf_entry->offset;
+		bufs->addr = sst_drv_ctx->mmap_mem;
+		bufs->in_use = false;
+		buf_entry++;
+		/* locking here */
+		mutex_lock(&stream->lock);
+		list_add_tail(&bufs->node, &stream->bufs);
+		mutex_unlock(&stream->lock);
+	}
+
+	mutex_lock(&stream->lock);
+	stream->data_blk.condition = false;
+	stream->data_blk.ret_code = 0;
+	if (stream->status == STREAM_INIT &&
+			stream->prev != STREAM_UN_INIT &&
+			stream->need_draining != true) {
+		stream->prev = stream->status;
+		stream->status = STREAM_RUNNING;
+		if (stream->ops == STREAM_OPS_PLAYBACK) {
+			if (sst_play_frame(str_id) < 0) {
+				pr_warn("sst: play frames fail\n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		} else if (stream->ops == STREAM_OPS_CAPTURE) {
+			if (sst_capture_frame(str_id) < 0) {
+				pr_warn("sst: capture frame fail\n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		}
+	}
+	mutex_unlock(&stream->lock);
+	/* Block the call for reply */
+	if (!list_empty(&stream->bufs)) {
+		stream->data_blk.on = true;
+		retval = sst_wait_interruptible(sst_drv_ctx,
+					&stream->data_blk);
+	}
+
+	if (retval >= 0)
+		retval = stream->cumm_bytes;
+	pr_debug("sst:end of play/rec ioctl bytes = %d!!\n", retval);
+	return retval;
+}
+
+/*sets user data buffers to play/capture*/
+static int intel_sst_play_capture(struct stream_info *stream, int str_id)
+{
+	int retval;
+
+	stream->data_blk.ret_code = 0;
+	stream->data_blk.on = true;
+	stream->data_blk.condition = false;
+
+	mutex_lock(&stream->lock);
+	if (stream->status == STREAM_INIT && stream->prev != STREAM_UN_INIT) {
+		/* stream is started */
+		stream->prev = stream->status;
+		stream->status = STREAM_RUNNING;
+	}
+
+	if (stream->status == STREAM_INIT && stream->prev == STREAM_UN_INIT) {
+		/* stream is not started yet */
+		pr_debug("sst: Stream isn't in started state %d, prev %d\n",
+			stream->status, stream->prev);
+	} else if ((stream->status == STREAM_RUNNING ||
+			stream->status == STREAM_PAUSED) &&
+			stream->need_draining != true) {
+		/* stream is started */
+		if (stream->ops == STREAM_OPS_PLAYBACK ||
+				stream->ops == STREAM_OPS_PLAYBACK_DRM) {
+			if (sst_play_frame(str_id) < 0) {
+				pr_warn("sst: play frames failed\n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		} else if (stream->ops == STREAM_OPS_CAPTURE) {
+			if (sst_capture_frame(str_id) < 0) {
+				pr_warn("sst: capture frames failed\n ");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		}
+	} else {
+		mutex_unlock(&stream->lock);
+		return -EIO;
+	}
+	mutex_unlock(&stream->lock);
+	/* Block the call for reply */
+
+	retval = sst_wait_interruptible(sst_drv_ctx, &stream->data_blk);
+	if (retval) {
+		stream->status = STREAM_INIT;
+		pr_debug("sst: wait returned error...\n");
+	}
+	return retval;
+}
+
+/* fills kernel list with buffer addresses for SST DSP driver to process*/
+static int snd_sst_fill_kernel_list(struct stream_info *stream,
+			const struct iovec *iovec, unsigned long nr_segs,
+			struct list_head *copy_to_list)
+{
+	struct sst_stream_bufs *stream_bufs;
+	unsigned long index, data_not_copied, mmap_len;
+	unsigned char *bufp;
+	unsigned long size, copied_size;
+	int retval = 0, add_to_list = 0;
+	static int sent_offset;
+	static unsigned long sent_index;
+
+	stream_bufs = kzalloc(sizeof(*stream_bufs), GFP_KERNEL);
+	if (!stream_bufs)
+		return -ENOMEM;
+	stream_bufs->addr = sst_drv_ctx->mmap_mem;
+#ifdef CONFIG_MRST_RAR_HANDLER
+	if (stream->ops == STREAM_OPS_PLAYBACK_DRM) {
+		for (index = stream->sg_index; index < nr_segs; index++) {
+			__u32 rar_handle;
+			struct sst_stream_bufs *stream_bufs =
+				kzalloc(sizeof(*stream_bufs), GFP_KERNEL);
+
+			stream->sg_index = index;
+			if (!stream_bufs)
+				return -ENOMEM;
+			retval = copy_from_user((void *) &rar_handle,
+						iovec[index].iov_base,
+						sizeof(__u32));
+			if (retval != 0)
+				return -EFAULT;
+			stream_bufs->addr = (char *)rar_handle;
+			stream_bufs->in_use = false;
+			stream_bufs->size = iovec[0].iov_len;
+			/* locking here */
+			mutex_lock(&stream->lock);
+			list_add_tail(&stream_bufs->node, &stream->bufs);
+			mutex_unlock(&stream->lock);
+		}
+		stream->sg_index = index;
+		return retval;
+	}
+#endif
+	mmap_len = sst_drv_ctx->mmap_len;
+	stream_bufs->addr = sst_drv_ctx->mmap_mem;
+	bufp = stream->cur_ptr;
+
+	copied_size = 0;
+
+	if (!stream->sg_index)
+		sent_index = sent_offset = 0;
+
+	for (index = stream->sg_index; index < nr_segs; index++) {
+		stream->sg_index = index;
+		if (!stream->cur_ptr)
+			bufp = iovec[index].iov_base;
+
+		size = ((unsigned long)iovec[index].iov_base
+			+ iovec[index].iov_len) - (unsigned long) bufp;
+
+		if ((copied_size + size) > mmap_len)
+			size = mmap_len - copied_size;
+
+
+		if (stream->ops == STREAM_OPS_PLAYBACK) {
+			data_not_copied = copy_from_user(
+				(void *)(stream_bufs->addr + copied_size),
+				bufp, size);
+			if (data_not_copied > 0) {
+				/* Clean up the list and return error code */
+				retval = -EFAULT;
+				break;
+			}
+		} else if (stream->ops == STREAM_OPS_CAPTURE) {
+			struct snd_sst_user_cap_list *entry =
+				kzalloc(sizeof(*entry), GFP_KERNEL);
+
+			if (!entry) {
+				kfree(stream_bufs);
+				return -ENOMEM;
+			}
+			entry->iov_index = index;
+			entry->iov_offset = (unsigned long) bufp -
+					(unsigned long)iovec[index].iov_base;
+			entry->offset = copied_size;
+			entry->size = size;
+			list_add_tail(&entry->node, copy_to_list);
+		}
+
+		stream->cur_ptr = bufp + size;
+
+		if (((unsigned long)iovec[index].iov_base
+				+ iovec[index].iov_len) <
+				((unsigned long)iovec[index].iov_base)) {
+			pr_debug("sst: Buffer overflows");
+			kfree(stream_bufs);
+			return -EINVAL;
+		}
+
+		if (((unsigned long)iovec[index].iov_base
+					+ iovec[index].iov_len) ==
+					(unsigned long)stream->cur_ptr) {
+			stream->cur_ptr = NULL;
+			stream->sg_index++;
+		}
+
+		copied_size += size;
+		pr_debug("sst: copied_size - %lx\n", copied_size);
+		if ((copied_size >= mmap_len) ||
+				(stream->sg_index == nr_segs)) {
+			add_to_list = 1;
+		}
+
+		if (add_to_list) {
+			stream_bufs->in_use = false;
+			stream_bufs->size = copied_size;
+			/* locking here */
+			mutex_lock(&stream->lock);
+			list_add_tail(&stream_bufs->node, &stream->bufs);
+			mutex_unlock(&stream->lock);
+			break;
+		}
+	}
+	return retval;
+}
+
+/* This function copies the captured data returned from SST DSP engine
+ * to the user buffers*/
+static int snd_sst_copy_userbuf_capture(struct stream_info *stream,
+			const struct iovec *iovec,
+			struct list_head *copy_to_list)
+{
+	struct snd_sst_user_cap_list *entry, *_entry;
+	struct sst_stream_bufs *kbufs = NULL, *_kbufs;
+	int retval = 0;
+	unsigned long data_not_copied;
+
+	/* copy sent buffers */
+	pr_debug("sst: capture stream copying to user now...\n");
+	list_for_each_entry_safe(kbufs, _kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == true) {
+			/* copy to user */
+			list_for_each_entry_safe(entry, _entry,
+						copy_to_list, node) {
+				data_not_copied = copy_to_user((void *)
+					iovec[entry->iov_index].iov_base +
+						entry->iov_offset,
+					kbufs->addr + entry->offset,
+					entry->size);
+				if (data_not_copied > 0) {
+					/* Clean up the list and return error */
+					retval = -EFAULT;
+					break;
+				}
+				list_del(&entry->node);
+				kfree(entry);
+			}
+		}
+	}
+	pr_debug("sst: end of cap copy\n");
+	return retval;
+}
+
+/*
+ * snd_sst_userbufs_play_cap - constructs the list from user buffers
+ *
+ * @iovec:pointer to iovec structure
+ * @nr_segs:number entries in the iovec structure
+ * @str_id:stream id
+ * @stream:pointer to stream_info structure
+ *
+ * This function will traverse the user list and copy the data to the kernel
+ * space buffers.
+ */
+static int snd_sst_userbufs_play_cap(const struct iovec *iovec,
+			unsigned long nr_segs, unsigned int str_id,
+			struct stream_info *stream)
+{
+	int retval;
+	LIST_HEAD(copy_to_list);
+
+
+	retval = snd_sst_fill_kernel_list(stream, iovec, nr_segs,
+		       &copy_to_list);
+
+	retval = intel_sst_play_capture(stream, str_id);
+	if (retval < 0)
+		return retval;
+
+	if (stream->ops == STREAM_OPS_CAPTURE) {
+		retval = snd_sst_copy_userbuf_capture(stream, iovec,
+				&copy_to_list);
+	}
+	return retval;
+}
+
+/* This function is common function across read/write
+  for user buffers called from system calls*/
+static int intel_sst_read_write(unsigned int str_id, char __user *buf,
+					size_t count)
+{
+	int retval;
+	struct stream_info *stream;
+	struct iovec iovec;
+	unsigned long nr_segs;
+
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return -EINVAL;
+	stream = &sst_drv_ctx->streams[str_id];
+	if (stream->mmapped == true) {
+		pr_warn("sst: user write and stream is mapped");
+		return -EIO;
+	}
+	if (!count)
+		return -EINVAL;
+	stream->curr_bytes = 0;
+	stream->cumm_bytes = 0;
+	/* copy user buf details */
+	pr_debug("sst: new buffers %p, copy size %d, status %d\n" ,
+			buf, (int) count, (int) stream->status);
+
+	stream->buf_type = SST_BUF_USER_STATIC;
+	iovec.iov_base = (void *)buf;
+	iovec.iov_len  = count;
+	nr_segs = 1;
+
+	do {
+		retval = snd_sst_userbufs_play_cap(
+				&iovec, nr_segs, str_id, stream);
+		if (retval < 0)
+			break;
+
+	} while (stream->sg_index < nr_segs);
+
+	stream->sg_index = 0;
+	stream->cur_ptr = NULL;
+	if (retval >= 0)
+		retval = stream->cumm_bytes;
+	pr_debug("sst: end of play/rec bytes = %d!!\n", retval);
+	return retval;
+}
+
+/***
+ * intel_sst_write - This function is called when user tries to play out data
+ *
+ * @file_ptr:pointer to file
+ * @buf:user buffer to be played out
+ * @count:size of tthe buffer
+ * @offset:offset to start from
+ *
+ * writes the encoded data into DSP
+ */
+int intel_sst_write(struct file *file_ptr, const char __user *buf,
+			size_t count, loff_t *offset)
+{
+	struct ioctl_pvt_data *data = file_ptr->private_data;
+	int str_id = data->str_id;
+	struct stream_info *stream = &sst_drv_ctx->streams[str_id];
+
+	pr_debug("sst: called for %d\n", str_id);
+	if (stream->status == STREAM_UN_INIT ||
+		stream->status == STREAM_DECODE) {
+		return -EBADRQC;
+	}
+	return intel_sst_read_write(str_id, (char __user *)buf, count);
+}
+
+/*
+ * intel_sst_aio_write - write buffers
+ *
+ * @kiocb:pointer to a structure containing file pointer
+ * @iov:list of user buffer to be played out
+ * @nr_segs:number of entries
+ * @offset:offset to start from
+ *
+ * This function is called when user tries to play out multiple data buffers
+ */
+ssize_t intel_sst_aio_write(struct kiocb *kiocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t  offset)
+{
+	int retval;
+	struct ioctl_pvt_data *data = kiocb->ki_filp->private_data;
+	int str_id = data->str_id;
+	struct stream_info *stream;
+
+	pr_debug("sst: entry - %ld\n", nr_segs);
+
+	if (is_sync_kiocb(kiocb) == false)
+		return -EINVAL;
+
+	pr_debug("sst: called for str_id %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return -EINVAL;
+	stream = &sst_drv_ctx->streams[str_id];
+	if (stream->mmapped == true)
+		return -EIO;
+	if (stream->status == STREAM_UN_INIT ||
+		stream->status == STREAM_DECODE) {
+		return -EBADRQC;
+	}
+	stream->curr_bytes = 0;
+	stream->cumm_bytes = 0;
+	pr_debug("sst: new segs %ld, offset %d, status %d\n" ,
+			nr_segs, (int) offset, (int) stream->status);
+	stream->buf_type = SST_BUF_USER_STATIC;
+	do {
+		retval = snd_sst_userbufs_play_cap(iov, nr_segs,
+						str_id, stream);
+		if (retval < 0)
+			break;
+
+	} while (stream->sg_index < nr_segs);
+
+	stream->sg_index = 0;
+	stream->cur_ptr = NULL;
+	if (retval >= 0)
+		retval = stream->cumm_bytes;
+	pr_debug("sst: end of play/rec bytes = %d!!\n", retval);
+	return retval;
+}
+
+/*
+ * intel_sst_read - read the encoded data
+ *
+ * @file_ptr: pointer to file
+ * @buf: user buffer to be filled with captured data
+ * @count: size of tthe buffer
+ * @offset: offset to start from
+ *
+ * This function is called when user tries to capture data
+ */
+int intel_sst_read(struct file *file_ptr, char __user *buf,
+			size_t count, loff_t *offset)
+{
+	struct ioctl_pvt_data *data = file_ptr->private_data;
+	int str_id = data->str_id;
+	struct stream_info *stream = &sst_drv_ctx->streams[str_id];
+
+	pr_debug("sst: called for %d\n", str_id);
+	if (stream->status == STREAM_UN_INIT ||
+			stream->status == STREAM_DECODE)
+		return -EBADRQC;
+	return intel_sst_read_write(str_id, buf, count);
+}
+
+/*
+ * intel_sst_aio_read - aio read
+ *
+ * @kiocb: pointer to a structure containing file pointer
+ * @iov: list of user buffer to be filled with captured
+ * @nr_segs: number of entries
+ * @offset: offset to start from
+ *
+ * This function is called when user tries to capture out multiple data buffers
+ */
+ssize_t intel_sst_aio_read(struct kiocb *kiocb, const struct iovec *iov,
+			 unsigned long nr_segs, loff_t offset)
+{
+	int retval;
+	struct ioctl_pvt_data *data = kiocb->ki_filp->private_data;
+	int str_id = data->str_id;
+	struct stream_info *stream;
+
+	pr_debug("sst: entry - %ld\n", nr_segs);
+
+	if (is_sync_kiocb(kiocb) == false) {
+		pr_debug("sst: aio_read from user space is not allowed\n");
+		return -EINVAL;
+	}
+
+	pr_debug("sst: called for str_id %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return -EINVAL;
+	stream = &sst_drv_ctx->streams[str_id];
+	if (stream->mmapped == true)
+		return -EIO;
+	if (stream->status == STREAM_UN_INIT ||
+			stream->status == STREAM_DECODE)
+		return -EBADRQC;
+	stream->curr_bytes = 0;
+	stream->cumm_bytes = 0;
+
+	pr_debug("sst: new segs %ld, offset %d, status %d\n" ,
+			nr_segs, (int) offset, (int) stream->status);
+	stream->buf_type = SST_BUF_USER_STATIC;
+	do {
+		retval = snd_sst_userbufs_play_cap(iov, nr_segs,
+						str_id, stream);
+		if (retval < 0)
+			break;
+
+	} while (stream->sg_index < nr_segs);
+
+	stream->sg_index = 0;
+	stream->cur_ptr = NULL;
+	if (retval >= 0)
+		retval = stream->cumm_bytes;
+	pr_debug("sst: end of play/rec bytes = %d!!\n", retval);
+	return retval;
+}
+
+/* sst_print_stream_params - prints the stream parameters (debug fn)*/
+static void sst_print_stream_params(struct snd_sst_get_stream_params *get_prm)
+{
+	pr_debug("sst: codec params:result =%d\n",
+				get_prm->codec_params.result);
+	pr_debug("sst: codec params:stream = %d\n",
+				get_prm->codec_params.stream_id);
+	pr_debug("sst: codec params:codec = %d\n",
+				get_prm->codec_params.codec);
+	pr_debug("sst: codec params:ops = %d\n",
+				get_prm->codec_params.ops);
+	pr_debug("sst: codec params:stream_type= %d\n",
+				get_prm->codec_params.stream_type);
+	pr_debug("sst: pcmparams:sfreq= %d\n",
+				get_prm->pcm_params.sfreq);
+	pr_debug("sst: pcmparams:num_chan= %d\n",
+				get_prm->pcm_params.num_chan);
+	pr_debug("sst: pcmparams:pcm_wd_sz= %d\n",
+				get_prm->pcm_params.pcm_wd_sz);
+	return;
+}
+
+/**
+ * intel_sst_ioctl - recieves the device ioctl's
+ * @file_ptr:pointer to file
+ * @cmd:Ioctl cmd
+ * @arg:data
+ *
+ * This function is called by OS when a user space component
+ * sends an Ioctl to SST driver
+ */
+long intel_sst_ioctl(struct file *file_ptr, unsigned int cmd, unsigned long arg)
+{
+	int retval = 0;
+	struct ioctl_pvt_data *data = NULL;
+	int str_id = 0, minor = 0;
+
+	lock_kernel();
+
+	data = file_ptr->private_data;
+	if (data) {
+		minor = 0;
+		str_id = data->str_id;
+	} else
+		minor = 1;
+
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING) {
+		unlock_kernel();
+		return -EBUSY;
+	}
+
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(SNDRV_SST_STREAM_PAUSE):
+		pr_debug("sst: IOCTL_PAUSE recieved for %d!\n", str_id);
+		if (minor != STREAM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+		retval = sst_pause_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_RESUME):
+		pr_debug("sst: SNDRV_SST_IOCTL_RESUME recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+		retval = sst_resume_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_SET_PARAMS): {
+		struct snd_sst_params *str_param = (struct snd_sst_params *)arg;
+
+		pr_debug("sst: IOCTL_SET_PARAMS recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+
+		if (!str_id) {
+
+			retval = sst_get_stream(str_param);
+			if (retval > 0) {
+				struct stream_info *str_info;
+				sst_drv_ctx->stream_cnt++;
+				data->str_id = retval;
+				str_info = &sst_drv_ctx->streams[retval];
+				str_info->src = SST_DRV;
+				retval = copy_to_user(&str_param->stream_id,
+						&retval, sizeof(__u32));
+			} else {
+				if (retval == -SST_ERR_INVALID_PARAMS)
+					retval = -EINVAL;
+			}
+		} else {
+			pr_debug("sst: SET_STREAM_PARAMS recieved!\n");
+			/* allocated set params only */
+			retval = sst_set_stream_param(str_id, str_param);
+			/* Block the call for reply */
+			if (!retval) {
+				int sfreq = 0, word_size = 0, num_channel = 0;
+				sfreq =	str_param->sparams.uc.pcm_params.sfreq;
+				word_size = str_param->sparams.
+						uc.pcm_params.pcm_wd_sz;
+				num_channel = str_param->
+					sparams.uc.pcm_params.num_chan;
+				if (str_param->ops == STREAM_OPS_CAPTURE) {
+					sst_drv_ctx->scard_ops->\
+					set_pcm_audio_params(sfreq,
+						word_size, num_channel);
+				}
+			}
+		}
+		break;
+	}
+	case _IOC_NR(SNDRV_SST_SET_VOL): {
+		struct snd_sst_vol *set_vol;
+		struct snd_sst_vol *rec_vol = (struct snd_sst_vol *)arg;
+		pr_debug("sst: SET_VOLUME recieved for %d!\n",
+				rec_vol->stream_id);
+		if (minor == STREAM_MODULE && rec_vol->stream_id == 0) {
+			pr_debug("sst: invalid operation!\n");
+			retval = -EPERM;
+			break;
+		}
+		set_vol = kzalloc(sizeof(*set_vol), GFP_ATOMIC);
+		if (!set_vol) {
+			pr_debug("sst: mem allocation failed\n");
+			retval = -ENOMEM;
+			break;
+		}
+		retval = copy_from_user(set_vol, rec_vol, sizeof(*set_vol));
+		if (retval) {
+			pr_debug("sst: copy failed\n");
+			retval = -EAGAIN;
+			break;
+		}
+		retval = sst_set_vol(set_vol);
+		kfree(set_vol);
+		break;
+	}
+	case _IOC_NR(SNDRV_SST_GET_VOL): {
+		struct snd_sst_vol *rec_vol = (struct snd_sst_vol *)arg;
+		struct snd_sst_vol get_vol;
+		pr_debug("sst: IOCTL_GET_VOLUME recieved for stream = %d!\n",
+				rec_vol->stream_id);
+		if (minor == STREAM_MODULE && rec_vol->stream_id == 0) {
+			pr_debug("sst: invalid operation!\n");
+			retval = -EPERM;
+			break;
+		}
+		get_vol.stream_id = rec_vol->stream_id;
+		retval = sst_get_vol(&get_vol);
+		if (retval) {
+			retval = -EIO;
+			break;
+		}
+		pr_debug("sst: id:%d\n, vol:%d, ramp_dur:%d, ramp_type:%d\n",
+				get_vol.stream_id, get_vol.volume,
+				get_vol.ramp_duration, get_vol.ramp_type);
+		retval = copy_to_user((struct snd_sst_vol *)arg,
+						&get_vol, sizeof(get_vol));
+		if (retval) {
+			retval = -EIO;
+			break;
+		}
+		/*sst_print_get_vol_info(str_id, &get_vol);*/
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_MUTE): {
+		struct snd_sst_mute *set_mute;
+		struct snd_sst_vol *rec_mute = (struct snd_sst_vol *)arg;
+		pr_debug("sst: SNDRV_SST_SET_VOLUME recieved for %d!\n",
+			rec_mute->stream_id);
+		if (minor == STREAM_MODULE && rec_mute->stream_id == 0) {
+			retval = -EPERM;
+			break;
+		}
+		set_mute = kzalloc(sizeof(*set_mute), GFP_ATOMIC);
+		if (!set_mute) {
+			retval = -ENOMEM;
+			break;
+		}
+		retval = copy_from_user(set_mute, rec_mute, sizeof(*set_mute));
+		if (retval) {
+			retval = -EFAULT;
+			break;
+		}
+		retval = sst_set_mute(set_mute);
+		kfree(set_mute);
+		break;
+	}
+	case _IOC_NR(SNDRV_SST_STREAM_GET_PARAMS): {
+		struct snd_sst_get_stream_params get_params;
+
+		pr_debug("sst: IOCTL_GET_PARAMS recieved!\n");
+		if (minor != 0) {
+			retval = -EBADRQC;
+			break;
+		}
+
+		retval = sst_get_stream_params(str_id, &get_params);
+		if (retval) {
+			retval = -EIO;
+			break;
+		}
+		retval = copy_to_user((struct snd_sst_get_stream_params *)arg,
+					&get_params, sizeof(get_params));
+		if (retval) {
+			retval = -EBUSY;
+			break;
+		}
+		sst_print_stream_params(&get_params);
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_MMAP_PLAY):
+	case _IOC_NR(SNDRV_SST_MMAP_CAPTURE):
+		pr_debug("sst: SNDRV_SST_MMAP_PLAY/CAPTURE recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+		retval = intel_sst_mmap_play_capture(str_id,
+				(struct snd_sst_mmap_buffs *)arg);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_DROP):
+		pr_debug("sst: SNDRV_SST_IOCTL_DROP recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_drop_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_GET_TSTAMP): {
+		unsigned long long *ms = (unsigned long long *)arg;
+		struct snd_sst_tstamp tstamp = {0};
+		unsigned long long time, freq, mod;
+
+		pr_debug("sst: SNDRV_SST_STREAM_GET_TSTAMP recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+		memcpy_fromio(&tstamp,
+			((void *)(sst_drv_ctx->mailbox + SST_TIME_STAMP)
+			+(str_id * sizeof(tstamp))),
+			sizeof(tstamp));
+		time = tstamp.samples_rendered;
+		freq = (unsigned long long) tstamp.sampling_frequency;
+		time = time * 1000; /* converting it to ms */
+		mod = do_div(time, freq);
+		retval = copy_to_user(ms, &time, sizeof(*ms));
+		if (retval)
+			retval = -EFAULT;
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_STREAM_START):{
+		struct stream_info *stream;
+
+		pr_debug("sst: SNDRV_SST_STREAM_START recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_validate_strid(str_id);
+		if (retval)
+			break;
+		stream = &sst_drv_ctx->streams[str_id];
+		mutex_lock(&stream->lock);
+		if (stream->status == STREAM_INIT &&
+			stream->need_draining != true) {
+			stream->prev = stream->status;
+			stream->status = STREAM_RUNNING;
+			if (stream->ops == STREAM_OPS_PLAYBACK ||
+				stream->ops == STREAM_OPS_PLAYBACK_DRM) {
+				retval = sst_play_frame(str_id);
+			} else if (stream->ops == STREAM_OPS_CAPTURE)
+				retval = sst_capture_frame(str_id);
+			else {
+				retval = -EINVAL;
+				mutex_unlock(
+					&sst_drv_ctx->streams[str_id].lock);
+				break;
+			}
+			if (retval < 0) {
+				stream->status = STREAM_INIT;
+				mutex_unlock(
+					&sst_drv_ctx->streams[str_id].lock);
+				break;
+			}
+		} else {
+			retval = -EINVAL;
+		}
+		mutex_unlock(&sst_drv_ctx->streams[str_id].lock);
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_SET_TARGET_DEVICE): {
+		struct snd_sst_target_device *target_device;
+
+		pr_debug("sst: SET_TARGET_DEVICE recieved!\n");
+		target_device =	(struct snd_sst_target_device *)arg;
+		BUG_ON(!target_device);
+		if (minor != AM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+		retval = sst_target_device_select(target_device);
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_DRIVER_INFO): {
+		struct snd_sst_driver_info *info =
+			(struct snd_sst_driver_info *)arg;
+
+		pr_debug("sst: SNDRV_SST_DRIVER_INFO recived\n");
+		info->version = SST_VERSION_NUM;
+		/* hard coding, shud get sumhow later */
+		info->active_pcm_streams = sst_drv_ctx->stream_cnt -
+						sst_drv_ctx->encoded_cnt;
+		info->active_enc_streams = sst_drv_ctx->encoded_cnt;
+		info->max_pcm_streams = MAX_ACTIVE_STREAM - MAX_ENC_STREAM;
+		info->max_enc_streams = MAX_ENC_STREAM;
+		info->buf_per_stream = sst_drv_ctx->mmap_len;
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_STREAM_DECODE): {
+		struct snd_sst_dbufs *param =
+				(struct snd_sst_dbufs *)arg, dbufs_local;
+		int i;
+		struct snd_sst_buffs ibufs, obufs;
+		struct snd_sst_buff_entry ibuf_temp[param->ibufs->entries],
+				obuf_temp[param->obufs->entries];
+
+		pr_debug("sst: SNDRV_SST_STREAM_DECODE recived\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EBADRQC;
+			break;
+		}
+		if (!param) {
+			retval = -EINVAL;
+			break;
+		}
+
+		dbufs_local.input_bytes_consumed = param->input_bytes_consumed;
+		dbufs_local.output_bytes_produced =
+					param->output_bytes_produced;
+		dbufs_local.ibufs = &ibufs;
+		dbufs_local.obufs = &obufs;
+		dbufs_local.ibufs->entries = param->ibufs->entries;
+		dbufs_local.ibufs->type = param->ibufs->type;
+		dbufs_local.obufs->entries = param->obufs->entries;
+		dbufs_local.obufs->type = param->obufs->type;
+
+		dbufs_local.ibufs->buff_entry = ibuf_temp;
+		for (i = 0; i < dbufs_local.ibufs->entries; i++) {
+			ibuf_temp[i].buffer =
+				param->ibufs->buff_entry[i].buffer;
+			ibuf_temp[i].size =
+				param->ibufs->buff_entry[i].size;
+		}
+		dbufs_local.obufs->buff_entry = obuf_temp;
+		for (i = 0; i < dbufs_local.obufs->entries; i++) {
+			obuf_temp[i].buffer =
+				param->obufs->buff_entry[i].buffer;
+			obuf_temp[i].size =
+				param->obufs->buff_entry[i].size;
+		}
+		retval = sst_decode(str_id, &dbufs_local);
+		if (retval)
+			retval =  -EAGAIN;
+		retval = copy_to_user(&param->input_bytes_consumed,
+			&dbufs_local.input_bytes_consumed,
+			sizeof(unsigned long long));
+		if (retval) {
+			retval =  -EFAULT;
+			break;
+		}
+		retval = copy_to_user(&param->output_bytes_produced,
+				&dbufs_local.output_bytes_produced,
+				sizeof(unsigned long long));
+		if (retval) {
+			retval =  -EFAULT;
+			break;
+		}
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_STREAM_DRAIN):
+		pr_debug("sst: SNDRV_SST_STREAM_DRAIN recived\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_drain_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_BYTES_DECODED): {
+		unsigned long long *bytes = (unsigned long long *)arg;
+		struct snd_sst_tstamp tstamp = {0};
+
+		pr_debug("sst: STREAM_BYTES_DECODED recieved!\n");
+		if (minor != STREAM_MODULE) {
+			retval = -EINVAL;
+			break;
+		}
+		memcpy_fromio(&tstamp,
+			((void *)(sst_drv_ctx->mailbox + SST_TIME_STAMP)
+			+(str_id * sizeof(tstamp))),
+			sizeof(tstamp));
+		retval = copy_to_user(bytes, &tstamp.bytes_processed,
+					sizeof(*bytes));
+		if (retval)
+			retval = -EFAULT;
+		break;
+	}
+	case _IOC_NR(SNDRV_SST_FW_INFO): {
+		struct snd_sst_fw_info *fw_info;
+
+		pr_debug("sst: SNDRV_SST_FW_INFO recived\n");
+
+		fw_info = kzalloc(sizeof(*fw_info), GFP_ATOMIC);
+		if (!fw_info) {
+			retval = -ENOMEM;
+			break;
+		}
+		retval = sst_get_fw_info(fw_info);
+		if (retval) {
+			retval = -EIO;
+			kfree(fw_info);
+			break;
+		}
+		retval = copy_to_user((struct snd_sst_dbufs *)arg,
+					fw_info, sizeof(*fw_info));
+		if (retval) {
+			kfree(fw_info);
+			retval = -EFAULT;
+			break;
+		}
+		/*sst_print_fw_info(fw_info);*/
+		kfree(fw_info);
+		break;
+	}
+	default:
+		retval = -EINVAL;
+	}
+	unlock_kernel();
+	pr_debug("sst: intel_sst_ioctl:complete ret code = %d\n", retval);
+	return retval;
+}
+
diff --git a/drivers/staging/intel_sst/intel_sst_common.h b/drivers/staging/intel_sst/intel_sst_common.h
new file mode 100644
index 0000000..73a98c8
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_common.h
@@ -0,0 +1,618 @@
+#ifndef __INTEL_SST_COMMON_H__
+#define __INTEL_SST_COMMON_H__
+/*
+ *  intel_sst_common.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  Common private declarations for SST
+ */
+
+#define SST_DRIVER_VERSION "1.2.05"
+#define SST_VERSION_NUM 0x1205
+
+/* driver names */
+#define SST_DRV_NAME "intel_sst_driver"
+#define SST_FW_FILENAME_MRST "fw_sst_080a.bin"
+#define SST_FW_FILENAME_MFLD "fw_sst_082f.bin"
+#define SST_MRST_PCI_ID 0x080A
+#define SST_MFLD_PCI_ID 0x082F
+
+enum sst_states {
+	SST_FW_LOADED = 1,
+	SST_FW_RUNNING,
+	SST_UN_INIT,
+	SST_ERROR,
+	SST_SUSPENDED
+};
+
+#define MAX_ACTIVE_STREAM	3
+#define MAX_ENC_STREAM		1
+#define MAX_AM_HANDLES		1
+#define ALLOC_TIMEOUT		5000
+/* SST numbers */
+#define SST_BLOCK_TIMEOUT	5000
+#define TARGET_DEV_BLOCK_TIMEOUT	5000
+
+#define BLOCK_UNINIT		-1
+#define RX_TIMESLOT_UNINIT	-1
+
+/* SST register map */
+#define SST_CSR			0x00
+#define SST_PISR		0x08
+#define SST_PIMR		0x10
+#define SST_ISRX		0x18
+#define SST_IMRX		0x28
+#define SST_IPCX		0x38 /* IPC IA-SST */
+#define SST_IPCD		0x40 /* IPC SST-IA */
+#define SST_ISRD		0x20 /* dummy register for shim workaround */
+#define SST_SHIM_SIZE		0X44
+
+#define SPI_MODE_ENABLE_BASE_ADDR 0xffae4000
+#define FW_SIGNATURE_SIZE	4
+
+/* PMIC and SST hardware states */
+enum sst_mad_states {
+	SND_MAD_UN_INIT = 0,
+	SND_MAD_INIT_DONE,
+};
+
+/* stream states */
+enum sst_stream_states {
+	STREAM_UN_INIT	= 0,	/* Freed/Not used stream */
+	STREAM_RUNNING	= 1,	/* Running */
+	STREAM_PAUSED	= 2,	/* Paused stream */
+	STREAM_DECODE	= 3,	/* stream is in decoding only state */
+	STREAM_INIT	= 4,	/* stream init, waiting for data */
+};
+
+
+enum sst_ram_type {
+	SST_IRAM	= 1,
+	SST_DRAM	= 2,
+};
+/* SST shim registers to structure mapping  */
+union config_status_reg {
+	struct {
+		u32 rsvd0:1;
+		u32 sst_reset:1;
+		u32 hw_rsvd:3;
+		u32 sst_clk:2;
+		u32 bypass:3;
+		u32 run_stall:1;
+		u32 rsvd1:2;
+		u32 strb_cntr_rst:1;
+		u32 rsvd:18;
+	} part;
+	u32 full;
+};
+
+union interrupt_reg {
+	struct {
+		u32 done_interrupt:1;
+		u32 busy_interrupt:1;
+		u32 rsvd:30;
+	} part;
+	u32 full;
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
+
+struct sst_stream_bufs {
+	struct list_head	node;
+	u32			size;
+	const char		*addr;
+	u32			data_copied;
+	bool			in_use;
+	u32			offset;
+};
+
+struct snd_sst_user_cap_list {
+	unsigned int iov_index; /* index of iov */
+	unsigned long iov_offset; /* offset in iov */
+	unsigned long offset; /* offset in kmem */
+	unsigned long size; /* size copied */
+	struct list_head node;
+};
+/*
+This structure is used to block a user/fw data call to another
+fw/user call
+*/
+struct sst_block {
+	bool	condition; /* condition for blocking check */
+	int	ret_code; /* ret code when block is released */
+	void	*data; /* data to be appsed for block if any */
+	bool	on;
+};
+
+enum snd_sst_buf_type {
+	SST_BUF_USER_STATIC = 1,
+	SST_BUF_USER_DYNAMIC,
+	SST_BUF_MMAP_STATIC,
+	SST_BUF_MMAP_DYNAMIC,
+};
+
+enum snd_src {
+	SST_DRV = 1,
+	MAD_DRV = 2
+};
+
+/**
+ * struct stream_info - structure that holds the stream information
+ *
+ * @status : stream current state
+ * @prev : stream prev state
+ * @codec : stream codec
+ * @sst_id : stream id
+ * @ops : stream operation pb/cp/drm...
+ * @bufs: stream buffer list
+ * @lock : stream mutex for protecting state
+ * @pcm_lock : spinlock for pcm path only
+ * @mmapped : is stream mmapped
+ * @sg_index : current stream user buffer index
+ * @cur_ptr : stream user buffer pointer
+ * @buf_entry : current user buffer
+ * @data_blk : stream block for data operations
+ * @ctrl_blk : stream block for ctrl operations
+ * @buf_type : stream user buffer type
+ * @pcm_substream : PCM substream
+ * @period_elapsed : PCM period elapsed callback
+ * @sfreq : stream sampling freq
+ * @decode_ibuf : Decoded i/p buffers pointer
+ * @decode_obuf : Decoded o/p buffers pointer
+ * @decode_isize : Decoded i/p buffers size
+ * @decode_osize : Decoded o/p buffers size
+ * @decode_ibuf_type : Decoded i/p buffer type
+ * @decode_obuf_type : Decoded o/p buffer type
+ * @idecode_alloc : Decode alloc index
+ * @need_draining : stream set for drain
+ * @str_type : stream type
+ * @curr_bytes : current bytes decoded
+ * @cumm_bytes : cummulative bytes decoded
+ * @str_type : stream type
+ * @src : stream source
+ * @device : output device type (medfield only)
+ * @pcm_slot : pcm slot value
+ */
+struct stream_info {
+	unsigned int		status;
+	unsigned int		prev;
+	u8			codec;
+	unsigned int		sst_id;
+	unsigned int		ops;
+	struct list_head	bufs;
+	struct mutex		lock; /* mutex */
+	spinlock_t          pcm_lock;
+	bool			mmapped;
+	unsigned int		sg_index; /*  current buf Index  */
+	unsigned char		*cur_ptr; /*  Current static bufs  */
+	struct snd_sst_buf_entry *buf_entry;
+	struct sst_block	data_blk; /* stream ops block */
+	struct sst_block	ctrl_blk; /* stream control cmd block */
+	enum snd_sst_buf_type   buf_type;
+	void			*pcm_substream;
+	void (*period_elapsed) (void *pcm_substream);
+	unsigned int		sfreq;
+	void			*decode_ibuf, *decode_obuf;
+	unsigned int		decode_isize, decode_osize;
+	u8 decode_ibuf_type, decode_obuf_type;
+	unsigned int		idecode_alloc;
+	unsigned int		need_draining;
+	unsigned int		str_type;
+	u32			curr_bytes;
+	u32			cumm_bytes;
+	u32			src;
+	enum snd_sst_audio_device_type device;
+	u8			pcm_slot;
+};
+
+/*
+ * struct stream_alloc_bloc - this structure is used for blocking the user's
+ * alloc calls to fw's response to alloc calls
+ *
+ * @sst_id : session id of blocked stream
+ * @ops_block : ops block struture
+ */
+struct stream_alloc_block {
+	int			sst_id; /* session id of blocked stream */
+	struct sst_block	ops_block; /* ops block struture */
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
+struct dma_block_info {
+	enum sst_ram_type	type;	/* IRAM/DRAM */
+	u32			size;	/* Bytes */
+	u32			ram_offset; /* Offset in I/DRAM */
+	u32			rsvd;	/* Reserved field */
+};
+
+struct ioctl_pvt_data {
+	int			str_id;
+	int			pvt_id;
+};
+
+struct sst_ipc_msg_wq {
+	union ipc_header	header;
+	char mailbox[SST_MAILBOX_SIZE];
+	struct work_struct	wq;
+};
+
+struct mad_ops_wq {
+	int stream_id;
+	enum sst_controls control_op;
+	struct work_struct	wq;
+
+};
+
+#define SST_MMAP_PAGES	(640*1024 / PAGE_SIZE)
+#define SST_MMAP_STEP	(40*1024 / PAGE_SIZE)
+
+/***
+ * struct intel_sst_drv - driver ops
+ *
+ * @pmic_state : pmic state
+ * @pmic_vendor : pmic vendor detected
+ * @sst_state : current sst device state
+ * @pci_id : PCI device id loaded
+ * @shim : SST shim pointer
+ * @mailbox : SST mailbox pointer
+ * @iram : SST IRAM pointer
+ * @dram : SST DRAM pointer
+ * @shim_phy_add : SST shim phy addr
+ * @ipc_dispatch_list : ipc messages dispatched
+ * @ipc_post_msg_wq : wq to post IPC messages context
+ * @ipc_process_msg : wq to process msgs from FW context
+ * @ipc_process_reply : wq to process reply from FW context
+ * @ipc_post_msg : wq to post reply from FW context
+ * @mad_ops : MAD driver operations registered
+ * @mad_wq : MAD driver wq
+ * @post_msg_wq : wq to post IPC messages
+ * @process_msg_wq : wq to process msgs from FW
+ * @process_reply_wq : wq to process reply from FW
+ * @streams : sst stream contexts
+ * @alloc_block : block structure for alloc
+ * @tgt_dev_blk : block structure for target device
+ * @fw_info_blk : block structure for fw info block
+ * @vol_info_blk : block structure for vol info block
+ * @mute_info_blk : block structure for mute info block
+ * @hs_info_blk : block structure for hs info block
+ * @list_lock : sst driver list lock (deprecated)
+ * @list_spin_lock : sst driver spin lock block
+ * @scard_ops : sst card ops
+ * @pci : sst pci device struture
+ * @active_streams : sst active streams
+ * @sst_lock : sst device lock
+ * @stream_lock : sst stream lock
+ * @unique_id : sst unique id
+ * @stream_cnt : total sst active stream count
+ * @pb_streams : total active pb streams
+ * @cp_streams : total active cp streams
+ * @lpe_stalled : lpe stall status
+ * @pmic_port_instance : active pmic port instance
+ * @rx_time_slot_status : active rx slot
+ * @lpaudio_start : lpaudio status
+ * @audio_start : audio status
+ * @devt_d : pointer to /dev/lpe node
+ * @devt_c : pointer to /dev/lpe_ctrl node
+ * @max_streams : max streams allowed
+ */
+struct intel_sst_drv {
+	bool			pmic_state;
+	int			pmic_vendor;
+	int			sst_state;
+	unsigned int		pci_id;
+	void __iomem		*shim;
+	void __iomem		*mailbox;
+	void __iomem		*iram;
+	void __iomem		*dram;
+	unsigned int		shim_phy_add;
+	struct list_head	ipc_dispatch_list;
+	struct work_struct	ipc_post_msg_wq;
+	struct sst_ipc_msg_wq	ipc_process_msg;
+	struct sst_ipc_msg_wq	ipc_process_reply;
+	struct sst_ipc_msg_wq	ipc_post_msg;
+	struct mad_ops_wq	mad_ops;
+	wait_queue_head_t	wait_queue;
+	struct workqueue_struct *mad_wq;
+	struct workqueue_struct *post_msg_wq;
+	struct workqueue_struct *process_msg_wq;
+	struct workqueue_struct *process_reply_wq;
+
+	struct stream_info	streams[MAX_NUM_STREAMS];
+	struct stream_alloc_block alloc_block[MAX_ACTIVE_STREAM];
+	struct sst_block	tgt_dev_blk, fw_info_blk,
+				vol_info_blk, mute_info_blk, hs_info_blk;
+	struct mutex		list_lock;/* mutex for IPC list locking */
+	spinlock_t	list_spin_lock; /* mutex for IPC list locking */
+	struct snd_pmic_ops	*scard_ops;
+	struct pci_dev		*pci;
+	int active_streams[MAX_NUM_STREAMS];
+	void			*mmap_mem;
+	struct mutex            sst_lock;
+	struct mutex		stream_lock;
+	unsigned int		mmap_len;
+	unsigned int		unique_id;
+	unsigned int		stream_cnt;	/* total streams */
+	unsigned int		encoded_cnt;	/* enocded streams only */
+	unsigned int		am_cnt;
+	unsigned int		pb_streams;	/* pb streams active */
+	unsigned int		cp_streams;	/* cp streams active */
+	unsigned int		lpe_stalled; /* LPE is stalled or not */
+	unsigned int		pmic_port_instance; /*pmic port instance*/
+	int			rx_time_slot_status;
+	unsigned int		lpaudio_start;
+		/* 1 - LPA stream(MP3 pb) in progress*/
+	unsigned int		audio_start;
+	dev_t			devt_d, devt_c;
+	unsigned int		max_streams;
+};
+
+extern struct intel_sst_drv *sst_drv_ctx;
+
+#define CHIP_REV_REG 0xff108000
+#define CHIP_REV_ADDR 0x78
+
+/* misc definitions */
+#define FW_DWNL_ID 0xFF
+#define LOOP1 0x11111111
+#define LOOP2 0x22222222
+#define LOOP3 0x33333333
+#define LOOP4 0x44444444
+
+#define SST_DEFAULT_PMIC_PORT 1 /*audio port*/
+/* NOTE: status will have +ve for good cases and -ve for error ones */
+#define MAX_STREAM_FIELD 255
+
+int sst_alloc_stream(char *params, unsigned int stream_ops, u8 codec,
+						unsigned int session_id);
+int sst_alloc_stream_response(unsigned int str_id,
+				struct snd_sst_alloc_response *response);
+int sst_stalled(void);
+int sst_pause_stream(int id);
+int sst_resume_stream(int id);
+int sst_enable_rx_timeslot(int status);
+int sst_drop_stream(int id);
+int sst_free_stream(int id);
+int sst_start_stream(int streamID);
+int sst_play_frame(int streamID);
+int sst_pcm_play_frame(int str_id, struct sst_stream_bufs *sst_buf);
+int sst_capture_frame(int streamID);
+int sst_set_stream_param(int streamID, struct snd_sst_params *str_param);
+int sst_target_device_select(struct snd_sst_target_device *target_device);
+int sst_decode(int str_id, struct snd_sst_dbufs *dbufs);
+int sst_get_decoded_bytes(int str_id, unsigned long long *bytes);
+int sst_get_fw_info(struct snd_sst_fw_info *info);
+int sst_get_stream_params(int str_id,
+		struct snd_sst_get_stream_params *get_params);
+int sst_get_stream(struct snd_sst_params *str_param);
+int sst_get_stream_allocated(struct snd_sst_params *str_param,
+				struct snd_sst_lib_download **lib_dnld);
+int sst_drain_stream(int str_id);
+int sst_get_vol(struct snd_sst_vol *set_vol);
+int sst_set_vol(struct snd_sst_vol *set_vol);
+int sst_set_mute(struct snd_sst_mute *set_mute);
+
+
+void sst_post_message(struct work_struct *work);
+void sst_process_message(struct work_struct *work);
+void sst_process_reply(struct work_struct *work);
+void sst_process_mad_ops(struct work_struct *work);
+void sst_process_mad_jack_detection(struct work_struct *work);
+
+long intel_sst_ioctl(struct file *file_ptr, unsigned int cmd,
+			unsigned long arg);
+int intel_sst_open(struct inode *i_node, struct file *file_ptr);
+int intel_sst_open_cntrl(struct inode *i_node, struct file *file_ptr);
+int intel_sst_release(struct inode *i_node, struct file *file_ptr);
+int intel_sst_release_cntrl(struct inode *i_node, struct file *file_ptr);
+int intel_sst_read(struct file *file_ptr, char __user *buf,
+			size_t count, loff_t *ppos);
+int intel_sst_write(struct file *file_ptr, const char __user *buf,
+			size_t count, loff_t *ppos);
+int intel_sst_mmap(struct file *fp, struct vm_area_struct *vma);
+ssize_t intel_sst_aio_write(struct kiocb *kiocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t  offset);
+ssize_t intel_sst_aio_read(struct kiocb *kiocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t offset);
+
+int sst_load_fw(const struct firmware *fw, void *context);
+int sst_load_library(struct snd_sst_lib_download *lib, u8 ops);
+int sst_spi_mode_enable(void);
+int sst_get_block_stream(struct intel_sst_drv *sst_drv_ctx);
+
+int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
+				struct sst_block *block);
+int sst_wait_interruptible_timeout(struct intel_sst_drv *sst_drv_ctx,
+		struct sst_block *block, int timeout);
+int sst_wait_timeout(struct intel_sst_drv *sst_drv_ctx,
+		struct stream_alloc_block *block);
+int sst_create_large_msg(struct ipc_post **arg);
+int sst_create_short_msg(struct ipc_post **arg);
+void sst_wake_up_alloc_block(struct intel_sst_drv *sst_drv_ctx,
+		u8 sst_id, int status, void *data);
+void sst_clear_interrupt(void);
+int intel_sst_resume(struct pci_dev *pci);
+int sst_download_fw(void);
+void free_stream_context(unsigned int str_id);
+void sst_clean_stream(struct stream_info *stream);
+
+/*
+ * sst_fill_header - inline to fill sst header
+ *
+ * @header : ipc header
+ * @msg : IPC message to be sent
+ * @large : is ipc large msg
+ * @str_id : stream id
+ *
+ * this function is an inline function that sets the headers before
+ * sending a message
+ */
+static inline void sst_fill_header(union ipc_header *header,
+				int msg, int large, int str_id)
+{
+	header->part.msg_id = msg;
+	header->part.str_id = str_id;
+	header->part.large = large;
+	header->part.done = 0;
+	header->part.busy = 1;
+	header->part.data = 0;
+}
+
+/*
+ * sst_assign_pvt_id - assign a pvt id for stream
+ *
+ * @sst_drv_ctx : driver context
+ *
+ * this inline function assigns a private id for calls that dont have stream
+ * context yet, should be called with lock held
+ */
+static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx)
+{
+	sst_drv_ctx->unique_id++;
+	if (sst_drv_ctx->unique_id >= MAX_NUM_STREAMS)
+		sst_drv_ctx->unique_id = 1;
+	return sst_drv_ctx->unique_id;
+}
+
+/*
+ * sst_init_stream - this function initialzes stream context
+ *
+ * @stream : stream struture
+ * @codec : codec for stream
+ * @sst_id : stream id
+ * @ops : stream operation
+ * @slot : stream pcm slot
+ * @device : device type
+ *
+ * this inline function initialzes stream context for allocated stream
+ */
+static inline void sst_init_stream(struct stream_info *stream,
+		int codec, int sst_id, int ops, u8 slot,
+		enum snd_sst_audio_device_type device)
+{
+	stream->status = STREAM_INIT;
+	stream->prev = STREAM_UN_INIT;
+	stream->codec = codec;
+	stream->sst_id = sst_id;
+	stream->str_type = 0;
+	stream->ops = ops;
+	stream->data_blk.on = false;
+	stream->data_blk.condition = false;
+	stream->data_blk.ret_code = 0;
+	stream->data_blk.data = NULL;
+	stream->ctrl_blk.on = false;
+	stream->ctrl_blk.condition = false;
+	stream->ctrl_blk.ret_code = 0;
+	stream->ctrl_blk.data = NULL;
+	stream->need_draining = false;
+	stream->decode_ibuf = NULL;
+	stream->decode_isize = 0;
+	stream->mmapped = false;
+	stream->pcm_slot = slot;
+	stream->device = device;
+}
+
+
+/*
+ * sst_validate_strid - this function validates the stream id
+ *
+ * @str_id : stream id to be validated
+ *
+ * returns 0 if valid stream
+ */
+static inline int sst_validate_strid(int str_id)
+{
+	if (str_id <= 0 || str_id > sst_drv_ctx->max_streams) {
+		pr_err("SST ERR: invalid stream id : %d MAX_STREAMS:%d\n",
+					str_id, sst_drv_ctx->max_streams);
+		return -EINVAL;
+	} else
+		return 0;
+}
+
+static inline int sst_shim_write(void __iomem *addr, int offset, int value)
+{
+
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+		writel(value, addr + SST_ISRD);	/*dummy*/
+	writel(value, addr + offset);
+	return 0;
+}
+
+static inline int sst_shim_read(void __iomem *addr, int offset)
+{
+	return readl(addr + offset);
+}
+#endif /* __INTEL_SST_COMMON_H__ */
diff --git a/drivers/staging/intel_sst/intel_sst_drv_interface.c b/drivers/staging/intel_sst/intel_sst_drv_interface.c
new file mode 100644
index 0000000..715c2d8
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_drv_interface.c
@@ -0,0 +1,492 @@
+/*
+ *  intel_sst_interface.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corp
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *  Upper layer interfaces (MAD driver, MMF) to SST driver
+ */
+
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+
+/*
+ * sst_download_fw - download the audio firmware to DSP
+ *
+ * This function is called when the FW needs to be downloaded to SST DSP engine
+ */
+int sst_download_fw(void)
+{
+	int retval;
+	const struct firmware *fw_sst;
+	const char *name;
+	if (sst_drv_ctx->sst_state != SST_UN_INIT)
+		return -EPERM;
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+		name = SST_FW_FILENAME_MRST;
+	else
+		name = SST_FW_FILENAME_MFLD;
+	pr_debug("sst: Downloading %s FW now...\n", name);
+	retval = request_firmware(&fw_sst, name, &sst_drv_ctx->pci->dev);
+	if (retval) {
+		pr_err("sst: request fw failed %d\n", retval);
+		return retval;
+	}
+	sst_drv_ctx->alloc_block[0].sst_id = FW_DWNL_ID;
+	sst_drv_ctx->alloc_block[0].ops_block.condition = false;
+	retval = sst_load_fw(fw_sst, NULL);
+	if (retval)
+		goto end_restore;
+
+	retval = sst_wait_timeout(sst_drv_ctx, &sst_drv_ctx->alloc_block[0]);
+	if (retval)
+		pr_err("sst: fw download failed %d\n" , retval);
+end_restore:
+	release_firmware(fw_sst);
+	sst_drv_ctx->alloc_block[0].sst_id = BLOCK_UNINIT;
+	return retval;
+}
+
+
+/*
+ * sst_stalled - this function checks if the lpe is in stalled state
+ */
+int sst_stalled(void)
+{
+	int retry = 1000;
+	int retval = -1;
+
+	while (retry) {
+		if (!sst_drv_ctx->lpe_stalled)
+			return 0;
+		/*wait for time and re-check*/
+		msleep(1);
+
+		retry--;
+	}
+	pr_debug("sst: in Stalled State\n");
+	return retval;
+}
+
+void free_stream_context(unsigned int str_id)
+{
+	struct stream_info *stream;
+
+	if (!sst_validate_strid(str_id)) {
+		/* str_id is valid, so stream is alloacted */
+		stream = &sst_drv_ctx->streams[str_id];
+		if (stream->ops == STREAM_OPS_PLAYBACK ||
+				stream->ops == STREAM_OPS_PLAYBACK_DRM) {
+			sst_drv_ctx->pb_streams--;
+			if (sst_drv_ctx->pb_streams == 0)
+				sst_drv_ctx->scard_ops->power_down_pmic_pb();
+		} else if (stream->ops == STREAM_OPS_CAPTURE) {
+			sst_drv_ctx->cp_streams--;
+			if (sst_drv_ctx->cp_streams == 0)
+				sst_drv_ctx->scard_ops->power_down_pmic_cp();
+		}
+		if (sst_drv_ctx->pb_streams == 0
+				&& sst_drv_ctx->cp_streams == 0)
+			sst_drv_ctx->scard_ops->power_down_pmic();
+		if (sst_free_stream(str_id))
+			sst_clean_stream(&sst_drv_ctx->streams[str_id]);
+	}
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
+	struct stream_info *str_info;
+
+	retval = sst_alloc_stream((char *) &str_param->sparams, str_param->ops,
+				str_param->codec, str_param->device_type);
+	if (retval < 0) {
+		pr_err("sst: sst_alloc_stream failed %d\n", retval);
+		return retval;
+	}
+	pr_debug("sst: Stream allocated %d\n", retval);
+	str_id = retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+	/* Block the call for reply */
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+			&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+	if ((retval != 0) || (str_info->ctrl_blk.ret_code != 0)) {
+		pr_debug("sst: FW alloc failed retval %d, ret_code %d\n",
+				retval, str_info->ctrl_blk.ret_code);
+		str_id = -str_info->ctrl_blk.ret_code; /*return error*/
+		*lib_dnld = str_info->ctrl_blk.data;
+		sst_clean_stream(str_info);
+	} else
+		pr_debug("sst: FW Stream allocated sucess\n");
+	return str_id; /*will ret either error (in above if) or correct str id*/
+}
+
+/*
+ * sst_get_sfreq - this function returns the frequency of the stream
+ *
+ * @str_param : stream params
+ */
+static int sst_get_sfreq(struct snd_sst_params *str_param)
+{
+	switch (str_param->codec) {
+	case SST_CODEC_TYPE_PCM:
+		return 48000; /*str_param->sparams.uc.pcm_params.sfreq;*/
+	case SST_CODEC_TYPE_MP3:
+		return str_param->sparams.uc.mp3_params.sfreq;
+	case SST_CODEC_TYPE_AAC:
+		return str_param->sparams.uc.aac_params.sfreq;;
+	case SST_CODEC_TYPE_WMA9:
+		return str_param->sparams.uc.wma_params.sfreq;;
+	default:
+		return 0;
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
+	int i, retval;
+	struct stream_info *str_info;
+	struct snd_sst_lib_download *lib_dnld;
+
+	/* stream is not allocated, we are allocating */
+	retval = sst_get_stream_allocated(str_param, &lib_dnld);
+	if (retval == -(SST_LIB_ERR_LIB_DNLD_REQUIRED)) {
+		/* codec download is required */
+		struct snd_sst_alloc_response *response;
+
+		pr_debug("sst: Codec is required.... trying that\n");
+		if (lib_dnld == NULL) {
+			pr_err("sst: lib download null!!! abort\n");
+			return -EIO;
+		}
+		i = sst_get_block_stream(sst_drv_ctx);
+		response = sst_drv_ctx->alloc_block[i].ops_block.data;
+		pr_debug("sst: alloc block allocated = %d\n", i);
+		if (i < 0) {
+			kfree(lib_dnld);
+			return -ENOMEM;
+		}
+		retval = sst_load_library(lib_dnld, str_param->ops);
+		kfree(lib_dnld);
+
+		sst_drv_ctx->alloc_block[i].sst_id = BLOCK_UNINIT;
+		if (!retval) {
+			pr_debug("sst: codec was downloaded sucesfully\n");
+
+			retval = sst_get_stream_allocated(str_param, &lib_dnld);
+			if (retval <= 0)
+				goto err;
+
+			pr_debug("sst: Alloc done stream id %d\n", retval);
+		} else {
+			pr_debug("sst: codec download failed\n");
+			retval = -EIO;
+			goto err;
+		}
+	} else if  (retval <= 0)
+		goto err;
+	/*else
+		set_port_params(str_param, str_param->ops);*/
+
+	/* store sampling freq */
+	str_info = &sst_drv_ctx->streams[retval];
+	str_info->sfreq = sst_get_sfreq(str_param);
+
+	/* power on the analog, if reqd */
+	if (str_param->ops == STREAM_OPS_PLAYBACK ||
+			str_param->ops == STREAM_OPS_PLAYBACK_DRM) {
+		if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+			sst_drv_ctx->scard_ops->power_up_pmic_pb(
+					sst_drv_ctx->pmic_port_instance);
+		else
+			sst_drv_ctx->scard_ops->power_up_pmic_pb(
+							str_info->device);
+		/*Only if the playback is MP3 - Send a message*/
+		sst_drv_ctx->pb_streams++;
+	} else if (str_param->ops == STREAM_OPS_CAPTURE) {
+
+		sst_drv_ctx->scard_ops->power_up_pmic_cp(
+				sst_drv_ctx->pmic_port_instance);
+		/*Send a messageif not sent already*/
+		sst_drv_ctx->cp_streams++;
+	}
+
+err:
+	return retval;
+}
+
+void sst_process_mad_ops(struct work_struct *work)
+{
+
+	struct mad_ops_wq *mad_ops =
+			container_of(work, struct mad_ops_wq, wq);
+	int retval = 0;
+
+	switch (mad_ops->control_op) {
+	case SST_SND_PAUSE:
+		retval = sst_pause_stream(mad_ops->stream_id);
+		break;
+	case SST_SND_RESUME:
+		retval = sst_resume_stream(mad_ops->stream_id);
+		break;
+	case SST_SND_DROP:
+/*		retval = sst_drop_stream(mad_ops->stream_id);
+*/		break;
+	case SST_SND_START:
+			pr_debug("SST Debug: start stream\n");
+		retval = sst_start_stream(mad_ops->stream_id);
+		break;
+	case SST_SND_STREAM_PROCESS:
+		pr_debug("sst: play/capt frames...\n");
+		break;
+	default:
+		pr_err("sst:  wrong control_ops reported\n");
+	}
+	return;
+}
+/*
+ * sst_control_set - Set Control params
+ *
+ * @control_list: list of controls to be set
+ *
+ * This function is called by MID sound card driver to set
+ * SST/Sound card controls. This is registered with MID driver
+ */
+int sst_control_set(int control_element, void *value)
+{
+	int retval = 0, str_id = 0;
+	struct stream_info *stream;
+
+	if (sst_drv_ctx->sst_state == SST_SUSPENDED) {
+		/*LPE is suspended, resume it before proceding*/
+		pr_debug("sst: Resuming from Suspended state\n");
+		retval = intel_sst_resume(sst_drv_ctx->pci);
+		if (retval) {
+			pr_err("sst: Resume Failed = %#x, abort\n", retval);
+			return retval;
+		}
+	}
+	if (sst_drv_ctx->sst_state == SST_UN_INIT) {
+		/* FW is not downloaded */
+		pr_debug("sst: DSP Downloading FW now...\n");
+		retval = sst_download_fw();
+		if (retval) {
+			pr_err("sst: FW download fail %x, abort\n", retval);
+			return retval;
+		}
+		if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID &&
+			sst_drv_ctx->rx_time_slot_status != RX_TIMESLOT_UNINIT
+				&& sst_drv_ctx->pmic_vendor != SND_NC)
+			sst_enable_rx_timeslot(
+					sst_drv_ctx->rx_time_slot_status);
+	}
+
+	switch (control_element) {
+	case SST_SND_ALLOC: {
+		struct snd_sst_params *str_param;
+		struct stream_info *str_info;
+
+		str_param = (struct snd_sst_params *)value;
+		BUG_ON(!str_param);
+		retval = sst_get_stream(str_param);
+		if (retval >= 0)
+			sst_drv_ctx->stream_cnt++;
+		str_info = &sst_drv_ctx->streams[retval];
+		str_info->src = MAD_DRV;
+		break;
+	}
+
+	case SST_SND_PAUSE:
+	case SST_SND_RESUME:
+	case SST_SND_DROP:
+	case SST_SND_START:
+		sst_drv_ctx->mad_ops.control_op = control_element;
+		sst_drv_ctx->mad_ops.stream_id = *(int *)value;
+		queue_work(sst_drv_ctx->mad_wq, &sst_drv_ctx->mad_ops.wq);
+		break;
+
+	case SST_SND_FREE:
+		str_id = *(int *)value;
+		stream = &sst_drv_ctx->streams[str_id];
+		free_stream_context(str_id);
+		stream->pcm_substream = NULL;
+		stream->status = STREAM_UN_INIT;
+		stream->period_elapsed = NULL;
+		sst_drv_ctx->stream_cnt--;
+		break;
+
+	case SST_SND_STREAM_INIT: {
+		struct pcm_stream_info *str_info;
+		struct stream_info *stream;
+
+		pr_debug("sst: stream init called\n");
+		str_info = (struct pcm_stream_info *)value;
+		str_id = str_info->str_id;
+		retval = sst_validate_strid(str_id);
+		if (retval)
+			break;
+
+		stream = &sst_drv_ctx->streams[str_id];
+		pr_debug("sst: setting the period ptrs\n");
+		stream->pcm_substream = str_info->mad_substream;
+		stream->period_elapsed = str_info->period_elapsed;
+		stream->sfreq = str_info->sfreq;
+		stream->prev = stream->status;
+		stream->status = STREAM_INIT;
+		break;
+	}
+
+	case SST_SND_BUFFER_POINTER: {
+		struct pcm_stream_info *stream_info;
+		struct snd_sst_tstamp fw_tstamp = {0,};
+		struct stream_info *stream;
+
+
+		stream_info = (struct pcm_stream_info *)value;
+		str_id = stream_info->str_id;
+		retval = sst_validate_strid(str_id);
+		if (retval)
+			break;
+		stream = &sst_drv_ctx->streams[str_id];
+
+		if (!stream->pcm_substream)
+			break;
+		memcpy_fromio(&fw_tstamp,
+			((void *)(sst_drv_ctx->mailbox + SST_TIME_STAMP)
+			+(str_id * sizeof(fw_tstamp))),
+			sizeof(fw_tstamp));
+
+		pr_debug("sst: Pointer Query on strid = %d ops %d\n",
+						str_id, stream->ops);
+
+		if (stream->ops == STREAM_OPS_PLAYBACK)
+			stream_info->buffer_ptr = fw_tstamp.samples_rendered;
+		else
+			stream_info->buffer_ptr = fw_tstamp.samples_processed;
+		pr_debug("sst: Samples rendered = %llu, buffer ptr %llu\n",
+			fw_tstamp.samples_rendered, stream_info->buffer_ptr);
+		break;
+	}
+	case SST_ENABLE_RX_TIME_SLOT: {
+		int status = *(int *)value;
+		sst_drv_ctx->rx_time_slot_status = status ;
+		sst_enable_rx_timeslot(status);
+		break;
+	}
+	default:
+		/* Illegal case */
+		pr_warn("sst: illegal req\n");
+		return -EINVAL;
+	}
+
+	return retval;
+}
+
+
+struct intel_sst_card_ops sst_pmic_ops = {
+	.control_set = sst_control_set,
+};
+
+/*
+ * register_sst_card - function for sound card to register
+ *
+ * @card: pointer to structure of operations
+ *
+ * This function is called card driver loads and is ready for registration
+ */
+int register_sst_card(struct intel_sst_card_ops *card)
+{
+	if (!sst_drv_ctx) {
+		pr_err("sst: No SST driver register card reject\n");
+		return -ENODEV;
+	}
+
+	if (!card || !card->module_name) {
+		pr_err("sst: Null Pointer Passed\n");
+		return -EINVAL;
+	}
+	if (sst_drv_ctx->pmic_state == SND_MAD_UN_INIT) {
+		/* register this driver */
+		if ((strncmp(SST_CARD_NAMES, card->module_name,
+				strlen(SST_CARD_NAMES))) == 0) {
+			sst_drv_ctx->pmic_vendor = card->vendor_id;
+			sst_drv_ctx->scard_ops =  card->scard_ops;
+			sst_pmic_ops.module_name = card->module_name;
+			sst_drv_ctx->pmic_state = SND_MAD_INIT_DONE;
+			sst_drv_ctx->rx_time_slot_status = 0; /*default AMIC*/
+			card->control_set = sst_pmic_ops.control_set;
+			sst_drv_ctx->scard_ops->card_status = SND_CARD_UN_INIT;
+			return 0;
+		} else {
+			pr_err("sst: strcmp fail %s\n", card->module_name);
+			return -EINVAL;
+		}
+
+	} else {
+		/* already registered a driver */
+		pr_err("sst: Repeat for registeration..denied\n");
+		return -EBADRQC;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_sst_card);
+
+/*
+ * unregister_sst_card- function for sound card to un-register
+ *
+ * @card: pointer to structure of operations
+ *
+ * This function is called when card driver unloads
+ */
+void unregister_sst_card(struct intel_sst_card_ops *card)
+{
+	if (sst_pmic_ops.control_set == card->control_set) {
+		/* unreg */
+		sst_pmic_ops.module_name = "";
+		sst_drv_ctx->pmic_state = SND_MAD_UN_INIT;
+		pr_debug("sst: Unregistered %s\n", card->module_name);
+	}
+	return;
+}
+EXPORT_SYMBOL_GPL(unregister_sst_card);
diff --git a/drivers/staging/intel_sst/intel_sst_dsp.c b/drivers/staging/intel_sst/intel_sst_dsp.c
new file mode 100644
index 0000000..d80a6ee
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_dsp.c
@@ -0,0 +1,486 @@
+/*
+ *  intel_sst_dsp.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10	Intel Corp
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *
+ *  This file contains all dsp controlling functions like firmware download,
+ * setting/resetting dsp cores, etc
+ */
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+
+/**
+ * intel_sst_reset_dsp_mrst - Resetting SST DSP
+ *
+ * This resets DSP in case of MRST platfroms
+ */
+static int intel_sst_reset_dsp_mrst(void)
+{
+	union config_status_reg csr;
+
+	pr_debug("sst: Resetting the DSP in mrst\n");
+	csr.full = 0x3a2;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	csr.full = sst_shim_read(sst_drv_ctx->shim, SST_CSR);
+	csr.part.strb_cntr_rst = 0;
+	csr.part.run_stall = 0x1;
+	csr.part.bypass = 0x7;
+	csr.part.sst_reset = 0x1;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	return 0;
+}
+
+/**
+ * intel_sst_reset_dsp_medfield - Resetting SST DSP
+ *
+ * This resets DSP in case of Medfield platfroms
+ */
+static int intel_sst_reset_dsp_medfield(void)
+{
+	union config_status_reg csr;
+
+	pr_debug("sst: Resetting the DSP in medfield\n");
+	csr.full = 0x048303E2;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	return 0;
+}
+
+/**
+ * sst_start_mrst - Start the SST DSP processor
+ *
+ * This starts the DSP in MRST platfroms
+ */
+static int sst_start_mrst(void)
+{
+	union config_status_reg csr;
+
+	csr.full = sst_shim_read(sst_drv_ctx->shim, SST_CSR);
+	csr.part.bypass = 0;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	csr.part.run_stall = 0;
+	csr.part.sst_reset = 0;
+	csr.part.strb_cntr_rst = 1;
+	pr_debug("sst: Setting SST to execute_mrst 0x%x\n", csr.full);
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	return 0;
+}
+
+/**
+ * sst_start_medfield - Start the SST DSP processor
+ *
+ * This starts the DSP in MRST platfroms
+ */
+static int sst_start_medfield(void)
+{
+	union config_status_reg csr;
+
+	csr.full = 0x04830062;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	csr.full = 0x04830063;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	csr.full = 0x04830061;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+	pr_debug("sst: Starting the DSP_medfld\n");
+
+	return 0;
+}
+
+/**
+ * sst_parse_module - Parse audio FW modules
+ *
+ * @module: FW module header
+ *
+ * Parses modules that need to be placed in SST IRAM and DRAM
+ * returns error or 0 if module sizes are proper
+ */
+static int sst_parse_module(struct fw_module_header *module)
+{
+	struct dma_block_info *block;
+	u32 count;
+	void __iomem *ram;
+
+	pr_debug("sst: module sign %s size %x blocks %x type %x\n",
+			module->signature, module->mod_size,
+			module->blocks, module->type);
+	pr_debug("sst: module entrypoint 0x%x\n", module->entry_point);
+
+	block = (void *)module + sizeof(*module);
+
+	for (count = 0; count < module->blocks; count++) {
+		if (block->size <= 0) {
+			pr_err("sst: block size invalid\n");
+			return -EINVAL;
+		}
+		switch (block->type) {
+		case SST_IRAM:
+			ram = sst_drv_ctx->iram;
+			break;
+		case SST_DRAM:
+			ram = sst_drv_ctx->dram;
+			break;
+		default:
+			pr_err("sst: wrong ram type0x%x in block0x%x\n",
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
+ * sst_parse_fw_image - parse and load FW
+ *
+ * @sst_fw: pointer to audio fw
+ *
+ * This function is called to parse and download the FW image
+ */
+static int sst_parse_fw_image(const struct firmware *sst_fw)
+{
+	struct fw_header *header;
+	u32 count;
+	int ret_val;
+	struct fw_module_header *module;
+
+	BUG_ON(!sst_fw);
+
+	/* Read the header information from the data pointer */
+	header = (struct fw_header *)sst_fw->data;
+
+	/* verify FW */
+	if ((strncmp(header->signature, SST_FW_SIGN, 4) != 0) ||
+			(sst_fw->size != header->file_size + sizeof(*header))) {
+		/* Invalid FW signature */
+		pr_err("sst: InvalidFW sign/filesize mismatch\n");
+		return -EINVAL;
+	}
+	pr_debug("sst: header sign=%s size=%x modules=%x fmt=%x size=%x\n",
+			header->signature, header->file_size, header->modules,
+			header->file_format, sizeof(*header));
+	module = (void *)sst_fw->data + sizeof(*header);
+	for (count = 0; count < header->modules; count++) {
+		/* module */
+		ret_val = sst_parse_module(module);
+		if (ret_val)
+			return ret_val;
+		module = (void *)module + sizeof(*module) + module->mod_size ;
+	}
+
+	return 0;
+}
+
+/**
+ * sst_load_fw - function to load FW into DSP
+ *
+ * @fw: Pointer to driver loaded FW
+ * @context: driver context
+ *
+ * This function is called by OS when the FW is loaded into kernel
+ */
+int sst_load_fw(const struct firmware *fw, void *context)
+{
+	int ret_val;
+
+	pr_debug("sst: load_fw called\n");
+	BUG_ON(!fw);
+
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+		ret_val = intel_sst_reset_dsp_mrst();
+	else if (sst_drv_ctx->pci_id == SST_MFLD_PCI_ID)
+		ret_val = intel_sst_reset_dsp_medfield();
+	if (ret_val)
+		return ret_val;
+
+	ret_val = sst_parse_fw_image(fw);
+	if (ret_val)
+		return ret_val;
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_FW_LOADED;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	/*  7. ask scu to reset the bypass bits */
+	/*  8.bring sst out of reset  */
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+		ret_val = sst_start_mrst();
+	else if (sst_drv_ctx->pci_id == SST_MFLD_PCI_ID)
+		ret_val = sst_start_medfield();
+	if (ret_val)
+		return ret_val;
+
+	pr_debug("sst: fw loaded successful!!!\n");
+	return ret_val;
+}
+
+/*This function is called when any codec/post processing library
+ needs to be downloaded*/
+static int sst_download_library(const struct firmware *fw_lib,
+				struct snd_sst_lib_download_info *lib)
+{
+	/* send IPC message and wait */
+	int i;
+	u8 pvt_id;
+	struct ipc_post *msg = NULL;
+	union config_status_reg csr;
+	struct snd_sst_str_type str_type = {0};
+	int retval = 0;
+
+	if (sst_create_large_msg(&msg))
+		return -ENOMEM;
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	i = sst_get_block_stream(sst_drv_ctx);
+	pr_debug("sst: alloc block allocated = %d, pvt_id %d\n", i, pvt_id);
+	if (i < 0) {
+		kfree(msg);
+		return -ENOMEM;
+	}
+	sst_drv_ctx->alloc_block[i].sst_id = pvt_id;
+	sst_fill_header(&msg->header, IPC_IA_PREP_LIB_DNLD, 1, pvt_id);
+	msg->header.part.data = sizeof(u32) + sizeof(str_type);
+	str_type.codec_type = lib->dload_lib.lib_info.lib_type;
+	/*str_type.pvt_id = pvt_id;*/
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &str_type, sizeof(str_type));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_timeout(sst_drv_ctx, &sst_drv_ctx->alloc_block[i]);
+	if (retval) {
+		/* error */
+		sst_drv_ctx->alloc_block[i].sst_id = BLOCK_UNINIT;
+		pr_err("sst: Prep codec downloaded failed %d\n",
+				retval);
+		return -EIO;
+	}
+	pr_debug("sst: FW responded, ready for download now...\n");
+	/* downloading on success */
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_FW_LOADED;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	csr.full = readl(sst_drv_ctx->shim + SST_CSR);
+	csr.part.run_stall = 1;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	csr.full = sst_shim_read(sst_drv_ctx->shim, SST_CSR);
+	csr.part.bypass = 0x7;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	sst_parse_fw_image(fw_lib);
+
+	/* set the FW to running again */
+	csr.full = sst_shim_read(sst_drv_ctx->shim, SST_CSR);
+	csr.part.bypass = 0x0;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	csr.full = sst_shim_read(sst_drv_ctx->shim, SST_CSR);
+	csr.part.run_stall = 0;
+	sst_shim_write(sst_drv_ctx->shim, SST_CSR, csr.full);
+
+	/* send download complete and wait */
+	if (sst_create_large_msg(&msg)) {
+		sst_drv_ctx->alloc_block[i].sst_id = BLOCK_UNINIT;
+		return -ENOMEM;
+	}
+
+	sst_fill_header(&msg->header, IPC_IA_LIB_DNLD_CMPLT, 1, pvt_id);
+	sst_drv_ctx->alloc_block[i].sst_id = pvt_id;
+	msg->header.part.data = sizeof(u32) + sizeof(*lib);
+	lib->pvt_id = pvt_id;
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), lib, sizeof(*lib));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	pr_debug("sst: Waiting for FW response Download complete\n");
+	sst_drv_ctx->alloc_block[i].ops_block.condition = false;
+	retval = sst_wait_timeout(sst_drv_ctx, &sst_drv_ctx->alloc_block[i]);
+	if (retval) {
+		/* error */
+		mutex_lock(&sst_drv_ctx->sst_lock);
+		sst_drv_ctx->sst_state = SST_UN_INIT;
+		mutex_unlock(&sst_drv_ctx->sst_lock);
+		sst_drv_ctx->alloc_block[i].sst_id = BLOCK_UNINIT;
+		return -EIO;
+	}
+
+	pr_debug("sst: FW sucess on Download complete\n");
+	sst_drv_ctx->alloc_block[i].sst_id = BLOCK_UNINIT;
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_FW_RUNNING;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	return 0;
+
+}
+
+/* This function is called befoer downloading the codec/postprocessing
+library is set for download to SST DSP*/
+static int sst_validate_library(const struct firmware *fw_lib,
+		struct lib_slot_info *slot,
+		u32 *entry_point)
+{
+	struct fw_header *header;
+	struct fw_module_header *module;
+	struct dma_block_info *block;
+	unsigned int n_blk, isize = 0, dsize = 0;
+	int err = 0;
+
+	header = (struct fw_header *)fw_lib->data;
+	if (header->modules != 1) {
+		pr_err("sst: Module no mismatch found\n ");
+		err = -EINVAL;
+		goto exit;
+	}
+	module = (void *)fw_lib->data + sizeof(*header);
+	*entry_point = module->entry_point;
+	pr_debug("sst: Module entry point 0x%x\n", *entry_point);
+	pr_debug("sst: Module Sign %s, Size 0x%x, Blocks 0x%x Type 0x%x\n",
+			module->signature, module->mod_size,
+			module->blocks, module->type);
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
+			pr_err("sst: Invalid block type for 0x%x\n", n_blk);
+			err = -EINVAL;
+			goto exit;
+		}
+		block = (void *)block + sizeof(*block) + block->size;
+	}
+	if (isize > slot->iram_size || dsize > slot->dram_size) {
+		pr_err("sst: library exceeds size allocated\n");
+		err = -EINVAL;
+		goto exit;
+	} else
+		pr_debug("sst: Library is safe for download...\n");
+
+	pr_debug("sst: iram 0x%x, dram 0x%x, iram 0x%x, dram 0x%x\n",
+			isize, dsize, slot->iram_size, slot->dram_size);
+exit:
+	return err;
+
+}
+
+/* This function is called when FW requests for a particular libary download
+This function prepares the library to download*/
+int sst_load_library(struct snd_sst_lib_download *lib, u8 ops)
+{
+	char buf[20];
+	const char *type, *dir;
+	int len = 0, error = 0;
+	u32 entry_point;
+	const struct firmware *fw_lib;
+	struct snd_sst_lib_download_info dload_info = {{{0},},};
+
+	memset(buf, 0, sizeof(buf));
+
+	pr_debug("sst: Lib Type 0x%x, Slot 0x%x, ops 0x%x\n",
+			lib->lib_info.lib_type, lib->slot_info.slot_num, ops);
+	pr_debug("sst: Version 0x%x, name %s, caps 0x%x media type 0x%x\n",
+		lib->lib_info.lib_version, lib->lib_info.lib_name,
+		lib->lib_info.lib_caps, lib->lib_info.media_type);
+
+	pr_debug("sst: IRAM Size 0x%x, offset 0x%x\n",
+		lib->slot_info.iram_size, lib->slot_info.iram_offset);
+	pr_debug("sst: DRAM Size 0x%x, offset 0x%x\n",
+		lib->slot_info.dram_size, lib->slot_info.dram_offset);
+
+	switch (lib->lib_info.lib_type) {
+	case SST_CODEC_TYPE_MP3:
+		type = "mp3_";
+		break;
+	case SST_CODEC_TYPE_AAC:
+		type = "aac_";
+		break;
+	case SST_CODEC_TYPE_AACP:
+		type = "aac_v1_";
+		break;
+	case SST_CODEC_TYPE_eAACP:
+		type = "aac_v2_";
+		break;
+	case SST_CODEC_TYPE_WMA9:
+		type = "wma9_";
+		break;
+	default:
+		pr_err("sst: Invalid codec type\n");
+		error = -EINVAL;
+		goto wake;
+	}
+
+	if (ops == STREAM_OPS_CAPTURE)
+		dir = "enc_";
+	else
+		dir = "dec_";
+	len = strlen(type) + strlen(dir);
+	strncpy(buf, type, sizeof(buf)-1);
+	strncpy(buf + strlen(type), dir, sizeof(buf)-strlen(type)-1);
+	len += snprintf(buf + len, sizeof(buf) - len, "%d",
+			lib->slot_info.slot_num);
+	len += snprintf(buf + len, sizeof(buf) - len, ".bin");
+
+	pr_debug("sst: Requesting %s\n", buf);
+
+	error = request_firmware(&fw_lib, buf, &sst_drv_ctx->pci->dev);
+	if (error) {
+		pr_err("sst: library load failed %d\n", error);
+		goto wake;
+	}
+	error = sst_validate_library(fw_lib, &lib->slot_info, &entry_point);
+	if (error)
+		goto wake_free;
+
+	lib->mod_entry_pt = entry_point;
+	memcpy(&dload_info.dload_lib, lib, sizeof(*lib));
+	error = sst_download_library(fw_lib, &dload_info);
+	if (error)
+		goto wake_free;
+
+	/* lib is downloaded and init send alloc again */
+	pr_debug("sst: Library is downloaded now...\n");
+wake_free:
+	/* sst_wake_up_alloc_block(sst_drv_ctx, pvt_id, error, NULL); */
+	release_firmware(fw_lib);
+wake:
+	return error;
+}
+
diff --git a/drivers/staging/intel_sst/intel_sst_fw_ipc.h b/drivers/staging/intel_sst/intel_sst_fw_ipc.h
new file mode 100644
index 0000000..1a2f67f
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_fw_ipc.h
@@ -0,0 +1,393 @@
+#ifndef __INTEL_SST_FW_IPC_H__
+#define __INTEL_SST_FW_IPC_H__
+/*
+*  intel_sst_fw_ipc.h - Intel SST Driver for audio engine
+*
+*  Copyright (C) 2008-10 Intel Corporation
+*  Author:	Vinod Koul <vinod.koul@intel.com>
+*		Harsha Priya <priya.harsha@intel.com>
+*		Dharageswari R <dharageswari.r@intel.com>
+*		KP Jeeja <jeeja.kp@intel.com>
+*  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; version 2 of the License.
+*
+*  This program is distributed in the hope that it will be useful, but
+*  WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+*  General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License along
+*  with this program; if not, write to the Free Software Foundation, Inc.,
+*  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+*
+* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+*
+*  This driver exposes the audio engine functionalities to the ALSA
+*	and middleware.
+*  This file has definitions shared between the firmware and driver
+*/
+
+#define MAX_NUM_STREAMS_MRST 3
+#define MAX_NUM_STREAMS_MFLD 6
+#define MAX_NUM_STREAMS 6
+#define MAX_DBG_RW_BYTES 80
+#define MAX_NUM_SCATTER_BUFFERS 8
+#define MAX_LOOP_BACK_DWORDS 8
+/* IPC base address and mailbox, timestamp offsets */
+#define SST_MAILBOX_SIZE 0x0400
+#define SST_MAILBOX_SEND 0x0000
+#define SST_MAILBOX_RCV 0x0804
+#define SST_TIME_STAMP 0x1800
+#define SST_RESERVED_OFFSET 0x1A00
+#define SST_CHEKPOINT_OFFSET 0x1C00
+#define REPLY_MSG 0x80
+
+/* Message ID's for IPC messages */
+/* Bits B7: SST or IA/SC ; B6-B4: Msg Category; B3-B0: Msg Type */
+
+/* I2L Firmware/Codec Download msgs */
+#define IPC_IA_PREP_LIB_DNLD 0x01
+#define IPC_IA_LIB_DNLD_CMPLT 0x02
+
+#define IPC_IA_SET_PMIC_TYPE 0x03
+#define IPC_IA_GET_FW_VERSION 0x04
+#define IPC_IA_GET_FW_BUILD_INF 0x05
+#define IPC_IA_GET_FW_INFO 0x06
+
+/* I2L Codec Config/control msgs */
+#define IPC_IA_SET_CODEC_PARAMS 0x10
+#define IPC_IA_GET_CODEC_PARAMS 0x11
+#define IPC_IA_SET_PPP_PARAMS 0x12
+#define IPC_IA_GET_PPP_PARAMS 0x13
+#define IPC_IA_PLAY_FRAMES 0x14
+#define IPC_IA_CAPT_FRAMES 0x15
+#define IPC_IA_PLAY_VOICE 0x16
+#define IPC_IA_CAPT_VOICE 0x17
+#define IPC_IA_DECODE_FRAMES 0x18
+
+/* I2L Stream config/control msgs */
+#define IPC_IA_ALLOC_STREAM 0x20 /* Allocate a stream ID */
+#define IPC_IA_FREE_STREAM 0x21 /* Free the stream ID */
+#define IPC_IA_SET_STREAM_PARAMS 0x22
+#define IPC_IA_GET_STREAM_PARAMS 0x23
+#define IPC_IA_PAUSE_STREAM 0x24
+#define IPC_IA_RESUME_STREAM 0x25
+#define IPC_IA_DROP_STREAM 0x26
+#define IPC_IA_DRAIN_STREAM 0x27 /* Short msg with str_id */
+#define IPC_IA_TARGET_DEV_SELECT 0x28
+#define IPC_IA_CONTROL_ROUTING 0x29
+
+#define IPC_IA_SET_STREAM_VOL 0x2A /*Vol for stream, pre mixer */
+#define IPC_IA_GET_STREAM_VOL 0x2B
+#define IPC_IA_SET_STREAM_MUTE 0x2C
+#define IPC_IA_GET_STREAM_MUTE 0x2D
+#define IPC_IA_ENABLE_RX_TIME_SLOT 0x2E /* Enable Rx time slot 0 or 1 */
+
+#define IPC_IA_START_STREAM 0x30 /* Short msg with str_id */
+
+/* Debug msgs */
+#define IPC_IA_DBG_MEM_READ 0x40
+#define IPC_IA_DBG_MEM_WRITE 0x41
+#define IPC_IA_DBG_LOOP_BACK 0x42
+
+/* L2I Firmware/Codec Download msgs */
+#define IPC_IA_FW_INIT_CMPLT 0x81
+#define IPC_IA_LPE_GETTING_STALLED 0x82
+#define IPC_IA_LPE_UNSTALLED 0x83
+
+/* L2I Codec Config/control msgs */
+#define IPC_SST_GET_PLAY_FRAMES 0x90 /* Request IA more data */
+#define IPC_SST_GET_CAPT_FRAMES 0x91 /* Request IA more data */
+#define IPC_SST_BUF_UNDER_RUN 0x92 /* PB Under run and stopped */
+#define IPC_SST_BUF_OVER_RUN 0x93 /* CAP Under run and stopped */
+#define IPC_SST_DRAIN_END 0x94 /* PB Drain complete and stopped */
+#define IPC_SST_CHNGE_SSP_PARAMS 0x95 /* PB SSP parameters changed */
+#define IPC_SST_STREAM_PROCESS_FATAL_ERR 0x96/* error in processing a stream */
+#define IPC_SST_PERIOD_ELAPSED 0x97 /* period elapsed */
+#define IPC_IA_TARGET_DEV_CHNGD 0x98 /* error in processing a stream */
+
+#define IPC_SST_ERROR_EVENT 0x99 /* Buffer over run occured */
+/* L2S messages */
+#define IPC_SC_DDR_LINK_UP 0xC0
+#define IPC_SC_DDR_LINK_DOWN 0xC1
+#define IPC_SC_SET_LPECLK_REQ 0xC2
+#define IPC_SC_SSP_BIT_BANG 0xC3
+
+/* L2I Error reporting msgs */
+#define IPC_IA_MEM_ALLOC_FAIL 0xE0
+#define IPC_IA_PROC_ERR 0xE1 /* error in processing a
+					stream can be used by playback and
+					capture modules */
+
+/* L2I Debug msgs */
+#define IPC_IA_PRINT_STRING 0xF0
+
+
+
+/* Command Response or Acknowledge message to any IPC message will have
+ * same message ID and stream ID information which is sent.
+ * There is no specific Ack message ID. The data field is used as response
+ * meaning.
+ */
+enum ackData {
+	IPC_ACK_SUCCESS = 0,
+	IPC_ACK_FAILURE
+};
+
+
+enum sst_error_codes {
+	/* Error code,response to msgId: Description */
+	/* Common error codes */
+	SST_SUCCESS = 0,	/* Success */
+	SST_ERR_INVALID_STREAM_ID, /* Invalid stream ID */
+	SST_ERR_INVALID_MSG_ID,	/* Invalid message ID */
+	SST_ERR_INVALID_STREAM_OP, /* Invalid stream operation request */
+	SST_ERR_INVALID_PARAMS,	/* Invalid params */
+	SST_ERR_INVALID_CODEC,	/* Invalid codec type */
+	SST_ERR_INVALID_MEDIA_TYPE, /* Invalid media type */
+	SST_ERR_STREAM_ERR,  /* ANY: Stream control or config or
+					processing error */
+
+	/* IPC specific error codes */
+	SST_IPC_ERR_CALL_BACK_NOT_REGD, /* Call back for msg not regd */
+	SST_IPC_ERR_STREAM_NOT_ALLOCATED, /* Stream is not allocated  */
+	SST_IPC_ERR_STREAM_ALLOC_FAILED, /* ALLOC:Stream alloc failed */
+	SST_IPC_ERR_GET_STREAM_FAILED, /* ALLOC:Get stream id failed*/
+	SST_ERR_MOD_NOT_AVAIL, /* SET/GET: Mod(AEC/AGC/ALC) not available */
+	SST_ERR_MOD_DNLD_RQD, /* SET/GET: Mod(AEC/AGC/ALC) download required */
+	SST_ERR_STREAM_STOPPED,		/* ANY: Stream is in stopped state */
+	SST_ERR_STREAM_IN_USE, /* ANY: Stream is already in use */
+
+	/* Capture specific error codes */
+	SST_CAP_ERR_INCMPLTE_CAPTURE_MSG,/* ANY:Incomplete message */
+	SST_CAP_ERR_CAPTURE_FAIL, /* ANY:Capture op failed */
+	SST_CAP_ERR_GET_DDR_NEW_SGLIST,
+	SST_CAP_ERR_UNDER_RUN,	/* lack of input data */
+	SST_CAP_ERR_OVERFLOW,	/* lack of output space */
+
+	/* Playback specific error codes*/
+	SST_PB_ERR_INCMPLTE_PLAY_MSG, /* ANY: Incomplete message */
+	SST_PB_ERR_PLAY_FAIL, /* ANY: Playback operation failed */
+	SST_PB_ERR_GET_DDR_NEW_SGLIST,
+
+	/* Codec manager specific error codes */
+	SST_LIB_ERR_LIB_DNLD_REQUIRED, /* ALLOC: Codec download required */
+	SST_LIB_ERR_LIB_NOT_SUPPORTED, /* Library is not supported */
+
+	/* Library manager specific error codes */
+	SST_SCC_ERR_PREP_DNLD_FAILED, /* Failed to prepare for codec download */
+	SST_SCC_ERR_LIB_DNLD_RES_FAILED, /* Lib download resume failed */
+	/* Scheduler specific error codes */
+	SST_SCH_ERR_FAIL, /* REPORT: */
+
+	/* DMA specific error codes */
+	SST_DMA_ERR_NO_CHNL_AVAILABLE, /* DMA Ch not available */
+	SST_DMA_ERR_INVALID_INPUT_PARAMS, /* Invalid input params */
+	SST_DMA_ERR_CHNL_ALREADY_SUSPENDED, /* Ch is suspended */
+	SST_DMA_ERR_CHNL_ALREADY_STARTED, /* Ch already started */
+	SST_DMA_ERR_CHNL_NOT_ENABLED, /* Ch not enabled */
+	SST_DMA_ERR_TRANSFER_FAILED, /* Transfer failed */
+	SST_SSP_ERR_ALREADY_ENABLED, /* REPORT: SSP already enabled */
+	SST_SSP_ERR_ALREADY_DISABLED, /* REPORT: SSP already disabled */
+	SST_SSP_ERR_NOT_INITIALIZED,
+
+	/* Other error codes */
+	SST_ERR_MOD_INIT_FAIL,	/* Firmware Module init failed */
+
+	/* FW init error codes */
+	SST_RDR_ERR_IO_DEV_SEL_NOT_ALLOWED,
+	SST_RDR_ERR_ROUTE_ALREADY_STARTED,
+	SST_RDR_PREP_CODEC_DNLD_FAILED,
+
+	/* Memory debug error codes */
+	SST_ERR_DBG_MEM_READ_FAIL,
+	SST_ERR_DBG_MEM_WRITE_FAIL,
+
+	/* Decode error codes */
+	SST_ERR_DEC_NEED_INPUT_BUF,
+
+};
+
+enum dbg_mem_data_type {
+	/* Data type of debug read/write */
+	DATA_TYPE_U32,
+	DATA_TYPE_U16,
+	DATA_TYPE_U8,
+};
+
+/* CAUTION NOTE: All IPC message body must be multiple of 32 bits.*/
+
+/* IPC Header */
+union ipc_header {
+	struct {
+		u32  msg_id:8; /* Message ID - Max 256 Message Types */
+		u32  str_id:5;
+		u32  large:1;	/* Large Message if large = 1 */
+		u32  reserved:2;	/* Reserved for future use */
+		u32  data:14;	/* Ack/Info for msg, size of msg in Mailbox */
+		u32  done:1; /* bit 30 */
+		u32  busy:1; /* bit 31 */
+	} part;
+	u32 full;
+} __attribute__ ((packed));
+
+/* Firmware build info */
+struct sst_fw_build_info {
+	unsigned char  date[16]; /* Firmware build date */
+	unsigned char  time[16]; /* Firmware build time */
+} __attribute__ ((packed));
+
+struct ipc_header_fw_init {
+	struct snd_sst_fw_version fw_version;/* Firmware version details */
+	struct sst_fw_build_info build_info;
+	u16 result;	/* Fw init result */
+	u8 module_id; /* Module ID in case of error */
+	u8 debug_info; /* Debug info from Module ID in case of fail */
+} __attribute__ ((packed));
+
+/* Address and size info of a frame buffer in DDR */
+struct sst_address_info {
+	u32 addr; /* Address at IA */
+	u32 size; /* Size of the buffer */
+} __attribute__ ((packed));
+
+/* Time stamp */
+struct snd_sst_tstamp {
+	u64 samples_processed;/* capture - data in DDR */
+	u64 samples_rendered;/* playback - data rendered */
+	u64 bytes_processed;/* bytes decoded or encoded */
+	u32 sampling_frequency;/* eg: 48000, 44100 */
+	u32 dma_base_address;/* DMA base address */
+	u16	dma_channel_no;/* DMA Channel used for the data transfer*/
+	u16	reserved;/* 32 bit alignment */
+};
+
+/* Frame info to play or capture */
+struct sst_frame_info {
+	u16  num_entries; /* number of entries to follow */
+	u16  rsrvd;
+	struct sst_address_info  addr[MAX_NUM_SCATTER_BUFFERS];
+} __attribute__ ((packed));
+
+/* Frames info for decode */
+struct snd_sst_decode_info {
+	unsigned long long input_bytes_consumed;
+	unsigned long long output_bytes_produced;
+	struct sst_frame_info frames_in;
+	struct sst_frame_info frames_out;
+} __attribute__ ((packed));
+
+/* SST to IA print debug message*/
+struct ipc_sst_ia_print_params {
+	u32 string_size;/* Max value is 160 */
+	u8 prt_string[160];/* Null terminated Char string */
+} __attribute__ ((packed));
+
+/* Voice data message  */
+struct snd_sst_voice_data {
+	u16 num_bytes;/* Number of valid voice data bytes */
+	u8  pcm_wd_size;/* 0=8 bit, 1=16 bit 2=32 bit */
+	u8  reserved;/* Reserved */
+	u8  voice_data_buf[0];/* Voice data buffer in bytes, little endian */
+} __attribute__ ((packed));
+
+/* SST to IA memory read debug message  */
+struct ipc_sst_ia_dbg_mem_rw  {
+	u16  num_bytes;/* Maximum of MAX_DBG_RW_BYTES */
+	u16  data_type;/* enum: dbg_mem_data_type */
+	u32  address;	/* Memory address of data memory of data_type */
+	u8	rw_bytes[MAX_DBG_RW_BYTES];/* Maximum of 64 bytes can be RW */
+} __attribute__ ((packed));
+
+struct ipc_sst_ia_dbg_loop_back {
+	u16 num_dwords; /* Maximum of MAX_DBG_RW_BYTES */
+	u16 increment_val;/* Increments dwords by this value, 0- no increment */
+	u32 lpbk_dwords[MAX_LOOP_BACK_DWORDS];/* Maximum of 8 dwords loopback */
+} __attribute__ ((packed));
+
+/* Stream type params struture for Alloc stream */
+struct snd_sst_str_type {
+	u8 codec_type;		/* Codec type */
+	u8 str_type;		/* 1 = voice 2 = music */
+	u8 operation;		/* Playback or Capture */
+	u8 protected_str;	/* 0=Non DRM, 1=DRM */
+	u8 time_slots;
+	u8 reserved;		/* Reserved */
+	u16 result;		/* Result used for acknowledgment */
+} __attribute__ ((packed));
+
+/* Library info structure */
+struct module_info {
+	u32 lib_version;
+	u32 lib_type;/*TBD- KLOCKWORK u8 lib_type;*/
+	u32 media_type;
+	u8  lib_name[12];
+	u32 lib_caps;
+	unsigned char  b_date[16]; /* Lib build date */
+	unsigned char  b_time[16]; /* Lib build time */
+} __attribute__ ((packed));
+
+/* Library slot info */
+struct lib_slot_info {
+	u8  slot_num; /* 1 or 2 */
+	u8  reserved1;
+	u16 reserved2;
+	u32 iram_size; /* slot size in IRAM */
+	u32 dram_size; /* slot size in DRAM */
+	u32 iram_offset; /* starting offset of slot in IRAM */
+	u32 dram_offset; /* starting offset of slot in DRAM */
+} __attribute__ ((packed));
+
+struct snd_sst_lib_download {
+	struct module_info lib_info; /* library info type, capabilities etc */
+	struct lib_slot_info slot_info; /* slot info to be downloaded */
+	u32 mod_entry_pt;
+};
+
+struct snd_sst_lib_download_info {
+	struct snd_sst_lib_download dload_lib;
+	u16 result;	/* Result used for acknowledgment */
+	u8 pvt_id; /* Private ID */
+	u8 reserved;  /* for alignment */
+};
+
+/* Alloc stream params structure */
+struct snd_sst_alloc_params {
+	struct snd_sst_str_type str_type;
+	struct snd_sst_stream_params stream_params;
+};
+
+struct snd_sst_fw_get_stream_params {
+	struct snd_sst_stream_params codec_params;
+	struct snd_sst_pmic_config pcm_params;
+};
+
+/* Alloc stream response message */
+struct snd_sst_alloc_response {
+	struct snd_sst_str_type str_type; /* Stream type for allocation */
+	struct snd_sst_lib_download lib_dnld; /* Valid only for codec dnld */
+};
+
+/* Drop response */
+struct snd_sst_drop_response {
+	u32 result;
+	u32 bytes;
+};
+
+/* CSV Voice call routing structure */
+struct snd_sst_control_routing {
+	u8 control; /* 0=start, 1=Stop */
+	u8 reserved[3];	/* Reserved- for 32 bit alignment */
+};
+
+
+struct ipc_post {
+	struct list_head node;
+	union ipc_header header; /* driver specific */
+	char *mailbox_data;
+};
+
+#endif /* __INTEL_SST_FW_IPC_H__ */
diff --git a/drivers/staging/intel_sst/intel_sst_ioctl.h b/drivers/staging/intel_sst/intel_sst_ioctl.h
new file mode 100644
index 0000000..03b9316
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_ioctl.h
@@ -0,0 +1,435 @@
+#ifndef __INTEL_SST_IOCTL_H__
+#define __INTEL_SST_IOCTL_H__
+/*
+ *  intel_sst_ioctl.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file defines all sst ioctls
+ */
+
+/* codec and post/pre processing related info */
+
+#include <linux/types.h>
+
+enum sst_codec_types {
+/*  AUDIO/MUSIC	CODEC Type Definitions */
+	SST_CODEC_TYPE_UNKNOWN = 0,
+	SST_CODEC_TYPE_PCM,	/* Pass through Audio codec */
+	SST_CODEC_TYPE_MP3,
+	SST_CODEC_TYPE_MP24,
+	SST_CODEC_TYPE_AAC,
+	SST_CODEC_TYPE_AACP,
+	SST_CODEC_TYPE_eAACP,
+	SST_CODEC_TYPE_WMA9,
+	SST_CODEC_TYPE_WMA10,
+	SST_CODEC_TYPE_WMA10P,
+	SST_CODEC_TYPE_RA,
+	SST_CODEC_TYPE_DDAC3,
+	SST_CODEC_TYPE_STEREO_TRUE_HD,
+	SST_CODEC_TYPE_STEREO_HD_PLUS,
+
+	/*  VOICE CODEC Type Definitions */
+	SST_CODEC_TYPE_VOICE_PCM = 0x21, /* Pass through voice codec */
+};
+
+enum sst_algo_types {
+	SST_CODEC_SRC = 0x64,
+	SST_CODEC_MIXER = 0x65,
+	SST_CODEC_DOWN_MIXER = 0x66,
+	SST_CODEC_VOLUME_CONTROL = 0x67,
+	SST_CODEC_OEM1 = 0xC8,
+	SST_CODEC_OEM2 = 0xC9,
+};
+
+enum snd_sst_stream_ops {
+	STREAM_OPS_PLAYBACK = 0,	/* Decode */
+	STREAM_OPS_CAPTURE,		/* Encode */
+	STREAM_OPS_PLAYBACK_DRM,	/* Play Audio/Voice */
+	STREAM_OPS_PLAYBACK_ALERT,	/* Play Audio/Voice */
+	STREAM_OPS_CAPTURE_VOICE_CALL,	/* CSV Voice recording */
+};
+
+enum stream_mode {
+	SST_STREAM_MODE_NONE = 0,
+	SST_STREAM_MODE_DNR = 1,
+	SST_STREAM_MODE_FNF = 2,
+	SST_STREAM_MODE_CAPTURE = 3
+};
+
+enum stream_type {
+	SST_STREAM_TYPE_NONE = 0,
+	SST_STREAM_TYPE_MUSIC = 1,
+	SST_STREAM_TYPE_NORMAL = 2,
+	SST_STREAM_TYPE_LONG_PB = 3,
+	SST_STREAM_TYPE_LOW_LATENCY = 4,
+};
+
+enum snd_sst_audio_device_type {
+	SND_SST_DEVICE_HEADSET = 1,
+	SND_SST_DEVICE_IHF,
+	SND_SST_DEVICE_VIBRA,
+	SND_SST_DEVICE_HAPTIC,
+	SND_SST_DEVICE_CAPTURE,
+};
+
+/* Firmware Version info */
+struct snd_sst_fw_version {
+	__u8 build;	/* build number*/
+	__u8 minor;	/* minor number*/
+	__u8 major;	/* major number*/
+	__u8 type; /* build type */
+};
+
+/* Port info structure */
+struct snd_sst_port_info {
+	__u16 port_type;
+	__u16 reserved;
+};
+
+/* Mixer info structure */
+struct snd_sst_mix_info {
+	__u16 max_streams;
+	__u16 reserved;
+};
+
+/* PCM Parameters */
+struct snd_pcm_params {
+	__u16 codec;	/* codec type */
+	__u8 num_chan;	/* 1=Mono, 2=Stereo */
+	__u8 pcm_wd_sz;	/* 16/24 - bit*/
+	__u32 reserved;	/* Bitrate in bits per second */
+	__u32 sfreq;	/* Sampling rate in Hz */
+	__u32 ring_buffer_size;
+	__u32 period_count;	/* period elapsed in samples*/
+	__u32 ring_buffer_addr;
+};
+
+/* MP3 Music Parameters Message */
+struct snd_mp3_params {
+	__u16 codec;
+	__u8  num_chan;	/* 1=Mono, 2=Stereo	*/
+	__u8  pcm_wd_sz; /* 16/24 - bit*/
+	__u32 brate; /* Use the hard coded value. */
+	__u32 sfreq; /* Sampling freq eg. 8000, 441000, 48000 */
+	__u8  crc_check; /* crc_check - disable (0) or enable (1) */
+	__u8  op_align; /* op align 0- 16 bit, 1- MSB, 2 LSB*/
+	__u16 reserved;	/* Unused */
+};
+
+#define AAC_BIT_STREAM_ADTS		0
+#define AAC_BIT_STREAM_ADIF		1
+#define AAC_BIT_STREAM_RAW		2
+
+/* AAC Music Parameters Message */
+struct snd_aac_params {
+	__u16 codec;
+	__u8 num_chan; /* 1=Mono, 2=Stereo*/
+	__u8 pcm_wd_sz; /* 16/24 - bit*/
+	__u32 brate;
+	__u32 sfreq; /* Sampling freq eg. 8000, 441000, 48000 */
+	__u32 aac_srate;	/* Plain AAC decoder operating sample rate */
+	__u8 mpg_id; /* 0=MPEG-2, 1=MPEG-4 */
+	__u8 bs_format; /* input bit stream format adts=0, adif=1, raw=2 */
+	__u8 aac_profile; /* 0=Main Profile, 1=LC profile, 3=SSR profile */
+	__u8 ext_chl; /* No.of external channels */
+	__u8 aot; /* Audio object type. 1=Main , 2=LC , 3=SSR, 4=SBR*/
+	__u8 op_align; /* output alignment 0=16 bit , 1=MSB, 2= LSB align */
+	__u8 brate_type; /* 0=CBR, 1=VBR */
+	__u8 crc_check; /* crc check 0= disable, 1=enable */
+	__s8 bit_stream_format[8]; /* input bit stream format adts/adif/raw */
+	__u8 jstereo; /* Joint stereo Flag */
+	__u8 sbr_present; /* 1 = SBR Present, 0 = SBR absent, for RAW */
+	__u8 downsample;       /* 1 = Downsampling ON, 0 = Downsampling OFF */
+	__u8 num_syntc_elems; /* 1- Mono/stereo, 0 - Dual Mono, 0 - for raw */
+	__s8 syntc_id[2]; /* 0 for ID_SCE(Dula Mono), -1 for raw */
+	__s8 syntc_tag[2]; /* raw - -1 and 0 -16 for rest of the streams */
+	__u8 pce_present; /* Flag. 1- present 0 - not present, for RAW */
+	__u8 sbr_type;		/* sbr_type: 0-plain aac, 1-aac-v1, 2-aac-v2 */
+	__u8 outchmode;  /*0- mono, 1-stereo, 2-dual mono 3-Parametric stereo */
+	__u8 ps_present;
+};
+
+/* WMA Music Parameters Message */
+struct snd_wma_params {
+	__u16 codec;
+	__u8  num_chan;	/* 1=Mono, 2=Stereo */
+	__u8  pcm_wd_sz;	/* 16/24 - bit*/
+	__u32 brate;	/* Use the hard coded value. */
+	__u32 sfreq;	/* Sampling freq eg. 8000, 441000, 48000 */
+	__u32 channel_mask;  /* Channel Mask */
+	__u16 format_tag;	/* Format Tag */
+	__u16 block_align;	/* packet size */
+	__u16 wma_encode_opt;/* Encoder option */
+	__u8 op_align;	/* op align 0- 16 bit, 1- MSB, 2 LSB */
+	__u8 pcm_src;	/* input pcm bit width */
+};
+
+/* Pre processing param structure */
+struct snd_prp_params {
+	__u32 reserved;	/* No pre-processing defined yet */
+};
+
+struct snd_params_block {
+	__u32 type;		/*Type of the parameter*/
+	__u32 size;		/*size of the parameters in the block*/
+	__u8 params[0];	/*Parameters of the algorithm*/
+};
+
+/* Pre and post processing params structure */
+struct snd_ppp_params {
+	enum sst_algo_types	algo_id;/* Post/Pre processing algorithm ID  */
+	__u8			str_id;	/*Only 5 bits used 0 - 31 are valid*/
+	__u8			enable;	/* 0= disable, 1= enable*/
+	__u8			reserved;
+	__u32			size;	/*Size of parameters for all blocks*/
+	struct snd_params_block	params[0];
+};
+
+struct snd_sst_postproc_info {
+	__u32 src_min;		/* Supported SRC Min sampling freq */
+	__u32 src_max;		/* Supported SRC Max sampling freq */
+	__u8  src;		/* 0=Not supported, 1=Supported */
+	__u8  bass_boost;		/* 0=Not Supported, 1=Supported */
+	__u8  stereo_widening;	/* 0=Not Supported, 1=Supported */
+	__u8  volume_control;	/* 0=Not Supported, 1=Supported */
+	__s16 min_vol;		/* Minimum value of Volume in dB */
+	__s16 max_vol;		/* Maximum value of Volume in dB */
+	__u8 mute_control;	/* 0=No Mute, 1=Mute */
+	__u8 reserved1;
+	__u16 reserved2;
+};
+
+/* pre processing Capability info structure */
+struct snd_sst_prp_info {
+	__s16 min_vol;			/* Minimum value of Volume in dB */
+	__s16 max_vol;			/* Maximum value of Volume in dB */
+	__u8 volume_control;		/* 0=Not Supported, 1=Supported */
+	__u8 reserved1;			/* for 32 bit alignment */
+	__u16 reserved2;		/* for 32 bit alignment */
+} __attribute__ ((packed));
+
+/*Pre / Post processing algorithms support*/
+struct snd_sst_ppp_info {
+	__u32 src:1;		/* 0=Not supported, 1=Supported */
+	__u32 mixer:1;		/* 0=Not supported, 1=Supported */
+	__u32 volume_control:1;	/* 0=Not Supported, 1=Supported */
+	__u32 mute_control:1;	/* 0=Not Supported, 1=Supported */
+	__u32 anc:1;		/* 0=Not Supported, 1=Supported */
+	__u32 side_tone:1;	/* 0=Not Supported, 1=Supported */
+	__u32 dc_removal:1;	/* 0=Not Supported, 1=Supported */
+	__u32 equalizer:1;	/* 0=Not Supported, 1=Supported */
+	__u32 spkr_prot:1;	/* 0=Not Supported, 1=Supported */
+	__u32 bass_boost:1;	/* 0=Not Supported, 1=Supported */
+	__u32 stereo_widening:1;/* 0=Not Supported, 1=Supported */
+	__u32 rsvd1:21;
+	__u32 rsvd2;
+};
+
+/* Firmware capabilities info */
+struct snd_sst_fw_info {
+	struct snd_sst_fw_version fw_version; /* Firmware version */
+	__u8 audio_codecs_supported[8];	/* Codecs supported by FW */
+	__u32 recommend_min_duration; /* Min duration for Lowpower Playback */
+	__u8 max_pcm_streams_supported; /* Max num of PCM streams supported */
+	__u8 max_enc_streams_supported;	/* Max number of Encoded streams  */
+	__u16 reserved;		/* 32 bit alignment*/
+	struct snd_sst_ppp_info ppp_info; /* pre_processing mod cap info */
+	struct snd_sst_postproc_info pop_info; /* Post processing cap info*/
+	struct snd_sst_port_info port_info[3]; /* Port info */
+	struct snd_sst_mix_info mix_info;/* Mixer info */
+	__u32 min_input_buf; /* minmum i/p buffer for decode */
+};
+
+/* Codec params struture */
+union  snd_sst_codec_params {
+	struct snd_pcm_params pcm_params;
+	struct snd_mp3_params mp3_params;
+	struct snd_aac_params aac_params;
+	struct snd_wma_params wma_params;
+};
+
+
+struct snd_sst_stream_params {
+	union snd_sst_codec_params uc;
+} __attribute__ ((packed));
+
+struct snd_sst_params {
+	__u32 result;
+	__u32 stream_id;
+	__u8 codec;
+	__u8 ops;
+	__u8 stream_type;
+	__u8 device_type;
+	struct snd_sst_stream_params sparams;
+};
+
+struct snd_sst_vol {
+	__u32	stream_id;
+	__s32	volume;
+	__u32	ramp_duration;
+	__u32	ramp_type;		/* Ramp type, default=0 */
+};
+
+struct snd_sst_mute {
+	__u32	stream_id;
+	__u32	mute;
+};
+
+/* ioctl related stuff here */
+struct snd_sst_pmic_config {
+	__u32  sfreq;                /* Sampling rate in Hz */
+	__u16  num_chan;             /* Mono =1 or Stereo =2 */
+	__u16  pcm_wd_sz;            /* Number of bits per sample */
+} __attribute__ ((packed));
+
+struct snd_sst_get_stream_params {
+	struct snd_sst_params codec_params;
+	struct snd_sst_pmic_config pcm_params;
+};
+
+enum snd_sst_target_type {
+	SND_SST_TARGET_PMIC = 1,
+	SND_SST_TARGET_LPE,
+	SND_SST_TARGET_MODEM,
+	SND_SST_TARGET_BT,
+	SND_SST_TARGET_FM,
+	SND_SST_TARGET_NONE,
+};
+
+enum snd_sst_device_type {
+	SND_SST_DEVICE_SSP = 1,
+	SND_SST_DEVICE_PCM,
+	SND_SST_DEVICE_OTHER,
+};
+
+enum snd_sst_device_mode {
+
+	SND_SST_DEV_MODE_PCM_MODE1 = 1, /*(16-bit word, bit-length frame sync)*/
+	SND_SST_DEV_MODE_PCM_MODE2,
+	SND_SST_DEV_MODE_PCM_MODE3,
+	SND_SST_DEV_MODE_PCM_MODE4_RIGHT_JUSTIFIED,
+	SND_SST_DEV_MODE_PCM_MODE4_LEFT_JUSTIFIED,
+	SND_SST_DEV_MODE_PCM_MODE4_I2S, /*(I2S mode, 16-bit words)*/
+	SND_SST_DEV_MODE_PCM_MODE5,
+	SND_SST_DEV_MODE_PCM_MODE6,
+};
+
+enum snd_sst_port_action {
+	SND_SST_PORT_PREPARE = 1,
+	SND_SST_PORT_ACTIVATE,
+};
+
+/* Target selection per device structure */
+struct snd_sst_slot_info {
+	__u8 mix_enable;	/* Mixer enable or disable */
+	__u8 device_type;
+	__u8 device_instance;	/* 0, 1, 2 */
+	__u8 target_device;
+	__u16 target_sink;
+	__u8 slot[2];
+	__u8 master;
+	__u8 action;
+	__u8 device_mode;
+	__u8 reserved;
+	struct snd_sst_pmic_config pcm_params;
+} __attribute__ ((packed));
+
+#define SST_MAX_TARGET_DEVICES 3
+/* Target device list structure */
+struct snd_sst_target_device  {
+	__u32 device_route;
+	struct snd_sst_slot_info devices[SST_MAX_TARGET_DEVICES];
+} __attribute__ ((packed));
+
+struct snd_sst_driver_info {
+	__u32 version;	/* Version of the driver */
+	__u32 active_pcm_streams;
+	__u32 active_enc_streams;
+	__u32 max_pcm_streams;
+	__u32 max_enc_streams;
+	__u32 buf_per_stream;
+};
+
+enum snd_sst_buff_type {
+	SST_BUF_USER = 1,
+	SST_BUF_MMAP,
+	SST_BUF_RAR,
+};
+
+struct snd_sst_mmap_buff_entry {
+	unsigned int offset;
+	unsigned int size;
+};
+
+struct snd_sst_mmap_buffs {
+	unsigned int entries;
+	enum snd_sst_buff_type type;
+	struct snd_sst_mmap_buff_entry *buff;
+};
+
+struct snd_sst_buff_entry {
+	void *buffer;
+	unsigned int size;
+};
+
+struct snd_sst_buffs {
+	unsigned int entries;
+	__u8 type;
+	struct snd_sst_buff_entry *buff_entry;
+};
+
+struct snd_sst_dbufs  {
+	unsigned long long input_bytes_consumed;
+	unsigned long long output_bytes_produced;
+	struct snd_sst_buffs *ibufs;
+	struct snd_sst_buffs *obufs;
+};
+
+/*IOCTL defined here */
+/*SST MMF IOCTLS only */
+#define SNDRV_SST_STREAM_SET_PARAMS _IOR('L', 0x00, \
+					struct snd_sst_stream_params *)
+#define SNDRV_SST_STREAM_GET_PARAMS _IOWR('L', 0x01, \
+					struct snd_sst_get_stream_params *)
+#define SNDRV_SST_STREAM_GET_TSTAMP _IOWR('L', 0x02, __u64 *)
+#define	SNDRV_SST_STREAM_DECODE	_IOWR('L', 0x03, struct snd_sst_dbufs *)
+#define SNDRV_SST_STREAM_BYTES_DECODED _IOWR('L', 0x04, __u64 *)
+#define SNDRV_SST_STREAM_START	_IO('A', 0x42)
+#define SNDRV_SST_STREAM_DROP	_IO('A', 0x43)
+#define SNDRV_SST_STREAM_DRAIN	_IO('A', 0x44)
+#define SNDRV_SST_STREAM_PAUSE	_IOW('A', 0x45, int)
+#define SNDRV_SST_STREAM_RESUME _IO('A', 0x47)
+#define SNDRV_SST_MMAP_PLAY	_IOW('L', 0x05, struct snd_sst_mmap_buffs *)
+#define SNDRV_SST_MMAP_CAPTURE _IOW('L', 0x06, struct snd_sst_mmap_buffs *)
+/*SST common ioctls */
+#define SNDRV_SST_DRIVER_INFO	_IOR('L', 0x10, struct snd_sst_driver_info *)
+#define SNDRV_SST_SET_VOL	_IOW('L', 0x11, struct snd_sst_vol *)
+#define SNDRV_SST_GET_VOL	_IOW('L', 0x12, struct snd_sst_vol *)
+#define SNDRV_SST_MUTE		_IOW('L', 0x13, struct snd_sst_mute *)
+/*AM Ioctly only */
+#define SNDRV_SST_FW_INFO	_IOR('L', 0x20,  struct snd_sst_fw_info *)
+#define SNDRV_SST_SET_TARGET_DEVICE _IOW('L', 0x21, \
+					struct snd_sst_target_device *)
+
+#endif /* __INTEL_SST_IOCTL_H__ */
diff --git a/drivers/staging/intel_sst/intel_sst_ipc.c b/drivers/staging/intel_sst/intel_sst_ipc.c
new file mode 100644
index 0000000..39c67fa
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_ipc.c
@@ -0,0 +1,656 @@
+/*
+ *  intel_sst_ipc.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file defines all ipc functions
+ */
+
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <linux/sched.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+/*
+ * sst_send_sound_card_type - send sound card type
+ *
+ * this function sends the sound card type to sst dsp engine
+ */
+static void sst_send_sound_card_type(void)
+{
+	struct ipc_post *msg = NULL;
+
+	if (sst_create_short_msg(&msg))
+		return;
+
+	sst_fill_header(&msg->header, IPC_IA_SET_PMIC_TYPE, 0, 0);
+	msg->header.part.data = sst_drv_ctx->pmic_vendor;
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	return;
+}
+
+/**
+* sst_post_message - Posts message to SST
+*
+* @work: Pointer to work structure
+*
+* This function is called by any component in driver which
+* wants to send an IPC message. This will post message only if
+* busy bit is free
+*/
+void sst_post_message(struct work_struct *work)
+{
+	struct ipc_post *msg;
+	union ipc_header header;
+	union  interrupt_reg imr;
+	int retval = 0;
+	imr.full = 0;
+
+	/*To check if LPE is in stalled state.*/
+	retval = sst_stalled();
+	if (retval < 0) {
+		pr_err("sst: in stalled state\n");
+		return;
+	}
+	pr_debug("sst: post message called\n");
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+
+	/* check list */
+	if (list_empty(&sst_drv_ctx->ipc_dispatch_list)) {
+		/* list is empty, mask imr */
+		pr_debug("sst: Empty msg queue... masking\n");
+		imr.full = readl(sst_drv_ctx->shim + SST_IMRX);
+		imr.part.done_interrupt = 1;
+		/* dummy register for shim workaround */
+		sst_shim_write(sst_drv_ctx->shim, SST_IMRX, imr.full);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		return;
+	}
+
+	/* check busy bit */
+	header.full = sst_shim_read(sst_drv_ctx->shim, SST_IPCX);
+	if (header.part.busy) {
+		/* busy, unmask */
+		pr_debug("sst: Busy not free... unmasking\n");
+		imr.full = readl(sst_drv_ctx->shim + SST_IMRX);
+		imr.part.done_interrupt = 0;
+		/* dummy register for shim workaround */
+		sst_shim_write(sst_drv_ctx->shim, SST_IMRX, imr.full);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		return;
+	}
+	/* copy msg from list */
+	msg = list_entry(sst_drv_ctx->ipc_dispatch_list.next,
+			struct ipc_post, node);
+	list_del(&msg->node);
+	pr_debug("sst: Post message: header = %x\n", msg->header.full);
+	pr_debug("sst: size: = %x\n", msg->header.part.data);
+	if (msg->header.part.large)
+		memcpy_toio(sst_drv_ctx->mailbox + SST_MAILBOX_SEND,
+			msg->mailbox_data, msg->header.part.data);
+	/* dummy register for shim workaround */
+
+	sst_shim_write(sst_drv_ctx->shim, SST_IPCX, msg->header.full);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+
+	kfree(msg->mailbox_data);
+	kfree(msg);
+	return;
+}
+
+/*
+ * sst_clear_interrupt - clear the SST FW interrupt
+ *
+ * This function clears the interrupt register after the interrupt
+ * bottom half is complete allowing next interrupt to arrive
+ */
+void sst_clear_interrupt(void)
+{
+	union interrupt_reg isr;
+	union interrupt_reg imr;
+	union ipc_header clear_ipc;
+
+	imr.full = sst_shim_read(sst_drv_ctx->shim, SST_IMRX);
+	isr.full = sst_shim_read(sst_drv_ctx->shim, SST_ISRX);
+	/*  write 1 to clear  */;
+	isr.part.busy_interrupt = 1;
+	sst_shim_write(sst_drv_ctx->shim, SST_ISRX, isr.full);
+	/* Set IA done bit */
+	clear_ipc.full = sst_shim_read(sst_drv_ctx->shim, SST_IPCD);
+	clear_ipc.part.busy = 0;
+	clear_ipc.part.done = 1;
+	clear_ipc.part.data = IPC_ACK_SUCCESS;
+	sst_shim_write(sst_drv_ctx->shim, SST_IPCD, clear_ipc.full);
+	/* un mask busy interrupt */
+	imr.part.busy_interrupt = 0;
+	sst_shim_write(sst_drv_ctx->shim, SST_IMRX, imr.full);
+}
+
+/*
+ * process_fw_init - process the FW init msg
+ *
+ * @msg: IPC message from FW
+ *
+ * This function processes the FW init msg from FW
+ * marks FW state and prints debug info of loaded FW
+ */
+int process_fw_init(struct sst_ipc_msg_wq *msg)
+{
+	struct ipc_header_fw_init *init =
+		(struct ipc_header_fw_init *)msg->mailbox;
+	int retval = 0;
+
+	pr_debug("sst: *** FW Init msg came***\n");
+	if (init->result) {
+		mutex_lock(&sst_drv_ctx->sst_lock);
+		sst_drv_ctx->sst_state = SST_ERROR;
+		mutex_unlock(&sst_drv_ctx->sst_lock);
+		pr_debug("sst: FW Init failed, Error %x\n", init->result);
+		pr_err("sst: FW Init failed, Error %x\n", init->result);
+		retval = -init->result;
+		return retval;
+	}
+	if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID)
+		sst_send_sound_card_type();
+	mutex_lock(&sst_drv_ctx->sst_lock);
+	sst_drv_ctx->sst_state = SST_FW_RUNNING;
+	mutex_unlock(&sst_drv_ctx->sst_lock);
+	pr_debug("sst: FW Version %x.%x\n",
+			init->fw_version.major, init->fw_version.minor);
+	pr_debug("sst: Build No %x Type %x\n",
+			init->fw_version.build, init->fw_version.type);
+	pr_debug("sst:  Build date %s Time %s\n",
+			init->build_info.date, init->build_info.time);
+	sst_wake_up_alloc_block(sst_drv_ctx, FW_DWNL_ID, retval, NULL);
+	return retval;
+}
+/**
+* sst_process_message - Processes message from SST
+*
+* @work:	Pointer to work structure
+*
+* This function is scheduled by ISR
+* It take a msg from process_queue and does action based on msg
+*/
+void sst_process_message(struct work_struct *work)
+{
+	struct sst_ipc_msg_wq *msg =
+			container_of(work, struct sst_ipc_msg_wq, wq);
+	int str_id = msg->header.part.str_id;
+
+	pr_debug("sst: IPC process for %x\n", msg->header.full);
+
+	/* based on msg in list call respective handler */
+	switch (msg->header.part.msg_id) {
+	case IPC_SST_BUF_UNDER_RUN:
+	case IPC_SST_BUF_OVER_RUN:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst:  stream id %d invalid\n", str_id);
+			break;
+		}
+		pr_err("sst: Buffer under/overrun for%d\n",
+				msg->header.part.str_id);
+		pr_err("sst: Got Underrun & not to send data...ignore\n");
+		break;
+
+	case IPC_SST_GET_PLAY_FRAMES:
+		if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID) {
+			struct stream_info *stream ;
+
+			if (sst_validate_strid(str_id)) {
+				pr_err("sst: strid %d invalid\n", str_id);
+				break;
+			}
+			/* call sst_play_frame */
+			stream = &sst_drv_ctx->streams[str_id];
+			pr_debug("sst: sst_play_frames for %d\n",
+					msg->header.part.str_id);
+			mutex_lock(&sst_drv_ctx->streams[str_id].lock);
+			sst_play_frame(msg->header.part.str_id);
+			mutex_unlock(&sst_drv_ctx->streams[str_id].lock);
+			break;
+		} else
+			pr_err("sst: sst_play_frames for Penwell!!\n");
+
+	case IPC_SST_GET_CAPT_FRAMES:
+		if (sst_drv_ctx->pci_id == SST_MRST_PCI_ID) {
+			struct stream_info *stream;
+			/* call sst_capture_frame */
+			if (sst_validate_strid(str_id)) {
+				pr_err("sst: str id %d invalid\n", str_id);
+				break;
+			}
+			stream = &sst_drv_ctx->streams[str_id];
+			pr_debug("sst: sst_capture_frames for %d\n",
+					msg->header.part.str_id);
+			mutex_lock(&stream->lock);
+			if (stream->mmapped == false &&
+					stream->src == SST_DRV) {
+				pr_debug("sst: waking up block for copy.\n");
+				stream->data_blk.ret_code = 0;
+				stream->data_blk.condition = true;
+				stream->data_blk.on = false;
+				wake_up(&sst_drv_ctx->wait_queue);
+			} else
+				sst_capture_frame(msg->header.part.str_id);
+			mutex_unlock(&stream->lock);
+		} else
+			pr_err("sst: sst_play_frames for Penwell!!\n");
+		break;
+
+	case IPC_IA_PRINT_STRING:
+		pr_debug("sst: been asked to print something by fw\n");
+		/* TBD */
+		break;
+
+	case IPC_IA_FW_INIT_CMPLT: {
+		/* send next data to FW */
+		process_fw_init(msg);
+		break;
+	}
+
+	case IPC_SST_STREAM_PROCESS_FATAL_ERR:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst: stream id %d invalid\n", str_id);
+			break;
+		}
+		pr_err("sst: codec fatal error %x stream %d...\n",
+				msg->header.full, msg->header.part.str_id);
+		pr_err("sst: Dropping the stream\n");
+		sst_drop_stream(msg->header.part.str_id);
+		break;
+	case IPC_IA_LPE_GETTING_STALLED:
+		sst_drv_ctx->lpe_stalled = 1;
+		break;
+	case IPC_IA_LPE_UNSTALLED:
+		sst_drv_ctx->lpe_stalled = 0;
+		break;
+	default:
+		/* Illegal case */
+		pr_err("sst: Unhandled msg %x header %x\n",
+		msg->header.part.msg_id, msg->header.full);
+	}
+	sst_clear_interrupt();
+	return;
+}
+
+/**
+* sst_process_reply - Processes reply message from SST
+*
+* @work:	Pointer to work structure
+*
+* This function is scheduled by ISR
+* It take a reply msg from response_queue and
+* does action based on msg
+*/
+void sst_process_reply(struct work_struct *work)
+{
+	struct sst_ipc_msg_wq *msg =
+			container_of(work, struct sst_ipc_msg_wq, wq);
+
+	int str_id = msg->header.part.str_id;
+	struct stream_info *str_info;
+
+	switch (msg->header.part.msg_id) {
+	case IPC_IA_TARGET_DEV_SELECT:
+		if (!msg->header.part.data) {
+			sst_drv_ctx->tgt_dev_blk.ret_code = 0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+			msg->header.part.msg_id, msg->header.part.data);
+			sst_drv_ctx->tgt_dev_blk.ret_code =
+					-msg->header.part.data;
+		}
+
+		if (sst_drv_ctx->tgt_dev_blk.on == true) {
+				sst_drv_ctx->tgt_dev_blk.condition = true;
+				wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_GET_FW_INFO: {
+		struct snd_sst_fw_info *fw_info =
+			(struct snd_sst_fw_info *)msg->mailbox;
+		if (msg->header.part.large) {
+			int major = fw_info->fw_version.major;
+			int minor = fw_info->fw_version.minor;
+			int build = fw_info->fw_version.build;
+			pr_debug("sst: Msg succedded %x\n",
+				       msg->header.part.msg_id);
+			pr_debug("INFO: ***FW*** = %02d.%02d.%02d\n",
+					major, minor, build);
+			memcpy_fromio(sst_drv_ctx->fw_info_blk.data,
+				((struct snd_sst_fw_info *)(msg->mailbox)),
+				sizeof(struct snd_sst_fw_info));
+			sst_drv_ctx->fw_info_blk.ret_code = 0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+			msg->header.part.msg_id, msg->header.part.data);
+			sst_drv_ctx->fw_info_blk.ret_code =
+					-msg->header.part.data;
+		}
+		if (sst_drv_ctx->fw_info_blk.on == true) {
+			pr_debug("sst: Memcopy succedded\n");
+			sst_drv_ctx->fw_info_blk.on = false;
+			sst_drv_ctx->fw_info_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	}
+	case IPC_IA_SET_STREAM_MUTE:
+		if (!msg->header.part.data) {
+			pr_debug("sst: Msg succedded %x\n",
+				       msg->header.part.msg_id);
+			sst_drv_ctx->mute_info_blk.ret_code = 0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+			msg->header.part.msg_id, msg->header.part.data);
+			sst_drv_ctx->mute_info_blk.ret_code =
+					-msg->header.part.data;
+
+		}
+		if (sst_drv_ctx->mute_info_blk.on == true) {
+			sst_drv_ctx->mute_info_blk.on = false;
+			sst_drv_ctx->mute_info_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_SET_STREAM_VOL:
+		if (!msg->header.part.data) {
+			pr_debug("sst: Msg succedded %x\n",
+				       msg->header.part.msg_id);
+			sst_drv_ctx->vol_info_blk.ret_code = 0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+					msg->header.part.msg_id,
+			msg->header.part.data);
+			sst_drv_ctx->vol_info_blk.ret_code =
+					-msg->header.part.data;
+
+		}
+
+		if (sst_drv_ctx->vol_info_blk.on == true) {
+			sst_drv_ctx->vol_info_blk.on = false;
+			sst_drv_ctx->vol_info_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_GET_STREAM_VOL:
+		if (msg->header.part.large) {
+			pr_debug("sst: Large Msg Received Successfully\n");
+			pr_debug("sst: Msg succedded %x\n",
+				       msg->header.part.msg_id);
+			memcpy_fromio(sst_drv_ctx->vol_info_blk.data,
+				(void *) msg->mailbox,
+				sizeof(struct snd_sst_vol));
+			sst_drv_ctx->vol_info_blk.ret_code = 0;
+		} else {
+			pr_err("sst: Msg %x reply error %x\n",
+			msg->header.part.msg_id, msg->header.part.data);
+			sst_drv_ctx->vol_info_blk.ret_code =
+					-msg->header.part.data;
+		}
+		if (sst_drv_ctx->vol_info_blk.on == true) {
+			sst_drv_ctx->vol_info_blk.on = false;
+			sst_drv_ctx->vol_info_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+
+	case IPC_IA_GET_STREAM_PARAMS:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst: stream id %d invalid\n", str_id);
+			break;
+		}
+		str_info = &sst_drv_ctx->streams[str_id];
+		if (msg->header.part.large) {
+			pr_debug("sst: Get stream large success\n");
+			memcpy_fromio(str_info->ctrl_blk.data,
+				((void *)(msg->mailbox)),
+				sizeof(struct snd_sst_fw_get_stream_params));
+			str_info->ctrl_blk.ret_code = 0;
+		} else {
+			pr_err("sst: Msg %x reply error %x\n",
+				msg->header.part.msg_id, msg->header.part.data);
+			str_info->ctrl_blk.ret_code = -msg->header.part.data;
+		}
+		if (str_info->ctrl_blk.on == true) {
+			str_info->ctrl_blk.on = false;
+			str_info->ctrl_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_DECODE_FRAMES:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst: stream id %d invalid\n", str_id);
+			break;
+		}
+		str_info = &sst_drv_ctx->streams[str_id];
+		if (msg->header.part.large) {
+			pr_debug("sst: Msg succedded %x\n",
+				       msg->header.part.msg_id);
+			memcpy_fromio(str_info->data_blk.data,
+					((void *)(msg->mailbox)),
+					sizeof(struct snd_sst_decode_info));
+			str_info->data_blk.ret_code = 0;
+		} else {
+			pr_err("sst: Msg %x reply error %x\n",
+				msg->header.part.msg_id, msg->header.part.data);
+			str_info->data_blk.ret_code = -msg->header.part.data;
+		}
+		if (str_info->data_blk.on == true) {
+			str_info->data_blk.on = false;
+			str_info->data_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_DRAIN_STREAM:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst: stream id %d invalid\n", str_id);
+			break;
+		}
+		str_info = &sst_drv_ctx->streams[str_id];
+		if (!msg->header.part.data) {
+			pr_debug("sst: Msg succedded %x\n",
+					msg->header.part.msg_id);
+			str_info->ctrl_blk.ret_code = 0;
+
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+				msg->header.part.msg_id, msg->header.part.data);
+			str_info->ctrl_blk.ret_code = -msg->header.part.data;
+
+		}
+		str_info = &sst_drv_ctx->streams[str_id];
+		if (str_info->data_blk.on == true) {
+			str_info->data_blk.on = false;
+			str_info->data_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+
+	case IPC_IA_DROP_STREAM:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst: str id %d invalid\n", str_id);
+			break;
+		}
+		str_info = &sst_drv_ctx->streams[str_id];
+		if (msg->header.part.large) {
+			struct snd_sst_drop_response *drop_resp =
+				(struct snd_sst_drop_response *)msg->mailbox;
+
+			pr_debug("sst: Drop ret bytes %x\n", drop_resp->bytes);
+
+			str_info->curr_bytes = drop_resp->bytes;
+			str_info->ctrl_blk.ret_code =  0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+				msg->header.part.msg_id, msg->header.part.data);
+			str_info->ctrl_blk.ret_code = -msg->header.part.data;
+		}
+		if (str_info->ctrl_blk.on == true) {
+			str_info->ctrl_blk.on = false;
+			str_info->ctrl_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_ENABLE_RX_TIME_SLOT:
+		if (!msg->header.part.data) {
+			pr_debug("sst: RX_TIME_SLOT success\n");
+			sst_drv_ctx->hs_info_blk.ret_code = 0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+				msg->header.part.msg_id,
+				msg->header.part.data);
+			sst_drv_ctx->hs_info_blk.ret_code =
+				-msg->header.part.data;
+		}
+		if (sst_drv_ctx->hs_info_blk.on == true) {
+			sst_drv_ctx->hs_info_blk.on = false;
+			sst_drv_ctx->hs_info_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+	case IPC_IA_PAUSE_STREAM:
+	case IPC_IA_RESUME_STREAM:
+	case IPC_IA_SET_STREAM_PARAMS:
+		str_info = &sst_drv_ctx->streams[str_id];
+		if (!msg->header.part.data) {
+			pr_debug("sst: Msg succedded %x\n",
+					msg->header.part.msg_id);
+			str_info->ctrl_blk.ret_code = 0;
+		} else {
+			pr_err("sst:  Msg %x reply error %x\n",
+					msg->header.part.msg_id,
+					msg->header.part.data);
+			str_info->ctrl_blk.ret_code = -msg->header.part.data;
+		}
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst:  stream id %d invalid\n", str_id);
+			break;
+		}
+
+		if (str_info->ctrl_blk.on == true) {
+			str_info->ctrl_blk.on = false;
+			str_info->ctrl_blk.condition = true;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		break;
+
+	case IPC_IA_FREE_STREAM:
+		if (!msg->header.part.data) {
+			pr_debug("sst: Stream %d freed\n", str_id);
+		} else {
+			pr_err("sst: Free for %d ret error %x\n",
+				       str_id, msg->header.part.data);
+		}
+		break;
+	case IPC_IA_ALLOC_STREAM: {
+		/* map to stream, call play */
+		struct snd_sst_alloc_response *resp =
+				(struct snd_sst_alloc_response *)msg->mailbox;
+		if (resp->str_type.result)
+			pr_err("sst: error alloc stream = %x\n",
+				       resp->str_type.result);
+		sst_alloc_stream_response(str_id, resp);
+		break;
+	}
+
+	case IPC_IA_PLAY_FRAMES:
+	case IPC_IA_CAPT_FRAMES:
+		if (sst_validate_strid(str_id)) {
+			pr_err("sst: stream id %d invalid\n" , str_id);
+			break;
+		}
+		pr_debug("sst: Ack for play/capt frames recived\n");
+		break;
+
+	case IPC_IA_PREP_LIB_DNLD: {
+		struct snd_sst_str_type *str_type =
+			(struct snd_sst_str_type *)msg->mailbox;
+		pr_debug("sst: Prep Lib download %x\n",
+				msg->header.part.msg_id);
+		if (str_type->result)
+			pr_err("sst: Prep lib download %x\n", str_type->result);
+		else
+			pr_debug("sst: Can download codec now...\n");
+		sst_wake_up_alloc_block(sst_drv_ctx, str_id,
+				str_type->result, NULL);
+		break;
+	}
+
+	case IPC_IA_LIB_DNLD_CMPLT: {
+		struct snd_sst_lib_download_info *resp =
+			(struct snd_sst_lib_download_info *)msg->mailbox;
+		int retval = resp->result;
+
+		pr_debug("sst: Lib downloaded %x\n", msg->header.part.msg_id);
+		if (resp->result) {
+			pr_err("sst: err in lib dload %x\n", resp->result);
+		} else {
+			pr_debug("sst: Codec download complete...\n");
+			pr_debug("sst: codec Type %d Ver %d Built %s: %s\n",
+				resp->dload_lib.lib_info.lib_type,
+				resp->dload_lib.lib_info.lib_version,
+				resp->dload_lib.lib_info.b_date,
+				resp->dload_lib.lib_info.b_time);
+		}
+		sst_wake_up_alloc_block(sst_drv_ctx, str_id,
+						retval, NULL);
+		break;
+	}
+
+	case IPC_IA_GET_FW_VERSION: {
+		struct ipc_header_fw_init *version =
+				(struct ipc_header_fw_init *)msg->mailbox;
+		int major = version->fw_version.major;
+		int minor = version->fw_version.minor;
+		int build = version->fw_version.build;
+		dev_info(&sst_drv_ctx->pci->dev,
+			"INFO: ***LOADED SST FW VERSION*** = %02d.%02d.%02d\n",
+		major, minor, build);
+		break;
+	}
+	case IPC_IA_GET_FW_BUILD_INF: {
+		struct sst_fw_build_info *build =
+			(struct sst_fw_build_info *)msg->mailbox;
+		pr_debug("sst: Build date:%sTime:%s", build->date, build->time);
+		break;
+	}
+	case IPC_IA_SET_PMIC_TYPE:
+		break;
+	case IPC_IA_START_STREAM:
+		pr_debug("sst: reply for START STREAM %x\n", msg->header.full);
+		break;
+	default:
+		/* Illegal case */
+		pr_err("sst: process reply:default = %x\n", msg->header.full);
+	}
+	sst_clear_interrupt();
+	return;
+}
diff --git a/drivers/staging/intel_sst/intel_sst_pvt.c b/drivers/staging/intel_sst/intel_sst_pvt.c
new file mode 100644
index 0000000..6487e19
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_pvt.c
@@ -0,0 +1,311 @@
+/*
+ *  intel_sst_pvt.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10	Intel Corp
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *
+ *  This file contains all private functions
+ */
+
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include <linux/sched.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+/*
+ * sst_get_block_stream - get a new block stream
+ *
+ * @sst_drv_ctx: Driver context structure
+ *
+ * This function assigns a block for the calls that dont have stream context yet
+ * the blocks are used for waiting on Firmware's response for any operation
+ * Should be called with stream lock held
+ */
+int sst_get_block_stream(struct intel_sst_drv *sst_drv_ctx)
+{
+	int i;
+
+	for (i = 0; i < MAX_ACTIVE_STREAM; i++) {
+		if (sst_drv_ctx->alloc_block[i].sst_id == BLOCK_UNINIT) {
+			sst_drv_ctx->alloc_block[i].ops_block.condition = false;
+			sst_drv_ctx->alloc_block[i].ops_block.ret_code = 0;
+			sst_drv_ctx->alloc_block[i].sst_id = 0;
+			break;
+		}
+	}
+	if (i == MAX_ACTIVE_STREAM) {
+		pr_err("sst: max alloc_stream reached");
+		i = -EBUSY; /* active stream limit reached */
+	}
+	return i;
+}
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
+			pr_err("sst: stream failed %d\n", block->ret_code);
+			retval = -EBUSY;
+		} else {
+			pr_debug("sst: event up\n");
+			retval = 0;
+		}
+	} else {
+		pr_err("sst: signal interrupted\n");
+		retval = -EINTR;
+	}
+	return retval;
+
+}
+
+
+/*
+ * sst_wait_interruptible_timeout - wait on event interruptable
+ *
+ * @sst_drv_ctx: Driver context
+ * @block: Driver block to wait on
+ * @timeout: time for wait on
+ *
+ * This function waits with a timeout value (and is interruptible) on a
+ * given block event
+ */
+int sst_wait_interruptible_timeout(
+			struct intel_sst_drv *sst_drv_ctx,
+			struct sst_block *block, int timeout)
+{
+	int retval = 0;
+
+	pr_debug("sst: sst_wait_interruptible_timeout - waiting....\n");
+	if (wait_event_interruptible_timeout(sst_drv_ctx->wait_queue,
+						block->condition,
+						msecs_to_jiffies(timeout))) {
+		if (block->ret_code < 0)
+			pr_err("sst: stream failed %d\n", block->ret_code);
+		else
+			pr_debug("sst: event up\n");
+		retval = block->ret_code;
+	} else {
+		block->on = false;
+		pr_err("sst: timeout occured...\n");
+		/*setting firmware state as uninit so that the
+		firmware will get re-downloaded on next request
+		this is because firmare not responding for 5 sec
+		is equalant to some unrecoverable error of FW
+		sst_drv_ctx->sst_state = SST_UN_INIT;*/
+		retval = -EBUSY;
+	}
+	return retval;
+
+}
+
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
+int sst_wait_timeout(struct intel_sst_drv *sst_drv_ctx,
+		struct stream_alloc_block *block)
+{
+	int retval = 0;
+
+	/* NOTE:
+	Observed that FW processes the alloc msg and replies even
+	before the alloc thread has finished execution */
+	pr_debug("sst: waiting for %x, condition %x\n",
+		       block->sst_id, block->ops_block.condition);
+	if (wait_event_interruptible_timeout(sst_drv_ctx->wait_queue,
+				block->ops_block.condition,
+				msecs_to_jiffies(SST_BLOCK_TIMEOUT))) {
+		/* event wake */
+		pr_debug("sst: Event wake %x\n", block->ops_block.condition);
+		pr_debug("sst: message ret: %d\n", block->ops_block.ret_code);
+		retval = block->ops_block.ret_code;
+	} else {
+		block->ops_block.on = false;
+		pr_err("sst: Wait timed-out %x\n", block->ops_block.condition);
+		/* settign firmware state as uninit so that the
+		firmware will get redownloaded on next request
+		this is because firmare not responding for 5 sec
+		is equalant to some unrecoverable error of FW
+		sst_drv_ctx->sst_state = SST_UN_INIT;*/
+		retval = -EBUSY;
+	}
+	return retval;
+
+}
+
+/*
+ * sst_create_large_msg - create a large IPC message
+ *
+ * @arg: ipc message
+ *
+ * this function allocates structures to send a large message to the firmware
+ */
+int sst_create_large_msg(struct ipc_post **arg)
+{
+	struct ipc_post *msg;
+
+	msg = kzalloc(sizeof(struct ipc_post), GFP_ATOMIC);
+	if (!msg) {
+		pr_err("sst: kzalloc msg failed\n");
+		return -ENOMEM;
+	}
+
+	msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_ATOMIC);
+	if (!msg->mailbox_data) {
+		kfree(msg);
+		pr_err("sst: kzalloc mailbox_data failed");
+		return -ENOMEM;
+	};
+	*arg = msg;
+	return 0;
+}
+
+/*
+ * sst_create_short_msg - create a short IPC message
+ *
+ * @arg: ipc message
+ *
+ * this function allocates structures to send a short message to the firmware
+ */
+int sst_create_short_msg(struct ipc_post **arg)
+{
+	struct ipc_post *msg;
+
+	msg = kzalloc(sizeof(*msg), GFP_ATOMIC);
+	if (!msg) {
+		pr_err("sst: kzalloc msg failed\n");
+		return -ENOMEM;
+	}
+	msg->mailbox_data = NULL;
+	*arg = msg;
+	return 0;
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
+	struct sst_stream_bufs *bufs = NULL, *_bufs;
+	stream->status = STREAM_UN_INIT;
+	stream->prev = STREAM_UN_INIT;
+	mutex_lock(&stream->lock);
+	list_for_each_entry_safe(bufs, _bufs, &stream->bufs, node) {
+		list_del(&bufs->node);
+		kfree(bufs);
+	}
+	mutex_unlock(&stream->lock);
+
+	if (stream->ops != STREAM_OPS_PLAYBACK_DRM)
+		kfree(stream->decode_ibuf);
+}
+
+/*
+ * sst_wake_up_alloc_block - wake up waiting block
+ *
+ * @sst_drv_ctx: Driver context
+ * @sst_id: stream id
+ * @status: status of wakeup
+ * @data: data pointer of wakeup
+ *
+ * This function wakes up a sleeping block event based on the response
+ */
+void sst_wake_up_alloc_block(struct intel_sst_drv *sst_drv_ctx,
+		u8 sst_id, int status, void *data)
+{
+	int i;
+
+	/* Unblock with retval code */
+	for (i = 0; i < MAX_ACTIVE_STREAM; i++) {
+		if (sst_id == sst_drv_ctx->alloc_block[i].sst_id) {
+			sst_drv_ctx->alloc_block[i].ops_block.condition = true;
+			sst_drv_ctx->alloc_block[i].ops_block.ret_code = status;
+			sst_drv_ctx->alloc_block[i].ops_block.data = data;
+			wake_up(&sst_drv_ctx->wait_queue);
+			break;
+		}
+	}
+}
+
+/*
+ * sst_enable_rx_timeslot - Send msg to query for stream parameters
+ * @status: rx timeslot to be enabled
+ *
+ * This function is called when the RX timeslot is required to be enabled
+ */
+int sst_enable_rx_timeslot(int status)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+
+	if (sst_create_short_msg(&msg)) {
+		pr_err("sst: mem allocation failed\n");
+			return -ENOMEM;
+	}
+	pr_debug("sst: ipc message sending: ENABLE_RX_TIME_SLOT\n");
+	sst_fill_header(&msg->header, IPC_IA_ENABLE_RX_TIME_SLOT, 0, 0);
+	msg->header.part.data = status;
+	sst_drv_ctx->hs_info_blk.condition = false;
+	sst_drv_ctx->hs_info_blk.ret_code = 0;
+	sst_drv_ctx->hs_info_blk.on = true;
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node,
+			&sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+				&sst_drv_ctx->hs_info_blk, SST_BLOCK_TIMEOUT);
+	return retval;
+}
+
diff --git a/drivers/staging/intel_sst/intel_sst_stream.c b/drivers/staging/intel_sst/intel_sst_stream.c
new file mode 100644
index 0000000..ff46d5c
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_stream.c
@@ -0,0 +1,575 @@
+/*
+ *  intel_sst_stream.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corp
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file contains the stream operations of SST driver
+ */
+
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <linux/sched.h>
+#include "intel_sst_ioctl.h"
+#include "intel_sst.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+
+/*
+ * sst_check_device_type - Check the medfield device type
+ *
+ * @device: Device to be checked
+ * @num_ch: Number of channels queried
+ * @pcm_slot: slot to be enabled for this device
+ *
+ * This checks the deivce against the map and calculates pcm_slot value
+ */
+int sst_check_device_type(u32 device, u32 num_chan, u32 *pcm_slot)
+{
+	if (device > MAX_NUM_STREAMS_MFLD) {
+		pr_debug("sst: device type invalid %d\n", device);
+		return -EINVAL;
+	}
+	if (sst_drv_ctx->streams[device].status == STREAM_UN_INIT) {
+		if (device == SND_SST_DEVICE_VIBRA && num_chan == 1)
+			*pcm_slot = 0x10;
+		else if (device == SND_SST_DEVICE_HAPTIC && num_chan == 1)
+			*pcm_slot = 0x20;
+		else if (device == SND_SST_DEVICE_IHF && num_chan == 1)
+			*pcm_slot = 0x04;
+		else if (device == SND_SST_DEVICE_IHF && num_chan == 2)
+			*pcm_slot = 0x0C;
+		else if (device == SND_SST_DEVICE_HEADSET && num_chan == 1)
+			*pcm_slot = 0x01;
+		else if (device == SND_SST_DEVICE_HEADSET && num_chan == 2)
+			*pcm_slot = 0x03;
+		else if (device == SND_SST_DEVICE_CAPTURE && num_chan == 1)
+			*pcm_slot = 0x01;
+		else if (device == SND_SST_DEVICE_CAPTURE && num_chan == 2)
+			*pcm_slot = 0x03;
+		else if (device == SND_SST_DEVICE_CAPTURE && num_chan == 3)
+			*pcm_slot = 0x07;
+		else if (device == SND_SST_DEVICE_CAPTURE && num_chan == 4)
+			*pcm_slot = 0x0F;
+		else {
+			pr_debug("sst: No condition satisfied.. ret err\n");
+			return -EINVAL;
+		}
+	} else {
+		pr_debug("sst: this stream state is not uni-init, is %d\n",
+				sst_drv_ctx->streams[device].status);
+		return -EBADRQC;
+	}
+	pr_debug("sst: returning slot %x\n", *pcm_slot);
+	return 0;
+}
+/**
+ * get_mrst_stream_id	-	gets a new stream id for use
+ *
+ * This functions searches the current streams and allocated an empty stream
+ * lock stream_lock required to be held before calling this
+ */
+static unsigned int get_mrst_stream_id(void)
+{
+	int i;
+
+	for (i = 1; i <= MAX_NUM_STREAMS_MRST; i++) {
+		if (sst_drv_ctx->streams[i].status == STREAM_UN_INIT)
+			return i;
+	}
+	pr_debug("sst: Didnt find empty stream for mrst\n");
+	return -EBUSY;
+}
+
+/**
+ * sst_alloc_stream - Send msg for a new stream ID
+ *
+ * @params:	stream params
+ * @stream_ops:	operation of stream PB/capture
+ * @codec:	codec for stream
+ * @device:	device stream to be allocated for
+ *
+ * This function is called by any function which wants to start
+ * a new stream. This also check if a stream exists which is idle
+ * it initializes idle stream id to this request
+ */
+int sst_alloc_stream(char *params, unsigned int stream_ops,
+	       u8 codec, unsigned int device)
+{
+	struct ipc_post *msg = NULL;
+	struct snd_sst_alloc_params alloc_param;
+	unsigned int pcm_slot = 0, num_ch, str_id;
+	struct snd_sst_stream_params *sparams;
+	struct stream_info *str_info;
+
+	pr_debug("SST DBG:entering sst_alloc_stream\n");
+	pr_debug("SST DBG:%d %d %d\n", stream_ops, codec, device);
+
+	BUG_ON(!params);
+	sparams = (struct snd_sst_stream_params *)params;
+	num_ch = sparams->uc.pcm_params.num_chan;
+	/*check the device type*/
+	if (sst_drv_ctx->pci_id == SST_MFLD_PCI_ID) {
+		if (sst_check_device_type(device, num_ch, &pcm_slot))
+			return -EINVAL;
+		mutex_lock(&sst_drv_ctx->stream_lock);
+		str_id = device;
+		mutex_unlock(&sst_drv_ctx->stream_lock);
+		pr_debug("SST_DBG: slot %x\n", pcm_slot);
+	} else {
+		mutex_lock(&sst_drv_ctx->stream_lock);
+		str_id = get_mrst_stream_id();
+		mutex_unlock(&sst_drv_ctx->stream_lock);
+		if (str_id <= 0)
+			return -EBUSY;
+	}
+	/*allocate device type context*/
+	sst_init_stream(&sst_drv_ctx->streams[str_id], codec,
+			str_id, stream_ops, pcm_slot, device);
+	/* send msg to FW to allocate a stream */
+	if (sst_create_large_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_ALLOC_STREAM, 1, str_id);
+	msg->header.part.data = sizeof(alloc_param) + sizeof(u32);
+	alloc_param.str_type.codec_type = codec;
+	alloc_param.str_type.str_type = SST_STREAM_TYPE_MUSIC;
+	alloc_param.str_type.operation = stream_ops;
+	alloc_param.str_type.protected_str = 0; /* non drm */
+	alloc_param.str_type.time_slots = pcm_slot;
+	alloc_param.str_type.result = alloc_param.str_type.reserved = 0;
+	memcpy(&alloc_param.stream_params, params,
+			sizeof(struct snd_sst_stream_params));
+
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &alloc_param,
+			sizeof(alloc_param));
+	str_info = &sst_drv_ctx->streams[str_id];
+	str_info->ctrl_blk.condition = false;
+	str_info->ctrl_blk.ret_code = 0;
+	str_info->ctrl_blk.on = true;
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	pr_debug("SST DBG:alloc stream done\n");
+	return str_id;
+}
+
+
+/*
+ * sst_alloc_stream_response - process alloc reply
+ *
+ * @str_id:	stream id for which the stream has been allocated
+ * @resp		the stream response from firware
+ *
+ * This function is called by firmware as a response to stream allcoation
+ * request
+ */
+int sst_alloc_stream_response(unsigned int str_id,
+				struct snd_sst_alloc_response *resp)
+{
+	int retval = 0;
+	struct stream_info *str_info;
+	struct snd_sst_lib_download *lib_dnld;
+
+	pr_debug("SST DEBUG: stream number given = %d\n", str_id);
+	str_info = &sst_drv_ctx->streams[str_id];
+	if (resp->str_type.result == SST_LIB_ERR_LIB_DNLD_REQUIRED) {
+		lib_dnld = kzalloc(sizeof(*lib_dnld), GFP_KERNEL);
+		memcpy(lib_dnld, &resp->lib_dnld, sizeof(*lib_dnld));
+	} else
+		lib_dnld = NULL;
+	if (str_info->ctrl_blk.on == true) {
+		str_info->ctrl_blk.on = false;
+		str_info->ctrl_blk.data = lib_dnld;
+		str_info->ctrl_blk.condition = true;
+		str_info->ctrl_blk.ret_code = resp->str_type.result;
+		pr_debug("SST DEBUG: sst_alloc_stream_response: waking up.\n");
+		wake_up(&sst_drv_ctx->wait_queue);
+	}
+	return retval;
+}
+
+
+/**
+* sst_get_fw_info - Send msg to query for firmware configurations
+* @info: out param that holds the firmare configurations
+*
+* This function is called when the firmware configurations are queiried for
+*/
+int sst_get_fw_info(struct snd_sst_fw_info *info)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+
+	pr_debug("SST DBG:sst_get_fw_info called\n");
+
+	if (sst_create_short_msg(&msg)) {
+		pr_err("SST ERR: message creation failed\n");
+		return -ENOMEM;
+	}
+
+	sst_fill_header(&msg->header, IPC_IA_GET_FW_INFO, 0, 0);
+	sst_drv_ctx->fw_info_blk.condition = false;
+	sst_drv_ctx->fw_info_blk.ret_code = 0;
+	sst_drv_ctx->fw_info_blk.on = true;
+	sst_drv_ctx->fw_info_blk.data = info;
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+			&sst_drv_ctx->fw_info_blk, SST_BLOCK_TIMEOUT);
+	if (retval) {
+		pr_err("SST ERR: error in fw_info = %d\n", retval);
+		retval = -EIO;
+	}
+	return retval;
+}
+
+
+/**
+* sst_pause_stream - Send msg for a pausing stream
+* @str_id:	 stream ID
+*
+* This function is called by any function which wants to pause
+* an already running stream.
+*/
+int sst_start_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+
+	pr_debug("sst_start_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+	if (str_info->status != STREAM_INIT)
+		return -EBADRQC;
+	if (sst_create_short_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_START_STREAM, 0, str_id);
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	return retval;
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
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+
+	pr_debug("SST DBG:sst_pause_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+	if (str_info->status == STREAM_PAUSED)
+		return 0;
+	if (str_info->status == STREAM_RUNNING ||
+		str_info->status == STREAM_INIT) {
+		if (str_info->prev == STREAM_UN_INIT)
+			return -EBADRQC;
+		if (str_info->ctrl_blk.on == true) {
+			pr_err("SST ERR: control path is in use\n ");
+			return -EINVAL;
+		}
+		if (sst_create_short_msg(&msg))
+			return -ENOMEM;
+
+		sst_fill_header(&msg->header, IPC_IA_PAUSE_STREAM, 0, str_id);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node,
+				&sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval == 0) {
+			str_info->prev = str_info->status;
+			str_info->status = STREAM_PAUSED;
+		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+			retval = -EINVAL;
+			mutex_lock(&sst_drv_ctx->stream_lock);
+			sst_clean_stream(str_info);
+			mutex_unlock(&sst_drv_ctx->stream_lock);
+		}
+	} else {
+		retval = -EBADRQC;
+		pr_err("SST ERR:BADQRC for stream\n ");
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
+
+	pr_debug("SST DBG:sst_resume_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+	if (str_info->status == STREAM_RUNNING)
+			return 0;
+	if (str_info->status == STREAM_PAUSED) {
+		if (str_info->ctrl_blk.on == true) {
+			pr_err("SST ERR: control path in use\n");
+			return -EINVAL;
+		}
+		if (sst_create_short_msg(&msg)) {
+			pr_err("SST ERR: mem allocation failed\n");
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_RESUME_STREAM, 0, str_id);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node,
+				&sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (!retval) {
+			if (str_info->prev == STREAM_RUNNING)
+				str_info->status = STREAM_RUNNING;
+			else
+				str_info->status = STREAM_INIT;
+			str_info->prev = STREAM_PAUSED;
+		} else if (retval == -SST_ERR_INVALID_STREAM_ID) {
+			retval = -EINVAL;
+			mutex_lock(&sst_drv_ctx->stream_lock);
+			sst_clean_stream(str_info);
+			mutex_unlock(&sst_drv_ctx->stream_lock);
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
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct sst_stream_bufs *bufs = NULL, *_bufs;
+	struct stream_info *str_info;
+
+	pr_debug("SST DBG:sst_drop_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+
+	if (str_info->status != STREAM_UN_INIT &&
+		str_info->status != STREAM_DECODE) {
+		if (str_info->ctrl_blk.on == true) {
+			pr_err("SST ERR: control path in use\n");
+			return -EINVAL;
+		}
+		if (sst_create_short_msg(&msg)) {
+			pr_err("SST ERR: mem allocation failed\n");
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_DROP_STREAM, 0, str_id);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node,
+				&sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (!retval) {
+			pr_debug("SST DBG:drop success\n");
+			str_info->prev = STREAM_UN_INIT;
+			str_info->status = STREAM_INIT;
+			if (str_info->src != MAD_DRV) {
+				mutex_lock(&str_info->lock);
+				list_for_each_entry_safe(bufs, _bufs,
+							&str_info->bufs, node) {
+					list_del(&bufs->node);
+					kfree(bufs);
+				}
+				mutex_unlock(&str_info->lock);
+			}
+			str_info->cumm_bytes += str_info->curr_bytes;
+		} else if (retval == -SST_ERR_INVALID_STREAM_ID) {
+			retval = -EINVAL;
+			mutex_lock(&sst_drv_ctx->stream_lock);
+			sst_clean_stream(str_info);
+			mutex_unlock(&sst_drv_ctx->stream_lock);
+		}
+		if (str_info->data_blk.on == true) {
+			str_info->data_blk.condition = true;
+			str_info->data_blk.ret_code = retval;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+	} else {
+		retval = -EBADRQC;
+		pr_err("SST ERR:BADQRC for stream\n");
+	}
+	return retval;
+}
+
+/**
+* sst_drain_stream - Send msg for draining stream
+* @str_id:		stream ID
+*
+* This function is called by any function which wants to drain
+* a stream.
+*/
+int sst_drain_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+
+	pr_debug("SST DBG:sst_drain_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+
+	if (str_info->status != STREAM_RUNNING &&
+		str_info->status != STREAM_INIT &&
+		str_info->status != STREAM_PAUSED) {
+			pr_err("SST ERR: BADQRC for stream = %d\n",
+				       str_info->status);
+			return -EBADRQC;
+	}
+
+	if (str_info->status == STREAM_INIT) {
+		if (sst_create_short_msg(&msg)) {
+			pr_err("SST ERR: mem allocation failed\n");
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_DRAIN_STREAM, 0, str_id);
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	} else
+		str_info->need_draining = true;
+	str_info->data_blk.condition = false;
+	str_info->data_blk.ret_code = 0;
+	str_info->data_blk.on = true;
+	retval = sst_wait_interruptible(sst_drv_ctx, &str_info->data_blk);
+	str_info->need_draining = false;
+	if (retval == -SST_ERR_INVALID_STREAM_ID) {
+		retval = -EINVAL;
+		sst_clean_stream(str_info);
+	}
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
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+
+	pr_debug("SST DBG:sst_free_stream for %d\n", str_id);
+
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	str_info = &sst_drv_ctx->streams[str_id];
+
+	if (str_info->status != STREAM_UN_INIT) {
+		if (sst_create_short_msg(&msg)) {
+			pr_err("SST ERR: mem allocation failed\n");
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_FREE_STREAM, 0, str_id);
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		str_info->prev =  str_info->status;
+		str_info->status = STREAM_UN_INIT;
+		if (str_info->data_blk.on == true) {
+			str_info->data_blk.condition = true;
+			str_info->data_blk.ret_code = 0;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		mutex_lock(&sst_drv_ctx->stream_lock);
+		sst_clean_stream(str_info);
+		mutex_unlock(&sst_drv_ctx->stream_lock);
+		pr_debug("SST DBG:Stream freed\n");
+	} else {
+		retval = -EBADRQC;
+		pr_debug("SST DBG:BADQRC for stream\n");
+	}
+
+	return retval;
+}
+
+
diff --git a/drivers/staging/intel_sst/intel_sst_stream_encoded.c b/drivers/staging/intel_sst/intel_sst_stream_encoded.c
new file mode 100644
index 0000000..fbae39f
--- /dev/null
+++ b/drivers/staging/intel_sst/intel_sst_stream_encoded.c
@@ -0,0 +1,1275 @@
+/*
+ *  intel_sst_stream.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corp
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file contains the stream operations of SST driver
+ */
+
+#include <linux/pci.h>
+#include <linux/syscalls.h>
+#include <linux/firmware.h>
+#include <linux/sched.h>
+#include <linux/rar_register.h>
+#ifdef CONFIG_MRST_RAR_HANDLER
+#include "../../../drivers/staging/memrar/memrar.h"
+#endif
+#include "intel_sst_ioctl.h"
+#include "intel_sst.h"
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+/**
+* sst_get_stream_params - Send msg to query for stream parameters
+* @str_id:	stream id for which the parameters are queried for
+* @get_params:	out parameters to which the parameters are copied to
+*
+* This function is called when the stream parameters are queiried for
+*/
+int sst_get_stream_params(int str_id,
+			struct snd_sst_get_stream_params *get_params)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct snd_sst_fw_get_stream_params *fw_params;
+
+	pr_debug("sst: get_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+
+	str_info = &sst_drv_ctx->streams[str_id];
+	if (str_info->status != STREAM_UN_INIT) {
+		if (str_info->ctrl_blk.on == true) {
+			pr_err("sst: control path in use\n");
+			return -EINVAL;
+		}
+		if (sst_create_short_msg(&msg)) {
+			pr_err("sst: message creation failed\n");
+			return -ENOMEM;
+		}
+		fw_params = kzalloc(sizeof(*fw_params), GFP_ATOMIC);
+		if (!fw_params) {
+			pr_err("sst: mem allcoation failed\n ");
+			kfree(msg);
+			return -ENOMEM;
+		}
+
+		sst_fill_header(&msg->header, IPC_IA_GET_STREAM_PARAMS,
+					0, str_id);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		str_info->ctrl_blk.data = (void *) fw_params;
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval) {
+			get_params->codec_params.result = retval;
+			kfree(fw_params);
+			return -EIO;
+		}
+		memcpy(&get_params->pcm_params, &fw_params->pcm_params,
+				sizeof(fw_params->pcm_params));
+		memcpy(&get_params->codec_params.sparams,
+				&fw_params->codec_params,
+				sizeof(fw_params->codec_params));
+		get_params->codec_params.result = 0;
+		get_params->codec_params.stream_id = str_id;
+		get_params->codec_params.codec = str_info->codec;
+		get_params->codec_params.ops = str_info->ops;
+		get_params->codec_params.stream_type = str_info->str_type;
+		kfree(fw_params);
+	} else {
+		pr_debug("sst: Stream is not in the init state\n");
+	}
+	return retval;
+}
+
+/**
+ * sst_set_stream_param - Send msg for setting stream parameters
+ *
+ * @str_id: stream id
+ * @str_param: stream params
+ *
+ * This function sets stream params during runtime
+ */
+int sst_set_stream_param(int str_id, struct snd_sst_params *str_param)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+
+	BUG_ON(!str_param);
+	if (sst_drv_ctx->streams[str_id].ops != str_param->ops) {
+		pr_err("sst: Invalid operation\n");
+		return -EINVAL;
+	}
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	pr_debug("sst: set_stream for %d\n", str_id);
+	str_info =  &sst_drv_ctx->streams[str_id];
+	if (sst_drv_ctx->streams[str_id].status == STREAM_INIT) {
+		if (str_info->ctrl_blk.on == true) {
+			pr_err("sst: control path in use\n");
+			return -EAGAIN;
+		}
+		if (sst_create_large_msg(&msg))
+			return -ENOMEM;
+
+		sst_fill_header(&msg->header,
+				IPC_IA_SET_STREAM_PARAMS, 1, str_id);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		msg->header.part.data = sizeof(u32) +
+				sizeof(str_param->sparams);
+		memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+		memcpy(msg->mailbox_data + sizeof(u32), &str_param->sparams,
+				sizeof(str_param->sparams));
+		spin_lock(&sst_drv_ctx->list_spin_lock);
+		list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock(&sst_drv_ctx->list_spin_lock);
+		sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval < 0) {
+			retval = -EIO;
+			sst_clean_stream(str_info);
+		}
+	} else {
+		retval = -EBADRQC;
+		pr_err("sst: BADQRC for stream\n");
+	}
+	return retval;
+}
+
+/**
+* sst_get_vol - This fuction allows to get the premix gain or gain of a stream
+*
+* @get_vol: this is an output param through which the volume
+*	structure is passed back to user
+*
+* This function is called when the premix gain or stream gain is queried for
+*/
+int sst_get_vol(struct snd_sst_vol *get_vol)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct snd_sst_vol *fw_get_vol;
+	int str_id = get_vol->stream_id;
+
+	pr_debug("sst: get vol called\n");
+
+	if (sst_create_short_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header,
+				IPC_IA_GET_STREAM_VOL, 0, str_id);
+	sst_drv_ctx->vol_info_blk.condition = false;
+	sst_drv_ctx->vol_info_blk.ret_code = 0;
+	sst_drv_ctx->vol_info_blk.on = true;
+	fw_get_vol = kzalloc(sizeof(*fw_get_vol), GFP_ATOMIC);
+	if (!fw_get_vol) {
+		pr_err("sst: mem allocation failed\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+	sst_drv_ctx->vol_info_blk.data = (void *)fw_get_vol;
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+			&sst_drv_ctx->vol_info_blk, SST_BLOCK_TIMEOUT);
+	if (retval)
+		retval = -EIO;
+	else {
+		pr_debug("sst: stream id %d\n", fw_get_vol->stream_id);
+		pr_debug("sst: volume %d\n", fw_get_vol->volume);
+		pr_debug("sst: ramp duration %d\n", fw_get_vol->ramp_duration);
+		pr_debug("sst: ramp_type %d\n", fw_get_vol->ramp_type);
+		memcpy(get_vol, fw_get_vol, sizeof(*fw_get_vol));
+	}
+	return retval;
+}
+
+/**
+* sst_set_vol - This fuction allows to set the premix gain or gain of a stream
+*
+* @set_vol:	this holds the volume structure that needs to be set
+*
+* This function is called when premix gain or stream gain is requested to be set
+*/
+int sst_set_vol(struct snd_sst_vol *set_vol)
+{
+
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+
+	pr_debug("sst: set vol called\n");
+
+	if (sst_create_large_msg(&msg)) {
+		pr_err("sst: message creation failed\n");
+		return -ENOMEM;
+	}
+	sst_fill_header(&msg->header, IPC_IA_SET_STREAM_VOL, 1,
+				set_vol->stream_id);
+
+	msg->header.part.data = sizeof(u32) + sizeof(*set_vol);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), set_vol, sizeof(*set_vol));
+	sst_drv_ctx->vol_info_blk.condition = false;
+	sst_drv_ctx->vol_info_blk.ret_code = 0;
+	sst_drv_ctx->vol_info_blk.on = true;
+	sst_drv_ctx->vol_info_blk.data = set_vol;
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+			&sst_drv_ctx->vol_info_blk, SST_BLOCK_TIMEOUT);
+	if (retval) {
+		pr_err("sst: error in set_vol = %d\n", retval);
+		retval = -EIO;
+	}
+	return retval;
+}
+
+/**
+* sst_set_mute - This fuction sets premix mute or soft mute of a stream
+*
+* @set_mute:	this holds the mute structure that needs to be set
+*
+* This function is called when premix mute or stream mute requested to be set
+*/
+int sst_set_mute(struct snd_sst_mute *set_mute)
+{
+
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+
+	pr_debug("sst: set mute called\n");
+
+	if (sst_create_large_msg(&msg)) {
+		pr_err("sst: message creation failed\n");
+		return -ENOMEM;
+	}
+	sst_fill_header(&msg->header, IPC_IA_SET_STREAM_MUTE, 1,
+				set_mute->stream_id);
+	sst_drv_ctx->mute_info_blk.condition = false;
+	sst_drv_ctx->mute_info_blk.ret_code = 0;
+	sst_drv_ctx->mute_info_blk.on = true;
+	sst_drv_ctx->mute_info_blk.data = set_mute;
+
+	msg->header.part.data = sizeof(u32) + sizeof(*set_mute);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), set_mute,
+			sizeof(*set_mute));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+			&sst_drv_ctx->mute_info_blk, SST_BLOCK_TIMEOUT);
+	if (retval) {
+		pr_err("sst: error in set_mute = %d\n", retval);
+		retval = -EIO;
+	}
+	return retval;
+}
+
+int sst_prepare_target(struct snd_sst_slot_info *slot)
+{
+	if (slot->target_device == SND_SST_TARGET_PMIC
+		&& slot->device_instance == 1) {
+			/*music mode*/
+			if (sst_drv_ctx->pmic_port_instance == 0)
+				sst_drv_ctx->scard_ops->set_voice_port(
+					DEACTIVATE);
+	} else if ((slot->target_device == SND_SST_TARGET_PMIC ||
+			slot->target_device == SND_SST_TARGET_MODEM) &&
+			slot->device_instance == 0) {
+				/*voip mode where pcm0 is active*/
+				if (sst_drv_ctx->pmic_port_instance == 1)
+					sst_drv_ctx->scard_ops->set_audio_port(
+						DEACTIVATE);
+	}
+	return 0;
+}
+
+int sst_activate_target(struct snd_sst_slot_info *slot)
+{
+	if (slot->target_device == SND_SST_TARGET_PMIC &&
+		slot->device_instance == 1) {
+			/*music mode*/
+			sst_drv_ctx->pmic_port_instance = 1;
+			sst_drv_ctx->scard_ops->set_audio_port(ACTIVATE);
+			sst_drv_ctx->scard_ops->set_pcm_audio_params(
+				slot->pcm_params.sfreq,
+				slot->pcm_params.pcm_wd_sz,
+				slot->pcm_params.num_chan);
+			if (sst_drv_ctx->pb_streams)
+				sst_drv_ctx->scard_ops->power_up_pmic_pb(1);
+			if (sst_drv_ctx->cp_streams)
+				sst_drv_ctx->scard_ops->power_up_pmic_cp(1);
+	} else if ((slot->target_device == SND_SST_TARGET_PMIC ||
+			slot->target_device == SND_SST_TARGET_MODEM) &&
+			slot->device_instance == 0) {
+				/*voip mode where pcm0 is active*/
+				sst_drv_ctx->pmic_port_instance = 0;
+				sst_drv_ctx->scard_ops->set_voice_port(
+					ACTIVATE);
+				sst_drv_ctx->scard_ops->power_up_pmic_pb(0);
+				/*sst_drv_ctx->scard_ops->power_up_pmic_cp(0);*/
+	}
+	return 0;
+}
+
+int sst_parse_target(struct snd_sst_slot_info *slot)
+{
+	int retval = 0;
+
+	if (slot->action == SND_SST_PORT_ACTIVATE &&
+		slot->device_type == SND_SST_DEVICE_PCM) {
+			retval = sst_activate_target(slot);
+			if (retval)
+				pr_err("sst: SST_Activate_target_fail\n");
+			else
+				pr_err("sst: SST_Activate_target_pass\n");
+		return retval;
+	} else if (slot->action == SND_SST_PORT_PREPARE &&
+			slot->device_type == SND_SST_DEVICE_PCM) {
+				retval = sst_prepare_target(slot);
+			if (retval)
+				pr_err("sst: SST_prepare_target_fail\n");
+			else
+				pr_err("sst: SST_prepare_target_pass\n");
+			return retval;
+	} else {
+		pr_err("sst: slot_action : %d, device_type: %d\n",
+				slot->action, slot->device_type);
+		return retval;
+	}
+}
+
+int sst_send_target(struct snd_sst_target_device *target)
+{
+	int retval;
+	struct ipc_post *msg;
+
+	if (sst_create_large_msg(&msg)) {
+		pr_err("sst: message creation failed\n");
+		return -ENOMEM;
+	}
+	sst_fill_header(&msg->header, IPC_IA_TARGET_DEV_SELECT, 1, 0);
+	sst_drv_ctx->tgt_dev_blk.condition = false;
+	sst_drv_ctx->tgt_dev_blk.ret_code = 0;
+	sst_drv_ctx->tgt_dev_blk.on = true;
+
+	msg->header.part.data = sizeof(u32) + sizeof(*target);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), target,
+			sizeof(*target));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	pr_debug("sst: message sent- waiting\n");
+	retval = sst_wait_interruptible_timeout(sst_drv_ctx,
+			&sst_drv_ctx->tgt_dev_blk, TARGET_DEV_BLOCK_TIMEOUT);
+	if (retval)
+		pr_err("sst: target device ipc failed = 0x%x\n", retval);
+	return retval;
+
+}
+
+int sst_target_device_validate(struct snd_sst_target_device *target)
+{
+	int retval = 0;
+       int i;
+
+	for (i = 0; i < SST_MAX_TARGET_DEVICES; i++) {
+		if (target->devices[i].device_type == SND_SST_DEVICE_PCM) {
+			/*pcm device, check params*/
+			if (target->devices[i].device_instance == 1) {
+				if ((target->devices[i].device_mode !=
+				SND_SST_DEV_MODE_PCM_MODE4_I2S) &&
+				(target->devices[i].device_mode !=
+				SND_SST_DEV_MODE_PCM_MODE4_RIGHT_JUSTIFIED)
+				&& (target->devices[i].device_mode !=
+				SND_SST_DEV_MODE_PCM_MODE1))
+					goto err;
+			} else if (target->devices[i].device_instance == 0) {
+				if ((target->devices[i].device_mode !=
+						SND_SST_DEV_MODE_PCM_MODE2)
+					&& (target->devices[i].device_mode !=
+						SND_SST_DEV_MODE_PCM_MODE4_I2S)
+					&& (target->devices[i].device_mode !=
+						SND_SST_DEV_MODE_PCM_MODE1))
+					goto err;
+				if (target->devices[i].pcm_params.sfreq != 8000
+				|| target->devices[i].pcm_params.num_chan != 1
+				|| target->devices[i].pcm_params.pcm_wd_sz !=
+									16)
+					goto err;
+			} else {
+err:
+				pr_err("sst: i/p params incorrect\n");
+				return -EINVAL;
+			}
+		}
+	}
+    return retval;
+}
+
+/**
+ * sst_target_device_select - This fuction sets the target device configurations
+ *
+ * @target: this parameter holds the configurations to be set
+ *
+ * This function is called when the user layer wants to change the target
+ * device's configurations
+ */
+
+int sst_target_device_select(struct snd_sst_target_device *target)
+{
+	int retval, i, prepare_count = 0;
+
+	pr_debug("sst: Target Device Select\n");
+
+	if (target->device_route < 0 || target->device_route > 2) {
+		pr_err("sst: device route is invalid\n");
+		return -EINVAL;
+	}
+
+	if (target->device_route != 0) {
+		pr_err("sst: Unsupported config\n");
+		return -EIO;
+	}
+	retval = sst_target_device_validate(target);
+	if (retval)
+		return retval;
+
+	retval = sst_send_target(target);
+	if (retval)
+		return retval;
+	for (i = 0; i < SST_MAX_TARGET_DEVICES; i++) {
+		if (target->devices[i].action == SND_SST_PORT_ACTIVATE) {
+			pr_debug("sst: activate called in %d\n", i);
+			retval = sst_parse_target(&target->devices[i]);
+			if (retval)
+				return retval;
+		} else if (target->devices[i].action == SND_SST_PORT_PREPARE) {
+			pr_debug("sst: PREPARE in %d, Forwading\n", i);
+			retval = sst_parse_target(&target->devices[i]);
+			if (retval) {
+				pr_err("sst: Parse Target fail %d", retval);
+				return retval;
+			}
+			pr_debug("sst: Parse Target successful %d", retval);
+			if (target->devices[i].device_type ==
+						SND_SST_DEVICE_PCM)
+				prepare_count++;
+		}
+	}
+	if (target->devices[0].action == SND_SST_PORT_PREPARE &&
+		prepare_count == 0)
+			sst_drv_ctx->scard_ops->power_down_pmic();
+
+	return retval;
+}
+#ifdef CONFIG_MRST_RAR_HANDLER
+/*This function gets the physical address of the secure memory from the handle*/
+static inline int sst_get_RAR(struct RAR_buffer *buffers, int count)
+{
+	int retval = 0, rar_status = 0;
+
+	rar_status = rar_handle_to_bus(buffers, count);
+
+	if (count != rar_status) {
+		pr_err("sst: The rar CALL Failed");
+		retval = -EIO;
+	}
+	if (buffers->info.type != RAR_TYPE_AUDIO) {
+		pr_err("sst: Invalid RAR type\n");
+		return -EINVAL;
+	}
+	return retval;
+}
+
+#endif
+
+/* This function creates the scatter gather list to be sent to firmware to
+capture/playback data*/
+static int sst_create_sg_list(struct stream_info *stream,
+		struct sst_frame_info *sg_list)
+{
+	struct sst_stream_bufs *kbufs = NULL;
+#ifdef CONFIG_MRST_RAR_HANDLER
+	struct RAR_buffer rar_buffers;
+	int retval = 0;
+#endif
+	int i = 0;
+	list_for_each_entry(kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == false) {
+#ifdef CONFIG_MRST_RAR_HANDLER
+			if (stream->ops == STREAM_OPS_PLAYBACK_DRM) {
+				pr_debug("sst: DRM playback handling\n");
+				rar_buffers.info.handle = (__u32)kbufs->addr;
+				rar_buffers.info.size = kbufs->size;
+				pr_debug("sst: rar handle 0x%x size=0x%x",
+					rar_buffers.info.handle,
+					rar_buffers.info.size);
+				retval =  sst_get_RAR(&rar_buffers, 1);
+
+				if (retval)
+					return retval;
+				sg_list->addr[i].addr = rar_buffers.bus_address;
+				/* rar_buffers.info.size; */
+				sg_list->addr[i].size = (__u32)kbufs->size;
+				pr_debug("sst: phyaddr[%d] 0x%x Size:0x%x\n"
+					, i, sg_list->addr[i].addr,
+					sg_list->addr[i].size);
+			}
+#endif
+			if (stream->ops != STREAM_OPS_PLAYBACK_DRM) {
+				sg_list->addr[i].addr =
+					virt_to_phys((void *)
+						kbufs->addr + kbufs->offset);
+				sg_list->addr[i].size = kbufs->size;
+				pr_debug("sst: phyaddr[%d]:0x%x Size:0x%x\n"
+				, i , sg_list->addr[i].addr, kbufs->size);
+			}
+			stream->curr_bytes += sg_list->addr[i].size;
+			kbufs->in_use = true;
+			i++;
+		}
+		if (i >= MAX_NUM_SCATTER_BUFFERS)
+			break;
+	}
+
+	sg_list->num_entries = i;
+	pr_debug("sst:sg list entries = %d\n", sg_list->num_entries);
+	return i;
+}
+
+
+/**
+ * sst_play_frame - Send msg for sending stream frames
+ *
+ * @str_id:	ID of stream
+ *
+ * This function is called to send data to be played out
+ * to the firmware
+ */
+int sst_play_frame(int str_id)
+{
+	int i = 0, retval = 0;
+	struct ipc_post *msg = NULL;
+	struct sst_frame_info sg_list = {0};
+	struct sst_stream_bufs *kbufs = NULL, *_kbufs;
+	struct stream_info *stream;
+
+	pr_debug("sst: play frame for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+
+	stream = &sst_drv_ctx->streams[str_id];
+	/* clear prev sent buffers */
+	list_for_each_entry_safe(kbufs, _kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == true) {
+			spin_lock(&stream->pcm_lock);
+			list_del(&kbufs->node);
+			spin_unlock(&stream->pcm_lock);
+			kfree(kbufs);
+		}
+	}
+	/* update bytes sent */
+	stream->cumm_bytes += stream->curr_bytes;
+	stream->curr_bytes = 0;
+	if (list_empty(&stream->bufs)) {
+		/* no user buffer available */
+		pr_debug("sst: Null buffer stream status %d\n", stream->status);
+		stream->prev = stream->status;
+		stream->status = STREAM_INIT;
+		pr_debug("sst:new stream status = %d\n", stream->status);
+		if (stream->need_draining == true) {
+			pr_debug("sst:draining stream\n");
+			if (sst_create_short_msg(&msg)) {
+				pr_err("sst: mem alloc failed\n");
+				return -ENOMEM;
+			}
+			sst_fill_header(&msg->header, IPC_IA_DRAIN_STREAM,
+						0, str_id);
+			spin_lock(&sst_drv_ctx->list_spin_lock);
+			list_add_tail(&msg->node,
+					&sst_drv_ctx->ipc_dispatch_list);
+			spin_unlock(&sst_drv_ctx->list_spin_lock);
+			sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+		} else if (stream->data_blk.on == true) {
+			pr_debug("sst:user list empty.. wake\n");
+			/* unblock */
+			stream->data_blk.ret_code = 0;
+			stream->data_blk.condition = true;
+			stream->data_blk.on = false;
+			wake_up(&sst_drv_ctx->wait_queue);
+		}
+		return 0;
+	}
+
+	/* create list */
+	i = sst_create_sg_list(stream, &sg_list);
+
+	/* post msg */
+	if (sst_create_large_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_PLAY_FRAMES, 1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(sg_list);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &sg_list, sizeof(sg_list));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	return 0;
+
+}
+
+/**
+ * sst_capture_frame - Send msg for sending stream frames
+ *
+ * @str_id:	ID of stream
+ *
+ * This function is called to capture data from the firmware
+ */
+int sst_capture_frame(int str_id)
+{
+	int i = 0, retval = 0;
+	struct ipc_post *msg = NULL;
+	struct sst_frame_info sg_list = {0};
+	struct sst_stream_bufs *kbufs = NULL, *_kbufs;
+	struct stream_info *stream;
+
+
+	pr_debug("sst:capture frame for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+	stream = &sst_drv_ctx->streams[str_id];
+	/* clear prev sent buffers */
+	list_for_each_entry_safe(kbufs, _kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == true) {
+			list_del(&kbufs->node);
+			kfree(kbufs);
+			pr_debug("sst:del node\n");
+		}
+	}
+	if (list_empty(&stream->bufs)) {
+		/* no user buffer available */
+		pr_debug("sst:Null buffer!!!!stream status %d\n",
+			       stream->status);
+		stream->prev = stream->status;
+		stream->status = STREAM_INIT;
+		pr_debug("sst:new stream status = %d\n",
+			       stream->status);
+		if (stream->data_blk.on == true) {
+			pr_debug("sst:user list empty.. wake\n");
+			/* unblock */
+			stream->data_blk.ret_code = 0;
+			stream->data_blk.condition = true;
+			stream->data_blk.on = false;
+			wake_up(&sst_drv_ctx->wait_queue);
+
+		}
+		return 0;
+	}
+	/* create new sg list */
+	i = sst_create_sg_list(stream, &sg_list);
+
+	/* post msg */
+	if (sst_create_large_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_CAPT_FRAMES, 1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(sg_list);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &sg_list, sizeof(sg_list));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+
+
+	/*update bytes recevied*/
+	stream->cumm_bytes += stream->curr_bytes;
+	stream->curr_bytes = 0;
+
+    pr_debug("sst:Cum bytes  = %d\n", stream->cumm_bytes);
+	return 0;
+}
+
+/*This function is used to calculate the minimum size of input buffers given*/
+static unsigned int calculate_min_size(struct snd_sst_buffs *bufs)
+{
+	int i, min_val = bufs->buff_entry[0].size;
+	for (i = 1 ; i < bufs->entries; i++) {
+		if (bufs->buff_entry[i].size < min_val)
+			min_val = bufs->buff_entry[i].size;
+	}
+	pr_debug("sst:min_val = %d\n", min_val);
+	return min_val;
+}
+
+static unsigned int calculate_max_size(struct snd_sst_buffs *bufs)
+{
+	int i, max_val = bufs->buff_entry[0].size;
+	for (i = 1 ; i < bufs->entries; i++) {
+		if (bufs->buff_entry[i].size > max_val)
+			max_val = bufs->buff_entry[i].size;
+	}
+	pr_debug("sst:max_val = %d\n", max_val);
+	return max_val;
+}
+
+/*This function is used to allocate input and output buffers to be sent to
+the firmware that will take encoded data and return decoded data*/
+static int sst_allocate_decode_buf(struct stream_info *str_info,
+				struct snd_sst_dbufs *dbufs,
+				unsigned int cum_input_given,
+				unsigned int cum_output_given)
+{
+#ifdef CONFIG_MRST_RAR_HANDLER
+	if (str_info->ops == STREAM_OPS_PLAYBACK_DRM) {
+
+		if (dbufs->ibufs->type == SST_BUF_RAR  &&
+			dbufs->obufs->type == SST_BUF_RAR) {
+			if (dbufs->ibufs->entries == dbufs->obufs->entries)
+				return 0;
+			else {
+				pr_err("sst: RAR entries dont match\n");
+				 return -EINVAL;
+			}
+		} else
+			str_info->decode_osize = cum_output_given;
+		return 0;
+
+	}
+#endif
+	if (!str_info->decode_ibuf) {
+		pr_debug("sst:no i/p buffers, trying full size\n");
+		str_info->decode_isize = cum_input_given;
+		str_info->decode_ibuf = kzalloc(str_info->decode_isize,
+						GFP_KERNEL);
+		str_info->idecode_alloc = str_info->decode_isize;
+	}
+	if (!str_info->decode_ibuf) {
+		pr_debug("sst:buff alloc failed, try max size\n");
+		str_info->decode_isize = calculate_max_size(dbufs->ibufs);
+		str_info->decode_ibuf = kzalloc(
+				str_info->decode_isize, GFP_KERNEL);
+		str_info->idecode_alloc = str_info->decode_isize;
+	}
+	if (!str_info->decode_ibuf) {
+		pr_debug("sst:buff alloc failed, try min size\n");
+		str_info->decode_isize = calculate_min_size(dbufs->ibufs);
+		str_info->decode_ibuf = kzalloc(str_info->decode_isize,
+						GFP_KERNEL);
+		if (!str_info->decode_ibuf) {
+			pr_err("sst: mem allocation failed\n");
+			return -ENOMEM;
+		}
+		str_info->idecode_alloc = str_info->decode_isize;
+	}
+	str_info->decode_osize = cum_output_given;
+	if (str_info->decode_osize > sst_drv_ctx->mmap_len)
+		str_info->decode_osize = sst_drv_ctx->mmap_len;
+	return 0;
+}
+
+/*This function is used to send the message to firmware to decode the data*/
+static int sst_send_decode_mess(int str_id, struct stream_info *str_info,
+				struct snd_sst_decode_info *dec_info)
+{
+	struct ipc_post *msg = NULL;
+	int retval = 0;
+
+	pr_debug("SST DBGsst_set_mute:called\n");
+
+	if (str_info->decode_ibuf_type == SST_BUF_RAR) {
+#ifdef CONFIG_MRST_RAR_HANDLER
+			dec_info->frames_in.addr[0].addr =
+				(unsigned long)str_info->decode_ibuf;
+			dec_info->frames_in.addr[0].size =
+							str_info->decode_isize;
+#endif
+
+	} else {
+		dec_info->frames_in.addr[0].addr = virt_to_phys((void *)
+					str_info->decode_ibuf);
+		dec_info->frames_in.addr[0].size = str_info->decode_isize;
+	}
+
+
+	if (str_info->decode_obuf_type == SST_BUF_RAR) {
+#ifdef CONFIG_MRST_RAR_HANDLER
+		dec_info->frames_out.addr[0].addr =
+				(unsigned long)str_info->decode_obuf;
+		dec_info->frames_out.addr[0].size = str_info->decode_osize;
+#endif
+
+	} else {
+		dec_info->frames_out.addr[0].addr = virt_to_phys((void *)
+						str_info->decode_obuf) ;
+		dec_info->frames_out.addr[0].size = str_info->decode_osize;
+	}
+
+	dec_info->frames_in.num_entries = 1;
+	dec_info->frames_out.num_entries = 1;
+	dec_info->frames_in.rsrvd = 0;
+	dec_info->frames_out.rsrvd = 0;
+	dec_info->input_bytes_consumed = 0;
+	dec_info->output_bytes_produced = 0;
+	if (sst_create_large_msg(&msg)) {
+		pr_err("sst: message creation failed\n");
+		return -ENOMEM;
+	}
+
+	sst_fill_header(&msg->header, IPC_IA_DECODE_FRAMES, 1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(*dec_info);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), dec_info,
+			sizeof(*dec_info));
+	spin_lock(&sst_drv_ctx->list_spin_lock);
+	list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+	spin_unlock(&sst_drv_ctx->list_spin_lock);
+	str_info->data_blk.condition = false;
+	str_info->data_blk.ret_code = 0;
+	str_info->data_blk.on = true;
+	str_info->data_blk.data = dec_info;
+	sst_post_message(&sst_drv_ctx->ipc_post_msg_wq);
+	retval = sst_wait_interruptible(sst_drv_ctx, &str_info->data_blk);
+	return retval;
+}
+
+static int sst_prepare_input_buffers_rar(struct stream_info *str_info,
+			struct snd_sst_dbufs *dbufs,
+			int *input_index, int *in_copied,
+			int *input_index_valid_size, int *new_entry_flag)
+{
+	int retval = 0;
+#ifdef CONFIG_MRST_RAR_HANDLER
+	int i;
+
+	if (str_info->ops == STREAM_OPS_PLAYBACK_DRM) {
+		struct RAR_buffer rar_buffers;
+		__u32 info;
+		retval = copy_from_user((void *) &info,
+				dbufs->ibufs->buff_entry[i].buffer,
+				sizeof(__u32));
+		if (retval) {
+			pr_err("sst:cpy from user fail\n");
+			return -EAGAIN;
+		}
+		rar_buffers.info.type = dbufs->ibufs->type;
+		rar_buffers.info.size = dbufs->ibufs->buff_entry[i].size;
+		rar_buffers.info.handle =  info;
+		pr_debug("rar in DnR(input buffer function)=0x%x size=0x%x",
+				rar_buffers.info.handle,
+				rar_buffers.info.size);
+		retval =  sst_get_RAR(&rar_buffers, 1);
+		if (retval) {
+			pr_debug("SST ERR: RAR API failed\n");
+			return retval;
+		}
+		str_info->decode_ibuf =
+		(void *) ((unsigned long) rar_buffers.bus_address);
+		pr_debug("RAR buf addr in DnR (input buffer function)0x%lu",
+				 (unsigned long) str_info->decode_ibuf);
+		pr_debug("rar in DnR decode funtion/output b_add rar =0x%lu",
+				(unsigned long) rar_buffers.bus_address);
+		*input_index = i + 1;
+		str_info->decode_isize = dbufs->ibufs->buff_entry[i].size;
+		str_info->decode_ibuf_type = dbufs->ibufs->type;
+		*in_copied = str_info->decode_isize;
+	}
+#endif
+	return retval;
+}
+/*This function is used to prepare the kernel input buffers with contents
+before sending for decode*/
+static int sst_prepare_input_buffers(struct stream_info *str_info,
+			struct snd_sst_dbufs *dbufs,
+			int *input_index, int *in_copied,
+			int *input_index_valid_size, int *new_entry_flag)
+{
+	int i, cpy_size, retval = 0;
+
+	pr_debug("sst:input_index = %d, input entries = %d\n",
+			 *input_index, dbufs->ibufs->entries);
+	for (i = *input_index; i < dbufs->ibufs->entries; i++) {
+#ifdef CONFIG_MRST_RAR_HANDLER
+		retval = sst_prepare_input_buffers_rar(str_info,
+			dbufs, input_index, in_copied,
+				input_index_valid_size, new_entry_flag);
+		if (retval) {
+			pr_err("sst: In prepare input buffers for RAR\n");
+			return -EIO;
+		}
+#endif
+		*input_index = i;
+		if (*input_index_valid_size == 0)
+			*input_index_valid_size =
+				dbufs->ibufs->buff_entry[i].size;
+		pr_debug("sst:inout addr = %p, size = %d\n",
+			dbufs->ibufs->buff_entry[i].buffer,
+			*input_index_valid_size);
+		pr_debug("sst:decode_isize = %d, in_copied %d\n",
+			str_info->decode_isize, *in_copied);
+		if (*input_index_valid_size <=
+					(str_info->decode_isize - *in_copied))
+			cpy_size = *input_index_valid_size;
+		else
+			cpy_size = str_info->decode_isize - *in_copied;
+
+		pr_debug("sst:cpy size = %d\n", cpy_size);
+		if (!dbufs->ibufs->buff_entry[i].buffer) {
+			pr_err("sst: i/p buffer is null\n");
+			return -EINVAL;
+		}
+		pr_debug("sst:Try copy To %p, From %p, size %d\n",
+				str_info->decode_ibuf + *in_copied,
+				dbufs->ibufs->buff_entry[i].buffer, cpy_size);
+
+		retval =
+		copy_from_user((void *)(str_info->decode_ibuf + *in_copied),
+				(void *) dbufs->ibufs->buff_entry[i].buffer,
+				cpy_size);
+		if (retval) {
+			pr_err("sst: copy from user failed\n");
+			return -EIO;
+		}
+		*in_copied += cpy_size;
+		*input_index_valid_size -= cpy_size;
+		pr_debug("sst:in buff size = %d, in_copied = %d\n",
+			*input_index_valid_size, *in_copied);
+		if (*input_index_valid_size != 0) {
+			pr_debug("sst:more input buffers left\n");
+			dbufs->ibufs->buff_entry[i].buffer += cpy_size;
+			break;
+		}
+		if (*in_copied == str_info->decode_isize &&
+			*input_index_valid_size == 0 &&
+			(i+1) <= dbufs->ibufs->entries) {
+			pr_debug("sst:all input buffers copied\n");
+			*new_entry_flag = true;
+			*input_index = i + 1;
+			break;
+		}
+	}
+	return retval;
+}
+
+/* This function is used to copy the decoded data from kernel buffers to
+the user output buffers with contents after decode*/
+static int sst_prepare_output_buffers(struct stream_info *str_info,
+			struct snd_sst_dbufs *dbufs,
+			int *output_index, int output_size,
+			int *out_copied)
+
+{
+	int i, cpy_size, retval = 0;
+	pr_debug("sst:output_index = %d, output entries = %d\n",
+				*output_index,
+				dbufs->obufs->entries);
+	for (i = *output_index; i < dbufs->obufs->entries; i++) {
+		*output_index = i;
+		pr_debug("sst:output addr = %p, size = %d\n",
+			dbufs->obufs->buff_entry[i].buffer,
+			dbufs->obufs->buff_entry[i].size);
+		pr_debug("sst:output_size = %d, out_copied = %d\n",
+				output_size, *out_copied);
+		if (dbufs->obufs->buff_entry[i].size <
+				(output_size - *out_copied))
+			cpy_size = dbufs->obufs->buff_entry[i].size;
+		else
+			cpy_size = output_size - *out_copied;
+		pr_debug("sst:cpy size = %d\n", cpy_size);
+		pr_debug("sst:Try copy To: %p, From %p, size %d\n",
+				dbufs->obufs->buff_entry[i].buffer,
+				sst_drv_ctx->mmap_mem + *out_copied,
+				cpy_size);
+		retval = copy_to_user(dbufs->obufs->buff_entry[i].buffer,
+					sst_drv_ctx->mmap_mem + *out_copied,
+					cpy_size);
+		if (retval) {
+			pr_err("sst: copy to user failed\n");
+			return -EIO;
+		} else
+			pr_debug("sst:copy to user passed\n");
+		*out_copied += cpy_size;
+		dbufs->obufs->buff_entry[i].size -= cpy_size;
+		pr_debug("sst:o/p buff size %d, out_copied %d\n",
+			dbufs->obufs->buff_entry[i].size, *out_copied);
+		if (dbufs->obufs->buff_entry[i].size != 0) {
+			*output_index = i;
+			dbufs->obufs->buff_entry[i].buffer += cpy_size;
+			break;
+		} else if (*out_copied == output_size) {
+			*output_index = i + 1;
+			break;
+		}
+	}
+	return retval;
+}
+
+/**
+ * sst_decode - Send msg for decoding frames
+ *
+ * @str_id: ID of stream
+ * @dbufs: param that holds the user input and output buffers and size
+ *
+ * This function is called to decode data from the firmware
+ */
+int sst_decode(int str_id, struct snd_sst_dbufs *dbufs)
+{
+	int retval = 0, i;
+	unsigned long long total_input = 0 , total_output = 0;
+	unsigned int cum_input_given = 0 , cum_output_given = 0;
+	int copy_in_done = false, copy_out_done = false;
+	int input_index = 0, output_index = 0;
+	int input_index_valid_size = 0;
+	int in_copied, out_copied;
+	int new_entry_flag;
+	u64 output_size;
+	struct stream_info *str_info;
+	struct snd_sst_decode_info dec_info;
+	unsigned long long input_bytes, output_bytes;
+
+	sst_drv_ctx->scard_ops->power_down_pmic();
+	pr_debug("sst: Powering_down_PMIC...\n");
+
+	retval = sst_validate_strid(str_id);
+	if (retval)
+		return retval;
+
+	str_info = &sst_drv_ctx->streams[str_id];
+	if (str_info->status != STREAM_INIT) {
+		pr_err("sst: invalid stream state = %d\n",
+			       str_info->status);
+		return -EINVAL;
+	}
+
+	str_info->prev = str_info->status;
+	str_info->status = STREAM_DECODE;
+
+	for (i = 0; i < dbufs->ibufs->entries; i++)
+		cum_input_given += dbufs->ibufs->buff_entry[i].size;
+	for (i = 0; i < dbufs->obufs->entries; i++)
+		cum_output_given += dbufs->obufs->buff_entry[i].size;
+
+	/* input and output buffer allocation */
+	retval =  sst_allocate_decode_buf(str_info, dbufs,
+				cum_input_given, cum_output_given);
+	if (retval) {
+		pr_err("sst: mem allocation failed, abort!!!\n");
+		retval = -ENOMEM;
+		goto finish;
+	}
+
+	str_info->decode_isize = str_info->idecode_alloc;
+	str_info->decode_ibuf_type = dbufs->ibufs->type;
+	str_info->decode_obuf_type = dbufs->obufs->type;
+
+	while ((copy_out_done == false) && (copy_in_done == false)) {
+		in_copied = 0;
+		new_entry_flag = false;
+		retval = sst_prepare_input_buffers(str_info,\
+			dbufs, &input_index, &in_copied,
+			&input_index_valid_size, &new_entry_flag);
+		if (retval) {
+			pr_err("sst: prepare in buffers failed\n");
+			goto finish;
+		}
+
+		if (str_info->ops != STREAM_OPS_PLAYBACK_DRM)
+			str_info->decode_obuf = sst_drv_ctx->mmap_mem;
+
+#ifdef CONFIG_MRST_RAR_HANDLER
+		else {
+			if (dbufs->obufs->type == SST_BUF_RAR) {
+				struct RAR_buffer rar_buffers;
+				__u32 info;
+
+				pr_debug("DRM");
+				retval = copy_from_user((void *) &info,
+						dbufs->obufs->
+						buff_entry[output_index].buffer,
+						sizeof(__u32));
+
+				rar_buffers.info.size = dbufs->obufs->
+					buff_entry[output_index].size;
+				rar_buffers.info.handle =  info;
+				retval =  sst_get_RAR(&rar_buffers, 1);
+				if (retval)
+					return retval;
+
+				str_info->decode_obuf = (void *)((unsigned long)
+						rar_buffers.bus_address);
+				str_info->decode_osize = dbufs->obufs->
+					buff_entry[output_index].size;
+				str_info->decode_obuf_type = dbufs->obufs->type;
+				pr_debug("sst:DRM handling\n");
+				pr_debug("o/p_add=0x%lu Size=0x%x",
+					(unsigned long) str_info->decode_obuf,
+					str_info->decode_osize);
+			} else {
+				str_info->decode_obuf = sst_drv_ctx->mmap_mem;
+				str_info->decode_osize = dbufs->obufs->
+					buff_entry[output_index].size;
+
+			}
+		}
+#endif
+		if (str_info->ops != STREAM_OPS_PLAYBACK_DRM) {
+			if (str_info->decode_isize > in_copied) {
+				str_info->decode_isize = in_copied;
+				pr_debug("sst:i/p size = %d\n",
+						str_info->decode_isize);
+			}
+		}
+
+
+		retval = sst_send_decode_mess(str_id, str_info, &dec_info);
+		if (retval || dec_info.input_bytes_consumed == 0) {
+			pr_err(
+				"SST ERR: mess failed or no input consumed\n");
+			goto finish;
+		}
+		input_bytes = dec_info.input_bytes_consumed;
+		output_bytes = dec_info.output_bytes_produced;
+
+		pr_debug("sst:in_copied=%d, con=%lld, prod=%lld\n",
+			in_copied, input_bytes, output_bytes);
+		if (dbufs->obufs->type == SST_BUF_RAR) {
+			output_index += 1;
+			if (output_index == dbufs->obufs->entries) {
+				copy_in_done = true;
+				pr_debug("sst:all i/p cpy done\n");
+			}
+			total_output += output_bytes;
+		} else {
+			out_copied = 0;
+			output_size = output_bytes;
+			retval = sst_prepare_output_buffers(str_info, dbufs,
+				&output_index, output_size, &out_copied);
+			if (retval) {
+				pr_err("sst:prep out buff fail\n");
+				goto finish;
+			}
+			if (str_info->ops != STREAM_OPS_PLAYBACK_DRM) {
+				if (in_copied != input_bytes) {
+					int bytes_left = in_copied -
+								input_bytes;
+					pr_debug("sst:bytes %d\n",
+							bytes_left);
+					if (new_entry_flag == true)
+						input_index--;
+					while (bytes_left) {
+						struct snd_sst_buffs *ibufs;
+						struct snd_sst_buff_entry
+								*buff_entry;
+						unsigned int size_sent;
+
+						ibufs = dbufs->ibufs;
+						buff_entry =
+						&ibufs->buff_entry[input_index];
+						size_sent = buff_entry->size -\
+							input_index_valid_size;
+						if (bytes_left == size_sent) {
+								bytes_left = 0;
+						} else if (bytes_left <
+								size_sent) {
+							buff_entry->buffer +=
+							 (size_sent -
+								bytes_left);
+							buff_entry->size -=
+							 (size_sent -
+								bytes_left);
+							bytes_left = 0;
+						} else {
+							bytes_left -= size_sent;
+							input_index--;
+							input_index_valid_size =
+									0;
+						}
+					}
+
+				}
+			}
+
+			total_output += out_copied;
+			if (str_info->decode_osize != out_copied) {
+				str_info->decode_osize -= out_copied;
+				pr_debug("sst:output size modified = %d\n",
+						str_info->decode_osize);
+			}
+		}
+		total_input += input_bytes;
+
+		if (str_info->ops == STREAM_OPS_PLAYBACK_DRM) {
+			if (total_input == cum_input_given)
+				copy_in_done = true;
+			copy_out_done = true;
+
+		} else {
+			if (total_output == cum_output_given) {
+				copy_out_done = true;
+				pr_debug("sst:all o/p cpy done\n");
+			}
+
+			if (total_input == cum_input_given) {
+				copy_in_done = true;
+				pr_debug("sst:all i/p cpy done\n");
+			}
+		}
+
+		pr_debug("sst:copy_out = %d, copy_in = %d\n",
+				copy_out_done, copy_in_done);
+	}
+
+finish:
+	dbufs->input_bytes_consumed = total_input;
+	dbufs->output_bytes_produced = total_output;
+	str_info->status = str_info->prev;
+	str_info->prev = STREAM_DECODE;
+	str_info->decode_ibuf = NULL;
+	kfree(str_info->decode_ibuf);
+	return retval;
+}
diff --git a/drivers/staging/intel_sst/intelmid.c b/drivers/staging/intel_sst/intelmid.c
new file mode 100644
index 0000000..63138b3
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid.c
@@ -0,0 +1,1233 @@
+/*
+ *   intelmid.c - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Harsha Priya <priya.harsha@intel.com>
+ *		Vinod Koul <vinod.koul@intel.com>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * ALSA driver for Intel MID sound card chipset
+ */
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <sound/control.h>
+#include <asm/mrst.h>
+#include <sound/pcm.h>
+#include "jack.h"
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intelmid_snd_control.h"
+#include "intelmid.h"
+
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_AUTHOR("Dharageswari R <dharageswari.r@intel.com>");
+MODULE_AUTHOR("KP Jeeja <jeeja.kp@intel.com>");
+MODULE_DESCRIPTION("Intel MAD Sound card driver");
+MODULE_LICENSE("GPL v2");
+MODULE_SUPPORTED_DEVICE("{Intel,Intel_MAD}");
+
+
+static int card_index = SNDRV_DEFAULT_IDX1;/* Index 0-MAX */
+static char *card_id = SNDRV_DEFAULT_STR1;	/* ID for this card */
+
+module_param(card_index, int, 0444);
+MODULE_PARM_DESC(card_index, "Index value for INTELMAD soundcard.");
+module_param(card_id, charp, 0444);
+MODULE_PARM_DESC(card_id, "ID string for INTELMAD soundcard.");
+
+int	sst_card_vendor_id;
+int intelmid_audio_interrupt_enable;/*checkpatch fix*/
+
+/* Data path functionalities */
+static struct snd_pcm_hardware snd_intelmad_stream = {
+	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_DOUBLE |
+			SNDRV_PCM_INFO_PAUSE |
+			SNDRV_PCM_INFO_RESUME |
+			SNDRV_PCM_INFO_MMAP|
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_SYNC_START),
+	.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
+			SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
+	.rates = (SNDRV_PCM_RATE_8000|
+			SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000),
+	.rate_min = MIN_RATE,
+
+	.rate_max = MAX_RATE,
+	.channels_min =	MIN_CHANNEL,
+	.channels_max =	MAX_CHANNEL_AMIC,
+	.buffer_bytes_max = MAX_BUFFER,
+	.period_bytes_min = MIN_PERIOD_BYTES,
+	.period_bytes_max = MAX_PERIOD_BYTES,
+	.periods_min = MIN_PERIODS,
+	.periods_max = MAX_PERIODS,
+	.fifo_size = FIFO_SIZE,
+};
+
+
+/**
+ * snd_intelmad_pcm_trigger - stream activities are handled here
+ *
+ * @substream:substream for which the stream function is called
+ * @cmd:the stream commamd that requested from upper layer
+ *
+ * This function is called whenever an a stream activity is invoked
+ */
+static int snd_intelmad_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	int ret_val = 0;
+	struct snd_intelmad *intelmaddata;
+	struct mad_stream_pvt *stream;
+	/*struct stream_buffer buffer_to_sst;*/
+
+
+
+	WARN_ON(!substream);
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+	stream = substream->runtime->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+	WARN_ON(!intelmaddata->sstdrv_ops->scard_ops);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		pr_debug("sst: Trigger Start\n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_START,
+				&stream->stream_info.str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = RUNNING;
+		stream->substream = substream;
+		stream->stream_status = RUNNING;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		pr_debug("sst: in stop\n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_DROP,
+				&stream->stream_info.str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = DROPPED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		pr_debug("sst: in pause\n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_PAUSE,
+				&stream->stream_info.str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = PAUSED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		pr_debug("sst: in pause release\n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_RESUME,
+						&stream->stream_info.str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = RUNNING;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return ret_val;
+}
+
+/**
+* snd_intelmad_pcm_prepare- internal preparation before starting a stream
+*
+* @substream:  substream for which the function is called
+*
+* This function is called when a stream is started for internal preparation.
+*/
+static int snd_intelmad_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct mad_stream_pvt *stream;
+	int ret_val = 0;
+	struct snd_intelmad *intelmaddata;
+
+	pr_debug("sst: pcm_prepare called\n");
+
+	WARN_ON(!substream);
+	stream = substream->runtime->private_data;
+	intelmaddata = snd_pcm_substream_chip(substream);
+	pr_debug("sst: pb cnt = %d cap cnt = %d\n",\
+		intelmaddata->playback_cnt,
+		intelmaddata->capture_cnt);
+
+	if (stream->stream_info.str_id) {
+		pr_debug("sst: Prepare called for already set stream\n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_DROP,
+					&stream->stream_info.str_id);
+		return ret_val;
+	}
+
+	 ret_val = snd_intelmad_alloc_stream(substream);
+	if (ret_val < 0)
+		return ret_val;
+	stream->dbg_cum_bytes = 0;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			intelmaddata->playback_cnt++;
+	else
+		intelmaddata->capture_cnt++;
+	/* return back the stream id */
+	snprintf(substream->pcm->id, sizeof(substream->pcm->id),
+			"%d", stream->stream_info.str_id);
+	pr_debug("sst: stream id to user = %s\n",
+			substream->pcm->id);
+
+	ret_val = snd_intelmad_init_stream(substream);
+	if (ret_val)
+		return ret_val;
+	substream->runtime->hw.info = SNDRV_PCM_INFO_BLOCK_TRANSFER;
+	return ret_val;
+}
+
+static int snd_intelmad_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+{
+	int ret_val;
+
+	pr_debug("sst: snd_intelmad_hw_params called\n");
+	ret_val = snd_pcm_lib_malloc_pages(substream,
+			params_buffer_bytes(hw_params));
+	memset(substream->runtime->dma_area, 0,
+			params_buffer_bytes(hw_params));
+
+	return ret_val;
+}
+
+static int snd_intelmad_hw_free(struct snd_pcm_substream *substream)
+{
+	pr_debug("sst: snd_intelmad_hw_free called\n");
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/**
+ * snd_intelmad_pcm_pointer- to send the current buffer pointer processed by hw
+ *
+ * @substream:  substream for which the function is called
+ *
+ * This function is called by ALSA framework to get the current hw buffer ptr
+ * when a period is elapsed
+ */
+static snd_pcm_uframes_t snd_intelmad_pcm_pointer
+			(struct snd_pcm_substream *substream)
+{
+	/* struct snd_pcm_runtime *runtime = substream->runtime; */
+	struct mad_stream_pvt *stream;
+	struct snd_intelmad *intelmaddata;
+	int ret_val;
+
+	WARN_ON(!substream);
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+	stream = substream->runtime->private_data;
+	if (stream->stream_status == INIT)
+		return 0;
+
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_BUFFER_POINTER,
+				&stream->stream_info);
+	if (ret_val) {
+		pr_err("sst: error code = 0x%x\n", ret_val);
+		return ret_val;
+	}
+	pr_debug("sst: samples reported out 0x%llx\n",
+			stream->stream_info.buffer_ptr);
+	pr_debug("sst: Frame bits:: %d period_count :: %d\n",
+			(int)substream->runtime->frame_bits,
+			(int)substream->runtime->period_size);
+
+	return stream->stream_info.buffer_ptr;
+
+}
+
+/**
+ * snd_intelmad_close- to free parameteres when stream is stopped
+ *
+ * @substream:  substream for which the function is called
+ *
+ * This function is called by ALSA framework when stream is stopped
+ */
+static int snd_intelmad_close(struct snd_pcm_substream *substream)
+{
+	struct snd_intelmad *intelmaddata;
+	struct mad_stream_pvt *stream;
+	int ret_val = 0;
+
+	WARN_ON(!substream);
+
+	stream = substream->runtime->private_data;
+
+	pr_debug("sst: snd_intelmad_close called\n");
+	intelmaddata = snd_pcm_substream_chip(substream);
+
+	pr_debug("sst: str id = %d\n", stream->stream_info.str_id);
+	if (stream->stream_info.str_id) {
+		/* SST API to actually stop/free the stream */
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_FREE,
+				&stream->stream_info.str_id);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			intelmaddata->playback_cnt--;
+		else
+			intelmaddata->capture_cnt--;
+	}
+	pr_debug("sst: snd_intelmad_close : pb cnt = %d cap cnt = %d\n",
+		intelmaddata->playback_cnt, intelmaddata->capture_cnt);
+	kfree(substream->runtime->private_data);
+	return ret_val;
+}
+
+/**
+ * snd_intelmad_open- to set runtime parameters during stream start
+ *
+ * @substream:  substream for which the function is called
+ * @type: audio device type
+ *
+ * This function is called by ALSA framework when stream is started
+ */
+static int snd_intelmad_open(struct snd_pcm_substream *substream,
+			enum snd_sst_audio_device_type type)
+{
+	struct snd_intelmad *intelmaddata;
+	struct snd_pcm_runtime *runtime;
+	struct mad_stream_pvt *stream;
+
+	WARN_ON(!substream);
+
+	pr_debug("sst: snd_intelmad_open called\n");
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+	runtime = substream->runtime;
+	/* set the runtime hw parameter with local snd_pcm_hardware struct */
+	runtime->hw = snd_intelmad_stream;
+	if (intelmaddata->cpu_id == CPU_CHIP_PENWELL) {
+		runtime->hw = snd_intelmad_stream;
+		runtime->hw.rates = SNDRV_PCM_RATE_48000;
+		runtime->hw.rate_min = MAX_RATE;
+		runtime->hw.formats = (SNDRV_PCM_FMTBIT_S24 |
+						SNDRV_PCM_FMTBIT_U24);
+		if (intelmaddata->sstdrv_ops->scard_ops->input_dev_id == AMIC)
+			runtime->hw.channels_max = MAX_CHANNEL_AMIC;
+		else
+			runtime->hw.channels_max = MAX_CHANNEL_DMIC;
+
+	}
+	/* setup the internal datastruture stream pointers based on it being
+	playback or capture stream */
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+	stream->stream_info.str_id = 0;
+	stream->device = type;
+	stream->stream_status = INIT;
+	runtime->private_data = stream;
+	return snd_pcm_hw_constraint_integer(runtime,
+			 SNDRV_PCM_HW_PARAM_PERIODS);
+}
+
+static int snd_intelmad_headset_open(struct snd_pcm_substream *substream)
+{
+	return snd_intelmad_open(substream, SND_SST_DEVICE_HEADSET);
+}
+
+static int snd_intelmad_ihf_open(struct snd_pcm_substream *substream)
+{
+	return snd_intelmad_open(substream, SND_SST_DEVICE_IHF);
+}
+
+static int snd_intelmad_vibra_open(struct snd_pcm_substream *substream)
+{
+	return snd_intelmad_open(substream, SND_SST_DEVICE_VIBRA);
+}
+
+static int snd_intelmad_haptic_open(struct snd_pcm_substream *substream)
+{
+	return snd_intelmad_open(substream, SND_SST_DEVICE_HAPTIC);
+}
+
+static struct snd_pcm_ops snd_intelmad_headset_ops = {
+	.open = snd_intelmad_headset_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+};
+
+static struct snd_pcm_ops snd_intelmad_ihf_ops = {
+	.open = snd_intelmad_ihf_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+};
+
+static struct snd_pcm_ops snd_intelmad_vibra_ops = {
+	.open = snd_intelmad_vibra_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+};
+
+static struct snd_pcm_ops snd_intelmad_haptic_ops = {
+	.open = snd_intelmad_haptic_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+};
+
+static struct snd_pcm_ops snd_intelmad_capture_ops = {
+	.open = snd_intelmad_headset_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+};
+
+
+/**
+ * snd_intelmad_intr_handler- interrupt handler
+ *
+ * @irq :  irq number of the interrupt received
+ * @dev: device context
+ *
+ * This function is called when an interrupt is raised at the sound card
+ */
+static irqreturn_t snd_intelmad_intr_handler(int irq, void *dev)
+{
+	struct snd_intelmad *intelmaddata =
+			(struct snd_intelmad *)dev;
+	u8 intsts;
+
+	memcpy_fromio(&intsts,
+			((void *)(intelmaddata->int_base)),
+			sizeof(u8));
+	intelmaddata->mad_jack_msg.intsts = intsts;
+	intelmaddata->mad_jack_msg.intelmaddata = intelmaddata;
+
+	queue_work(intelmaddata->mad_jack_wq, &intelmaddata->mad_jack_msg.wq);
+
+	return IRQ_HANDLED;
+}
+
+void sst_mad_send_jack_report(struct snd_jack *jack,
+				int buttonpressevent , int status)
+{
+
+	if (!jack) {
+		pr_debug("sst: MAD error jack empty\n");
+
+	} else {
+		pr_debug("sst: MAD send jack report for = %d!!!\n", status);
+		pr_debug("sst: MAD send jack report %d\n", jack->type);
+		snd_jack_report(jack, status);
+
+		/*button pressed and released */
+		if (buttonpressevent)
+			snd_jack_report(jack, 0);
+		pr_debug("sst: MAD sending jack report Done !!!\n");
+	}
+
+
+
+}
+
+void sst_mad_jackdetection_fs(u8 intsts , struct snd_intelmad *intelmaddata)
+{
+	struct snd_jack *jack = NULL;
+	unsigned int present = 0, jack_event_flag = 0, buttonpressflag = 0;
+	struct sc_reg_access sc_access[] = {
+				{0x187, 0x00, MASK7},
+				{0x188, 0x10, MASK4},
+				{0x18b, 0x10, MASK4},
+	};
+
+	struct sc_reg_access sc_access_write[] = {
+				{0x198, 0x00, 0x0},
+	};
+
+	if (intsts & 0x4) {
+
+		if (!(intelmid_audio_interrupt_enable)) {
+			pr_debug("sst: Audio interrupt enable\n");
+			sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 3);
+
+			sst_sc_reg_access(sc_access_write, PMIC_WRITE, 1);
+			intelmid_audio_interrupt_enable = 1;
+			intelmaddata->jack[0].jack_status = 0;
+			intelmaddata->jack[1].jack_status = 0;
+
+		}
+		/* send headphone detect */
+		pr_debug("sst: MAD headphone %d\n", intsts & 0x4);
+		jack = &intelmaddata->jack[0].jack;
+		present = !(intelmaddata->jack[0].jack_status);
+		intelmaddata->jack[0].jack_status = present;
+		jack_event_flag = 1;
+
+	}
+
+	if (intsts & 0x2) {
+		/* send short push */
+		pr_debug("sst: MAD short push %d\n", intsts & 0x2);
+		jack = &intelmaddata->jack[2].jack;
+		present = 1;
+		jack_event_flag = 1;
+		buttonpressflag = 1;
+	}
+	if (intsts & 0x1) {
+		/* send long push */
+		pr_debug("sst: MAD long push %d\n", intsts & 0x1);
+		jack = &intelmaddata->jack[3].jack;
+		present = 1;
+		jack_event_flag = 1;
+		buttonpressflag = 1;
+	}
+	if (intsts & 0x8) {
+		if (!(intelmid_audio_interrupt_enable)) {
+			pr_debug("sst: Audio interrupt enable\n");
+			sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 3);
+
+			sst_sc_reg_access(sc_access_write, PMIC_WRITE, 1);
+			intelmid_audio_interrupt_enable = 1;
+			intelmaddata->jack[0].jack_status = 0;
+			intelmaddata->jack[1].jack_status = 0;
+		}
+		/* send headset detect */
+		pr_debug("sst: MAD headset = %d\n", intsts & 0x8);
+		jack = &intelmaddata->jack[1].jack;
+		present = !(intelmaddata->jack[1].jack_status);
+		intelmaddata->jack[1].jack_status = present;
+		jack_event_flag = 1;
+	}
+
+	if (jack_event_flag)
+		sst_mad_send_jack_report(jack, buttonpressflag, present);
+}
+
+
+void sst_mad_jackdetection_mx(u8 intsts, struct snd_intelmad *intelmaddata)
+{
+	u8 value = 0, jack_prev_state = 0;
+	struct snd_jack *jack = NULL;
+	unsigned int present = 0, jack_event_flag = 0, buttonpressflag = 0;
+	time_t  timediff;
+	struct sc_reg_access sc_access_read = {0,};
+	struct snd_pmic_ops *scard_ops;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	pr_debug("sst: previous value: %x\n", intelmaddata->jack_prev_state);
+
+	if (!(intelmid_audio_interrupt_enable)) {
+		pr_debug("sst: Audio interrupt enable\n");
+		intelmaddata->jack_prev_state = 0xC0;
+		intelmid_audio_interrupt_enable = 1;
+	}
+
+	if (intsts & 0x2) {
+		jack_prev_state = intelmaddata->jack_prev_state;
+		if (intelmaddata->pmic_status == PMIC_INIT) {
+			sc_access_read.reg_addr = 0x201;
+			sst_sc_reg_access(&sc_access_read, PMIC_READ, 1);
+			value = (sc_access_read.value);
+			pr_debug("sst: value returned = 0x%x\n", value);
+		}
+
+		if (jack_prev_state == 0xc0 && value == 0x40) {
+			/*headset detected. */
+			pr_debug("sst: MAD headset inserted\n");
+			jack = &intelmaddata->jack[1].jack;
+			present = 1;
+			jack_event_flag = 1;
+			intelmaddata->jack[1].jack_status = 1;
+
+		}
+
+		if (jack_prev_state == 0xc0 && value == 0x00) {
+			/* headphone  detected. */
+			pr_debug("sst: MAD headphone inserted\n");
+			jack = &intelmaddata->jack[0].jack;
+			present = 1;
+			jack_event_flag = 1;
+
+		}
+
+		if (jack_prev_state == 0x40 && value == 0xc0) {
+			/*headset  removed*/
+			pr_debug("sst: Jack headset status %d\n",
+				intelmaddata->jack[1].jack_status);
+			pr_debug("sst: MAD headset removed\n");
+			jack = &intelmaddata->jack[1].jack;
+			present = 0;
+			jack_event_flag = 1;
+			intelmaddata->jack[1].jack_status = 0;
+		}
+
+		if (jack_prev_state == 0x00 && value == 0xc0) {
+			/* headphone  detected. */
+			pr_debug("sst: Jack headphone status %d\n",
+					intelmaddata->jack[0].jack_status);
+			pr_debug("sst: headphone removed\n");
+			jack = &intelmaddata->jack[0].jack;
+			present = 0;
+			jack_event_flag = 1;
+		}
+
+		if (jack_prev_state == 0x40 && value == 0x00) {
+			/*button pressed*/
+			do_gettimeofday(&intelmaddata->jack[1].buttonpressed);
+			pr_debug("sst: MAD button press detected n");
+		}
+
+
+		if (jack_prev_state == 0x00 && value == 0x40) {
+			if (intelmaddata->jack[1].jack_status) {
+				/*button pressed*/
+				do_gettimeofday(
+					&intelmaddata->jack[1].buttonreleased);
+				/*button pressed */
+				pr_debug("sst: Button Released detected\n");
+				timediff = intelmaddata->jack[1].
+					buttonreleased.tv_sec - intelmaddata->
+					jack[1].buttonpressed.tv_sec;
+				buttonpressflag = 1;
+				if (timediff > 1) {
+					pr_debug("sst: long press detected\n");
+					/* send headphone detect/undetect */
+					jack = &intelmaddata->jack[3].jack;
+					present = 1;
+					jack_event_flag = 1;
+				}	else	{
+					pr_debug("sst: short press detected\n");
+					/* send headphone detect/undetect */
+					jack = &intelmaddata->jack[2].jack;
+					present = 1;
+					jack_event_flag = 1;
+				}
+			}
+
+		}
+		intelmaddata->jack_prev_state  = value ;
+
+	}
+	if (is_aava() && jack) {
+		if (present) {
+			pr_debug("sst: Jack... YES\n");
+			scard_ops->set_output_dev(STEREO_HEADPHONE);
+
+		} else {
+			pr_debug("sst: Jack... NO\n");
+			scard_ops->set_output_dev(INTERNAL_SPKR);
+
+		}
+	}
+
+	if (jack_event_flag)
+		sst_mad_send_jack_report(jack, buttonpressflag, present);
+}
+
+
+void sst_mad_jackdetection_nec(u8 intsts, struct snd_intelmad *intelmaddata)
+{
+	u8 value = 0;
+	struct snd_jack *jack = NULL;
+	unsigned int present = 0, jack_event_flag = 0, buttonpressflag = 0;
+	struct sc_reg_access sc_access_read = {0,};
+
+	if (intelmaddata->pmic_status == PMIC_INIT) {
+		sc_access_read.reg_addr = 0x132;
+		sst_sc_reg_access(&sc_access_read, PMIC_READ, 1);
+		value = (sc_access_read.value);
+		pr_debug("sst: value returned = 0x%x\n", value);
+	}
+	if (intsts & 0x1) {
+		pr_debug("sst: headset detected\n");
+		/* send headset detect/undetect */
+		jack = &intelmaddata->jack[1].jack;
+		present = (value == 0x1) ? 1 : 0;
+		jack_event_flag = 1;
+	}
+	if (intsts & 0x2) {
+		pr_debug("sst: headphone detected\n");
+		/* send headphone detect/undetect */
+		jack = &intelmaddata->jack[0].jack;
+		present = (value == 0x2) ? 1 : 0;
+		jack_event_flag = 1;
+	}
+	if (intsts & 0x4) {
+		pr_debug("sst: short push detected\n");
+		/* send short push */
+		jack = &intelmaddata->jack[2].jack;
+		present = 1;
+		jack_event_flag = 1;
+		buttonpressflag = 1;
+	}
+	if (intsts & 0x8) {
+		pr_debug("sst: long push detected\n");
+		/* send long push */
+		jack = &intelmaddata->jack[3].jack;
+		present = 1;
+		jack_event_flag = 1;
+		buttonpressflag = 1;
+	}
+
+	if (jack_event_flag)
+		sst_mad_send_jack_report(jack, buttonpressflag, present);
+
+
+}
+
+void sst_process_mad_jack_detection(struct work_struct *work)
+{
+	u8 intsts;
+	struct mad_jack_msg_wq *mad_jack_detect =
+			container_of(work, struct mad_jack_msg_wq, wq);
+
+	struct snd_intelmad *intelmaddata =
+			mad_jack_detect->intelmaddata;
+
+	intsts = mad_jack_detect->intsts;
+
+	switch (intelmaddata->sstdrv_ops->vendor_id) {
+	case SND_FS:
+		sst_mad_jackdetection_fs(intsts , intelmaddata);
+		break;
+	case SND_MX:
+		sst_mad_jackdetection_mx(intsts , intelmaddata);
+		break;
+	case SND_NC:
+		sst_mad_jackdetection_nec(intsts , intelmaddata);
+		break;
+	}
+}
+
+
+static int __devinit snd_intelmad_register_irq(
+					struct snd_intelmad *intelmaddata)
+{
+	int ret_val;
+	u32 regbase = AUDINT_BASE, regsize = 8;
+	char *drv_name;
+
+	pr_debug("sst: irq reg done, regbase 0x%x, regsize 0x%x\n",
+					regbase, regsize);
+	intelmaddata->int_base = ioremap_nocache(regbase, regsize);
+	if (!intelmaddata->int_base)
+		pr_err("sst: Mapping of cache failed\n");
+	pr_debug("sst: irq = 0x%x\n", intelmaddata->irq);
+	if (intelmaddata->cpu_id == CPU_CHIP_PENWELL)
+		drv_name = DRIVER_NAME_MFLD;
+	else
+		drv_name = DRIVER_NAME_MRST;
+	ret_val = request_irq(intelmaddata->irq,
+				snd_intelmad_intr_handler,
+				IRQF_SHARED, drv_name,
+				intelmaddata);
+	if (ret_val)
+		pr_err("sst: cannot register IRQ\n");
+	return ret_val;
+}
+
+static int __devinit snd_intelmad_sst_register(
+			struct snd_intelmad *intelmaddata)
+{
+	int ret_val = 0;
+	struct snd_pmic_ops *intelmad_vendor_ops[MAX_VENDORS] = {
+		&snd_pmic_ops_fs,
+		&snd_pmic_ops_mx,
+		&snd_pmic_ops_nc,
+		&snd_msic_ops
+	};
+
+	struct sc_reg_access vendor_addr = {0x00, 0x00, 0x00};
+
+	if (intelmaddata->cpu_id == CPU_CHIP_LINCROFT) {
+		ret_val = sst_sc_reg_access(&vendor_addr, PMIC_READ, 1);
+		if (ret_val)
+			return ret_val;
+		sst_card_vendor_id = (vendor_addr.value & (MASK2|MASK1|MASK0));
+		pr_debug("sst: orginal n extrated vendor id = 0x%x %d\n",
+				vendor_addr.value, sst_card_vendor_id);
+		if (sst_card_vendor_id < 0 || sst_card_vendor_id > 2) {
+			pr_err("sst: vendor card not supported!!\n");
+			return -EIO;
+		}
+	} else
+		sst_card_vendor_id = 0x3;
+
+	intelmaddata->sstdrv_ops->module_name = SST_CARD_NAMES;
+	intelmaddata->sstdrv_ops->vendor_id = sst_card_vendor_id;
+	BUG_ON(!intelmad_vendor_ops[sst_card_vendor_id]);
+	intelmaddata->sstdrv_ops->scard_ops =
+			intelmad_vendor_ops[sst_card_vendor_id];
+
+	if (intelmaddata->cpu_id == CPU_CHIP_PENWELL) {
+		intelmaddata->sstdrv_ops->scard_ops->pb_on = 0;
+		intelmaddata->sstdrv_ops->scard_ops->cap_on = 0;
+		intelmaddata->sstdrv_ops->scard_ops->input_dev_id = DMIC;
+		intelmaddata->sstdrv_ops->scard_ops->output_dev_id =
+							STEREO_HEADPHONE;
+	}
+
+	/* registering with SST driver to get access to SST APIs to use */
+	ret_val = register_sst_card(intelmaddata->sstdrv_ops);
+	if (ret_val) {
+		pr_err("sst: sst card registration failed\n");
+		return ret_val;
+	}
+
+	sst_card_vendor_id = intelmaddata->sstdrv_ops->vendor_id;
+	intelmaddata->pmic_status = PMIC_UNINIT;
+	return ret_val;
+}
+
+/* Driver Init/exit functionalities */
+/**
+ * snd_intelmad_pcm_new - to setup pcm for the card
+ *
+ * @card:  pointer to the sound card structure
+ * @intelmaddata: pointer to internal context
+ * @pb: playback count for this card
+ * @cap: capture count for this card
+ * @index: device index
+ *
+ * This function is called from probe function to set up pcm params
+ * and functions
+ */
+static int __devinit snd_intelmad_pcm_new(struct snd_card *card,
+			struct snd_intelmad *intelmaddata,
+			unsigned int pb, unsigned int cap, unsigned int index)
+{
+	int ret_val = 0;
+	struct snd_pcm *pcm;
+	char name[32] = INTEL_MAD;
+	struct snd_pcm_ops *pb_ops = NULL, *cap_ops = NULL;
+
+	pr_debug("sst: called for pb %d, cp %d, idx %d\n", pb, cap, index);
+	ret_val = snd_pcm_new(card, name, index, pb, cap, &pcm);
+	if (ret_val)
+		return ret_val;
+	/* setup the ops for playback and capture streams */
+	switch (index) {
+	case 0:
+		pb_ops = &snd_intelmad_headset_ops;
+		cap_ops = &snd_intelmad_capture_ops;
+		break;
+	case 1:
+		pb_ops = &snd_intelmad_ihf_ops;
+		cap_ops = &snd_intelmad_capture_ops;
+		break;
+	case 2:
+		pb_ops = &snd_intelmad_vibra_ops;
+		cap_ops = &snd_intelmad_capture_ops;
+		break;
+	case 3:
+		pb_ops = &snd_intelmad_haptic_ops;
+		cap_ops = &snd_intelmad_capture_ops;
+		break;
+	}
+	if (pb)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, pb_ops);
+	if (cap)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, cap_ops);
+	/* setup private data which can be retrieved when required */
+	pcm->private_data = intelmaddata;
+	pcm->info_flags = 0;
+	strncpy(pcm->name, card->shortname, strlen(card->shortname));
+	/* allocate dma pages for ALSA stream operations */
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL),
+			MIN_BUFFER, MAX_BUFFER);
+	return ret_val;
+}
+
+static int __devinit snd_intelmad_pcm(struct snd_card *card,
+				struct snd_intelmad *intelmaddata)
+{
+	int ret_val = 0;
+
+	WARN_ON(!card);
+	WARN_ON(!intelmaddata);
+	pr_debug("sst: snd_intelmad_pcm called\n");
+	ret_val = snd_intelmad_pcm_new(card, intelmaddata, 1, 1, 0);
+	if (intelmaddata->cpu_id == CPU_CHIP_LINCROFT)
+		return ret_val;
+	ret_val = snd_intelmad_pcm_new(card, intelmaddata, 1, 0, 1);
+	if (ret_val)
+		return ret_val;
+	ret_val = snd_intelmad_pcm_new(card, intelmaddata, 1, 0, 2);
+	if (ret_val)
+		return ret_val;
+	return snd_intelmad_pcm_new(card, intelmaddata, 1, 0, 3);
+}
+
+/**
+ * snd_intelmad_jack- to setup jack settings of the card
+ *
+ * @intelmaddata: pointer to internal context
+ *
+ * This function is called send jack events
+ */
+static int snd_intelmad_jack(struct snd_intelmad *intelmaddata)
+{
+	struct snd_jack *jack;
+	int retval;
+
+	pr_debug("sst: snd_intelmad_jack called\n");
+	jack = &intelmaddata->jack[0].jack;
+	retval = snd_jack_new(intelmaddata->card, "Headphone",
+				SND_JACK_HEADPHONE, &jack);
+	if (retval < 0)
+		return retval;
+	snd_jack_report(jack, 0);
+
+	jack->private_data = jack;
+	intelmaddata->jack[0].jack = *jack;
+
+
+	jack = &intelmaddata->jack[1].jack;
+	retval = snd_jack_new(intelmaddata->card, "Headset",
+				SND_JACK_HEADSET, &jack);
+	if (retval < 0)
+		return retval;
+
+
+
+	jack->private_data = jack;
+	intelmaddata->jack[1].jack = *jack;
+
+
+	jack = &intelmaddata->jack[2].jack;
+	retval = snd_jack_new(intelmaddata->card, "Short Press",
+				SND_JACK_HS_SHORT_PRESS, &jack);
+	if (retval < 0)
+		return retval;
+
+
+	jack->private_data = jack;
+	intelmaddata->jack[2].jack = *jack;
+
+
+	jack = &intelmaddata->jack[3].jack;
+	retval = snd_jack_new(intelmaddata->card, "Long Press",
+				SND_JACK_HS_LONG_PRESS, &jack);
+	if (retval < 0)
+		return retval;
+
+
+	jack->private_data = jack;
+	intelmaddata->jack[3].jack = *jack;
+
+	return retval;
+}
+
+/**
+ * snd_intelmad_mixer- to setup mixer settings of the card
+ *
+ * @intelmaddata: pointer to internal context
+ *
+ * This function is called from probe function to set up mixer controls
+ */
+static int __devinit snd_intelmad_mixer(struct snd_intelmad *intelmaddata)
+{
+	struct snd_card *card;
+	unsigned int idx;
+	int ret_val = 0, max_controls = 0;
+	char *mixername = "IntelMAD Controls";
+	struct snd_kcontrol_new *controls;
+
+	WARN_ON(!intelmaddata);
+
+	card = intelmaddata->card;
+	strncpy(card->mixername, mixername, sizeof(card->mixername)-1);
+	/* add all widget controls and expose the same */
+	if (intelmaddata->cpu_id == CPU_CHIP_PENWELL) {
+		max_controls = MAX_CTRL_MFLD;
+		controls = snd_intelmad_controls_mfld;
+	} else {
+		max_controls = MAX_CTRL_MRST;
+		controls = snd_intelmad_controls_mrst;
+	}
+	for (idx = 0; idx < max_controls; idx++) {
+		ret_val = snd_ctl_add(card,
+				snd_ctl_new1(&controls[idx],
+				intelmaddata));
+		pr_debug("sst: mixer[idx]=%d added\n", idx);
+		if (ret_val) {
+			pr_err("sst: in adding of control index = %d\n", idx);
+			break;
+		}
+	}
+	return ret_val;
+}
+
+static int snd_intelmad_dev_free(struct snd_device *device)
+{
+	struct snd_intelmad *intelmaddata;
+
+	WARN_ON(!device);
+
+	intelmaddata = device->device_data;
+
+	pr_debug("sst: snd_intelmad_dev_free called\n");
+	snd_card_free(intelmaddata->card);
+	/*genl_unregister_family(&audio_event_genl_family);*/
+	unregister_sst_card(intelmaddata->sstdrv_ops);
+
+	/* free allocated memory for internal context */
+	destroy_workqueue(intelmaddata->mad_jack_wq);
+	kfree(intelmaddata->sstdrv_ops);
+	kfree(intelmaddata);
+	return 0;
+}
+
+static int __devinit snd_intelmad_create(
+		struct snd_intelmad *intelmaddata,
+		struct snd_card *card)
+{
+	int ret_val;
+	static struct snd_device_ops ops = {
+		.dev_free =	snd_intelmad_dev_free,
+	};
+
+	WARN_ON(!intelmaddata);
+	WARN_ON(!card);
+	/* ALSA api to register for the device */
+	ret_val = snd_device_new(card, SNDRV_DEV_LOWLEVEL, intelmaddata, &ops);
+	return ret_val;
+}
+
+/**
+* snd_intelmad_probe- function registred for init
+* @pdev :  pointer to the device struture
+* This function is called when the device is initialized
+*/
+int __devinit snd_intelmad_probe(struct platform_device *pdev)
+{
+	struct snd_card *card;
+	int ret_val;
+	struct snd_intelmad *intelmaddata;
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	unsigned int cpu_id = (unsigned int)id->driver_data;
+
+	pr_debug("sst: probe for %s cpu_id %d\n", pdev->name, cpu_id);
+	if (!strcmp(pdev->name, DRIVER_NAME_MRST))
+		pr_debug("sst: detected MRST\n");
+	else if (!strcmp(pdev->name, DRIVER_NAME_MFLD))
+		pr_debug("sst: detected MFLD\n");
+	else {
+		pr_err("sst: detected unknown device abort!!\n");
+		return -EIO;
+	}
+	if ((cpu_id < CPU_CHIP_LINCROFT) || (cpu_id > CPU_CHIP_PENWELL)) {
+		pr_err("sst: detected unknown cpu_id abort!!\n");
+		return -EIO;
+	}
+	/* allocate memory for saving internal context and working */
+	intelmaddata = kzalloc(sizeof(*intelmaddata), GFP_KERNEL);
+	if (!intelmaddata) {
+		pr_debug("sst: mem alloctn fail\n");
+		return -ENOMEM;
+	}
+
+	/* allocate memory for LPE API set */
+	intelmaddata->sstdrv_ops = kzalloc(sizeof(struct intel_sst_card_ops),
+					GFP_KERNEL);
+	if (!intelmaddata->sstdrv_ops) {
+		pr_err("sst: mem allocation for ops fail\n");
+		kfree(intelmaddata);
+		return -ENOMEM;
+	}
+
+	intelmaddata->cpu_id = cpu_id;
+	/* create a card instance with ALSA framework */
+	ret_val = snd_card_create(card_index, card_id, THIS_MODULE, 0, &card);
+	if (ret_val) {
+		pr_err("sst: snd_card_create fail\n");
+		goto free_allocs;
+	}
+
+	intelmaddata->pdev = pdev;
+	intelmaddata->irq = platform_get_irq(pdev, 0);
+	platform_set_drvdata(pdev, intelmaddata);
+	intelmaddata->card = card;
+	intelmaddata->card_id = card_id;
+	intelmaddata->card_index = card_index;
+	intelmaddata->master_mute = UNMUTE;
+	intelmaddata->playback_cnt =  intelmaddata->capture_cnt = 0;
+	strncpy(card->driver, INTEL_MAD, strlen(INTEL_MAD));
+	strncpy(card->shortname, INTEL_MAD, strlen(INTEL_MAD));
+
+	intelmaddata->sstdrv_ops->module_name = SST_CARD_NAMES;
+	/* registering with LPE driver to get access to SST APIs to use */
+	ret_val = snd_intelmad_sst_register(intelmaddata);
+	if (ret_val) {
+		pr_err("sst: snd_intelmad_sst_register failed\n");
+		goto free_allocs;
+	}
+
+	intelmaddata->pmic_status = PMIC_INIT;
+
+	ret_val = snd_intelmad_pcm(card, intelmaddata);
+	if (ret_val) {
+		pr_err("sst: snd_intelmad_pcm failed\n");
+		goto free_allocs;
+	}
+
+	ret_val = snd_intelmad_mixer(intelmaddata);
+	if (ret_val) {
+		pr_err("sst: snd_intelmad_mixer failed\n");
+		goto free_allocs;
+	}
+
+	ret_val = snd_intelmad_jack(intelmaddata);
+	if (ret_val) {
+		pr_err("sst: snd_intelmad_jack failed\n");
+		goto free_allocs;
+	}
+
+	/*create work queue for jack interrupt*/
+	INIT_WORK(&intelmaddata->mad_jack_msg.wq,
+		sst_process_mad_jack_detection);
+
+	intelmaddata->mad_jack_wq = create_workqueue("sst_mad_jack_wq");
+	if (!intelmaddata->mad_jack_wq)
+		goto free_mad_jack_wq;
+
+	ret_val = snd_intelmad_register_irq(intelmaddata);
+	if (ret_val) {
+		pr_err("sst: snd_intelmad_register_irq fail\n");
+		goto free_allocs;
+	}
+
+	/* internal function call to register device with ALSA */
+	ret_val = snd_intelmad_create(intelmaddata, card);
+	if (ret_val) {
+		pr_err("sst: snd_intelmad_create failed\n");
+		goto free_allocs;
+	}
+	card->private_data = &intelmaddata;
+	snd_card_set_dev(card, &pdev->dev);
+	ret_val = snd_card_register(card);
+	if (ret_val) {
+		pr_err("sst: snd_card_register failed\n");
+		goto free_allocs;
+	}
+
+	pr_debug("sst:snd_intelmad_probe complete\n");
+	return ret_val;
+
+free_mad_jack_wq:
+	destroy_workqueue(intelmaddata->mad_jack_wq);
+free_allocs:
+	pr_err("sst: probe failed\n");
+	snd_card_free(card);
+	kfree(intelmaddata->sstdrv_ops);
+	kfree(intelmaddata);
+	return ret_val;
+}
+
+
+static int snd_intelmad_remove(struct platform_device *pdev)
+{
+	struct snd_intelmad *intelmaddata = platform_get_drvdata(pdev);
+
+	if (intelmaddata) {
+		snd_card_free(intelmaddata->card);
+		unregister_sst_card(intelmaddata->sstdrv_ops);
+		/* free allocated memory for internal context */
+		destroy_workqueue(intelmaddata->mad_jack_wq);
+		kfree(intelmaddata->sstdrv_ops);
+		kfree(intelmaddata);
+	}
+	return 0;
+}
+
+/*********************************************************************
+ *		Driver initialization and exit
+ *********************************************************************/
+static const struct platform_device_id snd_intelmad_ids[] = {
+	{DRIVER_NAME_MRST, CPU_CHIP_LINCROFT},
+	{DRIVER_NAME_MFLD, CPU_CHIP_PENWELL},
+	{"", 0},
+
+};
+
+static struct platform_driver snd_intelmad_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "intel_mid_sound_card",
+	},
+	.id_table = snd_intelmad_ids,
+	.probe = snd_intelmad_probe,
+	.remove = __devexit_p(snd_intelmad_remove),
+};
+
+/*
+ * alsa_card_intelmad_init- driver init function
+ *
+ * This function is called when driver module is inserted
+ */
+static int __init alsa_card_intelmad_init(void)
+{
+	pr_debug("sst: mad_init called\n");
+	return platform_driver_register(&snd_intelmad_driver);
+}
+
+/**
+ * alsa_card_intelmad_exit- driver exit function
+ *
+ * This function is called when driver module is removed
+ */
+static void __exit alsa_card_intelmad_exit(void)
+{
+	pr_debug("sst:mad_exit called\n");
+	return platform_driver_unregister(&snd_intelmad_driver);
+}
+
+module_init(alsa_card_intelmad_init)
+module_exit(alsa_card_intelmad_exit)
+
diff --git a/drivers/staging/intel_sst/intelmid.h b/drivers/staging/intel_sst/intelmid.h
new file mode 100644
index 0000000..81e7448
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid.h
@@ -0,0 +1,186 @@
+/*
+ *  intelmid.h - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Harsha Priya <priya.harsha@intel.com>
+ *		Vinod Koul <vinod.koul@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com>
+ *		KP Jeeja <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation version 2 of the License.
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
+ *  ALSA driver header for Intel MAD chipset
+ */
+#ifndef __INTELMID_H
+#define __INTELMID_H
+
+#include <linux/time.h>
+
+#define DRIVER_NAME_MFLD "msic_audio"
+#define DRIVER_NAME_MRST "pmic_audio"
+#define DRIVER_NAME "intelmid_audio"
+#define PMIC_SOUND_IRQ_TYPE_MASK (1 << 15)
+#define AUDINT_BASE (0xFFFFEFF8 + (6 * sizeof(u8)))
+#define REG_IRQ
+/* values #defined   */
+/* will differ for different hw - to be taken from config  */
+#define MAX_DEVICES		1
+#define MIN_RATE		8000
+#define MAX_RATE		48000
+#define MAX_BUFFER		(800*1024) /* for PCM */
+#define MIN_BUFFER		(800*1024)
+#define MAX_PERIODS		(1024*2)
+#define MIN_PERIODS		1
+#define MAX_PERIOD_BYTES MAX_BUFFER
+#define MIN_PERIOD_BYTES 32
+/*#define MIN_PERIOD_BYTES 160*/
+#define MAX_MUTE		1
+#define MIN_MUTE		0
+#define MONO_CNTL		1
+#define STEREO_CNTL		2
+#define MIN_CHANNEL		1
+#define MAX_CHANNEL_AMIC	2
+#define MAX_CHANNEL_DMIC	4
+#define FIFO_SIZE		0 /* fifo not being used */
+#define INTEL_MAD		"Intel MAD"
+#define MAX_CTRL_MRST		7
+#define MAX_CTRL_MFLD		2
+#define MAX_CTRL		7
+#define MAX_VENDORS		4
+/* TODO +6 db */
+#define MAX_VOL		64
+/* TODO -57 db */
+#define MIN_VOL		0
+#define PLAYBACK_COUNT  1
+#define CAPTURE_COUNT	1
+
+extern int	sst_card_vendor_id;
+
+struct mad_jack {
+	struct snd_jack jack;
+	int jack_status;
+	struct timeval buttonpressed;
+	struct timeval  buttonreleased;
+};
+
+struct mad_jack_msg_wq {
+	u8 intsts;
+	struct snd_intelmad *intelmaddata;
+	struct work_struct	wq;
+
+};
+
+/**
+ * struct snd_intelmad - intelmad driver structure
+ *
+ * @card: ptr to the card details
+ * @card_index: sound card index
+ * @card_id: sound card id detected
+ * @sstdrv_ops: ptr to sst driver ops
+ * @pdev: ptr to platfrom device
+ * @irq: interrupt number detected
+ * @pmic_status: Device status of sound card
+ * @int_base: ptr to MMIO interrupt region
+ * @output_sel: device slected as o/p
+ * @input_sel: device slected as i/p
+ * @master_mute: master mute status
+ * @jack: jack status
+ * @playback_cnt: active pb streams
+ * @capture_cnt: active cp streams
+ * @mad_jack_msg: wq struct for jack interrupt processing
+ * @mad_jack_wq: wq for jack interrupt processing
+ * @jack_prev_state: Previos state of jack detected
+ * @cpu_id: current cpu id loaded for
+ */
+struct snd_intelmad {
+	struct snd_card	*card; /* ptr to the card details */
+	int		card_index;/*  card index  */
+	char		*card_id; /* card id */
+	struct intel_sst_card_ops *sstdrv_ops;/* ptr to sst driver ops */
+	struct platform_device *pdev;
+	int irq;
+	int pmic_status;
+	void __iomem *int_base;
+	int output_sel;
+	int input_sel;
+	int master_mute;
+	struct mad_jack jack[4];
+	int playback_cnt;
+	int capture_cnt;
+	struct mad_jack_msg_wq  mad_jack_msg;
+	struct workqueue_struct *mad_jack_wq;
+	u8 jack_prev_state;
+	unsigned int cpu_id;
+};
+
+struct snd_control_val {
+	int	playback_vol_max;
+	int	playback_vol_min;
+	int	capture_vol_max;
+	int	capture_vol_min;
+};
+
+struct mad_stream_pvt {
+	int			stream_status;
+	int			stream_ops;
+	struct snd_pcm_substream *substream;
+	struct pcm_stream_info stream_info;
+	ssize_t		dbg_cum_bytes;
+	enum snd_sst_device_type device;
+};
+
+enum mad_drv_status {
+    INIT = 1,
+    STARTED,
+    RUNNING,
+    PAUSED,
+    DROPPED,
+};
+
+enum mad_pmic_status {
+	PMIC_UNINIT = 1,
+	PMIC_INIT,
+};
+enum _widget_ctrl {
+	OUTPUT_SEL = 1,
+	INPUT_SEL,
+	PLAYBACK_VOL,
+	PLAYBACK_MUTE,
+	CAPTURE_VOL,
+	CAPTURE_MUTE,
+	MASTER_MUTE
+};
+
+void period_elapsed(void *mad_substream);
+int snd_intelmad_alloc_stream(struct snd_pcm_substream *substream);
+int snd_intelmad_init_stream(struct snd_pcm_substream *substream);
+
+int sst_sc_reg_access(struct sc_reg_access *sc_access,
+					int type, int num_val);
+#define CPU_CHIP_LINCROFT       1 /* System running lincroft */
+#define CPU_CHIP_PENWELL        2 /* System running penwell */
+
+extern struct snd_control_val intelmad_ctrl_val[];
+extern struct snd_kcontrol_new snd_intelmad_controls_mrst[];
+extern struct snd_kcontrol_new snd_intelmad_controls_mfld[];
+extern struct snd_pmic_ops *intelmad_vendor_ops[];
+
+/* This is an enabler hook as the platform detection logic isn't yet
+   present and depends on some firmware and DMI support to detect AAVA
+   devices. It will vanish once the AAVA platform support is merged */
+#define is_aava()	0
+
+#endif /* __INTELMID_H */
diff --git a/drivers/staging/intel_sst/intelmid_ctrl.c b/drivers/staging/intel_sst/intelmid_ctrl.c
new file mode 100644
index 0000000..03b4ece
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_ctrl.c
@@ -0,0 +1,629 @@
+/*
+ *  intelmid_ctrl.c - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Harsha Priya <priya.harsha@intel.com>
+ *		Vinod Koul <vinod.koul@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com>
+ *		KP Jeeja <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation version 2 of the License.
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
+ *  ALSA driver handling mixer controls for Intel MAD chipset
+ */
+#include <sound/core.h>
+#include <sound/control.h>
+#include "jack.h"
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intelmid_snd_control.h"
+#include "intelmid.h"
+
+static char *out_names_mrst[] = {"Headphones",
+				"Internal speakers"};
+static char *in_names_mrst[] = {"AMIC",
+				"DMIC",
+				"HS_MIC"};
+static char *out_names_mfld[] = {"Headset ",
+				"EarPiece  "};
+static char *in_names_mfld[] = {"AMIC",
+				"DMIC"};
+
+struct snd_control_val intelmad_ctrl_val[MAX_VENDORS] = {
+	{
+		.playback_vol_max = 63,
+		.playback_vol_min = 0,
+		.capture_vol_max = 63,
+		.capture_vol_min = 0,
+	},
+	{
+		.playback_vol_max = 0,
+		.playback_vol_min = -31,
+		.capture_vol_max = 0,
+		.capture_vol_min = -20,
+	},
+	{
+		.playback_vol_max = 0,
+		.playback_vol_min = -126,
+		.capture_vol_max = 0,
+		.capture_vol_min = -31,
+	},
+};
+
+/* control path functionalities */
+
+static inline int snd_intelmad_volume_info(struct snd_ctl_elem_info *uinfo,
+					int control_type, int max, int min)
+{
+	WARN_ON(!uinfo);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = control_type;
+	uinfo->value.integer.min = min;
+	uinfo->value.integer.max = max;
+	return 0;
+}
+
+/**
+* snd_intelmad_mute_info - provides information about the mute controls
+*
+* @kcontrol:	pointer to the control
+* @uinfo:	pointer to the structure where the control's info need
+*		to be filled
+*
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_mute_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	WARN_ON(!uinfo);
+	WARN_ON(!kcontrol);
+
+	/* set up the mute as a boolean mono control with min-max values */
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = MONO_CNTL;
+	uinfo->value.integer.min = MIN_MUTE;
+	uinfo->value.integer.max = MAX_MUTE;
+	return 0;
+}
+
+/**
+* snd_intelmad_capture_volume_info - provides info about the volume control
+*
+* @kcontrol:	pointer to the control
+* @uinfo:	pointer to the structure where the control's info need
+*		to be filled
+*
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_capture_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, MONO_CNTL,
+		intelmad_ctrl_val[sst_card_vendor_id].capture_vol_max,
+		intelmad_ctrl_val[sst_card_vendor_id].capture_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_playback_volume_info - provides info about the volume control
+*
+* @kcontrol:	pointer to the control
+* @uinfo:	pointer to the structure where the control's info need
+*		to be filled
+*
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_playback_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+		intelmad_ctrl_val[sst_card_vendor_id].playback_vol_max,
+		intelmad_ctrl_val[sst_card_vendor_id].playback_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_device_info_mrst - provides information about the devices available
+*
+* @kcontrol:	pointer to the control
+* @uinfo:	pointer to the structure where the devices's info need
+*		to be filled
+*
+* This function is called when a mixer application requests for device's info
+*/
+static int snd_intelmad_device_info_mrst(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+
+	WARN_ON(!kcontrol);
+	WARN_ON(!uinfo);
+
+	/* setup device select as drop down controls with different values */
+	if (kcontrol->id.numid == OUTPUT_SEL)
+		uinfo->value.enumerated.items = ARRAY_SIZE(out_names_mrst);
+	else
+		uinfo->value.enumerated.items = ARRAY_SIZE(in_names_mrst);
+	uinfo->count = MONO_CNTL;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = 1;
+	if (kcontrol->id.numid == OUTPUT_SEL)
+		strncpy(uinfo->value.enumerated.name,
+			out_names_mrst[uinfo->value.enumerated.item],
+			sizeof(uinfo->value.enumerated.name)-1);
+	else
+		strncpy(uinfo->value.enumerated.name,
+			in_names_mrst[uinfo->value.enumerated.item],
+			sizeof(uinfo->value.enumerated.name)-1);
+	return 0;
+}
+
+static int snd_intelmad_device_info_mfld(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	WARN_ON(!kcontrol);
+	WARN_ON(!uinfo);
+	/* setup device select as drop down controls with different values */
+	if (kcontrol->id.numid == OUTPUT_SEL)
+		uinfo->value.enumerated.items = ARRAY_SIZE(out_names_mfld);
+	else
+		uinfo->value.enumerated.items = ARRAY_SIZE(in_names_mfld);
+	uinfo->count = MONO_CNTL;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = 1;
+	if (kcontrol->id.numid == OUTPUT_SEL)
+		strncpy(uinfo->value.enumerated.name,
+			out_names_mfld[uinfo->value.enumerated.item],
+			sizeof(uinfo->value.enumerated.name)-1);
+	else
+		strncpy(uinfo->value.enumerated.name,
+			in_names_mfld[uinfo->value.enumerated.item],
+			sizeof(uinfo->value.enumerated.name)-1);
+	return 0;
+}
+
+/**
+* snd_intelmad_volume_get - gets the current volume for the control
+*
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info need
+*		to be filled
+*
+* This function is called when .get function of a control is invoked from app
+*/
+static int snd_intelmad_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *uval)
+{
+	int ret_val = 0, cntl_list[2] = {0,};
+	int value = 0;
+	struct snd_intelmad *intelmaddata;
+	struct snd_pmic_ops *scard_ops;
+
+	pr_debug("sst: snd_intelmad_volume_get called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	switch (kcontrol->id.numid) {
+	case PLAYBACK_VOL:
+		cntl_list[0] = PMIC_SND_RIGHT_PB_VOL;
+		cntl_list[1] = PMIC_SND_LEFT_PB_VOL;
+		break;
+
+	case CAPTURE_VOL:
+		cntl_list[0] = PMIC_SND_CAPTURE_VOL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->get_vol(cntl_list[0], &value);
+	uval->value.integer.value[0] = value;
+
+	if (ret_val)
+		return ret_val;
+
+	if (kcontrol->id.numid == PLAYBACK_VOL) {
+		ret_val = scard_ops->get_vol(cntl_list[1], &value);
+		uval->value.integer.value[1] = value;
+	}
+	return ret_val;
+}
+
+/**
+* snd_intelmad_mute_get - gets the current mute status for the control
+*
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info need
+*		to be filled
+*
+* This function is called when .get function of a control is invoked from app
+*/
+static int snd_intelmad_mute_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+
+	int cntl_list = 0, ret_val = 0;
+	u8 value = 0;
+	struct snd_intelmad *intelmaddata;
+	struct snd_pmic_ops *scard_ops;
+
+	pr_debug("sst: Mute_get called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	switch (kcontrol->id.numid) {
+	case PLAYBACK_MUTE:
+		if (intelmaddata->output_sel == STEREO_HEADPHONE)
+			cntl_list = PMIC_SND_LEFT_HP_MUTE;
+		else if ((intelmaddata->output_sel == INTERNAL_SPKR) ||
+			(intelmaddata->output_sel == MONO_EARPIECE))
+			cntl_list = PMIC_SND_LEFT_SPEAKER_MUTE;
+		break;
+
+	case CAPTURE_MUTE:
+		if (intelmaddata->input_sel == DMIC)
+			cntl_list = PMIC_SND_DMIC_MUTE;
+		else if (intelmaddata->input_sel == AMIC)
+			cntl_list = PMIC_SND_AMIC_MUTE;
+		else if (intelmaddata->input_sel == HS_MIC)
+			cntl_list = PMIC_SND_HP_MIC_MUTE;
+		break;
+	case MASTER_MUTE:
+		uval->value.integer.value[0] = intelmaddata->master_mute;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->get_mute(cntl_list, &value);
+	uval->value.integer.value[0] = value;
+	return ret_val;
+}
+
+/**
+* snd_intelmad_volume_set - sets the volume control's info
+*
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info is
+*		available to be set
+*
+* This function is called when .set function of a control is invoked from app
+*/
+static int snd_intelmad_volume_set(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+
+	int ret_val, cntl_list[2] = {0,};
+	struct snd_intelmad *intelmaddata;
+	struct snd_pmic_ops *scard_ops;
+
+	pr_debug("sst: volume set called:%ld %ld\n",
+			uval->value.integer.value[0],
+			uval->value.integer.value[1]);
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	switch (kcontrol->id.numid) {
+	case PLAYBACK_VOL:
+		cntl_list[0] = PMIC_SND_LEFT_PB_VOL;
+		cntl_list[1] = PMIC_SND_RIGHT_PB_VOL;
+		break;
+
+	case CAPTURE_VOL:
+		cntl_list[0] = PMIC_SND_CAPTURE_VOL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->set_vol(cntl_list[0],
+				uval->value.integer.value[0]);
+	if (ret_val)
+		return ret_val;
+
+	if (kcontrol->id.numid == PLAYBACK_VOL)
+		ret_val = scard_ops->set_vol(cntl_list[1],
+				uval->value.integer.value[1]);
+	return ret_val;
+}
+
+/**
+* snd_intelmad_mute_set - sets the mute control's info
+*
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info is
+*		available to be set
+*
+* This function is called when .set function of a control is invoked from app
+*/
+static int snd_intelmad_mute_set(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+	int cntl_list[2] = {0,}, ret_val;
+	struct snd_intelmad *intelmaddata;
+	struct snd_pmic_ops *scard_ops;
+
+	pr_debug("sst: snd_intelmad_mute_set called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	kcontrol->private_value = uval->value.integer.value[0];
+
+	switch (kcontrol->id.numid) {
+	case PLAYBACK_MUTE:
+		if (intelmaddata->output_sel == STEREO_HEADPHONE) {
+			cntl_list[0] = PMIC_SND_LEFT_HP_MUTE;
+			cntl_list[1] = PMIC_SND_RIGHT_HP_MUTE;
+		} else if ((intelmaddata->output_sel == INTERNAL_SPKR) ||
+				(intelmaddata->output_sel == MONO_EARPIECE)) {
+			cntl_list[0] = PMIC_SND_LEFT_SPEAKER_MUTE;
+			cntl_list[1] = PMIC_SND_RIGHT_SPEAKER_MUTE;
+		}
+		break;
+
+	case CAPTURE_MUTE:/*based on sel device mute the i/p dev*/
+		if (intelmaddata->input_sel == DMIC)
+			cntl_list[0] = PMIC_SND_DMIC_MUTE;
+		else if (intelmaddata->input_sel == AMIC)
+			cntl_list[0] = PMIC_SND_AMIC_MUTE;
+		else if (intelmaddata->input_sel == HS_MIC)
+			cntl_list[0] = PMIC_SND_HP_MIC_MUTE;
+		break;
+	case MASTER_MUTE:
+		cntl_list[0] = PMIC_SND_MUTE_ALL;
+		intelmaddata->master_mute = uval->value.integer.value[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->set_mute(cntl_list[0],
+				uval->value.integer.value[0]);
+	if (ret_val)
+		return ret_val;
+
+	if (kcontrol->id.numid == PLAYBACK_MUTE)
+		ret_val = scard_ops->set_mute(cntl_list[1],
+					uval->value.integer.value[0]);
+	return ret_val;
+}
+
+/**
+* snd_intelmad_device_get - get the device select control's info
+*
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info is
+*		to be filled
+*
+* This function is called when .get function of a control is invoked from app
+*/
+static int snd_intelmad_device_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+	struct snd_intelmad *intelmaddata;
+	struct snd_pmic_ops *scard_ops;
+	pr_debug("sst: device_get called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+	if (intelmaddata->cpu_id == CPU_CHIP_PENWELL) {
+		scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+		if (kcontrol->id.numid == OUTPUT_SEL)
+			uval->value.enumerated.item[0] =
+					scard_ops->output_dev_id;
+		else if (kcontrol->id.numid == INPUT_SEL)
+			uval->value.enumerated.item[0] =
+					scard_ops->input_dev_id;
+		else
+			return -EINVAL;
+	} else
+	uval->value.enumerated.item[0] = kcontrol->private_value;
+	return 0;
+}
+
+/**
+* snd_intelmad_device_set - set the device select control's info
+*
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info is
+*		available to be set
+*
+* This function is called when .set function of a control is invoked from app
+*/
+static int snd_intelmad_device_set(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+	struct snd_intelmad *intelmaddata;
+	struct snd_pmic_ops *scard_ops;
+	int ret_val = 0, vendor, status;
+
+	pr_debug("sst: snd_intelmad_device_set called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+	status = -1;
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	/* store value with driver */
+	kcontrol->private_value = uval->value.enumerated.item[0];
+
+	switch (kcontrol->id.numid) {
+	case OUTPUT_SEL:
+		ret_val = scard_ops->set_output_dev(
+				uval->value.enumerated.item[0]);
+		intelmaddata->output_sel = uval->value.enumerated.item[0];
+		break;
+	case INPUT_SEL:
+		vendor = intelmaddata->sstdrv_ops->vendor_id;
+		if ((vendor == SND_MX) || (vendor == SND_FS)) {
+			if (uval->value.enumerated.item[0] == HS_MIC) {
+				status = 1;
+				intelmaddata->sstdrv_ops->
+				control_set(SST_ENABLE_RX_TIME_SLOT, &status);
+			} else {
+				status = 0;
+				intelmaddata->sstdrv_ops->
+				control_set(SST_ENABLE_RX_TIME_SLOT, &status);
+			}
+		}
+		ret_val = scard_ops->set_input_dev(
+				uval->value.enumerated.item[0]);
+		intelmaddata->input_sel = uval->value.enumerated.item[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+	kcontrol->private_value = uval->value.enumerated.item[0];
+	return ret_val;
+}
+
+struct snd_kcontrol_new snd_intelmad_controls_mrst[MAX_CTRL] __devinitdata = {
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Playback Source",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_device_info_mrst,
+	.get		=	snd_intelmad_device_get,
+	.put		=	snd_intelmad_device_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Capture Source",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_device_info_mrst,
+	.get		=	snd_intelmad_device_get,
+	.put		=	snd_intelmad_device_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Playback Volume",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_playback_volume_info,
+	.get		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Playback Switch",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_mute_info,
+	.get		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Capture Volume",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_capture_volume_info,
+	.get		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Capture Switch",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_mute_info,
+	.get		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"Master Playback Switch",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_mute_info,
+	.get		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+};
+
+struct snd_kcontrol_new
+snd_intelmad_controls_mfld[MAX_CTRL_MFLD] __devinitdata = {
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Playback Source",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_device_info_mfld,
+	.get		=	snd_intelmad_device_get,
+	.put		=	snd_intelmad_device_set,
+	.private_value	=	0,
+},
+{
+	.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		=	"PCM Capture Source",
+	.access		=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info		=	snd_intelmad_device_info_mfld,
+	.get		=	snd_intelmad_device_get,
+	.put		=	snd_intelmad_device_set,
+	.private_value	=	0,
+},
+};
+
diff --git a/drivers/staging/intel_sst/intelmid_msic_control.c b/drivers/staging/intel_sst/intelmid_msic_control.c
new file mode 100644
index 0000000..4d1755e
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_msic_control.c
@@ -0,0 +1,410 @@
+/*
+ *  intelmid_vm_control.c - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *
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
+ * This file contains the control operations of msic vendors
+ */
+
+#include <linux/pci.h>
+#include <linux/file.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intelmid_snd_control.h"
+
+static int msic_init_card(void)
+{
+	struct sc_reg_access sc_access[] = {
+		/* dmic configuration */
+		{0x241, 0x85, 0},
+		{0x242, 0x02, 0},
+		/* audio paths config */
+		{0x24C, 0x10, 0},
+		{0x24D, 0x32, 0},
+		/* PCM2 interface slots */
+		/* preconfigured slots for 0-5 both tx, rx */
+		{0x272, 0x10, 0},
+		{0x273, 0x32, 0},
+		{0x274, 0xFF, 0},
+		{0x275, 0x10, 0},
+		{0x276, 0x32, 0},
+		{0x277, 0x54, 0},
+		/*Sinc5 decimator*/
+		{0x24E, 0x28, 0},
+		/*TI vibra w/a settings*/
+		{0x384, 0x80, 0},
+		{0x385, 0x80, 0},
+		/*vibra settings*/
+		{0x267, 0x00, 0},
+		{0x26A, 0x10, 0},
+		{0x261, 0x00, 0},
+		{0x264, 0x10, 0},
+		/* pcm port setting */
+		{0x278, 0x00, 0},
+		{0x27B, 0x01, 0},
+		{0x27C, 0x0a, 0},
+		/* Set vol HSLRVOLCTRL, IHFVOL */
+		{0x259, 0x04, 0},
+		{0x25A, 0x04, 0},
+		{0x25B, 0x04, 0},
+		{0x25C, 0x04, 0},
+		/* HSEPRXCTRL  Enable the headset left and right FIR filters  */
+		{0x250, 0x30, 0},
+		/* HSMIXER */
+		{0x256, 0x11, 0},
+		/* amic configuration */
+		{0x249, 0x09, 0x0},
+		{0x24A, 0x09, 0x0},
+		/* unmask ocaudio/accdet interrupts */
+		{0x1d, 0x00, 0x00},
+		{0x1e, 0x00, 0x00},
+	};
+	snd_msic_ops.card_status = SND_CARD_INIT_DONE;
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 30);
+	snd_msic_ops.pb_on = 0;
+	snd_msic_ops.cap_on = 0;
+	snd_msic_ops.input_dev_id = DMIC; /*def dev*/
+	snd_msic_ops.output_dev_id = STEREO_HEADPHONE;
+	pr_debug("sst: msic init complete!!\n");
+	return 0;
+}
+
+static int msic_power_up_pb(unsigned int device)
+{
+	struct sc_reg_access sc_access1[] = {
+		/* turn on the audio power supplies */
+		{0x0DB, 0x05, 0},
+		/*  VHSP */
+		{0x0DC, 0xFF, 0},
+		/*  VHSN */
+		{0x0DD, 0x3F, 0},
+		/* turn on PLL */
+		{0x240, 0x21, 0},
+	};
+	struct sc_reg_access sc_access2[] = {
+		/*  disable driver */
+		{0x25D, 0x0, 0x43},
+		/* DAC CONFIG ; both HP, LP on */
+		{0x257, 0x03, 0x03},
+	};
+	struct sc_reg_access sc_access3[] = {
+		/* HSEPRXCTRL  Enable the headset left and right FIR filters  */
+		{0x250, 0x30, 0},
+		/* HSMIXER */
+		{0x256, 0x11, 0},
+	};
+	struct sc_reg_access sc_access4[] = {
+		/* enable driver */
+		{0x25D, 0x3, 0x3},
+		/* unmute the headset */
+		{ 0x259, 0x80, 0x80},
+		{ 0x25A, 0x80, 0x80},
+	};
+	struct sc_reg_access sc_access_vihf[] = {
+		/*  VIHF ON */
+		{0x0C9, 0x2D, 0x00},
+	};
+	struct sc_reg_access sc_access22[] = {
+		/*  disable driver */
+		{0x25D, 0x00, 0x0C},
+		/*Filer DAC enable*/
+		{0x251, 0x03, 0x03},
+		{0x257, 0x0C, 0x0C},
+	};
+	struct sc_reg_access sc_access32[] = {
+		/*enable drv*/
+		{0x25D, 0x0C, 0x0c},
+	};
+	struct sc_reg_access sc_access42[] = {
+		/*unmute headset*/
+		{0x25B, 0x80, 0x80},
+		{0x25C, 0x80, 0x80},
+	};
+	struct sc_reg_access sc_access23[] = {
+		/*  disable driver */
+		{0x25D, 0x0, 0x43},
+		/* DAC CONFIG ; both HP, LP on */
+		{0x257, 0x03, 0x03},
+	};
+	struct sc_reg_access sc_access43[] = {
+		/* enable driver */
+		{0x25D, 0x40, 0x40},
+		/* unmute the headset */
+		{ 0x259, 0x80, 0x80},
+		{ 0x25A, 0x80, 0x80},
+	};
+	struct sc_reg_access sc_access_vib[] = {
+		/* enable driver, ADC */
+		{0x25D, 0x10, 0x10},
+		{0x264, 0x02, 0x02},
+	};
+	struct sc_reg_access sc_access_hap[] = {
+		/* enable driver, ADC */
+		{0x25D, 0x20, 0x20},
+		{0x26A, 0x02, 0x02},
+	};
+	struct sc_reg_access sc_access_pcm2[] = {
+		/* enable pcm 2 */
+		{0x27C, 0x1, 0x1},
+	};
+	int retval = 0;
+
+	if (snd_msic_ops.card_status == SND_CARD_UN_INIT) {
+		retval = msic_init_card();
+		if (retval)
+			return retval;
+	}
+
+	pr_debug("sst: powering up pb.... Device %d\n", device);
+	sst_sc_reg_access(sc_access1, PMIC_WRITE, 4);
+	switch (device) {
+	case SND_SST_DEVICE_HEADSET:
+		if (snd_msic_ops.output_dev_id == STEREO_HEADPHONE) {
+			sst_sc_reg_access(sc_access2, PMIC_READ_MODIFY, 2);
+			sst_sc_reg_access(sc_access3, PMIC_WRITE, 2);
+			sst_sc_reg_access(sc_access4, PMIC_READ_MODIFY, 3);
+		} else {
+			sst_sc_reg_access(sc_access23, PMIC_READ_MODIFY, 2);
+			sst_sc_reg_access(sc_access3, PMIC_WRITE, 2);
+			sst_sc_reg_access(sc_access43, PMIC_READ_MODIFY, 3);
+		}
+		snd_msic_ops.pb_on = 1;
+		break;
+
+	case SND_SST_DEVICE_IHF:
+		sst_sc_reg_access(sc_access_vihf, PMIC_WRITE, 1);
+		sst_sc_reg_access(sc_access22, PMIC_READ_MODIFY, 3);
+		sst_sc_reg_access(sc_access32, PMIC_READ_MODIFY, 1);
+		sst_sc_reg_access(sc_access42, PMIC_READ_MODIFY, 2);
+		break;
+
+	case SND_SST_DEVICE_VIBRA:
+		sst_sc_reg_access(sc_access_vib, PMIC_READ_MODIFY, 2);
+		break;
+
+	case SND_SST_DEVICE_HAPTIC:
+		sst_sc_reg_access(sc_access_hap, PMIC_READ_MODIFY, 2);
+		break;
+
+	default:
+		pr_warn("sst: Wrong Device %d, selected %d\n",
+			       device, snd_msic_ops.output_dev_id);
+	}
+	return sst_sc_reg_access(sc_access_pcm2, PMIC_READ_MODIFY, 1);
+}
+
+static int msic_power_up_cp(unsigned int device)
+{
+	struct sc_reg_access sc_access[] = {
+		/* turn on the audio power supplies */
+		{0x0DB, 0x05, 0},
+		/*  VHSP */
+		{0x0DC, 0xFF, 0},
+		/*  VHSN */
+		{0x0DD, 0x3F, 0},
+		/* turn on PLL */
+		{0x240, 0x21, 0},
+
+		/*  Turn on DMIC supply  */
+		{0x247, 0xA0, 0x0},
+		{0x240, 0x21, 0x0},
+		{0x24C, 0x10, 0x0},
+
+		/* mic demux enable */
+		{0x245, 0x3F, 0x0},
+		{0x246, 0x7, 0x0},
+
+	};
+	struct sc_reg_access sc_access_amic[] = {
+		/* turn on the audio power supplies */
+		{0x0DB, 0x05, 0},
+		/*  VHSP */
+		{0x0DC, 0xFF, 0},
+		/*  VHSN */
+		{0x0DD, 0x3F, 0},
+		/* turn on PLL */
+		{0x240, 0x21, 0},
+		/*ADC EN*/
+		{0x248, 0x05, 0x0},
+		{0x24C, 0x76, 0x0},
+		/*MIC EN*/
+		{0x249, 0x09, 0x0},
+		{0x24A, 0x09, 0x0},
+		/*  Turn on AMIC supply  */
+		{0x247, 0xFC, 0x0},
+
+	};
+	struct sc_reg_access sc_access2[] = {
+		/* enable pcm 2 */
+		{0x27C, 0x1, 0x1},
+	};
+	struct sc_reg_access sc_access3[] = {
+		/*wait for mic to stabalize before turning on audio channels*/
+		{0x24F, 0x3C, 0x0},
+	};
+	int retval = 0;
+
+	if (snd_msic_ops.card_status == SND_CARD_UN_INIT) {
+		retval = msic_init_card();
+		if (retval)
+			return retval;
+	}
+
+	pr_debug("sst: powering up cp....%d\n", snd_msic_ops.input_dev_id);
+	sst_sc_reg_access(sc_access2, PMIC_READ_MODIFY, 1);
+	snd_msic_ops.cap_on = 1;
+	if (snd_msic_ops.input_dev_id == AMIC)
+		sst_sc_reg_access(sc_access_amic, PMIC_WRITE, 9);
+	else
+		sst_sc_reg_access(sc_access, PMIC_WRITE, 9);
+	return sst_sc_reg_access(sc_access3, PMIC_WRITE, 1);
+
+}
+
+static int msic_power_down(void)
+{
+	int retval = 0;
+
+	pr_debug("sst: powering dn msic\n");
+	snd_msic_ops.pb_on = 0;
+	snd_msic_ops.cap_on = 0;
+	return retval;
+}
+
+static int msic_power_down_pb(void)
+{
+	int retval = 0;
+
+	pr_debug("sst: powering dn pb....\n");
+	snd_msic_ops.pb_on = 0;
+	return retval;
+}
+
+static int msic_power_down_cp(void)
+{
+	int retval = 0;
+
+	pr_debug("sst: powering dn cp....\n");
+	snd_msic_ops.cap_on = 0;
+	return retval;
+}
+
+static int msic_set_selected_output_dev(u8 value)
+{
+	int retval = 0;
+
+	pr_debug("sst: msic set selected output:%d\n", value);
+	snd_msic_ops.output_dev_id = value;
+	if (snd_msic_ops.pb_on)
+		msic_power_up_pb(SND_SST_DEVICE_HEADSET);
+	return retval;
+}
+
+static int msic_set_selected_input_dev(u8 value)
+{
+
+	struct sc_reg_access sc_access_dmic[] = {
+		{0x24C, 0x10, 0x0},
+	};
+	struct sc_reg_access sc_access_amic[] = {
+		{0x24C, 0x76, 0x0},
+
+	};
+	int retval = 0;
+
+	pr_debug("sst: msic_set_selected_input_dev:%d\n", value);
+	snd_msic_ops.input_dev_id = value;
+	switch (value) {
+	case AMIC:
+		pr_debug("sst: Selecting AMIC1\n");
+		retval = sst_sc_reg_access(sc_access_amic, PMIC_WRITE, 1);
+		break;
+	case DMIC:
+		pr_debug("sst: Selecting DMIC1\n");
+		retval = sst_sc_reg_access(sc_access_dmic, PMIC_WRITE, 1);
+		break;
+	default:
+		return -EINVAL;
+
+	}
+	if (snd_msic_ops.cap_on)
+		retval = msic_power_up_cp(SND_SST_DEVICE_CAPTURE);
+	return retval;
+}
+
+static int msic_set_pcm_voice_params(void)
+{
+	return 0;
+}
+
+static int msic_set_pcm_audio_params(int sfreq, int word_size, int num_channel)
+{
+	return 0;
+}
+
+static int msic_set_audio_port(int status)
+{
+	return 0;
+}
+
+static int msic_set_voice_port(int status)
+{
+	return 0;
+}
+
+static int msic_set_mute(int dev_id, u8 value)
+{
+	return 0;
+}
+
+static int msic_set_vol(int dev_id, int value)
+{
+	return 0;
+}
+
+static int msic_get_mute(int dev_id, u8 *value)
+{
+	return 0;
+}
+
+static int msic_get_vol(int dev_id, int *value)
+{
+	return 0;
+}
+
+struct snd_pmic_ops snd_msic_ops = {
+	.set_input_dev	=	msic_set_selected_input_dev,
+	.set_output_dev =	msic_set_selected_output_dev,
+	.set_mute	=	msic_set_mute,
+	.get_mute	=	msic_get_mute,
+	.set_vol	=	msic_set_vol,
+	.get_vol	=	msic_get_vol,
+	.init_card	=	msic_init_card,
+	.set_pcm_audio_params	= msic_set_pcm_audio_params,
+	.set_pcm_voice_params	= msic_set_pcm_voice_params,
+	.set_voice_port = msic_set_voice_port,
+	.set_audio_port = msic_set_audio_port,
+	.power_up_pmic_pb =	msic_power_up_pb,
+	.power_up_pmic_cp =	msic_power_up_cp,
+	.power_down_pmic_pb =	msic_power_down_pb,
+	.power_down_pmic_cp =	msic_power_down_cp,
+	.power_down_pmic =	msic_power_down,
+};
diff --git a/drivers/staging/intel_sst/intelmid_pvt.c b/drivers/staging/intel_sst/intelmid_pvt.c
new file mode 100644
index 0000000..9ed9475
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_pvt.c
@@ -0,0 +1,174 @@
+/*
+ *   intelmid_pvt.h - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Harsha Priya <priya.harsha@intel.com>
+ *		Vinod Koul <vinod.koul@intel.com>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * ALSA driver for Intel MID sound card chipset - holding private functions
+ */
+#include <linux/io.h>
+#include <asm/intel_scu_ipc.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include "jack.h"
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intelmid_snd_control.h"
+#include "intelmid.h"
+
+
+void period_elapsed(void *mad_substream)
+{
+	struct snd_pcm_substream *substream = mad_substream;
+	struct mad_stream_pvt *stream;
+
+
+
+	if (!substream || !substream->runtime)
+		return;
+	stream = substream->runtime->private_data;
+	if (!stream)
+		return;
+
+	if (stream->stream_status != RUNNING)
+		return;
+	pr_debug("sst: calling period elapsed\n");
+	snd_pcm_period_elapsed(substream);
+	return;
+}
+
+
+int snd_intelmad_alloc_stream(struct snd_pcm_substream *substream)
+{
+	struct snd_intelmad *intelmaddata = snd_pcm_substream_chip(substream);
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+	struct snd_sst_stream_params param = {{{0,},},};
+	struct snd_sst_params str_params = {0};
+	int ret_val;
+
+	/* set codec params and inform SST driver the same */
+
+	param.uc.pcm_params.codec = SST_CODEC_TYPE_PCM;
+	param.uc.pcm_params.num_chan = (u8) substream->runtime->channels;
+	param.uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
+	param.uc.pcm_params.reserved = 0;
+	param.uc.pcm_params.sfreq = substream->runtime->rate;
+	param.uc.pcm_params.ring_buffer_size =
+					snd_pcm_lib_buffer_bytes(substream);
+	param.uc.pcm_params.period_count = substream->runtime->period_size;
+	param.uc.pcm_params.ring_buffer_addr =
+				virt_to_phys(substream->runtime->dma_area);
+	pr_debug("sst: period_cnt = %d\n", param.uc.pcm_params.period_count);
+	pr_debug("sst: sfreq= %d, wd_sz = %d\n",
+		 param.uc.pcm_params.sfreq, param.uc.pcm_params.pcm_wd_sz);
+
+	str_params.sparams = param;
+	str_params.codec = SST_CODEC_TYPE_PCM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		str_params.ops = STREAM_OPS_PLAYBACK;
+		pr_debug("sst: Playbck stream,Device %d\n", stream->device);
+	} else {
+		str_params.ops = STREAM_OPS_CAPTURE;
+		stream->device = SND_SST_DEVICE_CAPTURE;
+		pr_debug("sst: Capture stream,Device %d\n", stream->device);
+	}
+	str_params.device_type = stream->device;
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_ALLOC,
+					&str_params);
+	pr_debug("sst: SST_SND_PLAY/CAPTURE ret_val = %x\n",
+			ret_val);
+	if (ret_val < 0)
+		return ret_val;
+
+	stream->stream_info.str_id = ret_val;
+	stream->stream_status = INIT;
+	stream->stream_info.buffer_ptr = 0;
+	pr_debug("sst: str id :  %d\n", stream->stream_info.str_id);
+
+	return ret_val;
+}
+
+int snd_intelmad_init_stream(struct snd_pcm_substream *substream)
+{
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+	struct snd_intelmad *intelmaddata = snd_pcm_substream_chip(substream);
+	int ret_val;
+
+	pr_debug("sst: setting buffer ptr param\n");
+	stream->stream_info.period_elapsed = period_elapsed;
+	stream->stream_info.mad_substream = substream;
+	stream->stream_info.buffer_ptr = 0;
+	stream->stream_info.sfreq = substream->runtime->rate;
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_STREAM_INIT,
+					&stream->stream_info);
+	if (ret_val)
+		pr_err("sst: control_set ret error %d\n", ret_val);
+	return ret_val;
+
+}
+
+
+/**
+ * sst_sc_reg_access - IPC read/write wrapper
+ *
+ * @sc_access:  array of data, addresses and mask
+ * @type: operation type
+ * @num_val: number of reg to opertae on
+ *
+ * Reads/writes/read-modify operations on registers accessed through SCU (sound
+ * card and few SST DSP regsisters that are not accissible to IA)
+ */
+int sst_sc_reg_access(struct sc_reg_access *sc_access,
+					int type, int num_val)
+{
+	int i, retval = 0;
+	if (type == PMIC_WRITE) {
+		for (i = 0; i < num_val; i++) {
+			retval = intel_scu_ipc_iowrite8(sc_access[i].reg_addr,
+							sc_access[i].value);
+			if (retval) {
+				pr_err("sst: IPC write failed!!! %d\n", retval);
+				return retval;
+			}
+		}
+	} else if (type == PMIC_READ) {
+		for (i = 0; i < num_val; i++) {
+			retval = intel_scu_ipc_ioread8(sc_access[i].reg_addr,
+							&(sc_access[i].value));
+			if (retval) {
+				pr_err("sst: IPC read failed!!!!!%d\n", retval);
+				return retval;
+			}
+		}
+	} else {
+		for (i = 0; i < num_val; i++) {
+			retval = intel_scu_ipc_update_register(
+				sc_access[i].reg_addr, sc_access[i].value,
+				sc_access[i].mask);
+			if (retval) {
+				pr_err("sst: IPC Modify failed!!!%d\n", retval);
+				return retval;
+			}
+		}
+	}
+	return retval;
+}
diff --git a/drivers/staging/intel_sst/intelmid_snd_control.h b/drivers/staging/intel_sst/intelmid_snd_control.h
new file mode 100644
index 0000000..a4565f3
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_snd_control.h
@@ -0,0 +1,114 @@
+#ifndef __INTELMID_SND_CTRL_H__
+#define __INTELMID_SND_CTRL_H__
+/*
+ *  intelmid_snd_control.h - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file defines all snd control functions
+ */
+
+/*
+Mask bits
+*/
+#define MASK0 0x01	/* 0000 0001 */
+#define MASK1 0x02	/* 0000 0010 */
+#define MASK2 0x04	/* 0000 0100 */
+#define MASK3 0x08	/* 0000 1000 */
+#define MASK4 0x10	/* 0001 0000 */
+#define MASK5 0x20	/* 0010 0000 */
+#define MASK6 0x40	/* 0100 0000 */
+#define MASK7 0x80	/* 1000 0000 */
+/*
+value bits
+*/
+#define VALUE0	0x01	/* 0000 0001 */
+#define VALUE1	0x02	/* 0000 0010 */
+#define VALUE2	0x04	/* 0000 0100 */
+#define VALUE3	0x08	/* 0000 1000 */
+#define VALUE4	0x10	/* 0001 0000 */
+#define VALUE5	0x20	/* 0010 0000 */
+#define VALUE6	0x40	/* 0100 0000 */
+#define VALUE7	0x80	/* 1000 0000 */
+
+#define MUTE 0    /* ALSA Passes 0 for mute */
+#define UNMUTE 1  /* ALSA Passes 1 for unmute */
+
+#define MAX_VOL_PMIC_VENDOR0    0x3f /* max vol in dB for stereo & voice DAC */
+#define MIN_VOL_PMIC_VENDOR0    0 /* min vol in dB for stereo & voice DAC */
+/* Head phone volume control  */
+#define MAX_HP_VOL_PMIC_VENDOR1    6 /* max volume in dB for HP */
+#define MIN_HP_VOL_PMIC_VENDOR1    (-84) /* min volume in dB for HP */
+#define MAX_HP_VOL_INDX_PMIC_VENDOR1 40 /* Number of HP volume control values */
+
+/* Mono Earpiece Volume control */
+#define MAX_EP_VOL_PMIC_VENDOR1    0 /* max volume in dB for EP */
+#define MIN_EP_VOL_PMIC_VENDOR1    (-75) /* min volume in dB for EP */
+#define MAX_EP_VOL_INDX_PMIC_VENDOR1 32 /* Number of EP volume control values */
+
+int sst_sc_reg_access(struct sc_reg_access *sc_access,
+					int type, int num_val);
+extern struct snd_pmic_ops snd_pmic_ops_fs;
+extern struct snd_pmic_ops snd_pmic_ops_mx;
+extern struct snd_pmic_ops snd_pmic_ops_nc;
+extern struct snd_pmic_ops snd_msic_ops;
+
+/* device */
+enum SND_INPUT_DEVICE {
+	AMIC,
+	DMIC,
+	HS_MIC,
+	IN_UNDEFINED
+};
+
+enum SND_OUTPUT_DEVICE {
+	STEREO_HEADPHONE,
+	MONO_EARPIECE,
+
+	INTERNAL_SPKR,
+	RECEIVER,
+	OUT_UNDEFINED
+};
+
+enum pmic_controls {
+	PMIC_SND_HP_MIC_MUTE =			0x0001,
+	PMIC_SND_AMIC_MUTE =			0x0002,
+	PMIC_SND_DMIC_MUTE =			0x0003,
+	PMIC_SND_CAPTURE_VOL =			0x0004,
+/* Output controls */
+	PMIC_SND_LEFT_PB_VOL =			0x0010,
+	PMIC_SND_RIGHT_PB_VOL =			0x0011,
+	PMIC_SND_LEFT_HP_MUTE =			0x0012,
+	PMIC_SND_RIGHT_HP_MUTE =		0x0013,
+	PMIC_SND_LEFT_SPEAKER_MUTE =		0x0014,
+	PMIC_SND_RIGHT_SPEAKER_MUTE =		0x0015,
+	PMIC_SND_RECEIVER_VOL =			0x0016,
+	PMIC_SND_RECEIVER_MUTE =		0x0017,
+/* Other controls */
+	PMIC_SND_MUTE_ALL =			0x0020,
+	PMIC_MAX_CONTROLS =			0x0020,
+};
+
+#endif /* __INTELMID_SND_CTRL_H__ */
+
+
diff --git a/drivers/staging/intel_sst/intelmid_v0_control.c b/drivers/staging/intel_sst/intelmid_v0_control.c
new file mode 100644
index 0000000..f586d62
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_v0_control.c
@@ -0,0 +1,771 @@
+/*
+ *  intel_sst_v0_control.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file contains the control operations of vendor 1
+ */
+
+#include <linux/pci.h>
+#include <linux/file.h>
+#include "intel_sst.h"
+#include "intelmid_snd_control.h"
+
+
+enum _reg_v1 {
+	VOICEPORT1 = 0x180,
+	VOICEPORT2 = 0x181,
+	AUDIOPORT1 = 0x182,
+	AUDIOPORT2 = 0x183,
+	MISCVOICECTRL = 0x184,
+	MISCAUDCTRL = 0x185,
+	DMICCTRL1 = 0x186,
+	AUDIOBIAS = 0x187,
+	MICCTRL = 0x188,
+	MICLICTRL1 = 0x189,
+	MICLICTRL2 = 0x18A,
+	MICLICTRL3 = 0x18B,
+	VOICEDACCTRL1 = 0x18C,
+	STEREOADCCTRL = 0x18D,
+	AUD15 = 0x18E,
+	AUD16 = 0x18F,
+	AUD17 = 0x190,
+	AUD18 = 0x191,
+	RMIXOUTSEL = 0x192,
+	ANALOGLBR = 0x193,
+	ANALOGLBL = 0x194,
+	POWERCTRL1 = 0x195,
+	POWERCTRL2 = 0x196,
+	HEADSETDETECTINT = 0x197,
+	HEADSETDETECTINTMASK = 0x198,
+	TRIMENABLE = 0x199,
+};
+
+int rev_id = 0x20;
+
+/****
+ * fs_init_card - initialize the sound card
+ *
+ * This initilizes the audio paths to know values in case of this sound card
+ */
+static int fs_init_card(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{0x180, 0x00, 0x0},
+		{0x181, 0x00, 0x0},
+		{0x182, 0xF8, 0x0},
+		{0x183, 0x08, 0x0},
+		{0x184, 0x00, 0x0},
+		{0x185, 0x40, 0x0},
+		{0x186, 0x06, 0x0},
+		{0x187, 0x80, 0x0},
+		{0x188, 0x40, 0x0},
+		{0x189, 0x39, 0x0},
+		{0x18a, 0x39, 0x0},
+		{0x18b, 0x1F, 0x0},
+		{0x18c, 0x00, 0x0},
+		{0x18d, 0x00, 0x0},
+		{0x18e, 0x39, 0x0},
+		{0x18f, 0x39, 0x0},
+		{0x190, 0x39, 0x0},
+		{0x191, 0x11, 0x0},
+		{0x192, 0x0E, 0x0},
+		{0x193, 0x00, 0x0},
+		{0x194, 0x00, 0x0},
+		{0x195, 0x00, 0x0},
+		{0x196, 0x7C, 0x0},
+		{0x197, 0x00, 0x0},
+		{0x198, 0x0B, 0x0},
+		{0x199, 0x00, 0x0},
+		{0x037, 0x3F, 0x0},
+	};
+
+	snd_pmic_ops_fs.card_status = SND_CARD_INIT_DONE;
+	snd_pmic_ops_fs.master_mute = UNMUTE;
+	snd_pmic_ops_fs.mute_status = UNMUTE;
+	snd_pmic_ops_fs.num_channel = 2;
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, 27);
+}
+
+static int fs_enable_audiodac(int value)
+{
+	struct sc_reg_access sc_access[3];
+	sc_access[0].reg_addr = AUD16;
+	sc_access[1].reg_addr = AUD17;
+	sc_access[2].reg_addr = AUD15;
+	sc_access[0].mask = sc_access[1].mask = sc_access[2].mask = MASK7;
+
+	if (snd_pmic_ops_fs.mute_status == MUTE)
+		return 0;
+	if (value == MUTE) {
+			sc_access[0].value = sc_access[1].value =
+				sc_access[2].value = 0x80;
+
+		} else {
+			sc_access[0].value = sc_access[1].value =
+			sc_access[2].value =  0x0;
+		}
+	if (snd_pmic_ops_fs.num_channel == 1)
+		sc_access[1].value = sc_access[2].value = 0x80;
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 3);
+
+}
+
+static int fs_power_up_pb(unsigned int port)
+{
+	struct sc_reg_access sc_access[] = {
+		{AUDIOBIAS, 0x00, MASK7},
+		{POWERCTRL1, 0xC6, 0xC6},
+		{POWERCTRL2, 0x30, 0x30},
+
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	retval = fs_enable_audiodac(MUTE);
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 3);
+
+	if (retval)
+		return retval;
+
+	pr_debug("sst: in fs power up pb\n");
+	return fs_enable_audiodac(UNMUTE);
+}
+
+static int fs_power_down_pb(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{POWERCTRL1, 0x00, 0xC6},
+		{POWERCTRL2, 0x00, 0x30},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	retval = fs_enable_audiodac(MUTE);
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+	if (retval)
+		return retval;
+
+	pr_debug("sst: in fsl power down pb\n");
+	return fs_enable_audiodac(UNMUTE);
+}
+
+static int fs_power_up_cp(unsigned int port)
+{
+	struct sc_reg_access sc_access[] = {
+		{POWERCTRL2, 0x32, 0x32}, /*NOTE power up A ADC only as*/
+		{AUDIOBIAS, 0x00, MASK7},
+					/*as turning on V ADC causes noise*/
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+}
+
+static int fs_power_down_cp(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{POWERCTRL2, 0x00, 0x03},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+}
+
+static int fs_power_down(void)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access[] = {
+		{AUDIOBIAS, MASK7, MASK7},
+	};
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+}
+
+static int fs_set_pcm_voice_params(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{0x180, 0xA0, 0},
+		{0x181, 0x04, 0},
+		{0x182, 0x0, 0},
+		{0x183, 0x0, 0},
+		{0x184, 0x18, 0},
+		{0x185, 0x40, 0},
+		{0x186, 0x06, 0},
+		{0x187, 0x0, 0},
+		{0x188, 0x10, 0},
+		{0x189, 0x39, 0},
+		{0x18a, 0x39, 0},
+		{0x18b, 0x02, 0},
+		{0x18c, 0x0, 0},
+		{0x18d, 0x0, 0},
+		{0x18e, 0x39, 0},
+		{0x18f, 0x0, 0},
+		{0x190, 0x0, 0},
+		{0x191, 0x20, 0},
+		{0x192, 0x20, 0},
+		{0x193, 0x0, 0},
+		{0x194, 0x0, 0},
+		{0x195, 0x06, 0},
+		{0x196, 0x25, 0},
+		{0x197, 0x0, 0},
+		{0x198, 0xF, 0},
+		{0x199, 0x0, 0},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, 26);
+}
+
+static int fs_set_audio_port(int status)
+{
+	struct sc_reg_access sc_access[2];
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	if (status == DEACTIVATE) {
+		/* Deactivate audio port-tristate and power */
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6|MASK7;
+		sc_access[0].reg_addr = AUDIOPORT1;
+		sc_access[1].value = 0x00;
+		sc_access[1].mask = MASK4|MASK5;
+		sc_access[1].reg_addr = POWERCTRL2;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	} else if (status == ACTIVATE) {
+		/* activate audio port */
+		sc_access[0].value = 0xC0;
+		sc_access[0].mask = MASK6|MASK7;
+		sc_access[0].reg_addr = AUDIOPORT1;
+		sc_access[1].value = 0x30;
+		sc_access[1].mask = MASK4|MASK5;
+		sc_access[1].reg_addr = POWERCTRL2;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	} else
+		return -EINVAL;
+}
+
+static int fs_set_voice_port(int status)
+{
+	struct sc_reg_access sc_access[2];
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	if (status == DEACTIVATE) {
+		/* Deactivate audio port-tristate and power */
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6|MASK7;
+		sc_access[0].reg_addr = VOICEPORT1;
+		sc_access[1].value = 0x00;
+		sc_access[1].mask = MASK0|MASK1;
+		sc_access[1].reg_addr = POWERCTRL2;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	} else if (status == ACTIVATE) {
+		/* activate audio port */
+		sc_access[0].value = 0xC0;
+		sc_access[0].mask = MASK6|MASK7;
+		sc_access[0].reg_addr = VOICEPORT1;
+		sc_access[1].value = 0x03;
+		sc_access[1].mask = MASK0|MASK1;
+		sc_access[1].reg_addr = POWERCTRL2;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	} else
+		return -EINVAL;
+}
+
+static int fs_set_pcm_audio_params(int sfreq, int word_size, int num_channel)
+{
+	u8 config1 = 0;
+	struct sc_reg_access sc_access[4];
+	int retval = 0, num_value = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+	switch (sfreq) {
+	case 8000:
+		config1 = 0x00;
+		break;
+	case 11025:
+		config1 = 0x01;
+		break;
+	case 12000:
+		config1 = 0x02;
+		break;
+	case 16000:
+		config1 = 0x03;
+		break;
+	case 22050:
+		config1 = 0x04;
+		break;
+	case 24000:
+		config1 = 0x05;
+		break;
+	case 26000:
+		config1 = 0x06;
+		break;
+	case 32000:
+		config1 = 0x07;
+		break;
+	case 44100:
+		config1 = 0x08;
+		break;
+	case 48000:
+		config1 = 0x09;
+		break;
+	}
+	snd_pmic_ops_fs.num_channel = num_channel;
+	if (snd_pmic_ops_fs.num_channel == 1)	{
+		sc_access[0].reg_addr = AUD17;
+		sc_access[1].reg_addr = AUD15;
+		sc_access[0].mask = sc_access[1].mask = MASK7;
+		sc_access[0].value = sc_access[1].value = 0x80;
+		sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+	} else {
+		sc_access[0].reg_addr = AUD17;
+		sc_access[1].reg_addr = AUD15;
+		sc_access[0].mask = sc_access[1].mask = MASK7;
+		sc_access[0].value = sc_access[1].value = 0x00;
+		sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+	}
+	pr_debug("sst: sfreq:%d,Register value = %x\n", sfreq, config1);
+
+	if (word_size == 24) {
+		sc_access[0].reg_addr  = AUDIOPORT1;
+		sc_access[0].mask = MASK0|MASK1|MASK2|MASK3;
+		sc_access[0].value = 0xFB;
+
+
+		sc_access[1].reg_addr  = AUDIOPORT2;
+		sc_access[1].value = config1 | 0x10;
+		sc_access[1].mask = MASK0 | MASK1 | MASK2 | MASK3
+					| MASK4 | MASK5 | MASK6;
+
+		sc_access[2].reg_addr  = MISCAUDCTRL;
+		sc_access[2].value = 0x02;
+		sc_access[2].mask = 0x02;
+
+		num_value = 3 ;
+
+	} else {
+
+		sc_access[0].reg_addr  = AUDIOPORT2;
+		sc_access[0].value = config1;
+		sc_access[0].mask = MASK0|MASK1|MASK2|MASK3;
+
+		sc_access[1].reg_addr  = MISCAUDCTRL;
+		sc_access[1].value = 0x00;
+		sc_access[1].mask = 0x02;
+		num_value = 2;
+	}
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, num_value);
+
+}
+
+static int fs_set_selected_input_dev(u8 value)
+{
+	struct sc_reg_access sc_access_dmic[] = {
+		{MICCTRL, 0x81, 0xf7},
+		{MICLICTRL3, 0x00, 0xE0},
+	};
+	struct sc_reg_access sc_access_mic[] = {
+		{MICCTRL, 0x40, MASK2|MASK4|MASK5|MASK6|MASK7},
+		{MICLICTRL3, 0x00, 0xE0},
+	};
+	struct sc_reg_access sc_access_hsmic[] = {
+		{MICCTRL, 0x10, MASK2|MASK4|MASK5|MASK6|MASK7},
+		{MICLICTRL3, 0x00, 0xE0},
+	};
+
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+
+	switch (value) {
+	case AMIC:
+		pr_debug("sst: Selecting amic not supported in mono cfg\n");
+		return sst_sc_reg_access(sc_access_mic, PMIC_READ_MODIFY, 2);
+		break;
+
+	case HS_MIC:
+		pr_debug("sst: Selecting hsmic\n");
+		return sst_sc_reg_access(sc_access_hsmic,
+				PMIC_READ_MODIFY, 2);
+		break;
+
+	case DMIC:
+		pr_debug("sst: Selecting dmic\n");
+		return sst_sc_reg_access(sc_access_dmic, PMIC_READ_MODIFY, 2);
+		break;
+
+	default:
+		return -EINVAL;
+
+	}
+}
+
+static int fs_set_selected_output_dev(u8 value)
+{
+	struct sc_reg_access sc_access_hp[] = {
+		{0x191, 0x11, 0x0},
+		{0x192, 0x0E, 0x0},
+	};
+	struct sc_reg_access sc_access_is[] = {
+		{0x191, 0x17, 0xFF},
+		{0x192, 0x08, 0xFF},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+
+	switch (value) {
+	case STEREO_HEADPHONE:
+		pr_debug("SST DBG:Selecting headphone\n");
+		return sst_sc_reg_access(sc_access_hp, PMIC_WRITE, 2);
+		break;
+	case MONO_EARPIECE:
+	case INTERNAL_SPKR:
+		pr_debug("SST DBG:Selecting internal spkr\n");
+		return sst_sc_reg_access(sc_access_is, PMIC_READ_MODIFY, 2);
+		break;
+
+	default:
+		return -EINVAL;
+
+	}
+}
+
+static int fs_set_mute(int dev_id, u8 value)
+{
+	struct sc_reg_access sc_access[6] = {{0,},};
+	int reg_num = 0;
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+
+
+	pr_debug("sst: dev_id:0x%x value:0x%x\n", dev_id, value);
+	switch (dev_id) {
+	case PMIC_SND_DMIC_MUTE:
+		sc_access[0].reg_addr = MICCTRL;
+		sc_access[1].reg_addr = MICLICTRL1;
+		sc_access[2].reg_addr = MICLICTRL2;
+		sc_access[0].mask = MASK5;
+		sc_access[1].mask = sc_access[2].mask = MASK6;
+		if (value == MUTE) {
+			sc_access[0].value = 0x20;
+			sc_access[2].value = sc_access[1].value = 0x40;
+		} else
+			sc_access[0].value = sc_access[1].value
+			= sc_access[2].value = 0x0;
+		reg_num = 3;
+		break;
+	case PMIC_SND_HP_MIC_MUTE:
+	case PMIC_SND_AMIC_MUTE:
+		sc_access[0].reg_addr = MICLICTRL1;
+		sc_access[1].reg_addr = MICLICTRL2;
+		sc_access[0].mask = sc_access[1].mask = MASK6;
+		if (value == MUTE)
+			sc_access[0].value = sc_access[1].value = 0x40;
+		else
+			sc_access[0].value = sc_access[1].value = 0x0;
+		reg_num = 2;
+		break;
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+	case PMIC_SND_LEFT_HP_MUTE:
+		sc_access[0].reg_addr = AUD16;
+		sc_access[1].reg_addr = AUD15;
+
+		sc_access[0].mask = sc_access[1].mask = MASK7;
+		if (value == MUTE)
+			sc_access[0].value = sc_access[1].value = 0x80;
+		else
+			sc_access[0].value = sc_access[1].value = 0x0;
+		reg_num = 2;
+		snd_pmic_ops_fs.mute_status = value;
+		break;
+	case PMIC_SND_RIGHT_HP_MUTE:
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		sc_access[0].reg_addr = AUD17;
+		sc_access[1].reg_addr = AUD15;
+		sc_access[0].mask = sc_access[1].mask = MASK7;
+		if (value == MUTE)
+			sc_access[0].value = sc_access[1].value = 0x80;
+		else
+			sc_access[0].value = sc_access[1].value = 0x0;
+		snd_pmic_ops_fs.mute_status = value;
+		if (snd_pmic_ops_fs.num_channel == 1)
+			sc_access[0].value = sc_access[1].value = 0x80;
+		reg_num = 2;
+		break;
+	case PMIC_SND_MUTE_ALL:
+		sc_access[0].reg_addr = AUD16;
+		sc_access[1].reg_addr = AUD17;
+		sc_access[2].reg_addr = AUD15;
+		sc_access[3].reg_addr = MICCTRL;
+		sc_access[4].reg_addr = MICLICTRL1;
+		sc_access[5].reg_addr = MICLICTRL2;
+		sc_access[0].mask = sc_access[1].mask =
+				sc_access[2].mask = MASK7;
+		sc_access[3].mask = MASK5;
+		sc_access[4].mask = sc_access[5].mask = MASK6;
+
+		if (value == MUTE) {
+			sc_access[0].value =
+			sc_access[1].value = sc_access[2].value = 0x80;
+			sc_access[3].value = 0x20;
+			sc_access[4].value = sc_access[5].value = 0x40;
+
+		} else {
+			sc_access[0].value = sc_access[1].value =
+			sc_access[2].value = sc_access[3].value =
+			sc_access[4].value = sc_access[5].value = 0x0;
+		}
+		if (snd_pmic_ops_fs.num_channel == 1)
+			sc_access[1].value = sc_access[2].value = 0x80;
+		reg_num = 6;
+		snd_pmic_ops_fs.mute_status = value;
+		snd_pmic_ops_fs.master_mute = value;
+		break;
+
+	}
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, reg_num);
+}
+
+static int fs_set_vol(int dev_id, int value)
+{
+	struct sc_reg_access sc_acces, sc_access[4] = {{0},};
+	int reg_num = 0;
+	int retval = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+
+	switch (dev_id) {
+	case PMIC_SND_LEFT_PB_VOL:
+		pr_debug("sst: PMIC_SND_LEFT_PB_VOL:%d\n", value);
+		sc_access[0].value = sc_access[1].value = value;
+		sc_access[0].reg_addr = AUD16;
+		sc_access[1].reg_addr = AUD15;
+		sc_access[0].mask = sc_access[1].mask =
+			(MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		reg_num = 2;
+		break;
+
+	case PMIC_SND_RIGHT_PB_VOL:
+		pr_debug("sst: PMIC_SND_RIGHT_PB_VOL:%d\n", value);
+		sc_access[0].value = sc_access[1].value = value;
+		sc_access[0].reg_addr = AUD17;
+		sc_access[1].reg_addr = AUD15;
+		sc_access[0].mask = sc_access[1].mask =
+			(MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		if (snd_pmic_ops_fs.num_channel == 1) {
+			sc_access[0].value = sc_access[1].value = 0x80;
+			sc_access[0].mask = sc_access[1].mask = MASK7;
+		}
+		reg_num = 2;
+		break;
+	case PMIC_SND_CAPTURE_VOL:
+		pr_debug("sst: PMIC_SND_CAPTURE_VOL:%d\n", value);
+		sc_access[0].reg_addr = MICLICTRL1;
+		sc_access[1].reg_addr = MICLICTRL2;
+		sc_access[2].reg_addr = DMICCTRL1;
+		sc_access[2].value = value;
+		sc_access[0].value = sc_access[1].value = value;
+		sc_acces.reg_addr = MICLICTRL3;
+		sc_acces.value = value;
+		sc_acces.mask = (MASK0|MASK1|MASK2|MASK3|MASK5|MASK6|MASK7);
+		retval = sst_sc_reg_access(&sc_acces, PMIC_READ_MODIFY, 1);
+		sc_access[0].mask = sc_access[1].mask =
+		sc_access[2].mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		reg_num = 3;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, reg_num);
+}
+
+static int fs_get_mute(int dev_id, u8 *value)
+{
+	struct sc_reg_access sc_access[6] = {{0,},};
+
+	int retval = 0, temp_value = 0, mask = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+
+	switch (dev_id) {
+
+	case PMIC_SND_AMIC_MUTE:
+	case PMIC_SND_HP_MIC_MUTE:
+		sc_access[0].reg_addr = MICLICTRL1;
+		mask = MASK6;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (sc_access[0].value & mask)
+			*value = MUTE;
+		else
+			*value = UNMUTE;
+		break;
+	case PMIC_SND_DMIC_MUTE:
+		sc_access[0].reg_addr = MICCTRL;
+		mask = MASK5;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		temp_value = (sc_access[0].value & mask);
+		if (temp_value == 0)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		break;
+
+	case PMIC_SND_LEFT_HP_MUTE:
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		sc_access[0].reg_addr = AUD16;
+		mask = MASK7;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		temp_value = sc_access[0].value & mask;
+		if (temp_value == 0)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		break;
+	case PMIC_SND_RIGHT_HP_MUTE:
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		sc_access[0].reg_addr = AUD17;
+		mask = MASK7;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		temp_value = sc_access[0].value & mask;
+		if (temp_value == 0)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return retval;
+}
+
+static int fs_get_vol(int dev_id, int *value)
+{
+	struct sc_reg_access sc_access = {0,};
+	int retval = 0, mask = 0;
+
+	if (snd_pmic_ops_fs.card_status == SND_CARD_UN_INIT)
+		retval = fs_init_card();
+	if (retval)
+		return retval;
+
+	switch (dev_id) {
+	case PMIC_SND_CAPTURE_VOL:
+		pr_debug("sst: PMIC_SND_CAPTURE_VOL\n");
+		sc_access.reg_addr = MICLICTRL1;
+		mask = (MASK5|MASK4|MASK3|MASK2|MASK1|MASK0);
+		break;
+	case PMIC_SND_LEFT_PB_VOL:
+		pr_debug("sst: PMIC_SND_LEFT_PB_VOL\n");
+		sc_access.reg_addr = AUD16;
+		mask = (MASK5|MASK4|MASK3|MASK2|MASK1|MASK0);
+		break;
+	case PMIC_SND_RIGHT_PB_VOL:
+		pr_debug("sst: PMIC_SND_RT_PB_VOL\n");
+		sc_access.reg_addr = AUD17;
+		mask = (MASK5|MASK4|MASK3|MASK2|MASK1|MASK0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ, 1);
+	pr_debug("sst: value read = 0x%x\n", sc_access.value);
+	*value = (int) (sc_access.value & mask);
+	pr_debug("sst: value returned = 0x%x\n", *value);
+	return retval;
+}
+
+struct snd_pmic_ops snd_pmic_ops_fs = {
+	.set_input_dev = fs_set_selected_input_dev,
+	.set_output_dev = fs_set_selected_output_dev,
+	.set_mute = fs_set_mute,
+	.get_mute = fs_get_mute,
+	.set_vol = fs_set_vol,
+	.get_vol = fs_get_vol,
+	.init_card = fs_init_card,
+	.set_pcm_audio_params = fs_set_pcm_audio_params,
+	.set_pcm_voice_params = fs_set_pcm_voice_params,
+	.set_voice_port = fs_set_voice_port,
+	.set_audio_port = fs_set_audio_port,
+	.power_up_pmic_pb = fs_power_up_pb,
+	.power_up_pmic_cp = fs_power_up_cp,
+	.power_down_pmic_pb = fs_power_down_pb,
+	.power_down_pmic_cp = fs_power_down_cp,
+	.power_down_pmic = fs_power_down,
+};
diff --git a/drivers/staging/intel_sst/intelmid_v1_control.c b/drivers/staging/intel_sst/intelmid_v1_control.c
new file mode 100644
index 0000000..94d30a9
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_v1_control.c
@@ -0,0 +1,1072 @@
+/*  intel_sst_v1_control.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *	Harsha Priya <priya.harsha@intel.com>
+ *	Dharageswari R <dharageswari.r@intel.com>
+ *	KP Jeeja <jeeja.kp@intel.com>
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
+ *  This file contains the control operations of vendor 2
+ */
+
+#include <linux/pci.h>
+#include <linux/file.h>
+#include <asm/mrst.h>
+#include <sound/pcm.h>
+#include "jack.h"
+#include <sound/pcm_params.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include "intel_sst.h"
+#include "intel_sst_ioctl.h"
+#include "intelmid.h"
+#include "intelmid_snd_control.h"
+
+#include <linux/gpio.h>
+#define KOSKI_VOICE_CODEC_ENABLE 46
+
+enum _reg_v2 {
+
+	MASTER_CLOCK_PRESCALAR  = 0x205,
+	SET_MASTER_AND_LR_CLK1	= 0x20b,
+	SET_MASTER_AND_LR_CLK2	= 0x20c,
+	MASTER_MODE_AND_DATA_DELAY = 0x20d,
+	DIGITAL_INTERFACE_TO_DAI2 = 0x20e,
+	CLK_AND_FS1 = 0x208,
+	CLK_AND_FS2 = 0x209,
+	DAI2_TO_DAC_HP = 0x210,
+	HP_OP_SINGLE_ENDED = 0x224,
+	ENABLE_OPDEV_CTRL = 0x226,
+	ENABLE_DEV_AND_USE_XTAL = 0x227,
+
+	/* Max audio subsystem (PQ49) MAX 8921 */
+	AS_IP_MODE_CTL = 0xF9,
+	AS_LEFT_SPKR_VOL_CTL = 0xFA, /* Mono Earpiece volume control */
+	AS_RIGHT_SPKR_VOL_CTL = 0xFB,
+	AS_LEFT_HP_VOL_CTL = 0xFC,
+	AS_RIGHT_HP_VOL_CTL = 0xFD,
+	AS_OP_MIX_CTL = 0xFE,
+	AS_CONFIG = 0xFF,
+
+	/* Headphone volume control & mute registers */
+	VOL_CTRL_LT = 0x21c,
+	VOL_CTRL_RT = 0x21d,
+
+};
+/**
+ * mx_init_card - initilize the sound card
+ *
+ * This initilizes the audio paths to know values in case of this sound card
+ */
+static int mx_init_card(void)
+{
+	if (is_aava())  {
+
+		struct sc_reg_access sc_access[] = {
+			{0x200, 0x00, 0x0},
+			{0x201, 0xC0, 0x0},
+			{0x202, 0x00, 0x0},
+			{0x203, 0x00, 0x0},
+			{0x204, 0x0e, 0x0},
+			{0x205, 0x20, 0x0},
+			{0x206, 0x00, 0x0},
+			{0x207, 0x00, 0x0},
+			{0x208, 0x00, 0x0},
+			{0x209, 0x51, 0x0},
+			{0x20a, 0x00, 0x0},
+			{0x20b, 0x5a, 0x0},
+			{0x20c, 0xbe, 0x0},
+			{0x20d, 0x90, 0x0},
+			{0x20e, 0x51, 0x0},
+			{0x20f, 0x00, 0x0},
+			{0x210, 0x21, 0x0},
+			{0x211, 0x00, 0x0},
+			{0x212, 0x00, 0x0},
+			{0x213, 0x00, 0x0},
+			{0x214, 0x41, 0x0},
+			{0x215, 0x81, 0x0},
+			{0x216, 0x00, 0x0},
+			{0x217, 0x00, 0x0},
+			{0x218, 0x00, 0x0},
+			{0x219, 0x00, 0x0},
+			{0x21a, 0x00, 0x0},
+			{0x21b, 0x00, 0x0},
+			{0x21c, 0x00, 0x0},
+			{0x21d, 0x00, 0x0},
+			{0x21e, 0x00, 0x0},
+			{0x21f, 0x00, 0x0},
+			{0x220, 0x00, 0x0},
+			{0x221, 0x00, 0x0},
+			{0x222, 0x51, 0x0},
+			{0x223, 0x20, 0x0}, /* Jack detection: 00 -> 01 */
+			{0x224, 0x40, 0x0},
+			{0x225, 0x80, 0x0}, /* JAck detection: 00 -> 80 */
+			{0x226, 0x00, 0x0},
+			{0x227, 0x00, 0x0},
+			{0xf9, 0x40, 0x0},
+			{0xfa, 0x1F, 0x0},
+			{0xfb, 0x1F, 0x0},
+			{0xfc, 0x1F, 0x0},
+			{0xfd, 0x1F, 0x0},
+			{0xfe, 0x00, 0x0},
+			{0xff, 0x00, 0x0}, /* Removed sel_output */
+		};
+		int retval;
+
+		/*init clock sig to voice codec*/
+		retval = gpio_request(KOSKI_VOICE_CODEC_ENABLE,
+					"sound_voice_codec");
+		if (retval) {
+			pr_err("sst: Error enabling voice codec clock\n");
+		} else {
+			gpio_direction_output(KOSKI_VOICE_CODEC_ENABLE, 1);
+			pr_debug("sst: Voice codec clock enabled\n");
+		}
+
+		snd_pmic_ops_mx.card_status = SND_CARD_INIT_DONE;
+		snd_pmic_ops_mx.master_mute = UNMUTE;
+		snd_pmic_ops_mx.mute_status = UNMUTE;
+		snd_pmic_ops_mx.num_channel = 2;
+		pr_debug("**************inside aava\n");
+		return sst_sc_reg_access(sc_access, PMIC_WRITE, 47);
+	} else {
+		struct sc_reg_access sc_access[] = {
+			{0x200, 0x80, 0x00},
+			{0x201, 0xC0, 0x00},
+			{0x202, 0x00, 0x00},
+			{0x203, 0x00, 0x00},
+			{0x204, 0x02, 0x00},
+			{0x205, 0x10, 0x00},
+			{0x206, 0x60, 0x00},
+			{0x207, 0x00, 0x00},
+			{0x208, 0x90, 0x00},
+			{0x209, 0x51, 0x00},
+			{0x20a, 0x00, 0x00},
+			{0x20b, 0x10, 0x00},
+			{0x20c, 0x00, 0x00},
+			{0x20d, 0x00, 0x00},
+			{0x20e, 0x21, 0x00},
+			{0x20f, 0x00, 0x00},
+			{0x210, 0x84, 0x00},
+			{0x211, 0xB3, 0x00},
+			{0x212, 0x00, 0x00},
+			{0x213, 0x00, 0x00},
+			{0x214, 0x41, 0x00},
+			{0x215, 0x00, 0x00},
+			{0x216, 0x00, 0x00},
+			{0x217, 0x00, 0x00},
+			{0x218, 0x03, 0x00},
+			{0x219, 0x03, 0x00},
+			{0x21a, 0x00, 0x00},
+			{0x21b, 0x00, 0x00},
+			{0x21c, 0x00, 0x00},
+			{0x21d, 0x00, 0x00},
+			{0x21e, 0x00, 0x00},
+			{0x21f, 0x00, 0x00},
+			{0x220, 0x20, 0x00},
+			{0x221, 0x20, 0x00},
+			{0x222, 0x51, 0x00},
+			{0x223, 0x20, 0x00},
+			{0x224, 0x04, 0x00},
+			{0x225, 0x80, 0x00},
+			{0x226, 0x0F, 0x00},
+			{0x227, 0x08, 0x00},
+			{0xf9,  0x40, 0x00},
+			{0xfa,  0x1f, 0x00},
+			{0xfb,  0x1f, 0x00},
+			{0xfc,  0x1f, 0x00},
+			{0xfd,  0x1f, 0x00},
+			{0xfe,  0x00, 0x00},
+			{0xff,  0x0c, 0x00},
+		};
+		snd_pmic_ops_mx.card_status = SND_CARD_INIT_DONE;
+		snd_pmic_ops_mx.num_channel = 2;
+		snd_pmic_ops_mx.master_mute = UNMUTE;
+		snd_pmic_ops_mx.mute_status = UNMUTE;
+		return sst_sc_reg_access(sc_access, PMIC_WRITE, 47);
+	}
+}
+
+static int mx_init_capture_card(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{0x206, 0x5a, 0x0},
+		{0x207, 0xbe, 0x0},
+		{0x208, 0x90, 0x0},
+		{0x209, 0x32, 0x0},
+		{0x20e, 0x22, 0x0},
+		{0x210, 0x84, 0x0},
+		{0x223, 0x20, 0x0},
+		{0x226, 0xC0, 0x0},
+	};
+
+	int retval = 0;
+
+	retval = sst_sc_reg_access(sc_access, PMIC_WRITE, 8);
+	if (0 != retval) {
+		/* pmic communication fails */
+		pr_debug("sst: pmic commn failed\n");
+		return retval;
+	}
+
+	pr_debug("sst: Capture configuration complete!!\n");
+	return 0;
+}
+
+static int mx_init_playback_card(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{0x206, 0x00, 0x0},
+		{0x207, 0x00, 0x0},
+		{0x208, 0x00, 0x0},
+		{0x209, 0x51, 0x0},
+		{0x20e, 0x51, 0x0},
+		{0x210, 0x21, 0x0},
+		{0x223, 0x01, 0x0},
+	};
+	int retval = 0;
+
+	retval = sst_sc_reg_access(sc_access, PMIC_WRITE, 9);
+	if (0 != retval) {
+		/* pmic communication fails */
+		pr_debug("sst: pmic commn failed\n");
+		return retval;
+	}
+
+	pr_debug("sst: Playback configuration complete!!\n");
+	return 0;
+}
+
+static int mx_enable_audiodac(int value)
+{
+	struct sc_reg_access sc_access[3];
+	int mute_val = 0;
+	int mute_val1 = 0;
+	int retval = 0;
+
+	sc_access[0].reg_addr = AS_LEFT_HP_VOL_CTL;
+	sc_access[1].reg_addr = AS_RIGHT_HP_VOL_CTL;
+
+	if (value == UNMUTE) {
+		mute_val = 0x1F;
+		mute_val1 = 0x00;
+	} else {
+		mute_val = 0x00;
+		mute_val1 = 0x40;
+	}
+	sc_access[0].mask = sc_access[1].mask = MASK0|MASK1|MASK2|MASK3|MASK4;
+	sc_access[0].value = sc_access[1].value = (u8)mute_val;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	if (retval)
+		return retval;
+	pr_debug("sst: mute status = %d", snd_pmic_ops_mx.mute_status);
+	if (snd_pmic_ops_mx.mute_status == MUTE ||
+				snd_pmic_ops_mx.master_mute == MUTE)
+		return retval;
+
+	sc_access[0].reg_addr = VOL_CTRL_LT;
+	sc_access[1].reg_addr = VOL_CTRL_RT;
+	sc_access[0].mask = sc_access[1].mask = MASK6;
+	sc_access[0].value = sc_access[1].value = mute_val1;
+	if (snd_pmic_ops_mx.num_channel == 1)
+		sc_access[1].value = 0x40;
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+}
+
+static int mx_power_up_pb(unsigned int port)
+{
+
+	int retval = 0;
+	struct sc_reg_access sc_access[3];
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	if ((is_aava()) && port == 1)
+		mx_init_playback_card();
+	retval = mx_enable_audiodac(MUTE);
+	if (retval)
+		return retval;
+
+	msleep(10);
+
+	sc_access[0].reg_addr = AS_CONFIG;
+	sc_access[0].mask  = MASK7;
+	sc_access[0].value = 0x80;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	sc_access[0].reg_addr = ENABLE_OPDEV_CTRL;
+	sc_access[0].mask  = 0xff;
+	sc_access[0].value = 0x3C;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	sc_access[0].reg_addr = ENABLE_DEV_AND_USE_XTAL;
+	sc_access[0].mask  = 0x80;
+	sc_access[0].value = 0x80;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	return mx_enable_audiodac(UNMUTE);
+}
+
+static int mx_power_down_pb(void)
+{
+	struct sc_reg_access sc_access[3];
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+
+	retval = mx_enable_audiodac(MUTE);
+	if (retval)
+		return retval;
+
+	sc_access[0].reg_addr = ENABLE_OPDEV_CTRL;
+	sc_access[0].mask  = MASK3|MASK2;
+	sc_access[0].value = 0x00;
+
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	return mx_enable_audiodac(UNMUTE);
+}
+
+static int mx_power_up_cp(unsigned int port)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access[] = {
+		{ENABLE_DEV_AND_USE_XTAL, 0x80, MASK7},
+		{ENABLE_OPDEV_CTRL, 0x3, 0x3},
+	};
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+
+	if (is_aava()) {
+		retval = mx_init_capture_card();
+		if (retval)
+			return retval;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	} else
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+}
+
+static int mx_power_down_cp(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{ENABLE_OPDEV_CTRL, 0x00, MASK1|MASK0},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+}
+
+static int mx_power_down(void)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access[3];
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+
+	retval = mx_enable_audiodac(MUTE);
+	if (retval)
+		return retval;
+
+	sc_access[0].reg_addr = AS_CONFIG;
+	sc_access[0].mask  = MASK7;
+	sc_access[0].value = 0x00;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	sc_access[0].reg_addr = ENABLE_DEV_AND_USE_XTAL;
+	sc_access[0].mask  = MASK7;
+	sc_access[0].value = 0x00;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	sc_access[0].reg_addr = ENABLE_OPDEV_CTRL;
+	sc_access[0].mask  = MASK3|MASK2;
+	sc_access[0].value = 0x00;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (retval)
+		return retval;
+
+	return mx_enable_audiodac(UNMUTE);
+}
+
+static int mx_set_pcm_voice_params(void)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access[] = {
+		{0x200, 0x80, 0x00},
+		{0x201, 0xC0, 0x00},
+		{0x202, 0x00, 0x00},
+		{0x203, 0x00, 0x00},
+		{0x204, 0x0e, 0x00},
+		{0x205, 0x20, 0x00},
+		{0x206, 0x8f, 0x00},
+		{0x207, 0x21, 0x00},
+		{0x208, 0x18, 0x00},
+		{0x209, 0x32, 0x00},
+		{0x20a, 0x00, 0x00},
+		{0x20b, 0x5A, 0x00},
+		{0x20c, 0xBE, 0x00},/* 0x00 -> 0xBE Koski */
+		{0x20d, 0x00, 0x00}, /* DAI2 'off' */
+		{0x20e, 0x40, 0x00},
+		{0x20f, 0x00, 0x00},
+		{0x210, 0x84, 0x00},
+		{0x211, 0x33, 0x00}, /* Voice filter */
+		{0x212, 0x00, 0x00},
+		{0x213, 0x00, 0x00},
+		{0x214, 0x41, 0x00},
+		{0x215, 0x00, 0x00},
+		{0x216, 0x00, 0x00},
+		{0x217, 0x20, 0x00},
+		{0x218, 0x00, 0x00},
+		{0x219, 0x00, 0x00},
+		{0x21a, 0x40, 0x00},
+		{0x21b, 0x40, 0x00},
+		{0x21c, 0x09, 0x00},
+		{0x21d, 0x09, 0x00},
+		{0x21e, 0x00, 0x00},
+		{0x21f, 0x00, 0x00},
+		{0x220, 0x00, 0x00}, /* Microphone configurations */
+		{0x221, 0x00, 0x00}, /* Microphone configurations */
+		{0x222, 0x50, 0x00}, /* Microphone configurations */
+		{0x223, 0x21, 0x00}, /* Microphone configurations */
+		{0x224, 0x00, 0x00},
+		{0x225, 0x80, 0x00},
+		{0xf9, 0x40, 0x00},
+		{0xfa, 0x19, 0x00},
+		{0xfb, 0x19, 0x00},
+		{0xfc, 0x12, 0x00},
+		{0xfd, 0x12, 0x00},
+		{0xfe, 0x00, 0x00},
+	};
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	pr_debug("sst: SST DBG mx_set_pcm_voice_params called\n");
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, 44);
+}
+
+static int mx_set_pcm_audio_params(int sfreq, int word_size, int num_channel)
+{
+	int retval = 0;
+
+	if (!is_aava()) {
+		int config1 = 0, config2 = 0, filter = 0xB3;
+		struct sc_reg_access sc_access[5];
+
+		if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+			retval = mx_init_card();
+			if (retval)
+				return retval;
+		}
+
+		switch (sfreq) {
+		case 8000:
+			config1 = 0x10;
+			config2 = 0x00;
+			filter = 0x33;
+			break;
+		case 11025:
+			config1 = 0x16;
+			config2 = 0x0d;
+			break;
+		case 12000:
+			config1 = 0x18;
+			config2 = 0x00;
+			break;
+		case 16000:
+			config1 = 0x20;
+			config2 = 0x00;
+			break;
+		case 22050:
+			config1 = 0x2c;
+			config2 = 0x1a;
+			break;
+		case 24000:
+			config1 = 0x30;
+			config2 = 0x00;
+			break;
+		case 32000:
+			config1 = 0x40;
+			config2 = 0x00;
+			break;
+		case 44100:
+			config1 = 0x58;
+			config2 = 0x33;
+			break;
+		case 48000:
+			config1 = 0x60;
+			config2 = 0x00;
+			break;
+		}
+
+		snd_pmic_ops_mx.num_channel = num_channel;
+		/*mute the right channel if MONO*/
+		if (snd_pmic_ops_mx.num_channel == 1)	{
+
+			sc_access[0].reg_addr = VOL_CTRL_RT;
+			sc_access[0].value = 0x40;
+			sc_access[0].mask = MASK6;
+
+			sc_access[1].reg_addr = 0x224;
+			sc_access[1].value = 0x05;
+			sc_access[1].mask = MASK0|MASK1|MASK2;
+
+			retval = sst_sc_reg_access(sc_access,
+					PMIC_READ_MODIFY, 2);
+			if (retval)
+				return retval;
+		} else {
+			sc_access[0].reg_addr = VOL_CTRL_RT;
+			sc_access[0].value = 0x00;
+			sc_access[0].mask = MASK6;
+
+			sc_access[1].reg_addr = 0x224;
+			sc_access[1].value = 0x04;
+			sc_access[1].mask = MASK0|MASK1|MASK2;
+
+			retval = sst_sc_reg_access(sc_access,
+					PMIC_READ_MODIFY, 2);
+			if (retval)
+				return retval;
+		}
+		sc_access[0].reg_addr =	0x206;
+		sc_access[0].value = config1;
+		sc_access[1].reg_addr = 0x207;
+		sc_access[1].value = config2;
+
+		if (word_size == 16) {
+			sc_access[2].value = 0x51;
+			sc_access[3].value = 0x31;
+		} else if (word_size == 24) {
+			sc_access[2].value = 0x52;
+			sc_access[3].value = 0x92;
+		}
+
+		sc_access[2].reg_addr = 0x209;
+		sc_access[3].reg_addr = 0x20e;
+
+		sc_access[4].reg_addr = 0x211;
+		sc_access[4].value = filter;
+
+		return sst_sc_reg_access(sc_access, PMIC_WRITE, 5);
+	} else {
+		int config1 = 0, config2 = 0, filter = 0x00;
+		struct sc_reg_access sc_access[5];
+
+		pr_debug("sst: mx_set_pcm_audio_params - inside AAVA\n");
+
+		if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+			retval = mx_init_card();
+			if (retval)
+				return retval;
+		}
+
+		switch (sfreq) {
+		case 8000:
+			config1 = 0x20;
+			config2 = 0x0f;
+			filter = 0x33;
+			break;
+		case 11025:
+			config1 = 0x14;
+			config2 = 0xd8;
+			break;
+		case 12000:
+			config1 = 0x16;
+			config2 = 0xaf;
+			break;
+		case 16000:
+			config1 = 0x1e;
+			config2 = 0x3f;
+			break;
+		case 22050:
+			config1 = 0x29;
+			config2 = 0xaf;
+			break;
+		case 24000:
+			config1 = 0x2d;
+			config2 = 0x5f;
+			break;
+		case 32000:
+			config1 = 0x3c;
+			config2 = 0x7f;
+			break;
+		case 44100:
+			config1 = 0x53;
+			config2 = 0x5f;
+			break;
+		case 48000:
+			config1 = 0x5a;
+			config2 = 0xbe;
+			break;
+		}
+
+		snd_pmic_ops_mx.num_channel = num_channel;
+		/*mute the right channel if MONO*/
+		sc_access[0].reg_addr =	0x20b;
+		sc_access[0].value = config1;
+		sc_access[1].reg_addr = 0x20c;
+		sc_access[1].value = config2;
+		if (word_size == 16) {
+			sc_access[2].value = 0x51;
+			sc_access[3].value = 0x51;
+		} else if (word_size == 24) {
+			sc_access[2].value = 0x52;
+			sc_access[3].value = 0x92;
+
+		}
+
+		sc_access[2].reg_addr = 0x209;
+		sc_access[3].reg_addr = 0x20e;
+		sc_access[4].reg_addr = 0x211;
+		sc_access[4].value = filter;
+
+		return sst_sc_reg_access(sc_access, PMIC_WRITE, 5);
+	}
+	return 0;
+}
+
+static int mx_set_selected_output_dev(u8 dev_id)
+{
+	struct sc_reg_access sc_access[2];
+	int num_reg = 0;
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+
+	pr_debug("sst: mx_set_selected_output_dev dev_id:0x%x\n", dev_id);
+	snd_pmic_ops_mx.output_dev_id = dev_id;
+	switch (dev_id) {
+	case STEREO_HEADPHONE:
+		sc_access[0].reg_addr = 0xFF;
+		sc_access[0].value = 0x8C;
+		sc_access[0].mask =
+			MASK2|MASK3|MASK5|MASK6|MASK4;
+
+		num_reg = 1;
+		break;
+	case MONO_EARPIECE:
+	case INTERNAL_SPKR:
+		sc_access[0].reg_addr = 0xFF;
+		sc_access[0].value = 0xb0;
+		sc_access[0].mask =  MASK2|MASK3|MASK5|MASK6|MASK4;
+
+		num_reg = 1;
+		break;
+	case RECEIVER:
+		pr_debug("sst: RECEIVER Koski selected\n");
+
+		/* configuration - AS enable, receiver enable */
+		sc_access[0].reg_addr = 0xFF;
+		sc_access[0].value = 0x81;
+		sc_access[0].mask = 0xff;
+
+		num_reg = 1;
+		break;
+	default:
+		pr_err("sst: Not a valid output dev\n");
+		return 0;
+	}
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, num_reg);
+}
+
+
+static int mx_set_voice_port(int status)
+{
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	if (status == ACTIVATE)
+		retval = mx_set_pcm_voice_params();
+
+	return retval;
+}
+
+static int mx_set_audio_port(int status)
+{
+	int retval = 0;
+	if (is_aava()) {
+		if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT)
+			retval = mx_init_card();
+		if (retval)
+			return retval;
+		if (status == ACTIVATE) {
+			mx_init_card();
+			mx_set_selected_output_dev
+					(snd_pmic_ops_mx.output_dev_id);
+		}
+	}
+	return retval;
+
+}
+
+static int mx_set_selected_input_dev(u8 dev_id)
+{
+	struct sc_reg_access sc_access[2];
+	int num_reg = 0;
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	snd_pmic_ops_mx.input_dev_id = dev_id;
+	pr_debug("sst: mx_set_selected_input_dev dev_id:0x%x\n", dev_id);
+
+	switch (dev_id) {
+	case AMIC:
+		sc_access[0].reg_addr = 0x223;
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK7|MASK6|MASK5|MASK4|MASK0;
+		sc_access[1].reg_addr = 0x222;
+		sc_access[1].value = 0x50;
+		sc_access[1].mask = MASK7|MASK6|MASK5|MASK4;
+		num_reg = 2;
+		break;
+
+	case HS_MIC:
+		sc_access[0].reg_addr = 0x223;
+		sc_access[0].value = 0x20;
+		sc_access[0].mask = MASK7|MASK6|MASK5|MASK4|MASK0;
+		sc_access[1].reg_addr = 0x222;
+		sc_access[1].value = 0x51;
+		sc_access[1].mask = MASK7|MASK6|MASK5|MASK4;
+		num_reg = 2;
+		break;
+	case DMIC:
+		sc_access[1].reg_addr = 0x222;
+		sc_access[1].value = 0x00;
+		sc_access[1].mask = MASK7|MASK6|MASK5|MASK4|MASK0;
+		sc_access[0].reg_addr = 0x223;
+		sc_access[0].value = 0x20;
+		sc_access[0].mask = MASK7|MASK6|MASK5|MASK4|MASK0;
+		num_reg = 2;
+		break;
+	}
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, num_reg);
+}
+
+static int mx_set_mute(int dev_id, u8 value)
+{
+	struct sc_reg_access sc_access[5];
+	int num_reg = 0;
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+
+
+	pr_debug("sst: set_mute dev_id:0x%x , value:%d\n", dev_id, value);
+
+	switch (dev_id) {
+	case PMIC_SND_DMIC_MUTE:
+	case PMIC_SND_AMIC_MUTE:
+	case PMIC_SND_HP_MIC_MUTE:
+		sc_access[0].reg_addr =	0x220;
+		sc_access[1].reg_addr =	0x221;
+		sc_access[2].reg_addr =	0x223;
+		if (value == MUTE) {
+			sc_access[0].value = 0x00;
+			sc_access[1].value = 0x00;
+			if (snd_pmic_ops_mx.input_dev_id == DMIC)
+				sc_access[2].value = 0x00;
+			else
+				sc_access[2].value = 0x20;
+		} else {
+			sc_access[0].value = 0x20;
+			sc_access[1].value = 0x20;
+			if (snd_pmic_ops_mx.input_dev_id == DMIC)
+				sc_access[2].value = 0x20;
+			else
+				sc_access[2].value = 0x00;
+		}
+		sc_access[0].mask = MASK5|MASK6;
+		sc_access[1].mask = MASK5|MASK6;
+		sc_access[2].mask = MASK5|MASK6;
+		num_reg = 3;
+		break;
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+	case PMIC_SND_LEFT_HP_MUTE:
+		sc_access[0].reg_addr =	VOL_CTRL_LT;
+		if (value == MUTE)
+			sc_access[0].value = 0x40;
+		else
+			sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
+		num_reg = 1;
+		snd_pmic_ops_mx.mute_status = value;
+		break;
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+	case PMIC_SND_RIGHT_HP_MUTE:
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		if (snd_pmic_ops_mx.num_channel == 1)
+			value = MUTE;
+		if (value == MUTE)
+			sc_access[0].value = 0x40;
+		else
+			sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
+		num_reg = 1;
+		snd_pmic_ops_mx.mute_status = value;
+		break;
+	case PMIC_SND_MUTE_ALL:
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		sc_access[1].reg_addr = VOL_CTRL_LT;
+		sc_access[2].reg_addr =	0x220;
+		sc_access[3].reg_addr =	0x221;
+		sc_access[4].reg_addr =	0x223;
+		snd_pmic_ops_mx.master_mute = value;
+		if (value == MUTE) {
+			sc_access[0].value = sc_access[1].value = 0x40;
+			sc_access[2].value = 0x00;
+			sc_access[3].value = 0x00;
+			if (snd_pmic_ops_mx.input_dev_id == DMIC)
+				sc_access[4].value = 0x00;
+			else
+				sc_access[4].value = 0x20;
+
+		} else {
+			sc_access[0].value = sc_access[1].value = 0x00;
+			sc_access[2].value = sc_access[3].value = 0x20;
+				sc_access[4].value = 0x20;
+			if (snd_pmic_ops_mx.input_dev_id == DMIC)
+				sc_access[4].value = 0x20;
+			else
+				sc_access[4].value = 0x00;
+
+
+		}
+		if (snd_pmic_ops_mx.num_channel == 1)
+			sc_access[0].value = 0x40;
+		sc_access[0].mask = sc_access[1].mask = MASK6;
+		sc_access[2].mask = MASK5|MASK6;
+		sc_access[3].mask = MASK5|MASK6|MASK2|MASK4;
+		sc_access[4].mask = MASK5|MASK6|MASK4;
+
+		num_reg = 5;
+		break;
+	case PMIC_SND_RECEIVER_MUTE:
+		sc_access[0].reg_addr =  VOL_CTRL_RT;
+		if (value == MUTE)
+			sc_access[0].value = 0x40;
+		else
+			sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
+		num_reg = 1;
+		break;
+	}
+
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, num_reg);
+}
+
+static int mx_set_vol(int dev_id, int value)
+{
+	struct sc_reg_access sc_access[2] = {{0},};
+	int num_reg = 0;
+	int retval = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	pr_debug("sst: set_vol dev_id:0x%x ,value:%d\n", dev_id, value);
+	switch (dev_id) {
+	case PMIC_SND_RECEIVER_VOL:
+		return 0;
+		break;
+	case PMIC_SND_CAPTURE_VOL:
+		sc_access[0].reg_addr =	0x220;
+		sc_access[1].reg_addr =	0x221;
+		sc_access[0].value = sc_access[1].value = -value;
+		sc_access[0].mask = sc_access[1].mask =
+			(MASK0|MASK1|MASK2|MASK3|MASK4);
+		num_reg = 2;
+		break;
+	case PMIC_SND_LEFT_PB_VOL:
+		sc_access[0].value = -value;
+		sc_access[0].reg_addr = VOL_CTRL_LT;
+		sc_access[0].mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		num_reg = 1;
+		break;
+	case PMIC_SND_RIGHT_PB_VOL:
+		sc_access[0].value = -value;
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		sc_access[0].mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		if (snd_pmic_ops_mx.num_channel == 1) {
+			sc_access[0].value = 0x40;
+			sc_access[0].mask = MASK6;
+			sc_access[0].reg_addr = VOL_CTRL_RT;
+		}
+		num_reg = 1;
+		break;
+	}
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, num_reg);
+}
+
+static int mx_get_mute(int dev_id, u8 *value)
+{
+	struct sc_reg_access sc_access[4] = {{0},};
+	int retval = 0, num_reg = 0, mask = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	switch (dev_id) {
+	case PMIC_SND_DMIC_MUTE:
+	case PMIC_SND_AMIC_MUTE:
+	case PMIC_SND_HP_MIC_MUTE:
+		sc_access[0].reg_addr = 0x220;
+		mask = MASK5|MASK6;
+		num_reg = 1;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, num_reg);
+		if (retval)
+			return retval;
+		*value = sc_access[0].value & mask;
+		if (*value)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		return retval;
+	case PMIC_SND_LEFT_HP_MUTE:
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		sc_access[0].reg_addr = VOL_CTRL_LT;
+		num_reg = 1;
+		mask = MASK6;
+		break;
+	case PMIC_SND_RIGHT_HP_MUTE:
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		num_reg = 1;
+		mask = MASK6;
+		break;
+	}
+	retval = sst_sc_reg_access(sc_access, PMIC_READ, num_reg);
+	if (retval)
+		return retval;
+	*value = sc_access[0].value & mask;
+	if (*value)
+		*value = MUTE;
+	else
+		*value = UNMUTE;
+	return retval;
+}
+
+static int mx_get_vol(int dev_id, int *value)
+{
+	struct sc_reg_access sc_access = {0,};
+	int retval = 0, mask = 0, num_reg = 0;
+
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
+	switch (dev_id) {
+	case PMIC_SND_CAPTURE_VOL:
+		sc_access.reg_addr = 0x220;
+		mask = MASK0|MASK1|MASK2|MASK3|MASK4;
+		num_reg = 1;
+		break;
+	case PMIC_SND_LEFT_PB_VOL:
+		sc_access.reg_addr = VOL_CTRL_LT;
+		mask = MASK0|MASK1|MASK2|MASK3|MASK4|MASK5;
+		num_reg = 1;
+		break;
+	case PMIC_SND_RIGHT_PB_VOL:
+		sc_access.reg_addr = VOL_CTRL_RT;
+		mask = MASK0|MASK1|MASK2|MASK3|MASK4|MASK5;
+		num_reg = 1;
+		break;
+	}
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ, num_reg);
+	if (retval)
+		return retval;
+	*value = -(sc_access.value & mask);
+	pr_debug("sst: get volume value extracted %d\n", *value);
+	return retval;
+}
+
+struct snd_pmic_ops snd_pmic_ops_mx = {
+	.set_input_dev = mx_set_selected_input_dev,
+	.set_output_dev = mx_set_selected_output_dev,
+	.set_mute = mx_set_mute,
+	.get_mute = mx_get_mute,
+	.set_vol = mx_set_vol,
+	.get_vol = mx_get_vol,
+	.init_card = mx_init_card,
+	.set_pcm_audio_params = mx_set_pcm_audio_params,
+	.set_pcm_voice_params = mx_set_pcm_voice_params,
+	.set_voice_port = mx_set_voice_port,
+	.set_audio_port = mx_set_audio_port,
+	.power_up_pmic_pb = mx_power_up_pb,
+	.power_up_pmic_cp = mx_power_up_cp,
+	.power_down_pmic_pb = mx_power_down_pb,
+	.power_down_pmic_cp = mx_power_down_cp,
+	.power_down_pmic =  mx_power_down,
+};
+
diff --git a/drivers/staging/intel_sst/intelmid_v2_control.c b/drivers/staging/intel_sst/intelmid_v2_control.c
new file mode 100644
index 0000000..3a7de76
--- /dev/null
+++ b/drivers/staging/intel_sst/intelmid_v2_control.c
@@ -0,0 +1,1001 @@
+/*
+ *  intelmid_v2_control.c - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-10 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *		KP Jeeja <jeeja.kp@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com>
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
+ *  This file contains the control operations of vendor 3
+ */
+
+#include <linux/pci.h>
+#include <linux/file.h>
+#include "intel_sst.h"
+#include "intelmid_snd_control.h"
+
+enum reg_v3 {
+	VAUDIOCNT = 0x51,
+	VOICEPORT1 = 0x100,
+	VOICEPORT2 = 0x101,
+	AUDIOPORT1 = 0x102,
+	AUDIOPORT2 = 0x103,
+	ADCSAMPLERATE = 0x104,
+	DMICCTRL1 = 0x105,
+	DMICCTRL2 = 0x106,
+	MICCTRL = 0x107,
+	MICSELVOL = 0x108,
+	LILSEL = 0x109,
+	LIRSEL = 0x10a,
+	VOICEVOL = 0x10b,
+	AUDIOLVOL = 0x10c,
+	AUDIORVOL = 0x10d,
+	LMUTE = 0x10e,
+	RMUTE = 0x10f,
+	POWERCTRL1 = 0x110,
+	POWERCTRL2 = 0x111,
+	DRVPOWERCTRL = 0x112,
+	VREFPLL = 0x113,
+	PCMBUFCTRL = 0x114,
+	SOFTMUTE = 0x115,
+	DTMFPATH = 0x116,
+	DTMFVOL = 0x117,
+	DTMFFREQ = 0x118,
+	DTMFHFREQ = 0x119,
+	DTMFLFREQ = 0x11a,
+	DTMFCTRL = 0x11b,
+	DTMFASON = 0x11c,
+	DTMFASOFF = 0x11d,
+	DTMFASINUM = 0x11e,
+	CLASSDVOL = 0x11f,
+	VOICEDACAVOL = 0x120,
+	AUDDACAVOL = 0x121,
+	LOMUTEVOL = 0x122,
+	HPLVOL = 0x123,
+	HPRVOL = 0x124,
+	MONOVOL = 0x125,
+	LINEOUTMIXVOL = 0x126,
+	EPMIXVOL = 0x127,
+	LINEOUTLSEL = 0x128,
+	LINEOUTRSEL = 0x129,
+	EPMIXOUTSEL = 0x12a,
+	HPLMIXSEL = 0x12b,
+	HPRMIXSEL = 0x12c,
+	LOANTIPOP = 0x12d,
+};
+
+/****
+ * nc_init_card - initilize the sound card
+ *
+ * This initilizes the audio paths to know values in case of this sound card
+ */
+static int nc_init_card(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{VAUDIOCNT, 0x25, 0},
+		{VOICEPORT1, 0x00, 0},
+		{VOICEPORT2, 0x00, 0},
+		{AUDIOPORT1, 0x98, 0},
+		{AUDIOPORT2, 0x09, 0},
+		{AUDIOLVOL, 0x00, 0},
+		{AUDIORVOL, 0x00, 0},
+		{LMUTE, 0x03, 0},
+		{RMUTE, 0x03, 0},
+		{POWERCTRL1, 0x00, 0},
+		{POWERCTRL2, 0x00, 0},
+		{DRVPOWERCTRL, 0x00, 0},
+		{VREFPLL, 0x10, 0},
+		{HPLMIXSEL, 0xee, 0},
+		{HPRMIXSEL, 0xf6, 0},
+		{PCMBUFCTRL, 0x0, 0},
+		{VOICEVOL, 0x0e, 0},
+		{HPLVOL, 0x06, 0},
+		{HPRVOL, 0x06, 0},
+		{MICCTRL, 0x41, 0x00},
+		{ADCSAMPLERATE, 0x8B, 0x00},
+		{MICSELVOL, 0x5B, 0x00},
+		{LILSEL, 0x06, 0},
+		{LIRSEL, 0x46, 0},
+		{LOANTIPOP, 0x00, 0},
+		{DMICCTRL1, 0x40, 0},
+	};
+	snd_pmic_ops_nc.card_status = SND_CARD_INIT_DONE;
+	snd_pmic_ops_nc.master_mute = UNMUTE;
+	snd_pmic_ops_nc.mute_status = UNMUTE;
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 26);
+	pr_debug("sst: init complete!!\n");
+	return 0;
+}
+
+static int nc_enable_audiodac(int value)
+{
+	struct sc_reg_access sc_access[3];
+	int mute_val = 0;
+
+	if (snd_pmic_ops_nc.mute_status == MUTE)
+		return 0;
+
+	if (((snd_pmic_ops_nc.output_dev_id == MONO_EARPIECE) ||
+		(snd_pmic_ops_nc.output_dev_id == INTERNAL_SPKR)) &&
+		(value == UNMUTE))
+		return 0;
+	if (value == UNMUTE) {
+			/* unmute the system, set the 7th bit to zero */
+			mute_val = 0x00;
+		} else {
+			/* MUTE:Set the seventh bit */
+			mute_val = 0x04;
+
+		}
+		sc_access[0].reg_addr = LMUTE;
+		sc_access[1].reg_addr = RMUTE;
+		sc_access[0].mask = sc_access[1].mask = MASK2;
+		sc_access[0].value = sc_access[1].value = mute_val;
+
+		if (snd_pmic_ops_nc.num_channel == 1)
+			sc_access[1].value = 0x04;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+}
+
+static int nc_power_up_pb(unsigned int port)
+{
+	struct sc_reg_access sc_access[7];
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+	if (port == 0xFF)
+		return 0;
+	nc_enable_audiodac(MUTE);
+	msleep(30);
+
+	pr_debug("sst: powering up pb....\n");
+
+	sc_access[0].reg_addr = VAUDIOCNT;
+	sc_access[0].value = 0x27;
+	sc_access[0].mask = 0x27;
+	sc_access[1].reg_addr = VREFPLL;
+	if (port == 0) {
+		sc_access[1].value = 0x3A;
+		sc_access[1].mask = 0x3A;
+	} else if (port == 1) {
+		sc_access[1].value = 0x35;
+		sc_access[1].mask = 0x35;
+	}
+	retval =  sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+
+
+	sc_access[0].reg_addr = POWERCTRL1;
+	if (port == 0) {
+		sc_access[0].value = 0x40;
+		sc_access[0].mask = 0x40;
+	} else if (port == 1) {
+		sc_access[0].value = 0x01;
+		sc_access[0].mask = 0x01;
+	}
+	sc_access[1].reg_addr = POWERCTRL2;
+	sc_access[1].value = 0x0C;
+	sc_access[1].mask = 0x0C;
+
+	sc_access[2].reg_addr = DRVPOWERCTRL;
+	sc_access[2].value = 0x86;
+	sc_access[2].mask = 0x86;
+
+	sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 3);
+
+	msleep(30);
+
+	return nc_enable_audiodac(UNMUTE);
+
+}
+
+static int nc_power_up_cp(unsigned int port)
+{
+	struct sc_reg_access sc_access[5];
+	int retval = 0;
+
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+
+	pr_debug("sst: powering up cp....\n");
+
+	if (port == 0xFF)
+		return 0;
+	sc_access[0].reg_addr = VAUDIOCNT;
+	sc_access[0].value = 0x27;
+	sc_access[0].mask = 0x27;
+	sc_access[1].reg_addr = VREFPLL;
+	if (port == 0) {
+		sc_access[1].value = 0x3E;
+		sc_access[1].mask = 0x3E;
+	} else if (port == 1) {
+		sc_access[1].value = 0x35;
+		sc_access[1].mask = 0x35;
+	}
+
+	retval =  sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+
+	sc_access[0].reg_addr = POWERCTRL1;
+	if (port == 0) {
+		sc_access[0].value = 0xB4;
+		sc_access[0].mask = 0xB4;
+	} else if (port == 1) {
+		sc_access[0].value = 0xBF;
+		sc_access[0].mask = 0xBF;
+	}
+	sc_access[1].reg_addr = POWERCTRL2;
+	if (port == 0) {
+		sc_access[1].value = 0x0C;
+		sc_access[1].mask = 0x0C;
+	} else if (port == 1) {
+		sc_access[1].value = 0x02;
+		sc_access[1].mask = 0x02;
+	}
+
+	return  sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+}
+
+static int nc_power_down(void)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access[5];
+
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+	nc_enable_audiodac(MUTE);
+
+
+	pr_debug("sst: powering dn nc_power_down ....\n");
+
+	msleep(30);
+
+	sc_access[0].reg_addr = DRVPOWERCTRL;
+	sc_access[0].value = 0x00;
+	sc_access[0].mask = 0x00;
+
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 1);
+
+	sc_access[0].reg_addr = POWERCTRL1;
+	sc_access[0].value = 0x00;
+	sc_access[0].mask = 0x00;
+
+	sc_access[1].reg_addr = POWERCTRL2;
+	sc_access[1].value = 0x00;
+	sc_access[1].mask = 0x00;
+
+
+
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 2);
+
+	msleep(30);
+	sc_access[0].reg_addr = VREFPLL;
+	sc_access[0].value = 0x10;
+	sc_access[0].mask = 0x10;
+
+	sc_access[1].reg_addr = VAUDIOCNT;
+	sc_access[1].value = 0x25;
+	sc_access[1].mask = 0x25;
+
+
+	retval =  sst_sc_reg_access(sc_access, PMIC_WRITE, 2);
+
+	msleep(30);
+	return nc_enable_audiodac(UNMUTE);
+}
+
+static int nc_power_down_pb(void)
+{
+
+	int retval = 0;
+	struct sc_reg_access sc_access[5];
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	pr_debug("sst: powering dn pb....\n");
+
+	nc_enable_audiodac(MUTE);
+
+
+	msleep(30);
+
+
+	sc_access[0].reg_addr = DRVPOWERCTRL;
+	sc_access[0].value = 0x00;
+	sc_access[0].mask = 0x00;
+
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 1);
+
+	msleep(30);
+
+	sc_access[0].reg_addr = POWERCTRL1;
+	sc_access[0].value = 0x00;
+	sc_access[0].mask = 0x41;
+
+	sc_access[1].reg_addr = POWERCTRL2;
+	sc_access[1].value = 0x00;
+	sc_access[1].mask = 0x0C;
+
+	sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+
+	msleep(30);
+
+	return nc_enable_audiodac(UNMUTE);
+
+
+}
+
+static int nc_power_down_cp(void)
+{
+	struct sc_reg_access sc_access[] = {
+		{POWERCTRL1, 0x00, 0xBE},
+		{POWERCTRL2, 0x00, 0x02},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	pr_debug("sst: powering dn cp....\n");
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+}
+
+static int nc_set_pcm_voice_params(void)
+{
+	struct sc_reg_access sc_access[] = {
+			{0x100, 0xD5, 0},
+			{0x101, 0x08, 0},
+			{0x104, 0x03, 0},
+			{0x107, 0x10, 0},
+			{0x10B, 0x0E, 0},
+			{0x10E, 0x03, 0},
+			{0x10F, 0x03, 0},
+			{0x114, 0x13, 0},
+			{0x115, 0x00, 0},
+			{0x128, 0xFE, 0},
+			{0x129, 0xFE, 0},
+			{0x12A, 0xFE, 0},
+			{0x12B, 0xDE, 0},
+			{0x12C, 0xDE, 0},
+	};
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 14);
+	pr_debug("sst: Voice parameters set successfully!!\n");
+	return 0;
+}
+
+
+static int nc_set_pcm_audio_params(int sfreq, int word_size, int num_channel)
+{
+	int config2 = 0;
+	struct sc_reg_access sc_access;
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	switch (sfreq) {
+	case 8000:
+		config2 = 0x00;
+		break;
+	case 11025:
+		config2 = 0x01;
+		break;
+	case 12000:
+		config2 = 0x02;
+		break;
+	case 16000:
+		config2 = 0x03;
+		break;
+	case 22050:
+		config2 = 0x04;
+		break;
+	case 24000:
+		config2 = 0x05;
+		break;
+	case 32000:
+		config2 = 0x07;
+		break;
+	case 44100:
+		config2 = 0x08;
+		break;
+	case 48000:
+		config2 = 0x09;
+		break;
+	}
+
+	snd_pmic_ops_nc.num_channel = num_channel;
+	if (snd_pmic_ops_nc.num_channel == 1)	{
+
+		sc_access.value = 0x07;
+		sc_access.reg_addr = RMUTE;
+		pr_debug("sst: RIGHT_HP_MUTE value%d\n", sc_access.value);
+		sc_access.mask = MASK2;
+		sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+	} else {
+		sc_access.value = 0x00;
+		sc_access.reg_addr = RMUTE;
+		pr_debug("sst: RIGHT_HP_MUTE value %d\n", sc_access.value);
+		sc_access.mask = MASK2;
+		sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+
+
+	}
+
+	pr_debug("sst: word_size = %d\n", word_size);
+
+	if (word_size == 24) {
+		sc_access.reg_addr = AUDIOPORT2;
+		sc_access.value = config2 | 0x10;
+		sc_access.mask = 0x1F;
+	} else {
+		sc_access.value = config2;
+		sc_access.mask = 0x1F;
+		sc_access.reg_addr = AUDIOPORT2;
+	}
+	sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+
+	pr_debug("sst: word_size = %d\n", word_size);
+	sc_access.reg_addr = AUDIOPORT1;
+	sc_access.mask = MASK5|MASK4|MASK1|MASK0;
+	if (word_size == 16)
+		sc_access.value = 0x98;
+	else if (word_size == 24)
+		sc_access.value = 0xAB;
+
+	return sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+
+
+
+}
+
+static int nc_set_selected_output_dev(u8 value)
+{
+	struct sc_reg_access sc_access_HP[] = {
+		{LMUTE, 0x02, 0x06},
+		{RMUTE, 0x02, 0x06}
+	};
+	struct sc_reg_access sc_access_IS[] = {
+		{LMUTE, 0x04, 0x06},
+		{RMUTE, 0x04, 0x06}
+	};
+	int retval = 0;
+
+	snd_pmic_ops_nc.output_dev_id = value;
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+	pr_debug("sst: nc set selected output:%d\n", value);
+	switch (value) {
+	case STEREO_HEADPHONE:
+		retval = sst_sc_reg_access(sc_access_HP, PMIC_WRITE, 2);
+		break;
+	case INTERNAL_SPKR:
+		retval = sst_sc_reg_access(sc_access_IS, PMIC_WRITE, 2);
+		break;
+	default:
+		pr_err("sst: rcvd illegal request: %d\n", value);
+		return -EINVAL;
+	}
+	return retval;
+}
+
+static int nc_audio_init(void)
+{
+	struct sc_reg_access sc_acces, sc_access[] = {
+			{0x100, 0x00, 0},
+			{0x101, 0x00, 0},
+			{0x104, 0x8B, 0},
+			{0x107, 0x11, 0},
+			{0x10B, 0x0E, 0},
+			{0x114, 0x00, 0},
+			{0x115, 0x00, 0},
+			{0x128, 0x00, 0},
+			{0x129, 0x00, 0},
+			{0x12A, 0x00, 0},
+			{0x12B, 0xee, 0},
+			{0x12C, 0xf6, 0},
+	};
+
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 12);
+	pr_debug("sst: Audio Init successfully!!\n");
+
+	/*set output device */
+	nc_set_selected_output_dev(snd_pmic_ops_nc.output_dev_id);
+
+	if (snd_pmic_ops_nc.num_channel == 1) {
+		sc_acces.value = 0x07;
+		sc_acces.reg_addr = RMUTE;
+		pr_debug("sst: RIGHT_HP_MUTE value%d\n", sc_acces.value);
+		sc_acces.mask = MASK2;
+		sst_sc_reg_access(&sc_acces, PMIC_READ_MODIFY, 1);
+	} else {
+		sc_acces.value = 0x00;
+		sc_acces.reg_addr = RMUTE;
+		pr_debug("sst: RIGHT_HP_MUTE value%d\n", sc_acces.value);
+		sc_acces.mask = MASK2;
+		sst_sc_reg_access(&sc_acces, PMIC_READ_MODIFY, 1);
+	}
+
+	return 0;
+}
+
+static int nc_set_audio_port(int status)
+{
+	struct sc_reg_access sc_access[2] = {{0,},};
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	if (status == DEACTIVATE) {
+		/* Deactivate audio port-tristate and power */
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK4|MASK5;
+		sc_access[0].reg_addr = AUDIOPORT1;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	} else if (status == ACTIVATE) {
+		/* activate audio port */
+		nc_audio_init();
+		sc_access[0].value = 0x10;
+		sc_access[0].mask =  MASK4|MASK5 ;
+		sc_access[0].reg_addr = AUDIOPORT1;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	} else
+		return -EINVAL;
+
+}
+
+static int nc_set_voice_port(int status)
+{
+	struct sc_reg_access sc_access[2] = {{0,},};
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	if (status == DEACTIVATE) {
+		/* Activate Voice port */
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK4;
+		sc_access[0].reg_addr = VOICEPORT1;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	} else if (status == ACTIVATE) {
+		/* Deactivate voice port */
+		nc_set_pcm_voice_params();
+		sc_access[0].value = 0x10;
+		sc_access[0].mask = MASK4;
+		sc_access[0].reg_addr = VOICEPORT1;
+		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	} else
+		return -EINVAL;
+}
+
+static int nc_set_mute(int dev_id, u8 value)
+{
+	struct sc_reg_access sc_access[3];
+	u8 mute_val, cap_mute;
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	pr_debug("sst: set device id::%d, value %d\n", dev_id, value);
+
+	switch (dev_id) {
+	case PMIC_SND_MUTE_ALL:
+		pr_debug("sst: PMIC_SND_MUTE_ALL value %d\n", value);
+		snd_pmic_ops_nc.mute_status = value;
+		snd_pmic_ops_nc.master_mute = value;
+		if (value == UNMUTE) {
+			/* unmute the system, set the 7th bit to zero */
+			mute_val = cap_mute = 0x00;
+		} else {
+			/* MUTE:Set the seventh bit */
+			mute_val = 0x80;
+			cap_mute = 0x40;
+		}
+		sc_access[0].reg_addr = AUDIOLVOL;
+		sc_access[1].reg_addr = AUDIORVOL;
+		sc_access[0].mask = sc_access[1].mask = MASK7;
+		sc_access[0].value = sc_access[1].value = mute_val;
+		if (snd_pmic_ops_nc.num_channel == 1)
+				sc_access[1].value = 0x80;
+		if (!sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2)) {
+			sc_access[0].reg_addr = 0x109;
+			sc_access[1].reg_addr = 0x10a;
+			sc_access[2].reg_addr = 0x105;
+			sc_access[0].mask = sc_access[1].mask =
+				sc_access[2].mask = MASK6;
+			sc_access[0].value = sc_access[1].value =
+				sc_access[2].value = cap_mute;
+
+			if ((snd_pmic_ops_nc.input_dev_id == AMIC) ||
+				(snd_pmic_ops_nc.input_dev_id == DMIC))
+					sc_access[1].value = 0x40;
+			if (snd_pmic_ops_nc.input_dev_id == HS_MIC)
+					sc_access[0].value = 0x40;
+			retval = sst_sc_reg_access(sc_access,
+					PMIC_READ_MODIFY, 3);
+		}
+		break;
+	case PMIC_SND_HP_MIC_MUTE:
+		pr_debug("sst: PMIC_SND_HPMIC_MUTE value %d\n", value);
+		if (value == UNMUTE) {
+			/* unmute the system, set the 6th bit to one */
+			sc_access[0].value = 0x00;
+		} else {
+			/* mute the system, reset the 6th bit to zero */
+			sc_access[0].value = 0x40;
+		}
+		sc_access[0].reg_addr = LIRSEL;
+		sc_access[0].mask = MASK6;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+	case PMIC_SND_AMIC_MUTE:
+		pr_debug("sst: PMIC_SND_AMIC_MUTE value %d\n", value);
+		if (value == UNMUTE) {
+			/* unmute the system, set the 6th bit to one */
+			sc_access[0].value = 0x00;
+		} else {
+			/* mute the system, reset the 6th bit to zero */
+			sc_access[0].value = 0x40;
+		}
+		sc_access[0].reg_addr = LILSEL;
+		sc_access[0].mask = MASK6;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+
+	case PMIC_SND_DMIC_MUTE:
+		pr_debug("sst: INPUT_MUTE_DMIC value%d\n", value);
+		if (value == UNMUTE) {
+			/* unmute the system, set the 6th bit to one */
+			sc_access[1].value = 0x00;
+			sc_access[0].value = 0x00;
+		} else {
+			/* mute the system, reset the 6th bit to zero */
+			sc_access[1].value = 0x40;
+			sc_access[0].value = 0x40;
+		}
+		sc_access[0].reg_addr = DMICCTRL1;
+		sc_access[0].mask = MASK6;
+		sc_access[1].reg_addr = LILSEL;
+		sc_access[1].mask = MASK6;
+		retval = sst_sc_reg_access(sc_access,
+					PMIC_READ_MODIFY, 2);
+		break;
+
+	case PMIC_SND_LEFT_HP_MUTE:
+	case PMIC_SND_RIGHT_HP_MUTE:
+		snd_pmic_ops_nc.mute_status = value;
+		if (value == UNMUTE)
+			sc_access[0].value = 0x0;
+		else
+			sc_access[0].value = 0x04;
+
+		if (dev_id == PMIC_SND_LEFT_HP_MUTE) {
+			sc_access[0].reg_addr = LMUTE;
+			pr_debug("sst: LEFT_HP_MUTE value %d\n",
+					sc_access[0].value);
+		} else {
+			if (snd_pmic_ops_nc.num_channel == 1)
+				sc_access[0].value = 0x04;
+			sc_access[0].reg_addr = RMUTE;
+			pr_debug("sst: RIGHT_HP_MUTE value %d\n",
+					sc_access[0].value);
+		}
+		sc_access[0].mask = MASK2;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		if (value == UNMUTE)
+			sc_access[0].value = 0x00;
+		else
+			sc_access[0].value = 0x03;
+		sc_access[0].reg_addr = LMUTE;
+		pr_debug("sst: SPEAKER_MUTE %d\n", sc_access[0].value);
+		sc_access[0].mask = MASK1;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return retval ;
+
+}
+
+static int nc_set_vol(int dev_id, int value)
+{
+	struct sc_reg_access sc_access[3];
+	int retval = 0, entries = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	pr_debug("sst: set volume:%d\n", dev_id);
+	switch (dev_id) {
+	case PMIC_SND_CAPTURE_VOL:
+		pr_debug("sst: PMIC_SND_CAPTURE_VOL:value::%d\n", value);
+		sc_access[0].value = sc_access[1].value =
+					sc_access[2].value = -value;
+		sc_access[0].mask = sc_access[1].mask = sc_access[2].mask =
+					(MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		sc_access[0].reg_addr = 0x10a;
+		sc_access[1].reg_addr = 0x109;
+		sc_access[2].reg_addr = 0x105;
+		entries = 3;
+		break;
+
+	case PMIC_SND_LEFT_PB_VOL:
+		pr_debug("sst: PMIC_SND_LEFT_HP_VOL %d\n", value);
+		sc_access[0].value = -value;
+		sc_access[0].reg_addr  = AUDIOLVOL;
+		sc_access[0].mask =
+			(MASK0|MASK1|MASK2|MASK3|MASK4|MASK5|MASK6);
+		entries = 1;
+		break;
+
+	case PMIC_SND_RIGHT_PB_VOL:
+		pr_debug("sst: PMIC_SND_RIGHT_HP_VOL value %d\n", value);
+		if (snd_pmic_ops_nc.num_channel == 1) {
+			sc_access[0].value = 0x04;
+		    sc_access[0].reg_addr = RMUTE;
+			sc_access[0].mask = MASK2;
+		} else {
+		sc_access[0].value = -value;
+		sc_access[0].reg_addr  = AUDIORVOL;
+		sc_access[0].mask =
+				(MASK0|MASK1|MASK2|MASK3|MASK4|MASK5|MASK6);
+		entries = 1;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+
+	}
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, entries);
+}
+
+static int nc_set_selected_input_dev(u8 value)
+{
+	struct sc_reg_access sc_access[6];
+	u8 num_val;
+	int retval = 0;
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+	snd_pmic_ops_nc.input_dev_id = value;
+
+	pr_debug("sst: nc set selected input:%d\n", value);
+
+	switch (value) {
+	case AMIC:
+		pr_debug("sst: Selecting AMIC\n");
+		sc_access[0].reg_addr = 0x107;
+		sc_access[0].value = 0x40;
+		sc_access[0].mask =  MASK6|MASK4|MASK3|MASK1|MASK0;
+		sc_access[1].reg_addr = 0x10a;
+		sc_access[1].value = 0x40;
+		sc_access[1].mask = MASK6;
+		sc_access[2].reg_addr = 0x109;
+		sc_access[2].value = 0x00;
+		sc_access[2].mask = MASK6;
+		sc_access[3].reg_addr = 0x105;
+		sc_access[3].value = 0x40;
+		sc_access[3].mask = MASK6;
+		num_val = 4;
+		break;
+
+	case HS_MIC:
+		pr_debug("sst: Selecting HS_MIC\n");
+		sc_access[0].reg_addr = 0x107;
+		sc_access[0].mask =  MASK6|MASK4|MASK3|MASK1|MASK0;
+		sc_access[0].value = 0x10;
+		sc_access[1].reg_addr = 0x109;
+		sc_access[1].mask = MASK6;
+		sc_access[1].value = 0x40;
+		sc_access[2].reg_addr = 0x10a;
+		sc_access[2].mask = MASK6;
+		sc_access[2].value = 0x00;
+		sc_access[3].reg_addr = 0x105;
+		sc_access[3].value = 0x40;
+		sc_access[3].mask = MASK6;
+		num_val = 4;
+		break;
+
+	case DMIC:
+		pr_debug("sst: DMIC\n");
+		sc_access[0].reg_addr = 0x107;
+		sc_access[0].mask = MASK6|MASK4|MASK3|MASK1|MASK0;
+		sc_access[0].value = 0x0B;
+		sc_access[1].reg_addr = 0x105;
+		sc_access[1].value = 0x80;
+		sc_access[1].mask = MASK7|MASK6;
+		sc_access[2].reg_addr = 0x10a;
+		sc_access[2].value = 0x40;
+		sc_access[2].mask = MASK6;
+		sc_access[3].reg_addr = 0x109;
+		sc_access[3].mask = MASK6;
+		sc_access[3].value = 0x40;
+		num_val = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, num_val);
+}
+
+static int nc_get_mute(int dev_id, u8 *value)
+{
+	int retval = 0, mask = 0;
+	struct sc_reg_access sc_access = {0,};
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	pr_debug("sst: get mute::%d\n", dev_id);
+
+	switch (dev_id) {
+	case PMIC_SND_AMIC_MUTE:
+		pr_debug("sst: PMIC_SND_INPUT_MUTE_MIC1\n");
+		sc_access.reg_addr = LILSEL;
+		mask = MASK6;
+		break;
+	case PMIC_SND_HP_MIC_MUTE:
+		pr_debug("sst: PMIC_SND_INPUT_MUTE_MIC2\n");
+		sc_access.reg_addr = LIRSEL;
+		mask = MASK6;
+		break;
+	case PMIC_SND_LEFT_HP_MUTE:
+	case PMIC_SND_RIGHT_HP_MUTE:
+		mask = MASK2;
+		pr_debug("sst: PMIC_SN_LEFT/RIGHT_HP_MUTE\n");
+		if (dev_id == PMIC_SND_RIGHT_HP_MUTE)
+			sc_access.reg_addr = RMUTE;
+		else
+			sc_access.reg_addr = LMUTE;
+		break;
+
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		pr_debug("sst: PMIC_MONO_EARPIECE_MUTE\n");
+		sc_access.reg_addr = RMUTE;
+		mask = MASK1;
+		break;
+	case PMIC_SND_DMIC_MUTE:
+		pr_debug("sst: PMIC_SND_INPUT_MUTE_DMIC\n");
+		sc_access.reg_addr = 0x105;
+		mask = MASK6;
+		break;
+	default:
+		return -EINVAL;
+
+	}
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ, 1);
+	pr_debug("sst: reg value = %d\n", sc_access.value);
+	if (retval)
+		return retval;
+	*value = (sc_access.value) & mask;
+	pr_debug("sst: masked value = %d\n", *value);
+	if (*value)
+		*value = 0;
+	else
+		*value = 1;
+	pr_debug("sst: value returned = 0x%x\n", *value);
+	return retval;
+}
+
+static int nc_get_vol(int dev_id, int *value)
+{
+	int retval = 0, mask = 0;
+	struct sc_reg_access sc_access = {0,};
+
+	if (snd_pmic_ops_nc.card_status == SND_CARD_UN_INIT)
+		retval = nc_init_card();
+	if (retval)
+		return retval;
+
+	switch (dev_id) {
+	case PMIC_SND_CAPTURE_VOL:
+		pr_debug("sst: PMIC_SND_INPUT_CAPTURE_VOL\n");
+		sc_access.reg_addr =  LILSEL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		break;
+
+	case PMIC_SND_RIGHT_PB_VOL:
+		pr_debug("sst: GET_VOLUME_PMIC_LEFT_HP_VOL\n");
+		sc_access.reg_addr = AUDIOLVOL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5|MASK6);
+		break;
+
+	case PMIC_SND_LEFT_PB_VOL:
+		pr_debug("sst: GET_VOLUME_PMIC_RIGHT_HP_VOL\n");
+		sc_access.reg_addr = AUDIORVOL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5|MASK6);
+		break;
+
+	default:
+		return -EINVAL;
+
+	}
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ, 1);
+	pr_debug("sst: value read = 0x%x\n", sc_access.value);
+	*value = -((sc_access.value) & mask);
+	pr_debug("sst: get vol value returned = %d\n", *value);
+	return retval;
+}
+
+struct snd_pmic_ops snd_pmic_ops_nc = {
+	.set_input_dev	=	nc_set_selected_input_dev,
+	.set_output_dev =	nc_set_selected_output_dev,
+	.set_mute	=	nc_set_mute,
+	.get_mute	=	nc_get_mute,
+	.set_vol	=	nc_set_vol,
+	.get_vol	=	nc_get_vol,
+	.init_card	=	nc_init_card,
+	.set_pcm_audio_params	= nc_set_pcm_audio_params,
+	.set_pcm_voice_params	= nc_set_pcm_voice_params,
+	.set_voice_port = nc_set_voice_port,
+	.set_audio_port = nc_set_audio_port,
+	.power_up_pmic_pb =	nc_power_up_pb,
+	.power_up_pmic_cp =	nc_power_up_cp,
+	.power_down_pmic_pb =	nc_power_down_pb,
+	.power_down_pmic_cp =	nc_power_down_cp,
+	.power_down_pmic =	nc_power_down,
+};
diff --git a/drivers/staging/intel_sst/jack.h b/drivers/staging/intel_sst/jack.h
new file mode 100644
index 0000000..9a6e483
--- /dev/null
+++ b/drivers/staging/intel_sst/jack.h
@@ -0,0 +1,10 @@
+/* Temporary staging glue */
+
+#include <sound/jack.h>
+
+/* These want adding to jack.h as enum entries once approved */
+
+#define SND_JACK_HS_SHORT_PRESS 	(SND_JACK_HEADSET | 0x0020)
+#define	SND_JACK_HS_LONG_PRESS		(SND_JACK_HEADSET | 0x0040)
+
+
