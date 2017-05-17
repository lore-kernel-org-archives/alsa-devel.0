From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove error pointer for adg->clkout[i]" to the asoc tree
Date: Wed, 17 May 2017 10:52:10 +0100
Message-ID: <E1dAvco-0006og-N0@debutante>
References: <87pofaj34y.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87pofaj34y.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove error pointer for adg->clkout[i]

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

>From 1f6bbe64abd7dc1997fa31a9e550eadf170961d5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 May 2017 01:59:22 +0000
Subject: [PATCH] ASoC: rsnd: remove error pointer for adg->clkout[i]

commit d7f298197a22f11b38059f257842dac7c30a564c
("ASoC: rcar: fixup of_clk_add_provider() usage for multi clkout")
added adg->clkout[i] = ERR_PTR(-ENOENT),
but, adg->clkout[i] are assumed NULL or clk pointer.
This patch fix it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index cb4eab0e24ce..36bece8621b7 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -556,7 +556,6 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 			clk = clk_register_fixed_rate(dev, clkout_name[i],
 						      parent_clk_name, 0,
 						      req_rate[0]);
-			adg->clkout[i] = ERR_PTR(-ENOENT);
 			if (!IS_ERR(clk))
 				adg->clkout[i] = clk;
 		}
-- 
2.11.0
