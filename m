From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/2] ASoC: core - Add direct mapping between
	DAIs and DAPM
Date: Wed, 15 Feb 2012 16:02:54 +0000
Message-ID: <1329321775-21082-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A5A3103E72
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 17:10:10 +0100 (CET)
Received: by wics10 with SMTP id s10so826153wic.33
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 08:09:25 -0800 (PST)
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

Currently we map DAI streams to DAPM widgets based on a string stream name.
This can lead to some limitations when working with lots of DAI links as there
is a risk of naming collision with similar stream names.

This patch creates a 1:N mapping between a DAI and it's DAPM widgets. It's
still string based, but we now directly reference the widget names with
the DAI and bind the DAI to the widget ptrs at initialisation. The binding
also tales into consideration the parent codec or platform that the DAI and
widget belong to so that we can easily support multiple components with
the same widget names.

This patch still works in conjunction with the stream based events, but it
is intended to eventually replace the DAI stream name.

e.g. to map twl6040 headset DACs to headset DAI

static const char *headset_widgets[] = {"HSDAC Left", "HSDAC Right"};

static struct snd_soc_dai_driver twl6040_dai[] = {
...
{
	.name = "twl6040-dl1",
	.playback = {
		.stream_name = "Headset Playback",
		.channel_widgets = headset_widgets,
		.channels_min = 1,
		.channels_max = ARRAY_SIZE(headset_widgets),
		.rates = TWL6040_RATES,
		.formats = TWL6040_FORMATS,
	},
	.ops = &twl6040_dai_ops,
},

This patch will allow DAI connection to any widget type as not all DAIs connect
directly to DACs or ADCs, some can connect via a mux that can swap channels etc.

This patch is also intended to be the starting point for future DAPM channel
mapping support as we now have a direct link between PCMs and DAPM widgets.
e.g. In the example above we map channel 0 (left) to "HSDAC Left" and channel 1
(right) to "HSDAC Right".

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dai.h |   11 ++-
 include/sound/soc.h     |    1 +
 sound/soc/soc-core.c    |   42 +++++++++++++
 sound/soc/soc-dapm.c    |  155 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2413acc..ce5beea 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -246,14 +246,17 @@ struct snd_soc_dai {
 	unsigned int rate;
 
 	/* parent platform/codec */
-	union {
-		struct snd_soc_platform *platform;
-		struct snd_soc_codec *codec;
-	};
+	struct snd_soc_platform *platform;
+	struct snd_soc_codec *codec;
 	struct snd_soc_card *card;
 
 	struct list_head list;
 	struct list_head card_list;
+
+	/* runtime widgets */
+	struct snd_soc_dapm_widget **playback_widgets;
+	struct snd_soc_dapm_widget **capture_widgets;
+	bool dapm_bind_complete;
 };
 
 static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8fa4dca..bace9b8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -507,6 +507,7 @@ struct snd_soc_pcm_stream {
 	unsigned int rates;		/* SNDRV_PCM_RATE_* */
 	unsigned int rate_min;		/* min rate */
 	unsigned int rate_max;		/* max rate */
+	const char **channel_widgets;	/* DAPM channel widget names */
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
 	unsigned int sig_bits;		/* number of bits of content */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6bad7cd..733f5de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -68,6 +68,8 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
+int dapm_bind_dai_widgets(struct snd_soc_dai *dai, int stream);
+
 /* returns the minimum number of bytes needed to represent
  * a particular given value */
 static int min_bytes_needed(unsigned long val)
@@ -1392,6 +1394,41 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static int soc_init_card_dai_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_dai *dai;
+	int ret = 0;
+
+	list_for_each_entry(dai, &card->dai_dev_list, card_list) {
+
+		/* only process DAIs that use the new API until
+		 * the old "stream name" API is fully deprecated */
+		if (!dai->driver->playback.channel_widgets &&
+			!dai->driver->capture.channel_widgets)
+			continue;
+
+		/* skip if already instanciated */
+		if (dai->dapm_bind_complete)
+			continue;
+
+		/* bind DAI widget name to component widget */
+		if (dai->driver->playback.channels_max) {
+			ret = dapm_bind_dai_widgets(dai, SNDRV_PCM_STREAM_PLAYBACK);
+			if (ret < 0)
+				return ret;
+		}
+		if (dai->driver->capture.channels_max) {
+			ret = dapm_bind_dai_widgets(dai, SNDRV_PCM_STREAM_CAPTURE);
+			if (ret < 0)
+				return ret;
+		}
+
+		dai->dapm_bind_complete = 1;
+	}
+
+	return ret;
+}
+
 static void snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
@@ -1556,6 +1593,9 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	snd_soc_dapm_new_widgets(&card->dapm);
+	ret = soc_init_card_dai_widgets(card);
+	if (ret < 0)
+		goto probe_aux_dev_err;
 
 	if (card->fully_routed)
 		list_for_each_entry(codec, &card->codec_dev_list, card_list)
@@ -3139,6 +3179,8 @@ found:
 
 	pr_debug("Unregistered DAI '%s'\n", dai->name);
 	kfree(dai->name);
+	kfree(dai->playback_widgets);
+	kfree(dai->capture_widgets);
 	kfree(dai);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_dai);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 63a5614..5f99842 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -829,6 +829,161 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	return con;
 }
 
+static struct snd_soc_dapm_widget *
+	dapm_get_codec_widget(struct snd_soc_codec *codec, const char *name)
+{
+	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_widget *w;
+
+	/* find widget for this codec and widget name */
+	list_for_each_entry(w, &card->widgets, list) {
+
+		/* make sure the widget belongs to the DAI codec  */
+		if (w->codec && w->codec != codec)
+			continue;
+
+		if (!strcmp(w->name, name))
+			return w;
+	}
+
+	return NULL;
+}
+
+static struct snd_soc_dapm_widget *
+	dapm_get_platform_widget(struct snd_soc_platform *platform,
+	const char *name)
+{
+	struct snd_soc_card *card = platform->card;
+	struct snd_soc_dapm_widget *w;
+
+	/* find widget for this platform and widget name */
+	list_for_each_entry(w, &card->widgets, list) {
+
+		/* make sure the widget belongs to the DAI platform */
+		if (w->platform && w->platform != platform)
+			continue;
+
+		if (!strcmp(w->name, name))
+			return w;
+	}
+
+	return NULL;
+}
+
+int dapm_bind_dai_playback_widgets(struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = dai->card;
+	struct snd_soc_dapm_widget *w = NULL;
+	const char *widget_name;
+	int i;
+
+	if (!dai->driver->playback.channel_widgets)
+		return 0;
+
+	dai->playback_widgets =
+			kzalloc(sizeof(struct snd_soc_dapm_widget *) *
+			dai->driver->playback.channels_max, GFP_KERNEL);
+	if (!dai->playback_widgets)
+		return -ENOMEM;
+
+	for (i = 0; i < dai->driver->playback.channels_max; i++) {
+		widget_name = dai->driver->playback.channel_widgets[i];
+
+		if (dai->codec) {
+			struct snd_soc_codec *codec;
+
+			list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+				w = dapm_get_codec_widget(codec, widget_name);
+				if (w) {
+					dev_dbg(dai->dev, "bind %s to %s\n", w->name, codec->name);
+					break;
+				}
+			}
+		} else if (dai->platform) {
+			struct snd_soc_platform *platform;
+
+			list_for_each_entry(platform, &card->platform_dev_list, card_list) {
+				w = dapm_get_platform_widget(platform, widget_name);
+				if (w) {
+					dev_dbg(dai->dev, "bind %s to %s\n", w->name, platform->name);
+					break;
+				}
+			}
+		}
+
+		if (w)
+			dai->playback_widgets[i] = w;
+		else {
+			dev_err(dai->dev, "unable to find playback DAI AIF %s\n",
+					widget_name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int dapm_bind_dai_capture_widgets(struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = dai->card;
+	struct snd_soc_dapm_widget *w = NULL;
+	const char *widget_name;
+	int i;
+
+	if (!dai->driver->capture.channel_widgets)
+		return 0;
+
+	dai->capture_widgets =
+			kzalloc(sizeof(struct snd_soc_dapm_widget *) *
+			dai->driver->capture.channels_max, GFP_KERNEL);
+	if (!dai->capture_widgets)
+		return -ENOMEM;
+
+	for (i = 0; i < dai->driver->capture.channels_max; i++) {
+		widget_name = dai->driver->capture.channel_widgets[i];
+
+		if (dai->codec) {
+			struct snd_soc_codec *codec;
+
+			list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+				w = dapm_get_codec_widget(codec, widget_name);
+				if (w) {
+					dev_dbg(dai->dev, "bind %s to %s\n", w->name, codec->name);
+					break;
+				}
+			}
+		} else if (dai->platform) {
+			struct snd_soc_platform *platform;
+
+			list_for_each_entry(platform, &card->platform_dev_list, card_list) {
+				w = dapm_get_platform_widget(platform, widget_name);
+				if (w) {
+					dev_dbg(dai->dev, "bind %s to %s\n", w->name, platform->name);
+					break;
+				}
+			}
+		}
+
+		if (w)
+			dai->capture_widgets[i] = w;
+		else {
+			dev_err(dai->dev, "unable to find playback DAI AIF %s\n",
+					widget_name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int dapm_bind_dai_widgets(struct snd_soc_dai *dai, int stream)
+{
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return dapm_bind_dai_playback_widgets(dai);
+	else
+		return dapm_bind_dai_capture_widgets(dai);
+}
+
 /*
  * Handler for generic register modifier widget.
  */
-- 
1.7.5.4
