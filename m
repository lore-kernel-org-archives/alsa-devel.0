From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup mod ID for CTU regmap
	read/write" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:11 +0000 (GMT)
Message-ID: <20181204172712.01B3A11251E3@debutante.sirena.org.uk>
References: <87in093f2p.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10096267B75
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:12 +0100 (CET)
In-Reply-To: <87in093f2p.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup mod ID for CTU regmap read/write

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

>From 665c1ade11e8aee0db691c7a928de1586b712344 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 4 Dec 2018 08:00:47 +0000
Subject: [PATCH] ASoC: rsnd: fixup mod ID for CTU regmap read/write

commit c16015f36cc12824 ("ASoC: rsnd: add .get_id/.get_id_sub")
add new .get_id/.get_id_sub to indicate module ID/subID.
It is used for SSIU and CTU. In SSIU case, subID indicates BUSIF,
but register settings is based on SSIU ID.
OTOH, in CTU case, subID indicates CTU channel, and register settings
is based on it. This means regmap read/write function needs to care it.
This patch fixup this issue. It can't play MIXed sound without this
patch.

Fixes: c16015f36cc12824 ("ASoC: rsnd: add .get_id/.get_id_sub")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c  |  1 +
 sound/soc/sh/rcar/gen.c  | 14 +++++++++++---
 sound/soc/sh/rcar/rsnd.h |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 4dda7d968894..ff41a5ee6092 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -317,6 +317,7 @@ static struct rsnd_mod_ops rsnd_ctu_ops = {
 	.get_status	= rsnd_mod_get_status,
 	.id		= rsnd_ctu_id,
 	.id_sub		= rsnd_ctu_id_sub,
+	.id_cmd		= rsnd_mod_id_raw,
 };
 
 struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index ca639404f2cd..3283d677c937 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -71,6 +71,14 @@ static int rsnd_is_accessible_reg(struct rsnd_priv *priv,
 	return 1;
 }
 
+static int rsnd_mod_id_cmd(struct rsnd_mod *mod)
+{
+	if (mod->ops->id_cmd)
+		return mod->ops->id_cmd(mod);
+
+	return rsnd_mod_id(mod);
+}
+
 u32 rsnd_read(struct rsnd_priv *priv,
 	      struct rsnd_mod *mod, enum rsnd_reg reg)
 {
@@ -81,7 +89,7 @@ u32 rsnd_read(struct rsnd_priv *priv,
 	if (!rsnd_is_accessible_reg(priv, gen, reg))
 		return 0;
 
-	regmap_fields_read(gen->regs[reg], rsnd_mod_id(mod), &val);
+	regmap_fields_read(gen->regs[reg], rsnd_mod_id_cmd(mod), &val);
 
 	dev_dbg(dev, "r %s - %-18s (%4d) : %08x\n",
 		rsnd_mod_name(mod),
@@ -100,7 +108,7 @@ void rsnd_write(struct rsnd_priv *priv,
 	if (!rsnd_is_accessible_reg(priv, gen, reg))
 		return;
 
-	regmap_fields_force_write(gen->regs[reg], rsnd_mod_id(mod), data);
+	regmap_fields_force_write(gen->regs[reg], rsnd_mod_id_cmd(mod), data);
 
 	dev_dbg(dev, "w %s - %-18s (%4d) : %08x\n",
 		rsnd_mod_name(mod),
@@ -117,7 +125,7 @@ void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod,
 		return;
 
 	regmap_fields_force_update_bits(gen->regs[reg],
-					rsnd_mod_id(mod), mask, data);
+					rsnd_mod_id_cmd(mod), mask, data);
 
 	dev_dbg(dev, "b %s - %-18s (%4d) : %08x/%08x\n",
 		rsnd_mod_name(mod),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 3c57129af6d1..94d51fee8999 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -306,6 +306,7 @@ struct rsnd_mod_ops {
 			   enum rsnd_mod_type type);
 	int (*id)(struct rsnd_mod *mod);
 	int (*id_sub)(struct rsnd_mod *mod);
+	int (*id_cmd)(struct rsnd_mod *mod);
 };
 
 struct rsnd_dai_stream;
-- 
2.19.0.rc2
