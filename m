From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001405]: Driver not working (no sound) with ATI IXP150 AC'97
Date: Fri, 9 Sep 2005 03:58:48 +0200
Message-ID: <2d13b4cbe6050766afe105c722165926@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C35C190
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 03:58:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1405> 
======================================================================
Reported By:                ganhawk
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1405
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4smp
======================================================================
Date Submitted:             09-09-2005 03:21 CEST
Last Modified:              09-09-2005 03:58 CEST
======================================================================
Summary:                    Driver not working (no sound) with ATI IXP150 AC'97
Description: 
OS is Fedora Core 4 but using ALSA driver 1.0.9rc4a. It throws "codec reset
timeout" error when the module is inserted and the sound card does not
work.

The error is from alsa-kernel/pci/atiixp.c:518

This is on a Tosiba A75 S1253 laptop with ATI IXP150 AC'97
======================================================================

----------------------------------------------------------------------
 ganhawk - 09-09-05 03:58 
----------------------------------------------------------------------
Hi,

Forgot to enter the additional information:

I tried disabling the ACPI but the result is the same.

lspci says:
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97
Audio Controller
        Subsystem: Toshiba America Info Systems: Unknown device ff01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min), Cache Line Size 08
        Interrupt: pin B routed to IRQ 177
        Region 0: Memory at e8004400 (32-bit, non-prefetchable)
[size=256]

Also when compiled with debug=detect, the driver produces the following:

ALSA alsa-kernel/pci/atiixp.c:518: atiixp: codec reset timeout
ALSA alsa-kernel/pci/atiixp.c:1383: atiixp: codec 1 not available for
audio

Please help me solve this issue or give me information regarding what to
change in the source.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 03:21 ganhawk        New Issue                                    
09-09-05 03:21 ganhawk        Distribution              => Fedora Core 4   
09-09-05 03:21 ganhawk        Kernel Version            => 2.6.11-1.1369_FC4smp
09-09-05 03:23 ganhawk        Issue Monitored: ganhawk                     
09-09-05 03:58 ganhawk        Note Added: 0006088                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
