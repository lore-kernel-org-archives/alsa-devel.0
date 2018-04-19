From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 1/3] ASoC: Add initial support for multiple
	CPU DAIs
Date: Thu, 19 Apr 2018 15:19:17 +0530
Message-ID: <1524131359-24387-2-git-send-email-vinod.koul@intel.com>
References: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E359E2673E1
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 11:44:52 +0200 (CEST)
In-Reply-To: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

For usecases where a stream consists of multiple BE CPU DAIs,
DAI Link should support the same.

This patch adds initial support for multiple CPU DAIs in ASoC for
card instantiation, suspend and resume functions.

This support is added only for BE DAI Links. Support for FE and
Codec-Codec Links is not added.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h  |   6 ++
 sound/soc/soc-core.c | 283 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 201 insertions(+), 88 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3676d0a8f532..080b3be875ac 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1068,6 +1068,9 @@ struct snd_soc_dai_link {
 	struct snd_soc_dai_link_component *codecs;
 	unsigned int num_codecs;
 
+	struct snd_soc_dai_link_component *cpu_dai;
+	unsigned int num_cpu_dai;
+
 	/*
 	 * You MAY specify the link's platform/PCM/DMA driver, either by
 	 * device name, or by DT/OF node, but not both. Some forms of link
@@ -1296,6 +1299,9 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai **codec_dais;
 	unsigned int num_codecs;
 
+	struct snd_soc_dai **cpu_dais;
+	unsigned int num_cpu_dai;
+
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aa1c33b3cce0..93eee7f5ab54 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -578,12 +578,21 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
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
 
 static void soc_free_pcm_runtime(struct snd_soc_pcm_runtime *rtd)
 {
 	kfree(rtd->codec_dais);
+	kfree(rtd->cpu_dais);
 	snd_soc_rtdcom_del_all(rtd);
 	kfree(rtd);
 }
@@ -679,13 +688,17 @@ int snd_soc_suspend(struct device *dev)
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
@@ -749,16 +762,21 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	list_for_each_entry(rtd, &card->rtd_list, list) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai *cpu_dai;
 
-		if (rtd->dai_link->ignore_suspend)
-			continue;
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+
+			if (rtd->dai_link->ignore_suspend)
+				continue;
 
-		if (cpu_dai->driver->suspend && cpu_dai->driver->bus_control)
-			cpu_dai->driver->suspend(cpu_dai);
+			if (cpu_dai->driver->suspend &&
+					cpu_dai->driver->bus_control)
+				cpu_dai->driver->suspend(cpu_dai);
 
-		/* deactivate pins to sleep state */
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+			/* deactivate pins to sleep state */
+			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+		}
 	}
 
 	if (card->suspend_post)
@@ -793,13 +811,18 @@ static void soc_resume_deferred(struct work_struct *work)
 
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
@@ -845,8 +868,13 @@ static void soc_resume_deferred(struct work_struct *work)
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
@@ -868,6 +896,7 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	bool bus_control = false;
 	struct snd_soc_pcm_runtime *rtd;
+	int i;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
@@ -876,11 +905,16 @@ int snd_soc_resume(struct device *dev)
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
@@ -896,8 +930,11 @@ int snd_soc_resume(struct device *dev)
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
@@ -1042,9 +1079,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
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
@@ -1055,26 +1092,38 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
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
-		dev_info(card->dev, "ASoC: CPU DAI %s not registered\n",
-			 dai_link->cpu_dai_name);
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
 
@@ -1190,7 +1239,8 @@ static void soc_remove_link_dais(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++)
 		soc_remove_dai(rtd->codec_dais[i], order);
 
-	soc_remove_dai(rtd->cpu_dai, order);
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		soc_remove_dai(rtd->cpu_dais[i], order);
 }
 
 static void soc_remove_link_components(struct snd_soc_card *card,
@@ -1262,6 +1312,30 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
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
@@ -1273,6 +1347,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
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
@@ -1308,24 +1388,28 @@ static int soc_init_dai_link(struct snd_soc_card *card,
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
 
@@ -1640,6 +1724,9 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	if (rtd->num_codecs > 1)
 		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
 
+	if (rtd->num_cpu_dai > 1)
+		dev_warn(card->dev, "ASoC: Multiple CPU DAIs not supported yet\n");
+
 	/* link the DAI widgets */
 	sink = codec_dai->playback_widget;
 	source = cpu_dai->capture_widget;
@@ -1674,7 +1761,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		struct snd_soc_pcm_runtime *rtd, int order)
 {
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i, ret, num;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
@@ -1683,9 +1769,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
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
@@ -1735,9 +1823,13 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		num = rtd->num;
 	}
 
-	if (cpu_dai->driver->compress_new) {
+	if (rtd->cpu_dais[0]->driver->compress_new) {
+		if (rtd->num_cpu_dai > 1)
+			dev_warn(card->dev,
+				"ASoC: multi-cpu compress dais not supported");
+
 		/*create compress_device"*/
-		ret = cpu_dai->driver->compress_new(rtd, num);
+		ret = rtd->cpu_dais[0]->driver->compress_new(rtd, rtd->num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
@@ -1753,7 +1845,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 				       dai_link->stream_name, ret);
 				return ret;
 			}
-			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+			ret = soc_link_dai_pcm_new(rtd->cpu_dais,
+					rtd->num_cpu_dai, rtd);
 			if (ret < 0)
 				return ret;
 			ret = soc_link_dai_pcm_new(rtd->codec_dais,
@@ -1890,7 +1983,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int dai_fmt)
 {
 	struct snd_soc_dai **codec_dais = rtd->codec_dais;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai **cpu_dais = rtd->cpu_dais;
 	unsigned int i;
 	int ret;
 
@@ -1907,34 +2000,44 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 
 	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
 	/* the component which has non_legacy_dai_naming is Codec */
-	if (cpu_dai->codec ||
-	    cpu_dai->component->driver->non_legacy_dai_naming) {
-		unsigned int inv_dai_fmt;
-
-		inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
-		switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBM_CFM:
-			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
-			break;
-		case SND_SOC_DAIFMT_CBM_CFS:
-			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFM:
-			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFS:
-			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
-			break;
-		}
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		struct snd_soc_dai *cpu_dai = cpu_dais[i];
+		unsigned int inv_dai_fmt, temp_dai_fmt;
 
-		dai_fmt = inv_dai_fmt;
-	}
+		temp_dai_fmt = dai_fmt;
+		if (cpu_dai->codec ||
+			cpu_dai->component->driver->non_legacy_dai_naming) {
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
-	if (ret != 0 && ret != -ENOTSUPP) {
-		dev_warn(cpu_dai->dev,
-			 "ASoC: Failed to set DAI format: %d\n", ret);
-		return ret;
+			inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
+
+			switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+			case SND_SOC_DAIFMT_CBM_CFM:
+				inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+				break;
+
+			case SND_SOC_DAIFMT_CBM_CFS:
+				inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+				break;
+
+			case SND_SOC_DAIFMT_CBS_CFM:
+				inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
+				break;
+
+			case SND_SOC_DAIFMT_CBS_CFS:
+				inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+				break;
+
+			}
+
+			temp_dai_fmt = inv_dai_fmt;
+		}
+
+		ret = snd_soc_dai_set_fmt(cpu_dai, temp_dai_fmt);
+		if (ret != 0 && ret != -ENOTSUPP) {
+			dev_warn(cpu_dai->dev,
+				"ASoC: Failed to set DAI format: %d\n", ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -2442,10 +2545,11 @@ int snd_soc_poweroff(struct device *dev)
 
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
@@ -3019,7 +3123,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	/* deactivate pins to sleep state */
 	list_for_each_entry(rtd, &card->rtd_list, list)  {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai *cpu_dai;
 		int j;
 
 		for (j = 0; j < rtd->num_codecs; j++) {
@@ -3028,8 +3132,11 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
