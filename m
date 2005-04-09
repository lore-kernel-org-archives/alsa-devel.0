From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000405]: PCM playback causes hard freeze under kernel 2.6.x
Date: Sat, 9 Apr 2005 04:19:42 +0200
Message-ID: <a61b7423ff0afe72cb131a1ca5f4bc1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4F73200
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 04:19:42 +0200 (MEST)
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


The following issue has been CONFIRMED.
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
Status:                     confirmed
Distribution:               Gentoo Linux
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-25-2004 20:07 CEST
Last Modified:              04-09-2005 04:19 CEST
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
 heyzuess - 07-28-04 02:57 
----------------------------------------------------------------------
I have the same problem - and tried everything to resolve it (re-compiled
the kernel about 20 times with different options each time) and I don't
think this is specific to alsa since it also happens with the OSS drivers
for me as well.

I'm using SB Live emu10k.

I can break the freeze by ssh'ing in from another box, then killing
whatever is trying to produce sound.

----------------------------------------------------------------------
 jdthood - 04-08-05 22:27 
----------------------------------------------------------------------
Was this problem solved in later ALSA releases?

----------------------------------------------------------------------
 comac - 04-09-05 00:10 
----------------------------------------------------------------------
I've been trying 2.6.x kernels as they are released up to 2.6.11.5, using
the included alsa code. And all kernels have shown the same problem so
far.

Is there any combination of kernel + alsa I should try?

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
