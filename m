From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Move CODEC to CODEC params from
	the widget to the runtime" to the asoc tree
Date: Thu,  6 Sep 2018 11:46:50 +0100 (BST)
Message-ID: <20180906104650.7AE651122A1F@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E715126779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:46:51 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Move CODEC to CODEC params from the widget to the runtime

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 243bcfafcd9a23a20867fd488dc3a35264918d87 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 5 Sep 2018 15:21:02 +0100
Subject: [PATCH] ASoC: dapm: Move CODEC to CODEC params from the widget to the
 runtime

Larger CODECs may contain many several hundred widgets and which set of
parameters is selected only needs to be recorded on a per DAI basis. As
such move the selected CODEC to CODEC link params to be stored in the
runtime rather than the DAPM widget, to save some memory.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 6b68b31e3140..821bf99992b8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1130,6 +1130,8 @@ struct snd_soc_pcm_runtime {
 	enum snd_soc_pcm_subclass pcm_subclass;
 	struct snd_pcm_ops ops;
 
+	unsigned int params_select; /* currently selected param for dai link */
+
 	/* Dynamic PCM BE runtime data */
 	struct snd_soc_dpcm_runtime dpcm[2];
 	int fe_compr;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 40f27c95da61..9f4edcd19e02 100644
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
@@ -3617,13 +3618,15 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
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
@@ -3772,8 +3775,9 @@ static int snd_soc_dapm_dai_link_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 
-	ucontrol->value.enumerated.item[0] = w->params_select;
+	ucontrol->value.enumerated.item[0] = rtd->params_select;
 
 	return 0;
 }
@@ -3782,18 +3786,19 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
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
@@ -3936,8 +3941,6 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	if (IS_ERR(w))
 		goto outfree_kcontrol_news;
 
-	w->params = rtd->dai_link->params;
-	w->num_params = rtd->dai_link->num_params;
 	w->priv = rtd;
 
 	return w;
-- 
2.19.0.rc1
