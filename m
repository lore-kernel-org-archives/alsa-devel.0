From: syzbot <syzbot+9917f000776fb73fa40f@syzkaller.appspotmail.com>
Subject: KASAN: use-after-free Read in delete_and_unsubscribe_port
Date: Sat, 29 Dec 2018 09:54:03 -0800
Message-ID: <000000000000852fcf057e2cdd51@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, colin.king@canonical.com, linux-kernel@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166859b3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=9917f000776fb73fa40f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9917f000776fb73fa40f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:191  
[inline]
BUG: KASAN: use-after-free in list_empty include/linux/list.h:226 [inline]
BUG: KASAN: use-after-free in delete_and_unsubscribe_port+0x5d7/0x6d0  
sound/core/seq/seq_ports.c:548
Read of size 8 at addr ffff8881d1c05590 by task syz-executor1/6930

CPU: 0 PID: 6930 Comm: syz-executor1 Not tainted 4.20.0 #167
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:191 [inline]
  list_empty include/linux/list.h:226 [inline]
  delete_and_unsubscribe_port+0x5d7/0x6d0 sound/core/seq/seq_ports.c:548
  snd_seq_port_disconnect+0x17b/0x280 sound/core/seq/seq_ports.c:628
  snd_seq_ioctl_unsubscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1499
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f36626cac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457759
RDX: 00000000200001c0 RSI: 0000000040505331 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f36626cb6d4
R13: 00000000004ca358 R14: 00000000004d35d0 R15: 00000000ffffffff

Allocated by task 6924:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  snd_seq_port_connect+0xe0/0x760 sound/core/seq/seq_ports.c:571
  snd_seq_ioctl_subscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1458
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6931:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  snd_seq_port_disconnect+0x205/0x280 sound/core/seq/seq_ports.c:632
  snd_seq_ioctl_unsubscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1499
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d1c05540
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 80 bytes inside of
  128-byte region [ffff8881d1c05540, ffff8881d1c055c0)
The buggy address belongs to the page:
page:ffffea0007470140 count:1 mapcount:0 mapping:ffff8881da800640  
index:0xffff8881d1c05b40
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0006fb09c8 ffffea0006f38908 ffff8881da800640
raw: ffff8881d1c05b40 ffff8881d1c05000 000000010000000e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d1c05480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d1c05500: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8881d1c05580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                          ^
  ffff8881d1c05600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d1c05680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
