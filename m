From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: omap-abe-twl6040: Remove support
 for pdata (legacy boot)
Date: Wed, 31 Jul 2013 20:03:18 +0100
Message-ID: <20130731190318.GC9858@sirena.org.uk>
References: <1375290032-21708-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5579011492269550069=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 063C7261643
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 21:03:22 +0200 (CEST)
In-Reply-To: <1375290032-21708-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5579011492269550069==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dEEDTEf0AkNfK6zl"
Content-Disposition: inline


--dEEDTEf0AkNfK6zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 07:00:32PM +0200, Peter Ujfalusi wrote:
> Just recently OMAP4 legacy boot support has been removed. No reason to keep
> the code used by the legacy boot (pdata based) since neither OMAP4 or OMAP5
> can boot in this mode.

Applied, thanks.

--dEEDTEf0AkNfK6zl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+V9yAAoJELSic+t+oim9OUwP/14PQcyuz7b7rsrQJp5voYY/
UUcbmag1PCExe5bXIYUgbhulaDNVTAy6W3c7VAp/tODdK7hLmpc1bq5bCBzpTUJh
lgqYWj9pKZiuTZNOzJAVFuWzev4bKfl0HS8KfzsQY+TjfalNdFfmWVY5Rw2nKWJq
O9KAXW1BN9UEbU+C/z7d/e5ha6mRxbzJwxNZ4dtNqxB61Tdp8GsaOAEP7/IhBw/m
sYa3TWQJBRnwbpuX48cDw8S/jke6IWxhNRZwOhFGjRluGq7ZHk2D0pKQ0IGfMiCt
N8/IqvY3KN8YZpAKA7onoVptESSs4n08nrUXtLgVrIyOY3MI3lCCKzIgLy0q7DBh
qVmnYP8qYsfShpIkf8y6bXhZC5TgL5AyUskO4Ou4M3/V5fX1gPRb79t4szbab/ra
HImf8HXDv0sX4Q1JK4GzSMsQZxH/rDDsISnuGU9rOeOobUC8JIVdLoXyvxvMMTtL
4oy/TV8SCqlh3X8jaRb7n4GWIBko4olvjUQu8UjdBmMvmVjzl2qI+hTuF2CrCK9w
xHBDChbFj0P6+CjKnIaHtE7rl/V0m5lkQJfN7duWRGUytQbIBzUczdhba69JyQNP
WiBCV0jBf+y5AgtVJY3TQvxkKcqAP66wXKKDm8TPFRR/JnL+X4uOwg5xiYaFLeMb
OVLnAR7CcOgn5uJXz30x
=U681
-----END PGP SIGNATURE-----

--dEEDTEf0AkNfK6zl--

--===============5579011492269550069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5579011492269550069==--
