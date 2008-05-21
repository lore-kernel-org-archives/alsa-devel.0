From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Kernel crash in snd-aloop
Date: Wed, 21 May 2008 13:14:26 +0200
Message-ID: <d5eabee70805210414y386ef44fo957782cb2023b018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BCEB244B7
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 13:14:28 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2013497rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 21 May 2008 04:14:26 -0700 (PDT)
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

Thanks to the excellent advice here on the list, I'm one step further with
getting my project running with the snd-aloop driver! Now I'm looking to
scale my solution to more concurrent users. If I check aloop-kernel.c (in
the alsa 10.0.16 release tarball), there are two lines that interest me:

#define MAX_PCM_SUBSTREAMS 8
and
static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};

The standard aloop driver supplies 8 loopback devices; I need to have more,
so I changed both occurences of '8' to 16 and there are no problems.
I'm bundling all these subdevices with a 'type multi' in .asoundrc to one
device that is used as a JACK backend. So far so good!

If I change the 16 to 32 (and modifying .asoundrc to bundle all 32 devices
to the 'multi' device)  however, restarting JACK will sometimes panic my
kernel. I'm running a stock 2.6.22-4 kernel (64 bit) and this is the oops
output (redirected to a serial console luckily, otherwise it would be a lot
of typing):

----Start oops output----

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>
ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>
ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>
ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>
ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff8026669d>] get_page_from_freelist+0x2b/0x534
 [<ffffffff80266d0b>] __alloc_pages+0x5a/0x2bc
 [<ffffffff8026664f>] get_zeroed_page+0x11/0x34
 [<ffffffff8026eba6>] __pte_alloc+0x1a/0xb8
 [<ffffffff8026ed7f>] __handle_mm_fault+0x13b/0xa35
 [<ffffffff80220e9a>] do_page_fault+0x42b/0x7ad
 [<ffffffff80273f66>] do_mmap_pgoff+0x60a/0x776
 [<ffffffff803fe7dd>] error_exit+0x0/0x84

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>
ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff8026e33b>] unmap_vmas+0x3a0/0x741
 [<ffffffff8026e26e>] unmap_vmas+0x2d3/0x741
 [<ffffffff80272394>] exit_mmap+0x80/0x117
 [<ffffffff8022fdfe>] mmput+0x2c/0x9e
 [<ffffffff8028aee7>] flush_old_exec+0x69d/0x9b6
 [<ffffffff8028702b>] vfs_read+0x13f/0x153
 [<ffffffff802b60e2>] load_elf_binary+0x462/0x1979
 [<ffffffff80244a85>] autoremove_wake_function+0x0/0x2e
 [<ffffffff80266d0b>] __alloc_pages+0x5a/0x2bc
 [<ffffffff802b5c80>] load_elf_binary+0x0/0x1979
 [<ffffffff8028a135>] search_binary_handler+0xf1/0x27e
 [<ffffffff8028bbae>] do_execve+0x188/0x231
 [<ffffffff80208b6f>] sys_execve+0x36/0x90
 [<ffffffff8020a207>] stub_execve+0x67/0xb0

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>
ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff8026655a>] free_hot_cold_page+0x135/0x167
 [<ffffffff802665ad>] __pagevec_free+0x21/0x2e
 [<ffffffff80268e15>] release_pages+0x123/0x169
 [<ffffffff8026945d>] __pagevec_release+0x19/0x22
 [<ffffffff80269988>] truncate_inode_pages_range+0xc5/0x28d
 [<ffffffff8027ffd2>] shmem_delete_inode+0x3f/0xe7
 [<ffffffff8027ff93>] shmem_delete_inode+0x0/0xe7
 [<ffffffff802991a7>] generic_delete_inode+0xc5/0x13d
 [<ffffffff80296307>] d_kill+0x38/0x59
 [<ffffffff80296435>] dput+0x10d/0x119
 [<ffffffff802877dd>] __fput+0x145/0x16e
 [<ffffffff802d1141>] shm_destroy+0x41/0x5a
 [<ffffffff802d1e5f>] sys_shmctl+0x49d/0x632
 [<ffffffff8023d659>] sys_kill+0x133/0x15c
 [<ffffffff80286ed7>] vfs_write+0x142/0x157
 [<ffffffff802873c1>] sys_write+0x45/0x6e
 [<ffffffff80209e3e>] system_call+0x7e/0x83

ALSA */home/benjamin/alsa/alsa-driver-1.0.16/acore/*..*/alsa-kernel/core/*pcm_lib.c)


Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf

divide error: 0000 [1] PREEMPT SMP
CPU 2
Modules linked in: snd_aloop snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
snn
Pid: 0, comm: swapper Not tainted 2.6.22-4-amd64-preempt-blktrace #1
RIP: 0010:[<ffffffff882e73dd>]  [<ffffffff882e73dd>]
:snd_aloop:snd_card_loopba0
RSP: 0018:ffff81042faefed0  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff810404cd78a8 RCX: 00000001003d172d
RDX: 0000000000000000 RSI: 0000000000000217 RDI: 0000000000000001
RBP: ffff810404cd78b0 R08: 0000000000000091 R09: 00000001003d172d
R10: 0000000000000000 R11: 0000000000000217 R12: ffff81042fadc000
R13: ffffffff882e7391 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81042fa7d440(0000) knlGS:0000000000000000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000005b2b50 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81042fae8000, task ffff81042fae75a0)

Stack:  ffff810404cd78a8 ffff810404cd78a8 0000000000000102 ffffffff8023a720
 ffff81042faefef0 ffff81042faefef0 0000012c0000000a 0000000000000021
 ffffffff804f1110 000000000000000a 0000000000000002 ffffffff8023723b
Call Trace:
 <IRQ>  [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf


Code: f7 73 64 8b 4b 68 89 93 80 00 00 00 8b 53 7c 39 ca 72 35 89
RIP  [<ffffffff882e73dd>]
:snd_aloop:snd_card_loopback_timer_function+0x4c/0xa0
 RSP <ffff81042faefed0>
Kernel panic - not syncing: Aiee, killing interrupt handler!
Unable to handle kernel paging request at ffff81042af0c800 RIP:
 [<ffff81042af0c800>]
PGD 8063 PUD 19063 PMD 800000042ae001e3 PTE 0
Oops: 0011 [2] PREEMPT SMP
CPU 2
Modules linked in: snd_aloop snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
snn
Pid: 0, comm: swapper Not tainted 2.6.22-4-amd64-preempt-blktrace #1
RIP: 0010:[<ffff81042af0c800>]  [<ffff81042af0c800>]
RSP: 0018:ffff81042faefb60  EFLAGS: 00010003
RAX: ffff81042fae9fd8 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8059e900 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff81042faefb90 R08: 0000000000000000 R09: ffff81042af0c800
R10: ffffffff8046d656 R11: 00000000000000fc R12: ffff81042af0c800
R13: 0000000000000000 R14: 000000000000000b R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81042fa7d440(0000) knlGS:0000000000000000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffff81042af0c800 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81042fae8000, task ffff81042fae75a0)

Stack:  ffffffff802189f1 ffffffff8046d636 ffff81042fae75a0 ffffffff80468144
 ffffffff8020a9c6 ffff81042faefb90 0000000000000000 00000000000000fc
 ffffffff8046d656 ffff81042af0c800 0000000000000000 ffffffff8037f3ca
Call Trace:
 <IRQ>  [<ffffffff802189f1>] smp_call_function_interrupt+0x40/0x5e
 [<ffffffff8020a9c6>] call_function_interrupt+0x66/0x70
 [<ffffffff8037f3ca>] i8042_panic_blink+0x1/0x147
 [<ffffffff80232206>] panic+0x126/0x148
 [<ffffffff80232193>] panic+0xb3/0x148
 [<ffffffff802298b0>] __wake_up_common+0x3e/0x68
 [<ffffffff802352ec>] do_exit+0x8a/0x849
 [<ffffffff8020b964>] kernel_math_error+0x0/0x71
 [<ffffffff882e7391>] :snd_aloop:snd_card_loopback_timer_function+0x0/0xa0
 [<ffffffff8020be38>] do_divide_error+0x7f/0x89
 [<ffffffff882e73dd>] :snd_aloop:snd_card_loopback_timer_function+0x4c/0xa0
 [<ffffffff882e7391>] :snd_aloop:snd_card_loopback_timer_function+0x0/0xa0
 [<ffffffff80232b1f>] printk+0x4e/0x56
 [<ffffffff8024d569>] __module_text_address+0x5e/0x68
 [<ffffffff803fe7dd>] error_exit+0x0/0x84
 [<ffffffff882e7391>] :snd_aloop:snd_card_loopback_timer_function+0x0/0xa0
 [<ffffffff882e73dd>] :snd_aloop:snd_card_loopback_timer_function+0x4c/0xa0
 [<ffffffff8023a720>] run_timer_softirq+0x15b/0x1cf
 [<ffffffff8023723b>] __do_softirq+0x49/0xb8
 [<ffffffff8020affc>] call_softirq+0x1c/0x28
 [<ffffffff8020ca75>] do_softirq+0x2c/0x7d
 [<ffffffff802371e6>] irq_exit+0x36/0x42
 [<ffffffff8021a549>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff80208e05>] mwait_idle+0x0/0x45
 [<ffffffff8020aaa6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80208e47>] mwait_idle+0x42/0x45
 [<ffffffff80208d89>] cpu_idle+0x88/0xbf


Code: 00 00 00 00 00 00 00 00 00 a0 f2 2b 04 81 ff ff 00 20 18 29
RIP  [<ffff81042af0c800>]
 RSP <ffff81042faefb60>
CR2: ffff81042af0c800
Kernel panic - not syncing: Aiee, killing interrupt handler!

----End oops output----

This crash can be reproduced by automatically restarting jackd in a 'while
true' loop and simultaneously killing it every 0.5 seconds from a different
terminal. That seems like a nasty thing to do, but I have had it happen some
times when jackd was running for a few hours and I needed to restart it for
testing something else. Sometimes it takes down the machine, sometimes it
doesn't. This constant starting/killing will reproduce it within a minute or
so.

I'm convinced that jackd should never be able to crash the kernel right? Is
there anything I'm missing here by blindly changing the value from 16 to 32,
anything else I need to consider? Any input is greatly appreciated. Thanks
in advance!

Kind regards,
Benjamin
