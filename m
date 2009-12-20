From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: [2.6.33-rc1] [SOUND] HDA: high cpu usage, noise
Date: Sun, 20 Dec 2009 18:27:45 +0100
Message-ID: <8db1092f0912200927y7cdab36ftd1f73d56cd89763f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755729AbZLTR1t@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.de, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

Hi

Affected kernel: 2.6.33-rc1
Last known good: 2.6.32

Hadware:
/proc/asound/pcm
00-00: AD198x Analog : AD198x Analog : playback 1 : capture 1
00-06: Si3054 Modem : Si3054 Modem : playback 1 : capture 1

I notice high cpu load during idle/playing sounds. From "ps aux":

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      1119 26.4  0.0      0     0 ?        R    18:09   1:47 [hd-audio0]

Also I hear noise, during (probably) disk I/O operations. Any suggestions?

cat /proc/interrupts
           CPU0       CPU1
  0:      58385          0   IO-APIC-edge      timer
  1:         77        201   IO-APIC-edge      i8042
  8:          1          0   IO-APIC-edge      rtc0
  9:         67        117   IO-APIC-fasteoi   acpi
 12:        157      14303   IO-APIC-edge      i8042
 14:       1625          0   IO-APIC-edge      ata_piix
 15:          0          0   IO-APIC-edge      ata_piix
 16:       1115          0   IO-APIC-fasteoi   i915@pci:0000:00:02.0, eth0
 18:          0          0   IO-APIC-fasteoi   yenta, uhci_hcd:usb4
 19:          1          0   IO-APIC-fasteoi   ohci1394, uhci_hcd:usb5
 20:        146          2   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
 21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
 27:       4013      10861   PCI-MSI-edge      ahci
 28:       3452          0   PCI-MSI-edge      iwl3945
 29:    1556997          0   PCI-MSI-edge      HDA Intel
NMI:          0          0   Non-maskable interrupts
LOC:      16143      35244   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
PND:          0          0   Performance pending work
RES:      27154     126864   Rescheduling interrupts
CAL:         59         34   Function call interrupts
TLB:        899        748   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          1          1   Machine check polls
ERR:          0
MIS:          0

Config, dmesg and lspci:
http://unixy.pl/maciek/download/kernel/2.6.33-rc1/gumis/

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
