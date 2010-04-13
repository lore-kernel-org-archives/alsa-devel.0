From: Gregory T Flynn <gflynn1@binghamton.edu>
Subject: no soundcards detected on MCP51 rev a
Date: Tue, 13 Apr 2010 17:06:26 -0400
Message-ID: <i2qb98465221004131406ze558772bq74e2ffac68e1f12a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 43BF6103884
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 23:06:27 +0200 (CEST)
Received: by vws1 with SMTP id 1so2358264vws.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 14:06:27 -0700 (PDT)
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

$ alsaconf
will detect the soundcard but

$ aplay -l
aplay: device_list:223: no soundcards found...

ALC883 Realtek
lspci:
00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)

Alsa info result:

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Tue Apr 13 20:50:40 UTC 2010


!!Linux Distribution
!!------------------

Arch Linux \r (\n) (\l)


!!DMI Information
!!---------------

Manufacturer:      Micro-Star International
Product Name:      MEGA BOOK S430


!!Kernel Information
!!------------------

Kernel release:    2.6.33-ARCH
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         AMD Turion(tm) 64 X2 Mobile Technology TL-50
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.22
Utilities version:  1.0.22


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

--- no soundcards ---


!!PCI Soundcards installed in the system
!!--------------------------------------

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:10.1 0403: 10de:026c (rev a2)
	Subsystem: 1462:373d


!!Loaded sound module options
!!--------------------------


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 3 Apr 13 14:37 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 Apr 13 14:37 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:223: no soundcards found...

ARECORD

arecord: device_list:223: no soundcards found...

!!Amixer output
!!-------------


!!Alsactl output
!!-------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ipt_MASQUERADE
xt_state
ipt_REJECT
xt_tcpudp
iptable_filter
nf_nat_h323
nf_conntrack_h323
nf_nat_pptp
nf_conntrack_pptp
nf_conntrack_proto_gre
nf_nat_proto_gre
nf_nat_tftp
nf_conntrack_tftp
nf_nat_sip
nf_conntrack_sip
nf_nat_irc
nf_conntrack_irc
nf_nat_ftp
nf_conntrack_ftp
iptable_nat
nf_nat
nf_conntrack_ipv4
nf_conntrack
nf_defrag_ipv4
ip_tables
x_tables
ipv6
ext2
joydev
usbhid
hid
arc4
ecb
rt73usb
crc_itu_t
rt2x00usb
rt2x00lib
led_class
mac80211
cfg80211
rfkill
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_hda_intel
snd_pcm_oss
snd_hda_codec
snd_hwdep
snd_pcm
snd_mixer_oss
ohci_hcd
snd_timer
video
ac
battery
ehci_hcd
snd
snd_page_alloc
nvidia
output
usbcore
thermal
i2c_nforce2
i2c_core
button
k8temp
processor
forcedeth
psmouse
sg
edac_core
edac_mce_amd
evdev
serio_raw
soundcore
fuse
rtc_cmos
rtc_core
rtc_lib
ext4
mbcache
jbd2
crc16
sr_mod
sd_mod
cdrom
ata_generic
pata_acpi
pata_amd
sata_nv
libata
scsi_mod


!!ALSA/HDA dmesg
!!------------------

ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 23
HDA Intel 0000:00:10.1: PCI INT B -> Link[LAZA] -> GSI 23 (level, low) -> IRQ 23
hda_intel: Disable MSI for Nvidia chipset
HDA Intel 0000:00:10.1: setting latency timer to 64
usb 1-8: new high speed USB device using ehci_hcd and address 3
--
usbhid: USB HID core driver
hda-intel: azx_get_response timeout, switching to polling mode: last
cmd=0x000f0000
hda-intel: Codec #0 probe error; disabling it...
hda-intel: Codec #1 probe error; disabling it...
hda-intel: Codec #2 probe error; disabling it...
hda-intel: Codec #3 probe error; disabling it...
hda_intel: azx_get_response timeout, switching to single_cmd mode:
last cmd=0x000f0000
hda-intel: no codecs initialized
HDA Intel 0000:00:10.1: PCI INT B disabled
EXT4-fs (sda4): mounted filesystem with ordered data mode



-- 
- Greg Flynn
