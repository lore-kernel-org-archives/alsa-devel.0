From: "=?utf-8?B?5YiY5Lyf5Liw?=" <liuwf@sanlogic.com>
Subject: microphone recording got lower or higher tune than
	standard - 1
Date: Fri, 27 Dec 2013 14:12:18 +0800
Message-ID: <tencent_58E274C72C56B2A04CF97D46@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbgjp2.qq.com (smtpbgjp2.qq.com [54.238.162.12])
 by alsa0.perex.cz (Postfix) with SMTP id 5602D261A32
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2013 07:12:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello, you all!

sorry I have to repost the message by spliting in three ones as the original size is a bit too big  to be passed.

I am facing a strange problem on our arm-based box   runnig ubuntu.

firstly the following tests worked fine:

arecord -f S16_LE -D plughw:0,0 -r 8000 | aplay -f S16_LE -D plughw:0,0 -r 8000
arecord -f S16_LE -D plughw:0,0 -r 16000 | aplay -f S16_LE -D plughw:0,0 -r 16000
an so on up to 32k,44k,48k., and for c1, c2

but  using Mumble's Audio Tuninf Wizard to test speaker, I could only hear  my voice with very lower tune than my normal, and when I use Linphone to do  the same test I heard my voice with very higher tune than standard.

in Mumble's test I used the following setting:

Audio Tuninf Wizard:
input Device
This is the device your microphone is connectedto.
System:
ALSA
Device:
[hw:CARD=AMLCS42L52,DEV=] AML-CS42L52, Direct hardware device without any conversions
or
[hw:CARD=AMLCS42L52,DEV=] AML-CS42L52, Direct hardware device with all software conversions

if I select any Pulse options I could hear nothing except choppy sounds.

I am puzzled if the problem is in kernel driver or alsa or pulseaudio? any advice appreciated.

#these are my alsa-info:
----------------------------------------------------------------------------------------------
upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.62
!!################################

!!Script ran on: Fri Dec 27 02:58:19 UTC 2013


!!Linux Distribution
!!------------------




!!DMI Information
!!---------------

Manufacturer:      
Product Name:      
Product Version:   
Firmware Version:  


!!Kernel Information
!!------------------

Kernel release:    3.0.50-svn2
Operating System:  GNU/Linux
Architecture:      armv7l
Processor:         armv7l
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [AMLCS42L52     ]: SOC-Audio - AML-CS42L52
                      AML-CS42L52


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-caiaq: index=-2
snd-usb-ua101: index=-2
snd-usb-us122l: index=-2
snd-usb-usx2y: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388
snd-pcsp: index=-2
snd-usb-audio: index=-2


!!Loaded sound module options
!!---------------------------


!!ALSA Device nodes
!!-----------------

crw-rw---T+ 1 root audio 116,  0 Dec 27 10:57 /dev/snd/controlC0
crw-rw---T+ 1 root audio 116, 24 Dec 27 10:57 /dev/snd/pcmC0D0c
crw-rw---T+ 1 root audio 116, 16 Dec 27 10:57 /dev/snd/pcmC0D0p
crw-rw---T+ 1 root audio 116, 33 Dec 27 10:57 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Dec 27 10:57 .
drwxr-xr-x 3 root root 140 Dec 27 10:57 ..
lrwxrwxrwx 1 root root  12 Dec 27 10:57 platform-soc-audio -> ../controlC0


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

pcm.convert_mic {
    type route
    slave {
        pcm "plughw:0"
        channels 2
    }
    ttable {
        0 {
            1 1.0
            1 1.0
        }
    }
}

pcm.!default {
    type asym
    playback {
        pcm "plughw:0"
    }
    capture {
        pcm "convert_mic"
    }
}


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: AMLCS42L52 [AML-CS42L52], device 0: CS42L52 PCM cs42l52-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: AMLCS42L52 [AML-CS42L52], device 0: CS42L52 PCM cs42l52-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [AMLCS42L52]

Card hw:0 'AMLCS42L52'/'AML-CS42L52'
  Mixer name    : ''
  Components    : ''
  Controls      : 79
  Simple ctrls  : 76
Simple mixer control 'Master',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 176
  Front Left: 0 [0%] [-102.00dB]
  Front Right: 0 [0%] [-102.00dB]
Simple mixer control 'Headphone',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 152
  Front Left: 0 [0%] [-99999.99dB]
  Front Right: 0 [0%] [-99999.99dB]
Simple mixer control 'Headphone Analog Gain',0
  Capabilities: enum
  Items: '0.3959' '0.4571' '0.5111' '0.6047' '0.7099' '0.8399' '1.000' '1.1430'
  Item0: '1.000'
Simple mixer control 'Speaker',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 254
  Front Left: 127 [50%] [-38.50dB]
  Front Right: 127 [50%] [-38.50dB]
Simple mixer control 'Tone Control',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Bass Gain',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%] [-94.50dB]
Simple mixer control 'Treble Gain',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%] [-94.50dB]
Simple mixer control 'PCM Left Swap',0
  Capabilities: enum
  Items: 'Left' 'LR 2' 'Right'
  Item0: 'Left'
Simple mixer control 'PCM Mixer',0
  Capabilities: volume pswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - -102
  Front Left: 1 [-1%] [-101.50dB] Playback [on]
  Front Right: 1 [-1%] [-101.50dB] Playback [on]
Simple mixer control 'PCM Right Swap',0
  Capabilities: enum
  Items: 'Right' 'LR 2' 'Left'
  Item0: 'Right'
Simple mixer control 'Beep',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 31 [100%] [-86.50dB]
Simple mixer control 'Beep Bass Corner Freq',0
  Capabilities: enum
  Items: '50 Hz' '100 Hz' '200 Hz' '250 Hz'
  Item0: '50 Hz'
Simple mixer control 'Beep Config',0
  Capabilities: enum
  Items: 'Off' 'Single' 'Multiple' 'Continuous'
  Item0: 'Off'
Simple mixer control 'Beep Mixer',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Beep Pitch',0
  Capabilities: enum
  Items: 'C4' 'C5' 'D5' 'E5' 'F5' 'G5' 'A5' 'B5' 'C6' 'D6' 'E6' 'F6' 'G6' 'A6' 'B6' 'C7'
  Item0: 'C4'
Simple mixer control 'Beep Treble Corner Freq',0
  Capabilities: enum
  Items: '5 kHz' '7 kHz' '10 kHz' ' 15 kHz'
  Item0: '5 kHz'
Simple mixer control 'Beep off Time',0
  Capabilities: enum
  Items: '1.23 s' '2.58 s' '3.90 s' '5.20 s' '6.60 s' '8.05 s' '9.35 s' '10.80 s'
  Item0: '1.23 s'
Simple mixer control 'Beep on Time',0
  Capabilities: enum
   Items: '86 ms' '430 ms' '780 ms' '1.20 s' '1.50 s' '1.80 s' '2.20 s'  '2.50 s' '2.80 s' '3.20 s' '3.50 s' '3.80 s' '4.20 s' '4.50 s' '4.80 s'  '5.20 s'
  Item0: '86 ms'
Simple mixer control 'ADC',0
  Capabilities: volume pswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 32
  Front Left: 8 [25%] [-88.00dB] Playback [off]
  Front Right: 8 [25%] [-88.00dB] Playback [off]
Simple mixer control 'ADC Left Mux',0
  Capabilities: enum
  Items: 'Input1A' 'Input2A' 'Input3A' 'Input4A' 'PGA Input Left'
  Item0: 'PGA Input Left'
Simple mixer control 'ADC Left Swap',0
  Capabilities: enum
  Items: 'Left' 'LR 2' 'Right'
  Item0: 'Left'
Simple mixer control 'ADC Mixer',0
  Capabilities: volume pswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - -102
  Front Left: 1 [-1%] [-95.00dB] Playback [off]
  Front Right: 1 [-1%] [-95.00dB] Playback [off]
Simple mixer control 'ADC Right Mux',0
  Capabilities: enum
  Items: 'Input1B' 'Input2B' 'Input3B' 'Input4B' 'PGA Input Right'
  Item0: 'PGA Input Right'
Simple mixer control 'ADC Right Swap',0
  Capabilities: enum
  Items: 'Right' 'LR 2' 'Left'
  Item0: 'Right'
Simple mixer control 'ALC',0
  Capabilities: cswitch penum
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'ALC Attack Rate',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 63
  Mono: 0 [0%] [-30.00dB]
Simple mixer control 'ALC Max Threshold',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 1 [14%] [-24.00dB]
Simple mixer control 'ALC Min Threshold',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 7 [100%] [0.00dB]
Simple mixer control 'ALC Release Rate',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 63
  Mono: 63 [100%]
Simple mixer control 'ALC SR',0
  Capabilities: cswitch penum
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'ALC ZC',0
  Capabilities: cswitch penum
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Analog SR',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Analog ZC',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Batt Compensation',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Batt VP Monitor',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Batt VP ref',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'Bypass',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 120
  Front Left: 40 [33%] [14.00dB]
  Front Right: 40 [33%] [14.00dB]
Simple mixer control 'Bypass Left',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Bypass Mute',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Bypass Right',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Deemphasis',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital SR',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Digital ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'HP Left Amp',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP Right Amp',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HPF',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Limiter',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Limiter Attack Rate',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 63
  Mono: 0 [0%] [-30.00dB]
Simple mixer control 'Limiter Cushion Threshold',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-30.00dB]
Simple mixer control 'Limiter Max Threshold',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-30.00dB]
Simple mixer control 'Limiter Release Rate',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 63
  Mono: 63 [100%]
Simple mixer control 'Limiter SR',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Limiter ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'MIC Bias Level',0
  Capabilities: enum
  Items: '0.5 +VA' '0.6 +VA' '0.7 +VA' '0.8 +VA' '0.83 +VA' '0.91 +VA'
  Item0: '0.5 +VA'
Simple mixer control 'MIC Gain',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 16
  Front Left: 0 [0%] [16.00dB]
  Front Right: 0 [0%] [16.00dB]
Simple mixer control 'MICA Mux',0
  Capabilities: enum
  Items: 'Single' 'Differential'
  Item0: 'Single'
Simple mixer control 'MICB Mux',0
  Capabilities: enum
  Items: 'Single' 'Differential'
  Item0: 'Single'
Simple mixer control 'NG Boost',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'NG Delay',0
  Capabilities: enum
  Items: '50ms' '100ms' '150ms' '200ms'
  Item0: '50ms'
Simple mixer control 'NG Enable',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'NG Threshold',0
  Capabilities: enum
  Items: '-34dB' '-37dB' '-40dB' '-43dB' '-46dB' '-52dB' '-58dB' '-64dB'
  Item0: '-34dB'
Simple mixer control 'NG Type',0
  Capabilities: enum
  Items: 'Apply Specific' 'Apply All'
  Item0: 'Apply Specific'
Simple mixer control 'Output Mux',0
  Capabilities: enum
  Items: 'ADC' 'DSP'
  Item0: 'ADC'
Simple mixer control 'PGA',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 8
  Front Left: 0 [0%] [-6.00dB]
  Front Right: 0 [0%] [-6.00dB]
Simple mixer control 'PGA AIN1L',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN1R',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN2L',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN2R',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN3L',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN3R',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN4L',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA AIN4R',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PGA MICA',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PGA MICB',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'SPK Left Amp',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'SPK Right Amp',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!--------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module


!!ALSA/HDA dmesg
!!--------------

[    0.607134@0] register tv module server ok 
[    0.611486@0] HDMI DEBUG: amhdmitx_init [1771]
[    0.615831@0] HDMI DEBUG: amhdmitx_probe [1581]
[    0.620652@1] Set HDMI:Chip C
[    0.623486@1] HDMI DEBUG: HDMITX_M1B_Init [3329]
[    0.627882@1] HDMI DEBUG: HDMITX_M1B_Init [3332]
[    0.632497@1] HDMI DEBUG: hdmi_hw_init [1222]
[    0.632503@0] HDMI: get hdmi platform data
[    0.632508@0] HDMI 5V Power On
[    0.635069@0] ------------[ cut here ]------------
--
[    0.786779@0] cfg80211: Calling CRDA to update world regulatory domain
[    0.787136@1] HDMI: get brd phy data
[    0.787142@1] hdmi phy setting
[    0.787211@1] HDMI: get brd phy data
[    0.787214@1] hdmi phy setting
[    0.788020@1] HDMI: reset intr mask
[    0.791243@1] Switched to NOHz mode on CPU #1
[    0.806787@1] HDMI DEBUG: hdmi_task_handle [1216]
[    0.818857@0] Switched to NOHz mode on CPU #0
--
[    6.413727@0] aml_hw_crypto initialization.
[    6.418996@0] ***Entered sound/soc/codecs/cs42l52.c:cs42l52_modinit
[    6.424078@0] ***Entered sound/soc/codecs/cs42l52.c:cs42l52_i2c_probe
[    6.430501@0] ***cs42l52 reset***
[    6.464886@0] enter aml_dai_probe
[    6.465038@0] ***Entered sound/soc/aml/aml_m6_cs42l52.c:m6_codec_audio_probe
[    6.466738@0] ***Entered sound/soc/codecs/cs42l52.c:cs42l52_probe
[    6.495203@0] cs42l52 1-004a: Failed to add route MIC IN->Mic Bias
--
[    6.525362@0] asoc: cs42l52 <-> aml-dai0 mapping ok
[    6.532326@0] ALSA device list:
[    6.533331@0]   #0: AML-CS42L52
--
[   11.911917@0] 
[   11.911952@0] HDMITX: HDCP disable
[   11.911982@0] HDMI: reset IP: 0x10
[   11.911994@0] TV mode VGA_1280X720 selected.
--
[   11.912331@0]  set ok
[   11.912345@0] HDMI: get current mode: VGA_1280x720
[   11.912366@0] set mode VIC 4 (cd0,cs0,pm1,vd0,1) 
[   11.912373@0] HDMI DEBUG: hdmi_hw_reset [1395]
[   11.912392@0] HDMI: get brd phy data
[   11.912398@0] hdmi phy setting
[   11.913597@0] HDMI: get brd phy data
[   11.913610@0] hdmi phy setting
[   11.913695@0] HDMI DEBUG: hdmitx_set_pll [2069]
[   11.913703@0] param->VIC:4
--
[   11.917944@1] audio sample rate: 0
[   11.917949@1] HDMI: reset audio N para
[   11.917969@1] PCM out to HDMI
[   11.921776@0] set_vout_mode[179]
[   11.945810@1] Time out: AIU_HDMI_CLK_DATA_CTRL
[   11.978499@1] Time out: AIU_HDMI_CLK_DATA_CTRL
[   11.978517@1] Enable audio spdif to HDMI
[   11.978659@1] HDMI: set audio param
[   12.134549@1] Ethernet Driver ioctl (8947)

----------------------------------------------------------------------------------------
and my /proc/asound/card0/xxx follows this mesage -1 with seq. message -2
