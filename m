From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000548]: Format not supported by Webcam
Date: Thu, 25 Nov 2004 14:23:09 +0100
Message-ID: <abcea2a22bf43c9d64552c796d1c6fb8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 95F041DC
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2004 14:23:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=548> 
======================================================================
Reported By:                djtm
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   548
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8.1-ck6
======================================================================
Date Submitted:             09-28-2004 15:57 CEST
Last Modified:              11-25-2004 14:23 CET
======================================================================
Summary:                    Format not supported by Webcam
Description: 
1 [webcam         ]: USB-Audio - USB Device 0x46d:0x8b4
                     USB Device 0x46d:0x8b4 at usb-0000:00:02.1-2, full
speed

Only supports: 16_le, 44100, mono.
======================================================================

----------------------------------------------------------------------
 djtm - 09-28-04 16:26 
----------------------------------------------------------------------
(now with 48000khz)
ecasound -f 16,1,48000 -i:alsa,hw:1,0 -o:alsa,default -D

USB Device 0x46d:0x8b4 at usb-0000:00:02.1-2, full speed : USB Audio

Capture:
  Status: Running
    Interface = 2
    Altset = 1
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 90
    Momentary freq = 44100 Hz
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 44100
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 22050
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 11025
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 8000


(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 8,96 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 9,11 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 30,73 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 11,68 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 1,41 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 10,66 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 13,59 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 1,17 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 6,06 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,49 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 7,76 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 1,00 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 12,17 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 28,51 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 13,82 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.

Ecasound bug?

----------------------------------------------------------------------
 djtm - 11-25-04 14:23 
----------------------------------------------------------------------
ecasound -f 16,1,44100 -i:alsa,hw:1,0 -o:alsa,default -D
cat /proc/asound/card1/stream0
USB Device 0x46d:0x8b4 at usb-0000:00:02.0-2, full speed : USB Audio

Capture:
  Status: Running
    Interface = 2
    Altset = 1
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 90
    Momentary freq = 44100 Hz
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 44100
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 22050
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 11025
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 8000


and while getting 32000hz:
ecasound -f 16,1,32000 -i:alsa,hw:1,0 -o:alsa,default -D

cat /proc/asound/card1/stream0
USB Device 0x46d:0x8b4 at usb-0000:00:02.0-2, full speed : USB Audio

Capture:
  Status: Running
    Interface = 2
    Altset = 1
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 90
    Momentary freq = 44100 Hz
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 44100
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 22050
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 11025
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 8000

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-28-04 15:57 djtm           New Issue                                    
09-28-04 15:57 djtm           Distribution              => Debian          
09-28-04 15:57 djtm           Kernel Version            => 2.6.8.1-ck6     
09-28-04 16:13 Clemens LadischNote Added: 0001950                          
09-28-04 16:13 Clemens LadischNote Edited: 0001950                         
09-28-04 16:24 djtm           Note Added: 0001952                          
09-28-04 16:26 djtm           Note Added: 0001953                          
11-25-04 14:23 djtm           Note Added: 0002590                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
