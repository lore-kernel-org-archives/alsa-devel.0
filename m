From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8782: add support for
	regulators
Date: Fri, 5 Oct 2018 12:44:20 +0100
Message-ID: <20181005114420.GC6266@sirena.org.uk>
References: <20181003193436.5281-1-daniel@zonque.org>
 <20181003193436.5281-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6195563253762890228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EC92F267925
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 13:44:22 +0200 (CEST)
In-Reply-To: <20181003193436.5281-2-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============6195563253762890228==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 09:34:36PM +0200, Daniel Mack wrote:
> Lookup regulators for Vdd and Vdda during probe, and enable them when the

Copying in the Cirrus people...

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

> component is linked.
>=20
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  sound/soc/codecs/wm8782.c | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>=20
> diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
> index 317db9a149a7..cf2cdbece122 100644
> --- a/sound/soc/codecs/wm8782.c
> +++ b/sound/soc/codecs/wm8782.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/device.h>
> +#include <linux/regulator/consumer.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/ac97_codec.h>
> @@ -50,7 +51,51 @@ static struct snd_soc_dai_driver wm8782_dai =3D {
>  	},
>  };
> =20
> +/* regulator power supply names */
> +static const char *supply_names[] =3D {
> +	"Vdda", /* analog supply, 2.7V - 3.6V */
> +	"Vdd",  /* digital supply, 2.7V - 5.5V */
> +};
> +
> +struct wm8782_priv {
> +	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
> +};
> +
> +static int wm8782_soc_probe(struct snd_soc_component *component)
> +{
> +	struct wm8782_priv *priv =3D snd_soc_component_get_drvdata(component);
> +	return regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies=
);
> +}
> +
> +static void wm8782_soc_remove(struct snd_soc_component *component)
> +{
> +	struct wm8782_priv *priv =3D snd_soc_component_get_drvdata(component);
> +	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +}
> +
> +#ifdef CONFIG_PM
> +static int wm8782_soc_suspend(struct snd_soc_component *component)
> +{
> +	struct wm8782_priv *priv =3D snd_soc_component_get_drvdata(component);
> +	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +	return 0;
> +}
> +
> +static int wm8782_soc_resume(struct snd_soc_component *component)
> +{
> +	struct wm8782_priv *priv =3D snd_soc_component_get_drvdata(component);
> +	return regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies=
);
> +}
> +#else
> +#define wm8782_soc_suspend      NULL
> +#define wm8782_soc_resume       NULL
> +#endif /* CONFIG_PM */
> +
>  static const struct snd_soc_component_driver soc_component_dev_wm8782 =
=3D {
> +	.probe			=3D wm8782_soc_probe,
> +	.remove			=3D wm8782_soc_remove,
> +	.suspend		=3D wm8782_soc_suspend,
> +	.resume			=3D wm8782_soc_resume,
>  	.dapm_widgets		=3D wm8782_dapm_widgets,
>  	.num_dapm_widgets	=3D ARRAY_SIZE(wm8782_dapm_widgets),
>  	.dapm_routes		=3D wm8782_dapm_routes,
> @@ -63,6 +108,24 @@ static const struct snd_soc_component_driver soc_comp=
onent_dev_wm8782 =3D {
> =20
>  static int wm8782_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
> +	struct wm8782_priv *priv;
> +	int ret, i;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(supply_names); i++)
> +		priv->supplies[i].supply =3D supply_names[i];
> +
> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
> +				      priv->supplies);
> +	if (ret < 0)
> +		return ret;
> +
>  	return devm_snd_soc_register_component(&pdev->dev,
>  			&soc_component_dev_wm8782, &wm8782_dai, 1);
>  }
> --=20
> 2.17.1
>=20

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu3TpQACgkQJNaLcl1U
h9BVdwf/T1ZcK80eTSmYNOsCcFDCLFwlMkzAEkre3urizJxvMqgDX/tO9D7TrjTG
KdIQi2WI5f40ObPUaH7ygwb8ZGhfTGMqmQxMnXRLYeeFGoVqHZa9lS2+3fbwoRE5
zjeLJY4C6B+9HcGABISUjdIF9FmGcY36agPpFGvodcyVdD53QJCjze+GOrSLWu+g
YrPJTSq/oa/NlyJsbHDrvECBQ49bN8fkL+RUVyzSRrahzkyt35aItx0QqI8NULXO
qYhHYj3e1Cqa7yHRSiE2CwdsJo+bO5MeL3vqIs0X/QZrqn6Y97UKUWcLoTK8G/uo
YdqGmVuWRtGMzRgMgBM59GQk5/u60g==
=NZ0q
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

--===============6195563253762890228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6195563253762890228==--
