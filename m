From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002217]: Problems with ASUS A6Km
Date: Sat, 24 Jun 2006 14:32:33 +0200
Message-ID: <35383dcf3c8da9a9e2f1af8f4794bdc1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26583175
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Jun 2006 14:32:34 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2217> 
======================================================================
Reported By:                mafm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2217
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-18-2006 05:06 CEST
Last Modified:              06-24-2006 14:32 CEST
======================================================================
Summary:                    Problems with ASUS A6Km
Description: 
I have the same problems described here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898 , but I'm
opening a new report because I can't find a way to add a comment there.

I tried that asus-a6km-fix.diff but it doesn't work, in fact it doesn't
appear to have any effect at all.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-24-06 10:30 
----------------------------------------------------------------------
According to the notebook specification

Integrated V.92 MDC Fax/Modem, with AC-Link Version. 2.1 Compliant
AC 97 s/w MODEM 

lsmod


cat /proc/asound/cards

cat /proc/asound/pcm



----------------------------------------------------------------------
 mafm - 06-24-06 14:32 
----------------------------------------------------------------------
enti:
------------------------------------------------------------------------------
$ tar xjf linux-2.6.17.tar.bz2
$ cd linux-2.6.17/
$ rgrep -i A6KM sound/pci/ac97/ac97_patch.c
$ cd sound/
$ patch -p1 < /usr/src/asus-a6km-fix.diff
$ rgrep -i A6KM .
./pci/ac97/ac97_patch.c:            /* ASUS A6KM requires EAPD */
------------------------------------------------------------------------------

So you must be using kernels with additional sets of patches, even if it's
from kernel.org -- I'm using the "official" one.  I can't tell you wheter
those additional patches make a difference or not, but that's precisely
what I'm trying to find out -- trying to isolate the problem, because I've
seen too many posts for *similar* laptop models, talking about modifying
registers of the card and enabling different switches to get it to work,
that didn't work for me anyway. This method is pretty straightforward
compared to the others, so it'll be easier to follow for people with
problems, and it will help to isolate other possible problems; but I don't
know if it works only for me, or only for my Q0012H model, or what.

If you had it working in the past with this patch, there are reasonable
chances that your problem is in fact due to the additional patches (using
ALSA 1.0.12-rcX, or some other stuff).  Also, what's your model, Q0012H
too?

Raymond: huh? What do you mean, do you get it working or not, etc?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 05:06 mafm           New Issue                                    
06-18-06 16:51 ryswic         Issue Monitored: ryswic                      
06-19-06 15:49 mafm           Issue Monitored: mafm                        
06-19-06 15:50 mafm           Note Added: 0010315                          
06-20-06 19:46 tiwai          Note Added: 0010345                          
06-20-06 20:16 mafm           Note Added: 0010354                          
06-21-06 21:37 eNTi           Note Added: 0010405                          
06-21-06 22:24 rlrevell       Note Added: 0010406                          
06-21-06 22:33 mafm           Note Added: 0010407                          
06-21-06 22:48 eNTi           Note Added: 0010408                          
06-22-06 00:10 mafm           Note Added: 0010410                          
06-23-06 15:27 mafm           Note Added: 0010451                          
06-23-06 15:55 mafm           File Added: asus-a6km-fix.diff                    
06-23-06 16:23 mafm           Note Added: 0010454                          
06-24-06 09:12 eNTi           Note Added: 0010467                          
06-24-06 10:26 Raymond        Note Added: 0010470                          
06-24-06 10:30 Raymond        Note Edited: 0010470                         
06-24-06 14:32 mafm           Note Added: 0010473                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
