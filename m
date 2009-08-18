From: epic <epicadocan@gmail.com>
Subject: [PATCH] various acer-mic-internal bugs solution
Date: Wed, 19 Aug 2009 00:18:56 +0100
Message-ID: <4A8B36E0.6080404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8854995804066721183=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 729D624356
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 01:19:06 +0200 (CEST)
Received: by ewy20 with SMTP id 20so3982286ewy.46
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2009 16:19:06 -0700 (PDT)
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8854995804066721183==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig34FEC857E3E1F8D0268C7469"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34FEC857E3E1F8D0268C7469
Content-Type: multipart/mixed;
 boundary="------------020009000905070000040802"

This is a multi-part message in MIME format.
--------------020009000905070000040802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Several mic related bugs maybe solved with this patch or a derived one


 1  -My internal-mic was not working and front jack mic sound was
terrible (useless for headset mic).

 2  -Detected offset level from inputs {line, mic}, this offset level
increases with specific [boost] and/or [capture(NID 0x23)] gain.

* I just played around several days compiling and testing alsa with my
acer-alc268, checked all data communication with alc268, pin config etc.
and tested different values for offset in pins.

* Found internal-mic comes alive with a 50% offset v_reference and mic
sound is much better.

*This patch applies/solves only for alc268 with option model=3Dacer in
alsa-base.conf, but i think the others acer-alcxxx bugs maybe solved in
the same way.

	changing PIN_VREF80 to PIN_VREF50 at
		NID 0x18 mic
		NID 0x19 internal-mic
		NID 0x1a line-in (not tested)

*Don't know what can happen to other acer-alcxxx, so i only patched
acer-alc268. But this patch solved my mic-internal issue and most
important for me now i can use a headset mic.

*It remains a level offset, lower than before, but mic is usable, the
level is  showed in the pictures.


*Pictures: input with two channels and a positive offset in left channel
(red), negative offset in rigth channel (blue)
	http://imagebin.ca/view/Y8TyujP.html

working internal microphone ok
	http://imagebin.ca/view/nzTzeX.html

Realtek datasheet 1.3 is available for alc268


	2.6.26-2-686 #1 SMP i686 GNU/Linux debian/squeeze
	description: Computer
	product: Aspire 7720
	vendor: Acer
	version: V1.17

TAGS: alc268 offset level internal mic microphone alsa hda intel realtek


Signed-off-by: EliasTG <epicadocan a.t gmail.com>


--------------020009000905070000040802
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="alsa-info.txt"

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Tue Aug 18 21:27:39 UTC 2009


!!Linux Distribution
!!------------------

Debian GNU/Linux squeeze/sid \n \l


!!Kernel Information
!!------------------

Kernel release:    2.6.26-2-686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.20
Utilities version:  1.0.20


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x9b300000 irq 11


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Con=
troller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1025:011e


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2
snd-hda-intel: index=3D0 model=3Dtest


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : 0,-1,-1,-1,-1,-1,-1,-1
model : test,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC268
Address: 0
Function Id: 0x1
Vendor Id: 0x10ec0268
Subsystem Id: 0x1025011e
Revision Id: 0x100003
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D4, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x2c 0x2c]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x2c 0x2c]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x100111: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x100111: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00]
  Connection: 1
     0x02
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x02 0x1d
Node 0x10 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
  Connection: 3
     0x03 0x1d 0x02
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x02211020: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D04, enabled=3D1
  Connection: 1
     0x0f
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x02, stepsize=3D0x4f, mute=3D0
  Amp-In vals:  [0x02 0x02]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19840: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x4, Sequence =3D 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x02
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x02, stepsize=3D0x4f, mute=3D0
  Amp-In vals:  [0x02 0x02]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x99a30941: [Fixed] Mic at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x4, Sequence =3D 0x1
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=3D00, enabled=3D0
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x02, stepsize=3D0x4f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0281304e: [Jack] Line In at Ext Front
    Conn =3D 1/8, Color =3D Blue
    DefAssociation =3D 0x4, Sequence =3D 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x02
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4017952d: [N/A] Speaker at Ext N/A
    Conn =3D Analog, Color =3D Pink
    DefAssociation =3D 0x2, Sequence =3D 0xd
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x02451130: [Jack] SPDIF Out at Ext Front
    Conn =3D Optical, Color =3D Black
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D10
  Processing Coefficient: 0x03
  Coefficient Index: 0x01
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x15 0x15]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x12
Node 0x24 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x13
Codec: Conexant ID 2c06
Address: 1
Function Id: 0x2
Vendor Id: 0x14f12c06
Subsystem Id: 0x1025011e
Revision Id: 0x100000
Modem Function Group: 0x2
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 Aug 18 22:02 /dev/snd/controlC0
crw-rw----  1 root audio 116,  4 Aug 18 22:02 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  5 Aug 18 22:02 /dev/snd/hwC0D1
crw-rw----+ 1 root audio 116, 24 Aug 18 22:02 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 Aug 18 22:02 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  1 Aug 18 05:24 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Aug 18 05:24 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC268 Analog [ALC268 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC268 Analog [ALC268 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0x9b300000 irq 11'
  Mixer name	: 'Realtek ALC268'
  Components	: 'HDA:10ec0268,1025011e,00100003 HDA:14f12c06,1025011e,0010=
0000'
  Controls      : 12
  Simple ctrls  : 9
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 44 [69%] [-20.00dB] [on]
  Front Right: Playback 44 [69%] [-20.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 185 [73%] [-14.00dB]
  Front Right: Playback 185 [73%] [-14.00dB]
Simple mixer control 'Line In Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 2
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 2
  Front Left: 2 [100%]
  Front Right: 2 [100%]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 21 [68%] [15.00dB] [on]
  Front Right: Capture 21 [68%] [15.00dB] [on]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 12
  Mono:
  Front Left: Playback 0 [0%] [-24.00dB] [off]
  Front Right: Playback 0 [0%] [-24.00dB] [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 0 [0%] [-30.00dB]
  Front Right: Capture 0 [0%] [-30.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 2
  Front Left: 2 [100%]
  Front Right: 2 [100%]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 44
		value.1 44
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 2'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mic Boost'
		value.0 2
		value.1 2
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 2'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Internal Mic Boost'
		value.0 2
		value.1 2
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 2'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Line In Boost'
		value.0 0
		value.1 0
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 21
		value.1 21
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 12'
		comment.dbmin -2400
		comment.dbmax 0
		iface MIXER
		name 'Beep Playback Volume'
		value.0 0
		value.1 0
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Beep Playback Switch'
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 185
		value.1 185
	}
	control.12 {
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
snd_hda_codec_realtek
snd_hda_intel
snd_hda_codec
snd_hwdep
usb_storage
nvidia
ppdev
parport_pc
lp
parport
ipv6
sbp2
loop
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
snd_seq_oss
snd_seq_midi
snd_rawmidi
snd_seq_midi_event
snd_seq
snd_timer
snd_seq_device
mxl5005s
zl10353
snd
arc4
ecb
crypto_blkcipher
soundcore
joydev
dvb_usb_ce6230
dvb_usb
iwl3945
snd_page_alloc
dvb_core
uvcvideo
serio_raw
mac80211
i2c_i801
acer_wmi
firmware_class
videodev
v4l1_compat
cfg80211
i2c_core
psmouse
pcspkr
led_class
evdev
video
output
battery
button
ac
wmi
ext2
mbcache
usbhid
hid
ff_memless
ide_cd_mod
cdrom
ide_pci_generic
sd_mod
ata_generic
uhci_hcd
ahci
sdhci
libata
ricoh_mmc
mmc_core
ohci1394
scsi_mod
dock
ieee1394
piix
ide_core
tg3
ehci_hcd
usbcore
intel_agp
agpgart
thermal
processor
fan
thermal_sys
dm_mirror
dm_log
dm_mod


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x12 0x411111f0
0x13 0x411111f0
0x14 0x02211020
0x15 0x99130110
0x16 0x411111f0
0x18 0x02a19840
0x19 0x99a30941
0x1a 0x0281304e
0x1c 0x411111f0
0x1d 0x4017952d
0x1e 0x02451130

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:
0x73 0x016a10f0

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:



--------------020009000905070000040802
Content-Type: text/plain;
 name="codec0.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="codec0.txt"

Codec: Realtek ALC268
Address: 0
Function Id: 0x1
Vendor Id: 0x10ec0268
Subsystem Id: 0x1025011e
Revision Id: 0x100003
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D4, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x2c 0x2c]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x2c 0x2c]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x100111: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x100111: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00]
  Connection: 1
     0x02
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x02 0x1d
Node 0x10 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
  Connection: 3
     0x03 0x1d 0x02
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x02211020: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D04, enabled=3D1
  Connection: 1
     0x0f
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x02, stepsize=3D0x4f, mute=3D0
  Amp-In vals:  [0x02 0x02]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19840: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x4, Sequence =3D 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x02
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x02, stepsize=3D0x4f, mute=3D0
  Amp-In vals:  [0x02 0x02]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x99a30941: [Fixed] Mic at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x4, Sequence =3D 0x1
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=3D00, enabled=3D0
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x02, stepsize=3D0x4f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0281304e: [Jack] Line In at Ext Front
    Conn =3D 1/8, Color =3D Blue
    DefAssociation =3D 0x4, Sequence =3D 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x02
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4017952d: [N/A] Speaker at Ext N/A
    Conn =3D Analog, Color =3D Pink
    DefAssociation =3D 0x2, Sequence =3D 0xd
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x02451130: [Jack] SPDIF Out at Ext Front
    Conn =3D Optical, Color =3D Black
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D10
  Processing Coefficient: 0xa948
  Coefficient Index: 0x02
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x15 0x15]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x12
Node 0x24 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x13

--------------020009000905070000040802
Content-Type: text/plain;
 name="log07.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="log07.txt"


[617100.073588] hda_codec:patch_alc268 here we go! v2
[617100.079773] hda_codec:snd_hda_codec_write: 0x170e01
[617100.079856] hda_codec:snd_hda_codec_read: 0x1f000d  -->       0x0
[617100.079954] hda_codec:snd_hda_codec_read: 0x100f0000  -->  0x14f12c06=

[617100.080028] hda_codec:snd_hda_codec_read: 0x100f0001  -->       0x0
[617100.080105] hda_codec:snd_hda_codec_read: 0x100f0002  -->  0x100000
[617100.080170] hda_codec:snd_hda_codec_read: 0x100f0004  -->   0x20001
[617100.080257] hda_codec:snd_hda_codec_read: 0x102f0005  -->     0x102
[617100.080333] hda_codec:snd_hda_codec_read: 0x102f0004  -->  0x700004
[617100.080398] hda_codec:snd_hda_codec_read: 0x170f0009  -->  0xf00000
[617100.080464] hda_codec:snd_hda_codec_read: 0x171f0009  -->  0x100100
[617100.080548] hda_codec:snd_hda_codec_read: 0x172f0009  -->       0x0
[617100.080625] hda_codec:snd_hda_codec_read: 0x173f0009  -->  0x400100
[617100.080689] hda_codec:snd_hda_codec_read: 0x173f1c00  -->  0x16a10f0
[617100.080756] hda_codec:snd_hda_codec_read: 0x102f2000  -->  0x1025011e=

[617100.080762] hda_codec:snd_hda_codec_write: 0x10270500
[617100.110915] hda_codec:snd_hda_codec_read: 0x102f0500  -->       0x0
[617100.114318] hda_codec:snd_hda_codec_read: 0x2f000a  -->   0xe0560
[617100.114318] hda_codec:snd_hda_codec_read: 0x2f000b  -->       0x1
[617100.114318] hda_codec:snd_hda_codec_read: 0x8f000a  -->   0x60160
[617100.114318] hda_codec:snd_hda_codec_read: 0x8f000b  -->       0x1
[617100.114318] hda_codec:snd_hda_codec_write: 0x17ff00
[617100.114318] hda_codec:snd_hda_codec_write: 0x23b000
[617100.114318] hda_codec:snd_hda_codec_write: 0x33b000
[617100.114318] hda_codec:snd_hda_codec_write: 0xe37000
[617100.114318] hda_codec:snd_hda_codec_write: 0xe70100
[617100.114318] hda_codec:snd_hda_codec_write: 0xf37000
[617100.114318] hda_codec:snd_hda_codec_write: 0x1037000
[617100.114318] hda_codec:snd_hda_codec_write: 0x1470740
[617100.114318] hda_codec:snd_hda_codec_write: 0x15707c0
[617100.114318] hda_codec:snd_hda_codec_write: 0x1670740
[617100.114318] hda_codec:snd_hda_codec_write: 0x1870722
[617100.114318] hda_codec:snd_hda_codec_write: 0x1970722
[617100.114318] hda_codec:snd_hda_codec_write: 0x1a70720
[617100.114318] hda_codec:snd_hda_codec_write: 0x1c70720
[617100.114318] hda_codec:snd_hda_codec_write: 0x1d70720
[617100.114318] hda_codec:snd_hda_codec_write: 0x143b080
[617100.114318] hda_codec:snd_hda_codec_write: 0x153b080
[617100.114318] hda_codec:snd_hda_codec_write: 0x163b080
[617100.114318] hda_codec:snd_hda_codec_write: 0x183b080
[617100.114318] hda_codec:snd_hda_codec_write: 0x1a3b080
[617100.114318] hda_codec:snd_hda_codec_write: 0x1d37000
[617100.114318] hda_codec:snd_hda_codec_write: 0xf37180
[617100.114318] hda_codec:snd_hda_codec_write: 0x1037180
[617100.114318] hda_codec:snd_hda_codec_write: 0x2370100
[617100.114318] hda_codec:snd_hda_codec_write: 0x233b000
[617100.114318] hda_codec:snd_hda_codec_write: 0x2470100
[617100.114318] hda_codec:snd_hda_codec_write: 0x243b000
[617100.114318] hda_codec:snd_hda_codec_write: 0x1470c02
[617100.114318] hda_codec:snd_hda_codec_write: 0x1570c02
[617100.114318] hda_codec:snd_hda_codec_write: 0x1270720
[617100.114318] hda_codec:snd_hda_codec_write: 0x1370720
[617100.114318] hda_codec:snd_hda_codec_write: 0x14707c0
[617100.114318] hda_codec:snd_hda_codec_write: 0x1570740
[617100.114318] hda_codec:snd_hda_codec_write: 0x1870722
[617100.114318] hda_codec:snd_hda_codec_write: 0x1a70722
[617100.114318] hda_codec:snd_hda_codec_write: 0x1470884
[617100.114318] hda_codec:snd_hda_codec_read: 0x14f0900  -->       0x0
[617100.114318] hda_codec:snd_hda_codec_read: 0x14ba000  -->      0x80
[617100.114318] hda_codec:snd_hda_codec_read: 0x15ba000  -->      0x80
[617100.114318] hda_codec:snd_hda_codec_read: 0x15b8000  -->      0x80
[617100.114318] hda_codec:snd_hda_codec_read: 0x2f0012  -->   0x34040
[617100.114318] hda_codec:snd_hda_codec_read: 0x23f0012  -->  0x80051f0b
[617100.135224] hda_codec:snd_hda_codec_read: 0x14f0900  -->  0x80000000
[617100.162363] hda_codec:snd_hda_codec_read: 0x18f000d  -->  0x4f0200
[617100.162363] hda_codec:snd_hda_codec_read: 0x19f000d  -->  0x4f0200
[617100.162363] hda_codec:snd_hda_codec_read: 0x1af000d  -->  0x4f0200
[617100.162363] hda_codec:snd_hda_codec_read: 0x2ba000  -->       0x0
[617100.162363] hda_codec:snd_hda_codec_write: 0x23a036
[617100.162363] hda_codec:snd_hda_codec_read: 0x2b8000  -->       0x0
[617100.162363] hda_codec:snd_hda_codec_write: 0x239036
[617100.162363] hda_codec:snd_hda_codec_read: 0x3ba000  -->       0x0
[617100.162363] hda_codec:snd_hda_codec_write: 0x33a036
[617100.162363] hda_codec:snd_hda_codec_read: 0x3b8000  -->       0x0
[617100.162377] hda_codec:snd_hda_codec_write: 0x339036
[617100.162387] hda_codec:snd_hda_codec_write: 0x143a000
[617100.162491] hda_codec:snd_hda_codec_read: 0x14b8000  -->      0x80
[617100.162498] hda_codec:snd_hda_codec_write: 0x1439000
[617100.162557] hda_codec:snd_hda_codec_read: 0x18b2000  -->       0x0
[617100.162621] hda_codec:snd_hda_codec_read: 0x18b0000  -->       0x0
[617100.162702] hda_codec:snd_hda_codec_read: 0x19b2000  -->       0x0
[617100.162789] hda_codec:snd_hda_codec_read: 0x19b0000  -->       0x0
[617100.162869] hda_codec:snd_hda_codec_read: 0x1ab2000  -->       0x0
[617100.162955] hda_codec:snd_hda_codec_read: 0x1ab0000  -->       0x0
[617100.163035] hda_codec:snd_hda_codec_read: 0x23ba000  -->       0x0
[617100.163122] hda_codec:snd_hda_codec_read: 0x23b8000  -->       0x0
[617100.163128] hda_codec:snd_hda_codec_write: 0x2339006
[617100.163136] hda_codec:snd_hda_codec_write: 0x233a080
[617100.163239] hda_codec:snd_hda_codec_read: 0x1db2000  -->       0x0
[617100.163306] hda_codec:snd_hda_codec_read: 0x1db0000  -->       0x0
[617100.163385] hda_codec:snd_hda_codec_read: 0xfb2001  -->      0x80
[617100.163452] hda_codec:snd_hda_codec_read: 0xfb0001  -->      0x80
[617100.163538] hda_codec:snd_hda_codec_read: 0x10b2001  -->      0x80
[617100.163615] hda_codec:snd_hda_codec_read: 0x10b0001  -->      0x80
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f000a  -->   0xe0560
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f000b  -->       0x1
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f000d  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f0012  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f0004  -->   0x20023
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f0011  -->  0x40000004
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f1600  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f1700  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f1800  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f1900  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f1a00  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x1f1500  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x2f0009  -->      0x1d
[617165.253398] hda_codec:snd_hda_codec_read: 0x2f0012  -->   0x34040
[617165.253398] hda_codec:snd_hda_codec_read: 0x2ba000  -->      0x36
[617165.253398] hda_codec:snd_hda_codec_read: 0x2b8000  -->      0x36
[617165.253398] hda_codec:snd_hda_codec_read: 0x2f0600  -->       0x0
[617165.253398] hda_codec:snd_hda_codec_read: 0x2f000a  -->   0xe0560
[617165.253398] hda_codec:snd_hda_codec_read: 0x2f000b  -->       0x1
[617165.253398] hda_codec:snd_hda_codec_read: 0x3f0009  -->      0x1d
[617165.253398] hda_codec:snd_hda_codec_read: 0x3f0012  -->   0x34040
[617165.253398] hda_codec:snd_hda_codec_read: 0x3ba000  -->      0x36
[617165.255878] hda_codec:snd_hda_codec_read: 0x3b8000  -->      0x36
[617165.255942] hda_codec:snd_hda_codec_read: 0x3f0600  -->       0x0
[617165.256009] hda_codec:snd_hda_codec_read: 0x3f000a  -->   0xe0560
[617165.256095] hda_codec:snd_hda_codec_read: 0x3f000b  -->       0x1
[617165.256174] hda_codec:snd_hda_codec_read: 0x4f0009  -->  0xf00000
[617165.256239] hda_codec:snd_hda_codec_read: 0x5f0009  -->  0xf00000
[617165.256316] hda_codec:snd_hda_codec_read: 0x6f0009  -->     0x211
[617165.256383] hda_codec:snd_hda_codec_read: 0x6f0600  -->       0x0
[617165.256447] hda_codec:snd_hda_codec_read: 0x6f0d00  -->       0x0
[617165.256524] hda_codec:snd_hda_codec_read: 0x6f000a  -->  0x1e05e0
[617165.256590] hda_codec:snd_hda_codec_read: 0x6f000b  -->       0x1
[617165.256676] hda_codec:snd_hda_codec_read: 0x7f0009  -->  0x100111
[617165.256754] hda_codec:snd_hda_codec_read: 0x7f000e  -->       0x1
[617165.256818] hda_codec:snd_hda_codec_read: 0x7f0200  -->      0x24
[617165.256884] hda_codec:snd_hda_codec_read: 0x7f0600  -->       0x0
[617165.256961] hda_codec:snd_hda_codec_read: 0x7f0400  -->       0x0
[617165.257025] hda_codec:snd_hda_codec_read: 0x7f000a  -->   0x60160
[617165.257092] hda_codec:snd_hda_codec_read: 0x7f000b  -->       0x1
[617165.257171] hda_codec:snd_hda_codec_read: 0x8f0009  -->  0x100111
[617165.257235] hda_codec:snd_hda_codec_read: 0x8f000e  -->       0x1
[617165.257321] hda_codec:snd_hda_codec_read: 0x8f0200  -->      0x23
[617165.257398] hda_codec:snd_hda_codec_read: 0x8f0600  -->       0x0
[617165.257464] hda_codec:snd_hda_codec_read: 0x8f0400  -->       0x0
[617165.257529] hda_codec:snd_hda_codec_read: 0x8f000a  -->   0x60160
[617165.257605] hda_codec:snd_hda_codec_read: 0x8f000b  -->       0x1
[617165.257674] hda_codec:snd_hda_codec_read: 0x9f0009  -->  0xf00000
[617165.257759] hda_codec:snd_hda_codec_read: 0xaf0009  -->  0xf00000
[617165.257836] hda_codec:snd_hda_codec_read: 0xbf0009  -->  0xf00000
[617165.257903] hda_codec:snd_hda_codec_read: 0xcf0009  -->  0xf00000
[617165.257980] hda_codec:snd_hda_codec_read: 0xdf0009  -->  0xf00000
[617165.258047] hda_codec:snd_hda_codec_read: 0xef0009  -->  0x20010a
[617165.258112] hda_codec:snd_hda_codec_read: 0xef000e  -->       0x1
[617165.258188] hda_codec:snd_hda_codec_read: 0xef0200  -->       0x2
[617165.258255] hda_codec:snd_hda_codec_read: 0xef000d  -->  0x80000000
[617165.258320] hda_codec:snd_hda_codec_read: 0xeb0000  -->       0x0
[617165.258397] hda_codec:snd_hda_codec_read: 0xff0009  -->  0x20010b
[617165.258464] hda_codec:snd_hda_codec_read: 0xff000e  -->       0x2
[617165.258528] hda_codec:snd_hda_codec_read: 0xff0200  -->    0x1d02
[617165.258605] hda_codec:snd_hda_codec_read: 0xff000d  -->  0x80000000
[617165.258672] hda_codec:snd_hda_codec_read: 0xfb2000  -->       0x0
[617165.258756] hda_codec:snd_hda_codec_read: 0xfb0000  -->       0x0
[617165.259833] hda_codec:snd_hda_codec_read: 0xfb2001  -->      0x80
[617165.259833] hda_codec:snd_hda_codec_read: 0xfb0001  -->      0x80
[617165.259833] hda_codec:snd_hda_codec_read: 0x10f0009  -->  0x20010b
[617165.259833] hda_codec:snd_hda_codec_read: 0x10f000e  -->       0x3
[617165.259833] hda_codec:snd_hda_codec_read: 0x10f0200  -->   0x21d03
[617165.259833] hda_codec:snd_hda_codec_read: 0x10f000d  -->  0x80000000
[617165.259833] hda_codec:snd_hda_codec_read: 0x10b2000  -->       0x0
[617165.259833] hda_codec:snd_hda_codec_read: 0x10b0000  -->       0x0
[617165.259833] hda_codec:snd_hda_codec_read: 0x10b2001  -->      0x80
[617165.259833] hda_codec:snd_hda_codec_read: 0x10b0001  -->      0x80
[617165.259833] hda_codec:snd_hda_codec_read: 0x10b2002  -->      0x80
[617165.259833] hda_codec:snd_hda_codec_read: 0x10b0002  -->      0x80
[617165.259833] hda_codec:snd_hda_codec_read: 0x11f0009  -->  0xf00000
[617165.259833] hda_codec:snd_hda_codec_read: 0x12f0009  -->  0x400001
[617165.259868] hda_codec:snd_hda_codec_read: 0x12f000c  -->      0x20
[617165.259945] hda_codec:snd_hda_codec_read: 0x12f1c00  -->  0x411111f0
[617165.260012] hda_codec:snd_hda_codec_read: 0x12f0700  -->      0x20
[617165.260089] hda_codec:snd_hda_codec_read: 0x13f0009  -->  0x400001
[617165.260155] hda_codec:snd_hda_codec_read: 0x13f000c  -->      0x20
[617165.260220] hda_codec:snd_hda_codec_read: 0x13f1c00  -->  0x411111f0
[617165.260298] hda_codec:snd_hda_codec_read: 0x13f0700  -->      0x20
[617165.260364] hda_codec:snd_hda_codec_read: 0x14f0009  -->  0x40018d
[617165.260449] hda_codec:snd_hda_codec_read: 0x14f000e  -->       0x1
[617165.260526] hda_codec:snd_hda_codec_read: 0x14f0200  -->       0xf
[617165.260590] hda_codec:snd_hda_codec_read: 0x14f0012  -->  0x80000000
[617165.260657] hda_codec:snd_hda_codec_read: 0x14ba000  -->       0x0
[617165.260734] hda_codec:snd_hda_codec_read: 0x14b8000  -->       0x0
[617165.260798] hda_codec:snd_hda_codec_read: 0x14f000c  -->   0x1003c
[617165.260865] hda_codec:snd_hda_codec_read: 0x14f0c00  -->       0x2
[617165.260949] hda_codec:snd_hda_codec_read: 0x14f1c00  -->  0x2211020
[617165.261027] hda_codec:snd_hda_codec_read: 0x14f0700  -->      0xc0
[617165.261094] hda_codec:snd_hda_codec_read: 0x14f0800  -->      0x84
[617165.261179] hda_codec:snd_hda_codec_read: 0x15f0009  -->  0x40018d
[617165.261256] hda_codec:snd_hda_codec_read: 0x15f000e  -->       0x1
[617165.261322] hda_codec:snd_hda_codec_read: 0x15f0200  -->      0x10
[617165.261399] hda_codec:snd_hda_codec_read: 0x15f0012  -->  0x80000000
[617165.261464] hda_codec:snd_hda_codec_read: 0x15ba000  -->      0x80
[617165.261530] hda_codec:snd_hda_codec_read: 0x15b8000  -->      0x80
[617165.261615] hda_codec:snd_hda_codec_read: 0x15f000c  -->   0x1003c
[617165.261692] hda_codec:snd_hda_codec_read: 0x15f0c00  -->       0x2
[617165.261756] hda_codec:snd_hda_codec_read: 0x15f1c00  -->  0x99130110
[617165.261845] hda_codec:snd_hda_codec_read: 0x15f0700  -->      0x40
[617165.261921] hda_codec:snd_hda_codec_read: 0x15f0800  -->       0x0
[617165.262004] hda_codec:snd_hda_codec_read: 0x16f0009  -->  0x40010c
[617165.262071] hda_codec:snd_hda_codec_read: 0x16f000e  -->       0x1
[617165.262156] hda_codec:snd_hda_codec_read: 0x16f0200  -->       0xe
[617165.262232] hda_codec:snd_hda_codec_read: 0x16f0012  -->  0x80000000
[617165.262299] hda_codec:snd_hda_codec_read: 0x16b8000  -->      0x80
[617165.262386] hda_codec:snd_hda_codec_read: 0x16f000c  -->      0x10
[617165.262462] hda_codec:snd_hda_codec_read: 0x16f1c00  -->  0x411111f0
[617165.262551] hda_codec:snd_hda_codec_read: 0x16f0700  -->      0x40
[617165.262628] hda_codec:snd_hda_codec_read: 0x17f0009  -->  0xf00000
[617165.262693] hda_codec:snd_hda_codec_read: 0x18f0009  -->  0x40018f
[617165.262780] hda_codec:snd_hda_codec_read: 0x18f000e  -->       0x1
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f0200  -->       0x2
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f000d  -->  0x4f0200
[617165.263834] hda_codec:snd_hda_codec_read: 0x18b2000  -->       0x0
[617165.263834] hda_codec:snd_hda_codec_read: 0x18b0000  -->       0x0
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f0012  -->  0x80000000
[617165.263834] hda_codec:snd_hda_codec_read: 0x18ba000  -->      0x80
[617165.263834] hda_codec:snd_hda_codec_read: 0x18b8000  -->      0x80
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f000c  -->    0x3734
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f1c00  -->  0x2a19840
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f0700  -->      0x22
[617165.263834] hda_codec:snd_hda_codec_read: 0x18f0800  -->       0x0
[617165.263834] hda_codec:snd_hda_codec_read: 0x19f0009  -->  0x40008b
[617165.263834] hda_codec:snd_hda_codec_read: 0x19f000d  -->  0x4f0200
[617165.263838] hda_codec:snd_hda_codec_read: 0x19b2000  -->       0x0
[617165.263904] hda_codec:snd_hda_codec_read: 0x19b0000  -->       0x0
[617165.263969] hda_codec:snd_hda_codec_read: 0x19f000c  -->    0x3724
[617165.264046] hda_codec:snd_hda_codec_read: 0x19f1c00  -->  0x99a30941
[617165.264114] hda_codec:snd_hda_codec_read: 0x19f0700  -->      0x22
[617165.264199] hda_codec:snd_hda_codec_read: 0x19f0800  -->       0x0
[617165.264276] hda_codec:snd_hda_codec_read: 0x1af0009  -->  0x40018f
[617165.264343] hda_codec:snd_hda_codec_read: 0x1af000e  -->       0x1
[617165.264429] hda_codec:snd_hda_codec_read: 0x1af0200  -->       0x2
[617165.264505] hda_codec:snd_hda_codec_read: 0x1af000d  -->  0x4f0200
[617165.264570] hda_codec:snd_hda_codec_read: 0x1ab2000  -->       0x0
[617165.264657] hda_codec:snd_hda_codec_read: 0x1ab0000  -->       0x0
[617165.264733] hda_codec:snd_hda_codec_read: 0x1af0012  -->  0x80000000
[617165.264800] hda_codec:snd_hda_codec_read: 0x1aba000  -->      0x80
[617165.264884] hda_codec:snd_hda_codec_read: 0x1ab8000  -->      0x80
[617165.264961] hda_codec:snd_hda_codec_read: 0x1af000c  -->    0x3734
[617165.265026] hda_codec:snd_hda_codec_read: 0x1af1c00  -->  0x281304e
[617165.265114] hda_codec:snd_hda_codec_read: 0x1af0700  -->      0x22
[617165.265191] hda_codec:snd_hda_codec_read: 0x1af0800  -->       0x0
[617165.265258] hda_codec:snd_hda_codec_read: 0x1bf0009  -->  0xf00000
[617165.265335] hda_codec:snd_hda_codec_read: 0x1cf0009  -->  0x400001
[617165.265400] hda_codec:snd_hda_codec_read: 0x1cf000c  -->      0x20
[617165.265467] hda_codec:snd_hda_codec_read: 0x1cf1c00  -->  0x411111f0
[617165.265545] hda_codec:snd_hda_codec_read: 0x1cf0700  -->      0x20
[617165.265610] hda_codec:snd_hda_codec_read: 0x1df0009  -->  0x400000
[617165.265697] hda_codec:snd_hda_codec_read: 0x1df000c  -->      0x20
[617165.265773] hda_codec:snd_hda_codec_read: 0x1df1c00  -->  0x4017952d
[617165.265842] hda_codec:snd_hda_codec_read: 0x1df0700  -->      0x20
[617165.265927] hda_codec:snd_hda_codec_read: 0x1ef0009  -->  0x400380
[617165.266003] hda_codec:snd_hda_codec_read: 0x1ef000e  -->       0x1
[617165.266070] hda_codec:snd_hda_codec_read: 0x1ef0200  -->       0x6
[617165.266146] hda_codec:snd_hda_codec_read: 0x1ef000c  -->      0x10
[617165.266210] hda_codec:snd_hda_codec_read: 0x1ef1c00  -->  0x2451130
[617165.266278] hda_codec:snd_hda_codec_read: 0x1ef0700  -->      0x40
[617165.266355] hda_codec:snd_hda_codec_read: 0x1ef0800  -->       0x0
[617165.266420] hda_codec:snd_hda_codec_read: 0x1ff0009  -->  0xf00000
[617165.266507] hda_codec:snd_hda_codec_read: 0x20f0009  -->  0xf00040
[617165.266584] hda_codec:snd_hda_codec_read: 0x20f0010  -->     0xa00
[617165.266651] hda_codec:snd_hda_codec_read: 0x20c0000  -->       0x3
[617165.266738] hda_codec:snd_hda_codec_read: 0x20d0000  -->       0x1
[617165.266815] hda_codec:snd_hda_codec_read: 0x21f0009  -->  0xf00000
[617165.267835] hda_codec:snd_hda_codec_read: 0x22f0009  -->  0xf00000
[617165.267835] hda_codec:snd_hda_codec_read: 0x23f0009  -->  0x30010d
[617165.267835] hda_codec:snd_hda_codec_read: 0x23f000e  -->       0x7
[617165.267835] hda_codec:snd_hda_codec_read: 0x23f0200  -->  0x1c1a1918
[617165.267835] hda_codec:snd_hda_codec_read: 0x23f0204  -->  0x121514
[617165.267835] hda_codec:snd_hda_codec_read: 0x23f0012  -->  0x80051f0b
[617165.267835] hda_codec:snd_hda_codec_read: 0x23ba000  -->      0x80
[617165.267835] hda_codec:snd_hda_codec_read: 0x23b8000  -->       0x6
[617165.267835] hda_codec:snd_hda_codec_read: 0x23f0100  -->       0x0
[617165.267835] hda_codec:snd_hda_codec_read: 0x24f0009  -->  0x30010d
[617165.267835] hda_codec:snd_hda_codec_read: 0x24f000e  -->       0x7
[617165.267835] hda_codec:snd_hda_codec_read: 0x24f0200  -->  0x1c1a1918
[617165.267835] hda_codec:snd_hda_codec_read: 0x24f0204  -->  0x131514
[617165.267870] hda_codec:snd_hda_codec_read: 0x24f0012  -->  0x80051f0b
[617165.267947] hda_codec:snd_hda_codec_read: 0x24ba000  -->       0x0
[617165.268012] hda_codec:snd_hda_codec_read: 0x24b8000  -->       0x0
[617165.268098] hda_codec:snd_hda_codec_read: 0x24f0100  -->       0x0

--------------020009000905070000040802
Content-Type: text/x-patch;
 name="patch_realtek.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="patch_realtek.diff"

--- actual/patch_realtek.c	2009-05-06 08:06:04.000000000 +0100
+++ new/patch_realtek.c	2009-08-18 21:58:26.000000000 +0100
@@ -11443,7 +11443,8 @@
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
 	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
 	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 	{ }
@@ -11634,8 +11635,8 @@
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0},
 	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
-	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},
-	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
 	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20},
 	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20},
 	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20},
@@ -11669,8 +11670,8 @@
 	{0x02, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
=20
-	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},
-	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
 	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20},
 	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20},
 	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20},

--------------020009000905070000040802
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lspci.txt"

MDA6MWIuMCBBdWRpbyBkZXZpY2UgWzA0MDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUgg
KElDSDggRmFtaWx5KSBIRCBBdWRpbyBDb250cm9sbGVyIFs4MDg2OjI4NGJdIChyZXYgMDMp
CglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMTFl
XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBW
R0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0
YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6
IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxMQoJUmVnaW9uIDA6IE1lbW9y
eSBhdCA5YjMwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdCglD
YXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCQlGbGFnczog
UE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD01NW1BIFBNRShEMCssRDEtLEQyLSxE
M2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9
MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs2MF0gTVNJOiBNYXNrLSA2NGJpdCsgQ291bnQ9MS8x
IEVuYWJsZS0KCQlBZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBh
YmlsaXRpZXM6IFs3MF0gRXhwcmVzcyAodjEpIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVu
ZHBvaW50LCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1
bmMgMCwgTGF0ZW5jeSBMMHMgPDY0bnMsIEwxIDwxdXMKCQkJRXh0VGFnLSBSQkUtIEZMUmVz
ZXQtCgkJRGV2Q3RsOglSZXBvcnQgZXJyb3JzOiBDb3JyZWN0YWJsZS0gTm9uLUZhdGFsLSBG
YXRhbC0gVW5zdXBwb3J0ZWQtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQ
d3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBi
eXRlcwoJCURldlN0YToJQ29yckVyci0gVW5jb3JyRXJyLSBGYXRhbEVyci0gVW5zdXBwUmVx
LSBBdXhQd3IrIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIHVua25vd24s
IFdpZHRoIHgwLCBBU1BNIHVua25vd24sIExhdGVuY3kgTDAgPDY0bnMsIEwxIDwxdXMKCQkJ
Q2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0KCQlMbmtDdGw6CUFTUE0gRGlz
YWJsZWQ7IERpc2FibGVkLSBSZXRyYWluLSBDb21tQ2xrLQoJCQlFeHRTeW5jaC0gQ2xvY2tQ
TS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCB1bmtub3du
LCBXaWR0aCB4MCwgVHJFcnItIFRyYWluLSBTbG90Q2xrLSBETEFjdGl2ZS0gQldNZ210LSBB
QldNZ210LQoJQ2FwYWJpbGl0aWVzOiBbMTAwXSBWaXJ0dWFsIENoYW5uZWwgPD8+CglDYXBh
YmlsaXRpZXM6IFsxMzBdIFJvb3QgQ29tcGxleCBMaW5rIDw/PgoJS2VybmVsIGRyaXZlciBp
biB1c2U6IEhEQSBJbnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZC1oZGEtaW50ZWw=
--------------020009000905070000040802--

--------------enig34FEC857E3E1F8D0268C7469
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkqLNuUACgkQddEagFdIMIRzzQCWOle1H9GH7X5kPORyCdoun+4R
WgCcCOpRrmBRZpFjZcLKQJmMYbz0i5Q=
=I2KW
-----END PGP SIGNATURE-----

--------------enig34FEC857E3E1F8D0268C7469--

--===============8854995804066721183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8854995804066721183==--
