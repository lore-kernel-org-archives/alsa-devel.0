From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000823]: Shutdown messages
Date: Sun, 16 Jan 2005 21:45:39 +0100
Message-ID: <6e89c1d7ccff64db865409a4a1ea3c9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 522532AB
	for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2005 21:45:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=823> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   823
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               FC2/PlanetCCRMA - up to date but not running newest
kernel due to other Alsa problems
Kernel Version:             2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
======================================================================
Date Submitted:             01-16-2005 21:45 CET
Last Modified:              01-16-2005 21:45 CET
======================================================================
Summary:                    Shutdown messages
Description: 
When shutting my system down I consistently get the following message:

Shutting down sound driver rme_hammerfall dsp 0:00:0f 
device was removed without properly calling pci_disable_device()
This may need fixing
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-05 21:45 Mark Knecht    New Issue                                    
01-16-05 21:45 Mark Knecht    Distribution              => FC2/PlanetCCRMA - up
to date but not running newest kernel due to other Alsa problems
01-16-05 21:45 Mark Knecht    Kernel Version            =>
2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
