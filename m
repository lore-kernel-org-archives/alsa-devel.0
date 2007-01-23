From: <jmsgrtn-alsa@yahoo.com>
Subject: RE : Re: No sound with intel hda driver on a sony vaio
	vgx xl100 system
Date: Tue, 23 Jan 2007 23:46:42 +0100 (CET)
Message-ID: <472402.83858.qm@web36808.mail.mud.yahoo.com>
References: <1169503839.31789.100.camel@localhost>
Reply-To: jmsgrtn-alsa@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1169503839.31789.100.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have tried both model. none of them works.
Is there anything I missed ?

--- Tobin Davis <tdavis@dsl-only.net> a =E9crit :

> Your subsystem ID (104d:81f7) is not listed in the driver currently.
> The driver is configured to use the generic parser if it can't find a
> match.
> =

> There are two defined models for your codec (vaio, vaio-ar).  Try
> loading the driver with one of those models as follows:
> modprobe -r snd-hda-intel                  # remove driver
> modprobe snd-hda-intel model=3Dvaio  # reload with model deffinition
> =

> Try both model deffinitions to see which works better for you.  Report
> back your results and we'll get it added.
> =

> Thanks,
> =

> Tobin Davis
> =

> On Mon, 2007-01-22 at 22:22 +0100, jmsgrtn-alsa@yahoo.com wrote:
> =

> > Hi
> > =

> > I can't have any sound on my sony VAIO vgx-xl100 system with the 1.0.14=
rc2
> > build on a 2.6.18 kernel (debian)
> > =

> > the output of lspci -nv is :
> > =

> > 00:1b.0 0403: 8086:27d8 (rev 01)
> > 	Subsystem: 104d:81f7
> > 	Flags: bus master, fast devsel, latency 0, IRQ 169
> > 	Memory at fdff8000 (64-bit, non-prefetchable) [size=3D16K]
> > 	Capabilities: <access denied>
> > =

> > dmesg gives :
> > =

> > ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> > PCI: Enabling device 0000:00:1b.0 (0000 -> 0002)
> > ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
> > PCI: Setting latency timer of device 0000:00:1b.0 to 64
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_in=
tel.c:696:
> > codec_mask =3D 0x1
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:611:
> > AUD_IN =3D 6
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:233:
> > UNMUTE IN: NID=3D0x6 IDX=3D0x0
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:233:
> > UNMUTE IN: NID=3D0xe IDX=3D0x0
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:233:
> > UNMUTE IN: NID=3D0x7 IDX=3D0x0
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:217:
> > UNMUTE OUT: NID=3D0x7
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:648:
> > [Capture Source] NID=3D0x6, #SRC=3D1
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:651:
> >   [Line] IDX=3D0x0
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:289:
> > AUD_OUT found 2
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:233:
> > UNMUTE IN: NID=3D0xa IDX=3D0x0
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:217:
> > UNMUTE OUT: NID=3D0xa
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:217:
> > UNMUTE OUT: NID=3D0xa
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:251:
> > CONNECT: NID=3D0x6 IDX=3D0x0
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:713:
> > [Master Playback Switch] NID=3D0x2, DIR=3DOUT
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_ge=
neric.c:733:
> > [Master Playback Volume] NID=3D0x2, DIR=3DOUT
> > =

> > and the contents of /proc/asound/card0/codec# is :
> > =

> > Codec: SigmaTel CXD9872RD/K
> > Address: 0
> > Vendor Id: 0x83847661
> > Subsystem Id: 0x104d0b00
> > Revision Id: 0x104201
> > Default PCM:
> >     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
> >     bits [0xe]: 16 20 24
> >     formats [0x1]: PCM
> > Default Amp-In caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=
=3D1
> > Default Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=
=3D1
> > Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
> >   Amp-Out caps: N/A
> >   Amp-Out vals:  [0x3c 0x3c]
> >   Power: 0x0
> > Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
> >   Amp-Out caps: N/A
> >   Amp-Out vals:  [0xff 0xff]
> >   Power: 0x0
> > Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
> >   Amp-Out caps: N/A
> >   Amp-Out vals:  [0xff 0xff]
> >   Power: 0x0
> > Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
> >   Amp-Out caps: N/A
> >   Amp-Out vals:  [0x3c 0x3c]
> >   Power: 0x0
> > Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
> >   Power: 0x0
> >   Connection: 1
> >      0x07
> > Node 0x07 [Audio Selector] wcaps 0x300903: Stereo Amp-In
> >   Amp-In caps: N/A
> >   Amp-In vals:  [0x00 0x00]
> >   Connection: 1
> >      0x0e
> > Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
> >   Power: 0x0
> >   Connection: 1
> >      0x09
> > Node 0x09 [Audio Selector] wcaps 0x300903: Stereo Amp-In
> >   Amp-In caps: N/A
> >   Amp-In vals:  [0x80 0x80]
> >   Connection: 1
> >      0x15
> > Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
> >   Pincap 0x08173c: IN OUT HP Detect
> >   Pin Default 0x02024110: [Jack] Line Out at Ext Front
> >     Conn =3D 1/4, Color =3D Green
> >   Pin-ctls: 0xc0: OUT HP
> >   Connection: 1
> >      0x02
> > Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
> >   Pincap 0x0814: OUT Detect
> >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> >     Conn =3D 1/8, Color =3D Black
> >   Pin-ctls: 0x00:
> >   Connection: 1
> >      0x04
> > Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
> >   Pincap 0x0814: OUT Detect
> >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> >     Conn =3D 1/8, Color =3D Black
> >   Pin-ctls: 0x00:
> >   Connection: 1
> >      0x03
> > Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
> >   Pincap 0x08173c: IN OUT HP Detect
> >   Pin Default 0x02a19920: [Jack] Mic at Ext Front
> >     Conn =3D 1/8, Color =3D Pink
> >   Pin-ctls: 0x24: IN
> >   Connection: 1
> >      0x02
> > Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
> >   Pincap 0x0824: IN Detect
> >   Pin Default 0x01845121: [Jack] Line In at Ext Rear
> >     Conn =3D RCA, Color =3D Red
> >   Pin-ctls: 0x20: IN
> > Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
> >   Pincap 0x0814: OUT Detect
> >   Pin Default 0x01045111: [Jack] Line Out at Ext Rear
> >     Conn =3D RCA, Color =3D Red
> >   Pin-ctls: 0x40: OUT
> >   Connection: 1
> >      0x05
> > Node 0x10 [Audio Output] wcaps 0x40211: Stereo Digital
> >   PCM:
> >     rates [0x3e0]: 44100 48000 88200 96000 176400
> >     bits [0xe]: 16 20 24
> >     formats [0x5]: PCM AC3
> > Node 0x11 [Pin Complex] wcaps 0x400301: Stereo Digital
> >   Pincap 0x0810: OUT
> >   Pin Default 0x01451112: [Jack] SPDIF Out at Ext Rear
> >     Conn =3D Optical, Color =3D Black
> >   Pin-ctls: 0x00:
> >   Connection: 2
> >      0x10* 0x09
> > Node 0x12 [Audio Input] wcaps 0x140311: Stereo Digital
> >   PCM:
> >     rates [0x160]: 44100 48000 96000
> >     bits [0xe]: 16 20 24
> =

=3D=3D=3D message truncated =3D=3D=3D



	=


	=

		=

___________________________________________________________________________ =

D=E9couvrez une nouvelle fa=E7on d'obtenir des r=E9ponses =E0 toutes vos qu=
estions ! =

Profitez des connaissances, des opinions et des exp=E9riences des internaut=
es sur Yahoo! Questions/R=E9ponses =

http://fr.answers.yahoo.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
