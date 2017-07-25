From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] ASoC: Intel: Fix Kabylake machine driver for
	pops and clicks
Date: Tue, 25 Jul 2017 15:27:39 -0700
Message-ID: <1501021659-8597-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 06EA2266CD2
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 00:27:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds fixes for the following issues in Kabylake machine driver

1. crackling noise in rt5663 headset codec 
2. enabling 4 slot IV feedback for max98927 speaker amp codec 
3. pop noise while recording from rt5514 dmic codec 

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 28 ++++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 3fe4a08..4c51965 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -319,7 +319,9 @@ static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
-	rt5663_sel_asrc_clk_src(codec_dai->codec, RT5663_DA_STEREO_FILTER, 1);
+	rt5663_sel_asrc_clk_src(codec_dai->codec,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
 
 	ret = snd_soc_dai_set_sysclk(codec_dai,
 			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
@@ -349,27 +351,27 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 			}
 
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-				RT5514_PLL1_S_BCLK, RT5514_AIF1_BCLK_FREQ,
-						RT5514_AIF1_SYSCLK_FREQ);
+			ret = snd_soc_dai_set_sysclk(codec_dai,
+				RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
+
 			if (ret < 0) {
-				dev_err(rtd->dev, "set bclk err: %d\n", ret);
+				dev_err(rtd->dev, "set sysclk err: %d\n", ret);
 				return ret;
 			}
+		}
 
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-				RT5514_SCLK_S_PLL1, RT5514_AIF1_SYSCLK_FREQ,
-							SND_SOC_CLOCK_IN);
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
 			if (ret < 0) {
-				dev_err(rtd->dev, "set sclk err: %d\n", ret);
+				dev_err(rtd->dev, "DEV0 TDM slot err:%d\n", ret);
 				return ret;
 			}
 		}
-		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME) ||
-			!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
-			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF0, 3, 8, 16);
+
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xC0, 3, 8, 16);
 			if (ret < 0) {
-				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
+				dev_err(rtd->dev, "DEV1 TDM slot err:%d\n", ret);
 				return ret;
 			}
 		}
-- 
1.9.1
