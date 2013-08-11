From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH 2/2] ASoC: cs4271: Add DAPM support
Date: Sun, 11 Aug 2013 14:34:19 +0200
Message-ID: <1376224459.11976.1.camel@r60e>
References: <1376223377-23047-1-git-send-email-broonie@kernel.org>
 <1376223377-23047-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward7l.mail.yandex.net (forward7l.mail.yandex.net
 [84.201.143.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E52E264FA2
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 14:34:24 +0200 (CEST)
In-Reply-To: <1376223377-23047-2-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Sun, 2013-08-11 at 13:16 +0100, Mark Brown wrote: 
> From: Mark Brown <broonie@linaro.org>
> 
> This makes it possible to hook the device into a more complex board and
> ensures it will continue to work with non-DAPM support removed from the
> core.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Alexander Sverdlin <subaparts@yandex.ru>

> ---
>  sound/soc/codecs/cs4271.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 65ad56c..35a6a67 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -173,6 +173,26 @@ struct cs4271_private {
>  	bool				enable_soft_reset;
>  };
>  
> +static const struct snd_soc_dapm_widget cs4271_dapm_widgets[] = {
> +SND_SOC_DAPM_INPUT("AINA"),
> +SND_SOC_DAPM_INPUT("AINB"),
> +
> +SND_SOC_DAPM_OUTPUT("AOUTA+"),
> +SND_SOC_DAPM_OUTPUT("AOUTA-"),
> +SND_SOC_DAPM_OUTPUT("AOUTB+"),
> +SND_SOC_DAPM_OUTPUT("AOUTB-"),
> +};
> +
> +static const struct snd_soc_dapm_route cs4271_dapm_routes[] = {
> +	{ "Capture", NULL, "AINL" },
> +	{ "Capture", NULL, "AINR" },
> +
> +	{ "AOUTA+", NULL, "Playback" },
> +	{ "AOUTA-", NULL, "Playback" },
> +	{ "AOUTB+", NULL, "Playback" },
> +	{ "AOUTB-", NULL, "Playback" },
> +};
> +
>  /*
>   * @freq is the desired MCLK rate
>   * MCLK rate should (c) be the sample rate, multiplied by one of the
> @@ -598,6 +618,10 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
>  
>  	.controls		= cs4271_snd_controls,
>  	.num_controls		= ARRAY_SIZE(cs4271_snd_controls),
> +	.dapm_widgets		= cs4271_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(cs4271_dapm_widgets),
> +	.dapm_routes		= cs4271_dapm_routes,
> +	.num_dapm_routes	= ARRAY_SIZE(cs4271_dapm_routes),
>  };
>  
>  #if defined(CONFIG_SPI_MASTER)
