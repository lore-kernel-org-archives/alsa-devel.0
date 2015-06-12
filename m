From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: mediatek: Add machine driver for MAX98090 codec
Date: Fri, 12 Jun 2015 14:13:25 +0100
Message-ID: <20150612131325.GA1921@sirena.org.uk>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
 <1433946276-25969-3-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7Us/CiahOveQMyD"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433946276-25969-3-git-send-email-koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--C7Us/CiahOveQMyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 10:24:35PM +0800, Koro Chen wrote:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
> @@ -0,0 +1,17 @@
> +MT8173 with MAX98090 CODEC
> +
> +Required properties:
> +- compatible : "mediatek,mt8173-max98090"
> +- mediatek,audio-codec: the phandle of the MAX98090 audio codec
> +- dvdd-supply : the phandle of regulator to supply 1.2V
> +- avdd-supply : the phandle of regulator to supply 1.8V

Why are these supplies part of the machine driver?

> +config SND_SOC_MT8173_MAX98090
> +	bool "ASoC Audio driver for MT8173 with MAX98090 codec"

Why bool?

> +	codec_node = of_parse_phandle(pdev->dev.of_node,
> +				      "mediatek,audio-codec", 0);
> +	if (!codec_node) {
> +		dev_err(&pdev->dev,
> +			"Property 'audio-codec' missing or invalid\n");
> +	} else {

Isn't this a fatal error?

> +	/* set codec DVDD voltage */
> +	reg_dvdd = devm_regulator_get(&pdev->dev, "dvdd");
> +	if (IS_ERR(reg_dvdd)) {
> +		dev_err(&pdev->dev, "failed to get dvdd\n");
> +		return PTR_ERR(reg_dvdd);
> +	}
> +	ret = regulator_set_voltage(reg_dvdd, 1220000, 1220000);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Failed to set dvdd: %d\n", ret);
> +		return ret;
> +	}

No, this is not appropriate for a machine driver - this is something the
regulator constraints set for the board should do.

> +	dev_info(&pdev->dev, "dvdd = %d uv\n",
> +		 regulator_get_voltage(reg_dvdd));

Don't include debugging stuff like this please.

> +	ret = regulator_enable(reg_dvdd);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Failed to enable dvdd: %d\n", ret);
> +		return ret;
> +	}

IF this is for the CODEC then you should add regulator support to the
CODEC driver.

--C7Us/CiahOveQMyD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVetr0AAoJECTWi3JdVIfQp30H/0XfBCaZMqd788UfEvBzrmni
b9vtnYGE2d9GAQJnlmT/aBDDbMHkIyR3F1kKfva96anOk22vrNp15tgLOGDuv6EQ
ItMgWSNVZnT4AQbTLvHuVEMfmGuyhdbqGaSHMogNLCWnoZc1xytFoSO+DotbCgrV
6iHWfiSC3B7QQTeDSyiM1bvizpLYq6f74tTMg8lYVbOvdk0vy0b9N0XFGJn3W0Qd
CYYmf1mn7vauRslW1db3zkmY/TlyF9n5L15yChIh6Zq9Mkvn46TopvI0RV3M3gH4
cq5Zn76LeguQkTjq79y70nZK9KVfU2W9AMsR7CXFtiujK5ZMb/XmGNTIdtmP7Ak=
=nC9U
-----END PGP SIGNATURE-----

--C7Us/CiahOveQMyD--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
