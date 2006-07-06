From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002254]: Compilation warnings that
	result in the module to not be loaded
Date: Fri, 7 Jul 2006 01:21:58 +0200
Message-ID: <acfd8ec3d8bc9b839aeeb36aa1324c7e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F9C1236
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 01:21:58 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2254> 
======================================================================
Reported By:                LordRaiden
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2254
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             kernel 2.6.17-3
======================================================================
Date Submitted:             07-03-2006 05:47 CEST
Last Modified:              07-07-2006 01:21 CEST
======================================================================
Summary:                    Compilation warnings that result in the module to
not be loaded
Description: 
I tried both 1.0.11 and 1.0.12rc1, both with the same result. i'm trying to
compile via82xx drivers, but I think the problems are in an acore/sound.c
file (everything else compiles without errors or warnings.

/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c: In function
&#8216;snd_register_device&#8217;:
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 2 of &#8216;class_device_create&#8217; makes pointer from
integer without a cast
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 3 of &#8216;class_device_create&#8217; makes integer from
pointer without a cast
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 4 of &#8216;class_device_create&#8217; from incompatible
pointer type
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 5 of &#8216;class_device_create&#8217; discards
qualifiers from pointer target type

======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-06-06 23:51 
----------------------------------------------------------------------
The ALSA drivers shipped with the Ubuntu kernel shouldn't be that much
different from the standalone ALSA drivers.

Please post the errors you are seeing in dmesg, or noone will be able to
help you.

----------------------------------------------------------------------
 LordRaiden - 07-07-06 01:21 
----------------------------------------------------------------------
Here it is

[17179596.508000] BUG: unable to handle kernel paging request at virtual
address 07400041
[17179596.508000]  printing eip:
[17179596.508000] c01de846
[17179596.508000] *pde = 00000000
[17179596.508000] Oops: 0000 [#1]
[17179596.508000] SMP
[17179596.508000] Modules linked in: snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev soundcore nvidia
agpgart crc_ccitt psmouse serio_raw i2c_core parport_pc parport floppy
pcspkr usbhid ext3 jbd uhci_hcd ehci_hcd usbcore ide_generic ide_cd cdrom
ide_disk via82cxxx generic thermal processor fan capability commoncap
vesafb fbcon tileblit font bitblit softcursor
[17179596.508000] CPU:    0
[17179596.508000] EIP:    0060:[<c01de846>]    Tainted: P      VLI
[17179596.508000] EFLAGS: 00010286   (2.6.17-4-k7 #1)
[17179596.508000] EIP is at kref_get+0x6/0x40
[17179596.508000] eax: 07400041   ebx: 07400041   ecx: cbb02c00   edx:
00000000
[17179596.508000] esi: cbb02300   edi: 00000000   ebp: 00000021   esp:
cac45e14
[17179596.508000] ds: 007b   es: 007b   ss: 0068
[17179596.508000] Process modprobe (pid: 2711, threadinfo=cac44000
task=ce9a2050)
[17179596.508000] Stack: ce963030 ce963030 c1203e60 833e6f00 07400029
c01ddc3f cbb02380 c0242bde
[17179596.508000]        c0243078 00000014 cbb02380 c03716f4 cbb02c00
cbb02308 ffffffea 00000001
[17179596.508000]        cbb02300 cbb02300 fffffff4 cbb02c00 00000021
c02433bd cac45e98 cac45e98
[17179596.508000] Call Trace:
[17179596.508000]  <c01ddc3f> kobject_get+0xf/0x20  <c0242bde>
class_device_get+0xe/0x20
[17179596.508000]  <c0243078> class_device_add+0x68/0x310  <c02433bd>
class_device_create+0x8d/0xc0
[17179596.508000]  <d0f9f300> snd_register_device+0x150/0x160 [snd] 
<d087a0da> alsa_timer_init+0xda/0x18c [snd_timer]
[17179596.508000]  <c012e920> blocking_notifier_call_chain+0x30/0x60 
<c013bbc8> sys_init_module+0x148/0x1ad0
[17179596.508000]  <c015aa1d> do_mmap_pgoff+0x52d/0x71a  <c0164950>
__kmalloc+0x0/0x90
[17179596.508000]  <c0102fbf> sysenter_past_esp+0x54/0x75
[17179596.508000] Code: 00 00 00 c7 44 24 04 af 20 2f c0 c7 04 24 47 68 2e
c0 e8 be 37 f4 ff e8 99 5f f2 ff eb 82 8d b4 26 00 00 00 00 53 89 c3 83 ec
10 <8b> 00 85 c0 74 08 90 ff 03 83 c4 10 5b c3 c7 44 24 0c 79 98 2d
[17179596.508000] EIP: [<c01de846>] kref_get+0x6/0x40 SS:ESP 0068:cac45e14

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-06 05:47 LordRaiden     New Issue                                    
07-03-06 05:47 LordRaiden     Distribution              => Ubuntu          
07-03-06 05:47 LordRaiden     Kernel Version            => kernel 2.6.17-3 
07-03-06 05:49 LordRaiden     Issue Monitored: LordRaiden                    
07-06-06 02:28 Adrian Bunk    Note Added: 0010846                          
07-06-06 02:28 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - via82xx
07-06-06 02:28 Adrian Bunk    Steps to Reproduce Updated                    
07-06-06 06:17 LordRaiden     Note Added: 0010853                          
07-06-06 06:18 LordRaiden     Note Edited: 0010853                         
07-06-06 23:51 Adrian Bunk    Note Added: 0010887                          
07-07-06 01:21 LordRaiden     Note Added: 0010889                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
