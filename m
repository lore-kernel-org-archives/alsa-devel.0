From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Thu, 17 Jul 2014 12:41:23 +0200
Message-ID: <20140717104121.GF17877@ulmo>
References: <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo>
 <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140717101723.GR17528@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Jones <rob.jones@codethink.co.uk>, Rojhalat Ibrahim <imr@rtschenk.de>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 11:17:23AM +0100, Mark Brown wrote:
> On Thu, Jul 17, 2014 at 05:55:36PM +0900, Alexandre Courbot wrote:
>=20
> > Right. It may very well be that a single flag specifier (as opposed to
> > an array) will be enough for this case. If you need to request some
> > GPIOs as input and some other as output then they are clearly
> > different functions and requesting them together would be an abuse of
> > the API.
>=20
> Not so sure about that - what about requesting GPIOs for a bidirectional
> bus?  Thinking about SPI bitbanging here.

Wouldn't you want to use a different means that the gpiod_array_*() API
to handle those cases? gpiod_array_*() is probably most useful to handle
bulk operations on a set of GPIOs that do essentially the same thing. If
you get and then need to index into that array to handle them all
differently then you don't gain very much.

Thierry

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx6hRAAoJEN0jrNd/PrOhBkcP/25fFCby+zd83WuQVZRLV2by
pD2RCEephts/LoqxgVCDQLurSvo0PnyuFH741l1bSj+STTfIpODZ/B7Ps9qSHLY6
66CEhoUcaxxvyc+K/ixkPJH2GsN4dNo6noWUJZ2LCGyPRef3956DD48D7bcZqbwO
snDBhDJFJFM1Um7yGT3BUkCMwjSqTpYkWQse/gcGRuC0e1z59Tl7nYxlLBmFNffK
AdO11OIAUvmt1gF371UxXXAZjyGNvkehz2J81RYOOrQ41Hr5rLFddVvwwolPdq3s
OzKVS28GFcrlv0eyjDOesMT26vj+nS5gC5ykcLne5ZfFqaY12PbYplb6t1N05z6e
TBiZJeiClLlYcqADnDwTC+fBZyzbyEDa+SlxqPXzsoE+GYFmx3MYEk+gj9g5LlWP
TWJco6uP6i/NEidYBZN4VAkYm5MDtiV+8+TZ3o2xGpMCIShml4DqBFlFqDpfB6/q
/zDVrgpAA10gw9V1+xIj1NRasKmJ5GGC6+r/lMiJ12N03xtWxp1gOxJOJP6jf7pu
AQwJtQVPbIchepNMGpMnRK+kOKvHX/9sPyp0NqG9aRy0cdaPraB4MuEJMR1qwxSs
P0xyjzY92oQ/mH/xHCLTod5/AVvUaZ8xRY64v9vRLzdjVRr5Ttj0HvUjKKxI4ewk
6EqYj2iHx0jf3Lzk6atF
=KrTp
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
