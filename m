From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001304]: Speaker test hangs
Date: Thu, 4 Aug 2005 20:21:54 +0200
Message-ID: <4582172d9b768dbaf8753bd08f8fa5f4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8206A1EE
	for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2005 20:21:54 +0200 (MEST)
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
Last Modified:              08-04-2005 20:21 CEST
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
 jcdutton - 08-04-05 14:10 
----------------------------------------------------------------------
This looks like a bug in the period/buffer size setting.
Buffer size range from 16 to 32768
Period size range from 8 to 16384
Periods = 4
Buffer time size 2525
To choose buffer_size = 15052
To choose period_size = 3763
was set period_size = 3764
was set buffer_size = 15052

Does not make valid sense.
If there are 4 periods, with period size of 3764, the buffer size should
be 15056 and not 15052.

Do you have similar problems with the other sound card?
E.g.
Card 0
speaker-test -c2 -Dplug:front:0
Card 1
speaker-test -c2 -Dplug:front:1

----------------------------------------------------------------------
 herby - 08-04-05 20:21 
----------------------------------------------------------------------
It seems that the problem is only on the Revolution 7.1 card, since it
hangs, and the motherboard audio (Via 8235) can generate the audio. 
Results of the tests:
<<<Revo 7.1 card test (card #0)>>>
[tsw ~]$ speaker-test -c2 -Dplug:front:0

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
<<<Hangs, aborted by interupt>>>

<<<Test using the Motherboard audio, card #1>>>
[tsw ~]$ speaker-test -c2 -Dplug:front:1

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
Time per period = 5.649717
 0 - Front Left
 1 - Front Right

<<<Audio cycles as intended>>>

Maybe it is the interaction between the Revo 7.1 driver and the speaker
test.  Any more test to be run??

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 02:46 herby          New Issue                                    
08-03-05 02:46 herby          File Added: speaker-trace                    
08-03-05 12:18 tiwai          Note Added: 0005621                          
08-04-05 03:21 herby          Note Added: 0005638                          
08-04-05 14:10 jcdutton       Note Added: 0005648                          
08-04-05 20:21 herby          Note Added: 0005652                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
