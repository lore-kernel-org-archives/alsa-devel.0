From: Adrian Patzak <zoiss@web.de>
Subject: Auzentech X-Fi Prelude with alsa drivers
Date: Sun, 09 Aug 2009 17:29:37 +0200
Message-ID: <4A7EEB61.1070404@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050204070308040806070505"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41]) by alsa0.perex.cz (Postfix) with ESMTP id 57DBA24152
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:29:38 +0200 (CEST)
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net
	[151.189.8.15]) by mx.arcor.de (Postfix) with ESMTP id A8989332ABC
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:29:37 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 9FA0B2D34FE
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:29:37 +0200 (CEST)
Received: from [192.168.0.143] (dslb-084-056-113-202.pools.arcor-ip.net
	[84.56.113.202]) (Authenticated sender: zoiss@arcor.de)
	by mail-in-03.arcor-online.net (Postfix) with ESMTPA id 49BEB2C2D1C
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:29:37 +0200 (CEST)
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
--------------050204070308040806070505
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Dear sirs,

I've got a Auzentech X-Fi Prelude and I installed the alsa unstable 
snapshot drivers.
Stereo sound for my headphones and ditital output are working fine but 
my microphone
isn't recording anything. I was checking the mixer settings but i wasn't 
able to find something wrong.
Are the x-fi drivers just not designed to fit with the Auzentech card or 
do i have a local
configuration problem?

The output of alsa-info.sh script is attached.
Thanking you in anticipation for any answer.

--------------050204070308040806070505
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.57
!!################################

!!Script ran on: Fri Aug  7 10:48:57 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu 9.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 9.04"


!!DMI Information
!!---------------

Manufacturer:      FUJITSU SIEMENS
Product Name:      AMD690VM-FMH


!!Kernel Information
!!------------------

Kernel release:    2.6.28-14-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.18
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------

snd_ctxfi


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

 0 [XFi            ]: SB-XFi - Creative X-Fi
                      Creative X-Fi 20K1 Unknown


!!PCI Soundcards installed in the system
!!--------------------------------------

03:01.0 Multimedia audio controller: Creative Labs SB X-Fi


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

03:01.0 0401: 1102:0005
	Subsystem: 415a:0034


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

!!Module: snd_ctxfi
	enable : Y,Y,Y,Y,Y,Y,Y,Y
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1
	multiple : 2
	reference_rate : 48000
	use_system_timer : N


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 Aug  7 08:13 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 24 Aug  7 12:02 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 Aug  7 12:02 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 17 Aug  7 08:13 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116, 18 Aug  7 08:13 /dev/snd/pcmC0D2p
crw-rw----+ 1 root audio 116, 19 Aug  7 08:13 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116, 20 Aug  7 08:13 /dev/snd/pcmC0D4p
crw-rw----+ 1 root audio 116, 33 Aug  7 08:13 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

E: core-util.c: Home directory /home/adrian not ours.
**** List of PLAYBACK Hardware Devices ****
card 0: XFi [Creative X-Fi], device 0: ctxfi [Front/WaveIn]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 1: ctxfi [Surround]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 2: ctxfi [Center/LFE]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 3: ctxfi [Side]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 4: ctxfi [IEC958 Non-audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

E: core-util.c: Home directory /home/adrian not ours.
**** List of CAPTURE Hardware Devices ****
card 0: XFi [Creative X-Fi], device 0: ctxfi [Front/WaveIn]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [XFi]

Card hw:0 'XFi'/'Creative X-Fi 20K1 Unknown'
  Mixer name	: '20K1'
  Components	: ''
  Controls      : 30
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 256 Capture 0 - 256
  Front Left: Playback 256 [100%] [0.00dB] Capture 256 [100%] [0.00dB]
  Front Right: Playback 256 [100%] [0.00dB] Capture 256 [100%] [0.00dB]
Simple mixer control 'PCM',0
  Capabilities: pvolume cvolume cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 256 Capture 0 - 256
  Front Left: Playback 256 [100%] [0.00dB] Capture 256 [100%] [0.00dB] [off]
  Front Right: Playback 256 [100%] [0.00dB] Capture 256 [100%] [0.00dB] [off]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 256
  Mono:
  Front Left: Playback 256 [100%] [0.00dB] [on]
  Front Right: Playback 256 [100%] [0.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 256
  Mono:
  Front Left: Playback 256 [100%] [0.00dB] [off]
  Front Right: Playback 256 [100%] [0.00dB] [off]
Simple mixer control 'Center/LFE',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 256
  Mono:
  Front Left: Playback 256 [100%] [0.00dB] [off]
  Front Right: Playback 256 [100%] [0.00dB] [off]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 256
  Mono:
  Front Left: Playback 256 [100%] [0.00dB] [off]
  Front Right: Playback 256 [100%] [0.00dB] [off]
Simple mixer control 'Line-in',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 256 Capture 0 - 256
  Front Left: Playback 256 [100%] [0.00dB] [off] Capture 256 [100%] [0.00dB] [off]
  Front Right: Playback 256 [100%] [0.00dB] [off] Capture 256 [100%] [0.00dB] [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume cvolume cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 256 Capture 0 - 256
  Front Left: Playback 256 [100%] [0.00dB] Capture 256 [100%] [0.00dB] [on]
  Front Right: Playback 256 [100%] [0.00dB] Capture 256 [100%] [0.00dB] [on]
Simple mixer control 'Digit-IO',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'S/PDIF-in',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 256 Capture 0 - 256
  Front Left: Playback 256 [100%] [0.00dB] [off] Capture 256 [100%] [0.00dB] [off]
  Front Right: Playback 256 [100%] [0.00dB] [off] Capture 256 [100%] [0.00dB] [off]
Simple mixer control 'S/PDIF-out',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 256
  Mono:
  Front Left: Playback 256 [100%] [0.00dB] [on]
  Front Right: Playback 256 [100%] [0.00dB] [on]


!!Alsactl output
!!-------------

--startcollapse--
state.XFi {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 256
		value.1 256
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 256
		value.1 256
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Line-in Playback Volume'
		value.0 256
		value.1 256
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Mic Playback Volume'
		value.0 256
		value.1 256
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'S/PDIF-in Playback Volume'
		value.0 256
		value.1 256
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'S/PDIF-out Playback Volume'
		value.0 256
		value.1 256
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 256
		value.1 256
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 256
		value.1 256
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Center/LFE Playback Volume'
		value.0 256
		value.1 256
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Side Playback Volume'
		value.0 256
		value.1 256
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Master Capture Volume'
		value.0 256
		value.1 256
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'PCM Capture Volume'
		value.0 256
		value.1 256
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Line-in Capture Volume'
		value.0 256
		value.1 256
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Mic Capture Volume'
		value.0 256
		value.1 256
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 256'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'S/PDIF-in Capture Volume'
		value.0 256
		value.1 256
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Capture Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line-in Capture Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Capture Switch'
		value true
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'S/PDIF-in Capture Switch'
		value false
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line-in Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'S/PDIF-out Playback Switch'
		value true
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'S/PDIF-in Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Front Playback Switch'
		value true
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Surround Playback Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center/LFE Playback Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Side Playback Switch'
		value false
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Digit-IO Playback Switch'
		value true
	}
	control.28 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 4
		name 'IEC958 Playback Mask'
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.29 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 4
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.30 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 4
		name 'IEC958 Playback PCM Stream'
		value '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
nls_iso8859_1
nls_cp437
vfat
fat
binfmt_misc
ppdev
bridge
stp
bnep
video
output
input_polldev
sbp2
lp
parport
joydev
snd_ctxfi
snd_pcm
snd_timer
snd
usbhid
i2c_piix4
soundcore
snd_page_alloc
psmouse
serio_raw
usblp
pcspkr
nvidia
usb_storage
ohci1394
ieee1394
r8169
mii
fbcon
tileblit
font
bitblit
softcursor


!!ALSA/HDA dmesg
!!------------------




--------------050204070308040806070505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050204070308040806070505--
