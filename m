From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-pcm: DPCM cares BE format
Date: Fri, 22 May 2015 13:38:49 +0100
Message-ID: <20150522123849.GT21391@sirena.org.uk>
References: <87wq0ebllq.wl%kuninori.morimoto.gx@renesas.com>
 <87vbfyblke.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4312191578420322610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10EBE265B69
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:08:20 +0200 (CEST)
In-Reply-To: <87vbfyblke.wl%kuninori.morimoto.gx@renesas.com>
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


--===============4312191578420322610==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qKhyKP9HH88saeqA"
Content-Disposition: inline


--qKhyKP9HH88saeqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 02:03:33AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current DPCM is caring only FE format. but it will be no sound
> if FE/BE was below style, and user selects S24_LE format.

Applied, thanks.

--qKhyKP9HH88saeqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyNYAAoJECTWi3JdVIfQVfwH/0Swih9qcRRTt88nndzaU/kQ
WB6YjOANt3Bq6LgYnMEmwbBw719XIp2jPgOMLfsJlvQ+b6kWEYIccKC9CDZoYbGN
ya9UM1Rpe+MSgE3o8FYpCnSn1kj8dIp9n5AIDbpBc41dAQ8KJ//TJ0jiYU+EDHPz
7q2hpg0kmDo+oJEvRTm6tJBSY78wS+5QT845Bx5VtOFnu1zbPvDyfx5qHmLBXnAe
XajfcvHuIymXCxQBmvPngQZrfu0Hzw0blW6iAOQb00MemVTXLIztBR3rPh8oOSr2
CNgKFKlAlA9NXuy3ri/USSzJnr5YypvNK2w8gcFAq3uOBmHSl1EsKWjDKtvYNmg=
=gC6n
-----END PGP SIGNATURE-----

--qKhyKP9HH88saeqA--

--===============4312191578420322610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4312191578420322610==--
