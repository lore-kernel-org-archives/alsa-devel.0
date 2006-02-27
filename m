From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001874]: USB sound device appears to be loading properly, but all applications report the device is busy
Date: Mon, 27 Feb 2006 22:33:06 +0100
Message-ID: <729cbab1d901518fd7f60909ea4acd09@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F33BD194
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 22:33:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1874> 
======================================================================
Reported By:                oggb4mp3
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1874
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Arch Linux
Kernel Version:             2.6.15-archck4
======================================================================
Date Submitted:             02-24-2006 07:27 CET
Last Modified:              02-27-2006 22:33 CET
======================================================================
Summary:                    USB sound device appears to be loading properly, but
all applications report the device is busy
Description: 
I own a USB audio Device with a TI burr-brown DAC and with my recent
upgrade to 2.6.15-ck4, all apps report that the device is busy.  I found
this bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585 that
I thought might be the culprit, but when I tried to apply the patch, I
found that it was already applied.  I tried to reverse it, thinking that I
might have had one of the devices that worked without it and this patch
actually broke it, but no joy.

The device appears to be present as alsa device hw:1,0, the same as it
always was, and I can select it, but all apps report that it is busy or
blocked.  This all worked properly with a 2.6.14-ck kernel.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 02-27-06 18:22 
----------------------------------------------------------------------
What are the contents of /proc/asound/card1/stream0?

----------------------------------------------------------------------
 oggb4mp3 - 02-27-06 22:33 
----------------------------------------------------------------------
$ cat /proc/asound/card1/stream0
Burr-Brown from TI               USB Audio CODEC  at usb-0000:00:10.2-2,
full s : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000
  Interface 1
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000
  Interface 1
    Altset 3
    Format: S8
    Channels: 2
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000
  Interface 1
    Altset 4
    Format: S8
    Channels: 1
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000
  Interface 1
    Altset 5
    Format: U8
    Channels: 2
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000
  Interface 1
    Altset 6
    Format: U8
    Channels: 1
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 48000
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 48000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 44100
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 44100
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 32000
  Interface 2
    Altset 6
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 32000
  Interface 2
    Altset 7
    Format: S16_LE
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 22050
  Interface 2
    Altset 8
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 22050
  Interface 2
    Altset 9
    Format: S16_LE
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 10
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 11
    Format: S8
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 12
    Format: S8
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 13
    Format: S8
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 8000
  Interface 2
    Altset 14
    Format: S8
    Channels: 1
    Endpoint: 4 IN (ASYNC)
    Rates: 8000
  Interface 2
    Altset 15
    Format: S16_LE
    Channels: 2
    Endpoint: 4 IN (SYNC)
    Rates: 11025
  Interface 2
    Altset 16
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (SYNC)
    Rates: 11025
  Interface 2
    Altset 17
    Format: S8
    Channels: 2
    Endpoint: 4 IN (SYNC)
    Rates: 11025
  Interface 2
    Altset 18
    Format: S8
    Channels: 1
    Endpoint: 4 IN (SYNC)
    Rates: 11025

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-06 07:27 oggb4mp3       New Issue                                    
02-24-06 07:27 oggb4mp3       Distribution              => Arch Linux      
02-24-06 07:27 oggb4mp3       Kernel Version            => 2.6.15-archck4  
02-24-06 07:32 oggb4mp3       Note Added: 0008171                          
02-24-06 14:16 Clemens LadischNote Added: 0008175                          
02-24-06 15:00 oggb4mp3       Note Added: 0008177                          
02-24-06 15:32 Clemens LadischNote Added: 0008178                          
02-25-06 00:49 oggb4mp3       Note Added: 0008183                          
02-27-06 00:37 oggb4mp3       Note Added: 0008210                          
02-27-06 02:54 oggb4mp3       Note Added: 0008211                          
02-27-06 16:48 oggb4mp3       Note Added: 0008224                          
02-27-06 18:18 oggb4mp3       Note Added: 0008226                          
02-27-06 18:22 Clemens LadischNote Added: 0008227                          
02-27-06 22:33 oggb4mp3       Note Added: 0008232                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
