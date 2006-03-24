From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001584]: Load rises to 100% when dmix is used with ICE1724 (SN25P)
Date: Fri, 24 Mar 2006 17:45:11 +0100
Message-ID: <a9285534cecf200e44a68caf807d936f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C2051CE
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 17:45:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1584> 
======================================================================
Reported By:                mr511
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1584
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             11-20-2005 20:33 CET
Last Modified:              03-24-2006 17:45 CET
======================================================================
Summary:                    Load rises to 100% when dmix is used with ICE1724
(SN25P)
Description: 
ALSA applications using the dmix plugin run at 100% load. Verified with
aplay, alsaplayer, xine, aoss+mpg123 and several others.

Approximately 1/3 of the load appears to be in user space, 2/3 in system
space.

Re-installing alsa-lib 1.0.8 makes the problem go away.
======================================================================

----------------------------------------------------------------------
 bambam - 02-19-06 17:05 
----------------------------------------------------------------------
I just want to confirm that this issue is still present with alsa-lib from
today's CVS and drivers from 2.6.16-rc4. My soundcard is intel8x0. It's
indeed a 64-bit kernel and 32-bit userspace problem and it affects all but
the async transfer methods used with both dmix and plughw (but not hw).
If you need any additional info, I'd be glad to help. This problem starts
to be very annoying because most players don't use the async method to
play sound.

----------------------------------------------------------------------
 bambam - 03-24-06 17:45 
----------------------------------------------------------------------
This has been solved in today's CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-20-05 20:33 mr511          New Issue                                    
11-21-05 14:37 mr511          Note Added: 0006771                          
11-21-05 21:43 mr511          Note Added: 0006777                          
12-17-05 20:16 rlrevell       Note Added: 0007067                          
12-17-05 23:37 mr511          Note Added: 0007068                          
02-19-06 17:05 bambam         Note Added: 0008135                          
03-24-06 17:45 bambam         Note Added: 0008930                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
