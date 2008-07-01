From: "Mark T.B. Carroll" <mtbc@ixod.org>
Subject: Re: [ALSA] hda-codec - Fix laptop models for Cxt5045
Date: Tue, 01 Jul 2008 09:19:45 -0400
Message-ID: <87y74ld9n2.fsf@ixod.org>
References: <871w2ea4ek.fsf@ixod.org>
	<Pine.LNX.4.61.0807010906240.20581@tm8103-a.perex-int.cz>
	<s5h63rqexpj.wl%tiwai@suse.de> <87y74liyd4.fsf@ixod.org>
	<s5hod5heq04.wl%tiwai@suse.de> <s5hlk0lepn4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sabji.vm.bytemark.co.uk (sabji.ixod.org [80.68.89.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 27FB52439A
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 15:19:42 +0200 (CEST)
In-Reply-To: <s5hlk0lepn4.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	01 Jul 2008 14:48:47 +0200")
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Marc Boucher <marc@linuxant.com>
List-Id: alsa-devel@alsa-project.org

--=-=-=

Takashi Iwai <tiwai@suse.de> writes:

> +	SND_PCI_QUIRK(0x1179, 0xff31, "Toshiba P105", CXT5045_LAPTOP_MICSENSE),

This patch seems to fix the problem for me! Thanks. I thought I'd
previouslyu tried model=laptop-micsense but I obviously messed that 
up somehow. FWIW I enclose the alsa-info.txt.

Mark

--=-=-=
Content-Disposition: inline; filename=alsa-info-patched.txt
Content-Description: Patched kernel with headphones plugged in

name=root&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.48
!!################################

!!Script ran on: Tue Jul  1 09:14:15 EDT 2008


!!Linux Distribution
!!------------------

Debian GNU/Linux 4.0 \n \l


!!Kernel Information
!!------------------

Kernel release:    2.6.26-rc8
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.16
Library version:    
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------



!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xd0340000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
0a:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card Reader (SD/MMC/MS/MS PRO/xD)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 1179:ff31


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-pcsp: index=-2


!!Loaded sound module options
!!--------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Conexant CX20549 (Venice)
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x1179ff31
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
  Amp-Out vals:  [0x2b 0x2b]
  Pincap 0x0810014: OUT EAPD Detect
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
  Amp-Out vals:  [0x2b 0x2b]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x4221101f: [N/A] HP Out at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x19 0x17*
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xab 0xab]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x02811020: [Jack] Line In at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=38, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x02441140: [Jack] SPDIF Out at Ext Front
    Conn = RCA, Color = Black
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
    Vref caps: HIZ 80
  Pin Default 0x02a1102e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x59330060: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x6, Sequence = 0x0
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x14 0x14] [0x14 0x14] [0x14 0x14] [0x80 0x80] [0x80 0x80]
  Power: setting=D0, actual=D0
  Connection: 5
     0x19 0x14 0x12 0x11 0x15
Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=5, channel=0
  Digital: Enabled
  Digital category: 0x1
  PCM:
    rates [0x40]: 48000
    bits [0x6]: 16 20
    formats [0x5]: PCM AC3
Node 0x19 [Audio Output] wcaps 0xc11: Stereo R/L
  Converter: stream=5, channel=0
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

crw-rw---- 1 root audio 116, 7 2008-07-01 09:12 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 6 2008-07-01 09:12 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 5 2008-07-01 09:13 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 4 2008-07-01 09:12 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 3 2008-07-01 09:12 /dev/snd/seq
crw-rw---- 1 root audio 116, 2 2008-07-01 09:12 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 0/1
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

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43
  Mono:
  Front Left: Playback 43 [100%] [0.00dB] [on]
  Front Right: Playback 43 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 20
  Mono:
  Front Left: Playback 20 [100%] [0.00dB] [on]
  Front Right: Playback 20 [100%] [0.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]
Simple mixer control 'Ext Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 20 [100%] [0.00dB] [on] Capture 23 [100%] [34.50dB] [on]
  Front Right: Playback 20 [100%] [0.00dB] [on] Capture 23 [100%] [34.50dB] [on]
Simple mixer control 'ExtMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Int Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 20 [100%] [0.00dB] [on] Capture 23 [100%] [34.50dB] [on]
  Front Right: Playback 20 [100%] [0.00dB] [on] Capture 23 [100%] [34.50dB] [on]
Simple mixer control 'IntMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 IntMic
		comment.item.1 ExtMic
		iface MIXER
		name 'Capture Source'
		value IntMic
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin 0
		comment.dbmax 3450
		iface MIXER
		name 'Int Mic Capture Volume'
		value.0 23
		value.1 23
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Capture Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin 0
		comment.dbmax 3450
		iface MIXER
		name 'Ext Mic Capture Volume'
		value.0 23
		value.1 23
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Capture Switch'
		value.0 true
		value.1 true
	}
	control.6 {
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
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
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
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Playback Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin -3000
		comment.dbmax 0
		iface MIXER
		name 'Ext Mic Playback Volume'
		value.0 20
		value.1 20
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Playback Switch'
		value.0 true
		value.1 true
	}
	control.12 {
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
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
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
		value.0 120
		value.1 120
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
iwl3945



--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
