From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001090]: Support for new Prodigy 7.1 LT
Date: Tue, 14 Jun 2005 21:26:53 +0200
Message-ID: <40b026fa0072a5d1f1d981b06637467b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 75C631E0
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2005 21:26:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1090> 
======================================================================
Reported By:                Demosthenes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1090
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Ubuntu (Hoary Hedgehog)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             05-06-2005 17:34 CEST
Last Modified:              06-14-2005 21:26 CEST
======================================================================
Summary:                    Support for new Prodigy 7.1 LT
Description: 
Could you please try to add support for the Audiotrak Prodigy 7.1 LT, as
far as I am aware this card is essentially the same as the Produgy 7.1 but
low profile and with a couple of physical changes such as no digital in.

ALSA does not detect the card currently and when I try to load the
snd-1724 module it fails with an EEPROM error.

I have tried compiling a new kernel with the subdevice id for the Prodigy
7.1 in aureon.h changed to correspond to my device (as detailed here for
another card
http://linux.derkeiler.com/Newsgroups/comp.os.linux.hardware/2004-10/0340.html).
Alsa then detects the card and I can load modules and change volumes in
alsamixer but I haven't been able to produce any sound.

Hopefully support will be easy to add as this card is almost exactly the
same as the Prodigy 7.1 (and Aureon Space etc.) which already have
support.

I would be very happy to give any further information needed.
======================================================================

----------------------------------------------------------------------
 Demosthenes - 06-14-05 18:50 
----------------------------------------------------------------------
Unfortunately due to the fact that I have had exams I haven't much tried to
get any further with the card, however since I have finished today I am
ready to start anew my efforts.

ESI apparently are working with ALSA to provide support for their cards,
currently they are working on the Juli@ driver, we need to somehow get
someone to start on the LT, as I've posted before hopefully it won't be
too hard.  

I have no experience in these things (drivers) though I am definately
willing to do anything to help.  I am glad to see that it is not just me
wanting support for this card perhaps the two of us together will have
better luck (I am sure there must be more people, it has all the makings
of a very good card for small form factor, HTPC etc.).



----------------------------------------------------------------------
 ungod - 06-14-05 21:26 
----------------------------------------------------------------------
I must apologize for my abscence, however I have too been busy with the
exams - and still am. As soon as I am done (next week), I will gladly
assist further in implementing the prodigy 7.1lt. (I did quite a bunch of
the prodigy 5.1/7.1 stuff and have a personal interest in making the
driver complete, although I don't have the LT card myself)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 17:34 Demosthenes    New Issue                                    
05-06-05 17:35 Demosthenes    Distribution              => Ubuntu (Hoary
Hedgehog)
05-06-05 17:35 Demosthenes    Kernel Version            => 2.6.10          
05-06-05 22:44 ungod          Note Added: 0004597                          
05-06-05 22:48 ungod          Note Added: 0004598                          
05-07-05 01:38 Demosthenes    Note Added: 0004600                          
05-07-05 01:47 Demosthenes    Note Edited: 0004600                         
05-08-05 00:45 ungod          Note Added: 0004608                          
05-08-05 17:30 Demosthenes    Note Added: 0004610                          
05-08-05 17:39 ungod          File Added: aureon-prodigy71lt-fix.diff           
        
05-08-05 17:40 ungod          Note Added: 0004611                          
05-08-05 19:09 Demosthenes    Note Added: 0004612                          
05-08-05 19:12 Demosthenes    Note Edited: 0004612                         
05-08-05 19:12 Demosthenes    Note Edited: 0004612                         
05-08-05 20:08 ungod          Note Added: 0004614                          
05-08-05 20:18 Demosthenes    Note Added: 0004615                          
05-08-05 20:23 ungod          Note Added: 0004616                          
05-08-05 20:27 ungod          Note Added: 0004617                          
05-08-05 20:37 Demosthenes    Note Added: 0004618                          
05-09-05 01:01 ungod          Note Added: 0004620                          
05-09-05 13:15 Demosthenes    Note Added: 0004624                          
05-09-05 14:49 ungod          Note Added: 0004625                          
05-09-05 15:03 Demosthenes    Note Added: 0004626                          
05-10-05 09:36 ungod          Note Added: 0004632                          
05-10-05 15:50 Demosthenes    Note Added: 0004633                          
05-14-05 15:18 Demosthenes    Note Added: 0004658                          
05-14-05 20:24 Demosthenes    Note Edited: 0004658                         
06-14-05 16:02 baesyspem      Note Added: 0005018                          
06-14-05 16:03 baesyspem      Issue Monitored: baesyspem                    
06-14-05 16:03 baesyspem      Issue End Monitor: baesyspem                    
06-14-05 18:30 Demosthenes    Note Added: 0005019                          
06-14-05 18:50 Demosthenes    Note Edited: 0005019                         
06-14-05 21:26 ungod          Note Added: 0005020                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
