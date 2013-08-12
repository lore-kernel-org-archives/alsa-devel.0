From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/16 v2] sound/soc/pxa/mioa701_wm9713.c:
 Avoid using ARRAY_AND_SIZE(e) as a function argument
Date: Mon, 12 Aug 2013 22:40:50 +0100
Message-ID: <20130812214050.GI6427@sirena.org.uk>
References: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6160938425814823606=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 253C1265019
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 23:41:00 +0200 (CEST)
In-Reply-To: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@arm.linux.org.uk>, robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6160938425814823606==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gqUrV6DUXoHnB0ku"
Content-Disposition: inline


--gqUrV6DUXoHnB0ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2013 at 10:49:24PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding t=
he
> arity of the called function.

What is the difference between this and the patch I applied the other
day?

--gqUrV6DUXoHnB0ku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCVZfAAoJELSic+t+oim9mNkQAJzpxYPkBF49Qv88qzBnBeFZ
PVubj8VLfgWrp/YnRUC0fIFpW5d5Z81j0GFlWtVmxrWxIkr9VGT7bLNfqNwPdXhd
Wk2KwheLQ16qfqB2sndoX2lS0K7N/49K73t+H0AOoNC2JQHWsISvLeJiqqJ9wz0I
9AZt8KIXqlQadl/dVApUaodpnAG6OsAYNQ+gYZxFrONTPp+YeDzkoxc6RopjZZ3U
1HeoF83OM6xp7D4rzjBzpjau1eEVP0Hp5PZ0N3ECC5glR+JRABiwWbMbfayIdDId
Ff/qw4XtrsZZ+oto0ERVOAFlS6hPa5d6CvnPtfff6ZPhu8Q3mm/14fKLPx43g+7a
SA++xoJx/V3euevjzUlMgT5ihNq7KrC9ubXNfl1dTC75vVPMU2/VcQ7pbcMBJoJW
ZO3fmyvmn+HFRCF5ZTWgMIXDMvjOa/pnkuosVeLsUOw8owneU7nRt4y9t12bpKil
zGYt3vv6fdirMA5SaL4foQKK/W8BodRRWyI+fgSRRHSCfHJ0CuFKPcLPjGycfjVt
gFfpCYVkxVj3QFSYXEgGofCsVui1oob6R4Li8WySFS9r0JGbv/ZNUKksajuAiS3q
SCICQLWC54xhAQLz4pfYnXEqo8OAcq2RWxf/8m5SXbR0vkxEQSsjJGr8rcASX++q
E7ozOEAvEaXOYEOojBLO
=28+c
-----END PGP SIGNATURE-----

--gqUrV6DUXoHnB0ku--

--===============6160938425814823606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6160938425814823606==--
