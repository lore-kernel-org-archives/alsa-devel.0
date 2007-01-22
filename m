From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: No sound with intel hda driver on a sony vaio
	vgx	xl100 system
Date: Mon, 22 Jan 2007 14:10:39 -0800
Message-ID: <1169503839.31789.100.camel@localhost>
References: <486159.63650.qm@web36806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0660058543=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <486159.63650.qm@web36806.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: jmsgrtn-alsa@yahoo.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0660058543==
Content-Type: multipart/alternative; boundary="=-AED56a0+YmEx9vEsfBtB"


--=-AED56a0+YmEx9vEsfBtB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Your subsystem ID (104d:81f7) is not listed in the driver currently.
The driver is configured to use the generic parser if it can't find a
match.

There are two defined models for your codec (vaio, vaio-ar).  Try
loading the driver with one of those models as follows:
modprobe -r snd-hda-intel                  # remove driver
modprobe snd-hda-intel model=3Dvaio  # reload with model deffinition

Try both model deffinitions to see which works better for you.  Report
back your results and we'll get it added.

Thanks,

Tobin Davis

On Mon, 2007-01-22 at 22:22 +0100, jmsgrtn-alsa@yahoo.com wrote:

> Hi
>=20
> I can't have any sound on my sony VAIO vgx-xl100 system with the 1.0.14=
rc2
> build on a 2.6.18 kernel (debian)
>=20
> the output of lspci -nv is :
>=20
> 00:1b.0 0403: 8086:27d8 (rev 01)
> 	Subsystem: 104d:81f7
> 	Flags: bus master, fast devsel, latency 0, IRQ 169
> 	Memory at fdff8000 (64-bit, non-prefetchable) [size=3D16K]
> 	Capabilities: <access denied>
>=20
> dmesg gives :
>=20
> ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> PCI: Enabling device 0000:00:1b.0 (0000 -> 0002)
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_intel.c:696:
> codec_mask =3D 0x1
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:611:
> AUD_IN =3D 6
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:233:
> UNMUTE IN: NID=3D0x6 IDX=3D0x0
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:233:
> UNMUTE IN: NID=3D0xe IDX=3D0x0
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:233:
> UNMUTE IN: NID=3D0x7 IDX=3D0x0
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:217:
> UNMUTE OUT: NID=3D0x7
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:648:
> [Capture Source] NID=3D0x6, #SRC=3D1
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:651:
>   [Line] IDX=3D0x0
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:289:
> AUD_OUT found 2
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:233:
> UNMUTE IN: NID=3D0xa IDX=3D0x0
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:217:
> UNMUTE OUT: NID=3D0xa
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:217:
> UNMUTE OUT: NID=3D0xa
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:251:
> CONNECT: NID=3D0x6 IDX=3D0x0
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:713:
> [Master Playback Switch] NID=3D0x2, DIR=3DOUT
> ALSA
> /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hd=
a_generic.c:733:
> [Master Playback Volume] NID=3D0x2, DIR=3DOUT
>=20
> and the contents of /proc/asound/card0/codec# is :
>=20
> Codec: SigmaTel CXD9872RD/K
> Address: 0
> Vendor Id: 0x83847661
> Subsystem Id: 0x104d0b00
> Revision Id: 0x104201
> Default PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D=
1
> Default Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=3D=
1
> Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x3c 0x3c]
>   Power: 0x0
> Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0xff 0xff]
>   Power: 0x0
> Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0xff 0xff]
>   Power: 0x0
> Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x3c 0x3c]
>   Power: 0x0
> Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
>   Power: 0x0
>   Connection: 1
>      0x07
> Node 0x07 [Audio Selector] wcaps 0x300903: Stereo Amp-In
>   Amp-In caps: N/A
>   Amp-In vals:  [0x00 0x00]
>   Connection: 1
>      0x0e
> Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
>   Power: 0x0
>   Connection: 1
>      0x09
> Node 0x09 [Audio Selector] wcaps 0x300903: Stereo Amp-In
>   Amp-In caps: N/A
>   Amp-In vals:  [0x80 0x80]
>   Connection: 1
>      0x15
> Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x08173c: IN OUT HP Detect
>   Pin Default 0x02024110: [Jack] Line Out at Ext Front
>     Conn =3D 1/4, Color =3D Green
>   Pin-ctls: 0xc0: OUT HP
>   Connection: 1
>      0x02
> Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn =3D 1/8, Color =3D Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x04
> Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn =3D 1/8, Color =3D Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x03
> Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x08173c: IN OUT HP Detect
>   Pin Default 0x02a19920: [Jack] Mic at Ext Front
>     Conn =3D 1/8, Color =3D Pink
>   Pin-ctls: 0x24: IN
>   Connection: 1
>      0x02
> Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
>   Pincap 0x0824: IN Detect
>   Pin Default 0x01845121: [Jack] Line In at Ext Rear
>     Conn =3D RCA, Color =3D Red
>   Pin-ctls: 0x20: IN
> Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x01045111: [Jack] Line Out at Ext Rear
>     Conn =3D RCA, Color =3D Red
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x05
> Node 0x10 [Audio Output] wcaps 0x40211: Stereo Digital
>   PCM:
>     rates [0x3e0]: 44100 48000 88200 96000 176400
>     bits [0xe]: 16 20 24
>     formats [0x5]: PCM AC3
> Node 0x11 [Pin Complex] wcaps 0x400301: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x01451112: [Jack] SPDIF Out at Ext Rear
>     Conn =3D Optical, Color =3D Black
>   Pin-ctls: 0x00:
>   Connection: 2
>      0x10* 0x09
> Node 0x12 [Audio Input] wcaps 0x140311: Stereo Digital
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0xe]: 16 20 24
>     formats [0x5]: PCM AC3
>   Connection: 1
>      0x13
> Node 0x13 [Pin Complex] wcaps 0x440381: Stereo Digital
>   Pincap 0x0834: IN OUT Detect
>   Pin Default 0x01c51122: [Jack] SPDIF In at Ext Rear
>     Conn =3D Optical, Color =3D Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x18
> Node 0x14 [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn =3D 1/8, Color =3D Black
>   Pin-ctls: 0x20: IN
> Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>   Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D1
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 4
>      0x0a 0x0d* 0x14 0x02
> Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>   Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D0
>   Amp-Out vals:  [0x00]
> Node 0x17 [Volume Knob Widget] wcaps 0x600000: Mono
> Node 0x18 [Audio Output] wcaps 0x40201: Stereo Digital
>=20
>=20
>=20
> ---------------------------------
> Jean-Marc Segretain
> mailto:jmsegretain@yahoo.com=20
>=20
>=20
>=20
> =09
>=20
> =09
> 	=09
> _______________________________________________________________________=
____=20
> D=C3=A9couvrez une nouvelle fa=C3=A7on d'obtenir des r=C3=A9ponses =C3=A0=
 toutes vos questions !=20
> Profitez des connaissances, des opinions et des exp=C3=A9riences des in=
ternautes sur Yahoo! Questions/R=C3=A9ponses=20
> http://fr.answers.yahoo.com
>=20
> -----------------------------------------------------------------------=
--
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share=
 your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=20
Tobin Davis <tdavis@dsl-only.net>

--=-AED56a0+YmEx9vEsfBtB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Your subsystem ID (<FONT COLOR="#000000">104d:81f7</FONT>) is not listed in the driver currently.&nbsp; The driver is configured to use the generic parser if it can't find a match.<BR>
<BR>
There are two defined models for your codec (vaio, vaio-ar).&nbsp; Try loading the driver with one of those models as follows:<BR>
modprobe -r snd-hda-intel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # remove driver<BR>
modprobe snd-hda-intel model=vaio&nbsp; # reload with model deffinition<BR>
<BR>
Try both model deffinitions to see which works better for you.&nbsp; Report back your results and we'll get it added.<BR>
<BR>
Thanks,<BR>
<BR>
Tobin Davis<BR>
<BR>
On Mon, 2007-01-22 at 22:22 +0100, jmsgrtn-alsa@yahoo.com wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi</FONT>

<FONT COLOR="#000000">I can't have any sound on my sony VAIO vgx-xl100 system with the 1.0.14rc2</FONT>
<FONT COLOR="#000000">build on a 2.6.18 kernel (debian)</FONT>

<FONT COLOR="#000000">the output of lspci -nv is :</FONT>

<FONT COLOR="#000000">00:1b.0 0403: 8086:27d8 (rev 01)</FONT>
<FONT COLOR="#000000">	Subsystem: 104d:81f7</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0, IRQ 169</FONT>
<FONT COLOR="#000000">	Memory at fdff8000 (64-bit, non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">	Capabilities: &lt;access denied&gt;</FONT>

<FONT COLOR="#000000">dmesg gives :</FONT>

<FONT COLOR="#000000">ACPI: PCI interrupt for device 0000:00:1b.0 disabled</FONT>
<FONT COLOR="#000000">PCI: Enabling device 0000:00:1b.0 (0000 -&gt; 0002)</FONT>
<FONT COLOR="#000000">ACPI: PCI Interrupt 0000:00:1b.0[A] -&gt; GSI 16 (level, low) -&gt; IRQ 169</FONT>
<FONT COLOR="#000000">PCI: Setting latency timer of device 0000:00:1b.0 to 64</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:</FONT>
<FONT COLOR="#000000">codec_mask = 0x1</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:611:</FONT>
<FONT COLOR="#000000">AUD_IN = 6</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:233:</FONT>
<FONT COLOR="#000000">UNMUTE IN: NID=0x6 IDX=0x0</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:233:</FONT>
<FONT COLOR="#000000">UNMUTE IN: NID=0xe IDX=0x0</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:233:</FONT>
<FONT COLOR="#000000">UNMUTE IN: NID=0x7 IDX=0x0</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:217:</FONT>
<FONT COLOR="#000000">UNMUTE OUT: NID=0x7</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:648:</FONT>
<FONT COLOR="#000000">[Capture Source] NID=0x6, #SRC=1</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:651:</FONT>
<FONT COLOR="#000000">  [Line] IDX=0x0</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:289:</FONT>
<FONT COLOR="#000000">AUD_OUT found 2</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:233:</FONT>
<FONT COLOR="#000000">UNMUTE IN: NID=0xa IDX=0x0</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:217:</FONT>
<FONT COLOR="#000000">UNMUTE OUT: NID=0xa</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:217:</FONT>
<FONT COLOR="#000000">UNMUTE OUT: NID=0xa</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:251:</FONT>
<FONT COLOR="#000000">CONNECT: NID=0x6 IDX=0x0</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:713:</FONT>
<FONT COLOR="#000000">[Master Playback Switch] NID=0x2, DIR=OUT</FONT>
<FONT COLOR="#000000">ALSA</FONT>
<FONT COLOR="#000000">/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:733:</FONT>
<FONT COLOR="#000000">[Master Playback Volume] NID=0x2, DIR=OUT</FONT>

<FONT COLOR="#000000">and the contents of /proc/asound/card0/codec# is :</FONT>

<FONT COLOR="#000000">Codec: SigmaTel CXD9872RD/K</FONT>
<FONT COLOR="#000000">Address: 0</FONT>
<FONT COLOR="#000000">Vendor Id: 0x83847661</FONT>
<FONT COLOR="#000000">Subsystem Id: 0x104d0b00</FONT>
<FONT COLOR="#000000">Revision Id: 0x104201</FONT>
<FONT COLOR="#000000">Default PCM:</FONT>
<FONT COLOR="#000000">    rates [0x7e0]: 44100 48000 88200 96000 176400 192000</FONT>
<FONT COLOR="#000000">    bits [0xe]: 16 20 24</FONT>
<FONT COLOR="#000000">    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">Default Amp-In caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1</FONT>
<FONT COLOR="#000000">Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x3c 0x3c]</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0xff 0xff]</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0xff 0xff]</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x3c 0x3c]</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x07</FONT>
<FONT COLOR="#000000">Node 0x07 [Audio Selector] wcaps 0x300903: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x0e</FONT>
<FONT COLOR="#000000">Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x09</FONT>
<FONT COLOR="#000000">Node 0x09 [Audio Selector] wcaps 0x300903: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x15</FONT>
<FONT COLOR="#000000">Node 0x0a [Pin Complex] wcaps 0x400181: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x08173c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x02024110: [Jack] Line Out at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/4, Color = Green</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0xc0: OUT HP</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x02</FONT>
<FONT COLOR="#000000">Node 0x0b [Pin Complex] wcaps 0x400181: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0814: OUT Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x04</FONT>
<FONT COLOR="#000000">Node 0x0c [Pin Complex] wcaps 0x400181: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0814: OUT Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x03</FONT>
<FONT COLOR="#000000">Node 0x0d [Pin Complex] wcaps 0x400181: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x08173c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x02a19920: [Jack] Mic at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Pink</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x02</FONT>
<FONT COLOR="#000000">Node 0x0e [Pin Complex] wcaps 0x400081: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0824: IN Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01845121: [Jack] Line In at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = RCA, Color = Red</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">Node 0x0f [Pin Complex] wcaps 0x400181: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0814: OUT Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01045111: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = RCA, Color = Red</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x05</FONT>
<FONT COLOR="#000000">Node 0x10 [Audio Output] wcaps 0x40211: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM:</FONT>
<FONT COLOR="#000000">    rates [0x3e0]: 44100 48000 88200 96000 176400</FONT>
<FONT COLOR="#000000">    bits [0xe]: 16 20 24</FONT>
<FONT COLOR="#000000">    formats [0x5]: PCM AC3</FONT>
<FONT COLOR="#000000">Node 0x11 [Pin Complex] wcaps 0x400301: Stereo Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">  Pin Default 0x01451112: [Jack] SPDIF Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = Optical, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x10* 0x09</FONT>
<FONT COLOR="#000000">Node 0x12 [Audio Input] wcaps 0x140311: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM:</FONT>
<FONT COLOR="#000000">    rates [0x160]: 44100 48000 96000</FONT>
<FONT COLOR="#000000">    bits [0xe]: 16 20 24</FONT>
<FONT COLOR="#000000">    formats [0x5]: PCM AC3</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x13</FONT>
<FONT COLOR="#000000">Node 0x13 [Pin Complex] wcaps 0x440381: Stereo Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0834: IN OUT Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01c51122: [Jack] SPDIF In at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = Optical, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x18</FONT>
<FONT COLOR="#000000">Node 0x14 [Pin Complex] wcaps 0x400001: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 4</FONT>
<FONT COLOR="#000000">     0x0a 0x0d* 0x14 0x02</FONT>
<FONT COLOR="#000000">Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00]</FONT>
<FONT COLOR="#000000">Node 0x17 [Volume Knob Widget] wcaps 0x600000: Mono</FONT>
<FONT COLOR="#000000">Node 0x18 [Audio Output] wcaps 0x40201: Stereo Digital</FONT>



<FONT COLOR="#000000">---------------------------------</FONT>
<FONT COLOR="#000000">Jean-Marc Segretain</FONT>
<FONT COLOR="#000000">mailto:<A HREF="mailto:jmsegretain@yahoo.com">jmsegretain@yahoo.com</A> </FONT>



<FONT COLOR="#000000">	</FONT>

<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">___________________________________________________________________________ </FONT>
<FONT COLOR="#000000">D&#233;couvrez une nouvelle fa&#231;on d'obtenir des r&#233;ponses &#224; toutes vos questions ! </FONT>
<FONT COLOR="#000000">Profitez des connaissances, des opinions et des exp&#233;riences des internautes sur Yahoo! Questions/R&#233;ponses </FONT>
<FONT COLOR="#000000"><A HREF="http://fr.answers.yahoo.com">http://fr.answers.yahoo.com</A></FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-AED56a0+YmEx9vEsfBtB--



--===============0660058543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0660058543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0660058543==--
