From: Gregory T Flynn <gflynn1@binghamton.edu>
Subject: Re: no soundcards detected on MCP51 rev a
Date: Wed, 14 Apr 2010 08:47:04 -0400
Message-ID: <y2rb98465221004140547m50808d75q5a896bea789b655e@mail.gmail.com>
References: <i2qb98465221004131406ze558772bq74e2ffac68e1f12a@mail.gmail.com>
	<r2m604760771004131619p2ac8d6fasb387dccb325a55ae@mail.gmail.com>
	<v2rb98465221004131834o14d1d48brba3a39da322e2011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 36B8A10380A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 14:47:05 +0200 (CEST)
Received: by vws1 with SMTP id 1so20067vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 05:47:04 -0700 (PDT)
In-Reply-To: <v2rb98465221004131834o14d1d48brba3a39da322e2011@mail.gmail.com>
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

No dice, configured with '--with-debug=3Dverbose':

nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x000f0000
ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #1 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #3 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #4 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #5 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #6 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #7 probe error; disabling it...
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:751: hda_intel: azx_get_response timeout, switching
to single_cmd mode: last cmd=3D0x000f0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0001
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0002
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0004
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0001
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0002
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0004
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_intel.c:1447: no codecs initialized

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Wed Apr 14 12:46:14 UTC 2010


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

Driver version:     1.0.22.1
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

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a=
2)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:10.1 0403: 10de:026c (rev a2)
	Subsystem: 1462:373d


!!Loaded sound module options
!!--------------------------


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 3 Apr 13 19:50 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 Apr 13 19:50 /dev/snd/timer


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
snd_pcm_oss
snd_mixer_oss
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm
snd_timer
snd
ohci_hcd
snd_page_alloc
i2c_nforce2
edac_core
battery
ac
ehci_hcd
nvidia
i2c_core
edac_mce_amd
usbcore
video
psmouse
output
forcedeth
k8temp
button
thermal
evdev
serio_raw
processor
sg
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
HDA Intel 0000:00:10.1: PCI INT B -> Link[LAZA] -> GSI 23 (level, low) -> I=
RQ 23
hda_intel: Disable MSI for Nvidia chipset
HDA Intel 0000:00:10.1: setting latency timer to 64
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
usb 1-8: new high speed USB device using ehci_hcd and address 3
ALSA hda_intel.c:909: codec_mask =3D 0xff
cfg80211: Calling CRDA to update world regulatory domain
--
usbhid: USB HID core driver
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x000f0000
ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #1 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #3 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #4 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #5 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #6 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #7 probe error; disabling it...
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:751: hda_intel: azx_get_response timeout, switching
to single_cmd mode: last cmd=3D0x000f0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0001
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0002
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0xf0004
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0000
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0001
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0002
ALSA hda_intel.c:815: send_cmd timeout: IRS=3D0x741, val=3D0x100f0004
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_codec.c:1051: hda_codec: no AFG or MFG node found
ALSA hda_intel.c:1447: no codecs initialized
HDA Intel 0000:00:10.1: PCI INT B disabled
EXT4-fs (sda4): mounted filesystem with ordered data mode



> On Tue, Apr 13, 2010 at 7:19 PM, Daniel Chen <seven.steps@gmail.com> wrot=
e:
>> On Tue, Apr 13, 2010 at 5:06 PM, Gregory T Flynn <gflynn1@binghamton.edu=
> wrote:
>>> Driver version: =A0 =A0 1.0.21
>>> 00:10.1 0403: 10de:026c (rev a2)
>>> =A0 =A0 =A0 =A0Subsystem: 1462:373d
>>
>> Please try http://kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa=
-driver-snapshot.tar.bz2
>>
>
>
>
> --
> - Greg Flynn
>



-- =

- Greg Flynn
