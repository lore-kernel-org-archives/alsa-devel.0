From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3.5 2/2] ASoC: core: Use driver core probe
	deferral
Date: Wed, 14 Mar 2012 21:20:44 +0000
Message-ID: <1331760044-16857-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1331760044-16857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71146103D57
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 22:20:49 +0100 (CET)
In-Reply-To: <1331760044-16857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Grant Likely <grant@secretlab.ca>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In version 3.4 the driver core acquired probe deferral which is a core way
of doing essentially the same thing as ASoC has been doing since forever
to make sure that all the devices needed to make up the card are present
without needing open coding in the subsystem.

Make basic use of this probe deferral mechanism for the cards, removing the
need to handle partially instantiated cards. We should be able to remove
even more code than this, though some of the checks we're currently doing
should stay since they're about things like suppressing unneeded DAPM runs
rather than deferring probes.

In order to avoid robustness issues with our teardown paths (which do need
quite a bit of TLC) add a check for aux_devs prior to attempting to set
things up, this means that we've got a reasonable idea that everything will
be there before we start. As with the removal of partial instantiation
support more work will be needed to make this work neatly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 -
 sound/soc/soc-core.c |  147 +++++++++++++++++++++-----------------------------
 2 files changed, 62 insertions(+), 86 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b8163dd..9e238fa 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -896,7 +896,6 @@ struct snd_soc_pcm_runtime {
 	enum snd_soc_pcm_subclass pcm_subclass;
 	struct snd_pcm_ops ops;
 
-	unsigned int complete:1;
 	unsigned int dev_registered:1;
 
 	long pmdown_time;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b0f8666..0548e5c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -54,7 +54,6 @@ EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
 #endif
 
 static DEFINE_MUTEX(client_mutex);
-static LIST_HEAD(card_list);
 static LIST_HEAD(dai_list);
 static LIST_HEAD(platform_list);
 static LIST_HEAD(codec_list);
@@ -785,15 +784,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_dai *codec_dai, *cpu_dai;
 	const char *platform_name;
 
-	if (rtd->complete)
-		return 1;
 	dev_dbg(card->dev, "binding %s at idx %d\n", dai_link->name, num);
 
-	/* do we already have the CPU DAI for this link ? */
-	if (rtd->cpu_dai) {
-		goto find_codec;
-	}
-	/* no, then find CPU DAI from registered DAIs*/
+	/* Find CPU DAI from registered DAIs*/
 	list_for_each_entry(cpu_dai, &dai_list, list) {
 		if (dai_link->cpu_dai_of_node) {
 			if (cpu_dai->dev->of_node != dai_link->cpu_dai_of_node)
@@ -804,18 +797,15 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		}
 
 		rtd->cpu_dai = cpu_dai;
-		goto find_codec;
 	}
-	dev_dbg(card->dev, "CPU DAI %s not registered\n",
-			dai_link->cpu_dai_name);
 
-find_codec:
-	/* do we already have the CODEC for this link ? */
-	if (rtd->codec) {
-		goto find_platform;
+	if (!rtd->cpu_dai) {
+		dev_dbg(card->dev, "CPU DAI %s not registered\n",
+			dai_link->cpu_dai_name);
+		return -EPROBE_DEFER;
 	}
 
-	/* no, then find CODEC from registered CODECs*/
+	/* Find CODEC from registered CODECs */
 	list_for_each_entry(codec, &codec_list, list) {
 		if (dai_link->codec_of_node) {
 			if (codec->dev->of_node != dai_link->codec_of_node)
@@ -837,28 +827,28 @@ find_codec:
 					dai_link->codec_dai_name)) {
 
 				rtd->codec_dai = codec_dai;
-				goto find_platform;
 			}
 		}
-		dev_dbg(card->dev, "CODEC DAI %s not registered\n",
-				dai_link->codec_dai_name);
 
-		goto find_platform;
+		if (!rtd->codec_dai) {
+			dev_dbg(card->dev, "CODEC DAI %s not registered\n",
+				dai_link->codec_dai_name);
+			return -EPROBE_DEFER;
+		}
 	}
-	dev_dbg(card->dev, "CODEC %s not registered\n",
-			dai_link->codec_name);
 
-find_platform:
-	/* do we need a platform? */
-	if (rtd->platform)
-		goto out;
+	if (!rtd->codec) {
+		dev_dbg(card->dev, "CODEC %s not registered\n",
+			dai_link->codec_name);
+		return -EPROBE_DEFER;
+	}
 
 	/* if there's no platform we match on the empty platform */
 	platform_name = dai_link->platform_name;
 	if (!platform_name && !dai_link->platform_of_node)
 		platform_name = "snd-soc-dummy";
 
-	/* no, then find one from the set of registered platforms */
+	/* find one from the set of registered platforms */
 	list_for_each_entry(platform, &platform_list, list) {
 		if (dai_link->platform_of_node) {
 			if (platform->dev->of_node !=
@@ -870,20 +860,16 @@ find_platform:
 		}
 
 		rtd->platform = platform;
-		goto out;
 	}
-
-	dev_dbg(card->dev, "platform %s not registered\n",
+	if (!rtd->platform) {
+		dev_dbg(card->dev, "platform %s not registered\n",
 			dai_link->platform_name);
-	return 0;
-
-out:
-	/* mark rtd as complete if we found all 4 of our client devices */
-	if (rtd->codec && rtd->codec_dai && rtd->platform && rtd->cpu_dai) {
-		rtd->complete = 1;
-		card->num_rtd++;
+		return -EPROBE_DEFER;
 	}
-	return 1;
+
+	card->num_rtd++;
+
+	return 0;
 }
 
 static void soc_remove_codec(struct snd_soc_codec *codec)
@@ -1346,6 +1332,20 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
 }
 #endif
 
+static int soc_check_aux_dev(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	struct snd_soc_codec *codec;
+
+	/* find CODEC from registered CODECs*/
+	list_for_each_entry(codec, &codec_list, list) {
+		if (!strcmp(codec->name, aux_dev->codec_name))
+			return 0;
+	}
+
+	return -EPROBE_DEFER;
+}
+
 static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
@@ -1366,7 +1366,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	}
 	/* codec not found */
 	dev_err(card->dev, "asoc: codec %s not found", aux_dev->codec_name);
-	goto out;
+	return -EPROBE_DEFER;
 
 found:
 	ret = soc_probe_codec(card, codec);
@@ -1416,7 +1416,7 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static void snd_soc_instantiate_card(struct snd_soc_card *card)
+static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_conf *codec_conf;
@@ -1426,19 +1426,18 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
-	if (card->instantiated) {
-		mutex_unlock(&card->mutex);
-		return;
-	}
-
 	/* bind DAIs */
-	for (i = 0; i < card->num_links; i++)
-		soc_bind_dai_link(card, i);
+	for (i = 0; i < card->num_links; i++) {
+		ret = soc_bind_dai_link(card, i);
+		if (ret != 0)
+			goto base_error;
+	}
 
-	/* bind completed ? */
-	if (card->num_rtd != card->num_links) {
-		mutex_unlock(&card->mutex);
-		return;
+	/* check aux_devs too */
+	for (i = 0; i < card->num_aux_devs; i++) {
+		ret = soc_check_aux_dev(card, i);
+		if (ret != 0)
+			goto base_error;
 	}
 
 	/* initialize the register cache for each available codec */
@@ -1458,10 +1457,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 			}
 		}
 		ret = snd_soc_init_codec_cache(codec, compress_type);
-		if (ret < 0) {
-			mutex_unlock(&card->mutex);
-			return;
-		}
+		if (ret < 0)
+			goto base_error;
 	}
 
 	/* card bind complete so register a sound card */
@@ -1470,8 +1467,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	if (ret < 0) {
 		pr_err("asoc: can't create sound card for card %s: %d\n",
 			card->name, ret);
-		mutex_unlock(&card->mutex);
-		return;
+		goto base_error;
 	}
 	card->snd_card->dev = card->dev;
 
@@ -1611,7 +1607,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
-	return;
+
+	return 0;
 
 probe_aux_dev_err:
 	for (i = 0; i < card->num_aux_devs; i++)
@@ -1626,18 +1623,10 @@ card_probe_error:
 
 	snd_card_free(card->snd_card);
 
+base_error:
 	mutex_unlock(&card->mutex);
-}
 
-/*
- * Attempt to initialise any uninitialised cards.  Must be called with
- * client_mutex.
- */
-static void snd_soc_instantiate_cards(void)
-{
-	struct snd_soc_card *card;
-	list_for_each_entry(card, &card_list, list)
-		snd_soc_instantiate_card(card);
+	return ret;
 }
 
 /* probes a new socdev */
@@ -3072,7 +3061,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i;
+	int i, ret;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -3136,14 +3125,11 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 
-	mutex_lock(&client_mutex);
-	list_add(&card->list, &card_list);
-	snd_soc_instantiate_cards();
-	mutex_unlock(&client_mutex);
+	ret = snd_soc_instantiate_card(card);
+	if (ret != 0)
+		soc_cleanup_card_debugfs(card);
 
-	dev_dbg(card->dev, "Registered card '%s'\n", card->name);
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
@@ -3157,9 +3143,6 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 {
 	if (card->instantiated)
 		soc_cleanup_card_resources(card);
-	mutex_lock(&client_mutex);
-	list_del(&card->list);
-	mutex_unlock(&client_mutex);
 	dev_dbg(card->dev, "Unregistered card '%s'\n", card->name);
 
 	return 0;
@@ -3256,7 +3239,6 @@ int snd_soc_register_dai(struct device *dev,
 
 	mutex_lock(&client_mutex);
 	list_add(&dai->list, &dai_list);
-	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Registered DAI '%s'\n", dai->name);
@@ -3338,9 +3320,6 @@ int snd_soc_register_dais(struct device *dev,
 		pr_debug("Registered DAI '%s'\n", dai->name);
 	}
 
-	mutex_lock(&client_mutex);
-	snd_soc_instantiate_cards();
-	mutex_unlock(&client_mutex);
 	return 0;
 
 err:
@@ -3398,7 +3377,6 @@ int snd_soc_register_platform(struct device *dev,
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
-	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Registered platform '%s'\n", platform->name);
@@ -3557,7 +3535,6 @@ int snd_soc_register_codec(struct device *dev,
 
 	mutex_lock(&client_mutex);
 	list_add(&codec->list, &codec_list);
-	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Registered codec '%s'\n", codec->name);
-- 
1.7.9.1
