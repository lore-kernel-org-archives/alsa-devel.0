From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/21] ASoC: mx27vis-aci32x4: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:13 +0100
Message-ID: <1420128990-6872-5-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id B18122604EA
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:39 +0100 (CET)
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
 sound/soc/fsl/mx27vis-aic32x4.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index b1ced7b..198eeb3 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -55,16 +55,6 @@ static int mx27vis_aic32x4_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
-	u32 dai_format;
-
-	dai_format = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM;
-
-	/* set codec DAI configuration */
-	snd_soc_dai_set_fmt(codec_dai, dai_format);
-
-	/* set cpu DAI configuration */
-	snd_soc_dai_set_fmt(cpu_dai, dai_format);
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 				     25000000, SND_SOC_CLOCK_OUT);
@@ -164,6 +154,8 @@ static struct snd_soc_dai_link mx27vis_aic32x4_dai = {
 	.platform_name	= "imx-ssi.0",
 	.codec_name	= "tlv320aic32x4.0-0018",
 	.cpu_dai_name	= "imx-ssi.0",
+	.dai_fmt	= SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &mx27vis_aic32x4_snd_ops,
 };
 
-- 
1.8.0
