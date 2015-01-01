From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/21] ASoC: goni_wm8994: Use static DAI format
	setup
Date: Thu,  1 Jan 2015 17:16:19 +0100
Message-ID: <1420128990-6872-11-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 920E8260531
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:47 +0100 (CET)
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
 sound/soc/samsung/goni_wm8994.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index 3b527dc..fad56b9 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -136,22 +136,9 @@ static int goni_hifi_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int pll_out = 24000000;
 	int ret = 0;
 
-	/* set the cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec FLL */
 	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1, 0, pll_out,
 			params_rate(params) * 256);
@@ -182,12 +169,6 @@ static int goni_voice_hw_params(struct snd_pcm_substream *substream,
 	if (params_rate(params) != 8000)
 		return -EINVAL;
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_LEFT_J |
-			SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec FLL */
 	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL2, 0, pll_out,
 			params_rate(params) * 256);
@@ -234,6 +215,8 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.codec_dai_name = "wm8994-aif1",
 	.platform_name = "samsung-i2s.0",
 	.codec_name = "wm8994-codec.0-001a",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.init = goni_wm8994_init,
 	.ops = &goni_hifi_ops,
 }, {
@@ -242,6 +225,8 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.cpu_dai_name = "goni-voice-dai",
 	.codec_dai_name = "wm8994-aif2",
 	.codec_name = "wm8994-codec.0-001a",
+	.dai_fmt = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_IB_IF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops = &goni_voice_ops,
 },
 };
-- 
1.8.0
