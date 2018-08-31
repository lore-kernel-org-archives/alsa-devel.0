From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use
	snd_soc_dai_link_component for platform" to the asoc tree
Date: Fri, 31 Aug 2018 16:34:01 +0100 (BST)
Message-ID: <20180831153401.C280211226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CE93267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:34:02 +0200 (CEST)
In-Reply-To: 
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

   ASoC: soc-core: use snd_soc_dai_link_component for platform

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

>From daecf46ee0e5f0fb2349e20af53c4653e2afc440 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:10:08 +0000
Subject: [PATCH] ASoC: soc-core: use snd_soc_dai_link_component for platform

Current struct snd_soc_dai_link is supporting multicodec,
and it is supporting legacy style of
	codec_name
	codec_of_node
	code_dai_name
This is handled as single entry of multicodec.

We don't have multicpu support yet, but in the future we will.
In such case, we can use snd_soc_dai_link_component for both
cpu/codec. Then the code will be more simple and readble.

As next step, we want to use it for platform, too.
This patch adds snd_soc_dai_link_component style for platform.
We might have multiplatform support in the future, but we
don't know yet. To avoid un-known issue / complex code,
this patch supports just single-platform as 1st step.

If we could use snd_soc_dai_link_component for all CPU/Codec/Platform,
we will switch to new style, and remove legacy code.
This is prepare for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 48 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 41cec42fb456..96c19aabf21b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -915,6 +915,8 @@ struct snd_soc_dai_link {
 	 */
 	const char *platform_name;
 	struct device_node *platform_of_node;
+	struct snd_soc_dai_link_component *platform;
+
 	int id;	/* optional ID for machine driver link identification */
 
 	const struct snd_soc_pcm_stream *params;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 473eefe8658e..2a73630d0680 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -892,8 +892,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	rtd->codec_dai = codec_dais[0];
 
 	/* if there's no platform we match on the empty platform */
-	platform_name = dai_link->platform_name;
-	if (!platform_name && !dai_link->platform_of_node)
+	platform_name = dai_link->platform->name;
+	if (!platform_name && !dai_link->platform->of_node)
 		platform_name = "snd-soc-dummy";
 
 	/* find one from the set of registered platforms */
@@ -902,8 +902,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 		if (!platform_of_node && component->dev->parent->of_node)
 			platform_of_node = component->dev->parent->of_node;
 
-		if (dai_link->platform_of_node) {
-			if (platform_of_node != dai_link->platform_of_node)
+		if (dai_link->platform->of_node) {
+			if (platform_of_node != dai_link->platform->of_node)
 				continue;
 		} else {
 			if (strcmp(component->name, platform_name))
@@ -1015,6 +1015,31 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	}
 }
 
+static int snd_soc_init_platform(struct snd_soc_card *card,
+				 struct snd_soc_dai_link *dai_link)
+{
+	/*
+	 * FIXME
+	 *
+	 * this function should be removed in the future
+	 */
+	/* convert Legacy platform link */
+	if (dai_link->platform)
+		return 0;
+
+	dai_link->platform = devm_kzalloc(card->dev,
+				sizeof(struct snd_soc_dai_link_component),
+				GFP_KERNEL);
+	if (!dai_link->platform)
+		return -ENOMEM;
+
+	dai_link->platform->name	= dai_link->platform_name;
+	dai_link->platform->of_node	= dai_link->platform_of_node;
+	dai_link->platform->dai_name	= NULL;
+
+	return 0;
+}
+
 static int snd_soc_init_multicodec(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *dai_link)
 {
@@ -1047,6 +1072,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 {
 	int i, ret;
 
+	ret = snd_soc_init_platform(card, link);
+	if (ret) {
+		dev_err(card->dev, "ASoC: failed to init multiplatform\n");
+		return ret;
+	}
+
 	ret = snd_soc_init_multicodec(card, link);
 	if (ret) {
 		dev_err(card->dev, "ASoC: failed to init multicodec\n");
@@ -1076,13 +1107,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Platform may be specified by either name or OF node, but
 	 * can be left unspecified, and a dummy platform will be used.
 	 */
-	if (link->platform_name && link->platform_of_node) {
+	if (link->platform->name && link->platform->of_node) {
 		dev_err(card->dev,
 			"ASoC: Both platform name/of_node are set for %s\n",
 			link->name);
 		return -EINVAL;
 	}
-
 	/*
 	 * CPU device may be specified by either name or OF node, but
 	 * can be left unspecified, and will be matched based on DAI
@@ -1917,7 +1947,11 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				 card->dai_link[i].name);
 
 			/* override platform component */
-			dai_link->platform_name = component->name;
+			if (snd_soc_init_platform(card, dai_link) < 0) {
+				dev_err(card->dev, "init platform error");
+				continue;
+			}
+			dai_link->platform->name = component->name;
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
-- 
2.19.0.rc1
