From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: another WARNING in rawmidi_transmit_ack
Date: Tue, 2 Feb 2016 22:59:49 +0100
Message-ID: <CACT4Y+bbeQKVNueT6iHdvruWj64hp4sYNOYZCvxagZBXtmn20Q@mail.gmail.com>
References: <CACT4Y+acG4iyphdOZx47Nyq_VHGbpJQK-6xNpiqUjaZYqsXOGw@mail.gmail.com>
 <s5hy4b4myqm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy4b4myqm.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 1, 2016 at 12:55 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 01 Feb 2016 12:31:20 +0100,
> Dmitry Vyukov wrote:
>>
>> Hello,
>>
>> The following program triggers a splash of WARNINGs in rawmidi_transmit_ack.
>> Takashi, I am on commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3 + a
>> bunch of your recent fixes:
>> https://gist.githubusercontent.com/dvyukov/40640128a433ad16a56a/raw/ab3a08637ce3654b969b778c5700fe4a80f14456/gistfile1.txt
>
> Ouch, this is another spot with an open race between
> snd_rawmidi_transmit_peek() and snd_rawmidi_transmit_ack().
>
> Could you drop the previous fix and apply the one below instead?
>
> FWIW, I pushed sound.git tree topic/core-fixes branch containing all
> pending fixes.  This should be pullable cleanly onto 4.5-rc1/rc2.
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/core-fixes
>
>
> Thanks!
>
> Takashi


Now this program hangs the machine with:

[ 2101.730005] NMI backtrace for cpu 3
[ 2101.730005] CPU: 3 PID: 32283 Comm: a.out Not tainted 4.5.0-rc2+ #307
[ 2101.730005] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[ 2101.730005] task: ffff880061c1df00 ti: ffff8800632c0000 task.ti:
ffff8800632c0000
[ 2101.730005] RIP: 0010:[<ffffffff82c0ff55>]  [<ffffffff82c0ff55>]
delay_tsc+0x25/0x70
[ 2101.730005] RSP: 0018:ffff8800632c7ab8  EFLAGS: 00000006
[ 2101.730005] RAX: 00000000884b1cf5 RBX: ffff88006540d380 RCX: 000000000000001e
[ 2101.730005] RDX: 0000051300000000 RSI: 00000513884b1cf5 RDI: 0000000000000001
[ 2101.730005] RBP: ffff8800632c7ab8 R08: 0000000000000003 R09: 0000000000000001
[ 2101.730005] R10: ffff880061c1df00 R11: ffff88006540d398 R12: ffff88006540d390
[ 2101.730005] R13: 000000009a9d2d40 R14: ffff88006540d388 R15: 000000009a849c5e
[ 2101.730005] FS:  00007f3f0b1f6700(0000) GS:ffff88006d700000(0000)
knlGS:0000000000000000
[ 2101.730005] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 2101.730005] CR2: 0000000020d8b000 CR3: 0000000061117000 CR4: 00000000000006e0
[ 2101.730005] Stack:
[ 2101.730005]  ffff8800632c7ac8 ffffffff82c0fe9a ffff8800632c7b00
ffffffff81467999
[ 2101.730005]  ffff88006540d380 ffff8800655b9e00 1ffff1000c658fa1
ffff88006540d338
[ 2101.730005]  ffff8800632c7cb8 ffff8800632c7b20 ffffffff86660b2f
ffffffff8528758b
[ 2101.730005] Call Trace:
[ 2101.730005]  [<ffffffff82c0fe9a>] __delay+0xa/0x10
[ 2101.730005]  [<ffffffff81467999>] do_raw_spin_lock+0x149/0x2b0
[ 2101.730005]  [<ffffffff86660b2f>] _raw_spin_lock_irq+0x6f/0x80
[ 2101.730005]  [<ffffffff8528758b>] ? snd_rawmidi_write+0x21b/0xb30
[ 2101.730005]  [<ffffffff8528758b>] snd_rawmidi_write+0x21b/0xb30
[ 2101.730005]  [<ffffffff85287370>] ? snd_rawmidi_release+0xf0/0xf0
[ 2101.730005]  [<ffffffff81794e1f>] ? get_mem_cgroup_from_mm+0x39f/0x4a0
[ 2101.730005]  [<ffffffff8168131e>] ? __lru_cache_add+0xce/0x1d0
[ 2101.730005]  [<ffffffff816f1d02>] ? handle_mm_fault+0x3042/0x49a0
[ 2101.730005]  [<ffffffff81456670>] ? debug_check_no_locks_freed+0x3c0/0x3c0
[ 2101.730005]  [<ffffffff817ba743>] __vfs_write+0x113/0x4b0
[ 2101.730005]  [<ffffffff85287370>] ? snd_rawmidi_release+0xf0/0xf0
[ 2101.730005]  [<ffffffff817ba630>] ? vfs_iter_write+0x360/0x360
[ 2101.730005]  [<ffffffff829e5f95>] ? common_file_perm+0x155/0x3a0
[ 2101.730005]  [<ffffffff829e63f2>] ? apparmor_file_permission+0x22/0x30
[ 2101.730005]  [<ffffffff8291cc4c>] ? security_file_permission+0x8c/0x1f0
[ 2101.730005]  [<ffffffff817bbbd2>] ? rw_verify_area+0x102/0x2c0
[ 2101.730005]  [<ffffffff817bc207>] vfs_write+0x167/0x4a0
[ 2101.730005]  [<ffffffff817bf4f1>] SyS_write+0x111/0x220
[ 2101.730005]  [<ffffffff817bf3e0>] ? SyS_read+0x220/0x220
[ 2101.730005]  [<ffffffff81005017>] ? trace_hardirqs_on_thunk+0x17/0x19
[ 2101.730005]  [<ffffffff86661376>] entry_SYSCALL_64_fastpath+0x16/0x7a
