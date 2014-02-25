From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da732x: Mark DC offset control registers volatile
Date: Wed, 26 Feb 2014 08:54:34 +0900
Message-ID: <20140225235434.GH2927@sirena.org.uk>
References: <1393210853-32246-1-git-send-email-broonie@kernel.org>
 <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
 <20140224124230.GF25940@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376BAD405D@SW-EX-MBX01.diasemi.com>
 <20140225012138.GK25940@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376BAD41AF@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376BAD41AF@SW-EX-MBX01.diasemi.com>
Sender: stable-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 04:13:02PM +0000, Opensource [Adam Thomson] wrote:
> On Tue, 25 Feb 2014 01:22:04 +0000, Mark Brown wrote:

> > Refactoring the offset correction to happen once on startup would solve
> > the issue since the cache could just be bypassed, though you are likely
> > to find that there is some run to run variation for the callibration due
> > to effects like thermal variation and simple measurement errors.  Still,
> > the effects are typically very small.

> I have to agree, the variation won't be great. If it were then you'd see
> problems for example when keeping a device awake for prolonged periods and
> during fluctuations in temperature. As far as I'm aware issues like this have
> not been experienced with this device so I think it's safe to make this a one
> time thing at startup.

OK, so in that case how about applying the patch I sent for now (since
it should make things better for stable users) and then refactoring to
do the callibration at startup with cache bypass enabled for a proper
fix?

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDS02AAoJELSic+t+oim91qQP/1MzyrOl0qQ5H1A0ZXeiYP5K
0ut2YtiMM34ueUI8xO6azUteKavQm49YF56P9mqgjdcoKu24GUIeyDbkerl8XQTo
aLhGPVCuHbt1jORzt7F+PdnEpZvTcoklgJGIHhNC8Q4Faa2Dzky03gg/YjdieIa6
tZbTai7s7jOHgpzr3aQ4+24tpjuYfTr58uZ4TOJ8/vr1thwa0WpSHvu68Bq6+zRn
O4IDe0+3lYrW6mXzgzmPZdsRgIdXPfo7IsS7Rlr4TQFddyg++lkNEViMb9g+bLlA
NjxaLrOd+yunI8U+n0IfUbNFOBhc1UyoTGeB6uaLc+Y1mb08CNkRG13ftBxTCD2M
v508HlSzYG4hBohcC1u7Lhb2pWZCUZhLdgJYHuBhdE3mwfgGYD99zojWvAPrqGSQ
d5iIGEqyZVVnm4ZXIcYiouTFXZBTv8SgOI2bAvDGzBPgkxoIIVrR4xss/+HWlCXC
ygWalRDcvFFXaqYVVtRQZjoHHY/Z3jMZq2qmvow0ogZD8+X1waKVcZo/WKp3gAQB
2tnZLUAHKcdZz0mDSubeauDy3cy0fQ5UfevIXvf+WxkpmfaFCGEkQvup2CokTU6u
JA7KIDdLE6If1Mz9TL0lVNcHSu1HENQRX2k/AeG0bs9eNywclxgjXrzn66C5mOdZ
5juCCouY+43RP4EngdPm
=S8aE
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
