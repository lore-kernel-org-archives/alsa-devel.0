From: mengdong.lin@linux.intel.com
Subject: [PATCH 9/9] topology: Add C API support for PCM
Date: Thu,  5 Nov 2015 20:49:36 +0800
Message-ID: <cc240cae0dea61d4e923adc12d0326c39b97ea5f.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2FD266170
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:34:10 +0100 (CET)
In-Reply-To: <cover.1446726689.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

PCM objects can be added by C API. And this is used to create FE DAIs
and DAI links in kernel.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index ccd69d7..b631871 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -660,6 +660,41 @@ struct snd_tplg_stream_template {
 	int channels;		/*!< number of channels */
 };
 
+/** \struct snd_tplg_stream_caps_template
+ * \brief Stream Capabilities.
+ */
+struct snd_tplg_stream_caps_template {
+	const char *name;	/*!< name of the stream caps */
+	__le64 formats;	/*!< supported formats SNDRV_PCM_FMTBIT_* */
+	unsigned int rates;	/*!< supported rates SNDRV_PCM_RATE_* */
+	unsigned int rate_min;	/*!< min rate */
+	unsigned int rate_max;	/*!< max rate */
+	unsigned int channels_min;	/*!< min channels */
+	unsigned int channels_max;	/*!< max channels */
+	unsigned int periods_min;	/*!< min number of periods */
+	unsigned int periods_max;	/*!< max number of periods */
+	unsigned int period_size_min;	/*!< min period size bytes */
+	unsigned int period_size_max;	/*!< max period size bytes */
+	unsigned int buffer_size_min;	/*!< min buffer size bytes */
+	unsigned int buffer_size_max;	/*!< max buffer size bytes */
+};
+
+/** \struct snd_tplg_pcm_template
+ * \brief Template type for PCM (FE DAI & DAI links).
+ */
+struct snd_tplg_pcm_template {
+	const char *pcm_name;	/*!< PCM stream name */
+	const char *dai_name;	/*!< DAI name */
+	unsigned int pcm_id;	/*!< unique ID - used to match */
+	unsigned int dai_id;	/*!< unique ID - used to match */
+	unsigned int playback;	/*!< supports playback mode */
+	unsigned int capture;	/*!< supports capture mode */
+	unsigned int compress;	/*!< 1 = compressed; 0 = PCM */
+	struct snd_tplg_stream_caps_template *caps[2]; /*!< playback & capture for DAI */
+	int num_streams;	/*!< number of supported configs */
+	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
+};
+
 /** \struct snd_tplg_link_template
  * \brief Template type for BE and CC DAI Links.
  */
@@ -684,6 +719,7 @@ typedef struct snd_tplg_obj_template {
 		struct snd_tplg_bytes_template *bytes_ctl;	/*!< Bytes control */
 		struct snd_tplg_enum_template *enum_ctl;	/*!< Enum control */
 		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
+		struct snd_tplg_pcm_template *pcm;		/*!< PCM elements */
 		struct snd_tplg_link_template *link;		/*!< BE and CC Links */
 	};
 } snd_tplg_obj_template_t;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 1851459..80a0ae0 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -311,6 +311,8 @@ int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 		return tplg_add_widget_object(tplg, t);
 	case SND_TPLG_TYPE_DAPM_GRAPH:
 		return tplg_add_graph_object(tplg, t);
+	case SND_TPLG_TYPE_PCM:
+		return tplg_add_pcm_object(tplg, t);
 	case SND_TPLG_TYPE_BE:
 	case SND_TPLG_TYPE_CC:
 		return tplg_add_link_object(tplg, t);
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index c2b2b98..9b7e402 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -95,6 +95,9 @@ int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type)
 		err = tplg_build_pcm_caps(tplg, elem);
 		if (err < 0)
 			return err;
+
+		/* add PCM to manifest */
+		tplg->manifest.pcm_elems++;
 	}
 
 	return 0;
@@ -494,6 +497,68 @@ static void tplg_add_stream_object(struct snd_soc_tplg_stream *strm,
 	strm->channels = strm_tpl->channels;
 }
 
+static void tplg_add_stream_caps(struct snd_soc_tplg_stream_caps *caps,
+	struct snd_tplg_stream_caps_template *caps_tpl)
+{
+	elem_copy_text(caps->name, caps_tpl->name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	caps->formats = caps_tpl->formats;
+	caps->rates = caps_tpl->rates;
+	caps->rate_min = caps_tpl->rate_min;
+	caps->rate_max = caps_tpl->rate_max;
+	caps->channels_min = caps_tpl->channels_min;
+	caps->channels_max = caps_tpl->channels_max;
+	caps->periods_min = caps_tpl->periods_min;
+	caps->periods_max = caps_tpl->periods_max;
+	caps->period_size_min = caps_tpl->period_size_min;
+	caps->period_size_max = caps_tpl->period_size_max;
+	caps->buffer_size_min = caps_tpl->buffer_size_min;
+	caps->buffer_size_max = caps_tpl->buffer_size_max;
+}
+
+int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	struct snd_tplg_pcm_template *pcm_tpl = t->pcm;
+	struct snd_soc_tplg_pcm *pcm;
+	struct tplg_elem *elem;
+	int i;
+
+	tplg_dbg("PCM: %s, DAI %s\n", pcm_tpl->pcm_name, pcm_tpl->dai_name);
+
+	if (pcm_tpl->num_streams > SND_SOC_TPLG_STREAM_CONFIG_MAX)
+		return -EINVAL;
+
+	elem = tplg_elem_new_common(tplg, NULL, pcm_tpl->pcm_name,
+		SND_TPLG_TYPE_PCM);
+	if (!elem)
+		return -ENOMEM;
+
+	pcm = elem->pcm;
+	pcm->size = elem->size;
+
+	elem_copy_text(pcm->pcm_name, pcm_tpl->pcm_name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	elem_copy_text(pcm->dai_name, pcm_tpl->dai_name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	pcm->pcm_id = pcm_tpl->pcm_id;
+	pcm->dai_id = pcm_tpl->dai_id;
+	pcm->playback = pcm_tpl->playback;
+	pcm->capture = pcm_tpl->capture;
+	pcm->compress = pcm_tpl->compress;
+
+	for (i = 0; i < 2; i++) {
+		if (pcm_tpl->caps[i])
+			tplg_add_stream_caps(&pcm->caps[i], pcm_tpl->caps[i]);
+	}
+
+	pcm->num_streams = pcm_tpl->num_streams;
+	for (i = 0; i < pcm->num_streams; i++)
+		tplg_add_stream_object(&pcm->stream[i], &pcm_tpl->stream[i]);
+
+	return 0;
+}
+
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 {
 	struct snd_tplg_link_template *link = t->link;
-- 
1.9.1
