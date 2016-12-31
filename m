From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: fix invalid configuration in
	Pre-Scalar of FLL" to the asoc tree
Date: Sat, 31 Dec 2016 19:18:48 +0000
Message-ID: <E1cNPB2-0003on-US@debutante>
References: <1482206589-28996-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F7E62670BE
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 20:19:00 +0100 (CET)
In-Reply-To: <1482206589-28996-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: fix invalid configuration in Pre-Scalar of FLL

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

>From a1792cda51300e15b03549cccf0b09f3be82e697 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 20 Dec 2016 12:03:09 +0800
Subject: [PATCH] ASoC: nau8825: fix invalid configuration in Pre-Scalar of FLL

The clk_ref_div is not configured in the correct position of the
register. The patch fixes that clk_ref_div, Pre-Scalar, is assigned
the wrong value.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 3 ++-
 sound/soc/codecs/nau8825.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index abf77dd422f4..4576f987a4a5 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2006,7 +2006,8 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
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
index b6b21b312854..514fd13c2f46 100644
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
2.11.0
