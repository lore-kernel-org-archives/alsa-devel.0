From: Andrew Pimlott <andrew@pimlott.net>
Subject: snd-intel8x0 produces no sound starting in 2.6.5
Date: Wed, 26 May 2004 00:46:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040526044627.GF3183@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[I sent a more complete version of this mail several days ago before I
was subscribed, but it seems to have disappeared and I neglected to keep
a copy.  If anyone can dig out that message and post it, I'd be
grateful.]

I have an "Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)"
in my Dell Inspiron 5150 that worked fine with the snd-intel8x0 driver
in 2.6.4, but produces no sound in 2.6.[56].  The device is detected and
sound apps (eg alsaplayer) don't notice any problem, there is just no
sound.  The mixer levels (checked with alsamixer) seem correct in both
cases.  The kernels are configured the same and I've tried both modular
and built-in drivers, with no change (both ways work on 2.6.4 and fail
on 2.6.6).

Looking at the boot messages, the first different that popped out was
that 2.6.4 used irq 11 but 2.6.6 used irq 7.  However, when I booted
2.6.6 with pci=noacpi, I got irq 7 again, and still no sound.  I did
some additional experiments, such as booting 2.6.4 with pci=noapici
(worked), that convinced me that the irq was a red herring.

Here are the differences between the kernel messages of 2.6.4 and 2.6.6
(without pci=noacpi) that look remotely relevant:

     ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
     ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
    -ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7)
    +ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
     ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
     ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
     ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

     ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
     ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
     ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
     ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
    -ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
    +ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
     ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
     PCI: Using ACPI for IRQ routing

    -  #0: Intel 82801DB-ICH4 at 0xf4fff800, irq 11
    +  #0: Intel 82801DB-ICH4 at 0xf4fff800, irq 7

I have tried every permutation I could think of, so I don't believe I am
doing something stupid here.  Any suggestions are appreciated.  I tried
looking at the differences in the code, but they are substantial and
obviously depend on larger infrastructure changes.  Also, I looked at
the driver in alsa 1.0.4, but it seems to be the same as in 2.6.6.

Andrew


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
