From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/13] ASoC: Move AUX dev support to the
	component level
Date: Tue, 19 Aug 2014 15:51:22 +0200
Message-ID: <1408456290-13945-6-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B37265683
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:44 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
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

This patch makes it possible to register arbitrary components as a AUX dev
for a card. This was previously only possible for CODEC components. With
componentization having made it possible for components to have DAPM contexts
and controls there is no reason why AUX devs should be artificially limited to
snd_soc_codec devices.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 48 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cb5c9ca..ec35ca3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1140,6 +1140,7 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_platform *platform;
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
+	struct snd_soc_component *component; /* Only valid for AUX dev rtds */
 
 	struct snd_soc_dai **codec_dais;
 	unsigned int num_codecs;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 76598cc..1d4776e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -860,6 +860,23 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
+static struct snd_soc_component *soc_find_component(
+	const struct device_node *of_node, const char *name)
+{
+	struct snd_soc_component *component;
+
+	list_for_each_entry(component, &component_list, list) {
+		if (of_node) {
+			if (component->dev->of_node == of_node)
+				return component;
+		} else if (strcmp(component->name, name) == 0) {
+			return component;
+		}
+	}
+
+	return NULL;
+}
+
 static struct snd_soc_codec *soc_find_codec(
 					const struct device_node *codec_of_node,
 					const char *codec_name)
@@ -1577,17 +1594,24 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	const char *codecname = aux_dev->codec_name;
+	const char *name = aux_dev->codec_name;
 
-	rtd->codec = soc_find_codec(aux_dev->codec_of_node, codecname);
-	if (!rtd->codec) {
+	rtd->component = soc_find_component(aux_dev->codec_of_node, name);
+	if (!rtd->component) {
 		if (aux_dev->codec_of_node)
-			codecname = of_node_full_name(aux_dev->codec_of_node);
+			name = of_node_full_name(aux_dev->codec_of_node);
 
-		dev_err(card->dev, "ASoC: %s not registered\n", codecname);
+		dev_err(card->dev, "ASoC: %s not registered\n", name);
 		return -EPROBE_DEFER;
 	}
 
+	/*
+	 * Some places still reference rtd->codec, so we have to keep that
+	 * initialized if the component is a CODEC. Once all those references
+	 * have been removed, this code can be removed as well.
+	 */
+	 rtd->codec = rtd->component->codec;
+
 	return 0;
 }
 
@@ -1597,18 +1621,18 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	int ret;
 
-	if (rtd->codec->component.probed) {
-		dev_err(rtd->codec->dev, "ASoC: codec already probed\n");
+	if (rtd->component->probed) {
+		dev_err(rtd->dev, "ASoC: codec already probed\n");
 		return -EBUSY;
 	}
 
-	ret = soc_probe_component(card, &rtd->codec->component);
+	ret = soc_probe_component(card, rtd->component);
 	if (ret < 0)
 		return ret;
 
 	/* do machine specific initialization */
 	if (aux_dev->init) {
-		ret = aux_dev->init(&rtd->codec->dapm);
+		ret = aux_dev->init(snd_soc_component_get_dapm(rtd->component));
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: failed to init %s: %d\n",
 				aux_dev->name, ret);
@@ -1622,7 +1646,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_component *component = rtd->component;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
@@ -1631,8 +1655,8 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 		rtd->dev_registered = 0;
 	}
 
-	if (codec && codec->component.probed)
-		soc_remove_component(&codec->component);
+	if (component && component->probed)
+		soc_remove_component(component);
 }
 
 static int snd_soc_init_codec_cache(struct snd_soc_codec *codec)
-- 
1.8.0
