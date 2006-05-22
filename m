From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002145]: Quiet sound, no master channel, no PCM channel and no ability to switch to non-8ch mode
Date: Tue, 23 May 2006 01:51:19 +0200
Message-ID: <2380ae64bd8bc0a8e649f485eb060a7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4294222
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 01:51:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2145> 
======================================================================
Reported By:                rathann
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2145
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111_FC5 (SMP)
======================================================================
Date Submitted:             05-23-2006 00:22 CEST
Last Modified:              05-23-2006 01:51 CEST
======================================================================
Summary:                    Quiet sound, no master channel, no PCM channel and
no ability to switch to non-8ch mode
Description: 
1. Sound is very quiet. I need to set every channel to max to have decent
volume.
2. There's no master channel and there's no PCM channel.
3. There's a switch to change the number of output channels, but it has
only one option: 8ch (card supports 2-8ch).
======================================================================

----------------------------------------------------------------------
 rathann - 05-23-06 01:46 
----------------------------------------------------------------------
amixer output
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%]
  Front Right: Playback 255 [100%]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 63 [98%] [on]
  Front Right: Playback 63 [98%] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 63 [98%] [on]
  Front Right: Playback 63 [98%] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 63 [98%] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 63 [98%] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 63 [98%] [on]
  Front Right: Playback 63 [98%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 64 [98%] [on]
  Front Right: Playback 64 [98%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 35 [54%] [off]
  Front Right: Playback 35 [54%] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '8ch'
  Item0: '8ch'
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Line'
Simple mixer control 'Input Source',2
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'CD'

----------------------------------------------------------------------
 rlrevell - 05-23-06 01:51 
----------------------------------------------------------------------
There is definitely a PCM channel, but you're right about the lack of
Master and buggy Channel Mode switch.

Are you testing 1.0.11 or 1.0.11-rc2 (which comes with 2.6.16 kernel)?

Please post the contents of /proc/asound/card0/codec97#0/ac97#0-0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 00:22 rathann        New Issue                                    
05-23-06 00:22 rathann        Distribution              => Fedora Core 5   
05-23-06 00:22 rathann        Kernel Version            => 2.6.16-1.2111_FC5
(SMP)
05-23-06 00:39 rlrevell       Note Added: 0009920                          
05-23-06 01:46 rathann        Note Added: 0009921                          
05-23-06 01:51 rlrevell       Note Added: 0009922                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
