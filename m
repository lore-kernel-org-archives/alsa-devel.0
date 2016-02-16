From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ASoC: adau17x1: Support platform data via DT
Date: Tue, 16 Feb 2016 14:42:02 +0100
Message-ID: <4053162.T8NAULHXMt@wuerfel>
References: <1455627405-18155-1-git-send-email-andire@axis.com> <1455627405-18155-6-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455627405-18155-6-git-send-email-andire-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas =?ISO-8859-1?Q?Irest=E5l?= <andreas.irestal-VrBV9hrLPhE@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas =?ISO-8859-1?Q?Irest=E5l?= <andire-VrBV9hrLPhE@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 16 February 2016 13:56:45 Andreas Irest=E5l wrote:
> Currently, it is only possible to configure HW-specific options to th=
e
> adau17x1 codecs by providing a platform data struct. With this patch,
> it is possible to provide the same data via DT instead.
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

It would be nicer to avoid the need for the extra header file, those
tend to cause more problems than they solve.
=20
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
> +	MICBIAS_0_90_AVDD - 0.9 * AVDD
> +	MICBIAS_0_65_AVDD - 0.65 * AVDD

This could be an integer property, or possibly two (mutually exclusive)
boolean properties.

> +Optional properties (ADAU1361/ADAU1461/ADAU1761/ADAU1961 only)
> +
> + - adi,jack-detection	If present, configures codec to use the digmic=
/jackdet
> +			pin for jack detection. must provide one of
> +			JACKDETECT_ACTIVE_LO or JACKDETECT_ACTIVE_HI followed
> +			by debounce time in ms, which must be 5, 10, 20, or 40.

I would use one integer property for debounce and one bool property for
polarity.

> +The output mode must be one of:
> +	OUTPUT_MODE_HEADPHONE           - Headphone output
> +	OUTPUT_MODE_HEADPHONE_CAPLESS   - Capless headphone output
> +	OUTPUT_MODE_LINE                - Line output

And something along the same lines here. Or just document the three mod=
es
as numbers in the binding file.

> +#ifdef CONFIG_OF
> +static void adau1781_pdata_from_of(struct device *dev,
> +				   struct adau1781_platform_data *pdata)

You can remove the #ifdef here...

> +	if (!dev->platform_data && np) {

if you change this to=20

	if (IS_ENABLED(CONFIG_OF) && np) {

> +		of_pdata =3D devm_kzalloc(dev, sizeof(*of_pdata), GFP_KERNEL);
> +		if (!of_pdata)
> +			return -ENOMEM;
> +		adau1781_pdata_from_of(dev, of_pdata);
> +		dev->platform_data =3D of_pdata;

and here I'd try to avoid the dynamic allocation and just add the field=
s to the
driver private structure. You can copy the information from the platfor=
m
data in the 'else' path.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
