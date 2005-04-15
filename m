From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001049]: No sound at all
Date: Fri, 15 Apr 2005 14:09:21 +0200
Message-ID: <833852fe1798dda95e19ddd157319d2b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4BB1421D
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2005 14:09:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1049> 
======================================================================
Reported By:                DF5JT
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1049
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.770_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Feb 24 14:00:06 EST
2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             04-13-2005 11:25 CEST
Last Modified:              04-15-2005 14:09 CEST
======================================================================
Summary:                    No sound at all
Description: 
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)
        Subsystem: Rioworks: Unknown device 203d
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)



======================================================================

----------------------------------------------------------------------
 stransky - 04-15-05 12:38 
----------------------------------------------------------------------
The bug is maybee in alsa-lib-stack.patch included to alsa-utils-1.0.6, in
FC3. Could you please try remove this patch from src.rpm and test it?

----------------------------------------------------------------------
 DF5JT - 04-15-05 14:09 
----------------------------------------------------------------------
Hello Martin,

I changed the SPEC file to exclude the patch and rebuilt the package.
Alas, no change after installation and restart of the soundsystem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 11:25 DF5JT          New Issue                                    
04-13-05 11:25 DF5JT          Distribution              => Fedora Core 3   
04-13-05 11:25 DF5JT          Kernel Version            => 2.6.10-1.770_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Feb 24 14:00:06 EST
2005 i686 i686 i386 GNU/Linux
04-13-05 11:25 DF5JT          Issue Monitored: DF5JT                       
04-13-05 16:34 tiwai          Note Added: 0004469                          
04-13-05 16:52 DF5JT          Note Added: 0004470                          
04-13-05 17:19 tiwai          Note Added: 0004473                          
04-15-05 12:08 DF5JT          Note Added: 0004497                          
04-15-05 12:38 stransky       Note Added: 0004498                          
04-15-05 14:09 DF5JT          Note Added: 0004499                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
