From: Uros Vampl <mobile.leecher@gmail.com>
Subject: Re: No sound on Quanta KN1 with kernel 3.4
Date: Wed, 18 Apr 2012 13:36:55 +0200
Message-ID: <20120418113655.GA26938@zverina>
References: <20120414171029.GA740@zanic_kista> <s5hiph2p132.wl%tiwai@suse.de>
	<20120414205209.GA1041@zanic_kista> <s5hbomrsrc1.wl%tiwai@suse.de>
	<20120416175609.GA22954@zverina> <s5h62czpjhu.wl%tiwai@suse.de>
	<s5hfwc1o46s.wl%tiwai@suse.de> <20120418095545.GA26678@zverina>
	<s5hmx6949oi.wl%tiwai@suse.de> <s5h8vht49fp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id AF9F3243E0
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 13:36:53 +0200 (CEST)
Received: by werg1 with SMTP id g1so4873986wer.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 04:36:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5h8vht49fp.wl%tiwai@suse.de>
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


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.04.12 12:32, Takashi Iwai wrote:
> Below is the test patch.  Again, adjust the mixer volumes after
> applying the patch.  Now you should have "Headphone" and "Speaker"
> volumes & switches.
>=20
> Also, the speaker is muted automatically when the headphone is plugged.
> For testing the speaker, unplug the headphone.

Still no sound, not speakers, not headphones. Did you see my other mail=20
about the "Front" control?

Also, there's only one capture control now. Shouldn't I be able to=20
choose whether to capture from internal or external mic?

Attached is alsa-info.txt with the new patch.


Regards,
Uro=C5=A1

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info.txt.XzqSmgC6SY"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Wed Apr 18 11:30:58 UTC 2012


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
  Converter: stream=8, channel=0
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
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="ALC260 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x8e 0x8e] [0x8e 0x8e] [0x8e 0x8e] [0x8e 0x8e] [0x8e 0x8e] [0x8e 0x8e] [0x8e 0x8e]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 7
     0x12* 0x13 0x14 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 8
     0x12* 0x13 0x14 0x15 0x16 0x07 0x0f 0x10
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
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
  Control: name="Internal Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals:  [0xa3 0xa3] [0xa3 0xa3] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x0b 0x0b] [0x80 0x80] [0x80 0x80]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x2c 0x2c]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00] [0x00]
  Amp-Out caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=0
  Amp-Out vals:  [0x0f]
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
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001003f: IN OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
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
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x90a60160: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x02a19000: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
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
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
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

crw-rw---- 1 root audio 116,  0 Apr 18 13:08 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Apr 18 13:08 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116,  5 Apr 18 13:08 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 24 Apr 18 13:28 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Apr 18 13:12 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 Apr 18 13:08 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Apr 18 13:08 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Apr 18 13:08 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Apr 18 13:08 .
drwxr-xr-x 3 root root 220 Apr 18 13:08 ..
lrwxrwxrwx 1 root root  12 Apr 18 13:08 pci-0000:00:1b.0 -> ../controlC0


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

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xc0000000 irq 44'
  Mixer name	: 'Realtek ALC260'
  Components	: 'HDA:10ec0260,02600000,00100400 HDA:10573055,10573055,00100700'
  Controls      : 25
  Simple ctrls  : 12
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 44 [69%] [-20.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 65
  Mono: Playback 35 [54%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 35 [54%] [0.00dB] [off]
  Front Right: Playback 35 [54%] [0.00dB] [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 11 [17%] [-24.00dB] [on]
  Front Right: Playback 11 [17%] [-24.00dB] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 14 [40%] [14.00dB] [off]
  Front Right: Capture 14 [40%] [14.00dB] [off]
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
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 35 [54%] [0.00dB] [off]
  Front Right: Playback 35 [54%] [0.00dB] [off]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
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
		name 'Headphone Playback Switch'
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
		name 'Speaker Playback Volume'
		value 35
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 0
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'Internal Mic Playback Volume'
		value.0 35
		value.1 35
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.6 {
		iface MIXER
		name 'Internal Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.7 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 35
		value.1 35
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.8 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.9 {
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
	control.10 {
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
	control.11 {
		iface MIXER
		name 'Capture Volume'
		value.0 14
		value.1 14
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 35'
			dbmin 0
			dbmax 3500
			dbvalue.0 1400
			dbvalue.1 1400
		}
	}
	control.12 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.13 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.14 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.15 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'Beep Playback Volume'
		value.0 11
		value.1 11
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 65'
			dbmin -3500
			dbmax 3000
			dbvalue.0 -2400
			dbvalue.1 -2400
		}
	}
	control.18 {
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
	control.19 {
		iface MIXER
		name 'Master Playback Volume'
		value 44
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 -2000
		}
	}
	control.20 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.21 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface CARD
		name 'SPDIF Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.24 {
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
	control.25 {
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
0x10 0x02214000
0x11 0x99130110
0x12 0x90a60160
0x13 0x02a19000
0x18 0x01446000
0x0f 0x411111f0
0x14 0x411111f0
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x19 0x411111f0

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



--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--k+w/mQv8wyuph6w0--
