From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001851]: No support for C-Media
	CMI9761 chip
Date: Wed, 5 Jul 2006 23:05:12 +0200
Message-ID: <95ac23ee66b7dda21425a6273e477628@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A742259
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Jul 2006 23:05:13 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1851> 
======================================================================
Reported By:                duffymcdrew
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1851
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu
Kernel Version:             2.6.12-10-386
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             02-17-2006 04:55 CET
Last Modified:              07-05-2006 23:05 CEST
======================================================================
Summary:                    No support for C-Media CMI9761 chip
Description: 
Recently installed Ubunut onto a new machine, and the sound is not working
at all.  I have an ASUS P4V8X-MX motherboard with an onboard VIA 8237 card
/ C-Media Electronics CMI9761 chip. Finally realized that ALSA soes not
support the CMI9761 chip.  Requesting a driver for this chipset.
======================================================================

----------------------------------------------------------------------
 nouguisa - 05-02-06 22:30 
----------------------------------------------------------------------
tiwai, I don't agree with you : look inside the
/usr/src/sound/pci/ac97/ac97_patch.c source file. At the end of the file
there is specific code for the CMI9761 chip. A driver is available on the
C-media site for windows and concerning linux it redirects the user to the
alsa site ... but it seems that no detailed information concerning the
chip configuration is made available to the community from the
manufacturer.
Regards - nouguisa

----------------------------------------------------------------------
 tiwai - 05-03-06 11:42 
----------------------------------------------------------------------
It's your freedom to disagree, but you should know the difference between
AC97 codec chip and the sound controller chip.  The linux sound driver is
for the latter (in your case snd-via82xx, I suppose), and the former is
implemented as a slave controlled by the driver.

In short: CM9761 itself is supported but there is no dedicated driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 04:55 duffymcdrew    New Issue                                    
02-17-06 04:55 duffymcdrew    Distribution              => Ubuntu          
02-17-06 04:55 duffymcdrew    Kernel Version            => 2.6.12-10-386   
04-30-06 11:59 nouguisa       Note Added: 0009546                          
05-02-06 18:02 tiwai          Note Added: 0009563                          
05-02-06 22:30 nouguisa       Note Added: 0009579                          
05-03-06 11:42 tiwai          Note Added: 0009585                          
05-20-06 22:32 nouguisa       Issue Monitored: nouguisa                    
07-05-06 23:05 Adrian Bunk    Status                   assigned => closed  
07-05-06 23:05 Adrian Bunk    Resolution               open => not an issue
07-05-06 23:05 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - via82xx
07-05-06 23:05 Adrian Bunk    os_build                 3.4.4-6ubuntu8 =>   
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
