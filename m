From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Remove CLK_IS_ROOT" to the asoc tree
Date: Wed, 20 Apr 2016 17:19:53 +0100
Message-ID: <E1asur3-0006yv-7K@debutante>
References: <1461114480-12695-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461114480-12695-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgKuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Remove CLK_IS_ROOT

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

>From 2ebdf684082fa9ad924df1b2f80653920c7ca097 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 19 Apr 2016 18:08:00 -0700
Subject: [PATCH] ASoC: rsnd: Remove CLK_IS_ROOT

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 606399de684d..49354d17ea55 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -492,9 +492,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	 */
 	if (!count) {
 		clk = clk_register_fixed_rate(dev, clkout_name[CLKOUT],
-					      parent_clk_name,
-					      (parent_clk_name) ?
-					      0 : CLK_IS_ROOT, req_rate);
+					      parent_clk_name, 0, req_rate);
 		if (!IS_ERR(clk)) {
 			adg->clkout[CLKOUT] = clk;
 			of_clk_add_provider(np, of_clk_src_simple_get, clk);
@@ -506,9 +504,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	else {
 		for (i = 0; i < CLKOUTMAX; i++) {
 			clk = clk_register_fixed_rate(dev, clkout_name[i],
-						      parent_clk_name,
-						      (parent_clk_name) ?
-						      0 : CLK_IS_ROOT,
+						      parent_clk_name, 0,
 						      req_rate);
 			if (!IS_ERR(clk)) {
 				adg->onecell.clks	= adg->clkout;
-- 
2.8.0.rc3
