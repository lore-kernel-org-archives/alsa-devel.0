From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/10] ASoC: rsnd: add SRC support
Date: Tue, 31 Dec 2013 13:36:57 +0000
Message-ID: <20131231133657.GC31886@sirena.org.uk>
References: <87lhzgurtc.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6449162442011673166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C0BEF264F10
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 14:37:01 +0100 (CET)
In-Reply-To: <87lhzgurtc.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6449162442011673166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KXlsDDyIxzhAJBYd"
Content-Disposition: inline


--KXlsDDyIxzhAJBYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 07:25:41PM -0800, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> These are cleanup and SRC support patches
> for Renesas sound driver

I've applied all these but you really need to start moving this stuff
over to use DPCM, this is getting to be very borderline.

--KXlsDDyIxzhAJBYd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwsh2AAoJELSic+t+oim9D1UP/Rd4fCXL9Uc1gCkJ4WNPROHM
bX2Y3LxN3MfT5XHPjCmxrgKq7zrsNUxTn/rOuCR4dC5Qu4H3QjqClBMVHGjm9PhC
o1/IEh0ZdVSXg3C1kpMaaMak+Fvr0ZqVv/qJPESH9NRofD0t6wAkEU9e2gQCucRY
9aKK4U56CWmHTM5RVLWbcbZdZdbLwE78t8A+xQOel47DH3pGwBLlzEGKRkPkle4H
joVJmXXOI5GRn37g7YKcwGWXABqLg4KVUsQ3UV5XXf1Kf5EICJwFHINL9C+njkr1
nK/uo0SxcKzBKtRzQCiPuEW8Z4AazXPDoHjlS6rZv4YynKhvI9Jf7BhDfUa3tTJm
QmoLApXLmGUSh8f6Nf7czBGZCO12CnlElOlQKuSctWa8SacwFw0U9BAGvUv5YTzZ
4u4OPi2DO+Mx+gdrc5C+siBAHYjPa13RB6E9AoYaXJ5sTIEiRWBDi1qrvLDG0crc
FXUywH7jODXsrvPuBDn3XyvavZvP7r7i9V0ZO7A5cV3QQBn4rmu9hpmb1zpsdEOn
nHj8ZBkajmqKjiz7pRVVgSXy6XTprNEmUEKJGiBwM3ISDWVlwb3NucJxl9NspYWv
hGEZUtp4/2Jd4+rjo1p5O1rnJrBJQxdlSO3izPRSuxjdmbjCeZxm67VJ7nt7IbIk
TlWw6IKb8upPFohj2Z8k
=v5DX
-----END PGP SIGNATURE-----

--KXlsDDyIxzhAJBYd--

--===============6449162442011673166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6449162442011673166==--
