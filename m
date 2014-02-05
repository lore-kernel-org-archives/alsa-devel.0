From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] ASoC: da9055: Fix device registration of PMIC and
 CODEC devices
Date: Wed, 5 Feb 2014 18:38:14 +0000
Message-ID: <20140205183814.GI32298@sirena.org.uk>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391614923.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2014 at 05:48:32PM +0000, Adam Thomson wrote:
> Currently the I2C device Ids conflict for the MFD and CODEC so
> cannot be both instantiated on one platform. This patch updates
> the Ids and names to make them unique from each other.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8oUTAAoJELSic+t+oim96VoP/1zBrLQmM7cWSXMxK2kl+5wR
Qz0bZD7TA0E9UMpn7MJBzFB/N6KZ2THQhl0qujW+UGa6etd+UN4v2V24ItA7Zpad
Qko0TZn52adJpi1+iktqZqhilDf3ivvwFl9zs6cs5+sh73r/PdsvPQKVkkhjgbfF
iF48GxW1cf9N9WHrK1nK/qXRJs5hluHC8rhaufF4tlADMR9GtdSRI1glyIrY7KCx
uvpwRjLHZaIkHjCFP9UBzHd+ebQTguB36Y8MDUlvwZwiaiBxZ2Ta2mNi8LimJFWX
vDPJMW8dO2qMl46xgQGMICl2Z/z9Q5YFtsAf3je2PW5ejXMilj6b3CxWBy/bLU5N
/F0wEqKW7RG49wqJLrIsXtsR74EmYGUVNorcBEgV3hheX4jZnBF/8rKGBALalxY/
yAApYJ/S8YPPPA2YFwLLumD4rB5okvivufIxepAPTJqZ9Eg9z+vSulOOgZROBPQD
cImpLg1XlyRqrFbsWaBCAXguontn30mPEUo7e0/wfENurDZCZTvL0kRSXhXjS3EG
gQmcVvQuj+WHg3rEQQ7jBiC8zmMvmBayQEt1Iisqy0+8rqqVsHg8iJcK1Wyt2qWn
zAI/NIsY/G9lyLDd4fqeqKQf6CK0sKIZIEgsQGh22iZ84wPnO8nx91PtdMOkTDr1
O2h5sKKkC9g/29dI3wjT
=ZMIu
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
