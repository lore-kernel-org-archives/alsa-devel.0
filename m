From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000119]: Toshiba Laptop [2455-S305] ICH4 Chipset
Date: Thu, 10 Mar 2005 15:18:17 +0100
Message-ID: <d1207400b732b5f02117493ebb1b019a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 40E78157
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:18:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=119> 
======================================================================
Reported By:                haloboy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   119
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2004.0 &amp; 1.4
Kernel Version:             2.6.3
======================================================================
Date Submitted:             03-06-2004 08:05 CET
Last Modified:              03-10-2005 15:18 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-06-04 08:05 haloboy        New Issue                                    
03-10-05 15:18 jdthood        Note Added: 0003860                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
