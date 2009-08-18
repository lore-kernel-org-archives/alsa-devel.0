From: David P <changedsoul@gmail.com>
Subject: SB Audigy 4 No Front speakers,
	only Rear / SigmaTel STAC9750, 51 codec
Date: Tue, 18 Aug 2009 11:26:19 -0500
Message-ID: <d912a7d80908180926w625bdbd8y5e52dd0b459dd97e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 47B412477D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 18:26:21 +0200 (CEST)
Received: by ywh11 with SMTP id 11so5901705ywh.16
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2009 09:26:19 -0700 (PDT)
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

Hi, after some time trying to trouble shoot this sound issue, I was
encuraged to post a message explaining my situation in hopes maybe I would
get some help.

I have a SB Audigy 4. Surround Speakers work, Mic works.  I do not have
sound from front speakers. I'm not trying to do 5.1 surround or anything
fancy. Just have headphones and a pair of speakers. I find it strange I have
sound coming from the Rear and not the Front. All the searching I have done
for this card seems people are having the oposite issue.

I have checked all connections, they are all fine. I enabled all mixer
controls and turned all the volumes up. Running various command line
speaker-test's always reports no sound from Fronts, only Rears.

So here I am asking for help. Here is a copy of my Alsa-info
I hope this helps .

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.57
!!################################

!!Script ran on: Tue Aug 18 15:42:27 UTC 2009


!!Linux Distribution
!!------------------

Welcome to openSUSE 11.1 - Kernel \r (\l). openSUSE 11.1 (i586)
LSB_VERSION="core-2.0-noarch:core-3.2-noarch:core-2.0-ia32:core-3.2-ia32"


!!DMI Information
!!---------------

Manufacturer:      Gigabyte Technology Co., Ltd.
Product Name:      P31-S3G


!!Kernel Information
!!------------------

Kernel release:    2.6.27.25-0.1-pae
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.17
Library version:
Utilities version:  1.0.20


!!Loaded ALSA modules
!!-------------------

snd_emu10k1


!!Sound Servers on this system
!!----------------------------

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

aRts:
      Installed - Yes (/opt/kde3/bin/artsd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Audigy2        ]: Audigy2 - Audigy 4 [SB0610]
                      Audigy 4 [SB0610] (rev.0, serial:0x10211102) at
0xd000, irq 18


!!PCI Soundcards installed in the system
!!--------------------------------------

04:02.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

04:02.0 0401: 1102:0008
    Subsystem: 1102:1021


!!Modprobe options (Sound related)
!!--------------------------------

snd-emu10k1: extin=0x3fff extout=0x7fff


!!Loaded sound module options
!!--------------------------

!!Module: snd_emu10k1
    enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
    enable_ir :
N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
    extin :
16383,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    extout :
32767,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    id :
<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
    index :
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
    max_buffer_size :
128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
    max_synth_voices :
64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
    seq_ports :
4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
    subsystem :
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: SigmaTel STAC9750,51

PCI Subsys Vendor: 0x0000
PCI Subsys Device: 0x0000

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=7/8
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x0 Generation=0
Rate=48kHz

0:00 = 6a90
0:02 = 0505
0:04 = 9f1f
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 8009
0:0e = 0047
0:10 = 0a0a
0:12 = 8808
0:14 = 8808
0:16 = 8b0b
0:18 = 9f1f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0605
0:2a = 0410
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2000
0:3c = 0000
0:3e = 0100
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0003
0:4e = ffff
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
0:68 = 0000
0:6a = 0000
0:6c = 0002
0:6e = 1000
0:70 = 0000
0:72 = 0000
0:74 = 0800
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 8384
0:7e = 7650
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 12 Aug 18 05:04 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  3 Aug 18 05:04 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 14 Aug 18 10:04 /dev/snd/hwC0D2
crw-rw----+ 1 root audio 116,  5 Aug 18 05:04 /dev/snd/midiC0D0
crw-rw----+ 1 root audio 116,  4 Aug 18 05:04 /dev/snd/midiC0D1
crw-rw----+ 1 root audio 116, 15 Aug 18 10:04 /dev/snd/midiC0D2
crw-rw----+ 1 root audio 116, 16 Aug 18 10:04 /dev/snd/midiC0D3
crw-rw----+ 1 root audio 116, 11 Aug 18 05:04 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 10 Aug 18 10:20 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  9 Aug 18 05:04 /dev/snd/pcmC0D1c
crw-rw----+ 1 root audio 116,  8 Aug 18 05:04 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116,  7 Aug 18 05:04 /dev/snd/pcmC0D2p
crw-rw----+ 1 root audio 116,  6 Aug 18 05:04 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116, 13 Aug 18 10:04 /dev/snd/seq
crw-rw----+ 1 root audio 116,  2 Aug 18 05:04 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Audigy2 [Audigy 4 [SB0610]], device 0: emu10k1 [ADC Capture/Standard
PCM Playback]
  Subdevices: 31/32
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
  Subdevice #8: subdevice #8
  Subdevice #9: subdevice #9
  Subdevice #10: subdevice #10
  Subdevice #11: subdevice #11
  Subdevice #12: subdevice #12
  Subdevice #13: subdevice #13
  Subdevice #14: subdevice #14
  Subdevice #15: subdevice #15
  Subdevice #16: subdevice #16
  Subdevice #17: subdevice #17
  Subdevice #18: subdevice #18
  Subdevice #19: subdevice #19
  Subdevice #20: subdevice #20
  Subdevice #21: subdevice #21
  Subdevice #22: subdevice #22
  Subdevice #23: subdevice #23
  Subdevice #24: subdevice #24
  Subdevice #25: subdevice #25
  Subdevice #26: subdevice #26
  Subdevice #27: subdevice #27
  Subdevice #28: subdevice #28
  Subdevice #29: subdevice #29
  Subdevice #30: subdevice #30
  Subdevice #31: subdevice #31
card 0: Audigy2 [Audigy 4 [SB0610]], device 2: emu10k1 efx [Multichannel
Capture/PT Playback]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: Audigy2 [Audigy 4 [SB0610]], device 3: emu10k1 [Multichannel
Playback]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Audigy2 [Audigy 4 [SB0610]], device 0: emu10k1 [ADC Capture/Standard
PCM Playback]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Audigy2 [Audigy 4 [SB0610]], device 1: emu10k1 mic [Mic Capture]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Audigy2 [Audigy 4 [SB0610]], device 2: emu10k1 efx [Multichannel
Capture/PT Playback]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Audigy2]

Card hw:0 'Audigy2'/'Audigy 4 [SB0610] (rev.0, serial:0x10211102) at 0xd000,
irq 18'
  Mixer name    : 'SigmaTel STAC9750,51'
  Components    : 'AC97a:83847650'
  Controls      : 201
  Simple ctrls  : 36
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined cvolume cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 31
  Mono: Playback 68 [68%] [-12.80dB]
  Front Left: Capture 26 [84%] [-7.50dB] [on]
  Front Right: Capture 26 [84%] [-7.50dB] [on]
Simple mixer control 'Tone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 27 [68%]
  Front Right: 27 [68%]
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 27 [68%]
  Front Right: 27 [68%]
Simple mixer control 'PCM',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 100
  Front Left: Capture 65 [65%] [-14.00dB]
  Front Right: Capture 65 [65%] [-14.00dB]
Simple mixer control 'PCM Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 75 [75%] [-10.00dB]
Simple mixer control 'PCM Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 75 [75%] [-10.00dB]
  Front Right: Playback 75 [75%] [-10.00dB]
Simple mixer control 'PCM LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 75 [75%] [-10.00dB]
Simple mixer control 'PCM Out Path & Mute',0
  Capabilities: enum
  Items: 'pre 3D' 'post 3D'
  Item0: 'pre 3D'
Simple mixer control 'PCM Side',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 72 [72%] [-11.20dB]
  Front Right: Playback 72 [72%] [-11.20dB]
Simple mixer control 'PCM Surround',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 75 [75%] [-10.00dB]
  Front Right: Playback 75 [75%] [-10.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 82 [82%] [-7.20dB]
  Front Right: Playback 82 [82%] [-7.20dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 84 [84%] [-6.40dB]
  Front Right: Playback 84 [84%] [-6.40dB]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 70 [70%] [-12.00dB]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 64 [64%] [-14.40dB]
Simple mixer control 'Side',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 82 [82%] [-7.20dB]
  Front Right: Playback 82 [82%] [-7.20dB]
Simple mixer control 'Synth',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 81 [81%] [-7.60dB] Capture 100 [100%] [0.00dB]
  Front Right: Playback 81 [81%] [-7.60dB] Capture 100 [100%] [0.00dB]
Simple mixer control 'Wave',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 82 [82%] [-7.20dB]
  Front Right: Playback 82 [82%] [-7.20dB]
Simple mixer control 'Line',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 21 [68%] [-3.00dB] [on]
  Front Right: Capture 21 [68%] [-3.00dB] [on]
Simple mixer control 'CD',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB] [off]
  Front Right: Capture 23 [74%] [0.00dB] [off]
Simple mixer control 'Mic',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 31
  Mono: Capture 24 [77%] [1.50dB] [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB] [off]
  Front Right: Capture 23 [74%] [0.00dB] [off]
Simple mixer control 'Phone',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 31
  Mono: Capture 22 [71%] [-1.50dB] [off]
Simple mixer control 'IEC958 Optical',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 75 [75%] [-10.00dB] Capture 73 [73%] [-10.80dB]
  Front Right: Playback 75 [75%] [-10.00dB] Capture 73 [73%] [-10.80dB]
Simple mixer control 'IEC958 Optical Raw',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PC Speaker',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 15
  Mono: Capture 0 [0%] [-45.00dB] [off]
Simple mixer control 'Aux',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 20 [65%] [-4.50dB] [off]
  Front Right: Capture 20 [65%] [-4.50dB] [off]
Simple mixer control 'Aux2',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] [-99999.99dB] Capture 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB] Capture 0 [0%] [-99999.99dB]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'AMic',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB]
Simple mixer control 'Analog Mix',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] [-99999.99dB] Capture 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB] Capture 0 [0%] [-99999.99dB]
Simple mixer control 'Audigy Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Audigy CD',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 76 [76%] [-9.60dB] Capture 74 [74%] [-10.40dB]
  Front Right: Playback 76 [76%] [-9.60dB] Capture 74 [74%] [-10.40dB]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Audigy2 {
    control.1 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'PCM Front Playback Volume'
        value.0 75
        value.1 75
    }
    control.2 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'PCM Surround Playback Volume'
        value.0 75
        value.1 75
    }
    control.3 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'PCM Side Playback Volume'
        value.0 72
        value.1 72
    }
    control.4 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'PCM Center Playback Volume'
        value 75
    }
    control.5 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'PCM LFE Playback Volume'
        value 75
    }
    control.6 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Wave Playback Volume'
        value.0 82
        value.1 82
    }
    control.7 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Synth Playback Volume'
        value.0 81
        value.1 81
    }
    control.8 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'PCM Capture Volume'
        value.0 65
        value.1 65
    }
    control.9 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Synth Capture Volume'
        value.0 100
        value.1 100
    }
    control.10 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'AMic Playback Volume'
        value.0 0
        value.1 0
    }
    control.12 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Audigy CD Playback Volume'
        value.0 76
        value.1 76
    }
    control.13 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Audigy CD Capture Volume'
        value.0 74
        value.1 74
    }
    control.14 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'IEC958 Optical Playback Volume'
        value.0 75
        value.1 75
    }
    control.15 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'IEC958 Optical Capture Volume'
        value.0 73
        value.1 73
    }
    control.18 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Analog Mix Playback Volume'
        value.0 0
        value.1 0
    }
    control.19 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Analog Mix Capture Volume'
        value.0 0
        value.1 0
    }
    control.20 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Aux2 Playback Volume'
        value.0 0
        value.1 0
    }
    control.21 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Aux2 Capture Volume'
        value.0 0
        value.1 0
    }
    control.22 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Front Playback Volume'
        value.0 82
        value.1 82
    }
    control.23 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Surround Playback Volume'
        value.0 84
        value.1 84
    }
    control.24 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Center Playback Volume'
        value 70
    }
    control.25 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'LFE Playback Volume'
        value 64
    }
    control.26 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Side Playback Volume'
        value.0 82
        value.1 82
    }
    control.27 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 40'
        iface MIXER
        name 'Tone Control - Bass'
        value.0 27
        value.1 27
    }
    control.28 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 40'
        iface MIXER
        name 'Tone Control - Treble'
        value.0 27
        value.1 27
    }
    control.29 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Tone Control - Switch'
        value.0 true
        value.1 true
    }
    control.30 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 100'
        comment.dbmin -4000
        comment.dbmax 0
        iface MIXER
        name 'Master Playback Volume'
        value 68
    }
    control.31 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'IEC958 Optical Raw Playback Switch'
        value.0 true
        value.1 true
    }
    control.32 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 64
        iface PCM
        device 2
        name 'Captured FX8010 Outputs'
        value.0 false
        value.1 false
        value.2 false
        value.3 false
        value.4 false
        value.5 false
        value.6 false
        value.7 false
        value.8 false
        value.9 false
        value.10 false
        value.11 false
        value.12 false
        value.13 false
        value.14 false
        value.15 false
        value.16 false
        value.17 false
        value.18 false
        value.19 false
        value.20 false
        value.21 false
        value.22 false
        value.23 false
        value.24 false
        value.25 false
        value.26 false
        value.27 false
        value.28 false
        value.29 false
        value.30 false
        value.31 false
        value.32 true
        value.33 true
        value.34 true
        value.35 true
        value.36 true
        value.37 true
        value.38 true
        value.39 true
        value.40 true
        value.41 true
        value.42 true
        value.43 true
        value.44 true
        value.45 true
        value.46 true
        value.47 true
        value.48 false
        value.49 false
        value.50 false
        value.51 false
        value.52 false
        value.53 false
        value.54 false
        value.55 false
        value.56 false
        value.57 false
        value.58 false
        value.59 false
        value.60 false
        value.61 false
        value.62 false
        value.63 false
    }
    control.33 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Master Capture Switch'
        value true
    }
    control.34 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -4650
        comment.dbmax 0
        iface MIXER
        name 'Master Capture Volume'
        value.0 26
        value.1 26
    }
    control.39 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'PC Speaker Capture Switch'
        value false
    }
    control.40 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 15'
        comment.dbmin -4500
        comment.dbmax 0
        iface MIXER
        name 'PC Speaker Capture Volume'
        value 0
    }
    control.41 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Phone Capture Switch'
        value false
    }
    control.42 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'Phone Capture Volume'
        value 22
    }
    control.43 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Mic Capture Switch'
        value true
    }
    control.44 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'Mic Capture Volume'
        value 24
    }
    control.45 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Mic Boost (+20dB)'
        value true
    }
    control.46 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Line Capture Switch'
        value true
    }
    control.47 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'Line Capture Volume'
        value.0 21
        value.1 21
    }
    control.48 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'CD Capture Switch'
        value false
    }
    control.49 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'CD Capture Volume'
        value.0 23
        value.1 23
    }
    control.50 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Video Capture Switch'
        value false
    }
    control.51 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'Video Capture Volume'
        value.0 23
        value.1 23
    }
    control.52 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Aux Capture Switch'
        value false
    }
    control.53 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'Aux Capture Volume'
        value.0 20
        value.1 20
    }
    control.59 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'pre 3D'
        comment.item.1 'post 3D'
        iface MIXER
        name 'PCM Out Path & Mute'
        value 'pre 3D'
    }
    control.61 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 Mix
        comment.item.1 Mic
        iface MIXER
        name 'Mono Output Select'
        value Mix
    }
    control.62 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 Mic1
        comment.item.1 Mic2
        iface MIXER
        name 'Mic Select'
        value Mic1
    }
    control.65 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'External Amplifier'
        value true
    }
    control.66 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 24
        comment.range '0 - 63'
        iface PCM
        name 'EMU10K1 PCM Send Routing'
        value.0 0
        value.1 1
        value.2 2
        value.3 3
        value.4 0
        value.5 0
        value.6 0
        value.7 0
        value.8 0
        value.9 1
        value.10 2
        value.11 3
        value.12 0
        value.13 0
        value.14 0
        value.15 0
        value.16 0
        value.17 1
        value.18 2
        value.19 3
        value.20 0
        value.21 0
        value.22 0
        value.23 0
    }
    control.98 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 24
        comment.range '0 - 255'
        iface PCM
        name 'EMU10K1 PCM Send Volume'
        value.0 255
        value.1 255
        value.2 0
        value.3 0
        value.4 0
        value.5 0
        value.6 0
        value.7 0
        value.8 255
        value.9 0
        value.10 0
        value.11 0
        value.12 0
        value.13 0
        value.14 0
        value.15 0
        value.16 0
        value.17 255
        value.18 0
        value.19 0
        value.20 0
        value.21 0
        value.22 0
        value.23 0
    }
    control.130 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 3
        comment.range '0 - 65535'
        iface PCM
        name 'EMU10K1 PCM Volume'
        value.0 65535
        value.1 65535
        value.2 65535
    }
    control.210 {
        comment.access read
        comment.type IEC958
        comment.count 1
        iface PCM
        name 'IEC958 Playback Mask'
        value
ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    }
    control.211 {
        comment.access read
        comment.type IEC958
        comment.count 1
        iface PCM
        name 'IEC958 Playback Mask'
        index 1
        value
ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    }
    control.212 {
        comment.access read
        comment.type IEC958
        comment.count 1
        iface PCM
        name 'IEC958 Playback Mask'
        index 2
        value
ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    }
    control.213 {
        comment.access 'read write'
        comment.type IEC958
        comment.count 1
        iface PCM
        name 'IEC958 Playback Default'
        value
'0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
    }
    control.214 {
        comment.access 'read write'
        comment.type IEC958
        comment.count 1
        iface PCM
        name 'IEC958 Playback Default'
        index 1
        value
'0492100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
    }
    control.215 {
        comment.access 'read write'
        comment.type IEC958
        comment.count 1
        iface PCM
        name 'IEC958 Playback Default'
        index 2
        value
'0492100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
    }
    control.216 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Audigy Analog/Digital Output Jack'
        value true
    }
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ip6t_LOG
xt_tcpudp
xt_pkttype
ipt_LOG
xt_limit
binfmt_misc
snd_pcm_oss
snd_mixer_oss
snd_seq_midi
snd_emu10k1_synth
snd_emux_synth
snd_seq_virmidi
snd_seq_midi_event
snd_seq_midi_emul
snd_seq
af_packet
ip6t_REJECT
nf_conntrack_ipv6
ip6table_raw
xt_NOTRACK
ipt_REJECT
xt_state
iptable_raw
iptable_filter
ip6table_mangle
nf_conntrack_netbios_ns
nf_conntrack_ipv4
nf_conntrack
ip_tables
ip6table_filter
ip6_tables
x_tables
cpufreq_conservative
ipv6
cpufreq_userspace
cpufreq_powersave
acpi_cpufreq
speedstep_lib
fuse
loop
dm_mod
snd_emu10k1
snd_rawmidi
snd_ac97_codec
ac97_bus
snd_pcm
snd_seq_device
snd_timer
snd_page_alloc
snd_util_mem
snd_hwdep
snd
iTCO_wdt
nvidia
iTCO_vendor_support
rtc_cmos
r8169
ppdev
i2c_i801
sr_mod
intel_agp
soundcore
rtc_core
cdrom
mii
pcspkr
rtc_lib
i2c_core
parport_pc
button
joydev
parport
agpgart
floppy
sg
usbhid
hid
ff_memless
uhci_hcd
ehci_hcd
sd_mod
crc_t10dif
usbcore
edd
ext3
mbcache
jbd
fan
ide_pci_generic
ide_core
ata_generic
ata_piix
libata
scsi_mod
dock
thermal
processor
thermal_sys
hwmon


!!ALSA/HDA dmesg
!!------------------

EMU10K1_Audigy 0000:04:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ALSA sound/pci/emu10k1/emu10k1_main.c:219: Audigy2 value: Special config.
Adding 2104472k swap on /dev/sda5.  Priority:-1 extents:1 across:2104472
