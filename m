From: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>
Subject: Re: Altec Lansing FX5051 mixer
Date: Fri, 31 Aug 2007 22:36:09 -0600
Message-ID: <20070901043609.GA13584@rifetech.com>
References: <20070827152359.GA22496@rifetech.com>
	<1188231535.15509.1207493335@webmail.messagingengine.com>
	<46D2FD9C.5030807@atrus.rifetech.com>
	<1188283800.25549.1207609489@webmail.messagingengine.com>
	<20070828074351.GA26261@rifetech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7016025222377535676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a8.g.dreamhost.com (sd-green-bigip-66.dreamhost.com
	[208.97.132.66]) by alsa0.perex.cz (Postfix) with ESMTP id 761E42439A
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Sep 2007 06:36:14 +0200 (CEST)
In-Reply-To: <20070828074351.GA26261@rifetech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7016025222377535676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Precisely the same problems with alsa 1.0.15rc1.


On Tue, Aug 28, 2007 at 01:43:51AM -0600, Jeremy Nickurak wrote:
> On Tue, Aug 28, 2007 at 08:50:00AM +0200, Clemens Ladisch wrote:
> > >         bmaControls( 0)      0x15
> > >           Mute
> > >           Bass
> > >           Treble
> > >         bmaControls( 1)      0x02
> > >           Volume
> > >         bmaControls( 2)      0x02
> > >           Volume
> > >         bmaControls( 3)      0x00
> > >         bmaControls( 4)      0x00
> > >         bmaControls( 5)      0x00
> > >         bmaControls( 6)      0x00
> >=20
> > These descriptors say that there is a two-channel volume control that
> > applies to the front channels, but I guess it really affects all
> > channels.
> >=20
> > Please show the output of "amixer contents" for this card.
>=20
> numid=3D3,iface=3DMIXER,name=3D'Tone Control - Bass'
>   ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D0,max=3D10,step=3D0
>   : values=3D5
> numid=3D4,iface=3DMIXER,name=3D'Tone Control - Treble'
>   ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D0,max=3D10,step=3D0
>   : values=3D5
> numid=3D1,iface=3DMIXER,name=3D'PCM Playback Switch'
>   ; type=3DBOOLEAN,access=3Drw------,values=3D1
>   : values=3Don
> numid=3D2,iface=3DMIXER,name=3D'PCM Playback Volume'
>   ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D49,step=3D0
>   : values=3D48,48
>   | dBscale-min=3D-49.00dB,step=3D1.00dB,mute=3D0
>=20
>=20
> >=20
> > > ...
> > >         HID Device Descriptor:
> > >           bLength                 9
> > >           bDescriptorType        33
> > >           bcdHID               1.00
> > >           bCountryCode            0 Not supported
> > >           bNumDescriptors         1
> > >           bDescriptorType        34 Report
> > >           wDescriptorLength     172
> > >           Report Descriptor: (length is 172)
> > >             Item(Global): Usage Page, data=3D [ 0x0c ] 12
> > >                             Consumer
> > >             Item(Local ): Usage, data=3D [ 0x01 ] 1
> > >                             Consumer Control
> > >             Item(Main  ): Collection, data=3D [ 0x01 ] 1
> > >                             Application
> > >             Item(Global): Usage Page, data=3D [ 0x0c ] 12
> > >                             Consumer
> > >             Item(Local ): Usage, data=3D [ 0xe2 ] 226
> > >                             Mute
> > >             Item(Local ): Usage, data=3D [ 0xe9 ] 233
> > >                             Volume Increment
> > > ...
> >=20
> > This describes an input device that reports 'key' presses to the
> > computer.  I guess the control panel and remote control don't have a
> > direct effect but expect the computer to explicitly change mixer
> > controls when a key is pressed.
>=20
> Since it works fine in Windows without any non-ms software, would this=20
> imply that this is somewhat standard behavior?
>=20
> >=20
> > However, this shouldn't prevent alsamixer from working.
> >=20
> > It might be possible that the mixer controls don't have many steps and
> > that the step size used by alsamixer is so small that the device rounds
> > the setting back to the old position.  Please try PageUp/Down or Home/
> > End instead of Up/Down keys.
>=20
> PgUp/PgDown don't do any better on any controls. I seem to be able to=20
> drop the PCM volume to nothing in practice with End, but Home won't=20
> restore it. Up/Down immediately brings it back up to 100%. The LED's on=
=20
> the control reflect this btw, but alsamixer still reports 98%.

The control pad wouldn't be an especially big deal, if only alsamixer did w=
ork right.


--=20
Jeremy Nickurak -=3D Email/Jabber: atrus@rifetech.com =3D-

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG2Ow5tjFmtbiy5uYRApE0AJ0byqBGycBFB4A237/4hq8GfF0hZwCdGF/f
/uVWSmwHiZ4s9M7QJ6HcMNk=
=Pgtp
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--===============7016025222377535676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7016025222377535676==--
