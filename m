From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000707]: Incorrect suspend code
Date: Mon, 6 Dec 2004 14:21:11 +0100
Message-ID: <7bf7442e46f5bc6ed2d898fd912a9fa2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6EA5038F
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 14:21:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=707> 
======================================================================
Reported By:                Eric Valette
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   707
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             
======================================================================
Date Submitted:             12-05-2004 10:09 CET
Last Modified:              12-06-2004 14:21 CET
======================================================================
Summary:                    Incorrect suspend code
Description: 
My laptop does not wakeup from suspend to RAM due to intel8xx
driver. Many other are seeing the very same problem. It is due to
incorrect suspend code.

In additionnal information there is a fix for this problem that I tested
on my laptop and that indeed fix the problem.
======================================================================

----------------------------------------------------------------------
 rgmerk - 12-06-04 14:21 
----------------------------------------------------------------------
I can confirm that the problem also exists on the IBM X40; the patch fixes
the problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 10:09 Eric Valette   New Issue                                    
12-05-04 10:09 Eric Valette   Distribution              => Debian          
12-06-04 14:21 rgmerk         Note Added: 0002728                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
