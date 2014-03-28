From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: ak4104: add regulator
	consumer support
Date: Fri, 28 Mar 2014 11:53:41 +0000
Message-ID: <20140328115341.GF30768@sirena.org.uk>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
 <1395952936-10670-2-git-send-email-zonque@gmail.com>
 <20140328112345.GZ30768@sirena.org.uk> <53355C92.3000105@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6478098041542759297=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73145261987
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:54:07 +0100 (CET)
In-Reply-To: <53355C92.3000105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6478098041542759297==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PgLV2f+xYr9y+IUc"
Content-Disposition: inline


--PgLV2f+xYr9y+IUc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 12:27:14PM +0100, Daniel Mack wrote:

> Yeah, I noticed this one is unfortunately broken since a while already
> due to other changes in ASoC. I'm working on fixing this in parallel,
> but it's legacy hardware which get less attention than it should. I'll
> fix up the constraints along with that.

> Want me to resend with a DT bindings fix, or can we do that in 2nd step?

Do it in a second step if Raumfeld is already broken anyway, I'll go
ahead and apply.

--PgLV2f+xYr9y+IUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNWLBAAoJELSic+t+oim9328P/153bQWm2A/EiGuz+G4mcoel
3VLTHtwDFBrmYO0UV6yyGaRns8yg0ruvJ0z6xI+UEokl0Og6ix/5vw6Jk84VXafy
lVO/8ix+A3CK+364R/DF4ZPduafIu+HFLxWJN7HKU2GftpQMyuYuQ2pGmxfQBwvd
In19zsWnHm256/8W9iolMo7foWWyUrFXDShmgCan8DtbqEOPrVvIh/kcIVzQX52X
IyCli5QigIOh11u8ltInJP6dh1ohv8Yu7cDvFTGDmEtvntxID06sUrLBAOU8Tp2F
mBN17UlgaO0vAKaX0ScBJhuZ04lwRIED8VkrHOdY+34Vj4uwUBuu8QDArhC+TZNR
vjGWUe613v0RypGQDusdxXb1wXJuokV6jg+XJdBaaJL/Y2DNfjVOfwan55vc016U
e/wWmjXpE96dUyYL+8yTov+EeGBvcpMgJjRRqgCm38NfAuQAdwIclO4Lb4zaQ/Js
5n0rOR8cDrHXYGsF1y4x1PfIGHD2N2jXbFprHO+wtsfU3j/2LGLhsUVwWMsQ9mA0
C6QiWuL+lfordczYbeCoNlYyCfpP4wx6k7i36jtxn9q7OMSeS9OAUpTsyJGGnKTp
W1hKc5WNm2Wpt7Xk12nvMgtgwuNCSkNEbsPHjFm3Fp11dzY9lzJcVvPmQELYWEV5
OAgEzC6hpvGwjB/3srU3
=9V27
-----END PGP SIGNATURE-----

--PgLV2f+xYr9y+IUc--

--===============6478098041542759297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6478098041542759297==--
