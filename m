From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH v4] ASoC: Allow DAI links to be specified using
	device tree nodes
Date: Fri,  9 Dec 2011 12:36:46 -0700
Message-ID: <1323459406-30567-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BD2410384A
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 20:36:56 +0100 (CET)
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

DAI link endpoints and platform (DMA) devices are currently specified
by name. When instantiating sound cards from device tree, it may be more
convenient to refer to these devices by phandle in the device tree, and
for code to describe DAI links using the "struct device_node *"
("of_node") those phandles map to.

This change adds new fields to snd_soc_dai_link which can "name" devices
using of_node, enhances soc_bind_dai_link() to allow binding based on
of_node, and enhances snd_soc_register_card() to ensure that illegal
combinations of name and of_node are not used.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Liam Girdwood <lrg@ti.com>

COMMIT NOTES:
v2: New patch implementing a new feature
v3: Add Liam's ack
v4: Rebased to re-order this patch directly onto ASoC for-next
---
 include/sound/soc.h  |    4 +++
 sound/soc/soc-core.c |   64 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d9aa66b..40c256e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -231,6 +231,7 @@ enum snd_soc_bias_level {
 	SND_SOC_BIAS_ON = 3,
 };
 
+struct device_node;
 struct snd_jack;
 struct snd_soc_card;
 struct snd_soc_pcm_stream;
@@ -704,8 +705,11 @@ struct snd_soc_dai_link {
 	const char *name;			/* Codec name */
 	const char *stream_name;		/* Stream name */
 	const char *codec_name;		/* for multi-codec */
+	const struct device_node *codec_of_node;
 	const char *platform_name;	/* for multi-platform */
+	const struct device_node *platform_of_node;
 	const char *cpu_dai_name;
+	const struct device_node *cpu_dai_of_node;
 	const char *codec_dai_name;
 
 	unsigned int dai_fmt;           /* format to set on init */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ebb1048..56792d4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -763,8 +763,13 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	}
 	/* no, then find CPU DAI from registered DAIs*/
 	list_for_each_entry(cpu_dai, &dai_list, list) {
-		if (strcmp(cpu_dai->name, dai_link->cpu_dai_name))
-			continue;
+		if (dai_link->cpu_dai_of_node) {
+			if (cpu_dai->dev->of_node != dai_link->cpu_dai_of_node)
+				continue;
+		} else {
+			if (strcmp(cpu_dai->name, dai_link->cpu_dai_name))
+				continue;
+		}
 
 		rtd->cpu_dai = cpu_dai;
 		goto find_codec;
@@ -780,8 +785,13 @@ find_codec:
 
 	/* no, then find CODEC from registered CODECs*/
 	list_for_each_entry(codec, &codec_list, list) {
-		if (strcmp(codec->name, dai_link->codec_name))
-			continue;
+		if (dai_link->codec_of_node) {
+			if (codec->dev->of_node != dai_link->codec_of_node)
+				continue;
+		} else {
+			if (strcmp(codec->name, dai_link->codec_name))
+				continue;
+		}
 
 		rtd->codec = codec;
 
@@ -813,13 +823,19 @@ find_platform:
 
 	/* if there's no platform we match on the empty platform */
 	platform_name = dai_link->platform_name;
-	if (!platform_name)
+	if (!platform_name && !dai_link->platform_of_node)
 		platform_name = "snd-soc-dummy";
 
 	/* no, then find one from the set of registered platforms */
 	list_for_each_entry(platform, &platform_list, list) {
-		if (strcmp(platform->name, platform_name))
-			continue;
+		if (dai_link->platform_of_node) {
+			if (platform->dev->of_node !=
+			    dai_link->platform_of_node)
+				continue;
+		} else {
+			if (strcmp(platform->name, platform_name))
+				continue;
+		}
 
 		rtd->platform = platform;
 		goto out;
@@ -2830,6 +2846,40 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai_link *link = &card->dai_link[i];
+
+		/*
+		 * Codec must be specified by 1 of name or OF node,
+		 * not both or neither.
+		 */
+		if (!!link->codec_name == !!link->codec_of_node) {
+			dev_err(card->dev,
+				"Neither/both codec name/of_node are set\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * Platform may be specified by either name or OF node, but
+		 * can be left unspecified, and a dummy platform will be used.
+		 */
+		if (link->platform_name && link->platform_of_node) {
+			dev_err(card->dev,
+				"Both platform name/of_node are set\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * CPU DAI must be specified by 1 of name or OF node,
+		 * not both or neither.
+		 */
+		if (!!link->cpu_dai_name == !!link->cpu_dai_of_node) {
+			dev_err(card->dev,
+				"Neither/both cpu_dai name/of_node are set\n");
+			return -EINVAL;
+		}
+	}
+
 	dev_set_drvdata(card->dev, card);
 
 	snd_soc_initialize_card_lists(card);
-- 
1.7.0.4
