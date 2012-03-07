From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] ASoC: omap McBSP: Clear rx_irq at probe
 time for OMAP4
Date: Wed, 07 Mar 2012 10:48:28 +0100
Message-ID: <1331113708.3539.10.camel@mattotaupa>
References: <1331111839-14778-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1333855307720838962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F763103F3F
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 10:48:33 +0100 (CET)
In-Reply-To: <1331111839-14778-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko@alsa-project.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1333855307720838962==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-0Z9c1jh4mihbKvbPQ+O5"


--=-0Z9c1jh4mihbKvbPQ+O5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Peter,


Am Mittwoch, den 07.03.2012, 11:17 +0200 schrieb Peter Ujfalusi:
> On OMAP4 we have one interrupt line per McBSP port.
> At proble time tx, and rx irq value will be -ENXIO,

s/proble/probe/

> and only the tx irq will get corrected.
> In omap_mcbsp_request if the rx_irq is not 0 we proceed,
> and try to request the interrupt, which will fail on
> OMAP4 (rx_irq =3D=3D -6).
> To avoid this error, clear the rx_irq at probe time
> on OMAP4.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/mcbsp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 21dbb05..c3e31de 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -958,8 +958,10 @@ int __devinit omap_mcbsp_init(struct platform_device=
 *pdev)
>  	mcbsp->rx_irq =3D platform_get_irq_byname(pdev, "rx");
> =20
>  	/* From OMAP4 there will be a single irq line */
> -	if (mcbsp->tx_irq =3D=3D -ENXIO)
> +	if (mcbsp->tx_irq =3D=3D -ENXIO) {
>  		mcbsp->tx_irq =3D platform_get_irq(pdev, 0);
> +		mcbsp->rx_irq =3D 0;
> +	}
> =20
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
>  	if (!res) {

Reviewed-by: Paul Menzel <paulepanter@users.sourceforge.net>


Thanks,

Paul

--=-0Z9c1jh4mihbKvbPQ+O5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk9XLuwACgkQPX1aK2wOHVilIACeJQiBFCmKZ9HWzAr8+NXK5SRW
/9oAn0YINPFzXTPotMp3s5mx2xj1AOrd
=yRqx
-----END PGP SIGNATURE-----

--=-0Z9c1jh4mihbKvbPQ+O5--


--===============1333855307720838962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1333855307720838962==--
