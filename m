From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000058]: Amixer will not recognize SB Extigy
Date: Wed, 8 Jun 2005 18:09:13 +0200
Message-ID: <a499a87a15d31f359847198a031578d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 982B71DE
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 18:09:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=58> 
======================================================================
Reported By:                shraps
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   58
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.1
======================================================================
Date Submitted:             02-13-2004 04:53 CET
Last Modified:              06-08-2005 18:09 CEST
======================================================================
Summary:                    Amixer will not recognize SB Extigy
Description: 
No matter what I do, amixer/alsamixer cannot load the extigy card. 
However, other volume control programs can unmute and control the volume.

Errorcode:
amixer: Mixer load error: hw:1
======================================================================

----------------------------------------------------------------------
 shraps - 03-11-04 17:07 
----------------------------------------------------------------------
Stream0:

Playback:
  Status: Running
    Interface = 1
    Altset = 1
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 200
    Momentary freq = 48,000 Hz
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 12
    Format: S16_LE
    Channels: 3
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 13
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 14
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 15
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 16
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000





That is the output for the stream that is running.  

However,  this is what amixer -c1 outputs for Master:
Simple mixer control 'Master',1
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 200
  Mono: Playback 144 [72%]

----------------------------------------------------------------------
 perex - 06-08-05 18:09 
----------------------------------------------------------------------
Does this problem still exists in the current ALSA driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 04:53 shraps         New Issue                                    
02-20-04 18:40 Clemens LadischNote Added: 0000277                          
02-20-04 22:59 shraps         Note Added: 0000278                          
02-24-04 08:46 Clemens LadischNote Added: 0000301                          
02-24-04 22:50 shraps         Note Added: 0000306                          
02-25-04 10:10 Clemens LadischIssue Monitored: Clemens Ladisch                  
 
02-25-04 10:11 Clemens LadischNote Added: 0000312                          
02-25-04 22:33 shraps         Note Added: 0000326                          
02-26-04 16:18 Clemens LadischNote Added: 0000353                          
02-27-04 01:00 shraps         Note Added: 0000378                          
03-01-04 18:49 Clemens LadischNote Added: 0000414                          
03-01-04 18:49 Clemens LadischAssigned To              Clemens Ladisch => tiwai
03-02-04 04:38 shraps         Note Added: 0000430                          
03-04-04 18:47 tiwai          Note Added: 0000490                          
03-04-04 22:56 shraps         Note Added: 0000493                          
03-07-04 02:27 shraps         Note Added: 0000522                          
03-10-04 17:51 tiwai          Note Added: 0000564                          
03-11-04 17:07 shraps         Note Added: 0000572                          
06-08-05 18:09 perex          Note Added: 0004969                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
