From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000438]: OpenOffice crashes with LD_PRELOAD=/usr/lib/libaoss.so
Date: Fri, 13 Aug 2004 11:41:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040813094143.5725E1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A9E9828C
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 11:41:43 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 683E9179A1
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 11:41:43 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000438
======================================================================
Reported By:                vslavik
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Bug ID:                     438
Category:                   
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-13-2004 11:41 CEST
Last Modified:              08-13-2004 11:41 CEST
======================================================================
Summary:                    OpenOffice crashes with LD_PRELOAD=/usr/lib/libaoss.so
Description: 
I'm having problems with using ALSA's OSS library together with OpenOffice
(version 1.1.1): it crashes early during startup. It doesn't happen if
libaoss.so is not preloaded.

Ending parts of strace output are:
...
open("/opt/OpenOffice.org/program/libz.so.1", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/opt/OpenOffice.org/program/libz.so.1", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/opt/OpenOffice.org/program/libz.so.1", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("i686/mmx/libz.so.1", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("i686/libz.so.1", O_RDONLY)        = -1 ENOENT (No such file or
directory)
open("mmx/libz.so.1", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("libz.so.1", O_RDONLY)             = -1 ENOENT (No such file or
directory)
open("/lib/libz.so.1", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\23"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=65412, ...}) = 0
mmap2(NULL, 67388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4203e000
mmap2(0x4204e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xf) = 0x4204e000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x4204f000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x42050000
mprotect(0x4181d000, 8519680, PROT_READ|PROT_WRITE) = 0
mprotect(0x4181d000, 8519680, PROT_READ|PROT_EXEC) = 0
munmap(0x4108d000, 115564)              = 0
modify_ldt(1, {entry_number:0, base_addr:0x411c8060, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}, 16) = 0
getpid()                                = 7468
rt_sigaction(SIGRTMIN, {0x411c2f90, [], SA_RESTORER, 0x413d42a8}, NULL, 8)
= 0
rt_sigaction(SIGRT_1, {0x411c3070, [], SA_RESTORER, 0x413d42a8}, NULL, 8)
= 0
rt_sigaction(SIGRT_2, {0x411c31e0, [], SA_RESTORER, 0x413d42a8}, NULL, 8)
= 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfffea64, 32, (nil), 0}) = 0
brk(0)                                  = 0x80a66a4
brk(0x80c76a4)                          = 0x80c76a4
brk(0x80c8000)                          = 0x80c8000
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

Some additional information can be found here (another reporter a few
months ago):
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=234044
Let me know if you need more information.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-13-04 11:41 vslavik        New Bug                                      
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
