From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 6/6] ASoC: da7219: Remove support for 32KHz PLL mode
Date: Tue, 22 Dec 2015 18:27:56 +0000
Message-ID: <1ab0fbcc6456d5ee428e5390b7ff756695b5c33c.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

PLL mode based on 32KHz master clock not supported in
AB silicon so remove support from the driver.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 10 ++--------
 sound/soc/codecs/da7219.h |  2 --
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c019fef..82a7236 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1074,11 +1074,8 @@ static int da7219_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	u32 freq_ref;
 	u64 frac_div;
 
-	/* Verify 32KHz, 2MHz - 54MHz MCLK provided, and set input divider */
-	if (da7219->mclk_rate == 32768) {
-		indiv_bits = DA7219_PLL_INDIV_2_5_MHZ;
-		indiv = DA7219_PLL_INDIV_2_5_MHZ_VAL;
-	} else if (da7219->mclk_rate < 2000000) {
+	/* Verify 2MHz - 54MHz MCLK provided, and set input divider */
+	if (da7219->mclk_rate < 2000000) {
 		dev_err(codec->dev, "PLL input clock %d below valid range\n",
 			da7219->mclk_rate);
 		return -EINVAL;
@@ -1119,9 +1116,6 @@ static int da7219_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	case DA7219_SYSCLK_PLL_SRM:
 		pll_ctrl |= DA7219_PLL_MODE_SRM;
 		break;
-	case DA7219_SYSCLK_PLL_32KHZ:
-		pll_ctrl |= DA7219_PLL_MODE_32KHZ;
-		break;
 	default:
 		dev_err(codec->dev, "Invalid PLL config\n");
 		return -EINVAL;
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 2b3f447..5a787e7 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -206,7 +206,6 @@
 #define DA7219_PLL_MODE_BYPASS		(0x0 << 6)
 #define DA7219_PLL_MODE_NORMAL		(0x1 << 6)
 #define DA7219_PLL_MODE_SRM		(0x2 << 6)
-#define DA7219_PLL_MODE_32KHZ		(0x3 << 6)
 
 /* DA7219_PLL_FRAC_TOP = 0x22 */
 #define DA7219_PLL_FBDIV_FRAC_TOP_SHIFT	0
@@ -780,7 +779,6 @@ enum da7219_sys_clk {
 	DA7219_SYSCLK_MCLK = 0,
 	DA7219_SYSCLK_PLL,
 	DA7219_SYSCLK_PLL_SRM,
-	DA7219_SYSCLK_PLL_32KHZ
 };
 
 /* Regulators */
-- 
1.9.3
