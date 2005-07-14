From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001251]: emagic a62m: maybe bug: arecord doesn't record anything, jack+jackrec work
Date: Thu, 14 Jul 2005 11:02:23 +0200
Message-ID: <2bdf94a021c3a5befc04c235a8e95fe7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F10D17C
	for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2005 11:02:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1251> 
======================================================================
Reported By:                Robert_Schulze
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1251
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-11-2005 14:39 CEST
Last Modified:              07-14-2005 11:02 CEST
======================================================================
Summary:                    emagic a62m: maybe bug: arecord doesn't record
anything, jack+jackrec work
Description: 
When I want to record something from my emi a62m audiointerface, arecord
doesn't work:

"arecord -D emi -f cd > test.wav"
when issuing "aplay -vvv test.wav", the histogram shows up a permanent
peak of 36% during the whole file, no sound hearable.

Starting "jackd -d alsa -D emi" and issuing "jackrec -f test.wav -d 5
alsa_pcm:capture_1 alsa_pcm:capture_2" does record a valid file.

.asoundrc:

pcm.emi 
 {
 type hw
 card 1 
 }

ctl.emi
 {
 type hw
 card 1
 }

Card 0 is a solo1.
======================================================================

----------------------------------------------------------------------
 Robert_Schulze - 07-12-05 17:29 
----------------------------------------------------------------------
While nothing runs:

Emagic GmbH Emagic EMI 6|2 m at usb-0000:00:07.2-1.1, full speed : USB
Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 6
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 6
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000
  Interface 2
    Altset 4
    Format: S24_3LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000

------------------------------------------------------------------------------
While jackd runs:

Emagic GmbH Emagic EMI 6|2 m at usb-0000:00:07.2-1.1, full speed : USB
Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 1
    URBs = 5 [ 1 1 1 1 1 ]
    Packet Size = 243
    Momentary freq = 48000 Hz
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000

Capture:
  Status: Running
    Interface = 2
    Altset = 1
    URBs = 5 [ 1 1 1 1 1 ]
    Packet Size = 588
    Momentary freq = 48000 Hz
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 6
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 6
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000
  Interface 2
    Altset 4
    Format: S24_3LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000

-------------------------------------------------------------------------------
while arecord runs:

Emagic GmbH Emagic EMI 6|2 m at usb-0000:00:07.2-1.1, full speed : USB
Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000

Capture:
  Status: Running
    Interface = 2
    Altset = 3
    URBs = 5 [ 1 1 1 1 1 ]
    Packet Size = 243
    Momentary freq = 48000 Hz
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 6
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 6
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000
  Interface 2
    Altset 4
    Format: S24_3LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000

------------------------------------------------------------------------------

I tried both 24 bit, where alsa says that the device supports S24_3LE, and
16 bit (jackd ... --shorts). In both cases, jack works and arecord
doesn't.

One thing I realized: If I open the device capture-only with "jackd ...
-C", the recording results are equal to the results of pure arecord. Maybe
it has something to do with that.
You can see the difference in the sections above.

----------------------------------------------------------------------
 Clemens Ladisch - 07-14-05 11:02 
----------------------------------------------------------------------
The difference is that arecord uses two channels, while Jack records from
all six channels.

Please try the following arecord commands:

arecord -D emi -f S16_LE  -c 2 -r 96  > test_2_16_96.wav
arecord -D emi -f S24_3LE -c 2 -r 96  > test_2_24_96.wav
arecord -D emi -f S16_LE  -c 6 -r 48  > test_6_16_48.wav
arecord -D emi -f S24_3LE -c 6 -r 48  > test_6_24_48.wav

According to your tests so far, the last two should work.

What is the output of "xxd -g1 test_2_16_96.wav | head"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-05 14:39 Robert_Schulze New Issue                                    
07-11-05 16:20 Clemens LadischNote Added: 0005448                          
07-12-05 11:57 Robert_Schulze Note Added: 0005452                          
07-12-05 12:52 Clemens LadischNote Added: 0005453                          
07-12-05 17:29 Robert_Schulze Note Added: 0005456                          
07-14-05 11:02 Clemens LadischNote Added: 0005469                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
