From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Only power up active channels
	from a DAI" to the asoc tree
Date: Sat,  2 Feb 2019 16:18:00 +0000 (GMT)
Message-ID: <20190202161800.BEBC9440083@finisterre.ee.mobilebroadband>
References: <20190131133019.1965-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E33267477
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:02 +0100 (CET)
In-Reply-To: <20190131133019.1965-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Only power up active channels from a DAI

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

>From 078a85f2806f0ffd11289009462a6a390f9adb5c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 31 Jan 2019 13:30:18 +0000
Subject: [PATCH] ASoC: dapm: Only power up active channels from a DAI

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 22 +++++++-----
 sound/soc/soc-dapm.c     | 76 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-pcm.c      |  4 +++
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 46f2ba3ffcb7..79b4ddfb8e9e 100644
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
index e71cd5b660ad..36d964a52874 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2541,6 +2541,78 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
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
@@ -3706,6 +3778,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			ret = soc_dai_hw_params(&substream, params, source);
 			if (ret < 0)
 				goto out;
+
+			dapm_update_dai_unlocked(&substream, params, source);
 		}
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -3726,6 +3800,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			ret = soc_dai_hw_params(&substream, params, sink);
 			if (ret < 0)
 				goto out;
+
+			dapm_update_dai_unlocked(&substream, params, sink);
 		}
 		break;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 03f36e534050..a5b40e82dea4 100644
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
2.20.1
