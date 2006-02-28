From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001344]: Acer Laptop Card not working (3002WTCi)
Date: Wed, 1 Mar 2006 00:55:35 +0100
Message-ID: <35c141efeb2fe08f256393f68ff60733@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B3E771C0
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:55:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1344> 
======================================================================
Reported By:                bqtran
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1344
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.13-rc5 (mm-sources)
======================================================================
Date Submitted:             08-17-2005 07:33 CEST
Last Modified:              03-01-2006 00:55 CET
======================================================================
Summary:                    Acer Laptop Card not working (3002WTCi)
Description: 
The module fails to load for this card. Here is some info.

lspci -v:
0000:00:01b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
         Subsystem: Acer Incorporated [ALI]: Unknown device 0067
         Flags: bus master, fast devsel, latency 0
         Memory at d000c000 (64-bit, non-prefetchable)
         Capabilities: [50] Power Management version 2
         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
         Capabilities: [70] #10 [0091]


======================================================================

----------------------------------------------------------------------
 rlrevell - 03-01-06 00:55 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 07:33 bqtran         New Issue                                    
08-17-05 07:33 bqtran         Distribution              => Gentoo          
08-17-05 07:33 bqtran         Kernel Version            => 2.6.13-rc5
(mm-sources)
08-17-05 07:38 bqtran         Issue Monitored: bqtran                      
08-23-05 16:26 bqtran         Issue End Monitor: bqtran                    
03-01-06 00:55 rlrevell       Note Added: 0008255                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
