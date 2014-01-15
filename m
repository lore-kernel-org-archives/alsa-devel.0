From: Olivier =?ISO-8859-1?Q?Cr=EAte?= <olivier.crete@ocrete.ca>
Subject: Re: Surround sound not working on ALC887 based
	motherboard
Date: Wed, 15 Jan 2014 12:50:38 -0500
Message-ID: <1389808238.4661.24.camel@TesterBox>
References: <1389286414.4661.13.camel@TesterBox>
 <CAN8cciaoEwYvqDCGiR5jjgK78GMMG6dVSnzJN2_D9D4H6RWusA@mail.gmail.com>
 <1389643950.28960.6.camel@TesterTop4> <1389719312.4661.21.camel@TesterBox>
 <CAN8cciZLSbxWVSbpzNkqQ2e1_O9StWCMgYcoTsHdB6gfCkpEWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8272550899595749603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by alsa0.perex.cz (Postfix) with ESMTP id E533A265146
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2014 18:51:47 +0100 (CET)
Received: from TesterServ.TesterNet ([135.19.19.22])
 by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MZG00GX1EYA3210@VL-VM-MR006.ip.videotron.ca> for
 alsa-devel@alsa-project.org; Wed, 15 Jan 2014 12:51:46 -0500 (EST)
In-reply-to: <CAN8cciZLSbxWVSbpzNkqQ2e1_O9StWCMgYcoTsHdB6gfCkpEWw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8272550899595749603==
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-iWCfHge9Uf0eMPlStfzX"


--=-iWCfHge9Uf0eMPlStfzX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-01-15 at 15:35 +0800, Raymond Yau wrote:
>=20
>=20
>=20
> 2014/1/15 Olivier Cr=C3=AAte <olivier.crete@ocrete.ca>
>         Hi,
>        =20
>        =20
>         > >         I have a Asus P5G41T-M LX Plus motherboard which
>         is ICH7 +
>         > >         Realtek
>         > >         ALC887-VD, alsa only lets me access the first 2
>         channels
>         > >         (stereo), but
>         > >         not the 6 other ones. It works fine in Windows.
>         > >
>         > >         Trying to run this after killing pulseaudio fails:
>         > >
>         > >         $ aplay -D surround40:0 -f S16_LE -r 44100 -c
>         4 /dev/zero -v
>         > >         Playing raw data '/dev/zero' : Signed 16 bit
>         Little Endian,
>         > >         Rate 44100 Hz, Channels 4
>         > >         aplay: set_params:1239: Channels count non
>         available
>         > >
>         > >
>         > >         Output from alsa-info:
>         > >
>         http://www.alsa-project.org/db/?f=3Dfe378d28f0dbb5a427b005d20866a=
762fd37d31a
>         >
>         > >
>         > > post output of pactl list or pulseaudio verbose log
>         >
>         > http://www.ocrete.ca/surround/pactl-list.txt
>         > http://www.ocrete.ca/surround/pulseaudio-vv.txt
>         >
>         > > you have to change channel mode from 2ch to 6ch to retask
>         the input
>         > > jacks as output if your motherboard only have three audio
>         jacks at
>         > > rear panel
>         >
>         > How would one do that ? Pulseaudio only offers Stereo
>         profiles.
>        =20
>=20
> amixer -c0 set "Channel Mode" "6ch"
>=20
>=20
> >
> > > do you mean pulseaudio cannot probe the surroun40 or surround51
> > > profile ?
> >
> > Yes, but I can't use it with aplay even without pulseaudio running.
> >
> > > Simple mixer control 'Channel Mode',0
> > >   Capabilities: enum
> > >   Items: '2ch' '4ch' '6ch'
> > >   Item0: '2ch'
> >
> >
>=20
>=20
> > For some reason didn't get your last email, but I saw I saw it on
> the
> > archive.. Thanks for your solution, it worked! Definitely something
> > PulseAudio should expose better.
>=20
>=20
>=20
>=20
> do it really work since rear mic become active port even when it had
> been retasked as output ?

The 6 outputs work at the same time. I didn't try it as a mic as I don't
have a mic here...

> Ports:
> 		analog-input-front-mic: Front Microphone (priority: 8500, not available=
)
> 		analog-input-rear-mic: Rear Microphone (priority: 8200, available)
> 		analog-input-linein: Line In (priority: 8100, available)
> 	Active Port: analog-input-rear-mic


--=20
Olivier Cr=C3=AAte
olivier.crete@ocrete.ca

--=-iWCfHge9Uf0eMPlStfzX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlLWym4ACgkQHTiOWk7ZorsJywCfYS0Xcn2oGDyTa+1inSgjxlN2
O2oAmQEkz+sr9Eywyza0WebY6n+7uzMl
=oPV1
-----END PGP SIGNATURE-----

--=-iWCfHge9Uf0eMPlStfzX--


--===============8272550899595749603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8272550899595749603==--
