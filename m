From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001304]: Speaker test hangs
Date: Fri, 12 Aug 2005 08:12:19 +0200
Message-ID: <30775fb1f7ce48327d639a7a3123ccbf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D6DBD211
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 08:12:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1304> 
======================================================================
Reported By:                herby
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1304
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-03-2005 02:46 CEST
Last Modified:              08-12-2005 08:12 CEST
======================================================================
Summary:                    Speaker test hangs
Description: 
After applying the patch to the library that took out the check for a
proper "start_threshold" (file .../alsa-lib/src/pcm/pcm.c around lines 834
or so), I attempted to try a speaker test again.  It hung right after
outputting "0 - Front Left".  I did an strace and the results are included
in the file attached.  I attempted to vary the sample rate (to 44.1 kHz)
with little luck.  The wierd thing is that I can execute 'aplay' (with the
default device) and get a '.wav' file to play nicely.  I can even get a
multi-channel (4 to be exact) ".wav" file to go thru 'aplay'.  Why
speaker-test doesn't work is beyond me.  The problem is that I appear to
use similar techniques in my own programming as speaker-test, and my
program doesen't do that well.  Being as how speaker-test IS part of ALSA,
I thought I would submit the bug report against it.

If other tests need be preformed, I'd be VERY happy to do them.
======================================================================

----------------------------------------------------------------------
 herby - 08-09-05 06:58 
----------------------------------------------------------------------
Now that I see the problem only happens on the Revo 7.1 card, do we
transfer it to that driver?  There are the attempts at trying speaker
test:
[tsw ~]$ speaker-test -c 2 -D plug:front:0  <<Attempting to use Revo 7.1
card>>

speaker-test 0.0.8

Playback device is plug:front:0
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 16 to 32768
Period size range from 8 to 16384
Periods = 4
Buffer time size 2525
To choose buffer_size = 15052
To choose period_size = 3763
was set period_size = 3764
was set buffer_size = 15052
 0 - Front Left
<interupt after waiting for sound to appear. No such luck!>


[tsw ~]$ speaker-test -c 2 -D plug:front:1   <<Using working motherboard
audio>>

speaker-test 0.0.8

Playback device is plug:front:1
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 16 to 16384
Period size range from 8 to 8192
Periods = 4
Buffer time size 2525
To choose buffer_size = 15052
To choose period_size = 3763
was set period_size = 3763
was set buffer_size = 15052
 0 - Front Left
 1 - Front Right
Time per period = 5.649939
 0 - Front Left
<interupted after success at generating white noise.  Works OK>

For reference:

[tsw ~]$ more /proc/asound/cards
0 [Revolution71   ]: ICE1724 - M Audio Revolution-7.1
                     M Audio Revolution-7.1 at 0xdc00, irq 10
1 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 with VT1616i at 0xd400, irq 5

Obviously there is a problem in the Revolution-7.1 software.  Is there any
hope?
Has the Revo 7.1 driver changed from version 1.0.9b to the present??

I'd like to get the Revo driver functional, as I've got a project that
uses it
(all 8 channels it really should be called a Revo 8.0!).

----------------------------------------------------------------------
 herby - 08-12-05 08:12 
----------------------------------------------------------------------
More info:
When speaker-test stalls (on the Revo 7.1) no interrupts get generated
(from /proc/interrupts).  When I use 'aplay' (which generates sound!),
interrupts get generated (go figure).  When I use the VIA 8233
(motherboard audio) speaker-test all goes well.  It seems that there is
something wierd in the buffer counts, or something on the Revo 7.1 card. 
Here is some data from /proc/asound/card0/pcm0p/sub0 that might help:
[tsw sub0]$ more *
::::::::::::::
hw_params
::::::::::::::
access: MMAP_INTERLEAVED
format: S32_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 3764
buffer_size: 15052
tick_time: 1000
::::::::::::::
info
::::::::::::::
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
::::::::::::::
prealloc
::::::::::::::
256
::::::::::::::
status
::::::::::::::
state: PREPARED
trigger_time: 0.000000000
tstamp      : 1123826957.287182000
delay       : 0
avail       : 3760
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 11292
::::::::::::::
sw_params
::::::::::::::
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 3764
xfer_align: 1
start_threshold: 15052
stop_threshold: 15052
silence_threshold: 0
silence_size: 0
boundary: 1972895744

(this was taken while the speaker-test was stalled out)

Hope this helps!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 02:46 herby          New Issue                                    
08-03-05 02:46 herby          File Added: speaker-trace                    
08-03-05 12:18 tiwai          Note Added: 0005621                          
08-04-05 03:21 herby          Note Added: 0005638                          
08-04-05 14:10 jcdutton       Note Added: 0005648                          
08-04-05 20:21 herby          Note Added: 0005652                          
08-09-05 06:58 herby          Note Added: 0005718                          
08-12-05 08:12 herby          Note Added: 0005765                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
