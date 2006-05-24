From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working on recent versions
Date: Wed, 24 May 2006 23:44:24 +0200
Message-ID: <6857ad5ee868ca54e17e40a895616873@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A639E179
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 23:44:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              05-24-2006 23:44 CEST
======================================================================
Summary:                    ac3 passthrough not working on recent versions
Description: 
Using the following AC3 passthrough with mplayer works:
Linux 2.4.31
alsa-driver 1.0.8-7 (debian stable packaged)

Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
kernel and
alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
stays quiet.

The only change is booting with different kernels, no other config or
hardware is touched, so this must be a driver regression.

The card is YMF-754 based, connected with coax spdif to my HK reciever.

If you need more info, just tell me and I'll dig it up.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 23:44 nikke          New Issue                                    
05-24-06 23:44 nikke          Distribution              => Debian          
05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
