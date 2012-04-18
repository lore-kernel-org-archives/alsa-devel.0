From: Uros Vampl <mobile.leecher@gmail.com>
Subject: Re: No sound on Quanta KN1 with kernel 3.4
Date: Wed, 18 Apr 2012 11:55:45 +0200
Message-ID: <20120418095545.GA26678@zverina>
References: <20120414171029.GA740@zanic_kista> <s5hiph2p132.wl%tiwai@suse.de>
	<20120414205209.GA1041@zanic_kista> <s5hbomrsrc1.wl%tiwai@suse.de>
	<20120416175609.GA22954@zverina> <s5h62czpjhu.wl%tiwai@suse.de>
	<s5hfwc1o46s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 5736F24392
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 11:55:44 +0200 (CEST)
Received: by wibhq7 with SMTP id hq7so388856wib.2
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 02:55:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hfwc1o46s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.04.12 10:05, Takashi Iwai wrote:
> > > It's a laptop. There's no sound, not from internal speakers, not fr=
om=20
> > > headphone out. There is a mild crackling sound when the module is=20
> > > loaded, but that's it. The patch does not change things.
> >=20
> > OK, I'll send another patch tomorrow.  But the previous patch should
> > work, still.  Make sure that you adjusted and unmuted the mixer
> > elements after applying the patch.  There should be some new mixer
> > elements.
> >=20
> > If it still doesn't work after the mixer adjustment, give alsa-info.s=
h
> > output again.
>=20
> Also, there are many bogus input pins on your device.
> Which physical inputs are on the machine?  BIOS advertises that there
> are front-mic, rear-mic, line-in, aux-in and CD.  Do all these work
> properly?  You can choose it from "Input Source" mixer enum.
>=20
> Also, it also advertises SPDIF input and output.  Are really both on
> your machine?

The only physical input is mic-in. But there's also an integrated=20
microphone. In kernel 3.3 the intergrated mic is simply "Mic" and works=20
for both playback and capture. I don't have an external mic to test.

In kernel 3.4 I still don't have sound, even with the patch (I unmuted=20
everything there was to unmute, then muted SPDIF, nothing produced=20
sound), so I could only test capture - "Rear Mic" captures from the=20
integrated microphone.

I assume "Front Mic" would work for an external microphone, and maybe CD=20
is for listening to audio CDs? The CD drive broke a few years back, so I=20
can't test it.

No idea about SPDIF-in, but headphone-out doubles as SPDIF-out. There's=20
a red light inside the jack, and if I unmute SPDIF, the light goes on. I=20
remember it was like that also in Windows. I don't have appropriate=20
hardware to test if it actually works.

Attached is a alsa-info.txt with the patch. There are some differences=20
compared to without patch, but like I said above, still no sound.


Regards,
Uro=C5=A1

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info.txt.5SoKYr3Vcw"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Wed Apr 18 09:50:38 UTC 2012


!!Linux Distribution
!!------------------

Arch Linux @ \n (\r) \l


!!DMI Information
!!---------------

Manufacturer:      Gericom Inc
Product Name:      KN1             
Product Version:   Not Applicable


!!Kernel Information
!!------------------

Kernel release:    3.4.0-rc3-zanic_kista
Operating System:  GNU/Linux
Architecture:      i686
Processor:         Intel(R) Pentium(R) M processor 1.73GHz
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.25
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xc0000000 irq 44


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:2668 (rev 04)
	Subsystem: 152d:0729


!!Loaded sound module options
!!--------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC260
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0260
Subsystem Id: 0x02600000
Revision Id: 0x100400
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Device: name="ALC260 Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="ALC260 Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Input Source", index=0, device=0
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="ALC260 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x17 0x17] [0x17 0x17] [0x17 0x17] [0x17 0x17] [0x17 0x17] [0x17 0x17] [0x17 0x17]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 7
     0x12* 0x13 0x14 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Input Source", index=1, device=0
  Control: name="Capture Switch", index=1, device=0
  Control: name="Capture Volume", index=1, device=0
  Device: name="ALC260 Analog", type="Audio", device=2
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 8
     0x12 0x13* 0x14 0x15 0x16 0x07 0x0f 0x10
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
  Control: name="IEC958 Capture Switch", index=0, device=0
  Control: name="IEC958 Capture Default", index=0, device=0
  Device: name="ALC260 Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x19
Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="CD Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="CD Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Aux Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Aux Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals:  [0x2b 0x2b] [0x2b 0x2b] [0x2b 0x2b] [0x2b 0x2b] [0x2b 0x2b] [0x0c 0x0c] [0x80 0x80] [0x80 0x80]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x2a 0x2a]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x14 0x14]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00] [0x80]
  Amp-Out caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=0
  Amp-Out vals:  [0x23]
  Connection: 2
     0x02 0x07
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003f: IN OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x01014000: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x08
Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003f: IN OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x02214000: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x09
Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x50171000: [N/A] Speaker at Int N/A
    Conn = Analog, Color = Black
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x01a19000: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Front Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x02a19000: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=04, enabled=1
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Line Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x01813000: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x99931000: [Fixed] Aux at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x99331000: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90f71000: [Fixed] Other at Int N/A
    Conn = Analog, Color = Black
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
  Control: name="SPDIF Jack", index=0, device=0
  Pincap 0x00000014: OUT Detect
  Pin Default 0x01446000: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Orange
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x03
Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
  Control: name="SPDIF In Jack", index=0, device=0
  Pincap 0x00000024: IN Detect
  Pin Default 0x01c41000: [Jack] SPDIF In at Ext Rear
    Conn = RCA, Color = Black
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
Node 0x1a [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=13
Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono
  Volume-Knob: delta=0, steps=64, direct=0, val=0
  Unsolicited: tag=00, enabled=0
  Connection: 0
Codec: Motorola ID 3055
Address: 1
MFG Function Id: 0x2 (unsol 1)
Vendor Id: 0x10573055
Subsystem Id: 0x10573055
Revision Id: 0x100700
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Apr 18 11:24 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Apr 18 11:24 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116,  5 Apr 18 11:24 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 24 Apr 18 11:39 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Apr 18 11:24 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 25 Apr 18 11:24 /dev/snd/pcmC0D1c
crw-rw---- 1 root audio 116, 17 Apr 18 11:24 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 26 Apr 18 11:24 /dev/snd/pcmC0D2c
crw-rw---- 1 root audio 116,  1 Apr 18 11:24 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Apr 18 11:24 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Apr 18 11:24 .
drwxr-xr-x 3 root root 260 Apr 18 11:24 ..
lrwxrwxrwx 1 root root  12 Apr 18 11:24 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xc0000000 irq 44'
  Mixer name	: 'Realtek ALC260'
  Components	: 'HDA:10ec0260,02600000,00100400 HDA:10573055,10573055,00100700'
  Controls      : 40
  Simple ctrls  : 17
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 42 [66%] [-22.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 42 [66%] [-22.00dB] [on]
  Front Right: Playback 42 [66%] [-22.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 43 [66%] [8.00dB] [on]
  Front Right: Playback 43 [66%] [8.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 43 [66%] [8.00dB] [on]
  Front Right: Playback 43 [66%] [8.00dB] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 43 [66%] [8.00dB] [on]
  Front Right: Playback 43 [66%] [8.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 12 [18%] [-23.00dB] [on]
  Front Right: Playback 12 [18%] [-23.00dB] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 43 [66%] [8.00dB] [on]
  Front Right: Playback 43 [66%] [8.00dB] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 23 [66%] [23.00dB] [on]
  Front Right: Capture 23 [66%] [23.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 23 [66%] [23.00dB] [off]
  Front Right: Capture 23 [66%] [23.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line' 'CD' 'Aux'
  Item0: 'Rear Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line' 'CD' 'Aux'
  Item0: 'Front Mic'
Simple mixer control 'Rear Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 43 [66%] [8.00dB] [on]
  Front Right: Playback 43 [66%] [8.00dB] [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		iface MIXER
		name 'PCM Playback Volume'
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
		name 'PCM Playback Switch'
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
		name 'Headphone Playback Volume'
		value.0 42
		value.1 42
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 -2200
			dbvalue.1 -2200
		}
	}
	control.4 {
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
	control.5 {
		iface MIXER
		name 'Rear Mic Playback Volume'
		value.0 43
		value.1 43
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 800
			dbvalue.1 800
		}
	}
	control.6 {
		iface MIXER
		name 'Rear Mic Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.7 {
		iface MIXER
		name 'Front Mic Playback Volume'
		value.0 43
		value.1 43
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 800
			dbvalue.1 800
		}
	}
	control.8 {
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
	control.9 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 43
		value.1 43
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 800
			dbvalue.1 800
		}
	}
	control.10 {
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
	control.11 {
		iface MIXER
		name 'CD Playback Volume'
		value.0 43
		value.1 43
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 800
			dbvalue.1 800
		}
	}
	control.12 {
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
	control.13 {
		iface MIXER
		name 'Aux Playback Volume'
		value.0 43
		value.1 43
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 800
			dbvalue.1 800
		}
	}
	control.14 {
		iface MIXER
		name 'Aux Playback Switch'
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
	control.16 {
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
	control.17 {
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
	control.18 {
		iface MIXER
		name 'Capture Volume'
		value.0 23
		value.1 23
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 35'
			dbmin 0
			dbmax 3500
			dbvalue.0 2300
			dbvalue.1 2300
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 23
		value.1 23
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 35'
			dbmin 0
			dbmax 3500
			dbvalue.0 2300
			dbvalue.1 2300
		}
	}
	control.20 {
		iface MIXER
		name 'Input Source'
		value 'Rear Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Rear Mic'
			item.1 'Front Mic'
			item.2 Line
			item.3 CD
			item.4 Aux
		}
	}
	control.21 {
		iface MIXER
		name 'Input Source'
		index 1
		value 'Front Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Rear Mic'
			item.1 'Front Mic'
			item.2 Line
			item.3 CD
			item.4 Aux
		}
	}
	control.22 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Capture Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'Beep Playback Volume'
		value.0 12
		value.1 12
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 -2300
			dbvalue.1 -2300
		}
	}
	control.30 {
		iface MIXER
		name 'Beep Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.31 {
		iface MIXER
		name 'Master Playback Volume'
		value 42
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 -2200
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
		iface CARD
		name 'Line Out Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.34 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface CARD
		name 'Rear Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface CARD
		name 'Front Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.37 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface CARD
		name 'SPDIF Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.39 {
		iface CARD
		name 'SPDIF In Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.40 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 60
		value.1 60
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
nvidia
snd_hda_codec_realtek
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_page_alloc
snd_timer
tifm_7xx1
tifm_core


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x0f 0x01014000
0x10 0x02214000
0x11 0x50171000
0x12 0x01a19000
0x13 0x02a19000
0x14 0x01813000
0x15 0x99931000
0x16 0x99331000
0x17 0x90f71000
0x18 0x01446000
0x19 0x01c41000

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:


!!ALSA/HDA dmesg
!!------------------

usbhid: USB HID core driver
ALSA device list:
  No soundcards found.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
--
usb 1-2: reset high-speed USB device number 2 using ehci_hcd
snd_hda_intel 0000:00:1b.0: irq 44 for MSI/MSI-X
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
hda-codec: No codec parser is available
nvidia: module license 'NVIDIA' taints kernel.



--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0OAP2g/MAC+5xKAE--
