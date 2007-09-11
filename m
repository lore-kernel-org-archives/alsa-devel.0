From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#438118: alsa-utils: aplay
	non-blocking	mode isn't working
Date: Tue, 11 Sep 2007 18:08:11 +0200
Message-ID: <20070911160811.GD17585@frodo.home.lxtec.de>
References: <20070815.153103.-1470506910.anders@netinsight.se>
	<20070815172821.GB7381@frodo.home.lxtec.de>
	<20070816.094636.-753684517.anders@netinsight.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5465455921028411978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 86EF4244D7
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 18:08:16 +0200 (CEST)
In-Reply-To: <20070816.094636.-753684517.anders@netinsight.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel <alsa-devel@alsa-project.org>, Anders =?iso-8859-1?Q?Bostr=F6m?= <anders@netinsight.net>, 438118@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--===============5465455921028411978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

forwarded 438118 alsa-devel@alsa-project.org

stop

Hi all,

can one please have a lokk at this? aplay -N isn't working for the
OP.

On Thu, 16 Aug 2007 the mental interface of
Anders Bostr=F6m told:

> >>>>> "ER" =3D=3D Elimar Riesebieter <riesebie@lxtec.de> writes:
>=20
>  >> strace aplay -N :
>  >>=20
>  >> ...
>  >> open("/usr/lib/alsa-lib/libasound_module_rate_speexrate.so", O_RDONLY=
) =3D -1 ENOENT (No such file or directory)
>=20
>  ER> This file is provided by
>  ER> libasound2-plugins: /usr/lib/alsa-lib/libasound_module_rate_speexrat=
e.so
>=20
>  ER> Please install libasound2-plugins and try again.
>=20
> Thanks for the suggestion.
>=20
> Unfortunately, it didn't solve my problem, no sound when non-blocking
> mode is used. New strace:
>=20
> strace aplay -N :
> ...
> open("/usr/lib/alsa-lib/libasound_module_rate_speexrate.so", O_RDONLY) =
=3D 5
> read(5, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\22\0"..., 832)=
 =3D 832
> fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D20848, ...}) =3D 0
> mmap(NULL, 2116136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 5, 0)=
 =3D 0x2b9f792fe000
> mprotect(0x2b9f79302000, 2097152, PROT_NONE) =3D 0
> mmap(0x2b9f79502000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 5, 0x4000) =3D 0x2b9f79502000
> close(5)                                =3D 0
> ioctl(4, 0xc2604110, 0x7fff3269dec0)    =3D 0
> ioctl(4, 0xc2604110, 0x7fff3269dec0)    =3D 0
> ioctl(4, 0xc2604110, 0x7fff3269de00)    =3D 0
> ioctl(4, 0xc2604110, 0x7fff3269de00)    =3D 0
> ioctl(4, 0xc2604110, 0x7fff3269ddd0)    =3D 0
> ioctl(4, 0xc2604110, 0x7fff3269ddc0)    =3D 0
> ioctl(4, 0xc2604111, 0x7fff3269ddc0)    =3D 0
> ioctl(4, 0xc0884113, 0x7fff3269dd10)    =3D 0
> ioctl(4, 0x80184132, 0x7fff3269dc70)    =3D 0
> mmap(NULL, 49152, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =3D 0x2b9f79503=
000
> ioctl(4, 0xc0884113, 0x624e88)          =3D 0
> ioctl(4, 0x4140, 0)                     =3D 0
> ioctl(4, 0xc0884113, 0x624e88)          =3D 0
> read(3, "\377eO\333\337\370\344}\335_\377\330^l\356\361`j\336_l"..., 1001=
) =3D 1001
> read(3, "n{u^\342zl~e~_[\365_y\362_\363\350\337n[\347nmi`\367y\344"..., 6=
04) =3D 604
> ioctl(4, 0x4144, 0x2b9f785d8000)        =3D -1 EAGAIN (Resource temporari=
ly unavailable)
> close(3)                                =3D 0
> ioctl(4, 0x4143, 0x3)                   =3D 0
> munmap(0x2b9f79503000, 49152)           =3D 0
> ioctl(4, 0x4112, 0)                     =3D 0
> close(4)                                =3D 0
> munmap(0x2b9f785d7000, 4096)            =3D 0
> munmap(0x2b9f785d8000, 4096)            =3D 0
> munmap(0x2b9f792fe000, 2116136)         =3D 0
> exit_group(0)                           =3D ?

I have no idea, so forwarded to alsa-dev then.

THX in advance

Elimar


--=20
  Experience is something you don't get until=20
  just after you need it!

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG5r1r3Ig8bsVPf7ARAnynAKCUJ2gbemSOcXaqdruNB0o7STUQKACfXON8
4iLC0n2bO7S/CYrS4/mPHb0=
=nVS3
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

--===============5465455921028411978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5465455921028411978==--
