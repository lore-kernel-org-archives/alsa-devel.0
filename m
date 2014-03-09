From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] ASoC: Consolidate
	snd_soc_register_dai() and snd_soc_register_dais()
Date: Sun,  9 Mar 2014 17:41:45 +0100
Message-ID: <1394383307-7224-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DFEC52655B4
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 17:41:15 +0100 (CET)
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

snd_soc_register_dais() has basically the same code as snd_soc_register_dai(),
but running in a loop. The only difference is that snd_soc_register_dai() calls
fmt_single_name() to generate the DAIs name and snd_soc_register_dais() calls
fmt_multiple_name(). This patch pushes the check in __snd_soc_register_component()
which decides whether to call snd_soc_register_dai() or snd_soc_register_dais()
to snd_soc_register_dais() to decide which naming scheme to use. This allows us
to remove snd_soc_register_dai().

The patch also updates snd_soc_register_dais() to unregister every DAI it finds
for the component rather than trying to unregister one DAI for each DAI that was
registered. Both have the same result since there won't be more DAIs than what
have been registered, but the former is easier to implement.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Fixed compile error that slipped into patch 1, but was fixed in patch 3
---
 sound/soc/soc-core.c | 154 ++++++++++++++-------------------------------------
 1 file changed, 42 insertions(+), 112 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8ddb15c..ae2b7cc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3897,100 +3897,47 @@ static inline char *fmt_multiple_name(struct device *dev,
 }
 
 /**
- * snd_soc_register_dai - Register a DAI with the ASoC core
+ * snd_soc_unregister_dai - Unregister DAIs from the ASoC core
  *
- * @component: The component the DAIs are registered for
- * @dai_drv: DAI driver to use for the DAIs
+ * @component: The component for which the DAIs should be unregistered
  */
-static int snd_soc_register_dai(struct snd_soc_component *component,
-		struct snd_soc_dai_driver *dai_drv)
+static void snd_soc_unregister_dais(struct snd_soc_component *component)
 {
-	struct device *dev = component->dev;
-	struct snd_soc_codec *codec;
-	struct snd_soc_dai *dai;
-
-	dev_dbg(dev, "ASoC: dai register %s\n", dev_name(dev));
-
-	dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
-	if (dai == NULL)
-		return -ENOMEM;
-
-	/* create DAI component name */
-	dai->name = fmt_single_name(dev, &dai->id);
-	if (dai->name == NULL) {
-		kfree(dai);
-		return -ENOMEM;
-	}
-
-	dai->component = component;
-	dai->dev = dev;
-	dai->driver = dai_drv;
-	dai->dapm.dev = dev;
-	if (!dai->driver->ops)
-		dai->driver->ops = &null_dai_ops;
+	struct snd_soc_dai *dai, *_dai;
 
 	mutex_lock(&client_mutex);
+	list_for_each_entry_safe(dai, _dai, &dai_list, list) {
+		if (dai->dev != component->dev)
+			continue;
 
-	list_for_each_entry(codec, &codec_list, list) {
-		if (codec->dev == dev) {
-			dev_dbg(dev, "ASoC: Mapped DAI %s to CODEC %s\n",
-				dai->name, codec->name);
-			dai->codec = codec;
-			break;
-		}
-	}
-
-	if (!dai->codec)
-		dai->dapm.idle_bias_off = 1;
-
-	list_add(&dai->list, &dai_list);
-
-	mutex_unlock(&client_mutex);
-
-	dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
-
-	return 0;
-}
-
-/**
- * snd_soc_unregister_dai - Unregister a DAI from the ASoC core
- *
- * @dai: DAI to unregister
- */
-static void snd_soc_unregister_dai(struct device *dev)
-{
-	struct snd_soc_dai *dai;
+		list_del(&dai->list);
 
-	list_for_each_entry(dai, &dai_list, list) {
-		if (dev == dai->dev)
-			goto found;
+		dev_dbg(component->dev, "ASoC: Unregistered DAI '%s'\n",
+			dai->name);
+		kfree(dai->name);
+		kfree(dai);
 	}
-	return;
-
-found:
-	mutex_lock(&client_mutex);
-	list_del(&dai->list);
 	mutex_unlock(&client_mutex);
-
-	dev_dbg(dev, "ASoC: Unregistered DAI '%s'\n", dai->name);
-	kfree(dai->name);
-	kfree(dai);
 }
 
 /**
- * snd_soc_register_dais - Register multiple DAIs with the ASoC core
+ * snd_soc_register_dais - Register a DAI with the ASoC core
  *
  * @component: The component the DAIs are registered for
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
+ * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
+ *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
-		struct snd_soc_dai_driver *dai_drv, size_t count)
+	struct snd_soc_dai_driver *dai_drv, size_t count,
+	bool legacy_dai_naming)
 {
 	struct device *dev = component->dev;
 	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
-	int i, ret = 0;
+	unsigned int i;
+	int ret;
 
 	dev_dbg(dev, "ASoC: dai register %s #%Zu\n", dev_name(dev), count);
 
@@ -4002,21 +3949,32 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 			goto err;
 		}
 
-		/* create DAI component name */
-		dai->name = fmt_multiple_name(dev, &dai_drv[i]);
+		/*
+		 * Back in the old days when we still had component-less DAIs,
+		 * instead of having a static name, component-less DAIs would
+		 * inherit the name of the parent device so it is possible to
+		 * register multiple instances of the DAI. We still need to keep
+		 * the same naming style even though those DAIs are not
+		 * component-less anymore.
+		 */
+		if (count == 1 && legacy_dai_naming) {
+			dai->name = fmt_single_name(dev, &dai->id);
+		} else {
+			dai->name = fmt_multiple_name(dev, &dai_drv[i]);
+			if (dai_drv[i].id)
+				dai->id = dai_drv[i].id;
+			else
+				dai->id = i;
+		}
 		if (dai->name == NULL) {
 			kfree(dai);
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto err;
 		}
 
 		dai->component = component;
 		dai->dev = dev;
 		dai->driver = &dai_drv[i];
-		if (dai->driver->id)
-			dai->id = dai->driver->id;
-		else
-			dai->id = i;
 		dai->dapm.dev = dev;
 		if (!dai->driver->ops)
 			dai->driver->ops = &null_dai_ops;
@@ -4025,8 +3983,7 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 
 		list_for_each_entry(codec, &codec_list, list) {
 			if (codec->dev == dev) {
-				dev_dbg(dev,
-					"ASoC: Mapped DAI %s to CODEC %s\n",
+				dev_dbg(dev, "ASoC: Mapped DAI %s to CODEC %s\n",
 					dai->name, codec->name);
 				dai->codec = codec;
 				break;
@@ -4040,33 +3997,18 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 
 		mutex_unlock(&client_mutex);
 
-		dev_dbg(dai->dev, "ASoC: Registered DAI '%s'\n", dai->name);
+		dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
 	}
 
 	return 0;
 
 err:
-	for (i--; i >= 0; i--)
-		snd_soc_unregister_dai(dev);
+	snd_soc_unregister_dais(component);
 
 	return ret;
 }
 
 /**
- * snd_soc_unregister_dais - Unregister multiple DAIs from the ASoC core
- *
- * @dai: Array of DAIs to unregister
- * @count: Number of DAIs
- */
-static void snd_soc_unregister_dais(struct device *dev, size_t count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		snd_soc_unregister_dai(dev);
-}
-
-/**
  * snd_soc_register_component - Register a component with the ASoC core
  *
  */
@@ -4097,19 +4039,7 @@ __snd_soc_register_component(struct device *dev,
 	cmpnt->dai_drv	= dai_drv;
 	cmpnt->num_dai	= num_dai;
 
-	/*
-	 * snd_soc_register_dai()  uses fmt_single_name(), and
-	 * snd_soc_register_dais() uses fmt_multiple_name()
-	 * for dai->name which is used for name based matching
-	 *
-	 * this function is used from cpu/codec.
-	 * allow_single_dai flag can ignore "codec" driver reworking
-	 * since it had been used snd_soc_register_dais(),
-	 */
-	if ((1 == num_dai) && allow_single_dai)
-		ret = snd_soc_register_dai(cmpnt, dai_drv);
-	else
-		ret = snd_soc_register_dais(cmpnt, dai_drv, num_dai);
+	ret = snd_soc_register_dais(cmpnt, dai_drv, num_dai, allow_single_dai);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to regster DAIs: %d\n", ret);
 		goto error_component_name;
@@ -4164,7 +4094,7 @@ void snd_soc_unregister_component(struct device *dev)
 	return;
 
 found:
-	snd_soc_unregister_dais(dev, cmpnt->num_dai);
+	snd_soc_unregister_dais(cmpnt);
 
 	mutex_lock(&client_mutex);
 	list_del(&cmpnt->list);
-- 
1.8.0
