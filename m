From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000070]: Sound driver loses synch
	during high cpu activity.
Date: Wed, 19 Jul 2006 10:23:33 +0200
Message-ID: <38fd4e3c09135e93682ac94acf854a35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 591DA224
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 10:23:33 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              07-19-2006 10:23 CEST
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
 fizban - 04-21-06 18:16 
----------------------------------------------------------------------
No, not really: I see this problem while playing videos in VLC with kernel
2.6.16 on my Thinkpad T22, which has

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM Unknown device 0153
        Flags: bus master, slow devsel, latency 64, IRQ 11
        Memory at e8122000 (32-bit, non-prefetchable) [size=4K]
        Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

----------------------------------------------------------------------
 Raymond - 07-19-06 10:23 
----------------------------------------------------------------------
The cs46xx DSP only has 64 voices 

For 4 channels
capture = 2 / 2 = 1 
front = ( 64 - 2 ) / 2 = 31
rear  = ( 64 - 2 ) / 2 = 31 

Why 6 channels still have 31 center lfe devices ?
capture    = 2 / 2 = 1
front      = ( 64 - 2 ) / 3 = 20
rear       = ( 64 - 2 ) / 3 = 20
center lfe = ( 64 - 2 ) / 3 = 20

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
04-21-06 18:16 fizban         Note Added: 0009423                          
07-19-06 10:23 Raymond        Note Added: 0011083                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
