From: mengdong.lin@linux.intel.com
Subject: [PATCH v7 10/11] ASoC: topology: Rename functions &
	variables for physical DAIs
Date: Thu,  3 Nov 2016 01:05:15 +0800
Message-ID: <0329ba85681b5e2b0c546203e3da67d8dd8f2f60.1478071138.git.mengdong.lin@linux.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 081272666FA
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:04:15 +0100 (CET)
In-Reply-To: <cover.1478071138.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Code refactoring. These functions and variables are for configuring
physical DAIs, not only backend DAIs since users may not need DPCM.
So remove 'be' from the function names, and rename variables 'be'
to 'd' or 'dai'.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index a839dc8..f44f12e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2081,16 +2081,16 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
-/* *
- * soc_tplg_be_dai_config - Find and configure an existing BE DAI.
+/**
+ * soc_tplg_dai_config - Find and configure an existing physical DAI.
  * @tplg: topology context
- * @be: topology BE DAI configs.
+ * @d: physical DAI configs.
  *
- * The BE dai should already be registered by the platform driver. The
- * platform driver should specify the BE DAI name and ID for matching.
+ * The physical dai should already be registered by the platform driver.
+ * The platform driver should specify the DAI name and ID for matching.
  */
-static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
-				  struct snd_soc_tplg_dai *be)
+static int soc_tplg_dai_config(struct soc_tplg *tplg,
+			       struct snd_soc_tplg_dai *d)
 {
 	struct snd_soc_dai_link_component dai_component = {0};
 	struct snd_soc_dai *dai;
@@ -2099,17 +2099,17 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;
 
-	dai_component.dai_name = be->dai_name;
+	dai_component.dai_name = d->dai_name;
 	dai = snd_soc_find_dai(&dai_component);
 	if (!dai) {
-		dev_err(tplg->dev, "ASoC: BE DAI %s not registered\n",
-			be->dai_name);
+		dev_err(tplg->dev, "ASoC: physical DAI %s not registered\n",
+			d->dai_name);
 		return -EINVAL;
 	}
 
-	if (be->dai_id != dai->id) {
-		dev_err(tplg->dev, "ASoC: BE DAI %s id mismatch\n",
-			be->dai_name);
+	if (d->dai_id != dai->id) {
+		dev_err(tplg->dev, "ASoC: physical DAI %s id mismatch\n",
+			d->dai_name);
 		return -EINVAL;
 	}
 
@@ -2117,20 +2117,20 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	if (!dai_drv)
 		return -EINVAL;
 
-	if (be->playback) {
+	if (d->playback) {
 		stream = &dai_drv->playback;
-		caps = &be->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
+		caps = &d->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
 		set_stream_info(stream, caps);
 	}
 
-	if (be->capture) {
+	if (d->capture) {
 		stream = &dai_drv->capture;
-		caps = &be->caps[SND_SOC_TPLG_STREAM_CAPTURE];
+		caps = &d->caps[SND_SOC_TPLG_STREAM_CAPTURE];
 		set_stream_info(stream, caps);
 	}
 
-	if (be->flag_mask)
-		set_dai_flags(dai_drv, be->flag_mask, be->flags);
+	if (d->flag_mask)
+		set_dai_flags(dai_drv, d->flag_mask, d->flags);
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv);
@@ -2142,10 +2142,11 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	return 0;
 }
 
-static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
-				      struct snd_soc_tplg_hdr *hdr)
+/* load physical DAI elements */
+static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
+				   struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_dai *be;
+	struct snd_soc_tplg_dai *dai;
 	int count = hdr->count;
 	int i;
 
@@ -2154,14 +2155,14 @@ static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 
 	/* config the existing BE DAIs */
 	for (i = 0; i < count; i++) {
-		be = (struct snd_soc_tplg_dai *)tplg->pos;
-		if (be->size != sizeof(*be)) {
-			dev_err(tplg->dev, "ASoC: invalid BE DAI size\n");
+		dai = (struct snd_soc_tplg_dai *)tplg->pos;
+		if (dai->size != sizeof(*dai)) {
+			dev_err(tplg->dev, "ASoC: invalid physical DAI size\n");
 			return -EINVAL;
 		}
 
-		soc_tplg_be_dai_config(tplg, be);
-		tplg->pos += (sizeof(*be) + be->priv.size);
+		soc_tplg_dai_config(tplg, dai);
+		tplg->pos += (sizeof(*dai) + dai->priv.size);
 	}
 
 	dev_dbg(tplg->dev, "ASoC: Configure %d BE DAIs\n", count);
@@ -2329,7 +2330,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_TYPE_PCM:
 		return soc_tplg_pcm_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_DAI:
-		return soc_tplg_be_dai_elems_load(tplg, hdr);
+		return soc_tplg_dai_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_DAI_LINK:
 	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
 		/* physical link configurations */
-- 
2.7.4
