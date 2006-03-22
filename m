From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000070]: Sound driver loses synch during high cpu activity.
Date: Wed, 22 Mar 2006 03:33:20 +0100
Message-ID: <ba150ba0a8ffd8a1b47f5ead66806f01@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 933971A0
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:33:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=70> 
======================================================================
Reported By:                mystica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   70
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Slackware Linux 9.1 (with Dropline Gnome and extra
software installed manually)
Kernel Version:             2.4.23-mywin4lin-xfs-v4l2 (currently, but also
2.6.1-mywin4lin as well)
======================================================================
Date Submitted:             02-18-2004 07:36 CET
Last Modified:              03-22-2006 03:33 CET
======================================================================
Summary:                    Sound driver loses synch during high cpu activity.
Description: 
About half the time I am playing a video with mplayer/xine or sometimes
even during periods of high cpu activity not caused by video (compiling a
program and listening to music for example) the audio will stop playing
back, sound like static for a few seconds, and then restart about 30
seconds (in the source) after it lost continuity/synch. If its in a video,
the video will then play back as fast as it can to meet back up with the
audio, but if its an MP3 it just keeps playing normally from where it
re-synchs.

======================================================================

----------------------------------------------------------------------
 jdthood - 03-10-05 15:13 
----------------------------------------------------------------------
I still see "cs46xx: failure waiting for FIFO command to complete"
with the 1.0.8 drivers.

I haven't seen the other problem (of ALSA dropping 30 seconds of sound on
the floor) though.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:33 
----------------------------------------------------------------------
Any improvement in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-04 07:36 mystica        New Issue                                    
02-18-04 07:40 mystica        Note Added: 0000263                          
02-22-04 15:24 bheung         Issue Monitored: bheung                      
03-02-04 08:36 mystica        Note Added: 0000431                          
03-09-04 08:36 mystica        Note Added: 0000538                          
03-09-04 15:20 tiwai          Note Added: 0000548                          
03-11-04 08:06 mystica        Note Added: 0000568                          
03-16-04 11:38 mystica        Note Added: 0000625                          
03-10-05 15:13 jdthood        Note Added: 0003858                          
09-22-05 14:59 jdthood        Status                   new => acknowledged 
03-22-06 03:33 rlrevell       Note Added: 0008823                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
