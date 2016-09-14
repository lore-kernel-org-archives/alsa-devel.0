From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: alsa-tools FTBFS on armel: gcc-6 narrowing
	conversions
Date: Thu, 15 Sep 2016 08:33:22 +0900
Message-ID: <100312f5-4956-02df-3dd3-6e78f9d70985@sakamocchi.jp>
References: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8816504328641926563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 331B32664C3
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 01:33:27 +0200 (CEST)
In-Reply-To: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: riesebie@lxtec.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8816504328641926563==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bcwGDqoGQKbE95buNikOKQmD3CqAbh3Dc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bcwGDqoGQKbE95buNikOKQmD3CqAbh3Dc
Content-Type: multipart/mixed; boundary="ur71XlaXWaM6jB9aW3hu3KPHVJxAPwD6Q"
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: riesebie@lxtec.de
Cc: alsa-devel@alsa-project.org
Message-ID: <100312f5-4956-02df-3dd3-6e78f9d70985@sakamocchi.jp>
Subject: Re: alsa-tools FTBFS on armel: gcc-6 narrowing conversions
References: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>
In-Reply-To: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>

--ur71XlaXWaM6jB9aW3hu3KPHVJxAPwD6Q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On Sep 13 2016 01:52, Elimar Riesebieter wrote:
> Hi all,
>=20
> in Debian a FTBFS was discovered in building alsa-tools:
>=20
> | arm-linux-gnueabi-g++ -DPACKAGE_NAME=3D\"hdspmixer\" -DPACKAGE_TARNAM=
E=3D\"hdspmixer\" -DPACKAGE_VERSION=3D\"1.11\" -DPACKAGE_STRING=3D\"hdspm=
ixer\ 1.11\" -DPACKAGE_BUGREPORT=3D\"\" -DPACKAGE_URL=3D\"\" -DPACKAGE=3D=
\"hdspmixer\" -DVERSION=3D\"1.11\" -DSTDC_HEADERS=3D1 -DHAVE_LIBASOUND=3D=
1 -I.   -Wdate-time -D_FORTIFY_SOURCE=3D2  -g -O2 -fdebug-prefix-map=3D/<=
<PKGBUILDDIR>>=3D. -fstack-protector-strong -Wformat -Werror=3Dformat-sec=
urity   -I/usr/include/freetype2   -D_THREAD_SAFE -D_REENTRANT -fno-excep=
tions -MT channelmap.o -MD -MP -MF .deps/channelmap.Tpo -c -o channelmap.=
o channelmap.cxx
> | channelmap.cxx:59:1: error: narrowing conversion of '-1' from 'int' t=
o 'char' inside { } [-Wnarrowing]
> |  };
> |  ^
>=20
> More Details can be found at:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D837590
>=20
> Could this be fixed for next release?

I'm interested in this issue.
(I'm an user of Debian/Ubuntu and some of my friends are DD.)

I think this issue is triggered by some compiler options, so long
overlooked. I'd like to fix it, however I don't know how to prepare for
build environment to reproduce it.

If you have some advices to reproduce, please inform it to me? I also
asked my friends to help for it ;)


Thanks

Takashi Sakamoto


--ur71XlaXWaM6jB9aW3hu3KPHVJxAPwD6Q--

--bcwGDqoGQKbE95buNikOKQmD3CqAbh3Dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX2d5DAAoJELWlhsfWb9NBAOEP/0J5k68y2NCCBPal2/l3JAjs
x1Lv/eN3p4ahwOLTlupGq/k7PBj5LX2ollEKozGRM3qexf4F2uzartXc1i8WmVVj
NdN0xVHF/meP6Cuo2pBFkdefiwRlXvDK3r3YpWgOl+sm6qckpbqJqagNuBLM3Vz9
y7mVGN7Q8iH8OX5UwjaHuskn7S+jcR2u+W0ZDLGM2NZ+Nv+hKbvA3JjR/NCpe5wz
euOVF0kzttwWGYdXRUJBN4h9XB+//ZHoszhKu2K+DtaiXk476zeZ3RIGRZvtXYrD
IhV8raIeH8WuuFejZkRXWwoO689K/1BhmlaZdvoGuO8l7dnAJPJT0ztnHrcF8gIh
VHpWAQl6/ejRi2YeR/v6doMz4JmqV+vKstPVuDYEU4cLxuN93/rbqYobEZEv9PxT
/mR5+3L+rhjItUo/OCQba2QYfSGqDiO3qSXY2M85T8plsgaSbh6VXDC/fTESaHyL
SANrP+8kBj8w+U8ANRzvVRbzDnWgZOiix7bzq/K4IdeHGHwiyNw1Ow6qFFRjqZtQ
zr9h2c1uHrMsr60G5EytNJSfhCViOIGwbhzdJMZz1962GKrYf2+519H8lCntIbx8
r26fPWcd0SaZjutq+Zm40K5zQm0OXu2HOlsKeqy3JxT5yJ6jLHxoOqg24LaKD47N
rznbD0ZQTMTyGh2F1Kkn
=/Vi+
-----END PGP SIGNATURE-----

--bcwGDqoGQKbE95buNikOKQmD3CqAbh3Dc--

--===============8816504328641926563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8816504328641926563==--
