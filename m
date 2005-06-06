From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000932]: locked at module probe
Date: Mon, 6 Jun 2005 10:53:34 +0200
Message-ID: <6b20a7fe71fc78744ca761282a28c3df@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FCA3181
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 10:53:34 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=932> 
======================================================================
Reported By:                jeanseb
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   932
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               debian
Kernel Version:             2.6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-22-2005 11:03 CET
Last Modified:              06-06-2005 10:53 CEST
======================================================================
Summary:                    locked at module probe
Description: 
oprobing with fast spinlock an prempt anable smp kernel hang.
This is a spin lock problem and I've fixed it in the isisalsa version.


======================================================================

----------------------------------------------------------------------
 jdthood - 04-13-05 21:50 
----------------------------------------------------------------------
Submitter: Was this fixed in the latest ALSA release?

----------------------------------------------------------------------
 perex - 06-06-05 10:53 
----------------------------------------------------------------------
No response from reporter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 11:03 jeanseb        New Issue                                    
02-22-05 11:03 jeanseb        Distribution              => debian          
02-22-05 11:03 jeanseb        Kernel Version            => 2.6             
02-22-05 14:18 tiwai          Note Added: 0003697                          
02-22-05 14:19 tiwai          Note Added: 0003698                          
04-13-05 21:50 jdthood        Note Added: 0004477                          
06-06-05 10:53 perex          Status                   assigned => resolved
06-06-05 10:53 perex          Resolution               open => fixed       
06-06-05 10:53 perex          Note Added: 0004899                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
