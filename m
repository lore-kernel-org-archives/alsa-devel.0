From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Add platform stream event support.
Date: Wed,  7 Mar 2012 16:32:59 +0000
Message-ID: <1331137979-25731-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 0E97C24502
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 17:33:07 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so4151142wib.35
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 08:33:04 -0800 (PST)
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

Currently stream events are only perfomed on codec stream widgets only.
There is now a need to be able to perform stream events on platform
widgets too.

e.g. we have the ABE platform driver with several DAI links
to dummy codecs. We need to be able to perform stream events on any
of the dummy codec DAI links.

This patch also removes the snd_soc_dai * parameter since it's already
contained within the rtd * parameter.

Finally makle stream event return void since no one checks it anyway.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    4 +-
 sound/soc/soc-core.c     |    8 +---
 sound/soc/soc-dapm.c     |   79 +++++++++++++++++++++++++++++----------------
 sound/soc/soc-pcm.c      |    9 ++---
 4 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8cd3c74..d3e45a0 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -368,8 +368,8 @@ int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
-			      struct snd_soc_dai *dai, int event);
+void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+	int event);
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* external DAPM widget events */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f466b9d..cc9f1f1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -573,19 +573,16 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
 		snd_soc_dapm_stream_event(&card->rtd[i],
 					  SNDRV_PCM_STREAM_PLAYBACK,
-					  codec_dai,
 					  SND_SOC_DAPM_STREAM_SUSPEND);
 
 		snd_soc_dapm_stream_event(&card->rtd[i],
 					  SNDRV_PCM_STREAM_CAPTURE,
-					  codec_dai,
 					  SND_SOC_DAPM_STREAM_SUSPEND);
 	}
 
@@ -689,17 +686,16 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
 		snd_soc_dapm_stream_event(&card->rtd[i],
-					  SNDRV_PCM_STREAM_PLAYBACK, codec_dai,
+					  SNDRV_PCM_STREAM_PLAYBACK,
 					  SND_SOC_DAPM_STREAM_RESUME);
 
 		snd_soc_dapm_stream_event(&card->rtd[i],
-					  SNDRV_PCM_STREAM_CAPTURE, codec_dai,
+					  SNDRV_PCM_STREAM_CAPTURE,
 					  SND_SOC_DAPM_STREAM_RESUME);
 	}
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d15a703..8320fd7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3019,37 +3019,61 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
-				  int stream, struct snd_soc_dai *dai,
-				  int event)
+static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+	int event)
 {
-	struct snd_soc_dapm_widget *w;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		w = dai->playback_widget;
-	else
-		w = dai->capture_widget;
+	struct snd_soc_dapm_widget *w_cpu, *w_codec;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
-	if (!w)
-		return;
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w_cpu = cpu_dai->playback_widget;
+		w_codec = codec_dai->playback_widget;
+	} else {
+		w_cpu = cpu_dai->capture_widget;
+		w_codec = codec_dai->capture_widget;
+	}
 
-	dapm_mark_dirty(w, "stream event");
+	if (w_cpu) {
 
-	switch (event) {
-	case SND_SOC_DAPM_STREAM_START:
-		w->active = 1;
-		break;
-	case SND_SOC_DAPM_STREAM_STOP:
-		w->active = 0;
-		break;
-	case SND_SOC_DAPM_STREAM_SUSPEND:
-	case SND_SOC_DAPM_STREAM_RESUME:
-	case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
-	case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
-		break;
+		dapm_mark_dirty(w_cpu, "stream event");
+
+		switch (event) {
+		case SND_SOC_DAPM_STREAM_START:
+			w_cpu->active = 1;
+			break;
+		case SND_SOC_DAPM_STREAM_STOP:
+			w_cpu->active = 0;
+			break;
+		case SND_SOC_DAPM_STREAM_SUSPEND:
+		case SND_SOC_DAPM_STREAM_RESUME:
+		case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
+		case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
+			break;
+		}
+	}
+
+	if (w_codec) {
+
+		dapm_mark_dirty(w_codec, "stream event");
+
+		switch (event) {
+		case SND_SOC_DAPM_STREAM_START:
+			w_codec->active = 1;
+			break;
+		case SND_SOC_DAPM_STREAM_STOP:
+			w_codec->active = 0;
+			break;
+		case SND_SOC_DAPM_STREAM_SUSPEND:
+		case SND_SOC_DAPM_STREAM_RESUME:
+		case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
+		case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
+			break;
+		}
 	}
 
-	dapm_power_widgets(dapm, event);
+	dapm_power_widgets(&rtd->card->dapm, event);
 }
 
 /**
@@ -3063,15 +3087,14 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
-			      struct snd_soc_dai *dai, int event)
+void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+			      int event)
 {
 	struct snd_soc_card *card = rtd->card;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
-	soc_dapm_stream_event(&card->dapm, stream, dai, event);
+	soc_dapm_stream_event(rtd, stream, event);
 	mutex_unlock(&card->dapm_mutex);
-	return 0;
 }
 
 /**
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0ad8dca..26a60b4 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -308,7 +308,7 @@ static void close_delayed_work(struct work_struct *work)
 	if (codec_dai->pop_wait == 1) {
 		codec_dai->pop_wait = 0;
 		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
-					  codec_dai, SND_SOC_DAPM_STREAM_STOP);
+					  SND_SOC_DAPM_STREAM_STOP);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -373,7 +373,6 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
 						  SNDRV_PCM_STREAM_PLAYBACK,
-						  codec_dai,
 						  SND_SOC_DAPM_STREAM_STOP);
 		} else {
 			/* start delayed pop wq here for playback streams */
@@ -384,7 +383,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	} else {
 		/* capture streams can be powered down now */
 		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
-					  codec_dai, SND_SOC_DAPM_STREAM_STOP);
+					  SND_SOC_DAPM_STREAM_STOP);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -453,8 +452,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		cancel_delayed_work(&rtd->delayed_work);
 	}
 
-	snd_soc_dapm_stream_event(rtd, substream->stream, codec_dai,
-				  SND_SOC_DAPM_STREAM_START);
+	snd_soc_dapm_stream_event(rtd, substream->stream,
+			SND_SOC_DAPM_STREAM_START);
 
 	snd_soc_dai_digital_mute(codec_dai, 0);
 
-- 
1.7.5.4
