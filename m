From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add
	snd_soc_is_matching_component()" to the asoc tree
Date: Mon, 17 Sep 2018 22:21:02 +0100 (BST)
Message-ID: <20180917212102.C6B3A440078@finisterre.ee.mobilebroadband>
References: <87zhwo4jov.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E1CF267892
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 23:21:06 +0200 (CEST)
In-Reply-To: <87zhwo4jov.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: add snd_soc_is_matching_component()

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

>From be6ac0a9ced99403c435b2b2fe9ac4bd55749823 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Sep 2018 06:51:45 +0000
Subject: [PATCH] ASoC: soc-core: add snd_soc_is_matching_component()

To find (CPU/)Codec/Platform, we need to find component first
(= on CPU/Codec/Platform), and find DAI from it (= CPU/Codec).
These are similar operation but difficult to be simple,
and has many duplicate code to finding component.
This patch adds new snd_soc_is_matching_component(),
and reduce duplicate codes.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d856b08f5f99..da2b2a758b6d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -737,6 +737,24 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
+static int snd_soc_is_matching_component(
+	const struct snd_soc_dai_link_component *dlc,
+	struct snd_soc_component *component)
+{
+	struct device_node *component_of_node;
+
+	component_of_node = component->dev->of_node;
+	if (!component_of_node && component->dev->parent)
+		component_of_node = component->dev->parent->of_node;
+
+	if (dlc->of_node && component_of_node != dlc->of_node)
+		return 0;
+	if (dlc->name && strcmp(component->name, dlc->name))
+		return 0;
+
+	return 1;
+}
+
 /**
  * snd_soc_find_dai - Find a registered DAI
  *
@@ -753,19 +771,12 @@ struct snd_soc_dai *snd_soc_find_dai(
 {
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
-	struct device_node *component_of_node;
 
 	lockdep_assert_held(&client_mutex);
 
 	/* Find CPU DAI from registered DAIs*/
 	list_for_each_entry(component, &component_list, list) {
-		component_of_node = component->dev->of_node;
-		if (!component_of_node && component->dev->parent)
-			component_of_node = component->dev->parent->of_node;
-
-		if (dlc->of_node && component_of_node != dlc->of_node)
-			continue;
-		if (dlc->name && strcmp(component->name, dlc->name))
+		if (!snd_soc_is_matching_component(dlc, component))
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
 			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
@@ -844,7 +855,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_component *component;
 	struct snd_soc_dai **codec_dais;
-	struct device_node *platform_of_node;
 	int i;
 
 	if (dai_link->ignore)
@@ -893,17 +903,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	/* find one from the set of registered platforms */
 	list_for_each_entry(component, &component_list, list) {
-		platform_of_node = component->dev->of_node;
-		if (!platform_of_node && component->dev->parent->of_node)
-			platform_of_node = component->dev->parent->of_node;
-
-		if (dai_link->platform->of_node) {
-			if (platform_of_node != dai_link->platform->of_node)
-				continue;
-		} else {
-			if (strcmp(component->name, dai_link->platform->name))
-				continue;
-		}
+		if (!snd_soc_is_matching_component(dai_link->platform,
+						   component))
+			continue;
 
 		snd_soc_rtdcom_add(rtd, component);
 	}
-- 
2.19.0
