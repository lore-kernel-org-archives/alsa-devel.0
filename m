From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: manage platform name under
	snd_soc_init_platform()" to the asoc tree
Date: Mon, 17 Sep 2018 22:21:09 +0100 (BST)
Message-ID: <20180917212109.F2FDC440078@finisterre.ee.mobilebroadband>
References: <871sa05ya3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 569752678A6
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 23:21:12 +0200 (CEST)
In-Reply-To: <871sa05ya3.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: manage platform name under snd_soc_init_platform()

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

>From 4a9ed39477bd1635cf23b49e10f9e364329bbe46 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Sep 2018 06:51:14 +0000
Subject: [PATCH] ASoC: soc-core: manage platform name under
 snd_soc_init_platform()

Now "platform" is controlled by snd_soc_dai_link_component,
thus its "name" can be initialized in snd_soc_init_platform(),
instead of soc_bind_dai_link() local.
This patch do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 325dc1964850..d856b08f5f99 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -845,7 +845,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_dai **codec_dais;
 	struct device_node *platform_of_node;
-	const char *platform_name;
 	int i;
 
 	if (dai_link->ignore)
@@ -892,11 +891,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	/* Single codec links expect codec and codec_dai in runtime data */
 	rtd->codec_dai = codec_dais[0];
 
-	/* if there's no platform we match on the empty platform */
-	platform_name = dai_link->platform->name;
-	if (!platform_name && !dai_link->platform->of_node)
-		platform_name = "snd-soc-dummy";
-
 	/* find one from the set of registered platforms */
 	list_for_each_entry(component, &component_list, list) {
 		platform_of_node = component->dev->of_node;
@@ -907,7 +901,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 			if (platform_of_node != dai_link->platform->of_node)
 				continue;
 		} else {
-			if (strcmp(component->name, platform_name))
+			if (strcmp(component->name, dai_link->platform->name))
 				continue;
 		}
 
@@ -1020,24 +1014,31 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
+	struct snd_soc_dai_link_component *platform = dai_link->platform;
+
 	/*
 	 * FIXME
 	 *
 	 * this function should be removed in the future
 	 */
 	/* convert Legacy platform link */
-	if (dai_link->platform)
-		return 0;
-
-	dai_link->platform = devm_kzalloc(card->dev,
+	if (!platform) {
+		platform = devm_kzalloc(card->dev,
 				sizeof(struct snd_soc_dai_link_component),
 				GFP_KERNEL);
-	if (!dai_link->platform)
-		return -ENOMEM;
+		if (!platform)
+			return -ENOMEM;
 
-	dai_link->platform->name	= dai_link->platform_name;
-	dai_link->platform->of_node	= dai_link->platform_of_node;
-	dai_link->platform->dai_name	= NULL;
+		dai_link->platform	= platform;
+		platform->name		= dai_link->platform_name;
+		platform->of_node	= dai_link->platform_of_node;
+		platform->dai_name	= NULL;
+	}
+
+	/* if there's no platform we match on the empty platform */
+	if (!platform->name &&
+	    !platform->of_node)
+		platform->name = "snd-soc-dummy";
 
 	return 0;
 }
-- 
2.19.0
