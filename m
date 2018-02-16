From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: dmic: Add optional wakeup delay
Date: Thu, 15 Feb 2018 18:47:29 -0800
Message-ID: <20180216024728.GA93733@rodete-desktop-imager.corp.google.com>
References: <20180216022416.208265-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180216022416.208265-1-mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Feb 15, 2018 at 06:24:16PM -0800, Matthias Kaehlcke wrote:
> On some systems a delay is needed after switching on the clocks, to allow
> the output to stabilize and avoid a popping noise at the beginning of
> the recording. Add the optional device tree property 'wakeup-delay-ms'
> and apply the specified delay after enabling the mic. A blocking delay
> can't be applied in dmic_daiops_trigger() since the function is called
> in atomic context. Instead use a DAPM event handler to set the enable
> GPIO and apply the delay in the handler.
> 
> Signed-off-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Changes in v2:
> - use DAPM event handler instead of _prepare() and get rid of
>   _trigger()
> - skip error check for optional 'wakeup-delay-ms' property
> - updated commit message

Looks good to me in general:

Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

But I don't know much about the audio subsystem. One comment below.

> 
>  .../devicetree/bindings/sound/dmic.txt        |  2 +
>  sound/soc/codecs/dmic.c                       | 63 ++++++++++---------
>  2 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> index f7bf65611453..e957b4136716 100644
> --- a/Documentation/devicetree/bindings/sound/dmic.txt
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -8,6 +8,7 @@ Required properties:
>  Optional properties:
>  	- dmicen-gpios: GPIO specifier for dmic to control start and stop
>  	- num-channels: Number of microphones on this DAI
> +	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
>  
>  Example node:
>  
> @@ -15,4 +16,5 @@ Example node:
>  		compatible = "dmic-codec";
>  		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
>  		num-channels = <1>;
> +		wakeup-delay-ms <50>;
>  	};
> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index cf83c423394d..b5f60ac22ace 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
[...]

>  static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
> -	SND_SOC_DAPM_AIF_OUT("DMIC AIF", "Capture", 0,
> -			     SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT_E("DMIC AIF", "Capture", 0,
> +			       SND_SOC_NOPM, 0, 0, dmic_aif_event,
> +			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

Any good reason both are _POST_? It seems like you'd want them to be
inverses (e.g., power-power-up, and pre-power-down).

>  	SND_SOC_DAPM_INPUT("DMic"),
>  };
>  

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
