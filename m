From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sirf-audio-codec: Simplify the new
 bitmask value in regmap_update_bits
Date: Mon, 26 May 2014 17:00:53 +0100
Message-ID: <20140526160053.GH22111@sirena.org.uk>
References: <1399537789.21710.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7218836460369267613=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24BE4265488
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 18:01:25 +0200 (CEST)
In-Reply-To: <1399537789.21710.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Rongjun Ying <rongjun.ying@csr.com>, Barry Song <baohua@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7218836460369267613==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hf3PDeZ9a40C1ZbL"
Content-Disposition: inline


--hf3PDeZ9a40C1ZbL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2014 at 04:29:49PM +0800, Axel Lin wrote:
> Having the binary ones complement operator in the new bitmak value makes the
> code hard to read.

Applied, thanks.

--hf3PDeZ9a40C1ZbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg2UxAAoJELSic+t+oim9+08P+QFYwZJin0OeB3s1cAKWiekT
+n7EWo3mKzmHKDoJroiF0RO2k+zPUUcQQdsaPRJYe+DU2XvQDvddN1GwD3xANP2t
Qcg1WTWva1BvBqfshwnZheMevgTV0Nx8ni9WvKnvv7nlIH1tE3y4ofCBFduU40uk
dqiY5prBUunvAXawf3fa5djjIL7EGhpa3okim4aW2sLa3+97dOwc/ofaV7NFjUJ7
QuoonJYmFLPKr5upyaD77nBtr32yR3Nnw0dErscyw5OSxEFQrtdItalJCDzTDSZJ
Xcr2YBrhdBYDIjeK5VyGQll7zESBLVOA0mQ3qRZE+i65BTxG43bDdDKcbpwnBk35
9szDjxcGnhVelL6UhWGxINWUd1QFoAMatRmirjN5h/5YMmcb5j8csI0NytD5ovdT
OcKO9FLKAysQ3zlvEV5oV5jUkUKXFK1tQL34u1CFyZFVUYNt3TAFeLegYUg6sI4g
CQrSdAjHXJs9NOswwHPwuSpDzgQ7JaOJ+r5jul/ivkaFFmQlm18Ozus5CBncmr3G
C1Y1KIEEsJqQqyqsQTWAX8Vc7uGQRRt/CnPLRfG+3ING6DomvrVndqnKmBzSsl8H
znH2WyZMmO9MVeP8NYH1X2T1T5xxTOr/aC5HPpfhhzBiSzIYJJiOa7bnZNLGIEfG
zNc5dC2CIqONVTwvoKkj
=pvuE
-----END PGP SIGNATURE-----

--hf3PDeZ9a40C1ZbL--

--===============7218836460369267613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7218836460369267613==--
