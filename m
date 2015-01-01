From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/21] ASoC: smdk_wm8580: Use static DAI format
	setup
Date: Thu,  1 Jan 2015 17:16:27 +0100
Message-ID: <1420128990-6872-19-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id A44B6260578
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:58 +0100 (CET)
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
 sound/soc/samsung/smdk_wm8580.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index b1a519f..17a2f71 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -32,7 +32,6 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int pll_out;
 	int bfs, rfs, ret;
@@ -77,20 +76,6 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 	}
 	pll_out = params_rate(params) * rfs;
 
-	/* Set the Codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* Set the AP DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	/* Set WM8580 to drive MCLK from its PLLA */
 	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
 					WM8580_CLKSRC_PLLA);
@@ -168,6 +153,9 @@ enum {
 	SEC_PLAYBACK,
 };
 
+#define SMDK_DAI_FMT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
+	SND_SOC_DAIFMT_CBM_CFM)
+
 static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_PLAYBACK] = { /* Primary Playback i/f */
 		.name = "WM8580 PAIF RX",
@@ -176,6 +164,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
+		.dai_fmt = SMDK_DAI_FMT,
 		.ops = &smdk_ops,
 	},
 	[PRI_CAPTURE] = { /* Primary Capture i/f */
@@ -185,6 +174,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-capture",
 		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
+		.dai_fmt = SMDK_DAI_FMT,
 		.init = smdk_wm8580_init_paiftx,
 		.ops = &smdk_ops,
 	},
@@ -195,6 +185,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-i2s-sec",
 		.codec_name = "wm8580.0-001b",
+		.dai_fmt = SMDK_DAI_FMT,
 		.ops = &smdk_ops,
 	},
 };
-- 
1.8.0
