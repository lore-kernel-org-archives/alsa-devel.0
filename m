From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000919]: Master volume doesn't control rear speakers...
Date: Tue, 22 Feb 2005 09:56:42 +0100
Message-ID: <3bbdd9ff3155b9a9ec8c53e61bbebc2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 146E6174
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:56:43 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000154.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=919> 
======================================================================
Reported By:                adamk75
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   919
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-18-2005 12:41 CET
Last Modified:              02-22-2005 09:56 CET
======================================================================
Summary:                    Master volume doesn't control rear speakers...
Description: 

If I adjust the master volume in alsamixer, the rear speaker volume isn't
affected at all.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000154 Master volume only controls front outpu...
======================================================================

----------------------------------------------------------------------
 tiwai - 02-18-05 13:00 
----------------------------------------------------------------------
It's a feature of ac97 codec.  Not a bug.

----------------------------------------------------------------------
 adamk75 - 02-18-05 13:06 
----------------------------------------------------------------------
Having a master volume control that doesn't actually control the master
volume is a feature?

----------------------------------------------------------------------
 tiwai - 02-18-05 14:32 
----------------------------------------------------------------------
Yes.  The AC97 master volume register doesn't affect the volume of
surrounds.

----------------------------------------------------------------------
 adamk75 - 02-18-05 14:41 
----------------------------------------------------------------------
Then shouldn't "master" be renamed?  A master volume control implies that
it will control the volume of all output.  Clearly this isn't the case.

----------------------------------------------------------------------
 tiwai - 02-18-05 15:00 
----------------------------------------------------------------------
Maybe.  It's called as Master only from a traditional reason.  For example,
OSS uses this control as the Master control.
I myself don't mind to change it except for compatibility reason.

----------------------------------------------------------------------
 tiwai - 02-18-05 15:02 
----------------------------------------------------------------------
Also, this register controls the master volume of the mixing among PCM and
input signals from Line, Mic, etc (although its output is routed only to
Front).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-05 12:41 adamk75        New Issue                                    
02-18-05 13:00 tiwai          Note Added: 0003650                          
02-18-05 13:06 adamk75        Note Added: 0003651                          
02-18-05 14:32 tiwai          Note Added: 0003652                          
02-18-05 14:41 adamk75        Note Added: 0003653                          
02-18-05 15:00 tiwai          Note Added: 0003654                          
02-18-05 15:02 tiwai          Note Added: 0003655                          
02-22-05 09:56 perex          Relationship added       related to 0000154  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
