From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 25/32] ASoC: Intel: bytcr_rt5651: Configure
	PLL1 before using it
Date: Sun, 25 Feb 2018 11:47:06 +0100
Message-ID: <20180225104713.4745-26-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ADCB2674D2
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:53 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

When platform_clock_control() first selects PLL1 as sysclk the PLL_CTRL
registers have not been setup yet and we effectively have an invalid clock
configuration until byt_rt5651_aif1_hw_params() gets called.

Add a new byt_rt5651_prepare_and_enable_pll1() helper and use that from
both platform_clock_control() and byt_rt5651_aif1_hw_params() to fix this.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Make bclk_ratio configurable instead of hardcoding it to 50, this will be
 used when adding SSP0 support
---
 sound/soc/intel/boards/bytcr_rt5651.c | 73 +++++++++++++++++------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e44851448118..28219945912a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -110,6 +110,38 @@ static void log_quirks(struct device *dev)
 
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
@@ -135,9 +167,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
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
@@ -251,44 +281,11 @@ static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
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
2.14.3
