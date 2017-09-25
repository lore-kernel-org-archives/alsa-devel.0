From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove unneeded dai->driver->ops check"
	to the asoc tree
Date: Mon, 25 Sep 2017 17:31:19 +0100 (BST)
Message-ID: <20170925163119.97317440052@finisterre.ee.mobilebroadband>
References: <87fubbpnry.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A11C3266EEB
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:04 +0200 (CEST)
In-Reply-To: <87fubbpnry.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove unneeded dai->driver->ops check

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9900a4226c785dbb32c08af5ae8fbbf1fc4c31d0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Sep 2017 01:38:54 +0000
Subject: [PATCH] ASoC: remove unneeded dai->driver->ops check

On soc_add_dai(), it uses null_dai_ops if driver doesn't have
its own ops. This means, dai->driver->ops never been NULL.
dai->driver->ops check is not needed.
This patch removes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c |  8 ++++----
 sound/soc/soc-pcm.c  | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a9bd48..9d4748e2b67a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3681,7 +3681,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-		if (source->driver->ops && source->driver->ops->startup) {
+		if (source->driver->ops->startup) {
 			ret = source->driver->ops->startup(&substream, source);
 			if (ret < 0) {
 				dev_err(source->dev,
@@ -3695,7 +3695,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			goto out;
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-		if (sink->driver->ops && sink->driver->ops->startup) {
+		if (sink->driver->ops->startup) {
 			ret = sink->driver->ops->startup(&substream, sink);
 			if (ret < 0) {
 				dev_err(sink->dev,
@@ -3725,13 +3725,13 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		ret = 0;
 
 		source->active--;
-		if (source->driver->ops && source->driver->ops->shutdown) {
+		if (source->driver->ops->shutdown) {
 			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
 			source->driver->ops->shutdown(&substream, source);
 		}
 
 		sink->active--;
-		if (sink->driver->ops && sink->driver->ops->shutdown) {
+		if (sink->driver->ops->shutdown) {
 			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
 			sink->driver->ops->shutdown(&substream, sink);
 		}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f11421f08065..983edd0e6e8f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -474,7 +474,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	/* startup the audio subsystem */
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->startup) {
+	if (cpu_dai->driver->ops->startup) {
 		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "ASoC: can't open interface"
@@ -494,7 +494,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops && codec_dai->driver->ops->startup) {
+		if (codec_dai->driver->ops->startup) {
 			ret = codec_dai->driver->ops->startup(substream,
 							      codec_dai);
 			if (ret < 0) {
@@ -771,7 +771,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops && codec_dai->driver->ops->prepare) {
+		if (codec_dai->driver->ops->prepare) {
 			ret = codec_dai->driver->ops->prepare(substream,
 							      codec_dai);
 			if (ret < 0) {
@@ -783,7 +783,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->prepare) {
+	if (cpu_dai->driver->ops->prepare) {
 		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev,
@@ -829,7 +829,7 @@ int soc_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	int ret;
 
-	if (dai->driver->ops && dai->driver->ops->hw_params) {
+	if (dai->driver->ops->hw_params) {
 		ret = dai->driver->ops->hw_params(substream, params, dai);
 		if (ret < 0) {
 			dev_err(dai->dev, "ASoC: can't set %s hw params: %d\n",
@@ -934,7 +934,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 
 platform_err:
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
+	if (cpu_dai->driver->ops->hw_free)
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 interface_err:
@@ -943,7 +943,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 codec_err:
 	while (--i >= 0) {
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
 	}
@@ -1004,11 +1004,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	/* now free hw params for the DAIs  */
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 	}
 
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
+	if (cpu_dai->driver->ops->hw_free)
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -1025,7 +1025,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops && codec_dai->driver->ops->trigger) {
+		if (codec_dai->driver->ops->trigger) {
 			ret = codec_dai->driver->ops->trigger(substream,
 							      cmd, codec_dai);
 			if (ret < 0)
@@ -1039,7 +1039,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->trigger) {
+	if (cpu_dai->driver->ops->trigger) {
 		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
 			return ret;
@@ -1064,8 +1064,7 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops &&
-		    codec_dai->driver->ops->bespoke_trigger) {
+		if (codec_dai->driver->ops->bespoke_trigger) {
 			ret = codec_dai->driver->ops->bespoke_trigger(substream,
 								cmd, codec_dai);
 			if (ret < 0)
@@ -1073,7 +1072,7 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->bespoke_trigger) {
+	if (cpu_dai->driver->ops->bespoke_trigger) {
 		ret = cpu_dai->driver->ops->bespoke_trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
 			return ret;
@@ -1100,12 +1099,12 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	if (platform->driver->ops && platform->driver->ops->pointer)
 		offset = platform->driver->ops->pointer(substream);
 
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->delay)
+	if (cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
-		if (codec_dai->driver->ops && codec_dai->driver->ops->delay)
+		if (codec_dai->driver->ops->delay)
 			codec_delay = max(codec_delay,
 					codec_dai->driver->ops->delay(substream,
 								    codec_dai));
-- 
2.14.1
