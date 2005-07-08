From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000468]: stuttering audio output with SDL_audio applications
Date: Fri, 8 Jul 2005 10:38:05 +0200
Message-ID: <d4a2f7bafba9f96518bd5564a0809185@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5EE7F18F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:05 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=468> 
======================================================================
Reported By:                int-e
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   468
Category:                   PCI - via82xx
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-27-2004 03:48 CEST
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    stuttering audio output with SDL_audio applications
Description: 
I traced this down to the check that's now called check_invalid_pos() in
calc_linear_pos() in the driver being triggered with lastpos==bufsize and
res==bufsize/2.

I think lastpos should be 0 at that point.

Moving the assignment viadev->lastpos = res; at the end of that function
after the wrap handling if() solved the problem for me.
======================================================================

----------------------------------------------------------------------
 int-e - 04-09-05 11:37 
----------------------------------------------------------------------
I can't reproduce the problem on linux kernel version 2.6.11.7.
check_invalid_pos() does not seem to get triggered any more either, so I
suppose it's fixed.

Thank you.

----------------------------------------------------------------------
 jdthood - 04-09-05 12:03 
----------------------------------------------------------------------
Thanks for the info.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-27-04 03:48 int-e          New Issue                                    
08-27-04 03:48 int-e          File Added: via82xx.diff                     
08-27-04 03:48 int-e          Distribution              => Gentoo          
08-27-04 03:48 int-e          Kernel Version            => 2.6.8.1         
04-09-05 04:28 jdthood        Note Added: 0004383                          
04-09-05 11:37 int-e          Note Added: 0004391                          
04-09-05 12:03 jdthood        Note Added: 0004392                          
04-09-05 12:03 jdthood        Status                   new => resolved     
04-09-05 12:03 jdthood        Resolution               open => fixed       
04-09-05 12:03 jdthood        Summary                  stuttering audio output
with SDL_audio applications
 => stuttering audio output with SDL_audio applications
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
