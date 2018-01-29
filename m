From: Shreyas NC <shreyas.nc@intel.com>
Subject: [RFC 1/3] ASoC: Add initial support for multiple CPU
	DAIs
Date: Mon, 29 Jan 2018 15:01:34 +0530
Message-ID: <1517218296-19793-2-git-send-email-shreyas.nc@intel.com>
References: <1517218296-19793-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D13D92676EB
 for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2018 10:34:03 +0100 (CET)
In-Reply-To: <1517218296-19793-1-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, kuninori.morimoto.gx@renesas.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

For usecases where a stream consists of multiple BE CPU DAIs, DAI Link
should support the same.

This patch adds initial support for multiple CPU DAIs in ASoC for card
instantiation, suspend and resume functions.

This support is added only for BE DAI Links. Support for FE and
Codec-Codec Links is not added.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 include/sound/soc.h  |   5 ++
 sound/soc/soc-core.c | 195 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 146 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 747fd58..06cb2ab 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1052,6 +1052,8 @@ struct snd_soc_dai_link {
 
 	struct snd_soc_dai_link_component *codecs;
 	unsigned int num_codecs;
+	struct snd_soc_dai_link_component *cpu_dai;
+	unsigned int num_cpu_dai;
 
 	/*
 	 * You MAY specify the link's platform/PCM/DMA driver, either by
@@ -1277,6 +1279,9 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai **codec_dais;
 	unsigned int num_codecs;
 
+	struct snd_soc_dai **cpu_dais;
+	unsigned int num_cpu_dai;
+
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9c7b785..bee13c0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -611,6 +611,14 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 		return NULL;
 	}
 
+	rtd->cpu_dais = kzalloc(sizeof(struct snd_soc_dai *) *
+				dai_link->num_cpu_dai, GFP_KERNEL);
+	if (!rtd->cpu_dais) {
+		kfree(rtd->codec_dais);
+		kfree(rtd);
+		return NULL;
+	}
+
 	return rtd;
 }
 
@@ -712,13 +720,17 @@ int snd_soc_suspend(struct device *dev)
 		card->suspend_pre(card);
 
 	list_for_each_entry(rtd, &card->rtd_list, list) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai *cpu_dai;
 
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->suspend && !cpu_dai->driver->bus_control)
-			cpu_dai->driver->suspend(cpu_dai);
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+			if (cpu_dai->driver->suspend &&
+					!cpu_dai->driver->bus_control)
+				cpu_dai->driver->suspend(cpu_dai);
+		}
 	}
 
 	/* close any waiting streams */
@@ -826,13 +838,18 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	/* resume control bus DAIs */
 	list_for_each_entry(rtd, &card->rtd_list, list) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai *cpu_dai;
 
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->resume && cpu_dai->driver->bus_control)
-			cpu_dai->driver->resume(cpu_dai);
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+
+			if (cpu_dai->driver->resume &&
+					cpu_dai->driver->bus_control)
+				cpu_dai->driver->resume(cpu_dai);
+		}
 	}
 
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
@@ -878,8 +895,13 @@ static void soc_resume_deferred(struct work_struct *work)
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->resume && !cpu_dai->driver->bus_control)
-			cpu_dai->driver->resume(cpu_dai);
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+
+			if (cpu_dai->driver->resume &&
+					!cpu_dai->driver->bus_control)
+				cpu_dai->driver->resume(cpu_dai);
+		}
 	}
 
 	if (card->resume_post)
@@ -901,6 +923,7 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	bool bus_control = false;
 	struct snd_soc_pcm_runtime *rtd;
+	int i;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
@@ -909,11 +932,16 @@ int snd_soc_resume(struct device *dev)
 	/* activate pins from sleep state */
 	list_for_each_entry(rtd, &card->rtd_list, list) {
 		struct snd_soc_dai **codec_dais = rtd->codec_dais;
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai **cpu_dais = rtd->cpu_dais;
+		struct snd_soc_dai *cpu_dai;
 		int j;
 
-		if (cpu_dai->active)
-			pinctrl_pm_select_default_state(cpu_dai->dev);
+		for (j = 0; j < rtd->num_cpu_dai; j++) {
+			cpu_dai = cpu_dais[j];
+
+			if (cpu_dai->active)
+				pinctrl_pm_select_default_state(cpu_dai->dev);
+		}
 
 		for (j = 0; j < rtd->num_codecs; j++) {
 			struct snd_soc_dai *codec_dai = codec_dais[j];
@@ -929,8 +957,11 @@ int snd_soc_resume(struct device *dev)
 	 * due to I/O costs and anti-pop so handle them out of line.
 	 */
 	list_for_each_entry(rtd, &card->rtd_list, list) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-		bus_control |= cpu_dai->driver->bus_control;
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			struct snd_soc_dai *cpu_dai = rtd->cpu_dais[i];
+
+			bus_control |= cpu_dai->driver->bus_control;
+		}
 	}
 	if (bus_control) {
 		dev_dbg(dev, "ASoC: Resuming control bus master immediately\n");
@@ -1075,9 +1106,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
-	struct snd_soc_dai_link_component cpu_dai_component;
+	struct snd_soc_dai_link_component *cpu_dai_component;
 	struct snd_soc_component *component;
-	struct snd_soc_dai **codec_dais;
+	struct snd_soc_dai **codec_dais, **cpu_dais;
 	struct snd_soc_platform *platform;
 	struct device_node *platform_of_node;
 	const char *platform_name;
@@ -1085,26 +1116,38 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
+	cpu_dai_component = dai_link->cpu_dai;
+
 	if (soc_is_dai_link_bound(card, dai_link)) {
 		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
 			dai_link->name);
 		return 0;
 	}
 
+	if (dai_link->dynamic && dai_link->num_cpu_dai > 1) {
+		dev_err(card->dev, "ASoC: Multi CPU DAI not supported for FE");
+		return -EINVAL;
+	}
+
 	rtd = soc_new_pcm_runtime(card, dai_link);
 	if (!rtd)
 		return -ENOMEM;
 
-	cpu_dai_component.name = dai_link->cpu_name;
-	cpu_dai_component.of_node = dai_link->cpu_of_node;
-	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
-	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
-	if (!rtd->cpu_dai) {
-		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
-			dai_link->cpu_dai_name);
-		goto _err_defer;
+	rtd->num_cpu_dai = dai_link->num_cpu_dai;
+
+	cpu_dais = rtd->cpu_dais;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dais[i] = snd_soc_find_dai(&cpu_dai_component[i]);
+		if (!cpu_dais[i]) {
+			dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
+				cpu_dai_component[i].dai_name);
+			goto _err_defer;
+		}
+		snd_soc_rtdcom_add(rtd, cpu_dais[i]->component);
 	}
-	snd_soc_rtdcom_add(rtd, rtd->cpu_dai->component);
+
+	/* Fill cpu_dai in the runtime data */
+	rtd->cpu_dai = cpu_dais[0];
 
 	rtd->num_codecs = dai_link->num_codecs;
 
@@ -1225,7 +1268,8 @@ static void soc_remove_link_dais(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++)
 		soc_remove_dai(rtd->codec_dais[i], order);
 
-	soc_remove_dai(rtd->cpu_dai, order);
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		soc_remove_dai(rtd->cpu_dais[i], order);
 }
 
 static void soc_remove_link_components(struct snd_soc_card *card,
@@ -1297,6 +1341,30 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
 	return 0;
 }
 
+static int snd_soc_init_single_cpu_dai(struct snd_soc_card *card,
+				   struct snd_soc_dai_link *dai_link)
+{
+	if (dai_link->cpu_name || dai_link->cpu_of_node ||
+					dai_link->cpu_dai_name) {
+		dai_link->num_cpu_dai = 1;
+		dai_link->cpu_dai = devm_kzalloc(card->dev,
+				sizeof(struct snd_soc_dai_link_component),
+				GFP_KERNEL);
+
+		if (!dai_link->cpu_dai)
+			return -ENOMEM;
+
+		dai_link->cpu_dai[0].name = dai_link->cpu_name;
+		dai_link->cpu_dai[0].of_node = dai_link->cpu_of_node;
+		dai_link->cpu_dai[0].dai_name = dai_link->cpu_dai_name;
+	} else if (!dai_link->cpu_dai) {
+		dev_err(card->dev, "ASoC: DAI link has no DAIs\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int soc_init_dai_link(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *link)
 {
@@ -1308,6 +1376,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 		return ret;
 	}
 
+	ret = snd_soc_init_single_cpu_dai(card, link);
+	if (ret) {
+		dev_err(card->dev, "ASoC: failed to init cpu\n");
+		return ret;
+	}
+
 	for (i = 0; i < link->num_codecs; i++) {
 		/*
 		 * Codec must be specified by 1 of name or OF node,
@@ -1343,24 +1417,28 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * can be left unspecified, and will be matched based on DAI
 	 * name alone..
 	 */
-	if (link->cpu_name && link->cpu_of_node) {
-		dev_err(card->dev,
-			"ASoC: Neither/both cpu name/of_node are set for %s\n",
-			link->name);
-		return -EINVAL;
-	}
-	/*
-	 * At least one of CPU DAI name or CPU device name/node must be
-	 * specified
-	 */
-	if (!link->cpu_dai_name &&
-	    !(link->cpu_name || link->cpu_of_node)) {
-		dev_err(card->dev,
-			"ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
-			link->name);
-		return -EINVAL;
-	}
 
+	for (i = 0; i < link->num_cpu_dai; i++) {
+		if (link->cpu_dai[i].name &&
+			link->cpu_dai[i].of_node) {
+			dev_err(card->dev,
+			    "ASoC: Neither/both cpu name/of_node are set for %s\n",
+					link->cpu_dai[i].name);
+			return -EINVAL;
+		}
+
+		/*
+		 * At least one of CPU DAI name or CPU device name/node must be
+		 * specified
+		 */
+		if (!link->cpu_dai[i].dai_name &&
+			!(link->cpu_dai[i].name || link->cpu_dai[i].of_node)) {
+			dev_err(card->dev,
+			    "ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
+				link->name);
+			return -EINVAL;
+		}
+	}
 	return 0;
 }
 
@@ -1676,6 +1754,9 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	if (rtd->num_codecs > 1)
 		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
 
+	if (rtd->num_cpu_dai > 1)
+		dev_warn(card->dev, "ASoC: Multiple CPU DAIs not supported yet\n");
+
 	/* link the DAI widgets */
 	sink = codec_dai->playback_widget;
 	source = cpu_dai->capture_widget;
@@ -1710,7 +1791,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		struct snd_soc_pcm_runtime *rtd, int order)
 {
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i, ret;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
@@ -1719,9 +1799,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
 
-	ret = soc_probe_dai(cpu_dai, order);
-	if (ret)
-		return ret;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		ret = soc_probe_dai(rtd->cpu_dais[i], order);
+		if (ret)
+			return ret;
+	}
 
 	/* probe the CODEC DAI */
 	for (i = 0; i < rtd->num_codecs; i++) {
@@ -1757,9 +1839,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		soc_dpcm_debugfs_add(rtd);
 #endif
 
-	if (cpu_dai->driver->compress_new) {
+	if (rtd->cpu_dais[0]->driver->compress_new) {
 		/*create compress_device"*/
-		ret = cpu_dai->driver->compress_new(rtd, rtd->num);
+		ret = rtd->cpu_dais[0]->driver->compress_new(rtd, rtd->num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
@@ -1775,7 +1857,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 				       dai_link->stream_name, ret);
 				return ret;
 			}
-			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+			ret = soc_link_dai_pcm_new(rtd->cpu_dais,
+					rtd->num_cpu_dai, rtd);
 			if (ret < 0)
 				return ret;
 			ret = soc_link_dai_pcm_new(rtd->codec_dais,
@@ -2400,10 +2483,11 @@ int snd_soc_poweroff(struct device *dev)
 
 	/* deactivate pins to sleep state */
 	list_for_each_entry(rtd, &card->rtd_list, list) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		int i;
 
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+		for (i = 0; i < rtd->num_cpu_dai; i++)
+			pinctrl_pm_select_sleep_state(rtd->cpu_dais[i]->dev);
+
 		for (i = 0; i < rtd->num_codecs; i++) {
 			struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 			pinctrl_pm_select_sleep_state(codec_dai->dev);
@@ -2977,7 +3061,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	/* deactivate pins to sleep state */
 	list_for_each_entry(rtd, &card->rtd_list, list)  {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai *cpu_dai;
 		int j;
 
 		for (j = 0; j < rtd->num_codecs; j++) {
@@ -2986,8 +3070,11 @@ int snd_soc_register_card(struct snd_soc_card *card)
 				pinctrl_pm_select_sleep_state(codec_dai->dev);
 		}
 
-		if (!cpu_dai->active)
-			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+		for (j = 0; j < rtd->num_cpu_dai; j++) {
+			cpu_dai = rtd->cpu_dais[j];
+			if (!cpu_dai->active)
+				pinctrl_pm_select_sleep_state(cpu_dai->dev);
+		}
 	}
 
 	return ret;
-- 
2.7.4
