From: Damien Zammit <damien.zammit@gmail.com>
Subject: Digidesign Mbox2 - usb support
Date: Mon, 17 Aug 2009 16:46:26 +1000
Message-ID: <4A88FCC2.5060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D0D5245E8
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 08:46:37 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id l33so612929rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2009 23:46:36 -0700 (PDT)
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

I compiled the latest stable ALSA and kernel, and all the utilities.

!!################################
!!ALSA Information Script v 0.4.57
!!################################

!!Script ran on: Mon Aug 17 06:39:10 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu 8.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 8.04"


!!DMI Information
!!---------------

Manufacturer:      Dell Computer Corporation
Product Name:      Latitude D600


!!Kernel Information
!!------------------

Kernel release:    2.6.30.4
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.20
Utilities version:  1.0.20


!!Loaded ALSA modules
!!-------------------

snd_usb_audio


!!Sound Servers on this system
!!----------------------------

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

  1 [M2             ]: USB-Audio - Mbox 2
                       Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1f.5 0401: 8086:24c5 (rev 01)
	Subsystem: 1028:011d


!!Modprobe options (Sound related)
!!--------------------------------

snd-bt87x: index=-2
snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=1
snd-bt87x: index=-2
snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_usb_audio
	async_unlink : Y
	device_setup : 0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	ignore_ctl_error : N
	index : 1,-1,-1,-1,-1,-1,-1,-1
	nrpacks : 8
	pid : -1,-1,-1,-1,-1,-1,-1,-1
	vid : -1,-1,-1,-1,-1,-1,-1,-1


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 32 Aug 17 15:08 /dev/snd/controlC1
crw-rw----+ 1 root audio 116, 40 Aug 17 15:08 /dev/snd/midiC1D0
crw-rw----+ 1 root audio 116, 56 Aug 17 16:36 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116, 48 Aug 17 16:36 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116,  1 Aug 17 14:50 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Aug 17 14:50 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

# ALSA library configuration file

# Include settings that are under the control of asoundconf(1).
# (To disable these settings, comment out this line.)
</home/dczammit/.asoundrc.asoundconf>



!!asoundconf-generated config file

# ALSA library configuration file managed by asoundconf(1).
#
# MANUAL CHANGES TO THIS FILE WILL BE OVERWRITTEN!
#
# Manual changes to the ALSA library configuration should be implemented
# by editing the ~/.asoundrc file, not by editing this file.
defaults.rawmidi.card 0
defaults.rawmidi.device 0
defaults.rawmidi.subdevice -1
defaults.hwdep.card 0
defaults.hwdep.device 0
defaults.timer.class 2
defaults.timer.sclass 0
defaults.timer.card 0
defaults.timer.device 0
defaults.timer.subdevice 0
defaults.namehint.showall off
defaults.namehint.basic on
defaults.namehint.extended off


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 1: M2 [Mbox 2], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 1: M2 [Mbox 2], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 1 [M2]

Card hw:1 'M2'/'Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed'
   Mixer name	: ''
   Components	: 'USB0dba:3000'
   Controls      : 0
   Simple ctrls  : 0


!!Alsactl output
!!-------------

--startcollapse--
state.M2 {
	control {
	}
}
--endcollapse--




jackd 0.116.2
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 48000
creating alsa driver ... hw:1|hw:1|256|2|48000|2|2|nomon|swmeter|-|32bit
control device hw:1
configuring for 48000Hz, period = 256 frames (5.3 ms), buffer = 2 periods
ALSA: final selected sample format for capture: 24bit little-endian
ALSA: use 2 periods for capture
ALSA: cannot set hardware parameters for capture
ALSA: cannot configure capture channel
cannot load driver module alsa


[ 6387.449014] WARNING: at sound/usb/usbaudio.c:1314 
snd_usb_hw_params+0xbc8/0xc10 [snd_usb_audio]()
[ 6387.449056] Hardware name: Latitude D600
[ 6387.449059] Modules linked in: snd_usb_audio snd_pcm snd_page_alloc 
snd_usb_lib snd_hwdep binfmt_misc radeon drm i2c_core rfcomm l2cap 
bluetooth ppdev sbs sbshc container acpi_cpufreq cpufreq_userspace 
cpufreq_stats cpufreq_powersave cpufreq_ondemand freq_table 
cpufreq_conservative ipv6 dm_crypt snd_seq_midi snd_rawmidi 
snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore lp 
af_packet joydev pcmcia yenta_socket rsrc_nonstatic video output 
pcmcia_core parport_pc parport psmouse serio_raw button battery ac 
processor pcspkr intel_agp shpchp agpgart pci_hotplug iTCO_wdt 
iTCO_vendor_support dcdbas evdev sr_mod sg cdrom sd_mod usbhid hid 
ata_piix pata_acpi ata_generic tg3 firmware_class libphy libata uhci_hcd 
ehci_hcd usbcore scsi_mod raid10 raid456 raid6_pq async_xor async_memcpy 
async_tx xor raid1 raid0 multipath linear md_mod dm_mirror 
dm_region_hash dm_log dm_snapshot dm_mod thermal fan thermal_sys fuse
[ 6387.449148] Pid: 25866, comm: jackd Tainted: G        W  2.6.30.4 #1
[ 6387.449151] Call Trace:
[ 6387.449165]  [<f81121d8>] ? snd_usb_hw_params+0xbc8/0xc10 [snd_usb_audio]
[ 6387.449175]  [<f81121d8>] ? snd_usb_hw_params+0xbc8/0xc10 [snd_usb_audio]
[ 6387.449191]  [<c012c03f>] ? warn_slowpath_common+0x7f/0xb0
[ 6387.449201]  [<f81121d8>] ? snd_usb_hw_params+0xbc8/0xc10 [snd_usb_audio]
[ 6387.449206]  [<c012c083>] ? warn_slowpath_null+0x13/0x20
[ 6387.449216]  [<f81121d8>] ? snd_usb_hw_params+0xbc8/0xc10 [snd_usb_audio]
[ 6387.449237]  [<f80eae90>] ? snd_pcm_hw_params_choose+0x30/0xa0 [snd_pcm]
[ 6387.449248]  [<f80e6fd0>] ? snd_pcm_hw_params+0xe0/0x320 [snd_pcm]
[ 6387.449254]  [<c0271dce>] ? copy_from_user+0x2e/0x70
[ 6387.449265]  [<f80e7346>] ? snd_pcm_hw_params_user+0x36/0x80 [snd_pcm]
[ 6387.449276]  [<f80e7c06>] ? snd_pcm_common_ioctl1+0x7f6/0x1140 [snd_pcm]
[ 6387.449281]  [<c0129385>] ? check_preempt_wakeup+0xd5/0x160
[ 6387.449286]  [<c01242e9>] ? try_to_wake_up+0xa9/0x200
[ 6387.449292]  [<c01b80b5>] ? pollwake+0x45/0x50
[ 6387.449296]  [<c0124440>] ? default_wake_function+0x0/0x10
[ 6387.449306]  [<c011f0fb>] ? __wake_up_common+0x4b/0x80
[ 6387.449310]  [<c01201f5>] ? __wake_up_sync_key+0x45/0x80
[ 6387.449314]  [<c01bf8cd>] ? mnt_drop_write+0x1d/0xe0
[ 6387.449319]  [<c01bbebb>] ? file_update_time+0x7b/0xc0
[ 6387.449325]  [<c01b06ee>] ? pipe_write+0x32e/0x450
[ 6387.449337]  [<f80e85de>] ? snd_pcm_capture_ioctl1+0x8e/0x400 [snd_pcm]
[ 6387.449348]  [<f80e8993>] ? snd_pcm_capture_ioctl+0x43/0x50 [snd_pcm]
[ 6387.449359]  [<f80e8950>] ? snd_pcm_capture_ioctl+0x0/0x50 [snd_pcm]
[ 6387.449364]  [<c01b629b>] ? vfs_ioctl+0x2b/0x90
[ 6387.449367]  [<c01b65d0>] ? do_vfs_ioctl+0x2d0/0x510
[ 6387.449374]  [<c0399075>] ? __schedule+0x235/0x730
[ 6387.449378]  [<c01a9b0d>] ? vfs_write+0xfd/0x160
[ 6387.449382]  [<c01b6866>] ? sys_ioctl+0x56/0x70
[ 6387.449387]  [<c0102dd4>] ? sysenter_do_call+0x12/0x28
[ 6387.449391] ---[ end trace 8fe22d9a0585e3c1 ]---
