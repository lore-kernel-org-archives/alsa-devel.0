From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002217]: Problems with ASUS A6Km
Date: Wed, 21 Jun 2006 22:48:52 +0200
Message-ID: <f3e3f465fe6cc5d14079a2148ea577f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B0C317C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 22:48:52 +0200 (MEST)
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
Last Modified:              06-21-2006 22:48 CEST
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
 mafm - 06-21-06 22:33 
----------------------------------------------------------------------
eNTi: are you using vanilla kernels, or from some distribution? Because all
this mess is quite strange, I never got it working. The combinations that
I tested are 2.6.16.8, 2.6.16.16 and 2.6.17-rc3 from Debian unstable, and
with 2.6.16.20 and 2.6.17 of vanilla kernels (the vanilla kernels with and
without the patch, I tested all combinations).

And which BIOS version are you using? I'm using the last one, from
A6KM210AS.zip, and I can't get the USB mouse working properly (some people
said that it was working with this one, but I never got this to work
either...), that's why I have to use "acpi=ht", to not have to unplug it
while the system boots. The original BIOS version shipped was 208.

Maybe the patches that the distributions apply to their kernels packages
or the BIOS make the difference, because the kernel versions are the same,
and apparently the hardware too...

----------------------------------------------------------------------
 eNTi - 06-21-06 22:48 
----------------------------------------------------------------------
i'm currently using 209A as bios. i never actually had many problems with
usb, even though i read a lot of people do. i also use a fixed dsdt from
acpi.sourceforge.net.

my kernel versions vary from stock arch linux builds, community built to
self made. a self made vanilla+beyond patchset kernel + the patch against
ac97_patch.c made my speakers work. i don't know what it is, that changed
it to non-working again. i'm currently on 2.6.17-ck1 (community built).
maybe i'll compile another kernel tomorrow or so. i'll tell you the
outcome, even though i doubt, that it will work.

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
======================================================================



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
