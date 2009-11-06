From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
 on OMAP MCBSP
Date: Fri, 6 Nov 2009 20:24:00 +0200
Message-ID: <20091106202400.a0ded9c3.jhnikula@gmail.com>
References: <1257454808.3576.397.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id BA6512453B
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 19:22:56 +0100 (CET)
Received: by fxm1 with SMTP id 1so923126fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2009 10:22:56 -0800 (PST)
In-Reply-To: <1257454808.3576.397.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 05 Nov 2009 21:00:08 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> From: Graeme Gregory <gg@slimlogic.co.uk>
> 
> This patch increases the number of supported audio channels from 4
> to 16 and has been sponsored by Shotspotter Inc. It also fixes a
> FSYNC rate calculation bug when McBSP is FSYNC master.
> 
I would not call it as bug but more like an implementation
restriction :-)

But as the patch now requires that machine driver using OMAP as a
master must provide the sample rate generator input clock frequency, I
would like to hear how it will work on Pandora.

Grazvydas: are you able to test is the Pandora still playing after applying
patch [1] to omap-mcbsp.c and my patch below to omap3pandora.c?

I made an assumption that input clock frequency on Pandora is
8 * 32 * sample_rate.

-- 
Jarkko

1.
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022797.html

---
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index ad219aa..d0949fe 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -40,9 +40,12 @@
 
 #define PREFIX "ASoC omap3pandora: "
 
-static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
-	struct snd_soc_dai *cpu_dai, unsigned int fmt)
+static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, unsigned int fmt)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -68,8 +71,9 @@ static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
 	}
 
 	/* Set McBSP clock to external */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT, 0,
-					    SND_SOC_CLOCK_IN);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
+				     8 * 32 * params_rate(params),
+				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
 		pr_err(PREFIX "can't set cpu system clock\n");
 		return ret;
@@ -87,11 +91,7 @@ static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
 static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
+	return omap3pandora_cmn_hw_params(substream, params,
 					  SND_SOC_DAIFMT_I2S |
 					  SND_SOC_DAIFMT_IB_NF |
 					  SND_SOC_DAIFMT_CBS_CFS);
@@ -100,11 +100,7 @@ static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
 static int omap3pandora_in_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
+	return omap3pandora_cmn_hw_params(substream, params,
 					  SND_SOC_DAIFMT_I2S |
 					  SND_SOC_DAIFMT_NB_NF |
 					  SND_SOC_DAIFMT_CBS_CFS);
