From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001032]: 1.0.9rc2 causes mplayer -ao alsa to crash on startup
Date: Tue, 5 Apr 2005 21:08:33 +0200
Message-ID: <b5b4f44b0a244eafa5e64909198f28c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F385E244
	for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2005 21:08:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1032> 
======================================================================
Reported By:                bero
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1032
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-02-2005 16:10 CEST
Last Modified:              04-05-2005 21:08 CEST
======================================================================
Summary:                    1.0.9rc2 causes mplayer -ao alsa to crash on startup
Description: 
1.0.9rc2 causes mplayer -ao alsa to crash on startup
======================================================================

----------------------------------------------------------------------
 Toph - 04-05-05 21:08 
----------------------------------------------------------------------
I can confirm this issue. Happens with anything that uses alsa, the end any
strace is always:
octl(7, SNDCTL_TMR_START or TCSETS, 0xbffed748) = 0
ioctl(7, TIOCSPGRP, 0xbffed750)         = 0
ioctl(7, TIOCSTI <unfinished ...>
+++ killed by SIGSEGV +++

the attached patch does make everything work again, though.

I'm using Gentoo on x86, Kernel 2.6.11, patched with cko3, my soundcard is
an "Ensoniq 5880 AudioPCI" (es1371), but it seems to happen with most
hardware. http://bugs.gentoo.org/show_bug.cgi?id=87099 is about the same
issue.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-05 16:10 bero           New Issue                                    
04-02-05 16:10 bero           File Added: alsa-lib-mplayer.patch                
   
04-05-05 21:08 Toph           Note Added: 0004340                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
