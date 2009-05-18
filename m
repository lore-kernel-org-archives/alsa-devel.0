From: "Michael (Micksa) Slade" <mslade@knobbits.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 18 May 2009 20:10:46 +1000
Message-ID: <4A113426.10102@knobbits.org>
References: <s5h4ovovtwe.wl%tiwai@suse.de>	<s5h7i0i9yng.wl%tiwai@suse.de>	<4A0E88A4.2030206@knobbits.org>	<s5h7i0h84sh.wl%tiwai@suse.de>	<4A10D968.8040108@knobbits.org>
	<s5h7i0feyta.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080400030908060701070702"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from killface.knobbits.org (killface.knobbits.org [67.18.208.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 6098D2435A
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 12:10:56 +0200 (CEST)
In-Reply-To: <s5h7i0feyta.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Michael (Micksa) Slade" <micksa@knobbits.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080400030908060701070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> Could you run alsa-info.sh with --no-upload option, and attach the
>     generated file?  The script is found at
>     http://www.alsa-project.org/alsa-info.sh
>
>   
Attached.

Mick.


--------------080400030908060701070702
Content-Type: text/plain;
 name="mickpc-alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mickpc-alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Mon May 18 10:07:32 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu 9.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 9.04"


!!Kernel Information
!!------------------

Kernel release:    2.6.28-11-generic
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
snd_usb_audio
snd_usb_audio


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [XFi            ]: SB-XFi - Creative X-Fi
                      Creative ALSA Driver X-Fi
 1 [Cable          ]: USB-Audio - USB Midi Cable
                      USB Midi Cable at usb-0000:00:12.2-3.1, full speed
 2 [PCR            ]: USB-Audio - PCR
                      EDIROL PCR at usb-0000:00:12.2-3.2, full speed


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
02:00.0 Audio device: Creative Labs [X-Fi Titanium series] EMU20k2 (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1458:a022
--
02:00.0 0403: 1102:000b (rev 03)
	Subsystem: 1102:0043


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
multiple : 2
reference_rate : 48000

!!Module: snd_usb_audio
async_unlink : Y
device_setup : 0,0,0,0,0,0,0,0
devpath : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
enable : Y,Y,Y,Y,Y,Y,Y,Y
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
ignore_ctl_error : N
index : -2,-1,-1,-1,-1,-1,-1,-1
nrpacks : 8
pid : -1,-1,-1,-1,-1,-1,-1,-1
vid : -1,-1,-1,-1,-1,-1,-1,-1

!!Module: snd_usb_audio
async_unlink : Y
device_setup : 0,0,0,0,0,0,0,0
devpath : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
enable : Y,Y,Y,Y,Y,Y,Y,Y
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
ignore_ctl_error : N
index : -2,-1,-1,-1,-1,-1,-1,-1
nrpacks : 8
pid : -1,-1,-1,-1,-1,-1,-1,-1
vid : -1,-1,-1,-1,-1,-1,-1,-1


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 May 18 20:03 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 32 May 16 16:27 /dev/snd/controlC1
crw-rw----+ 1 root audio 116, 64 May 15 19:36 /dev/snd/controlC2
crw-rw----+ 1 root audio 116, 40 May 16 16:27 /dev/snd/midiC1D0
crw-rw----+ 1 root audio 116, 72 May 15 19:36 /dev/snd/midiC2D0
crw-rw----+ 1 root audio 116, 24 May 18 20:03 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 May 18 20:04 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 17 May 18 20:03 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116, 18 May 18 20:03 /dev/snd/pcmC0D2p
crw-rw----+ 1 root audio 116, 19 May 18 20:03 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116, 20 May 18 20:03 /dev/snd/pcmC0D4p
crw-rw----+ 1 root audio 116,  1 May 15 19:36 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 May 15 19:36 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: XFi [Creative X-Fi], device 0: Front/WaveIn [Front/WaveIn]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 1: Rear [Rear]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 2: Center/LFE [Center/LFE]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 3: Surround [Surround]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: XFi [Creative X-Fi], device 4: IEC958 Non-audio [IEC958 Non-audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: XFi [Creative X-Fi], device 0: Front/WaveIn [Front/WaveIn]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [XFi]

Card hw:0 'XFi'/'Creative ALSA Driver X-Fi'
  Mixer name	: '20K2'
  Components	: ''
  Controls      : 29
  Simple ctrls  : 10
Simple mixer control 'Master',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43690 Capture 0 - 43690
  Front Left: Playback 21845 [50%] Capture 34913 [80%]
  Front Right: Playback 21845 [50%] Capture 34913 [80%]
Simple mixer control 'PCM',0
  Capabilities: pvolume cvolume cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43690 Capture 0 - 43690
  Front Left: Playback 34461 [79%] Capture 34913 [80%] [on]
  Front Right: Playback 34461 [79%] Capture 34913 [80%] [on]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43690
  Mono:
  Front Left: Playback 34913 [80%] [on]
  Front Right: Playback 34913 [80%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43690
  Mono:
  Front Left: Playback 32525 [74%] [off]
  Front Right: Playback 32525 [74%] [off]
Simple mixer control 'Center/LFE',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43690
  Mono:
  Front Left: Playback 32525 [74%] [off]
  Front Right: Playback 32525 [74%] [off]
Simple mixer control 'Line-in',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43690 Capture 0 - 43690
  Front Left: Playback 32525 [74%] [off] Capture 32525 [74%] [on]
  Front Right: Playback 32525 [74%] [off] Capture 32525 [74%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume cvolume cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43690 Capture 0 - 43690
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'Rear',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43690
  Mono:
  Front Left: Playback 32525 [74%] [off]
  Front Right: Playback 32525 [74%] [off]
Simple mixer control 'S/PDIF-in',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 43690 Capture 0 - 43690
  Front Left: Playback 32525 [74%] [off] Capture 32525 [74%] [on]
  Front Right: Playback 32525 [74%] [off] Capture 32525 [74%] [on]
Simple mixer control 'S/PDIF-out',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 43690
  Mono:
  Front Left: Playback 32525 [74%] [off]
  Front Right: Playback 32525 [74%] [off]

!!-------Mixer controls for card 1 [Cable]

Card hw:1 'Cable'/'USB Midi Cable at usb-0000:00:12.2-3.1, full speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB15ca:0101'
  Controls      : 0
  Simple ctrls  : 0

!!-------Mixer controls for card 2 [PCR]

Card hw:2 'PCR'/'EDIROL PCR at usb-0000:00:12.2-3.2, full speed'
  Mixer name	: ''
  Components	: 'USB0582:0033'
  Controls      : 0
  Simple ctrls  : 0


!!Alsactl output
!!-------------

--startcollapse--
state.XFi {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Master Playback Volume'
		value.0 21845
		value.1 21845
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'PCM Playback Volume'
		value.0 34461
		value.1 34461
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Line-in Playback Volume'
		value.0 32525
		value.1 32525
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'S/PDIF-in Playback Volume'
		value.0 32525
		value.1 32525
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'S/PDIF-out Playback Volume'
		value.0 32525
		value.1 32525
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Front Playback Volume'
		value.0 34913
		value.1 34913
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Rear Playback Volume'
		value.0 32525
		value.1 32525
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Center/LFE Playback Volume'
		value.0 32525
		value.1 32525
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Surround Playback Volume'
		value.0 32525
		value.1 32525
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Master Capture Volume'
		value.0 34913
		value.1 34913
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'PCM Capture Volume'
		value.0 34913
		value.1 34913
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Line-in Capture Volume'
		value.0 32525
		value.1 32525
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43690 (step 128)'
		iface MIXER
		device 5
		name 'S/PDIF-in Capture Volume'
		value.0 32525
		value.1 32525
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'PCM Capture Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Line-in Capture Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Mic Capture Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'S/PDIF-in Capture Switch'
		value true
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Line-in Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'S/PDIF-out Playback Switch'
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'S/PDIF-in Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Front Playback Switch'
		value true
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Rear Playback Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Center/LFE Playback Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		device 5
		name 'Surround Playback Switch'
		value false
	}
	control.27 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 4
		name 'IEC958 Playback Mask'
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.28 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 4
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.29 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 4
		name 'IEC958 Playback PCM Stream'
		value '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
}
state.Cable {
	control {
	}
}
state.PCR {
	control {
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_ctxfi
isofs
udf
crc_itu_t
nfs
lockd
nfs_acl
sunrpc
binfmt_misc
bridge
stp
bnep
video
output
input_polldev
nls_iso8859_1
nls_cp437
vfat
fat
lp
snd_hda_codec_ca0110
snd_hda_codec_realtek
snd_usb_audio
snd_usb_lib
snd_seq_dummy
snd_seq_oss
snd_hda_codec
snd_pcm_oss
snd_mixer_oss
snd_seq_midi
snd_rawmidi
snd_seq_midi_event
ppdev
snd_seq
snd_hwdep
snd_pcm
parport_pc
i2c_piix4
pcspkr
snd_timer
snd_seq_device
snd_page_alloc
parport
psmouse
k8temp
nvidia
serio_raw
snd
soundcore
ohci1394
ieee1394
r8169
mii
fbcon
tileblit
font
bitblit
softcursor



--------------080400030908060701070702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080400030908060701070702--
