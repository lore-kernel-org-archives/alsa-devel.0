From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: control SSICR::EN correctly" to the asoc tree
Date: Tue, 08 Aug 2017 12:06:06 +0100
Message-ID: <E1df2Ks-0004uK-Kl@finisterre>
References: <874ltin959.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <874ltin959.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: control SSICR::EN correctly

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

>From 597b046f0d99b0b0123a715f8c8b1ea881d2bec6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 Aug 2017 01:31:39 +0000
Subject: [PATCH] ASoC: rsnd: control SSICR::EN correctly

In case of SSI0 playback, SSI1 capture, SSI0 might be shared for
clock output if clock master mode.

Current rsnd driver had been assumed that SSI clock contiguous
output which is needed for SSI parent needs SSICR::EN (SSI module
enable) bit.
But, this bit controls data input/output, not for clock.
Clock contiguous output needs SSICR : FORCE, SCKD, SWSD,
and SSIWSR : CONT. Not SSICR : EN.

Because of this wrong assumption, and insufficient control, on current
code, for example, if it starts SSI0(playback) -> SSI1(capture) order,
SSI0 SSICR::EN bit will temporarily be 0.
It causes playback side underrun error. This is bug.
We can reproduce this issue with SSI+SRC (without DVC), and capture
during playback operation.

This patch fixup current (wrong) assumption, and control SSICR::EN bit
correctly.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 46feddd78ee2..c5d5c64152e9 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -72,6 +72,7 @@ struct rsnd_ssi {
 	u32 cr_own;
 	u32 cr_clk;
 	u32 cr_mode;
+	u32 cr_en;
 	u32 wsr;
 	int chan;
 	int rate;
@@ -291,6 +292,16 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * SSI clock will be output contiguously
+	 * by below settings.
+	 * This means, rsnd_ssi_master_clk_start()
+	 * and rsnd_ssi_register_setup() are necessary
+	 * for SSI parent
+	 *
+	 * SSICR  : FORCE, SCKD, SWSD
+	 * SSIWSR : CONT
+	 */
 	ssi->cr_clk = FORCE | SWL_32 | SCKD | SWSD | CKDV(idx);
 	ssi->wsr = CONT;
 	ssi->rate = rate;
@@ -393,7 +404,8 @@ static void rsnd_ssi_register_setup(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, SSIWSR,	ssi->wsr);
 	rsnd_mod_write(mod, SSICR,	ssi->cr_own	|
 					ssi->cr_clk	|
-					ssi->cr_mode); /* without EN */
+					ssi->cr_mode	|
+					ssi->cr_en);
 }
 
 static void rsnd_ssi_pointer_init(struct rsnd_mod *mod,
@@ -544,6 +556,8 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 			  struct rsnd_dai_stream *io,
 			  struct rsnd_priv *priv)
 {
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+
 	if (!rsnd_ssi_is_run_mods(mod, io))
 		return 0;
 
@@ -554,7 +568,19 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_multi_slaves_runtime(io))
 		return 0;
 
-	rsnd_mod_bset(mod, SSICR, EN, EN);
+	/*
+	 * EN is for data output.
+	 * SSI parent EN is not needed.
+	 */
+	if (rsnd_ssi_is_parent(mod, io))
+		return 0;
+
+	ssi->cr_en = EN;
+
+	rsnd_mod_write(mod, SSICR,	ssi->cr_own	|
+					ssi->cr_clk	|
+					ssi->cr_mode	|
+					ssi->cr_en);
 
 	return 0;
 }
@@ -569,13 +595,7 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	if (!rsnd_ssi_is_run_mods(mod, io))
 		return 0;
 
-	/*
-	 * don't stop if not last user
-	 * see also
-	 *	rsnd_ssi_start
-	 *	rsnd_ssi_interrupt
-	 */
-	if (ssi->usrcnt > 1)
+	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
 	/*
@@ -595,6 +615,8 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	rsnd_mod_write(mod, SSICR, cr);	/* disabled all */
 	rsnd_ssi_status_check(mod, IIRQ);
 
+	ssi->cr_en = 0;
+
 	return 0;
 }
 
-- 
2.13.2
