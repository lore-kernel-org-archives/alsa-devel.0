From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Atmel_usba_udc: Kernel panic in usba_ep_enable
Date: Mon, 11 May 2015 18:37:34 +0200
Message-ID: <20150511163734.GA8831@panicking>
References: <CA+TH9V=Oe8L7sZTANhf7x6Y5LrxVNzw2DCtZ=XGsQs=c6Rr9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id F353E2650D1
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 18:38:16 +0200 (CEST)
Received: by widdi4 with SMTP id di4so112986939wid.0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 09:38:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+TH9V=Oe8L7sZTANhf7x6Y5LrxVNzw2DCtZ=XGsQs=c6Rr9Hg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, May 11, 2015 at 05:58:27PM +0200, Angelo Compagnucci wrote:
> Hello List,
> 
> I'm having troubles with usb audio on an SAMA5D3 on 3.19.8 with a
> strange kernel panic.
> 
> The function f_audio_set_alt (f_uac1.c) is passing a NULL out_ep and
> so the usba_ep_enable crashes with a null pointer dereference as you
> can see from the debugging output:
> 
> [   24.210000] ep1: ep_enable: desc=  (null)
> 
> Unfortunately, there is nothing strange with my configuration, I'm
> trying to use the soundcard (which plays files flawlessly) as a usb
> soundcard, so the only thing I did was to compile g_audio as a module,
> enable UAC1 and did a modprode.
> 

Please apply:

commit 8d252db174ab27485126f540f368149e3c875e5a
Author: Xuebing Wang <xbing6@gmail.com>
Date:   Wed Dec 10 16:28:15 2014 +0800

    usb: gadget: f_uac1: update Class-Specific AudioControl Interface Header Descriptor
    
    Update this according to USB Audio Class 1.0 spec. This fixes the Windows 7
    detection issue.
    
    Cc: Rafael Brune <mail@rbrune.de>
    Signed-off-by: Xuebing Wang <xbing6@gmail.com>
    Signed-off-by: Fabio Estevam <festevam@gmail.com>
    Signed-off-by: Peter Chen <peter.chen@freescale.com>
    (Fixed some code style issues)
    Tested-by: Peter Chen <peter.chen@freescale.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

commit 625763d101c7aa706b35f052cd978a61f1ef26bc
Author: Xuebing Wang <xbing6@gmail.com>
Date:   Wed Dec 10 16:28:14 2014 +0800

    usb: gadget: f_uac1: configure endpoint before using it
    
    UAC1 forget to do it.
    
    Signed-off-by: Xuebing Wang <xbing6@gmail.com>
    Signed-off-by: Peter Chen <peter.chen@freescale.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>


and check the error of the configure

>From 36faa76befcdcc0d273c8cea32fef82f2fb85771 Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Mon, 11 May 2015 18:30:52 +0200
Subject: [PATCH] f_uac1: check return code from config_ep_by_speed

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/usb/gadget/function/f_uac1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 9719abf..7856b33 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -588,7 +588,10 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 
 	if (intf == 1) {
 		if (alt == 1) {
-			config_ep_by_speed(cdev->gadget, f, out_ep);
+			err = config_ep_by_speed(cdev->gadget, f, out_ep);
+			if (err)
+				return err;
+
 			usb_ep_enable(out_ep);
 			out_ep->driver_data = audio;
 			audio->copy_buf = f_audio_buffer_alloc(audio_buf_size);
-- 
1.9.1

> Can you share any advice?
> 
> Following kernel panic output:
> 
> [   23.500000] g_audio gadget: adding config #1 'Linux USB Audio
> Gadget'/bf0232c8
> [   23.510000] g_audio gadget: adding 'g_audio'/cf9c6400 to config
> 'Linux USB Audio Gadget'/bf0232c8
> [   23.600000] g_audio gadget: Hardware params: access 3, format 2,
> channels 2, rate 48000
> [   23.630000] g_audio gadget: cfg 1/bf0232c8 speeds: high full
> [   23.630000] g_audio gadget:   interface 0 = g_audio/cf9c6400
> [   23.640000] g_audio gadget:   interface 1 = g_audio/cf9c6400
> [   23.640000] g_audio gadget: Linux USB Audio Gadget, version: Feb 2, 2012
> [   23.650000] g_audio gadget: g_audio ready
> [   24.200000] g_audio gadget: high-speed config #1: Linux USB Audio Gadget
> [   24.200000] g_audio gadget: intf 0, alt 0
> [   24.200000] g_audio gadget: intf 1, alt 0
> [   24.210000] g_audio gadget: intf 1, alt 1
> [   24.210000] ep1: ep_enable: desc=  (null)
> [   24.210000] Unable to handle kernel NULL pointer dereference at
> virtual address 00000002
> [   24.210000] pgd = c0004000
> [   24.210000] [00000002] *pgd=00000000
> [   24.210000] Internal error: Oops: 17 [#1] ARM
> [   24.210000] Modules linked in: usb_f_uac1 g_audio libcomposite
> [   24.210000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.8+ #69
> [   24.210000] Hardware name: Atmel SAMA5 (Device Tree)
> [   24.210000] task: c052c7b8 ti: c0522000 task.ti: c0522000
> [   24.210000] PC is at usba_ep_enable+0x28/0x200
> [   24.210000] LR is at usba_ep_enable+0x24/0x200
> [   24.210000] pc : [<c02815bc>]    lr : [<c02815b8>]    psr: 200f0193
> [   24.210000] sp : c0523e18  ip : 00000007  fp : 0000bb80
> [   24.210000] r10: 00000100  r9 : cfb17c00  r8 : 00000001
> [   24.210000] r7 : 000000c8  r6 : cf99aa10  r5 : 00000000  r4 : cf99d868
> [   24.210000] r3 : 00000006  r2 : 00000007  r1 : 00000000  r0 : 00000001
> [   24.210000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> [   24.210000] Control: 10c53c7d  Table: 2fb28059  DAC: 00000015
> [   24.210000] Process swapper (pid: 0, stack limit = 0xc0522230)
> [   24.210000] Stack: (0xc0523e18 to 0xc0524000)
> [   24.210000] 3e00:
>     00000001 cf99d868
> [   24.210000] 3e20: cf9c6400 bf028694 00000001 c0530008 cfa13ac0
> cfb17c00 cfb17a00 00000001
> [   24.210000] 3e40: cf9c6400 00000001 00000001 cf99aa18 00000000
> bf015104 c0523e74 c0034d9c
> [   24.210000] 3e60: cf9471c0 600f0193 cfb05f6c c0530704 c00398b8
> c00398c4 c05306f8 c0039400
> [   24.210000] 3e80: 00000000 200f0193 00000007 00000006 00000000
> cf99d810 0000000b cf99d848
> [   24.210000] 3ea0: cf99aa10 00000000 00000000 00000000 00000800
> c0282f0c 0000001c ffffffff
> [   24.210000] 3ec0: 7fffffff c0547d80 00000000 00000125 00000001
> c054e23e 00010b01 00000001
> [   24.210000] 3ee0: 00000000 cf998240 cf802540 00000000 00000000
> 0000002d cf901dc0 c054e23e
> [   24.210000] 3f00: 00000000 c0040af0 cf802200 c054eb00 cf901dc0
> cf802540 00000000 00000000
> [   24.210000] 3f20: cf802200 c051ac50 cfffc480 c0040be0 cf901dc0
> c0042e00 0000002d 0000002d
> [   24.210000] 3f40: 00000000 c0040314 c0534ca0 c0040538 c000eec4
> 600f0013 ffffffff c0523f9c
> [   24.210000] 3f60: c054e340 c0011b00 00000000 c0530918 00000000
> c0017880 c0522000 c052a0c4
> [   24.210000] 3f80: c054e23c c054e23c c054e340 c051ac50 cfffc480
> 00000000 01000000 c0523fb0
> [   24.210000] 3fa0: c000eec0 c000eec4 600f0013 ffffffff c0522000
> c0039b58 ffffffff c04f5c30
> [   24.210000] 3fc0: ffffffff ffffffff c04f5678 00000000 00000000
> c051ac50 c054e514 c052a070
> [   24.210000] 3fe0: c051ac4c c052d860 20004059 410fc051 00000000
> 20008070 00000000 00000000
> [   24.210000] [<c02815bc>] (usba_ep_enable) from [<bf028694>]
> (f_audio_set_alt+0xc4/0x19c [usb_f_uac1])
> [   24.210000] [<bf028694>] (f_audio_set_alt [usb_f_uac1]) from
> [<bf015104>] (composite_setup+0x4e0/0x1640 [libcomposite])
> [   24.210000] [<bf015104>] (composite_setup [libcomposite]) from
> [<c0282f0c>] (usba_udc_irq+0x75c/0xc74)
> [   24.210000] [<c0282f0c>] (usba_udc_irq) from [<c0040af0>]
> (handle_irq_event_percpu+0x78/0x140)
> [   24.210000] [<c0040af0>] (handle_irq_event_percpu) from
> [<c0040be0>] (handle_irq_event+0x28/0x38)
> [   24.210000] [<c0040be0>] (handle_irq_event) from [<c0042e00>]
> (handle_fasteoi_irq+0x9c/0x164)
> [   24.210000] [<c0042e00>] (handle_fasteoi_irq) from [<c0040314>]
> (generic_handle_irq+0x2c/0x3c)
> [   24.210000] [<c0040314>] (generic_handle_irq) from [<c0040538>]
> (__handle_domain_irq+0x54/0xa8)
> [   24.210000] [<c0040538>] (__handle_domain_irq) from [<c0011b00>]
> (__irq_svc+0x40/0x54)
> [   24.210000] [<c0011b00>] (__irq_svc) from [<c000eec4>]
> (arch_cpu_idle+0x38/0x3c)
> [   24.210000] [<c000eec4>] (arch_cpu_idle) from [<c0039b58>]
> (cpu_startup_entry+0xa8/0xf4)
> [   24.210000] [<c0039b58>] (cpu_startup_entry) from [<c04f5c30>]
> (start_kernel+0x374/0x380)
> [   24.210000] Code: e5941004 e5946024 eb04d705 e5d40033 (e5d51002)
> [   24.210000] ---[ end trace d5ac053970e7d2d1 ]---
> [   24.210000] Kernel panic - not syncing: Fatal exception in interrupt
> [   24.210000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> 
> 
> -- 
> Profile: http://it.linkedin.com/in/compagnucciangelo
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
