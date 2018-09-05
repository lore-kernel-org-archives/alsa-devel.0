From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 1/5] ASoC: dapm: Move error handling to
	snd_soc_dapm_new_control_unlocked
Date: Wed, 5 Sep 2018 15:20:58 +0100
Message-ID: <20180905142102.29070-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A9F7267818
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2018 16:21:13 +0200 (CEST)
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

Currently DAPM has a lot of similar code to handle errors from
snd_soc_dapm_new_control_unlocked, and much of this code does
not really accurately reflect what the function returns.

Firstly, most places will check for a return value of
-EPROBE_DEFER and silence any error messages in that case. The
one notable exception here being dapm_kcontrol_data_alloc
which does currently print any error messages in the case
of snd_soc_dapm_new_control_unlocked returning NULL or an
error. Additionally the error prints being silenced in these
case are redundant as snd_soc_dapm_new_control_unlocked can
only return -EPROBE_DEFER or NULL when failing.

Secondly, most places will treat a return value of NULL as
an -ENOMEM.  This is not correct either since any error except
EPROBE_DEFER will cause a return value of NULL from
snd_soc_dapm_new_control_unlocked.

Centralise this handling and the error messages within
snd_soc_dapm_new_control_unlocked and update the callers
to simply check IS_ERR and return. Note that this update is
slightly simpler in the case of dapm_kcontrol_data_alloc where
that is fairly close to the handling that was already in place.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Improved the commit message to be a more descriptive
   of the change

Thanks,
Charles

 sound/soc/soc-dapm.c     | 118 ++++++++---------------------------------------
 sound/soc/soc-topology.c |  11 -----
 2 files changed, 19 insertions(+), 110 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0a738cb439be..d13a25ce1275 100644
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
@@ -3433,23 +3425,8 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
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
@@ -3464,24 +3441,20 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
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
@@ -3490,22 +3463,14 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
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
@@ -3519,7 +3484,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->name = kstrdup_const(widget->name, GFP_KERNEL);
 	if (w->name == NULL) {
 		kfree(w);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	switch (w->id) {
@@ -3596,6 +3561,13 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
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
@@ -3621,19 +3593,6 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
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
@@ -3944,21 +3903,8 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
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
@@ -3999,21 +3945,8 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
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
@@ -4028,21 +3961,8 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
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
