From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001843]: regression: no sound with sigmatel stac9200, works in alsa 1.0.10
Date: Fri, 17 Mar 2006 04:55:39 +0100
Message-ID: <c96b264571d5aa969e29753c190fd71b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3BBCE199
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 04:55:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1843> 
======================================================================
Reported By:                richardfish
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1843
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             suspend2-sources-2.6.15-r6
======================================================================
Date Submitted:             02-13-2006 04:04 CET
Last Modified:              03-17-2006 04:55 CET
======================================================================
Summary:                    regression: no sound with sigmatel stac9200, works
in alsa 1.0.10
Description: 
With alsa 1.0.10, my Intel HDA with the Sigmatel STAC9200 produces sound
from both speakers and headphones (although the speakers are not muted
when the headphones are inserted, but that is a separate problem).  

With alsa 1.0.11rc3, and the CVS version as of today, no sound is produced
from either speakers or headphones.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001813 STAC9750 not recognised by hda-intel
has duplicate       0001729 Only output through headphone jack
======================================================================

----------------------------------------------------------------------
 tiwai - 03-17-06 00:39 
----------------------------------------------------------------------
The patch attached includes fixes for the auto-configuration breakage to
the latest CVS version.  Please give it a try.

----------------------------------------------------------------------
 error10 - 03-17-06 04:55 
----------------------------------------------------------------------
Just a note that the hda-autoconfig-fix.diff patch worked for me on
2.6.15-1.2054_FC5 (which is actually based on 2.6.16-rc6) on Fedora Core
5-rawhide (though I did have to massage the patch a bit) on a new Dell
Dimension E310 with the following hardware. :) :)

00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1028:01c4
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at dff3c000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-06 04:04 richardfish    New Issue                                    
02-13-06 04:04 richardfish    File Added: alsa-rjf-1.patch                    
02-13-06 04:04 richardfish    Distribution              => Gentoo          
02-13-06 04:04 richardfish    Kernel Version            =>
suspend2-sources-2.6.15-r6
02-14-06 05:43 richardfish    Issue Monitored: richardfish                    
02-20-06 22:51 lrupn          Issue Monitored: lrupn                       
02-25-06 21:40 lrupn          Note Added: 0008192                          
02-26-06 16:08 toshio         Note Added: 0008203                          
02-27-06 23:45 richardfish    Note Added: 0008233                          
03-01-06 17:07 lrupn          Note Added: 0008281                          
03-01-06 17:59 mpt            Issue Monitored: mpt                         
03-17-06 00:39 tiwai          Note Added: 0008622                          
03-17-06 00:41 tiwai          File Added: hda-autoconfig-fix.diff               
    
03-17-06 01:03 tiwai          Relationship added       has duplicate 0001813
03-17-06 01:09 tiwai          Relationship added       has duplicate 0001729
03-17-06 04:55 error10        Note Added: 0008634                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
