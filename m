From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] ASoC: rsnd: drop useles self-assignments
Date: Mon, 20 Feb 2017 21:58:34 +0100
Message-ID: <20170220205858.10799-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Coverity reported (CID 1397992) this self-assignment. I think the code
stays readable even with the assignments removed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/sh/rcar/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 47b370cb2d3b3a..24adb3cc17aa63 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -674,12 +674,10 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	/* set clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_IF:
-		rdai->bit_clk_inv =  rdai->bit_clk_inv;
 		rdai->frm_clk_inv = !rdai->frm_clk_inv;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		rdai->bit_clk_inv = !rdai->bit_clk_inv;
-		rdai->frm_clk_inv =  rdai->frm_clk_inv;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		rdai->bit_clk_inv = !rdai->bit_clk_inv;
-- 
2.11.0
