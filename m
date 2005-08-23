From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001210]: Exaudio produces noise on all speakers for 5.1 channels
Date: Wed, 24 Aug 2005 01:03:40 +0200
Message-ID: <81ddf0be127c3e520f0532873f33064d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4735D244
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 01:03:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1210> 
======================================================================
Reported By:                andersin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1210
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-23-2005 23:54 CEST
Last Modified:              08-24-2005 01:03 CEST
======================================================================
Summary:                    Exaudio produces noise on all speakers for 5.1
channels
Description: 
I am using a soundblaster extigy with ALSA ver. 1.0.9b and am happy to say

that stereo sound works find and that all 6 speakers can produce some
sound.

With more than 2 channel output, I experience problems. speaker-test,
which 
works for 1 and 2 channels, results in a hissing/crackling for 3,5,6 
channels, which changes in pitch depending on the number of channels. For
4 
channels, it loops, producing the following output


speaker-test 0.0.8

Playback device is extigy
Stream parameters are 48000Hz, S16_LE, 4 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 96 to 8192
Period size range from 48 to 4096
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 2048
was set buffer_size = 8192
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument
Rate set to 48000Hz (requested 48000Hz)
[ The "Rate set to ..." part is repeated continuously ]


Setting my capture device to mixer, I was able to record the output with 
arecord -c 6 -f dat -r 48000 /root/speaker-test-6ch.wav . The distortion
is 
still present when playing the file, forcing 2 channels in aplay.

In addition to using speaker test, I tried using the route plugin to
isolate 
the rear channels. When I route to any channel, I can hear the same output
on 
all 5 (not sure about Woofer) channels, no matter which channel I route
to. 
Here is the relevant setup:

pcm.route1      {
type            route;
slave.pcm       "extigy";
slave.channels  6;
ttable.0.0      1.0;
}

The music that I played had similar distortions like the one for speaker
test 
and played considerably slower than when player with 2 channels. Again I 
could record and replay the effect. The setup was slightly different in
order 
to route the stereo channels to all 6 speakers.

For routing with 4 slave channels, I get a failure (as expected), this
time 
with the output:

Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
aplay: set_params:910: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 48000
PERIOD_TIME: (42666 42667)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (170666 170667)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 1000

This is all the relevant bits that I can think of at the moment. Thank you
for 
reading this far. If anybody thinks it is important to get the recorded 
files, I am happy to sent them. I am grateful for any nudge on what I am 
doing wrong with my setup.

Christoph Burger-Scheidlin
======================================================================

----------------------------------------------------------------------
 andersin - 08-24-05 00:50 
----------------------------------------------------------------------
Hmm, nothing happened in a while. Reading over the comments, I think I gave
you the wrong files. I downloaded some ac3 test files and decoded them
using ac3dec -6 -D extigy. The file I uploaded is a recording of the two
front speakers.

----------------------------------------------------------------------
 andersin - 08-24-05 01:03 
----------------------------------------------------------------------
I am also experiencing a problem with channel assignments while playing 6
channel sound, which I posted as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001364. I am not sure if
it is
related though

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-05 23:54 andersin       New Issue                                    
06-24-05 09:21 Clemens LadischFile Added: alsa-lib-start-threshold-check.diff   
                
06-24-05 09:22 Clemens LadischFile Deleted: alsa-lib-start-threshold-check.diff 
                  
06-24-05 09:23 Clemens LadischNote Added: 0005205                          
06-24-05 10:14 andersin       File Added: stream0.txt                      
06-24-05 10:16 andersin       Note Added: 0005208                          
06-24-05 10:25 Clemens LadischNote Added: 0005209                          
06-24-05 13:38 andersin       Note Added: 0005218                          
06-24-05 15:23 andersin       Note Edited: 0005218                         
06-24-05 17:22 Clemens LadischNote Added: 0005239                          
06-24-05 17:44 andersin       File Added: speaker-test-6ch.mp3                  
 
06-24-05 17:44 andersin       File Added: speaker-test-2ch.mp3                  
 
06-24-05 17:47 andersin       Note Added: 0005242                          
08-24-05 00:50 andersin       Note Added: 0005920                          
08-24-05 00:50 andersin       File Added: record.wav.mp3                    
08-24-05 01:03 andersin       Note Added: 0005922                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
