From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] ASoC: imx-sgtl5000.c: Add support for
 specifying PDCR_TXRXEN
Date: Thu, 24 Apr 2014 10:46:30 +0200
Message-ID: <20140424084630.GD7361@pengutronix.de>
References: <1398268218-31897-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7876079051763288063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 16CF02651F2
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 10:46:36 +0200 (CEST)
In-Reply-To: <1398268218-31897-1-git-send-email-david@protonic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Jander <david@protonic.nl>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============7876079051763288063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 23, 2014 at 05:50:18PM +0200, David Jander wrote:
> This enables effectively swapping RX/TX pins on the external audio port
>=20
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt | 4 ++++
>  sound/soc/fsl/imx-sgtl5000.c                                   | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.t=
xt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> index e4acdd8..3afea85 100644
> --- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> @@ -29,6 +29,10 @@ Required properties:
>  - mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
>  - mux-ext-port : The external port of the i.MX audio muxer
> =20
> +Optional properties:
> +- ext-port-txrxen : Flag. Set to swap RX/TX signals on external port (se=
t the
> +  IMX_AUDMUX_V2_PDCR_TXRXEN bit in the PDC register of the external port)
> +
>  Note: The AUDMUX port numbering should start at 1, which is consistent w=
ith
>  hardware manual.

You could also try to use the simple sound card and use DT properties to
setup audmux.

This is a configuration example for the audmux:
&audmux {
        status =3D "okay";

        aud4 {
                fsl,audmux-port =3D <MX31_AUDMUX_PORT4_SSI_PINS_4>;
                fsl,port-config =3D <
                        (IMX_AUDMUX_V2_PTCR_SYN |
                                IMX_AUDMUX_V2_PTCR_TFSDIR |
                                IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT1_=
SSI0) |
                                IMX_AUDMUX_V2_PTCR_TCLKDIR |
                                IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT1_=
SSI0))
                        IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0)
                >;
        };
};

Regards,

Markus

> =20
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 1cb22dd..b543fa6 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -63,6 +63,7 @@ static int imx_sgtl5000_probe(struct platform_device *p=
dev)
>  	struct i2c_client *codec_dev;
>  	struct imx_sgtl5000_data *data =3D NULL;
>  	int int_port, ext_port;
> +	unsigned int ext_txrxen =3D 0;
>  	int ret;
> =20
>  	ret =3D of_property_read_u32(np, "mux-int-port", &int_port);
> @@ -75,6 +76,8 @@ static int imx_sgtl5000_probe(struct platform_device *p=
dev)
>  		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
>  		return ret;
>  	}
> +	if (of_property_read_bool(np, "ext-port-txrxen"))
> +		ext_txrxen =3D IMX_AUDMUX_V2_PDCR_TXRXEN;
> =20
>  	/*
>  	 * The port numbering in the hardware manual starts at 1, while
> @@ -95,7 +98,7 @@ static int imx_sgtl5000_probe(struct platform_device *p=
dev)
>  	}
>  	ret =3D imx_audmux_v2_configure_port(ext_port,
>  			IMX_AUDMUX_V2_PTCR_SYN,
> -			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port) | ext_txrxen);
>  	if (ret) {
>  		dev_err(&pdev->dev, "audmux external port setup failed\n");
>  		return ret;
> --=20
> 1.9.1
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTWM9lAAoJEEpcgKtcEGQQ+q4QAJf9mr5Ka0KP+fCPrQLgu2Cu
JCcDphD9MwDUrthnOQ7rBc53munGIulPCizZSPnfuvoILiqqDdYmaxWezFChd1kG
IF2IZpd0qUJtpFnVUWYK32Q8x4YQw/iNvd0tQ/ROz3pySK7rVSUMsZQMAD+nFfGH
FSyTfYY64RDKeoiUFQKj2fTAH6NSLwgoOLTWTUtwfmdF4x3Kc08l4ty1pihDQWxT
xgim3m5NOQWZwBdXZYXlaMV1N/emw9iaPYpeQq4UjMNnAVegXiBzRIHQnfp1cP3W
SMciZjgqhoMacoDiPOuT1Bo5EhBZGRveMWrRWmAjHoBO2uxiCKnwbSGS4cmFf6bT
TdayaEIMMOkQL6FhF9Lcwsyt8jfL4hHje1OPN0bWQVTZSHdTEkMGe0Oh16fCoJLp
kMi3ijN44iyBqMzmH0agLBrkD591/P/p1Rssl6TGiYjz51gLob9XrQ6J5kof3NPg
ZPE6BQpmhikfJEJtQkLmHuz57xkHBsal0lTQhT0qMl3+us7pu8iPH840l2oh7EJ2
UcThK2ep4EB+sDvdFFKaqvIgZslaj8yXCcPR3oWPtdXRnaI+g5d7H1V5Kb2yurQX
8wwQxEHzfdRM0K78JXBeB40rYAVpdiyGQc7l5XJqsAdr3Xw4jC8Xch9+6Qq5etDa
Lk3f8kj7fVg6NPXtxqyS
=m583
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

--===============7876079051763288063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7876079051763288063==--
