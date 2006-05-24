From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002157]: Regression on HP dc7600 (0x103c, 0x3012)
Date: Wed, 24 May 2006 11:39:21 +0200
Message-ID: <3a915da2b892bd73fcfb44de3784779a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1677171
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 11:39:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2157> 
======================================================================
Reported By:                ondrej
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2157
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux
Kernel Version:             2.6.15-23-amd64-xen
======================================================================
Date Submitted:             05-24-2006 11:39 CEST
Last Modified:              05-24-2006 11:39 CEST
======================================================================
Summary:                    Regression on HP dc7600 (0x103c, 0x3012)
Description: 
Sound stopped working when upgraded to anything higher then 1.0.9, there
was new code to add support for HDA intel (Realtek) on HP machines.

0x3012 is almost same as 0x3013, just Headphones and Front is reversed. 
And BTW "Front" is connector on the back of machine.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 11:39 ondrej         New Issue                                    
05-24-06 11:39 ondrej         Distribution              => Ubuntu Linux    
05-24-06 11:39 ondrej         Kernel Version            => 2.6.15-23-amd64-xen
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
