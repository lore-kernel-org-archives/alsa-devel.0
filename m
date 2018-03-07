From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Configure PLL1
	before using it" to the asoc tree
Date: Wed, 07 Mar 2018 14:22:18 +0000
Message-ID: <E1etZxS-0002mx-Ci@debutante>
References: <20180225104713.4745-26-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CD5D52673A4
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:23 +0100 (CET)
In-Reply-To: <20180225104713.4745-26-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Configure PLL1 before using it

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

>From aeec6cc0821573920d559f7d6297ea5dd3fbbd17 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:03 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Configure PLL1 before using it

When platform_clock_control() first selects PLL1 as sysclk the PLL_CTRL
registers have not been setup yet and we effectively have an invalid clock
configuration until byt_rt5651_aif1_hw_params() gets called.

Add a new byt_rt5651_prepare_and_enable_pll1() helper and use that from
both platform_clock_control() and byt_rt5651_aif1_hw_params() to fix this.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 73 +++++++++++++++++------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 91b5841af622..af30c730f432 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -111,6 +111,38 @@ static void log_quirks(struct device *dev)
 
 #define BYT_CODEC_DAI1	"rt5651-aif1"
 
+static int byt_rt5651_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai,
+					      int rate, int bclk_ratio)
+{
+	int clk_id, clk_freq, ret;
+
+	/* Configure the PLL before selecting it */
+	if (!(byt_rt5651_quirk & BYT_RT5651_MCLK_EN)) {
+		clk_id = RT5651_PLL1_S_BCLK1,
+		clk_freq = rate * bclk_ratio;
+	} else {
+		clk_id = RT5651_PLL1_S_MCLK;
+		if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
+			clk_freq = 25000000;
+		else
+			clk_freq = 19200000;
+	}
+	ret = snd_soc_dai_set_pll(codec_dai, 0, clk_id, clk_freq, rate * 512);
+	if (ret < 0) {
+		dev_err(codec_dai->codec->dev, "can't set pll: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
+				     rate * 512, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->codec->dev, "can't set clock %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *k, int  event)
 {
@@ -136,9 +168,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				return ret;
 			}
 		}
-		ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
-					     48000 * 512,
-					     SND_SOC_CLOCK_IN);
+		ret = byt_rt5651_prepare_and_enable_pll1(codec_dai, 48000, 50);
 	} else {
 		/*
 		 * Set codec clock source to internal clock before
@@ -252,44 +282,11 @@ static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
+	int rate = params_rate(params);
 
 	snd_soc_dai_set_bclk_ratio(codec_dai, 50);
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
-				     params_rate(params) * 512,
-				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
-		return ret;
-	}
-
-	if (!(byt_rt5651_quirk & BYT_RT5651_MCLK_EN)) {
-		/* 2x25 bit slots on SSP2 */
-		ret = snd_soc_dai_set_pll(codec_dai, 0,
-					RT5651_PLL1_S_BCLK1,
-					params_rate(params) * 50,
-					params_rate(params) * 512);
-	} else {
-		if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ) {
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5651_PLL1_S_MCLK,
-						25000000,
-						params_rate(params) * 512);
-		} else {
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5651_PLL1_S_MCLK,
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
+	return byt_rt5651_prepare_and_enable_pll1(codec_dai, rate, 50);
 }
 
 static int byt_rt5651_quirk_cb(const struct dmi_system_id *id)
-- 
2.16.2
