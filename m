From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: cs53l30: Add MUTE pin control support via GPIO
Date: Tue, 21 Jun 2016 16:34:37 -0500
Message-ID: <20160621213437.GA3571@rob-hp-laptop>
References: <1466474084-6775-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466474084-6775-1-git-send-email-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2016 at 06:54:44PM -0700, Nicolin Chen wrote:
> The codec chip has a physical MUTE pin to let users control it via
> GPIO. So this patch add a mute control support to the driver.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/cs53l30.txt          |  2 ++
>  sound/soc/codecs/cs53l30.c                         | 30 ++++++++++++++++++++++
>  sound/soc/codecs/cs53l30.h                         |  1 +
>  3 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt b/Documentation/devicetree/bindings/sound/cs53l30.txt
> index 18d6b99..6f7d3c8 100644
> --- a/Documentation/devicetree/bindings/sound/cs53l30.txt
> +++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
> @@ -13,6 +13,8 @@ Optional properties:
>  
>    - reset-gpios : a GPIO spec for the reset pin.
>  
> +  - mute-gpios : a GPIO spec for the MUTE pin.

Please define the active state for the gpio.

> +
>    - cirrus,micbias-lvl : Set the output voltage level on the MICBIAS Pin.
>  			 0 = Hi-Z
>  			 1 = 1.80 V
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
