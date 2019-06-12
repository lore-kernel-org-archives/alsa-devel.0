From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/15] ASoC: SOF: Intel: hda: couple host and
	link DMA during FE hw_free
Date: Wed, 12 Jun 2019 12:23:39 -0500
Message-ID: <20190612172347.22338-8-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C7E0F8970C
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:23:58 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Host and link DMA are decoupled during FE hw_params. So,
they must be coupled in hw_free if the link DMA channel
is idle.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/apl.c        |  1 +
 sound/soc/sof/intel/cnl.c        |  1 +
 sound/soc/sof/intel/hda-stream.c | 20 ++++++++++++++++++++
 sound/soc/sof/intel/hda.h        |  2 ++
 sound/soc/sof/ops.h              | 11 +++++++++++
 sound/soc/sof/pcm.c              |  7 +++++++
 sound/soc/sof/sof-priv.h         |  4 ++++
 7 files changed, 46 insertions(+)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index f215d80dce2c..43d1c9f31ec4 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -61,6 +61,7 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 	.pcm_open	= hda_dsp_pcm_open,
 	.pcm_close	= hda_dsp_pcm_close,
 	.pcm_hw_params	= hda_dsp_pcm_hw_params,
+	.pcm_hw_free	= hda_dsp_stream_hw_free,
 	.pcm_trigger	= hda_dsp_pcm_trigger,
 	.pcm_pointer	= hda_dsp_pcm_pointer,
 
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index d59305787fc3..3840f81767fa 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -219,6 +219,7 @@ const struct snd_sof_dsp_ops sof_cnl_ops = {
 	.pcm_open	= hda_dsp_pcm_open,
 	.pcm_close	= hda_dsp_pcm_close,
 	.pcm_hw_params	= hda_dsp_pcm_hw_params,
+	.pcm_hw_free	= hda_dsp_stream_hw_free,
 	.pcm_trigger	= hda_dsp_pcm_trigger,
 	.pcm_pointer	= hda_dsp_pcm_pointer,
 
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index a3f7c91469ec..ff6ab0c45d8e 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -438,6 +438,26 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 	return ret;
 }
 
+int hda_dsp_stream_hw_free(struct snd_sof_dev *sdev,
+			   struct snd_pcm_substream *substream)
+{
+	struct hdac_stream *stream = substream->runtime->private_data;
+	struct hdac_ext_stream *link_dev = container_of(stream,
+							struct hdac_ext_stream,
+							hstream);
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	u32 mask = 0x1 << stream->index;
+
+	spin_lock(&bus->reg_lock);
+	/* couple host and link DMA if link DMA channel is idle */
+	if (!link_dev->link_locked)
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR,
+					SOF_HDA_REG_PP_PPCTL, mask, 0);
+	spin_unlock(&bus->reg_lock);
+
+	return 0;
+}
+
 irqreturn_t hda_dsp_stream_interrupt(int irq, void *context)
 {
 	struct hdac_bus *bus = context;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 327621ef5cf3..8812dae9cf7a 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -468,6 +468,8 @@ int hda_dsp_pcm_hw_params(struct snd_sof_dev *sdev,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
 			  struct sof_ipc_stream_params *ipc_params);
+int hda_dsp_stream_hw_free(struct snd_sof_dev *sdev,
+			   struct snd_pcm_substream *substream);
 int hda_dsp_pcm_trigger(struct snd_sof_dev *sdev,
 			struct snd_pcm_substream *substream, int cmd);
 snd_pcm_uframes_t hda_dsp_pcm_pointer(struct snd_sof_dev *sdev,
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index a23297353750..45a3d1091163 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -287,6 +287,17 @@ snd_sof_pcm_platform_hw_params(struct snd_sof_dev *sdev,
 	return 0;
 }
 
+/* host stream hw free */
+static inline int
+snd_sof_pcm_platform_hw_free(struct snd_sof_dev *sdev,
+			     struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_hw_free)
+		return sof_ops(sdev)->pcm_hw_free(sdev, substream);
+
+	return 0;
+}
+
 /* host stream trigger */
 static inline int
 snd_sof_pcm_platform_trigger(struct snd_sof_dev *sdev,
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 6dc5f97be0bc..334e9d59b1ba 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -251,6 +251,13 @@ static int sof_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	cancel_work_sync(&spcm->stream[substream->stream].period_elapsed_work);
 
+	if (ret < 0)
+		return ret;
+
+	ret = snd_sof_pcm_platform_hw_free(sdev, substream);
+	if (ret < 0)
+		dev_err(sdev->dev, "error: platform hw free failed\n");
+
 	return ret;
 }
 
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 4d8c06eaf571..e04418615129 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -143,6 +143,10 @@ struct snd_sof_dsp_ops {
 			     struct snd_pcm_hw_params *params,
 			     struct sof_ipc_stream_params *ipc_params); /* optional */
 
+	/* host stream hw_free */
+	int (*pcm_hw_free)(struct snd_sof_dev *sdev,
+			   struct snd_pcm_substream *substream); /* optional */
+
 	/* host stream trigger */
 	int (*pcm_trigger)(struct snd_sof_dev *sdev,
 			   struct snd_pcm_substream *substream,
-- 
2.20.1
