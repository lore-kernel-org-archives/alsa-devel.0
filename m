From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000620]: Pb with chorus and reverb gestion
Date: Thu, 16 Dec 2004 18:17:59 +0100
Message-ID: <16c9462746c3890ab26a5647ae9b450f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 54931249
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:17:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=620> 
======================================================================
Reported By:                hg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   620
Category:                   CORE - sequencer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-31-2004 12:25 CET
Last Modified:              12-16-2004 18:17 CET
======================================================================
Summary:                    Pb with chorus and reverb gestion
Description: 
Pb with chorus and reverb gestion with driver as emu8000
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 19:00 
----------------------------------------------------------------------
The patch looks fine.
Please create a patch file with a summary and a signed-off-by lines to
apply to CVS.


Thanks.

----------------------------------------------------------------------
 tiwai - 11-16-04 16:42 
----------------------------------------------------------------------
Oops, the patch is NOT correct.  30 = reverb and 38 = chorus in fact.

Fixed on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-04 12:25 hg             New Issue                                    
11-09-04 19:00 tiwai          Note Added: 0002339                          
11-16-04 16:42 tiwai          Status                   new => resolved     
11-16-04 16:42 tiwai          Resolution               open => fixed       
11-16-04 16:42 tiwai          Assigned To               => tiwai           
11-16-04 16:42 tiwai          Note Added: 0002427                          
12-16-04 18:17 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
