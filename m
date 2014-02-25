From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: byt-rt5640: Use init time DAI
	format
Date: Tue, 25 Feb 2014 15:17:28 +0200
Message-ID: <1393334248-29033-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1393334248-29033-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A26265463
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 14:17:45 +0100 (CET)
In-Reply-To: <1393334248-29033-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Setting static DAI format has been supported in the soc-core quite some time
now so there is no need to set it runtime in machine driver.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index 672fedbfa680..eff97c8e5218 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -57,19 +57,8 @@ static int byt_rt5640_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int fmt;
 	int ret;
 
-	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-	      SND_SOC_DAIFMT_CBS_CFS;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		dev_err(codec_dai->dev,
-			"can't set codec DAI configuration %d\n", ret);
-		return ret;
-	}
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
 				     params_rate(params) * 256,
 				     SND_SOC_CLOCK_IN);
@@ -132,6 +121,8 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.codec_dai_name = "rt5640-aif1",
 		.codec_name = "i2c-10EC5640:00",
 		.platform_name = "baytrail-pcm-audio",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
 		.init = byt_rt5640_init,
 		.ignore_suspend = 1,
 		.ops = &byt_rt5640_ops,
@@ -143,6 +134,8 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.codec_dai_name = "rt5640-aif1",
 		.codec_name = "i2c-10EC5640:00",
 		.platform_name = "baytrail-pcm-audio",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
 		.init = NULL,
 		.ignore_suspend = 1,
 		.ops = &byt_rt5640_ops,
-- 
1.8.5.3
