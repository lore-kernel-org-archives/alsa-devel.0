From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001877]: ALSA driver not recognising nVidia MCP51 (Realtek ALC850) sound chip
Date: Sat, 25 Feb 2006 12:29:51 +0100
Message-ID: <95b59444e527c1760f1fb9ea8c880595@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B4B61BB
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2006 12:29:51 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1877> 
======================================================================
Reported By:                bobhesketh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1877
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r5
======================================================================
Date Submitted:             02-25-2006 12:29 CET
Last Modified:              02-25-2006 12:29 CET
======================================================================
Summary:                    ALSA driver not recognising nVidia MCP51 (Realtek
ALC850) sound chip
Description: 
The ASRock K8NF4G-SATA2 contains an nVidia MCP51 chipset, utilising a
Realtek
ALC850 codec sound chip. This is compatible with the intel8x0 ALSA sound
driver.
However, selecting the driver:

[Intel/Sis/nVidia/AMD/ALi AC97 Controller]

in the kernel doesn't work, and neither does the equivalent driver in the
alsa-driver package.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-06 12:29 bobhesketh     New Issue                                    
02-25-06 12:29 bobhesketh     Distribution              => Gentoo          
02-25-06 12:29 bobhesketh     Kernel Version            => 2.6.15-gentoo-r5
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
