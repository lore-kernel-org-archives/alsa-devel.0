From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Kernel crash in snd-aloop (2)
Date: Wed, 21 May 2008 16:41:08 +0200
Message-ID: <d5eabee70805210741p256d4b3dmaa15fbd39df7c53f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 995242432E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 16:41:09 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2078830rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 21 May 2008 07:41:08 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hello all,

I did some more experimenting, this time with a stock Debian 2.6.18-6-686
SMP kernel and alsa-driver 10.0.16 source. This is on a 32 bit machine and
the problem happens here as well.

What I've noticed is that prior to the whole machine crashing (about 2 or 3
seconds), I get a number of "ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))?" lines on my console. After that, the kernel
panics completely.

This line is causes by the assertion 'snd_assert(runtime != NULL, return);'
failing in the snd_pcm_period_elapsed function of pcm_lib.c
Any ideas?

The crash dump is a bit more informative so that's why I'm posting it here
(the tainted indication comes from the vmware driver):

----Start 32bit dump---

ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
 [<c014c26c>] __handle_mm_fault+0x3d2/0x740
 [<c01154b6>] do_page_fault+0x18a/0x481
 [<c011532c>] do_page_fault+0x0/0x481
 [<c01037f9>] error_code+0x39/0x40
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
 [<c0102bbe>] sysenter_past_esp+0x3/0x79
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
 [<c0101a5a>] default_idle+0x0/0x59
 [<c0101a8b>] default_idle+0x31/0x59
 [<c0101b52>] cpu_idle+0x9f/0xb9
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
 [<c0102bbe>] sysenter_past_esp+0x3/0x79
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
ALSA
/home/benjamin/alsa-driver-1.0.16/acore/../alsa-kernel/core/pcm_lib.c:1471:
BUG? (runtime != ((void *)0))
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
divide error: 0000 [#1]
SMP
Modules linked in: snd_aloop kfusd ppdev lp button ac battery vmblock vmxnet
vmmemctl ipv6 vmhgfs dm_snapshot dm_mirror dm_mod loop tsdev snd_ens1371
gameport snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq
snd_rawmidi snd_seq_device snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd i2c_piix4 serio_raw shpchp rtc floppy soundcore
i2c_core intel_agp agpgart pci_hotplug parport_pc parport snd_page_alloc
pcspkr psmouse evdev ext3 jbd mbcache sd_mod ide_cd cdrom generic mptspi
mptscsih mptbase scsi_transport_spi scsi_mod pcnet32 mii piix ide_core
thermal processor fan
CPU:    1
EIP:    0060:[<d8ab2331>]    Tainted: P      VLI
EFLAGS: 00210046   (2.6.18-6-686 #1)
EIP is at snd_card_loopback_timer_function+0x41/0x82 [snd_aloop]
eax: 00000000   ebx: c942e654   ecx: 00000000   edx: 00000000
esi: c13a8000   edi: d8ab22f0   ebp: 00000001   esp: cabebdf8
ds: 007b   es: 007b   ss: 0068
Process jackd (pid: 3746, ti=cabea000 task=d7041550 task.ti=cabea000)
Stack: c13a8000 00000100 c13a8000 c0125607 cabebe08 cabebe08 00000011
c030df48
       0000000a c0121838 00200046 00000000 ca447000 d776b394 c01218cf
00000400
       c0103747 00000400 00000000 caaa1814 00000000 ca447000 d776b394
ca445000
Call Trace:
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
 [<d89c2184>] snd_pcm_attach_substream+0x2bf/0x311 [snd_pcm]
 [<d89c3ea7>] snd_pcm_open_substream+0x11/0x91 [snd_pcm]
 [<d89c3fc8>] snd_pcm_open+0xa1/0x1d5 [snd_pcm]
 [<c0117778>] default_wake_function+0x0/0xc
 [<d89d4718>] snd_open+0xdb/0x17e [snd]
 [<c0161879>] chrdev_open+0x126/0x141
 [<c0161753>] chrdev_open+0x0/0x141
 [<c0158b45>] __dentry_open+0xc8/0x1ac
 [<c0158c8d>] nameidata_to_filp+0x19/0x28
 [<c0158cc7>] do_filp_open+0x2b/0x31
 [<d89d75c0>] snd_ctl_ioctl+0x0/0x960 [snd]
 [<c0158d0b>] do_sys_open+0x3e/0xb3
 [<c0158dad>] sys_open+0x16/0x18
 [<c0102c11>] sysenter_past_esp+0x56/0x79
Code: 08 74 08 0f 0b 52 00 65 26 ab d8 8b 50 08 e8 df 30 67 e7 8d 43 04 e8
9e e6 7c e7 8b 43 38 31 d2 8b 4b 3c 01 c1 03 43 40 89 4b 3c <f7> 73 24 89 53
40 8b 53 28 39 d1 72 2a 89 d6 89 c8 31 d2 f7 f6
EIP: [<d8ab2331>] snd_card_loopback_timer_function+0x41/0x82 [snd_aloop]
SS:ESP 0068:cabebdf8
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c010f5a3>] smp_call_function+0x53/0xfe
 [<c011d97e>] printk+0x14/0x18
 [<c010f661>] smp_send_stop+0x13/0x1c
 [<c011cfc6>] panic+0x4c/0xe2
 [<c0104013>] die+0x256/0x28a
 [<c0104681>] do_divide_error+0x0/0x9a
 [<c010470f>] do_divide_error+0x8e/0x9a
 [<d8ab2331>] snd_card_loopback_timer_function+0x41/0x82 [snd_aloop]
 [<c015be05>] __getblk+0x27/0x266
 [<c0146aec>] __do_page_cache_readahead+0x69/0x1e8
 [<d88dbabb>] do_get_write_access+0x435/0x462 [jbd]
 [<d89104cf>] __ext3_get_inode_loc+0x109/0x2b9 [ext3]
 [<c0116412>] __activate_task+0x1c/0x29
 [<c01037f9>] error_code+0x39/0x40
 [<d8ab22f0>] snd_card_loopback_timer_function+0x0/0x82 [snd_aloop]
 [<d8ab2331>] snd_card_loopback_timer_function+0x41/0x82 [snd_aloop]
 [<c0125607>] run_timer_softirq+0xfb/0x151
 [<c0121838>] __do_softirq+0x5a/0xbb
 [<c01218cf>] do_softirq+0x36/0x3a
 [<c0103747>] apic_timer_interrupt+0x1f/0x24
 [<d89c2184>] snd_pcm_attach_substream+0x2bf/0x311 [snd_pcm]
 [<d89c3ea7>] snd_pcm_open_substream+0x11/0x91 [snd_pcm]
 [<d89c3fc8>] snd_pcm_open+0xa1/0x1d5 [snd_pcm]
 [<c0117778>] default_wake_function+0x0/0xc
 [<d89d4718>] snd_open+0xdb/0x17e [snd]
 [<c0161879>] chrdev_open+0x126/0x141
 [<c0161753>] chrdev_open+0x0/0x141
 [<c0158b45>] __dentry_open+0xc8/0x1ac
 [<c0158c8d>] nameidata_to_filp+0x19/0x28
 [<c0158cc7>] do_filp_open+0x2b/0x31
 [<d89d75c0>] snd_ctl_ioctl+0x0/0x960 [snd]
 [<c0158d0b>] do_sys_open+0x3e/0xb3
 [<c0158dad>] sys_open+0x16/0x18
 [<c0102c11>] sysenter_past_esp+0x56/0x79

---Stop 32bit dump---

Kind regards,
Benjamin
