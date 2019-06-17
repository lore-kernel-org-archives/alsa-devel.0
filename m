From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: make sure RUN bit
	setting to 0 during clear stream status" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:18 +0100 (BST)
Message-ID: <20190617152418.3E79D440049@finisterre.sirena.org.uk>
References: <20190612172347.22338-16-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFA1AF89693
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:19 +0200 (CEST)
In-Reply-To: <20190612172347.22338-16-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: make sure RUN bit setting to 0 during clear stream status

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

>From 5b8cc7d17f56257056ed65624dec28dcdf14e87e Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:47 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: make sure RUN bit setting to 0 during
 clear stream status

Before clearing stream statuses, ensure RUN bit update has taken
effect by reading the value back.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
