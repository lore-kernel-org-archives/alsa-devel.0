From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Move error handling to
	snd_soc_dapm_new_control_unlocked" to the asoc tree
Date: Thu,  6 Sep 2018 11:50:59 +0100 (BST)
Message-ID: <20180906105059.26D891122A1F@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A88926779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:51:01 +0200 (CEST)
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

   ASoC: dapm: Move error handling to snd_soc_dapm_new_control_unlocked

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

>From 3bbf5d34fd4a0c41246290b70338095ae291851b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 5 Sep 2018 15:20:58 +0100
Subject: [PATCH] ASoC: dapm: Move error handling to
 snd_soc_dapm_new_control_unlocked

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c     | 118 +++++++--------------------------------
 sound/soc/soc-topology.c |  11 ----
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
2.19.0.rc1
