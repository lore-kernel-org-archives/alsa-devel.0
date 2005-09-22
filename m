From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000119]: Toshiba Laptop [2455-S305] ICH4 Chipset
Date: Thu, 22 Sep 2005 15:02:10 +0200
Message-ID: <a02434f043405ffcfcb1ce7c3b58f7b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A0CC3152
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 15:02:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=119> 
======================================================================
Reported By:                haloboy
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   119
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo 2004.0 & 1.4
Kernel Version:             2.6.3
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-06-2004 08:05 CET
Last Modified:              09-22-2005 15:02 CEST
======================================================================
Summary:                    Toshiba Laptop [2455-S305] ICH4 Chipset
Description: 
I can use the 2.6.3 OSS Obselete Driver PERFECTLY except for a few skips
every few minutes and only for a fraction of a second. When I use the ALSA
Intel 8x0 driver I get now sound but the card is found since devfsd adds
the dsp device and when I use a different not correct ALSA driver for a
different card and devfsd does not add the dsp device. I also notice that
when I play sound through most applications such as esd, nasd, most artsd
my machine completely crashes. I even tried the kernel's builtin alsa
drivers and the same thing happens. I can recreate the problem everytime,
with of course a HARD reboot to resolve the crash since my entire systems
totally hangs when alsa crashes. Again OSS works fine.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-10-05 15:18 
----------------------------------------------------------------------
> When I use the ALSA Intel 8x0 driver I get now sound but the card
> is found since devfsd adds the dsp device and when I use a different
> not correct ALSA driver for a different card and devfsd does not add
> the dsp device.


This sentence makes no sense.  Can you please rephrase it?


> I also notice that when I play sound through most applications
> such as esd, nasd, most artsd my machine completely crashes.


What are the exact symptoms of this crash?  Is there an oops?

----------------------------------------------------------------------
 jdthood - 09-22-05 15:02 
----------------------------------------------------------------------
Closing, since no additional information was forthcoming.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-06-04 08:05 haloboy        New Issue                                    
03-10-05 15:18 jdthood        Note Added: 0003860                          
09-22-05 15:02 jdthood        Status                   new => resolved     
09-22-05 15:02 jdthood        Resolution               open => unable to
duplicate
09-22-05 15:02 jdthood        Assigned To               => jdthood         
09-22-05 15:02 jdthood        Note Added: 0006341                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
