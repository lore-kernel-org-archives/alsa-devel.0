From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000411]: IEC958 status non-audio (and others) bits are not updated on iec958 stream
Date: Sat, 9 Apr 2005 14:27:07 +0200
Message-ID: <dddae54f0f80a5cc7a9b3f079e2e4b60@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 16EE4217
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 14:27:08 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=411> 
======================================================================
Reported By:                domi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   411
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Debian unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-28-2004 21:04 CEST
Last Modified:              04-09-2005 14:27 CEST
======================================================================
Summary:                    IEC958 status non-audio (and others) bits are not
updated on iec958 stream
Description: 
To investigate a problem where AC3 is not working
with my Yamaha amplifer and my Asus a7n8x deluxe board,
I've set up a loopback between the rear spdif output (RCA)
and the on-board spdif input.

Reading the 'SPDIF In Status' status line in  the card0/codec97#0/ac97#0-0
file, I've noticed that the status, non-audio or any other information
sent through the spdif stream are not sent on the wire.

This behavior would explain the problems found in bug 00369 (SPDIF always
on) and 00214 (AC3 not working)

Note that the 'SPDIF Control' line and ac97#0-0+regs file are updated
correctly, only the information sent on the
stream are lost.
======================================================================

----------------------------------------------------------------------
 domi - 09-07-04 14:10 
----------------------------------------------------------------------
I've tried the driver from Nvidia (nvsound) whose latest release
features [1] :
- AC3 passthrough
- Added support for SoundStorm

And, lo and behold, the ac3 works ! I finally got the AC3 stream
recognized by my Yamaha amplifier.

Moreover, simple stereo is also converted to AC3 by the SoundStorm
stuff (OK, that's not so great for HiFi :-/ ).

So my hardware is not faulty. There's no bug in the ALC650.

I think tiwai is right, the soundstorm chip gets in the way.

----------------------------------------------------------------------
 jdthood - 04-09-05 14:27 
----------------------------------------------------------------------
> So my hardware is not faulty. There's no bug in the ALC650.

Can this bug report be closed, or is there something that remains to be
done?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-28-04 21:04 domi           New Issue                                    
07-28-04 21:04 domi           Distribution              => Debian unstable 
07-28-04 21:04 domi           Kernel Version            => 2.6.7           
08-05-04 20:18 domi           Note Added: 0001535                          
08-07-04 18:09 domi           Note Added: 0001544                          
08-19-04 19:01 tiwai          Note Added: 0001590                          
09-07-04 14:10 domi           Note Added: 0001707                          
04-09-05 14:27 jdthood        Note Added: 0004397                          
04-09-05 14:27 jdthood        Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
