From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: help needed: support of Tascam us 1641 usb 2.0 with
 support provided from company (was: [Alsa-devel] Tascam us 1641 usb 2.0)
Date: Tue, 17 Aug 2010 14:46:25 +0200
Message-ID: <1282049185.3712.1.camel@mattotaupa>
References: <20100804092327.327280@gmx.net>
	<20100804111145.GB19789@exact.conquest> <20100816153242.176620@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8853525934610031539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 65BED2438E
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 14:46:32 +0200 (CEST)
In-Reply-To: <20100816153242.176620@gmx.net>
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
Cc: Takashi Iwai <tiwai@suse.de>, Christoph =?ISO-8859-1?Q?K=F6ditz?= <ckoeditz@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============8853525934610031539==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8f9jWdH+zWkso38ogwQP"


--=-8f9jWdH+zWkso38ogwQP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Sorry for the double posts you guys in CC. I got the wrong list address th=
e first time.]


Dear ALSA developers,


Christoph sent the following message to alsa-user. Maybe someone can
step up to this task or at least tell how much work this will be. It
looks like, Karten wrote the support for the other Tascam devices.

        commit 030a07e441296c372f946cd4065b5d831d8dc40c
        Author: Karsten Wiese <fzu@wemgehoertderstaat.de>
        Date:   Wed Jul 30 15:13:29 2008 +0200
       =20
            ALSA: Add USB US122L driver
           =20
            Added a new US122L usb-audio driver.  This driver works togethe=
r with a
            dedicated alsa-lib plugin.
           =20
            Signed-off-by: Takashi Iwai <tiwai@suse.de>
            Signed-off-by: Jaroslav Kysela <perex@perex.cz>

@Christoph: I got this, cloning the Linux kernel tree and running the
following.

	git log sound/usb/usx2y/us122l.c


Thanks,

Paul


PS: Sorry for top posting, but I think in this case it is feasible,
because I changed the lists.


Am Montag, den 16.08.2010, 17:32 +0200 schrieb "Christoph K=C3=B6ditz":
> Hello there,
>=20
> I have contacted Tascam because of the us-1641. They had send me an answe=
r (in German):
>=20
> "...Linux Treiber sind von unserer Seite her nicht geplant. Die Treiber b=
asieren aber auf einem identischen Konzept wie die des US-144.
> Bisher wurde von Seitens des ALSA Projects keine bitte um, eine Unterst=
=C3=BCtzung f=C3=BCr die Treiber Entwicklung des US-1641 an uns herangetrag=
en.
> Wir hatten einem hier in Deutschland ans=C3=A4ssigen Teilnehmer des Proje=
kt bereits f=C3=BCr die Entwicklung der US-122L und US-144 Treiber leihweis=
e Ger=C3=A4te als Entwicklungsgrundlage zur Verf=C3=BCgung gestellt und k=
=C3=B6nnten uns =C3=A4hnliches auch in diesem Fall vorstellen. ..."
>=20
> They said:
> They don't planned any Linux-drivers. But the drivers are based on an ide=
ntical concept like the US-144. So far, the ALSA Project not asked for a dr=
iver support for the development of the US 1641.
> They hired an in Germany living developer an US-122L and an US144 for dev=
eloping a driver. In this case they think, they would do something like tha=
t.
>=20
> I hope anyone helps this information.
>=20
> Regards, Chris
>
> -------- Original-Nachricht --------
> > Datum: Wed, 4 Aug 2010 12:11:46 +0100
> > Von: ael <law_ence.dev@ntlworld.com>
> > An: "Christoph K=C3=B6ditz" <ckoeditz@gmx.de>
> > Betreff: Re: [Alsa-user] Tascam us 1641 usb 2.0
>=20
> > On Wed, Aug 04, 2010 at 11:23:27AM +0200, "Christoph K=C3=B6ditz" wrote=
:
> > > Hello there,
> > >=20
> > > I've got a question. I want to know if the Tascam us 1641 USB Interfa=
ce
> > is supported or is not supported in opensuse.
> >=20
> > You might get an answer from some kind person, but probably not.=20
> > alsa is a project for linux in general. opensuse is just one
> > distribution: you should ask them. Or better, look to see which kernel
> > is in use, download the source, and look for yourself.
> >=20
> > If necessary, you might want to collect and install a current kernel
> > if it supports your hardware.
> >=20
> > ael
> >=20
> > PS. As I happen to have the latest kernel source, I did a quick grep fo=
r
> > you and found:-
> >=20
> > 1)
> >  Module snd-usb-usx2y
> >   --------------------
> >=20
> >     Module for Tascam USB US-122, US-224 and US-428 devices.
> >=20
> >     This module supports multiple devices, autoprobe and hotplugging.
> >=20
> >     Note: you need to load the firmware via usx2yloader utility include=
d
> >           in alsa-tools and alsa-firmware packages.
> > -----------------------------------------------------------
> >  (This was under Documentation, so might be out of date)
> >=20
> >  2) Many hits under sound:-
> >=20
> > usb/usx2y/us122l.c:MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version
> > 0.5");
> > usb/usx2y/us122l.c:	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
> > usb/usx2y/usX2Yhwdep.c: * Driver for Tascam US-X2Y USB soundcards
> > usb/usx2y/usX2Yhwdep.c:		.vendor_name =3D	"TASCAM",
> > usb/usx2y/usX2Yhwdep.c:		.vendor_name =3D	"TASCAM",
> > usb/usx2y/usbusx2yaudio.c:	{ 0x18, 0x40},	// only tascam / frontier des=
ign
> > knows the further lines .......
> > usb/usx2y/usbusx2yaudio.c:	{ 0x18, 0x40},	// only tascam / frontier des=
ign
> > knows the further lines .......
> > usb/usx2y/usbusx2y.c:	Removed EZUSB Firmware. First Stage Firmwaredownl=
oad
> > is now done by tascam-firmware downloader.
> > usb/usx2y/usbusx2y.c:	http://usb-midi-fw.sourceforge.net/tascam-firmwar=
e.tar.gz
> > usb/usx2y/usbusx2y.c:MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version
> > 0.8.7.2");
> > usb/usx2y/usbusx2y.c:MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604),
> > "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
> > usb/usx2y/usbusx2y.c:	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"")=
;
> > usb/usx2y/usx2y.h: * Driver for Tascam US-X2Y USB soundcards
> > usb/Kconfig:	tristate "Tascam US-122, US-224 and US-428 USB driver"
> > usb/Kconfig:	  Say Y here to include support for Tascam USB Audio/MIDI
> > usb/Kconfig:	tristate "Tascam US-122L USB driver"
> > usb/Kconfig:	  Say Y here to include support for Tascam US-122L USB
> > Audio/MIDI
> > ----------------------------------------------------------------
> >=20
> > So it looks as if you might need to look in us122l.c, usX2Yhwdep.c, etc=
.
> > Of course, I have no idea whether these US-X2Y soundcards have the 1641=
=20
> > interface you mention.=20
> >=20
>=20
> --=20
> Neu: GMX De-Mail - Einfach wie E-Mail, sicher wie ein Brief! =20
> Jetzt De-Mail-Adresse reservieren: http://portal.gmx.net/de/go/demail
>=20
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by=20
>=20
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev=20
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user



--=-8f9jWdH+zWkso38ogwQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxqhJoACgkQPX1aK2wOHVi6LACfX+5NMfwdUna57cL6e7QboHaR
kRUAn0CtxbrYuACgdXLtY0swuzvwdevg
=de1y
-----END PGP SIGNATURE-----

--=-8f9jWdH+zWkso38ogwQP--


--===============8853525934610031539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8853525934610031539==--
