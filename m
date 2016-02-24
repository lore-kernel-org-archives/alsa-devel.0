From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Make logging of FLL calculations clearer
Date: Wed, 24 Feb 2016 13:08:32 +0900
Message-ID: <20160224040832.GQ18327@sirena.org.uk>
References: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vbJ+yrvy98/8rWIL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vbJ+yrvy98/8rWIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2016 at 02:16:32PM +0000, Richard Fitzgerald wrote:
> The debug logging of FLL calculations was confusing. Values were
> printed in hex without indicating this by a leading 0x, and
> despite these normally being required in decimal. Also where the
> register value isn't the actual value (it s a power-of-two or
> 0 means 1, 1 means 2, ...)  it was unclear whether the actual or
> register value was shown.

I think that stuff was originally based on the way the datasheets quote
things:

> -	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",

the hex(decimal) but there is certainly very familiar from some of
those.

--vbJ+yrvy98/8rWIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWzSy5AAoJECTWi3JdVIfQk6UH/3y/31T3LN0JK1TYge8m+Nmo
jOhXzMCy5fP7NnIRHHRizcvAHXStU49WfjN+hDg4jQ3gQGp8QHJvhKk6Y/a4UaJb
kQ2z+LREErCA4z/GnmIWnuNdevVYv2bI8k/UTVSuzVwe2HIjLBLA/cFVHYwxr5Ok
2sofdz7wRVszh1Zuu7Hm4RgASi8FV6alf+pdwy+qpXZP4fKxfq/mqn+qOTmU0LX5
x6IV2zbOCplhYlqr5Saourt432FpHmgERN7V4rrqdtrNVepk9NL7xjpbbUHnFidL
XOLJQZOKp0eUhPaRN7roztYkFIj+ylv62TtssOakeS4TcNjCVYwY/sGCIaxCmsk=
=K1CN
-----END PGP SIGNATURE-----

--vbJ+yrvy98/8rWIL--
