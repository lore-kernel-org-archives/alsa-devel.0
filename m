From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: Re: hda Regression: jack doesn't mute speaker
Date: Thu, 16 Apr 2009 09:05:36 +0200
Message-ID: <49E6D8C0.4040206@odi.ch>
References: <49E65947.1090406@odi.ch> <s5hd4bd2kbl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080808000703040903020207"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep20-int.chello.at (viefep20-int.chello.at [62.179.121.40])
	by alsa0.perex.cz (Postfix) with ESMTP id D933110381E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 09:05:49 +0200 (CEST)
Received: from edge02.upc.biz ([192.168.13.237]) by viefep20-int.chello.at
	(InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
	id <20090416070544.UYB20956.viefep20-int.chello.at@edge02.upc.biz>
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 09:05:44 +0200
Received: from [192.168.111.10] (mithril [192.168.111.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gollum.odi.ch (Postfix) with ESMTPSA id 95F86D5B5E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 09:05:41 +0200 (CEST)
In-Reply-To: <s5hd4bd2kbl.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080808000703040903020207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> At Thu, 16 Apr 2009 00:01:43 +0200,
> Ortwin Gl=FCck wrote:
>> Hi,
>>
>> Since 2.6.30-rc1 when I plug in headphones in the side jack the built-=
in
>> speakers are not muted any more. Worked fine until 2.6.29.1.
>=20
> What machine is it?
> Could you give alsa-info.sh output (with --no-upload option)?

It's a MacBook Pro 2,1. Find the alsa-info attached.

>> Also the "Front"=20
>> and "Surround" outputs are now both labeled "Speaker" (see attached im=
ages of kmix).
>=20
> What I/O are they actually corresponding to?  Are they speaker outputs
> or line-outs, or anything else?

They correspond to the built-in speakers.

The MacBook Pro has a headphone and a mic jack on the left side. The head=
phone=20
jack is also an optical output.

>=20
> thanks,
>=20
> Takashi

Thanks for looking into it.

Ortwin

>> lspci:
>> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Defi=
nition
>> Audio Controller (rev 02)
>>
>>
>>
>> uname -a:
>> Linux mithril 2.6.30-rc2 #2 SMP PREEMPT Wed Apr 15 22:51:36 CEST 2009 =
i686=20
>> Intel(R) Core(TM)2 CPU T7600 @ 2.33GHz GenuineIntel GNU/Linux
>>
>> dmesg:
>> HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
>> HDA Intel 0000:00:1b.0: setting latency timer to 6
>> hda_codec: STAC922x, Apple subsys_id=3D106b1a00
>> input: HDA Intel Line In at Ext Left Jack as /class/input/input8
>> input: HDA Intel Mic at Ext Left Jack as /class/input/input9
>> hda-intel: IRQ timing workaround is activated for card #0. Suggest a b=
igger=20
>> bdl_pos_adj.
>>
>>
>>
>>
>> uname -a:
>> Linux mithril 2.6.29.1 #3 SMP PREEMPT Wed Apr 15 23:03:20 CEST 2009 i6=
86
>> Intel(R) Core(TM)2 CPU T7600 @ 2.33GHz GenuineIntel GNU/Linux
>>
>> dmesg:
>> HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
>> HDA Intel 0000:00:1b.0: setting latency timer to 64
>> hda_codec: STAC922x, Apple subsys_id=3D106b1a00
>> Apr 15 23:20:22 mithril input: HDA Intel Line In at Ext Left Jack as=20
>> /class/input/input8
>> Apr 15 23:20:22 mithril input: HDA Intel Mic at Ext Left Jack as /clas=
s/input/input9
>> Apr 15 23:20:22 mithril input: HDA Intel HP Out at Ext Left Jack as=20
>> /class/input/input10
>> hda-intel: IRQ timing workaround is activated for card #0. Suggest a b=
igger
>> bdl_pos_adj.

--------------080808000703040903020207
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Thu Apr 16 06:58:37 UTC 2009


!!Linux Distribution
!!------------------

Gentoo Base System release 1.12.11.1


!!Kernel Information
!!------------------

Kernel release:    2.6.30-rc2
Operating System:  GNU/Linux
Architecture:      i686
Processor:         Intel(R) Core(TM)2 CPU T7600 @ 2.33GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.17a
Utilities version:  1.0.17


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x98400000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 8384:7680


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: position_fix=1 model=macbook-pro
snd-hda-intel: position_fix=1 model=macbook-pro


!!Loaded sound module options
!!--------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: SigmaTel STAC9221 A1
Address: 0
Function Id: 0x1
Vendor Id: 0x83847680
Subsystem Id: 0x106b1a00
Revision Id: 0x103401
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=4, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x17
  Processing caps: benign=0, ncoeff=0
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x18
  Processing caps: benign=0, ncoeff=0
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0121e21f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = White
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x90a7012e: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x2, Sequence = 0xe
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x9017e110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = White
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400000fd: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xd
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x400000fe: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xe
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x0181e020: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = White
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x60: IN OUT
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x1145e230: [Jack] SPDIF Out at Int Rear
    Conn = Optical, Color = White
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x11c5e240: [Jack] SPDIF In at Int Rear
    Conn = Optical, Color = White
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 3 samples
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x02 0x02]
  Connection: 7
     0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x400000fc: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xc
  Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=1, val=127
  Connection: 4
     0x02 0x03 0x04 0x05
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In R/L
  Amp-In caps: N/A
  Amp-In vals:  [0x8e 0x8e]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In R/L
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
  Delay: 3 samples
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  Delay: 3 samples
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x400000fb: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xb
  Pin-ctls: 0x00:
  Connection: 1
     0x1a
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Apr 16 08:54 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 24 Apr 16 08:54 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Apr 16 08:54 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 25 Apr 16 08:54 /dev/snd/pcmC0D1c
crw-rw---- 1 root audio 116, 17 Apr 16 08:54 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Apr 16 08:54 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Apr 16 08:54 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0x98400000 irq 22'
  Mixer name	: 'SigmaTel STAC9221 A1'
  Components	: 'HDA:83847680,106b1a00,00103401'
  Controls      : 23
  Simple ctrls  : 13
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 127 [50%] [-25.60dB]
  Front Right: Playback 127 [50%] [-25.60dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 14 [100%] [21.00dB] [off]
  Front Right: Capture 14 [100%] [21.00dB] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 0 [0%] [-30.00dB]
  Front Right: Capture 0 [0%] [-30.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Mux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 2
  Front Left: Capture 2 [100%] [20.00dB]
  Front Right: Capture 2 [100%] [20.00dB]
Simple mixer control 'Mux',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [-48.00dB] [on]
  Front Right: Playback 0 [0%] [-48.00dB] [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 14'
		comment.dbmin 0
		comment.dbmax 2100
		iface MIXER
		name 'Capture Volume'
		value.0 14
		value.1 14
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 14'
		comment.dbmin 0
		comment.dbmax 2100
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 0
		value.1 0
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 2'
		comment.dbmin 0
		comment.dbmax 2000
		iface MIXER
		name 'Mux Capture Volume'
		value.0 2
		value.1 2
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 Line
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.12 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 Line
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.13 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.19 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 64
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.22 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 127
		value.1 127
	}
	control.23 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 0
		value.1 0
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
rfcomm
radeon
drm
ip6t_LOG
nf_conntrack_ipv6
ip6table_filter
ip6_tables
ipv6
uvcvideo
videodev
v4l1_compat
isight_firmware
snd_hda_codec_idt
snd_hda_intel
snd_hda_codec
ohci1394
appletouch



--------------080808000703040903020207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080808000703040903020207--
