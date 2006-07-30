From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001111]: Audigy2NX: Channels
	interchanged
Date: Mon, 31 Jul 2006 01:49:12 +0200
Message-ID: <477881cb768c0f3a2b14b897152a1074@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 917EB185
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 01:49:12 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1111> 
======================================================================
Reported By:                fabian
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1111
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.11.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-14-2005 17:34 CEST
Last Modified:              07-31-2006 01:49 CEST
======================================================================
Summary:                    Audigy2NX: Channels interchanged
Description: 
Hi

I recently bought an Audigy2NX for my Laptop to use my Creative Inspire
5300 5.1 System. I configured around a little bit, and tried to simulate
5.1 sound with stereo-mp3s by copying the audiostreams using TTable. I got
very confusing results so I tried speaker-test.

speaker-test -D default -c 6 -f 300 -p 300

default is, cause I have to resample output to 48k to get correct sound:

1. Problem:
The confusing thing is that I noticed that the rear speakers are
interchanged with the subwoofer/center speaker. First I thought I made a
mistake with the plugs, but I checked everything: I only get the correct
output, when I plug the black chord for rear speaker in "Sub/center" on
the Audigy and vice versa.

Little other problems:
* The Master volume adjustor on the card itself doesn't work.
* When I use the "Mute" button on the card, I only can unmute in software
* The channels in "Alsamixer" are named very confusingly: 
Speaker
Speaker1
Speaker2
Speaker2
Speaker2
Speaker2
Speaker3 (is a switch)
How does Alsamixer get the labels for the channels? Can one rename the
channels anywhere?

And a question:
* Will the remote control work someday?


And the last thing I want to say: I got in touch with ALSA today the first
time, and I'm fascinated about the things you can do especially in
asound.conf. Great great great Work! :-)

greetings
fabian

PS:
My /etc/asound.conf:

pcm.intel8x0 {
        type hw
        card 0
}

ctl.intel8x0 {
        type hw
        card 0
}

pcm.Audigy2NX {
        type hw
        card 1
}

ctl.Audigy2NX {
        type hw
        card 1
}

pcm.!default {
        type plug
        slave {
                pcm Audigy2NX
                rate 48000
        }
}

ctl.!default {
        type plug
        slave {
                ctl Audigy2NX
                rate 48000
        }
}

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 06-24-05 09:29 
----------------------------------------------------------------------
ALSA 1.0.9 has better control names, and you don't need the 48 kHz hack
anymore.

The remote control is supported with the alsa_usb driver in the CVS
version of LIRC.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 17:34 fabian         New Issue                                    
05-14-05 17:34 fabian         Kernel Version            => 2.6.11.9        
06-24-05 09:29 Clemens LadischNote Added: 0005206                          
07-31-06 01:49 Adrian Bunk    Status                   assigned => resolved
07-31-06 01:49 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
