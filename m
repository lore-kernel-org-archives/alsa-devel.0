From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000992]: no supported card
Date: Thu, 17 Mar 2005 00:51:20 +0100
Message-ID: <d4908646b9325484e24f2a05df92a7c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 12C70234
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2005 00:51:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=992> 
======================================================================
Reported By:                rav0r
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   992
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4
======================================================================
Date Submitted:             03-14-2005 21:52 CET
Last Modified:              03-17-2005 00:51 CET
======================================================================
Summary:                    no supported card
Description: 
I am not sure what model my s.card is. I only know it's ct4830 , 4.1 .Will
this model ever be supported?
======================================================================

----------------------------------------------------------------------
 mikma - 03-16-05 11:05 
----------------------------------------------------------------------
I think it's a problem with the kernel configuration. The configure script
probably didn't found support for PCI which is required by the emu10k1
driver.

----------------------------------------------------------------------
 rav0r - 03-17-05 00:51 
----------------------------------------------------------------------
"cat /proc/pci |more"
has found this:

Class 6581: Creative Labs SB Live! EMU10k1 (rev 8).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=129.Max Lat=101.
      I/O at 0xd000 [0xd01f].
  Bus  0, device   9, function  0:

So, I do not belive that is the problem. Couldn't this be a bug? This
sound card was not so known, so maybe.. Btw. My kernel is 2.4.20-8
I mean, my lan works on pci, so this should not be a problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 21:52 rav0r          New Issue                                    
03-14-05 21:52 rav0r          Kernel Version            => 2.4             
03-14-05 22:57 mikma          Note Added: 0003910                          
03-15-05 23:13 rav0r          Note Added: 0003925                          
03-16-05 11:05 mikma          Note Added: 0003935                          
03-17-05 00:51 rav0r          Note Added: 0003974                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
