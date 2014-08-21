From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 06/11] ASoC: Intel: sst: Add some helper functions
Date: Thu, 21 Aug 2014 18:20:45 +0530
Message-ID: <1408625450-32315-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B15EE2658AB
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:13:00 +0200 (CEST)
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

This patch adds helper functions like wait, creating ipc headers, shim
wrappers.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_pvt.c | 207 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100644 sound/soc/intel/sst/sst_pvt.c

diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/sst/sst_pvt.c
new file mode 100644
index 000000000000..b7a138e82dfe
--- /dev/null
+++ b/sound/soc/intel/sst/sst_pvt.c
@@ -0,0 +1,207 @@
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
+				block->condition, block->msg_id,
+				sst_drv_ctx->sst_state);
+		sst_drv_ctx->sst_state = SST_RESET;
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
+	if (!msg)
+		return -ENOMEM;
+	if (large) {
+		msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_ATOMIC);
+		if (!msg->mailbox_data) {
+			kfree(msg);
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
-- 
1.9.0
