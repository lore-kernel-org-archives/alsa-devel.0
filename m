From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing SRC_O_BUSIF_MODE
	register" to the asoc tree
Date: Tue, 01 Dec 2015 23:00:02 +0000
Message-ID: <E1a3tty-0007AW-53@debutante>
References: <878u5fub4u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB1D626627F
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 00:00:06 +0100 (CET)
In-Reply-To: <878u5fub4u.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add missing SRC_O_BUSIF_MODE register

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

>From bf4e8d7c371ae0d7acc1872a153c2f980f5523fe Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:50:08 +0000
Subject: [PATCH] ASoC: rsnd: add missing SRC_O_BUSIF_MODE register

SRC_BUSIF_MODE has both IN/OUT register. Current src driver sets
IN register only. This patch sets missing OUT register.
IN/OUT register are using default setting, so, there is no
HW effect.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  | 4 +++-
 sound/soc/sh/rcar/rsnd.h | 3 ++-
 sound/soc/sh/rcar/src.c  | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 15d770662482..364708c73418 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -233,8 +233,10 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_CTRL,	0x10,	0x80),
 		RSND_GEN_M_REG(SSI_INT_ENABLE,	0x18,	0x80),
 	};
+
 	const static struct rsnd_regmap_field_conf conf_scu[] = {
-		RSND_GEN_M_REG(SRC_BUSIF_MODE,	0x0,	0x20),
+		RSND_GEN_M_REG(SRC_I_BUSIF_MODE,0x0,	0x20),
+		RSND_GEN_M_REG(SRC_O_BUSIF_MODE,0x4,	0x20),
 		RSND_GEN_M_REG(SRC_BUSIF_DALIGN,0x8,	0x20),
 		RSND_GEN_M_REG(SRC_ROUTE_MODE0,	0xc,	0x20),
 		RSND_GEN_M_REG(SRC_CTRL,	0x10,	0x20),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 42d2ac5cb0d1..bb2c29cdc892 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -51,7 +51,8 @@ enum rsnd_reg {
 	RSND_REG_SSI_BUSIF_ADINR,	/* Gen2 only */
 	RSND_REG_SSI_BUSIF_DALIGN,	/* Gen2 only */
 	RSND_REG_SSI_INT_ENABLE,	/* Gen2 only */
-	RSND_REG_SRC_BUSIF_MODE,
+	RSND_REG_SRC_I_BUSIF_MODE,
+	RSND_REG_SRC_O_BUSIF_MODE,
 	RSND_REG_SRC_ROUTE_MODE0,
 	RSND_REG_SRC_SWRSR,
 	RSND_REG_SRC_SRCIR,
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 30cad79deab0..27b3ffe8c9a0 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -254,7 +254,8 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_SRCIR, 0);	/* cancel initialize */
 
 	rsnd_mod_write(mod, SRC_ROUTE_MODE0, route);
-	rsnd_mod_write(mod, SRC_BUSIF_MODE, 1);
+	rsnd_mod_write(mod, SRC_I_BUSIF_MODE, 1);
+	rsnd_mod_write(mod, SRC_O_BUSIF_MODE, 1);
 	rsnd_mod_write(mod, SRC_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
 
 	if (convert_rate)
-- 
2.6.2
