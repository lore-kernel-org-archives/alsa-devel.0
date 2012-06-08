From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 4/4] ASoC: probe CODECs and platforms before
	DAIs and links
Date: Fri,  8 Jun 2012 12:34:23 -0600
Message-ID: <1339180463-21178-4-git-send-email-swarren@wwwdotorg.org>
References: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 65B8411CF31
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 20:34:34 +0200 (CEST)
In-Reply-To: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

soc_probe_dai_link() currently inter-mixes the probing of CODECs,
platforms, and DAIs. This can lead to problems such as a CODEC's DAI
being probed before the CODEC, if that DAI is used as the CPU-side of
a DAI link without any other of the CODEC's DAIs having been used as
the CODEC-side of any DAI link that was probed earlier.

To solve this, split soc_probe_dai_link() into soc_probe_link_components()
and soc_probe_link_dais(). The former is used to probe all CODECs and
platforms used by a card first, and then the latter is used to probe all
the DAIs and links later.

A similar change is made to soc_remove_dai_links().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |  129 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 95 insertions(+), 34 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a539ade..fe16135 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -941,11 +941,9 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 	module_put(codec->dev->driver->owner);
 }
 
-static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
+static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
 	int err;
 
@@ -970,16 +968,6 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 		list_del(&codec_dai->card_list);
 	}
 
-	/* remove the platform */
-	if (platform && platform->probed &&
-			platform->driver->remove_order == order)
-		soc_remove_platform(platform);
-
-	/* remove the CODEC */
-	if (codec && codec->probed &&
-			codec->driver->remove_order == order)
-		soc_remove_codec(codec);
-
 	/* remove the cpu_dai */
 	if (cpu_dai && cpu_dai->probed &&
 			cpu_dai->driver->remove_order == order) {
@@ -999,6 +987,38 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 	}
 }
 
+static void soc_remove_link_components(struct snd_soc_card *card, int num,
+				       int order)
+{
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_codec *codec;
+
+	/* remove the platform */
+	if (platform && platform->probed &&
+	    platform->driver->remove_order == order) {
+		soc_remove_platform(platform);
+	}
+
+	/* remove the CODEC-side CODEC */
+	if (codec_dai) {
+		codec = codec_dai->codec;
+		if (codec && codec->probed &&
+		    codec->driver->remove_order == order)
+			soc_remove_codec(codec);
+	}
+
+	/* remove any CPU-side CODEC */
+	if (cpu_dai) {
+		codec = cpu_dai->codec;
+		if (codec && codec->probed &&
+		    codec->driver->remove_order == order)
+			soc_remove_codec(codec);
+	}
+}
+
 static void soc_remove_dai_links(struct snd_soc_card *card)
 {
 	int dai, order;
@@ -1006,8 +1026,15 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
 		for (dai = 0; dai < card->num_rtd; dai++)
-			soc_remove_dai_link(card, dai, order);
+			soc_remove_link_dais(card, dai, order);
+	}
+
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++) {
+		for (dai = 0; dai < card->num_rtd; dai++)
+			soc_remove_link_components(card, dai, order);
 	}
+
 	card->num_rtd = 0;
 }
 
@@ -1244,7 +1271,44 @@ out:
 	return 0;
 }
 
-static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
+static int soc_probe_link_components(struct snd_soc_card *card, int num,
+				     int order)
+{
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret;
+
+	/* probe the CPU-side component, if it is a CODEC */
+	if (cpu_dai->codec &&
+	    !cpu_dai->codec->probed &&
+	    cpu_dai->codec->driver->probe_order == order) {
+		ret = soc_probe_codec(card, cpu_dai->codec);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* probe the CODEC-side component */
+	if (!codec_dai->codec->probed &&
+	    codec_dai->codec->driver->probe_order == order) {
+		ret = soc_probe_codec(card, codec_dai->codec);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* probe the platform */
+	if (!platform->probed &&
+	    platform->driver->probe_order == order) {
+		ret = soc_probe_platform(card, platform);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
@@ -1292,22 +1356,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 		list_add(&cpu_dai->card_list, &card->dai_dev_list);
 	}
 
-	/* probe the CODEC */
-	if (!codec->probed &&
-			codec->driver->probe_order == order) {
-		ret = soc_probe_codec(card, codec);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* probe the platform */
-	if (!platform->probed &&
-			platform->driver->probe_order == order) {
-		ret = soc_probe_platform(card, platform);
-		if (ret < 0)
-			return ret;
-	}
-
 	/* probe the CODEC DAI */
 	if (!codec_dai->probed && codec_dai->driver->probe_order == order) {
 		if (codec_dai->driver->probe) {
@@ -1582,14 +1630,27 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto card_probe_error;
 	}
 
-	/* early DAI link probe */
+	/* probe all components used by DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
 		for (i = 0; i < card->num_links; i++) {
-			ret = soc_probe_dai_link(card, i, order);
+			ret = soc_probe_link_components(card, i, order);
 			if (ret < 0) {
 				pr_err("asoc: failed to instantiate card %s: %d\n",
-			       card->name, ret);
+				       card->name, ret);
+				goto probe_dai_err;
+			}
+		}
+	}
+
+	/* probe all DAI links on this card */
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++) {
+		for (i = 0; i < card->num_links; i++) {
+			ret = soc_probe_link_dais(card, i, order);
+			if (ret < 0) {
+				pr_err("asoc: failed to instantiate card %s: %d\n",
+				       card->name, ret);
 				goto probe_dai_err;
 			}
 		}
-- 
1.7.0.4
