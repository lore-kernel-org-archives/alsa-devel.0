From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 4/7] clk: renesas: r8a77995: Add ADG clock
Date: Wed, 5 Dec 2018 16:48:16 +0900
Message-ID: <20181205074819.27944-5-jiada_wang@mentor.com>
References: <20181205074819.27944-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205074819.27944-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, vladimir_zapolskiy@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds ADG clock to the R8A77995 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index 47e60e3dbe05..933084d896e3 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -165,6 +165,7 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
 	DEF_MOD("can-fd",		 914,	R8A77995_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A77995_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A77995_CLK_S3D4),
+	DEF_MOD("adg",			 922,   R8A77995_CLK_ZA8),
 	DEF_MOD("i2c3",			 928,	R8A77995_CLK_S3D2),
 	DEF_MOD("i2c2",			 929,	R8A77995_CLK_S3D2),
 	DEF_MOD("i2c1",			 930,	R8A77995_CLK_S3D2),
-- 
2.19.2
