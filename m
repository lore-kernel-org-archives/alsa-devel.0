From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Thu, 17 Jul 2014 11:17:23 +0100
Message-ID: <20140717101723.GR17528@sirena.org.uk>
References: <53C4DF0D.8010208@metafoo.de>
 <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo>
 <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KQSGybwJm5+gcNx6"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Jones <rob.jones@codethink.co.uk>, Rojhalat Ibrahim <imr@rtschenk.de>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--KQSGybwJm5+gcNx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 05:55:36PM +0900, Alexandre Courbot wrote:

> Right. It may very well be that a single flag specifier (as opposed to
> an array) will be enough for this case. If you need to request some
> GPIOs as input and some other as output then they are clearly
> different functions and requesting them together would be an abuse of
> the API.

Not so sure about that - what about requesting GPIOs for a bidirectional
bus?  Thinking about SPI bitbanging here.

--KQSGybwJm5+gcNx6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx6KwAAoJELSic+t+oim9YskP/2XBPXubFb540mtLrUM0CCyk
EyRpMv9b48huDTsPeYjZ1nI3LFdj+Lg1pSR3gK4dZvPpV4Vb6/gneORgiD9Af+gE
xLY7UScLPEQhKoZNoHUOBazV0cRnjZa4Hd9gXtj+RxGYwAV0sa1lrzqLsx6oxAOh
5odgbmd0QVo9CQ9cRMXyU5gBll5+cLnbEvdQ1D/+dRJc/HyXEuD5BazINYqP3TaZ
PvaNZC3uHIwVkeX1LcxIml8mspboWyyAEa6WFdBCyFDOdaZZHVRTBJ9K+9BcJ1Gn
693WEdjmRijcxDR9542J8dQjmbIGFxEt7UtTTD8SjEM2e/DVo795xYK1myZdpFZa
jXcBSzO9hqICUe/XC/WiSBTiqJJfHghszpVKQ9ccZu+Qi+9WsiFnawm7iJzwgyDO
bW+MTMVrev3gYNrLMB+sopapLeAFVhNsejZ1I84RVK4mcUg4x8A3ccLX1fc+z0rM
DastOf0qyrwWqZWxl6a6YdmJrw6/eARkkqu0g6AI8LmNKvqF2nBuFeVfEYtQ7GeF
+/QTYckkxKxxcnqhqJYFHeAg81KpxpoT6lSaRII4lcXNoZPvFw+jFmTArdU0R7W1
Frko4hmGGlCxsw/AGM71wobtD6uc3O4t+rMU5WMfJ4BFIP1aPfClaQDMHSJx+gNV
82DVbvqU035lzWzMjdHw
=RuD1
-----END PGP SIGNATURE-----

--KQSGybwJm5+gcNx6--
