From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001329]: input part of kmix don't show any settings
Date: Tue, 8 Nov 2005 15:55:06 +0100
Message-ID: <84a7ef8639249ef45910a4d54f22d013@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2164E1C0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 15:55:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1329> 
======================================================================
Reported By:                submax82
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1329
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               debian
Kernel Version:             2.6.12.4
======================================================================
Date Submitted:             08-12-2005 14:59 CEST
Last Modified:              11-08-2005 15:55 CET
======================================================================
Summary:                    input part of kmix don't show any settings
Description: 
The input section of kmix, on kde, do not show any settings: cd, line-in,
mic ecc... Those are not present! This is big lack!
======================================================================

----------------------------------------------------------------------
 jcdutton - 09-10-05 10:43 
----------------------------------------------------------------------
I think you need a more up to date version of alsa-driver.
Version 1.0.9b or above should work.

----------------------------------------------------------------------
 roadrunner - 11-08-05 15:55 
----------------------------------------------------------------------
Still nothing in input part of kmix with alsa 1.0.10rc3:
alsamixer shows only some switches in the capture view.
The only volume control that controls an input is 'CAPTURE feedback'. It
is displayed as output control, although it controls the recording volume
for line-in / mic.

> cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc3.
Compiled on Nov  8 2005 for kernel 2.4.21-297-default with versioned
symbols

> cat /proc/asound/cards
0 [CA0106         ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0410] at 0xd400 irq 5

> amixer
Simple mixer control 'Mic/Line in Capture',0
  Capabilities: enum
  Items: 'Line in' 'Mic in'
  Item0: 'Line in'
Simple mixer control 'AC97 in',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Analog Center/LFE',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'Analog Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 154 [60%]
  Front Right: Playback 154 [60%]
Simple mixer control 'Analog Rear',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'Analog Side',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'CAPTURE feedback',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'SPDIF Center/LFE',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'SPDIF Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'SPDIF Out',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'SPDIF Rear',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'SPDIF Unknown',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
Simple mixer control 'SPDIF in',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'SPDIF out',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'SRC out',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'i2s in',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'i2s mixer out',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-12-05 14:59 submax82       New Issue                                    
08-12-05 14:59 submax82       Distribution              => debian          
08-12-05 14:59 submax82       Kernel Version            => 2.6.12.4        
08-13-05 01:51 jcdutton       Note Added: 0005799                          
08-13-05 01:51 jcdutton       Status                   assigned => feedback
08-13-05 14:29 submax82       Note Added: 0005805                          
08-13-05 14:49 submax82       Note Edited: 0005805                         
08-17-05 16:58 submax82       Note Added: 0005838                          
09-10-05 10:43 jcdutton       Note Added: 0006111                          
11-08-05 15:55 roadrunner     Note Added: 0006621                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
