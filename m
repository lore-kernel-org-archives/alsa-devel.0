From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000058]: Amixer will not recognize SB Extigy
Date: Wed, 21 Sep 2005 22:54:58 +0200
Message-ID: <34ce3e4a8f07063430d111c17cebc527@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A75A916A
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2005 22:54:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=58> 
======================================================================
Reported By:                shraps
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   58
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.1
======================================================================
Date Submitted:             02-13-2004 04:53 CET
Last Modified:              09-21-2005 22:54 CEST
======================================================================
Summary:                    Amixer will not recognize SB Extigy
Description: 
No matter what I do, amixer/alsamixer cannot load the extigy card. 
However, other volume control programs can unmute and control the volume.

Errorcode:
amixer: Mixer load error: hw:1
======================================================================

----------------------------------------------------------------------
 perex - 06-08-05 18:09 
----------------------------------------------------------------------
Does this problem still exists in the current ALSA driver?

----------------------------------------------------------------------
 shraps - 09-21-05 22:54 
----------------------------------------------------------------------
Sorry for the late response...  I hadn't been running linux for a while.  I
recently put debian on one of my partitions and the alsa included in the
2.6.8 kernel seems to perform well with my extigy.  I can get sound out of
front right, front left, and center speakers (didn't test the two rear
speakers because they aren't hooked up here).  I also have no problems
seeing the extigy with amixer.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 04:53 shraps         New Issue                                    
02-20-04 18:40 Clemens LadischNote Added: 0000277                          
02-20-04 22:59 shraps         Note Added: 0000278                          
02-24-04 08:46 Clemens LadischNote Added: 0000301                          
02-24-04 22:50 shraps         Note Added: 0000306                          
02-25-04 10:10 Clemens LadischIssue Monitored: Clemens Ladisch                  
 
02-25-04 10:11 Clemens LadischNote Added: 0000312                          
02-25-04 22:33 shraps         Note Added: 0000326                          
02-26-04 16:18 Clemens LadischNote Added: 0000353                          
02-27-04 01:00 shraps         Note Added: 0000378                          
03-01-04 18:49 Clemens LadischNote Added: 0000414                          
03-01-04 18:49 Clemens LadischAssigned To              Clemens Ladisch => tiwai
03-02-04 04:38 shraps         Note Added: 0000430                          
03-04-04 18:47 tiwai          Note Added: 0000490                          
03-04-04 22:56 shraps         Note Added: 0000493                          
03-07-04 02:27 shraps         Note Added: 0000522                          
03-10-04 17:51 tiwai          Note Added: 0000564                          
03-11-04 17:07 shraps         Note Added: 0000572                          
06-08-05 18:09 perex          Note Added: 0004969                          
09-21-05 22:54 shraps         Note Added: 0006327                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
