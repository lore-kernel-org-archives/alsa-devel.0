From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-spdif: Set the card owner
	field
Date: Wed, 14 Jan 2015 18:49:50 +0000
Message-ID: <20150114184950.GA3043@sirena.org.uk>
References: <1421260755-7445-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6203391035353678816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BA64265881
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 19:50:01 +0100 (CET)
In-Reply-To: <1421260755-7445-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6203391035353678816==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 04:39:15PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Set the card owner field to avoid getting a kernel crash when the imx-spd=
if
> is unloaded while the playback is active.

Applied, thanks.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtrpKAAoJECTWi3JdVIfQMLMH/1X2c2lGYUyB9Kt4ztPFKIIi
NEykd8zuQt46Kgc6gdC195J/SMiII/6kqYyOP6+ngDQ9NZVAEUm+3eiAhqr94ifO
qLRs1b29dc8+camzYRuPv7iLig+yBBEnxoFSPQgG0wNuDLn7iMvLE+Y6OsBlOSgd
dVtvzPBXU9KCcmEsC0j4OUGK+uqwTRsFBF9y9IMeOlFk0zdiorERz71sFVXw0F/c
LSh1pXfWa/zs3xcTwrL+2vG6fH6b+9tNOajufGxduZ33P+itorm9LjS6DTlX4s8f
2g42c2XIOzygu0bTkas0B/poRGcXHUPWON2ySuBlhn0eUv9fMNkFpr+XmukOnMU=
=QbgU
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============6203391035353678816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6203391035353678816==--
