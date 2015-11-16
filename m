From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4613: tidyup CTRL1 value selection
	method
Date: Mon, 16 Nov 2015 13:16:37 +0000
Message-ID: <20151116131637.GC31303@sirena.org.uk>
References: <87mvuecwsu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8339588372222296608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C510260471
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 14:16:46 +0100 (CET)
In-Reply-To: <87mvuecwsu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8339588372222296608==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2015 at 06:01:29AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current CTRL1 selection method didn't care about simultaneous
> playback / capture. This patch tidyup it.

This doesn't apply against current code, please check and resend.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSdc1AAoJECTWi3JdVIfQOtcH/3Zdmh8ccXRPHFu2DI4mFK/9
lLc4b9HOKScp3M21hVBDpNUA9X2xMMEzgN4TEhnViWmxihe/TMjLDRB0euMyT6St
yPn0vt4sdl7vlndL8fSPF4bVsewUk5HL5dAX0ICqJRMRlV6J5L6XZCuaZo1opeI1
dR14Veu5tQPBkHpjkWGWmI6K1TinNEMO3DaFc0ZBsHBies9IG6ewt5Bn7jOOknLb
K/BaiKomw+Fl2890SPusg/RoVZVtvN9YDNIxy/Djz3pCO7mct6xJMip6QcPkCEBL
/3aLEzJN6DBjUAYNGhNhkwmgqptPi0U+o4vpia9p1JDH7esA0VYJoWL6s23kSfA=
=zY6F
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

--===============8339588372222296608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8339588372222296608==--
