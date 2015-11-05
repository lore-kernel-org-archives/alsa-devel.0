From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 13/13] ASoC: topology: Add support for BE
	and CC DAI Links
Date: Thu,  5 Nov 2015 18:00:14 +0800
Message-ID: <3a020923df80f288fdbb977204fd0cd848bc0f18.1446717205.git.mengdong.lin@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 34C52265CAC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:44:50 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

Adding support to modify already existing BE and CC DAI Links.
The links are matches using unique id (be_id) of the links.

Now, the params member in the snd_soc_dai_link struct will be
populated with stream related information.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 6324537..f37f5d8 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -40,6 +40,7 @@ enum snd_soc_dobj_type {
 	SND_SOC_DOBJ_BYTES,
 	SND_SOC_DOBJ_PCM,
 	SND_SOC_DOBJ_DAI_LINK,
+	SND_SOC_DOBJ_BACKEND_LINK,
 	SND_SOC_DOBJ_CODEC_LINK,
 	SND_SOC_DOBJ_WIDGET,
 };
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 31fe60a..875c361 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -992,6 +992,9 @@ struct snd_soc_dai_link {
 	const struct snd_soc_pcm_stream *params;
 	unsigned int num_params;
 
+	/* Stores HW params. Used by topology core. */
+	const struct snd_pcm_hardware *hw_params;
+
 	unsigned int dai_fmt;           /* format to set on init */
 
 	enum snd_soc_dpcm_trigger trigger[2]; /* trigger type for DPCM */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d07c6b0..83c8dd8 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -48,9 +48,11 @@
 #define SOC_TPLG_PASS_PCM_DAI		4
 #define SOC_TPLG_PASS_GRAPH		5
 #define SOC_TPLG_PASS_PINS		6
+#define SOC_TPLG_PASS_BE_LINK		7
+#define SOC_TPLG_PASS_CC_LINK		8
 
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
-#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PINS
+#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_CC_LINK
 
 struct soc_tplg {
 	const struct firmware *fw;
@@ -263,6 +265,8 @@ static enum snd_soc_dobj_type get_dobj_type(struct snd_soc_tplg_hdr *hdr,
 		return SND_SOC_DOBJ_PCM;
 	case SND_SOC_TPLG_TYPE_CODEC_LINK:
 		return SND_SOC_DOBJ_CODEC_LINK;
+	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
+		return SND_SOC_DOBJ_BACKEND_LINK;
 	default:
 		return SND_SOC_DOBJ_NONE;
 	}
@@ -522,6 +526,21 @@ static void remove_pcm_dai(struct snd_soc_component *comp,
 	kfree(dai);
 }
 
+static void soc_tplg_free_be_cc_params(struct snd_soc_component *comp,
+	struct snd_soc_dobj *dobj, int pass)
+{
+	struct snd_soc_card *card = comp->card;
+	struct snd_soc_dai_link *dai_link = card->dai_link;
+	int i, num_links = card->num_links;
+
+	if (pass != SOC_TPLG_PASS_BE_LINK || pass != SOC_TPLG_PASS_CC_LINK)
+		return;
+
+	/* loop through all dai_links. */
+	for (i = 0; i < num_links; i++)
+		kfree(dai_link->hw_params);
+
+}
 /* bind a kcontrol to it's IO handlers */
 static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	struct snd_kcontrol_new *k,
@@ -1701,6 +1720,89 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+static void soc_tplg_make_hw_params(struct snd_pcm_hardware *hw,
+	struct snd_soc_tplg_stream *streams, int num_streams)
+{
+	struct snd_soc_tplg_stream *stream;
+	unsigned int rate;
+	int i;
+
+	for (i = 0; i < num_streams; i++) {
+		stream = streams + i;
+		hw->formats |= stream->format;
+
+		hw->rates |= stream->rate;
+		rate = snd_pcm_rate_bit_to_rate(stream->rate);
+		if (!hw->rate_min || hw->rate_min > rate)
+			hw->rate_min = rate;
+		if (hw->rate_max < rate)
+			hw->rate_max = rate;
+
+		if (!hw->channels_min || hw->channels_min > stream->channels)
+			hw->channels_min = stream->channels;
+		if (hw->channels_max < stream->channels)
+			hw->channels_max = stream->channels;
+
+		if (!hw->period_bytes_min
+			|| hw->period_bytes_min > stream->period_bytes)
+			hw->period_bytes_min = stream->period_bytes;
+		if (hw->period_bytes_max < stream->period_bytes)
+			hw->period_bytes_max = stream->period_bytes;
+
+		if (hw->buffer_bytes_max < stream->buffer_bytes)
+			hw->buffer_bytes_max = stream->buffer_bytes;
+		}
+}
+
+/* modify already existing backend links and codec links. */
+static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
+	struct snd_soc_tplg_hdr *hdr)
+{
+	int i, j;
+	struct snd_soc_tplg_link_config *link;
+	struct snd_soc_card *card = tplg->comp->card;
+	struct snd_soc_dai_link *dai_link = card->dai_link;
+	struct snd_pcm_hardware *pcm_hw;
+	int count = hdr->count, num_dailinks = card->num_links;
+
+	if (tplg->pass != SOC_TPLG_PASS_BE_LINK &&
+		tplg->pass != SOC_TPLG_PASS_CC_LINK)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+		link = (struct snd_soc_tplg_link_config *) tplg->pos;
+		/**
+		 * The machine driver will initially create BE and CC Links.
+		 * In topology, we are searching for the existing BE Link
+		 * by it unique id (be_id).
+		 */
+		for (j = 0; j < num_dailinks; j++) {
+			if (dai_link[j].be_id == link->id)
+				break;
+		}
+
+		if (j == num_dailinks && dai_link[j].be_id != link->id) {
+			dev_err(tplg->dev,
+				"ASoC: cannot find Back End DAI with id %d",
+				link->id);
+			continue;
+		}
+
+		/* copy the data from tplg_elem to BE/CC DAI Link. */
+		pcm_hw = kzalloc(sizeof(struct snd_pcm_hardware), GFP_KERNEL);
+		if (!pcm_hw)
+			return -ENOMEM;
+		soc_tplg_make_hw_params(pcm_hw,
+			link->stream, link->num_streams);
+		dai_link[j].hw_params = pcm_hw;
+
+		tplg->pos += sizeof(struct snd_soc_tplg_link_config);
+	}
+
+
+	return 0;
+}
+
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
@@ -1791,8 +1893,10 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 		return soc_tplg_dapm_widget_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_PCM:
 	case SND_SOC_TPLG_TYPE_DAI_LINK:
-	case SND_SOC_TPLG_TYPE_CODEC_LINK:
 		return soc_tplg_pcm_elems_load(tplg, hdr);
+	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
+	case SND_SOC_TPLG_TYPE_CODEC_LINK:
+		return soc_tplg_link_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
@@ -1950,9 +2054,12 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 				break;
 			case SND_SOC_DOBJ_PCM:
 			case SND_SOC_DOBJ_DAI_LINK:
-			case SND_SOC_DOBJ_CODEC_LINK:
 				remove_pcm_dai(comp, dobj, pass);
 				break;
+			case SND_SOC_DOBJ_BACKEND_LINK:
+			case SND_SOC_DOBJ_CODEC_LINK:
+				soc_tplg_free_be_cc_params(comp, dobj, pass);
+				break;
 			default:
 				dev_err(comp->dev, "ASoC: invalid component type %d for removal\n",
 					dobj->type);
-- 
1.9.1
