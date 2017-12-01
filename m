From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short circuit
 detection support
Date: Fri, 1 Dec 2017 13:39:30 +0000
Message-ID: <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mkiku65tfcdxl625"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171129213300.20021-17-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--mkiku65tfcdxl625
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:32:57PM -0600, Andrew F. Davis wrote:

> +static irqreturn_t aic31xx_irq(int irq, void *data)
> +{
> +	struct aic31xx_priv *aic31xx = (struct aic31xx_priv *)data;

There is no need to cast away from void, doing so can only mask bugs.

> +	ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG, &value);
> +	if (ret) {
> +		dev_err(dev, "Failed to read interrupt mask: %d\n", ret);
> +		return IRQ_NONE;
> +	}
> +
> +	if (value & AIC31XX_HPLSCDETECT)
> +		dev_err(dev, "Short circuit on Left output is detected\n");
> +	if (value & AIC31XX_HPRSCDETECT)
> +		dev_err(dev, "Short circuit on Right output is detected\n");
> +
> +	return IRQ_HANDLED;

This will report the interrupt as handled even if we didn't see an
interrupt we understand which will break shared interrupt lines.  At the
very least we should log other interrupt sources numerically.

> +	if (aic31xx->irq > 0) {
> +		regmap_update_bits(aic31xx->regmap, AIC31XX_GPIO1,
> +				   AIC31XX_GPIO1_FUNC_MASK,
> +				   AIC31XX_GPIO1_INT1 <<
> +				   AIC31XX_GPIO1_FUNC_SHIFT);

Is the interrupt only available on GPIO1?

--mkiku65tfcdxl625
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohW5EACgkQJNaLcl1U
h9BpyQf+Mwg+vQDCu4H9o5W/ESJMk8yrbgIaM1BV8y0FAMgTPXnLDJnmw7nxYgq3
8xbE6oBZ6NI7GX1mCw6kUXNkdq7uT+qzJFCkmUqRtMTQZvpIoUy3DR3s9KtIlVMR
vIGrEZ3/2ix+O2K6aSBbrrTNKqpRva4MQkbzJ82qmcZTWwrFCfmoem7oUxZATAHN
GqsOHfnCKXSzFpn/z0h+7Ijh0u5lAED/IyLK4EafarYdLnwfL2NspNZtdNiRBGhs
2YTEbF0ZvKk2PTsOADihRUar+RMBXK65V8ZwZc6o8pTRuNhdcm3k849RJK5uyHxr
yQYJOaKaNlUtlGfQRXuTeCyiCif5Uw==
=0WYc
-----END PGP SIGNATURE-----

--mkiku65tfcdxl625--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
