From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000673]: alternate CS4235 ident string
Date: Mon, 27 Dec 2004 15:51:17 +0100
Message-ID: <330dcd16853f6fbde84abb1ba458d8aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EFF9722B
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:51:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=673> 
======================================================================
Reported By:                basic
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   673
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-24-2004 07:45 CET
Last Modified:              12-27-2004 15:51 CET
======================================================================
Summary:                    alternate CS4235 ident string
Description: 
Found a CS4235 on a SiS530 based mainboard (no longer have the box, so no
idea who built it), alsaconf could detect it but the driver would not
load. Here's the patch, got the strings with isapnptools (pnpdump).
======================================================================

----------------------------------------------------------------------
 tiwai - 11-24-04 12:15 
----------------------------------------------------------------------
Could you provide the summary, description and signed-off-by lines for your
patch (as written in the main page)?

Thanks.

----------------------------------------------------------------------
 tiwai - 11-26-04 12:31 
----------------------------------------------------------------------
Now applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 07:45 basic          New Issue                                    
11-24-04 07:45 basic          File Added: cs4236.c.patch                    
11-24-04 12:15 tiwai          Note Added: 0002545                          
11-26-04 09:46 basic          File Added: cs4236.c.patch                    
11-26-04 12:31 tiwai          Note Added: 0002601                          
11-26-04 12:31 tiwai          Status                   new => resolved     
11-26-04 12:31 tiwai          Resolution               open => fixed       
11-26-04 12:31 tiwai          Assigned To               => tiwai           
12-27-04 15:51 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
