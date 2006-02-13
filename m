From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001843]: regression: no sound with sigmatel stac9200, works in alsa 1.0.10
Date: Mon, 13 Feb 2006 04:04:03 +0100
Message-ID: <1e2d32b94cf0f25dcc4844283460e45f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B64361CA
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 04:04:03 +0100 (MET)
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
Last Modified:              02-13-2006 04:04 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-06 04:04 richardfish    New Issue                                    
02-13-06 04:04 richardfish    File Added: alsa-rjf-1.patch                    
02-13-06 04:04 richardfish    Distribution              => Gentoo          
02-13-06 04:04 richardfish    Kernel Version            =>
suspend2-sources-2.6.15-r6
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
