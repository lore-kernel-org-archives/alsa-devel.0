From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_ssi_clk_query()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:15 +0100
Message-ID: <E1dLYRL-0001bP-Cq@debutante>
References: <87injym64o.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87injym64o.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_ssi_clk_query()

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

>From ef4cf5d6a143e04e149ad81fc491fe10855544fe Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:50:02 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_ssi_clk_query()

Current Renesas sound driver is assuming that all Sampling rate and
channles are possible to use, but these are depends on inputed clock
and SSI connection situation.
For example, if it is using 1 SSI, enabled TDM mode and has 12288000
input clock, 2ch output can support until 192000Hz, but 6ch output can
support until 64000Hz, 8ch can support 48000Hz.
To control these situation correctly, it needs to support
hw_constraints / refine feature.

To support such feature, this patch adds new rsnd_ssi_clk_query().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h |  2 +
 sound/soc/sh/rcar/ssi.c  | 95 ++++++++++++++++++++++++++++--------------------
 2 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 7b76f3998fd7..3aa07a07bbcb 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -679,6 +679,8 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 void rsnd_parse_connect_ssi(struct rsnd_dai *rdai,
 			    struct device_node *playback,
 			    struct device_node *capture);
+int rsnd_ssi_clk_query(struct rsnd_priv *priv,
+		       int param1, int param2, int *idx);
 
 /*
  *	R-Car SSIU
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 6450095eb547..c8956c3484dd 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -208,6 +208,46 @@ u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
 	return 0;
 }
 
+int rsnd_ssi_clk_query(struct rsnd_priv *priv,
+		       int param1, int param2, int *idx)
+{
+	int ssi_clk_mul_table[] = {
+		1, 2, 4, 8, 16, 6, 12,
+	};
+	int j, ret;
+	int main_rate;
+
+	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
+
+		/*
+		 * It will set SSIWSR.CONT here, but SSICR.CKDV = 000
+		 * with it is not allowed. (SSIWSR.WS_MODE with
+		 * SSICR.CKDV = 000 is not allowed either).
+		 * Skip it. See SSICR.CKDV
+		 */
+		if (j == 0)
+			continue;
+
+		/*
+		 * this driver is assuming that
+		 * system word is 32bit x chan
+		 * see rsnd_ssi_init()
+		 */
+		main_rate = 32 * param1 * param2 * ssi_clk_mul_table[j];
+
+		ret = rsnd_adg_clk_query(priv, main_rate);
+		if (ret < 0)
+			continue;
+
+		if (idx)
+			*idx = j;
+
+		return main_rate;
+	}
+
+	return -EINVAL;
+}
+
 static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 				     struct rsnd_dai_stream *io)
 {
@@ -217,10 +257,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 	int chan = rsnd_runtime_channel_for_ssi(io);
-	int j, ret;
-	int ssi_clk_mul_table[] = {
-		1, 2, 4, 8, 16, 6, 12,
-	};
+	int idx, ret;
 	unsigned int main_rate;
 	unsigned int rate = rsnd_io_is_play(io) ?
 		rsnd_src_get_out_rate(priv, io) :
@@ -244,45 +281,25 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 		return 0;
 	}
 
-	/*
-	 * Find best clock, and try to start ADG
-	 */
-	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
-
-		/*
-		 * It will set SSIWSR.CONT here, but SSICR.CKDV = 000
-		 * with it is not allowed. (SSIWSR.WS_MODE with
-		 * SSICR.CKDV = 000 is not allowed either).
-		 * Skip it. See SSICR.CKDV
-		 */
-		if (j == 0)
-			continue;
-
-		/*
-		 * this driver is assuming that
-		 * system word is 32bit x chan
-		 * see rsnd_ssi_init()
-		 */
-		main_rate = rate * 32 * chan * ssi_clk_mul_table[j];
-
-		ret = rsnd_adg_ssi_clk_try_start(mod, main_rate);
-		if (0 == ret) {
-			ssi->cr_clk	= FORCE | SWL_32 |
-				SCKD | SWSD | CKDV(j);
-			ssi->wsr = CONT;
+	main_rate = rsnd_ssi_clk_query(priv, rate, chan, &idx);
+	if (main_rate < 0) {
+		dev_err(dev, "unsupported clock rate\n");
+		return -EIO;
+	}
 
-			ssi->rate = rate;
+	ret = rsnd_adg_ssi_clk_try_start(mod, main_rate);
+	if (ret < 0)
+		return ret;
 
-			dev_dbg(dev, "%s[%d] outputs %u Hz\n",
-				rsnd_mod_name(mod),
-				rsnd_mod_id(mod), rate);
+	ssi->cr_clk = FORCE | SWL_32 | SCKD | SWSD | CKDV(idx);
+	ssi->wsr = CONT;
+	ssi->rate = rate;
 
-			return 0;
-		}
-	}
+	dev_dbg(dev, "%s[%d] outputs %u Hz\n",
+		rsnd_mod_name(mod),
+		rsnd_mod_id(mod), rate);
 
-	dev_err(dev, "unsupported clock rate\n");
-	return -EIO;
+	return 0;
 }
 
 static void rsnd_ssi_master_clk_stop(struct rsnd_mod *mod,
-- 
2.11.0
