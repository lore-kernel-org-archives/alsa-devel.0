From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001016]: [PATCH] conf.c -- allow to compile with gcc 4.0
Date: Tue, 29 Mar 2005 15:25:44 +0200
Message-ID: <26f5cd6bf9fff99f6317dd3647fbed58@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AB2B425E
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 15:25:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1016> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1016
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-25-2005 15:41 CET
Last Modified:              03-29-2005 15:25 CEST
======================================================================
Summary:                    [PATCH] conf.c -- allow to compile with gcc 4.0
Description: 
The submitter of Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=300792 has provided this
patch which allows
alsa-lib to be built with gcc 4.0.

He says that without the patch, gcc-4.0 stops with an 'invalid 
storage class' error because it is not allowed to declare a 'static'
function inside another function.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-05 15:25 
----------------------------------------------------------------------
Already fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 15:41 jdthood        New Issue                                    
03-25-05 15:41 jdthood        File Added: conf.c-gcc-4.0_20050325jdth1.patch    
               
03-29-05 15:25 tiwai          Status                   new => resolved     
03-29-05 15:25 tiwai          Resolution               open => fixed       
03-29-05 15:25 tiwai          Assigned To               => tiwai           
03-29-05 15:25 tiwai          Note Added: 0004243                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
