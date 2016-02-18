From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ASoC: adau17x1: Support platform data via DT
Date: Thu, 18 Feb 2016 08:37:35 -0600
Message-ID: <20160218143735.GS9654@rob-hp-laptop>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
 <1455627405-18155-6-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455627405-18155-6-git-send-email-andire-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal-VrBV9hrLPhE@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas =?iso-8859-1?Q?Irest=E5l?= <andire-VrBV9hrLPhE@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2016 at 01:56:45PM +0100, Andreas Irest=E5l wrote:
> Currently, it is only possible to configure HW-specific options to th=
e
> adau17x1 codecs by providing a platform data struct. With this patch,
> it is possible to provide the same data via DT instead.

The subject is a red flag. Platform data and DT properties are not=20
necessarily equivalent.

This should be part of the previous patch.

>=20
> Signed-off-by: Andreas Irest=E5l <andire-VrBV9hrLPhE@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/adi,adau17x1.txt     |  31 +++++
>  include/dt-bindings/sound/adau17x1.h               |  14 +++
>  sound/soc/codecs/adau1761.c                        | 127 +++++++++++=
++++++++++
>  sound/soc/codecs/adau1781.c                        |  48 ++++++++
>  4 files changed, 220 insertions(+)
>  create mode 100644 include/dt-bindings/sound/adau17x1.h
>=20
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt=
 b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> index 8dbce0e..6050602 100644
> --- a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> @@ -13,6 +13,32 @@ Required properties:
>   - reg:			The i2c address. Value depends on the state of ADDR0
>  			and ADDR1, as wired in hardware.
> =20
> +Optional properties:
> +
> + - adi,input-differential	bool to set if the input is differential
> + - adi,digital-microphone	bool to set if there is a digital micropho=
ne
> +				connected to digmic/jackdet pin.
> + - adi,micbias-vg		Microphone bias voltage

In what units? Add units suffix. Also, this seems like something that=20
should be common.

> +	MICBIAS_0_90_AVDD - 0.9 * AVDD
> +	MICBIAS_0_65_AVDD - 0.65 * AVDD

What does this mean?

> +
> +Optional properties (ADAU1361/ADAU1461/ADAU1761/ADAU1961 only)
> +
> + - adi,jack-detection	If present, configures codec to use the digmic=
/jackdet
> +			pin for jack detection. must provide one of
> +			JACKDETECT_ACTIVE_LO or JACKDETECT_ACTIVE_HI followed
> +			by debounce time in ms, which must be 5, 10, 20, or 40.

Seems like this could be common. No existing examples to copy?

> +
> + - adi,lineout-mode	Set output mode of the lineout pins.
> + - adi,headphone-mode	Set output mode of the headphone pins.
> +
> +The output mode must be one of:
> +	OUTPUT_MODE_HEADPHONE           - Headphone output
> +	OUTPUT_MODE_HEADPHONE_CAPLESS   - Capless headphone output
> +	OUTPUT_MODE_LINE                - Line output
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
