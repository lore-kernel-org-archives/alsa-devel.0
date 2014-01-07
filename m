From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dpcm: Explicitly set BE DAI link
 supported stream directions
Date: Tue, 7 Jan 2014 17:58:06 +0000
Message-ID: <20140107175806.GI31886@sirena.org.uk>
References: <1389117102-6488-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1389117102-6488-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1618010499751669885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05B11261092
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:58:11 +0100 (CET)
In-Reply-To: <1389117102-6488-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1618010499751669885==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DeJtexeFuKMt9/11"
Content-Disposition: inline


--DeJtexeFuKMt9/11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 05:51:42PM +0000, Liam Girdwood wrote:
> Some BE DAIs can be "dummy" (when the DSP is controlling the DAI) and as =
such
> wont have set a minimum number of playback or capture channels required f=
or BE
> DAI registration (to establish supported stream directions).
>=20
> Force machine drivers to explicitly set whether they support playback and=
 capture
> stream directions for every BE DAIs.

Applied, thanks!

--DeJtexeFuKMt9/11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzEArAAoJELSic+t+oim9Be0P/jFcVkY30ToARpJWJ3/7tz6N
/nfhL1HtAApwkNz+E/6b6ByfNGdl++hL9eC6aEHPW97no7N0zXBt1X0iyETDR7ur
6sJLsFdfrAnc0q9Fcs7ltCrUFlFlrDHII5/nu2G1OPclLh1B7C3oYQ0gxmhtHwmA
o6DXHlrdZf+RKoRRqOLA56UPMjVJMR7QCopmf9kDb9x9hwrQXTUGvigM9HmUrHXO
E41X4WV5vd228KsXkaCbA4DU6mxMcZQIp9rD38f0ovXs9socIZzg8A5MES+eWJIn
ZTjiA6AQKORuAsIjQwhz6RpxXzDH52utSLIY4UdvM3xj0buzts2he5STdPzAAZfD
iScqdvcr7adPq1RwVWIWm6Id/xpT8UhTgLFP/ROzBoUvEBlQybHvkh5/Ryszd78N
rShNXf8fel0sl/D/Z7o9y0Z5gELKXmUMjEsbxyf7+jWEeYCEXHMaloJ4plkM8l6K
p88osR2Wsyd/CQskfcJtIW5ha+0yrTIyqbqikH4lwljtW3O4/99rB62Zv+PYfR/m
OPXC8u9ZWKWFeajS1PIwYMOCSnv0pitgl4bTTec3kh4zUHXDoxfKn5hjO9BnyAAf
dB0Eh2SmlUE5RMax1Eap+6bxK0SFwT936dQjuUl9jbcLr5HwCQ5L3xWx40wrdaJ8
pDrnFwU5jipR3txjc4rG
=Vi0s
-----END PGP SIGNATURE-----

--DeJtexeFuKMt9/11--

--===============1618010499751669885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1618010499751669885==--
