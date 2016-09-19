From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: DAPM over two regmaps (and a mailbox)
Date: Mon, 19 Sep 2016 12:54:19 +0200
Message-ID: <20160919105419.GK8719@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4783330204823921791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id EF2FA26533B
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 12:54:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Mylene Josserand <mylene.josserand@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: alsa-devel@alsa-project.org


--===============4783330204823921791==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E6lVPAHcXg6biC3t"
Content-Disposition: inline


--E6lVPAHcXg6biC3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

We've been working recently on a later SoC (Allwinner A33) with a
codec directly embedded into it, just like
sound/soc/sunxi/sun4i-codec.c, but this time using the usual i2s
controller we had, instead of a custom DAI.

That codec is mapped in memory, however, we have a bunch of DAPM
widgets that are mapped in a separate register space, that should
probably be exposed through a syscon (but isn't yet).

Those are apparently used to control the analog part of the codec,
including powering up the DAC, so it really feels like they should be
part of DAPM.

However, since we will obviously have a regmap for the main register
space of the codec, that leaves us with two regmaps that we need to
use, depending on the register we want to set, and DAPM doesn't really
seem to be able to handle that.

To make things worse, the register in the syscon behaves as a mailbox,
where you actually have to set in that register the address you want
to modify and the new value, in a single write. This also seem to
deviate from the usual DAPM access pattern.

I'm not really sure how to handle that properly. For now, we just did
those writes outside of DAPM, in the startup, shutdown and prepare
shutdowns. We could also have a meta-regmap, that would have custom
write and read functions, and depending on the register would turn to
our syscon, or do a writel.

Or we could try to make DAPM able to use different regmaps depending
on the register, but that seem do be very intrusive.

Do you have any suggestions or preferences on how to implement this
properly?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX38PbAAoJEBx+YmzsjxAgw5gP/AptHGZ22yp+d9W+JOn7OHH8
xSF/MjWfvZ4LLyoeBbN7ORbQRQ9T1uWCDOK7Pa7SB5QKFlj16S9EuDn8WM1IPasN
QZnjDu3GmJfVSk0AKGGgcXodsYvKUWUFoW2Q4V9BBH+1b+0KP1UTDmE6zMLyG6fc
z/cSWOMpxtueQtMX8vaYjAPxme5bABCszL4xZUDiE9Gw1QfS9p7C0AvBQgWScCDc
+uOqVE85+rRpRMJSlj/zOdXpLSYEc80FOWSemQjm2QQCtPTNBvA0Gd5KSTHaoM6O
lmWJZ+vqUeM2EJQlMJ/o6+p0PaY6m2loJYK1rRRq434m4Xm3qDdvRkYBNfYh57xr
m+Xu0ejjvT1wEBZFijuqzFGYimZaiWyeN6xzwqgxyPayzj6JUHwNjh0BRSJ7otYJ
8Rs53ClJM6mddATAflgnWBH/7i9tv/BdxNvNo6+lteUw775mhFxlhf/RJk8NmiqS
dN98Qv56/n2QF3+XMMwWVuL4cEwMSiGeLAt5jwQppbs/Aa+4fWH7qqvBN3Xr8Tul
qYFaopE1U0GJuxoaK3zzveViIqLGi6EzEslX/8mFwKxcglwwZq7kadCtrez/uJ2H
6AvdW8mpr7QI4/OPvuMiKP19MXF7GjkLUA0G5XvO+D9rDPn4HOEbHZUc8Fjs9her
1su5KfYXlsgEYdZKRzmw
=sxc1
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--

--===============4783330204823921791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4783330204823921791==--
