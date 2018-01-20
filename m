From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: BUG: unable to handle kernel paging request in
	memset_erms (2)
Date: Sat, 20 Jan 2018 13:37:25 +0100
Message-ID: <CACT4Y+bojoerqXL22+x4ZbfXwEw=bpt0-7m0j_4RNNWFA+U-8g@mail.gmail.com>
References: <001a114099b0994a5e0563282c1c@google.com>
 <20180119140445.7b71846a087fccc4c05585db@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id ACDC8266CFE
 for <alsa-devel@alsa-project.org>; Sat, 20 Jan 2018 13:37:48 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id e76so3478796pfk.1
 for <alsa-devel@alsa-project.org>; Sat, 20 Jan 2018 04:37:48 -0800 (PST)
In-Reply-To: <20180119140445.7b71846a087fccc4c05585db@linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, alexander.deucher@amd.com, Takashi Iwai <tiwai@suse.com>, mchehab@kernel.org, syzbot <syzbot+29f08ad5cb6820798dfe@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 19, 2018 at 11:04 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 19 Jan 2018 13:58:01 -0800 syzbot <syzbot+29f08ad5cb6820798dfe@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot hit the following crash on mmots commit
>> 2164355612187e55e8d60a28d2cc6b2337841a7e (Fri Jan 19 01:07:54 2018 +0000)
>> pci: test for unexpectedly disabled bridges
>>
>> So far this crash happened 2 times on mmots.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+29f08ad5cb6820798dfe@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> BUG: unable to handle kernel paging request at ffffc90001691000
>> IP: memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:65
>> PGD 1dad2c067 P4D 1dad2c067 PUD 1dad2d067 PMD 1c6a8f067 PTE 0
>> Oops: 0002 [#1] SMP KASAN
>> Dumping ftrace buffer:
>>     (ftrace buffer empty)
>> Modules linked in:
>> CPU: 1 PID: 5739 Comm: syzkaller592073 Not tainted 4.15.0-rc8-mm1+ #57
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:65
>> RSP: 0018:ffff8801cbbdfb78 EFLAGS: 00010246
>> RAX: fffff520002d3f00 RBX: ffffc90001691000 RCX: 000000000000ee51
>> RDX: 000000000000ee51 RSI: 0000000000000000 RDI: ffffc90001691000
>> RBP: ffff8801cbbdfb98 R08: fffff520002d3fcb R09: ffffc90001691000
>> R10: 0000000000001dcb R11: fffff520002d3fca R12: 000000000000ee51
>> R13: 0000000000000000 R14: 00007ffffffff000 R15: 000000002001be51
>> FS:  00007f88ae7d7700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffc90001691000 CR3: 00000001ccefa005 CR4: 00000000001606e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   memset include/linux/string.h:329 [inline]
>>   _copy_from_user+0xe9/0x110 lib/usercopy.c:16
>>   copy_from_user include/linux/uaccess.h:147 [inline]
>>   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1347 [inline]
>>   snd_pcm_oss_write+0x438/0x880 sound/core/oss/pcm_oss.c:2659
>>   __vfs_write+0xef/0x970 fs/read_write.c:480
>>   vfs_write+0x189/0x510 fs/read_write.c:544
>>   SYSC_write fs/read_write.c:589 [inline]
>>   SyS_write+0xef/0x220 fs/read_write.c:581
>>   entry_SYSCALL_64_fastpath+0x29/0xa0
>> RIP: 0033:0x44a559
>> RSP: 002b:00007f88ae7d6da8 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 00000000006dcc24 RCX: 000000000044a559
>> RDX: 000000000000fe51 RSI: 000000002000c000 RDI: 0000000000000003
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 00000000006dcc20
>> R13: 7073642f7665642f R14: 00800000c0045006 R15: 0000000000000001
>> Code: 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3
>> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89
>> c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01
>> RIP: memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:65 RSP: ffff8801cbbdfb78
>> CR2: ffffc90001691000
>> ---[ end trace 8f421641f3e10f44 ]---
>> Kernel panic - not syncing: Fatal exception
>> Dumping ftrace buffer:
>>     (ftrace buffer empty)
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>
> It's hard to believe that the (four year old)
> workaround-for-a-pci-restoring-bug.patch could cause this.


Hi Andrew,

This commit is not the guilty commit (not the result of bisection).
It's just the commit on which testing was conducted (so that one can
make sense out of the line numbers and also understand if it
includes/excludes some related commits).
If the current wording is unclear, we can improve it if one can
suggest a more clear wording.
