From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: allow soc-core to pick up name prefixes
	from component nodes" to the asoc tree
Date: Fri, 13 Jul 2018 16:10:12 +0100 (BST)
Message-ID: <20180713151012.162C444007A@finisterre.ee.mobilebroadband>
References: <20180713125043.13242-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AEB9267730
 for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2018 00:44:23 +0200 (CEST)
In-Reply-To: <20180713125043.13242-3-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: allow soc-core to pick up name prefixes from component nodes

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

>From aefba45539bc4868c1fae336410aec907ee0882a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 13 Jul 2018 14:50:43 +0200
Subject: [PATCH] ASoC: allow soc-core to pick up name prefixes from component
 nodes

When the component does not match the configuration table provided
by the card, let soc-core check the component node for a name prefix

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0
