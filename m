From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/21] ASoC: raumfeld: Use static DAI format
	setup
Date: Thu,  1 Jan 2015 17:16:17 +0100
Message-ID: <1420128990-6872-9-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E272260527
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:45 +0100 (CET)
In-Reply-To: <1420128990-6872-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Set the dai_fmt field in the dai_link struct instead of manually calling
snd_soc_dai_fmt(). This makes the code cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/raumfeld.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 0837065..552b763 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -88,7 +88,7 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	unsigned int fmt, clk = 0;
+	unsigned int clk = 0;
 	int ret = 0;
 
 	switch (params_rate(params)) {
@@ -112,15 +112,6 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	fmt = SND_SOC_DAIFMT_I2S |
-	      SND_SOC_DAIFMT_NB_NF |
-	      SND_SOC_DAIFMT_CBS_CFS;
-
-	/* setup the CODEC DAI */
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk, 0);
 	if (ret < 0)
 		return ret;
@@ -130,10 +121,6 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
 	if (ret < 0)
 		return ret;
@@ -169,9 +156,8 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int fmt, ret = 0, clk = 0;
+	int ret = 0, clk = 0;
 
 	switch (params_rate(params)) {
 	case 44100:
@@ -194,22 +180,11 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
-
-	/* setup the CODEC DAI */
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	/* setup the CPU DAI */
 	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, clk);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
 	if (ret < 0)
 		return ret;
@@ -233,6 +208,9 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.platform_name	= "pxa-pcm-audio",		\
 	.codec_dai_name	= "cs4270-hifi",		\
 	.codec_name	= "cs4270.0-0048",	\
+	.dai_fmt	= SND_SOC_DAIFMT_I2S |		\
+			  SND_SOC_DAIFMT_NB_NF |        \
+			  SND_SOC_DAIFMT_CBS_CFS,       \
 	.ops		= &raumfeld_cs4270_ops,		\
 }
 
@@ -243,6 +221,9 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.cpu_dai_name	= "pxa-ssp-dai.1",		\
 	.codec_dai_name	= "ak4104-hifi",		\
 	.platform_name	= "pxa-pcm-audio",		\
+	.dai_fmt	= SND_SOC_DAIFMT_I2S |		\
+			  SND_SOC_DAIFMT_NB_NF |	\
+			  SND_SOC_DAIFMT_CBS_CFS,       \
 	.ops		= &raumfeld_ak4104_ops,		\
 	.codec_name	= "spi0.0",			\
 }
-- 
1.8.0
