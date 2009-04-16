From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: Re: hda Regression: jack doesn't mute speaker
Date: Thu, 16 Apr 2009 09:31:12 +0200
Message-ID: <49E6DEC0.5010308@odi.ch>
References: <49E65947.1090406@odi.ch> <s5hd4bd2kbl.wl%tiwai@suse.de>
	<49E6D8C0.4040206@odi.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010002080609000202070001"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep16-int.chello.at (viefep16-int.chello.at [62.179.121.36])
	by alsa0.perex.cz (Postfix) with ESMTP id D91A310393D
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 09:31:16 +0200 (CEST)
Received: from edge04.upc.biz ([192.168.13.239]) by viefep16-int.chello.at
	(InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
	id <20090416073115.UZPX10095.viefep16-int.chello.at@edge04.upc.biz>
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 09:31:15 +0200
Received: from [192.168.111.10] (mithril [192.168.111.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gollum.odi.ch (Postfix) with ESMTPSA id DE73B8AD2
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 09:31:12 +0200 (CEST)
In-Reply-To: <49E6D8C0.4040206@odi.ch>
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
--------------010002080609000202070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable



Ortwin Gl=FCck wrote:
> It's a MacBook Pro 2,1. Find the alsa-info attached.

Oh, ignore the module option. I had added that one just for now, but that=
 gives
me a "Headphone" and "Speaker" control and no sound at all.

Well, I have removed the module option again, and also deleted the two fi=
les in=20
/var/lib/alsa. Now I get slightly different controls, same misbehaviour w=
ith the=20
jack though. (No idea what these "Mux" things are supposed to do, they ap=
pear to=20
have no effect.)

Ortwin




--------------010002080609000202070001
Content-Type: image/png;
 name="2.6.30.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="2.6.30.png"

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
VGvlymPIPc0700bTrW0zQoNr07BJa+5++Gm++CPe5jKsJVlr0+y9b5VR1i8M+WUihLpVqmWc
kpJS7KWUtwb04xePbnyycRvnEi/zz57NTHugA1v++6BidRJCiMqwTzeFKZ9VM0cTHdmQOvUa
c+fImVzIN1R5e+/GJbPy1dG0ahSMu9YNv6CG9Lp3FB9t+NumbZvrW7SFb23ajfum1+v5c+nL
dG8TTnBwKFE9B/NdfPr1TRpSmPfkIJrUD6Fh0yieemNjsfXPbH6fO7u3pV6dYJq27cms5duq
HIsKqcDPQ6/Xs+mtCURFNCSkfjj3jX+TdIPJvvUVwgXYZTTF3rkDmXegMV9sPcyFE7sZFrSF
gU/9XOVyx7XWM+zZN/l19z+k51pPJmVt29yqL9rCtzbNmik7g1gZE0viheMseMSPiffNtszb
+vzdfJbek98PJhD/9w803j2t2Lr3P/4KA1//kpMXE9n901L0+2ffWHyNqujPY+r2+qz9+xin
D8TQ+fJy7nzxf3asrRCuQdPkjomm/iOmcuxSnk03CiqrP1Wv11t9P7BxXSbvP03fQE8ADDnx
1IscwaWzVWsRGnJOsXje23z7058cOXkOz+BIet89lJdemUS4l9ambRetZ9F9LGuaXq9n14Uk
Iq9tw2TIoHZoC5KTzgPQr1EoL8Ql0O/aNnNTf6Zu+DDL+v0ahdJrzjIevr0HTetVX19uef3C
tv48btzXL05c5A79tX1J+YnG7d7iYkLVf5kK4crMNwrKOHuApIMxVOrRyBXtJ955NY9/hdct
Nq0yT46+kdarCRNmvcuEWQBGLh6P5ZsPXuD2/jnE//FijW7bnIgBNFp/TIZsy+fYzHxuDfC0
fPasdWuxdb9at5iX5n3A4FfHkuHXkolzPmHy3Y2rXCco/WdTNFFXNCa9A4vsS8Bt5GWOqGIt
hRA3sks3RQdfHZvPXCp20S85Obmat+JG3abRjP/vapIPvWfztq0loaom67a+HvyZlmv5nJv+
R7H5QdGD+eCLDcTGn2Pze8OZO9a+Fxwr+vP4LbXIvqT9jodPlD2qKYRLsUsynjuhPSNHvc7+
08kYjPmc/2cbs8f0rXK5nQeO4ZO1v3PmSgYGk4HUi/GsfPVxAiJG2bztcC8tf1zMKlautWkV
MXNoBM+OX8Tp1FxyU0+zcNyUYvP7jpnNzmOJGIwG3NwAqn4xsyIq+vOYMm4Bp1JzyU09xYJx
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
--------------010002080609000202070001
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Thu Apr 16 07:30:13 UTC 2009


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

snd-hda-intel: position_fix=1
snd-hda-intel: position_fix=1


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
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6a 0x6a]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6a 0x6a]
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
  Digital:
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
  Pin Default 0x0321e21f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = White
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x03a1e02e: [Jack] Mic at Ext Left
    Conn = 1/8, Color = White
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=01, enabled=1
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
  Pin Default 0x9017e11f: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = White
    DefAssociation = 0x1, Sequence = 0xf
    Misc = NO_PRESENCE
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
  Pin Default 0x0381e020: [Jack] Line In at Ext Left
    Conn = 1/8, Color = White
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x60: IN OUT
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x1345e230: [Jack] SPDIF Out at Int Left
    Conn = Optical, Color = White
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x13c5e240: [Jack] SPDIF In at Int Left
    Conn = Optical, Color = White
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 3 samples
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
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
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In R/L
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
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

crw-rw---- 1 root audio 116,  0 Apr 16 09:24 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 24 Apr 16 09:24 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Apr 16 09:26 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 25 Apr 16 09:24 /dev/snd/pcmC0D1c
crw-rw---- 1 root audio 116, 17 Apr 16 09:24 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Apr 16 09:24 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Apr 16 09:24 /dev/snd/timer


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
  Controls      : 20
  Simple ctrls  : 12
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 43 [67%] [-15.75dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
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
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
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
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',1
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]


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
		value.0 0
		value.1 0
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
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
		value.0 false
		value.1 false
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
		value.0 64
		value.1 64
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
		name 'Speaker Playback Volume'
		index 1
		value.0 64
		value.1 64
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Speaker Playback Switch'
		index 1
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
		value.0 0
		value.1 0
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
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 43
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.20 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
hfsplus
rfcomm
radeon
drm
ip6t_LOG
nf_conntrack_ipv6
ip6table_filter
ip6_tables
ipv6
snd_hda_codec_idt
uvcvideo
videodev
snd_hda_intel
v4l1_compat
snd_hda_codec
appletouch
ohci1394



--------------010002080609000202070001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010002080609000202070001--
