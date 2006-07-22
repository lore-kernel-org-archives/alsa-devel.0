From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002291]: AD1986A produces a high
	fequency noise
Date: Sat, 22 Jul 2006 08:54:26 +0200
Message-ID: <7e08723d872a604227d6178031694f58@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7E7611F
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 08:54:26 +0200 (MEST)
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
Status:                     assigned
Distribution:               
Kernel Version:             2.6.17-1.2145_FC5
======================================================================
Date Submitted:             07-18-2006 07:12 CEST
Last Modified:              07-22-2006 08:54 CEST
======================================================================
Summary:                    AD1986A produces a high fequency noise
Description: 
Some noise, just like "weeeeee", produced when playing a sound files or
music files.
No exception. It always produced.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-20-06 06:47 
----------------------------------------------------------------------
Good to hear.  Then please inform the name of your machine (product name of
laptop, mobo or whatever), together with the output of "lspci -nv" (only
for class 0403) so that the driver will work without extra option.

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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
