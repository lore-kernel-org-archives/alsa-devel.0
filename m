From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001206]: No Surround Sound (5.1) with analog speaker set on ASUS P4P800-VM and Suse 9.3 (Kernel 26.11.4-20a)
Date: Wed, 22 Jun 2005 22:32:34 +0200
Message-ID: <6d07f631910c04019ef0b93b4c02423a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C7BC1E4
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 22:32:34 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1206> 
======================================================================
Reported By:                marcmerz
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1206
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 9.3
Kernel Version:             Linux cinemaxx 2.6.11.4-20a-smp-matrox
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 SMP Fri May 27 20:49:09
CEST 2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             06-20-2005 20:39 CEST
Last Modified:              06-22-2005 22:32 CEST
======================================================================
Summary:                    No Surround Sound (5.1) with analog speaker set on
ASUS P4P800-VM and Suse 9.3 (Kernel 26.11.4-20a)
Description: 
The same hardware (Asus P4P800-VM with an analog surround set from
creative) was working fine under Suse 9.1 with Kernel 2.6.5. I then had to
change my HD (/dev/hda) due to harddisk crash and installed Suse 9.3 with
Kernel 2.6.11.4-20a (where i included module support for my Matrox G400
everything else is default config). It came with ALSA 1.08. I already got
the sources from the alsa homepage and updated to the current versions
(1.09b, 1.09a and 1.09 for drivers, utils, libs, tools etc.).
 
Meanwhile i spent more than 7 days now to get my DD5.1 Surround working in
6-channel mode but to no avail. When i do the speaker test, the front left
and front right are ok. Rear Left comes from the Rear Right speaker and
Rear Right comes from the left rear speaker. The center channel does not
do any sounds at all and the LFE output is on the left front speaker.
 
I checked my wirings a couple of times. I do have 'normal' sound in KDE
playing MP3's etc. and i can also use the 'Spread Front to Surround/LFE'
switch in kmix to get some sound from all speakers including center and
lfe.
 
When i play AC3 testfiles with a52dec, the center is always off (i.e. not
to hear) and the lfe output is going to the front left speaker. With
ac3dec i get the same result but on top of it, using 'ac3dec -6' the sound
is crackling and therefore useless (btw. this was also the case with Alsa
1.04|5 under Suse 9.1 with Kernel 2.6.5).
 
I can not believe that the same setup did work flawlessly under ALSA 1.05
and with a new kernel and current source drivers from the alsa project
homepage it is just not working in DD5.1.
 
Maybe there is a configuration mistake concerning plug:surround51 sending
output to the wrong channels but a) i did not change anything there and b)
i have no clue how to do that anyway.
 
Any help would be greatly appreciated.
 
Just some settings from my setup:
# lspci -v|grep audio  // (using acpi=off noapic in /boot/grub/menu.lst
does not make any difference
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)

# hwinfo --sound
21: PCI 1f.5: 0401 Multimedia audio controller
  [Created at pci.273]
  Unique ID: W60f.jRYEjR2QAA3
  SysFS ID: /devices/pci0000:00/0000:00:1f.5
  SysFS BusID: 0000:00:1f.5
  Hardware Class: sound
  Model: "ASUSTeK 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x24d5 "82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller"
  SubVendor: pci 0x1043 "ASUSTeK Computer Inc."
  SubDevice: pci 0x80b0
  Revision: 0x02
  Driver: "Intel ICH"
  I/O Ports: 0xe800-0xe8ff (rw)
  I/O Ports: 0xee80-0xeebf (rw)
  Memory Range: 0xfebff800-0xfebff9ff (rw,non-prefetchable)
  Memory Range: 0xfebff400-0xfebff4ff (rw,non-prefetchable)
  IRQ: 209 (170062 events)
  Driver Info https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0:
    Driver Status: snd-intel8x0 is active
    Driver Activation Cmd: "modprobe snd-intel8x0"
  Driver Info https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1:
    Driver Status: i810_audio is not active
    Driver Activation Cmd: "modprobe i810_audio"
  Config Status: cfg=yes, avail=yes, need=no, active=unknown

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jun  8 2005 for kernel 2.6.11.4-20a-smp-matrox (SMP).
 
# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1980 at 0xfebff800, irq 209

# cat /proc/asound/devices
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

# cat /proc/asound/modules
0 snd_intel8x0

# cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1

/etc/asound.state:
state.ICH5 {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Master Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Surround Playback Volume'
                value.0 28
                value.1 28
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value true
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 31
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'LFE Playback Switch'
                value true
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 31
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Surround Playback Volume'
                value.0 31
                value.1 31
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Master Playback Switch'
                value.0 true
                value.1 true
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 28
                value.1 28
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Mono Playback Switch'
                value false
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 0
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Phone Playback Switch'
                value false
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Phone Playback Volume'
                value 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Playback Switch'
                value true
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 31
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Line Playback Switch'
                value.0 true
                value.1 true
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 31
                value.1 31
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'CD Playback Switch'
                value.0 false
                value.1 false
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Aux Playback Switch'
                value.0 false
                value.1 false
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.24 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'PCM Playback Switch'
                value.0 true
                value.1 true
        }
        control.25 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 31
                value.1 31
        }
        control.26 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 Mic
                value.1 Mic
        }
        control.27 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 true
                value.1 true
        }
        control.28 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.29 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic1
        }
        control.30 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000f0000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000'
        }
        control.31 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf00000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000
        }
        control.32 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Default'
                value
'008200020000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000'
        }
        control.33 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Switch'
                value false
        }
        control.34 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 3'
                iface MIXER
                name 'IEC958 Playback AC97-SPSA'
                value 0
        }
        control.35 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 AC-Link
                comment.item.1 'A/D Converter'
                iface MIXER
                name 'IEC958 Playback Source'
                value 'A/D Converter'
        }
        control.36 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Exchange Front/Surround'
                value false
        }
        control.37 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Spread Front to Surround and Center/LFE'
                value false
        }
        control.38 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Off
                comment.item.1 '6 -> 4'
                comment.item.2 '6 -> 2'
                iface MIXER
                name Downmix
                value Off
        }
        control.39 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Shared
                comment.item.1 Independent
                iface MIXER
                name 'Surround Jack Mode'
                value Shared
        }
        control.40 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 '2ch'
                comment.item.1 '4ch'
                comment.item.2 '6ch'
                iface MIXER
                name 'Channel Mode'
                value '6ch'
        }
        control.41 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Stereo Mic'
                value false
        }
        control.42 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'External Amplifier'
                value false
        }
}

# lsmod|grep snd
snd_intel8x0           35136  0
snd_ac97_codec         84220  1 snd_intel8x0
snd_pcm               106500  2 snd_intel8x0,snd_ac97_codec
snd_timer              29700  1 snd_pcm
snd                    65796  4
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore              14048  1 snd
snd_page_alloc         13060  2 snd_intel8x0,snd_pcm
======================================================================

----------------------------------------------------------------------
 marcmerz - 06-22-05 22:24 
----------------------------------------------------------------------
I tried to install to confirm that Driver 1.06 is working with my setup as
well and got this:

cinemaxx:/usr/src/alsa-driver-1.0.6 # ./configure --with-debug=full
--with-cards=intel8x0 --with-sequencer=yes
checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for ranlib... ranlib
checking for a BSD-compatible install... /usr/bin/install -c
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory... /usr/src/alsa-driver-1.0.6
checking cross compile...
checking for directory with kernel source...
/lib/modules/2.6.11.4-20a-smp-matrox/build
checking for kernel version... 2.6.11.4-20a-smp-matrox
checking for GCC version... Kernel compiler:  Used compiler: gcc (GCC)
3.3.5 20050117 (prerelease) (SUSE Linux)

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for building
kernel.

checking for built-in ALSA... "no"
checking for existing ALSA module... "yes"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking for SUSE kernel... "auto"
checking for SUSE kernel... "yes"
checking to modify of kernel linux/kmod.h... "no"
checking for kernel linux/compiler.h... "yes"
checking for kernel linux/pm.h... "yes"
checking for kernel linux/spinlock.h... "yes"
checking for kernel linux/irq.h... "yes"
checking for kernel linux/threads.h... "yes"
checking for kernel linux/rwsem.h... "yes"
checking for kernel linux/gameport.h... "yes"
checking for kernel linux/devfs_fs_kernel.h... "yes"
checking for kernel linux/highmem.h... "yes"
checking for kernel linux/workqueue.h... "yes"
Removing a dummy linux/workqueue.h.
checking for kernel linux/dma-mapping.h... "yes"
Removing a dummy linux/dma-mapping.h.
checking for kernel asm/hw_irq.h... "yes"
checking for kernel linux/device.h... "yes"
Removing a dummy linux/device.h.
checking for kernel linux/jiffies.h... "yes"
Removing a dummy linux/jiffies.h.
checking for kernel linux/compat.h... "yes"
Removing a dummy linux/compat.h.
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for kernel linux/moduleparam.h... "yes"
Removing a dummy linux/moduleparam.h.
checking for kernel linux/syscalls.h... "yes"
Removing a dummy linux/syscalls.h.
checking for kernel module symbol versions... "yes"
checking for PCI support in kernel... "yes"
checking for I2C driver in kernel... module
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules...
/lib/modules/2.6.11.4-20a-smp-matrox/kernel/sound
checking for verbose printk... on
checking for debug level... full
checking for ISA support in kernel... "yes"
checking for processor type... i586
checking for i386 machine type... default
checking for SMP... "yes"
checking for Video device support in kernel... "yes"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "yes"
checking for strlcpy... "yes"
checking for snprintf... "yes"
checking for scnprintf... "yes"
checking for vmalloc_to_page... "yes"
checking for old kmod... "no"
checking for PDE... "yes"
checking for pci_set_consistent_dma_mask... "yes"
checking for tty->count is the atomic type... "no"
checking for video_get_drvdata... "yes"
checking for new remap_page_range... "yes"
checking for kcalloc... "yes"
checking for saved_config_space in pci_dev... "yes"
Removing local linux/pnp.h.
checking for driver version... 1.0.6
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "yes"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "yes"
checking for PC9800 support in kernel... "no"
checking for which soundcards to compile driver for... intel8x0
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: creating toplevel.config
config.status: creating utils/alsasound
config.status: creating utils/alsasound.posix
config.status: creating include/config.h
config.status: creating include/config1.h
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h
Hacking autoconf.h...


So ./configure went ok but then:


cinemaxx:/usr/src/alsa-driver-1.0.6 # make
if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make dep
make[1]: Entering directory `/usr/src/alsa-driver-1.0.6'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6 succeeded at 495
(offset 1 line).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7 succeeded at 508
(offset 1 line).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8 succeeded at 923
(offset 1 line).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 2735
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 2755
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 2808
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 succeeded at 2835
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6 succeeded at 2922
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7 succeeded at 2951
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8 succeeded at 2980
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9 succeeded at 3009
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 succeeded at 3038
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11 succeeded at 3061
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12 succeeded at 3079
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13 succeeded at 3099
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 succeeded at 3115
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=15 succeeded at 3151
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=16 succeeded at 3163
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=17 succeeded at 3201
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18 succeeded at 3350
(offset 6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=19 succeeded at 3366
(offset 6 lines).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 1237
(offset 309 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 321
(offset 29 lines).
copying file alsa-kernel/core/init.c
patching file init.c
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 1338
(offset 22 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 996
(offset 27 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 1809
(offset 76 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 1837
(offset 56 lines).
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 95
(offset 3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 148
(offset 3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 211
with fuzz 2 (offset 3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 succeeded at 725
(offset -178 lines).
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 390
(offset 14 lines).
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 2228
(offset 15 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 2406
(offset 15 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 2533
(offset 15 lines).
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/acore/oss'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 51
with fuzz 2 (offset 2 lines).
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 2500
(offset 45 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
make[4]: Entering directory `/usr/src/alsa-driver-1.0.6/acore/seq/instr'
make[4]: Leaving directory `/usr/src/alsa-driver-1.0.6/acore/seq/instr'
make[4]: Entering directory `/usr/src/alsa-driver-1.0.6/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 203
(offset 9 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 312
(offset 9 lines).
make[4]: Leaving directory `/usr/src/alsa-driver-1.0.6/acore/seq/oss'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/acore/seq'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/acore'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/i2c'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/i2c/other'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/i2c/other'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/i2c'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/drivers'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/drivers/opl3'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 succeeded at 414
(offset -2 lines).
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/drivers/opl3'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/drivers/opl4'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/drivers/opl4'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/drivers/mpu401'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/drivers/mpu401'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/drivers/vx'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/drivers/vx'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/drivers'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/isa'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/msnd'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/msnd'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/ad1816a'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/ad1816a'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/ad1848'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/ad1848'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/cs423x'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/cs423x'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/es1688'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/es1688'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/gus'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/gus'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/opti9xx'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/opti9xx'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/sb'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/sb'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/isa/wavefront'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa/wavefront'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/isa'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/synth'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/synth/emux'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/synth/emux'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/synth'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/pci'
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 762
(offset 13 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 773
(offset 13 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 2841
(offset 28 lines).
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/pdplus'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/pdplus'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/azx'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/azx'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/ac97'
copying file alsa-kernel/pci/ac97/ac97_proc.c
patching file ac97_proc.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 322
with fuzz 1.
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 341
with fuzz 1 (offset 2 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 succeeded at 398
(offset 2 lines).
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/ac97'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/ali5451'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/ali5451'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/au88x0'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/au88x0'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/cs46xx'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/cs46xx'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/emu10k1'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/emu10k1'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/ice1712'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/ice1712'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/korg1212'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/korg1212'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/mixart'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/mixart'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/nm256'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/nm256'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/rme9652'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/rme9652'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/trident'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/trident'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/ymfpci'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/ymfpci'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pci/vx222'
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci/vx222'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/pci'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/usb'
copying file alsa-kernel/usb/usbaudio.c
patching file usbaudio.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 68
(offset -1 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 1912
(offset 16 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 1929
(offset 16 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 succeeded at 3222
(offset 109 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6 succeeded at 3243
(offset 109 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7 succeeded at 3265
(offset 109 lines).
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/usb/usx2y'
copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/usb/usx2y'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/usb'
make[2]: Entering directory `/usr/src/alsa-driver-1.0.6/pcmcia'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pcmcia/vx'
copying file alsa-kernel/pcmcia/vx/vxpocket.c
patching file vxpocket.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 69
with fuzz 1 (offset -4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 176
(offset -5 lines).
copying file alsa-kernel/pcmcia/vx/vx_entry.c
patching file vx_entry.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 151
(offset 4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 234
(offset 4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 333
(offset 4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 succeeded at 387
(offset 4 lines).
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pcmcia/vx'
make[3]: Entering directory `/usr/src/alsa-driver-1.0.6/pcmcia/pdaudiocf'
copying file alsa-kernel/pcmcia/pdaudiocf/pdaudiocf.c
patching file pdaudiocf.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 29
with fuzz 1.
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 succeeded at 59
with fuzz 1 (offset -3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 81
(offset -3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 succeeded at 193
(offset -3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6 succeeded at 280
(offset -6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7 succeeded at 378
(offset -6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8 succeeded at 449
(offset -6 lines).
make[3]: Leaving directory `/usr/src/alsa-driver-1.0.6/pcmcia/pdaudiocf'
make[2]: Leaving directory `/usr/src/alsa-driver-1.0.6/pcmcia'
make[1]: Leaving directory `/usr/src/alsa-driver-1.0.6'
make -C /lib/modules/2.6.11.4-20a-smp-matrox/build
SUBDIRS=/usr/src/alsa-driver-1.0.6/kbuild  modules
make[1]: Entering directory `/usr/src/linux-2.6.11.4-20a'

WARNING: Symbol version dump /usr/src/linux-2.6.11.4-20a/Module.symvers is
 missing; modules will have no modversions.

  CC [M]  /usr/src/alsa-driver-1.0.6/kbuild/../acore/memalloc.o
/usr/src/alsa-driver-1.0.6/acore/memalloc.c:54: error: initializer element
is not constant
/usr/src/alsa-driver-1.0.6/acore/memalloc.c:54: error: (near
initialization for `__param_arr_enable.num')
make[3]: *** [/usr/src/alsa-driver-1.0.6/kbuild/../acore/memalloc.o] Error
1
make[2]: *** [/usr/src/alsa-driver-1.0.6/kbuild/../acore] Error 2
make[1]: *** [_module_/usr/src/alsa-driver-1.0.6/kbuild] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.11.4-20a'
make: *** [compile] Error 2


Therefore for the moment i can not test with Alsa Driver 1.06 (got the
tarball from the alsa-project homepage.

@rlrevell
I can confirm that with setting "Surround Jack Mode" to "Independent" i
have only front speaker working, too. It is like rraptorr said, the
P4P800-VM does only have 3 jacks and in 6-channel mode the rear,center/lfe
is shared with mic in,line in.

----------------------------------------------------------------------
 rraptorr - 06-22-05 22:32 
----------------------------------------------------------------------
Alsa-driver 1.0.6 is not working with recent kernels. I've altered it a
bit, to make it compile and work, but this isn't good solution (by altered
I mean commented out some code:)).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-20-05 20:39 marcmerz       New Issue                                    
06-20-05 20:39 marcmerz       Distribution              => Suse 9.3        
06-20-05 20:39 marcmerz       Kernel Version            => Linux cinemaxx
2.6.11.4-20a-smp-matrox https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
SMP Fri May 27 20:49:09 CEST 2005 i686 i686 i386 GNU/Linux
06-21-05 11:26 tiwai          Note Added: 0005105                          
06-21-05 20:29 marcmerz       Note Added: 0005113                          
06-22-05 01:08 marcmerz       Note Added: 0005115                          
06-22-05 01:20 marcmerz       Note Added: 0005116                          
06-22-05 01:43 rlrevell       Note Added: 0005117                          
06-22-05 10:04 pzad           Note Added: 0005119                          
06-22-05 11:49 tiwai          Note Added: 0005124                          
06-22-05 11:53 tiwai          Note Added: 0005125                          
06-22-05 12:37 marcmerz       Note Added: 0005127                          
06-22-05 12:44 tiwai          Note Added: 0005128                          
06-22-05 12:48 tiwai          Note Added: 0005129                          
06-22-05 12:51 marcmerz       Note Added: 0005130                          
06-22-05 12:55 marcmerz       Note Added: 0005131                          
06-22-05 18:03 tiwai          Note Added: 0005138                          
06-22-05 19:55 marcmerz       File Added: ac97#0-0                         
06-22-05 19:55 marcmerz       File Added: ac97#0-0+regs                    
06-22-05 19:55 marcmerz       Note Added: 0005146                          
06-22-05 19:57 marcmerz       File Added: alsasound                        
06-22-05 20:18 rraptorr       Note Added: 0005147                          
06-22-05 20:19 rraptorr       File Added: codec97                          
06-22-05 20:34 rraptorr       Note Added: 0005148                          
06-22-05 20:35 rraptorr       Note Edited: 0005147                         
06-22-05 20:35 rraptorr       Note Deleted: 0005148                        
06-22-05 20:50 rraptorr       Issue Monitored: rraptorr                    
06-22-05 21:06 marcmerz       Note Edited: 0005146                         
06-22-05 21:13 marcmerz       Note Added: 0005149                          
06-22-05 21:17 rlrevell       Note Added: 0005150                          
06-22-05 21:18 marcmerz       File Added: codec97-marcmerz                    
06-22-05 21:26 rraptorr       Note Added: 0005151                          
06-22-05 22:24 marcmerz       Note Added: 0005152                          
06-22-05 22:32 rraptorr       Note Added: 0005153                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
