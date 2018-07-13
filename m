From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] ASoC: allow soc-core to pick up name prefixes from component nodes
Date: Fri, 13 Jul 2018 14:50:43 +0200
Message-ID: <20180713125043.13242-3-jbrunet@baylibre.com>
References: <20180713125043.13242-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713125043.13242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When the component does not match the configuration table provided
by the card, let soc-core check the component node for a name prefix

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 00bd58d167dd..3be0310d5c81 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1193,15 +1193,27 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
 
+static void soc_set_of_name_prefix(struct snd_soc_component *component)
+{
+	struct device_node *component_of_node = component->dev->of_node;
+	const char *str;
+	int ret;
+
+	if (!component_of_node && component->dev->parent)
+		component_of_node = component->dev->parent->of_node;
+
+	ret = of_property_read_string(component_of_node, "sound-name-prefix",
+				      &str);
+	if (!ret)
+		component->name_prefix = str;
+}
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
 	int i;
 
-	if (card->codec_conf == NULL)
-		return;
-
-	for (i = 0; i < card->num_configs; i++) {
+	for (i = 0; i < card->num_configs && card->codec_conf; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 		struct device_node *component_of_node = component->dev->of_node;
 
@@ -1213,8 +1225,14 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 		if (map->dev_name && strcmp(component->name, map->dev_name))
 			continue;
 		component->name_prefix = map->name_prefix;
-		break;
+		return;
 	}
+
+	/*
+	 * If there is no configuration table or no match in the table,
+	 * check if a prefix is provided in the node
+	 */
+	soc_set_of_name_prefix(component);
 }
 
 static int soc_probe_component(struct snd_soc_card *card,
-- 
2.14.4
