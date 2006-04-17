From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002025]: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio lacks support for microphone
Date: Mon, 17 Apr 2006 16:11:08 +0200
Message-ID: <796de811182636d0d3a250cff4be7cdf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E78A5159
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 16:11:08 +0200 (MEST)
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
Last Modified:              04-17-2006 16:11 CEST
======================================================================
Summary:                    Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio lacks support for microphone
Description: 
The speakers to works but the microphone is always on i.e. it always
captures sound and produces acoustic feedback.
======================================================================

----------------------------------------------------------------------
 tbecker37 - 04-17-06 14:43 
----------------------------------------------------------------------
I can confirm this with the Intel 82801G (ICH7 Family) as well (STAC 9200
codec).    See bug # 1988.  Here's my amixer output:

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 8 [26%] [on]
  Front Right: Playback 8 [26%] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [off]
  Front Right: Capture 0 [0%] [off]
Simple mixer control 'Capture Mux',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 4
  Front Left: 4 [100%]
  Front Right: 4 [100%]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic'
  Item0: 'Mic'

----------------------------------------------------------------------
 rlrevell - 04-17-06 16:11 
----------------------------------------------------------------------
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [off]
  Front Right: Capture 0 [0%] [off]

You must unmute this control and raise volume for the mic to work

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
