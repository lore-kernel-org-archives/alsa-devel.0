From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/21] ASoC: neo1973_wm8753: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:22 +0100
Message-ID: <1420128990-6872-14-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D7326055F
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:51 +0100 (CET)
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
 sound/soc/samsung/neo1973_wm8753.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 9b4a09f..65602b9 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -70,20 +70,6 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, pll_out,
 		SND_SOC_CLOCK_IN);
@@ -151,13 +137,6 @@ static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
 
 	pcmdiv = WM8753_PCM_DIV_6; /* 2.048 MHz */
 
-	/* todo: gg check mode (DSP_B) against CSR datasheet */
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_PCMCLK, 12288000,
 		SND_SOC_CLOCK_IN);
@@ -300,6 +279,8 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.cpu_dai_name = "s3c24xx-iis",
 	.codec_dai_name = "wm8753-hifi",
 	.codec_name = "wm8753.0-001a",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.init = neo1973_wm8753_init,
 	.ops = &neo1973_hifi_ops,
 },
@@ -309,6 +290,8 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.cpu_dai_name = "bt-sco-pcm",
 	.codec_dai_name = "wm8753-voice",
 	.codec_name = "wm8753.0-001a",
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &neo1973_voice_ops,
 },
 };
-- 
1.8.0
