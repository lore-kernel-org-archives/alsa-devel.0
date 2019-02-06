From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Add helper functions for
	component trigger/set_params" to the asoc tree
Date: Wed,  6 Feb 2019 16:58:12 +0000 (GMT)
Message-ID: <20190206165812.9367E1127EA3@debutante.sirena.org.uk>
References: <20190205111813.28929-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C0D5267945
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:58:14 +0100 (CET)
In-Reply-To: <20190205111813.28929-2-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, vkoul@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Add helper functions for component trigger/set_params

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

>From 4ef0ecb80e348f1888b0c7ebfa8f7c1ec3ed9006 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 5 Feb 2019 11:18:13 +0000
Subject: [PATCH] ASoC: compress: Add helper functions for component
 trigger/set_params

The trigger and set_params callbacks are called from 3 and 2 separate
loops respectively, tidy up the code a little by factoring these out
into helper functions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 117 ++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index fc8742383b23..03d5b9ccd3fc 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -345,17 +345,13 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	return 0;
 }
 
-static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
+static int soc_compr_components_trigger(struct snd_compr_stream *cstream,
+					int cmd)
 {
-
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0;
-
-	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+	int ret;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
@@ -366,9 +362,25 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 
 		ret = component->driver->compr_ops->trigger(cstream, cmd);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
+	return 0;
+}
+
+static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret;
+
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
+	ret = soc_compr_components_trigger(cstream, cmd);
+	if (ret < 0)
+		goto out;
+
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger)
 		cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
 
@@ -389,28 +401,12 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int ret, stream;
 
 	if (cmd == SND_COMPR_TRIGGER_PARTIAL_DRAIN ||
-		cmd == SND_COMPR_TRIGGER_DRAIN) {
-
-		for_each_rtdcom(fe, rtdcom) {
-			component = rtdcom->component;
-
-			if (!component->driver->compr_ops ||
-			    !component->driver->compr_ops->trigger)
-				continue;
-
-			ret = component->driver->compr_ops->trigger(cstream,
-								    cmd);
-			if (ret < 0)
-				return ret;
-		}
-		return ret;
-	}
+	    cmd == SND_COMPR_TRIGGER_DRAIN)
+		return soc_compr_components_trigger(cstream, cmd);
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -425,17 +421,9 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->trigger)
-			continue;
-
-		ret = component->driver->compr_ops->trigger(cstream, cmd);
-		if (ret < 0)
-			goto out;
-	}
+	ret = soc_compr_components_trigger(cstream, cmd);
+	if (ret < 0)
+		goto out;
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
@@ -462,12 +450,33 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 	return ret;
 }
 
-static int soc_compr_set_params(struct snd_compr_stream *cstream,
-					struct snd_compr_params *params)
+static int soc_compr_components_set_params(struct snd_compr_stream *cstream,
+					   struct snd_compr_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
+	int ret;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		if (!component->driver->compr_ops ||
+		    !component->driver->compr_ops->set_params)
+			continue;
+
+		ret = component->driver->compr_ops->set_params(cstream, params);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int soc_compr_set_params(struct snd_compr_stream *cstream,
+				struct snd_compr_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
@@ -486,17 +495,9 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 			goto err;
 	}
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->set_params)
-			continue;
-
-		ret = component->driver->compr_ops->set_params(cstream, params);
-		if (ret < 0)
-			goto err;
-	}
+	ret = soc_compr_components_set_params(cstream, params);
+	if (ret < 0)
+		goto err;
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->set_params) {
 		ret = rtd->dai_link->compr_ops->set_params(cstream);
@@ -530,8 +531,6 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream =
 		 fe->pcm->streams[cstream->direction].substream;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int ret, stream;
 
@@ -566,17 +565,9 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 			goto out;
 	}
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->set_params)
-			continue;
-
-		ret = component->driver->compr_ops->set_params(cstream, params);
-		if (ret < 0)
-			goto out;
-	}
+	ret = soc_compr_components_set_params(cstream, params);
+	if (ret < 0)
+		goto out;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->set_params) {
 		ret = fe->dai_link->compr_ops->set_params(cstream);
-- 
2.20.1
