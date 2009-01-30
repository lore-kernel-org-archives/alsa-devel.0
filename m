From: Stephan =?utf-8?q?J=C3=A4necke?= <stejae@arcor.de>
Subject: Alsamixer isn't working properly with HDA VIA VT82xx
	with Realtek ALC888 Codec
Date: Fri, 30 Jan 2009 19:10:54 +0100
Message-ID: <200901301910.54906.stejae@arcor.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uK0gJKT2S/YbHPR"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A2FF81037E3
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 19:11:07 +0100 (CET)
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net
	[151.189.8.20]) by mx.arcor.de (Postfix) with ESMTP id BC3912AF218
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 19:11:05 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id EE1D421306E
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 19:11:04 +0100 (CET)
Received: from amd32os111.localnet (p57B74827.dip.t-dialin.net [87.183.72.39])
	(Authenticated sender: stejae@arcor.de)
	by mail-in-12.arcor-online.net (Postfix) with ESMTPSA id B26881B39AD
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 19:11:04 +0100 (CET)
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

--Boundary-00=_uK0gJKT2S/YbHPR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear developers,
alsamixer doesn't work on my fedora machine. When I type in 'alsamixer -c 0=
',
I get
		"hda_codec: num-steps=3D0 for NID=3D0xf (ctl=3DSide Playback Volume)"
		"alsamixer: function snd_mixer_load failed: Invalid argument"

Although Pulseaudio and OSS Mixers seem to be present, I don't get any soun=
d.
Please have a look at http://www.alsa-
project.org/db/?f=3D15c9f665eb141dee755a533d804456e81442f270
or check the attachment.

I hope you can help me solving my problem.

Regards,
Stephan J=C3=A4necke

PS: I had the same mixer problem with Mandriva 2009.0 before I installed=20
=46edora 10 to check whether it's an distribution specific bug. Whereas=20
alsamixer didn't work properly as well, I could enjoy working sound.
=2D-=20
Powered by openSUSE 11.1 and KMail 1.10.3

--Boundary-00=_uK0gJKT2S/YbHPR
Content-Type: text/plain;
  charset="UTF-8";
  name="fedora-alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fedora-alsa-info.txt"


!!################################
!!ALSA Information Script v 0.4.53
!!################################

!!Script ran on: Fri Jan 30 15:01:08 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge)


!!Kernel Information
!!------------------

Kernel release:    2.6.27.9-159.fc10.i686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.18a
Library version:    
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [VT82xx         ]: HDA-Intel - HDA VIA VT82xx
                      HDA VIA VT82xx at 0xfebfc000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

03:06.0 Multimedia controller: Philips Semiconductors SAA7133/SAA7135 Video Broadcast Decoder (rev d0)
80:01.0 Audio device: VIA Technologies, Inc. VIA High Definition Audio Controller (rev 10)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

80:01.0 0403: 1106:3288 (rev 10)
	Subsystem: 1849:0888


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC888
Address: 0
Vendor Id: 0x10ec0888
Subsystem Id: 0x18491e01
Revision Id: 0x100001
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

crw-rw----  1 root root 116, 9 Jan 30  2009 /dev/snd/controlC0
crw-rw----  1 root root 116, 8 Jan 30  2009 /dev/snd/hwC0D0
crw-rw----  1 root root 116, 7 Jan 30  2009 /dev/snd/pcmC0D0c
crw-rw----  1 root root 116, 6 Jan 30  2009 /dev/snd/pcmC0D0p
crw-rw----  1 root root 116, 5 Jan 30  2009 /dev/snd/pcmC0D1p
crw-rw----  1 root root 116, 4 Jan 30  2009 /dev/snd/pcmC0D2c
crw-rw----  1 root root 116, 3 Jan 30  2009 /dev/snd/seq
crw-rw----  1 root root 116, 2 Jan 30  2009 /dev/snd/timer


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
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 1: ALC888 Digital [ALC888 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 2: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [VT82xx]

amixer: Mixer load hw:0 error: Invalid argument
Card hw:0 'VT82xx'/'HDA VIA VT82xx at 0xfebfc000 irq 17'
  Mixer name	: 'Realtek ALC888'
  Components	: 'HDA:10ec0888,18491e01,00100001'
  Controls      : 31
amixer: Mixer hw:0 load error: Invalid argument


!!Alsactl output
!!-------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module
w83627hf
hwmon_vid
hwmon
i2c_dev
udf
crc_itu_t
fuse
sco
bridge
stp
bnep
l2cap
bluetooth
sunrpc
ip6t_REJECT
nf_conntrack_ipv6
ip6table_filter
ip6_tables
ipv6
p4_clockmod
dm_multipath
uinput
tda827x
tda8290
tuner
snd_hda_intel
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
saa7134
ir_common
videodev
v4l1_compat
compat_ioctl32
snd_mixer_oss
v4l2_common
videobuf_dma_sg
i2c_viapro
snd_pcm
ppdev
videobuf_core
tveeprom
i2c_core
snd_timer
snd_page_alloc
via_rhine
mii
sata_via
parport_pc
snd_hwdep
snd
soundcore
pcspkr
parport
floppy
ata_generic
pata_acpi
pata_via



--Boundary-00=_uK0gJKT2S/YbHPR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_uK0gJKT2S/YbHPR--
