From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: PATCH: wm8731 - reinitialize regmap cache
 after hardware reset
Date: Thu, 28 May 2015 20:26:20 +0100
Message-ID: <20150528192619.GE21577@sirena.org.uk>
References: <CA+abuVebbr9Cif_SfB+JcNhUOMV70fdWa-Q-nk+gFv9H5MRtgQ@mail.gmail.com>
 <1432831966.2726.63.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3102985641756801826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC802260502
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 21:26:26 +0200 (CEST)
In-Reply-To: <1432831966.2726.63.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Sergey Kiselev <skiselev@gmail.com>, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============3102985641756801826==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FVVc0UeP3VjfaANg"
Content-Disposition: inline


--FVVc0UeP3VjfaANg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 05:52:46PM +0100, Liam Girdwood wrote:
> On Thu, 2015-05-28 at 09:34 -0700, Sergey Kiselev wrote:

> > Another way to avoid this issue might be resetting the codec in the
> > *_spi_probe()/*_i2c_probe(), so that it only gets reset once when
> > codec is loading.

This is the correct way to fix the issue, this is a result of a partial
conversion to the device model.  There is no point in reseting the
device if we also rewrite all the register values.

--FVVc0UeP3VjfaANg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZ2vbAAoJECTWi3JdVIfQ1MEH/1SsZ6iL7fmPRi3EIrkABV8Z
jd3SbUksYr1IQ9a6PMdmo86ltE1B1Uajf1nxbLIQ4VAluVLyooy9MUH4hyfcS22i
zXx2HS+/lG9e/hFo4eklnKL1aGK0kakgdAdENU9lYGilgl4/CN8bp8Lnn9n0TUwS
yuShTTA0i6yfqIu6X683jQ2G6tFX8/P60gw0xVZjdyMZ2Hiz0OymLa7CiwmI4FfZ
y4pfsPV5oe0IIboOtKFjwshCtGZJXQB7Zr470QGaKkPlDxHfOrgTWCLfl9k5QyA8
kKp2rBDKC4F019Uv9W6kjIe1KCR9wmegQKW0159EaCmzYCFHAj1XcTnvSuVBL70=
=MLuz
-----END PGP SIGNATURE-----

--FVVc0UeP3VjfaANg--

--===============3102985641756801826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3102985641756801826==--
