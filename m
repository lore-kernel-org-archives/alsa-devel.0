From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001174]: Speaker Test fails with error message(s) from alsa lib.  "problem for start_threshold"
Date: Wed, 22 Jun 2005 11:39:34 +0200
Message-ID: <315013d76908703237d6b3c53ef285d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D960205
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 11:39:34 +0200 (MEST)
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
Last Modified:              06-22-2005 11:39 CEST
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
 herby - 06-22-05 10:19 
----------------------------------------------------------------------
I've seen recent notes on the frequency range for speaker test (nice to
have a wide range of things).  Has anyone tried the latest version(s) to
see if this bug pops its head up.  I've got other programs that appear to
exhibit this (or a similar) error, but I feel that a standard program is a
better example.  If you need more information, PLEASE let me know!

----------------------------------------------------------------------
 tiwai - 06-22-05 11:39 
----------------------------------------------------------------------
The bug acked.  Will check what's going on there...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 00:42 herby          New Issue                                    
06-13-05 19:49 herby          Issue Monitored: herby                       
06-13-05 19:55 herby          Note Added: 0005013                          
06-15-05 14:27 jdthood        Note Added: 0005024                          
06-22-05 10:19 herby          Note Added: 0005120                          
06-22-05 11:39 tiwai          Note Added: 0005123                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
