From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: release link DMA for
	paused streams during suspend" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:24 +0100 (BST)
Message-ID: <20190617152424.5C143440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54D92F89717
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:25 +0200 (CEST)
In-Reply-To: <20190612172347.22338-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: release link DMA for paused streams during suspend

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

>From 7077a07a72d38a78040873bbc13a77d1e45f8aa0 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:38 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: release link DMA for paused streams
 during suspend

Paused streams do not get suspended when the system enters S3.
So, clear and release link DMA channel for such streams in the
hda_dsp_set_hw_params_upon_resume() callback. Also, invalidate
the link DMA channel in the DAI config before restoring the
dai config upon resume. Also, modify the signature for the
set_hw_params_upon_resume() op to return an int.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 29 ++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h     |  2 +-
 sound/soc/sof/ops.h           |  5 +++--
 sound/soc/sof/pm.c            | 24 ++++++++++++++++++++----
 sound/soc/sof/sof-priv.h      |  2 +-
 5 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 5b73115a0b78..c6eea3079ab7 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -454,18 +454,45 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev, int state)
 	return 0;
 }
 
-void hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
+int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct sof_intel_hda_stream *hda_stream;
 	struct hdac_ext_stream *stream;
 	struct hdac_stream *s;
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct snd_soc_pcm_runtime *rtd;
+	struct hdac_ext_link *link;
+	const char *name;
+	int stream_tag;
+#endif
+
 	/* set internal flag for BE */
 	list_for_each_entry(s, &bus->stream_list, list) {
 		stream = stream_to_hdac_ext_stream(s);
 		hda_stream = container_of(stream, struct sof_intel_hda_stream,
 					  hda_stream);
 		hda_stream->hw_params_upon_resume = 1;
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+		/*
+		 * clear and release stream. This should already be taken care
+		 * for running streams when the SUSPEND trigger is called.
+		 * But paused streams do not get suspended, so this needs to be
+		 * done explicitly during suspend.
+		 */
+		if (stream->link_substream) {
+			rtd = snd_pcm_substream_chip(stream->link_substream);
+			name = rtd->codec_dai->component->name;
+			link = snd_hdac_ext_bus_get_link(bus, name);
+			if (!link)
+				return -EINVAL;
+			stream_tag = hdac_stream(stream)->stream_tag;
+			snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+			snd_hdac_ext_stream_release(stream,
+						    HDAC_EXT_STREAM_TYPE_LINK);
+		}
+#endif
 	}
+	return 0;
 }
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 2862b4b3b07c..327621ef5cf3 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -451,7 +451,7 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev, int state);
 int hda_dsp_resume(struct snd_sof_dev *sdev);
 int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev, int state);
 int hda_dsp_runtime_resume(struct snd_sof_dev *sdev);
-void hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
+int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
 void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags);
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags);
 void hda_ipc_dump(struct snd_sof_dev *sdev);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 80fc3b374c2b..a23297353750 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -134,10 +134,11 @@ static inline int snd_sof_dsp_runtime_suspend(struct snd_sof_dev *sdev,
 	return 0;
 }
 
-static inline void snd_sof_dsp_hw_params_upon_resume(struct snd_sof_dev *sdev)
+static inline int snd_sof_dsp_hw_params_upon_resume(struct snd_sof_dev *sdev)
 {
 	if (sof_ops(sdev)->set_hw_params_upon_resume)
-		sof_ops(sdev)->set_hw_params_upon_resume(sdev);
+		return sof_ops(sdev)->set_hw_params_upon_resume(sdev);
+	return 0;
 }
 
 static inline int snd_sof_dsp_set_clk(struct snd_sof_dev *sdev, u32 freq)
diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index b7843f02ef67..8eeb3a1029f2 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -153,6 +153,15 @@ static int sof_restore_pipelines(struct snd_sof_dev *sdev)
 			continue;
 		}
 
+		/*
+		 * The link DMA channel would be invalidated for running
+		 * streams but not for streams that were in the PAUSED
+		 * state during suspend. So invalidate it here before setting
+		 * the dai config in the DSP.
+		 */
+		if (config->type == SOF_DAI_INTEL_HDA)
+			config->hda.link_dma_ch = DMA_CHAN_INVALID;
+
 		ret = sof_ipc_tx_message(sdev->ipc,
 					 config->hdr.cmd, config,
 					 config->hdr.size,
@@ -204,7 +213,7 @@ static int sof_send_pm_ipc(struct snd_sof_dev *sdev, int cmd)
 				 sizeof(pm_ctx), &reply, sizeof(reply));
 }
 
-static void sof_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
+static int sof_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 {
 	struct snd_pcm_substream *substream;
 	struct snd_sof_pcm *spcm;
@@ -229,7 +238,7 @@ static void sof_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 	}
 
 	/* set internal flag for BE */
-	snd_sof_dsp_hw_params_upon_resume(sdev);
+	return snd_sof_dsp_hw_params_upon_resume(sdev);
 }
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
@@ -333,8 +342,15 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	snd_sof_release_trace(sdev);
 
 	/* set restore_stream for all streams during system suspend */
-	if (!runtime_suspend)
-		sof_set_hw_params_upon_resume(sdev);
+	if (!runtime_suspend) {
+		ret = sof_set_hw_params_upon_resume(sdev);
+		if (ret < 0) {
+			dev_err(sdev->dev,
+				"error: setting hw_params flag during suspend %d\n",
+				ret);
+			return ret;
+		}
+	}
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
 	/* cache debugfs contents during runtime suspend */
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index b80d93e5df2f..cf1b047f8cb6 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -172,7 +172,7 @@ struct snd_sof_dsp_ops {
 	int (*runtime_suspend)(struct snd_sof_dev *sof_dev,
 			       int state); /* optional */
 	int (*runtime_resume)(struct snd_sof_dev *sof_dev); /* optional */
-	void (*set_hw_params_upon_resume)(struct snd_sof_dev *sdev); /* optional */
+	int (*set_hw_params_upon_resume)(struct snd_sof_dev *sdev); /* optional */
 
 	/* DSP clocking */
 	int (*set_clk)(struct snd_sof_dev *sof_dev, u32 freq); /* optional */
-- 
2.20.1
