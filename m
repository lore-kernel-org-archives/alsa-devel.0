From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
Subject: Re: configure and compile errors (possibly because of
 gcc 3.3)
Date: Fri, 20 Jun 2003 19:31:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030620193113.43123592.hanno@gmx.de>
References: <20030619132925.68cb59bd.hanno@gmx.de>
	<Pine.HPX.4.33n.0306200912570.9190-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.w(7yv_OXlQc8Ef"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306200912570.9190-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=.w(7yv_OXlQc8Ef
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

> > Kernel compiler: gcc-Version 3.3 (Gentoo Linux 1.4, PVR 3.3)
> > Used compiler:   gcc (GCC) 3.3 (Gentoo Linux 1.4, PVR 3.3)
> > ...
> > Decoded kernel compiler: type=3Dgcc-Version version=3D3.3
> > Decoded used compiler:   type=3Dgcc         version=3D3.3
> >
> > Well, the kernel compiler and the used compiler are definitely the
> > same.
>=20
> Well, the identification strings aren't (not exactly).

It seems the detection routine of the configure-script contains bugs.
I'm not the only one with this problem. There are at least two bugs in
the gentoo-bugzilla containing the same problem:
http://bugs.gentoo.org/show_bug.cgi?id=3D22841
http://bugs.gentoo.org/show_bug.cgi?id=3D21990

> > checking for kernel version... 2.4.21-ac1
> > ...
> > serialmidi.c: In function `open_tty': serialmidi.c:158: error:
> > invalid operands to binary >
>=20
> The -ac patch changes the count field's type to atomic_t. Change the
> offending line to:
>=20
> 	if (atomic_read(&tty->count) > 1) {

Okay, now I know how to workaround the bugs for me. Will they be
fixed in future alsa-versions?

--=20
Hanno B=F6ck - hanno@gmx.de

"Immer wenn man die Meinung der Mehrheit teilt, ist es Zeit sich zu
besinnen." Mark Twain

--=.w(7yv_OXlQc8Ef
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+80Tlr2QksT29OyARAul8AJ4ucRNPOiMkeGl6him+ZPS1LWlLSACeMP1c
UPC2j1M61Y9DeHy7ofvWbkY=
=ciVE
-----END PGP SIGNATURE-----

--=.w(7yv_OXlQc8Ef--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
