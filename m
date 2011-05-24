From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Allow some components to
	probe/remove later or earlier.
Date: Tue, 24 May 2011 17:39:52 +0100
Message-ID: <1306255192-4592-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 93C801039BB
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 18:39:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Some ASoC components depend on other ASoC components to provide clocks and
power resources in order to probe().

Provide a method to allow some components to be probed() later and be also
removed() earlier.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dai.h |    4 +++
 include/sound/soc.h     |    8 +++++++
 sound/soc/soc-core.c    |   49 ++++++++++++++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1bafe95..ada1f24 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -209,6 +209,10 @@ struct snd_soc_dai_driver {
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
 	unsigned int symmetric_rates:1;
+
+	/* probe ordering - for components with runtime dependencies */
+	bool late_probe;
+	bool early_remove;
 };
 
 /*
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f1de3e0..a2139d4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -613,6 +613,10 @@ struct snd_soc_codec_driver {
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
+
+	/* probe ordering - for components with runtime dependencies */
+	bool late_probe;
+	bool early_remove;
 };
 
 /* SoC platform interface */
@@ -637,6 +641,10 @@ struct snd_soc_platform_driver {
 
 	/* platform stream ops */
 	struct snd_pcm_ops *ops;
+
+	/* probe ordering - for components with runtime dependencies */
+	bool late_probe;
+	bool early_remove;
 };
 
 struct snd_soc_platform {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f9667f6..321182e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1393,7 +1393,7 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 	module_put(codec->dev->driver->owner);
 }
 
-static void soc_remove_dai_link(struct snd_soc_card *card, int num)
+static void soc_remove_dai_link(struct snd_soc_card *card, int num, int early)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_codec *codec = rtd->codec;
@@ -1410,7 +1410,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the CODEC DAI */
-	if (codec_dai && codec_dai->probed) {
+	if (codec_dai && codec_dai->probed &&
+			codec_dai->driver->early_remove == early) {
 		if (codec_dai->driver->remove) {
 			err = codec_dai->driver->remove(codec_dai);
 			if (err < 0)
@@ -1421,7 +1422,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the platform */
-	if (platform && platform->probed) {
+	if (platform && platform->probed &&
+			platform->driver->early_remove == early) {
 		if (platform->driver->remove) {
 			err = platform->driver->remove(platform);
 			if (err < 0)
@@ -1433,11 +1435,13 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the CODEC */
-	if (codec && codec->probed)
+	if (codec && codec->probed &&
+			codec->driver->early_remove == early)
 		soc_remove_codec(codec);
 
 	/* remove the cpu_dai */
-	if (cpu_dai && cpu_dai->probed) {
+	if (cpu_dai && cpu_dai->probed &&
+			cpu_dai->driver->early_remove == early) {
 		if (cpu_dai->driver->remove) {
 			err = cpu_dai->driver->remove(cpu_dai);
 			if (err < 0)
@@ -1454,7 +1458,9 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	int i;
 
 	for (i = 0; i < card->num_rtd; i++)
-		soc_remove_dai_link(card, i);
+			soc_remove_dai_link(card, i, 1); /* early remove */
+	for (i = 0; i < card->num_rtd; i++)
+		soc_remove_dai_link(card, i, 0); /* late remove */
 
 	card->num_rtd = 0;
 }
@@ -1596,7 +1602,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	return 0;
 }
 
-static int soc_probe_dai_link(struct snd_soc_card *card, int num)
+static int soc_probe_dai_link(struct snd_soc_card *card, int num, int late)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
@@ -1605,7 +1611,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
+	dev_dbg(card->dev, "probe %s dai link %d late %d\n", card->name, num, late);
 
 	/* config components */
 	codec_dai->codec = codec;
@@ -1617,7 +1623,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	rtd->pmdown_time = pmdown_time;
 
 	/* probe the cpu_dai */
-	if (!cpu_dai->probed) {
+	if (!cpu_dai->probed &&
+			cpu_dai->driver->late_probe == late) {
 		if (!try_module_get(cpu_dai->dev->driver->owner))
 			return -ENODEV;
 
@@ -1636,14 +1643,16 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* probe the CODEC */
-	if (!codec->probed) {
+	if (!codec->probed &&
+			codec->driver->late_probe == late) {
 		ret = soc_probe_codec(card, codec);
 		if (ret < 0)
 			return ret;
 	}
 
 	/* probe the platform */
-	if (!platform->probed) {
+	if (!platform->probed &&
+			platform->driver->late_probe == late) {
 		if (!try_module_get(platform->dev->driver->owner))
 			return -ENODEV;
 
@@ -1662,7 +1671,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* probe the CODEC DAI */
-	if (!codec_dai->probed) {
+	if (!codec_dai->probed && codec_dai->driver->late_probe == late) {
 		if (codec_dai->driver->probe) {
 			ret = codec_dai->driver->probe(codec_dai);
 			if (ret < 0) {
@@ -1677,6 +1686,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 		list_add(&codec_dai->card_list, &card->dai_dev_list);
 	}
 
+	/* complete DAI probe during late probe */
+	if (!late)
+		return 0;
+
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
@@ -1895,8 +1908,18 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto card_probe_error;
 	}
 
+	/* early DAI link probe */
+	for (i = 0; i < card->num_links; i++) {
+		ret = soc_probe_dai_link(card, i, 0);
+		if (ret < 0) {
+			pr_err("asoc: failed to instantiate card %s: %d\n",
+			       card->name, ret);
+			goto probe_dai_err;
+		}
+	}
+	/* late DAI link probe */
 	for (i = 0; i < card->num_links; i++) {
-		ret = soc_probe_dai_link(card, i);
+		ret = soc_probe_dai_link(card, i, 1);
 		if (ret < 0) {
 			pr_err("asoc: failed to instantiate card %s: %d\n",
 			       card->name, ret);
-- 
1.7.4.1
