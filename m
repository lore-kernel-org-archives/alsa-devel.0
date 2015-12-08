From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup data align position for
	capture" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:31 +0000
Message-ID: <E1a6Nff-00046P-ES@debutante>
References: <87h9jt5wpb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5DC2604A4
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:36 +0100 (CET)
In-Reply-To: <87h9jt5wpb.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup data align position for capture

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

>From a504b1ee417ffd1e3c272b4594213edf14af3ef1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 Dec 2015 05:38:23 +0000
Subject: [PATCH] ASoC: rsnd: tidyup data align position for capture

L/R channel data has been treated as inverted on R-Car sound 16bit mode,
Thus, 4689032b1("ASoC: rsnd: tidyup data align position") tidyuped data
align position. But it couldn't care about capture case. This patch
cares both playback/capture

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c  |  1 +
 sound/soc/sh/rcar/core.c | 13 +++++++++++--
 sound/soc/sh/rcar/gen.c  |  1 +
 sound/soc/sh/rcar/rsnd.h |  2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index ab904c3f20b5..cd1f064e63c4 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -80,6 +80,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
+	rsnd_mod_write(mod, CMD_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
 
 	rsnd_adg_set_cmd_timsel_gen2(mod, io);
 
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f1d7af114a31..849c1ad93df2 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -272,13 +272,22 @@ u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
  */
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
-	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 	struct rsnd_mod *ssi = rsnd_io_to_mod_ssi(io);
-	struct rsnd_mod *target = src ? src : ssi;
+	struct rsnd_mod *target;
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	u32 val = 0x76543210;
 	u32 mask = ~0;
 
+	if (rsnd_io_is_play(io)) {
+		struct rsnd_mod *src = rsnd_io_to_mod_src(io);
+
+		target = src ? src : ssi;
+	} else {
+		struct rsnd_mod *cmd = rsnd_io_to_mod_cmd(io);
+
+		target = cmd ? cmd : ssi;
+	}
+
 	mask <<= runtime->channels * 4;
 	val = val & mask;
 
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 50fc73042b7e..7c5485e46fd7 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -242,6 +242,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SRC_ROUTE_MODE0,	0xc,	0x20),
 		RSND_GEN_M_REG(SRC_CTRL,	0x10,	0x20),
 		RSND_GEN_M_REG(SRC_INT_ENABLE0,	0x18,	0x20),
+		RSND_GEN_M_REG(CMD_BUSIF_DALIGN,0x188,	0x20),
 		RSND_GEN_M_REG(CMD_ROUTE_SLCT,	0x18c,	0x20),
 		RSND_GEN_M_REG(CMD_CTRL,	0x190,	0x20),
 		RSND_GEN_S_REG(SCU_SYS_STATUS0,	0x1c8),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 970e1301f7c6..ad854d6719ea 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -81,6 +81,7 @@ enum rsnd_reg {
 	RSND_REG_SCU_SYS_INT_EN0,
 	RSND_REG_SCU_SYS_INT_EN1,	/* Gen2 only */
 	RSND_REG_CMD_CTRL,		/* Gen2 only */
+	RSND_REG_CMD_BUSIF_DALIGN,	/* Gen2 only */
 	RSND_REG_CMD_ROUTE_SLCT,
 	RSND_REG_CMDOUT_TIMSEL,		/* Gen2 only */
 	RSND_REG_CTU_CTUIR,
@@ -319,6 +320,7 @@ struct rsnd_dai_stream {
 #define rsnd_io_to_mod_ctu(io)	rsnd_io_to_mod((io), RSND_MOD_CTU)
 #define rsnd_io_to_mod_mix(io)	rsnd_io_to_mod((io), RSND_MOD_MIX)
 #define rsnd_io_to_mod_dvc(io)	rsnd_io_to_mod((io), RSND_MOD_DVC)
+#define rsnd_io_to_mod_cmd(io)	rsnd_io_to_mod((io), RSND_MOD_CMD)
 #define rsnd_io_to_rdai(io)	((io)->rdai)
 #define rsnd_io_to_priv(io)	(rsnd_rdai_to_priv(rsnd_io_to_rdai(io)))
 #define rsnd_io_is_play(io)	(&rsnd_io_to_rdai(io)->playback == io)
-- 
2.6.2
