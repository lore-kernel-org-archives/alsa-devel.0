From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000968]: arecord/aplay 24-bit nonstandard?
Date: Fri, 8 Jul 2005 10:34:43 +0200
Message-ID: <11fc1ddc38a04eedf00bdd2753a445eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A6CCD17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=968> 
======================================================================
Reported By:                ScottHelmke
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   968
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-07-2005 18:11 CET
Last Modified:              07-08-2005 10:34 CEST
======================================================================
Summary:                    arecord/aplay 24-bit nonstandard?
Description: 
Using arecord with S24_LE resolution, later tried to import files into
Ardour.  Apparently the 24-bit implemenation by arecord is faulty.  16 and
32 bit audio from arecord imported just fine.  Ardour developers say that
problem is with arecord.


======================================================================

----------------------------------------------------------------------
 ScottHelmke - 03-17-05 07:32 
----------------------------------------------------------------------
S24_3LE works fine with Ardour - thanks!

----------------------------------------------------------------------
 tiwai - 03-18-05 18:15 
----------------------------------------------------------------------
OK, closing this now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-05 18:11 ScottHelmke    New Issue                                    
03-07-05 20:52 perex          Note Added: 0003808                          
03-07-05 20:58 ScottHelmke    Note Added: 0003810                          
03-09-05 18:38 tiwai          Note Added: 0003831                          
03-17-05 07:32 ScottHelmke    Note Added: 0003978                          
03-18-05 18:15 tiwai          Status                   new => resolved     
03-18-05 18:15 tiwai          Resolution               open => not an issue
03-18-05 18:15 tiwai          Assigned To               => tiwai           
03-18-05 18:15 tiwai          Note Added: 0004000                          
03-18-05 18:15 tiwai          Assigned To              tiwai =>            
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
