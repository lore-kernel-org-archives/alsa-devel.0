From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001092]: Low volume output with snd-i8x0
Date: Sun, 8 May 2005 19:51:27 +0200
Message-ID: <59f2c075205b9c7b17e0c320c30ad0f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 690D125E
	for <alsa-devel@alsa-project.org>; Sun,  8 May 2005 19:51:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1092> 
======================================================================
Reported By:                haYnguy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1092
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6
======================================================================
Date Submitted:             05-06-2005 22:49 CEST
Last Modified:              05-08-2005 19:51 CEST
======================================================================
Summary:                    Low volume output with snd-i8x0
Description: 
Whenever I want to listen to anything, the volume is extremely low.
Everything is supported, plugged in, turned on, turned up, and still the
volume is very low. I can only hear it when I put the speaker to my ear,
and still it is quite faint.
======================================================================

----------------------------------------------------------------------
 haYnguy - 05-07-05 18:46 
----------------------------------------------------------------------
amixer output:

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 29 [94%] [on]
Simple mixer control 'Headphone Jack Sense',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 16 [52%] [on]
  Front Right: Playback 16 [52%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Line Jack Sense',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

----------------------------------------------------------------------
 jdthood - 05-08-05 19:51 
----------------------------------------------------------------------
> Simple mixer control 'PCM',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 31
>   Front Left: Playback 16 [52%] [on]
>   Front Right: Playback 16 [52%] [on]

Does it help to increase this level?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 22:49 haYnguy        New Issue                                    
05-06-05 22:49 haYnguy        Kernel Version            => 2.6             
05-06-05 23:02 haYnguy        Note Added: 0004599                          
05-07-05 09:47 jdthood        Note Added: 0004601                          
05-07-05 18:46 haYnguy        Note Added: 0004606                          
05-08-05 19:51 jdthood        Note Added: 0004613                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
