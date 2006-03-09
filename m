From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000919]: Master volume doesn't control rear speakers...
Date: Thu, 9 Mar 2006 11:35:21 +0100
Message-ID: <b59e127a96a0564565fe288bf0625379@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64FAF128
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2006 11:35:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=919> 
======================================================================
Reported By:                adamk75
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   919
Category:                   2_mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             02-18-2005 12:41 CET
Last Modified:              03-09-2006 11:35 CET
======================================================================
Summary:                    Master volume doesn't control rear speakers...
Description: 
If I adjust the master volume in alsamixer, the rear speaker volume isn't
affected at all.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000154 Master volume only controls front outpu...
related to          0000172 Master volume control only controls fro...
======================================================================

----------------------------------------------------------------------
 tiwai - 02-18-05 15:02 
----------------------------------------------------------------------
Also, this register controls the master volume of the mixing among PCM and
input signals from Line, Mic, etc (although its output is routed only to
Front).

----------------------------------------------------------------------
 muffty - 03-09-06 11:35 
----------------------------------------------------------------------
Please, take a look at
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172. I added a
possible solution there.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-05 12:41 adamk75        New Issue                                    
02-18-05 13:00 tiwai          Note Added: 0003650                          
02-18-05 13:06 adamk75        Note Added: 0003651                          
02-18-05 14:32 tiwai          Note Added: 0003652                          
02-18-05 14:41 adamk75        Note Added: 0003653                          
02-18-05 15:00 tiwai          Note Added: 0003654                          
02-18-05 15:02 tiwai          Note Added: 0003655                          
02-22-05 09:56 perex          Relationship added       related to 0000154  
02-22-05 09:57 perex          Relationship added       related to 0000172  
02-22-05 09:57 perex          Status                   new => assigned     
02-22-05 09:57 perex          Assigned To               => perex           
02-22-05 09:58 perex          Project                  ALSA - driver => ALSA -
lib
02-22-05 09:58 perex          Severity                 major => feature    
02-22-05 09:58 perex          Category                 PCI - ymfpci => mixer
02-22-05 09:58 perex          Description Updated                          
02-22-05 09:58 perex          Steps to Reproduce Updated                    
03-09-06 11:35 muffty         Note Added: 0008389                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
