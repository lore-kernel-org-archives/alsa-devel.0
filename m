From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001960]: Compilation warning in control_compat.c
Date: Wed, 29 Mar 2006 19:03:25 +0200
Message-ID: <9747e22b5c764cad35ef78e0ef1d6265@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 90D2A173
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 19:03:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1960> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1960
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.15-rc1-kj1
Resolution:                 duplicate
Duplicate:                  1959
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2006 21:02 CET
Last Modified:              03-29-2006 19:03 CEST
======================================================================
Summary:                    Compilation warning in control_compat.c
Description: 
I've compiled the new alsa-driver-1.0.11rc4 and got a warning message:

/alsa-kernel/core/control_compat.c: In function
&#8216;copy_ctl_value_from_user&#8217;:
/alsa-kernel/core/control_compat.c:222: warning: &#8216;count&#8217; may
be used uninitialized in this function


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001959 Compilation warning in control_compat.c
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 21:02 Henne          New Issue                                    
03-24-06 21:02 Henne          Distribution              => Suse 10.0 x86_64
03-24-06 21:02 Henne          Kernel Version            => 2.6.15-rc1-kj1  
03-29-06 19:03 tiwai          Relationship added       duplicate of 0001959
03-29-06 19:03 tiwai          Duplicate ID             0 => 1959           
03-29-06 19:03 tiwai          Status                   assigned => resolved
03-29-06 19:03 tiwai          Resolution               open => duplicate   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
