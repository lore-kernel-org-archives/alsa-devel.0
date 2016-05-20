From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: wm8985: add device tree binding for WM8985
Date: Fri, 20 May 2016 17:14:42 +0100
Message-ID: <20160520161442.GR1646@localhost.localdomain>
References: <1463489389-17719-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463489389-17719-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, plamen-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 02:49:48PM +0200, Petr Kulhavy wrote:
> Add device tree binding for the WM8985 codec driver.
> 
> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> v1: initial
> v2: no change
> 
>  Documentation/devicetree/bindings/sound/wm8985.txt | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/wm8985.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8985.txt b/Documentation/devicetree/bindings/sound/wm8985.txt
> new file mode 100644
> index 000000000000..788d64766257
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wm8985.txt
> @@ -0,0 +1,36 @@
> +Wolfson Microelectronics WM8985 and WM8758 audio codecs
> +
> +These devices support both I2C and SPI (configured with pin strapping
> +on the board).
> +
> +Required properties:
> +
> +  - compatible : "wlf,wm8985" or "wlf,wm8758"
> +
> +  - reg : the I2C address of the device for I2C, the chip select
> +          number for SPI.
> +
> +Pins on the device for linking into audio routes:
> +
> +  * LIN      : left microphone pre-amp negative input
> +  * LIP      : left microphone pre-amp positive input
> +  * RIN      : right microphone pre-amp negative input
> +  * RIP      : right microphone pre-amp positive input
> +  * L2       : left line input / secondary pre-amp positive input
> +  * R2       : right line input / secondary pre-amp positive input
> +  * AUXL     : left auxiliary input (WM8985 only)
> +  * AUXR     : right auxiliary input (WM8985 only)
> +
> +  * HPL      : left headphone / line output (the LOUT1 pin)
> +  * HPR      : right headphone / line output (the ROUT1 pin)
> +  * SPKL     : left headphone / line output (the LOUT2 pin)
> +  * SPKR     : right headphone / line output (the ROUT2 pin)
> +  * Mic Bias : microphone bias
> +
> +
> +Example:
> +
> +wm8758: audio-codec@1a {
> +	compatible = "wlf,wm8758";
> +	reg = <0x1a>;
> +};

You should probably mention the regulators as well.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
