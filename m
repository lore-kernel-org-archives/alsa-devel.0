From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: fix invalid configuration in
	Pre-Scalar of FLL
Date: Tue, 20 Dec 2016 12:03:09 +0800
Message-ID: <1482206589-28996-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E983266DD5
 for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2016 05:03:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The clk_ref_div is not configured in the correct position of the
register. The patch fixes that clk_ref_div, Pre-Scalar, is assigned
the wrong value. 

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 3 ++-
 sound/soc/codecs/nau8825.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index f69f738..e4fb017 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2078,7 +2078,8 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
 			NAU8825_FLL_INTEGER_MASK, fll_param->fll_int);
 	/* FLL pre-scaler */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL4,
-			NAU8825_FLL_REF_DIV_MASK, fll_param->clk_ref_div);
+			NAU8825_FLL_REF_DIV_MASK,
+			fll_param->clk_ref_div << NAU8825_FLL_REF_DIV_SFT);
 	/* select divided VCO input */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
 		NAU8825_FLL_CLK_SW_MASK, NAU8825_FLL_CLK_SW_REF);
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index fa571ec..5732ce1 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -137,7 +137,8 @@
 #define NAU8825_FLL_CLK_SRC_FS			(0x3 << NAU8825_FLL_CLK_SRC_SFT)
 
 /* FLL4 (0x07) */
-#define NAU8825_FLL_REF_DIV_MASK		(0x3 << 10)
+#define NAU8825_FLL_REF_DIV_SFT	10
+#define NAU8825_FLL_REF_DIV_MASK	(0x3 << NAU8825_FLL_REF_DIV_SFT)
 
 /* FLL5 (0x08) */
 #define NAU8825_FLL_PDB_DAC_EN		(0x1 << 15)
-- 
2.6.4
