From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cs4232: fix crash during chip PNP detection
Date: Wed, 23 Jul 2008 07:48:49 +0200
Message-ID: <20080723074849.7c280237.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EC421038CE
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 07:44:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The acard->wss pointer is uninitialized in this function
which leads to crash during chip PNP detection.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This bug was found in the 2.6.26-git9 kernel.
This is the second version of the patch previously called:
"cs4236: add missing pnp_request_card_device()"

The crash log (if needed):
BUG: unable to handle kernel NULL pointer dereference at 00000158
IP: [<c02ba3f8>] pnp_activate_dev+0x5/0x37
*pde = 00000000 
Oops: 0000 [#1] 
Modules linked in: snd_cs4232(+) snd_opl3_lib snd_hwdep snd_cs4231_lib
 snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi 
snd_seq_device parport_pc parport

Pid: 668, comm: modprobe Not tainted (2.6.26-git9 #1)
EIP: 0060:[<c02ba3f8>] EFLAGS: 00010246 CPU: 0
EIP is at pnp_activate_dev+0x5/0x37
EAX: 00000000 EBX: 00000000 ECX: c1c46800 EDX: 00000000
ESI: 00000000 EDI: c1c46800 EBP: c02d6635 ESP: c1db3ef0
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process modprobe (pid: 668, ti=c1db2000 task=c064d3e0 task.ti=c1db2000)
Stack: 00000000 c2a710ed 00000000 c1c46800 c2a712e7 c1e35600 c2a71702 c1c46800 
       c1c46800 c2a74120 c02b93ca c1c46800 00000000 c2a7413c c02d650d c2a7413c 
       c1c46800 00000000 c02d65ca c1c46800 c1c468a8 c2a7413c c02d666c c1db3f5c 
Call Trace:
[<c2a710ed>] snd_cs423x_pnp_init_wss+0xd/0x10c [snd_cs4232]
[<c2a712e7>] snd_card_cs4232_pnp+0xb/0x25 [snd_cs4232]
[<c2a71702>] snd_cs4232_pnpbios_detect+0x7b/0xcf [snd_cs4232]
[<c02b93ca>] pnp_device_probe+0x5d/0x7a
[<c02d650d>] really_probe+0x70/0xea
[<c02d65ca>] driver_probe_device+0x34/0x3c
[<c02d666c>] __driver_attach+0x37/0x55
[<c02d5aa2>] bus_for_each_dev+0x36/0x5a
[<c02998d2>] kobject_init_and_add+0x23/0x25
[<c02d669b>] driver_attach+0x11/0x13
[<c02d6635>] __driver_attach+0x0/0x55
[<c02d5f9f>] bus_add_driver+0x8a/0x132
[<c02d69c2>] driver_register+0x68/0x88
[<c2a43027>] alsa_card_cs423x_init+0x27/0x6e [snd_cs4232]
[<c022eb96>] sys_init_module+0x84/0x173
[<c02028c2>] syscall_call+0x7/0xb
=======================
Code: e8 10 b3 f5 ff b8 fb ff ff ff eb 15 50 89 d8 e8 eb 9e 01 00 50 68 21 c3 3d c0 e8 f6 b2 f5 ff 31 c0 83 c4 0c 5b c3 53 31 d2 89 c3 <83> b8 58 01 00 00 00 75 25 e8 a3 fe ff ff ba f0 ff
ff ff 85 c0 
EIP: [<c02ba3f8>] pnp_activate_dev+0x5/0x37 SS:ESP 0068:c1db3ef0
---[ end trace ff15a9f65b38124f ]---

--- linux-2.6.26/sound/isa/cs423x/cs4236.c~	2008-07-23 07:40:16.129637645 +0200
+++ linux-2.6.26/sound/isa/cs423x/cs4236.c	2008-07-23 07:40:32.905641806 +0200
@@ -325,6 +325,7 @@ static int __devinit snd_cs423x_pnp_init
 static int __devinit snd_card_cs4232_pnp(int dev, struct snd_card_cs4236 *acard,
 					 struct pnp_dev *pdev)
 {
+	acard->wss = pdev;
 	if (snd_cs423x_pnp_init_wss(dev, acard->wss) < 0)
 		return -EBUSY;
 	cport[dev] = -1;

----------------------------------------------------------------------
Galeria absurdow.
zobacz >>> http://link.interia.pl/f1e5e
