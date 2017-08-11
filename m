From: Naveen M <naveen.m@intel.com>
Subject: [PATCH] ASoC: Intel: kbl: Enabling ASRC for RT5663
	codec on kabylake platform
Date: Fri, 11 Aug 2017 10:30:46 +0530
Message-ID: <1502427646-18880-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C84B7267610
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 07:01:22 +0200 (CEST)
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
Cc: Shruthi Sudhakar <shruthi.sudhakar@intel.com>, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, Harsha Priya N <harshapriya.n@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Harsha Priya N <harshapriya.n@intel.com>

Patch fixes cracking noise in rt5663 headphones for kbl platform by
calling rt5663_sel_asrc_clk_src() for RT5663_AD_STEREO_FILTER to set
ASRC.

The ASRC function is for asynchronous MCLK and LRCK. For RT5663 ASRC
should be enabled to  support special i2s clock format like Intel's
100fs. ASRC function will track i2s clock and generate corresponding
system clock for codec. Calling this func helps select clock source
for both RT5663_AD_STEREO_FILTER and RT5663_DA_STEREO_FILTER filters
which fixes the crackling sound.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Shruthi Sudhakar <shruthi.sudhakar@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index f9ba977..29b50e4 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -312,11 +312,13 @@ static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
 	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
-	rt5663_sel_asrc_clk_src(codec_dai->codec, RT5663_DA_STEREO_FILTER, 1);
+	rt5663_sel_asrc_clk_src(codec_dai->codec,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
 
+	ret = snd_soc_dai_set_sysclk(codec_dai,
+			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
 
-- 
1.9.1
