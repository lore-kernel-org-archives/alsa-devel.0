From: Federico Quagliata <federico@quagliata.org>
Subject: HP dv6000t
Date: Mon, 20 Nov 2006 21:09:15 +0100
Message-ID: <ejt21b$qit$1@sea.gmane.org>
References: <4ea46bd50611201008t45951bafsf502f979a32e7bf5@mail.gmail.com>
	<1164046446.5390.234.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Tobin... I wrote you a private mail, but I'm not sure you got it as I had
problem with my mail server.

Here it is:

> I have a HP dv6000t laptop with 1 mic-in, 1-hp-out and 1-hp-spdif-out.
> =

> I use the latest alsa-drivers from the hg repository.
> =

> What works
> =A0- With model=3Dhp-laptop sound from speakers is correctly muted when I =

> plug the hp jack in both hp and spdif out. Headphones do work.
> =

> What doesn't
> =A0- The laptop has a "mute" orange led on the mute button that stays =

> always on, even when mute is off;
> =A0- mute on master only actually mute the line-out, not the
> =A0 =A0integrated speakers;
> =A0- recording: neither from line-in nor the internal mic.
> =

> =

> System informations
> =

> dmesg
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> =

> =

> lspci -s 0:1b -vn
> 00:1b.0 0403: 8086:27d8 (rev 02)
> =A0 =A0 =A0 =A0 Subsystem: 103c:30bb
> =A0 =A0 =A0 =A0 Flags: bus master, fast devsel, latency 0, IRQ 20
> =A0 =A0 =A0 =A0 Memory at de300000 (64-bit, non-prefetchable) [size=3D16K]
> =A0 =A0 =A0 =A0 Capabilities: [50] Power Management version 2
> =A0 =A0 =A0 =A0 Capabilities: [60] Message Signalled Interrupts: Mask- 64=
bit+ =

> Queue=3D0/0 Enable-
> =A0 =A0 =A0 =A0 Capabilities: [70] Express Unknown type IRQ 0
> =A0 =A0 =A0 =A0 Capabilities: [100] Virtual Channel
> =A0 =A0 =A0 =A0 Capabilities: [130] Unknown (5)
> =

> =

> cat /proc/asound/card0/codec#0
> Codec: Conexant CXT5045
> Address: 0
> Vendor Id: 0x14f15045
> Subsystem Id: 0x103c30bb
> Revision Id: 0x100100
> Default PCM:
> =A0 =A0 rates [0x140]: 48000 96000
> =A0 =A0 bits [0xe]: 16 20 24
> =A0 =A0 formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0 Amp-Out caps: ofs=3D0x2b, nsteps=3D0x2b, stepsize=3D0x05, mute=3D1
> =A0 Amp-Out vals: =A0[0x9c 0x9c]
> =A0 Pincap 0x0810014: OUT EAPD Detect
> =A0 Pin Default 0x90170110: [Fixed] Speaker at Int N/A
> =A0 =A0 Conn =3D Analog, Color =3D Unknown
> =A0 Pin-ctls: 0x40: OUT
> =A0 Power: 0x0
> =A0 Connection: 2
> =A0 =A0 =A00x19* 0x17
> Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0 Amp-Out caps: ofs=3D0x2b, nsteps=3D0x2b, stepsize=3D0x05, mute=3D1
> =A0 Amp-Out vals: =A0[0x1c 0x1c]
> =A0 Pincap 0x08113c: IN OUT HP Detect
> =A0 Pin Default 0x0121401f: [Jack] HP Out at Ext Rear
> =A0 =A0 Conn =3D 1/8, Color =3D Green
> =A0 Pin-ctls: 0x40: OUT
> =A0 Power: 0x0
> =A0 Connection: 2
> =A0 =A0 =A00x19* 0x17
> Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0 Amp-Out caps: ofs=3D0x2b, nsteps=3D0x2b, stepsize=3D0x05, mute=3D1
> =A0 Amp-Out vals: =A0[0xab 0xab]
> =A0 Pincap 0x08113c: IN OUT HP Detect
> =A0 Pin Default 0x01813030: [Jack] Line In at Ext Rear
> =A0 =A0 Conn =3D 1/8, Color =3D Blue
> =A0 Pin-ctls: 0x20: IN
> =A0 Power: 0x0
> =A0 Connection: 2
> =A0 =A0 =A00x19* 0x17
> Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
> =A0 Pincap 0x0810: OUT
> =A0 Pin Default 0x21447040: [Jack] SPDIF Out at Sep Rear
> =A0 =A0 Conn =3D RCA, Color =3D Yellow
> =A0 Pin-ctls: 0x00:
> =A0 Connection: 1
> =A0 =A0 =A00x18
> Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
> =A0 Pincap 0x081124: IN Detect
> =A0 Pin Default 0x97a70050: [Fixed] Mic at Int Riser
> =A0 =A0 Conn =3D Analog, Color =3D Unknown
> =A0 Pin-ctls: 0x20: IN
> Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
> =A0 Pincap 0x0820: IN
> =A0 Pin Default 0x99330060: [Fixed] CD at Int ATAPI
> =A0 =A0 Conn =3D ATAPI, Color =3D Unknown
> =A0 Pin-ctls: 0x00:
> Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
> =A0 Amp-Out caps: ofs=3D0x07, nsteps=3D0x07, stepsize=3D0x0b, mute=3D1
> =A0 Amp-Out vals: =A0[0x06]
> Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x14, nsteps=3D0x2b, stepsize=3D0x05, mute=3D1
> =A0 Amp-In vals: =A0[0x17 0x17] [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94 =

> 0x94]
> =A0 Power: 0x0
> =A0 Connection: 5
> =A0 =A0 =A00x19 0x14 0x12 0x11 0x15
> Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
> =A0 PCM:
> =A0 =A0 rates [0x40]: 48000
> =A0 =A0 bits [0x6]: 16 20
> =A0 =A0 formats [0x5]: PCM AC3
> Node 0x19 [Audio Output] wcaps 0xc11: Stereo
> =A0 PCM:
> =A0 =A0 rates [0x540]: 48000 96000 192000
> =A0 =A0 bits [0xe]: 16 20 24
> =A0 =A0 formats [0x1]: PCM
> =A0 Power: 0x0
> Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x17, stepsize=3D0x05, mute=3D1
> =A0 Amp-In vals: =A0[0x80 0x80] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 =

> 0x00]
> =A0 Power: 0x0
> =A0 Connection: 5
> =A0 =A0 =A00x17 0x14* 0x12 0x11 0x15
> Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono

Greetings,
Federico
-- =

On the web:  http://www.quaqo.org - OpenPGP KeyID: 0x1D535856
Jabber: quaqo@jabber.org - MSN: quaqo@msn.com - ICQ: 48618109
Linux User: #263663 / Machine: #341187 (Arch Linux / Gimmick)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
