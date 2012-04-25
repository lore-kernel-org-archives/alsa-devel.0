From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: bf5xx-ssm2602: Setup sysclock in
	init callback
Date: Wed, 25 Apr 2012 11:29:48 +0200
Message-ID: <1335346188-29823-2-git-send-email-lars@metafoo.de>
References: <1335346188-29823-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-093.synserver.de (smtp-out-100.synserver.de
	[212.40.185.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 88391104838
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 11:27:32 +0200 (CEST)
In-Reply-To: <1335346188-29823-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The sysclock is fixed, so just set it up once in the init callback instead of
setting it repeatably in the hw_params callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ssm2602.c |   37 ++++--------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index b39ad35..f5b9951 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -44,16 +44,8 @@
 
 static struct snd_soc_card bf5xx_ssm2602;
 
-static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int bf5xx_ssm2602_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int clk = 0;
-	int ret = 0;
-
-	pr_debug("%s rate %d format %x\n", __func__, params_rate(params),
-		params_format(params));
 	/*
 	 * If you are using a crystal source which frequency is not 12MHz
 	 * then modify the below case statement with frequency of the crystal.
@@ -61,31 +53,10 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 	 * If you are using the SPORT to generate clocking then this is
 	 * where to do it.
 	 */
-
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-	case 48000:
-	case 96000:
-	case 11025:
-	case 22050:
-	case 44100:
-		clk = 12000000;
-		break;
-	}
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, SSM2602_SYSCLK, clk,
+	return snd_soc_dai_set_sysclk(rtd->codec_dai, SSM2602_SYSCLK, 12000000,
 		SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
-static struct snd_soc_ops bf5xx_ssm2602_ops = {
-	.hw_params = bf5xx_ssm2602_hw_params,
-};
-
 /* CODEC is master for BCLK and LRC in this configuration. */
 #define BF5XX_SSM2602_DAIFMT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
 				SND_SOC_DAIFMT_CBM_CFM)
@@ -98,7 +69,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai[] = {
 		.codec_dai_name = "ssm2602-hifi",
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "ssm2602.0-001b",
-		.ops = &bf5xx_ssm2602_ops,
+		.init = bf5xx_ssm2602_init,
 		.dai_fmt = BF5XX_SSM2602_DAIFMT,
 	},
 	{
@@ -108,7 +79,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai[] = {
 		.codec_dai_name = "ssm2602-hifi",
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "ssm2602.0-001b",
-		.ops = &bf5xx_ssm2602_ops,
+		.init = bf5xx_ssm2602_init,
 		.dai_fmt = BF5XX_SSM2602_DAIFMT,
 	},
 };
-- 
1.7.9.5
