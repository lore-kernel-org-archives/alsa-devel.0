From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: support different clock source
	for FLL function" to the asoc tree
Date: Tue, 15 Mar 2016 09:29:00 +0000
Message-ID: <E1aflHg-0005SC-JD@debutante>
References: <1458014901-28049-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1FB62612AD
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:29:26 +0100 (CET)
In-Reply-To: <1458014901-28049-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: support different clock source for FLL function

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

>From ac61ae979d92cb99c18c938f5854179ed54d111a Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 15 Mar 2016 12:08:21 +0800
Subject: [PATCH] ASoC: nau8825: support different clock source for FLL
 function

Extend FLL clock source selection. The source can be from MCLK, BCLK or FS.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 82 +++++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/nau8825.h |  8 +++++
 2 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 1c8729984c2b..ac264ec3d15e 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1053,6 +1053,37 @@ static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 	return 0;
 }
 
+static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
+{
+	int ret = 0;
+
+	nau8825->mclk = devm_clk_get(nau8825->dev, "mclk");
+	if (IS_ERR(nau8825->mclk)) {
+		dev_info(nau8825->dev, "No 'mclk' clock found, assume MCLK is managed externally");
+		return 0;
+	}
+
+	if (!nau8825->mclk_freq) {
+		ret = clk_prepare_enable(nau8825->mclk);
+		if (ret) {
+			dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
+			return ret;
+		}
+	}
+
+	if (nau8825->mclk_freq != freq) {
+		freq = clk_round_rate(nau8825->mclk, freq);
+		ret = clk_set_rate(nau8825->mclk, freq);
+		if (ret) {
+			dev_err(nau8825->dev, "Unable to set mclk rate\n");
+			return ret;
+		}
+		nau8825->mclk_freq = freq;
+	}
+
+	return 0;
+}
+
 static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 	unsigned int freq)
 {
@@ -1064,29 +1095,9 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
 		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
-
-		/* We selected MCLK source but the clock itself managed externally */
-		if (!nau8825->mclk)
-			break;
-
-		if (!nau8825->mclk_freq) {
-			ret = clk_prepare_enable(nau8825->mclk);
-			if (ret) {
-				dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
-				return ret;
-			}
-		}
-
-		if (nau8825->mclk_freq != freq) {
-			nau8825->mclk_freq = freq;
-
-			freq = clk_round_rate(nau8825->mclk, freq);
-			ret = clk_set_rate(nau8825->mclk, freq);
-			if (ret) {
-				dev_err(nau8825->dev, "Unable to set mclk rate\n");
-				return ret;
-			}
-		}
+		ret = nau8825_mclk_prepare(nau8825, freq);
+		if (ret)
+			return ret;
 
 		break;
 	case NAU8825_CLK_INTERNAL:
@@ -1094,7 +1105,32 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 			NAU8825_DCO_EN);
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+		if (nau8825->mclk_freq) {
+			clk_disable_unprepare(nau8825->mclk);
+			nau8825->mclk_freq = 0;
+		}
 
+		break;
+	case NAU8825_CLK_FLL_MCLK:
+		regmap_update_bits(regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_MCLK);
+		ret = nau8825_mclk_prepare(nau8825, freq);
+		if (ret)
+			return ret;
+
+		break;
+	case NAU8825_CLK_FLL_BLK:
+		regmap_update_bits(regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_BLK);
+		if (nau8825->mclk_freq) {
+			clk_disable_unprepare(nau8825->mclk);
+			nau8825->mclk_freq = 0;
+		}
+
+		break;
+	case NAU8825_CLK_FLL_FS:
+		regmap_update_bits(regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_FS);
 		if (nau8825->mclk_freq) {
 			clk_disable_unprepare(nau8825->mclk);
 			nau8825->mclk_freq = 0;
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 8ceb5f385478..ed0d8f3df65f 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -113,6 +113,11 @@
 
 /* FLL3 (0x06) */
 #define NAU8825_FLL_INTEGER_MASK		(0x3ff << 0)
+#define NAU8825_FLL_CLK_SRC_SFT		10
+#define NAU8825_FLL_CLK_SRC_MASK		(0x3 << NAU8825_FLL_CLK_SRC_SFT)
+#define NAU8825_FLL_CLK_SRC_MCLK		(0 << NAU8825_FLL_CLK_SRC_SFT)
+#define NAU8825_FLL_CLK_SRC_BLK		(0x2 << NAU8825_FLL_CLK_SRC_SFT)
+#define NAU8825_FLL_CLK_SRC_FS			(0x3 << NAU8825_FLL_CLK_SRC_SFT)
 
 /* FLL4 (0x07) */
 #define NAU8825_FLL_REF_DIV_MASK		(0x3 << 10)
@@ -320,6 +325,9 @@
 enum {
 	NAU8825_CLK_MCLK = 0,
 	NAU8825_CLK_INTERNAL,
+	NAU8825_CLK_FLL_MCLK,
+	NAU8825_CLK_FLL_BLK,
+	NAU8825_CLK_FLL_FS,
 };
 
 struct nau8825 {
-- 
2.7.0
