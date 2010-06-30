From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [RFC 04/15] ASoC: multi-component - TI DaVinci
 Platform
Date: Thu, 1 Jul 2010 00:58:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305A415C0@dbde02.ent.ti.com>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
	<1277639534-5104-5-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 32082243ED
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 21:28:18 +0200 (CEST)
In-Reply-To: <1277639534-5104-5-git-send-email-lrg@slimlogic.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Liam Girdwood
Sent: Sunday, June 27, 2010 5:22 PM
To: alsa-devel@alsa-project.org
Cc: Mark Brown; Liam Girdwood
Subject: [alsa-devel] [RFC 04/15] ASoC: multi-component - TI DaVinci Platform

Update the TI DaVinci platform and machines to new multi-component model.

[...]

@@ -161,8 +163,10 @@ static int evm_aic3x_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &davinci_i2s_dai,
+	.codec_dai_drv = &aic3x_dai,
+	.codec_drv = &soc_codec_dev_aic3x,
+	.platform_drv = &davinci_soc_platform,
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -171,40 +175,52 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 #ifdef CONFIG_SND_DM365_AIC3X_CODEC
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &davinci_i2s_dai,
+	.codec_dai_drv = &aic3x_dai,
 	.init = evm_aic3x_init,
+	.codec_drv = &soc_codec_dev_aic3x,
 	.ops = &evm_ops,
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
 	.stream_name = "CQ93",
-	.cpu_dai = &davinci_vcif_dai,
-	.codec_dai = &cq93vc_dai,
+	.cpu_dai_drv = &davinci_vcif_dai,
+	.codec_dai_drv = &cq93vc_dai,
+	.codec_drv = &soc_codec_dev_cq93vc,
 #endif
+	.platform_drv = &davinci_soc_platform,
 };
 
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
 		.stream_name = "AIC3X",
-		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
-		.codec_dai = &aic3x_dai,
+		.cpu_dai_drv= &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
+		.cpu_dai_id = DAVINCI_MCASP_I2S_DAI,
+		.codec_dai_drv = &aic3x_dai,
+		.platform_drv = &davinci_soc_platform,
+		.codec_drv = &soc_codec_dev_aic3x,
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
 	},
 	{
 		.name = "McASP",
 		.stream_name = "spdif",
-		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
-		.codec_dai = &dit_stub_dai,
+		.cpu_dai_drv = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
+		.cpu_dai_id = DAVINCI_MCASP_DIT_DAI,
+		.codec_dai_drv = &dit_stub_dai,
+		.codec_drv = &soc_codec_spdif_dit,
+		.platform_drv = &davinci_soc_platform,
 		.ops = &evm_spdif_ops,
 	},
 };
 static struct snd_soc_dai_link da8xx_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
+	.cpu_dai_id = DAVINCI_MCASP_I2S_DAI,
+	.codec_dai_drv = &aic3x_dai,
+	.codec_drv = &soc_codec_dev_aic3x,
+	.platform_drv = &davinci_soc_platform,
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
[...]

Hi Liam,

While testing out the recent multi-component changes on da8xx at first I was unable to get the codec to register with a codec id of -1. However specifying the I2C address of the codec did the trick. 

Seeing the other mails about sound cards not being registered I wanted to confirm whether a codec_id of -1 works or right now I2C address is necessary.

Regards,
Vaibhav
