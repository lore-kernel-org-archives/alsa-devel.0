From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Tue, 15 Jul 2014 11:39:38 +0100
Message-ID: <20140715103938.GJ6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel>
 <20140714183624.GV6800@sirena.org.uk>
 <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LkBseQZEL/3d2JPd"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--LkBseQZEL/3d2JPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2014 at 04:36:20PM +0900, Alexandre Courbot wrote:

> Direction and initial value, on the other hand, are clearly properties
> that ought to be set by the driver itself. Thus my expectation here
> would be that the driver sets the GPIO direction and initial value as
> soon as it gets it using gpiod_direction_output(). In other words,

Well, it's a bit of a mix really - from a hardware point of view they
normally are actually often fixed.

> there is no replacement for gpio_request_one() with the gpiod
> interface. Is there any use-case that cannot be covered by calling
> gpiod_direction_output() right after gpiod_get()? AFAICT this is what
> gpio_request_one() was doing anyway.

Right, the original goal was to provide a better interface for
requesting a GPIO - it saves a lot of error handling code throughout the
kernel and avoids the possibility of bugs due to users forgetting to
mark the directio for the GPIO.  Having a direct replacement also makes
conversions to gpiod easier.

--LkBseQZEL/3d2JPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxQTnAAoJELSic+t+oim9MVIP/10zkYMLCdAJVQnZZUBU8mWy
fuBhPCbPrneue715Ok/i/G24Yo2IMfkEjyYCpvEBVD1vMvLzUR9WVz0HorPjJoDQ
hmDxQyYjkpUeYwDsZFKjF15fINLb7LX9/WS5JhYnJz6NMhi7ZF7nheYDUowC20J+
2JZcZNcUqQrKoz9d/MqREXTdSsTKk0DKwRdIHPNWvaE5dYCNccLRN61GgFdAv/NM
GLXwcEz/wxqGrHmnJ2NURZAqSBJZ53ucMRY1orN1PXLPHnolmvKr10Z8VwIQnxH/
XmTXiTrb39KH8grdfYIs8tO9Bbi1N6wJnQ7cdu90OngmsdDaW7m8yCBUPESCv4gg
snlbWjRBl3/ZF9pobcHw1zvPkGZ1VBjHXPQCgDMmpfX3GQstF/6UzCcmor/C9dNm
KleqIMB6ftohJjaR/cynnJXSJsFC86UkKgmC1q9uNF7+ng1kKgNr4/nKS96msuIK
ka1TxSaaWeh+N3c8Eppg94NywOl2fb7ty47xSDsmgCV3+qzKA2YeACSKLiO8lH1A
nTx1N75cVjUBZjILgYvO2PFYRVGQuG52AMz83nTFFHijsjBpgrSFTkahyNbJFuN+
Agzsy3hybDpxb39XjFMm7HxUhlWBsPK+yl8wAahItpjdgOZ/Yea8uHXL+fDyqNvE
x8Vd3E56YHasjaHbUKZI
=Lk2/
-----END PGP SIGNATURE-----

--LkBseQZEL/3d2JPd--
