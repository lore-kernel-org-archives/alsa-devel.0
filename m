From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002011]: alsa-lib compiler warnings using gcc 4.0.2 (fix attached)
Date: Fri, 7 Apr 2006 17:34:51 +0200
Message-ID: <890ca504bb5f66053cf5f6d191cc88ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA152157
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 17:34:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2011> 
======================================================================
Reported By:                wille
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2011
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-07-2006 16:29 CEST
Last Modified:              04-07-2006 17:34 CEST
======================================================================
Summary:                    alsa-lib compiler warnings using gcc 4.0.2 (fix
attached)
Description: 
The gcc 4.0.2 compiler generates serveral warning messages while building
alsa-lib-1.0.10.  These warnings are a result of mismatched pointer types,
unused parameters, and unused variables, etc.  I've attached a patch file
to correct these problems.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-07-06 17:34 
----------------------------------------------------------------------
We can't fix an old release, please regenerate the patch against the latest
CVS sources

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 16:29 wille          New Issue                                    
04-07-06 16:29 wille          File Added:
alsa-lib-1.0.10-gcc4.0.2-compiler-warnings.patch                    
04-07-06 17:34 rlrevell       Note Added: 0009140                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
