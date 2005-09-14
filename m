From: Daniel James <daniel@64studio.com>
Subject: Re: More info on hard lock-ups with MIDI on envy24, x86_64 machine
Date: Wed, 14 Sep 2005 14:34:16 +0100
Message-ID: <200509141434.16323.daniel@64studio.com>
References: <200508111525.07881.daniel@64studio.com> <200509141218.49448.daniel@64studio.com> <s5h64t3et1i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64t3et1i.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> Any change with ACPI boot options like
> pci=noacpi or acpi=off?

Unfortunately it's no better, although I think that the kernel may be 
re-enabling ACPI by itself. Here is the output of /proc/interrupts:

           CPU0       
  0:      89261    IO-APIC-edge  timer
  1:       2003    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          0    IO-APIC-edge  rtc
 12:         97    IO-APIC-edge  i8042
 14:       2477    IO-APIC-edge  ide0
 15:         19    IO-APIC-edge  ide1
137:        674   IO-APIC-level  mga@pci:0000:02:00.0
145:        247   IO-APIC-level  eth0
153:          0   IO-APIC-level  ICE1712
NMI:         77 
LOC:      89235 
ERR:          0
MIS:          0

It could be because this is a dual-processor board with only one CPU 
in it. In /var/log/messages there is this:

Sep 14 14:16:05 64studio kernel: pnp: PnP ACPI: disabled
Sep 14 14:16:05 64studio kernel: PCI: Probing PCI hardware
Sep 14 14:16:05 64studio kernel: PCI: Probing PCI hardware (bus 00)
Sep 14 14:16:05 64studio kernel: PCI: Using IRQ router default 
[1022/746b] at 0000:00:07.3
Sep 14 14:16:05 64studio kernel: PCI->APIC IRQ transform: 0000:00:07.2
[D] -> IRQ 161
Sep 14 14:16:05 64studio kernel: PCI->APIC IRQ transform: 0000:02:00.0
[A] -> IRQ 137
Sep 14 14:16:05 64studio kernel: PCI->APIC IRQ transform: 0000:01:06.0
[A] -> IRQ 153
Sep 14 14:16:05 64studio kernel: PCI->APIC IRQ transform: 0000:01:08.0
[A] -> IRQ 145

> you can try the patch below, too.

Thanks! We'll give that a go.

Daniel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
