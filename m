From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Clarify the intent of current
	compressed ops handling" to the asoc tree
Date: Wed,  6 Feb 2019 16:58:14 +0000 (GMT)
Message-ID: <20190206165814.B30301127EA3@debutante.sirena.org.uk>
References: <20190205111813.28929-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 88FD126797B
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:58:20 +0100 (CET)
In-Reply-To: <20190205111813.28929-1-ckeepax@opensource.cirrus.com>
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

   ASoC: compress: Clarify the intent of current compressed ops handling

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

>From 52cadf1fdbe87a3a3eee11d9cc4873796903c934 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 5 Feb 2019 11:18:12 +0000
Subject: [PATCH] ASoC: compress: Clarify the intent of current compressed ops
 handling

For callbacks configuring the state of the components (trigger,
set_params, ack and set_metadata) simplify the code a little and make
intention clearer by aborting as soon as an error is encountered. The
operation has already failed and there is nothing to be gained from
processing the callbacks on additional components. The operations
currently abort after the callbacks, so this simply shortens the
error path.

For callbacks returning information from the driver (copy,
get_metadata, pointer, get_codec_caps, get_caps and get_params)
only look for the first callback provided, currently the code will
call every callback only returning the information provided by the
last. Since we can only return one set of data, it makes no sense to
request the data from every component. Again this just makes the
currently supported feature set a little more clear.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 106 ++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 58 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 699397a09167..fc8742383b23 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -353,7 +353,7 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -364,12 +364,10 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 		    !component->driver->compr_ops->trigger)
 			continue;
 
-		__ret = component->driver->compr_ops->trigger(cstream, cmd);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->trigger(cstream, cmd);
+		if (ret < 0)
+			goto out;
 	}
-	if (ret < 0)
-		goto out;
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger)
 		cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
@@ -394,7 +392,7 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	int ret = 0, __ret, stream;
+	int ret, stream;
 
 	if (cmd == SND_COMPR_TRIGGER_PARTIAL_DRAIN ||
 		cmd == SND_COMPR_TRIGGER_DRAIN) {
@@ -406,9 +404,10 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 			    !component->driver->compr_ops->trigger)
 				continue;
 
-			__ret = component->driver->compr_ops->trigger(cstream, cmd);
-			if (__ret < 0)
-				ret = __ret;
+			ret = component->driver->compr_ops->trigger(cstream,
+								    cmd);
+			if (ret < 0)
+				return ret;
 		}
 		return ret;
 	}
@@ -433,12 +432,10 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 		    !component->driver->compr_ops->trigger)
 			continue;
 
-		__ret = component->driver->compr_ops->trigger(cstream, cmd);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->trigger(cstream, cmd);
+		if (ret < 0)
+			goto out;
 	}
-	if (ret < 0)
-		goto out;
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
@@ -472,7 +469,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -496,12 +493,10 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->set_params)
 			continue;
 
-		__ret = component->driver->compr_ops->set_params(cstream, params);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->set_params(cstream, params);
+		if (ret < 0)
+			goto err;
 	}
-	if (ret < 0)
-		goto err;
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->set_params) {
 		ret = rtd->dai_link->compr_ops->set_params(cstream);
@@ -522,7 +517,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 
 	cancel_delayed_work_sync(&rtd->delayed_work);
 
-	return ret;
+	return 0;
 
 err:
 	mutex_unlock(&rtd->pcm_mutex);
@@ -538,7 +533,7 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	int ret = 0, __ret, stream;
+	int ret, stream;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -578,12 +573,10 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->set_params)
 			continue;
 
-		__ret = component->driver->compr_ops->set_params(cstream, params);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->set_params(cstream, params);
+		if (ret < 0)
+			goto out;
 	}
-	if (ret < 0)
-		goto out;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->set_params) {
 		ret = fe->dai_link->compr_ops->set_params(cstream);
@@ -607,7 +600,7 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -624,9 +617,8 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->get_params)
 			continue;
 
-		__ret = component->driver->compr_ops->get_params(cstream, params);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->get_params(cstream, params);
+		break;
 	}
 
 err:
@@ -640,7 +632,7 @@ static int soc_compr_get_caps(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -651,9 +643,8 @@ static int soc_compr_get_caps(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->get_caps)
 			continue;
 
-		__ret = component->driver->compr_ops->get_caps(cstream, caps);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->get_caps(cstream, caps);
+		break;
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -666,7 +657,7 @@ static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -677,9 +668,9 @@ static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->get_codec_caps)
 			continue;
 
-		__ret = component->driver->compr_ops->get_codec_caps(cstream, codec);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->get_codec_caps(cstream,
+								   codec);
+		break;
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -692,7 +683,7 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -709,9 +700,9 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 		    !component->driver->compr_ops->ack)
 			continue;
 
-		__ret = component->driver->compr_ops->ack(cstream, bytes);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->ack(cstream, bytes);
+		if (ret < 0)
+			goto err;
 	}
 
 err:
@@ -725,7 +716,7 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	int ret = 0;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -740,9 +731,8 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->pointer)
 			continue;
 
-		__ret = component->driver->compr_ops->pointer(cstream, tstamp);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->pointer(cstream, tstamp);
+		break;
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -781,7 +771,7 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret;
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_metadata) {
 		ret = cpu_dai->driver->cops->set_metadata(cstream, metadata, cpu_dai);
@@ -796,12 +786,13 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->set_metadata)
 			continue;
 
-		__ret = component->driver->compr_ops->set_metadata(cstream, metadata);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->set_metadata(cstream,
+								 metadata);
+		if (ret < 0)
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
@@ -811,7 +802,7 @@ static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret;
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->get_metadata) {
 		ret = cpu_dai->driver->cops->get_metadata(cstream, metadata, cpu_dai);
@@ -826,12 +817,11 @@ static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->get_metadata)
 			continue;
 
-		__ret = component->driver->compr_ops->get_metadata(cstream, metadata);
-		if (__ret < 0)
-			ret = __ret;
+		return component->driver->compr_ops->get_metadata(cstream,
+								  metadata);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* ASoC Compress operations */
-- 
2.20.1
