From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Locking issue from snd_soc_suspend
Date: Mon, 11 Jan 2016 18:21:51 -0200
Message-ID: <CAOMZO5BajMzAp8_M4RjjwZeHs11jdp0SCQQK1ChT9eGwVmgdTQ@mail.gmail.com>
References: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 78FC3260455
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 21:21:52 +0100 (CET)
Received: by mail-ig0-f176.google.com with SMTP id h5so78228938igh.0
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 12:21:52 -0800 (PST)
In-Reply-To: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 7, 2016 at 9:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> I get the following issue when doing a suspend/resume sequence on a
> mx6q-cubox-i running 4.4-rc8.
>
> Haven't started debugging it yet, but if someone has some ideas,
> please let me know.
>
> Thanks
>
> $ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
> $ echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.003 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
> Unable to handle kernel NULL pointer dereference at virtual address 0000073c
> pgd = ed888000
> [0000073c] *pgd=8ecdf831
> Internal error: Oops: 17 [#1] SMP ARM
> Modules linked in:
> CPU: 3 PID: 988 Comm: sh Not tainted 4.4.0-rc8 #272
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> task: ee2ab980 ti: ed8f8000 task.ti: ed8f8000
> PC is at __lock_acquire+0x15c/0x1ba4
> LR is at lock_acquire+0x78/0x98
> pc : [<c006f120>]    lr : [<c0070f20>]    psr: 20000093
> sp : ed8f9bb0  ip : 00000000  fp : ed8f9c3c
> r10: 00000000  r9 : c0af1ba8  r8 : 0000073c
> r7 : ee2ab980  r6 : c1332014  r5 : c0ae42e4  r4 : ed8f8000
> r3 : c112f600  r2 : 00000000  r1 : 00000000  r0 : 0000073c
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 3d88804a  DAC: 00000051
> Process sh (pid: 988, stack limit = 0xed8f8210)
> Stack: (0xed8f9bb0 to 0xed8fa000)
> 9ba0:                                     00000000 ee2abe28 00000005 c1332014
> 9bc0: ee2ab980 c1333944 c0af1ba8 00000016 00000000 ee2abe08 00000000 c1332014
> 9be0: ee2ab980 ee9b4210 c0af1ba8 0000009b 00000000 ee2abe08 00000004 c1332014
> 9c00: ee2ab980 ee9d1478 c0af1ba8 0000009c ed8f9cac 00000000 60000013 c05844e0
> 9c20: 00000001 ee9d1444 00000708 ee9d1410 ed8f9c74 ed8f9c40 c0070f20 c006efd0
> 9c40: 00000001 00000000 00000000 c05844e0 00000000 00000000 c05844e0 00000000
> 9c60: c1332014 ee2ab980 ed8f9ccc ed8f9c78 c07ab5b0 c0070eb4 00000001 00000000
> 9c80: c05844e0 00000000 ed8f9cb4 ed8f9c98 c0071754 c006e920 c07ab840 ee2ab980
> 9ca0: 00000001 00000000 ee248c10 c03c3194 00000002 ee9d1444 00000000 ee9d1410
> 9cc0: ed8f9cf4 ed8f9cd0 c05844e0 c07ab560 c05844a8 00000000 00000000 c03c3194
> 9ce0: 00000002 ee9d1444 ed8f9d04 ed8f9cf8 c03c31c8 c05844b4 ed8f9d3c ed8f9d08
> 9d00: c03cc850 c03c31a0 c07af6cc c0071974 00000000 00000000 ee9d1410 00000000
> 9d20: c134b238 00000002 ee9d1444 00000000 ed8f9d6c ed8f9d40 c03cd754 c03cc828
> 9d40: ee9d14c0 009d1410 c0b016c0 ee9d14c0 ee9d1410 c0b016c0 c134b238 c0b01724
> 9d60: ed8f9db4 ed8f9d70 c03ceaec c03cd62c a4b37d28 00000002 c03cee68 00000002
> 9d80: a4b37d28 00000002 60000013 00000002 c12ef69c 00000003 00000003 ed802200
> 9da0: 00000000 00000004 ed8f9dcc ed8f9db8 c03ceee4 c03ce9e4 00000000 c12ef69c
> 9dc0: ed8f9e14 ed8f9dd0 c00770a8 c03cee90 c007adf0 c007a834 c0978fac ed8f9e0c
> 9de0: ed8f9e04 ed8f9df0 c00c74e4 00000000 00000003 c12ef6a8 00000003 ed802200
> 9e00: 00000000 00000004 ed8f9e34 ed8f9e18 c0077718 c0077024 0000006d 00000003
> 9e20: c0974c8c c12ef6ac ed8f9e5c ed8f9e38 c00760c0 c00774a8 edffb580 00000004
> 9e40: ed802200 00000004 00000000 00000000 ed8f9e6c ed8f9e60 c02d4438 c007605c
> 9e60: ed8f9e8c ed8f9e70 c017bd30 c02d4428 c017bcdc edffb580 ed802200 edffb58c
> 9e80: ed8f9ed4 ed8f9e90 c017b028 c017bce8 00000000 00000000 60000013 c010e888
> 9ea0: ed8f9f78 00000051 ed8f8000 c07bf87c 01668408 edf24a00 ed8f9f78 00000004
> 9ec0: ed8f8000 01668408 ed8f9f44 ed8f9ed8 c010bfd8 c017af6c c006b5a8 c008423c
> 9ee0: 00000001 ee265234 ed8f9f24 ed8f9ef8 c006b824 c006b59c 00000001 00000000
> 9f00: c010e888 c0b3f6d5 ed8f9f34 00000001 ee265000 00000000 ed8f9f44 ed8f9f28
> 9f20: c010e888 edf24a00 01668408 00000004 ed8f9f78 00000004 ed8f9f74 ed8f9f48
> 9f40: c010d024 c010bfb0 c0129ce4 c0129c48 00000000 00000000 edf24a00 edf24a00
> 9f60: 00000004 01668408 ed8f9fa4 ed8f9f78 c010d2bc c010cf98 00000000 00000000
> 9f80: 00000004 b6f935c0 00000004 00000004 c000ff44 00000000 00000000 ed8f9fa8
> 9fa0: c000fda0 c010d284 00000004 b6f935c0 00000001 01668408 00000004 00000000
> 9fc0: 00000004 b6f935c0 00000004 00000004 01668408 016662e8 bea7fa48 00000000
> 9fe0: 00000000 bea7f9c8 b6ecf690 b6f220bc 60000010 00000001 00000000 00000000
> Backtrace:
> [<c006efc4>] (__lock_acquire) from [<c0070f20>] (lock_acquire+0x78/0x98)
>  r10:ee9d1410 r9:00000708 r8:ee9d1444 r7:00000001 r6:c05844e0 r5:60000013
>  r4:00000000
> [<c0070ea8>] (lock_acquire) from [<c07ab5b0>] (mutex_lock_nested+0x5c/0x3ec)
>  r7:ee2ab980 r6:c1332014 r5:00000000 r4:c05844e0
> [<c07ab554>] (mutex_lock_nested) from [<c05844e0>] (snd_soc_suspend+0x38/0x404)
>  r10:ee9d1410 r9:00000000 r8:ee9d1444 r7:00000002 r6:c03c3194 r5:ee248c10
>  r4:00000000
> [<c05844a8>] (snd_soc_suspend) from [<c03c31c8>] (platform_pm_suspend+0x34/0x5c)

Martin also observed the same problem on a mx53 and uses the following
patch to avoid it:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a1305f8..a7ddf69 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -584,6 +584,9 @@ int snd_soc_suspend(struct device *dev)
        if (!card->instantiated)
                return 0;

+       if (!card->snd_card)
+               return 0;
+
        /* Due to the resume being scheduled into a workqueue we could
        * suspend before that's finished - wait for it to complete.
         */
@@ -814,6 +817,9 @@ int snd_soc_resume(struct device *dev)
        if (!card->instantiated)
                return 0;

+       if (!card->snd_card)
+               return 0;
+
        /* activate pins from sleep state */

Applying this change allows suspend/resume to work on a mx6q-cubox-i as well.

Could anyone comment about it? Thanks
