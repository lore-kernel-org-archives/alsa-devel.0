From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use soc_find_component() at
	snd_soc_get_dai_id()" to the asoc tree
Date: Mon, 13 May 2019 13:30:27 +0100 (BST)
Message-ID: <20190513123027.208EB1129237@debutante.sirena.org.uk>
References: <87r292alro.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D181EF896B8
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <87r292alro.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: use soc_find_component() at snd_soc_get_dai_id()

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

>From 09d4cc03ff77790872b8b9e51b6d7b5863686fc5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2019 16:07:20 +0900
Subject: [PATCH] ASoC: soc-core: use soc_find_component() at
 snd_soc_get_dai_id()

soc-core core already has soc_find_component() which find
component from device node.
Let's use existing function to find component.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e55170ce6d3e..e83edbe27041 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3751,7 +3751,7 @@ EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
 int snd_soc_get_dai_id(struct device_node *ep)
 {
-	struct snd_soc_component *pos;
+	struct snd_soc_component *component;
 	struct device_node *node;
 	int ret;
 
@@ -3765,17 +3765,10 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	 */
 	ret = -ENOTSUPP;
 	mutex_lock(&client_mutex);
-	for_each_component(pos) {
-		struct device_node *component_of_node = soc_component_to_node(pos);
-
-		if (component_of_node != node)
-			continue;
-
-		if (pos->driver->of_xlate_dai_id)
-			ret = pos->driver->of_xlate_dai_id(pos, ep);
-
-		break;
-	}
+	component = soc_find_component(node, NULL);
+	if (component &&
+	    component->driver->of_xlate_dai_id)
+		ret = component->driver->of_xlate_dai_id(component, ep);
 	mutex_unlock(&client_mutex);
 
 	of_node_put(node);
-- 
2.20.1
