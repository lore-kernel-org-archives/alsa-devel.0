From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000544]: Sound freezes (but can be restarted OK) after kernel locked for a long time
Date: Wed, 16 Mar 2005 22:21:50 +0100
Message-ID: <8e6b927727afb57cc267b3fbddb148e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9ADA231
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 22:21:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=544> 
======================================================================
Reported By:                sasa
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   544
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-26-2004 10:44 CEST
Last Modified:              03-16-2005 22:21 CET
======================================================================
Summary:                    Sound freezes (but can be restarted OK) after kernel
locked for a long time
Description: 
When doing an intensive task that locks the kernel (such as fixating
CD-ROM, initializing Lucent modem chipset) when even the mouse pointer
stops moving for half a second or so, sound from xmms stops playing until
I press stop and play again.
Interesting thing is that this only happens when MMAP is on. When I turn
it off, the sound freezes for a second and after that continues.
======================================================================

----------------------------------------------------------------------
 lee - 10-09-04 20:13 
----------------------------------------------------------------------
Please close this.  It's an XMMS bug, probably related to how XMMS does
xrun recovery.

----------------------------------------------------------------------
 jdthood - 03-16-05 22:21 
----------------------------------------------------------------------
Apparently this report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 10:44 sasa           New Issue                                    
09-26-04 10:58 sasa           Note Added: 0001916                          
09-26-04 10:59 sasa           Issue Monitored: sasa                        
09-26-04 12:03 lee            Note Added: 0001918                          
09-26-04 12:25 sasa           Note Added: 0001919                          
10-09-04 20:02 jtimonen       Note Added: 0002062                          
10-09-04 20:13 lee            Note Added: 0002063                          
03-16-05 22:21 jdthood        Note Added: 0003966                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
