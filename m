From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001350]: Could someone add spec files to the tarballs, please?
Date: Sat, 20 Aug 2005 16:45:51 +0200
Message-ID: <81c45d3cdf15e3e516c3370c3a6ecf41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EBEA418F
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2005 16:45:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1350> 
======================================================================
Reported By:                Vic
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1350
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-20-2005 16:37 CEST
Last Modified:              08-20-2005 16:45 CEST
======================================================================
Summary:                    Could someone add spec files to the tarballs,
please?
Description: 
Those of us using RPM-based distributions generally like to keep everything
within the RPM system.

By adding a simple .spec file to the tarball, that can be achieved by a
simple "rpmbuild -ta <tarball>". This is a fairly significant increase in
usability for almost no work.

The spec file I used for alsa-driver-1.0.9b is at
http://beer.org.uk/alsa-driver.spec . As you can see, keeping this file
up-to-date is very simple - just change the version number at the top of
the file.
======================================================================

----------------------------------------------------------------------
 Vic - 08-20-05 16:45 
----------------------------------------------------------------------
Just noticed - there is a file alsa-driver.spec.in in the utils directory
of the tarball. [N.B. this needs modifying for use with the current
version of rpmbuild - bug already submitted to RedHat].

If this could be cooked & put in the tarball, that would do the job
nicely!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-20-05 16:37 Vic            New Issue                                    
08-20-05 16:45 Vic            Note Added: 0005880                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
