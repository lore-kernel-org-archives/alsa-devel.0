From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Mon, 19 Sep 2016 13:34:15 +0200
Message-ID: <20160919113415.GM8719@lukather>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2259564981945824836=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id AAC46266A5B
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 13:34:16 +0200 (CEST)
In-Reply-To: <20160919111247.GL10189@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Mylene Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: alsa-devel@alsa-project.org


--===============2259564981945824836==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4D23EFnZpzTzcHd"
Content-Disposition: inline


--z4D23EFnZpzTzcHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2016 at 12:12:47PM +0100, Mark Brown wrote:
> On Mon, Sep 19, 2016 at 12:54:19PM +0200, Maxime Ripard wrote:
>=20
> > That codec is mapped in memory, however, we have a bunch of DAPM
> > widgets that are mapped in a separate register space, that should
> > probably be exposed through a syscon (but isn't yet).
>=20
> Why not just represent those as a separate device?

I don't know, this seems to be supplies to muxers, mixers, DACs, the
amplifier (and the amplifier volume too, even though that's not a
widget), and it looks really intertwinned, how would you separate
them?

> > To make things worse, the register in the syscon behaves as a mailbox,
> > where you actually have to set in that register the address you want
> > to modify and the new value, in a single write. This also seem to
> > deviate from the usual DAPM access pattern.
>=20
> This is totally fine, just use events for the things that aren't simple
> register updates - there are a large number of examples in the tree,
> simple register access is totally optional.

Ah, yes, that seems to be just right. Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--z4D23EFnZpzTzcHd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3803AAoJEBx+YmzsjxAgrgwP+QEpzFdvXVPsPCjMsPYQeeP4
Yac9PimJO+HM/TaFQz1XSk3DAtUQY3RRZF6krztadARYFcn0KLEb5Rd4xhzHkA2+
g4k3UubzFVvm5cwtOoXvyGNJL6IYwbfoEFRMjfP31Y8SfHCD17IVCSzX0nl2Mwp4
8lNtFsUVZLjz5Ku2xJ6n1ZBPq25AlUnfSsAZu9EabtJCWThwgtccHqWw1E4AyyBb
c46L66FLhs3o5FheGY/5V1vb7Jnrb43PyIzKZZ1upQxzqPl6BWmYNB7eqno6agmv
7xlAt1GT3vxD2Dxkv2aq+vT4+e57qz75M0Gk8H0Jcw7BKFoJc7I2IwZxw1rUMYkt
tMj2hiONA6SLydkCN5zGyf/fXY/ZHLl83FdPFKA5JlSAenIDDpxPlYHqlKTMRFPQ
+o7KysZMC0T1b/cKEKjTwS8tmncQjKcky99OJQ+SoNu/lbgAJIbGoBwi0RhyvQoy
hBJ0LDiM8qy8jKv/PZ1I4T+ZBiJwPT9mrbdhN0Azr6NotxYLiNST362OBVBmopcG
N4kFm1KI3hdj3nHiE08pHZcD4hbsfCy5ahTPCtauW68cds18vH6QrfgO/fCu7Eks
SqnAoM2uyssvLM9eAeMfo+DSnBbGuxUsFLxW5WZLia3wjuQ71IL15tt06mvk8qBM
vSv2jMuaRLBX7vgNmigI
=Aovv
-----END PGP SIGNATURE-----

--z4D23EFnZpzTzcHd--

--===============2259564981945824836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2259564981945824836==--
