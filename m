From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000468]: stuttering audio output with SDL_audio applications
Date: Sat, 9 Apr 2005 11:37:31 +0200
Message-ID: <15937b72c2283e302d7b746f04100a92@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DAC40228
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 11:37:31 +0200 (MEST)
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
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             08-27-2004 03:48 CEST
Last Modified:              04-09-2005 11:37 CEST
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
 jdthood - 04-09-05 04:28 
----------------------------------------------------------------------
Submitter: Does the problem still exist in the latest ALSA release?

----------------------------------------------------------------------
 int-e - 04-09-05 11:37 
----------------------------------------------------------------------
I can't reproduce the problem on linux kernel version 2.6.11.7.
check_invalid_pos() does not seem to get triggered any more either, so I
suppose it's fixed.

Thank you.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-27-04 03:48 int-e          New Issue                                    
08-27-04 03:48 int-e          File Added: via82xx.diff                     
08-27-04 03:48 int-e          Distribution              => Gentoo          
08-27-04 03:48 int-e          Kernel Version            => 2.6.8.1         
04-09-05 04:28 jdthood        Note Added: 0004383                          
04-09-05 11:37 int-e          Note Added: 0004391                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
