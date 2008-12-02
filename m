From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Gateway MX3042 Laptop. No sound
Date: Wed, 3 Dec 2008 00:12:54 +0100
Message-ID: <200812030012.54515.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id A0E8324156
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 00:13:05 +0100 (CET)
Content-Disposition: inline
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
Cc: Michael Satterwhite <michael@weblore.com>
List-Id: alsa-devel@alsa-project.org

I'm trying to help someone on the Kubuntu list, using Hardy Heron 8.04, which 
uses alsa driver 1.0.16. This is with a Gateway MX3042 Laptop, but no sounds.

The output from running alsa-info.sh is below.


!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: Tue Dec  2 16:30:06 CST 2008


!!Linux Distribution
!!------------------

Ubuntu 8.04.1 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 8.04.1"


!!Kernel Information
!!------------------

Kernel release:    2.6.24-22-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.16
Library version:    
Utilities version:  1.0.15


!!Loaded ALSA modules
!!-------------------

snd_intel8x0


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with AD1981B at irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1f.5 0401: 8086:24c5 (rev 03)
 Subsystem: 161f:203e


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-usx2y: index=-2
snd-usb-caiaq: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388


!!Loaded sound module options
!!--------------------------

!!Module: snd_intel8x0
ac97_clock : 0
ac97_quirk : <NULL>
buggy_irq : N
buggy_semaphore : N
enable : N
id : <NULL>
index : -1
joystick : 0
spdif_aclink : 0
xbox : N


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: Analog Devices AD1981B

PCI Subsys Vendor: 0x161f
PCI Subsys Device: 0x203e

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         :  20dB [ 20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=10/11 SPDIF VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz



AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

0:00 = 0090
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 001f
0:0e = 805f
0:10 = 0808
0:12 = 0606
0:14 = 0000
0:16 = 1f1f
0:18 = 0000
0:1a = 0505
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0605
0:2a = 0435
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 4000
0:5e = 0000
0:60 = 8080
0:62 = 0000
0:64 = 8000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 1800
0:74 = 1001
0:76 = 2050
0:78 = 0000
0:7a = 0000
0:7c = 4144
0:7e = 5374
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----  1 root audio 116,  0 2008-12-02 11:09 /dev/snd/controlC0
crw-rw----  1 root audio 116, 24 2008-12-02 11:09 /dev/snd/pcmC0D0c
crw-rw----  1 root audio 116, 16 2008-12-02 14:27 /dev/snd/pcmC0D0p
crw-rw----  1 root audio 116, 25 2008-12-02 11:09 /dev/snd/pcmC0D1c
crw-rw----  1 root audio 116, 26 2008-12-02 11:09 /dev/snd/pcmC0D2c
crw-rw----  1 root audio 116, 27 2008-12-02 11:09 /dev/snd/pcmC0D3c
crw-rw----  1 root audio 116, 20 2008-12-02 11:09 /dev/snd/pcmC0D4p
crw-rw----  1 root audio 116,  1 2008-12-02 11:09 /dev/snd/seq
crw-rw----  1 root audio 116, 33 2008-12-02 11:09 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 0: Intel ICH [Intel 
82801DB-ICH4]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 4: Intel ICH - IEC958 [Intel 
82801DB-ICH4 - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 0: Intel ICH [Intel 
82801DB-ICH4]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 1: Intel ICH - MIC ADC 
[Intel 82801DB-ICH4 - MIC ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 2: Intel ICH - MIC2 ADC 
[Intel 82801DB-ICH4 - MIC2 ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 3: Intel ICH - ADC2 [Intel 
82801DB-ICH4 - ADC2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [I82801DBICH4]

Card hw:0 'I82801DBICH4'/'Intel 82801DB-ICH4 with AD1981B at irq 17'
  Mixer name : 'Analog Devices AD1981B'
  Components : 'AC97a:41445374'
  Controls      : 34
  Simple ctrls  : 23
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Headphone Jack Sense',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB] [on]
  Front Right: Playback 31 [100%] [12.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [0.00dB] [on] Capture [off]
  Front Right: Playback 23 [74%] [0.00dB] [on] Capture [off]
Simple mixer control 'Line Jack Sense',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 25 [81%] [3.00dB] [on] Capture [off]
  Front Right: Playback 25 [81%] [3.00dB] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch 
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost ( 20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch 
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities: enum
  Items: 'AC-Link' 'A/D Converter'
  Item0: 'AC-Link'
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [on] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [on] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Stereo Mic',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.I82801DBICH4 {
 control.1 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 2
  iface MIXER
  name 'Master Playback Switch'
  value.0 true
  value.1 true
 }
 control.2 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 31'
  iface MIXER
  name 'Master Playback Volume'
  value.0 31
  value.1 31
 }
 control.3 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 2
  iface MIXER
  name 'Headphone Playback Switch'
  value.0 true
  value.1 true
 }
 control.4 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 31'
  iface MIXER
  name 'Headphone Playback Volume'
  value.0 31
  value.1 31
 }
 control.5 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Master Mono Playback Switch'
  value true
 }
 control.6 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 1
  comment.range '0 - 31'
  iface MIXER
  name 'Master Mono Playback Volume'
  value 31
 }
 control.7 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Phone Playback Switch'
  value true
 }
 control.8 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 1
  comment.range '0 - 31'
  iface MIXER
  name 'Phone Playback Volume'
  value 0
 }
 control.9 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Mic Playback Switch'
  value false
 }
 control.10 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 1
  comment.range '0 - 31'
  iface MIXER
  name 'Mic Playback Volume'
  value 0
 }
 control.11 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Mic Boost ( 20dB)'
  value true
 }
 control.12 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 2
  iface MIXER
  name 'Line Playback Switch'
  value.0 true
  value.1 true
 }
 control.13 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 31'
  iface MIXER
  name 'Line Playback Volume'
  value.0 23
  value.1 23
 }
 control.14 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 2
  iface MIXER
  name 'CD Playback Switch'
  value.0 true
  value.1 true
 }
 control.15 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 31'
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
  name 'Aux Playback Switch'
  value.0 true
  value.1 true
 }
 control.17 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 31'
  iface MIXER
  name 'Aux Playback Volume'
  value.0 0
  value.1 0
 }
 control.18 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 2
  iface MIXER
  name 'PCM Playback Switch'
  value.0 true
  value.1 true
 }
 control.19 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 31'
  iface MIXER
  name 'PCM Playback Volume'
  value.0 31
  value.1 31
 }
 control.20 {
  comment.access 'read write'
  comment.type ENUMERATED
  comment.count 2
  comment.item.0 Mic
  comment.item.1 CD
  comment.item.2 Video
  comment.item.3 Aux
  comment.item.4 Line
  comment.item.5 Mix
  comment.item.6 'Mix Mono'
  comment.item.7 Phone
  iface MIXER
  name 'Capture Source'
  value.0 Mix
  value.1 Mix
 }
 control.21 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 2
  iface MIXER
  name 'Capture Switch'
  value.0 true
  value.1 true
 }
 control.22 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 2
  comment.range '0 - 15'
  iface MIXER
  name 'Capture Volume'
  value.0 0
  value.1 0
 }
 control.23 {
  comment.access 'read write'
  comment.type ENUMERATED
  comment.count 1
  comment.item.0 Mix
  comment.item.1 Mic
  iface MIXER
  name 'Mono Output Select'
  value Mix
 }
 control.24 {
  comment.access 'read write'
  comment.type ENUMERATED
  comment.count 1
  comment.item.0 Mic1
  comment.item.1 Mic2
  iface MIXER
  name 'Mic Select'
  value Mic1
 }
	control.25 {
		comment.access read
  comment.type IEC958
  comment.count 1
  iface MIXER
  name 'IEC958 Playback Con Mask'
  value 
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 }
 control.26 {
  comment.access read
  comment.type IEC958
  comment.count 1
  iface MIXER
  name 'IEC958 Playback Pro Mask'
  value 
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
 }
 control.27 {
  comment.access 'read write'
  comment.type IEC958
  comment.count 1
  iface MIXER
  name 'IEC958 Playback Default'
  value 
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 }
 control.28 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'IEC958 Playback Switch'
  value true
 }
 control.29 {
  comment.access 'read write'
  comment.type INTEGER
  comment.count 1
  comment.range '0 - 3'
  iface MIXER
  name 'IEC958 Playback AC97-SPSA'
  value 3
 }
 control.30 {
  comment.access 'read write'
  comment.type ENUMERATED
  comment.count 1
  comment.item.0 AC-Link
  comment.item.1 'A/D Converter'
  iface MIXER
  name 'IEC958 Playback Source'
  value AC-Link
 }
 control.31 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Stereo Mic'
  value true
 }
 control.32 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Headphone Jack Sense'
  value true
 }
 control.33 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Line Jack Sense'
  value true
 }
 control.34 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'External Amplifier'
  value false
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
usb_storage
libusual
ipv6
af_packet
rfcomm
l2cap
bluetooth
rfkill_input
i915
drm
ppdev
cpufreq_userspace
cpufreq_stats
cpufreq_powersave
cpufreq_conservative
cpufreq_ondemand
freq_table
dock
container
sbs
sbshc
iptable_filter
ip_tables
x_tables
aes_i586
dm_crypt
dm_mod
sbp2
parport_pc
lp
parport
joydev
tifm_sd
mmc_core
pcmcia
arc4
ecb
blkcipher
b43
rfkill
mac80211
cfg80211
led_class
input_polldev
snd_intel8x0
snd_ac97_codec
ac97_bus
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
video
output
evdev
psmouse
tifm_7xx1
serio_raw
snd_seq_oss
tifm_core
yenta_socket
rsrc_nonstatic
snd_seq_midi
pcmcia_core
snd_rawmidi
snd_seq_midi_event
snd_seq
snd_timer
snd_seq_device
battery
ac
button
pcspkr
snd
soundcore
iTCO_wdt
iTCO_vendor_support
snd_page_alloc
intel_agp
shpchp
pci_hotplug
agpgart
ext3
jbd
mbcache
sg
sr_mod
cdrom
sd_mod
ata_generic
usbhid
hid
b44
ata_piix
ohci1394
pata_acpi
ssb
mii
ieee1394
libata
scsi_mod
ehci_hcd
uhci_hcd
usbcore
thermal
processor
fan
fbcon
tileblit
font
bitblit
softcursor
fuse

Any help in getting Michael's sounds working, greatly appreciated.

Nigel.
