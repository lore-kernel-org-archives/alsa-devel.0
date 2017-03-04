From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: another deadlock in snd_seq_pool_done
Date: Sat, 4 Mar 2017 17:31:21 +0100
Message-ID: <CACT4Y+aqqy8bZA1fFieifNxR2fAfFQQABcBHj801+u5ePV0URw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A762668AC
 for <alsa-devel@alsa-project.org>; Sat,  4 Mar 2017 17:31:43 +0100 (CET)
Received: by mail-ua0-f177.google.com with SMTP id q7so103157347uaf.2
 for <alsa-devel@alsa-project.org>; Sat, 04 Mar 2017 08:31:43 -0800 (PST)
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

The following program creates processes deadlocked in snd_seq_pool_done:

https://gist.githubusercontent.com/dvyukov/97efc9cb6d63b1b2c7b737b82cc8b0d6/raw/3546b133ae0b2d3e1190ae7c1f4e240ce7ce132e/gistfile1.txt

After few seconds I get:

# ps afxu | grep a.out
root      8660  2.0  0.0      0     0 pts/0    Zl   16:27   0:00
[a.out] <defunct>

# kill -9 8660

# cat /proc/8660/status
Name: a.out
State: Z (zombie)
Tgid: 8660
Ngid: 0
Pid: 8660
PPid: 1
TracerPid: 0
Uid: 0 0 0 0
Gid: 0 0 0 0
FDSize: 0
Groups: 0
NStgid: 8660
NSpid: 8660
NSpgid: 8660
NSsid: 2971
Threads: 2
SigQ: 1/3304
SigPnd: 0000000000000000
ShdPnd: 0000000000000100
SigBlk: 0000000000000000
SigIgn: 0000000180000000
SigCgt: 0000000000000440
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
voluntary_ctxt_switches: 12
nonvoluntary_ctxt_switches: 0

# cat /proc/8660/task/*/stack
[<ffffffff835406db>] snd_seq_pool_done+0x31b/0x620
sound/core/seq/seq_memory.c:436
[<ffffffff8353a11e>] snd_seq_ioctl_set_client_pool+0x1ae/0x600
sound/core/seq/seq_clientmgr.c:1836
[<ffffffff835382ba>] snd_seq_ioctl+0x2da/0x4d0
sound/core/seq/seq_clientmgr.c:2130
[<ffffffff81aced2f>] vfs_ioctl fs/ioctl.c:45 [inline]
[<ffffffff81aced2f>] do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:685
[<ffffffff81ad038f>] SYSC_ioctl fs/ioctl.c:700 [inline]
[<ffffffff81ad038f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
[<ffffffff8457dc41>] entry_SYSCALL_64_fastpath+0x1f/0xc2
