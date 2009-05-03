From: Guy Stalnaker <jstalnak@wisc.edu>
Subject: Issues with HP DV4 laptop sound after Ubuntu Jaunty
	9.04 upgrade
Date: Sat, 02 May 2009 23:58:44 -0500
Message-ID: <49FD2484.4000002@wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_uf7KqQv6G3KOf2bMcvhxMQ)"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agogare.doit.wisc.edu (agogare.doit.wisc.edu [144.92.197.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 945AC245FE
	for <alsa-devel@alsa-project.org>;
	Sun,  3 May 2009 06:58:52 +0200 (CEST)
Received: from avs-daemon.smtpauth2.wiscmail.wisc.edu by
	smtpauth2.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 7.0-5.01 32bit (built Feb 19
	2009)) id <0KJ100800XU41E00@smtpauth2.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Sat, 02 May 2009 23:58:52 -0500 (CDT)
Received: from [173.98.170.102]
	(173-98-170-102.pools.spcsdns.net [173.98.170.102])
	by smtpauth2.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 7.0-5.01 32bit (built Feb 19
	2009))
	with ESMTPSA id <0KJ10073FXU1U500@smtpauth2.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Sat, 02 May 2009 23:58:50 -0500 (CDT)
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

This is a multi-part message in MIME format.

--Boundary_(ID_uf7KqQv6G3KOf2bMcvhxMQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Hello again.

I was able to get my internal speakers working for my HP Pavilion Dv4
laptop by following the advice I found in the alsa-devel archives.  That
advice seems to have worked for quit a few people who found it by a post
I made to the Ubuntu Forums.

But now, after I have upgraded my Ubuntu from version 8.10 (when sound
worked) to version 9.04, sound no longer works correctly.  I have some
detailed information about the sequencing and the specific error.
Attached is an alsa-info.txt output.

Here's what I'm seeing (extracts from dmesg/kernel logs):

Apr 29 15:13:17 Harlindon kernel: [   19.937190] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Apr 29 15:13:17 Harlindon kernel: [   19.937270] HDA Intel 0000:00:14.2:
setting latency timer to 64

Apr 30 09:37:09 Harlindon kernel: [   19.941675] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Apr 30 09:37:09 Harlindon kernel: [   19.941750] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  1 16:06:01 Harlindon kernel: [   19.852324] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 16:06:01 Harlindon kernel: [   19.852398] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  1 16:13:43 Harlindon kernel: [   20.950985] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 16:13:43 Harlindon kernel: [   20.951060] HDA Intel 0000:00:14.2:
setting latency timer to 64

Commit Log for Fri May  1 16:41:58 2009 [Upgrade to Ubuntu Jaunty 9.04]

May  1 17:11:05 Harlindon kernel: [   20.318416] hda-intel: unable to
grab IRQ 0, disabling device
May  1 17:11:05 Harlindon kernel: [   20.318517] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  1 17:14:18 Harlindon kernel: [   22.977762] hda-intel: unable to
grab IRQ 0, disabling device
May  1 17:14:18 Harlindon kernel: [   22.977828] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  1 17:18:49 Harlindon kernel: [   21.105013] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 17:18:49 Harlindon kernel: [   21.105087] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  1 21:15:14 Harlindon kernel: [   19.776991] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 21:15:14 Harlindon kernel: [   19.777893] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  2 09:22:01 Harlindon kernel: [   20.540543] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  2 09:22:01 Harlindon kernel: [   20.540619] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  2 09:26:04 Harlindon kernel: [   19.819578] hda-intel: unable to
grab IRQ 0, disabling device
May  2 09:26:04 Harlindon kernel: [   19.819677] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  2 10:37:28 Harlindon kernel: [   20.175934] hda-intel: unable to
grab IRQ 0, disabling device
May  2 10:37:28 Harlindon kernel: [   20.175999] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  2 13:26:27 Harlindon kernel: [   20.610591] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  2 13:26:27 Harlindon kernel: [   20.610666] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  2 16:57:23 Harlindon kernel: [   19.885497] hda-intel: unable to
grab IRQ 0, disabling device
May  2 16:57:23 Harlindon kernel: [   19.885575] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  2 18:20:18 Harlindon kernel: [   22.605977] hda-intel: unable to
grab IRQ 0, disabling device
May  2 18:20:18 Harlindon kernel: [   22.606042] HDA Intel: probe of
0000:00:14.2 failed with error -16

What is damned peculiar is that is has sometimes worked (as you can see
above).  I can find no pattern however.  I HAVE downloaded an compiled
the latest alsa-driver-snapshot.  That last reboot has the same unable
to grab irq error.

Any suggestions are greatly appreciated.

-- 
Guy Stalnaker, I^2@DOIT, 1210 West Dayton Street, Room 3209 CSS, Madison
WI 53719-1220, jstalnak@wisc.edu, work 608.263.8035, cell 608.235.4718,
fax 608.265.6681, page page-guy@watchdog.doit.wisc.edu


--Boundary_(ID_uf7KqQv6G3KOf2bMcvhxMQ)
Content-type: text/plain; name=alsa-info.txt
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=alsa-info.txt

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Sun May  3 04:38:21 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu 9.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 9.04"


!!Kernel Information
!!------------------

Kernel release:    2.6.28-6-386
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.18
Utilities version:  1.0.18


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

 0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xd2410000 irq 19


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
01:05.1 Audio device: ATI Technologies Inc RS780 Azalia controller


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 103c:30fb
--
01:05.1 0403: 1002:960f
	Subsystem: 1002:960f


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
snd_hda_intel: model=hp-dv5


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
model : hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: ATI RS690/780 HDMI
Address: 0
Function Id: 0x1
Vendor Id: 0x1002791a
Subsystem Id: 0x00791a00
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x40]: 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 6 May  2 18:25 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 5 May  2 18:25 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 4 May  2 18:25 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116, 3 May  2 18:25 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 May  2 18:25 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [HDMI]

Card hw:0 'HDMI'/'HDA ATI HDMI at 0xd2410000 irq 19'
  Mixer name	: 'ATI RS690/780 HDMI'
  Components	: 'HDA:1002791a,00791a00,00100000'
  Controls      : 4
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.HDMI {
	control.1 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.2 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.3 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ppp_deflate
zlib_deflate
bsd_comp
ppp_async
crc_ccitt
ppp_generic
slhc
binfmt_misc
ppdev
rfcomm
bridge
stp
bnep
sco
l2cap
bluetooth
ipv6
container
sbs
pci_slot
sbshc
rfkill
input_polldev
cpufreq_powersave
cpufreq_stats
cpufreq_userspace
cpufreq_ondemand
cpufreq_conservative
freq_table
cbc
dm_crypt
sha256_generic
sha1_generic
sha512_generic
aes_i586
aes_generic
lp
parport
joydev
snd_hda_codec_atihdmi
snd_hda_intel
snd_seq_dummy
snd_hda_codec
snd_seq_oss
snd_seq_midi
snd_hwdep
snd_rawmidi
snd_pcm_oss
snd_mixer_oss
snd_seq_midi_event
psmouse
i2c_piix4
snd_pcm
uvcvideo
compat_ioctl32
serio_raw
snd_seq
i2c_core
sierra
snd_timer
snd_seq_device
videodev
v4l1_compat
usblp
evdev
usbserial
fglrx
snd
soundcore
snd_page_alloc
agpgart
battery
leds_hp_disk
led_class
shpchp
pci_hotplug
video
output
lis3lv02d
sdhci_pci
sdhci
mmc_core
ac
button
reiserfs
ata_generic
pata_acpi
pata_atiixp
sg
sr_mod
cdrom
sd_mod
crc_t10dif
usbhid
hid
atiixp
ahci
libata
r8169
mii
usb_storage
scsi_mod
dm_mirror
dm_region_hash
dm_log
dm_snapshot
dm_mod
thermal
processor
fan
fbcon
tileblit
font
bitblit
softcursor


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x03 0x18560010

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:



--Boundary_(ID_uf7KqQv6G3KOf2bMcvhxMQ)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary_(ID_uf7KqQv6G3KOf2bMcvhxMQ)--
