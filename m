From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001174]: Speaker Test fails with error message(s) from alsa lib.  "problem for start_threshold"
Date: Wed, 22 Jun 2005 10:19:23 +0200
Message-ID: <54d59e1a2438e57809c77757fcfc4805@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1D40135
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 10:19:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1174> 
======================================================================
Reported By:                herby
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1174
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-09-2005 00:42 CEST
Last Modified:              06-22-2005 10:19 CEST
======================================================================
Summary:                    Speaker Test fails with error message(s) from alsa
lib.  "problem for start_threshold"
Description: 
Running speaker test gets me:
>>>
speaker-test 0.0.8

Playback device is plughw:0,0
Stream parameters are 48000Hz, S16_LE, 1 channels
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
ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params:
params->avail_min problem for start_threshold
Unable to set sw params for playback: Invalid argument
Setting of swparams failed: Invalid argument
<<<
======================================================================

----------------------------------------------------------------------
 jdthood - 06-15-05 14:27 
----------------------------------------------------------------------
I have this problem too.  1.0.8 worked fine.  1.0.9 prints an error
message

    Setting of swparams failed: Invalid argument

and cycles back to "Rate set to 48000Hz (requested 48000Hz)" in an
infinite loop, without ever producing any sound.

Note too that speaker-test 1.0.9 prints its version number as "0.0.8".

--------------------
Test with ALSA 1.0.8
--------------------

$ speaker-test

speaker-test 1.0.8

Playback device is plughw:0,0
Stream parameters are 48000Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 32768
Period size range from 16 to 1024
Buffer time size 2525
To choose buffer_size = 2520
To choose period_size = 315
was set period_size = 256
was set buffer_size = 2520
  - Front Left
... with tones playing


--------------------
Test with ALSA 1.0.9
--------------------

$ speaker-test

speaker-test 0.0.8

Playback device is plughw:0,0
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 32768
Period size range from 16 to 1024
Periods = 4
Buffer time size 2525
To choose buffer_size = 15052
To choose period_size = 3763
was set period_size = 1024
was set buffer_size = 15052
Unable to set sw params for playback: Invalid argument
Setting of swparams failed: Invalid argument
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 32768
Period size range from 16 to 1024
Periods = 4
... ad infinitum


jdthood@thanatos:~$ dpkg -l alsa-\* libasound\* | grep ^ii
ii  alsa-base      1.0.9b-2~5     ALSA driver configuration files
ii  alsa-modules-2 1.0.9+1        ALSA modules for kernel 2.4.27-2-686
ii  alsa-source    1.0.9b-2~5     ALSA driver sources
ii  alsa-utils     1.0.9a-2       ALSA utilities
ii  libasound2     1.0.9-2        ALSA library
ii  libasound2-doc 1.0.9-2        ALSA library developer documentation
jdthood@thanatos:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jun 15 2005 for kernel 2.6.11.
jdthood@thanatos:~$ cat /proc/asound/cards
0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0x50100000/0x50000000, irq 11

----------------------------------------------------------------------
 herby - 06-22-05 10:19 
----------------------------------------------------------------------
I've seen recent notes on the frequency range for speaker test (nice to
have a wide range of things).  Has anyone tried the latest version(s) to
see if this bug pops its head up.  I've got other programs that appear to
exhibit this (or a similar) error, but I feel that a standard program is a
better example.  If you need more information, PLEASE let me know!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 00:42 herby          New Issue                                    
06-13-05 19:49 herby          Issue Monitored: herby                       
06-13-05 19:55 herby          Note Added: 0005013                          
06-15-05 14:27 jdthood        Note Added: 0005024                          
06-22-05 10:19 herby          Note Added: 0005120                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
