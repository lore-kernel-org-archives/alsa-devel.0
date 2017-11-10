From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add initial PCM1862/63/64/65 universal
 ADC driver
Date: Fri, 10 Nov 2017 21:21:50 +0000
Message-ID: <20171110212150.fyxqtoh5nusirslp@sirena.co.uk>
References: <20171110195711.24210-1-afd@ti.com>
 <20171110195711.24210-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k3w4ke7dyh63td57"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171110195711.24210-2-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--k3w4ke7dyh63td57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10, 2017 at 01:57:11PM -0600, Andrew F. Davis wrote:

This looks mostly good, a few small issues though:

> +	dev_info(&i2c->dev, "%s() i2c->addr=%d\n", __func__, i2c->addr);

No need for this as standard, we already have I2C level logging
facilities if they're really needed.  It's OK to do things like log chip
revisions read back from hardware but this is pure software.

> +static const struct snd_kcontrol_new pcm1863_snd_controls[] = {
> +	SOC_DOUBLE_R_S_TLV("Analog Gain", PCM186X_PGA_VAL_CH1_L,

Volume controls should end in Volume to tell userspace how to handle
them, see ControlNames.txt.

> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
> +				      priv->supplies);
> +	if (ret != 0) {
> +		dev_err(dev, "failed to request supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Reset device registers for a consistent power-on like state */
> +	ret = regmap_write(regmap, PCM186X_PAGE, PCM186X_RESET);
> +	if (ret != 0) {
> +		dev_err(dev, "failed to write device: %d\n", ret);
> +		return ret;
> +	}

We didn't enable the supplies for the device before we reset it, if the
device was powered off then the write will hopefully not work and we'll
get a spurious error here.  The driver should bounce the supplies on at
least long enough to do the reset, it's not ideal but it's robust.

--k3w4ke7dyh63td57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloGGG0ACgkQJNaLcl1U
h9DVJgf+IoG8uVUySa7bC03HnYfu2JE0hSsoGo+TOR+oZfrOHEaAioeTJcxwSR60
5r9FErPeMCjGTdvjXjQ4yt87Bre9wAYkgCyyuq+ZfLlxH4FCgj1dMuOeQRTj0uaX
4RqSRk6vA69/+JNJV4NOHV0PhEFMi3ioYFOXFUIUB/eiXfu73NwY+WA5DzsP7rRy
WOM3FjT1ZGwLy1Mc5ptkUbKiW+W0Ow99RZ4wGgcejY1McS54Yid2gsdFOmqYWnuh
BpZQC73uMuTEv3MgxnbHkuNerqVLpkkiVxLdQZO2U4w0N4NVRpiL8YTwld+8Ozm5
xobFX1fGg/PxC1lCQBGZ9EwTvjj3/Q==
=5oWf
-----END PGP SIGNATURE-----

--k3w4ke7dyh63td57--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
