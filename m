From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/13] ASoC: Consolidate CPU and CODEC DAI
	lookup
Date: Tue, 19 Aug 2014 15:51:27 +0200
Message-ID: <1408456290-13945-11-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CD8C265661
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:50 +0200 (CEST)
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

The lookup of CPU and CODEC DAIs is fairly similar and can easily be
consolidated into a single helper function.

There are two main differences in the current implementation of the CPU and
CODEC DAI lookup:
 1) CPU DAIs can be looked up by the DAI name alone and do not necessarily
   require a component name/of_node.
 2) The CODEC DAI search only considers DAIs from CODEC components.

For 1) the new helper function will allow to lookup DAIs without providing a
component name or of_node, but since snd_soc_register_card() already rejects
CODEC DAI link components without neither a of_node or a name we'll never get
into the situation where we try to lookup a CODEC DAI without a name/of_node.
For 2) the new helper function just always considers all components.
Componentization is now at a point where it is possible to register a CODEC as a
snd_soc_component rather than a snd_soc_codec, by considering DAIs from all
components it is possible to use such a CODEC in a DAI link.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 72 ++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 53 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 04cc3d7..9d05a28 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -877,35 +877,23 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
-static struct snd_soc_codec *soc_find_codec(
-					const struct device_node *codec_of_node,
-					const char *codec_name)
+static struct snd_soc_dai *snd_soc_find_dai(
+	const struct snd_soc_dai_link_component *dlc)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
+	struct snd_soc_dai *dai;
 
-	list_for_each_entry(codec, &codec_list, list) {
-		if (codec_of_node) {
-			if (codec->dev->of_node != codec_of_node)
-				continue;
-		} else {
-			if (strcmp(codec->component.name, codec_name))
+	/* Find CPU DAI from registered DAIs*/
+	list_for_each_entry(component, &component_list, list) {
+		if (dlc->of_node && component->dev->of_node != dlc->of_node)
+			continue;
+		if (dlc->name && strcmp(dev_name(component->dev), dlc->name))
+			continue;
+		list_for_each_entry(dai, &component->dai_list, list) {
+			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name))
 				continue;
-		}
-
-		return codec;
-	}
-
-	return NULL;
-}
-
-static struct snd_soc_dai *soc_find_codec_dai(struct snd_soc_codec *codec,
-					      const char *codec_dai_name)
-{
-	struct snd_soc_dai *codec_dai;
 
-	list_for_each_entry(codec_dai, &codec->component.dai_list, list) {
-		if (!strcmp(codec_dai->name, codec_dai_name)) {
-			return codec_dai;
+			return dai;
 		}
 	}
 
@@ -916,33 +904,19 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_component *component;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
+	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_dai **codec_dais = rtd->codec_dais;
 	struct snd_soc_platform *platform;
-	struct snd_soc_dai *cpu_dai;
 	const char *platform_name;
 	int i;
 
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
-	/* Find CPU DAI from registered DAIs*/
-	list_for_each_entry(component, &component_list, list) {
-		if (dai_link->cpu_of_node &&
-			component->dev->of_node != dai_link->cpu_of_node)
-			continue;
-		if (dai_link->cpu_name &&
-			strcmp(dev_name(component->dev), dai_link->cpu_name))
-			continue;
-		list_for_each_entry(cpu_dai, &component->dai_list, list) {
-			if (dai_link->cpu_dai_name &&
-				strcmp(cpu_dai->name, dai_link->cpu_dai_name))
-				continue;
-
-			rtd->cpu_dai = cpu_dai;
-		}
-	}
-
+	cpu_dai_component.name = dai_link->cpu_name;
+	cpu_dai_component.of_node = dai_link->cpu_of_node;
+	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
+	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
 	if (!rtd->cpu_dai) {
 		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
 			dai_link->cpu_dai_name);
@@ -953,15 +927,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 
 	/* Find CODEC from registered CODECs */
 	for (i = 0; i < rtd->num_codecs; i++) {
-		struct snd_soc_codec *codec;
-		codec = soc_find_codec(codecs[i].of_node, codecs[i].name);
-		if (!codec) {
-			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
-				codecs[i].name);
-			return -EPROBE_DEFER;
-		}
-
-		codec_dais[i] = soc_find_codec_dai(codec, codecs[i].dai_name);
+		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
 			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
 				codecs[i].dai_name);
-- 
1.8.0
