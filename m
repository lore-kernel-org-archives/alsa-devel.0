From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001959]: Compilation warning in control_compat.c
Date: Wed, 29 Mar 2006 18:59:54 +0200
Message-ID: <c6b147b3b54b939cd056cb09662cc211@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5453157
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 18:59:55 +0200 (MEST)
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2006 20:58 CET
Last Modified:              03-29-2006 18:59 CEST
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

----------------------------------------------------------------------
 tiwai - 03-29-06 18:59 
----------------------------------------------------------------------
This is a bogus warning from gcc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 20:58 Henne          New Issue                                    
03-24-06 21:11 Henne          Note Added: 0008937                          
03-29-06 18:59 tiwai          Status                   assigned => resolved
03-29-06 18:59 tiwai          Resolution               open => won't fix   
03-29-06 18:59 tiwai          Note Added: 0009005                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
