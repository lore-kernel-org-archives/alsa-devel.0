From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: dapm: Only power up active channels
	from a DAI
Date: Thu, 31 Jan 2019 13:30:18 +0000
Message-ID: <20190131133019.1965-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DE821267448
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 14:30:24 +0100 (CET)
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

Currently all widgets attached to a DAI link will be powered
up when the DAI is active, however this may include routes
that are not actually in use if there are unused channels
available on the DAI.

The macros for creating AIF widgets already include an entry for
slot, it is proposed to change that to channel. The effective
difference here being respresenting the logical channel index
rather than the physical slot index. The CODECs currently
using the slot entry on the DAPM_AIF macros are using it in
a manner consistent with this, the CODECs not using it just
have the field set to zero.

A variable is added to snd_soc_dapm_widget to represent
this channel index and then for each AIF widget attached to
a DAI this is compared against the number of channels on
the stream. Enabling the links for those which will be in
use. This has the nice property that the CODECs which haven't
used the slot/channel entry in the macro will function exactly
as before due to all the AIF widgets having a channel of zero
and a stream by definition having at least one channel.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-dapm.h | 22 +++++++++-----
 sound/soc/soc-dapm.c     | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-pcm.c      |  4 +++
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 46f2ba3ffcb7c..79b4ddfb8e9e2 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -214,21 +214,21 @@ struct device;
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD}
 
 /* stream domain */
-#define SND_SOC_DAPM_AIF_IN(wname, stname, wslot, wreg, wshift, winvert) \
+#define SND_SOC_DAPM_AIF_IN(wname, stname, wchan, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
-#define SND_SOC_DAPM_AIF_IN_E(wname, stname, wslot, wreg, wshift, winvert, \
+	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
+#define SND_SOC_DAPM_AIF_IN_E(wname, stname, wchan, wreg, wshift, winvert, \
 			      wevent, wflags)				\
 {	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags }
-#define SND_SOC_DAPM_AIF_OUT(wname, stname, wslot, wreg, wshift, winvert) \
+#define SND_SOC_DAPM_AIF_OUT(wname, stname, wchan, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
-#define SND_SOC_DAPM_AIF_OUT_E(wname, stname, wslot, wreg, wshift, winvert, \
+	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
+#define SND_SOC_DAPM_AIF_OUT_E(wname, stname, wchan, wreg, wshift, winvert, \
 			     wevent, wflags)				\
 {	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.channel = wchan, SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
@@ -407,6 +407,10 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
+int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai);
+
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
@@ -627,6 +631,8 @@ struct snd_soc_dapm_widget {
 	int endpoints[2];
 
 	struct clk *clk;
+
+	int channel;
 };
 
 struct snd_soc_dapm_update {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c4c134195392..1714f612451e1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2525,6 +2525,78 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
+static int dapm_update_dai_chan(struct snd_soc_dapm_path *p,
+				struct snd_soc_dapm_widget *w,
+				int channels)
+{
+	switch (w->id) {
+	case snd_soc_dapm_aif_out:
+	case snd_soc_dapm_aif_in:
+		break;
+	default:
+		return 0;
+	}
+
+	dev_dbg(w->dapm->dev, "%s DAI route %s -> %s\n",
+		w->channel < channels ? "Connecting" : "Disconnecting",
+		p->source->name, p->sink->name);
+
+	if (w->channel < channels)
+		soc_dapm_connect_path(p, true, "dai update");
+	else
+		soc_dapm_connect_path(p, false, "dai update");
+
+	return 0;
+}
+
+static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	int dir = substream->stream;
+	int channels = params_channels(params);
+	struct snd_soc_dapm_path *p;
+	struct snd_soc_dapm_widget *w;
+	int ret;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		w = dai->playback_widget;
+	else
+		w = dai->capture_widget;
+
+	dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
+		dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
+
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
+		ret = dapm_update_dai_chan(p, p->sink, channels);
+		if (ret < 0)
+			return ret;
+	}
+
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
+		ret = dapm_update_dai_chan(p, p->source, channels);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int ret;
+
+	mutex_lock_nested(&rtd->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	ret = dapm_update_dai_unlocked(substream, params, dai);
+	mutex_unlock(&rtd->card->dapm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_update_dai);
+
 /*
  * dapm_update_widget_flags() - Re-compute widget sink and source flags
  * @w: The widget for which to update the flags
@@ -3689,6 +3761,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			ret = soc_dai_hw_params(&substream, params, source);
 			if (ret < 0)
 				goto out;
+
+			dapm_update_dai_unlocked(&substream, params, source);
 		}
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -3709,6 +3783,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			ret = soc_dai_hw_params(&substream, params, sink);
 			if (ret < 0)
 				goto out;
+
+			dapm_update_dai_unlocked(&substream, params, sink);
 		}
 		break;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 03f36e534050f..a5b40e82dea4a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -969,6 +969,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		codec_dai->channels = params_channels(&codec_params);
 		codec_dai->sample_bits = snd_pcm_format_physical_width(
 						params_format(&codec_params));
+
+		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
 	}
 
 	ret = soc_dai_hw_params(substream, params, cpu_dai);
@@ -998,6 +1000,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	cpu_dai->sample_bits =
 		snd_pcm_format_physical_width(params_format(params));
 
+	snd_soc_dapm_update_dai(substream, params, cpu_dai);
+
 	ret = soc_pcm_params_symmetry(substream, params);
         if (ret)
 		goto component_err;
-- 
2.11.0
