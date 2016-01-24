From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: use-after-free in snd_timer_notify1
Date: Sun, 24 Jan 2016 11:10:33 +0100
Message-ID: <CACT4Y+Z6RzW5MBr-HUdV-8zwg71WQfKTdPpYGvOeS7v4cyurNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C9BE260631
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2016 11:10:53 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id b14so39658554wmb.1
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2016 02:10:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello,

The following program causes use-after-free in snd_timer_notify1:

==================================================================
BUG: KASAN: use-after-free in snd_timer_notify1+0x411/0x460 at addr
ffff880035a433e0
Read of size 8 by task syz-executor/11116
=============================================================================
BUG kmalloc-256 (Not tainted): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in snd_timer_instance_new+0x52/0x3a0 age=1 cpu=1 pid=11106
[<     inline     >] kzalloc include/linux/slab.h:607
[<      none      >] snd_timer_instance_new+0x52/0x3a0 sound/core/timer.c:105
[<      none      >] snd_timer_open+0x522/0xce0 sound/core/timer.c:288
[<      none      >] snd_seq_timer_open+0x223/0x560
sound/core/seq/seq_timer.c:279
[<      none      >] snd_seq_queue_use+0x147/0x230
sound/core/seq/seq_queue.c:528
[<      none      >] snd_seq_queue_alloc+0x36a/0x4d0
sound/core/seq/seq_queue.c:199
[<      none      >] snd_seq_ioctl_create_queue+0xdb/0x2b0
sound/core/seq/seq_clientmgr.c:1536
[<      none      >] snd_seq_do_ioctl+0x19d/0x1c0
sound/core/seq/seq_clientmgr.c:2209
[<      none      >] snd_seq_ioctl+0x54/0xa0 sound/core/seq/seq_clientmgr.c:2224
[<     inline     >] vfs_ioctl fs/ioctl.c:43
[<      none      >] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
[<     inline     >] SYSC_ioctl fs/ioctl.c:689
[<      none      >] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
[<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185

INFO: Freed in snd_timer_close+0x3a8/0x700 age=19 cpu=3 pid=11114
[<      none      >] kfree+0x2b7/0x2e0 mm/slub.c:3664
[<      none      >] snd_timer_close+0x3a8/0x700 sound/core/timer.c:368
[<      none      >] snd_seq_timer_close+0x97/0x130
sound/core/seq/seq_timer.c:312
[<      none      >] snd_seq_queue_timer_close+0x28/0x50
sound/core/seq/seq_queue.c:475
[<      none      >] snd_seq_ioctl_set_queue_timer+0x159/0x300
sound/core/seq/seq_clientmgr.c:1809
[<      none      >] snd_seq_do_ioctl+0x19d/0x1c0
sound/core/seq/seq_clientmgr.c:2209
[<      none      >] snd_seq_ioctl+0x54/0xa0 sound/core/seq/seq_clientmgr.c:2224
[<     inline     >] vfs_ioctl fs/ioctl.c:43
[<      none      >] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
[<     inline     >] SYSC_ioctl fs/ioctl.c:689
[<      none      >] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
[<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185

INFO: Slab 0xffffea0000d69000 objects=22 used=16 fp=0xffff880035a42d80
flags=0x1fffc0000004080
INFO: Object 0xffff880035a43330 @offset=13104 fp=0xffff880064ccee20
CPU: 0 PID: 11116 Comm: syz-executor Tainted: G    B           4.4.0+ #276
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 00000000ffffffff ffff880064bcf560 ffffffff82999e2d ffff88003e807000
 ffff880035a43330 ffff880035a40000 ffff880064bcf590 ffffffff81757354
 ffff88003e807000 ffffea0000d69000 ffff880035a43330 ffff880064bcf718

Call Trace:
 [<ffffffff817609ee>] __asan_report_load8_noabort+0x3e/0x40
mm/kasan/report.c:295
 [<ffffffff84f40da1>] snd_timer_notify1+0x411/0x460 sound/core/timer.c:416
 [<ffffffff84f41025>] _snd_timer_stop+0x235/0x5c0 sound/core/timer.c:524
 [<ffffffff84f41d3a>] snd_timer_pause+0x1a/0x20 sound/core/timer.c:583
 [<     inline     >] snd_seq_timer_stop sound/core/seq/seq_timer.c:325
 [<ffffffff84fc1658>] snd_seq_timer_start+0x148/0x1a0
sound/core/seq/seq_timer.c:366
 [<     inline     >] snd_seq_queue_process_event sound/core/seq/seq_queue.c:687
 [<ffffffff84fbc344>] snd_seq_control_queue+0x304/0x8b0
sound/core/seq/seq_queue.c:748
 [<ffffffff84fc1da5>] event_input_timer+0x25/0x30
sound/core/seq/seq_system.c:118
 [<ffffffff84fb4c14>]
snd_seq_deliver_single_event.constprop.11+0x3f4/0x740
sound/core/seq/seq_clientmgr.c:634
 [<ffffffff84fb5082>] snd_seq_deliver_event+0x122/0x800
sound/core/seq/seq_clientmgr.c:828
 [<ffffffff84fb65a9>] snd_seq_dispatch_event+0xf9/0x510
sound/core/seq/seq_clientmgr.c:902
 [<ffffffff84fba85b>] snd_seq_check_queue+0x3fb/0x560
sound/core/seq/seq_queue.c:293
 [<ffffffff84fbac0d>] snd_seq_enqueue_event+0x24d/0x400
sound/core/seq/seq_queue.c:357
 [<ffffffff84fb5974>] snd_seq_client_enqueue_event+0x214/0x430
sound/core/seq/seq_clientmgr.c:961
 [<ffffffff84fb5e7f>] snd_seq_write+0x2ef/0x570
sound/core/seq/seq_clientmgr.c:1075
 [<ffffffff817b0323>] __vfs_write+0x113/0x480 fs/read_write.c:528
 [<ffffffff817b1db7>] vfs_write+0x167/0x4a0 fs/read_write.c:577
 [<     inline     >] SYSC_write fs/read_write.c:624
 [<ffffffff817b50a1>] SyS_write+0x111/0x220 fs/read_write.c:616
 [<ffffffff86336c36>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
==================================================================



// autogenerated by syzkaller (http://github.com/google/syzkaller)
#include <pthread.h>
#include <stdint.h>
#include <string.h>
#include <sys/syscall.h>
#include <unistd.h>

long r[254];

int main()
{
  memset(r, -1, sizeof(r));
  r[0] = syscall(SYS_mmap, 0x20000000ul, 0x1c000ul, 0x3ul, 0x32ul,
                 0xfffffffffffffffful, 0x0ul);
  r[2] = open("/dev/snd/seq", 0x1ul, 0, 0, 0);
  *(uint32_t*)0x20006000 = (uint32_t)0xffffffffffffffff;
  *(uint32_t*)0x20006004 = (uint32_t)0x10000;
  *(uint32_t*)0x20006008 = (uint32_t)0x2;
  *(uint8_t*)0x2000600c = (uint8_t)0x7;
  *(uint8_t*)0x2000600d = (uint8_t)0x2;
  *(uint8_t*)0x2000600e = (uint8_t)0xec0;
  *(uint8_t*)0x2000600f = (uint8_t)0x4;
  *(uint8_t*)0x20006010 = (uint8_t)0x7;
  *(uint8_t*)0x20006011 = (uint8_t)0x9;
  *(uint8_t*)0x20006012 = (uint8_t)0x80000000;
  *(uint8_t*)0x20006013 = (uint8_t)0x2;
  *(uint8_t*)0x20006014 = (uint8_t)0x2;
  *(uint8_t*)0x20006015 = (uint8_t)0x3;
  *(uint8_t*)0x20006016 = (uint8_t)0x8;
  *(uint8_t*)0x20006017 = (uint8_t)0x9;
  *(uint8_t*)0x20006018 = (uint8_t)0x4;
  *(uint8_t*)0x20006019 = (uint8_t)0xffffffffffffff5c;
  *(uint8_t*)0x2000601a = (uint8_t)0x5ab;
  *(uint8_t*)0x2000601b = (uint8_t)0x4;
  *(uint8_t*)0x2000601c = (uint8_t)0x0;
  *(uint8_t*)0x2000601d = (uint8_t)0x38;
  *(uint8_t*)0x2000601e = (uint8_t)0x9d;
  *(uint8_t*)0x2000601f = (uint8_t)0x8;
  *(uint8_t*)0x20006020 = (uint8_t)0x3;
  *(uint8_t*)0x20006021 = (uint8_t)0x47221059;
  *(uint8_t*)0x20006022 = (uint8_t)0x400;
  *(uint8_t*)0x20006023 = (uint8_t)0x1000;
  *(uint8_t*)0x20006024 = (uint8_t)0x2;
  *(uint8_t*)0x20006025 = (uint8_t)0x3;
  *(uint8_t*)0x20006026 = (uint8_t)0x3;
  *(uint8_t*)0x20006027 = (uint8_t)0x80000000;
  *(uint8_t*)0x20006028 = (uint8_t)0x5;
  *(uint8_t*)0x20006029 = (uint8_t)0x200;
  *(uint8_t*)0x2000602a = (uint8_t)0x1;
  *(uint8_t*)0x2000602b = (uint8_t)0x30;
  *(uint8_t*)0x2000602c = (uint8_t)0x4;
  *(uint8_t*)0x2000602d = (uint8_t)0x0;
  *(uint8_t*)0x2000602e = (uint8_t)0x3;
  *(uint8_t*)0x2000602f = (uint8_t)0xffffffff8a5c645b;
  *(uint8_t*)0x20006030 = (uint8_t)0x4;
  *(uint8_t*)0x20006031 = (uint8_t)0x1;
  *(uint8_t*)0x20006032 = (uint8_t)0x3ff;
  *(uint8_t*)0x20006033 = (uint8_t)0x200;
  *(uint8_t*)0x20006034 = (uint8_t)0x3;
  *(uint8_t*)0x20006035 = (uint8_t)0xea3e;
  *(uint8_t*)0x20006036 = (uint8_t)0x9;
  *(uint8_t*)0x20006037 = (uint8_t)0x200;
  *(uint8_t*)0x20006038 = (uint8_t)0x0;
  *(uint8_t*)0x20006039 = (uint8_t)0x5;
  *(uint8_t*)0x2000603a = (uint8_t)0xfdc;
  *(uint8_t*)0x2000603b = (uint8_t)0x1000;
  *(uint8_t*)0x2000603c = (uint8_t)0x467;
  *(uint8_t*)0x2000603d = (uint8_t)0xea;
  *(uint8_t*)0x2000603e = (uint8_t)0x40;
  *(uint8_t*)0x2000603f = (uint8_t)0x9e98;
  *(uint8_t*)0x20006040 = (uint8_t)0x7;
  *(uint8_t*)0x20006041 = (uint8_t)0x7;
  *(uint8_t*)0x20006042 = (uint8_t)0x0;
  *(uint8_t*)0x20006043 = (uint8_t)0x20;
  *(uint8_t*)0x20006044 = (uint8_t)0x1;
  *(uint8_t*)0x20006045 = (uint8_t)0x4;
  *(uint8_t*)0x20006046 = (uint8_t)0x2;
  *(uint8_t*)0x20006047 = (uint8_t)0x9;
  *(uint8_t*)0x20006048 = (uint8_t)0x5;
  *(uint8_t*)0x20006049 = (uint8_t)0x6;
  *(uint8_t*)0x2000604a = (uint8_t)0x8f2;
  *(uint8_t*)0x2000604b = (uint8_t)0x0;
  *(uint32_t*)0x2000604c = (uint32_t)0x6;
  *(uint8_t*)0x20006050 = (uint8_t)0x0;
  *(uint8_t*)0x20006051 = (uint8_t)0x0;
  *(uint8_t*)0x20006052 = (uint8_t)0x0;
  *(uint8_t*)0x20006053 = (uint8_t)0x0;
  *(uint8_t*)0x20006054 = (uint8_t)0x0;
  *(uint8_t*)0x20006055 = (uint8_t)0x0;
  *(uint8_t*)0x20006056 = (uint8_t)0x0;
  *(uint8_t*)0x20006057 = (uint8_t)0x0;
  *(uint8_t*)0x20006058 = (uint8_t)0x0;
  *(uint8_t*)0x20006059 = (uint8_t)0x0;
  *(uint8_t*)0x2000605a = (uint8_t)0x0;
  *(uint8_t*)0x2000605b = (uint8_t)0x0;
  *(uint8_t*)0x2000605c = (uint8_t)0x0;
  *(uint8_t*)0x2000605d = (uint8_t)0x0;
  *(uint8_t*)0x2000605e = (uint8_t)0x0;
  *(uint8_t*)0x2000605f = (uint8_t)0x0;
  *(uint8_t*)0x20006060 = (uint8_t)0x0;
  *(uint8_t*)0x20006061 = (uint8_t)0x0;
  *(uint8_t*)0x20006062 = (uint8_t)0x0;
  *(uint8_t*)0x20006063 = (uint8_t)0x0;
  *(uint8_t*)0x20006064 = (uint8_t)0x0;
  *(uint8_t*)0x20006065 = (uint8_t)0x0;
  *(uint8_t*)0x20006066 = (uint8_t)0x0;
  *(uint8_t*)0x20006067 = (uint8_t)0x0;
  *(uint8_t*)0x20006068 = (uint8_t)0x0;
  *(uint8_t*)0x20006069 = (uint8_t)0x0;
  *(uint8_t*)0x2000606a = (uint8_t)0x0;
  *(uint8_t*)0x2000606b = (uint8_t)0x0;
  *(uint8_t*)0x2000606c = (uint8_t)0x0;
  *(uint8_t*)0x2000606d = (uint8_t)0x0;
  *(uint8_t*)0x2000606e = (uint8_t)0x0;
  *(uint8_t*)0x2000606f = (uint8_t)0x0;
  *(uint8_t*)0x20006070 = (uint8_t)0x0;
  *(uint8_t*)0x20006071 = (uint8_t)0x0;
  *(uint8_t*)0x20006072 = (uint8_t)0x0;
  *(uint8_t*)0x20006073 = (uint8_t)0x0;
  *(uint8_t*)0x20006074 = (uint8_t)0x0;
  *(uint8_t*)0x20006075 = (uint8_t)0x0;
  *(uint8_t*)0x20006076 = (uint8_t)0x0;
  *(uint8_t*)0x20006077 = (uint8_t)0x0;
  *(uint8_t*)0x20006078 = (uint8_t)0x0;
  *(uint8_t*)0x20006079 = (uint8_t)0x0;
  *(uint8_t*)0x2000607a = (uint8_t)0x0;
  *(uint8_t*)0x2000607b = (uint8_t)0x0;
  *(uint8_t*)0x2000607c = (uint8_t)0x0;
  *(uint8_t*)0x2000607d = (uint8_t)0x0;
  *(uint8_t*)0x2000607e = (uint8_t)0x0;
  *(uint8_t*)0x2000607f = (uint8_t)0x0;
  *(uint8_t*)0x20006080 = (uint8_t)0x0;
  *(uint8_t*)0x20006081 = (uint8_t)0x0;
  *(uint8_t*)0x20006082 = (uint8_t)0x0;
  *(uint8_t*)0x20006083 = (uint8_t)0x0;
  *(uint8_t*)0x20006084 = (uint8_t)0x0;
  *(uint8_t*)0x20006085 = (uint8_t)0x0;
  *(uint8_t*)0x20006086 = (uint8_t)0x0;
  *(uint8_t*)0x20006087 = (uint8_t)0x0;
  *(uint8_t*)0x20006088 = (uint8_t)0x0;
  *(uint8_t*)0x20006089 = (uint8_t)0x0;
  *(uint8_t*)0x2000608a = (uint8_t)0x0;
  *(uint8_t*)0x2000608b = (uint8_t)0x0;
  r[131] =
      syscall(SYS_ioctl, r[2], 0xc08c5332ul, 0x20006000ul, 0, 0, 0);
  *(uint32_t*)0x20006fd7 = (uint32_t)0x0;
  *(uint32_t*)0x20006fdb = (uint32_t)0x0;
  *(uint32_t*)0x20006fdf = (uint32_t)0x6;
  *(uint32_t*)0x20006fe3 = (uint32_t)0x81;
  *(uint32_t*)0x20006fe7 = (uint32_t)0x7;
  *(uint32_t*)0x20006feb = (uint32_t)0x9;
  *(uint32_t*)0x20006fef = (uint32_t)0x401;
  *(uint8_t*)0x20006ff3 = (uint8_t)0x0;
  *(uint8_t*)0x20006ff4 = (uint8_t)0x0;
  *(uint8_t*)0x20006ff5 = (uint8_t)0x0;
  *(uint8_t*)0x20006ff6 = (uint8_t)0x0;
  *(uint8_t*)0x20006ff7 = (uint8_t)0x0;
  *(uint8_t*)0x20006ff8 = (uint8_t)0x0;
  *(uint8_t*)0x20006ff9 = (uint8_t)0x0;
  *(uint8_t*)0x20006ffa = (uint8_t)0x0;
  *(uint8_t*)0x20006ffb = (uint8_t)0x0;
  *(uint8_t*)0x20006ffc = (uint8_t)0x0;
  *(uint8_t*)0x20006ffd = (uint8_t)0x0;
  *(uint8_t*)0x20006ffe = (uint8_t)0x0;
  *(uint8_t*)0x20006fff = (uint8_t)0x0;
  *(uint8_t*)0x20007000 = (uint8_t)0x0;
  *(uint8_t*)0x20007001 = (uint8_t)0x0;
  *(uint8_t*)0x20007002 = (uint8_t)0x0;
  *(uint8_t*)0x20007003 = (uint8_t)0x0;
  *(uint8_t*)0x20007004 = (uint8_t)0x0;
  *(uint8_t*)0x20007005 = (uint8_t)0x0;
  *(uint8_t*)0x20007006 = (uint8_t)0x0;
  *(uint8_t*)0x20007007 = (uint8_t)0x0;
  *(uint8_t*)0x20007008 = (uint8_t)0x0;
  *(uint8_t*)0x20007009 = (uint8_t)0x0;
  *(uint8_t*)0x2000700a = (uint8_t)0x0;
  *(uint8_t*)0x2000700b = (uint8_t)0x0;
  *(uint8_t*)0x2000700c = (uint8_t)0x0;
  *(uint8_t*)0x2000700d = (uint8_t)0x0;
  *(uint8_t*)0x2000700e = (uint8_t)0x0;
  *(uint8_t*)0x2000700f = (uint8_t)0x0;
  *(uint8_t*)0x20007010 = (uint8_t)0x0;
  *(uint8_t*)0x20007011 = (uint8_t)0x0;
  *(uint8_t*)0x20007012 = (uint8_t)0x0;
  *(uint8_t*)0x20007013 = (uint8_t)0x0;
  *(uint8_t*)0x20007014 = (uint8_t)0x0;
  *(uint8_t*)0x20007015 = (uint8_t)0x0;
  *(uint8_t*)0x20007016 = (uint8_t)0x0;
  *(uint8_t*)0x20007017 = (uint8_t)0x0;
  *(uint8_t*)0x20007018 = (uint8_t)0x0;
  *(uint8_t*)0x20007019 = (uint8_t)0x0;
  *(uint8_t*)0x2000701a = (uint8_t)0x0;
  *(uint8_t*)0x2000701b = (uint8_t)0x0;
  *(uint8_t*)0x2000701c = (uint8_t)0x0;
  *(uint8_t*)0x2000701d = (uint8_t)0x0;
  *(uint8_t*)0x2000701e = (uint8_t)0x0;
  *(uint8_t*)0x2000701f = (uint8_t)0x0;
  *(uint8_t*)0x20007020 = (uint8_t)0x0;
  *(uint8_t*)0x20007021 = (uint8_t)0x0;
  *(uint8_t*)0x20007022 = (uint8_t)0x0;
  *(uint8_t*)0x20007023 = (uint8_t)0x0;
  *(uint8_t*)0x20007024 = (uint8_t)0x0;
  *(uint8_t*)0x20007025 = (uint8_t)0x0;
  *(uint8_t*)0x20007026 = (uint8_t)0x0;
  *(uint8_t*)0x20007027 = (uint8_t)0x0;
  *(uint8_t*)0x20007028 = (uint8_t)0x0;
  *(uint8_t*)0x20007029 = (uint8_t)0x0;
  *(uint8_t*)0x2000702a = (uint8_t)0x0;
  *(uint8_t*)0x2000702b = (uint8_t)0x0;
  *(uint8_t*)0x2000702c = (uint8_t)0x0;
  *(uint8_t*)0x2000702d = (uint8_t)0x0;
  *(uint8_t*)0x2000702e = (uint8_t)0x0;
  *(uint8_t*)0x2000702f = (uint8_t)0x0;
  *(uint8_t*)0x20007030 = (uint8_t)0x0;
  *(uint8_t*)0x20007031 = (uint8_t)0x0;
  *(uint8_t*)0x20007032 = (uint8_t)0x0;
  r[203] =
      syscall(SYS_ioctl, r[2], 0x40605346ul, 0x20006fd7ul, 0, 0, 0);
  *(uint8_t*)0x20005000 = (uint8_t)0x3ff;
  *(uint8_t*)0x20005001 = (uint8_t)0x2e;
  *(uint8_t*)0x20005002 = (uint8_t)0x1;
  *(uint8_t*)0x20005003 = (uint8_t)0x8;
  *(uint32_t*)0x2000500c = (uint32_t)0x4;
  *(uint8_t*)0x20005010 = (uint8_t)0x8001;
  *(uint8_t*)0x20005011 = (uint8_t)0x2;
  *(uint8_t*)0x20005012 = (uint8_t)0xfffffffffffffffa;
  *(uint8_t*)0x20005013 = (uint8_t)0xffff;
  *(uint8_t*)0x2000501c = (uint8_t)0x5;
  *(uint8_t*)0x2000501d = (uint8_t)0x2;
  *(uint8_t*)0x2000501e = (uint8_t)0x5;
  *(uint8_t*)0x2000501f = (uint8_t)0x0;
  *(uint8_t*)0x20005020 = (uint8_t)0x5;
  *(uint8_t*)0x20005021 = (uint8_t)0x100000000;
  *(uint8_t*)0x20005022 = (uint8_t)0x7;
  *(uint8_t*)0x20005023 = (uint8_t)0xfffffffffffff2fb;
  *(uint32_t*)0x2000502c = (uint32_t)0x8;
  *(uint8_t*)0x20005030 = (uint8_t)0x80;
  *(uint8_t*)0x20005031 = (uint8_t)0x485;
  *(uint8_t*)0x20005032 = (uint8_t)0x4;
  *(uint8_t*)0x20005033 = (uint8_t)0x4;
  *(uint8_t*)0x2000503c = (uint8_t)0x9;
  *(uint8_t*)0x2000503d = (uint8_t)0x7;
  *(uint8_t*)0x2000503e = (uint8_t)0x20;
  *(uint8_t*)0x2000503f = (uint8_t)0x0;
  *(uint8_t*)0x20005040 = (uint8_t)0x20;
  *(uint8_t*)0x20005041 = (uint8_t)0x9;
  *(uint8_t*)0x20005042 = (uint8_t)0x2;
  *(uint8_t*)0x20005043 = (uint8_t)0x2;
  *(uint64_t*)0x20005058 = (uint64_t)0x0;
  *(uint64_t*)0x20005060 = (uint64_t)0x0;
  *(uint8_t*)0x20005068 = (uint8_t)0x1c8;
  *(uint8_t*)0x20005069 = (uint8_t)0xfffffffffffffff7;
  *(uint8_t*)0x2000506a = (uint8_t)0x1ff;
  *(uint8_t*)0x2000506b = (uint8_t)0x9f9f;
  *(uint32_t*)0x2000507c = (uint32_t)0x90;
  *(uint32_t*)0x20005080 = (uint32_t)0x40;
  *(uint32_t*)0x20005084 = (uint32_t)0x0;
  *(uint8_t*)0x20005088 = (uint8_t)0x0;
  *(uint8_t*)0x20005089 = (uint8_t)0x4;
  *(uint8_t*)0x2000508a = (uint8_t)0x1;
  *(uint8_t*)0x2000508b = (uint8_t)0xffffffff80000001;
  *(uint32_t*)0x20005094 = (uint32_t)0x9;
  *(uint8_t*)0x20005098 = (uint8_t)0x8;
  *(uint8_t*)0x20005099 = (uint8_t)0x7;
  *(uint8_t*)0x2000509a = (uint8_t)0xfff;
  *(uint8_t*)0x2000509b = (uint8_t)0x8;
  *(uint32_t*)0x200050a8 = (uint32_t)0xbd1e;
  r[253] = syscall(SYS_write, r[2], 0x20005000ul, 0x95cul, 0, 0, 0);
  return 0;
}


I am on commit 30f05309bde49295e02e45c7e615f73aa4e0ccc2 (Jan 20) + the
following pending patch from Takashi:

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index f845ecf..656d9a9 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -90,7 +90,7 @@ static int snd_hrtimer_start(struct snd_timer *t)
        struct snd_hrtimer *stime = t->private_data;

        atomic_set(&stime->running, 0);
-       hrtimer_cancel(&stime->hrt);
+       hrtimer_try_to_cancel(&stime->hrt);
        hrtimer_start(&stime->hrt, ns_to_ktime(t->sticks * resolution),
                      HRTIMER_MODE_REL);
        atomic_set(&stime->running, 1);
@@ -101,6 +101,7 @@ static int snd_hrtimer_stop(struct snd_timer *t)
 {
        struct snd_hrtimer *stime = t->private_data;
        atomic_set(&stime->running, 0);
+       hrtimer_try_to_cancel(&stime->hrt);
        return 0;
 }
