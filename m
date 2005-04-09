From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000572]: spdif hw entry fails to work in multi
Date: Sat, 9 Apr 2005 16:19:28 +0200
Message-ID: <cd616e49074805a73bf06d0f8264fae4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C423C24F
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 16:19:28 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=572> 
======================================================================
Reported By:                ramendik
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   572
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               RH-based
Kernel Version:             2.6.8.1, with alsa 1.0.7rc1 plus patches from bug
0000505
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-08-2004 02:27 CEST
Last Modified:              04-09-2005 16:19 CEST
======================================================================
Summary:                    spdif hw entry fails to work in multi
Description: 
After bug 0000505 was fixed, hw:0,0 only plays to analog devices, and
hw:0,4 to spdif. As one needs output in both, I tried to use .asoundrc ,
and therefore needed to use the "multi" pcm type in order to unite these
two (and then route). This is what I put in .asoundrc

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
    slave.pcm "whole"
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
}

The ttable may be wrong - I could not find a sane description anywhere -
but I tried many variants, and besides, playing to "whole" bypasses this.

So here's what I get when playing to "rt" OR to "whole" via alsaplayer :

$ alsaplayer -d whole test.wav 
error on set_channels (2)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 64
CHANNELS: 4
RATE: 44100
PERIOD_TIME: (181 371520)
PERIOD_SIZE: [8 16384]
PERIOD_BYTES: [64 131072]
PERIODS: [1 1024]
BUFFER_TIME: (181 371520)
BUFFER_SIZE: [8 16384]
BUFFER_BYTES: [64 131072]
TICK_TIME: 1000
error on set_channels (2)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 64
CHANNELS: 4
RATE: 44100
PERIOD_TIME: (181 371520)
PERIOD_SIZE: [8 16384]
PERIOD_BYTES: [64 131072]
PERIODS: [1 1024]
BUFFER_TIME: (181 371520)
BUFFER_SIZE: [8 16384]
BUFFER_BYTES: [64 131072]
TICK_TIME: 1000
failed to configure output device...trying OSS

then alsaplayer hangs until interrupted.

When I comment out everything related to slave b, "whole" seems to work
(without spdif output, of course). So this seems like a bug in the spdif
device.
======================================================================

----------------------------------------------------------------------
 ramendik - 10-13-04 17:31 
----------------------------------------------------------------------
1.0.7rc2 has patched ok, but then failed to compile inside kernel 2.6.8.1.
And it's not about the patch - the failure was in core/rtctimer.o . 

Perhaps I can stick intel_i8x0.c from 1.0.7rc2 into 1.0.7rc1? Or, perhaps
wait for kernel 2.6.9 ?

----------------------------------------------------------------------
 tiwai - 10-14-04 12:37 
----------------------------------------------------------------------
Just copying may not work.  I don't know of compile problems for
rtctimer.c.  Please file the bug report about it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-08-04 02:27 ramendik       New Issue                                    
10-08-04 02:27 ramendik       Distribution              => RH-based        
10-08-04 02:27 ramendik       Kernel Version            => 2.6.8.1, with alsa
1.0.7rc1 plus patches from bug 0000505
10-08-04 02:31 ramendik       Issue Monitored: ramendik                    
10-08-04 12:13 tiwai          Note Added: 0002045                          
10-08-04 12:29 ramendik       Note Added: 0002048                          
10-08-04 12:42 tiwai          Status                   new => resolved     
10-08-04 12:42 tiwai          Resolution               open => not an issue
10-08-04 12:42 tiwai          Assigned To               => tiwai           
10-08-04 12:42 tiwai          Note Added: 0002049                          
10-11-04 15:39 tiwai          Status                   resolved => feedback
10-11-04 15:39 tiwai          Resolution               not an issue => reopened
10-11-04 15:39 tiwai          Note Added: 0002079                          
10-11-04 15:39 tiwai          File Added: ich-analog-spdif-dup.dif              
     
10-13-04 06:43 ramendik       Note Added: 0002110                          
10-13-04 10:49 tiwai          Note Added: 0002117                          
10-13-04 17:31 ramendik       Note Added: 0002128                          
10-14-04 12:37 tiwai          Note Added: 0002141                          
04-09-05 16:19 jdthood        Status                   feedback => resolved
04-09-05 16:19 jdthood        Resolution               reopened => fixed   
04-09-05 16:19 jdthood        Description Updated                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
