From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000973]: Errors in headers
Date: Thu, 10 Mar 2005 14:52:45 +0100
Message-ID: <9ebcf20d868f5d88f8639e801bfe23be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 093BD1C5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 14:52:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=973> 
======================================================================
Reported By:                subbia
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   973
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Hoary
Kernel Version:             2.6.10
======================================================================
Date Submitted:             03-08-2005 03:08 CET
Last Modified:              03-10-2005 14:52 CET
======================================================================
Summary:                    Errors in headers
Description: 
I've tried to make alsa driver, but errors during compiling comes out.

1)on file core.h (sound_core)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=166 error on free_workq:
incomplete
statemente 

2)on file aio.h (kernel/include/linux)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=151 same of above

p.s.: I've bypassed the first errore 'cause i'm thinking free_workq is a
pointer, but in the second error don't goes this solution, so.....I don't
know
======================================================================

----------------------------------------------------------------------
 subbia - 03-10-05 14:49 
----------------------------------------------------------------------
No, my kernel is the 2.6.10, and i haven't modified it. I've installed
kernel's sources directly from ubuntu mirrors, with synaptic, if this can
be usefull......

----------------------------------------------------------------------
 tiwai - 03-10-05 14:52 
----------------------------------------------------------------------
How did you compile ALSA drivers?
Did you pass proper configure options?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 03:08 subbia         New Issue                                    
03-08-05 03:08 subbia         Distribution              => Ubuntu Hoary    
03-08-05 03:08 subbia         Kernel Version            => 2.6.10          
03-09-05 18:40 tiwai          Note Added: 0003833                          
03-10-05 14:49 subbia         Note Added: 0003854                          
03-10-05 14:52 tiwai          Note Added: 0003855                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
