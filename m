From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 3/3] uda1380: make driver more
	powersave-friendly
Date: Sun, 27 Jun 2010 13:43:32 +0300
Message-ID: <201006271343.36646.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006270007.34271.anarsoul@gmail.com>
	<20100627101053.GA26394@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8027609012855629059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 71939103832
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 12:43:44 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1285605bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 03:43:42 -0700 (PDT)
In-Reply-To: <20100627101053.GA26394@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============8027609012855629059==
Content-Type: multipart/signed;
  boundary="nextPart3592615.gunaZcHkFs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3592615.gunaZcHkFs
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
27 =D0=B8=D1=8E=D0=BD=D1=8F 2010 13:10:54 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> > Nope, it is not. Only i2c and clock related regs of uda1380 can be
> > modified when there's no i2s clock, i.e. mixer regs should be updated
> > right after i2s clock was enabled, so we marking mixer-related regs
> > cache as dirty, to make sure they'll be updated when possible.
>=20
> This is very much non-obvious from your code - it really needs comments
> explaining why the cache sync function didn't actually manage to sync
> the cache.  I'd also really expect that the dirtying of the cache would
> be done when the operation that invalidates it happens, not later on
> when restoring the cache.  Otherwise there's a window where the cache is
> flagged as valid but is not actually so which doesn't seem robust.

Ok I'll add comments, but there's no window where cache is marked as valid =
but=20
is no consistent with hardware - resume callback marks cache as dirty=20
immediately :)

> Old drivers for fairly obscure chips aren't always a good guide to best
> practices for things.

Ok, what driver should I use as reference?

> > It's softreset and it's performed by writing some value to some reg. i2c
> > xfers is not possible when codec is not enabled (it is not at this
> > point)
>=20
> It needs to happen at some point.

Softreset is performed right after codec power on, it can't be performed=20
earlier.

--nextPart3592615.gunaZcHkFs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwnK1gACgkQRM6pQpltKE6DVACePUpDbMpKBcmaUSW6G2k//O+u
6bsAnRQ0hXZ9m8GAIbfOCH05eqKafzyY
=53lW
-----END PGP SIGNATURE-----

--nextPart3592615.gunaZcHkFs--

--===============8027609012855629059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8027609012855629059==--
