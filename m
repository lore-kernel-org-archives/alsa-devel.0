From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add RSND_GEN3 for R-Car Gen3" to
	the asoc tree
Date: Fri, 13 Apr 2018 12:22:50 +0100
Message-ID: <E1f6wn4-0008Pm-5N@debutante>
References: <87sh82fqcc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB9F267356
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:22:52 +0200 (CEST)
In-Reply-To: <87sh82fqcc.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Mark Brown <broonie@kernel.org>, Nguyen Viet Dung <dung.nguyen.aj@renesas.com>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add RSND_GEN3 for R-Car Gen3

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

>From 53041ccf8b8883d2e22525d36ddfff16b80541b6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Apr 2018 02:10:29 +0000
Subject: [PATCH] ASoC: rsnd: add RSND_GEN3 for R-Car Gen3

rsnd driver is supporting Gen3. The difference between Gen1 and Gen2
were very big, but, between Gen2 and Gen3 are not so much.
Thus, it is assuming Gen2 and Gen3 have compatible, therefore,
there is no RSND_GEN3 and rsnd_is_gen3() macro.
But in the future, it will need Gen2 and Gen3 different operation,
and for Gen4.
This patch adds missing RSND_GEN3 and rsnd_is_gen3() macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 sound/soc/sh/rcar/dma.c  | 4 ++--
 sound/soc/sh/rcar/gen.c  | 3 ++-
 sound/soc/sh/rcar/rsnd.h | 2 ++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6a76688a8ba9..47a55d6bfd80 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -111,7 +111,7 @@
 static const struct of_device_id rsnd_of_match[] = {
 	{ .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
 	{ .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
-	{ .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN2 }, /* gen2 compatible */
+	{ .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rsnd_of_match);
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 41de23417c4a..32ac97be26f1 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -695,7 +695,7 @@ static int rsnd_dma_alloc(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 
 	rsnd_dma_of_path(mod, io, is_play, &mod_from, &mod_to);
 
-	/* for Gen2 */
+	/* for Gen2 or later */
 	if (mod_from && mod_to) {
 		ops	= &rsnd_dmapp_ops;
 		attach	= rsnd_dmapp_attach;
@@ -773,7 +773,7 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
 		return 0;
 
 	/*
-	 * for Gen2
+	 * for Gen2 or later
 	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "audmapp");
 	dmac = devm_kzalloc(dev, sizeof(*dmac), GFP_KERNEL);
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index f04c4100043a..25642e92dae0 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -414,7 +414,8 @@ int rsnd_gen_probe(struct rsnd_priv *priv)
 	ret = -ENODEV;
 	if (rsnd_is_gen1(priv))
 		ret = rsnd_gen1_probe(priv);
-	else if (rsnd_is_gen2(priv))
+	else if (rsnd_is_gen2(priv) ||
+		 rsnd_is_gen3(priv))
 		ret = rsnd_gen2_probe(priv);
 
 	if (ret < 0)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ab4d55548ed1..b1896f1eb214 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -538,6 +538,7 @@ struct rsnd_priv {
 #define RSND_GEN_MASK	(0xF << 0)
 #define RSND_GEN1	(1 << 0)
 #define RSND_GEN2	(2 << 0)
+#define RSND_GEN3	(3 << 0)
 
 	/*
 	 * below value will be filled on rsnd_gen_probe()
@@ -609,6 +610,7 @@ struct rsnd_priv {
 
 #define rsnd_is_gen1(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN1)
 #define rsnd_is_gen2(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN2)
+#define rsnd_is_gen3(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN3)
 
 #define rsnd_flags_has(p, f) ((p)->flags & (f))
 #define rsnd_flags_set(p, f) ((p)->flags |= (f))
-- 
2.17.0
