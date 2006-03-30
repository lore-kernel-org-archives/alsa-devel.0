From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001634]: lack of mmap support with ice1724
Date: Thu, 30 Mar 2006 16:17:43 +0200
Message-ID: <f02356c36f5d4a0042026d5d77782468@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 60712175
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 16:17:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1634> 
======================================================================
Reported By:                joecool
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1634
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.14-mm2
======================================================================
Date Submitted:             12-10-2005 09:02 CET
Last Modified:              03-30-2006 16:17 CEST
======================================================================
Summary:                    lack of mmap support with ice1724
Description: 
I've dug around for awhile now as to why my m-audio revolution 7.1 doesn't
work on enemy-territory because of an mmap error, and came to the
conclusion it must be because there is no working mmap support.  So
everything needs to run through arts, which is a poor, high-latency
workaround to a major problem.

This is a confirmable bug that 2 seconds of googling will pull up results.
 I do not want to hear of using a sound server (artsd, esd, jackd, etc.)
as a workaround.  However, if the mmap support can be emulated driver
level, then that would be fine.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001940 enemy territory has no sound on ICE1724
======================================================================

----------------------------------------------------------------------
 oscar - 03-30-06 09:40 
----------------------------------------------------------------------
Does it mean, "it's not supported and never will be"?

Should I be looking for another sound solution?

btw, the recommended documentation says 1712 doesn't do it. I doesn't
mention ice1724.

----------------------------------------------------------------------
 tiwai - 03-30-06 16:17 
----------------------------------------------------------------------
ICE1724 doesn't provide 16bit samples, so you cannot mmap the buffer to the
apps which accept only S16 bit format.  Thus, there is no good solution in
the kernel emulation at all.

We may need some workaround for this kind of problem on aoss user-space
wrapper, though.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 09:02 joecool        New Issue                                    
12-10-05 09:02 joecool        Distribution              => Gentoo Linux    
12-10-05 09:02 joecool        Kernel Version            => 2.6.14-mm2      
01-15-06 02:02 joecool        Issue Monitored: joecool                     
03-18-06 00:21 oscar          Note Added: 0008665                          
03-20-06 06:03 joecool        Note Added: 0008708                          
03-20-06 11:47 tiwai          Note Added: 0008713                          
03-29-06 19:24 tiwai          Relationship added       has duplicate 0001940
03-30-06 09:40 oscar          Note Added: 0009023                          
03-30-06 09:58 oscar          Issue Monitored: oscar                       
03-30-06 16:17 tiwai          Note Added: 0009035                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
