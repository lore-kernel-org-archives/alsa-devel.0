From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: ALSA - No sound on MBA2,1
Date: Wed, 4 Dec 2013 11:47:41 +0100
Message-ID: <20131204114741.0efc3a33@pluto.restena.lu>
References: <20131203225413.6b1e7e98@neptune.home>
 <s5hsiu93x6d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/R9+YUJg.vJ55Yi=/69wq6kw"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.restena.lu (smtprelay.restena.lu [158.64.1.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D862625D3
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 11:47:41 +0100 (CET)
In-Reply-To: <s5hsiu93x6d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_/R9+YUJg.vJ55Yi=/69wq6kw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Takashi,

On Wed, 04 Dec 2013 08:14:18 +0100 Takashi Iwai wrote:
> At Tue, 3 Dec 2013 22:54:13 +0100, Bruno Pr=C3=A9mont wrote:
> > Hi Takashi,
> >=20
> > Since I started using Linux on a MBA2,1 I never had sound working.
> > recently searching for some solution to get sound working I saw that
> > some users had sound with 3.2.x kernels and reported it stopped working
> > somewhere between 3.2 and 3.4.
> >=20
> > Thus I tried bisecting this and found two steps of losing sound support,
> > a first one being losing sound output on built-in speaker, a second
> > point where sound through headphone jack stopped working.
> >=20
> > Even with 3.2 non of the mute options is working (I did not try recordi=
ng
> > via build-in microphone)
> >=20
> > ...
> >=20
> > Attached is the output of `alsa-info --with-devices` under current 3.12=
.2
> > kernel and under 3.2.53.
> >=20
> > As this all seems related to quirks being replaced with auto-parsing.
> > Trying to revert the commits on top of 3.12.x looks unworkable.
> >=20
> > Is there some extra data I should try to provide or a workaround/fix I
> > could try out? I'm booting in EFI mode using EFI stub (did backport it
> > from 3.3 to 3.2 for bisecting/testing 3.2).
>=20
> You seem to be passing model=3D3stack, and this must break things.
> To be sure, try sound.git tree for-linus branch without any options.
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

I tried your branch (with merged rc2 from Linus) and there is still no
sound.
(took some time to test as kernel freezes during boot somewhere in
nouveau, thus me merging in rc2 in the hope of a fix for that)

> If it still doesn't work, please give alsa-info.sh output with that
> kernel.

`alsa-info --with-devices` is attached.

Bruno


> Takashi

--MP_/R9+YUJg.vJ55Yi=/69wq6kw
Content-Type: text/plain
Content-Disposition: attachment; filename=alsa-info-3.13-rc2-tiwai
Content-Transfer-Encoding: quoted-printable

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Wed Dec  4 10:40:42 UTC 2013


!!Linux Distribution
!!------------------

Gentoo Base System release 2.2 NAME=3DGentoo ID=3Dgentoo PRETTY_NAME=3D"G=
entoo/Linux" HOME_URL=3D"http://www.gentoo.org/" SUPPORT_URL=3D"http://ww=
w.gentoo.org/main/en/support.xml" BUG_REPORT_URL=3D"https://bugs.gentoo.o=
rg/"


!!DMI Information
!!---------------

Manufacturer:      Apple Inc.
Product Name:      MacBookAir2,1
Product Version:   1.0


!!Kernel Information
!!------------------

Kernel release:    3.13.0-rc2-air+
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM)2 Duo CPU L9400 @ 1.86GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.13.0-rc2-air+
Library version:    1.0.27.1
Utilities version:  1.0.27.1


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0x93380000 irq 19


!!PCI Soundcards installed in the system
!!--------------------------------------

00:08.0 Audio device: NVIDIA Corporation MCP79 High Definition Audio (rev=
 b1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:08.0 0403: 10de:0ac0 (rev b1)
	Subsystem: 10de:cb79


!!Loaded sound module options
!!--------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC889A
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0885
Subsystem Id: 0x106b3500
Revision Id: 0x100103
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
GPIO: io=3D2, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D1, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Device: name=3D"ALC889A Analog", type=3D"Audio", device=3D0
  Converter: stream=3D8, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D8, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name=3D"Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Device: name=3D"ALC889A Analog", type=3D"Audio", device=3D0
  Amp-In caps: ofs=3D0x10, nsteps=3D0x2e, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x10, nsteps=3D0x2e, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x90 0x90]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x10, nsteps=3D0x2e, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x90 0x90]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Headphone Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D6, ofs=3D0
  Control: name=3D"Headphone Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D6, ofs=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x8=
0] [0x80 0x80] [0x1f 0x1f] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Headphone Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Headphone Mic Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01214030: [Jack] HP Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x3, Sequence =3D 0x0
  Pin-ctls: 0xc4: OUT HP VREF_80
  Unsolicited: tag=3D01, enabled=3D1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000003c: IN OUT HP Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000003c: IN OUT HP Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Speaker Phantom Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x90100120: [Fixed] Speaker at Int N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x20: IN
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D17
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
  Volume-Knob: delta=3D0, steps=3D32, direct=3D0, val=3D64
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 0
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x8=
0] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80=
]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x8=
0] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80=
]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x8=
0] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80=
]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x25 0x0b
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  4 Dec  4 11:38 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  3 Dec  4 11:38 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116,  2 Dec  4 11:40 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 33 Dec  4 11:38 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Dec  4 11:38 .
drwxr-xr-x 3 root root 140 Dec  4 11:38 ..
lrwxrwxrwx 1 root root  12 Dec  4 11:38 pci-0000:00:08.0 -> ../controlC0



--MP_/R9+YUJg.vJ55Yi=/69wq6kw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/R9+YUJg.vJ55Yi=/69wq6kw--
