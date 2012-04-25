From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 3/5] ASoC: dpcm: Add runtime dynamic route
	update
Date: Wed, 25 Apr 2012 12:12:51 +0100
Message-ID: <1335352373-5237-3-git-send-email-lrg@ti.com>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id EB9F91048AB
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 13:13:49 +0200 (CEST)
Received: by wgbfm10 with SMTP id fm10so1701579wgb.34
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 04:13:47 -0700 (PDT)
In-Reply-To: <1335352373-5237-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This patch allows DPCM to dynamically alter the FE to BE PCM links
at runtime based on mixer setting updates. DAPM is looked up after
every mixer update and we perform a DPCM runtime update if the
mixer has a change of value.

This patchs adds/changes the following :-

 o Adds DPCM runtime update core.
 o Changes soc_dapm_mixer_update_power() and soc_dapm_mux_update_power()
   to return if a change has occured rather than 0. No other users check
   atm.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dpcm.h |    1 +
 sound/soc/soc-dapm.c     |    8 ++-
 sound/soc/soc-pcm.c      |  221 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index e307fa3..d1a4b50 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -132,5 +132,6 @@ void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
 /* internal use only */
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
 int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
+int soc_dpcm_runtime_update(struct snd_soc_dapm_widget *);
 
 #endif
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d7ee73a..174ce7b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1744,7 +1744,7 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 	}
 
-	return 0;
+	return found;
 }
 
 int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
@@ -1756,6 +1756,8 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	ret = soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 	mutex_unlock(&card->dapm_mutex);
+	if (ret > 0)
+		soc_dpcm_runtime_update(widget);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
@@ -1788,7 +1790,7 @@ static int soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 	}
 
-	return 0;
+	return found;
 }
 
 int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
@@ -1800,6 +1802,8 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	ret = soc_dapm_mixer_update_power(widget, kcontrol, connect);
 	mutex_unlock(&card->dapm_mutex);
+	if (ret > 0)
+		soc_dpcm_runtime_update(widget);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a1d4426..ca36fd6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1608,7 +1608,228 @@ out:
 	return ret;
 }
 
+static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	int err;
+
+	dev_dbg(fe->dev, "runtime %s close on FE %s\n",
+			stream ? "capture" : "playback", fe->dai_link->name);
+
+	err = dpcm_be_dai_trigger(fe, stream, SNDRV_PCM_TRIGGER_STOP);
+	if (err < 0)
+		dev_err(fe->dev,"dpcm: trigger FE failed %d\n", err);
+
+	err = dpcm_be_dai_hw_free(fe, stream);
+	if (err < 0)
+		dev_err(fe->dev,"dpcm: hw_free FE failed %d\n", err);
+
+	err = dpcm_be_dai_shutdown(fe, stream);
+	if (err < 0)
+		dev_err(fe->dev,"dpcm: shutdown FE failed %d\n", err);
+
+	/* run the stream event for each BE */
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_NOP);
+
+	return 0;
+}
+
+static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	int ret;
+
+	dev_dbg(fe->dev, "runtime %s open on FE %s\n",
+			stream ? "capture" : "playback", fe->dai_link->name);
+
+	/* Only start the BE if the FE is ready */
+	if (fe->dpcm[stream].state == SND_SOC_DPCM_STATE_HW_FREE ||
+		fe->dpcm[stream].state == SND_SOC_DPCM_STATE_CLOSE)
+		return -EINVAL;
+
+	/* startup must always be called for new BEs */
+	ret = dpcm_be_dai_startup(fe, stream);
+	if (ret < 0) {
+		goto disconnect;
+		return ret;
+	}
+
+	/* keep going if FE state is > open */
+	if (fe->dpcm[stream].state == SND_SOC_DPCM_STATE_OPEN)
+		return 0;
 
+	ret = dpcm_be_dai_hw_params(fe, stream);
+	if (ret < 0) {
+		goto close;
+		return ret;
+	}
+
+	/* keep going if FE state is > hw_params */
+	if (fe->dpcm[stream].state == SND_SOC_DPCM_STATE_HW_PARAMS)
+		return 0;
+
+
+	ret = dpcm_be_dai_prepare(fe, stream);
+	if (ret < 0) {
+		goto hw_free;
+		return ret;
+	}
+
+	/* run the stream event for each BE */
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_NOP);
+
+	/* keep going if FE state is > prepare */
+	if (fe->dpcm[stream].state == SND_SOC_DPCM_STATE_PREPARE ||
+		fe->dpcm[stream].state == SND_SOC_DPCM_STATE_STOP)
+		return 0;
+
+	dev_dbg(fe->dev, "dpcm: trigger FE %s cmd start\n",
+		fe->dai_link->name);
+
+	ret = dpcm_be_dai_trigger(fe, stream,
+			SNDRV_PCM_TRIGGER_START);
+	if (ret < 0) {
+		dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+		goto hw_free;
+	}
+
+	return 0;
+
+hw_free:
+	dpcm_be_dai_hw_free(fe, stream);
+close:
+	dpcm_be_dai_shutdown(fe, stream);
+disconnect:
+	/* disconnect any non started BEs */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
+	}
+
+	return ret;
+}
+
+static int dpcm_run_new_update(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	int ret;
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_BE;
+	ret = dpcm_run_update_startup(fe, stream);
+	if (ret < 0)
+		dev_err(fe->dev, "failed to startup some BEs\n");
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+
+	return ret;
+}
+
+static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	int ret;
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_BE;
+	ret = dpcm_run_update_shutdown(fe, stream);
+	if (ret < 0)
+		dev_err(fe->dev, "failed to shutdown some BEs\n");
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+
+	return ret;
+}
+
+/* Called by DAPM mixer/mux changes to update audio routing between PCMs and
+ * any DAI links.
+ */
+int soc_dpcm_runtime_update(struct snd_soc_dapm_widget *widget)
+{
+	struct snd_soc_card *card;
+	int i, old, new, paths;
+
+	if (widget->codec)
+		card = widget->codec->card;
+	else if (widget->platform)
+		card = widget->platform->card;
+	else
+		return -EINVAL;
+
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dapm_widget_list *list;
+		struct snd_soc_pcm_runtime *fe = &card->rtd[i];
+
+		/* make sure link is FE */
+		if (!fe->dai_link->dynamic)
+			continue;
+
+		/* only check active links */
+		if (!fe->cpu_dai->active)
+			continue;
+
+		/* DAPM sync will call this to update DSP paths */
+		dev_dbg(fe->dev, "DPCM runtime update for FE %s\n",
+			fe->dai_link->name);
+
+		/* skip if FE doesn't have playback capability */
+		if (!fe->cpu_dai->driver->playback.channels_min)
+			goto capture;
+
+		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
+		if (paths < 0) {
+			dev_warn(fe->dev, "%s no valid %s path\n",
+					fe->dai_link->name,  "playback");
+			mutex_unlock(&card->mutex);
+			return paths;
+		}
+
+		/* update any new playback paths */
+		new = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, 1);
+		if (new) {
+			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
+			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
+			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+
+		/* update any old playback paths */
+		old = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, 0);
+		if (old) {
+			dpcm_run_old_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
+			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
+			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+
+capture:
+		/* skip if FE doesn't have capture capability */
+		if (!fe->cpu_dai->driver->capture.channels_min)
+			continue;
+
+		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
+		if (paths < 0) {
+			dev_warn(fe->dev, "%s no valid %s path\n",
+					fe->dai_link->name,  "capture");
+			mutex_unlock(&card->mutex);
+			return paths;
+		}
+
+		/* update any new capture paths */
+		new = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, 1);
+		if (new) {
+			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_CAPTURE);
+			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
+			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
+		}
+
+		/* update any old capture paths */
+		old = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, 0);
+		if (old) {
+			dpcm_run_old_update(fe, SNDRV_PCM_STREAM_CAPTURE);
+			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
+			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
+		}
+
+		dpcm_path_put(&list);
+	}
+
+	mutex_unlock(&card->mutex);
+	return 0;
+}
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
 	struct snd_soc_dpcm *dpcm;
-- 
1.7.5.4
