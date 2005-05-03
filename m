From: Giuseppe Miletto <beppe.miletto@tiscali.it>
Subject: Re: Re: [Alsa-user] Re: [linux-audio-dev] E-MU 1212m Linux drivers
Date: Tue, 3 May 2005 23:34:52 +0200
Message-ID: <200505032334.52210.beppe.miletto@tiscali.it>
References: <200505010231.19540.beppe.miletto@tiscali.it> <1114992424.23959.5.camel@mindpipe> <427580EE.6040500@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <427580EE.6040500@superbug.co.uk>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Alle 03:22, luned=EC 2 maggio 2005, James Courtier-Dutton ha scritto:
> Lee Revell wrote:
> > On Sun, 2005-05-01 at 19:30 -0400, Lee Revell wrote:
> >>On Mon, 2005-05-02 at 01:24 +0200, Giuseppe Miletto wrote:
> >>>Alle 02:41, domenica 1 maggio 2005, hai scritto:
> >>>>On Sun, 2005-05-01 at 02:31 +0200, Giuseppe Miletto wrote:
> >>>>>I've already bought a EMU-1212 and I've doing very good job with
> >>>>> windows operating system. This has been a forced choice: trying to
> >>>>> use EMU-1212 with my suse 9.2 linux system I haven't been able to go
> >>>>> over the use of MIDI port of my EMU-1212.
> >>>>>Since I'm still an entusiastic of linux, I'll be very gratefull if
> >>>>> some linux driver allow me to work with my EMU-1212 under this
> >>>>> system: the only use of windows I'm doing now is for sound and
> >>>>> music.And EMU-1212 is really a great soundcard.
> >>>>
> >>>>Can you provide the "lspci -vn" output?  It's possible that some
> >>>>functionality will work if the driver just treats the card like an APS
> >>>>(that is, an emu10k1 with no AC97).
> >>>>
> >>>>Lee
> >>>
> >>>Hereby is what you asked for.
> >>>Thanks in advance
> >>>BYE
> >>
> >>James, here's the entry for the 1212m:
> >>
> >>0000:02:0a.0 Class 0401: 1102:0004 (rev 03)
> >>        Subsystem: 1102:4001
> >>        Flags: bus master, medium devsel, latency 32, IRQ 5
> >>        I/O ports at 9000
> >>        Capabilities: [dc] Power Management version 2
> >>
> >>Let's add this to the driver & see what happens.  I'll try to get a
> >>patch together, feel free to post one if you get a chance before I do.
> >
> > Please try this patch against ALSA CVS.  It should cause the emu10k1
> > driver to claim this device.
> >
> > I have no idea what will happen, it could work, or lock up your machine.
> >
> > Lee
> >
> > Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
> > retrieving revision 1.55
> > diff -u -r1.55 emu10k1_main.c
> > --- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	10 Apr 2005 14:43:35
> > -0000	1.55 +++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	2 May 2005
> > 00:06:38 -0000 @@ -700,6 +700,10 @@
> >  	 .emu10k2_chip =3D 1,
> >  	 .ca0102_chip =3D 1,
> >  	 .ac97_chip =3D 1} ,
> > +	{.vendor =3D 0x1102, .device =3D 0x0004, .subsystem =3D 0x40011102,
> > +	 .driver =3D "EMU10K1", .name =3D "E-mu 1212m [4001]",
> > +	 .id =3D "1212m",
> > +	 .emu10k1_chip =3D 1} ,
> >  	{.vendor =3D 0x1102, .device =3D 0x0004,
> >  	 .driver =3D "Audigy", .name =3D "Audigy 1 [Unknown]",
> >  	 .id =3D "Audigy",
>
> Yes, well, that's really going to work isn't it!!!
>
> > +	 .emu10k1_chip =3D 1} ,
>
> Me thinks ".emu10k2_chip =3D 1}, " would be more like it. :-)


Thanks to you,
I think you both gave me a solution but really I don't know how to manage t=
he=20
listed instruction.
I've a SUSE 9.2 linux version and I use usually YAST2 to confgiure the syst=
em.
Moreover when all my sound system is halted (for example when I want to use=
=20
Audacity ans it's not able to find the sound card - the Intel one built in =
in=20
the motherboard) I run alsaconf as su.
I've not able to do more than this.
Do you think you can help me more than already done?
Grateful in advance.

Beppe Miletto

=2D-=20
Giuseppe Miletto
Via Campi Rotondi, 35
10020 Cambiano (TO)
tel.      +390119442144
cell.     +393487659488
mailto:   beppe.miletto@tiscali.it
sito web: http://www.elletici.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
