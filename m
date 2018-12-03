From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 3/6] clk: renesas: r8a77990: Add ADG clocks
Date: Mon, 3 Dec 2018 20:21:57 +0900
Message-ID: <20181203112200.18220-4-jiada_wang@mentor.com>
References: <20181203112200.18220-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203112200.18220-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, vladimir_zapolskiy@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds ADG clock to the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index 9eb80180eea0..3bb55037a9e3 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -203,6 +203,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("can-if0",		 916,	R8A77990_CLK_S3D4),
 	DEF_MOD("i2c6",			 918,	R8A77990_CLK_S3D2),
 	DEF_MOD("i2c5",			 919,	R8A77990_CLK_S3D2),
+	DEF_MOD("adg",			 922,	R8A77990_CLK_ZA8),
 	DEF_MOD("i2c-dvfs",		 926,	R8A77990_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A77990_CLK_S3D2),
 	DEF_MOD("i2c3",			 928,	R8A77990_CLK_S3D2),
-- 
2.17.0
