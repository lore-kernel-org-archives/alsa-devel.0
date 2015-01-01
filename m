From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 19/21] ASoC: smdk_wm8570pcm: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:28 +0100
Message-ID: <1420128990-6872-20-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id F0AC42605BF
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:59 +0100 (CET)
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
 sound/soc/samsung/smdk_wm8580pcm.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index 05c609c..6deec52 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -62,20 +62,6 @@ static int smdk_wm8580_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	rfs = mclk_freq / params_rate(params) / 2;
 
-	/* Set the codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B
-				| SND_SOC_DAIFMT_IB_NF
-				| SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* Set the cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_B
-				| SND_SOC_DAIFMT_IB_NF
-				| SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	if (mclk_freq == xtal_freq) {
 		ret = snd_soc_dai_set_sysclk(codec_dai, WM8580_CLKSRC_MCLK,
 						mclk_freq, SND_SOC_CLOCK_IN);
@@ -121,6 +107,9 @@ static struct snd_soc_ops smdk_wm8580_pcm_ops = {
 	.hw_params = smdk_wm8580_pcm_hw_params,
 };
 
+#define SMDK_DAI_FMT (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF | \
+	SND_SOC_DAIFMT_CBS_CFS)
+
 static struct snd_soc_dai_link smdk_dai[] = {
 	{
 		.name = "WM8580 PAIF PCM RX",
@@ -129,6 +118,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8580.0-001b",
+		.dai_fmt = SMDK_DAI_FMT,
 		.ops = &smdk_wm8580_pcm_ops,
 	}, {
 		.name = "WM8580 PAIF PCM TX",
@@ -137,6 +127,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-capture",
 		.platform_name = "samsung-pcm.0",
 		.codec_name = "wm8580.0-001b",
+		.dai_fmt = SMDK_DAI_FMT,
 		.ops = &smdk_wm8580_pcm_ops,
 	},
 };
-- 
1.8.0
