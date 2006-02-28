From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001319]: MIDI I/O (MPU-401) works for output only, not input
Date: Wed, 1 Mar 2006 00:59:31 +0100
Message-ID: <7174df884f432ef3a5df4b43ccd2da97@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 477961CA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:59:31 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1319> 
======================================================================
Reported By:                roothorick
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1319
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-08-2005 05:38 CEST
Last Modified:              03-01-2006 00:59 CET
======================================================================
Summary:                    MIDI I/O (MPU-401) works for output only, not input
Description: 
I have a Sound Blaster PCI 512, and MIDI interfacing with external devices,
such as keyboards, only works for output (from the soundcard to other
devices). When I try to do input (from those devices to the soundcard) no
events get through at all.
======================================================================

----------------------------------------------------------------------
 roothorick - 08-12-05 16:38 
----------------------------------------------------------------------
Passing the option enable_ir=1 had no effect whatsoever.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:22 
----------------------------------------------------------------------
Any improvement in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 05:38 roothorick     New Issue                                    
08-11-05 14:31 tiwai          Note Added: 0005759                          
08-11-05 17:41 roothorick     Note Added: 0005761                          
08-12-05 15:53 tiwai          Note Added: 0005776                          
08-12-05 16:17 roothorick     Note Added: 0005779                          
08-12-05 16:30 Clemens LadischNote Added: 0005780                          
08-12-05 16:38 roothorick     Note Added: 0005781                          
12-30-05 23:22 rlrevell       Note Added: 0007286                          
03-01-06 00:59 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
