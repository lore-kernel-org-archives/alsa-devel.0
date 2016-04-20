From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] ASoC: rsnd: Remove CLK_IS_ROOT
Date: Tue, 19 Apr 2016 18:08:00 -0700
Message-ID: <1461114480-12695-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
