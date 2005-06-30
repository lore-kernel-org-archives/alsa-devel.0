From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001090]: Support for new Prodigy 7.1 LT
Date: Thu, 30 Jun 2005 21:21:52 +0200
Message-ID: <d5812616d969cd86d61a073877b3503f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B239A19E
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2005 21:21:52 +0200 (MEST)
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
Last Modified:              06-30-2005 21:21 CEST
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
 Demosthenes - 06-30-05 02:38 
----------------------------------------------------------------------
Ha, well if I had waited a few minutes it would have saved me taking my
shuttle apart (which I managed to drop on the floor through stupidity,
still works though luckily).  Some of my numbers seem to be slightly
different (not talking about the last part of some chips, which I have
included because I spent all that effort getting them). I have:
1) WM8770IFT, 38AAXFF (This chip had a Q sticker on it indicating the
QSound chip?)
2)3AZ6D5J, HC04 (the logo for this looks like Texas with something it in)
3)HC125A, PAB122 (thick line and "on" in a circle)
4)H16A, 351BE (triangle with a squiggle)
5)ATMEL426, 24CO2N, SI27 D
6)H17A, 317BJ (triangle with a squiggle)
7)NCO-3.3V, 49.152MHz, NTE

It looks like I might have a newer board than you baesyspem.



----------------------------------------------------------------------
 ungod - 06-30-05 21:21 
----------------------------------------------------------------------
Ah, WM8770 is apparently the only sound related chip onboard besides the
opamps and the ICE1724. Now what we need to do now, is to figure out how
the WM8770 is connected to the ICE1724.

There are 4 relevant pins on the WM8770, RESETB, CE, DI, and CL (see
http://linux.developers.dk/prodigy2.png) On the ordinary Prodigy card, the
chip was connected to GPIO20, GPIO12, GPIO18, and GPIO19 on ICE1724,
however this seems not to be the case on this particular card (if so, you
would have had sound). On the ordinary Prodigy, all GPIO pins was used for
communication with the various other chips on the board.

Now, what I want you to do, is to somehow trace the route of the WM8770
pins to the ICE1724 with a voltmeter or something. The chip is most likely
connected to the GPIO pins and/or the I2C pins (I've marked their
locations on the picture).

You will find that the 24C02N is also connected to the I2C pins (it is an
EEPROM containing vendor id's)

I know this probably isn't easy, but it is my best shot. Hopefully, there
are markins on the PCB, indicating pin numbers of the ICE1724 (mine have)

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
06-14-05 21:27 ungod          Note Edited: 0005020                         
06-29-05 18:30 Demosthenes    Note Added: 0005307                          
06-30-05 01:03 ungod          Note Added: 0005321                          
06-30-05 01:08 ungod          Issue Monitored: ungod                       
06-30-05 01:46 baesyspem      Note Added: 0005322                          
06-30-05 02:27 Demosthenes    Note Added: 0005323                          
06-30-05 02:29 Demosthenes    Note Edited: 0005323                         
06-30-05 02:29 Demosthenes    Note Edited: 0005323                         
06-30-05 02:36 Demosthenes    Note Edited: 0005323                         
06-30-05 02:38 Demosthenes    Note Edited: 0005323                         
06-30-05 21:21 ungod          Note Added: 0005328                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
