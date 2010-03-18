From: Daniel Mack <daniel@caiaq.de>
Subject: Memory corruption in ASoC
Date: Thu, 18 Mar 2010 17:17:55 +0100
Message-ID: <20100318161755.GJ30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 16B5610386F
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 17:18:02 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I've been hunting a serious memory corruption in the ASoC core for some
time now and finally managed to figure out where the actual problem
lies.

We're currently using a 2.6.32.10, on a PXA303 based series of devices
(see sound/soc/pxa/raumfeld.c).

So here's the demo program, reduced to the max:

  http://caiaq.de/download/tmp/alsa.c

The thread launched to call getifaddrs() every 10ms is actually just
there because

  a) this was the way the bug was originally triggered in our
     application and
  b) this seems to be a good way to put the kernel's memory management
     under fire, so you don't have to wait long for a crash.

Important to mention is that the bug is only triggered when
snd_pcm_set_params() is called for both streams, and only if more than
one device is opened.

This sources smash my kernel more or less instantly with a backtrace
similar to the one at the end of this mail. You might also end up
getting hung tasks, and the kernel detector which complains about them
after awhile also points out code somewhere in the netlink area (which
is of course innocent, we clearly deal with a memory corruption here).

So - look at these simplified sniplets:

	// called for stream #0
	pxa_ssp_hw_params(...) { // sound/soc/pxa/pxa-ssp.c
	  ...
	  cpu_dai->dma_data = ssp_get_dma_params(...)
	  ...
	}

	// called for stream #1
	pxa_ssp_startup(...) {  // sound/soc/pxa/pxa-ssp.c
	  ...
	  if (cpu_dai->dma_data) {
	     kfree(cpu_dai->dma_data);
	     ...
	  }
	}

	// called for stream #0
	__pxa2xx_pcm_hw_free(...) { // sound/arm/pxa2xx-pcm-lib.c
	  ...
	  if (rtd && rtd->params && rtd->params->drcmr)
	    *rtd->params->drcmr = 0; // <-- BOOM
	  ...
	}

So the first stream (PLAYBACK) already exported its dma_data which is
now freed by the code initializing the second stream (CAPTURE).
This corrupts all existing users of course, and in this particular case,
the cleanup in __pxa2xx_pcm_hw_free() dereferences a pointer which is
bogus.

What I really don't understand is why this didn't crash a lot earlier
for many more users.

So how is this supposed to be fixed? Should dma_data become a member of
some per-stream instance? I believe that also other platforms than PXA
are actually affected - am I right?

Daniel




[   42.158232] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[   42.166289] pgd = c7f14000
[   42.168970] [00000008] *pgd=a7eff031, *pte=00000000, *ppte=00000000
[   42.175187] Internal error: Oops: 17 [#1]
[   42.179163] last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
[   42.184950] Modules linked in:
[   42.187983] CPU: 0    Not tainted  (2.6.32.10 #99)
[   42.192769] PC is at netlink_dump_start+0x154/0x190
[   42.197609] LR is at 0x306874
[   42.200552] pc : [<c029dc38>]    lr : [<00306874>]    psr: 20000093
[   42.200562] sp : c7ecdd10  ip : 00000000  fp : c053c648
[   42.211954] r10: c7844000  r9 : c7ec8200  r8 : 0000045e
[   42.217141] r7 : c7edc140  r6 : c7ec8600  r5 : 00000000  r4 : 00000000
[   42.223620] r3 : 20000093  r2 : 20000013  r1 : c79df600  r0 : 0000006c
[   42.230102] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   42.237276] Control: 0000397f  Table: a7f14018  DAC: 00000015
[   42.242979] Process alsa (pid: 1118, stack limit = 0xc7ecc278)
[   42.248769] Stack: (0xc7ecdd10 to 0xc7ece000)
[   42.253099] dd00:                                     c0296b94 c7ec8200 00000006 00000000
[   42.261227] dd20: c7ec8600 c0298118 00000000 c7ecde40 c7ecdd5c c7ed8a80 c005030c c7ec8200
[   42.269359] dd40: c7ed8a80 c0298040 c7ecdd7c c7ec8600 00000000 00000038 c053c648 c029ea10
[   42.277493] dd60: c7ed8a80 00000014 c7ed8a80 c0298030 c7844000 c029e6e0 00000014 7fffffff
[   42.285625] dd80: 00000014 00000000 c7ed8a80 c7ec8600 c7ecdf5c c7672580 c7ecde80 00000000
[   42.293748] dda0: 00000014 c029efb0 00000000 c005118c 00000000 00000000 0000045e 00000000
[   42.301872] ddc0: 00000000 00000000 00000000 00000000 00000000 c7ecdf5c 00000014 be1ff9ec
[   42.309997] dde0: c7ecc000 0000000c be1ffa84 c027f730 c0069880 c7ecddf4 00000000 00000001
[   42.318120] de00: ffffffff 00000000 00000000 00000000 00000000 00000000 c7a10f00 00000000
[   42.326247] de20: 00000000 00000000 be1ff9ec c7a10f00 c0069880 c7ecde34 c7ecde34 00120000
[   42.334379] de40: 00000014 be1ff9ec c7ecde80 00001000 c7672580 c0050518 c7ecdd68 c7ecdf5c
[   42.342503] de60: 00000000 be1ffa2c c7672580 be1ffa28 be1ffa44 be1ffa44 0000000c 00000000
[   42.350628] de80: 0000000c c02802c4 c7672580 00000014 c7672580 c0280420 c7ecddb8 c7ecdf5c
[   42.358751] dea0: 00000000 00000000 c027ea8c 00000000 c7ecdedc 00000014 be1ff9ec c7ecdedc
[   42.366876] dec0: 0000000c c7672580 00000000 c7ecdedc 00000014 c027fa08 c00440c4 00000010
[   42.375001] dee0: 00000000 00000000 0000000c c02802c4 0000000c c7672580 c7ecdf04 c0280690
[   42.383124] df00: c7ecdf08 00000010 0000045e 00000000 00000000 c76747d8 c7674780 be1fea1c
[   42.391249] df20: 00000fec c7ecdf4c 00000005 c7ec9f80 c7672580 00000000 c03fd590 c027f3d8
[   42.399373] df40: c03fd590 c0532ab0 c7e8ad80 00000000 00000000 c047c88f 00000005 c7ecdedc
[   42.407497] df60: 0000000c c7ecdf78 00000001 00000000 00000000 00000000 be1ff9ec 00000000
[   42.415620] df80: 00000001 00000000 00000000 be1ff9ec 0000000c 0000000c 00000122 c00440c4
[   42.423746] dfa0: 00000000 c0043f40 be1ff9ec 0000000c 00000005 be1ff9d8 00000014 00000000
[   42.431870] dfc0: be1ff9ec 0000000c 0000000c 00000122 be1ff9ec 00001000 00000000 be1ffa84
[   42.439995] dfe0: 00000000 be1ff9c0 4011e8a4 40123848 60000010 00000005 00000000 00000000
[   42.448139] [<c029dc38>] (netlink_dump_start+0x154/0x190) from [<c0298118>] (rtnetlink_rcv_msg+0xd8/0x220)
[   42.457739] [<c0298118>] (rtnetlink_rcv_msg+0xd8/0x220) from [<c029ea10>] (netlink_rcv_skb+0x4c/0xb0)
[   42.466904] [<c029ea10>] (netlink_rcv_skb+0x4c/0xb0) from [<c0298030>] (rtnetlink_rcv+0x1c/0x2c)
[   42.475640] [<c0298030>] (rtnetlink_rcv+0x1c/0x2c) from [<c029e6e0>] (netlink_unicast+0x22c/0x2d0)
[   42.484550] [<c029e6e0>] (netlink_unicast+0x22c/0x2d0) from [<c029efb0>] (netlink_sendmsg+0x260/0x274)
[   42.493806] [<c029efb0>] (netlink_sendmsg+0x260/0x274) from [<c027f730>] (sock_sendmsg+0xa0/0xc4)
[   42.502630] [<c027f730>] (sock_sendmsg+0xa0/0xc4) from [<c027fa08>] (sys_sendto+0xb0/0xd4)
[   42.510866] [<c027fa08>] (sys_sendto+0xb0/0xd4) from [<c0043f40>] (ret_fast_syscall+0x0/0x28)
[   42.519344] Code: ebfffe2e e10f2000 e3823080 e121f003 (e5943008) 
[   42.525679] ---[ end trace 3209e05a50ffc8c1 ]---
