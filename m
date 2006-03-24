From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001959]: Compilation warning in control_compat.c
Date: Fri, 24 Mar 2006 21:11:15 +0100
Message-ID: <2e883a4233b893496c415145d1cba25b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 338051D7
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 21:11:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1959> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1959
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-24-2006 20:58 CET
Last Modified:              03-24-2006 21:11 CET
======================================================================
Summary:                    Compilation warning in control_compat.c
Description: 
I've compiled the new alsa-driver-1.0.11rc4 and got a warning message:

/alsa-kernel/core/control_compat.c: In function
&#8216;copy_ctl_value_from_user&#8217;:
/alsa-kernel/core/control_compat.c:222: warning: &#8216;count&#8217; may
be used uninitialized in this function

I belive that this is a gcc-error (I use gcc version 4.0.2 20050901
(prerelease) (SUSE Linux)), since I looked at the code and  
======================================================================

----------------------------------------------------------------------
 Henne - 03-24-06 21:11 
----------------------------------------------------------------------
Please remove that. I posted it twice.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 20:58 Henne          New Issue                                    
03-24-06 21:11 Henne          Note Added: 0008937                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
