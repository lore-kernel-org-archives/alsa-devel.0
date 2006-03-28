From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001970]: Applied dff from 1596 fixed high pitched whine out of left chael but on shutdown crashes computer
Date: Tue, 28 Mar 2006 04:16:20 +0200
Message-ID: <ee6c48abaf1c062466bdac6dc33e4ebf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EAE651A9
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 04:16:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1970> 
======================================================================
Reported By:                dlm1065
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1970
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             03-28-2006 04:16 CEST
Last Modified:              03-28-2006 04:16 CEST
======================================================================
Summary:                    Applied dff from 1596 fixed high pitched whine out
of left chael but on shutdown crashes computer
Description: 
I made an ebuild adding the diff from
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1596 to get d of the
whine.

Ebuild fixes whine but shutdown does NOT release a lock on some resource
and comp locks up
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 04:16 dlm1065        New Issue                                    
03-28-06 04:16 dlm1065        File Added: alsa-driver.tar.gz                    
03-28-06 04:16 dlm1065        Distribution              => Gentoo          
03-28-06 04:16 dlm1065        Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
