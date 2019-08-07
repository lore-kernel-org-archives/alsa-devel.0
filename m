From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/6] ASoC: SOF: Intel: hda: Use generic
	function for fw ready / mem windows creation
Date: Wed,  7 Aug 2019 10:02:03 -0500
Message-ID: <20190807150203.26359-7-pierre-louis.bossart@linux.intel.com>
References: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F341F8059F
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 17:02:32 +0200 (CEST)
In-Reply-To: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We can use generic sof_fw_ready function and reduce code duplication.
Careful here that we need to provide the implementation for
get_mailbox_offset and get_window_offset.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/apl.c     |   4 +-
 sound/soc/sof/intel/cnl.c     |   4 +-
 sound/soc/sof/intel/hda-ipc.c | 150 +---------------------------------
 sound/soc/sof/intel/hda.h     |   4 +-
 4 files changed, 13 insertions(+), 149 deletions(-)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index fd2e26d79796..8dc7a5558da4 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -46,7 +46,9 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 
 	/* ipc */
 	.send_msg	= hda_dsp_ipc_send_msg,
-	.fw_ready	= hda_dsp_ipc_fw_ready,
+	.fw_ready	= sof_fw_ready,
+	.get_mailbox_offset = hda_dsp_ipc_get_mailbox_offset,
+	.get_window_offset = hda_dsp_ipc_get_window_offset,
 
 	.ipc_msg_data	= hda_ipc_msg_data,
 	.ipc_pcm_params	= hda_ipc_pcm_params,
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index ffd8d4394537..6d7d9c93252c 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -204,7 +204,9 @@ const struct snd_sof_dsp_ops sof_cnl_ops = {
 
 	/* ipc */
 	.send_msg	= cnl_ipc_send_msg,
-	.fw_ready	= hda_dsp_ipc_fw_ready,
+	.fw_ready	= sof_fw_ready,
+	.get_mailbox_offset = hda_dsp_ipc_get_mailbox_offset,
+	.get_window_offset = hda_dsp_ipc_get_window_offset,
 
 	.ipc_msg_data	= hda_ipc_msg_data,
 	.ipc_pcm_params	= hda_ipc_pcm_params,
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 2ecba91f5219..6aae6f18b3dc 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -266,156 +266,14 @@ irqreturn_t hda_dsp_ipc_irq_handler(int irq, void *context)
 	return ret;
 }
 
-/* IPC Firmware ready */
-
-static void ipc_get_windows(struct snd_sof_dev *sdev)
+int hda_dsp_ipc_get_mailbox_offset(struct snd_sof_dev *sdev)
 {
-	struct sof_ipc_window_elem *elem;
-	u32 outbox_offset = 0;
-	u32 stream_offset = 0;
-	u32 inbox_offset = 0;
-	u32 outbox_size = 0;
-	u32 stream_size = 0;
-	u32 inbox_size = 0;
-	int i;
-
-	if (!sdev->info_window) {
-		dev_err(sdev->dev, "error: have no window info\n");
-		return;
-	}
-
-	for (i = 0; i < sdev->info_window->num_windows; i++) {
-		elem = &sdev->info_window->window[i];
-
-		switch (elem->type) {
-		case SOF_IPC_REGION_UPBOX:
-			inbox_offset =
-				elem->offset + SRAM_WINDOW_OFFSET(elem->id);
-			inbox_size = elem->size;
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						inbox_offset,
-						elem->size, "inbox",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		case SOF_IPC_REGION_DOWNBOX:
-			outbox_offset =
-				elem->offset + SRAM_WINDOW_OFFSET(elem->id);
-			outbox_size = elem->size;
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						outbox_offset,
-						elem->size, "outbox",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		case SOF_IPC_REGION_TRACE:
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						elem->offset +
-						SRAM_WINDOW_OFFSET
-						(elem->id),
-						elem->size, "etrace",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		case SOF_IPC_REGION_DEBUG:
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						elem->offset +
-						SRAM_WINDOW_OFFSET
-						(elem->id),
-						elem->size, "debug",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		case SOF_IPC_REGION_STREAM:
-			stream_offset =
-				elem->offset + SRAM_WINDOW_OFFSET(elem->id);
-			stream_size = elem->size;
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						elem->offset +
-						SRAM_WINDOW_OFFSET
-						(elem->id),
-						elem->size, "stream",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		case SOF_IPC_REGION_REGS:
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						elem->offset +
-						SRAM_WINDOW_OFFSET
-						(elem->id),
-						elem->size, "regs",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		case SOF_IPC_REGION_EXCEPTION:
-			sdev->dsp_oops_offset = elem->offset +
-						SRAM_WINDOW_OFFSET(elem->id);
-			snd_sof_debugfs_io_item(sdev,
-						sdev->bar[HDA_DSP_BAR] +
-						elem->offset +
-						SRAM_WINDOW_OFFSET
-						(elem->id),
-						elem->size, "exception",
-						SOF_DEBUGFS_ACCESS_D0_ONLY);
-			break;
-		default:
-			dev_err(sdev->dev, "error: get illegal window info\n");
-			return;
-		}
-	}
-
-	if (outbox_size == 0 || inbox_size == 0) {
-		dev_err(sdev->dev, "error: get illegal mailbox window\n");
-		return;
-	}
-
-	snd_sof_dsp_mailbox_init(sdev, inbox_offset, inbox_size,
-				 outbox_offset, outbox_size);
-	sdev->stream_box.offset = stream_offset;
-	sdev->stream_box.size = stream_size;
-
-	dev_dbg(sdev->dev, " mailbox upstream 0x%x - size 0x%x\n",
-		inbox_offset, inbox_size);
-	dev_dbg(sdev->dev, " mailbox downstream 0x%x - size 0x%x\n",
-		outbox_offset, outbox_size);
-	dev_dbg(sdev->dev, " stream region 0x%x - size 0x%x\n",
-		stream_offset, stream_size);
+	return HDA_DSP_MBOX_UPLINK_OFFSET;
 }
 
-/* check for ABI compatibility and create memory windows on first boot */
-int hda_dsp_ipc_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
+int hda_dsp_ipc_get_window_offset(struct snd_sof_dev *sdev, u32 id)
 {
-	struct sof_ipc_fw_ready *fw_ready = &sdev->fw_ready;
-	u32 offset;
-	int ret;
-
-	/* mailbox must be on 4k boundary */
-	offset = HDA_DSP_MBOX_UPLINK_OFFSET;
-
-	dev_dbg(sdev->dev, "ipc: DSP is ready 0x%8.8x offset 0x%x\n",
-		msg_id, offset);
-
-	/* no need to re-check version/ABI for subsequent boots */
-	if (!sdev->first_boot)
-		return 0;
-
-	/* copy data from the DSP FW ready offset */
-	sof_block_read(sdev, sdev->mmio_bar, offset, fw_ready,
-		       sizeof(*fw_ready));
-
-	/* make sure ABI version is compatible */
-	ret = snd_sof_ipc_valid(sdev);
-	if (ret < 0)
-		return ret;
-
-	/* now check for extended data */
-	snd_sof_fw_parse_ext_data(sdev, sdev->mmio_bar,
-				  HDA_DSP_MBOX_UPLINK_OFFSET +
-				  sizeof(struct sof_ipc_fw_ready));
-
-	ipc_get_windows(sdev);
-
-	return 0;
+	return SRAM_WINDOW_OFFSET(id);
 }
 
 void hda_ipc_msg_data(struct snd_sof_dev *sdev,
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index ceaaa8d467f4..9246ba776d68 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -519,7 +519,9 @@ int hda_ipc_pcm_params(struct snd_sof_dev *sdev,
 int hda_dsp_ipc_send_msg(struct snd_sof_dev *sdev,
 			 struct snd_sof_ipc_msg *msg);
 void hda_dsp_ipc_get_reply(struct snd_sof_dev *sdev);
-int hda_dsp_ipc_fw_ready(struct snd_sof_dev *sdev, u32 msg_id);
+int hda_dsp_ipc_get_mailbox_offset(struct snd_sof_dev *sdev);
+int hda_dsp_ipc_get_window_offset(struct snd_sof_dev *sdev, u32 id);
+
 irqreturn_t hda_dsp_ipc_irq_handler(int irq, void *context);
 irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context);
 int hda_dsp_ipc_cmd_done(struct snd_sof_dev *sdev, int dir);
-- 
2.20.1
