From: Fabio Estevam <festevam@gmail.com>
Subject: mx6: Audio does not work on linux-next 20140107
Date: Tue, 7 Jan 2014 09:56:26 -0200
Message-ID: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f182.google.com (mail-ve0-f182.google.com
 [209.85.128.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1871D2616CB
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:56:29 +0100 (CET)
Received: by mail-ve0-f182.google.com with SMTP id jy13so24484veb.13
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2014 03:56:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Nicolin Chen <b42378@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Playing audio on a mx6qsabresd board running linux-next 20140107 leads
to the following crash:

$ aplay clarinet.wav
random: nonblocking pool is initialized
Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
underrun!!! (at least -477981.433 ms long)
underrun!!! (at least -477981.435 ms long)
underrun!!! (at least -477981.436 ms long)
underrun!!! (at least -477981.435 ms long)
underrun!!! (at least -477981.436 ms long)
underrun!!! (at least -477981.435 ms long)
underrun!!! (at least -477981.436 ms long)
underrun!!! (at least -477981.436 ms long)
underrun!!! (at least -477981.436 ms long)
underrun!!! (at least -477981.436 ms long)
Unable to handle kernel NULL pointer dereference at virtual address 00000044
pgd = 80004000
[00000044] *pgd=00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.13.0-rc7-next-20140107+ #607
task: 8089fef0 ti: 80894000 task.ti: 80894000
PC is at dmaengine_pcm_dma_complete+0x10/0x50
LR is at sdma_tasklet+0x128/0x130
pc : [<804aee6c>]    lr : [<802e6428>]    psr: a0000113
sp : 80895df8  ip : 80895e08  fp : 80895e04
r10: 808f64c0  r9 : bfaa41b4  r8 : 00000000
r7 : 8089cd24  r6 : 00000001  r5 : 00000003  r4 : bfaa40e8
r3 : 00000000  r2 : 00000020  r1 : 00000000  r0 : bf15c000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 4eedc04a  DAC: 00000017
Process swapper/0 (pid: 0, stack limit = 0x80894240)
Stack: (0x80895df8 to 0x80896000)
5de0:                                                       80895e2c 80895e08
5e00: 802e6428 804aee68 bfaa41b0 00000000 80894000 8089cd24 00000000 808f64c0
5e20: 80895e64 80895e30 8002c4b8 802e630c 80062a6c 80890390 00000040 00000000
5e40: 80896098 80894000 80896080 00000006 00000100 00000006 80895eb4 80895e68
5e60: 8002ca38 8002c434 00000022 00000000 bf807a14 00000001 00200000 ffff915f
5e80: 0000000a 00000000 f4000100 80894000 80890ff0 80894000 00000022 00000000
5ea0: 8063350c 808f4abd 80895ecc 80895eb8 8002cf4c 8002c914 00000184 8089cd24
5ec0: 80895ef4 80895ed0 8000f35c 8002cea8 000000a0 f400010c 8089ce80 80895f18
5ee0: f4000100 80894000 80895f14 80895ef8 80008640 8000f310 8000f734 20000113
5f00: ffffffff 80895f4c 80895f6c 80895f18 800130a4 8000861c 00000001 00000001
5f20: 00000000 8089fef0 00000000 8089c99c 8089c938 808f4abd 80894000 8063350c
5f40: 808f4abd 80895f6c 80895f30 80895f60 80062ab0 8000f734 20000113 ffffffff
5f60: 80895f84 80895f70 8006ad14 8000f718 00000000 8181d140 80895fb4 80895f88
5f80: 80624260 8006acb8 00000001 00000000 806241ac 8089ca38 808f4cc0 8089ca38
5fa0: 808f4cc0 ffffffff 80895ff4 80895fb8 80843b40 806241b8 ffffffff ffffffff
5fc0: 808435d0 00000000 00000000 80883970 10c53c7d 8089c928 8088396c 808a1524
5fe0: 1000406a 00000000 00000000 80895ff8 10008074 80843840 00000000 00000000
Backtrace:
[<804aee5c>] (dmaengine_pcm_dma_complete) from [<802e6428>] (sdma_tasklet+0x128)
[<802e6300>] (sdma_tasklet) from [<8002c4b8>] (tasklet_action+0x90/0x148)
 r10:808f64c0 r8:00000000 r7:8089cd24 r6:80894000 r5:00000000 r4:bfaa41b0
[<8002c428>] (tasklet_action) from [<8002ca38>] (__do_softirq+0x130/0x278)
 r10:00000006 r9:00000100 r8:00000006 r7:80896080 r6:80894000 r5:80896098
 r4:00000000
[<8002c908>] (__do_softirq) from [<8002cf4c>] (irq_exit+0xb0/0x100)
 r10:808f4abd r9:8063350c r8:00000000 r7:00000022 r6:80894000 r5:80890ff0
 r4:80894000
[<8002ce9c>] (irq_exit) from [<8000f35c>] (handle_IRQ+0x58/0xb8)
 r4:8089cd24 r3:00000184
[<8000f304>] (handle_IRQ) from [<80008640>] (gic_handle_irq+0x30/0x64)
 r8:80894000 r7:f4000100 r6:80895f18 r5:8089ce80 r4:f400010c r3:000000a0
[<80008610>] (gic_handle_irq) from [<800130a4>] (__irq_svc+0x44/0x5c)
Exception stack(0x80895f18 to 0x80895f60)
5f00:                                                       00000001 00000001
5f20: 00000000 8089fef0 00000000 8089c99c 8089c938 808f4abd 80894000 8063350c
5f40: 808f4abd 80895f6c 80895f30 80895f60 80062ab0 8000f734 20000113 ffffffff
 r7:80895f4c r6:ffffffff r5:20000113 r4:8000f734
[<8000f70c>] (arch_cpu_idle) from [<8006ad14>] (cpu_startup_entry+0x68/0x150)
[<8006acac>] (cpu_startup_entry) from [<80624260>] (rest_init+0xb4/0xdc)
 r7:8181d140 r3:00000000
[<806241ac>] (rest_init) from [<80843b40>] (start_kernel+0x30c/0x364)
 r6:ffffffff r5:808f4cc0 r4:8089ca38
[<80843834>] (start_kernel) from [<10008074>] (0x10008074)
Code: e1a0c00d e92dd800 e24cb004 e59030c8 (e5931044)
---[ end trace 076f597fb036d850 ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D      3.13.0-rc7-next-20140107+ 7
Backtrace:
[<8001233c>] (dump_backtrace) from [<800124d8>] (show_stack+0x18/0x1c)
 r6:80890ff0 r5:8089cd24 r4:00000000 r3:00000000
[<800124c0>] (show_stack) from [<80629fac>] (dump_stack+0x80/0x9c)
[<80629f2c>] (dump_stack) from [<80015494>] (handle_IPI+0x148/0x174)
 r4:00000001 r3:bf87d100
[<8001534c>] (handle_IPI) from [<8000866c>] (gic_handle_irq+0x5c/0x64)
 r8:bf89c000 r7:f4000100 r6:bf89df70 r5:8089ce80 r4:f400010c r3:bf87d100
[<80008610>] (gic_handle_irq) from [<800130a4>] (__irq_svc+0x44/0x5c)
Exception stack(0xbf89df70 to 0xbf89dfb8)
df60:                                     8000f730 bf89df80 00000000 00000000
df80: 00000000 8089c99c 8089c938 808f4abd bf89c000 8063350c 808f4abd bf89dfc4
dfa0: bf89dfa8 bf89dfb8 80062b9c 8000f734 60000113 ffffffff
 r7:bf89dfa4 r6:ffffffff r5:60000113 r4:8000f734
[<8000f70c>] (arch_cpu_idle) from [<8006ad14>] (cpu_startup_entry+0x68/0x150)
[<8006acac>] (cpu_startup_entry) from [<800150e0>] (secondary_start_kernel+0x12)
 r7:808f4fd0 r3:bf87d100
[<80014fb4>] (secondary_start_kernel) from [<10008704>] (0x10008704)
 r5:0000001f r4:4f88406a
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D      3.13.0-rc7-next-20140107+ 7
Backtrace:
[<8001233c>] (dump_backtrace) from [<800124d8>] (show_stack+0x18/0x1c)
 r6:80890ff0 r5:8089cd24 r4:00000000 r3:00000000
[<800124c0>] (show_stack) from [<80629fac>] (dump_stack+0x80/0x9c)
[<80629f2c>] (dump_stack) from [<80015494>] (handle_IPI+0x148/0x174)
 r4:00000003 r3:bf87e300
[<8001534c>] (handle_IPI) from [<8000866c>] (gic_handle_irq+0x5c/0x64)
 r8:bf8a0000 r7:f4000100 r6:bf8a1f70 r5:8089ce80 r4:f400010c r3:bf87e300
[<80008610>] (gic_handle_irq) from [<800130a4>] (__irq_svc+0x44/0x5c)
Exception stack(0xbf8a1f70 to 0xbf8a1fb8)
1f60:                                     8000f730 bf8a1f80 00000000 00000000
1f80: 00000000 8089c99c 8089c938 808f4abd bf8a0000 8063350c 808f4abd bf8a1fc4
1fa0: bf8a1fa8 bf8a1fb8 80062b9c 8000f734 60000013 ffffffff
 r7:bf8a1fa4 r6:ffffffff r5:60000013 r4:8000f734
[<8000f70c>] (arch_cpu_idle) from [<8006ad14>] (cpu_startup_entry+0x68/0x150)
[<8006acac>] (cpu_startup_entry) from [<800150e0>] (secondary_start_kernel+0x12)
 r7:808f4fd0 r3:bf87e300
[<80014fb4>] (secondary_start_kernel) from [<10008704>] (0x10008704)
 r5:0000001f r4:4f88406a
CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D      3.13.0-rc7-next-20140107+ 7
Backtrace:
[<8001233c>] (dump_backtrace) from [<800124d8>] (show_stack+0x18/0x1c)
 r6:80890ff0 r5:8089cd24 r4:00000000 r3:00000000
[<800124c0>] (show_stack) from [<80629fac>] (dump_stack+0x80/0x9c)
[<80629f2c>] (dump_stack) from [<80015494>] (handle_IPI+0x148/0x174)
 r4:00000002 r3:bf87da00
[<8001534c>] (handle_IPI) from [<8000866c>] (gic_handle_irq+0x5c/0x64)
 r8:bf89e000 r7:f4000100 r6:bf89ff70 r5:8089ce80 r4:f400010c r3:bf87da00
[<80008610>] (gic_handle_irq) from [<800130a4>] (__irq_svc+0x44/0x5c)
Exception stack(0xbf89ff70 to 0xbf89ffb8)
ff60:                                     8000f730 bf89ff80 00000000 00000000
ff80: 00000000 8089c99c 8089c938 808f4abd bf89e000 8063350c 808f4abd bf89ffc4
ffa0: bf89ffa8 bf89ffb8 80062b9c 8000f734 60000013 ffffffff
 r7:bf89ffa4 r6:ffffffff r5:60000013 r4:8000f734
[<8000f70c>] (arch_cpu_idle) from [<8006ad14>] (cpu_startup_entry+0x68/0x150)
[<8006acac>] (cpu_startup_entry) from [<800150e0>] (secondary_start_kernel+0x12)
 r7:808f4fd0 r3:bf87da00
[<80014fb4>] (secondary_start_kernel) from [<10008704>] (0x10008704)
 r5:0000001f r4:4f88406a
drm_kms_helper: panic occurred, switching back to text console

I haven't started debugging it, but if this looks familiar to someone,
please let me know.

Regards,

Fabio Estevam
