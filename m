From: Paul Davis <pbd@op.net>
Subject: Re: HDSP CardBus issue - /proc/ioports /proc/iomem
Date: Fri, 24 May 2002 10:09:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205241407.QAA32578@alsa.alsa-project.org>
References: <E1795WT-0000Dc-00@satellite>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA32578
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 16:07:32 +0200
In-Reply-To: Your message of "Sat, 18 May 2002 16:49:28 +0200."
             <E1795WT-0000Dc-00@satellite>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: thomas@undata.org, Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thomas and Ico:

can you please try to boot your systems with the "pci=biosirq" command
line flag?

from my discussions with alan cox on the linux kernel mailing list, it
appears that the PCI configuration information for the card isn't
complete, and only the BIOS knows how to figure out the interrupt
number. You both had different issues - one of you had a problem with
IO memory, the other with interrupts - but I'd like to see what
difference this makes. 

as i understand it, it tells the PCI code in the kernel to use the IRQ
allocation decisions made by the BIOS (linux usually throws them away
and does its own thing; windows uses the BIOS values).

thanks.

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
