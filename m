From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in 2.6.11 kernel
Date: Mon, 20 Jun 2005 10:59:38 +0200
Message-ID: <f1a24ac6a3eb26b5fe92244a88bb7d30@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6076F1CA
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2005 10:59:39 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023> 
======================================================================
Reported By:                yafrank
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1023
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.8_FC3
======================================================================
Date Submitted:             03-30-2005 14:25 CEST
Last Modified:              06-20-2005 10:59 CEST
======================================================================
Summary:                    ens1371 pcm not work in 2.6.11 kernel
Description: 
I'm using FC3 and my Creative SB AudioPCI 64V sound card works fine in 
2.6.10-1.770_FC3 kernel. After I replaced the kernel to 2.6.11 from
kernel.org or 2.6.11-1.8_FC3 from redhat, there is no sound anymore. I
noticed that the 2.6.11 kernel uses alsa 1.0.8 driver, yet userspace
alsa-lib and utility in fc3 are 1.0.6. So I upgrade them to 1.0.8 too.
Still, there is no sound and alsamixer doesn't show any pcm option.
Fortunately, the 1.0.8 lib and utility backward compatible with 1.0.6
driver in 2.6.10 kernel, so they were kept. The sound card uses ens1371
kernel module. And my /etc/modprobe.conf is this:

alias snd-card-0 snd-ens1371
alias sound-slot-0 snd-ens1371
install snd-ens1371 /sbin/modprobe --ignore-install snd-ens1371 &&
/usr/sbin/alsactlrestore >/dev/null 2>&1 || :
remove snd-ens1371 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-ens1371
alias usb-controller uhci-hcd
alias net-pf-10 off
alias ipv6 off
alias eth0 8139too


======================================================================

----------------------------------------------------------------------
 tiwai - 03-30-05 18:08 
----------------------------------------------------------------------
First check whether the sound driver is properly loaded.  See
/proc/asound/cards output.

ALso, please elaborate the situation "no sound".  Can you open alsamixer? 
Does aplay start (try -vv to show VU meter) ?

----------------------------------------------------------------------
 yafrank - 03-31-05 10:49 
----------------------------------------------------------------------
The ens1371 kernel module is loaded in 2.6.11
[frank@twinhead html]$ uname -a
Linux twinhead.localdomain 2.6.11-prep
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Wed Mar 30 17:11:30 CST
2005
i686 i686 i386 GNU/Linux
[frank@twinhead html]$ cat /proc/asound/cards0
[AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                   Ensoniq AudioPCI ENS1371 at 0xfcc0, irq 5
[frank@twinhead html]$ /sbin/lsmod | grep snd
snd_ens1371            28452  1
snd_rawmidi            27808  1 snd_ens1371
snd_seq_device          8972  1 snd_rawmidi
snd_ac97_codec         67576  1 snd_ens1371
snd_pcm_oss            49328  0
snd_mixer_oss          18048  2 snd_pcm_oss
snd_pcm                94472  3 snd_ens1371,snd_ac97_codec,snd_pcm_oss
snd_timer              31492  1 snd_pcm
snd                    55652  8
snd_ens1371,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11232  2 snd
snd_page_alloc          9988  1 snd_pcm

    As concern to "no sound", I've tested xmms playing mp3 file, mplayer
with wma and aplay with wav file. Alsamixer can always be invoked, but PCM
channel is missing if 2.6.11 kernel used. It seems that the former PCM
volume setting is now occupied by "Center" channel. Enable every channel
and miximum each volume setting in alsamixer doens't help either. 
    Aplay can be started without any error and VU meter can be seen if -vv
option applied.

----------------------------------------------------------------------
 yafrank - 03-31-05 13:14 
----------------------------------------------------------------------
More info of the sound card.
[root@twinhead ~]# lspci -vvv | grep "audio" -A8
00:06.0 Multimedia audio controller: Creative Labs Ectiva EV1938
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0e70
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort- >SERR- <PERR-
        Latency: 96 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at fcc0 [size=64]
        Region 1: I/O ports at fc40 [size=32]
        Capabilities: [dc] Power Management version 1

    If other info is needed, just let me know.

----------------------------------------------------------------------
 perex - 03-31-05 13:23 
----------------------------------------------------------------------
Could you try to compile and test the 1.0.9rc2 drivers?

----------------------------------------------------------------------
 yafrank - 03-31-05 17:08 
----------------------------------------------------------------------
Here is what I did:
[root@twinhead alsa-driver-1.0.9rc2]# rpm -i
/usr/local/src/kernel/kernel-2.6.11-1.8_FC3.src.rpm
[root@twinhead alsa-driver-1.0.9rc2]# rpmbuild -bp --target=i686
/usr/src/redhat/SPECS/kernel-2.6.spec
[root@twinhead kernel]# ln -s
/usr/src/redhat/BUILD/kernel-2.6.11/linux-2.6.11/include/sound/version.h
/usr/src/redhat/BUILD/kernel-2.6.11/linux-2.6.11/include/linux/
[root@twinhead alsa-driver-1.0.9rc2]# ./configure --with-redhat=yes
--with-cards=ens1371
--with-kernel=/usr/src/redhat/BUILD/kernel-2.6.11/linux-2.6.11
--with-sequencer=yes
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
checking for current directory...
/usr/local/src/kernel/alsa-driver-1.0.9rc2
checking cross compile...
checking for directory with kernel source...
/usr/src/redhat/BUILD/kernel-2.6.11/linux-2.6.11
checking for directory with kernel build...
/lib/modules/2.6.11-prep/build
checking for kernel version... 0.0.0
checking for GCC version... Kernel compiler:  Used compiler: gcc (GCC)
3.4.2 20041017 (Red Hat 3.4.2-6.fc3)

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for building
kernel.

checking for built-in ALSA... "no"
checking for existing ALSA module... "no"
checking for Red Hat kernel... "yes"
checking for SUSE kernel... "auto"
checking for SUSE kernel... "no"
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
checking for kernel linux/dma-mapping.h... "yes"
checking for kernel asm/hw_irq.h... "no"
checking for kernel linux/device.h... "yes"
checking for kernel linux/jiffies.h... "yes"
checking for kernel linux/compat.h... "yes"
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for kernel linux/moduleparam.h... "yes"
checking for kernel linux/syscalls.h... "yes"
checking for kernel linux/firmware.h... "yes"
checking for exported symbol dump_stack... grep:
/usr/src/redhat/BUILD/kernel-2.6.11/linux-2.6.11/kernel/ksyms.c: No such
file or directory
"no"
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "no"
checking for I2C driver in kernel... unknown
checking for firmware loader... unknown
checking for directory to store kernel modules... /lib/modules/0.0.0/misc
checking for verbose printk... on
checking for debug level... none
checking for processor type... "unknown"
checking for SMP... "no"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "no"
checking for strlcpy... "no"
checking for snprintf... "no"
checking for vsnprintf... "no"
checking for scnprintf... "no"
checking for sscanf... "no"
checking for vmalloc_to_page... "no"
checking for old kmod... "yes"
checking for PDE... "no"
checking for pci_set_consistent_dma_mask... "no"
checking for pci_dev_present... "no"
checking for msleep... "no"
checking for tty->count is the atomic type... "no"
checking for remap_pfn_range... "no"
checking for new remap_page_range... "no"
checking for kcalloc... "no"
checking for saved_config_space in pci_dev... "no"
checking for old kill_fasync... "no"
checking for dma_addr_t... "no"
checking for MUTEX macros... "no"
checking for driver version... 1.0.9rc2
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "no"
checking for HPET support... "no"
checking for Procfs support... "no"
checking for USB support... "no"
checking for USB module support... "no"
checking for PC-Speaker hook... "no"
checking for kernel PCMCIA
checking for PCMCIA support... "no"
checking for PCMCIA module support... "no"
checking for PC9800 support in kernel... "no"
checking for parallel port support... "no"
checking for parallel port module support... "no"
checking for which soundcards to compile driver for... configure: error:
Unsupportedsoundcard ens1371

----------------------------------------------------------------------
 mmadore - 04-06-05 18:41 
----------------------------------------------------------------------
Hi,

I am seeing the same behavior.

The sound card is a Creative Labs CT4730 (Ectiva EV1938 - PCI-ID
1102:8938)

Under stock kernel 2.6.10, the mixer works correctly and I can hear sounds
playing.  After upgrading to 2.6.11 or higher, the PCM channel is missing
from alsamixer.  Trying to play any sounds results in silence, and there
aren't any error messages.

I also tried the 1.0.9rc2 drivers, libs and utilities with the same
results.

What can I do to help debug this problem?

Mike

----------------------------------------------------------------------
 tiwai - 04-07-05 16:04 
----------------------------------------------------------------------
Might be some ac97 problem.  Please attach the contents of
/etc/asound.state and /proc/asound/card0/codec97#0/* files.

----------------------------------------------------------------------
 mmadore - 04-07-05 18:32 
----------------------------------------------------------------------
Hi,

I have attached the files you requested.  Also if I replace the following
files in the current version with those from 2.6.10, then I am able to get
sound working.  Hopefully this will narrow it down a little bit.

sound/core/pcm.c 
sound/core/pcm_lib.c 
sound/core/pcm_memory.c 
sound/core/pcm_native.c 
sound/pci/ac97/*.c 
sound/pci/ac97/*.h 
include/sound/pcm.h 
include/sound/pcm-indirect.h 
include/sound/pcm_params.h 
include/sound/ac97_codec.h 
include/sound/ak4531_codec.h

----------------------------------------------------------------------
 yafrank - 04-12-05 06:02 
----------------------------------------------------------------------
Just came back from vacation. I've read tiwai's request of
/etc/asound.state and /proc/asound/card0/codec97#0/* files. Since someone
else had attached them already, I'll paste mine here avoiding overwritten.
The former customized 2.6.11-1.8_FC3 kernel had been removed and this time
I'm using 2.6.11-1.14_FC3 with similar behavior. 

[frank@twinhead ~]$ cd /proc/asound/card0/codec97#0/
[frank@twinhead codec97#0]$ ls
ac97#0-0  ac97#0-0+regs
[frank@twinhead codec97#0]$ cat ac97#0-0
0-0/0: 0x8a058384
?&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=65533;

Capabilities     : -dedicated MIC PCM IN channel- -bass & treble-
DAC resolution   : 16-bit
ADC resolution   : 20-bit
3D enhancement   : Reserved 29

Current setup
Mic gain         : +20dB [+0dB]
POP path         : post 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : on
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : off
Extended modem ID: codec=3 CID2 CID1 HSET LIN2 LIN1
Modem status     : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO)
PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 65535Hz
Line2 rate       : 65535Hz
Headset rate     : 65535Hz
[frank@twinhead codec97#0]$ cat ac97#0-0+regs
0:00 = ffff
0:02 = 0140
0:04 = 9f1f
0:06 = 8000
0:08 = ffff
0:0a = ffff
0:0c = 811f
0:0e = 8001
0:10 = 8001
0:12 = 8101
0:14 = 9f1f
0:16 = 9f1f
0:18 = 9f1f
0:1a = 8101
0:1c = 9818
0:1e = 0000
0:20 = ffff
0:22 = 0000
0:24 = 0000
0:26 = ffff
0:28 = 000f
0:2a = ffff
0:2c = ffff
0:2e = ffff
0:30 = ffff
0:32 = ffff
0:34 = ffff
0:36 = ffff
0:38 = ffff
0:3a = ffff
0:3c = ffff
0:3e = ffff
0:40 = ffff
0:42 = ffff
0:44 = ffff
0:46 = ffff
0:48 = ffff
0:4a = ffff
0:4c = ffff
0:4e = ffff
0:50 = ffff
0:52 = ffff
0:54 = ffff
0:56 = ffff
0:58 = ffff
0:5a = ffff
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = ffff
0:64 = ffff
0:66 = ffff
0:68 = ffff
0:6a = ffff
0:6c = ffff
0:6e = ffff
0:70 = ffff
0:72 = ffff
0:74 = ffff
0:76 = ffff
0:78 = ffff
0:7a = ffff
0:7c = ffff
0:7e = 8384

[frank@twinhead codec97#0]$ cat /etc/asound.state
state.AudioPCI {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Playback Switch'
                value true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 29
                value.1 29
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value false
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 0
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
                value 0
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Mono Playback Switch'
                value false
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 0
        }
        control.9 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Bass'
                value 2
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Treble'
                value 0
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PC Speaker Playback Switch'
                value true
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
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
                comment.range '0 - 15'
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
                value false
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 0
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
                comment.count 1
                iface MIXER
                name 'Line Playback Switch'
                value false
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'CD Playback Switch'
                value false
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
                comment.count 1
                iface MIXER
                name 'Video Playback Switch'
                value false
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Video Playback Volume'
                value.0 0
                value.1 0
        }
        control.24 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Aux Playback Switch'
                value false
        }
        control.25 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.26 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PCM Playback Switch'
                value true
        }
        control.27 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 10
                value.1 10
        }
        control.28 {
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
                value.0 'Mix Mono'
                value.1 'Mix Mono'
        }
        control.29 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.30 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Capture Switch'
                value false
        }
        control.31 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Mic Capture Volume'
                value 0
        }
}

----------------------------------------------------------------------
 tiwai - 04-12-05 16:29 
----------------------------------------------------------------------
I see "PCM" control in both /etc/asound.state files.
So I don't understand why PCM disappears on your mixer app.
Are you sure that /etc/asound.state you attached is the newest output from
alsactl?  Run "alsactl store" as root, and check whether "PCM Playback
Volume" and "PCM Playback Switch" exist on /etc/asound.state.

----------------------------------------------------------------------
 yafrank - 04-12-05 19:46 
----------------------------------------------------------------------
The /etc/asound.state I pasted is the one I'm currently using in
2.6.10-1.770_FC3 kernel and it works fine with it. I'll get the
correspondent in 2.6.11-1.14_FC3 after rebooting and running "alsactl
store" right away.

----------------------------------------------------------------------
 yafrank - 04-12-05 20:00 
----------------------------------------------------------------------
The former pasted /etc/asound.state and /proc/asound/card0/codec97#0/* are
actually both from 2.6.11-1.14_FC3 kernel. I only forgot to run a "alsactl
store" then. The latest /etc/asound.state should be as following:
 
[root@twinhead ~]# uname -r
2.6.11-1.14_FC3
[root@twinhead ~]# cp /etc/asound.state /tmp
[root@twinhead ~]# alsactl store
[root@twinhead ~]# cat /etc/asound.state
state.AudioPCI {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 0
                value.1 0
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value false
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 31
        }
        control.4 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'LFE Playback Switch'
                value false
        }
        control.5 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 0
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 0
        }
        control.7 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Bass'
                value 0
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Treble'
                value 0
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PC Speaker Playback Switch'
                value false
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value 0
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.13 {
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
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Capture Switch'
                value true
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Mic Capture Volume'
                value 0
        }
        control.17 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic1
        }
        control.18 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Center'
                value 0
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Depth'
                value 0
        }
}

----------------------------------------------------------------------
 mmadore - 04-12-05 21:11 
----------------------------------------------------------------------
Hi,

I am adding my /etc/asound.state after running alsactl store.  This is
with the 1.0.9rc2 drivers, libs and utilities.

----------------------------------------------------------------------
 yafrank - 06-17-05 09:55 
----------------------------------------------------------------------
Just test the latest driver 1.0.9b with offical kernel 2.6.12-rc6-git8 in
my FC3 with no help. There is still no pcm option in alsamixer.

----------------------------------------------------------------------
 yafrank - 06-17-05 11:45 
----------------------------------------------------------------------
Tired of waiting, I've tested downgrading alsa to 1.0.7 in kernel
2.6.12-rc6-git8 with success in my fc3. First build a customized kernel
without any alsa or oss option enabled in config, but only enable sound
support. Then goto extracted alsa-1.0.7 source directory, execute
following:
./configure --with-kernel=</path/to/kernel/source>
--with-build=</path/to/kernel/source> --with-cards=ens1371
--with-sequencer=yes; make; make install-modules

----------------------------------------------------------------------
 tiwai - 06-17-05 14:44 
----------------------------------------------------------------------
OK, then the problem is that the ac97 chip on your board cheats the
ac97_codec.c code as if there is no PCM control.
Please try the following with the latest ALSA code:
- compile with debug option
- as root
    # echo 18 8000 > /proc/asound/card0/codec97#0/ac97#0-0+regs
  and
    # cat /proc/asound/card0/codec97#0/ac97#0-0+regs
  and check the output of the register 0x18 again whether the value
  0x8000 is read.
  Then, try the value 0x000 instead of 0x8000 above, and check again.
- similarly, try values 0x2020, 0x1010 and 0x0101 and read/compare again.

----------------------------------------------------------------------
 yafrank - 06-18-05 04:26 
----------------------------------------------------------------------
I'm not quite sure if my antique laptop bought in 2k, CII 366M/192M/Intel
BX/20G, contains any ac97 chip on borad. Anyway, I'm compiling
2.6.12-rc6-git8 kernel and 1.0.9b alsa now. Alsa compile using
"./configure --with-kernel=/path/to/kernel --with-build=/path/to/kernel
--with-debug=full --with-cards=ens1371 --with-sequencer=yes; make; make
install-modules". Before doing the test, what are those values represent?

----------------------------------------------------------------------
 yafrank - 06-18-05 05:19 
----------------------------------------------------------------------
Boot to newly compiled 2.6.12-rc6-git8 kernel with 1.0.9b alsa driver,
[root@twinhead ~]# cd /proc/asound/card0/codec97#0/
[root@twinhead codec97#0]# echo 18 8000 > ac97#0-0+regs
[root@twinhead codec97#0]# cat ac97#0-0+regs > /tmp/alsa-ac97-test  ##
uploaded
[root@twinhead codec97#0]# grep 18 /tmp/alsa-ac97-test
0:18 = 8101
[root@twinhead codec97#0]# echo 18 000 > ac97#0-0+regs
[root@twinhead codec97#0]# cat ac97#0-0+regs > /tmp/alsa-ac97-test-000
[root@twinhead codec97#0]# grep 18 /tmp/alsa-ac97-test-000
0:18 = 8101
[root@twinhead codec97#0]# echo 18 2020 > ac97#0-0+regs
[root@twinhead codec97#0]# cat ac97#0-0+regs > /tmp/alsa-ac97-test-2020
[root@twinhead codec97#0]# grep 18 /tmp/alsa-ac97-test-2020
0:18 = 8101
[root@twinhead codec97#0]# echo 18 1010 > ac97#0-0+regs
[root@twinhead codec97#0]# cat ac97#0-0+regs > /tmp/alsa-ac97-test-1010
[root@twinhead codec97#0]# grep 18 /tmp/alsa-ac97-test-1010
0:18 = 8101
[root@twinhead codec97#0]# echo 18 0101 > ac97#0-0+regs
[root@twinhead codec97#0]# cat ac97#0-0+regs > /tmp/alsa-ac97-test-0101
[root@twinhead codec97#0]# grep 18 /tmp/alsa-ac97-test-0101
0:18 = 8101
[root@twinhead tmp]# diff alsa-ac97-test alsa-ac97-test-000
1c1
< 0:00 = 0140
---
> 0:00 = 7605
14c14
< 0:1a = 8000
---
> 0:1a = 0000
[root@twinhead tmp]# diff alsa-ac97-test alsa-ac97-test-2020
1c1
< 0:00 = 0140
---
> 0:00 = 7605
8c8
< 0:0e = 8001
---
> 0:0e = 801f
15c15
< 0:1c = 8000
---
> 0:1c = 0000
[root@twinhead tmp]# diff alsa-ac97-test alsa-ac97-test-1010
1c1
< 0:00 = 0140
---
> 0:00 = 7605
6,7c6,7
< 0:0a = ffff
< 0:0c = 811f
---
> 0:0a = 811f
> 0:0c = 801e
14c14
< 0:1a = 8000
---
> 0:1a = 1010
[root@twinhead tmp]# diff alsa-ac97-test alsa-ac97-test-0101
1c1
< 0:00 = 0140
---
> 0:00 = 7605
9c9
< 0:10 = 801f
---
> 0:10 = 8101
14c14
< 0:1a = 8000
---
> 0:1a = 0101

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 14:25 yafrank        New Issue                                    
03-30-05 14:25 yafrank        Distribution              => Fedora Core 3   
03-30-05 14:25 yafrank        Kernel Version            => 2.6.11-1.8_FC3  
03-30-05 18:08 tiwai          Note Added: 0004266                          
03-31-05 10:49 yafrank        Note Added: 0004277                          
03-31-05 13:14 yafrank        Note Added: 0004279                          
03-31-05 13:23 perex          Note Added: 0004280                          
03-31-05 17:08 yafrank        Note Added: 0004282                          
04-06-05 18:41 mmadore        Note Added: 0004350                          
04-07-05 16:04 tiwai          Note Added: 0004357                          
04-07-05 18:32 mmadore        Note Added: 0004362                          
04-07-05 18:33 mmadore        File Added: asound.state                     
04-07-05 18:37 mmadore        File Added: ac97#0-0                         
04-07-05 18:38 mmadore        File Added: ac97#0-0+regs                    
04-12-05 05:47 yafrank        Issue Monitored: yafrank                     
04-12-05 06:02 yafrank        Note Added: 0004445                          
04-12-05 16:29 tiwai          Note Added: 0004447                          
04-12-05 19:46 yafrank        Note Added: 0004459                          
04-12-05 20:00 yafrank        Note Added: 0004460                          
04-12-05 21:11 mmadore        Note Added: 0004463                          
04-12-05 21:12 mmadore        File Added: asound.state.new                    
04-24-05 00:15 mycroft        Issue Monitored: mycroft                     
06-17-05 09:55 yafrank        Note Added: 0005065                          
06-17-05 11:45 yafrank        Note Added: 0005067                          
06-17-05 14:44 tiwai          Note Added: 0005073                          
06-18-05 04:26 yafrank        Note Added: 0005082                          
06-18-05 04:52 yafrank        File Added: alsa-ac97-test                    
06-18-05 05:19 yafrank        Note Added: 0005083                          
06-20-05 10:59 perex          File Added: ens1371-reset.patch                   

06-20-05 10:59 perex          Category                 CORE - pcm => PCI -
ens1371
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
