From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Configure PLL1
	before using it" to the asoc tree
Date: Fri, 11 May 2018 03:48:46 +0100 (BST)
Message-ID: <20180511024846.3322244007C@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE9962677B2
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:01:21 +0200 (CEST)
In-Reply-To: <20180508153604.23711-9-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Configure PLL1 before using it

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From bcd9a325f0b0f407c4559779a94e802977c67274 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:53 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Configure PLL1 before using it

When platform_clock_control() first selects PLL1 as sysclk the PLL_CTRL
registers have not been setup yet and we effectively have an invalid clock
configuration until byt_rt5640_aif1_hw_params() gets called.

Add a new byt_rt5640_prepare_and_enable_pll1() helper and use that from
both platform_clock_control() and byt_rt5640_aif1_hw_params() to fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 100 +++++++++++++-------------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index ad5fcd5a1762..c540dfdf045d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -141,6 +141,52 @@ static void log_quirks(struct device *dev)
 	}
 }
 
+static int byt_rt5640_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai,
+					      int rate)
+{
+	int ret;
+
+	/* Configure the PLL before selecting it */
+	if (!(byt_rt5640_quirk & BYT_RT5640_MCLK_EN)) {
+		/* use bitclock as PLL input */
+		if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
+		    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
+			/* 2x16 bit slots on SSP0 */
+			ret = snd_soc_dai_set_pll(codec_dai, 0,
+						  RT5640_PLL1_S_BCLK1,
+						  rate * 32, rate * 512);
+		} else {
+			/* 2x15 bit slots on SSP2 */
+			ret = snd_soc_dai_set_pll(codec_dai, 0,
+						  RT5640_PLL1_S_BCLK1,
+						  rate * 50, rate * 512);
+		}
+	} else {
+		if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ) {
+			ret = snd_soc_dai_set_pll(codec_dai, 0,
+						  RT5640_PLL1_S_MCLK,
+						  25000000, rate * 512);
+		} else {
+			ret = snd_soc_dai_set_pll(codec_dai, 0,
+						  RT5640_PLL1_S_MCLK,
+						  19200000, rate * 512);
+		}
+	}
+
+	if (ret < 0) {
+		dev_err(codec_dai->codec->dev, "can't set pll: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
+				     rate * 512, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->codec->dev, "can't set clock %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
 
 #define BYT_CODEC_DAI1	"rt5640-aif1"
 #define BYT_CODEC_DAI2	"rt5640-aif2"
@@ -173,9 +219,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				return ret;
 			}
 		}
-		ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
-					     48000 * 512,
-					     SND_SOC_CLOCK_IN);
+		ret = byt_rt5640_prepare_and_enable_pll1(codec_dai, 48000);
 	} else {
 		/*
 		 * Set codec clock source to internal clock before
@@ -299,55 +343,9 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
-				     params_rate(params) * 512,
-				     SND_SOC_CLOCK_IN);
-
-	if (ret < 0) {
-		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
-		return ret;
-	}
+	struct snd_soc_dai *dai = rtd->codec_dai;
 
-	if (!(byt_rt5640_quirk & BYT_RT5640_MCLK_EN)) {
-		/* use bitclock as PLL input */
-		if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
-			(byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-
-			/* 2x16 bit slots on SSP0 */
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_BCLK1,
-						params_rate(params) * 32,
-						params_rate(params) * 512);
-		} else {
-			/* 2x15 bit slots on SSP2 */
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_BCLK1,
-						params_rate(params) * 50,
-						params_rate(params) * 512);
-		}
-	} else {
-		if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ) {
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_MCLK,
-						25000000,
-						params_rate(params) * 512);
-		} else {
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_MCLK,
-						19200000,
-						params_rate(params) * 512);
-		}
-	}
-
-	if (ret < 0) {
-		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return byt_rt5640_prepare_and_enable_pll1(dai, params_rate(params));
 }
 
 static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
-- 
2.17.0
