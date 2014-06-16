From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 03/11] ASoC: Split component registration
	into two steps
Date: Mon, 16 Jun 2014 18:13:03 +0200
Message-ID: <1402935191-18398-4-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AADF265482
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:24 +0200 (CEST)
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

Split snd_soc_component_register() into snd_soc_component_initialize() and
snd_soc_component_add(). Using a 2-stage registration approach has the advantage
that it is possible to modify the component after it has been initialized, but
before it is made visible to the system. This e.g. allows CODECs or platforms to
overwrite some of the default settings made in snd_soc_component_initialize().

Similar snd_soc_component_unregister() is split into two steps as well,
snd_soc_component_delete(), which removes the component from the system, and
snd_soc_component_cleanup(), which frees all the resources allocated by the
component.

Furthermore this patch makes sure that if a component is visible on two list
(e.g. the component list and the CODEC list) it is added or removed to both
lists atomically.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 177 ++++++++++++++++++++++++++-------------------------
 1 file changed, 91 insertions(+), 86 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b8cc88a..0944da6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3922,16 +3922,14 @@ static void snd_soc_unregister_dais(struct snd_soc_component *component)
  * snd_soc_register_dais - Register a DAI with the ASoC core
  *
  * @component: The component the DAIs are registered for
- * @codec: The CODEC that the DAIs are registered for, NULL if the component is
- *         not a CODEC.
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
  * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
  *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
-	struct snd_soc_codec *codec, struct snd_soc_dai_driver *dai_drv,
-	size_t count, bool legacy_dai_naming)
+	struct snd_soc_dai_driver *dai_drv, size_t count,
+	bool legacy_dai_naming)
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
@@ -3940,6 +3938,9 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 
 	dev_dbg(dev, "ASoC: dai register %s #%Zu\n", dev_name(dev), count);
 
+	component->dai_drv = dai_drv;
+	component->num_dai = count;
+
 	for (i = 0; i < count; i++) {
 
 		dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
@@ -3972,7 +3973,6 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 		}
 
 		dai->component = component;
-		dai->codec = codec;
 		dai->dev = dev;
 		dai->driver = &dai_drv[i];
 		dai->dapm.dev = dev;
@@ -3995,60 +3995,52 @@ err:
 	return ret;
 }
 
-/**
- * snd_soc_register_component - Register a component with the ASoC core
- *
- */
-static int
-__snd_soc_register_component(struct device *dev,
-			     struct snd_soc_component *cmpnt,
-			     const struct snd_soc_component_driver *cmpnt_drv,
-			     struct snd_soc_codec *codec,
-			     struct snd_soc_dai_driver *dai_drv,
-			     int num_dai, bool allow_single_dai)
+static int snd_soc_component_initialize(struct snd_soc_component *component,
+	const struct snd_soc_component_driver *driver, struct device *dev)
 {
-	int ret;
-
-	dev_dbg(dev, "component register %s\n", dev_name(dev));
-
-	if (!cmpnt) {
-		dev_err(dev, "ASoC: Failed to connecting component\n");
+	component->name = fmt_single_name(dev, &component->id);
+	if (!component->name) {
+		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
 	}
 
-	mutex_init(&cmpnt->io_mutex);
+	component->dev = dev;
+	component->driver = driver;
 
-	cmpnt->name = fmt_single_name(dev, &cmpnt->id);
-	if (!cmpnt->name) {
-		dev_err(dev, "ASoC: Failed to simplifying name\n");
-		return -ENOMEM;
-	}
+	INIT_LIST_HEAD(&component->dai_list);
+	mutex_init(&component->io_mutex);
 
-	cmpnt->dev	= dev;
-	cmpnt->driver	= cmpnt_drv;
-	cmpnt->dai_drv	= dai_drv;
-	cmpnt->num_dai	= num_dai;
-	INIT_LIST_HEAD(&cmpnt->dai_list);
+	return 0;
+}
 
-	ret = snd_soc_register_dais(cmpnt, codec, dai_drv, num_dai,
-		allow_single_dai);
-	if (ret < 0) {
-		dev_err(dev, "ASoC: Failed to regster DAIs: %d\n", ret);
-		goto error_component_name;
-	}
+static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
+{
+	list_add(&component->list, &component_list);
+}
 
+static void snd_soc_component_add(struct snd_soc_component *component)
+{
 	mutex_lock(&client_mutex);
-	list_add(&cmpnt->list, &component_list);
+	snd_soc_component_add_unlocked(component);
 	mutex_unlock(&client_mutex);
+}
 
-	dev_dbg(cmpnt->dev, "ASoC: Registered component '%s'\n", cmpnt->name);
-
-	return ret;
+static void snd_soc_component_cleanup(struct snd_soc_component *component)
+{
+	snd_soc_unregister_dais(component);
+	kfree(component->name);
+}
 
-error_component_name:
-	kfree(cmpnt->name);
+static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
+{
+	list_del(&component->list);
+}
 
-	return ret;
+static void snd_soc_component_del(struct snd_soc_component *component)
+{
+	mutex_lock(&client_mutex);
+	snd_soc_component_del_unlocked(component);
+	mutex_unlock(&client_mutex);
 }
 
 int snd_soc_register_component(struct device *dev,
@@ -4057,32 +4049,38 @@ int snd_soc_register_component(struct device *dev,
 			       int num_dai)
 {
 	struct snd_soc_component *cmpnt;
+	int ret;
 
-	cmpnt = devm_kzalloc(dev, sizeof(*cmpnt), GFP_KERNEL);
+	cmpnt = kzalloc(sizeof(*cmpnt), GFP_KERNEL);
 	if (!cmpnt) {
 		dev_err(dev, "ASoC: Failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
+	ret = snd_soc_component_initialize(cmpnt, cmpnt_drv, dev);
+	if (ret)
+		goto err_free;
+
 	cmpnt->ignore_pmdown_time = true;
 	cmpnt->registered_as_component = true;
 
-	return __snd_soc_register_component(dev, cmpnt, cmpnt_drv, NULL,
-					    dai_drv, num_dai, true);
-}
-EXPORT_SYMBOL_GPL(snd_soc_register_component);
+	ret = snd_soc_register_dais(cmpnt, dai_drv, num_dai, true);
+	if (ret < 0) {
+		dev_err(dev, "ASoC: Failed to regster DAIs: %d\n", ret);
+		goto err_cleanup;
+	}
 
-static void __snd_soc_unregister_component(struct snd_soc_component *cmpnt)
-{
-	snd_soc_unregister_dais(cmpnt);
+	snd_soc_component_add(cmpnt);
 
-	mutex_lock(&client_mutex);
-	list_del(&cmpnt->list);
-	mutex_unlock(&client_mutex);
+	return 0;
 
-	dev_dbg(cmpnt->dev, "ASoC: Unregistered component '%s'\n", cmpnt->name);
-	kfree(cmpnt->name);
+err_cleanup:
+	snd_soc_component_cleanup(cmpnt);
+err_free:
+	kfree(cmpnt);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_register_component);
 
 /**
  * snd_soc_unregister_component - Unregister a component from the ASoC core
@@ -4099,7 +4097,9 @@ void snd_soc_unregister_component(struct device *dev)
 	return;
 
 found:
-	__snd_soc_unregister_component(cmpnt);
+	snd_soc_component_del(cmpnt);
+	snd_soc_component_cleanup(cmpnt);
+	kfree(cmpnt);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
@@ -4132,6 +4132,11 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 {
 	int ret;
 
+	ret = snd_soc_component_initialize(&platform->component,
+			&platform_drv->component_driver, dev);
+	if (ret)
+		return ret;
+
 	platform->dev = dev;
 	platform->driver = platform_drv;
 	platform->dapm.dev = dev;
@@ -4143,17 +4148,8 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 	if (platform_drv->read)
 		platform->component.read = snd_soc_platform_drv_read;
 
-	/* register component */
-	ret = __snd_soc_register_component(dev, &platform->component,
-					   &platform_drv->component_driver,
-					   NULL, NULL, 0, false);
-	if (ret < 0) {
-		dev_err(platform->component.dev,
-			"ASoC: Failed to register component: %d\n", ret);
-		return ret;
-	}
-
 	mutex_lock(&client_mutex);
+	snd_soc_component_add_unlocked(&platform->component);
 	list_add(&platform->list, &platform_list);
 	mutex_unlock(&client_mutex);
 
@@ -4195,12 +4191,14 @@ EXPORT_SYMBOL_GPL(snd_soc_register_platform);
  */
 void snd_soc_remove_platform(struct snd_soc_platform *platform)
 {
-	__snd_soc_unregister_component(&platform->component);
 
 	mutex_lock(&client_mutex);
 	list_del(&platform->list);
+	snd_soc_component_del_unlocked(&platform->component);
 	mutex_unlock(&client_mutex);
 
+	snd_soc_component_cleanup(&platform->component);
+
 	dev_dbg(platform->dev, "ASoC: Unregistered platform '%s'\n",
 		platform->component.name);
 }
@@ -4299,6 +4297,7 @@ int snd_soc_register_codec(struct device *dev,
 			   int num_dai)
 {
 	struct snd_soc_codec *codec;
+	struct snd_soc_dai *dai;
 	struct regmap *regmap;
 	int ret, i;
 
@@ -4308,6 +4307,11 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec == NULL)
 		return -ENOMEM;
 
+	ret = snd_soc_component_initialize(&codec->component,
+			&codec_drv->component_driver, dev);
+	if (ret)
+		goto err_free;
+
 	if (codec_drv->write)
 		codec->component.write = snd_soc_codec_drv_write;
 	if (codec_drv->read)
@@ -4337,7 +4341,7 @@ int snd_soc_register_codec(struct device *dev,
 				dev_err(codec->dev,
 						"Failed to set cache I/O:%d\n",
 						ret);
-				return ret;
+				goto err_cleanup;
 			}
 		}
 	}
@@ -4347,27 +4351,27 @@ int snd_soc_register_codec(struct device *dev,
 		fixup_codec_formats(&dai_drv[i].capture);
 	}
 
+	ret = snd_soc_register_dais(&codec->component, dai_drv, num_dai, false);
+	if (ret < 0) {
+		dev_err(dev, "ASoC: Failed to regster DAIs: %d\n", ret);
+		goto err_cleanup;
+	}
+
+	list_for_each_entry(dai, &codec->component.dai_list, list)
+		dai->codec = codec;
+
 	mutex_lock(&client_mutex);
+	snd_soc_component_add_unlocked(&codec->component);
 	list_add(&codec->list, &codec_list);
 	mutex_unlock(&client_mutex);
 
-	/* register component */
-	ret = __snd_soc_register_component(dev, &codec->component,
-					   &codec_drv->component_driver,
-					   codec, dai_drv, num_dai, false);
-	if (ret < 0) {
-		dev_err(codec->dev, "ASoC: Failed to regster component: %d\n", ret);
-		goto fail_codec;
-	}
-
 	dev_dbg(codec->dev, "ASoC: Registered codec '%s'\n",
 		codec->component.name);
 	return 0;
 
-fail_codec:
-	mutex_lock(&client_mutex);
-	list_del(&codec->list);
-	mutex_unlock(&client_mutex);
+err_cleanup:
+	snd_soc_component_cleanup(&codec->component);
+err_free:
 	kfree(codec);
 	return ret;
 }
@@ -4389,15 +4393,16 @@ void snd_soc_unregister_codec(struct device *dev)
 	return;
 
 found:
-	__snd_soc_unregister_component(&codec->component);
 
 	mutex_lock(&client_mutex);
 	list_del(&codec->list);
+	snd_soc_component_del_unlocked(&codec->component);
 	mutex_unlock(&client_mutex);
 
 	dev_dbg(codec->dev, "ASoC: Unregistered codec '%s'\n",
 			codec->component.name);
 
+	snd_soc_component_cleanup(&codec->component);
 	snd_soc_cache_exit(codec);
 	kfree(codec);
 }
-- 
1.8.0
