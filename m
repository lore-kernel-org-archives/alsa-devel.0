From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001330]: alsa-driver fails "make install"
Date: Sat, 13 Aug 2005 00:27:17 +0200
Message-ID: <79da7e76d20c5d3293ceb1c01be4d89e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 202C51AB
	for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2005 00:27:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1330> 
======================================================================
Reported By:                jcdutton
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1330
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-13-2005 00:07 CEST
Last Modified:              08-13-2005 00:27 CEST
======================================================================
Summary:                    alsa-driver fails "make install"
Description: 
See output below.
Does anyone have a clew how to fix this?


alsa-driver # make install
find /lib/modules/2.6.13-rc5/kernel/sound -name 'snd*.*o' | xargs rm -f
make[1]: Entering directory `/u/alsacvs/alsa-driver/acore'
make[1]: *** No rule to make target `modules_install'.  Stop.
make[1]: Leaving directory `/u/alsacvs/alsa-driver/acore'
make: *** [install-modules] Error 1



======================================================================

----------------------------------------------------------------------
 jcdutton - 08-13-05 00:27 
----------------------------------------------------------------------
The attached "make-it-work.diff.txt" is a diff from the current cvs to an
older cvs version. Applying this diff lets if work again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 00:07 jcdutton       New Issue                                    
08-13-05 00:26 jcdutton       File Added: make-it-work.diff.txt                 
  
08-13-05 00:27 jcdutton       Note Added: 0005792                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
