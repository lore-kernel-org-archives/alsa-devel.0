From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't call unneeded of_node_put()
	on dma.c" to the asoc tree
Date: Tue, 25 Oct 2016 20:23:43 +0100
Message-ID: <E1bz7K3-0004nW-CM@debutante>
References: <871sz5clxh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E17CE2606F8
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:23:50 +0200 (CEST)
In-Reply-To: <871sz5clxh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't call unneeded of_node_put() on dma.c

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 161ba1f1a5c99c4525eb39cc71ec984e0a39e6d7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Oct 2016 00:37:18 +0000
Subject: [PATCH] ASoC: rsnd: don't call unneeded of_node_put() on dma.c

Current rsnd_dmaen_start() is calling of_node_put() for np,
but it is not needed if it goes through this loop.
This patch tidyup it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index c85a55111392..2f0327714625 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -143,19 +143,17 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 					  struct rsnd_mod *mod, char *name)
 {
-	struct dma_chan *chan;
+	struct dma_chan *chan = NULL;
 	struct device_node *np;
 	int i = 0;
 
 	for_each_child_of_node(of_node, np) {
-		if (i == rsnd_mod_id(mod))
-			break;
+		if (i == rsnd_mod_id(mod) && (!chan))
+			chan = of_dma_request_slave_channel(np, name);
 		i++;
 	}
 
-	chan = of_dma_request_slave_channel(np, name);
-
-	of_node_put(np);
+	/* It should call of_node_put(), since, it is rsnd_xxx_of_node() */
 	of_node_put(of_node);
 
 	return chan;
-- 
2.8.1
