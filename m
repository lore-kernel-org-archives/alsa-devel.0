From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000973]: Errors in headers
Date: Wed, 16 Mar 2005 18:36:35 +0100
Message-ID: <0a2683a9736bea66d51af8bb8ae65a67@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5C9B921B
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 18:36:35 +0100 (MET)
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
Last Modified:              03-16-2005 18:36 CET
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
 tiwai - 03-16-05 14:47 
----------------------------------------------------------------------
Does the configure detect the kernel tree you installed properly?
Is the kernel source tree exactly matching for your running kernel?

----------------------------------------------------------------------
 subbia - 03-16-05 18:36 
----------------------------------------------------------------------
The configure procedure runs good, with no errors. But when I try to do the
make procedure, here's the error. Kernel tree is exactly the same that
i've installed on my mdk, and is build with modules, 'cause i probe
frequently new hardware on my pc. I've tried to compile alsa 1.0.8 on a
debian installed in another partition (just to be sure) and it does, but i
can't hear something going out from my audio board. It's all ok in the
configuration, matching exactly what on the install howto is written. I'm
thinking it's my sis 7012 audio that cause all this problems. But the
module intel 81x is ok...... I really don't know.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 03:08 subbia         New Issue                                    
03-08-05 03:08 subbia         Distribution              => Ubuntu Hoary    
03-08-05 03:08 subbia         Kernel Version            => 2.6.10          
03-09-05 18:40 tiwai          Note Added: 0003833                          
03-10-05 14:49 subbia         Note Added: 0003854                          
03-10-05 14:52 tiwai          Note Added: 0003855                          
03-11-05 01:11 subbia         Note Added: 0003878                          
03-16-05 14:47 tiwai          Note Added: 0003957                          
03-16-05 18:36 subbia         Note Added: 0003963                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
