From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000700]: IEC958 Capture and Universe support
Date: Thu, 2 Dec 2004 09:59:05 +0100
Message-ID: <90421f5ae4abc09595ecdcb0fa8df6ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0999C1C1
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2004 09:59:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=700> 
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   700
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-02-2004 09:59 CET
Last Modified:              12-02-2004 09:59 CET
======================================================================
Summary:                    IEC958 Capture and Universe support
Description: 
I had some spare time, so I thought I would continue adding features to the
aureon driver. The attached patch is the result:

Summary: IEC958 Capture mixer controls and Universe support

 * Added SPI read routine
 * Added IEC958 Capture mixer controls
 * Improved Universe support
 * Headphone Amp renamed to External Amplifier
 * Fixed GPIO bug in Prodigy code (There is no GPIO23 on ICE1724)
 
Signed-off-by: Peter Christensen <peter@developers.dk>
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-04 09:59 ungod          New Issue                                    
12-02-04 09:59 ungod          File Added: aureon-misc.diff                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
