From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [Regression] With the new 2.6.33 when I plug in
 headphones, the speakers don't turn off anymore
Date: Fri, 26 Feb 2010 12:42:23 +0100
Message-ID: <1267184543.3802.13.camel@mattotaupa>
References: <hm82oh$1am$1@dough.gmane.org>
	<1267176828.3751.12.camel@mattotaupa> <hm8aat$shn$1@dough.gmane.org>
	<hm8afm$shn$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1066013885191037036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A79A103A16
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:42:33 +0100 (CET)
In-Reply-To: <hm8afm$shn$2@dough.gmane.org>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============1066013885191037036==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Tg1I1DTdCnLao15lZVed"


--=-Tg1I1DTdCnLao15lZVed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 26.02.2010, 12:15 +0100 schrieb giggzounet:
> [snip]
>=20
> >> I do not know why enable_msi is set to =C2=BB-1=C2=AB and not one sinc=
e it should
> >> be enabled by default now [1]. Could you try to load the sound module
> >> with `enable_msi` set to `0` and report back your findings, please.
> >>
> >>         $ sudo modinfo snd-hda-intel
> >>         [=E2=80=A6]
> >>         parm:           enable_msi:Enable Message Signaled Interrupt (=
MSI) (int)
> >>         [=E2=80=A6]
> >>
> >=20
> > I have modified /etc/modprobe.d/sound with :
> > snd-hda-intel index=3D0 enable_msi=3D0
> >=20
> > I attach the log of alsa-info.
> >=20
>=20
> I have forgotten to say that the problem is always here with
> enable_msi=3D0
>=20
> [snip]

That=E2=80=99s unfortunate. It would have been nice if this had fixed it.

I CC Takashi, since he is the author of [1]. Maybe he can tell us if it
is related.

The only relevant(?) difference there is the following.

        $ diff -u alsa-info_2.6.32.9.log alsa-info_2.6.33_enable_msi.log
        [=E2=80=A6]
        @@ -85,11 +85,12 @@
        =20
         !!Module: snd_hda_intel
         	bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
        +	beep_mode : 1,1,1,1,1,1,1,1
        [=E2=80=A6]

The only other thing I can think of is, that you go trough the commit
log yourself and try to figure out what changed regarding to your
chipset and CODEC.

And last not least you could try DebPkg:libasound2 from unstable and see
if this changes anything. Although I guess it will not.


Thanks,

Paul


[1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D71623855e20c3febebb5fa60528cde2592678bd5

--=-Tg1I1DTdCnLao15lZVed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuHs5gACgkQPX1aK2wOHVibBACeIy9IU68AsMBaxNfzZrZv9mkr
9r4Amwc/8kbdxtg1zCq2doZLii0mPqzU
=vSxq
-----END PGP SIGNATURE-----

--=-Tg1I1DTdCnLao15lZVed--


--===============1066013885191037036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1066013885191037036==--
