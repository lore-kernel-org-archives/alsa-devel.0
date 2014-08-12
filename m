From: jon <jon@seniorblanco.com>
Subject: trouble using S/PDIF input on CMI8738-MC6: C-Media
 CMI8738 (model 55)
Date: Tue, 12 Aug 2014 09:29:31 -0700
Message-ID: <53EA40EB.2060201@seniorblanco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thetis.seniorblanco.com
 (108-227-52-43.lightspeed.irvnca.sbcglobal.net [108.227.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B00872650FE
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 18:30:07 +0200 (CEST)
Received: from 108-227-52-42.lightspeed.irvnca.sbcglobal.net ([108.227.52.42]
 helo=[192.168.1.34])
 by thetis.seniorblanco.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <jon@seniorblanco.com>)
 id 1XHEuw-0000hf-8A
 for alsa-devel@alsa-project.org; Tue, 12 Aug 2014 09:27:33 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Greetings,

I hope I have sent this email to the correct list, I apologize if I am 
in error.

I have a somewhat antiquated motherboard (SOYO SY-K7V DRAGON Plus!) with 
an on-board soundcard using the cmipci driver.  Audio playback through 
the analog output jacks works, as does audio capture from the analog 
line-in jack.  I really would like to get either of the digital inputs 
to work for recording instead though (it has both optical and coaxial 
input *and* output jacks available on an optional breakout connector) 
however I have so far been unable to do so for either the coaxial or 
optical inputs even after having tested several different cables and 
external devices as audio sources.  Neither recording nor the "monitor" 
feature of either digital inputs works.  Unfortunately though I have no 
means by which to test the digital output other than to look into the 
end of a connected toslink cable and verify it indeed lights up.

Initially I suspected my alsamixer settings were simply wrong, however 
after extensive testing and searching I have begun to suspect that the 
driver is simply not properly recognizing the optional (apparently 
somewhat rare) extra i/o expansion header.  When I try to record from 
the digital input device, arecord outputs the status text, pauses for a 
few seconds and then spits out an i/o error.  Below, in sections divided 
by the "####" bars I have included what I hope is enough relevant 
information for someone knowledgeable to help me troubleshoot/fix this 
issue.  If information is missing I will happily provide it given 
instructions on how to find it.

########################################################################
Here is the arecord output:

$ arecord -v -v -D hw:0,2 -f dat test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, 
Stereo
Hardware PCM card 0 'C-Media CMI8738' device 2 subdevice 0
Its setup is:
   stream       : CAPTURE
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 16384
   period_size  : 4096
   period_time  : 85333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 4096
   period_event : 0
   start_threshold  : 1
   stop_threshold   : 16384
   silence_threshold: 0
   silence_size : 0
   boundary     : 1073741824
   appl_ptr     : 0
   hw_ptr       : 0
arecord: pcm_read:1801: read error: Input/output error
########################################################################
In case its relevant, here is the contents of the cmipci registry file 
before I run arecord:

~$ cat /proc/asound/card0/cmipci
C-Media CMI8738 (model 55) at 0xd000, irq 11

00: 02 00 00 00
04: 12 e0 00 00
08: 0c 00 09 00
0c: 00 00 00 08
10: c0 00 00 00
14: 00 00 00 00
18: 00 01 81 0a
1c: ff ff ff ff
20: 10 40 08 00
24: 00 01 00 00
90: 20 09 00 10

And here is its contents while arecord is "hanging" - after I start the 
arecord command but before it spits out the i/o error then exits:

$ cat /proc/asound/card0/cmipci
C-Media CMI8738 (model 55) at 0xd000, irq 11

00: 02 00 02 00
04: 12 e2 00 00
08: 0c 00 09 00
0c: 00 00 02 08
10: c0 00 00 00
14: 00 00 00 00
18: 00 01 01 0a
1c: ff ff ff ff
20: 10 40 08 00
24: 00 01 00 00
90: 20 09 00 10

The second contents are the same as while its successfully recording 
from the analog input.  After the i/o error it reverts to the previous 
contents, but the output is always a silent file of exactly 44 bytes 
which I assume to be the minimum size for an empty PCM WAV file.
########################################################################
And, last but not least, here is the output of the alsa-info.sh test 
script which I hope will contain everything else relevant.  Note that 
While the current kernel is version 3.12 (vanilla) with both the "#if 0" 
lines in the cmipci.c file changed to "#if 1", the behavior as I have 
tested it is basically unchanged with the exception of the appearance of 
some more S/PDIF switches in alsamixer, and also unchanged from the 
stock wheezy 3.2 kernel.

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.63
!!################################

!!Script ran on: Tue Aug 12 15:22:29 UTC 2014


!!Linux Distribution
!!------------------

Debian GNU/Linux 7 \n \l PRETTY_NAME="Debian GNU/Linux 7 (wheezy)" 
NAME="Debian GNU/Linux" ID=debian HOME_URL="http://www.debian.org/" 
SUPPORT_URL="http://www.debian.org/support/" 
BUG_REPORT_URL="http://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      VIA Technologies, Inc.
Product Name:      VT8366-8233
Product Version:
Firmware Version:  6.00 PG


!!Kernel Information
!!------------------

Kernel release:    3.12.0dionysus1
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     k3.12.0dionysus1
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------

snd_cmipci


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

  0 [CMI8738        ]: CMI8738-MC6 - C-Media CMI8738
                       C-Media CMI8738 (model 55) at 0xd000, irq 11


!!PCI Soundcards installed in the system
!!--------------------------------------

00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 Video 
Capture (rev 12)
00:0e.0 Multimedia audio controller: C-Media Electronics Inc 
CMI8738/CMI8768 PCI Audio (rev 10)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:0e.0 0401: 13f6:0111 (rev 10)
	Subsystem: 10fd:a701


!!Modprobe options (Sound related)
!!--------------------------------

snd_pcsp: index=-2
snd_usb_audio: index=-2
snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_cmipci: joystick_port=1


!!Loaded sound module options
!!---------------------------

!!Module: snd_cmipci
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	fm_port : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	id : 
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	joystick_port : 
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	mpu_port : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	soft_ac3 : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y


!!ALSA Device nodes
!!-----------------

crw-rw---T 1 root audio 116,  9 Aug 12 07:33 /dev/snd/controlC0
crw-rw---T 1 root audio 116,  8 Aug 12 07:33 /dev/snd/hwC0D0
crw-rw---T 1 root audio 116,  2 Aug 12 07:33 /dev/snd/midiC0D0
crw-rw---T 1 root audio 116,  7 Aug 12 07:50 /dev/snd/pcmC0D0c
crw-rw---T 1 root audio 116,  6 Aug 12 07:33 /dev/snd/pcmC0D0p
crw-rw---T 1 root audio 116,  5 Aug 12 07:33 /dev/snd/pcmC0D1p
crw-rw---T 1 root audio 116,  4 Aug 12 07:47 /dev/snd/pcmC0D2c
crw-rw---T 1 root audio 116,  3 Aug 12 07:33 /dev/snd/pcmC0D2p
crw-rw---T 1 root audio 116,  1 Aug 12 07:33 /dev/snd/seq
crw-rw---T 1 root audio 116, 33 Aug 12 07:33 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug 12 07:33 .
drwxr-xr-x 3 root root 260 Aug 12 07:33 ..
lrwxrwxrwx 1 root root  12 Aug 12 07:33 pci-0000:00:0e.0 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: CMI8738 [C-Media CMI8738], device 0: CMI8738-MC6 [C-Media PCI 
DAC/ADC]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: CMI8738 [C-Media CMI8738], device 1: CMI8738-MC6 [C-Media PCI 
2nd DAC]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: CMI8738 [C-Media CMI8738], device 2: CMI8738-MC6 [C-Media PCI 
IEC958]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: CMI8738 [C-Media CMI8738], device 0: CMI8738-MC6 [C-Media PCI 
DAC/ADC]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: CMI8738 [C-Media CMI8738], device 2: CMI8738-MC6 [C-Media PCI 
IEC958]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [CMI8738]

Card hw:0 'CMI8738'/'C-Media CMI8738 (model 55) at 0xd000, irq 11'
   Mixer name	: 'CMedia PCI'
   Components	: ''
   Controls      : 45
   Simple ctrls  : 25
Simple mixer control 'Master',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 31 [100%]
   Front Right: Playback 31 [100%]
Simple mixer control '3D Control - Switch',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'PCM',0
   Capabilities: pvolume pswitch pswitch-joined cswitch penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 31 [100%] [on] Capture [off]
   Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Synth',0
   Capabilities: pvolume pswitch pswitch-joined cswitch penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 26 [84%] [on] Capture [off]
   Front Right: Playback 26 [84%] [on] Capture [off]
Simple mixer control 'Line',0
   Capabilities: pvolume pswitch cswitch penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 17 [55%] [on] Capture [on]
   Front Right: Playback 17 [55%] [on] Capture [on]
Simple mixer control 'Line-In Mode',0
   Capabilities: enum
   Items: 'Line-In' 'Rear Output' 'Bass Output'
   Item0: 'Line-In'
Simple mixer control 'CD',0
   Capabilities: pvolume pswitch cswitch penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 0 [0%] [off] Capture [off]
   Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Mic',0
   Capabilities: pvolume pvolume-joined cvolume cvolume-joined pswitch 
pswitch-joined cswitch cswitch-joined penum
   Playback channels: Mono
   Capture channels: Mono
   Limits: Playback 0 - 31 Capture 0 - 7
   Mono: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Mic Boost',0
   Capabilities: pswitch pswitch-joined cswitch cswitch-joined penum
   Playback channels: Mono
   Capture channels: Mono
   Mono: Playback [off] Capture [off]
Simple mixer control 'Mic-In Mode',0
   Capabilities: enum
   Items: 'Mic-In' 'Center/LFE Output'
   Item0: 'Mic-In'
Simple mixer control 'Phone',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
   Limits: Playback 0 - 7
   Mono: Playback 0 [0%] [off]
Simple mixer control 'IEC958 5V',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Copyright',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 In Monitor',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 In Phase Inverse',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 In Record',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 In Select',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'IEC958 In Valid',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Loop',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Out',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Out To DAC',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Output',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Beep',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
   Limits: Playback 0 - 3
   Mono: Playback 1 [33%] [on]
Simple mixer control 'Aux',0
   Capabilities: pvolume pswitch cswitch penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 15
   Front Left: Playback 0 [0%] [off] Capture [off]
   Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Four Channel Mode',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]


!!Alsactl output
!!--------------

--startcollapse--
state.CMI8738 {
	control.1 {
		iface PCM
		device 2
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		comment {
			access read
			type INTEGER
			count 6
			range '0 - 36'
		}
	}
	control.2 {
		iface MIXER
		name 'Master Playback Volume'
		value.0 31
		value.1 31
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
		}
	}
	control.3 {
		iface MIXER
		name '3D Control - Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 31
		value.1 31
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
		}
	}
	control.5 {
		iface MIXER
		name 'PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface MIXER
		name 'PCM Capture Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.7 {
		iface MIXER
		name 'Synth Playback Volume'
		value.0 26
		value.1 26
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
		}
	}
	control.8 {
		iface MIXER
		name 'Synth Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'Synth Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
		comment {
			access 'read write'
			type BOOLEAN
			count 4
		}
	}
	control.10 {
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
		}
	}
	control.11 {
		iface MIXER
		name 'CD Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.12 {
		iface MIXER
		name 'CD Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
		comment {
			access 'read write'
			type BOOLEAN
			count 4
		}
	}
	control.13 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 17
		value.1 17
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
		}
	}
	control.14 {
		iface MIXER
		name 'Line Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.15 {
		iface MIXER
		name 'Line Capture Route'
		value.0 true
		value.1 false
		value.2 false
		value.3 true
		comment {
			access 'read write'
			type BOOLEAN
			count 4
		}
	}
	control.16 {
		iface MIXER
		name 'Mic Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
		}
	}
	control.17 {
		iface MIXER
		name 'Mic Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'Mic Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'Beep Playback Volume'
		value 1
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 3'
		}
	}
	control.20 {
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 15'
		}
	}
	control.21 {
		iface MIXER
		name 'Aux Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.22 {
		iface MIXER
		name 'Aux Capture Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.23 {
		iface MIXER
		name 'Mic Boost Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'Mic Capture Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.25 {
		iface MIXER
		name 'Phone Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
		}
	}
	control.26 {
		iface MIXER
		name 'Phone Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'Beep Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'Mic Boost Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'Four Channel Mode'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'Line-In Mode'
		value Line-In
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Line-In
			item.1 'Rear Output'
			item.2 'Bass Output'
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 In Record'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Out'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.33 {
		iface MIXER
		name 'IEC958 Out To DAC'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.34 {
		iface MIXER
		name 'IEC958 Output Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface MIXER
		name 'IEC958 In Valid'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface MIXER
		name 'IEC958 Copyright'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.37 {
		iface MIXER
		name 'IEC958 5V'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface MIXER
		name 'IEC958 Loop'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.39 {
		iface MIXER
		name 'IEC958 In Monitor'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.40 {
		iface PCM
		device 2
		name 'IEC958 Playback Default'
		value 
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.41 {
		iface PCM
		device 2
		name 'IEC958 Playback Con Mask'
		value 
ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.42 {
		iface PCM
		device 2
		name 'IEC958 Playback PCM Stream'
		value 
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write inactive'
			type IEC958
			count 1
		}
	}
	control.43 {
		iface MIXER
		name 'IEC958 In Select'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.44 {
		iface MIXER
		name 'IEC958 In Phase Inverse'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.45 {
		iface MIXER
		name 'Mic-In Mode'
		value Mic-In
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic-In
			item.1 'Center/LFE Output'
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
fuse
nfsd
auth_rpcgss
oid_registry
nfs_acl
nfs
lockd
fscache
sunrpc
reiserfs
it87
hwmon_vid
snd_pcm_oss
snd_mixer_oss
analog
ns558
loop
tuner_simple
tuner_types
tuner
tda7432
tvaudio
snd_cmipci
snd_mpu401_uart
snd_opl3_lib
snd_hwdep
snd_pcm
snd_page_alloc
msp3400
bttv
snd_seq_midi
snd_seq_midi_event
tveeprom
btcx_risc
videobuf_dma_sg
snd_rawmidi
videobuf_core
nouveau
i2c_viapro
via_ircc
rc_core
video
mxm_wmi
snd_seq
snd_timer
snd_seq_device
v4l2_common
wmi
snd
soundcore
ttm
videodev
drm_kms_helper
drm
psmouse
serio_raw
evdev
joydev
pcspkr
processor
media
i2c_algo_bit
i2c_core
thermal_sys
gameport
irda
button
crc_ccitt
ext4
crc16
jbd2
mbcache
sd_mod
sg
sr_mod
cdrom
crc_t10dif
crct10dif_common
ata_generic
hid_generic
usbhid
hid
pata_via
libata
uhci_hcd
ehci_hcd
via_rhine
mii
scsi_mod
usbcore
usb_common


!!ALSA/HDA dmesg
!!--------------
