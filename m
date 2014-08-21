From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Thu, 21 Aug 2014 18:20:43 +0530
Message-ID: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 25F702651E3
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:12:55 +0200 (CEST)
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

This patch adds APIs to post IPCs and process reply messages.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_ipc.c | 368 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 368 insertions(+)
 create mode 100644 sound/soc/intel/sst/sst_ipc.c

diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/sst/sst_ipc.c
new file mode 100644
index 000000000000..18e5e3bad3f4
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
+	if (!msg)
+		return NULL;
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
+void sst_post_message_mrfld(struct intel_sst_drv *sst_drv_ctx)
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
+			    msg->mailbox_data,
+			    msg->mrfld_header.p.header_low_payload);
+
+	sst_shim_write64(sst_drv_ctx->shim, SST_IPCX, msg->mrfld_header.full);
+	spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+	pr_debug("sst: Post message: header = %x\n",
+				msg->mrfld_header.p.header_high.full);
+	kfree(msg->mailbox_data);
+	kfree(msg);
+}
+
+int sst_sync_post_message_mrfld(struct intel_sst_drv *sst_drv_ctx,
+		struct ipc_post *msg)
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
+		cpu_relax();
+		loop_count++;
+		header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
+	}
+	pr_debug("sst: Post message: header = %x\n",
+					msg->mrfld_header.p.header_high.full);
+	pr_debug("sst: size = 0x%x\n", msg->mrfld_header.p.header_low_payload);
+	if (msg->mrfld_header.p.header_high.part.large)
+		memcpy_toio(sst_drv_ctx->mailbox + SST_MAILBOX_SEND,
+			msg->mailbox_data,
+			msg->mrfld_header.p.header_low_payload);
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
+void intel_sst_clear_intr_mrfld(struct intel_sst_drv *sst_drv_ctx)
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
+static void process_fw_init(struct intel_sst_drv *sst_drv_ctx,
+			void *msg)
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
+
+ret:
+	sst_wake_up_block(sst_drv_ctx, retval, FW_DWNL_ID, 0 , NULL, 0);
+}
+
+static void process_fw_async_msg(struct intel_sst_drv *sst_drv_ctx,
+			struct ipc_post *msg)
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
+		str_id = get_stream_id_mrfld(sst_drv_ctx, pipe_id);
+		if (str_id > 0) {
+			pr_debug("Period elapsed rcvd for pipe id 0x%x\n",
+					pipe_id);
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
+		str_id = get_stream_id_mrfld(sst_drv_ctx, pipe_id);
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
+		process_fw_init(sst_drv_ctx, data_offset);
+		break;
+
+	case IPC_IA_BUF_UNDER_RUN_MRFLD:
+		pipe_id = ((struct ipc_dsp_hdr *)msg->mailbox_data)->pipe_id;
+		str_id = get_stream_id_mrfld(sst_drv_ctx, pipe_id);
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
+void sst_process_reply_mrfld(struct intel_sst_drv *sst_drv_ctx,
+		struct ipc_post *msg)
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
+		process_fw_async_msg(sst_drv_ctx, msg);
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
-- 
1.9.0
