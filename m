From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000736]: modprobe snd-azx still gives segmentation fault
Date: Mon, 20 Dec 2004 17:32:57 +0100
Message-ID: <52d493c5e01f917c87d4547858b7c0bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CF68029E
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 17:32:57 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=736> 
======================================================================
Reported By:                fermier
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   736
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Mandrake 10.1 Offficial
Kernel Version:             2.3.8.1-12mdk
======================================================================
Date Submitted:             12-20-2004 07:40 CET
Last Modified:              12-20-2004 17:32 CET
======================================================================
Summary:                    modprobe snd-azx still gives segmentation fault
Description: 
After having read the other errors reported for the CMI9880 sound chip and
that the CVS version has been fixed, I downloaded the latest CVS version
of the alsa-driver.  ./configure and make seem to complete without errors.
 After a make install a modprobe snd-azx still gives a segmentation fault
just like the normal tarred ball install and the previous CVS gave.  After
a modprobe snd-azx gave the segmentation fault a /sbin/lsmod hangs and
becomes a zombie process the same is true for modprobe -r snd or modprobe
-r snd-azx
======================================================================

----------------------------------------------------------------------
 tiwai - 12-20-04 16:34 
----------------------------------------------------------------------
You reported that there is an Oops.  That doesn't help at all.  Please
attach the texts below that (including the stack trace)!

For reading the messages, use dmesg command or look at /var/log/messages.

----------------------------------------------------------------------
 fermier - 12-20-04 17:32 
----------------------------------------------------------------------
Is this what you are looking for?

Dec 20 16:19:21 khazad kernel: Unable to handle kernel paging request at
virtual address f8a31220
Dec 20 16:19:21 khazad kernel:  printing eip:
Dec 20 16:19:21 khazad kernel: c01393f1
Dec 20 16:19:21 khazad kernel: *pde = 37e1e067
Dec 20 16:19:21 khazad kernel: *pte = 00000000
Dec 20 16:19:21 khazad kernel: Oops: 0002
[https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
Dec 20 16:19:21 khazad kernel: SMP 
Dec 20 16:19:21 khazad kernel: Modules linked in: nls_cp850 vfat fat
sd_mod usb-storage usbhid binfmt_misc md5 ipv6 rfcomm l2cap bluetooth
af_packet sk98lin eth1394 ide-cd cdrom ohci1394 ieee1394 loop
nls_iso8859-1 ntfs nvidia sata_sil iteraid ata_piix libata scsi_mod
ehci-hcd uhci-hcd usbcore reiserfs
Dec 20 16:19:21 khazad kernel: CPU:    1
Dec 20 16:19:21 khazad kernel: EIP:    0060:[module_unload_init+17/96]   
Tainted: P   VLI
Dec 20 16:19:21 khazad kernel: EIP:    0060:[<c01393f1>]    Tainted: P  
VLI
Dec 20 16:19:21 khazad kernel: EFLAGS: 00210246   (2.6.8.1-12mdksmp) 
Dec 20 16:19:21 khazad kernel: EIP is at module_unload_init+0x11/0x60
Dec 20 16:19:21 khazad kernel: eax: f8a31220   ebx: f8be1000   ecx:
f8a30d80   edx: 0000001f
Dec 20 16:19:21 khazad kernel: esi: 00000460   edi: f8be281c   ebp:
e549fefc   esp: e549fefc
Dec 20 16:19:21 khazad kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 16:19:21 khazad kernel: Process modprobe (pid: 11419,
threadinfo=e549e000 task=e8be80b0)
Dec 20 16:19:21 khazad kernel: Stack: e549ff9c c013b417 f8a30d80 f8be1000
f8be281c f8be2708 00000003 e549ff3c 
Dec 20 16:19:21 khazad kernel:        c015c054 c1813034 00200286 00000000
00000488 00000000 00000000 e5aec804 
Dec 20 16:19:21 khazad kernel:        e494c520 f8bab000 00000000 f8a30d80
00000000 00000000 00000000 00000000 
Dec 20 16:19:21 khazad kernel: Call Trace:
Dec 20 16:19:21 khazad kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
Dec 20 16:19:21 khazad kernel:  [<c0107dff>] show_stack+0x7f/0xa0
Dec 20 16:19:21 khazad kernel:  [show_registers+351/480]
show_registers+0x15f/0x1e0
Dec 20 16:19:21 khazad kernel:  [<c0107f9f>] show_registers+0x15f/0x1e0
Dec 20 16:19:21 khazad kernel:  [die+139/256] die+0x8b/0x100
Dec 20 16:19:21 khazad kernel:  [<c010816b>] die+0x8b/0x100
Dec 20 16:19:21 khazad kernel:  [do_page_fault+966/1456]
do_page_fault+0x3c6/0x5b0
Dec 20 16:19:21 khazad kernel:  [<c011c3c6>] do_page_fault+0x3c6/0x5b0
Dec 20 16:19:21 khazad kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec 20 16:19:21 khazad kernel:  [<c0107a7d>] error_code+0x2d/0x38
Dec 20 16:19:21 khazad kernel:  [load_module+1591/2592]
load_module+0x637/0xa20
Dec 20 16:19:21 khazad kernel:  [<c013b417>] load_module+0x637/0xa20
Dec 20 16:19:21 khazad kernel:  [sys_init_module+94/528]
sys_init_module+0x5e/0x210
Dec 20 16:19:21 khazad kernel:  [<c013b85e>] sys_init_module+0x5e/0x210
Dec 20 16:19:21 khazad kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Dec 20 16:19:21 khazad kernel:  [<c0106fa1>] sysenter_past_esp+0x52/0x71
Dec 20 16:19:21 khazad kernel: Code: ff 40 34 83 c4 08 89 d0 5b 5e 5d c3
8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 ba 1f 00 00 00 89 e5 8b 4d 08
8d 81 a0 04 00 00 <89> 81 a0 04 00 00 89 81 a4 04 00 00 89 c8 90 c7 80 a0
00 00 00

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-04 07:40 fermier        New Issue                                    
12-20-04 07:40 fermier        Distribution              => Mandrake 10.1
Offficial
12-20-04 07:40 fermier        Kernel Version            => 2.3.8.1-12mdk   
12-20-04 08:31 rlrevell       Note Added: 0002868                          
12-20-04 13:04 fermier        Note Added: 0002871                          
12-20-04 13:05 fermier        Note Added: 0002872                          
12-20-04 14:27 tiwai          Note Added: 0002873                          
12-20-04 15:35 fermier        Note Added: 0002877                          
12-20-04 15:38 tiwai          Note Added: 0002878                          
12-20-04 16:01 fermier        Note Added: 0002879                          
12-20-04 16:05 tiwai          Note Added: 0002881                          
12-20-04 16:06 tiwai          Note Added: 0002882                          
12-20-04 16:23 fermier        Note Added: 0002884                          
12-20-04 16:34 tiwai          Note Added: 0002885                          
12-20-04 17:32 fermier        Note Added: 0002889                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
