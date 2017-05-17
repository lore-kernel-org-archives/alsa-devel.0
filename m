From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use PDTA bit for 24bit on SSI" to the asoc tree
Date: Wed, 17 May 2017 10:51:23 +0100
Message-ID: <E1dAvc3-0006fK-Fd@debutante>
References: <87a86dy3n6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a86dy3n6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Hirohiko Ito <hirohiko.ito.wx@renesas.com>, Yoshiaki Yamazaki <yoshiaki.yamazaki.jy@renesas.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't use PDTA bit for 24bit on SSI

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

>From 90431eb49bff6d79814cbf0c96e13597ad53095c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 May 2017 01:51:41 +0000
Subject: [PATCH] ASoC: rsnd: don't use PDTA bit for 24bit on SSI

Current SSI uses PDTA bit which indicates data that Input/Output
data are Right-Aligned. But, 24bit sound should be Left-Aligned
in this HW. Because Linux is using Right-Aligned data, and HW uses
Left-Aligned data, current 24bit data is missing lower 8bit.
To fix this issue, this patch removes PDTA bit, and shift 8bit
in necessary module

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c  |  1 +
 sound/soc/sh/rcar/core.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sh/rcar/gen.c  |  1 +
 sound/soc/sh/rcar/rsnd.h |  2 ++
 sound/soc/sh/rcar/src.c  | 12 ++++++++++--
 sound/soc/sh/rcar/ssi.c  |  2 +-
 sound/soc/sh/rcar/ssiu.c |  3 ++-
 7 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 7d92a24b7cfa..d879c010cf03 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -89,6 +89,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
+	rsnd_mod_write(mod, CMD_BUSIF_MODE, rsnd_get_busif_shift(io, mod) | 1);
 	rsnd_mod_write(mod, CMD_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
 
 	rsnd_adg_set_cmd_timsel_gen2(mod, io);
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1744015408c3..8c1f4e2e0c4f 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -343,6 +343,57 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		return 0x76543210;
 }
 
+u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
+{
+	enum rsnd_mod_type playback_mods[] = {
+		RSND_MOD_SRC,
+		RSND_MOD_CMD,
+		RSND_MOD_SSIU,
+	};
+	enum rsnd_mod_type capture_mods[] = {
+		RSND_MOD_CMD,
+		RSND_MOD_SRC,
+		RSND_MOD_SSIU,
+	};
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_mod *tmod = NULL;
+	enum rsnd_mod_type *mods =
+		rsnd_io_is_play(io) ?
+		playback_mods : capture_mods;
+	int i;
+
+	/*
+	 * This is needed for 24bit data
+	 * We need to shift 8bit
+	 *
+	 * Linux 24bit data is located as 0x00******
+	 * HW    24bit data is located as 0x******00
+	 *
+	 */
+	switch (runtime->sample_bits) {
+	case 16:
+		return 0;
+	case 32:
+		break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(playback_mods); i++) {
+		tmod = rsnd_io_to_mod(io, mods[i]);
+		if (tmod)
+			break;
+	}
+
+	if (tmod != mod)
+		return 0;
+
+	if (rsnd_io_is_play(io))
+		return  (0 << 20) | /* shift to Left */
+			(8 << 16);  /* 8bit */
+	else
+		return  (1 << 20) | /* shift to Right */
+			(8 << 16);  /* 8bit */
+}
+
 /*
  *	rsnd_dai functions
  */
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 63b6d3c28021..4b0980728e13 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -236,6 +236,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SRC_ROUTE_MODE0,	0xc,	0x20),
 		RSND_GEN_M_REG(SRC_CTRL,	0x10,	0x20),
 		RSND_GEN_M_REG(SRC_INT_ENABLE0,	0x18,	0x20),
+		RSND_GEN_M_REG(CMD_BUSIF_MODE,	0x184,	0x20),
 		RSND_GEN_M_REG(CMD_BUSIF_DALIGN,0x188,	0x20),
 		RSND_GEN_M_REG(CMD_ROUTE_SLCT,	0x18c,	0x20),
 		RSND_GEN_M_REG(CMD_CTRL,	0x190,	0x20),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index dbf4163427e8..323af41ecfcb 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -73,6 +73,7 @@ enum rsnd_reg {
 	RSND_REG_SCU_SYS_INT_EN0,
 	RSND_REG_SCU_SYS_INT_EN1,
 	RSND_REG_CMD_CTRL,
+	RSND_REG_CMD_BUSIF_MODE,
 	RSND_REG_CMD_BUSIF_DALIGN,
 	RSND_REG_CMD_ROUTE_SLCT,
 	RSND_REG_CMDOUT_TIMSEL,
@@ -204,6 +205,7 @@ void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 		    u32 mask, u32 data);
 u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
+u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
 
 /*
  *	R-Car DMA
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 20b5b2ec625e..76a477a3ccb5 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -190,11 +190,13 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	int is_play = rsnd_io_is_play(io);
 	int use_src = 0;
 	u32 fin, fout;
 	u32 ifscr, fsrate, adinr;
 	u32 cr, route;
 	u32 bsdsr, bsisr;
+	u32 i_busif, o_busif, tmp;
 	uint ratio;
 
 	if (!runtime)
@@ -270,6 +272,11 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 		break;
 	}
 
+	/* BUSIF_MODE */
+	tmp = rsnd_get_busif_shift(io, mod);
+	i_busif = ( is_play ? tmp : 0) | 1;
+	o_busif = (!is_play ? tmp : 0) | 1;
+
 	rsnd_mod_write(mod, SRC_ROUTE_MODE0, route);
 
 	rsnd_mod_write(mod, SRC_SRCIR, 1);	/* initialize */
@@ -281,8 +288,9 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_BSISR, bsisr);
 	rsnd_mod_write(mod, SRC_SRCIR, 0);	/* cancel initialize */
 
-	rsnd_mod_write(mod, SRC_I_BUSIF_MODE, 1);
-	rsnd_mod_write(mod, SRC_O_BUSIF_MODE, 1);
+	rsnd_mod_write(mod, SRC_I_BUSIF_MODE, i_busif);
+	rsnd_mod_write(mod, SRC_O_BUSIF_MODE, o_busif);
+
 	rsnd_mod_write(mod, SRC_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
 
 	rsnd_adg_set_src_timesel_gen2(mod, io, fin, fout);
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 135c5669f796..e43277a5068c 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -302,7 +302,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	 * always use 32bit system word.
 	 * see also rsnd_ssi_master_clk_enable()
 	 */
-	cr_own = FORCE | SWL_32 | PDTA;
+	cr_own = FORCE | SWL_32;
 
 	if (rdai->bit_clk_inv)
 		cr_own |= SCKP;
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 14fafdaf1395..512d238b79e2 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -144,7 +144,8 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 			       (rsnd_io_is_play(io) ?
 				rsnd_runtime_channel_after_ctu(io) :
 				rsnd_runtime_channel_original(io)));
-		rsnd_mod_write(mod, SSI_BUSIF_MODE,  1);
+		rsnd_mod_write(mod, SSI_BUSIF_MODE,
+			       rsnd_get_busif_shift(io, mod) | 1);
 		rsnd_mod_write(mod, SSI_BUSIF_DALIGN,
 			       rsnd_get_dalign(mod, io));
 	}
-- 
2.11.0
