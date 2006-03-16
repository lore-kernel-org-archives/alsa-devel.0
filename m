From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000405]: PCM playback causes hard freeze under kernel 2.6.x
Date: Thu, 16 Mar 2006 08:33:15 +0100
Message-ID: <93c08f97ccc8a60c6e4ed51886ffc330@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 918011FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:33:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=405> 
======================================================================
Reported By:                comac
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   405
Category:                   ISA - opl3sa2
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     acknowledged
Distribution:               Gentoo Linux
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-25-2004 20:07 CEST
Last Modified:              03-16-2006 08:33 CET
======================================================================
Summary:                    PCM playback causes hard freeze under kernel 2.6.x
Description: 
System freezes after a few seconds of playback thru integrated "OPL3-SA3
Snd System" (as reported by pnpdump) with any 2.6 kernel. (tested 2.6.0,
2.6.5, 2.6.7, 2.6.7-ck[15] and perhaps some other)

Problem shows up both with kernel alsa modules AND 1.0.5 modules compiled
from alsa-project tarballs. Worked flawlessly on 2.4.x on the same
system.

Playback time before freeze varies from a few seconds to a few minutes and
seems to be related to system or disk load. While playing, sound gets
distorted (seems to skip) when disk is accessed.

I've tried disabling preemptive, messing with PnP settings on BIOS and
checked the card has its own DMA and IRQ (not shared with anyone else)
without any success.

======================================================================

----------------------------------------------------------------------
 comac - 04-09-05 00:10 
----------------------------------------------------------------------
I've been trying 2.6.x kernels as they are released up to 2.6.11.5, using
the included alsa code. And all kernels have shown the same problem so
far.

Is there any combination of kernel + alsa I should try?

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:33 
----------------------------------------------------------------------
heyzuess, your problem sounds like a kernel/ACPI issue.

Any improvement with later ALSA/kernel releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-25-04 20:07 comac          New Issue                                    
07-25-04 20:07 comac          Distribution              => Gentoo Linux    
07-25-04 20:07 comac          Kernel Version            => 2.6.7           
07-28-04 02:57 heyzuess       Note Added: 0001479                          
04-08-05 22:27 jdthood        Note Added: 0004377                          
04-09-05 00:10 comac          Note Added: 0004380                          
04-09-05 04:19 jdthood        Status                   new => confirmed    
04-09-05 04:20 jdthood        Status                   confirmed => acknowledged
03-16-06 08:33 rlrevell       Note Added: 0008592                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
