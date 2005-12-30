From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000579]: multi+route distort sound
Date: Fri, 30 Dec 2005 04:19:34 +0100
Message-ID: <75d6f3f80aac0e6c05f367da84d28190@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1B47319F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:19:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=579> 
======================================================================
Reported By:                ramendik
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   579
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-11-2004 20:45 CEST
Last Modified:              12-30-2005 04:19 CET
======================================================================
Summary:                    multi+route distort sound
Description: 
I have Intel ICH5, with both analog and spdif output.

I have made up /etc/asound.conf to route to both hw:0,0 and hw:0,4; I am
listening on spdif (hw:0,4). (tiwai: I will try the new patch that may
make this redundant, but what we have here seems to be another bug and
might happen in other cases too).

Here's my /etc/asound.conf in its entirety:

pcm.analog {
    type hw
    card 0
    device 0
}

pcm.digit {
    type hw
    card 0
    device 4
}

pcm.whole {
    type multi
    slaves.a.pcm "hw:0,0"
    slaves.a.channels 2
    slaves.b.pcm "hw:0,4"
    slaves.b.channels 2
    bindings.0.slave a
    bindings.0.channel 0
    bindings.1.slave a
    bindings.1.channel 1
    bindings.2.slave b
    bindings.2.channel 0
    bindings.3.slave b
    bindings.3.channel 1
}

pcm.rt {
    type route
    slave.pcm whole
    slave.channels 4
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
}
pcm.!default {
    type copy
    slave.pcm rt
}

ctl.!default {
    type hw
    card 0
}

When I play to hw:0,4 or "analog", the sound is OK. When I play to "rt",
it is distorted. Not noisy this time; instead, the pitch is shifted
somewhat lower. 

Checked with alsaplayer and xmms 1.2.10 . (XMMS 1.2.8 also caused high CPU
use when playing to "rt", but this may be a CPU bug). Checked with both
44100 Hz and 48000 Hz files.

This may have something to do with a strange fact. When I play a 48k file,
iecset still reports a rate of 44100 Hz. And in fact, if I set it to 48000
Hz manualy and start a 48k file in alsaplayer, it still shifts to 44100 !
This is true for both playing to hw:0,4 and to "rt". (Not tested with
XMMS, can test if needed)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000569 Software mixing to rear channel
======================================================================

----------------------------------------------------------------------
 ramendik - 03-20-05 13:21 
----------------------------------------------------------------------
Thanks for reminding! I'll test out with alsa in kernel 2.6.11 and newest
libs, and report back.

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:19 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-11-04 20:45 ramendik       New Issue                                    
10-11-04 20:45 ramendik       Distribution              => ASP Linux, RH9-based
10-11-04 20:45 ramendik       Kernel Version            => 2.6.8.1-ck8 , with
alsa 1.0.7rc1 stuck in and patches from bug 505 put on top
10-12-04 13:10 tiwai          Note Added: 0002091                          
10-22-04 16:56 perex          Relationship added       related to 0000569  
10-22-04 16:58 perex          Project                  ALSA - driver => ALSA -
lib
03-20-05 13:05 jdthood        Note Added: 0004077                          
03-20-05 13:21 ramendik       Note Added: 0004079                          
12-30-05 04:19 rlrevell       Note Added: 0007204                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
