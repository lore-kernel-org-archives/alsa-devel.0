From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: [Fwd: [kde] Low maximum volume with pulseaudio on
 kde]
Date: Sun, 19 Jun 2011 11:02:08 +0100
Message-ID: <1308477728.2355.7.camel@segulix>
References: <1308406497.32022.4.camel@segulix>
	<BANLkTiksXk01a8S1AufzpMP9J1bWSUU+SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-MFar6eqCZh4iCC3ZG/S9"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sapo.pt (relay2.ptmail.sapo.pt [212.55.154.22])
	by alsa0.perex.cz (Postfix) with SMTP id B2D78245DF
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jun 2011 12:02:31 +0200 (CEST)
Received: from unknown (HELO sergiomb.no-ip.org)
	(sergiomb@sapo.pt@[2.81.218.205])
	(envelope-sender <sergio@serjux.com>)
	by mta13 (qmail-ptmail-1.0.0) with AES256-SHA encrypted SMTP
	for <alsa-devel@alsa-project.org>; 19 Jun 2011 10:02:22 -0000
In-Reply-To: <BANLkTiksXk01a8S1AufzpMP9J1bWSUU+SA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-MFar6eqCZh4iCC3ZG/S9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2011-06-19 at 10:41 +0800, Raymond Yau wrote:=20
> 2011/6/18 S=C3=A9rgio Basto <sergio@serjux.com>:
> > -------- Forwarded Message --------
> > From: S=C3=A9rgio Basto <sergio@serjux.com>
> > Reply-to: kde@mail.kde.org
> > To: KDE ML <kde@mail.kde.org>
> > Subject: [kde] Low maximum volume with pulseaudio on kde
> > Date: Wed, 15 Jun 2011 23:04:26 +0100
> >
> > Hi, try again,
>=20
> Which sound card/HDA Codec are you using ?

in attach=20

> >
> > 1st - edit /etc/pulse/client.conf
> > and change
> > autospawn =3D no
> >
> > 2nd - killall pulseaudio
> >
> > 3rd - run on user env:
> > pulseaudio -vvv
> >
> > lets test with kmix I see on pulseaudio logs at maximum :
>=20
> which version of kmix/ubuntu are you using ?

Fedora 15 , kdemultimedia-4.6.3-1.fc15.x86_64=20

>=20
> AFAIK, the pulseaudio developer rewrorte kmix to use pulse api , and
> "new" kmix does not use alsa mixer api any more
>=20
> >
> > D: alsa-sink.c: Requested volume: 0: 100% 1: 100%
> > D: alsa-sink.c: Got hardware volume: 0: 100% 1: 100%
> > D: alsa-sink.c: Calculated software volume: 0: 100% 1: 100%
> > (accurate-enough=3Dyes)
> >
> > with gnome-control-center -> sound I see on pulseaudio logs at
> > maximum :
> >
> > D: protocol-native.c: Client gnome-control-center changes volume of s=
ink
> > alsa_output.pci-0000_00_1b.0.analog-stereo.
> > D: alsa-sink.c: Requested volume: 0: 153% 1: 153%
> > D: alsa-sink.c: Got hardware volume: 0: 100% 1: 100%
> > D: alsa-sink.c: Calculated software volume: 0: 153% 1: 153%
> > (accurate-enough=3Dno)
> >
> > so how I put kmix also control "software volume" since system use pul=
se-audio ?
> >
>=20
> gnome sound preference already used pulse api and this is why you can
> see value over 100%
>=20
> Those values over 100% are software gain and sound is distorted when
> clipping occur
>=20

yeah

> > I read this articles
> > http://www.webupd8.org/2009/08/increase-maximum-sound-level-in-ubuntu=
.html
>=20
> The example in the above URL is properly wrong  , since PA server does
> not use "default" device
>=20
> > http://alsa.opensrc.org/How_to_use_softvol_to_control_the_master_volu=
me
> >
>=20
> The "More complex example " in the above URL  for SBLive! Platinum
> [CT4760P] is also incorrect.
>=20
> When the application use
>=20
> 1) "hw" , the volume is controlled by "Wave Front" and "Wave Surround"
> controls as the sound card pan stereo to front and rear jacks
> 2) "front", the volume is controlled by "Front Playback Volume"
> 3) "rear",  the volume is controlled by "Surround Playback Volume"
> 4) "surround40" the volume is controlled by "Front Playback Volume"
> and "Surround Playback Volume"

I just want a way to control sofvol, with alsamixer , kmixer ( we know
that gnome-control-center -> sound already do that) ,  can you give me a
example that works.
Seems I don't have dmix either .=20

Thanks,=20


--=20
S=C3=A9rgio M. B.

--=-MFar6eqCZh4iCC3ZG/S9
Content-Disposition: attachment; filename="alsa-info.txt.DuaIjbrd46"
Content-Type: text/plain; name="alsa-info.txt.DuaIjbrd46"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Sun Jun 19 09:21:13 UTC 2011


!!Linux Distribution
!!------------------

Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock)


!!DMI Information
!!---------------

Manufacturer:      Dell Inc.
Product Name:      Latitude E6410
Product Version:   0001


!!Kernel Information
!!------------------

Kernel release:    2.6.38.8-32.fc15.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.23
Library version:    1.0.24
Utilities version:  1.0.24.1


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

aRts:
      Installed - Yes (/usr/bin/artsd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf6960000 irq 45


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 05)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:3b56 (rev 05)
	Subsystem: 1028:040a


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: IDT 92HD81B1C5
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x111d76d5
Subsystem Id: 0x1028040a
Revision Id: 0x100104
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=3, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Power-Map: 0x00
Node 0x0a [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Control: name="Mic Jack Mode", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Control: name="Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0001173c: IN OUT HP EAPD Detect
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x04a11020: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0421101f: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Power: setting=D0, actual=D0
  Connection: 3
     0x13 0x14* 0x1c
Node 0x0c [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00011734: IN OUT EAPD Detect
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x0d [Pin Complex] wcaps 0x400501: Stereo
  Pincap 0x00010050: OUT EAPD Balanced
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x0e [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x23011050: [Jack] Line Out at Sep Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power: setting=D0, actual=D0
  Connection: 3
     0x13 0x14* 0x1c
Node 0x0f [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Control: name="Dock Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x23a1102e: [Jack] Mic at Sep Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x20: IN
  Unsolicited: tag=04, enabled=1
  Power: setting=D0, actual=D0
  Connection: 3
     0x13 0x14* 0x1c
Node 0x10 [Pin Complex] wcaps 0x400500: Mono
  Pincap 0x00000010: OUT
  Pin Default 0x400000f3: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x3
  Pin-ctls: 0x00:
  Power: setting=D0, actual=D0
  Connection: 1
     0x1a
Node 0x11 [Pin Complex] wcaps 0x400483: Stereo Amp-In
  Control: name="Internal Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x90a60130: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
Node 0x12 [Vendor Defined Widget] wcaps 0xf00503: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Power: setting=D0, actual=D0
  Connection: 1
     0x20
Node 0x13 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=63
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="STAC92xx Analog", type="Audio", device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6b 0x6b]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x14 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=63
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6b 0x6b]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x15 [Audio Input] wcaps 0x1d0541: Stereo
  Device: name="STAC92xx Analog", type="Audio", device=0
  Converter: stream=1, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x17
  Processing caps: benign=0, ncoeff=0
Node 0x16 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x18
  Processing caps: benign=0, ncoeff=0
Node 0x17 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Power: setting=D0, actual=D0
  Connection: 7
     0x0c 0x0e 0x0f 0x1b 0x11* 0x12 0x0a
Node 0x18 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Power: setting=D0, actual=D0
  Connection: 7
     0x0c* 0x0e 0x0f 0x1b 0x11 0x12 0x0a
Node 0x19 [Audio Selector] wcaps 0x300501: Stereo
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x1a [Audio Mixer] wcaps 0x200500: Mono
  Power: setting=D0, actual=D0
  Connection: 1
     0x19
Node 0x1b [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Power: setting=D0, actual=D0
  Connection: 6
     0x0c 0x0e 0x0f 0x13 0x14 0x0a
Node 0x1c [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Power: setting=D0, actual=D0
  Connection: 1
     0x1b
Node 0x1d [Audio Output] wcaps 0x4061d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x1e [Audio Output] wcaps 0x4061d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x1f [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x1d
Node 0x20 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x1e
Node 0x21 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Codec: Conexant ID 2c06
Address: 1
MFG Function Id: 0x2 (unsol 1)
Vendor Id: 0x14f12c06
Subsystem Id: 0x14f1000f
Revision Id: 0x100000
Modem Function Group: 0x2
Codec: Intel IbexPeak HDMI
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862804
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Device: name="HDMI 0", type="HDMI", device=3
  Converter: stream=8, channel=0
  Digital: Enabled GenLevel
  Digital category: 0x2
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x04 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x80]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x58560030: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  8 Jun 19 10:04 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  7 Jun 19 10:04 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  6 Jun 19 10:04 /dev/snd/hwC0D1
crw-rw----+ 1 root audio 116,  5 Jun 19 10:04 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116,  4 Jun 19 10:06 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Jun 19 10:18 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  2 Jun 19 10:06 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  1 Jun 19 10:04 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Jun 19 10:04 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Jun 19 10:04 .
drwxr-xr-x 3 root root 240 Jun 19 10:04 ..
lrwxrwxrwx 1 root root  12 Jun 19 10:04 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
            #"/etc/pulse/my-default.conf"
			"/etc/alsa/pulse-default.conf"
            #"/etc/alsa/alsactl.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xf6960000 irq 45'
  Mixer name	: 'Intel IbexPeak HDMI'
  Components	: 'HDA:111d76d5,1028040a,00100104 HDA:14f12c06,14f1000f,00100000 HDA:80862804,80860101,00100000'
  Controls      : 20
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 44 [69%] [-15.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 253 [99%] [0.40dB]
  Front Right: Playback 253 [99%] [0.40dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Mic Jack Mode',0
  Capabilities: enum
  Items: 'Mic In' 'Line In'
  Item0: 'Mic In'
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 1 [33%] [-12.00dB] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Dock Mic',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Internal Mic',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -4800
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Mic Jack Mode'
		value 'Mic In'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Mic In'
			item.1 'Line In'
		}
	}
	control.4 {
		iface MIXER
		name 'Beep Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'Beep Playback Volume'
		value 1
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 3'
			dbmin -1800
			dbmax 0
			dbvalue.0 -1200
		}
	}
	control.6 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -4800
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.7 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 15'
			dbmin 0
			dbmax 2250
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.9 {
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.10 {
		iface MIXER
		name 'Mic Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.11 {
		iface MIXER
		name 'Dock Mic Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Internal Mic Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.13 {
		iface MIXER
		name 'Master Playback Volume'
		value 44
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -9999999
			dbmax 0
			dbvalue.0 -1500
		}
	}
	control.14 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.15 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 253
		value.1 253
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -40
			dbvalue.1 -40
		}
	}
	control.20 {
		iface MIXER
		name PCM
		value.0 253
		value.1 253
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -40
			dbvalue.1 -40
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
tcp_lp
fuse
ip6table_filter
ip6_tables
ebtable_nat
ebtables
ipt_MASQUERADE
iptable_nat
nf_nat
xt_CHECKSUM
iptable_mangle
bridge
stp
llc
sunrpc
cpufreq_ondemand
acpi_cpufreq
freq_table
mperf
sco
bnep
l2cap
bluetooth
snd_hda_codec_hdmi
snd_hda_codec_idt
arc4
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq
snd_seq_device
snd_pcm
uvcvideo
videodev
v4l2_compat_ioctl32
iwlagn
dell_laptop
iTCO_wdt
e1000e
iwlcore
mac80211
snd_timer
cfg80211
snd
dell_wmi
soundcore
rfkill
snd_page_alloc
iTCO_vendor_support
sparse_keymap
ppdev
i2c_i801
intel_ips
dcdbas
parport_pc
parport
microcode
wmi
virtio_net
kvm_intel
kvm
ipv6
sdhci_pci
sdhci
mmc_core
firewire_ohci
yenta_socket
firewire_core
crc_itu_t
i915
drm_kms_helper
drm
i2c_algo_bit
i2c_core
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x0a 0x04a11020
0x0b 0x0421101f
0x0c 0x400000f0
0x0d 0x90170110
0x0e 0x23011050
0x0f 0x23a1102e
0x10 0x400000f3
0x11 0x90a60130
0x1f 0x400000f0
0x20 0x400000f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:
0x73 0x016a10f0

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:

/sys/class/sound/hwC0D3/init_pin_configs:
0x04 0x18560010
0x05 0x18560020
0x06 0x58560030

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   15.276507] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   15.397589] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   15.397763] HDA Intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[   15.397797] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   15.567623] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   15.599523] ALSA sound/pci/hda/hda_codec.c:4633: autoconfig: line_outs=1 (0xe/0x0/0x0/0x0/0x0)
[   15.599531] ALSA sound/pci/hda/hda_codec.c:4637:    speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
[   15.599537] ALSA sound/pci/hda/hda_codec.c:4641:    hp_outs=1 (0xb/0x0/0x0/0x0/0x0)
[   15.599543] ALSA sound/pci/hda/hda_codec.c:4642:    mono: mono_out=0x0
[   15.599548] ALSA sound/pci/hda/hda_codec.c:4646:    inputs:
[   15.599552] ALSA sound/pci/hda/hda_codec.c:4652: 
[   15.600267] ALSA sound/pci/hda/patch_sigmatel.c:3073: stac92xx: dac_nids=1 (0x13/0x0/0x0/0x0/0x0)
[   15.663111] input: HDA Intel Mic at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   15.663317] input: HDA Intel Mic at Ext Right Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   15.663502] input: HDA Intel Line Out at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   15.663678] input: HDA Intel HP Out at Ext Right Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   15.789272] cfg80211: Calling CRDA for country: PT
--
[   60.050665] fuse init (API version 7.16)
[  262.993299] hda-intel: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
[  455.022007] TCP lp registered



--=-MFar6eqCZh4iCC3ZG/S9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-MFar6eqCZh4iCC3ZG/S9--
