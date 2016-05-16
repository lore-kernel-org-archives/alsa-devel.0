From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: pcm5102a: Add support for PCM5102A codec
Date: Mon, 16 May 2016 11:26:30 -0500
Message-ID: <20160516162630.GA15914@rob-hp-laptop>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463130853-25096-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2016 at 09:14:12AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
> 
> Some definitions to support the PCM5102A codec
> by Texas Instruments.
> 
> Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
> 
> Changes to original patch by Florian Meier:
> * rebased (Makefile and Kconfig
> * fixed checkpath errors (spaces, newlines)
> * added dt-binding documentation
> 
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/pcm5102a.txt         | 13 ++++
>  sound/soc/codecs/Kconfig                           |  4 ++
>  sound/soc/codecs/Makefile                          |  2 +
>  sound/soc/codecs/pcm5102a.c                        | 69 ++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.txt
>  create mode 100644 sound/soc/codecs/pcm5102a.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm5102a.txt b/Documentation/devicetree/bindings/sound/pcm5102a.txt
> new file mode 100644
> index 0000000..c63ab0b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm5102a.txt
> @@ -0,0 +1,13 @@
> +PCM5102a audio CODECs
> +
> +These devices does not use I2C or SPI.

s/does/do/ or singular device.

What do they use? Describe the interface (or lack of), not 2 possible 
interfaces that it doesn't have.

> +
> +Required properties:
> +
> +  - compatible : set as "ti,pcm5102a"
> +
> +Examples:
> +
> +	pcm5102a: pcm5102a {
> +		compatible = "ti,pcm5102a";
> +	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
