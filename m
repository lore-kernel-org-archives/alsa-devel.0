From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: heap out-of-bounds write in
	dummy_systimer_prepare
Date: Wed, 27 Jan 2016 10:55:45 +0100
Message-ID: <CACT4Y+ZGEeEBntHW5WHn2GoeE0G_kRrCmUh6=dWyy-wfzvuJLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id E785B2602F1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 10:56:05 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id n5so19525898wmn.1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 01:56:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I've got the following report while running syzkaller fuzzer:

==================================================================
BUG: KASAN: slab-out-of-bounds in dummy_systimer_prepare+0x268/0x2a0
at addr ffff88006067aa30
Write of size 4 by task syz-executor/5841
=============================================================================
BUG kmalloc-192 (Not tainted): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in dummy_hrtimer_create+0x49/0x1a0 age=77 cpu=2 pid=5841
[<     inline     >] slab_alloc_node mm/slub.c:2562
[<     inline     >] slab_alloc mm/slub.c:2604
[<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
[<     inline     >] kmalloc include/linux/slab.h:463
[<     inline     >] kzalloc include/linux/slab.h:607
[<      none      >] dummy_hrtimer_create+0x49/0x1a0 sound/drivers/dummy.c:458
[<      none      >] dummy_pcm_open+0xef/0x570 sound/drivers/dummy.c:573
[<      none      >] snd_pcm_open_substream+0x188/0x430
sound/core/pcm_native.c:2264
[<     inline     >] snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2342
[<      none      >] snd_pcm_oss_open.part.17+0x5a4/0x1110
sound/core/oss/pcm_oss.c:2424
[<      none      >] snd_pcm_oss_open+0x35/0x50 sound/core/oss/pcm_oss.c:2388
[<      none      >] soundcore_open+0x30f/0x640 sound/sound_core.c:639
[<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
[<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
[<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
[<     inline     >] do_last fs/namei.c:3254
[<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
[<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
[<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
[<     inline     >] SYSC_open fs/open.c:1040
[<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035

INFO: Slab 0xffffea0001819e00 objects=24 used=20 fp=0xffff8800606799f0
flags=0x5fffc0000004080
INFO: Object 0xffff88006067a980 @offset=10624 fp=0x          (null)
CPU: 2 PID: 5841 Comm: syz-executor Tainted: G    B           4.5.0-rc1+ #291
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 00000000ffffffff ffff8800316af4c8 ffffffff829e798d ffff88003e804c00
 ffff88006067a980 ffff880060678000 ffff8800316af4f8 ffffffff8175b394
 ffff88003e804c00 ffffea0001819e00 ffff88006067a980 0000000000008002

Call Trace:
 [<     inline     >] kasan_report mm/kasan/report.c:274
 [<ffffffff81764ebe>] __asan_report_store4_noabort+0x3e/0x40
mm/kasan/report.c:299
 [<ffffffff850dc078>] dummy_systimer_prepare+0x268/0x2a0
sound/drivers/dummy.c:295
 [<ffffffff850dc52b>] dummy_pcm_prepare+0x7b/0xa0 sound/drivers/dummy.c:512
 [<ffffffff8505159a>] snd_pcm_do_prepare+0x5a/0x90 sound/core/pcm_native.c:1512
 [<ffffffff85050886>] snd_pcm_action_single+0x76/0x120
sound/core/pcm_native.c:944
 [<ffffffff85050c85>] snd_pcm_action_nonatomic+0x95/0xa0
sound/core/pcm_native.c:1011
 [<     inline     >] snd_pcm_prepare sound/core/pcm_native.c:1552
 [<ffffffff8505bbd5>] snd_pcm_common_ioctl1+0x1045/0x21a0
sound/core/pcm_native.c:2765
 [<ffffffff8505cfd2>] snd_pcm_playback_ioctl1+0x2a2/0x5e0
sound/core/pcm_native.c:2884
 [<ffffffff8505dad6>] snd_pcm_kernel_ioctl+0x136/0x160
sound/core/pcm_native.c:3004
 [<ffffffff8508bb4b>] snd_pcm_oss_prepare+0x4b/0x200
sound/core/oss/pcm_oss.c:1112
 [<ffffffff850941ee>] snd_pcm_oss_make_ready+0xae/0x120
sound/core/oss/pcm_oss.c:1140
 [<ffffffff85096d5a>] snd_pcm_oss_sync+0xba/0xa30 sound/core/oss/pcm_oss.c:1609
 [<ffffffff8509787d>] snd_pcm_oss_release+0x1ad/0x280
sound/core/oss/pcm_oss.c:2479
 [<ffffffff817c0096>] __fput+0x236/0x780 fs/file_table.c:208
 [<ffffffff817c0665>] ____fput+0x15/0x20 fs/file_table.c:244
 [<ffffffff813b13c0>] task_work_run+0x170/0x210 kernel/task_work.c:115
 [<     inline     >] exit_task_work include/linux/task_work.h:21
 [<ffffffff8135ca55>] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
 [<ffffffff8135efc8>] do_group_exit+0x108/0x330 kernel/exit.c:878
 [<ffffffff81382114>] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
 [<ffffffff811a0db3>] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
 [<ffffffff81006685>] exit_to_usermode_loop+0x1a5/0x210
arch/x86/entry/common.c:247
 [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
 [<ffffffff810084ea>] syscall_return_slowpath+0x2ba/0x340
arch/x86/entry/common.c:344
 [<ffffffff86459c22>] int_ret_from_sys_call+0x25/0x9f
arch/x86/entry/entry_64.S:281

Memory state around the buggy address:
 ffff88006067a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88006067a980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88006067aa00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88006067aa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88006067ab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


The timer is created by dummy_hrtimer_create as hrtimer, but then
accessed by dummy_systimer_prepare as systimer. The root cause seems
to be a data race on dummy->timer_ops which is reinitialized while it
is being used already. The race in turn causes type confusion. Which
in turn causes heap overwrite with known values.

I was able to reproduce this by working with sound devices and doing
"echo -n N > /sys/module/snd_dummy/parameters/hrtimer" concurrently.
But I am sure that syzkaller did not do writes to sysfs when this bug
was triggered, not sure what altered hrtimer variable in that case. Or
do you see any other possibilities for this issue to be triggered?

On commit e2464688b59c6ae9928f385dabf5355e30cff298.
