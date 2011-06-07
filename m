From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Allow components to probe/remove
	in sequence.
Date: Tue, 7 Jun 2011 16:08:05 +0100
Message-ID: <1307459285-5040-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F25C244FB
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 17:08:22 +0200 (CEST)
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
power resources in order to probe() and vice versa for remove().

Allow components to be ordered so that components can be probed() and removed()
in sequences that conform to their dependencies.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dai.h |    4 +++
 include/sound/soc.h     |   18 ++++++++++++++
 sound/soc/soc-core.c    |   60 ++++++++++++++++++++++++++++++----------------
 3 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1bafe95..5ad5f3a 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -209,6 +209,10 @@ struct snd_soc_dai_driver {
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
 	unsigned int symmetric_rates:1;
+
+	/* probe ordering - for components with runtime dependencies */
+	int probe_order;
+	int remove_order;
 };
 
 /*
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f55efc1..baaba6a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -203,6 +203,16 @@
 	SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
 
 /*
+ * Component probe and remove ordering levels for components with runtime
+ * dependencies.
+ */
+#define SND_SOC_COMP_ORDER_FIRST		-2
+#define SND_SOC_COMP_ORDER_EARLY		-1
+#define SND_SOC_COMP_ORDER_NORMAL		0
+#define SND_SOC_COMP_ORDER_LATE		1
+#define SND_SOC_COMP_ORDER_LAST		2
+
+/*
  * Bias levels
  *
  * @ON:      Bias is fully on for audio playback and capture operations.
@@ -613,6 +623,10 @@ struct snd_soc_codec_driver {
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
+
+	/* probe ordering - for components with runtime dependencies */
+	int probe_order;
+	int remove_order;
 };
 
 /* SoC platform interface */
@@ -637,6 +651,10 @@ struct snd_soc_platform_driver {
 
 	/* platform stream ops */
 	struct snd_pcm_ops *ops;
+
+	/* probe ordering - for components with runtime dependencies */
+	int probe_order;
+	int remove_order;
 };
 
 struct snd_soc_platform {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c53f5d5..ae4c5e4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1394,7 +1394,7 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 	module_put(codec->dev->driver->owner);
 }
 
-static void soc_remove_dai_link(struct snd_soc_card *card, int num)
+static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_codec *codec = rtd->codec;
@@ -1411,7 +1411,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the CODEC DAI */
-	if (codec_dai && codec_dai->probed) {
+	if (codec_dai && codec_dai->probed &&
+			codec_dai->driver->remove_order == order) {
 		if (codec_dai->driver->remove) {
 			err = codec_dai->driver->remove(codec_dai);
 			if (err < 0)
@@ -1422,7 +1423,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the platform */
-	if (platform && platform->probed) {
+	if (platform && platform->probed &&
+			platform->driver->remove_order == order) {
 		if (platform->driver->remove) {
 			err = platform->driver->remove(platform);
 			if (err < 0)
@@ -1434,11 +1436,13 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the CODEC */
-	if (codec && codec->probed)
+	if (codec && codec->probed &&
+			codec->driver->remove_order == order)
 		soc_remove_codec(codec);
 
 	/* remove the cpu_dai */
-	if (cpu_dai && cpu_dai->probed) {
+	if (cpu_dai && cpu_dai->probed &&
+			cpu_dai->driver->remove_order == order) {
 		if (cpu_dai->driver->remove) {
 			err = cpu_dai->driver->remove(cpu_dai);
 			if (err < 0)
@@ -1452,11 +1456,13 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 
 static void soc_remove_dai_links(struct snd_soc_card *card)
 {
-	int i;
-
-	for (i = 0; i < card->num_rtd; i++)
-		soc_remove_dai_link(card, i);
+	int dai, order;
 
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++) {
+		for (dai = 0; dai < card->num_rtd; dai++)
+			soc_remove_dai_link(card, dai, order);
+	}
 	card->num_rtd = 0;
 }
 
@@ -1597,7 +1603,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	return 0;
 }
 
-static int soc_probe_dai_link(struct snd_soc_card *card, int num)
+static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
@@ -1606,7 +1612,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
+	dev_dbg(card->dev, "probe %s dai link %d late %d\n",
+			card->name, num, order);
 
 	/* config components */
 	codec_dai->codec = codec;
@@ -1618,7 +1625,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	rtd->pmdown_time = pmdown_time;
 
 	/* probe the cpu_dai */
-	if (!cpu_dai->probed) {
+	if (!cpu_dai->probed &&
+			cpu_dai->driver->probe_order == order) {
 		if (!try_module_get(cpu_dai->dev->driver->owner))
 			return -ENODEV;
 
@@ -1637,14 +1645,16 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* probe the CODEC */
-	if (!codec->probed) {
+	if (!codec->probed &&
+			codec->driver->probe_order == order) {
 		ret = soc_probe_codec(card, codec);
 		if (ret < 0)
 			return ret;
 	}
 
 	/* probe the platform */
-	if (!platform->probed) {
+	if (!platform->probed &&
+			platform->driver->probe_order == order) {
 		if (!try_module_get(platform->dev->driver->owner))
 			return -ENODEV;
 
@@ -1663,7 +1673,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* probe the CODEC DAI */
-	if (!codec_dai->probed) {
+	if (!codec_dai->probed && codec_dai->driver->probe_order == order) {
 		if (codec_dai->driver->probe) {
 			ret = codec_dai->driver->probe(codec_dai);
 			if (ret < 0) {
@@ -1678,6 +1688,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 		list_add(&codec_dai->card_list, &card->dai_dev_list);
 	}
 
+	/* complete DAI probe during last probe */
+	if (order != SND_SOC_COMP_ORDER_LAST)
+		return 0;
+
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
@@ -1818,7 +1832,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_conf *codec_conf;
 	enum snd_soc_compress_type compress_type;
-	int ret, i;
+	int ret, i, order;
 
 	mutex_lock(&card->mutex);
 
@@ -1896,12 +1910,16 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto card_probe_error;
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		ret = soc_probe_dai_link(card, i);
-		if (ret < 0) {
-			pr_err("asoc: failed to instantiate card %s: %d\n",
+	/* early DAI link probe */
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++) {
+		for (i = 0; i < card->num_links; i++) {
+			ret = soc_probe_dai_link(card, i, order);
+			if (ret < 0) {
+				pr_err("asoc: failed to instantiate card %s: %d\n",
 			       card->name, ret);
-			goto probe_dai_err;
+				goto probe_dai_err;
+			}
 		}
 	}
 
-- 
1.7.4.1
