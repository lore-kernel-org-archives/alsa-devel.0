From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001090]: Support for new Prodigy 7.1 LT
Date: Wed, 13 Jul 2005 04:24:05 +0200
Message-ID: <5d66a4296b705bc5915129e29ef62b68@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF8541B5
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2005 04:24:05 +0200 (MEST)
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
Last Modified:              07-13-2005 04:24 CEST
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
 Demosthenes - 07-13-05 04:12 
----------------------------------------------------------------------
I tried playing a wav and toggling every pin from 0-22 (except 8,9,10) high
and low but I didnt notice anything whilst doing so, should I have?  What
is the effect of the external amp?  The external amp is always reported as
on in alsamixer, I dont know if this is of any relevance.

----------------------------------------------------------------------
 ungod - 07-13-05 04:24 
----------------------------------------------------------------------
The gpio tool works behind the back of the driver, so the driver probably
won't recognize any change. I don't know exactly what effect the external
amp have on the LT model, but on the ordinary version it is quite a
significant increase of sound volume.

If you have Windows installed, you could check the differences.

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
07-01-05 14:25 baesyspem      Note Added: 0005333                          
07-01-05 16:09 baesyspem      Note Added: 0005335                          
07-01-05 20:41 ungod          File Added: aureon-prodigy71lt-fix2.diff          
         
07-01-05 20:43 ungod          Note Added: 0005339                          
07-01-05 22:08 Demosthenes    Note Added: 0005341                          
07-01-05 22:46 ungod          Note Added: 0005342                          
07-01-05 23:09 Demosthenes    Note Added: 0005344                          
07-01-05 23:10 Demosthenes    Note Edited: 0005344                         
07-02-05 00:31 Demosthenes    Note Edited: 0005344                         
07-02-05 03:29 ungod          Note Added: 0005350                          
07-02-05 03:30 ungod          File Added: prodigytest.tar.gz                    
07-02-05 03:37 ungod          Note Edited: 0005350                         
07-02-05 16:50 Demosthenes    Note Added: 0005353                          
07-02-05 18:10 Demosthenes    Note Edited: 0005344                         
07-02-05 18:27 ungod          Note Added: 0005354                          
07-02-05 18:36 Demosthenes    Note Added: 0005355                          
07-02-05 20:20 ungod          Note Added: 0005358                          
07-02-05 20:59 Demosthenes    Note Added: 0005359                          
07-02-05 21:43 ungod          File Added: peak.tar.gz                      
07-02-05 21:44 ungod          Note Added: 0005360                          
07-02-05 22:30 Demosthenes    Note Added: 0005362                          
07-03-05 00:21 ungod          Note Added: 0005363                          
07-03-05 01:49 Demosthenes    Note Added: 0005364                          
07-03-05 01:55 ungod          Note Added: 0005365                          
07-03-05 02:46 Demosthenes    Note Added: 0005366                          
07-03-05 02:47 Demosthenes    Note Edited: 0005366                         
07-03-05 03:18 Demosthenes    Note Added: 0005367                          
07-03-05 03:21 Demosthenes    Note Edited: 0005367                         
07-03-05 11:35 ungod          File Added: aureon-prodigy71lt-fix3.diff          
         
07-03-05 11:47 ungod          Note Added: 0005373                          
07-03-05 15:29 Demosthenes    Note Added: 0005377                          
07-03-05 17:06 ungod          Note Added: 0005379                          
07-04-05 14:34 miljan         Issue Monitored: miljan                      
07-04-05 14:35 miljan         Issue End Monitor: miljan                    
07-04-05 14:35 miljan         Issue Monitored: miljan                      
07-06-05 19:19 Demosthenes    Note Added: 0005392                          
07-08-05 22:52 ungod          Note Added: 0005437                          
07-13-05 03:57 ungod          Note Added: 0005457                          
07-13-05 03:58 ungod          File Added: gpio.tar.gz                      
07-13-05 04:12 Demosthenes    Note Added: 0005458                          
07-13-05 04:24 ungod          Note Added: 0005459                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
