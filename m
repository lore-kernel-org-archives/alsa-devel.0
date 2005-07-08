From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000911]: On board sound for ASUS P5GD2 Deluxe not detected
Date: Fri, 8 Jul 2005 10:37:35 +0200
Message-ID: <7e42f182fc388c7e11526009e08b7401@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8AF4D186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:35 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=911> 
======================================================================
Reported By:                scot
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   911
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.760_FC3smp
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-16-2005 17:08 CET
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    On board sound for ASUS P5GD2 Deluxe not detected
Description: 
Using ASUS P5GD2 Deluxe mother board that has on board Intel high
definition audio controller.  Loaded Fedora Core 3 latest updates.  On
board audio controller is not found and can not be configured.  

Using: 2.6.10-1.760_FC3smp kernel

alsa-utils-1.0.8-12.rhfc3.at
alsa-lib-devel-1.0.8-18.rhfc3.at
alsa-lib-1.0.8-18.rhfc3.at

lspci -v :

00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 03)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813d
        Flags: bus master, fast devsel, latency 0, IRQ 5
        Memory at bdffc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

 When alsaconf is run it comes back with:

No supported PnP or PCI card found.


======================================================================

----------------------------------------------------------------------
 tiwai - 02-16-05 17:15 
----------------------------------------------------------------------
You need to install alsa-driver manually.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-05 17:08 scot           New Issue                                    
02-16-05 17:08 scot           Distribution              => Fedora Core 3   
02-16-05 17:08 scot           Kernel Version            => 2.6.10-1.760_FC3smp
02-16-05 17:15 tiwai          Note Added: 0003623                          
04-13-05 21:54 jdthood        Status                   new => resolved     
04-13-05 21:54 jdthood        Resolution               open => fixed       
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
