From: Tim Blechmann <TimBlechmann-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: snd-hdsp+cardbus=distortion -- the
	sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is	the
	cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 20:53:53 +0200
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040330205353.08cd0ac8@laptop>
References: <20040329235823.04bacef4@laptop>
	<20040330055204.UUGL2042.smtp1.fuse.net@64BitBadass>
	<20040330090053.A3956@flint.arm.linux.org.uk>
	<20040330141038.5f98d8ae@laptop>
	<20040330142008.A11813@flint.arm.linux.org.uk>
	<20040330164528.239c32c1@laptop>
	<20040330170637.B11813@flint.arm.linux.org.uk>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <20040330170637.B11813-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: Russell King <rmk+pcmcia-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
List-Id: alsa-devel@alsa-project.org

hi russel

> The majority of PCMCIA is the same between the two kernels.  There
> have been some cleanups and changes to the way card events (insertions
> and removals) occur, and some setup changes to the cardbus bridge to
> turn on some extra features.
> 
> However, if you're saying that 2.4 and 2.6 behave the same way, then
> logically it isn't something that any of these changes have caused.

i tried to use the pcmcia-cs driver again (2.4.24-ck1 ... they didn't
work with the hdsp, either (afaik, the pcmcia-cs driver never worked
with the hdsp, but i'm not sure about that)
the dmesg output was:

PCI: Found IRQ 5 for device 02:00.0
PCI: Sharing IRQ 5 with 01:00.0
PCI: Found IRQ 11 for device 02:00.1
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
  O2Micro OZ6933 rev 01 PCI-to-CardBus at slot 02:00, mem 0x20000000
    host opts [0]: [pci/way] [pci irq 5] [lat 168/176] [bus 3/6]
    host opts [1]: [pci/way] [pci irq 11] [lat 168/176] [bus 7/10]
    ISA irqs (default) = 3,4,7,9,10 PCI status changes
cs: cb_alloc(bus 7): vendor 0x10ee, device 0x3fc5
cs: cb_free(bus 7)
cs: cb_alloc(bus 7): vendor 0x10ee, device 0x3fc5
PCI: No IRQ known for interrupt pin A of device .
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:5031: unable to grab memory
region 0x0-0x1bff 
RME Hammerfall-DSP: no cards found

i have no idea of the differences between the cardbus drivers of the
kernel and of the pcmcia-cs project ...
anyway, the hdsp is working on a certain area of memory, that the
pcmcia-cs driver can't grab the kernel driver can ... 
i disabled acpi and apic and used pci=biosirq as kernel flag

maybe this can give you a hint ... anyway, i hope thomas can comment on
that...

cheers and thanks for your help...

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
