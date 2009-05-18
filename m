From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Integrate bias management with DAPM
	power management
Date: Mon, 18 May 2009 16:05:57 +0100
Message-ID: <1242659158-1701-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47E8324469
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:06:10 +0200 (CEST)
In-Reply-To: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Rather than managing the bias level of the system based on if there is
an active audio stream manage it based on there being an active DAPM
widget. This simplifies the code a little, moving the power handling
into one place, and improves audio performance for bypass paths when no
playbacks or captures are active.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 -
 include/sound/soc.h      |    1 +
 sound/soc/soc-core.c     |   61 ++++++------------------------------
 sound/soc/soc-dapm.c     |   78 +++++++++++++++++++++++++++++++--------------
 4 files changed, 65 insertions(+), 77 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index b3f789d..ec8a45f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -279,8 +279,6 @@ int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
 	int event);
-int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
-	enum snd_soc_bias_level level);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8309ce8..2af3213 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -339,6 +339,7 @@ struct snd_soc_codec {
 	struct module *owner;
 	struct mutex mutex;
 	struct device *dev;
+	struct snd_soc_device *socdev;
 
 	struct list_head list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0e7066..4aa8e2d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -299,7 +299,6 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_card *card = container_of(work, struct snd_soc_card,
 						 delayed_work.work);
-	struct snd_soc_device *socdev = card->socdev;
 	struct snd_soc_codec *codec = card->codec;
 	struct snd_soc_dai *codec_dai;
 	int i;
@@ -315,27 +314,10 @@ static void close_delayed_work(struct work_struct *work)
 
 		/* are we waiting on this codec DAI stream */
 		if (codec_dai->pop_wait == 1) {
-
-			/* Reduce power if no longer active */
-			if (codec->active == 0) {
-				pr_debug("pop wq D1 %s %s\n", codec->name,
-					 codec_dai->playback.stream_name);
-				snd_soc_dapm_set_bias_level(socdev,
-					SND_SOC_BIAS_PREPARE);
-			}
-
 			codec_dai->pop_wait = 0;
 			snd_soc_dapm_stream_event(codec,
 				codec_dai->playback.stream_name,
 				SND_SOC_DAPM_STREAM_STOP);
-
-			/* Fall into standby if no longer active */
-			if (codec->active == 0) {
-				pr_debug("pop wq D3 %s %s\n", codec->name,
-					 codec_dai->playback.stream_name);
-				snd_soc_dapm_set_bias_level(socdev,
-					SND_SOC_BIAS_STANDBY);
-			}
 		}
 	}
 	mutex_unlock(&pcm_mutex);
@@ -399,10 +381,6 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 		snd_soc_dapm_stream_event(codec,
 			codec_dai->capture.stream_name,
 			SND_SOC_DAPM_STREAM_STOP);
-
-		if (codec->active == 0 && codec_dai->pop_wait == 0)
-			snd_soc_dapm_set_bias_level(socdev,
-						SND_SOC_BIAS_STANDBY);
 	}
 
 	mutex_unlock(&pcm_mutex);
@@ -467,36 +445,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		cancel_delayed_work(&card->delayed_work);
 	}
 
-	/* do we need to power up codec */
-	if (codec->bias_level != SND_SOC_BIAS_ON) {
-		snd_soc_dapm_set_bias_level(socdev,
-					    SND_SOC_BIAS_PREPARE);
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			snd_soc_dapm_stream_event(codec,
-					codec_dai->playback.stream_name,
-					SND_SOC_DAPM_STREAM_START);
-		else
-			snd_soc_dapm_stream_event(codec,
-					codec_dai->capture.stream_name,
-					SND_SOC_DAPM_STREAM_START);
-
-		snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_ON);
-		snd_soc_dai_digital_mute(codec_dai, 0);
-
-	} else {
-		/* codec already powered - power on widgets */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			snd_soc_dapm_stream_event(codec,
-					codec_dai->playback.stream_name,
-					SND_SOC_DAPM_STREAM_START);
-		else
-			snd_soc_dapm_stream_event(codec,
-					codec_dai->capture.stream_name,
-					SND_SOC_DAPM_STREAM_START);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_dapm_stream_event(codec,
+					  codec_dai->playback.stream_name,
+					  SND_SOC_DAPM_STREAM_START);
+	else
+		snd_soc_dapm_stream_event(codec,
+					  codec_dai->capture.stream_name,
+					  SND_SOC_DAPM_STREAM_START);
 
-		snd_soc_dai_digital_mute(codec_dai, 0);
-	}
+	snd_soc_dai_digital_mute(codec_dai, 0);
 
 out:
 	mutex_unlock(&pcm_mutex);
@@ -1372,6 +1330,7 @@ int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 		return ret;
 	}
 
+	codec->socdev = socdev;
 	codec->card->dev = socdev->dev;
 	codec->card->private_data = codec;
 	strncpy(codec->card->driver, codec->name, sizeof(codec->card->driver));
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d130602..4ca5e56 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -94,6 +94,30 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
+/**
+ * snd_soc_dapm_set_bias_level - set the bias level for the system
+ * @socdev: audio device
+ * @level: level to configure
+ *
+ * Configure the bias (power) levels for the SoC audio device.
+ *
+ * Returns 0 for success else error.
+ */
+static int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
+				       enum snd_soc_bias_level level)
+{
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret = 0;
+
+	if (card->set_bias_level)
+		ret = card->set_bias_level(card, level);
+	if (ret == 0 && codec->set_bias_level)
+		ret = codec->set_bias_level(codec, level);
+
+	return ret;
+}
+
 /* set up initial codec paths */
 static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_path *p, int i)
@@ -707,9 +731,11 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
  */
 static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 {
+	struct snd_soc_device *socdev = codec->socdev;
 	struct snd_soc_dapm_widget *w;
 	int ret = 0;
 	int i, power;
+	int sys_power = 0;
 
 	INIT_LIST_HEAD(&codec->up_list);
 	INIT_LIST_HEAD(&codec->down_list);
@@ -731,6 +757,9 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 				continue;
 
 			power = w->power_check(w);
+			if (power)
+				sys_power = 1;
+
 			if (w->power == power)
 				continue;
 
@@ -745,6 +774,15 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		}
 	}
 
+	/* If we're changing to all on or all off then prepare */
+	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
+	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
+		ret = snd_soc_dapm_set_bias_level(socdev,
+						  SND_SOC_BIAS_PREPARE);
+		if (ret != 0)
+			pr_err("Failed to prepare bias: %d\n", ret);
+	}
+
 	/* Power down widgets first; try to avoid amplifying pops. */
 	for (i = 0; i < ARRAY_SIZE(dapm_down_seq); i++) {
 		list_for_each_entry(w, &codec->down_list, power_list) {
@@ -773,6 +811,22 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		}
 	}
 
+	/* If we just powered the last thing off drop to standby bias */
+	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
+		ret = snd_soc_dapm_set_bias_level(socdev,
+						  SND_SOC_BIAS_STANDBY);
+		if (ret != 0)
+			pr_err("Failed to apply standby bias: %d\n", ret);
+	}
+
+	/* If we just powered up then move to active bias */
+	if (codec->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
+		ret = snd_soc_dapm_set_bias_level(socdev,
+						  SND_SOC_BIAS_ON);
+		if (ret != 0)
+			pr_err("Failed to apply active bias: %d\n", ret);
+	}
+
 	return 0;
 }
 
@@ -1721,30 +1775,6 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
 
 /**
- * snd_soc_dapm_set_bias_level - set the bias level for the system
- * @socdev: audio device
- * @level: level to configure
- *
- * Configure the bias (power) levels for the SoC audio device.
- *
- * Returns 0 for success else error.
- */
-int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
-				enum snd_soc_bias_level level)
-{
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret = 0;
-
-	if (card->set_bias_level)
-		ret = card->set_bias_level(card, level);
-	if (ret == 0 && codec->set_bias_level)
-		ret = codec->set_bias_level(codec, level);
-
-	return ret;
-}
-
-/**
  * snd_soc_dapm_enable_pin - enable pin.
  * @codec: SoC codec
  * @pin: pin name
-- 
1.6.3.1
