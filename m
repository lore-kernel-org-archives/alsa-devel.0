From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: fixup of_clk_add_provider() usage for multi clkout" to the asoc tree
Date: Thu, 30 Mar 2017 22:23:03 +0100
Message-ID: <E1cthX5-0008Ae-Jb@debutante>
References: <87o9wjedvz.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87o9wjedvz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: fixup of_clk_add_provider() usage for multi clkout

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

>From d7f298197a22f11b38059f257842dac7c30a564c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Mar 2017 01:49:06 +0000
Subject: [PATCH] ASoC: rcar: fixup of_clk_add_provider() usage for multi
 clkout

Current adg is calling of_clk_add_povider() multiple times,
but it is not correct usage. This patch fixup its parameter
and call it once.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 85a33ac0a5c4..56107454bdb3 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -537,16 +537,14 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 			clk = clk_register_fixed_rate(dev, clkout_name[i],
 						      parent_clk_name, 0,
 						      req_rate);
-			if (!IS_ERR(clk)) {
-				adg->onecell.clks	= adg->clkout;
-				adg->onecell.clk_num	= CLKOUTMAX;
-
+			adg->clkout[i] = ERR_PTR(-ENOENT);
+			if (!IS_ERR(clk))
 				adg->clkout[i] = clk;
-
-				of_clk_add_provider(np, of_clk_src_onecell_get,
-						    &adg->onecell);
-			}
 		}
+		adg->onecell.clks	= adg->clkout;
+		adg->onecell.clk_num	= CLKOUTMAX;
+		of_clk_add_provider(np, of_clk_src_onecell_get,
+				    &adg->onecell);
 	}
 
 	adg->ckr = ckr;
-- 
2.11.0
