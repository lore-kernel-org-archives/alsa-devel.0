From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 2/6] ASoC: Intel: Add Haswell/Broadwell IPC
Date: Thu, 20 Feb 2014 21:48:43 +0000
Message-ID: <1392932927-9725-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9338826585A
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 22:49:21 +0100 (CET)
In-Reply-To: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add support for Haswell and Broadwell DSP IPC. This is used by the DSP
platform PCM driver to configure the DSP for audio operations.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 1785 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-haswell-ipc.h |  488 ++++++++++
 2 files changed, 2273 insertions(+)
 create mode 100644 sound/soc/intel/sst-haswell-ipc.c
 create mode 100644 sound/soc/intel/sst-haswell-ipc.h

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
new file mode 100644
index 0000000..668d486
--- /dev/null
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -0,0 +1,1785 @@
+/*
+ *  Intel SST Haswell/Broadwell IPC Support
+ *
+ * Copyright (C) 2013, Intel Corporation. All rights reserved.
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
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/kthread.h>
+#include <linux/firmware.h>
+#include <linux/dma-mapping.h>
+#include <linux/debugfs.h>
+
+#include "sst-haswell-ipc.h"
+#include "sst-dsp.h"
+#include "sst-dsp-priv.h"
+
+/* Global Message - Generic */
+#define IPC_GLB_TYPE_SHIFT	24
+#define IPC_GLB_TYPE_MASK	(0x1f << IPC_GLB_TYPE_SHIFT)
+#define IPC_GLB_TYPE(x)		(x << IPC_GLB_TYPE_SHIFT)
+
+/* Global Message - Reply */
+#define IPC_GLB_REPLY_SHIFT	0
+#define IPC_GLB_REPLY_MASK	(0x1f << IPC_GLB_REPLY_SHIFT)
+#define IPC_GLB_REPLY_TYPE(x)	(x << IPC_GLB_REPLY_TYPE_SHIFT)
+
+/* Stream Message - Generic */
+#define IPC_STR_TYPE_SHIFT	20
+#define IPC_STR_TYPE_MASK	(0xf << IPC_STR_TYPE_SHIFT)
+#define IPC_STR_TYPE(x)		(x << IPC_STR_TYPE_SHIFT)
+#define IPC_STR_ID_SHIFT	16
+#define IPC_STR_ID_MASK		(0xf << IPC_STR_ID_SHIFT)
+#define IPC_STR_ID(x)		(x << IPC_STR_ID_SHIFT)
+
+/* Stream Message - Reply */
+#define IPC_STR_REPLY_SHIFT	0
+#define IPC_STR_REPLY_MASK	(0x1f << IPC_STR_REPLY_SHIFT)
+
+/* Stream Stage Message - Generic */
+#define IPC_STG_TYPE_SHIFT	12
+#define IPC_STG_TYPE_MASK	(0xf << IPC_STG_TYPE_SHIFT)
+#define IPC_STG_TYPE(x)		(x << IPC_STG_TYPE_SHIFT)
+#define IPC_STG_ID_SHIFT	10
+#define IPC_STG_ID_MASK		(0x3 << IPC_STG_ID_SHIFT)
+#define IPC_STG_ID(x)		(x << IPC_STG_ID_SHIFT)
+
+/* Stream Stage Message - Reply */
+#define IPC_STG_REPLY_SHIFT	0
+#define IPC_STG_REPLY_MASK	(0x1f << IPC_STG_REPLY_SHIFT)
+
+/* Debug Log Message - Generic */
+#define IPC_LOG_OP_SHIFT	20
+#define IPC_LOG_OP_MASK		(0xf << IPC_LOG_OP_SHIFT)
+#define IPC_LOG_OP_TYPE(x)	(x << IPC_LOG_OP_SHIFT)
+#define IPC_LOG_ID_SHIFT	16
+#define IPC_LOG_ID_MASK		(0xf << IPC_LOG_ID_SHIFT)
+#define IPC_LOG_ID(x)		(x << IPC_LOG_ID_SHIFT)
+
+/* IPC message timeout (msecs) */
+#define IPC_TIMEOUT_MSECS	300
+#define IPC_BOOT_MSECS		200
+#define IPC_MSG_WAIT		0
+#define IPC_MSG_NOWAIT		1
+
+/* Firmware Ready Message */
+#define IPC_FW_READY		(0x1 << 29)
+#define IPC_STATUS_MASK		(0x3 << 30)
+
+#define IPC_EMPTY_LIST_SIZE	8
+#define IPC_MAX_STREAMS		4
+
+/* Mailbox */
+#define IPC_MAX_MAILBOX_BYTES	256
+
+/* Global Message - Types and Replies */
+enum ipc_glb_type {
+	IPC_GLB_GET_FW_VERSION = 0,		/* Retrieves firmware version */
+	IPC_GLB_PERFORMANCE_MONITOR = 1,	/* Performance monitoring actions */
+	IPC_GLB_ALLOCATE_STREAM = 3,		/* Request to allocate new stream */
+	IPC_GLB_FREE_STREAM = 4,		/* Request to free stream */
+	IPC_GLB_GET_FW_CAPABILITIES = 5,	/* Retrieves firmware capabilities */
+	IPC_GLB_STREAM_MESSAGE = 6,		/* Message directed to stream or its stages */
+	/* Request to store firmware context during D0->D3 transition */
+	IPC_GLB_REQUEST_DUMP = 7,
+	/* Request to restore firmware context during D3->D0 transition */
+	IPC_GLB_RESTORE_CONTEXT = 8,
+	IPC_GLB_GET_DEVICE_FORMATS = 9,		/* Set device format */
+	IPC_GLB_SET_DEVICE_FORMATS = 10,	/* Get device format */
+	IPC_GLB_SHORT_REPLY = 11,
+	IPC_GLB_ENTER_DX_STATE = 12,
+	IPC_GLB_GET_MIXER_STREAM_INFO = 13,	/* Request mixer stream params */
+	IPC_GLB_DEBUG_LOG_MESSAGE = 14,		/* Message to or from the debug logger. */
+	IPC_GLB_REQUEST_TRANSFER = 16, 		/* < Request Transfer for host */
+	IPC_GLB_MAX_IPC_MESSAGE_TYPE = 17,	/* Maximum message number */
+};
+
+enum ipc_glb_reply {
+	IPC_GLB_REPLY_SUCCESS = 0,		/* The operation was successful. */
+	IPC_GLB_REPLY_ERROR_INVALID_PARAM = 1,	/* Invalid parameter was passed. */
+	IPC_GLB_REPLY_UNKNOWN_MESSAGE_TYPE = 2,	/* Uknown message type was resceived. */
+	IPC_GLB_REPLY_OUT_OF_RESOURCES = 3,	/* No resources to satisfy the request. */
+	IPC_GLB_REPLY_BUSY = 4,			/* The system or resource is busy. */
+	IPC_GLB_REPLY_PENDING = 5,		/* The action was scheduled for processing.  */
+	IPC_GLB_REPLY_FAILURE = 6,		/* Critical error happened. */
+	IPC_GLB_REPLY_INVALID_REQUEST = 7,	/* Request can not be completed. */
+	IPC_GLB_REPLY_STAGE_UNINITIALIZED = 8,	/* Processing stage was uninitialized. */
+	IPC_GLB_REPLY_NOT_FOUND = 9,		/* Required resource can not be found. */
+	IPC_GLB_REPLY_SOURCE_NOT_STARTED = 10,	/* Source was not started. */
+};
+
+/* Stream Message - Types */
+enum ipc_str_operation {
+	IPC_STR_RESET = 0,
+	IPC_STR_PAUSE = 1,
+	IPC_STR_RESUME = 2,
+	IPC_STR_STAGE_MESSAGE = 3,
+	IPC_STR_NOTIFICATION = 4,
+	IPC_STR_MAX_MESSAGE
+};
+
+/* Stream Stage Message Types */
+enum ipc_stg_operation {
+	IPC_STG_GET_VOLUME = 0,
+	IPC_STG_SET_VOLUME,
+	IPC_STG_SET_WRITE_POSITION,
+	IPC_STG_SET_FX_ENABLE,
+	IPC_STG_SET_FX_DISABLE,
+	IPC_STG_SET_FX_GET_PARAM,
+	IPC_STG_SET_FX_SET_PARAM,
+	IPC_STG_SET_FX_GET_INFO,
+	IPC_STG_MUTE_LOOPBACK,
+	IPC_STG_MAX_MESSAGE
+};
+
+/* Stream Stage Message Types For Notification*/
+enum ipc_stg_operation_notify {
+	IPC_POSITION_CHANGED = 0,
+	IPC_STG_GLITCH,
+	IPC_STG_MAX_NOTIFY
+};
+
+enum ipc_glitch_type {
+	IPC_GLITCH_UNDERRUN = 1,
+	IPC_GLITCH_DECODER_ERROR,
+	IPC_GLITCH_DOUBLED_WRITE_POS,
+	IPC_GLITCH_MAX
+};
+
+/* Debug Control */
+enum ipc_debug_operation {
+	IPC_DEBUG_ENABLE_LOG = 0,
+	IPC_DEBUG_DISABLE_LOG = 1,
+	IPC_DEBUG_REQUEST_LOG_DUMP = 2,
+	IPC_DEBUG_NOTIFY_LOG_DUMP = 3,
+	IPC_DEBUG_MAX_DEBUG_LOG
+};
+
+/* Firmware Ready */
+struct sst_hsw_ipc_fw_ready {
+	u32 inbox_offset;
+	u32 outbox_offset;
+	u32 inbox_size;
+	u32 outbox_size;
+	u32 fw_info_size;
+	u8 fw_info[1];
+} __attribute__((packed));
+
+struct ipc_message {
+	struct list_head list;
+	u32 header;
+
+	/* direction wrt host CPU */
+	char tx_data[IPC_MAX_MAILBOX_BYTES];
+	size_t tx_size;
+	char rx_data[IPC_MAX_MAILBOX_BYTES];
+	size_t rx_size;
+
+	wait_queue_head_t waitq;
+	bool pending;
+	bool complete;
+	bool wait;
+	int errno;
+};
+
+struct sst_hsw_stream;
+struct sst_hsw;
+
+/* Stream infomation */
+struct sst_hsw_stream {
+	/* configuration */
+	struct sst_hsw_ipc_stream_alloc_req request;
+	struct sst_hsw_ipc_stream_alloc_reply reply;
+	struct sst_hsw_ipc_stream_free_req free_req;
+
+	/* Mixer info */
+	u32 mute_volume[SST_HSW_NO_CHANNELS];
+	u32 mute[SST_HSW_NO_CHANNELS];
+
+	/* runtime info */
+	struct sst_hsw *hsw;
+	int host_id;
+	bool commited;
+	bool running;
+
+	/* Notification work */
+	struct work_struct notify_work;
+	u32 header;
+
+	/* Position info from DSP */
+	struct sst_hsw_ipc_stream_set_position wpos;
+	struct sst_hsw_ipc_stream_get_position rpos;
+	struct sst_hsw_ipc_stream_glitch_position glitch;
+
+	/* Volume info */
+	struct sst_hsw_ipc_volume_req vol_req;
+
+	/* driver callback */
+	u32 (*notify_position)(struct sst_hsw_stream *stream, void *data);
+	void *pdata;
+
+	struct list_head node;
+};
+
+/* FW log ring information */
+struct sst_hsw_log_stream {
+	dma_addr_t dma_addr;
+	unsigned char *dma_area;
+	unsigned char *ring_descr;
+	int pages;
+	int size;
+
+	/* Notification work */
+	struct work_struct notify_work;
+	wait_queue_head_t readers_wait_q;
+	struct mutex rw_mutex;
+
+	u32 last_pos;
+	u32 curr_pos;
+	u32 reader_pos;
+
+	/* fw log config */
+	u32 config[SST_HSW_FW_LOG_CONFIG_DWORDS];
+
+	struct sst_hsw *hsw;
+};
+
+/* SST Haswell IPC data */
+struct sst_hsw {
+	struct device *dev;
+	struct sst_dsp *dsp;
+	struct platform_device *pdev_pcm;
+
+	/* FW config */
+	struct sst_hsw_ipc_fw_ready fw_ready;
+	struct sst_hsw_ipc_fw_version version;
+	struct sst_module *scratch;
+	bool fw_done;
+
+	/* stream */
+	struct list_head stream_list;
+
+	/* global mixer */
+	struct sst_hsw_ipc_stream_info_reply mixer_info;
+	enum sst_hsw_volume_curve curve_type;
+	u32 curve_duration;
+	u32 mute[SST_HSW_NO_CHANNELS];
+	u32 mute_volume[SST_HSW_NO_CHANNELS];
+
+	/* DX */
+	struct sst_hsw_ipc_dx_reply dx;
+
+	/* boot */
+	wait_queue_head_t boot_wait;
+	bool boot_complete;
+	bool shutdown;
+
+	/* IPC messaging */
+	struct list_head tx_list;
+	struct list_head rx_list;
+	struct list_head empty_list;
+	wait_queue_head_t wait_txq;
+	struct task_struct *tx_thread;
+	struct kthread_worker kworker;
+	struct kthread_work kwork;
+	bool pending;
+	struct ipc_message *msg;
+
+	/* FW log stream */
+	struct sst_hsw_log_stream log_stream;
+};
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/hswadsp.h>
+
+static inline u32 msg_get_global_type(u32 msg)
+{
+	return (msg & IPC_GLB_TYPE_MASK) >> IPC_GLB_TYPE_SHIFT;
+}
+
+static inline u32 msg_get_global_reply(u32 msg)
+{
+	return (msg & IPC_GLB_REPLY_MASK) >> IPC_GLB_REPLY_SHIFT;
+}
+
+static inline u32 msg_get_stream_type(u32 msg)
+{
+	return (msg & IPC_STR_TYPE_MASK) >>  IPC_STR_TYPE_SHIFT;
+}
+
+static inline u32 msg_get_stage_type(u32 msg)
+{
+	return (msg & IPC_STG_TYPE_MASK) >>  IPC_STG_TYPE_SHIFT;
+}
+
+static inline u32 msg_set_stage_type(u32 msg, u32 type)
+{
+	return (msg & ~IPC_STG_TYPE_MASK) +
+		(type << IPC_STG_TYPE_SHIFT);
+}
+
+static inline u32 msg_get_stream_id(u32 msg)
+{
+	return (msg & IPC_STR_ID_MASK) >>  IPC_STR_ID_SHIFT;
+}
+
+static inline u32 msg_get_notify_reason(u32 msg)
+{
+	return (msg & IPC_STG_TYPE_MASK) >> IPC_STG_TYPE_SHIFT;
+}
+
+u32 create_channel_map(enum sst_hsw_channel_config config)
+{
+	switch (config) {
+	case SST_HSW_CHANNEL_CONFIG_MONO:
+		return (0xFFFFFFF0 | SST_HSW_CHANNEL_CENTER);
+	case SST_HSW_CHANNEL_CONFIG_STEREO:
+		return (0xFFFFFF00 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_RIGHT << 4));
+	case SST_HSW_CHANNEL_CONFIG_2_POINT_1:
+		return (0xFFFFF000 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_RIGHT << 4)
+			| (SST_HSW_CHANNEL_LFE << 8 ));
+	case SST_HSW_CHANNEL_CONFIG_3_POINT_0:
+		return (0xFFFFF000 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_CENTER << 4)
+			| (SST_HSW_CHANNEL_RIGHT << 8));
+	case SST_HSW_CHANNEL_CONFIG_3_POINT_1:
+		return (0xFFFF0000 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_CENTER << 4)
+			| (SST_HSW_CHANNEL_RIGHT << 8)
+			| (SST_HSW_CHANNEL_LFE << 12));
+	case SST_HSW_CHANNEL_CONFIG_QUATRO:
+		return (0xFFFF0000 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_RIGHT << 4)
+			| (SST_HSW_CHANNEL_LEFT_SURROUND << 8)
+			| (SST_HSW_CHANNEL_RIGHT_SURROUND << 12));
+	case SST_HSW_CHANNEL_CONFIG_4_POINT_0:
+		return (0xFFFF0000 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_CENTER << 4)
+			| (SST_HSW_CHANNEL_RIGHT << 8)
+			| (SST_HSW_CHANNEL_CENTER_SURROUND << 12));
+	case SST_HSW_CHANNEL_CONFIG_5_POINT_0:
+		return (0xFFF00000 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_CENTER << 4)
+			| (SST_HSW_CHANNEL_RIGHT << 8)
+			| (SST_HSW_CHANNEL_LEFT_SURROUND << 12)
+			| (SST_HSW_CHANNEL_RIGHT_SURROUND << 16));
+	case SST_HSW_CHANNEL_CONFIG_5_POINT_1:
+		return (0xFF000000 | SST_HSW_CHANNEL_CENTER
+			| (SST_HSW_CHANNEL_LEFT << 4)
+			| (SST_HSW_CHANNEL_RIGHT << 8)
+			| (SST_HSW_CHANNEL_LEFT_SURROUND << 12)
+			| (SST_HSW_CHANNEL_RIGHT_SURROUND << 16)
+			| (SST_HSW_CHANNEL_LFE << 20));
+	case SST_HSW_CHANNEL_CONFIG_DUAL_MONO:
+		return (0xFFFFFF00 | SST_HSW_CHANNEL_LEFT
+			| (SST_HSW_CHANNEL_LEFT << 4));
+	default:
+		return 0xFFFFFFFF;
+	}
+}
+
+static struct sst_hsw_stream *get_stream_by_id(struct sst_hsw *hsw,
+	int stream_id)
+{
+	struct sst_hsw_stream *stream;
+
+	list_for_each_entry(stream, &hsw->stream_list, node) {
+		if (stream->reply.stream_hw_id == stream_id)
+			return stream;
+	}
+
+	return NULL;
+}
+
+static void ipc_shim_dbg(struct sst_hsw *hsw, const char *text)
+{
+	struct sst_dsp *sst = hsw->dsp;
+	u32 isr, ipcd, imrx, ipcx;
+
+	ipcx = sst_dsp_shim_read_unlocked(sst, SST_IPCX);
+	isr = sst_dsp_shim_read_unlocked(sst, SST_ISRX);
+	ipcd = sst_dsp_shim_read_unlocked(sst, SST_IPCD);
+	imrx = sst_dsp_shim_read_unlocked(sst, SST_IMRX);
+
+	dev_err(hsw->dev, "ipc: --%s-- ipcx 0x%8.8x isr 0x%8.8x ipcd 0x%8.8x imrx 0x%8.8x\n",
+		text, ipcx, isr, ipcd, imrx);
+}
+
+/* locks held by caller */
+static struct ipc_message *msg_get_empty(struct sst_hsw *hsw)
+{
+	struct ipc_message *msg = NULL;
+
+	if (!list_empty(&hsw->empty_list)) {
+		msg = list_first_entry(&hsw->empty_list, struct ipc_message,
+			list);
+		list_del(&msg->list);
+	}
+
+	return msg;
+}
+
+static void ipc_tx_msgs(struct kthread_work *work)
+{
+	struct sst_hsw *hsw =
+		container_of(work, struct sst_hsw, kwork);
+	struct ipc_message *msg;
+	unsigned long flags;
+	u32 ipcx;
+
+	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
+
+	if (list_empty(&hsw->tx_list) || hsw->pending) {
+		spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
+		return;
+	}
+
+	/* if the DSP is busy we will TX messages after IRQ */
+	ipcx = sst_dsp_shim_read_unlocked(hsw->dsp, SST_IPCX);
+	if (ipcx & SST_IPCX_BUSY) {
+		spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
+		return;
+	}
+
+	msg = list_first_entry(&hsw->tx_list, struct ipc_message, list);
+
+	list_move(&msg->list, &hsw->rx_list);
+
+	/* send the message */
+	sst_dsp_outbox_write(hsw->dsp, msg->tx_data, msg->tx_size);
+	sst_dsp_ipc_msg_tx(hsw->dsp, msg->header | SST_IPCX_BUSY);
+
+	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
+}
+
+/* locks held by caller */
+static void tx_msg_reply_complete(struct sst_hsw *hsw, struct ipc_message *msg)
+{
+	msg->complete = true;
+	trace_ipc_reply("completed", msg->header);
+
+	if (!msg->wait)
+		list_add_tail(&msg->list, &hsw->empty_list);
+	else
+		wake_up(&msg->waitq);
+}
+
+static int tx_wait_done(struct sst_hsw *hsw, struct ipc_message *msg,
+	void *rx_data)
+{
+	unsigned long flags;
+	int ret;
+
+	/* wait for DSP completion (in all cases atm inc pending) */
+	ret = wait_event_timeout(msg->waitq, msg->complete,
+		msecs_to_jiffies(IPC_TIMEOUT_MSECS));
+
+	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
+	if (ret == 0) {
+		ipc_shim_dbg(hsw, "message timeout");
+
+		trace_ipc_error("error message timeout for", msg->header);
+		ret = -ETIMEDOUT;
+	} else {
+
+		/* copy the data returned from DSP */
+		if (msg->rx_size)
+			memcpy(rx_data, msg->rx_data, msg->rx_size);
+		ret = msg->errno;
+	}
+
+	list_add_tail(&msg->list, &hsw->empty_list);
+	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
+	return ret;
+}
+
+static int ipc_tx_message(struct sst_hsw *hsw, u32 header, void *tx_data,
+	size_t tx_bytes, void *rx_data, size_t rx_bytes, int wait)
+{
+	struct ipc_message *msg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
+
+	msg = msg_get_empty(hsw);
+	if (msg == NULL) {
+		spin_unlock(&hsw->dsp->spinlock);
+		return -EBUSY;
+	}
+
+	if (tx_bytes)
+		memcpy(msg->tx_data, tx_data, tx_bytes);
+
+	msg->header = header;
+	msg->tx_size = tx_bytes;
+	msg->rx_size = rx_bytes;
+	msg->wait = wait;
+	msg->errno = 0;
+	msg->pending = false;
+	msg->complete = false;
+
+	list_add_tail(&msg->list, &hsw->tx_list);
+	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
+
+	queue_kthread_work(&hsw->kworker, &hsw->kwork);
+
+	if (wait)
+		return tx_wait_done(hsw, msg, rx_data);
+	else
+		return 0;
+}
+
+static inline int ipc_tx_message_wait(struct sst_hsw *hsw, u32 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
+{
+	return ipc_tx_message(hsw, header, tx_data, tx_bytes, rx_data,
+		rx_bytes, 1);
+}
+
+static inline int ipc_tx_message_nowait(struct sst_hsw *hsw, u32 header,
+	void *tx_data, size_t tx_bytes)
+{
+	return ipc_tx_message(hsw, header, tx_data, tx_bytes, NULL, 0, 0);
+}
+
+static void hsw_fw_ready(struct sst_hsw *hsw, u32 header)
+{
+	struct sst_hsw_ipc_fw_ready fw_ready;
+	u32 offset;
+
+	offset = (header & 0x1FFFFFFF) << 3;
+
+	dev_dbg(hsw->dev, "ipc: DSP is ready 0x%8.8x offset %d\n",
+		header, offset);
+
+	/* copy data from the DSP FW ready offset */
+	sst_dsp_read(hsw->dsp, &fw_ready, offset, sizeof(fw_ready));
+
+	sst_dsp_mailbox_init(hsw->dsp, fw_ready.inbox_offset,
+		fw_ready.inbox_size, fw_ready.outbox_offset,
+		fw_ready.outbox_size);
+
+	hsw->boot_complete = true;
+	wake_up(&hsw->boot_wait);
+
+	dev_dbg(hsw->dev, " mailbox upstream 0x%x - size 0x%x\n",
+		fw_ready.inbox_offset, fw_ready.inbox_size);
+	dev_dbg(hsw->dev, " mailbox downstream 0x%x - size 0x%x\n",
+		fw_ready.outbox_offset, fw_ready.outbox_size);
+}
+
+static void hsw_notification_work(struct work_struct *work)
+{
+	struct sst_hsw_stream *stream = container_of(work,
+			struct sst_hsw_stream, notify_work);
+	struct sst_hsw_ipc_stream_glitch_position *glitch = &stream->glitch;
+	struct sst_hsw_ipc_stream_get_position *pos = &stream->rpos;
+	struct sst_hsw *hsw = stream->hsw;
+	u32 reason;
+
+	reason = msg_get_notify_reason(stream->header);
+
+	switch (reason) {
+	case IPC_STG_GLITCH:
+		trace_ipc_notification("DSP stream under/overrun",
+			stream->reply.stream_hw_id);
+		sst_dsp_inbox_read(hsw->dsp, glitch, sizeof(*glitch));
+
+		dev_err(hsw->dev, "glitch %d pos 0x%x write pos 0x%x\n",
+			glitch->glitch_type, glitch->present_pos,
+			glitch->write_pos);
+		break;
+
+	case IPC_POSITION_CHANGED:
+		trace_ipc_notification("DSP stream position changed for",
+			stream->reply.stream_hw_id);
+		sst_dsp_inbox_read(hsw->dsp, pos, sizeof(&pos));
+
+		if (stream->notify_position)
+			stream->notify_position(stream, stream->pdata);
+
+		break;
+	default:
+		dev_err(hsw->dev, "error: unknown notification 0x%x\n",
+			stream->header);
+		break;
+	}
+
+	/* tell DSP that notification has been handled */
+	sst_dsp_shim_update_bits_unlocked(hsw->dsp, SST_IPCD,
+		SST_IPCD_BUSY | SST_IPCD_DONE, SST_IPCD_DONE);
+
+	/* unmask busy interrupt */
+	sst_dsp_shim_update_bits_unlocked(hsw->dsp, SST_IMRX, SST_IMRX_BUSY, 0);
+}
+
+static struct ipc_message *reply_find_msg(struct sst_hsw *hsw, u32 header)
+{
+	struct ipc_message *msg;
+
+	/* clear reply bits & status bits */
+	header &= ~(IPC_STATUS_MASK | IPC_GLB_REPLY_MASK);
+
+	if (list_empty(&hsw->rx_list)) {
+		dev_err(hsw->dev, "error: rx list empty but received 0x%x\n",
+			header);
+		return NULL;
+	}
+
+	list_for_each_entry(msg, &hsw->rx_list, list) {
+		if (msg->header == header)
+			return msg;
+	}
+
+	return NULL;
+}
+
+static void hsw_stream_update(struct sst_hsw *hsw, struct ipc_message *msg)
+{
+	struct sst_hsw_stream *stream;
+	u32 header = msg->header & ~(IPC_STATUS_MASK | IPC_GLB_REPLY_MASK);
+	u32 stream_id = msg_get_stream_id(header);
+	u32 stream_msg = msg_get_stream_type(header);
+
+	stream = get_stream_by_id(hsw, stream_id);
+	if (stream == NULL)
+		return;
+
+	switch (stream_msg) {
+	case IPC_STR_STAGE_MESSAGE:
+	case IPC_STR_NOTIFICATION:
+	case IPC_STR_RESET:
+		break;
+	case IPC_STR_PAUSE:
+		stream->running = false;
+		trace_ipc_notification("stream paused",
+			stream->reply.stream_hw_id);
+		break;
+	case IPC_STR_RESUME:
+		stream->running = true;
+		trace_ipc_notification("stream running",
+			stream->reply.stream_hw_id);
+		break;
+	}
+}
+
+static int hsw_process_reply(struct sst_hsw *hsw, u32 header)
+{
+	struct ipc_message *msg;
+	u32 reply = msg_get_global_reply(header);
+
+	trace_ipc_reply("processing -->", header);
+
+	msg = reply_find_msg(hsw, header);
+	if (msg == NULL) {
+		trace_ipc_error("error: can't find message header", header);
+		return -EIO;
+	}
+
+	/* first process the header */
+	switch (reply) {
+	case IPC_GLB_REPLY_PENDING:
+		trace_ipc_pending_reply("received", header);
+		msg->pending = true;
+		hsw->pending = true;
+		return 1;
+	case IPC_GLB_REPLY_SUCCESS:
+		if (msg->pending) {
+			trace_ipc_pending_reply("completed", header);
+			sst_dsp_inbox_read(hsw->dsp, msg->rx_data,
+				msg->rx_size);
+			hsw->pending = false;
+		} else {
+			/* copy data from the DSP */
+			sst_dsp_outbox_read(hsw->dsp, msg->rx_data,
+				msg->rx_size);
+		}
+		break;
+	/* these will be rare - but useful for debug */
+	case IPC_GLB_REPLY_UNKNOWN_MESSAGE_TYPE:
+		trace_ipc_error("error: unknown message type", header);
+		msg->errno = -EBADMSG;
+		break;
+	case IPC_GLB_REPLY_OUT_OF_RESOURCES:
+		trace_ipc_error("error: out of resources", header);
+		msg->errno = -ENOMEM;
+		break;
+	case IPC_GLB_REPLY_BUSY:
+		trace_ipc_error("error: reply busy", header);
+		msg->errno = -EBUSY;
+		break;
+	case IPC_GLB_REPLY_FAILURE:
+		trace_ipc_error("error: reply failure", header);
+		msg->errno = -EINVAL;
+		break;
+	case IPC_GLB_REPLY_STAGE_UNINITIALIZED:
+		trace_ipc_error("error: stage uninitialized", header);
+		msg->errno = -EINVAL;
+		break;
+	case IPC_GLB_REPLY_NOT_FOUND:
+		trace_ipc_error("error: reply not found", header);
+		msg->errno = -EINVAL;
+		break;
+	case IPC_GLB_REPLY_SOURCE_NOT_STARTED:
+		trace_ipc_error("error: source not started", header);
+		msg->errno = -EINVAL;
+		break;
+	case IPC_GLB_REPLY_INVALID_REQUEST:
+		trace_ipc_error("error: invalid request", header);
+		msg->errno = -EINVAL;
+		break;
+	case IPC_GLB_REPLY_ERROR_INVALID_PARAM:
+		trace_ipc_error("error: invalid parameter", header);
+		msg->errno = -EINVAL;
+		break;
+	default:
+		trace_ipc_error("error: unknown reply", header);
+		msg->errno = -EINVAL;
+		break;
+	}
+
+	/* update any stream states */
+	hsw_stream_update(hsw, msg);
+
+	/* wake up and return the error if we have waiters on this message ? */
+	list_del(&msg->list);
+	tx_msg_reply_complete(hsw, msg);
+
+	return 1;
+}
+
+static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
+{
+	u32 stream_msg, stream_id, stage_type;
+	struct sst_hsw_stream *stream;
+	int handled = 0;
+
+	stream_msg = msg_get_stream_type(header);
+	stream_id = msg_get_stream_id(header);
+	stage_type = msg_get_stage_type(header);
+
+	stream = get_stream_by_id(hsw, stream_id);
+	if (stream == NULL)
+		return handled;
+
+	stream->header = header;
+
+	switch (stream_msg) {
+	case IPC_STR_STAGE_MESSAGE:
+		dev_err(hsw->dev, "error: stage msg not implemented 0x%8.8x\n",
+			header);
+		break;
+	case IPC_STR_NOTIFICATION:
+		schedule_work(&stream->notify_work);
+		break;
+	default:
+		/* handle pending message complete request */
+		handled = hsw_process_reply(hsw, header);
+		break;
+	}
+
+	return handled;
+}
+
+static int hsw_log_message(struct sst_hsw *hsw, u32 header)
+{
+	u32 operation = (header & IPC_LOG_OP_MASK) >>  IPC_LOG_OP_SHIFT;
+	struct sst_hsw_log_stream *stream = &hsw->log_stream;
+	int ret = 1;
+
+	if (operation != IPC_DEBUG_REQUEST_LOG_DUMP) {
+		dev_err(hsw->dev,
+			"error: log msg not implemented 0x%8.8x\n", header);
+		return 0;
+	}
+
+	mutex_lock(&stream->rw_mutex);
+	stream->last_pos = stream->curr_pos;
+	sst_dsp_inbox_read(
+		hsw->dsp, &stream->curr_pos, sizeof(stream->curr_pos));
+	mutex_unlock(&stream->rw_mutex);
+
+	schedule_work(&stream->notify_work);
+
+	return ret;
+}
+
+static int hsw_process_notification(struct sst_hsw *hsw)
+{
+	struct sst_dsp *sst = hsw->dsp;
+	u32 type, header;
+	int handled = 1;
+
+	header = sst_dsp_shim_read_unlocked(sst, SST_IPCD);
+	type = msg_get_global_type(header);
+
+	trace_ipc_request("processing -->", header);
+
+	/* FW Ready is a special case */
+	if (!hsw->boot_complete && header & IPC_FW_READY) {
+		hsw_fw_ready(hsw, header);
+		return handled;
+	}
+
+	switch (type) {
+	case IPC_GLB_GET_FW_VERSION:
+	case IPC_GLB_ALLOCATE_STREAM:
+	case IPC_GLB_FREE_STREAM:
+	case IPC_GLB_GET_FW_CAPABILITIES:
+	case IPC_GLB_REQUEST_DUMP:
+	case IPC_GLB_GET_DEVICE_FORMATS:
+	case IPC_GLB_SET_DEVICE_FORMATS:
+	case IPC_GLB_ENTER_DX_STATE:
+	case IPC_GLB_GET_MIXER_STREAM_INFO:
+	case IPC_GLB_MAX_IPC_MESSAGE_TYPE:
+	case IPC_GLB_RESTORE_CONTEXT:
+	case IPC_GLB_SHORT_REPLY:
+		dev_err(hsw->dev, "error: message type %d header 0x%x\n",
+			type, header);
+		break;
+	case IPC_GLB_STREAM_MESSAGE:
+		handled = hsw_stream_message(hsw, header);
+		break;
+	case IPC_GLB_DEBUG_LOG_MESSAGE:
+		handled = hsw_log_message(hsw, header);
+		break;
+	default:
+		dev_err(hsw->dev, "error: unexpected type %d hdr 0x%8.8x\n",
+			type, header);
+		break;
+	}
+
+	return handled;
+}
+
+static irqreturn_t hsw_irq_thread(int irq, void *context)
+{
+	struct sst_dsp *sst = (struct sst_dsp *) context;
+	struct sst_hsw *hsw = sst_dsp_get_thread_context(sst);
+	u32 ipcx, ipcd;
+	int handled;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sst->spinlock, flags);
+
+	ipcx = sst_dsp_ipc_msg_rx(hsw->dsp);
+	ipcd = sst_dsp_shim_read_unlocked(sst, SST_IPCD);
+
+	/* reply message from DSP */
+	if (ipcx & SST_IPCX_DONE) {
+
+		/* Handle Immediate reply from DSP Core */
+		handled = hsw_process_reply(hsw, ipcx);
+
+		if (handled) {
+			/* clear DONE bit - tell DSP we have completed */
+			sst_dsp_shim_update_bits_unlocked(sst, SST_IPCX,
+				SST_IPCX_DONE, 0);
+
+			/* unmask Done interrupt */
+			sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
+				SST_IMRX_DONE, 0);
+		}
+	}
+
+	/* new message from DSP */
+	if (ipcd & SST_IPCD_BUSY) {
+
+		/* Handle Notification and Delayed reply from DSP Core */
+		handled = hsw_process_notification(hsw);
+
+		/* clear BUSY bit and set DONE bit - accept new messages */
+		if (handled) {
+			sst_dsp_shim_update_bits_unlocked(sst, SST_IPCD,
+				SST_IPCD_BUSY | SST_IPCD_DONE, SST_IPCD_DONE);
+
+			/* unmask busy interrupt */
+			sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
+				SST_IMRX_BUSY, 0);
+		}
+	}
+
+	spin_unlock_irqrestore(&sst->spinlock, flags);
+
+	/* continue to send any remaining messages... */
+	queue_kthread_work(&hsw->kworker, &hsw->kwork);
+
+	return IRQ_HANDLED;
+}
+
+int sst_hsw_fw_get_version(struct sst_hsw *hsw,
+	struct sst_hsw_ipc_fw_version *version)
+{
+	int ret;
+
+	ret = ipc_tx_message_wait(hsw, IPC_GLB_TYPE(IPC_GLB_GET_FW_VERSION),
+		NULL, 0, version, sizeof(*version));
+	if (ret < 0)
+		dev_err(hsw->dev, "error: get version failed\n");
+
+	return ret;
+}
+
+/* Mixer Controls */
+int sst_hsw_stream_mute(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 stage_id, u32 channel)
+{
+	int ret;
+
+	ret = sst_hsw_stream_get_volume(hsw, stream, stage_id, channel,
+		&stream->mute_volume[channel]);
+	if (ret < 0)
+		return ret;
+
+	ret = sst_hsw_stream_set_volume(hsw, stream, stage_id, channel, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: can't unmute stream %d channel %d\n",
+			stream->reply.stream_hw_id, channel);
+		return ret;
+	}
+
+	stream->mute[channel] = 1;
+	return 0;
+}
+
+int sst_hsw_stream_unmute(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 stage_id, u32 channel)
+
+{
+	int ret;
+
+	stream->mute[channel] = 0;
+	ret = sst_hsw_stream_set_volume(hsw, stream, stage_id, channel,
+		stream->mute_volume[channel]);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: can't unmute stream %d channel %d\n",
+			stream->reply.stream_hw_id, channel);
+		return ret;
+	}
+
+	return 0;
+}
+
+int sst_hsw_stream_get_volume(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 stage_id, u32 channel, u32 *volume)
+{
+	if (channel > 1)
+		return -EINVAL;
+
+	sst_dsp_read(hsw->dsp, volume,
+		stream->reply.volume_register_address[channel], sizeof(volume));
+
+	return 0;
+}
+
+int sst_hsw_stream_set_volume_curve(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u64 curve_duration,
+	enum sst_hsw_volume_curve curve)
+{
+	/* curve duration in steps of 100ns */
+	stream->vol_req.curve_duration = curve_duration;
+	stream->vol_req.curve_type = curve;
+
+	return 0;
+}
+
+/* stream volume */
+int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 stage_id, u32 channel, u32 volume)
+{
+	struct sst_hsw_ipc_volume_req *req;
+	u32 header;
+	int ret;
+
+	trace_ipc_request("set stream volume", stream->reply.stream_hw_id);
+
+	if (channel > 1)
+		return -EINVAL;
+
+	if (stream->mute[channel]) {
+		stream->mute_volume[channel] = volume;
+		return 0;
+	}
+
+	header = IPC_GLB_TYPE(IPC_GLB_STREAM_MESSAGE) |
+		IPC_STR_TYPE(IPC_STR_STAGE_MESSAGE);
+	header |= (stream->reply.stream_hw_id << IPC_STR_ID_SHIFT);
+	header |= (IPC_STG_SET_VOLUME << IPC_STG_TYPE_SHIFT);
+	header |= (stage_id << IPC_STG_ID_SHIFT);
+
+	req = &stream->vol_req;
+	req->channel = channel;
+	req->target_volume = volume;
+
+	ret = ipc_tx_message_wait(hsw, header, req, sizeof(*req), NULL, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: set stream volume failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int sst_hsw_mixer_mute(struct sst_hsw *hsw, u32 stage_id, u32 channel)
+{
+	int ret;
+
+	ret = sst_hsw_mixer_get_volume(hsw, stage_id, channel,
+		&hsw->mute_volume[channel]);
+	if (ret < 0)
+		return ret;
+
+	ret = sst_hsw_mixer_set_volume(hsw, stage_id, channel, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: failed to unmute mixer channel %d\n",
+			channel);
+		return ret;
+	}
+
+	hsw->mute[channel] = 1;
+	return 0;
+}
+
+int sst_hsw_mixer_unmute(struct sst_hsw *hsw, u32 stage_id, u32 channel)
+{
+	int ret;
+
+	ret = sst_hsw_mixer_set_volume(hsw, stage_id, channel,
+		hsw->mixer_info.volume_register_address[channel]);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: failed to unmute mixer channel %d\n",
+			channel);
+		return ret;
+	}
+
+	hsw->mute[channel] = 0;
+	return 0;
+}
+
+int sst_hsw_mixer_get_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
+	u32 *volume)
+{
+	if (channel > 1)
+		return -EINVAL;
+
+	sst_dsp_read(hsw->dsp, volume,
+		hsw->mixer_info.volume_register_address[channel],
+		sizeof(*volume));
+
+	return 0;
+}
+
+int sst_hsw_mixer_set_volume_curve(struct sst_hsw *hsw,
+	 u64 curve_duration, enum sst_hsw_volume_curve curve)
+{
+	/* curve duration in steps of 100ns */
+	hsw->curve_duration = curve_duration;
+	hsw->curve_type = curve;
+
+	return 0;
+}
+
+/* global mixer volume */
+int sst_hsw_mixer_set_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
+	u32 volume)
+{
+	struct sst_hsw_ipc_volume_req req;
+	u32 header;
+	int ret;
+
+	trace_ipc_request("set mixer volume", volume);
+
+	/* set both at same time ? */
+	if (channel == 2) {
+		if (hsw->mute[0] && hsw->mute[1]) {
+			hsw->mute_volume[0] = hsw->mute_volume[1] = volume;
+			return 0;
+		} else if (hsw->mute[0])
+			req.channel = 1;
+		else if (hsw->mute[1])
+			req.channel = 0;
+		else
+			req.channel = 0xffffffff;
+	} else {
+		/* set only 1 channel */
+		if (hsw->mute[channel]) {
+			hsw->mute_volume[channel] = volume;
+			return 0;
+		}
+		req.channel = channel;
+	}
+
+	header = IPC_GLB_TYPE(IPC_GLB_STREAM_MESSAGE) |
+		IPC_STR_TYPE(IPC_STR_STAGE_MESSAGE);
+	header |= (hsw->mixer_info.mixer_hw_id << IPC_STR_ID_SHIFT);
+	header |= (IPC_STG_SET_VOLUME << IPC_STG_TYPE_SHIFT);
+	header |= (stage_id << IPC_STG_ID_SHIFT);
+
+	req.curve_duration = hsw->curve_duration;
+	req.curve_type = hsw->curve_type;
+	req.target_volume = volume;
+
+	ret = ipc_tx_message_wait(hsw, header, &req, sizeof(req), NULL, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: set mixer volume failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Stream API */
+struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
+	u32 (*notify_position)(struct sst_hsw_stream *stream, void *data),
+	void *data)
+{
+	struct sst_hsw_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (stream == NULL)
+		return NULL;
+
+	list_add(&stream->node, &hsw->stream_list);
+	stream->notify_position = notify_position;
+	stream->pdata = data;
+	stream->hsw = hsw;
+	stream->host_id = id;
+
+	/* work to process notification messages */
+	INIT_WORK(&stream->notify_work, hsw_notification_work);
+
+	return stream;
+}
+
+int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
+{
+	u32 header;
+	int ret = 0;
+
+	/* dont free DSP streams that are not commited */
+	if (!stream->commited)
+		goto out;
+
+	trace_ipc_request("stream free", stream->host_id);
+
+	stream->free_req.stream_id = stream->reply.stream_hw_id;
+	header = IPC_GLB_TYPE(IPC_GLB_FREE_STREAM);
+
+	ret = ipc_tx_message_wait(hsw, header, &stream->free_req,
+		sizeof(stream->free_req), NULL, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: free stream %d failed\n",
+			stream->free_req.stream_id);
+		return -EAGAIN;
+	}
+
+	trace_hsw_stream_free_req(stream, &stream->free_req);
+
+out:
+	list_del(&stream->node);
+	kfree(stream);
+
+	return ret;
+}
+
+int sst_hsw_stream_set_bits(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, enum sst_hsw_bitdepth bits)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set bits\n");
+		return -EINVAL;
+	}
+
+	stream->request.format.bitdepth = bits;
+	return 0;
+}
+
+int sst_hsw_stream_set_channels(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, int channels)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set channels\n");
+		return -EINVAL;
+	}
+
+	/* stereo is only supported atm */
+	if (channels != 2)
+		return -EINVAL;
+
+	stream->request.format.ch_num = channels;
+	return 0;
+}
+
+int sst_hsw_stream_set_rate(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, int rate)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set rate\n");
+		return -EINVAL;
+	}
+
+	stream->request.format.frequency = rate;
+	return 0;
+}
+
+int sst_hsw_stream_set_map_config(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 map,
+	enum sst_hsw_channel_config config)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set map\n");
+		return -EINVAL;
+	}
+
+	stream->request.format.map = map;
+	stream->request.format.config = config;
+	return 0;
+}
+
+int sst_hsw_stream_set_style(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, enum sst_hsw_interleaving style)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set style\n");
+		return -EINVAL;
+	}
+
+	stream->request.format.style = style;
+	return 0;
+}
+
+int sst_hsw_stream_set_valid(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 bits)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set valid bits\n");
+		return -EINVAL;
+	}
+
+	stream->request.format.valid_bit = bits;
+	return 0;
+}
+
+/* Stream Configuration */
+int sst_hsw_stream_format(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	enum sst_hsw_stream_path_id path_id,
+	enum sst_hsw_stream_type stream_type,
+	enum sst_hsw_stream_format format_id)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set format\n");
+		return -EINVAL;
+	}
+
+	stream->request.path_id = path_id;
+	stream->request.stream_type = stream_type;
+	stream->request.format_id = format_id;
+
+	trace_hsw_stream_alloc_request(stream, &stream->request);
+
+	return 0;
+}
+
+int sst_hsw_stream_buffer(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 ring_pt_address, u32 num_pages,
+	u32 ring_size, u32 ring_offset, u32 ring_first_pfn)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for buffer\n");
+		return -EINVAL;
+	}
+
+	stream->request.ringinfo.ring_pt_address = ring_pt_address;
+	stream->request.ringinfo.num_pages = num_pages;
+	stream->request.ringinfo.ring_size = ring_size;
+	stream->request.ringinfo.ring_offset = ring_offset;
+	stream->request.ringinfo.ring_first_pfn = ring_first_pfn;
+
+	trace_hsw_stream_buffer(stream);
+
+	return 0;
+}
+
+int sst_hsw_stream_set_module_info(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, enum sst_hsw_module_id module_id,
+	u32 entry_point)
+{
+	struct sst_hsw_module_map *map = &stream->request.map;
+
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set module\n");
+		return -EINVAL;
+	}
+
+	/* only support initial module atm */
+	map->module_entries_count = 1;
+	map->module_entries[0].module_id = module_id;
+	map->module_entries[0].entry_point = entry_point;
+
+	return 0;
+}
+
+int sst_hsw_stream_set_pmemory_info(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 offset, u32 size)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set pmem\n");
+		return -EINVAL;
+	}
+
+	stream->request.persistent_mem.offset = offset;
+	stream->request.persistent_mem.size = size;
+
+	return 0;
+}
+
+int sst_hsw_stream_set_smemory_info(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 offset, u32 size)
+{
+	if (stream->commited) {
+		dev_err(hsw->dev, "error: stream committed for set smem\n");
+		return -EINVAL;
+	}
+
+	stream->request.scratch_mem.offset = offset;
+	stream->request.scratch_mem.size = size;
+
+	return 0;
+}
+
+int sst_hsw_stream_commit(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
+{
+	struct sst_hsw_ipc_stream_alloc_req *str_req = &stream->request;
+	struct sst_hsw_ipc_stream_alloc_reply *reply = &stream->reply;
+	u32 header;
+	int ret;
+
+	trace_ipc_request("stream alloc", stream->host_id);
+
+	header = IPC_GLB_TYPE(IPC_GLB_ALLOCATE_STREAM);
+
+	ret = ipc_tx_message_wait(hsw, header, str_req, sizeof(*str_req),
+		reply, sizeof(*reply));
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: stream commit failed\n");
+		return ret;
+	}
+
+	stream->commited = 1;
+	trace_hsw_stream_alloc_reply(stream);
+
+	return 0;
+}
+
+/* Stream Information - these calls could be inline but we want the IPC
+ ABI to be opaque to client PCM drivers to cope with any future ABI changes */
+int sst_hsw_stream_get_hw_id(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->reply.stream_hw_id;
+}
+
+int sst_hsw_stream_get_mixer_id(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->reply.mixer_hw_id;
+}
+
+u32 sst_hsw_stream_get_read_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->reply.read_position_register_address;
+}
+
+u32 sst_hsw_stream_get_pointer_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->reply.presentation_position_register_address;
+}
+
+u32 sst_hsw_stream_get_peak_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 channel)
+{
+	if (channel >= 2)
+		return 0;
+
+	return stream->reply.peak_meter_register_address[channel];
+}
+
+u32 sst_hsw_stream_get_vol_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 channel)
+{
+	if (channel >= 2)
+		return 0;
+
+	return stream->reply.volume_register_address[channel];
+}
+
+int sst_hsw_mixer_get_info(struct sst_hsw *hsw)
+{
+	struct sst_hsw_ipc_stream_info_reply *reply;
+	u32 header;
+	int ret;
+
+	reply = &hsw->mixer_info;
+	header = IPC_GLB_TYPE(IPC_GLB_GET_MIXER_STREAM_INFO);
+
+	trace_ipc_request("get global mixer info", 0);
+
+	ret = ipc_tx_message_wait(hsw, header, NULL, 0, reply, sizeof(*reply));
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: get stream info failed\n");
+		return ret;
+	}
+
+	trace_hsw_mixer_info_reply(reply);
+
+	return 0;
+}
+
+/* Send stream command */
+static int sst_hsw_stream_operations(struct sst_hsw *hsw, int type,
+	int stream_id, int wait)
+{
+	u32 header;
+
+	header = IPC_GLB_TYPE(IPC_GLB_STREAM_MESSAGE) | IPC_STR_TYPE(type);
+	header |= (stream_id << IPC_STR_ID_SHIFT);
+
+	if (wait)
+		return ipc_tx_message_wait(hsw, header, NULL, 0, NULL, 0);
+	else
+		return ipc_tx_message_nowait(hsw, header, NULL, 0);
+}
+
+/* Stream ALSA trigger operations */
+int sst_hsw_stream_pause(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	int wait)
+{
+	int ret;
+
+	trace_ipc_request("stream pause", stream->reply.stream_hw_id);
+
+	ret = sst_hsw_stream_operations(hsw, IPC_STR_PAUSE,
+		stream->reply.stream_hw_id, wait);
+	if (ret < 0)
+		dev_err(hsw->dev, "error: failed to pause stream %d\n",
+			stream->reply.stream_hw_id);
+
+	return ret;
+}
+
+int sst_hsw_stream_resume(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	int wait)
+{
+	int ret;
+
+	trace_ipc_request("stream resume", stream->reply.stream_hw_id);
+
+	ret = sst_hsw_stream_operations(hsw, IPC_STR_RESUME,
+		stream->reply.stream_hw_id, wait);
+	if (ret < 0)
+		dev_err(hsw->dev, "error: failed to resume stream %d\n",
+			stream->reply.stream_hw_id);
+
+	return ret;
+}
+
+int sst_hsw_stream_reset(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
+{
+	int ret, tries = 10;
+
+	/* dont reset streams that are not commited */
+	if (!stream->commited)
+		return 0;
+
+	/* wait for pause to complete before we reset the stream */
+	while (stream->running && tries--)
+		msleep(1);
+	if (!tries) {
+		dev_err(hsw->dev, "error: reset stream %d still running\n",
+			stream->reply.stream_hw_id);
+		return -EINVAL;
+	}
+
+	trace_ipc_request("stream reset", stream->reply.stream_hw_id);
+
+	ret = sst_hsw_stream_operations(hsw, IPC_STR_RESET,
+		stream->reply.stream_hw_id, 1);
+	if (ret < 0)
+		dev_err(hsw->dev, "error: failed to reset stream %d\n",
+			stream->reply.stream_hw_id);
+	return ret;
+}
+
+/* Stream pointer positions */
+int sst_hsw_get_dsp_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->rpos.position;
+}
+
+int sst_hsw_stream_set_write_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 stage_id, u32 position)
+{
+	u32 header;
+	int ret;
+
+	trace_stream_write_position(stream->reply.stream_hw_id, position);
+
+	header = IPC_GLB_TYPE(IPC_GLB_STREAM_MESSAGE) |
+		IPC_STR_TYPE(IPC_STR_STAGE_MESSAGE);
+	header |= (stream->reply.stream_hw_id << IPC_STR_ID_SHIFT);
+	header |= (IPC_STG_SET_WRITE_POSITION << IPC_STG_TYPE_SHIFT);
+	header |= (stage_id << IPC_STG_ID_SHIFT);
+	stream->wpos.position = position;
+
+	ret = ipc_tx_message_nowait(hsw, header, &stream->wpos,
+		sizeof(stream->wpos));
+	if (ret < 0)
+		dev_err(hsw->dev, "error: stream %d set position %d failed\n",
+			stream->reply.stream_hw_id, position);
+
+	return ret;
+}
+
+/* physical BE config */
+int sst_hsw_device_set_config(struct sst_hsw *hsw,
+	enum sst_hsw_device_id dev, enum sst_hsw_device_mclk mclk,
+	enum sst_hsw_device_mode mode, u32 clock_divider)
+{
+	struct sst_hsw_ipc_device_config_req config;
+	u32 header;
+	int ret;
+
+	trace_ipc_request("set device config", dev);
+
+	config.ssp_interface = dev;
+	config.clock_frequency = mclk;
+	config.mode = mode;
+	config.clock_divider = clock_divider;
+
+	trace_hsw_device_config_req(&config);
+
+	header = IPC_GLB_TYPE(IPC_GLB_SET_DEVICE_FORMATS);
+
+	ret = ipc_tx_message_wait(hsw, header, &config, sizeof(config),
+		NULL, 0);
+	if (ret < 0)
+		dev_err(hsw->dev, "error: set device formats failed\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_hsw_device_set_config);
+
+/* DX Config */
+int sst_hsw_dx_set_state(struct sst_hsw *hsw,
+	enum sst_hsw_dx_state state, struct sst_hsw_ipc_dx_reply *dx)
+{
+	u32 header, state_;
+	int ret;
+
+	header = IPC_GLB_TYPE(IPC_GLB_ENTER_DX_STATE);
+	state_ = state;
+
+	trace_ipc_request("PM enter Dx state", state);
+
+	ret = ipc_tx_message_wait(hsw, header, &state_, sizeof(state_),
+		dx, sizeof(dx));
+	if (ret < 0) {
+		dev_err(hsw->dev, "ipc: error set dx state %d failed\n", state);
+		return ret;
+	}
+
+	dev_dbg(hsw->dev, "ipc: got %d entry numbers for state %d\n",
+		dx->entries_no, state);
+
+	memcpy(&hsw->dx, dx, sizeof(*dx));
+	return 0;
+}
+
+/* Used to save state into hsw->dx_reply */
+int sst_hsw_dx_get_state(struct sst_hsw *hsw, u32 item,
+	u32 *offset, u32 *size, u32 *source)
+{
+	struct sst_hsw_ipc_dx_memory_item *dx_mem;
+	struct sst_hsw_ipc_dx_reply *dx_reply;
+	int entry_no;
+
+	dx_reply = &hsw->dx;
+	entry_no = dx_reply->entries_no;
+
+	trace_ipc_request("PM get Dx state", entry_no);
+
+	if (item >= entry_no)
+		return -EINVAL;
+
+	dx_mem = &dx_reply->mem_info[item];
+	*offset = dx_mem->offset;
+	*size = dx_mem->size;
+	*source = dx_mem->source;
+
+	return 0;
+}
+
+static int msg_empty_list_init(struct sst_hsw *hsw)
+{
+	int i;
+
+	hsw->msg = kzalloc(sizeof(struct ipc_message) *
+		IPC_EMPTY_LIST_SIZE, GFP_KERNEL);
+	if (hsw->msg == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
+		init_waitqueue_head(&hsw->msg[i].waitq);
+		list_add(&hsw->msg[i].list, &hsw->empty_list);
+	}
+
+	return 0;
+}
+
+void sst_hsw_set_scratch_module(struct sst_hsw *hsw,
+	struct sst_module *scratch)
+{
+	hsw->scratch = scratch;
+}
+
+struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw)
+{
+	return hsw->dsp;
+}
+
+static struct sst_dsp_device hsw_dev = {
+	.thread = hsw_irq_thread,
+	.ops = &haswell_ops,
+};
+
+int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
+{
+	struct sst_hsw_ipc_fw_version version;
+	struct sst_hsw *hsw;
+	struct sst_fw *hsw_sst_fw;
+	int ret;
+
+	dev_dbg(dev, "initialising Audio DSP IPC\n");
+
+	hsw = devm_kzalloc(dev, sizeof(*hsw), GFP_KERNEL);
+	if (hsw == NULL)
+		return -ENOMEM;
+
+	hsw->dev = dev;
+	INIT_LIST_HEAD(&hsw->stream_list);
+	INIT_LIST_HEAD(&hsw->tx_list);
+	INIT_LIST_HEAD(&hsw->rx_list);
+	INIT_LIST_HEAD(&hsw->empty_list);
+	init_waitqueue_head(&hsw->boot_wait);
+	init_waitqueue_head(&hsw->wait_txq);
+
+	ret = msg_empty_list_init(hsw);
+	if (ret < 0)
+		goto list_err;
+
+	/* start the IPC message thread */
+	init_kthread_worker(&hsw->kworker);
+	hsw->tx_thread = kthread_run(kthread_worker_fn,
+					   &hsw->kworker,
+					   dev_name(hsw->dev));
+	if (IS_ERR(hsw->tx_thread)) {
+		ret = PTR_ERR(hsw->tx_thread);
+		dev_err(hsw->dev, "error: failed to create message TX task\n");
+		goto list_err;
+	}
+	init_kthread_work(&hsw->kwork, ipc_tx_msgs);
+
+	hsw_dev.thread_context = hsw;
+
+	/* init SST shim */
+	hsw->dsp = sst_dsp_new(dev, &hsw_dev, pdata);
+	if (hsw->dsp == NULL) {
+		ret = -ENODEV;
+		goto list_err;
+	}
+
+	/* keep the DSP in reset state for base FW loading */
+	sst_dsp_reset(hsw->dsp);
+
+	hsw_sst_fw = sst_fw_new(hsw->dsp, pdata->fw, hsw);
+
+	if (hsw_sst_fw == NULL) {
+		ret = -ENODEV;
+		dev_err(dev, "error: failed to load firmware\n");
+		goto fw_err;
+	}
+
+	/* wait for DSP boot completion */
+	sst_dsp_boot(hsw->dsp);
+	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
+		msecs_to_jiffies(IPC_BOOT_MSECS));
+	if (ret == 0) {
+		ret = -EIO;
+		dev_err(hsw->dev, "error: ADSP boot timeout\n");
+		goto boot_err;
+	}
+
+	/* get the FW version */
+	sst_hsw_fw_get_version(hsw, &version);
+	dev_info(hsw->dev, "FW loaded: type %d - version: %d.%d build %d\n",
+		version.type, version.major, version.minor, version.build);
+
+	/* get the globalmixer */
+	ret = sst_hsw_mixer_get_info(hsw);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: failed to get stream info\n");
+		goto boot_err;
+	}
+
+	pdata->dsp = hsw;
+	return 0;
+
+boot_err:
+	sst_dsp_reset(hsw->dsp);
+	sst_fw_free(hsw_sst_fw);
+fw_err:
+	sst_dsp_free(hsw->dsp);
+	kfree(hsw->msg);
+list_err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
+
+void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata)
+{
+	struct sst_hsw *hsw = pdata->dsp;
+
+	sst_dsp_reset(hsw->dsp);
+	sst_fw_free_all(hsw->dsp);
+	sst_dsp_free(hsw->dsp);
+	kfree(hsw->scratch);
+	kfree(hsw->msg);
+}
+EXPORT_SYMBOL_GPL(sst_hsw_dsp_free);
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
new file mode 100644
index 0000000..d517929
--- /dev/null
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -0,0 +1,488 @@
+/*
+ * Intel SST Haswell/Broadwell IPC Support
+ *
+ * Copyright (C) 2013, Intel Corporation. All rights reserved.
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
+#ifndef __SST_HASWELL_IPC_H
+#define __SST_HASWELL_IPC_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#define SST_HSW_NO_CHANNELS		2
+#define SST_HSW_MAX_DX_REGIONS		14
+
+#define SST_HSW_FW_LOG_CONFIG_DWORDS	12
+#define SST_HSW_GLOBAL_LOG		15
+
+/**
+ * Upfront defined maximum message size that is
+ * expected by the in/out communication pipes in FW.
+ */
+#define SST_HSW_IPC_MAX_PAYLOAD_SIZE	400
+#define SST_HSW_MAX_INFO_SIZE		64
+#define SST_HSW_BUILD_HASH_LENGTH	40
+
+struct sst_hsw;
+struct sst_hsw_stream;
+struct sst_hsw_log_stream;
+struct sst_pdata;
+struct sst_module;
+extern struct sst_ops haswell_ops;
+
+/* Stream Allocate Path ID */
+enum sst_hsw_stream_path_id {
+	SST_HSW_STREAM_PATH_SSP0_OUT = 0,
+	SST_HSW_STREAM_PATH_SSP0_IN = 1,
+	SST_HSW_STREAM_PATH_MAX_PATH_ID = 2,
+};
+
+/* Stream Allocate Stream Type */
+enum sst_hsw_stream_type {
+	SST_HSW_STREAM_TYPE_RENDER = 0,
+	SST_HSW_STREAM_TYPE_SYSTEM = 1,
+	SST_HSW_STREAM_TYPE_CAPTURE = 2,
+	SST_HSW_STREAM_TYPE_LOOPBACK = 3,
+	SST_HSW_STREAM_TYPE_MAX_STREAM_TYPE = 4,
+};
+
+/* Stream Allocate Stream Format */
+enum sst_hsw_stream_format {
+	SST_HSW_STREAM_FORMAT_PCM_FORMAT = 0,
+	SST_HSW_STREAM_FORMAT_MP3_FORMAT = 1,
+	SST_HSW_STREAM_FORMAT_AAC_FORMAT = 2,
+	SST_HSW_STREAM_FORMAT_MAX_FORMAT_ID = 3,
+};
+
+/* Device ID */
+enum sst_hsw_device_id {
+	SST_HSW_DEVICE_SSP_0   = 0,
+	SST_HSW_DEVICE_SSP_1   = 1,
+};
+
+/* Device Master Clock Frequency */
+enum sst_hsw_device_mclk {
+	SST_HSW_DEVICE_MCLK_OFF         = 0,
+	SST_HSW_DEVICE_MCLK_FREQ_6_MHZ  = 1,
+	SST_HSW_DEVICE_MCLK_FREQ_12_MHZ = 2,
+	SST_HSW_DEVICE_MCLK_FREQ_24_MHZ = 3,
+};
+
+/* Device Clock Master */
+enum sst_hsw_device_mode {
+	SST_HSW_DEVICE_CLOCK_SLAVE   = 0,
+	SST_HSW_DEVICE_CLOCK_MASTER  = 1,
+};
+
+/* DX Power State */
+enum sst_hsw_dx_state {
+	SST_HSW_DX_STATE_D0     = 0,
+	SST_HSW_DX_STATE_D1     = 1,
+	SST_HSW_DX_STATE_D3     = 3,
+	SST_HSW_DX_STATE_MAX	= 3,
+};
+
+/* Audio stream stage IDs */
+enum sst_hsw_fx_stage_id {
+	SST_HSW_STAGE_ID_WAVES = 0,
+	SST_HSW_STAGE_ID_DTS   = 1,
+	SST_HSW_STAGE_ID_DOLBY = 2,
+	SST_HSW_STAGE_ID_BOOST = 3,
+	SST_HSW_STAGE_ID_MAX_FX_ID
+};
+
+/* DX State Type */
+enum sst_hsw_dx_type {
+	SST_HSW_DX_TYPE_FW_IMAGE = 0,
+	SST_HSW_DX_TYPE_MEMORY_DUMP = 1
+};
+
+/* Volume Curve Type*/
+enum sst_hsw_volume_curve {
+	SST_HSW_VOLUME_CURVE_NONE = 0,
+	SST_HSW_VOLUME_CURVE_FADE = 1
+};
+
+/* Sample ordering */
+enum sst_hsw_interleaving {
+	SST_HSW_INTERLEAVING_PER_CHANNEL = 0,
+	SST_HSW_INTERLEAVING_PER_SAMPLE  = 1,
+};
+
+/* Channel indices */
+enum sst_hsw_channel_index {
+	SST_HSW_CHANNEL_LEFT            = 0,
+	SST_HSW_CHANNEL_CENTER          = 1,
+	SST_HSW_CHANNEL_RIGHT           = 2,
+	SST_HSW_CHANNEL_LEFT_SURROUND   = 3,
+	SST_HSW_CHANNEL_CENTER_SURROUND = 3,
+	SST_HSW_CHANNEL_RIGHT_SURROUND  = 4,
+	SST_HSW_CHANNEL_LFE             = 7,
+	SST_HSW_CHANNEL_INVALID         = 0xF,
+};
+
+/* List of supported channel maps. */
+enum sst_hsw_channel_config {
+	SST_HSW_CHANNEL_CONFIG_MONO      = 0, /* mono only. */
+	SST_HSW_CHANNEL_CONFIG_STEREO    = 1, /* L & R. */
+	SST_HSW_CHANNEL_CONFIG_2_POINT_1 = 2, /* L, R & LFE; PCM only. */
+	SST_HSW_CHANNEL_CONFIG_3_POINT_0 = 3, /* L, C & R; MP3 & AAC only. */
+	SST_HSW_CHANNEL_CONFIG_3_POINT_1 = 4, /* L, C, R & LFE; PCM only. */
+	SST_HSW_CHANNEL_CONFIG_QUATRO    = 5, /* L, R, Ls & Rs; PCM only. */
+	SST_HSW_CHANNEL_CONFIG_4_POINT_0 = 6, /* L, C, R & Cs; MP3 & AAC only. */
+	SST_HSW_CHANNEL_CONFIG_5_POINT_0 = 7, /* L, C, R, Ls & Rs. */
+	SST_HSW_CHANNEL_CONFIG_5_POINT_1 = 8, /* L, C, R, Ls, Rs & LFE. */
+	SST_HSW_CHANNEL_CONFIG_DUAL_MONO = 9, /* One channel replicated in two. */
+	SST_HSW_CHANNEL_CONFIG_INVALID,
+};
+
+/* List of supported bit depths. */
+enum sst_hsw_bitdepth {
+	SST_HSW_DEPTH_8BIT  = 8,
+	SST_HSW_DEPTH_16BIT = 16,
+	SST_HSW_DEPTH_24BIT = 24, /* Default. */
+	SST_HSW_DEPTH_32BIT = 32,
+	SST_HSW_DEPTH_INVALID = 33,
+};
+
+enum sst_hsw_module_id {
+	SST_HSW_MODULE_BASE_FW = 0x0,
+	SST_HSW_MODULE_MP3     = 0x1,
+	SST_HSW_MODULE_AAC_5_1 = 0x2,
+	SST_HSW_MODULE_AAC_2_0 = 0x3,
+	SST_HSW_MODULE_SRC     = 0x4,
+	SST_HSW_MODULE_WAVES   = 0x5,
+	SST_HSW_MODULE_DOLBY   = 0x6,
+	SST_HSW_MODULE_BOOST   = 0x7,
+	SST_HSW_MODULE_LPAL    = 0x8,
+	SST_HSW_MODULE_DTS     = 0x9,
+	SST_HSW_MODULE_PCM_CAPTURE = 0xA,
+	SST_HSW_MODULE_PCM_SYSTEM = 0xB,
+	SST_HSW_MODULE_PCM_REFERENCE = 0xC,
+	SST_HSW_MODULE_PCM = 0xD,
+	SST_HSW_MODULE_BLUETOOTH_RENDER_MODULE = 0xE,
+	SST_HSW_MODULE_BLUETOOTH_CAPTURE_MODULE = 0xF,
+	SST_HSW_MAX_MODULE_ID,
+};
+
+enum sst_hsw_performance_action {
+	SST_HSW_PERF_START = 0,
+	SST_HSW_PERF_STOP = 1,
+};
+
+/* SST firmware module info */
+struct sst_hsw_module_info {
+	u8 name[SST_HSW_MAX_INFO_SIZE];
+	u8 version[SST_HSW_MAX_INFO_SIZE];
+} __attribute__((packed));
+
+/* Module entry point */
+struct sst_hsw_module_entry {
+	enum sst_hsw_module_id module_id;
+	u32 entry_point;
+} __attribute__((packed));
+
+/* Module map - alignement matches DSP */
+struct sst_hsw_module_map {
+	u8 module_entries_count;
+	struct sst_hsw_module_entry module_entries[1];
+} __attribute__((packed));
+
+struct sst_hsw_memory_info {
+	u32 offset;
+	u32 size;
+} __attribute__((packed));
+
+struct sst_hsw_fx_enable {
+	struct sst_hsw_module_map module_map;
+	struct sst_hsw_memory_info persistent_mem;
+} __attribute__((packed));
+
+struct sst_hsw_get_fx_param {
+	u32 parameter_id;
+	u32 param_size;
+} __attribute__((packed));
+
+struct sst_hsw_perf_action {
+	u32 action;
+} __attribute__((packed));
+
+struct sst_hsw_perf_data {
+	u64 timestamp;
+	u64 cycles;
+	u64 datatime;
+} __attribute__((packed));
+
+/* FW version */
+struct sst_hsw_ipc_fw_version {
+	u8 build;
+	u8 minor;
+	u8 major;
+	u8 type;
+	u8 fw_build_hash[SST_HSW_BUILD_HASH_LENGTH];
+	u32 fw_log_providers_hash;
+} __attribute__((packed));
+
+/* Stream ring info */
+struct sst_hsw_ipc_stream_ring {
+	u32 ring_pt_address;
+	u32 num_pages;
+	u32 ring_size;
+	u32 ring_offset;
+	u32 ring_first_pfn;
+} __attribute__((packed));
+
+/* Debug Dump Log Enable Request */
+struct sst_hsw_ipc_debug_log_enable_req {
+	struct sst_hsw_ipc_stream_ring ringinfo;
+	u32 config[SST_HSW_FW_LOG_CONFIG_DWORDS];
+} __attribute__((packed));
+
+/* Debug Dump Log Reply */
+struct sst_hsw_ipc_debug_log_reply {
+	u32 log_buffer_begining;
+	u32 log_buffer_size;
+} __attribute__((packed));
+
+/* Stream glitch position */
+struct sst_hsw_ipc_stream_glitch_position {
+	u32 glitch_type;
+	u32 present_pos;
+	u32 write_pos;
+} __attribute__((packed));
+
+/* Stream get position */
+struct sst_hsw_ipc_stream_get_position {
+	u32 position;
+	u32 fw_cycle_count;
+} __attribute__((packed));
+
+/* Stream set position */
+struct sst_hsw_ipc_stream_set_position {
+	u32 position;
+	u32 end_of_buffer;
+} __attribute__((packed));
+
+/* Stream Free Request */
+struct sst_hsw_ipc_stream_free_req {
+	u8 stream_id;
+	u8 reserved[3];
+} __attribute__((packed));
+
+/* Set Volume Request */
+struct sst_hsw_ipc_volume_req {
+	u32 channel;
+	u32 target_volume;
+	u64 curve_duration;
+	u32 curve_type;
+} __attribute__((packed));
+
+/* Device Configuration Request */
+struct sst_hsw_ipc_device_config_req {
+	u32 ssp_interface;
+	u32 clock_frequency;
+	u32 mode;
+	u16 clock_divider;
+	u16 reserved;
+} __attribute__((packed));
+
+/* Audio Data formats */
+struct sst_hsw_audio_data_format_ipc {
+	u32 frequency;
+	u32 bitdepth;
+	u32 map;
+	u32 config;
+	u32 style;
+	u8 ch_num;
+	u8 valid_bit;
+	u8 reserved[2];
+} __attribute__((packed));
+
+/* Stream Allocate Request */
+struct sst_hsw_ipc_stream_alloc_req {
+	u8 path_id;
+	u8 stream_type;
+	u8 format_id;
+	u8 reserved;
+	struct sst_hsw_audio_data_format_ipc format;
+	struct sst_hsw_ipc_stream_ring ringinfo;
+	struct sst_hsw_module_map map;
+	struct sst_hsw_memory_info persistent_mem;
+	struct sst_hsw_memory_info scratch_mem;
+	u32 number_of_notifications;
+} __attribute__((packed));
+
+/* Stream Allocate Reply */
+struct sst_hsw_ipc_stream_alloc_reply {
+	u32 stream_hw_id;
+	u32 mixer_hw_id; // returns rate ????
+	u32 read_position_register_address;
+	u32 presentation_position_register_address;
+	u32 peak_meter_register_address[SST_HSW_NO_CHANNELS];
+	u32 volume_register_address[SST_HSW_NO_CHANNELS];
+} __attribute__((packed));
+
+/* Get Mixer Stream Info */
+struct sst_hsw_ipc_stream_info_reply {
+	u32 mixer_hw_id;
+	u32 peak_meter_register_address[SST_HSW_NO_CHANNELS];
+	u32 volume_register_address[SST_HSW_NO_CHANNELS];
+} __attribute__((packed));
+
+/* DX State Request */
+struct sst_hsw_ipc_dx_req {
+	u8 state;
+	u8 reserved[3];
+} __attribute__((packed));
+
+/* DX State Reply Memory Info Item */
+struct sst_hsw_ipc_dx_memory_item {
+	u32 offset;
+	u32 size;
+	u32 source;
+} __attribute__((packed));
+
+/* DX State Reply */
+struct sst_hsw_ipc_dx_reply {
+	u32 entries_no;
+	struct sst_hsw_ipc_dx_memory_item mem_info[SST_HSW_MAX_DX_REGIONS];
+} __attribute__((packed));
+
+struct sst_hsw_ipc_fw_version;
+
+/* SST Init & Free */
+struct sst_hsw *sst_hsw_new(struct device *dev, const u8 *fw, size_t fw_length,
+	u32 fw_offset);
+void sst_hsw_free(struct sst_hsw *hsw);
+int sst_hsw_fw_get_version(struct sst_hsw *hsw,
+	struct sst_hsw_ipc_fw_version *version);
+u32 create_channel_map(enum sst_hsw_channel_config config);
+
+/* Stream Mixer Controls - */
+int sst_hsw_stream_mute(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 stage_id, u32 channel);
+int sst_hsw_stream_unmute(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 stage_id, u32 channel);
+
+int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 stage_id, u32 channel, u32 volume);
+int sst_hsw_stream_get_volume(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 stage_id, u32 channel, u32 *volume);
+
+int sst_hsw_stream_set_volume_curve(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u64 curve_duration,
+	enum sst_hsw_volume_curve curve);
+
+/* Global Mixer Controls - */
+int sst_hsw_mixer_mute(struct sst_hsw *hsw, u32 stage_id, u32 channel);
+int sst_hsw_mixer_unmute(struct sst_hsw *hsw, u32 stage_id, u32 channel);
+
+int sst_hsw_mixer_set_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
+	u32 volume);
+int sst_hsw_mixer_get_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
+	u32 *volume);
+
+int sst_hsw_mixer_set_volume_curve(struct sst_hsw *hsw,
+	u64 curve_duration, enum sst_hsw_volume_curve curve);
+
+/* Stream API */
+struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
+	u32 (*get_write_position)(struct sst_hsw_stream *stream, void *data),
+	void *data);
+
+int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream);
+
+/* Stream Configuration */
+int sst_hsw_stream_format(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	enum sst_hsw_stream_path_id path_id,
+	enum sst_hsw_stream_type stream_type,
+	enum sst_hsw_stream_format format_id);
+
+int sst_hsw_stream_buffer(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 ring_pt_address, u32 num_pages,
+	u32 ring_size, u32 ring_offset, u32 ring_first_pfn);
+
+int sst_hsw_stream_commit(struct sst_hsw *hsw, struct sst_hsw_stream *stream);
+
+int sst_hsw_stream_set_valid(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	u32 bits);
+int sst_hsw_stream_set_rate(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	int rate);
+int sst_hsw_stream_set_bits(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	enum sst_hsw_bitdepth bits);
+int sst_hsw_stream_set_channels(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, int channels);
+int sst_hsw_stream_set_map_config(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 map,
+	enum sst_hsw_channel_config config);
+int sst_hsw_stream_set_style(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	enum sst_hsw_interleaving style);
+int sst_hsw_stream_set_module_info(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, enum sst_hsw_module_id module_id,
+	u32 entry_point);
+int sst_hsw_stream_set_pmemory_info(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 offset, u32 size);
+int sst_hsw_stream_set_smemory_info(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 offset, u32 size);
+int sst_hsw_stream_get_hw_id(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+int sst_hsw_stream_get_mixer_id(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+u32 sst_hsw_stream_get_read_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+u32 sst_hsw_stream_get_pointer_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+u32 sst_hsw_stream_get_peak_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 channel);
+u32 sst_hsw_stream_get_vol_reg(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 channel);
+int sst_hsw_mixer_get_info(struct sst_hsw *hsw);
+
+/* Stream ALSA trigger operations */
+int sst_hsw_stream_pause(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	int wait);
+int sst_hsw_stream_resume(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
+	int wait);
+int sst_hsw_stream_reset(struct sst_hsw *hsw, struct sst_hsw_stream *stream);
+
+/* Stream pointer positions */
+int sst_hsw_stream_get_read_pos(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 *position);
+int sst_hsw_stream_get_write_pos(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 *position);
+int sst_hsw_stream_set_write_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, u32 stage_id, u32 position);
+int sst_hsw_get_dsp_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+
+/* HW port config */
+int sst_hsw_device_set_config(struct sst_hsw *hsw,
+	enum sst_hsw_device_id dev, enum sst_hsw_device_mclk mclk,
+	enum sst_hsw_device_mode mode, u32 clock_divider);
+
+/* DX Config */
+int sst_hsw_dx_set_state(struct sst_hsw *hsw,
+	enum sst_hsw_dx_state state, struct sst_hsw_ipc_dx_reply *dx);
+int sst_hsw_dx_get_state(struct sst_hsw *hsw, u32 item,
+	u32 *offset, u32 *size, u32 *source);
+
+/* init */
+int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata);
+void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata);
+struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
+void sst_hsw_set_scratch_module(struct sst_hsw *hsw,
+	struct sst_module *scratch);
+
+#endif
-- 
1.8.3.2
