From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 19/21] ASoC: SOF: Intel: hda: fix stream id
	setting
Date: Mon, 22 Jul 2019 09:14:00 -0500
Message-ID: <20190722141402.7194-20-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45E68F804CC
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:25 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Rander Wang <rander.wang@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rander Wang <rander.wang@linux.intel.com>

snd_hdac_ext_link_clear_stream_id maps stream id to
link output, which is for playback, not capture.

Tested on Whiskey Lake platform.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 15 +++++++++++----
 sound/soc/sof/intel/hda-dsp.c |  8 +++++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 2b5e2b8c69c2..8796f385be76 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -327,8 +327,12 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 					  DMA_CHAN_INVALID, substream->stream);
 		if (ret < 0)
 			return ret;
-		stream_tag = hdac_stream(link_dev)->stream_tag;
-		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			stream_tag = hdac_stream(link_dev)->stream_tag;
+			snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+		}
+
 		link_dev->link_prepared = 0;
 
 		/* fallthrough */
@@ -369,8 +373,11 @@ static int hda_link_hw_free(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
-	stream_tag = hdac_stream(link_dev)->stream_tag;
-	snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		stream_tag = hdac_stream(link_dev)->stream_tag;
+		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+	}
+
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
 	snd_hdac_ext_stream_release(link_dev, HDAC_EXT_STREAM_TYPE_LINK);
 	link_dev->link_prepared = 0;
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index e38008194574..fb55a3c5afd0 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -450,9 +450,15 @@ int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 			link = snd_hdac_ext_bus_get_link(bus, name);
 			if (!link)
 				return -EINVAL;
+
+			stream->link_prepared = 0;
+
+			if (hdac_stream(stream)->direction ==
+				SNDRV_PCM_STREAM_CAPTURE)
+				continue;
+
 			stream_tag = hdac_stream(stream)->stream_tag;
 			snd_hdac_ext_link_clear_stream_id(link, stream_tag);
-			stream->link_prepared = 0;
 		}
 	}
 #endif
-- 
2.20.1
