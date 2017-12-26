From: Freek de Kruijf <freek@opensuse.org>
Subject: Sound to HDMI device delayed
Date: Tue, 26 Dec 2017 15:32:21 +0100
Message-ID: <189291619.ZYY3cy48X2@eiktum>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart63100057.B2ybvK4IXk"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud9.xs4all.net (lb3-smtp-cloud9.xs4all.net
 [194.109.24.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A36A26698E
 for <alsa-devel@alsa-project.org>; Tue, 26 Dec 2017 15:32:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by smtp.beelaertsict.nl (Postfix) with ESMTP id CEF641F5D5
 for <alsa-devel@alsa-project.org>; Tue, 26 Dec 2017 15:32:35 +0100 (CET)
Received: from smtp.beelaertsict.nl ([127.0.0.1])
 by localhost (rpi3-423.beelaertsict.nl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ai-FoKEyYoU for <alsa-devel@alsa-project.org>;
 Tue, 26 Dec 2017 15:32:22 +0100 (CET)
Received: from rpi3-423 (eiktum.beelaertsict.nl [192.168.178.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp.beelaertsict.nl (Postfix) with ESMTPSA id 5BE3A21163
 for <alsa-devel@alsa-project.org>; Tue, 26 Dec 2017 15:32:22 +0100 (CET)
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

This is a multi-part message in MIME format.

--nextPart63100057.B2ybvK4IXk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I have the following sound devices:

hwinfo --sound          
Absolute path to 'hwinfo' is '/usr/sbin/hwinfo', so running it may require 
superuser privileges (eg. root).
freek@eiktum:~> /usr/sbin/hwinfo --sound 
16: PCI 14.2: 0403 Audio device                                 
  [Created at pci.378]
  Unique ID: 5Dex.BDUuYMOWyw7
  SysFS ID: /devices/pci0000:00/0000:00:14.2
  SysFS BusID: 0000:00:14.2
  Hardware Class: sound
  Model: "ATI SBx00 Azalia (Intel HDA)"
  Vendor: pci 0x1002 "ATI Technologies Inc"
  Device: pci 0x4383 "SBx00 Azalia (Intel HDA)"
  SubVendor: pci 0x1002 "ATI Technologies Inc"
  SubDevice: pci 0x4383 
  Revision: 0x40
  Memory Range: 0xfe6f8000-0xfe6fbfff (rw,non-prefetchable)
  IRQ: 10 (no events)
  Module Alias: "pci:v00001002d00004383sv00001002sd00004383bc04sc03i00"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Config Status: cfg=yes, avail=yes, need=no, active=unknown

26: PCI 500.1: 0403 Audio device
  [Created at pci.378]
  Unique ID: 5yAR.dhjYDcGDBr3
  Parent ID: _Znp.ZJmKoWxd6BF
  SysFS ID: /devices/pci0000:00/0000:00:02.0/0000:05:00.1
  SysFS BusID: 0000:05:00.1
  Hardware Class: sound
  Model: "ATI RV770 HDMI Audio [Radeon HD 4850/4870]"
  Vendor: pci 0x1002 "ATI Technologies Inc"
  Device: pci 0xaa30 "RV770 HDMI Audio [Radeon HD 4850/4870]"
  SubVendor: pci 0x1787 "Hightech Information System Ltd."
  SubDevice: pci 0xaa30 
  Driver: "snd_hda_intel"
  Driver Modules: "snd_hda_intel"
  Memory Range: 0xfe9ec000-0xfe9effff (rw,non-prefetchable)
  IRQ: 36 (1104 events)
  Module Alias: "pci:v00001002d0000AA30sv00001787sd0000AA30bc04sc03i00"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Config Status: cfg=yes, avail=yes, need=no, active=unknown
  Attached to: #18 (PCI bridge)

I have my monitor connected via HDMI and that monitor has speakers. The 
monitor is:

hwinfo --monitor
29: None 00.0: 10002 LCD Monitor                                
  [Created at monitor.125]
  Unique ID: rdCR.ukgc1_4VzS0
  Parent ID: Ddhb.zvQlrOmSRQ8
  Hardware Class: monitor
  Model: "R231"
  Vendor: ACR 
  Device: eisa 0x0504 "R231"
  Serial ID: "T6GEE0012400"
  Resolution: 720x400@70Hz
  Resolution: 640x480@60Hz
  Resolution: 640x480@67Hz
  Resolution: 800x600@56Hz
  Resolution: 800x600@60Hz
  Resolution: 1024x768@60Hz
  Resolution: 1024x768@70Hz
  Resolution: 1152x864@75Hz
  Resolution: 1280x1024@60Hz
  Resolution: 1280x720@60Hz
  Resolution: 1920x1080@60Hz
  Size: 509x286 mm
  Year of Manufacture: 2016
  Week of Manufacture: 4
  Detailed Timings #0:
     Resolution: 1920x1080
     Horizontal: 1920 2008 2052 2200 (+88 +132 +280) +hsync
       Vertical: 1080 1084 1089 1125 (+4 +9 +45) +vsync
    Frequencies: 148.50 MHz, 67.50 kHz, 60.00 Hz
  Driver Info #0:
    Max. Resolution: 1920x1080
    Vert. Sync Range: 56-75 Hz
    Hor. Sync Range: 31-75 kHz
    Bandwidth: 148 MHz
  Config Status: cfg=no, avail=yes, need=no, active=unknown
  Attached to: #8 (VGA compatible controller)

The sound is working OK, however the problem is that the sound is delayed by 
about one second compared to the picture on the screen.
Most visible/hearable by using Musescore, where a music note is highlighted 
when it is played. Using VGA and the other sound card there is no delay.

alsa-info.sh

-- 
fr.gr.

member openSUSE
Freek de Kruijf

--nextPart63100057.B2ybvK4IXk
Content-Disposition: attachment; filename="also-info.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="also-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Tue Dec 26 14:30:01 UTC 2017


!!Linux Distribution
!!------------------

Welcome to openSUSE Tumbleweed 20171222 - Kernel \r (\l). LSB_VERSION="core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-x86_64:core-3.2-x86_64:core-4.0-x86_64" NAME="openSUSE Tumbleweed" ID=opensuse ID_LIKE="suse" PRETTY_NAME="openSUSE Tumbleweed" CPE_NAME="cpe:/o:opensuse:tumbleweed:20171222" BUG_REPORT_URL="https://bugs.opensuse.org" HOME_URL="https://www.opensuse.org/"


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version
Firmware Version:  0801   
Board Vendor:      ASUSTeK Computer INC.
Board Name:        M4A87TD/USB3


!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/ATK0110:00/status 	 15
/sys/bus/acpi/devices/PNP0103:00/status 	 15
/sys/bus/acpi/devices/PNP0501:00/status 	 15
/sys/bus/acpi/devices/PNP0C0C:00/status 	 11
/sys/bus/acpi/devices/PNP0C0F:00/status 	 11
/sys/bus/acpi/devices/PNP0C0F:01/status 	 11
/sys/bus/acpi/devices/PNP0C0F:02/status 	 11
/sys/bus/acpi/devices/PNP0C0F:03/status 	 11
/sys/bus/acpi/devices/PNP0C0F:04/status 	 11
/sys/bus/acpi/devices/PNP0C0F:05/status 	 11
/sys/bus/acpi/devices/PNP0C0F:06/status 	 11
/sys/bus/acpi/devices/PNP0C0F:07/status 	 11
/sys/bus/acpi/devices/device:2c/status 	 15
/sys/bus/acpi/devices/device:2d/status 	 15
/sys/bus/acpi/devices/device:2f/status 	 15


!!Kernel Information
!!------------------

Kernel release:    4.14.6-1-default
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k4.14.6-1-default
Library version:    
Utilities version:  1.1.5


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

 0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfe9ec000 irq 36


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) (rev 40)
05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] RV770 HDMI Audio [Radeon HD 4850/4870]


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:14.2 0403: 1002:4383 (rev 40)
	Subsystem: 1002:4383
--
05:00.1 0403: 1002:aa30
	Subsystem: 1787:aa30


!!Modprobe options (Sound related)
!!--------------------------------

snd_hda_intel: enable=0,1,0


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable : N,Y,N,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
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
	single_cmd : -1
	snoop : -1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100100
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
  Converter: stream=0, channel=0
  Digital: Enabled GenLevel
  Digital category: 0x2
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
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

crw-rw----+ 1 root audio 116,  2 Dec 26 10:49 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  4 Dec 26 10:49 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  3 Dec 26 14:08 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  1 Dec 26 10:49 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Dec 26 10:49 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Dec 26 10:49 .
drwxr-xr-x 3 root root 160 Dec 26 10:49 ..
lrwxrwxrwx 1 root root  12 Dec 26 10:49 pci-0000:05:00.1 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [HDMI]

Card hw:0 'HDMI'/'HDA ATI HDMI at 0xfe9ec000 irq 36'
  Mixer name	: 'ATI R6xx HDMI'
  Components	: 'HDA:1002aa01,00aa0100,00100100'
  Controls      : 7
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.HDMI {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.7 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
lp
parport_pc
st
ppdev
parport
fuse
nf_log_ipv6
xt_comment
nf_log_ipv4
nf_log_common
xt_LOG
xt_limit
xt_recent
nfnetlink_cthelper
nfnetlink
af_packet
iscsi_ibft
iscsi_boot_sysfs
ip6t_REJECT
nf_reject_ipv6
nf_conntrack_ipv6
nf_defrag_ipv6
ipt_REJECT
nf_reject_ipv4
xt_pkttype
xt_tcpudp
iptable_filter
ip6table_mangle
nf_conntrack_netbios_ns
nf_conntrack_broadcast
nf_conntrack_ipv4
nf_defrag_ipv4
ip_tables
xt_conntrack
nf_conntrack
libcrc32c
ip6table_filter
ip6_tables
x_tables
msr
gspca_zc3xx
gspca_main
v4l2_common
videodev
snd_hda_codec_hdmi
snd_hda_intel
snd_hda_codec
snd_hda_core
snd_hwdep
snd_pcm
snd_seq
snd_seq_device
snd_timer
edac_mce_amd
r8169
mii
snd
asus_atk0110
shpchp
kvm_amd
wmi_bmof
sp5100_tco
joydev
soundcore
button
acpi_cpufreq
kvm
wmi
i2c_piix4
hid_generic
pcspkr
k10temp
irqbypass
uas
usb_storage
hid_logitech
ff_memless
usbhid
ohci_pci
serio_raw
ata_generic
amdkfd
amd_iommu_v2
xhci_pci
xhci_hcd
ehci_pci
pata_atiixp
ohci_hcd
ehci_hcd
usbcore
pata_jmicron
radeon
i2c_algo_bit
sr_mod
cdrom
drm_kms_helper
syscopyarea
sysfillrect
sysimgblt
fb_sys_fops
ttm
drm
sg


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x03 0x18560010

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    4.736256] [drm] Connector 0:
[    4.736257] [drm]   HDMI-A-1
[    4.736257] [drm]   HPD1
--
[   14.323497] Adding 4192252k swap on /dev/sda1.  Priority:-3 extents:1 across:4192252k FS
[   14.406746] snd_hda_intel: probe of 0000:00:14.2 failed with error -2
[   14.406897] snd_hda_intel 0000:05:00.1: Handle vga_switcheroo audio client
[   14.567602] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   14.568924] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:05:00.1/sound/card0/input10
[   15.080067] usb 6-3: New USB device found, idVendor=0001, idProduct=0000
--
[   43.832419] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC= SRC=192.168.178.6 DST=224.0.0.251 LEN=178 TOS=0x00 PREC=0x00 TTL=255 ID=1474 DF PROTO=UDP SPT=5353 DPT=5353 LEN=158 
[   81.589671] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   81.911438] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   82.227581] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   82.547739] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   82.871858] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   83.188034] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   83.508180] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   83.828347] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   84.148482] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   96.054593] fuse init (API version 7.26)
[   96.704898] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   97.019051] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   97.339161] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   97.659267] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   97.979474] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   98.299658] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   98.619748] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   98.939963] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[   99.264164] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[  180.113019] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[ 3435.793432] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:00:0a:f5:08:00 SRC=192.168.178.23 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[ 3479.809446] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3480.110198] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3480.430200] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3480.750209] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3481.070224] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3481.390173] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3481.710186] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3482.030171] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3482.350198] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 3555.126170] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[ 6309.603438] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:7f:f1:9b:08:00 SRC=192.168.178.21 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[ 6315.556250] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6315.738448] snd_hda_intel 0000:05:00.1: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
[ 6315.866634] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6316.186652] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6316.506658] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6316.826654] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6317.146613] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6317.466649] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6317.786656] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6318.106652] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 6430.137665] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[ 9560.121477] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:7f:f1:9b:08:00 SRC=192.168.178.21 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[ 9642.812230] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9643.140883] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9643.460376] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9643.780247] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9644.100246] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9644.420252] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9644.740233] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9645.060261] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9645.380249] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[ 9680.153145] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[10307.660386] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:00:0a:f5:08:00 SRC=192.168.178.23 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[10319.621186] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10319.621209] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10319.946287] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10320.266285] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10320.586289] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10320.906297] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10321.226289] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10321.546243] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10321.866299] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10322.186298] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[10430.155912] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[11258.104210] usb 5-1: reset high-speed USB device number 2 using ehci-pci
[11291.782056] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11291.782079] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11292.112379] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11292.432378] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11292.752383] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11293.072381] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11293.392392] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11293.712364] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11294.032371] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11294.352398] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11305.159544] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[11431.666033] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:7f:f1:9b:08:00 SRC=192.168.178.21 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[11516.415828] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11516.721426] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11517.041432] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11517.361389] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11517.681426] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11518.001397] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11518.321434] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11518.641428] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11518.961436] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11555.160831] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[11639.769965] usb 5-1: reset high-speed USB device number 2 using ehci-pci
[11653.043735] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11653.362034] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11653.682040] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11654.002045] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11654.322035] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11654.642036] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11654.962015] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11655.282041] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11655.602040] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11680.161392] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[11934.159065] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:00:0a:f5:08:00 SRC=192.168.178.23 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[11950.777726] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11951.091313] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11951.411316] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11951.731292] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11952.051301] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11952.371315] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11952.691321] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11953.011328] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11953.331321] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[11996.603500] usb 5-1: reset high-speed USB device number 2 using ehci-pci
--
[13435.281448] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:7f:f1:9b:08:00 SRC=192.168.178.21 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[13460.369120] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13460.697009] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13461.016999] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13461.336997] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13461.656990] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13461.977011] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13462.297005] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13462.617018] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13462.937008] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[13555.168589] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
--
[16683.187822] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:00:0a:f5:08:00 SRC=192.168.178.23 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[16740.598756] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16740.722653] r8169 0000:01:00.0: invalid short VPD tag 00 at offset 1
[16740.905747] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16741.225768] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16741.545762] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16741.865768] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16742.185759] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16742.505767] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16742.825772] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16743.145768] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD
[16805.182139] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:01:9c:c7:a6:0a:1f:48:08:00 SRC=192.168.178.1 DST=224.0.0.1 LEN=36 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[16811.802193] SFW2-INext-ACC-TRUST IN=enp1s0 OUT= MAC=01:00:5e:00:00:fb:78:25:44:7f:f1:9b:08:00 SRC=192.168.178.21 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2 
[16849.023819] snd_hda_codec_hdmi hdaudioC0D0: HDMI ATI/AMD: no speaker allocation for ELD



--nextPart63100057.B2ybvK4IXk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart63100057.B2ybvK4IXk--
