From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Realtek ALC269VB Asus 1001px intern mic ist not
 working
Date: Wed, 02 Mar 2011 15:28:57 +0100
Message-ID: <1299076137.3857.39.camel@mattotaupa>
References: <4D6BE110.6020007@membee-rythms.net>
	<1298920230.3989.17.camel@mattotaupa>
	<4D6D6674.8050001@membee-rythms.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5121689271265936929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 35A122433C
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 15:29:00 +0100 (CET)
Received: from f053041235.adsl.alicedsl.de ([78.53.41.235]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Pun2w-0005Pv-Oj
	for alsa-devel@alsa-project.org; Wed, 02 Mar 2011 14:28:58 +0000
In-Reply-To: <4D6D6674.8050001@membee-rythms.net>
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


--===============5121689271265936929==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-WtvqdKw52355rwljpIni"


--=-WtvqdKw52355rwljpIni
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Marty,


please remember to reply to the list, e. g. in Evolution the shortcut is
Ctrl + l, and to send just plain text messages to lists as you did in
your original post.

Am Dienstag, den 01.03.2011, 22:34 +0100 schrieb Marty:
> Am 28.02.2011 20:10, schrieb Paul Menzel:

> > On Mo, 2011-02-28 at 18:53 +0100, Marty wrote:
> >   =20
> >> Hi, hope I get some help with this problem. At the moment I work with
> >> Pulse Audio but the results are very bad.
> >>     =20
> > how do you get it to work using PulseAudio?

I am pasting Marty=E2=80=99s first private answer.

        Am Montag, den 28.02.2011, 21:35 +0100 schrieb Marty:
        > Dear Paul, as first my basic os informations.
        >=20
        > Host/Kernel/OS "boaconstrictor" running Linux 2.6.38-5-generic i6=
86 [=20
        > Kanotix Hellfire 20101213-09:07 ]
        > CPU Info       (1) Intel Atom N450 @ clocked at [ 1667.000 MHz ]
        > Intel Atom N450 @ clocked at [ 1000.000 MHz ]
        > Videocard       Intel N10 Family Integrated Graphics Controller  =
X.Org=20
        > 1.7.7  [ 1024x600 ]
        > Processes 128 | Uptime 17min | Memory 258.2/2002.9MB | HDD Size 2=
50GB=20
        > (16%used) | Client Unknown Perl client | Infobash v2.67.2
        >=20
        > Advanced Linux Sound Architecture Driver Version 1.0.23.
        >=20
        > 0 [Intel          ]: HDA-Intel - HDA Intel
        > HDA Intel at 0xf7cf8000 ir
        >=20
        > 1:        : sequencer
        > 2: [ 0- 0]: digital audio playback
        > 3: [ 0- 0]: digital audio capture
        > 4: [ 0- 0]: hardware dependent
        > 5: [ 0]   : control
        > 33:        : timer
        >=20
        > 00-00: ALC269VB Analog : ALC269VB Analog : playback 1 : capture 1
        >=20
        >=20
        > I tried nearly all settings in alsamixer m and i could`nt activat=
e the=20
        > intern mic. After installing Pulse Audio with basic settings I ha=
d=20
        > either no success.
        >=20
        > 1. I modify /etc/modprobe.d/alsa-base.conf options snd-hda-intel =
model=3Dauto
        > ( i did`nt  tried yet options snd-hda-intel model=3Dfujitsu optio=
ns=20
        > snd-hda-intel model=3Dlifebook)
        > 2. save & reboot
        > 3. load driver and check settings in alsamixer m
        > 4. Pulse Audio settings - set all the capture devices to only the=
 left=20
        > (or right) channel
        > 5. Suspend to Ram
        > 6. reboot
        >=20
        > After this I had postive results in skype. The intern mic works b=
ut the=20
        > quality is worse. I modified all prossible soundsettings for bett=
er=20
        > results - no luck.
        >=20
        > Best & thx
        > Marty=20

> >> check:
> >> http://www.alsa-project.org/db/?f=3D0286416d03a64a2e34a4f73831c4f0f5cb=
a002d6
> >>     =20
> > Please always additionally paste this information into the message.
> >
> >          [=E2=80=A6]
> >
> >          !!Kernel Information
> >          !!------------------
> >
> >          Kernel release:    2.6.38-5-generic
> >          Operating System:  GNU/Linux
> >          Architecture:      i686
> >          Processor:         unknown
> >          SMP Enabled:       Yes
> >
> >
> >          !!ALSA Version
> >          !!------------
> >
> >          Driver version:     1.0.23
> >          Library version:    1.0.23
> >          Utilities version:  1.0.23
> >
> >          [=E2=80=A6]
> >
> > Could you please try a current ALSA version, i. e. 1.0.24, (for example
> > using a live image) or test if some `model` parameters, e. g. `fujitsu`=
,
> > work [1][2][3]?
> >
> > Searching for =C2=BB1001PX alsa=C2=AB also brought up several hits. Whi=
ch one did
> > you try?
> >
> >
> > Thanks,
> >
> > Paul
> >
> >
> > [1] http://alsa-project.org/main/index.php/Help_To_Debug
> > [2] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA
> > [3] https://wiki.archlinux.org/index.php/Asus_Eee_PC_1001px#Sound

> Hi Paul, I fixed it finaly with perfect quality.
>=20
> Alsa Driver  v1.0.24
> ./configure --with-oss=3Dno
> make -j2
> make install

I guess `--with-oss=3Dno` will not make a difference. But unless somebody
tried we will not know.

> purge Pulse Audio
> reboot
> modify all settings
> suspend to ram
>=20
> and after this I had clear sound !

Great to hear that. Could you please confirm that it does not work with
PulseAudio installed. I would imagine that upgrading ALSA driver to
1.0.24 did the trick.


Thank you very much for keeping the list/me updated with your progress
and success.

Paul

--=-WtvqdKw52355rwljpIni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1uVCkACgkQPX1aK2wOHVhl+QCfQCi681z9tYcsGjxY3GmzC9xX
YggAnj2EwA4poUzUuFwYnvmOb988W8t6
=HLTV
-----END PGP SIGNATURE-----

--=-WtvqdKw52355rwljpIni--


--===============5121689271265936929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5121689271265936929==--
