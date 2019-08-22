From: syzbot <syzbot+4a75454b9ca2777f35c7@syzkaller.appspotmail.com>
Subject: KASAN: use-after-free Read in snd_seq_ioctl_get_client_pool
Date: Thu, 22 Aug 2019 07:53:05 -0700
Message-ID: <000000000000e2a2ac0590b5d81f@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org, bhelgaas@google.com, kirr@nexedi.com, linux-kernel@vger.kernel.org, linux@roeck-us.net, logang@deltatee.com, perex@perex.cz, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tiwai@suse.com, zsm@chromium.org
List-Id: alsa-devel@alsa-project.org

Hello,

syzbot found the following crash on:

HEAD commit:    d1abaeb3 Linux 5.3-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b5add2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7242b2607d5d53a
dashboard link: https://syzkaller.appspot.com/bug?extid=4a75454b9ca2777f35c7
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a75454b9ca2777f35c7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in snd_seq_unused_cells  
sound/core/seq/seq_memory.h:60 [inline]
BUG: KASAN: use-after-free in snd_seq_ioctl_get_client_pool+0x2e0/0x680  
sound/core/seq/seq_clientmgr.c:1839
Read of size 4 at addr ffff8880a8e27b14 by task syz-executor.5/31741

CPU: 0 PID: 31741 Comm: syz-executor.5 Not tainted 5.3.0-rc5 #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_address_description+0x75/0x5b0 mm/kasan/report.c:351
  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:482
  kasan_report+0x26/0x50 mm/kasan/common.c:612
  check_memory_region_inline mm/kasan/generic.c:182 [inline]
  check_memory_region+0x2cf/0x2e0 mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:92
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  snd_seq_unused_cells sound/core/seq/seq_memory.h:60 [inline]
  snd_seq_ioctl_get_client_pool+0x2e0/0x680  
sound/core/seq/seq_clientmgr.c:1839
  snd_seq_ioctl+0x1d1/0x340 sound/core/seq/seq_clientmgr.c:2158
  do_vfs_ioctl+0x744/0x1730 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007faf5e0c4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 00000000200003c0 RSI: 00000000c058534b RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007faf5e0c56d4
R13: 00000000004cdc18 R14: 00000000004d7ba8 R15: 00000000ffffffff

Allocated by task 31737:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:487
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:501
  kmem_cache_alloc_trace+0x221/0x2f0 mm/slab.c:3550
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  snd_seq_pool_new+0x53/0x1b0 sound/core/seq/seq_memory.c:459
  snd_seq_fifo_new+0x72/0x1c0 sound/core/seq/seq_fifo.c:26
  snd_seq_open+0x1e4/0x470 sound/core/seq/seq_clientmgr.c:350
  snd_open+0x313/0x380 sound/core/sound.c:163
  chrdev_open+0x509/0x590 fs/char_dev.c:414
  do_dentry_open+0x73b/0xf90 fs/open.c:797
  vfs_open+0x73/0x80 fs/open.c:906
  do_last fs/namei.c:3416 [inline]
  path_openat+0x1397/0x4460 fs/namei.c:3533
  do_filp_open+0x192/0x3d0 fs/namei.c:3563
  do_sys_open+0x29f/0x560 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x87/0x90 fs/open.c:1102
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 31737:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:457
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x115/0x200 mm/slab.c:3756
  snd_seq_pool_delete+0x9e/0xd0 sound/core/seq/seq_memory.c:487
  snd_seq_fifo_resize+0x1de/0x250 sound/core/seq/seq_fifo.c:262
  snd_seq_ioctl_set_client_pool+0x3c4/0x740  
sound/core/seq/seq_clientmgr.c:1880
  snd_seq_ioctl+0x1d1/0x340 sound/core/seq/seq_clientmgr.c:2158
  do_vfs_ioctl+0x744/0x1730 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a8e27b00
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 20 bytes inside of
  192-byte region [ffff8880a8e27b00, ffff8880a8e27bc0)
The buggy address belongs to the page:
page:ffffea0002a389c0 refcount:1 mapcount:0 mapping:ffff8880aa400000  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00026d1008 ffffea0002870048 ffff8880aa400000
raw: 0000000000000000 ffff8880a8e27000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a8e27a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a8e27a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8880a8e27b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8880a8e27b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880a8e27c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
