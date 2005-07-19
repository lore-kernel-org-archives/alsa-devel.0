From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001257]: 'Sample format non available' when using jack-plugin
Date: Tue, 19 Jul 2005 18:26:22 +0200
Message-ID: <884caf1041b188066437de603a3a0561@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54F8C1D1
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 18:26:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1257> 
======================================================================
Reported By:                Robert_Schulze
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1257
Category:                   PCM - jack
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-14-2005 17:50 CEST
Last Modified:              07-19-2005 18:26 CEST
======================================================================
Summary:                    'Sample format non available' when using jack-plugin
Description: 
1. Start Jackd:

/usr/local/jack/bin/jackd -vd alsa -d emi -S

2. Start arecord:

arecord -D "emijack12" -t wav -f S16_LE -c 2 -r 48000 > test.wav

gives: "arecord: set_params:882: Sample format non available"

arecord -D "emijack12" > test.wav

gives the same.

my .asoundr:

pcm.emijack12
    {
    type jack
    playback_ports
        {
        0 alsa_pcm:playback_1
        1 alsa_pcm:playback_2
        }
    capture_ports
        {
        0 alsa_pcm:capture_1
        1 alsa_pcm:capture_2
        }
    }

ctl.emi
    {
    type hw
    card 1
    }

pcm.emi
    {
    type hw
    card 1
    }

emi is a Emagic a62m USB-Audiointerface


======================================================================

----------------------------------------------------------------------
 Robert_Schulze - 07-19-05 17:21 
----------------------------------------------------------------------
Yes that does indeed. But I'm unable to kill the task (arecord) with
ctrl+c, only a killall -KILL arecord works...

The format of the ALSA <-> JACK PCM I/O PLugin is FLOAT_LE.
Do I have to convert to INT in my .asoundrc?

----------------------------------------------------------------------
 Clemens Ladisch - 07-19-05 18:26 
----------------------------------------------------------------------
Jack uses float samples internally, so it's the only sample format
supported by the Jack plugin.  You have to convert it with a plugin like
lfloat or plug.

I don't know why arecord hangs.  Does it work without -vv?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-14-05 17:50 Robert_Schulze New Issue                                    
07-14-05 18:03 Clemens LadischNote Added: 0005477                          
07-19-05 17:21 Robert_Schulze Note Added: 0005528                          
07-19-05 18:26 Clemens LadischNote Added: 0005530                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
