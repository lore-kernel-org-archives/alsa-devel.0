From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [Regression] With the new 2.6.33 when I plug in
 headphones, the speakers don't turn off anymore
Date: Fri, 26 Feb 2010 10:33:48 +0100
Message-ID: <1267176828.3751.12.camel@mattotaupa>
References: <hm82oh$1am$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5429767792780663535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 26E622442F
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 10:33:56 +0100 (CET)
Received: from f053038134.adsl.alicedsl.de ([78.53.38.134]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Nkwa2-0007B6-Nc
	for alsa-devel@alsa-project.org; Fri, 26 Feb 2010 09:33:54 +0000
In-Reply-To: <hm82oh$1am$1@dough.gmane.org>
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


--===============5429767792780663535==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-vBBa936rmoIplXlRCdZ7"


--=-vBBa936rmoIplXlRCdZ7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Guillaume,


Am Freitag, den 26.02.2010, 10:03 +0100 schrieb giggzounet:
> I have installed debian stable lenny + backports on an eeepc 1201n. With
> the 2.6.30 or 2.6.32 from lenny-backport I don't have problem with sound
> : when I plug the headphones, speakers get off.
>=20
> I have tested with 2.6.33 and when I plug headphones, speakers don't get
> off anymore. so I have sound in headphones and speakers.
>=20
> 22:42 giggz@baal ~ % cat /proc/asound/card0/codec#* | grep Codec
> Codec: Realtek ALC269
> Codec: Nvidia MCP7A HDMI
>=20
> I attach the output of alsa-info with the 2.6.32.9 and the 2.6.33 (I'm
> in a Uni Campus and it's quite difficult to have internet on a external
> laptop...so I attach them at this mail and I don't upload them on pastbin=
).

I find it good that you attached the files, so I could produce a diff
easily. Besides some additional control elements and names the following
difference shows up.

        $ diff -u alsa-info_2.6.32.9.log alsa-info_2.6.33.log
        --- alsa-info_2.6.32.9.log      2010-02-26 10:14:01.000000000 +0100
        +++ alsa-info_2.6.33.log        2010-02-26 10:14:06.000000000 +0100
        @@ -3,7 +3,7 @@
       =20
        [=E2=80=A6]
       =20
        @@ -85,11 +85,12 @@
        =20
         !!Module: snd_hda_intel
                bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
        +       beep_mode : 1,1,1,1,1,1,1,1
                enable : Y,Y,Y,Y,Y,Y,Y,Y
        -       enable_msi : 0
        -       id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL=
>
        +       enable_msi : -1
        +       id : (null),(null),(null),(null),(null),(null),(null),(null=
)
                index : 0,-1,-1,-1,-1,-1,-1,-1
        -       model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<N=
ULL>
        +       model : (null),(null),(null),(null),(null),(null),(null),(n=
ull)
                position_fix : 0,0,0,0,0,0,0,0
                power_save : 5
                power_save_controller : N
        [=E2=80=A6]

I do not know why enable_msi is set to =C2=BB-1=C2=AB and not one since it =
should
be enabled by default now [1]. Could you try to load the sound module
with `enable_msi` set to `0` and report back your findings, please.

        $ sudo modinfo snd-hda-intel
        [=E2=80=A6]
        parm:           enable_msi:Enable Message Signaled Interrupt (MSI) =
(int)
        [=E2=80=A6]

> I have opened a bug on the kernel bugzilla (bug 15399). Should I provide
> anything more ?

Please always provide a link I can just click on and try to put as much
reference to already existing posts as possible. This refers to the post
on Debian-eeepc-devel [2].


Thanks,

Paul


[1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D71623855e20c3febebb5fa60528cde2592678bd5
[2] http://lists.alioth.debian.org/pipermail/debian-eeepc-devel/2010-Februa=
ry/003322.html

--=-vBBa936rmoIplXlRCdZ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuHlXUACgkQPX1aK2wOHVhNvwCeL482JBHzM2Iwr466HOnKJw1y
kSEAn3lWOuRJAc2vRVEtUBFpFJWUEGQX
=m4gm
-----END PGP SIGNATURE-----

--=-vBBa936rmoIplXlRCdZ7--


--===============5429767792780663535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5429767792780663535==--
