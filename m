From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002311]: Still issues with audio cds
	on ICH7 in Asus A8Jm
Date: Sat, 29 Jul 2006 06:24:20 +0200
Message-ID: <56c26a826116b2a77b99fd70761cd7b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 79576185
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 06:24:20 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2311> 
======================================================================
Reported By:                bugmenot
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2311
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17
======================================================================
Date Submitted:             07-29-2006 06:24 CEST
Last Modified:              07-29-2006 06:24 CEST
======================================================================
Summary:                    Still issues with audio cds on ICH7 in Asus A8Jm
Description: 
The main issues with the ICH7 in Asus A8Jm have been fixed. However, I
still don't get any sound from audio cds. Please find the lspci output
below.

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1153
        Flags: bus master, fast devsel, latency 0, IRQ 23
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-06 06:24 bugmenot       New Issue                                    
07-29-06 06:24 bugmenot       Distribution              => Gentoo          
07-29-06 06:24 bugmenot       Kernel Version            => 2.6.17          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
