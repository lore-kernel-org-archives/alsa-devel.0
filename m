From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Mon, 18 Jun 2007 12:07:53 -0500
Message-ID: <61c0054e0706181007g6d7b9de0te1c27ffefebc2225@mail.gmail.com>
References: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
	<1181934519.26658.94.camel@localhost.localdomain>
	<61c0054e0706151406o2cc8b4c2x502e7fdb38a39a3e@mail.gmail.com>
	<61c0054e0706180851y49fc8c1cs7a27c4f84d10904f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D43B243D1
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 19:07:54 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1839559mue
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2007 10:07:53 -0700 (PDT)
In-Reply-To: <61c0054e0706180851y49fc8c1cs7a27c4f84d10904f@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I now have the linux-2.6.22-rc1 kernel booting correctly without the aSoC
driver activated in .config. However, when I rebuild with the aSoC and then
boot, I get the following crash:

.snip.
Advanced Linux Sound Architecture Driver Version 1.0.14rc4 (Wed May 09
09:51:39 2007 UTC).
ASoC version 0.13.0
Unable to handle kernel NULL pointer dereference at virtual address 00000001
pgd = c0004000
[00000001] *pgd=00000000
Internal error: Oops: 801 [#1]
Modules linked in:
CPU: 0
PC is at grh_ek_w6811_init+0x4c/0x11c
LR is at __arm_ioremap_pfn+0x2cc/0x2ec
pc : [<c0019c44>]    lr : [<c00285f4>]    Not tainted
sp : c02e1f74  ip : 00000000  fp : c02e1f8c
r10: 00000000  r9 : 00000000  r8 : c02e0000
r7 : 00000000  r6 : c001d54c  r5 : 00000000  r4 : 00000001
r3 : 00000000  r2 : 00000004  r1 : fffbf000  r0 : c4830000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 5317F
Table: 20004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc02e0258)
Stack: (0xc02e1f74 to 0xc02e2000)
1f60:                                              c001e404 00000000
c001d54c
1f80: c02e1ff4 c02e1f90 c0008924 c0019c08 00000000 73f7f554 00000000
00000000
1fa0: 00000000 c02e1fb0 c0021ec4 c0032f70 00000000 00000000 c000886c
c0038d30
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
1fe0: 00000000 00000000 00000000 c02e1ff8 c0038d30 c000887c 0987e45b
736275d9
Backtrace:
[<c0019bf8>] (grh_ek_w6811_init+0x0/0x11c) from [<c0008924>]
(kernel_init+0xb8/0x284)
 r6:c001d54c r5:00000000 r4:c001e404
[<c000886c>] (kernel_init+0x0/0x284) from [<c0038d30>] (do_exit+0x0/0x7b4)
Code: e3a01901 e3a02000 eb003a74 e3500000 (e5840000)
Kernel panic - not syncing: Attempted to kill init!
.snip.

I am not the best at deciphering these, but I believe the error is in my
driver init function...and probably something to do with memory. Is anyone
better at analyzing these?

Thanks.

Paul
