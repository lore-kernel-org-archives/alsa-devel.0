From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in mulaw_decode
Date: Sun, 7 Jan 2018 12:33:05 +0100
Message-ID: <CACT4Y+aMfeSWpw7vsyxsTkubM+DWN7bG7_eO_-7sJgmwiJxb6w@mail.gmail.com>
References: <94eb2c19de60c6629d0561f3b762@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id DAFFF266B67
 for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2018 12:33:27 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id t67so3781014pgc.5
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 03:33:27 -0800 (PST)
In-Reply-To: <94eb2c19de60c6629d0561f3b762@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: syzbot <syzbot+ebf0a29fce8f37153f57@syzkaller.appspotmail.com>
Cc: dzickus@redhat.com, Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, babu.moger@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, the arch/x86 maintainers <x86@kernel.org>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, npiggin@gmail.com, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 4, 2018 at 2:57 PM, syzbot
<syzbot+ebf0a29fce8f37153f57@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzkaller hit the following crash on
> ad036b63ee57df9ab802a4eb20cbbbec66aa4520
> git://git.cmpxchg.org/linux-mmots.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> Unfortunately, I don't have any reproducer for this bug yet.
>
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ebf0a29fce8f37153f57@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: rcu_sched self-detected stall on CPU
>         1-....: (124999 ticks this GP) idle=71e/1/4611686018427387906
> softirq=9229/9229 fqs=31218
>          (t=125000 jiffies g=4571 c=4570 q=876)
> NMI backtrace for cpu 1
> CPU: 1 PID: 4500 Comm: syz-executor6 Not tainted 4.15.0-rc6-mm1+ #50
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x137/0x198 lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>  rcu_dump_cpu_stacks+0x186/0x1d7 kernel/rcu/tree.c:1375
>  print_cpu_stall kernel/rcu/tree.c:1524 [inline]
>  check_cpu_stall kernel/rcu/tree.c:1592 [inline]
>  __rcu_pending kernel/rcu/tree.c:3362 [inline]
>  rcu_pending kernel/rcu/tree.c:3424 [inline]
>  rcu_check_callbacks+0x1a64/0x1de0 kernel/rcu/tree.c:2764
>  update_process_times+0x30/0x60 kernel/time/timer.c:1628
>  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1176
>  __run_hrtimer kernel/time/hrtimer.c:1210 [inline]
>  __hrtimer_run_queues+0x2c8/0xb50 kernel/time/hrtimer.c:1274
>  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1308
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0xc9/0x4c0 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:920
>  </IRQ>
> RIP: 0010:__memcpy+0x0/0x20
> RSP: 0018:ffff8801cd597918 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff11
> RAX: fffff52000255558 RBX: 0000000000000002 RCX: ffffffff83b7d25e
> RDX: 0000000000000002 RSI: ffff8801cd597a00 RDI: ffffc900012aaab8
> RBP: ffff8801cd597938 R08: fffff52000255558 R09: fffff52000255558
> R10: 0000000000000001 R11: fffff52000255557 R12: ffffc900012aaab8
> R13: ffff8801cd597a00 R14: ffff8801d0e45000 R15: dffffc0000000000
>  memcpy include/linux/string.h:344 [inline]
>  cvt_s16_to_native sound/core/oss/mulaw.c:164 [inline]
>  mulaw_decode+0x50e/0x740 sound/core/oss/mulaw.c:195
>  mulaw_transfer+0x222/0x270 sound/core/oss/mulaw.c:273
>  snd_pcm_plug_write_transfer+0x20b/0x390 sound/core/oss/pcm_plugin.c:611
>  snd_pcm_oss_write2+0x22e/0x3c0 sound/core/oss/pcm_oss.c:1311
>  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1372 [inline]
>  snd_pcm_oss_write+0x4c1/0x690 sound/core/oss/pcm_oss.c:2646
>  __vfs_write+0xef/0x740 fs/read_write.c:480
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xd4/0x1a0 fs/read_write.c:581
>  entry_SYSCALL_64_fastpath+0x23/0x9a
> RIP: 0033:0x452ac9
> RSP: 002b:00007febc940bc58 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000071bf58 RCX: 0000000000452ac9
> RDX: 00000000ffffffa2 RSI: 0000000020001000 RDI: 0000000000000013
> RBP: 0000000000000521 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f5bb8
> R13: 00000000ffffffff R14: 00007febc940c6d4 R15: 000000000000000b


+ALSA maintainers

This looks like:

#syz dup: INFO: rcu detected stall in memcpy

right?



> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c19de60c6629d0561f3b762%40google.com.
> For more options, visit https://groups.google.com/d/optout.
