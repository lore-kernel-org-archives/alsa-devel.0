From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000579]: multi+route distort sound
Date: Tue, 12 Oct 2004 13:10:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012111047.B92C918009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2CE182DB
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 13:10:48 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000579
======================================================================
Reported By:                ramendik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     579
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ASP Linux, RH9-based
Kernel Version:             2.6.8.1-ck8 , with alsa 1.0.7rc1 stuck in and patches from bug 505 put on top
======================================================================
Date Submitted:             10-11-2004 20:45 CEST
Last Modified:              10-12-2004 13:10 CEST
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

----------------------------------------------------------------------
 tiwai - 10-12-2004 13:10 CEST 
----------------------------------------------------------------------
No clue yet.  To make the test consistent, use aplay for testing.
Run aplay with -v option.  This will show the hw/sw setting.
In addition, iecset output and /proc/asound/card0/codec97#0/* files
would be helpful as usual.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-11-04 20:45 ramendik       New Bug                                      
10-11-04 20:45 ramendik       Distribution              => ASP Linux, RH9-based
10-11-04 20:45 ramendik       Kernel Version            => 2.6.8.1-ck8 , with alsa 1.0.7rc1 stuck in and patches from bug 505 put on top
10-12-04 13:10 tiwai          Bugnote Added: 0002091                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
