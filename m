From: Robert Lemmen <robertle@semistable.com>
Subject: Re: hda-intel without headphone output
Date: Wed, 20 Jun 2007 21:02:40 +0200
Message-ID: <20070620190240.GA13021@sandbender>
References: <20070614083156.GB26945@sandbender> <s5h8xamk612.wl%tiwai@suse.de>
	<20070614182703.GA9443@sandbender>
	<1181874374.12385.203.camel@razman.gruemaster.com>
	<s5hhcp4i711.wl%tiwai@suse.de> <20070619113525.GA4477@sandbender>
	<s5htzt4gof6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d80-237-144-212.dds.hosteurope.de (debian.semistable.com
	[80.237.144.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 048F324396
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 21:08:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htzt4gof6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 19, 2007 at 01:43:25PM +0200, Takashi Iwai wrote:
> The patch works as if model=fujitsu.  So I suppose model=fujitsu
> doesn't work as expected?
> 
> Try to replace CXT5045_FUJITSU with CXT5045_LAPTOP in that patch.

hi everyone,

i am sorry, but this still doesn't work. if i pass model=laptop on the
modprobe line or through /etc/modultils.d/, everything works as
expected, including speaker muting on headphone jack insert. using no
param or fujitsu works, but without muting. perhaps the driver somehow
does not pick up the automatic model setting? is there a way to query a
running driver on which model it did select? or is there a way to add
something like a printf() to an alsa module (just for debugging)? and
lastly: i have no idea how all this stuff works, but looking at the
patch, it looks like you are tying the lspci subsystem id to the model.
in my lspci output i have multiple devices with that subsystem id
(1734:10cb), could that be a problem? full lspci -vn output:

00:00.0 0600: 1106:0364
        Subsystem: 1106:0364
        Flags: medium devsel
        Memory at c0000000 (32-bit, prefetchable) [disabled] [size=128M]
        Capabilities: <access denied>

00:00.1 0600: 1106:1364
        Flags: bus master, medium devsel, latency 0

00:00.2 0600: 1106:2364
        Flags: bus master, medium devsel, latency 0

00:00.3 0600: 1106:3364
        Flags: bus master, medium devsel, latency 0

00:00.4 0600: 1106:4364
        Flags: bus master, medium devsel, latency 0

00:00.5 0800: 1106:5364 (prog-if 20 [IO(X)-APIC])
        Flags: bus master, fast devsel, latency 0

00:00.6 0600: 1106:6364
        Flags: bus master, fast devsel, latency 0

00:00.7 0600: 1106:7364
        Flags: bus master, medium devsel, latency 0

00:01.0 0604: 1106:b198 (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: c8000000-c8ffffff
        Prefetchable memory behind bridge: a0000000-bfffffff
        Capabilities: <access denied>

00:02.0 0604: 1106:a364 (rev 80) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: <access denied>

00:03.0 0604: 1106:c364 (rev 80) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: c9000000-c90fffff
        Capabilities: <access denied>

00:0f.0 0101: 1106:0591 (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 64, IRQ 217
        I/O ports at 60b8 [size=8]
        I/O ports at 60b0 [size=4]
        I/O ports at 6008 [size=8]
        I/O ports at 6004 [size=4]
        I/O ports at 6010 [size=16]
        I/O ports at 6400 [size=256]
        Capabilities: <access denied>

00:0f.1 0101: 1106:0571 (rev 07) (prog-if 8a [Master SecP PriP])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 0
        I/O ports at 60a0 [size=16]
        Capabilities: <access denied>

00:10.0 0c03: 1106:3038 (rev a0) (prog-if 00 [UHCI])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 64, IRQ 233
        I/O ports at 6020 [size=32]
        Capabilities: <access denied>

00:10.1 0c03: 1106:3038 (rev a0) (prog-if 00 [UHCI])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 64, IRQ 50
        I/O ports at 6040 [size=32]
        Capabilities: <access denied>

00:10.2 0c03: 1106:3038 (rev a0) (prog-if 00 [UHCI])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 64, IRQ 217
        I/O ports at 6060 [size=32]
        Capabilities: <access denied>

00:10.3 0c03: 1106:3038 (rev a0) (prog-if 00 [UHCI])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 64, IRQ 225
        I/O ports at 6080 [size=32]
        Capabilities: <access denied>

00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20 [EHCI])
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 64, IRQ 217
        Memory at c9400000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>

00:11.0 0601: 1106:3337
        Subsystem: 1734:10cb
        Flags: medium devsel
        Capabilities: <access denied>

00:11.7 0600: 1106:287e
        Subsystem: 1106:337e
        Flags: medium devsel
        Capabilities: <access denied>

00:12.0 0200: 1106:3065 (rev 7c)
        Subsystem: 1734:10cb
        Flags: bus master, medium devsel, latency 24, IRQ 225
        I/O ports at 6800 [size=256]
        Memory at c9400400 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>

00:13.0 0604: 1106:337b (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        Memory behind bridge: c9100000-c91fffff
        Capabilities: <access denied>

00:13.1 0604: 1106:337a (prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        Memory behind bridge: 50000000-500fffff
        Capabilities: <access denied>

01:00.0 0300: 1106:3371 (rev 01) (prog-if 00 [VGA])
        Subsystem: 1734:10cb
        Flags: bus master, 66MHz, medium devsel, latency 16, IRQ 9
        Memory at a0000000 (32-bit, prefetchable) [size=512M]
        Memory at c8000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: <access denied>

04:01.0 0403: 1106:3288 (rev 10)
        Subsystem: 1734:10cb
        Flags: bus master, fast devsel, latency 0, IRQ 58
        Memory at c9100000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>

05:01.0 0200: 168c:001a (rev 01)
        Subsystem: 168c:2052
        Flags: bus master, medium devsel, latency 80, IRQ 10
        Memory at 50000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: <access denied>

cu  robert

-- 
Robert Lemmen                               http://www.semistable.com 
