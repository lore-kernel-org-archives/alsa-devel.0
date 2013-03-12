From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 07/10] ASoC: phycore-ac97: Add DT support
Date: Tue, 12 Mar 2013 18:59:22 +0000
Message-ID: <20130312185921.GX19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-8-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4198827805944969795=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362940391-8338-8-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============4198827805944969795==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4PR/+zdSfVlxyWed"
Content-Disposition: inline


--4PR/+zdSfVlxyWed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2013 at 07:33:08PM +0100, Markus Pargmann wrote:
> Add devicetree support for this audio soc fabric driver.
>=20
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  sound/soc/fsl/phycore-ac97.c | 148 ++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 125 insertions(+), 23 deletions(-)

A binding document is mandatory for new bindings.

> +#ifdef CONFIG_MACH_IMX27_DT
> +		.cpu_dai_name	=3D "10010000.ssi",
> +		.platform_name	=3D "imx-fiq-pcm-audio",
> +#else

This looks wrong, at least the CPU DAI name should be being looked up
via the DT.

> +static const struct of_device_id imx_phycore_ac97_of_dev_id[] =3D {
> +	{
> +		.compatible =3D "phytec,imx27-pca100-ac97",
> +		.data =3D (void *)MX27_PCA100,
> +	}, {
> +		.compatible =3D "phytec,imx27-pcm043-ac97",
> +		.data =3D (void *)MX27_PCM043
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, imx_phycore_ac97_of_dev_id);

It seems like we ought to be able to describe the properties of the
boards in this class rather than just enumerating the boards.  What are
the differences?

>  MODULE_AUTHOR("Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> -MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
> +MODULE_DESCRIPTION(DRV_NAME ": PhyCORE ALSA SoC fabric driver");

Please don't make up terms like "fabric driver".

--4PR/+zdSfVlxyWed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3sDAAoJELSic+t+oim9wMwP/RoGVToEOungyy+z0NHpmXAQ
lfElfdmodx3Qz2lj9cgfWtJduBdDucgqtMb67RvbVc3ILn8Urz6ofXTwSuyeoN0N
lY584ERPAnvof+J2SG3qbeQyEFn6GuHCW2PJwuepiAQMMPfyZFbjUoNhScmoGiqw
5z0kzjvTDEQmSQQycBqs8Zc+uEkwZqulc/aMaBd2UATFu+8ZkJZtyQdxT9/r5G8p
rB0zENwGrKJyiStLNdc/lW4BcAw4eTfyiKB6TMMEduJjUhVXg5KqheTDfreER+n6
de8o+lBiQ6U304QilfPqV2+YSKGqyVNVszERzNNoUQ12fhIJ9HNp24RVa+kqNMIN
k+jfC/HO3kWruddm91yd8jw46N+HSnv4waeLt2ChxPxnSxh6BPEkD54LWYau0SO3
LuJ8W0PUN+7LGkNbBayA+piziRxW74mpcSN6UQRLEU7RCgT9sVKCtkHNYmB5NzlC
Xu/XgDrhu1gw+Kk8aYMn8EWKA9RttuuUiFZFASKbnkSYVkRT6nXZORQgXhuBr1k+
rgT2572QI6haGWirQCBZptVjkq1ecIaowmuoJPt+CgaF2u0gQ5NVnZs3smlmO4EO
60CboHfUv0coBDqcbvqOMdHcYIp84YamBsK1y/5YCW3HE2mTPwj0ZkZzD5DdQmTW
tPJgTw7MsD7ikicVUHu1
=2kNB
-----END PGP SIGNATURE-----

--4PR/+zdSfVlxyWed--

--===============4198827805944969795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4198827805944969795==--
