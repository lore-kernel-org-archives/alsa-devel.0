From: wwp <subscript@free.fr>
Subject: Re: Audigy4 support
Date: Fri, 24 Feb 2006 19:58:35 +0100
Message-ID: <20060224195835.457552d8@localhost.localdomain>
References: <20060222194029.1709b043@localhost.localdomain>
	<s5hd5hcvcjx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_ddBblnRVYFT6hcDJOXcDkMI;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5hcvcjx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Sig_ddBblnRVYFT6hcDJOXcDkMI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Takashi,


On Fri, 24 Feb 2006 19:25:54 +0100 Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 22 Feb 2006 19:40:29 +0100,
> wwp wrote:
> >=20
> > [1  <multipart/mixed (7bit)>]
> > [1.1  <text/plain; US-ASCII (quoted-printable)>]
> > Hello all,
> >=20
> >=20
> > I've got a brand new Audigy4 PCI sound-card, running on Debian unstable
> > (kernel 2.6.15, feat. Alsa 1.0.10+1.0.11-rc2-2).
> >=20
> > I'm able to get PCM out but can't get line-in to work: the alsa mixer
> > allows un-muting line-in but I can't get the input selector in audacity
> > for instance.
> >=20
> >=20
> > The exact model is a Creative SoundBlaster Audigy 4 retail (purchase da=
te:
> > 20060219, UK) w/ remote controler RM-1500.
> >=20
> > 0000:00:0a.0 0401: 1102:0008
> > Here was lspci says:
> >=20
> > 0000:00:0a.0 Multimedia audio controller: Creative Labs SB0400 Audigy2
> > Value Subsystem: Creative Labs: Unknown device 1021
> > 		 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> > VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF-
> > FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PER=
R-
> > Latency: 32 (500ns min, 5000ns max) Interrupt: pin A routed to IRQ 12
> > 		 Region 0: I/O ports at d400 [size=3D64]
> > 		 Capabilities: [dc] Power Management version 2
> > 				 Flags: PMEClk- DSI+ D1+ D2+
> > AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
> > DSel=3D0 DScale=3D0 PME-
> >=20
> >=20
> > I've found that the emu10k1 sources (checked at 1.0.11-rc3) don't inclu=
de
> > the card IDs, would the attached patch do it? Would that one be enough =
to
> > get proper line-in support?
>=20
> Are you sue that the patch really works for you?
> 1102:2008 are _not_ subsystem IDs but the normal PCI IDs.
>=20
> The subsystem number in the emu10k1's chip table is what you get as
> the serial number in /proc/asound/cards (perhaps 0x10211102).

Well, I never said that the patch worked neither that I've applied it :-).
No, I just wrote it as I assumed, wrongly, that it was a possible solution =
to
submit before I set up a customized kernel configuration from the sources.
Sorry for this confusion.

Here's what `cat /proc/asound/cards` shows:

0 [Audigy2        ]: Audigy2 - Audigy 2 Value [Unknown]
                     Audigy 2 Value [Unknown] (rev.0, serial:0x10211102) at=
 0xd400, irq 12
1 [UART           ]: MPU-401 UART - MPU-401 UART
                     MPU-401 UART at 0x330, irq 5


Now.. what to do? Should I provide more information? What to expect?


> > BTW, is it normal that the chip_detail table shows .id Audigy2 for Audi=
gy4
> > cards? Is emu10k1 falling back to Audigy2 Value when it doesn't know the
> > exact card IDs?
>=20
> It's correct behavior.  "Audigy2" is just the driver model name.  As
> long as Audigy4 uses the same configuration as Audigy2, there is no
> reason to introduce a new incompatibility.

Thanks for this clarification!
=20

Regards,

> > Here are some references more:
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1868
> > http://www.creative.com/products/product.asp?category=3D1&subcategory=
=3D434&product=3D14103
> >=20
> >=20
> > Regards,
> >=20
> > --=20
> > wwp
> > [1.2 alsa-driver-1.0.11rc3-audigy4-sb0400.diff <text/x-patch
> > (quoted-printable)>] --- emu10k1_main.c.orig	2006-02-22
> > 18:24:06.000000000 +0100 +++ emu10k1_main.c	2006-02-22
> > 18:24:12.000000000 +0100 @@ -824,6 +824,16 @@
> >  	 .emu10k2_chip =3D 1,
> >  	 .ca0102_chip =3D 1,
> >  	 .emu1212m =3D 1} ,
> > +	/* Tested by claws 22nd February 2006 */
> > +	{.vendor =3D 0x1102, .device =3D 0x0004, .subsystem =3D 0x20081102,
> > +	 .driver =3D "Audigy2", .name =3D "Audigy 4 [SB0400]",=20
> > +	 .id =3D "Audigy2",
> > +	 .emu10k2_chip =3D 1,
> > +	 .ca0102_chip =3D 1,
> > +	 .ca0151_chip =3D 1,
> > +	 .spk71 =3D 1,
> > +	 .spdif_bug =3D 1,
> > +	 .ac97_chip =3D 1} ,
> >  	/* Tested by James@superbug.co.uk 3rd July 2005 */
> >  	{.vendor =3D 0x1102, .device =3D 0x0004, .subsystem =3D 0x20071102,
> >  	 .driver =3D "Audigy2", .name =3D "Audigy 4 PRO [SB0380]",=20
> > --- p16v.c.orig	2005-12-22 18:01:20.000000000 +0100
> > +++ p16v.c	2006-02-22 18:24:46.000000000 +0100
> > @@ -118,6 +118,7 @@
> >   * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:1007 -> Audigy2 6.1
> > Model:SB0240
> >   * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:1002 -> Audigy2
> > Platinum  Model:SB msb0240230009266
> >   * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:2007 -> Audigy4 Pro
> > Model:SB0380 M1SB0380472001901E
> > + * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:2008 -> Audigy4
> > Model:SB0400 *
> >   */
> > =20
> > [2 signature.asc <application/pgp-signature (7bit)>]
> >=20
>=20


--=20
wwp

--Sig_ddBblnRVYFT6hcDJOXcDkMI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD4DBQFD/1dfadgnuQFKG88RAjRUAJYhxGMWaeJCYOUo4CiKl2j6KV9+AJ9hybnj
y7HQN7NcCAUnH7LpmMarjg==
=4WbM
-----END PGP SIGNATURE-----

--Sig_ddBblnRVYFT6hcDJOXcDkMI--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
