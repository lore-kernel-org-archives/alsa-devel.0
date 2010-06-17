From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pandora: fix CLKX polarity
Date: Thu, 17 Jun 2010 16:50:01 +0100
Message-ID: <u6g5khs6pbrq63fngu2ncjvv.1276789801383@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C12C244A8
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 17:50:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Probably best to add a CC to stable too. Sorry about the rubbish formatting, on my phone and it can't do any better.

Grazvydas Ignotas <notasas@gmail.com> wrote:

>After mass production started it was found that several boards exhibit
>noise problems during sound playback. After some investigation it was
>determined that CLKX polarity is set incorrectly, and even if most boards
>can tolerate the wrong setting, there are some that don't.
>
>Fix polarity setup in the board file. As the clock settings for input and
>output now match, merge in and out functions and structures to simplify
>code.
>
>Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>---
> sound/soc/omap/omap3pandora.c |   36 ++++++++----------------------------
> 1 files changed, 8 insertions(+), 28 deletions(-)
>
>diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
>index 87ce842..9eecac1 100644
>--- a/sound/soc/omap/omap3pandora.c
>+++ b/sound/soc/omap/omap3pandora.c
>@@ -43,12 +43,14 @@
> 
> static struct regulator *omap3pandora_dac_reg;
> 
>-static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
>-	struct snd_pcm_hw_params *params, unsigned int fmt)
>+static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
>+	struct snd_pcm_hw_params *params)
> {
> 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>+	int fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>+		  SND_SOC_DAIFMT_CBS_CFS;
> 	int ret;
> 
> 	/* Set codec DAI configuration */
>@@ -91,24 +93,6 @@ static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
> 	return 0;
> }
> 
>-static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
>-	struct snd_pcm_hw_params *params)
>-{
>-	return omap3pandora_cmn_hw_params(substream, params,
>-					  SND_SOC_DAIFMT_I2S |
>-					  SND_SOC_DAIFMT_IB_NF |
>-					  SND_SOC_DAIFMT_CBS_CFS);
>-}
>-
>-static int omap3pandora_in_hw_params(struct snd_pcm_substream *substream,
>-	struct snd_pcm_hw_params *params)
>-{
>-	return omap3pandora_cmn_hw_params(substream, params,
>-					  SND_SOC_DAIFMT_I2S |
>-					  SND_SOC_DAIFMT_NB_NF |
>-					  SND_SOC_DAIFMT_CBS_CFS);
>-}
>-
> static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
> 	struct snd_kcontrol *k, int event)
> {
>@@ -231,12 +215,8 @@ static int omap3pandora_in_init(struct snd_soc_codec *codec)
> 	return snd_soc_dapm_sync(codec);
> }
> 
>-static struct snd_soc_ops omap3pandora_out_ops = {
>-	.hw_params = omap3pandora_out_hw_params,
>-};
>-
>-static struct snd_soc_ops omap3pandora_in_ops = {
>-	.hw_params = omap3pandora_in_hw_params,
>+static struct snd_soc_ops omap3pandora_ops = {
>+	.hw_params = omap3pandora_hw_params,
> };
> 
> /* Digital audio interface glue - connects codec <--> CPU */
>@@ -246,14 +226,14 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
> 		.stream_name = "HiFi Out",
> 		.cpu_dai = &omap_mcbsp_dai[0],
> 		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
>-		.ops = &omap3pandora_out_ops,
>+		.ops = &omap3pandora_ops,
> 		.init = omap3pandora_out_init,
> 	}, {
> 		.name = "TWL4030",
> 		.stream_name = "Line/Mic In",
> 		.cpu_dai = &omap_mcbsp_dai[1],
> 		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
>-		.ops = &omap3pandora_in_ops,
>+		.ops = &omap3pandora_ops,
> 		.init = omap3pandora_in_init,
> 	}
> };
>-- 
>1.6.3.3
>
