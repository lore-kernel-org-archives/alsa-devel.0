From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000358]: error in pcm_native.c while compiling alsa-driver from cvs
Date: Fri, 24 Sep 2004 13:35:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113505.F2EA5101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DF08A28B
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:36:02 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000358
======================================================================
Reported By:                msrinath80
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     358
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               RedHat Linux 9
Kernel Version:             2.4.20-8
======================================================================
Date Submitted:             06-30-2004 23:46 CEST
Last Modified:              09-24-2004 13:35 CEST
======================================================================
Summary:                    error in pcm_native.c while compiling alsa-driver from cvs
Description: 
When I try to do a ./cvscompile --with-cards=emu10k1x for a fresh Check Out
(30th June) from alsa CVS, I get the following error:
---------------
pcm_native.c: In function `snd_pcm_mmap_data':
pcm_native.c:3176: warning: passing arg 1 of `remap_page_range' makes
pointer from integer without a cast
pcm_native.c:3176: incompatible type for argument 4 of `remap_page_range'
pcm_native.c:3176: too few arguments to function `remap_page_range'
make[1]: *** [pcm_native.o] Error 1
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/acore'
make: *** [compile] Error 1
---------------
======================================================================

----------------------------------------------------------------------
 msrinath80 - 07-05-2004 07:20 CEST 
----------------------------------------------------------------------
Reminder sent to perex

hi,

sorry to disturb you. can you look into the cvs problem in (pcm_native.c)

thanks!

-pUl|

----------------------------------------------------------------------
 msrinath80 - 07-14-2004 10:27 CEST 
----------------------------------------------------------------------
Seems to work now in the CVS. You might want to close this bug report?

Thanks!

----------------------------------------------------------------------
 tiwai - 07-15-2004 11:22 CEST 
----------------------------------------------------------------------
Fixed now on cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 23:46 msrinath80     New Bug                                      
06-30-04 23:46 msrinath80     File Added: log                              
06-30-04 23:46 msrinath80     Distribution              => RedHat Linux 9  
06-30-04 23:46 msrinath80     Kernel Version            => 2.4.20-8        
06-30-04 23:48 msrinath80     Bug Monitored: msrinath80                    
07-05-04 07:20 msrinath80     Bugnote Added: 0001382                       
07-14-04 10:27 msrinath80     Bugnote Added: 0001417                       
07-15-04 11:22 tiwai          Bugnote Added: 0001426                       
07-15-04 11:22 tiwai          Resolution               open => fixed       
07-15-04 11:22 tiwai          Status                   assigned => resolved
09-24-04 13:35 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
