From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000714]: On newer xboxes, the xbox=1 workaround does not solve the problem.
Date: Wed, 8 Dec 2004 12:21:25 +0100
Message-ID: <09ec9053d673be1d3ab84187a0ff5552@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 66FF8383
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2004 12:21:25 +0100 (MET)
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


A new RELATIONSHIP has been added to the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=714> 
======================================================================
Reported By:                davidmpye
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   714
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.28
======================================================================
Date Submitted:             12-08-2004 01:35 CET
Last Modified:              12-08-2004 12:21 CET
======================================================================
Summary:                    On newer xboxes, the xbox=1 workaround does not
solve the problem.
Description: 
This is a followup to bug 221, and the workaround that was added to ALSA
1.0.7.

Unfortunately, on newer xboxes, the chip reports less info than before,
making another change necessary - this change is backwards compatible, and
doesn't break earlier xboxes, of course. 

Please see attached patch.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000221 ac97 detect fails on xbox/i8x0
======================================================================

----------------------------------------------------------------------
 davidmpye - 12-08-04 01:52 
----------------------------------------------------------------------
If the patch requires 'crediting', the original author is Ed Hucek
(hostmaster@ed-soft.at).

Thanks,

David

----------------------------------------------------------------------
 tiwai - 12-08-04 12:17 
----------------------------------------------------------------------
Please provide the signed-off-by, as described in the News page.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-04 01:35 davidmpye      New Issue                                    
12-08-04 01:35 davidmpye      Distribution              => Debian          
12-08-04 01:35 davidmpye      Kernel Version            => 2.4.28          
12-08-04 01:52 davidmpye      Note Added: 0002772                          
12-08-04 12:17 tiwai          Note Added: 0002780                          
12-08-04 12:21 tiwai          Relationship added       related to 0000221  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
