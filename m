From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002321]: no audio and very few mixer
	options with C-Media 106 based USB sound card
Date: Tue, 1 Aug 2006 16:43:43 +0200
Message-ID: <46f9a6dffb0cba6563bd554c8c3bc758@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B521118D
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 16:43:43 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2321> 
======================================================================
Reported By:                doobedoobedo
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2321
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14/5
======================================================================
Date Submitted:             08-01-2006 16:43 CEST
Last Modified:              08-01-2006 16:43 CEST
======================================================================
Summary:                    no audio and very few mixer options with C-Media 106
based USB sound card
Description: 
no audio output with the snd-usb-audio module

amixer output:
Simple mixer control 'PCM',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4095
  Front Left: Capture 2048 [50%] [on]
  Front Right: Capture 2048 [50%] [on]
Simple mixer control 'PCM Capture Source',0
  Capabilities: enum
  Items: 'Mic' 'Input 1' 'Input 2' 'Mixer'
  Item0: 'Mic'
Simple mixer control 'PCM',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4095
  Front Left: Capture 2048 [50%]
  Front Right: Capture 2048 [50%]
Simple mixer control 'Mic',0
  Capabilities: pvolume cvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 8191 Capture 0 - 4095
  Front Left: Playback 2048 [25%] [off] Capture 2048 [50%]
  Front Right: Playback 2048 [25%] [off] Capture 2048 [50%]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 8191
  Mono:
  Front Left: Playback 2048 [25%] [on]
  Front Right: Playback 2048 [25%] [on]
Simple mixer control 'Speaker',1
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 37
  Mono: Playback 15 [41%] [on]

speaker 0 and mic will only decrease in volume in alsamixer, although no
sound is played trough the speakers at all.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-06 16:43 doobedoobedo   New Issue                                    
08-01-06 16:43 doobedoobedo   Distribution              => Gentoo          
08-01-06 16:43 doobedoobedo   Kernel Version            => 2.6.14/5        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
