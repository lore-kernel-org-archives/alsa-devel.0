From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: No CD mixer on Intel G35 (Asus P5E-V(M))
Date: Tue, 02 Mar 2010 13:21:30 +0100
Message-ID: <1267532490.12737.20.camel@mattotaupa>
References: <20100228193128.GA14556@darkside.12.kls.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0741502185776730774=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id A575210389A
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 13:21:33 +0100 (CET)
Received: from f053034205.adsl.alicedsl.de ([78.53.34.205]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NmR6S-0002iq-2G
	for alsa-devel@alsa-project.org; Tue, 02 Mar 2010 12:21:32 +0000
In-Reply-To: <20100228193128.GA14556@darkside.12.kls.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0741502185776730774==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lj6Rq5cKwq5eXMJPTHq5"


--=-lj6Rq5cKwq5eXMJPTHq5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Mario,


Am Sonntag, den 28.02.2010, 20:31 +0100 schrieb Mario 'BitKoenig' Holbe:
> on my Asus P5E-V HDMI and my Asus P5E-VM HDMI (both Intel G35) alsamixer
> shows no CD mixer. Both boards have a CD audio connector and the
> CD-drive connected to it.
>=20
> holbe@darkside:/home/holbe% uname -a
> Linux darkside 2.6.32-3-686-bigmem #1 SMP Thu Feb 25 06:54:30 UTC 2010 i6=
86 GNU/Linux
> holbe@darkside:/home/holbe% cat /proc/asound/cards
>  0 [Intel          ]: HDA-Intel - HDA Intel
>                       HDA Intel at 0xfe5f4000 irq 22
>  1 [Bt878          ]: Bt87x - Brooktree Bt878
>                       Brooktree Bt878 at 0xfdfff000, irq 16
>=20
> alsamixer says:
> Card: HDA Intel
> Chip: Silicon Image SiI1392 HDMI
>=20
> Same with 2.6.33.
>=20
> On my P5Q-EM (Intel G45) the CD mixer appears in alsamixer.
>=20
> I have no idea how to dig deeper in this, if you need more information,
> please just tell me.

I think the developers like to have the output of `alsa-info.sh` [1][2].

1. Did ALSA ever detected the CD mixer on this board?
2. Did you try all different model parameters [2]? If not and it does
not work please also attach sanely named files with the output of
`alsa-info.sh`.
3. Have you tried to build the modules yourself from Git head [1]?


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug
[2] http://www.alsa-project.org/alsa-info.sh
[3] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA#.27model=
.27_parameter

--=-lj6Rq5cKwq5eXMJPTHq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuNAsoACgkQPX1aK2wOHVjv4gCeMkQNqXUU6wuZt3J0rmoJdv5T
epgAn0xJDICq7IbE5GfCa/yzqTK3yzpl
=488a
-----END PGP SIGNATURE-----

--=-lj6Rq5cKwq5eXMJPTHq5--


--===============0741502185776730774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0741502185776730774==--
