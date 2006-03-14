From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001631]: Audiophile USB will not capture.
Date: Tue, 14 Mar 2006 17:17:56 +0100
Message-ID: <384ffb27ae1aaf7ad6cd3b751f8596c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 101731C3
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 17:17:57 +0100 (MET)
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


The following issue has been marked as UNRELATED TO issue 0001890.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1631> 
======================================================================
Reported By:                smithbone
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1631
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               1.0.10
Kernel Version:             2.6.15-rc5-git1
======================================================================
Date Submitted:             12-08-2005 17:38 CET
Last Modified:              03-14-2006 17:17 CET
======================================================================
Summary:                    Audiophile USB will not capture.
Description: 
If I try to capure audio from my Audiophile USB I get the following.

 $ arecord -vv -D hw:1,1 -f S24_3BE -t raw -c 2 -r48000 test.raw
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S24_3BE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 24
buffer_size  : 24000
period_size  : 6000
period_time  : 125000
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 1
stop_threshold   : 24000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000
arecord: pcm_read:1303: read error: Input/output error
======================================================================

----------------------------------------------------------------------
 sander - 12-23-05 18:40 
----------------------------------------------------------------------
I mailed this analysis to the alsa-devel list two months ago. It seems to
have found a nice home here :)


SUMMARY:

- only 48001-96000hz capturing works
- only capturing through plughw:x,1 works
- format is 24/32 bits regardless of plug conversion (? at least, as
reported by audacity)
- only the signal on the jack inputs is captured
- only 2-channel capture
- only the SYNC/48001-96000/S24_3BE altset on device #1 can be captured,
only through plughw.


signal (from the jacks, not the cinch connectors)
-------------------------------------------------

s1) arecord -D plughw:0,1 -t wav -c 2 -r 96000 -f S16_LE -d 2 -vv test.wav

- output :
Plug PCM: Linear conversion PCM (S24_3BE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
- audacity reports 24b/96khz
- amplitude suspects 24 bit sound despite S16_LE setting
- altset reportedly used :
    Format: S24_3BE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 48001 - 96000 (continuous)
- see (n1) and (e3)

s2) arecord -D plughw:0,1 -t wav -c 2 -r 96000 -f S32_LE -d 2 -vv
test.wav
- output :
Plug PCM: Linear conversion PCM (S24_3BE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S32_LE
- audacity reports 32b/96khz
- altset used same as (s1)


no signal
---------

n1) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f S24_3BE -d 2 -vv
test.raw
- output :
Plug PCM: Hardware PCM card 0 'Audiophile USB (tm)' device 1 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S24_3BE

n2) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f S24_LE -d 2 -vv
test.raw
n3) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f S24_3LE -d 2 -vv
test.raw
n4) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f U24_3LE -d 2 -vv
test.raw
n5) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f U24_3BE -d 2 -vv
test.raw

errors/'lock'
-------------

e1) arecord -D plughw:0,1 -t raw -c 2 -r 48000 -f S16_LE -d 2 -vv
test.raw
- output :
Plug PCM: Linear conversion PCM (S16_BE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE

e2) arecord -D plughw:0,1 -t raw -c 2 -r 48000 -f S16_BE -d 2 -vv
test.raw
- output :
Plug PCM: Hardware PCM card 0 'Audiophile USB (tm)' device 1 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_BE

e3) arecord -D plughw:0,0 -t wav -c 2 -r 96000 -f S16_LE -d 2 -vv
test.wav
e3) arecord -D plughw:0,1 -t wav -c 1 -r 96000 -f S16_LE -d 2 -vv test.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-05 17:38 smithbone      New Issue                                    
12-08-05 17:38 smithbone      Distribution              => 1.0.10          
12-08-05 17:38 smithbone      Kernel Version            => 2.6.15-rc5-git1 
12-23-05 18:40 sander         Note Added: 0007135                          
03-14-06 17:17 rlrevell       Relationship added       related to 0001890  
03-14-06 17:17 rlrevell       Relationship deleted     related to 0001890  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
