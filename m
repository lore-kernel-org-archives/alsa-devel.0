From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 05/11] ASoC: Intel: sst: add stream operations
Date: Thu, 21 Aug 2014 18:20:44 +0530
Message-ID: <1408625450-32315-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C4CCB265895
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:12:58 +0200 (CEST)
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

This patch adds pcm and compressed stream control operations.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_stream.c | 526 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 526 insertions(+)
 create mode 100644 sound/soc/intel/sst/sst_stream.c

diff --git a/sound/soc/intel/sst/sst_stream.c b/sound/soc/intel/sst/sst_stream.c
new file mode 100644
index 000000000000..4ae5dbc7f2a3
--- /dev/null
+++ b/sound/soc/intel/sst/sst_stream.c
@@ -0,0 +1,526 @@
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
+int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx,
+		void *params, struct sst_block *block)
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
+	alloc_param.ring_buf_info[0].addr =
+		str_params->aparams.ring_buf_info[0].addr;
+	alloc_param.ring_buf_info[0].size =
+		str_params->aparams.ring_buf_info[0].size;
+	alloc_param.frag_size = str_params->aparams.frag_size;
+
+	memcpy(&alloc_param.codec_params, &str_params->sparams,
+			sizeof(struct snd_sst_stream_params));
+
+	/*
+	 * fill channel map params for multichannel support.
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
+	len = msg->mrfld_header.p.header_low_payload =
+		sizeof(alloc_param) + sizeof(dsp_hdr);
+	sst_fill_header_dsp(&dsp_hdr, IPC_IA_ALLOC_STREAM_MRFLD,
+			pipe_id, sizeof(alloc_param));
+	memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+	memcpy(msg->mailbox_data + sizeof(dsp_hdr), &alloc_param,
+			sizeof(alloc_param));
+	str_info = &sst_drv_ctx->streams[str_id];
+	pr_debug("header:%x\n", msg->mrfld_header.p.header_high.full);
+	pr_debug("response rqd: %x",
+			msg->mrfld_header.p.header_high.part.res_rqd);
+	pr_debug("calling post_message\n");
+	pr_info("Alloc for str %d pipe %#x\n", str_id, pipe_id);
+
+	sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
+	return str_id;
+}
+
+/**
+* sst_start_stream - Send msg for a starting stream
+* @str_id:	 stream ID
+*
+* This function is called by any function which wants to start
+* a stream.
+*/
+int sst_start_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
+{
+	int retval = 0, pvt_id;
+	u32 len = 0;
+	struct ipc_post *msg = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+	struct stream_info *str_info;
+
+	pr_debug("sst_start_stream for %d\n", str_id);
+	str_info = get_stream_info(sst_drv_ctx, str_id);
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
+	sst_drv_ctx->ops->sync_post_message(sst_drv_ctx, msg);
+	return retval;
+}
+
+int sst_send_byte_stream_mrfld(struct intel_sst_drv *sst_drv_ctx,
+		struct snd_sst_bytes_v2 *bytes)
+{
+	struct ipc_post *msg = NULL;
+	u32 length;
+	int pvt_id, ret = 0;
+	struct sst_block *block = NULL;
+
+	pr_debug("%s: type:%u ipc_msg:%u block:%u task_id:%u pipe: %#x length:%#x\n",
+		__func__, bytes->type, bytes->ipc_msg,
+		bytes->block, bytes->task_id,
+		bytes->pipe_id, bytes->len);
+
+	/*
+	 * need some err check as this is user data, perhpas move this to the
+	 * platform driver and pass the struct
+	 */
+	if (sst_create_ipc_msg(&msg, true))
+		return -ENOMEM;
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	sst_fill_header_mrfld(&msg->mrfld_header, bytes->ipc_msg,
+			bytes->task_id, 1, pvt_id);
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
+	pr_debug("msg->mrfld_header.p.header_low_payload:%d",
+			msg->mrfld_header.p.header_low_payload);
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
+int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
+{
+	int retval = 0, pvt_id, len;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct sst_block *block;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_pause_stream for %d\n", str_id);
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
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
+int sst_resume_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct sst_block *block = NULL;
+	int pvt_id, len;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_resume_stream for %d\n", str_id);
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
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
+int sst_drop_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
+{
+	int retval = 0, pvt_id;
+	struct stream_info *str_info;
+	struct ipc_post *msg = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_drop_stream for %d\n", str_id);
+	str_info = get_stream_info(sst_drv_ctx, str_id);
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
+		sst_drv_ctx->ops->sync_post_message(sst_drv_ctx, msg);
+	} else {
+		retval = -EBADRQC;
+		pr_debug("BADQRC for stream, state %x\n", str_info->status);
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
+int sst_drain_stream(struct intel_sst_drv *sst_drv_ctx,
+			int str_id, bool partial_drain)
+{
+	int retval = 0, pvt_id, len;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct sst_block *block = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("SST DBG:sst_drain_stream for %d\n", str_id);
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
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
+int sst_free_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
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
+	str_info = get_stream_info(sst_drv_ctx, str_id);
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
+		pr_info("Free for str %d pipe %#x\n",
+				str_id, str_info->pipe_id);
+
+		spin_lock_irqsave(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+		list_add_tail(&msg->node, &sst_drv_ctx->ipc_dispatch_list);
+		spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
+		ops->post_message(sst_drv_ctx);
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
1.9.0
