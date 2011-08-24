From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Report by PulseAudio: `alsa-sink.c: We were woken up
 with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
 another value < min_avail.`
Date: Wed, 24 Aug 2011 13:35:59 +0200
Message-ID: <1314185760.3628.30.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4202702749806582265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 257B1103911
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 13:36:02 +0200 (CEST)
Received: from f053036225.adsl.alicedsl.de ([78.53.36.225]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QwBkb-0006Hf-R2
	for alsa-devel@alsa-project.org; Wed, 24 Aug 2011 11:36:06 +0000
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


--===============4202702749806582265==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-VRtqRyO+MAXFpyWsFdDO"


--=-VRtqRyO+MAXFpyWsFdDO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA developers,


I got the following messages in `/var/log/syslog`.

        Aug 24 09:29:05 doe pulseaudio[2735]: core-util.c: Home directory /=
etc/timidity not ours.
        Aug 24 09:29:05 doe pulseaudio[2735]: lock-autospawn.c: Cannot acce=
ss autospawn lock.
        Aug 24 09:29:05 doe pulseaudio[2735]: main.c: Failed to acquire aut=
ospawn lock

        Aug 24 13:00:33 doe pulseaudio[3118]: alsa-sink.c: ALSA woke us up =
to write new data to the device, but there was actually nothing to write!
        Aug 24 13:00:33 doe pulseaudio[3118]: alsa-sink.c: Most likely this=
 is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to t=
he ALSA developers.
        Aug 24 13:00:33 doe pulseaudio[3118]: alsa-sink.c: We were woken up=
 with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or ano=
ther value < min_avail.

Additionally I am seeing the a lot of the following messages in the
kernel ring buffer (`dmesg`)

        [14293.422591] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
f0004
        [14293.422612] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
f0004
        [14293.422633] hda-intel: spurious response 0xe0160:0x0, last cmd=
=3D0x1f0004
        [14293.422653] hda-intel: spurious response 0x1:0x0, last cmd=3D0x1=
f0004
        [14293.422675] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
f0004
        [14293.422695] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1=
f0004
        [14293.422716] hda-intel: spurious response 0x20025:0x0, last cmd=
=3D0x1f0004

but I do not know if this is related. I am using the Debian Linux kernel
2.6.32 which includes all longterm patches up to 2.6.32.40.

So only the ALSA drivers version 1.0.21 are used. Is there a commit that
addresses the above behavior and which could be backported?

Please find the output of `alsa-info.sh` [1] at the end.


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug


!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Wed Aug 24 11:24:45 UTC 2011


!!Linux Distribution
!!------------------

Debian GNU/Linux wheezy/sid \n \l


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version


!!Kernel Information
!!------------------

Kernel release:    2.6.32-5-amd64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.24.1
Utilities version:  1.0.24.2


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

aRts:
      Installed - Yes (/usr/bin/artsd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [VT82xx         ]: HDA-Intel - HDA VIA VT82xx
                      HDA VIA VT82xx at 0xfbffc000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

20:01.0 Audio device: VIA Technologies, Inc. VT1708/A [Azalia HDAC] (VIA Hi=
gh Definition Audio Controller) (rev 10)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

20:01.0 0403: 1106:3288 (rev 10)
	Subsystem: 1043:8290


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2
snd-usb-audio: index=3D-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : 0
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>=
,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NUL=
L>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<N=
ULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NU=
LL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<=
NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>=
,<NULL>
	patch : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NU=
LL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<=
NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>=
,<NULL>
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N=
,N
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC662 rev1
Address: 0
Function Id: 0x1
Vendor Id: 0x10ec0662
Subsystem Id: 0x10438290
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Invalid AFG subtree
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 9 Aug 24 09:27 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 8 Aug 24 09:27 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 7 Aug 24 09:27 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 6 Aug 24 13:07 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 5 Aug 24 09:27 /dev/snd/pcmC0D1c
crw-rw----+ 1 root audio 116, 4 Aug 24 09:27 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116, 3 Aug 24 09:27 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 Aug 24 09:27 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug 24 09:27 .
drwxr-xr-x 3 root root 220 Aug 24 09:27 ..
lrwxrwxrwx 1 root root  12 Aug 24 09:27 pci-0000:20:01.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

pcm.pulse {
    type pulse
}
=20
ctl.pulse {
    type pulse
}
=20
pcm.!default {
    type pulse
}
ctl.!default {
    type pulse
}


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC662 rev1 Analog [ALC662 rev1 =
Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 1: ALC662 rev1 Digital [ALC662 rev1=
 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC662 rev1 Analog [ALC662 rev1 =
Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 1: ALC662 rev1 Digital [ALC662 rev1=
 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [VT82xx]

Card hw:0 'VT82xx'/'HDA VIA VT82xx at 0xfbffc000 irq 17'
  Mixer name	: 'Realtek ALC662 rev1'
  Components	: 'HDA:10ec0662,10438290,00100101'
  Controls      : 37
  Simple ctrls  : 20
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 63 [98%] [-1.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 254 [100%] [0.20dB]
  Front Right: Playback 254 [100%] [0.20dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 20 [65%] [-4.50dB] [on]
  Front Right: Playback 20 [65%] [-4.50dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 16 [52%] [-10.50dB] [on]
  Front Right: Playback 16 [52%] [-10.50dB] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-9.00dB] [on]
  Front Right: Playback 17 [55%] [-9.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-9.00dB] [on]
  Front Right: Playback 17 [55%] [-9.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 24 [77%] [22.50dB] [on]
  Front Right: Capture 24 [77%] [22.50dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 9 [29%] [0.00dB] [off]
  Front Right: Capture 9 [29%] [0.00dB] [off]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 66 [55%] [3.00dB]
  Front Right: Capture 66 [55%] [3.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'


!!Alsactl output
!!-------------

--startcollapse--
state.VT82xx {
	control.1 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Center Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface MIXER
		name 'LFE Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.10 {
		iface MIXER
		name 'CD Playback Volume'
		value.0 17
		value.1 17
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -900
			dbvalue.1 -900
		}
	}
	control.11 {
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.12 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 16
		value.1 16
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -1050
			dbvalue.1 -1050
		}
	}
	control.13 {
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
	control.14 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 17
		value.1 17
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -900
			dbvalue.1 -900
		}
	}
	control.15 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.16 {
		iface MIXER
		name 'Front Mic Playback Volume'
		value.0 20
		value.1 20
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -450
			dbvalue.1 -450
		}
	}
	control.17 {
		iface MIXER
		name 'Front Mic Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.18 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '6ch'
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.21 {
		iface MIXER
		name 'Capture Volume'
		value.0 24
		value.1 24
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1350
			dbmax 3300
			dbvalue.0 2250
			dbvalue.1 2250
		}
	}
	control.22 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 9
		value.1 9
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -1350
			dbmax 3300
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.23 {
		iface MIXER
		name 'Input Source'
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Front Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.24 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Front Mic'
			item.2 Line
			item.3 CD
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff00000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f0000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.27 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '040000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Capture Default'
		value '040000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'Beep Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.33 {
		iface MIXER
		name 'Beep Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.34 {
		iface MIXER
		name 'Master Playback Volume'
		value 63
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 -100
		}
	}
	control.35 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 254
		value.1 254
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -20
			dbvalue.1 -20
		}
	}
	control.37 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 66
		value.1 66
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 300
			dbvalue.1 300
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
binfmt_misc
via
drm
ip6table_filter
ip6_tables
iptable_filter
ip_tables
x_tables
powernow_k8
cpufreq_conservative
cpufreq_userspace
cpufreq_stats
cpufreq_powersave
reiserfs
xfs
exportfs
fuse
kvm_amd
kvm
loop
firewire_sbp2
firewire_core
crc_itu_t
snd_hda_codec_realtek
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_midi
snd_rawmidi
snd_seq_midi_event
snd_seq
snd_timer
snd_seq_device
amd64_edac_mod
snd
psmouse
evdev
edac_core
parport_pc
soundcore
i2c_viapro
parport
snd_page_alloc
k8temp
asus_atk0110
shpchp
edac_mce_amd
serio_raw
i2c_core
pci_hotplug
processor
button
ext3
jbd
mbcache
sha256_generic
aes_x86_64
aes_generic
cbc
dm_crypt
dm_mod
raid1
md_mod
sg
usbhid
hid
sr_mod
cdrom
sd_mod
crc_t10dif
ata_generic
uhci_hcd
pata_via
ehci_hcd
sata_via
libata
thermal
thermal_sys
via_rhine
mii
usbcore
nls_base
scsi_mod


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x14 0x01014010
0x15 0x411111f0
0x16 0x411111f0
0x18 0x01a19840
0x19 0x02a19950
0x1a 0x0181304f
0x1b 0x02214120
0x1c 0x593301f0
0x1d 0x4005c603
0x1e 0x99430130

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   38.078771]   alloc kstat_irqs on node 0
[   38.078780] HDA Intel 0000:20:01.0: PCI INT A -> GSI 17 (level, low) -> =
IRQ 17
[   38.078848] HDA Intel 0000:20:01.0: setting latency timer to 64
[   38.078852] HDA Intel 0000:20:01.0: PCI: Disallowing DAC for device
[   38.165465] input: HDA Digital PCBeep as /devices/pci0000:20/0000:20:01.=
0/input/input5
[   38.229088] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i804=
2/serio1/input/input6
--
[  146.194407] ioctl32(Xorg:2515): Unknown cmd fd(11) cmd(c0246400){t:'d';s=
z:36} arg(08665f10) on /dev/dri/card0
[  185.172076] hda-intel: IRQ timing workaround is activated for card #0. S=
uggest a bigger bdl_pos_adj.
[  327.111398] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[  337.652026] eth0: no IPv6 routers present
[14293.421429] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421447] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421467] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421488] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421509] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421530] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421550] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421571] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421592] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421613] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421634] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421655] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421677] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421695] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421716] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421737] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421758] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421778] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421799] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421820] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421841] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421861] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421882] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421903] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421924] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421945] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421965] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.421987] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422007] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422028] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422049] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422070] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422090] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422112] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422132] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422153] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422174] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422195] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422216] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422236] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422257] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422280] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422300] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422321] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422342] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422363] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422384] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422405] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422425] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422446] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422467] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422488] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422507] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422528] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422549] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422570] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422591] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422612] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422633] hda-intel: spurious response 0xe0160:0x0, last cmd=3D0x1f000=
4
[14293.422653] hda-intel: spurious response 0x1:0x0, last cmd=3D0x1f0004
[14293.422675] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422695] hda-intel: spurious response 0x0:0x0, last cmd=3D0x1f0004
[14293.422716] hda-intel: spurious response 0x20025:0x0, last cmd=3D0x1f000=
4

--=-VRtqRyO+MAXFpyWsFdDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5U4h8ACgkQPX1aK2wOHVhReACdFksr3vTze07Rgn5ll9YZAlwS
9P0AoIwzHb5UN9loVjvy1x/fmRJ3Fah1
=9+Gu
-----END PGP SIGNATURE-----

--=-VRtqRyO+MAXFpyWsFdDO--


--===============4202702749806582265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4202702749806582265==--
