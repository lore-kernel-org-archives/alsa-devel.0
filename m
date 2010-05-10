From: Tim Starling <tstarling@wikimedia.org>
Subject: Re: [PATCH] ALSA: hda: Fix 0 dB for Packard Bell
 models using Conexant CX20549 (Venice)
Date: Mon, 10 May 2010 22:48:17 +1000
Message-ID: <hs8vah$9un$1@dough.gmane.org>
References: <x2n604760771004281507x5464161frd1f09b6cd4c8a7fc@mail.gmail.com>	<s5hiq72vkt7.wl%tiwai@suse.de>
	<hs8bra$53h$1@dough.gmane.org>
	<AANLkTinJUJ5t2YB85ba8AjZrJnNwNXvW8Kr4NHeFcBlJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030009020009060602060405"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 499D524752
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 14:48:30 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OBSPM-00041n-Ca
	for alsa-devel@alsa-project.org; Mon, 10 May 2010 14:48:28 +0200
Received: from vps2.angtim.com ([74.207.253.152])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 14:48:28 +0200
Received: from tstarling by vps2.angtim.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 14:48:28 +0200
In-Reply-To: <AANLkTinJUJ5t2YB85ba8AjZrJnNwNXvW8Kr4NHeFcBlJ@mail.gmail.com>
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
--------------030009020009060602060405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 10/05/10 20:29, Daniel Chen wrote:
> On Mon, May 10, 2010 at 9:15 AM, Tim Starling <tstarling@wikimedia.org> wrote:
>> Can you please also add vendor ID 0x17aa (Lenovo)? I have the same
>> problem on my Thinkpad R61. I compiled my kernel with a 0x17aa case
>> added where Daniel's patch indicates and tested it with dbverify, it
>> seems to fix the problem.
> 
> Please attach your alsa-info.sh output.

Attached as requested. Generated with patched kernel running.

-- Tim Starling

--------------030009020009060602060405
Content-Type: text/plain;
 name="alsa-info.txt.zDLiJnUHZf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-info.txt.zDLiJnUHZf"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon May 10 12:43:35 UTC 2010


!!Linux Distribution
!!------------------

Ubuntu 10.04 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 10.04 LTS"


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      8932A52


!!Kernel Information
!!------------------

Kernel release:    2.6.32-22-generic-pae
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.22
Utilities version:  1.0.22


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
thinkpad_acpi


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfe100000 irq 17
29 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
                      ThinkPad Console Audio Control at EC reg 0x30, fw 7KHT24WW-1.08


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 17aa:20ac


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-us122l: index=-2
snd-usb-usx2y: index=-2
snd-usb-caiaq: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388
snd-pcsp: index=-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : 0
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	patch : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	single_cmd : N

!!Module: thinkpad_acpi
	brightness_enable : 2
	brightness_mode : 4
	dbg_bluetoothemul : 0
	dbg_uwbemul : 0
	dbg_wlswemul : 0
	dbg_wwanemul : 0
	enable : Y
	experimental : 0
	fan_control : N
	force_load : N
	hotkey_report_mode : 0
	id : ThinkPadEC
	index : -536870912
	volume_capabilities : 0
	volume_control : N
	volume_mode : 3


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Conexant CX20549 (Venice)
Address: 0
Function Id: 0x2
Vendor Id: 0x14f15045
Subsystem Id: 0x17aa20db
Revision Id: 0x100100
Modem Function Group: 0x2
Default PCM:
    rates [0x140]: 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xab 0xab] [0x00 0x00]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x95170110: [Fixed] Speaker at Int Top
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x19 0x17*
Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x2b 0x2b] [0x00 0x00]
  Pincap 0x0000113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x0321401f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=37, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x19 0x17*
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xab 0xab] [0x00 0x00]
  Pincap 0x0000113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x21a1902e: [Jack] Mic at Sep Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=38, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x2144f1f0: [Jack] SPDIF Out at Sep Rear
    Conn = RCA, Color = Other
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001124: IN Detect
    Vref caps: HIZ 80
  Pin Default 0x03a15021: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Red
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x95a70120: [Fixed] Mic at Int Top
    Conn = Analog, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x14 0x14] [0x94 0x94] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Power: setting=D0, actual=D0
  Connection: 5
     0x19 0x14 0x12 0x11 0x15
Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x40]: 48000
    bits [0x6]: 16 20
    formats [0x5]: PCM AC3
Node 0x19 [Audio Output] wcaps 0xc11: Stereo R/L
  Converter: stream=0, channel=0
  PCM:
    rates [0x540]: 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In R/L
  Amp-In caps: ofs=0x00, nsteps=0x17, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Connection: 5
     0x17 0x14* 0x12 0x11 0x15
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 9 May 10 16:57 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 3 May 10 16:57 /dev/snd/controlC29
crw-rw----+ 1 root audio 116, 8 May 10 16:57 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 7 May 10 17:01 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 6 May 10 22:41 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 5 May 10 16:58 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116, 4 May 10 16:57 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 May 10 16:57 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 May 10 16:57 .
drwxr-xr-x 3 root root 220 May 10 16:57 ..
lrwxrwxrwx 1 root root  12 May 10 16:57 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  13 May 10 16:57 platform-thinkpad_acpi -> ../controlC29


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: Conexant Digital [Conexant Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfe100000 irq 17'
  Mixer name	: 'Conexant CX20549 (Venice)'
  Components	: 'HDA:14f15045,17aa20db,00100100'
  Controls      : 19
  Simple ctrls  : 9
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43
  Mono:
  Front Left: Playback 43 [100%] [0.00dB] [on]
  Front Right: Playback 43 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 20
  Mono:
  Front Left: Playback 20 [100%] [0.00dB] [on]
  Front Right: Playback 20 [100%] [0.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 0 [0%] [-30.00dB]
  Front Right: Capture 0 [0%] [-30.00dB]
Simple mixer control 'Ext Mic',0
  Capabilities: pvolume cvolume pswitch cswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [off]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'ExtMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Int Mic',0
  Capabilities: pvolume cvolume pswitch cswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 20 [100%] [0.00dB] [off] Capture 0 [0%] [0.00dB] [off]
  Front Right: Playback 20 [100%] [0.00dB] [off] Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'IntMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]

!!-------Mixer controls for card 29 [ThinkPadEC]

Card hw:29 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 0x30, fw 7KHT24WW-1.08'
  Mixer name	: 'ThinkPad EC 7KHT24WW-1.08'
  Components	: ''
  Controls      : 1
  Simple ctrls  : 1
Simple mixer control 'Console',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin 0
		comment.dbmax 3450
		iface MIXER
		name 'Int Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Capture Switch'
		value.0 false
		value.1 false
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin 0
		comment.dbmax 3450
		iface MIXER
		name 'Ext Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Capture Switch'
		value.0 false
		value.1 false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin -3000
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 20
		value.1 20
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin -3000
		comment.dbmax 0
		iface MIXER
		name 'Int Mic Playback Volume'
		value.0 20
		value.1 20
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin -3000
		comment.dbmax 0
		iface MIXER
		name 'Ext Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43'
		comment.dbmin -6450
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 43
		value.1 43
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
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
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 IntMic
		comment.item.1 ExtMic
		iface MIXER
		name 'Capture Source'
		value IntMic
	}
	control.19 {
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
state.ThinkPadEC {
	control.1 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Console Playback Switch'
		value true
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
aes_i586
aes_generic
binfmt_misc
ppdev
hdaps
input_polldev
kvm_intel
kvm
nls_iso8859_1
nls_cp437
vfat
fat
snd_hda_codec_conexant
vga16fb
snd_hda_intel
vgastate
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
arc4
snd_seq_dummy
snd_seq_oss
snd_seq_midi
uinput
pcmcia
snd_rawmidi
iwlagn
i915
joydev
snd_seq_midi_event
drm_kms_helper
iwlcore
yenta_socket
mac80211
snd_seq
sbp2
sdhci_pci
drm
thinkpad_acpi
sdhci
intel_agp
psmouse
rsrc_nonstatic
i2c_algo_bit
snd_timer
ricoh_mmc
cfg80211
led_class
agpgart
pcmcia_core
video
snd_seq_device
serio_raw
nvram
output
snd
soundcore
snd_page_alloc
uvcvideo
videodev
v4l1_compat
lp
parport
reiserfs
usbhid
hid
dm_raid45
xor
fbcon
tileblit
font
bitblit
ohci1394
softcursor
ieee1394
tg3
ahci


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x10 0x95170110
0x11 0x0321401f
0x12 0x21a1902e
0x13 0x2144f1f0
0x14 0x03a15021
0x15 0x95a70120

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   31.086805] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   31.469601] HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   31.469605] hda_intel: probe_mask set to 0x1 for device 17aa:20ac
[   31.469632] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   31.566417] vga16fb: initializing



--------------030009020009060602060405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030009020009060602060405--
