From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000361]: Latest alsa-driver from CVS will not compile on Linux 2.4 (perhaps RH EL specific)
Date: Fri, 24 Sep 2004 13:38:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113826.F417E101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 32CB6288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:38:27 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000361
======================================================================
Reported By:                elklein
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     361
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Red Hat Enterprise Linux
Kernel Version:             2.4.21-15.0.2
======================================================================
Date Submitted:             07-02-2004 16:53 CEST
Last Modified:              09-24-2004 13:38 CEST
======================================================================
Summary:                    Latest alsa-driver from CVS will not compile on Linux 2.4 (perhaps RH EL specific)
Description: 
I believe this bug was introduced on June 22nd in
alsa-devel/acore/pcm_native.patch

With the latest code, I get a compile error at line 3175 of pcm_native.c.
The problem is that io_remap_page_range has too few arguments for my OS
version (it works with the 2.6 version in the code), however I am using
Red Hat's latest 2.4.21-15.0.2 kernel.
======================================================================

----------------------------------------------------------------------
 elklein - 07-02-2004 16:54 CEST 
----------------------------------------------------------------------
I feel like an idiot. I just noticed that this bug had already been
reported a bit ago. The first bug is:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000358

My appologies.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-02-04 16:53 elklein        New Bug                                      
07-02-04 16:53 elklein        Distribution              => Red Hat Enterprise Linux
07-02-04 16:53 elklein        Kernel Version            => 2.4.21-15.0.2   
07-02-04 16:54 elklein        Bugnote Added: 0001375                       
07-04-04 12:54 perex          duplicate_id             0 => 358            
07-04-04 12:54 perex          Resolution               open => duplicate   
07-04-04 12:54 perex          Status                   assigned => resolved
09-24-04 13:38 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
