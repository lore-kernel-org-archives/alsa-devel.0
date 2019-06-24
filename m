From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: soc_find_component() uses
	snd_soc_dai_link_component" to the asoc tree
Date: Mon, 24 Jun 2019 17:32:13 +0100 (BST)
Message-ID: <20190624163213.C727F44004A@finisterre.sirena.org.uk>
References: <87pnn9rsks.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5782AF896F0
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 11:53:58 +0200 (CEST)
In-Reply-To: <87pnn9rsks.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: soc_find_component() uses snd_soc_dai_link_component

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

>From c1e230f0f7a3cc640317aa78389258a2fa54bcde Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Jun 2019 09:49:27 +0900
Subject: [PATCH] ASoC: soc-core: soc_find_component() uses
 snd_soc_dai_link_component

soc_find_component() is using "of_node" and "name" to finding component,
but we should use snd_soc_dai_link_component now, because it is created
to such purpose.

This patch uses snd_soc_dai_link_component for soc_find_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 45 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e6b95b7e2737..1749f4af91b6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -780,19 +780,15 @@ static int snd_soc_is_matching_component(
 }
 
 static struct snd_soc_component *soc_find_component(
-	struct device_node *of_node, const char *name)
+	const struct snd_soc_dai_link_component *dlc)
 {
 	struct snd_soc_component *component;
-	struct snd_soc_dai_link_component dlc;
 
 	lockdep_assert_held(&client_mutex);
 
-	for_each_component(component) {
-		dlc.name = name;
-		dlc.of_node = of_node;
-		if (snd_soc_is_matching_component(&dlc, component))
+	for_each_component(component)
+		if (snd_soc_is_matching_component(dlc, component))
 			return component;
-	}
 
 	return NULL;
 }
@@ -1106,8 +1102,7 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 		 * added to component list.
 		 */
 		if ((link->platforms->of_node || link->platforms->name) &&
-		    !soc_find_component(link->platforms->of_node,
-					link->platforms->name))
+		    !soc_find_component(link->platforms))
 			return -EPROBE_DEFER;
 	}
 
@@ -1136,7 +1131,7 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * component list.
 	 */
 	if ((link->cpus->of_node || link->cpus->name) &&
-	    !soc_find_component(link->cpus->of_node, link->cpus->name))
+	    !soc_find_component(link->cpus))
 		return -EPROBE_DEFER;
 
 	/*
@@ -1580,23 +1575,23 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_component *component;
-	const char *name;
-	struct device_node *codec_of_node;
+	struct snd_soc_dai_link_component dlc;
 
 	if (aux_dev->codec_of_node || aux_dev->codec_name) {
 		/* codecs, usually analog devices */
-		name = aux_dev->codec_name;
-		codec_of_node = aux_dev->codec_of_node;
-		component = soc_find_component(codec_of_node, name);
+		dlc.name = aux_dev->codec_name;
+		dlc.of_node = aux_dev->codec_of_node;
+		component = soc_find_component(&dlc);
 		if (!component) {
-			if (codec_of_node)
-				name = of_node_full_name(codec_of_node);
+			if (dlc.of_node)
+				dlc.name = of_node_full_name(dlc.of_node);
 			goto err_defer;
 		}
 	} else if (aux_dev->name) {
 		/* generic components */
-		name = aux_dev->name;
-		component = soc_find_component(NULL, name);
+		dlc.name = aux_dev->name;
+		dlc.of_node = NULL;
+		component = soc_find_component(&dlc);
 		if (!component)
 			goto err_defer;
 	} else {
@@ -1610,7 +1605,7 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 	return 0;
 
 err_defer:
-	dev_err(card->dev, "ASoC: %s not registered\n", name);
+	dev_err(card->dev, "ASoC: %s not registered\n", dlc.name);
 	return -EPROBE_DEFER;
 }
 
@@ -3661,11 +3656,11 @@ EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 int snd_soc_get_dai_id(struct device_node *ep)
 {
 	struct snd_soc_component *component;
-	struct device_node *node;
+	struct snd_soc_dai_link_component dlc;
 	int ret;
 
-	node = of_graph_get_port_parent(ep);
-
+	dlc.of_node	= of_graph_get_port_parent(ep);
+	dlc.name	= NULL;
 	/*
 	 * For example HDMI case, HDMI has video/sound port,
 	 * but ALSA SoC needs sound port number only.
@@ -3674,13 +3669,13 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	 */
 	ret = -ENOTSUPP;
 	mutex_lock(&client_mutex);
-	component = soc_find_component(node, NULL);
+	component = soc_find_component(&dlc);
 	if (component &&
 	    component->driver->of_xlate_dai_id)
 		ret = component->driver->of_xlate_dai_id(component, ep);
 	mutex_unlock(&client_mutex);
 
-	of_node_put(node);
+	of_node_put(dlc.of_node);
 
 	return ret;
 }
-- 
2.20.1
