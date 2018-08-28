From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/7] ASoC: dapm: Move error handling to
	snd_soc_dapm_new_control_unlocked
Date: Tue, 28 Aug 2018 14:35:04 +0100
Message-ID: <20180828133508.13012-3-ckeepax@opensource.cirrus.com>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BE2F2678BF
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

Currently DAPM has almost identical code to handle errors from
snd_soc_dapm_new_control_unlocked in many places. Centralise
this handling within snd_soc_dapm_new_control_unlocked and
remove the duplicated error reporting. This also has the fringe
benefit of removing a lot of error messages that would have
been printed on the -ENOMEM paths.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c     | 118 ++++++++---------------------------------------
 sound/soc/soc-topology.c |  11 -----
 2 files changed, 19 insertions(+), 110 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d7be3981f026..ff4219fa4a01 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -364,10 +364,6 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 				ret = PTR_ERR(data->widget);
 				goto err_data;
 			}
-			if (!data->widget) {
-				ret = -ENOMEM;
-				goto err_data;
-			}
 		}
 		break;
 	case snd_soc_dapm_demux:
@@ -402,10 +398,6 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 				ret = PTR_ERR(data->widget);
 				goto err_data;
 			}
-			if (!data->widget) {
-				ret = -ENOMEM;
-				goto err_data;
-			}
 
 			snd_soc_dapm_add_path(widget->dapm, data->widget,
 					      widget, NULL, NULL);
@@ -3432,23 +3424,8 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
-	/* Do not nag about probe deferrals */
-	if (IS_ERR(w)) {
-		int ret = PTR_ERR(w);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(dapm->dev,
-				"ASoC: Failed to create DAPM control %s (%d)\n",
-				widget->name, ret);
-		goto out_unlock;
-	}
-	if (!w)
-		dev_err(dapm->dev,
-			"ASoC: Failed to create DAPM control %s\n",
-			widget->name);
-
-out_unlock:
 	mutex_unlock(&dapm->card->dapm_mutex);
+
 	return w;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
@@ -3463,24 +3440,20 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	int ret;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	switch (w->id) {
 	case snd_soc_dapm_regulator_supply:
 		w->regulator = devm_regulator_get(dapm->dev, w->name);
 		if (IS_ERR(w->regulator)) {
 			ret = PTR_ERR(w->regulator);
-			if (ret == -EPROBE_DEFER)
-				return ERR_PTR(ret);
-			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
-				w->name, ret);
-			return NULL;
+			goto request_failed;
 		}
 
 		if (w->on_val & SND_SOC_DAPM_REGULATOR_BYPASS) {
 			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
-				dev_warn(w->dapm->dev,
+				dev_warn(dapm->dev,
 					 "ASoC: Failed to bypass %s: %d\n",
 					 w->name, ret);
 		}
@@ -3489,22 +3462,14 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->pinctrl = devm_pinctrl_get(dapm->dev);
 		if (IS_ERR(w->pinctrl)) {
 			ret = PTR_ERR(w->pinctrl);
-			if (ret == -EPROBE_DEFER)
-				return ERR_PTR(ret);
-			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
-				w->name, ret);
-			return NULL;
+			goto request_failed;
 		}
 		break;
 	case snd_soc_dapm_clock_supply:
 		w->clk = devm_clk_get(dapm->dev, w->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
-			if (ret == -EPROBE_DEFER)
-				return ERR_PTR(ret);
-			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
-				w->name, ret);
-			return NULL;
+			goto request_failed;
 		}
 		break;
 	default:
@@ -3518,7 +3483,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->name = kstrdup_const(widget->name, GFP_KERNEL);
 	if (w->name == NULL) {
 		kfree(w);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	switch (w->id) {
@@ -3595,6 +3560,13 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	/* machine layer sets up unconnected pins and insertions */
 	w->connected = 1;
 	return w;
+
+request_failed:
+	if (ret != -EPROBE_DEFER)
+		dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
+			w->name, ret);
+
+	return ERR_PTR(ret);
 }
 
 /**
@@ -3620,19 +3592,6 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 		w = snd_soc_dapm_new_control_unlocked(dapm, widget);
 		if (IS_ERR(w)) {
 			ret = PTR_ERR(w);
-			/* Do not nag about probe deferrals */
-			if (ret == -EPROBE_DEFER)
-				break;
-			dev_err(dapm->dev,
-				"ASoC: Failed to create DAPM control %s (%d)\n",
-				widget->name, ret);
-			break;
-		}
-		if (!w) {
-			dev_err(dapm->dev,
-				"ASoC: Failed to create DAPM control %s\n",
-				widget->name);
-			ret = -ENOMEM;
 			break;
 		}
 		widget++;
@@ -3943,21 +3902,8 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
-	if (IS_ERR(w)) {
-		ret = PTR_ERR(w);
-		/* Do not nag about probe deferrals */
-		if (ret != -EPROBE_DEFER)
-			dev_err(card->dev,
-				"ASoC: Failed to create %s widget (%d)\n",
-				link_name, ret);
-		goto outfree_kcontrol_news;
-	}
-	if (!w) {
-		dev_err(card->dev, "ASoC: Failed to create %s widget\n",
-			link_name);
-		ret = -ENOMEM;
+	if (IS_ERR(w))
 		goto outfree_kcontrol_news;
-	}
 
 	w->params = params;
 	w->num_params = num_params;
@@ -3998,21 +3944,8 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 			template.name);
 
 		w = snd_soc_dapm_new_control_unlocked(dapm, &template);
-		if (IS_ERR(w)) {
-			int ret = PTR_ERR(w);
-
-			/* Do not nag about probe deferrals */
-			if (ret != -EPROBE_DEFER)
-				dev_err(dapm->dev,
-				"ASoC: Failed to create %s widget (%d)\n",
-				dai->driver->playback.stream_name, ret);
-			return ret;
-		}
-		if (!w) {
-			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
-				dai->driver->playback.stream_name);
-			return -ENOMEM;
-		}
+		if (IS_ERR(w))
+			return PTR_ERR(w);
 
 		w->priv = dai;
 		dai->playback_widget = w;
@@ -4027,21 +3960,8 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 			template.name);
 
 		w = snd_soc_dapm_new_control_unlocked(dapm, &template);
-		if (IS_ERR(w)) {
-			int ret = PTR_ERR(w);
-
-			/* Do not nag about probe deferrals */
-			if (ret != -EPROBE_DEFER)
-				dev_err(dapm->dev,
-				"ASoC: Failed to create %s widget (%d)\n",
-				dai->driver->playback.stream_name, ret);
-			return ret;
-		}
-		if (!w) {
-			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
-				dai->driver->capture.stream_name);
-			return -ENOMEM;
-		}
+		if (IS_ERR(w))
+			return PTR_ERR(w);
 
 		w->priv = dai;
 		dai->capture_widget = w;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 66e77e020745..17f81b9a5754 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1565,17 +1565,6 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 		widget = snd_soc_dapm_new_control_unlocked(dapm, &template);
 	if (IS_ERR(widget)) {
 		ret = PTR_ERR(widget);
-		/* Do not nag about probe deferrals */
-		if (ret != -EPROBE_DEFER)
-			dev_err(tplg->dev,
-				"ASoC: failed to create widget %s controls (%d)\n",
-				w->name, ret);
-		goto hdr_err;
-	}
-	if (widget == NULL) {
-		dev_err(tplg->dev, "ASoC: failed to create widget %s controls\n",
-			w->name);
-		ret = -ENOMEM;
 		goto hdr_err;
 	}
 
-- 
2.11.0
