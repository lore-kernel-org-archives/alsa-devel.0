From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001111]: Audigy2NX: Channels interchanged
Date: Sat, 14 May 2005 17:34:51 +0200
Message-ID: <7e8f5483bb2642338a9924e53c408a45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0A9AB2B9
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2005 17:34:51 +0200 (MEST)
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
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11.9
======================================================================
Date Submitted:             05-14-2005 17:34 CEST
Last Modified:              05-14-2005 17:34 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 17:34 fabian         New Issue                                    
05-14-05 17:34 fabian         Kernel Version            => 2.6.11.9        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
