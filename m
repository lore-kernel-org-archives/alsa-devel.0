From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Remove support for 32KHz PLL
	mode" to the asoc tree
Date: Wed, 23 Dec 2015 00:12:15 +0000
Message-ID: <E1aBX2N-0008LX-HL@debutante>
References: <1ab0fbcc6456d5ee428e5390b7ff756695b5c33c.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48655266518
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:12:22 +0100 (CET)
In-Reply-To: <1ab0fbcc6456d5ee428e5390b7ff756695b5c33c.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Remove support for 32KHz PLL mode

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

>From 501f72e9c5205b9d70d5d61e9b186ae7ba873f73 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 Dec 2015 18:27:56 +0000
Subject: [PATCH] ASoC: da7219: Remove support for 32KHz PLL mode

PLL mode based on 32KHz master clock not supported in
AB silicon so remove support from the driver.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 10 ++--------
 sound/soc/codecs/da7219.h |  2 --
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 371768092e17..c6d3b32bb4ae 100644
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
index 2b3f4471a17f..5a787e738084 100644
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
2.6.2
