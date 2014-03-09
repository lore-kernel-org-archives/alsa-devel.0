From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/3] ASoC: Add a per component dai list
Date: Sun,  9 Mar 2014 17:41:47 +0100
Message-ID: <1394383307-7224-3-git-send-email-lars@metafoo.de>
References: <1394383307-7224-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 19BCF2655BE
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 17:41:17 +0100 (CET)
In-Reply-To: <1394383307-7224-1-git-send-email-lars@metafoo.de>
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

Now that every DAI has a component we can track the DAIs on a per component
basis. This simplifies the DAI lookup when we are only interested in DAIs of a
specific component and also makes it possible to have multiple components with
the same parent device and also register DAIs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 76 +++++++++++++++++++++++-----------------------------
 2 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c0b6656..5725243 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -680,6 +680,8 @@ struct snd_soc_component {
 	int num_dai;
 
 	const struct snd_soc_component_driver *driver;
+
+	struct list_head dai_list;
 };
 
 /* SoC Audio Codec device */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a6c753a..f19e6bc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -56,7 +56,6 @@ EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
 #endif
 
 static DEFINE_MUTEX(client_mutex);
-static LIST_HEAD(dai_list);
 static LIST_HEAD(platform_list);
 static LIST_HEAD(codec_list);
 static LIST_HEAD(component_list);
@@ -370,18 +369,22 @@ static ssize_t dai_list_read_file(struct file *file, char __user *user_buf,
 {
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	ssize_t len, ret = 0;
+	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 
 	if (!buf)
 		return -ENOMEM;
 
-	list_for_each_entry(dai, &dai_list, list) {
-		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n", dai->name);
-		if (len >= 0)
-			ret += len;
-		if (ret > PAGE_SIZE) {
-			ret = PAGE_SIZE;
-			break;
+	list_for_each_entry(component, &component_list, list) {
+		list_for_each_entry(dai, &component->dai_list, list) {
+			len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
+				dai->name);
+			if (len >= 0)
+				ret += len;
+			if (ret > PAGE_SIZE) {
+				ret = PAGE_SIZE;
+				break;
+			}
 		}
 	}
 
@@ -855,6 +858,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_component *component;
 	struct snd_soc_codec *codec;
 	struct snd_soc_platform *platform;
 	struct snd_soc_dai *codec_dai, *cpu_dai;
@@ -863,18 +867,20 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
 	/* Find CPU DAI from registered DAIs*/
-	list_for_each_entry(cpu_dai, &dai_list, list) {
+	list_for_each_entry(component, &component_list, list) {
 		if (dai_link->cpu_of_node &&
-		    (cpu_dai->dev->of_node != dai_link->cpu_of_node))
+			component->dev->of_node != dai_link->cpu_of_node)
 			continue;
 		if (dai_link->cpu_name &&
-		    strcmp(dev_name(cpu_dai->dev), dai_link->cpu_name))
-			continue;
-		if (dai_link->cpu_dai_name &&
-		    strcmp(cpu_dai->name, dai_link->cpu_dai_name))
+			strcmp(dev_name(component->dev), dai_link->cpu_name))
 			continue;
+		list_for_each_entry(cpu_dai, &component->dai_list, list) {
+			if (dai_link->cpu_dai_name &&
+				strcmp(cpu_dai->name, dai_link->cpu_dai_name))
+				continue;
 
-		rtd->cpu_dai = cpu_dai;
+			rtd->cpu_dai = cpu_dai;
+		}
 	}
 
 	if (!rtd->cpu_dai) {
@@ -899,12 +905,10 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		 * CODEC found, so find CODEC DAI from registered DAIs from
 		 * this CODEC
 		 */
-		list_for_each_entry(codec_dai, &dai_list, list) {
-			if (codec->dev == codec_dai->dev &&
-				!strcmp(codec_dai->name,
-					dai_link->codec_dai_name)) {
-
+		list_for_each_entry(codec_dai, &codec->component.dai_list, list) {
+			if (!strcmp(codec_dai->name, dai_link->codec_dai_name)) {
 				rtd->codec_dai = codec_dai;
+				break;
 			}
 		}
 
@@ -1128,12 +1132,8 @@ static int soc_probe_codec(struct snd_soc_card *card,
 					  driver->num_dapm_widgets);
 
 	/* Create DAPM widgets for each DAI stream */
-	list_for_each_entry(dai, &dai_list, list) {
-		if (dai->dev != codec->dev)
-			continue;
-
+	list_for_each_entry(dai, &codec->component.dai_list, list)
 		snd_soc_dapm_new_dai_widgets(&codec->dapm, dai);
-	}
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
@@ -1180,6 +1180,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 {
 	int ret = 0;
 	const struct snd_soc_platform_driver *driver = platform->driver;
+	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 
 	platform->card = card;
@@ -1195,11 +1196,11 @@ static int soc_probe_platform(struct snd_soc_card *card,
 			driver->dapm_widgets, driver->num_dapm_widgets);
 
 	/* Create DAPM widgets for each DAI stream */
-	list_for_each_entry(dai, &dai_list, list) {
-		if (dai->dev != platform->dev)
+	list_for_each_entry(component, &component_list, list) {
+		if (component->dev != platform->dev)
 			continue;
-
-		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
+		list_for_each_entry(dai, &component->dai_list, list)
+			snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
 	}
 
 	platform->dapm.idle_bias_off = 1;
@@ -3903,21 +3904,14 @@ static inline char *fmt_multiple_name(struct device *dev,
  */
 static void snd_soc_unregister_dais(struct snd_soc_component *component)
 {
-	struct snd_soc_dai *dai, *_dai;
-
-	mutex_lock(&client_mutex);
-	list_for_each_entry_safe(dai, _dai, &dai_list, list) {
-		if (dai->dev != component->dev)
-			continue;
-
-		list_del(&dai->list);
+	struct snd_soc_dai *dai;
 
+	list_for_each_entry(dai, &component->dai_list, list) {
 		dev_dbg(component->dev, "ASoC: Unregistered DAI '%s'\n",
 			dai->name);
 		kfree(dai->name);
 		kfree(dai);
 	}
-	mutex_unlock(&client_mutex);
 }
 
 /**
@@ -3981,13 +3975,10 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 		if (!dai->driver->ops)
 			dai->driver->ops = &null_dai_ops;
 
-
 		if (!dai->codec)
 			dai->dapm.idle_bias_off = 1;
 
-		mutex_lock(&client_mutex);
-		list_add(&dai->list, &dai_list);
-		mutex_unlock(&client_mutex);
+		list_add(&dai->list, &component->dai_list);
 
 		dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
 	}
@@ -4031,6 +4022,7 @@ __snd_soc_register_component(struct device *dev,
 	cmpnt->driver	= cmpnt_drv;
 	cmpnt->dai_drv	= dai_drv;
 	cmpnt->num_dai	= num_dai;
+	INIT_LIST_HEAD(&cmpnt->dai_list);
 
 	ret = snd_soc_register_dais(cmpnt, codec, dai_drv, num_dai,
 		allow_single_dai);
-- 
1.8.0
