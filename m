From: Marek Lotke <lollul@wp.pl>
Subject: hda-codec conexant - no external mic on FSC V5505
	(with patch)
Date: Wed, 9 Jul 2008 18:22:40 +0200
Message-ID: <200807091822.40851.lollul@wp.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QXOdI5E0xyR135e"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 145D12437F
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 18:22:42 +0200 (CEST)
Received: from 243.18-240-81.adsl-dyn.isp.belgacom.be (HELO r2d2.localnet)
	(lollul@[81.240.18.243]) (envelope-sender <lollul@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <alsa-devel@alsa-project.org>; 9 Jul 2008 18:22:38 +0200
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

--Boundary-00=_QXOdI5E0xyR135e
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I've tried all conextant models for my new laptop... External mic would work 
only with benq but then the external headphones don't work.

I managed to get the external mic working with this little patch:
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -686,7 +686,7 @@ static struct snd_kcontrol_new cxt5045_mixers_hp530[] = {

 static struct hda_verb cxt5045_init_verbs[] = {
        /* Line in, Mic */
-       {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+       {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
        {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
        /* HP, Amp  */
        {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},

Now I can switch between the mics with mixer. Still no mic auto sensing though 
but maybe there is none in hardware.
Attached are the outputs of alsa-info.sh: default, with model benq and with 
default model with my patch with mixer set to external.

I'll be glad to provide any info or try any patch...

Thanks,
Marek


--Boundary-00=_QXOdI5E0xyR135e
Content-Type: text/plain;
  charset="iso-8859-2";
  name="alsa-info_default.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info_default.txt"

name=root&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.44
!!################################

!!Script ran on: Sat Jul  5 21:51:49 CEST 2008


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.0


!!Kernel Information
!!------------------

Kernel release:    2.6.26-rc8-zen1-dirty
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM)2 Duo CPU T5450 @ 1.66GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.17rc3
Library version:    1.0.16
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfc400000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1734:110e


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Conexant CX20549 (Venice)
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x1734110e
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
  Amp-Out vals:  [0x28 0x28]
  Pincap 0x0810014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x92170110: [Fixed] Speaker at Int Front
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
  Amp-Out vals:  [0x28 0x28]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x0121401f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=37, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x19 0x17*
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x214571f0: [Jack] SPDIF Out at Sep Rear
    Conn = Optical, Color = Yellow
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
    Vref caps: HIZ 80
  Pin Default 0x97a7012e: [Fixed] Mic at Int Riser
    Conn = Analog, Color = Unknown
    DefAssociation = 0x2, Sequence = 0xe
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x0c 0x0c] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
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

crw-rw---- 1 root audio 116,  0 Jul  5 21:46 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Jul  5 21:46 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 24 Jul  5 21:51 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Jul  5 21:46 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 Jul  5 21:46 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Jul  5 21:46 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jul  5 21:46 /dev/snd/timer


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

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43
  Mono:
  Front Left: Playback 40 [93%] [-4.50dB] [on]
  Front Right: Playback 40 [93%] [-4.50dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 20
  Mono:
  Front Left: Playback 12 [60%] [-12.00dB] [on]
  Front Right: Playback 12 [60%] [-12.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 80 [67%] [10.00dB]
  Front Right: Capture 80 [67%] [10.00dB]
Simple mixer control 'Ext Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [on]
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
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
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
		value.0 17
		value.1 17
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
		value.0 0
		value.1 0
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
		value.0 12
		value.1 12
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
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Playback Switch'
		value.0 false
		value.1 false
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
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Playback Switch'
		value.0 false
		value.1 false
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
		value.0 40
		value.1 40
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
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
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
		value.0 80
		value.1 80
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_seq
snd_seq_device
snd_hda_intel
snd_pcm
snd_timer
snd_page_alloc
snd_hwdep
snd
ipv6
iwl3945
i915
soundcore
bridge
llc
vfat
fat
sg
hci_usb
bluetooth
usb_storage
r8169
compat_ioctl32
videodev
v4l1_compat
arc4
ecb
crypto_blkcipher
cryptomgr
firmware_class
mac80211
led_class
cfg80211
evdev
uhci_hcd
ehci_hcd
usbcore
sr_mod
cdrom
sdhci
mmc_core
psmouse
intel_agp
acpi_cpufreq



--Boundary-00=_QXOdI5E0xyR135e
Content-Type: text/plain;
  charset="iso-8859-2";
  name="alsa-info_benq.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info_benq.txt"

name=root&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.44
!!################################

!!Script ran on: Sat Jul  5 21:57:28 CEST 2008


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.0


!!Kernel Information
!!------------------

Kernel release:    2.6.26-rc8-zen1-dirty
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM)2 Duo CPU T5450 @ 1.66GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.17rc3
Library version:    1.0.16
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfc400000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1734:110e


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: model=benq


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : benq,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Conexant CX20549 (Venice)
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x1734110e
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
  Amp-Out vals:  [0x28 0x28]
  Pincap 0x0810014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x92170110: [Fixed] Speaker at Int Front
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
  Amp-Out vals:  [0x28 0x28]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x0121401f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x19 0x17*
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x214571f0: [Jack] SPDIF Out at Sep Rear
    Conn = Optical, Color = Yellow
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
    Vref caps: HIZ 80
  Pin Default 0x97a7012e: [Fixed] Mic at Int Riser
    Conn = Analog, Color = Unknown
    DefAssociation = 0x2, Sequence = 0xe
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x0c 0x0c] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
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
     0x17 0x14 0x12* 0x11 0x15
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Jul  5 21:53 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Jul  5 21:53 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 24 Jul  5 21:56 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Jul  5 21:53 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 Jul  5 21:53 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Jul  5 21:53 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jul  5 21:53 /dev/snd/timer


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

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43
  Mono:
  Front Left: Playback 40 [93%] [-4.50dB] [on]
  Front Right: Playback 40 [93%] [-4.50dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 20
  Mono:
  Front Left: Playback 12 [60%] [-12.00dB] [on]
  Front Right: Playback 12 [60%] [-12.00dB] [on]
Simple mixer control 'Line In',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'LineIn',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 80 [67%] [10.00dB]
  Front Right: Capture 80 [67%] [10.00dB]
Simple mixer control 'Ext Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'ExtMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Int Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
Simple mixer control 'IntMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]


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
		comment.item.2 LineIn
		iface MIXER
		name 'Capture Source'
		value ExtMic
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
		value.0 17
		value.1 17
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
		value.0 0
		value.1 0
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
		value.0 12
		value.1 12
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
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Playback Switch'
		value.0 false
		value.1 false
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
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Playback Switch'
		value.0 false
		value.1 false
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
		value.0 40
		value.1 40
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
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin 0
		comment.dbmax 3450
		iface MIXER
		name 'Line In Capture Volume'
		value.0 0
		value.1 0
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line In Capture Switch'
		value.0 true
		value.1 true
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin -3000
		comment.dbmax 0
		iface MIXER
		name 'Line In Playback Volume'
		value.0 0
		value.1 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line In Playback Switch'
		value.0 false
		value.1 false
	}
	control.18 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.19 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.20 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
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
		value.0 80
		value.1 80
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_seq
snd_seq_device
snd_hda_intel
snd_pcm
snd_timer
snd_page_alloc
snd_hwdep
snd
ipv6
iwl3945
i915
soundcore
bridge
llc
vfat
fat
sg
hci_usb
bluetooth
usb_storage
r8169
compat_ioctl32
videodev
v4l1_compat
arc4
ecb
crypto_blkcipher
cryptomgr
firmware_class
mac80211
led_class
cfg80211
evdev
uhci_hcd
ehci_hcd
usbcore
sr_mod
cdrom
sdhci
mmc_core
psmouse
intel_agp
acpi_cpufreq



--Boundary-00=_QXOdI5E0xyR135e
Content-Type: text/plain;
  charset="iso-8859-2";
  name="alsa-info_with_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info_with_patch.txt"

name=root&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.44
!!################################

!!Script ran on: Sat Jul  5 22:29:23 CEST 2008


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.0


!!Kernel Information
!!------------------

Kernel release:    2.6.26-rc8-zen1-dirty
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM)2 Duo CPU T5450 @ 1.66GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.17rc3
Library version:    1.0.16
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfc400000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1734:110e


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Conexant CX20549 (Venice)
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x1734110e
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
  Amp-Out vals:  [0xa8 0xa8]
  Pincap 0x0810014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x92170110: [Fixed] Speaker at Int Front
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
  Amp-Out vals:  [0x28 0x28]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x0121401f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=37, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x19 0x17*
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08113c: IN OUT HP Detect
    Vref caps: HIZ 80
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x214571f0: [Jack] SPDIF Out at Sep Rear
    Conn = Optical, Color = Yellow
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
    Vref caps: HIZ 80
  Pin Default 0x97a7012e: [Fixed] Mic at Int Riser
    Conn = Analog, Color = Unknown
    DefAssociation = 0x2, Sequence = 0xe
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
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
     0x17 0x14 0x12* 0x11 0x15
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Jul  5 22:22 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Jul  5 22:22 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 24 Jul  5 22:26 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Jul  5 22:22 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 Jul  5 22:22 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 Jul  5 22:22 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jul  5 22:22 /dev/snd/timer


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

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43
  Mono:
  Front Left: Playback 40 [93%] [-4.50dB] [on]
  Front Right: Playback 40 [93%] [-4.50dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43
  Mono:
  Front Left: Playback 23 [53%] [4.50dB] [on]
  Front Right: Playback 23 [53%] [4.50dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 96 [80%] [18.00dB]
  Front Right: Capture 96 [80%] [18.00dB]
Simple mixer control 'Ext Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
Simple mixer control 'ExtMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Int Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 17 [74%] [25.50dB] [on]
Simple mixer control 'IntMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]


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
		value ExtMic
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
		value.0 17
		value.1 17
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
		value.0 17
		value.1 17
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
		comment.range '0 - 43'
		comment.dbmin -3000
		comment.dbmax 3450
		iface MIXER
		name 'PCM Playback Volume'
		value.0 23
		value.1 23
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
		comment.range '0 - 43'
		comment.dbmin -3000
		comment.dbmax 3450
		iface MIXER
		name 'Int Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Int Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43'
		comment.dbmin -3000
		comment.dbmax 3450
		iface MIXER
		name 'Ext Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Ext Mic Playback Switch'
		value.0 false
		value.1 false
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
		value.0 40
		value.1 40
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
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
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
		value.0 96
		value.1 96
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_seq
snd_seq_device
snd_hda_intel
snd_pcm
snd_timer
snd_page_alloc
snd_hwdep
snd
ipv6
iwl3945
i915
soundcore
bridge
llc
vfat
fat
sg
hci_usb
bluetooth
usb_storage
r8169
compat_ioctl32
videodev
v4l1_compat
arc4
ecb
crypto_blkcipher
cryptomgr
firmware_class
mac80211
led_class
cfg80211
evdev
uhci_hcd
ehci_hcd
usbcore
sr_mod
cdrom
sdhci
mmc_core
psmouse
intel_agp
acpi_cpufreq



--Boundary-00=_QXOdI5E0xyR135e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_QXOdI5E0xyR135e--
