From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Support transparent CODEC<->CODEC
	DAI links
Date: Fri, 13 Apr 2012 19:45:04 +0100
Message-ID: <1334342704-21495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBE6F10454E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 20:45:08 +0200 (CEST)
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

Rather than having the user half start a stream but avoid any DMA to
trigger data flow on links which don't pass through the CPU create a
DAPM route between the two DAI widgets using a hw_params configuration
provided by the machine driver with the new 'params' member of the
dai_link struct.  If no configuration is provided in the dai_link then
use the old style even for CODEC<->CODEC links to avoid breaking
systems.

This greatly simplifies the userspace usage of such links, making them
as simple as analogue connections with the stream configuration being
completely transparent to them.

This is achieved by defining a new dai_link widget type which is created
when CODECs are linked and triggering the configuration of the link via
the normal PCM operations from there.  It is expected that the bias
level callbacks will be used for clock configuration.

Currently only the DAI format, rate and channel count can be configured
and currently the only DAI operations which can be called are hw_params
and digital_mute().  This corresponds well to the majority of CODEC
drivers which only use other callbacks for constraint setting but there
is obviously much room for extension here.  We can't simply call
hw_params() on startup as things like the system clocking configuration
may change at runtime and in future it will be desirable to offer some
configurability of the link parameters.

At present we are also restricted to a single DAPM link for the entire
DAI.  Once we have better support for channel mapping it would also be
desirable to extend this feature so that we can propagate per-channel
power state over the link.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    6 ++
 include/sound/soc.h      |    2 +
 sound/soc/soc-core.c     |   43 +++++++++++--
 sound/soc/soc-dapm.c     |  155 +++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 196 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 01e7ad1..bea0c86 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -356,6 +356,10 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
+int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 const struct snd_soc_pcm_stream *params,
+			 struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
@@ -427,6 +431,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
 	snd_soc_dapm_dai,		/* link to DAI structure */
+	snd_soc_dapm_dai_link,		/* link between two DAI structures */
 };
 
 enum snd_soc_dapm_subclass {
@@ -485,6 +490,7 @@ struct snd_soc_dapm_widget {
 
 	void *priv;				/* widget specific data */
 	struct regulator *regulator;		/* attached regulator */
+	const struct snd_soc_pcm_stream *params; /* params for dai links */
 
 	/* dapm control */
 	int reg;				/* negative reg = no direct dapm */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index acb57b8..afc3204 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -761,6 +761,8 @@ struct snd_soc_dai_link {
 	const struct device_node *cpu_dai_of_node;
 	const char *codec_dai_name;
 
+	const struct snd_soc_pcm_stream *params;
+
 	unsigned int dai_fmt;           /* format to set on init */
 
 	/* Keep DAI active over suspend */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 20a15a3..6953ea3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1191,7 +1191,9 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dapm_widget *play_w, *capture_w;
 	int ret;
 
 	dev_dbg(card->dev, "probe %s dai link %d late %d\n",
@@ -1272,12 +1274,39 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 	if (ret < 0)
 		pr_warn("asoc: failed to add pmdown_time sysfs:%d\n", ret);
 
-	/* create the pcm */
-	ret = soc_new_pcm(rtd, num);
-	if (ret < 0) {
-		pr_err("asoc: can't create pcm %s :%d\n",
-				dai_link->stream_name, ret);
-		return ret;
+	if (!dai_link->params) {
+		/* create the pcm */
+		ret = soc_new_pcm(rtd, num);
+		if (ret < 0) {
+			pr_err("asoc: can't create pcm %s :%d\n",
+			       dai_link->stream_name, ret);
+			return ret;
+		}
+	} else {
+		/* link the DAI widgets */
+		play_w = codec_dai->playback_widget;
+		capture_w = cpu_dai->capture_widget;
+		if (play_w && capture_w) {
+			ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+						   capture_w, play_w);
+			if (ret != 0) {
+				dev_err(card->dev, "Can't link %s to %s: %d\n",
+					play_w->name, capture_w->name, ret);
+				return ret;
+			}
+		}
+
+		play_w = cpu_dai->playback_widget;
+		capture_w = codec_dai->capture_widget;
+		if (play_w && capture_w) {
+			ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+						   capture_w, play_w);
+			if (ret != 0) {
+				dev_err(card->dev, "Can't link %s to %s: %d\n",
+					play_w->name, capture_w->name, ret);
+				return ret;
+			}
+		}
 	}
 
 	/* add platform data for AC97 devices */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7c8ff90..69886b6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -52,6 +52,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_supply] = 1,
 	[snd_soc_dapm_regulator_supply] = 1,
 	[snd_soc_dapm_micbias] = 2,
+	[snd_soc_dapm_dai_link] = 2,
 	[snd_soc_dapm_dai] = 3,
 	[snd_soc_dapm_aif_in] = 3,
 	[snd_soc_dapm_aif_out] = 3,
@@ -90,9 +91,10 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai] = 10,
-	[snd_soc_dapm_regulator_supply] = 11,
-	[snd_soc_dapm_supply] = 11,
-	[snd_soc_dapm_post] = 12,
+	[snd_soc_dapm_dai_link] = 11,
+	[snd_soc_dapm_regulator_supply] = 12,
+	[snd_soc_dapm_supply] = 12,
+	[snd_soc_dapm_post] = 13,
 };
 
 static void pop_wait(u32 pop_time)
@@ -396,6 +398,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_spk:
 	case snd_soc_dapm_line:
+	case snd_soc_dapm_dai_link:
 		p->connect = 1;
 	break;
 	/* does affect routing - dynamically connected */
@@ -2081,6 +2084,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai:
+	case snd_soc_dapm_dai_link:
 		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
@@ -2809,6 +2813,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_hp:
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_line:
+	case snd_soc_dapm_dai_link:
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_supply:
@@ -2871,6 +2876,150 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
+static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_dapm_path *source_p, *sink_p;
+	struct snd_soc_dai *source, *sink;
+	const struct snd_soc_pcm_stream *config = w->params;
+	struct snd_pcm_substream substream;
+	struct snd_pcm_hw_params params;
+	u64 fmt;
+	int ret;
+
+	BUG_ON(!config);
+	BUG_ON(list_empty(&w->sources) || list_empty(&w->sinks));
+
+	/* We only support a single source and sink, pick the first */
+	source_p = list_first_entry(&w->sources, struct snd_soc_dapm_path,
+				    list_sink);
+	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
+				  list_source);
+
+	BUG_ON(!source_p || !sink_p);
+	BUG_ON(!sink_p->source || !source_p->sink);
+	BUG_ON(!source_p->source || !sink_p->sink);
+
+	source = source_p->source->priv;
+	sink = sink_p->sink->priv;
+
+	/* Be a little careful as we don't want to overflow the mask array */
+	if (config->formats) {
+		fmt = ffs(config->formats) - 1;
+	} else {
+		dev_warn(w->dapm->dev, "Invalid format %lx specified\n",
+			 config->formats);
+		fmt = 0;
+	}
+
+	/* Currently very limited parameter selection */
+	memset(&params, 0, sizeof(params));
+	snd_mask_set(hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
+
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->min =
+		config->rate_min;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->max =
+		config->rate_max;
+
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->min
+		= config->channels_min;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
+		= config->channels_max;
+
+	memset(&substream, 0, sizeof(substream));
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (source->driver->ops && source->driver->ops->hw_params) {
+			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+			ret = source->driver->ops->hw_params(&substream,
+							     &params, source);
+			if (ret != 0) {
+				dev_err(source->dev,
+					"hw_params() failed: %d\n", ret);
+				return ret;
+			}
+		}
+
+		if (sink->driver->ops && sink->driver->ops->hw_params) {
+			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+			ret = sink->driver->ops->hw_params(&substream, &params,
+							   sink);
+			if (ret != 0) {
+				dev_err(sink->dev,
+					"hw_params() failed: %d\n", ret);
+				return ret;
+			}
+		}
+		break;
+
+	case SND_SOC_DAPM_POST_PMU:
+		ret = snd_soc_dai_digital_mute(sink, 0);
+		if (ret != 0 && ret != -ENOTSUPP)
+			dev_warn(sink->dev, "Failed to unmute: %d\n", ret);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		ret = snd_soc_dai_digital_mute(sink, 1);
+		if (ret != 0 && ret != -ENOTSUPP)
+			dev_warn(sink->dev, "Failed to mute: %d\n", ret);
+		break;
+
+	default:
+		BUG();
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 const struct snd_soc_pcm_stream *params,
+			 struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_route routes[2];
+	struct snd_soc_dapm_widget template;
+	struct snd_soc_dapm_widget *w;
+	size_t len;
+	char *link_name;
+
+	len = strlen(source->name) + strlen(sink->name) + 2;
+	link_name = devm_kzalloc(card->dev, len, GFP_KERNEL);
+	if (!link_name)
+		return -ENOMEM;
+	snprintf(link_name, len, "%s-%s", source->name, sink->name);
+
+	memset(&template, 0, sizeof(template));
+	template.reg = SND_SOC_NOPM;
+	template.id = snd_soc_dapm_dai_link;
+	template.name = link_name;
+	template.event = snd_soc_dai_link_event;
+	template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_PRE_PMD;
+
+	dev_dbg(card->dev, "adding %s widget\n", link_name);
+
+	w = snd_soc_dapm_new_control(&card->dapm, &template);
+	if (!w) {
+		dev_err(card->dev, "Failed to create %s widget\n",
+			link_name);
+		return -ENOMEM;
+	}
+
+	w->params = params;
+
+	memset(&routes, 0, sizeof(routes));
+
+	routes[0].source = source->name;
+	routes[0].sink = link_name;
+	routes[1].source = link_name;
+	routes[1].sink = sink->name;
+
+	return snd_soc_dapm_add_routes(&card->dapm, routes,
+				       ARRAY_SIZE(routes));
+}
+
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai)
 {
-- 
1.7.9.1
