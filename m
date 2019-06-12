From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 15/15] ASoC: SOF: Intel: hda: make sure RUN bit
	setting to 0 during clear stream status
Date: Wed, 12 Jun 2019 12:23:47 -0500
Message-ID: <20190612172347.22338-16-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C5A0F89737
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

Before clearing stream statuses, ensure RUN bit update has taken
effect by reading the value back.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 13d114993f96..ad8d41f22e92 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -295,7 +295,9 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 	struct hdac_stream *hstream = &stream->hstream;
 	int sd_offset = SOF_STREAM_SD_OFFSET(hstream);
 	int ret, timeout = HDA_DSP_STREAM_RESET_TIMEOUT;
+	u32 dma_start = SOF_HDA_SD_CTL_DMA_START;
 	u32 val, mask;
+	u32 run;
 
 	if (!stream) {
 		dev_err(sdev->dev, "error: no stream available\n");
@@ -316,6 +318,16 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, sd_offset,
 				SOF_HDA_CL_DMA_SD_INT_MASK |
 				SOF_HDA_SD_CTL_DMA_START, 0);
+
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_HDA_BAR,
+					    sd_offset, run,
+					    !(run & dma_start),
+					    HDA_DSP_REG_POLL_INTERVAL_US,
+					    HDA_DSP_STREAM_RUN_TIMEOUT);
+
+	if (ret)
+		return ret;
+
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 				sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
 				SOF_HDA_CL_DMA_SD_INT_MASK,
@@ -368,6 +380,16 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, sd_offset,
 				SOF_HDA_CL_DMA_SD_INT_MASK |
 				SOF_HDA_SD_CTL_DMA_START, 0);
+
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_HDA_BAR,
+					    sd_offset, run,
+					    !(run & dma_start),
+					    HDA_DSP_REG_POLL_INTERVAL_US,
+					    HDA_DSP_STREAM_RUN_TIMEOUT);
+
+	if (ret)
+		return ret;
+
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 				sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
 				SOF_HDA_CL_DMA_SD_INT_MASK,
-- 
2.20.1
