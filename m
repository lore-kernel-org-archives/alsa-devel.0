From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ASoC: dapm: Supply the DAI and substream
	when calling stream events
Date: Thu, 16 Feb 2012 21:56:06 -0800
Message-ID: <1329458170-22119-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12633103A48
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In order to allow us to do something smarter than iterate through widgets
doing strcmp() to work out what to power up for stream events change the
interface used to generate them to be based on the combination of a DAI
and a stream direction rather than just a simple string identifying the
stream.

At some point we'll probably want a set of channels too.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    4 ++--
 sound/soc/soc-core.c     |   30 ++++++++++++++++--------------
 sound/soc/soc-dapm.c     |   25 ++++++++++++++++---------
 sound/soc/soc-pcm.c      |   25 +++++++++----------------
 4 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c28d20b..c32c521 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -365,8 +365,8 @@ int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
-	const char *stream, int event);
+int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+			      struct snd_soc_dai *dai, int event);
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* external DAPM widget events */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 09b8fde..87a3c5c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -573,18 +573,20 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai_driver *driver = card->rtd[i].codec_dai->driver;
+		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (driver->playback.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->playback.stream_name,
-				SND_SOC_DAPM_STREAM_SUSPEND);
+		snd_soc_dapm_stream_event(&card->rtd[i],
+					  SNDRV_PCM_STREAM_PLAYBACK,
+					  codec_dai,
+					  SND_SOC_DAPM_STREAM_SUSPEND);
 
-		if (driver->capture.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->capture.stream_name,
-				SND_SOC_DAPM_STREAM_SUSPEND);
+		snd_soc_dapm_stream_event(&card->rtd[i],
+					  SNDRV_PCM_STREAM_CAPTURE,
+					  codec_dai,
+					  SND_SOC_DAPM_STREAM_SUSPEND);
 	}
 
 	/* suspend all CODECs */
@@ -687,18 +689,18 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai_driver *driver = card->rtd[i].codec_dai->driver;
+		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (driver->playback.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->playback.stream_name,
-				SND_SOC_DAPM_STREAM_RESUME);
+		snd_soc_dapm_stream_event(&card->rtd[i],
+					  SNDRV_PCM_STREAM_PLAYBACK, codec_dai,
+					  SND_SOC_DAPM_STREAM_RESUME);
 
-		if (driver->capture.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->capture.stream_name,
-				SND_SOC_DAPM_STREAM_RESUME);
+		snd_soc_dapm_stream_event(&card->rtd[i],
+					  SNDRV_PCM_STREAM_CAPTURE, codec_dai,
+					  SND_SOC_DAPM_STREAM_RESUME);
 	}
 
 	/* unmute any active DACs */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index bfaa9d2..21c7b31 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2826,17 +2826,27 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
 static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
-	const char *stream, int event)
+				  int stream, struct snd_soc_dai *dai,
+				  int event)
 {
 	struct snd_soc_dapm_widget *w;
+	const char *stream_name;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream_name = dai->driver->playback.stream_name;
+	else
+		stream_name = dai->driver->capture.stream_name;
+
+	if (!stream_name)
+		return;
 
 	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
 		if (!w->sname || w->dapm != dapm)
 			continue;
 		dev_vdbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
-			w->name, w->sname, stream, event);
-		if (strstr(w->sname, stream)) {
+			w->name, w->sname, stream_name, event);
+		if (strstr(w->sname, stream_name)) {
 			dapm_mark_dirty(w, "stream event");
 			switch(event) {
 			case SND_SOC_DAPM_STREAM_START:
@@ -2868,16 +2878,13 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
-	const char *stream, int event)
+int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+			      struct snd_soc_dai *dai, int event)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 
-	if (stream == NULL)
-		return 0;
-
 	mutex_lock(&codec->mutex);
-	soc_dapm_stream_event(&codec->dapm, stream, event);
+	soc_dapm_stream_event(&codec->dapm, stream, dai, event);
 	mutex_unlock(&codec->mutex);
 	return 0;
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d7bb268..2896904 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -307,9 +307,8 @@ static void close_delayed_work(struct work_struct *work)
 	/* are we waiting on this codec DAI stream */
 	if (codec_dai->pop_wait == 1) {
 		codec_dai->pop_wait = 0;
-		snd_soc_dapm_stream_event(rtd,
-			codec_dai->driver->playback.stream_name,
-			SND_SOC_DAPM_STREAM_STOP);
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+					  codec_dai, SND_SOC_DAPM_STREAM_STOP);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -373,8 +372,9 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		    rtd->dai_link->ignore_pmdown_time) {
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
-				codec_dai->driver->playback.stream_name,
-				SND_SOC_DAPM_STREAM_STOP);
+						  SNDRV_PCM_STREAM_PLAYBACK,
+						  codec_dai,
+						  SND_SOC_DAPM_STREAM_STOP);
 		} else {
 			/* start delayed pop wq here for playback streams */
 			codec_dai->pop_wait = 1;
@@ -383,9 +383,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		}
 	} else {
 		/* capture streams can be powered down now */
-		snd_soc_dapm_stream_event(rtd,
-			codec_dai->driver->capture.stream_name,
-			SND_SOC_DAPM_STREAM_STOP);
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
+					  codec_dai, SND_SOC_DAPM_STREAM_STOP);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -454,14 +453,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		cancel_delayed_work(&rtd->delayed_work);
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_dapm_stream_event(rtd,
-					  codec_dai->driver->playback.stream_name,
-					  SND_SOC_DAPM_STREAM_START);
-	else
-		snd_soc_dapm_stream_event(rtd,
-					  codec_dai->driver->capture.stream_name,
-					  SND_SOC_DAPM_STREAM_START);
+	snd_soc_dapm_stream_event(rtd, substream->stream, codec_dai,
+				  SND_SOC_DAPM_STREAM_START);
 
 	snd_soc_dai_digital_mute(codec_dai, 0);
 
-- 
1.7.9.rc1
