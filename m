From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000428]: unresolved symbols in snd-pcm.ko on alpha linux-2.6.7
Date: Thu, 12 Aug 2004 14:07:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040812120728.5FE611102E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C5AF8196
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2004 14:07:28 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 77A6D17578
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2004 14:07:28 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000428
======================================================================
Reported By:                svetljo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     428
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake cooker
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-06-2004 21:15 CEST
Last Modified:              08-12-2004 14:07 CEST
======================================================================
Summary:                    unresolved symbols in snd-pcm.ko on alpha linux-2.6.7
Description: 
trying to compile latest alsa driver 1.0.6-rc1
results in unresolved symbols at module link time
in snd-pcm.ko

gcc-3.4 , linux-2.6.7

here is the message:
*** Warning: "__ioremap" [sound/core/snd-pcm.ko] undefined!
*** Warning: "virt_to_phys" [sound/core/snd-pcm.ko] undefined!

which results in unusable alsa drivers
======================================================================

----------------------------------------------------------------------
 svetljo - 08-12-2004 11:09 CEST 
----------------------------------------------------------------------
just to add a note
that 1.0.6-rc2 has the same problem
whereas 1.0.5a and the in-kernel alsa 
build OK

----------------------------------------------------------------------
 perex - 08-12-2004 11:35 CEST 
----------------------------------------------------------------------
Any other warnings during compilation?

----------------------------------------------------------------------
 svetljo - 08-12-2004 11:42 CEST 
----------------------------------------------------------------------
that's all i see

  CC [M]  sound/core/pcm_native.o
sound/core/pcm_native.c: In function `snd_pcm_mmap_data':
sound/core/pcm_native.c:3067: warning: implicit declaration of function
`virt_to_phys'
sound/core/pcm_native.c:3067: warning: implicit declaration of function
`__ioremap'

----------------------------------------------------------------------
 perex - 08-12-2004 11:54 CEST 
----------------------------------------------------------------------
Are you using 1.0.6rc2 sources? Lines does not match.

----------------------------------------------------------------------
 svetljo - 08-12-2004 12:06 CEST 
----------------------------------------------------------------------
it might be a bit earlier,
or a bit later version i use cvs
last changes were to:
usb/usx2y/usbusx2yaudio.c
pci/au88x0/

but it's the same with 1.0.6-rc1 and a bit earlier versions

----------------------------------------------------------------------
 svetljo - 08-12-2004 12:45 CEST 
----------------------------------------------------------------------
could it be an alpha bug, which is just exposed by the new alsa ?


--------greping for io_remap ---------------------
include/asm-i386/pgtable.h-348-#endif /* !CONFIG_DISCONTIGMEM */
include/asm-i386/pgtable.h-349-
include/asm-i386/pgtable.h:350:#define io_remap_page_range
remap_page_range
include/asm-i386/pgtable.h-351-
include/asm-i386/pgtable.h-352-#define
__HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
[svetljo@flamingo linux-2.6.7]$ grep -n2 io_remap include/asm-alpha/*
include/asm-alpha/pgtable.h-328-#endif
include/asm-alpha/pgtable.h-329-
include/asm-alpha/pgtable.h:330:#define io_remap_page_range(vma, start,
busaddr, size, prot) \
include/asm-alpha/pgtable.h-331-    remap_page_range(vma, start,
virt_to_phys(__ioremap(busaddr, size)), size, prot)
include/asm-alpha/pgtable.h-332-
[svetljo@flamingo linux-2.6.7]$ grep -n2 io_remap include/asm-ppc/*
include/asm-ppc/pgtable.h-678-#define kern_addr_valid(addr)     (1)
include/asm-ppc/pgtable.h-679-
include/asm-ppc/pgtable.h:680:#define io_remap_page_range
remap_page_range
include/asm-ppc/pgtable.h-681-
---------------------------------------------------------
if i use 
#define io_remap_page_range remap_page_range

then there are no warnings during the compilation
let's see what will happen on linking time

----------------------------------------------------------------------
 svetljo - 08-12-2004 14:07 CEST 
----------------------------------------------------------------------
compiles OK

bad that i can not test it over ssh
/*and it even doesn't have sound */

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-06-04 21:15 svetljo        New Bug                                      
08-06-04 21:15 svetljo        Distribution              => Mandrake cooker 
08-06-04 21:15 svetljo        Kernel Version            => 2.6.7           
08-11-04 19:31 svetljo        Bug Monitored: svetljo                       
08-12-04 11:09 svetljo        Bugnote Added: 0001552                       
08-12-04 11:35 perex          Bugnote Added: 0001553                       
08-12-04 11:42 svetljo        Bugnote Added: 0001554                       
08-12-04 11:54 perex          Bugnote Added: 0001555                       
08-12-04 12:06 svetljo        Bugnote Added: 0001556                       
08-12-04 12:45 svetljo        Bugnote Added: 0001557                       
08-12-04 14:07 svetljo        Bugnote Added: 0001558                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
