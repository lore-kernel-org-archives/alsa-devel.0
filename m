From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000604]: sound loop problem
Date: Wed, 10 Nov 2004 12:56:35 +0100
Message-ID: <d0161c63d1edb981833a55aaed5b849f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3C12823D
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 12:56:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=604> 
======================================================================
Reported By:                chomwitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   604
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               slackware10
Kernel Version:             2.6.7
======================================================================
Date Submitted:             10-26-2004 01:29 CEST
Last Modified:              11-10-2004 12:56 CET
======================================================================
Summary:                    sound loop problem
Description: 
i get a sound loop which gets correctet only 
while moving the mouse!
======================================================================

----------------------------------------------------------------------
 chomwitt - 10-28-04 02:22 
----------------------------------------------------------------------
some more information:

 this is the /proc/interrupt

0:    5757032          XT-PIC  timer
  1:       2574          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     100000          XT-PIC  ohci_hcd
  9:          4          XT-PIC  acpi
 10:       9584          XT-PIC  ohci_hcd, yenta, yenta, ATI IXP
 11:          2          XT-PIC  ehci_hcd, ohci_hcd, ohci_hcd
 12:        601          XT-PIC  i8042
 14:      16262          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0 
LOC:    5757240 
ERR:          0


lspci | grep -i audio
00:14.5 Multimedia audio controller: ATI Technologies Inc SoundMAX 
Integrated Digital Audio


(someone suggested to me to remove apic,acpi,hpet from kernel.
i did that , recompiled , but the problem remained )

----------------------------------------------------------------------
 tiwai - 11-10-04 12:56 
----------------------------------------------------------------------
This looks like a typical IRQ problem.
Try to turn off ACPI or use another pci routing option.
You can find other similar bugreport for atiixp in BTS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 01:29 chomwitt       New Issue                                    
10-26-04 01:29 chomwitt       Distribution              => slackware10     
10-26-04 01:29 chomwitt       Kernel Version            => 2.6.7           
10-27-04 21:07 chomwitt       Note Added: 0002280                          
10-28-04 02:14 chomwitt       Note Added: 0002281                          
10-28-04 02:17 chomwitt       Note Added: 0002282                          
10-28-04 02:22 chomwitt       Note Added: 0002283                          
11-10-04 12:56 tiwai          Note Added: 0002371                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
