From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: Pass CODEC to snd_soc_register_dais()
Date: Sun,  9 Mar 2014 11:59:50 +0100
Message-ID: <1394362791-3188-2-git-send-email-lars@metafoo.de>
References: <1394362791-3188-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-136.synserver.de
 [212.40.185.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A49B265580
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 11:59:29 +0100 (CET)
In-Reply-To: <1394362791-3188-1-git-send-email-lars@metafoo.de>
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

snd_soc_register_dais() looks up the CODEC that is registering the DAIs by
looping over all registered CODECs. This patch updates the code to
simply pass the CODEC that registers the DAIs to snd_soc_register_dais() thus
avoiding the lookup.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2fe0338..7e43e27 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3923,17 +3923,18 @@ static void snd_soc_unregister_dais(struct snd_soc_component *component)
  * snd_soc_register_dais - Register a DAI with the ASoC core
  *
  * @component: The component the DAIs are registered for
+ * @codec: The CODEC that the DAIs are registered for, NULL if the component is
+ *         not a CODEC.
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
  * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
  *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
-	struct snd_soc_dai_driver *dai_drv, size_t count,
-	bool legacy_dai_naming)
+	struct snd_soc_codec *codec, struct snd_soc_dai_driver *dai_drv,
+	size_t count, bool legacy_dai_naming)
 {
 	struct device *dev = component->dev;
-	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
 	unsigned int i;
 	int ret;
@@ -3972,28 +3973,19 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 		}
 
 		dai->component = component;
+		dai->codec = codec;
 		dai->dev = dev;
 		dai->driver = &dai_drv[i];
 		dai->dapm.dev = dev;
 		if (!dai->driver->ops)
 			dai->driver->ops = &null_dai_ops;
 
-		mutex_lock(&client_mutex);
-
-		list_for_each_entry(codec, &codec_list, list) {
-			if (codec->dev == dev) {
-				dev_dbg(dev, "ASoC: Mapped DAI %s to CODEC %s\n",
-					dai->name, codec->name);
-				dai->codec = codec;
-				break;
-			}
-		}
 
 		if (!dai->codec)
 			dai->dapm.idle_bias_off = 1;
 
+		mutex_lock(&client_mutex);
 		list_add(&dai->list, &dai_list);
-
 		mutex_unlock(&client_mutex);
 
 		dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
@@ -4015,6 +4007,7 @@ static int
 __snd_soc_register_component(struct device *dev,
 			     struct snd_soc_component *cmpnt,
 			     const struct snd_soc_component_driver *cmpnt_drv,
+			     struct snd_soc_codec *codec,
 			     struct snd_soc_dai_driver *dai_drv,
 			     int num_dai, bool allow_single_dai)
 {
@@ -4038,7 +4031,8 @@ __snd_soc_register_component(struct device *dev,
 	cmpnt->dai_drv	= dai_drv;
 	cmpnt->num_dai	= num_dai;
 
-	ret = snd_soc_register_dais(cmpnt, dai_drv, num_dai, allow_single_dai);
+	ret = snd_soc_register_dais(cmpnt, codec, dai_drv, num_dai,
+		allow_single_dai);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to regster DAIs: %d\n", ret);
 		goto error_component_name;
@@ -4073,7 +4067,7 @@ int snd_soc_register_component(struct device *dev,
 
 	cmpnt->ignore_pmdown_time = true;
 
-	return __snd_soc_register_component(dev, cmpnt, cmpnt_drv,
+	return __snd_soc_register_component(dev, cmpnt, cmpnt_drv, NULL,
 					    dai_drv, num_dai, true);
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_component);
@@ -4294,7 +4288,7 @@ int snd_soc_register_codec(struct device *dev,
 	/* register component */
 	ret = __snd_soc_register_component(dev, &codec->component,
 					   &codec_drv->component_driver,
-					   dai_drv, num_dai, false);
+					   codec, dai_drv, num_dai, false);
 	if (ret < 0) {
 		dev_err(codec->dev, "ASoC: Failed to regster component: %d\n", ret);
 		goto fail_codec_name;
-- 
1.8.0
