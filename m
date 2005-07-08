From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001230]: Compiler warning while compiling gus_main.c
Date: Fri, 8 Jul 2005 10:29:48 +0200
Message-ID: <1f95b23b041f087c6e84f3dbaf672689@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2059A17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:29:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1230> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1230
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-04-2005 09:48 CEST
Last Modified:              07-08-2005 10:29 CEST
======================================================================
Summary:                    Compiler warning while compiling gus_main.c
Description: 
The compiler gives a warning on gus_main.c, that snd_gus_seq_dev_free() is
defined but not used. This patch will fix it. 
======================================================================

----------------------------------------------------------------------
 perex - 07-08-05 10:29 
----------------------------------------------------------------------
Applied to CVS. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-05 09:48 Henne          New Issue                                    
07-04-05 09:48 Henne          File Added: gus_main_c.diff                    
07-08-05 10:29 perex          Status                   assigned => resolved
07-08-05 10:29 perex          Resolution               open => fixed       
07-08-05 10:29 perex          Note Added: 0005407                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
