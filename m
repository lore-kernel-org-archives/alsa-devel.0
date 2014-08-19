From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/13] ASoC: Automatically initialize regmap
	for all components
Date: Tue, 19 Aug 2014 15:51:28 +0200
Message-ID: <1408456290-13945-12-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 430D32657BD
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:54 +0200 (CEST)
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

So far regmap is only automatically initialized for CODECs. Now that we have the
infrastructure in place to let components have DAPM widgets and controls that
want to use the generic regmap based IO also make sure to automatically
initialize regmap for all components.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  3 ---
 sound/soc/soc-core.c | 35 +++++++++++++++++------------------
 sound/soc/soc-io.c   | 28 ----------------------------
 3 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f8abe22..d4ba8048 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1289,9 +1289,6 @@ void snd_soc_component_async_complete(struct snd_soc_component *component);
 int snd_soc_component_test_bits(struct snd_soc_component *component,
 	unsigned int reg, unsigned int mask, unsigned int value);
 
-int snd_soc_component_init_io(struct snd_soc_component *component,
-	struct regmap *regmap);
-
 /* device driver data */
 
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9d05a28..5c78098 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4032,8 +4032,23 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	return 0;
 }
 
+static void snd_soc_component_init_regmap(struct snd_soc_component *component)
+{
+	if (!component->regmap)
+		component->regmap = dev_get_regmap(component->dev, NULL);
+	if (component->regmap) {
+		int val_bytes = regmap_get_val_bytes(component->regmap);
+		/* Errors are legitimate for non-integer byte multiples */
+		if (val_bytes > 0)
+			component->val_bytes = val_bytes;
+	}
+}
+
 static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
 {
+	if (!component->write && !component->read)
+		snd_soc_component_init_regmap(component);
+
 	list_add(&component->list, &component_list);
 }
 
@@ -4371,7 +4386,6 @@ int snd_soc_register_codec(struct device *dev,
 {
 	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
-	struct regmap *regmap;
 	int ret, i;
 
 	dev_dbg(dev, "codec register %s\n", dev_name(dev));
@@ -4425,23 +4439,8 @@ int snd_soc_register_codec(struct device *dev,
 	codec->component.debugfs_prefix = "codec";
 #endif
 
-	if (!codec->component.write) {
-		if (codec_drv->get_regmap)
-			regmap = codec_drv->get_regmap(dev);
-		else
-			regmap = dev_get_regmap(dev, NULL);
-
-		if (regmap) {
-			ret = snd_soc_component_init_io(&codec->component,
-				regmap);
-			if (ret) {
-				dev_err(codec->dev,
-						"Failed to set cache I/O:%d\n",
-						ret);
-				goto err_cleanup;
-			}
-		}
-	}
+	if (codec_drv->get_regmap)
+		codec->component.regmap = codec_drv->get_regmap(dev);
 
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 7767fbd..9b39390 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -271,31 +271,3 @@ int snd_soc_platform_write(struct snd_soc_platform *platform,
 	return snd_soc_component_write(&platform->component, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_write);
-
-/**
- * snd_soc_component_init_io() - Initialize regmap IO
- *
- * @component: component to initialize
- * @regmap: regmap instance to use for IO operations
- *
- * Return: 0 on success, a negative error code otherwise
- */
-int snd_soc_component_init_io(struct snd_soc_component *component,
-	struct regmap *regmap)
-{
-	int ret;
-
-	if (!regmap)
-		return -EINVAL;
-
-	ret = regmap_get_val_bytes(regmap);
-	/* Errors are legitimate for non-integer byte
-	 * multiples */
-	if (ret > 0)
-		component->val_bytes = ret;
-
-	component->regmap = regmap;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_component_init_io);
-- 
1.8.0
