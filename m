From: Mark Brown <broonie@kernel.org>
Subject: Multiple DA9055 chips
Date: Mon, 1 Jul 2013 17:48:33 +0100
Message-ID: <20130701164833.GL27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZaNUQUWeUBsaJYg9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Dajun Chen <david.chen@diasemi.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--ZaNUQUWeUBsaJYg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It seems we have two drivers in mainline for da9055 on I2C.  We've got
one in sound/soc/codecs/da9055.c and one in drivers/mfd/da9055-i2c.c,
both registering themselves identically.  What's going on here?  Is this
a combined CODEC and PMIC, has someone decided to release two chips with
the same name or is one of the drivers misnamed?

--ZaNUQUWeUBsaJYg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIbBAEBAgAGBQJR0bLeAAoJELSic+t+oim9qeAP9RXgq/jL9ooeltPA6ZysfnDM
0XH3OomLPXWiy6i1dpy2xU43Ese9Ak7toSVA3u7rV2aOvGoUeoEmBErp2I5AkaML
rz7qShxwV5iTC/fcgSsEY2KErG3HSQ//kORa0v7a6puo8yjlJWqLwW953lSu+WZN
M6GxBlC0wCPGakNukvcn8xM1WyoiZkSKVOZq7vHPC6J6RWwdec8OaDQgxMs9QXSZ
mNZiAH78aYrCEVcU4OPhMWg7G4JSxptv83Syxb+ctc+mZEHeP+MYXsLBHjxHFrMb
VlWZooEATYVsC/iKFYXQgsmiCojIe44Plm9i99DJZrrI37IRskF087RO7y99G/Sn
3NpWt2s6yCWs2VGQ08Z8dEaimYvipVt5lcFAIgTlrOe7v09cRE26ITJt5Xp1Vfng
09DnWbaqJ3zsc6zVad6vcEDrdYg1E+XkYVXb4ACesOnDQNcuD/INKCX0IF1ArQ7v
B01XXeUdAqOFm7ATn4XFNWBM1y+qmMLmUAH/lSyb4LSHDN2LLjFLAJkeYKoFMsAA
eEuLV4VfN/eGUAO9FHFVQhmblviKsklGXUNr8oxdZcUVUquQ7Rs7QYUzy5WumnWd
A96x9GK4Trr43IW+oQkzmlw0hF7wPzMjYE+xO0Ky/kFjZJYShLJRyNYixVr8OHlI
xhwqX8NcsSNoW4y3HgA=
=gzFp
-----END PGP SIGNATURE-----

--ZaNUQUWeUBsaJYg9--
