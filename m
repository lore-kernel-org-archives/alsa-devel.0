From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: sgtl5000: Fix the cache handling
Date: Mon, 26 May 2014 11:11:34 +0100
Message-ID: <20140526101134.GU22111@sirena.org.uk>
References: <1400958960-18775-1-git-send-email-festevam@gmail.com>
 <5382ECA9.1090808@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1962490335204417067=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 177C5265090
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 12:12:06 +0200 (CEST)
In-Reply-To: <5382ECA9.1090808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============1962490335204417067==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ow8ubXhN+exFFgjp"
Content-Disposition: inline


--ow8ubXhN+exFFgjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 09:26:33AM +0200, Lars-Peter Clausen wrote:

> I think the issue with this chip is that it wants a special sequence in
> which the registers are written when syncing the cache to the hardware. The
> first thing to check is probably if that is actually necessary. If not just
> drop the whole restore_regs thing. If it is necessary its probably worth
> investigating whether it makes sense to support custom sync sequences in
> regmap. We already have regcache_sync_region() so maybe add a
> regcache_sync_regions() which takes a array of struct regmap_range. And
> syncs the registers in the order of the ranges.

There's a few devices which need some sequencing on restore but it's
usually just for a very small subset of registers (and sometimes need
delays between the writes and things) so what tends to happen is a short
open coded sequences that do the ordering sensitive portions of the
sequence followed by a regcache_sync() which covers everything else.

--ow8ubXhN+exFFgjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTgxNNAAoJELSic+t+oim99ysP/1wQIViu7mxjzG1w/p3t16Jf
VXbnC4hvmkgZfsBIFjTOsKm8j8ynv6pyngcCV3qSUtX/Z9MDeRRmwprbQwvU4EvW
pvbAz9pPBbYkPB0CtA/LL/QZmbBxslEE5acDE7fbfQDYCAOy0DfIvACJcZoClSZM
ZY77stgyS/GWCL9x0SYsv01W3U/8Nm/DUtOgCWDH6c1dLK5zStth3CaVas+gg7Dg
k1TtURyT4BijM6qOyyAsBMMOG6N0Gn1MnFlAhXKWUa20HVi/vw+K34w2V3mLfxpO
ntG/zQ6jk6yKDdW+Lwp5FtexAAIos/Qutafpq/b56hB2zUB2E2qpCctpNMj073i6
+5Fzx9AWATW/IuuDaDuzRvH8qJtnQSsCD6Y6PAnKNrzYQym3X87NQiBkZ3CRXmyp
qENWBmm31OFrs+z3mWwoMf5hbY9hY8PRiKWBtmsugKuPTpXl/7eRzHfQU256cXdE
SiOZO15tsokjRMwdH8EZq+N0nrvWL9MSs7BfrG2U/ZNwoFfmEPuu7Fi7woUDlxnq
ksQNScGYHx2TSI0m3YJ+l3zTtyFIYSYwXxG4J94QbdvzO09d24kNWpAzOCuzvhit
zljT7aI5wGWredKagVVEO+c7q2xJ0wXjhUDc9jdmtBeGY+Pymlsg+hJW9nSzZfvg
l1o+YsfzuxQ1jUnNDMYi
=bzpq
-----END PGP SIGNATURE-----

--ow8ubXhN+exFFgjp--

--===============1962490335204417067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1962490335204417067==--
