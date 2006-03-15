From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001849]: sound hangs after quarter of a second
Date: Wed, 15 Mar 2006 15:39:25 +0100
Message-ID: <931f9a3104a6422919e4d80eb9d607e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA1751EB
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 15:39:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1849> 
======================================================================
Reported By:                Marijn Schouten
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1849
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               gentoo
Kernel Version:             2.6.15
Resolution:                 duplicate
Duplicate:                  1807
Fixed in Version:           
======================================================================
Date Submitted:             02-16-2006 12:01 CET
Last Modified:              03-15-2006 15:39 CET
======================================================================
Summary:                    sound hangs after quarter of a second
Description: 
everything seems to work normally, until I actually try to get some sound.
Then it works for a very short time, then the driver hangs the program and
I get a repetition of the first sound produced ad infinitum. For example
speaker-test doesn't get to any "Time per period = 2.662410". Output stops
right before. 

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001807 Sound playback hangs and loops on first...
======================================================================

----------------------------------------------------------------------
 Marijn Schouten - 02-16-06 12:04 
----------------------------------------------------------------------
oops, this is a duplicate of bug 1807
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1807)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-06 12:01 Marijn SchoutenNew Issue                                    
02-16-06 12:01 Marijn SchoutenDistribution              => gentoo          
02-16-06 12:01 Marijn SchoutenKernel Version            => 2.6.15          
02-16-06 12:04 Marijn SchoutenNote Added: 0008094                          
03-15-06 15:39 tiwai          Relationship added       duplicate of 0001807
03-15-06 15:39 tiwai          Duplicate ID             0 => 1807           
03-15-06 15:39 tiwai          Status                   assigned => resolved
03-15-06 15:39 tiwai          Resolution               open => duplicate   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
