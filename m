From: Alexander Nyberg <alexn@telia.com>
Subject: Badness in remove_proc_entry called from snd_via82xx_remove
	(2.6.4-mm)
Date: Thu, 11 Mar 2004 18:38:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1079026696.810.26.camel@boxen>
References: <20040204203426.GA1841@miriel.finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040204203426.GA1841@miriel.finwe.eu.org>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This happens at shutdown when alsa is to be closed with kernel 2.6.4-mm.
I'm running debian sid, snd_via82xx compiled as module.
Happens also on 2.6.4-rc2-mm1, I can try on more kernels as well if it
is not a clear case.


I slapped a printk on these just before the badness:
de->subdir->name = "id", de->name = "card0"

Badness in remove_proc_entry at fs/proc/generic.c:667
Call Trace:
[<c016fb5a>] remove_proc_entry+0x13a/0x1a0
[<e083a6fb>] snd_info_unregister+0x3b/0x70 [snd]
[<e083a231>] snd_info_card_free+0x31/0x60 [snd]
[<e0838b67>] snd_card_free+0xd7/0x250 [snd]
[<c015bfde>] destroy_inode+0x4e/0x50
[<c015d0b5>] iput+0x55/0x80
[<e08709c9>] snd_via82xx_remove+0x19/0x30 [snd_via82xx]
[<c01a074b>] pci_device_remove+0x3b/0x40
[<c01c4854>] device_release_driver+0x64/0x70
[<c01c4880>] driver_detach+0x20/0x30
[<c01c4aad>] bus_remove_driver+0x3d/0x80
[<c01c4ec3>] driver_unregister+0x13/0x28
[<c01a08e2>] pci_unregister_driver+0x12/0x20
[<e08709ef>] alsa_card_via82xx_exit+0xf/0x13 [snd_via82xx]
[<c012b5d1>] sys_delete_module+0x131/0x170
[<c013e264>] sys_munmap+0x44/0x70
[<c0249c4f>] syscall_call+0x7/0xb



00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 50)
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
