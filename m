From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: BUG since "ASoC: simple-card: Add pm callbacks to platform driver"
Date: Tue, 17 May 2016 12:55:01 +0200
Message-ID: <CAMuHMdX6veYCvRdJjui3J0oPUKLhZB1Y8_AROnqhtZS9=HyNTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Peter, Mark, Liam,

With today's sound-asoc/for-next, I'm seeing on r8a7791/koelsch and
sh73a0/kzm9g:

    kernel BUG at drivers/base/regmap/regcache.c:347!
    Internal error: Oops - BUG: 0 [#1] SMP ARM
    Modules linked in:
    CPU: 0 PID: 20 Comm: kworker/0:1 Not tainted
4.6.0-koelsch-07135-g1481dd77fa7d01cb #2621
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    Workqueue: events soc_resume_deferred
    task: ef512100 ti: ef5a6000 task.ti: ef5a6000
    PC is at regcache_sync+0xc/0x118
    LR is at ak4642_resume+0x20/0x28
    pc : [<c04932a4>]    lr : [<c05bd34c>]    psr: 60000153
    sp : ef5a7ee0  ip : ee7ea62c  fp : 00000008
    r10: 00000000  r9 : ee7ebd0c  r8 : ee7ebd18
    r7 : ee7ebc10  r6 : ee7ebcb8  r5 : ee7ebd08  r4 : eefc5800
    r3 : 00000000  r2 : eefc5814  r1 : 001c001b  r0 : eefc5800
    Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
    Control: 30c5387d  Table: 6eaee540  DAC: fffffffd
    Process kworker/0:1 (pid: 20, stack limit = 0xef5a6210)
    Stack: (0xef5a7ee0 to 0xef5a8000)
    7ee0: eefc5600 c05ae878 ef588100 ee7ebd08 ef9bdf00 00000000
ef9c4400 c023341c
    7f00: ef588100 ee7ebd08 ef588100 ef9bdf00 ef9bdf00 ef5a6000
ef9bdf24 c0e02100
    7f20: ef588118 c0233ae0 ef512100 ef59ae00 00000000 ef588100
c0233838 00000000
    7f40: 00000000 00000000 00000000 c0237b58 00000001 00000000
ef43b040 ef588100
    7f60: 00000000 00000000 dead4ead ffffffff ffffffff ef5a7f74
ef5a7f74 00000000
    7f80: 00000000 dead4ead ffffffff ffffffff ef5a7f90 ef5a7f90
ef5a7fac ef59ae00
    7fa0: c0237a80 00000000 00000000 c0206b68 00000000 00000000
00000000 00000000
    7fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
ef5a7ff4 00000000
    [<c04932a4>] (regcache_sync) from [<ee7ebd08>] (0xee7ebd08)
    Code: c0978f0f e590312c e3530000 1a000000 (e7f001f2)

I've bisected this to

commit 7c3767115a04bc7aa87bdbd3352d1801d4bbeea4
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Mon May 9 13:38:10 2016 +0300

    ASoC: simple-card: Add pm callbacks to platform driver

    Set snd_soc_pm_ops for the pm ops to make sure that the ASoC level of PM
    operations are going to happen. This is needed to get suspend/resume
    working correctly when the audio is using simple-card.

    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

Reverting it fixes the problem for me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
