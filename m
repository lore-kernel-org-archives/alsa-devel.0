From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 25 May 2010 10:41:33 +1000
Message-ID: <20100525004126.GA10968@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 54DE524751
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 02:41:39 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OGiD8-0004bC-Sp
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 10:41:35 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGiD7-0004at-Lq
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 10:41:34 +1000
Content-Disposition: inline
In-Reply-To: <1274698156.3064.93.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 24, 2010 at 11:49:16AM +0100, Liam Girdwood wrote:
> On Mon, 2010-05-24 at 17:49 +1000, Stuart Longland wrote:
> > Now this compiles... but when I go to load it; one of two things
> > happens... either practically nothing (at this stage; no modules are
> > loaded prior to calling modprobe):
> > 
> 
> It does sound like you have some memory corruption somewhere. Can you
> rule out your new CODEC driver by replacing it with another CODEC driver
> (ads117x.c is a very simple example).
> 
> Liam

Well, the plot thickens... I tried two things.

(1) I swapped my 'AIC3204 driver for the 'AIC3X driver that my driver
was originally based upon, and retried loading the driver.  No blowups,
but now devices appearing in /proc/asound/cards or /proc/asound/devices.

(2) I then tried using the phycore-ac97 driver (after disabling the
relevant checks to see it was running on a Phycore module).  First load
went kaboom:

192 / # depmod -a && modprobe snd-soc-phycore-ac97

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = c3e68000
[00000008] *pgd=a3e53031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT
last sysfs file: 
Modules linked in: snd_soc_phycore_ac97(+) snd_soc_wm9712 snd_soc_imx
snd_soc_tlv320aic3x snd_soc_core snd_pcm snd_timer snd soundcore snd_page_alloc
ac97_bus [last unloaded: snd_soc_jem3]
CPU: 0    Not tainted  (2.6.34-jacques-jem3 #16)
PC is at snd_soc_instantiate_cards+0x2c/0x7b4 [snd_soc_core]
LR is at 0x0
pc : [<bf0513d8>]    lr : [<00000000>]    psr: 20000013
sp : c3e63db0  ip : bf05906c  fp : bf059074
r10: 00000001  r9 : bf058fd0  r8 : 00000000
r7 : bf080788  r6 : c3d2d1a8  r5 : bf072960  r4 : bf059074
r3 : 00000000  r2 : 00000000  r1 : bf072960  r0 : bf059074
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: a3e68000  DAC: 00000015
Process modprobe (pid: 288, stack limit = 0xc3e62270)
Stack: (0xc3e63db0 to 0xc3e64000)
3da0:                                     c3e63dec 00000001 c3d2d1a8 00000000
3dc0: bf0897e8 00000000 c034f1c8 00000000 c3e62000 c0167c18 c02eee78 c3e63e34
3de0: c3e63e6c c3c0e7a8 00000000 c0275b24 c3c15040 c003a008 c3c15040 000000d0
3e00: c02e2fbc c3e62000 c3ea89c8 c3ea44b8 c3e63e34 00000008 c034f1dc c3e6d1e0
3e20: c3e6d1e0 c3ea44b8 c3ea89c8 c00f2674 00000000 0000073c c3e63e60 c3ea89c8
3e40: c3ea44b8 c00f2724 c0355190 00000000 c3ea89c8 bf0910c8 bf0910d0 c3d2d1a8
3e60: 00000000 c3d2d1b0 00000000 c033ec88 00000000 bf052ed0 c0355190 c3d2d1a8
3e80: c3e63eb0 bf059020 c0355190 c01ac47c bf059020 c01ab394 c3d2d1a8 00000000
3ea0: c3e63eb0 c3d2d1a8 c01ab548 c01aa628 c3c044e8 c3e71ad4 c02de99c c3d2d1a8
3ec0: c3d2d1a8 c3d2d1dc 00000000 c01ab5f4 c3d2d1a8 c3d2d1a8 00000000 c01aa5a8
3ee0: 00000000 c01a8c20 bf091154 c3d2d1b0 c3d2d1b0 00000000 00000000 c0168c18
3f00: c3d2d1a8 c3d2d1a8 c3d2d1a0 00000000 bf094000 c0021b88 00000000 c034578c
3f20: 000190bc c01acaa0 c3d2d1a8 bf091288 fffffff4 bf0910b8 bf094000 bf094058
3f40: 00000fc5 bf091148 c3e62000 c0021374 00000000 00000000 00000000 00000fc5
3f60: bf091148 000278c8 00000fc5 bf091148 000278c8 00000000 c0021b88 c3e62000
3f80: 00000000 c006e48c 00000001 00000000 00020138 0000cf60 00019380 00019370
3fa0: 00000080 c00219e0 0000cf60 00019380 000278c8 00000fc5 00019330 00019330
3fc0: 0000cf60 00019380 00019370 00000080 00000000 bec56984 00000000 000190bc
3fe0: 000190b0 bec56514 0000bc98 4010ab44 60000010 000278c8 00000000 00000000
[<bf0513d8>] (snd_soc_instantiate_cards+0x2c/0x7b4 [snd_soc_core]) from
[<bf052ed0>] (soc_probe+0x74/0xb0 [snd_soc_core])
[<bf052ed0>] (soc_probe+0x74/0xb0 [snd_soc_core]) from [<c01ac47c>]
(platform_drv_probe+0x1c/0x24)
[<c01ac47c>] (platform_drv_probe+0x1c/0x24) from [<c01ab394>]
(driver_probe_device+0x88/0x180)
[<c01ab394>] (driver_probe_device+0x88/0x180) from [<c01aa628>]
(bus_for_each_drv+0x60/0x8c)
[<c01aa628>] (bus_for_each_drv+0x60/0x8c) from [<c01ab5f4>]
(device_attach+0x5c/0x74)
[<c01ab5f4>] (device_attach+0x5c/0x74) from [<c01aa5a8>]
(bus_probe_device+0x30/0x50)
[<c01aa5a8>] (bus_probe_device+0x30/0x50) from [<c01a8c20>]
(device_add+0x1f4/0x4c0)
[<c01a8c20>] (device_add+0x1f4/0x4c0) from [<c01acaa0>]
(platform_device_add+0xf0/0x194)
[<c01acaa0>] (platform_device_add+0xf0/0x194) from [<bf094058>]
(imx_phycore_init+0x58/0x98 [snd_soc_phycore_ac97])
[<bf094058>] (imx_phycore_init+0x58/0x98 [snd_soc_phycore_ac97]) from
[<c0021374>] (do_one_initcall+0x2c/0x1a8)
[<c0021374>] (do_one_initcall+0x2c/0x1a8) from [<c006e48c>]
(sys_init_module+0xc4/0x1f8)
[<c006e48c>] (sys_init_module+0xc4/0x1f8) from [<c00219e0>]
(ret_fast_syscall+0x0/0x2c)
Code: e1530002 0a000021 e597203c e5973010 (e5922008) 
---[ end trace 79ad861a733eea22 ]---
192 / # cat /proc/asound/cards 
--- no soundcards ---

A reboot, and I repeat the experiment.  Nothing went bang, but nothing
happened either:

192 / # modprobe snd-soc-phycore-ac97
192 / # mount /proc
192 / # lsmod
Module                  Size  Used by
snd_soc_phycore_ac97      795  0 
snd_soc_wm9712         17489  1 snd_soc_phycore_ac97
snd_soc_imx            10105  2 snd_soc_phycore_ac97,snd_soc_wm9712
snd_soc_core           45013  2 snd_soc_wm9712,snd_soc_imx
ac97_bus                 840  1 snd_soc_core
snd_pcm                68536  2 snd_soc_imx,snd_soc_core
snd_timer              18154  1 snd_pcm
snd                    48419  3 snd_soc_core,snd_pcm,snd_timer
soundcore               5339  1 snd
snd_page_alloc          3496  1 snd_pcm
192 / # cat /proc/asound/cards 
--- no soundcards ---
192 / # cat /proc/asound/devices 
  2:        : timer

I'm not sure whether that is due to the CODEC not being found by the
wm9712 driver (which is understandable; there isn't one) or whether
there's bugs in the i.MX driver that leads to the devices attached not
getting discovered.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
