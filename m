From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001634]: lack of mmap support with ice1724
Date: Mon, 20 Mar 2006 11:47:36 +0100
Message-ID: <3a1779298991d8524d5adabbfee77970@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 154BC1CD
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 11:47:37 +0100 (MET)
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
Last Modified:              03-20-2006 11:47 CET
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

----------------------------------------------------------------------
 joecool - 03-20-06 06:03 
----------------------------------------------------------------------
no, that won't fix it.  First of all the /proc layout is different now and
more importantly that solution never worked for this card.  I doubt you
also have a Revolution 7.1 or even a card with ice1724 and then tried to
use that solution.

Anyways, thanks for trying to help, but it'll take more then that in this
case :P

----------------------------------------------------------------------
 tiwai - 03-20-06 11:47 
----------------------------------------------------------------------
It's not supported.  See OSS-Emulation.txt.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
