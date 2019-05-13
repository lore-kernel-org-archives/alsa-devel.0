From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add soc_component_to_node()"
	to the asoc tree
Date: Mon, 13 May 2019 13:30:27 +0100 (BST)
Message-ID: <20190513123027.537341129238@debutante.sirena.org.uk>
References: <87sgtialsa.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3F6CF89720
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <87sgtialsa.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add soc_component_to_node()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From c083444061ada428af71809cc12fd8f06dd2be19 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2019 16:06:59 +0900
Subject: [PATCH] ASoC: soc-core: add soc_component_to_node()

Many function are getting device_node from component
with caring its parent component.
This patch adds new soc_component_to_node() and share
same code.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c80e7df3b20b..e55170ce6d3e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -738,6 +738,18 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
+static struct device_node
+*soc_component_to_node(struct snd_soc_component *component)
+{
+	struct device_node *of_node;
+
+	of_node = component->dev->of_node;
+	if (!of_node && component->dev->parent)
+		of_node = component->dev->parent->of_node;
+
+	return of_node;
+}
+
 static struct snd_soc_component *soc_find_component(
 	const struct device_node *of_node, const char *name)
 {
@@ -748,9 +760,7 @@ static struct snd_soc_component *soc_find_component(
 
 	for_each_component(component) {
 		if (of_node) {
-			component_of_node = component->dev->of_node;
-			if (!component_of_node && component->dev->parent)
-				component_of_node = component->dev->parent->of_node;
+			component_of_node = soc_component_to_node(component);
 
 			if (component_of_node == of_node)
 				return component;
@@ -768,9 +778,7 @@ static int snd_soc_is_matching_component(
 {
 	struct device_node *component_of_node;
 
-	component_of_node = component->dev->of_node;
-	if (!component_of_node && component->dev->parent)
-		component_of_node = component->dev->parent->of_node;
+	component_of_node = soc_component_to_node(component);
 
 	if (dlc->of_node && component_of_node != dlc->of_node)
 		return 0;
@@ -1317,13 +1325,10 @@ EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
 
 static void soc_set_of_name_prefix(struct snd_soc_component *component)
 {
-	struct device_node *component_of_node = component->dev->of_node;
+	struct device_node *component_of_node = soc_component_to_node(component);
 	const char *str;
 	int ret;
 
-	if (!component_of_node && component->dev->parent)
-		component_of_node = component->dev->parent->of_node;
-
 	ret = of_property_read_string(component_of_node, "sound-name-prefix",
 				      &str);
 	if (!ret)
@@ -1337,10 +1342,7 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 
 	for (i = 0; i < card->num_configs && card->codec_conf; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
-		struct device_node *component_of_node = component->dev->of_node;
-
-		if (!component_of_node && component->dev->parent)
-			component_of_node = component->dev->parent->of_node;
+		struct device_node *component_of_node = soc_component_to_node(component);
 
 		if (map->of_node && component_of_node != map->of_node)
 			continue;
@@ -3764,10 +3766,7 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	ret = -ENOTSUPP;
 	mutex_lock(&client_mutex);
 	for_each_component(pos) {
-		struct device_node *component_of_node = pos->dev->of_node;
-
-		if (!component_of_node && pos->dev->parent)
-			component_of_node = pos->dev->parent->of_node;
+		struct device_node *component_of_node = soc_component_to_node(pos);
 
 		if (component_of_node != node)
 			continue;
@@ -3794,9 +3793,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 
 	mutex_lock(&client_mutex);
 	for_each_component(pos) {
-		component_of_node = pos->dev->of_node;
-		if (!component_of_node && pos->dev->parent)
-			component_of_node = pos->dev->parent->of_node;
+		component_of_node = soc_component_to_node(pos);
 
 		if (component_of_node != args->np)
 			continue;
-- 
2.20.1
