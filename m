From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000943]: cmipci freezes the whole system
Date: Fri, 25 Feb 2005 21:57:46 +0100
Message-ID: <bc64637a33a382da10e23e9178414c41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A62C25D
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2005 21:57:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=943> 
======================================================================
Reported By:                aisotton
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   943
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sid (Unstable)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-25-2005 16:06 CET
Last Modified:              02-25-2005 21:57 CET
======================================================================
Summary:                    cmipci freezes the whole system
Description: 
Hi,

I have a Terratec Aureon 5.1 PCI sound card, and an on-board 3Com 3c940
gigabit ethernet controller (the board is an Asus A7V600). The sound
card uses the cmipci module, and the ethernet card the sk98lin module.

Playing sound and using the network at the same time freezes the sytem
after a short time (generally 15-30 seconds); nothing is logged or
displayed (I checked syslog, kern.log and /var/log/messages), it just
freezes everything, forcing a reset of the machine (and after the
subsequent reboot my mouse isn't recognized any more, but I don't think
that matters).

I am using that network card since more than a year, and it never gave a
problem; thus I think the bug is in the cmipci driver (the system never
froze before I installed the sound card).

I did a memtest, but my memory seems to be ok.

This happens with all kernels I tested, specifically:

Debian kernel-image-2.6.10-1-k7-4
Debian kernel-image-2.6.9-2-k7-5
Debian kernel-image-2.6.8-2-k7-13
Debian kernel-image-2.6.10-1-k7-4 with PREEMPT deactivated
Vanilla kernel 2.6.10, compiled with the same options as Debian
kernel-image-2.6.10-1-k7-4.


======================================================================

----------------------------------------------------------------------
 aisotton - 02-25-05 16:07 
----------------------------------------------------------------------
I'd be glad to help debugging the driver, I just don't know where to start
:-(

----------------------------------------------------------------------
 runderwo - 02-25-05 21:57 
----------------------------------------------------------------------
Try booting with any of the following kernel arguments: noapic, acpi=off,
pci=noacpi, pci=noapic, pci=nolapic.  Also post /proc/interrupts and lspci
-vvv

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-05 16:06 aisotton       New Issue                                    
02-25-05 16:06 aisotton       Distribution              => Debian Sid (Unstable)
02-25-05 16:06 aisotton       Kernel Version            => 2.6.10          
02-25-05 16:07 aisotton       Note Added: 0003734                          
02-25-05 21:57 runderwo       Note Added: 0003736                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
