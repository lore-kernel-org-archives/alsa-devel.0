From: Tony Vroon <chainsaw@gentoo.org>
Subject: Re: PCMCIA Audigy 2 broken in 2.6.21?
Date: Wed, 04 Jul 2007 10:30:10 +0100
Message-ID: <468B68A2.9060909@gentoo.org>
References: <4681614E.7060705@redhat.com> <46819BDD.7000107@superbug.co.uk>
	<468AD152.30703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 60897103877
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 11:30:32 +0200 (CEST)
In-Reply-To: <468AD152.30703@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Chuck Ebbert wrote:
>> I don't think that anything has changed in the driver between 2.6.20 and
>> 2.6.21 that would affect this. That PCMCIA card can rather easily hang
>> the machine due to it's design, but removing the PCMCIA card during the
>> hang should release the hang state and the PC should continue. There was
>> one case where it would continue to hang, but I believe I fixed that.

In the hope that it helps, the initialization of the Audigy 2 ZS
Notebook still succeeds on my laptop, but it does seem noisier then
usual lately (this writing to ADC failed message):
Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31
09:03:25 2007 UTC).
PCI: Enabling device 0000:05:00.0 (0000 -> 0001)
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:05:00.0 to 64
Audigy2 value: Special config.
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
Writing to ADC failed!
ALSA device list:
  #0: Audigy 2 ZS Notebook [SB0530] (rev.0, serial:0x20011102) at
0x3000, irq 17

>> Please tell me the output of the above two cat commands, and I will then
>> have a better idea of what the problem is.


 0 [Audigy2        ]: Audigy2 - Audigy 2 ZS Notebook [SB0530]
                      Audigy 2 ZS Notebook [SB0530] (rev.0,
serial:0x20011102) at 0x3000, irq 17
 1 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with AD1981B at irq 22

And the interrupt routing:
           CPU0
  0:     412580   IO-APIC-edge      timer
  1:         10   IO-APIC-edge      i8042
  8:          2   IO-APIC-edge      rtc
  9:       2671   IO-APIC-fasteoi   acpi
 12:        149   IO-APIC-edge      i8042
 14:     132742   IO-APIC-edge      libata
 15:      37617   IO-APIC-edge      libata
 17:     205632   IO-APIC-fasteoi   yenta, uhci_hcd:usb2, EMU10K1,
i915@pci:0000:00:02.0
 19:      43447   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb5
 20:        377   IO-APIC-fasteoi   uhci_hcd:usb3, sdhci:slot0
 21:     341744   IO-APIC-fasteoi   uhci_hcd:usb4
 22:          0   IO-APIC-fasteoi   Intel ICH6
 23:      56606   IO-APIC-fasteoi   ipw2200
NMI:          0
LOC:     144023
ERR:          0
MIS:          0

For reference, my CardBus controller:
04:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8d)
        Subsystem: IBM Unknown device 0555
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at a0200000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=04, secondary=05, subordinate=06, sec-latency=176
        Memory window 0: d0000000-d3fff000 (prefetchable)
        Memory window 1: a4000000-a7fff000
        I/O window 0: 00003000-000030ff
        I/O window 1: 00003400-000034ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt-
PostWrite+
        16-bit legacy interface ports at 0001

Audigy itself:
05:00.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
        Subsystem: Creative Labs Unknown device 2001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


This is a ThinkPad X41.

Also, I would like to say that although this card works on an x86
laptop, it has severe difficulties in a PowerBook. In that machine it
can not be hotplugged, and needs to be inserted before powerup, and
removal with the power on results in a kernel oops.

Before I forget, this is on vanilla:
Linux deep-blue 2.6.22-rc5 #1 Sun Jun 17 23:23:55 BST 2007 i686 Intel(R)
Pentium(R) M processor 1.60GHz GenuineIntel GNU/Linux

If I can help by giving you more information, let me know.

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGi2iip5vW4rUFj5oRCPrJAJsHbhI8npfudZHjq5tk9/YBJYC9lACfUkDX
PrHOKZa2vlS8PyczFq8p6Yo=
=epWn
-----END PGP SIGNATURE-----
