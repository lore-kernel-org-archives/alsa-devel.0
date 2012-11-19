From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core: Standardise ASoC messages.
Date: Mon, 19 Nov 2012 14:47:09 +0000
Message-ID: <1353336429-5356-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 26536265159
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 15:47:17 +0100 (CET)
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
 sound/soc/soc-core.c |  241 ++++++++++++++++++++++++++------------------------
 1 file changed, 123 insertions(+), 118 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 10d21be..cee37ee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -271,7 +271,8 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 	codec->debugfs_codec_root = debugfs_create_dir(codec->name,
 						       debugfs_card_root);
 	if (!codec->debugfs_codec_root) {
-		dev_warn(codec->dev, "Failed to create codec debugfs directory\n");
+		dev_warn(codec->dev, "ASoC: Failed to create codec debugfs"
+			" directory\n");
 		return;
 	}
 
@@ -284,7 +285,8 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 						 codec->debugfs_codec_root,
 						 codec, &codec_reg_fops);
 	if (!codec->debugfs_reg)
-		dev_warn(codec->dev, "Failed to create codec register debugfs file\n");
+		dev_warn(codec->dev, "ASoC: Failed to create codec register"
+			" debugfs file\n");
 
 	snd_soc_dapm_debugfs_init(&codec->dapm, codec->debugfs_codec_root);
 }
@@ -302,7 +304,7 @@ static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
 						       debugfs_card_root);
 	if (!platform->debugfs_platform_root) {
 		dev_warn(platform->dev,
-			"Failed to create platform debugfs directory\n");
+			"ASoC: Failed to create platform debugfs directory\n");
 		return;
 	}
 
@@ -430,7 +432,7 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
 						    &card->pop_time);
 	if (!card->debugfs_pop_time)
 		dev_warn(card->dev,
-		       "Failed to create pop time debugfs file\n");
+		       "ASoC: Failed to create pop time debugfs file\n");
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
@@ -475,7 +477,7 @@ struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 			!strcmp(card->rtd[i].dai_link->name, dai_link))
 			return card->rtd[i].pcm->streams[stream].substream;
 	}
-	dev_dbg(card->dev, "failed to find dai link %s\n", dai_link);
+	dev_dbg(card->dev, "ASoC: failed to find dai link %s\n", dai_link);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_dai_substream);
@@ -489,7 +491,7 @@ struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 		if (!strcmp(card->rtd[i].dai_link->name, dai_link))
 			return &card->rtd[i];
 	}
-	dev_dbg(card->dev, "failed to find rtd %s\n", dai_link);
+	dev_dbg(card->dev, "ASoC: failed to find rtd %s\n", dai_link);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
@@ -519,7 +521,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 		     codec->card->snd_card->number, 0, codec->name);
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
-		snd_printk(KERN_ERR "Can't register ac97 bus\n");
+		dev_err(codec->dev, "ASoC: Can't register ac97 bus\n");
 		codec->ac97->dev.bus = NULL;
 		return err;
 	}
@@ -628,7 +630,8 @@ int snd_soc_suspend(struct device *dev)
 				 */
 				if (codec->dapm.idle_bias_off) {
 					dev_dbg(codec->dev,
-						"idle_bias_off CODEC on over suspend\n");
+						"ASoC: idle_bias_off CODEC on"
+						" over suspend\n");
 					break;
 				}
 			case SND_SOC_BIAS_OFF:
@@ -639,7 +642,8 @@ int snd_soc_suspend(struct device *dev)
 					regcache_mark_dirty(codec->control_data);
 				break;
 			default:
-				dev_dbg(codec->dev, "CODEC is on over suspend\n");
+				dev_dbg(codec->dev, "ASoC: CODEC is on"
+					" over suspend\n");
 				break;
 			}
 		}
@@ -676,7 +680,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	 * so userspace apps are blocked from touching us
 	 */
 
-	dev_dbg(card->dev, "starting resume work\n");
+	dev_dbg(card->dev, "ASoC: starting resume work\n");
 
 	/* Bring us up into D2 so that DAPM starts enabling things */
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D2);
@@ -708,7 +712,8 @@ static void soc_resume_deferred(struct work_struct *work)
 				codec->suspended = 0;
 				break;
 			default:
-				dev_dbg(codec->dev, "CODEC was on over suspend\n");
+				dev_dbg(codec->dev, "ASoC: CODEC was on over"
+					" suspend\n");
 				break;
 			}
 		}
@@ -758,7 +763,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	if (card->resume_post)
 		card->resume_post(card);
 
-	dev_dbg(card->dev, "resume work completed\n");
+	dev_dbg(card->dev, "ASoC: resume work completed\n");
 
 	/* userspace can access us now we are back as we were before */
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
@@ -790,12 +795,12 @@ int snd_soc_resume(struct device *dev)
 		ac97_control |= cpu_dai->driver->ac97_control;
 	}
 	if (ac97_control) {
-		dev_dbg(dev, "Resuming AC97 immediately\n");
+		dev_dbg(dev, "ASoC: Resuming AC97 immediately\n");
 		soc_resume_deferred(&card->deferred_resume_work);
 	} else {
-		dev_dbg(dev, "Scheduling resume work\n");
+		dev_dbg(dev, "ASoC: Scheduling resume work\n");
 		if (!schedule_work(&card->deferred_resume_work))
-			dev_err(dev, "resume work item may be lost\n");
+			dev_err(dev, "ASoC: resume work item may be lost\n");
 	}
 
 	return 0;
@@ -818,7 +823,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_dai *codec_dai, *cpu_dai;
 	const char *platform_name;
 
-	dev_dbg(card->dev, "binding %s at idx %d\n", dai_link->name, num);
+	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
 	/* Find CPU DAI from registered DAIs*/
 	list_for_each_entry(cpu_dai, &dai_list, list) {
@@ -836,7 +841,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	if (!rtd->cpu_dai) {
-		dev_err(card->dev, "CPU DAI %s not registered\n",
+		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
 			dai_link->cpu_dai_name);
 		return -EPROBE_DEFER;
 	}
@@ -867,14 +872,14 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		}
 
 		if (!rtd->codec_dai) {
-			dev_err(card->dev, "CODEC DAI %s not registered\n",
+			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
 				dai_link->codec_dai_name);
 			return -EPROBE_DEFER;
 		}
 	}
 
 	if (!rtd->codec) {
-		dev_err(card->dev, "CODEC %s not registered\n",
+		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
 			dai_link->codec_name);
 		return -EPROBE_DEFER;
 	}
@@ -898,7 +903,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		rtd->platform = platform;
 	}
 	if (!rtd->platform) {
-		dev_err(card->dev, "platform %s not registered\n",
+		dev_err(card->dev, "ASoC: platform %s not registered\n",
 			dai_link->platform_name);
 		return -EPROBE_DEFER;
 	}
@@ -915,8 +920,8 @@ static int soc_remove_platform(struct snd_soc_platform *platform)
 	if (platform->driver->remove) {
 		ret = platform->driver->remove(platform);
 		if (ret < 0)
-			pr_err("asoc: failed to remove %s: %d\n",
-				platform->name, ret);
+			dev_err(platform->dev, "ASoC: failed to remove %d\n",
+				ret);
 	}
 
 	/* Make sure all DAPM widgets are freed */
@@ -937,9 +942,7 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 	if (codec->driver->remove) {
 		err = codec->driver->remove(codec);
 		if (err < 0)
-			dev_err(codec->dev,
-				"asoc: failed to remove %s: %d\n",
-				codec->name, err);
+			dev_err(codec->dev, "ASoC: failed to remove %d\n", err);
 	}
 
 	/* Make sure all DAPM widgets are freed */
@@ -971,8 +974,9 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 		if (codec_dai->driver->remove) {
 			err = codec_dai->driver->remove(codec_dai);
 			if (err < 0)
-				pr_err("asoc: failed to remove %s: %d\n",
-							codec_dai->name, err);
+				dev_err(codec_dai->dev,
+					"ASoC: failed to remove %s: %d\n",
+					codec_dai->name, err);
 		}
 		codec_dai->probed = 0;
 		list_del(&codec_dai->card_list);
@@ -984,8 +988,9 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 		if (cpu_dai->driver->remove) {
 			err = cpu_dai->driver->remove(cpu_dai);
 			if (err < 0)
-				pr_err("asoc: failed to remove %s: %d\n",
-							cpu_dai->name, err);
+				dev_err(cpu_dai->dev,
+					"ASoC: failed to remove %s: %d\n",
+					cpu_dai->name, err);
 		}
 		cpu_dai->probed = 0;
 		list_del(&cpu_dai->card_list);
@@ -1099,8 +1104,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		ret = driver->probe(codec);
 		if (ret < 0) {
 			dev_err(codec->dev,
-				"asoc: failed to probe CODEC %s: %d\n",
-				codec->name, ret);
+				"ASoC: failed to probe CODEC %d\n", ret);
 			goto err_probe;
 		}
 	}
@@ -1163,8 +1167,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		ret = driver->probe(platform);
 		if (ret < 0) {
 			dev_err(platform->dev,
-				"asoc: failed to probe platform %s: %d\n",
-				platform->name, ret);
+				"ASoC: failed to probe platform %d\n", ret);
 			goto err_probe;
 		}
 	}
@@ -1229,7 +1232,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	else if (dailess && aux_dev->init)
 		ret = aux_dev->init(&codec->dapm);
 	if (ret < 0) {
-		dev_err(card->dev, "asoc: failed to init %s: %d\n", name, ret);
+		dev_err(card->dev, "ASoC: failed to init %s: %d\n", name, ret);
 		return ret;
 	}
 	codec->name_prefix = temp;
@@ -1253,7 +1256,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	ret = device_add(rtd->dev);
 	if (ret < 0) {
 		dev_err(card->dev,
-			"asoc: failed to register runtime device: %d\n", ret);
+			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
 	}
 	rtd->dev_registered = 1;
@@ -1262,14 +1265,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	ret = snd_soc_dapm_sys_add(rtd->dev);
 	if (ret < 0)
 		dev_err(codec->dev,
-			"asoc: failed to add codec dapm sysfs entries: %d\n",
-			ret);
+			"ASoC: failed to add codec dapm sysfs entries: %d\n", ret);
 
 	/* add codec sysfs entries */
 	ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
 	if (ret < 0)
 		dev_err(codec->dev,
-			"asoc: failed to add codec sysfs files: %d\n", ret);
+			"ASoC: failed to add codec sysfs files: %d\n", ret);
 
 #ifdef CONFIG_DEBUG_FS
 	/* add DPCM sysfs entries */
@@ -1278,7 +1280,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 
 	ret = soc_dpcm_debugfs_add(rtd);
 	if (ret < 0)
-		dev_err(rtd->dev, "asoc: failed to add dpcm sysfs entries: %d\n", ret);
+		dev_err(rtd->dev, "ASoC: failed to add dpcm sysfs entries: %d\n", ret);
 
 out:
 #endif
@@ -1333,7 +1335,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	struct snd_soc_dapm_widget *play_w, *capture_w;
 	int ret;
 
-	dev_dbg(card->dev, "probe %s dai link %d late %d\n",
+	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
 			card->name, num, order);
 
 	/* config components */
@@ -1359,8 +1361,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
 			if (ret < 0) {
-				pr_err("asoc: failed to probe CPU DAI %s: %d\n",
-							cpu_dai->name, ret);
+				dev_err(cpu_dai->dev,
+					"ASoC: failed to probe CPU DAI %s: %d\n",
+					cpu_dai->name, ret);
 				module_put(cpu_dai->dev->driver->owner);
 				return ret;
 			}
@@ -1375,8 +1378,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 		if (codec_dai->driver->probe) {
 			ret = codec_dai->driver->probe(codec_dai);
 			if (ret < 0) {
-				pr_err("asoc: failed to probe CODEC DAI %s: %d\n",
-							codec_dai->name, ret);
+				dev_err(codec_dai->dev,
+					"ASoC: failed to probe CODEC DAI %s: %d\n",
+					codec_dai->name, ret);
 				return ret;
 			}
 		}
@@ -1396,13 +1400,14 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 
 	ret = device_create_file(rtd->dev, &dev_attr_pmdown_time);
 	if (ret < 0)
-		pr_warn("asoc: failed to add pmdown_time sysfs:%d\n", ret);
+		dev_warn(rtd->dev, "ASoC: failed to add pmdown_time sysfs: %d\n",
+			ret);
 
 	if (cpu_dai->driver->compress_dai) {
 		/*create compress_device"*/
 		ret = soc_new_compress(rtd, num);
 		if (ret < 0) {
-			pr_err("asoc: can't create compress %s\n",
+			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
 			return ret;
 		}
@@ -1412,7 +1417,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 			/* create the pcm */
 			ret = soc_new_pcm(rtd, num);
 			if (ret < 0) {
-				pr_err("asoc: can't create pcm %s :%d\n",
+				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 				       dai_link->stream_name, ret);
 				return ret;
 			}
@@ -1424,7 +1429,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				ret = snd_soc_dapm_new_pcm(card, dai_link->params,
 						   capture_w, play_w);
 				if (ret != 0) {
-					dev_err(card->dev, "Can't link %s to %s: %d\n",
+					dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
 						play_w->name, capture_w->name, ret);
 					return ret;
 				}
@@ -1436,7 +1441,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				ret = snd_soc_dapm_new_pcm(card, dai_link->params,
 						   capture_w, play_w);
 				if (ret != 0) {
-					dev_err(card->dev, "Can't link %s to %s: %d\n",
+					dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
 						play_w->name, capture_w->name, ret);
 					return ret;
 				}
@@ -1473,7 +1478,8 @@ static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 
 		ret = soc_ac97_dev_register(rtd->codec);
 		if (ret < 0) {
-			pr_err("asoc: AC97 device register failed:%d\n", ret);
+			dev_err(rtd->codec->dev,
+				"ASoC: AC97 device register failed: %d\n", ret);
 			return ret;
 		}
 
@@ -1502,7 +1508,7 @@ static int soc_check_aux_dev(struct snd_soc_card *card, int num)
 			return 0;
 	}
 
-	dev_err(card->dev, "%s not registered\n", aux_dev->codec_name);
+	dev_err(card->dev, "ASoC: %s not registered\n", aux_dev->codec_name);
 
 	return -EPROBE_DEFER;
 }
@@ -1518,7 +1524,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 		if (!strcmp(codec->name, aux_dev->codec_name)) {
 			if (codec->probed) {
 				dev_err(codec->dev,
-					"asoc: codec already probed");
+					"ASoC: codec already probed");
 				ret = -EBUSY;
 				goto out;
 			}
@@ -1526,7 +1532,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 		}
 	}
 	/* codec not found */
-	dev_err(card->dev, "asoc: codec %s not found", aux_dev->codec_name);
+	dev_err(card->dev, "ASoC: codec %s not found", aux_dev->codec_name);
 	return -EPROBE_DEFER;
 
 found:
@@ -1569,8 +1575,8 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 		codec->compress_type = compress_type;
 	ret = snd_soc_cache_init(codec);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cache compression type: %d\n",
-			ret);
+		dev_err(codec->dev, "ASoC: Failed to set cache compression"
+			" type: %d\n", ret);
 		return ret;
 	}
 	codec->cache_init = 1;
@@ -1626,8 +1632,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			card->owner, 0, &card->snd_card);
 	if (ret < 0) {
-		pr_err("asoc: can't create sound card for card %s: %d\n",
-			card->name, ret);
+		dev_err(card->dev, "ASoC: can't create sound card for"
+			" card %s: %d\n", card->name, ret);
 		goto base_error;
 	}
 	card->snd_card->dev = card->dev;
@@ -1663,8 +1669,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		for (i = 0; i < card->num_links; i++) {
 			ret = soc_probe_link_components(card, i, order);
 			if (ret < 0) {
-				pr_err("asoc: failed to instantiate card %s: %d\n",
-				       card->name, ret);
+				dev_err(card->dev,
+					"ASoC: failed to instantiate card %d\n",
+					ret);
 				goto probe_dai_err;
 			}
 		}
@@ -1676,8 +1683,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		for (i = 0; i < card->num_links; i++) {
 			ret = soc_probe_link_dais(card, i, order);
 			if (ret < 0) {
-				pr_err("asoc: failed to instantiate card %s: %d\n",
-				       card->name, ret);
+				dev_err(card->dev,
+					"ASoC: failed to instantiate card %d\n",
+					ret);
 				goto probe_dai_err;
 			}
 		}
@@ -1686,8 +1694,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_aux_devs; i++) {
 		ret = soc_probe_aux_dev(card, i);
 		if (ret < 0) {
-			pr_err("asoc: failed to add auxiliary devices %s: %d\n",
-			       card->name, ret);
+			dev_err(card->dev,
+				"ASoC: failed to add auxiliary devices %d\n",
+				ret);
 			goto probe_aux_dev_err;
 		}
 	}
@@ -1712,7 +1721,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 						  dai_fmt);
 			if (ret != 0 && ret != -ENOTSUPP)
 				dev_warn(card->rtd[i].codec_dai->dev,
-					 "Failed to set DAI format: %d\n",
+					 "ASoC: Failed to set DAI format: %d\n",
 					 ret);
 		}
 
@@ -1723,7 +1732,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 						  dai_fmt);
 			if (ret != 0 && ret != -ENOTSUPP)
 				dev_warn(card->rtd[i].cpu_dai->dev,
-					 "Failed to set DAI format: %d\n",
+					 "ASoC: Failed to set DAI format: %d\n",
 					 ret);
 		} else if (dai_fmt) {
 			/* Flip the polarity for the "CPU" end */
@@ -1748,7 +1757,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 						  dai_fmt);
 			if (ret != 0 && ret != -ENOTSUPP)
 				dev_warn(card->rtd[i].cpu_dai->dev,
-					 "Failed to set DAI format: %d\n",
+					 "ASoC: Failed to set DAI format: %d\n",
 					 ret);
 		}
 	}
@@ -1775,7 +1784,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	if (card->late_probe) {
 		ret = card->late_probe(card);
 		if (ret < 0) {
-			dev_err(card->dev, "%s late_probe() failed: %d\n",
+			dev_err(card->dev, "ASoC: %s late_probe() failed: %d\n",
 				card->name, ret);
 			goto probe_aux_dev_err;
 		}
@@ -1789,8 +1798,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
-		pr_err("asoc: failed to register soundcard for %s: %d\n",
-							card->name, ret);
+		dev_err(card->dev, "ASoC: failed to register soundcard %d\n",
+				ret);
 		goto probe_aux_dev_err;
 	}
 
@@ -1799,8 +1808,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_rtd; i++) {
 		ret = soc_register_ac97_dai_link(&card->rtd[i]);
 		if (ret < 0) {
-			pr_err("asoc: failed to register AC97 %s: %d\n",
-							card->name, ret);
+			dev_err(card->dev, "ASoC: failed to register AC97:"
+				" %d\n", ret);
 			while (--i >= 0)
 				soc_unregister_ac97_dai_link(card->rtd[i].codec);
 			goto probe_aux_dev_err;
@@ -1846,7 +1855,7 @@ static int soc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	dev_warn(&pdev->dev,
-		 "ASoC machine %s should use snd_soc_register_card()\n",
+		 "ASoC: machine %s should use snd_soc_register_card()\n",
 		 card->name);
 
 	/* Bodge while we unpick instantiation */
@@ -1996,7 +2005,7 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 	unsigned int ret;
 
 	if (!platform->driver->read) {
-		dev_err(platform->dev, "platform has no read back\n");
+		dev_err(platform->dev, "ASoC: platform has no read back\n");
 		return -1;
 	}
 
@@ -2012,7 +2021,7 @@ int snd_soc_platform_write(struct snd_soc_platform *platform,
 					 unsigned int reg, unsigned int val)
 {
 	if (!platform->driver->write) {
-		dev_err(platform->dev, "platform has no write back\n");
+		dev_err(platform->dev, "ASoC: platform has no write back\n");
 		return -1;
 	}
 
@@ -2283,7 +2292,8 @@ static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
 		err = snd_ctl_add(card, snd_soc_cnew(control, data,
 						     control->name, prefix));
 		if (err < 0) {
-			dev_err(dev, "Failed to add %s: %d\n", control->name, err);
+			dev_err(dev, "ASoC: Failed to add %s: %d\n",
+				control->name, err);
 			return err;
 		}
 	}
@@ -3534,15 +3544,14 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 * not both or neither.
 		 */
 		if (!!link->codec_name == !!link->codec_of_node) {
-			dev_err(card->dev,
-				"Neither/both codec name/of_node are set for %s\n",
-				link->name);
+			dev_err(card->dev, "ASoC: Neither/both codec"
+				" name/of_node are set for %s\n", link->name);
 			return -EINVAL;
 		}
 		/* Codec DAI name must be specified */
 		if (!link->codec_dai_name) {
-			dev_err(card->dev, "codec_dai_name not set for %s\n",
-				link->name);
+			dev_err(card->dev, "ASoC: codec_dai_name not"
+				" set for %s\n", link->name);
 			return -EINVAL;
 		}
 
@@ -3551,8 +3560,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 * can be left unspecified, and a dummy platform will be used.
 		 */
 		if (link->platform_name && link->platform_of_node) {
-			dev_err(card->dev,
-				"Both platform name/of_node are set for %s\n", link->name);
+			dev_err(card->dev, "ASoC: Both platform name/of_node"
+				" are set for %s\n", link->name);
 			return -EINVAL;
 		}
 
@@ -3562,9 +3571,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 * name alone..
 		 */
 		if (link->cpu_name && link->cpu_of_node) {
-			dev_err(card->dev,
-				"Neither/both cpu name/of_node are set for %s\n",
-				link->name);
+			dev_err(card->dev, "ASoC: Neither/both "
+				"cpu name/of_node are set for %s\n",link->name);
 			return -EINVAL;
 		}
 		/*
@@ -3573,9 +3581,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 */
 		if (!link->cpu_dai_name &&
 		    !(link->cpu_name || link->cpu_of_node)) {
-			dev_err(card->dev,
-				"Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
-				link->name);
+			dev_err(card->dev, "ASoC: Neither cpu_dai_name nor "
+				"cpu_name/of_node are set for %s\n", link->name);
 			return -EINVAL;
 		}
 	}
@@ -3622,7 +3629,7 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 {
 	if (card->instantiated)
 		soc_cleanup_card_resources(card);
-	dev_dbg(card->dev, "Unregistered card '%s'\n", card->name);
+	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 
 	return 0;
 }
@@ -3679,8 +3686,8 @@ static inline char *fmt_multiple_name(struct device *dev,
 		struct snd_soc_dai_driver *dai_drv)
 {
 	if (dai_drv->name == NULL) {
-		pr_err("asoc: error - multiple DAI %s registered with no name\n",
-				dev_name(dev));
+		dev_err(dev, "ASoC: error - multiple DAI %s registered with"
+				" no name\n", dev_name(dev));
 		return NULL;
 	}
 
@@ -3698,7 +3705,7 @@ int snd_soc_register_dai(struct device *dev,
 	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
 
-	dev_dbg(dev, "dai register %s\n", dev_name(dev));
+	dev_dbg(dev, "ASoC: dai register %s\n", dev_name(dev));
 
 	dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
 	if (dai == NULL)
@@ -3721,7 +3728,7 @@ int snd_soc_register_dai(struct device *dev,
 
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->dev == dev) {
-			dev_dbg(dev, "Mapped DAI %s to CODEC %s\n",
+			dev_dbg(dev, "ASoC: Mapped DAI %s to CODEC %s\n",
 				dai->name, codec->name);
 			dai->codec = codec;
 			break;
@@ -3735,7 +3742,7 @@ int snd_soc_register_dai(struct device *dev,
 
 	mutex_unlock(&client_mutex);
 
-	pr_debug("Registered DAI '%s'\n", dai->name);
+	dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
 
 	return 0;
 }
@@ -3761,7 +3768,7 @@ found:
 	list_del(&dai->list);
 	mutex_unlock(&client_mutex);
 
-	pr_debug("Unregistered DAI '%s'\n", dai->name);
+	dev_dbg(dev, "ASoC: Unregistered DAI '%s'\n", dai->name);
 	kfree(dai->name);
 	kfree(dai);
 }
@@ -3780,7 +3787,7 @@ int snd_soc_register_dais(struct device *dev,
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
-	dev_dbg(dev, "dai register %s #%Zu\n", dev_name(dev), count);
+	dev_dbg(dev, "ASoC: dai register %s #%Zu\n", dev_name(dev), count);
 
 	for (i = 0; i < count; i++) {
 
@@ -3812,8 +3819,8 @@ int snd_soc_register_dais(struct device *dev,
 
 		list_for_each_entry(codec, &codec_list, list) {
 			if (codec->dev == dev) {
-				dev_dbg(dev, "Mapped DAI %s to CODEC %s\n",
-					dai->name, codec->name);
+				dev_dbg(dev, "ASoC: Mapped DAI %s to "
+					"CODEC %s\n", dai->name, codec->name);
 				dai->codec = codec;
 				break;
 			}
@@ -3826,7 +3833,7 @@ int snd_soc_register_dais(struct device *dev,
 
 		mutex_unlock(&client_mutex);
 
-		pr_debug("Registered DAI '%s'\n", dai->name);
+		dev_dbg(dai->dev, "ASoC: Registered DAI '%s'\n", dai->name);
 	}
 
 	return 0;
@@ -3864,7 +3871,7 @@ int snd_soc_register_platform(struct device *dev,
 {
 	struct snd_soc_platform *platform;
 
-	dev_dbg(dev, "platform register %s\n", dev_name(dev));
+	dev_dbg(dev, "ASoC: platform register %s\n", dev_name(dev));
 
 	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
 	if (platform == NULL)
@@ -3888,7 +3895,7 @@ int snd_soc_register_platform(struct device *dev,
 	list_add(&platform->list, &platform_list);
 	mutex_unlock(&client_mutex);
 
-	pr_debug("Registered platform '%s'\n", platform->name);
+	dev_dbg(dev, "ASoC: Registered platform '%s'\n", platform->name);
 
 	return 0;
 }
@@ -3914,7 +3921,7 @@ found:
 	list_del(&platform->list);
 	mutex_unlock(&client_mutex);
 
-	pr_debug("Unregistered platform '%s'\n", platform->name);
+	dev_dbg(dev, "ASoC: Unregistered platform '%s'\n", platform->name);
 	kfree(platform->name);
 	kfree(platform);
 }
@@ -4043,11 +4050,11 @@ int snd_soc_register_codec(struct device *dev,
 	if (num_dai) {
 		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
 		if (ret < 0)
-			dev_err(codec->dev, "Failed to regster DAIs: %d\n",
-				ret);
+			dev_err(codec->dev, "ASoC: Failed to regster"
+				" DAIs: %d\n", ret);
 	}
 
-	pr_debug("Registered codec '%s'\n", codec->name);
+	dev_dbg(codec->dev, "ASoC: Registered codec '%s'\n", codec->name);
 	return 0;
 
 fail:
@@ -4082,7 +4089,7 @@ found:
 	list_del(&codec->list);
 	mutex_unlock(&client_mutex);
 
-	pr_debug("Unregistered codec '%s'\n", codec->name);
+	dev_dbg(codec->dev, "ASoC: Unregistered codec '%s'\n", codec->name);
 
 	snd_soc_cache_exit(codec);
 	kfree(codec->reg_def_copy);
@@ -4106,7 +4113,7 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 	 */
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(card->dev,
-			"Property '%s' could not be read: %d\n",
+			"ASoC: Property '%s' could not be read: %d\n",
 			propname, ret);
 		return ret;
 	}
@@ -4125,15 +4132,13 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 
 	num_routes = of_property_count_strings(np, propname);
 	if (num_routes < 0 || num_routes & 1) {
-		dev_err(card->dev,
-		     "Property '%s' does not exist or its length is not even\n",
-		     propname);
+		dev_err(card->dev, "ASoC: Property '%s' does not exist or its"
+			" length is not even\n", propname);
 		return -EINVAL;
 	}
 	num_routes /= 2;
 	if (!num_routes) {
-		dev_err(card->dev,
-			"Property '%s's length is zero\n",
+		dev_err(card->dev, "ASoC: Property '%s's length is zero\n",
 			propname);
 		return -EINVAL;
 	}
@@ -4142,7 +4147,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			      GFP_KERNEL);
 	if (!routes) {
 		dev_err(card->dev,
-			"Could not allocate DAPM route table\n");
+			"ASoC: Could not allocate DAPM route table\n");
 		return -EINVAL;
 	}
 
@@ -4150,9 +4155,9 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		ret = of_property_read_string_index(np, propname,
 			2 * i, &routes[i].sink);
 		if (ret) {
-			dev_err(card->dev,
-				"Property '%s' index %d could not be read: %d\n",
-				propname, 2 * i, ret);
+			dev_err(card->dev, "ASoC: Property '%s' index %d"
+				" could not be read: %d\n", propname, 2 * i,
+				ret);
 			kfree(routes);
 			return -EINVAL;
 		}
@@ -4160,8 +4165,8 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			(2 * i) + 1, &routes[i].source);
 		if (ret) {
 			dev_err(card->dev,
-				"Property '%s' index %d could not be read: %d\n",
-				propname, (2 * i) + 1, ret);
+				"ASoC: Property '%s' index %d could not be"
+				" read: %d\n", propname, (2 * i) + 1, ret);
 			kfree(routes);
 			return -EINVAL;
 		}
-- 
1.7.10.4
