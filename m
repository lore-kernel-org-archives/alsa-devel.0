From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 7/7] ASoC: dapm: Move CODEC to CODEC params
	from the widget to the runtime
Date: Tue, 28 Aug 2018 14:35:08 +0100
Message-ID: <20180828133508.13012-7-ckeepax@opensource.cirrus.com>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 46D682678C5
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 15:35:13 +0200 (CEST)
In-Reply-To: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Larger CODECs may contain many several hundred widgets and which set of
parameters is selected only needs to be recorded on a per DAI basis. As
such move the selected CODEC to CODEC link params to be stored in the
runtime rather than the DAPM widget, to save some memory.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-dapm.h |  3 ---
 include/sound/soc.h      |  2 ++
 sound/soc/soc-dapm.c     | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index cb177fa21ce7..bd8163f151cb 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -584,9 +584,6 @@ struct snd_soc_dapm_widget {
 	void *priv;				/* widget specific data */
 	struct regulator *regulator;		/* attached regulator */
 	struct pinctrl *pinctrl;		/* attached pinctrl */
-	const struct snd_soc_pcm_stream *params; /* params for dai links */
-	unsigned int num_params; /* number of params for dai links */
-	unsigned int params_select; /* currently selected param for dai link */
 
 	/* dapm control */
 	int reg;				/* negative reg = no direct dapm */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 41cec42fb456..3984fb627dfb 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1124,6 +1124,8 @@ struct snd_soc_pcm_runtime {
 	enum snd_soc_pcm_subclass pcm_subclass;
 	struct snd_pcm_ops ops;
 
+	unsigned int params_select; /* currently selected param for dai link */
+
 	/* Dynamic PCM BE runtime data */
 	struct snd_soc_dpcm_runtime dpcm[2];
 	int fe_compr;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index bf648e27e2cf..30bb9f7c08af 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1018,9 +1018,10 @@ static int dapm_new_dai_link(struct snd_soc_dapm_widget *w)
 	struct snd_kcontrol *kcontrol;
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_card *card = dapm->card->snd_card;
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 
 	/* create control for links with > 1 config */
-	if (w->num_params <= 1)
+	if (rtd->dai_link->num_params <= 1)
 		return 0;
 
 	/* add kcontrol */
@@ -3616,13 +3617,15 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dai *source, *sink;
 	struct snd_soc_pcm_runtime *rtd = w->priv;
-	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
+	const struct snd_soc_pcm_stream *config;
 	struct snd_pcm_substream substream;
 	struct snd_pcm_hw_params *params = NULL;
 	struct snd_pcm_runtime *runtime = NULL;
 	unsigned int fmt;
 	int ret;
 
+	config = rtd->dai_link->params + rtd->params_select;
+
 	if (WARN_ON(!config) ||
 	    WARN_ON(list_empty(&w->edges[SND_SOC_DAPM_DIR_OUT]) ||
 		    list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])))
@@ -3771,8 +3774,9 @@ static int snd_soc_dapm_dai_link_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 
-	ucontrol->value.enumerated.item[0] = w->params_select;
+	ucontrol->value.enumerated.item[0] = rtd->params_select;
 
 	return 0;
 }
@@ -3781,18 +3785,19 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 
 	/* Can't change the config when widget is already powered */
 	if (w->power)
 		return -EBUSY;
 
-	if (ucontrol->value.enumerated.item[0] == w->params_select)
+	if (ucontrol->value.enumerated.item[0] == rtd->params_select)
 		return 0;
 
-	if (ucontrol->value.enumerated.item[0] >= w->num_params)
+	if (ucontrol->value.enumerated.item[0] >= rtd->dai_link->num_params)
 		return -EINVAL;
 
-	w->params_select = ucontrol->value.enumerated.item[0];
+	rtd->params_select = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -3935,8 +3940,6 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	if (IS_ERR(w))
 		goto outfree_kcontrol_news;
 
-	w->params = rtd->dai_link->params;
-	w->num_params = rtd->dai_link->num_params;
 	w->priv = rtd;
 
 	return w;
-- 
2.11.0
