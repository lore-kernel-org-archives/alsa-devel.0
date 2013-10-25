From: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
Date: Thu, 24 Oct 2013 22:39:10 -0500
Message-ID: <8309A8FC-87E3-4479-BAB7-DD9B818D56BE@codeaurora.org>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com> <1382616832-23593-2-git-send-email-denis@eukrea.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382616832-23593-2-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Oct 24, 2013, at 7:13 AM, Denis Carikli wrote:

> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Eric B=E9nard <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
>=20
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> ---
> ChangeLog v6->v7:
> - The cleanups went into another patch.
> - The support for fsl_ssi doesn't depend on dt anymore.
> - platform_name =3D "imx-ssi.0" is still set when in non-dt mode.
> ---
> .../devicetree/bindings/sound/eukrea-tlv320.txt    |   23 +++++
> sound/soc/fsl/Kconfig                              |    5 +-
> sound/soc/fsl/eukrea-tlv320.c                      |   88 +++++++++++=
+++++++--
> 3 files changed, 107 insertions(+), 9 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv=
320.txt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/eukrea-tlv320.tx=
t b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
> new file mode 100644
> index 0000000..8791037
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
> @@ -0,0 +1,23 @@
> +Audio complex for Eukrea boards with tlv320aic23 codec.
> +
> +Required properties:
> +- compatible : "eukrea,eukrea-tlv320"
> +- model : The user-visible name of this sound complex.
> +- ssi-controller : The phandle of the SSI controller.
> +- audio-codec : The phandle of the tlv320aic23 audio codec.
> +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
> +- mux-ext-port : The external port of the i.MX audio muxer.

mux-int-port & mux-ext-port should probably be vendor prefixed. (I know=
 there are examples in tree where this isn't done).

> +
> +Note: The AUDMUX port numbering should start at 1, which is consiste=
nt with
> +hardware manual.
> +
> +Example:
> +
> +	sound {
> +		compatible =3D "eukrea,eukrea-tlv320";
> +		model =3D "imx51-eukrea-tlv320aic23";
> +		ssi-controller =3D <&ssi2>;
> +		fsl,audio-codec =3D <&tlv320aic23>;

this is inconsistent with the binding description above, is it audio-co=
dec or fsl,audio-codec?

> +		mux-int-port =3D <2>;
> +		mux-ext-port =3D <3>;
> +	};

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
