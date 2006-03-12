From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001916]: NVidia CK8 and CK8S AC97 controllers only capture in mono
Date: Sun, 12 Mar 2006 02:33:52 +0100
Message-ID: <e2124fc04ff5d7cb85d630c7423d90fc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E110F13A
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 02:33:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1916> 
======================================================================
Reported By:                nenolod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1916
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.15-gentoo-r7
======================================================================
Date Submitted:             03-12-2006 02:33 CET
Last Modified:              03-12-2006 02:33 CET
======================================================================
Summary:                    NVidia CK8 and CK8S AC97 controllers only capture in
mono
Description: 
nenolod@localhost ~/audacious-devel/audacious $ cat /proc/asound/cards
0 [CK8            ]: NFORCE - NVidia CK8
                     NVidia CK8 with ALC658D at 0xea005000, irq 18
nenolod@localhost ~/audacious-devel/audacious $ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).
nenolod@localhost ~/audacious-devel/audacious $

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-06 02:33 nenolod        New Issue                                    
03-12-06 02:33 nenolod        Distribution              => Gentoo Linux 2005.1
03-12-06 02:33 nenolod        Kernel Version            => 2.6.15-gentoo-r7
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
