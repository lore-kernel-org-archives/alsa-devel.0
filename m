From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000428]: unresolved symbols in snd-pcm.ko on alpha linux-2.6.7
Date: Thu, 12 Aug 2004 11:54:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040812095400.60C703B005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4F5027D
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2004 11:54:00 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000428
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
Last Modified:              08-12-2004 11:54 CEST
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
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
