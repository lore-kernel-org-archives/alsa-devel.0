From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000570]: Sparse mixer for RME96
Date: Wed, 29 Dec 2004 14:31:20 +0100
Message-ID: <db34a6759dbd339b25cbd29ead71cd69@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CF16E26D
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 14:31:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=570> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   570
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-07-2004 10:59 CEST
Last Modified:              12-29-2004 14:31 CET
======================================================================
Summary:                    Sparse mixer for RME96
Description: 
Noticed that almost all mixer controls was identified as PCM controles, so
I did a small patch.

Summary: RME96 Mixer fix

 - Fix mixer bugs

Signed-off-by: Peter Chrisensen <peter@developers.dk>
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000681 alsamixer, rmedigicontrol and rme96 ker...
has duplicate       0000682 alsamixer, rmedigicontrol and rme96 ker...
======================================================================

----------------------------------------------------------------------
 ungod - 10-07-04 18:05 
----------------------------------------------------------------------
I see. Strange. Anyway, didn't even know that there was such a tool. I'll
mention that to the dude on #alsa I made the patch for.

----------------------------------------------------------------------
 tiwai - 11-29-04 16:11 
----------------------------------------------------------------------
Now applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-07-04 10:59 ungod          New Issue                                    
10-07-04 10:59 ungod          File Added: rme96-mixerfix.diff                   

10-07-04 14:11 tiwai          Note Added: 0002030                          
10-07-04 14:12 tiwai          Note Added: 0002031                          
10-07-04 18:05 ungod          Note Added: 0002036                          
11-29-04 16:01 tiwai          Relationship added       related to 0000681  
11-29-04 16:04 tiwai          Relationship added       has duplicate 0000682
11-29-04 16:11 tiwai          Status                   new => resolved     
11-29-04 16:11 tiwai          Resolution               open => fixed       
11-29-04 16:11 tiwai          Assigned To               => tiwai           
11-29-04 16:11 tiwai          Note Added: 0002648                          
12-29-04 14:31 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
