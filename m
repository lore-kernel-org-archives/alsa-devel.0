From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Asus w5f. ALC660-VD codec not detected
Date: Mon, 22 Dec 2008 23:48:48 +0100
Message-ID: <200812222348.48698.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id A8551103814
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 23:48:58 +0100 (CET)
Content-Disposition: inline
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
Cc: Salvatore Filippone <filippone.salvatore@gmail.com>
List-Id: alsa-devel@alsa-project.org

The person I've been trying to help has fedora Core 7 on this Asus w5f laptop. 
FC7 has sounds. there are 2 codecs detected, one for the soundcard, and one 
for the sounds on the onboard modem. Link below for output from alsa-info.sh, 
and a bit of pasted output.

 http://www.alsa-project.org/db/?f=93964b2ec68d1f912509bb1ac2ee02a5163ec4a1


!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: Fri Dec 12 11:07:58 CET 2008


!!Linux Distribution
!!------------------

Fedora release 7 (Moonshine) Fedora release 7 (Moonshine) Fedora release 7 
(Moonshine)


!!Kernel Information
!!------------------

Kernel release:    2.6.23.17-88.fc7
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.14
Library version:    1.0.14a
Utilities version:  1.0.14


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfeb38000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition 
Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
 Subsystem: 1043:1262


!!Modprobe options (Sound related)
!!--------------------------------

snd-card-0: index=0  
snd-hda-intel: index=0  


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
enable : N
id : <NULL>
index : 0
model : <NULL>
position_fix : 0
probe_mask : -1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC660-VD
Address: 0
Vendor Id: 0x10ec0660
Subsystem Id: 0x10430000
Revision Id: 0x100001
No Modem Function Group found

<skip>

Codec: Motorola Si3054
Address: 1
Vendor Id: 0x10573055
Subsystem Id: 0x10431316
Revision Id: 0x100700
Modem Function Group: 0x1

Moving on to his other install.

He also has Fedora 10 installed on this machine, but the only codec detected 
is the modem one (Motorola Si3054), and no sounds. Link below for 
alsa-info.sh output, and output pasted also below.

http://www.alsa-project.org/db/?f=552b7c6386f59813a04150545ab79f92d4af2e8a


!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: Fri Dec 12 11:16:40 CET 2008


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 
(Cambridge) Fedora release 10 (Cambridge)


!!Kernel Information
!!------------------

Kernel release:    2.6.27.5-117.fc10.i686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.17
Library version:    
Utilities version:  1.0.18rc3


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfeb38000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition 
Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
 Subsystem: 1043:1262


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : 
<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
model : 
<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Motorola Si3054
Address: 1
Vendor Id: 0x10573055
Subsystem Id: 0x10431316
Revision Id: 0x100700
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----  1 root root 116, 7 2008-12-12 11:13 /dev/snd/controlC0
crw-rw----  1 root root 116, 6 2008-12-12 11:13 /dev/snd/hwC0D1
crw-rw----  1 root root 116, 5 2008-12-12 11:13 /dev/snd/pcmC0D6c
crw-rw----  1 root root 116, 4 2008-12-12 11:13 /dev/snd/pcmC0D6p
crw-rw----  1 root root 116, 3 2008-12-12 11:13 /dev/snd/seq
crw-rw----  1 root root 116, 2 2008-12-12 11:13 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
 {
  func load
  files [
   "/etc/alsa/pulse-default.conf"
  ]
  errors false
 }
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfeb38000 irq 16'
  Mixer name : 'Motorola Si3054'
  Components : 'HDA:10573055'
  Controls      : 2
  Simple ctrls  : 2
Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
 control.1 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Off-hook Switch'
  value false
 }
 control.2 {
  comment.access 'read write'
  comment.type BOOLEAN
  comment.count 1
  iface MIXER
  name 'Caller ID Switch'
  value false
 }
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
fuse
i915
drm
i2c_core
rfcomm
sco
bridge
stp
bnep
l2cap
sunrpc
ip6t_REJECT
nf_conntrack_ipv6
ip6table_filter
ip6_tables
ipv6
cpufreq_ondemand
acpi_cpufreq
dm_multipath
uinput
snd_hda_intel
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_timer
snd_page_alloc
snd_hwdep
btusb
snd
bluetooth
firewire_ohci
8139cp
firewire_core
arc4
ecb
crypto_blkcipher
crc_itu_t
sdhci_pci
sdhci
mmc_core
8139too
gspca_vc032x
soundcore
iwl3945
mii
rfkill
iTCO_wdt
iTCO_vendor_support
gspca_main
videodev
v4l1_compat
usb_storage
serio_raw
mac80211
cfg80211
joydev
video
output
asus_laptop
pcspkr
ata_generic
pata_acpi

I also suggested upgrading to the latest snapshot of the alsa driver, which he 
did, but no change, and only the modem codec is detected on his Fedora 10 
install

Any suggestions are really welcome to help this guy

Nigel.
