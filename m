From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 5/7] clk: renesas: r8a77965: Add ADG clock
Date: Wed, 5 Dec 2018 16:49:19 +0900
Message-ID: <20181205074919.28038-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, vladimir_zapolskiy@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds ADG clock to the R8A77965 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 1fcc411502da..3ce8b0b31647 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -211,6 +211,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("can-if0",		916,	R8A77965_CLK_S3D4),
 	DEF_MOD("i2c6",			918,	R8A77965_CLK_S0D6),
 	DEF_MOD("i2c5",			919,	R8A77965_CLK_S0D6),
+	DEF_MOD("adg",			922,	R8A77965_CLK_S0D1),
 	DEF_MOD("i2c-dvfs",		926,	R8A77965_CLK_CP),
 	DEF_MOD("i2c4",			927,	R8A77965_CLK_S0D6),
 	DEF_MOD("i2c3",			928,	R8A77965_CLK_S0D6),
-- 
2.19.2
