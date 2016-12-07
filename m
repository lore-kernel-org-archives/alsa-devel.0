From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: setup BRGCKR/BRRA/BRRB when
	starting" to the asoc tree
Date: Wed, 07 Dec 2016 15:50:14 +0000
Message-ID: <E1cEeU2-0000m2-Nu@finisterre>
References: <87twag37p4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF3B266499
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 16:50:30 +0100 (CET)
In-Reply-To: <87twag37p4.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Gaku Inami <gaku.inami.xw@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: setup BRGCKR/BRRA/BRRB when starting

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

>From b99258a3151a70da9b4125f940c4dcc091df84c1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Dec 2016 00:28:11 +0000
Subject: [PATCH] ASoC: rsnd: setup BRGCKR/BRRA/BRRB when starting

Current rsnd driver setups BRGCKR/BRRA/BRRB when .probe timing.
But it breaks sound after Suspend/Resume. These should be setups
every start timing.
This patch is tested on R-Car Gen3 Salvator-X board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 54b28fd502ef..85a33ac0a5c4 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -34,6 +34,9 @@ struct rsnd_adg {
 	struct clk_onecell_data onecell;
 	struct rsnd_mod mod;
 	u32 flags;
+	u32 ckr;
+	u32 rbga;
+	u32 rbgb;
 
 	int rbga_rate_for_441khz; /* RBGA */
 	int rbgb_rate_for_48khz;  /* RBGB */
@@ -316,9 +319,11 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	struct clk *clk;
 	int i;
 	u32 data;
+	u32 ckr = 0;
 	int sel_table[] = {
 		[CLKA] = 0x1,
 		[CLKB] = 0x2,
@@ -360,15 +365,14 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
 	if (!(adg_mode_flags(adg) & LRCLK_ASYNC)) {
-		struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
-		u32 ckr = 0;
-
 		if (0 == (rate % 8000))
 			ckr = 0x80000000;
-
-		rsnd_mod_bset(adg_mod, BRGCKR, 0x80000000, ckr);
 	}
 
+	rsnd_mod_bset(adg_mod, BRGCKR, 0x80FF0000, adg->ckr | ckr);
+	rsnd_mod_write(adg_mod, BRRA,  adg->rbga);
+	rsnd_mod_write(adg_mod, BRRB,  adg->rbgb);
+
 	dev_dbg(dev, "ADG: %s[%d] selects 0x%x for %d\n",
 		rsnd_mod_name(ssi_mod), rsnd_mod_id(ssi_mod),
 		data, rate);
@@ -421,7 +425,6 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 				struct rsnd_adg *adg)
 {
 	struct clk *clk;
-	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
 	u32 ckr, rbgx, rbga, rbgb;
@@ -546,9 +549,9 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 		}
 	}
 
-	rsnd_mod_bset(adg_mod, BRGCKR, 0x80FF0000, ckr);
-	rsnd_mod_write(adg_mod, BRRA,  rbga);
-	rsnd_mod_write(adg_mod, BRRB,  rbgb);
+	adg->ckr = ckr;
+	adg->rbga = rbga;
+	adg->rbgb = rbgb;
 
 	for_each_rsnd_clkout(clk, adg, i)
 		dev_dbg(dev, "clkout %d : %p : %ld\n", i, clk, clk_get_rate(clk));
-- 
2.10.2
