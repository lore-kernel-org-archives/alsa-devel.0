From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_write() / rsnd_bset() uses
	regmap _force_ function" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:26 +0900
Message-ID: <E1aZ8uE-00088B-W5@finisterre>
References: <87r3gls2u8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B2532614C1
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:29 +0100 (CET)
In-Reply-To: <87r3gls2u8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rsnd_write() / rsnd_bset() uses regmap _force_ function

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

>From 6be2553117b84e6d3e502b0af7c189ddeb89fa5c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:26:51 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_write() / rsnd_bset() uses regmap _force_
 function

Some R-Car sound requests picky register access which needs *force*
register write.
Some status register needs to set 1 to clear status, but we might
read 1 from its register. In such case, current regmap does nothing
and driver will be forever loop
To reduce code complexity, this patch uses regmap _force_
function for all register access.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  | 21 ++-------------------
 sound/soc/sh/rcar/rsnd.h |  2 --
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 271d29adac68..46c0ba7b6414 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -104,23 +104,6 @@ void rsnd_write(struct rsnd_priv *priv,
 	if (!rsnd_is_accessible_reg(priv, gen, reg))
 		return;
 
-	regmap_fields_write(gen->regs[reg], rsnd_mod_id(mod), data);
-
-	dev_dbg(dev, "w %s[%d] - %-18s (%4d) : %08x\n",
-		rsnd_mod_name(mod), rsnd_mod_id(mod),
-		rsnd_reg_name(gen, reg), reg, data);
-}
-
-void rsnd_force_write(struct rsnd_priv *priv,
-		      struct rsnd_mod *mod,
-		      enum rsnd_reg reg, u32 data)
-{
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_gen *gen = rsnd_priv_to_gen(priv);
-
-	if (!rsnd_is_accessible_reg(priv, gen, reg))
-		return;
-
 	regmap_fields_force_write(gen->regs[reg], rsnd_mod_id(mod), data);
 
 	dev_dbg(dev, "w %s[%d] - %-18s (%4d) : %08x\n",
@@ -137,8 +120,8 @@ void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod,
 	if (!rsnd_is_accessible_reg(priv, gen, reg))
 		return;
 
-	regmap_fields_update_bits(gen->regs[reg], rsnd_mod_id(mod),
-				  mask, data);
+	regmap_fields_force_update_bits(gen->regs[reg],
+					rsnd_mod_id(mod), mask, data);
 
 	dev_dbg(dev, "b %s[%d] - %-18s (%4d) : %08x/%08x\n",
 		rsnd_mod_name(mod), rsnd_mod_id(mod),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 5f613eb42614..305cc086a0bc 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -182,8 +182,6 @@ struct rsnd_dai_stream;
 	rsnd_read(rsnd_mod_to_priv(m), m, RSND_REG_##r)
 #define rsnd_mod_write(m, r, d) \
 	rsnd_write(rsnd_mod_to_priv(m), m, RSND_REG_##r, d)
-#define rsnd_mod_force_write(m, r, d) \
-	rsnd_force_write(rsnd_mod_to_priv(m), m, RSND_REG_##r, d)
 #define rsnd_mod_bset(m, r, s, d) \
 	rsnd_bset(rsnd_mod_to_priv(m), m, RSND_REG_##r, s, d)
 
-- 
2.7.0
