From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: STAC9228
Date: Thu, 01 Nov 2007 16:23:08 -0700
Message-ID: <1193959388.32561.413.camel@razman.gruemaster.com>
References: <f08e5fd10711010736j5ab19cf9q80b466df93fde182@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 142072447A
	for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2007 00:23:10 +0100 (CET)
In-Reply-To: <f08e5fd10711010736j5ab19cf9q80b466df93fde182@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Meyer <osarusan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could you download and run this script:
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh

Then repost the link it generates.  It generates a vast amount of useful
information about your system.

Thanks,

Tobin Davis

On Thu, 2007-11-01 at 23:36 +0900, Matthew Meyer wrote:

> Hi, I'm using a Fujitsu Stylistic ST5112 tablet PC with Ubuntu 7.10. It has
> the Sigma Tel STAC9228 sound card. I am having tons of trouble getting the
> sound to work; I had this problem in 7.04 too. I used both alsa 1.0.14 and
> 1.0.15RC3, and no luck. I read through ALSA-Configuration.txt and found the
> model at line 924, and I tried using model=ref, model=3stack and
> model=5stack, but none of them worked.
> 
> The only time I've been able to get any sound at all was when I had a
> completely wrong bit of text entered for model=xxx, and in that case the
> system beep worked, but no sound cards were recognized or loaded at all.
> I've checked for the card being muted, and it's not... so I don't know what
> could be wrong. Maybe you have some insight, otherwise, I guess this could
> be a bug?
> 
> Anyway, I hope this helps.
> 
> Matt
> 
> lspci -nv output:
> 00:00.0 0600: 8086:27a0 (rev 03)
>         Subsystem: 10cf:1378
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: <access denied>
> 
> 00:02.0 0300: 8086:27a2 (rev 03) (prog-if 00 [VGA])
>         Subsystem: 10cf:137e
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         Memory at f0300000 (32-bit, non-prefetchable) [size=512K]
>         I/O ports at 1800 [size=8]
>         Memory at e0000000 (32-bit, prefetchable) [size=256M]
>         Memory at f0400000 (32-bit, non-prefetchable) [size=256K]
>         Capabilities: <access denied>
> 
> 00:02.1 0380: 8086:27a6 (rev 03)
>         Subsystem: 10cf:137e
>         Flags: bus master, fast devsel, latency 0
>         Memory at f0380000 (32-bit, non-prefetchable) [size=512K]
>         Capabilities: <access denied>
> 
> 00:1b.0 0403: 8086:27d8 (rev 02)
>         Subsystem: 10cf:13b4
>         Flags: bus master, fast devsel, latency 0, IRQ 23
>         Memory at f0640000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
> 
> 00:1c.0 0604: 8086:27d0 (rev 02) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 00002000-00002fff
>         Memory behind bridge: f0100000-f01fffff
>         Prefetchable memory behind bridge: 0000000090000000-00000000900fffff
>         Capabilities: <access denied>
> 
> 00:1c.1 0604: 8086:27d2 (rev 02) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
>         Capabilities: <access denied>
> 
> 00:1c.2 0604: 8086:27d4 (rev 02) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>         Memory behind bridge: 90100000-901fffff
>         Capabilities: <access denied>
> 
> 00:1d.0 0c03: 8086:27c8 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: 10cf:1389
>         Flags: bus master, medium devsel, latency 0, IRQ 20
>         I/O ports at 1820 [size=32]
> 
> 00:1d.1 0c03: 8086:27c9 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: 10cf:1389
>         Flags: bus master, medium devsel, latency 0, IRQ 18
>         I/O ports at 1840 [size=32]
> 
> 00:1d.2 0c03: 8086:27ca (rev 02) (prog-if 00 [UHCI])
>         Subsystem: 10cf:1389
>         Flags: bus master, medium devsel, latency 0, IRQ 21
>         I/O ports at 1860 [size=32]
> 
> 00:1d.3 0c03: 8086:27cb (rev 02) (prog-if 00 [UHCI])
>         Subsystem: 10cf:1389
>         Flags: bus master, medium devsel, latency 0, IRQ 19
>         I/O ports at 1880 [size=32]
> 
> 00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20 [EHCI])
>         Subsystem: 10cf:138a
>         Flags: bus master, medium devsel, latency 0, IRQ 20
>         Memory at f0644000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: <access denied>
> 
> 00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01 [Subtractive decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=08, subordinate=10, sec-latency=32
>         I/O behind bridge: 00003000-00003fff
>         Memory behind bridge: f0200000-f02fffff
>         Prefetchable memory behind bridge: 0000000088000000-000000008fffffff
>         Capabilities: <access denied>
> 
> 00:1f.0 0601: 8086:27b9 (rev 02)
>         Subsystem: 10cf:1384
>         Flags: bus master, medium devsel, latency 0
>         Capabilities: <access denied>
> 
> 00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: 10cf:1385
>         Flags: bus master, medium devsel, latency 0, IRQ 21
>         I/O ports at 01f0 [size=8]
>         I/O ports at 03f4 [size=1]
>         I/O ports at 0170 [size=8]
>         I/O ports at 0374 [size=1]
>         I/O ports at 1810 [size=16]
> 
> 00:1f.2 0106: 8086:27c5 (rev 02) (prog-if 01 [AHCI 1.0])
>         Subsystem: 10cf:1387
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 22
>         I/O ports at 18d0 [size=8]
>         I/O ports at 18c4 [size=4]
>         I/O ports at 18c8 [size=8]
>         I/O ports at 18c0 [size=4]
>         I/O ports at 18b0 [size=16]
>         Memory at f0644400 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: <access denied>
> 
> 00:1f.3 0c05: 8086:27da (rev 02)
>         Subsystem: 10cf:1388
>         Flags: medium devsel, IRQ 11
>         I/O ports at 18e0 [size=32]
> 
> 02:00.0 0200: 11ab:4363 (rev 12)
>         Subsystem: 10cf:139a
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         Memory at f0100000 (64-bit, non-prefetchable) [size=16K]
>         I/O ports at 2000 [size=256]
>         [virtual] Expansion ROM at 90000000 [disabled] [size=128K]
>         Capabilities: <access denied>
> 
> 05:00.0 0200: 168c:001c (rev 01)
>         Subsystem: 10cf:139c
>         Flags: bus master, fast devsel, latency 0, IRQ 21
>         Memory at 90100000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: <access denied>
> 
> 08:03.0 0607: 1217:7134 (rev 21)
>         Subsystem: 10cf:131e
>         Flags: bus master, stepping, slow devsel, latency 168, IRQ 19
>         Memory at f0203000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=08, secondary=09, subordinate=0c, sec-latency=176
>         Memory window 0: 88000000-8bfff000 (prefetchable)
>         Memory window 1: 94000000-97fff000
>         I/O window 0: 00003000-000030ff
>         I/O window 1: 00003400-000034ff
>         16-bit legacy interface ports at 0001
> 
> 08:03.1 0607: 1217:7134 (rev 21)
>         Subsystem: 10cf:131e
>         Flags: bus master, stepping, slow devsel, latency 168, IRQ 19
>         Memory at f0204000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=08, secondary=0d, subordinate=10, sec-latency=176
>         Memory window 0: 8c000000-8ffff000 (prefetchable)
>         Memory window 1: 98000000-9bfff000
>         I/O window 0: 00003800-000038ff
>         I/O window 1: 00003c00-00003cff
>         16-bit legacy interface ports at 0001
> 
> 08:03.2 0805: 1217:7120 (rev 01)
>         Subsystem: 10cf:131e
>         Flags: slow devsel, IRQ 19
>         Memory at f0202800 (32-bit, non-prefetchable) [size=256]
>         Capabilities: <access denied>
> 
> 08:03.3 0680: 1217:7130 (rev 01)
>         Subsystem: 10cf:131e
>         Flags: slow devsel, IRQ 11
>         Memory at f0200000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: <access denied>
> 
> 08:03.4 0c00: 1217:00f7 (rev 02) (prog-if 10 [OHCI])
>         Subsystem: 1217:00f7
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         Memory at f0201000 (32-bit, non-prefetchable) [size=4K]
>         Memory at f0202000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: <access denied>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


He asked me if I knew what time it was -- I said yes, but not right now.
		-- Steven Wright
