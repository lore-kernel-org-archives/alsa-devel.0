From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: Add initial PCM1862/63/64/65
 universal ADC driver
Date: Thu, 30 Nov 2017 12:20:35 +0000
Message-ID: <20171130122035.wgj2jpvzx6md5gnl@sirena.org.uk>
References: <20171129185015.5304-1-afd@ti.com>
 <20171129185015.5304-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqvz43tvr3dfqugf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171129185015.5304-2-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--sqvz43tvr3dfqugf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 12:50:15PM -0600, Andrew F. Davis wrote:

> +	case SND_SOC_BIAS_STANDBY:
> +		pcm186x_power_on(codec);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		pcm186x_power_off(codec);
> +		break;
> +	}

> +/*
> + * The PCM186x's page register is located on every page, allowing to program it
> + * without having to switch pages. Take advantage of this by defining the range
> + * such to have this register located inside the data window.
> + */

That sounds like a normal page register?

> +int pcm186x_probe(struct device *dev, enum pcm186x_type type, int irq,
> +		  struct regmap *regmap)
> +{

> +	ret = regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
> +				     priv->supplies);
> +	if (ret) {
> +		dev_err(dev, "failed disable supplies: %d\n", ret);
> +		return ret;
> +	}

> +static int __maybe_unused pcm186x_resume(struct device *dev)
> +{
> +	struct pcm186x_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
> +				    priv->supplies);
> +	if (ret != 0) {
> +		dev_err(dev, "failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}

> +const struct dev_pm_ops pcm186x_pm_ops = {
> +	SET_RUNTIME_PM_OPS(pcm186x_suspend, pcm186x_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(pcm186x_pm_ops);

There's no code in the driver that enables runtime PM so this isn't
going to do anything.  I'm also not clear that the power management
handling is in general joined up - we leave the regulators disabled
at the end of probe, relying on the bias level configuration to reenable
them but then the runtime PM configuration also tries to enable and
disable them.  Based on what I think the intention is I'd suggest
removing the bias level handling and then having probe enable runtime
PM with the device flagged as active, letting runtime PM do any
disabling if the device is idle.

I'd also expect to see some system suspend handling.

--sqvz43tvr3dfqugf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlof95IACgkQJNaLcl1U
h9BVUQf9FtRiBp4vQBIt44dGOnF0uRKfbIdmGWkkLn55DpiwswvuSmkjxvBU7xQH
V9ipI/EC5ViTbUUDEl7KNSEolfYEJTIP6ZF5mFUjwyq/BLwRZiUWJbHaYpUVH8zd
GHn5hGgldErT8IGKZ+XAOLg6iuTqIY9w0rYdmckfATLbE5srmKA7g/mpsdGxkk0q
fsaRVM/4NrdHlLPOpmgeWbfhmpL5SeamXmUWt12mqXPMlvK5t6OJq1Qpzl8K8i9U
FyxkHoT63nOlahzvh6NZPfDrOwQ5PeCVmOITzwkoBqdaTuWG/3oBzuVElrwDJEJ9
kX8Exq2dAx6vyDcF81tpgXqDX9/ocQ==
=IQSt
-----END PGP SIGNATURE-----

--sqvz43tvr3dfqugf--
