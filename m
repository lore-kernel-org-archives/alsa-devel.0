From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: gen: add rsnd_force_write()" to
	the asoc tree
Date: Fri, 10 Jul 2015 11:39:58 +0100
Message-ID: <E1ZDVio-0002Eo-TQ@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC978260499
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 12:40:08 +0200 (CEST)
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: gen: add rsnd_force_write()

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

>From 7b47ab47b3938e2274834dbde7915df98fc74368 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jun 2015 08:53:11 +0000
Subject: [PATCH] ASoC: rsnd: gen: add rsnd_force_write()

rsnd_force_write() is similar to rsnd_write(),
but rsnd_force_write() write data to register even though
it is same value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  | 16 ++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 8c7dc51b1c4f..48f704b1d80e 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -103,6 +103,22 @@ void rsnd_write(struct rsnd_priv *priv,
 	regmap_fields_write(gen->regs[reg], rsnd_mod_id(mod), data);
 }
 
+void rsnd_force_write(struct rsnd_priv *priv,
+		      struct rsnd_mod *mod,
+		      enum rsnd_reg reg, u32 data)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_gen *gen = rsnd_priv_to_gen(priv);
+
+	if (!rsnd_is_accessible_reg(priv, gen, reg))
+		return;
+
+	dev_dbg(dev, "w %s[%d] - %4d : %08x\n",
+		rsnd_mod_name(mod), rsnd_mod_id(mod), reg, data);
+
+	regmap_fields_force_write(gen->regs[reg], rsnd_mod_id(mod), data);
+}
+
 void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod,
 	       enum rsnd_reg reg, u32 mask, u32 data)
 {
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 09fcc54a8ee0..f729646e3d18 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -157,12 +157,16 @@ struct rsnd_dai_stream;
 	rsnd_read(rsnd_mod_to_priv(m), m, RSND_REG_##r)
 #define rsnd_mod_write(m, r, d) \
 	rsnd_write(rsnd_mod_to_priv(m), m, RSND_REG_##r, d)
+#define rsnd_mod_force_write(m, r, d) \
+	rsnd_force_write(rsnd_mod_to_priv(m), m, RSND_REG_##r, d)
 #define rsnd_mod_bset(m, r, s, d) \
 	rsnd_bset(rsnd_mod_to_priv(m), m, RSND_REG_##r, s, d)
 
 u32 rsnd_read(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg);
 void rsnd_write(struct rsnd_priv *priv, struct rsnd_mod *mod,
 		enum rsnd_reg reg, u32 data);
+void rsnd_force_write(struct rsnd_priv *priv, struct rsnd_mod *mod,
+		enum rsnd_reg reg, u32 data);
 void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 		    u32 mask, u32 data);
 u32 rsnd_get_adinr(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
-- 
2.1.4
