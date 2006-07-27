From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002291]: AD1986A produces a high
	fequency noise
Date: Thu, 27 Jul 2006 13:02:16 +0200
Message-ID: <73dcc1c705a1afa9c4333263853eaf8a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8BCA170
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 13:02:16 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2291> 
======================================================================
Reported By:                michaeleekk
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2291
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.17-1.2145_FC5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-18-2006 07:12 CEST
Last Modified:              07-27-2006 13:02 CEST
======================================================================
Summary:                    AD1986A produces a high fequency noise
Description: 
Some noise, just like "weeeeee", produced when playing a sound files or
music files.
No exception. It always produced.
======================================================================

----------------------------------------------------------------------
 michaeleekk - 07-22-06 08:54 
----------------------------------------------------------------------
My machine ... I'm using a PC, You mean my motherboard?
My motherboard is ASUS M2NPV-VM, NVIDIA 430 Chipset.

After run the lspci -nv:
00:10.1 0403: 10de:026c (rev a2)
        Subsystem: 1043:81cb
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping

----------------------------------------------------------------------
 tiwai - 07-27-06 13:02 
----------------------------------------------------------------------
Fixed on HG.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 07:12 michaeleekk    New Issue                                    
07-18-06 07:12 michaeleekk    Kernel Version            => 2.6.17-1.2145_FC5
07-18-06 11:50 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - hda-intel
07-19-06 20:18 tiwai          Note Added: 0011095                          
07-20-06 05:07 michaeleekk    Note Added: 0011108                          
07-20-06 05:12 michaeleekk    Note Added: 0011109                          
07-20-06 06:47 tiwai          Note Added: 0011110                          
07-22-06 08:54 michaeleekk    Note Added: 0011168                          
07-27-06 13:02 tiwai          Status                   assigned => resolved
07-27-06 13:02 tiwai          Resolution               open => fixed       
07-27-06 13:02 tiwai          Note Added: 0011272                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
