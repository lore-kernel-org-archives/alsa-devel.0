From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/13] ASoC: Move debugfs registration to the
	component level
Date: Tue, 19 Aug 2014 15:51:18 +0200
Message-ID: <1408456290-13945-2-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 35EE3265661
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:41 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The debugfs registration is mostly identical between platforms and CODECs. This
patches consolidates the two implementations at the component level.

Unfortunately there are still a couple of CODEC specific debugfs files that are
related to legacy ASoC IO that need to be registered. For this a new callback is
added to the component struct that will be initialized when a CODEC is
registered and will be used to register the CODEC specific files. Once there are
no drivers left using legacy IO this can be removed again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  20 ++++++---
 sound/soc/soc-core.c | 122 ++++++++++++++++++++++-----------------------------
 2 files changed, 67 insertions(+), 75 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6f6064a..4506de8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -728,9 +728,24 @@ struct snd_soc_component {
 
 	struct mutex io_mutex;
 
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_root;
+#endif
+
+	/*
+	* DO NOT use any of the fields below in drivers, they are temporary and
+	* are going to be removed again soon. If you use them in driver code the
+	* driver will be marked as BROKEN when these fields are removed.
+	*/
+
 	/* Don't use these, use snd_soc_component_get_dapm() */
 	struct snd_soc_dapm_context dapm;
 	struct snd_soc_dapm_context *dapm_ptr;
+
+#ifdef CONFIG_DEBUG_FS
+	void (*init_debugfs)(struct snd_soc_component *component);
+	const char *debugfs_prefix;
+#endif
 };
 
 /* SoC Audio Codec device */
@@ -766,7 +781,6 @@ struct snd_soc_codec {
 	struct snd_soc_dapm_context dapm;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_codec_root;
 	struct dentry *debugfs_reg;
 #endif
 };
@@ -879,10 +893,6 @@ struct snd_soc_platform {
 	struct list_head list;
 
 	struct snd_soc_component component;
-
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_platform_root;
-#endif
 };
 
 struct snd_soc_dai_link {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 889f4e3..8d1e319 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -270,79 +270,56 @@ static const struct file_operations codec_reg_fops = {
 	.llseek = default_llseek,
 };
 
-static struct dentry *soc_debugfs_create_dir(struct dentry *parent,
-	const char *fmt, ...)
+static void soc_init_component_debugfs(struct snd_soc_component *component)
 {
-	struct dentry *de;
-	va_list ap;
-	char *s;
+	if (component->debugfs_prefix) {
+		char *name;
 
-	va_start(ap, fmt);
-	s = kvasprintf(GFP_KERNEL, fmt, ap);
-	va_end(ap);
+		name = kasprintf(GFP_KERNEL, "%s:%s",
+			component->debugfs_prefix, component->name);
+		if (name) {
+			component->debugfs_root = debugfs_create_dir(name,
+				component->card->debugfs_card_root);
+			kfree(name);
+		}
+	} else {
+		component->debugfs_root = debugfs_create_dir(component->name,
+				component->card->debugfs_card_root);
+	}
 
-	if (!s)
-		return NULL;
+	if (!component->debugfs_root) {
+		dev_warn(component->dev,
+			"ASoC: Failed to create component debugfs directory\n");
+		return;
+	}
 
-	de = debugfs_create_dir(s, parent);
-	kfree(s);
+	snd_soc_dapm_debugfs_init(snd_soc_component_get_dapm(component),
+		component->debugfs_root);
 
-	return de;
+	if (component->init_debugfs)
+		component->init_debugfs(component);
 }
 
-static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
+static void soc_cleanup_component_debugfs(struct snd_soc_component *component)
 {
-	struct dentry *debugfs_card_root = codec->component.card->debugfs_card_root;
+	debugfs_remove_recursive(component->debugfs_root);
+}
 
-	codec->debugfs_codec_root = soc_debugfs_create_dir(debugfs_card_root,
-						"codec:%s",
-						codec->component.name);
-	if (!codec->debugfs_codec_root) {
-		dev_warn(codec->dev,
-			"ASoC: Failed to create codec debugfs directory\n");
-		return;
-	}
+static void soc_init_codec_debugfs(struct snd_soc_component *component)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-	debugfs_create_bool("cache_sync", 0444, codec->debugfs_codec_root,
+	debugfs_create_bool("cache_sync", 0444, codec->component.debugfs_root,
 			    &codec->cache_sync);
-	debugfs_create_bool("cache_only", 0444, codec->debugfs_codec_root,
+	debugfs_create_bool("cache_only", 0444, codec->component.debugfs_root,
 			    &codec->cache_only);
 
 	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
-						 codec->debugfs_codec_root,
+						 codec->component.debugfs_root,
 						 codec, &codec_reg_fops);
 	if (!codec->debugfs_reg)
 		dev_warn(codec->dev,
 			"ASoC: Failed to create codec register debugfs file\n");
-
-	snd_soc_dapm_debugfs_init(&codec->dapm, codec->debugfs_codec_root);
-}
-
-static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
-{
-	debugfs_remove_recursive(codec->debugfs_codec_root);
-}
-
-static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
-{
-	struct dentry *debugfs_card_root = platform->component.card->debugfs_card_root;
-
-	platform->debugfs_platform_root = soc_debugfs_create_dir(debugfs_card_root,
-						"platform:%s",
-						platform->component.name);
-	if (!platform->debugfs_platform_root) {
-		dev_warn(platform->dev,
-			"ASoC: Failed to create platform debugfs directory\n");
-		return;
-	}
-
-	snd_soc_dapm_debugfs_init(&platform->component.dapm,
-		platform->debugfs_platform_root);
-}
-
-static void soc_cleanup_platform_debugfs(struct snd_soc_platform *platform)
-{
-	debugfs_remove_recursive(platform->debugfs_platform_root);
 }
 
 static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
@@ -474,19 +451,15 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 
 #else
 
-static inline void soc_init_codec_debugfs(struct snd_soc_codec *codec)
-{
-}
+#define soc_init_codec_debugfs NULL
 
-static inline void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
+static inline void soc_init_component_debugfs(
+	struct snd_soc_component *component)
 {
 }
 
-static inline void soc_init_platform_debugfs(struct snd_soc_platform *platform)
-{
-}
-
-static inline void soc_cleanup_platform_debugfs(struct snd_soc_platform *platform)
+static inline void soc_cleanup_component_debugfs(
+	struct snd_soc_component *component)
 {
 }
 
@@ -1026,7 +999,7 @@ static int soc_remove_platform(struct snd_soc_platform *platform)
 	/* Make sure all DAPM widgets are freed */
 	snd_soc_dapm_free(&platform->component.dapm);
 
-	soc_cleanup_platform_debugfs(platform);
+	soc_cleanup_component_debugfs(&platform->component);
 	platform->probed = 0;
 	module_put(platform->dev->driver->owner);
 
@@ -1046,7 +1019,7 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 	/* Make sure all DAPM widgets are freed */
 	snd_soc_dapm_free(&codec->dapm);
 
-	soc_cleanup_codec_debugfs(codec);
+	soc_cleanup_component_debugfs(&codec->component);
 	codec->probed = 0;
 	list_del(&codec->card_list);
 	module_put(codec->dev->driver->owner);
@@ -1187,7 +1160,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	if (!try_module_get(codec->dev->driver->owner))
 		return -ENODEV;
 
-	soc_init_codec_debugfs(codec);
+	soc_init_component_debugfs(&codec->component);
 
 	if (driver->dapm_widgets) {
 		ret = snd_soc_dapm_new_controls(&codec->dapm,
@@ -1242,7 +1215,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	return 0;
 
 err_probe:
-	soc_cleanup_codec_debugfs(codec);
+	soc_cleanup_component_debugfs(&codec->component);
 	module_put(codec->dev->driver->owner);
 
 	return ret;
@@ -1262,7 +1235,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	if (!try_module_get(platform->dev->driver->owner))
 		return -ENODEV;
 
-	soc_init_platform_debugfs(platform);
+	soc_init_component_debugfs(&platform->component);
 
 	if (driver->dapm_widgets)
 		snd_soc_dapm_new_controls(&platform->component.dapm,
@@ -1302,7 +1275,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	return 0;
 
 err_probe:
-	soc_cleanup_platform_debugfs(platform);
+	soc_cleanup_component_debugfs(&platform->component);
 	module_put(platform->dev->driver->owner);
 
 	return ret;
@@ -4266,6 +4239,10 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 	if (platform_drv->read)
 		platform->component.read = snd_soc_platform_drv_read;
 
+#ifdef CONFIG_DEBUG_FS
+	platform->component.debugfs_prefix = "platform";
+#endif
+
 	mutex_lock(&client_mutex);
 	snd_soc_component_add_unlocked(&platform->component);
 	list_add(&platform->list, &platform_list);
@@ -4455,6 +4432,11 @@ int snd_soc_register_codec(struct device *dev,
 	codec->component.val_bytes = codec_drv->reg_word_size;
 	mutex_init(&codec->mutex);
 
+#ifdef CONFIG_DEBUG_FS
+	codec->component.init_debugfs = soc_init_codec_debugfs;
+	codec->component.debugfs_prefix = "codec";
+#endif
+
 	if (!codec->component.write) {
 		if (codec_drv->get_regmap)
 			regmap = codec_drv->get_regmap(dev);
-- 
1.8.0
