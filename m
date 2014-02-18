From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/4] ASoC: tlv320aic32x4: Support for
	regulators
Date: Tue, 18 Feb 2014 10:27:25 +0900
Message-ID: <20140218012725.GS2669@sirena.org.uk>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4732190284542483565=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EE9C7265079
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:29:23 +0100 (CET)
In-Reply-To: <1392631460-32002-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4732190284542483565==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GFHULmA0mO3kKGOo"
Content-Disposition: inline


--GFHULmA0mO3kKGOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 11:04:18AM +0100, Markus Pargmann wrote:

> +	if (IS_ERR(aic32x4->supply_iov)) {
> +		dev_err(dev, "Missing supply 'iov'\n");
> +		ret = -EINVAL;
> +	}

This won't work with deferred probe and is ignoring the error value
reported by the regualtor API.  It should pass back what it was given
and still needs to handle deferred probe even if it's happy for a
regulator not to be there.

> +	if (!IS_ERR(aic32x4->supply_iov)) {
> +		ret = regulator_enable(aic32x4->supply_iov);
> +		if (ret) {
> +			printk("Failed to enable regulator iov\n");
> +			return ret;
> +		}
> +	}

dev_err().  It would probably be easier to put one of the child
regulators you did get into supply_iov instead so that outside of the
probe you don't need to worry about which is actually there.

I'm also not seeing any disables prior to remove.

--GFHULmA0mO3kKGOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArb5AAoJELSic+t+oim9gt0P/RTiNzOReSlkTzR8wXPzc1aE
ORTvS64Ydx/251lcrF+i10gqlvLSAN0lj7gd4ZXmc6jRre7yfRU3SWWLIdiNcSTV
D3hnrox/yT70uGJdjN16UvR1vJSJKFcbbrWvkBlFQEdTiPzyJyML5H1FU+z+gTKb
uZWvriXxMO3xaqJIrkZgRm8WthRUFb2fEtjiJiPLvTRMLSfsHQXhmbXOXvEA0hQO
Wvv+yhErNrSF5NzwfjrBjthbD/RJe3PQlMkrVhZmSYamcAqI2OflqWBqEAdmwOZ6
lwb+r4C04vquDLxAg+dQmn5ZKdHSuauO9qZ8MKOtgOOH6su9/sfS/Ax9N+UWvCyy
DrsMIf2VPIGvLNZi5FBGERvVQuVXLugUmUn3kYVjrDgmI2QKmyxQk7wsiUfqF1ag
tEwZ03ESYdUxL/elB2yVrKwTN7OVaMxfE/uT8i2HeybFPq4ZyL8i94kqhEjvdjdB
nrTFiM4c0OHaoCiu4skfyBr1+8yXkaaP62nTU9M/pCuI+St9sgkZVAp6v4pRmLzC
0H4eWk8x1IdpenecJrbx5do/sTu4bKjoVxBxqhWTdA6DdPdNEUt8SX26eahdpmjD
bMO1c6zI/cCgJVH5kUjcXaZrdses1qkCBRr/YvDGGUy3ZHRcAqF3Q/U7fJrBab1e
Eq0mOe8ipWMgDnbTYIbP
=r8jb
-----END PGP SIGNATURE-----

--GFHULmA0mO3kKGOo--

--===============4732190284542483565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4732190284542483565==--
