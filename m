From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000690]: Audigy LS using ALSA+JACK: jackd watchdog timeout
Date: Mon, 6 Dec 2004 23:23:49 +0100
Message-ID: <c67b20fd4b1999e25cdd9f9f76e7e680@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5D761B8
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 23:23:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=690> 
======================================================================
Reported By:                tilman75
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   690
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux unstable (Mon Nov 29 10:03:51 CET
2004)
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-29-2004 10:19 CET
Last Modified:              12-06-2004 23:23 CET
======================================================================
Summary:                    Audigy LS using ALSA+JACK: jackd watchdog timeout
Description: 
the jackd server program cannot be run to produce sound.
instead, after being executed, on first attempt to start a JACK-client, it
renders the fatal error message:
jackd watchdog: timeout - killing jackd
see the steps to reproduce for information on hard- and software versions.
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:23 
----------------------------------------------------------------------
I am closing this bug. The reason for this is that the audigyls driver has
changed a lot recently, and I would prefer it if you tried again with the
latest alsa-driver cvs, and tried the ca0106 driver.
If the bug is still present, please re-raise the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 10:19 tilman75       New Issue                                    
11-29-04 10:19 tilman75       Distribution              => Debian GNU/Linux
unstable (Mon Nov 29 10:03:51 CET 2004)
11-29-04 10:19 tilman75       Kernel Version            => 2.6.9           
12-06-04 23:23 jcdutton       Note Added: 0002737                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
