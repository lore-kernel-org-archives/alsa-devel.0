From: William <walsac3@orthoset.com>
Subject: Re: Bad IRQs from using pcm in alsa-driver-1.0.7
Date: Tue, 23 Nov 2004 13:18:43 GMT
Message-ID: <200411231318.NAA09073@orthoset.com>
References: <s5hpt25vlcw.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt25vlcw.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> William wrote:
>> 
>> Using ALSA PCM always disables the IRQ for my mouse (USB Logitech wheelmouse)
> 
> Which kernel version?  It smells like a general IRQ routing
> problem.  What happens when you play with acpi boot option?

The problem happens with all kernels from 2.6.2 to 2.6.8.1.  I've configured
preemption, CONFIG_PCI_GOBIOS, and CONFIG_ACPI_* (CONFIG_APM is off).

Thanks for your suggestion.  This is what happened when I tried the
acpi boot option to disable IRQ routing for PCI:

1. Reboot with acpi=noirq

Many kernel warnings appeared:

Nov 22 18:38:08 kernel: PCI: IRQ 0 for device 0000:00:10.3 doesn't match PIRQ mask - try pci=usepirqmask

Booting was also very slow and the X server gave many "internal" error messages.

2. Reboot with acpi=noirq pci=usepirqmask

Nov 22 18:42:37 kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
Nov 22 18:42:37 kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *10, disabled.

First time the mouse was used, new messages for PCI IRQ routing:

Nov 22 18:43:43 kernel: PCI: Found IRQ 11 for device 0000:00:11.5
Nov 22 18:43:43 kernel: PCI: Sharing IRQ 11 with 0000:00:0b.1
Nov 22 18:43:43 kernel: PCI: Sharing IRQ 11 with 0000:00:10.2
Nov 22 18:43:43 kernel: PCI: Sharing IRQ 11 with 0000:00:11.6

First time ALSA PCM was used:

Nov 22 18:48:42 kernel: rtc: lost some interrupts at 1024Hz.

Many more of these messages during every ALSA PCM playback:

Nov 22 19:10:17 last message repeated 3392 times

So now the mouse can be used at the same time as ALSA PCM
but the new problem is many RTC interrupts are being lost.
Is there a fix?

William


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
