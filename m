From: Manuel Naranjo <manuel@aircable.net>
Subject: Mute Beep (was Regression on alsa-driver-1.0.18a on
 HDA for Dell Inspiron 1521)
Date: Wed, 12 Nov 2008 16:52:51 -0200
Message-ID: <491B2603.9070802@aircable.net>
References: <a10be5a00811120606s12672837secdda91b80659ac8@mail.gmail.com>	<491AE402.3030507@aircable.net>	<s5hk5b9jaim.wl%tiwai@suse.de>	<491AE7F3.2040203@aircable.net>	<s5h7i79j8k8.wl%tiwai@suse.de>	<Pine.LNX.4.61.0811121603350.13649@tm8103.perex-int.cz>
	<s5hzlk5htlu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080202040500020702000102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id E23E21037F8
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 19:52:29 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so271759waf.16
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 10:52:28 -0800 (PST)
In-Reply-To: <s5hzlk5htlu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080202040500020702000102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> Typo here.
>>     
>
> Yep, thanks.
>
> The fixed patch below.
>
>
> Takashi
>   
Sorry but for some reason it doesn't work at all.

I'm getting this in dmegs:-
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
input: HDA Digital PCBeep as /class/input/input10
HDA Intel 0000:00:14.2: PCI INT A disabled
HDA Intel: probe of 0000:00:14.2 failed with error -16
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
input: HDA Digital PCBeep as /class/input/input11
HDA Intel 0000:00:14.2: PCI INT A disabled
HDA Intel: probe of 0000:00:14.2 failed with error -16
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16


I also attach alsa-info.sh output.

--------------080202040500020702000102
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Disposition: inline;
 filename="alsa-info.txt"
Content-Transfer-Encoding: quoted-printable

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: mi=C3=A9 nov 12 16:47:00 ARST 2008


!!Linux Distribution
!!------------------

Mandriva Linux release 2009.0 (Official) for i586 LSB_VERSION=3Dlsb-3.1-i=
a32:lsb-3.1-noarch DISTRIB_ID=3DMandrivaLinux DISTRIB_DESCRIPTION=3D"Mand=
riva Linux 2009.0" Mandriva Linux release 2009.0 (Official) for i586 Mand=
riva Linux release 2009.0 (Official) for i586 Mandriva Linux release 2009=
.0 (Official) for i586 Mandriva Linux release 2009.0 (Official) for i586 =
Mandriva Linux release 2009.0 (Official) for i586


!!Kernel Information
!!------------------

Kernel release:    2.6.27.4-desktop586-1mnb
Operating System:  GNU/Linux
Architecture:      i686
Processor:         AMD Turion(tm) 64 X2 Mobile Technology TL-56
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.18a
Library version:    1.0.18
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------



!!Soundcards recognised by ALSA
!!-----------------------------

--- no soundcards ---


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1028:01fc


!!Modprobe options (Sound related)
!!--------------------------------

snd_hda_intel: model=3Ddell-m42
snd-ac97-codec: power_save=3D1


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  1 2008-11-12 16:43 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 2008-11-12 16:43 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

#pcm.bluetooth {
#    type bluetooth
#    device 00:12:0E:06:C5:8A
#    profile "voice"
#}

pcm.pulse {
    type pulse
}
   =20
ctl.pulse {
    type pulse
}
       =20

!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:217: no soundcards found...

ARECORD

arecord: device_list:217: no soundcards found...

!!Amixer output
!!-------------


!!Alsactl output
!!-------------

--startcollapse--
state.SB {
	control.1 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.2 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Loopback'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 12
		value.1 12
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 98
		value.1 98
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'PC Beep Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		value.0 4
		value.1 4
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		index 1
		value.0 4
		value.1 4
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 'Digital Mic 1'
		iface MIXER
		name 'Digital Input Source'
		value 'Digital Mic 1'
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		iface MIXER
		name 'IEC958 Playback Source'
		value 'Digital Playback'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 101
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.22 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 204
		value.1 204
	}
	control.23 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_pcm
snd_timer
snd_page_alloc
snd_mixer_oss
snd
soundcore
af_packet
fglrx
ipv6
vboxdrv
binfmt_misc
loop
vfat
fat
dm_mod
cpufreq_ondemand
cpufreq_conservative
cpufreq_powersave
powernow_k8
freq_table
nvram
i8k
b44
ssb
thermal
pcmcia
k8temp
video
usbhid
processor
pcmcia_core
ohci1394
ac
i2c_piix4
shpchp
sdhci_pci
ieee1394
output
wmi
pci_hotplug
uvcvideo
battery
button
compat_ioctl32
joydev
i2c_core
rtc_cmos
evdev
videodev
mmc_block
v4l1_compat
sdhci
mii
mmc_core
dcdbas
ndiswrapper
ff_memless
ati_agp
agpgart
sr_mod
sg
pata_atiixp
ata_piix
ahci
libata
dock
sd_mod
scsi_mod
crc_t10dif
ext3
jbd
uhci_hcd
ohci_hcd
ehci_hcd
usbcore



--------------080202040500020702000102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080202040500020702000102--
