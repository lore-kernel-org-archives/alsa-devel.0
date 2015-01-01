From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/21] ASoC: eureka-tlv320: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:12 +0100
Message-ID: <1420128990-6872-4-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5A12604D1
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:38 +0100 (CET)
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
 sound/soc/fsl/eukrea-tlv320.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 9ce70fc..8c9e900 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -42,25 +42,6 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	/* fsl_ssi lacks the set_fmt ops. */
-	if (ret && ret != -ENOTSUPP) {
-		dev_err(cpu_dai->dev,
-			"Failed to set the cpu dai format.\n");
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		dev_err(cpu_dai->dev,
-			"Failed to set the codec format.\n");
-		return ret;
-	}
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 				     CODEC_CLOCK, SND_SOC_CLOCK_OUT);
 	if (ret) {
@@ -91,6 +72,8 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.codec_dai_name	= "tlv320aic23-hifi",
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &eukrea_tlv320_snd_ops,
 };
 
-- 
1.8.0
