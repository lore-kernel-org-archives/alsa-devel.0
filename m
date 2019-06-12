From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/15] ASoC: SOF: Intel: hda: make sure DMA is
	start/stop by read the RUN bit
Date: Wed, 12 Jun 2019 12:23:46 -0500
Message-ID: <20190612172347.22338-15-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C447F89736
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:24:04 +0200 (CEST)
In-Reply-To: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

As per the HW recommendation, after setting the RUN bit
(start as 1, stop as 0), software must read the bit back
to make sure the bit is set right, before modifying related
control registers/re-starting the DMA engine.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 22 ++++++++++++++++++++++
 sound/soc/sof/intel/hda.h        |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 23cff5aca007..13d114993f96 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -217,6 +217,9 @@ int hda_dsp_stream_trigger(struct snd_sof_dev *sdev,
 {
 	struct hdac_stream *hstream = &stream->hstream;
 	int sd_offset = SOF_STREAM_SD_OFFSET(hstream);
+	u32 dma_start = SOF_HDA_SD_CTL_DMA_START;
+	int ret;
+	u32 run;
 
 	/* cmd must be for audio stream */
 	switch (cmd) {
@@ -234,6 +237,16 @@ int hda_dsp_stream_trigger(struct snd_sof_dev *sdev,
 					SOF_HDA_SD_CTL_DMA_START |
 					SOF_HDA_CL_DMA_SD_INT_MASK);
 
+		ret = snd_sof_dsp_read_poll_timeout(sdev,
+					HDA_DSP_HDA_BAR,
+					sd_offset, run,
+					((run &	dma_start) == dma_start),
+					HDA_DSP_REG_POLL_INTERVAL_US,
+					HDA_DSP_STREAM_RUN_TIMEOUT);
+
+		if (ret)
+			return ret;
+
 		hstream->running = true;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -244,6 +257,15 @@ int hda_dsp_stream_trigger(struct snd_sof_dev *sdev,
 					SOF_HDA_SD_CTL_DMA_START |
 					SOF_HDA_CL_DMA_SD_INT_MASK, 0x0);
 
+		ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_HDA_BAR,
+						sd_offset, run,
+						!(run &	dma_start),
+						HDA_DSP_REG_POLL_INTERVAL_US,
+						HDA_DSP_STREAM_RUN_TIMEOUT);
+
+		if (ret)
+			return ret;
+
 		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, sd_offset +
 				  SOF_HDA_ADSP_REG_CL_SD_STS,
 				  SOF_HDA_CL_DMA_SD_INT_MASK);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 50653859e0a0..73d7cc08afc2 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -159,6 +159,12 @@
 #define HDA_DSP_MBOX_UPLINK_OFFSET		0x81000
 
 #define HDA_DSP_STREAM_RESET_TIMEOUT		300
+/*
+ * Timeout in us, for setting the stream RUN bit, during
+ * start/stop the stream. The timeout expires if new RUN bit
+ * value cannot be read back within the specified time.
+ */
+#define HDA_DSP_STREAM_RUN_TIMEOUT		300
 #define HDA_DSP_CL_TRIGGER_TIMEOUT		300
 
 #define HDA_DSP_SPIB_ENABLE			1
-- 
2.20.1
