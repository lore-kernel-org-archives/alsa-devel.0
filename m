From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/21] ASoC: mxs-sgtl5000: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:15 +0100
Message-ID: <1420128990-6872-7-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 60420260501
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:42 +0100 (CET)
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
 sound/soc/mxs/mxs-sgtl5000.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 6f1916b..6e6fce6 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -36,7 +36,7 @@ static int mxs_sgtl5000_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int rate = params_rate(params);
-	u32 dai_format, mclk;
+	u32 mclk;
 	int ret;
 
 	/* sgtl5000 does not support 512*rate when in 96000 fs */
@@ -65,26 +65,6 @@ static int mxs_sgtl5000_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* set codec to slave mode */
-	dai_format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, dai_format);
-	if (ret) {
-		dev_err(codec_dai->dev, "Failed to set dai format to %08x\n",
-			dai_format);
-		return ret;
-	}
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, dai_format);
-	if (ret) {
-		dev_err(cpu_dai->dev, "Failed to set dai format to %08x\n",
-			dai_format);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -92,17 +72,22 @@ static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
 	.hw_params = mxs_sgtl5000_hw_params,
 };
 
+#define MXS_SGTL5000_DAI_FMT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
+	SND_SOC_DAIFMT_CBS_CFS)
+
 static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 	{
 		.name		= "HiFi Tx",
 		.stream_name	= "HiFi Playback",
 		.codec_dai_name	= "sgtl5000",
+		.dai_fmt	= MXS_SGTL5000_DAI_FMT,
 		.ops		= &mxs_sgtl5000_hifi_ops,
 		.playback_only	= true,
 	}, {
 		.name		= "HiFi Rx",
 		.stream_name	= "HiFi Capture",
 		.codec_dai_name	= "sgtl5000",
+		.dai_fmt	= MXS_SGTL5000_DAI_FMT,
 		.ops		= &mxs_sgtl5000_hifi_ops,
 		.capture_only	= true,
 	},
-- 
1.8.0
