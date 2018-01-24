From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: compress: Correct handling of
	compressed ops
Date: Wed, 24 Jan 2018 13:55:24 +0000
Message-ID: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 4284B2674F7
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 14:55:32 +0100 (CET)
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The soc_compr_copy callback is currently broken. Since the
changes to move the compr_ops over to the component the return
value is not correctly propagated, always returning zero on
success rather than the number of bytes copied. This causes
user-space to stall continuously reading as it does not believe
it has received any data.

Furthermore, the changes to move the compr_ops over to the
component iterate through the list of components and will
call the compressed operation for any that have compressed
ops. However, there would be signifcantly more work required
to support such a system. There isn't currently any sensible
mechanism to forward the ops to multiple components. For example
what should be done about merging data from copy?  Or what should
be returned through the pointer call, each component may have
different amounts of data available, but user-space expects a
single answer?

As such clean up the code a little by factoring out the search
for the relevant component and bring things back to looking for
a single component that supports compressed ops on a single
runtime. These refactorings also put back the original handling
for the copy callback, correcting the return value.

Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

These refactorings should also fix the static analysis warnings
that Dan Carpenter was seeing [1]. Which were being caused
due to the loops that could "in theory" call the free on more
than one component.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/130822.html

 sound/soc/soc-compress.c | 587 ++++++++++-------------------------------------
 1 file changed, 118 insertions(+), 469 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 81232f4ab614..34834c02dda8 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -26,14 +26,42 @@
 #include <sound/initval.h>
 #include <sound/soc-dpcm.h>
 
-static int soc_compr_open(struct snd_compr_stream *cstream)
+static struct snd_soc_component *
+soc_compr_get_component(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
+
+	if (platform)
+		return &platform->component;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		if (rtdcom->component->driver->compr_ops)
+			return rtdcom->component;
+	}
+
+	return NULL;
+}
+
+static const struct snd_compr_ops *
+soc_compr_get_ops(struct snd_soc_pcm_runtime *rtd,
+		  struct snd_soc_component *component)
+{
+	struct snd_soc_platform *platform = rtd->platform;
+
+	if (platform)
+		return platform->driver->compr_ops;
+	else
+		return component->driver->compr_ops;
+}
+
+static int soc_compr_open(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -46,36 +74,15 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 		}
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->open) {
-		ret = platform->driver->compr_ops->open(cstream);
+	if (compr_ops && compr_ops->open) {
+		ret = compr_ops->open(cstream);
 		if (ret < 0) {
 			pr_err("compress asoc: can't open platform %s\n",
-				platform->component.name);
+				component->name);
 			goto plat_err;
 		}
 	}
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->open)
-			continue;
-
-		__ret = component->driver->compr_ops->open(cstream);
-		if (__ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n",
-			       component->name);
-			ret = __ret;
-		}
-	}
-	if (ret < 0)
-		goto machine_err;
-
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
 		ret = rtd->dai_link->compr_ops->startup(cstream);
 		if (ret < 0) {
@@ -91,22 +98,8 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	return 0;
 
 machine_err:
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
-			continue;
-
-		component->driver->compr_ops->free(cstream);
-	}
-
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
-		platform->driver->compr_ops->free(cstream);
+	if (compr_ops && compr_ops->free)
+		compr_ops->free(cstream);
 plat_err:
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -118,16 +111,15 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
+	struct snd_soc_component *component = soc_compr_get_component(fe);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(fe, component);
 	struct snd_pcm_substream *fe_substream =
 		 fe->pcm->streams[cstream->direction].substream;
-	struct snd_soc_platform *platform = fe->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list;
 	int stream;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -145,37 +137,15 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		}
 	}
 
-
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->open) {
-		ret = platform->driver->compr_ops->open(cstream);
+	if (compr_ops && compr_ops->open) {
+		ret = compr_ops->open(cstream);
 		if (ret < 0) {
 			pr_err("compress asoc: can't open platform %s\n",
-				platform->component.name);
+				component->name);
 			goto plat_err;
 		}
 	}
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->open)
-			continue;
-
-		__ret = component->driver->compr_ops->open(cstream);
-		if (__ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n",
-			       component->name);
-			ret = __ret;
-		}
-	}
-	if (ret < 0)
-		goto machine_err;
-
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
 		if (ret < 0) {
@@ -227,22 +197,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
 		fe->dai_link->compr_ops->shutdown(cstream);
 machine_err:
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
-			continue;
-
-		component->driver->compr_ops->free(cstream);
-	}
-
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
-		platform->driver->compr_ops->free(cstream);
+	if (compr_ops && compr_ops->free)
+		compr_ops->free(cstream);
 plat_err:
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -283,9 +239,8 @@ static void close_delayed_work(struct work_struct *work)
 static int soc_compr_free(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int stream;
@@ -311,22 +266,8 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
-			continue;
-
-		component->driver->compr_ops->free(cstream);
-	}
-
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
-		platform->driver->compr_ops->free(cstream);
+	if (compr_ops && compr_ops->free)
+		compr_ops->free(cstream);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -356,9 +297,8 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
-	struct snd_soc_platform *platform = fe->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(fe);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(fe, component);
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
 	int stream, ret;
@@ -396,22 +336,8 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
 		fe->dai_link->compr_ops->shutdown(cstream);
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
-		platform->driver->compr_ops->free(cstream);
-
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
-			continue;
-
-		component->driver->compr_ops->free(cstream);
-	}
+	if (compr_ops && compr_ops->free)
+		compr_ops->free(cstream);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -424,43 +350,23 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 {
 
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->trigger) {
-		ret = platform->driver->compr_ops->trigger(cstream, cmd);
+	if (compr_ops && compr_ops->trigger) {
+		ret = compr_ops->trigger(cstream, cmd);
 		if (ret < 0)
 			goto out;
 	}
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->trigger)
-			continue;
-
-		__ret = component->driver->compr_ops->trigger(cstream, cmd);
-		if (__ret < 0)
-			ret = __ret;
-	}
-	if (ret < 0)
-		goto out;
-
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger)
 		cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
 
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
@@ -478,37 +384,16 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
-	struct snd_soc_platform *platform = fe->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(fe);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(fe, component);
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	int ret = 0, __ret, stream;
+	int ret = 0, stream;
 
 	if (cmd == SND_COMPR_TRIGGER_PARTIAL_DRAIN ||
 		cmd == SND_COMPR_TRIGGER_DRAIN) {
 
-		if (platform &&
-		    platform->driver->compr_ops &&
-		    platform->driver->compr_ops->trigger)
-			return platform->driver->compr_ops->trigger(cstream,
-								    cmd);
-
-		for_each_rtdcom(fe, rtdcom) {
-			component = rtdcom->component;
-
-			/* ignore duplication for now */
-			if (platform && (component == &platform->component))
-				continue;
-
-			if (!component->driver->compr_ops ||
-			    !component->driver->compr_ops->trigger)
-				continue;
-
-			__ret = component->driver->compr_ops->trigger(cstream, cmd);
-			if (__ret < 0)
-				ret = __ret;
-		}
-		return ret;
+		if (compr_ops && compr_ops->trigger)
+			return compr_ops->trigger(cstream, cmd);
 	}
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
@@ -525,30 +410,12 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->trigger) {
-		ret = platform->driver->compr_ops->trigger(cstream, cmd);
+	if (compr_ops && compr_ops->trigger) {
+		ret = compr_ops->trigger(cstream, cmd);
 		if (ret < 0)
 			goto out;
 	}
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->trigger)
-			continue;
-
-		__ret = component->driver->compr_ops->trigger(cstream, cmd);
-		if (__ret < 0)
-			ret = __ret;
-	}
-	if (ret < 0)
-		goto out;
-
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
 	ret = dpcm_be_dai_trigger(fe, stream, cmd);
@@ -578,11 +445,10 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 					struct snd_compr_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -598,30 +464,12 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 			goto err;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
-		ret = platform->driver->compr_ops->set_params(cstream, params);
+	if (compr_ops && compr_ops->set_params) {
+		ret = compr_ops->set_params(cstream, params);
 		if (ret < 0)
 			goto err;
 	}
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->set_params)
-			continue;
-
-		__ret = component->driver->compr_ops->set_params(cstream, params);
-		if (__ret < 0)
-			ret = __ret;
-	}
-	if (ret < 0)
-		goto err;
-
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->set_params) {
 		ret = rtd->dai_link->compr_ops->set_params(cstream);
 		if (ret < 0)
@@ -654,11 +502,10 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream =
 		 fe->pcm->streams[cstream->direction].substream;
-	struct snd_soc_platform *platform = fe->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(fe);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(fe, component);
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	int ret = 0, __ret, stream;
+	int ret = 0, stream;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -673,30 +520,12 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 			goto out;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
-		ret = platform->driver->compr_ops->set_params(cstream, params);
+	if (compr_ops && compr_ops->set_params) {
+		ret = compr_ops->set_params(cstream, params);
 		if (ret < 0)
 			goto out;
 	}
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->set_params)
-			continue;
-
-		__ret = component->driver->compr_ops->set_params(cstream, params);
-		if (__ret < 0)
-			ret = __ret;
-	}
-	if (ret < 0)
-		goto out;
-
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->set_params) {
 		ret = fe->dai_link->compr_ops->set_params(cstream);
 		if (ret < 0)
@@ -734,11 +563,10 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 					struct snd_codec *params)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -748,27 +576,8 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 			goto err;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->get_params) {
-		ret = platform->driver->compr_ops->get_params(cstream, params);
-		if (ret < 0)
-			goto err;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->get_params)
-			continue;
-
-		__ret = component->driver->compr_ops->get_params(cstream, params);
-		if (__ret < 0)
-			ret = __ret;
-	}
+	if (compr_ops && compr_ops->get_params)
+		ret = compr_ops->get_params(cstream, params);
 
 err:
 	mutex_unlock(&rtd->pcm_mutex);
@@ -779,36 +588,15 @@ static int soc_compr_get_caps(struct snd_compr_stream *cstream,
 				struct snd_compr_caps *caps)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->get_caps) {
-		ret = platform->driver->compr_ops->get_caps(cstream, caps);
-		if (ret < 0)
-			goto err;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->get_caps)
-			continue;
+	if (compr_ops && compr_ops->get_caps)
+		ret = compr_ops->get_caps(cstream, caps);
 
-		__ret = component->driver->compr_ops->get_caps(cstream, caps);
-		if (__ret < 0)
-			ret = __ret;
-	}
-
-err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
@@ -817,36 +605,15 @@ static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
 				struct snd_compr_codec_caps *codec)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->get_codec_caps) {
-		ret = platform->driver->compr_ops->get_codec_caps(cstream, codec);
-		if (ret < 0)
-			goto err;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
+	if (compr_ops && compr_ops->get_codec_caps)
+		ret = compr_ops->get_codec_caps(cstream, codec);
 
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->get_codec_caps)
-			continue;
-
-		__ret = component->driver->compr_ops->get_codec_caps(cstream, codec);
-		if (__ret < 0)
-			ret = __ret;
-	}
-
-err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
@@ -854,11 +621,10 @@ static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
 static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -868,27 +634,8 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 			goto err;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->ack) {
-		ret = platform->driver->compr_ops->ack(cstream, bytes);
-		if (ret < 0)
-			goto err;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->ack)
-			continue;
-
-		__ret = component->driver->compr_ops->ack(cstream, bytes);
-		if (__ret < 0)
-			ret = __ret;
-	}
+	if (compr_ops && compr_ops->ack)
+		ret = compr_ops->ack(cstream, bytes);
 
 err:
 	mutex_unlock(&rtd->pcm_mutex);
@@ -899,10 +646,9 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 			struct snd_compr_tstamp *tstamp)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
+	int ret = 0;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -910,29 +656,9 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->pointer)
 		cpu_dai->driver->cops->pointer(cstream, tstamp, cpu_dai);
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->pointer) {
-		ret = platform->driver->compr_ops->pointer(cstream, tstamp);
-		if (ret < 0)
-			goto err;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->pointer)
-			continue;
+	if (compr_ops && compr_ops->pointer)
+		ret = compr_ops->pointer(cstream, tstamp);
 
-		__ret = component->driver->compr_ops->pointer(cstream, tstamp);
-		if (__ret < 0)
-			ret = __ret;
-	}
-
-err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
@@ -941,35 +667,15 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 			  char __user *buf, size_t count)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->copy) {
-		ret = platform->driver->compr_ops->copy(cstream, buf, count);
-		if (ret < 0)
-			goto err;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
+	if (compr_ops && compr_ops->copy)
+		ret = compr_ops->copy(cstream, buf, count);
 
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->copy)
-			continue;
-
-		__ret = component->driver->compr_ops->copy(cstream, buf, count);
-		if (__ret < 0)
-			ret = __ret;
-	}
-err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
@@ -978,11 +684,10 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 				struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_metadata) {
 		ret = cpu_dai->driver->cops->set_metadata(cstream, metadata, cpu_dai);
@@ -990,27 +695,8 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 			return ret;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->set_metadata) {
-		ret = platform->driver->compr_ops->set_metadata(cstream, metadata);
-		if (ret < 0)
-			return ret;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->set_metadata)
-			continue;
-
-		__ret = component->driver->compr_ops->set_metadata(cstream, metadata);
-		if (__ret < 0)
-			ret = __ret;
-	}
+	if (compr_ops && compr_ops->set_metadata)
+		ret = compr_ops->set_metadata(cstream, metadata);
 
 	return ret;
 }
@@ -1019,11 +705,10 @@ static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
 				struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->get_metadata) {
 		ret = cpu_dai->driver->cops->get_metadata(cstream, metadata, cpu_dai);
@@ -1031,27 +716,8 @@ static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
 			return ret;
 	}
 
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->get_metadata) {
-		ret = platform->driver->compr_ops->get_metadata(cstream, metadata);
-		if (ret < 0)
-			return ret;
-	}
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->get_metadata)
-			continue;
-
-		__ret = component->driver->compr_ops->get_metadata(cstream, metadata);
-		if (__ret < 0)
-			ret = __ret;
-	}
+	if (compr_ops && compr_ops->get_metadata)
+		ret = compr_ops->get_metadata(cstream, metadata);
 
 	return ret;
 }
@@ -1096,9 +762,8 @@ static struct snd_compr_ops soc_compr_dyn_ops = {
  */
 int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
-	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component = soc_compr_get_component(rtd);
+	const struct snd_compr_ops *compr_ops = soc_compr_get_ops(rtd, component);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_compr *compr;
@@ -1174,25 +839,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		memcpy(compr->ops, &soc_compr_ops, sizeof(soc_compr_ops));
 	}
 
-
 	/* Add copy callback for not memory mapped DSPs */
-	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->copy)
-		compr->ops->copy = soc_compr_copy;
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
-			continue;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->copy)
-			continue;
-
+	if (compr_ops && compr_ops->copy)
 		compr->ops->copy = soc_compr_copy;
-	}
-
 
 	mutex_init(&compr->lock);
 	ret = snd_compress_new(rtd->card->snd_card, num, direction,
-- 
2.11.0
