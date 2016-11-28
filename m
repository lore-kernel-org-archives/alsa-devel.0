From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ALSA SoC MAX98927 driver - Initial release
Date: Mon, 28 Nov 2016 16:01:53 -0600
Message-ID: <20161128220153.7ccbt4p3wy2fomis@rob-hp-laptop>
References: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479877026-5172-1-git-send-email-RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org, Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2016 at 01:57:06PM +0900, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/max98927.txt         |   32 +
>  sound/soc/codecs/Kconfig                           |    5 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/max98927.c                        |  954 +++++++++++++++
>  sound/soc/codecs/max98927.h                        | 1253 ++++++++++++++++++++
>  5 files changed, 2246 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/max98927.txt
>  mode change 100644 => 100755 sound/soc/codecs/Kconfig
>  mode change 100644 => 100755 sound/soc/codecs/Makefile
>  create mode 100755 sound/soc/codecs/max98927.c
>  create mode 100755 sound/soc/codecs/max98927.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/max98927.txt b/Documentation/devicetree/bindings/sound/max98927.txt
> new file mode 100755
> index 0000000..ddcd332
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max98927.txt
> @@ -0,0 +1,32 @@
> +max98927 audio CODEC
> +
> +This device supports I2C.
> +
> +Required properties:
> +
> +  - compatible : "maxim,max98927"
> +
> +  - vmon-slot-no : slot number used to send voltage information
> +                   or in inteleave mode this will be used as

s/inteleave/interleave/

What is the range of values?

> +                   interleave slot.
> +
> +  - imon-slot-no : slot number used to send current information

Range?

> +
> +  - interleave-mode : When using two MAX98927 in a system it is

These all need vendor prefix.

> +                      possible to create ADC data that that will
> +                      overflow the frame size. Digital Audio Interleave
> +                      mode provides a means to output VMON and IMON data
> +                      from two devices on a single DOUT line when running
> +                      smaller frames sizes such as 32 BCLKS per LRCLK or
> +                      48 BCLKS per LRCLK.
> +
> +  - reg : the I2C address of the device for I2C
> +
> +Example:
> +
> +codec: max98927@3a {
> +   compatible = "maxim,max98927";
> +   vmon-slot-no = <1>;
> +   imon-slot-no = <0>;
> +   reg = <0x3a>;
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
