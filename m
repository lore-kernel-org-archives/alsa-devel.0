From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 4/4] ASoC: pcm: Standardise ASoC PCM messages
Date: Mon, 19 Nov 2012 14:39:15 +0000
Message-ID: <1353335955-5249-4-git-send-email-lrg@ti.com>
References: <1353335955-5249-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E52126514E
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 15:39:28 +0100 (CET)
In-Reply-To: <1353335955-5249-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC has a mixture of message prefixes e.g. "ASoC", "asoc"
or none and message types e.g. pr_debug or dev_dbg.

Make sure all ASoC core messages use the same "ASoC" prefix and
convert any component device specific messages to use dev_dbg
instead of pr_debug.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |  193 ++++++++++++++++++++++++++-------------------------
 1 file changed, 98 insertions(+), 95 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ef22d0b..314102a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -43,7 +43,7 @@ static int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 
-		dev_dbg(be->dev, "pm: BE %s event %d dir %d\n",
+		dev_dbg(be->dev, "ASoC: BE %s event %d dir %d\n",
 				be->dai_link->name, event, dir);
 
 		snd_soc_dapm_stream_event(be, dir, event);
@@ -70,18 +70,19 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 	 */
 	if (!soc_dai->rate) {
 		dev_warn(soc_dai->dev,
-			 "Not enforcing symmetric_rates due to race\n");
+			 "ASoC: Not enforcing symmetric_rates due to race\n");
 		return 0;
 	}
 
-	dev_dbg(soc_dai->dev, "Symmetry forces %dHz rate\n", soc_dai->rate);
+	dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %dHz rate\n", soc_dai->rate);
 
 	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
 					   SNDRV_PCM_HW_PARAM_RATE,
 					   soc_dai->rate, soc_dai->rate);
 	if (ret < 0) {
 		dev_err(soc_dai->dev,
-			"Unable to apply rate symmetry constraint: %d\n", ret);
+			"ASoC: Unable to apply rate symmetry constraint: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -118,7 +119,7 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 						   sample_sizes[i], bits);
 		if (ret != 0)
 			dev_warn(dai->dev,
-				 "Failed to set MSB %d/%d: %d\n",
+				 "ASoC: Failed to set MSB %d/%d: %d\n",
 				 bits, sample_sizes[i], ret);
 	}
 }
@@ -149,8 +150,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops->startup) {
 		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev, "can't open interface %s: %d\n",
-				cpu_dai->name, ret);
+			dev_err(cpu_dai->dev, "ASoC: can't open interface"
+				" %s: %d\n", cpu_dai->name, ret);
 			goto out;
 		}
 	}
@@ -158,8 +159,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (platform->driver->ops && platform->driver->ops->open) {
 		ret = platform->driver->ops->open(substream);
 		if (ret < 0) {
-			dev_err(platform->dev, "can't open platform %s: %d\n",
-				platform->name, ret);
+			dev_err(platform->dev, "ASoC: can't open platform"
+				" %s: %d\n", platform->name, ret);
 			goto platform_err;
 		}
 	}
@@ -167,8 +168,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (codec_dai->driver->ops->startup) {
 		ret = codec_dai->driver->ops->startup(substream, codec_dai);
 		if (ret < 0) {
-			dev_err(codec_dai->dev, "can't open codec %s: %d\n",
-				codec_dai->name, ret);
+			dev_err(codec_dai->dev, "ASoC: can't open codec"
+				" %s: %d\n", codec_dai->name, ret);
 			goto codec_dai_err;
 		}
 	}
@@ -176,7 +177,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (rtd->dai_link->ops && rtd->dai_link->ops->startup) {
 		ret = rtd->dai_link->ops->startup(substream);
 		if (ret < 0) {
-			pr_err("asoc: %s startup failed: %d\n",
+			pr_err("ASoC: %s startup failed: %d\n",
 			       rtd->dai_link->name, ret);
 			goto machine_err;
 		}
@@ -238,18 +239,18 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	ret = -EINVAL;
 	snd_pcm_limit_hw_rates(runtime);
 	if (!runtime->hw.rates) {
-		printk(KERN_ERR "asoc: %s <-> %s No matching rates\n",
+		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
 			codec_dai->name, cpu_dai->name);
 		goto config_err;
 	}
 	if (!runtime->hw.formats) {
-		printk(KERN_ERR "asoc: %s <-> %s No matching formats\n",
+		printk(KERN_ERR "ASoC: %s <-> %s No matching formats\n",
 			codec_dai->name, cpu_dai->name);
 		goto config_err;
 	}
 	if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
 	    runtime->hw.channels_min > runtime->hw.channels_max) {
-		printk(KERN_ERR "asoc: %s <-> %s No matching channels\n",
+		printk(KERN_ERR "ASoC: %s <-> %s No matching channels\n",
 				codec_dai->name, cpu_dai->name);
 		goto config_err;
 	}
@@ -270,12 +271,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			goto config_err;
 	}
 
-	pr_debug("asoc: %s <-> %s info:\n",
+	pr_debug("ASoC: %s <-> %s info:\n",
 			codec_dai->name, cpu_dai->name);
-	pr_debug("asoc: rate mask 0x%x\n", runtime->hw.rates);
-	pr_debug("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
+	pr_debug("ASoC: rate mask 0x%x\n", runtime->hw.rates);
+	pr_debug("ASoC: min ch %d max ch %d\n", runtime->hw.channels_min,
 		 runtime->hw.channels_max);
-	pr_debug("asoc: min rate %d max rate %d\n", runtime->hw.rate_min,
+	pr_debug("ASoC: min rate %d max rate %d\n", runtime->hw.rate_min,
 		 runtime->hw.rate_max);
 
 dynamic:
@@ -330,7 +331,7 @@ static void close_delayed_work(struct work_struct *work)
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	pr_debug("pop wq checking: %s status: %s waiting: %s\n",
+	dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
 		 codec_dai->driver->playback.stream_name,
 		 codec_dai->playback_active ? "active" : "inactive",
 		 codec_dai->pop_wait ? "yes" : "no");
@@ -444,7 +445,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (rtd->dai_link->ops && rtd->dai_link->ops->prepare) {
 		ret = rtd->dai_link->ops->prepare(substream);
 		if (ret < 0) {
-			pr_err("asoc: machine prepare error: %d\n", ret);
+			dev_err(rtd->card->dev, "ASoC: machine prepare error:"
+				" %d\n", ret);
 			goto out;
 		}
 	}
@@ -452,8 +454,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (platform->driver->ops && platform->driver->ops->prepare) {
 		ret = platform->driver->ops->prepare(substream);
 		if (ret < 0) {
-			dev_err(platform->dev, "platform prepare error: %d\n",
-				ret);
+			dev_err(platform->dev, "ASoC: platform prepare error:"
+				" %d\n", ret);
 			goto out;
 		}
 	}
@@ -461,7 +463,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (codec_dai->driver->ops->prepare) {
 		ret = codec_dai->driver->ops->prepare(substream, codec_dai);
 		if (ret < 0) {
-			dev_err(codec_dai->dev, "DAI prepare error: %d\n",
+			dev_err(codec_dai->dev, "ASoC: DAI prepare error: %d\n",
 				ret);
 			goto out;
 		}
@@ -470,7 +472,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops->prepare) {
 		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev, "DAI prepare error: %d\n",
+			dev_err(cpu_dai->dev, "ASoC: DAI prepare error: %d\n",
 				ret);
 			goto out;
 		}
@@ -512,7 +514,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
-			pr_err("asoc: machine hw_params failed: %d\n", ret);
+			dev_err(rtd->card->dev, "ASoC: machine hw_params"
+				" failed: %d\n", ret);
 			goto out;
 		}
 	}
@@ -520,8 +523,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (codec_dai->driver->ops->hw_params) {
 		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
 		if (ret < 0) {
-			dev_err(codec_dai->dev, "can't set %s hw params: %d\n",
-				codec_dai->name, ret);
+			dev_err(codec_dai->dev, "ASoC: can't set %s hw params:"
+				" %d\n", codec_dai->name, ret);
 			goto codec_err;
 		}
 	}
@@ -529,7 +532,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (cpu_dai->driver->ops->hw_params) {
 		ret = cpu_dai->driver->ops->hw_params(substream, params, cpu_dai);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev, "%s hw params failed: %d\n",
+			dev_err(cpu_dai->dev, "ASoC: %s hw params failed: %d\n",
 				cpu_dai->name, ret);
 			goto interface_err;
 		}
@@ -538,7 +541,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (platform->driver->ops && platform->driver->ops->hw_params) {
 		ret = platform->driver->ops->hw_params(substream, params);
 		if (ret < 0) {
-			dev_err(platform->dev, "%s hw params failed: %d\n",
+			dev_err(platform->dev, "ASoC: %s hw params failed: %d\n",
 			       platform->name, ret);
 			goto platform_err;
 		}
@@ -760,7 +763,7 @@ static void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm, *d;
 
 	list_for_each_entry_safe(dpcm, d, &fe->dpcm[stream].be_clients, list_be) {
-		dev_dbg(fe->dev, "BE %s disconnect check for %s\n",
+		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
 				stream ? "capture" : "playback",
 				dpcm->be->dai_link->name);
 
@@ -815,7 +818,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	}
 
-	dev_err(card->dev, "can't get %s BE for %s\n",
+	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
 		stream ? "capture" : "playback", widget->name);
 	return NULL;
 }
@@ -866,7 +869,7 @@ static int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	/* get number of valid DAI paths and their widgets */
 	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, &list);
 
-	dev_dbg(fe->dev, "found %d audio %s paths\n", paths,
+	dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
 			stream ? "capture" : "playback");
 
 	*list_ = list;
@@ -903,7 +906,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		if (widget && widget_in_list(list, widget))
 			continue;
 
-		dev_dbg(fe->dev, "pruning %s BE %s for %s\n",
+		dev_dbg(fe->dev, "ASoC: pruning %s BE %s for %s\n",
 			stream ? "capture" : "playback",
 			dpcm->be->dai_link->name, fe->dai_link->name);
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
@@ -911,7 +914,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		prune++;
 	}
 
-	dev_dbg(fe->dev, "found %d old BE paths for pruning\n", prune);
+	dev_dbg(fe->dev, "ASoC: found %d old BE paths for pruning\n", prune);
 	return prune;
 }
 
@@ -932,7 +935,7 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		/* is there a valid BE rtd for this widget */
 		be = dpcm_get_be(card, list->widgets[i], stream);
 		if (!be) {
-			dev_err(fe->dev, "no BE found for %s\n",
+			dev_err(fe->dev, "ASoC: no BE found for %s\n",
 					list->widgets[i]->name);
 			continue;
 		}
@@ -948,7 +951,7 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		/* newly connected FE and BE */
 		err = dpcm_be_connect(fe, be, stream);
 		if (err < 0) {
-			dev_err(fe->dev, "can't connect %s\n",
+			dev_err(fe->dev, "ASoC: can't connect %s\n",
 				list->widgets[i]->name);
 			break;
 		} else if (err == 0) /* already connected */
@@ -959,7 +962,7 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		new++;
 	}
 
-	dev_dbg(fe->dev, "found %d new BE paths\n", new);
+	dev_dbg(fe->dev, "ASoC: found %d new BE paths\n", new);
 	return new;
 }
 
@@ -998,7 +1001,7 @@ static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
 			snd_soc_dpcm_get_substream(be, stream);
 
 		if (be->dpcm[stream].users == 0)
-			dev_err(be->dev, "no users %s at close - state %d\n",
+			dev_err(be->dev, "ASoC: no users %s at close - state %d\n",
 				stream ? "capture" : "playback",
 				be->dpcm[stream].state);
 
@@ -1032,7 +1035,7 @@ static int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 
 		/* first time the dpcm is open ? */
 		if (be->dpcm[stream].users == DPCM_MAX_BE_USERS)
-			dev_err(be->dev, "too many users %s at open %d\n",
+			dev_err(be->dev, "ASoC: too many users %s at open %d\n",
 				stream ? "capture" : "playback",
 				be->dpcm[stream].state);
 
@@ -1043,15 +1046,15 @@ static int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
 
-		dev_dbg(be->dev, "dpcm: open BE %s\n", be->dai_link->name);
+		dev_dbg(be->dev, "ASoC: open BE %s\n", be->dai_link->name);
 
 		be_substream->runtime = be->dpcm[stream].runtime;
 		err = soc_pcm_open(be_substream);
 		if (err < 0) {
-			dev_err(be->dev, "BE open failed %d\n", err);
+			dev_err(be->dev, "ASoC: BE open failed %d\n", err);
 			be->dpcm[stream].users--;
 			if (be->dpcm[stream].users < 0)
-				dev_err(be->dev, "no users %s at unwind %d\n",
+				dev_err(be->dev, "ASoC: no users %s at unwind %d\n",
 					stream ? "capture" : "playback",
 					be->dpcm[stream].state);
 
@@ -1076,7 +1079,7 @@ unwind:
 			continue;
 
 		if (be->dpcm[stream].users == 0)
-			dev_err(be->dev, "no users %s at close %d\n",
+			dev_err(be->dev, "ASoC: no users %s at close %d\n",
 				stream ? "capture" : "playback",
 				be->dpcm[stream].state);
 
@@ -1128,16 +1131,16 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 
 	ret = dpcm_be_dai_startup(fe, fe_substream->stream);
 	if (ret < 0) {
-		dev_err(fe->dev,"dpcm: failed to start some BEs %d\n", ret);
+		dev_err(fe->dev,"ASoC: failed to start some BEs %d\n", ret);
 		goto be_err;
 	}
 
-	dev_dbg(fe->dev, "dpcm: open FE %s\n", fe->dai_link->name);
+	dev_dbg(fe->dev, "ASoC: open FE %s\n", fe->dai_link->name);
 
 	/* start the DAI frontend */
 	ret = soc_pcm_open(fe_substream);
 	if (ret < 0) {
-		dev_err(fe->dev,"dpcm: failed to start FE %d\n", ret);
+		dev_err(fe->dev,"ASoC: failed to start FE %d\n", ret);
 		goto unwind;
 	}
 
@@ -1172,7 +1175,7 @@ static int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if (be->dpcm[stream].users == 0)
-			dev_err(be->dev, "no users %s at close - state %d\n",
+			dev_err(be->dev, "ASoC: no users %s at close - state %d\n",
 				stream ? "capture" : "playback",
 				be->dpcm[stream].state);
 
@@ -1183,7 +1186,7 @@ static int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN))
 			continue;
 
-		dev_dbg(be->dev, "dpcm: close BE %s\n",
+		dev_dbg(be->dev, "ASoC: close BE %s\n",
 			dpcm->fe->dai_link->name);
 
 		soc_pcm_close(be_substream);
@@ -1204,7 +1207,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	/* shutdown the BEs */
 	dpcm_be_dai_shutdown(fe, substream->stream);
 
-	dev_dbg(fe->dev, "dpcm: close FE %s\n", fe->dai_link->name);
+	dev_dbg(fe->dev, "ASoC: close FE %s\n", fe->dai_link->name);
 
 	/* now shutdown the frontend */
 	soc_pcm_close(substream);
@@ -1243,7 +1246,7 @@ static int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-		dev_dbg(be->dev, "dpcm: hw_free BE %s\n",
+		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
 			dpcm->fe->dai_link->name);
 
 		soc_pcm_hw_free(be_substream);
@@ -1262,12 +1265,12 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
-	dev_dbg(fe->dev, "dpcm: hw_free FE %s\n", fe->dai_link->name);
+	dev_dbg(fe->dev, "ASoC: hw_free FE %s\n", fe->dai_link->name);
 
 	/* call hw_free on the frontend */
 	err = soc_pcm_hw_free(substream);
 	if (err < 0)
-		dev_err(fe->dev,"dpcm: hw_free FE %s failed\n",
+		dev_err(fe->dev,"ASoC: hw_free FE %s failed\n",
 			fe->dai_link->name);
 
 	/* only hw_params backends that are either sinks or sources
@@ -1305,7 +1308,7 @@ static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE))
 			continue;
 
-		dev_dbg(be->dev, "dpcm: hw_params BE %s\n",
+		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
 			dpcm->fe->dai_link->name);
 
 		/* copy params for each dpcm */
@@ -1318,7 +1321,7 @@ static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 					&dpcm->hw_params);
 			if (ret < 0) {
 				dev_err(be->dev,
-					"dpcm: hw_params BE fixup failed %d\n",
+					"ASoC: hw_params BE fixup failed %d\n",
 					ret);
 				goto unwind;
 			}
@@ -1327,7 +1330,7 @@ static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
 		if (ret < 0) {
 			dev_err(dpcm->be->dev,
-				"dpcm: hw_params BE failed %d\n", ret);
+				"ASoC: hw_params BE failed %d\n", ret);
 			goto unwind;
 		}
 
@@ -1374,18 +1377,18 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 			sizeof(struct snd_pcm_hw_params));
 	ret = dpcm_be_dai_hw_params(fe, substream->stream);
 	if (ret < 0) {
-		dev_err(fe->dev,"dpcm: hw_params BE failed %d\n", ret);
+		dev_err(fe->dev,"ASoC: hw_params BE failed %d\n", ret);
 		goto out;
 	}
 
-	dev_dbg(fe->dev, "dpcm: hw_params FE %s rate %d chan %x fmt %d\n",
+	dev_dbg(fe->dev, "ASoC: hw_params FE %s rate %d chan %x fmt %d\n",
 			fe->dai_link->name, params_rate(params),
 			params_channels(params), params_format(params));
 
 	/* call hw_params on the frontend */
 	ret = soc_pcm_hw_params(substream, params);
 	if (ret < 0) {
-		dev_err(fe->dev,"dpcm: hw_params FE failed %d\n", ret);
+		dev_err(fe->dev,"ASoC: hw_params FE failed %d\n", ret);
 		dpcm_be_dai_hw_free(fe, stream);
 	 } else
 		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_PARAMS;
@@ -1401,12 +1404,12 @@ static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
 {
 	int ret;
 
-	dev_dbg(dpcm->be->dev, "dpcm: trigger BE %s cmd %d\n",
+	dev_dbg(dpcm->be->dev, "ASoC: trigger BE %s cmd %d\n",
 			dpcm->fe->dai_link->name, cmd);
 
 	ret = soc_pcm_trigger(substream, cmd);
 	if (ret < 0)
-		dev_err(dpcm->be->dev,"dpcm: trigger BE failed %d\n", ret);
+		dev_err(dpcm->be->dev,"ASoC: trigger BE failed %d\n", ret);
 
 	return ret;
 }
@@ -1517,12 +1520,12 @@ static int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SND_SOC_DPCM_TRIGGER_PRE:
 		/* call trigger on the frontend before the backend. */
 
-		dev_dbg(fe->dev, "dpcm: pre trigger FE %s cmd %d\n",
+		dev_dbg(fe->dev, "ASoC: pre trigger FE %s cmd %d\n",
 				fe->dai_link->name, cmd);
 
 		ret = soc_pcm_trigger(substream, cmd);
 		if (ret < 0) {
-			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
 			goto out;
 		}
 
@@ -1533,11 +1536,11 @@ static int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		ret = dpcm_be_dai_trigger(fe, substream->stream, cmd);
 		if (ret < 0) {
-			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
 			goto out;
 		}
 
-		dev_dbg(fe->dev, "dpcm: post trigger FE %s cmd %d\n",
+		dev_dbg(fe->dev, "ASoC: post trigger FE %s cmd %d\n",
 				fe->dai_link->name, cmd);
 
 		ret = soc_pcm_trigger(substream, cmd);
@@ -1545,17 +1548,17 @@ static int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SND_SOC_DPCM_TRIGGER_BESPOKE:
 		/* bespoke trigger() - handles both FE and BEs */
 
-		dev_dbg(fe->dev, "dpcm: bespoke trigger FE %s cmd %d\n",
+		dev_dbg(fe->dev, "ASoC: bespoke trigger FE %s cmd %d\n",
 				fe->dai_link->name, cmd);
 
 		ret = soc_pcm_bespoke_trigger(substream, cmd);
 		if (ret < 0) {
-			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
 			goto out;
 		}
 		break;
 	default:
-		dev_err(fe->dev, "dpcm: invalid trigger cmd %d for %s\n", cmd,
+		dev_err(fe->dev, "ASoC: invalid trigger cmd %d for %s\n", cmd,
 				fe->dai_link->name);
 		ret = -EINVAL;
 		goto out;
@@ -1598,12 +1601,12 @@ static int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-		dev_dbg(be->dev, "dpcm: prepare BE %s\n",
+		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
 			dpcm->fe->dai_link->name);
 
 		ret = soc_pcm_prepare(be_substream);
 		if (ret < 0) {
-			dev_err(be->dev, "dpcm: backend prepare failed %d\n",
+			dev_err(be->dev, "ASoC: backend prepare failed %d\n",
 				ret);
 			break;
 		}
@@ -1620,13 +1623,13 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
-	dev_dbg(fe->dev, "dpcm: prepare FE %s\n", fe->dai_link->name);
+	dev_dbg(fe->dev, "ASoC: prepare FE %s\n", fe->dai_link->name);
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
 	/* there is no point preparing this FE if there are no BEs */
 	if (list_empty(&fe->dpcm[stream].be_clients)) {
-		dev_err(fe->dev, "dpcm: no backend DAIs enabled for %s\n",
+		dev_err(fe->dev, "ASoC: no backend DAIs enabled for %s\n",
 				fe->dai_link->name);
 		ret = -EINVAL;
 		goto out;
@@ -1639,7 +1642,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	/* call prepare on the frontend */
 	ret = soc_pcm_prepare(substream);
 	if (ret < 0) {
-		dev_err(fe->dev,"dpcm: prepare FE %s failed\n",
+		dev_err(fe->dev,"ASoC: prepare FE %s failed\n",
 			fe->dai_link->name);
 		goto out;
 	}
@@ -1673,33 +1676,33 @@ static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int err;
 
-	dev_dbg(fe->dev, "runtime %s close on FE %s\n",
+	dev_dbg(fe->dev, "ASoC: runtime %s close on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
 
 	if (trigger == SND_SOC_DPCM_TRIGGER_BESPOKE) {
 		/* call bespoke trigger - FE takes care of all BE triggers */
-		dev_dbg(fe->dev, "dpcm: bespoke trigger FE %s cmd stop\n",
+		dev_dbg(fe->dev, "ASoC: bespoke trigger FE %s cmd stop\n",
 				fe->dai_link->name);
 
 		err = soc_pcm_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		if (err < 0)
-			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", err);
+			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", err);
 	} else {
-		dev_dbg(fe->dev, "dpcm: trigger FE %s cmd stop\n",
+		dev_dbg(fe->dev, "ASoC: trigger FE %s cmd stop\n",
 			fe->dai_link->name);
 
 		err = dpcm_be_dai_trigger(fe, stream, SNDRV_PCM_TRIGGER_STOP);
 		if (err < 0)
-			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", err);
+			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", err);
 	}
 
 	err = dpcm_be_dai_hw_free(fe, stream);
 	if (err < 0)
-		dev_err(fe->dev,"dpcm: hw_free FE failed %d\n", err);
+		dev_err(fe->dev,"ASoC: hw_free FE failed %d\n", err);
 
 	err = dpcm_be_dai_shutdown(fe, stream);
 	if (err < 0)
-		dev_err(fe->dev,"dpcm: shutdown FE failed %d\n", err);
+		dev_err(fe->dev,"ASoC: shutdown FE failed %d\n", err);
 
 	/* run the stream event for each BE */
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_NOP);
@@ -1715,7 +1718,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int ret;
 
-	dev_dbg(fe->dev, "runtime %s open on FE %s\n",
+	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
 
 	/* Only start the BE if the FE is ready */
@@ -1761,22 +1764,22 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 
 	if (trigger == SND_SOC_DPCM_TRIGGER_BESPOKE) {
 		/* call trigger on the frontend - FE takes care of all BE triggers */
-		dev_dbg(fe->dev, "dpcm: bespoke trigger FE %s cmd start\n",
+		dev_dbg(fe->dev, "ASoC: bespoke trigger FE %s cmd start\n",
 				fe->dai_link->name);
 
 		ret = soc_pcm_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		if (ret < 0) {
-			dev_err(fe->dev,"dpcm: bespoke trigger FE failed %d\n", ret);
+			dev_err(fe->dev,"ASoC: bespoke trigger FE failed %d\n", ret);
 			goto hw_free;
 		}
 	} else {
-		dev_dbg(fe->dev, "dpcm: trigger FE %s cmd start\n",
+		dev_dbg(fe->dev, "ASoC: trigger FE %s cmd start\n",
 			fe->dai_link->name);
 
 		ret = dpcm_be_dai_trigger(fe, stream,
 					SNDRV_PCM_TRIGGER_START);
 		if (ret < 0) {
-			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			dev_err(fe->dev,"ASoC: trigger FE failed %d\n", ret);
 			goto hw_free;
 		}
 	}
@@ -1805,7 +1808,7 @@ static int dpcm_run_new_update(struct snd_soc_pcm_runtime *fe, int stream)
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_BE;
 	ret = dpcm_run_update_startup(fe, stream);
 	if (ret < 0)
-		dev_err(fe->dev, "failed to startup some BEs\n");
+		dev_err(fe->dev, "ASoC: failed to startup some BEs\n");
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 
 	return ret;
@@ -1818,7 +1821,7 @@ static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_BE;
 	ret = dpcm_run_update_shutdown(fe, stream);
 	if (ret < 0)
-		dev_err(fe->dev, "failed to shutdown some BEs\n");
+		dev_err(fe->dev, "ASoC: failed to shutdown some BEs\n");
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 
 	return ret;
@@ -1853,7 +1856,7 @@ int soc_dpcm_runtime_update(struct snd_soc_dapm_widget *widget)
 			continue;
 
 		/* DAPM sync will call this to update DSP paths */
-		dev_dbg(fe->dev, "DPCM runtime update for FE %s\n",
+		dev_dbg(fe->dev, "ASoC: DPCM runtime update for FE %s\n",
 			fe->dai_link->name);
 
 		/* skip if FE doesn't have playback capability */
@@ -1862,7 +1865,7 @@ int soc_dpcm_runtime_update(struct snd_soc_dapm_widget *widget)
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
 		if (paths < 0) {
-			dev_warn(fe->dev, "%s no valid %s path\n",
+			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "playback");
 			mutex_unlock(&card->mutex);
 			return paths;
@@ -1891,7 +1894,7 @@ capture:
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
 		if (paths < 0) {
-			dev_warn(fe->dev, "%s no valid %s path\n",
+			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "capture");
 			mutex_unlock(&card->mutex);
 			return paths;
@@ -1934,7 +1937,7 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 		if (be->dai_link->ignore_suspend)
 			continue;
 
-		dev_dbg(be->dev, "BE digital mute %s\n", be->dai_link->name);
+		dev_dbg(be->dev, "ASoC: BE digital mute %s\n", be->dai_link->name);
 
 		if (drv->ops->digital_mute && dai->playback_active)
 				drv->ops->digital_mute(dai, mute);
@@ -1955,7 +1958,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	if (dpcm_path_get(fe, stream, &list) <= 0) {
-		dev_dbg(fe->dev, "asoc: %s no valid %s route\n",
+		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
 	}
 
@@ -2039,11 +2042,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			capture, &pcm);
 	}
 	if (ret < 0) {
-		dev_err(rtd->card->dev, "can't create pcm for %s\n",
+		dev_err(rtd->card->dev, "ASoC: can't create pcm for %s\n",
 			rtd->dai_link->name);
 		return ret;
 	}
-	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num, new_name);
+	dev_dbg(rtd->card->dev, "ASoC: registered pcm #%d %s\n",num, new_name);
 
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
@@ -2097,7 +2100,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (platform->driver->pcm_new) {
 		ret = platform->driver->pcm_new(rtd);
 		if (ret < 0) {
-			dev_err(platform->dev, "pcm constructor failed\n");
+			dev_err(platform->dev, "ASoC: pcm constructor failed\n");
 			return ret;
 		}
 	}
-- 
1.7.10.4
