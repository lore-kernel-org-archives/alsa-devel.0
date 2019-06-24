From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: soc_find_component() uses
	snd_soc_is_matching_component()" to the asoc tree
Date: Mon, 24 Jun 2019 17:32:13 +0100 (BST)
Message-ID: <20190624163213.E612A44004F@finisterre.sirena.org.uk>
References: <87r27prskw.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E089F896FD
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 11:53:59 +0200 (CEST)
In-Reply-To: <87r27prskw.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: soc_find_component() uses snd_soc_is_matching_component()

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

>From a9ec84966f6d887b9066029596eb361b5d2af214 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Jun 2019 09:49:23 +0900
Subject: [PATCH] ASoC: soc-core: soc_find_component() uses
 snd_soc_is_matching_component()

ALSA SoC already has snd_soc_is_matching_component() to confirming
matching component, but, soc_find_component() has original
implementation to confirm component.

We shouldn't have duplicate implementation to do same things.
This patch uses snd_soc_is_matching_component() at soc_find_component()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1b94119cfb0d..e6b95b7e2737 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -780,22 +780,18 @@ static int snd_soc_is_matching_component(
 }
 
 static struct snd_soc_component *soc_find_component(
-	const struct device_node *of_node, const char *name)
+	struct device_node *of_node, const char *name)
 {
 	struct snd_soc_component *component;
-	struct device_node *component_of_node;
+	struct snd_soc_dai_link_component dlc;
 
 	lockdep_assert_held(&client_mutex);
 
 	for_each_component(component) {
-		if (of_node) {
-			component_of_node = soc_component_to_node(component);
-
-			if (component_of_node == of_node)
-				return component;
-		} else if (name && strcmp(component->name, name) == 0) {
+		dlc.name = name;
+		dlc.of_node = of_node;
+		if (snd_soc_is_matching_component(&dlc, component))
 			return component;
-		}
 	}
 
 	return NULL;
-- 
2.20.1
