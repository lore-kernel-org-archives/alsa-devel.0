From: Jean-Philippe Guillemin <h1p8r10n@gmail.com>
Subject: Re: Adding support for CMEDIA USB2.0 High-Speed True
	HD Audio
Date: Thu, 8 Feb 2018 17:15:27 +0100
Message-ID: <CAOuaOFugppjDhdR8_6bi+6BXX6Eg7SSHDDXjO-KsvtDsn6WYkQ@mail.gmail.com>
References: <CAOuaOFuAa0jd9ZAENcnaJci1JmCw+dzAwQqT9bhv2t=i=ndWSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f172.google.com (mail-ot0-f172.google.com
 [74.125.82.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 34022267743
 for <alsa-devel@alsa-project.org>; Thu,  8 Feb 2018 17:15:59 +0100 (CET)
Received: by mail-ot0-f172.google.com with SMTP id l5so4802007otj.11
 for <alsa-devel@alsa-project.org>; Thu, 08 Feb 2018 08:15:59 -0800 (PST)
In-Reply-To: <CAOuaOFuAa0jd9ZAENcnaJci1JmCw+dzAwQqT9bhv2t=i=ndWSA@mail.gmail.com>
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

Hi,

below the output of the alsa-info script :

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Thu Feb  8 16:11:43 UTC 2018


!!Linux Distribution
!!------------------

NAME=Slackware ID=slackware PRETTY_NAME="Slackware 14.2"
CPE_NAME="cpe:/o:slackware:slackware_linux:14.2" HOME_URL="
http://slackware.com/" SUPPORT_URL="
http://www.linuxquestions.org/questions/slackware-14/" BUG_REPORT_URL="
http://www.linuxquestions.org/questions/slackware-14/" Slackware 14.2
Zenwalk 8.0


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version
Firmware Version:  2301
Board Vendor:      ASUSTeK Computer INC.
Board Name:        M4A88TD-V EVO/USB3


!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/ATK0110:00/status      15
/sys/bus/acpi/devices/PNP0103:00/status      15
/sys/bus/acpi/devices/PNP0501:00/status      15
/sys/bus/acpi/devices/PNP0C0C:00/status      11
/sys/bus/acpi/devices/PNP0C0F:00/status      11
/sys/bus/acpi/devices/PNP0C0F:01/status      11
/sys/bus/acpi/devices/PNP0C0F:02/status      11
/sys/bus/acpi/devices/PNP0C0F:03/status      11
/sys/bus/acpi/devices/PNP0C0F:04/status      11
/sys/bus/acpi/devices/PNP0C0F:05/status      11
/sys/bus/acpi/devices/PNP0C0F:06/status      11
/sys/bus/acpi/devices/PNP0C0F:07/status      11
/sys/bus/acpi/devices/device:02/status      15
/sys/bus/acpi/devices/device:0a/status      15
/sys/bus/acpi/devices/device:0b/status      15
/sys/bus/acpi/devices/device:21/status      15
/sys/bus/acpi/devices/device:24/status      15


!!Kernel Information
!!------------------

Kernel release:    4.14.17
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         AMD Phenom(tm) II X6 1055T Processor
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k4.14.17
Library version:    1.1.5
Utilities version:  1.1.5


!!Loaded ALSA modules
!!-------------------

snd_usb_audio


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Audio          ]: USB-Audio - USB2.0 High-Speed True HD Audio
                      CMEDIA USB2.0 High-Speed True HD Audio at
usb-0000:00:12.2-4, high speed


!!PCI Soundcards installed in the system
!!--------------------------------------



!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------



!!Loaded sound module options
!!---------------------------

!!Module: snd_usb_audio
    autoclock : Y
    device_setup :
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
    id :
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
    ignore_ctl_error : N
    index :
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
    pid :
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
    quirk_alias :
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
    vid :
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x147ae055, ctrlif=0, ctlerr=0
Card: CMEDIA USB2.0 High-Speed True HD Audio at usb-0000:00:12.2-4, high
speed
  Unit: 10
    Control: name="PCM Capture Source", index=0
    Info: id=10, control=1, cmask=0x0, channels=1, type="U8"
    Volume: min=1, max=3, dBmin=0, dBmax=0
  Unit: 11
    Control: name="Speaker Playback Volume", index=0
    Info: id=11, control=2, cmask=0xff, channels=8, type="S16"
    Volume: min=-15872, max=0, dBmin=-6200, dBmax=0
  Unit: 11
    Control: name="Speaker Playback Switch", index=0
    Info: id=11, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 12
    Control: name="PCM Playback Switch", index=0
    Info: id=12, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 13
    Control: name="Auto Gain Control", index=0
    Info: id=13, control=7, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 13
    Control: name="Mic Capture Volume", index=0
    Info: id=13, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-4096, max=3072, dBmin=-1600, dBmax=1200
  Unit: 13
    Control: name="Mic Capture Switch", index=0
    Info: id=13, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 14
    Control: name="Line Capture Volume", index=0
    Info: id=14, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-4096, max=3072, dBmin=-1600, dBmax=1200
  Unit: 14
    Control: name="Line Capture Switch", index=0
    Info: id=14, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 15
    Control: name="PCM Capture Volume", index=0
    Info: id=15, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-4096, max=3072, dBmin=-1600, dBmax=1200
  Unit: 15
    Control: name="PCM Capture Switch", index=0
    Info: id=15, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 16
    Control: name="Mic Playback Volume", index=0
    Info: id=16, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-8832, max=3072, dBmin=-3450, dBmax=1200
  Unit: 16
    Control: name="Mic Playback Switch", index=0
    Info: id=16, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 17
    Control: name="Line Playback Volume", index=0
    Info: id=17, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-8832, max=3072, dBmin=-3450, dBmax=1200
  Unit: 17
    Control: name="Line Playback Switch", index=0
    Info: id=17, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 22
    Control: name="Clock Source 22 Validity", index=0
    Info: id=22, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 23
    Control: name="Clock Source 23 Validity", index=0
    Info: id=23, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 24
    Control: name="Clock Source 24 Validity", index=0
    Info: id=24, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 25
    Control: name="Clock Source 25 Validity", index=0
    Info: id=25, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Feb  8 08:56 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  4 Feb  8 08:56 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Feb  8 08:56 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  6 Feb  8 08:56 /dev/snd/pcmC0D1c
crw-rw----+ 1 root audio 116,  5 Feb  8 08:56 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  7 Feb  8 16:28 /dev/snd/pcmC0D2p
crw-rw----  1 root audio 116,  1 Feb  8 09:56 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Feb  8 08:56 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  60 Feb  8 09:56 .
drwxr-xr-x 4 root root 240 Feb  8 09:56 ..
lrwxrwxrwx 1 root root  12 Feb  8 08:56
usb-CMEDIA_USB2.0_High-Speed_True_HD_Audio-00 -> ../controlC0

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Feb  8 09:56 .
drwxr-xr-x 4 root root 240 Feb  8 09:56 ..
lrwxrwxrwx 1 root root  12 Feb  8 08:56 pci-0000:00:12.2-usb-0:4:1.0 ->
../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

# ALSA system-wide config file
# By default, redirect to PulseAudio:
pcm.default pulse
ctl.default pulse


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Audio [USB2.0 High-Speed True HD Audio], device 0: USB Audio [USB
Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Audio [USB2.0 High-Speed True HD Audio], device 1: USB Audio [USB
Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Audio [USB2.0 High-Speed True HD Audio], device 2: USB Audio [USB
Audio #2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Audio [USB2.0 High-Speed True HD Audio], device 0: USB Audio [USB
Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Audio [USB2.0 High-Speed True HD Audio], device 1: USB Audio [USB
Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Audio]

Card hw:0 'Audio'/'CMEDIA USB2.0 High-Speed True HD Audio at
usb-0000:00:12.2-4, high speed'
  Mixer name    : 'USB Mixer'
  Components    : 'USB147a:e055'
  Controls      : 24
  Simple ctrls  : 10
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right - Rear Left - Rear Right -
Front Center - Woofer - Side Left - Side Right
  Limits: Playback 0 - 62
  Mono:
  Front Left: Playback 59 [95%] [-3.00dB] [on]
  Front Right: Playback 59 [95%] [-3.00dB] [on]
  Rear Left: Playback 0 [0%] [-62.00dB] [on]
  Rear Right: Playback 0 [0%] [-62.00dB] [on]
  Front Center: Playback 0 [0%] [-62.00dB] [on]
  Woofer: Playback 0 [0%] [-62.00dB] [on]
  Side Left: Playback 0 [0%] [-62.00dB] [on]
  Side Right: Playback 0 [0%] [-62.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: cvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 28
  Mono: Playback [on]
  Front Left: Capture 16 [57%] [0.00dB] [on]
  Front Right: Capture 16 [57%] [0.00dB] [on]
Simple mixer control 'PCM Capture Source',0
  Capabilities: enum
  Items: 'Mic' 'Line' 'Mixer'
  Item0: 'Mic'
Simple mixer control 'Line',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch
cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31 Capture 0 - 28
  Front Left: Playback 3 [10%] [-30.00dB] [off] Capture 0 [0%] [-16.00dB]
[off]
  Front Right: Playback 3 [10%] [-30.00dB] [off] Capture 0 [0%] [-16.00dB]
[off]
Simple mixer control 'Mic',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch
cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31 Capture 0 - 28
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture 16 [57%] [0.00dB]
[off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture 16 [57%] [0.00dB]
[off]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Clock Source 22 Validity',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Clock Source 23 Validity',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Clock Source 24 Validity',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Clock Source 25 Validity',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!--------------

--startcollapse--
state.Audio {
    control.1 {
        iface PCM
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
            access read
            type INTEGER
            count 8
            range '0 - 36'
        }
    }
    control.2 {
        iface PCM
        device 1
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
    control.3 {
        iface PCM
        device 2
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
    control.4 {
        iface PCM
        name 'Capture Channel Map'
        value.0 0
        value.1 0
        comment {
            access read
            type INTEGER
            count 2
            range '0 - 36'
        }
    }
    control.5 {
        iface PCM
        device 1
        name 'Capture Channel Map'
        value.0 0
        value.1 0
        comment {
            access read
            type INTEGER
            count 2
            range '0 - 36'
        }
    }
    control.6 {
        iface MIXER
        name 'Mic Playback Switch'
        value false
        comment {
            access 'read write'
            type BOOLEAN
            count 1
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
        name 'Line Playback Switch'
        value false
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.9 {
        iface MIXER
        name 'Line Playback Volume'
        value.0 3
        value.1 3
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 31'
            dbmin -3450
            dbmax 1200
            dbvalue.0 -3000
            dbvalue.1 -3000
        }
    }
    control.10 {
        iface MIXER
        name 'Speaker Playback Switch'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.11 {
        iface MIXER
        name 'Speaker Playback Volume'
        value.0 59
        value.1 59
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
            range '0 - 62'
            dbmin -6200
            dbmax 0
            dbvalue.0 -300
            dbvalue.1 -300
            dbvalue.2 -6200
            dbvalue.3 -6200
            dbvalue.4 -6200
            dbvalue.5 -6200
            dbvalue.6 -6200
            dbvalue.7 -6200
        }
    }
    control.12 {
        iface MIXER
        name 'Clock Source 22 Validity'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.13 {
        iface MIXER
        name 'PCM Playback Switch'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.14 {
        iface MIXER
        name 'Clock Source 23 Validity'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.15 {
        iface MIXER
        name 'Mic Capture Switch'
        value false
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.16 {
        iface MIXER
        name 'Mic Capture Volume'
        value.0 16
        value.1 16
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 28'
            dbmin -1600
            dbmax 1200
            dbvalue.0 0
            dbvalue.1 0
        }
    }
    control.17 {
        iface MIXER
        name 'Auto Gain Control'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.18 {
        iface MIXER
        name 'Line Capture Switch'
        value false
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.19 {
        iface MIXER
        name 'Line Capture Volume'
        value.0 0
        value.1 0
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 28'
            dbmin -1600
            dbmax 1200
            dbvalue.0 -1600
            dbvalue.1 -1600
        }
    }
    control.20 {
        iface MIXER
        name 'PCM Capture Switch'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.21 {
        iface MIXER
        name 'PCM Capture Volume'
        value.0 16
        value.1 16
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 28'
            dbmin -1600
            dbmax 1200
            dbvalue.0 0
            dbvalue.1 0
        }
    }
    control.22 {
        iface MIXER
        name 'PCM Capture Source'
        value Mic
        comment {
            access 'read write'
            type ENUMERATED
            count 1
            item.0 Mic
            item.1 Line
            item.2 Mixer
        }
    }
    control.23 {
        iface MIXER
        name 'Clock Source 24 Validity'
        value true
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.24 {
        iface MIXER
        name 'Clock Source 25 Validity'
        value false
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
rfcomm
cfg80211
8021q
garp
stp
llc
xt_tcpudp
xt_limit
xt_conntrack
iptable_mangle
nf_conntrack_ftp
xt_state
iptable_nat
nf_conntrack_ipv4
nf_defrag_ipv4
nf_nat_ipv4
nf_nat
nf_conntrack
ipv6
iptable_filter
ip_tables
x_tables
cmac
bnep
fuse
hid_logitech_hidpp
joydev
hid_logitech_dj
hid_generic
snd_usb_audio
snd_usbmidi_lib
snd_hwdep
snd_rawmidi
snd_seq_device
snd_pcm
btusb
snd_timer
btrtl
btbcm
usbhid
btintel
snd
soundcore
hid
bluetooth
ecdh_generic
rfkill
i2c_dev
amdkfd
amd_iommu_v2
radeon
wmi_bmof
ttm
evdev
drm_kms_helper
ohci_pci
drm
r8169
agpgart
kvm
psmouse
i2c_algo_bit
fb_sys_fops
firewire_ohci
syscopyarea
serio_raw
i2c_piix4
mii
sysfillrect
irqbypass
xhci_pci
ohci_hcd
k10temp
sysimgblt
ehci_pci
firewire_core
i2c_core
xhci_hcd
ehci_hcd
asus_atk0110
hwmon
shpchp
wmi
acpi_cpufreq
button
loop


!!ALSA/HDA dmesg
!!--------------

[    7.671204] usb 1-4: clock source 25 is not valid, cannot use
[    7.703765] usbcore: registered new interface driver snd-usb-audio
[    7.710330] hid-generic 0003:147A:E055.0003: input,hidraw3: USB HID
v1.00 Device [CMEDIA USB2.0 High-Speed True HD Audio] on
usb-0000:00:12.2-4/input5




2018-02-02 15:36 GMT+01:00 Jean-Philippe Guillemin <h1p8r10n@gmail.com>:

> Hi,
>
> CMEDIA USB2.0 High-Speed True HD Audio has iec958 output on device 2 and
> iec958 input on device 0.
>
> root[~]# cat /proc/asound/cards
>  0 [Audio          ]: USB-Audio - USB2.0 High-Speed True HD Audio
>                       CMEDIA USB2.0 High-Speed True HD Audio at
> usb-0000:00:12.2-2, high speed
>
> I'm trying to create a mapping in USB-Audio.conf :
>  # If a device does not use the first PCM device for digital data, the
> device
>   # number for the iec958 device can be changed here.
>   USB-Audio.pcm.iec958_device {
>      # "NoiseBlaster 3000" 42
>      "USB Sound Blaster HD" 1
>      "USB2.0 High-Speed True HD Audio" 2
>   ...
>
> But I never got a match on "USB2.0 High-Speed True HD Audio".
>
> Please could you provide me correct config ? I will test it and report
> results so that you can append this card to ALSA.
>
> Thanks
> (below lsusb output)
>
> root[~]# lsusb -v
> Bus 001 Device 009: ID 147a:e055 Formosa Industrial Computing, Inc.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x147a Formosa Industrial Computing, Inc.
>   idProduct          0xe055
>   bcdDevice            1.08
>   iManufacturer           1 CMEDIA
>   iProduct                2 USB2.0 High-Speed True HD Audio
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength         1170
>     bNumInterfaces          6
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              500mA
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         0
>       bInterfaceCount         5
>       bFunctionClass          1 Audio
>       bFunctionSubClass       0
>       bFunctionProtocol      32
>       iFunction               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               2.00
>         bCategory              10
>         wTotalLength          378
>         bmControl            0x00
>       AudioControl Interface Descriptor:
>         bLength                17
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bCSourceID             22
>         bNrChannels             0
>         bmChannelConfig   0x00000000
>         bmControls    0x0040
>           Cluster Control (read-only)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                17
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             2
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bCSourceID             23
>         bNrChannels             0
>         bmChannelConfig   0x00000000
>         bmControls    0x0040
>           Cluster Control (read-only)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                17
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0201 Microphone
>         bAssocTerminal          0
>         bCSourceID             24
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         bmControls    0x0040
>           Cluster Control (read-only)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                17
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             4
>         wTerminalType      0x0603 Line Connector
>         bAssocTerminal          0
>         bCSourceID             24
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         bmControls    0x0040
>           Cluster Control (read-only)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                17
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             5
>         wTerminalType      0x0605 SPDIF interface
>         bAssocTerminal          0
>         bCSourceID             25
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         bmControls    0x0040
>           Cluster Control (read-only)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             6
>         wTerminalType      0x0301 Speaker
>         bAssocTerminal          0
>         bSourceID              11
>         bCSourceID             22
>         bmControls         0x0000
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             7
>         wTerminalType      0x0605 SPDIF interface
>         bAssocTerminal          0
>         bSourceID              12
>         bCSourceID             23
>         bmControls         0x0000
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             8
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bSourceID              10
>         bCSourceID             24
>         bmControls         0x0000
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             9
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bSourceID               5
>         bCSourceID             25
>         bmControls         0x0000
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      5 (SELECTOR_UNIT)
>         bUnitID                10
>         bNrInPins               3
>         baSource( 0)           13
>         baSource( 1)           14
>         baSource( 2)           15
>         bmControls           0x03
>           Selector Control (read/write)
>         iSelector               0
>       AudioControl Interface Descriptor:
>         bLength                42
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                11
>         bSourceID              18
>         bmaControls( 0)      0x00000003
>           Mute Control (read/write)
>         bmaControls( 1)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 2)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 3)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 4)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 5)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 6)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 7)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 8)      0x0000000c
>           Volume Control (read/write)
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                12
>         bSourceID               2
>         bmaControls( 0)      0x00000003
>           Mute Control (read/write)
>         bmaControls( 1)      0x00000000
>         bmaControls( 2)      0x00000000
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                13
>         bSourceID               3
>         bmaControls( 0)      0x00003003
>           Mute Control (read/write)
>           Automatic Gain Control (read/write)
>         bmaControls( 1)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 2)      0x0000000c
>           Volume Control (read/write)
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                14
>         bSourceID               4
>         bmaControls( 0)      0x00000003
>           Mute Control (read/write)
>         bmaControls( 1)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 2)      0x0000000c
>           Volume Control (read/write)
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                15
>         bSourceID              19
>         bmaControls( 0)      0x00000003
>           Mute Control (read/write)
>         bmaControls( 1)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 2)      0x0000000c
>           Volume Control (read/write)
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                16
>         bSourceID               3
>         bmaControls( 0)      0x00000003
>           Mute Control (read/write)
>         bmaControls( 1)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 2)      0x0000000c
>           Volume Control (read/write)
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                17
>         bSourceID               4
>         bmaControls( 0)      0x00000003
>           Mute Control (read/write)
>         bmaControls( 1)      0x0000000c
>           Volume Control (read/write)
>         bmaControls( 2)      0x0000000c
>           Volume Control (read/write)
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                28
>         bDescriptorType        36
>         bDescriptorSubtype      4 (MIXER_UNIT)
>         bUnitID                18
>         bNrPins                 3
>         baSourceID( 0)          1
>         baSourceID( 1)         16
>         baSourceID( 2)         17
>         bNrChannels             8
>         bmChannelConfig    0x0000063f
>           Front Left (FL)
>           Front Right (FR)
>           Front Center (FC)
>           Low Frequency Effects (LFE)
>           Back Left (BL)
>           Back Right (BR)
>           Side Left (SL)
>           Side Right (SR)
>         iChannelNames           0
>  00 00 00 00 00 00 00 00 00 00 00 00
>         bmControls         01
>           Cluster Control (read-only)
>         iMixer                 0
>       AudioControl Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      4 (MIXER_UNIT)
>         bUnitID                19
>         bNrPins                 2
>         baSourceID( 0)          3
>         baSourceID( 1)          4
>         bNrChannels             2
>         bmChannelConfig    0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>  00
>         bmControls         01
>           Cluster Control (read-only)
>         iMixer                 0
>       AudioControl Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype     10 (CLOCK_SOURCE)
>         bClockID               22
>         bmAttributes         0x07 Internal programmable Clock (synced to
> SOF)
>         bmControls           0x07
>           Clock Frequency Control (read/write)
>           Clock Validity Control (read-only)
>         bAssocTerminal          0
>         iClockSource            0
>       AudioControl Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype     10 (CLOCK_SOURCE)
>         bClockID               23
>         bmAttributes         0x07 Internal programmable Clock (synced to
> SOF)
>         bmControls           0x07
>           Clock Frequency Control (read/write)
>           Clock Validity Control (read-only)
>         bAssocTerminal          0
>         iClockSource            0
>       AudioControl Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype     10 (CLOCK_SOURCE)
>         bClockID               24
>         bmAttributes         0x03 Internal programmable Clock
>         bmControls           0x07
>           Clock Frequency Control (read/write)
>           Clock Validity Control (read-only)
>         bAssocTerminal          0
>         iClockSource            0
>       AudioControl Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype     10 (CLOCK_SOURCE)
>         bClockID               25
>         bmAttributes         0x00 External Clock
>         bmControls           0x07
>           Clock Frequency Control (read/write)
>           Clock Validity Control (read-only)
>         bAssocTerminal          0
>         iClockSource            0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x8f  EP 15 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0006  1x 6 bytes
>         bInterval               4
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              4 Output
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             8
>         bmChannelConfig   0x0000063f
>           Front Left (FL)
>           Front Right (FR)
>           Front Center (FC)
>           Low Frequency Effects (LFE)
>           Back Left (BL)
>           Back Right (BR)
>           Side Left (SL)
>           Side Right (SR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x01a0  1x 416 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             8
>         bmChannelConfig   0x0000063f
>           Front Left (FL)
>           Front Right (FR)
>           Front Center (FC)
>           Low Frequency Effects (LFE)
>           Back Left (BL)
>           Back Right (BR)
>           Side Left (SL)
>           Side Right (SR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0340  1x 832 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       3
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0068  1x 104 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       4
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00d0  1x 208 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       5
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             6
>         bmChannelConfig   0x0000003f
>           Front Left (FL)
>           Front Right (FR)
>           Front Center (FC)
>           Low Frequency Effects (LFE)
>           Back Left (BL)
>           Back Right (BR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0138  1x 312 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       6
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             6
>         bmChannelConfig   0x0000003f
>           Front Left (FL)
>           Front Right (FR)
>           Front Center (FC)
>           Low Frequency Effects (LFE)
>           Back Left (BL)
>           Back Right (BR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0270  1x 624 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       7
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             4
>         bmChannelConfig   0x00000033
>           Front Left (FL)
>           Front Right (FR)
>           Back Left (BL)
>           Back Right (BR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00d0  1x 208 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       8
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             4
>         bmChannelConfig   0x00000033
>           Front Left (FL)
>           Front Right (FR)
>           Back Left (BL)
>           Back Right (BR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x01a0  1x 416 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              5 SPDIF Output
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           2
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0068  1x 104 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           2
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00d0  1x 208 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       3
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           2
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             3
>         bmFormats         0x00001381
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             3 (FORMAT_TYPE_III)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0068  1x 104 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              6 Input
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           8
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x88  EP 8 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0068  1x 104 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           8
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x88  EP 8 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00d0  1x 208 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              7 SPDIF Input
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           9
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            2
>         bBitResolution         16
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x8a  EP 10 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0068  1x 104 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol     32
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           9
>         bmControls           0x05
>           Active Alternate Setting Control (read-only)
>           Valid Alternate Setting Control (read-only)
>         bFormatType             1
>         bmFormats         0x00000001
>           PCM
>         bNrChannels             2
>         bmChannelConfig   0x00000003
>           Front Left (FL)
>           Front Right (FR)
>         iChannelNames           0
>       AudioStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bSubslotSize            4
>         bBitResolution         24
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x8a  EP 10 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00d0  1x 208 bytes
>         bInterval               1
>         AudioControl Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bmControls           0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         5
>       bInterfaceCount         1
>       bFunctionClass          3 Human Interface Device
>       bFunctionSubClass       0
>       bFunctionProtocol       0
>       iFunction               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        5
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      50
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               4
> Device Qualifier (for other device speed):
>   bLength                10
>   bDescriptorType         6
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   bNumConfigurations      1
> Device Status:     0x0000
>   (Bus Powered)
>
> I'm trying to create a mapping in
>
