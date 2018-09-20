From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Date: Thu, 20 Sep 2018 09:19:05 -0700
Message-ID: <20180920161905.GM2471@sirena.org.uk>
References: <20180912121955.33048-1-cychiang@chromium.org>
 <20180912121955.33048-2-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSJGZE3ajDCqFLUt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912121955.33048-2-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--VSJGZE3ajDCqFLUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2018 at 08:19:55PM +0800, Cheng-Yi Chiang wrote:

> +	/*
> +	 * Release reset GPIO because we are not going to use it.
> +	 */
> +	devm_gpiod_put(dev, max98927->reset_gpio);

There is no need to do this, it's still potentially useful information
for userspace and it's also going to surprise anyone who tries to modify
the code to use this function at some other time (eg, when coming out of
suspend sometimes it's useful to reset the device).

> @@ -934,6 +1010,8 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>  	if (ret < 0)
>  		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
> =20
> +	list_add(&max98927->list, &reset_list);
> +

I'm not seeing any locking of this list.  This also feels like something
that shouldn't be in this driver but should be pushed up a level - it's
only going to do the right thing if the reset line is only shared with
other devices using this driver, if someone does something like put the
CODEC and an external speaker amp on the same reset pin then it won't
work.  I'm not sure where the best place to do that is; drivers/reset
isn't really for this use case but feels right perhaps?

Can you perhaps split the basic reset handling out from this list
handling as a separate patch?

--VSJGZE3ajDCqFLUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlujyHkACgkQJNaLcl1U
h9BuFQf/Q5y6HzLzXxcbLIk/wGLLN6BWn65TTUXkpZyWSPWDu5ZTISi6mKO3ahpT
xlqQXIWuY9T8DPL1tKUch40051dJExbQbd3y6JWUbQN0y0nqpKaCBhiqEYfG0Svj
CT90BvsEfhHsBvx+gWw6DXWuRLjik9AKjgPBqkNtU3wSB06xWZoDXQpJC/5nCdns
CmN/Y7UpGa5e5JAYGyYSeDu9Hna1Opb2nG+pDLqbgbmHpiTTo5Slc5etpavVl4rJ
+ivSqktKhd882USl//O6LCP3A32VW+b8eG9LbCAe0PwQxfMaUIwVMm985PzvV5ld
qtwLIvOYlMpZAZ2VBU4xrTxij2ab2Q==
=80Zv
-----END PGP SIGNATURE-----

--VSJGZE3ajDCqFLUt--
