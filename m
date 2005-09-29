From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001092]: Low volume output with snd-i8x0
Date: Thu, 29 Sep 2005 12:05:30 +0200
Message-ID: <7a5dab1f2650bca7949effa49e1ec0c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36340CB
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:05:30 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000101.
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
Last Modified:              09-29-2005 12:05 CEST
======================================================================
Summary:                    Low volume output with snd-i8x0
Description: 
Whenever I want to listen to anything, the volume is extremely low.
Everything is supported, plugged in, turned on, turned up, and still the
volume is very low. I can only hear it when I put the speaker to my ear,
and still it is quite faint.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000101 SiS7012 LineIn low loudness
======================================================================

----------------------------------------------------------------------
 haYnguy - 05-06-05 23:02 
----------------------------------------------------------------------
this is my lsmod output:

Module                  Size  Used by
snd_pcm_oss            56224  0
snd_mixer_oss          18816  1 snd_pcm_oss
snd_seq_oss            33408  0
snd_seq_midi_event      6528  1 snd_seq_oss
snd_seq                54800  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          7308  2 snd_seq_oss,snd_seq
snd_intel8x0           29376  2
snd_ac97_codec         81272  1 snd_intel8x0
snd_pcm                92168  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              22788  2 snd_seq,snd_pcm
snd                    50788  13
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          8324  2 snd_intel8x0,snd_pcm

----------------------------------------------------------------------
 jdthood - 05-07-05 09:47 
----------------------------------------------------------------------
Please send the output of the amixer command.

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

----------------------------------------------------------------------
 haYnguy - 05-10-05 03:25 
----------------------------------------------------------------------
i did but it is still very low... (still in the same situation)

----------------------------------------------------------------------
 tiwai - 05-24-05 12:18 
----------------------------------------------------------------------
Try to turn off 'Headphone Jack Sense' and 'Line Jack Sense' switches.
If this doesn't work, I would suspect a hardware problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 22:49 haYnguy        New Issue                                    
05-06-05 22:49 haYnguy        Kernel Version            => 2.6             
05-06-05 23:02 haYnguy        Note Added: 0004599                          
05-07-05 09:47 jdthood        Note Added: 0004601                          
05-07-05 18:46 haYnguy        Note Added: 0004606                          
05-08-05 19:51 jdthood        Note Added: 0004613                          
05-10-05 03:25 haYnguy        Note Added: 0004631                          
05-24-05 12:18 tiwai          Note Added: 0004715                          
09-29-05 12:05 jdthood        Relationship added       related to 0000101  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
