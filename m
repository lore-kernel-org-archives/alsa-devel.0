From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10 v3] ASoC: rsnd: no more SRC restart
 when unusual situation
Date: Sun, 22 Mar 2015 18:12:42 +0000
Message-ID: <20150322181242.GW6643@sirena.org.uk>
References: <87mw39eide.wl%kuninori.morimoto.gx@renesas.com>
 <87fv91eia6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0813704015739541270=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B435E261692
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:00:08 +0100 (CET)
In-Reply-To: <87fv91eia6.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0813704015739541270==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oNLI4EWr1RPQuPCf"
Content-Disposition: inline


--oNLI4EWr1RPQuPCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 04:14:04AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> It will be SRC interrupt endless loop f unusual situation happen.
> This patch adds restart limit for it.

Applied, thanks.

--oNLI4EWr1RPQuPCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwYZAAoJECTWi3JdVIfQxQkH/0Uyo8veX2ir5UAe4GNXHzbh
G+f4Dgsyu7jKKuJJ8AVMdC/4iZPlLhYoKH/pfuujsOhqrGyYw3+C3ebPGr5XpOTx
yagxcE/hipvYzIOUEWjk3zs7gkjyfHOIK1LIYIvynkJZ/B/fv09O50UCglKmsZZT
LAAy66usAkgXos6o+hX8HtlpGcLnj0XZGn1Od5eXr15MncaQed/Iqpj2jsoTsp/D
ht4om0fCUxEGDB2ynjW+vhb7A7ZT5f938l1OEL41G983lWIAYnDWwPIqzH8eh7fe
ogCnpOO5QjZD2EVsA77786IX7ue6C8ZhLDwxjUGScgbenzeqy9h0qabDJYso0zQ=
=b6yx
-----END PGP SIGNATURE-----

--oNLI4EWr1RPQuPCf--

--===============0813704015739541270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0813704015739541270==--
