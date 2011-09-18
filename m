From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: `hda-intel: spurious response` several times in
 output of `dmesg`
Date: Sun, 18 Sep 2011 20:28:03 +0200
Message-ID: <1316370484.7061.103.camel@mattotaupa>
References: <1314185760.3628.30.camel@mattotaupa>
	<1314284537.26121.6.camel@mattotaupa>
	<1314785943.3769.30.camel@mattotaupa>
	<CACTFLANPdSzg9KMhjdgn_=kuQZq+EnwA2cw0t+QT1RoWQ=nwCA@mail.gmail.com>
	<s5h8vpu85z9.wl%tiwai@suse.de> <1315951908.4138.13.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2907701270102920208=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DB0224354
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Sep 2011 20:28:07 +0200 (CEST)
In-Reply-To: <1315951908.4138.13.camel@mattotaupa>
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


--===============2907701270102920208==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-4JYoTTBaqLER87lkSxUv"


--=-4JYoTTBaqLER87lkSxUv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 14.09.2011, 00:11 +0200 schrieb Paul Menzel:
> Am Montag, den 12.09.2011, 11:28 +0200 schrieb Takashi Iwai:
> > At Wed, 31 Aug 2011 12:37:28 +0200, Daniel Mack wrote:
> > >=20
> > > On Wed, Aug 31, 2011 at 12:19 PM, Paul Menzel wrote:
>=20
> > > > Am Donnerstag, den 25.08.2011, 17:01 +0200 schrieb Paul Menzel:
> > > >
> > > > [=E2=80=A6]
> > > >
> > > >> I just want to add that I also see these messages with Linux kerne=
l
> > > >> 3.0.2 and say seem to be related to suspend and resume.
> > > >>
> > > >> The values seem to differ though every time.
> > > >>
> > > >>         [ 1130.984969] hda-intel: spurious response 0x0:0x0, last =
cmd=3D0x620000
> > > >>         [ 1130.984990] hda-intel: spurious response 0x1003c:0x0, l=
ast cmd=3D0x620000
> > > >>         [ 1130.985011] hda-intel: spurious response 0x0:0x0, last =
cmd=3D0x620000
> > > >>         [ 1130.985032] hda-intel: spurious response 0x10034:0x0, l=
ast cmd=3D0x620000
> > > >>         [ 1130.985053] hda-intel: spurious response 0x0:0x0, last =
cmd=3D0x620000
> > > >>
> > > >>         [ =E2=80=A6 another suspend/resume =E2=80=A6 ]
> > > >>
> > > >>         [ 2726.277102] hda-intel: spurious response 0x0:0x0, last =
cmd=3D0x1e70700
> > > >>         [ 2726.277123] hda-intel: spurious response 0x0:0x0, last =
cmd=3D0x1e70700
> > > >>         [ 2726.277144] hda-intel: spurious response 0x0:0x0, last =
cmd=3D0x1e70700
> > > >>         [ 2726.277165] hda-intel: spurious response 0xb:0x0, last =
cmd=3D0x1e70700
> > > >>
> > > >> Please find the output of `alsa-info.sh` [1] with this Linux versi=
on at
> > > >> the end.

[=E2=80=A6]

> > The verb 0x620000 is to set a stream format to NID 0x06.
> > For further debugging, more detailed information is needed.
> >=20
> > I seem to have lost the original post, so could you attach
> > alsa-info.sh output again, Paul?
>=20
> Unfortunately I have to compress them due to the size limit. (Could you
> increase that to for example 150 kB?)

The output of `alsa-info.sh` with Linux 3.1-rc6 (3ab0fcd6c)

        commit 3ab0fcd6cd45d0d0cac114e498848f37e7a463b2
        Merge: 9183834 14515a0
        Author: Takashi Iwai <tiwai@suse.de>
        Date:   Fri Sep 16 08:34:05 2011 +0200
       =20
            Merge branch 'topic/misc'

is as follows.


Thanks,

Paul


!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Sun Sep 18 16:11:59 UTC 2011


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

Kernel release:    3.1.0-rc1+
Operating System:  GNU/Linux
Architecture:      i686
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
	align_buffer_size : Y
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
  Converter: stream=3D5, channel=3D0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name=3D"Surround Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=3D5, channel=3D0
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
  Converter: stream=3D5, channel=3D0
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
  Converter: stream=3D8, channel=3D0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name=3D"Capture Switch", index=3D0, device=3D0
  Control: name=3D"Capture Volume", index=3D0, device=3D0
  Device: name=3D"ALC662 rev1 Analog", type=3D"Audio", device=3D0
  Amp-In caps: ofs=3D0x09, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x18 0x18]
  Converter: stream=3D1, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name=3D"Capture Switch", index=3D1, device=3D0
  Control: name=3D"Capture Volume", index=3D1, device=3D0
  Device: name=3D"ALC662 rev1 Analog", type=3D"Audio", device=3D2
  Amp-In caps: ofs=3D0x09, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x89 0x89]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Rear Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Rear Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Front Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
  Control: name=3D"Front Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
  Control: name=3D"Line Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
  Control: name=3D"Line Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x14 0x14] [0x10 0x10] [0x80 0x80] [0x80 0x80]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 9
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x0b
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name=3D"Front Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
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
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name=3D"Center Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"LFE Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D2, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Rear Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
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
  Control: name=3D"Front Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
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
  Control: name=3D"Surround Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
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
  Unsolicited: tag=3D04, enabled=3D1
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
  Control: name=3D"Input Source", index=3D1, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Input Source", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x26 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  7 Sep 18 11:10 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  6 Sep 18 11:10 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  5 Sep 18 16:59 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  4 Sep 18 18:08 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  3 Sep 18 16:59 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  2 Sep 18 11:10 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116,  1 Sep 18 11:10 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Sep 18 11:10 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Sep 18 11:10 .
drwxr-xr-x 3 root root 220 Sep 18 11:10 ..
lrwxrwxrwx 1 root root  12 Sep 18 11:10 pci-0000:20:01.0 -> ../controlC0


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
card 0: VT82xx [HDA VIA VT82xx], device 2: ALC662 rev1 Analog [ALC662 rev1 =
Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [VT82xx]

Card hw:0 'VT82xx'/'HDA VIA VT82xx at 0xfbffc000 irq 17'
  Mixer name	: 'Realtek ALC662 rev1'
  Components	: 'HDA:10ec0662,10438290,00100101'
  Controls      : 34
  Simple ctrls  : 21
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
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
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
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
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
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 66 [55%] [3.00dB]
  Front Right: Capture 66 [55%] [3.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Rear Mic'
Simple mixer control 'Rear Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Rear Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]


!!Alsactl output
!!-------------

--startcollapse--
state.VT82xx {
	control.1 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '4ch'
			item.2 '6ch'
		}
	}
	control.2 {
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
	control.3 {
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
	control.4 {
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
	control.5 {
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
	control.6 {
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
	control.7 {
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
	control.8 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
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
	control.11 {
		iface MIXER
		name 'Rear Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.12 {
		iface MIXER
		name 'Rear Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
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
	control.14 {
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
	control.15 {
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
	control.16 {
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
	control.17 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Enabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.18 {
		iface MIXER
		name 'Rear Mic Boost Volume'
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
	control.19 {
		iface MIXER
		name 'Front Mic Boost Volume'
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
	control.20 {
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
	control.21 {
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
	control.22 {
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
	control.23 {
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
	control.24 {
		iface MIXER
		name 'Input Source'
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Rear Mic'
			item.1 'Front Mic'
			item.2 Line
		}
	}
	control.25 {
		iface MIXER
		name 'Input Source'
		index 1
		value 'Rear Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Rear Mic'
			item.1 'Front Mic'
			item.2 Line
		}
	}
	control.26 {
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
	control.27 {
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
	control.28 {
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
	control.29 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
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
	control.32 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.33 {
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
	control.34 {
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
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_midi
snd_rawmidi
psmouse
snd_seq_midi_event
snd_seq
snd_timer
snd_seq_device
snd
evdev
i2c_viapro
shpchp
parport_pc
serio_raw
pci_hotplug
processor
parport
i2c_core
k8temp
soundcore
snd_page_alloc
button
asus_atk0110
thermal_sys
ext3
jbd
mbcache
sha256_generic
aes_generic
cbc
dm_crypt
dm_mod
raid1
md_mod
sg
sr_mod
cdrom
sd_mod
crc_t10dif
usbhid
ata_generic
hid
uhci_hcd
pata_via
ehci_hcd
sata_via
libata
usbcore
scsi_mod
via_rhine
mii


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

[   18.188646] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   19.071968] snd_hda_intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low)=
 -> IRQ 17
[   19.072044] snd_hda_intel 0000:20:01.0: setting latency timer to 64
[   19.072050] snd_hda_intel 0000:20:01.0: PCI: Disallowing DAC for device
[   19.170077] input: HDA VIA VT82xx Headphone as /devices/pci0000:20/0000:=
20:01.0/sound/card0/input4
[   19.517148] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i804=
2/serio1/input/input5
--
[  308.672048] uhci_hcd 0000:00:10.1: PCI INT B disabled
[  308.776271] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776291] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776312] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776333] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776354] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776375] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776396] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776416] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776437] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776458] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776479] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776500] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776521] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776542] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776563] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776583] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776604] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776625] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776646] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776667] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776687] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776708] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776729] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776750] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776771] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776791] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776812] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776833] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776854] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776875] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776896] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776917] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776937] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776958] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.776979] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777000] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777021] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777042] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777063] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777084] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777104] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777125] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777145] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777166] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777187] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777208] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777229] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777250] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777271] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777291] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777312] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777333] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777354] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777375] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777396] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777417] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.777438] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1e70700
[  308.880069] snd_hda_intel 0000:20:01.0: PCI INT A disabled
[  309.015605] sata_via 0000:00:0f.0: PCI INT B disabled
--
[  309.214569] pci 0000:01:00.0: restoring config space at offset 0x1 (was =
0x2300007, writing 0x2300003)
[  309.214600] snd_hda_intel 0000:20:01.0: restoring config space at offset=
 0x3 (was 0x0, writing 0x10)
[  309.214606] snd_hda_intel 0000:20:01.0: restoring config space at offset=
 0x1 (was 0x100006, writing 0x100002)
[  309.214704] PM: early resume of devices complete after 0.856 msecs
--
[  309.214998] pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  309.215011] snd_hda_intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low)=
 -> IRQ 17
[  309.215017] snd_hda_intel 0000:20:01.0: setting latency timer to 64
[  309.215256] sd 1:0:0:0: [sda] Starting disk
--
[  333.696026] eth0: no IPv6 routers present
[  357.513878] hda-intel: IRQ timing workaround is activated for card #0. S=
uggest a bigger bdl_pos_adj.
[ 2658.757075] usb 3-2.3: new full speed USB device number 3 using uhci_hcd
--
[ 9129.272055] uhci_hcd 0000:00:10.1: PCI INT B disabled
[ 9129.376472] hda-intel: spurious response 0x4011:0x0, last cmd=3D0x620000
[ 9129.376491] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376512] hda-intel: spurious response 0x4013:0x0, last cmd=3D0x620000
[ 9129.376533] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376554] hda-intel: spurious response 0x4013:0x0, last cmd=3D0x620000
[ 9129.376574] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376595] hda-intel: spurious response 0x50:0x0, last cmd=3D0x620000
[ 9129.376616] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376636] hda-intel: spurious response 0x4013:0x0, last cmd=3D0x620000
[ 9129.376657] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376678] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376699] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376720] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376741] hda-intel: spurious response 0x80:0x0, last cmd=3D0x620000
[ 9129.376762] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376783] hda-intel: spurious response 0x4011:0x0, last cmd=3D0x620000
[ 9129.376803] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376824] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376845] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376866] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376887] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376908] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376929] hda-intel: spurious response 0x4015:0x0, last cmd=3D0x620000
[ 9129.376949] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.376970] hda-intel: spurious response 0x52:0x0, last cmd=3D0x620000
[ 9129.376991] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377012] hda-intel: spurious response 0x4015:0x0, last cmd=3D0x620000
[ 9129.377033] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377054] hda-intel: spurious response 0x54:0x0, last cmd=3D0x620000
[ 9129.377074] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377095] hda-intel: spurious response 0x4015:0x0, last cmd=3D0x620000
[ 9129.377116] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377136] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377157] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377178] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377199] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377220] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377241] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377262] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377283] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377303] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377324] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377345] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377366] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377387] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377408] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377429] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377449] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377470] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377491] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377511] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377532] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377553] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377574] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377595] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377616] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377637] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.377657] hda-intel: spurious response 0x0:0x0, last cmd=3D0x620000
[ 9129.480070] snd_hda_intel 0000:20:01.0: PCI INT A disabled
[ 9129.617666] sata_via 0000:00:0f.0: PCI INT B disabled
--
[ 9129.818670] pci 0000:01:00.0: restoring config space at offset 0x1 (was =
0x2300007, writing 0x2300003)
[ 9129.818701] snd_hda_intel 0000:20:01.0: restoring config space at offset=
 0x3 (was 0x0, writing 0x10)
[ 9129.818707] snd_hda_intel 0000:20:01.0: restoring config space at offset=
 0x1 (was 0x100006, writing 0x100002)
[ 9129.818806] PM: early resume of devices complete after 0.851 msecs
--
[ 9129.819238] pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[ 9129.819252] snd_hda_intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low)=
 -> IRQ 17
[ 9129.819257] snd_hda_intel 0000:20:01.0: setting latency timer to 64
[ 9129.819485] sd 1:0:0:0: [sda] Starting disk

--=-4JYoTTBaqLER87lkSxUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk52ODMACgkQPX1aK2wOHVhycgCghVLgU81EosS+fsGG9/0SUbBA
IL8AnAlSOisYAxYpoTrlbDVd3ZrWkA9C
=4tZD
-----END PGP SIGNATURE-----

--=-4JYoTTBaqLER87lkSxUv--


--===============2907701270102920208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2907701270102920208==--
