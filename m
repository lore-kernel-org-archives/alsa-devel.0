From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_path_parse() for
	CTU/MIX/DVC route setting" to the asoc tree
Date: Thu, 16 Jul 2015 22:30:03 +0100
Message-ID: <E1ZFqjD-0004l8-Cf@finisterre>
References: <87oajdvqug.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E7E266716
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:08 +0200 (CEST)
In-Reply-To: <87oajdvqug.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_path_parse() for CTU/MIX/DVC route setting

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

>From e2c08416196bd10a6575057fdd1347a307ce3a15 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:13:10 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_path_parse() for CTU/MIX/DVC route
 setting

Current sound data route settings is done in dvc.c, and it doesn't care
about CTU/MIX at this poinnt, but we need to care about these.
OTOH, rsnd driver already has rsnd_path_xxx() functions for data path which
are good match for CTU/MIX/DVC path selectio.
This patch adds new rsnd_path_parse() to select sound data route which will
care about CTU/MIX/DVC path.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 22 ++++++++++++++++++++++
 sound/soc/sh/rcar/dvc.c  | 40 +++++++++-------------------------------
 sound/soc/sh/rcar/rsnd.h |  2 ++
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 93fed50..cb82067 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -537,6 +537,28 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	}							\
 }
 
+void rsnd_path_parse(struct rsnd_priv *priv,
+		     struct rsnd_dai_stream *io)
+{
+	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
+	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
+	int src_id = rsnd_mod_id(src);
+	u32 path[] = {
+		[0] = 0x30000,
+		[1] = 0x30001,
+		[2] = 0x40000,
+		[3] = 0x10000,
+		[4] = 0x20000,
+		[5] = 0x40100
+	};
+
+	/* Gen1 is not supported */
+	if (rsnd_is_gen1(priv))
+		return;
+
+	rsnd_mod_write(dvc, CMD_ROUTE_SLCT, path[src_id]);
+}
+
 static int rsnd_path_init(struct rsnd_priv *priv,
 			  struct rsnd_dai *rdai,
 			  struct rsnd_dai_stream *io)
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 24d0763..9392507 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -142,48 +142,26 @@ static int rsnd_dvc_remove_gen2(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_dvc_init(struct rsnd_mod *dvc_mod,
+static int rsnd_dvc_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	struct rsnd_mod *src_mod = rsnd_io_to_mod_src(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	int dvc_id = rsnd_mod_id(dvc_mod);
-	int src_id = rsnd_mod_id(src_mod);
-	u32 route[] = {
-		[0] = 0x30000,
-		[1] = 0x30001,
-		[2] = 0x40000,
-		[3] = 0x10000,
-		[4] = 0x20000,
-		[5] = 0x40100
-	};
-
-	if (src_id >= ARRAY_SIZE(route)) {
-		dev_err(dev, "DVC%d isn't connected to SRC%d\n", dvc_id, src_id);
-		return -EINVAL;
-	}
-
-	rsnd_mod_hw_start(dvc_mod);
+	rsnd_mod_hw_start(mod);
 
-	rsnd_dvc_soft_reset(dvc_mod);
+	rsnd_dvc_soft_reset(mod);
 
-	/*
-	 * fixme
-	 * it doesn't support CTU/MIX
-	 */
-	rsnd_mod_write(dvc_mod, CMD_ROUTE_SLCT, route[src_id]);
+	rsnd_path_parse(priv, io);
 
-	rsnd_mod_write(dvc_mod, DVC_DVUIR, 1);
+	rsnd_mod_write(mod, DVC_DVUIR, 1);
 
-	rsnd_mod_write(dvc_mod, DVC_ADINR, rsnd_get_adinr(dvc_mod, io));
+	rsnd_mod_write(mod, DVC_ADINR, rsnd_get_adinr(mod, io));
 
 	/* ch0/ch1 Volume */
-	rsnd_dvc_volume_update(io, dvc_mod);
+	rsnd_dvc_volume_update(io, mod);
 
-	rsnd_mod_write(dvc_mod, DVC_DVUIR, 0);
+	rsnd_mod_write(mod, DVC_DVUIR, 0);
 
-	rsnd_adg_set_cmd_timsel_gen2(dvc_mod, io);
+	rsnd_adg_set_cmd_timsel_gen2(mod, io);
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index c8d2029..6a87757 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -170,6 +170,8 @@ void rsnd_force_write(struct rsnd_priv *priv, struct rsnd_mod *mod,
 void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 		    u32 mask, u32 data);
 u32 rsnd_get_adinr(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
+void rsnd_path_parse(struct rsnd_priv *priv,
+		     struct rsnd_dai_stream *io);
 
 /*
  *	R-Car DMA
-- 
2.1.4
