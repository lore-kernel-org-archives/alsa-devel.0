From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix crash in asoc_simple_card_unref()
Date: Wed, 14 Jan 2015 17:18:38 +0000
Message-ID: <20150114171838.GY4160@sirena.org.uk>
References: <1421179417-23698-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2+IDmuKgu0wSQZlt"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421179417-23698-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2+IDmuKgu0wSQZlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2015 at 09:03:37PM +0100, Geert Uytterhoeven wrote:
> If asoc_simple_card_probe() fails, asoc_simple_card_unref() may be
> called before dev_set_drvdata(), causing a NULL pointer dereference in
> asoc_simple_card_unref():

Applied, thanks.

--2+IDmuKgu0wSQZlt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtqTuAAoJECTWi3JdVIfQSpEH/1dq2UiGyLtXhJQMMso1FSBf
SnjsqSpspcbV7bjMPJJWI/f92411NgMYKxcix0W9dTlma9qYYfqdNgaBIPYyq+T9
YHAqOCyLm44qJlnucGF+LCqPbrxUFo81y1LZjGGQDEHgSajqmmvA0CkxVzHEzCqH
QAbeAQkpDDShpbeDNlecZSx0YF4I1/hdnHGvthXNKIenT2NL+Zk9SOkSsFf0m2LP
s+PF8DbhyRbSR7o3I2IHIh7gWE+D/WhjqfrhQ9uSHY2T72PJOR6P1d+2SUER9wru
mANqDmJXZsk93Jm7b2wiHHyWiyKNxDQHNoVT4K+w1Nvo+0pRUsjFAyEpW8VFpms=
=gqwy
-----END PGP SIGNATURE-----

--2+IDmuKgu0wSQZlt--
