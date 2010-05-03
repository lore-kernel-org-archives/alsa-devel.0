From: Peter Hercek <phercek@gmail.com>
Subject: Xonar D1 front panel microphone not working in kernel
	2.6.33
Date: Mon, 03 May 2010 23:48:24 +0200
Message-ID: <hrngb8$7q6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070009050907010902070303"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 678832471D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 23:50:06 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O93Wf-0002vv-Bz
	for alsa-devel@alsa-project.org; Mon, 03 May 2010 23:50:05 +0200
Received: from mail.hck.sk ([87.197.106.197])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 23:50:05 +0200
Received: from phercek by mail.hck.sk with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 23:50:05 +0200
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
--------------070009050907010902070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It is not possible to record anything from my front panel microphone 
jack after I updated kernel to 2.6.33.

It still works OK with kernel 2.6.32.10, but does not work with 
2.6.33.3, and it did not work with 2.6.33.rc8 too. The front panel 
switch in alsamixer switches only output but not input (mic) now. 
Before, the switch had impact on both output and input.
When I activate the back panel on the card everything is working well 
(back panel connectors are active, front panel connectors are inactive). 
When I activate the front panel then the front panel microphone is not 
working (back panel microphone works). The alsamixer front panel switch 
does not have impact on the microphone any more and no switch was added 
to control the microphone separately from the output.
The alsa version is 1.0.23.

I use 32 bit kernels. My brother uses 64 bit kernels and the problem is 
the same for him too. Although he uses Xonar DX.

Any idea how to get this fixed?

I attached output of alsa-info.sh for both cases.
Maybe it is only some new configuration thing which needs to be done but 
if not then I should be able to test a patch to vanilla kernel 2.6.33.3 
if needed.

Peter.

--------------070009050907010902070303
Content-Type: text/plain;
 name="alsa-info-2.6.32.10.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-info-2.6.32.10.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon May  3 21:37:39 UTC 2010


!!Linux Distribution
!!------------------

Arch Linux (Core Dump) \r (\n) (\l)


!!DMI Information
!!---------------

Manufacturer:       
Product Name:       


!!Kernel Information
!!------------------

Kernel release:    2.6.32-ARCH
Operating System:  GNU/Linux
Architecture:      i686
Processor:         AMD Athlon(tm) 64 X2 Dual Core Processor 4800+
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.23
Utilities version:  1.0.23


!!Loaded ALSA modules
!!-------------------

snd_virtuoso


!!Sound Servers on this system
!!----------------------------

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [D1             ]: AV200 - Xonar D1
                      Asus Virtuoso 100 (rev 2) at 0x9c00, irq 18


!!PCI Soundcards installed in the system
!!--------------------------------------

02:07.0 Multimedia video controller: Brooktree Corporation Bt879 Video Capture (rev 02)
02:07.1 Multimedia controller: Brooktree Corporation Bt879 Audio Capture (rev 02)
02:08.0 Multimedia audio controller: C-Media Electronics Inc CMI8788 [Oxygen HD Audio]


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

02:08.0 0401: 13f6:8788
	Subsystem: 1043:834f


!!Loaded sound module options
!!--------------------------

!!Module: snd_virtuoso
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 7 May  3 23:36 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 6 May  3 23:36 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 5 May  3 23:36 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 4 May  3 23:36 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 3 May  3 23:36 /dev/snd/seq
crw-rw---- 1 root audio 116, 2 May  3 23:36 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 May  3 23:36 .
drwxr-xr-x 3 root root 180 May  3 23:36 ..
lrwxrwxrwx 1 root root  12 May  3 23:36 pci-0000:02:08.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: D1 [Xonar D1], device 0: Multichannel [Multichannel]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: D1 [Xonar D1], device 1: Digital [Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: D1 [Xonar D1], device 0: Multichannel [Multichannel]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [D1]

Card hw:0 'D1'/'Asus Virtuoso 100 (rev 2) at 0x9c00, irq 18'
  Mixer name	: 'AV200'
  Components	: 'CS4398 CS4362A CS5361 AV200'
  Controls      : 16
  Simple ctrls  : 9
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right - Rear Left - Rear Right - Front Center - Woofer - Side Left - Side Right
  Limits: Playback 67 - 127
  Mono:
  Front Left: Playback 121 [90%] [-6.00dB] [on]
  Front Right: Playback 121 [90%] [-6.00dB] [on]
  Rear Left: Playback 121 [90%] [-6.00dB] [on]
  Rear Right: Playback 121 [90%] [-6.00dB] [on]
  Front Center: Playback 121 [90%] [-6.00dB] [on]
  Woofer: Playback 121 [90%] [-6.00dB] [on]
  Side Left: Playback 121 [90%] [-6.00dB] [on]
  Side Right: Playback 121 [90%] [-6.00dB] [on]
Simple mixer control 'Front Panel',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Line',0
  Capabilities: cswitch cswitch-joined penum
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Mic',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined penum
  Capture channels: Mono
  Limits: Capture 0 - 31
  Mono: Capture 27 [87%] [6.00dB] [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Aux',0
  Capabilities: cvolume cswitch cswitch-joined penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 28 [90%] [7.50dB] [on]
  Front Right: Capture 27 [87%] [6.00dB] [on]
Simple mixer control 'Analog Input Monitor',0
  Capabilities: volume volume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 1
  Mono: 1 [100%] [0.00dB] Playback [off]
Simple mixer control 'Stereo Upmixing',0
  Capabilities: enum
  Items: 'Front' 'Front+Surround' 'Front+Surround+Back'
  Item0: 'Front'


!!Alsactl output
!!-------------

--startcollapse--
state.D1 {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 8
		comment.range '67 - 127'
		comment.dbmin -6000
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 121
		value.1 121
		value.2 121
		value.3 121
		value.4 121
		value.5 121
		value.6 121
		value.7 121
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.3 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Front
		comment.item.1 Front+Surround
		comment.item.2 Front+Surround+Back
		iface MIXER
		name 'Stereo Upmixing'
		value Front
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.5 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Default'
		value '0482000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.6 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Con Mask'
		value '3eff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Input Monitor Switch'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 1'
		comment.dbmin -1000
		comment.dbmax 0
		iface MIXER
		name 'Analog Input Monitor Volume'
		value 1
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Capture Volume'
		value 27
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Capture Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value true
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Capture Switch'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Aux Capture Volume'
		value.0 28
		value.1 27
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Capture Switch'
		value true
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Front Panel Switch'
		value true
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
vmnet
vmblock
vsock
vmci
vmmon
cpufreq_ondemand
tuner
tea5767
tda8290
tda18271
tda827x
tuner_xc2028
xc5000
tda9887
tuner_simple
tuner_types
mt20xx
tea5761
tvaudio
tda7432
msp3400
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_pcm_oss
snd_virtuoso
bttv
snd_mixer_oss
snd_oxygen_lib
v4l2_common
snd_pcm
snd_timer
videodev
snd_page_alloc
snd_mpu401_uart
v4l1_compat
snd_rawmidi
ir_common
i2c_algo_bit
snd_seq_device
videobuf_dma_sg
loop
fuse
videobuf_core
snd
btcx_risc
firewire_ohci
tveeprom
soundcore
firewire_core
crc_itu_t
w83627hf
shpchp
usbhid
amd64_agp
i2c_nforce2
ppdev
parport_pc
thermal
pci_hotplug
agpgart
evdev
hwmon_vid
forcedeth
k8temp
psmouse
i2c_core
hid
serio_raw
button
sg
usb_storage
lp
powernow_k8
freq_table
processor
pcspkr
parport
r8169
mii
rtc_cmos
rtc_core
rtc_lib
ext3
jbd
mbcache
ohci_hcd
ehci_hcd
usbcore
sr_mod
sd_mod
cdrom
sata_nv
ata_generic
pata_amd
libata
scsi_mod


!!ALSA/HDA dmesg
!!------------------




--------------070009050907010902070303
Content-Type: text/plain;
 name="alsa-info-2.6.33.3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-info-2.6.33.3.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon May  3 21:35:13 UTC 2010


!!Linux Distribution
!!------------------

Arch Linux (Core Dump) \r (\n) (\l)


!!DMI Information
!!---------------

Manufacturer:       
Product Name:       


!!Kernel Information
!!------------------

Kernel release:    2.6.33.3-vanilla
Operating System:  GNU/Linux
Architecture:      i686
Processor:         AMD Athlon(tm) 64 X2 Dual Core Processor 4800+
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.23
Utilities version:  1.0.23


!!Loaded ALSA modules
!!-------------------

snd_virtuoso


!!Sound Servers on this system
!!----------------------------

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [D1             ]: AV200 - Xonar D1
                      Asus Virtuoso 100 (rev 2) at 0x9c00, irq 18


!!PCI Soundcards installed in the system
!!--------------------------------------

02:07.0 Multimedia video controller: Brooktree Corporation Bt879 Video Capture (rev 02)
02:07.1 Multimedia controller: Brooktree Corporation Bt879 Audio Capture (rev 02)
02:08.0 Multimedia audio controller: C-Media Electronics Inc CMI8788 [Oxygen HD Audio]


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

02:08.0 0401: 13f6:8788
	Subsystem: 1043:834f


!!Loaded sound module options
!!--------------------------

!!Module: snd_virtuoso
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 7 May  3 09:33 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 6 May  3 09:33 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 5 May  3 23:18 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 4 May  3 09:33 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 3 May  3 09:33 /dev/snd/seq
crw-rw---- 1 root audio 116, 2 May  3 09:33 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 May  3 09:33 .
drwxr-xr-x 3 root root 180 May  3 09:33 ..
lrwxrwxrwx 1 root root  12 May  3 09:33 pci-0000:02:08.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: D1 [Xonar D1], device 0: Multichannel [Multichannel]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: D1 [Xonar D1], device 1: Digital [Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: D1 [Xonar D1], device 0: Multichannel [Multichannel]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [D1]

Card hw:0 'D1'/'Asus Virtuoso 100 (rev 2) at 0x9c00, irq 18'
  Mixer name	: 'AV200'
  Components	: 'CS4398 CS4362A CS5361 AV200'
  Controls      : 17
  Simple ctrls  : 10
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right - Rear Left - Rear Right - Front Center - Woofer - Side Left - Side Right
  Limits: Playback 67 - 127
  Mono:
  Front Left: Playback 121 [90%] [-6.00dB] [on]
  Front Right: Playback 121 [90%] [-6.00dB] [on]
  Rear Left: Playback 121 [90%] [-6.00dB] [on]
  Rear Right: Playback 121 [90%] [-6.00dB] [on]
  Front Center: Playback 121 [90%] [-6.00dB] [on]
  Woofer: Playback 121 [90%] [-6.00dB] [on]
  Side Left: Playback 121 [90%] [-6.00dB] [on]
  Side Right: Playback 121 [90%] [-6.00dB] [on]
Simple mixer control 'Front Panel',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Line',0
  Capabilities: cswitch cswitch-joined penum
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Mic',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined penum
  Capture channels: Mono
  Limits: Capture 0 - 31
  Mono: Capture 27 [87%] [6.00dB] [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Aux',0
  Capabilities: cvolume cswitch cswitch-joined penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 28 [90%] [7.50dB] [on]
  Front Right: Capture 27 [87%] [6.00dB] [on]
Simple mixer control 'Analog Input Monitor',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 1
  Mono: Playback 1 [100%] [0.00dB] [on]
Simple mixer control 'DAC Filter',0
  Capabilities: penum
  Items: 'Fast Roll-off' 'Slow Roll-off'
  Item0: 'Fast Roll-off'
Simple mixer control 'Stereo Upmixing',0
  Capabilities: enum
  Items: 'Front' 'Front+Surround' 'Front+Surround+Back' 'Front+Surround+Center/LFE' 'Front+Surround+Center/LFE+Back'
  Item0: 'Front'


!!Alsactl output
!!-------------

--startcollapse--
state.D1 {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 8
		comment.range '67 - 127'
		comment.dbmin -6000
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 121
		value.1 121
		value.2 121
		value.3 121
		value.4 121
		value.5 121
		value.6 121
		value.7 121
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.3 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Front
		comment.item.1 Front+Surround
		comment.item.2 Front+Surround+Back
		comment.item.3 Front+Surround+Center/LFE
		comment.item.4 Front+Surround+Center/LFE+Back
		iface MIXER
		name 'Stereo Upmixing'
		value Front
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.5 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Default'
		value '0482000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.6 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Con Mask'
		value '3eff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Input Monitor Playback Switch'
		value true
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 1'
		comment.dbmin -1000
		comment.dbmax 0
		iface MIXER
		name 'Analog Input Monitor Playback Volume'
		value 1
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Capture Volume'
		value 27
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Capture Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value true
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Capture Switch'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Aux Capture Volume'
		value.0 28
		value.1 27
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Capture Switch'
		value true
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Front Panel Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Fast Roll-off'
		comment.item.1 'Slow Roll-off'
		iface MIXER
		name 'DAC Filter Playback Enum'
		value 'Fast Roll-off'
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
serpent
lrw
gf128mul
dm_crypt
dm_mod
vmnet
vmblock
vsock
vmci
vmmon
cpufreq_ondemand
tuner_simple
tuner_types
radeon
tuner
tvaudio
loop
ttm
drm_kms_helper
drm
fuse
tda7432
snd_seq_dummy
msp3400
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_pcm_oss
snd_mixer_oss
snd_virtuoso
bttv
snd_oxygen_lib
v4l2_common
videodev
snd_pcm
v4l1_compat
snd_timer
ir_common
snd_page_alloc
i2c_algo_bit
snd_mpu401_uart
firewire_ohci
videobuf_dma_sg
videobuf_core
snd_rawmidi
btcx_risc
snd_seq_device
firewire_core
w83627hf
hwmon_vid
ppdev
parport_pc
crc_itu_t
powernow_k8
tveeprom
snd
i2c_nforce2
ir_core
i2c_core
soundcore
freq_table
evdev
thermal
k8temp
button
processor
usbhid
usb_storage
r8169
hid
shpchp
psmouse
forcedeth
amd64_agp
pci_hotplug
mii
agpgart
serio_raw
lp
pcspkr
sg
parport
rtc_cmos
rtc_core
rtc_lib
ext3
jbd
mbcache
ohci_hcd
ehci_hcd
usbcore
sd_mod
sr_mod
cdrom
sata_nv
ata_generic
pata_amd
libata
scsi_mod


!!ALSA/HDA dmesg
!!------------------




--------------070009050907010902070303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070009050907010902070303--
