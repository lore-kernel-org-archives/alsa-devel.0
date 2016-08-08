From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7218: Remove 32KHz PLL mode from driver
Date: Mon, 8 Aug 2016 15:35:23 +0100
Message-ID: <ca4027f23045654e22aa1067e91e58c6f8385d13.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Functionality has been removed in latest silicon variants. This
patch removes the feature from the driver to align.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7218.c | 12 +++---------
 sound/soc/codecs/da7218.h |  2 --
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 99ce23e..f443519 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1819,7 +1819,7 @@ static int da7218_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if (da7218->mclk_rate == freq)
 		return 0;
 
-	if (((freq < 2000000) && (freq != 32768)) || (freq > 54000000)) {
+	if ((freq < 2000000) || (freq > 54000000)) {
 		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
@@ -1866,11 +1866,8 @@ static int da7218_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	u32 freq_ref;
 	u64 frac_div;
 
-	/* Verify 32KHz, 2MHz - 54MHz MCLK provided, and set input divider */
-	if (da7218->mclk_rate == 32768) {
-		indiv_bits = DA7218_PLL_INDIV_9_TO_18_MHZ;
-		indiv = DA7218_PLL_INDIV_9_TO_18_MHZ_VAL;
-	} else if (da7218->mclk_rate < 2000000) {
+	/* Verify 2MHz - 54MHz MCLK provided, and set input divider */
+	if (da7218->mclk_rate < 2000000) {
 		dev_err(codec->dev, "PLL input clock %d below valid range\n",
 			da7218->mclk_rate);
 		return -EINVAL;
@@ -1911,9 +1908,6 @@ static int da7218_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	case DA7218_SYSCLK_PLL_SRM:
 		pll_ctrl |= DA7218_PLL_MODE_SRM;
 		break;
-	case DA7218_SYSCLK_PLL_32KHZ:
-		pll_ctrl |= DA7218_PLL_MODE_32KHZ;
-		break;
 	default:
 		dev_err(codec->dev, "Invalid PLL config\n");
 		return -EINVAL;
diff --git a/sound/soc/codecs/da7218.h b/sound/soc/codecs/da7218.h
index 477cd37..4f7ec21 100644
--- a/sound/soc/codecs/da7218.h
+++ b/sound/soc/codecs/da7218.h
@@ -888,7 +888,6 @@
 #define DA7218_PLL_MODE_BYPASS		(0x0 << 6)
 #define DA7218_PLL_MODE_NORMAL		(0x1 << 6)
 #define DA7218_PLL_MODE_SRM		(0x2 << 6)
-#define DA7218_PLL_MODE_32KHZ		(0x3 << 6)
 
 /* DA7218_PLL_FRAC_TOP = 0x92 */
 #define DA7218_PLL_FBDIV_FRAC_TOP_SHIFT	0
@@ -1371,7 +1370,6 @@ enum da7218_sys_clk {
 	DA7218_SYSCLK_MCLK = 0,
 	DA7218_SYSCLK_PLL,
 	DA7218_SYSCLK_PLL_SRM,
-	DA7218_SYSCLK_PLL_32KHZ
 };
 
 enum da7218_dev_id {
-- 
1.9.3
