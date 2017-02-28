From: Dmitry Vyukov <dvyukov@google.com>
Subject: sounds: deadlocked processed in snd_seq_pool_done
Date: Tue, 28 Feb 2017 17:26:27 +0100
Message-ID: <CACT4Y+bdFT5CQOcs4OZytERxAoa1wsa+rPE5RZpM7XwuimPisQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 31E28266718
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 17:26:50 +0100 (CET)
Received: by mail-ua0-f170.google.com with SMTP id x24so19210937uab.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 08:26:50 -0800 (PST)
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

The following program creates deadlocked processed in snd_seq_pool_done:

https://gist.githubusercontent.com/dvyukov/1c9b1e4641f46c16a42cdb4458bbe8fd/raw/a09912f3cff4d86f412cedf5f5b4a5c98a9f0040/gistfile1.txt

# cat /proc/2964/status
Name: a.out
State: D (disk sleep)
Tgid: 2964
Ngid: 0
Pid: 2964
PPid: 2956
TracerPid: 0
Uid: 0 0 0 0
Gid: 0 0 0 0
FDSize: 0
Groups: 0
NStgid: 2964
NSpid: 2964
NSpgid: 2964
NSsid: 2956
Threads: 1
SigQ: 1/3304
SigPnd: 0000000000000000
ShdPnd: 0000000000000100
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000180000000
CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000
NoNewPrivs: 0
Seccomp: 0
Cpus_allowed: f
Cpus_allowed_list: 0-3
Mems_allowed: 00000000,00000001
Mems_allowed_list: 0
voluntary_ctxt_switches: 103997
nonvoluntary_ctxt_switches: 0

# cat /proc/2964/task/*/stack
[<ffffffff8356c96b>] snd_seq_pool_done+0x31b/0x620
sound/core/seq/seq_memory.c:435
[<ffffffff83571961>] snd_seq_fifo_delete+0x161/0x1f0
sound/core/seq/seq_fifo.c:83
[<ffffffff83562b4f>] snd_seq_release+0x7f/0xe0
sound/core/seq/seq_clientmgr.c:368
[<ffffffff81a8aae2>] __fput+0x332/0x7f0 fs/file_table.c:208
[<ffffffff81a8b025>] ____fput+0x15/0x20 fs/file_table.c:244
[<ffffffff814c782a>] task_work_run+0x18a/0x260 kernel/task_work.c:116
[<ffffffff81451a86>] exit_task_work include/linux/task_work.h:21 [inline]
[<ffffffff81451a86>] do_exit+0x1956/0x2900 kernel/exit.c:873
[<ffffffff81457579>] do_group_exit+0x149/0x420 kernel/exit.c:977
[<ffffffff8145786d>] SYSC_exit_group kernel/exit.c:988 [inline]
[<ffffffff8145786d>] SyS_exit_group+0x1d/0x20 kernel/exit.c:986
[<ffffffff8457c781>] entry_SYSCALL_64_fastpath+0x1f/0xc2
[<ffffffffffffffff>] 0xffffffffffffffff
