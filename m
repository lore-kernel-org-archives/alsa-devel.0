From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000707]: Incorrect suspend code
Date: Sun, 5 Dec 2004 10:09:07 +0100
Message-ID: <0032d9134542ae9c1d7b28b267d22d38@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 222C9348
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2004 10:09:08 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              12-05-2004 10:09 CET
======================================================================
Summary:                    Incorrect suspend code
Description: 
My laptop does not wakeup from suspend to RAM due to intel8xx
driver. Many other are seeing the very same problem. It is due to
incorrect suspend code.

In additionnal information there is a fix for this problem that I tested
on my laptop and that indeed fix the problem.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 10:09 Eric Valette   New Issue                                    
12-05-04 10:09 Eric Valette   Distribution              => Debian          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
