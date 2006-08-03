From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002321]: no audio and very few mixer
	options with C-Media 106 based USB sound card
Date: Thu, 3 Aug 2006 20:32:39 +0200
Message-ID: <a3e4e9a1eafa12d7ae7df8588889f37e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E965217E
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Aug 2006 20:32:39 +0200 (MEST)
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
Last Modified:              08-03-2006 20:32 CEST
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

----------------------------------------------------------------------
 rlrevell - 08-03-06 19:15 
----------------------------------------------------------------------
slave.pcm "snd-usb-audio"

is wrong, it should be something like

slave.pcm hw:0,0

(replace hw:0,0 with the correct device ID)

----------------------------------------------------------------------
 doobedoobedo - 08-03-06 20:32 
----------------------------------------------------------------------
Thanks for the suggestion 

$ cat .asoundrc
pcm.swapchannels {
    type route
    slave.pcm hw:1,0
    #slave.channels 6
    ttable.0.0 1
    ttable.1.1 1
    ttable.2.2 1
    ttable.3.3 1
    ttable.4.4 1
    ttable.5.5 1
}

$ aplay -D swapchannels sound/Surround-SDL-testfiles/chan-id.wav
ALSA lib conf.c:1587:(snd_config_load1) _toplevel_:49:0:Unexpected char
ALSA lib conf.c:2827:(snd_config_hook_load) /home/ron/.asoundrc may be old
or corrupted: consider to remove or fix it
ALSA lib conf.c:2691:(snd_config_hooks_call) function snd_config_hook_load
returned error: Invalid argument
ALSA lib conf.c:3054:(snd_config_update_r) hooks failed, removing
configuration
aplay: main:547: audio open error: Invalid argument

Then if I remove .asoundrc

$ aplay -c6 -D hw:1,0 sound/Surround-SDL-testfiles/chan-id.wav
Playing WAVE 'sound/Surround-SDL-testfiles/chan-id.wav' : Signed 16 bit
Little Endian, Rate 44100 Hz, Channels 6
aplay: set_params:906: Channels count non available

However the following works (albeit with swapped channels)

$ aplay -D plughw:1,0 sound/Surround-SDL-testfiles/chan-id.wav
Playing WAVE 'sound/Surround-SDL-testfiles/chan-id.wav' : Signed 16 bit
Little Endian, Rate 44100 Hz, Channels 6

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-06 16:43 doobedoobedo   New Issue                                    
08-01-06 16:43 doobedoobedo   Distribution              => Gentoo          
08-01-06 16:43 doobedoobedo   Kernel Version            => 2.6.14/5        
08-01-06 16:51 doobedoobedo   Issue Monitored: doobedoobedo                    
08-01-06 16:54 doobedoobedo   Note Added: 0011376                          
08-03-06 03:40 doobedoobedo   Note Added: 0011393                          
08-03-06 17:34 doobedoobedo   Note Added: 0011404                          
08-03-06 19:15 rlrevell       Note Added: 0011407                          
08-03-06 20:32 doobedoobedo   Note Added: 0011408                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
