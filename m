From: Chris Meadors <twrchris@hereintown.net>
Subject: Re: 2.6.0-test1: ALSA problem
Date: 15 Jul 2003 10:57:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1058281075.8444.7.camel@clubneon.priv.hereintown.net>
References: <200307151048.17586.shahamit@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200307151048.17586.shahamit@gmx.net>
To: Amit Shah <shahamit@gmx.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-07-15 at 01:18, Amit Shah wrote:
> I don't know what the problem is exactly, since alsa shows it found one 
> card... I'm using debian woody with alsa-base installed. Even if alsa shows 
> one card detected, it doesn't play. (It doesn't recognize /dev/dsp?)
> 
> 
> Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 
> 2003 UTC).
> kobject_register failed for Ensoniq AudioPCI (-17)
> Call Trace:
>  [<c01f6b8a>] kobject_register+0x32/0x48
>  [<c0248a1b>] bus_add_driver+0x3f/0xa0
>  [<c0248e0a>] driver_register+0x36/0x3c
>  [<c01fb236>] pci_register_driver+0x6a/0x90
>  [<c04117ba>] alsa_card_ens137x_init+0xe/0x3c
>  [<c03f86f5>] do_initcalls+0x39/0x94
>  [<c03f876c>] do_basic_setup+0x1c/0x20
>  [<c010509b>] init+0x33/0x188
>  [<c0105068>] init+0x0/0x188
>  [<c0107145>] kernel_thread_helper+0x5/0xc
> 
> ALSA device list:
>   #0: Intel 82801BA-ICH2 at 0xe800, irq 17

I see exactly the same thing with my Sound Blaster 16 PCI.

Output of lspci:

02:06.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Flags: bus master, slow devsel, latency 96, IRQ 18
        I/O ports at 3400 [size=64]
        Capabilities: [dc] Power Management version 1

I'm also CCing alsa-devel, but I'm not on the list, hopefully a
moderator will pick this up though.

-- 
Chris
