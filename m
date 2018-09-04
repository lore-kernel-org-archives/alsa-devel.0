From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_link_codecs() macro" to
	the asoc tree
Date: Tue,  4 Sep 2018 17:22:22 +0100 (BST)
Message-ID: <20180904162222.9AD1711227D8@debutante.sirena.org.uk>
References: <87k1o3fi84.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 30B8026789B
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 18:22:23 +0200 (CEST)
In-Reply-To: <87k1o3fi84.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add for_each_link_codecs() macro

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3db769f17714ae65f2faf44ff2bae9d52f4bd46b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 3 Sep 2018 02:12:40 +0000
Subject: [PATCH] ASoC: add for_each_link_codecs() macro

ALSA SoC snd_soc_dai_link has snd_soc_dai_link_component array
for codecs.
To be more readable code, this patch adds
new for_each_link_codecs() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h        |  4 ++++
 sound/soc/meson/axg-card.c |  5 +++--
 sound/soc/soc-core.c       | 17 ++++++++---------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 96c19aabf21b..ce42c578fe82 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -978,6 +978,10 @@ struct snd_soc_dai_link {
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
 };
+#define for_each_link_codecs(link, i, codec)				\
+	for ((i) = 0;							\
+	     ((i) < link->num_codecs) && ((codec) = &link->codecs[i]);	\
+	     (i)++)
 
 struct snd_soc_codec_conf {
 	/*
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index b76a5f4f1785..3e68f1aa68ff 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -97,14 +97,15 @@ static void axg_card_clean_references(struct axg_card *priv)
 {
 	struct snd_soc_card *card = &priv->card;
 	struct snd_soc_dai_link *link;
+	struct snd_soc_dai_link_component *codec;
 	int i, j;
 
 	if (card->dai_link) {
 		for (i = 0; i < card->num_links; i++) {
 			link = &card->dai_link[i];
 			of_node_put(link->cpu_of_node);
-			for (j = 0; j < link->num_codecs; j++)
-				of_node_put(link->codecs[j].of_node);
+			for_each_link_codecs(link, j, codec)
+				of_node_put(codec->of_node);
 		}
 	}
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e9c2304afaf1..eeab492e954f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1071,6 +1071,7 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *link)
 {
 	int i, ret;
+	struct snd_soc_dai_link_component *codec;
 
 	ret = snd_soc_init_platform(card, link);
 	if (ret) {
@@ -1084,19 +1085,19 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 		return ret;
 	}
 
-	for (i = 0; i < link->num_codecs; i++) {
+	for_each_link_codecs(link, i, codec) {
 		/*
 		 * Codec must be specified by 1 of name or OF node,
 		 * not both or neither.
 		 */
-		if (!!link->codecs[i].name ==
-		    !!link->codecs[i].of_node) {
+		if (!!codec->name ==
+		    !!codec->of_node) {
 			dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
 		/* Codec DAI name must be specified */
-		if (!link->codecs[i].dai_name) {
+		if (!codec->dai_name) {
 			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
 				link->name);
 			return -EINVAL;
@@ -3796,10 +3797,10 @@ EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
  */
 void snd_soc_of_put_dai_link_codecs(struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link_component *component = dai_link->codecs;
+	struct snd_soc_dai_link_component *component;
 	int index;
 
-	for (index = 0; index < dai_link->num_codecs; index++, component++) {
+	for_each_link_codecs(dai_link, index, component) {
 		if (!component->of_node)
 			break;
 		of_node_put(component->of_node);
@@ -3851,9 +3852,7 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 	dai_link->num_codecs = num_codecs;
 
 	/* Parse the list */
-	for (index = 0, component = dai_link->codecs;
-	     index < dai_link->num_codecs;
-	     index++, component++) {
+	for_each_link_codecs(dai_link, index, component) {
 		ret = of_parse_phandle_with_args(of_node, name,
 						 "#sound-dai-cells",
 						  index, &args);
-- 
2.19.0.rc1
