From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Add support to handle mclk data
	provided to driver" to the asoc tree
Date: Wed, 07 Oct 2015 15:12:05 +0100
Message-ID: <E1ZjpRt-0007TW-DC@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BADE526646C
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:12:22 +0200 (CEST)
In-Reply-To: 
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

   ASoC: da7213: Add support to handle mclk data provided to driver

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

>From 6e7c444318699496e6e6f30c875cf67534aeccc6 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 7 Oct 2015 14:27:11 +0100
Subject: [PATCH] ASoC: da7213: Add support to handle mclk data provided to
 driver

Driver now can make use of mclk data, if provided, to set, enable
and disable the clock source. As part of this, the choice to
enable clock squaring is dealt with as part of dai_sysclk() call
rather than as platform data.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/da7213.h    |  3 ---
 sound/soc/codecs/da7213.c | 67 +++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/da7213.h |  8 ++++--
 3 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/include/sound/da7213.h b/include/sound/da7213.h
index 673f5c3..e7eac89 100644
--- a/include/sound/da7213.h
+++ b/include/sound/da7213.h
@@ -44,9 +44,6 @@ struct da7213_platform_data {
 	enum da7213_dmic_data_sel dmic_data_sel;
 	enum da7213_dmic_samplephase dmic_samplephase;
 	enum da7213_dmic_clk_rate dmic_clk_rate;
-
-	/* MCLK squaring config */
-	bool mclk_squaring;
 };
 
 #endif /* _DA7213_PDATA_H */
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index ab1486b..7278f93 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -12,6 +12,7 @@
  * option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -1222,23 +1223,44 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	if ((da7213->clk_src == clk_id) && (da7213->mclk_rate == freq))
+		return 0;
+
+	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
+		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
+			freq);
+		return -EINVAL;
+	}
 
 	switch (clk_id) {
 	case DA7213_CLKSRC_MCLK:
-		if ((freq == 32768) ||
-		    ((freq >= 5000000) && (freq <= 54000000))) {
-			da7213->mclk_rate = freq;
-			return 0;
-		} else {
-			dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
-				freq);
-			return -EINVAL;
-		}
+		da7213->mclk_squarer_en = false;
+		break;
+	case DA7213_CLKSRC_MCLK_SQR:
+		da7213->mclk_squarer_en = true;
 		break;
 	default:
 		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
 		return -EINVAL;
 	}
+
+	da7213->clk_src = clk_id;
+
+	if (da7213->mclk) {
+		freq = clk_round_rate(da7213->mclk, freq);
+		ret = clk_set_rate(da7213->mclk, freq);
+		if (ret) {
+			dev_err(codec_dai->dev, "Failed to set clock rate %d\n",
+				freq);
+			return ret;
+		}
+	}
+
+	da7213->mclk_rate = freq;
+
+	return 0;
 }
 
 /* Supported PLL input frequencies are 5MHz - 54MHz. */
@@ -1366,12 +1388,25 @@ static struct snd_soc_dai_driver da7213_dai = {
 static int da7213_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			/* MCLK */
+			if (da7213->mclk) {
+				ret = clk_prepare_enable(da7213->mclk);
+				if (ret) {
+					dev_err(codec->dev,
+						"Failed to enable mclk\n");
+					return ret;
+				}
+			}
+
 			/* Enable VMID reference & master bias */
 			snd_soc_update_bits(codec, DA7213_REFERENCES,
 					    DA7213_VMID_EN | DA7213_BIAS_EN,
@@ -1382,6 +1417,10 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 		/* Disable VMID reference & master bias */
 		snd_soc_update_bits(codec, DA7213_REFERENCES,
 				    DA7213_VMID_EN | DA7213_BIAS_EN, 0);
+
+		/* MCLK */
+		if (da7213->mclk)
+			clk_disable_unprepare(da7213->mclk);
 		break;
 	}
 	return 0;
@@ -1618,9 +1657,15 @@ static int da7213_probe(struct snd_soc_codec *codec)
 				    DA7213_DMIC_DATA_SEL_MASK |
 				    DA7213_DMIC_SAMPLEPHASE_MASK |
 				    DA7213_DMIC_CLK_RATE_MASK, dmic_cfg);
+	}
 
-		/* Set MCLK squaring */
-		da7213->mclk_squarer_en = pdata->mclk_squaring;
+	/* Check if MCLK provided */
+	da7213->mclk = devm_clk_get(codec->dev, "mclk");
+	if (IS_ERR(da7213->mclk)) {
+		if (PTR_ERR(da7213->mclk) != -ENOENT)
+			return PTR_ERR(da7213->mclk);
+		else
+			da7213->mclk = NULL;
 	}
 
 	return 0;
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 9cb9ddd..030fd69 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -13,6 +13,7 @@
 #ifndef _DA7213_H
 #define _DA7213_H
 
+#include <linux/clk.h>
 #include <linux/regmap.h>
 #include <sound/da7213.h>
 
@@ -504,14 +505,17 @@
 #define DA7213_PLL_INDIV_20_40_MHZ_VAL	8
 #define DA7213_PLL_INDIV_40_54_MHZ_VAL	16
 
-enum clk_src {
-	DA7213_CLKSRC_MCLK
+enum da7213_clk_src {
+	DA7213_CLKSRC_MCLK = 0,
+	DA7213_CLKSRC_MCLK_SQR,
 };
 
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct clk *mclk;
 	unsigned int mclk_rate;
+	int clk_src;
 	bool master;
 	bool mclk_squarer_en;
 	bool srm_en;
-- 
2.5.0
