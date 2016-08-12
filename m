From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 09/17] ASoC: Intel: bytcr_rt5640: fix dai/clock
	setup for SSP0 routing
Date: Fri, 12 Aug 2016 16:27:52 -0500
Message-ID: <1471037280-17433-10-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 654CD266040
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:48 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

SSP0 uses 16 bits 2ch, SSP2 24 bits 2ch

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 92 ++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4337b5e..42c7bd2 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -138,8 +138,6 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	snd_soc_dai_set_bclk_ratio(codec_dai, 50);
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
 				     params_rate(params) * 512,
 				     SND_SOC_CLOCK_IN);
@@ -148,9 +146,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,
-				  params_rate(params) * 50,
-				  params_rate(params) * 512);
+	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
+		(byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
+
+		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,
+					params_rate(params) * 32, /* FIXME */
+					params_rate(params) * 512);
+	} else {
+		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,
+					params_rate(params) * 50,
+					params_rate(params) * 512);
+	}
+
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
@@ -311,34 +318,63 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
 	int ret;
 
-	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	/* The DSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
-	/* set SSP2 to 24-bit */
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
-
-	/*
-	 * Default mode for SSP configuration is TDM 4 slot, override config
-	 * with explicit setting to I2S 2ch 24-bit. The word length is set with
-	 * dai_set_tdm_slot() since there is no other API exposed
-	 */
-	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
-				  SND_SOC_DAIFMT_I2S     |
-				  SND_SOC_DAIFMT_NB_IF   |
-				  SND_SOC_DAIFMT_CBS_CFS
-				  );
-	if (ret < 0) {
-		dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-		return ret;
-	}
+	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
+		(byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
+
+		/* set SSP2 to 16-bit */
+		params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
+
+		/*
+		 * Default mode for SSP configuration is TDM 4 slot, override config
+		 * with explicit setting to I2S 2ch 16-bit. The word length is set with
+		 * dai_set_tdm_slot() since there is no other API exposed
+		 */
+		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+					SND_SOC_DAIFMT_I2S     |
+					SND_SOC_DAIFMT_NB_IF   |
+					SND_SOC_DAIFMT_CBS_CFS
+			);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+			return ret;
+		}
 
-	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
-	if (ret < 0) {
-		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
-		return ret;
-	}
+		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 16);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+			return ret;
+		}
+
+	} else {
 
+		/* set SSP2 to 24-bit */
+		params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+
+		/*
+		 * Default mode for SSP configuration is TDM 4 slot, override config
+		 * with explicit setting to I2S 2ch 24-bit. The word length is set with
+		 * dai_set_tdm_slot() since there is no other API exposed
+		 */
+		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+					SND_SOC_DAIFMT_I2S     |
+					SND_SOC_DAIFMT_NB_IF   |
+					SND_SOC_DAIFMT_CBS_CFS
+			);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+			return ret;
+		}
+	}
 	return 0;
 }
 
-- 
2.5.0
