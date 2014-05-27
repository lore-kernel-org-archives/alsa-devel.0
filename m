From: Christopher Head <alsa@chead.ca>
Subject: Re: aplay: main:722: audio open error: No such file or
 directory
Date: Mon, 26 May 2014 22:13:57 -0700
Message-ID: <20140526221357.1a10cc17@kruskal.home.chead.ca>
References: <20140525091124.01578e75@kruskal.home.chead.ca>
 <5382FBA9.4000402@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8971783688800436238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from chead.ca (chead.ca [67.220.144.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 2520C2654B9
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 07:14:05 +0200 (CEST)
In-Reply-To: <5382FBA9.4000402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============8971783688800436238==
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/TqClEdUS2ABgwor40ThPSQB"; protocol="application/pgp-signature"

--Sig_/TqClEdUS2ABgwor40ThPSQB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2014 10:30:33 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> Christopher Head wrote:
> > asound # cat cards
> >  0 [MID            ]: HDA-Intel - HDA Intel MID
> >                       HDA Intel MID at 0xf4900000 irq 53
> >  1 [NVidia         ]: HDA-Intel - HDA NVidia
> >                       HDA NVidia at 0xf3080000 irq 17
> >
> > I can't play audio on non-default devices.
> >
> > Running aplay with -D hdmi does not work, failing with this message:
> > aplay: main:722: audio open error: No such file or directory
>=20
> The default card has no "hdmi" device.
>=20
> Try -D hdmi:CARD=3DNVidia (or better plug:hdmi:CARD=3DNVidia to get
> automatic sample format conversions).
>=20
>=20
> Regards,
> Clemens

Well, here=E2=80=99s what happens when I try either of those:

$ aplay -D hdmi:CARD=3DNVidia phone.wav
Playing WAVE 'phone.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
aplay: set_params:1233: Sample format non available
Available formats:
- S16_LE
- S32_LE

(so, looks like it worked fine)

$ aplay -D plug:hdmi:CARD=3DNVidia phone.wav
ALSA
lib /tmp/portage/media-libs/alsa-lib-1.0.27.2/work/alsa-lib-1.0.27.2/src/co=
nf.c:4578:(parse_args)
Unknown parameter hdmi:CARD ALSA
lib /tmp/portage/media-libs/alsa-lib-1.0.27.2/work/alsa-lib-1.0.27.2/src/co=
nf.c:4711:(snd_config_expand)
Parse arguments error: No such file or directory ALSA
lib /tmp/portage/media-libs/alsa-lib-1.0.27.2/work/alsa-lib-1.0.27.2/src/pc=
m/pcm.c:2239:(snd_pcm_open_noupdate)
Unknown PCM plug:hdmi:CARD=3DNVidia
aplay: main:722: audio open error: No such file or directory

(no idea what happened here)

Actually, I was led to this problem initially due to trying to get
Linphone to use my HDMI output for ringing but my normal audio output
to headphones for talking. I discovered Linphone was using the wrong
device node name, so I tried to narrow down the problem by getting
Linphone out of the picture and just playing to different destinations
with aplay.

What strikes me as weird is that sure, my default card doesn=E2=80=99t have=
 an
hdmi device=E2=80=94so why then is it trying to open a /dev/snd/pcm node wh=
ose
name is a mixture of card and device that doesn=E2=80=99t exist? If it=E2=
=80=99s only
willing to consider card 0 in this case, why is it looking up the name
=E2=80=9Chdmi=E2=80=9D under card 1 and finding device number 3 at all, onl=
y to
concatenate it with card number 0?

If this is considered not a bug, then I=E2=80=99ll be happy to leave you al=
one
and poke the Linphone/Mediastreamer folks more instead.
--=20
Christopher Head

--Sig_/TqClEdUS2ABgwor40ThPSQB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBCAAGBQJThB8YAAoJEAoxakYXDDIkpSgIAJ+hSXNBaUsrHvz9bMAqYIJ0
uTPFg9Z3o5TeysoY8/lYrWfLIMw/u6MpzrfF4SI/DzyuhqDdROilOIXT1uJ/4TtA
h8lVvIlB5xZEpr2OIIA9OTktlxM2TStlr/EmVivpUpp8Cw175FVcDm4KkC5s4/rY
E8/J2BaSQnylPvVCRQPj38+u+Z9duCihhDFK+n91iVMI8bmBTkbVQPANh/oKOE3c
FS6u/k6xXQrVKUts6dhPTxSkZmd4FacNTWYeVDBPcy2BwAGiVB3MH4+EUC4R8/+v
5/g1+qmQ7KGZNg08cXBSEjNCLgvt2UkFbAAZtPGPFo2+sKDyL0WdlgTn6/eh8PY=
=qGUr
-----END PGP SIGNATURE-----

--Sig_/TqClEdUS2ABgwor40ThPSQB--

--===============8971783688800436238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8971783688800436238==--
