From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs42l52: Catch no-match case in
	cs42l52_get_clk
Date: Mon, 24 Dec 2012 16:02:49 +0000
Message-ID: <20121224160248.GP30837@opensource.wolfsonmicro.com>
References: <1355993596.20315.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3683490286052648205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5968B261639
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 17:02:50 +0100 (CET)
In-Reply-To: <1355993596.20315.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3683490286052648205==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZMy3ZKywLyoHonN"
Content-Disposition: inline


--7ZMy3ZKywLyoHonN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2012 at 04:53:16PM +0800, Axel Lin wrote:
> In the case of no-match, return -EINVAL instead of 0.
>=20
> Since we assign i to ret in the for loop, ret always less than
> ARRAY_SIZE(clk_map_table). Thus remove the boundary checking for ret.

Applied, thanks.

--7ZMy3ZKywLyoHonN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HyiAAoJELSic+t+oim9l24P+wbQYjBW1E2mVWdNk9DcJ/o4
dl3NT+ETLCxBwj9t5lzqBd4F2/G64bfa523DC0LtKIS+yksax/AbK4jHEFmGBaK1
oZoYPBa2fKi4LR/gRg37mX8eKI/NTGecqXAelS5LHWqH+v1oqK4fQDfITzzFeJpX
ihU0wXsCs6RqDpXpofSAOqidrEV3BKYYFYI4/YdQXt6Z04RaiNqUhkTkM6k3JmGp
bgaDyrxUWU+/WqTs/cj+1BNJXWdDJjGQyxsMguo7buJPRcrCPTQAkF8PHU/qPswj
cMUxOaj24SEpbG/y3aooryzCHcg9PzuqaYp81p+fx9ilQKm+BT2vra1Rjnh4/C5/
x4HvCrAmNow1P29qMp0DTVQbh0VSmG9RR5rgVNxNzLBKIlmGqhy9twjQ3xUxMGZI
mwZBvxugS857zi+m9KlDd6nfyJwplhsRXHjQ0Fm13mz09TrMQ1zYvXbeiBFpRcwX
n2gk7aH7yK+2QF0rviMb6cs5DZoTd427Z0QNefEE2/qikm8oLitDclfy7csUVG1L
KsTnmA6bI1FKresv3Z1k7xCve4MPITYus62zkEaLnUwq1mYGsq0/I8YBcbaQlhzs
D0nriWTi9x1wy01PwlJnCfLfoVma0Sj4UaaFGYjU4VOPHwdYa/sZkKmIt339LBEd
7AMzZ78h+PMKy1yyGoRU
=Z+kp
-----END PGP SIGNATURE-----

--7ZMy3ZKywLyoHonN--

--===============3683490286052648205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3683490286052648205==--
