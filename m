From: wwp <subscript@free.fr>
Subject: Re: Audigy4 support
Date: Sat, 25 Feb 2006 12:01:57 +0100
Message-ID: <20060225120157.0fad0068@localhost.localdomain>
References: <20060222194029.1709b043@localhost.localdomain>
	<s5hd5hcvcjx.wl%tiwai@suse.de>
	<20060224195835.457552d8@localhost.localdomain>
	<s5h4q2ovav5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_OsnHnPqIDFdN=96OLn5+yK2";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q2ovav5.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Sig_OsnHnPqIDFdN=96OLn5+yK2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Takashi,


On Fri, 24 Feb 2006 20:02:22 +0100 Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 24 Feb 2006 19:58:35 +0100,
> wwp wrote:
> >=20
> > Hello Takashi,
> >=20
> >=20
> > On Fri, 24 Feb 2006 19:25:54 +0100 Takashi Iwai <tiwai@suse.de> wrote:
> >=20
> > > At Wed, 22 Feb 2006 19:40:29 +0100,
> > > wwp wrote:
> > > >=20
> > > > [1  <multipart/mixed (7bit)>]
> > > > [1.1  <text/plain; US-ASCII (quoted-printable)>]
> > > > Hello all,
> > > >=20
> > > >=20
> > > > I've got a brand new Audigy4 PCI sound-card, running on Debian
> > > > unstable (kernel 2.6.15, feat. Alsa 1.0.10+1.0.11-rc2-2).
> > > >=20
> > > > I'm able to get PCM out but can't get line-in to work: the alsa mix=
er
> > > > allows un-muting line-in but I can't get the input selector in
> > > > audacity for instance.
> > > >=20
> > > >=20
> > > > The exact model is a Creative SoundBlaster Audigy 4 retail (purchase
> > > > date: 20060219, UK) w/ remote controler RM-1500.
> > > >=20
> > > > 0000:00:0a.0 0401: 1102:0008
> > > > Here was lspci says:
> > > >=20
> > > > 0000:00:0a.0 Multimedia audio controller: Creative Labs SB0400 Audi=
gy2
> > > > Value Subsystem: Creative Labs: Unknown device 1021
> > > > 		 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> > > > VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF-
> > > > FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR-
> > > > <PERR- Latency: 32 (500ns min, 5000ns max) Interrupt: pin A routed =
to
> > > > IRQ 12 Region 0: I/O ports at d400 [size=3D64]
> > > > 		 Capabilities: [dc] Power Management version 2
> > > > 				 Flags: PMEClk- DSI+ D1+ D2+
> > > > AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Ena=
ble-
> > > > DSel=3D0 DScale=3D0 PME-
> > > >=20
> > > >=20
> > > > I've found that the emu10k1 sources (checked at 1.0.11-rc3) don't
> > > > include the card IDs, would the attached patch do it? Would that one
> > > > be enough to get proper line-in support?
> > >=20
> > > Are you sue that the patch really works for you?
> > > 1102:2008 are _not_ subsystem IDs but the normal PCI IDs.
> > >=20
> > > The subsystem number in the emu10k1's chip table is what you get as
> > > the serial number in /proc/asound/cards (perhaps 0x10211102).
> >=20
> > Well, I never said that the patch worked neither that I've applied it :=
-).
> > No, I just wrote it as I assumed, wrongly, that it was a possible
> > solution to submit before I set up a customized kernel configuration fr=
om
> > the sources. Sorry for this confusion.
> >=20
> > Here's what `cat /proc/asound/cards` shows:
> >=20
> > 0 [Audigy2        ]: Audigy2 - Audigy 2 Value [Unknown]
> >                      Audigy 2 Value [Unknown] (rev.0, serial:0x10211102)
> > at 0xd400, irq 12 1 [UART           ]: MPU-401 UART - MPU-401 UART
> >                      MPU-401 UART at 0x330, irq 5
> >=20
> >=20
> > Now.. what to do? Should I provide more information? What to expect?
>=20
> Try subsystem=3D0x10211102 module option with snd-emu10k1.
> It assumes that the subsystem is the given model.
>=20
> If that works, please create a write patch with correct parameters :)
>    .vendor =3D 0x1102, .device =3D 0x0008, .subsystem =3D 0x20121102
>    ...
> and check whether the driver works without extra module option.

Ouch! Seems that my cable was the culprit, line-in works now w/ a new cable
(wtf??). I'm really sorry for the noise. Anyway I'm still interested in
making Alsa recognizing this card.. what's next step, do you have all the
necessary information now?


Regards,

--=20
wwp

--Sig_OsnHnPqIDFdN=96OLn5+yK2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEADkladgnuQFKG88RAicMAJsGIyaWwp4Ux9OalQXO9Jdx9zbb5ACcCeaY
ZZPmX9hbdDG+8QHwtiy5crY=
=Zgsp
-----END PGP SIGNATURE-----

--Sig_OsnHnPqIDFdN=96OLn5+yK2--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
