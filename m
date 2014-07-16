From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Wed, 16 Jul 2014 10:48:41 +0100
Message-ID: <20140716094841.GK17528@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel>
 <20140714183624.GV6800@sirena.org.uk>
 <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
 <53C4DF0D.8010208@metafoo.de>
 <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2014 at 04:28:33PM +0900, Alexandre Courbot wrote:
> On Wed, Jul 16, 2014 at 4:12 PM, Thierry Reding

> > Then again, maybe rather than add a new set of functions we should bite
> > the bullet and change gpiod_get() (and variants) to take an additional
> > flags parameter. There aren't all that many users yet (I count 26
> > outside of drivers/gpio), so maybe now would still be a good time to do
> > that.

> That sounds reasonable indeed. And preferable to getting an aneurysm
> after trying to spell devm_gpiod_get_index_optional_with_flags().

> This also makes the most sense since most GPIO users will want to set
> a direction and value right after obtaining one. So if there is no
> objection I will probably start refactoring gpiod_get() this week.

Yes, please!

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxkp2AAoJELSic+t+oim9spgP/RtWRfdFAg9bFnFyz5hQ3JYy
iYRmqDI36CrFwuUp0U/1Lg5sJpTjOPJ7eP53E6Fg8pBVfVYI0Q6gya94HYyXUCmP
HNyI6V0/ZgzQKjrjfq4E6h7o6pn2K/b7jU6GjdsfCWCCWOf32MOeSuGmB4+0phzE
zAnD8TzykPQpgF2ifVXnwi27ICk4XdmRsQNcLFySWnncLiKmFOHXaIxplJpA51NE
5jRI4y+wwdigbm8dLv/grF4NcNxrTqsYrYAKOiSLmNJSwSH+iJxO7JYxKaHzVqjL
kCOPxzWH0YGSiY74j+mWdPiD3fYjPnjaahp5zms7hOJHbU4WDVtStANhZDFx06LQ
Ik/1i3IwGudWJw1rdOoRA/2fKvds+axhqI+MZgQbciu7kd4rPTJzTmjvzARxSBCI
BSobvPNN271vBRFCJM1Irg1WlHw7YqTjAEfV8nKIEKCqv3IkXboKuOrMqiPKz6HM
kZ2i9KuVog33p9+qoDYlxFd/KKIC8LIp9XuahWUpWjFtbVweGJemTh/kl3YrSoN2
jo8qLhoBW+aEs9sBZ1LVgDqW1aAqWpJ3lE3lLUmCm3RVWxWs5GlCBEmo5i5hYgMM
FcNBh4HPY/zsb6gMc9PgX3WPcLjHY+cRkoTdmwchHrXTPVgmBh3YEgxU5TG/1/oQ
wzDEikuY31NiH6w6b9mP
=rpWh
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
