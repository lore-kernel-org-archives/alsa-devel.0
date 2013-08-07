From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ad1980: Provide stub DAPM support
Date: Wed, 07 Aug 2013 09:53:02 +0200
Message-ID: <5201FCDE.2070100@metafoo.de>
References: <1375829501-14223-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-104.synserver.de (smtp-out-110.synserver.de
 [212.40.185.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8AC260305
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 09:52:04 +0200 (CEST)
In-Reply-To: <1375829501-14223-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 08/07/2013 12:51 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since non-DAPM devices are not going to be supported provide DAPM input
> and output widgets and hook them up to the DAIs.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

I unfortunately can't test this at the moment, but looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/codecs/ad1980.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index 89fcf7d..7257a88 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -96,6 +96,44 @@ SOC_ENUM("Capture Source", ad1980_cap_src),
>  SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
>  };
>  
> +static const struct snd_soc_dapm_widget ad1980_dapm_widgets[] = {
> +SND_SOC_DAPM_INPUT("MIC1"),
> +SND_SOC_DAPM_INPUT("MIC2"),
> +SND_SOC_DAPM_INPUT("CD_L"),
> +SND_SOC_DAPM_INPUT("CD_R"),
> +SND_SOC_DAPM_INPUT("AUX_L"),
> +SND_SOC_DAPM_INPUT("AUX_R"),
> +SND_SOC_DAPM_INPUT("LINE_IN_L"),
> +SND_SOC_DAPM_INPUT("LINE_IN_R"),
> +
> +SND_SOC_DAPM_OUTPUT("LFE_OUT"),
> +SND_SOC_DAPM_OUTPUT("CENTER_OUT"),
> +SND_SOC_DAPM_OUTPUT("LINE_OUT_L"),
> +SND_SOC_DAPM_OUTPUT("LINE_OUT_R"),
> +SND_SOC_DAPM_OUTPUT("MONO_OUT"),
> +SND_SOC_DAPM_OUTPUT("HP_OUT_L"),
> +SND_SOC_DAPM_OUTPUT("HP_OUT_R"),
> +};
> +
> +static const struct snd_soc_dapm_route ad1980_dapm_routes[] = {
> +	{ "Capture", NULL, "MIC1" },
> +	{ "Capture", NULL, "MIC2" },
> +	{ "Capture", NULL, "CD_L" },
> +	{ "Capture", NULL, "CD_R" },
> +	{ "Capture", NULL, "AUX_L" },
> +	{ "Capture", NULL, "AUX_R" },
> +	{ "Capture", NULL, "LINE_IN_L" },
> +	{ "Capture", NULL, "LINE_IN_R" },
> +
> +	{ "LFE_OUT", NULL, "Playback" },
> +	{ "CENTER_OUT", NULL, "Playback" },
> +	{ "LINE_OUT_L", NULL, "Playback" },
> +	{ "LINE_OUT_R", NULL, "Playback" },
> +	{ "MONO_OUT", NULL, "Playback" },
> +	{ "HP_OUT_L", NULL, "Playback" },
> +	{ "HP_OUT_R", NULL, "Playback" },
> +};
> +
>  static unsigned int ac97_read(struct snd_soc_codec *codec,
>  	unsigned int reg)
>  {
> @@ -253,6 +291,11 @@ static struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
>  	.reg_cache_step = 2,
>  	.write = ac97_write,
>  	.read = ac97_read,
> +
> +	.dapm_widgets = ad1980_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(ad1980_dapm_widgets),
> +	.dapm_routes = ad1980_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(ad1980_dapm_routes),
>  };
>  
>  static int ad1980_probe(struct platform_device *pdev)
> 
