From: noreply@alsa-project.org
Subject: [ALSA - driver 0000115]: Unresolved Reference:  _mmx_memcpy_Rxxxxxxx
Date: Fri, 16 Jul 2004 14:37:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123720.87BF62C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DE482244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:37:20 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000115
======================================================================
Reported By:                lintos
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     115
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.4.20
======================================================================
Date Submitted:             03-04-2004 03:34 CET
Last Modified:              07-16-2004 14:37 CEST
======================================================================
Summary:                    Unresolved Reference:  _mmx_memcpy_Rxxxxxxx
Description: 
insmod snd produces unresolved reference to _mmx_memcpy_Rxxxxxx
======================================================================

----------------------------------------------------------------------
 perex - 03-05-2004 13:01 CET 
----------------------------------------------------------------------
Can you try the latest 2.4 kernel? It seems like a bug in the kernel
configuration or you compile driver against another kernel.

----------------------------------------------------------------------
 lintos - 03-14-2004 22:31 CET 
----------------------------------------------------------------------
I will need to get the latest 2.4.2x kernel will let you know what
happens.

Note that I do not have this problem on my P4 laptop with the same source
codes (Kernel and Alsa).  When I check the System.map it does not have
that "unresolved reference" listed in the map like the K7 built kernel
does.  I am thinking this is specific to the AMD-K7 built 2.4.20
kernel/alsa combination.  The Code for /usr/src/linux/arch/lib/mmx.c has
CPP directives which are selected if the processor is an AMD K7 as opposed
to any other AMD/Intel chipset.

----------------------------------------------------------------------
 lintos - 03-15-2004 22:45 CET 
----------------------------------------------------------------------
Installing 2.4.25 AND ensuring the correct kernel image is being booted
fixed the problem.  My system was being booted from /boot/vmlinux but the
kernel build was being placed in /vmlinux.  I pointed lilo.conf at the
correct kernel image and rebuilt ALSA vs the right kernel. All modules
load AOK. Ran gnome-alsamixer to set the mixer settings. aplay test.wav.
Sound is good.
Recommendation: close this bugnote.

thanks

Lintos

----------------------------------------------------------------------
 perex - 03-16-2004 16:08 CET 
----------------------------------------------------------------------
User mistake.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-04-04 03:34 lintos         New Bug                                      
03-05-04 13:01 perex          Bugnote Added: 0000500                       
03-14-04 22:31 lintos         Bugnote Added: 0000604                       
03-15-04 22:45 lintos         Bugnote Added: 0000622                       
03-16-04 16:08 perex          Bugnote Added: 0000628                       
03-16-04 16:08 perex          Resolution               open => fixed       
03-16-04 16:08 perex          Status                   assigned => resolved
07-16-04 14:37 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
