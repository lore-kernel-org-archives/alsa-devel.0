From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000736]: modprobe snd-azx still gives segmentation fault
Date: Thu, 20 Jan 2005 19:18:22 +0100
Message-ID: <090aa42b6b4823de6e83d1b088335249@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2B7AF229
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 19:18:23 +0100 (MET)
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
Last Modified:              01-20-2005 19:18 CET
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
 fermier - 12-20-04 18:10 
----------------------------------------------------------------------
Did a clean boot and here is the message.  I have to go and will only be
able to continue with this reporting after 16 Jan 2005.  Sorry.  I'm late
for my flight!

Dec 20 18:05:50 khazad kernel: Unable to handle kernel paging request at
virtual address f8a31220
Dec 20 18:05:50 khazad kernel:  printing eip:
Dec 20 18:05:50 khazad kernel: c01393f1
Dec 20 18:05:50 khazad kernel: *pde = 37e1e067
Dec 20 18:05:50 khazad kernel: *pte = 00000000
Dec 20 18:05:50 khazad kernel: Oops: 0002
[https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
Dec 20 18:05:50 khazad kernel: SMP 
Dec 20 18:05:50 khazad kernel: Modules linked in: usbhid binfmt_misc md5
ipv6 rfcomm l2cap bluetooth af_packet sk98lin eth1394 ide-cd cdrom
ohci1394 ieee1394 loop nls_iso8859-1 ntfs nvidia sata_sil iteraid ata_piix
libata scsi_mod ehci-hcd uhci-hcd usbcore reiserfs
Dec 20 18:05:50 khazad kernel: CPU:    1
Dec 20 18:05:50 khazad kernel: EIP:    0060:[module_unload_init+17/96]   
Tainted: P   VLI
Dec 20 18:05:50 khazad kernel: EIP:    0060:[<c01393f1>]    Tainted: P  
VLI
Dec 20 18:05:50 khazad kernel: EFLAGS: 00210246   (2.6.8.1-12mdksmp) 
Dec 20 18:05:50 khazad kernel: EIP is at module_unload_init+0x11/0x60
Dec 20 18:05:50 khazad kernel: eax: f8a31220   ebx: f8bc2000   ecx:
f8a30d80   edx: 0000001f
Dec 20 18:05:50 khazad kernel: esi: 00000460   edi: f8bc381c   ebp:
f4457efc   esp: f4457efc
Dec 20 18:05:50 khazad kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 18:05:50 khazad kernel: Process modprobe (pid: 4227,
threadinfo=f4456000 task=f1872c90)
Dec 20 18:05:50 khazad kernel: Stack: f4457f9c c013b417 f8a30d80 f8bc2000
f8bc381c f8bc3708 00000003 f4457f3c 
Dec 20 18:05:50 khazad kernel:        c015c054 c1813034 00200286 00000000
00000488 00000000 00000000 f31ddee8 
Dec 20 18:05:50 khazad kernel:        f7324e00 f8bab000 00000000 f8a30d80
00000000 00000000 00000000 00000000 
Dec 20 18:05:50 khazad kernel: Call Trace:
Dec 20 18:05:50 khazad kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
Dec 20 18:05:50 khazad kernel:  [<c0107dff>] show_stack+0x7f/0xa0
Dec 20 18:05:50 khazad kernel:  [show_registers+351/480]
show_registers+0x15f/0x1e0
Dec 20 18:05:50 khazad kernel:  [<c0107f9f>] show_registers+0x15f/0x1e0
Dec 20 18:05:50 khazad kernel:  [die+139/256] die+0x8b/0x100
Dec 20 18:05:50 khazad kernel:  [<c010816b>] die+0x8b/0x100
Dec 20 18:05:50 khazad kernel:  [do_page_fault+966/1456]
do_page_fault+0x3c6/0x5b0
Dec 20 18:05:50 khazad kernel:  [<c011c3c6>] do_page_fault+0x3c6/0x5b0
Dec 20 18:05:50 khazad kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec 20 18:05:50 khazad kernel:  [<c0107a7d>] error_code+0x2d/0x38
Dec 20 18:05:50 khazad kernel:  [load_module+1591/2592]
load_module+0x637/0xa20
Dec 20 18:05:50 khazad kernel:  [<c013b417>] load_module+0x637/0xa20
Dec 20 18:05:50 khazad kernel:  [sys_init_module+94/528]
sys_init_module+0x5e/0x210
Dec 20 18:05:50 khazad kernel:  [<c013b85e>] sys_init_module+0x5e/0x210
Dec 20 18:05:50 khazad kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Dec 20 18:05:50 khazad kernel:  [<c0106fa1>] sysenter_past_esp+0x52/0x71
Dec 20 18:05:50 khazad kernel: Code: ff 40 34 83 c4 08 89 d0 5b 5e 5d c3
8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 ba 1f 00 00 00 89 e5 8b 4d 08
8d 81 a0 04 00 00 <89> 81 a0 04 00 00 89 81 a4 04 00 00 89 c8 90 c7 80 a0
00 00 00

----------------------------------------------------------------------
 tiwai - 01-20-05 19:18 
----------------------------------------------------------------------
Try 1.0.8.  All odd bugs around azx should have been fixed.

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
12-20-04 17:40 tiwai          Note Added: 0002891                          
12-20-04 18:10 fermier        Note Added: 0002893                          
01-20-05 19:18 tiwai          Note Added: 0003334                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
