From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000672]: alternate ALS0200 ident string
Date: Mon, 27 Dec 2004 15:51:34 +0100
Message-ID: <ea571dc05594bc0897c99065d69bc68c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D845722B
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:51:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=672> 
======================================================================
Reported By:                basic
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   672
Category:                   ISA - als100
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-24-2004 07:31 CET
Last Modified:              12-27-2004 15:51 CET
======================================================================
Summary:                    alternate ALS0200 ident string
Description: 
recently dug up some older hardware to put togather a pc for my brother,
found this OEM ALS0200 card, couldn't get the module to load, so
downloaded pnptools and used pnpdump... long story short, here's the patch
to get it to work.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-24-04 12:16 
----------------------------------------------------------------------
Please provide the summary, description and signed-off-by lines.

----------------------------------------------------------------------
 tiwai - 11-26-04 12:32 
----------------------------------------------------------------------
Thanks, applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 07:31 basic          New Issue                                    
11-24-04 07:31 basic          File Added: als100.c.patch                    
11-24-04 12:16 tiwai          Note Added: 0002546                          
11-26-04 09:46 basic          File Added: als100.c.patch                    
11-26-04 12:32 tiwai          Status                   new => resolved     
11-26-04 12:32 tiwai          Resolution               open => fixed       
11-26-04 12:32 tiwai          Assigned To               => tiwai           
11-26-04 12:32 tiwai          Note Added: 0002602                          
12-27-04 15:51 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
