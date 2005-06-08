From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001174]: Speaker Test fails with error message(s) from alsa lib.  "problem for start_threshold"
Date: Thu, 9 Jun 2005 00:42:54 +0200
Message-ID: <324c36df3e75827c0a8d5fc63576f52f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CDEE81CC
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 00:42:54 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              06-09-2005 00:42 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 00:42 herby          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
