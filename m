From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: unable to handle kernel paging request
	snd_seq_prioq_cell_out
Date: Tue, 31 Jan 2017 11:04:46 +0100
Message-ID: <CACT4Y+YdhDV2H5LLzDTJDVF-qiYHUHhtRaW4rbb4gUhTCQB81w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C20E267268
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 11:05:07 +0100 (CET)
Received: by mail-vk0-f50.google.com with SMTP id t8so233703627vke.3
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 02:05:07 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following program triggers wild memory access in snd_seq_prioq_cell_out:
https://gist.githubusercontent.com/dvyukov/e0bfb47caf577217b3b0550866cba00b/raw/111473e99109fc96a1d3e252c3b8f982e8eaa265/gistfile1.txt

BUG: unable to handle kernel paging request at ffffc9000392ddb8
IP: snd_seq_prioq_cell_out+0x11d/0x260 sound/core/seq/seq_prioq.c:231
PGD 6cc6f067
PUD 6cc70067
PMD 5f94c067
PTE 0
Oops: 0000 [#1] SMP KASAN
Modules linked in:
CPU: 2 PID: 375 Comm: syz-executor Not tainted 4.10.0-rc5+ #201
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff880066f92500 task.stack: ffff88005f740000
RIP: 0010:snd_seq_prioq_cell_out+0x11d/0x260 sound/core/seq/seq_prioq.c:231
RSP: 0018:ffff88005f7470b8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 1ffff1000bee8e18 RCX: ffffc90000c22000
RDX: 1ffff92000725bb7 RSI: ffffffff8348787e RDI: ffffc9000392ddb8
RBP: ffff88005f747208 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: 0000000000000004 R12: ffff8800673cbe80
R13: ffff88005f7471e0 R14: ffffc9000392dd90 R15: ffff8800673cbe98
FS:  00007f5262fee700(0000) GS:ffff88006d100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000392ddb8 CR3: 0000000066209000 CR4: 00000000001406e0
Call Trace:
 snd_seq_prioq_delete+0x8b/0xf0 sound/core/seq/seq_prioq.c:90
 queue_delete+0x77/0xb0 sound/core/seq/seq_queue.c:152
 snd_seq_queue_client_leave+0x34/0x130 sound/core/seq/seq_queue.c:595
 seq_free_client1.part.5+0x10a/0x410 sound/core/seq/seq_clientmgr.c:258
 seq_free_client1 sound/core/seq/seq_clientmgr.c:255 [inline]
 seq_free_client+0x6f/0x170 sound/core/seq/seq_clientmgr.c:284
 snd_seq_release+0x51/0xe0 sound/core/seq/seq_clientmgr.c:366
 __fput+0x332/0x7f0 fs/file_table.c:208
 ____fput+0x15/0x20 fs/file_table.c:244
 task_work_run+0x18a/0x260 kernel/task_work.c:116
 get_signal+0x148f/0x1820 kernel/signal.c:2143
 do_signal+0xd2/0x2190 arch/x86/kernel/signal.c:807
 exit_to_usermode_loop+0x200/0x2a0 arch/x86/entry/common.c:156
 prepare_exit_to_usermode arch/x86/entry/common.c:190 [inline]
 syscall_return_slowpath+0x4d3/0x570 arch/x86/entry/common.c:259
 entry_SYSCALL_64_fastpath+0xc0/0xc2
RIP: 0033:0x4457d9
RSP: 002b:00007f5262fedb58 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00000000007080a8 RCX: 00000000004457d9
RDX: 0000000020001000 RSI: 000000004058534c RDI: 0000000000000005
RBP: 0000000000002250 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000006e0310
R13: 0000000000000005 R14: 000000004058534c R15: 0000000020001000
Code: f6 0f 84 90 00 00 00 e8 02 1e 2a fe 49 8d 7e 28 48 b8 00 00 00
00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1f 01 00 00 <49>
8b 46 28 49 8d 7c 24 08 48 89 fa 49 89 04 24 48 c1 ea 03 48
RIP: snd_seq_prioq_cell_out+0x11d/0x260 sound/core/seq/seq_prioq.c:231
RSP: ffff88005f7470b8
CR2: ffffc9000392ddb8
---[ end trace cbaec69c4a9fdbfc ]---

On commit fd694aaa46c7ed811b72eb47d5eb11ce7ab3f7f1 (Jan 26).
