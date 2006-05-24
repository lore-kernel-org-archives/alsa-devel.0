From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002081]: and-atiixp module does not load into kernel
Date: Wed, 24 May 2006 21:02:34 +0200
Message-ID: <618dfb869130d9f143b320f08e8491b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57EDA19A
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 21:02:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2081> 
======================================================================
Reported By:                KaszeL
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2081
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-ck6-r1
======================================================================
Date Submitted:             04-28-2006 00:07 CEST
Last Modified:              05-24-2006 21:02 CEST
======================================================================
Summary:                    and-atiixp module does not load into kernel
Description: 
On DFI Infinity RS432 kernel module snd-atiixp does not load into kernel.
After succesfoul compilation via gentoo portage/emerge i allways get
errors similar to this:

ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:458:
atiixp: codec read timeout (reg 0) 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:458:
atiixp: codec read timeout (reg 3c) 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:458:
atiixp: codec read timeout (reg 1c) 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/ac97/ac97_codec.c:1910:
AC'97 2 does not respond - RESET 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/ac97/ac97_codec.c:1919:
AC'97 2 access is not valid [0xffffffff], removing mixer. 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:1411:
atiixp: no codec available 

Here is my lspci info:
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97
Audio Controller (rev 80) 
        Subsystem: DFI Inc Unknown device 3100 
        Flags: 66MHz, slow devsel, IRQ 18 
        Memory at fe02b000 (32-bit, non-prefetchable) [size=256] 
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0
Enable

I've tried several kernel and alsa-driver versions. I've also tried to
compile alsa staticly into the kernel but this does not work either.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-03-06 11:46 
----------------------------------------------------------------------
Try acpi=off or pci=noacpi boot option at first.

----------------------------------------------------------------------
 KaszeL - 05-24-06 21:02 
----------------------------------------------------------------------
I've tried to disable ACPI completely, still no change.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-06 00:07 KaszeL         New Issue                                    
04-28-06 00:07 KaszeL         Distribution              => Gentoo          
04-28-06 00:07 KaszeL         Kernel Version            => 2.6.16-ck6-r1   
04-28-06 00:08 KaszeL         Issue Monitored: KaszeL                      
05-02-06 18:10 tiwai          Note Added: 0009567                          
05-02-06 20:25 KaszeL         Note Added: 0009577                          
05-03-06 11:46 tiwai          Note Added: 0009588                          
05-24-06 21:02 KaszeL         Note Added: 0009958                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
