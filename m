From: noreply@alsa-project.org
Subject: [ALSA - driver 0000086]: sound is jerky, sometimes bigger jumps
Date: Fri, 16 Jul 2004 14:30:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123042.E59362C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5023F244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:30:43 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000086
======================================================================
Reported By:                bekesa
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     86
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.3
======================================================================
Date Submitted:             02-25-2004 12:27 CET
Last Modified:              07-16-2004 14:30 CEST
======================================================================
Summary:                    sound is jerky, sometimes bigger jumps
Description: 
ALSA is compiled in the kernel (2.6) with OSS emulation.
PCM sound through OSS is jerky and it does bigger jumps sometimes. The
problem is the same with native ALSA (artsd with ALSA as sound I/O). It
has no problem with native OSS.
======================================================================

----------------------------------------------------------------------
 perex - 02-26-2004 12:12 CET 
----------------------------------------------------------------------
Can you try the latest 1.0.3rc2 code?

----------------------------------------------------------------------
 bekesa - 03-10-2004 00:16 CET 
----------------------------------------------------------------------
Tried 1.0.3 (final) with 2.6.3, does not help.
But now I noticed that the noise is stonger if X is working (like I move a
window, etc).

Also tried 1.0.3 with a 2.4 kernel, it works fine.

edited on: 03-10-04 00:16

----------------------------------------------------------------------
 perex - 03-23-2004 16:28 CET 
----------------------------------------------------------------------
Then it's kernel core related problem (seems like PCI bus setup). You may
report this to the linux kernel mailing list.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-25-04 12:27 bekesa         New Bug                                      
02-26-04 12:12 perex          Bugnote Added: 0000343                       
03-09-04 15:21 bekesa         Bugnote Added: 0000549                       
03-10-04 00:16 bekesa         Bugnote Edited: 0000549                      
03-18-04 09:11 onemaN         Bugnote Added: 0000639                       
03-18-04 09:11 onemaN         Bugnote Deleted: 0000639                     
03-23-04 16:28 perex          Bugnote Added: 0000668                       
03-23-04 16:28 perex          Assigned To               => perex           
03-23-04 16:28 perex          Resolution               open => fixed       
03-23-04 16:28 perex          Status                   new => resolved     
07-16-04 14:30 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
