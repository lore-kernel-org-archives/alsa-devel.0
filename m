From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000713]: AC'97 codec issue: "AC'97 0 does not respond - RESET"
Date: Tue, 7 Dec 2004 19:43:33 +0100
Message-ID: <eefb1be2ddd93a6e5a2e09983d437ac7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D03453AE
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 19:43:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=713> 
======================================================================
Reported By:                jefke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   713
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-07-2004 19:43 CET
Last Modified:              12-07-2004 19:43 CET
======================================================================
Summary:                    AC'97 codec issue: "AC'97 0 does not respond -
RESET"
Description: 
Souncard is working fine with oss module i810_audio, but isn't using alsa
modules. Several tests have been done under 2.6.8, 2.6.9 and 2.6.10rc3
kernels, using alsa-drivers version 1.0.7, without success.

Looks like the AC97 codec can't get initialized, and is unable to read PCI
registries on the sound card (AC97_VENDOR_ID1, AC97_VENDOR_ID2).

Cf uploaded file for configuration details.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 19:43 jefke          New Issue                                    
12-07-04 19:43 jefke          File Added: alsa-bug                         
12-07-04 19:43 jefke          Distribution              => Debian sid      
12-07-04 19:43 jefke          Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
