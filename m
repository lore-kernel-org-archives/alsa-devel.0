From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 02/11] ASoC: Move name and id from
	CODEC/platform to component
Date: Mon, 16 Jun 2014 18:13:02 +0200
Message-ID: <1402935191-18398-3-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C388265468
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:23 +0200 (CEST)
In-Reply-To: <1402935191-18398-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The component struct already has a name and id field which are initialized to
the same values as the same fields in the CODEC and platform structs. So remove
them from the CODEC and platform structs and used the ones from the component
struct instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h            |  4 ----
 include/trace/events/asoc.h    |  6 ++---
 sound/soc/codecs/tlv320dac33.c |  2 +-
 sound/soc/soc-cache.c          |  7 +++---
 sound/soc/soc-compress.c       |  8 ++++---
 sound/soc/soc-core.c           | 53 ++++++++++++++++--------------------------
 sound/soc/soc-dapm.c           |  8 +++----
 sound/soc/soc-pcm.c            |  4 ++--
 8 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e1cce00..f64bf94 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -710,8 +710,6 @@ struct snd_soc_component {
 
 /* SoC Audio Codec device */
 struct snd_soc_codec {
-	const char *name;
-	int id;
 	struct device *dev;
 	const struct snd_soc_codec_driver *driver;
 
@@ -848,8 +846,6 @@ struct snd_soc_platform_driver {
 };
 
 struct snd_soc_platform {
-	const char *name;
-	int id;
 	struct device *dev;
 	const struct snd_soc_platform_driver *driver;
 
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index c75c795..0194a64 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -296,17 +296,17 @@ TRACE_EVENT(snd_soc_cache_sync,
 	TP_ARGS(codec, type, status),
 
 	TP_STRUCT__entry(
-		__string(	name,		codec->name	)
+		__string(	name,		codec->component.name)
 		__string(	status,		status		)
 		__string(	type,		type		)
 		__field(	int,		id		)
 	),
 
 	TP_fast_assign(
-		__assign_str(name, codec->name);
+		__assign_str(name, codec->component.name);
 		__assign_str(status, status);
 		__assign_str(type, type);
-		__entry->id = codec->id;
+		__entry->id = codec->component.id;
 	),
 
 	TP_printk("codec=%s.%d type=%s status=%s", __get_str(name),
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index df3a750..ff006cc 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1404,7 +1404,7 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 	if (dac33->irq >= 0) {
 		ret = request_irq(dac33->irq, dac33_interrupt_handler,
 				  IRQF_TRIGGER_RISING,
-				  codec->name, codec);
+				  codec->component.name, codec);
 		if (ret < 0) {
 			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",
 						dac33->irq, ret);
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 00e70b6..a9f82b5 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -78,7 +78,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 	mutex_init(&codec->cache_rw_mutex);
 
 	dev_dbg(codec->dev, "ASoC: Initializing cache for %s codec\n",
-				codec->name);
+				codec->component.name);
 
 	if (codec_drv->reg_cache_default)
 		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
@@ -98,8 +98,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 int snd_soc_cache_exit(struct snd_soc_codec *codec)
 {
 	dev_dbg(codec->dev, "ASoC: Destroying cache for %s codec\n",
-			codec->name);
-
+			codec->component.name);
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
 	return 0;
@@ -192,7 +191,7 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 		return 0;
 
 	dev_dbg(codec->dev, "ASoC: Syncing cache for %s codec\n",
-		codec->name);
+		codec->component.name);
 	trace_snd_soc_cache_sync(codec, name, "start");
 	ret = snd_soc_flat_cache_sync(codec);
 	if (!ret)
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 10f7f1d..f96fb96 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -37,7 +37,8 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n", platform->name);
+			pr_err("compress asoc: can't open platform %s\n",
+				platform->component.name);
 			goto out;
 		}
 	}
@@ -84,7 +85,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
-			pr_err("compress asoc: can't open platform %s\n", platform->name);
+			pr_err("compress asoc: can't open platform %s\n",
+				platform->component.name);
 			goto out;
 		}
 	}
@@ -680,7 +682,7 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
 	if (ret < 0) {
 		pr_err("compress asoc: can't create compress for codec %s\n",
-			codec->name);
+			codec->component.name);
 		goto compr_err;
 	}
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ba822e9..b8cc88a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -274,7 +274,7 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
 	struct dentry *debugfs_card_root = codec->card->debugfs_card_root;
 
-	codec->debugfs_codec_root = debugfs_create_dir(codec->name,
+	codec->debugfs_codec_root = debugfs_create_dir(codec->component.name,
 						       debugfs_card_root);
 	if (!codec->debugfs_codec_root) {
 		dev_warn(codec->dev,
@@ -306,8 +306,8 @@ static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
 {
 	struct dentry *debugfs_card_root = platform->card->debugfs_card_root;
 
-	platform->debugfs_platform_root = debugfs_create_dir(platform->name,
-						       debugfs_card_root);
+	platform->debugfs_platform_root = debugfs_create_dir(
+		platform->component.name, debugfs_card_root);
 	if (!platform->debugfs_platform_root) {
 		dev_warn(platform->dev,
 			"ASoC: Failed to create platform debugfs directory\n");
@@ -335,7 +335,7 @@ static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
 
 	list_for_each_entry(codec, &codec_list, list) {
 		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-			       codec->name);
+			       codec->component.name);
 		if (len >= 0)
 			ret += len;
 		if (ret > PAGE_SIZE) {
@@ -406,7 +406,7 @@ static ssize_t platform_list_read_file(struct file *file,
 
 	list_for_each_entry(platform, &platform_list, list) {
 		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-			       platform->name);
+			       platform->component.name);
 		if (len >= 0)
 			ret += len;
 		if (ret > PAGE_SIZE) {
@@ -528,7 +528,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-		     codec->card->snd_card->number, 0, codec->name);
+		     codec->card->snd_card->number, 0, codec->component.name);
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
 		dev_err(codec->dev, "ASoC: Can't register ac97 bus\n");
@@ -857,7 +857,7 @@ static struct snd_soc_codec *soc_find_codec(const struct device_node *codec_of_n
 			if (codec->dev->of_node != codec_of_node)
 				continue;
 		} else {
-			if (strcmp(codec->name, codec_name))
+			if (strcmp(codec->component.name, codec_name))
 				continue;
 		}
 
@@ -945,7 +945,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 			    dai_link->platform_of_node)
 				continue;
 		} else {
-			if (strcmp(platform->name, platform_name))
+			if (strcmp(platform->component.name, platform_name))
 				continue;
 		}
 
@@ -1177,7 +1177,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		WARN(codec->dapm.idle_bias_off &&
 			codec->dapm.bias_level != SND_SOC_BIAS_OFF,
 			"codec %s can not start from non-off bias with idle_bias_off==1\n",
-			codec->name);
+			codec->component.name);
 	}
 
 	if (driver->controls)
@@ -1647,7 +1647,8 @@ static struct snd_soc_codec *soc_find_matching_codec(struct snd_soc_card *card,
 		if (aux_dev->codec_of_node &&
 		   (codec->dev->of_node != aux_dev->codec_of_node))
 			continue;
-		if (aux_dev->codec_name && strcmp(codec->name, aux_dev->codec_name))
+		if (aux_dev->codec_name &&
+			strcmp(codec->component.name, aux_dev->codec_name))
 			continue;
 		return codec;
 	}
@@ -4131,11 +4132,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 {
 	int ret;
 
-	/* create platform component name */
-	platform->name = fmt_single_name(dev, &platform->id);
-	if (platform->name == NULL)
-		return -ENOMEM;
-
 	platform->dev = dev;
 	platform->driver = platform_drv;
 	platform->dapm.dev = dev;
@@ -4161,7 +4157,8 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 	list_add(&platform->list, &platform_list);
 	mutex_unlock(&client_mutex);
 
-	dev_dbg(dev, "ASoC: Registered platform '%s'\n", platform->name);
+	dev_dbg(dev, "ASoC: Registered platform '%s'\n",
+		platform->component.name);
 
 	return 0;
 }
@@ -4205,8 +4202,7 @@ void snd_soc_remove_platform(struct snd_soc_platform *platform)
 	mutex_unlock(&client_mutex);
 
 	dev_dbg(platform->dev, "ASoC: Unregistered platform '%s'\n",
-		platform->name);
-	kfree(platform->name);
+		platform->component.name);
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_platform);
 
@@ -4312,13 +4308,6 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec == NULL)
 		return -ENOMEM;
 
-	/* create CODEC component name */
-	codec->name = fmt_single_name(dev, &codec->id);
-	if (codec->name == NULL) {
-		ret = -ENOMEM;
-		goto fail_codec;
-	}
-
 	if (codec_drv->write)
 		codec->component.write = snd_soc_codec_drv_write;
 	if (codec_drv->read)
@@ -4368,19 +4357,17 @@ int snd_soc_register_codec(struct device *dev,
 					   codec, dai_drv, num_dai, false);
 	if (ret < 0) {
 		dev_err(codec->dev, "ASoC: Failed to regster component: %d\n", ret);
-		goto fail_codec_name;
+		goto fail_codec;
 	}
 
-	dev_dbg(codec->dev, "ASoC: Registered codec '%s'\n", codec->name);
+	dev_dbg(codec->dev, "ASoC: Registered codec '%s'\n",
+		codec->component.name);
 	return 0;
 
-fail_codec_name:
+fail_codec:
 	mutex_lock(&client_mutex);
 	list_del(&codec->list);
 	mutex_unlock(&client_mutex);
-
-	kfree(codec->name);
-fail_codec:
 	kfree(codec);
 	return ret;
 }
@@ -4408,10 +4395,10 @@ found:
 	list_del(&codec->list);
 	mutex_unlock(&client_mutex);
 
-	dev_dbg(codec->dev, "ASoC: Unregistered codec '%s'\n", codec->name);
+	dev_dbg(codec->dev, "ASoC: Unregistered codec '%s'\n",
+			codec->component.name);
 
 	snd_soc_cache_exit(codec);
-	kfree(codec->name);
 	kfree(codec);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8e08ace..f3ccf6d1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3403,8 +3403,8 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 			source = cpu_dai->playback_widget;
 			sink = codec_dai->playback_widget;
 			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				cpu_dai->codec->name, source->name,
-				codec_dai->platform->name, sink->name);
+				cpu_dai->component->name, source->name,
+				codec_dai->component->name, sink->name);
 
 			snd_soc_dapm_add_path(&card->dapm, source, sink,
 				NULL, NULL);
@@ -3415,8 +3415,8 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 			source = codec_dai->capture_widget;
 			sink = cpu_dai->capture_widget;
 			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				codec_dai->codec->name, source->name,
-				cpu_dai->platform->name, sink->name);
+				codec_dai->component->name, source->name,
+				cpu_dai->component->name, sink->name);
 
 			snd_soc_dapm_add_path(&card->dapm, source, sink,
 				NULL, NULL);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 54d18f2..9b78bb6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -376,7 +376,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		ret = platform->driver->ops->open(substream);
 		if (ret < 0) {
 			dev_err(platform->dev, "ASoC: can't open platform"
-				" %s: %d\n", platform->name, ret);
+				" %s: %d\n", platform->component.name, ret);
 			goto platform_err;
 		}
 	}
@@ -707,7 +707,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		ret = platform->driver->ops->hw_params(substream, params);
 		if (ret < 0) {
 			dev_err(platform->dev, "ASoC: %s hw params failed: %d\n",
-			       platform->name, ret);
+			       platform->component.name, ret);
 			goto platform_err;
 		}
 	}
-- 
1.8.0
