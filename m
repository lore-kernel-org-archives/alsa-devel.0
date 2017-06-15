From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_adg_clk_query()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:27 +0100
Message-ID: <E1dLYRX-0001ce-3E@debutante>
References: <87k24em656.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k24em656.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_adg_clk_query()

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

>From 1dfdc6501a4a140cfbfc6be8dbb1da3a6f726c15 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:49:43 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_adg_clk_query()

Current Renesas sound driver is assuming that all Sampling rate and
channles are possible to use, but these are depends on inputed clock
and SSI connection situation.
For example, if it is using 1 SSI, enabled TDM mode and has 12288000
input clock, 2ch output can support until 192000Hz, but 6ch output can
support until 64000Hz, 8ch can support 48000Hz.
To control these situation correctly, it needs to support
hw_constraints / refine feature.

To support such feature, it needs SSI clock query feature, and it needs
ADG clock query feature. Current ADG has rsnd_adg_ssi_clk_try_start()
and it is doing similar things, but it try to setup ADG register in
same time. This is not needed.

This patch adds new rsnd_adg_clk_query() and separates query feature
and register setting feature in adg.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  | 53 ++++++++++++++++++++++++------------------------
 sound/soc/sh/rcar/rsnd.h |  1 +
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 4a72fd74ddc2..197cb3ec075f 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -308,23 +308,12 @@ static void rsnd_adg_set_ssi_clk(struct rsnd_mod *ssi_mod, u32 val)
 	}
 }
 
-int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod)
-{
-	rsnd_adg_set_ssi_clk(ssi_mod, 0);
-
-	return 0;
-}
-
-int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
+int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate)
 {
-	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	struct clk *clk;
 	int i;
-	u32 data;
-	u32 ckr = 0;
 	int sel_table[] = {
 		[CLKA] = 0x1,
 		[CLKB] = 0x2,
@@ -338,30 +327,42 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 	 * find suitable clock from
 	 * AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC/AUDIO_CLKI.
 	 */
-	data = 0;
 	for_each_rsnd_clk(clk, adg, i) {
-		if (rate == clk_get_rate(clk)) {
-			data = sel_table[i];
-			goto found_clock;
-		}
+		if (rate == clk_get_rate(clk))
+			return sel_table[i];
 	}
 
 	/*
 	 * find divided clock from BRGA/BRGB
 	 */
-	if (rate  == adg->rbga_rate_for_441khz) {
-		data = 0x10;
-		goto found_clock;
-	}
+	if (rate == adg->rbga_rate_for_441khz)
+		return 0x10;
 
-	if (rate == adg->rbgb_rate_for_48khz) {
-		data = 0x20;
-		goto found_clock;
-	}
+	if (rate == adg->rbgb_rate_for_48khz)
+		return 0x20;
 
 	return -EIO;
+}
+
+int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod)
+{
+	rsnd_adg_set_ssi_clk(ssi_mod, 0);
+
+	return 0;
+}
+
+int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
+{
+	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
+	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
+	int data;
+	u32 ckr = 0;
 
-found_clock:
+	data = rsnd_adg_clk_query(priv, rate);
+	if (data < 0)
+		return data;
 
 	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 47162bdf1abc..7b76f3998fd7 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -502,6 +502,7 @@ phys_addr_t rsnd_gen_get_phy_addr(struct rsnd_priv *priv, int reg_id);
 /*
  *	R-Car ADG
  */
+int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate);
 int rsnd_adg_ssi_clk_stop(struct rsnd_mod *mod);
 int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *mod, unsigned int rate);
 int rsnd_adg_probe(struct rsnd_priv *priv);
-- 
2.11.0
