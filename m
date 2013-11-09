From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] hda_intel: ratelimit "spurious
	response" message
Date: Fri, 08 Nov 2013 20:41:34 -0800
Message-ID: <1383972094.2860.2.camel@joe-AO722>
References: <1383854115.9263.21.camel@joe-AO722>
 <s5h61s4dkqs.wl%tiwai@suse.de> <1383856098.9263.28.camel@joe-AO722>
 <s5hwqkjrwg0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0068.hostedemail.com
 [216.40.44.68]) by alsa0.perex.cz (Postfix) with ESMTP id 8DC95261785
 for <alsa-devel@alsa-project.org>; Sat,  9 Nov 2013 05:41:53 +0100 (CET)
In-Reply-To: <s5hwqkjrwg0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(dropping lkml from cc's)

On Fri, 2013-11-08 at 11:59 +0100, Takashi Iwai wrote:
> At Thu, 07 Nov 2013 12:28:18 -0800,
> Joe Perches wrote:
> > On Thu, 2013-11-07 at 21:23 +0100, Takashi Iwai wrote:
> > > At Thu, 07 Nov 2013 11:55:15 -0800,
> > > Joe Perches wrote:
> > > > dmesg here has a 100+ consecutive lines of:
> > > > [ 1464.219446] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
> > > > [ 1464.219451] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
> > > > [ 1464.219454] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
> > > > ...
> > > > Ratelimit the message to reduce the dmesg log noise.
> > > > Coalesce the format while at it.
> > > Thanks, applied.
> > > BTW, which hardware shows this problem?
> > > I'm interested rather in that...
> > It's a little Acer netbook AO725
> > # lspci -v -v -s0:14.2
> > 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia Controller (rev 01)
> > 	Subsystem: Acer Incorporated [ALI] Device 0740
> Could you give alsa-info.sh output (maybe better to get it after
> applying your patch)?  It'll show more comprehensive information.

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.62
!!################################

!!Script ran on: Sat Nov  9 04:36:16 UTC 2013


!!Linux Distribution
!!------------------

Ubuntu 13.10 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 13.10" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu 13.10" HOME_URL="http://www.ubuntu.com/" SUPPORT_URL="http://help.ubuntu.com/" BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"


!!DMI Information
!!---------------

Manufacturer:      Acer
Product Name:      AO725
Product Version:   V2.12
Firmware Version:  V2.12


!!Kernel Information
!!------------------

Kernel release:    3.12.0
Operating System:  GNU/Linux
Architecture:      i686
Processor:         athlon
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.12.0
Library version:    1.0.27.2
Utilities version:  1.0.27.1


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xf0244000 irq 45


!!PCI Soundcards installed in the system
!!--------------------------------------

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Wrestler HDMI Audio
00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia Controller (rev 01)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:01.1 0403: 1002:1314
	Subsystem: 1025:0740
--
00:14.2 0403: 1022:780d (rev 01)
	Subsystem: 1025:0740


!!Modprobe options (Sound related)
!!--------------------------------

snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_usb_audio: index=-2
snd_usb_caiaq: index=-2
snd_usb_ua101: index=-2
snd_usb_us122l: index=-2
snd_usb_usx2y: index=-2
snd_cmipci: mpu_port=0x330 fm_port=0x388
snd_pcsp: index=-2
snd_usb_audio: index=-2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 1
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: ATI ID aa01
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100200
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Device: name="ID aa01 Digital", type="HDMI", device=3
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI Jack", index=0, device=0
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  4 Nov  8 20:34 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  6 Nov  8 20:36 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  3 Nov  8 20:34 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  5 Nov  8 20:36 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116,  2 Nov  8 20:35 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  1 Nov  8 20:34 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Nov  8 20:34 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Nov  8 20:36 .
drwxr-xr-x 3 root root 200 Nov  8 20:36 ..
lrwxrwxrwx 1 root root  12 Nov  8 20:34 pci-0000:00:01.1 -> ../controlC0
lrwxrwxrwx 1 root root  12 Nov  8 20:36 pci-0000:00:14.2 -> ../controlC1


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
}
pcm.!default {
    type pulse
}
ctl.!default {
    type pulse
}


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Generic [HD-Audio Generic], device 3: ID aa01 Digital [ID aa01 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Generic]

Card hw:0 'Generic'/'HD-Audio Generic at 0xf0244000 irq 45'
  Mixer name	: 'ATI ID aa01'
  Components	: 'HDA:1002aa01,00aa0100,00100200'
  Controls      : 6
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

!!-------Mixer controls for card 1 ]

Card hw:1 'Generic_1'/'HD-Audio Generic at 0xf0240000 irq 46'
  Mixer name	: 'Realtek ALC271X'
  Components	: 'HDA:10ec0269,10250740,00100100'
  Controls      : 21
  Simple ctrls  : 10
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 87
  Mono: Playback 0 [0%] [-65.25dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 87 [100%] [0.00dB] [on]
  Front Right: Playback 87 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 0 [0%] [-65.25dB] [on]
  Front Right: Playback 0 [0%] [-65.25dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%] [-51.00dB]
  Front Right: Playback 0 [0%] [-51.00dB]
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
  Limits: 0 - 127
  Front Left: 127 [100%] [0.00dB]
  Front Right: 127 [100%] [0.00dB]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 127
  Front Left: Capture 127 [100%] [0.00dB] [on]
  Front Right: Capture 127 [100%] [0.00dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 127
  Front Left: 127 [100%] [0.00dB]
  Front Right: 127 [100%] [0.00dB]


!!Alsactl output
!!--------------

--startcollapse--
state.Generic {
	control.1 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.5 {
		iface CARD
		name 'HDMI Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
}
state.Generic_1 {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 87
		value.1 87
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
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
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -6525
			dbvalue.1 -6525
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
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
		name 'Internal Mic Playback Volume'
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
	control.6 {
		iface MIXER
		name 'Internal Mic Playback Switch'
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
		name 'Mic Playback Volume'
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
	control.8 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.9 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Enabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.10 {
		iface MIXER
		name 'Capture Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -9999999
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.11 {
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
	control.12 {
		iface MIXER
		name 'Internal Mic Boost Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -9999999
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.13 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -9999999
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.14 {
		iface MIXER
		name 'Master Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -6525
		}
	}
	control.15 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface CARD
		name 'Mic Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface CARD
		name 'Headphone Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.20 {
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
	control.21 {
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
	control.22 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -5100
			dbvalue.1 -5100
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
arc4
brcmsmac
cordic
brcmutil
b43
mac80211
cfg80211
joydev
acer_wmi
sparse_keymap
ssb
kvm
uvcvideo
videobuf2_vmalloc
videobuf2_memops
videobuf2_core
microcode
videodev
psmouse
serio_raw
snd_hda_codec_realtek
parport_pc
ppdev
snd_hda_intel
k10temp
snd_hda_codec
i2c_piix4
snd_hwdep
bnep
rfcomm
bluetooth
snd_pcm
wmi
snd_page_alloc
snd_seq_midi
snd_seq_midi_event
snd_rawmidi
video
snd_seq
snd_seq_device
snd_timer
snd
binfmt_misc
mac_hid
bcma
soundcore
lp
parport
ahci
libahci
ohci_pci
r8169
mii


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x03 0x18560010

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x12 0x411111f0
0x14 0x90170110
0x17 0x411111f0
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x90a70920
0x1d 0x4017992d
0x1e 0x411111f0
0x21 0x0321401f

/sys/class/sound/hwC1D0/driver_pin_configs:
0x14 0x99130110
0x19 0x01a19c20
0x1b 0x99a7012f
0x21 0x0121401f

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[   12.904619] Request for unknown module key 'Magrathea: Glacier signing key: 67fb854805331643285fac717c3eca13bcd27a11' err -11
[   12.934419] hda-intel 0000:00:01.1: Using LPIB position fix
[   12.934926] snd_hda_intel 0000:00:01.1: irq 45 for MSI/MSI-X
[   12.939349] ppdev: user-space parallel port driver
[   12.953651] Request for unknown module key 'Magrathea: Glacier signing key: 67fb854805331643285fac717c3eca13bcd27a11' err -11
[   12.980331] hda-intel 0000:00:01.1: Enable sync_write for stable communication
[   13.023285] autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
--
[   13.023319]    inputs:
[   13.024262] input: HD-Audio Generic HDMI as /devices/pci0000:00/0000:00:01.1/sound/card0/input10
[   13.047906] hda-intel 0000:00:14.2: Using LPIB position fix
[   13.113364] snd_hda_intel 0000:00:14.2: irq 46 for MSI/MSI-X
[   13.143431] hda-intel 0000:00:14.2: Enable sync_write for stable communication
[   13.161091] init: avahi-cups-reload main process (467) terminated with status 1
--
[   19.376633] ieee80211 phy0: registered radio enabled led device: brcmsmac-phy0:radio gpio: 243
[   19.920196] hda_codec: rates == 0 (nid=0x2, val=0x0, ovrd=1)
[   19.920212] hda_codec: cannot attach PCM stream 0 for codec #0
[   21.201741] type=1400 audit(1383971659.219:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/lightdm/lightdm/lightdm-guest-session-wrapper" pid=1158 comm="apparmor_parser"
--
[   22.841535] type=1400 audit(1383971660.859:13): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=1203 comm="apparmor_parser"
[   22.940626] hda-codec: out of range cmd 0:20:400:ffffffff
[   22.953083] brcmsmac bcma0:0: brcms_ops_bss_info_changed: qos enabled: false (implement)
--
[   24.968914] IPv6: ADDRCONF(NETDEV_CHANGE): wlan2: link becomes ready
[   25.961020] hda-codec: out of range cmd 0:20:400:ffffffff
[   26.014218] brcmsmac bcma0:0: brcms_ops_bss_info_changed: arp filtering: 1 addresses (implement)
--
[   28.872890] type=1400 audit(1383971666.887:20): apparmor="STATUS" operation="profile_load" name="/usr/lib/telepathy/telepathy-ofono" pid=1209 comm="apparmor_parser"
[   28.977442] hda-codec: out of range cmd 0:20:400:ffffffff
[   30.839285] type=1400 audit(1383971668.855:21): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=1355 comm="apparmor_parser"
--
[   31.674152] type=1400 audit(1383971669.691:24): apparmor="STATUS" operation="profile_load" name="/usr/sbin/mysqld" pid=1361 comm="apparmor_parser"
[   31.997829] hda-codec: out of range cmd 0:20:400:ffffffff
[   32.480075] type=1400 audit(1383971670.495:25): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=1363 comm="apparmor_parser"
--
[   57.577932] init: plymouth-stop pre-start process (2080) terminated with status 1
[  139.549955] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:14.2/sound/card1/input19
[  139.550275] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input18
