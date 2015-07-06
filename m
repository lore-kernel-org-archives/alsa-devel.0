From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: g_audio kernel oops on pulling calbe
Date: Mon, 6 Jul 2015 15:20:14 +0200
Message-ID: <CA+TH9V=Kz3M4Kco5Biee2KUKHo6BaennNLOW5VBDBYpyYV7khQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id E34D42605C7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:20:54 +0200 (CEST)
Received: by wiga1 with SMTP id a1so228692055wig.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 06:20:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Developers,

I'm having hard times with g_audio module on a Atmel SAMA5D3. I always
obtain a kernel oops in a memcpy inside f_audio_complete function.
Honeslty I cannot understand wht's going wrong, cause that memcpy should work.

I have a simple ssc sound card whih works as expected when used with
aplay or any other audio player software, but when i pull the usb
cable this is what I obtain:

[   23.860000] Unable to handle kernel paging request at virtual
address 0a080604
[   23.860000] pgd = c0004000
[   23.860000] [0a080604] *pgd=00000000
[   23.860000] Internal error: Oops: 805 [#1] ARM
[   23.860000] Modules linked in: usb_f_uac1 g_audio libcomposite
snd_soc_atmel_ssc_dai snd_soc_atmel_pcm_dma
[   23.860000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.8+ #81
[   23.860000] Hardware name: Atmel SAMA5 (Device Tree)
[   23.860000] task: c05327b8 ti: c0528000 task.ti: c0528000
[   23.860000] PC is at memcpy+0x50/0x330
[   23.860000] LR is at 0x0
[   23.860000] pc : [<c01a0430>]    lr : [<00000000>]    psr: 20090193
[   23.860000] sp : c0529e5c  ip : 00000000  fp : cfb33200
[   23.860000] r10: 00000001  r9 : 0000bb80  r8 : 00000000
[   23.860000] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
[   23.860000] r3 : 00000000  r2 : 00000020  r1 : cf9f5220  r0 : 0a080604
[   23.860000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[   23.860000] Control: 10c53c7d  Table: 2fb24059  DAC: 00000015
[   23.860000] Process swapper (pid: 0, stack limit = 0xc0528230)
[   23.860000] Stack: (0xc0529e5c to 0xc052a000)
[   23.860000] 9e40:
             cf9f5100
[   23.860000] 9e60: cfa25868 cf9e7dc0 cfb33080 0a080604 cfb33200
bf0287e0 cfa25858 00000000
[   23.860000] 9e80: cfa20a10 cfb33200 cfa25858 cfa20a10 cfa20a10
000000c0 00000002 c0284f50
[   23.860000] 9ea0: c0529ea0 c0529ea0 00000002 00000090 cfa25858
c0286408 0000001c ffffffff
[   23.860000] 9ec0: 7fffffff c054e040 00000000 02000029 cf88cac0
c05544fe c0529ed8 c0529ed8
[   23.860000] 9ee0: 00000000 cfa23c40 cf802540 00000000 00000000
0000002d cf901dc0 c05544fe
[   23.860000] 9f00: 00000000 c0040b28 c05544fe c0554dc0 cf901dc0
cf802540 00000000 00000000
[   23.860000] 9f20: cf802200 c051fe18 cfffc480 c0040c18 cf901dc0
c0042e38 0000002d 0000002d
[   23.860000] 9f40: 00000000 c004034c c053aca0 c0040570 c000eec4
60090013 ffffffff c0529f9c
[   23.860000] 9f60: c0554600 c0011b00 00000000 c0536918 00000000
c0017880 c0528000 c05300c4
[   23.860000] 9f80: c05544fc c05544fc c0554600 c051fe18 cfffc480
00000000 01000000 c0529fb0
[   23.860000] 9fa0: c000eec0 c000eec4 60090013 ffffffff c0528000
c0039b90 ffffffff c04fac30
[   23.860000] 9fc0: ffffffff ffffffff c04fa678 00000000 00000000
c051fe18 c05547d4 c0530070
[   23.860000] 9fe0: c051fe14 c0533860 20004059 410fc051 00000000
20008070 00000000 00000000
[   23.860000] [<c01a0430>] (memcpy) from [<bf0287e0>]
(f_audio_complete+0x11c/0x170 [usb_f_uac1])
[   23.860000] [<bf0287e0>] (f_audio_complete [usb_f_uac1]) from
[<c0284f50>] (request_complete+0x5c/0x80)
[   23.860000] [<c0284f50>] (request_complete) from [<c0286408>]
(usba_udc_irq+0x12c/0xc50)
[   23.860000] [<c0286408>] (usba_udc_irq) from [<c0040b28>]
(handle_irq_event_percpu+0x78/0x140)
[   23.860000] [<c0040b28>] (handle_irq_event_percpu) from
[<c0040c18>] (handle_irq_event+0x28/0x38)
[   23.860000] [<c0040c18>] (handle_irq_event) from [<c0042e38>]
(handle_fasteoi_irq+0x9c/0x164)
[   23.860000] [<c0042e38>] (handle_fasteoi_irq) from [<c004034c>]
(generic_handle_irq+0x2c/0x3c)
[   23.860000] [<c004034c>] (generic_handle_irq) from [<c0040570>]
(__handle_domain_irq+0x54/0xa8)
[   23.860000] [<c0040570>] (__handle_domain_irq) from [<c0011b00>]
(__irq_svc+0x40/0x54)
[   23.860000] [<c0011b00>] (__irq_svc) from [<c000eec4>]
(arch_cpu_idle+0x38/0x3c)
[   23.860000] [<c000eec4>] (arch_cpu_idle) from [<c0039b90>]
(cpu_startup_entry+0xa8/0xf4)
[   23.860000] [<c0039b90>] (cpu_startup_entry) from [<c04fac30>]
(start_kernel+0x374/0x380)
[   23.860000] Code: f5d1f05c f5d1f07c e8b151f8 e2522020 (e8a051f8)
[   23.860000] ---[ end trace 6affc0dac289a4ab ]---
[   23.860000] Kernel panic - not syncing: Fatal exception in interrupt
[   23.860000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

Anyone has a clue about that?

-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
