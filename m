From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Wed, 11 May 2016 16:29:50 +0100
Message-ID: <20160511152950.GL6261@sirena.org.uk>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6795229924200944031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F3A82607C8
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 17:30:32 +0200 (CEST)
In-Reply-To: <1462892797-1147-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============6795229924200944031==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Content-Disposition: inline


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:

> +		if (master) {
> +			switch (max9860->pclk_rate) {
> +			case 12000000:
> +				sysclk = MAX9860_FREQ_12MHZ;
> +				break;
> +			case 13000000:
> +				sysclk = MAX9860_FREQ_13MHZ;
> +				break;
> +			case 19200000:
> +				sysclk = MAX9860_FREQ_19_2MHZ;
> +				break;
> +			}

What if we have another PCLK rate?

> +#ifdef CONFIG_PM
> +static int max9860_suspend(struct device *dev)
> +{
> +	struct max9860_priv *max9860 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(max9860->regmap, MAX9860_SYSCLK,
> +				 MAX9860_PSCLK, MAX9860_PSCLK_OFF);
> +	if (ret) {
> +		dev_err(dev, "Failed to disable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max9860_resume(struct device *dev)
> +{
> +	struct max9860_priv *max9860 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	regcache_cache_only(max9860->regmap, false);
> +	ret = regcache_sync(max9860->regmap);

We didn't go into cache only mode on suspend?  I'd also expect to see
the regulators disabled over suspend and some system PM ops.

> +static int max9860_mclk_rate(struct device *dev, unsigned long *mclk_rate)
> +{
> +	struct clk *mclk = clk_get(dev, "mclk");

Request resources on probe, not at some random point in driver
execution.  That will mean probe deferral works properly and that we
don't get broken devices instantiated in userspace.

> +	ret = clk_prepare_enable(mclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable MCLK: %d\n", ret);
> +		clk_put(mclk);
> +		return ret;
> +	}
> +
> +	*mclk_rate = clk_get_rate(mclk);
> +
> +	clk_disable_unprepare(mclk);

This is definitely confused too.  Enabling the clock to read the
programmed frequency is at best odd, and obviously if we do get the rate
this will ensure that MCLK is disabled which probably isn't ideal.

> +err_pm:
> +	pm_runtime_disable(dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(max9860_probe);

I've no idea why this is exported...

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXM0/tAAoJECTWi3JdVIfQc64H/1mudSoNJ7vsOOxo60u5wlNb
3LtkUY+5wwENNG0hhHX7I/BHssna1OL5eX1vFhjtqZ3QMUvtvgPH89kY0PItIqF8
8D4GdAZzjyg0Qxb6na3w7ub2LpKTIy3htoIWLi6Ct2pbtinfj0Qt6TvYLIhblzc0
VaHwEwnRdw5t2KHX0kJQbzKUmIgWx/f19BkdbSw1lx5/3zD1SjqeDyrJF7yjR/Ox
7HhRHGRhaAXObsLbe4YVtNbVqWSreV24xMFkIth5VLJwQOV0YGwKiwOrHc1N+kKS
K6VJz0mknA2NJXdtss+MjcsubEGFh2PE/8frOdZNQbhB9fqeuCCzQSmPAMWUfuY=
=9tXP
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--

--===============6795229924200944031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6795229924200944031==--
