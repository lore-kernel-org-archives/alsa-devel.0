From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: ich10 usb_host vs snd_usb_audio Hercules - irq
	broadcast.
Date: Thu, 23 Jul 2009 20:00:13 +0200
Message-ID: <4A68A52D.8050409@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 903D2103A1C
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 20:00:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo,

i found some time to investigate the issue with my "Hercules USB 5.1 
Cannel Audio Adapter". The issue is pretty tricky and depend to host 
hardware, in my situation this is Intel DG45ID board.

Symptoms are: if i use this sound adapter after some time i'll get:
irq 16: nobody cared ... Disabling IRQ #16. After closer look i found, 
it depend on usb port. And if i use one "wrong" usb port on IRQ 18 it 
will broadcast interrupts to two IRQs 18 and 16, until IRQ 16 will die.

The problem is... this happens only with this sound card. So this is not 
easy to locate bug. And it's working fine on Win Vista and on Mac OS on 
same hardware.. so it should be software issue.




Here is a copy of my post on 
http://bugzilla.kernel.org/show_bug.cgi?id=13816


If use any usb connector located on irq 18 for usb soundcard it will 
cause "irq
16: nobody cared", so every thing connected (usb mouse, keyboard ) to irq 16
will be broken. If i connect devices with less traffic (like mouse or 
keyboard)
to irq 18, and usb soundcard to irq 16 or 21 ... every thing will be fine.
irqpoll do not do any difference.

             / irq16|uhci-3 (mouse, keyboard)
irq18|ehci-1- irq21|uhci-4 (sound work fine normal)
             \ irq18|uhci-5 (sound will brake uhci-3)

             / irq23|uhci-6 (not used)
irq23|ehci-2- irq19|uhci-7 (not used)
             \ irq18|uhci-8 (not used)



=========================================================================
[  315.056793] irq 16: nobody cared (try booting with the "irqpoll" option)
[  315.056799] Pid: 0, comm: swapper Not tainted
2.6.31-rc3-00216-gea11951-dirty #98
[  315.056802] Call Trace:
[  315.056804]  <IRQ>  [<ffffffff8109d666>] __report_bad_irq+0x26/0xa0
[  315.056814]  [<ffffffff8109d86c>] note_interrupt+0x18c/0x1d0
[  315.056819]  [<ffffffff8106a373>] ? sched_clock_tick+0x73/0xb0
[  315.056823]  [<ffffffff8109deb5>] handle_fasteoi_irq+0xb5/0xe0
[  315.056827]  [<ffffffff8100dffd>] handle_irq+0x1d/0x30
[  315.056830]  [<ffffffff8100d527>] do_IRQ+0x67/0xe0
[  315.056834]  [<ffffffff8100c013>] ret_from_intr+0x0/0xa
[  315.056837]  <EOI>  [<ffffffff812822e1>] ? acpi_idle_enter_bm+0x256/0x288
[  315.056844]  [<ffffffff812822de>] ? acpi_idle_enter_bm+0x253/0x288
[  315.056849]  [<ffffffff813a480b>] ? cpuidle_idle_call+0x9b/0xf0
[  315.056853]  [<ffffffff8100a59c>] ? cpu_idle+0xac/0x100
[  315.056858]  [<ffffffff81496825>] ? rest_init+0x65/0x70
[  315.056862]  [<ffffffff8172ed35>] ? start_kernel+0x3ba/0x3c5
[  315.056866]  [<ffffffff8172e315>] ? x86_64_start_reservations+0x125/0x129
[  315.056870]  [<ffffffff8172e3fd>] ? x86_64_start_kernel+0xe4/0xeb
[  315.056872] handlers:
[  315.056874] [<ffffffff8134bdb0>] (usb_hcd_irq+0x0/0x70)
[  315.056878] Disabling IRQ #16
==================================================================



I did smole script to test haw interrupts are used:

$for i in $(seq 1 1000); do cat /proc/interrupts >> test; sleep 10s; done
$grep usb[3,4,5] test

there is no connections on usb3. on usb4 are keyboard an mouse. on usb5 
is the
soundcard.

======================================================================
-------after boot. there is too match interrupts on 16,
-------there is nothing connected.
  16:       4276       4520   IO-APIC-fasteoi   uhci_hcd:usb3
  18:       2732       2598   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:        856        816   IO-APIC-fasteoi   uhci_hcd:usb4

-------here i begin to play to usb sound card on usb5.
  16:      12162      10987   IO-APIC-fasteoi   uhci_hcd:usb3
  18:       8070       7134   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:        887        875   IO-APIC-fasteoi   uhci_hcd:usb4

  16:      20097      17784   IO-APIC-fasteoi   uhci_hcd:usb3
  18:      13539      11674   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:       1003        958   IO-APIC-fasteoi   uhci_hcd:usb4

------- count of interrupts on irq 16 is almost double of irq18
  16:      28083      24881   IO-APIC-fasteoi   uhci_hcd:usb3
  18:      19091      16130   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:       1005        968   IO-APIC-fasteoi   uhci_hcd:usb4

......
......

  16:      94758      81082   IO-APIC-fasteoi   uhci_hcd:usb3
  18:      61430      53863   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:       1389       1539   IO-APIC-fasteoi   uhci_hcd:usb4

  16:     103141      87919   IO-APIC-fasteoi   uhci_hcd:usb3
  18:      66678      58625   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:       1389       1539   IO-APIC-fasteoi   uhci_hcd:usb4

------- irq 16: nobody cared, Disabling IRQ #16.
  16:     107840      92161   IO-APIC-fasteoi   uhci_hcd:usb3
  18:      71854      63458   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:       1389       1539   IO-APIC-fasteoi   uhci_hcd:usb4

  16:     107840      92161   IO-APIC-fasteoi   uhci_hcd:usb3
  18:      76498      68823   IO-APIC-fasteoi   ehci_hcd:usb1, 
uhci_hcd:usb5,
uhci_hcd:usb8
  21:       1389       1539   IO-APIC-fasteoi   uhci_hcd:usb4
