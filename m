From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/19] ASoC: rsnd: unify rdai naming
Date: Mon, 3 Mar 2014 10:20:18 +0900
Message-ID: <20140303012018.GF2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <8761o390r3.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0028237081653947591=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFFB02654D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 03:23:20 +0100 (CET)
In-Reply-To: <8761o390r3.wl%kuninori.morimoto.gx@gmail.com>
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


--===============0028237081653947591==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:15:18PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> struct rsnd_dai is called as "rdai",
> but its size has been called as "dai_nr".
> Unify these as "rdai"

Applied, thanks.

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9jPAAoJELSic+t+oim9uRwQAJOgU2pM5BLhacjUD7WHCsHR
WS15b6/1XhFR3eM4NEownF8zoazSRd1G1wlLcPtzmlsRlLUpjcd65g/Go3fNTVPx
y6PcjLIT71jVD6Nmwxh9Icmdk6xMxXspM9D6BjRgeDRtvpbgQSEYbcWgsQ0VEKCZ
pZBMySJ2iaLV7P1u2i7mih1HCtPV8YtVJEx4DYaPQeAbnp9PBnd/3N+GEt38pKOj
uBzvLYzOSDNbrPzrPmUtdwmvGlpAD9wNsioGTNJX5cPSOIMRFlw3GWMsWcaB+QEw
qDRVCviZDN/NAE3nQgB4ZY87a5hEjXj72QVu9yBeChdiQSWWZNswhuagYCReWD4x
0WR/YVEqvI1BNFmC0CmMtFZydn6rHYDO/0eebQm1SP6r8d0XwL+xCqKBsc+z7KgD
ezYvaqYXNhenVOeFQo/yRZlXV6Oj38QSdEtTQN4vJQoYFTNTUsp06oVJKn6XixVS
HpP2ksa0I+C3rD1OH+iGd100NSkoye9XYr9IfBdlPa3dF/qSHIK4WuL0qftVnsco
7NK2xHBEh480L3N3NsC2KApj4VA1whUjREMkGWvkRw9JmCy50l76IhHY+Zldlsa2
4ijOo5olFyzbuDShC2Mk95Gf340NjK9bIeI4ELV9ztS8eKXz7wGcyq7JSlCvJZwQ
g8Nv4B/sRofmjZoCS8N7
=yXwk
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--

--===============0028237081653947591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0028237081653947591==--
