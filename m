From: noreply@alsa-project.org
Subject: [ALSA - driver 0000128]: modprobe -r snd-intel8x0 crash on Intel 865PERL
Date: Fri, 16 Jul 2004 14:39:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123925.DCE512C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3E1CE244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:39:26 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000128
======================================================================
Reported By:                tfolks
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     128
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 1
Kernel Version:             2.6.3-2.1.242
======================================================================
Date Submitted:             03-10-2004 07:14 CET
Last Modified:              07-16-2004 14:39 CEST
======================================================================
Summary:                    modprobe -r snd-intel8x0 crash on Intel 865PERL
Description: 
Both the driver included in kernel 2.6.3 and in alsa-driver 1.0.3 crash on
modprobe -r snd-intel8x0 with:

kernel: kernel BUG at fs/proc/generic.c:664!
kernel: invalid operand: 0000 [https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001]
kernel: PREEMPT SMP 
kernel: CPU:    1
kernel: EIP:    0060:[<c01863f9>]    Not tainted
kernel: EFLAGS: 00010286   (2.6.3-2.1.242custom) 
kernel: EIP is at remove_proc_entry+0xd9/0x110
kernel: eax: ce74c300   ebx: e73c5a00   ecx: 00000000   edx: f4dd1780
kernel: esi: 00000005   edi: da31d9b0   ebp: e97f2000   esp: e97f3eac
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process modprobe (pid: 4721, threadinfo=e97f2000 task=f1684d20)
kernel: Stack: 00000004 da31d9b0 c01863c6 0000003c da31d980 e73c5a48
faea5df0 d8213d80 
kernel:        00000000 fae9d97c d8070600 d8070600 fae9d56e e97f2000
fae9be26 00000000 
kernel:        c015ab33 da2bfc80 00000000 da2bfc80 c01723a6 00000292
da2bfc80 dcf13780 
kernel: Call Trace:
kernel:  [<c01863c6>] remove_proc_entry+0xa6/0x110
kernel:  [<fae9d97c>] snd_info_unregister+0x32/0x5c [snd]
kernel:  [<fae9d56e>] snd_info_card_free+0x20/0x42 [snd]
kernel:  [<fae9be26>] snd_card_free+0x106/0x2f5 [snd]
kernel:  [<c015ab33>] invalidate_inode_buffers+0xa/0x7f
kernel:  [<c01723a6>] wake_up_inode+0x6/0x27
kernel:  [<faeb1c0c>] snd_intel8x0_remove+0x13/0x1c [snd_intel8x0]
kernel:  [<c01c97e0>] pci_device_remove+0x28/0x2a
kernel:  [<c0203d8a>] device_release_driver+0x56/0x58
kernel:  [<c0203da2>] driver_detach+0x16/0x21
kernel:  [<c0203f90>] bus_remove_driver+0x39/0x6a
kernel:  [<c0204296>] driver_unregister+0x8/0x19
kernel:  [<c01c9957>] pci_unregister_driver+0xb/0x13
kernel:  [<faeb1d9a>] alsa_card_intel8x0_exit+0xa/0x1f [snd_intel8x0]
kernel:  [<c01383eb>] sys_delete_module+0x110/0x134
kernel:  [<c014ca00>] unmap_vma+0x19/0x8a
kernel:  [<c014ceff>] do_munmap+0x139/0x190
kernel:  [<c014cf97>] sys_munmap+0x41/0x65
kernel:  [<c02abaeb>] syscall_call+0x7/0xb
kernel: 
kernel: Code: 0f 0b 98 02 ef 03 2c c0 eb b5 8b 44 24 10 66 83 68 0a 01 eb


lspci -vv info:

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)
        Subsystem: Intel Corp.: Unknown device a000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 2: Memory at ffaff800 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at ffaff400 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
======================================================================

----------------------------------------------------------------------
 tiwai - 03-12-2004 13:04 CET 
----------------------------------------------------------------------
fixed on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-10-04 07:14 tfolks         New Bug                                      
03-10-04 07:14 tfolks         Distribution              => Fedora Core 1   
03-10-04 07:14 tfolks         Kernel Version            => 2.6.3-2.1.242   
03-12-04 13:04 tiwai          Bugnote Added: 0000575                       
03-12-04 13:04 tiwai          Assigned To               => tiwai           
03-12-04 13:04 tiwai          Resolution               open => fixed       
03-12-04 13:04 tiwai          Status                   new => resolved     
07-16-04 14:39 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
