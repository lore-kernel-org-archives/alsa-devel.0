From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/17 v2] ASoC: pxa: tosa: Update locking around use of
 DAPM pin API
Date: Thu, 20 Feb 2014 19:54:48 +0900
Message-ID: <20140220105448.GS2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-18-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0iSpYRf9rOurbk0+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-18-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--0iSpYRf9rOurbk0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:28PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--0iSpYRf9rOurbk0+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBd70AAoJELSic+t+oim9978QAJLH6BZBfVw9/VCLbTJs2PSk
Jxnw5SSHkwLE5LIBjjSIbsbeiW5MvN0r1DKkXsDlS1l0IhSRydZ9/tbjCupzLtnj
lGan/DIsYFFo7fPGf7+LB8K7zKZLOwREt8laCLxvJVotmTIMGzeXFSQxTyBlQmGa
m1vkIOjNpeZhkVOzQCO3ISjc4F4e37ZFmbK5qMa5KW5jbDERYbKXR2Y/WJ6+Pyg/
NVfPZbRybo4pY52cvji3GRbWo8oTDo6anh08Nr6gcLCbq0q52TQwI//jAjaAw4rQ
11UL3fQQ4TkuEmRIp1ya+hs/J3LXa8Z6FqVF9Y7FNBSX17wciFiL7LCSUxUYNXpj
VZde/z0GXh0TgfYgtIjdbQwmvd/C7bcxOO9oFUS41Gex/AwIHBBdFbNq5NpdZSTJ
U5XLhhLcvPMBcSFGKi9zKGbcW5v1iN2UUhuuov0yYkGwBh/iYBSpUSZLpeKDF/R+
2+OuZMdyFrfRoKfW2uigN1M/8ZOOdkGAWtRftPrbUOAVPFbBgyOmpWLb+hid0i2S
GeaDpQqVM/u32Sd7Uk81yieuEkjXK+q6ZOQCWKn74vPn3pLKn9sN/6Sr7mJQR6CR
dDiITngAKFAK1Ou4fgttV79Isfod+h6XGhO6JvbNt/isgiZ8oUotI78P9OfnDtDR
QEEy6oCOIGnQ0gvoC4he
=J702
-----END PGP SIGNATURE-----

--0iSpYRf9rOurbk0+--
