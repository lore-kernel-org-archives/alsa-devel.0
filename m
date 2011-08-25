From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: `hda-intel: spurious response` several times in output
 of `dmesg` (was: Report by PulseAudio: `alsa-sink.c: We were woken up with
 POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another
 value < min_avail.`)
Date: Thu, 25 Aug 2011 17:01:58 +0200
Message-ID: <1314284537.26121.6.camel@mattotaupa>
References: <1314185760.3628.30.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8160314834462722087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id A2F09244E8
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 17:02:20 +0200 (CEST)
In-Reply-To: <1314185760.3628.30.camel@mattotaupa>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============8160314834462722087==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wGYdCaUxAY9+RrNZgUFm"


--=-wGYdCaUxAY9+RrNZgUFm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA folks,


Am Mittwoch, den 24.08.2011, 13:35 +0200 schrieb Paul Menzel:

[=E2=80=A6]

> Additionally I am seeing the a lot of the following messages in the
> kernel ring buffer (`dmesg`)
>=20
>         [14293.422591] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1f0004
>         [14293.422612] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1f0004
>         [14293.422633] hda-intel: spurious response 0xe0160:0x0, last cmd=
=3D0x1f0004
>         [14293.422653] hda-intel: spurious response 0x1:0x0, last cmd=3D0=
x1f0004
>         [14293.422675] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1f0004
>         [14293.422695] hda-intel: spurious response 0x0:0x0, last cmd=3D0=
x1f0004
>         [14293.422716] hda-intel: spurious response 0x20025:0x0, last cmd=
=3D0x1f0004
>=20
> but I do not know if this is related. I am using the Debian Linux kernel
> 2.6.32 which includes all longterm patches up to 2.6.32.40.
>=20
> So only the ALSA drivers version 1.0.21 are used. Is there a commit that
> addresses the above behavior and which could be backported?
>=20
> Please find the output of `alsa-info.sh` [1] at the end.

I just want to add that I also see these messages with Linux kernel
3.0.2 and say seem to be related to suspend and resume.

The values seem to differ though every time.

        [ 1130.984969] hda-intel: spurious response 0x0:0x0, last cmd=3D0x6=
20000
        [ 1130.984990] hda-intel: spurious response 0x1003c:0x0, last cmd=
=3D0x620000
        [ 1130.985011] hda-intel: spurious response 0x0:0x0, last cmd=3D0x6=
20000
        [ 1130.985032] hda-intel: spurious response 0x10034:0x0, last cmd=
=3D0x620000
        [ 1130.985053] hda-intel: spurious response 0x0:0x0, last cmd=3D0x6=
20000

        [ =E2=80=A6 another suspend/resume =E2=80=A6 ]

        [ 2726.277102] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
e70700
        [ 2726.277123] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
e70700
        [ 2726.277144] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
e70700
        [ 2726.277165] hda-intel: spurious response 0xb:0x0, last cmd=3D0x1=
e70700

Please find the output of `alsa-info.sh` [1] with this Linux version at
the end.


Thanks,

Paul


> [1] http://alsa-project.org/main/index.php/Help_To_Debug


!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Thu Aug 25 13:14:02 UTC 2011


!!Linux Distribution
!!------------------

Debian GNU/Linux wheezy/sid \n \l


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version


!!Kernel Information
!!------------------

Kernel release:    3.0.0-1-amd64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    1.0.24.1
Utilities version:  1.0.24.2


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

aRts:
      Installed - Yes (/usr/bin/artsd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [VT82xx         ]: HDA-Intel - HDA VIA VT82xx
                      HDA VIA VT82xx at 0xfbffc000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

20:01.0 Audio device: VIA Technologies, Inc. VT1708/A [Azalia HDAC] (VIA Hi=
gh Definition Audio Controller) (rev 10)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

20:01.0 0403: 1106:3288 (rev 10)
	Subsystem: 1043:8290


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2
snd-usb-audio: index=3D-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,=
1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null)=
,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(n=
ull)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nu=
ll),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)=
,(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nu=
ll),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)=
,(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC662 rev1
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0662
Subsystem Id: 0x10438290
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D2, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name=3D"Front Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Device: name=3D"ALC662 rev1 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name=3D"Surround Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name=3D"Center Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"LFE Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D2, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Control: name=3D"IEC958 Default PCM Playback Switch", index=3D0, device=
=3D0
  Device: name=3D"ALC662 rev1 Digital", type=3D"SPDIF", device=3D1
  Converter: stream=3D0, channel=3D0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name=3D"Capture Switch", index=3D1, device=3D0
  Control: name=3D"Capture Volume", index=3D1, device=3D0
  Amp-In caps: ofs=3D0x09, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x89 0x89]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name=3D"Capture Switch", index=3D0, device=3D0
  Control: name=3D"Capture Volume", index=3D0, device=3D0
  Device: name=3D"ALC662 rev1 Analog", type=3D"Audio", device=3D0
  Amp-In caps: ofs=3D0x09, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x18 0x18]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
  Control: name=3D"IEC958 Capture Switch", index=3D0, device=3D0
  Control: name=3D"IEC958 Capture Default", index=3D0, device=3D0
  Device: name=3D"ALC662 rev1 Digital", type=3D"SPDIF", device=3D1
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"CD Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
  Control: name=3D"CD Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
  Control: name=3D"Line Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
  Control: name=3D"Line Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
  Control: name=3D"Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Front Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
  Control: name=3D"Front Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x11 0x11] [0x14 0x14] [0x10 0x10] [0x80 0x80] [0x11 0x11]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 9
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Front Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Surround Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Center Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"LFE Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D2, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00001734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19840: [Jack] Mic at Ext Rear
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x4, Sequence =3D 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0e
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000173c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19950: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x5, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 2
     0x0c* 0x0e
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x0181304f: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
    DefAssociation =3D 0x4, Sequence =3D 0xf
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000173c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02214120: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x2, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 2
     0x0c* 0x0e
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4005c603: [N/A] Line Out at Ext N/A
    Conn =3D Optical, Color =3D UNKNOWN
    DefAssociation =3D 0x0, Sequence =3D 0x3
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x99430130: [Fixed] SPDIF Out at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D12
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Input Source", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Input Source", index=3D1, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x26 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  7 Aug 25 11:47 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  6 Aug 25 11:47 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  5 Aug 25 11:47 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  4 Aug 25 11:52 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  3 Aug 25 11:47 /dev/snd/pcmC0D1c
crw-rw----+ 1 root audio 116,  2 Aug 25 11:47 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  1 Aug 25 11:47 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Aug 25 11:47 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug 25 11:47 .
drwxr-xr-x 3 root root 220 Aug 25 11:47 ..
lrwxrwxrwx 1 root root  12 Aug 25 11:47 pci-0000:20:01.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

pcm.pulse {
    type pulse
}
=20
ctl.pulse {
    type pulse
}
=20
pcm.!default {
    type pulse
}
ctl.!default {
    type pulse
}


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC662 rev1 Analog [ALC662 rev1 =
Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 1: ALC662 rev1 Digital [ALC662 rev1=
 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC662 rev1 Analog [ALC662 rev1 =
Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 1: ALC662 rev1 Digital [ALC662 rev1=
 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [VT82xx]

Card hw:0 'VT82xx'/'HDA VIA VT82xx at 0xfbffc000 irq 17'
  Mixer name	: 'Realtek ALC662 rev1'
  Components	: 'HDA:10ec0662,10438290,00100101'
  Controls      : 35
  Simple ctrls  : 19
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 20 [65%] [-4.50dB] [on]
  Front Right: Playback 20 [65%] [-4.50dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 16 [52%] [-10.50dB] [on]
  Front Right: Playback 16 [52%] [-10.50dB] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-9.00dB] [on]
  Front Right: Playback 17 [55%] [-9.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-9.00dB] [on]
  Front Right: Playback 17 [55%] [-9.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 24 [77%] [22.50dB] [on]
  Front Right: Capture 24 [77%] [22.50dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 9 [29%] [0.00dB] [off]
  Front Right: Capture 9 [29%] [0.00dB] [off]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 66 [55%] [3.00dB]
  Front Right: Capture 66 [55%] [3.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'


!!Alsactl output
!!-------------

--startcollapse--
state.VT82xx {
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
			dbmin -6400
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
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Center Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface MIXER
		name 'LFE Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
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
	control.10 {
		iface MIXER
		name 'CD Playback Volume'
		value.0 17
		value.1 17
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -900
			dbvalue.1 -900
		}
	}
	control.11 {
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.12 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 16
		value.1 16
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -1050
			dbvalue.1 -1050
		}
	}
	control.13 {
		iface MIXER
		name 'Line Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.14 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 17
		value.1 17
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -900
			dbvalue.1 -900
		}
	}
	control.15 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.16 {
		iface MIXER
		name 'Front Mic Playback Volume'
		value.0 20
		value.1 20
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -450
			dbvalue.1 -450
		}
	}
	control.17 {
		iface MIXER
		name 'Front Mic Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.18 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '6ch'
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.21 {
		iface MIXER
		name 'Capture Volume'
		value.0 24
		value.1 24
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1350
			dbmax 3300
			dbvalue.0 2250
			dbvalue.1 2250
		}
	}
	control.22 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 9
		value.1 9
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1350
			dbmax 3300
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.23 {
		iface MIXER
		name 'Input Source'
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Front Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.24 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Front Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff00000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f0000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '040000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Capture Default'
		value '040000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'Master Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.33 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.34 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.35 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 66
		value.1 66
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 300
			dbvalue.1 300
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
binfmt_misc
via
drm
ip6table_filter
ip6_tables
iptable_filter
ip_tables
x_tables
powernow_k8
mperf
cpufreq_conservative
cpufreq_userspace
cpufreq_stats
cpufreq_powersave
reiserfs
xfs
fuse
kvm_amd
kvm
loop
firewire_sbp2
firewire_core
crc_itu_t
snd_hda_codec_realtek
i2c_viapro
amd64_edac_mod
edac_core
edac_mce_amd
snd_hda_intel
snd_hda_codec
psmouse
i2c_core
k8temp
evdev
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
serio_raw
snd_seq_midi
parport_pc
parport
snd_rawmidi
snd_seq_midi_event
asus_atk0110
processor
snd_seq
snd_timer
snd_seq_device
button
snd
soundcore
snd_page_alloc
shpchp
pci_hotplug
thermal_sys
ext3
jbd
mbcache
sha256_generic
cryptd
aes_x86_64
aes_generic
cbc
dm_crypt
dm_mod
raid1
md_mod
sr_mod
cdrom
sg
sd_mod
crc_t10dif
usbhid
ata_generic
hid
pata_via
uhci_hcd
sata_via
libata
ehci_hcd
via_rhine
mii
scsi_mod
usbcore


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x14 0x01014010
0x15 0x411111f0
0x16 0x411111f0
0x18 0x01a19840
0x19 0x02a19950
0x1a 0x0181304f
0x1b 0x02214120
0x1c 0x593301f0
0x1d 0x4005c603
0x1e 0x99430130

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   16.854240] k8temp 0000:00:18.3: Temperature readouts might be wrong - c=
heck erratum #141
[   16.968428] HDA Intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low) -> =
IRQ 17
[   16.968481] HDA Intel 0000:20:01.0: setting latency timer to 64
[   16.968487] HDA Intel 0000:20:01.0: PCI: Disallowing DAC for device
[   16.977923] MCE: In-kernel MCE decoding enabled.
--
[  247.978266] ioctl32(Xorg:3108): Unknown cmd fd(11) cmd(c0246400){t:'d';s=
z:36} arg(0967ef10) on /dev/dri/card0
[  318.556155] hda-intel: IRQ timing workaround is activated for card #0. S=
uggest a bigger bdl_pos_adj.
[ 1130.714250] PM: Syncing filesystems ... done.
--
[ 1130.880048] uhci_hcd 0000:00:10.1: PCI INT B disabled
[ 1130.984429] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984449] hda-intel: spurious response 0x10:0x0, last cmd=3D0x620000
[ 1130.984470] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984490] hda-intel: spurious response 0x4011:0x0, last cmd=3D0x620000
[ 1130.984511] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984532] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984553] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984574] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984595] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984615] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984636] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984657] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984678] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984699] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984720] hda-intel: spurious response 0x80:0x0, last cmd=3D0x620000
[ 1130.984741] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984762] hda-intel: spurious response 0x4011:0x0, last cmd=3D0x620000
[ 1130.984782] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984803] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984824] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984845] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984866] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984886] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984907] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984928] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984949] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984969] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.984990] hda-intel: spurious response 0x1003c:0x0, last cmd=3D0x62000=
0
[ 1130.985011] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985032] hda-intel: spurious response 0x10034:0x0, last cmd=3D0x62000=
0
[ 1130.985053] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985074] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985095] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985116] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985136] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985157] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985178] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985199] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985220] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985241] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985262] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985283] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985303] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985324] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985345] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985365] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985386] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985407] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1130.985428] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 1131.088080] HDA Intel 0000:20:01.0: PCI INT A disabled
[ 1131.167710] sd 1:0:0:0: [sda] Stopping disk
--
[ 1131.886676] pci 0000:01:00.0: restoring config space at offset 0x1 (was =
0x2300007, writing 0x2300003)
[ 1131.886707] HDA Intel 0000:20:01.0: restoring config space at offset 0x3=
 (was 0x0, writing 0x10)
[ 1131.886713] HDA Intel 0000:20:01.0: restoring config space at offset 0x1=
 (was 0x100006, writing 0x100002)
[ 1131.886823] PM: early resume of devices complete after 0.870 msecs
--
[ 1131.887187] pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 1131.887200] HDA Intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low) -> =
IRQ 17
[ 1131.887205] HDA Intel 0000:20:01.0: setting latency timer to 64
[ 1131.889158] sd 1:0:0:0: [sda] Starting disk
--
[ 2726.172052] uhci_hcd 0000:00:10.1: PCI INT B disabled
[ 2726.276271] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276290] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276310] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276331] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276352] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276373] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276394] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276415] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276435] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276456] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276477] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276498] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276519] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276540] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276561] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276582] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276602] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276623] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276644] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276665] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276686] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276707] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276728] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276748] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276769] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276790] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276810] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276831] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276852] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276873] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276894] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276915] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276936] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276956] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276977] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.276998] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277019] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277040] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277061] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277082] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277102] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277123] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277144] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277165] hda-intel: spurious response 0xb:0x0, last cmd=3D0x1e70700
[ 2726.277185] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277206] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277227] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277248] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277269] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277290] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277310] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277331] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277352] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277373] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277394] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277415] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277436] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277457] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277477] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277498] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277519] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277540] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277561] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277582] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277603] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277623] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277644] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277665] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277685] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277706] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277727] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277748] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277769] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277790] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277811] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277831] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277852] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277873] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277894] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277915] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277936] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277957] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277977] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.277998] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278019] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278040] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278061] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278082] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278102] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278123] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278144] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278165] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278185] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278206] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278227] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278248] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278269] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278290] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278311] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278331] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278352] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278373] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278394] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278415] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278436] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278457] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278477] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278498] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278519] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278540] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278560] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278581] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278602] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278623] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278644] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278665] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278685] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278706] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278727] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278748] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278769] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278790] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278811] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278832] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278852] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278873] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278894] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278915] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278936] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278957] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278978] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.278998] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279019] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279040] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279060] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279081] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279102] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279123] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279144] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279165] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279186] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279207] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279227] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279248] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279269] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279290] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279311] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279332] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279353] hda-intel: spurious response 0xb:0x0, last cmd=3D0x1e70700
[ 2726.279373] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279394] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279415] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279435] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279456] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279477] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279498] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279519] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279540] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279560] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279581] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279602] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279623] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279644] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279665] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279686] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279707] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279727] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279748] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279769] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279790] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279811] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279832] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279853] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279873] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279894] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279915] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279935] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279956] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279977] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.279998] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280019] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280040] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280061] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280081] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280102] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280123] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280144] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280165] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280186] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280207] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280228] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280248] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280269] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280290] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280310] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280331] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280352] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280373] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280394] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280415] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280435] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280456] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280477] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280498] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280519] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280540] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280561] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280582] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280603] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280623] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280644] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280665] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280686] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280707] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280728] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280749] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280769] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280790] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280811] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280831] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280852] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.280873] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[ 2726.380060] HDA Intel 0000:20:01.0: PCI INT A disabled
[ 2726.489745] sd 1:0:0:0: [sda] Stopping disk
--
[ 2727.210602] pci 0000:01:00.0: restoring config space at offset 0x1 (was =
0x2300007, writing 0x2300003)
[ 2727.210633] HDA Intel 0000:20:01.0: restoring config space at offset 0x3=
 (was 0x0, writing 0x10)
[ 2727.210639] HDA Intel 0000:20:01.0: restoring config space at offset 0x1=
 (was 0x100006, writing 0x100002)
[ 2727.210749] PM: early resume of devices complete after 0.859 msecs
--
[ 2727.211123] pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 2727.211137] HDA Intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low) -> =
IRQ 17
[ 2727.211143] HDA Intel 0000:20:01.0: setting latency timer to 64
[ 2727.211410] sd 1:0:0:0: [sda] Starting disk

--=-wGYdCaUxAY9+RrNZgUFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5WY+cACgkQPX1aK2wOHVhNLgCfYM5ZL60lzcF9h2zBAu0bdDRh
vBQAn1VVDWpYHsq5JFreCUZwZ2zHfAXG
=eEjp
-----END PGP SIGNATURE-----

--=-wGYdCaUxAY9+RrNZgUFm--


--===============8160314834462722087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8160314834462722087==--
