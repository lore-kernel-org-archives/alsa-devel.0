From: Manuel Naranjo <manuel@aircable.net>
Subject: Re: Regression on alsa-driver-1.0.18a on HDA for Dell
 Inspiron 1521
Date: Wed, 12 Nov 2008 12:28:03 -0200
Message-ID: <491AE7F3.2040203@aircable.net>
References: <a10be5a00811120606s12672837secdda91b80659ac8@mail.gmail.com>	<491AE402.3030507@aircable.net>
	<s5hk5b9jaim.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000700030500000805030501"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 353792445E
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 15:27:42 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so415144rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 06:27:41 -0800 (PST)
In-Reply-To: <s5hk5b9jaim.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------000700030500000805030501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> Ohh btw, 1.0.18a connects the hardwar beeper, which can only be disabled 
>> at compile time, just as a suggestion, isn't there any way to create a 
>> way to mute this on runtime? For advanced users like us this is no 
>> trouble, but for newbies this is an issue, and might scare them, the 
>> beep on a dell laptop is quite annoying (you can't image how annoying 
>> it's comming out of the headphones)
>>     
>
> Don't you have "PC Beep" mixer control?
>
>
> Takashi
>   
I do have it, but there's no mute option. And even at the lowest level 
option it keeps beeping at a very loud level.

I'm attaching alsa-info.sh output at lowest level possible, and I tell 
you it hearts when it beeps in the headphones.

--------------000700030500000805030501
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Disposition: inline;
 filename="alsa-info.txt"
Content-Transfer-Encoding: quoted-printable

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: mi=C3=A9 nov 12 12:27:27 ARST 2008


!!Linux Distribution
!!------------------

Mandriva Linux release 2009.0 (Official) for i586 LSB_VERSION=3Dlsb-3.1-i=
a32:lsb-3.1-noarch DISTRIB_ID=3DMandrivaLinux DISTRIB_DESCRIPTION=3D"Mand=
riva Linux 2009.0" Mandriva Linux release 2009.0 (Official) for i586 Mand=
riva Linux release 2009.0 (Official) for i586 Mandriva Linux release 2009=
.0 (Official) for i586 Mandriva Linux release 2009.0 (Official) for i586 =
Mandriva Linux release 2009.0 (Official) for i586


!!Kernel Information
!!------------------

Kernel release:    2.6.27.4-desktop586-1mnb
Operating System:  GNU/Linux
Architecture:      i686
Processor:         AMD Turion(tm) 64 X2 Mobile Technology TL-56
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.18a
Library version:    1.0.18
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfebfc000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1028:01fc


!!Modprobe options (Sound related)
!!--------------------------------

snd-ac97-codec: power_save=3D1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: SigmaTel STAC9205
Address: 0
Vendor Id: 0x838476a0
Subsystem Id: 0x102801fc
Revision Id: 0x100204
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D0
Default Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=3D=
1
GPIO: io=3D5, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
  IO[0]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D1
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0
  IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0
  IO[4]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D3a, enabled=3D1
  Connection: 2
     0x10* 0x11
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D1b, enabled=3D1
  Connection: 2
     0x10* 0x11
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400003fa: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0xa
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x11
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x90170310: [Fixed] Speaker at Int N/A
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x10
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400003fb: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0xb
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x10
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400003fc: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0xc
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x11
Node 0x10 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x48 0x48]
  Converter: stream=3D0, channel=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
Node 0x11 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=3D0, channel=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
Node 0x12 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
  Connection: 1
     0x1d
  Processing caps: benign=3D0, ncoeff=3D0
Node 0x13 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
  Connection: 1
     0x1e
  Processing caps: benign=3D0, ncoeff=3D0
Node 0x14 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x400003fd: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0xd
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x15
Node 0x15 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x40f000f9: [N/A] Other at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x9
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x90a60330: [Fixed] Mic at Int N/A
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x400003ff: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0xf
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e 0x16 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e 0x16 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x1b [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x19
Node 0x1c [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x1a
Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x1b 0x17* 0x18
Node 0x1e [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x1c* 0x17 0x18
Node 0x1f [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x20 [Audio Input] wcaps 0x140311: Stereo Digital
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x22
Node 0x21 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x0144131f: [Jack] SPDIF Out at Ext Rear
    Conn =3D RCA, Color =3D Black
    DefAssociation =3D 0x1, Sequence =3D 0xf
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x1f* 0x1d 0x1e
Node 0x22 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x40c003fe: [N/A] SPDIF In at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0xe
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 3 samples
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D0
  Amp-Out vals:  [0x00]
Node 0x24 [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=3D1, steps=3D127, direct=3D1, val=3D127
  Connection: 2
     0x10* 0x11
Node 0x25 [Vendor Defined Widget] wcaps 0xf00001: Stereo
Codec: Conexant ID 2c06
Address: 1
Vendor Id: 0x14f12c06
Subsystem Id: 0x14f1000f
Revision Id: 0x100000
Modem Function Group: 0x2
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 2008-11-12 12:25 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 24 2008-11-12 12:25 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 2008-11-12 12:25 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 17 2008-11-12 12:25 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  1 2008-11-12 12:25 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 2008-11-12 12:25 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

#pcm.bluetooth {
#    type bluetooth
#    device 00:12:0E:06:C5:8A
#    profile "voice"
#}

pcm.pulse {
    type pulse
}
   =20
ctl.pulse {
    type pulse
}
       =20

!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Card hw:0 'SB'/'HDA ATI SB at 0xfebfc000 irq 16'
  Mixer name	: 'SigmaTel STAC9205'
  Components	: 'HDA:838476a0,102801fc,00100204 HDA:14f12c06,14f1000f,0010=
0000'
  Controls      : 23
  Simple ctrls  : 16
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 101 [80%] [-19.50dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 204 [80%] [-10.20dB]
  Front Right: Playback 204 [80%] [-10.20dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 98 [77%] [-21.75dB] [on]
  Front Right: Playback 98 [77%] [-21.75dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities: enum
  Items: 'Digital Playback' 'Analog Mux 1' 'Analog Mux 2'
  Item0: 'Digital Playback'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 12 [80%] [18.00dB] [on]
  Front Right: Capture 12 [80%] [18.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 12 [80%] [18.00dB] [on]
  Front Right: Capture 12 [80%] [18.00dB] [on]
Simple mixer control 'Analog Loopback',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]
Simple mixer control 'Digital Input Source',0
  Capabilities: enum
  Items: 'Analog Inputs' 'Digital Mic 1'
  Item0: 'Digital Mic 1'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic'
  Item0: 'Mic'
Simple mixer control 'Mux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 4 [100%] [40.00dB]
  Front Right: Capture 4 [100%] [40.00dB]
Simple mixer control 'Mux',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 4 [100%] [40.00dB]
  Front Right: Capture 4 [100%] [40.00dB]
Simple mixer control 'PC Beep',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 0 [0%] [-18.00dB]


!!Alsactl output
!!-------------

--startcollapse--
state.SB {
	control.1 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.2 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Loopback'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 12
		value.1 12
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 98
		value.1 98
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'PC Beep Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		value.0 4
		value.1 4
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		index 1
		value.0 4
		value.1 4
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 'Digital Mic 1'
		iface MIXER
		name 'Digital Input Source'
		value 'Digital Mic 1'
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		iface MIXER
		name 'IEC958 Playback Source'
		value 'Digital Playback'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 101
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
		value.0 204
		value.1 204
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
		value.0 120
		value.1 120
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_pcm
snd_timer
snd_page_alloc
snd_mixer_oss
snd
soundcore
hidp
rfcomm
bridge
stp
bnep
l2cap
btusb
bluetooth
usbhid
ff_memless
fglrx
ipv6
vboxdrv
binfmt_misc
loop
vfat
fat
dm_mod
cpufreq_ondemand
cpufreq_conservative
cpufreq_powersave
powernow_k8
freq_table
nvram
i8k
af_packet
b44
ssb
sdhci_pci
uvcvideo
pcmcia
compat_ioctl32
mmc_block
pcmcia_core
videodev
sdhci
v4l1_compat
ricoh_mmc
mii
ndiswrapper
mmc_core
ohci1394
i2c_piix4
thermal
battery
wmi
video
processor
button
ac
ieee1394
k8temp
output
ati_agp
dcdbas
shpchp
agpgart
i2c_core
pci_hotplug
rtc_cmos
joydev
evdev
sg
sr_mod
pata_atiixp
ata_piix
ahci
libata
dock
sd_mod
scsi_mod
crc_t10dif
ext3
jbd
uhci_hcd
ohci_hcd
ehci_hcd
usbcore



--------------000700030500000805030501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000700030500000805030501--
