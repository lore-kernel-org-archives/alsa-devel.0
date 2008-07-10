From: "Kristin Low" <kristin.low@gmail.com>
Subject: ALSA Problem - Broken Pipe
Date: Wed, 9 Jul 2008 20:31:19 -0400
Message-ID: <3b2c72ff0807091731m27ed3247nb91a8e55702bd3e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B6A8610380B
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 02:31:21 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2740617rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 09 Jul 2008 17:31:19 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi all,


I apologize if this isn't the right place to ask for help, but no one who
I've asked knows how to help and I'm somewhat new to Linux.

I'm running Ubuntu Hardy Heron and haven't changed any config files
(practically a fresh install) however ALSA does not work properly and I
assume that because of this, Pulseaudio doesn't work either (it breaks when
ALSA does). Playing a song, I can hear the song for a random length of time
and then it cuts out. If I run VLC from a terminal, it claims "alsa output
error: write error (broken pipe)" as the cause and continues to write that
over the screen until I force VLC to quit. If I restart the song again, the
same thing occurs. Pulseaudio cuts out and says it gets a POLLERR from ALSA.
When I login, only part of the login sounds play and are cut just the same
as any songs or audio files I try. It seems like my sound card is detected
fine, and OSS works when I select to use it instead. It's on a laptop, a
Toshiba Satellite a70.


Below I've listed the alsa-info.txt as per
https://wiki.ubuntu.com/DebuggingSoundProblems.


Thanks,

Kristin



name=kristin&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.48
!!################################

!!Script ran on: Tue Jul  8 16:13:38 EDT 2008


!!Linux Distribution
!!------------------

Ubuntu 8.04.1 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 8.04.1"


!!Kernel Information
!!------------------

Kernel release:    2.6.24-19-generic
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

snd_atiixp
snd_atiixp_modem


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [IXP            ]: ATIIXP - ATI IXP
                      ATI IXP rev 0 with ALC250 at 0xd0004400, irq 17
 1 [Modem          ]: ATIIXP-MODEM - ATI IXP Modem
                      ATI IXP Modem rev 1 at 0xd0004800, irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio
Controller
02:02.0 Ethernet controller: Atheros Communications Inc. AR5212/AR5213
Multiprotocol MAC/baseband processor (rev 01)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.5 0401: 1002:4341
    Subsystem: 1179:ff01


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

!!Module: snd_atiixp
ac97_clock : 48000
ac97_codec : -1
ac97_quirk : <NULL>
enable : N
id : <NULL>
index : -1
spdif_aclink : Y

!!Module: snd_atiixp_modem
ac97_clock : 48000
enable : N
id : <NULL>
index : -2


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: Realtek ALC250 rev 2

PCI Subsys Vendor: 0x1179
PCI Subsys Device: 0xff01

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=2 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPDIF=3/4 VRA
PCM front DAC    : 44100Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

                    Gain     Inverted  Buffer delay  Location
Master Out       :   0.0 dBV    -      23/fs         Rear I/O Panel
AUX Out          :   0.0 dBV    -      23/fs         Rear I/O Panel
Center/LFE Out   :   0.0 dBV    -      23/fs         Rear I/O Panel
SPDIF Out        :   0.0 dBV    -      23/fs         Rear I/O Panel
Phone In         :   0.0 dBV    -      23/fs         Rear I/O Panel
Mic 1            :   0.0 dBV    -      23/fs         Rear I/O Panel
Mic 2            :   0.0 dBV    -      23/fs         Rear I/O Panel
Line In          :   0.0 dBV    -      23/fs         Rear I/O Panel
CD In            :   0.0 dBV    -      23/fs         Rear I/O Panel
Video In         :   0.0 dBV    -      23/fs         Rear I/O Panel
Aux In           :   0.0 dBV    -      23/fs         Rear I/O Panel
Mono Out         :   0.0 dBV    -      23/fs         Rear I/O Panel

0:00 = 0190
0:02 = 0000
0:04 = 1212
0:06 = 0008
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 831f
0:10 = 9f1f
0:12 = 0505
0:14 = 0000
0:16 = 9f1f
0:18 = 0606
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0a07
0:2a = 0001
0:2c = ac44
0:2e = 0000
0:30 = 0000
0:32 = ac44
0:34 = bb80
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
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0aea
0:6a = 4400
0:6c = 4601
0:6e = 0015
0:70 = 0008
0:72 = 0000
0:74 = 0100
0:76 = 0304
0:78 = 0c03
0:7a = 6002
0:7c = 414c
0:7e = 4752
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 2008-07-08 12:08 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 32 2008-07-08 12:08 /dev/snd/controlC1
crw-rw----+ 1 root audio 116, 24 2008-07-08 14:11 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 2008-07-08 15:15 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 56 2008-07-08 12:08 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116, 48 2008-07-08 12:08 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116,  1 2008-07-08 12:08 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 2008-07-08 12:08 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: Modem [ATI IXP Modem], device 0: ATI IXP MC97 [ATI IXP MC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Modem [ATI IXP Modem], device 0: ATI IXP MC97 [ATI IXP MC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [IXP]

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Mono:
  Front Left: Playback 63 [100%] [0.00dB] [on]
  Front Right: Playback 63 [100%] [0.00dB] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 23 [74%] [-12.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Mono:
  Front Left: Playback 45 [71%] [-27.00dB] [on]
  Front Right: Playback 45 [71%] [-27.00dB] [on]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [3.00dB] [on]
  Front Right: Playback 25 [81%] [3.00dB] [on]
Simple mixer control 'PCM Out Path & Mute',0
  Capabilities: enum
  Items: 'pre 3D' 'post 3D'
  Item0: 'pre 3D'
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 26 [84%] [4.50dB] [on] Capture [off]
  Front Right: Playback 26 [84%] [4.50dB] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [on]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
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
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 0 [0%] [-45.00dB] [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

!!-------Mixer controls for card 1 [Modem]

Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Modem Speaker',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.IXP {
    control.1 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Master Playback Switch'
        value true
    }
    control.2 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 63'
        iface MIXER
        name 'Master Playback Volume'
        value.0 63
        value.1 63
    }
    control.3 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Headphone Playback Switch'
        value true
    }
    control.4 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 63'
        iface MIXER
        name 'Headphone Playback Volume'
        value.0 45
        value.1 45
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
        value 23
    }
    control.7 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'PC Speaker Playback Switch'
        value false
    }
    control.8 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 15'
        iface MIXER
        name 'PC Speaker Playback Volume'
        value 0
    }
    control.9 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Phone Playback Switch'
        value false
    }
    control.10 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 31'
        iface MIXER
        name 'Phone Playback Volume'
        value 0
    }
    control.11 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Mic Playback Switch'
        value false
    }
    control.12 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        iface MIXER
        name 'Mic Playback Volume'
        value.0 0
        value.1 0
    }
    control.13 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Mic Boost (+20dB)'
        value false
    }
    control.14 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Line Playback Switch'
        value false
    }
    control.15 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        iface MIXER
        name 'Line Playback Volume'
        value.0 0
        value.1 0
    }
    control.16 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'CD Playback Switch'
        value true
    }
    control.17 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        iface MIXER
        name 'CD Playback Volume'
        value.0 26
        value.1 26
    }
    control.18 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Aux Playback Switch'
        value false
    }
    control.19 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        iface MIXER
        name 'Aux Playback Volume'
        value.0 0
        value.1 0
    }
    control.20 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'PCM Playback Switch'
        value true
    }
    control.21 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        iface MIXER
        name 'PCM Playback Volume'
        value.0 25
        value.1 25
    }
    control.22 {
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
        value.0 Mic
        value.1 Mic
    }
    control.23 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Capture Switch'
        value true
    }
    control.24 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 15'
        iface MIXER
        name 'Capture Volume'
        value.0 0
        value.1 0
    }
    control.25 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'pre 3D'
        comment.item.1 'post 3D'
        iface MIXER
        name 'PCM Out Path & Mute'
        value 'pre 3D'
    }
    control.26 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name '3D Control - Switch'
        value false
    }
    control.27 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 Mic1
        comment.item.1 Mic2
        iface MIXER
        name 'Mic Select'
        value Mic1
    }
    control.28 {
        comment.access read
        comment.type IEC958
        comment.count 1
        iface MIXER
        name 'IEC958 Playback Con Mask'
        value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
    }
    control.29 {
        comment.access read
        comment.type IEC958
        comment.count 1
        iface MIXER
        name 'IEC958 Playback Pro Mask'
        value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    }
    control.30 {
        comment.access 'read write'
        comment.type IEC958
        comment.count 1
        iface MIXER
        name 'IEC958 Playback Default'
        value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
    }
    control.31 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'IEC958 Playback Switch'
        value false
    }
    control.32 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 3'
        iface MIXER
        name 'IEC958 Playback AC97-SPSA'
        value 0
    }
    control.33 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'External Amplifier'
        value true
    }
}
state.Modem {
    control.1 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Off-hook Switch'
        value false
    }
    control.2 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Caller ID Switch'
        value false
    }
    control.3 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 3'
        iface MIXER
        name 'Modem Speaker Volume'
        value.0 0
        value.1 0
    }
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ipv6
af_packet
radeon
drm
rfcomm
l2cap
bluetooth
ppdev
acpi_cpufreq
speedstep_lib
cpufreq_powersave
cpufreq_conservative
cpufreq_userspace
cpufreq_ondemand
cpufreq_stats
freq_table
dock
sbs
sbshc
iptable_filter
ip_tables
x_tables
sbp2
lp
joydev
pcmcia
wlan_scan_sta
ath_rate_sample
snd_atiixp
parport_pc
parport
snd_seq_dummy
evdev
snd_atiixp_modem
video
output
snd_ac97_codec
serio_raw
snd_seq_oss
sdhci
battery
irda
container
ac97_bus
snd_pcm_oss
snd_mixer_oss
ac
crc_ccitt
ath_pci
snd_seq_midi
mmc_core
yenta_socket
rsrc_nonstatic
pcmcia_core
psmouse
wlan
snd_rawmidi
snd_seq_midi_event
ath_hal
button
snd_pcm
snd_seq
snd_timer
snd_seq_device
i2c_piix4
ati_agp
shpchp
pci_hotplug
pcspkr
i2c_core
agpgart
snd
soundcore
snd_page_alloc
ext3
jbd
mbcache
sg
usbhid
hid
sr_mod
cdrom
sd_mod
atiixp
ide_core
pata_acpi
pata_atiixp
8139too
ohci1394
ata_generic
8139cp
mii
ieee1394
libata
scsi_mod
ehci_hcd
ohci_hcd
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
