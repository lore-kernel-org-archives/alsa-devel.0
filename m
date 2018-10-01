From: syzbot <syzbot+9437020c82413d00222d@syzkaller.appspotmail.com>
Subject: KASAN: use-after-free Read in snd_seq_ioctl_get_subscription
Date: Mon, 01 Oct 2018 00:28:02 -0700
Message-ID: <000000000000d862ae057725be54@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, keescook@chromium.org, linux-kernel@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com, viro@zeniv.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hello,

syzbot found the following crash on:

HEAD commit:    e704966c45e4 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1277814e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
dashboard link: https://syzkaller.appspot.com/bug?extid=9437020c82413d00222d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9437020c82413d00222d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_seq_ioctl_get_subscription+0x241/0x250  
sound/core/seq/seq_clientmgr.c:1913
Read of size 80 at addr ffff880198190300 by task syz-executor1/22402

CPU: 0 PID: 22402 Comm: syz-executor1 Not tainted 4.19.0-rc5+ #162
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load_n_noabort+0xf/0x20 mm/kasan/report.c:443
  snd_seq_ioctl_get_subscription+0x241/0x250  
sound/core/seq/seq_clientmgr.c:1913
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  snd_seq_ioctl_compat+0x16c/0x2d0 sound/core/seq/seq_compat.c:123
  __do_compat_sys_ioctl fs/compat_ioctl.c:1419 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:1365 [inline]
  __ia32_compat_sys_ioctl+0x20e/0x630 fs/compat_ioctl.c:1365
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f2bca9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5f270cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000c0505350
RDX: 0000000020000140 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 22402:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  snd_seq_port_connect+0xe4/0x730 sound/core/seq/seq_ports.c:571
  snd_seq_ioctl_subscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1458
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  snd_seq_ioctl_compat+0x16c/0x2d0 sound/core/seq/seq_compat.c:123
  __do_compat_sys_ioctl fs/compat_ioctl.c:1419 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:1365 [inline]
  __ia32_compat_sys_ioctl+0x20e/0x630 fs/compat_ioctl.c:1365
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 22399:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  clear_subscriber_list+0x1ba/0x390 sound/core/seq/seq_ports.c:254
  port_delete+0x7c/0x1b0 sound/core/seq/seq_ports.c:270
  snd_seq_delete_all_ports+0x5fb/0x940 sound/core/seq/seq_ports.c:333
  seq_free_client1.part.9+0xcb/0x270 sound/core/seq/seq_clientmgr.c:262
  seq_free_client1 sound/core/seq/seq_clientmgr.c:256 [inline]
  seq_free_client+0x82/0x100 sound/core/seq/seq_clientmgr.c:285
  snd_seq_release+0x51/0xe0 sound/core/seq/seq_clientmgr.c:366
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
  do_fast_syscall_32+0xcd5/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

The buggy address belongs to the object at ffff880198190300
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
  128-byte region [ffff880198190300, ffff880198190380)
The buggy address belongs to the page:
page:ffffea0006606400 count:1 mapcount:0 mapping:ffff8801da800640 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000713cc48 ffffea0006e7eb08 ffff8801da800640
raw: 0000000000000000 ffff880198190000 0000000100000015 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880198190200: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
  ffff880198190280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> ffff880198190300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff880198190380: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff880198190400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
