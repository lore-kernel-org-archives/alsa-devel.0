From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 17/21] ASoC: SOF: Intel: hda: reset link DMA
	state in prepare
Date: Mon, 22 Jul 2019 09:13:58 -0500
Message-ID: <20190722141402.7194-18-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF405F8048E
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:23 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

When application goes through SUSPEND/STOP->PREPARE->START
cycle, we should always reprogram the DAI link DMA to ensure
it is in sync with the host PCM DMA.

Use same state tracking logic to handle both restart and
system resume flows. Use link_prepared field of
'struct hdac_ext_stream' to store the state, instead of
adding redundant fields to SOF specific structs.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c |  8 +++-----
 sound/soc/sof/intel/hda-dsp.c | 17 ++++++-----------
 sound/soc/sof/intel/hda.h     |  1 -
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index a514f9cf5c9a..a448be60f6dd 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -226,8 +226,6 @@ static int hda_link_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
 
-	hda_stream->hw_params_upon_resume = 0;
-
 	link = snd_hdac_ext_bus_get_link(bus, codec_dai->component->name);
 	if (!link)
 		return -EINVAL;
@@ -267,8 +265,7 @@ static int hda_link_pcm_prepare(struct snd_pcm_substream *substream,
 
 	hda_stream = hstream_to_sof_hda_stream(link_dev);
 
-	/* setup hw_params again only if resuming from system suspend */
-	if (!hda_stream->hw_params_upon_resume)
+	if (link_dev->link_prepared)
 		return 0;
 
 	dev_dbg(sdev->dev, "hda: prepare stream dir %d\n", substream->stream);
@@ -317,6 +314,7 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 		snd_hdac_ext_link_stream_start(link_dev);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
 		/*
 		 * clear and release link DMA channel. It will be assigned when
 		 * hw_params is set up again after resume.
@@ -329,10 +327,10 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
 		snd_hdac_ext_stream_release(link_dev,
 					    HDAC_EXT_STREAM_TYPE_LINK);
+		link_dev->link_prepared = 0;
 
 		/* fallthrough */
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_STOP:
 		snd_hdac_ext_link_stream_clear(link_dev);
 		break;
 	default:
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index f08a5d649346..e82ecaad1763 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -425,25 +425,19 @@ int hda_dsp_suspend(struct snd_sof_dev *sdev)
 
 int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 {
-	struct hdac_bus *bus = sof_to_bus(sdev);
-	struct sof_intel_hda_stream *hda_stream;
-	struct hdac_ext_stream *stream;
-	struct hdac_stream *s;
-
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct snd_soc_pcm_runtime *rtd;
+	struct hdac_ext_stream *stream;
 	struct hdac_ext_link *link;
+	struct hdac_stream *s;
 	const char *name;
 	int stream_tag;
-#endif
 
 	/* set internal flag for BE */
 	list_for_each_entry(s, &bus->stream_list, list) {
 		stream = stream_to_hdac_ext_stream(s);
-		hda_stream = container_of(stream, struct sof_intel_hda_stream,
-					  hda_stream);
-		hda_stream->hw_params_upon_resume = 1;
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+
 		/*
 		 * clear and release stream. This should already be taken care
 		 * for running streams when the SUSPEND trigger is called.
@@ -460,8 +454,9 @@ int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 			snd_hdac_ext_link_clear_stream_id(link, stream_tag);
 			snd_hdac_ext_stream_release(stream,
 						    HDAC_EXT_STREAM_TYPE_LINK);
+			stream->link_prepared = 0;
 		}
-#endif
 	}
+#endif
 	return 0;
 }
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 028e865d5e20..ceaaa8d467f4 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -418,7 +418,6 @@ struct sof_intel_hda_stream {
 	struct snd_sof_dev *sdev;
 	struct hdac_ext_stream hda_stream;
 	struct sof_intel_stream stream;
-	int hw_params_upon_resume; /* set up hw_params upon resume */
 	int host_reserved; /* reserve host DMA channel */
 };
 
-- 
2.20.1
