From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/4] ASoC: compress: Add helper functions for
	component trigger/set_params
Date: Thu, 26 Apr 2018 17:30:06 +0100
Message-ID: <20180426163007.5632-3-ckeepax@opensource.cirrus.com>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C8FD22677FD
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 18:30:14 +0200 (CEST)
In-Reply-To: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
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
Cc: vinod.koul@intel.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The trigger and set_params callbacks are called from 3 and 2 separate
loops respectively, tidy up the code a little by factoring these out
into helper functions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-compress.c | 116 ++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 62 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b411143f21ccc..3d107652b7ca3 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -355,17 +355,13 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
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
@@ -376,9 +372,25 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 
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
 
@@ -399,27 +411,12 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
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
-			ret = component->driver->compr_ops->trigger(cstream, cmd);
-			if (ret < 0)
-				return ret;
-		}
-		return ret;
-	}
+	    cmd == SND_COMPR_TRIGGER_DRAIN)
+		return soc_compr_components_trigger(cstream, cmd);
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -435,17 +432,9 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
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
 
@@ -472,12 +461,33 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
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
 
@@ -496,17 +506,9 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
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
@@ -540,8 +542,6 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream =
 		 fe->pcm->streams[cstream->direction].substream;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int ret, stream;
 
@@ -558,17 +558,9 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
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
2.11.0
