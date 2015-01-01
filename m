From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 20/21] ASoC: smdk_wm8994pcm: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:29 +0100
Message-ID: <1420128990-6872-21-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F96E2605C4
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:17:01 +0100 (CET)
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
 sound/soc/samsung/smdk_wm8994pcm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index c470e8e..b1c89ec 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -68,20 +68,6 @@ static int smdk_wm8994_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	mclk_freq = params_rate(params) * rfs;
 
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
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL1,
 					mclk_freq, SND_SOC_CLOCK_IN);
 	if (ret < 0)
@@ -118,6 +104,8 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8994-aif1",
 		.platform_name = "samsung-pcm.0",
 		.codec_name = "wm8994-codec",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &smdk_wm8994_pcm_ops,
 	},
 };
-- 
1.8.0
