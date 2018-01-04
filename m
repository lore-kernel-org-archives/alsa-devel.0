From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in memcpy
Date: Thu, 4 Jan 2018 15:01:06 +0100
Message-ID: <CACT4Y+Zqm=kYx5weFtDROs1u8vNqW8oy-Dt05tsq1xZ=KLUFUw@mail.gmail.com>
References: <001a113f711a23fe310561f21d1a@google.com>
 <CACT4Y+Z1oSMf8t4fWZ8_Na+TU=S59z-PTYeK71qO=Awy+nAmqw@mail.gmail.com>
 <s5hmv1tbx2v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id A944226782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 15:01:28 +0100 (CET)
Received: by mail-pl0-f67.google.com with SMTP id n13so1067228plp.11
 for <alsa-devel@alsa-project.org>; Thu, 04 Jan 2018 06:01:28 -0800 (PST)
In-Reply-To: <s5hmv1tbx2v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, syzbot <syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 4, 2018 at 1:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 04 Jan 2018 13:08:45 +0100,
> Dmitry Vyukov wrote:
>>
>> On Thu, Jan 4, 2018 at 1:03 PM, syzbot
>> <syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com> wrote:
>> > Hello,
>> >
>> > syzkaller hit the following crash on
>> > 30a7acd573899fd8b8ac39236eff6468b195ac7d
>> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> > compiler: gcc (GCC) 7.1.1 20170620
>> > .config is attached
>> > Raw console output is attached.
>> > Unfortunately, I don't have any reproducer for this bug yet.
>> >
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>>
>> This looks ALSA-related. +ALSA maintainers.
>
> Not sure exactly what triggers it.  It's the simple memcpy(), and I
> don't know where RCU is involved in that code path.
>
> BTW, other two suspicious RCU usage reports are actually stopped at
> the second WARN_ON() after the RCU message, and the second WARN_ON()
> is independent from RCU; it's the known spurious WARN_ON() and was
> already removed in the sound git tree.


Hi Takashi,

Another similar one just popped up:

https://groups.google.com/forum/#!topic/syzkaller-bugs/X3d6-PIrJM0

This looks like mulaw_decode enters an infinite loop, or at least
doing very large amount of computations without a resched, e.g.
(uint64_t)-1 number of iterations of something along these lines.



>> > INFO: rcu_sched detected stalls on CPUs/tasks:
>> >         (detected by 0, t=125002 jiffies, g=15654, c=15653, q=133)
>> > All QSes seen, last rcu_sched kthread activity 125002
>> > (4294863411-4294738409), jiffies_till_next_fqs=3, root ->qsmask 0x0
>> > syz-executor1   R  running task    24936 11943   3739 0x0000000c
>> > Call Trace:
>> >  <IRQ>
>> >  sched_show_task+0x4a3/0x5e0 kernel/sched/core.c:5198
>> >  print_other_cpu_stall+0x996/0x1090 kernel/rcu/tree.c:1564
>> >  check_cpu_stall.isra.61+0x6e6/0x15b0 kernel/rcu/tree.c:1682
>> >  __rcu_pending kernel/rcu/tree.c:3440 [inline]
>> >  rcu_pending kernel/rcu/tree.c:3502 [inline]
>> >  rcu_check_callbacks+0x256/0xd00 kernel/rcu/tree.c:2842
>> >  update_process_times+0x30/0x60 kernel/time/timer.c:1628
>> >  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>> >  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1194
>> >  __run_hrtimer kernel/time/hrtimer.c:1211 [inline]
>> >  __hrtimer_run_queues+0x358/0xe20 kernel/time/hrtimer.c:1275
>> >  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1309
>> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>> >  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>> >  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:920
>> >  </IRQ>
>> > RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:30 [inline]
>> > RIP: 0010:memory_is_poisoned_n mm/kasan/kasan.c:210 [inline]
>> > RIP: 0010:memory_is_poisoned mm/kasan/kasan.c:241 [inline]
>> > RIP: 0010:check_memory_region_inline mm/kasan/kasan.c:257 [inline]
>> > RIP: 0010:check_memory_region+0x38/0x190 mm/kasan/kasan.c:267
>> > RSP: 0000:ffff8801bd2ff868 EFLAGS: 00000212 ORIG_RAX: ffffffffffffff11
>> > RAX: ffff7fffffffffff RBX: ffffc9000160020b RCX: ffffffff841fceaf
>> > RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffffc9000160020a
>> > RBP: ffff8801bd2ff878 R08: ffffc9000160020a R09: dffffc0000000000
>> > R10: 0000000000000001 R11: ffffed0037a5ff2e R12: ffffc9000160020a
>> > R13: ffff8801bd2ff970 R14: dffffc0000000000 R15: ffffc9000160020a
>> >  memcpy+0x37/0x50 mm/kasan/kasan.c:303
>> >  memcpy include/linux/string.h:344 [inline]
>> >  cvt_s16_to_native sound/core/oss/mulaw.c:164 [inline]
>> >  mulaw_decode+0x52f/0x770 sound/core/oss/mulaw.c:195
>> >  mulaw_transfer+0x222/0x270 sound/core/oss/mulaw.c:273
>> >  snd_pcm_plug_write_transfer+0x22d/0x420 sound/core/oss/pcm_plugin.c:611
>> >  snd_pcm_oss_write2+0x260/0x420 sound/core/oss/pcm_oss.c:1311
>> >  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1372 [inline]
>> >  snd_pcm_oss_write+0x5fe/0x830 sound/core/oss/pcm_oss.c:2646
>> >  __vfs_write+0xef/0x970 fs/read_write.c:480
>> >  vfs_write+0x189/0x510 fs/read_write.c:544
>> >  SYSC_write fs/read_write.c:589 [inline]
>> >  SyS_write+0xef/0x220 fs/read_write.c:581
>> >  entry_SYSCALL_64_fastpath+0x23/0x9a
>> > RIP: 0033:0x452ac9
>> > RSP: 002b:00007fa354a13c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
>> > RAX: ffffffffffffffda RBX: cccccccccccccccd RCX: 0000000000452ac9
>> > RDX: 00000000fffffeb2 RSI: 0000000020083fc6 RDI: 0000000000000014
>> > RBP: 00000000000005b5 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f6998
>> > R13: 00000000ffffffff R14: 00007fa354a146d4 R15: 0000000000000000
>> > rcu_sched kthread starved for 125002 jiffies! g15654 c15653 f0x2
>> > RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
>> > rcu_sched       R  running task    23456     8      2 0x80000000
>> > Call Trace:
>> >  context_switch kernel/sched/core.c:2799 [inline]
>> >  __schedule+0x8eb/0x2060 kernel/sched/core.c:3375
>> >  schedule+0xf5/0x430 kernel/sched/core.c:3434
>> >  schedule_timeout+0x118/0x230 kernel/time/timer.c:1793
>> >  rcu_gp_kthread+0x9e5/0x1930 kernel/rcu/tree.c:2314
>> >  kthread+0x33c/0x400 kernel/kthread.c:238
>> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
>> >
>> >
>> > ---
>> > This bug is generated by a dumb bot. It may contain errors.
>> > See https://goo.gl/tpsmEJ for details.
>> > Direct all questions to syzkaller@googlegroups.com.
>> >
>> > syzbot will keep track of this bug report.
>> > If you forgot to add the Reported-by tag, once the fix for this bug is
>> > merged
>> > into any tree, please reply to this email with:
>> > #syz fix: exact-commit-title
>> > To mark this as a duplicate of another syzbot report, please reply with:
>> > #syz dup: exact-subject-of-another-report
>> > If it's a one-off invalid bug report, please reply with:
>> > #syz invalid
>> > Note: if the crash happens again, it will cause creation of a new bug
>> > report.
>> > Note: all commands must start from beginning of the line in the email body.
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups
>> > "syzkaller-bugs" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an
>> > email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> > To view this discussion on the web visit
>> > https://groups.google.com/d/msgid/syzkaller-bugs/001a113f711a23fe310561f21d1a%40google.com.
>> >
>> > For more options, visit https://groups.google.com/d/optout.
>>
