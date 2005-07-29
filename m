From: Voluspa <lista1@telia.com>
Subject: via82xx dxs_support=5 OK
Date: Fri, 29 Jul 2005 07:04:01 +0200
Message-ID: <20050729070401.525b58fd.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pne-smtpout1-sn1.fre.skanova.net (pne-smtpout1-sn1.fre.skanova.net [81.228.11.98])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 42596176
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 07:04:03 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


"via82xx: Assuming DXS channels with 48k fixed sample rate.
          Please try dxs_support=5 option
          and report if it works on your machine.
          For more details, read ALSA-Configuration.txt."

I assumed you meant:
<kernel-src>/Documentation/sound/alsa/ALSA-Configuration.txt
And so it was ;-)

Ok, not being too sound familiar I can only say that loading snd-via82xx
with the option dxs_support=5 and playing different files work here (the
missing message quoted above in the kernel log confirmed that the option
"stuck").

Playing 1 .mp3 in xmms (44.1kHz) + 1 .wav in aplay (44.1kHz) = OK
Playing 1 ogg stream in xmms (32kHz) + (see above) = OK
Playing 1 ogg stream in xmms (44.1kHz) + (see above) = OK
Playing 1 .wav in xmms (44.1kHz) + (see above) = OK
Playing 1 .shn in xmms (~44.1kHz?) + (see above) = OK

Don't know if I should have played more files/streams at the same time. The
ALSA-Configuration.txt talks about "up to 4 streams can be played at the
same time". And I don't really know what you mean by "48k fixed rate". The
files/stream-examples I've listed above show the exact same kHz info with or
without the dxs_support=5 option.

Anyway, here's the info you request:

root:sleipner:~# cat /proc/pci

[...]
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 80).
      IRQ 19.
      I/O at 0x1400 [0x14ff].

root:sleipner:~# lspci -nv

00:00.0 Class 0600: 1106:0204
        Subsystem: 1025:006e
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [80] AGP version 3.0
        Capabilities: [50] Power Management version 2
        Capabilities: [60] #08 [0060]
        Capabilities: [58] #08 [8001]

00:00.1 Class 0600: 1106:1204
        Flags: bus master, medium devsel, latency 0

00:00.2 Class 0600: 1106:2204
        Flags: bus master, medium devsel, latency 0
00:00.3 Class 0600: 1106:3204
        Flags: bus master, medium devsel, latency 0

00:00.4 Class 0600: 1106:4204
        Flags: bus master, medium devsel, latency 0

00:00.7 Class 0600: 1106:7204
        Flags: bus master, medium devsel, latency 0

00:01.0 Class 0604: 1106:b188
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: c1000000-c1ffffff
        Prefetchable memory behind bridge: e0000000-efffffff
        Capabilities: [80] Power Management version 2

00:0a.0 Class 0200: 17fe:2220
        Subsystem: 1468:0305
        Flags: medium devsel, IRQ 10
        I/O ports at 1c00 [size=32]
        Memory at c0006000 (32-bit, non-prefetchable) [size=32]
        Memory at c0005000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [40] Power Management version 2

00:0b.0 Class 0607: 104c:ac8e
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at 28020000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20000000-21fff000 (prefetchable)
        Memory window 1: 22000000-23fff000 (prefetchable)
        I/O window 0: 00002000-00002fff
        I/O window 1: 00003000-00003fff
        16-bit legacy interface ports at 0001

00:0b.1 Class 0607: 104c:ac8e
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64, IRQ 17
        Memory at 28021000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 24000000-25fff000 (prefetchable)
        Memory window 1: 26000000-27fff000 (prefetchable)
        I/O window 0: 00004000-00004fff
        I/O window 1: 00005000-00005fff
        16-bit legacy interface ports at 0001

00:0b.2 Class 0c00: 104c:802e (prog-if 10)
        Subsystem: 1025:006e
        Flags: medium devsel, IRQ 11
        Memory at c0005800 (32-bit, non-prefetchable) [size=2K]
        Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

00:0c.0 Class 0200: 10ec:8169 (rev 10)
        Subsystem: 1025:006e
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
        I/O ports at 1000 [size=256]
        Memory at c0006400 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 28000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:10.0 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64, IRQ 18
        I/O ports at 1c20 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64, IRQ 18
        I/O ports at 1c40 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64, IRQ 18
        I/O ports at 1c60 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64, IRQ 18
        Memory at c0006800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 Class 0601: 1106:3177
        Subsystem: 1106:3177
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1025:006e
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1c80 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1025:0046
        Flags: medium devsel, IRQ 19
        I/O ports at 1400 [size=256]
        Capabilities: [c0] Power Management version 2

00:11.6 Class 0780: 1106:3068 (rev 80)
        Subsystem: 1025:0046
        Flags: medium devsel, IRQ 11
        I/O ports at 1800 [size=256]
        Capabilities: [d0] Power Management version 2

00:18.0 Class 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] #08 [2101]

00:18.1 Class 0600: 1022:1101
        Flags: fast devsel

00:18.2 Class 0600: 1022:1102
        Flags: fast devsel

00:18.3 Class 0600: 1022:1103
        Flags: fast devsel

01:00.0 Class 0300: 10de:0347 (rev a1)
        Subsystem: 1025:006e
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 20
        Memory at c1000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

Mvh
Mats Johannesson
--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
