From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 05/20] ASoC: davinci-evm: Switch to use
	.dai_fmt of snd_soc_dai_link(s)
Date: Thu, 14 Nov 2013 11:35:21 +0200
Message-ID: <1384421737-4467-6-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 80D57261A11
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:35:50 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Specify the dai formats to use within the snd_soc_dai_link structures. In
this way we can remove the code dealing with the dai format configuration
from the machin driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-evm.c | 47 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 2a00e2d..70ff377 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -33,8 +33,6 @@ struct snd_soc_card_drvdata_davinci {
 	unsigned sysclk;
 };
 
-#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
-		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
 static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
@@ -47,16 +45,6 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
 			   snd_soc_card_get_drvdata(soc_card))->sysclk;
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
 	if (ret < 0)
@@ -70,24 +58,10 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int evm_spdif_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-	/* set cpu DAI configuration */
-	return snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
-}
-
 static struct snd_soc_ops evm_ops = {
 	.hw_params = evm_hw_params,
 };
 
-static struct snd_soc_ops evm_spdif_ops = {
-	.hw_params = evm_spdif_hw_params,
-};
-
 /* davinci-evm machine dapm widgets */
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
@@ -164,6 +138,8 @@ static struct snd_soc_dai_link dm6446_evm_dai = {
 	.platform_name = "davinci-mcbsp",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+		   SND_SOC_DAIFMT_IB_NF,
 };
 
 static struct snd_soc_dai_link dm355_evm_dai = {
@@ -175,6 +151,8 @@ static struct snd_soc_dai_link dm355_evm_dai = {
 	.platform_name = "davinci-mcbsp.1",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+		   SND_SOC_DAIFMT_IB_NF,
 };
 
 static struct snd_soc_dai_link dm365_evm_dai = {
@@ -183,10 +161,12 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 	.stream_name = "AIC3X",
 	.cpu_dai_name = "davinci-mcbsp",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.init = evm_aic3x_init,
 	.codec_name = "tlv320aic3x-codec.1-0018",
-	.ops = &evm_ops,
 	.platform_name = "davinci-mcbsp",
+	.init = evm_aic3x_init,
+	.ops = &evm_ops,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+		   SND_SOC_DAIFMT_IB_NF,
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
 	.stream_name = "CQ93",
@@ -207,6 +187,8 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.codec_name = "tlv320aic3x-codec.0-001a",
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+			   SND_SOC_DAIFMT_IB_NF,
 	},
 	{
 		.name = "McASP",
@@ -215,7 +197,8 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif_dit",
 		.platform_name = "davinci-mcasp.1",
-		.ops = &evm_spdif_ops,
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+			   SND_SOC_DAIFMT_IB_NF,
 	},
 };
 
@@ -228,6 +211,8 @@ static struct snd_soc_dai_link da830_evm_dai = {
 	.platform_name = "davinci-mcasp.1",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+		   SND_SOC_DAIFMT_IB_NF,
 };
 
 static struct snd_soc_dai_link da850_evm_dai = {
@@ -239,6 +224,8 @@ static struct snd_soc_dai_link da850_evm_dai = {
 	.platform_name = "davinci-mcasp.0",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+		   SND_SOC_DAIFMT_IB_NF,
 };
 
 /* davinci dm6446 evm audio machine driver */
@@ -335,6 +322,8 @@ static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
 	.codec_dai_name	= "tlv320aic3x-hifi",
 	.ops            = &evm_ops,
 	.init           = evm_aic3x_init,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
+		   SND_SOC_DAIFMT_IB_NF,
 };
 
 static const struct of_device_id davinci_evm_dt_ids[] = {
-- 
1.8.4.2
