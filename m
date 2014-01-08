From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: wm_adsp: Factor out ADSP2
	boot proceedure
Date: Wed, 8 Jan 2014 18:27:55 +0000
Message-ID: <20140108182755.GU31886@sirena.org.uk>
References: <1389202939-13741-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3496391825775290835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F866261B20
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 19:28:09 +0100 (CET)
In-Reply-To: <1389202939-13741-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3496391825775290835==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DFkvugPqpPdjMvyU"
Content-Disposition: inline


--DFkvugPqpPdjMvyU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 05:42:18PM +0000, Charles Keepax wrote:
> Move the ADSP2 boot proceedure into a work structure in preparation for
> running it asynchronously with the reset of the audio path bring up.

Applied both, thanks.  Might be worth considering pushing the RAM enable
into the context of the initiating thread so that the time taken to poll
is eaten up in the scheduling delay, or at least you end up with bigger
chains of I/O.

--DFkvugPqpPdjMvyU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzZioAAoJELSic+t+oim92jAQAJsvsMzrzclVIH8ilLurXO3+
M9vJlQ57wnkctuC/kuTCMOntVwSwixKuNWiNI8DvBUHyQ87S1efjK0xtKnOcJ5C3
LTojk3vbzHiqInRo7r0LOCuJCALkqcskpWvUTiNst1g4Kqbm92EF/wYwhLFRle/B
ooNeKtl4KOlIeF9lLr52x9u1OrUMR66dxc0x2fxfikh4zb4VINA/c9ogL6howwhm
5r6QM+Lzq8Jo6Ez9awVZRgbrZ7cOhA+8pItc6hBmW9SMnAnYM+ul47sDdEFICSnf
AHBpACPuUdz72RIWWK1C9YtptTmInyAmw3iSASXDm/FRQ0EXgI1sX5HPAbSBBv0p
UrZj/EDpCnvY6YXT8hvQ46XDKjg3SdNpDeMJPvIWEZb+HKYyRceI2c1m0+f/+Cty
+Bhnq3yGTjgiq3AfkAxYc2+uENohHbvBa2FOPgXpPuPFDkKnRNxJjZsjJtdGYCDK
6y/UyIApXNl5HGZOrONAoRenZaSYKcIkmLRYN81RM2qs/T0EPg6PP/38hxSN0g9f
/2stT9rA0NQkbWFWWW/ajU24D2oEQUQ+fo22y8Z90JF/lXdy+Zv+5+QyAAEol7s0
LHzPufYDzucTKu37O+UR3UOBlIou+Znz2pr0MnfYIFDYG+hM+j3g2Yb04CqehYGr
K2akoddzOi0kZqQugOxr
=n2IM
-----END PGP SIGNATURE-----

--DFkvugPqpPdjMvyU--

--===============3496391825775290835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3496391825775290835==--
