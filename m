From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/9] ASoC: SOF: send time stamp to FW for
	alignment
Date: Mon,  3 Jun 2019 11:18:17 -0500
Message-ID: <20190603161821.7486-6-pierre-louis.bossart@linux.intel.com>
References: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C092BF896EE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:18:33 +0200 (CEST)
In-Reply-To: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

Timer will be reset when DSP is powered down. So the time stamp of trace
log will be reset after resume. Send time stamp to FW can align the time
stamp and avoid reset time stamp in trace log.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/header.h   |  1 +
 include/sound/sof/trace.h    | 10 ++++++++++
 include/uapi/sound/sof/abi.h |  2 +-
 sound/soc/sof/trace.c        | 16 +++++++++++++---
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/sound/sof/header.h b/include/sound/sof/header.h
index 1efcf7b18ec2..ab5862d80afe 100644
--- a/include/sound/sof/header.h
+++ b/include/sound/sof/header.h
@@ -102,6 +102,7 @@
 /* trace and debug */
 #define SOF_IPC_TRACE_DMA_PARAMS		SOF_CMD_TYPE(0x001)
 #define SOF_IPC_TRACE_DMA_POSITION		SOF_CMD_TYPE(0x002)
+#define SOF_IPC_TRACE_DMA_PARAMS_EXT		SOF_CMD_TYPE(0x003)
 
 /* Get message component id */
 #define SOF_IPC_MESSAGE_ID(x)			((x) & 0xffff)
diff --git a/include/sound/sof/trace.h b/include/sound/sof/trace.h
index fdb30078448f..9257d5473d97 100644
--- a/include/sound/sof/trace.h
+++ b/include/sound/sof/trace.h
@@ -19,12 +19,22 @@
 #define SOF_TRACE_FILENAME_SIZE		32
 
 /* DMA for Trace params info - SOF_IPC_DEBUG_DMA_PARAMS */
+/* Deprecated - use sof_ipc_dma_trace_params_ext */
 struct sof_ipc_dma_trace_params {
 	struct sof_ipc_cmd_hdr hdr;
 	struct sof_ipc_host_buffer buffer;
 	uint32_t stream_tag;
 }  __packed;
 
+/* DMA for Trace params info - SOF_IPC_DEBUG_DMA_PARAMS_EXT */
+struct sof_ipc_dma_trace_params_ext {
+	struct sof_ipc_cmd_hdr hdr;
+	struct sof_ipc_host_buffer buffer;
+	uint32_t stream_tag;
+	uint64_t timestamp_ns; /* in nanosecond */
+	uint32_t reserved[8];
+}  __packed;
+
 /* DMA for Trace params info - SOF_IPC_DEBUG_DMA_PARAMS */
 struct sof_ipc_dma_trace_posn {
 	struct sof_ipc_reply rhdr;
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 0868eb47acf7..92eee681bc62 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 6
+#define SOF_ABI_MINOR 7
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index 2613dd3e0dfc..84d89206a0e0 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -161,7 +161,9 @@ static int trace_debugfs_create(struct snd_sof_dev *sdev)
 
 int snd_sof_init_trace_ipc(struct snd_sof_dev *sdev)
 {
-	struct sof_ipc_dma_trace_params params;
+	struct sof_ipc_fw_ready *ready = &sdev->fw_ready;
+	struct sof_ipc_fw_version *v = &ready->version;
+	struct sof_ipc_dma_trace_params_ext params;
 	struct sof_ipc_reply ipc_reply;
 	int ret;
 
@@ -172,8 +174,16 @@ int snd_sof_init_trace_ipc(struct snd_sof_dev *sdev)
 		return -EINVAL;
 
 	/* set IPC parameters */
-	params.hdr.size = sizeof(params);
-	params.hdr.cmd = SOF_IPC_GLB_TRACE_MSG | SOF_IPC_TRACE_DMA_PARAMS;
+	params.hdr.cmd = SOF_IPC_GLB_TRACE_MSG;
+	/* PARAMS_EXT is only supported from ABI 3.7.0 onwards */
+	if (v->abi_version >= SOF_ABI_VER(3, 7, 0)) {
+		params.hdr.size = sizeof(struct sof_ipc_dma_trace_params_ext);
+		params.hdr.cmd |= SOF_IPC_TRACE_DMA_PARAMS_EXT;
+		params.timestamp_ns = ktime_get(); /* in nanosecond */
+	} else {
+		params.hdr.size = sizeof(struct sof_ipc_dma_trace_params);
+		params.hdr.cmd |= SOF_IPC_TRACE_DMA_PARAMS;
+	}
 	params.buffer.phy_addr = sdev->dmatp.addr;
 	params.buffer.size = sdev->dmatb.bytes;
 	params.buffer.pages = sdev->dma_trace_pages;
-- 
2.20.1
