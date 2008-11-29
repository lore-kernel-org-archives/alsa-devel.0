From: nokos@gmx.net
Subject: Re: [BUG] Long Resume with Riptide
Date: Sat, 29 Nov 2008 13:28:35 +0100
Message-ID: <1227961715.19181.20.camel@earth.gruber.myown>
References: <20081120140233.GB25908@alice>  <20081128064841.GA17330@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42]) by alsa0.perex.cz (Postfix) with ESMTP id 33084243B3
	for <alsa-devel@alsa-project.org>; Sat, 29 Nov 2008 13:28:42 +0100 (CET)
In-Reply-To: <20081128064841.GA17330@alice>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

can you enable the sound debug options:
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERSOSE=y
(be warned it generates lots of log entries)

and search for "send cmd ...failed" you will also find some "send cmd"
lines containing timing statistics.

Then try to reduce the timeoutvalue in sound/pci/riptide/riptide.c
CMDIF_TIMEOUT to something near mintime/maxtime (it defaults to 5 sec
[500000*10us])

If the error is hard to reproduce you might want to try this:
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -945,8 +945,8 @@ static int sendcmd(struct cmdif *cif, u32 flags, u32 cmd, u32 parm,
       errout:
        cif->errcnt++;
        spin_unlock_irqrestore(&cif->lock, irqflags);
-       snd_printdd
-           ("send cmd %d hw: 0x%x flag: 0x%x cmd: 0x%x parm: 0x%x ret: 0x%x 0x%x CMDE: %d DATF: %d failed %d\n",
+       snd_printk(KERN_ERR
+           "send cmd %d hw: 0x%x flag: 0x%x cmd: 0x%x parm: 0x%x ret: 0x%x 0x%x CMDE: %d DATF: %d failed %d\n",
             cif->cmdcnt, (int)((void *)&(cmdport->stat) - (void *)hwport),
             flags, cmd, parm, ret ? ret->retlongs[0] : 0,
             ret ? ret->retlongs[1] : 0, IS_CMDE(cmdport), IS_DATF(cmdport),

and disable the SND_DEBUG stuff (less log spam but you see which commands are failing and together with the reduced CMDIF_TIMEOUT 
you also see which commands are stalling)

Peter



Am Freitag, den 28.11.2008, 07:48 +0100 schrieb Eric Sesterhenn:
> Hi,
> 
> Sometimes during bootup on this box i get a warning that resume took too long
> (I have suspend testing enabled). As far as I can see the riptide driver
> takes ~5 seconds to resume. Kernel is 2.6.28-rc5
>  
> [   23.857632] PM: test RTC wakeup from 'standby' suspend
> [   23.859062] PM: Syncing filesystems ... done.
> [   23.866226] Freezing user space processes ... (elapsed 0.00 seconds) done.
> [   23.866671] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> [   23.867527] Suspending console(s) (use no_console_suspend to debug)
> [   24.317553] sd 2:0:0:0: [sda] Synchronizing SCSI cache
> [   24.318470] sd 2:0:0:0: [sda] Stopping disk
> [   24.431264] serial 00:08: disabled
> [   24.432568] RIPTIDE 0000:00:12.0: PCI INT A disabled
> [   24.465203] aic7xxx 0000:00:0c.0: PCI INT A disabled
> [   24.480466] uhci_hcd 0000:00:07.2: PCI INT D disabled
> [   24.481411] PM: suspend devices took 0.616 seconds
> [   24.481663] ACPI: Preparing to enter system sleep state S1
> [   24.490826] ACPI: Waking up from system sleep state S1
> [   24.493282] ACPI Warning (nspredef-0852): \_WAK: Return type mismatch - found Integer, expected Package [20080926]
> [   24.494394] uhci_hcd 0000:00:07.2: PCI INT D -> Link[LNKD] -> GSI 9 (level, low) -> IRQ 9
> [   24.512439] aic7xxx 0000:00:0c.0: enabling device (0116 -> 0117)
> [   24.512471] aic7xxx 0000:00:0c.0: PCI INT A -> Link[LNKB] -> GSI 5 (level, low) -> IRQ 5
> [   24.532081] eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> [   24.548248] RIPTIDE 0000:00:12.0: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
> [   29.954494] matroxfb 0000:01:00.0: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
> [   29.957755] serial 00:08: activated
> [   29.962016] sd 2:0:0:0: [sda] Starting disk
> [   29.968733] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
> [   29.968747] ata1.00: ACPI cmd ef/03:22:00:00:00:a0 filtered out
> [   29.969379] ata2.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
> [   29.969392] ata2.00: ACPI cmd ef/03:42:00:00:00:a0 filtered out
> [   29.976984] ata1.00: configured for UDMA/33
> [   29.992727] ata2.00: configured for UDMA/33
> [   30.016716] ata2.00: configured for UDMA/33
> [   30.016731] ata2: EH complete
> [   30.360069] CPA self-test:
> [   30.365709]  4k 65533 large 0 gb 0 x 65533[c0000000-cfffc000] miss 0
> [   30.380333]  4k 65533 large 0 gb 0 x 65533[c0000000-cfffc000] miss 0
> [   30.392794]  4k 65533 large 0 gb 0 x 65533[c0000000-cfffc000] miss 0
> [   30.392803] ok.
> [   33.253318] sd 2:0:0:0: [sda] 40031712 512-byte hardware sectors: (20.4 GB/19.0 GiB)
> [   33.253543] sd 2:0:0:0: [sda] Write Protect is off
> [   33.253842] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   33.254073] sda: detected capacity change from 0 to 20496236544
> [   33.254398] sd 2:0:0:0: [sda] 40031712 512-byte hardware sectors: (20.4 GB/19.0 GiB)
> [   33.254563] sd 2:0:0:0: [sda] Write Protect is off
> [   33.254858] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   33.254920] sda: detected capacity change from 0 to 20496236544
> [   33.298085] PM: resume devices took 8.804 seconds
> [   33.298105] ------------[ cut here ]------------
> [   33.298114] WARNING: at kernel/power/main.c:177 suspend_test_finish+0x85/0x90()
> [   33.298124] Component: resume devices
> [   33.298130] Modules linked in:
> [   33.298142] Pid: 1, comm: swapper Not tainted 2.6.28-rc5 #60
> [   33.298151] Call Trace:
> [   33.298176]  [<c012a235>] warn_slowpath+0x65/0x90
> [   33.298195]  [<c014d1ef>] ? trace_hardirqs_off_caller+0x1f/0xc0
> [   33.298208]  [<c014d29b>] ? trace_hardirqs_off+0xb/0x10
> [   33.298232]  [<c05c57ff>] ? _spin_unlock_irqrestore+0x4f/0x60
> [   33.298246]  [<c05c5832>] ? _spin_unlock+0x22/0x30
> [   33.298263]  [<c014f475>] ? trace_hardirqs_on_caller+0x115/0x160
> [   33.298276]  [<c014f4cb>] ? trace_hardirqs_on+0xb/0x10
> [   33.298289]  [<c05c2f0a>] ? printk+0x1d/0x23
> [   33.298301]  [<c015ab55>] suspend_test_finish+0x85/0x90
> [   33.298314]  [<c015ac7b>] suspend_devices_and_enter+0xfb/0x1f0
> [   33.298327]  [<c015af64>] enter_state+0x1c4/0x280
> [   33.298338]  [<c015b0fe>] pm_suspend+0x1e/0x30
> [   33.298352]  [<c08d21f9>] test_suspend+0x167/0x19f
> [   33.298366]  [<c08d2092>] ? test_suspend+0x0/0x19f
> [   33.298379]  [<c010111b>] do_one_initcall+0x2b/0x180
> [   33.298391]  [<c014f4cb>] ? trace_hardirqs_on+0xb/0x10
> [   33.298412]  [<c01ec557>] ? proc_register+0x117/0x1f0
> [   33.298426]  [<c05c5832>] ? _spin_unlock+0x22/0x30
> [   33.298438]  [<c01ec557>] ? proc_register+0x117/0x1f0
> [   33.298450]  [<c01ec111>] ? __proc_create+0xf1/0x110
> [   33.298463]  [<c01ec739>] ? create_proc_entry+0x59/0xa0
> [   33.298478]  [<c016d8b7>] ? register_irq_proc+0x87/0xa0
> [   33.298491]  [<c016d909>] ? init_irq_proc+0x39/0x50
> [   33.298510]  [<c08ba4f5>] kernel_init+0x83/0xdf
> [   33.298521]  [<c08ba472>] ? kernel_init+0x0/0xdf
> [   33.298538]  [<c010440b>] kernel_thread_helper+0x7/0x10
> [   33.298547] ---[ end trace 9997c7f634daff1f ]---
> 
> On other bootups I see the following before the freezer tests,
> since in both cases the device gets initialized i guess this
> is the same issue.
>  
> [   23.522685] RIPTIDE 0000:00:12.0: enabling device (0104 -> 0105)
> [   23.524005] RIPTIDE 0000:00:12.0: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
> [   23.664021] RCU detected CPU 0 stall (t=4294899535/1358 jiffies)
> [   23.664021] Pid: 1, comm: swapper Not tainted 2.6.28-rc5 #60
> [   23.664021] Call Trace:
> [   23.664021]  [<c05c2f0a>] ? printk+0x1d/0x23
> [   23.664021]  [<c016e26d>] __rcu_pending+0x11d/0x1c0
> [   23.664021]  [<c016e327>] rcu_pending+0x17/0x40
> [   23.664021]  [<c0133e2f>] update_process_times+0x2f/0x60
> [   23.664021]  [<c014b0ea>] tick_sched_timer+0x5a/0xd0
> [   23.664021]  [<c014b090>] ? tick_sched_timer+0x0/0xd0
> [   23.664021]  [<c014b090>] ? tick_sched_timer+0x0/0xd0
> [   23.664021]  [<c014257c>] __run_hrtimer+0xac/0xc0
> [   23.664021]  [<c014b090>] ? tick_sched_timer+0x0/0xd0
> [   23.664021]  [<c0142dff>] hrtimer_interrupt+0x12f/0x1a0
> [   23.664021]  [<c0106770>] timer_interrupt+0x40/0x50
> [   23.664021]  [<c016b4c1>] handle_IRQ_event+0x31/0x60
> [   23.664021]  [<c016d18b>] handle_level_irq+0x6b/0xe0
> [   23.664021]  [<c016d120>] ? handle_level_irq+0x0/0xe0
> [   23.664021]  <IRQ>  [<c01042bd>] ? common_interrupt+0x21/0x30
> [   23.664021]  [<c01042c4>] ? common_interrupt+0x28/0x30
> [   23.664021]  [<c014007b>] ? posix_cpu_timer_schedule+0xcb/0x130
> [   23.664021]  [<c05c57ec>] ? _spin_unlock_irqrestore+0x3c/0x60
> [   23.664021]  [<c04f91c7>] ? sendcmd+0x217/0x240
> [   23.664021]  [<c04f9841>] ? riptide_reset+0x371/0x6e0
> [   23.664021]  [<c014f475>] ? trace_hardirqs_on_caller+0x115/0x160
> [   23.664021]  [<c04f9bdd>] ? snd_riptide_initialize+0x2d/0xc0
> [   23.664021]  [<c05c15af>] ? snd_card_riptide_probe+0x17f/0x580
> [   23.664021]  [<c010442a>] ? ftrace_call+0x5/0x8
> [   23.664021]  [<c02c2d29>] ? pci_match_id+0x9/0xa0
> [   23.664021]  [<c02c2f5d>] ? pci_match_device+0xbd/0xd0
> [   23.664021]  [<c02c375e>] ? pci_device_probe+0x5e/0x80
> [   23.664021]  [<c0383ec1>] ? driver_probe_device+0xa1/0x2f0
> [   23.664021]  [<c014f4cb>] ? trace_hardirqs_on+0xb/0x10
> [   23.664021]  [<c03841a1>] ? __driver_attach+0x91/0xa0
> [   23.664021]  [<c03835eb>] ? bus_for_each_dev+0x5b/0x80
> [   23.664021]  [<c02c36a0>] ? pci_device_remove+0x0/0x40
> [   23.664021]  [<c0383c3e>] ? driver_attach+0x1e/0x20
> [   23.664021]  [<c0384110>] ? __driver_attach+0x0/0xa0
> [   23.664021]  [<c0382e47>] ? bus_add_driver+0x1c7/0x290
> [   23.664021]  [<c02c36a0>] ? pci_device_remove+0x0/0x40
> [   23.664021]  [<c0384381>] ? driver_register+0x71/0x150
> [   23.664021]  [<c02c39c3>] ? __pci_register_driver+0x63/0xb0
> [   23.664021]  [<c08ea9eb>] ? alsa_card_riptide_init+0x0/0x1f
> [   23.664021]  [<c08ea9ff>] ? alsa_card_riptide_init+0x14/0x1f
> [   23.664021]  [<c010111b>] ? do_one_initcall+0x2b/0x180
> [   23.664021]  [<c014f4cb>] ? trace_hardirqs_on+0xb/0x10
> [   23.664021]  [<c01ec557>] ? proc_register+0x117/0x1f0
> [   23.664021]  [<c05c5832>] ? _spin_unlock+0x22/0x30
> [   23.664021]  [<c01ec557>] ? proc_register+0x117/0x1f0
> [   23.664021]  [<c01ec111>] ? __proc_create+0xf1/0x110
> [   23.664021]  [<c01ec739>] ? create_proc_entry+0x59/0xa0
> [   23.664021]  [<c016d8b7>] ? register_irq_proc+0x87/0xa0
> [   23.664021]  [<c016d909>] ? init_irq_proc+0x39/0x50
> [   23.664021]  [<c08ba4f5>] ? kernel_init+0x83/0xdf
> [   23.664021]  [<c08ba472>] ? kernel_init+0x0/0xdf
> [   23.664021]  [<c010440b>] ? kernel_thread_helper+0x7/0x10
> 
> If you need more information or need me to test patches, just let me know.
>  
>  Greetings, Eric
