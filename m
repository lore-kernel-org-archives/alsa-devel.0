From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000059]: On au8820 left and right channels are swapped
Date: Thu, 10 Mar 2005 21:25:37 +0100
Message-ID: <728cb1cf3c25e6910269900b5376d7a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 33CB91B2
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 21:25:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
======================================================================
Reported By:                kernel_bug
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   59
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-13-2004 11:40 CET
Last Modified:              03-10-2005 21:25 CET
======================================================================
Summary:                    On au8820 left and right channels are swapped
Description: 
In most cases, left and right channels are swapped. But in approx. 5% cases
all OK. Looks like the matter is somewhere in byte alignment...
======================================================================

----------------------------------------------------------------------
 mjander - 03-10-05 16:44 
----------------------------------------------------------------------
AFAIK this bug was solved a long time ago. It was supposedly caused by a
incorrect routing table initialization (bug found by Claudia). That fact,
i guess, leaved some random routes interferening with other intentional
routes.

Did anyone still get this bug or may we close it ?

Best Regards

Manuel

----------------------------------------------------------------------
 kernel_bug - 03-10-05 21:25 
----------------------------------------------------------------------
> Did anyone still get this bug or may we close it ?

Yes, I still get this bug. Channels are swapped just after the module is
loaded. First attempt to play something causes output with swapped
channels, all consequent attempts cause normal output.

"A long time ago" there was fixed another bug concerned with _random_
channel swap at _any_ attempt of output. Now we _always_ have swapped
channels, but only when you try to output something just after the module
is loaded.

I use ALSA drivers from the Linux kernel 2.6.11.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 11:40 kernel_bug     New Issue                                    
02-21-04 15:40 kernel_bug     Note Added: 0000280                          
03-02-04 02:56 Tim            Note Added: 0000429                          
04-09-04 11:54 kernel_bug     Note Added: 0000774                          
04-09-04 18:35 mjander        Note Added: 0000777                          
04-17-04 18:59 mjander        Status                   assigned => closed  
04-17-04 18:59 mjander        Note Added: 0000849                          
04-26-04 17:04 kernel_bug     Status                   closed => feedback  
04-26-04 17:04 kernel_bug     Resolution               open => reopened    
04-26-04 17:04 kernel_bug     Note Added: 0000953                          
04-26-04 23:27 mjander        Note Added: 0000956                          
03-10-05 15:31 jdthood        Note Added: 0003866                          
03-10-05 16:44 mjander        Note Added: 0003867                          
03-10-05 21:25 kernel_bug     Note Added: 0003873                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
