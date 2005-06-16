From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000973]: Errors in headers
Date: Thu, 16 Jun 2005 14:42:02 +0200
Message-ID: <f0c4ed97788874e6dccb0d53a3e14d86@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C0FD191
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2005 14:42:02 +0200 (MEST)
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
Status:                     resolved
Distribution:               Ubuntu Hoary
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-08-2005 03:08 CET
Last Modified:              06-16-2005 14:42 CEST
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
 perex - 06-06-05 10:06 
----------------------------------------------------------------------
Does 1.0.9a solve this problem?

----------------------------------------------------------------------
 perex - 06-16-05 14:42 
----------------------------------------------------------------------
No response from reporter.

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
03-16-05 18:37 subbia         Note Edited: 0003963                         
06-06-05 10:06 perex          Note Added: 0004891                          
06-16-05 14:42 perex          Status                   assigned => resolved
06-16-05 14:42 perex          Resolution               open => fixed       
06-16-05 14:42 perex          Note Added: 0005054                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
