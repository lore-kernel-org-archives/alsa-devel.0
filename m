From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 01/20] ASoC: SOF: Intel: Add BYT,
	CHT and BSW DSP HW support.
Date: Wed, 13 Feb 2019 16:08:28 -0600
Message-ID: <20190213220847.10567-2-pierre-louis.bossart@linux.intel.com>
References: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add support for the audio DSP hardware found on Intel Baytrail,
Cherrytrail and Braswell based devices.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/byt.c  | 893 +++++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/shim.h | 177 ++++++++
 2 files changed, 1070 insertions(+)
 create mode 100644 sound/soc/sof/intel/byt.c
 create mode 100644 sound/soc/sof/intel/shim.h

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
new file mode 100644
index 000000000000..34ad7536bdc8
--- /dev/null
+++ b/sound/soc/sof/intel/byt.c
@@ -0,0 +1,893 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//
+
+/*
+ * Hardware interface for audio DSP on Baytrail, Braswell and Cherrytrail.
+ */
+
+#include <linux/module.h>
+#include <sound/sof.h>
+#include <sound/sof/xtensa.h>
+#include "../ops.h"
+#include "shim.h"
+
+/* DSP memories */
+#define IRAM_OFFSET		0x0C0000
+#define IRAM_SIZE		(80 * 1024)
+#define DRAM_OFFSET		0x100000
+#define DRAM_SIZE		(160 * 1024)
+#define SHIM_OFFSET		0x140000
+#define SHIM_SIZE		0x100
+#define MBOX_OFFSET		0x144000
+#define MBOX_SIZE		0x1000
+#define EXCEPT_OFFSET		0x800
+
+/* DSP peripherals */
+#define DMAC0_OFFSET		0x098000
+#define DMAC1_OFFSET		0x09c000
+#define DMAC2_OFFSET		0x094000
+#define DMAC_SIZE		0x420
+#define SSP0_OFFSET		0x0a0000
+#define SSP1_OFFSET		0x0a1000
+#define SSP2_OFFSET		0x0a2000
+#define SSP3_OFFSET		0x0a4000
+#define SSP4_OFFSET		0x0a5000
+#define SSP5_OFFSET		0x0a6000
+#define SSP_SIZE		0x100
+
+#define BYT_STACK_DUMP_SIZE	32
+
+#define BYT_PCI_BAR_SIZE	0x200000
+
+#define BYT_PANIC_OFFSET(x)	(((x) & GENMASK_ULL(47, 32)) >> 32)
+
+/*
+ * Debug
+ */
+
+#define MBOX_DUMP_SIZE	0x30
+
+/* BARs */
+#define BYT_DSP_BAR		0
+#define BYT_PCI_BAR		1
+#define BYT_IMR_BAR		2
+
+static const struct snd_sof_debugfs_map byt_debugfs[] = {
+	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp0",  BYT_DSP_BAR, SSP0_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp1", BYT_DSP_BAR, SSP1_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp2", BYT_DSP_BAR, SSP2_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"iram", BYT_DSP_BAR, IRAM_OFFSET, IRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+};
+
+static const struct snd_sof_debugfs_map cht_debugfs[] = {
+	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac2", BYT_DSP_BAR,  DMAC2_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp0",  BYT_DSP_BAR, SSP0_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp1", BYT_DSP_BAR, SSP1_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp2", BYT_DSP_BAR, SSP2_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp3", BYT_DSP_BAR, SSP3_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp4", BYT_DSP_BAR, SSP4_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp5", BYT_DSP_BAR, SSP5_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"iram", BYT_DSP_BAR, IRAM_OFFSET, IRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+};
+
+static int byt_cmd_done(struct snd_sof_dev *sdev, int dir);
+
+/*
+ * IPC Firmware ready.
+ */
+static void byt_get_windows(struct snd_sof_dev *sdev)
+{
+	struct sof_ipc_window_elem *elem;
+	u32 outbox_offset = 0;
+	u32 stream_offset = 0;
+	u32 inbox_offset = 0;
+	u32 outbox_size = 0;
+	u32 stream_size = 0;
+	u32 inbox_size = 0;
+	int i;
+
+	if (!sdev->info_window) {
+		dev_err(sdev->dev, "error: have no window info\n");
+		return;
+	}
+
+	for (i = 0; i < sdev->info_window->num_windows; i++) {
+		elem = &sdev->info_window->window[i];
+
+		switch (elem->type) {
+		case SOF_IPC_REGION_UPBOX:
+			inbox_offset = elem->offset + MBOX_OFFSET;
+			inbox_size = elem->size;
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						inbox_offset,
+						elem->size, "inbox",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		case SOF_IPC_REGION_DOWNBOX:
+			outbox_offset = elem->offset + MBOX_OFFSET;
+			outbox_size = elem->size;
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						outbox_offset,
+						elem->size, "outbox",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		case SOF_IPC_REGION_TRACE:
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						elem->offset +
+						MBOX_OFFSET,
+						elem->size, "etrace",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		case SOF_IPC_REGION_DEBUG:
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						elem->offset +
+						MBOX_OFFSET,
+						elem->size, "debug",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		case SOF_IPC_REGION_STREAM:
+			stream_offset = elem->offset + MBOX_OFFSET;
+			stream_size = elem->size;
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						stream_offset,
+						elem->size, "stream",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		case SOF_IPC_REGION_REGS:
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						elem->offset +
+						MBOX_OFFSET,
+						elem->size, "regs",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		case SOF_IPC_REGION_EXCEPTION:
+			sdev->dsp_oops_offset = elem->offset + MBOX_OFFSET;
+			snd_sof_debugfs_io_item(sdev,
+						sdev->bar[BYT_DSP_BAR] +
+						elem->offset +
+						MBOX_OFFSET,
+						elem->size, "exception",
+						SOF_DEBUGFS_ACCESS_D0_ONLY);
+			break;
+		default:
+			dev_err(sdev->dev, "error: get illegal window info\n");
+			return;
+		}
+	}
+
+	if (outbox_size == 0 || inbox_size == 0) {
+		dev_err(sdev->dev, "error: get illegal mailbox window\n");
+		return;
+	}
+
+	snd_sof_dsp_mailbox_init(sdev, inbox_offset, inbox_size,
+				 outbox_offset, outbox_size);
+	sdev->stream_box.offset = stream_offset;
+	sdev->stream_box.size = stream_size;
+
+	dev_dbg(sdev->dev, " mailbox upstream 0x%x - size 0x%x\n",
+		inbox_offset, inbox_size);
+	dev_dbg(sdev->dev, " mailbox downstream 0x%x - size 0x%x\n",
+		outbox_offset, outbox_size);
+	dev_dbg(sdev->dev, " stream region 0x%x - size 0x%x\n",
+		stream_offset, stream_size);
+}
+
+/* check for ABI compatibility and create memory windows on first boot */
+static int byt_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
+{
+	struct sof_ipc_fw_ready *fw_ready = &sdev->fw_ready;
+	u32 offset;
+	int ret;
+
+	/* mailbox must be on 4k boundary */
+	offset = MBOX_OFFSET;
+
+	dev_dbg(sdev->dev, "ipc: DSP is ready 0x%8.8x offset 0x%x\n",
+		msg_id, offset);
+
+	/* no need to re-check version/ABI for subsequent boots */
+	if (!sdev->first_boot)
+		return 0;
+
+	/* copy data from the DSP FW ready offset */
+	sof_block_read(sdev, sdev->mmio_bar, offset, fw_ready,
+		       sizeof(*fw_ready));
+
+	snd_sof_dsp_mailbox_init(sdev, fw_ready->dspbox_offset,
+				 fw_ready->dspbox_size,
+				 fw_ready->hostbox_offset,
+				 fw_ready->hostbox_size);
+
+	/* make sure ABI version is compatible */
+	ret = snd_sof_ipc_valid(sdev);
+	if (ret < 0)
+		return ret;
+
+	/* now check for extended data */
+	snd_sof_fw_parse_ext_data(sdev, sdev->mmio_bar, MBOX_OFFSET +
+				  sizeof(struct sof_ipc_fw_ready));
+
+	byt_get_windows(sdev);
+
+	return 0;
+}
+
+/*
+ * Debug
+ */
+
+static void byt_get_registers(struct snd_sof_dev *sdev,
+			      struct sof_ipc_dsp_oops_xtensa *xoops,
+			      struct sof_ipc_panic_info *panic_info,
+			      u32 *stack, size_t stack_words)
+{
+	/* first read regsisters */
+	sof_mailbox_read(sdev, sdev->dsp_oops_offset, xoops, sizeof(*xoops));
+
+	/* then get panic info */
+	sof_mailbox_read(sdev, sdev->dsp_oops_offset + sizeof(*xoops),
+			 panic_info, sizeof(*panic_info));
+
+	/* then get the stack */
+	sof_mailbox_read(sdev, sdev->dsp_oops_offset + sizeof(*xoops) +
+			   sizeof(*panic_info), stack,
+			   stack_words * sizeof(u32));
+}
+
+static void byt_dump(struct snd_sof_dev *sdev, u32 flags)
+{
+	struct sof_ipc_dsp_oops_xtensa xoops;
+	struct sof_ipc_panic_info panic_info;
+	u32 stack[BYT_STACK_DUMP_SIZE];
+	u32 status, panic;
+
+	/* now try generic SOF status messages */
+	status = snd_sof_dsp_read(sdev, BYT_DSP_BAR, SHIM_IPCD);
+	panic = snd_sof_dsp_read(sdev, BYT_DSP_BAR, SHIM_IPCX);
+	byt_get_registers(sdev, &xoops, &panic_info, stack,
+			  BYT_STACK_DUMP_SIZE);
+	snd_sof_get_status(sdev, status, panic, &xoops, &panic_info, stack,
+			   BYT_STACK_DUMP_SIZE);
+}
+
+/*
+ * IPC Doorbell IRQ handler and thread.
+ */
+
+static irqreturn_t byt_irq_handler(int irq, void *context)
+{
+	struct snd_sof_dev *sdev = (struct snd_sof_dev *)context;
+	u64 isr;
+	int ret = IRQ_NONE;
+
+	/* Interrupt arrived, check src */
+	isr = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_ISRX);
+	if (isr & (SHIM_ISRX_DONE | SHIM_ISRX_BUSY))
+		ret = IRQ_WAKE_THREAD;
+
+	return ret;
+}
+
+static irqreturn_t byt_irq_thread(int irq, void *context)
+{
+	struct snd_sof_dev *sdev = (struct snd_sof_dev *)context;
+	u64 ipcx, ipcd;
+	u64 imrx;
+
+	imrx = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IMRX);
+	ipcx = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IPCX);
+
+	/* reply message from DSP */
+	if (ipcx & SHIM_BYT_IPCX_DONE &&
+	    !(imrx & SHIM_IMRX_DONE)) {
+		/* Mask Done interrupt before first */
+		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR,
+						   SHIM_IMRX,
+						   SHIM_IMRX_DONE,
+						   SHIM_IMRX_DONE);
+		/*
+		 * handle immediate reply from DSP core. If the msg is
+		 * found, set done bit in cmd_done which is called at the
+		 * end of message processing function, else set it here
+		 * because the done bit can't be set in cmd_done function
+		 * which is triggered by msg
+		 */
+		if (snd_sof_ipc_reply(sdev, ipcx))
+			byt_cmd_done(sdev, SOF_IPC_DSP_REPLY);
+	}
+
+	/* new message from DSP */
+	ipcd = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IPCD);
+	if (ipcd & SHIM_BYT_IPCD_BUSY &&
+	    !(imrx & SHIM_IMRX_BUSY)) {
+		/* Mask Busy interrupt before return */
+		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR,
+						   SHIM_IMRX,
+						   SHIM_IMRX_BUSY,
+						   SHIM_IMRX_BUSY);
+
+		/* Handle messages from DSP Core */
+		if ((ipcd & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
+			snd_sof_dsp_panic(sdev, BYT_PANIC_OFFSET(ipcd) +
+					  MBOX_OFFSET);
+		} else {
+			snd_sof_ipc_msgs_rx(sdev);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int byt_is_ipc_ready(struct snd_sof_dev *sdev)
+{
+	u64 ipcx;
+
+	ipcx = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IPCX);
+	if ((ipcx & SHIM_BYT_IPCX_BUSY) || (ipcx & SHIM_BYT_IPCX_DONE))
+		return 0;
+
+	return 1;
+}
+
+static int byt_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
+{
+	u64 cmd = msg->header;
+
+	/* send the message */
+	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
+			  msg->msg_size);
+	snd_sof_dsp_write64(sdev, BYT_DSP_BAR, SHIM_IPCX,
+			    cmd | SHIM_BYT_IPCX_BUSY);
+
+	return 0;
+}
+
+static int byt_get_reply(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
+{
+	struct sof_ipc_reply reply;
+	int ret = 0;
+	u32 size;
+
+	/* get reply */
+	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
+	if (reply.error < 0) {
+		size = sizeof(reply);
+		ret = reply.error;
+	} else {
+		/* reply correct size ? */
+		if (reply.hdr.size != msg->reply_size) {
+			dev_err(sdev->dev, "error: reply expected 0x%zx got 0x%x bytes\n",
+				msg->reply_size, reply.hdr.size);
+			size = msg->reply_size;
+			ret = -EINVAL;
+		} else {
+			size = reply.hdr.size;
+		}
+	}
+
+	/* read the message */
+	if (msg->msg_data && size > 0)
+		sof_mailbox_read(sdev, sdev->host_box.offset, msg->reply_data,
+				 size);
+
+	return ret;
+}
+
+static int byt_cmd_done(struct snd_sof_dev *sdev, int dir)
+{
+	if (dir == SOF_IPC_HOST_REPLY) {
+		/* clear BUSY bit and set DONE bit - accept new messages */
+		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IPCD,
+						   SHIM_BYT_IPCD_BUSY |
+						   SHIM_BYT_IPCD_DONE,
+						   SHIM_BYT_IPCD_DONE);
+
+		/* unmask busy interrupt */
+		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IMRX,
+						   SHIM_IMRX_BUSY, 0);
+	} else {
+		/* clear DONE bit - tell DSP we have completed */
+		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IPCX,
+						   SHIM_BYT_IPCX_DONE, 0);
+
+		/* unmask Done interrupt */
+		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IMRX,
+						   SHIM_IMRX_DONE, 0);
+	}
+
+	return 0;
+}
+
+/*
+ * DSP control.
+ */
+
+static int byt_run(struct snd_sof_dev *sdev)
+{
+	int tries = 10;
+
+	/* release stall and wait to unstall */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_CSR,
+				  SHIM_BYT_CSR_STALL, 0x0);
+	while (tries--) {
+		if (!(snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_CSR) &
+		      SHIM_BYT_CSR_PWAITMODE))
+			break;
+		msleep(100);
+	}
+	if (tries < 0) {
+		dev_err(sdev->dev, "error:  unable to run DSP firmware\n");
+		byt_dump(sdev, SOF_DBG_REGS | SOF_DBG_MBOX);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int byt_reset(struct snd_sof_dev *sdev)
+{
+	/* put DSP into reset, set reset vector and stall */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_CSR,
+				  SHIM_BYT_CSR_RST | SHIM_BYT_CSR_VECTOR_SEL |
+				  SHIM_BYT_CSR_STALL,
+				  SHIM_BYT_CSR_RST | SHIM_BYT_CSR_VECTOR_SEL |
+				  SHIM_BYT_CSR_STALL);
+
+	usleep_range(10, 15);
+
+	/* take DSP out of reset and keep stalled for FW loading */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_CSR,
+				  SHIM_BYT_CSR_RST, 0);
+
+	return 0;
+}
+
+#define BYT_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+/* Baytrail DAIs */
+static struct snd_soc_dai_driver byt_dai[] = {
+{
+	.name = "ssp0-port",
+	.playback = SOF_DAI_STREAM("ssp0 Tx", 1, 8,
+				   SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+	.capture = SOF_DAI_STREAM("ssp0 Rx", 1, 8,
+				  SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+},
+{
+	.name = "ssp1-port",
+	.playback = SOF_DAI_STREAM("ssp1 Tx", 1, 8,
+				   SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+	.capture = SOF_DAI_STREAM("ssp1 Rx", 1, 8,
+				  SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+},
+{
+	.name = "ssp2-port",
+	.playback = SOF_DAI_STREAM("ssp2 Tx", 1, 8,
+				   SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+	.capture = SOF_DAI_STREAM("ssp2 Rx", 1, 8,
+				  SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+},
+{
+	.name = "ssp3-port",
+	.playback = SOF_DAI_STREAM("ssp3 Tx", 1, 8,
+				   SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+	.capture = SOF_DAI_STREAM("ssp3 Rx", 1, 8,
+				  SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+},
+{
+	.name = "ssp4-port",
+	.playback = SOF_DAI_STREAM("ssp4 Tx", 1, 8,
+				   SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+	.capture = SOF_DAI_STREAM("ssp4 Rx", 1, 8,
+				  SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+},
+{
+	.name = "ssp5-port",
+	.playback = SOF_DAI_STREAM("ssp5 Tx", 1, 8,
+				   SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+	.capture = SOF_DAI_STREAM("ssp5 Rx", 1, 8,
+				  SNDRV_PCM_RATE_8000_192000, BYT_FORMATS),
+},
+};
+
+/*
+ * Probe and remove.
+ */
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)
+
+static int byt_pci_probe(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *pdata = sdev->pdata;
+	const struct sof_dev_desc *desc = pdata->desc;
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	u32 base, size;
+	int ret = 0;
+
+	/* DSP DMA can only access low 31 bits of host memory */
+	ret = dma_coerce_mask_and_coherent(&pci->dev, DMA_BIT_MASK(31));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to set DMA mask %d\n", ret);
+		return ret;
+	}
+
+	/* LPE base */
+	base = pci_resource_start(pci, desc->resindex_lpe_base) - IRAM_OFFSET;
+	size = BYT_PCI_BAR_SIZE;
+
+	dev_dbg(sdev->dev, "LPE PHY base at 0x%x size 0x%x", base, size);
+	sdev->bar[BYT_DSP_BAR] = devm_ioremap(sdev->dev, base, size);
+	if (!sdev->bar[BYT_DSP_BAR]) {
+		dev_err(sdev->dev, "error: failed to ioremap LPE base 0x%x size 0x%x\n",
+			base, size);
+		return -ENODEV;
+	}
+	dev_dbg(sdev->dev, "LPE VADDR %p\n", sdev->bar[BYT_DSP_BAR]);
+
+	/* IMR base - optional */
+	if (desc->resindex_imr_base == -1)
+		goto irq;
+
+	base = pci_resource_start(pci, desc->resindex_imr_base);
+	size = pci_resource_len(pci, desc->resindex_imr_base);
+
+	/* some BIOSes don't map IMR */
+	if (base == 0x55aa55aa || base == 0x0) {
+		dev_info(sdev->dev, "IMR not set by BIOS. Ignoring\n");
+		goto irq;
+	}
+
+	dev_dbg(sdev->dev, "IMR base at 0x%x size 0x%x", base, size);
+	sdev->bar[BYT_IMR_BAR] = devm_ioremap(sdev->dev, base, size);
+	if (!sdev->bar[BYT_IMR_BAR]) {
+		dev_err(sdev->dev, "error: failed to ioremap IMR base 0x%x size 0x%x\n",
+			base, size);
+		return -ENODEV;
+	}
+	dev_dbg(sdev->dev, "IMR VADDR %p\n", sdev->bar[BYT_IMR_BAR]);
+
+irq:
+	/* register our IRQ */
+	sdev->ipc_irq = pci->irq;
+	dev_dbg(sdev->dev, "using IRQ %d\n", sdev->ipc_irq);
+	ret = devm_request_threaded_irq(sdev->dev, sdev->ipc_irq,
+					byt_irq_handler, byt_irq_thread,
+					0, "AudioDSP", sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to register IRQ %d\n",
+			sdev->ipc_irq);
+		return ret;
+	}
+
+	/* enable Interrupt from both sides */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x0);
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x0);
+
+	/* set default mailbox offset for FW ready message */
+	sdev->dsp_box.offset = MBOX_OFFSET;
+
+	return ret;
+}
+
+const struct snd_sof_dsp_ops sof_tng_ops = {
+	/* device init */
+	.probe		= byt_pci_probe,
+
+	/* DSP core boot / reset */
+	.run		= byt_run,
+	.reset		= byt_reset,
+
+	/* Register IO */
+	.write		= sof_io_write,
+	.read		= sof_io_read,
+	.write64	= sof_io_write64,
+	.read64		= sof_io_read64,
+
+	/* Block IO */
+	.block_read	= sof_block_read,
+	.block_write	= sof_block_write,
+
+	/* doorbell */
+	.irq_handler	= byt_irq_handler,
+	.irq_thread	= byt_irq_thread,
+
+	/* mailbox */
+	.mailbox_read	= sof_mailbox_read,
+	.mailbox_write	= sof_mailbox_write,
+
+	/* ipc */
+	.send_msg	= byt_send_msg,
+	.get_reply	= byt_get_reply,
+	.fw_ready	= byt_fw_ready,
+	.is_ipc_ready	= byt_is_ipc_ready,
+	.cmd_done	= byt_cmd_done,
+
+	/* debug */
+	.debug_map	= byt_debugfs,
+	.debug_map_count	= ARRAY_SIZE(byt_debugfs),
+	.dbg_dump	= byt_dump,
+
+	/* module loading */
+	.load_module	= snd_sof_parse_module_memcpy,
+
+	/*Firmware loading */
+	.load_firmware	= snd_sof_load_firmware_memcpy,
+
+	/* DAI drivers */
+	.drv = byt_dai,
+	.num_drv = 3, /* we have only 3 SSPs on byt*/
+};
+EXPORT_SYMBOL(sof_tng_ops);
+
+const struct sof_intel_dsp_desc tng_chip_info = {
+	.cores_num = 1,
+	.cores_mask = 1,
+};
+EXPORT_SYMBOL(tng_chip_info);
+
+#endif /* CONFIG_SND_SOC_SOF_EDISON */
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+
+static int byt_acpi_probe(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *pdata = sdev->pdata;
+	const struct sof_dev_desc *desc = pdata->desc;
+	struct platform_device *pdev =
+		container_of(sdev->dev, struct platform_device, dev);
+	struct resource *mmio;
+	u32 base, size;
+	int ret = 0;
+
+	/* DSP DMA can only access low 31 bits of host memory */
+	ret = dma_coerce_mask_and_coherent(sdev->dev, DMA_BIT_MASK(31));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to set DMA mask %d\n", ret);
+		return ret;
+	}
+
+	/* LPE base */
+	mmio = platform_get_resource(pdev, IORESOURCE_MEM,
+				     desc->resindex_lpe_base);
+	if (mmio) {
+		base = mmio->start;
+		size = resource_size(mmio);
+	} else {
+		dev_err(sdev->dev, "error: failed to get LPE base at idx %d\n",
+			desc->resindex_lpe_base);
+		return -EINVAL;
+	}
+
+	dev_dbg(sdev->dev, "LPE PHY base at 0x%x size 0x%x", base, size);
+	sdev->bar[BYT_DSP_BAR] = devm_ioremap(sdev->dev, base, size);
+	if (!sdev->bar[BYT_DSP_BAR]) {
+		dev_err(sdev->dev, "error: failed to ioremap LPE base 0x%x size 0x%x\n",
+			base, size);
+		return -ENODEV;
+	}
+	dev_dbg(sdev->dev, "LPE VADDR %p\n", sdev->bar[BYT_DSP_BAR]);
+
+	/* TODO: add offsets */
+	sdev->mmio_bar = BYT_DSP_BAR;
+	sdev->mailbox_bar = BYT_DSP_BAR;
+
+	/* IMR base - optional */
+	if (desc->resindex_imr_base == -1)
+		goto irq;
+
+	mmio = platform_get_resource(pdev, IORESOURCE_MEM,
+				     desc->resindex_imr_base);
+	if (mmio) {
+		base = mmio->start;
+		size = resource_size(mmio);
+	} else {
+		dev_err(sdev->dev, "error: failed to get IMR base at idx %d\n",
+			desc->resindex_imr_base);
+		return -ENODEV;
+	}
+
+	/* some BIOSes don't map IMR */
+	if (base == 0x55aa55aa || base == 0x0) {
+		dev_info(sdev->dev, "IMR not set by BIOS. Ignoring\n");
+		goto irq;
+	}
+
+	dev_dbg(sdev->dev, "IMR base at 0x%x size 0x%x", base, size);
+	sdev->bar[BYT_IMR_BAR] = devm_ioremap(sdev->dev, base, size);
+	if (!sdev->bar[BYT_IMR_BAR]) {
+		dev_err(sdev->dev, "error: failed to ioremap IMR base 0x%x size 0x%x\n",
+			base, size);
+		return -ENODEV;
+	}
+	dev_dbg(sdev->dev, "IMR VADDR %p\n", sdev->bar[BYT_IMR_BAR]);
+
+irq:
+	/* register our IRQ */
+	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
+	if (sdev->ipc_irq < 0) {
+		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
+			desc->irqindex_host_ipc);
+		return sdev->ipc_irq;
+	}
+
+	dev_dbg(sdev->dev, "using IRQ %d\n", sdev->ipc_irq);
+	ret = devm_request_threaded_irq(sdev->dev, sdev->ipc_irq,
+					byt_irq_handler, byt_irq_thread,
+					IRQF_SHARED, "AudioDSP", sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to register IRQ %d\n",
+			sdev->ipc_irq);
+		return ret;
+	}
+
+	/* enable Interrupt from both sides */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x0);
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x0);
+
+	/* set default mailbox offset for FW ready message */
+	sdev->dsp_box.offset = MBOX_OFFSET;
+
+	return ret;
+}
+
+/* baytrail ops */
+const struct snd_sof_dsp_ops sof_byt_ops = {
+	/* device init */
+	.probe		= byt_acpi_probe,
+
+	/* DSP core boot / reset */
+	.run		= byt_run,
+	.reset		= byt_reset,
+
+	/* Register IO */
+	.write		= sof_io_write,
+	.read		= sof_io_read,
+	.write64	= sof_io_write64,
+	.read64		= sof_io_read64,
+
+	/* Block IO */
+	.block_read	= sof_block_read,
+	.block_write	= sof_block_write,
+
+	/* doorbell */
+	.irq_handler	= byt_irq_handler,
+	.irq_thread	= byt_irq_thread,
+
+	/* mailbox */
+	.mailbox_read	= sof_mailbox_read,
+	.mailbox_write	= sof_mailbox_write,
+
+	/* ipc */
+	.send_msg	= byt_send_msg,
+	.get_reply	= byt_get_reply,
+	.fw_ready	= byt_fw_ready,
+	.is_ipc_ready	= byt_is_ipc_ready,
+	.cmd_done	= byt_cmd_done,
+
+	/* debug */
+	.debug_map	= byt_debugfs,
+	.debug_map_count	= ARRAY_SIZE(byt_debugfs),
+	.dbg_dump	= byt_dump,
+
+	/* module loading */
+	.load_module	= snd_sof_parse_module_memcpy,
+
+	/*Firmware loading */
+	.load_firmware	= snd_sof_load_firmware_memcpy,
+
+	/* DAI drivers */
+	.drv = byt_dai,
+	.num_drv = 3, /* we have only 3 SSPs on byt*/
+};
+EXPORT_SYMBOL(sof_byt_ops);
+
+const struct sof_intel_dsp_desc byt_chip_info = {
+	.cores_num = 1,
+	.cores_mask = 1,
+};
+EXPORT_SYMBOL(byt_chip_info);
+
+/* cherrytrail and braswell ops */
+const struct snd_sof_dsp_ops sof_cht_ops = {
+	/* device init */
+	.probe		= byt_acpi_probe,
+
+	/* DSP core boot / reset */
+	.run		= byt_run,
+	.reset		= byt_reset,
+
+	/* Register IO */
+	.write		= sof_io_write,
+	.read		= sof_io_read,
+	.write64	= sof_io_write64,
+	.read64		= sof_io_read64,
+
+	/* Block IO */
+	.block_read	= sof_block_read,
+	.block_write	= sof_block_write,
+
+	/* doorbell */
+	.irq_handler	= byt_irq_handler,
+	.irq_thread	= byt_irq_thread,
+
+	/* mailbox */
+	.mailbox_read	= sof_mailbox_read,
+	.mailbox_write	= sof_mailbox_write,
+
+	/* ipc */
+	.send_msg	= byt_send_msg,
+	.get_reply	= byt_get_reply,
+	.fw_ready	= byt_fw_ready,
+	.is_ipc_ready	= byt_is_ipc_ready,
+	.cmd_done	= byt_cmd_done,
+
+	/* debug */
+	.debug_map	= cht_debugfs,
+	.debug_map_count	= ARRAY_SIZE(cht_debugfs),
+	.dbg_dump	= byt_dump,
+
+	/* module loading */
+	.load_module	= snd_sof_parse_module_memcpy,
+
+	/*Firmware loading */
+	.load_firmware	= snd_sof_load_firmware_memcpy,
+
+	/* DAI drivers */
+	.drv = byt_dai,
+	/* all 6 SSPs may be available for cherrytrail */
+	.num_drv = ARRAY_SIZE(byt_dai),
+};
+EXPORT_SYMBOL(sof_cht_ops);
+
+const struct sof_intel_dsp_desc cht_chip_info = {
+	.cores_num = 1,
+	.cores_mask = 1,
+};
+EXPORT_SYMBOL(cht_chip_info);
+
+#endif /* CONFIG_SND_SOC_SOF_BAYTRAIL */
+
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
new file mode 100644
index 000000000000..1a92b155af24
--- /dev/null
+++ b/sound/soc/sof/intel/shim.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2017 Intel Corporation. All rights reserved.
+ *
+ * Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+ */
+
+#ifndef __SOF_INTEL_SHIM_H
+#define __SOF_INTEL_SHIM_H
+
+/*
+ * SHIM registers for BYT, BSW, CHT, HSW, BDW
+ */
+
+#define SHIM_CSR		(SHIM_OFFSET + 0x00)
+#define SHIM_PISR		(SHIM_OFFSET + 0x08)
+#define SHIM_PIMR		(SHIM_OFFSET + 0x10)
+#define SHIM_ISRX		(SHIM_OFFSET + 0x18)
+#define SHIM_ISRD		(SHIM_OFFSET + 0x20)
+#define SHIM_IMRX		(SHIM_OFFSET + 0x28)
+#define SHIM_IMRD		(SHIM_OFFSET + 0x30)
+#define SHIM_IPCX		(SHIM_OFFSET + 0x38)
+#define SHIM_IPCD		(SHIM_OFFSET + 0x40)
+#define SHIM_ISRSC		(SHIM_OFFSET + 0x48)
+#define SHIM_ISRLPESC		(SHIM_OFFSET + 0x50)
+#define SHIM_IMRSC		(SHIM_OFFSET + 0x58)
+#define SHIM_IMRLPESC		(SHIM_OFFSET + 0x60)
+#define SHIM_IPCSC		(SHIM_OFFSET + 0x68)
+#define SHIM_IPCLPESC		(SHIM_OFFSET + 0x70)
+#define SHIM_CLKCTL		(SHIM_OFFSET + 0x78)
+#define SHIM_CSR2		(SHIM_OFFSET + 0x80)
+#define SHIM_LTRC		(SHIM_OFFSET + 0xE0)
+#define SHIM_HMDC		(SHIM_OFFSET + 0xE8)
+
+#define SHIM_PWMCTRL		0x1000
+
+/*
+ * SST SHIM register bits for BYT, BSW, CHT HSW, BDW
+ * Register bit naming and functionaility can differ between devices.
+ */
+
+/* CSR / CS */
+#define SHIM_CSR_RST		BIT(1)
+#define SHIM_CSR_SBCS0		BIT(2)
+#define SHIM_CSR_SBCS1		BIT(3)
+#define SHIM_CSR_DCS(x)		((x) << 4)
+#define SHIM_CSR_DCS_MASK	(0x7 << 4)
+#define SHIM_CSR_STALL		BIT(10)
+#define SHIM_CSR_S0IOCS		BIT(21)
+#define SHIM_CSR_S1IOCS		BIT(23)
+#define SHIM_CSR_LPCS		BIT(31)
+#define SHIM_CSR_24MHZ_LPCS \
+	(SHIM_CSR_SBCS0 | SHIM_CSR_SBCS1 | SHIM_CSR_LPCS)
+#define SHIM_CSR_24MHZ_NO_LPCS	(SHIM_CSR_SBCS0 | SHIM_CSR_SBCS1)
+#define SHIM_BYT_CSR_RST	BIT(0)
+#define SHIM_BYT_CSR_VECTOR_SEL	BIT(1)
+#define SHIM_BYT_CSR_STALL	BIT(2)
+#define SHIM_BYT_CSR_PWAITMODE	BIT(3)
+
+/*  ISRX / ISC */
+#define SHIM_ISRX_BUSY		BIT(1)
+#define SHIM_ISRX_DONE		BIT(0)
+#define SHIM_BYT_ISRX_REQUEST	BIT(1)
+
+/*  ISRD / ISD */
+#define SHIM_ISRD_BUSY		BIT(1)
+#define SHIM_ISRD_DONE		BIT(0)
+
+/* IMRX / IMC */
+#define SHIM_IMRX_BUSY		BIT(1)
+#define SHIM_IMRX_DONE		BIT(0)
+#define SHIM_BYT_IMRX_REQUEST	BIT(1)
+
+/* IMRD / IMD */
+#define SHIM_IMRD_DONE		BIT(0)
+#define SHIM_IMRD_BUSY		BIT(1)
+#define SHIM_IMRD_SSP0		BIT(16)
+#define SHIM_IMRD_DMAC0		BIT(21)
+#define SHIM_IMRD_DMAC1		BIT(22)
+#define SHIM_IMRD_DMAC		(SHIM_IMRD_DMAC0 | SHIM_IMRD_DMAC1)
+
+/*  IPCX / IPCC */
+#define	SHIM_IPCX_DONE		BIT(30)
+#define	SHIM_IPCX_BUSY		BIT(31)
+#define SHIM_BYT_IPCX_DONE	BIT_ULL(62)
+#define SHIM_BYT_IPCX_BUSY	BIT_ULL(63)
+
+/*  IPCD */
+#define	SHIM_IPCD_DONE		BIT(30)
+#define	SHIM_IPCD_BUSY		BIT(31)
+#define SHIM_BYT_IPCD_DONE	BIT_ULL(62)
+#define SHIM_BYT_IPCD_BUSY	BIT_ULL(63)
+
+/* CLKCTL */
+#define SHIM_CLKCTL_SMOS(x)	((x) << 24)
+#define SHIM_CLKCTL_MASK	(3 << 24)
+#define SHIM_CLKCTL_DCPLCG	BIT(18)
+#define SHIM_CLKCTL_SCOE1	BIT(17)
+#define SHIM_CLKCTL_SCOE0	BIT(16)
+
+/* CSR2 / CS2 */
+#define SHIM_CSR2_SDFD_SSP0	BIT(1)
+#define SHIM_CSR2_SDFD_SSP1	BIT(2)
+
+/* LTRC */
+#define SHIM_LTRC_VAL(x)	((x) << 0)
+
+/* HMDC */
+#define SHIM_HMDC_HDDA0(x)	((x) << 0)
+#define SHIM_HMDC_HDDA1(x)	((x) << 7)
+#define SHIM_HMDC_HDDA_E0_CH0	1
+#define SHIM_HMDC_HDDA_E0_CH1	2
+#define SHIM_HMDC_HDDA_E0_CH2	4
+#define SHIM_HMDC_HDDA_E0_CH3	8
+#define SHIM_HMDC_HDDA_E1_CH0	SHIM_HMDC_HDDA1(SHIM_HMDC_HDDA_E0_CH0)
+#define SHIM_HMDC_HDDA_E1_CH1	SHIM_HMDC_HDDA1(SHIM_HMDC_HDDA_E0_CH1)
+#define SHIM_HMDC_HDDA_E1_CH2	SHIM_HMDC_HDDA1(SHIM_HMDC_HDDA_E0_CH2)
+#define SHIM_HMDC_HDDA_E1_CH3	SHIM_HMDC_HDDA1(SHIM_HMDC_HDDA_E0_CH3)
+#define SHIM_HMDC_HDDA_E0_ALLCH	\
+	(SHIM_HMDC_HDDA_E0_CH0 | SHIM_HMDC_HDDA_E0_CH1 | \
+	 SHIM_HMDC_HDDA_E0_CH2 | SHIM_HMDC_HDDA_E0_CH3)
+#define SHIM_HMDC_HDDA_E1_ALLCH	\
+	(SHIM_HMDC_HDDA_E1_CH0 | SHIM_HMDC_HDDA_E1_CH1 | \
+	 SHIM_HMDC_HDDA_E1_CH2 | SHIM_HMDC_HDDA_E1_CH3)
+
+/* Audio DSP PCI registers */
+#define PCI_VDRTCTL0		0xa0
+#define PCI_VDRTCTL1		0xa4
+#define PCI_VDRTCTL2		0xa8
+#define PCI_VDRTCTL3		0xaC
+
+/* VDRTCTL0 */
+#define PCI_VDRTCL0_D3PGD		BIT(0)
+#define PCI_VDRTCL0_D3SRAMPGD		BIT(1)
+#define PCI_VDRTCL0_DSRAMPGE_SHIFT	12
+#define PCI_VDRTCL0_DSRAMPGE_MASK	GENMASK(PCI_VDRTCL0_DSRAMPGE_SHIFT + 19,\
+						PCI_VDRTCL0_DSRAMPGE_SHIFT)
+#define PCI_VDRTCL0_ISRAMPGE_SHIFT	2
+#define PCI_VDRTCL0_ISRAMPGE_MASK	GENMASK(PCI_VDRTCL0_ISRAMPGE_SHIFT + 9,\
+						PCI_VDRTCL0_ISRAMPGE_SHIFT)
+
+/* VDRTCTL2 */
+#define PCI_VDRTCL2_DCLCGE		BIT(1)
+#define PCI_VDRTCL2_DTCGE		BIT(10)
+#define PCI_VDRTCL2_APLLSE_MASK		BIT(31)
+
+/* PMCS */
+#define PCI_PMCS		0x84
+#define PCI_PMCS_PS_MASK	0x3
+
+/* DSP hardware descriptor */
+struct sof_intel_dsp_desc {
+	int cores_num;
+	int cores_mask;
+	int ipc_req;
+	int ipc_req_mask;
+	int ipc_ack;
+	int ipc_ack_mask;
+	int ipc_ctl;
+};
+
+extern const struct snd_sof_dsp_ops sof_tng_ops;
+extern const struct snd_sof_dsp_ops sof_byt_ops;
+extern const struct snd_sof_dsp_ops sof_cht_ops;
+extern const struct snd_sof_dsp_ops sof_hsw_ops;
+extern const struct snd_sof_dsp_ops sof_bdw_ops;
+
+extern const struct sof_intel_dsp_desc byt_chip_info;
+extern const struct sof_intel_dsp_desc cht_chip_info;
+extern const struct sof_intel_dsp_desc bdw_chip_info;
+extern const struct sof_intel_dsp_desc hsw_chip_info;
+extern const struct sof_intel_dsp_desc tng_chip_info;
+
+#endif
-- 
2.17.1
