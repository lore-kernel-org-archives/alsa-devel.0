From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Thu, 17 Jul 2014 12:05:40 +0100
Message-ID: <20140717110540.GS17528@sirena.org.uk>
References: <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo>
 <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk>
 <20140717104121.GF17877@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dngyMJhgXGAL5Gb8"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140717104121.GF17877@ulmo>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Jones <rob.jones@codethink.co.uk>, Rojhalat Ibrahim <imr@rtschenk.de>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--dngyMJhgXGAL5Gb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 12:41:23PM +0200, Thierry Reding wrote:
> On Thu, Jul 17, 2014 at 11:17:23AM +0100, Mark Brown wrote:

> > Not so sure about that - what about requesting GPIOs for a bidirectional
> > bus?  Thinking about SPI bitbanging here.

> Wouldn't you want to use a different means that the gpiod_array_*() API
> to handle those cases? gpiod_array_*() is probably most useful to handle
> bulk operations on a set of GPIOs that do essentially the same thing. If
> you get and then need to index into that array to handle them all
> differently then you don't gain very much.

For set and get, sure - but it's still useful to be able to do bulk
requests for GPIOs especially since that's the only bit of the interface
that requires error handling.

--dngyMJhgXGAL5Gb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx64BAAoJELSic+t+oim9mpwP/Ax9gXcoZuAluXZwvDnHbFaS
G6uQ6ZfqxfuqD4QeQjX8BhBH9r5YIbFRwyUgwFAy/tumoOffgiYssvn/sjf3XK1j
pIiaOVaL5C8ThTAf1d3Fad7M/h+kxdDcUus+v0JOoriqs+fa2vV6HdQBXQVdxra3
8ZPARmMInw3tqbK8Qj0jmlUfVAOlv9f4O39kMtg0tHexuU1M6bILs9mClCmLlPp4
EVlGlRWgCtpiO1ZXzCrakZE+VSlBvjTtTi+4PGUglMmuqBq/bPAIUdSUsO0x4s5S
mL6R7o8qMPZM+uCBKOcxa61fUr2hnfoK2cIZiFdquWtphrjLzAlCzWnnGxynpSqR
rhNBq8kKaUABpDfEIEnPiqF/+AdLdw65/zi41skQAbpAaImQZ+6b1c3zo3rQ3DUX
qBtTzzzTmatOOOUyslvqwGkA0faWF8mRxUCzlytJ9CvBnabzg6E7L6IMTwWWsaSP
zdS+axozOOh22WKPp9hHIQa64y9UphMz+S08WKfJObcM1Svtu1I8/QfFIbhMUqAB
hzzZgcNOWCp4NIV2k7/3X5LxBL3MPSgbjTGMObXCl9RlHLtU/NWs0/kYknMJLTwc
MDisdZfKsH3WI11x8VxoWZbAyQDv22PZjli8mflrP4GxPBhqVkng7IOmHsjIRv8j
k1NQZzHfxrEkVhBosTN0
=VQOW
-----END PGP SIGNATURE-----

--dngyMJhgXGAL5Gb8--
