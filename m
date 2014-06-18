From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine driver
Date: Wed, 18 Jun 2014 11:02:33 +0100
Message-ID: <20140618100233.GE5099@sirena.org.uk>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
 <1403063242-20840-4-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HhaQrpaE6DOVGqQz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403063242-20840-4-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--HhaQrpaE6DOVGqQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2014 at 11:47:21AM +0800, Sean Cross wrote:

> +config SND_SOC_IMX_ES8328
> +	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
> +	depends on OF && (I2C || SPI)
> +	select SND_SOC_ES8328_I2C if I2C
> +	select SND_SOC_ES8328_SPI if SPI_MASTER

I expect this is going to break configurations where I2C is modular and
SPI is enabled since it'll try to build in the I2C bus interface.

> +static int imx_set_frequency(struct imx_es8328_data *data, int freq)
> +{
> +	int ret;
> +
> +	ret = clk_set_parent(data->output_clk, data->codec_clk);
> +	if (ret) {
> +		dev_err(data->dev, "unable to set clk output");
> +		return ret;
> +	}
> +
> +	ret = clk_set_parent(data->codec_clk_sel, data->codec_clk_post_div);
> +	if (ret) {
> +		dev_err(data->dev, "unable to set clk parent");
> +		return ret;
> +	}

This should be handled by the clock bindings not open coded in the
driver - leaving this here most likely won't play nicely when the clock
API can configure the defaults for the tree.  There is supposed to be
support for setting default clock trees going in (or perhaps already in)
the clock bindings.

> +	data->codec_regulator = devm_regulator_get(dev, "codec");
> +	if (IS_ERR(data->codec_regulator)) {
> +		dev_err(dev, "No codec regulator\n");
> +		data->codec_regulator = NULL;
> +	} else {
> +		ret = regulator_enable(data->codec_regulator);
> +		if (ret)
> +			dev_err(dev,
> +				"Unable to enable codec regulator: %d\n", ret);
> +	}

No, this is broken.  The CODEC should request its own supplies which
need to correspond to the supplies the physical device has and failing
to get the supplies should be a fatal error unless the device works
without power (in which case why bother enablin them at all?).

> +	ret = snd_soc_register_card(&data->card);
> +	if (ret)
> +		goto fail;

devm_snd_soc_register_card().

--HhaQrpaE6DOVGqQz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToWO2AAoJELSic+t+oim9ZT0P/1ZvxbCnrhs5KM9wbzdHChln
oxBhfsB6MGybo+7SGxTXBVqo2tm43SlzaH1YYhRsA7hKbkpIelXEcyeN0yYGzXWn
yx4OczymMBWrigBQMI+ToikxFSIE3FqSAm1BtL83ZIgyXnBxbuy0D4tO6N0Mz+Kr
yvSD7Gs74bcpHEhsiG15a9vUXygPxixNxqGKdxsvMcZpjqgjgu8mHtgirLxxVJzf
LnLyTelqNS88a+YYP5ERmSEpSZDh3VJy6aFA2bGqIQfFgNCJGVPaFjAa0dRKOo3X
vDUxbdWVhqCbft8kijewVF/2kCTm0XpSDO4ENHAAyAnIcDIYc4L2yy+7vUWd9pfY
oW1RaGO/pLv9D39hajmZSo4NJ28sFFx6li91LJnNPOswWvWA8dqZiFjw5cptUkwe
Tcuk34mFNz4hSYdCphBEnPNAvwj8UDZJiiwUo8u9rZc+eImA7FoJSgo2urY+rK7Y
UzPcLdsWHmw83+zUtYzP9IabkA/gmcTy4BgGTB4z3vX6oIrohzmZVuh18zBjzIZG
67RqD7Qw0OjkQx4OtI6s5v5QXVWGssvELxDiKJSMFnV86Vy3o1XdfMcxlOMIekvl
vF+YMw0CQ3z6/XA0ZtdqGNhYAWJfD1HHOCcQkHiJZQ29SPRj9m8BtNPnhG7xtasw
bgdLSLboOYnye4+HMKhh
=jXNn
-----END PGP SIGNATURE-----

--HhaQrpaE6DOVGqQz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
