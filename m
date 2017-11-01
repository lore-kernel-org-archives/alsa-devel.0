From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: BUG: unable to handle kernel paging request in
	snd_seq_oss_readq_puts
Date: Wed, 1 Nov 2017 21:39:46 +0300
Message-ID: <CACT4Y+a2eNABZqqcGe1idMX80pS+HrYgM74BiNz8LZjNXDPKXA@mail.gmail.com>
References: <001a1140b6b825822a055cf02f93@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 096E426737F
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 19:40:08 +0100 (CET)
Received: by mail-io0-f180.google.com with SMTP id i38so8206329iod.2
 for <alsa-devel@alsa-project.org>; Wed, 01 Nov 2017 11:40:08 -0700 (PDT)
In-Reply-To: <001a1140b6b825822a055cf02f93@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: syzbot <bot+31681772ec7a18dde8d3f8caf475f361a89b9514@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 1, 2017 at 9:38 PM, syzbot
<bot+31681772ec7a18dde8d3f8caf475f361a89b9514@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> fc2e8b1a47c14b22c33eb087fca0db58e1f4ed0e
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers

This also happened on more recent commits, including upstream
9c323bff13f92832e03657cabdd70d731408d621 (Oct 20):

device gre0 entered promiscuous mode
BUG: unable to handle kernel paging request at ffffc90001688000
IP: snd_seq_oss_readq_puts+0x146/0x210 sound/core/seq/oss/seq_oss_readq.c:112
PGD 1dac75067 P4D 1dac75067 PUD 1dac76067 PMD 1c1dd3067 PTE 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 18947 Comm: syz-executor2 Not tainted 4.14.0-rc5+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
task: ffff8801d92c8140 task.stack: ffff8801c2ef0000
RIP: 0010:snd_seq_oss_readq_puts+0x146/0x210
sound/core/seq/oss/seq_oss_readq.c:112
RSP: 0018:ffff8801c2ef6db0 EFLAGS: 00010246
RAX: ffffed00385dedbf RBX: ffffc90001688000 RCX: ffff8801c2ef6df9
RDX: 000000000000554e RSI: ffffffff83d4c556 RDI: 0000000000000282
RBP: ffff8801c2ef6e60 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000400000a0
R13: ffff8801c2ef6e38 R14: ffffc90001688001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801db300000(0063) knlGS:00000000f76ffb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc90001688000 CR3: 00000001d0650000 CR4: 00000000001406e0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 send_midi_event sound/core/seq/oss/seq_oss_midi.c:616 [inline]
 snd_seq_oss_midi_input+0xd39/0x1040 sound/core/seq/oss/seq_oss_midi.c:535
 snd_seq_oss_event_input+0x15d/0x220 sound/core/seq/oss/seq_oss_event.c:439
 snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
sound/core/seq/seq_clientmgr.c:621
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:676 [inline]
 snd_seq_deliver_event+0x318/0x790 sound/core/seq/seq_clientmgr.c:807
 snd_seq_kernel_client_dispatch+0x11e/0x150 sound/core/seq/seq_clientmgr.c:2313
 dummy_input+0x2c4/0x400 sound/core/seq/seq_dummy.c:104
 snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
sound/core/seq/seq_clientmgr.c:621
 snd_seq_deliver_event+0x12c/0x790 sound/core/seq/seq_clientmgr.c:818
 snd_seq_dispatch_event+0x105/0x5b0 sound/core/seq/seq_clientmgr.c:892
 snd_seq_check_queue.part.3+0x38e/0x510 sound/core/seq/seq_queue.c:285
 snd_seq_check_queue sound/core/seq/seq_queue.c:357 [inline]
 snd_seq_enqueue_event+0x32d/0x3d0 sound/core/seq/seq_queue.c:363
 snd_seq_client_enqueue_event+0x21b/0x420 sound/core/seq/seq_clientmgr.c:951
 kernel_client_enqueue.part.10+0xb5/0xd0 sound/core/seq/seq_clientmgr.c:2252
 kernel_client_enqueue sound/core/seq/seq_clientmgr.c:2242 [inline]
 snd_seq_kernel_client_enqueue_blocking+0xcf/0x110
sound/core/seq/seq_clientmgr.c:2279
 insert_queue sound/core/seq/oss/seq_oss_rw.c:189 [inline]
 snd_seq_oss_write+0x5fe/0xa80 sound/core/seq/oss/seq_oss_rw.c:148
 odev_write+0x64/0x90 sound/core/seq/oss/seq_oss.c:177
 __vfs_write+0xef/0x970 fs/read_write.c:479
 __kernel_write+0xf8/0x350 fs/read_write.c:500
 write_pipe_buf+0x175/0x220 fs/splice.c:797
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x328/0x730 fs/splice.c:626
 splice_from_pipe+0x1e9/0x330 fs/splice.c:661
 default_file_splice_write+0x40/0x90 fs/splice.c:809
 do_splice_from fs/splice.c:851 [inline]
 do_splice fs/splice.c:1147 [inline]
 SYSC_splice fs/splice.c:1402 [inline]
 SyS_splice+0x7b7/0x1610 fs/splice.c:1382
 do_syscall_32_irqs_on arch/x86/entry/common.c:329 [inline]
 do_fast_syscall_32+0x3f2/0xf05 arch/x86/entry/common.c:391
 entry_SYSENTER_compat+0x51/0x60 arch/x86/entry/entry_64_compat.S:124
RIP: 0023:0xf7f03c79
RSP: 002b:00000000f76ff01c EFLAGS: 00000296 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000000014 RCX: 0000000000000000
RDX: 0000000000000013 RSI: 0000000000000000 RDI: 000000005813dd57
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Code: d9 4c 8d 73 01 48 c1 e8 03 83 e1 07 42 0f b6 04 38 38 c8 7f 08
84 c0 0f 85 bf 00 00 00 48 8b 85 58 ff ff ff 48 8b 8d 68 ff ff ff <41>
0f b6 5e ff 0f b6 00 83 e1 07 38 c8 7f 08 84 c0 0f 85 89 00
RIP: snd_seq_oss_readq_puts+0x146/0x210
sound/core/seq/oss/seq_oss_readq.c:112 RSP: ffff8801c2ef6db0
CR2: ffffc90001688000
---[ end trace c7c98a599517e76d ]---


> IP: snd_seq_oss_readq_puts+0x146/0x210
> sound/core/seq/oss/seq_oss_readq.c:112
> PGD 1dac75067 P4D 1dac75067 PUD 1dac76067 PMD 1c1cd3067 PTE 0
> Oops: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 3012 Comm: syzkaller659314 Not tainted 4.14.0-rc1-next-20170918+
> #24
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> task: ffff8801ce930000 task.stack: ffff8801ce650000
> RIP: 0010:snd_seq_oss_readq_puts+0x146/0x210
> sound/core/seq/oss/seq_oss_readq.c:112
> RSP: 0018:ffff8801ce657208 EFLAGS: 00010246
> RAX: ffffed0039ccae4a RBX: ffffc900016f4000 RCX: ffff8801ce657251
> RDX: 0000000000000000 RSI: 1ffff10039d26117 RDI: 0000000000000282
> RBP: ffff8801ce6572b8 R08: ffff8801d807ab50 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 000000003fffffa4
> R13: ffff8801ce657290 R14: ffffc900016f4001 R15: dffffc0000000000
> FS:  00007f9079b19700(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc900016f4000 CR3: 00000001ce47d000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  send_midi_event sound/core/seq/oss/seq_oss_midi.c:616 [inline]
>  snd_seq_oss_midi_input+0xd39/0x1040 sound/core/seq/oss/seq_oss_midi.c:535
>  snd_seq_oss_event_input+0x15d/0x220 sound/core/seq/oss/seq_oss_event.c:439
>  snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
> sound/core/seq/seq_clientmgr.c:621
>  deliver_to_subscribers sound/core/seq/seq_clientmgr.c:676 [inline]
>  snd_seq_deliver_event+0x318/0x790 sound/core/seq/seq_clientmgr.c:807
>  snd_seq_kernel_client_dispatch+0x11e/0x150
> sound/core/seq/seq_clientmgr.c:2309
>  dummy_input+0x2c4/0x400 sound/core/seq/seq_dummy.c:104
>  snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
> sound/core/seq/seq_clientmgr.c:621
>  snd_seq_deliver_event+0x12c/0x790 sound/core/seq/seq_clientmgr.c:818
>  snd_seq_dispatch_event+0x105/0x5b0 sound/core/seq/seq_clientmgr.c:892
>  snd_seq_check_queue.part.3+0x38e/0x510 sound/core/seq/seq_queue.c:285
>  snd_seq_check_queue sound/core/seq/seq_queue.c:357 [inline]
>  snd_seq_enqueue_event+0x32d/0x3d0 sound/core/seq/seq_queue.c:363
>  snd_seq_client_enqueue_event+0x21b/0x420 sound/core/seq/seq_clientmgr.c:951
>  kernel_client_enqueue.part.10+0xb5/0xd0 sound/core/seq/seq_clientmgr.c:2248
>  kernel_client_enqueue sound/core/seq/seq_clientmgr.c:2238 [inline]
>  snd_seq_kernel_client_enqueue_blocking+0xcf/0x110
> sound/core/seq/seq_clientmgr.c:2275
>  insert_queue sound/core/seq/oss/seq_oss_rw.c:189 [inline]
>  snd_seq_oss_write+0x5fe/0xa80 sound/core/seq/oss/seq_oss_rw.c:148
>  odev_write+0x64/0x90 sound/core/seq/oss/seq_oss.c:177
>  __vfs_write+0xef/0x970 fs/read_write.c:479
>  vfs_write+0x18f/0x510 fs/read_write.c:543
>  SYSC_write fs/read_write.c:588 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:580
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x446469
> RSP: 002b:00007f9079b18dc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000446469
> RDX: 0000000000000150 RSI: 0000000020e7f000 RDI: 0000000000000003
> RBP: 0000000000000082 R08: 00007f9079b19700 R09: 00007f9079b19700
> R10: 00007f9079b19700 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe543fcc1f R14: 00007f9079b199c0 R15: 0000000000000000
> Code: d9 4c 8d 73 01 48 c1 e8 03 83 e1 07 42 0f b6 04 38 38 c8 7f 08 84 c0
> 0f 85 bf 00 00 00 48 8b 85 58 ff ff ff 48 8b 8d 68 ff ff ff <41> 0f b6 5e ff
> 0f b6 00 83 e1 07 38 c8 7f 08 84 c0 0f 85 89 00
> RIP: snd_seq_oss_readq_puts+0x146/0x210
> sound/core/seq/oss/seq_oss_readq.c:112 RSP: ffff8801ce657208
> CR2: ffffc900016f4000
> ---[ end trace cc8c763aca15dec8 ]---
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1140b6b825822a055cf02f93%40google.com.
> For more options, visit https://groups.google.com/d/optout.
