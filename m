From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/15] ASoC: dapm: Add locked version of
 snd_soc_dapm_xxxx_pin functions
Date: Tue, 18 Feb 2014 09:30:30 +0900
Message-ID: <20140218003030.GH2669@sirena.org.uk>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392655903-24537-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <5302417B.3070408@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5302417B.3070408@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 06:06:03PM +0100, Lars-Peter Clausen wrote:

> Hm, this is a bit confusing. For other functions in ASoC when we
> have a pair of functions with the _locked suffix and without the one
> with _locked takes the lock, the other one doesn't. E.g.
> snd_soc_update_bits_locked. Here we do it the other way around.

Yes, this is definitely confusing.  The existing naming might not be the
best but making things inconsistent isn't going to help the situation
either.

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAqmjAAoJELSic+t+oim9VdEP+gNbJ7YwWxY7RhGla7HeeK1R
aMOUkadbnupVs2mIeZO0SdXHf/q6o9z6JH7/fpuOiHEPnpM0a+o5Z64kwrwLJKdi
ZsjmgjsfnVlYWZ/PmIBIlkZgNr4nOHXoIBjSF+7o8xTaLo031jMlFwlFHCjarqY4
WO/MHOI0z10uGd0RdsqLB5iUnUHm2gw4B2Egejo3Rt1ERfs7yPR8TT5Y3+dyMSYr
pyc+I7oerf60+07nDCaW1xI+m52MUbzinx38yDAeb+YLFd9+5kX/JLVFhGwFS2hC
mwQJeqyOkzh72crrRfMeRbIAIEzBslxVQGF3pGVtL+NdEVVGNcBcAwhFR0XqURHO
Jota7VmSNA858L9eCtAXffRLA5RvKNtCURywIivpfCdCfzrgQkgmlYrrh2GpQuCX
PKlSTnLyy9gzH1yVbyLd238h2m6qyrvV6wK5U9KKqaUgOg54Qd4oKaRL3gTqOJKj
o3a2x2zcXDJ49ShMe5LzAbqR1GXyv6nZ2xcdRiaaCM6xPgUa4miKToedBtuYBNYB
8gyGTySU+D3rTteJ9BWUNtf+nI36wGqneVgRy1Jl39tHME9EkcpAY2VaiVTTgFrA
n+XSHJJIrRioF5504qhfiIb9WkUoZ9FmDb2AWvJly1LB+9QZLdPtY7oiL+j/YJo+
QT5wP+9wRcbuG2qjas9w
=Tga9
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
