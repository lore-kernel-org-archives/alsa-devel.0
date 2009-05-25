From: Stephan =?iso-8859-1?q?J=E4necke?= <stejae@arcor.de>
Subject: Re: Alsamixer isn't working properly with HDA VIA
	VT82xx with Realtek ALC888 Codec
Date: Mon, 25 May 2009 16:43:53 +0200
Message-ID: <200905251643.53184.stejae@arcor.de>
References: <200901301910.54906.stejae@arcor.de>
	<200904261307.58085.stejae@arcor.de> <s5hocuih151.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p6qGKTJZFKCldJz"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48]) by alsa0.perex.cz (Postfix) with ESMTP id 298F624428
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 16:44:02 +0200 (CEST)
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net
	[151.189.8.36]) by mx.arcor.de (Postfix) with ESMTP id B7FB32AEB82
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 16:44:01 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id CA04C6C34E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 16:44:01 +0200 (CEST)
Received: from amd32os110.localnet (p57B76ADE.dip.t-dialin.net
	[87.183.106.222]) (Authenticated sender: stejae@arcor.de)
	by mail-in-12.arcor-online.net (Postfix) with ESMTPSA id 2C5F01B38E3
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 16:44:01 +0200 (CEST)
In-Reply-To: <s5hocuih151.wl%tiwai@suse.de>
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

--Boundary-00=_p6qGKTJZFKCldJz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

After a long time the drivers shipped with Ubuntu 9.04 worked, it suddenly 
died today and pulseaudio just outputed the sound to the null device. So I 
compiled the driver-snapshot again, Takashi gave me, and now it magically 
works including alsamixer.

But there are two problems left:
1. Every time I use alsa tools, I get a warning at the beginning: WARNING: All 
config files need .conf: /etc/modprobe.d/alsa-base, it will be ignored in a 
future release.

2.saa7134-alsa isn't loadable anymore. According to dmesg the driver wasn't 
updated with the driver snapshot. Is it included in the current one?

PS: alsa-info.txt and dmesg-output are attached.

Greetings,
Steve
-- 
Powered by openSUSE 11.0 and KMail 1.11

--Boundary-00=_p6qGKTJZFKCldJz
Content-Type: text/plain;
  charset="UTF-8";
  name="alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Mon May 25 14:15:34 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu 9.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 9.04"


!!Kernel Information
!!------------------

Kernel release:    2.6.28-11-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.18
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


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

 0 [VT82xx         ]: HDA-Intel - HDA VIA VT82xx
                      HDA VIA VT82xx at 0xfebfc000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

03:06.0 Multimedia controller: Philips Semiconductors SAA7131/SAA7133/SAA7135 Video Broadcast Decoder (rev d0)
80:01.0 Audio device: VIA Technologies, Inc. VT1708/A [Azalia HDAC] (VIA High Definition Audio Controller) (rev 10)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

80:01.0 0403: 1106:3288 (rev 10)
	Subsystem: 1849:0888


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: model=auto
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
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : auto,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC888
Address: 0
Function Id: 0x1
Vendor Id: 0x10ec0888
Subsystem Id: 0x18491e01
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=0
Invalid AFG subtree
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 May 25 15:58 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  4 May 25 15:58 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 24 May 25 15:59 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 May 25 15:59 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 17 May 25 15:58 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116, 26 May 25 15:58 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116,  1 May 25 15:58 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 May 25 15:58 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 1: ALC888 Digital [ALC888 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 2: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [VT82xx]

Card hw:0 'VT82xx'/'HDA VIA VT82xx at 0xfebfc000 irq 17'
  Mixer name	: 'Realtek ALC888'
  Components	: 'HDA:10ec0888,18491e01,00100001'
  Controls      : 33
  Simple ctrls  : 18
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [-9.00dB] [on]
  Front Right: Playback 25 [81%] [-9.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [-9.00dB] [on]
  Front Right: Playback 25 [81%] [-9.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 27 [87%] [-6.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 27 [87%] [-6.00dB] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 24 [77%] [-10.50dB] [on]
  Front Right: Playback 24 [77%] [-10.50dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [3.00dB] [on]
  Front Right: Playback 25 [81%] [3.00dB] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [3.00dB] [on]
  Front Right: Playback 25 [81%] [3.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
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
  Limits: Capture 0 - 31
  Front Left: Capture 31 [100%] [30.00dB] [on]
  Front Right: Capture 31 [100%] [30.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 0 [0%] [-16.50dB] [on]
  Front Right: Capture 0 [0%] [-16.50dB] [on]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 15 [48%] [-12.00dB] [on]
  Front Right: Playback 15 [48%] [-12.00dB] [on]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Line' 'CD'
  Item0: 'CD'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Line' 'CD'
  Item0: 'CD'


!!Alsactl output
!!-------------

--startcollapse--
state.VT82xx {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 25
		value.1 25
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 25
		value.1 25
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 27
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 27
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Side Playback Volume'
		value.0 24
		value.1 24
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 true
		value.1 true
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 25
		value.1 25
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 true
		value.1 true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'CD Playback Volume'
		value.0 25
		value.1 25
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Boost'
		value.0 0
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 31
		value.1 31
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 Line
		comment.item.2 CD
		iface MIXER
		name 'Input Source'
		value CD
	}
	control.23 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 Line
		comment.item.2 CD
		iface MIXER
		name 'Input Source'
		index 1
		value CD
	}
	control.24 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.25 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.26 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Beep Playback Volume'
		value.0 15
		value.1 15
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Beep Playback Switch'
		value.0 true
		value.1 true
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 31
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.33 {
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
isofs
udf
crc_itu_t
binfmt_misc
bridge
stp
bnep
video
output
input_polldev
nfsd
auth_rpcgss
exportfs
nfs
lockd
nfs_acl
sunrpc
w83627hf
hwmon_vid
lp
ir_kbd_i2c
tda827x
snd_hda_codec_realtek
tda8290
snd_hda_intel
snd_hda_codec
tuner
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
snd_seq_oss
snd_seq_midi
snd_rawmidi
saa7134
snd_seq_midi_event
ir_common
videodev
v4l1_compat
snd_seq
compat_ioctl32
snd_timer
snd_seq_device
v4l2_common
videobuf_dma_sg
snd
videobuf_core
psmouse
nvidia
soundcore
via_agp
ppdev
tveeprom
serio_raw
shpchp
i2c_viapro
snd_page_alloc
agpgart
pcspkr
parport_pc
parport
via_rhine
mii
floppy
fbcon
tileblit
font
bitblit
softcursor


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x14 0x01014010
0x15 0x01011012
0x16 0x01016011
0x17 0x01012014
0x18 0x01a19830
0x19 0x411111f0
0x1a 0x01813031
0x1b 0x411111f0
0x1c 0x9933013f
0x1d 0x411111f0
0x1e 0xc144e120
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:



--Boundary-00=_p6qGKTJZFKCldJz
Content-Type: text/plain;
  charset="UTF-8";
  name="dmesg_saa714-alsa"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_saa714-alsa"

[  725.753112] saa7134_alsa: disagrees about version of symbol snd_ctl_add
[  725.753119] saa7134_alsa: Unknown symbol snd_ctl_add
[  725.753247] saa7134_alsa: disagrees about version of symbol snd_pcm_new
[  725.753250] saa7134_alsa: Unknown symbol snd_pcm_new
[  725.753487] saa7134_alsa: disagrees about version of symbol snd_card_register
[  725.753489] saa7134_alsa: Unknown symbol snd_card_register
[  725.753726] saa7134_alsa: disagrees about version of symbol snd_card_free
[  725.753729] saa7134_alsa: Unknown symbol snd_card_free
[  725.753953] saa7134_alsa: disagrees about version of symbol snd_pcm_stop
[  725.753956] saa7134_alsa: Unknown symbol snd_pcm_stop
[  725.754213] saa7134_alsa: disagrees about version of symbol snd_ctl_new1
[  725.754216] saa7134_alsa: Unknown symbol snd_ctl_new1
[  725.754836] saa7134_alsa: Unknown symbol snd_card_new
[  725.754950] saa7134_alsa: disagrees about version of symbol snd_pcm_lib_ioctl
[  725.754952] saa7134_alsa: Unknown symbol snd_pcm_lib_ioctl
[  725.755301] saa7134_alsa: disagrees about version of symbol snd_pcm_set_ops
[  725.755303] saa7134_alsa: Unknown symbol snd_pcm_set_ops
[  725.755667] saa7134_alsa: disagrees about version of symbol snd_pcm_hw_constraint_integer
[  725.755670] saa7134_alsa: Unknown symbol snd_pcm_hw_constraint_integer
[  725.756183] saa7134_alsa: disagrees about version of symbol snd_pcm_period_elapsed
[  725.756185] saa7134_alsa: Unknown symbol snd_pcm_period_elapsed
[  725.756299] saa7134_alsa: disagrees about version of symbol snd_pcm_hw_constraint_step
[  725.756302] saa7134_alsa: Unknown symbol snd_pcm_hw_constraint_step


--Boundary-00=_p6qGKTJZFKCldJz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_p6qGKTJZFKCldJz--
