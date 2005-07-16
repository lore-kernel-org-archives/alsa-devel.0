From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001261]: poor recording with emu10k1
Date: Sat, 16 Jul 2005 12:12:12 +0200
Message-ID: <439d3205cb0b2dac916485f624a10bab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A4C2C179
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 12:12:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1261> 
======================================================================
Reported By:                mal
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1261
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             all 2.6 versions
======================================================================
Date Submitted:             07-16-2005 09:28 CEST
Last Modified:              07-16-2005 12:12 CEST
======================================================================
Summary:                    poor recording with emu10k1
Description: 
Sound recording does not work right with emu10k1 on linux 2.6

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144940

This problem has ben an issue for a while. People can not use sound on
linux because of it.

======================================================================

----------------------------------------------------------------------
 mal - 07-16-05 11:09 
----------------------------------------------------------------------
Attached 
arecord -f cd t_cd.wav
Recording WAVE 't_cd.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

looks does not have a background noise



----------------------------------------------------------------------
 rlrevell - 07-16-05 12:12 
----------------------------------------------------------------------
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 1 [7%] [on]
  Front Right: Capture 1 [7%] [on]

Try setting this to 100%.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 09:28 mal            New Issue                                    
07-16-05 09:28 mal            Kernel Version            => all 2.6 versions
07-16-05 09:31 mal            Note Added: 0005485                          
07-16-05 09:49 rlrevell       Note Added: 0005486                          
07-16-05 10:32 mal            Note Added: 0005487                          
07-16-05 10:34 mal            Note Added: 0005488                          
07-16-05 10:38 mal            Note Added: 0005489                          
07-16-05 10:41 mal            File Added: tsts.wav                         
07-16-05 10:51 mal            File Added: t44100.wav                       
07-16-05 10:52 mal            Note Added: 0005490                          
07-16-05 10:53 mal            File Added: t44100_stereo.wav                    
07-16-05 11:00 mal            Note Added: 0005491                          
07-16-05 11:07 mal            File Added: t_cd.wav                         
07-16-05 11:08 mal            Note Added: 0005492                          
07-16-05 11:09 mal            Note Edited: 0005492                         
07-16-05 12:12 rlrevell       Note Added: 0005493                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
