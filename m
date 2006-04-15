From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002021]: No sound from speakers (only headphone) after resume to suspend-to-ram
Date: Sat, 15 Apr 2006 13:19:02 +0200
Message-ID: <72e3546e60ce03b3be369f1b5aef8f1a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8259F165
	for <alsa-devel@alsa-project.org>; Sat, 15 Apr 2006 13:19:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2021> 
======================================================================
Reported By:                tsaiming
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2021
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             suspend2-2.6.16-r2
======================================================================
Date Submitted:             04-15-2006 13:19 CEST
Last Modified:              04-15-2006 13:19 CEST
======================================================================
Summary:                    No sound from speakers (only headphone) after resume
to suspend-to-ram
Description: 
After suspend2-to-ram (but it happens also with the suspend kernel built
in) I have no more sound from speakers but only from headphones.
With suspend to disk all works good 
Also tried to stop alsasound and unload modules before suspending and
restart service after resume with no change.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-06 13:19 tsaiming       New Issue                                    
04-15-06 13:19 tsaiming       File Added: codec97#0.txt                    
04-15-06 13:19 tsaiming       Distribution              => Gentoo          
04-15-06 13:19 tsaiming       Kernel Version            => suspend2-2.6.16-r2
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
