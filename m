From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002025]: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio lacks support for microphone
Date: Mon, 17 Apr 2006 22:45:25 +0200
Message-ID: <13ddf36ac3ac6d67e76e4850ad31517f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 696881AC
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 22:45:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2025> 
======================================================================
Reported By:                gegtot
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2025
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-16-2006 21:08 CEST
Last Modified:              04-17-2006 22:45 CEST
======================================================================
Summary:                    Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio lacks support for microphone
Description: 
The speakers to works but the microphone is always on i.e. it always
captures sound and produces acoustic feedback.
======================================================================

----------------------------------------------------------------------
 tbecker37 - 04-17-06 19:29 
----------------------------------------------------------------------
I did unmute and set volume to 100%.  Still no luck.

No I'm a dork.  I DID work. but recording from the MIC is very scratchy.
I've attached a short wav file to demonstrate.

BTW I'm using alsa-driver 1.0.11rc5

Setting the capture levels to about 75% solves the scratchyness.  

Thanks!



----------------------------------------------------------------------
 gegtot - 04-17-06 22:45 
----------------------------------------------------------------------
Used krecord at first. Krecord's feq spectrum shows some activity but
leaves no recording. No luck with arecord. BTW... I saw a post by tiwai
saying that this problem was solved in the cvs-version. I couldn't install
it because I didn't find "configure" in the driver dir. Is it really
missing or is it just me?


# amixer scontents

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 46 [72%] [on]
  Front Right: Playback 46 [72%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 230 [90%]
  Front Right: Playback 230 [90%]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 48 [75%] [on]
  Front Right: Playback 48 [75%] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 65
  Mono: Capture [off]
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 65
  Mono: Capture [off]
  Front Left: Playback 38 [58%] [on]
  Front Right: Playback 38 [58%] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 65
  Mono: Capture [off]
  Front Left: Playback 58 [89%] [on]
  Front Right: Playback 58 [89%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 65
  Mono: Capture [on]
  Front Left: Playback 31 [48%] [on]
  Front Right: Playback 31 [48%] [on]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 29 [45%] [on]
  Front Right: Playback 29 [45%] [on]
Simple mixer control 'Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 65
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 21 [60%] [on]
  Front Right: Capture 21 [60%] [on]

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-06 21:08 gegtot         New Issue                                    
04-16-06 21:27 gegtot         Issue Monitored: gegtot                      
04-16-06 21:28 gegtot         Note Added: 0009298                          
04-17-06 07:29 rlrevell       Note Added: 0009304                          
04-17-06 14:43 tbecker37      Note Added: 0009309                          
04-17-06 14:44 tbecker37      Issue Monitored: tbecker37                    
04-17-06 16:11 rlrevell       Note Added: 0009311                          
04-17-06 16:20 tbecker37      Note Added: 0009312                          
04-17-06 16:45 tbecker37      Note Edited: 0009312                         
04-17-06 16:46 tbecker37      File Added: test.wav                         
04-17-06 16:46 tbecker37      Note Edited: 0009312                         
04-17-06 19:29 tbecker37      Note Edited: 0009312                         
04-17-06 19:30 tbecker37      Issue End Monitor: tbecker37                    
04-17-06 22:45 gegtot         Note Added: 0009321                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
