From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: Bind aux devs early
Date: Tue,  1 Jul 2014 22:13:47 +0200
Message-ID: <1404245628-30877-4-git-send-email-lars@metafoo.de>
References: <1404245628-30877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF262650D1
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 22:13:59 +0200 (CEST)
In-Reply-To: <1404245628-30877-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Currently in snd_soc_instantiate_card() we only check if the aux dev exists, but
do not yet assign it to its rtd. This means that we need to lookup the aux dev
again in soc_probe_aux_dev(). This patch changes the behavior to assign the aux
dev to the rtd in soc_check_aux_dev() (and renames it to soc_bind_aux_dev()).
This simplifies the implementation a bit and also removes the need for
soc_post_component_init() to know about the specific CODEC that was assigned to
the rtd. The later is necessary for componentization as the code should work for
all types of components not just CODECs. This new behavior is also more in sync
with how soc_bind_dai_link()/soc_probe_link_dais() works.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 67 ++++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c8bdac2..0b870bb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1286,9 +1286,7 @@ static void rtd_release(struct device *dev)
 	kfree(dev);
 }
 
-static int soc_aux_dev_init(struct snd_soc_card *card,
-			    struct snd_soc_codec *codec,
-			    int num)
+static int soc_aux_dev_init(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
@@ -1298,13 +1296,11 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
 
 	/* do machine specific initialization */
 	if (aux_dev->init) {
-		ret = aux_dev->init(&codec->dapm);
+		ret = aux_dev->init(&rtd->codec->dapm);
 		if (ret < 0)
 			return ret;
 	}
 
-	rtd->codec = codec;
-
 	return 0;
 }
 
@@ -1327,7 +1323,6 @@ static int soc_dai_link_init(struct snd_soc_card *card, int num)
 }
 
 static int soc_post_component_init(struct snd_soc_card *card,
-				   struct snd_soc_codec *codec,
 				   int num, int dailess)
 {
 	struct snd_soc_dai_link *dai_link = NULL;
@@ -1345,7 +1340,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 		aux_dev = &card->aux_dev[num];
 		rtd = &card->rtd_aux[num];
 		name = aux_dev->name;
-		ret = soc_aux_dev_init(card, codec, num);
+		ret = soc_aux_dev_init(card, num);
 	}
 
 	if (ret < 0) {
@@ -1380,13 +1375,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	/* add DAPM sysfs entries for this codec */
 	ret = snd_soc_dapm_sys_add(rtd->dev);
 	if (ret < 0)
-		dev_err(codec->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to add codec dapm sysfs entries: %d\n", ret);
 
 	/* add codec sysfs entries */
 	ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
 	if (ret < 0)
-		dev_err(codec->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to add codec sysfs files: %d\n", ret);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1551,7 +1546,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	if (order != SND_SOC_COMP_ORDER_LAST)
 		return 0;
 
-	ret = soc_post_component_init(card, codec, num, 0);
+	ret = soc_post_component_init(card, num, 0);
 	if (ret)
 		return ret;
 
@@ -1649,51 +1644,39 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
-static int soc_check_aux_dev(struct snd_soc_card *card, int num)
-{
-	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	const char *codecname = aux_dev->codec_name;
-	struct snd_soc_codec *codec;
-
-	codec = soc_find_codec(aux_dev->codec_of_node, aux_dev->codec_name);
-	if (codec)
-		return 0;
-	if (aux_dev->codec_of_node)
-		codecname = of_node_full_name(aux_dev->codec_of_node);
-
-	dev_err(card->dev, "ASoC: %s not registered\n", codecname);
-	return -EPROBE_DEFER;
-}
-
-static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
+static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 {
+	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	const char *codecname = aux_dev->codec_name;
-	int ret = -ENODEV;
-	struct snd_soc_codec *codec;
 
-	codec = soc_find_codec(aux_dev->codec_of_node, aux_dev->codec_name);
-	if (!codec) {
+	rtd->codec = soc_find_codec(aux_dev->codec_of_node, codecname);
+	if (!rtd->codec) {
 		if (aux_dev->codec_of_node)
 			codecname = of_node_full_name(aux_dev->codec_of_node);
 
-		/* codec not found */
-		dev_err(card->dev, "ASoC: codec %s not found", codecname);
+		dev_err(card->dev, "ASoC: %s not registered\n", codecname);
 		return -EPROBE_DEFER;
 	}
 
-	if (codec->probed) {
-		dev_err(codec->dev, "ASoC: codec already probed");
+	return 0;
+}
+
+static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	int ret;
+
+	if (rtd->codec->probed) {
+		dev_err(rtd->codec->dev, "ASoC: codec already probed\n");
 		return -EBUSY;
 	}
 
-	ret = soc_probe_codec(card, codec);
+	ret = soc_probe_codec(card, rtd->codec);
 	if (ret < 0)
 		return ret;
 
-	ret = soc_post_component_init(card, codec, num, 1);
-
-	return ret;
+	return soc_post_component_init(card, num, 1);
 }
 
 static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
@@ -1745,9 +1728,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto base_error;
 	}
 
-	/* check aux_devs too */
+	/* bind aux_devs too */
 	for (i = 0; i < card->num_aux_devs; i++) {
-		ret = soc_check_aux_dev(card, i);
+		ret = soc_bind_aux_dev(card, i);
 		if (ret != 0)
 			goto base_error;
 	}
-- 
1.8.0
