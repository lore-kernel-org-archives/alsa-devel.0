From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42l52: Reorder Min/Max and
 update to SX_TLV for Beep Volume
Date: Tue, 6 Aug 2013 19:39:14 +0100
Message-ID: <20130806183914.GQ6427@sirena.org.uk>
References: <1375811842-12513-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6466103604142410279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 94F9C2616C1
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 20:39:17 +0200 (CEST)
In-Reply-To: <1375811842-12513-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brian.austin@cirrus.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6466103604142410279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mpb+VUhBqKoEsre9"
Content-Disposition: inline


--mpb+VUhBqKoEsre9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 12:57:21PM -0500, brian.austin@cirrus.com wrote:
> From: Brian Austin <brian.austin@cirrus.com>
>=20
> Beep Volume Min/Max was backwards.
> Change to SOC_SONGLE_SX_TLV for correct volume representation

Applied both, thanks.

--mpb+VUhBqKoEsre9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAULPAAoJELSic+t+oim9ZvgP/izDofapwqaalW1X3bKUWIau
atwlX8zWsC3m7lp2a5qy5b9C+As/fflYcLgAdOZ5qumuSol2GMWtvEJ5d4DjPgHz
av3ALpLsX0NdDlQz7Jnkh/vUB3ywVUW/efz04FW4V2QsXOUYaf3Hcvwn5qiX4abh
3K0aaREjeeilWJiKkSn1uFrCcuBKkJ6vnawdAuKQkjSeiJvJSzfUImZTkrtLEN+m
Kz8eXpYbV0OsMk8FMe5QA8P3leFv6ecE51GmyoSiGSl5GdZHFk4fRdjm5wHJx1Fs
WKIloKYhIJ7uZS9+40nxWkCIeEk47LvbVEKbG/OEBb3uF1SbB8RpQsOIMdnaMEF/
aXAR8kdYml0zmUFyCLwVPQ6QketCuWsRMjAi3VNL9cbqH0iFNFnSX9itt/5TNbVa
blsOlDDKVctCxtZahPK/lpsuyxACqNBk9EUZw0Py9Eu/cQTISv1BpmRlBzm3N7rA
GIS5PnPUcLmonf+KO+m9kAlGS3ueTNSxvfevIwqKByRj8REEjU3uoPehs8ewieK6
DRjBsqcVusg5HnmT33LSbywIGAPbrF4B9Y11hNtRFZh+qKglS9UasLiLFJ0fMqcA
43a4q7/p08T4R/GO4vYAu3brrqoUZWPwFNir2J54Lrti7fe4QLatDkxPNh0i5yZO
xluvsVPBrZVZUCoeN6zM
=NgX1
-----END PGP SIGNATURE-----

--mpb+VUhBqKoEsre9--

--===============6466103604142410279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6466103604142410279==--
