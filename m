From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000572]: spdif hw entry fails to work in multi
Date: Wed, 13 Oct 2004 10:49:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013084907.A4F821B00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DACA8268
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2004 10:49:07 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000572
======================================================================
Reported By:                ramendik
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     572
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               RH-based
Kernel Version:             2.6.8.1, with alsa 1.0.7rc1 plus patches from bug 0000505
======================================================================
Date Submitted:             10-08-2004 02:27 CEST
Last Modified:              10-13-2004 10:49 CEST
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
 tiwai - 10-08-2004 12:13 CEST 
----------------------------------------------------------------------
Use this:

pcm.rt {
    type route
    slave.pcm whole
    slave.channels 4
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
}

and run with -d rt .

----------------------------------------------------------------------
 ramendik - 10-08-2004 12:29 CEST 
----------------------------------------------------------------------
Thanks. This has worked.

A definite must for the FAQ, and a link to this should be present in the
soundcard matrix for i865 - which at this point is not even available. 
But I'll refile this as a documentation bug. Please close this one.

Actually, the absence of a *decent* documentation of the route type is
another documentation bug. And, as a professional tech writer I'm
qualified to fix this. I'll write to alsa-devel to offer my services.

----------------------------------------------------------------------
 tiwai - 10-08-2004 12:42 CEST 
----------------------------------------------------------------------
Yes, we know the documentation problems :-<
Any help would be appreciated.

BTW, it's possible to implement the analog and spdif simultaneous
output on ICH4 without data duplication.  I'll try a hack later.

Anyway, I close this bug now.

----------------------------------------------------------------------
 tiwai - 10-11-2004 15:39 CEST 
----------------------------------------------------------------------
Could you try the attached patch?  With this patch, the signal to
hw:0,0 will be routed to the spdif, too.

This behavior should be switched by either a module parameter or a
mixer control because someone may want to use analog and SPDIF
separately to play different streams.

----------------------------------------------------------------------
 ramendik - 10-13-2004 06:43 CEST 
----------------------------------------------------------------------
The patch has failed.

(I tried to apply it over 1.0.7rc1 plus the bug 505 patches.)

The reason is probably that it's over CVS. Rather than play around with
patches, perhaps you can simply attach intel8x0.c so I could replace the
entire file?

Alternatively I can pull alsa-cvs, of course. Should I do this?

----------------------------------------------------------------------
 tiwai - 10-13-2004 10:49 CEST 
----------------------------------------------------------------------
Try 1.0.7rc2.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-08-04 02:27 ramendik       New Bug                                      
10-08-04 02:27 ramendik       Distribution              => RH-based        
10-08-04 02:27 ramendik       Kernel Version            => 2.6.8.1, with alsa 1.0.7rc1 plus patches from bug 0000505
10-08-04 02:31 ramendik       Bug Monitored: ramendik                      
10-08-04 12:13 tiwai          Bugnote Added: 0002045                       
10-08-04 12:29 ramendik       Bugnote Added: 0002048                       
10-08-04 12:42 tiwai          Bugnote Added: 0002049                       
10-08-04 12:42 tiwai          Assigned To               => tiwai           
10-08-04 12:42 tiwai          Resolution               open => not a bug   
10-08-04 12:42 tiwai          Status                   new => resolved     
10-11-04 15:39 tiwai          Bugnote Added: 0002079                       
10-11-04 15:39 tiwai          Resolution               not a bug => reopened
10-11-04 15:39 tiwai          Status                   resolved => feedback
10-11-04 15:39 tiwai          File Added: ich-analog-spdif-dup.dif                    
10-13-04 06:43 ramendik       Bugnote Added: 0002110                       
10-13-04 10:49 tiwai          Bugnote Added: 0002117                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
