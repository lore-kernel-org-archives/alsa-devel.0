From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001257]: 'Sample format non available' when using jack-plugin
Date: Fri, 24 Mar 2006 05:11:59 +0100
Message-ID: <6e4a59519d7edbf5167ea7c60deb5cae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A2FBA11D
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 05:11:59 +0100 (MET)
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
Last Modified:              03-24-2006 05:11 CET
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
 Robert_Schulze - 07-20-05 17:48 
----------------------------------------------------------------------
It hangs even wihtout -vv.
I started jack verbosely and noticed a failure in disconnection of the
ports.

If I start arecord, jackd logs:

"
connect alsa_pcm:capture_1 and alsaC.3308.0:in_000
...
connect alsa_pcm:capture_2 and alsaC.3308.0:in_001
"

If I quit arecord via ctrl+c, jackd logs:

"
DIS-connect alsa_pcm:capture_2 and alsaC.3308.0:in_001
"

So it just disconnects the last given port-pair.
When I kill arecord with SIGKILL, jack logs:

"
cannot read event responce from client [alsaC.3308.0] (Connection reset by
peer)
bad status for client event handling (type=4)
DIS-connect alsa_pcm:capture_1 and alsaC.3308.0:in_000

cannot send event to client [alsaC.3308.0] (Broken pipe)
bad status for client event handling (type=4)
...
cannot write request result to client
could not handle external client request
"

----------------------------------------------------------------------
 Raymond - 03-24-06 05:11 
----------------------------------------------------------------------
It is ok to use arecord, mplayer with alsa, jack using alsa-plugins
1.0.11rc4

arecord -Dplug:jack -f S16_LE -r 48000 -c 2 stereo.wav

mplayer -ao alsa stereo.wav 
mplayer -ao jack stereo.wav 

However, mplayer hangs after play sound for a few seconds for plug:jack

mplayer -ao alsa:device=plug=jack stereo.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-14-05 17:50 Robert_Schulze New Issue                                    
07-14-05 18:03 Clemens LadischNote Added: 0005477                          
07-19-05 17:21 Robert_Schulze Note Added: 0005528                          
07-19-05 18:26 Clemens LadischNote Added: 0005530                          
07-20-05 17:48 Robert_Schulze Note Added: 0005533                          
03-24-06 05:11 Raymond        Note Added: 0008911                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
