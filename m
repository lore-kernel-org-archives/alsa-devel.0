From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: ALSA trigger soft lockup since "ALSA: seq: Fix
 race at creating a queue"
Date: Sat, 4 Nov 2017 16:32:42 -0400
Message-ID: <20171104203242.GA2740@redhat.com>
References: <20171101130227.97f943b3318827b0ac5238a1@linux-foundation.org>
 <20171104023409.GB10353@redhat.com> <s5hshduzf9x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id ED9D6266A73
 for <alsa-devel@alsa-project.org>; Sat,  4 Nov 2017 21:32:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hshduzf9x.wl-tiwai@suse.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org, Daniel Mentz <danielmentz@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 04, 2017 at 08:14:50AM +0100, Takashi Iwai wrote:
> On Sat, 04 Nov 2017 03:34:09 +0100,
> Jerome Glisse wrote:
> > =

> > On Wed, Nov 01, 2017 at 01:02:27PM -0700, Andrew Morton wrote:
> > > Begin forwarded message:
> > > =

> > > Date: Wed, 01 Nov 2017 12:54:16 -0700
> > > From: syzbot <bot+63583aefef5457348dcfa06b87d4fd1378b26b09@syzkaller.=
appspotmail.com>
> > > To: aaron.lu@intel.com, akpm@linux-foundation.org, aneesh.kumar@linux=
.vnet.ibm.com, jack@suse.cz, kirill.shutemov@linux.intel.com, linux-kernel@=
vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, p=
eterz@infradead.org, rientjes@google.com, sfr@canb.auug.org.au, shli@fb.com=
, syzkaller-bugs@googlegroups.com, willy@linux.intel.com, ying.huang@intel.=
com, zi.yan@cs.rutgers.edu
> > > Subject: BUG: soft lockup
> > > =

> > > =

> > > Hello,
> > > =

> > > syzkaller hit the following crash on  =

> > > 1d53d908b79d7870d89063062584eead4cf83448
> > > git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/mas=
ter
> > > compiler: gcc (GCC) 7.1.1 20170620
> > > .config is attached
> > > Raw console output is attached.
> > > C reproducer is attached
> > > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> > > for information about syzkaller reproducers
> > =

> > Sorry to be the bringer of bad news but after:
> > 4842e98f26dd80be3623c4714a244ba52ea096a8
> > and
> > 7e1d90f60a0d501c8503e636942ca704a454d910
> > =

> > The attached syzkaller repro trigger a softlockup in workqueue. I am un=
familiar
> > with that code so some familiar in that domain is more likely to find a=
 proper
> > solution.
> > =

> > Note with
> > git revert 7e1d90f60a0d501c8503e636942ca704a454d910
> > git revert 4842e98f26dd80be3623c4714a244ba52ea096a8
> > fix the issue
> =

> Could you give the stack trace?

Stack trace doesn't say anything it is different every single time.
It was first reported against mm as stack was showing some mm code
but that was coincidence. Stack will show what ever is running at
the time the workqueue soft lockup kick in. The only constant is the
watchdog stack trace but that does not tell you anything:

RIP: 0033:0x4012c8
RSP: 002b:00007ffc12d93e10 EFLAGS: 00010286
RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: 0000000000439779
RDX: 0000000000000000 RSI: 000000002076e000 RDI: ffffffffffffffff
RBP: 00327265636e6575 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 7165732f7665642f
R13: 646e732f7665642f R14: 0030656c69662f2e R15: 0000000000000000
Code: 60 39 d1 fc e9 8d fd ff ff be 08 00 00 00 4c 89 ff e8 2e 39 d1 fc e9  =

1c fd ff ff 90 90 90 90 90 90 90 90 90 b9 00 02 00 00 31 c0 <f3> 48 ab c3  =

0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 84 00
Kernel panic - not syncing: softlockup: hung tasks
CPU: 3 PID: 2995 Comm: syzkaller355698 Tainted: G             L  =

4.13.0-rc7-next-20170901+ #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:16 [inline]
  dump_stack+0x194/0x257 lib/dump_stack.c:52
  panic+0x1e4/0x417 kernel/panic.c:181
  watchdog_timer_fn+0x401/0x410 kernel/watchdog.c:433
  __run_hrtimer kernel/time/hrtimer.c:1213 [inline]
  __hrtimer_run_queues+0x349/0xe10 kernel/time/hrtimer.c:1277
  hrtimer_interrupt+0x1d4/0x5f0 kernel/time/hrtimer.c:1311
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1021 [inline]
  smp_apic_timer_interrupt+0x156/0x710 arch/x86/kernel/apic/apic.c:1046
  apic_timer_interrupt+0x9d/0xb0 arch/x86/entry/entry_64.S:577


If you want i can collect a bunch but i haven't seen anything usefull in
any of them

Cheers,
J=E9r=F4me
