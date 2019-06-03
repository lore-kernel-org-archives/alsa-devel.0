From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: send time stamp to FW for
	alignment" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:53 +0100 (BST)
Message-ID: <20190603180154.04DC9440046@finisterre.sirena.org.uk>
References: <20190603161821.7486-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B845EF80774
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:01:55 +0200 (CEST)
In-Reply-To: <20190603161821.7486-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: send time stamp to FW for alignment

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e3adc9495ab26fc4bfe29253d4e7aad47dab2307 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Mon, 3 Jun 2019 11:18:17 -0500
Subject: [PATCH] ASoC: SOF: send time stamp to FW for alignment

Timer will be reset when DSP is powered down. So the time stamp of trace
log will be reset after resume. Send time stamp to FW can align the time
stamp and avoid reset time stamp in trace log.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 7d211f319a92..2187ff7d07ce 100644
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
index b02520f8e595..befed975161c 100644
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
 
@@ -169,8 +171,16 @@ int snd_sof_init_trace_ipc(struct snd_sof_dev *sdev)
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
