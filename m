From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/2] ASoC: core - Add support for direct DAI ->
	widget mapping stream events.
Date: Wed, 15 Feb 2012 16:02:55 +0000
Message-ID: <1329321775-21082-2-git-send-email-lrg@ti.com>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71]) by alsa0.perex.cz (Postfix) with SMTP id 7AB5D103E72
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 17:03:22 +0100 (CET)
Received: by mail-we0-f174.google.com with SMTP id b13so716846wer.19
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 08:03:03 -0800 (PST)
In-Reply-To: <1329321775-21082-1-git-send-email-lrg@ti.com>
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

Currently a DAPM stream event is strstr() matched on the DAI stream name
and the card widget names. This has some performance and naming scope
limitations for larger and more modern sound cards.

This patch adds the capability to perform a stream event based upon the new
DAI widget pointers if they exist and modifies snd_soc_dapm_stream_event() by
removing the stream name and adding the stream direction and power widgets
parameters.

void snd_soc_dapm_rtd_stream_event(struct snd_soc_pcm_runtime *rtd,
	int stream, int event, int power_widgets);

The stream event now checks whether the RTD DAIs have widget pointers and if
so will perfiorm a stream event using the widget pointers. If no widget pointer
is found then it reverts to the existing stream event logic to guarantee correct
operation for existing drivers.

The "power widgets" parameter will only walk the DAPM graph and power the
widgets when true. This allows the dynamic PCM core to coalesce several
stream events togother.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    4 +-
 sound/soc/soc-core.c     |   22 +++-----
 sound/soc/soc-dapm.c     |  133 +++++++++++++++++++++++++++++++++++++++++----
 sound/soc/soc-pcm.c      |   25 ++++-----
 4 files changed, 141 insertions(+), 43 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index db8435a..21b3b06 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -367,8 +367,8 @@ int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
-	const char *stream, int event);
+void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+	int event, int power);
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* external DAPM widget events */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 733f5de..1423a01 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -575,18 +575,15 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai_driver *driver = card->rtd[i].codec_dai->driver;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (driver->playback.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->playback.stream_name,
-				SND_SOC_DAPM_STREAM_SUSPEND);
+		snd_soc_dapm_stream_event(&card->rtd[i], SNDRV_PCM_STREAM_PLAYBACK,
+				SND_SOC_DAPM_STREAM_SUSPEND, 0);
 
-		if (driver->capture.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->capture.stream_name,
-				SND_SOC_DAPM_STREAM_SUSPEND);
+		snd_soc_dapm_stream_event(&card->rtd[i], SNDRV_PCM_STREAM_CAPTURE,
+				SND_SOC_DAPM_STREAM_SUSPEND, 1);
 	}
 
 	/* suspend all CODECs */
@@ -689,18 +686,15 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai_driver *driver = card->rtd[i].codec_dai->driver;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (driver->playback.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->playback.stream_name,
-				SND_SOC_DAPM_STREAM_RESUME);
+		snd_soc_dapm_stream_event(&card->rtd[i], SNDRV_PCM_STREAM_PLAYBACK,
+				SND_SOC_DAPM_STREAM_RESUME, 0);
 
-		if (driver->capture.stream_name != NULL)
-			snd_soc_dapm_stream_event(&card->rtd[i], driver->capture.stream_name,
-				SND_SOC_DAPM_STREAM_RESUME);
+		snd_soc_dapm_stream_event(&card->rtd[i], SNDRV_PCM_STREAM_CAPTURE,
+				SND_SOC_DAPM_STREAM_RESUME, 1);
 	}
 
 	/* unmute any active DACs */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5f99842..27f7858f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3017,29 +3017,138 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	dapm_power_widgets(dapm, event);
 }
 
+static void widget_playback_stream_update(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dai *dai, int event)
+{
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	if (!dai->playback_widgets)
+		return;
+
+	for (i = 0; i < dai->driver->playback.channels_max; i++) {
+		w = dai->playback_widgets[i];
+
+		if (!w)
+			return;
+
+		dapm_mark_dirty(w, "stream event");
+
+		switch(event) {
+		case SND_SOC_DAPM_STREAM_START:
+			w->active = 1;
+			break;
+		case SND_SOC_DAPM_STREAM_STOP:
+			w->active = 0;
+			break;
+		case SND_SOC_DAPM_STREAM_SUSPEND:
+		case SND_SOC_DAPM_STREAM_RESUME:
+		case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
+		case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
+			break;
+		}
+	}
+}
+
+static void widget_capture_stream_update(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dai *dai, int event)
+{
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	if (!dai->capture_widgets)
+		return;
+
+	for (i = 0; i < dai->driver->capture.channels_max; i++) {
+		w = dai->capture_widgets[i];
+
+		if (!w)
+			return;
+
+		dapm_mark_dirty(w, "stream event");
+
+		switch(event) {
+		case SND_SOC_DAPM_STREAM_START:
+			w->active = 1;
+			break;
+		case SND_SOC_DAPM_STREAM_STOP:
+			w->active = 0;
+			break;
+		case SND_SOC_DAPM_STREAM_SUSPEND:
+		case SND_SOC_DAPM_STREAM_RESUME:
+		case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
+		case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
+			break;
+		}
+	}
+}
+
+static void soc_dapm_rtd_stream_event(struct snd_soc_pcm_runtime *rtd,
+	int stream, int event, int power_widgets)
+{
+	struct snd_soc_dapm_context *platform_dapm = &rtd->platform->dapm;
+	struct snd_soc_dapm_context *codec_dapm = &rtd->codec->dapm;
+
+	dev_dbg(rtd->dev, "dai link stream %d event %d\n", stream, event);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		widget_playback_stream_update(platform_dapm, rtd->cpu_dai, event);
+		widget_playback_stream_update(codec_dapm, rtd->codec_dai, event);
+	} else {
+		widget_capture_stream_update(platform_dapm, rtd->cpu_dai, event);
+		widget_capture_stream_update(codec_dapm, rtd->codec_dai, event);
+	}
+
+	if (power_widgets)
+		dapm_power_widgets(codec_dapm, event);
+}
+
+/* legacy strstr() based stream event - now deprecated */
+static int soc_dapm_stream_event_str(struct snd_soc_pcm_runtime *rtd,
+	int event)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	const char *stream = rtd->codec_dai->driver->playback.stream_name;
+
+	if (stream == NULL)
+		return 0;
+
+	mutex_lock(&codec->mutex);
+	soc_dapm_stream_event(&codec->dapm, stream, event);
+	mutex_unlock(&codec->mutex);
+	return 0;
+}
+
 /**
  * snd_soc_dapm_stream_event - send a stream event to the dapm core
  * @rtd: PCM runtime data
- * @stream: stream name
+ * @stream: stream direction
  * @event: stream event
  *
+ * This function support both widget based and the deprecated string based
+ * stream events. The intention is to eventually remove the deprecated string
+ * support.
+ *
  * Sends a stream event to the dapm core. The core then makes any
  * necessary widget power changes.
- *
- * Returns 0 for success else error.
  */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
-	const char *stream, int event)
+void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
+	int event, int power)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 
-	if (stream == NULL)
-		return 0;
+		if (rtd->cpu_dai->playback_widgets && rtd->codec_dai->playback_widgets)
+			soc_dapm_rtd_stream_event(rtd, stream, event, power);
+		else
+			soc_dapm_stream_event_str(rtd, event);
 
-	mutex_lock(&codec->mutex);
-	soc_dapm_stream_event(&codec->dapm, stream, event);
-	mutex_unlock(&codec->mutex);
-	return 0;
+	} else {
+
+		if (rtd->cpu_dai->capture_widgets && rtd->codec_dai->capture_widgets)
+			soc_dapm_rtd_stream_event(rtd, stream, event, power);
+		else
+			soc_dapm_stream_event_str(rtd, event);
+	}
 }
 
 /**
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 15816ec..4cd8eee 100644
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
+			SND_SOC_DAPM_STREAM_STOP, 1);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -372,9 +371,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
 		    rtd->dai_link->ignore_pmdown_time) {
 			/* powered down playback stream now */
-			snd_soc_dapm_stream_event(rtd,
-				codec_dai->driver->playback.stream_name,
-				SND_SOC_DAPM_STREAM_STOP);
+			snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+				SND_SOC_DAPM_STREAM_STOP, 1);
 		} else {
 			/* start delayed pop wq here for playback streams */
 			codec_dai->pop_wait = 1;
@@ -383,9 +381,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		}
 	} else {
 		/* capture streams can be powered down now */
-		snd_soc_dapm_stream_event(rtd,
-			codec_dai->driver->capture.stream_name,
-			SND_SOC_DAPM_STREAM_STOP);
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
+			SND_SOC_DAPM_STREAM_STOP, 1);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -455,13 +452,11 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_dapm_stream_event(rtd,
-					  codec_dai->driver->playback.stream_name,
-					  SND_SOC_DAPM_STREAM_START);
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+					  SND_SOC_DAPM_STREAM_START, 1);
 	else
-		snd_soc_dapm_stream_event(rtd,
-					  codec_dai->driver->capture.stream_name,
-					  SND_SOC_DAPM_STREAM_START);
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
+					  SND_SOC_DAPM_STREAM_START, 1);
 
 	snd_soc_dai_digital_mute(codec_dai, 0);
 
-- 
1.7.5.4
