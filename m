From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: ALSA Version change
Date: Tue, 11 Mar 2008 13:36:09 -0500
Message-ID: <1205260569.18700.386.camel@petrie.sacredspiral.co.uk>
References: <370c08350803111130i2d4147f2q9a7345d11ccbc6c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1828325120050301096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id A0DE21038A7
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 19:35:38 +0100 (CET)
In-Reply-To: <370c08350803111130i2d4147f2q9a7345d11ccbc6c7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Healy <cphealy@gmail.com>
Cc: alsa-devel@alsa-project.org, cphealy@rockwellcollins.com
List-Id: alsa-devel@alsa-project.org


--===============1828325120050301096==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aL7i3uAmKsUZUZqW9lpY"


--=-aL7i3uAmKsUZUZqW9lpY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-03-11 at 11:30 -0700, Chris Healy wrote:
> Currently, I am using a 2.6.19.2 kernel with ALSA version 1.0.13.  This i=
s
> on an i.MX31 ARM11 platform.  (This is what it came with.)  We want to us=
e a
> codec that currently has and ASoC supported driver so it seems best that =
we
> move forward to a newer version of ALSA.  (1.0.14 or later has ASoC.)
>=20
> If we are going to the trouble of moving from 1.0.13 to a later version,
> does it make sense to port to 1.0.14 or 1.0.16?  It makes sense that movi=
ng
> to 1.0.14 would take the least effort, but obviously, 1.0.16 has bug fixe=
s
> and features.  Do you think there is a large delta porting wise between
> moving to 1.0.16 instead of 1.0.14.  (The assumption is that we have to m=
ove
> over to the later alsa-lib and alsa-utils, correct?)
>=20
> The other question we have is in reference to the max number of cards we =
are
> working with.  This is an embedded system and we want to control 16 audio
> codecs, (cards).  We won't be using the PCM interfaces of these cards, bu=
t
> we do need to control the codecs through the mixer interface.  I have see=
n
> limitations previously alluding to a maximum of 8 cards but this was a fe=
w
> years ago.  Is this true with the most recent versions, and if so, any id=
eas
> on what is necessary to change this?
>=20
> Thanks,
>=20
> Chris

Usually ALSA's configure script will patch the kernel itself AFAIK, so
there's no need to worry about any unnecessary trouble. As for
versioning, 1.0.16 is what you probably want.

William



--=-aL7i3uAmKsUZUZqW9lpY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH1tEZoB+26npOQg4RAs4VAJ4v4EQsWDjxs9/CaCQKIUfPZKL4/ACfWEIl
8/GDfCs+ybM0P+xtXWb4kuI=
=7F5J
-----END PGP SIGNATURE-----

--=-aL7i3uAmKsUZUZqW9lpY--


--===============1828325120050301096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1828325120050301096==--
