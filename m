From: Tim Blechmann <TimBlechmann-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: snd-hdsp+cardbus=distortion -- the saga
	continues (cardbus driver=culprit?)
Date: Mon, 29 Mar 2004 18:57:33 +0200
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040329185733.284ddac0@laptop>
References: <20040326181517.CZPI16557.smtp2.fuse.net@smtp.fuse.net>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <20040326181517.CZPI16557.smtp2.fuse.net-TAIDijpykVYqcZcGjlUOXw@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, ico-rDkNP/OoUoU@public.gmane.org
Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

> 1) provide detailed lspci
would it be possible, that you send be your lspci -v output?
this is mine:

bash-2.05b# lspci -v
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)        Subsystem: Acer Incorporated [ALI]: Unknown
device 0019        Flags: bus master, fast devsel, latency 0
        Memory at ec000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [9104]
        Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
Bridge (rev 04) (prog-if 00 [Normal decode])        Flags: bus master,
66Mhz, fast devsel, latency 96        Bus: primary=00, secondary=01,
subordinate=01, sec-latency=64        I/O behind bridge:
00003000-00003fff        Memory behind bridge: e8000000-e80fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Expansion ROM at 00003000 [disabled] [size=4K]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
(prog-if 00 [Normal decode])        Flags: bus master, fast devsel,
latency 0        Bus: primary=00, secondary=02, subordinate=02,
sec-latency=64        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: e8100000-e81fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
(prog-if 80 [Master])        Subsystem: Acer Incorporated [ALI]: Unknown
device 0019        Flags: bus master, medium devsel, latency 0
        I/O ports at 1800 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev
05) (prog-if 00 [UHCI])        Subsystem: Acer Incorporated [ALI]:
Unknown device 0019        Flags: bus master, medium devsel, latency 0,
IRQ 5        I/O ports at 1820 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Flags: medium devsel, IRQ 11
        I/O ports at 1810 [size=16]

0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev
05) (prog-if 00 [UHCI])        Subsystem: Acer Incorporated [ALI]:
Unknown device 0019        Flags: bus master, medium devsel, latency 0,
IRQ 11        I/O ports at 1840 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97
Audio (rev 05)        Subsystem: Acer Incorporated [ALI]: Unknown device
0019        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1c00
        I/O ports at 1880 [size=64]

0000:00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev
05) (prog-if 00 [Generic])        Subsystem: Acer Incorporated [ALI]:
Unknown device 0019        Flags: medium devsel, IRQ 11
        I/O ports at 2400
        I/O ports at 2000 [size=128]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
Mobility M6 LY (prog-if 00 [VGA])        Subsystem: Acer Incorporated
[ALI]: Unknown device 0019        Flags: bus master, stepping, fast
Back2Back, 66Mhz, medium devsel, latency 66, IRQ 5        Memory at
f0000000 (32-bit, prefetchable)        I/O ports at 3000 [size=256]
        Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

0000:02:00.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller
(rev 01)        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 5
        Memory at 20000000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004400-000044ff
        I/O window 1: 00004800-000048ff
        16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller
(rev 01)        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
        Memory at 20001000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004c00-00004cff
        I/O window 1: 00005000-000050ff
        16-bit legacy interface ports at 0001

0000:02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM
Ethernet Controller (rev 03)        Subsystem: Acer Incorporated [ALI]:
Unknown device 0019        Flags: bus master, medium devsel, latency 66,
IRQ 11        Memory at e8100000 (32-bit, non-prefetchable)
        I/O ports at 4000 [size=64]
        Capabilities: [dc] Power Management version 2

0000:07:00.0 Multimedia audio controller: Xilinx Corporation RME
Hammerfall DSP (rev 0a)        Flags: bus master, stepping, medium
devsel, latency 255, IRQ 11        Memory at 21000000 (32-bit,
non-prefetchable)

> 3) try pcmcia-cs (most likely wont work as Tim already tried that and
> it made no difference on his laptop, also the package wasnt updated
> since Dec.)
actually i tried this with kernel 2.4 ... but it was in the first days
of my problems, when i had no idea what's the difference between cardbus
and pcmcia :-)
- pcmcia-cs doesn't support kernel 2.6 
- i'm not even sure if the pcmcia-cs package contains a cardbus bridge
  driver ... as i said i had no idea, what i was doing, when i tried
  it...

> 4) try playback with an external Word Clock source
have you been able to try this? i'd be interested in your results ...
but from my understanding this is unlikely to be the reason, but if you
are successful using an external word clock source, it might give us a
hint, where the problem might be...

> 5) provide downloadable examples of the distorted sounds
i'm currently working on some sound samples ... i'm not able to provide
the samples on the web, but if you or someone else might be able to
offer some webspace, where i could upload the files, i'd appreciate your
help...

cheers...

 Tim                          mailto:TimBlechmann-Mmb7MZpHnFY@public.gmane.org
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac
