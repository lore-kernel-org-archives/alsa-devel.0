From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000548]: Format not supported by Webcam
Date: Tue, 28 Sep 2004 16:26:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928142627.67C5339006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CBBD230A
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 16:26:27 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000548
======================================================================
Reported By:                djtm
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     548
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8.1-ck6
======================================================================
Date Submitted:             09-28-2004 15:57 CEST
Last Modified:              09-28-2004 16:26 CEST
======================================================================
Summary:                    Format not supported by Webcam
Description: 
1 [webcam         ]: USB-Audio - USB Device 0x46d:0x8b4
                     USB Device 0x46d:0x8b4 at usb-0000:00:02.1-2, full
speed

Only supports: 16_le, 44100, mono.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 09-28-2004 16:13 CEST 
----------------------------------------------------------------------
Please show the contents of /proc/asound/card1/stream0.

edited on: 09-28-04 16:13

----------------------------------------------------------------------
 djtm - 09-28-2004 16:24 CEST 
----------------------------------------------------------------------
USB Device 0x46d:0x8b4 at usb-0000:00:02.1-2, full speed : USB Audio

Capture:
  Status: Running
    Interface = 2
    Altset = 2
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 46
    Momentary freq = 22050 Hz
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

These do work.
Though with:
"(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,02 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 1,87 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long.
(audioio-alsa3) warning! playback underrun - samples lost!  Break was at
least 0,01 ms long."
(ecasound)

48000, 32000 are not rejected, but played faster/slower than 44100.

----------------------------------------------------------------------
 djtm - 09-28-2004 16:26 CEST 
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-28-04 15:57 djtm           New Bug                                      
09-28-04 15:57 djtm           Distribution              => Debian          
09-28-04 15:57 djtm           Kernel Version            => 2.6.8.1-ck6     
09-28-04 16:13 Clemens LadischBugnote Added: 0001950                       
09-28-04 16:13 Clemens LadischBugnote Edited: 0001950                      
09-28-04 16:24 djtm           Bugnote Added: 0001952                       
09-28-04 16:26 djtm           Bugnote Added: 0001953                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
