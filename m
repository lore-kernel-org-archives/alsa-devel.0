From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/3] ASoC: topology: Add support for
	configuring existing BE DAIs
Date: Tue, 26 Jul 2016 14:32:37 +0800
Message-ID: <15ea9a58599b6c3ffff04532cf651feb362039d0.1469514328.git.mengdong.lin@linux.intel.com>
References: <cover.1469514328.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CF6DE2654B5
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 08:27:23 +0200 (CEST)
In-Reply-To: <cover.1469514328.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The platform driver may just specify the BE (Back End) DAI name and ID.
And topology will find the existing BE DAI by its name and ID, and then
configure its stream caps and flags.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ee7f15a..05a18f6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -48,9 +48,10 @@
 #define SOC_TPLG_PASS_PCM_DAI		4
 #define SOC_TPLG_PASS_GRAPH		5
 #define SOC_TPLG_PASS_PINS		6
+#define SOC_TPLG_PASS_BE_DAI		7
 
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
-#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PINS
+#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_BE_DAI
 
 struct soc_tplg {
 	const struct firmware *fw;
@@ -1556,6 +1557,24 @@ static void set_stream_info(struct snd_soc_pcm_stream *stream,
 	stream->formats = caps->formats;
 }
 
+static void set_dai_flags(struct snd_soc_dai_driver *dai_drv,
+			  unsigned int flag_mask, unsigned int flags)
+{
+	if (flag_mask & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES)
+		dai_drv->symmetric_rates =
+			flags & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS)
+		dai_drv->symmetric_channels =
+			flags & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS ?
+			1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS)
+		dai_drv->symmetric_samplebits =
+			flags & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS ?
+			1 : 0;
+}
+
 static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
@@ -1690,8 +1709,96 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* *
+ * soc_tplg_be_dai_config - Find and configure an existing BE DAI.
+ * @tplg: topology context
+ * @be: topology BE DAI configs.
+ *
+ * The BE dai should already be registered by the platform driver. The
+ * platform driver should specify the BE DAI name and ID for matching.
+ */
+static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
+				  struct snd_soc_tplg_be_dai *be)
+{
+	struct snd_soc_dai_link_component dai_component = {0};
+	struct snd_soc_dai *dai;
+	struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream *stream;
+	struct snd_soc_tplg_stream_caps *caps;
+	int ret;
+
+	dai_component.dai_name = be->dai_name;
+	dai = snd_soc_find_dai(&dai_component);
+	if (!dai) {
+		dev_err(tplg->dev, "ASoC: BE DAI %s not registered\n",
+			be->dai_name);
+		return -EINVAL;
+	}
+
+	if (be->dai_id != dai->id) {
+		dev_err(tplg->dev, "ASoC: BE DAI %s id mismatch\n",
+			be->dai_name);
+		return -EINVAL;
+	}
+
+	dai_drv = dai->driver;
+	if (!dai_drv)
+		return -EINVAL;
+
+	if (be->playback) {
+		stream = &dai_drv->playback;
+		caps = &be->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
+		set_stream_info(stream, caps);
+	}
+
+	if (be->capture) {
+		stream = &dai_drv->capture;
+		caps = &be->caps[SND_SOC_TPLG_STREAM_CAPTURE];
+		set_stream_info(stream, caps);
+	}
+
+	if (be->flag_mask)
+		set_dai_flags(dai_drv, be->flag_mask, be->flags);
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_load(tplg, dai_drv);
+	if (ret < 0) {
+		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
+				      struct snd_soc_tplg_hdr *hdr)
+{
+	struct snd_soc_tplg_be_dai *be;
+	int count = hdr->count;
+	int i;
+
+	if (tplg->pass != SOC_TPLG_PASS_BE_DAI)
+		return 0;
+
+	/* config the existing BE DAIs */
+	for (i = 0; i < count; i++) {
+		be = (struct snd_soc_tplg_be_dai *)tplg->pos;
+		if (be->size != sizeof(*be)) {
+			dev_err(tplg->dev, "ASoC: invalid BE DAI size\n");
+			return -EINVAL;
+		}
+
+		soc_tplg_be_dai_config(tplg, be);
+		tplg->pos += (sizeof(*be) + be->priv.size);
+	}
+
+	dev_dbg(tplg->dev, "ASoC: Configure %d BE DAIs\n", count);
+	return 0;
+}
+
+
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
-	struct snd_soc_tplg_hdr *hdr)
+				  struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_manifest *manifest;
 
@@ -1793,6 +1900,8 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 		return soc_tplg_dapm_widget_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_PCM:
 		return soc_tplg_pcm_elems_load(tplg, hdr);
+	case SND_SOC_TPLG_TYPE_BE_DAI:
+		return soc_tplg_be_dai_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
-- 
2.5.0
