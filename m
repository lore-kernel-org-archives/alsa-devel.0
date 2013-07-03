From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
Date: Wed, 3 Jul 2013 17:17:27 +0100
Message-ID: <20130703161727.GS27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5011663300994395071=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-9-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============5011663300994395071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uxt9koO+4Cm8N9x"
Content-Disposition: inline


--3uxt9koO+4Cm8N9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2013 at 03:20:27PM +0200, Markus Pargmann wrote:

> Notes:
>     Changes in v9:
>      - Fix blank line at end of file.
>    =20

Please don't include enormous changelogs like this, they're just noise.

> +config SND_SOC_PHYCORE_AC97_DT
> +	bool "SoC Audio support for Phytec phyCORE (and phyCARD) boards (device=
tree only)"
> +	depends on MACH_PCA100 || MACH_PCM043

Is there an actual dependency on the machine type?  This seems wrong for
a DT driver.

> +static struct snd_soc_ops imx_phycore_hifi_ops =3D {
> +};
> +

You shouldn't have this if there's nothing in it.

> +static struct platform_device *imx_phycore_snd_device;

This shouldn't be a global, it should be in driver data.

> +/*
> + * Pointer to AC97 reset functions for specific boards
> + */
> +#if IS_ENABLED(CONFIG_MACH_PCA100)
> +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> +#else
> +static void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> +static void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
> +#endif

> +	if (of_machine_is_compatible("phytec,imx27-pca100")) {
> +		phycore_ac97_reset =3D pca100_ac97_cold_reset;
> +		phycore_ac97_warm_reset =3D pca100_ac97_warm_reset;
> +	} else if (of_machine_is_compatible("phytec,imx35-pcm043")) {
> +		phycore_ac97_reset =3D pcm043_ac97_cold_reset;
> +		phycore_ac97_warm_reset =3D pcm043_ac97_warm_reset;
> +	} else {
> +		dev_err(&pdev->dev, "Failed to set AC97 reset functions, unknown board=
=2E\n");
> +		return -EINVAL;
> +	}

These functions have no reason to be anywhere except in the driver and
really you should just be specifying which pins to use there - ideally
via pinctrl but I don't think i.MX has adopted that yet.

--3uxt9koO+4Cm8N9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1E6UAAoJELSic+t+oim9iuYP/1FyXHMnCOP1ujKM70fbeU0I
KwxXwQbWJjke0qOBBuCn7Mm8whLWj24ZeXeTKuHma45tcRTZ59fH2Eizx/Mi2O0v
kJ8XrMaB5brljuDnaJJ+0Co05qlZ+lZUg5dcDMBT7wpoKPCx40Q0bmPw0j4tLAK6
3c9PnSk3uPLq4+ReXZgqiqP1xtOz5dIw6pGUgxk8SpmudgHzZn49uVp6Gnd/4SYv
eswn+R3vJMkA0Lh23NhDshfHDxTVaCQ2KFJWV0+R0YEzf05w1Is9POBhV4gxLYz2
C0LQrO6NoaSggQzTBE/IvvecBhA4gjfuw/3msv3aQed/ZV55mnJ8ErrDhN5ATE9G
Fd9sTV58m5QBxA1aT6e1ZMIIYWVVjKPtrH36igluf6lq4EBq/tiYiWzD+UTcY7ra
nU8kb01xe9bXjc/S1HT6KP5CqQNw+i0OxGwH5E2euQ+CyJszA5fGUVmLuOeMcExH
+3ojeEP6QmjJ2cJKeftmfzkwsmH6u83SxUfBARdPYWwqAFEbzo0SK0WgNN5cc8Yk
UEIJLeSJco+r/aceLKeYZaitQ9Lg9GYhzVZ3Qnc9Py6pAZm6ay9yfCMhEJpCsDds
o+cTRGVCgHQJ67gwisyG0Ry/PtPt+OCe5N4V5HeeA7PNfO7/ReIFnKM7Scox0i6S
phnq9ilZekhP91QhkXrW
=xHL9
-----END PGP SIGNATURE-----

--3uxt9koO+4Cm8N9x--

--===============5011663300994395071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5011663300994395071==--
