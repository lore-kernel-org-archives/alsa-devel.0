From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: BUG: soft lockup (2)
Date: Tue, 9 Jan 2018 23:46:10 -0800
Message-ID: <20180110074610.GD931@zzz.localdomain>
References: <089e082676ec552289055ffc71f9@google.com>
 <001a113ece5c2b600d05620b097a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001a113ece5c2b600d05620b097a@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+f76f3c62dfadce022fd1c1deff15a61e09ac708a@syzkaller.appspotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, aaron.lu@intel.com, adobriyan@gmail.com, akpm@linux-foundation.org, alsa-devel@alsa-project.org, frederic@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, o-takashi@sakamocchi.jp, perex@perex.cz, peterz@infradead.org, syzkaller-bugs@googlegroups.com, tiwai@suse.com, ying.huang@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 09:47:01AM -0800, syzbot wrote:
> syzkaller has found reproducer for the following crash on
> e1915c8195b38393005be9b74bfa6a3a367c83b3
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> syzbot+f76f3c62dfadce022fd1c1deff15a61e09ac708a@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 135s! [syzkaller670324:3527]
> Modules linked in:
> irq event stamp: 2531226
> hardirqs last  enabled at (2531225): [<00000000f1ec093f>]
> snd_pcm_stream_unlock_irq+0x78/0xe0 sound/core/pcm_native.c:166
> hardirqs last disabled at (2531226): [<000000003c6ef1cd>]
> apic_timer_interrupt+0xa4/0xb0 arch/x86/entry/entry_64.S:920
> softirqs last  enabled at (41848): [<0000000081bd5f03>]
> __do_softirq+0x7a0/0xb85 kernel/softirq.c:311
> softirqs last disabled at (41829): [<00000000d02c6d52>] invoke_softirq
> kernel/softirq.c:365 [inline]
> softirqs last disabled at (41829): [<00000000d02c6d52>] irq_exit+0x1cc/0x200
> kernel/softirq.c:405
> CPU: 0 PID: 3527 Comm: syzkaller670324 Not tainted 4.15.0-rc6+ #158
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:memcpy+0x45/0x50 mm/kasan/kasan.c:305
> RSP: 0018:ffff8801bf6676f0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff11
> RAX: ffffc9000137ba06 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: ffff8801bf6677da RDI: ffffc9000137ba08
> RBP: ffff8801bf667708 R08: fffff5200026f741 R09: fffff5200026f741
> R10: 0000000000000001 R11: fffff5200026f740 R12: ffffc9000137ba06
> R13: ffff8801bf6677d8 R14: dffffc0000000000 R15: ffffc9000137ba06
> FS:  0000000000000000(0000) GS:ffff8801db200000(0063) knlGS:00000000f7ec6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000020735ee0 CR3: 00000001bfba8002 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  memcpy include/linux/string.h:344 [inline]
>  cvt_s16_to_native sound/core/oss/mulaw.c:164 [inline]
>  mulaw_decode+0x52f/0x770 sound/core/oss/mulaw.c:195
>  mulaw_transfer+0x222/0x270 sound/core/oss/mulaw.c:273
>  snd_pcm_plug_write_transfer+0x22d/0x420 sound/core/oss/pcm_plugin.c:611
>  snd_pcm_oss_write2+0x260/0x420 sound/core/oss/pcm_oss.c:1311
>  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1372 [inline]
>  snd_pcm_oss_write+0x5fe/0x830 sound/core/oss/pcm_oss.c:2646
>  __vfs_write+0xef/0x970 fs/read_write.c:480
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129

Seems that this is fixed in sound/for-linus by:

#syz fix: ALSA: pcm: Abort properly at pending signal in OSS read/write loops
