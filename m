From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: move soc_find_component()" to
	the asoc tree
Date: Mon, 24 Jun 2019 17:32:14 +0100 (BST)
Message-ID: <20190624163214.0EB9B440053@finisterre.sirena.org.uk>
References: <87sgs5rsl2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBD61F8071F
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 11:53:58 +0200 (CEST)
In-Reply-To: <87sgs5rsl2.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: move soc_find_component()

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

>From 7d7db5d3c3d849c2f877be3b4c9afa7f5b5257c2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Jun 2019 09:49:17 +0900
Subject: [PATCH] ASoC: soc-core: move soc_find_component()

move soc_find_component() next to snd_soc_is_matching_component().
This is prepare for soc_find_component() cleanup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4cd77cd6c864..1b94119cfb0d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -760,6 +760,25 @@ static struct device_node
 	return of_node;
 }
 
+static int snd_soc_is_matching_component(
+	const struct snd_soc_dai_link_component *dlc,
+	struct snd_soc_component *component)
+{
+	struct device_node *component_of_node;
+
+	if (!dlc)
+		return 0;
+
+	component_of_node = soc_component_to_node(component);
+
+	if (dlc->of_node && component_of_node != dlc->of_node)
+		return 0;
+	if (dlc->name && strcmp(component->name, dlc->name))
+		return 0;
+
+	return 1;
+}
+
 static struct snd_soc_component *soc_find_component(
 	const struct device_node *of_node, const char *name)
 {
@@ -782,25 +801,6 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
-static int snd_soc_is_matching_component(
-	const struct snd_soc_dai_link_component *dlc,
-	struct snd_soc_component *component)
-{
-	struct device_node *component_of_node;
-
-	if (!dlc)
-		return 0;
-
-	component_of_node = soc_component_to_node(component);
-
-	if (dlc->of_node && component_of_node != dlc->of_node)
-		return 0;
-	if (dlc->name && strcmp(component->name, dlc->name))
-		return 0;
-
-	return 1;
-}
-
 /**
  * snd_soc_find_dai - Find a registered DAI
  *
-- 
2.20.1
