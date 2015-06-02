From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 1/4] ASoC: arizona: Export functions to control
 subsystem DVFS
Date: Tue, 2 Jun 2015 21:07:42 +0100
Message-ID: <20150602200742.GP14071@sirena.org.uk>
References: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+IuRATsqV0DV21e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--x+IuRATsqV0DV21e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 11:53:33AM +0100, Richard Fitzgerald wrote:

> Previously this was being done by having the booster enable bit set
> as a side-effect of the LDO1 regulator driver, which is unexpected
> behaviour of a regulator and not compatible with using an external
> regulator.

Applied all, I added a note explaining where this came from.

--x+IuRATsqV0DV21e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbg0NAAoJECTWi3JdVIfQLOQH/1VSpfNSm35qo2+jxdyfCmNO
tHI4Lv33Y76CiQSSusm3MF7TvM6Y4YcS1G/p9gr75pnEPwzPQ4xYqipGNV52wFIa
YOKuX0OixwUIzaKsLmCM+D+AaQHfcjr11Ps5P4TV4pqVAPajpZ9wqFplm80wPY7o
4R+tt2wfMAundjSiQO6M+sjDmIUGw17tVIi0TKHlrSesz+0mhSSskRlRVNqgkBZX
Y7XhEGupLtfj462wxSpw0Z7D/Pm8mEfLyx2z3C4RbUWIGxIljR+dZhqjBqAHyw4P
HFgwLpkajOOQ3QWQhl8mX7eTcbkXY+wQmOBOt+XPKeNM7nFw0DLN8G1BPPK6AVk=
=tKoc
-----END PGP SIGNATURE-----

--x+IuRATsqV0DV21e--
